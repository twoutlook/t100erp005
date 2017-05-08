#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt620.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-11-30 17:35:11), PR版次:0005(2017-01-06 14:40:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt620
#+ Description: 期別費用預算維護
#+ Creator....: 02599(2016-11-28 22:00:13)
#+ Modifier...: 02599 -SD/PR- 05016
 
{</section>}
 
{<section id="abgt620.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161215-00014#3  2016/12/15 By 02599    报错信息修改
#161220-00036#1  2016/12/20 By 02599    抓取第二单身的金额时，初始化变量
#                                       画面单身中去除汇率，汇率按照年度+期别抓取
#170103-00013#1  2017/01/03 By 02599    取每期汇率时，日期抓取预算周期表中当期最大日期
#170104-00017#1  2017/01/06 By 05016    bgfb005 SCC更改只取費用
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_bgfb_m        RECORD
       bgfb002 LIKE bgfb_t.bgfb002, 
   bgfb002_desc LIKE type_t.chr80, 
   bgfb003 LIKE bgfb_t.bgfb003, 
   bgfb004 LIKE bgfb_t.bgfb004, 
   bgfb004_desc LIKE type_t.chr80, 
   bgaa002 LIKE type_t.chr10, 
   bgaa003 LIKE type_t.chr10, 
   bgfb011 LIKE bgfb_t.bgfb011, 
   bgfb001 LIKE bgfb_t.bgfb001, 
   bgfb005 LIKE bgfb_t.bgfb005, 
   bgfb006 LIKE bgfb_t.bgfb006, 
   bgfb010 LIKE bgfb_t.bgfb010, 
   bgfbstus LIKE bgfb_t.bgfbstus, 
   bgfb007 LIKE bgfb_t.bgfb007, 
   bgfb007_desc_t LIKE type_t.chr80, 
   bgfb013 LIKE bgfb_t.bgfb013, 
   bgfb013_desc_t LIKE type_t.chr80, 
   bgfb016 LIKE bgfb_t.bgfb016, 
   bgfb016_desc_t LIKE type_t.chr80, 
   bgfb019 LIKE bgfb_t.bgfb019, 
   bgfb019_desc_t LIKE type_t.chr80, 
   bgfb022 LIKE bgfb_t.bgfb022, 
   bgfb009 LIKE bgfb_t.bgfb009, 
   bgfb014 LIKE bgfb_t.bgfb014, 
   bgfb014_desc_t LIKE type_t.chr80, 
   bgfb017 LIKE bgfb_t.bgfb017, 
   bgfb017_desc_t LIKE type_t.chr80, 
   bgfb020 LIKE bgfb_t.bgfb020, 
   bgfb020_desc_t LIKE type_t.chr80, 
   bgfb023 LIKE bgfb_t.bgfb023, 
   bgfb023_desc_t LIKE type_t.chr80, 
   bgfb012 LIKE bgfb_t.bgfb012, 
   bgfb012_desc_t LIKE type_t.chr80, 
   bgfb015 LIKE bgfb_t.bgfb015, 
   bgfb015_desc_t LIKE type_t.chr80, 
   bgfb018 LIKE bgfb_t.bgfb018, 
   bgfb018_desc_t LIKE type_t.chr80, 
   bgfb021 LIKE bgfb_t.bgfb021, 
   bgfb021_desc_t LIKE type_t.chr80, 
   bgfb024 LIKE bgfb_t.bgfb024, 
   bgfb024_desc_t LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgfb_d        RECORD
       bgfbseq LIKE bgfb_t.bgfbseq, 
   bgfb010 LIKE bgfb_t.bgfb010, 
   bgfb007 LIKE bgfb_t.bgfb007, 
   bgfb007_desc LIKE type_t.chr500, 
   bgfb009 LIKE bgfb_t.bgfb009, 
   bgfb009_desc LIKE type_t.chr500, 
   bgfb012 LIKE bgfb_t.bgfb012, 
   bgfb012_desc LIKE type_t.chr500, 
   bgfb013 LIKE bgfb_t.bgfb013, 
   bgfb013_desc LIKE type_t.chr500, 
   bgfb014 LIKE bgfb_t.bgfb014, 
   bgfb014_desc LIKE type_t.chr500, 
   bgfb015 LIKE bgfb_t.bgfb015, 
   bgfb015_desc LIKE type_t.chr500, 
   bgfb016 LIKE bgfb_t.bgfb016, 
   bgfb016_desc LIKE type_t.chr500, 
   bgfb017 LIKE bgfb_t.bgfb017, 
   bgfb017_desc LIKE type_t.chr500, 
   bgfb018 LIKE bgfb_t.bgfb018, 
   bgfb018_desc LIKE type_t.chr500, 
   bgfb019 LIKE bgfb_t.bgfb019, 
   bgfb019_desc LIKE type_t.chr500, 
   bgfb020 LIKE bgfb_t.bgfb020, 
   bgfb020_desc LIKE type_t.chr500, 
   bgfb021 LIKE bgfb_t.bgfb021, 
   bgfb021_desc LIKE type_t.chr500, 
   bgfb022 LIKE bgfb_t.bgfb022, 
   bgfb023 LIKE bgfb_t.bgfb023, 
   bgfb023_desc LIKE type_t.chr500, 
   bgfb024 LIKE bgfb_t.bgfb024, 
   bgfb024_desc LIKE type_t.chr500, 
   bgfb035 LIKE bgfb_t.bgfb035, 
   bgfb036 LIKE bgfb_t.bgfb036, 
   bgfb100 LIKE bgfb_t.bgfb100, 
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
   amt13 LIKE type_t.num20_6, 
   bgfb008 LIKE bgfb_t.bgfb008, 
   bgfb047 LIKE bgfb_t.bgfb047, 
   bgfb048 LIKE bgfb_t.bgfb048
       END RECORD
PRIVATE TYPE type_g_bgfb2_d RECORD
       bgfbseq LIKE bgfb_t.bgfbseq, 
   bgfbownid LIKE bgfb_t.bgfbownid, 
   bgfbownid_desc LIKE type_t.chr500, 
   bgfbowndp LIKE bgfb_t.bgfbowndp, 
   bgfbowndp_desc LIKE type_t.chr500, 
   bgfbcrtid LIKE bgfb_t.bgfbcrtid, 
   bgfbcrtid_desc LIKE type_t.chr500, 
   bgfbcrtdp LIKE bgfb_t.bgfbcrtdp, 
   bgfbcrtdp_desc LIKE type_t.chr500, 
   bgfbcrtdt DATETIME YEAR TO SECOND, 
   bgfbmodid LIKE bgfb_t.bgfbmodid, 
   bgfbmodid_desc LIKE type_t.chr500, 
   bgfbmoddt DATETIME YEAR TO SECOND, 
   bgfbcnfid LIKE bgfb_t.bgfbcnfid, 
   bgfbcnfid_desc LIKE type_t.chr500, 
   bgfbcnfdt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_bgfb3_d RECORD
       bgfbseq LIKE bgfb_t.bgfbseq, 
   content LIKE type_t.chr500, 
   tamt1 LIKE type_t.num20_6, 
   tamt2 LIKE type_t.num20_6, 
   tamt3 LIKE type_t.num20_6, 
   tamt4 LIKE type_t.num20_6, 
   tamt5 LIKE type_t.num20_6, 
   tamt6 LIKE type_t.num20_6, 
   tamt7 LIKE type_t.num20_6, 
   tamt8 LIKE type_t.num20_6, 
   tamt9 LIKE type_t.num20_6, 
   tamt10 LIKE type_t.num20_6, 
   tamt11 LIKE type_t.num20_6, 
   tamt12 LIKE type_t.num20_6, 
   tamt13 LIKE type_t.num20_6, 
   sum LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_max_period      LIKE type_t.num5
DEFINE g_bgaw1           DYNAMIC ARRAY OF VARCHAR(1) #位置在单头+显示为 Y，否则为 N
DEFINE g_bgaw2           DYNAMIC ARRAY OF VARCHAR(1) #位置在单身+显示为 Y，否则为 N
DEFINE g_bgaa008         LIKE bgaa_t.bgaa008
DEFINE g_bgal RECORD  #預算專案維護檔
       bgalent LIKE bgal_t.bgalent, #企业编号
       bgalownid LIKE bgal_t.bgalownid, #资料所有者
       bgalowndp LIKE bgal_t.bgalowndp, #资料所有部门
       bgalcrtid LIKE bgal_t.bgalcrtid, #资料录入者
       bgalcrtdp LIKE bgal_t.bgalcrtdp, #资料录入部门
       bgalcrtdt LIKE bgal_t.bgalcrtdt, #资料创建日
       bgalmodid LIKE bgal_t.bgalmodid, #资料更改者
       bgalmoddt LIKE bgal_t.bgalmoddt, #最近更改日
       bgalstus LIKE bgal_t.bgalstus, #状态码
       bgal001 LIKE bgal_t.bgal001, #预算编号
       bgal002 LIKE bgal_t.bgal002, #预算组织
       bgal003 LIKE bgal_t.bgal003, #可用预算细项
       bgal004 LIKE bgal_t.bgal004, #预算期别
       bgal005 LIKE bgal_t.bgal005, #部门
       bgal006 LIKE bgal_t.bgal006, #利润/成本中心
       bgal007 LIKE bgal_t.bgal007, #区域
       bgal008 LIKE bgal_t.bgal008, #交易客商
       bgal009 LIKE bgal_t.bgal009, #收款客商
       bgal010 LIKE bgal_t.bgal010, #客群
       bgal011 LIKE bgal_t.bgal011, #产品类别
       bgal012 LIKE bgal_t.bgal012, #人员
       bgal013 LIKE bgal_t.bgal013, #项目编号
       bgal014 LIKE bgal_t.bgal014, #WBS
       bgal015 LIKE bgal_t.bgal015, #自由核算项一
       bgal016 LIKE bgal_t.bgal016, #自由核算项二
       bgal017 LIKE bgal_t.bgal017, #自由核算项三
       bgal018 LIKE bgal_t.bgal018, #自由核算项四
       bgal019 LIKE bgal_t.bgal019, #自由核算项五
       bgal020 LIKE bgal_t.bgal020, #自由核算项六
       bgal021 LIKE bgal_t.bgal021, #自由核算项七
       bgal022 LIKE bgal_t.bgal022, #自由核算项八
       bgal023 LIKE bgal_t.bgal023, #自由核算项九
       bgal024 LIKE bgal_t.bgal024, #自由核算项十
       bgalud001 LIKE bgal_t.bgalud001, #自定义字段(文本)001
       bgalud002 LIKE bgal_t.bgalud002, #自定义字段(文本)002
       bgalud003 LIKE bgal_t.bgalud003, #自定义字段(文本)003
       bgalud004 LIKE bgal_t.bgalud004, #自定义字段(文本)004
       bgalud005 LIKE bgal_t.bgalud005, #自定义字段(文本)005
       bgalud006 LIKE bgal_t.bgalud006, #自定义字段(文本)006
       bgalud007 LIKE bgal_t.bgalud007, #自定义字段(文本)007
       bgalud008 LIKE bgal_t.bgalud008, #自定义字段(文本)008
       bgalud009 LIKE bgal_t.bgalud009, #自定义字段(文本)009
       bgalud010 LIKE bgal_t.bgalud010, #自定义字段(文本)010
       bgalud011 LIKE bgal_t.bgalud011, #自定义字段(数字)011
       bgalud012 LIKE bgal_t.bgalud012, #自定义字段(数字)012
       bgalud013 LIKE bgal_t.bgalud013, #自定义字段(数字)013
       bgalud014 LIKE bgal_t.bgalud014, #自定义字段(数字)014
       bgalud015 LIKE bgal_t.bgalud015, #自定义字段(数字)015
       bgalud016 LIKE bgal_t.bgalud016, #自定义字段(数字)016
       bgalud017 LIKE bgal_t.bgalud017, #自定义字段(数字)017
       bgalud018 LIKE bgal_t.bgalud018, #自定义字段(数字)018
       bgalud019 LIKE bgal_t.bgalud019, #自定义字段(数字)019
       bgalud020 LIKE bgal_t.bgalud020, #自定义字段(数字)020
       bgalud021 LIKE bgal_t.bgalud021, #自定义字段(日期时间)021
       bgalud022 LIKE bgal_t.bgalud022, #自定义字段(日期时间)022
       bgalud023 LIKE bgal_t.bgalud023, #自定义字段(日期时间)023
       bgalud024 LIKE bgal_t.bgalud024, #自定义字段(日期时间)024
       bgalud025 LIKE bgal_t.bgalud025, #自定义字段(日期时间)025
       bgalud026 LIKE bgal_t.bgalud026, #自定义字段(日期时间)026
       bgalud027 LIKE bgal_t.bgalud027, #自定义字段(日期时间)027
       bgalud028 LIKE bgal_t.bgalud028, #自定义字段(日期时间)028
       bgalud029 LIKE bgal_t.bgalud029, #自定义字段(日期时间)029
       bgalud030 LIKE bgal_t.bgalud030, #自定义字段(日期时间)030
       bgal025 LIKE bgal_t.bgal025, #经营方式
       bgal026 LIKE bgal_t.bgal026, #渠道
       bgal027 LIKE bgal_t.bgal027  #品牌
END RECORD
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bgfb_m          type_g_bgfb_m
DEFINE g_bgfb_m_t        type_g_bgfb_m
DEFINE g_bgfb_m_o        type_g_bgfb_m
DEFINE g_bgfb_m_mask_o   type_g_bgfb_m #轉換遮罩前資料
DEFINE g_bgfb_m_mask_n   type_g_bgfb_m #轉換遮罩後資料
 
   DEFINE g_bgfb002_t LIKE bgfb_t.bgfb002
DEFINE g_bgfb003_t LIKE bgfb_t.bgfb003
DEFINE g_bgfb004_t LIKE bgfb_t.bgfb004
DEFINE g_bgfb001_t LIKE bgfb_t.bgfb001
DEFINE g_bgfb005_t LIKE bgfb_t.bgfb005
DEFINE g_bgfb006_t LIKE bgfb_t.bgfb006
DEFINE g_bgfb010_t LIKE bgfb_t.bgfb010
DEFINE g_bgfb007_t LIKE bgfb_t.bgfb007
DEFINE g_bgfb009_t LIKE bgfb_t.bgfb009
 
 
DEFINE g_bgfb_d          DYNAMIC ARRAY OF type_g_bgfb_d
DEFINE g_bgfb_d_t        type_g_bgfb_d
DEFINE g_bgfb_d_o        type_g_bgfb_d
DEFINE g_bgfb_d_mask_o   DYNAMIC ARRAY OF type_g_bgfb_d #轉換遮罩前資料
DEFINE g_bgfb_d_mask_n   DYNAMIC ARRAY OF type_g_bgfb_d #轉換遮罩後資料
DEFINE g_bgfb2_d   DYNAMIC ARRAY OF type_g_bgfb2_d
DEFINE g_bgfb2_d_t type_g_bgfb2_d
DEFINE g_bgfb2_d_o type_g_bgfb2_d
DEFINE g_bgfb2_d_mask_o   DYNAMIC ARRAY OF type_g_bgfb2_d #轉換遮罩前資料
DEFINE g_bgfb2_d_mask_n   DYNAMIC ARRAY OF type_g_bgfb2_d #轉換遮罩後資料
DEFINE g_bgfb3_d   DYNAMIC ARRAY OF type_g_bgfb3_d
DEFINE g_bgfb3_d_t type_g_bgfb3_d
DEFINE g_bgfb3_d_o type_g_bgfb3_d
DEFINE g_bgfb3_d_mask_o   DYNAMIC ARRAY OF type_g_bgfb3_d #轉換遮罩前資料
DEFINE g_bgfb3_d_mask_n   DYNAMIC ARRAY OF type_g_bgfb3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bgfb001 LIKE bgfb_t.bgfb001,
      b_bgfb002 LIKE bgfb_t.bgfb002,
      b_bgfb003 LIKE bgfb_t.bgfb003,
      b_bgfb004 LIKE bgfb_t.bgfb004,
      b_bgfb005 LIKE bgfb_t.bgfb005,
      b_bgfb006 LIKE bgfb_t.bgfb006,
      b_bgfb007 LIKE bgfb_t.bgfb007,
      b_bgfb009 LIKE bgfb_t.bgfb009,
      b_bgfb010 LIKE bgfb_t.bgfb010
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgt620.main" >}
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
   CALL s_abgt620_create_head_tmp()
   
   #单头锁资料重写，在fetch段定义
   IF 1=2 THEN
   #end add-point
   LET g_forupd_sql = " SELECT bgfb002,'',bgfb003,bgfb004,'','','',bgfb011,bgfb001,bgfb005,bgfb006,bgfb010, 
       bgfbstus,bgfb007,'',bgfb013,'',bgfb016,'',bgfb019,'',bgfb022,bgfb009,bgfb014,'',bgfb017,'',bgfb020, 
       '',bgfb023,'',bgfb012,'',bgfb015,'',bgfb018,'',bgfb021,'',bgfb024,''", 
                      " FROM bgfb_t",
                      " WHERE bgfbent= ? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND  
                          bgfb005=? AND bgfb006=? AND bgfb007=? AND bgfb009=? AND bgfb010=? FOR UPDATE" 
 
   #add-point:SQL_define name="main.after_define_sql"
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt620_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgfb002,t0.bgfb003,t0.bgfb004,t0.bgfb011,t0.bgfb001,t0.bgfb005,t0.bgfb006, 
       t0.bgfb010,t0.bgfbstus,t0.bgfb007,t0.bgfb013,t0.bgfb016,t0.bgfb019,t0.bgfb022,t0.bgfb009,t0.bgfb014, 
       t0.bgfb017,t0.bgfb020,t0.bgfb023,t0.bgfb012,t0.bgfb015,t0.bgfb018,t0.bgfb021,t0.bgfb024,t1.bgaal003 , 
       t2.bgail004",
               " FROM bgfb_t t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bgfb002 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN bgail_t t2 ON t2.bgailent="||g_enterprise||" AND t2.bgail001=t0.bgfb002 AND t2.bgail002=t0.bgfb004 AND t2.bgail003='"||g_dlang||"' ",
 
               " WHERE t0.bgfbent = " ||g_enterprise|| " AND t0.bgfb001 = ? AND t0.bgfb002 = ? AND t0.bgfb003 = ? AND t0.bgfb004 = ? AND t0.bgfb005 = ? AND t0.bgfb006 = ? AND t0.bgfb007 = ? AND t0.bgfb009 = ? AND t0.bgfb010 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   END IF
   #重寫抓取單頭資料SQL，資料改抓取單頭臨時表
   LET g_sql = " SELECT DISTINCT t0.bgfb002,t0.bgfb003,t0.bgfb004,t0.bgfb011,t0.bgfb001,t0.bgfb005,t0.bgfb006, 
       t0.bgfb010,t0.bgfbstus,t0.bgfb007,t0.bgfb013,t0.bgfb016,t0.bgfb019,t0.bgfb022,t0.bgfb009,t0.bgfb014,
       t0.bgfb017, t0.bgfb020,t0.bgfb023,t0.bgfb012,t0.bgfb015,t0.bgfb018,t0.bgfb021,t0.bgfb024,t1.bgaal003 ,
       t2.bgail004", 
               " FROM s_abgt620_tmp t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bgfb002 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN bgail_t t2 ON t2.bgailent="||g_enterprise||" AND t2.bgail001=t0.bgfb002 AND t2.bgail002=t0.bgfb004 AND t2.bgail003='"||g_dlang||"' ",
 
               " WHERE t0.bgfbent = " ||g_enterprise|| " AND t0.bgfb001 = ? AND t0.bgfb002 = ? AND t0.bgfb003 = ? AND t0.bgfb004 = ? AND t0.bgfb005 = ? AND t0.bgfb006 = ? AND t0.bgfb007 = ? AND t0.bgfb009 = ? AND t0.bgfb010 = ?"
   #end add-point
   PREPARE abgt620_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt620 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt620_init()   
 
      #進入選單 Menu (="N")
      CALL abgt620_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt620
      
   END IF 
   
   CLOSE abgt620_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_abgt620_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt620.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt620_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('bgfbstus','13','N,Y,FC,A,D,R,W,X')
 
      CALL cl_set_combo_scc('bgfb005','9418') 
   CALL cl_set_combo_scc('bgfb006','9989') 
   CALL cl_set_combo_scc('bgfb022','6013') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
#   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc_part('bgfb005','9418','1,2,3,4,5')   #170104-00017#1
   CALL cl_set_combo_scc('bgfb022_2','6013')
   #end add-point
   
   CALL abgt620_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt620.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt620_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success             LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL cl_set_act_visible("open_abgt620_01_s", FALSE)
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bgfb_m.* TO NULL
         CALL g_bgfb_d.clear()
         CALL g_bgfb2_d.clear()
         CALL g_bgfb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt620_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_bgfb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgt620_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgt620_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               #根据单身一的资料动态显示对应调整资料
               CALL abgt620_b_fill2(l_ac)
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
                              #此段落i02,i07樣板使用, 但目前不支援批次修改狀態, 先註解
			   ##此段落由子樣板a22產生
               ##目前選取的stus為N
               #IF . = "N" THEN
               #                     CALL cl_set_act_visible('unconfirmed',FALSE)
                  CALL cl_set_act_visible('confirmed',TRUE)
                  CALL cl_set_act_visible('final_confirmed',TRUE)
                  CALL cl_set_act_visible('approved',TRUE)
                  CALL cl_set_act_visible('withdraw',TRUE)
                  CALL cl_set_act_visible('rejection',TRUE)
                  CALL cl_set_act_visible('signing',TRUE)
                  CALL cl_set_act_visible('invalid',TRUE)
 
               #END IF
               ##stus - Start - 
               ##目前選取的stus為}
               #IF . = "}" THEN
               #   }
               #END IF        
               ##stus -  End  -               
    
 
 
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_bgfb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt620_idx_chk()
               CALL abgt620_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               #根据单身一的资料动态显示对应调整资料
               CALL abgt620_b_fill2(l_ac)
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_bgfb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt620_idx_chk()
               CALL abgt620_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 3
            
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL abgt620_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL abgt620_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt620_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abgt620_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abgt620_set_act_visible()   
            CALL abgt620_set_act_no_visible()
            IF NOT (g_bgfb_m.bgfb001 IS NULL
                 OR g_bgfb_m.bgfb002 IS NULL
                 OR g_bgfb_m.bgfb003 IS NULL
                 OR g_bgfb_m.bgfb004 IS NULL
                 OR g_bgfb_m.bgfb005 IS NULL
                 OR g_bgfb_m.bgfb006 IS NULL
                 OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 IS NULL)
                 OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 IS NULL)
            
              ) THEN
               #組合條件
               LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                                  " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                                 ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                                 ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                                 ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                                 ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                                 ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
                                 ," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
                                 ," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
            
               #填到對應位置
               CALL abgt620_browser_fill("")
            END IF
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt620_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt620_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt620_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt620_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt620_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_bgfb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgfb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_bgfb3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
                CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD bgfb008
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL abgt620_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgt620_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgt620_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt620_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt620_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_01
            LET g_action_choice="open_abgt340_01"
            IF cl_auth_chk_act("open_abgt340_01") THEN
               
               #add-point:ON ACTION open_abgt340_01 name="menu.open_abgt340_01"
               #本层调整
               CALL abgt620_adjust(1)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_02
            LET g_action_choice="open_abgt340_02"
            IF cl_auth_chk_act("open_abgt340_02") THEN
               
               #add-point:ON ACTION open_abgt340_02 name="menu.open_abgt340_02"
               IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) AND
                  NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) AND 
                  NOT cl_null(g_bgfb_m.bgfb011) THEN
                  CALL abgt340_02(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                  g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb011)
                  RETURNING l_success
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt620_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt620_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/abg/abgt620_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/abg/abgt620_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgt620_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgp610
            LET g_action_choice="open_abgp610"
            IF cl_auth_chk_act("open_abgp610") THEN
               
               #add-point:ON ACTION open_abgp610 name="menu.open_abgp610"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt620_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_01_s
            LET g_action_choice="open_abgt340_01_s"
            IF cl_auth_chk_act("open_abgt340_01_s") THEN
               
               #add-point:ON ACTION open_abgt340_01_s name="menu.open_abgt340_01_s"
               #上层调整
               CALL abgt620_adjust(2)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt620_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt620_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt620_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
         CONTINUE DIALOG
            
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgt620_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt620_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ooef001_str     STRING
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #产生单头临时表资料
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc = " bgfb001='20' AND ",g_wc," AND ",g_wc2
   
   #檢查預算組織是否在abgi090中可操作的組織中
   CALL s_abg2_get_budget_site('','',g_user,'04') RETURNING l_ooef001_str
   CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
   LET l_wc = l_wc," AND bgfb007 IN ",l_ooef001_str
   #抓取有权限的管理组织
   LET l_wc=l_wc," AND bgfb004 IN (SELECT DISTINCT bgai002 FROM bgai_t ",
                 "                  WHERE bgaient=",g_enterprise," AND bgaistus='Y' ",
                 "                    AND bgai003='",g_user,"'",
                 "                    AND (bgai005='00' OR bgai005='04') ",
                 "                 )"
            
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                         " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                        ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                        ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                        ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                        ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                        ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
      IF g_bgaw1[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
      END IF
      IF g_bgaw2[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
      END IF
   END IF
      
   CALL s_abgt620_create_head(l_wc,g_add_browse)
   #end add-point    
 
   LET l_searchcol = "bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb009,bgfb010"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT bgfb001 ",
                      ", bgfb002 ",
                      ", bgfb003 ",
                      ", bgfb004 ",
                      ", bgfb005 ",
                      ", bgfb006 ",
                      ", bgfb007 ",
                      ", bgfb009 ",
                      ", bgfb010 ",
 
                      " FROM bgfb_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bgfbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgfb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgfb001 ",
                      ", bgfb002 ",
                      ", bgfb003 ",
                      ", bgfb004 ",
                      ", bgfb005 ",
                      ", bgfb006 ",
                      ", bgfb007 ",
                      ", bgfb009 ",
                      ", bgfb010 ",
 
                      " FROM bgfb_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bgfbent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgfb_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #重写l_sub_sql 和 g_sql 语句，抓取资料来源改为单头临时表
   LET l_sub_sql = " SELECT DISTINCT bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb009,bgfb010 ",
                   "   FROM s_abgt620_tmp ",
                   " WHERE bgfbent = ",g_enterprise
                   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_bgfb_m.* TO NULL
      CALL g_bgfb_d.clear()        
      CALL g_bgfb2_d.clear() 
      CALL g_bgfb3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgfb001,t0.bgfb002,t0.bgfb003,t0.bgfb004,t0.bgfb005,t0.bgfb006,t0.bgfb007,t0.bgfb009,t0.bgfb010 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bgfb001,t0.bgfb002,t0.bgfb003,t0.bgfb004,t0.bgfb005,t0.bgfb006,t0.bgfb007, 
       t0.bgfb009,t0.bgfb010",
                " FROM bgfb_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bgfbent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bgfb_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #組合條件
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                         " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                        ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                        ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                        ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                        ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                        ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
      IF g_bgaw1[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
      END IF
      IF g_bgaw2[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
      END IF
      LET l_wc  = g_add_browse
   ELSE
      LET l_wc  = ' 1=1'
   END IF
   #重写g_sql 语句，抓取资料来源改为单头临时表
   LET g_sql  = "SELECT DISTINCT bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb009,bgfb010 ",
                " FROM s_abgt620_tmp ",
                " WHERE bgfbent = " ||g_enterprise|| " AND ", l_wc
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgfb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bgfb001,g_browser[g_cnt].b_bgfb002,g_browser[g_cnt].b_bgfb003, 
          g_browser[g_cnt].b_bgfb004,g_browser[g_cnt].b_bgfb005,g_browser[g_cnt].b_bgfb006,g_browser[g_cnt].b_bgfb007, 
          g_browser[g_cnt].b_bgfb009,g_browser[g_cnt].b_bgfb010 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point  
      
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
      END FOREACH
      FREE browse_pre
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_bgfb001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bgfb_m.* TO NULL
      CALL g_bgfb_d.clear()
      CALL g_bgfb2_d.clear()
      CALL g_bgfb3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgt620_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   #由于statechange是画面中手动画上的，不是r.a产生的，此处需要添加
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange", FALSE)
   END IF
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt620_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
 
   #end add-point
   
   LET g_bgfb_m.bgfb001 = g_browser[g_current_idx].b_bgfb001   
   LET g_bgfb_m.bgfb002 = g_browser[g_current_idx].b_bgfb002   
   LET g_bgfb_m.bgfb003 = g_browser[g_current_idx].b_bgfb003   
   LET g_bgfb_m.bgfb004 = g_browser[g_current_idx].b_bgfb004   
   LET g_bgfb_m.bgfb005 = g_browser[g_current_idx].b_bgfb005   
   LET g_bgfb_m.bgfb006 = g_browser[g_current_idx].b_bgfb006   
   LET g_bgfb_m.bgfb007 = g_browser[g_current_idx].b_bgfb007   
   LET g_bgfb_m.bgfb009 = g_browser[g_current_idx].b_bgfb009   
   LET g_bgfb_m.bgfb010 = g_browser[g_current_idx].b_bgfb010   
 
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010 INTO g_bgfb_m.bgfb002, 
       g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023, 
       g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb002_desc, 
       g_bgfb_m.bgfb004_desc
   CALL abgt620_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt620_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt620_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_bgfb001 = g_bgfb_m.bgfb001 
         AND g_browser[l_i].b_bgfb002 = g_bgfb_m.bgfb002 
         AND g_browser[l_i].b_bgfb003 = g_bgfb_m.bgfb003 
         AND g_browser[l_i].b_bgfb004 = g_bgfb_m.bgfb004 
         AND g_browser[l_i].b_bgfb005 = g_bgfb_m.bgfb005 
         AND g_browser[l_i].b_bgfb006 = g_bgfb_m.bgfb006 
         AND g_browser[l_i].b_bgfb007 = g_bgfb_m.bgfb007 
         AND g_browser[l_i].b_bgfb009 = g_bgfb_m.bgfb009 
         AND g_browser[l_i].b_bgfb010 = g_bgfb_m.bgfb010 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt620_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002
   DEFINE l_ooef001_str   STRING
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_bgfb_m.* TO NULL
   CALL g_bgfb_d.clear()
   CALL g_bgfb2_d.clear()
   CALL g_bgfb3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   CALL cl_set_comp_visible("bgfb007,bgfb007_desc_t,bgfb009,bgfb013,bgfb013_desc_t,bgfb014,bgfb014_desc_t,bgfb015,bgfb015_desc_t,bgfb016,bgfb016_desc_t,bgfb017,bgfb017_desc_t,group_1",TRUE)
   CALL cl_set_comp_visible("bgfb018,bgfb018_desc_t,bgfb019,bgfb019_desc_t,bgfb022,bgfb023,bgfb023_desc_t,bgfb024,bgfb024_desc_t,bgfb012,bgfb012_desc_t,bgfb020,bgfb020_desc_t,bgfb021,bgfb021_desc_t",TRUE)
   
   CALL cl_set_comp_visible("bgfb007_desc,bgfb009_desc,bgfb013_desc,bgfb014_desc,bgfb015_desc,bgfb016_desc,bgfb017_desc",TRUE)
   CALL cl_set_comp_visible("bgfb018_desc,bgfb019_desc,bgfb022_2,bgfb023_desc,bgfb024_desc,bgfb012_desc,bgfb020_desc,bgfb021_desc",TRUE)
      
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgfb002,bgfb003,bgfb004,bgfb011,bgfb001,bgfb005,bgfb006,bgfb010,bgfbstus, 
          bgfb007,bgfb013,bgfb016,bgfb019,bgfb022,bgfb009,bgfb014,bgfb017,bgfb020,bgfb023,bgfb012,bgfb015, 
          bgfb018,bgfb021,bgfb024
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.bgfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb002
            #add-point:ON ACTION controlp INFIELD bgfb002 name="construct.c.bgfb002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus='Y' AND bgaa006 = '1' "
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb002  #顯示到畫面上
            NEXT FIELD bgfb002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb002
            #add-point:BEFORE FIELD bgfb002 name="construct.b.bgfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb002
            
            #add-point:AFTER FIELD bgfb002 name="construct.a.bgfb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb003
            #add-point:BEFORE FIELD bgfb003 name="construct.b.bgfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb003
            
            #add-point:AFTER FIELD bgfb003 name="construct.a.bgfb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb003
            #add-point:ON ACTION controlp INFIELD bgfb003 name="construct.c.bgfb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgfb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb004
            #add-point:ON ACTION controlp INFIELD bgfb004 name="construct.c.bgfb004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='04' OR bgai005='00')" 
            CALL q_bgai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb004  #顯示到畫面上
            NEXT FIELD bgfb004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb004
            #add-point:BEFORE FIELD bgfb004 name="construct.b.bgfb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb004
            
            #add-point:AFTER FIELD bgfb004 name="construct.a.bgfb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb011
            #add-point:ON ACTION controlp INFIELD bgfb011 name="construct.c.bgfb011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgaw001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb011  #顯示到畫面上
            NEXT FIELD bgfb011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb011
            #add-point:BEFORE FIELD bgfb011 name="construct.b.bgfb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb011
            
            #add-point:AFTER FIELD bgfb011 name="construct.a.bgfb011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb001
            #add-point:BEFORE FIELD bgfb001 name="construct.b.bgfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb001
            
            #add-point:AFTER FIELD bgfb001 name="construct.a.bgfb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb001
            #add-point:ON ACTION controlp INFIELD bgfb001 name="construct.c.bgfb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb005
            #add-point:BEFORE FIELD bgfb005 name="construct.b.bgfb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb005
            
            #add-point:AFTER FIELD bgfb005 name="construct.a.bgfb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb005
            #add-point:ON ACTION controlp INFIELD bgfb005 name="construct.c.bgfb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb006
            #add-point:BEFORE FIELD bgfb006 name="construct.b.bgfb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb006
            
            #add-point:AFTER FIELD bgfb006 name="construct.a.bgfb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb006
            #add-point:ON ACTION controlp INFIELD bgfb006 name="construct.c.bgfb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb010
            #add-point:BEFORE FIELD bgfb010 name="construct.b.bgfb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb010
            
            #add-point:AFTER FIELD bgfb010 name="construct.a.bgfb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb010
            #add-point:ON ACTION controlp INFIELD bgfb010 name="construct.c.bgfb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbstus
            #add-point:BEFORE FIELD bgfbstus name="construct.b.bgfbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbstus
            
            #add-point:AFTER FIELD bgfbstus name="construct.a.bgfbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbstus
            #add-point:ON ACTION controlp INFIELD bgfbstus name="construct.c.bgfbstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgfb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007
            #add-point:ON ACTION controlp INFIELD bgfb007 name="construct.c.bgfb007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'04') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb007  #顯示到畫面上
            NEXT FIELD bgfb007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007
            #add-point:BEFORE FIELD bgfb007 name="construct.b.bgfb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007
            
            #add-point:AFTER FIELD bgfb007 name="construct.a.bgfb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb013
            #add-point:ON ACTION controlp INFIELD bgfb013 name="construct.c.bgfb013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb013  #顯示到畫面上
            NEXT FIELD bgfb013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb013
            #add-point:BEFORE FIELD bgfb013 name="construct.b.bgfb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb013
            
            #add-point:AFTER FIELD bgfb013 name="construct.a.bgfb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb016
            #add-point:ON ACTION controlp INFIELD bgfb016 name="construct.c.bgfb016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb016  #顯示到畫面上
            NEXT FIELD bgfb016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb016
            #add-point:BEFORE FIELD bgfb016 name="construct.b.bgfb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb016
            
            #add-point:AFTER FIELD bgfb016 name="construct.a.bgfb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb019
            #add-point:ON ACTION controlp INFIELD bgfb019 name="construct.c.bgfb019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb019  #顯示到畫面上
            NEXT FIELD bgfb019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb019
            #add-point:BEFORE FIELD bgfb019 name="construct.b.bgfb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb019
            
            #add-point:AFTER FIELD bgfb019 name="construct.a.bgfb019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb022
            #add-point:BEFORE FIELD bgfb022 name="construct.b.bgfb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb022
            
            #add-point:AFTER FIELD bgfb022 name="construct.a.bgfb022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb022
            #add-point:ON ACTION controlp INFIELD bgfb022 name="construct.c.bgfb022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgfb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb009
            #add-point:ON ACTION controlp INFIELD bgfb009 name="construct.c.bgfb009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaestus = 'Y' "
            CALL q_bgae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb009  #顯示到畫面上
            NEXT FIELD bgfb009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb009
            #add-point:BEFORE FIELD bgfb009 name="construct.b.bgfb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb009
            
            #add-point:AFTER FIELD bgfb009 name="construct.a.bgfb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb014
            #add-point:ON ACTION controlp INFIELD bgfb014 name="construct.c.bgfb014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb014  #顯示到畫面上
            NEXT FIELD bgfb014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb014
            #add-point:BEFORE FIELD bgfb014 name="construct.b.bgfb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb014
            
            #add-point:AFTER FIELD bgfb014 name="construct.a.bgfb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb017
            #add-point:ON ACTION controlp INFIELD bgfb017 name="construct.c.bgfb017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb017  #顯示到畫面上
            NEXT FIELD bgfb017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb017
            #add-point:BEFORE FIELD bgfb017 name="construct.b.bgfb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb017
            
            #add-point:AFTER FIELD bgfb017 name="construct.a.bgfb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb020
            #add-point:ON ACTION controlp INFIELD bgfb020 name="construct.c.bgfb020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb020  #顯示到畫面上
            NEXT FIELD bgfb020                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb020
            #add-point:BEFORE FIELD bgfb020 name="construct.b.bgfb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb020
            
            #add-point:AFTER FIELD bgfb020 name="construct.a.bgfb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb023
            #add-point:ON ACTION controlp INFIELD bgfb023 name="construct.c.bgfb023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb023  #顯示到畫面上
            NEXT FIELD bgfb023                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb023
            #add-point:BEFORE FIELD bgfb023 name="construct.b.bgfb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb023
            
            #add-point:AFTER FIELD bgfb023 name="construct.a.bgfb023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb012
            #add-point:ON ACTION controlp INFIELD bgfb012 name="construct.c.bgfb012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb012  #顯示到畫面上
            NEXT FIELD bgfb012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb012
            #add-point:BEFORE FIELD bgfb012 name="construct.b.bgfb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb012
            
            #add-point:AFTER FIELD bgfb012 name="construct.a.bgfb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb015
            #add-point:ON ACTION controlp INFIELD bgfb015 name="construct.c.bgfb015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb015  #顯示到畫面上
            NEXT FIELD bgfb015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb015
            #add-point:BEFORE FIELD bgfb015 name="construct.b.bgfb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb015
            
            #add-point:AFTER FIELD bgfb015 name="construct.a.bgfb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb018
            #add-point:ON ACTION controlp INFIELD bgfb018 name="construct.c.bgfb018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb018  #顯示到畫面上
            NEXT FIELD bgfb018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb018
            #add-point:BEFORE FIELD bgfb018 name="construct.b.bgfb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb018
            
            #add-point:AFTER FIELD bgfb018 name="construct.a.bgfb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb021
            #add-point:ON ACTION controlp INFIELD bgfb021 name="construct.c.bgfb021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb021  #顯示到畫面上
            NEXT FIELD bgfb021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb021
            #add-point:BEFORE FIELD bgfb021 name="construct.b.bgfb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb021
            
            #add-point:AFTER FIELD bgfb021 name="construct.a.bgfb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgfb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb024
            #add-point:ON ACTION controlp INFIELD bgfb024 name="construct.c.bgfb024"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb024  #顯示到畫面上
            NEXT FIELD bgfb024                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb024
            #add-point:BEFORE FIELD bgfb024 name="construct.b.bgfb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb024
            
            #add-point:AFTER FIELD bgfb024 name="construct.a.bgfb024"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bgfbseq,bgfb010_2,bgfb007_2,bgfb007_desc,bgfb009_2,bgfb009_desc,bgfb012_2, 
          bgfb012_desc,bgfb013_2,bgfb013_desc,bgfb014_2,bgfb014_desc,bgfb015_2,bgfb015_desc,bgfb016_2, 
          bgfb016_desc,bgfb017_2,bgfb017_desc,bgfb018_2,bgfb018_desc,bgfb019_2,bgfb019_desc,bgfb020_2, 
          bgfb020_desc,bgfb021_2,bgfb021_desc,bgfb022_2,bgfb023_2,bgfb023_desc,bgfb024_2,bgfb024_desc, 
          bgfb035,bgfb036,bgfb100,bgfb008,bgfb047,bgfb048,bgfbownid,bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt, 
          bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt
           FROM s_detail1[1].bgfbseq,s_detail1[1].bgfb010_2,s_detail1[1].bgfb007_2,s_detail1[1].bgfb007_desc, 
               s_detail1[1].bgfb009_2,s_detail1[1].bgfb009_desc,s_detail1[1].bgfb012_2,s_detail1[1].bgfb012_desc, 
               s_detail1[1].bgfb013_2,s_detail1[1].bgfb013_desc,s_detail1[1].bgfb014_2,s_detail1[1].bgfb014_desc, 
               s_detail1[1].bgfb015_2,s_detail1[1].bgfb015_desc,s_detail1[1].bgfb016_2,s_detail1[1].bgfb016_desc, 
               s_detail1[1].bgfb017_2,s_detail1[1].bgfb017_desc,s_detail1[1].bgfb018_2,s_detail1[1].bgfb018_desc, 
               s_detail1[1].bgfb019_2,s_detail1[1].bgfb019_desc,s_detail1[1].bgfb020_2,s_detail1[1].bgfb020_desc, 
               s_detail1[1].bgfb021_2,s_detail1[1].bgfb021_desc,s_detail1[1].bgfb022_2,s_detail1[1].bgfb023_2, 
               s_detail1[1].bgfb023_desc,s_detail1[1].bgfb024_2,s_detail1[1].bgfb024_desc,s_detail1[1].bgfb035, 
               s_detail1[1].bgfb036,s_detail1[1].bgfb100,s_detail1[1].bgfb008,s_detail1[1].bgfb047,s_detail1[1].bgfb048, 
               s_detail2[1].bgfbownid,s_detail2[1].bgfbowndp,s_detail2[1].bgfbcrtid,s_detail2[1].bgfbcrtdp, 
               s_detail2[1].bgfbcrtdt,s_detail2[1].bgfbmodid,s_detail2[1].bgfbmoddt,s_detail2[1].bgfbcnfid, 
               s_detail2[1].bgfbcnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgfbcrtdt>>----
         AFTER FIELD bgfbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgfbmoddt>>----
         AFTER FIELD bgfbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgfbcnfdt>>----
         AFTER FIELD bgfbcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgfbpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbseq
            #add-point:BEFORE FIELD bgfbseq name="construct.b.page1.bgfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbseq
            
            #add-point:AFTER FIELD bgfbseq name="construct.a.page1.bgfbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbseq
            #add-point:ON ACTION controlp INFIELD bgfbseq name="construct.c.page1.bgfbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb010_2
            #add-point:BEFORE FIELD bgfb010_2 name="construct.b.page1.bgfb010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb010_2
            
            #add-point:AFTER FIELD bgfb010_2 name="construct.a.page1.bgfb010_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb010_2
            #add-point:ON ACTION controlp INFIELD bgfb010_2 name="construct.c.page1.bgfb010_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgfb007_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007_2
            #add-point:ON ACTION controlp INFIELD bgfb007_2 name="construct.c.page1.bgfb007_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb007_2  #顯示到畫面上
            NEXT FIELD bgfb007_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007_2
            #add-point:BEFORE FIELD bgfb007_2 name="construct.b.page1.bgfb007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007_2
            
            #add-point:AFTER FIELD bgfb007_2 name="construct.a.page1.bgfb007_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007_desc
            #add-point:ON ACTION controlp INFIELD bgfb007_desc name="construct.c.page1.bgfb007_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'04') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb007_desc  #顯示到畫面上
            NEXT FIELD bgfb007_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007_desc
            #add-point:BEFORE FIELD bgfb007_desc name="construct.b.page1.bgfb007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007_desc
            
            #add-point:AFTER FIELD bgfb007_desc name="construct.a.page1.bgfb007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb009_2
            #add-point:ON ACTION controlp INFIELD bgfb009_2 name="construct.c.page1.bgfb009_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb009_2  #顯示到畫面上
            NEXT FIELD bgfb009_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb009_2
            #add-point:BEFORE FIELD bgfb009_2 name="construct.b.page1.bgfb009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb009_2
            
            #add-point:AFTER FIELD bgfb009_2 name="construct.a.page1.bgfb009_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb009_desc
            #add-point:ON ACTION controlp INFIELD bgfb009_desc name="construct.c.page1.bgfb009_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb009_desc  #顯示到畫面上
            NEXT FIELD bgfb009_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb009_desc
            #add-point:BEFORE FIELD bgfb009_desc name="construct.b.page1.bgfb009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb009_desc
            
            #add-point:AFTER FIELD bgfb009_desc name="construct.a.page1.bgfb009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb012_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb012_2
            #add-point:ON ACTION controlp INFIELD bgfb012_2 name="construct.c.page1.bgfb012_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb012_2  #顯示到畫面上
            NEXT FIELD bgfb012_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb012_2
            #add-point:BEFORE FIELD bgfb012_2 name="construct.b.page1.bgfb012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb012_2
            
            #add-point:AFTER FIELD bgfb012_2 name="construct.a.page1.bgfb012_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb012_desc
            #add-point:ON ACTION controlp INFIELD bgfb012_desc name="construct.c.page1.bgfb012_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb012_desc  #顯示到畫面上
            NEXT FIELD bgfb012_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb012_desc
            #add-point:BEFORE FIELD bgfb012_desc name="construct.b.page1.bgfb012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb012_desc
            
            #add-point:AFTER FIELD bgfb012_desc name="construct.a.page1.bgfb012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb013_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb013_2
            #add-point:ON ACTION controlp INFIELD bgfb013_2 name="construct.c.page1.bgfb013_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb013_2  #顯示到畫面上
            NEXT FIELD bgfb013_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb013_2
            #add-point:BEFORE FIELD bgfb013_2 name="construct.b.page1.bgfb013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb013_2
            
            #add-point:AFTER FIELD bgfb013_2 name="construct.a.page1.bgfb013_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb013_desc
            #add-point:ON ACTION controlp INFIELD bgfb013_desc name="construct.c.page1.bgfb013_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb013_desc  #顯示到畫面上
            NEXT FIELD bgfb013_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb013_desc
            #add-point:BEFORE FIELD bgfb013_desc name="construct.b.page1.bgfb013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb013_desc
            
            #add-point:AFTER FIELD bgfb013_desc name="construct.a.page1.bgfb013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb014_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb014_2
            #add-point:ON ACTION controlp INFIELD bgfb014_2 name="construct.c.page1.bgfb014_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb014_2  #顯示到畫面上
            NEXT FIELD bgfb014_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb014_2
            #add-point:BEFORE FIELD bgfb014_2 name="construct.b.page1.bgfb014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb014_2
            
            #add-point:AFTER FIELD bgfb014_2 name="construct.a.page1.bgfb014_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb014_desc
            #add-point:ON ACTION controlp INFIELD bgfb014_desc name="construct.c.page1.bgfb014_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb014_desc  #顯示到畫面上
            NEXT FIELD bgfb014_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb014_desc
            #add-point:BEFORE FIELD bgfb014_desc name="construct.b.page1.bgfb014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb014_desc
            
            #add-point:AFTER FIELD bgfb014_desc name="construct.a.page1.bgfb014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb015_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb015_2
            #add-point:ON ACTION controlp INFIELD bgfb015_2 name="construct.c.page1.bgfb015_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb015_2  #顯示到畫面上
            NEXT FIELD bgfb015_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb015_2
            #add-point:BEFORE FIELD bgfb015_2 name="construct.b.page1.bgfb015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb015_2
            
            #add-point:AFTER FIELD bgfb015_2 name="construct.a.page1.bgfb015_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb015_desc
            #add-point:ON ACTION controlp INFIELD bgfb015_desc name="construct.c.page1.bgfb015_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb015_desc  #顯示到畫面上
            NEXT FIELD bgfb015_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb015_desc
            #add-point:BEFORE FIELD bgfb015_desc name="construct.b.page1.bgfb015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb015_desc
            
            #add-point:AFTER FIELD bgfb015_desc name="construct.a.page1.bgfb015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb016_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb016_2
            #add-point:ON ACTION controlp INFIELD bgfb016_2 name="construct.c.page1.bgfb016_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb016_2  #顯示到畫面上
            NEXT FIELD bgfb016_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb016_2
            #add-point:BEFORE FIELD bgfb016_2 name="construct.b.page1.bgfb016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb016_2
            
            #add-point:AFTER FIELD bgfb016_2 name="construct.a.page1.bgfb016_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb016_desc
            #add-point:ON ACTION controlp INFIELD bgfb016_desc name="construct.c.page1.bgfb016_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb016_desc  #顯示到畫面上
            NEXT FIELD bgfb016_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb016_desc
            #add-point:BEFORE FIELD bgfb016_desc name="construct.b.page1.bgfb016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb016_desc
            
            #add-point:AFTER FIELD bgfb016_desc name="construct.a.page1.bgfb016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb017_2
            #add-point:ON ACTION controlp INFIELD bgfb017_2 name="construct.c.page1.bgfb017_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb017_2  #顯示到畫面上
            NEXT FIELD bgfb017_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb017_2
            #add-point:BEFORE FIELD bgfb017_2 name="construct.b.page1.bgfb017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb017_2
            
            #add-point:AFTER FIELD bgfb017_2 name="construct.a.page1.bgfb017_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb017_desc
            #add-point:ON ACTION controlp INFIELD bgfb017_desc name="construct.c.page1.bgfb017_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb017_desc  #顯示到畫面上
            NEXT FIELD bgfb017_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb017_desc
            #add-point:BEFORE FIELD bgfb017_desc name="construct.b.page1.bgfb017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb017_desc
            
            #add-point:AFTER FIELD bgfb017_desc name="construct.a.page1.bgfb017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb018_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb018_2
            #add-point:ON ACTION controlp INFIELD bgfb018_2 name="construct.c.page1.bgfb018_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb018_2  #顯示到畫面上
            NEXT FIELD bgfb018_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb018_2
            #add-point:BEFORE FIELD bgfb018_2 name="construct.b.page1.bgfb018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb018_2
            
            #add-point:AFTER FIELD bgfb018_2 name="construct.a.page1.bgfb018_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb018_desc
            #add-point:ON ACTION controlp INFIELD bgfb018_desc name="construct.c.page1.bgfb018_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb018_desc  #顯示到畫面上
            NEXT FIELD bgfb018_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb018_desc
            #add-point:BEFORE FIELD bgfb018_desc name="construct.b.page1.bgfb018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb018_desc
            
            #add-point:AFTER FIELD bgfb018_desc name="construct.a.page1.bgfb018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb019_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb019_2
            #add-point:ON ACTION controlp INFIELD bgfb019_2 name="construct.c.page1.bgfb019_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb019_2  #顯示到畫面上
            NEXT FIELD bgfb019_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb019_2
            #add-point:BEFORE FIELD bgfb019_2 name="construct.b.page1.bgfb019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb019_2
            
            #add-point:AFTER FIELD bgfb019_2 name="construct.a.page1.bgfb019_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb019_desc
            #add-point:ON ACTION controlp INFIELD bgfb019_desc name="construct.c.page1.bgfb019_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb019_desc  #顯示到畫面上
            NEXT FIELD bgfb019_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb019_desc
            #add-point:BEFORE FIELD bgfb019_desc name="construct.b.page1.bgfb019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb019_desc
            
            #add-point:AFTER FIELD bgfb019_desc name="construct.a.page1.bgfb019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb020_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb020_2
            #add-point:ON ACTION controlp INFIELD bgfb020_2 name="construct.c.page1.bgfb020_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb020_2  #顯示到畫面上
            NEXT FIELD bgfb020_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb020_2
            #add-point:BEFORE FIELD bgfb020_2 name="construct.b.page1.bgfb020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb020_2
            
            #add-point:AFTER FIELD bgfb020_2 name="construct.a.page1.bgfb020_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb020_desc
            #add-point:ON ACTION controlp INFIELD bgfb020_desc name="construct.c.page1.bgfb020_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb020_desc  #顯示到畫面上
            NEXT FIELD bgfb020_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb020_desc
            #add-point:BEFORE FIELD bgfb020_desc name="construct.b.page1.bgfb020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb020_desc
            
            #add-point:AFTER FIELD bgfb020_desc name="construct.a.page1.bgfb020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb021_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb021_2
            #add-point:ON ACTION controlp INFIELD bgfb021_2 name="construct.c.page1.bgfb021_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb021_2  #顯示到畫面上
            NEXT FIELD bgfb021_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb021_2
            #add-point:BEFORE FIELD bgfb021_2 name="construct.b.page1.bgfb021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb021_2
            
            #add-point:AFTER FIELD bgfb021_2 name="construct.a.page1.bgfb021_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb021_desc
            #add-point:ON ACTION controlp INFIELD bgfb021_desc name="construct.c.page1.bgfb021_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb021_desc  #顯示到畫面上
            NEXT FIELD bgfb021_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb021_desc
            #add-point:BEFORE FIELD bgfb021_desc name="construct.b.page1.bgfb021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb021_desc
            
            #add-point:AFTER FIELD bgfb021_desc name="construct.a.page1.bgfb021_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb022_2
            #add-point:BEFORE FIELD bgfb022_2 name="construct.b.page1.bgfb022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb022_2
            
            #add-point:AFTER FIELD bgfb022_2 name="construct.a.page1.bgfb022_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb022_2
            #add-point:ON ACTION controlp INFIELD bgfb022_2 name="construct.c.page1.bgfb022_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgfb023_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb023_2
            #add-point:ON ACTION controlp INFIELD bgfb023_2 name="construct.c.page1.bgfb023_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb023_2  #顯示到畫面上
            NEXT FIELD bgfb023_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb023_2
            #add-point:BEFORE FIELD bgfb023_2 name="construct.b.page1.bgfb023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb023_2
            
            #add-point:AFTER FIELD bgfb023_2 name="construct.a.page1.bgfb023_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb023_desc
            #add-point:ON ACTION controlp INFIELD bgfb023_desc name="construct.c.page1.bgfb023_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb023_desc  #顯示到畫面上
            NEXT FIELD bgfb023_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb023_desc
            #add-point:BEFORE FIELD bgfb023_desc name="construct.b.page1.bgfb023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb023_desc
            
            #add-point:AFTER FIELD bgfb023_desc name="construct.a.page1.bgfb023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb024_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb024_2
            #add-point:ON ACTION controlp INFIELD bgfb024_2 name="construct.c.page1.bgfb024_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb024_2  #顯示到畫面上
            NEXT FIELD bgfb024_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb024_2
            #add-point:BEFORE FIELD bgfb024_2 name="construct.b.page1.bgfb024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb024_2
            
            #add-point:AFTER FIELD bgfb024_2 name="construct.a.page1.bgfb024_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb024_desc
            #add-point:ON ACTION controlp INFIELD bgfb024_desc name="construct.c.page1.bgfb024_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb024_desc  #顯示到畫面上
            NEXT FIELD bgfb024_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb024_desc
            #add-point:BEFORE FIELD bgfb024_desc name="construct.b.page1.bgfb024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb024_desc
            
            #add-point:AFTER FIELD bgfb024_desc name="construct.a.page1.bgfb024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb035
            #add-point:ON ACTION controlp INFIELD bgfb035 name="construct.c.page1.bgfb035"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb035  #顯示到畫面上
            NEXT FIELD bgfb035                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb035
            #add-point:BEFORE FIELD bgfb035 name="construct.b.page1.bgfb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb035
            
            #add-point:AFTER FIELD bgfb035 name="construct.a.page1.bgfb035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb036
            #add-point:BEFORE FIELD bgfb036 name="construct.b.page1.bgfb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb036
            
            #add-point:AFTER FIELD bgfb036 name="construct.a.page1.bgfb036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb036
            #add-point:ON ACTION controlp INFIELD bgfb036 name="construct.c.page1.bgfb036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgfb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb100
            #add-point:ON ACTION controlp INFIELD bgfb100 name="construct.c.page1.bgfb100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfb100  #顯示到畫面上
            NEXT FIELD bgfb100                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb100
            #add-point:BEFORE FIELD bgfb100 name="construct.b.page1.bgfb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb100
            
            #add-point:AFTER FIELD bgfb100 name="construct.a.page1.bgfb100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb008
            #add-point:BEFORE FIELD bgfb008 name="construct.b.page1.bgfb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb008
            
            #add-point:AFTER FIELD bgfb008 name="construct.a.page1.bgfb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb008
            #add-point:ON ACTION controlp INFIELD bgfb008 name="construct.c.page1.bgfb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb047
            #add-point:BEFORE FIELD bgfb047 name="construct.b.page1.bgfb047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb047
            
            #add-point:AFTER FIELD bgfb047 name="construct.a.page1.bgfb047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb047
            #add-point:ON ACTION controlp INFIELD bgfb047 name="construct.c.page1.bgfb047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb048
            #add-point:BEFORE FIELD bgfb048 name="construct.b.page1.bgfb048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb048
            
            #add-point:AFTER FIELD bgfb048 name="construct.a.page1.bgfb048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgfb048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb048
            #add-point:ON ACTION controlp INFIELD bgfb048 name="construct.c.page1.bgfb048"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgfbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbownid
            #add-point:ON ACTION controlp INFIELD bgfbownid name="construct.c.page2.bgfbownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfbownid  #顯示到畫面上
            NEXT FIELD bgfbownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbownid
            #add-point:BEFORE FIELD bgfbownid name="construct.b.page2.bgfbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbownid
            
            #add-point:AFTER FIELD bgfbownid name="construct.a.page2.bgfbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgfbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbowndp
            #add-point:ON ACTION controlp INFIELD bgfbowndp name="construct.c.page2.bgfbowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfbowndp  #顯示到畫面上
            NEXT FIELD bgfbowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbowndp
            #add-point:BEFORE FIELD bgfbowndp name="construct.b.page2.bgfbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbowndp
            
            #add-point:AFTER FIELD bgfbowndp name="construct.a.page2.bgfbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgfbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbcrtid
            #add-point:ON ACTION controlp INFIELD bgfbcrtid name="construct.c.page2.bgfbcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfbcrtid  #顯示到畫面上
            NEXT FIELD bgfbcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbcrtid
            #add-point:BEFORE FIELD bgfbcrtid name="construct.b.page2.bgfbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbcrtid
            
            #add-point:AFTER FIELD bgfbcrtid name="construct.a.page2.bgfbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgfbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbcrtdp
            #add-point:ON ACTION controlp INFIELD bgfbcrtdp name="construct.c.page2.bgfbcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfbcrtdp  #顯示到畫面上
            NEXT FIELD bgfbcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbcrtdp
            #add-point:BEFORE FIELD bgfbcrtdp name="construct.b.page2.bgfbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbcrtdp
            
            #add-point:AFTER FIELD bgfbcrtdp name="construct.a.page2.bgfbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbcrtdt
            #add-point:BEFORE FIELD bgfbcrtdt name="construct.b.page2.bgfbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgfbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbmodid
            #add-point:ON ACTION controlp INFIELD bgfbmodid name="construct.c.page2.bgfbmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfbmodid  #顯示到畫面上
            NEXT FIELD bgfbmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbmodid
            #add-point:BEFORE FIELD bgfbmodid name="construct.b.page2.bgfbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbmodid
            
            #add-point:AFTER FIELD bgfbmodid name="construct.a.page2.bgfbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbmoddt
            #add-point:BEFORE FIELD bgfbmoddt name="construct.b.page2.bgfbmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgfbcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbcnfid
            #add-point:ON ACTION controlp INFIELD bgfbcnfid name="construct.c.page2.bgfbcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgfbcnfid  #顯示到畫面上
            NEXT FIELD bgfbcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbcnfid
            #add-point:BEFORE FIELD bgfbcnfid name="construct.b.page2.bgfbcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbcnfid
            
            #add-point:AFTER FIELD bgfbcnfid name="construct.a.page2.bgfbcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbcnfdt
            #add-point:BEFORE FIELD bgfbcnfdt name="construct.b.page2.bgfbcnfdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         
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
   
   #add-point:cs段after_construct name="cs.after_construct"
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"_desc","")
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"bgfb022_2","bgfb022")
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt620_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
   #end add-point 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
   
   LET ls_wc = g_wc
 
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_bgfb_d.clear()
   CALL g_bgfb2_d.clear()
   CALL g_bgfb3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgt620_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt620_browser_fill(g_wc)
      CALL abgt620_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgt620_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL abgt620_fetch("F") 
   END IF
   
   CALL abgt620_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt620_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_bgfb010_str       STRING
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL abgt620_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_bgfb_m.bgfb001 = g_browser[g_current_idx].b_bgfb001
   LET g_bgfb_m.bgfb002 = g_browser[g_current_idx].b_bgfb002
   LET g_bgfb_m.bgfb003 = g_browser[g_current_idx].b_bgfb003
   LET g_bgfb_m.bgfb004 = g_browser[g_current_idx].b_bgfb004
   LET g_bgfb_m.bgfb005 = g_browser[g_current_idx].b_bgfb005
   LET g_bgfb_m.bgfb006 = g_browser[g_current_idx].b_bgfb006
   LET g_bgfb_m.bgfb007 = g_browser[g_current_idx].b_bgfb007
   LET g_bgfb_m.bgfb009 = g_browser[g_current_idx].b_bgfb009
   LET g_bgfb_m.bgfb010 = g_browser[g_current_idx].b_bgfb010
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010 INTO g_bgfb_m.bgfb002, 
       g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023, 
       g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb002_desc, 
       g_bgfb_m.bgfb004_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bgfb_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgfb_m_mask_o.* =  g_bgfb_m.*
   CALL abgt620_bgfb_t_mask()
   LET g_bgfb_m_mask_n.* =  g_bgfb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt620_set_act_visible()
   CALL abgt620_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   #重新抓取樣式
   CALL s_abg2_get_bgaw(g_bgfb_m.bgfb011) RETURNING g_bgaw1,g_bgaw2
   
   #重写单头锁资料sql
   LET g_forupd_sql = " SELECT bgfb002,'',bgfb003,bgfb004,'','','',bgfb011,bgfb001,bgfb005,bgfb006,bgfbstus, 
       bgfb007,'',bgfb013,'',bgfb016,'',bgfb019,'',bgfb022,bgfb009,bgfb014,'',bgfb017,'',bgfb020,'', 
       bgfb023,'',bgfb012,'',bgfb015,'',bgfb018,'',bgfb021,'',bgfb024,''",  
                      " FROM bgfb_t",
                      " WHERE bgfbent= ? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND  
                          bgfb005=? AND bgfb006=? "
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET g_forupd_sql = g_forupd_sql," AND bgfb007=? "
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET g_forupd_sql = g_forupd_sql," AND bgfb009=? "
   END IF
   
   #将单头核算项组成的组合码转换成查询条件
   LET l_bgfb010_str=g_bgfb_m.bgfb010
   IF cl_null(l_bgfb010_str) THEN
      LET l_bgfb010_str = " 1=1 "
   ELSE
      LET l_bgfb010_str=cl_replace_str(l_bgfb010_str,"=","='")
      LET l_bgfb010_str=cl_replace_str(l_bgfb010_str,"/","' AND ")
      LET l_bgfb010_str=l_bgfb010_str,"' "
   END IF
   LET g_forupd_sql = g_forupd_sql," AND ",l_bgfb010_str
   
   LET g_forupd_sql = g_forupd_sql," FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt620_hcl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   #end add-point
 
   #保存單頭舊值
   LET g_bgfb_m_t.* = g_bgfb_m.*
   LET g_bgfb_m_o.* = g_bgfb_m.*
   
   #重新顯示   
   CALL abgt620_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt620_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bgfb_d.clear()
   CALL g_bgfb2_d.clear()
   CALL g_bgfb3_d.clear()
 
 
   INITIALIZE g_bgfb_m.* TO NULL             #DEFAULT 設定
   LET g_bgfb001_t = NULL
   LET g_bgfb002_t = NULL
   LET g_bgfb003_t = NULL
   LET g_bgfb004_t = NULL
   LET g_bgfb005_t = NULL
   LET g_bgfb006_t = NULL
   LET g_bgfb007_t = NULL
   LET g_bgfb009_t = NULL
   LET g_bgfb010_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_bgfb_m.bgfb001 = "20"
      LET g_bgfb_m.bgfb005 = "1"
      LET g_bgfb_m.bgfb006 = "1"
      LET g_bgfb_m.bgfbstus = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_bgfb_m_t.* = g_bgfb_m.*
      CALL cl_set_comp_visible("bgfb007,bgfb007_desc_t,bgfb009,bgfb013,bgfb013_desc_t,bgfb014,bgfb014_desc_t,bgfb015,bgfb015_desc_t,bgfb016,bgfb016_desc_t,bgfb017,bgfb017_desc_t,",TRUE)
      CALL cl_set_comp_visible("bgfb018,bgfb018_desc_t,bgfb019,bgfb019_desc_t,bgfb022,bgfb023,bgfb023_desc_t,bgfb024,bgfb024_desc_t,bgfb012,bgfb012_desc_t,bgfb020,bgfb020_desc_tbgfb021,bgfb021_desc_t,group_1",TRUE)
      CASE g_bgfb_m.bgfbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
      #end add-point 
 
      CALL abgt620_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
 
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bgfb_m.* TO NULL
         INITIALIZE g_bgfb_d TO NULL
         INITIALIZE g_bgfb2_d TO NULL
         INITIALIZE g_bgfb3_d TO NULL
 
         CALL abgt620_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgfb_m.* = g_bgfb_m_t.*
         CALL abgt620_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bgfb_d.clear()
      #CALL g_bgfb2_d.clear()
      #CALL g_bgfb3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt620_set_act_visible()
   CALL abgt620_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
   LET g_bgfb010_t = g_bgfb_m.bgfb010
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                      " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                      ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                      ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                      ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                      ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                      ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
                      ," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
                      ," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
                      ," AND bgfb010 = '", g_bgfb_m.bgfb010, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt620_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgt620_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010 INTO g_bgfb_m.bgfb002, 
       g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023, 
       g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb002_desc, 
       g_bgfb_m.bgfb004_desc
   
   #遮罩相關處理
   LET g_bgfb_m_mask_o.* =  g_bgfb_m.*
   CALL abgt620_bgfb_t_mask()
   LET g_bgfb_m_mask_n.* =  g_bgfb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgfb_m.bgfb002,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb004_desc, 
       g_bgfb_m.bgaa002,g_bgfb_m.bgaa003,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb007_desc_t,g_bgfb_m.bgfb013, 
       g_bgfb_m.bgfb013_desc_t,g_bgfb_m.bgfb016,g_bgfb_m.bgfb016_desc_t,g_bgfb_m.bgfb019,g_bgfb_m.bgfb019_desc_t, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb014_desc_t,g_bgfb_m.bgfb017,g_bgfb_m.bgfb017_desc_t, 
       g_bgfb_m.bgfb020,g_bgfb_m.bgfb020_desc_t,g_bgfb_m.bgfb023,g_bgfb_m.bgfb023_desc_t,g_bgfb_m.bgfb012, 
       g_bgfb_m.bgfb012_desc_t,g_bgfb_m.bgfb015,g_bgfb_m.bgfb015_desc_t,g_bgfb_m.bgfb018,g_bgfb_m.bgfb018_desc_t, 
       g_bgfb_m.bgfb021,g_bgfb_m.bgfb021_desc_t,g_bgfb_m.bgfb024,g_bgfb_m.bgfb024_desc_t
   
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt620_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #由于主键位置不确定在单头或单身，锁资料SQL不同，需重写
   CALL abgt620_modify_1()
   RETURN
   #end add-point
   
   IF g_bgfb_m.bgfb001 IS NULL
   OR g_bgfb_m.bgfb002 IS NULL
   OR g_bgfb_m.bgfb003 IS NULL
   OR g_bgfb_m.bgfb004 IS NULL
   OR g_bgfb_m.bgfb005 IS NULL
   OR g_bgfb_m.bgfb006 IS NULL
   OR g_bgfb_m.bgfb007 IS NULL
   OR g_bgfb_m.bgfb009 IS NULL
   OR g_bgfb_m.bgfb010 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
   LET g_bgfb010_t = g_bgfb_m.bgfb010
 
   CALL s_transaction_begin()
   
   OPEN abgt620_cl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt620_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt620_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010 INTO g_bgfb_m.bgfb002, 
       g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023, 
       g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb002_desc, 
       g_bgfb_m.bgfb004_desc
   
   #遮罩相關處理
   LET g_bgfb_m_mask_o.* =  g_bgfb_m.*
   CALL abgt620_bgfb_t_mask()
   LET g_bgfb_m_mask_n.* =  g_bgfb_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt620_show()
   WHILE TRUE
      LET g_bgfb001_t = g_bgfb_m.bgfb001
      LET g_bgfb002_t = g_bgfb_m.bgfb002
      LET g_bgfb003_t = g_bgfb_m.bgfb003
      LET g_bgfb004_t = g_bgfb_m.bgfb004
      LET g_bgfb005_t = g_bgfb_m.bgfb005
      LET g_bgfb006_t = g_bgfb_m.bgfb006
      LET g_bgfb007_t = g_bgfb_m.bgfb007
      LET g_bgfb009_t = g_bgfb_m.bgfb009
      LET g_bgfb010_t = g_bgfb_m.bgfb010
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgt620_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgfb_m.* = g_bgfb_m_t.*
         CALL abgt620_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgfb_m.bgfb001 != g_bgfb001_t 
      OR g_bgfb_m.bgfb002 != g_bgfb002_t 
      OR g_bgfb_m.bgfb003 != g_bgfb003_t 
      OR g_bgfb_m.bgfb004 != g_bgfb004_t 
      OR g_bgfb_m.bgfb005 != g_bgfb005_t 
      OR g_bgfb_m.bgfb006 != g_bgfb006_t 
      OR g_bgfb_m.bgfb007 != g_bgfb007_t 
      OR g_bgfb_m.bgfb009 != g_bgfb009_t 
      OR g_bgfb_m.bgfb010 != g_bgfb010_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt620_set_act_visible()
   CALL abgt620_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                      " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                      ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                      ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                      ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                      ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                      ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
                      ," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
                      ," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
                      ," AND bgfb010 = '", g_bgfb_m.bgfb010, "' "
 
   #填到對應位置
   CALL abgt620_browser_fill("")
 
   CALL abgt620_idx_chk()
 
   CLOSE abgt620_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt620.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt620_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_ooaa002              LIKE ooaa_t.ooaa002
   DEFINE l_success              LIKE type_t.num5     
   DEFINE l_ooef017              LIKE ooef_t.ooef017
   DEFINE l_bgaa011              LIKE bgaa_t.bgaa011
   DEFINE l_bgaa010              LIKE bgaa_t.bgaa010
   DEFINE l_origin_str           STRING
   DEFINE l_site_str             STRING
   DEFINE l_sql                  STRING
   DEFINE l_bgasl003             LIKE bgasl_t.bgasl003
   DEFINE l_bgasl004             LIKE bgasl_t.bgasl004
   DEFINE l_bgfb007              LIKE bgfb_t.bgfb007
   DEFINE l_bgfb009              LIKE bgfb_t.bgfb009
   DEFINE l_ooef019              LIKE ooef_t.ooef019
   DEFINE l_ooef001              LIKE ooef_t.ooef001
   DEFINE l_ooed005              LIKE ooed_t.ooed005
   DEFINE l_bgea012              LIKE bgea_t.bgea012
   DEFINE l_bgea010              LIKE bgea_t.bgea010
   DEFINE l_bgea011              LIKE bgea_t.bgea011
   DEFINE l_bgea013              LIKE bgea_t.bgea013
   DEFINE l_bgea004              LIKE bgea_t.bgea004
   DEFINE l_bgaa006              LIKE bgaa_t.bgaa006
   DEFINE l_bgae008              LIKE bgae_t.bgae008
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bgfb_m.bgfb002,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb004_desc, 
       g_bgfb_m.bgaa002,g_bgfb_m.bgaa003,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb007_desc_t,g_bgfb_m.bgfb013, 
       g_bgfb_m.bgfb013_desc_t,g_bgfb_m.bgfb016,g_bgfb_m.bgfb016_desc_t,g_bgfb_m.bgfb019,g_bgfb_m.bgfb019_desc_t, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb014_desc_t,g_bgfb_m.bgfb017,g_bgfb_m.bgfb017_desc_t, 
       g_bgfb_m.bgfb020,g_bgfb_m.bgfb020_desc_t,g_bgfb_m.bgfb023,g_bgfb_m.bgfb023_desc_t,g_bgfb_m.bgfb012, 
       g_bgfb_m.bgfb012_desc_t,g_bgfb_m.bgfb015,g_bgfb_m.bgfb015_desc_t,g_bgfb_m.bgfb018,g_bgfb_m.bgfb018_desc_t, 
       g_bgfb_m.bgfb021,g_bgfb_m.bgfb021_desc_t,g_bgfb_m.bgfb024,g_bgfb_m.bgfb024_desc_t
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016, 
       bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,bgfb100,bgfb008, 
       bgfb047,bgfb048,bgfbseq,bgfbownid,bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt, 
       bgfbcnfid,bgfbcnfdt,bgfbseq FROM bgfb_t WHERE bgfbent=? AND bgfb001=? AND bgfb002=? AND bgfb003=?  
       AND bgfb004=? AND bgfb005=? AND bgfb006=? AND bgfb007=? AND bgfb009=? AND bgfb010=? AND bgfb008=?  
       AND bgfbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   #重写单身锁资料sql
   #161220-00036#1--mod--str--
#   LET g_forupd_sql = "SELECT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015, 
#       bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,
#       bgfb100,bgfb101,0,bgfb047,bgfb048,bgfbseq,bgfbownid,bgfbowndp, 
#       bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt,bgfbseq FROM bgfb_t WHERE  
#       bgfbent=? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND bgfb005=? AND bgfb006=?  
#       AND bgfb007=? AND bgfb009=? AND bgfb010=? AND bgfbseq=? FOR UPDATE"
   LET g_forupd_sql = "SELECT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015,", 
       "bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,",
       "bgfb100,0,bgfb047,bgfb048,bgfbseq,bgfbownid,bgfbowndp, ",
       "bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt,bgfbseq ",
       "  FROM bgfb_t ",
       " WHERE bgfbent=? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND bgfb005=? AND bgfb006=? ", 
       "   AND bgfb007=? AND bgfb009=? AND bgfb010=? AND bgfbseq=? FOR UPDATE"
   #161220-00036#1--mod--end
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt620_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt620_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt620_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013, 
       g_bgfb_m.bgfb016,g_bgfb_m.bgfb019,g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017, 
       g_bgfb_m.bgfb020,g_bgfb_m.bgfb023,g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021, 
       g_bgfb_m.bgfb024
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt620.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001, 
          g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013, 
          g_bgfb_m.bgfb016,g_bgfb_m.bgfb019,g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017, 
          g_bgfb_m.bgfb020,g_bgfb_m.bgfb023,g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021, 
          g_bgfb_m.bgfb024 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            IF p_cmd = 'u' THEN
               CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
            END IF
            #新增时从预算编号开始录入
            IF p_cmd ='a' THEN
               NEXT FIELD bgfb002
            END IF
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb002
            
            #add-point:AFTER FIELD bgfb002 name="input.a.bgfb002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb002
            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb002_desc

            IF NOT cl_null(g_bgfb_m.bgfb002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb002 != g_bgfb002_t)) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgfb_m.bgfb002
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"

                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_bgaa001") THEN
                     #预算编号需是使用预测的（bgaa006=1.使用）
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_bgfb_m.bgfb002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgfb_m.bgfb002 = g_bgfb_m_t.bgfb002
                        CALL s_desc_get_budget_desc(g_bgfb_m.bgfb002) RETURNING g_bgfb_m.bgfb002_desc
                        DISPLAY BY NAME g_bgfb_m.bgfb002_desc
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_bgfb_m.bgfb004) THEN
                        CALL s_abg2_bgai002_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,'04')
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bgfb_m.bgfb002," + ",g_bgfb_m.bgfb004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_m.bgfb002 = g_bgfb_m_t.bgfb002
                           CALL s_desc_get_budget_desc(g_bgfb_m.bgfb002) RETURNING g_bgfb_m.bgfb002_desc
                           DISPLAY BY NAME g_bgfb_m.bgfb002_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bgfb_m.bgfb002 = g_bgfb_m_t.bgfb002
                     CALL s_desc_get_budget_desc(g_bgfb_m.bgfb002) RETURNING g_bgfb_m.bgfb002_desc
                     DISPLAY BY NAME g_bgfb_m.bgfb002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #抓取預算樣表
                  IF NOT cl_null(g_bgfb_m.bgfb004) THEN
                     SELECT DISTINCT bgai008 INTO g_bgfb_m.bgfb011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bgfb_m.bgfb002 AND bgai002=g_bgfb_m.bgfb004
                     CALL s_abg2_get_bgaw(g_bgfb_m.bgfb011) RETURNING g_bgaw1,g_bgaw2
                     #设置核算项显示位置
                     CALL abgt620_set_hsx_visible()
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
                     AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                        OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                   g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgfb_m.bgfb002
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_m.bgfb002 = g_bgfb_m_t.bgfb002
                           CALL s_desc_get_budget_desc(g_bgfb_m.bgfb002) RETURNING g_bgfb_m.bgfb002_desc
                           DISPLAY BY NAME g_bgfb_m.bgfb002_desc
                           #重新抓取樣式
                           SELECT DISTINCT bgai008 INTO g_bgfb_m.bgfb011 FROM bgai_t
                            WHERE bgaient=g_enterprise AND bgai001=g_bgfb_m.bgfb002 AND bgai002=g_bgfb_m.bgfb004
                           CALL s_abg2_get_bgaw(g_bgfb_m.bgfb011) RETURNING g_bgaw1,g_bgaw2
                           #设置核算项显示位置
                           CALL abgt620_set_hsx_visible()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #抓取預算週期和預算期別
                  CALL s_abgt340_sel_bgaa(g_bgfb_m.bgfb002) RETURNING g_bgfb_m.bgaa002,g_bgfb_m.bgaa003,g_max_period
                  DISPLAY BY NAME g_bgfb_m.bgaa002,g_bgfb_m.bgaa003
                  #當期別不為13期時，影藏13期的金額欄位
                  IF g_max_period < 13 THEN
                     CALL cl_set_comp_visible("amt13,tamt13",FALSE)
                  ELSE
                     CALL cl_set_comp_visible("amt13,tamt13",TRUE)
                  END IF
                  #预算细项参照表号
                  SELECT bgaa008 INTO g_bgaa008 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb002
            #add-point:BEFORE FIELD bgfb002 name="input.b.bgfb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb002
            #add-point:ON CHANGE bgfb002 name="input.g.bgfb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb003
            #add-point:BEFORE FIELD bgfb003 name="input.b.bgfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb003
            
            #add-point:AFTER FIELD bgfb003 name="input.a.bgfb003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) AND NOT cl_null(g_bgfb_m.bgfb007) AND NOT cl_null(g_bgfb_m.bgfb009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t  OR g_bgfb_m.bgfb007 != g_bgfb007_t  OR g_bgfb_m.bgfb009 != g_bgfb009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgfb_t WHERE "||"bgfbent = " ||g_enterprise|| " AND "||"bgfb001 = '"||g_bgfb_m.bgfb001 ||"' AND "|| "bgfb002 = '"||g_bgfb_m.bgfb002 ||"' AND "|| "bgfb003 = '"||g_bgfb_m.bgfb003 ||"' AND "|| "bgfb004 = '"||g_bgfb_m.bgfb004 ||"' AND "|| "bgfb005 = '"||g_bgfb_m.bgfb005 ||"' AND "|| "bgfb006 = '"||g_bgfb_m.bgfb006 ||"' AND "|| "bgfb007 = '"||g_bgfb_m.bgfb007 ||"' AND "|| "bgfb009 = '"||g_bgfb_m.bgfb009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            IF NOT cl_null(g_bgfb_m.bgfb003) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb003 != g_bgfb003_t)) THEN
                  #確認欄位值在特定區間內
                  IF NOT cl_ap_chk_range(g_bgfb_m.bgfb003,"0","0","","","azz-00079",1) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #主鍵檢查
            IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
               AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t)  
                                  )
               ) THEN 
                  CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                             g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgfb_m.bgfb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb003 = g_bgfb_m_t.bgfb003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb003
            #add-point:ON CHANGE bgfb003 name="input.g.bgfb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb004
            
            #add-point:AFTER FIELD bgfb004 name="input.a.bgfb004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb002
            LET g_ref_fields[2] = g_bgfb_m.bgfb004
            CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb004_desc

            IF NOT cl_null(g_bgfb_m.bgfb004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb004 != g_bgfb004_t)) THEN
                  CALL s_abg2_bgai002_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,'04')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_m.bgfb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb004 = g_bgfb_m_t.bgfb004
                     CALL s_desc_get_bgai002_desc(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004) RETURNING g_bgfb_m.bgfb004_desc
                     DISPLAY BY NAME g_bgfb_m.bgfb004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #抓取預算樣表
                  IF NOT cl_null(g_bgfb_m.bgfb002) THEN
                     SELECT DISTINCT bgai008 INTO g_bgfb_m.bgfb011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bgfb_m.bgfb002 AND bgai002=g_bgfb_m.bgfb004
                     CALL s_abg2_get_bgaw(g_bgfb_m.bgfb011) RETURNING g_bgaw1,g_bgaw2
                     #设置核算项显示位置
                     CALL abgt620_set_hsx_visible()
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
                     AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                        OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                   g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgfb_m.bgfb004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_m.bgfb004 = g_bgfb_m_t.bgfb004
                           CALL s_desc_get_bgai002_desc(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004) RETURNING g_bgfb_m.bgfb004_desc
                           DISPLAY BY NAME g_bgfb_m.bgfb004_desc
                           #重新抓取樣式
                           SELECT DISTINCT bgai008 INTO g_bgfb_m.bgfb011 FROM bgai_t
                            WHERE bgaient=g_enterprise AND bgai001=g_bgfb_m.bgfb002 AND bgai002=g_bgfb_m.bgfb004
                           CALL s_abg2_get_bgaw(g_bgfb_m.bgfb011) RETURNING g_bgaw1,g_bgaw2
                           #设置核算项显示位置
                           CALL abgt620_set_hsx_visible()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb004
            #add-point:BEFORE FIELD bgfb004 name="input.b.bgfb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb004
            #add-point:ON CHANGE bgfb004 name="input.g.bgfb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb011
            #add-point:BEFORE FIELD bgfb011 name="input.b.bgfb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb011
            
            #add-point:AFTER FIELD bgfb011 name="input.a.bgfb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb011
            #add-point:ON CHANGE bgfb011 name="input.g.bgfb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb001
            #add-point:BEFORE FIELD bgfb001 name="input.b.bgfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb001
            
            #add-point:AFTER FIELD bgfb001 name="input.a.bgfb001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) AND NOT cl_null(g_bgfb_m.bgfb007) AND NOT cl_null(g_bgfb_m.bgfb009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t  OR g_bgfb_m.bgfb007 != g_bgfb007_t  OR g_bgfb_m.bgfb009 != g_bgfb009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgfb_t WHERE "||"bgfbent = " ||g_enterprise|| " AND "||"bgfb001 = '"||g_bgfb_m.bgfb001 ||"' AND "|| "bgfb002 = '"||g_bgfb_m.bgfb002 ||"' AND "|| "bgfb003 = '"||g_bgfb_m.bgfb003 ||"' AND "|| "bgfb004 = '"||g_bgfb_m.bgfb004 ||"' AND "|| "bgfb005 = '"||g_bgfb_m.bgfb005 ||"' AND "|| "bgfb006 = '"||g_bgfb_m.bgfb006 ||"' AND "|| "bgfb007 = '"||g_bgfb_m.bgfb007 ||"' AND "|| "bgfb009 = '"||g_bgfb_m.bgfb009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb001
            #add-point:ON CHANGE bgfb001 name="input.g.bgfb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb005
            #add-point:BEFORE FIELD bgfb005 name="input.b.bgfb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb005
            
            #add-point:AFTER FIELD bgfb005 name="input.a.bgfb005"
            #主鍵檢查
            IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
               AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t) 
                                  )
               ) THEN 
                  CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                             g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgfb_m.bgfb005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb005 = g_bgfb_m_t.bgfb005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb005
            #add-point:ON CHANGE bgfb005 name="input.g.bgfb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb006
            #add-point:BEFORE FIELD bgfb006 name="input.b.bgfb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb006
            
            #add-point:AFTER FIELD bgfb006 name="input.a.bgfb006"
            #主鍵檢查
            IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
               AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t)  
                                  )
               ) THEN 
                  CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                             g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgfb_m.bgfb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb006 = g_bgfb_m_t.bgfb006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb006
            #add-point:ON CHANGE bgfb006 name="input.g.bgfb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb010
            #add-point:BEFORE FIELD bgfb010 name="input.b.bgfb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb010
            
            #add-point:AFTER FIELD bgfb010 name="input.a.bgfb010"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) AND NOT cl_null(g_bgfb_m.bgfb007) AND NOT cl_null(g_bgfb_m.bgfb009) AND NOT cl_null(g_bgfb_m.bgfb010) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t  OR g_bgfb_m.bgfb007 != g_bgfb007_t  OR g_bgfb_m.bgfb009 != g_bgfb009_t  OR g_bgfb_m.bgfb010 != g_bgfb010_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgfb_t WHERE "||"bgfbent = " ||g_enterprise|| " AND "||"bgfb001 = '"||g_bgfb_m.bgfb001 ||"' AND "|| "bgfb002 = '"||g_bgfb_m.bgfb002 ||"' AND "|| "bgfb003 = '"||g_bgfb_m.bgfb003 ||"' AND "|| "bgfb004 = '"||g_bgfb_m.bgfb004 ||"' AND "|| "bgfb005 = '"||g_bgfb_m.bgfb005 ||"' AND "|| "bgfb006 = '"||g_bgfb_m.bgfb006 ||"' AND "|| "bgfb007 = '"||g_bgfb_m.bgfb007 ||"' AND "|| "bgfb009 = '"||g_bgfb_m.bgfb009 ||"' AND "|| "bgfb010 = '"||g_bgfb_m.bgfb010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb010
            #add-point:ON CHANGE bgfb010 name="input.g.bgfb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbstus
            #add-point:BEFORE FIELD bgfbstus name="input.b.bgfbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbstus
            
            #add-point:AFTER FIELD bgfbstus name="input.a.bgfbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfbstus
            #add-point:ON CHANGE bgfbstus name="input.g.bgfbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007
            
            #add-point:AFTER FIELD bgfb007 name="input.a.bgfb007"
            IF NOT cl_null(g_bgfb_m.bgfb007) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb007 != g_bgfb_m_t.bgfb007 OR cl_null(g_bgfb_m_t.bgfb007))) THEN
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgfb_m.bgfb007
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     #檢查失敗時後續處理
                     LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                     CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
                     NEXT FIELD CURRENT
                  END IF
                 
                  #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_bgfb_m.bgfb007,'04')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_m.bgfb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                     CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #检查预算编号+版本+预算管理组织+销售方式下预算组织或预算上层组织是否已存在汇总资料abgt630，如果存在，不可录入
                  IF NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) AND
                     NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) THEN
                     #预算组织是否存在汇总资料
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM bgfb_t
                      WHERE bgfbent=g_enterprise AND bgfb001='30'
                        AND bgfb002=g_bgfb_m.bgfb002 AND bgfb003=g_bgfb_m.bgfb003
                        AND bgfb004=g_bgfb_m.bgfb004 AND bgfb005=g_bgfb_m.bgfb005
                        AND bgfb006='2' AND bgfb007 = g_bgfb_m.bgfb007
                        AND bgfbstus<>'X'
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00231'
                        LET g_errparam.extend =g_bgfb_m.bgfb007
                        #161215-00014#3--mod--str--
#                        LET g_errparam.replace[1] = 'abgt630'
#                        LET g_errparam.replace[2] = cl_get_progname('abgt630',g_lang,"2")
                        LET g_errparam.replace[1] = cl_get_progname('abgt630',g_lang,"2")
                        #161215-00014#3--mod--end
                        LET g_errparam.exeprog = 'abgt630'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                        CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
                        DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
                        NEXT FIELD CURRENT
                     END IF
                     #预算组织的上层组织是否存在汇总资料
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
                     #抓取上层组织
                     IF NOT cl_null(l_bgaa010) THEN
                        SELECT ooed005 INTO l_ooed005 FROM ooed_t
                          WHERE ooedent=g_enterprise AND ooed001='4'
                            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                            AND ooed004=g_bgfb_m.bgfb007
                        IF NOT cl_null(l_ooed005) THEN
                           LET l_cnt = 0
                           SELECT COUNT(1) INTO l_cnt FROM bgfb_t
                            WHERE bgfbent=g_enterprise AND bgfb001='30'
                              AND bgfb002=g_bgfb_m.bgfb002 AND bgfb003=g_bgfb_m.bgfb003
                              AND bgfb004=g_bgfb_m.bgfb004 AND bgfb005=g_bgfb_m.bgfb005
                              AND bgfb006='2' AND bgfb007 = l_ooed005
                              AND bgfbstus<>'X'
                           IF l_cnt > 0 THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00232'
                              LET g_errparam.extend =g_bgfb_m.bgfb007
                              #161215-00014#3--mod--str--
#                              LET g_errparam.replace[1] = 'abgt630'
#                              LET g_errparam.replace[2] = cl_get_progname('abgt630',g_lang,"2")
                              LET g_errparam.replace[1] = cl_get_progname('abgt630',g_lang,"2")
                              #161215-00014#3--mod--end
                              LET g_errparam.exeprog = 'abgt630'
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                              CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
                              DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
                  
                  #预算细项在单头
                  IF g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009) THEN
                     #预算细项权限检查abgi090
                     CALL s_abg2_bgai006_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,g_bgfb_m.bgfb007,'04',g_bgfb_m.bgfb009)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend =l_bgea004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                        NEXT FIELD CURRENT
                     END IF
                     #设置单头启用核算项
                     CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
                  END IF
                  
                  #主鍵檢查
                  IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
                     AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                        OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                   g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgfb_m.bgfb007
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
            DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007
            #add-point:BEFORE FIELD bgfb007 name="input.b.bgfb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb007
            #add-point:ON CHANGE bgfb007 name="input.g.bgfb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb013
            
            #add-point:AFTER FIELD bgfb013 name="input.a.bgfb013"
            IF NOT cl_null(g_bgfb_m.bgfb013) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb013 != g_bgfb_m_t.bgfb013 OR cl_null(g_bgfb_m_t.bgfb013))) THEN
                  #部门基础资料检核
                  CALL s_department_chk(g_bgfb_m.bgfb013,g_today) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_m.bgfb013 = g_bgfb_m_t.bgfb013
                     CALL s_desc_get_department_desc(g_bgfb_m.bgfb013) RETURNING g_bgfb_m.bgfb013_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb013_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bgfb_m.bgfb013,g_bgfb_m.bgfb007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_m.bgfb013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb013 = g_bgfb_m_t.bgfb013
                     CALL s_desc_get_department_desc(g_bgfb_m.bgfb013) RETURNING g_bgfb_m.bgfb013_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb013_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               #抓取部门对应利润中心
               IF g_bgaw1[4]='Y' AND cl_null(g_bgfb_m.bgfb014) AND g_bgal.bgal006 = 'Y' THEN
                  SELECT ooeg004 INTO g_bgfb_m.bgfb014 FROM ooeg_t
                   WHERE ooegent=g_enterprise AND ooeg001=g_bgfb_m.bgfb013
                  CALL s_desc_get_department_desc(g_bgfb_m.bgfb014) RETURNING g_bgfb_m.bgfb014_desc_t
                  DISPLAY BY NAME g_bgfb_m.bgfb014,g_bgfb_m.bgfb014_desc_t
               END IF
            END IF
            CALL s_desc_get_department_desc(g_bgfb_m.bgfb013) RETURNING g_bgfb_m.bgfb013_desc_t
            DISPLAY BY NAME g_bgfb_m.bgfb013_desc_t
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb013
            #add-point:BEFORE FIELD bgfb013 name="input.b.bgfb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb013
            #add-point:ON CHANGE bgfb013 name="input.g.bgfb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb016
            
            #add-point:AFTER FIELD bgfb016 name="input.a.bgfb016"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb016
            CALL ap_ref_array2(g_ref_fields,"SELECT bgapl003 FROM bgapl_t WHERE bgaplent="||g_enterprise||" AND bgapl001=? AND bgapl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb016_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb016_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb016) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb016 != g_bgfb_m_t.bgfb016 OR cl_null(g_bgfb_m_t.bgfb016))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgfb_m.bgfb016,g_bgfb_m.bgfb007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb016
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb016 = g_bgfb_m_t.bgfb016
                     CALL s_desc_get_bgap001_desc(g_bgfb_m.bgfb016) RETURNING g_bgfb_m.bgfb016_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb016_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb016
            #add-point:BEFORE FIELD bgfb016 name="input.b.bgfb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb016
            #add-point:ON CHANGE bgfb016 name="input.g.bgfb016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb019
            
            #add-point:AFTER FIELD bgfb019 name="input.a.bgfb019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb019
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent="||g_enterprise||" AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb019_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb019_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb019) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb019 != g_bgfb_m_t.bgfb019 OR cl_null(g_bgfb_m_t.bgfb019))) THEN
                  CALL s_voucher_glaq024_chk(g_bgfb_m.bgfb019)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb019
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb019 = g_bgfb_m_t.bgfb019
                     CALL s_desc_get_rtaxl003_desc(g_bgfb_m.bgfb019) RETURNING g_bgfb_m.bgfb019_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb019_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb019
            #add-point:BEFORE FIELD bgfb019 name="input.b.bgfb019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb019
            #add-point:ON CHANGE bgfb019 name="input.g.bgfb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb022
            #add-point:BEFORE FIELD bgfb022 name="input.b.bgfb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb022
            
            #add-point:AFTER FIELD bgfb022 name="input.a.bgfb022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb022
            #add-point:ON CHANGE bgfb022 name="input.g.bgfb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb009
            #add-point:BEFORE FIELD bgfb009 name="input.b.bgfb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb009
            
            #add-point:AFTER FIELD bgfb009 name="input.a.bgfb009"
            #應用 a05 樣板自動產生(Version:3)
            IF NOT cl_null(g_bgfb_m.bgfb009) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb009 != g_bgfb_m_t.bgfb009 OR cl_null(g_bgfb_m_t.bgfb009))) THEN
                  CALL s_abg2_bgal003_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_m.bgfb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb009 = g_bgfb_m_t.bgfb009
                     NEXT FIELD CURRENT
                  END IF
                  #预算细项对应的费用分类要与单头的费用来源一致
                  SELECT bgae008 INTO l_bgae008 FROM bgae_t 
                   WHERE bgaeent=g_enterprise AND bgae006=g_bgaa008 AND bgae001=g_bgfb_m.bgfb009
                  IF l_bgae008 <> g_bgfb_m.bgfb005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00308'
                     LET g_errparam.extend =g_bgfb_m.bgfb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb009 = g_bgfb_m_t.bgfb009
                     NEXT FIELD CURRENT
                  END IF
                  #预算细项权限检查abgi090
                  CALL s_abg2_bgai006_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,g_bgfb_m.bgfb007,'04',g_bgfb_m.bgfb009)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =l_bgea004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb009 = g_bgfb_m_t.bgfb009
                     NEXT FIELD CURRENT
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
                     AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                        OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                   g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgfb_m.bgfb009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_m.bgfb009 = g_bgfb_m_t.bgfb009
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               
                  #设置单头启用核算项
                  CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb009
            #add-point:ON CHANGE bgfb009 name="input.g.bgfb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb014
            
            #add-point:AFTER FIELD bgfb014 name="input.a.bgfb014"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb014
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? ","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb014_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb014_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb014) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb014 != g_bgfb_m_t.bgfb014 OR cl_null(g_bgfb_m_t.bgfb014))) THEN
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bgfb_m.bgfb014,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb014
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb014 = g_bgfb_m_t.bgfb014
                     CALL s_desc_get_department_desc(g_bgfb_m.bgfb014) RETURNING g_bgfb_m.bgfb014_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb014_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bgfb_m.bgfb014,g_bgfb_m.bgfb007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_m.bgfb014
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb014 = g_bgfb_m_t.bgfb014
                     CALL s_desc_get_department_desc(g_bgfb_m.bgfb014) RETURNING g_bgfb_m.bgfb014_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb014_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb014
            #add-point:BEFORE FIELD bgfb014 name="input.b.bgfb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb014
            #add-point:ON CHANGE bgfb014 name="input.g.bgfb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb017
            
            #add-point:AFTER FIELD bgfb017 name="input.a.bgfb017"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb017
            CALL ap_ref_array2(g_ref_fields,"SELECT bgapl003 FROM bgapl_t WHERE bgaplent="||g_enterprise||" AND bgapl001=? AND bgapl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb017_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb017_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb017) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb017 != g_bgfb_m_t.bgfb017 OR cl_null(g_bgfb_m_t.bgfb017))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgfb_m.bgfb017,g_bgfb_m.bgfb007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb017
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb017 = g_bgfb_m_t.bgfb017
                     CALL s_desc_get_bgap001_desc(g_bgfb_m.bgfb017) RETURNING g_bgfb_m.bgfb017_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb017_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb017
            #add-point:BEFORE FIELD bgfb017 name="input.b.bgfb017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb017
            #add-point:ON CHANGE bgfb017 name="input.g.bgfb017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb020
            
            #add-point:AFTER FIELD bgfb020 name="input.a.bgfb020"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb020
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent="||g_enterprise||" AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb020_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb020_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb020) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb020 != g_bgfb_m_t.bgfb020 OR cl_null(g_bgfb_m_t.bgfb020))) THEN
                  CALL s_aap_project_chk(g_bgfb_m.bgfb020) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb020
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb020 = g_bgfb_m_t.bgfb020
                     CALL s_desc_get_oojdl003_desc(g_bgfb_m.bgfb020) RETURNING g_bgfb_m.bgfb020_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb020_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb020
            #add-point:BEFORE FIELD bgfb020 name="input.b.bgfb020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb020
            #add-point:ON CHANGE bgfb020 name="input.g.bgfb020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb023
            
            #add-point:AFTER FIELD bgfb023 name="input.a.bgfb023"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb023
            CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent="||g_enterprise||" AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb023_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb023_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb023) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb023 != g_bgfb_m_t.bgfb023 OR cl_null(g_bgfb_m_t.bgfb023))) THEN
                  CALL s_voucher_glaq052_chk(g_bgfb_m.bgfb023) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb023
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb023 = g_bgfb_m_t.bgfb023
                     CALL s_desc_get_oojdl003_desc(g_bgfb_m.bgfb023) RETURNING g_bgfb_m.bgfb023_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb023_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb023
            #add-point:BEFORE FIELD bgfb023 name="input.b.bgfb023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb023
            #add-point:ON CHANGE bgfb023 name="input.g.bgfb023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb012
            
            #add-point:AFTER FIELD bgfb012 name="input.a.bgfb012"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent="||g_enterprise||" AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb012_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb012_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb012) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb012 != g_bgfb_m_t.bgfb012 OR cl_null(g_bgfb_m_t.bgfb012))) THEN
                  #员工基础资料检查
                  CALL s_employee_chk(g_bgfb_m.bgfb012) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_m.bgfb012 = g_bgfb_m_t.bgfb012
                     CALL s_desc_get_person_desc(g_bgfb_m.bgfb012) RETURNING g_bgfb_m.bgfb012_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb012_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，人员在单头时，人员归属据点归属法人必须等于g_site归属法人
                  #其他情况，人员归属据点归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(1,g_bgfb_m.bgfb012,g_bgfb_m.bgfb007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_m.bgfb012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb012 = g_bgfb_m_t.bgfb012
                     CALL s_desc_get_person_desc(g_bgfb_m.bgfb012) RETURNING g_bgfb_m.bgfb012_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb012_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb012
            #add-point:BEFORE FIELD bgfb012 name="input.b.bgfb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb012
            #add-point:ON CHANGE bgfb012 name="input.g.bgfb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb015
            
            #add-point:AFTER FIELD bgfb015 name="input.a.bgfb015"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb015
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb015_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb015_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb015) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb015 != g_bgfb_m_t.bgfb015 OR cl_null(g_bgfb_m_t.bgfb015))) THEN
                  CALL s_azzi650_chk_exist('287',g_bgfb_m.bgfb015) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_m.bgfb015 = g_bgfb_m_t.bgfb015
                     CALL s_desc_get_acc_desc('287',g_bgfb_m.bgfb015) RETURNING g_bgfb_m.bgfb015_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb015_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb015
            #add-point:BEFORE FIELD bgfb015 name="input.b.bgfb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb015
            #add-point:ON CHANGE bgfb015 name="input.g.bgfb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb018
            
            #add-point:AFTER FIELD bgfb018 name="input.a.bgfb018"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='281' AND oocql002=? AND oocql003=? ","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb018_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb018_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb018) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb018 != g_bgfb_m_t.bgfb018 OR cl_null(g_bgfb_m_t.bgfb018))) THEN
                  CALL s_azzi650_chk_exist('281',g_bgfb_m.bgfb018) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_m.bgfb018 = g_bgfb_m_t.bgfb018
                     CALL s_desc_get_acc_desc('281',g_bgfb_m.bgfb018) RETURNING g_bgfb_m.bgfb018_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb018_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb018
            #add-point:BEFORE FIELD bgfb018 name="input.b.bgfb018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb018
            #add-point:ON CHANGE bgfb018 name="input.g.bgfb018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb021
            
            #add-point:AFTER FIELD bgfb021 name="input.a.bgfb021"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb020
            LET g_ref_fields[2] = g_bgfb_m.bgfb021
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent="||g_enterprise||" AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb021_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb021_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb021 != g_bgfb_m_t.bgfb021 OR cl_null(g_bgfb_m_t.bgfb021))) THEN
                  CALL s_voucher_glaq028_chk(g_bgfb_m.bgfb020,g_bgfb_m.bgfb021)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_m.bgfb021
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_m.bgfb021 = g_bgfb_m_t.bgfb021
                     CALL s_desc_get_wbs_desc(g_bgfb_m.bgfb020,g_bgfb_m.bgfb021) RETURNING g_bgfb_m.bgfb021_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb021_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb021
            #add-point:BEFORE FIELD bgfb021 name="input.b.bgfb021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb021
            #add-point:ON CHANGE bgfb021 name="input.g.bgfb021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb024
            
            #add-point:AFTER FIELD bgfb024 name="input.a.bgfb024"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgfb_m.bgfb024
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgfb_m.bgfb024_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgfb_m.bgfb024_desc_t
            IF NOT cl_null(g_bgfb_m.bgfb024) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgfb_m.bgfb024 != g_bgfb_m_t.bgfb024 OR cl_null(g_bgfb_m_t.bgfb024))) THEN
                  CALL s_azzi650_chk_exist('2002',g_bgfb_m.bgfb024) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_m.bgfb024 = g_bgfb_m_t.bgfb024
                     CALL s_desc_get_acc_desc('2002',g_bgfb_m.bgfb024) RETURNING g_bgfb_m.bgfb024_desc_t
                     DISPLAY BY NAME g_bgfb_m.bgfb024_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb024
            #add-point:BEFORE FIELD bgfb024 name="input.b.bgfb024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb024
            #add-point:ON CHANGE bgfb024 name="input.g.bgfb024"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb002
            #add-point:ON ACTION controlp INFIELD bgfb002 name="input.c.bgfb002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaa006 = '1' "
 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb002 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb002 TO bgfb002              #

            NEXT FIELD bgfb002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb003
            #add-point:ON ACTION controlp INFIELD bgfb003 name="input.c.bgfb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb004
            #add-point:ON ACTION controlp INFIELD bgfb004 name="input.c.bgfb004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='04' OR bgai005='00')" 
            IF NOT cl_null(g_bgfb_m.bgfb002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_bgfb_m.bgfb002,"' "
            END IF
 
            CALL q_bgai002()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb004 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb004 TO bgfb004              #

            NEXT FIELD bgfb004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb011
            #add-point:ON ACTION controlp INFIELD bgfb011 name="input.c.bgfb011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaw001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb011 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb011 TO bgfb011              #

            NEXT FIELD bgfb011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb001
            #add-point:ON ACTION controlp INFIELD bgfb001 name="input.c.bgfb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb005
            #add-point:ON ACTION controlp INFIELD bgfb005 name="input.c.bgfb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb006
            #add-point:ON ACTION controlp INFIELD bgfb006 name="input.c.bgfb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb010
            #add-point:ON ACTION controlp INFIELD bgfb010 name="input.c.bgfb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbstus
            #add-point:ON ACTION controlp INFIELD bgfbstus name="input.c.bgfbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007
            #add-point:ON ACTION controlp INFIELD bgfb007 name="input.c.bgfb007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb007             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,'04') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb007 = g_qryparam.return1              
            #LET g_bgfb_m.ooef001 = g_qryparam.return2 
            DISPLAY g_bgfb_m.bgfb007 TO bgfb007              #
            #DISPLAY g_bgfb_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD bgfb007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb013
            #add-point:ON ACTION controlp INFIELD bgfb013 name="input.c.bgfb013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET l_ooef001 = g_bgfb_m.bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               LET l_ooef001 = g_site
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "
            
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb013 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb013 TO bgfb013              #

            NEXT FIELD bgfb013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb016
            #add-point:ON ACTION controlp INFIELD bgfb016 name="input.c.bgfb016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            #当预算组织在单头
            IF g_bgaw1[1]='Y'  THEN
               LET l_bgfb007 = g_bgfb_m.bgfb007
            ELSE
               LET l_bgfb007 = g_site
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgfb007,"')"
 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb016 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb016 TO bgfb016              #

            NEXT FIELD bgfb016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb019
            #add-point:ON ACTION controlp INFIELD bgfb019 name="input.c.bgfb019"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb019 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb019 TO bgfb019              #

            NEXT FIELD bgfb019                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb022
            #add-point:ON ACTION controlp INFIELD bgfb022 name="input.c.bgfb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb009
            #add-point:ON ACTION controlp INFIELD bgfb009 name="input.c.bgfb009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            IF NOT cl_null(g_bgfb_m.bgfb002) THEN
               SELECT bgaa008 INTO g_bgaa008 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
               LET g_qryparam.where=" bgae006 = '",g_bgaa008,"'",
                                    " AND bgae001 IN (SELECT bgal003 FROM bgal_t ",
                                    "                  WHERE bgalent=",g_enterprise," AND bgal001='",g_bgfb_m.bgfb002,"'"
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET g_qryparam.where=g_qryparam.where," AND bgal002='",g_bgfb_m.bgfb007,"'"
               END IF
               LET g_qryparam.where=g_qryparam.where," )"
            END IF
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where=" bgae008='",g_bgfb_m.bgfb005,"'"
            ELSE
               LET g_qryparam.where=g_qryparam.where," AND bgae008='",g_bgfb_m.bgfb005,"'"
            END IF
 
            CALL q_bgae001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb009 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb009 TO bgfb009              #

            NEXT FIELD bgfb009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb014
            #add-point:ON ACTION controlp INFIELD bgfb014 name="input.c.bgfb014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET l_ooef001 = g_bgfb_m.bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               LET l_ooef001 = g_site
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "
 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb014 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb014 TO bgfb014              #

            NEXT FIELD bgfb014                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb017
            #add-point:ON ACTION controlp INFIELD bgfb017 name="input.c.bgfb017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            #当预算组织在单头
            IF g_bgaw1[1]='Y' THEN
               LET l_bgfb007 = g_bgfb_m.bgfb007
            ELSE
               LET l_bgfb007 = g_site
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgfb007,"')"
 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb017 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb017 TO bgfb017              #

            NEXT FIELD bgfb017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb020
            #add-point:ON ACTION controlp INFIELD bgfb020 name="input.c.bgfb020"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb020 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb020 TO bgfb020              #

            NEXT FIELD bgfb020                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb023
            #add-point:ON ACTION controlp INFIELD bgfb023 name="input.c.bgfb023"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb023 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb023 TO bgfb023              #

            NEXT FIELD bgfb023                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb012
            #add-point:ON ACTION controlp INFIELD bgfb012 name="input.c.bgfb012"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET l_ooef001 = g_bgfb_m.bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               LET l_ooef001 = g_site
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooag004 IN (SELECT ooef001 FROM ooef_t ",
                                   "              WHERE ooefent=",g_enterprise,
                                   "                AND ooef017='",l_ooef017,"' ",
                                   "             )"
 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb012 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb012 TO bgfb012              #

            NEXT FIELD bgfb012                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb015
            #add-point:ON ACTION controlp INFIELD bgfb015 name="input.c.bgfb015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb015             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb015 = g_qryparam.return1              
            #LET g_bgfb_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_m.bgfb015 TO bgfb015              #
            #DISPLAY g_bgfb_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb018
            #add-point:ON ACTION controlp INFIELD bgfb018 name="input.c.bgfb018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb018             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb018 = g_qryparam.return1              
            #LET g_bgfb_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_m.bgfb018 TO bgfb018              #
            #DISPLAY g_bgfb_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb021
            #add-point:ON ACTION controlp INFIELD bgfb021 name="input.c.bgfb021"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            IF NOT cl_null(g_bgfb_m.bgfb020) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bgfb_m.bgfb020,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb021 = g_qryparam.return1              

            DISPLAY g_bgfb_m.bgfb021 TO bgfb021              #

            NEXT FIELD bgfb021                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgfb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb024
            #add-point:ON ACTION controlp INFIELD bgfb024 name="input.c.bgfb024"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_m.bgfb024             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgfb_m.bgfb024 = g_qryparam.return1              
            #LET g_bgfb_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_m.bgfb024 TO bgfb024              #
            #DISPLAY g_bgfb_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb024                          #返回原欄位



            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bgfb_m.bgfb001             
                            ,g_bgfb_m.bgfb002   
                            ,g_bgfb_m.bgfb003   
                            ,g_bgfb_m.bgfb004   
                            ,g_bgfb_m.bgfb005   
                            ,g_bgfb_m.bgfb006   
                            ,g_bgfb_m.bgfb007   
                            ,g_bgfb_m.bgfb009   
                            ,g_bgfb_m.bgfb010   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
            #预算组织检核
            IF g_bgaw1[1]='Y' THEN
               #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
               #2.檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_bgfb_m.bgfb007,'04')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_bgfb_m.bgfb007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgfb_m.bgfb007 = g_bgfb_m_t.bgfb007
                  CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
                  DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
                  NEXT FIELD bgfb007
               END IF
            END IF
             
            #预算细项检核
            IF g_bgaw1[2]='Y' THEN
               CALL s_abg2_bgal003_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_bgfb_m.bgfb009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgfb_m.bgfb009 = g_bgfb_m_t.bgfb009
                  NEXT FIELD bgfb009
               END IF
               #预算细项权限检查abgi090
               CALL s_abg2_bgai006_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,g_bgfb_m.bgfb007,'04',g_bgfb_m.bgfb009)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =l_bgea004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgfb_m.bgfb009 = g_bgfb_m_t.bgfb009
                  NEXT FIELD bgfb009
               END IF
            END IF
            
            #主鍵檢查
            IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
               AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t)  
                                  )
               ) THEN 
                  CALL s_abgt620_head_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                             g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgfb002
                  END IF
               END IF
            END IF
            
         IF 1=2 THEN
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgt620_bgfb_t_mask_restore('restore_mask_o')
            
               UPDATE bgfb_t SET (bgfb002,bgfb003,bgfb004,bgfb011,bgfb001,bgfb005,bgfb006,bgfb010,bgfbstus, 
                   bgfb007,bgfb013,bgfb016,bgfb019,bgfb022,bgfb009,bgfb014,bgfb017,bgfb020,bgfb023,bgfb012, 
                   bgfb015,bgfb018,bgfb021,bgfb024) = (g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
                   g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb010, 
                   g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019, 
                   g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020, 
                   g_bgfb_m.bgfb023,g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021, 
                   g_bgfb_m.bgfb024)
                WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb001_t
                  AND bgfb002 = g_bgfb002_t
                  AND bgfb003 = g_bgfb003_t
                  AND bgfb004 = g_bgfb004_t
                  AND bgfb005 = g_bgfb005_t
                  AND bgfb006 = g_bgfb006_t
                  AND bgfb007 = g_bgfb007_t
                  AND bgfb009 = g_bgfb009_t
                  AND bgfb010 = g_bgfb010_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgfb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgfb_m.bgfb001
               LET gs_keys_bak[1] = g_bgfb001_t
               LET gs_keys[2] = g_bgfb_m.bgfb002
               LET gs_keys_bak[2] = g_bgfb002_t
               LET gs_keys[3] = g_bgfb_m.bgfb003
               LET gs_keys_bak[3] = g_bgfb003_t
               LET gs_keys[4] = g_bgfb_m.bgfb004
               LET gs_keys_bak[4] = g_bgfb004_t
               LET gs_keys[5] = g_bgfb_m.bgfb005
               LET gs_keys_bak[5] = g_bgfb005_t
               LET gs_keys[6] = g_bgfb_m.bgfb006
               LET gs_keys_bak[6] = g_bgfb006_t
               LET gs_keys[7] = g_bgfb_m.bgfb007
               LET gs_keys_bak[7] = g_bgfb007_t
               LET gs_keys[8] = g_bgfb_m.bgfb009
               LET gs_keys_bak[8] = g_bgfb009_t
               LET gs_keys[9] = g_bgfb_m.bgfb010
               LET gs_keys_bak[9] = g_bgfb010_t
               LET gs_keys[10] = g_bgfb_d[g_detail_idx].bgfb008
               LET gs_keys_bak[10] = g_bgfb_d_t.bgfb008
               LET gs_keys[11] = g_bgfb_d[g_detail_idx].bgfbseq
               LET gs_keys_bak[11] = g_bgfb_d_t.bgfbseq
               CALL abgt620_update_b('bgfb_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bgfb_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bgfb_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgt620_bgfb_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
            END IF
         END IF
         
            IF p_cmd = 'u' THEN
               #將遮罩欄位還原
               CALL abgt620_bgfb_t_mask_restore('restore_mask_o')
               
               #重写更新单头资料UPDATE
               LET l_success = TRUE
               CALL abgt620_update_head() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  INITIALIZE gs_keys TO NULL 
                  LET gs_keys[1] = g_bgfb_m.bgfb001
                  LET gs_keys_bak[1] = g_bgfb001_t
                  LET gs_keys[2] = g_bgfb_m.bgfb002
                  LET gs_keys_bak[2] = g_bgfb002_t
                  LET gs_keys[3] = g_bgfb_m.bgfb003
                  LET gs_keys_bak[3] = g_bgfb003_t
                  LET gs_keys[4] = g_bgfb_m.bgfb004
                  LET gs_keys_bak[4] = g_bgfb004_t
                  LET gs_keys[5] = g_bgfb_m.bgfb005
                  LET gs_keys_bak[5] = g_bgfb005_t
                  LET gs_keys[6] = g_bgfb_m.bgfb006
                  LET gs_keys_bak[6] = g_bgfb006_t
                  LET gs_keys[7] = g_bgfb_m.bgfb007
                  LET gs_keys_bak[7] = g_bgfb007_t
                  LET gs_keys[8] = g_bgfb_m.bgfb009
                  LET gs_keys_bak[8] = g_bgfb009_t
                  LET gs_keys[9] = g_bgfb_d[g_detail_idx].bgfb008
                  LET gs_keys_bak[9] = g_bgfb_d_t.bgfb008
                  LET gs_keys[10] = g_bgfb_d[g_detail_idx].bgfb010
                  LET gs_keys_bak[10] = g_bgfb_d_t.bgfb010
                  LET gs_keys[11] = g_bgfb_d[g_detail_idx].bgfbseq
                  LET gs_keys_bak[11] = g_bgfb_d_t.bgfbseq
                  CALL abgt620_update_b('bgfb_t',gs_keys,gs_keys_bak,"'1'")
                  CALL s_transaction_end('Y','0')
               END IF
               #將遮罩欄位進行遮蔽
               CALL abgt620_bgfb_t_mask_restore('restore_mask_n')
            ELSE 
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgt620_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bgfb001_t = g_bgfb_m.bgfb001
           LET g_bgfb002_t = g_bgfb_m.bgfb002
           LET g_bgfb003_t = g_bgfb_m.bgfb003
           LET g_bgfb004_t = g_bgfb_m.bgfb004
           LET g_bgfb005_t = g_bgfb_m.bgfb005
           LET g_bgfb006_t = g_bgfb_m.bgfb006
           LET g_bgfb007_t = g_bgfb_m.bgfb007
           LET g_bgfb009_t = g_bgfb_m.bgfb009
           LET g_bgfb010_t = g_bgfb_m.bgfb010
 
           
           IF g_bgfb_d.getLength() = 0 THEN
              NEXT FIELD bgfb008
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgt620.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgfb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgfb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt620_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            #由于主键位置不确定在单头或单身，锁资料SQL不同，需重写
            IF 1=2 THEN
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgt620_cl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgt620_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt620_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgfb_d[l_ac].bgfb008 IS NOT NULL
               AND g_bgfb_d[l_ac].bgfbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgfb_d_t.* = g_bgfb_d[l_ac].*  #BACKUP
               LET g_bgfb_d_o.* = g_bgfb_d[l_ac].*  #BACKUP
               CALL abgt620_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgt620_set_no_entry_b(l_cmd)
               OPEN abgt620_bcl USING g_enterprise,g_bgfb_m.bgfb001,
                                                g_bgfb_m.bgfb002,
                                                g_bgfb_m.bgfb003,
                                                g_bgfb_m.bgfb004,
                                                g_bgfb_m.bgfb005,
                                                g_bgfb_m.bgfb006,
                                                g_bgfb_m.bgfb007,
                                                g_bgfb_m.bgfb009,
                                                g_bgfb_m.bgfb010,
 
                                                g_bgfb_d_t.bgfb008
                                                ,g_bgfb_d_t.bgfbseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt620_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt620_bcl INTO g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010,g_bgfb_d[l_ac].bgfb007, 
                      g_bgfb_d[l_ac].bgfb009,g_bgfb_d[l_ac].bgfb012,g_bgfb_d[l_ac].bgfb013,g_bgfb_d[l_ac].bgfb014, 
                      g_bgfb_d[l_ac].bgfb015,g_bgfb_d[l_ac].bgfb016,g_bgfb_d[l_ac].bgfb017,g_bgfb_d[l_ac].bgfb018, 
                      g_bgfb_d[l_ac].bgfb019,g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021,g_bgfb_d[l_ac].bgfb022, 
                      g_bgfb_d[l_ac].bgfb023,g_bgfb_d[l_ac].bgfb024,g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036, 
                      g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb008,g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048, 
                      g_bgfb2_d[l_ac].bgfbseq,g_bgfb2_d[l_ac].bgfbownid,g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid, 
                      g_bgfb2_d[l_ac].bgfbcrtdp,g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid, 
                      g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt, 
                      g_bgfb3_d[l_ac].bgfbseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgfb_d_t.bgfb008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgfb_d_mask_o[l_ac].* =  g_bgfb_d[l_ac].*
                  CALL abgt620_bgfb_t_mask()
                  LET g_bgfb_d_mask_n[l_ac].* =  g_bgfb_d[l_ac].*
                  
                  CALL abgt620_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            END IF
            
            #重写Before Row 段逻辑
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt620_idx_chk()
                        
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               
               CASE
                  #预算组织在单头 AND #预算细项在单头
                  WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
                     OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
                         g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009
                  #预算组织在单头 AND #预算细项在单身
                  WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
                     OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
                         g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007
                  #预算组织在单身 AND #预算细项在单头
                  WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
                     OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
                         g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb009
                  #预算组织在单身 AND #预算细项在单身
                  WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
                     OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
                         g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006
               END CASE
               #当错写为-404 表示没有定义锁单头abgt620_hcl 这中情况出现在，打开作业直接点新增，没有走fetch       
               IF STATUS = '-404' THEN
                  #重写单头锁资料sql
                  LET g_forupd_sql = " SELECT bgfb002,'',bgfb003,bgfb004,'','','',bgfb011,bgfb001,bgfb005,bgfb006,bgfbstus, 
                      gfb007,'',bgfb013,'',bgfb016,'',bgfb019,'',bgfb022,bgfb009,bgfb014,'',bgfb017,'',bgfb020,'', 
                      gfb023,'',bgfb012,'',bgfb015,'',bgfb018,'',bgfb021,'',bgfb024,''", 
                      " FROM bgfb_t",
                      " WHERE bgfbent= ? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND  
                          bgfb005=? AND bgfb006=? "
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     LET g_sql = g_sql," AND bgfb007='",g_bgfb_m.bgfb007,"' "
                  END IF
                  #预算细项在单头
                  IF g_bgaw1[2] = 'Y' THEN
                     LET g_sql = g_sql," AND bgfb009='",g_bgfb_m.bgfb009,"' "
                  END IF
                  LET g_sql = g_sql,"FOR UPDATE"
                  
                  LET g_sql = cl_sql_forupd(g_sql)                #轉換不同資料庫語法
                  LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
                  DECLARE abgt620_hcl2 CURSOR FROM g_sql                 # LOCK CURSOR
                  OPEN abgt620_hcl2 USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
                                          g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006
                  IF STATUS THEN 
                     CLOSE abgt620_hcl2
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN abgt620_hcl2:" 
                     LET g_errparam.code   = STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     RETURN
                  END IF
               ELSE
                  IF STATUS THEN 
                     CLOSE abgt620_hcl
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN abgt620_hcl:" 
                     LET g_errparam.code   = STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     RETURN
                  END IF
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgfb_d[l_ac].bgfb008 IS NOT NULL
               AND g_bgfb_d[l_ac].bgfb010 IS NOT NULL
               AND g_bgfb_d[l_ac].bgfbseq IS NOT NULL
               AND ((g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 IS NOT NULL) OR (g_bgaw2[1]='Y' AND g_bgfb_d[l_ac].bgfb007 IS NOT NULL))
               AND ((g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 IS NOT NULL) OR (g_bgaw2[2]='Y' AND g_bgfb_d[l_ac].bgfb009 IS NOT NULL))
            THEN
               LET l_cmd='u'
               LET g_bgfb_d_t.* = g_bgfb_d[l_ac].*  #BACKUP
               LET g_bgfb_d_o.* = g_bgfb_d[l_ac].*  #BACKUP
               CALL abgt620_set_entry_b(l_cmd)
               CALL abgt620_set_no_entry_b(l_cmd)
               
               #预算组织在单头
               IF g_bgaw1[1] = 'Y' THEN
                  LET l_bgfb007 = g_bgfb_m.bgfb007
               ELSE
                  LET l_bgfb007 = g_bgfb_d_t.bgfb007
               END IF
               
               #预算细项在单头
               IF g_bgaw1[2] = 'Y' THEN
                  LET l_bgfb009 = g_bgfb_m.bgfb009
               ELSE
                  LET l_bgfb009 = g_bgfb_d_t.bgfb009
               END IF
            
               OPEN abgt620_bcl USING g_enterprise,g_bgfb_m.bgfb001,
                                                g_bgfb_m.bgfb002,
                                                g_bgfb_m.bgfb003,
                                                g_bgfb_m.bgfb004,
                                                g_bgfb_m.bgfb005,
                                                g_bgfb_m.bgfb006,
                                                l_bgfb007,
                                                l_bgfb009,
                                                g_bgfb_d_t.bgfb010,
                                                g_bgfb_d_t.bgfbseq
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt620_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt620_bcl INTO g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010,g_bgfb_d[l_ac].bgfb007, 
                      g_bgfb_d[l_ac].bgfb009,g_bgfb_d[l_ac].bgfb012,g_bgfb_d[l_ac].bgfb013, 
                      g_bgfb_d[l_ac].bgfb014,g_bgfb_d[l_ac].bgfb015,g_bgfb_d[l_ac].bgfb016,g_bgfb_d[l_ac].bgfb017, 
                      g_bgfb_d[l_ac].bgfb018,g_bgfb_d[l_ac].bgfb019,g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021, 
                      g_bgfb_d[l_ac].bgfb022,g_bgfb_d[l_ac].bgfb023,g_bgfb_d[l_ac].bgfb024,g_bgfb_d[l_ac].bgfb035, 
                      g_bgfb_d[l_ac].bgfb036,g_bgfb_d[l_ac].bgfb100,#g_bgfb_d[l_ac].bgfb101, #161220-00036#1 mark bgfb101
                      g_bgfb_d[l_ac].bgfb008,g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,
                      g_bgfb2_d[l_ac].bgfbseq,g_bgfb2_d[l_ac].bgfbownid,g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid, 
                      g_bgfb2_d[l_ac].bgfbcrtdp,g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid, 
                      g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt, 
                      g_bgfb3_d[l_ac].bgfbseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgfb_d_t.bgfb008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgfb_d_mask_o[l_ac].* =  g_bgfb_d[l_ac].*
                  CALL abgt620_bgfb_t_mask()
                  LET g_bgfb_d_mask_n[l_ac].* =  g_bgfb_d[l_ac].*
                  
                  CALL abgt620_ref_show()
                  CALL cl_show_fld_cont()
                  
                  #设置单头启用核算项
                  CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_d[l_ac].bgfb007,g_bgfb_d[l_ac].bgfb009)
                  #设置单身启用核算项
                  CALL abgt620_set_detail_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_d[l_ac].bgfb007,g_bgfb_d[l_ac].bgfb009)
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            #end add-point  
            
 
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bgfb_d_t.* TO NULL
            INITIALIZE g_bgfb_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgfb_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgfb2_d[l_ac].bgfbownid = g_user
      LET g_bgfb2_d[l_ac].bgfbowndp = g_dept
      LET g_bgfb2_d[l_ac].bgfbcrtid = g_user
      LET g_bgfb2_d[l_ac].bgfbcrtdp = g_dept 
      LET g_bgfb2_d[l_ac].bgfbcrtdt = cl_get_current()
      LET g_bgfb2_d[l_ac].bgfbmodid = g_user
      LET g_bgfb2_d[l_ac].bgfbmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_bgfb_d[l_ac].amt1 = "0"
      LET g_bgfb_d[l_ac].amt2 = "0"
      LET g_bgfb_d[l_ac].amt3 = "0"
      LET g_bgfb_d[l_ac].amt4 = "0"
      LET g_bgfb_d[l_ac].amt5 = "0"
      LET g_bgfb_d[l_ac].amt6 = "0"
      LET g_bgfb_d[l_ac].amt7 = "0"
      LET g_bgfb_d[l_ac].amt8 = "0"
      LET g_bgfb_d[l_ac].amt9 = "0"
      LET g_bgfb_d[l_ac].amt10 = "0"
      LET g_bgfb_d[l_ac].amt11 = "0"
      LET g_bgfb_d[l_ac].amt12 = "0"
      LET g_bgfb_d[l_ac].amt13 = "0"
      LET g_bgfb_d[l_ac].bgfb008 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_bgfb_d_t.* = g_bgfb_d[l_ac].*     #新輸入資料
            LET g_bgfb_d_o.* = g_bgfb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt620_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgt620_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgfb_d[li_reproduce_target].* = g_bgfb_d[li_reproduce].*
               LET g_bgfb2_d[li_reproduce_target].* = g_bgfb2_d[li_reproduce].*
               LET g_bgfb3_d[li_reproduce_target].* = g_bgfb3_d[li_reproduce].*
 
               LET g_bgfb_d[g_bgfb_d.getLength()].bgfb008 = NULL
               LET g_bgfb_d[g_bgfb_d.getLength()].bgfbseq = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #项次
            IF g_bgfb_d[l_ac].bgfbseq IS NULL OR g_bgfb_d[l_ac].bgfbseq = 0 THEN
               LET l_sql = "SELECT MAX(bgfbseq)+1 FROM bgfb_t ",
                           " WHERE bgfbent=",g_enterprise,
                           "   AND bgfb001='",g_bgfb_m.bgfb001,"'",
                           "   AND bgfb002='",g_bgfb_m.bgfb002,"'",
                           "   AND bgfb003='",g_bgfb_m.bgfb003,"'",
                           "   AND bgfb004='",g_bgfb_m.bgfb004,"'",
                           "   AND bgfb005='",g_bgfb_m.bgfb005,"'",
                           "   AND bgfb006='",g_bgfb_m.bgfb006,"'"
               #预算组织在单头
               IF g_bgaw1[1] = 'Y' THEN
                  LET l_sql = l_sql," AND bgfb007='",g_bgfb_m.bgfb007,"'"
               END IF
               #预算细项在单头
               IF g_bgaw1[2] = 'Y' THEN
                  LET l_sql = l_sql," AND bgfb009='",g_bgfb_m.bgfb009,"'"
               END IF
               PREPARE abgt620_seq_pr FROM l_sql
               EXECUTE abgt620_seq_pr INTO g_bgfb_d[l_ac].bgfbseq
               IF g_bgfb_d[l_ac].bgfbseq IS NULL THEN
                  LET g_bgfb_d[l_ac].bgfbseq = 1
               END IF
            END IF
            
            #交易币别、汇率
            LET g_bgfb_d[l_ac].bgfb100=g_bgfb_m.bgaa003
#            LET g_bgfb_d[l_ac].bgfb101=1 #161220-00036#1 mark
            
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               LET g_bgfb_d[l_ac].bgfb007 = g_bgfb_m.bgfb007
            END IF
            
            #上层组织
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb007) THEN
               SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
                WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
               IF cl_null(l_bgaa010) THEN
                  LET g_bgfb_d[l_ac].bgfb047 = g_bgfb_d[l_ac].bgfb007
               ELSE
                  SELECT ooed005 INTO g_bgfb_d[l_ac].bgfb047 FROM ooed_t
                   WHERE ooedent=g_enterprise AND ooed001='4'
                     AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                     AND ooed004=g_bgfb_d[l_ac].bgfb007
                  IF cl_null(g_bgfb_d[l_ac].bgfb047) THEN
                     LET g_bgfb_d[l_ac].bgfb047 = g_bgfb_d[l_ac].bgfb007
                  END IF
               END IF
            END IF
            
            #预算细项在单头
            IF g_bgaw1[2] = 'Y' THEN
               LET g_bgfb_d[l_ac].bgfb009 = g_bgfb_m.bgfb009
            END IF
            
            #预算组织、预算细项都在单头
            IF g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' THEN
               #设置单身启用核算项
               CALL abgt620_set_detail_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009)
            END IF
            
            
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            #重写新增
            IF 1=2 THEN
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bgfb_t 
             WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb_m.bgfb001
               AND bgfb002 = g_bgfb_m.bgfb002
               AND bgfb003 = g_bgfb_m.bgfb003
               AND bgfb004 = g_bgfb_m.bgfb004
               AND bgfb005 = g_bgfb_m.bgfb005
               AND bgfb006 = g_bgfb_m.bgfb006
               AND bgfb007 = g_bgfb_m.bgfb007
               AND bgfb009 = g_bgfb_m.bgfb009
               AND bgfb010 = g_bgfb_m.bgfb010
 
               AND bgfb008 = g_bgfb_d[l_ac].bgfb008
               AND bgfbseq = g_bgfb_d[l_ac].bgfbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO bgfb_t
                           (bgfbent,
                            bgfb002,bgfb003,bgfb004,bgfb011,bgfb001,bgfb005,bgfb006,bgfb010,bgfbstus,bgfb007,bgfb013,bgfb016,bgfb019,bgfb022,bgfb009,bgfb014,bgfb017,bgfb020,bgfb023,bgfb012,bgfb015,bgfb018,bgfb021,bgfb024,
                            bgfb008,bgfbseq
                            ,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,bgfb100,bgfb047,bgfb048,bgfbownid,bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt) 
                     VALUES(g_enterprise,
                            g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019,g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023,g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,
                            g_bgfb_d[l_ac].bgfb008,g_bgfb_d[l_ac].bgfbseq
                            ,g_bgfb_d[l_ac].bgfb012,g_bgfb_d[l_ac].bgfb013,g_bgfb_d[l_ac].bgfb014,g_bgfb_d[l_ac].bgfb015, 
                                g_bgfb_d[l_ac].bgfb016,g_bgfb_d[l_ac].bgfb017,g_bgfb_d[l_ac].bgfb018, 
                                g_bgfb_d[l_ac].bgfb019,g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021, 
                                g_bgfb_d[l_ac].bgfb022,g_bgfb_d[l_ac].bgfb023,g_bgfb_d[l_ac].bgfb024, 
                                g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036,g_bgfb_d[l_ac].bgfb100, 
                                g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,g_bgfb2_d[l_ac].bgfbownid, 
                                g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid,g_bgfb2_d[l_ac].bgfbcrtdp, 
                                g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid,g_bgfb2_d[l_ac].bgfbmoddt, 
                                g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgfb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            END IF
            
            #主键检查
            #组合key bgfb010
            CALL abgt620_get_bgfb010()
            
            #预算组织在单头
            IF g_bgaw1[1]='Y' THEN 
               LET l_bgfb007 = g_bgfb_m.bgfb007
            ELSE
               LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
            END IF
            #预算细项在单头
            IF g_bgaw1[2]='Y' THEN 
               LET l_bgfb009 = g_bgfb_m.bgfb009
            ELSE
               LET l_bgfb009 = g_bgfb_d[l_ac].bgfb009
            END IF
            CALL s_abgt620_detail_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                          g_bgfb_m.bgfb006,l_bgfb007,l_bgfb009,g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010)
            RETURNING l_success
            IF l_success = FALSE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00004'
               LET g_errparam.extend =g_bgfb_d[l_ac].bgfbseq
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD bgfbseq
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bgfb_t 
             WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb_m.bgfb001
               AND bgfb002 = g_bgfb_m.bgfb002
               AND bgfb003 = g_bgfb_m.bgfb003
               AND bgfb004 = g_bgfb_m.bgfb004
               AND bgfb005 = g_bgfb_m.bgfb005
               AND bgfb006 = g_bgfb_m.bgfb006
               AND bgfb007 = l_bgfb007
               AND bgfb009 = l_bgfb009
               AND bgfb010 = g_bgfb_d[l_ac].bgfb010
               AND bgfbseq = g_bgfb_d[l_ac].bgfbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #插入数据库
               CALL abgt620_insert_bgfb() RETURNING l_success

               IF l_success = FALSE  THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               ELSE
                  CALL s_transaction_end('Y','0')
                  #ERROR 'INSERT O.K'
                  LET g_rec_b=g_rec_b+1
                  DISPLAY g_rec_b TO FORMONLY.cnt
               END IF
               
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgfb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF abgt620_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bgfb_m.bgfb001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb002
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb003
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb004
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb005
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb006
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb007
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb009
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_m.bgfb010
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_d_t.bgfb008
                  LET gs_keys[gs_keys.getLength()+1] = g_bgfb_d_t.bgfbseq
 
 
                  #刪除下層單身
                  IF NOT abgt620_key_delete_b(gs_keys,'bgfb_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgt620_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgt620_bcl
               LET l_count = g_bgfb_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgfb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfbseq
            #add-point:BEFORE FIELD bgfbseq name="input.b.page1.bgfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfbseq
            
            #add-point:AFTER FIELD bgfbseq name="input.a.page1.bgfbseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  g_bgfb_m.bgfb001 IS NOT NULL AND g_bgfb_m.bgfb002 IS NOT NULL AND g_bgfb_m.bgfb003 IS NOT NULL AND g_bgfb_m.bgfb004 IS NOT NULL AND g_bgfb_m.bgfb005 IS NOT NULL AND g_bgfb_m.bgfb006 IS NOT NULL AND g_bgfb_m.bgfb007 IS NOT NULL AND g_bgfb_m.bgfb009 IS NOT NULL AND g_bgfb_d[g_detail_idx].bgfb008 IS NOT NULL AND g_bgfb_d[g_detail_idx].bgfb010 IS NOT NULL AND g_bgfb_d[g_detail_idx].bgfbseq IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t OR g_bgfb_m.bgfb002 != g_bgfb002_t OR g_bgfb_m.bgfb003 != g_bgfb003_t OR g_bgfb_m.bgfb004 != g_bgfb004_t OR g_bgfb_m.bgfb005 != g_bgfb005_t OR g_bgfb_m.bgfb006 != g_bgfb006_t OR g_bgfb_m.bgfb007 != g_bgfb007_t OR g_bgfb_m.bgfb009 != g_bgfb009_t OR g_bgfb_d[g_detail_idx].bgfb008 != g_bgfb_d_t.bgfb008 OR g_bgfb_d[g_detail_idx].bgfb010 != g_bgfb_d_t.bgfb010 OR g_bgfb_d[g_detail_idx].bgfbseq != g_bgfb_d_t.bgfbseq)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgfb_t WHERE "||"bgfbent = " ||g_enterprise|| " AND "||"bgfb001 = '"||g_bgfb_m.bgfb001 ||"' AND "|| "bgfb002 = '"||g_bgfb_m.bgfb002 ||"' AND "|| "bgfb003 = '"||g_bgfb_m.bgfb003 ||"' AND "|| "bgfb004 = '"||g_bgfb_m.bgfb004 ||"' AND "|| "bgfb005 = '"||g_bgfb_m.bgfb005 ||"' AND "|| "bgfb006 = '"||g_bgfb_m.bgfb006 ||"' AND "|| "bgfb007 = '"||g_bgfb_m.bgfb007 ||"' AND "|| "bgfb009 = '"||g_bgfb_m.bgfb009 ||"' AND "|| "bgfb008 = '"||g_bgfb_d[g_detail_idx].bgfb008 ||"' AND "|| "bgfb010 = '"||g_bgfb_d[g_detail_idx].bgfb010 ||"' AND "|| "bgfbseq = '"||g_bgfb_d[g_detail_idx].bgfbseq ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #主鍵檢查
            IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
               AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
               AND NOT cl_null(g_bgfb_d[l_ac].bgfbseq)
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb007)))
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb009)))
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                  OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                  OR ((g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t ) OR (g_bgaw2[1]='Y' AND g_bgfb_d[l_ac].bgfb007!=g_bgfb_d_t.bgfb007))
                                  OR ((g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t ) OR (g_bgaw2[2]='Y' AND g_bgfb_d[l_ac].bgfb009!=g_bgfb_d_t.bgfb009)) 
                                  )
               ) THEN 
                  #组合key bgfb010
                  CALL abgt620_get_bgfb010()
                  
                  #预算组织在单头
                  IF g_bgaw1[1]='Y' THEN 
                     LET l_bgfb007 = g_bgfb_m.bgfb007
                  ELSE
                     LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
                  END IF
                  #预算细项在单头
                  IF g_bgaw1[2]='Y' THEN 
                     LET l_bgfb009 = g_bgfb_m.bgfb009
                  ELSE
                     LET l_bgfb009 = g_bgfb_d[l_ac].bgfb009
                  END IF
                  
                  CALL s_abgt620_detail_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                g_bgfb_m.bgfb006,l_bgfb007,l_bgfb009,g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfbseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfbseq = g_bgfb_d_t.bgfbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfbseq
            #add-point:ON CHANGE bgfbseq name="input.g.page1.bgfbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb010_2
            #add-point:BEFORE FIELD bgfb010_2 name="input.b.page1.bgfb010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb010_2
            
            #add-point:AFTER FIELD bgfb010_2 name="input.a.page1.bgfb010_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb010_2
            #add-point:ON CHANGE bgfb010_2 name="input.g.page1.bgfb010_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007_2
            #add-point:BEFORE FIELD bgfb007_2 name="input.b.page1.bgfb007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007_2
            
            #add-point:AFTER FIELD bgfb007_2 name="input.a.page1.bgfb007_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb007_2
            #add-point:ON CHANGE bgfb007_2 name="input.g.page1.bgfb007_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007_desc
            #add-point:BEFORE FIELD bgfb007_desc name="input.b.page1.bgfb007_desc"
            LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d[l_ac].bgfb007
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007_desc
            
            #add-point:AFTER FIELD bgfb007_desc name="input.a.page1.bgfb007_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb007_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb007_desc <> g_bgfb_d_t.bgfb007 OR cl_null(g_bgfb_d_t.bgfb007))) THEN
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgfb_d[l_ac].bgfb007_desc
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     #檢查失敗時後續處理
                     LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                     NEXT FIELD CURRENT
                  END IF
                 
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_bgfb_d[l_ac].bgfb007_desc,'04')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfb007_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                     NEXT FIELD CURRENT
                  END IF
                  
                  #检查预算编号+版本+预算管理组织+销售方式下预算组织或预算上层组织是否已存在汇总资料abgt630，如果存在，不可录入
                  IF NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) AND
                     NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) THEN
                     #预算组织是否存在汇总资料
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM bgfb_t
                      WHERE bgfbent=g_enterprise AND bgfb001='30'
                        AND bgfb002=g_bgfb_m.bgfb002 AND bgfb003=g_bgfb_m.bgfb003
                        AND bgfb004=g_bgfb_m.bgfb004 AND bgfb005=g_bgfb_m.bgfb005
                        AND bgfb006='2' AND bgfb007 = g_bgfb_d[l_ac].bgfb007_desc
                        AND bgfbstus<>'X'
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00231'
                        LET g_errparam.extend =g_bgfb_d[l_ac].bgfb007_desc
                        #161215-00014#3--mod--str--
#                        LET g_errparam.replace[1] = 'abgt630'
#                        LET g_errparam.replace[2] = cl_get_progname('abgt630',g_lang,"2")
                        LET g_errparam.replace[1] = cl_get_progname('abgt630',g_lang,"2")
                        #161215-00014#3--mod--end
                        LET g_errparam.exeprog = 'abgt630'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                        NEXT FIELD CURRENT
                     END IF
                     #预算组织的上层组织是否存在汇总资料
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
                     #抓取上层组织
                     IF NOT cl_null(l_bgaa010) THEN
                        SELECT ooed005 INTO l_ooed005 FROM ooed_t
                          WHERE ooedent=g_enterprise AND ooed001='4'
                            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                            AND ooed004=g_bgfb_d[l_ac].bgfb007_desc
                        IF NOT cl_null(l_ooed005) THEN
                           LET l_cnt = 0
                           SELECT COUNT(1) INTO l_cnt FROM bgfb_t
                            WHERE bgfbent=g_enterprise AND bgfb001='30'
                              AND bgfb002=g_bgfb_m.bgfb002 AND bgfb003=g_bgfb_m.bgfb003
                              AND bgfb004=g_bgfb_m.bgfb004 AND bgfb005=g_bgfb_m.bgfb005
                              AND bgfb006='2' AND bgfb007 = l_ooed005
                              AND bgfbstus<>'X'
                           IF l_cnt > 0 THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00232'
                              LET g_errparam.extend =g_bgfb_d[l_ac].bgfb007_desc
                              #161215-00014#3--mod--str--
#                              LET g_errparam.replace[1] = 'abgt630'
#                              LET g_errparam.replace[2] = cl_get_progname('abgt630',g_lang,"2")
                              LET g_errparam.replace[1] = cl_get_progname('abgt630',g_lang,"2")
                              #161215-00014#3--mod--end
                              LET g_errparam.exeprog = 'abgt630'
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
                     AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
                     AND NOT cl_null(g_bgfb_d[l_ac].bgfbseq)
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb007_desc)))
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb009)))
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                        OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                        OR ((g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t ) OR (g_bgaw2[1]='Y' AND g_bgfb_d[l_ac].bgfb007_desc!=g_bgfb_d_t.bgfb007 ))
                                        OR ((g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t ) OR (g_bgaw2[2]='Y' AND g_bgfb_d[l_ac].bgfb009!=g_bgfb_d_t.bgfb009)) 
                                        )
                     ) THEN
                        #组合key bgfb010
                        CALL abgt620_get_bgfb010()
                        
                        #预算细项在单头
                        IF g_bgaw1[2]='Y' THEN 
                           LET l_bgfb009 = g_bgfb_m.bgfb009
                        ELSE
                           LET l_bgfb009 = g_bgfb_d[l_ac].bgfb009
                        END IF
                        CALL s_abgt620_detail_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                      g_bgfb_m.bgfb006,g_bgfb_d[l_ac].bgfb007_desc,l_bgfb009,g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010)
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgfb_d[l_ac].bgfb007_desc
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  
                  IF g_bgaw1[2] = 'Y' THEN
                     IF NOT cl_null(g_bgfb_m.bgfb009) THEN
                        #预算细项权限检查abgi090
                        CALL s_abg2_bgai006_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,g_bgfb_d[l_ac].bgfb007_desc,'04',g_bgfb_m.bgfb009)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend =l_bgea004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                           NEXT FIELD CURRENT
                        END IF
                        
                        #设置单头启用核算项
                        CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_d[l_ac].bgfb007_desc,g_bgfb_m.bgfb009)
                        #设置单身启用核算项
                        CALL abgt620_set_detail_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_d[l_ac].bgfb007_desc,g_bgfb_m.bgfb009)
                     END IF
                  ELSE      
                     #预算细项在单身
                     IF NOT cl_null(g_bgfb_d[l_ac].bgfb009) THEN
                        #预算细项权限检查abgi090
                        CALL s_abg2_bgai006_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,g_bgfb_d[l_ac].bgfb007_desc,'04',g_bgfb_d[l_ac].bgfb009)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend =l_bgea004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d_t.bgfb007
                           NEXT FIELD CURRENT
                        END IF
                        
                        #设置单头启用核算项
                        CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_d[l_ac].bgfb007_desc,g_bgfb_d[l_ac].bgfb009)
                        #设置单身启用核算项
                        CALL abgt620_set_detail_hsx_entry(g_bgfb_m.bgfb002,g_bgfb_d[l_ac].bgfb007_desc,g_bgfb_d[l_ac].bgfb009)
                     END IF
                  END IF
                  
                  #上层组织
                  IF NOT cl_null(g_bgfb_d[l_ac].bgfb007_desc) THEN
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
                     IF cl_null(l_bgaa010) THEN
                        LET g_bgfb_d[l_ac].bgfb047 = g_bgfb_d[l_ac].bgfb007_desc
                     ELSE
                        SELECT ooed005 INTO g_bgfb_d[l_ac].bgfb047 FROM ooed_t
                         WHERE ooedent=g_enterprise AND ooed001='4'
                           AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                           AND ooed004=g_bgfb_d[l_ac].bgfb007_desc
                        IF cl_null(g_bgfb_d[l_ac].bgfb047) THEN
                           LET g_bgfb_d[l_ac].bgfb047 = g_bgfb_d[l_ac].bgfb007_desc
                        END IF
                     END IF
                  END IF
               END IF
               LET g_bgfb_d[l_ac].bgfb007 = g_bgfb_d[l_ac].bgfb007_desc
               CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb007) RETURNING g_bgfb_d[l_ac].bgfb007_desc
               LET g_bgfb_d[l_ac].bgfb007_desc = g_bgfb_d[l_ac].bgfb007,"  ",g_bgfb_d[l_ac].bgfb007_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb007 = g_bgfb_d[l_ac].bgfb007_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb007_desc
            #add-point:ON CHANGE bgfb007_desc name="input.g.page1.bgfb007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb009_2
            #add-point:BEFORE FIELD bgfb009_2 name="input.b.page1.bgfb009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb009_2
            
            #add-point:AFTER FIELD bgfb009_2 name="input.a.page1.bgfb009_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb009_2
            #add-point:ON CHANGE bgfb009_2 name="input.g.page1.bgfb009_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb009_desc
            #add-point:BEFORE FIELD bgfb009_desc name="input.b.page1.bgfb009_desc"
            LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d[l_ac].bgfb009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb009_desc
            
            #add-point:AFTER FIELD bgfb009_desc name="input.a.page1.bgfb009_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb009_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb009_desc <> g_bgfb_d_t.bgfb009 OR cl_null(g_bgfb_d_t.bgfb009))) THEN
                  #预算组织在单头
                  IF g_bgaw1[1]='Y' THEN 
                     LET l_bgfb007 = g_bgfb_m.bgfb007
                  ELSE
                     LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
                  END IF
                  #预算细项存在且有效性检核
                  CALL s_abg2_bgal003_chk(g_bgfb_m.bgfb002,l_bgfb007,g_bgfb_d[l_ac].bgfb009_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfb009_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d_t.bgfb009
                     NEXT FIELD CURRENT
                  END IF
                  #预算细项对应的费用分类要与单头的费用来源一致
                  SELECT bgae008 INTO l_bgae008 FROM bgae_t 
                   WHERE bgaeent=g_enterprise AND bgae006=g_bgaa008 AND bgae001=g_bgfb_d[l_ac].bgfb009_desc
                  IF l_bgae008 <> g_bgfb_m.bgfb005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00308'
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfb009_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d_t.bgfb009
                     NEXT FIELD CURRENT
                  END IF
                  #预算细项权限检查abgi090
                  CALL s_abg2_bgai006_chk(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,l_bgfb007,'04',l_bgea004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =l_bgea004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d_t.bgfb009
                     NEXT FIELD CURRENT
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgfb_m.bgfb001) AND NOT cl_null(g_bgfb_m.bgfb002) AND NOT cl_null(g_bgfb_m.bgfb003) 
                     AND NOT cl_null(g_bgfb_m.bgfb004) AND NOT cl_null(g_bgfb_m.bgfb005) AND NOT cl_null(g_bgfb_m.bgfb006) 
                     AND NOT cl_null(g_bgfb_d[l_ac].bgfbseq)
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb007)))
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgfb_m.bgfb009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb009_desc)))
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t 
                                        OR g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t 
                                        OR ((g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t ) OR (g_bgaw2[1]='Y' AND g_bgfb_d[l_ac].bgfb007!=g_bgfb_d_t.bgfb007 ))
                                        OR ((g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t ) OR (g_bgaw2[2]='Y' AND g_bgfb_d[l_ac].bgfb009_desc!=g_bgfb_d_t.bgfb009)) 
                                        )
                     ) THEN 
                        #组合key bgfb010
                        CALL abgt620_get_bgfb010()
                  
                        #预算组织在单头
                        IF g_bgaw1[1]='Y' THEN 
                           LET l_bgfb007 = g_bgfb_m.bgfb007
                        ELSE
                           LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
                        END IF
                        
                        CALL s_abgt620_detail_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                      g_bgfb_m.bgfb006,l_bgfb007,g_bgfb_d[l_ac].bgfb009_desc,g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010)
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgfb_d[l_ac].bgfb009_desc
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d_t.bgfb009
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #设置单头启用核算项
                  CALL abgt620_set_head_hsx_entry(g_bgfb_m.bgfb002,l_bgfb007,g_bgfb_d[l_ac].bgfb009)
                  #设置单身启用核算项
                  CALL abgt620_set_detail_hsx_entry(g_bgfb_m.bgfb002,l_bgfb007,g_bgfb_d[l_ac].bgfb009)             
               END IF
               LET g_bgfb_d[l_ac].bgfb009 = g_bgfb_d[l_ac].bgfb009_desc
               CALL s_abg_bgae001_desc(g_bgaa008,g_bgfb_d[l_ac].bgfb009) RETURNING g_bgfb_d[l_ac].bgfb009_desc
               LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d[l_ac].bgfb009,"  ",g_bgfb_d[l_ac].bgfb009_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb009 = g_bgfb_d[l_ac].bgfb009_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb009_desc
            #add-point:ON CHANGE bgfb009_desc name="input.g.page1.bgfb009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb012_2
            #add-point:BEFORE FIELD bgfb012_2 name="input.b.page1.bgfb012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb012_2
            
            #add-point:AFTER FIELD bgfb012_2 name="input.a.page1.bgfb012_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb012_2
            #add-point:ON CHANGE bgfb012_2 name="input.g.page1.bgfb012_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb012_desc
            #add-point:BEFORE FIELD bgfb012_desc name="input.b.page1.bgfb012_desc"
            LET g_bgfb_d[l_ac].bgfb012_desc = g_bgfb_d[l_ac].bgfb012
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb012_desc
            
            #add-point:AFTER FIELD bgfb012_desc name="input.a.page1.bgfb012_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb012_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb012_desc <> g_bgfb_d_t.bgfb012 OR cl_null(g_bgfb_d_t.bgfb012))) THEN
                  #员工基础资料检查
                  CALL s_employee_chk(g_bgfb_d[l_ac].bgfb012_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_d[l_ac].bgfb012_desc = g_bgfb_d_t.bgfb012
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，人员在单头时，人员归属据点归属法人必须等于g_site归属法人
                  #其他情况，人员归属据点归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(1,g_bgfb_d[l_ac].bgfb012_desc,g_bgfb_m.bgfb007)                  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(1,g_bgfb_d[l_ac].bgfb012_desc,g_bgfb_d[l_ac].bgfb007)
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfb012_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb012_desc = g_bgfb_d_t.bgfb012
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_bgfb_d[l_ac].bgfb012 = g_bgfb_d[l_ac].bgfb012_desc
               CALL s_desc_get_person_desc(g_bgfb_d[l_ac].bgfb012) RETURNING g_bgfb_d[l_ac].bgfb012_desc
               LET g_bgfb_d[l_ac].bgfb012_desc = g_bgfb_d[l_ac].bgfb012,"  ",g_bgfb_d[l_ac].bgfb012_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb012 = g_bgfb_d[l_ac].bgfb012_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb012_desc
            #add-point:ON CHANGE bgfb012_desc name="input.g.page1.bgfb012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb013_2
            #add-point:BEFORE FIELD bgfb013_2 name="input.b.page1.bgfb013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb013_2
            
            #add-point:AFTER FIELD bgfb013_2 name="input.a.page1.bgfb013_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb013_2
            #add-point:ON CHANGE bgfb013_2 name="input.g.page1.bgfb013_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb013_desc
            #add-point:BEFORE FIELD bgfb013_desc name="input.b.page1.bgfb013_desc"
            LET g_bgfb_d[l_ac].bgfb013_desc = g_bgfb_d[l_ac].bgfb013
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb013_desc
            
            #add-point:AFTER FIELD bgfb013_desc name="input.a.page1.bgfb013_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb013_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb013_desc <> g_bgfb_d_t.bgfb013 OR cl_null(g_bgfb_d_t.bgfb013))) THEN
                  #部门基础资料检核
                  CALL s_department_chk(g_bgfb_d[l_ac].bgfb013_desc,g_today) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_d[l_ac].bgfb013_desc = g_bgfb_d_t.bgfb013
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(2,g_bgfb_d[l_ac].bgfb013_desc,g_bgfb_m.bgfb007)  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(2,g_bgfb_d[l_ac].bgfb013_desc,g_bgfb_d[l_ac].bgfb007) 
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfb013_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb013_desc = g_bgfb_d_t.bgfb013
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #抓取部门对应利润中心
               IF g_bgaw2[4]='Y' AND cl_null(g_bgfb_d[l_ac].bgfb014) AND g_bgal.bgal006 = 'Y' THEN
                  SELECT ooeg004 INTO g_bgfb_d[l_ac].bgfb014 FROM ooeg_t
                   WHERE ooegent=g_enterprise AND ooeg001=g_bgfb_d[l_ac].bgfb013_desc
                  CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb014) RETURNING g_bgfb_d[l_ac].bgfb014_desc
                  LET g_bgfb_d[l_ac].bgfb014_desc = g_bgfb_d[l_ac].bgfb014,"  ",g_bgfb_d[l_ac].bgfb014_desc
               END IF
               LET g_bgfb_d[l_ac].bgfb013 = g_bgfb_d[l_ac].bgfb013_desc
               CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb013) RETURNING g_bgfb_d[l_ac].bgfb013_desc
               LET g_bgfb_d[l_ac].bgfb013_desc = g_bgfb_d[l_ac].bgfb013,"  ",g_bgfb_d[l_ac].bgfb013_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb013 = g_bgfb_d[l_ac].bgfb013_desc
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb013_desc
            #add-point:ON CHANGE bgfb013_desc name="input.g.page1.bgfb013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb014_2
            #add-point:BEFORE FIELD bgfb014_2 name="input.b.page1.bgfb014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb014_2
            
            #add-point:AFTER FIELD bgfb014_2 name="input.a.page1.bgfb014_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb014_2
            #add-point:ON CHANGE bgfb014_2 name="input.g.page1.bgfb014_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb014_desc
            #add-point:BEFORE FIELD bgfb014_desc name="input.b.page1.bgfb014_desc"
            LET g_bgfb_d[l_ac].bgfb014_desc = g_bgfb_d[l_ac].bgfb014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb014_desc
            
            #add-point:AFTER FIELD bgfb014_desc name="input.a.page1.bgfb014_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb014_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb014_desc <> g_bgfb_d_t.bgfb014 OR cl_null(g_bgfb_d_t.bgfb014))) THEN
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bgfb_d[l_ac].bgfb014_desc,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb014_desc
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb014_desc = g_bgfb_d_t.bgfb014
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(2,g_bgfb_d[l_ac].bgfb014_desc,g_bgfb_m.bgfb007)                  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(2,g_bgfb_d[l_ac].bgfb014_desc,g_bgfb_d[l_ac].bgfb007)
                  END IF  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfb014_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb014_desc = g_bgfb_d_t.bgfb014
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb014 = g_bgfb_d[l_ac].bgfb014_desc
               CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb014) RETURNING g_bgfb_d[l_ac].bgfb014_desc
               LET g_bgfb_d[l_ac].bgfb014_desc = g_bgfb_d[l_ac].bgfb014,"  ",g_bgfb_d[l_ac].bgfb014_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb014 = g_bgfb_d[l_ac].bgfb014_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb014_desc
            #add-point:ON CHANGE bgfb014_desc name="input.g.page1.bgfb014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb015_2
            #add-point:BEFORE FIELD bgfb015_2 name="input.b.page1.bgfb015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb015_2
            
            #add-point:AFTER FIELD bgfb015_2 name="input.a.page1.bgfb015_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb015_2
            #add-point:ON CHANGE bgfb015_2 name="input.g.page1.bgfb015_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb015_desc
            #add-point:BEFORE FIELD bgfb015_desc name="input.b.page1.bgfb015_desc"
            LET g_bgfb_d[l_ac].bgfb015_desc = g_bgfb_d[l_ac].bgfb015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb015_desc
            
            #add-point:AFTER FIELD bgfb015_desc name="input.a.page1.bgfb015_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb015_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb015_desc <> g_bgfb_d_t.bgfb015 OR cl_null(g_bgfb_d_t.bgfb015))) THEN
                  CALL s_azzi650_chk_exist('287',g_bgfb_d[l_ac].bgfb015_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_d[l_ac].bgfb015_desc = g_bgfb_d_t.bgfb015
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb015 = g_bgfb_d[l_ac].bgfb015_desc
               CALL s_desc_get_acc_desc('287',g_bgfb_d[l_ac].bgfb015) RETURNING g_bgfb_d[l_ac].bgfb015_desc
               LET g_bgfb_d[l_ac].bgfb015_desc = g_bgfb_d[l_ac].bgfb015,"  ",g_bgfb_d[l_ac].bgfb015_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb015 = g_bgfb_d[l_ac].bgfb015_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb015_desc
            #add-point:ON CHANGE bgfb015_desc name="input.g.page1.bgfb015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb016_2
            #add-point:BEFORE FIELD bgfb016_2 name="input.b.page1.bgfb016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb016_2
            
            #add-point:AFTER FIELD bgfb016_2 name="input.a.page1.bgfb016_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb016_2
            #add-point:ON CHANGE bgfb016_2 name="input.g.page1.bgfb016_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb016_desc
            #add-point:BEFORE FIELD bgfb016_desc name="input.b.page1.bgfb016_desc"
            LET g_bgfb_d[l_ac].bgfb016_desc = g_bgfb_d[l_ac].bgfb016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb016_desc
            
            #add-point:AFTER FIELD bgfb016_desc name="input.a.page1.bgfb016_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb016_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb016_desc <> g_bgfb_d_t.bgfb016 OR cl_null(g_bgfb_d_t.bgfb016))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgfb_d[l_ac].bgfb016_desc,g_bgfb_d[l_ac].bgfb007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb016_desc
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb016_desc = g_bgfb_d_t.bgfb016
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb016 = g_bgfb_d[l_ac].bgfb016_desc
               CALL s_desc_get_bgap001_desc(g_bgfb_d[l_ac].bgfb016) RETURNING g_bgfb_d[l_ac].bgfb016_desc
               LET g_bgfb_d[l_ac].bgfb016_desc = g_bgfb_d[l_ac].bgfb016,"  ",g_bgfb_d[l_ac].bgfb016_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb016 = g_bgfb_d[l_ac].bgfb016_desc
            END IF          
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb016_desc
            #add-point:ON CHANGE bgfb016_desc name="input.g.page1.bgfb016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb017_2
            #add-point:BEFORE FIELD bgfb017_2 name="input.b.page1.bgfb017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb017_2
            
            #add-point:AFTER FIELD bgfb017_2 name="input.a.page1.bgfb017_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb017_2
            #add-point:ON CHANGE bgfb017_2 name="input.g.page1.bgfb017_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb017_desc
            #add-point:BEFORE FIELD bgfb017_desc name="input.b.page1.bgfb017_desc"
            LET g_bgfb_d[l_ac].bgfb017_desc = g_bgfb_d[l_ac].bgfb017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb017_desc
            
            #add-point:AFTER FIELD bgfb017_desc name="input.a.page1.bgfb017_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb017_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb017_desc <> g_bgfb_d_t.bgfb017 OR cl_null(g_bgfb_d_t.bgfb017))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgfb_d[l_ac].bgfb017_desc,g_bgfb_d[l_ac].bgfb007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb017_desc
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb017_desc = g_bgfb_d_t.bgfb017
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb017 = g_bgfb_d[l_ac].bgfb017_desc
               CALL s_desc_get_bgap001_desc(g_bgfb_d[l_ac].bgfb017) RETURNING g_bgfb_d[l_ac].bgfb017_desc
               LET g_bgfb_d[l_ac].bgfb017_desc = g_bgfb_d[l_ac].bgfb017,"  ",g_bgfb_d[l_ac].bgfb017_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb017 = g_bgfb_d[l_ac].bgfb017_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb017_desc
            #add-point:ON CHANGE bgfb017_desc name="input.g.page1.bgfb017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb018_2
            #add-point:BEFORE FIELD bgfb018_2 name="input.b.page1.bgfb018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb018_2
            
            #add-point:AFTER FIELD bgfb018_2 name="input.a.page1.bgfb018_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb018_2
            #add-point:ON CHANGE bgfb018_2 name="input.g.page1.bgfb018_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb018_desc
            #add-point:BEFORE FIELD bgfb018_desc name="input.b.page1.bgfb018_desc"
            LET g_bgfb_d[l_ac].bgfb018_desc = g_bgfb_d[l_ac].bgfb018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb018_desc
            
            #add-point:AFTER FIELD bgfb018_desc name="input.a.page1.bgfb018_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb018_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb018_desc <> g_bgfb_d_t.bgfb018 OR cl_null(g_bgfb_d_t.bgfb018))) THEN
                  CALL s_azzi650_chk_exist('281',g_bgfb_d[l_ac].bgfb018_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_d[l_ac].bgfb018_desc = g_bgfb_d_t.bgfb018
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb018 = g_bgfb_d[l_ac].bgfb018_desc
               CALL s_desc_get_acc_desc('281',g_bgfb_d[l_ac].bgfb018) RETURNING g_bgfb_d[l_ac].bgfb018_desc
               LET g_bgfb_d[l_ac].bgfb018_desc = g_bgfb_d[l_ac].bgfb018,"  ",g_bgfb_d[l_ac].bgfb018_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb018 = g_bgfb_d[l_ac].bgfb018_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb018_desc
            #add-point:ON CHANGE bgfb018_desc name="input.g.page1.bgfb018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb019_2
            #add-point:BEFORE FIELD bgfb019_2 name="input.b.page1.bgfb019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb019_2
            
            #add-point:AFTER FIELD bgfb019_2 name="input.a.page1.bgfb019_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb019_2
            #add-point:ON CHANGE bgfb019_2 name="input.g.page1.bgfb019_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb019_desc
            #add-point:BEFORE FIELD bgfb019_desc name="input.b.page1.bgfb019_desc"
            LET g_bgfb_d[l_ac].bgfb019_desc = g_bgfb_d[l_ac].bgfb019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb019_desc
            
            #add-point:AFTER FIELD bgfb019_desc name="input.a.page1.bgfb019_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb019_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb019_desc <> g_bgfb_d_t.bgfb019 OR cl_null(g_bgfb_d_t.bgfb019))) THEN
                  CALL s_voucher_glaq024_chk(g_bgfb_d[l_ac].bgfb019_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb019_desc
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb019_desc = g_bgfb_d_t.bgfb019
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb019 = g_bgfb_d[l_ac].bgfb019_desc
               CALL s_desc_get_rtaxl003_desc(g_bgfb_d[l_ac].bgfb019) RETURNING g_bgfb_d[l_ac].bgfb019_desc
               LET g_bgfb_d[l_ac].bgfb019_desc = g_bgfb_d[l_ac].bgfb019,"  ",g_bgfb_d[l_ac].bgfb019_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb019 = g_bgfb_d[l_ac].bgfb019_desc
            END IF       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb019_desc
            #add-point:ON CHANGE bgfb019_desc name="input.g.page1.bgfb019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb020_2
            #add-point:BEFORE FIELD bgfb020_2 name="input.b.page1.bgfb020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb020_2
            
            #add-point:AFTER FIELD bgfb020_2 name="input.a.page1.bgfb020_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb020_2
            #add-point:ON CHANGE bgfb020_2 name="input.g.page1.bgfb020_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb020_desc
            #add-point:BEFORE FIELD bgfb020_desc name="input.b.page1.bgfb020_desc"
            LET g_bgfb_d[l_ac].bgfb020_desc = g_bgfb_d[l_ac].bgfb020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb020_desc
            
            #add-point:AFTER FIELD bgfb020_desc name="input.a.page1.bgfb020_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb020_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb020_desc <> g_bgfb_d_t.bgfb020 OR cl_null(g_bgfb_d_t.bgfb020))) THEN
                  CALL s_aap_project_chk(g_bgfb_d[l_ac].bgfb020_desc) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb020_desc
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb020_desc = g_bgfb_d_t.bgfb020
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_bgfb_d[l_ac].bgfb020 = g_bgfb_d[l_ac].bgfb020_desc
               CALL s_desc_get_oojdl003_desc(g_bgfb_d[l_ac].bgfb020) RETURNING g_bgfb_d[l_ac].bgfb020_desc
               LET g_bgfb_d[l_ac].bgfb020_desc = g_bgfb_d[l_ac].bgfb020,"  ",g_bgfb_d[l_ac].bgfb020_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb020 = g_bgfb_d[l_ac].bgfb020_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb020_desc
            #add-point:ON CHANGE bgfb020_desc name="input.g.page1.bgfb020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb021_2
            #add-point:BEFORE FIELD bgfb021_2 name="input.b.page1.bgfb021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb021_2
            
            #add-point:AFTER FIELD bgfb021_2 name="input.a.page1.bgfb021_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb021_2
            #add-point:ON CHANGE bgfb021_2 name="input.g.page1.bgfb021_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb021_desc
            #add-point:BEFORE FIELD bgfb021_desc name="input.b.page1.bgfb021_desc"
            LET g_bgfb_d[l_ac].bgfb021_desc = g_bgfb_d[l_ac].bgfb021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb021_desc
            
            #add-point:AFTER FIELD bgfb021_desc name="input.a.page1.bgfb021_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb021_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb021_desc <> g_bgfb_d_t.bgfb021 OR cl_null(g_bgfb_d_t.bgfb021))) THEN
                  CALL s_voucher_glaq028_chk(g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb021_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb021_desc = g_bgfb_d_t.bgfb021
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb021 = g_bgfb_d[l_ac].bgfb021_desc
               CALL s_desc_get_wbs_desc(g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021) RETURNING g_bgfb_d[l_ac].bgfb021_desc
               LET g_bgfb_d[l_ac].bgfb021_desc = g_bgfb_d[l_ac].bgfb021,"  ",g_bgfb_d[l_ac].bgfb021_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb021 = g_bgfb_d[l_ac].bgfb021_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb021_desc
            #add-point:ON CHANGE bgfb021_desc name="input.g.page1.bgfb021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb022_2
            #add-point:BEFORE FIELD bgfb022_2 name="input.b.page1.bgfb022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb022_2
            
            #add-point:AFTER FIELD bgfb022_2 name="input.a.page1.bgfb022_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb022_2
            #add-point:ON CHANGE bgfb022_2 name="input.g.page1.bgfb022_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb023_2
            #add-point:BEFORE FIELD bgfb023_2 name="input.b.page1.bgfb023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb023_2
            
            #add-point:AFTER FIELD bgfb023_2 name="input.a.page1.bgfb023_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb023_2
            #add-point:ON CHANGE bgfb023_2 name="input.g.page1.bgfb023_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb023_desc
            #add-point:BEFORE FIELD bgfb023_desc name="input.b.page1.bgfb023_desc"
            LET g_bgfb_d[l_ac].bgfb023_desc = g_bgfb_d[l_ac].bgfb023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb023_desc
            
            #add-point:AFTER FIELD bgfb023_desc name="input.a.page1.bgfb023_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb023_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb023_desc <> g_bgfb_d_t.bgfb023 OR cl_null(g_bgfb_d_t.bgfb023))) THEN
                  CALL s_voucher_glaq052_chk(g_bgfb_d[l_ac].bgfb023_desc) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgfb_d[l_ac].bgfb023_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgfb_d[l_ac].bgfb023_desc = g_bgfb_d_t.bgfb023
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb023 = g_bgfb_d[l_ac].bgfb023_desc
               CALL s_desc_get_oojdl003_desc(g_bgfb_d[l_ac].bgfb023) RETURNING g_bgfb_d[l_ac].bgfb023_desc
               LET g_bgfb_d[l_ac].bgfb023_desc = g_bgfb_d[l_ac].bgfb023,"  ",g_bgfb_d[l_ac].bgfb023_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb023 = g_bgfb_d[l_ac].bgfb023_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb023_desc
            #add-point:ON CHANGE bgfb023_desc name="input.g.page1.bgfb023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb024_2
            #add-point:BEFORE FIELD bgfb024_2 name="input.b.page1.bgfb024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb024_2
            
            #add-point:AFTER FIELD bgfb024_2 name="input.a.page1.bgfb024_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb024_2
            #add-point:ON CHANGE bgfb024_2 name="input.g.page1.bgfb024_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb024_desc
            #add-point:BEFORE FIELD bgfb024_desc name="input.b.page1.bgfb024_desc"
            LET g_bgfb_d[l_ac].bgfb024_desc = g_bgfb_d[l_ac].bgfb024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb024_desc
            
            #add-point:AFTER FIELD bgfb024_desc name="input.a.page1.bgfb024_desc"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb024_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb024_desc <> g_bgfb_d_t.bgfb024 OR cl_null(g_bgfb_d_t.bgfb024))) THEN
                  CALL s_azzi650_chk_exist('2002',g_bgfb_d[l_ac].bgfb024_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgfb_d[l_ac].bgfb024_desc = g_bgfb_d_t.bgfb024
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgfb_d[l_ac].bgfb024 = g_bgfb_d[l_ac].bgfb024_desc
               CALL s_desc_get_acc_desc('2002',g_bgfb_d[l_ac].bgfb024) RETURNING g_bgfb_d[l_ac].bgfb024_desc
               LET g_bgfb_d[l_ac].bgfb024_desc = g_bgfb_d[l_ac].bgfb024,"  ",g_bgfb_d[l_ac].bgfb024_desc
            ELSE
               LET g_bgfb_d[l_ac].bgfb024 = g_bgfb_d[l_ac].bgfb024_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb024_desc
            #add-point:ON CHANGE bgfb024_desc name="input.g.page1.bgfb024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb035
            #add-point:BEFORE FIELD bgfb035 name="input.b.page1.bgfb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb035
            
            #add-point:AFTER FIELD bgfb035 name="input.a.page1.bgfb035"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb035) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb035 <> g_bgfb_d_t.bgfb035 OR cl_null(g_bgfb_d_t.bgfb035))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  IF g_bgaw1[1] = 'Y' THEN
                     LET l_bgfb007 = g_bgfb_m.bgfb007
                  ELSE
                     LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
                  END IF
                  LET g_chkparam.arg1 = l_bgfb007
                  LET g_chkparam.arg2 = g_bgfb_d[l_ac].bgfb035
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_bgfb_d[l_ac].bgfb035 = g_bgfb_d_t.bgfb035
                     NEXT FIELD CURRENT
                  END IF
                  SELECT oodb005 INTO g_bgfb_d[l_ac].bgfb036 FROM oodb_t
                   WHERE oodbent=g_enterprise AND oodb002=g_bgfb_d[l_ac].bgfb035
                     AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_bgfb007)
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb035
            #add-point:ON CHANGE bgfb035 name="input.g.page1.bgfb035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb036
            #add-point:BEFORE FIELD bgfb036 name="input.b.page1.bgfb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb036
            
            #add-point:AFTER FIELD bgfb036 name="input.a.page1.bgfb036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb036
            #add-point:ON CHANGE bgfb036 name="input.g.page1.bgfb036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb100
            #add-point:BEFORE FIELD bgfb100 name="input.b.page1.bgfb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb100
            
            #add-point:AFTER FIELD bgfb100 name="input.a.page1.bgfb100"
            IF NOT cl_null(g_bgfb_d[l_ac].bgfb100) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].bgfb100 <> g_bgfb_d_t.bgfb100 OR cl_null(g_bgfb_d_t.bgfb100))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgfb_d[l_ac].bgfb100
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  IF NOT cl_chk_exist("v_ooai001") THEN
                     LET g_bgfb_d[l_ac].bgfb100 = g_bgfb_d_t.bgfb100
                     NEXT FIELD CURRENT
                  END IF
#                  CALL s_abg_get_bg_rate(g_bgfb_m.bgfb002,g_today,g_bgfb_d[l_ac].bgfb100,g_bgfb_m.bgaa003) RETURNING g_bgfb_d[l_ac].bgfb101 #161220-00036#1 mark
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb100
            #add-point:ON CHANGE bgfb100 name="input.g.page1.bgfb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt1
            #add-point:BEFORE FIELD amt1 name="input.b.page1.amt1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt1
            
            #add-point:AFTER FIELD amt1 name="input.a.page1.amt1"
            IF NOT cl_null(g_bgfb_d[l_ac].amt1) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt1 <> g_bgfb_d_t.amt1 OR cl_null(g_bgfb_d_t.amt1))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt1,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt1 = g_bgfb_d_t.amt1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt1 = 0
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt1
            #add-point:ON CHANGE amt1 name="input.g.page1.amt1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="input.b.page1.amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="input.a.page1.amt2"
            IF NOT cl_null(g_bgfb_d[l_ac].amt2) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt2 <> g_bgfb_d_t.amt2 OR cl_null(g_bgfb_d_t.amt2))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt2,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt2 = g_bgfb_d_t.amt2
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt2 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt2
            #add-point:ON CHANGE amt2 name="input.g.page1.amt2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt3
            #add-point:BEFORE FIELD amt3 name="input.b.page1.amt3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt3
            
            #add-point:AFTER FIELD amt3 name="input.a.page1.amt3"
            IF NOT cl_null(g_bgfb_d[l_ac].amt3) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt3 <> g_bgfb_d_t.amt3 OR cl_null(g_bgfb_d_t.amt3))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt3,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt3 = g_bgfb_d_t.amt3
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt3 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt3
            #add-point:ON CHANGE amt3 name="input.g.page1.amt3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt4
            #add-point:BEFORE FIELD amt4 name="input.b.page1.amt4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt4
            
            #add-point:AFTER FIELD amt4 name="input.a.page1.amt4"
            IF NOT cl_null(g_bgfb_d[l_ac].amt4) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt4 <> g_bgfb_d_t.amt4 OR cl_null(g_bgfb_d_t.amt4))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt4,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt4 = g_bgfb_d_t.amt4
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt4 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt4
            #add-point:ON CHANGE amt4 name="input.g.page1.amt4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt5
            #add-point:BEFORE FIELD amt5 name="input.b.page1.amt5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt5
            
            #add-point:AFTER FIELD amt5 name="input.a.page1.amt5"
            IF NOT cl_null(g_bgfb_d[l_ac].amt5) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt5 <> g_bgfb_d_t.amt5 OR cl_null(g_bgfb_d_t.amt5))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt5,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt5 = g_bgfb_d_t.amt5
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt5 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt5
            #add-point:ON CHANGE amt5 name="input.g.page1.amt5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt6
            #add-point:BEFORE FIELD amt6 name="input.b.page1.amt6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt6
            
            #add-point:AFTER FIELD amt6 name="input.a.page1.amt6"
            IF NOT cl_null(g_bgfb_d[l_ac].amt6) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt6 <> g_bgfb_d_t.amt6 OR cl_null(g_bgfb_d_t.amt6))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt6,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt6 = g_bgfb_d_t.amt6
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt6 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt6
            #add-point:ON CHANGE amt6 name="input.g.page1.amt6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt7
            #add-point:BEFORE FIELD amt7 name="input.b.page1.amt7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt7
            
            #add-point:AFTER FIELD amt7 name="input.a.page1.amt7"
            IF NOT cl_null(g_bgfb_d[l_ac].amt7) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt7 <> g_bgfb_d_t.amt7 OR cl_null(g_bgfb_d_t.amt7))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt7,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt7 = g_bgfb_d_t.amt7
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt7 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt7
            #add-point:ON CHANGE amt7 name="input.g.page1.amt7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt8
            #add-point:BEFORE FIELD amt8 name="input.b.page1.amt8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt8
            
            #add-point:AFTER FIELD amt8 name="input.a.page1.amt8"
            IF NOT cl_null(g_bgfb_d[l_ac].amt8) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt8 <> g_bgfb_d_t.amt8 OR cl_null(g_bgfb_d_t.amt8))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt8,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt8 = g_bgfb_d_t.amt8
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt8 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt8
            #add-point:ON CHANGE amt8 name="input.g.page1.amt8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt9
            #add-point:BEFORE FIELD amt9 name="input.b.page1.amt9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt9
            
            #add-point:AFTER FIELD amt9 name="input.a.page1.amt9"
            IF NOT cl_null(g_bgfb_d[l_ac].amt9) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt9 <> g_bgfb_d_t.amt9 OR cl_null(g_bgfb_d_t.amt9))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt9,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt9 = g_bgfb_d_t.amt9
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt9 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt9
            #add-point:ON CHANGE amt9 name="input.g.page1.amt9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt10
            #add-point:BEFORE FIELD amt10 name="input.b.page1.amt10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt10
            
            #add-point:AFTER FIELD amt10 name="input.a.page1.amt10"
            IF NOT cl_null(g_bgfb_d[l_ac].amt10) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt10 <> g_bgfb_d_t.amt10 OR cl_null(g_bgfb_d_t.amt10))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt10,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt10 = g_bgfb_d_t.amt10
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt10 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt10
            #add-point:ON CHANGE amt10 name="input.g.page1.amt10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt11
            #add-point:BEFORE FIELD amt11 name="input.b.page1.amt11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt11
            
            #add-point:AFTER FIELD amt11 name="input.a.page1.amt11"
            IF NOT cl_null(g_bgfb_d[l_ac].amt11) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt11 <> g_bgfb_d_t.amt11 OR cl_null(g_bgfb_d_t.amt11))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt11,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt11 = g_bgfb_d_t.amt11
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt11 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt11
            #add-point:ON CHANGE amt11 name="input.g.page1.amt11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt12
            #add-point:BEFORE FIELD amt12 name="input.b.page1.amt12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt12
            
            #add-point:AFTER FIELD amt12 name="input.a.page1.amt12"
            IF NOT cl_null(g_bgfb_d[l_ac].amt12) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt12 <> g_bgfb_d_t.amt12 OR cl_null(g_bgfb_d_t.amt12))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt12,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt12 = g_bgfb_d_t.amt12
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt12 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt12
            #add-point:ON CHANGE amt12 name="input.g.page1.amt12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt13
            #add-point:BEFORE FIELD amt13 name="input.b.page1.amt13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt13
            
            #add-point:AFTER FIELD amt13 name="input.a.page1.amt13"
            IF NOT cl_null(g_bgfb_d[l_ac].amt13) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgfb_d[l_ac].amt13 <> g_bgfb_d_t.amt13 OR cl_null(g_bgfb_d_t.amt13))) THEN
                  IF NOT cl_ap_chk_Range(g_bgfb_d[l_ac].amt13,"0","1","","","azz-00079",1) THEN
                     LET g_bgfb_d[l_ac].amt13 = g_bgfb_d_t.amt13
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgfb_d[l_ac].amt13 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt13
            #add-point:ON CHANGE amt13 name="input.g.page1.amt13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb008
            #add-point:BEFORE FIELD bgfb008 name="input.b.page1.bgfb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb008
            
            #add-point:AFTER FIELD bgfb008 name="input.a.page1.bgfb008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgfb_m.bgfb001 IS NOT NULL AND g_bgfb_m.bgfb002 IS NOT NULL AND g_bgfb_m.bgfb003 IS NOT NULL AND g_bgfb_m.bgfb004 IS NOT NULL AND g_bgfb_m.bgfb005 IS NOT NULL AND g_bgfb_m.bgfb006 IS NOT NULL AND g_bgfb_m.bgfb007 IS NOT NULL AND g_bgfb_m.bgfb009 IS NOT NULL AND g_bgfb_d[g_detail_idx].bgfb008 IS NOT NULL AND g_bgfb_d[g_detail_idx].bgfb010 IS NOT NULL AND g_bgfb_d[g_detail_idx].bgfbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgfb_m.bgfb001 != g_bgfb001_t OR g_bgfb_m.bgfb002 != g_bgfb002_t OR g_bgfb_m.bgfb003 != g_bgfb003_t OR g_bgfb_m.bgfb004 != g_bgfb004_t OR g_bgfb_m.bgfb005 != g_bgfb005_t OR g_bgfb_m.bgfb006 != g_bgfb006_t OR g_bgfb_m.bgfb007 != g_bgfb007_t OR g_bgfb_m.bgfb009 != g_bgfb009_t OR g_bgfb_d[g_detail_idx].bgfb008 != g_bgfb_d_t.bgfb008 OR g_bgfb_d[g_detail_idx].bgfb010 != g_bgfb_d_t.bgfb010 OR g_bgfb_d[g_detail_idx].bgfbseq != g_bgfb_d_t.bgfbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgfb_t WHERE "||"bgfbent = " ||g_enterprise|| " AND "||"bgfb001 = '"||g_bgfb_m.bgfb001 ||"' AND "|| "bgfb002 = '"||g_bgfb_m.bgfb002 ||"' AND "|| "bgfb003 = '"||g_bgfb_m.bgfb003 ||"' AND "|| "bgfb004 = '"||g_bgfb_m.bgfb004 ||"' AND "|| "bgfb005 = '"||g_bgfb_m.bgfb005 ||"' AND "|| "bgfb006 = '"||g_bgfb_m.bgfb006 ||"' AND "|| "bgfb007 = '"||g_bgfb_m.bgfb007 ||"' AND "|| "bgfb009 = '"||g_bgfb_m.bgfb009 ||"' AND "|| "bgfb008 = '"||g_bgfb_d[g_detail_idx].bgfb008 ||"' AND "|| "bgfb010 = '"||g_bgfb_d[g_detail_idx].bgfb010 ||"' AND "|| "bgfbseq = '"||g_bgfb_d[g_detail_idx].bgfbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb008
            #add-point:ON CHANGE bgfb008 name="input.g.page1.bgfb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb047
            #add-point:BEFORE FIELD bgfb047 name="input.b.page1.bgfb047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb047
            
            #add-point:AFTER FIELD bgfb047 name="input.a.page1.bgfb047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb047
            #add-point:ON CHANGE bgfb047 name="input.g.page1.bgfb047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb048
            #add-point:BEFORE FIELD bgfb048 name="input.b.page1.bgfb048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb048
            
            #add-point:AFTER FIELD bgfb048 name="input.a.page1.bgfb048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb048
            #add-point:ON CHANGE bgfb048 name="input.g.page1.bgfb048"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfbseq
            #add-point:ON ACTION controlp INFIELD bgfbseq name="input.c.page1.bgfbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb010_2
            #add-point:ON ACTION controlp INFIELD bgfb010_2 name="input.c.page1.bgfb010_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb007_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007_2
            #add-point:ON ACTION controlp INFIELD bgfb007_2 name="input.c.page1.bgfb007_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb007             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb007 = g_qryparam.return1              
            #LET g_bgfb_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb007 TO bgfb007_2              #
            #DISPLAY g_bgfb_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgfb007_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007_desc
            #add-point:ON ACTION controlp INFIELD bgfb007_desc name="input.c.page1.bgfb007_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb007_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgfb_m.bgfb002,g_bgfb_m.bgfb004,g_user,'04') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb007_desc = g_qryparam.return1
            LET g_bgfb_d[l_ac].bgfb007 = g_qryparam.return1  
            #LET g_bgfb_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb007_desc TO bgfb007_desc              #
            #DISPLAY g_bgfb_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgfb007_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb009_2
            #add-point:ON ACTION controlp INFIELD bgfb009_2 name="input.c.page1.bgfb009_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgae001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb009 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb009 TO bgfb009_2              #

            NEXT FIELD bgfb009_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb009_desc
            #add-point:ON ACTION controlp INFIELD bgfb009_desc name="input.c.page1.bgfb009_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb009_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where=" bgae006 = '",g_bgaa008,"'",
                                 " AND bgae001 IN (SELECT bgal003 FROM bgal_t ",
                                 "                  WHERE bgalent=",g_enterprise," AND bgal001='",g_bgfb_m.bgfb002,"'",
                                 " AND bgae008='",g_bgfb_m.bgfb005,"' "
            IF g_bgaw1[1] = 'Y' THEN
               LET l_bgfb007 = g_bgfb_m.bgfb007
            ELSE
               LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
            END IF
            
            IF NOT cl_null(l_bgfb007) THEN 
               LET g_qryparam.where=g_qryparam.where," AND bgal002='",l_bgfb007,"'"
            END IF
            LET g_qryparam.where=g_qryparam.where," )"
 
            CALL q_bgae001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb009_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb009 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb009_desc TO bgfb009_desc              #

            NEXT FIELD bgfb009_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb012_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb012_2
            #add-point:ON ACTION controlp INFIELD bgfb012_2 name="input.c.page1.bgfb012_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb012 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb012 TO bgfb012_2              #

            NEXT FIELD bgfb012_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb012_desc
            #add-point:ON ACTION controlp INFIELD bgfb012_desc name="input.c.page1.bgfb012_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb012_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET l_ooef001 = g_bgfb_m.bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgfb_d[l_ac].bgfb007) THEN
                  LET l_ooef001 = g_bgfb_d[l_ac].bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooag004 IN (SELECT ooef001 FROM ooef_t ",
                                   "              WHERE ooefent=",g_enterprise,
                                   "                AND ooef017='",l_ooef017,"' ",
                                   "             )"
 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb012_desc = g_qryparam.return1   
            LET g_bgfb_d[l_ac].bgfb012 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb012_desc TO bgfb012_desc              #

            NEXT FIELD bgfb012_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb013_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb013_2
            #add-point:ON ACTION controlp INFIELD bgfb013_2 name="input.c.page1.bgfb013_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb013 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb013 TO bgfb013_2              #

            NEXT FIELD bgfb013_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb013_desc
            #add-point:ON ACTION controlp INFIELD bgfb013_desc name="input.c.page1.bgfb013_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb013_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET l_ooef001 = g_bgfb_m.bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgfb_d[l_ac].bgfb007) THEN
                  LET l_ooef001 = g_bgfb_d[l_ac].bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "
            
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb013_desc = g_qryparam.return1 
            LET g_bgfb_d[l_ac].bgfb013 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb013_desc TO bgfb013_desc              #

            NEXT FIELD bgfb013_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb014_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb014_2
            #add-point:ON ACTION controlp INFIELD bgfb014_2 name="input.c.page1.bgfb014_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb014 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb014 TO bgfb014_2              #

            NEXT FIELD bgfb014_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb014_desc
            #add-point:ON ACTION controlp INFIELD bgfb014_desc name="input.c.page1.bgfb014_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb014_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgfb_m.bgfb007) THEN
                  LET l_ooef001 = g_bgfb_m.bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgfb_d[l_ac].bgfb007) THEN
                  LET l_ooef001 = g_bgfb_d[l_ac].bgfb007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "

 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb014_desc = g_qryparam.return1
            LET g_bgfb_d[l_ac].bgfb014 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb014_desc TO bgfb014_desc              #

            NEXT FIELD bgfb014_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb015_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb015_2
            #add-point:ON ACTION controlp INFIELD bgfb015_2 name="input.c.page1.bgfb015_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb015             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb015 = g_qryparam.return1 
            
            #LET g_bgfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb015 TO bgfb015_2              #
            #DISPLAY g_bgfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb015_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb015_desc
            #add-point:ON ACTION controlp INFIELD bgfb015_desc name="input.c.page1.bgfb015_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb015_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb015_desc = g_qryparam.return1 
            LET g_bgfb_d[l_ac].bgfb015 = g_qryparam.return1
            #LET g_bgfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb015_desc TO bgfb015_desc              #
            #DISPLAY g_bgfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb015_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb016_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb016_2
            #add-point:ON ACTION controlp INFIELD bgfb016_2 name="input.c.page1.bgfb016_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb016            #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb016 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb016 TO bgfb016_2              #

            NEXT FIELD bgfb016_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb016_desc
            #add-point:ON ACTION controlp INFIELD bgfb016_desc name="input.c.page1.bgfb016_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb016_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            LET l_bgfb007 = ''
            #当预算组织在单头
            IF g_bgaw1[1]='Y' THEN
               LET l_bgfb007 = g_bgfb_m.bgfb007
            END IF
            #当预算组织在单身
            IF g_bgaw2[1]='Y' THEN
               LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgfb007,"')"
 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb016_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb016 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb016_desc TO bgfb016_desc              #

            NEXT FIELD bgfb016_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb017_2
            #add-point:ON ACTION controlp INFIELD bgfb017_2 name="input.c.page1.bgfb017_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb017 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb017 TO bgfb017_2              #

            NEXT FIELD bgfb017_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb017_desc
            #add-point:ON ACTION controlp INFIELD bgfb017_desc name="input.c.page1.bgfb017_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb017_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            LET l_bgfb007 = ''
            #当预算组织在单头
            IF g_bgaw1[1]='Y' AND NOT cl_null(g_bgfb_m.bgfb007) THEN
               LET l_bgfb007 = g_bgfb_m.bgfb007
            END IF
            #当预算组织在单身
            IF g_bgaw2[1]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb007) THEN
               LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
            END IF
            IF NOT cl_null(l_bgfb007) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                      "                  WHERE bgaqent=",g_enterprise,
                                      "                    AND bgaqsite='",l_bgfb007,"')"
            END IF
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb017_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb017 = g_qryparam.return1 
            DISPLAY g_bgfb_d[l_ac].bgfb017_desc TO bgfb017_desc              #

            NEXT FIELD bgfb017_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb018_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb018_2
            #add-point:ON ACTION controlp INFIELD bgfb018_2 name="input.c.page1.bgfb018_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb018             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb018 = g_qryparam.return1              
            #LET g_bgfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb018 TO bgfb018_2              #
            #DISPLAY g_bgfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb018_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb018_desc
            #add-point:ON ACTION controlp INFIELD bgfb018_desc name="input.c.page1.bgfb018_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb018_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb018_desc = g_qryparam.return1 
            LET g_bgfb_d[l_ac].bgfb018 = g_qryparam.return1
            #LET g_bgfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb018_desc TO bgfb018_desc              #
            #DISPLAY g_bgfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb018_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb019_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb019_2
            #add-point:ON ACTION controlp INFIELD bgfb019_2 name="input.c.page1.bgfb019_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb019 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb019 TO bgfb019_2              #

            NEXT FIELD bgfb019_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb019_desc
            #add-point:ON ACTION controlp INFIELD bgfb019_desc name="input.c.page1.bgfb019_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb019_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
 
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb019_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb019 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb019_desc TO bgfb019_desc              #

            NEXT FIELD bgfb019_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb020_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb020_2
            #add-point:ON ACTION controlp INFIELD bgfb020_2 name="input.c.page1.bgfb020_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb020 = g_qryparam.return1              
            
            DISPLAY g_bgfb_d[l_ac].bgfb020 TO bgfb020_2              #

            NEXT FIELD bgfb020_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb020_desc
            #add-point:ON ACTION controlp INFIELD bgfb020_desc name="input.c.page1.bgfb020_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb020_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb020_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb020 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb020_desc TO bgfb020_desc              #

            NEXT FIELD bgfb020_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb021_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb021_2
            #add-point:ON ACTION controlp INFIELD bgfb021_2 name="input.c.page1.bgfb021_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb021 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb021 TO bgfb021_2              #

            NEXT FIELD bgfb021_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb021_desc
            #add-point:ON ACTION controlp INFIELD bgfb021_desc name="input.c.page1.bgfb021_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb021_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = "pjbb012='1'"
            IF g_bgaw1[14]='Y' AND NOT cl_null(g_bgfb_m.bgfb020) THEN
               LET g_qryparam.where = g_qryparam.where," AND pjbb001='",g_bgfb_m.bgfb020,"'"
            END IF
            IF g_bgaw2[14]='Y' AND NOT cl_null(g_bgfb_d[l_ac].bgfb020) THEN
               LET g_qryparam.where = g_qryparam.where," AND pjbb001='",g_bgfb_d[l_ac].bgfb020,"'"
            END IF
 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb021_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb021 = g_qryparam.return1
            DISPLAY g_bgfb_d[l_ac].bgfb021_desc TO bgfb021_desc              #

            NEXT FIELD bgfb021_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb022_2
            #add-point:ON ACTION controlp INFIELD bgfb022_2 name="input.c.page1.bgfb022_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb023_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb023_2
            #add-point:ON ACTION controlp INFIELD bgfb023_2 name="input.c.page1.bgfb023_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb023 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb023 TO bgfb023_2              #

            NEXT FIELD bgfb023_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb023_desc
            #add-point:ON ACTION controlp INFIELD bgfb023_desc name="input.c.page1.bgfb023_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb023_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb023_desc = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb023 = g_qryparam.return1 
            DISPLAY g_bgfb_d[l_ac].bgfb023_desc TO bgfb023_desc              #

            NEXT FIELD bgfb023_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb024_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb024_2
            #add-point:ON ACTION controlp INFIELD bgfb024_2 name="input.c.page1.bgfb024_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb024             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb024 = g_qryparam.return1              
            #LET g_bgfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb024 TO bgfb024_2              #
            #DISPLAY g_bgfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb024_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb024_desc
            #add-point:ON ACTION controlp INFIELD bgfb024_desc name="input.c.page1.bgfb024_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb024_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgfb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb024_desc = g_qryparam.return1 
            LET g_bgfb_d[l_ac].bgfb024 = g_qryparam.return1 
            #LET g_bgfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgfb_d[l_ac].bgfb024_desc TO bgfb024_desc              #
            #DISPLAY g_bgfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgfb024_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb035
            #add-point:ON ACTION controlp INFIELD bgfb035 name="input.c.page1.bgfb035"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb035             #給予default值
            LET g_qryparam.default2 = g_bgfb_d[l_ac].bgfb036 #含稅否
            LET g_qryparam.default3 = "" #g_bgfb_d[l_ac].oodb006 #稅率
            LET g_qryparam.default4 = "" #g_bgfb_d[l_ac].oodbl004 #說明
            
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgfb_m.bgfb007
            ELSE
               IF NOT cl_null(g_bgfb_d[l_ac].bgfb007) THEN
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgfb_d[l_ac].bgfb007
               ELSE
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site
               END IF
            END IF
            #給予arg
            LET g_qryparam.arg1 =l_ooef019
            
            CALL q_oodb002_5()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb035 = g_qryparam.return1              
            LET g_bgfb_d[l_ac].bgfb036 = g_qryparam.return2 
            #LET g_bgfb_d[l_ac].oodb006 = g_qryparam.return3 
            #LET g_bgfb_d[l_ac].oodbl004 = g_qryparam.return4 
            DISPLAY g_bgfb_d[l_ac].bgfb035 TO bgfb035              #
            DISPLAY g_bgfb_d[l_ac].bgfb036 TO bgfb036 #含稅否
            #DISPLAY g_bgfb_d[l_ac].oodb006 TO oodb006 #稅率
            #DISPLAY g_bgfb_d[l_ac].oodbl004 TO oodbl004 #說明
            NEXT FIELD bgfb035                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb036
            #add-point:ON ACTION controlp INFIELD bgfb036 name="input.c.page1.bgfb036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb100
            #add-point:ON ACTION controlp INFIELD bgfb100 name="input.c.page1.bgfb100"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgfb_d[l_ac].bgfb100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_bgfb_d[l_ac].bgfb100 = g_qryparam.return1              

            DISPLAY g_bgfb_d[l_ac].bgfb100 TO bgfb100              #

            NEXT FIELD bgfb100                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.amt1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt1
            #add-point:ON ACTION controlp INFIELD amt1 name="input.c.page1.amt1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="input.c.page1.amt2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt3
            #add-point:ON ACTION controlp INFIELD amt3 name="input.c.page1.amt3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt4
            #add-point:ON ACTION controlp INFIELD amt4 name="input.c.page1.amt4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt5
            #add-point:ON ACTION controlp INFIELD amt5 name="input.c.page1.amt5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt6
            #add-point:ON ACTION controlp INFIELD amt6 name="input.c.page1.amt6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt7
            #add-point:ON ACTION controlp INFIELD amt7 name="input.c.page1.amt7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt8
            #add-point:ON ACTION controlp INFIELD amt8 name="input.c.page1.amt8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt9
            #add-point:ON ACTION controlp INFIELD amt9 name="input.c.page1.amt9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt10
            #add-point:ON ACTION controlp INFIELD amt10 name="input.c.page1.amt10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt11
            #add-point:ON ACTION controlp INFIELD amt11 name="input.c.page1.amt11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt12
            #add-point:ON ACTION controlp INFIELD amt12 name="input.c.page1.amt12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt13
            #add-point:ON ACTION controlp INFIELD amt13 name="input.c.page1.amt13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb008
            #add-point:ON ACTION controlp INFIELD bgfb008 name="input.c.page1.bgfb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb047
            #add-point:ON ACTION controlp INFIELD bgfb047 name="input.c.page1.bgfb047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgfb048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb048
            #add-point:ON ACTION controlp INFIELD bgfb048 name="input.c.page1.bgfb048"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgfb_d[l_ac].* = g_bgfb_d_t.*
               CLOSE abgt620_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bgfb_d[l_ac].bgfb008 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgfb_d[l_ac].* = g_bgfb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bgfb2_d[l_ac].bgfbmodid = g_user 
LET g_bgfb2_d[l_ac].bgfbmoddt = cl_get_current()
LET g_bgfb2_d[l_ac].bgfbmodid_desc = cl_get_username(g_bgfb2_d[l_ac].bgfbmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF 1=2 THEN
               #end add-point
         
               #將遮罩欄位還原
               CALL abgt620_bgfb_t_mask_restore('restore_mask_o')
         
               UPDATE bgfb_t SET (bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb009,bgfb010, 
                   bgfbseq,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021, 
                   bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,bgfb100,bgfb008,bgfb047,bgfb048,bgfbownid, 
                   bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt) = (g_bgfb_m.bgfb001, 
                   g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
                   g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010,g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb012, 
                   g_bgfb_d[l_ac].bgfb013,g_bgfb_d[l_ac].bgfb014,g_bgfb_d[l_ac].bgfb015,g_bgfb_d[l_ac].bgfb016, 
                   g_bgfb_d[l_ac].bgfb017,g_bgfb_d[l_ac].bgfb018,g_bgfb_d[l_ac].bgfb019,g_bgfb_d[l_ac].bgfb020, 
                   g_bgfb_d[l_ac].bgfb021,g_bgfb_d[l_ac].bgfb022,g_bgfb_d[l_ac].bgfb023,g_bgfb_d[l_ac].bgfb024, 
                   g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036,g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb008, 
                   g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,g_bgfb2_d[l_ac].bgfbownid,g_bgfb2_d[l_ac].bgfbowndp, 
                   g_bgfb2_d[l_ac].bgfbcrtid,g_bgfb2_d[l_ac].bgfbcrtdp,g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid, 
                   g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt)
                WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb_m.bgfb001 
                 AND bgfb002 = g_bgfb_m.bgfb002 
                 AND bgfb003 = g_bgfb_m.bgfb003 
                 AND bgfb004 = g_bgfb_m.bgfb004 
                 AND bgfb005 = g_bgfb_m.bgfb005 
                 AND bgfb006 = g_bgfb_m.bgfb006 
                 AND bgfb007 = g_bgfb_m.bgfb007 
                 AND bgfb009 = g_bgfb_m.bgfb009 
                 AND bgfb010 = g_bgfb_m.bgfb010 
 
                 AND bgfb008 = g_bgfb_d_t.bgfb008 #項次   
                 AND bgfbseq = g_bgfb_d_t.bgfbseq  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               END IF
               
               #將遮罩欄位還原
               CALL abgt620_bgfb_t_mask_restore('restore_mask_o')
               
               #主键检查
               #组合key bgfb010
               CALL abgt620_get_bgfb010()
               
               #预算组织在单头
               IF g_bgaw1[1]='Y' THEN 
                  LET l_bgfb007 = g_bgfb_m.bgfb007
               ELSE
                  LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
               END IF
               #预算细项在单头
               IF g_bgaw1[2]='Y' THEN 
                  LET l_bgfb009 = g_bgfb_m.bgfb009
               ELSE
                  LET l_bgfb009 = g_bgfb_d[l_ac].bgfb009
               END IF
               
               IF g_bgfb_m.bgfb001 != g_bgfb001_t  OR g_bgfb_m.bgfb002 != g_bgfb002_t  OR g_bgfb_m.bgfb003 != g_bgfb003_t OR
                  g_bgfb_m.bgfb004 != g_bgfb004_t  OR g_bgfb_m.bgfb005 != g_bgfb005_t  OR g_bgfb_m.bgfb006 != g_bgfb006_t OR
                  ((g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 != g_bgfb007_t ) OR (g_bgaw2[1]='Y' AND g_bgfb_d[l_ac].bgfb007!=g_bgfb_d_t.bgfb007)) OR
                  ((g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 != g_bgfb009_t ) OR (g_bgaw2[2]='Y' AND g_bgfb_d[l_ac].bgfb009!=g_bgfb_d_t.bgfb009)) 
               THEN                   
                  CALL s_abgt620_detail_key_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                                g_bgfb_m.bgfb006,l_bgfb007,l_bgfb009,g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgfb_d[l_ac].bgfbseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgfbseq
                  END IF
               END IF
               
               #重写单身更新
               CALL abgt620_update_detail() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgfb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bgfb_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgfb_m.bgfb001
               LET gs_keys_bak[1] = g_bgfb001_t
               LET gs_keys[2] = g_bgfb_m.bgfb002
               LET gs_keys_bak[2] = g_bgfb002_t
               LET gs_keys[3] = g_bgfb_m.bgfb003
               LET gs_keys_bak[3] = g_bgfb003_t
               LET gs_keys[4] = g_bgfb_m.bgfb004
               LET gs_keys_bak[4] = g_bgfb004_t
               LET gs_keys[5] = g_bgfb_m.bgfb005
               LET gs_keys_bak[5] = g_bgfb005_t
               LET gs_keys[6] = g_bgfb_m.bgfb006
               LET gs_keys_bak[6] = g_bgfb006_t
               LET gs_keys[7] = g_bgfb_m.bgfb007
               LET gs_keys_bak[7] = g_bgfb007_t
               LET gs_keys[8] = g_bgfb_m.bgfb009
               LET gs_keys_bak[8] = g_bgfb009_t
               LET gs_keys[9] = g_bgfb_m.bgfb010
               LET gs_keys_bak[9] = g_bgfb010_t
               LET gs_keys[10] = g_bgfb_d[g_detail_idx].bgfb008
               LET gs_keys_bak[10] = g_bgfb_d_t.bgfb008
               LET gs_keys[11] = g_bgfb_d[g_detail_idx].bgfbseq
               LET gs_keys_bak[11] = g_bgfb_d_t.bgfbseq
               CALL abgt620_update_b('bgfb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bgfb_m),util.JSON.stringify(g_bgfb_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgfb_m),util.JSON.stringify(g_bgfb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt620_bgfb_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bgfb_m.bgfb001
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb002
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb003
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb004
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb005
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb006
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb007
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb009
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_m.bgfb010
 
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_d_t.bgfb008
               LET ls_keys[ls_keys.getLength()+1] = g_bgfb_d_t.bgfbseq
 
               CALL abgt620_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgt620_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgfb_d[l_ac].* = g_bgfb_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgt620_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bgfb_d.getLength() = 0 THEN
               NEXT FIELD bgfb008
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgfb_d[li_reproduce_target].* = g_bgfb_d[li_reproduce].*
               LET g_bgfb2_d[li_reproduce_target].* = g_bgfb2_d[li_reproduce].*
               LET g_bgfb3_d[li_reproduce_target].* = g_bgfb3_d[li_reproduce].*
 
               LET g_bgfb_d[li_reproduce_target].bgfb008 = NULL
               LET g_bgfb_d[li_reproduce_target].bgfbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgfb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgfb_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bgfb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt620_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgt620_idx_chk()
            CALL abgt620_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
      DISPLAY ARRAY g_bgfb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt620_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 3
            CALL abgt620_idx_chk()
            CALL abgt620_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bgfb001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgfbseq
               WHEN "s_detail2"
                  NEXT FIELD bgfbseq_2
               WHEN "s_detail3"
                  NEXT FIELD bgfbseq_3
 
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   CLOSE abgt620_hcl2
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt620_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #重新抓取樣式
   CALL s_abg2_get_bgaw(g_bgfb_m.bgfb011) RETURNING g_bgaw1,g_bgaw2
   
   #设置核算项显示位置
   CALL abgt620_set_hsx_visible()
   
   #抓取預算週期和預算期別
   CALL s_abgt340_sel_bgaa(g_bgfb_m.bgfb002) RETURNING g_bgfb_m.bgaa002,g_bgfb_m.bgaa003,g_max_period
   DISPLAY BY NAME g_bgfb_m.bgaa002,g_bgfb_m.bgaa003
   #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
   IF g_max_period < 13 THEN
      CALL cl_set_comp_visible("amt13,tamt13",FALSE)
   ELSE
      CALL cl_set_comp_visible("amt13,tamt13",TRUE)
   END IF
   #预算细项参照表号
   SELECT bgaa008 INTO g_bgaa008 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgfb_m.bgfb002
   
   #抓取单头核算项说明
   CALL abgt620_head_hsx_desc()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgt620_b_fill(g_wc2) #第一階單身填充
      CALL abgt620_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt620_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bgfb_m.bgfb002,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb004_desc, 
       g_bgfb_m.bgaa002,g_bgfb_m.bgaa003,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb007_desc_t,g_bgfb_m.bgfb013, 
       g_bgfb_m.bgfb013_desc_t,g_bgfb_m.bgfb016,g_bgfb_m.bgfb016_desc_t,g_bgfb_m.bgfb019,g_bgfb_m.bgfb019_desc_t, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb014_desc_t,g_bgfb_m.bgfb017,g_bgfb_m.bgfb017_desc_t, 
       g_bgfb_m.bgfb020,g_bgfb_m.bgfb020_desc_t,g_bgfb_m.bgfb023,g_bgfb_m.bgfb023_desc_t,g_bgfb_m.bgfb012, 
       g_bgfb_m.bgfb012_desc_t,g_bgfb_m.bgfb015,g_bgfb_m.bgfb015_desc_t,g_bgfb_m.bgfb018,g_bgfb_m.bgfb018_desc_t, 
       g_bgfb_m.bgfb021,g_bgfb_m.bgfb021_desc_t,g_bgfb_m.bgfb024,g_bgfb_m.bgfb024_desc_t
 
   CALL abgt620_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CASE g_bgfb_m.bgfbstus 
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "FC"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgt620_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bgfb_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgfb2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_bgfb3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt620_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgfb_t.bgfb001 
   DEFINE l_oldno     LIKE bgfb_t.bgfb001 
   DEFINE l_newno02     LIKE bgfb_t.bgfb002 
   DEFINE l_oldno02     LIKE bgfb_t.bgfb002 
   DEFINE l_newno03     LIKE bgfb_t.bgfb003 
   DEFINE l_oldno03     LIKE bgfb_t.bgfb003 
   DEFINE l_newno04     LIKE bgfb_t.bgfb004 
   DEFINE l_oldno04     LIKE bgfb_t.bgfb004 
   DEFINE l_newno05     LIKE bgfb_t.bgfb005 
   DEFINE l_oldno05     LIKE bgfb_t.bgfb005 
   DEFINE l_newno06     LIKE bgfb_t.bgfb006 
   DEFINE l_oldno06     LIKE bgfb_t.bgfb006 
   DEFINE l_newno07     LIKE bgfb_t.bgfb007 
   DEFINE l_oldno07     LIKE bgfb_t.bgfb007 
   DEFINE l_newno08     LIKE bgfb_t.bgfb009 
   DEFINE l_oldno08     LIKE bgfb_t.bgfb009 
   DEFINE l_newno09     LIKE bgfb_t.bgfb010 
   DEFINE l_oldno09     LIKE bgfb_t.bgfb010 
 
   DEFINE l_master    RECORD LIKE bgfb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgfb_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_bgfb_m.bgfb001 IS NULL
      OR g_bgfb_m.bgfb002 IS NULL
      OR g_bgfb_m.bgfb003 IS NULL
      OR g_bgfb_m.bgfb004 IS NULL
      OR g_bgfb_m.bgfb005 IS NULL
      OR g_bgfb_m.bgfb006 IS NULL
      OR g_bgfb_m.bgfb007 IS NULL
      OR g_bgfb_m.bgfb009 IS NULL
      OR g_bgfb_m.bgfb010 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
   LET g_bgfb010_t = g_bgfb_m.bgfb010
 
   
   LET g_bgfb_m.bgfb001 = ""
   LET g_bgfb_m.bgfb002 = ""
   LET g_bgfb_m.bgfb003 = ""
   LET g_bgfb_m.bgfb004 = ""
   LET g_bgfb_m.bgfb005 = ""
   LET g_bgfb_m.bgfb006 = ""
   LET g_bgfb_m.bgfb007 = ""
   LET g_bgfb_m.bgfb009 = ""
   LET g_bgfb_m.bgfb010 = ""
 
   LET g_master_insert = FALSE
   CALL abgt620_set_entry('a')
   CALL abgt620_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bgfb_m.bgfb001 = "20"
   LET g_bgfb_m.bgfb005 = "1"
   LET g_bgfb_m.bgfb006 = "1"
   LET g_bgfb_m.bgfbstus = 'N'
   CASE g_bgfb_m.bgfbstus 
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "FC"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
   LET g_bgfb_m.bgfb011 = ''
   LET g_bgfb_m.bgaa002 = ''
   LET g_bgfb_m.bgaa003 = ''
   #end add-point
   
   #清空key欄位的desc
      LET g_bgfb_m.bgfb002_desc = ''
   DISPLAY BY NAME g_bgfb_m.bgfb002_desc
   LET g_bgfb_m.bgfb004_desc = ''
   DISPLAY BY NAME g_bgfb_m.bgfb004_desc
   LET g_bgfb_m.bgfb007_desc_t = ''
   DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
 
   
   CALL abgt620_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bgfb_m.* TO NULL
      INITIALIZE g_bgfb_d TO NULL
      INITIALIZE g_bgfb2_d TO NULL
      INITIALIZE g_bgfb3_d TO NULL
 
      CALL abgt620_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt620_set_act_visible()
   CALL abgt620_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
   LET g_bgfb010_t = g_bgfb_m.bgfb010
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                      " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                      ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                      ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                      ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                      ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                      ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
                      ," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
                      ," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
                      ," AND bgfb010 = '", g_bgfb_m.bgfb010, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt620_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgt620_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt620_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgfb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_sql       STRING
   DEFINE l_bgfb001_t LIKE bgfb_t.bgfb001
   DEFINE l_bgfb002_t LIKE bgfb_t.bgfb002
   DEFINE l_bgfb003_t LIKE bgfb_t.bgfb003
   DEFINE l_bgfb004_t LIKE bgfb_t.bgfb004
   DEFINE l_bgfb005_t LIKE bgfb_t.bgfb005
   DEFINE l_bgfb006_t LIKE bgfb_t.bgfb006
   DEFINE l_bgfb007_t LIKE bgfb_t.bgfb007
   DEFINE l_bgfb009_t LIKE bgfb_t.bgfb009
   DEFINE l_success   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt620_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   IF 1=2 THEN
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgfb_t
    WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb001_t
    AND bgfb002 = g_bgfb002_t
    AND bgfb003 = g_bgfb003_t
    AND bgfb004 = g_bgfb004_t
    AND bgfb005 = g_bgfb005_t
    AND bgfb006 = g_bgfb006_t
    AND bgfb007 = g_bgfb007_t
    AND bgfb009 = g_bgfb009_t
    AND bgfb010 = g_bgfb010_t
 
       INTO TEMP abgt620_detail
   
   #將key修正為調整後   
   UPDATE abgt620_detail 
      #更新key欄位
      SET bgfb001 = g_bgfb_m.bgfb001
          , bgfb002 = g_bgfb_m.bgfb002
          , bgfb003 = g_bgfb_m.bgfb003
          , bgfb004 = g_bgfb_m.bgfb004
          , bgfb005 = g_bgfb_m.bgfb005
          , bgfb006 = g_bgfb_m.bgfb006
          , bgfb007 = g_bgfb_m.bgfb007
          , bgfb009 = g_bgfb_m.bgfb009
          , bgfb010 = g_bgfb_m.bgfb010
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgfbownid = g_user 
       , bgfbowndp = g_dept
       , bgfbcrtid = g_user
       , bgfbcrtdp = g_dept 
       , bgfbcrtdt = ld_date
       , bgfbmodid = g_user
       , bgfbmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bgfb_t SELECT * FROM abgt620_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   END IF
   
   LET l_sql = "SELECT * FROM bgfb_t",
               " WHERE bgfbent =", g_enterprise," AND bgfb001 ='", g_bgfb001_t,"'",
               "   AND bgfb002 ='",g_bgfb002_t,"'",
               "   AND bgfb003 ='",g_bgfb003_t,"'",
               "   AND bgfb004 ='",g_bgfb004_t,"'",
               "   AND bgfb005 ='",g_bgfb005_t,"'",
               "   AND bgfb006 ='",g_bgfb006_t,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql,"   AND bgfb007 ='",g_bgfb007_t,"'"
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql,"   AND bgfb009 ='",g_bgfb009_t,"'"
   END IF
   LET l_sql = l_sql," INTO TEMP abgt620_detail"
   PREPARE abgt620_rep_pr FROM l_sql
   EXECUTE abgt620_rep_pr
   
   #將key修正為調整後   
   LET l_sql = "UPDATE abgt620_detail ",
               #更新key欄位
               "   SET bgfb001 = '",g_bgfb_m.bgfb001,"'",
               "      ,bgfb002 = '",g_bgfb_m.bgfb002,"'",
               "      ,bgfb003 = '",g_bgfb_m.bgfb003,"'",
               "      ,bgfb004 = '",g_bgfb_m.bgfb004,"'",
               "      ,bgfb005 = '",g_bgfb_m.bgfb005,"'",
               "      ,bgfb006 = '",g_bgfb_m.bgfb006,"'",
               
              #更新共用欄位
              #應用 a13 樣板自動產生(Version:4)
               "      ,bgfbownid = '",g_user,"'", 
               "      ,bgfbowndp = '",g_dept,"'",
               "      ,bgfbcrtid = '",g_user,"'",
               "      ,bgfbcrtdp = '",g_dept,"'", 
               "      ,bgfbcrtdt = to_date('",ld_date,"','YYYY-MM-DD hh24:mi:ss') ",
               "      ,bgfbmodid = '",g_user,"'",
               "      ,bgfbmoddt =  to_date('",ld_date,"','YYYY-MM-DD hh24:mi:ss') ",
               "      ,bgfbcnfid = NULL",
               "      ,bgfbcnfdt = NULL",
               "      ,bgfbstus = 'N'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql,"      ,bgfb007 = '",g_bgfb_m.bgfb007,"'"
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql,"      ,bgfb009 = '",g_bgfb_m.bgfb009,"'"
   END IF
   
   PREPARE abgt620_rep_pr2 FROM l_sql
   EXECUTE abgt620_rep_pr2
                                       
   #將資料塞回原table   
   INSERT INTO bgfb_t SELECT * FROM abgt620_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abgt620_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   #记录旧值主键
   LET l_bgfb001_t = g_bgfb001_t
   LET l_bgfb002_t = g_bgfb002_t
   LET l_bgfb003_t = g_bgfb003_t
   LET l_bgfb004_t = g_bgfb004_t
   LET l_bgfb005_t = g_bgfb005_t
   LET l_bgfb006_t = g_bgfb006_t
   LET l_bgfb007_t = g_bgfb007_t
   LET l_bgfb009_t = g_bgfb009_t
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
   CALL abgt620_update_head() RETURNING l_success 
   IF l_success = FALSE THEN
      CALL s_transaction_end('N','0')
      #还原旧主键
      LET g_bgfb001_t = l_bgfb001_t 
      LET g_bgfb002_t = l_bgfb002_t 
      LET g_bgfb003_t = l_bgfb003_t 
      LET g_bgfb004_t = l_bgfb004_t 
      LET g_bgfb005_t = l_bgfb005_t 
      LET g_bgfb006_t = l_bgfb006_t 
      LET g_bgfb007_t = l_bgfb007_t 
      LET g_bgfb009_t = l_bgfb009_t 
      RETURN
   END IF
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
   LET g_bgfb010_t = g_bgfb_m.bgfb010
 
   
   DROP TABLE abgt620_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt620_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   #由于主键位置不确定在单头或单身，锁资料SQL不同，需重写
   CALL abgt620_delete_1()
   RETURN
   #end add-point
   
   IF g_bgfb_m.bgfb001 IS NULL
   OR g_bgfb_m.bgfb002 IS NULL
   OR g_bgfb_m.bgfb003 IS NULL
   OR g_bgfb_m.bgfb004 IS NULL
   OR g_bgfb_m.bgfb005 IS NULL
   OR g_bgfb_m.bgfb006 IS NULL
   OR g_bgfb_m.bgfb007 IS NULL
   OR g_bgfb_m.bgfb009 IS NULL
   OR g_bgfb_m.bgfb010 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgt620_cl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt620_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt620_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010 INTO g_bgfb_m.bgfb002, 
       g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfb010,g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb009,g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023, 
       g_bgfb_m.bgfb012,g_bgfb_m.bgfb015,g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb002_desc, 
       g_bgfb_m.bgfb004_desc
   
   #遮罩相關處理
   LET g_bgfb_m_mask_o.* =  g_bgfb_m.*
   CALL abgt620_bgfb_t_mask()
   LET g_bgfb_m_mask_n.* =  g_bgfb_m.*
   
   CALL abgt620_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt620_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
 
      #end add-point
      
      DELETE FROM bgfb_t WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb_m.bgfb001
                                                               AND bgfb002 = g_bgfb_m.bgfb002
                                                               AND bgfb003 = g_bgfb_m.bgfb003
                                                               AND bgfb004 = g_bgfb_m.bgfb004
                                                               AND bgfb005 = g_bgfb_m.bgfb005
                                                               AND bgfb006 = g_bgfb_m.bgfb006
                                                               AND bgfb007 = g_bgfb_m.bgfb007
                                                               AND bgfb009 = g_bgfb_m.bgfb009
                                                               AND bgfb010 = g_bgfb_m.bgfb010
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
 
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE abgt620_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bgfb_d.clear() 
      CALL g_bgfb2_d.clear()       
      CALL g_bgfb3_d.clear()       
 
     
      CALL abgt620_ui_browser_refresh()  
      #CALL abgt620_ui_headershow()  
      #CALL abgt620_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt620_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt620_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt620_cl
 
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt620.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt620_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_bgfb010_str       STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bgfb_d.clear()
   CALL g_bgfb2_d.clear()
   CALL g_bgfb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016, 
       bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,bgfb100,bgfb008, 
       bgfb047,bgfb048,bgfbseq,bgfbownid,bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt, 
       bgfbcnfid,bgfbcnfdt,bgfbseq,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 FROM bgfb_t", 
          
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgfbownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgfbowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgfbcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgfbcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgfbmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgfbcnfid  ",
 
               " WHERE bgfbent= ? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND bgfb005=? AND bgfb006=? AND bgfb007=? AND bgfb009=? AND bgfb010=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgfb_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #重写单身抓取sql
   #161220-00036#1--mod--str--
#   LET g_sql = "SELECT  DISTINCT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015, 
#       bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036, 
#       bgfb100,bgfb101,0 bgfb008,bgfb047,'',bgfbseq,bgfbownid,bgfbowndp, 
#       bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt,bgfbseq,t1.ooag011 ,t2.ooefl003 , 
#       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 FROM bgfb_t",
   LET g_sql = "SELECT  DISTINCT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015,", 
       "bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,", 
       "bgfb100,0 bgfb008,bgfb047,'',bgfbseq,bgfbownid,bgfbowndp, ",
       "bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt,bgfbseq,t1.ooag011 ,t2.ooefl003 , ",
       "t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ",
       "  FROM bgfb_t",
   #161220-00036#1--mod--end       
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgfbownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgfbowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgfbcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgfbcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgfbmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgfbcnfid  ",
 
               " WHERE bgfbent= ? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND bgfb005=? AND bgfb006=? "  
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET g_sql = g_sql," AND bgfb007='",g_bgfb_m.bgfb007,"' "
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET g_sql = g_sql," AND bgfb009='",g_bgfb_m.bgfb009,"' "
   END IF
   
   #将单头核算项组成的组合码转换成查询条件
   LET l_bgfb010_str=g_bgfb_m.bgfb010
   IF cl_null(l_bgfb010_str) THEN
      LET l_bgfb010_str = " 1=1 "
   ELSE
      LET l_bgfb010_str=cl_replace_str(l_bgfb010_str,"=","='")
      LET l_bgfb010_str=cl_replace_str(l_bgfb010_str,"/","' AND ")
      LET l_bgfb010_str=l_bgfb010_str,"' "
   END IF
   LET g_sql = g_sql," AND ",l_bgfb010_str
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgfb_t")
   END IF
   LET g_sql = g_sql, " ORDER BY bgfb_t.bgfbseq"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   PREPARE abgt620_pb_1 FROM g_sql
   DECLARE b_fill_cs_1 CURSOR FOR abgt620_pb_1
   OPEN b_fill_cs_1 USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006
   
   LET g_cnt = l_ac
   LET l_ac = 1                                            
   FOREACH b_fill_cs_1 INTO g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010,g_bgfb_d[l_ac].bgfb007,g_bgfb_d[l_ac].bgfb009, 
       g_bgfb_d[l_ac].bgfb012,g_bgfb_d[l_ac].bgfb013,g_bgfb_d[l_ac].bgfb014, 
       g_bgfb_d[l_ac].bgfb015,g_bgfb_d[l_ac].bgfb016,g_bgfb_d[l_ac].bgfb017,g_bgfb_d[l_ac].bgfb018, 
       g_bgfb_d[l_ac].bgfb019,g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021,g_bgfb_d[l_ac].bgfb022, 
       g_bgfb_d[l_ac].bgfb023,g_bgfb_d[l_ac].bgfb024,g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036, 
#       g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb101,g_bgfb_d[l_ac].bgfb008, #161220-00036#1 mark
       g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb008, #161220-00036#1 add
       g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,g_bgfb2_d[l_ac].bgfbseq,
       g_bgfb2_d[l_ac].bgfbownid,g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid,
       g_bgfb2_d[l_ac].bgfbcrtdp,g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid,
       g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt, 
       g_bgfb3_d[l_ac].bgfbseq,g_bgfb2_d[l_ac].bgfbownid_desc,g_bgfb2_d[l_ac].bgfbowndp_desc,g_bgfb2_d[l_ac].bgfbcrtid_desc, 
       g_bgfb2_d[l_ac].bgfbcrtdp_desc,g_bgfb2_d[l_ac].bgfbmodid_desc,g_bgfb2_d[l_ac].bgfbcnfid_desc 
    
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF           
     
      #抓取项次对应的每个期别的金额
      CALL abgt620_get_amt()
      #显示单身核算项说明
      CALL abgt620_detail_hsx_desc()
   
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
   LET g_rec_b=l_ac-1
   LET l_ac = l_ac - 1
   CALL g_bgfb_d.deleteElement(g_bgfb_d.getLength())
   CALL g_bgfb2_d.deleteElement(g_bgfb2_d.getLength())
   
   DISPLAY g_rec_b TO FORMONLY.cnt    
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgfb_d.getLength()
      LET g_bgfb_d_mask_o[l_ac].* =  g_bgfb_d[l_ac].*
      CALL abgt620_bgfb_t_mask()
      LET g_bgfb_d_mask_n[l_ac].* =  g_bgfb_d[l_ac].*
   END FOR
   
   LET g_bgfb2_d_mask_o.* =  g_bgfb2_d.*
   FOR l_ac = 1 TO g_bgfb2_d.getLength()
      LET g_bgfb2_d_mask_o[l_ac].* =  g_bgfb2_d[l_ac].*
      CALL abgt620_bgfb_t_mask()
      LET g_bgfb2_d_mask_n[l_ac].* =  g_bgfb2_d[l_ac].*
   END FOR
   LET l_ac = g_cnt
   LET g_cnt = 0 
   
   #调整资讯页签填充单身
   CALL abgt620_b_fill2(l_ac)
   
   FREE abgt620_pb_1   
   RETURN
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgt620_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bgfb_t.bgfb008,bgfb_t.bgfbseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt620_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt620_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
          g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb010 INTO g_bgfb_d[l_ac].bgfbseq, 
          g_bgfb_d[l_ac].bgfb010,g_bgfb_d[l_ac].bgfb007,g_bgfb_d[l_ac].bgfb009,g_bgfb_d[l_ac].bgfb012, 
          g_bgfb_d[l_ac].bgfb013,g_bgfb_d[l_ac].bgfb014,g_bgfb_d[l_ac].bgfb015,g_bgfb_d[l_ac].bgfb016, 
          g_bgfb_d[l_ac].bgfb017,g_bgfb_d[l_ac].bgfb018,g_bgfb_d[l_ac].bgfb019,g_bgfb_d[l_ac].bgfb020, 
          g_bgfb_d[l_ac].bgfb021,g_bgfb_d[l_ac].bgfb022,g_bgfb_d[l_ac].bgfb023,g_bgfb_d[l_ac].bgfb024, 
          g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036,g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb008, 
          g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,g_bgfb2_d[l_ac].bgfbseq,g_bgfb2_d[l_ac].bgfbownid, 
          g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid,g_bgfb2_d[l_ac].bgfbcrtdp,g_bgfb2_d[l_ac].bgfbcrtdt, 
          g_bgfb2_d[l_ac].bgfbmodid,g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt, 
          g_bgfb3_d[l_ac].bgfbseq,g_bgfb2_d[l_ac].bgfbownid_desc,g_bgfb2_d[l_ac].bgfbowndp_desc,g_bgfb2_d[l_ac].bgfbcrtid_desc, 
          g_bgfb2_d[l_ac].bgfbcrtdp_desc,g_bgfb2_d[l_ac].bgfbmodid_desc,g_bgfb2_d[l_ac].bgfbcnfid_desc  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         
         #end add-point
      
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
 
            CALL g_bgfb_d.deleteElement(g_bgfb_d.getLength())
      CALL g_bgfb2_d.deleteElement(g_bgfb2_d.getLength())
      CALL g_bgfb3_d.deleteElement(g_bgfb3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
  
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgfb_d.getLength()
      LET g_bgfb_d_mask_o[l_ac].* =  g_bgfb_d[l_ac].*
      CALL abgt620_bgfb_t_mask()
      LET g_bgfb_d_mask_n[l_ac].* =  g_bgfb_d[l_ac].*
   END FOR
   
   LET g_bgfb2_d_mask_o.* =  g_bgfb2_d.*
   FOR l_ac = 1 TO g_bgfb2_d.getLength()
      LET g_bgfb2_d_mask_o[l_ac].* =  g_bgfb2_d[l_ac].*
      CALL abgt620_bgfb_t_mask()
      LET g_bgfb2_d_mask_n[l_ac].* =  g_bgfb2_d[l_ac].*
   END FOR
   LET g_bgfb3_d_mask_o.* =  g_bgfb3_d.*
   FOR l_ac = 1 TO g_bgfb3_d.getLength()
      LET g_bgfb3_d_mask_o[l_ac].* =  g_bgfb3_d[l_ac].*
      CALL abgt620_bgfb_t_mask()
      LET g_bgfb3_d_mask_n[l_ac].* =  g_bgfb3_d[l_ac].*
   END FOR
 
 
   FREE abgt620_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt620_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_bgfb_d.getLength() THEN
         LET g_detail_idx = g_bgfb_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgfb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgfb_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgfb2_d.getLength() THEN
         LET g_detail_idx = g_bgfb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgfb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgfb2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_bgfb3_d.getLength() THEN
         LET g_detail_idx = g_bgfb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgfb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgfb3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt620_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_bgfb037       LIKE bgfb_t.bgfb037
   DEFINE l_bgfb038       LIKE bgfb_t.bgfb038
   DEFINE l_bgfb039       LIKE bgfb_t.bgfb039
   DEFINE l_bgfb102       LIKE bgfb_t.bgfb102
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bgfb_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF pi_idx < 1 THEN
      RETURN
   END IF
   
   CALL g_bgfb3_d.clear()
   
   LET l_sql="SELECT bgfb037,bgfb038,bgfb039,bgfb102",
             "  FROM bgfb_t ",
             " WHERE bgfbent =  ",g_enterprise,
             "   AND bgfb001 = '",g_bgfb_m.bgfb001,"'",
             "   AND bgfb002 = '",g_bgfb_m.bgfb002,"'",
             "   AND bgfb003 = '",g_bgfb_m.bgfb003,"'",
             "   AND bgfb004 = '",g_bgfb_m.bgfb004,"'",
             "   AND bgfb005 = '",g_bgfb_m.bgfb005,"'",
             "   AND bgfb006 = '",g_bgfb_m.bgfb006,"'",
             "   AND bgfb010 = '",g_bgfb_d[pi_idx].bgfb010,"'",
             "   AND bgfbseq =  ",g_bgfb_d[pi_idx].bgfbseq,
             "   AND bgfb008 = ? "
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb_m.bgfb007,"'"
   ELSE
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb_d[pi_idx].bgfb007,"'"
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb_m.bgfb009,"'"
   ELSE
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb_d[pi_idx].bgfb009,"'"
   END IF
   PREPARE abgt620_b_fill2_pr FROM l_sql
   
   
   #第一行：基准金额
   LET g_bgfb3_d[1].bgfbseq = g_bgfb_d[pi_idx].bgfbseq #项次
   LET g_bgfb3_d[1].content = '1'
   #第二行：本层调整
   LET g_bgfb3_d[2].bgfbseq = g_bgfb_d[pi_idx].bgfbseq #项次
   LET g_bgfb3_d[2].content = '2'
   #第三行：上层调整
   LET g_bgfb3_d[3].bgfbseq = g_bgfb_d[pi_idx].bgfbseq #项次
   LET g_bgfb3_d[3].content = '3'
   #第四行：核准金额   
   LET g_bgfb3_d[4].bgfbseq = g_bgfb_d[pi_idx].bgfbseq #项次
   LET g_bgfb3_d[4].content = '4'
   FOR l_i = 1 TO g_max_period
      #161220-00036#1--add--str--
      LET l_bgfb037 = 0
      LET l_bgfb038 = 0
      LET l_bgfb039 = 0
      LET l_bgfb102 = 0
      #161220-00036#1--add--end
      EXECUTE abgt620_b_fill2_pr USING l_i
      INTO l_bgfb037,l_bgfb038,l_bgfb039,l_bgfb102 
      CASE l_i
         WHEN 1 
            LET g_bgfb3_d[1].tamt1 = l_bgfb037
            LET g_bgfb3_d[2].tamt1 = l_bgfb038
            LET g_bgfb3_d[3].tamt1 = l_bgfb039
            LET g_bgfb3_d[4].tamt1 = l_bgfb102
         WHEN 2 
            LET g_bgfb3_d[1].tamt2 = l_bgfb037
            LET g_bgfb3_d[2].tamt2 = l_bgfb038
            LET g_bgfb3_d[3].tamt2 = l_bgfb039
            LET g_bgfb3_d[4].tamt2 = l_bgfb102
         WHEN 3 
            LET g_bgfb3_d[1].tamt3 = l_bgfb037
            LET g_bgfb3_d[2].tamt3 = l_bgfb038
            LET g_bgfb3_d[3].tamt3 = l_bgfb039
            LET g_bgfb3_d[4].tamt3 = l_bgfb102
         WHEN 4 
            LET g_bgfb3_d[1].tamt4 = l_bgfb037
            LET g_bgfb3_d[2].tamt4 = l_bgfb038
            LET g_bgfb3_d[3].tamt4 = l_bgfb039
            LET g_bgfb3_d[4].tamt4 = l_bgfb102
         WHEN 5
            LET g_bgfb3_d[1].tamt5 = l_bgfb037
            LET g_bgfb3_d[2].tamt5 = l_bgfb038
            LET g_bgfb3_d[3].tamt5 = l_bgfb039
            LET g_bgfb3_d[4].tamt5 = l_bgfb102
         WHEN 6 
            LET g_bgfb3_d[1].tamt6 = l_bgfb037
            LET g_bgfb3_d[2].tamt6 = l_bgfb038
            LET g_bgfb3_d[3].tamt6 = l_bgfb039
            LET g_bgfb3_d[4].tamt6 = l_bgfb102
         WHEN 7 
            LET g_bgfb3_d[1].tamt7 = l_bgfb037
            LET g_bgfb3_d[2].tamt7 = l_bgfb038
            LET g_bgfb3_d[3].tamt7 = l_bgfb039
            LET g_bgfb3_d[4].tamt7 = l_bgfb102
         WHEN 8 
            LET g_bgfb3_d[1].tamt8 = l_bgfb037
            LET g_bgfb3_d[2].tamt8 = l_bgfb038
            LET g_bgfb3_d[3].tamt8 = l_bgfb039
            LET g_bgfb3_d[4].tamt8 = l_bgfb102
         WHEN 9 
            LET g_bgfb3_d[1].tamt9 = l_bgfb037
            LET g_bgfb3_d[2].tamt9 = l_bgfb038
            LET g_bgfb3_d[3].tamt9 = l_bgfb039
            LET g_bgfb3_d[4].tamt9 = l_bgfb102
         WHEN 10 
            LET g_bgfb3_d[1].tamt10 = l_bgfb037
            LET g_bgfb3_d[2].tamt10 = l_bgfb038
            LET g_bgfb3_d[3].tamt10 = l_bgfb039
            LET g_bgfb3_d[4].tamt10 = l_bgfb102
         WHEN 11 
            LET g_bgfb3_d[1].tamt11 = l_bgfb037
            LET g_bgfb3_d[2].tamt11 = l_bgfb038
            LET g_bgfb3_d[3].tamt11 = l_bgfb039
            LET g_bgfb3_d[4].tamt11 = l_bgfb102
         WHEN 12 
            LET g_bgfb3_d[1].tamt12 = l_bgfb037
            LET g_bgfb3_d[2].tamt12 = l_bgfb038
            LET g_bgfb3_d[3].tamt12 = l_bgfb039
            LET g_bgfb3_d[4].tamt12 = l_bgfb102
         WHEN 13 
            LET g_bgfb3_d[1].tamt13 = l_bgfb037
            LET g_bgfb3_d[2].tamt13 = l_bgfb038
            LET g_bgfb3_d[3].tamt13 = l_bgfb039
            LET g_bgfb3_d[4].tamt13 = l_bgfb102
      END CASE
   END FOR
   
   #合计
   LET l_sql="SELECT SUM(bgfb037),SUM(bgfb038),SUM(bgfb039),SUM(bgfb102)",
             "  FROM bgfb_t ",
             " WHERE bgfbent =  ",g_enterprise,
             "   AND bgfb001 = '",g_bgfb_m.bgfb001,"'",
             "   AND bgfb002 = '",g_bgfb_m.bgfb002,"'",
             "   AND bgfb003 = '",g_bgfb_m.bgfb003,"'",
             "   AND bgfb004 = '",g_bgfb_m.bgfb004,"'",
             "   AND bgfb005 = '",g_bgfb_m.bgfb005,"'",
             "   AND bgfb006 = '",g_bgfb_m.bgfb006,"'",
             "   AND bgfb010 = '",g_bgfb_d[pi_idx].bgfb010,"'",
             "   AND bgfbseq =  ",g_bgfb_d[pi_idx].bgfbseq
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb_m.bgfb007,"'"
   ELSE
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb_d[pi_idx].bgfb007,"'"
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb_m.bgfb009,"'"
   ELSE
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb_d[pi_idx].bgfb009,"'"
   END IF
   PREPARE abgt620_b_fill2_sum_pr FROM l_sql
   EXECUTE abgt620_b_fill2_sum_pr INTO g_bgfb3_d[1].sum,g_bgfb3_d[2].sum,g_bgfb3_d[3].sum,g_bgfb3_d[4].sum 
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgt620_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   DEFINE l_sql           STRING
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   IF 1=2 THEN
   #end add-point
   
   DELETE FROM bgfb_t
    WHERE bgfbent = g_enterprise AND bgfb001 = g_bgfb_m.bgfb001 AND
                              bgfb002 = g_bgfb_m.bgfb002 AND
                              bgfb003 = g_bgfb_m.bgfb003 AND
                              bgfb004 = g_bgfb_m.bgfb004 AND
                              bgfb005 = g_bgfb_m.bgfb005 AND
                              bgfb006 = g_bgfb_m.bgfb006 AND
                              bgfb007 = g_bgfb_m.bgfb007 AND
                              bgfb009 = g_bgfb_m.bgfb009 AND
                              bgfb010 = g_bgfb_m.bgfb010 AND
 
          bgfb008 = g_bgfb_d_t.bgfb008
      AND bgfbseq = g_bgfb_d_t.bgfbseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   END IF
   
   LET l_sql = "DELETE FROM bgfb_t ",
                " WHERE bgfbent = ",g_enterprise,
                "   AND bgfb001 ='",g_bgfb_m.bgfb001,"'",
                "   AND bgfb002 ='",g_bgfb_m.bgfb002,"'",
                "   AND bgfb003 ='",g_bgfb_m.bgfb003,"'",
                "   AND bgfb004 ='",g_bgfb_m.bgfb004,"'",
                "   AND bgfb005 ='",g_bgfb_m.bgfb005,"'",
                "   AND bgfb006 ='",g_bgfb_m.bgfb006,"'"
    #预算组织在单头
    IF g_bgaw1[1] = 'Y' THEN
       LET l_sql = l_sql," AND bgfb007 ='",g_bgfb_m.bgfb007,"'"
    ELSE
       LET l_sql = l_sql," AND bgfb007 ='",g_bgfb_d_t.bgfb007,"'"
    END IF
    #预算细项在单头
    IF g_bgaw1[2] = 'Y' THEN
       LET l_sql = l_sql," AND bgfb009 ='",g_bgfb_m.bgfb009,"'"
    ELSE
       LET l_sql = l_sql," AND bgfb009 ='",g_bgfb_d_t.bgfb009,"'"
    END IF
    LET l_sql = l_sql," AND bgfb010 ='",g_bgfb_d_t.bgfb010,"'",
                      " AND bgfbseq = ",g_bgfb_d_t.bgfbseq
                      
    PREPARE abgt620_before_delete_pr FROM l_sql
    EXECUTE abgt620_before_delete_pr
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="abgt620.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt620_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt620_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt620_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
   #end add-point 
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgt620_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bgfb_d[l_ac].bgfb008 = g_bgfb_d_t.bgfb008 
      AND g_bgfb_d[l_ac].bgfbseq = g_bgfb_d_t.bgfbseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt620_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt620_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL abgt620_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt620_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt620_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb009,bgfb010",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bgfb006",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt620_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb009,bgfb010",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("bgfb007,bgfb009",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt620_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt620_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt620_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   #由于statechange是画面中手动画上的，不是r.a产生的，此处需要添加
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange", TRUE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt620_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bgfb_m.bgfbstus NOT MATCHES "[NDR]" THEN   
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt620_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt620.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt620_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt620.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt620_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bgfb001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgfb002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bgfb003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bgfb004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bgfb005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bgfb006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " bgfb007 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " bgfb009 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " bgfb010 = '", g_argv[09], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt620_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt620.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgt620_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "bgfbseq"
      WHEN "s_detail2"
         LET ls_return = "bgfbseq_2"
      WHEN "s_detail3"
         LET ls_return = "bgfbseq_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgt620.mask_functions" >}
&include "erp/abg/abgt620_mask.4gl"
 
{</section>}
 
{<section id="abgt620.state_change" >}
    
 
{</section>}
 
{<section id="abgt620.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt620_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_bgfb_m.bgfb001
   LET g_pk_array[1].column = 'bgfb001'
   LET g_pk_array[2].values = g_bgfb_m.bgfb002
   LET g_pk_array[2].column = 'bgfb002'
   LET g_pk_array[3].values = g_bgfb_m.bgfb003
   LET g_pk_array[3].column = 'bgfb003'
   LET g_pk_array[4].values = g_bgfb_m.bgfb004
   LET g_pk_array[4].column = 'bgfb004'
   LET g_pk_array[5].values = g_bgfb_m.bgfb005
   LET g_pk_array[5].column = 'bgfb005'
   LET g_pk_array[6].values = g_bgfb_m.bgfb006
   LET g_pk_array[6].column = 'bgfb006'
   LET g_pk_array[7].values = g_bgfb_m.bgfb007
   LET g_pk_array[7].column = 'bgfb007'
   LET g_pk_array[8].values = g_bgfb_m.bgfb009
   LET g_pk_array[8].column = 'bgfb009'
   LET g_pk_array[9].values = g_bgfb_m.bgfb010
   LET g_pk_array[9].column = 'bgfb010'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt620.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt620_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL abgt620_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgfb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt620.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 设置核算项在单头或是单身，以及是否显示
# Memo...........:
# Usage..........: CALL abgt620_set_hsx_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_set_hsx_visible()
   DEFINE l_flag1        LIKE type_t.num5 #单头显示核算项个数
   
   LET l_flag1 = 0
   #单头显示栏位
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb007,bgfb007_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb007,bgfb007_desc_t",FALSE)
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb009",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb009",FALSE)
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb013,bgfb013_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb013,bgfb013_desc_t",FALSE)
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb014,bgfb014_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb014,bgfb014_desc_t",FALSE)
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb015,bgfb015_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb015,bgfb015_desc_t",FALSE)
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb016,bgfb016_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb016,bgfb016_desc_t",FALSE)
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb017,bgfb017_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb017,bgfb017_desc_t",FALSE)
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb018,bgfb018_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb018,bgfb018_desc_t",FALSE)
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb019,bgfb019_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb019,bgfb019_desc_t",FALSE)
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb022",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb022",FALSE)
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb023,bgfb023_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb023,bgfb023_desc_t",FALSE)
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb024,bgfb024_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb024,bgfb024_desc_t",FALSE)
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb012,bgfb012_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb012,bgfb012_desc_t",FALSE)
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb020,bgfb020_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb020,bgfb020_desc_t",FALSE)
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb021,bgfb021_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgfb021,bgfb021_desc_t",FALSE)
   END IF
   #当核算项都在单身显示时，隐藏单头核算项栏位
   IF l_flag1 = 0 THEN
      CALL cl_set_comp_visible("group_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("group_1",TRUE)
   END IF
   
   #单身显示栏位
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb007_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb007_desc",FALSE)
   END IF
   #预算细项
   IF g_bgaw2[2] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb009_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb009_desc",FALSE)
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb013_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb013_desc",FALSE)
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb014_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb014_desc",FALSE)
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb015_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb015_desc",FALSE)
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb016_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb016_desc",FALSE)
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb017_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb017_desc",FALSE)
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb018_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb018_desc",FALSE)
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb019_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb019_desc",FALSE)
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb022_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb022_2",FALSE)
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb023_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb023_desc",FALSE)
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb024_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb024_desc",FALSE)
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb012_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb012_desc",FALSE)
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb020_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb020_desc",FALSE)
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      CALL cl_set_comp_visible("bgfb021_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgfb021_desc",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据预算编号+预算组织+预算细项设置核算项的启用情况，启用时可以录入，不启用时不可录入，默认给空白
# Memo...........:
# Usage..........: CALL abgt620_set_head_hsx_entry(p_bgfb002,p_bgfb007,p_bgfb009)
# Input parameter: p_bgfb002      预算编号
#                : p_bgfb007      预算组织
#                : p_bgfb009      预算细项
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_set_head_hsx_entry(p_bgfb002,p_bgfb007,p_bgfb009)
   DEFINE p_bgfb002       LIKE bgfb_t.bgfb002
   DEFINE p_bgfb007       LIKE bgfb_t.bgfb007
   DEFINE p_bgfb009       LIKE bgfb_t.bgfb009
   
   IF cl_null(p_bgfb002) OR cl_null(p_bgfb007) OR cl_null(p_bgfb009) THEN
      RETURN
   END IF
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=p_bgfb002
      AND bgal002=p_bgfb007 AND bgal003=p_bgfb009
   #单头核算项栏位录入设置
   #部门
   IF g_bgaw1[3]='Y' THEN
      IF g_bgal.bgal005 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb013",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb013",FALSE)
         LET g_bgfb_m.bgfb013 = ' '
         LET g_bgfb_m.bgfb013_desc_t = ''
      END IF
   END IF
   #利润成本中心
   IF g_bgaw1[4]='Y' THEN
      IF g_bgal.bgal006 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb014",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb014",FALSE)
         LET g_bgfb_m.bgfb014 = ' '
         LET g_bgfb_m.bgfb014_desc_t = ''
      END IF
   END IF
   #区域
   IF g_bgaw1[5]='Y' THEN
      IF g_bgal.bgal007 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb015",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb015",FALSE)
         LET g_bgfb_m.bgfb015 = ' '
         LET g_bgfb_m.bgfb015_desc_t = ''
      END IF
   END IF
   #收付款客商
   IF g_bgaw1[6]='Y' THEN
      IF g_bgal.bgal008 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb016",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb016",FALSE)
         LET g_bgfb_m.bgfb016 = ' '
         LET g_bgfb_m.bgfb016_desc_t = ''
      END IF
   END IF 
   #账款客商
   IF g_bgaw1[7]='Y' THEN
      IF g_bgal.bgal009 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb017",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb017",FALSE)
         LET g_bgfb_m.bgfb017 = ' '
         LET g_bgfb_m.bgfb017_desc_t = ''
      END IF
   END IF  
   #客群
   IF g_bgaw1[8]='Y' THEN
      IF g_bgal.bgal010 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb018",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb018",FALSE)
         LET g_bgfb_m.bgfb018 = ' '
         LET g_bgfb_m.bgfb018_desc_t = ''
      END IF
   END IF
   #产品类别
   IF g_bgaw1[9]='Y' THEN
      IF g_bgal.bgal011 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb019",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb019",FALSE)
         LET g_bgfb_m.bgfb019 = ' '
         LET g_bgfb_m.bgfb019_desc_t = ''
      END IF
   END IF
   #经营方式
   IF g_bgaw1[10]='Y' THEN
      IF g_bgal.bgal025 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb022",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb022",FALSE)
         LET g_bgfb_m.bgfb022 = ' '
      END IF
   END IF
   #通路
   IF g_bgaw1[11]='Y' THEN
      IF g_bgal.bgal026 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb023",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb023",FALSE)
         LET g_bgfb_m.bgfb023 = ' '
         LET g_bgfb_m.bgfb023_desc_t = ''
      END IF
   END IF
   #品牌
   IF g_bgaw1[12]='Y' THEN
      IF g_bgal.bgal027 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb024",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb024",FALSE)
         LET g_bgfb_m.bgfb024 = ' '
         LET g_bgfb_m.bgfb024_desc_t = ''
      END IF
   END IF
   #人员
   IF g_bgaw1[13]='Y' THEN
      IF g_bgal.bgal012 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb012",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb012",FALSE)
         LET g_bgfb_m.bgfb012 = ' '
         LET g_bgfb_m.bgfb012_desc_t = ''
      END IF
   END IF
   #专案
   IF g_bgaw1[14]='Y' THEN
      IF g_bgal.bgal013 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb020",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb020",FALSE)
         LET g_bgfb_m.bgfb020 = ' '
         LET g_bgfb_m.bgfb020_desc_t = ''
      END IF
   END IF
   #WBS
   IF g_bgaw1[15]='Y' THEN
      IF g_bgal.bgal014 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb021",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb021",FALSE)
         LET g_bgfb_m.bgfb021 = ' '
         LET g_bgfb_m.bgfb021_desc_t = ''
      END IF
   END IF
   DISPLAY BY NAME g_bgfb_m.bgfb013,g_bgfb_m.bgfb014,g_bgfb_m.bgfb015,g_bgfb_m.bgfb016,g_bgfb_m.bgfb017,
                   g_bgfb_m.bgfb018,g_bgfb_m.bgfb019,g_bgfb_m.bgfb020,g_bgfb_m.bgfb021,g_bgfb_m.bgfb022,
                   g_bgfb_m.bgfb023,g_bgfb_m.bgfb024,
                   g_bgfb_m.bgfb013_desc_t,g_bgfb_m.bgfb014_desc_t,g_bgfb_m.bgfb015_desc_t,g_bgfb_m.bgfb016_desc_t,
                   g_bgfb_m.bgfb017_desc_t,g_bgfb_m.bgfb018_desc_t,g_bgfb_m.bgfb019_desc_t,g_bgfb_m.bgfb020_desc_t,
                   g_bgfb_m.bgfb021_desc_t,g_bgfb_m.bgfb023_desc_t,g_bgfb_m.bgfb024_desc_t
   
END FUNCTION

################################################################################
# Descriptions...: 根据预算编号+预算组织+预算细项设置核算项的启用情况，启用时可以录入，不启用时不可录入，默认给空白
# Memo...........:
# Usage..........: CALL abgt620_set_detail_hsx_entry(p_bgfb002,p_bgfb007,p_bgfb009)
# Input parameter: p_bgfb002      预算编号
#                : p_bgfb007      预算组织
#                : p_bgfb009      预算细项
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_set_detail_hsx_entry(p_bgfb002,p_bgfb007,p_bgfb009)
   DEFINE p_bgfb002       LIKE bgfb_t.bgfb002
   DEFINE p_bgfb007       LIKE bgfb_t.bgfb007
   DEFINE p_bgfb009       LIKE bgfb_t.bgfb009
   
   IF cl_null(p_bgfb002) OR cl_null(p_bgfb007) OR cl_null(p_bgfb009) THEN
      RETURN
   END IF
   
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=p_bgfb002
      AND bgal002=p_bgfb007 AND bgal003=p_bgfb009
   #单身核算项栏位录入设置
   #部门
   IF g_bgaw2[3]='Y' THEN
      IF g_bgal.bgal005 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb013_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb013_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb013 = ' '
      END IF
   END IF
   #利润成本中心
   IF g_bgaw2[4]='Y' THEN
      IF g_bgal.bgal006 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb014_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb014_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb014 = ' '
      END IF
   END IF
   #区域
   IF g_bgaw2[5]='Y' THEN
      IF g_bgal.bgal007 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb015_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb015_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb015 = ' '
      END IF
   END IF
   #收付款客商
   IF g_bgaw2[6]='Y' THEN
      IF g_bgal.bgal008 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb016_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb016_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb016 = ' '
      END IF
   END IF 
   #账款客商
   IF g_bgaw2[7]='Y' THEN
      IF g_bgal.bgal009 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb017_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb017_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb017 = ' '
      END IF
   END IF  
   #客群
   IF g_bgaw2[8]='Y' THEN
      IF g_bgal.bgal010 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb018_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb018_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb018 = ' '
      END IF
   END IF
   #产品类别
   IF g_bgaw2[9]='Y' THEN
      IF g_bgal.bgal011 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb019_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb019_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb019 = ' '
      END IF
   END IF
   #经营方式
   IF g_bgaw2[10]='Y' THEN
      IF g_bgal.bgal025 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb022_2",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb022_2",FALSE)
         LET g_bgfb_d[l_ac].bgfb022 = ' '
      END IF
   END IF
   #通路
   IF g_bgaw2[11]='Y' THEN
      IF g_bgal.bgal026 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb023_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb023_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb023 = ' '
      END IF
   END IF
   #品牌
   IF g_bgaw2[12]='Y' THEN
      IF g_bgal.bgal027 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb024_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb024_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb024 = ' '
      END IF
   END IF
   #人员
   IF g_bgaw2[13]='Y' THEN
      IF g_bgal.bgal012 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb012_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb012_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb012 = ' '
      END IF
   END IF
   #专案
   IF g_bgaw2[14]='Y' THEN
      IF g_bgal.bgal013 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb020_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb020_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb020 = ' '
      END IF
   END IF
   #WBS
   IF g_bgaw2[15]='Y' THEN
      IF g_bgal.bgal014 = 'Y' THEN
         CALL cl_set_comp_entry("bgfb021_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgfb021_desc",FALSE)
         LET g_bgfb_d[l_ac].bgfb021 = ' '
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示单头核算项说明
# Memo...........:
# Usage..........: CALL abgt620_head_hsx_desc()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_head_hsx_desc()
   #单头显示栏位
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgfb_m.bgfb007) RETURNING g_bgfb_m.bgfb007_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb007_desc_t
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgfb_m.bgfb013) RETURNING g_bgfb_m.bgfb013_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb013_desc_t
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgfb_m.bgfb014) RETURNING g_bgfb_m.bgfb014_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb014_desc_t
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      CALL s_desc_get_acc_desc('287',g_bgfb_m.bgfb015) RETURNING g_bgfb_m.bgfb015_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb015_desc_t
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgfb_m.bgfb016) RETURNING g_bgfb_m.bgfb016_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb016_desc_t
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgfb_m.bgfb017) RETURNING g_bgfb_m.bgfb017_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb017_desc_t
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      CALL s_desc_get_acc_desc('281',g_bgfb_m.bgfb018) RETURNING g_bgfb_m.bgfb018_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb018_desc_t
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      CALL s_desc_get_rtaxl003_desc(g_bgfb_m.bgfb019) RETURNING g_bgfb_m.bgfb019_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb019_desc_t
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgfb_m.bgfb023) RETURNING g_bgfb_m.bgfb023_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb023_desc_t
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      CALL s_desc_get_acc_desc('2002',g_bgfb_m.bgfb024) RETURNING g_bgfb_m.bgfb024_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb024_desc_t
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      CALL s_desc_get_person_desc(g_bgfb_m.bgfb012) RETURNING g_bgfb_m.bgfb012_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb012_desc_t
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgfb_m.bgfb020) RETURNING g_bgfb_m.bgfb020_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb020_desc_t
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      CALL s_desc_get_wbs_desc(g_bgfb_m.bgfb020,g_bgfb_m.bgfb021) RETURNING g_bgfb_m.bgfb021_desc_t
      DISPLAY BY NAME g_bgfb_m.bgfb021_desc_t
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 获取该项次对应的各个期别的金额
# Memo...........:
# Usage..........: CALL abgt620_get_amt()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_get_amt()
   DEFINE l_sql          STRING
   DEFINE l_bgfb008      LIKE bgfb_t.bgfb008
   DEFINE l_bgfb037      LIKE bgfb_t.bgfb037
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   
   LET l_sql="SELECT bgfb008,bgfb037 ",
             "  FROM bgfb_t ",
             " WHERE bgfbent=",g_enterprise," AND bgfb001='",g_bgfb_m.bgfb001,"' ",
             "   AND bgfb002='",g_bgfb_m.bgfb002,"' AND bgfb003='",g_bgfb_m.bgfb003,"' ",
             "   AND bgfb004='",g_bgfb_m.bgfb004,"' AND bgfb005='",g_bgfb_m.bgfb005,"' ",
             "   AND bgfb006='",g_bgfb_m.bgfb006,"' AND bgfbseq=",g_bgfb_d[l_ac].bgfbseq
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb007='",g_bgfb_m.bgfb007,"'"
   ELSE
      LET l_sql = l_sql," AND bgfb007='",g_bgfb_d[l_ac].bgfb007,"'"
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb009='",g_bgfb_m.bgfb009,"'"
   ELSE
      LET l_sql = l_sql," AND bgfb009='",g_bgfb_d[l_ac].bgfb009,"'"
   END IF
   LET l_sql = l_sql," ORDER BY bgfb008"
   PREPARE abgt620_sel_amt_pr FROM l_sql
   DECLARE abgt620_sel_amt_cs CURSOR FOR abgt620_sel_amt_pr
   
   FOREACH abgt620_sel_amt_cs INTO l_bgfb008,l_bgfb037
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CASE l_bgfb008
         WHEN 1
            LET g_bgfb_d[l_ac].amt1=l_bgfb037
         WHEN 2
            LET g_bgfb_d[l_ac].amt2=l_bgfb037
         WHEN 3
            LET g_bgfb_d[l_ac].amt3=l_bgfb037
         WHEN 4
            LET g_bgfb_d[l_ac].amt4=l_bgfb037
         WHEN 5
            LET g_bgfb_d[l_ac].amt5=l_bgfb037
         WHEN 6
            LET g_bgfb_d[l_ac].amt6=l_bgfb037 
         WHEN 7
            LET g_bgfb_d[l_ac].amt7=l_bgfb037
         WHEN 8
            LET g_bgfb_d[l_ac].amt8=l_bgfb037
         WHEN 9
            LET g_bgfb_d[l_ac].amt9=l_bgfb037
         WHEN 10
            LET g_bgfb_d[l_ac].amt10=l_bgfb037
         WHEN 11
            LET g_bgfb_d[l_ac].amt11=l_bgfb037
         WHEN 12
            LET g_bgfb_d[l_ac].amt12=l_bgfb037    
         WHEN 13
            LET g_bgfb_d[l_ac].amt13=l_bgfb037 
      END CASE      
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 获取核算项单身核算项说明
# Memo...........:
# Usage..........: CALL abgt620_detail_hsx_desc()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_detail_hsx_desc()
   DEFINE l_bgasl003    LIKE bgasl_t.bgasl003
   DEFINE l_bgasl004    LIKE bgasl_t.bgasl004
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   
   #单身显示栏位
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb007) RETURNING g_bgfb_d[l_ac].bgfb007_desc
      LET g_bgfb_d[l_ac].bgfb007_desc=g_bgfb_d[l_ac].bgfb007,"  ",g_bgfb_d[l_ac].bgfb007_desc
   END IF
   #预算细项
   IF g_bgaw2[2] = 'Y' THEN
      CALL s_abg_bgae001_desc(g_bgaa008,g_bgfb_d[l_ac].bgfb009) RETURNING g_bgfb_d[l_ac].bgfb009_desc
      LET g_bgfb_d[l_ac].bgfb009_desc = g_bgfb_d[l_ac].bgfb009,"  ",g_bgfb_d[l_ac].bgfb009_desc
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb013) RETURNING g_bgfb_d[l_ac].bgfb013_desc
      LET g_bgfb_d[l_ac].bgfb013_desc=g_bgfb_d[l_ac].bgfb013,"  ",g_bgfb_d[l_ac].bgfb013_desc
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgfb_d[l_ac].bgfb014) RETURNING g_bgfb_d[l_ac].bgfb014_desc
      LET g_bgfb_d[l_ac].bgfb014_desc=g_bgfb_d[l_ac].bgfb014,"  ",g_bgfb_d[l_ac].bgfb014_desc
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      CALL s_desc_get_acc_desc('287',g_bgfb_d[l_ac].bgfb015) RETURNING g_bgfb_d[l_ac].bgfb015_desc
      LET g_bgfb_d[l_ac].bgfb015_desc=g_bgfb_d[l_ac].bgfb015,"  ",g_bgfb_d[l_ac].bgfb015_desc
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgfb_d[l_ac].bgfb016) RETURNING g_bgfb_d[l_ac].bgfb016_desc
      LET g_bgfb_d[l_ac].bgfb016_desc=g_bgfb_d[l_ac].bgfb016,"  ",g_bgfb_d[l_ac].bgfb016_desc
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgfb_d[l_ac].bgfb017) RETURNING g_bgfb_d[l_ac].bgfb017_desc
      LET g_bgfb_d[l_ac].bgfb017_desc=g_bgfb_d[l_ac].bgfb017,"  ",g_bgfb_d[l_ac].bgfb017_desc
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      CALL s_desc_get_acc_desc('281',g_bgfb_d[l_ac].bgfb018) RETURNING g_bgfb_d[l_ac].bgfb018_desc
      LET g_bgfb_d[l_ac].bgfb018_desc=g_bgfb_d[l_ac].bgfb018,"  ",g_bgfb_d[l_ac].bgfb018_desc
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      CALL s_desc_get_rtaxl003_desc(g_bgfb_d[l_ac].bgfb019) RETURNING g_bgfb_d[l_ac].bgfb019_desc
      LET g_bgfb_d[l_ac].bgfb019_desc=g_bgfb_d[l_ac].bgfb019,"  ",g_bgfb_d[l_ac].bgfb019_desc
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgfb_d[l_ac].bgfb023) RETURNING g_bgfb_d[l_ac].bgfb023_desc
      LET g_bgfb_d[l_ac].bgfb023_desc=g_bgfb_d[l_ac].bgfb023,"  ",g_bgfb_d[l_ac].bgfb023_desc
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      CALL s_desc_get_acc_desc('2002',g_bgfb_d[l_ac].bgfb024) RETURNING g_bgfb_d[l_ac].bgfb024_desc
      LET g_bgfb_d[l_ac].bgfb024_desc=g_bgfb_d[l_ac].bgfb024,"  ",g_bgfb_d[l_ac].bgfb024_desc
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      CALL s_desc_get_person_desc(g_bgfb_d[l_ac].bgfb012) RETURNING g_bgfb_d[l_ac].bgfb012_desc
      LET g_bgfb_d[l_ac].bgfb012_desc=g_bgfb_d[l_ac].bgfb012,"  ",g_bgfb_d[l_ac].bgfb012_desc
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgfb_d[l_ac].bgfb020) RETURNING g_bgfb_d[l_ac].bgfb020_desc
      LET g_bgfb_d[l_ac].bgfb020_desc=g_bgfb_d[l_ac].bgfb020,"  ",g_bgfb_d[l_ac].bgfb020_desc
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      CALL s_desc_get_wbs_desc(g_bgfb_d[l_ac].bgfb020,g_bgfb_d[l_ac].bgfb021) RETURNING g_bgfb_d[l_ac].bgfb021_desc
      LET g_bgfb_d[l_ac].bgfb021_desc=g_bgfb_d[l_ac].bgfb021,"  ",g_bgfb_d[l_ac].bgfb021_desc
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 插入bgfb_t资料
# Memo...........:
# Usage..........: CALL abgt620_insert_bgfb()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     执行结果TRUE/FALSE 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_insert_bgfb()
   DEFINE l_bgfb RECORD  #銷售預算主檔
          bgfbent LIKE bgfb_t.bgfbent, #企业编号
          bgfb001 LIKE bgfb_t.bgfb001, #来源作业
          bgfb002 LIKE bgfb_t.bgfb002, #预算编号
          bgfb003 LIKE bgfb_t.bgfb003, #版本
          bgfb004 LIKE bgfb_t.bgfb004, #管理组织
          bgfb005 LIKE bgfb_t.bgfb005, #销售来源
          bgfb006 LIKE bgfb_t.bgfb006, #数据类型
          bgfb007 LIKE bgfb_t.bgfb007, #预算组织
          bgfb008 LIKE bgfb_t.bgfb008, #预算期别
          bgfb009 LIKE bgfb_t.bgfb009, #预算细项
          bgfb010 LIKE bgfb_t.bgfb010, #组合KEY
          bgfbseq LIKE bgfb_t.bgfbseq, #项次
          bgfb011 LIKE bgfb_t.bgfb011, #预算样表
          bgfb012 LIKE bgfb_t.bgfb012, #人员
          bgfb013 LIKE bgfb_t.bgfb013, #部门
          bgfb014 LIKE bgfb_t.bgfb014, #成本利润中心
          bgfb015 LIKE bgfb_t.bgfb015, #区域
          bgfb016 LIKE bgfb_t.bgfb016, #收付款客商
          bgfb017 LIKE bgfb_t.bgfb017, #账款客商
          bgfb018 LIKE bgfb_t.bgfb018, #客群
          bgfb019 LIKE bgfb_t.bgfb019, #产品类别
          bgfb020 LIKE bgfb_t.bgfb020, #项目编号
          bgfb021 LIKE bgfb_t.bgfb021, #WBS
          bgfb022 LIKE bgfb_t.bgfb022, #经营方式
          bgfb023 LIKE bgfb_t.bgfb023, #渠道
          bgfb024 LIKE bgfb_t.bgfb024, #品牌
          bgfb025 LIKE bgfb_t.bgfb025, #自由核算项一
          bgfb026 LIKE bgfb_t.bgfb026, #自由核算项二
          bgfb027 LIKE bgfb_t.bgfb027, #自由核算项三
          bgfb028 LIKE bgfb_t.bgfb028, #自由核算项四
          bgfb029 LIKE bgfb_t.bgfb029, #自由核算项五
          bgfb030 LIKE bgfb_t.bgfb030, #自由核算项六
          bgfb031 LIKE bgfb_t.bgfb031, #自由核算项七
          bgfb032 LIKE bgfb_t.bgfb032, #自由核算项八
          bgfb033 LIKE bgfb_t.bgfb033, #自由核算项九
          bgfb034 LIKE bgfb_t.bgfb034, #自由核算项十
          bgfb035 LIKE bgfb_t.bgfb035, #税种
          bgfb036 LIKE bgfb_t.bgfb036, #含税否
          bgfb037 LIKE bgfb_t.bgfb037, #原币费用金额
          bgfb038 LIKE bgfb_t.bgfb038, #本层调整金额
          bgfb039 LIKE bgfb_t.bgfb039, #上层调整金额
          bgfb047 LIKE bgfb_t.bgfb047, #上层组织
          bgfb048 LIKE bgfb_t.bgfb048, #凭证编号
          bgfb100 LIKE bgfb_t.bgfb100, #交易币种
          bgfb101 LIKE bgfb_t.bgfb101, #汇率
          bgfb102 LIKE bgfb_t.bgfb102, #核准原币销售金额
          bgfb103 LIKE bgfb_t.bgfb103, #核准原币税前金额
          bgfb104 LIKE bgfb_t.bgfb104, #核准原币税额
          bgfb105 LIKE bgfb_t.bgfb105, #核准原币含税金额
          bgfbownid LIKE bgfb_t.bgfbownid, #资料所有者
          bgfbowndp LIKE bgfb_t.bgfbowndp, #资料所有部门
          bgfbcrtid LIKE bgfb_t.bgfbcrtid, #资料录入者
          bgfbcrtdp LIKE bgfb_t.bgfbcrtdp, #资料录入部门
          bgfbcrtdt LIKE bgfb_t.bgfbcrtdt, #资料创建日
          bgfbmodid LIKE bgfb_t.bgfbmodid, #资料更改者
          bgfbmoddt LIKE bgfb_t.bgfbmoddt, #最近更改日
          bgfbcnfid LIKE bgfb_t.bgfbcnfid, #资料审核者
          bgfbcnfdt LIKE bgfb_t.bgfbcnfdt, #数据审核日
          bgfbstus LIKE bgfb_t.bgfbstus, #状态码
          bgfbud001 LIKE bgfb_t.bgfbud001, #自定义字段(文本)001
          bgfbud002 LIKE bgfb_t.bgfbud002, #自定义字段(文本)002
          bgfbud003 LIKE bgfb_t.bgfbud003, #自定义字段(文本)003
          bgfbud004 LIKE bgfb_t.bgfbud004, #自定义字段(文本)004
          bgfbud005 LIKE bgfb_t.bgfbud005, #自定义字段(文本)005
          bgfbud006 LIKE bgfb_t.bgfbud006, #自定义字段(文本)006
          bgfbud007 LIKE bgfb_t.bgfbud007, #自定义字段(文本)007
          bgfbud008 LIKE bgfb_t.bgfbud008, #自定义字段(文本)008
          bgfbud009 LIKE bgfb_t.bgfbud009, #自定义字段(文本)009
          bgfbud010 LIKE bgfb_t.bgfbud010, #自定义字段(文本)010
          bgfbud011 LIKE bgfb_t.bgfbud011, #自定义字段(数字)011
          bgfbud012 LIKE bgfb_t.bgfbud012, #自定义字段(数字)012
          bgfbud013 LIKE bgfb_t.bgfbud013, #自定义字段(数字)013
          bgfbud014 LIKE bgfb_t.bgfbud014, #自定义字段(数字)014
          bgfbud015 LIKE bgfb_t.bgfbud015, #自定义字段(数字)015
          bgfbud016 LIKE bgfb_t.bgfbud016, #自定义字段(数字)016
          bgfbud017 LIKE bgfb_t.bgfbud017, #自定义字段(数字)017
          bgfbud018 LIKE bgfb_t.bgfbud018, #自定义字段(数字)018
          bgfbud019 LIKE bgfb_t.bgfbud019, #自定义字段(数字)019
          bgfbud020 LIKE bgfb_t.bgfbud020, #自定义字段(数字)020
          bgfbud021 LIKE bgfb_t.bgfbud021, #自定义字段(日期时间)021
          bgfbud022 LIKE bgfb_t.bgfbud022, #自定义字段(日期时间)022
          bgfbud023 LIKE bgfb_t.bgfbud023, #自定义字段(日期时间)023
          bgfbud024 LIKE bgfb_t.bgfbud024, #自定义字段(日期时间)024
          bgfbud025 LIKE bgfb_t.bgfbud025, #自定义字段(日期时间)025
          bgfbud026 LIKE bgfb_t.bgfbud026, #自定义字段(日期时间)026
          bgfbud027 LIKE bgfb_t.bgfbud027, #自定义字段(日期时间)027
          bgfbud028 LIKE bgfb_t.bgfbud028, #自定义字段(日期时间)028
          bgfbud029 LIKE bgfb_t.bgfbud029, #自定义字段(日期时间)029
          bgfbud030 LIKE bgfb_t.bgfbud030  #自定义字段(日期时间)030
   END RECORD
   DEFINE l_i            LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgfb103      LIKE bgfb_t.bgfb103
   DEFINE l_bgfb104      LIKE bgfb_t.bgfb104
   DEFINE l_bgfb105      LIKE bgfb_t.bgfb105
   DEFINE l_day          LIKE type_t.num5 #161220-00036#1 add
   DEFINE l_date         LIKE type_t.dat  #161220-00036#1 add
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgfb.bgfb007 = g_bgfb_m.bgfb007
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgfb.bgfb009 = g_bgfb_m.bgfb009
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgfb.bgfb013 = g_bgfb_m.bgfb013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgfb.bgfb014 = g_bgfb_m.bgfb014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgfb.bgfb015 = g_bgfb_m.bgfb015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgfb.bgfb016 = g_bgfb_m.bgfb016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgfb.bgfb017 = g_bgfb_m.bgfb017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgfb.bgfb018 = g_bgfb_m.bgfb018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgfb.bgfb019 = g_bgfb_m.bgfb019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgfb.bgfb022= g_bgfb_m.bgfb022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgfb.bgfb023= g_bgfb_m.bgfb023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgfb.bgfb024= g_bgfb_m.bgfb024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgfb.bgfb012= g_bgfb_m.bgfb012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgfb.bgfb020= g_bgfb_m.bgfb020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgfb.bgfb021= g_bgfb_m.bgfb021
   END IF
   
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgfb.bgfb007 = g_bgfb_d[l_ac].bgfb007
   END IF
   #预算细项
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgfb.bgfb009 = g_bgfb_d[l_ac].bgfb009
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgfb.bgfb013 = g_bgfb_d[l_ac].bgfb013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgfb.bgfb014 = g_bgfb_d[l_ac].bgfb014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgfb.bgfb015 = g_bgfb_d[l_ac].bgfb015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgfb.bgfb016 = g_bgfb_d[l_ac].bgfb016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgfb.bgfb017 = g_bgfb_d[l_ac].bgfb017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgfb.bgfb018 = g_bgfb_d[l_ac].bgfb018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgfb.bgfb019 = g_bgfb_d[l_ac].bgfb019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgfb.bgfb022= g_bgfb_d[l_ac].bgfb022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgfb.bgfb023= g_bgfb_d[l_ac].bgfb023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgfb.bgfb024= g_bgfb_d[l_ac].bgfb024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgfb.bgfb012= g_bgfb_d[l_ac].bgfb012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgfb.bgfb020= g_bgfb_d[l_ac].bgfb020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgfb.bgfb021= g_bgfb_d[l_ac].bgfb021
   END IF
   
   #当核算项不使用时，核算项默认给空格
   #部门
   IF g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N' THEN
      LET l_bgfb.bgfb013 = ' '
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N' THEN
      LET l_bgfb.bgfb014 = ' '
   END IF
   #区域
   IF g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N' THEN
      LET l_bgfb.bgfb015 = ' '
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N' THEN
      LET l_bgfb.bgfb016 = ' '
   END IF
   #账款客商
   IF g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N' THEN
      LET l_bgfb.bgfb017 = ' '
   END IF
   #客群
   IF g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N' THEN
      LET l_bgfb.bgfb018 = ' '
   END IF
   #产品类别
   IF g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N' THEN
      LET l_bgfb.bgfb019 = ' '
   END IF
   #经营方式
   IF g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N' THEN
      LET l_bgfb.bgfb022= ' '
   END IF
   #通路
   IF g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N' THEN
      LET l_bgfb.bgfb023= ' '
   END IF
   #品牌
   IF g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N' THEN
      LET l_bgfb.bgfb024= ' '
   END IF
   #人员
   IF g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N' THEN
      LET l_bgfb.bgfb012= ' '
   END IF
   #专案
   IF g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N' THEN
      LET l_bgfb.bgfb020= ' '
   END IF
   #WBS
   IF g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N' THEN
      LET l_bgfb.bgfb021= ' '
   END IF
   
   #组合key bgfb010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET l_bgfb.bgfb010 = "bgfb013=",l_bgfb.bgfb013,"/",
                        "bgfb014=",l_bgfb.bgfb014,"/",
                        "bgfb015=",l_bgfb.bgfb015,"/",
                        "bgfb016=",l_bgfb.bgfb016,"/",
                        "bgfb017=",l_bgfb.bgfb017,"/",
                        "bgfb018=",l_bgfb.bgfb018,"/",
                        "bgfb019=",l_bgfb.bgfb019,"/",
                        "bgfb022=",l_bgfb.bgfb022,"/",
                        "bgfb023=",l_bgfb.bgfb023,"/",
                        "bgfb024=",l_bgfb.bgfb024,"/",
                        "bgfb012=",l_bgfb.bgfb012,"/",
                        "bgfb020=",l_bgfb.bgfb020,"/",
                        "bgfb021=",l_bgfb.bgfb021,""
   LET l_bgfb.bgfb038 = 0
   LET l_bgfb.bgfb039 = 0
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgfb.bgfb008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt1
         WHEN 2
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt2
         WHEN 3
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt3
         WHEN 4
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt4
         WHEN 5
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt5
         WHEN 6
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt6
         WHEN 7
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt7
         WHEN 8
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt8
         WHEN 9
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt9
         WHEN 10
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt10
         WHEN 11
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt11
         WHEN 12
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt12
         WHEN 13
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt13
      END CASE
      
      LET l_bgfb.bgfb102 = l_bgfb.bgfb037
      #161220-00036#1--add--str--
      #汇率
      #170103-00013#1--mod--str--
#      CALL s_date_get_max_day(g_bgfb_m.bgaa002,l_bgfb.bgfb008) RETURNING l_day
#      LET l_date=MDY(l_bgfb.bgfb008,l_day,g_bgfb_m.bgaa002)
      CALL s_abg2_get_max_bgac002(g_bgfb_m.bgaa002,l_bgfb.bgfb008) RETURNING l_date
      #170103-00013#1--mod--end
      CALL s_abg_get_bg_rate(g_bgfb_m.bgfb002,l_date,g_bgfb_d[l_ac].bgfb100,g_bgfb_m.bgaa003)
      RETURNING l_bgfb.bgfb101
      #161220-00036#1--add--end
      #以稅別計算出來含税金额、未税金额、税额
#      CALL s_tax_count(l_bgfb.bgfb007,g_bgfb_d[l_ac].bgfb035,l_bgfb.bgfb102,1,g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb101) #161220-00036#1 mark
      CALL s_tax_count(l_bgfb.bgfb007,g_bgfb_d[l_ac].bgfb035,l_bgfb.bgfb102,1,g_bgfb_d[l_ac].bgfb100,l_bgfb.bgfb101) #161220-00036#1 add
      RETURNING l_bgfb.bgfb103,l_bgfb.bgfb104,l_bgfb.bgfb105,l_bgfb103,l_bgfb104,l_bgfb105
      
      INSERT INTO bgfb_t
            (bgfbent,bgfb002,bgfb003,bgfb004,bgfb011,bgfb001,bgfb005,bgfb006,bgfbstus,
             bgfb007,bgfb009,bgfb008,bgfb010,bgfbseq,
             bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,
             bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,
             bgfb035,bgfb036,bgfb037,bgfb038,bgfb039,
             bgfb047,bgfb048,bgfb100,bgfb101,
             bgfb102,bgfb103,bgfb104,bgfb105,
             bgfbownid,bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt,
             bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt) 
      VALUES(g_enterprise,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,
             g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfbstus,
             l_bgfb.bgfb007,l_bgfb.bgfb009,l_bgfb.bgfb008,l_bgfb.bgfb010,g_bgfb_d[l_ac].bgfbseq,
             l_bgfb.bgfb012,l_bgfb.bgfb013,l_bgfb.bgfb014,l_bgfb.bgfb015,l_bgfb.bgfb016,l_bgfb.bgfb017,
             l_bgfb.bgfb018,l_bgfb.bgfb019,l_bgfb.bgfb020,l_bgfb.bgfb021,l_bgfb.bgfb022,l_bgfb.bgfb023,l_bgfb.bgfb024,
             g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036,l_bgfb.bgfb037,l_bgfb.bgfb038,l_bgfb.bgfb039,
#             g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb101, #161220-00036#1 mark
             g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048,g_bgfb_d[l_ac].bgfb100,l_bgfb.bgfb101, #161220-00036#1 add
             l_bgfb.bgfb102,l_bgfb.bgfb103,l_bgfb.bgfb104,l_bgfb.bgfb105,
             g_bgfb2_d[l_ac].bgfbownid,g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid, 
             g_bgfb2_d[l_ac].bgfbcrtdp,g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid, 
             g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid,g_bgfb2_d[l_ac].bgfbcnfdt) 
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE                  
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF
   END FOR
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 重写单头更新资料
# Memo...........:
# Usage..........: CALL abgt620_update_head()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_update_head()
   DEFINE l_sql           STRING
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING 
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_bgfb RECORD  #費用預算主檔
          bgfbent LIKE bgfb_t.bgfbent, #企業編號
          bgfb001 LIKE bgfb_t.bgfb001, #來源作業
          bgfb002 LIKE bgfb_t.bgfb002, #預算編號
          bgfb003 LIKE bgfb_t.bgfb003, #版本
          bgfb004 LIKE bgfb_t.bgfb004, #管理組織
          bgfb005 LIKE bgfb_t.bgfb005, #費用來源
          bgfb006 LIKE bgfb_t.bgfb006, #資料類型
          bgfb007 LIKE bgfb_t.bgfb007, #預算組織
          bgfb008 LIKE bgfb_t.bgfb008, #預算期別
          bgfb009 LIKE bgfb_t.bgfb009, #預算細項
          bgfb010 LIKE bgfb_t.bgfb010, #組合KEY
          bgfbseq LIKE bgfb_t.bgfbseq, #項次
          bgfb011 LIKE bgfb_t.bgfb011, #預算樣表
          bgfb012 LIKE bgfb_t.bgfb012, #人員
          bgfb013 LIKE bgfb_t.bgfb013, #部門
          bgfb014 LIKE bgfb_t.bgfb014, #成本利潤中心
          bgfb015 LIKE bgfb_t.bgfb015, #區域
          bgfb016 LIKE bgfb_t.bgfb016, #收付款客商
          bgfb017 LIKE bgfb_t.bgfb017, #帳款客商
          bgfb018 LIKE bgfb_t.bgfb018, #客群
          bgfb019 LIKE bgfb_t.bgfb019, #產品類別
          bgfb020 LIKE bgfb_t.bgfb020, #專案編號
          bgfb021 LIKE bgfb_t.bgfb021, #WBS
          bgfb022 LIKE bgfb_t.bgfb022, #經營方式
          bgfb023 LIKE bgfb_t.bgfb023, #通路
          bgfb024 LIKE bgfb_t.bgfb024, #品牌
          bgfb025 LIKE bgfb_t.bgfb025, #自由核算項一
          bgfb026 LIKE bgfb_t.bgfb026, #自由核算項二
          bgfb027 LIKE bgfb_t.bgfb027, #自由核算項三
          bgfb028 LIKE bgfb_t.bgfb028, #自由核算項四
          bgfb029 LIKE bgfb_t.bgfb029, #自由核算項五
          bgfb030 LIKE bgfb_t.bgfb030, #自由核算項六
          bgfb031 LIKE bgfb_t.bgfb031, #自由核算項七
          bgfb032 LIKE bgfb_t.bgfb032, #自由核算項八
          bgfb033 LIKE bgfb_t.bgfb033, #自由核算項九
          bgfb034 LIKE bgfb_t.bgfb034, #自由核算項十
          bgfb035 LIKE bgfb_t.bgfb035, #稅別
          bgfb036 LIKE bgfb_t.bgfb036, #含稅否
          bgfb037 LIKE bgfb_t.bgfb037, #原幣費用金額
          bgfb038 LIKE bgfb_t.bgfb038, #本層調整金額
          bgfb039 LIKE bgfb_t.bgfb039, #上層調整金額
          bgfb047 LIKE bgfb_t.bgfb047, #上層組織
          bgfb048 LIKE bgfb_t.bgfb048, #憑證單號
          bgfb100 LIKE bgfb_t.bgfb100, #交易幣別
          bgfb101 LIKE bgfb_t.bgfb101, #匯率
          bgfb102 LIKE bgfb_t.bgfb102, #核准原幣費用金額
          bgfb103 LIKE bgfb_t.bgfb103, #核准原幣未稅金額
          bgfb104 LIKE bgfb_t.bgfb104, #核准原幣稅額
          bgfb105 LIKE bgfb_t.bgfb105, #核准原幣含稅金額
          bgfbstus LIKE bgfb_t.bgfbstus, #狀態碼
          bgfbownid LIKE bgfb_t.bgfbownid, #資料所有者
          bgfbowndp LIKE bgfb_t.bgfbowndp, #資料所屬部門
          bgfbcrtid LIKE bgfb_t.bgfbcrtid, #資料建立者
          bgfbcrtdp LIKE bgfb_t.bgfbcrtdp, #資料建立部門
          bgfbcrtdt LIKE bgfb_t.bgfbcrtdt, #資料創建日
          bgfbmodid LIKE bgfb_t.bgfbmodid, #資料修改者
          bgfbmoddt LIKE bgfb_t.bgfbmoddt, #最近修改日
          bgfbcnfid LIKE bgfb_t.bgfbcnfid, #資料確認者
          bgfbcnfdt LIKE bgfb_t.bgfbcnfdt, #資料確認日
          bgfbud001 LIKE bgfb_t.bgfbud001, #自定義欄位(文字)001
          bgfbud002 LIKE bgfb_t.bgfbud002, #自定義欄位(文字)002
          bgfbud003 LIKE bgfb_t.bgfbud003, #自定義欄位(文字)003
          bgfbud004 LIKE bgfb_t.bgfbud004, #自定義欄位(文字)004
          bgfbud005 LIKE bgfb_t.bgfbud005, #自定義欄位(文字)005
          bgfbud006 LIKE bgfb_t.bgfbud006, #自定義欄位(文字)006
          bgfbud007 LIKE bgfb_t.bgfbud007, #自定義欄位(文字)007
          bgfbud008 LIKE bgfb_t.bgfbud008, #自定義欄位(文字)008
          bgfbud009 LIKE bgfb_t.bgfbud009, #自定義欄位(文字)009
          bgfbud010 LIKE bgfb_t.bgfbud010, #自定義欄位(文字)010
          bgfbud011 LIKE bgfb_t.bgfbud011, #自定義欄位(數字)011
          bgfbud012 LIKE bgfb_t.bgfbud012, #自定義欄位(數字)012
          bgfbud013 LIKE bgfb_t.bgfbud013, #自定義欄位(數字)013
          bgfbud014 LIKE bgfb_t.bgfbud014, #自定義欄位(數字)014
          bgfbud015 LIKE bgfb_t.bgfbud015, #自定義欄位(數字)015
          bgfbud016 LIKE bgfb_t.bgfbud016, #自定義欄位(數字)016
          bgfbud017 LIKE bgfb_t.bgfbud017, #自定義欄位(數字)017
          bgfbud018 LIKE bgfb_t.bgfbud018, #自定義欄位(數字)018
          bgfbud019 LIKE bgfb_t.bgfbud019, #自定義欄位(數字)019
          bgfbud020 LIKE bgfb_t.bgfbud020, #自定義欄位(數字)020
          bgfbud021 LIKE bgfb_t.bgfbud021, #自定義欄位(日期時間)021
          bgfbud022 LIKE bgfb_t.bgfbud022, #自定義欄位(日期時間)022
          bgfbud023 LIKE bgfb_t.bgfbud023, #自定義欄位(日期時間)023
          bgfbud024 LIKE bgfb_t.bgfbud024, #自定義欄位(日期時間)024
          bgfbud025 LIKE bgfb_t.bgfbud025, #自定義欄位(日期時間)025
          bgfbud026 LIKE bgfb_t.bgfbud026, #自定義欄位(日期時間)026
          bgfbud027 LIKE bgfb_t.bgfbud027, #自定義欄位(日期時間)027
          bgfbud028 LIKE bgfb_t.bgfbud028, #自定義欄位(日期時間)028
          bgfbud029 LIKE bgfb_t.bgfbud029, #自定義欄位(日期時間)029
          bgfbud030 LIKE bgfb_t.bgfbud030  #自定義欄位(日期時間)030
   END RECORD
   DEFINE l_bgal RECORD  #預算專案維護檔
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
          bgal015 LIKE bgal_t.bgal015, #自由核算項一
          bgal016 LIKE bgal_t.bgal016, #自由核算項二
          bgal017 LIKE bgal_t.bgal017, #自由核算項三
          bgal018 LIKE bgal_t.bgal018, #自由核算項四
          bgal019 LIKE bgal_t.bgal019, #自由核算項五
          bgal020 LIKE bgal_t.bgal020, #自由核算項六
          bgal021 LIKE bgal_t.bgal021, #自由核算項七
          bgal022 LIKE bgal_t.bgal022, #自由核算項八
          bgal023 LIKE bgal_t.bgal023, #自由核算項九
          bgal024 LIKE bgal_t.bgal024, #自由核算項十
          bgal025 LIKE bgal_t.bgal025, #經營方式
          bgal026 LIKE bgal_t.bgal026, #通路
          bgal027 LIKE bgal_t.bgal027  #品牌
   END RECORD
   DEFINE l_bgfb010_t     LIKE bgfb_t.bgfb010
   
   LET r_success = TRUE
                
   LET l_str1="bgfb002,bgfb003,bgfb004,bgfb011,bgfb001,bgfb005,bgfb006,bgfbstus"
   LET l_str2="'",g_bgfb_m.bgfb002,"','",g_bgfb_m.bgfb003,"','",g_bgfb_m.bgfb004,"','",g_bgfb_m.bgfb011,"',", 
              "'",g_bgfb_m.bgfb001,"','",g_bgfb_m.bgfb005,"','",g_bgfb_m.bgfb006,"','",g_bgfb_m.bgfbstus,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_str1=l_str1,",bgfb007"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb007,"'"
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_str1=l_str1,",bgfb009"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb009,"'"
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_str1=l_str1,",bgfb013"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb013,"'"
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_str1=l_str1,",bgfb014"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb014,"'"
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_str1=l_str1,",bgfb015"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb015,"'"
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_str1=l_str1,",bgfb016"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb016,"'"
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_str1=l_str1,",bgfb017"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb017,"'"
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_str1=l_str1,",bgfb018"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb018,"'"
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_str1=l_str1,",bgfb019"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb019,"'"
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_str1=l_str1,",bgfb022"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb022,"'"
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_str1=l_str1,",bgfb023"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb023,"'"
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_str1=l_str1,",bgfb024"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb024,"'"
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_str1=l_str1,",bgfb012"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb012,"'"
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_str1=l_str1,",bgfb020"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb020,"'"
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_str1=l_str1,",bgfb021"
      LET l_str2=l_str2,",'",g_bgfb_m.bgfb021,"'"
   END IF
   
   LET l_sql = "UPDATE bgfb_t SET (",l_str1,") = (",l_str2,")",
               " WHERE bgfbent =  ",g_enterprise,
               "   AND bgfb001 = '",g_bgfb001_t,"'",
               "   AND bgfb002 = '",g_bgfb002_t,"'",
               "   AND bgfb003 = '",g_bgfb003_t,"'",
               "   AND bgfb004 = '",g_bgfb004_t,"'",
               "   AND bgfb005 = '",g_bgfb005_t,"'",
               "   AND bgfb006 = '",g_bgfb006_t,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb007_t,"'"
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb009_t,"'"
   END IF
   PREPARE abgt620_update_head_pr FROM l_sql
   EXECUTE abgt620_update_head_pr
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgfb_t" 
         LET g_errparam.code   = "std-00009" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
   END CASE  
   #当更新单头资料报错时，返回FALSE，不在更新组合key
   IF r_success = FALSE THEN
      RETURN r_success
   END IF
   
   #单头核算项的改变会导致组合key 值的变化，这里重新更新组合key值
   LET l_sql = "SELECT DISTINCT bgfbseq,bgfb010,bgfb007,bgfb009,",
               "       bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,bgfb018,",
               "       bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024 ",
               "  FROM bgfb_t ",
               " WHERE bgfbent =  ",g_enterprise,
               "   AND bgfb001 = '",g_bgfb_m.bgfb001,"'",
               "   AND bgfb002 = '",g_bgfb_m.bgfb002,"'",
               "   AND bgfb003 = '",g_bgfb_m.bgfb003,"'",
               "   AND bgfb004 = '",g_bgfb_m.bgfb004,"'",
               "   AND bgfb005 = '",g_bgfb_m.bgfb005,"'",
               "   AND bgfb006 = '",g_bgfb_m.bgfb006,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb_m.bgfb007,"'"
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb_m.bgfb009,"'"
   END IF
   PREPARE abgt620_update_head_pr2 FROM l_sql
   DECLARE abgt620_update_head_cs2 CURSOR FOR abgt620_update_head_pr2
   
   FOREACH abgt620_update_head_cs2 INTO l_bgfb.bgfbseq,l_bgfb010_t,l_bgfb.bgfb007,l_bgfb.bgfb009,
                                        l_bgfb.bgfb012,l_bgfb.bgfb013,l_bgfb.bgfb014,l_bgfb.bgfb015,
                                        l_bgfb.bgfb016,l_bgfb.bgfb017,l_bgfb.bgfb018,l_bgfb.bgfb019,
                                        l_bgfb.bgfb020,l_bgfb.bgfb021,l_bgfb.bgfb022,l_bgfb.bgfb023,
                                        l_bgfb.bgfb024
      SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
             bgal010,bgal011,bgal012,bgal013,bgal014,
             bgal025,bgal026,bgal027 
        INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
             l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
             l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
        FROM bgal_t 
       WHERE bgalent=g_enterprise AND bgal001=g_bgfb_m.bgfb002
         AND bgal002=l_bgfb.bgfb007 AND bgal003=l_bgfb.bgfb009
      #部门
      IF (g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N') OR l_bgal.bgal005 = 'N' THEN
         LET l_bgfb.bgfb013 = ' '
      END IF
      #利润成本中心
      IF (g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N') OR l_bgal.bgal006 = 'N'  THEN
         LET l_bgfb.bgfb014 = ' '
      END IF
      #区域
      IF (g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N') OR l_bgal.bgal007 = 'N'  THEN
         LET l_bgfb.bgfb015 = ' '
      END IF
      #收付款客商
      IF (g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N') OR l_bgal.bgal008 = 'N'  THEN
         LET l_bgfb.bgfb016 = ' '
      END IF
      #账款客商
      IF (g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N') OR l_bgal.bgal009 = 'N'  THEN
         LET l_bgfb.bgfb017 = ' '
      END IF
      #客群
      IF (g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N') OR l_bgal.bgal010 = 'N'  THEN
         LET l_bgfb.bgfb018 = ' '
      END IF
      #产品类别
      IF (g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N') OR l_bgal.bgal011 = 'N' THEN
         LET l_bgfb.bgfb019 = ' '
      END IF
      #经营方式
      IF (g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N') OR l_bgal.bgal025 = 'N' THEN
         LET l_bgfb.bgfb022= ' '
      END IF
      #通路
      IF (g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N') OR l_bgal.bgal026 = 'N' THEN
         LET l_bgfb.bgfb023= ' '
      END IF
      #品牌
      IF (g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N') OR l_bgal.bgal027 = 'N' THEN
         LET l_bgfb.bgfb024= ' '
      END IF
      #人员
      IF (g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N') OR l_bgal.bgal012 = 'N' THEN
         LET l_bgfb.bgfb012= ' '
      END IF
      #专案
      IF (g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N') OR l_bgal.bgal013 = 'N' THEN
         LET l_bgfb.bgfb020= ' '
      END IF
      #WBS
      IF (g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N') OR l_bgal.bgal014 = 'N' THEN
         LET l_bgfb.bgfb021= ' '
      END IF
      
      #组合key bgfb010
      #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
      #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
      LET l_bgfb.bgfb010 = "bgfb013=",l_bgfb.bgfb013,"/",
                           "bgfb014=",l_bgfb.bgfb014,"/",
                           "bgfb015=",l_bgfb.bgfb015,"/",
                           "bgfb016=",l_bgfb.bgfb016,"/",
                           "bgfb017=",l_bgfb.bgfb017,"/",
                           "bgfb018=",l_bgfb.bgfb018,"/",
                           "bgfb019=",l_bgfb.bgfb019,"/",
                           "bgfb022=",l_bgfb.bgfb022,"/",
                           "bgfb023=",l_bgfb.bgfb023,"/",
                           "bgfb024=",l_bgfb.bgfb024,"/",
                           "bgfb012=",l_bgfb.bgfb012,"/",
                           "bgfb020=",l_bgfb.bgfb020,"/",
                           "bgfb021=",l_bgfb.bgfb021,""
                           
      UPDATE bgfb_t SET (bgfb010,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,
                         bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,
                         bgfb023,bgfb024) = (l_bgfb.bgfb010,l_bgfb.bgfb012, 
                         l_bgfb.bgfb013,l_bgfb.bgfb014,l_bgfb.bgfb015,l_bgfb.bgfb016, 
                         l_bgfb.bgfb017,l_bgfb.bgfb018,l_bgfb.bgfb019,l_bgfb.bgfb020, 
                         l_bgfb.bgfb021,l_bgfb.bgfb022,l_bgfb.bgfb023,l_bgfb.bgfb024)
       WHERE bgfbent = g_enterprise 
         AND bgfb001 = g_bgfb_m.bgfb001 
         AND bgfb002 = g_bgfb_m.bgfb002 
         AND bgfb003 = g_bgfb_m.bgfb003 
         AND bgfb004 = g_bgfb_m.bgfb004 
         AND bgfb005 = g_bgfb_m.bgfb005 
         AND bgfb006 = g_bgfb_m.bgfb006 
         AND bgfb007 = l_bgfb.bgfb007
         AND bgfb009 = l_bgfb.bgfb009
         AND bgfb010 = l_bgfb010_t
         AND bgfbseq = l_bgfb.bgfbseq 
     CASE
        WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgfb_t" 
           LET g_errparam.code   = "std-00009" 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOREACH
           
        WHEN SQLCA.sqlcode #其他錯誤
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOREACH
      END CASE
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新单身资料
# Memo...........:
# Usage..........: CALL abgt620_update_detail()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     执行结果TRUE/FALSE
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_update_detail()
   DEFINE l_bgfb RECORD  #銷售預算主檔
          bgfbent LIKE bgfb_t.bgfbent, #企业编号
          bgfb001 LIKE bgfb_t.bgfb001, #来源作业
          bgfb002 LIKE bgfb_t.bgfb002, #预算编号
          bgfb003 LIKE bgfb_t.bgfb003, #版本
          bgfb004 LIKE bgfb_t.bgfb004, #管理组织
          bgfb005 LIKE bgfb_t.bgfb005, #销售来源
          bgfb006 LIKE bgfb_t.bgfb006, #数据类型
          bgfb007 LIKE bgfb_t.bgfb007, #预算组织
          bgfb008 LIKE bgfb_t.bgfb008, #预算期别
          bgfb009 LIKE bgfb_t.bgfb009, #预算细项
          bgfb010 LIKE bgfb_t.bgfb010, #组合KEY
          bgfbseq LIKE bgfb_t.bgfbseq, #项次
          bgfb011 LIKE bgfb_t.bgfb011, #预算样表
          bgfb012 LIKE bgfb_t.bgfb012, #人员
          bgfb013 LIKE bgfb_t.bgfb013, #部门
          bgfb014 LIKE bgfb_t.bgfb014, #成本利润中心
          bgfb015 LIKE bgfb_t.bgfb015, #区域
          bgfb016 LIKE bgfb_t.bgfb016, #收付款客商
          bgfb017 LIKE bgfb_t.bgfb017, #账款客商
          bgfb018 LIKE bgfb_t.bgfb018, #客群
          bgfb019 LIKE bgfb_t.bgfb019, #产品类别
          bgfb020 LIKE bgfb_t.bgfb020, #项目编号
          bgfb021 LIKE bgfb_t.bgfb021, #WBS
          bgfb022 LIKE bgfb_t.bgfb022, #经营方式
          bgfb023 LIKE bgfb_t.bgfb023, #渠道
          bgfb024 LIKE bgfb_t.bgfb024, #品牌
          bgfb025 LIKE bgfb_t.bgfb025, #自由核算项一
          bgfb026 LIKE bgfb_t.bgfb026, #自由核算项二
          bgfb027 LIKE bgfb_t.bgfb027, #自由核算项三
          bgfb028 LIKE bgfb_t.bgfb028, #自由核算项四
          bgfb029 LIKE bgfb_t.bgfb029, #自由核算项五
          bgfb030 LIKE bgfb_t.bgfb030, #自由核算项六
          bgfb031 LIKE bgfb_t.bgfb031, #自由核算项七
          bgfb032 LIKE bgfb_t.bgfb032, #自由核算项八
          bgfb033 LIKE bgfb_t.bgfb033, #自由核算项九
          bgfb034 LIKE bgfb_t.bgfb034, #自由核算项十
          bgfb035 LIKE bgfb_t.bgfb035, #税种
          bgfb036 LIKE bgfb_t.bgfb036, #含税否
          bgfb037 LIKE bgfb_t.bgfb037, #原币费用金额
          bgfb038 LIKE bgfb_t.bgfb038, #本层调整金额
          bgfb039 LIKE bgfb_t.bgfb039, #上层调整金额
          bgfb047 LIKE bgfb_t.bgfb047, #上层组织
          bgfb048 LIKE bgfb_t.bgfb048, #凭证编号
          bgfb100 LIKE bgfb_t.bgfb100, #交易币种
          bgfb101 LIKE bgfb_t.bgfb101, #汇率
          bgfb102 LIKE bgfb_t.bgfb102, #核准原币销售金额
          bgfb103 LIKE bgfb_t.bgfb103, #核准原币税前金额
          bgfb104 LIKE bgfb_t.bgfb104, #核准原币税额
          bgfb105 LIKE bgfb_t.bgfb105, #核准原币含税金额
          bgfbownid LIKE bgfb_t.bgfbownid, #资料所有者
          bgfbowndp LIKE bgfb_t.bgfbowndp, #资料所有部门
          bgfbcrtid LIKE bgfb_t.bgfbcrtid, #资料录入者
          bgfbcrtdp LIKE bgfb_t.bgfbcrtdp, #资料录入部门
          bgfbcrtdt LIKE bgfb_t.bgfbcrtdt, #资料创建日
          bgfbmodid LIKE bgfb_t.bgfbmodid, #资料更改者
          bgfbmoddt LIKE bgfb_t.bgfbmoddt, #最近更改日
          bgfbcnfid LIKE bgfb_t.bgfbcnfid, #资料审核者
          bgfbcnfdt LIKE bgfb_t.bgfbcnfdt, #数据审核日
          bgfbstus LIKE bgfb_t.bgfbstus, #状态码
          bgfbud001 LIKE bgfb_t.bgfbud001, #自定义字段(文本)001
          bgfbud002 LIKE bgfb_t.bgfbud002, #自定义字段(文本)002
          bgfbud003 LIKE bgfb_t.bgfbud003, #自定义字段(文本)003
          bgfbud004 LIKE bgfb_t.bgfbud004, #自定义字段(文本)004
          bgfbud005 LIKE bgfb_t.bgfbud005, #自定义字段(文本)005
          bgfbud006 LIKE bgfb_t.bgfbud006, #自定义字段(文本)006
          bgfbud007 LIKE bgfb_t.bgfbud007, #自定义字段(文本)007
          bgfbud008 LIKE bgfb_t.bgfbud008, #自定义字段(文本)008
          bgfbud009 LIKE bgfb_t.bgfbud009, #自定义字段(文本)009
          bgfbud010 LIKE bgfb_t.bgfbud010, #自定义字段(文本)010
          bgfbud011 LIKE bgfb_t.bgfbud011, #自定义字段(数字)011
          bgfbud012 LIKE bgfb_t.bgfbud012, #自定义字段(数字)012
          bgfbud013 LIKE bgfb_t.bgfbud013, #自定义字段(数字)013
          bgfbud014 LIKE bgfb_t.bgfbud014, #自定义字段(数字)014
          bgfbud015 LIKE bgfb_t.bgfbud015, #自定义字段(数字)015
          bgfbud016 LIKE bgfb_t.bgfbud016, #自定义字段(数字)016
          bgfbud017 LIKE bgfb_t.bgfbud017, #自定义字段(数字)017
          bgfbud018 LIKE bgfb_t.bgfbud018, #自定义字段(数字)018
          bgfbud019 LIKE bgfb_t.bgfbud019, #自定义字段(数字)019
          bgfbud020 LIKE bgfb_t.bgfbud020, #自定义字段(数字)020
          bgfbud021 LIKE bgfb_t.bgfbud021, #自定义字段(日期时间)021
          bgfbud022 LIKE bgfb_t.bgfbud022, #自定义字段(日期时间)022
          bgfbud023 LIKE bgfb_t.bgfbud023, #自定义字段(日期时间)023
          bgfbud024 LIKE bgfb_t.bgfbud024, #自定义字段(日期时间)024
          bgfbud025 LIKE bgfb_t.bgfbud025, #自定义字段(日期时间)025
          bgfbud026 LIKE bgfb_t.bgfbud026, #自定义字段(日期时间)026
          bgfbud027 LIKE bgfb_t.bgfbud027, #自定义字段(日期时间)027
          bgfbud028 LIKE bgfb_t.bgfbud028, #自定义字段(日期时间)028
          bgfbud029 LIKE bgfb_t.bgfbud029, #自定义字段(日期时间)029
          bgfbud030 LIKE bgfb_t.bgfbud030  #自定义字段(日期时间)030
   END RECORD
   DEFINE l_i            LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgfb007_t    LIKE bgfb_t.bgfb007
   DEFINE l_bgfb009_t    LIKE bgfb_t.bgfb009
   DEFINE l_bgfb103      LIKE bgfb_t.bgfb103
   DEFINE l_bgfb104      LIKE bgfb_t.bgfb104
   DEFINE l_bgfb105      LIKE bgfb_t.bgfb105
   DEFINE l_bgal RECORD  #預算專案維護檔
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
          bgal015 LIKE bgal_t.bgal015, #自由核算項一
          bgal016 LIKE bgal_t.bgal016, #自由核算項二
          bgal017 LIKE bgal_t.bgal017, #自由核算項三
          bgal018 LIKE bgal_t.bgal018, #自由核算項四
          bgal019 LIKE bgal_t.bgal019, #自由核算項五
          bgal020 LIKE bgal_t.bgal020, #自由核算項六
          bgal021 LIKE bgal_t.bgal021, #自由核算項七
          bgal022 LIKE bgal_t.bgal022, #自由核算項八
          bgal023 LIKE bgal_t.bgal023, #自由核算項九
          bgal024 LIKE bgal_t.bgal024, #自由核算項十
          bgal025 LIKE bgal_t.bgal025, #經營方式
          bgal026 LIKE bgal_t.bgal026, #通路
          bgal027 LIKE bgal_t.bgal027  #品牌
   END RECORD
   DEFINE l_day          LIKE type_t.num5 #161220-00036#1 add
   DEFINE l_date         LIKE type_t.dat  #161220-00036#1 add
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgfb.bgfb007 = g_bgfb_m.bgfb007
      LET l_bgfb007_t = g_bgfb007_t
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgfb.bgfb009 = g_bgfb_m.bgfb009
      LET l_bgfb009_t = g_bgfb009_t
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgfb.bgfb013 = g_bgfb_m.bgfb013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgfb.bgfb014 = g_bgfb_m.bgfb014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgfb.bgfb015 = g_bgfb_m.bgfb015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgfb.bgfb016 = g_bgfb_m.bgfb016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgfb.bgfb017 = g_bgfb_m.bgfb017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgfb.bgfb018 = g_bgfb_m.bgfb018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgfb.bgfb019 = g_bgfb_m.bgfb019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgfb.bgfb022= g_bgfb_m.bgfb022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgfb.bgfb023= g_bgfb_m.bgfb023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgfb.bgfb024= g_bgfb_m.bgfb024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgfb.bgfb012= g_bgfb_m.bgfb012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgfb.bgfb020= g_bgfb_m.bgfb020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgfb.bgfb021= g_bgfb_m.bgfb021
   END IF
   
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgfb.bgfb007 = g_bgfb_d[l_ac].bgfb007
      LET l_bgfb007_t = g_bgfb_d_t.bgfb007
   END IF
   #预算细项
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgfb.bgfb009 = g_bgfb_d[l_ac].bgfb009
      LET l_bgfb009_t = g_bgfb_d_t.bgfb009
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgfb.bgfb013 = g_bgfb_d[l_ac].bgfb013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgfb.bgfb014 = g_bgfb_d[l_ac].bgfb014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgfb.bgfb015 = g_bgfb_d[l_ac].bgfb015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgfb.bgfb016 = g_bgfb_d[l_ac].bgfb016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgfb.bgfb017 = g_bgfb_d[l_ac].bgfb017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgfb.bgfb018 = g_bgfb_d[l_ac].bgfb018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgfb.bgfb019 = g_bgfb_d[l_ac].bgfb019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgfb.bgfb022= g_bgfb_d[l_ac].bgfb022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgfb.bgfb023= g_bgfb_d[l_ac].bgfb023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgfb.bgfb024= g_bgfb_d[l_ac].bgfb024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgfb.bgfb012= g_bgfb_d[l_ac].bgfb012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgfb.bgfb020= g_bgfb_d[l_ac].bgfb020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgfb.bgfb021= g_bgfb_d[l_ac].bgfb021
   END IF
   
   #当核算项不使用时，核算项默认给空格
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
          l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
          l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=g_bgfb_m.bgfb002
      AND bgal002=l_bgfb.bgfb007 AND bgal003=l_bgfb.bgfb009
      
   #部门
   IF (g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N') OR l_bgal.bgal005 = 'N' THEN
      LET l_bgfb.bgfb013 = ' '
   END IF
   #利润成本中心
   IF (g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N') OR l_bgal.bgal006 = 'N'  THEN
      LET l_bgfb.bgfb014 = ' '
   END IF
   #区域
   IF (g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N') OR l_bgal.bgal007 = 'N'  THEN
      LET l_bgfb.bgfb015 = ' '
   END IF
   #收付款客商
   IF (g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N') OR l_bgal.bgal008 = 'N'  THEN
      LET l_bgfb.bgfb016 = ' '
   END IF
   #账款客商
   IF (g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N') OR l_bgal.bgal009 = 'N'  THEN
      LET l_bgfb.bgfb017 = ' '
   END IF
   #客群
   IF (g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N') OR l_bgal.bgal010 = 'N'  THEN
      LET l_bgfb.bgfb018 = ' '
   END IF
   #产品类别
   IF (g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N') OR l_bgal.bgal011 = 'N' THEN
      LET l_bgfb.bgfb019 = ' '
   END IF
   #经营方式
   IF (g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N') OR l_bgal.bgal025 = 'N' THEN
      LET l_bgfb.bgfb022= ' '
   END IF
   #通路
   IF (g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N') OR l_bgal.bgal026 = 'N' THEN
      LET l_bgfb.bgfb023= ' '
   END IF
   #品牌
   IF (g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N') OR l_bgal.bgal027 = 'N' THEN
      LET l_bgfb.bgfb024= ' '
   END IF
   #人员
   IF (g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N') OR l_bgal.bgal012 = 'N' THEN
      LET l_bgfb.bgfb012= ' '
   END IF
   #专案
   IF (g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N') OR l_bgal.bgal013 = 'N' THEN
      LET l_bgfb.bgfb020= ' '
   END IF
   #WBS
   IF (g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N') OR l_bgal.bgal014 = 'N' THEN
      LET l_bgfb.bgfb021= ' '
   END IF
   
   #组合key bgfb010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET l_bgfb.bgfb010 = "bgfb013=",l_bgfb.bgfb013,"/",
                        "bgfb014=",l_bgfb.bgfb014,"/",
                        "bgfb015=",l_bgfb.bgfb015,"/",
                        "bgfb016=",l_bgfb.bgfb016,"/",
                        "bgfb017=",l_bgfb.bgfb017,"/",
                        "bgfb018=",l_bgfb.bgfb018,"/",
                        "bgfb019=",l_bgfb.bgfb019,"/",
                        "bgfb022=",l_bgfb.bgfb022,"/",
                        "bgfb023=",l_bgfb.bgfb023,"/",
                        "bgfb024=",l_bgfb.bgfb024,"/",
                        "bgfb012=",l_bgfb.bgfb012,"/",
                        "bgfb020=",l_bgfb.bgfb020,"/",
                        "bgfb021=",l_bgfb.bgfb021,""
   
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgfb.bgfb008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt1
         WHEN 2
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt2
         WHEN 3
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt3
         WHEN 4
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt4
         WHEN 5
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt5
         WHEN 6
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt6
         WHEN 7
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt7
         WHEN 8
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt8
         WHEN 9
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt9
         WHEN 10
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt10
         WHEN 11
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt11
         WHEN 12
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt12
         WHEN 13
            LET l_bgfb.bgfb037 = g_bgfb_d[l_ac].amt13
      END CASE
      
      LET l_bgfb.bgfb102 = l_bgfb.bgfb037
      #161220-00036#1--add--str--
      #汇率
      #170103-00013#1--mod--str--
#      CALL s_date_get_max_day(g_bgfb_m.bgaa002,l_bgfb.bgfb008) RETURNING l_day
#      LET l_date=MDY(l_bgfb.bgfb008,l_day,g_bgfb_m.bgaa002)
      CALL s_abg2_get_max_bgac002(g_bgfb_m.bgaa002,l_bgfb.bgfb008) RETURNING l_date
      #170103-00013#1--mod--end
      CALL s_abg_get_bg_rate(g_bgfb_m.bgfb002,l_date,g_bgfb_d[l_ac].bgfb100,g_bgfb_m.bgaa003)
      RETURNING l_bgfb.bgfb101
      #161220-00036#1--add--end
      #以稅別計算出來含税金额、未税金额、税额
#      CALL s_tax_count(l_bgfb.bgfb007,g_bgfb_d[l_ac].bgfb035,l_bgfb.bgfb102,1,g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb101) #161220-00036#1 mark
      CALL s_tax_count(l_bgfb.bgfb007,g_bgfb_d[l_ac].bgfb035,l_bgfb.bgfb102,1,g_bgfb_d[l_ac].bgfb100,l_bgfb.bgfb101) #161220-00036#1 add
      RETURNING l_bgfb.bgfb103,l_bgfb.bgfb104,l_bgfb.bgfb105,l_bgfb103,l_bgfb104,l_bgfb105
 
      UPDATE bgfb_t SET (bgfb007,bgfb009,bgfbseq,bgfb010, 
          bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,bgfb018,bgfb019,bgfb020, 
          bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036,bgfb037, 
          bgfb047,bgfb048,bgfb100,bgfb101,bgfb102,bgfb103,bgfb104,bgfb105,
          bgfbownid,bgfbowndp,bgfbcrtid,bgfbcrtdp,bgfbcrtdt, 
          bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt) = (l_bgfb.bgfb007,l_bgfb.bgfb009, 
          g_bgfb_d[l_ac].bgfbseq,g_bgfb_d[l_ac].bgfb010,l_bgfb.bgfb012, 
          l_bgfb.bgfb013,l_bgfb.bgfb014,l_bgfb.bgfb015,l_bgfb.bgfb016, 
          l_bgfb.bgfb017,l_bgfb.bgfb018,l_bgfb.bgfb019,l_bgfb.bgfb020, 
          l_bgfb.bgfb021,l_bgfb.bgfb022,l_bgfb.bgfb023,l_bgfb.bgfb024, 
          g_bgfb_d[l_ac].bgfb035,g_bgfb_d[l_ac].bgfb036,l_bgfb.bgfb037,
          g_bgfb_d[l_ac].bgfb047,g_bgfb_d[l_ac].bgfb048, 
#          g_bgfb_d[l_ac].bgfb100,g_bgfb_d[l_ac].bgfb101,l_bgfb.bgfb102, #161220-00036#1 mark
          g_bgfb_d[l_ac].bgfb100,l_bgcj.bgfb101,l_bgfb.bgfb102, #161220-00036#1 add
          l_bgfb.bgfb103,l_bgfb.bgfb104,l_bgfb.bgfb105,
          g_bgfb2_d[l_ac].bgfbownid,g_bgfb2_d[l_ac].bgfbowndp,g_bgfb2_d[l_ac].bgfbcrtid,g_bgfb2_d[l_ac].bgfbcrtdp, 
          g_bgfb2_d[l_ac].bgfbcrtdt,g_bgfb2_d[l_ac].bgfbmodid,g_bgfb2_d[l_ac].bgfbmoddt,g_bgfb2_d[l_ac].bgfbcnfid, 
          g_bgfb2_d[l_ac].bgfbcnfdt)
       WHERE bgfbent = g_enterprise 
        AND bgfb001 = g_bgfb_m.bgfb001 
        AND bgfb002 = g_bgfb_m.bgfb002 
        AND bgfb003 = g_bgfb_m.bgfb003 
        AND bgfb004 = g_bgfb_m.bgfb004 
        AND bgfb005 = g_bgfb_m.bgfb005 
        AND bgfb006 = g_bgfb_m.bgfb006 
        AND bgfb007 = l_bgfb007_t 
        AND bgfb009 = l_bgfb009_t 
        AND bgfb008 = l_bgfb.bgfb008 #期别  
        AND bgfb010 = g_bgfb_d_t.bgfb010  
        AND bgfbseq = g_bgfb_d_t.bgfbseq  
     CASE
        WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgfb_t" 
           LET g_errparam.code   = "std-00009" 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOR
           
        WHEN SQLCA.sqlcode #其他錯誤
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOR
     END CASE
   END FOR
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根据核算项组合key值bgfb010
# Memo...........:
# Usage..........: CALL abgt620_get_bgfb010()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_get_bgfb010()
   DEFINE l_bgfb RECORD  #銷售預算主檔
          bgfbent LIKE bgfb_t.bgfbent, #企业编号
          bgfb001 LIKE bgfb_t.bgfb001, #来源作业
          bgfb002 LIKE bgfb_t.bgfb002, #预算编号
          bgfb003 LIKE bgfb_t.bgfb003, #版本
          bgfb004 LIKE bgfb_t.bgfb004, #管理组织
          bgfb005 LIKE bgfb_t.bgfb005, #销售来源
          bgfb006 LIKE bgfb_t.bgfb006, #数据类型
          bgfb007 LIKE bgfb_t.bgfb007, #预算组织
          bgfb008 LIKE bgfb_t.bgfb008, #预算期别
          bgfb009 LIKE bgfb_t.bgfb009, #预算细项
          bgfb010 LIKE bgfb_t.bgfb010, #组合KEY
          bgfbseq LIKE bgfb_t.bgfbseq, #项次
          bgfb011 LIKE bgfb_t.bgfb011, #预算样表
          bgfb012 LIKE bgfb_t.bgfb012, #人员
          bgfb013 LIKE bgfb_t.bgfb013, #部门
          bgfb014 LIKE bgfb_t.bgfb014, #成本利润中心
          bgfb015 LIKE bgfb_t.bgfb015, #区域
          bgfb016 LIKE bgfb_t.bgfb016, #收付款客商
          bgfb017 LIKE bgfb_t.bgfb017, #账款客商
          bgfb018 LIKE bgfb_t.bgfb018, #客群
          bgfb019 LIKE bgfb_t.bgfb019, #产品类别
          bgfb020 LIKE bgfb_t.bgfb020, #项目编号
          bgfb021 LIKE bgfb_t.bgfb021, #WBS
          bgfb022 LIKE bgfb_t.bgfb022, #经营方式
          bgfb023 LIKE bgfb_t.bgfb023, #渠道
          bgfb024 LIKE bgfb_t.bgfb024, #品牌
          bgfb025 LIKE bgfb_t.bgfb025, #自由核算项一
          bgfb026 LIKE bgfb_t.bgfb026, #自由核算项二
          bgfb027 LIKE bgfb_t.bgfb027, #自由核算项三
          bgfb028 LIKE bgfb_t.bgfb028, #自由核算项四
          bgfb029 LIKE bgfb_t.bgfb029, #自由核算项五
          bgfb030 LIKE bgfb_t.bgfb030, #自由核算项六
          bgfb031 LIKE bgfb_t.bgfb031, #自由核算项七
          bgfb032 LIKE bgfb_t.bgfb032, #自由核算项八
          bgfb033 LIKE bgfb_t.bgfb033, #自由核算项九
          bgfb034 LIKE bgfb_t.bgfb034, #自由核算项十
          bgfb035 LIKE bgfb_t.bgfb035, #税种
          bgfb036 LIKE bgfb_t.bgfb036, #含税否
          bgfb037 LIKE bgfb_t.bgfb037, #原币费用金额
          bgfb038 LIKE bgfb_t.bgfb038, #本层调整金额
          bgfb039 LIKE bgfb_t.bgfb039, #上层调整金额
          bgfb047 LIKE bgfb_t.bgfb047, #上层组织
          bgfb048 LIKE bgfb_t.bgfb048, #凭证编号
          bgfb100 LIKE bgfb_t.bgfb100, #交易币种
          bgfb101 LIKE bgfb_t.bgfb101, #汇率
          bgfb102 LIKE bgfb_t.bgfb102, #核准原币销售金额
          bgfb103 LIKE bgfb_t.bgfb103, #核准原币税前金额
          bgfb104 LIKE bgfb_t.bgfb104, #核准原币税额
          bgfb105 LIKE bgfb_t.bgfb105, #核准原币含税金额
          bgfbownid LIKE bgfb_t.bgfbownid, #资料所有者
          bgfbowndp LIKE bgfb_t.bgfbowndp, #资料所有部门
          bgfbcrtid LIKE bgfb_t.bgfbcrtid, #资料录入者
          bgfbcrtdp LIKE bgfb_t.bgfbcrtdp, #资料录入部门
          bgfbcrtdt LIKE bgfb_t.bgfbcrtdt, #资料创建日
          bgfbmodid LIKE bgfb_t.bgfbmodid, #资料更改者
          bgfbmoddt LIKE bgfb_t.bgfbmoddt, #最近更改日
          bgfbcnfid LIKE bgfb_t.bgfbcnfid, #资料审核者
          bgfbcnfdt LIKE bgfb_t.bgfbcnfdt, #数据审核日
          bgfbstus LIKE bgfb_t.bgfbstus, #状态码
          bgfbud001 LIKE bgfb_t.bgfbud001, #自定义字段(文本)001
          bgfbud002 LIKE bgfb_t.bgfbud002, #自定义字段(文本)002
          bgfbud003 LIKE bgfb_t.bgfbud003, #自定义字段(文本)003
          bgfbud004 LIKE bgfb_t.bgfbud004, #自定义字段(文本)004
          bgfbud005 LIKE bgfb_t.bgfbud005, #自定义字段(文本)005
          bgfbud006 LIKE bgfb_t.bgfbud006, #自定义字段(文本)006
          bgfbud007 LIKE bgfb_t.bgfbud007, #自定义字段(文本)007
          bgfbud008 LIKE bgfb_t.bgfbud008, #自定义字段(文本)008
          bgfbud009 LIKE bgfb_t.bgfbud009, #自定义字段(文本)009
          bgfbud010 LIKE bgfb_t.bgfbud010, #自定义字段(文本)010
          bgfbud011 LIKE bgfb_t.bgfbud011, #自定义字段(数字)011
          bgfbud012 LIKE bgfb_t.bgfbud012, #自定义字段(数字)012
          bgfbud013 LIKE bgfb_t.bgfbud013, #自定义字段(数字)013
          bgfbud014 LIKE bgfb_t.bgfbud014, #自定义字段(数字)014
          bgfbud015 LIKE bgfb_t.bgfbud015, #自定义字段(数字)015
          bgfbud016 LIKE bgfb_t.bgfbud016, #自定义字段(数字)016
          bgfbud017 LIKE bgfb_t.bgfbud017, #自定义字段(数字)017
          bgfbud018 LIKE bgfb_t.bgfbud018, #自定义字段(数字)018
          bgfbud019 LIKE bgfb_t.bgfbud019, #自定义字段(数字)019
          bgfbud020 LIKE bgfb_t.bgfbud020, #自定义字段(数字)020
          bgfbud021 LIKE bgfb_t.bgfbud021, #自定义字段(日期时间)021
          bgfbud022 LIKE bgfb_t.bgfbud022, #自定义字段(日期时间)022
          bgfbud023 LIKE bgfb_t.bgfbud023, #自定义字段(日期时间)023
          bgfbud024 LIKE bgfb_t.bgfbud024, #自定义字段(日期时间)024
          bgfbud025 LIKE bgfb_t.bgfbud025, #自定义字段(日期时间)025
          bgfbud026 LIKE bgfb_t.bgfbud026, #自定义字段(日期时间)026
          bgfbud027 LIKE bgfb_t.bgfbud027, #自定义字段(日期时间)027
          bgfbud028 LIKE bgfb_t.bgfbud028, #自定义字段(日期时间)028
          bgfbud029 LIKE bgfb_t.bgfbud029, #自定义字段(日期时间)029
          bgfbud030 LIKE bgfb_t.bgfbud030  #自定义字段(日期时间)030
   END RECORD
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgfb.bgfb007 = g_bgfb_m.bgfb007
   END IF
   #预算细项
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgfb.bgfb009 = g_bgfb_m.bgfb009
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgfb.bgfb013 = g_bgfb_m.bgfb013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgfb.bgfb014 = g_bgfb_m.bgfb014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgfb.bgfb015 = g_bgfb_m.bgfb015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgfb.bgfb016 = g_bgfb_m.bgfb016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgfb.bgfb017 = g_bgfb_m.bgfb017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgfb.bgfb018 = g_bgfb_m.bgfb018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgfb.bgfb019 = g_bgfb_m.bgfb019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgfb.bgfb022= g_bgfb_m.bgfb022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgfb.bgfb023= g_bgfb_m.bgfb023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgfb.bgfb024= g_bgfb_m.bgfb024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgfb.bgfb012= g_bgfb_m.bgfb012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgfb.bgfb020= g_bgfb_m.bgfb020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgfb.bgfb021= g_bgfb_m.bgfb021
   END IF
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgfb.bgfb007 = g_bgfb_d[l_ac].bgfb007
   END IF
   #预算细项
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgfb.bgfb009 = g_bgfb_d[l_ac].bgfb009
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgfb.bgfb013 = g_bgfb_d[l_ac].bgfb013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgfb.bgfb014 = g_bgfb_d[l_ac].bgfb014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgfb.bgfb015 = g_bgfb_d[l_ac].bgfb015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgfb.bgfb016 = g_bgfb_d[l_ac].bgfb016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgfb.bgfb017 = g_bgfb_d[l_ac].bgfb017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgfb.bgfb018 = g_bgfb_d[l_ac].bgfb018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgfb.bgfb019 = g_bgfb_d[l_ac].bgfb019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgfb.bgfb022= g_bgfb_d[l_ac].bgfb022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgfb.bgfb023= g_bgfb_d[l_ac].bgfb023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgfb.bgfb024= g_bgfb_d[l_ac].bgfb024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgfb.bgfb012= g_bgfb_d[l_ac].bgfb012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgfb.bgfb020= g_bgfb_d[l_ac].bgfb020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgfb.bgfb021= g_bgfb_d[l_ac].bgfb021
   END IF
   
   #组合key bgfb010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET g_bgfb_d[l_ac].bgfb010 = "bgfb013=",l_bgfb.bgfb013,"/",
                                "bgfb014=",l_bgfb.bgfb014,"/",
                                "bgfb015=",l_bgfb.bgfb015,"/",
                                "bgfb016=",l_bgfb.bgfb016,"/",
                                "bgfb017=",l_bgfb.bgfb017,"/",
                                "bgfb018=",l_bgfb.bgfb018,"/",
                                "bgfb019=",l_bgfb.bgfb019,"/",
                                "bgfb022=",l_bgfb.bgfb022,"/",
                                "bgfb023=",l_bgfb.bgfb023,"/",
                                "bgfb024=",l_bgfb.bgfb024,"/",
                                "bgfb012=",l_bgfb.bgfb012,"/",
                                "bgfb020=",l_bgfb.bgfb020,"/",
                                "bgfb021=",l_bgfb.bgfb021,""
END FUNCTION

################################################################################
# Descriptions...: 状态码变更
# Memo...........:
# Usage..........: CALL abgt620_statechange()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"

   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_bgfbmodid  LIKE bgfb_t.bgfbmodid
   DEFINE l_bgfbmoddt  LIKE bgfb_t.bgfbmoddt
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgfb_m.bgfb001 IS NULL
   OR g_bgfb_m.bgfb002 IS NULL
   OR g_bgfb_m.bgfb003 IS NULL
   OR g_bgfb_m.bgfb004 IS NULL
   OR g_bgfb_m.bgfb005 IS NULL
   OR g_bgfb_m.bgfb006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 IS NULL)
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   CASE
      #预算组织在单头 AND #预算细项在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009
      #预算组织在单头 AND #预算细项在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007
      #预算组织在单身 AND #预算细项在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb009
      #预算组织在单身 AND #预算细项在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt620_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt620_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009 INTO g_bgfb_m.bgfb002,g_bgfb_m.bgfb003, 
       g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfbstus, 
       g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019,g_bgfb_m.bgfb022,g_bgfb_m.bgfb009, 
       g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023,g_bgfb_m.bgfb015, 
       g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb012,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb004_desc 
   
 
   CALL abgt620_show()
 
   CASE g_bgfb_m.bgfbstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "FC"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   IF g_bgfb_m.bgfbstus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00044'
      LET g_errparam.extend = g_bgfb_m.bgfb002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt620_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   IF g_bgfb_m.bgfbstus = 'FC' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00020'
      LET g_errparam.extend = g_bgfb_m.bgfb002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt620_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgfb_m.bgfbstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "FC"
               HIDE OPTION "final_confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"

      CALL cl_set_act_visible("signing,withdraw,final_confirmed",FALSE) 
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE) 
      CASE g_bgfb_m.bgfbstus
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #abgt620中状态为最终审核时不可以异动状态要去abgt350中异动
         WHEN "FC"
            CALL cl_set_act_visible("invalid,confirmed,final_confirmed,unconfirmed",FALSE)
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
      END CASE
     
      LET l_success=TRUE 
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT abgt620_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt620_hcl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abgt620_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt620_hcl
            RETURN
         END IF
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL cl_err_collect_init()
            #取消审核检查
            CALL s_abgt620_unconfirm_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,
                                         g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009) 
            RETURNING l_success
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #维度检核
            CALL abgt340_02(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                                  g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb011)
            RETURNING l_success
            #审核
            CALL cl_err_collect_init()
            IF l_success = TRUE THEN
               CALL s_abgt620_confirm_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,
                                          g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009) 
               RETURNING l_success
            END IF
            #end add-point
         END IF
         EXIT MENU
         
      ON ACTION final_confirmed
         IF cl_auth_chk_act("final_confirmed") THEN
            LET lc_state = "FC"
            #add-point:action控制 name="statechange.final_confirmed"

            #end add-point
         END IF
         EXIT MENU
         
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"

            #end add-point
         END IF
         EXIT MENU
      
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"

            #end add-point
         END IF
         EXIT MENU
      
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            CALL cl_err_collect_init()
            #詢問
            IF NOT cl_ask_confirm('aim-00109') THEN   #是否執作廢?
               CALL s_transaction_end('N','0') 
               CLOSE abgt620_hcl         
               RETURN
            END IF
            #无效检查
            CALL s_abgt620_void_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,
                                    g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009) 
            RETURNING l_success
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "FC"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_bgfb_m.bgfbstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt620_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #判断执行结果，当失败时，回滚数据库
   CALL cl_err_collect_show()
   IF l_success = FALSE  THEN
      CALL s_transaction_end('N','0')
      CLOSE abgt620_hcl
      RETURN
   END IF
   #end add-point
   
   LET l_bgfbmodid = g_user
   LET l_bgfbmoddt = cl_get_current()
   LET g_bgfb_m.bgfbstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   LET l_sql="UPDATE bgfb_t ",
             "   SET bgfbstus = '",g_bgfb_m.bgfbstus,"',",
             "       bgfbmodid = '",l_bgfbmodid,"',",
             "       bgfbmoddt = to_date('",l_bgfbmoddt,"','YYYY-MM-DD hh24:mi:ss'), "
   IF lc_state = 'Y' THEN
      LET l_sql=l_sql," bgfbcnfid = '",g_user,"',",
                      " bgfbcnfdt = to_date('",l_bgfbmoddt,"','YYYY-MM-DD hh24:mi:ss') "
   ELSE
      LET l_sql=l_sql," bgfbcnfid = NULL,",
                      " bgfbcnfdt = NULL "
   END IF
   LET l_sql=l_sql," WHERE bgfbent =  ",g_enterprise,
                   "   AND bgfb001 = '",g_bgfb_m.bgfb001,"'",
                   "   AND bgfb002 = '",g_bgfb_m.bgfb002,"'", 
                   "   AND bgfb003 = '",g_bgfb_m.bgfb003,"'", 
                   "   AND bgfb004 = '",g_bgfb_m.bgfb004,"'", 
                   "   AND bgfb005 = '",g_bgfb_m.bgfb005,"'", 
                   "   AND bgfb006 = '",g_bgfb_m.bgfb006,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb007 = '",g_bgfb_m.bgfb007,"'"
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgfb009 = '",g_bgfb_m.bgfb009,"'"
   END IF         
   PREPARE abgt620_state_upd_pr FROM l_sql
   EXECUTE abgt620_state_upd_pr
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bgfb_m.bgfb002,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb004_desc, 
       g_bgfb_m.bgaa002,g_bgfb_m.bgaa003,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006, 
       g_bgfb_m.bgfbstus,g_bgfb_m.bgfb007,g_bgfb_m.bgfb007_desc_t,g_bgfb_m.bgfb009, 
       g_bgfb_m.bgfb012,g_bgfb_m.bgfb012_desc_t,g_bgfb_m.bgfb013,g_bgfb_m.bgfb013_desc_t,g_bgfb_m.bgfb014, 
       g_bgfb_m.bgfb014_desc_t,g_bgfb_m.bgfb015,g_bgfb_m.bgfb015_desc_t,g_bgfb_m.bgfb016,g_bgfb_m.bgfb016_desc_t, 
       g_bgfb_m.bgfb017,g_bgfb_m.bgfb017_desc_t,g_bgfb_m.bgfb018,g_bgfb_m.bgfb018_desc_t,g_bgfb_m.bgfb019, 
       g_bgfb_m.bgfb019_desc_t,g_bgfb_m.bgfb020,g_bgfb_m.bgfb020_desc_t,g_bgfb_m.bgfb021,g_bgfb_m.bgfb021_desc_t, 
       g_bgfb_m.bgfb022,g_bgfb_m.bgfb023,g_bgfb_m.bgfb023_desc_t,g_bgfb_m.bgfb024,g_bgfb_m.bgfb024_desc_t 

   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgt620_hcl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('statechange:'||lc_state)
  
END FUNCTION

################################################################################
# Descriptions...: 重写修改
# Memo...........:
# Usage..........: CALL abgt620_modify_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_modify_1()
   #add-point:modify段define name="modify.define_customerization"

   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"

   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"

   #end add-point
   
   IF g_bgfb_m.bgfb001 IS NULL
   OR g_bgfb_m.bgfb002 IS NULL
   OR g_bgfb_m.bgfb003 IS NULL
   OR g_bgfb_m.bgfb004 IS NULL
   OR g_bgfb_m.bgfb005 IS NULL
   OR g_bgfb_m.bgfb006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 IS NULL)
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgfb001_t = g_bgfb_m.bgfb001
   LET g_bgfb002_t = g_bgfb_m.bgfb002
   LET g_bgfb003_t = g_bgfb_m.bgfb003
   LET g_bgfb004_t = g_bgfb_m.bgfb004
   LET g_bgfb005_t = g_bgfb_m.bgfb005
   LET g_bgfb006_t = g_bgfb_m.bgfb006
   LET g_bgfb007_t = g_bgfb_m.bgfb007
   LET g_bgfb009_t = g_bgfb_m.bgfb009
 
   CALL s_transaction_begin()
   
   CASE
      #预算组织在单头 AND #预算细项在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009
      #预算组织在单头 AND #预算细项在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007
      #预算组织在单身 AND #预算细项在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb009
      #预算组织在单身 AND #预算细项在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt620_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt620_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009 INTO g_bgfb_m.bgfb002,g_bgfb_m.bgfb003, 
       g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfbstus, 
       g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019,g_bgfb_m.bgfb022,g_bgfb_m.bgfb009, 
       g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023,g_bgfb_m.bgfb015, 
       g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb012,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb004_desc 

   
   #遮罩相關處理
   LET g_bgfb_m_mask_o.* =  g_bgfb_m.*
   CALL abgt620_bgfb_t_mask()
   LET g_bgfb_m_mask_n.* =  g_bgfb_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt620_show()
   WHILE TRUE
      LET g_bgfb001_t = g_bgfb_m.bgfb001
      LET g_bgfb002_t = g_bgfb_m.bgfb002
      LET g_bgfb003_t = g_bgfb_m.bgfb003
      LET g_bgfb004_t = g_bgfb_m.bgfb004
      LET g_bgfb005_t = g_bgfb_m.bgfb005
      LET g_bgfb006_t = g_bgfb_m.bgfb006
      LET g_bgfb007_t = g_bgfb_m.bgfb007
      LET g_bgfb009_t = g_bgfb_m.bgfb009
 
 
      #add-point:modify段修改前 name="modify.before_input"
      LET g_bgfb_m_t.* = g_bgfb_m.*
      #end add-point
      
      CALL abgt620_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"

      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgfb_m.* = g_bgfb_m_t.*
         CALL abgt620_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgfb_m.bgfb001 != g_bgfb001_t 
      OR g_bgfb_m.bgfb002 != g_bgfb002_t 
      OR g_bgfb_m.bgfb003 != g_bgfb003_t 
      OR g_bgfb_m.bgfb004 != g_bgfb004_t 
      OR g_bgfb_m.bgfb005 != g_bgfb005_t 
      OR g_bgfb_m.bgfb006 != g_bgfb006_t 
      OR g_bgfb_m.bgfb007 != g_bgfb007_t 
      OR g_bgfb_m.bgfb009 != g_bgfb009_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"

         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"

         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"

         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt620_set_act_visible()
   CALL abgt620_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgfbent = " ||g_enterprise|| " AND",
                      " bgfb001 = '", g_bgfb_m.bgfb001, "' "
                      ," AND bgfb002 = '", g_bgfb_m.bgfb002, "' "
                      ," AND bgfb003 = '", g_bgfb_m.bgfb003, "' "
                      ," AND bgfb004 = '", g_bgfb_m.bgfb004, "' "
                      ," AND bgfb005 = '", g_bgfb_m.bgfb005, "' "
                      ," AND bgfb006 = '", g_bgfb_m.bgfb006, "' "
                      ," AND bgfb007 = '", g_bgfb_m.bgfb007, "' "
                      ," AND bgfb009 = '", g_bgfb_m.bgfb009, "' "
 
   #填到對應位置
   CALL abgt620_browser_fill("")
 
   CALL abgt620_idx_chk()
 
   CLOSE abgt620_hcl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('modify')
END FUNCTION

################################################################################
# Descriptions...: 重写删除
# Memo...........:
# Usage..........: CALL abgt620_delete_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_delete_1()
#add-point:delete段define name="delete.define_customerization"

   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_sql           STRING
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"

   #end add-point
   
   IF g_bgfb_m.bgfb001 IS NULL
   OR g_bgfb_m.bgfb002 IS NULL
   OR g_bgfb_m.bgfb003 IS NULL
   OR g_bgfb_m.bgfb004 IS NULL
   OR g_bgfb_m.bgfb005 IS NULL
   OR g_bgfb_m.bgfb006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgfb_m.bgfb007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgfb_m.bgfb009 IS NULL)
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   CASE
      #预算组织在单头 AND #预算细项在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009
      #预算组织在单头 AND #预算细项在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007
      #预算组织在单身 AND #预算细项在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb009
      #预算组织在单身 AND #预算细项在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt620_hcl USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,
             g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt620_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt620_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt620_master_referesh USING g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004, 
       g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009 INTO g_bgfb_m.bgfb002,g_bgfb_m.bgfb003, 
       g_bgfb_m.bgfb004,g_bgfb_m.bgfb011,g_bgfb_m.bgfb001,g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfbstus, 
       g_bgfb_m.bgfb007,g_bgfb_m.bgfb013,g_bgfb_m.bgfb016,g_bgfb_m.bgfb019,g_bgfb_m.bgfb022,g_bgfb_m.bgfb009, 
       g_bgfb_m.bgfb014,g_bgfb_m.bgfb017,g_bgfb_m.bgfb020,g_bgfb_m.bgfb023,g_bgfb_m.bgfb015, 
       g_bgfb_m.bgfb018,g_bgfb_m.bgfb021,g_bgfb_m.bgfb024,g_bgfb_m.bgfb012,g_bgfb_m.bgfb002_desc,g_bgfb_m.bgfb004_desc 

   
   #遮罩相關處理
   LET g_bgfb_m_mask_o.* =  g_bgfb_m.*
   CALL abgt620_bgfb_t_mask()
   LET g_bgfb_m_mask_n.* =  g_bgfb_m.*
   
   CALL abgt620_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt620_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"

      #end add-point
      LET l_sql = "DELETE FROM bgfb_t ",
                  " WHERE bgfbent = ",g_enterprise,
                  "   AND bgfb001 ='",g_bgfb_m.bgfb001,"'",
                  "   AND bgfb002 ='",g_bgfb_m.bgfb002,"'",
                  "   AND bgfb003 ='",g_bgfb_m.bgfb003,"'",
                  "   AND bgfb004 ='",g_bgfb_m.bgfb004,"'",
                  "   AND bgfb005 ='",g_bgfb_m.bgfb005,"'",
                  "   AND bgfb006 ='",g_bgfb_m.bgfb006,"'"
      #预算组织在单头
      IF g_bgaw1[1] = 'Y' THEN
         LET l_sql = l_sql,"   AND bgfb007 ='",g_bgfb_m.bgfb007,"'"
      END IF
      #预算细项在单头
      IF g_bgaw1[2] = 'Y' THEN
         LET l_sql = l_sql,"   AND bgfb009 ='",g_bgfb_m.bgfb009,"'"
      END IF
      PREPARE abgt620_delete_pr FROM l_sql
      EXECUTE abgt620_delete_pr
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgfb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"

      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"

      #end add-point
      
      CLEAR FORM
      CALL g_bgfb_d.clear() 
      CALL g_bgfb2_d.clear()       
      CALL g_bgfb3_d.clear()       
 
     
      CALL abgt620_ui_browser_refresh()  
      #CALL abgt620_ui_headershow()  
      #CALL abgt620_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt620_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt620_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt620_hcl
 
   #功能已完成,通報訊息中心
   CALL abgt620_msgcentre_notify('delete')
    
END FUNCTION

################################################################################
# Descriptions...: 调用abgt620_01预算调整子作业调整金额
# Memo...........:
# Usage..........: CALL abgt620_adjust(p_type)
# Input parameter: p_type      1.本层调整 2.上层调整
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_adjust(p_type)
   DEFINE p_type         LIKE type_t.num5
   DEFINE l_bgfb007      LIKE bgfb_t.bgfb007
   DEFINE l_bgfb009      LIKE bgfb_t.bgfb009
   DEFINE l_sql,l_sql1   STRING
   DEFINE l_cnt          LIKE type_t.num5
   
   IF cl_null(g_bgfb_m.bgfb001) OR cl_null(g_bgfb_m.bgfb002) OR cl_null(g_bgfb_m.bgfb003) OR
      cl_null(g_bgfb_m.bgfb004) OR cl_null(g_bgfb_m.bgfb005) OR cl_null(g_bgfb_m.bgfb006) THEN
      RETURN
   END IF
   
   IF g_bgfb_m.bgfbstus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00218"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF g_bgfb_m.bgfbstus = 'FC' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00020"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF l_ac < 1 OR cl_null(g_bgfb_d[l_ac].bgfbseq) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-400"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #检核预算组织或预算组织的上层组织是否已存在与abgt350中，如果存在，不可调整
   LET l_sql1 ="  FROM bgfb_t ",
               " WHERE bgfbent=",g_enterprise,
               "   AND bgfb001 = '",g_bgfb_m.bgfb001,"'",
               "   AND bgfb002 = '",g_bgfb_m.bgfb002,"'", 
               "   AND bgfb003 = '",g_bgfb_m.bgfb003,"'", 
               "   AND bgfb004 = '",g_bgfb_m.bgfb004,"'", 
               "   AND bgfb005 = '",g_bgfb_m.bgfb005,"'", 
               "   AND bgfb006 = '",g_bgfb_m.bgfb006,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql1 = l_sql1," AND bgfb007 = '",g_bgfb_m.bgfb007,"'"
   END IF
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql1 = l_sql1," AND bgfb009 = '",g_bgfb_m.bgfb009,"'"
   END IF    
   LET l_cnt = 0
   #预算组织
   LET l_sql="SELECT COUNT(1) FROM bgfb_t",
             " WHERE bgfbent=",g_enterprise, 
             "   AND bgfb001='30'",
             "   AND bgfb002='",g_bgfb_m.bgfb002,"'",
             "   AND bgfb003='",g_bgfb_m.bgfb003,"'",
             "   AND bgfb004='",g_bgfb_m.bgfb004,"'",
             "   AND bgfb005='",g_bgfb_m.bgfb005,"'",
             "   AND bgfb006='2'",
             "   AND bgfbstus <> 'X'",
             "   AND bgfb007 IN (SELECT DISTINCT bgfb007 ",l_sql1,")"
   PREPARE abgt620_bgfb007_pr FROM l_sql
   EXECUTE abgt620_bgfb007_pr INTO l_cnt
   IF cl_null(l_cnt) THEN  LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'abg-00229'
      #161215-00014#3--mod--str--
#      LET g_errparam.replace[1] = 'abgt630'
#      LET g_errparam.replace[2] = cl_get_progname('abgt630',g_lang,"2")
      LET g_errparam.replace[1] = cl_get_progname('abgt630',g_lang,"2")
      #161215-00014#3--mod--end
      LET g_errparam.exeprog = 'abgt630'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   LET l_cnt = 0
   #预算组织的上层组织
   LET l_sql="SELECT COUNT(1) FROM bgfb_t",
             " WHERE bgfbent=",g_enterprise, 
             "   AND bgfb001='30'",
             "   AND bgfb002='",g_bgfb_m.bgfb002,"'",
             "   AND bgfb003='",g_bgfb_m.bgfb003,"'",
             "   AND bgfb004='",g_bgfb_m.bgfb004,"'",
             "   AND bgfb005='",g_bgfb_m.bgfb005,"'",
             "   AND bgfb006='2'",
             "   AND bgfbstus <> 'X'",
             "   AND bgfb007 IN (SELECT DISTINCT bgfb047 ",l_sql1,")"
   PREPARE abgt620_bgfb007_pr2 FROM l_sql
   EXECUTE abgt620_bgfb007_pr2 INTO l_cnt
   IF cl_null(l_cnt) THEN  LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'abg-00230'
      #161215-00014#3--mod--str--
#      LET g_errparam.replace[1] = 'abgt630'
#      LET g_errparam.replace[2] = cl_get_progname('abgt630',g_lang,"2")
      LET g_errparam.replace[1] = cl_get_progname('abgt630',g_lang,"2")
      #161215-00014#3--mod--end
      LET g_errparam.exeprog = 'abgt630'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #重写单身锁资料sql
   #161220-00036#1--mod--str--
#   LET g_forupd_sql = "SELECT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015, 
#       bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036, 
#       bgfb100,bgfb101,0,bgfb047,bgfb048,bgfbseq,bgfbownid,bgfbowndp, 
#       bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt,bgfbseq FROM bgfb_t WHERE  
#       bgfbent=? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND bgfb005=? AND bgfb006=?  
#       AND bgfb007=? AND bgfb009=? AND bgfb010=? AND bgfbseq=? FOR UPDATE"
   LET g_forupd_sql = "SELECT bgfbseq,bgfb010,bgfb007,bgfb009,bgfb012,bgfb013,bgfb014,bgfb015, ",
       "bgfb016,bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb035,bgfb036, ",
       "bgfb100,0,bgfb047,bgfb048,bgfbseq,bgfbownid,bgfbowndp, ",
       "bgfbcrtid,bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt,bgfbseq ",
       "  FROM bgfb_t ",
       " WHERE bgfbent=? AND bgfb001=? AND bgfb002=? AND bgfb003=? AND bgfb004=? AND bgfb005=? AND bgfb006=?",  
       "   AND bgfb007=? AND bgfb009=? AND bgfb010=? AND bgfbseq=? FOR UPDATE"
   #161220-00036#1--mod--end
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt620_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   
   #锁住这笔项次资料
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgfb007 = g_bgfb_m.bgfb007
   ELSE
      LET l_bgfb007 = g_bgfb_d[l_ac].bgfb007
   END IF
   
   #预算细项在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgfb009 = g_bgfb_m.bgfb009
   ELSE
      LET l_bgfb009 = g_bgfb_d[l_ac].bgfb009
   END IF
   CALL s_transaction_begin()
   OPEN abgt620_bcl2 USING g_enterprise,g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,
                          g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,l_bgfb007,l_bgfb009,g_bgfb_d[l_ac].bgfb010,
                          g_bgfb_d[l_ac].bgfbseq
                 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt620_bcl2:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      CLOSE abgt620_bcl2
      RETURN
   END IF
   CALL abgt340_01(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                   g_bgfb_m.bgfb006,l_bgfb007,l_bgfb009,g_bgfb_d[l_ac].bgfb010,g_bgfb_d[l_ac].bgfbseq,p_type)
   CLOSE abgt620_bcl2
   CALL s_transaction_end('Y','0')
   CALL abgt620_b_fill2(l_ac)
END FUNCTION

################################################################################
# Descriptions...: BPM提交
# Memo...........:
# Usage..........: CALL abgt620_send()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........: 
################################################################################
PRIVATE FUNCTION abgt620_send()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success1   LIKE type_t.num5
   
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
  
   CALL abgt620_set_pk_array()
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bgfb_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bgfb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段 
   CALL cl_err_collect_init()
   #维度检核
   CALL abgt340_02(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,g_bgfb_m.bgfb005,
                   g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009,g_bgfb_m.bgfb011)
   RETURNING l_success
   #审核检查
   IF l_success = TRUE THEN
      CALL s_abgt620_confirm_chk(g_bgfb_m.bgfb001,g_bgfb_m.bgfb002,g_bgfb_m.bgfb003,g_bgfb_m.bgfb004,
                                 g_bgfb_m.bgfb005,g_bgfb_m.bgfb006,g_bgfb_m.bgfb007,g_bgfb_m.bgfb009) 
      RETURNING l_success
   END IF
   
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN
      RETURN FALSE
   END IF
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"

   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL abgt620_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt620_ui_headershow()
   CALL abgt620_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: BPM抽单
# Memo...........:
# Usage..........: CALL abgt620_draw_out()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt620_draw_out()
   
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt620_ui_headershow()  
   CALL abgt620_ui_detailshow()
 
 
   RETURN TRUE
   
END FUNCTION

 
{</section>}
 
