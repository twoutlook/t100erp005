#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-11-09 10:25:16), PR版次:0005(2017-01-03 15:52:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt340
#+ Description: 期別銷售預算維護
#+ Creator....: 02599(2016-11-04 09:36:10)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="abgt340.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161108-00017#9  2016/11/11 By 08171    程式中DEFINE時不可以用*的寫法，要一個一個欄位定義
#161215-00014#1  2016/12/15 By 02599    报错信息修改
#161220-00036#1  2016/12/20 By 02599    抓取第二单身的金额时，初始化变量,去除人员与预算组织直接的关联检核
#                                       画面单身中去除汇率，汇率按照年度+期别抓取
#170103-00013#1  2017/01/03 By 02599    取每期汇率时，日期抓取预算周期表中当期最大日期
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
PRIVATE type type_g_bgcj_m        RECORD
       bgcj002 LIKE bgcj_t.bgcj002, 
   bgcj002_desc LIKE type_t.chr80, 
   bgcj003 LIKE bgcj_t.bgcj003, 
   bgcj004 LIKE bgcj_t.bgcj004, 
   bgcj004_desc LIKE type_t.chr80, 
   bgaa002 LIKE type_t.chr10, 
   bgaa003 LIKE type_t.chr10, 
   bgcj011 LIKE bgcj_t.bgcj011, 
   bgcj001 LIKE bgcj_t.bgcj001, 
   bgcj005 LIKE bgcj_t.bgcj005, 
   bgcj006 LIKE bgcj_t.bgcj006, 
   bgcj010 LIKE bgcj_t.bgcj010, 
   bgcjstus LIKE bgcj_t.bgcjstus, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_desc_t LIKE type_t.chr80, 
   bgcj013 LIKE bgcj_t.bgcj013, 
   bgcj013_desc_t LIKE type_t.chr80, 
   bgcj016 LIKE bgcj_t.bgcj016, 
   bgcj016_desc_t LIKE type_t.chr80, 
   bgcj019 LIKE bgcj_t.bgcj019, 
   bgcj019_desc_t LIKE type_t.chr80, 
   bgcj022 LIKE bgcj_t.bgcj022, 
   bgcj009 LIKE bgcj_t.bgcj009, 
   bgcj014 LIKE bgcj_t.bgcj014, 
   bgcj014_desc_t LIKE type_t.chr80, 
   bgcj017 LIKE bgcj_t.bgcj017, 
   bgcj017_desc_t LIKE type_t.chr80, 
   bgcj020 LIKE bgcj_t.bgcj020, 
   bgcj020_desc_t LIKE type_t.chr80, 
   bgcj023 LIKE bgcj_t.bgcj023, 
   bgcj023_desc_t LIKE type_t.chr80, 
   bgcj012 LIKE bgcj_t.bgcj012, 
   bgcj012_desc_t LIKE type_t.chr80, 
   bgcj015 LIKE bgcj_t.bgcj015, 
   bgcj015_desc_t LIKE type_t.chr80, 
   bgcj018 LIKE bgcj_t.bgcj018, 
   bgcj018_desc_t LIKE type_t.chr80, 
   bgcj021 LIKE bgcj_t.bgcj021, 
   bgcj021_desc_t LIKE type_t.chr80, 
   bgcj024 LIKE bgcj_t.bgcj024, 
   bgcj024_desc_t LIKE type_t.chr80, 
   bgcj049 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgcj_d        RECORD
       bgcjseq LIKE bgcj_t.bgcjseq, 
   bgcj010 LIKE bgcj_t.bgcj010, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_desc LIKE type_t.chr500, 
   bgcj009 LIKE bgcj_t.bgcj009, 
   bgcj009_desc LIKE type_t.chr500, 
   bgcj049 LIKE bgcj_t.bgcj049, 
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
   bgcj035 LIKE bgcj_t.bgcj035, 
   bgcj036 LIKE bgcj_t.bgcj036, 
   bgcj037 LIKE bgcj_t.bgcj037, 
   bgcj100 LIKE bgcj_t.bgcj100, 
   num1 LIKE type_t.num20_6, 
   price1 LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   num2 LIKE type_t.num20_6, 
   price2 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   num3 LIKE type_t.num20_6, 
   price3 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   num4 LIKE type_t.num20_6, 
   price4 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   num5 LIKE type_t.num20_6, 
   price5 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   num6 LIKE type_t.num20_6, 
   price6 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   num7 LIKE type_t.num20_6, 
   price7 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   num8 LIKE type_t.num20_6, 
   price8 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   num9 LIKE type_t.num20_6, 
   price9 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   num10 LIKE type_t.num20_6, 
   price10 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   num11 LIKE type_t.num20_6, 
   price11 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   num12 LIKE type_t.num20_6, 
   price12 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   num13 LIKE type_t.num20_6, 
   price13 LIKE type_t.num20_6, 
   amt13 LIKE type_t.num20_6, 
   bgcj008 LIKE bgcj_t.bgcj008, 
   bgcj047 LIKE bgcj_t.bgcj047, 
   bgcj048 LIKE bgcj_t.bgcj048, 
   bgcj050 LIKE bgcj_t.bgcj050
       END RECORD
PRIVATE TYPE type_g_bgcj2_d RECORD
       bgcjseq LIKE bgcj_t.bgcjseq, 
   bgcjownid LIKE bgcj_t.bgcjownid, 
   bgcjownid_desc LIKE type_t.chr500, 
   bgcjowndp LIKE bgcj_t.bgcjowndp, 
   bgcjowndp_desc LIKE type_t.chr500, 
   bgcjcrtid LIKE bgcj_t.bgcjcrtid, 
   bgcjcrtid_desc LIKE type_t.chr500, 
   bgcjcrtdp LIKE bgcj_t.bgcjcrtdp, 
   bgcjcrtdp_desc LIKE type_t.chr500, 
   bgcjcrtdt DATETIME YEAR TO SECOND, 
   bgcjmodid LIKE bgcj_t.bgcjmodid, 
   bgcjmodid_desc LIKE type_t.chr500, 
   bgcjmoddt DATETIME YEAR TO SECOND, 
   bgcjcnfid LIKE bgcj_t.bgcjcnfid, 
   bgcjcnfid_desc LIKE type_t.chr500, 
   bgcjcnfdt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_bgcj3_d RECORD
       bgcjseq LIKE bgcj_t.bgcjseq, 
   content LIKE type_t.chr500, 
   tnum1 LIKE type_t.num20_6, 
   tprice1 LIKE type_t.num20_6, 
   tamt1 LIKE type_t.num20_6, 
   tnum2 LIKE type_t.num20_6, 
   tprice2 LIKE type_t.num20_6, 
   tamt2 LIKE type_t.num20_6, 
   tnum3 LIKE type_t.num20_6, 
   tprice3 LIKE type_t.num20_6, 
   tamt3 LIKE type_t.num20_6, 
   tnum4 LIKE type_t.num20_6, 
   tprice4 LIKE type_t.num20_6, 
   tamt4 LIKE type_t.num20_6, 
   tnum5 LIKE type_t.num20_6, 
   tprice5 LIKE type_t.num20_6, 
   tamt5 LIKE type_t.num20_6, 
   tnum6 LIKE type_t.num20_6, 
   tprice6 LIKE type_t.num20_6, 
   tamt6 LIKE type_t.num20_6, 
   tnum7 LIKE type_t.num20_6, 
   tprice7 LIKE type_t.num20_6, 
   tamt7 LIKE type_t.num20_6, 
   tnum8 LIKE type_t.num20_6, 
   tprice8 LIKE type_t.num20_6, 
   tamt8 LIKE type_t.num20_6, 
   tnum9 LIKE type_t.num20_6, 
   tprice9 LIKE type_t.num20_6, 
   tamt9 LIKE type_t.num20_6, 
   tnum10 LIKE type_t.num20_6, 
   tprice10 LIKE type_t.num20_6, 
   tamt10 LIKE type_t.num20_6, 
   tnum11 LIKE type_t.num20_6, 
   tprice11 LIKE type_t.num20_6, 
   tamt11 LIKE type_t.num20_6, 
   tnum12 LIKE type_t.num20_6, 
   tprice12 LIKE type_t.num20_6, 
   tamt12 LIKE type_t.num20_6, 
   tnum13 LIKE type_t.num20_6, 
   tprice13 LIKE type_t.num20_6, 
   tamt13 LIKE type_t.num20_6, 
   sum LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_max_period      LIKE type_t.num5
DEFINE g_bgaw1           DYNAMIC ARRAY OF VARCHAR(1) #位置在单头+显示为 Y，否则为 N
DEFINE g_bgaw2           DYNAMIC ARRAY OF VARCHAR(1) #位置在单身+显示为 Y，否则为 N
DEFINE g_bgaa008         LIKE bgaa_t.bgaa008
#DEFINE g_bgal            RECORD LIKE bgal_t.* #161108-00017#9 mark
#161108-00017#9 --s add
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
#161108-00017#9 --e add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bgcj_m          type_g_bgcj_m
DEFINE g_bgcj_m_t        type_g_bgcj_m
DEFINE g_bgcj_m_o        type_g_bgcj_m
DEFINE g_bgcj_m_mask_o   type_g_bgcj_m #轉換遮罩前資料
DEFINE g_bgcj_m_mask_n   type_g_bgcj_m #轉換遮罩後資料
 
   DEFINE g_bgcj002_t LIKE bgcj_t.bgcj002
DEFINE g_bgcj003_t LIKE bgcj_t.bgcj003
DEFINE g_bgcj004_t LIKE bgcj_t.bgcj004
DEFINE g_bgcj001_t LIKE bgcj_t.bgcj001
DEFINE g_bgcj005_t LIKE bgcj_t.bgcj005
DEFINE g_bgcj006_t LIKE bgcj_t.bgcj006
DEFINE g_bgcj010_t LIKE bgcj_t.bgcj010
DEFINE g_bgcj007_t LIKE bgcj_t.bgcj007
DEFINE g_bgcj009_t LIKE bgcj_t.bgcj009
 
 
DEFINE g_bgcj_d          DYNAMIC ARRAY OF type_g_bgcj_d
DEFINE g_bgcj_d_t        type_g_bgcj_d
DEFINE g_bgcj_d_o        type_g_bgcj_d
DEFINE g_bgcj_d_mask_o   DYNAMIC ARRAY OF type_g_bgcj_d #轉換遮罩前資料
DEFINE g_bgcj_d_mask_n   DYNAMIC ARRAY OF type_g_bgcj_d #轉換遮罩後資料
DEFINE g_bgcj2_d   DYNAMIC ARRAY OF type_g_bgcj2_d
DEFINE g_bgcj2_d_t type_g_bgcj2_d
DEFINE g_bgcj2_d_o type_g_bgcj2_d
DEFINE g_bgcj2_d_mask_o   DYNAMIC ARRAY OF type_g_bgcj2_d #轉換遮罩前資料
DEFINE g_bgcj2_d_mask_n   DYNAMIC ARRAY OF type_g_bgcj2_d #轉換遮罩後資料
DEFINE g_bgcj3_d   DYNAMIC ARRAY OF type_g_bgcj3_d
DEFINE g_bgcj3_d_t type_g_bgcj3_d
DEFINE g_bgcj3_d_o type_g_bgcj3_d
DEFINE g_bgcj3_d_mask_o   DYNAMIC ARRAY OF type_g_bgcj3_d #轉換遮罩前資料
DEFINE g_bgcj3_d_mask_n   DYNAMIC ARRAY OF type_g_bgcj3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bgcj001 LIKE bgcj_t.bgcj001,
      b_bgcj002 LIKE bgcj_t.bgcj002,
      b_bgcj003 LIKE bgcj_t.bgcj003,
      b_bgcj004 LIKE bgcj_t.bgcj004,
      b_bgcj005 LIKE bgcj_t.bgcj005,
      b_bgcj006 LIKE bgcj_t.bgcj006,
      b_bgcj007 LIKE bgcj_t.bgcj007,
      b_bgcj009 LIKE bgcj_t.bgcj009,
      b_bgcj010 LIKE bgcj_t.bgcj010
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
 
{<section id="abgt340.main" >}
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
   CALL s_abgt340_create_head_tmp()
   
   #单头锁资料重写，在fetch段定义
   IF 1=2 THEN
   #end add-point
   LET g_forupd_sql = " SELECT bgcj002,'',bgcj003,bgcj004,'','','',bgcj011,bgcj001,bgcj005,bgcj006,bgcj010, 
       bgcjstus,bgcj007,'',bgcj013,'',bgcj016,'',bgcj019,'',bgcj022,bgcj009,bgcj014,'',bgcj017,'',bgcj020, 
       '',bgcj023,'',bgcj012,'',bgcj015,'',bgcj018,'',bgcj021,'',bgcj024,'',''", 
                      " FROM bgcj_t",
                      " WHERE bgcjent= ? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND  
                          bgcj005=? AND bgcj006=? AND bgcj007=? AND bgcj009=? AND bgcj010=? FOR UPDATE" 
 
   #add-point:SQL_define name="main.after_define_sql"
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt340_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgcj002,t0.bgcj003,t0.bgcj004,t0.bgcj011,t0.bgcj001,t0.bgcj005,t0.bgcj006, 
       t0.bgcj010,t0.bgcjstus,t0.bgcj007,t0.bgcj013,t0.bgcj016,t0.bgcj019,t0.bgcj022,t0.bgcj009,t0.bgcj014, 
       t0.bgcj017,t0.bgcj020,t0.bgcj023,t0.bgcj012,t0.bgcj015,t0.bgcj018,t0.bgcj021,t0.bgcj024,t0.bgcj049, 
       t1.bgaal003 ,t2.bgail004",
               " FROM bgcj_t t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bgcj002 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN bgail_t t2 ON t2.bgailent="||g_enterprise||" AND t2.bgail001=t0.bgcj002 AND t2.bgail002=t0.bgcj004 AND t2.bgail003='"||g_dlang||"' ",
 
               " WHERE t0.bgcjent = " ||g_enterprise|| " AND t0.bgcj001 = ? AND t0.bgcj002 = ? AND t0.bgcj003 = ? AND t0.bgcj004 = ? AND t0.bgcj005 = ? AND t0.bgcj006 = ? AND t0.bgcj007 = ? AND t0.bgcj009 = ? AND t0.bgcj010 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   END IF
   #重寫抓取單頭資料SQL，資料改抓取單頭臨時表
   LET g_sql = " SELECT DISTINCT t0.bgcj002,t0.bgcj003,t0.bgcj004,t0.bgcj011,t0.bgcj001,t0.bgcj005,t0.bgcj006, 
       t0.bgcj010,t0.bgcjstus,t0.bgcj007,t0.bgcj013,t0.bgcj016,t0.bgcj019,t0.bgcj022,t0.bgcj009,t0.bgcj014, 
       t0.bgcj017,t0.bgcj020,t0.bgcj023,t0.bgcj012,t0.bgcj015,t0.bgcj018,t0.bgcj021,t0.bgcj024,t0.bgcj049, 
       t1.bgaal003 ,t2.bgail004",       
               " FROM s_abgt340_tmp t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bgcj002 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN bgail_t t2 ON t2.bgailent="||g_enterprise||" AND t2.bgail001=t0.bgcj002 AND t2.bgail002=t0.bgcj004 AND t2.bgail003='"||g_dlang||"' ",
 
               " WHERE t0.bgcjent = " ||g_enterprise|| " AND t0.bgcj001 = ? AND t0.bgcj002 = ? AND t0.bgcj003 = ? AND t0.bgcj004 = ? AND t0.bgcj005 = ? AND t0.bgcj006 = ? AND t0.bgcj007 = ? AND t0.bgcj009 = ? AND t0.bgcj010 = ?"
   #end add-point
   PREPARE abgt340_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt340 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt340_init()   
 
      #進入選單 Menu (="N")
      CALL abgt340_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt340
      
   END IF 
   
   CLOSE abgt340_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_abgt340_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt340.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt340_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('bgcjstus','13','N,Y,FC,A,D,R,W,X')
 
      CALL cl_set_combo_scc('bgcj005','8952') 
   CALL cl_set_combo_scc('bgcj006','9989') 
   CALL cl_set_combo_scc('bgcj022','6013') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
#   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('bgcj022_2','6013')
   #end add-point
   
   CALL abgt340_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt340.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt340_ui_dialog()
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
   CALL cl_set_act_visible("open_abgt340_01_s", FALSE)
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bgcj_m.* TO NULL
         CALL g_bgcj_d.clear()
         CALL g_bgcj2_d.clear()
         CALL g_bgcj3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt340_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_bgcj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgt340_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgt340_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               #根据单身一的资料动态显示对应调整资料
               CALL abgt340_b_fill2(l_ac)
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
        
         DISPLAY ARRAY g_bgcj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt340_idx_chk()
               CALL abgt340_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               #根据单身一的资料动态显示对应调整资料
               CALL abgt340_b_fill2(l_ac)
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
         DISPLAY ARRAY g_bgcj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt340_idx_chk()
               CALL abgt340_ui_detailshow()
               
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
            CALL abgt340_browser_fill("")
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
               CALL abgt340_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt340_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abgt340_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abgt340_set_act_visible()   
            CALL abgt340_set_act_no_visible()
            IF NOT (g_bgcj_m.bgcj001 IS NULL
                 OR g_bgcj_m.bgcj002 IS NULL
                 OR g_bgcj_m.bgcj003 IS NULL
                 OR g_bgcj_m.bgcj004 IS NULL
                 OR g_bgcj_m.bgcj005 IS NULL
                 OR g_bgcj_m.bgcj006 IS NULL
                 OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 IS NULL)
                 OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 IS NULL)
            
              ) THEN
               #組合條件
               LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                                  " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                                 ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                                 ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                                 ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                                 ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                                 ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
                                 ," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
                                 ," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
            
               #填到對應位置
               CALL abgt340_browser_fill("")
            END IF
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt340_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt340_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt340_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt340_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt340_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt340_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt340_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt340_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt340_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt340_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgcj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgcj2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_bgcj3_d)
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
               NEXT FIELD bgcj008
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
               CALL abgt340_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgt340_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgt340_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt340_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt340_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_01
            LET g_action_choice="open_abgt340_01"
            IF cl_auth_chk_act("open_abgt340_01") THEN
               
               #add-point:ON ACTION open_abgt340_01 name="menu.open_abgt340_01"
               #本层调整
               CALL abgt340_adjust(1)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_02
            LET g_action_choice="open_abgt340_02"
            IF cl_auth_chk_act("open_abgt340_02") THEN
               
               #add-point:ON ACTION open_abgt340_02 name="menu.open_abgt340_02"
               IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) AND
                  NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) AND 
                  NOT cl_null(g_bgcj_m.bgcj011) THEN
                  CALL abgt340_02(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                  g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj011)
                  RETURNING l_success
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt340_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt340_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgp330
            LET g_action_choice="open_abgp330"
            IF cl_auth_chk_act("open_abgp330") THEN
               
               #add-point:ON ACTION open_abgp330 name="menu.open_abgp330"
                #调用abgp330,但是abgp330还没开发，先预留
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/abg/abgt340_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/abg/abgt340_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgt340_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt340_query()
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
               CALL abgt340_adjust(2)
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
            CALL abgt340_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt340_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt340_set_pk_array()
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
 
{<section id="abgt340.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgt340_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt340.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt340_browser_fill(ps_page_action)
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
   LET l_wc = " bgcj001='20' AND ",g_wc," AND ",g_wc2
   
   #檢查預算組織是否在abgi090中可操作的組織中
   CALL s_abg2_get_budget_site('','',g_user,'01') RETURNING l_ooef001_str
   CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
   LET l_wc = l_wc," AND bgcj007 IN ",l_ooef001_str
   #抓取有权限的管理组织
   LET l_wc=l_wc," AND bgcj004 IN (SELECT DISTINCT bgai002 FROM bgai_t ",
                 "                  WHERE bgaient=",g_enterprise," AND bgaistus='Y' ",
                 "                    AND bgai003='",g_user,"'",
                 "                    AND (bgai005='00' OR bgai005='01') ",
                 "                 )"
            
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                         " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                        ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                        ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                        ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                        ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                        ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
      IF g_bgaw1[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
      END IF
      IF g_bgaw2[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
      END IF
   END IF
      
   CALL s_abgt340_create_head(l_wc,g_add_browse)
   #end add-point    
 
   LET l_searchcol = "bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj009,bgcj010"
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
      LET l_sub_sql = " SELECT DISTINCT bgcj001 ",
                      ", bgcj002 ",
                      ", bgcj003 ",
                      ", bgcj004 ",
                      ", bgcj005 ",
                      ", bgcj006 ",
                      ", bgcj007 ",
                      ", bgcj009 ",
                      ", bgcj010 ",
 
                      " FROM bgcj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bgcjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgcj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgcj001 ",
                      ", bgcj002 ",
                      ", bgcj003 ",
                      ", bgcj004 ",
                      ", bgcj005 ",
                      ", bgcj006 ",
                      ", bgcj007 ",
                      ", bgcj009 ",
                      ", bgcj010 ",
 
                      " FROM bgcj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bgcjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgcj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #重写l_sub_sql 和 g_sql 语句，抓取资料来源改为单头临时表
   LET l_sub_sql = " SELECT DISTINCT bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj009,bgcj010 ",
                   "   FROM s_abgt340_tmp ",
                   " WHERE bgcjent = ",g_enterprise
                   
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
      INITIALIZE g_bgcj_m.* TO NULL
      CALL g_bgcj_d.clear()        
      CALL g_bgcj2_d.clear() 
      CALL g_bgcj3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgcj001,t0.bgcj002,t0.bgcj003,t0.bgcj004,t0.bgcj005,t0.bgcj006,t0.bgcj007,t0.bgcj009,t0.bgcj010 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bgcj001,t0.bgcj002,t0.bgcj003,t0.bgcj004,t0.bgcj005,t0.bgcj006,t0.bgcj007, 
       t0.bgcj009,t0.bgcj010",
                " FROM bgcj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bgcjent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bgcj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #組合條件
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                         " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                        ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                        ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                        ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                        ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                        ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
      IF g_bgaw1[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
      END IF
      IF g_bgaw2[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
      END IF
      LET l_wc  = g_add_browse
   ELSE
      LET l_wc  = ' 1=1'
   END IF
   #重写g_sql 语句，抓取资料来源改为单头临时表
   LET g_sql  = "SELECT DISTINCT bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj009,bgcj010 ",
                " FROM s_abgt340_tmp ",
                " WHERE bgcjent = " ||g_enterprise|| " AND ", l_wc
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgcj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bgcj001,g_browser[g_cnt].b_bgcj002,g_browser[g_cnt].b_bgcj003, 
          g_browser[g_cnt].b_bgcj004,g_browser[g_cnt].b_bgcj005,g_browser[g_cnt].b_bgcj006,g_browser[g_cnt].b_bgcj007, 
          g_browser[g_cnt].b_bgcj009,g_browser[g_cnt].b_bgcj010 
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
   
   IF cl_null(g_browser[g_cnt].b_bgcj001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bgcj_m.* TO NULL
      CALL g_bgcj_d.clear()
      CALL g_bgcj2_d.clear()
      CALL g_bgcj3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgt340_fetch('')
   
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
 
{<section id="abgt340.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt340_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
 
   #end add-point
   
   LET g_bgcj_m.bgcj001 = g_browser[g_current_idx].b_bgcj001   
   LET g_bgcj_m.bgcj002 = g_browser[g_current_idx].b_bgcj002   
   LET g_bgcj_m.bgcj003 = g_browser[g_current_idx].b_bgcj003   
   LET g_bgcj_m.bgcj004 = g_browser[g_current_idx].b_bgcj004   
   LET g_bgcj_m.bgcj005 = g_browser[g_current_idx].b_bgcj005   
   LET g_bgcj_m.bgcj006 = g_browser[g_current_idx].b_bgcj006   
   LET g_bgcj_m.bgcj007 = g_browser[g_current_idx].b_bgcj007   
   LET g_bgcj_m.bgcj009 = g_browser[g_current_idx].b_bgcj009   
   LET g_bgcj_m.bgcj010 = g_browser[g_current_idx].b_bgcj010   
 
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010 INTO g_bgcj_m.bgcj002, 
       g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023, 
       g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj049, 
       g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc
   CALL abgt340_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt340_ui_detailshow()
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
 
{<section id="abgt340.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt340_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgcj001 = g_bgcj_m.bgcj001 
         AND g_browser[l_i].b_bgcj002 = g_bgcj_m.bgcj002 
         AND g_browser[l_i].b_bgcj003 = g_bgcj_m.bgcj003 
         AND g_browser[l_i].b_bgcj004 = g_bgcj_m.bgcj004 
         AND g_browser[l_i].b_bgcj005 = g_bgcj_m.bgcj005 
         AND g_browser[l_i].b_bgcj006 = g_bgcj_m.bgcj006 
         AND g_browser[l_i].b_bgcj007 = g_bgcj_m.bgcj007 
         AND g_browser[l_i].b_bgcj009 = g_bgcj_m.bgcj009 
         AND g_browser[l_i].b_bgcj010 = g_bgcj_m.bgcj010 
 
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
 
{<section id="abgt340.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt340_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002
   DEFINE l_bgcj005       LIKE bgcj_t.bgcj005
   DEFINE l_ooef001_str   STRING
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_bgcj_m.* TO NULL
   CALL g_bgcj_d.clear()
   CALL g_bgcj2_d.clear()
   CALL g_bgcj3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   CALL cl_set_comp_visible("bgcj007,bgcj007_desc_t,bgcj009,bgcj013,bgcj013_desc_t,bgcj014,bgcj014_desc_t,bgcj015,bgcj015_desc_t,bgcj016,bgcj016_desc_t,bgcj017,bgcj017_desc_t,group_1",TRUE)
   CALL cl_set_comp_visible("bgcj018,bgcj018_desc_t,bgcj019,bgcj019_desc_t,bgcj022,bgcj023,bgcj023_desc_t,bgcj024,bgcj024_desc_t,bgcj012,bgcj012_desc_t,bgcj020,bgcj020_desc_t,bgcj021,bgcj021_desc_t",TRUE)
   
   CALL cl_set_comp_visible("bgcj007_desc,bgcj009_desc,bgcj013_desc,bgcj014_desc,bgcj015_desc,bgcj016_desc,bgcj017_desc",TRUE)
   CALL cl_set_comp_visible("bgcj018_desc,bgcj019_desc,bgcj022_2,bgcj023_desc,bgcj024_desc,bgcj012_desc,bgcj020_desc,bgcj021_desc",TRUE)
      
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgcj002,bgcj003,bgcj004,bgcj011,bgcj001,bgcj005,bgcj006,bgcj010,bgcjstus, 
          bgcj007,bgcj013,bgcj016,bgcj019,bgcj022,bgcj009,bgcj014,bgcj017,bgcj020,bgcj023,bgcj012,bgcj015, 
          bgcj018,bgcj021,bgcj024,bgcj049
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="construct.c.bgcj002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus='Y' AND bgaa006 = '1' "
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj002  #顯示到畫面上
            NEXT FIELD bgcj002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="construct.b.bgcj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="construct.a.bgcj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="construct.b.bgcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="construct.a.bgcj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="construct.c.bgcj003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgcj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj004
            #add-point:ON ACTION controlp INFIELD bgcj004 name="construct.c.bgcj004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='01' OR bgai005='00')" 
            CALL q_bgai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj004  #顯示到畫面上
            NEXT FIELD bgcj004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj004
            #add-point:BEFORE FIELD bgcj004 name="construct.b.bgcj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj004
            
            #add-point:AFTER FIELD bgcj004 name="construct.a.bgcj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj011
            #add-point:ON ACTION controlp INFIELD bgcj011 name="construct.c.bgcj011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgaw001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj011  #顯示到畫面上
            NEXT FIELD bgcj011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj011
            #add-point:BEFORE FIELD bgcj011 name="construct.b.bgcj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj011
            
            #add-point:AFTER FIELD bgcj011 name="construct.a.bgcj011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj001
            #add-point:BEFORE FIELD bgcj001 name="construct.b.bgcj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj001
            
            #add-point:AFTER FIELD bgcj001 name="construct.a.bgcj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj001
            #add-point:ON ACTION controlp INFIELD bgcj001 name="construct.c.bgcj001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj005
            #add-point:BEFORE FIELD bgcj005 name="construct.b.bgcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj005
            
            #add-point:AFTER FIELD bgcj005 name="construct.a.bgcj005"
            CALL FGL_DIALOG_GETBUFFER() RETURNING l_bgcj005
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj005
            #add-point:ON ACTION controlp INFIELD bgcj005 name="construct.c.bgcj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj006
            #add-point:BEFORE FIELD bgcj006 name="construct.b.bgcj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj006
            
            #add-point:AFTER FIELD bgcj006 name="construct.a.bgcj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj006
            #add-point:ON ACTION controlp INFIELD bgcj006 name="construct.c.bgcj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj010
            #add-point:BEFORE FIELD bgcj010 name="construct.b.bgcj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj010
            
            #add-point:AFTER FIELD bgcj010 name="construct.a.bgcj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj010
            #add-point:ON ACTION controlp INFIELD bgcj010 name="construct.c.bgcj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjstus
            #add-point:BEFORE FIELD bgcjstus name="construct.b.bgcjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjstus
            
            #add-point:AFTER FIELD bgcjstus name="construct.a.bgcjstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjstus
            #add-point:ON ACTION controlp INFIELD bgcjstus name="construct.c.bgcjstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="construct.c.bgcj007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'01') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj007  #顯示到畫面上
            NEXT FIELD bgcj007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="construct.b.bgcj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="construct.a.bgcj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj013
            #add-point:ON ACTION controlp INFIELD bgcj013 name="construct.c.bgcj013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj013  #顯示到畫面上
            NEXT FIELD bgcj013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj013
            #add-point:BEFORE FIELD bgcj013 name="construct.b.bgcj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj013
            
            #add-point:AFTER FIELD bgcj013 name="construct.a.bgcj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016
            #add-point:ON ACTION controlp INFIELD bgcj016 name="construct.c.bgcj016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj016  #顯示到畫面上
            NEXT FIELD bgcj016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016
            #add-point:BEFORE FIELD bgcj016 name="construct.b.bgcj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016
            
            #add-point:AFTER FIELD bgcj016 name="construct.a.bgcj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj019
            #add-point:ON ACTION controlp INFIELD bgcj019 name="construct.c.bgcj019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj019  #顯示到畫面上
            NEXT FIELD bgcj019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj019
            #add-point:BEFORE FIELD bgcj019 name="construct.b.bgcj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj019
            
            #add-point:AFTER FIELD bgcj019 name="construct.a.bgcj019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj022
            #add-point:BEFORE FIELD bgcj022 name="construct.b.bgcj022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj022
            
            #add-point:AFTER FIELD bgcj022 name="construct.a.bgcj022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj022
            #add-point:ON ACTION controlp INFIELD bgcj022 name="construct.c.bgcj022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgcj009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009
            #add-point:ON ACTION controlp INFIELD bgcj009 name="construct.c.bgcj009"
            #應用 a08 樣板自動產生(Version:3)
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
            NEXT FIELD bgcj009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009
            #add-point:BEFORE FIELD bgcj009 name="construct.b.bgcj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009
            
            #add-point:AFTER FIELD bgcj009 name="construct.a.bgcj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj014
            #add-point:ON ACTION controlp INFIELD bgcj014 name="construct.c.bgcj014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj014  #顯示到畫面上
            NEXT FIELD bgcj014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj014
            #add-point:BEFORE FIELD bgcj014 name="construct.b.bgcj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj014
            
            #add-point:AFTER FIELD bgcj014 name="construct.a.bgcj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj017
            #add-point:ON ACTION controlp INFIELD bgcj017 name="construct.c.bgcj017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj017  #顯示到畫面上
            NEXT FIELD bgcj017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj017
            #add-point:BEFORE FIELD bgcj017 name="construct.b.bgcj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj017
            
            #add-point:AFTER FIELD bgcj017 name="construct.a.bgcj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj020
            #add-point:ON ACTION controlp INFIELD bgcj020 name="construct.c.bgcj020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj020  #顯示到畫面上
            NEXT FIELD bgcj020                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj020
            #add-point:BEFORE FIELD bgcj020 name="construct.b.bgcj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj020
            
            #add-point:AFTER FIELD bgcj020 name="construct.a.bgcj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj023
            #add-point:ON ACTION controlp INFIELD bgcj023 name="construct.c.bgcj023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj023  #顯示到畫面上
            NEXT FIELD bgcj023                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj023
            #add-point:BEFORE FIELD bgcj023 name="construct.b.bgcj023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj023
            
            #add-point:AFTER FIELD bgcj023 name="construct.a.bgcj023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj012
            #add-point:ON ACTION controlp INFIELD bgcj012 name="construct.c.bgcj012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj012  #顯示到畫面上
            NEXT FIELD bgcj012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj012
            #add-point:BEFORE FIELD bgcj012 name="construct.b.bgcj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj012
            
            #add-point:AFTER FIELD bgcj012 name="construct.a.bgcj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj015
            #add-point:ON ACTION controlp INFIELD bgcj015 name="construct.c.bgcj015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj015  #顯示到畫面上
            NEXT FIELD bgcj015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj015
            #add-point:BEFORE FIELD bgcj015 name="construct.b.bgcj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj015
            
            #add-point:AFTER FIELD bgcj015 name="construct.a.bgcj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj018
            #add-point:ON ACTION controlp INFIELD bgcj018 name="construct.c.bgcj018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj018  #顯示到畫面上
            NEXT FIELD bgcj018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj018
            #add-point:BEFORE FIELD bgcj018 name="construct.b.bgcj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj018
            
            #add-point:AFTER FIELD bgcj018 name="construct.a.bgcj018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj021
            #add-point:ON ACTION controlp INFIELD bgcj021 name="construct.c.bgcj021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj021  #顯示到畫面上
            NEXT FIELD bgcj021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj021
            #add-point:BEFORE FIELD bgcj021 name="construct.b.bgcj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj021
            
            #add-point:AFTER FIELD bgcj021 name="construct.a.bgcj021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj024
            #add-point:ON ACTION controlp INFIELD bgcj024 name="construct.c.bgcj024"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj024  #顯示到畫面上
            NEXT FIELD bgcj024                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj024
            #add-point:BEFORE FIELD bgcj024 name="construct.b.bgcj024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj024
            
            #add-point:AFTER FIELD bgcj024 name="construct.a.bgcj024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj049
            #add-point:BEFORE FIELD bgcj049 name="construct.b.bgcj049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj049
            
            #add-point:AFTER FIELD bgcj049 name="construct.a.bgcj049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgcj049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj049
            #add-point:ON ACTION controlp INFIELD bgcj049 name="construct.c.bgcj049"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bgcjseq,bgcj010_2,bgcj007_2,bgcj007_desc,bgcj009_2,bgcj009_desc,bgcj049, 
          bgcj012_2,bgcj012_desc,bgcj013_2,bgcj013_desc,bgcj014_2,bgcj014_desc,bgcj015_2,bgcj015_desc, 
          bgcj016_2,bgcj016_desc,bgcj017_2,bgcj017_desc,bgcj018_2,bgcj018_desc,bgcj019_2,bgcj019_desc, 
          bgcj020_2,bgcj020_desc,bgcj021_2,bgcj021_desc,bgcj022_2,bgcj023_2,bgcj023_desc,bgcj024_2,bgcj024_desc, 
          bgcj035,bgcj036,bgcj037,bgcj100,bgcj008,bgcj047,bgcj048,bgcj050,bgcjownid,bgcjowndp,bgcjcrtid, 
          bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt
           FROM s_detail1[1].bgcjseq,s_detail1[1].bgcj010_2,s_detail1[1].bgcj007_2,s_detail1[1].bgcj007_desc, 
               s_detail1[1].bgcj009_2,s_detail1[1].bgcj009_desc,s_detail1[1].bgcj049,s_detail1[1].bgcj012_2, 
               s_detail1[1].bgcj012_desc,s_detail1[1].bgcj013_2,s_detail1[1].bgcj013_desc,s_detail1[1].bgcj014_2, 
               s_detail1[1].bgcj014_desc,s_detail1[1].bgcj015_2,s_detail1[1].bgcj015_desc,s_detail1[1].bgcj016_2, 
               s_detail1[1].bgcj016_desc,s_detail1[1].bgcj017_2,s_detail1[1].bgcj017_desc,s_detail1[1].bgcj018_2, 
               s_detail1[1].bgcj018_desc,s_detail1[1].bgcj019_2,s_detail1[1].bgcj019_desc,s_detail1[1].bgcj020_2, 
               s_detail1[1].bgcj020_desc,s_detail1[1].bgcj021_2,s_detail1[1].bgcj021_desc,s_detail1[1].bgcj022_2, 
               s_detail1[1].bgcj023_2,s_detail1[1].bgcj023_desc,s_detail1[1].bgcj024_2,s_detail1[1].bgcj024_desc, 
               s_detail1[1].bgcj035,s_detail1[1].bgcj036,s_detail1[1].bgcj037,s_detail1[1].bgcj100,s_detail1[1].bgcj008, 
               s_detail1[1].bgcj047,s_detail1[1].bgcj048,s_detail1[1].bgcj050,s_detail2[1].bgcjownid, 
               s_detail2[1].bgcjowndp,s_detail2[1].bgcjcrtid,s_detail2[1].bgcjcrtdp,s_detail2[1].bgcjcrtdt, 
               s_detail2[1].bgcjmodid,s_detail2[1].bgcjmoddt,s_detail2[1].bgcjcnfid,s_detail2[1].bgcjcnfdt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgcjcrtdt>>----
         AFTER FIELD bgcjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgcjmoddt>>----
         AFTER FIELD bgcjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgcjcnfdt>>----
         AFTER FIELD bgcjcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgcjpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjseq
            #add-point:BEFORE FIELD bgcjseq name="construct.b.page1.bgcjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjseq
            
            #add-point:AFTER FIELD bgcjseq name="construct.a.page1.bgcjseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjseq
            #add-point:ON ACTION controlp INFIELD bgcjseq name="construct.c.page1.bgcjseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj010_2
            #add-point:BEFORE FIELD bgcj010_2 name="construct.b.page1.bgcj010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj010_2
            
            #add-point:AFTER FIELD bgcj010_2 name="construct.a.page1.bgcj010_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj010_2
            #add-point:ON ACTION controlp INFIELD bgcj010_2 name="construct.c.page1.bgcj010_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgcj007_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007_2
            #add-point:ON ACTION controlp INFIELD bgcj007_2 name="construct.c.page1.bgcj007_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj007_2  #顯示到畫面上
            NEXT FIELD bgcj007_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007_2
            #add-point:BEFORE FIELD bgcj007_2 name="construct.b.page1.bgcj007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007_2
            
            #add-point:AFTER FIELD bgcj007_2 name="construct.a.page1.bgcj007_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007_desc
            #add-point:ON ACTION controlp INFIELD bgcj007_desc name="construct.c.page1.bgcj007_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'01') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj007_desc  #顯示到畫面上
            NEXT FIELD bgcj007_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007_desc
            #add-point:BEFORE FIELD bgcj007_desc name="construct.b.page1.bgcj007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007_desc
            
            #add-point:AFTER FIELD bgcj007_desc name="construct.a.page1.bgcj007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009_2
            #add-point:ON ACTION controlp INFIELD bgcj009_2 name="construct.c.page1.bgcj009_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj009_2  #顯示到畫面上
            NEXT FIELD bgcj009_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009_2
            #add-point:BEFORE FIELD bgcj009_2 name="construct.b.page1.bgcj009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009_2
            
            #add-point:AFTER FIELD bgcj009_2 name="construct.a.page1.bgcj009_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009_desc
            #add-point:ON ACTION controlp INFIELD bgcj009_desc name="construct.c.page1.bgcj009_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF l_bgcj005 = '4' THEN
               CALL q_bgcc001()
            ElSE
               CALL q_bgas001()
            END IF
            DISPLAY g_qryparam.return1 TO bgcj009_desc  #顯示到畫面上
            NEXT FIELD bgcj009_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009_desc
            #add-point:BEFORE FIELD bgcj009_desc name="construct.b.page1.bgcj009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009_desc
            
            #add-point:AFTER FIELD bgcj009_desc name="construct.a.page1.bgcj009_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj049
            #add-point:BEFORE FIELD bgcj049 name="construct.b.page1.bgcj049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj049
            
            #add-point:AFTER FIELD bgcj049 name="construct.a.page1.bgcj049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj049
            #add-point:ON ACTION controlp INFIELD bgcj049 name="construct.c.page1.bgcj049"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgcj012_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj012_2
            #add-point:ON ACTION controlp INFIELD bgcj012_2 name="construct.c.page1.bgcj012_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj012_2  #顯示到畫面上
            NEXT FIELD bgcj012_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj012_2
            #add-point:BEFORE FIELD bgcj012_2 name="construct.b.page1.bgcj012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj012_2
            
            #add-point:AFTER FIELD bgcj012_2 name="construct.a.page1.bgcj012_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj012_desc
            #add-point:ON ACTION controlp INFIELD bgcj012_desc name="construct.c.page1.bgcj012_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj012_desc  #顯示到畫面上
            NEXT FIELD bgcj012_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj012_desc
            #add-point:BEFORE FIELD bgcj012_desc name="construct.b.page1.bgcj012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj012_desc
            
            #add-point:AFTER FIELD bgcj012_desc name="construct.a.page1.bgcj012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj013_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj013_2
            #add-point:ON ACTION controlp INFIELD bgcj013_2 name="construct.c.page1.bgcj013_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj013_2  #顯示到畫面上
            NEXT FIELD bgcj013_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj013_2
            #add-point:BEFORE FIELD bgcj013_2 name="construct.b.page1.bgcj013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj013_2
            
            #add-point:AFTER FIELD bgcj013_2 name="construct.a.page1.bgcj013_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj013_desc
            #add-point:ON ACTION controlp INFIELD bgcj013_desc name="construct.c.page1.bgcj013_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj013_desc  #顯示到畫面上
            NEXT FIELD bgcj013_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj013_desc
            #add-point:BEFORE FIELD bgcj013_desc name="construct.b.page1.bgcj013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj013_desc
            
            #add-point:AFTER FIELD bgcj013_desc name="construct.a.page1.bgcj013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj014_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj014_2
            #add-point:ON ACTION controlp INFIELD bgcj014_2 name="construct.c.page1.bgcj014_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj014_2  #顯示到畫面上
            NEXT FIELD bgcj014_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj014_2
            #add-point:BEFORE FIELD bgcj014_2 name="construct.b.page1.bgcj014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj014_2
            
            #add-point:AFTER FIELD bgcj014_2 name="construct.a.page1.bgcj014_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj014_desc
            #add-point:ON ACTION controlp INFIELD bgcj014_desc name="construct.c.page1.bgcj014_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus='Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj014_desc  #顯示到畫面上
            NEXT FIELD bgcj014_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj014_desc
            #add-point:BEFORE FIELD bgcj014_desc name="construct.b.page1.bgcj014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj014_desc
            
            #add-point:AFTER FIELD bgcj014_desc name="construct.a.page1.bgcj014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj015_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj015_2
            #add-point:ON ACTION controlp INFIELD bgcj015_2 name="construct.c.page1.bgcj015_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj015_2  #顯示到畫面上
            NEXT FIELD bgcj015_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj015_2
            #add-point:BEFORE FIELD bgcj015_2 name="construct.b.page1.bgcj015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj015_2
            
            #add-point:AFTER FIELD bgcj015_2 name="construct.a.page1.bgcj015_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj015_desc
            #add-point:ON ACTION controlp INFIELD bgcj015_desc name="construct.c.page1.bgcj015_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj015_desc  #顯示到畫面上
            NEXT FIELD bgcj015_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj015_desc
            #add-point:BEFORE FIELD bgcj015_desc name="construct.b.page1.bgcj015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj015_desc
            
            #add-point:AFTER FIELD bgcj015_desc name="construct.a.page1.bgcj015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj016_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016_2
            #add-point:ON ACTION controlp INFIELD bgcj016_2 name="construct.c.page1.bgcj016_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj016_2  #顯示到畫面上
            NEXT FIELD bgcj016_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016_2
            #add-point:BEFORE FIELD bgcj016_2 name="construct.b.page1.bgcj016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016_2
            
            #add-point:AFTER FIELD bgcj016_2 name="construct.a.page1.bgcj016_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016_desc
            #add-point:ON ACTION controlp INFIELD bgcj016_desc name="construct.c.page1.bgcj016_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj016_desc  #顯示到畫面上
            NEXT FIELD bgcj016_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016_desc
            #add-point:BEFORE FIELD bgcj016_desc name="construct.b.page1.bgcj016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016_desc
            
            #add-point:AFTER FIELD bgcj016_desc name="construct.a.page1.bgcj016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj017_2
            #add-point:ON ACTION controlp INFIELD bgcj017_2 name="construct.c.page1.bgcj017_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj017_2  #顯示到畫面上
            NEXT FIELD bgcj017_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj017_2
            #add-point:BEFORE FIELD bgcj017_2 name="construct.b.page1.bgcj017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj017_2
            
            #add-point:AFTER FIELD bgcj017_2 name="construct.a.page1.bgcj017_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj017_desc
            #add-point:ON ACTION controlp INFIELD bgcj017_desc name="construct.c.page1.bgcj017_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj017_desc  #顯示到畫面上
            NEXT FIELD bgcj017_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj017_desc
            #add-point:BEFORE FIELD bgcj017_desc name="construct.b.page1.bgcj017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj017_desc
            
            #add-point:AFTER FIELD bgcj017_desc name="construct.a.page1.bgcj017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj018_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj018_2
            #add-point:ON ACTION controlp INFIELD bgcj018_2 name="construct.c.page1.bgcj018_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj018_2  #顯示到畫面上
            NEXT FIELD bgcj018_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj018_2
            #add-point:BEFORE FIELD bgcj018_2 name="construct.b.page1.bgcj018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj018_2
            
            #add-point:AFTER FIELD bgcj018_2 name="construct.a.page1.bgcj018_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj018_desc
            #add-point:ON ACTION controlp INFIELD bgcj018_desc name="construct.c.page1.bgcj018_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj018_desc  #顯示到畫面上
            NEXT FIELD bgcj018_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj018_desc
            #add-point:BEFORE FIELD bgcj018_desc name="construct.b.page1.bgcj018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj018_desc
            
            #add-point:AFTER FIELD bgcj018_desc name="construct.a.page1.bgcj018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj019_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj019_2
            #add-point:ON ACTION controlp INFIELD bgcj019_2 name="construct.c.page1.bgcj019_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj019_2  #顯示到畫面上
            NEXT FIELD bgcj019_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj019_2
            #add-point:BEFORE FIELD bgcj019_2 name="construct.b.page1.bgcj019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj019_2
            
            #add-point:AFTER FIELD bgcj019_2 name="construct.a.page1.bgcj019_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj019_desc
            #add-point:ON ACTION controlp INFIELD bgcj019_desc name="construct.c.page1.bgcj019_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj019_desc  #顯示到畫面上
            NEXT FIELD bgcj019_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj019_desc
            #add-point:BEFORE FIELD bgcj019_desc name="construct.b.page1.bgcj019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj019_desc
            
            #add-point:AFTER FIELD bgcj019_desc name="construct.a.page1.bgcj019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj020_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj020_2
            #add-point:ON ACTION controlp INFIELD bgcj020_2 name="construct.c.page1.bgcj020_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj020_2  #顯示到畫面上
            NEXT FIELD bgcj020_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj020_2
            #add-point:BEFORE FIELD bgcj020_2 name="construct.b.page1.bgcj020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj020_2
            
            #add-point:AFTER FIELD bgcj020_2 name="construct.a.page1.bgcj020_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj020_desc
            #add-point:ON ACTION controlp INFIELD bgcj020_desc name="construct.c.page1.bgcj020_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj020_desc  #顯示到畫面上
            NEXT FIELD bgcj020_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj020_desc
            #add-point:BEFORE FIELD bgcj020_desc name="construct.b.page1.bgcj020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj020_desc
            
            #add-point:AFTER FIELD bgcj020_desc name="construct.a.page1.bgcj020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj021_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj021_2
            #add-point:ON ACTION controlp INFIELD bgcj021_2 name="construct.c.page1.bgcj021_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj021_2  #顯示到畫面上
            NEXT FIELD bgcj021_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj021_2
            #add-point:BEFORE FIELD bgcj021_2 name="construct.b.page1.bgcj021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj021_2
            
            #add-point:AFTER FIELD bgcj021_2 name="construct.a.page1.bgcj021_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj021_desc
            #add-point:ON ACTION controlp INFIELD bgcj021_desc name="construct.c.page1.bgcj021_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj021_desc  #顯示到畫面上
            NEXT FIELD bgcj021_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj021_desc
            #add-point:BEFORE FIELD bgcj021_desc name="construct.b.page1.bgcj021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj021_desc
            
            #add-point:AFTER FIELD bgcj021_desc name="construct.a.page1.bgcj021_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj022_2
            #add-point:BEFORE FIELD bgcj022_2 name="construct.b.page1.bgcj022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj022_2
            
            #add-point:AFTER FIELD bgcj022_2 name="construct.a.page1.bgcj022_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj022_2
            #add-point:ON ACTION controlp INFIELD bgcj022_2 name="construct.c.page1.bgcj022_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgcj023_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj023_2
            #add-point:ON ACTION controlp INFIELD bgcj023_2 name="construct.c.page1.bgcj023_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj023_2  #顯示到畫面上
            NEXT FIELD bgcj023_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj023_2
            #add-point:BEFORE FIELD bgcj023_2 name="construct.b.page1.bgcj023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj023_2
            
            #add-point:AFTER FIELD bgcj023_2 name="construct.a.page1.bgcj023_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj023_desc
            #add-point:ON ACTION controlp INFIELD bgcj023_desc name="construct.c.page1.bgcj023_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj023_desc  #顯示到畫面上
            NEXT FIELD bgcj023_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj023_desc
            #add-point:BEFORE FIELD bgcj023_desc name="construct.b.page1.bgcj023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj023_desc
            
            #add-point:AFTER FIELD bgcj023_desc name="construct.a.page1.bgcj023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj024_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj024_2
            #add-point:ON ACTION controlp INFIELD bgcj024_2 name="construct.c.page1.bgcj024_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj024_2  #顯示到畫面上
            NEXT FIELD bgcj024_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj024_2
            #add-point:BEFORE FIELD bgcj024_2 name="construct.b.page1.bgcj024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj024_2
            
            #add-point:AFTER FIELD bgcj024_2 name="construct.a.page1.bgcj024_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj024_desc
            #add-point:ON ACTION controlp INFIELD bgcj024_desc name="construct.c.page1.bgcj024_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj024_desc  #顯示到畫面上
            NEXT FIELD bgcj024_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj024_desc
            #add-point:BEFORE FIELD bgcj024_desc name="construct.b.page1.bgcj024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj024_desc
            
            #add-point:AFTER FIELD bgcj024_desc name="construct.a.page1.bgcj024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj035
            #add-point:ON ACTION controlp INFIELD bgcj035 name="construct.c.page1.bgcj035"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj035  #顯示到畫面上
            NEXT FIELD bgcj035                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj035
            #add-point:BEFORE FIELD bgcj035 name="construct.b.page1.bgcj035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj035
            
            #add-point:AFTER FIELD bgcj035 name="construct.a.page1.bgcj035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj036
            #add-point:BEFORE FIELD bgcj036 name="construct.b.page1.bgcj036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj036
            
            #add-point:AFTER FIELD bgcj036 name="construct.a.page1.bgcj036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj036
            #add-point:ON ACTION controlp INFIELD bgcj036 name="construct.c.page1.bgcj036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgcj037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj037
            #add-point:ON ACTION controlp INFIELD bgcj037 name="construct.c.page1.bgcj037"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj037  #顯示到畫面上
            NEXT FIELD bgcj037                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj037
            #add-point:BEFORE FIELD bgcj037 name="construct.b.page1.bgcj037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj037
            
            #add-point:AFTER FIELD bgcj037 name="construct.a.page1.bgcj037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj100
            #add-point:ON ACTION controlp INFIELD bgcj100 name="construct.c.page1.bgcj100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj100  #顯示到畫面上
            NEXT FIELD bgcj100                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj100
            #add-point:BEFORE FIELD bgcj100 name="construct.b.page1.bgcj100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj100
            
            #add-point:AFTER FIELD bgcj100 name="construct.a.page1.bgcj100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj008
            #add-point:BEFORE FIELD bgcj008 name="construct.b.page1.bgcj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj008
            
            #add-point:AFTER FIELD bgcj008 name="construct.a.page1.bgcj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj008
            #add-point:ON ACTION controlp INFIELD bgcj008 name="construct.c.page1.bgcj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj047
            #add-point:BEFORE FIELD bgcj047 name="construct.b.page1.bgcj047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj047
            
            #add-point:AFTER FIELD bgcj047 name="construct.a.page1.bgcj047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj047
            #add-point:ON ACTION controlp INFIELD bgcj047 name="construct.c.page1.bgcj047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj048
            #add-point:BEFORE FIELD bgcj048 name="construct.b.page1.bgcj048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj048
            
            #add-point:AFTER FIELD bgcj048 name="construct.a.page1.bgcj048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj048
            #add-point:ON ACTION controlp INFIELD bgcj048 name="construct.c.page1.bgcj048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj050
            #add-point:BEFORE FIELD bgcj050 name="construct.b.page1.bgcj050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj050
            
            #add-point:AFTER FIELD bgcj050 name="construct.a.page1.bgcj050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcj050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj050
            #add-point:ON ACTION controlp INFIELD bgcj050 name="construct.c.page1.bgcj050"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgcjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjownid
            #add-point:ON ACTION controlp INFIELD bgcjownid name="construct.c.page2.bgcjownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcjownid  #顯示到畫面上
            NEXT FIELD bgcjownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjownid
            #add-point:BEFORE FIELD bgcjownid name="construct.b.page2.bgcjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjownid
            
            #add-point:AFTER FIELD bgcjownid name="construct.a.page2.bgcjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgcjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjowndp
            #add-point:ON ACTION controlp INFIELD bgcjowndp name="construct.c.page2.bgcjowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcjowndp  #顯示到畫面上
            NEXT FIELD bgcjowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjowndp
            #add-point:BEFORE FIELD bgcjowndp name="construct.b.page2.bgcjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjowndp
            
            #add-point:AFTER FIELD bgcjowndp name="construct.a.page2.bgcjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgcjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjcrtid
            #add-point:ON ACTION controlp INFIELD bgcjcrtid name="construct.c.page2.bgcjcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcjcrtid  #顯示到畫面上
            NEXT FIELD bgcjcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjcrtid
            #add-point:BEFORE FIELD bgcjcrtid name="construct.b.page2.bgcjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjcrtid
            
            #add-point:AFTER FIELD bgcjcrtid name="construct.a.page2.bgcjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgcjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjcrtdp
            #add-point:ON ACTION controlp INFIELD bgcjcrtdp name="construct.c.page2.bgcjcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcjcrtdp  #顯示到畫面上
            NEXT FIELD bgcjcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjcrtdp
            #add-point:BEFORE FIELD bgcjcrtdp name="construct.b.page2.bgcjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjcrtdp
            
            #add-point:AFTER FIELD bgcjcrtdp name="construct.a.page2.bgcjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjcrtdt
            #add-point:BEFORE FIELD bgcjcrtdt name="construct.b.page2.bgcjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgcjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjmodid
            #add-point:ON ACTION controlp INFIELD bgcjmodid name="construct.c.page2.bgcjmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcjmodid  #顯示到畫面上
            NEXT FIELD bgcjmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjmodid
            #add-point:BEFORE FIELD bgcjmodid name="construct.b.page2.bgcjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjmodid
            
            #add-point:AFTER FIELD bgcjmodid name="construct.a.page2.bgcjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjmoddt
            #add-point:BEFORE FIELD bgcjmoddt name="construct.b.page2.bgcjmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgcjcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjcnfid
            #add-point:ON ACTION controlp INFIELD bgcjcnfid name="construct.c.page2.bgcjcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcjcnfid  #顯示到畫面上
            NEXT FIELD bgcjcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjcnfid
            #add-point:BEFORE FIELD bgcjcnfid name="construct.b.page2.bgcjcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjcnfid
            
            #add-point:AFTER FIELD bgcjcnfid name="construct.a.page2.bgcjcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjcnfdt
            #add-point:BEFORE FIELD bgcjcnfdt name="construct.b.page2.bgcjcnfdt"
            
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
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"bgcj022_2","bgcj022")
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
 
{<section id="abgt340.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt340_query()
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
   CALL g_bgcj_d.clear()
   CALL g_bgcj2_d.clear()
   CALL g_bgcj3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgt340_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt340_browser_fill(g_wc)
      CALL abgt340_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgt340_browser_fill("F")
   
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
      CALL abgt340_fetch("F") 
   END IF
   
   CALL abgt340_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt340_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_bgcj010_str       STRING
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
   
   #CALL abgt340_browser_fill(p_flag)
   
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
   
   LET g_bgcj_m.bgcj001 = g_browser[g_current_idx].b_bgcj001
   LET g_bgcj_m.bgcj002 = g_browser[g_current_idx].b_bgcj002
   LET g_bgcj_m.bgcj003 = g_browser[g_current_idx].b_bgcj003
   LET g_bgcj_m.bgcj004 = g_browser[g_current_idx].b_bgcj004
   LET g_bgcj_m.bgcj005 = g_browser[g_current_idx].b_bgcj005
   LET g_bgcj_m.bgcj006 = g_browser[g_current_idx].b_bgcj006
   LET g_bgcj_m.bgcj007 = g_browser[g_current_idx].b_bgcj007
   LET g_bgcj_m.bgcj009 = g_browser[g_current_idx].b_bgcj009
   LET g_bgcj_m.bgcj010 = g_browser[g_current_idx].b_bgcj010
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010 INTO g_bgcj_m.bgcj002, 
       g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023, 
       g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj049, 
       g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bgcj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgcj_m_mask_o.* =  g_bgcj_m.*
   CALL abgt340_bgcj_t_mask()
   LET g_bgcj_m_mask_n.* =  g_bgcj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt340_set_act_visible()
   CALL abgt340_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   #重新抓取樣式
   CALL s_abg2_get_bgaw(g_bgcj_m.bgcj011) RETURNING g_bgaw1,g_bgaw2
   #重写单头锁资料sql
   LET g_forupd_sql = " SELECT bgcj002,'',bgcj003,bgcj004,'','','',bgcj011,bgcj001,bgcj005,bgcj006,bgcjstus, 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','',''", 
                      " FROM bgcj_t",
                      " WHERE bgcjent= ? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND  
                          bgcj005=? AND bgcj006=? "
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET g_forupd_sql = g_forupd_sql," AND bgcj007=? "
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET g_forupd_sql = g_forupd_sql," AND bgcj009=? "
   END IF
   
   #将单头核算项组成的组合码转换成查询条件
   LET l_bgcj010_str=g_bgcj_m.bgcj010
   IF cl_null(l_bgcj010_str) THEN
      LET l_bgcj010_str = " 1=1 "
   ELSE
      LET l_bgcj010_str=cl_replace_str(l_bgcj010_str,"=","='")
      LET l_bgcj010_str=cl_replace_str(l_bgcj010_str,"/","' AND ")
      LET l_bgcj010_str=l_bgcj010_str,"' "
   END IF
   LET g_forupd_sql = g_forupd_sql," AND ",l_bgcj010_str
   
   LET g_forupd_sql = g_forupd_sql," FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt340_hcl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   #end add-point
 
   #保存單頭舊值
   LET g_bgcj_m_t.* = g_bgcj_m.*
   LET g_bgcj_m_o.* = g_bgcj_m.*
   
   #重新顯示   
   CALL abgt340_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt340.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt340_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bgcj_d.clear()
   CALL g_bgcj2_d.clear()
   CALL g_bgcj3_d.clear()
 
 
   INITIALIZE g_bgcj_m.* TO NULL             #DEFAULT 設定
   LET g_bgcj001_t = NULL
   LET g_bgcj002_t = NULL
   LET g_bgcj003_t = NULL
   LET g_bgcj004_t = NULL
   LET g_bgcj005_t = NULL
   LET g_bgcj006_t = NULL
   LET g_bgcj007_t = NULL
   LET g_bgcj009_t = NULL
   LET g_bgcj010_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_bgcj_m.bgcj001 = "20"
      LET g_bgcj_m.bgcj005 = "1"
      LET g_bgcj_m.bgcj006 = "1"
      LET g_bgcj_m.bgcjstus = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_bgcj_m_t.* = g_bgcj_m.*
      CALL cl_set_comp_visible("bgcj007,bgcj007_desc_t,bgcj009,bgcj013,bgcj013_desc_t,bgcj014,bgcj014_desc_t,bgcj015,bgcj015_desc_t,bgcj016,bgcj016_desc_t,bgcj017,bgcj017_desc_t,",TRUE)
      CALL cl_set_comp_visible("bgcj018,bgcj018_desc_t,bgcj019,bgcj019_desc_t,bgcj022,bgcj023,bgcj023_desc_t,bgcj024,bgcj024_desc_t,bgcj012,bgcj012_desc_t,bgcj020,bgcj020_desc_tbgcj021,bgcj021_desc_t,group_1",TRUE)
      CASE g_bgcj_m.bgcjstus 
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
 
      CALL abgt340_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
 
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bgcj_m.* TO NULL
         INITIALIZE g_bgcj_d TO NULL
         INITIALIZE g_bgcj2_d TO NULL
         INITIALIZE g_bgcj3_d TO NULL
 
         CALL abgt340_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgcj_m.* = g_bgcj_m_t.*
         CALL abgt340_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bgcj_d.clear()
      #CALL g_bgcj2_d.clear()
      #CALL g_bgcj3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt340_set_act_visible()
   CALL abgt340_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
   LET g_bgcj010_t = g_bgcj_m.bgcj010
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                      " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                      ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                      ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                      ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                      ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                      ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
                      ," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
                      ," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
                      ," AND bgcj010 = '", g_bgcj_m.bgcj010, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgt340_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010 INTO g_bgcj_m.bgcj002, 
       g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023, 
       g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj049, 
       g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc
   
   #遮罩相關處理
   LET g_bgcj_m_mask_o.* =  g_bgcj_m.*
   CALL abgt340_bgcj_t_mask()
   LET g_bgcj_m_mask_n.* =  g_bgcj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgcj_m.bgcj002,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj004_desc, 
       g_bgcj_m.bgaa002,g_bgcj_m.bgaa003,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj007_desc_t,g_bgcj_m.bgcj013, 
       g_bgcj_m.bgcj013_desc_t,g_bgcj_m.bgcj016,g_bgcj_m.bgcj016_desc_t,g_bgcj_m.bgcj019,g_bgcj_m.bgcj019_desc_t, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj014_desc_t,g_bgcj_m.bgcj017,g_bgcj_m.bgcj017_desc_t, 
       g_bgcj_m.bgcj020,g_bgcj_m.bgcj020_desc_t,g_bgcj_m.bgcj023,g_bgcj_m.bgcj023_desc_t,g_bgcj_m.bgcj012, 
       g_bgcj_m.bgcj012_desc_t,g_bgcj_m.bgcj015,g_bgcj_m.bgcj015_desc_t,g_bgcj_m.bgcj018,g_bgcj_m.bgcj018_desc_t, 
       g_bgcj_m.bgcj021,g_bgcj_m.bgcj021_desc_t,g_bgcj_m.bgcj024,g_bgcj_m.bgcj024_desc_t,g_bgcj_m.bgcj049 
 
   
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt340_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #由于主键位置不确定在单头或单身，锁资料SQL不同，需重写
   CALL abgt340_modify_1()
   RETURN
   #end add-point
   
   IF g_bgcj_m.bgcj001 IS NULL
   OR g_bgcj_m.bgcj002 IS NULL
   OR g_bgcj_m.bgcj003 IS NULL
   OR g_bgcj_m.bgcj004 IS NULL
   OR g_bgcj_m.bgcj005 IS NULL
   OR g_bgcj_m.bgcj006 IS NULL
   OR g_bgcj_m.bgcj007 IS NULL
   OR g_bgcj_m.bgcj009 IS NULL
   OR g_bgcj_m.bgcj010 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
   LET g_bgcj010_t = g_bgcj_m.bgcj010
 
   CALL s_transaction_begin()
   
   OPEN abgt340_cl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt340_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010 INTO g_bgcj_m.bgcj002, 
       g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023, 
       g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj049, 
       g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc
   
   #遮罩相關處理
   LET g_bgcj_m_mask_o.* =  g_bgcj_m.*
   CALL abgt340_bgcj_t_mask()
   LET g_bgcj_m_mask_n.* =  g_bgcj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt340_show()
   WHILE TRUE
      LET g_bgcj001_t = g_bgcj_m.bgcj001
      LET g_bgcj002_t = g_bgcj_m.bgcj002
      LET g_bgcj003_t = g_bgcj_m.bgcj003
      LET g_bgcj004_t = g_bgcj_m.bgcj004
      LET g_bgcj005_t = g_bgcj_m.bgcj005
      LET g_bgcj006_t = g_bgcj_m.bgcj006
      LET g_bgcj007_t = g_bgcj_m.bgcj007
      LET g_bgcj009_t = g_bgcj_m.bgcj009
      LET g_bgcj010_t = g_bgcj_m.bgcj010
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgt340_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgcj_m.* = g_bgcj_m_t.*
         CALL abgt340_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgcj_m.bgcj001 != g_bgcj001_t 
      OR g_bgcj_m.bgcj002 != g_bgcj002_t 
      OR g_bgcj_m.bgcj003 != g_bgcj003_t 
      OR g_bgcj_m.bgcj004 != g_bgcj004_t 
      OR g_bgcj_m.bgcj005 != g_bgcj005_t 
      OR g_bgcj_m.bgcj006 != g_bgcj006_t 
      OR g_bgcj_m.bgcj007 != g_bgcj007_t 
      OR g_bgcj_m.bgcj009 != g_bgcj009_t 
      OR g_bgcj_m.bgcj010 != g_bgcj010_t 
 
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
   CALL abgt340_set_act_visible()
   CALL abgt340_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                      " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                      ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                      ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                      ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                      ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                      ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
                      ," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
                      ," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
                      ," AND bgcj010 = '", g_bgcj_m.bgcj010, "' "
 
   #填到對應位置
   CALL abgt340_browser_fill("")
 
   CALL abgt340_idx_chk()
 
   CLOSE abgt340_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt340.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt340_input(p_cmd)
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
   DEFINE l_bgcj007              LIKE bgcj_t.bgcj007
   DEFINE l_bgcj009              LIKE bgcj_t.bgcj009
   DEFINE l_ooef019              LIKE ooef_t.ooef019
   DEFINE l_ooef001              LIKE ooef_t.ooef001
   DEFINE l_ooed005              LIKE ooed_t.ooed005
   DEFINE l_bgea012              LIKE bgea_t.bgea012
   DEFINE l_bgea010              LIKE bgea_t.bgea010
   DEFINE l_bgea011              LIKE bgea_t.bgea011
   DEFINE l_bgea013              LIKE bgea_t.bgea013
   DEFINE l_bgea004              LIKE bgea_t.bgea004
   DEFINE l_bgaa006              LIKE bgaa_t.bgaa006
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
   DISPLAY BY NAME g_bgcj_m.bgcj002,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj004_desc, 
       g_bgcj_m.bgaa002,g_bgcj_m.bgaa003,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj007_desc_t,g_bgcj_m.bgcj013, 
       g_bgcj_m.bgcj013_desc_t,g_bgcj_m.bgcj016,g_bgcj_m.bgcj016_desc_t,g_bgcj_m.bgcj019,g_bgcj_m.bgcj019_desc_t, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj014_desc_t,g_bgcj_m.bgcj017,g_bgcj_m.bgcj017_desc_t, 
       g_bgcj_m.bgcj020,g_bgcj_m.bgcj020_desc_t,g_bgcj_m.bgcj023,g_bgcj_m.bgcj023_desc_t,g_bgcj_m.bgcj012, 
       g_bgcj_m.bgcj012_desc_t,g_bgcj_m.bgcj015,g_bgcj_m.bgcj015_desc_t,g_bgcj_m.bgcj018,g_bgcj_m.bgcj018_desc_t, 
       g_bgcj_m.bgcj021,g_bgcj_m.bgcj021_desc_t,g_bgcj_m.bgcj024,g_bgcj_m.bgcj024_desc_t,g_bgcj_m.bgcj049 
 
   
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
   LET g_forupd_sql = "SELECT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015, 
       bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037, 
       bgcj100,bgcj008,bgcj047,bgcj048,bgcj050,bgcjseq,bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt, 
       bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq FROM bgcj_t WHERE bgcjent=? AND bgcj001=? AND  
       bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=? AND bgcj007=? AND bgcj009=?  
       AND bgcj010=? AND bgcj008=? AND bgcjseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   #重写单身锁资料sql
   #161220-00036#1--mod--str--
#   LET g_forupd_sql = "SELECT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015, 
#       bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037, 
#       bgcj100,bgcj101,0,bgcj047,bgcj048,bgcj050,bgcjseq,bgcjownid,bgcjowndp, 
#       bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq FROM bgcj_t WHERE  
#       bgcjent=? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=?  
#       AND bgcj007=? AND bgcj009=? AND bgcj010=? AND bgcjseq=? FOR UPDATE"
   LET g_forupd_sql = "SELECT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,", 
       "bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037,", 
       "bgcj100,0,bgcj047,bgcj048,bgcj050,bgcjseq,bgcjownid,bgcjowndp,",
       "bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq", 
       "   FROM bgcj_t ", 
       "  WHERE bgcjent=? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=?",
       "    AND bgcj007=? AND bgcj009=? AND bgcj010=? AND bgcjseq=? FOR UPDATE"
   #161220-00036#1--mod--end
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt340_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt340_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt340_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013, 
       g_bgcj_m.bgcj016,g_bgcj_m.bgcj019,g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017, 
       g_bgcj_m.bgcj020,g_bgcj_m.bgcj023,g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021, 
       g_bgcj_m.bgcj024,g_bgcj_m.bgcj049
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   CALL cl_set_combo_scc_part('bgcj005','8952','1,4')
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt340.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001, 
          g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013, 
          g_bgcj_m.bgcj016,g_bgcj_m.bgcj019,g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017, 
          g_bgcj_m.bgcj020,g_bgcj_m.bgcj023,g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021, 
          g_bgcj_m.bgcj024,g_bgcj_m.bgcj049 
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
               CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_m.bgcj007,g_bgcj_m.bgcj049)
            END IF
            #新增时从预算编号开始录入
            IF p_cmd ='a' THEN
               NEXT FIELD bgcj002
            END IF
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="input.a.bgcj002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj002
            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj002_desc
            
            IF NOT cl_null(g_bgcj_m.bgcj002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj002 != g_bgcj002_t)) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgcj_m.bgcj002
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"

                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_bgaa001") THEN
                     #预算编号需是使用预测的（bgaa006=1.使用）
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_bgcj_m.bgcj002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgcj_m.bgcj002 = g_bgcj_m_t.bgcj002
                        CALL s_desc_get_budget_desc(g_bgcj_m.bgcj002) RETURNING g_bgcj_m.bgcj002_desc
                        DISPLAY BY NAME g_bgcj_m.bgcj002_desc
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_bgcj_m.bgcj004) THEN
                        CALL s_abg2_bgai002_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,'01')
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bgcj_m.bgcj002," + ",g_bgcj_m.bgcj004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj002 = g_bgcj_m_t.bgcj002
                           CALL s_desc_get_budget_desc(g_bgcj_m.bgcj002) RETURNING g_bgcj_m.bgcj002_desc
                           DISPLAY BY NAME g_bgcj_m.bgcj002_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bgcj_m.bgcj002 = g_bgcj_m_t.bgcj002
                     CALL s_desc_get_budget_desc(g_bgcj_m.bgcj002) RETURNING g_bgcj_m.bgcj002_desc
                     DISPLAY BY NAME g_bgcj_m.bgcj002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #抓取預算樣表
                  IF NOT cl_null(g_bgcj_m.bgcj004) THEN
                     SELECT DISTINCT bgai008 INTO g_bgcj_m.bgcj011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bgcj_m.bgcj002 AND bgai002=g_bgcj_m.bgcj004
                     CALL s_abg2_get_bgaw(g_bgcj_m.bgcj011) RETURNING g_bgaw1,g_bgaw2
                     #设置核算项显示位置
                     CALL abgt340_set_hsx_visible()
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
                     AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                        OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                   g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgcj_m.bgcj002
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj002 = g_bgcj_m_t.bgcj002
                           CALL s_desc_get_budget_desc(g_bgcj_m.bgcj002) RETURNING g_bgcj_m.bgcj002_desc
                           DISPLAY BY NAME g_bgcj_m.bgcj002_desc
                           #重新抓取樣式
                           SELECT DISTINCT bgai008 INTO g_bgcj_m.bgcj011 FROM bgai_t
                            WHERE bgaient=g_enterprise AND bgai001=g_bgcj_m.bgcj002 AND bgai002=g_bgcj_m.bgcj004
                           CALL s_abg2_get_bgaw(g_bgcj_m.bgcj011) RETURNING g_bgaw1,g_bgaw2
                           #设置核算项显示位置
                           CALL abgt340_set_hsx_visible()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #抓取預算週期和預算期別
                  CALL s_abgt340_sel_bgaa(g_bgcj_m.bgcj002) RETURNING g_bgcj_m.bgaa002,g_bgcj_m.bgaa003,g_max_period
                  DISPLAY BY NAME g_bgcj_m.bgaa002,g_bgcj_m.bgaa003
                  #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
                  IF g_max_period < 13 THEN
                     CALL cl_set_comp_visible("num13,price13,amt13,tnum13,tprice13,tamt13",FALSE)
                  ELSE
                     CALL cl_set_comp_visible("num13,price13,amt13,tnum13,tprice13,tamt13",TRUE)
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="input.b.bgcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj002
            #add-point:ON CHANGE bgcj002 name="input.g.bgcj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="input.b.bgcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="input.a.bgcj003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) AND NOT cl_null(g_bgcj_m.bgcj007) AND NOT cl_null(g_bgcj_m.bgcj009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t  OR g_bgcj_m.bgcj007 != g_bgcj007_t  OR g_bgcj_m.bgcj009 != g_bgcj009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_m.bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_m.bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_m.bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_m.bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_m.bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_m.bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_m.bgcj007 ||"' AND "|| "bgcj009 = '"||g_bgcj_m.bgcj009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            IF NOT cl_null(g_bgcj_m.bgcj003) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj003 != g_bgcj003_t)) THEN
                  #確認欄位值在特定區間內
                  IF NOT cl_ap_chk_range(g_bgcj_m.bgcj003,"0","0","","","azz-00079",1) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #主鍵檢查
            IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
               AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t)  
                                  )
               ) THEN 
                  CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                             g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgcj_m.bgcj003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj003 = g_bgcj_m_t.bgcj003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003
            #add-point:ON CHANGE bgcj003 name="input.g.bgcj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj004
            
            #add-point:AFTER FIELD bgcj004 name="input.a.bgcj004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj002
            LET g_ref_fields[2] = g_bgcj_m.bgcj004
            CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj004_desc

            IF NOT cl_null(g_bgcj_m.bgcj004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj004 != g_bgcj004_t)) THEN
                  CALL s_abg2_bgai002_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,'01')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_m.bgcj004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj004 = g_bgcj_m_t.bgcj004
                     CALL s_desc_get_bgai002_desc(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004) RETURNING g_bgcj_m.bgcj004_desc
                     DISPLAY BY NAME g_bgcj_m.bgcj004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #抓取預算樣表
                  IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                     SELECT DISTINCT bgai008 INTO g_bgcj_m.bgcj011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bgcj_m.bgcj002 AND bgai002=g_bgcj_m.bgcj004
                     CALL s_abg2_get_bgaw(g_bgcj_m.bgcj011) RETURNING g_bgaw1,g_bgaw2
                     #设置核算项显示位置
                     CALL abgt340_set_hsx_visible()
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
                     AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                        OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                   g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgcj_m.bgcj004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj004 = g_bgcj_m_t.bgcj004
                           CALL s_desc_get_bgai002_desc(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004) RETURNING g_bgcj_m.bgcj004_desc
                           DISPLAY BY NAME g_bgcj_m.bgcj004_desc
                           #重新抓取樣式
                           SELECT DISTINCT bgai008 INTO g_bgcj_m.bgcj011 FROM bgai_t
                            WHERE bgaient=g_enterprise AND bgai001=g_bgcj_m.bgcj002 AND bgai002=g_bgcj_m.bgcj004
                           CALL s_abg2_get_bgaw(g_bgcj_m.bgcj011) RETURNING g_bgaw1,g_bgaw2
                           #设置核算项显示位置
                           CALL abgt340_set_hsx_visible()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj004
            #add-point:BEFORE FIELD bgcj004 name="input.b.bgcj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj004
            #add-point:ON CHANGE bgcj004 name="input.g.bgcj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj011
            #add-point:BEFORE FIELD bgcj011 name="input.b.bgcj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj011
            
            #add-point:AFTER FIELD bgcj011 name="input.a.bgcj011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj011
            #add-point:ON CHANGE bgcj011 name="input.g.bgcj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj001
            #add-point:BEFORE FIELD bgcj001 name="input.b.bgcj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj001
            
            #add-point:AFTER FIELD bgcj001 name="input.a.bgcj001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) AND NOT cl_null(g_bgcj_m.bgcj007) AND NOT cl_null(g_bgcj_m.bgcj009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t  OR g_bgcj_m.bgcj007 != g_bgcj007_t  OR g_bgcj_m.bgcj009 != g_bgcj009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_m.bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_m.bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_m.bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_m.bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_m.bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_m.bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_m.bgcj007 ||"' AND "|| "bgcj009 = '"||g_bgcj_m.bgcj009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj001
            #add-point:ON CHANGE bgcj001 name="input.g.bgcj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj005
            #add-point:BEFORE FIELD bgcj005 name="input.b.bgcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj005
            
            #add-point:AFTER FIELD bgcj005 name="input.a.bgcj005"
            #主鍵檢查
            IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
               AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t) 
                                  )
               ) THEN 
                  CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                             g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgcj_m.bgcj005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj005 = g_bgcj_m_t.bgcj005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj005
            #add-point:ON CHANGE bgcj005 name="input.g.bgcj005"
            IF NOT cl_null(g_bgcj_m.bgcj005) THEN
               CALL abgt340_set_bgcj005_text(g_bgcj_m.bgcj005)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj006
            #add-point:BEFORE FIELD bgcj006 name="input.b.bgcj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj006
            
            #add-point:AFTER FIELD bgcj006 name="input.a.bgcj006"
            #主鍵檢查
            IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
               AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t)  
                                  )
               ) THEN 
                  CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                             g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgcj_m.bgcj006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj006 = g_bgcj_m_t.bgcj006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj006
            #add-point:ON CHANGE bgcj006 name="input.g.bgcj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj010
            #add-point:BEFORE FIELD bgcj010 name="input.b.bgcj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj010
            
            #add-point:AFTER FIELD bgcj010 name="input.a.bgcj010"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) AND NOT cl_null(g_bgcj_m.bgcj007) AND NOT cl_null(g_bgcj_m.bgcj009) AND NOT cl_null(g_bgcj_m.bgcj010) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t  OR g_bgcj_m.bgcj007 != g_bgcj007_t  OR g_bgcj_m.bgcj009 != g_bgcj009_t  OR g_bgcj_m.bgcj010 != g_bgcj010_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_m.bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_m.bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_m.bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_m.bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_m.bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_m.bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_m.bgcj007 ||"' AND "|| "bgcj009 = '"||g_bgcj_m.bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_m.bgcj010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj010
            #add-point:ON CHANGE bgcj010 name="input.g.bgcj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjstus
            #add-point:BEFORE FIELD bgcjstus name="input.b.bgcjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjstus
            
            #add-point:AFTER FIELD bgcjstus name="input.a.bgcjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcjstus
            #add-point:ON CHANGE bgcjstus name="input.g.bgcjstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="input.a.bgcj007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj007_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
            
            IF NOT cl_null(g_bgcj_m.bgcj007) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj007 != g_bgcj_m_t.bgcj007 OR cl_null(g_bgcj_m_t.bgcj007))) THEN
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgcj_m.bgcj007
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     #檢查失敗時後續處理
                     LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                     CALL s_desc_get_department_desc(g_bgcj_m.bgcj007) RETURNING g_bgcj_m.bgcj007_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
                     NEXT FIELD CURRENT
                  END IF
                 
                  #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_bgcj_m.bgcj007,'01')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_m.bgcj007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                     CALL s_desc_get_department_desc(g_bgcj_m.bgcj007) RETURNING g_bgcj_m.bgcj007_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #检查预算编号+版本+预算管理组织+销售方式下预算组织或预算上层组织是否已存在汇总资料abgt350，如果存在，不可录入
                  IF NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) AND
                     NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) THEN
                     #预算组织是否存在汇总资料
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                      WHERE bgcjent=g_enterprise AND bgcj001='30'
                        AND bgcj002=g_bgcj_m.bgcj002 AND bgcj003=g_bgcj_m.bgcj003
                        AND bgcj004=g_bgcj_m.bgcj004 AND bgcj005=g_bgcj_m.bgcj005
                        AND bgcj006='2' AND bgcj007 = g_bgcj_m.bgcj007
                        AND bgcjstus<>'X'
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00231'
                        LET g_errparam.extend =g_bgcj_m.bgcj007
                        #161215-00014#1--add--str--
                        LET g_errparam.replace[1] = cl_get_progname('abgt350',g_lang,"2")
                        LET g_errparam.exeprog = 'abgt350'
                        #161215-00014#1--add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                        CALL s_desc_get_department_desc(g_bgcj_m.bgcj007) RETURNING g_bgcj_m.bgcj007_desc_t
                        DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
                        NEXT FIELD CURRENT
                     END IF
                     #预算组织的上层组织是否存在汇总资料
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
                     #抓取上层组织
                     IF NOT cl_null(l_bgaa010) THEN
                        SELECT ooed005 INTO l_ooed005 FROM ooed_t
                          WHERE ooedent=g_enterprise AND ooed001='4'
                            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                            AND ooed004=g_bgcj_m.bgcj007
                        IF NOT cl_null(l_ooed005) THEN
                           LET l_cnt = 0
                           SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                            WHERE bgcjent=g_enterprise AND bgcj001='30'
                              AND bgcj002=g_bgcj_m.bgcj002 AND bgcj003=g_bgcj_m.bgcj003
                              AND bgcj004=g_bgcj_m.bgcj004 AND bgcj005=g_bgcj_m.bgcj005
                              AND bgcj006='2' AND bgcj007 = l_ooed005
                              AND bgcjstus<>'X'
                           IF l_cnt > 0 THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00232'
                              LET g_errparam.extend =g_bgcj_m.bgcj007
                              #161215-00014#1--add--str--
                              LET g_errparam.replace[1] = cl_get_progname('abgt350',g_lang,"2")
                              LET g_errparam.exeprog = 'abgt350'
                              #161215-00014#1--add--end
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                              CALL s_desc_get_department_desc(g_bgcj_m.bgcj007) RETURNING g_bgcj_m.bgcj007_desc_t
                              DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
                     AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                        OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                   g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgcj_m.bgcj007
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #预算料号在单头
                  IF g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009) THEN
                     LET l_bgea011 = ''
                     LET l_bgea004 = ''
                     #销售来源1.外部订单
                     IF g_bgcj_m.bgcj005 = '1' THEN
                        SELECT bgea004,bgea011 INTO l_bgea004,l_bgea011
                          FROM bgea_t
                         WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_m.bgcj009
                           AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_m.bgcj007
                        #161215-00014#1--add--str--
                        #判断是否维护了预算细项，没有维护提示维护
                        IF cl_null(l_bgea004) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abg-00204'
                           LET g_errparam.extend =g_bgcj_m.bgcj007," + ",g_bgcj_m.bgcj009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                           NEXT FIELD CURRENT
                        END IF
                        #161215-00014#1--add--end
                        #预算细项权限检查abgi090
                        CALL s_abg2_bgai006_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,g_bgcj_m.bgcj007,'01',l_bgea004)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend =l_bgea004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                           NEXT FIELD CURRENT
                        END IF
                        LET g_bgcj_m.bgcj049 = l_bgea004
                     END IF
                     
                     #设置单头启用核算项
                     CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_m.bgcj007,g_bgcj_m.bgcj049)
                     
                     IF NOT cl_null(l_bgea011) AND 
                        ((g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_m.bgcj016)) OR 
                         (g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_m.bgcj017))
                        ) THEN
                        #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                        CALL s_abg2_bgap001_chk(l_bgea011,g_bgcj_m.bgcj007)
                        IF cl_null(g_errno) THEN
                           #收付款客商
                           IF g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_m.bgcj016) THEN
                              LET g_bgcj_m.bgcj016 = l_bgea011
                              CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj016) RETURNING g_bgcj_m.bgcj016_desc_t
                              DISPLAY BY NAME g_bgcj_m.bgcj016,g_bgcj_m.bgcj016_desc_t
                           END IF
                           #账款客商
                           IF g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_m.bgcj017) THEN
                              LET g_bgcj_m.bgcj017 = l_bgea011
                              CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj017) RETURNING g_bgcj_m.bgcj017_desc_t
                              DISPLAY BY NAME g_bgcj_m.bgcj017,g_bgcj_m.bgcj017_desc_t
                           END IF
                        END IF
                     END IF
                  END IF
                  
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="input.b.bgcj007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj007
            #add-point:ON CHANGE bgcj007 name="input.g.bgcj007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj013
            
            #add-point:AFTER FIELD bgcj013 name="input.a.bgcj013"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj013
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj013_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj013_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj013) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj013 != g_bgcj_m_t.bgcj013 OR cl_null(g_bgcj_m_t.bgcj013))) THEN
                  #部门基础资料检核
                  CALL s_department_chk(g_bgcj_m.bgcj013,g_today) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_m.bgcj013 = g_bgcj_m_t.bgcj013
                     CALL s_desc_get_department_desc(g_bgcj_m.bgcj013) RETURNING g_bgcj_m.bgcj013_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj013_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bgcj_m.bgcj013,g_bgcj_m.bgcj007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_m.bgcj013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj013 = g_bgcj_m_t.bgcj013
                     CALL s_desc_get_department_desc(g_bgcj_m.bgcj013) RETURNING g_bgcj_m.bgcj013_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj013_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               #抓取部门对应利润中心
               IF g_bgaw1[4]='Y' AND cl_null(g_bgcj_m.bgcj014) AND g_bgal.bgal006 = 'Y' THEN
                  SELECT ooeg004 INTO g_bgcj_m.bgcj014 FROM ooeg_t
                   WHERE ooegent=g_enterprise AND ooeg001=g_bgcj_m.bgcj013
                  CALL s_desc_get_department_desc(g_bgcj_m.bgcj014) RETURNING g_bgcj_m.bgcj014_desc_t
                  DISPLAY BY NAME g_bgcj_m.bgcj014,g_bgcj_m.bgcj014_desc_t
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj013
            #add-point:BEFORE FIELD bgcj013 name="input.b.bgcj013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj013
            #add-point:ON CHANGE bgcj013 name="input.g.bgcj013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016
            
            #add-point:AFTER FIELD bgcj016 name="input.a.bgcj016"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj016
            CALL ap_ref_array2(g_ref_fields,"SELECT bgapl003 FROM bgapl_t WHERE bgaplent="||g_enterprise||" AND bgapl001=? AND bgapl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj016_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj016_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj016) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj016 != g_bgcj_m_t.bgcj016 OR cl_null(g_bgcj_m_t.bgcj016))) THEN
                  CALL s_abg2_bgap001_chk(g_bgcj_m.bgcj016,g_bgcj_m.bgcj007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj016
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj016 = g_bgcj_m_t.bgcj016
                     CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj016) RETURNING g_bgcj_m.bgcj016_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj016_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016
            #add-point:BEFORE FIELD bgcj016 name="input.b.bgcj016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj016
            #add-point:ON CHANGE bgcj016 name="input.g.bgcj016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj019
            
            #add-point:AFTER FIELD bgcj019 name="input.a.bgcj019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj019
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent="||g_enterprise||" AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj019_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj019_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj019) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj019 != g_bgcj_m_t.bgcj019 OR cl_null(g_bgcj_m_t.bgcj019))) THEN
                  CALL s_voucher_glaq024_chk(g_bgcj_m.bgcj019)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj019
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj019 = g_bgcj_m_t.bgcj019
                     CALL s_desc_get_rtaxl003_desc(g_bgcj_m.bgcj019) RETURNING g_bgcj_m.bgcj019_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj019_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj019
            #add-point:BEFORE FIELD bgcj019 name="input.b.bgcj019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj019
            #add-point:ON CHANGE bgcj019 name="input.g.bgcj019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj022
            #add-point:BEFORE FIELD bgcj022 name="input.b.bgcj022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj022
            
            #add-point:AFTER FIELD bgcj022 name="input.a.bgcj022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj022
            #add-point:ON CHANGE bgcj022 name="input.g.bgcj022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009
            #add-point:BEFORE FIELD bgcj009 name="input.b.bgcj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009
            
            #add-point:AFTER FIELD bgcj009 name="input.a.bgcj009"
            #應用 a05 樣板自動產生(Version:3)
            IF NOT cl_null(g_bgcj_m.bgcj009) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj009 != g_bgcj_m_t.bgcj009 OR cl_null(g_bgcj_m_t.bgcj009))) THEN
                  CALL s_abgt340_bgcj009_chk(g_bgcj_m.bgcj005,g_bgcj_m.bgcj009,g_bgcj_m.bgcj002,g_bgcj_m.bgcj007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_m.bgcj009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj009 = g_bgcj_m_t.bgcj009
                     NEXT FIELD CURRENT
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
                     AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                        OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                   g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgcj_m.bgcj009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_m.bgcj009 = g_bgcj_m_t.bgcj009
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               
                  #对应预算细项
                  #销售来源1.外部订单
                  LET l_bgea011 = ''
                  LET l_bgea004 = ''
                  IF g_bgcj_m.bgcj005 = '1' THEN
                     IF NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj007) THEN
                        SELECT bgea004,bgea011 INTO l_bgea004,l_bgea011
                          FROM bgea_t
                         WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_m.bgcj009
                           AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_m.bgcj007
                     END IF
                  END IF
                  #销售来源4.招商收入
                  IF g_bgcj_m.bgcj005 = '4' THEN
                     IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                        SELECT bgce003 INTO l_bgea004 FROM bgce_t
                         WHERE bgceent=g_enterprise AND bgce002=g_bgcj_m.bgcj009
                           AND bgce001=(SELECT bgaa008 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002)
                     END IF
                  END IF
                  #预算细项权限检查abgi090
                  CALL s_abg2_bgai006_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,g_bgcj_m.bgcj007,'01',l_bgea004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =l_bgea004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj009 = g_bgcj_m_t.bgcj009
                     NEXT FIELD CURRENT
                  END IF
                  LET g_bgcj_m.bgcj049 = l_bgea004
                  
                  #设置单头启用核算项
                  CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_m.bgcj007,g_bgcj_m.bgcj049)
                  #收付款客商、账款客商 设置默认值
                  IF NOT cl_null(l_bgea011) AND 
                     ((g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_m.bgcj016)) OR 
                      (g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_m.bgcj017))
                     ) THEN
                     #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                     CALL s_abg2_bgap001_chk(l_bgea011,g_bgcj_m.bgcj007)
                     IF cl_null(g_errno) THEN
                        #收付款客商
                        IF g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_m.bgcj016) THEN
                           LET g_bgcj_m.bgcj016 = l_bgea011
                           CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj016) RETURNING g_bgcj_m.bgcj016_desc_t
                           DISPLAY BY NAME g_bgcj_m.bgcj016,g_bgcj_m.bgcj016_desc_t
                        END IF
                        #账款客商
                        IF g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_m.bgcj017) THEN
                           LET g_bgcj_m.bgcj017 = l_bgea011
                           CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj017) RETURNING g_bgcj_m.bgcj017_desc_t
                           DISPLAY BY NAME g_bgcj_m.bgcj017,g_bgcj_m.bgcj017_desc_t
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj009
            #add-point:ON CHANGE bgcj009 name="input.g.bgcj009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj014
            
            #add-point:AFTER FIELD bgcj014 name="input.a.bgcj014"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj014
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? ","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj014_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj014_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj014) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj014 != g_bgcj_m_t.bgcj014 OR cl_null(g_bgcj_m_t.bgcj014))) THEN
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bgcj_m.bgcj014,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj014
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj014 = g_bgcj_m_t.bgcj014
                     CALL s_desc_get_department_desc(g_bgcj_m.bgcj014) RETURNING g_bgcj_m.bgcj014_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj014_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bgcj_m.bgcj014,g_bgcj_m.bgcj007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_m.bgcj014
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj014 = g_bgcj_m_t.bgcj014
                     CALL s_desc_get_department_desc(g_bgcj_m.bgcj014) RETURNING g_bgcj_m.bgcj014_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj014_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj014
            #add-point:BEFORE FIELD bgcj014 name="input.b.bgcj014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj014
            #add-point:ON CHANGE bgcj014 name="input.g.bgcj014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj017
            
            #add-point:AFTER FIELD bgcj017 name="input.a.bgcj017"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj017
            CALL ap_ref_array2(g_ref_fields,"SELECT bgapl003 FROM bgapl_t WHERE bgaplent="||g_enterprise||" AND bgapl001=? AND bgapl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj017_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj017_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj017) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj017 != g_bgcj_m_t.bgcj017 OR cl_null(g_bgcj_m_t.bgcj017))) THEN
                  CALL s_abg2_bgap001_chk(g_bgcj_m.bgcj017,g_bgcj_m.bgcj007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj017
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj017 = g_bgcj_m_t.bgcj017
                     CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj017) RETURNING g_bgcj_m.bgcj017_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj017_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj017
            #add-point:BEFORE FIELD bgcj017 name="input.b.bgcj017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj017
            #add-point:ON CHANGE bgcj017 name="input.g.bgcj017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj020
            
            #add-point:AFTER FIELD bgcj020 name="input.a.bgcj020"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj020
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent="||g_enterprise||" AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj020_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj020_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj020) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj020 != g_bgcj_m_t.bgcj020 OR cl_null(g_bgcj_m_t.bgcj020))) THEN
                  CALL s_aap_project_chk(g_bgcj_m.bgcj020) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj020
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj020 = g_bgcj_m_t.bgcj020
                     CALL s_desc_get_oojdl003_desc(g_bgcj_m.bgcj020) RETURNING g_bgcj_m.bgcj020_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj020_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj020
            #add-point:BEFORE FIELD bgcj020 name="input.b.bgcj020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj020
            #add-point:ON CHANGE bgcj020 name="input.g.bgcj020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj023
            
            #add-point:AFTER FIELD bgcj023 name="input.a.bgcj023"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj023
            CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent="||g_enterprise||" AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj023_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj023_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj023) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj023 != g_bgcj_m_t.bgcj023 OR cl_null(g_bgcj_m_t.bgcj023))) THEN
                  CALL s_voucher_glaq052_chk(g_bgcj_m.bgcj023) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj023
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj023 = g_bgcj_m_t.bgcj023
                     CALL s_desc_get_oojdl003_desc(g_bgcj_m.bgcj023) RETURNING g_bgcj_m.bgcj023_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj023_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj023
            #add-point:BEFORE FIELD bgcj023 name="input.b.bgcj023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj023
            #add-point:ON CHANGE bgcj023 name="input.g.bgcj023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj012
            
            #add-point:AFTER FIELD bgcj012 name="input.a.bgcj012"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent="||g_enterprise||" AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj012_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj012_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj012) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj012 != g_bgcj_m_t.bgcj012 OR cl_null(g_bgcj_m_t.bgcj012))) THEN
                  #员工基础资料检查
                  CALL s_employee_chk(g_bgcj_m.bgcj012) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_m.bgcj012 = g_bgcj_m_t.bgcj012
                     CALL s_desc_get_person_desc(g_bgcj_m.bgcj012) RETURNING g_bgcj_m.bgcj012_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj012_desc_t
                     NEXT FIELD CURRENT
                  END IF
#161220-00036#1--mark--str--                  
#                  #当预算组织在单身，人员在单头时，人员归属据点归属法人必须等于g_site归属法人
#                  #其他情况，人员归属据点归属法人必须等于预算组织归属法人
#                  CALL s_abgt340_comp_chk(1,g_bgcj_m.bgcj012,g_bgcj_m.bgcj007)                  
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend =g_bgcj_m.bgcj012
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_bgcj_m.bgcj012 = g_bgcj_m_t.bgcj012
#                     CALL s_desc_get_person_desc(g_bgcj_m.bgcj012) RETURNING g_bgcj_m.bgcj012_desc_t
#                     DISPLAY BY NAME g_bgcj_m.bgcj012_desc_t
#                     NEXT FIELD CURRENT
#                  END IF
#161220-00036#1--mark--end
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj012
            #add-point:BEFORE FIELD bgcj012 name="input.b.bgcj012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj012
            #add-point:ON CHANGE bgcj012 name="input.g.bgcj012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj015
            
            #add-point:AFTER FIELD bgcj015 name="input.a.bgcj015"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj015
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj015_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj015_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj015) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj015 != g_bgcj_m_t.bgcj015 OR cl_null(g_bgcj_m_t.bgcj015))) THEN
                  CALL s_azzi650_chk_exist('287',g_bgcj_m.bgcj015) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_m.bgcj015 = g_bgcj_m_t.bgcj015
                     CALL s_desc_get_acc_desc('287',g_bgcj_m.bgcj015) RETURNING g_bgcj_m.bgcj015_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj015_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj015
            #add-point:BEFORE FIELD bgcj015 name="input.b.bgcj015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj015
            #add-point:ON CHANGE bgcj015 name="input.g.bgcj015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj018
            
            #add-point:AFTER FIELD bgcj018 name="input.a.bgcj018"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='281' AND oocql002=? AND oocql003=? ","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj018_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj018_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj018) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj018 != g_bgcj_m_t.bgcj018 OR cl_null(g_bgcj_m_t.bgcj018))) THEN
                  CALL s_azzi650_chk_exist('281',g_bgcj_m.bgcj018) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_m.bgcj018 = g_bgcj_m_t.bgcj018
                     CALL s_desc_get_acc_desc('281',g_bgcj_m.bgcj018) RETURNING g_bgcj_m.bgcj018_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj018_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj018
            #add-point:BEFORE FIELD bgcj018 name="input.b.bgcj018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj018
            #add-point:ON CHANGE bgcj018 name="input.g.bgcj018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj021
            
            #add-point:AFTER FIELD bgcj021 name="input.a.bgcj021"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj020
            LET g_ref_fields[2] = g_bgcj_m.bgcj021
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent="||g_enterprise||" AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj021_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj021_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj021 != g_bgcj_m_t.bgcj021 OR cl_null(g_bgcj_m_t.bgcj021))) THEN
                  CALL s_voucher_glaq028_chk(g_bgcj_m.bgcj020,g_bgcj_m.bgcj021)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_m.bgcj021
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_m.bgcj021 = g_bgcj_m_t.bgcj021
                     CALL s_desc_get_wbs_desc(g_bgcj_m.bgcj020,g_bgcj_m.bgcj021) RETURNING g_bgcj_m.bgcj021_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj021_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj021
            #add-point:BEFORE FIELD bgcj021 name="input.b.bgcj021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj021
            #add-point:ON CHANGE bgcj021 name="input.g.bgcj021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj024
            
            #add-point:AFTER FIELD bgcj024 name="input.a.bgcj024"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_m.bgcj024
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_m.bgcj024_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_m.bgcj024_desc_t
            IF NOT cl_null(g_bgcj_m.bgcj024) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgcj_m.bgcj024 != g_bgcj_m_t.bgcj024 OR cl_null(g_bgcj_m_t.bgcj024))) THEN
                  CALL s_azzi650_chk_exist('2002',g_bgcj_m.bgcj024) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_m.bgcj024 = g_bgcj_m_t.bgcj024
                     CALL s_desc_get_acc_desc('2002',g_bgcj_m.bgcj024) RETURNING g_bgcj_m.bgcj024_desc_t
                     DISPLAY BY NAME g_bgcj_m.bgcj024_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj024
            #add-point:BEFORE FIELD bgcj024 name="input.b.bgcj024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj024
            #add-point:ON CHANGE bgcj024 name="input.g.bgcj024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj049
            #add-point:BEFORE FIELD bgcj049 name="input.b.bgcj049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj049
            
            #add-point:AFTER FIELD bgcj049 name="input.a.bgcj049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj049
            #add-point:ON CHANGE bgcj049 name="input.g.bgcj049"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="input.c.bgcj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaa006 = '1' "
 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj002 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj002 TO bgcj002              #

            NEXT FIELD bgcj002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="input.c.bgcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj004
            #add-point:ON ACTION controlp INFIELD bgcj004 name="input.c.bgcj004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='01' OR bgai005='00')" 
            IF NOT cl_null(g_bgcj_m.bgcj002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_bgcj_m.bgcj002,"' "
            END IF
 
            CALL q_bgai002()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj004 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj004 TO bgcj004              #

            NEXT FIELD bgcj004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj011
            #add-point:ON ACTION controlp INFIELD bgcj011 name="input.c.bgcj011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaw001()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj011 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj011 TO bgcj011              #

            NEXT FIELD bgcj011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj001
            #add-point:ON ACTION controlp INFIELD bgcj001 name="input.c.bgcj001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj005
            #add-point:ON ACTION controlp INFIELD bgcj005 name="input.c.bgcj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj006
            #add-point:ON ACTION controlp INFIELD bgcj006 name="input.c.bgcj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj010
            #add-point:ON ACTION controlp INFIELD bgcj010 name="input.c.bgcj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjstus
            #add-point:ON ACTION controlp INFIELD bgcjstus name="input.c.bgcjstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="input.c.bgcj007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj007             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef205 = 'Y'"
#            #1.抓取預算組織對應最上層組織及版本
#            IF NOT cl_null(g_bgcj_m.bgcj002) THEN
#               SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
#                WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
#               #根據預算最上層組織+版本抓取有權限據點
#               CALL s_abg2_get_site_role('4','',g_user,g_dept,'',l_bgaa011,l_bgaa010)
#               #有權限組織組成字串用,分開
#               CALL s_abg2_get_budget_sons_str()RETURNING l_origin_str 
#               CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
#               LET g_qryparam.where = " ooef001 IN ",l_origin_str 
#            END IF
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,'01') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj007 = g_qryparam.return1              
            #LET g_bgcj_m.ooef001 = g_qryparam.return2 
            DISPLAY g_bgcj_m.bgcj007 TO bgcj007              #
            #DISPLAY g_bgcj_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD bgcj007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj013
            #add-point:ON ACTION controlp INFIELD bgcj013 name="input.c.bgcj013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
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
 
            LET g_bgcj_m.bgcj013 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj013 TO bgcj013              #

            NEXT FIELD bgcj013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016
            #add-point:ON ACTION controlp INFIELD bgcj016 name="input.c.bgcj016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            #当预算组织在单头
            IF g_bgaw1[1]='Y'  THEN
               LET l_bgcj007 = g_bgcj_m.bgcj007
            ELSE
               LET l_bgcj007 = g_site
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgcj007,"')"
            CALL q_bgap001()                             #呼叫開窗
 
            LET g_bgcj_m.bgcj016 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj016 TO bgcj016              #

            NEXT FIELD bgcj016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj019
            #add-point:ON ACTION controlp INFIELD bgcj019 name="input.c.bgcj019"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj019 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj019 TO bgcj019              #

            NEXT FIELD bgcj019                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj022
            #add-point:ON ACTION controlp INFIELD bgcj022 name="input.c.bgcj022"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009
            #add-point:ON ACTION controlp INFIELD bgcj009 name="input.c.bgcj009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #销售方式1.外部订单
            IF g_bgcj_m.bgcj005 = '1' THEN
               LET g_qryparam.where = " bgas001 IN (SELECT bgea003 FROM bgea_t ",
                                      "              WHERE bgeaent=",g_enterprise," AND bgeastus='Y' "
               IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND bgea001='",g_bgcj_m.bgcj002,"' "
               END IF
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET g_qryparam.where = g_qryparam.where," AND bgea002='",g_bgcj_m.bgcj007,"' "
               END IF
               LET g_qryparam.where = g_qryparam.where," )"
               CALL q_bgas001() 
               LET g_bgcj_m.bgcj009 = g_qryparam.return1              
            END IF
            #销售方式4.招商收入
            IF g_bgcj_m.bgcj005 = '4' THEN
               IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                  SELECT bgaa008 INTO g_bgaa008 FROM bgaa_t 
                   WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002 AND bgaastus='Y'
                  LET g_qryparam.where = " bgcc001 IN (SELECT bgce002 FROM bgce_t ",
                                         "              WHERE bgceent=",g_enterprise,
                                         "                AND bgce001='",g_bgaa008,"'",
                                         "                AND bgcestus='Y' )"
               END IF
               CALL q_bgcc001() 
               LET g_bgcj_m.bgcj009 = g_qryparam.return1              
            END IF
            
            DISPLAY g_bgcj_m.bgcj009 TO bgcj009              #

            NEXT FIELD bgcj009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj014
            #add-point:ON ACTION controlp INFIELD bgcj014 name="input.c.bgcj014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
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
 
            LET g_bgcj_m.bgcj014 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj014 TO bgcj014              #

            NEXT FIELD bgcj014                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj017
            #add-point:ON ACTION controlp INFIELD bgcj017 name="input.c.bgcj017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            #当预算组织在单头
            IF g_bgaw1[1]='Y' THEN
               LET l_bgcj007 = g_bgcj_m.bgcj007
            ELSE
               LET l_bgcj007 = g_site
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgcj007,"')"
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj017 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj017 TO bgcj017              #

            NEXT FIELD bgcj017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj020
            #add-point:ON ACTION controlp INFIELD bgcj020 name="input.c.bgcj020"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj020 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj020 TO bgcj020              #

            NEXT FIELD bgcj020                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj023
            #add-point:ON ACTION controlp INFIELD bgcj023 name="input.c.bgcj023"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj023 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj023 TO bgcj023              #

            NEXT FIELD bgcj023                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj012
            #add-point:ON ACTION controlp INFIELD bgcj012 name="input.c.bgcj012"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
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
 
            LET g_bgcj_m.bgcj012 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj012 TO bgcj012              #

            NEXT FIELD bgcj012                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj015
            #add-point:ON ACTION controlp INFIELD bgcj015 name="input.c.bgcj015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj015             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj015 = g_qryparam.return1              
            #LET g_bgcj_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_m.bgcj015 TO bgcj015              #
            #DISPLAY g_bgcj_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj018
            #add-point:ON ACTION controlp INFIELD bgcj018 name="input.c.bgcj018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj018             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj018 = g_qryparam.return1              
            #LET g_bgcj_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_m.bgcj018 TO bgcj018              #
            #DISPLAY g_bgcj_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj021
            #add-point:ON ACTION controlp INFIELD bgcj021 name="input.c.bgcj021"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            IF NOT cl_null(g_bgcj_m.bgcj020) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bgcj_m.bgcj020,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj021 = g_qryparam.return1              

            DISPLAY g_bgcj_m.bgcj021 TO bgcj021              #

            NEXT FIELD bgcj021                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj024
            #add-point:ON ACTION controlp INFIELD bgcj024 name="input.c.bgcj024"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_m.bgcj024             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgcj_m.bgcj024 = g_qryparam.return1              
            #LET g_bgcj_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_m.bgcj024 TO bgcj024              #
            #DISPLAY g_bgcj_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj024                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj049
            #add-point:ON ACTION controlp INFIELD bgcj049 name="input.c.bgcj049"
            
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
            DISPLAY BY NAME g_bgcj_m.bgcj001             
                            ,g_bgcj_m.bgcj002   
                            ,g_bgcj_m.bgcj003   
                            ,g_bgcj_m.bgcj004   
                            ,g_bgcj_m.bgcj005   
                            ,g_bgcj_m.bgcj006   
                            ,g_bgcj_m.bgcj007   
                            ,g_bgcj_m.bgcj009   
                            ,g_bgcj_m.bgcj010   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_m.bgcj007,g_bgcj_m.bgcj049)
            #预算组织检核
            IF g_bgaw1[1]='Y' THEN
               #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
               #2.檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_bgcj_m.bgcj007,'01')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_bgcj_m.bgcj007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_m.bgcj007 = g_bgcj_m_t.bgcj007
                  CALL s_desc_get_department_desc(g_bgcj_m.bgcj007) RETURNING g_bgcj_m.bgcj007_desc_t
                  DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
                  NEXT FIELD bgcj007
               END IF
            END IF
             
            #预算料号检核
            IF g_bgaw1[2]='Y' THEN 
               CALL s_abgt340_bgcj009_chk(g_bgcj_m.bgcj005,g_bgcj_m.bgcj009,g_bgcj_m.bgcj002,g_bgcj_m.bgcj007)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_bgcj_m.bgcj009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_m.bgcj009 = g_bgcj_m_t.bgcj009
                  NEXT FIELD bgcj009
               END IF
            END IF
            
            #主鍵檢查
            IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
               AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t)  
                                  )
               ) THEN 
                  CALL s_abgt340_head_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                             g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgcj002
                  END IF
               END IF
            END IF
            
         IF 1=2 THEN
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgt340_bgcj_t_mask_restore('restore_mask_o')
            
               UPDATE bgcj_t SET (bgcj002,bgcj003,bgcj004,bgcj011,bgcj001,bgcj005,bgcj006,bgcj010,bgcjstus, 
                   bgcj007,bgcj013,bgcj016,bgcj019,bgcj022,bgcj009,bgcj014,bgcj017,bgcj020,bgcj023,bgcj012, 
                   bgcj015,bgcj018,bgcj021,bgcj024,bgcj049) = (g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
                   g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj010, 
                   g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019, 
                   g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020, 
                   g_bgcj_m.bgcj023,g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021, 
                   g_bgcj_m.bgcj024,g_bgcj_m.bgcj049)
                WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj001_t
                  AND bgcj002 = g_bgcj002_t
                  AND bgcj003 = g_bgcj003_t
                  AND bgcj004 = g_bgcj004_t
                  AND bgcj005 = g_bgcj005_t
                  AND bgcj006 = g_bgcj006_t
                  AND bgcj007 = g_bgcj007_t
                  AND bgcj009 = g_bgcj009_t
                  AND bgcj010 = g_bgcj010_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcj_m.bgcj001
               LET gs_keys_bak[1] = g_bgcj001_t
               LET gs_keys[2] = g_bgcj_m.bgcj002
               LET gs_keys_bak[2] = g_bgcj002_t
               LET gs_keys[3] = g_bgcj_m.bgcj003
               LET gs_keys_bak[3] = g_bgcj003_t
               LET gs_keys[4] = g_bgcj_m.bgcj004
               LET gs_keys_bak[4] = g_bgcj004_t
               LET gs_keys[5] = g_bgcj_m.bgcj005
               LET gs_keys_bak[5] = g_bgcj005_t
               LET gs_keys[6] = g_bgcj_m.bgcj006
               LET gs_keys_bak[6] = g_bgcj006_t
               LET gs_keys[7] = g_bgcj_m.bgcj007
               LET gs_keys_bak[7] = g_bgcj007_t
               LET gs_keys[8] = g_bgcj_m.bgcj009
               LET gs_keys_bak[8] = g_bgcj009_t
               LET gs_keys[9] = g_bgcj_m.bgcj010
               LET gs_keys_bak[9] = g_bgcj010_t
               LET gs_keys[10] = g_bgcj_d[g_detail_idx].bgcj008
               LET gs_keys_bak[10] = g_bgcj_d_t.bgcj008
               LET gs_keys[11] = g_bgcj_d[g_detail_idx].bgcjseq
               LET gs_keys_bak[11] = g_bgcj_d_t.bgcjseq
               CALL abgt340_update_b('bgcj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bgcj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bgcj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgt340_bgcj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
            END IF
         END IF
         
            IF p_cmd = 'u' THEN
               #將遮罩欄位還原
               CALL abgt340_bgcj_t_mask_restore('restore_mask_o')
               
               #重写更新单头资料UPDATE
               LET l_success = TRUE
               CALL abgt340_update_head() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  INITIALIZE gs_keys TO NULL 
                  LET gs_keys[1] = g_bgcj_m.bgcj001
                  LET gs_keys_bak[1] = g_bgcj001_t
                  LET gs_keys[2] = g_bgcj_m.bgcj002
                  LET gs_keys_bak[2] = g_bgcj002_t
                  LET gs_keys[3] = g_bgcj_m.bgcj003
                  LET gs_keys_bak[3] = g_bgcj003_t
                  LET gs_keys[4] = g_bgcj_m.bgcj004
                  LET gs_keys_bak[4] = g_bgcj004_t
                  LET gs_keys[5] = g_bgcj_m.bgcj005
                  LET gs_keys_bak[5] = g_bgcj005_t
                  LET gs_keys[6] = g_bgcj_m.bgcj006
                  LET gs_keys_bak[6] = g_bgcj006_t
                  LET gs_keys[7] = g_bgcj_m.bgcj007
                  LET gs_keys_bak[7] = g_bgcj007_t
                  LET gs_keys[8] = g_bgcj_m.bgcj009
                  LET gs_keys_bak[8] = g_bgcj009_t
                  LET gs_keys[9] = g_bgcj_d[g_detail_idx].bgcj008
                  LET gs_keys_bak[9] = g_bgcj_d_t.bgcj008
                  LET gs_keys[10] = g_bgcj_d[g_detail_idx].bgcj010
                  LET gs_keys_bak[10] = g_bgcj_d_t.bgcj010
                  LET gs_keys[11] = g_bgcj_d[g_detail_idx].bgcjseq
                  LET gs_keys_bak[11] = g_bgcj_d_t.bgcjseq
                  CALL abgt340_update_b('bgcj_t',gs_keys,gs_keys_bak,"'1'")
                  CALL s_transaction_end('Y','0')
               END IF
               #將遮罩欄位進行遮蔽
               CALL abgt340_bgcj_t_mask_restore('restore_mask_n')
            ELSE 
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgt340_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bgcj001_t = g_bgcj_m.bgcj001
           LET g_bgcj002_t = g_bgcj_m.bgcj002
           LET g_bgcj003_t = g_bgcj_m.bgcj003
           LET g_bgcj004_t = g_bgcj_m.bgcj004
           LET g_bgcj005_t = g_bgcj_m.bgcj005
           LET g_bgcj006_t = g_bgcj_m.bgcj006
           LET g_bgcj007_t = g_bgcj_m.bgcj007
           LET g_bgcj009_t = g_bgcj_m.bgcj009
           LET g_bgcj010_t = g_bgcj_m.bgcj010
 
           
           IF g_bgcj_d.getLength() = 0 THEN
              NEXT FIELD bgcj008
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgt340.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgcj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgcj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt340_b_fill(g_wc2) #test 
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
            CALL abgt340_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgt340_cl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgt340_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt340_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgcj_d[l_ac].bgcj008 IS NOT NULL
               AND g_bgcj_d[l_ac].bgcjseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgcj_d_t.* = g_bgcj_d[l_ac].*  #BACKUP
               LET g_bgcj_d_o.* = g_bgcj_d[l_ac].*  #BACKUP
               CALL abgt340_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgt340_set_no_entry_b(l_cmd)
               OPEN abgt340_bcl USING g_enterprise,g_bgcj_m.bgcj001,
                                                g_bgcj_m.bgcj002,
                                                g_bgcj_m.bgcj003,
                                                g_bgcj_m.bgcj004,
                                                g_bgcj_m.bgcj005,
                                                g_bgcj_m.bgcj006,
                                                g_bgcj_m.bgcj007,
                                                g_bgcj_m.bgcj009,
                                                g_bgcj_m.bgcj010,
 
                                                g_bgcj_d_t.bgcj008
                                                ,g_bgcj_d_t.bgcjseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt340_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt340_bcl INTO g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010,g_bgcj_d[l_ac].bgcj007, 
                      g_bgcj_d[l_ac].bgcj009,g_bgcj_d[l_ac].bgcj049,g_bgcj_d[l_ac].bgcj012,g_bgcj_d[l_ac].bgcj013, 
                      g_bgcj_d[l_ac].bgcj014,g_bgcj_d[l_ac].bgcj015,g_bgcj_d[l_ac].bgcj016,g_bgcj_d[l_ac].bgcj017, 
                      g_bgcj_d[l_ac].bgcj018,g_bgcj_d[l_ac].bgcj019,g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021, 
                      g_bgcj_d[l_ac].bgcj022,g_bgcj_d[l_ac].bgcj023,g_bgcj_d[l_ac].bgcj024,g_bgcj_d[l_ac].bgcj035, 
                      g_bgcj_d[l_ac].bgcj036,g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj008, 
                      g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048,g_bgcj_d[l_ac].bgcj050,g_bgcj2_d[l_ac].bgcjseq, 
                      g_bgcj2_d[l_ac].bgcjownid,g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid, 
                      g_bgcj2_d[l_ac].bgcjcrtdp,g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid, 
                      g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt, 
                      g_bgcj3_d[l_ac].bgcjseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgcj_d_t.bgcj008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgcj_d_mask_o[l_ac].* =  g_bgcj_d[l_ac].*
                  CALL abgt340_bgcj_t_mask()
                  LET g_bgcj_d_mask_n[l_ac].* =  g_bgcj_d[l_ac].*
                  
                  CALL abgt340_ref_show()
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
            CALL abgt340_idx_chk()
            
            
            CALL s_transaction_begin()
            
            
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               
               CASE
                  #预算组织在单头 AND #预算料号在单头
                  WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
                     OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
                         g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009
                  #预算组织在单头 AND #预算料号在单身
                  WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
                     OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
                         g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007
                  #预算组织在单身 AND #预算料号在单头
                  WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
                     OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
                         g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj009
                  #预算组织在单身 AND #预算料号在单身
                  WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
                     OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
                         g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006
               END CASE
               #当错写为-404 表示没有定义锁单头abgt340_hcl 这中情况出现在，打开作业直接点新增，没有走fetch       
               IF STATUS = '-404' THEN
                  #重写单头锁资料sql
                  LET g_sql = " SELECT bgcj002,'',bgcj003,bgcj004,'','','',bgcj011,bgcj001,bgcj005,bgcj006,bgcjstus, 
                      '','','','','','','','','','','','','','','','','','','','','','','','','','','','',''", 
                                     " FROM bgcj_t",
                                     " WHERE bgcjent= ? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND  
                                         bgcj005=? AND bgcj006=? "
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     LET g_sql = g_sql," AND bgcj007='",g_bgcj_m.bgcj007,"' "
                  END IF
                  #预算料号在单头
                  IF g_bgaw1[2] = 'Y' THEN
                     LET g_sql = g_sql," AND bgcj009='",g_bgcj_m.bgcj009,"' "
                  END IF
                  LET g_sql = g_sql,"FOR UPDATE"
                  
                  LET g_sql = cl_sql_forupd(g_sql)                #轉換不同資料庫語法
                  LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
                  DECLARE abgt340_hcl2 CURSOR FROM g_sql                 # LOCK CURSOR
                  OPEN abgt340_hcl2 USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
                                          g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006
                  IF STATUS THEN 
                     CLOSE abgt340_hcl2
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN abgt340_hcl2:" 
                     LET g_errparam.code   = STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     RETURN
                  END IF
               ELSE
                  IF STATUS THEN 
                     CLOSE abgt340_hcl
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN abgt340_hcl:" 
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
               AND g_bgcj_d[l_ac].bgcj008 IS NOT NULL
               AND g_bgcj_d[l_ac].bgcj010 IS NOT NULL
               AND g_bgcj_d[l_ac].bgcjseq IS NOT NULL
               AND ((g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 IS NOT NULL) OR (g_bgaw2[1]='Y' AND g_bgcj_d[l_ac].bgcj007 IS NOT NULL))
               AND ((g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 IS NOT NULL) OR (g_bgaw2[2]='Y' AND g_bgcj_d[l_ac].bgcj009 IS NOT NULL))
            THEN
               LET l_cmd='u'
               LET g_bgcj_d_t.* = g_bgcj_d[l_ac].*  #BACKUP
               LET g_bgcj_d_o.* = g_bgcj_d[l_ac].*  #BACKUP
               CALL abgt340_set_entry_b(l_cmd)
               CALL abgt340_set_no_entry_b(l_cmd)
               
               #预算组织在单头
               IF g_bgaw1[1] = 'Y' THEN
                  LET l_bgcj007 = g_bgcj_m.bgcj007
               ELSE
                  LET l_bgcj007 = g_bgcj_d_t.bgcj007
               END IF
               
               #预算料号在单头
               IF g_bgaw1[2] = 'Y' THEN
                  LET l_bgcj009 = g_bgcj_m.bgcj009
               ELSE
                  LET l_bgcj009 = g_bgcj_d_t.bgcj009
               END IF
            
               OPEN abgt340_bcl USING g_enterprise,g_bgcj_m.bgcj001,
                                                g_bgcj_m.bgcj002,
                                                g_bgcj_m.bgcj003,
                                                g_bgcj_m.bgcj004,
                                                g_bgcj_m.bgcj005,
                                                g_bgcj_m.bgcj006,
                                                l_bgcj007,
                                                l_bgcj009,
                                                g_bgcj_d_t.bgcj010,
                                                g_bgcj_d_t.bgcjseq
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt340_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt340_bcl INTO g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010,g_bgcj_d[l_ac].bgcj007, 
                      g_bgcj_d[l_ac].bgcj009,g_bgcj_d[l_ac].bgcj049,g_bgcj_d[l_ac].bgcj012,g_bgcj_d[l_ac].bgcj013, 
                      g_bgcj_d[l_ac].bgcj014,g_bgcj_d[l_ac].bgcj015,g_bgcj_d[l_ac].bgcj016,g_bgcj_d[l_ac].bgcj017, 
                      g_bgcj_d[l_ac].bgcj018,g_bgcj_d[l_ac].bgcj019,g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021, 
                      g_bgcj_d[l_ac].bgcj022,g_bgcj_d[l_ac].bgcj023,g_bgcj_d[l_ac].bgcj024,g_bgcj_d[l_ac].bgcj035, 
                      g_bgcj_d[l_ac].bgcj036,g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100,#g_bgcj_d[l_ac].bgcj101, #161220-00036#1 mark bgcj101 
                      g_bgcj_d[l_ac].bgcj008,g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048,g_bgcj_d[l_ac].bgcj050,
                      g_bgcj2_d[l_ac].bgcjseq,g_bgcj2_d[l_ac].bgcjownid,g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid, 
                      g_bgcj2_d[l_ac].bgcjcrtdp,g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid, 
                      g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt, 
                      g_bgcj3_d[l_ac].bgcjseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgcj_d_t.bgcj008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgcj_d_mask_o[l_ac].* =  g_bgcj_d[l_ac].*
                  CALL abgt340_bgcj_t_mask()
                  LET g_bgcj_d_mask_n[l_ac].* =  g_bgcj_d[l_ac].*
                  
                  CALL abgt340_ref_show()
                  CALL cl_show_fld_cont()
                  
                  #设置单头启用核算项
                  CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj049)
                  #设置单身启用核算项
                  CALL abgt340_set_detail_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj049)
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            #end add-point  
            
 
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bgcj_d_t.* TO NULL
            INITIALIZE g_bgcj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgcj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgcj2_d[l_ac].bgcjownid = g_user
      LET g_bgcj2_d[l_ac].bgcjowndp = g_dept
      LET g_bgcj2_d[l_ac].bgcjcrtid = g_user
      LET g_bgcj2_d[l_ac].bgcjcrtdp = g_dept 
      LET g_bgcj2_d[l_ac].bgcjcrtdt = cl_get_current()
      LET g_bgcj2_d[l_ac].bgcjmodid = g_user
      LET g_bgcj2_d[l_ac].bgcjmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_bgcj_d[l_ac].num1 = "0"
      LET g_bgcj_d[l_ac].price1 = "0"
      LET g_bgcj_d[l_ac].amt1 = "0"
      LET g_bgcj_d[l_ac].num2 = "0"
      LET g_bgcj_d[l_ac].price2 = "0"
      LET g_bgcj_d[l_ac].amt2 = "0"
      LET g_bgcj_d[l_ac].num3 = "0"
      LET g_bgcj_d[l_ac].price3 = "0"
      LET g_bgcj_d[l_ac].amt3 = "0"
      LET g_bgcj_d[l_ac].num4 = "0"
      LET g_bgcj_d[l_ac].price4 = "0"
      LET g_bgcj_d[l_ac].amt4 = "0"
      LET g_bgcj_d[l_ac].num5 = "0"
      LET g_bgcj_d[l_ac].price5 = "0"
      LET g_bgcj_d[l_ac].amt5 = "0"
      LET g_bgcj_d[l_ac].num6 = "0"
      LET g_bgcj_d[l_ac].price6 = "0"
      LET g_bgcj_d[l_ac].amt6 = "0"
      LET g_bgcj_d[l_ac].num7 = "0"
      LET g_bgcj_d[l_ac].price7 = "0"
      LET g_bgcj_d[l_ac].amt7 = "0"
      LET g_bgcj_d[l_ac].num8 = "0"
      LET g_bgcj_d[l_ac].price8 = "0"
      LET g_bgcj_d[l_ac].amt8 = "0"
      LET g_bgcj_d[l_ac].num9 = "0"
      LET g_bgcj_d[l_ac].price9 = "0"
      LET g_bgcj_d[l_ac].amt9 = "0"
      LET g_bgcj_d[l_ac].num10 = "0"
      LET g_bgcj_d[l_ac].price10 = "0"
      LET g_bgcj_d[l_ac].amt10 = "0"
      LET g_bgcj_d[l_ac].num11 = "0"
      LET g_bgcj_d[l_ac].price11 = "0"
      LET g_bgcj_d[l_ac].amt11 = "0"
      LET g_bgcj_d[l_ac].num12 = "0"
      LET g_bgcj_d[l_ac].price12 = "0"
      LET g_bgcj_d[l_ac].amt12 = "0"
      LET g_bgcj_d[l_ac].num13 = "0"
      LET g_bgcj_d[l_ac].price13 = "0"
      LET g_bgcj_d[l_ac].amt13 = "0"
      LET g_bgcj_d[l_ac].bgcj008 = "0"
      LET g_bgcj_d[l_ac].bgcj050 = "2"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_bgcj_d_t.* = g_bgcj_d[l_ac].*     #新輸入資料
            LET g_bgcj_d_o.* = g_bgcj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt340_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgt340_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgcj_d[li_reproduce_target].* = g_bgcj_d[li_reproduce].*
               LET g_bgcj2_d[li_reproduce_target].* = g_bgcj2_d[li_reproduce].*
               LET g_bgcj3_d[li_reproduce_target].* = g_bgcj3_d[li_reproduce].*
 
               LET g_bgcj_d[g_bgcj_d.getLength()].bgcj008 = NULL
               LET g_bgcj_d[g_bgcj_d.getLength()].bgcjseq = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #项次
            IF g_bgcj_d[l_ac].bgcjseq IS NULL OR g_bgcj_d[l_ac].bgcjseq = 0 THEN
               LET l_sql = "SELECT MAX(bgcjseq)+1 FROM bgcj_t ",
                           " WHERE bgcjent=",g_enterprise,
                           "   AND bgcj001='",g_bgcj_m.bgcj001,"'",
                           "   AND bgcj002='",g_bgcj_m.bgcj002,"'",
                           "   AND bgcj003='",g_bgcj_m.bgcj003,"'",
                           "   AND bgcj004='",g_bgcj_m.bgcj004,"'",
                           "   AND bgcj005='",g_bgcj_m.bgcj005,"'",
                           "   AND bgcj006='",g_bgcj_m.bgcj006,"'"
               #预算组织在单头
               IF g_bgaw1[1] = 'Y' THEN
                  LET l_sql = l_sql," AND bgcj007='",g_bgcj_m.bgcj007,"'"
               END IF
               #预算料号在单头
               IF g_bgaw1[2] = 'Y' THEN
                  LET l_sql = l_sql," AND bgcj009='",g_bgcj_m.bgcj009,"'"
               END IF
               PREPARE abgt340_seq_pr FROM l_sql
               EXECUTE abgt340_seq_pr INTO g_bgcj_d[l_ac].bgcjseq
               IF g_bgcj_d[l_ac].bgcjseq IS NULL THEN
                  LET g_bgcj_d[l_ac].bgcjseq = 1
               END IF
            END IF
            
            #交易币别、汇率
            LET g_bgcj_d[l_ac].bgcj100=g_bgcj_m.bgaa003
#            LET g_bgcj_d[l_ac].bgcj101=1 #161220-00036#1 mark
            
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               LET g_bgcj_d[l_ac].bgcj007 = g_bgcj_m.bgcj007
            END IF
            
            #上层组织
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
               SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
                WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
               IF cl_null(l_bgaa010) THEN
                  LET g_bgcj_d[l_ac].bgcj047 = g_bgcj_d[l_ac].bgcj007
               ELSE
                  SELECT ooed005 INTO g_bgcj_d[l_ac].bgcj047 FROM ooed_t
                   WHERE ooedent=g_enterprise AND ooed001='4'
                     AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                     AND ooed004=g_bgcj_d[l_ac].bgcj007
                  IF cl_null(g_bgcj_d[l_ac].bgcj047) THEN
                     LET g_bgcj_d[l_ac].bgcj047 = g_bgcj_d[l_ac].bgcj007
                  END IF
               END IF
            END IF
            
            #预算料号在单头
            IF g_bgaw1[2] = 'Y' THEN
               LET g_bgcj_d[l_ac].bgcj009 = g_bgcj_m.bgcj009
               LET g_bgcj_d[l_ac].bgcj049 = g_bgcj_m.bgcj049
            END IF
            
            #稅别、含税否、销售单位
            #预算组织、预算料号都在单头
            IF g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' THEN
               #销售来源1.外部订单
               IF g_bgcj_m.bgcj005='1' THEN
                  LET l_bgea011 = ''
                  SELECT bgea012,bgea010,bgea011,bgea013 
                     INTO g_bgcj_d[l_ac].bgcj035,g_bgcj_d[l_ac].bgcj037,l_bgea011,g_bgcj_d[l_ac].bgcj100
                     FROM bgea_t
                    WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_m.bgcj009
                      AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_m.bgcj007
                  IF NOT cl_null(l_bgea011) AND 
                     ((g_bgaw2[6]='Y' AND g_bgal.bgal008='Y') OR (g_bgaw2[7]='Y' AND g_bgal.bgal009='Y')) THEN
                     #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                     CALL s_abg2_bgap001_chk(l_bgea011,g_bgcj_m.bgcj007)
                     IF cl_null(g_errno) THEN
                        #收付款客商
                        IF g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' THEN
                           LET g_bgcj_d[l_ac].bgcj016 = l_bgea011
                           CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj016) RETURNING g_bgcj_d[l_ac].bgcj016_desc
                           LET g_bgcj_d[l_ac].bgcj016_desc = g_bgcj_d[l_ac].bgcj016," ",g_bgcj_d[l_ac].bgcj016_desc
                        END IF
                        #账款客商
                        IF g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' THEN
                           LET g_bgcj_d[l_ac].bgcj017 = l_bgea011
                           CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj017) RETURNING g_bgcj_d[l_ac].bgcj017_desc
                           LET g_bgcj_d[l_ac].bgcj017_desc = g_bgcj_d[l_ac].bgcj017," ",g_bgcj_d[l_ac].bgcj017_desc
                        END IF
                     END IF
                  END IF
                  
                  IF NOT cl_null(g_bgcj_d[l_ac].bgcj035) THEN
                     SELECT oodb005 INTO g_bgcj_d[l_ac].bgcj036 FROM oodb_t
                      WHERE oodbent=g_enterprise AND oodb002=g_bgcj_d[l_ac].bgcj035
                        AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgcj_m.bgcj007)
                  END IF
#                  CALL s_abg_get_bg_rate(g_bgcj_m.bgcj002,g_today,g_bgcj_d[l_ac].bgcj100,g_bgcj_m.bgaa003) RETURNING g_bgcj_d[l_ac].bgcj101 #161220-00036#1 mark
               END IF
               #设置单身启用核算项
               CALL abgt340_set_detail_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_m.bgcj007,g_bgcj_m.bgcj049)
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
            SELECT COUNT(1) INTO l_count FROM bgcj_t 
             WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj_m.bgcj001
               AND bgcj002 = g_bgcj_m.bgcj002
               AND bgcj003 = g_bgcj_m.bgcj003
               AND bgcj004 = g_bgcj_m.bgcj004
               AND bgcj005 = g_bgcj_m.bgcj005
               AND bgcj006 = g_bgcj_m.bgcj006
               AND bgcj007 = g_bgcj_m.bgcj007
               AND bgcj009 = g_bgcj_m.bgcj009
               AND bgcj010 = g_bgcj_m.bgcj010
 
               AND bgcj008 = g_bgcj_d[l_ac].bgcj008
               AND bgcjseq = g_bgcj_d[l_ac].bgcjseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO bgcj_t
                           (bgcjent,
                            bgcj002,bgcj003,bgcj004,bgcj011,bgcj001,bgcj005,bgcj006,bgcj010,bgcjstus,bgcj007,bgcj013,bgcj016,bgcj019,bgcj022,bgcj009,bgcj014,bgcj017,bgcj020,bgcj023,bgcj012,bgcj015,bgcj018,bgcj021,bgcj024,bgcj049,
                            bgcj008,bgcjseq
                            ,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037,bgcj100,bgcj047,bgcj048,bgcj050,bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt) 
                     VALUES(g_enterprise,
                            g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019,g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023,g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj049,
                            g_bgcj_d[l_ac].bgcj008,g_bgcj_d[l_ac].bgcjseq
                            ,g_bgcj_d[l_ac].bgcj049,g_bgcj_d[l_ac].bgcj012,g_bgcj_d[l_ac].bgcj013,g_bgcj_d[l_ac].bgcj014, 
                                g_bgcj_d[l_ac].bgcj015,g_bgcj_d[l_ac].bgcj016,g_bgcj_d[l_ac].bgcj017, 
                                g_bgcj_d[l_ac].bgcj018,g_bgcj_d[l_ac].bgcj019,g_bgcj_d[l_ac].bgcj020, 
                                g_bgcj_d[l_ac].bgcj021,g_bgcj_d[l_ac].bgcj022,g_bgcj_d[l_ac].bgcj023, 
                                g_bgcj_d[l_ac].bgcj024,g_bgcj_d[l_ac].bgcj035,g_bgcj_d[l_ac].bgcj036, 
                                g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj047, 
                                g_bgcj_d[l_ac].bgcj048,g_bgcj_d[l_ac].bgcj050,g_bgcj2_d[l_ac].bgcjownid, 
                                g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid,g_bgcj2_d[l_ac].bgcjcrtdp, 
                                g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid,g_bgcj2_d[l_ac].bgcjmoddt, 
                                g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgcj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
            #组合key bgcj010
            CALL abgt340_get_bgcj010()
            
            #预算组织在单头
            IF g_bgaw1[1]='Y' THEN 
               LET l_bgcj007 = g_bgcj_m.bgcj007
            ELSE
               LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
            END IF
            #预算料号在单头
            IF g_bgaw1[2]='Y' THEN 
               LET l_bgcj009 = g_bgcj_m.bgcj009
            ELSE
               LET l_bgcj009 = g_bgcj_d[l_ac].bgcj009
            END IF
            CALL s_abgt340_detail_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                          g_bgcj_m.bgcj006,l_bgcj007,l_bgcj009,g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010)
            RETURNING l_success
            IF l_success = FALSE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00004'
               LET g_errparam.extend =g_bgcj_d[l_ac].bgcjseq
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD bgcjseq
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bgcj_t 
             WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj_m.bgcj001
               AND bgcj002 = g_bgcj_m.bgcj002
               AND bgcj003 = g_bgcj_m.bgcj003
               AND bgcj004 = g_bgcj_m.bgcj004
               AND bgcj005 = g_bgcj_m.bgcj005
               AND bgcj006 = g_bgcj_m.bgcj006
               AND bgcj007 = l_bgcj007
               AND bgcj009 = l_bgcj009
               AND bgcj010 = g_bgcj_d[l_ac].bgcj010
               AND bgcjseq = g_bgcj_d[l_ac].bgcjseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #插入数据库
               CALL abgt340_insert_bgcj() RETURNING l_success

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
               INITIALIZE g_bgcj_d[l_ac].* TO NULL
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
               IF abgt340_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bgcj_m.bgcj001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj002
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj003
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj004
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj005
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj006
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj007
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj009
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_m.bgcj010
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_d_t.bgcj008
                  LET gs_keys[gs_keys.getLength()+1] = g_bgcj_d_t.bgcjseq
 
 
                  #刪除下層單身
                  IF NOT abgt340_key_delete_b(gs_keys,'bgcj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgt340_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgt340_bcl
               LET l_count = g_bgcj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgcj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjseq
            #add-point:BEFORE FIELD bgcjseq name="input.b.page1.bgcjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjseq
            
            #add-point:AFTER FIELD bgcjseq name="input.a.page1.bgcjseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  g_bgcj_m.bgcj001 IS NOT NULL AND g_bgcj_m.bgcj002 IS NOT NULL AND g_bgcj_m.bgcj003 IS NOT NULL AND g_bgcj_m.bgcj004 IS NOT NULL AND g_bgcj_m.bgcj005 IS NOT NULL AND g_bgcj_m.bgcj006 IS NOT NULL AND g_bgcj_m.bgcj007 IS NOT NULL AND g_bgcj_m.bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t OR g_bgcj_m.bgcj002 != g_bgcj002_t OR g_bgcj_m.bgcj003 != g_bgcj003_t OR g_bgcj_m.bgcj004 != g_bgcj004_t OR g_bgcj_m.bgcj005 != g_bgcj005_t OR g_bgcj_m.bgcj006 != g_bgcj006_t OR g_bgcj_m.bgcj007 != g_bgcj007_t OR g_bgcj_m.bgcj009 != g_bgcj009_t OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_m.bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_m.bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_m.bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_m.bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_m.bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_m.bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_m.bgcj007 ||"' AND "|| "bgcj009 = '"||g_bgcj_m.bgcj009 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #主鍵檢查
            IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
               AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
               AND NOT cl_null(g_bgcj_d[l_ac].bgcjseq)
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj007)))
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj009)))
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                  OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                  OR ((g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t ) OR (g_bgaw2[1]='Y' AND g_bgcj_d[l_ac].bgcj007!=g_bgcj_d_t.bgcj007))
                                  OR ((g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t ) OR (g_bgaw2[2]='Y' AND g_bgcj_d[l_ac].bgcj009!=g_bgcj_d_t.bgcj009)) 
                                  )
               ) THEN 
                  #组合key bgcj010
                  CALL abgt340_get_bgcj010()
                  
                  #预算组织在单头
                  IF g_bgaw1[1]='Y' THEN 
                     LET l_bgcj007 = g_bgcj_m.bgcj007
                  ELSE
                     LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
                  END IF
                  #预算料号在单头
                  IF g_bgaw1[2]='Y' THEN 
                     LET l_bgcj009 = g_bgcj_m.bgcj009
                  ELSE
                     LET l_bgcj009 = g_bgcj_d[l_ac].bgcj009
                  END IF
                  
                  CALL s_abgt340_detail_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                g_bgcj_m.bgcj006,l_bgcj007,l_bgcj009,g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcjseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcjseq = g_bgcj_d_t.bgcjseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcjseq
            #add-point:ON CHANGE bgcjseq name="input.g.page1.bgcjseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj010_2
            #add-point:BEFORE FIELD bgcj010_2 name="input.b.page1.bgcj010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj010_2
            
            #add-point:AFTER FIELD bgcj010_2 name="input.a.page1.bgcj010_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj010_2
            #add-point:ON CHANGE bgcj010_2 name="input.g.page1.bgcj010_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007_2
            #add-point:BEFORE FIELD bgcj007_2 name="input.b.page1.bgcj007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007_2
            
            #add-point:AFTER FIELD bgcj007_2 name="input.a.page1.bgcj007_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj007_2
            #add-point:ON CHANGE bgcj007_2 name="input.g.page1.bgcj007_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007_desc
            #add-point:BEFORE FIELD bgcj007_desc name="input.b.page1.bgcj007_desc"
            LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d[l_ac].bgcj007
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007_desc
            
            #add-point:AFTER FIELD bgcj007_desc name="input.a.page1.bgcj007_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj007_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj007_desc <> g_bgcj_d_t.bgcj007 OR cl_null(g_bgcj_d_t.bgcj007))) THEN
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgcj_d[l_ac].bgcj007_desc
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     #檢查失敗時後續處理
                     LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                     NEXT FIELD CURRENT
                  END IF
                 
                  #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_bgcj_d[l_ac].bgcj007_desc,'01')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcj007_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                     NEXT FIELD CURRENT
                  END IF
                  
                  #检查预算编号+版本+预算管理组织+销售方式下预算组织或预算上层组织是否已存在汇总资料abgt350，如果存在，不可录入
                  IF NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) AND
                     NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) THEN
                     #预算组织是否存在汇总资料
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                      WHERE bgcjent=g_enterprise AND bgcj001='30'
                        AND bgcj002=g_bgcj_m.bgcj002 AND bgcj003=g_bgcj_m.bgcj003
                        AND bgcj004=g_bgcj_m.bgcj004 AND bgcj005=g_bgcj_m.bgcj005
                        AND bgcj006='2' AND bgcj007 = g_bgcj_d[l_ac].bgcj007_desc
                        AND bgcjstus<>'X'
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00231'
                        LET g_errparam.extend =g_bgcj_d[l_ac].bgcj007_desc
                        #161215-00014#1--add--str--
                        LET g_errparam.replace[1] = cl_get_progname('abgt350',g_lang,"2")
                        LET g_errparam.exeprog = 'abgt350'
                        #161215-00014#1--add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                        NEXT FIELD CURRENT
                     END IF
                     #预算组织的上层组织是否存在汇总资料
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
                     #抓取上层组织
                     IF NOT cl_null(l_bgaa010) THEN
                        SELECT ooed005 INTO l_ooed005 FROM ooed_t
                          WHERE ooedent=g_enterprise AND ooed001='4'
                            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                            AND ooed004=g_bgcj_d[l_ac].bgcj007_desc
                        IF NOT cl_null(l_ooed005) THEN
                           LET l_cnt = 0
                           SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                            WHERE bgcjent=g_enterprise AND bgcj001='30'
                              AND bgcj002=g_bgcj_m.bgcj002 AND bgcj003=g_bgcj_m.bgcj003
                              AND bgcj004=g_bgcj_m.bgcj004 AND bgcj005=g_bgcj_m.bgcj005
                              AND bgcj006='2' AND bgcj007 = l_ooed005
                              AND bgcjstus<>'X'
                           IF l_cnt > 0 THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00232'
                              LET g_errparam.extend =g_bgcj_d[l_ac].bgcj007_desc
                              #161215-00014#1--add--str--
                              LET g_errparam.replace[1] = cl_get_progname('abgt350',g_lang,"2")
                              LET g_errparam.exeprog = 'abgt350'
                              #161215-00014#1--add--end
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
                     AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
                     AND NOT cl_null(g_bgcj_d[l_ac].bgcjseq)
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj007_desc)))
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj009)))
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                        OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                        OR ((g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t ) OR (g_bgaw2[1]='Y' AND g_bgcj_d[l_ac].bgcj007_desc!=g_bgcj_d_t.bgcj007 ))
                                        OR ((g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t ) OR (g_bgaw2[2]='Y' AND g_bgcj_d[l_ac].bgcj009!=g_bgcj_d_t.bgcj009)) 
                                        )
                     ) THEN
                        #组合key bgcj010
                        CALL abgt340_get_bgcj010()
                        
                        #预算料号在单头
                        IF g_bgaw1[2]='Y' THEN 
                           LET l_bgcj009 = g_bgcj_m.bgcj009
                        ELSE
                           LET l_bgcj009 = g_bgcj_d[l_ac].bgcj009
                        END IF
                        CALL s_abgt340_detail_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                      g_bgcj_m.bgcj006,g_bgcj_d[l_ac].bgcj007_desc,l_bgcj009,g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010)
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgcj_d[l_ac].bgcj007_desc
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #稅别、含税否、销售单位
                  #预算料号有值时，重新设置预设值及核算项启用
                  #预算料号在单头
                  LET l_bgea012 = ''
                  LET l_bgea010 = ''
                  LET l_bgea011 = ''
                  LET l_bgea013 = ''
                  LET l_bgea004 = ''
                  IF g_bgaw1[2] = 'Y' THEN
                     IF NOT cl_null(g_bgcj_m.bgcj009) THEN
                        #销售来源1.外部订单
                        IF g_bgcj_m.bgcj005='1' THEN
                           SELECT bgea004,bgea012,bgea010,bgea011,bgea013 
                              INTO l_bgea004,l_bgea012,l_bgea010,l_bgea011,l_bgea013
                              FROM bgea_t
                             WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_m.bgcj009
                               AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_d[l_ac].bgcj007_desc
                           
                           #161215-00014#1--add--str--
                           #判断是否维护了预算细项，没有维护提示维护
                           IF cl_null(l_bgea004) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00204'
                              LET g_errparam.extend =g_bgcj_d[l_ac].bgcj007_desc," + ",g_bgcj_m.bgcj009
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                              NEXT FIELD CURRENT
                           END IF
                           #161215-00014#1--add--end
                           #预算细项权限检查abgi090
                           CALL s_abg2_bgai006_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,g_bgcj_d[l_ac].bgcj007_desc,'01',l_bgea004)
                           IF NOT cl_null(g_errno) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend =l_bgea004
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                              NEXT FIELD CURRENT
                           END IF
                           LET g_bgcj_m.bgcj049 = l_bgea004
                        END IF
                        
                        #设置单头启用核算项
                        CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007_desc,g_bgcj_m.bgcj049)
                        #设置单身启用核算项
                        CALL abgt340_set_detail_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007_desc,g_bgcj_m.bgcj049)
                     END IF
                  ELSE      
                     #预算料在单身
                     IF NOT cl_null(g_bgcj_d[l_ac].bgcj009) THEN
                        #销售来源1.外部订单
                        IF g_bgcj_m.bgcj005='1' THEN
                           SELECT bgea004,bgea012,bgea010,bgea011,bgea013 
                             INTO l_bgea004,l_bgea012,l_bgea010,l_bgea011,l_bgea013
                             FROM bgea_t
                            WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_d[l_ac].bgcj009
                              AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_d[l_ac].bgcj007_desc
                           #161215-00014#1--add--str--
                           #判断是否维护了预算细项，没有维护提示维护
                           IF cl_null(l_bgea004) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00204'
                              LET g_errparam.extend =g_bgcj_d[l_ac].bgcj007_desc," + ",g_bgcj_d[l_ac].bgcj009
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                              NEXT FIELD CURRENT
                           END IF
                           #161215-00014#1--add--end
                           #预算细项权限检查abgi090
                           CALL s_abg2_bgai006_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,g_bgcj_d[l_ac].bgcj007_desc,'01',l_bgea004)
                           IF NOT cl_null(g_errno) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend =l_bgea004
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d_t.bgcj007
                              NEXT FIELD CURRENT
                           END IF
                           LET g_bgcj_d[l_ac].bgcj049 = l_bgea004
                        END IF
                        
                        #设置单头启用核算项
                        CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007_desc,g_bgcj_d[l_ac].bgcj049)
                        #设置单身启用核算项
                        CALL abgt340_set_detail_hsx_entry(g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007_desc,g_bgcj_d[l_ac].bgcj049)
                     END IF
                  END IF
                  
                  #收付款客商、账款客商
                  IF NOT cl_null(l_bgea011) THEN
                     IF (g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_d[l_ac].bgcj016) ) OR 
                        (g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_d[l_ac].bgcj017) )THEN
                        #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                        CALL s_abg2_bgap001_chk(l_bgea011,g_bgcj_d[l_ac].bgcj007_desc)
                        IF cl_null(g_errno) THEN
                           #收付款客商
                           IF g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_d[l_ac].bgcj016) THEN
                              LET g_bgcj_d[l_ac].bgcj016 = l_bgea011
                              CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj016) RETURNING g_bgcj_d[l_ac].bgcj016_desc
                              LET g_bgcj_d[l_ac].bgcj016_desc = g_bgcj_d[l_ac].bgcj016," ",g_bgcj_d[l_ac].bgcj016_desc
                           END IF
                           #账款客商
                           IF g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_d[l_ac].bgcj017) THEN
                              LET g_bgcj_d[l_ac].bgcj017 = l_bgea011
                              CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj017) RETURNING g_bgcj_d[l_ac].bgcj017_desc
                              LET g_bgcj_d[l_ac].bgcj017_desc = g_bgcj_d[l_ac].bgcj017," ",g_bgcj_d[l_ac].bgcj017_desc
                           END IF
                        END IF
                     END IF
                  END IF
                  
                  #稅别、含税否
                  IF NOT cl_null(l_bgea012) AND cl_null(g_bgcj_d[l_ac].bgcj035) THEN
                     LET g_bgcj_d[l_ac].bgcj035 = l_bgea012
                     SELECT oodb005 INTO g_bgcj_d[l_ac].bgcj036 FROM oodb_t
                      WHERE oodbent=g_enterprise AND oodb002=g_bgcj_d[l_ac].bgcj035
                        AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgcj_d[l_ac].bgcj007_desc)
                  END IF
                  
                  #销售单位
                  IF NOT cl_null(l_bgea010) AND cl_null(g_bgcj_d[l_ac].bgcj037) THEN
                     LET g_bgcj_d[l_ac].bgcj037 = l_bgea010
                  END IF
                  
                  #币别、汇率
                  IF NOT cl_null(l_bgea013) AND cl_null(g_bgcj_d[l_ac].bgcj100) THEN
                     LET g_bgcj_d[l_ac].bgcj100 = l_bgea013
#                     CALL s_abg_get_bg_rate(g_bgcj_m.bgcj002,g_today,g_bgcj_d[l_ac].bgcj100,g_bgcj_m.bgaa003) RETURNING g_bgcj_d[l_ac].bgcj101 #161220-00036#1 mark
                  END IF
                  
                  #上层组织
                  IF NOT cl_null(g_bgcj_d[l_ac].bgcj007_desc) THEN
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
                     IF cl_null(l_bgaa010) THEN
                        LET g_bgcj_d[l_ac].bgcj047 = g_bgcj_d[l_ac].bgcj007_desc
                     ELSE
                        SELECT ooed005 INTO g_bgcj_d[l_ac].bgcj047 FROM ooed_t
                         WHERE ooedent=g_enterprise AND ooed001='4'
                           AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                           AND ooed004=g_bgcj_d[l_ac].bgcj007_desc
                        IF cl_null(g_bgcj_d[l_ac].bgcj047) THEN
                           LET g_bgcj_d[l_ac].bgcj047 = g_bgcj_d[l_ac].bgcj007_desc
                        END IF
                     END IF
                  END IF
               END IF
               LET g_bgcj_d[l_ac].bgcj007 = g_bgcj_d[l_ac].bgcj007_desc
               CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj007) RETURNING g_bgcj_d[l_ac].bgcj007_desc
               LET g_bgcj_d[l_ac].bgcj007_desc = g_bgcj_d[l_ac].bgcj007,"  ",g_bgcj_d[l_ac].bgcj007_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj007 = g_bgcj_d[l_ac].bgcj007_desc
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj007_desc
            #add-point:ON CHANGE bgcj007_desc name="input.g.page1.bgcj007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009_2
            #add-point:BEFORE FIELD bgcj009_2 name="input.b.page1.bgcj009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009_2
            
            #add-point:AFTER FIELD bgcj009_2 name="input.a.page1.bgcj009_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj009_2
            #add-point:ON CHANGE bgcj009_2 name="input.g.page1.bgcj009_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009_desc
            #add-point:BEFORE FIELD bgcj009_desc name="input.b.page1.bgcj009_desc"
            LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d[l_ac].bgcj009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009_desc
            
            #add-point:AFTER FIELD bgcj009_desc name="input.a.page1.bgcj009_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj009_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj009_desc <> g_bgcj_d_t.bgcj009 OR cl_null(g_bgcj_d_t.bgcj009))) THEN
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_bgcj009_chk(g_bgcj_m.bgcj005,g_bgcj_d[l_ac].bgcj009_desc,g_bgcj_m.bgcj002,g_bgcj_m.bgcj007)
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_bgcj009_chk(g_bgcj_m.bgcj005,g_bgcj_d[l_ac].bgcj009_desc,g_bgcj_m.bgcj002,g_bgcj_d[l_ac].bgcj007)
                  END IF 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcj009_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d_t.bgcj009
                     NEXT FIELD CURRENT
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgcj_m.bgcj001) AND NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj003) 
                     AND NOT cl_null(g_bgcj_m.bgcj004) AND NOT cl_null(g_bgcj_m.bgcj005) AND NOT cl_null(g_bgcj_m.bgcj006) 
                     AND NOT cl_null(g_bgcj_d[l_ac].bgcjseq)
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj007)))
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgcj_m.bgcj009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj009_desc)))
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t 
                                        OR g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t 
                                        OR ((g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t ) OR (g_bgaw2[1]='Y' AND g_bgcj_d[l_ac].bgcj007!=g_bgcj_d_t.bgcj007 ))
                                        OR ((g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t ) OR (g_bgaw2[2]='Y' AND g_bgcj_d[l_ac].bgcj009_desc!=g_bgcj_d_t.bgcj009)) 
                                        )
                     ) THEN 
                        #组合key bgcj010
                        CALL abgt340_get_bgcj010()
                  
                        #预算组织在单头
                        IF g_bgaw1[1]='Y' THEN 
                           LET l_bgcj007 = g_bgcj_m.bgcj007
                        ELSE
                           LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
                        END IF
                        
                        CALL s_abgt340_detail_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                      g_bgcj_m.bgcj006,l_bgcj007,g_bgcj_d[l_ac].bgcj009_desc,g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010)
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgcj_d[l_ac].bgcj009_desc
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d_t.bgcj009
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               
                  #对应预算细项 #稅别、含税否、销售单位
                  #销售来源1.外部订单
                  LET l_bgea012 = ''
                  LET l_bgea010 = ''
                  LET l_bgea011 = ''
                  LET l_bgea013 = ''
                  LET l_bgea004 = ''
                  IF g_bgcj_m.bgcj005 = '1' THEN
                     #预算组织在单头
                     IF g_bgaw1[1] = 'Y' THEN
                        IF NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_m.bgcj007) THEN
                           SELECT bgea004,bgea012,bgea010,bgea011,bgea013
                             INTO l_bgea004,l_bgea012,l_bgea010,l_bgea011,l_bgea013
                             FROM bgea_t
                            WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_d[l_ac].bgcj009_desc
                              AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_m.bgcj007
                        END IF
                     ELSE
                     #预算组织在单身
                        IF NOT cl_null(g_bgcj_m.bgcj002) AND NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                           SELECT bgea004,bgea012,bgea010,bgea011,bgea013 
                             INTO l_bgea004,l_bgea012,l_bgea010,l_bgea011,l_bgea013
                             FROM bgea_t
                            WHERE bgeaent=g_enterprise AND bgea003=g_bgcj_d[l_ac].bgcj009_desc
                              AND bgea001=g_bgcj_m.bgcj002 AND bgea002=g_bgcj_d[l_ac].bgcj007
                        END IF
                     END IF
                  END IF
                  
                  #销售来源4.招商收入
                  IF g_bgcj_m.bgcj005 = '4' THEN
                     IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                        SELECT bgce003 INTO l_bgea004 FROM bgce_t
                         WHERE bgceent=g_enterprise AND bgce002=g_bgcj_d[l_ac].bgcj009_desc
                           AND bgce001=(SELECT bgaa008 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002)
                     END IF
                  END IF
                           
                  #设置核算项可可录入否
                  #预算组织在单头
                  IF g_bgaw1[1]='Y' THEN 
                     LET l_bgcj007 = g_bgcj_m.bgcj007
                  ELSE
                     LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
                  END IF
                  #预算细项权限检查abgi090
                  CALL s_abg2_bgai006_chk(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,l_bgcj007,'01',l_bgea004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =l_bgea004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d_t.bgcj009
                     NEXT FIELD CURRENT
                  END IF
                  LET g_bgcj_d[l_ac].bgcj049 = l_bgea004
                  
                  #设置单头启用核算项
                  CALL abgt340_set_head_hsx_entry(g_bgcj_m.bgcj002,l_bgcj007,g_bgcj_d[l_ac].bgcj049)
                  #设置单身启用核算项
                  CALL abgt340_set_detail_hsx_entry(g_bgcj_m.bgcj002,l_bgcj007,g_bgcj_d[l_ac].bgcj049) 
                  
                  #收付款客商、账款客商
                  IF NOT cl_null(l_bgea011) THEN
                     IF (g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_d[l_ac].bgcj016) ) OR 
                        (g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_d[l_ac].bgcj017) )THEN
                        #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                        CALL s_abg2_bgap001_chk(l_bgea011,g_bgcj_d[l_ac].bgcj007)
                        IF cl_null(g_errno) THEN
                           #收付款客商
                           IF g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgcj_d[l_ac].bgcj016) THEN
                              LET g_bgcj_d[l_ac].bgcj016 = l_bgea011
                              CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj016) RETURNING g_bgcj_d[l_ac].bgcj016_desc
                              LET g_bgcj_d[l_ac].bgcj016_desc = g_bgcj_d[l_ac].bgcj016," ",g_bgcj_d[l_ac].bgcj016_desc
                           END IF
                           #账款客商
                           IF g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgcj_d[l_ac].bgcj017) THEN
                              LET g_bgcj_d[l_ac].bgcj017 = l_bgea011
                              CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj017) RETURNING g_bgcj_d[l_ac].bgcj017_desc
                              LET g_bgcj_d[l_ac].bgcj017_desc = g_bgcj_d[l_ac].bgcj017," ",g_bgcj_d[l_ac].bgcj017_desc
                           END IF
                        END IF
                     END IF
                  END IF
                  
                  #稅别、含税否
                  IF NOT cl_null(l_bgea012) AND cl_null(g_bgcj_d[l_ac].bgcj035) THEN
                     LET g_bgcj_d[l_ac].bgcj035 = l_bgea012
                     SELECT oodb005 INTO g_bgcj_d[l_ac].bgcj036 FROM oodb_t
                      WHERE oodbent=g_enterprise AND oodb002=g_bgcj_d[l_ac].bgcj035
                        AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgcj_d[l_ac].bgcj007)
                  END IF
                  
                  #销售单位
                  IF NOT cl_null(l_bgea010) AND cl_null(g_bgcj_d[l_ac].bgcj037) THEN
                     LET g_bgcj_d[l_ac].bgcj037 = l_bgea010
                  END IF
                  
                  #币别、汇率
                  IF NOT cl_null(l_bgea013) AND cl_null(g_bgcj_d[l_ac].bgcj100) THEN
                     LET g_bgcj_d[l_ac].bgcj100 = l_bgea013
#                     CALL s_abg_get_bg_rate(g_bgcj_m.bgcj002,g_today,g_bgcj_d[l_ac].bgcj100,g_bgcj_m.bgaa003) RETURNING g_bgcj_d[l_ac].bgcj101 #161220-00036#1 mark
                  END IF              
               END IF   
            END IF
            LET g_bgcj_d[l_ac].bgcj009 = g_bgcj_d[l_ac].bgcj009_desc
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj009) THEN
               #销售来源4.招商收入，抓取模拟收入项目说明
               IF g_bgcj_m.bgcj005 = '4' THEN
                  CALL s_desc_get_bgcc001_desc(g_bgcj_d[l_ac].bgcj009) RETURNING g_bgcj_d[l_ac].bgcj009_desc
                  LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d[l_ac].bgcj009,"  ",g_bgcj_d[l_ac].bgcj009_desc
               ELSE
               #销售来源1.外部订单,抓取料件的品名规格
                  CALL s_desc_get_bgas001_desc(g_bgcj_d[l_ac].bgcj009) RETURNING l_bgasl003,l_bgasl004
                  LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d[l_ac].bgcj009,"  ",l_bgasl003,"  ",l_bgasl004
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj009_desc
            #add-point:ON CHANGE bgcj009_desc name="input.g.page1.bgcj009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj049
            #add-point:BEFORE FIELD bgcj049 name="input.b.page1.bgcj049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj049
            
            #add-point:AFTER FIELD bgcj049 name="input.a.page1.bgcj049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj049
            #add-point:ON CHANGE bgcj049 name="input.g.page1.bgcj049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj012_2
            #add-point:BEFORE FIELD bgcj012_2 name="input.b.page1.bgcj012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj012_2
            
            #add-point:AFTER FIELD bgcj012_2 name="input.a.page1.bgcj012_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj012_2
            #add-point:ON CHANGE bgcj012_2 name="input.g.page1.bgcj012_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj012_desc
            #add-point:BEFORE FIELD bgcj012_desc name="input.b.page1.bgcj012_desc"
            LET g_bgcj_d[l_ac].bgcj012_desc = g_bgcj_d[l_ac].bgcj012
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj012_desc
            
            #add-point:AFTER FIELD bgcj012_desc name="input.a.page1.bgcj012_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj012_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj012_desc <> g_bgcj_d_t.bgcj012 OR cl_null(g_bgcj_d_t.bgcj012))) THEN
                  #员工基础资料检查
                  CALL s_employee_chk(g_bgcj_d[l_ac].bgcj012_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_d[l_ac].bgcj012_desc = g_bgcj_d_t.bgcj012
                     NEXT FIELD CURRENT
                  END IF
#161220-00036#1--mark--str--                  
#                  #当预算组织在单身，人员在单头时，人员归属据点归属法人必须等于g_site归属法人
#                  #其他情况，人员归属据点归属法人必须等于预算组织归属法人
#                  #预算组织在单头
#                  IF g_bgaw1[1] = 'Y' THEN
#                     CALL s_abgt340_comp_chk(1,g_bgcj_d[l_ac].bgcj012_desc,g_bgcj_m.bgcj007)                  
#                  ELSE
#                  #预算组织在单身
#                     CALL s_abgt340_comp_chk(1,g_bgcj_d[l_ac].bgcj012_desc,g_bgcj_d[l_ac].bgcj007)
#                  END IF
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcj012_desc
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_bgcj_d[l_ac].bgcj012_desc = g_bgcj_d_t.bgcj012
#                     NEXT FIELD CURRENT
#                  END IF
#161220-00036#1--mark--end
               END IF
               LET g_bgcj_d[l_ac].bgcj012 = g_bgcj_d[l_ac].bgcj012_desc
               CALL s_desc_get_person_desc(g_bgcj_d[l_ac].bgcj012) RETURNING g_bgcj_d[l_ac].bgcj012_desc
               LET g_bgcj_d[l_ac].bgcj012_desc = g_bgcj_d[l_ac].bgcj012,"  ",g_bgcj_d[l_ac].bgcj012_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj012 = g_bgcj_d[l_ac].bgcj012_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj012_desc
            #add-point:ON CHANGE bgcj012_desc name="input.g.page1.bgcj012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj013_2
            #add-point:BEFORE FIELD bgcj013_2 name="input.b.page1.bgcj013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj013_2
            
            #add-point:AFTER FIELD bgcj013_2 name="input.a.page1.bgcj013_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj013_2
            #add-point:ON CHANGE bgcj013_2 name="input.g.page1.bgcj013_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj013_desc
            #add-point:BEFORE FIELD bgcj013_desc name="input.b.page1.bgcj013_desc"
            LET g_bgcj_d[l_ac].bgcj013_desc = g_bgcj_d[l_ac].bgcj013
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj013_desc
            
            #add-point:AFTER FIELD bgcj013_desc name="input.a.page1.bgcj013_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj013_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj013_desc <> g_bgcj_d_t.bgcj013 OR cl_null(g_bgcj_d_t.bgcj013))) THEN
                  #部门基础资料检核
                  CALL s_department_chk(g_bgcj_d[l_ac].bgcj013_desc,g_today) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_d[l_ac].bgcj013_desc = g_bgcj_d_t.bgcj013
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(2,g_bgcj_d[l_ac].bgcj013_desc,g_bgcj_m.bgcj007)  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(2,g_bgcj_d[l_ac].bgcj013_desc,g_bgcj_d[l_ac].bgcj007) 
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcj013_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj013_desc = g_bgcj_d_t.bgcj013
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #抓取部门对应利润中心
               IF g_bgaw2[4]='Y' AND cl_null(g_bgcj_d[l_ac].bgcj014) AND g_bgal.bgal006 = 'Y' THEN
                  SELECT ooeg004 INTO g_bgcj_d[l_ac].bgcj014 FROM ooeg_t
                   WHERE ooegent=g_enterprise AND ooeg001=g_bgcj_d[l_ac].bgcj013_desc
                  CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj014) RETURNING g_bgcj_d[l_ac].bgcj014_desc
                  LET g_bgcj_d[l_ac].bgcj014_desc = g_bgcj_d[l_ac].bgcj014,"  ",g_bgcj_d[l_ac].bgcj014_desc
               END IF
               LET g_bgcj_d[l_ac].bgcj013 = g_bgcj_d[l_ac].bgcj013_desc
               CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj013) RETURNING g_bgcj_d[l_ac].bgcj013_desc
               LET g_bgcj_d[l_ac].bgcj013_desc = g_bgcj_d[l_ac].bgcj013,"  ",g_bgcj_d[l_ac].bgcj013_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj013 = g_bgcj_d[l_ac].bgcj013_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj013_desc
            #add-point:ON CHANGE bgcj013_desc name="input.g.page1.bgcj013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj014_2
            #add-point:BEFORE FIELD bgcj014_2 name="input.b.page1.bgcj014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj014_2
            
            #add-point:AFTER FIELD bgcj014_2 name="input.a.page1.bgcj014_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj014_2
            #add-point:ON CHANGE bgcj014_2 name="input.g.page1.bgcj014_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj014_desc
            #add-point:BEFORE FIELD bgcj014_desc name="input.b.page1.bgcj014_desc"
            LET g_bgcj_d[l_ac].bgcj014_desc = g_bgcj_d[l_ac].bgcj014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj014_desc
            
            #add-point:AFTER FIELD bgcj014_desc name="input.a.page1.bgcj014_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj014_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj014_desc <> g_bgcj_d_t.bgcj014 OR cl_null(g_bgcj_d_t.bgcj014))) THEN
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bgcj_d[l_ac].bgcj014_desc,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj014_desc
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj014_desc = g_bgcj_d_t.bgcj014
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(2,g_bgcj_d[l_ac].bgcj014_desc,g_bgcj_m.bgcj007)                  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(2,g_bgcj_d[l_ac].bgcj014_desc,g_bgcj_d[l_ac].bgcj007)
                  END IF  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcj014_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj014_desc = g_bgcj_d_t.bgcj014
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj014 = g_bgcj_d[l_ac].bgcj014_desc
               CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj014) RETURNING g_bgcj_d[l_ac].bgcj014_desc
               LET g_bgcj_d[l_ac].bgcj014_desc = g_bgcj_d[l_ac].bgcj014,"  ",g_bgcj_d[l_ac].bgcj014_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj014 = g_bgcj_d[l_ac].bgcj014_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj014_desc
            #add-point:ON CHANGE bgcj014_desc name="input.g.page1.bgcj014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj015_2
            #add-point:BEFORE FIELD bgcj015_2 name="input.b.page1.bgcj015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj015_2
            
            #add-point:AFTER FIELD bgcj015_2 name="input.a.page1.bgcj015_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj015_2
            #add-point:ON CHANGE bgcj015_2 name="input.g.page1.bgcj015_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj015_desc
            #add-point:BEFORE FIELD bgcj015_desc name="input.b.page1.bgcj015_desc"
            LET g_bgcj_d[l_ac].bgcj015_desc = g_bgcj_d[l_ac].bgcj015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj015_desc
            
            #add-point:AFTER FIELD bgcj015_desc name="input.a.page1.bgcj015_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj015_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj015_desc <> g_bgcj_d_t.bgcj015 OR cl_null(g_bgcj_d_t.bgcj015))) THEN
                  CALL s_azzi650_chk_exist('287',g_bgcj_d[l_ac].bgcj015_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_d[l_ac].bgcj015_desc = g_bgcj_d_t.bgcj015
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj015 = g_bgcj_d[l_ac].bgcj015_desc
               CALL s_desc_get_acc_desc('287',g_bgcj_d[l_ac].bgcj015) RETURNING g_bgcj_d[l_ac].bgcj015_desc
               LET g_bgcj_d[l_ac].bgcj015_desc = g_bgcj_d[l_ac].bgcj015,"  ",g_bgcj_d[l_ac].bgcj015_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj015 = g_bgcj_d[l_ac].bgcj015_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj015_desc
            #add-point:ON CHANGE bgcj015_desc name="input.g.page1.bgcj015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016_2
            #add-point:BEFORE FIELD bgcj016_2 name="input.b.page1.bgcj016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016_2
            
            #add-point:AFTER FIELD bgcj016_2 name="input.a.page1.bgcj016_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj016_2
            #add-point:ON CHANGE bgcj016_2 name="input.g.page1.bgcj016_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016_desc
            #add-point:BEFORE FIELD bgcj016_desc name="input.b.page1.bgcj016_desc"
            LET g_bgcj_d[l_ac].bgcj016_desc = g_bgcj_d[l_ac].bgcj016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016_desc
            
            #add-point:AFTER FIELD bgcj016_desc name="input.a.page1.bgcj016_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj016_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj016_desc <> g_bgcj_d_t.bgcj016 OR cl_null(g_bgcj_d_t.bgcj016))) THEN
                  CALL s_abg2_bgap001_chk(g_bgcj_d[l_ac].bgcj016_desc,g_bgcj_d[l_ac].bgcj007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj016_desc
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj016_desc = g_bgcj_d_t.bgcj016
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj016 = g_bgcj_d[l_ac].bgcj016_desc
               CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj016) RETURNING g_bgcj_d[l_ac].bgcj016_desc
               LET g_bgcj_d[l_ac].bgcj016_desc = g_bgcj_d[l_ac].bgcj016,"  ",g_bgcj_d[l_ac].bgcj016_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj016 = g_bgcj_d[l_ac].bgcj016_desc
            END IF          
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj016_desc
            #add-point:ON CHANGE bgcj016_desc name="input.g.page1.bgcj016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj017_2
            #add-point:BEFORE FIELD bgcj017_2 name="input.b.page1.bgcj017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj017_2
            
            #add-point:AFTER FIELD bgcj017_2 name="input.a.page1.bgcj017_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj017_2
            #add-point:ON CHANGE bgcj017_2 name="input.g.page1.bgcj017_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj017_desc
            #add-point:BEFORE FIELD bgcj017_desc name="input.b.page1.bgcj017_desc"
            LET g_bgcj_d[l_ac].bgcj017_desc = g_bgcj_d[l_ac].bgcj017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj017_desc
            
            #add-point:AFTER FIELD bgcj017_desc name="input.a.page1.bgcj017_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj017_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj017_desc <> g_bgcj_d_t.bgcj017 OR cl_null(g_bgcj_d_t.bgcj017))) THEN
                  CALL s_abg2_bgap001_chk(g_bgcj_d[l_ac].bgcj017_desc,g_bgcj_d[l_ac].bgcj007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj017_desc
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj017_desc = g_bgcj_d_t.bgcj017
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj017 = g_bgcj_d[l_ac].bgcj017_desc
               CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj017) RETURNING g_bgcj_d[l_ac].bgcj017_desc
               LET g_bgcj_d[l_ac].bgcj017_desc = g_bgcj_d[l_ac].bgcj017,"  ",g_bgcj_d[l_ac].bgcj017_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj017 = g_bgcj_d[l_ac].bgcj017_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj017_desc
            #add-point:ON CHANGE bgcj017_desc name="input.g.page1.bgcj017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj018_2
            #add-point:BEFORE FIELD bgcj018_2 name="input.b.page1.bgcj018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj018_2
            
            #add-point:AFTER FIELD bgcj018_2 name="input.a.page1.bgcj018_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj018_2
            #add-point:ON CHANGE bgcj018_2 name="input.g.page1.bgcj018_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj018_desc
            #add-point:BEFORE FIELD bgcj018_desc name="input.b.page1.bgcj018_desc"
            LET g_bgcj_d[l_ac].bgcj018_desc = g_bgcj_d[l_ac].bgcj018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj018_desc
            
            #add-point:AFTER FIELD bgcj018_desc name="input.a.page1.bgcj018_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj018_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj018_desc <> g_bgcj_d_t.bgcj018 OR cl_null(g_bgcj_d_t.bgcj018))) THEN
                  CALL s_azzi650_chk_exist('281',g_bgcj_d[l_ac].bgcj018_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_d[l_ac].bgcj018_desc = g_bgcj_d_t.bgcj018
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj018 = g_bgcj_d[l_ac].bgcj018_desc
               CALL s_desc_get_acc_desc('281',g_bgcj_d[l_ac].bgcj018) RETURNING g_bgcj_d[l_ac].bgcj018_desc
               LET g_bgcj_d[l_ac].bgcj018_desc = g_bgcj_d[l_ac].bgcj018,"  ",g_bgcj_d[l_ac].bgcj018_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj018 = g_bgcj_d[l_ac].bgcj018_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj018_desc
            #add-point:ON CHANGE bgcj018_desc name="input.g.page1.bgcj018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj019_2
            #add-point:BEFORE FIELD bgcj019_2 name="input.b.page1.bgcj019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj019_2
            
            #add-point:AFTER FIELD bgcj019_2 name="input.a.page1.bgcj019_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj019_2
            #add-point:ON CHANGE bgcj019_2 name="input.g.page1.bgcj019_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj019_desc
            #add-point:BEFORE FIELD bgcj019_desc name="input.b.page1.bgcj019_desc"
            LET g_bgcj_d[l_ac].bgcj019_desc = g_bgcj_d[l_ac].bgcj019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj019_desc
            
            #add-point:AFTER FIELD bgcj019_desc name="input.a.page1.bgcj019_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj019_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj019_desc <> g_bgcj_d_t.bgcj019 OR cl_null(g_bgcj_d_t.bgcj019))) THEN
                  CALL s_voucher_glaq024_chk(g_bgcj_d[l_ac].bgcj019_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj019_desc
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj019_desc = g_bgcj_d_t.bgcj019
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj019 = g_bgcj_d[l_ac].bgcj019_desc
               CALL s_desc_get_rtaxl003_desc(g_bgcj_d[l_ac].bgcj019) RETURNING g_bgcj_d[l_ac].bgcj019_desc
               LET g_bgcj_d[l_ac].bgcj019_desc = g_bgcj_d[l_ac].bgcj019,"  ",g_bgcj_d[l_ac].bgcj019_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj019 = g_bgcj_d[l_ac].bgcj019_desc
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj019_desc
            #add-point:ON CHANGE bgcj019_desc name="input.g.page1.bgcj019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj020_2
            #add-point:BEFORE FIELD bgcj020_2 name="input.b.page1.bgcj020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj020_2
            
            #add-point:AFTER FIELD bgcj020_2 name="input.a.page1.bgcj020_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj020_2
            #add-point:ON CHANGE bgcj020_2 name="input.g.page1.bgcj020_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj020_desc
            #add-point:BEFORE FIELD bgcj020_desc name="input.b.page1.bgcj020_desc"
            LET g_bgcj_d[l_ac].bgcj020_desc = g_bgcj_d[l_ac].bgcj020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj020_desc
            
            #add-point:AFTER FIELD bgcj020_desc name="input.a.page1.bgcj020_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj020_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj020_desc <> g_bgcj_d_t.bgcj020 OR cl_null(g_bgcj_d_t.bgcj020))) THEN
                  CALL s_aap_project_chk(g_bgcj_d[l_ac].bgcj020_desc) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj020_desc
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj020_desc = g_bgcj_d_t.bgcj020
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_bgcj_d[l_ac].bgcj020 = g_bgcj_d[l_ac].bgcj020_desc
               CALL s_desc_get_oojdl003_desc(g_bgcj_d[l_ac].bgcj020) RETURNING g_bgcj_d[l_ac].bgcj020_desc
               LET g_bgcj_d[l_ac].bgcj020_desc = g_bgcj_d[l_ac].bgcj020,"  ",g_bgcj_d[l_ac].bgcj020_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj020 = g_bgcj_d[l_ac].bgcj020_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj020_desc
            #add-point:ON CHANGE bgcj020_desc name="input.g.page1.bgcj020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj021_2
            #add-point:BEFORE FIELD bgcj021_2 name="input.b.page1.bgcj021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj021_2
            
            #add-point:AFTER FIELD bgcj021_2 name="input.a.page1.bgcj021_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj021_2
            #add-point:ON CHANGE bgcj021_2 name="input.g.page1.bgcj021_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj021_desc
            #add-point:BEFORE FIELD bgcj021_desc name="input.b.page1.bgcj021_desc"
            LET g_bgcj_d[l_ac].bgcj021_desc = g_bgcj_d[l_ac].bgcj021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj021_desc
            
            #add-point:AFTER FIELD bgcj021_desc name="input.a.page1.bgcj021_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj021_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj021_desc <> g_bgcj_d_t.bgcj021 OR cl_null(g_bgcj_d_t.bgcj021))) THEN
                  CALL s_voucher_glaq028_chk(g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj021_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj021_desc = g_bgcj_d_t.bgcj021
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj021 = g_bgcj_d[l_ac].bgcj021_desc
               CALL s_desc_get_wbs_desc(g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021) RETURNING g_bgcj_d[l_ac].bgcj021_desc
               LET g_bgcj_d[l_ac].bgcj021_desc = g_bgcj_d[l_ac].bgcj021,"  ",g_bgcj_d[l_ac].bgcj021_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj021 = g_bgcj_d[l_ac].bgcj021_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj021_desc
            #add-point:ON CHANGE bgcj021_desc name="input.g.page1.bgcj021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj022_2
            #add-point:BEFORE FIELD bgcj022_2 name="input.b.page1.bgcj022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj022_2
            
            #add-point:AFTER FIELD bgcj022_2 name="input.a.page1.bgcj022_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj022_2
            #add-point:ON CHANGE bgcj022_2 name="input.g.page1.bgcj022_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj023_2
            #add-point:BEFORE FIELD bgcj023_2 name="input.b.page1.bgcj023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj023_2
            
            #add-point:AFTER FIELD bgcj023_2 name="input.a.page1.bgcj023_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj023_2
            #add-point:ON CHANGE bgcj023_2 name="input.g.page1.bgcj023_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj023_desc
            #add-point:BEFORE FIELD bgcj023_desc name="input.b.page1.bgcj023_desc"
            LET g_bgcj_d[l_ac].bgcj023_desc = g_bgcj_d[l_ac].bgcj023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj023_desc
            
            #add-point:AFTER FIELD bgcj023_desc name="input.a.page1.bgcj023_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj023_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj023_desc <> g_bgcj_d_t.bgcj023 OR cl_null(g_bgcj_d_t.bgcj023))) THEN
                  CALL s_voucher_glaq052_chk(g_bgcj_d[l_ac].bgcj023_desc) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgcj_d[l_ac].bgcj023_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgcj_d[l_ac].bgcj023_desc = g_bgcj_d_t.bgcj023
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj023 = g_bgcj_d[l_ac].bgcj023_desc
               CALL s_desc_get_oojdl003_desc(g_bgcj_d[l_ac].bgcj023) RETURNING g_bgcj_d[l_ac].bgcj023_desc
               LET g_bgcj_d[l_ac].bgcj023_desc = g_bgcj_d[l_ac].bgcj023,"  ",g_bgcj_d[l_ac].bgcj023_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj023 = g_bgcj_d[l_ac].bgcj023_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj023_desc
            #add-point:ON CHANGE bgcj023_desc name="input.g.page1.bgcj023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj024_2
            #add-point:BEFORE FIELD bgcj024_2 name="input.b.page1.bgcj024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj024_2
            
            #add-point:AFTER FIELD bgcj024_2 name="input.a.page1.bgcj024_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj024_2
            #add-point:ON CHANGE bgcj024_2 name="input.g.page1.bgcj024_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj024_desc
            #add-point:BEFORE FIELD bgcj024_desc name="input.b.page1.bgcj024_desc"
            LET g_bgcj_d[l_ac].bgcj024_desc = g_bgcj_d[l_ac].bgcj024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj024_desc
            
            #add-point:AFTER FIELD bgcj024_desc name="input.a.page1.bgcj024_desc"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj024_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj024_desc <> g_bgcj_d_t.bgcj024 OR cl_null(g_bgcj_d_t.bgcj024))) THEN
                  CALL s_azzi650_chk_exist('2002',g_bgcj_d[l_ac].bgcj024_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgcj_d[l_ac].bgcj024_desc = g_bgcj_d_t.bgcj024
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgcj_d[l_ac].bgcj024 = g_bgcj_d[l_ac].bgcj024_desc
               CALL s_desc_get_acc_desc('2002',g_bgcj_d[l_ac].bgcj024) RETURNING g_bgcj_d[l_ac].bgcj024_desc
               LET g_bgcj_d[l_ac].bgcj024_desc = g_bgcj_d[l_ac].bgcj024,"  ",g_bgcj_d[l_ac].bgcj024_desc
            ELSE
               LET g_bgcj_d[l_ac].bgcj024 = g_bgcj_d[l_ac].bgcj024_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj024_desc
            #add-point:ON CHANGE bgcj024_desc name="input.g.page1.bgcj024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj035
            #add-point:BEFORE FIELD bgcj035 name="input.b.page1.bgcj035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj035
            
            #add-point:AFTER FIELD bgcj035 name="input.a.page1.bgcj035"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj035) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj035 <> g_bgcj_d_t.bgcj035 OR cl_null(g_bgcj_d_t.bgcj035))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  IF g_bgaw1[1] = 'Y' THEN
                     LET l_bgcj007 = g_bgcj_m.bgcj007
                  ELSE
                     LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
                  END IF
                  LET g_chkparam.arg1 = l_bgcj007
                  LET g_chkparam.arg2 = g_bgcj_d[l_ac].bgcj035
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_bgcj_d[l_ac].bgcj035 = g_bgcj_d_t.bgcj035
                     NEXT FIELD CURRENT
                  END IF
                  SELECT oodb005 INTO g_bgcj_d[l_ac].bgcj036 FROM oodb_t
                   WHERE oodbent=g_enterprise AND oodb002=g_bgcj_d[l_ac].bgcj035
                     AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_bgcj007)
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj035
            #add-point:ON CHANGE bgcj035 name="input.g.page1.bgcj035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj036
            #add-point:BEFORE FIELD bgcj036 name="input.b.page1.bgcj036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj036
            
            #add-point:AFTER FIELD bgcj036 name="input.a.page1.bgcj036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj036
            #add-point:ON CHANGE bgcj036 name="input.g.page1.bgcj036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj037
            #add-point:BEFORE FIELD bgcj037 name="input.b.page1.bgcj037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj037
            
            #add-point:AFTER FIELD bgcj037 name="input.a.page1.bgcj037"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj037) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj037 <> g_bgcj_d_t.bgcj037 OR cl_null(g_bgcj_d_t.bgcj037))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgcj_d[l_ac].bgcj037
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgcj_d[l_ac].bgcj037 = g_bgcj_d_t.bgcj037
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj037
            #add-point:ON CHANGE bgcj037 name="input.g.page1.bgcj037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj100
            #add-point:BEFORE FIELD bgcj100 name="input.b.page1.bgcj100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj100
            
            #add-point:AFTER FIELD bgcj100 name="input.a.page1.bgcj100"
            IF NOT cl_null(g_bgcj_d[l_ac].bgcj100) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].bgcj100 <> g_bgcj_d_t.bgcj100 OR cl_null(g_bgcj_d_t.bgcj100))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgcj_d[l_ac].bgcj100
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  IF NOT cl_chk_exist("v_ooai001") THEN
                     LET g_bgcj_d[l_ac].bgcj100 = g_bgcj_d_t.bgcj100
                     NEXT FIELD CURRENT
                  END IF
#                  CALL s_abg_get_bg_rate(g_bgcj_m.bgcj002,g_today,g_bgcj_d[l_ac].bgcj100,g_bgcj_m.bgaa003) RETURNING g_bgcj_d[l_ac].bgcj101 #161220-00036#1 mark
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj100
            #add-point:ON CHANGE bgcj100 name="input.g.page1.bgcj100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num1
            #add-point:BEFORE FIELD num1 name="input.b.page1.num1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num1
            
            #add-point:AFTER FIELD num1 name="input.a.page1.num1"
            IF NOT cl_null(g_bgcj_d[l_ac].num1) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num1 <> g_bgcj_d_t.num1 OR cl_null(g_bgcj_d_t.num1))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num1,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num1 = g_bgcj_d_t.num1
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price1) THEN
                     LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1 * g_bgcj_d[l_ac].price1
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt1,2) 
                        RETURNING g_bgcj_d[l_ac].amt1
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt1
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num1
            #add-point:ON CHANGE num1 name="input.g.page1.num1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price1
            #add-point:BEFORE FIELD price1 name="input.b.page1.price1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price1
            
            #add-point:AFTER FIELD price1 name="input.a.page1.price1"
            IF NOT cl_null(g_bgcj_d[l_ac].price1) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price1 <> g_bgcj_d_t.price1 OR cl_null(g_bgcj_d_t.price1))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price1,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price1 = g_bgcj_d_t.price1
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price1,1) 
                     RETURNING g_bgcj_d[l_ac].price1
                  IF NOT cl_null(g_bgcj_d[l_ac].num1) THEN
                     LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1 * g_bgcj_d[l_ac].price1
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt1,2) 
                        RETURNING g_bgcj_d[l_ac].amt1
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt1
                  END IF
               END IF
            END IF
           
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price1
            #add-point:ON CHANGE price1 name="input.g.page1.price1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt1
            #add-point:BEFORE FIELD amt1 name="input.b.page1.amt1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt1
            
            #add-point:AFTER FIELD amt1 name="input.a.page1.amt1"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt1
            #add-point:ON CHANGE amt1 name="input.g.page1.amt1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num2
            #add-point:BEFORE FIELD num2 name="input.b.page1.num2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num2
            
            #add-point:AFTER FIELD num2 name="input.a.page1.num2"
            IF NOT cl_null(g_bgcj_d[l_ac].num2) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num2 <> g_bgcj_d_t.num2 OR cl_null(g_bgcj_d_t.num2))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num2,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num2 = g_bgcj_d_t.num2
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price2) THEN
                     LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2 * g_bgcj_d[l_ac].price2
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt2,2) 
                        RETURNING g_bgcj_d[l_ac].amt2
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt2
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num2
            #add-point:ON CHANGE num2 name="input.g.page1.num2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price2
            #add-point:BEFORE FIELD price2 name="input.b.page1.price2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price2
            
            #add-point:AFTER FIELD price2 name="input.a.page1.price2"
            IF NOT cl_null(g_bgcj_d[l_ac].price2) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price2 <> g_bgcj_d_t.price2 OR cl_null(g_bgcj_d_t.price2))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price2,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price2 = g_bgcj_d_t.price2
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price2,1) 
                     RETURNING g_bgcj_d[l_ac].price2
                  IF NOT cl_null(g_bgcj_d[l_ac].num2) THEN
                     LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2 * g_bgcj_d[l_ac].price2
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt2,2) 
                        RETURNING g_bgcj_d[l_ac].amt2
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt2
                  END IF
               END IF
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price2
            #add-point:ON CHANGE price2 name="input.g.page1.price2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="input.b.page1.amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="input.a.page1.amt2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt2
            #add-point:ON CHANGE amt2 name="input.g.page1.amt2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num3
            #add-point:BEFORE FIELD num3 name="input.b.page1.num3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num3
            
            #add-point:AFTER FIELD num3 name="input.a.page1.num3"
            IF NOT cl_null(g_bgcj_d[l_ac].num3) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num3 <> g_bgcj_d_t.num3 OR cl_null(g_bgcj_d_t.num3))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num3,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num3 = g_bgcj_d_t.num3
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price3) THEN
                     LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3 * g_bgcj_d[l_ac].price3
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt3,2) 
                        RETURNING g_bgcj_d[l_ac].amt3
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt3
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num3
            #add-point:ON CHANGE num3 name="input.g.page1.num3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price3
            #add-point:BEFORE FIELD price3 name="input.b.page1.price3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price3
            
            #add-point:AFTER FIELD price3 name="input.a.page1.price3"
            IF NOT cl_null(g_bgcj_d[l_ac].price3) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price3 <> g_bgcj_d_t.price3 OR cl_null(g_bgcj_d_t.price3))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price3,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price3 = g_bgcj_d_t.price3
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price3,1) 
                     RETURNING g_bgcj_d[l_ac].price3
                  IF NOT cl_null(g_bgcj_d[l_ac].num3) THEN
                     LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3 * g_bgcj_d[l_ac].price3
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt3,2) 
                        RETURNING g_bgcj_d[l_ac].amt3
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt3
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price3
            #add-point:ON CHANGE price3 name="input.g.page1.price3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt3
            #add-point:BEFORE FIELD amt3 name="input.b.page1.amt3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt3
            
            #add-point:AFTER FIELD amt3 name="input.a.page1.amt3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt3
            #add-point:ON CHANGE amt3 name="input.g.page1.amt3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num4
            #add-point:BEFORE FIELD num4 name="input.b.page1.num4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num4
            
            #add-point:AFTER FIELD num4 name="input.a.page1.num4"
            IF NOT cl_null(g_bgcj_d[l_ac].num4) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num4 <> g_bgcj_d_t.num4 OR cl_null(g_bgcj_d_t.num4))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num4,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num4 = g_bgcj_d_t.num4
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price4) THEN
                     LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4 * g_bgcj_d[l_ac].price4
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt4,2) 
                        RETURNING g_bgcj_d[l_ac].amt4
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt4
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num4
            #add-point:ON CHANGE num4 name="input.g.page1.num4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price4
            #add-point:BEFORE FIELD price4 name="input.b.page1.price4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price4
            
            #add-point:AFTER FIELD price4 name="input.a.page1.price4"
            IF NOT cl_null(g_bgcj_d[l_ac].price4) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price4 <> g_bgcj_d_t.price4 OR cl_null(g_bgcj_d_t.price4))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price4,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price4 = g_bgcj_d_t.price4
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price4,1) 
                     RETURNING g_bgcj_d[l_ac].price4
                  IF NOT cl_null(g_bgcj_d[l_ac].num4) THEN
                     LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4 * g_bgcj_d[l_ac].price4
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt4,2) 
                        RETURNING g_bgcj_d[l_ac].amt4
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt4
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price4
            #add-point:ON CHANGE price4 name="input.g.page1.price4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt4
            #add-point:BEFORE FIELD amt4 name="input.b.page1.amt4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt4
            
            #add-point:AFTER FIELD amt4 name="input.a.page1.amt4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt4
            #add-point:ON CHANGE amt4 name="input.g.page1.amt4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num5
            #add-point:BEFORE FIELD num5 name="input.b.page1.num5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num5
            
            #add-point:AFTER FIELD num5 name="input.a.page1.num5"
            IF NOT cl_null(g_bgcj_d[l_ac].num5) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num5 <> g_bgcj_d_t.num5 OR cl_null(g_bgcj_d_t.num5))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num5,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num5 = g_bgcj_d_t.num5
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price5) THEN
                     LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5 * g_bgcj_d[l_ac].price5
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt5,2) 
                        RETURNING g_bgcj_d[l_ac].amt5
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt5
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num5
            #add-point:ON CHANGE num5 name="input.g.page1.num5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price5
            #add-point:BEFORE FIELD price5 name="input.b.page1.price5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price5
            
            #add-point:AFTER FIELD price5 name="input.a.page1.price5"
            IF NOT cl_null(g_bgcj_d[l_ac].price5) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price5 <> g_bgcj_d_t.price5 OR cl_null(g_bgcj_d_t.price5))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price5,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price5 = g_bgcj_d_t.price5
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price5,1) 
                     RETURNING g_bgcj_d[l_ac].price5
                  IF NOT cl_null(g_bgcj_d[l_ac].num5) THEN
                     LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5 * g_bgcj_d[l_ac].price5
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt5,2) 
                        RETURNING g_bgcj_d[l_ac].amt5
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt5
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price5
            #add-point:ON CHANGE price5 name="input.g.page1.price5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt5
            #add-point:BEFORE FIELD amt5 name="input.b.page1.amt5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt5
            
            #add-point:AFTER FIELD amt5 name="input.a.page1.amt5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt5
            #add-point:ON CHANGE amt5 name="input.g.page1.amt5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num6
            #add-point:BEFORE FIELD num6 name="input.b.page1.num6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num6
            
            #add-point:AFTER FIELD num6 name="input.a.page1.num6"
            IF NOT cl_null(g_bgcj_d[l_ac].num6) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num6 <> g_bgcj_d_t.num6 OR cl_null(g_bgcj_d_t.num6))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num6,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num6 = g_bgcj_d_t.num6
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price6) THEN
                     LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6 * g_bgcj_d[l_ac].price6
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt6,2) 
                        RETURNING g_bgcj_d[l_ac].amt6
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt6
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num6
            #add-point:ON CHANGE num6 name="input.g.page1.num6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price6
            #add-point:BEFORE FIELD price6 name="input.b.page1.price6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price6
            
            #add-point:AFTER FIELD price6 name="input.a.page1.price6"
            IF NOT cl_null(g_bgcj_d[l_ac].price6) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price6 <> g_bgcj_d_t.price6 OR cl_null(g_bgcj_d_t.price6))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price6,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price6 = g_bgcj_d_t.price6
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price6,1) 
                     RETURNING g_bgcj_d[l_ac].price6
                  IF NOT cl_null(g_bgcj_d[l_ac].num6) THEN
                     LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6 * g_bgcj_d[l_ac].price6
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt6,2) 
                        RETURNING g_bgcj_d[l_ac].amt6
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt6
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price6
            #add-point:ON CHANGE price6 name="input.g.page1.price6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt6
            #add-point:BEFORE FIELD amt6 name="input.b.page1.amt6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt6
            
            #add-point:AFTER FIELD amt6 name="input.a.page1.amt6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt6
            #add-point:ON CHANGE amt6 name="input.g.page1.amt6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num7
            #add-point:BEFORE FIELD num7 name="input.b.page1.num7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num7
            
            #add-point:AFTER FIELD num7 name="input.a.page1.num7"
            IF NOT cl_null(g_bgcj_d[l_ac].num7) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num7 <> g_bgcj_d_t.num7 OR cl_null(g_bgcj_d_t.num7))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num7,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num7 = g_bgcj_d_t.num7
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price7) THEN
                     LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7 * g_bgcj_d[l_ac].price7
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt7,2) 
                        RETURNING g_bgcj_d[l_ac].amt7
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt7
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num7
            #add-point:ON CHANGE num7 name="input.g.page1.num7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price7
            #add-point:BEFORE FIELD price7 name="input.b.page1.price7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price7
            
            #add-point:AFTER FIELD price7 name="input.a.page1.price7"
            IF NOT cl_null(g_bgcj_d[l_ac].price7) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price7 <> g_bgcj_d_t.price7 OR cl_null(g_bgcj_d_t.price7))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price7,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price7 = g_bgcj_d_t.price7
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price7,1) 
                     RETURNING g_bgcj_d[l_ac].price7
                  IF NOT cl_null(g_bgcj_d[l_ac].num7) THEN
                     LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7 * g_bgcj_d[l_ac].price7
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt7,2) 
                        RETURNING g_bgcj_d[l_ac].amt7
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt7
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price7
            #add-point:ON CHANGE price7 name="input.g.page1.price7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt7
            #add-point:BEFORE FIELD amt7 name="input.b.page1.amt7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt7
            
            #add-point:AFTER FIELD amt7 name="input.a.page1.amt7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt7
            #add-point:ON CHANGE amt7 name="input.g.page1.amt7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num8
            #add-point:BEFORE FIELD num8 name="input.b.page1.num8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num8
            
            #add-point:AFTER FIELD num8 name="input.a.page1.num8"
            IF NOT cl_null(g_bgcj_d[l_ac].num8) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num8 <> g_bgcj_d_t.num8 OR cl_null(g_bgcj_d_t.num8))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num8,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num8 = g_bgcj_d_t.num8
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price8) THEN
                     LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8 * g_bgcj_d[l_ac].price8
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt8,2) 
                        RETURNING g_bgcj_d[l_ac].amt8
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt8
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num8
            #add-point:ON CHANGE num8 name="input.g.page1.num8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price8
            #add-point:BEFORE FIELD price8 name="input.b.page1.price8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price8
            
            #add-point:AFTER FIELD price8 name="input.a.page1.price8"
            IF NOT cl_null(g_bgcj_d[l_ac].price8) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price8 <> g_bgcj_d_t.price8 OR cl_null(g_bgcj_d_t.price8))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price8,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price8 = g_bgcj_d_t.price8
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price8,1) 
                     RETURNING g_bgcj_d[l_ac].price8
                  IF NOT cl_null(g_bgcj_d[l_ac].num8) THEN
                     LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8 * g_bgcj_d[l_ac].price8
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt8,2) 
                        RETURNING g_bgcj_d[l_ac].amt8
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt8
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price8
            #add-point:ON CHANGE price8 name="input.g.page1.price8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt8
            #add-point:BEFORE FIELD amt8 name="input.b.page1.amt8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt8
            
            #add-point:AFTER FIELD amt8 name="input.a.page1.amt8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt8
            #add-point:ON CHANGE amt8 name="input.g.page1.amt8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num9
            #add-point:BEFORE FIELD num9 name="input.b.page1.num9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num9
            
            #add-point:AFTER FIELD num9 name="input.a.page1.num9"
            IF NOT cl_null(g_bgcj_d[l_ac].num9) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num9 <> g_bgcj_d_t.num9 OR cl_null(g_bgcj_d_t.num9))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num9,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num9 = g_bgcj_d_t.num9
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price9) THEN
                     LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9 * g_bgcj_d[l_ac].price9
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt9,2) 
                        RETURNING g_bgcj_d[l_ac].amt9
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt9
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num9
            #add-point:ON CHANGE num9 name="input.g.page1.num9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price9
            #add-point:BEFORE FIELD price9 name="input.b.page1.price9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price9
            
            #add-point:AFTER FIELD price9 name="input.a.page1.price9"
            IF NOT cl_null(g_bgcj_d[l_ac].price9) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price9 <> g_bgcj_d_t.price9 OR cl_null(g_bgcj_d_t.price9))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price9,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price9 = g_bgcj_d_t.price9
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price9,1) 
                     RETURNING g_bgcj_d[l_ac].price9
                  IF NOT cl_null(g_bgcj_d[l_ac].num9) THEN
                     LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9 * g_bgcj_d[l_ac].price9
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt9,2) 
                        RETURNING g_bgcj_d[l_ac].amt9
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt9
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price9
            #add-point:ON CHANGE price9 name="input.g.page1.price9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt9
            #add-point:BEFORE FIELD amt9 name="input.b.page1.amt9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt9
            
            #add-point:AFTER FIELD amt9 name="input.a.page1.amt9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt9
            #add-point:ON CHANGE amt9 name="input.g.page1.amt9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num10
            #add-point:BEFORE FIELD num10 name="input.b.page1.num10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num10
            
            #add-point:AFTER FIELD num10 name="input.a.page1.num10"
            IF NOT cl_null(g_bgcj_d[l_ac].num10) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num10 <> g_bgcj_d_t.num10 OR cl_null(g_bgcj_d_t.num10))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num10,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num10 = g_bgcj_d_t.num10
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price10) THEN
                     LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10 * g_bgcj_d[l_ac].price10
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt10,2) 
                        RETURNING g_bgcj_d[l_ac].amt10
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt10
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num10
            #add-point:ON CHANGE num10 name="input.g.page1.num10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price10
            #add-point:BEFORE FIELD price10 name="input.b.page1.price10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price10
            
            #add-point:AFTER FIELD price10 name="input.a.page1.price10"
            IF NOT cl_null(g_bgcj_d[l_ac].price10) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price10 <> g_bgcj_d_t.price10 OR cl_null(g_bgcj_d_t.price10))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price10,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price10 = g_bgcj_d_t.price10
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price10,1) 
                     RETURNING g_bgcj_d[l_ac].price10
                  IF NOT cl_null(g_bgcj_d[l_ac].num10) THEN
                     LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10 * g_bgcj_d[l_ac].price10
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt10,2) 
                        RETURNING g_bgcj_d[l_ac].amt10
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt10
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price10
            #add-point:ON CHANGE price10 name="input.g.page1.price10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt10
            #add-point:BEFORE FIELD amt10 name="input.b.page1.amt10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt10
            
            #add-point:AFTER FIELD amt10 name="input.a.page1.amt10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt10
            #add-point:ON CHANGE amt10 name="input.g.page1.amt10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num11
            #add-point:BEFORE FIELD num11 name="input.b.page1.num11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num11
            
            #add-point:AFTER FIELD num11 name="input.a.page1.num11"
            IF NOT cl_null(g_bgcj_d[l_ac].num11) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num11 <> g_bgcj_d_t.num11 OR cl_null(g_bgcj_d_t.num11))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num11,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num11 = g_bgcj_d_t.num11
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price11) THEN
                     LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11 * g_bgcj_d[l_ac].price11
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt11,2) 
                        RETURNING g_bgcj_d[l_ac].amt11
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt11
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num11
            #add-point:ON CHANGE num11 name="input.g.page1.num11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price11
            #add-point:BEFORE FIELD price11 name="input.b.page1.price11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price11
            
            #add-point:AFTER FIELD price11 name="input.a.page1.price11"
            IF NOT cl_null(g_bgcj_d[l_ac].price11) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price11 <> g_bgcj_d_t.price11 OR cl_null(g_bgcj_d_t.price11))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price11,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price11 = g_bgcj_d_t.price11
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price11,1) 
                     RETURNING g_bgcj_d[l_ac].price11
                  IF NOT cl_null(g_bgcj_d[l_ac].num11) THEN
                     LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11 * g_bgcj_d[l_ac].price11
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt11,2) 
                        RETURNING g_bgcj_d[l_ac].amt11
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt11
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price11
            #add-point:ON CHANGE price11 name="input.g.page1.price11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt11
            #add-point:BEFORE FIELD amt11 name="input.b.page1.amt11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt11
            
            #add-point:AFTER FIELD amt11 name="input.a.page1.amt11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt11
            #add-point:ON CHANGE amt11 name="input.g.page1.amt11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num12
            #add-point:BEFORE FIELD num12 name="input.b.page1.num12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num12
            
            #add-point:AFTER FIELD num12 name="input.a.page1.num12"
            IF NOT cl_null(g_bgcj_d[l_ac].num12) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num12 <> g_bgcj_d_t.num12 OR cl_null(g_bgcj_d_t.num12))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num12,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num12 = g_bgcj_d_t.num12
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price12) THEN
                     LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12 * g_bgcj_d[l_ac].price12
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt12,2) 
                        RETURNING g_bgcj_d[l_ac].amt12
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt12
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num12
            #add-point:ON CHANGE num12 name="input.g.page1.num12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price12
            #add-point:BEFORE FIELD price12 name="input.b.page1.price12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price12
            
            #add-point:AFTER FIELD price12 name="input.a.page1.price12"
            IF NOT cl_null(g_bgcj_d[l_ac].price12) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price12 <> g_bgcj_d_t.price12 OR cl_null(g_bgcj_d_t.price12))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price12,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price12 = g_bgcj_d_t.price12
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price12,1) 
                     RETURNING g_bgcj_d[l_ac].price12
                  IF NOT cl_null(g_bgcj_d[l_ac].num12) THEN
                     LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12 * g_bgcj_d[l_ac].price12
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt12,2) 
                        RETURNING g_bgcj_d[l_ac].amt12
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt12
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price12
            #add-point:ON CHANGE price12 name="input.g.page1.price12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt12
            #add-point:BEFORE FIELD amt12 name="input.b.page1.amt12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt12
            
            #add-point:AFTER FIELD amt12 name="input.a.page1.amt12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt12
            #add-point:ON CHANGE amt12 name="input.g.page1.amt12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num13
            #add-point:BEFORE FIELD num13 name="input.b.page1.num13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num13
            
            #add-point:AFTER FIELD num13 name="input.a.page1.num13"
            IF NOT cl_null(g_bgcj_d[l_ac].num13) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].num13 <> g_bgcj_d_t.num13 OR cl_null(g_bgcj_d_t.num13))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].num13,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].num13 = g_bgcj_d_t.num13
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgcj_d[l_ac].price13) THEN
                     LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13 * g_bgcj_d[l_ac].price13
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt13,2) 
                        RETURNING g_bgcj_d[l_ac].amt13
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt13
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num13
            #add-point:ON CHANGE num13 name="input.g.page1.num13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price13
            #add-point:BEFORE FIELD price13 name="input.b.page1.price13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price13
            
            #add-point:AFTER FIELD price13 name="input.a.page1.price13"
            IF NOT cl_null(g_bgcj_d[l_ac].price13) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgcj_d[l_ac].price13 <> g_bgcj_d_t.price13 OR cl_null(g_bgcj_d_t.price13))) THEN
                  IF NOT cl_ap_chk_Range(g_bgcj_d[l_ac].price13,"0","1","","","azz-00079",1) THEN
                     LET g_bgcj_d[l_ac].price13 = g_bgcj_d_t.price13
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].price13,1) 
                     RETURNING g_bgcj_d[l_ac].price13
                  IF NOT cl_null(g_bgcj_d[l_ac].num13) THEN
                     LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13 * g_bgcj_d[l_ac].price13
                     CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].amt13,2) 
                        RETURNING g_bgcj_d[l_ac].amt13
                     DISPLAY BY NAME g_bgcj_d[l_ac].amt13
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price13
            #add-point:ON CHANGE price13 name="input.g.page1.price13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt13
            #add-point:BEFORE FIELD amt13 name="input.b.page1.amt13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt13
            
            #add-point:AFTER FIELD amt13 name="input.a.page1.amt13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt13
            #add-point:ON CHANGE amt13 name="input.g.page1.amt13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj008
            #add-point:BEFORE FIELD bgcj008 name="input.b.page1.bgcj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj008
            
            #add-point:AFTER FIELD bgcj008 name="input.a.page1.bgcj008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_m.bgcj001 IS NOT NULL AND g_bgcj_m.bgcj002 IS NOT NULL AND g_bgcj_m.bgcj003 IS NOT NULL AND g_bgcj_m.bgcj004 IS NOT NULL AND g_bgcj_m.bgcj005 IS NOT NULL AND g_bgcj_m.bgcj006 IS NOT NULL AND g_bgcj_m.bgcj007 IS NOT NULL AND g_bgcj_m.bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_m.bgcj001 != g_bgcj001_t OR g_bgcj_m.bgcj002 != g_bgcj002_t OR g_bgcj_m.bgcj003 != g_bgcj003_t OR g_bgcj_m.bgcj004 != g_bgcj004_t OR g_bgcj_m.bgcj005 != g_bgcj005_t OR g_bgcj_m.bgcj006 != g_bgcj006_t OR g_bgcj_m.bgcj007 != g_bgcj007_t OR g_bgcj_m.bgcj009 != g_bgcj009_t OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_m.bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_m.bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_m.bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_m.bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_m.bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_m.bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_m.bgcj007 ||"' AND "|| "bgcj009 = '"||g_bgcj_m.bgcj009 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj008
            #add-point:ON CHANGE bgcj008 name="input.g.page1.bgcj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj047
            #add-point:BEFORE FIELD bgcj047 name="input.b.page1.bgcj047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj047
            
            #add-point:AFTER FIELD bgcj047 name="input.a.page1.bgcj047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj047
            #add-point:ON CHANGE bgcj047 name="input.g.page1.bgcj047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj048
            #add-point:BEFORE FIELD bgcj048 name="input.b.page1.bgcj048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj048
            
            #add-point:AFTER FIELD bgcj048 name="input.a.page1.bgcj048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj048
            #add-point:ON CHANGE bgcj048 name="input.g.page1.bgcj048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj050
            #add-point:BEFORE FIELD bgcj050 name="input.b.page1.bgcj050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj050
            
            #add-point:AFTER FIELD bgcj050 name="input.a.page1.bgcj050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj050
            #add-point:ON CHANGE bgcj050 name="input.g.page1.bgcj050"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgcjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjseq
            #add-point:ON ACTION controlp INFIELD bgcjseq name="input.c.page1.bgcjseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj010_2
            #add-point:ON ACTION controlp INFIELD bgcj010_2 name="input.c.page1.bgcj010_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj007_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007_2
            #add-point:ON ACTION controlp INFIELD bgcj007_2 name="input.c.page1.bgcj007_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj007            #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj007 = g_qryparam.return1              
            #LET g_bgcj_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj007 TO bgcj007_2              #
            #DISPLAY g_bgcj_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgcj007_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007_desc
            #add-point:ON ACTION controlp INFIELD bgcj007_desc name="input.c.page1.bgcj007_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj007_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " ooef205 = 'Y'"
#            #1.抓取預算組織對應最上層組織及版本
#            SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
#             WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002
#            #根據預算最上層組織+版本抓取有權限據點
#            CALL s_abg2_get_site_role('4','',g_user,g_dept,'',l_bgaa011,l_bgaa010)
#            #有權限組織組成字串用,分開
#            CALL s_abg2_get_budget_sons_str()RETURNING l_origin_str
#            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
#            LET g_qryparam.where = " ooef001 IN ",l_origin_str 
            
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgcj_m.bgcj002,g_bgcj_m.bgcj004,g_user,'01') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj007_desc = g_qryparam.return1              
            #LET g_bgcj_d[l_ac].ooef001 = g_qryparam.return2 
            LET g_bgcj_d[l_ac].bgcj007 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj007_desc TO bgcj007_desc              #
            #DISPLAY g_bgcj_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgcj007_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009_2
            #add-point:ON ACTION controlp INFIELD bgcj009_2 name="input.c.page1.bgcj009_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj009 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj009 TO bgcj009_2              #

            NEXT FIELD bgcj009_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009_desc
            #add-point:ON ACTION controlp INFIELD bgcj009_desc name="input.c.page1.bgcj009_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj009_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #销售方式1.外部订单
            IF g_bgcj_m.bgcj005 = '1' THEN
               LET g_qryparam.where = " bgas001 IN (SELECT bgea003 FROM bgea_t ",
                                      "              WHERE bgeaent=",g_enterprise," AND bgeastus='Y' "
               IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND bgea001='",g_bgcj_m.bgcj002,"' "
               END IF
               #预算组织在单头
               IF g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET g_qryparam.where = g_qryparam.where," AND bgea002='",g_bgcj_m.bgcj007,"' "
               END IF
               #预算组织在单身
               IF g_bgaw2[1]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  LET g_qryparam.where = g_qryparam.where," AND bgea002='",g_bgcj_d[l_ac].bgcj007,"' "
               END IF
               LET g_qryparam.where = g_qryparam.where," )"
               CALL q_bgas001() 
               LET g_bgcj_m.bgcj009 = g_qryparam.return1              
            END IF
            #销售方式4.招商收入
            IF g_bgcj_m.bgcj005 = '4' THEN
               IF NOT cl_null(g_bgcj_m.bgcj002) THEN
                  SELECT bgaa008 INTO g_bgaa008 FROM bgaa_t 
                   WHERE bgaaent=g_enterprise AND bgaa001=g_bgcj_m.bgcj002 AND bgaastus='Y'
                  LET g_qryparam.where = " bgcc001 IN (SELECT bgce002 FROM bgce_t ",
                                         "              WHERE bgceent=",g_enterprise,
                                         "                AND bgce001='",g_bgaa008,"'",
                                         "                AND bgcestus='Y' )"
               END IF
               CALL q_bgcc001() 
               LET g_bgcj_m.bgcj009 = g_qryparam.return1              
            END IF
 
            LET g_bgcj_d[l_ac].bgcj009_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj009 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj009_desc TO bgcj009_desc              #

            NEXT FIELD bgcj009_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj049
            #add-point:ON ACTION controlp INFIELD bgcj049 name="input.c.page1.bgcj049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj012_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj012_2
            #add-point:ON ACTION controlp INFIELD bgcj012_2 name="input.c.page1.bgcj012_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj012 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj012 TO bgcj012_2              #

            NEXT FIELD bgcj012_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj012_desc
            #add-point:ON ACTION controlp INFIELD bgcj012_desc name="input.c.page1.bgcj012_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj012_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  LET l_ooef001 = g_bgcj_d[l_ac].bgcj007
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
 
            LET g_bgcj_d[l_ac].bgcj012_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj012 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj012_desc TO bgcj012_desc              #

            NEXT FIELD bgcj012_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj013_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj013_2
            #add-point:ON ACTION controlp INFIELD bgcj013_2 name="input.c.page1.bgcj013_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  LET l_ooef001 = g_bgcj_d[l_ac].bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "
 
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj013 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj013 TO bgcj013_2              #

            NEXT FIELD bgcj013_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj013_desc
            #add-point:ON ACTION controlp INFIELD bgcj013_desc name="input.c.page1.bgcj013_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj013_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  LET l_ooef001 = g_bgcj_d[l_ac].bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "

 
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj013_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj013 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj013_desc TO bgcj013_desc              #

            NEXT FIELD bgcj013_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj014_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj014_2
            #add-point:ON ACTION controlp INFIELD bgcj014_2 name="input.c.page1.bgcj014_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  LET l_ooef001 = g_bgcj_d[l_ac].bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "
 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj014 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj014 TO bgcj014_2              #

            NEXT FIELD bgcj014_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj014_desc
            #add-point:ON ACTION controlp INFIELD bgcj014_desc name="input.c.page1.bgcj014_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj014_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgcj_m.bgcj007) THEN
                  LET l_ooef001 = g_bgcj_m.bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  LET l_ooef001 = g_bgcj_d[l_ac].bgcj007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "

 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj014_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj014 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj014_desc TO bgcj014_desc              #

            NEXT FIELD bgcj014_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj015_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj015_2
            #add-point:ON ACTION controlp INFIELD bgcj015_2 name="input.c.page1.bgcj015_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj015            #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj015 = g_qryparam.return1              
            #LET g_bgcj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj015 TO bgcj015_2              #
            #DISPLAY g_bgcj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj015_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj015_desc
            #add-point:ON ACTION controlp INFIELD bgcj015_desc name="input.c.page1.bgcj015_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj015_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj015_desc = g_qryparam.return1 
            LET g_bgcj_d[l_ac].bgcj015 = g_qryparam.return1
            #LET g_bgcj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj015_desc TO bgcj015_desc              #
            #DISPLAY g_bgcj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj015_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj016_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016_2
            #add-point:ON ACTION controlp INFIELD bgcj016_2 name="input.c.page1.bgcj016_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj016 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj016 TO bgcj016_2              #

            NEXT FIELD bgcj016_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016_desc
            #add-point:ON ACTION controlp INFIELD bgcj016_desc name="input.c.page1.bgcj016_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj016_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            LET l_bgcj007 = ''
            #当预算组织在单头
            IF g_bgaw1[1]='Y' THEN
               LET l_bgcj007 = g_bgcj_m.bgcj007
            END IF
            #当预算组织在单身
            IF g_bgaw2[1]='Y' THEN
               LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgcj007,"')"
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj016_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj016 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj016_desc TO bgcj016_desc              #

            NEXT FIELD bgcj016_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj017_2
            #add-point:ON ACTION controlp INFIELD bgcj017_2 name="input.c.page1.bgcj017_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj017 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj017 TO bgcj017_2              #

            NEXT FIELD bgcj017_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj017_desc
            #add-point:ON ACTION controlp INFIELD bgcj017_desc name="input.c.page1.bgcj017_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj017_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            LET l_bgcj007 = ''
            #当预算组织在单头
            IF g_bgaw1[1]='Y' AND NOT cl_null(g_bgcj_m.bgcj007) THEN
               LET l_bgcj007 = g_bgcj_m.bgcj007
            END IF
            #当预算组织在单身
            IF g_bgaw2[1]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
               LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
            END IF
            IF NOT cl_null(l_bgcj007) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                      "                  WHERE bgaqent=",g_enterprise,
                                      "                    AND bgaqsite='",l_bgcj007,"')"
            END IF
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj017_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj017 = g_qryparam.return1 
            DISPLAY g_bgcj_d[l_ac].bgcj017_desc TO bgcj017_desc              #

            NEXT FIELD bgcj017_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj018_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj018_2
            #add-point:ON ACTION controlp INFIELD bgcj018_2 name="input.c.page1.bgcj018_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj018             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj018 = g_qryparam.return1              
            #LET g_bgcj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj018 TO bgcj018_2              #
            #DISPLAY g_bgcj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj018_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj018_desc
            #add-point:ON ACTION controlp INFIELD bgcj018_desc name="input.c.page1.bgcj018_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj018_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj018_desc = g_qryparam.return1
            LET g_bgcj_d[l_ac].bgcj018 = g_qryparam.return1            
            #LET g_bgcj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj018_desc TO bgcj018_desc              #
            #DISPLAY g_bgcj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj018_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj019_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj019_2
            #add-point:ON ACTION controlp INFIELD bgcj019_2 name="input.c.page1.bgcj019_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj019 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj019 TO bgcj019_2              #

            NEXT FIELD bgcj019_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj019_desc
            #add-point:ON ACTION controlp INFIELD bgcj019_desc name="input.c.page1.bgcj019_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj019_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj019_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj019 = g_qryparam.return1 
            DISPLAY g_bgcj_d[l_ac].bgcj019_desc TO bgcj019_desc              #

            NEXT FIELD bgcj019_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj020_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj020_2
            #add-point:ON ACTION controlp INFIELD bgcj020_2 name="input.c.page1.bgcj020_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj020 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj020 TO bgcj020_2              #

            NEXT FIELD bgcj020_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj020_desc
            #add-point:ON ACTION controlp INFIELD bgcj020_desc name="input.c.page1.bgcj020_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj020_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj020_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj020 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj020_desc TO bgcj020_desc              #

            NEXT FIELD bgcj020_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj021_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj021_2
            #add-point:ON ACTION controlp INFIELD bgcj021_2 name="input.c.page1.bgcj021_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj021 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj021 TO bgcj021_2              #

            NEXT FIELD bgcj021_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj021_desc
            #add-point:ON ACTION controlp INFIELD bgcj021_desc name="input.c.page1.bgcj021_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj021_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = "pjbb012='1'"
            IF g_bgaw1[14]='Y' AND NOT cl_null(g_bgcj_m.bgcj020) THEN
               LET g_qryparam.where = g_qryparam.where," AND pjbb001='",g_bgcj_m.bgcj020,"'"
            END IF
            IF g_bgaw2[14]='Y' AND NOT cl_null(g_bgcj_d[l_ac].bgcj020) THEN
               LET g_qryparam.where = g_qryparam.where," AND pjbb001='",g_bgcj_d[l_ac].bgcj020,"'"
            END IF
 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj021_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj021 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj021_desc TO bgcj021_desc              #

            NEXT FIELD bgcj021_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj022_2
            #add-point:ON ACTION controlp INFIELD bgcj022_2 name="input.c.page1.bgcj022_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj023_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj023_2
            #add-point:ON ACTION controlp INFIELD bgcj023_2 name="input.c.page1.bgcj023_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj023 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj023 TO bgcj023_2              #

            NEXT FIELD bgcj023_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj023_desc
            #add-point:ON ACTION controlp INFIELD bgcj023_desc name="input.c.page1.bgcj023_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj023_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj023_desc = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj023 = g_qryparam.return1
            DISPLAY g_bgcj_d[l_ac].bgcj023_desc TO bgcj023_desc              #

            NEXT FIELD bgcj023_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj024_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj024_2
            #add-point:ON ACTION controlp INFIELD bgcj024_2 name="input.c.page1.bgcj024_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj024             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj024 = g_qryparam.return1            
            #LET g_bgcj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj024 TO bgcj024_2              #
            #DISPLAY g_bgcj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj024_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj024_desc
            #add-point:ON ACTION controlp INFIELD bgcj024_desc name="input.c.page1.bgcj024_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj024_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj024_desc = g_qryparam.return1
            LET g_bgcj_d[l_ac].bgcj024 = g_qryparam.return1            
            #LET g_bgcj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj024_desc TO bgcj024_desc              #
            #DISPLAY g_bgcj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgcj024_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj035
            #add-point:ON ACTION controlp INFIELD bgcj035 name="input.c.page1.bgcj035"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj035             #給予default值
            LET g_qryparam.default2 = g_bgcj_d[l_ac].bgcj036 #含稅否
            LET g_qryparam.default3 = "" #g_bgcj_d[l_ac].oodb006 #稅率
            LET g_qryparam.default4 = "" #g_bgcj_d[l_ac].oodbl004 #說明
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgcj_m.bgcj007
            ELSE
               IF NOT cl_null(g_bgcj_d[l_ac].bgcj007) THEN
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgcj_d[l_ac].bgcj007
               ELSE
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site
               END IF
            END IF
            
            #給予arg
            LET g_qryparam.arg1 =l_ooef019
            
 
            CALL q_oodb002_5()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj035 = g_qryparam.return1              
            LET g_bgcj_d[l_ac].bgcj036 = g_qryparam.return2 
            #LET g_bgcj_d[l_ac].oodb006 = g_qryparam.return3 
            #LET g_bgcj_d[l_ac].oodbl004 = g_qryparam.return4 
            DISPLAY g_bgcj_d[l_ac].bgcj035 TO bgcj035              #
            DISPLAY g_bgcj_d[l_ac].bgcj036 TO bgcj036 #含稅否
            #DISPLAY g_bgcj_d[l_ac].oodb006 TO oodb006 #稅率
            #DISPLAY g_bgcj_d[l_ac].oodbl004 TO oodbl004 #說明
            NEXT FIELD bgcj035                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj036
            #add-point:ON ACTION controlp INFIELD bgcj036 name="input.c.page1.bgcj036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj037
            #add-point:ON ACTION controlp INFIELD bgcj037 name="input.c.page1.bgcj037"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj037             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj037 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj037 TO bgcj037              #

            NEXT FIELD bgcj037                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj100
            #add-point:ON ACTION controlp INFIELD bgcj100 name="input.c.page1.bgcj100"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj100 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj100 TO bgcj100              #

            NEXT FIELD bgcj100                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.num1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num1
            #add-point:ON ACTION controlp INFIELD num1 name="input.c.page1.num1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price1
            #add-point:ON ACTION controlp INFIELD price1 name="input.c.page1.price1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt1
            #add-point:ON ACTION controlp INFIELD amt1 name="input.c.page1.amt1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num2
            #add-point:ON ACTION controlp INFIELD num2 name="input.c.page1.num2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price2
            #add-point:ON ACTION controlp INFIELD price2 name="input.c.page1.price2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="input.c.page1.amt2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num3
            #add-point:ON ACTION controlp INFIELD num3 name="input.c.page1.num3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price3
            #add-point:ON ACTION controlp INFIELD price3 name="input.c.page1.price3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt3
            #add-point:ON ACTION controlp INFIELD amt3 name="input.c.page1.amt3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num4
            #add-point:ON ACTION controlp INFIELD num4 name="input.c.page1.num4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price4
            #add-point:ON ACTION controlp INFIELD price4 name="input.c.page1.price4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt4
            #add-point:ON ACTION controlp INFIELD amt4 name="input.c.page1.amt4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num5
            #add-point:ON ACTION controlp INFIELD num5 name="input.c.page1.num5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price5
            #add-point:ON ACTION controlp INFIELD price5 name="input.c.page1.price5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt5
            #add-point:ON ACTION controlp INFIELD amt5 name="input.c.page1.amt5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num6
            #add-point:ON ACTION controlp INFIELD num6 name="input.c.page1.num6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price6
            #add-point:ON ACTION controlp INFIELD price6 name="input.c.page1.price6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt6
            #add-point:ON ACTION controlp INFIELD amt6 name="input.c.page1.amt6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num7
            #add-point:ON ACTION controlp INFIELD num7 name="input.c.page1.num7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price7
            #add-point:ON ACTION controlp INFIELD price7 name="input.c.page1.price7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt7
            #add-point:ON ACTION controlp INFIELD amt7 name="input.c.page1.amt7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num8
            #add-point:ON ACTION controlp INFIELD num8 name="input.c.page1.num8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price8
            #add-point:ON ACTION controlp INFIELD price8 name="input.c.page1.price8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt8
            #add-point:ON ACTION controlp INFIELD amt8 name="input.c.page1.amt8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num9
            #add-point:ON ACTION controlp INFIELD num9 name="input.c.page1.num9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price9
            #add-point:ON ACTION controlp INFIELD price9 name="input.c.page1.price9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt9
            #add-point:ON ACTION controlp INFIELD amt9 name="input.c.page1.amt9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num10
            #add-point:ON ACTION controlp INFIELD num10 name="input.c.page1.num10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price10
            #add-point:ON ACTION controlp INFIELD price10 name="input.c.page1.price10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt10
            #add-point:ON ACTION controlp INFIELD amt10 name="input.c.page1.amt10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num11
            #add-point:ON ACTION controlp INFIELD num11 name="input.c.page1.num11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price11
            #add-point:ON ACTION controlp INFIELD price11 name="input.c.page1.price11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt11
            #add-point:ON ACTION controlp INFIELD amt11 name="input.c.page1.amt11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num12
            #add-point:ON ACTION controlp INFIELD num12 name="input.c.page1.num12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price12
            #add-point:ON ACTION controlp INFIELD price12 name="input.c.page1.price12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt12
            #add-point:ON ACTION controlp INFIELD amt12 name="input.c.page1.amt12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num13
            #add-point:ON ACTION controlp INFIELD num13 name="input.c.page1.num13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price13
            #add-point:ON ACTION controlp INFIELD price13 name="input.c.page1.price13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt13
            #add-point:ON ACTION controlp INFIELD amt13 name="input.c.page1.amt13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj008
            #add-point:ON ACTION controlp INFIELD bgcj008 name="input.c.page1.bgcj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj047
            #add-point:ON ACTION controlp INFIELD bgcj047 name="input.c.page1.bgcj047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj048
            #add-point:ON ACTION controlp INFIELD bgcj048 name="input.c.page1.bgcj048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj050
            #add-point:ON ACTION controlp INFIELD bgcj050 name="input.c.page1.bgcj050"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgcj_d[l_ac].* = g_bgcj_d_t.*
               CLOSE abgt340_bcl
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
               LET g_errparam.extend = g_bgcj_d[l_ac].bgcj008 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgcj_d[l_ac].* = g_bgcj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bgcj2_d[l_ac].bgcjmodid = g_user 
LET g_bgcj2_d[l_ac].bgcjmoddt = cl_get_current()
LET g_bgcj2_d[l_ac].bgcjmodid_desc = cl_get_username(g_bgcj2_d[l_ac].bgcjmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF 1=2 THEN
               #end add-point
         
               #將遮罩欄位還原
               CALL abgt340_bgcj_t_mask_restore('restore_mask_o')
         
               UPDATE bgcj_t SET (bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj009,bgcj010, 
                   bgcjseq,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,bgcj019,bgcj020, 
                   bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037,bgcj100,bgcj008,bgcj047,bgcj048, 
                   bgcj050,bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid, 
                   bgcjcnfdt) = (g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
                   g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010, 
                   g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj049,g_bgcj_d[l_ac].bgcj012,g_bgcj_d[l_ac].bgcj013, 
                   g_bgcj_d[l_ac].bgcj014,g_bgcj_d[l_ac].bgcj015,g_bgcj_d[l_ac].bgcj016,g_bgcj_d[l_ac].bgcj017, 
                   g_bgcj_d[l_ac].bgcj018,g_bgcj_d[l_ac].bgcj019,g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021, 
                   g_bgcj_d[l_ac].bgcj022,g_bgcj_d[l_ac].bgcj023,g_bgcj_d[l_ac].bgcj024,g_bgcj_d[l_ac].bgcj035, 
                   g_bgcj_d[l_ac].bgcj036,g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj008, 
                   g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048,g_bgcj_d[l_ac].bgcj050,g_bgcj2_d[l_ac].bgcjownid, 
                   g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid,g_bgcj2_d[l_ac].bgcjcrtdp,g_bgcj2_d[l_ac].bgcjcrtdt, 
                   g_bgcj2_d[l_ac].bgcjmodid,g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt) 
 
                WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj_m.bgcj001 
                 AND bgcj002 = g_bgcj_m.bgcj002 
                 AND bgcj003 = g_bgcj_m.bgcj003 
                 AND bgcj004 = g_bgcj_m.bgcj004 
                 AND bgcj005 = g_bgcj_m.bgcj005 
                 AND bgcj006 = g_bgcj_m.bgcj006 
                 AND bgcj007 = g_bgcj_m.bgcj007 
                 AND bgcj009 = g_bgcj_m.bgcj009 
                 AND bgcj010 = g_bgcj_m.bgcj010 
 
                 AND bgcj008 = g_bgcj_d_t.bgcj008 #項次   
                 AND bgcjseq = g_bgcj_d_t.bgcjseq  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               END IF
               
               #將遮罩欄位還原
               CALL abgt340_bgcj_t_mask_restore('restore_mask_o')
               
               #主键检查
               #组合key bgcj010
               CALL abgt340_get_bgcj010()
               
               #预算组织在单头
               IF g_bgaw1[1]='Y' THEN 
                  LET l_bgcj007 = g_bgcj_m.bgcj007
               ELSE
                  LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
               END IF
               #预算料号在单头
               IF g_bgaw1[2]='Y' THEN 
                  LET l_bgcj009 = g_bgcj_m.bgcj009
               ELSE
                  LET l_bgcj009 = g_bgcj_d[l_ac].bgcj009
               END IF
               
               IF g_bgcj_m.bgcj001 != g_bgcj001_t  OR g_bgcj_m.bgcj002 != g_bgcj002_t  OR g_bgcj_m.bgcj003 != g_bgcj003_t OR
                  g_bgcj_m.bgcj004 != g_bgcj004_t  OR g_bgcj_m.bgcj005 != g_bgcj005_t  OR g_bgcj_m.bgcj006 != g_bgcj006_t OR
                  ((g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 != g_bgcj007_t ) OR (g_bgaw2[1]='Y' AND g_bgcj_d[l_ac].bgcj007!=g_bgcj_d_t.bgcj007)) OR
                  ((g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 != g_bgcj009_t ) OR (g_bgaw2[2]='Y' AND g_bgcj_d[l_ac].bgcj009!=g_bgcj_d_t.bgcj009)) 
               THEN                   
                  CALL s_abgt340_detail_key_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                                g_bgcj_m.bgcj006,l_bgcj007,l_bgcj009,g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgcj_d[l_ac].bgcjseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgcjseq
                  END IF
               END IF
               
               #重写单身更新
               CALL abgt340_update_detail() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bgcj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcj_m.bgcj001
               LET gs_keys_bak[1] = g_bgcj001_t
               LET gs_keys[2] = g_bgcj_m.bgcj002
               LET gs_keys_bak[2] = g_bgcj002_t
               LET gs_keys[3] = g_bgcj_m.bgcj003
               LET gs_keys_bak[3] = g_bgcj003_t
               LET gs_keys[4] = g_bgcj_m.bgcj004
               LET gs_keys_bak[4] = g_bgcj004_t
               LET gs_keys[5] = g_bgcj_m.bgcj005
               LET gs_keys_bak[5] = g_bgcj005_t
               LET gs_keys[6] = g_bgcj_m.bgcj006
               LET gs_keys_bak[6] = g_bgcj006_t
               LET gs_keys[7] = g_bgcj_m.bgcj007
               LET gs_keys_bak[7] = g_bgcj007_t
               LET gs_keys[8] = g_bgcj_m.bgcj009
               LET gs_keys_bak[8] = g_bgcj009_t
               LET gs_keys[9] = g_bgcj_m.bgcj010
               LET gs_keys_bak[9] = g_bgcj010_t
               LET gs_keys[10] = g_bgcj_d[g_detail_idx].bgcj008
               LET gs_keys_bak[10] = g_bgcj_d_t.bgcj008
               LET gs_keys[11] = g_bgcj_d[g_detail_idx].bgcjseq
               LET gs_keys_bak[11] = g_bgcj_d_t.bgcjseq
               CALL abgt340_update_b('bgcj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bgcj_m),util.JSON.stringify(g_bgcj_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgcj_m),util.JSON.stringify(g_bgcj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt340_bgcj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bgcj_m.bgcj001
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj002
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj003
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj004
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj005
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj006
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj007
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj009
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_m.bgcj010
 
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_d_t.bgcj008
               LET ls_keys[ls_keys.getLength()+1] = g_bgcj_d_t.bgcjseq
 
               CALL abgt340_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            #检查单头是否存在未录入的核算项资料
            CALL abgt340_head_hsx_chk() #161215-00014#1 add
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgt340_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgcj_d[l_ac].* = g_bgcj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgt340_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bgcj_d.getLength() = 0 THEN
               NEXT FIELD bgcj008
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgcj_d[li_reproduce_target].* = g_bgcj_d[li_reproduce].*
               LET g_bgcj2_d[li_reproduce_target].* = g_bgcj2_d[li_reproduce].*
               LET g_bgcj3_d[li_reproduce_target].* = g_bgcj3_d[li_reproduce].*
 
               LET g_bgcj_d[li_reproduce_target].bgcj008 = NULL
               LET g_bgcj_d[li_reproduce_target].bgcjseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgcj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgcj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bgcj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt340_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgt340_idx_chk()
            CALL abgt340_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
      DISPLAY ARRAY g_bgcj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt340_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 3
            CALL abgt340_idx_chk()
            CALL abgt340_ui_detailshow()
        
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
            NEXT FIELD bgcj001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgcjseq
               WHEN "s_detail2"
                  NEXT FIELD bgcjseq_2
               WHEN "s_detail3"
                  NEXT FIELD bgcjseq_3
 
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
   CALL cl_set_combo_scc('bgcj005','8952')
   CLOSE abgt340_hcl2
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt340_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #重新抓取樣式
   CALL s_abg2_get_bgaw(g_bgcj_m.bgcj011) RETURNING g_bgaw1,g_bgaw2
   
   #设置核算项显示位置
   CALL abgt340_set_hsx_visible()
   
   #抓取預算週期和預算期別
   CALL s_abgt340_sel_bgaa(g_bgcj_m.bgcj002) RETURNING g_bgcj_m.bgaa002,g_bgcj_m.bgaa003,g_max_period
   DISPLAY BY NAME g_bgcj_m.bgaa002,g_bgcj_m.bgaa003
   #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
   IF g_max_period < 13 THEN
      CALL cl_set_comp_visible("num13,price13,amt13,tnum13,tprice13,tamt13",FALSE)
   ELSE
      CALL cl_set_comp_visible("num13,price13,amt13,tnum13,tprice13,tamt13",TRUE)
   END IF
   
   #根据销售来源显示预算料号栏位名称
   CALL abgt340_set_bgcj005_text(g_bgcj_m.bgcj005)
   
   #抓取单头核算项说明
   CALL abgt340_head_hsx_desc()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgt340_b_fill(g_wc2) #第一階單身填充
      CALL abgt340_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt340_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bgcj_m.bgcj002,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj004_desc, 
       g_bgcj_m.bgaa002,g_bgcj_m.bgaa003,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj007_desc_t,g_bgcj_m.bgcj013, 
       g_bgcj_m.bgcj013_desc_t,g_bgcj_m.bgcj016,g_bgcj_m.bgcj016_desc_t,g_bgcj_m.bgcj019,g_bgcj_m.bgcj019_desc_t, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj014_desc_t,g_bgcj_m.bgcj017,g_bgcj_m.bgcj017_desc_t, 
       g_bgcj_m.bgcj020,g_bgcj_m.bgcj020_desc_t,g_bgcj_m.bgcj023,g_bgcj_m.bgcj023_desc_t,g_bgcj_m.bgcj012, 
       g_bgcj_m.bgcj012_desc_t,g_bgcj_m.bgcj015,g_bgcj_m.bgcj015_desc_t,g_bgcj_m.bgcj018,g_bgcj_m.bgcj018_desc_t, 
       g_bgcj_m.bgcj021,g_bgcj_m.bgcj021_desc_t,g_bgcj_m.bgcj024,g_bgcj_m.bgcj024_desc_t,g_bgcj_m.bgcj049 
 
 
   CALL abgt340_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CASE g_bgcj_m.bgcjstus 
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
 
{<section id="abgt340.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgt340_ref_show()
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
   FOR l_ac = 1 TO g_bgcj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgcj2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_bgcj3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgt340.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt340_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgcj_t.bgcj001 
   DEFINE l_oldno     LIKE bgcj_t.bgcj001 
   DEFINE l_newno02     LIKE bgcj_t.bgcj002 
   DEFINE l_oldno02     LIKE bgcj_t.bgcj002 
   DEFINE l_newno03     LIKE bgcj_t.bgcj003 
   DEFINE l_oldno03     LIKE bgcj_t.bgcj003 
   DEFINE l_newno04     LIKE bgcj_t.bgcj004 
   DEFINE l_oldno04     LIKE bgcj_t.bgcj004 
   DEFINE l_newno05     LIKE bgcj_t.bgcj005 
   DEFINE l_oldno05     LIKE bgcj_t.bgcj005 
   DEFINE l_newno06     LIKE bgcj_t.bgcj006 
   DEFINE l_oldno06     LIKE bgcj_t.bgcj006 
   DEFINE l_newno07     LIKE bgcj_t.bgcj007 
   DEFINE l_oldno07     LIKE bgcj_t.bgcj007 
   DEFINE l_newno08     LIKE bgcj_t.bgcj009 
   DEFINE l_oldno08     LIKE bgcj_t.bgcj009 
   DEFINE l_newno09     LIKE bgcj_t.bgcj010 
   DEFINE l_oldno09     LIKE bgcj_t.bgcj010 
 
   DEFINE l_master    RECORD LIKE bgcj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgcj_t.* #此變數樣板目前無使用
 
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
 
   IF g_bgcj_m.bgcj001 IS NULL
      OR g_bgcj_m.bgcj002 IS NULL
      OR g_bgcj_m.bgcj003 IS NULL
      OR g_bgcj_m.bgcj004 IS NULL
      OR g_bgcj_m.bgcj005 IS NULL
      OR g_bgcj_m.bgcj006 IS NULL
      OR g_bgcj_m.bgcj007 IS NULL
      OR g_bgcj_m.bgcj009 IS NULL
      OR g_bgcj_m.bgcj010 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
   LET g_bgcj010_t = g_bgcj_m.bgcj010
 
   
   LET g_bgcj_m.bgcj001 = ""
   LET g_bgcj_m.bgcj002 = ""
   LET g_bgcj_m.bgcj003 = ""
   LET g_bgcj_m.bgcj004 = ""
   LET g_bgcj_m.bgcj005 = ""
   LET g_bgcj_m.bgcj006 = ""
   LET g_bgcj_m.bgcj007 = ""
   LET g_bgcj_m.bgcj009 = ""
   LET g_bgcj_m.bgcj010 = ""
 
   LET g_master_insert = FALSE
   CALL abgt340_set_entry('a')
   CALL abgt340_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bgcj_m.bgcj001 = "20"
   LET g_bgcj_m.bgcj005 = "1"
   LET g_bgcj_m.bgcj006 = "1"
   LET g_bgcj_m.bgcjstus = 'N'
   CASE g_bgcj_m.bgcjstus 
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
   LET g_bgcj_m.bgcj011 = ''
   LET g_bgcj_m.bgaa002 = ''
   LET g_bgcj_m.bgaa003 = ''
   #end add-point
   
   #清空key欄位的desc
      LET g_bgcj_m.bgcj002_desc = ''
   DISPLAY BY NAME g_bgcj_m.bgcj002_desc
   LET g_bgcj_m.bgcj004_desc = ''
   DISPLAY BY NAME g_bgcj_m.bgcj004_desc
   LET g_bgcj_m.bgcj007_desc_t = ''
   DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
 
   
   CALL abgt340_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bgcj_m.* TO NULL
      INITIALIZE g_bgcj_d TO NULL
      INITIALIZE g_bgcj2_d TO NULL
      INITIALIZE g_bgcj3_d TO NULL
 
      CALL abgt340_show()
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
   CALL abgt340_set_act_visible()
   CALL abgt340_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
   LET g_bgcj010_t = g_bgcj_m.bgcj010
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                      " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                      ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                      ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                      ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                      ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                      ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
                      ," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
                      ," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
                      ," AND bgcj010 = '", g_bgcj_m.bgcj010, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgt340_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt340_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgcj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_sql       STRING
   DEFINE l_bgcj001_t LIKE bgcj_t.bgcj001
   DEFINE l_bgcj002_t LIKE bgcj_t.bgcj002
   DEFINE l_bgcj003_t LIKE bgcj_t.bgcj003
   DEFINE l_bgcj004_t LIKE bgcj_t.bgcj004
   DEFINE l_bgcj005_t LIKE bgcj_t.bgcj005
   DEFINE l_bgcj006_t LIKE bgcj_t.bgcj006
   DEFINE l_bgcj007_t LIKE bgcj_t.bgcj007
   DEFINE l_bgcj009_t LIKE bgcj_t.bgcj009
   DEFINE l_success   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt340_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   IF 1=2 THEN
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgcj_t
    WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj001_t
    AND bgcj002 = g_bgcj002_t
    AND bgcj003 = g_bgcj003_t
    AND bgcj004 = g_bgcj004_t
    AND bgcj005 = g_bgcj005_t
    AND bgcj006 = g_bgcj006_t
    AND bgcj007 = g_bgcj007_t
    AND bgcj009 = g_bgcj009_t
    AND bgcj010 = g_bgcj010_t
 
       INTO TEMP abgt340_detail
   
   #將key修正為調整後   
   UPDATE abgt340_detail 
      #更新key欄位
      SET bgcj001 = g_bgcj_m.bgcj001
          , bgcj002 = g_bgcj_m.bgcj002
          , bgcj003 = g_bgcj_m.bgcj003
          , bgcj004 = g_bgcj_m.bgcj004
          , bgcj005 = g_bgcj_m.bgcj005
          , bgcj006 = g_bgcj_m.bgcj006
          , bgcj007 = g_bgcj_m.bgcj007
          , bgcj009 = g_bgcj_m.bgcj009
          , bgcj010 = g_bgcj_m.bgcj010
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgcjownid = g_user 
       , bgcjowndp = g_dept
       , bgcjcrtid = g_user
       , bgcjcrtdp = g_dept 
       , bgcjcrtdt = ld_date
       , bgcjmodid = g_user
       , bgcjmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bgcj_t SELECT * FROM abgt340_detail
   
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
   
   LET l_sql = "SELECT * FROM bgcj_t",
               " WHERE bgcjent =", g_enterprise," AND bgcj001 ='", g_bgcj001_t,"'",
               "   AND bgcj002 ='",g_bgcj002_t,"'",
               "   AND bgcj003 ='",g_bgcj003_t,"'",
               "   AND bgcj004 ='",g_bgcj004_t,"'",
               "   AND bgcj005 ='",g_bgcj005_t,"'",
               "   AND bgcj006 ='",g_bgcj006_t,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql,"   AND bgcj007 ='",g_bgcj007_t,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql,"   AND bgcj009 ='",g_bgcj009_t,"'"
   END IF
   LET l_sql = l_sql," INTO TEMP abgt340_detail"
   PREPARE abgt340_rep_pr FROM l_sql
   EXECUTE abgt340_rep_pr
   
   #將key修正為調整後   
   LET l_sql = "UPDATE abgt340_detail ",
               #更新key欄位
               "   SET bgcj001 = '",g_bgcj_m.bgcj001,"'",
               "      ,bgcj002 = '",g_bgcj_m.bgcj002,"'",
               "      ,bgcj003 = '",g_bgcj_m.bgcj003,"'",
               "      ,bgcj004 = '",g_bgcj_m.bgcj004,"'",
               "      ,bgcj005 = '",g_bgcj_m.bgcj005,"'",
               "      ,bgcj006 = '",g_bgcj_m.bgcj006,"'",
               
              #更新共用欄位
              #應用 a13 樣板自動產生(Version:4)
               "      ,bgcjownid = '",g_user,"'", 
               "      ,bgcjowndp = '",g_dept,"'",
               "      ,bgcjcrtid = '",g_user,"'",
               "      ,bgcjcrtdp = '",g_dept,"'", 
               "      ,bgcjcrtdt = to_date('",ld_date,"','YYYY-MM-DD hh24:mi:ss') ",
               "      ,bgcjmodid = '",g_user,"'",
               "      ,bgcjmoddt =  to_date('",ld_date,"','YYYY-MM-DD hh24:mi:ss') ",
               "      ,bgcjcnfid = NULL",
               "      ,bgcjcnfdt = NULL",
               "      ,bgcjstus = 'N'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql,"      ,bgcj007 = '",g_bgcj_m.bgcj007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql,"      ,bgcj009 = '",g_bgcj_m.bgcj009,"'"
   END IF
   
   PREPARE abgt340_rep_pr2 FROM l_sql
   EXECUTE abgt340_rep_pr2
                                       
   #將資料塞回原table   
   INSERT INTO bgcj_t SELECT * FROM abgt340_detail
   
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
   DROP TABLE abgt340_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   #记录旧值主键
   LET l_bgcj001_t = g_bgcj001_t
   LET l_bgcj002_t = g_bgcj002_t
   LET l_bgcj003_t = g_bgcj003_t
   LET l_bgcj004_t = g_bgcj004_t
   LET l_bgcj005_t = g_bgcj005_t
   LET l_bgcj006_t = g_bgcj006_t
   LET l_bgcj007_t = g_bgcj007_t
   LET l_bgcj009_t = g_bgcj009_t
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
   CALL abgt340_update_head() RETURNING l_success 
   IF l_success = FALSE THEN
      CALL s_transaction_end('N','0')
      #还原旧主键
      LET g_bgcj001_t = l_bgcj001_t 
      LET g_bgcj002_t = l_bgcj002_t 
      LET g_bgcj003_t = l_bgcj003_t 
      LET g_bgcj004_t = l_bgcj004_t 
      LET g_bgcj005_t = l_bgcj005_t 
      LET g_bgcj006_t = l_bgcj006_t 
      LET g_bgcj007_t = l_bgcj007_t 
      LET g_bgcj009_t = l_bgcj009_t 
      RETURN
   END IF
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
   LET g_bgcj010_t = g_bgcj_m.bgcj010
 
   
   DROP TABLE abgt340_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt340_delete()
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
   CALL abgt340_delete_1()
   RETURN
   #end add-point
   
   IF g_bgcj_m.bgcj001 IS NULL
   OR g_bgcj_m.bgcj002 IS NULL
   OR g_bgcj_m.bgcj003 IS NULL
   OR g_bgcj_m.bgcj004 IS NULL
   OR g_bgcj_m.bgcj005 IS NULL
   OR g_bgcj_m.bgcj006 IS NULL
   OR g_bgcj_m.bgcj007 IS NULL
   OR g_bgcj_m.bgcj009 IS NULL
   OR g_bgcj_m.bgcj010 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgt340_cl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt340_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010 INTO g_bgcj_m.bgcj002, 
       g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcj010,g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj009,g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023, 
       g_bgcj_m.bgcj012,g_bgcj_m.bgcj015,g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj049, 
       g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc
   
   #遮罩相關處理
   LET g_bgcj_m_mask_o.* =  g_bgcj_m.*
   CALL abgt340_bgcj_t_mask()
   LET g_bgcj_m_mask_n.* =  g_bgcj_m.*
   
   CALL abgt340_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt340_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
 
      #end add-point
      
      DELETE FROM bgcj_t WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj_m.bgcj001
                                                               AND bgcj002 = g_bgcj_m.bgcj002
                                                               AND bgcj003 = g_bgcj_m.bgcj003
                                                               AND bgcj004 = g_bgcj_m.bgcj004
                                                               AND bgcj005 = g_bgcj_m.bgcj005
                                                               AND bgcj006 = g_bgcj_m.bgcj006
                                                               AND bgcj007 = g_bgcj_m.bgcj007
                                                               AND bgcj009 = g_bgcj_m.bgcj009
                                                               AND bgcj010 = g_bgcj_m.bgcj010
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
 
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
      #   CLOSE abgt340_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bgcj_d.clear() 
      CALL g_bgcj2_d.clear()       
      CALL g_bgcj3_d.clear()       
 
     
      CALL abgt340_ui_browser_refresh()  
      #CALL abgt340_ui_headershow()  
      #CALL abgt340_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt340_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt340_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt340_cl
 
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt340.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt340_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_bgcj010_str       STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bgcj_d.clear()
   CALL g_bgcj2_d.clear()
   CALL g_bgcj3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015, 
       bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037, 
       bgcj100,bgcj008,bgcj047,bgcj048,bgcj050,bgcjseq,bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt, 
       bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooag011 FROM bgcj_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgcjownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgcjowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgcjcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgcjcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgcjmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgcjcnfid  ",
 
               " WHERE bgcjent= ? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=? AND bgcj007=? AND bgcj009=? AND bgcj010=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgcj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #重写单身抓取sql
   #161220-00036#1--mod--str--
#   LET g_sql = "SELECT  DISTINCT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015, 
#       bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037, 
#       bgcj100,bgcj101,0 bgcj008,bgcj047,'',bgcj050,bgcjseq,bgcjownid,bgcjowndp, 
#       bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq,t1.ooag011 ,t2.ooefl003 , 
#       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 FROM bgcj_t", 
   LET g_sql = "SELECT  DISTINCT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,", 
       "bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037, ",
       "bgcj100,0 bgcj008,bgcj047,'',bgcj050,bgcjseq,bgcjownid,bgcjowndp,",
       "bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq,t1.ooag011 ,t2.ooefl003 , ",
       "t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ",
       "  FROM bgcj_t",         
   #161220-00036#1--mark--end
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgcjownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgcjowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgcjcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgcjcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgcjmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgcjcnfid  ",
 
               " WHERE bgcjent= ? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=? "  
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET g_sql = g_sql," AND bgcj007='",g_bgcj_m.bgcj007,"' "
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET g_sql = g_sql," AND bgcj009='",g_bgcj_m.bgcj009,"' "
   END IF
   
   #将单头核算项组成的组合码转换成查询条件
   LET l_bgcj010_str=g_bgcj_m.bgcj010
   IF cl_null(l_bgcj010_str) THEN
      LET l_bgcj010_str = " 1=1 "
   ELSE
      LET l_bgcj010_str=cl_replace_str(l_bgcj010_str,"=","='")
      LET l_bgcj010_str=cl_replace_str(l_bgcj010_str,"/","' AND ")
      LET l_bgcj010_str=l_bgcj010_str,"' "
   END IF
   LET g_sql = g_sql," AND ",l_bgcj010_str
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgcj_t")
   END IF
   LET g_sql = g_sql, " ORDER BY bgcj_t.bgcjseq"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   PREPARE abgt340_pb_1 FROM g_sql
   DECLARE b_fill_cs_1 CURSOR FOR abgt340_pb_1
   OPEN b_fill_cs_1 USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006
   
   LET g_cnt = l_ac
   LET l_ac = 1                                            
   FOREACH b_fill_cs_1 INTO g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010,g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj009, 
       g_bgcj_d[l_ac].bgcj049,g_bgcj_d[l_ac].bgcj012,g_bgcj_d[l_ac].bgcj013,g_bgcj_d[l_ac].bgcj014, 
       g_bgcj_d[l_ac].bgcj015,g_bgcj_d[l_ac].bgcj016,g_bgcj_d[l_ac].bgcj017,g_bgcj_d[l_ac].bgcj018, 
       g_bgcj_d[l_ac].bgcj019,g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021,g_bgcj_d[l_ac].bgcj022, 
       g_bgcj_d[l_ac].bgcj023,g_bgcj_d[l_ac].bgcj024,g_bgcj_d[l_ac].bgcj035,g_bgcj_d[l_ac].bgcj036, 
#       g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj101,g_bgcj_d[l_ac].bgcj008, #161220-00036#1 mark
       g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj008, #161220-00036#1 add
       g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048,g_bgcj_d[l_ac].bgcj050,g_bgcj2_d[l_ac].bgcjseq,
       g_bgcj2_d[l_ac].bgcjownid,g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid,
       g_bgcj2_d[l_ac].bgcjcrtdp,g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid,
       g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt, 
       g_bgcj3_d[l_ac].bgcjseq,g_bgcj2_d[l_ac].bgcjownid_desc,g_bgcj2_d[l_ac].bgcjowndp_desc,g_bgcj2_d[l_ac].bgcjcrtid_desc, 
       g_bgcj2_d[l_ac].bgcjcrtdp_desc,g_bgcj2_d[l_ac].bgcjmodid_desc,g_bgcj2_d[l_ac].bgcjcnfid_desc 
    
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF           
     
      #抓取项次对应的每个期别的数量、单价、销售金额
      CALL abgt340_get_num_and_price()
      #显示单身核算项说明
      CALL abgt340_detail_hsx_desc()
   
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
   CALL g_bgcj_d.deleteElement(g_bgcj_d.getLength())
   CALL g_bgcj2_d.deleteElement(g_bgcj2_d.getLength())
   
   DISPLAY g_rec_b TO FORMONLY.cnt    
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgcj_d.getLength()
      LET g_bgcj_d_mask_o[l_ac].* =  g_bgcj_d[l_ac].*
      CALL abgt340_bgcj_t_mask()
      LET g_bgcj_d_mask_n[l_ac].* =  g_bgcj_d[l_ac].*
   END FOR
   
   LET g_bgcj2_d_mask_o.* =  g_bgcj2_d.*
   FOR l_ac = 1 TO g_bgcj2_d.getLength()
      LET g_bgcj2_d_mask_o[l_ac].* =  g_bgcj2_d[l_ac].*
      CALL abgt340_bgcj_t_mask()
      LET g_bgcj2_d_mask_n[l_ac].* =  g_bgcj2_d[l_ac].*
   END FOR
   LET l_ac = g_cnt
   LET g_cnt = 0 
   
   #调整资讯页签填充单身
   CALL abgt340_b_fill2(l_ac)
   
   FREE abgt340_pb_1   
   RETURN
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgt340_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bgcj_t.bgcj008,bgcj_t.bgcjseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt340_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt340_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
          g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj010 INTO g_bgcj_d[l_ac].bgcjseq, 
          g_bgcj_d[l_ac].bgcj010,g_bgcj_d[l_ac].bgcj007,g_bgcj_d[l_ac].bgcj009,g_bgcj_d[l_ac].bgcj049, 
          g_bgcj_d[l_ac].bgcj012,g_bgcj_d[l_ac].bgcj013,g_bgcj_d[l_ac].bgcj014,g_bgcj_d[l_ac].bgcj015, 
          g_bgcj_d[l_ac].bgcj016,g_bgcj_d[l_ac].bgcj017,g_bgcj_d[l_ac].bgcj018,g_bgcj_d[l_ac].bgcj019, 
          g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021,g_bgcj_d[l_ac].bgcj022,g_bgcj_d[l_ac].bgcj023, 
          g_bgcj_d[l_ac].bgcj024,g_bgcj_d[l_ac].bgcj035,g_bgcj_d[l_ac].bgcj036,g_bgcj_d[l_ac].bgcj037, 
          g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj008,g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048, 
          g_bgcj_d[l_ac].bgcj050,g_bgcj2_d[l_ac].bgcjseq,g_bgcj2_d[l_ac].bgcjownid,g_bgcj2_d[l_ac].bgcjowndp, 
          g_bgcj2_d[l_ac].bgcjcrtid,g_bgcj2_d[l_ac].bgcjcrtdp,g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid, 
          g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt,g_bgcj3_d[l_ac].bgcjseq, 
          g_bgcj2_d[l_ac].bgcjownid_desc,g_bgcj2_d[l_ac].bgcjowndp_desc,g_bgcj2_d[l_ac].bgcjcrtid_desc, 
          g_bgcj2_d[l_ac].bgcjcrtdp_desc,g_bgcj2_d[l_ac].bgcjmodid_desc,g_bgcj2_d[l_ac].bgcjcnfid_desc  
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
 
            CALL g_bgcj_d.deleteElement(g_bgcj_d.getLength())
      CALL g_bgcj2_d.deleteElement(g_bgcj2_d.getLength())
      CALL g_bgcj3_d.deleteElement(g_bgcj3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
  
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgcj_d.getLength()
      LET g_bgcj_d_mask_o[l_ac].* =  g_bgcj_d[l_ac].*
      CALL abgt340_bgcj_t_mask()
      LET g_bgcj_d_mask_n[l_ac].* =  g_bgcj_d[l_ac].*
   END FOR
   
   LET g_bgcj2_d_mask_o.* =  g_bgcj2_d.*
   FOR l_ac = 1 TO g_bgcj2_d.getLength()
      LET g_bgcj2_d_mask_o[l_ac].* =  g_bgcj2_d[l_ac].*
      CALL abgt340_bgcj_t_mask()
      LET g_bgcj2_d_mask_n[l_ac].* =  g_bgcj2_d[l_ac].*
   END FOR
   LET g_bgcj3_d_mask_o.* =  g_bgcj3_d.*
   FOR l_ac = 1 TO g_bgcj3_d.getLength()
      LET g_bgcj3_d_mask_o[l_ac].* =  g_bgcj3_d[l_ac].*
      CALL abgt340_bgcj_t_mask()
      LET g_bgcj3_d_mask_n[l_ac].* =  g_bgcj3_d[l_ac].*
   END FOR
 
 
   FREE abgt340_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt340_idx_chk()
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
      IF g_detail_idx > g_bgcj_d.getLength() THEN
         LET g_detail_idx = g_bgcj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgcj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgcj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgcj2_d.getLength() THEN
         LET g_detail_idx = g_bgcj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgcj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgcj2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_bgcj3_d.getLength() THEN
         LET g_detail_idx = g_bgcj3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgcj3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgcj3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt340_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_bgcj038       LIKE bgcj_t.bgcj038
   DEFINE l_bgcj039       LIKE bgcj_t.bgcj039
   DEFINE l_bgcj040       LIKE bgcj_t.bgcj040
   DEFINE l_bgcj041       LIKE bgcj_t.bgcj041
   DEFINE l_bgcj042       LIKE bgcj_t.bgcj042
   DEFINE l_bgcj043       LIKE bgcj_t.bgcj043
   DEFINE l_bgcj044       LIKE bgcj_t.bgcj044
   DEFINE l_bgcj045       LIKE bgcj_t.bgcj045
   DEFINE l_bgcj046       LIKE bgcj_t.bgcj046
   DEFINE l_bgcj102       LIKE bgcj_t.bgcj102
   DEFINE l_amt1          LIKE bgcj_t.bgcj040
   DEFINE l_amt2          LIKE bgcj_t.bgcj040
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bgcj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF pi_idx < 1 THEN
      RETURN
   END IF
   
   CALL g_bgcj3_d.clear()
   
   LET l_sql="SELECT bgcj038,bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,bgcj044,bgcj045,bgcj046,bgcj102",
             "  FROM bgcj_t ",
             " WHERE bgcjent =  ",g_enterprise,
             "   AND bgcj001 = '",g_bgcj_m.bgcj001,"'",
             "   AND bgcj002 = '",g_bgcj_m.bgcj002,"'",
             "   AND bgcj003 = '",g_bgcj_m.bgcj003,"'",
             "   AND bgcj004 = '",g_bgcj_m.bgcj004,"'",
             "   AND bgcj005 = '",g_bgcj_m.bgcj005,"'",
             "   AND bgcj006 = '",g_bgcj_m.bgcj006,"'",
             "   AND bgcj010 = '",g_bgcj_d[pi_idx].bgcj010,"'",
             "   AND bgcjseq =  ",g_bgcj_d[pi_idx].bgcjseq,
             "   AND bgcj008 = ? "
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj_m.bgcj007,"'"
   ELSE
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj_d[pi_idx].bgcj007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj_m.bgcj009,"'"
   ELSE
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj_d[pi_idx].bgcj009,"'"
   END IF
   PREPARE abgt340_b_fill2_pr FROM l_sql
   
   
   #第一行：基准金额
   LET g_bgcj3_d[1].bgcjseq = g_bgcj_d[pi_idx].bgcjseq #项次
   LET g_bgcj3_d[1].content = '1'
   #第二行：本层调整
   LET g_bgcj3_d[2].bgcjseq = g_bgcj_d[pi_idx].bgcjseq #项次
   LET g_bgcj3_d[2].content = '2'
   #第三行：上层调整
   LET g_bgcj3_d[3].bgcjseq = g_bgcj_d[pi_idx].bgcjseq #项次
   LET g_bgcj3_d[3].content = '3'
   #第四行：核准金额   
   LET g_bgcj3_d[4].bgcjseq = g_bgcj_d[pi_idx].bgcjseq #项次
   LET g_bgcj3_d[4].content = '4'
   FOR l_i = 1 TO g_max_period
      #161220-00036#1--add--str--
      LET l_bgcj038 = 0
      LET l_bgcj039 = 0
      LET l_bgcj040 = 0
      LET l_bgcj041 = 0
      LET l_bgcj042 = 0
      LET l_bgcj043 = 0
      LET l_bgcj044 = 0
      LET l_bgcj045 = 0
      LET l_bgcj046 = 0
      LET l_bgcj102 = 0
      LET l_amt1 = 0
      LET l_amt2 = 0
      #161220-00036#1--add--end
      EXECUTE abgt340_b_fill2_pr USING l_i
      INTO l_bgcj038,l_bgcj039,l_bgcj040,l_bgcj041,l_bgcj042,l_bgcj043,
           l_bgcj044,l_bgcj045,l_bgcj046,l_bgcj102 
      #调整金额=调整数量*（基准单价+调整单价）+基准数量*调整单价
      #本层调整金额
      LET l_amt1 = l_bgcj041 * (l_bgcj039 + l_bgcj042) + l_bgcj038 * l_bgcj042
      #上层调整
      LET l_amt2 = l_bgcj043 * (l_bgcj039 + l_bgcj044) + l_bgcj038 * l_bgcj044       
      CASE l_i
         WHEN 1 
            LET g_bgcj3_d[1].tnum1 = l_bgcj038
            LET g_bgcj3_d[1].tprice1 = l_bgcj039
            LET g_bgcj3_d[1].tamt1 = l_bgcj040
            LET g_bgcj3_d[2].tnum1 = l_bgcj041
            LET g_bgcj3_d[2].tprice1 = l_bgcj042
            LET g_bgcj3_d[2].tamt1 = l_amt1
            LET g_bgcj3_d[3].tnum1 = l_bgcj043
            LET g_bgcj3_d[3].tprice1 = l_bgcj044
            LET g_bgcj3_d[3].tamt1 = l_amt2
            LET g_bgcj3_d[4].tnum1 = l_bgcj045
            LET g_bgcj3_d[4].tprice1 = l_bgcj046
            LET g_bgcj3_d[4].tamt1 = l_bgcj102
         WHEN 2 
            LET g_bgcj3_d[1].tnum2 = l_bgcj038
            LET g_bgcj3_d[1].tprice2 = l_bgcj039
            LET g_bgcj3_d[1].tamt2 = l_bgcj040
            LET g_bgcj3_d[2].tnum2 = l_bgcj041
            LET g_bgcj3_d[2].tprice2 = l_bgcj042
            LET g_bgcj3_d[2].tamt2 = l_amt1
            LET g_bgcj3_d[3].tnum2 = l_bgcj043
            LET g_bgcj3_d[3].tprice2 = l_bgcj044
            LET g_bgcj3_d[3].tamt2 = l_amt2
            LET g_bgcj3_d[4].tnum2 = l_bgcj045
            LET g_bgcj3_d[4].tprice2 = l_bgcj046
            LET g_bgcj3_d[4].tamt2 = l_bgcj102
         WHEN 3 
            LET g_bgcj3_d[1].tnum3 = l_bgcj038
            LET g_bgcj3_d[1].tprice3 = l_bgcj039
            LET g_bgcj3_d[1].tamt3 = l_bgcj040
            LET g_bgcj3_d[2].tnum3 = l_bgcj041
            LET g_bgcj3_d[2].tprice3 = l_bgcj042
            LET g_bgcj3_d[2].tamt3 = l_amt1
            LET g_bgcj3_d[3].tnum3 = l_bgcj043
            LET g_bgcj3_d[3].tprice3 = l_bgcj044
            LET g_bgcj3_d[3].tamt3 = l_amt2
            LET g_bgcj3_d[4].tnum3 = l_bgcj045
            LET g_bgcj3_d[4].tprice3 = l_bgcj046
            LET g_bgcj3_d[4].tamt3 = l_bgcj102
         WHEN 4 
            LET g_bgcj3_d[1].tnum4 = l_bgcj038
            LET g_bgcj3_d[1].tprice4 = l_bgcj039
            LET g_bgcj3_d[1].tamt4 = l_bgcj040
            LET g_bgcj3_d[2].tnum4 = l_bgcj041
            LET g_bgcj3_d[2].tprice4 = l_bgcj042
            LET g_bgcj3_d[2].tamt4 = l_amt1
            LET g_bgcj3_d[3].tnum4 = l_bgcj043
            LET g_bgcj3_d[3].tprice4 = l_bgcj044
            LET g_bgcj3_d[3].tamt4 = l_amt2
            LET g_bgcj3_d[4].tnum4 = l_bgcj045
            LET g_bgcj3_d[4].tprice4 = l_bgcj046
            LET g_bgcj3_d[4].tamt4 = l_bgcj102
         WHEN 5
            LET g_bgcj3_d[1].tnum5 = l_bgcj038
            LET g_bgcj3_d[1].tprice5 = l_bgcj039
            LET g_bgcj3_d[1].tamt5 = l_bgcj040
            LET g_bgcj3_d[2].tnum5 = l_bgcj041
            LET g_bgcj3_d[2].tprice5 = l_bgcj042
            LET g_bgcj3_d[2].tamt5 = l_amt1
            LET g_bgcj3_d[3].tnum5 = l_bgcj043
            LET g_bgcj3_d[3].tprice5 = l_bgcj044
            LET g_bgcj3_d[3].tamt5 = l_amt2
            LET g_bgcj3_d[4].tnum5 = l_bgcj045
            LET g_bgcj3_d[4].tprice5 = l_bgcj046
            LET g_bgcj3_d[4].tamt5 = l_bgcj102
         WHEN 6 
            LET g_bgcj3_d[1].tnum6 = l_bgcj038
            LET g_bgcj3_d[1].tprice6 = l_bgcj039
            LET g_bgcj3_d[1].tamt6 = l_bgcj040
            LET g_bgcj3_d[2].tnum6 = l_bgcj041
            LET g_bgcj3_d[2].tprice6 = l_bgcj042
            LET g_bgcj3_d[2].tamt6 = l_amt1
            LET g_bgcj3_d[3].tnum6 = l_bgcj043
            LET g_bgcj3_d[3].tprice6 = l_bgcj044
            LET g_bgcj3_d[3].tamt6 = l_amt2
            LET g_bgcj3_d[4].tnum6 = l_bgcj045
            LET g_bgcj3_d[4].tprice6 = l_bgcj046
            LET g_bgcj3_d[4].tamt6 = l_bgcj102
         WHEN 7 
            LET g_bgcj3_d[1].tnum7 = l_bgcj038
            LET g_bgcj3_d[1].tprice7 = l_bgcj039
            LET g_bgcj3_d[1].tamt7 = l_bgcj040
            LET g_bgcj3_d[2].tnum7 = l_bgcj041
            LET g_bgcj3_d[2].tprice7 = l_bgcj042
            LET g_bgcj3_d[2].tamt7 = l_amt1
            LET g_bgcj3_d[3].tnum7 = l_bgcj043
            LET g_bgcj3_d[3].tprice7 = l_bgcj044
            LET g_bgcj3_d[3].tamt7 = l_amt2
            LET g_bgcj3_d[4].tnum7 = l_bgcj045
            LET g_bgcj3_d[4].tprice7 = l_bgcj046
            LET g_bgcj3_d[4].tamt7 = l_bgcj102
         WHEN 8 
            LET g_bgcj3_d[1].tnum8 = l_bgcj038
            LET g_bgcj3_d[1].tprice8 = l_bgcj039
            LET g_bgcj3_d[1].tamt8 = l_bgcj040
            LET g_bgcj3_d[2].tnum8 = l_bgcj041
            LET g_bgcj3_d[2].tprice8 = l_bgcj042
            LET g_bgcj3_d[2].tamt8 = l_amt1
            LET g_bgcj3_d[3].tnum8 = l_bgcj043
            LET g_bgcj3_d[3].tprice8 = l_bgcj044
            LET g_bgcj3_d[3].tamt8 = l_amt2
            LET g_bgcj3_d[4].tnum8 = l_bgcj045
            LET g_bgcj3_d[4].tprice8 = l_bgcj046
            LET g_bgcj3_d[4].tamt8 = l_bgcj102
         WHEN 9 
            LET g_bgcj3_d[1].tnum9 = l_bgcj038
            LET g_bgcj3_d[1].tprice9 = l_bgcj039
            LET g_bgcj3_d[1].tamt9 = l_bgcj040
            LET g_bgcj3_d[2].tnum9 = l_bgcj041
            LET g_bgcj3_d[2].tprice9 = l_bgcj042
            LET g_bgcj3_d[2].tamt9 = l_amt1
            LET g_bgcj3_d[3].tnum9 = l_bgcj043
            LET g_bgcj3_d[3].tprice9 = l_bgcj044
            LET g_bgcj3_d[3].tamt9 = l_amt2
            LET g_bgcj3_d[4].tnum9 = l_bgcj045
            LET g_bgcj3_d[4].tprice9 = l_bgcj046
            LET g_bgcj3_d[4].tamt9 = l_bgcj102
         WHEN 10 
            LET g_bgcj3_d[1].tnum10 = l_bgcj038
            LET g_bgcj3_d[1].tprice10 = l_bgcj039
            LET g_bgcj3_d[1].tamt10 = l_bgcj040
            LET g_bgcj3_d[2].tnum10 = l_bgcj041
            LET g_bgcj3_d[2].tprice10 = l_bgcj042
            LET g_bgcj3_d[2].tamt10 = l_amt1
            LET g_bgcj3_d[3].tnum10 = l_bgcj043
            LET g_bgcj3_d[3].tprice10 = l_bgcj044
            LET g_bgcj3_d[3].tamt10 = l_amt2
            LET g_bgcj3_d[4].tnum10 = l_bgcj045
            LET g_bgcj3_d[4].tprice10 = l_bgcj046
            LET g_bgcj3_d[4].tamt10 = l_bgcj102
         WHEN 11 
            LET g_bgcj3_d[1].tnum11 = l_bgcj038
            LET g_bgcj3_d[1].tprice11 = l_bgcj039
            LET g_bgcj3_d[1].tamt11 = l_bgcj040
            LET g_bgcj3_d[2].tnum11 = l_bgcj041
            LET g_bgcj3_d[2].tprice11 = l_bgcj042
            LET g_bgcj3_d[2].tamt11 = l_amt1
            LET g_bgcj3_d[3].tnum11 = l_bgcj043
            LET g_bgcj3_d[3].tprice11 = l_bgcj044
            LET g_bgcj3_d[3].tamt11 = l_amt2
            LET g_bgcj3_d[4].tnum11 = l_bgcj045
            LET g_bgcj3_d[4].tprice11 = l_bgcj046
            LET g_bgcj3_d[4].tamt11 = l_bgcj102
         WHEN 12 
            LET g_bgcj3_d[1].tnum12 = l_bgcj038
            LET g_bgcj3_d[1].tprice12 = l_bgcj039
            LET g_bgcj3_d[1].tamt12 = l_bgcj040
            LET g_bgcj3_d[2].tnum12 = l_bgcj041
            LET g_bgcj3_d[2].tprice12 = l_bgcj042
            LET g_bgcj3_d[2].tamt12 = l_amt1
            LET g_bgcj3_d[3].tnum12 = l_bgcj043
            LET g_bgcj3_d[3].tprice12 = l_bgcj044
            LET g_bgcj3_d[3].tamt12 = l_amt2
            LET g_bgcj3_d[4].tnum12 = l_bgcj045
            LET g_bgcj3_d[4].tprice12 = l_bgcj046
            LET g_bgcj3_d[4].tamt12 = l_bgcj102
         WHEN 13 
            LET g_bgcj3_d[1].tnum13 = l_bgcj038
            LET g_bgcj3_d[1].tprice13 = l_bgcj039
            LET g_bgcj3_d[1].tamt13 = l_bgcj040
            LET g_bgcj3_d[2].tnum13 = l_bgcj041
            LET g_bgcj3_d[2].tprice13 = l_bgcj042
            LET g_bgcj3_d[2].tamt13 = l_amt1
            LET g_bgcj3_d[3].tnum13 = l_bgcj043
            LET g_bgcj3_d[3].tprice13 = l_bgcj044
            LET g_bgcj3_d[3].tamt13 = l_amt2
            LET g_bgcj3_d[4].tnum13 = l_bgcj045
            LET g_bgcj3_d[4].tprice13 = l_bgcj046
            LET g_bgcj3_d[4].tamt13 = l_bgcj102
      END CASE
   END FOR
   
   #合计
   LET l_sql="SELECT SUM(bgcj040),",
             "       SUM(bgcj041 * (bgcj039 + bgcj042) + bgcj038 * bgcj042),",
             "       SUM(bgcj043 * (bgcj039 + bgcj044) + bgcj038 * bgcj044),",
             "       SUM(bgcj102)",
             "  FROM bgcj_t ",
             " WHERE bgcjent =  ",g_enterprise,
             "   AND bgcj001 = '",g_bgcj_m.bgcj001,"'",
             "   AND bgcj002 = '",g_bgcj_m.bgcj002,"'",
             "   AND bgcj003 = '",g_bgcj_m.bgcj003,"'",
             "   AND bgcj004 = '",g_bgcj_m.bgcj004,"'",
             "   AND bgcj005 = '",g_bgcj_m.bgcj005,"'",
             "   AND bgcj006 = '",g_bgcj_m.bgcj006,"'",
             "   AND bgcj010 = '",g_bgcj_d[pi_idx].bgcj010,"'",
             "   AND bgcjseq =  ",g_bgcj_d[pi_idx].bgcjseq
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj_m.bgcj007,"'"
   ELSE
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj_d[pi_idx].bgcj007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj_m.bgcj009,"'"
   ELSE
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj_d[pi_idx].bgcj009,"'"
   END IF
   PREPARE abgt340_b_fill2_sum_pr FROM l_sql
   EXECUTE abgt340_b_fill2_sum_pr INTO g_bgcj3_d[1].sum,g_bgcj3_d[2].sum,g_bgcj3_d[3].sum,g_bgcj3_d[4].sum 
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgt340_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   DEFINE l_sql           STRING
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   IF 1=2 THEN
   #end add-point
   
   DELETE FROM bgcj_t
    WHERE bgcjent = g_enterprise AND bgcj001 = g_bgcj_m.bgcj001 AND
                              bgcj002 = g_bgcj_m.bgcj002 AND
                              bgcj003 = g_bgcj_m.bgcj003 AND
                              bgcj004 = g_bgcj_m.bgcj004 AND
                              bgcj005 = g_bgcj_m.bgcj005 AND
                              bgcj006 = g_bgcj_m.bgcj006 AND
                              bgcj007 = g_bgcj_m.bgcj007 AND
                              bgcj009 = g_bgcj_m.bgcj009 AND
                              bgcj010 = g_bgcj_m.bgcj010 AND
 
          bgcj008 = g_bgcj_d_t.bgcj008
      AND bgcjseq = g_bgcj_d_t.bgcjseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   END IF
   
   LET l_sql = "DELETE FROM bgcj_t ",
                " WHERE bgcjent = ",g_enterprise,
                "   AND bgcj001 ='",g_bgcj_m.bgcj001,"'",
                "   AND bgcj002 ='",g_bgcj_m.bgcj002,"'",
                "   AND bgcj003 ='",g_bgcj_m.bgcj003,"'",
                "   AND bgcj004 ='",g_bgcj_m.bgcj004,"'",
                "   AND bgcj005 ='",g_bgcj_m.bgcj005,"'",
                "   AND bgcj006 ='",g_bgcj_m.bgcj006,"'"
    #预算组织在单头
    IF g_bgaw1[1] = 'Y' THEN
       LET l_sql = l_sql," AND bgcj007 ='",g_bgcj_m.bgcj007,"'"
    ELSE
       LET l_sql = l_sql," AND bgcj007 ='",g_bgcj_d_t.bgcj007,"'"
    END IF
    #预算料号在单头
    IF g_bgaw1[2] = 'Y' THEN
       LET l_sql = l_sql," AND bgcj009 ='",g_bgcj_m.bgcj009,"'"
    ELSE
       LET l_sql = l_sql," AND bgcj009 ='",g_bgcj_d_t.bgcj009,"'"
    END IF
    LET l_sql = l_sql," AND bgcj010 ='",g_bgcj_d_t.bgcj010,"'",
                      " AND bgcjseq = ",g_bgcj_d_t.bgcjseq
                      
    PREPARE abgt340_before_delete_pr FROM l_sql
    EXECUTE abgt340_before_delete_pr
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
 
{<section id="abgt340.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt340_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgt340.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt340_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgt340.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt340_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgt340.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgt340_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bgcj_d[l_ac].bgcj008 = g_bgcj_d_t.bgcj008 
      AND g_bgcj_d[l_ac].bgcjseq = g_bgcj_d_t.bgcjseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt340_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgt340.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt340_lock_b(ps_table,ps_page)
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
   #CALL abgt340_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt340.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt340_unlock_b(ps_table,ps_page)
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
 
{<section id="abgt340.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt340_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj009,bgcj010",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bgcj006",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt340.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt340_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj009,bgcj010",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("bgcj007,bgcj009",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt340.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt340_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt340_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt340_set_act_visible()
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
 
{<section id="abgt340.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt340_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bgcj_m.bgcjstus NOT MATCHES "[NDR]" THEN   
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt340.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt340_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt340.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt340_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt340.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt340_default_search()
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
      LET ls_wc = ls_wc, " bgcj001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgcj002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bgcj003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bgcj004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bgcj005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bgcj006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " bgcj007 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " bgcj009 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " bgcj010 = '", g_argv[09], "' AND "
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
 
{<section id="abgt340.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt340_fill_chk(ps_idx)
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
 
{<section id="abgt340.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgt340_modify_detail_chk(ps_record)
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
         LET ls_return = "bgcjseq"
      WHEN "s_detail2"
         LET ls_return = "bgcjseq_2"
      WHEN "s_detail3"
         LET ls_return = "bgcjseq_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340.mask_functions" >}
&include "erp/abg/abgt340_mask.4gl"
 
{</section>}
 
{<section id="abgt340.state_change" >}
    
 
{</section>}
 
{<section id="abgt340.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt340_set_pk_array()
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
   LET g_pk_array[1].values = g_bgcj_m.bgcj001
   LET g_pk_array[1].column = 'bgcj001'
   LET g_pk_array[2].values = g_bgcj_m.bgcj002
   LET g_pk_array[2].column = 'bgcj002'
   LET g_pk_array[3].values = g_bgcj_m.bgcj003
   LET g_pk_array[3].column = 'bgcj003'
   LET g_pk_array[4].values = g_bgcj_m.bgcj004
   LET g_pk_array[4].column = 'bgcj004'
   LET g_pk_array[5].values = g_bgcj_m.bgcj005
   LET g_pk_array[5].column = 'bgcj005'
   LET g_pk_array[6].values = g_bgcj_m.bgcj006
   LET g_pk_array[6].column = 'bgcj006'
   LET g_pk_array[7].values = g_bgcj_m.bgcj007
   LET g_pk_array[7].column = 'bgcj007'
   LET g_pk_array[8].values = g_bgcj_m.bgcj009
   LET g_pk_array[8].column = 'bgcj009'
   LET g_pk_array[9].values = g_bgcj_m.bgcj010
   LET g_pk_array[9].column = 'bgcj010'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt340.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt340_msgcentre_notify(lc_state)
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
   CALL abgt340_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgcj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt340.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 设置核算项在单头或是单身，以及是否显示
# Memo...........:
# Usage..........: CALL abgt340_set_hsx_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/28 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_set_hsx_visible()
   DEFINE l_flag1        LIKE type_t.num5 #单头显示核算项个数
   
   LET l_flag1 = 0
   #单头显示栏位
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj007,bgcj007_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj007,bgcj007_desc_t",FALSE)
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj009",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj009",FALSE)
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj013,bgcj013_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj013,bgcj013_desc_t",FALSE)
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj014,bgcj014_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj014,bgcj014_desc_t",FALSE)
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj015,bgcj015_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj015,bgcj015_desc_t",FALSE)
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj016,bgcj016_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj016,bgcj016_desc_t",FALSE)
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj017,bgcj017_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj017,bgcj017_desc_t",FALSE)
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj018,bgcj018_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj018,bgcj018_desc_t",FALSE)
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj019,bgcj019_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj019,bgcj019_desc_t",FALSE)
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj022",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj022",FALSE)
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj023,bgcj023_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj023,bgcj023_desc_t",FALSE)
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj024,bgcj024_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj024,bgcj024_desc_t",FALSE)
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj012,bgcj012_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj012,bgcj012_desc_t",FALSE)
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj020,bgcj020_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj020,bgcj020_desc_t",FALSE)
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj021,bgcj021_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgcj021,bgcj021_desc_t",FALSE)
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
      CALL cl_set_comp_visible("bgcj007_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj007_desc",FALSE)
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj009_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj009_desc",FALSE)
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj013_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj013_desc",FALSE)
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj014_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj014_desc",FALSE)
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj015_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj015_desc",FALSE)
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj016_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj016_desc",FALSE)
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj017_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj017_desc",FALSE)
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj018_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj018_desc",FALSE)
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj019_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj019_desc",FALSE)
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj022_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj022_2",FALSE)
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj023_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj023_desc",FALSE)
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj024_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj024_desc",FALSE)
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj012_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj012_desc",FALSE)
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj020_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj020_desc",FALSE)
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      CALL cl_set_comp_visible("bgcj021_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgcj021_desc",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据预算编号+预算组织+预算细项设置核算项的启用情况，启用时可以录入，不启用时不可录入，默认给空白
# Memo...........:
# Usage..........: CALL abgt340_set_head_hsx_entry(p_bgcj002,p_bgcj007,p_bgcj049)
# Input parameter: p_bgcj002      预算编号
#                : p_bgcj007      预算组织
#                : p_bgcj049      预算细项
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_set_head_hsx_entry(p_bgcj002,p_bgcj007,p_bgcj049)
   DEFINE p_bgcj002       LIKE bgcj_t.bgcj002
   DEFINE p_bgcj007       LIKE bgcj_t.bgcj007
   DEFINE p_bgcj049       LIKE bgcj_t.bgcj049
   
   IF cl_null(p_bgcj002) OR cl_null(p_bgcj007) OR cl_null(p_bgcj049) THEN
      RETURN
   END IF
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=p_bgcj002
      AND bgal002=p_bgcj007 AND bgal003=p_bgcj049
   #单头核算项栏位录入设置
   #部门
   IF g_bgaw1[3]='Y' THEN
      IF g_bgal.bgal005 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj013",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj013",FALSE)
         LET g_bgcj_m.bgcj013 = ' '
         LET g_bgcj_m.bgcj013_desc_t = ''
      END IF
   END IF
   #利润成本中心
   IF g_bgaw1[4]='Y' THEN
      IF g_bgal.bgal006 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj014",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj014",FALSE)
         LET g_bgcj_m.bgcj014 = ' '
         LET g_bgcj_m.bgcj014_desc_t = ''
      END IF
   END IF
   #区域
   IF g_bgaw1[5]='Y' THEN
      IF g_bgal.bgal007 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj015",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj015",FALSE)
         LET g_bgcj_m.bgcj015 = ' '
         LET g_bgcj_m.bgcj015_desc_t = ''
      END IF
   END IF
   #收付款客商
   IF g_bgaw1[6]='Y' THEN
      IF g_bgal.bgal008 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj016",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj016",FALSE)
         LET g_bgcj_m.bgcj016 = ' '
         LET g_bgcj_m.bgcj016_desc_t = ''
      END IF
   END IF 
   #账款客商
   IF g_bgaw1[7]='Y' THEN
      IF g_bgal.bgal009 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj017",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj017",FALSE)
         LET g_bgcj_m.bgcj017 = ' '
         LET g_bgcj_m.bgcj017_desc_t = ''
      END IF
   END IF  
   #客群
   IF g_bgaw1[8]='Y' THEN
      IF g_bgal.bgal010 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj018",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj018",FALSE)
         LET g_bgcj_m.bgcj018 = ' '
         LET g_bgcj_m.bgcj018_desc_t = ''
      END IF
   END IF
   #产品类别
   IF g_bgaw1[9]='Y' THEN
      IF g_bgal.bgal011 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj019",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj019",FALSE)
         LET g_bgcj_m.bgcj019 = ' '
         LET g_bgcj_m.bgcj019_desc_t = ''
      END IF
   END IF
   #经营方式
   IF g_bgaw1[10]='Y' THEN
      IF g_bgal.bgal025 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj022",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj022",FALSE)
         LET g_bgcj_m.bgcj022 = ' '
      END IF
   END IF
   #通路
   IF g_bgaw1[11]='Y' THEN
      IF g_bgal.bgal026 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj023",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj023",FALSE)
         LET g_bgcj_m.bgcj023 = ' '
         LET g_bgcj_m.bgcj023_desc_t = ''
      END IF
   END IF
   #品牌
   IF g_bgaw1[12]='Y' THEN
      IF g_bgal.bgal027 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj024",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj024",FALSE)
         LET g_bgcj_m.bgcj024 = ' '
         LET g_bgcj_m.bgcj024_desc_t = ''
      END IF
   END IF
   #人员
   IF g_bgaw1[13]='Y' THEN
      IF g_bgal.bgal012 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj012",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj012",FALSE)
         LET g_bgcj_m.bgcj012 = ' '
         LET g_bgcj_m.bgcj012_desc_t = ''
      END IF
   END IF
   #专案
   IF g_bgaw1[14]='Y' THEN
      IF g_bgal.bgal013 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj020",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj020",FALSE)
         LET g_bgcj_m.bgcj020 = ' '
         LET g_bgcj_m.bgcj020_desc_t = ''
      END IF
   END IF
   #WBS
   IF g_bgaw1[15]='Y' THEN
      IF g_bgal.bgal014 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj021",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj021",FALSE)
         LET g_bgcj_m.bgcj021 = ' '
         LET g_bgcj_m.bgcj021_desc_t = ''
      END IF
   END IF
   DISPLAY BY NAME g_bgcj_m.bgcj013,g_bgcj_m.bgcj014,g_bgcj_m.bgcj015,g_bgcj_m.bgcj016,g_bgcj_m.bgcj017,
                   g_bgcj_m.bgcj018,g_bgcj_m.bgcj019,g_bgcj_m.bgcj020,g_bgcj_m.bgcj021,g_bgcj_m.bgcj022,
                   g_bgcj_m.bgcj023,g_bgcj_m.bgcj024,
                   g_bgcj_m.bgcj013_desc_t,g_bgcj_m.bgcj014_desc_t,g_bgcj_m.bgcj015_desc_t,g_bgcj_m.bgcj016_desc_t,
                   g_bgcj_m.bgcj017_desc_t,g_bgcj_m.bgcj018_desc_t,g_bgcj_m.bgcj019_desc_t,g_bgcj_m.bgcj020_desc_t,
                   g_bgcj_m.bgcj021_desc_t,g_bgcj_m.bgcj023_desc_t,g_bgcj_m.bgcj024_desc_t
   
END FUNCTION

################################################################################
# Descriptions...: 根据预算编号+预算组织+预算细项设置核算项的启用情况，启用时可以录入，不启用时不可录入，默认给空白
# Memo...........:
# Usage..........: CALL abgt340_set_detail_hsx_entry(p_bgcj002,p_bgcj007,p_bgcj049)
# Input parameter: p_bgcj002      预算编号
#                : p_bgcj007      预算组织
#                : p_bgcj049      预算细项
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_set_detail_hsx_entry(p_bgcj002,p_bgcj007,p_bgcj049)
   DEFINE p_bgcj002       LIKE bgcj_t.bgcj002
   DEFINE p_bgcj007       LIKE bgcj_t.bgcj007
   DEFINE p_bgcj049       LIKE bgcj_t.bgcj049
   
   IF cl_null(p_bgcj002) OR cl_null(p_bgcj007) OR cl_null(p_bgcj049) THEN
      RETURN
   END IF
   
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=p_bgcj002
      AND bgal002=p_bgcj007 AND bgal003=p_bgcj049
   #单身核算项栏位录入设置
   #部门
   IF g_bgaw2[3]='Y' THEN
      IF g_bgal.bgal005 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj013_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj013_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj013 = ' '
      END IF
   END IF
   #利润成本中心
   IF g_bgaw2[4]='Y' THEN
      IF g_bgal.bgal006 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj014_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj014_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj014 = ' '
      END IF
   END IF
   #区域
   IF g_bgaw2[5]='Y' THEN
      IF g_bgal.bgal007 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj015_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj015_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj015 = ' '
      END IF
   END IF
   #收付款客商
   IF g_bgaw2[6]='Y' THEN
      IF g_bgal.bgal008 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj016_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj016_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj016 = ' '
      END IF
   END IF 
   #账款客商
   IF g_bgaw2[7]='Y' THEN
      IF g_bgal.bgal009 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj017_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj017_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj017 = ' '
      END IF
   END IF  
   #客群
   IF g_bgaw2[8]='Y' THEN
      IF g_bgal.bgal010 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj018_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj018_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj018 = ' '
      END IF
   END IF
   #产品类别
   IF g_bgaw2[9]='Y' THEN
      IF g_bgal.bgal011 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj019_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj019_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj019 = ' '
      END IF
   END IF
   #经营方式
   IF g_bgaw2[10]='Y' THEN
      IF g_bgal.bgal025 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj022_2",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj022_2",FALSE)
         LET g_bgcj_d[l_ac].bgcj022 = ' '
      END IF
   END IF
   #通路
   IF g_bgaw2[11]='Y' THEN
      IF g_bgal.bgal026 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj023_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj023_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj023 = ' '
      END IF
   END IF
   #品牌
   IF g_bgaw2[12]='Y' THEN
      IF g_bgal.bgal027 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj024_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj024_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj024 = ' '
      END IF
   END IF
   #人员
   IF g_bgaw2[13]='Y' THEN
      IF g_bgal.bgal012 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj012_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj012_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj012 = ' '
      END IF
   END IF
   #专案
   IF g_bgaw2[14]='Y' THEN
      IF g_bgal.bgal013 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj020_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj020_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj020 = ' '
      END IF
   END IF
   #WBS
   IF g_bgaw2[15]='Y' THEN
      IF g_bgal.bgal014 = 'Y' THEN
         CALL cl_set_comp_entry("bgcj021_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgcj021_desc",FALSE)
         LET g_bgcj_d[l_ac].bgcj021 = ' '
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据销售来源设置预测料号在画面中显示的说明，
# Memo...........:
# Usage..........: CALL abgt340_set_bgcj005_text(p_bgcj005)
#                  RETURNING 回传参数
# Input parameter: bgcj005        1.预算料号 2.模拟收入项目
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_set_bgcj005_text(p_bgcj005)
   DEFINE p_bgcj005           LIKE bgcj_t.bgcj005
   DEFINE l_dzebl003          LIKE dzebl_t.dzebl003   
   
   #4.招商收入
   IF p_bgcj005='4' THEN
      SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t  
       WHERE dzebl001='bgcc001' AND dzebl002=g_dlang
   ELSE
      SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t  
       WHERE dzebl001='bgcj009' AND dzebl002=g_dlang
   END IF
   CALL cl_set_comp_att_text('lbl_bgcj009',l_dzebl003)
END FUNCTION

################################################################################
# Descriptions...: 显示单头核算项说明
# Memo...........:
# Usage..........: CALL abgt340_head_hsx_desc()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_head_hsx_desc()
   #单头显示栏位
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgcj_m.bgcj007) RETURNING g_bgcj_m.bgcj007_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj007_desc_t
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgcj_m.bgcj013) RETURNING g_bgcj_m.bgcj013_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj013_desc_t
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgcj_m.bgcj014) RETURNING g_bgcj_m.bgcj014_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj014_desc_t
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      CALL s_desc_get_acc_desc('287',g_bgcj_m.bgcj015) RETURNING g_bgcj_m.bgcj015_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj015_desc_t
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj016) RETURNING g_bgcj_m.bgcj016_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj016_desc_t
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgcj_m.bgcj017) RETURNING g_bgcj_m.bgcj017_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj017_desc_t
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      CALL s_desc_get_acc_desc('281',g_bgcj_m.bgcj018) RETURNING g_bgcj_m.bgcj018_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj018_desc_t
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      CALL s_desc_get_rtaxl003_desc(g_bgcj_m.bgcj019) RETURNING g_bgcj_m.bgcj019_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj019_desc_t
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgcj_m.bgcj023) RETURNING g_bgcj_m.bgcj023_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj023_desc_t
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      CALL s_desc_get_acc_desc('2002',g_bgcj_m.bgcj024) RETURNING g_bgcj_m.bgcj024_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj024_desc_t
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      CALL s_desc_get_person_desc(g_bgcj_m.bgcj012) RETURNING g_bgcj_m.bgcj012_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj012_desc_t
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgcj_m.bgcj020) RETURNING g_bgcj_m.bgcj020_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj020_desc_t
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      CALL s_desc_get_wbs_desc(g_bgcj_m.bgcj020,g_bgcj_m.bgcj021) RETURNING g_bgcj_m.bgcj021_desc_t
      DISPLAY BY NAME g_bgcj_m.bgcj021_desc_t
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 获取该项次对应的各个期别的数量、单价、销售金额
# Memo...........:
# Usage..........: CALL abgt340_get_num_and_price()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_get_num_and_price()
   DEFINE l_sql          STRING
   DEFINE l_bgcj008      LIKE bgcj_t.bgcj008
   DEFINE l_bgcj038      LIKE bgcj_t.bgcj038
   DEFINE l_bgcj039      LIKE bgcj_t.bgcj039
   DEFINE l_bgcj040      LIKE bgcj_t.bgcj040
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   
   LET l_sql="SELECT bgcj008,bgcj038,bgcj039,bgcj040 ",
             "  FROM bgcj_t ",
             " WHERE bgcjent=",g_enterprise," AND bgcj001='",g_bgcj_m.bgcj001,"' ",
             "   AND bgcj002='",g_bgcj_m.bgcj002,"' AND bgcj003='",g_bgcj_m.bgcj003,"' ",
             "   AND bgcj004='",g_bgcj_m.bgcj004,"' AND bgcj005='",g_bgcj_m.bgcj005,"' ",
             "   AND bgcj006='",g_bgcj_m.bgcj006,"' AND bgcjseq=",g_bgcj_d[l_ac].bgcjseq
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj007='",g_bgcj_m.bgcj007,"'"
   ELSE
      LET l_sql = l_sql," AND bgcj007='",g_bgcj_d[l_ac].bgcj007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj009='",g_bgcj_m.bgcj009,"'"
   ELSE
      LET l_sql = l_sql," AND bgcj009='",g_bgcj_d[l_ac].bgcj009,"'"
   END IF
   LET l_sql = l_sql," ORDER BY bgcj008"
   PREPARE abgt340_sel_amt_pr FROM l_sql
   DECLARE abgt340_sel_amt_cs CURSOR FOR abgt340_sel_amt_pr
   
   FOREACH abgt340_sel_amt_cs INTO l_bgcj008,l_bgcj038,l_bgcj039,l_bgcj040
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CASE l_bgcj008
         WHEN 1
            LET g_bgcj_d[l_ac].num1=l_bgcj038
            LET g_bgcj_d[l_ac].price1=l_bgcj039
            LET g_bgcj_d[l_ac].amt1=l_bgcj040
         WHEN 2
            LET g_bgcj_d[l_ac].num2=l_bgcj038
            LET g_bgcj_d[l_ac].price2=l_bgcj039
            LET g_bgcj_d[l_ac].amt2=l_bgcj040
         WHEN 3
            LET g_bgcj_d[l_ac].num3=l_bgcj038
            LET g_bgcj_d[l_ac].price3=l_bgcj039
            LET g_bgcj_d[l_ac].amt3=l_bgcj040
         WHEN 4
            LET g_bgcj_d[l_ac].num4=l_bgcj038
            LET g_bgcj_d[l_ac].price4=l_bgcj039
            LET g_bgcj_d[l_ac].amt4=l_bgcj040
         WHEN 5
            LET g_bgcj_d[l_ac].num5=l_bgcj038
            LET g_bgcj_d[l_ac].price5=l_bgcj039
            LET g_bgcj_d[l_ac].amt5=l_bgcj040
         WHEN 6
            LET g_bgcj_d[l_ac].num6=l_bgcj038
            LET g_bgcj_d[l_ac].price6=l_bgcj039
            LET g_bgcj_d[l_ac].amt6=l_bgcj040 
         WHEN 7
            LET g_bgcj_d[l_ac].num7=l_bgcj038
            LET g_bgcj_d[l_ac].price7=l_bgcj039
            LET g_bgcj_d[l_ac].amt7=l_bgcj040
         WHEN 8
            LET g_bgcj_d[l_ac].num8=l_bgcj038
            LET g_bgcj_d[l_ac].price8=l_bgcj039
            LET g_bgcj_d[l_ac].amt8=l_bgcj040
         WHEN 9
            LET g_bgcj_d[l_ac].num9=l_bgcj038
            LET g_bgcj_d[l_ac].price9=l_bgcj039
            LET g_bgcj_d[l_ac].amt9=l_bgcj040
         WHEN 10
            LET g_bgcj_d[l_ac].num10=l_bgcj038
            LET g_bgcj_d[l_ac].price10=l_bgcj039
            LET g_bgcj_d[l_ac].amt10=l_bgcj040
         WHEN 11
            LET g_bgcj_d[l_ac].num11=l_bgcj038
            LET g_bgcj_d[l_ac].price11=l_bgcj039
            LET g_bgcj_d[l_ac].amt11=l_bgcj040
         WHEN 12
            LET g_bgcj_d[l_ac].num12=l_bgcj038
            LET g_bgcj_d[l_ac].price12=l_bgcj039
            LET g_bgcj_d[l_ac].amt12=l_bgcj040    
         WHEN 13
            LET g_bgcj_d[l_ac].num13=l_bgcj038
            LET g_bgcj_d[l_ac].price13=l_bgcj039
            LET g_bgcj_d[l_ac].amt13=l_bgcj040 
      END CASE      
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 获取核算项单身核算项说明
# Memo...........:
# Usage..........: CALL abgt340_detail_hsx_desc()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_detail_hsx_desc()
   DEFINE l_bgasl003    LIKE bgasl_t.bgasl003
   DEFINE l_bgasl004    LIKE bgasl_t.bgasl004
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   
   #单身显示栏位
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj007) RETURNING g_bgcj_d[l_ac].bgcj007_desc
      LET g_bgcj_d[l_ac].bgcj007_desc=g_bgcj_d[l_ac].bgcj007,"  ",g_bgcj_d[l_ac].bgcj007_desc
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      #销售来源4.招商收入，抓取模拟收入项目说明
      IF g_bgcj_m.bgcj005 = '4' THEN
         CALL s_desc_get_bgcc001_desc(g_bgcj_d[l_ac].bgcj009) RETURNING g_bgcj_d[l_ac].bgcj009_desc
         LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d[l_ac].bgcj009,"  ",g_bgcj_d[l_ac].bgcj009_desc
      ELSE
      #销售来源1.外部订单,抓取料件的品名规格
         CALL s_desc_get_bgas001_desc(g_bgcj_d[l_ac].bgcj009) RETURNING l_bgasl003,l_bgasl004
         LET g_bgcj_d[l_ac].bgcj009_desc = g_bgcj_d[l_ac].bgcj009,"  ",l_bgasl003,"  ",l_bgasl004
      END IF
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj013) RETURNING g_bgcj_d[l_ac].bgcj013_desc
      LET g_bgcj_d[l_ac].bgcj013_desc=g_bgcj_d[l_ac].bgcj013,"  ",g_bgcj_d[l_ac].bgcj013_desc
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgcj_d[l_ac].bgcj014) RETURNING g_bgcj_d[l_ac].bgcj014_desc
      LET g_bgcj_d[l_ac].bgcj014_desc=g_bgcj_d[l_ac].bgcj014,"  ",g_bgcj_d[l_ac].bgcj014_desc
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      CALL s_desc_get_acc_desc('287',g_bgcj_d[l_ac].bgcj015) RETURNING g_bgcj_d[l_ac].bgcj015_desc
      LET g_bgcj_d[l_ac].bgcj015_desc=g_bgcj_d[l_ac].bgcj015,"  ",g_bgcj_d[l_ac].bgcj015_desc
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj016) RETURNING g_bgcj_d[l_ac].bgcj016_desc
      LET g_bgcj_d[l_ac].bgcj016_desc=g_bgcj_d[l_ac].bgcj016,"  ",g_bgcj_d[l_ac].bgcj016_desc
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgcj_d[l_ac].bgcj017) RETURNING g_bgcj_d[l_ac].bgcj017_desc
      LET g_bgcj_d[l_ac].bgcj017_desc=g_bgcj_d[l_ac].bgcj017,"  ",g_bgcj_d[l_ac].bgcj017_desc
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      CALL s_desc_get_acc_desc('281',g_bgcj_d[l_ac].bgcj018) RETURNING g_bgcj_d[l_ac].bgcj018_desc
      LET g_bgcj_d[l_ac].bgcj018_desc=g_bgcj_d[l_ac].bgcj018,"  ",g_bgcj_d[l_ac].bgcj018_desc
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      CALL s_desc_get_rtaxl003_desc(g_bgcj_d[l_ac].bgcj019) RETURNING g_bgcj_d[l_ac].bgcj019_desc
      LET g_bgcj_d[l_ac].bgcj019_desc=g_bgcj_d[l_ac].bgcj019,"  ",g_bgcj_d[l_ac].bgcj019_desc
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgcj_d[l_ac].bgcj023) RETURNING g_bgcj_d[l_ac].bgcj023_desc
      LET g_bgcj_d[l_ac].bgcj023_desc=g_bgcj_d[l_ac].bgcj023,"  ",g_bgcj_d[l_ac].bgcj023_desc
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      CALL s_desc_get_acc_desc('2002',g_bgcj_d[l_ac].bgcj024) RETURNING g_bgcj_d[l_ac].bgcj024_desc
      LET g_bgcj_d[l_ac].bgcj024_desc=g_bgcj_d[l_ac].bgcj024,"  ",g_bgcj_d[l_ac].bgcj024_desc
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      CALL s_desc_get_person_desc(g_bgcj_d[l_ac].bgcj012) RETURNING g_bgcj_d[l_ac].bgcj012_desc
      LET g_bgcj_d[l_ac].bgcj012_desc=g_bgcj_d[l_ac].bgcj012,"  ",g_bgcj_d[l_ac].bgcj012_desc
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgcj_d[l_ac].bgcj020) RETURNING g_bgcj_d[l_ac].bgcj020_desc
      LET g_bgcj_d[l_ac].bgcj020_desc=g_bgcj_d[l_ac].bgcj020,"  ",g_bgcj_d[l_ac].bgcj020_desc
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      CALL s_desc_get_wbs_desc(g_bgcj_d[l_ac].bgcj020,g_bgcj_d[l_ac].bgcj021) RETURNING g_bgcj_d[l_ac].bgcj021_desc
      LET g_bgcj_d[l_ac].bgcj021_desc=g_bgcj_d[l_ac].bgcj021,"  ",g_bgcj_d[l_ac].bgcj021_desc
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 插入bgcj_t资料
# Memo...........:
# Usage..........: CALL abgt340_insert_bgcj()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     执行结果TRUE/FALSE 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_insert_bgcj()
  #DEFINE l_bgcj         RECORD LIKE bgcj_t.* #161108-00017#9 mark
   #161108-00017#9 --s add
   DEFINE l_bgcj RECORD  #銷售預算主檔
          bgcjent LIKE bgcj_t.bgcjent, #企业编号
          bgcj001 LIKE bgcj_t.bgcj001, #来源作业
          bgcj002 LIKE bgcj_t.bgcj002, #预算编号
          bgcj003 LIKE bgcj_t.bgcj003, #版本
          bgcj004 LIKE bgcj_t.bgcj004, #管理组织
          bgcj005 LIKE bgcj_t.bgcj005, #销售来源
          bgcj006 LIKE bgcj_t.bgcj006, #数据类型
          bgcj007 LIKE bgcj_t.bgcj007, #预算组织
          bgcj008 LIKE bgcj_t.bgcj008, #预算期别
          bgcj009 LIKE bgcj_t.bgcj009, #预算料件
          bgcj010 LIKE bgcj_t.bgcj010, #组合KEY
          bgcjseq LIKE bgcj_t.bgcjseq, #项次
          bgcj011 LIKE bgcj_t.bgcj011, #预算样表
          bgcj012 LIKE bgcj_t.bgcj012, #人员
          bgcj013 LIKE bgcj_t.bgcj013, #部门
          bgcj014 LIKE bgcj_t.bgcj014, #成本利润中心
          bgcj015 LIKE bgcj_t.bgcj015, #区域
          bgcj016 LIKE bgcj_t.bgcj016, #收付款客商
          bgcj017 LIKE bgcj_t.bgcj017, #账款客商
          bgcj018 LIKE bgcj_t.bgcj018, #客群
          bgcj019 LIKE bgcj_t.bgcj019, #产品类别
          bgcj020 LIKE bgcj_t.bgcj020, #项目编号
          bgcj021 LIKE bgcj_t.bgcj021, #WBS
          bgcj022 LIKE bgcj_t.bgcj022, #经营方式
          bgcj023 LIKE bgcj_t.bgcj023, #渠道
          bgcj024 LIKE bgcj_t.bgcj024, #品牌
          bgcj025 LIKE bgcj_t.bgcj025, #自由核算项一
          bgcj026 LIKE bgcj_t.bgcj026, #自由核算项二
          bgcj027 LIKE bgcj_t.bgcj027, #自由核算项三
          bgcj028 LIKE bgcj_t.bgcj028, #自由核算项四
          bgcj029 LIKE bgcj_t.bgcj029, #自由核算项五
          bgcj030 LIKE bgcj_t.bgcj030, #自由核算项六
          bgcj031 LIKE bgcj_t.bgcj031, #自由核算项七
          bgcj032 LIKE bgcj_t.bgcj032, #自由核算项八
          bgcj033 LIKE bgcj_t.bgcj033, #自由核算项九
          bgcj034 LIKE bgcj_t.bgcj034, #自由核算项十
          bgcj035 LIKE bgcj_t.bgcj035, #税种
          bgcj036 LIKE bgcj_t.bgcj036, #含税否
          bgcj037 LIKE bgcj_t.bgcj037, #销售单位
          bgcj038 LIKE bgcj_t.bgcj038, #交易数量
          bgcj039 LIKE bgcj_t.bgcj039, #单价
          bgcj040 LIKE bgcj_t.bgcj040, #原币销售金额
          bgcj041 LIKE bgcj_t.bgcj041, #本层调整数量
          bgcj042 LIKE bgcj_t.bgcj042, #本层调整单价
          bgcj043 LIKE bgcj_t.bgcj043, #上层调整数量
          bgcj044 LIKE bgcj_t.bgcj044, #上层调整单价
          bgcj045 LIKE bgcj_t.bgcj045, #核准数量
          bgcj046 LIKE bgcj_t.bgcj046, #核准单价
          bgcj047 LIKE bgcj_t.bgcj047, #上层组织
          bgcj048 LIKE bgcj_t.bgcj048, #转凭证否
          bgcj049 LIKE bgcj_t.bgcj049, #预算细项
          bgcj050 LIKE bgcj_t.bgcj050, #编制起点
          bgcj051 LIKE bgcj_t.bgcj051, #生产预算抛转否
          bgcj052 LIKE bgcj_t.bgcj052, #内部采购组织
          bgcj053 LIKE bgcj_t.bgcj053, #内部采购预算细项
          bgcj100 LIKE bgcj_t.bgcj100, #交易币种
          bgcj101 LIKE bgcj_t.bgcj101, #汇率
          bgcj102 LIKE bgcj_t.bgcj102, #核准原币销售金额
          bgcj103 LIKE bgcj_t.bgcj103, #核准原币税前金额
          bgcj104 LIKE bgcj_t.bgcj104, #核准原币税额
          bgcj105 LIKE bgcj_t.bgcj105, #核准原币含税金额
          bgcjownid LIKE bgcj_t.bgcjownid, #资料所有者
          bgcjowndp LIKE bgcj_t.bgcjowndp, #资料所有部门
          bgcjcrtid LIKE bgcj_t.bgcjcrtid, #资料录入者
          bgcjcrtdp LIKE bgcj_t.bgcjcrtdp, #资料录入部门
          bgcjcrtdt LIKE bgcj_t.bgcjcrtdt, #资料创建日
          bgcjmodid LIKE bgcj_t.bgcjmodid, #资料更改者
          bgcjmoddt LIKE bgcj_t.bgcjmoddt, #最近更改日
          bgcjcnfid LIKE bgcj_t.bgcjcnfid, #资料审核者
          bgcjcnfdt LIKE bgcj_t.bgcjcnfdt, #数据审核日
          bgcjstus LIKE bgcj_t.bgcjstus, #状态码
          bgcjud001 LIKE bgcj_t.bgcjud001, #自定义字段(文本)001
          bgcjud002 LIKE bgcj_t.bgcjud002, #自定义字段(文本)002
          bgcjud003 LIKE bgcj_t.bgcjud003, #自定义字段(文本)003
          bgcjud004 LIKE bgcj_t.bgcjud004, #自定义字段(文本)004
          bgcjud005 LIKE bgcj_t.bgcjud005, #自定义字段(文本)005
          bgcjud006 LIKE bgcj_t.bgcjud006, #自定义字段(文本)006
          bgcjud007 LIKE bgcj_t.bgcjud007, #自定义字段(文本)007
          bgcjud008 LIKE bgcj_t.bgcjud008, #自定义字段(文本)008
          bgcjud009 LIKE bgcj_t.bgcjud009, #自定义字段(文本)009
          bgcjud010 LIKE bgcj_t.bgcjud010, #自定义字段(文本)010
          bgcjud011 LIKE bgcj_t.bgcjud011, #自定义字段(数字)011
          bgcjud012 LIKE bgcj_t.bgcjud012, #自定义字段(数字)012
          bgcjud013 LIKE bgcj_t.bgcjud013, #自定义字段(数字)013
          bgcjud014 LIKE bgcj_t.bgcjud014, #自定义字段(数字)014
          bgcjud015 LIKE bgcj_t.bgcjud015, #自定义字段(数字)015
          bgcjud016 LIKE bgcj_t.bgcjud016, #自定义字段(数字)016
          bgcjud017 LIKE bgcj_t.bgcjud017, #自定义字段(数字)017
          bgcjud018 LIKE bgcj_t.bgcjud018, #自定义字段(数字)018
          bgcjud019 LIKE bgcj_t.bgcjud019, #自定义字段(数字)019
          bgcjud020 LIKE bgcj_t.bgcjud020, #自定义字段(数字)020
          bgcjud021 LIKE bgcj_t.bgcjud021, #自定义字段(日期时间)021
          bgcjud022 LIKE bgcj_t.bgcjud022, #自定义字段(日期时间)022
          bgcjud023 LIKE bgcj_t.bgcjud023, #自定义字段(日期时间)023
          bgcjud024 LIKE bgcj_t.bgcjud024, #自定义字段(日期时间)024
          bgcjud025 LIKE bgcj_t.bgcjud025, #自定义字段(日期时间)025
          bgcjud026 LIKE bgcj_t.bgcjud026, #自定义字段(日期时间)026
          bgcjud027 LIKE bgcj_t.bgcjud027, #自定义字段(日期时间)027
          bgcjud028 LIKE bgcj_t.bgcjud028, #自定义字段(日期时间)028
          bgcjud029 LIKE bgcj_t.bgcjud029, #自定义字段(日期时间)029
          bgcjud030 LIKE bgcj_t.bgcjud030  #自定义字段(日期时间)030
   END RECORD
   #161108-00017#9 --e add
   DEFINE l_i            LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgcj103      LIKE bgcj_t.bgcj103
   DEFINE l_bgcj104      LIKE bgcj_t.bgcj104
   DEFINE l_bgcj105      LIKE bgcj_t.bgcj105
   DEFINE l_day          LIKE type_t.num5 #161220-00036#1 add
   DEFINE l_date         LIKE type_t.dat  #161220-00036#1 add
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgcj.bgcj007 = g_bgcj_m.bgcj007
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgcj.bgcj009 = g_bgcj_m.bgcj009
      LET l_bgcj.bgcj049 = g_bgcj_m.bgcj049
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgcj.bgcj013 = g_bgcj_m.bgcj013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgcj.bgcj014 = g_bgcj_m.bgcj014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgcj.bgcj015 = g_bgcj_m.bgcj015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgcj.bgcj016 = g_bgcj_m.bgcj016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgcj.bgcj017 = g_bgcj_m.bgcj017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgcj.bgcj018 = g_bgcj_m.bgcj018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgcj.bgcj019 = g_bgcj_m.bgcj019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgcj.bgcj022= g_bgcj_m.bgcj022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgcj.bgcj023= g_bgcj_m.bgcj023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgcj.bgcj024= g_bgcj_m.bgcj024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgcj.bgcj012= g_bgcj_m.bgcj012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgcj.bgcj020= g_bgcj_m.bgcj020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgcj.bgcj021= g_bgcj_m.bgcj021
   END IF
   
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgcj.bgcj007 = g_bgcj_d[l_ac].bgcj007
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgcj.bgcj009 = g_bgcj_d[l_ac].bgcj009
      LET l_bgcj.bgcj049 = g_bgcj_d[l_ac].bgcj049
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgcj.bgcj013 = g_bgcj_d[l_ac].bgcj013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgcj.bgcj014 = g_bgcj_d[l_ac].bgcj014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgcj.bgcj015 = g_bgcj_d[l_ac].bgcj015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgcj.bgcj016 = g_bgcj_d[l_ac].bgcj016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgcj.bgcj017 = g_bgcj_d[l_ac].bgcj017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgcj.bgcj018 = g_bgcj_d[l_ac].bgcj018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgcj.bgcj019 = g_bgcj_d[l_ac].bgcj019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgcj.bgcj022= g_bgcj_d[l_ac].bgcj022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgcj.bgcj023= g_bgcj_d[l_ac].bgcj023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgcj.bgcj024= g_bgcj_d[l_ac].bgcj024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgcj.bgcj012= g_bgcj_d[l_ac].bgcj012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgcj.bgcj020= g_bgcj_d[l_ac].bgcj020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgcj.bgcj021= g_bgcj_d[l_ac].bgcj021
   END IF
   
   #当核算项不使用时，核算项默认给空格
   #部门
   IF g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N' THEN
      LET l_bgcj.bgcj013 = ' '
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N' THEN
      LET l_bgcj.bgcj014 = ' '
   END IF
   #区域
   IF g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N' THEN
      LET l_bgcj.bgcj015 = ' '
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N' THEN
      LET l_bgcj.bgcj016 = ' '
   END IF
   #账款客商
   IF g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N' THEN
      LET l_bgcj.bgcj017 = ' '
   END IF
   #客群
   IF g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N' THEN
      LET l_bgcj.bgcj018 = ' '
   END IF
   #产品类别
   IF g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N' THEN
      LET l_bgcj.bgcj019 = ' '
   END IF
   #经营方式
   IF g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N' THEN
      LET l_bgcj.bgcj022= ' '
   END IF
   #通路
   IF g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N' THEN
      LET l_bgcj.bgcj023= ' '
   END IF
   #品牌
   IF g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N' THEN
      LET l_bgcj.bgcj024= ' '
   END IF
   #人员
   IF g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N' THEN
      LET l_bgcj.bgcj012= ' '
   END IF
   #专案
   IF g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N' THEN
      LET l_bgcj.bgcj020= ' '
   END IF
   #WBS
   IF g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N' THEN
      LET l_bgcj.bgcj021= ' '
   END IF
   
   #组合key bgcj010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET l_bgcj.bgcj010 = "bgcj013=",l_bgcj.bgcj013,"/",
                        "bgcj014=",l_bgcj.bgcj014,"/",
                        "bgcj015=",l_bgcj.bgcj015,"/",
                        "bgcj016=",l_bgcj.bgcj016,"/",
                        "bgcj017=",l_bgcj.bgcj017,"/",
                        "bgcj018=",l_bgcj.bgcj018,"/",
                        "bgcj019=",l_bgcj.bgcj019,"/",
                        "bgcj022=",l_bgcj.bgcj022,"/",
                        "bgcj023=",l_bgcj.bgcj023,"/",
                        "bgcj024=",l_bgcj.bgcj024,"/",
                        "bgcj012=",l_bgcj.bgcj012,"/",
                        "bgcj020=",l_bgcj.bgcj020,"/",
                        "bgcj021=",l_bgcj.bgcj021,""
   
   LET l_bgcj.bgcj041 = 0
   LET l_bgcj.bgcj042 = 0
   LET l_bgcj.bgcj043 = 0
   LET l_bgcj.bgcj044 = 0
   LET l_bgcj.bgcj051 = 'N'
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgcj.bgcj008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num1
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price1
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt1
         WHEN 2
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num2
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price2
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt2
         WHEN 3
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num3
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price3
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt3
         WHEN 4
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num4
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price4
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt4
         WHEN 5
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num5
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price5
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt5
         WHEN 6
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num6
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price6
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt6
         WHEN 7
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num7
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price7
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt7
         WHEN 8
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num8
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price8
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt8
         WHEN 9
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num9
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price9
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt9
         WHEN 10
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num10
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price10
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt10
         WHEN 11
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num11
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price11
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt11
         WHEN 12
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num12
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price12
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt12
         WHEN 13
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num13
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price13
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt13
      END CASE
      #161215-00014#1--add--str--
      IF cl_null(l_bgcj.bgcj038) THEN LET l_bgcj.bgcj038 = 0 END IF
      IF cl_null(l_bgcj.bgcj039) THEN LET l_bgcj.bgcj039 = 0 END IF
      IF cl_null(l_bgcj.bgcj040) THEN LET l_bgcj.bgcj040 = 0 END IF
      #161215-00014#1--add--end
      LET l_bgcj.bgcj045 = l_bgcj.bgcj038
      LET l_bgcj.bgcj046 = l_bgcj.bgcj039
      LET l_bgcj.bgcj102 = l_bgcj.bgcj040
      #161220-00036#1--add--str--
      #汇率
      #170103-00013#1--mod--str--
#      CALL s_date_get_max_day(g_bgcj_m.bgaa002,l_bgcj.bgcj008) RETURNING l_day
#      LET l_date=MDY(l_bgcj.bgcj008,l_day,g_bgcj_m.bgaa002)
      CALL s_abg2_get_max_bgac002(g_bgcj_m.bgaa002,l_bgcj.bgcj008) RETURNING l_date
      #170103-00013#1--mod--end
      CALL s_abg_get_bg_rate(g_bgcj_m.bgcj002,l_date,g_bgcj_d[l_ac].bgcj100,g_bgcj_m.bgaa003)
      RETURNING l_bgcj.bgcj101
      #161220-00036#1--add--end
      #以稅別計算出來含税金额、未税金额、税额
#      CALL s_tax_count(l_bgcj.bgcj007,g_bgcj_d[l_ac].bgcj035,l_bgcj.bgcj102,l_bgcj.bgcj045,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj101) #161220-00036#1 mark
      CALL s_tax_count(l_bgcj.bgcj007,g_bgcj_d[l_ac].bgcj035,l_bgcj.bgcj102,l_bgcj.bgcj045,g_bgcj_d[l_ac].bgcj100,l_bgcj.bgcj101) #161220-00036#1 add
      RETURNING l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,l_bgcj103,l_bgcj104,l_bgcj105
      
      INSERT INTO bgcj_t
            (bgcjent,bgcj002,bgcj003,bgcj004,bgcj011,bgcj001,bgcj005,bgcj006,bgcjstus,
             bgcj007,bgcj009,bgcj008,bgcj010,bgcjseq,
             bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,
             bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,
             bgcj035,bgcj036,bgcj037,bgcj100,
             bgcj101,bgcj038,bgcj039,bgcj040,
             bgcj041,bgcj042,bgcj043,bgcj044,bgcj045,bgcj046,
             bgcj047,bgcj048,bgcj050,bgcj051,
             bgcj102,bgcj103,bgcj104,bgcj105,
             bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
             bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt) 
      VALUES(g_enterprise,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,
             g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcjstus,
             l_bgcj.bgcj007,l_bgcj.bgcj009,l_bgcj.bgcj008,l_bgcj.bgcj010,g_bgcj_d[l_ac].bgcjseq,
             l_bgcj.bgcj049,l_bgcj.bgcj012,l_bgcj.bgcj013,l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,
             l_bgcj.bgcj018,l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,l_bgcj.bgcj024,
             g_bgcj_d[l_ac].bgcj035,g_bgcj_d[l_ac].bgcj036,g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100, 
#             g_bgcj_d[l_ac].bgcj101,l_bgcj.bgcj038,l_bgcj.bgcj039,l_bgcj.bgcj040, #161220-00036#1 mark
             l_bgcj.bgcj101,l_bgcj.bgcj038,l_bgcj.bgcj039,l_bgcj.bgcj040,  #161220-00036#1 add
             l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,
             g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048,g_bgcj_d[l_ac].bgcj050,l_bgcj.bgcj051,
             l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,
             g_bgcj2_d[l_ac].bgcjownid,g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid, 
             g_bgcj2_d[l_ac].bgcjcrtdp,g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid, 
             g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid,g_bgcj2_d[l_ac].bgcjcnfdt) 
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
# Usage..........: CALL abgt340_update_head()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_update_head()
   DEFINE l_sql           STRING
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING 
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_bgcj RECORD  #銷售預算主檔
          bgcjent LIKE bgcj_t.bgcjent, #企业编号
          bgcj001 LIKE bgcj_t.bgcj001, #来源作业
          bgcj002 LIKE bgcj_t.bgcj002, #预算编号
          bgcj003 LIKE bgcj_t.bgcj003, #版本
          bgcj004 LIKE bgcj_t.bgcj004, #管理组织
          bgcj005 LIKE bgcj_t.bgcj005, #销售来源
          bgcj006 LIKE bgcj_t.bgcj006, #数据类型
          bgcj007 LIKE bgcj_t.bgcj007, #预算组织
          bgcj008 LIKE bgcj_t.bgcj008, #预算期别
          bgcj009 LIKE bgcj_t.bgcj009, #预算料件
          bgcj010 LIKE bgcj_t.bgcj010, #组合KEY
          bgcjseq LIKE bgcj_t.bgcjseq, #项次
          bgcj011 LIKE bgcj_t.bgcj011, #预算样表
          bgcj012 LIKE bgcj_t.bgcj012, #人员
          bgcj013 LIKE bgcj_t.bgcj013, #部门
          bgcj014 LIKE bgcj_t.bgcj014, #成本利润中心
          bgcj015 LIKE bgcj_t.bgcj015, #区域
          bgcj016 LIKE bgcj_t.bgcj016, #收付款客商
          bgcj017 LIKE bgcj_t.bgcj017, #账款客商
          bgcj018 LIKE bgcj_t.bgcj018, #客群
          bgcj019 LIKE bgcj_t.bgcj019, #产品类别
          bgcj020 LIKE bgcj_t.bgcj020, #项目编号
          bgcj021 LIKE bgcj_t.bgcj021, #WBS
          bgcj022 LIKE bgcj_t.bgcj022, #经营方式
          bgcj023 LIKE bgcj_t.bgcj023, #渠道
          bgcj024 LIKE bgcj_t.bgcj024, #品牌
          bgcj025 LIKE bgcj_t.bgcj025, #自由核算项一
          bgcj026 LIKE bgcj_t.bgcj026, #自由核算项二
          bgcj027 LIKE bgcj_t.bgcj027, #自由核算项三
          bgcj028 LIKE bgcj_t.bgcj028, #自由核算项四
          bgcj029 LIKE bgcj_t.bgcj029, #自由核算项五
          bgcj030 LIKE bgcj_t.bgcj030, #自由核算项六
          bgcj031 LIKE bgcj_t.bgcj031, #自由核算项七
          bgcj032 LIKE bgcj_t.bgcj032, #自由核算项八
          bgcj033 LIKE bgcj_t.bgcj033, #自由核算项九
          bgcj034 LIKE bgcj_t.bgcj034, #自由核算项十
          bgcj035 LIKE bgcj_t.bgcj035, #税种
          bgcj036 LIKE bgcj_t.bgcj036, #含税否
          bgcj037 LIKE bgcj_t.bgcj037, #销售单位
          bgcj038 LIKE bgcj_t.bgcj038, #交易数量
          bgcj039 LIKE bgcj_t.bgcj039, #单价
          bgcj040 LIKE bgcj_t.bgcj040, #原币销售金额
          bgcj041 LIKE bgcj_t.bgcj041, #本层调整数量
          bgcj042 LIKE bgcj_t.bgcj042, #本层调整单价
          bgcj043 LIKE bgcj_t.bgcj043, #上层调整数量
          bgcj044 LIKE bgcj_t.bgcj044, #上层调整单价
          bgcj045 LIKE bgcj_t.bgcj045, #核准数量
          bgcj046 LIKE bgcj_t.bgcj046, #核准单价
          bgcj047 LIKE bgcj_t.bgcj047, #上层组织
          bgcj048 LIKE bgcj_t.bgcj048, #转凭证否
          bgcj049 LIKE bgcj_t.bgcj049, #预算细项
          bgcj050 LIKE bgcj_t.bgcj050, #编制起点
          bgcj051 LIKE bgcj_t.bgcj051, #生产预算抛转否
          bgcj052 LIKE bgcj_t.bgcj052, #内部采购组织
          bgcj053 LIKE bgcj_t.bgcj053, #内部采购预算细项
          bgcj100 LIKE bgcj_t.bgcj100, #交易币种
          bgcj101 LIKE bgcj_t.bgcj101, #汇率
          bgcj102 LIKE bgcj_t.bgcj102, #核准原币销售金额
          bgcj103 LIKE bgcj_t.bgcj103, #核准原币税前金额
          bgcj104 LIKE bgcj_t.bgcj104, #核准原币税额
          bgcj105 LIKE bgcj_t.bgcj105, #核准原币含税金额
          bgcjownid LIKE bgcj_t.bgcjownid, #资料所有者
          bgcjowndp LIKE bgcj_t.bgcjowndp, #资料所有部门
          bgcjcrtid LIKE bgcj_t.bgcjcrtid, #资料录入者
          bgcjcrtdp LIKE bgcj_t.bgcjcrtdp, #资料录入部门
          bgcjcrtdt LIKE bgcj_t.bgcjcrtdt, #资料创建日
          bgcjmodid LIKE bgcj_t.bgcjmodid, #资料更改者
          bgcjmoddt LIKE bgcj_t.bgcjmoddt, #最近更改日
          bgcjcnfid LIKE bgcj_t.bgcjcnfid, #资料审核者
          bgcjcnfdt LIKE bgcj_t.bgcjcnfdt, #数据审核日
          bgcjstus LIKE bgcj_t.bgcjstus, #状态码
          bgcjud001 LIKE bgcj_t.bgcjud001, #自定义字段(文本)001
          bgcjud002 LIKE bgcj_t.bgcjud002, #自定义字段(文本)002
          bgcjud003 LIKE bgcj_t.bgcjud003, #自定义字段(文本)003
          bgcjud004 LIKE bgcj_t.bgcjud004, #自定义字段(文本)004
          bgcjud005 LIKE bgcj_t.bgcjud005, #自定义字段(文本)005
          bgcjud006 LIKE bgcj_t.bgcjud006, #自定义字段(文本)006
          bgcjud007 LIKE bgcj_t.bgcjud007, #自定义字段(文本)007
          bgcjud008 LIKE bgcj_t.bgcjud008, #自定义字段(文本)008
          bgcjud009 LIKE bgcj_t.bgcjud009, #自定义字段(文本)009
          bgcjud010 LIKE bgcj_t.bgcjud010, #自定义字段(文本)010
          bgcjud011 LIKE bgcj_t.bgcjud011, #自定义字段(数字)011
          bgcjud012 LIKE bgcj_t.bgcjud012, #自定义字段(数字)012
          bgcjud013 LIKE bgcj_t.bgcjud013, #自定义字段(数字)013
          bgcjud014 LIKE bgcj_t.bgcjud014, #自定义字段(数字)014
          bgcjud015 LIKE bgcj_t.bgcjud015, #自定义字段(数字)015
          bgcjud016 LIKE bgcj_t.bgcjud016, #自定义字段(数字)016
          bgcjud017 LIKE bgcj_t.bgcjud017, #自定义字段(数字)017
          bgcjud018 LIKE bgcj_t.bgcjud018, #自定义字段(数字)018
          bgcjud019 LIKE bgcj_t.bgcjud019, #自定义字段(数字)019
          bgcjud020 LIKE bgcj_t.bgcjud020, #自定义字段(数字)020
          bgcjud021 LIKE bgcj_t.bgcjud021, #自定义字段(日期时间)021
          bgcjud022 LIKE bgcj_t.bgcjud022, #自定义字段(日期时间)022
          bgcjud023 LIKE bgcj_t.bgcjud023, #自定义字段(日期时间)023
          bgcjud024 LIKE bgcj_t.bgcjud024, #自定义字段(日期时间)024
          bgcjud025 LIKE bgcj_t.bgcjud025, #自定义字段(日期时间)025
          bgcjud026 LIKE bgcj_t.bgcjud026, #自定义字段(日期时间)026
          bgcjud027 LIKE bgcj_t.bgcjud027, #自定义字段(日期时间)027
          bgcjud028 LIKE bgcj_t.bgcjud028, #自定义字段(日期时间)028
          bgcjud029 LIKE bgcj_t.bgcjud029, #自定义字段(日期时间)029
          bgcjud030 LIKE bgcj_t.bgcjud030  #自定义字段(日期时间)030
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
   DEFINE l_bgcj010_t     LIKE bgcj_t.bgcj010
   
   LET r_success = TRUE
                
   LET l_str1="bgcj002,bgcj003,bgcj004,bgcj011,bgcj001,bgcj005,bgcj006,bgcjstus"
   LET l_str2="'",g_bgcj_m.bgcj002,"','",g_bgcj_m.bgcj003,"','",g_bgcj_m.bgcj004,"','",g_bgcj_m.bgcj011,"',", 
              "'",g_bgcj_m.bgcj001,"','",g_bgcj_m.bgcj005,"','",g_bgcj_m.bgcj006,"','",g_bgcj_m.bgcjstus,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_str1=l_str1,",bgcj007"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_str1=l_str1,",bgcj009,bgcj049"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj009,"','",g_bgcj_m.bgcj049,"'"
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_str1=l_str1,",bgcj013"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj013,"'"
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_str1=l_str1,",bgcj014"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj014,"'"
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_str1=l_str1,",bgcj015"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj015,"'"
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_str1=l_str1,",bgcj016"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj016,"'"
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_str1=l_str1,",bgcj017"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj017,"'"
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_str1=l_str1,",bgcj018"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj018,"'"
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_str1=l_str1,",bgcj019"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj019,"'"
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_str1=l_str1,",bgcj022"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj022,"'"
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_str1=l_str1,",bgcj023"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj023,"'"
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_str1=l_str1,",bgcj024"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj024,"'"
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_str1=l_str1,",bgcj012"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj012,"'"
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_str1=l_str1,",bgcj020"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj020,"'"
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_str1=l_str1,",bgcj021"
      LET l_str2=l_str2,",'",g_bgcj_m.bgcj021,"'"
   END IF
   
   LET l_sql = "UPDATE bgcj_t SET (",l_str1,") = (",l_str2,")",
               " WHERE bgcjent =  ",g_enterprise,
               "   AND bgcj001 = '",g_bgcj001_t,"'",
               "   AND bgcj002 = '",g_bgcj002_t,"'",
               "   AND bgcj003 = '",g_bgcj003_t,"'",
               "   AND bgcj004 = '",g_bgcj004_t,"'",
               "   AND bgcj005 = '",g_bgcj005_t,"'",
               "   AND bgcj006 = '",g_bgcj006_t,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj007_t,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj009_t,"'"
   END IF
   PREPARE abgt340_update_head_pr FROM l_sql
   EXECUTE abgt340_update_head_pr
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgcj_t" 
         LET g_errparam.code   = "std-00009" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
   LET l_sql = "SELECT DISTINCT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,",
               "       bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,",
               "       bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024 ",
               "  FROM bgcj_t ",
               " WHERE bgcjent =  ",g_enterprise,
               "   AND bgcj001 = '",g_bgcj_m.bgcj001,"'",
               "   AND bgcj002 = '",g_bgcj_m.bgcj002,"'",
               "   AND bgcj003 = '",g_bgcj_m.bgcj003,"'",
               "   AND bgcj004 = '",g_bgcj_m.bgcj004,"'",
               "   AND bgcj005 = '",g_bgcj_m.bgcj005,"'",
               "   AND bgcj006 = '",g_bgcj_m.bgcj006,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj_m.bgcj007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj_m.bgcj009,"'"
   END IF
   PREPARE abgt340_update_head_pr2 FROM l_sql
   DECLARE abgt340_update_head_cs2 CURSOR FOR abgt340_update_head_pr2
   
   FOREACH abgt340_update_head_cs2 INTO l_bgcj.bgcjseq,l_bgcj010_t,l_bgcj.bgcj007,l_bgcj.bgcj009,l_bgcj.bgcj049,
                                        l_bgcj.bgcj012,l_bgcj.bgcj013,l_bgcj.bgcj014,l_bgcj.bgcj015,
                                        l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,l_bgcj.bgcj019,
                                        l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
                                        l_bgcj.bgcj024
      SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
             bgal010,bgal011,bgal012,bgal013,bgal014,
             bgal025,bgal026,bgal027 
        INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
             l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
             l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
        FROM bgal_t 
       WHERE bgalent=g_enterprise AND bgal001=g_bgcj_m.bgcj002
         AND bgal002=l_bgcj.bgcj007 AND bgal003=l_bgcj.bgcj049
      #部门
      IF (g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N') OR l_bgal.bgal005 = 'N' THEN
         LET l_bgcj.bgcj013 = ' '
      END IF
      #利润成本中心
      IF (g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N') OR l_bgal.bgal006 = 'N'  THEN
         LET l_bgcj.bgcj014 = ' '
      END IF
      #区域
      IF (g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N') OR l_bgal.bgal007 = 'N'  THEN
         LET l_bgcj.bgcj015 = ' '
      END IF
      #收付款客商
      IF (g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N') OR l_bgal.bgal008 = 'N'  THEN
         LET l_bgcj.bgcj016 = ' '
      END IF
      #账款客商
      IF (g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N') OR l_bgal.bgal009 = 'N'  THEN
         LET l_bgcj.bgcj017 = ' '
      END IF
      #客群
      IF (g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N') OR l_bgal.bgal010 = 'N'  THEN
         LET l_bgcj.bgcj018 = ' '
      END IF
      #产品类别
      IF (g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N') OR l_bgal.bgal011 = 'N' THEN
         LET l_bgcj.bgcj019 = ' '
      END IF
      #经营方式
      IF (g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N') OR l_bgal.bgal025 = 'N' THEN
         LET l_bgcj.bgcj022= ' '
      END IF
      #通路
      IF (g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N') OR l_bgal.bgal026 = 'N' THEN
         LET l_bgcj.bgcj023= ' '
      END IF
      #品牌
      IF (g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N') OR l_bgal.bgal027 = 'N' THEN
         LET l_bgcj.bgcj024= ' '
      END IF
      #人员
      IF (g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N') OR l_bgal.bgal012 = 'N' THEN
         LET l_bgcj.bgcj012= ' '
      END IF
      #专案
      IF (g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N') OR l_bgal.bgal013 = 'N' THEN
         LET l_bgcj.bgcj020= ' '
      END IF
      #WBS
      IF (g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N') OR l_bgal.bgal014 = 'N' THEN
         LET l_bgcj.bgcj021= ' '
      END IF
      
      #组合key bgcj010
      #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
      #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
      LET l_bgcj.bgcj010 = "bgcj013=",l_bgcj.bgcj013,"/",
                           "bgcj014=",l_bgcj.bgcj014,"/",
                           "bgcj015=",l_bgcj.bgcj015,"/",
                           "bgcj016=",l_bgcj.bgcj016,"/",
                           "bgcj017=",l_bgcj.bgcj017,"/",
                           "bgcj018=",l_bgcj.bgcj018,"/",
                           "bgcj019=",l_bgcj.bgcj019,"/",
                           "bgcj022=",l_bgcj.bgcj022,"/",
                           "bgcj023=",l_bgcj.bgcj023,"/",
                           "bgcj024=",l_bgcj.bgcj024,"/",
                           "bgcj012=",l_bgcj.bgcj012,"/",
                           "bgcj020=",l_bgcj.bgcj020,"/",
                           "bgcj021=",l_bgcj.bgcj021,""
                           
      UPDATE bgcj_t SET (bgcj010,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,
                         bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,
                         bgcj023,bgcj024) = (l_bgcj.bgcj010,l_bgcj.bgcj012, 
                         l_bgcj.bgcj013,l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016, 
                         l_bgcj.bgcj017,l_bgcj.bgcj018,l_bgcj.bgcj019,l_bgcj.bgcj020, 
                         l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,l_bgcj.bgcj024)
       WHERE bgcjent = g_enterprise 
         AND bgcj001 = g_bgcj_m.bgcj001 
         AND bgcj002 = g_bgcj_m.bgcj002 
         AND bgcj003 = g_bgcj_m.bgcj003 
         AND bgcj004 = g_bgcj_m.bgcj004 
         AND bgcj005 = g_bgcj_m.bgcj005 
         AND bgcj006 = g_bgcj_m.bgcj006 
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj010_t
         AND bgcjseq = l_bgcj.bgcjseq 
     CASE
        WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgcj_t" 
           LET g_errparam.code   = "std-00009" 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOREACH
           
        WHEN SQLCA.sqlcode #其他錯誤
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
# Usage..........: CALL abgt340_update_detail()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     执行结果TRUE/FALSE
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_update_detail()
  #DEFINE l_bgcj         RECORD LIKE bgcj_t.* #161108-00017#9 mark
   #161108-00017#9 --s add
   DEFINE l_bgcj RECORD  #銷售預算主檔
          bgcjent LIKE bgcj_t.bgcjent, #企业编号
          bgcj001 LIKE bgcj_t.bgcj001, #来源作业
          bgcj002 LIKE bgcj_t.bgcj002, #预算编号
          bgcj003 LIKE bgcj_t.bgcj003, #版本
          bgcj004 LIKE bgcj_t.bgcj004, #管理组织
          bgcj005 LIKE bgcj_t.bgcj005, #销售来源
          bgcj006 LIKE bgcj_t.bgcj006, #数据类型
          bgcj007 LIKE bgcj_t.bgcj007, #预算组织
          bgcj008 LIKE bgcj_t.bgcj008, #预算期别
          bgcj009 LIKE bgcj_t.bgcj009, #预算料件
          bgcj010 LIKE bgcj_t.bgcj010, #组合KEY
          bgcjseq LIKE bgcj_t.bgcjseq, #项次
          bgcj011 LIKE bgcj_t.bgcj011, #预算样表
          bgcj012 LIKE bgcj_t.bgcj012, #人员
          bgcj013 LIKE bgcj_t.bgcj013, #部门
          bgcj014 LIKE bgcj_t.bgcj014, #成本利润中心
          bgcj015 LIKE bgcj_t.bgcj015, #区域
          bgcj016 LIKE bgcj_t.bgcj016, #收付款客商
          bgcj017 LIKE bgcj_t.bgcj017, #账款客商
          bgcj018 LIKE bgcj_t.bgcj018, #客群
          bgcj019 LIKE bgcj_t.bgcj019, #产品类别
          bgcj020 LIKE bgcj_t.bgcj020, #项目编号
          bgcj021 LIKE bgcj_t.bgcj021, #WBS
          bgcj022 LIKE bgcj_t.bgcj022, #经营方式
          bgcj023 LIKE bgcj_t.bgcj023, #渠道
          bgcj024 LIKE bgcj_t.bgcj024, #品牌
          bgcj025 LIKE bgcj_t.bgcj025, #自由核算项一
          bgcj026 LIKE bgcj_t.bgcj026, #自由核算项二
          bgcj027 LIKE bgcj_t.bgcj027, #自由核算项三
          bgcj028 LIKE bgcj_t.bgcj028, #自由核算项四
          bgcj029 LIKE bgcj_t.bgcj029, #自由核算项五
          bgcj030 LIKE bgcj_t.bgcj030, #自由核算项六
          bgcj031 LIKE bgcj_t.bgcj031, #自由核算项七
          bgcj032 LIKE bgcj_t.bgcj032, #自由核算项八
          bgcj033 LIKE bgcj_t.bgcj033, #自由核算项九
          bgcj034 LIKE bgcj_t.bgcj034, #自由核算项十
          bgcj035 LIKE bgcj_t.bgcj035, #税种
          bgcj036 LIKE bgcj_t.bgcj036, #含税否
          bgcj037 LIKE bgcj_t.bgcj037, #销售单位
          bgcj038 LIKE bgcj_t.bgcj038, #交易数量
          bgcj039 LIKE bgcj_t.bgcj039, #单价
          bgcj040 LIKE bgcj_t.bgcj040, #原币销售金额
          bgcj041 LIKE bgcj_t.bgcj041, #本层调整数量
          bgcj042 LIKE bgcj_t.bgcj042, #本层调整单价
          bgcj043 LIKE bgcj_t.bgcj043, #上层调整数量
          bgcj044 LIKE bgcj_t.bgcj044, #上层调整单价
          bgcj045 LIKE bgcj_t.bgcj045, #核准数量
          bgcj046 LIKE bgcj_t.bgcj046, #核准单价
          bgcj047 LIKE bgcj_t.bgcj047, #上层组织
          bgcj048 LIKE bgcj_t.bgcj048, #转凭证否
          bgcj049 LIKE bgcj_t.bgcj049, #预算细项
          bgcj050 LIKE bgcj_t.bgcj050, #编制起点
          bgcj051 LIKE bgcj_t.bgcj051, #生产预算抛转否
          bgcj052 LIKE bgcj_t.bgcj052, #内部采购组织
          bgcj053 LIKE bgcj_t.bgcj053, #内部采购预算细项
          bgcj100 LIKE bgcj_t.bgcj100, #交易币种
          bgcj101 LIKE bgcj_t.bgcj101, #汇率
          bgcj102 LIKE bgcj_t.bgcj102, #核准原币销售金额
          bgcj103 LIKE bgcj_t.bgcj103, #核准原币税前金额
          bgcj104 LIKE bgcj_t.bgcj104, #核准原币税额
          bgcj105 LIKE bgcj_t.bgcj105, #核准原币含税金额
          bgcjownid LIKE bgcj_t.bgcjownid, #资料所有者
          bgcjowndp LIKE bgcj_t.bgcjowndp, #资料所有部门
          bgcjcrtid LIKE bgcj_t.bgcjcrtid, #资料录入者
          bgcjcrtdp LIKE bgcj_t.bgcjcrtdp, #资料录入部门
          bgcjcrtdt LIKE bgcj_t.bgcjcrtdt, #资料创建日
          bgcjmodid LIKE bgcj_t.bgcjmodid, #资料更改者
          bgcjmoddt LIKE bgcj_t.bgcjmoddt, #最近更改日
          bgcjcnfid LIKE bgcj_t.bgcjcnfid, #资料审核者
          bgcjcnfdt LIKE bgcj_t.bgcjcnfdt, #数据审核日
          bgcjstus LIKE bgcj_t.bgcjstus, #状态码
          bgcjud001 LIKE bgcj_t.bgcjud001, #自定义字段(文本)001
          bgcjud002 LIKE bgcj_t.bgcjud002, #自定义字段(文本)002
          bgcjud003 LIKE bgcj_t.bgcjud003, #自定义字段(文本)003
          bgcjud004 LIKE bgcj_t.bgcjud004, #自定义字段(文本)004
          bgcjud005 LIKE bgcj_t.bgcjud005, #自定义字段(文本)005
          bgcjud006 LIKE bgcj_t.bgcjud006, #自定义字段(文本)006
          bgcjud007 LIKE bgcj_t.bgcjud007, #自定义字段(文本)007
          bgcjud008 LIKE bgcj_t.bgcjud008, #自定义字段(文本)008
          bgcjud009 LIKE bgcj_t.bgcjud009, #自定义字段(文本)009
          bgcjud010 LIKE bgcj_t.bgcjud010, #自定义字段(文本)010
          bgcjud011 LIKE bgcj_t.bgcjud011, #自定义字段(数字)011
          bgcjud012 LIKE bgcj_t.bgcjud012, #自定义字段(数字)012
          bgcjud013 LIKE bgcj_t.bgcjud013, #自定义字段(数字)013
          bgcjud014 LIKE bgcj_t.bgcjud014, #自定义字段(数字)014
          bgcjud015 LIKE bgcj_t.bgcjud015, #自定义字段(数字)015
          bgcjud016 LIKE bgcj_t.bgcjud016, #自定义字段(数字)016
          bgcjud017 LIKE bgcj_t.bgcjud017, #自定义字段(数字)017
          bgcjud018 LIKE bgcj_t.bgcjud018, #自定义字段(数字)018
          bgcjud019 LIKE bgcj_t.bgcjud019, #自定义字段(数字)019
          bgcjud020 LIKE bgcj_t.bgcjud020, #自定义字段(数字)020
          bgcjud021 LIKE bgcj_t.bgcjud021, #自定义字段(日期时间)021
          bgcjud022 LIKE bgcj_t.bgcjud022, #自定义字段(日期时间)022
          bgcjud023 LIKE bgcj_t.bgcjud023, #自定义字段(日期时间)023
          bgcjud024 LIKE bgcj_t.bgcjud024, #自定义字段(日期时间)024
          bgcjud025 LIKE bgcj_t.bgcjud025, #自定义字段(日期时间)025
          bgcjud026 LIKE bgcj_t.bgcjud026, #自定义字段(日期时间)026
          bgcjud027 LIKE bgcj_t.bgcjud027, #自定义字段(日期时间)027
          bgcjud028 LIKE bgcj_t.bgcjud028, #自定义字段(日期时间)028
          bgcjud029 LIKE bgcj_t.bgcjud029, #自定义字段(日期时间)029
          bgcjud030 LIKE bgcj_t.bgcjud030  #自定义字段(日期时间)030
   END RECORD
   #161108-00017#9 --e add
   DEFINE l_i            LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgcj007_t    LIKE bgcj_t.bgcj007
   DEFINE l_bgcj009_t    LIKE bgcj_t.bgcj009
   DEFINE l_bgcj103      LIKE bgcj_t.bgcj103
   DEFINE l_bgcj104      LIKE bgcj_t.bgcj104
   DEFINE l_bgcj105      LIKE bgcj_t.bgcj105
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
   DEFINE l_day        LIKE type_t.num5 #161220-00036#1 add
   DEFINE l_date       LIKE type_t.dat  #161220-00036#1 add
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgcj.bgcj007 = g_bgcj_m.bgcj007
      LET l_bgcj007_t = g_bgcj007_t
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgcj.bgcj009 = g_bgcj_m.bgcj009
      LET l_bgcj.bgcj049 = g_bgcj_m.bgcj049
      LET l_bgcj009_t = g_bgcj009_t
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgcj.bgcj013 = g_bgcj_m.bgcj013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgcj.bgcj014 = g_bgcj_m.bgcj014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgcj.bgcj015 = g_bgcj_m.bgcj015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgcj.bgcj016 = g_bgcj_m.bgcj016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgcj.bgcj017 = g_bgcj_m.bgcj017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgcj.bgcj018 = g_bgcj_m.bgcj018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgcj.bgcj019 = g_bgcj_m.bgcj019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgcj.bgcj022= g_bgcj_m.bgcj022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgcj.bgcj023= g_bgcj_m.bgcj023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgcj.bgcj024= g_bgcj_m.bgcj024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgcj.bgcj012= g_bgcj_m.bgcj012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgcj.bgcj020= g_bgcj_m.bgcj020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgcj.bgcj021= g_bgcj_m.bgcj021
   END IF
   
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgcj.bgcj007 = g_bgcj_d[l_ac].bgcj007
      LET l_bgcj007_t = g_bgcj_d_t.bgcj007
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgcj.bgcj009 = g_bgcj_d[l_ac].bgcj009
      LET l_bgcj.bgcj049 = g_bgcj_d[l_ac].bgcj049
      LET l_bgcj009_t = g_bgcj_d_t.bgcj009
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgcj.bgcj013 = g_bgcj_d[l_ac].bgcj013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgcj.bgcj014 = g_bgcj_d[l_ac].bgcj014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgcj.bgcj015 = g_bgcj_d[l_ac].bgcj015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgcj.bgcj016 = g_bgcj_d[l_ac].bgcj016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgcj.bgcj017 = g_bgcj_d[l_ac].bgcj017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgcj.bgcj018 = g_bgcj_d[l_ac].bgcj018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgcj.bgcj019 = g_bgcj_d[l_ac].bgcj019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgcj.bgcj022= g_bgcj_d[l_ac].bgcj022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgcj.bgcj023= g_bgcj_d[l_ac].bgcj023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgcj.bgcj024= g_bgcj_d[l_ac].bgcj024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgcj.bgcj012= g_bgcj_d[l_ac].bgcj012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgcj.bgcj020= g_bgcj_d[l_ac].bgcj020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgcj.bgcj021= g_bgcj_d[l_ac].bgcj021
   END IF
   
   #当核算项不使用时，核算项默认给空格
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
          l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
          l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=g_bgcj_m.bgcj002
      AND bgal002=l_bgcj.bgcj007 AND bgal003=l_bgcj.bgcj049
      
   #部门
   IF (g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N') OR l_bgal.bgal005 = 'N' THEN
      LET l_bgcj.bgcj013 = ' '
   END IF
   #利润成本中心
   IF (g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N') OR l_bgal.bgal006 = 'N'  THEN
      LET l_bgcj.bgcj014 = ' '
   END IF
   #区域
   IF (g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N') OR l_bgal.bgal007 = 'N'  THEN
      LET l_bgcj.bgcj015 = ' '
   END IF
   #收付款客商
   IF (g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N') OR l_bgal.bgal008 = 'N'  THEN
      LET l_bgcj.bgcj016 = ' '
   END IF
   #账款客商
   IF (g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N') OR l_bgal.bgal009 = 'N'  THEN
      LET l_bgcj.bgcj017 = ' '
   END IF
   #客群
   IF (g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N') OR l_bgal.bgal010 = 'N'  THEN
      LET l_bgcj.bgcj018 = ' '
   END IF
   #产品类别
   IF (g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N') OR l_bgal.bgal011 = 'N' THEN
      LET l_bgcj.bgcj019 = ' '
   END IF
   #经营方式
   IF (g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N') OR l_bgal.bgal025 = 'N' THEN
      LET l_bgcj.bgcj022= ' '
   END IF
   #通路
   IF (g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N') OR l_bgal.bgal026 = 'N' THEN
      LET l_bgcj.bgcj023= ' '
   END IF
   #品牌
   IF (g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N') OR l_bgal.bgal027 = 'N' THEN
      LET l_bgcj.bgcj024= ' '
   END IF
   #人员
   IF (g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N') OR l_bgal.bgal012 = 'N' THEN
      LET l_bgcj.bgcj012= ' '
   END IF
   #专案
   IF (g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N') OR l_bgal.bgal013 = 'N' THEN
      LET l_bgcj.bgcj020= ' '
   END IF
   #WBS
   IF (g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N') OR l_bgal.bgal014 = 'N' THEN
      LET l_bgcj.bgcj021= ' '
   END IF
   
   #组合key bgcj010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET l_bgcj.bgcj010 = "bgcj013=",l_bgcj.bgcj013,"/",
                        "bgcj014=",l_bgcj.bgcj014,"/",
                        "bgcj015=",l_bgcj.bgcj015,"/",
                        "bgcj016=",l_bgcj.bgcj016,"/",
                        "bgcj017=",l_bgcj.bgcj017,"/",
                        "bgcj018=",l_bgcj.bgcj018,"/",
                        "bgcj019=",l_bgcj.bgcj019,"/",
                        "bgcj022=",l_bgcj.bgcj022,"/",
                        "bgcj023=",l_bgcj.bgcj023,"/",
                        "bgcj024=",l_bgcj.bgcj024,"/",
                        "bgcj012=",l_bgcj.bgcj012,"/",
                        "bgcj020=",l_bgcj.bgcj020,"/",
                        "bgcj021=",l_bgcj.bgcj021,""
   
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgcj.bgcj008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num1
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price1
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt1
         WHEN 2
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num2
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price2
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt2
         WHEN 3
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num3
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price3
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt3
         WHEN 4
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num4
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price4
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt4
         WHEN 5
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num5
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price5
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt5
         WHEN 6
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num6
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price6
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt6
         WHEN 7
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num7
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price7
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt7
         WHEN 8
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num8
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price8
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt8
         WHEN 9
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num9
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price9
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt9
         WHEN 10
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num10
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price10
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt10
         WHEN 11
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num11
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price11
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt11
         WHEN 12
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num12
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price12
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt12
         WHEN 13
            LET l_bgcj.bgcj038 = g_bgcj_d[l_ac].num13
            LET l_bgcj.bgcj039 = g_bgcj_d[l_ac].price13
            LET l_bgcj.bgcj040 = g_bgcj_d[l_ac].amt13
      END CASE
      #161215-00014#1--add--str--
      IF cl_null(l_bgcj.bgcj038) THEN LET l_bgcj.bgcj038 = 0 END IF
      IF cl_null(l_bgcj.bgcj039) THEN LET l_bgcj.bgcj039 = 0 END IF
      IF cl_null(l_bgcj.bgcj040) THEN LET l_bgcj.bgcj040 = 0 END IF
      #161215-00014#1--add--end
      LET l_bgcj.bgcj045 = l_bgcj.bgcj038
      LET l_bgcj.bgcj046 = l_bgcj.bgcj039
      LET l_bgcj.bgcj102 = l_bgcj.bgcj040

      #161220-00036#1--add--str--
      #汇率
      #170103-00013#1--mod--str--
#      CALL s_date_get_max_day(g_bgcj_m.bgaa002,l_bgcj.bgcj008) RETURNING l_day
#      LET l_date=MDY(l_bgcj.bgcj008,l_day,g_bgcj_m.bgaa002)
      CALL s_abg2_get_max_bgac002(g_bgcj_m.bgaa002,l_bgcj.bgcj008) RETURNING l_date
      #170103-00013#1--mod--end
      CALL s_abg_get_bg_rate(g_bgcj_m.bgcj002,l_date,g_bgcj_d[l_ac].bgcj100,g_bgcj_m.bgaa003)
      RETURNING l_bgcj.bgcj101
      #161220-00036#1--add--end
      
      #以稅別計算出來含税金额、未税金额、税额
      #CALL s_tax_count(l_bgcj.bgcj007,g_bgcj_d[l_ac].bgcj035,l_bgcj.bgcj102,l_bgcj.bgcj045,g_bgcj_d[l_ac].bgcj100,g_bgcj_d[l_ac].bgcj101) #161220-00036#1 mark
      CALL s_tax_count(l_bgcj.bgcj007,g_bgcj_d[l_ac].bgcj035,l_bgcj.bgcj102,l_bgcj.bgcj045,g_bgcj_d[l_ac].bgcj100,l_bgcj.bgcj101) #161220-00036#1 add
      RETURNING l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,l_bgcj103,l_bgcj104,l_bgcj105
 
      UPDATE bgcj_t SET (bgcj007,bgcj009,bgcjseq,bgcj010,bgcj049, 
          bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,bgcj019,bgcj020, 
          bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037,bgcj100,bgcj101,bgcj038,bgcj039, 
          bgcj040,bgcj047,bgcj048,bgcj045,bgcj046,bgcj102,
          bgcj103,bgcj104,bgcj105,
          bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt, 
          bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt) = (l_bgcj.bgcj007,l_bgcj.bgcj009, 
          g_bgcj_d[l_ac].bgcjseq,g_bgcj_d[l_ac].bgcj010,l_bgcj.bgcj049,l_bgcj.bgcj012, 
          l_bgcj.bgcj013,l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016, 
          l_bgcj.bgcj017,l_bgcj.bgcj018,l_bgcj.bgcj019,l_bgcj.bgcj020, 
          l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,l_bgcj.bgcj024, 
          g_bgcj_d[l_ac].bgcj035,g_bgcj_d[l_ac].bgcj036,g_bgcj_d[l_ac].bgcj037,g_bgcj_d[l_ac].bgcj100, 
#          g_bgcj_d[l_ac].bgcj101,l_bgcj.bgcj038,l_bgcj.bgcj039,l_bgcj.bgcj040, #161220-00036#1 mark
          l_bgcj.bgcj101,l_bgcj.bgcj038,l_bgcj.bgcj039,l_bgcj.bgcj040, #161220-00036#1 add
          g_bgcj_d[l_ac].bgcj047,g_bgcj_d[l_ac].bgcj048,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj102,
          l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,
          g_bgcj2_d[l_ac].bgcjownid,g_bgcj2_d[l_ac].bgcjowndp,g_bgcj2_d[l_ac].bgcjcrtid,g_bgcj2_d[l_ac].bgcjcrtdp, 
          g_bgcj2_d[l_ac].bgcjcrtdt,g_bgcj2_d[l_ac].bgcjmodid,g_bgcj2_d[l_ac].bgcjmoddt,g_bgcj2_d[l_ac].bgcjcnfid, 
          g_bgcj2_d[l_ac].bgcjcnfdt)
       WHERE bgcjent = g_enterprise 
        AND bgcj001 = g_bgcj_m.bgcj001 
        AND bgcj002 = g_bgcj_m.bgcj002 
        AND bgcj003 = g_bgcj_m.bgcj003 
        AND bgcj004 = g_bgcj_m.bgcj004 
        AND bgcj005 = g_bgcj_m.bgcj005 
        AND bgcj006 = g_bgcj_m.bgcj006 
        AND bgcj007 = l_bgcj007_t 
        AND bgcj009 = l_bgcj009_t 
        AND bgcj008 = l_bgcj.bgcj008 #期别  
        AND bgcj010 = g_bgcj_d_t.bgcj010  
        AND bgcjseq = g_bgcj_d_t.bgcjseq  
     CASE
        WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgcj_t" 
           LET g_errparam.code   = "std-00009" 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOR
           
        WHEN SQLCA.sqlcode #其他錯誤
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
# Descriptions...: 根据核算项组合key值bgcj010
# Memo...........:
# Usage..........: CALL abgt340_get_bgcj010()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_get_bgcj010()
  #DEFINE l_bgcj         RECORD LIKE bgcj_t.*  #161108-00017#9 mark
   #161108-00017#9 --s add
   DEFINE l_bgcj RECORD  #銷售預算主檔
          bgcjent LIKE bgcj_t.bgcjent, #企业编号
          bgcj001 LIKE bgcj_t.bgcj001, #来源作业
          bgcj002 LIKE bgcj_t.bgcj002, #预算编号
          bgcj003 LIKE bgcj_t.bgcj003, #版本
          bgcj004 LIKE bgcj_t.bgcj004, #管理组织
          bgcj005 LIKE bgcj_t.bgcj005, #销售来源
          bgcj006 LIKE bgcj_t.bgcj006, #数据类型
          bgcj007 LIKE bgcj_t.bgcj007, #预算组织
          bgcj008 LIKE bgcj_t.bgcj008, #预算期别
          bgcj009 LIKE bgcj_t.bgcj009, #预算料件
          bgcj010 LIKE bgcj_t.bgcj010, #组合KEY
          bgcjseq LIKE bgcj_t.bgcjseq, #项次
          bgcj011 LIKE bgcj_t.bgcj011, #预算样表
          bgcj012 LIKE bgcj_t.bgcj012, #人员
          bgcj013 LIKE bgcj_t.bgcj013, #部门
          bgcj014 LIKE bgcj_t.bgcj014, #成本利润中心
          bgcj015 LIKE bgcj_t.bgcj015, #区域
          bgcj016 LIKE bgcj_t.bgcj016, #收付款客商
          bgcj017 LIKE bgcj_t.bgcj017, #账款客商
          bgcj018 LIKE bgcj_t.bgcj018, #客群
          bgcj019 LIKE bgcj_t.bgcj019, #产品类别
          bgcj020 LIKE bgcj_t.bgcj020, #项目编号
          bgcj021 LIKE bgcj_t.bgcj021, #WBS
          bgcj022 LIKE bgcj_t.bgcj022, #经营方式
          bgcj023 LIKE bgcj_t.bgcj023, #渠道
          bgcj024 LIKE bgcj_t.bgcj024, #品牌
          bgcj025 LIKE bgcj_t.bgcj025, #自由核算项一
          bgcj026 LIKE bgcj_t.bgcj026, #自由核算项二
          bgcj027 LIKE bgcj_t.bgcj027, #自由核算项三
          bgcj028 LIKE bgcj_t.bgcj028, #自由核算项四
          bgcj029 LIKE bgcj_t.bgcj029, #自由核算项五
          bgcj030 LIKE bgcj_t.bgcj030, #自由核算项六
          bgcj031 LIKE bgcj_t.bgcj031, #自由核算项七
          bgcj032 LIKE bgcj_t.bgcj032, #自由核算项八
          bgcj033 LIKE bgcj_t.bgcj033, #自由核算项九
          bgcj034 LIKE bgcj_t.bgcj034, #自由核算项十
          bgcj035 LIKE bgcj_t.bgcj035, #税种
          bgcj036 LIKE bgcj_t.bgcj036, #含税否
          bgcj037 LIKE bgcj_t.bgcj037, #销售单位
          bgcj038 LIKE bgcj_t.bgcj038, #交易数量
          bgcj039 LIKE bgcj_t.bgcj039, #单价
          bgcj040 LIKE bgcj_t.bgcj040, #原币销售金额
          bgcj041 LIKE bgcj_t.bgcj041, #本层调整数量
          bgcj042 LIKE bgcj_t.bgcj042, #本层调整单价
          bgcj043 LIKE bgcj_t.bgcj043, #上层调整数量
          bgcj044 LIKE bgcj_t.bgcj044, #上层调整单价
          bgcj045 LIKE bgcj_t.bgcj045, #核准数量
          bgcj046 LIKE bgcj_t.bgcj046, #核准单价
          bgcj047 LIKE bgcj_t.bgcj047, #上层组织
          bgcj048 LIKE bgcj_t.bgcj048, #转凭证否
          bgcj049 LIKE bgcj_t.bgcj049, #预算细项
          bgcj050 LIKE bgcj_t.bgcj050, #编制起点
          bgcj051 LIKE bgcj_t.bgcj051, #生产预算抛转否
          bgcj052 LIKE bgcj_t.bgcj052, #内部采购组织
          bgcj053 LIKE bgcj_t.bgcj053, #内部采购预算细项
          bgcj100 LIKE bgcj_t.bgcj100, #交易币种
          bgcj101 LIKE bgcj_t.bgcj101, #汇率
          bgcj102 LIKE bgcj_t.bgcj102, #核准原币销售金额
          bgcj103 LIKE bgcj_t.bgcj103, #核准原币税前金额
          bgcj104 LIKE bgcj_t.bgcj104, #核准原币税额
          bgcj105 LIKE bgcj_t.bgcj105, #核准原币含税金额
          bgcjownid LIKE bgcj_t.bgcjownid, #资料所有者
          bgcjowndp LIKE bgcj_t.bgcjowndp, #资料所有部门
          bgcjcrtid LIKE bgcj_t.bgcjcrtid, #资料录入者
          bgcjcrtdp LIKE bgcj_t.bgcjcrtdp, #资料录入部门
          bgcjcrtdt LIKE bgcj_t.bgcjcrtdt, #资料创建日
          bgcjmodid LIKE bgcj_t.bgcjmodid, #资料更改者
          bgcjmoddt LIKE bgcj_t.bgcjmoddt, #最近更改日
          bgcjcnfid LIKE bgcj_t.bgcjcnfid, #资料审核者
          bgcjcnfdt LIKE bgcj_t.bgcjcnfdt, #数据审核日
          bgcjstus LIKE bgcj_t.bgcjstus, #状态码
          bgcjud001 LIKE bgcj_t.bgcjud001, #自定义字段(文本)001
          bgcjud002 LIKE bgcj_t.bgcjud002, #自定义字段(文本)002
          bgcjud003 LIKE bgcj_t.bgcjud003, #自定义字段(文本)003
          bgcjud004 LIKE bgcj_t.bgcjud004, #自定义字段(文本)004
          bgcjud005 LIKE bgcj_t.bgcjud005, #自定义字段(文本)005
          bgcjud006 LIKE bgcj_t.bgcjud006, #自定义字段(文本)006
          bgcjud007 LIKE bgcj_t.bgcjud007, #自定义字段(文本)007
          bgcjud008 LIKE bgcj_t.bgcjud008, #自定义字段(文本)008
          bgcjud009 LIKE bgcj_t.bgcjud009, #自定义字段(文本)009
          bgcjud010 LIKE bgcj_t.bgcjud010, #自定义字段(文本)010
          bgcjud011 LIKE bgcj_t.bgcjud011, #自定义字段(数字)011
          bgcjud012 LIKE bgcj_t.bgcjud012, #自定义字段(数字)012
          bgcjud013 LIKE bgcj_t.bgcjud013, #自定义字段(数字)013
          bgcjud014 LIKE bgcj_t.bgcjud014, #自定义字段(数字)014
          bgcjud015 LIKE bgcj_t.bgcjud015, #自定义字段(数字)015
          bgcjud016 LIKE bgcj_t.bgcjud016, #自定义字段(数字)016
          bgcjud017 LIKE bgcj_t.bgcjud017, #自定义字段(数字)017
          bgcjud018 LIKE bgcj_t.bgcjud018, #自定义字段(数字)018
          bgcjud019 LIKE bgcj_t.bgcjud019, #自定义字段(数字)019
          bgcjud020 LIKE bgcj_t.bgcjud020, #自定义字段(数字)020
          bgcjud021 LIKE bgcj_t.bgcjud021, #自定义字段(日期时间)021
          bgcjud022 LIKE bgcj_t.bgcjud022, #自定义字段(日期时间)022
          bgcjud023 LIKE bgcj_t.bgcjud023, #自定义字段(日期时间)023
          bgcjud024 LIKE bgcj_t.bgcjud024, #自定义字段(日期时间)024
          bgcjud025 LIKE bgcj_t.bgcjud025, #自定义字段(日期时间)025
          bgcjud026 LIKE bgcj_t.bgcjud026, #自定义字段(日期时间)026
          bgcjud027 LIKE bgcj_t.bgcjud027, #自定义字段(日期时间)027
          bgcjud028 LIKE bgcj_t.bgcjud028, #自定义字段(日期时间)028
          bgcjud029 LIKE bgcj_t.bgcjud029, #自定义字段(日期时间)029
          bgcjud030 LIKE bgcj_t.bgcjud030  #自定义字段(日期时间)030
   END RECORD
   #161108-00017#9 --e add
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgcj.bgcj007 = g_bgcj_m.bgcj007
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgcj.bgcj009 = g_bgcj_m.bgcj009
      LET l_bgcj.bgcj049 = g_bgcj_m.bgcj049
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgcj.bgcj013 = g_bgcj_m.bgcj013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgcj.bgcj014 = g_bgcj_m.bgcj014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgcj.bgcj015 = g_bgcj_m.bgcj015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgcj.bgcj016 = g_bgcj_m.bgcj016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgcj.bgcj017 = g_bgcj_m.bgcj017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgcj.bgcj018 = g_bgcj_m.bgcj018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgcj.bgcj019 = g_bgcj_m.bgcj019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgcj.bgcj022= g_bgcj_m.bgcj022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgcj.bgcj023= g_bgcj_m.bgcj023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgcj.bgcj024= g_bgcj_m.bgcj024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgcj.bgcj012= g_bgcj_m.bgcj012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgcj.bgcj020= g_bgcj_m.bgcj020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgcj.bgcj021= g_bgcj_m.bgcj021
   END IF
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgcj.bgcj007 = g_bgcj_d[l_ac].bgcj007
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgcj.bgcj009 = g_bgcj_d[l_ac].bgcj009
      LET l_bgcj.bgcj049 = g_bgcj_d[l_ac].bgcj049
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgcj.bgcj013 = g_bgcj_d[l_ac].bgcj013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgcj.bgcj014 = g_bgcj_d[l_ac].bgcj014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgcj.bgcj015 = g_bgcj_d[l_ac].bgcj015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgcj.bgcj016 = g_bgcj_d[l_ac].bgcj016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgcj.bgcj017 = g_bgcj_d[l_ac].bgcj017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgcj.bgcj018 = g_bgcj_d[l_ac].bgcj018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgcj.bgcj019 = g_bgcj_d[l_ac].bgcj019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgcj.bgcj022= g_bgcj_d[l_ac].bgcj022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgcj.bgcj023= g_bgcj_d[l_ac].bgcj023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgcj.bgcj024= g_bgcj_d[l_ac].bgcj024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgcj.bgcj012= g_bgcj_d[l_ac].bgcj012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgcj.bgcj020= g_bgcj_d[l_ac].bgcj020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgcj.bgcj021= g_bgcj_d[l_ac].bgcj021
   END IF
   
   #组合key bgcj010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET g_bgcj_d[l_ac].bgcj010 = "bgcj013=",l_bgcj.bgcj013,"/",
                                "bgcj014=",l_bgcj.bgcj014,"/",
                                "bgcj015=",l_bgcj.bgcj015,"/",
                                "bgcj016=",l_bgcj.bgcj016,"/",
                                "bgcj017=",l_bgcj.bgcj017,"/",
                                "bgcj018=",l_bgcj.bgcj018,"/",
                                "bgcj019=",l_bgcj.bgcj019,"/",
                                "bgcj022=",l_bgcj.bgcj022,"/",
                                "bgcj023=",l_bgcj.bgcj023,"/",
                                "bgcj024=",l_bgcj.bgcj024,"/",
                                "bgcj012=",l_bgcj.bgcj012,"/",
                                "bgcj020=",l_bgcj.bgcj020,"/",
                                "bgcj021=",l_bgcj.bgcj021,""
END FUNCTION

################################################################################
# Descriptions...: 状态码变更
# Memo...........:
# Usage..........: CALL abgt340_statechange()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"

   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_bgcjmodid  LIKE bgcj_t.bgcjmodid
   DEFINE l_bgcjmoddt  LIKE bgcj_t.bgcjmoddt
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgcj_m.bgcj001 IS NULL
   OR g_bgcj_m.bgcj002 IS NULL
   OR g_bgcj_m.bgcj003 IS NULL
   OR g_bgcj_m.bgcj004 IS NULL
   OR g_bgcj_m.bgcj005 IS NULL
   OR g_bgcj_m.bgcj006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 IS NULL)
 
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
      #预算组织在单头 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009
      #预算组织在单头 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007
      #预算组织在单身 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj009
      #预算组织在单身 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt340_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009 INTO g_bgcj_m.bgcj002,g_bgcj_m.bgcj003, 
       g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcjstus, 
       g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019,g_bgcj_m.bgcj022,g_bgcj_m.bgcj009, 
       g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023,g_bgcj_m.bgcj049,g_bgcj_m.bgcj015, 
       g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj012,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc 
   
 
   CALL abgt340_show()
 
   CASE g_bgcj_m.bgcjstus
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
   IF g_bgcj_m.bgcjstus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00044'
      LET g_errparam.extend = g_bgcj_m.bgcj002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   IF g_bgcj_m.bgcj005 = '2' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00245'
      LET g_errparam.extend = g_bgcj_m.bgcj002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   IF g_bgcj_m.bgcjstus = 'FC' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00020'
      LET g_errparam.extend = g_bgcj_m.bgcj002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgcj_m.bgcjstus
            
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
      CASE g_bgcj_m.bgcjstus
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #abgt340中状态为最终审核时不可以异动状态要去abgt350中异动
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
            IF NOT abgt340_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt340_hcl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abgt340_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt340_hcl
            RETURN
         END IF
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL cl_err_collect_init()
            #取消审核检查
            CALL s_abgt340_unconfirm_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,
                                         g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009) 
            RETURNING l_success
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #维度检核
            CALL abgt340_02(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                                  g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj011)
            RETURNING l_success
            #审核
            CALL cl_err_collect_init()
            IF l_success = TRUE THEN
               CALL s_abgt340_confirm_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,
                                          g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009) 
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
               CLOSE abgt340_hcl         
               RETURN
            END IF
            #无效检查
            CALL s_abgt340_void_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,
                                    g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009) 
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
      g_bgcj_m.bgcjstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #判断执行结果，当失败时，回滚数据库
   CALL cl_err_collect_show()
   IF l_success = FALSE  THEN
      CALL s_transaction_end('N','0')
      CLOSE abgt340_hcl
      RETURN
   END IF
   #end add-point
   
   LET l_bgcjmodid = g_user
   LET l_bgcjmoddt = cl_get_current()
   LET g_bgcj_m.bgcjstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   LET l_sql="UPDATE bgcj_t ",
             "   SET bgcjstus = '",g_bgcj_m.bgcjstus,"',",
             "       bgcjmodid = '",l_bgcjmodid,"',",
             "       bgcjmoddt = to_date('",l_bgcjmoddt,"','YYYY-MM-DD hh24:mi:ss'), "
   IF lc_state = 'Y' THEN
      LET l_sql=l_sql," bgcjcnfid = '",g_user,"',",
                      " bgcjcnfdt = to_date('",l_bgcjmoddt,"','YYYY-MM-DD hh24:mi:ss') "
   ELSE
      LET l_sql=l_sql," bgcjcnfid = NULL,",
                      " bgcjcnfdt = NULL "
   END IF
   LET l_sql=l_sql," WHERE bgcjent =  ",g_enterprise,
                   "   AND bgcj001 = '",g_bgcj_m.bgcj001,"'",
                   "   AND bgcj002 = '",g_bgcj_m.bgcj002,"'", 
                   "   AND bgcj003 = '",g_bgcj_m.bgcj003,"'", 
                   "   AND bgcj004 = '",g_bgcj_m.bgcj004,"'", 
                   "   AND bgcj005 = '",g_bgcj_m.bgcj005,"'", 
                   "   AND bgcj006 = '",g_bgcj_m.bgcj006,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj007 = '",g_bgcj_m.bgcj007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgcj009 = '",g_bgcj_m.bgcj009,"'"
   END IF         
   PREPARE abgt340_state_upd_pr FROM l_sql
   EXECUTE abgt340_state_upd_pr
   
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
      DISPLAY BY NAME g_bgcj_m.bgcj002,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj004_desc, 
       g_bgcj_m.bgaa002,g_bgcj_m.bgaa003,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006, 
       g_bgcj_m.bgcjstus,g_bgcj_m.bgcj007,g_bgcj_m.bgcj007_desc_t,g_bgcj_m.bgcj009,g_bgcj_m.bgcj049, 
       g_bgcj_m.bgcj012,g_bgcj_m.bgcj012_desc_t,g_bgcj_m.bgcj013,g_bgcj_m.bgcj013_desc_t,g_bgcj_m.bgcj014, 
       g_bgcj_m.bgcj014_desc_t,g_bgcj_m.bgcj015,g_bgcj_m.bgcj015_desc_t,g_bgcj_m.bgcj016,g_bgcj_m.bgcj016_desc_t, 
       g_bgcj_m.bgcj017,g_bgcj_m.bgcj017_desc_t,g_bgcj_m.bgcj018,g_bgcj_m.bgcj018_desc_t,g_bgcj_m.bgcj019, 
       g_bgcj_m.bgcj019_desc_t,g_bgcj_m.bgcj020,g_bgcj_m.bgcj020_desc_t,g_bgcj_m.bgcj021,g_bgcj_m.bgcj021_desc_t, 
       g_bgcj_m.bgcj022,g_bgcj_m.bgcj023,g_bgcj_m.bgcj023_desc_t,g_bgcj_m.bgcj024,g_bgcj_m.bgcj024_desc_t 

   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgt340_hcl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('statechange:'||lc_state)
  
END FUNCTION

################################################################################
# Descriptions...: 重写修改
# Memo...........:
# Usage..........: CALL abgt340_modify_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_modify_1()
   #add-point:modify段define name="modify.define_customerization"

   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"

   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"

   #end add-point
   
   IF g_bgcj_m.bgcj001 IS NULL
   OR g_bgcj_m.bgcj002 IS NULL
   OR g_bgcj_m.bgcj003 IS NULL
   OR g_bgcj_m.bgcj004 IS NULL
   OR g_bgcj_m.bgcj005 IS NULL
   OR g_bgcj_m.bgcj006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 IS NULL)
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgcj001_t = g_bgcj_m.bgcj001
   LET g_bgcj002_t = g_bgcj_m.bgcj002
   LET g_bgcj003_t = g_bgcj_m.bgcj003
   LET g_bgcj004_t = g_bgcj_m.bgcj004
   LET g_bgcj005_t = g_bgcj_m.bgcj005
   LET g_bgcj006_t = g_bgcj_m.bgcj006
   LET g_bgcj007_t = g_bgcj_m.bgcj007
   LET g_bgcj009_t = g_bgcj_m.bgcj009
 
   CALL s_transaction_begin()
   
   CASE
      #预算组织在单头 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009
      #预算组织在单头 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007
      #预算组织在单身 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj009
      #预算组织在单身 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt340_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009 INTO g_bgcj_m.bgcj002,g_bgcj_m.bgcj003, 
       g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcjstus, 
       g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019,g_bgcj_m.bgcj022,g_bgcj_m.bgcj009, 
       g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023,g_bgcj_m.bgcj049,g_bgcj_m.bgcj015, 
       g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj012,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc 

   
   #遮罩相關處理
   LET g_bgcj_m_mask_o.* =  g_bgcj_m.*
   CALL abgt340_bgcj_t_mask()
   LET g_bgcj_m_mask_n.* =  g_bgcj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt340_show()
   WHILE TRUE
      LET g_bgcj001_t = g_bgcj_m.bgcj001
      LET g_bgcj002_t = g_bgcj_m.bgcj002
      LET g_bgcj003_t = g_bgcj_m.bgcj003
      LET g_bgcj004_t = g_bgcj_m.bgcj004
      LET g_bgcj005_t = g_bgcj_m.bgcj005
      LET g_bgcj006_t = g_bgcj_m.bgcj006
      LET g_bgcj007_t = g_bgcj_m.bgcj007
      LET g_bgcj009_t = g_bgcj_m.bgcj009
 
 
      #add-point:modify段修改前 name="modify.before_input"
      LET g_bgcj_m_t.* = g_bgcj_m.*
      #end add-point
      
      CALL abgt340_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"

      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgcj_m.* = g_bgcj_m_t.*
         CALL abgt340_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgcj_m.bgcj001 != g_bgcj001_t 
      OR g_bgcj_m.bgcj002 != g_bgcj002_t 
      OR g_bgcj_m.bgcj003 != g_bgcj003_t 
      OR g_bgcj_m.bgcj004 != g_bgcj004_t 
      OR g_bgcj_m.bgcj005 != g_bgcj005_t 
      OR g_bgcj_m.bgcj006 != g_bgcj006_t 
      OR g_bgcj_m.bgcj007 != g_bgcj007_t 
      OR g_bgcj_m.bgcj009 != g_bgcj009_t 
 
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
   CALL abgt340_set_act_visible()
   CALL abgt340_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgcjent = " ||g_enterprise|| " AND",
                      " bgcj001 = '", g_bgcj_m.bgcj001, "' "
                      ," AND bgcj002 = '", g_bgcj_m.bgcj002, "' "
                      ," AND bgcj003 = '", g_bgcj_m.bgcj003, "' "
                      ," AND bgcj004 = '", g_bgcj_m.bgcj004, "' "
                      ," AND bgcj005 = '", g_bgcj_m.bgcj005, "' "
                      ," AND bgcj006 = '", g_bgcj_m.bgcj006, "' "
                      ," AND bgcj007 = '", g_bgcj_m.bgcj007, "' "
                      ," AND bgcj009 = '", g_bgcj_m.bgcj009, "' "
 
   #填到對應位置
   CALL abgt340_browser_fill("")
 
   CALL abgt340_idx_chk()
 
   CLOSE abgt340_hcl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('modify')
END FUNCTION

################################################################################
# Descriptions...: 重写删除
# Memo...........:
# Usage..........: CALL abgt340_delete_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_delete_1()
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
   
   IF g_bgcj_m.bgcj001 IS NULL
   OR g_bgcj_m.bgcj002 IS NULL
   OR g_bgcj_m.bgcj003 IS NULL
   OR g_bgcj_m.bgcj004 IS NULL
   OR g_bgcj_m.bgcj005 IS NULL
   OR g_bgcj_m.bgcj006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgcj_m.bgcj007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgcj_m.bgcj009 IS NULL)
 
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
      #预算组织在单头 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009
      #预算组织在单头 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007
      #预算组织在单身 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj009
      #预算组织在单身 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt340_hcl USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,
             g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt340_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt340_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt340_master_referesh USING g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004, 
       g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009 INTO g_bgcj_m.bgcj002,g_bgcj_m.bgcj003, 
       g_bgcj_m.bgcj004,g_bgcj_m.bgcj011,g_bgcj_m.bgcj001,g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcjstus, 
       g_bgcj_m.bgcj007,g_bgcj_m.bgcj013,g_bgcj_m.bgcj016,g_bgcj_m.bgcj019,g_bgcj_m.bgcj022,g_bgcj_m.bgcj009, 
       g_bgcj_m.bgcj014,g_bgcj_m.bgcj017,g_bgcj_m.bgcj020,g_bgcj_m.bgcj023,g_bgcj_m.bgcj049,g_bgcj_m.bgcj015, 
       g_bgcj_m.bgcj018,g_bgcj_m.bgcj021,g_bgcj_m.bgcj024,g_bgcj_m.bgcj012,g_bgcj_m.bgcj002_desc,g_bgcj_m.bgcj004_desc 

   
   #遮罩相關處理
   LET g_bgcj_m_mask_o.* =  g_bgcj_m.*
   CALL abgt340_bgcj_t_mask()
   LET g_bgcj_m_mask_n.* =  g_bgcj_m.*
   
   CALL abgt340_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt340_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"

      #end add-point
      LET l_sql = "DELETE FROM bgcj_t ",
                  " WHERE bgcjent = ",g_enterprise,
                  "   AND bgcj001 ='",g_bgcj_m.bgcj001,"'",
                  "   AND bgcj002 ='",g_bgcj_m.bgcj002,"'",
                  "   AND bgcj003 ='",g_bgcj_m.bgcj003,"'",
                  "   AND bgcj004 ='",g_bgcj_m.bgcj004,"'",
                  "   AND bgcj005 ='",g_bgcj_m.bgcj005,"'",
                  "   AND bgcj006 ='",g_bgcj_m.bgcj006,"'"
      #预算组织在单头
      IF g_bgaw1[1] = 'Y' THEN
         LET l_sql = l_sql,"   AND bgcj007 ='",g_bgcj_m.bgcj007,"'"
      END IF
      #预算料号在单头
      IF g_bgaw1[2] = 'Y' THEN
         LET l_sql = l_sql,"   AND bgcj009 ='",g_bgcj_m.bgcj009,"'"
      END IF
      PREPARE abgt340_delete_pr FROM l_sql
      EXECUTE abgt340_delete_pr
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
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
      CALL g_bgcj_d.clear() 
      CALL g_bgcj2_d.clear()       
      CALL g_bgcj3_d.clear()       
 
     
      CALL abgt340_ui_browser_refresh()  
      #CALL abgt340_ui_headershow()  
      #CALL abgt340_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt340_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt340_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt340_hcl
 
   #功能已完成,通報訊息中心
   CALL abgt340_msgcentre_notify('delete')
    
END FUNCTION

################################################################################
# Descriptions...: 调用abgt340_01预算调整子作业调整金额
# Memo...........:
# Usage..........: CALL abgt340_adjust(p_type)
# Input parameter: p_type      1.本层调整 2.上层调整
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_adjust(p_type)
   DEFINE p_type         LIKE type_t.num5
   DEFINE l_bgcj007      LIKE bgcj_t.bgcj007
   DEFINE l_bgcj009      LIKE bgcj_t.bgcj009
   DEFINE l_sql,l_sql1   STRING
   DEFINE l_cnt          LIKE type_t.num5
   
   IF cl_null(g_bgcj_m.bgcj001) OR cl_null(g_bgcj_m.bgcj002) OR cl_null(g_bgcj_m.bgcj003) OR
      cl_null(g_bgcj_m.bgcj004) OR cl_null(g_bgcj_m.bgcj005) OR cl_null(g_bgcj_m.bgcj006) THEN
      RETURN
   END IF
   
   IF g_bgcj_m.bgcjstus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00218"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF g_bgcj_m.bgcjstus = 'FC' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00020"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF l_ac < 1 OR cl_null(g_bgcj_d[l_ac].bgcjseq) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-400"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #检核预算组织或预算组织的上层组织是否已存在与abgt350中，如果存在，不可调整
   LET l_sql1 ="  FROM bgcj_t ",
               " WHERE bgcjent=",g_enterprise,
               "   AND bgcj001 = '",g_bgcj_m.bgcj001,"'",
               "   AND bgcj002 = '",g_bgcj_m.bgcj002,"'", 
               "   AND bgcj003 = '",g_bgcj_m.bgcj003,"'", 
               "   AND bgcj004 = '",g_bgcj_m.bgcj004,"'", 
               "   AND bgcj005 = '",g_bgcj_m.bgcj005,"'", 
               "   AND bgcj006 = '",g_bgcj_m.bgcj006,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql1 = l_sql1," AND bgcj007 = '",g_bgcj_m.bgcj007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql1 = l_sql1," AND bgcj009 = '",g_bgcj_m.bgcj009,"'"
   END IF    
   LET l_cnt = 0
   #预算组织
   LET l_sql="SELECT COUNT(1) FROM bgcj_t",
             " WHERE bgcjent=",g_enterprise, 
             "   AND bgcj001='30'",
             "   AND bgcj002='",g_bgcj_m.bgcj002,"'",
             "   AND bgcj003='",g_bgcj_m.bgcj003,"'",
             "   AND bgcj004='",g_bgcj_m.bgcj004,"'",
             "   AND bgcj005='",g_bgcj_m.bgcj005,"'",
             "   AND bgcj006='2'",
             "   AND bgcjstus <> 'X'",
             "   AND bgcj007 IN (SELECT DISTINCT bgcj007 ",l_sql1,")"
   PREPARE abgt340_bgcj007_pr FROM l_sql
   EXECUTE abgt340_bgcj007_pr INTO l_cnt
   IF cl_null(l_cnt) THEN  LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'abg-00229'
      #161215-00014#1--add--str--
      LET g_errparam.replace[1] = cl_get_progname('abgt350',g_lang,"2")
      LET g_errparam.exeprog = 'abgt350'
      #161215-00014#1--add--end
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   LET l_cnt = 0
   #预算组织的上层组织
   LET l_sql="SELECT COUNT(1) FROM bgcj_t",
             " WHERE bgcjent=",g_enterprise, 
             "   AND bgcj001='30'",
             "   AND bgcj002='",g_bgcj_m.bgcj002,"'",
             "   AND bgcj003='",g_bgcj_m.bgcj003,"'",
             "   AND bgcj004='",g_bgcj_m.bgcj004,"'",
             "   AND bgcj005='",g_bgcj_m.bgcj005,"'",
             "   AND bgcj006='2'",
             "   AND bgcjstus <> 'X'",
             "   AND bgcj007 IN (SELECT DISTINCT bgcj047 ",l_sql1,")"
   PREPARE abgt340_bgcj007_pr2 FROM l_sql
   EXECUTE abgt340_bgcj007_pr2 INTO l_cnt
   IF cl_null(l_cnt) THEN  LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'abg-00230'
      #161215-00014#1--add--str--
      LET g_errparam.replace[1] = cl_get_progname('abgt350',g_lang,"2")
      LET g_errparam.exeprog = 'abgt350'
      #161215-00014#1--add--end
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #重写单身锁资料sql
   #161220-00036#1--mod--str--
#   LET g_forupd_sql = "SELECT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015, 
#       bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037, 
#       bgcj100,bgcj101,0,bgcj047,bgcj048,bgcj050,bgcjseq,bgcjownid,bgcjowndp, 
#       bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq FROM bgcj_t WHERE  
#       bgcjent=? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=?  
#       AND bgcj007=? AND bgcj009=? AND bgcj010=? AND bgcjseq=? FOR UPDATE"
   LET g_forupd_sql = "SELECT bgcjseq,bgcj010,bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,", 
       "bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj035,bgcj036,bgcj037,", 
       "bgcj100,0,bgcj047,bgcj048,bgcj050,bgcjseq,bgcjownid,bgcjowndp,", 
       "bgcjcrtid,bgcjcrtdp,bgcjcrtdt,bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjseq ",
       "  FROM bgcj_t ",
       " WHERE bgcjent=? AND bgcj001=? AND bgcj002=? AND bgcj003=? AND bgcj004=? AND bgcj005=? AND bgcj006=? ", 
       "   AND bgcj007=? AND bgcj009=? AND bgcj010=? AND bgcjseq=? FOR UPDATE"
   #161220-00036#1--mod--end
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt340_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   
   #锁住这笔项次资料
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgcj007 = g_bgcj_m.bgcj007
   ELSE
      LET l_bgcj007 = g_bgcj_d[l_ac].bgcj007
   END IF
   
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgcj009 = g_bgcj_m.bgcj009
   ELSE
      LET l_bgcj009 = g_bgcj_d[l_ac].bgcj009
   END IF
   CALL s_transaction_begin()
   OPEN abgt340_bcl2 USING g_enterprise,g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,
                          g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,l_bgcj007,l_bgcj009,g_bgcj_d[l_ac].bgcj010,
                          g_bgcj_d[l_ac].bgcjseq
                 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt340_bcl2:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      CLOSE abgt340_bcl2
      RETURN
   END IF
   CALL abgt340_01(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                   g_bgcj_m.bgcj006,l_bgcj007,l_bgcj009,g_bgcj_d[l_ac].bgcj010,g_bgcj_d[l_ac].bgcjseq,p_type)
   CLOSE abgt340_bcl2
   CALL s_transaction_end('Y','0')
   CALL abgt340_b_fill2(l_ac)
END FUNCTION

################################################################################
# Descriptions...: BPM提交
# Memo...........:
# Usage..........: CALL abgt340_send()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/08 By 02599
# Modify.........: 
################################################################################
PRIVATE FUNCTION abgt340_send()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success1   LIKE type_t.num5
   
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
  
   CALL abgt340_set_pk_array()
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bgcj_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bgcj_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段 
   CALL cl_err_collect_init()
   #维度检核
   CALL abgt340_02(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,g_bgcj_m.bgcj005,
                   g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009,g_bgcj_m.bgcj011)
   RETURNING l_success
   #审核检查
   IF l_success = TRUE THEN
      CALL s_abgt340_confirm_chk(g_bgcj_m.bgcj001,g_bgcj_m.bgcj002,g_bgcj_m.bgcj003,g_bgcj_m.bgcj004,
                                 g_bgcj_m.bgcj005,g_bgcj_m.bgcj006,g_bgcj_m.bgcj007,g_bgcj_m.bgcj009) 
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
   #CALL abgt340_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt340_ui_headershow()
   CALL abgt340_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: BPM抽单
# Memo...........:
# Usage..........: CALL abgt340_draw_out()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/08 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_draw_out()
   
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt340_ui_headershow()  
   CALL abgt340_ui_detailshow()
 
 
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 当预算细项维护了单身才能抓取到值时，需检查单头核算项是否都录入
# Memo...........: #161215-00014#1
# Usage..........: CALL abgt340_head_hsx_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/15 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_head_hsx_chk()
   DEFINE l_flag        LIKE type_t.num5
   
   IF cl_null(g_bgcj_d[l_ac].bgcjseq) THEN
      RETURN
   END IF
   #预算料号在单身或预算料号在单头+预算组织在单身，这两种情况预算细项都在进入单身中抓取到值
   IF NOT (g_bgaw2[2]='Y' OR (g_bgaw1[2]='Y' AND g_bgaw2[1]='Y')) THEN
      RETURN
   END IF
   LET l_flag = 0
   #部门
   IF g_bgaw1[3]='Y' AND g_bgal.bgal005 = 'Y' AND cl_null(g_bgcj_m.bgcj013) THEN
      LET l_flag = l_flag + 1
   END IF
   #利润成本中心
   IF g_bgaw1[4]='Y' AND g_bgal.bgal006 = 'Y' AND cl_null(g_bgcj_m.bgcj014) THEN
      LET l_flag = l_flag + 1
   END IF
   #区域
   IF g_bgaw1[5]='Y' AND g_bgal.bgal007 = 'Y' AND cl_null(g_bgcj_m.bgcj015) THEN
      LET l_flag = l_flag + 1
   END IF
   #收付款客商
   IF g_bgaw1[6]='Y' AND g_bgal.bgal008 = 'Y' AND cl_null(g_bgcj_m.bgcj016) THEN
      LET l_flag = l_flag + 1
   END IF 
   #账款客商
   IF g_bgaw1[7]='Y' AND g_bgal.bgal009 = 'Y' AND cl_null(g_bgcj_m.bgcj017) THEN
      LET l_flag = l_flag + 1
   END IF  
   #客群
   IF g_bgaw1[8]='Y' AND g_bgal.bgal010 = 'Y' AND cl_null(g_bgcj_m.bgcj018) THEN
      LET l_flag = l_flag + 1
   END IF
   #产品类别
   IF g_bgaw1[9]='Y' AND g_bgal.bgal011 = 'Y' AND cl_null(g_bgcj_m.bgcj019) THEN
      LET l_flag = l_flag + 1
   END IF
   #经营方式
   IF g_bgaw1[10]='Y' AND g_bgal.bgal025 = 'Y' AND cl_null(g_bgcj_m.bgcj022) THEN
      LET l_flag = l_flag + 1
   END IF
   #通路
   IF g_bgaw1[11]='Y' AND g_bgal.bgal026 = 'Y' AND cl_null(g_bgcj_m.bgcj023) THEN
      LET l_flag = l_flag + 1
   END IF
   #品牌
   IF g_bgaw1[12]='Y' AND g_bgal.bgal027 = 'Y' AND cl_null(g_bgcj_m.bgcj023) THEN
      LET l_flag = l_flag + 1
   END IF
   #人员
   IF g_bgaw1[13]='Y' AND g_bgal.bgal012 = 'Y' AND cl_null(g_bgcj_m.bgcj012) THEN
      LET l_flag = l_flag + 1
   END IF
   #专案
   IF g_bgaw1[14]='Y' AND g_bgal.bgal013 = 'Y' AND cl_null(g_bgcj_m.bgcj020) THEN
      LET l_flag = l_flag + 1
   END IF
   #WBS
   IF g_bgaw1[15]='Y' AND g_bgal.bgal014 = 'Y' AND cl_null(g_bgcj_m.bgcj021) THEN
      LET l_flag = l_flag + 1
   END IF
   #单头存在未录入的核算项资料，提示操作者
   IF l_flag > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'abg-00309'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
END FUNCTION

 
{</section>}
 
