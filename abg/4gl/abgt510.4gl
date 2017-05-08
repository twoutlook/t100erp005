#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-11-18 14:18:33), PR版次:0004(2017-01-03 16:01:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt510
#+ Description: 期別採購預算維護
#+ Creator....: 02599(2016-11-17 21:20:08)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="abgt510.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161215-00014#2  2016/12/15 By 02599    报错信息修改
#161220-00036#1  2016/12/20 By 02599    抓取第二单身的金额时，初始化变量
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
PRIVATE type type_g_bgeg_m        RECORD
       bgeg002 LIKE bgeg_t.bgeg002, 
   bgeg002_desc LIKE type_t.chr80, 
   bgeg003 LIKE bgeg_t.bgeg003, 
   bgeg004 LIKE bgeg_t.bgeg004, 
   bgeg004_desc LIKE type_t.chr80, 
   bgaa002 LIKE type_t.chr10, 
   bgaa003 LIKE type_t.chr10, 
   bgeg011 LIKE bgeg_t.bgeg011, 
   bgeg001 LIKE bgeg_t.bgeg001, 
   bgeg005 LIKE bgeg_t.bgeg005, 
   bgeg006 LIKE bgeg_t.bgeg006, 
   bgeg010 LIKE bgeg_t.bgeg010, 
   bgegstus LIKE bgeg_t.bgegstus, 
   bgeg007 LIKE bgeg_t.bgeg007, 
   bgeg007_desc_t LIKE type_t.chr80, 
   bgeg013 LIKE bgeg_t.bgeg013, 
   bgeg013_desc_t LIKE type_t.chr80, 
   bgeg016 LIKE bgeg_t.bgeg016, 
   bgeg016_desc_t LIKE type_t.chr80, 
   bgeg019 LIKE bgeg_t.bgeg019, 
   bgeg019_desc_t LIKE type_t.chr80, 
   bgeg022 LIKE bgeg_t.bgeg022, 
   bgeg009 LIKE bgeg_t.bgeg009, 
   bgeg014 LIKE bgeg_t.bgeg014, 
   bgeg014_desc_t LIKE type_t.chr80, 
   bgeg017 LIKE bgeg_t.bgeg017, 
   bgeg017_desc_t LIKE type_t.chr80, 
   bgeg020 LIKE bgeg_t.bgeg020, 
   bgeg020_desc_t LIKE type_t.chr80, 
   bgeg023 LIKE bgeg_t.bgeg023, 
   bgeg023_desc_t LIKE type_t.chr80, 
   bgeg012 LIKE bgeg_t.bgeg012, 
   bgeg012_desc_t LIKE type_t.chr80, 
   bgeg015 LIKE bgeg_t.bgeg015, 
   bgeg015_desc_t LIKE type_t.chr80, 
   bgeg018 LIKE bgeg_t.bgeg018, 
   bgeg018_desc_t LIKE type_t.chr80, 
   bgeg021 LIKE bgeg_t.bgeg021, 
   bgeg021_desc_t LIKE type_t.chr80, 
   bgeg024 LIKE bgeg_t.bgeg024, 
   bgeg024_desc_t LIKE type_t.chr80, 
   bgeg049 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgeg_d        RECORD
       bgegseq LIKE bgeg_t.bgegseq, 
   bgeg010 LIKE bgeg_t.bgeg010, 
   bgeg007 LIKE bgeg_t.bgeg007, 
   bgeg007_desc LIKE type_t.chr500, 
   bgeg009 LIKE bgeg_t.bgeg009, 
   bgeg009_desc LIKE type_t.chr500, 
   bgeg049 LIKE bgeg_t.bgeg049, 
   bgeg012 LIKE bgeg_t.bgeg012, 
   bgeg012_desc LIKE type_t.chr500, 
   bgeg013 LIKE bgeg_t.bgeg013, 
   bgeg013_desc LIKE type_t.chr500, 
   bgeg014 LIKE bgeg_t.bgeg014, 
   bgeg014_desc LIKE type_t.chr500, 
   bgeg015 LIKE bgeg_t.bgeg015, 
   bgeg015_desc LIKE type_t.chr500, 
   bgeg016 LIKE bgeg_t.bgeg016, 
   bgeg016_desc LIKE type_t.chr500, 
   bgeg017 LIKE bgeg_t.bgeg017, 
   bgeg017_desc LIKE type_t.chr500, 
   bgeg018 LIKE bgeg_t.bgeg018, 
   bgeg018_desc LIKE type_t.chr500, 
   bgeg019 LIKE bgeg_t.bgeg019, 
   bgeg019_desc LIKE type_t.chr500, 
   bgeg020 LIKE bgeg_t.bgeg020, 
   bgeg020_desc LIKE type_t.chr500, 
   bgeg021 LIKE bgeg_t.bgeg021, 
   bgeg021_desc LIKE type_t.chr500, 
   bgeg022 LIKE bgeg_t.bgeg022, 
   bgeg023 LIKE bgeg_t.bgeg023, 
   bgeg023_desc LIKE type_t.chr500, 
   bgeg024 LIKE bgeg_t.bgeg024, 
   bgeg024_desc LIKE type_t.chr500, 
   bgeg035 LIKE bgeg_t.bgeg035, 
   bgeg036 LIKE bgeg_t.bgeg036, 
   bgeg037 LIKE bgeg_t.bgeg037, 
   bgeg100 LIKE bgeg_t.bgeg100, 
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
   bgeg008 LIKE bgeg_t.bgeg008, 
   bgeg047 LIKE bgeg_t.bgeg047, 
   bgeg048 LIKE bgeg_t.bgeg048, 
   bgeg050 LIKE bgeg_t.bgeg050
       END RECORD
PRIVATE TYPE type_g_bgeg2_d RECORD
       bgegseq LIKE bgeg_t.bgegseq, 
   bgegownid LIKE bgeg_t.bgegownid, 
   bgegownid_desc LIKE type_t.chr500, 
   bgegowndp LIKE bgeg_t.bgegowndp, 
   bgegowndp_desc LIKE type_t.chr500, 
   bgegcrtid LIKE bgeg_t.bgegcrtid, 
   bgegcrtid_desc LIKE type_t.chr500, 
   bgegcrtdp LIKE bgeg_t.bgegcrtdp, 
   bgegcrtdp_desc LIKE type_t.chr500, 
   bgegcrtdt DATETIME YEAR TO SECOND, 
   bgegmodid LIKE bgeg_t.bgegmodid, 
   bgegmodid_desc LIKE type_t.chr500, 
   bgegmoddt DATETIME YEAR TO SECOND, 
   bgegcnfid LIKE bgeg_t.bgegcnfid, 
   bgegcnfid_desc LIKE type_t.chr500, 
   bgegcnfdt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_bgeg3_d RECORD
       bgegseq LIKE bgeg_t.bgegseq, 
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
DEFINE g_bgeg_m          type_g_bgeg_m
DEFINE g_bgeg_m_t        type_g_bgeg_m
DEFINE g_bgeg_m_o        type_g_bgeg_m
DEFINE g_bgeg_m_mask_o   type_g_bgeg_m #轉換遮罩前資料
DEFINE g_bgeg_m_mask_n   type_g_bgeg_m #轉換遮罩後資料
 
   DEFINE g_bgeg002_t LIKE bgeg_t.bgeg002
DEFINE g_bgeg003_t LIKE bgeg_t.bgeg003
DEFINE g_bgeg004_t LIKE bgeg_t.bgeg004
DEFINE g_bgeg001_t LIKE bgeg_t.bgeg001
DEFINE g_bgeg005_t LIKE bgeg_t.bgeg005
DEFINE g_bgeg006_t LIKE bgeg_t.bgeg006
DEFINE g_bgeg010_t LIKE bgeg_t.bgeg010
DEFINE g_bgeg007_t LIKE bgeg_t.bgeg007
DEFINE g_bgeg009_t LIKE bgeg_t.bgeg009
 
 
DEFINE g_bgeg_d          DYNAMIC ARRAY OF type_g_bgeg_d
DEFINE g_bgeg_d_t        type_g_bgeg_d
DEFINE g_bgeg_d_o        type_g_bgeg_d
DEFINE g_bgeg_d_mask_o   DYNAMIC ARRAY OF type_g_bgeg_d #轉換遮罩前資料
DEFINE g_bgeg_d_mask_n   DYNAMIC ARRAY OF type_g_bgeg_d #轉換遮罩後資料
DEFINE g_bgeg2_d   DYNAMIC ARRAY OF type_g_bgeg2_d
DEFINE g_bgeg2_d_t type_g_bgeg2_d
DEFINE g_bgeg2_d_o type_g_bgeg2_d
DEFINE g_bgeg2_d_mask_o   DYNAMIC ARRAY OF type_g_bgeg2_d #轉換遮罩前資料
DEFINE g_bgeg2_d_mask_n   DYNAMIC ARRAY OF type_g_bgeg2_d #轉換遮罩後資料
DEFINE g_bgeg3_d   DYNAMIC ARRAY OF type_g_bgeg3_d
DEFINE g_bgeg3_d_t type_g_bgeg3_d
DEFINE g_bgeg3_d_o type_g_bgeg3_d
DEFINE g_bgeg3_d_mask_o   DYNAMIC ARRAY OF type_g_bgeg3_d #轉換遮罩前資料
DEFINE g_bgeg3_d_mask_n   DYNAMIC ARRAY OF type_g_bgeg3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bgeg001 LIKE bgeg_t.bgeg001,
      b_bgeg002 LIKE bgeg_t.bgeg002,
      b_bgeg003 LIKE bgeg_t.bgeg003,
      b_bgeg004 LIKE bgeg_t.bgeg004,
      b_bgeg005 LIKE bgeg_t.bgeg005,
      b_bgeg006 LIKE bgeg_t.bgeg006,
      b_bgeg007 LIKE bgeg_t.bgeg007,
      b_bgeg009 LIKE bgeg_t.bgeg009,
      b_bgeg010 LIKE bgeg_t.bgeg010
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
 
{<section id="abgt510.main" >}
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
   CALL s_abgt510_create_head_tmp()
   
   #单头锁资料重写，在fetch段定义
   IF 1=2 THEN
   #end add-point
   LET g_forupd_sql = " SELECT bgeg002,'',bgeg003,bgeg004,'','','',bgeg011,bgeg001,bgeg005,bgeg006,bgeg010, 
       bgegstus,bgeg007,'',bgeg013,'',bgeg016,'',bgeg019,'',bgeg022,bgeg009,bgeg014,'',bgeg017,'',bgeg020, 
       '',bgeg023,'',bgeg012,'',bgeg015,'',bgeg018,'',bgeg021,'',bgeg024,'',''", 
                      " FROM bgeg_t",
                      " WHERE bgegent= ? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND  
                          bgeg005=? AND bgeg006=? AND bgeg007=? AND bgeg009=? AND bgeg010=? FOR UPDATE" 
 
   #add-point:SQL_define name="main.after_define_sql"
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgeg002,t0.bgeg003,t0.bgeg004,t0.bgeg011,t0.bgeg001,t0.bgeg005,t0.bgeg006, 
       t0.bgeg010,t0.bgegstus,t0.bgeg007,t0.bgeg013,t0.bgeg016,t0.bgeg019,t0.bgeg022,t0.bgeg009,t0.bgeg014, 
       t0.bgeg017,t0.bgeg020,t0.bgeg023,t0.bgeg012,t0.bgeg015,t0.bgeg018,t0.bgeg021,t0.bgeg024,t0.bgeg049, 
       t1.bgaal003 ,t2.bgail004",
               " FROM bgeg_t t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bgeg002 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN bgail_t t2 ON t2.bgailent="||g_enterprise||" AND t2.bgail001=t0.bgeg002 AND t2.bgail002=t0.bgeg004 AND t2.bgail003='"||g_dlang||"' ",
 
               " WHERE t0.bgegent = " ||g_enterprise|| " AND t0.bgeg001 = ? AND t0.bgeg002 = ? AND t0.bgeg003 = ? AND t0.bgeg004 = ? AND t0.bgeg005 = ? AND t0.bgeg006 = ? AND t0.bgeg007 = ? AND t0.bgeg009 = ? AND t0.bgeg010 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   END IF
   #重寫抓取單頭資料SQL，資料改抓取單頭臨時表
   LET g_sql = " SELECT DISTINCT t0.bgeg002,t0.bgeg003,t0.bgeg004,t0.bgeg011,t0.bgeg001,t0.bgeg005,t0.bgeg006, 
       t0.bgeg010,t0.bgegstus,t0.bgeg007,t0.bgeg013,t0.bgeg016,t0.bgeg019,t0.bgeg022,t0.bgeg009,t0.bgeg014, 
       t0.bgeg017,t0.bgeg020,t0.bgeg023,t0.bgeg049,t0.bgeg015,t0.bgeg018,t0.bgeg021,t0.bgeg024,t0.bgeg012, 
       t1.bgaal003 ,t2.bgail004",       
               " FROM s_abgt510_tmp t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bgeg002 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN bgail_t t2 ON t2.bgailent="||g_enterprise||" AND t2.bgail001=t0.bgeg002 AND t2.bgail002=t0.bgeg004 AND t2.bgail003='"||g_dlang||"' ",
 
               " WHERE t0.bgegent = " ||g_enterprise|| " AND t0.bgeg001 = ? AND t0.bgeg002 = ? AND t0.bgeg003 = ? AND t0.bgeg004 = ? AND t0.bgeg005 = ? AND t0.bgeg006 = ? AND t0.bgeg007 = ? AND t0.bgeg009 = ? AND t0.bgeg010 = ?"
   #end add-point
   PREPARE abgt510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt510 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt510_init()   
 
      #進入選單 Menu (="N")
      CALL abgt510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt510
      
   END IF 
   
   CLOSE abgt510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_abgt510_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt510_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('bgegstus','13','N,Y,FC,A,D,R,W,X')
 
      CALL cl_set_combo_scc('bgeg005','8958') 
   CALL cl_set_combo_scc('bgeg006','9989') 
   CALL cl_set_combo_scc('bgeg022','6013') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
#   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('bgeg022_2','6013')
   #end add-point
   
   CALL abgt510_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt510.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt510_ui_dialog()
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
   CALL cl_set_act_visible("open_abgt510_01_s", FALSE)
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bgeg_m.* TO NULL
         CALL g_bgeg_d.clear()
         CALL g_bgeg2_d.clear()
         CALL g_bgeg3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt510_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_bgeg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgt510_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgt510_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               #根据单身一的资料动态显示对应调整资料
               CALL abgt510_b_fill2(l_ac)
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
        
         DISPLAY ARRAY g_bgeg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt510_idx_chk()
               CALL abgt510_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               #根据单身一的资料动态显示对应调整资料
               CALL abgt510_b_fill2(l_ac)
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
         DISPLAY ARRAY g_bgeg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt510_idx_chk()
               CALL abgt510_ui_detailshow()
               
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
            CALL abgt510_browser_fill("")
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
               CALL abgt510_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt510_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abgt510_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abgt510_set_act_visible()   
            CALL abgt510_set_act_no_visible()
            IF NOT (g_bgeg_m.bgeg001 IS NULL
                 OR g_bgeg_m.bgeg002 IS NULL
                 OR g_bgeg_m.bgeg003 IS NULL
                 OR g_bgeg_m.bgeg004 IS NULL
                 OR g_bgeg_m.bgeg005 IS NULL
                 OR g_bgeg_m.bgeg006 IS NULL
                 OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 IS NULL)
                 OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 IS NULL)
            
              ) THEN
               #組合條件
               LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                                  " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                                 ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                                 ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                                 ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                                 ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                                 ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
                                 ," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
                                 ," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
            
               #填到對應位置
               CALL abgt510_browser_fill("")
            END IF
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt510_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt510_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt510_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt510_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt510_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt510_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt510_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt510_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt510_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt510_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgeg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgeg2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_bgeg3_d)
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
               NEXT FIELD bgeg008
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
               CALL abgt510_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgt510_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgt510_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt510_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt510_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_01
            LET g_action_choice="open_abgt340_01"
            IF cl_auth_chk_act("open_abgt340_01") THEN
               
               #add-point:ON ACTION open_abgt340_01 name="menu.open_abgt340_01"
               #本层调整
               CALL abgt510_adjust(1)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgt340_02
            LET g_action_choice="open_abgt340_02"
            IF cl_auth_chk_act("open_abgt340_02") THEN
               
               #add-point:ON ACTION open_abgt340_02 name="menu.open_abgt340_02"
               IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) AND
                  NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) AND 
                  NOT cl_null(g_bgeg_m.bgeg011) THEN
                  CALL abgt340_02(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                  g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg011)
                  RETURNING l_success
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt510_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/abg/abgt510_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/abg/abgt510_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgt510_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgp510
            LET g_action_choice="open_abgp510"
            IF cl_auth_chk_act("open_abgp510") THEN
               
               #add-point:ON ACTION open_abgp510 name="menu.open_abgp510"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt510_query()
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
               CALL abgt510_adjust(2)
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
            CALL abgt510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt510_set_pk_array()
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
 
{<section id="abgt510.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgt510_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt510.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt510_browser_fill(ps_page_action)
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
   LET l_wc = " bgeg001='20' AND ",g_wc," AND ",g_wc2
   
   #檢查預算組織是否在abgi090中可操作的組織中
   CALL s_abg2_get_budget_site('','',g_user,'03') RETURNING l_ooef001_str
   CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
   LET l_wc = l_wc," AND bgeg007 IN ",l_ooef001_str
   #抓取有权限的管理组织
   LET l_wc=l_wc," AND bgeg004 IN (SELECT DISTINCT bgai002 FROM bgai_t ",
                 "                  WHERE bgaient=",g_enterprise," AND bgaistus='Y' ",
                 "                    AND bgai003='",g_user,"'",
                 "                    AND (bgai005='00' OR bgai005='03') ",
                 "                 )"
            
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                         " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                        ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                        ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                        ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                        ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                        ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
      IF g_bgaw1[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
      END IF
      IF g_bgaw2[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
      END IF
   END IF
   CALL s_abgt510_create_head(l_wc,g_add_browse)
   #end add-point    
 
   LET l_searchcol = "bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg009,bgeg010"
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
      LET l_sub_sql = " SELECT DISTINCT bgeg001 ",
                      ", bgeg002 ",
                      ", bgeg003 ",
                      ", bgeg004 ",
                      ", bgeg005 ",
                      ", bgeg006 ",
                      ", bgeg007 ",
                      ", bgeg009 ",
                      ", bgeg010 ",
 
                      " FROM bgeg_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bgegent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgeg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgeg001 ",
                      ", bgeg002 ",
                      ", bgeg003 ",
                      ", bgeg004 ",
                      ", bgeg005 ",
                      ", bgeg006 ",
                      ", bgeg007 ",
                      ", bgeg009 ",
                      ", bgeg010 ",
 
                      " FROM bgeg_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bgegent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgeg_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #重写l_sub_sql 和 g_sql 语句，抓取资料来源改为单头临时表
   IF NOT cl_null(g_add_browse) AND g_wc = " 1=2" THEN
      LET l_wc  = g_add_browse
   END IF
   LET l_sub_sql = " SELECT DISTINCT bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg009,bgeg010 ",
                   "   FROM s_abgt510_tmp ",
                   " WHERE bgegent = ",g_enterprise
                   
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
      INITIALIZE g_bgeg_m.* TO NULL
      CALL g_bgeg_d.clear()        
      CALL g_bgeg2_d.clear() 
      CALL g_bgeg3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgeg001,t0.bgeg002,t0.bgeg003,t0.bgeg004,t0.bgeg005,t0.bgeg006,t0.bgeg007,t0.bgeg009,t0.bgeg010 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bgeg001,t0.bgeg002,t0.bgeg003,t0.bgeg004,t0.bgeg005,t0.bgeg006,t0.bgeg007, 
       t0.bgeg009,t0.bgeg010",
                " FROM bgeg_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bgegent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bgeg_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #組合條件
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                         " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                        ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                        ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                        ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                        ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                        ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
      IF g_bgaw1[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
      END IF
      IF g_bgaw2[1]='Y' THEN
         LET g_add_browse = g_add_browse," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
      END IF
      LET l_wc = g_add_browse
   ELSE
      LET l_wc = ' 1=1'
   END IF
   #重写g_sql 语句，抓取资料来源改为单头临时表
   LET g_sql  = "SELECT DISTINCT bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg009,bgeg010 ",
                " FROM s_abgt510_tmp ",
                " WHERE bgegent = " ||g_enterprise|| " AND ", l_wc
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgeg_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bgeg001,g_browser[g_cnt].b_bgeg002,g_browser[g_cnt].b_bgeg003, 
          g_browser[g_cnt].b_bgeg004,g_browser[g_cnt].b_bgeg005,g_browser[g_cnt].b_bgeg006,g_browser[g_cnt].b_bgeg007, 
          g_browser[g_cnt].b_bgeg009,g_browser[g_cnt].b_bgeg010 
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
   
   IF cl_null(g_browser[g_cnt].b_bgeg001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bgeg_m.* TO NULL
      CALL g_bgeg_d.clear()
      CALL g_bgeg2_d.clear()
      CALL g_bgeg3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgt510_fetch('')
   
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
 
{<section id="abgt510.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt510_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
 
   #end add-point
   
   LET g_bgeg_m.bgeg001 = g_browser[g_current_idx].b_bgeg001   
   LET g_bgeg_m.bgeg002 = g_browser[g_current_idx].b_bgeg002   
   LET g_bgeg_m.bgeg003 = g_browser[g_current_idx].b_bgeg003   
   LET g_bgeg_m.bgeg004 = g_browser[g_current_idx].b_bgeg004   
   LET g_bgeg_m.bgeg005 = g_browser[g_current_idx].b_bgeg005   
   LET g_bgeg_m.bgeg006 = g_browser[g_current_idx].b_bgeg006   
   LET g_bgeg_m.bgeg007 = g_browser[g_current_idx].b_bgeg007   
   LET g_bgeg_m.bgeg009 = g_browser[g_current_idx].b_bgeg009   
   LET g_bgeg_m.bgeg010 = g_browser[g_current_idx].b_bgeg010   
 
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010 INTO g_bgeg_m.bgeg002, 
       g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023, 
       g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg049, 
       g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc
   CALL abgt510_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt510_ui_detailshow()
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
 
{<section id="abgt510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt510_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgeg001 = g_bgeg_m.bgeg001 
         AND g_browser[l_i].b_bgeg002 = g_bgeg_m.bgeg002 
         AND g_browser[l_i].b_bgeg003 = g_bgeg_m.bgeg003 
         AND g_browser[l_i].b_bgeg004 = g_bgeg_m.bgeg004 
         AND g_browser[l_i].b_bgeg005 = g_bgeg_m.bgeg005 
         AND g_browser[l_i].b_bgeg006 = g_bgeg_m.bgeg006 
         AND g_browser[l_i].b_bgeg007 = g_bgeg_m.bgeg007 
         AND g_browser[l_i].b_bgeg009 = g_bgeg_m.bgeg009 
         AND g_browser[l_i].b_bgeg010 = g_bgeg_m.bgeg010 
 
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
 
{<section id="abgt510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt510_construct()
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
   INITIALIZE g_bgeg_m.* TO NULL
   CALL g_bgeg_d.clear()
   CALL g_bgeg2_d.clear()
   CALL g_bgeg3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   CALL cl_set_comp_visible("bgeg007,bgeg007_desc_t,bgeg009,bgeg013,bgeg013_desc_t,bgeg014,bgeg014_desc_t,bgeg015,bgeg015_desc_t,bgeg016,bgeg016_desc_t,bgeg017,bgeg017_desc_t,group_1",TRUE)
   CALL cl_set_comp_visible("bgeg018,bgeg018_desc_t,bgeg019,bgeg019_desc_t,bgeg022,bgeg023,bgeg023_desc_t,bgeg024,bgeg024_desc_t,bgeg012,bgeg012_desc_t,bgeg020,bgeg020_desc_t,bgeg021,bgeg021_desc_t",TRUE)
   
   CALL cl_set_comp_visible("bgeg007_desc,bgeg009_desc,bgeg013_desc,bgeg014_desc,bgeg015_desc,bgeg016_desc,bgeg017_desc",TRUE)
   CALL cl_set_comp_visible("bgeg018_desc,bgeg019_desc,bgeg022_2,bgeg023_desc,bgeg024_desc,bgeg012_desc,bgeg020_desc,bgeg021_desc",TRUE)
      
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgeg002,bgeg003,bgeg004,bgeg011,bgeg001,bgeg005,bgeg006,bgeg010,bgegstus, 
          bgeg007,bgeg013,bgeg016,bgeg019,bgeg022,bgeg009,bgeg014,bgeg017,bgeg020,bgeg023,bgeg012,bgeg015, 
          bgeg018,bgeg021,bgeg024,bgeg049
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.bgeg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg002
            #add-point:ON ACTION controlp INFIELD bgeg002 name="construct.c.bgeg002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus='Y' AND bgaa006 = '1' "
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg002  #顯示到畫面上
            NEXT FIELD bgeg002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg002
            #add-point:BEFORE FIELD bgeg002 name="construct.b.bgeg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg002
            
            #add-point:AFTER FIELD bgeg002 name="construct.a.bgeg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg003
            #add-point:BEFORE FIELD bgeg003 name="construct.b.bgeg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg003
            
            #add-point:AFTER FIELD bgeg003 name="construct.a.bgeg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg003
            #add-point:ON ACTION controlp INFIELD bgeg003 name="construct.c.bgeg003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgeg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg004
            #add-point:ON ACTION controlp INFIELD bgeg004 name="construct.c.bgeg004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='03' OR bgai005='00')" 
            CALL q_bgai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg004  #顯示到畫面上
            NEXT FIELD bgeg004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg004
            #add-point:BEFORE FIELD bgeg004 name="construct.b.bgeg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg004
            
            #add-point:AFTER FIELD bgeg004 name="construct.a.bgeg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg011
            #add-point:ON ACTION controlp INFIELD bgeg011 name="construct.c.bgeg011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgaw001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg011  #顯示到畫面上
            NEXT FIELD bgeg011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg011
            #add-point:BEFORE FIELD bgeg011 name="construct.b.bgeg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg011
            
            #add-point:AFTER FIELD bgeg011 name="construct.a.bgeg011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg001
            #add-point:BEFORE FIELD bgeg001 name="construct.b.bgeg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg001
            
            #add-point:AFTER FIELD bgeg001 name="construct.a.bgeg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg001
            #add-point:ON ACTION controlp INFIELD bgeg001 name="construct.c.bgeg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg005
            #add-point:BEFORE FIELD bgeg005 name="construct.b.bgeg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg005
            
            #add-point:AFTER FIELD bgeg005 name="construct.a.bgeg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg005
            #add-point:ON ACTION controlp INFIELD bgeg005 name="construct.c.bgeg005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg006
            #add-point:BEFORE FIELD bgeg006 name="construct.b.bgeg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg006
            
            #add-point:AFTER FIELD bgeg006 name="construct.a.bgeg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg006
            #add-point:ON ACTION controlp INFIELD bgeg006 name="construct.c.bgeg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg010
            #add-point:BEFORE FIELD bgeg010 name="construct.b.bgeg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg010
            
            #add-point:AFTER FIELD bgeg010 name="construct.a.bgeg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg010
            #add-point:ON ACTION controlp INFIELD bgeg010 name="construct.c.bgeg010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegstus
            #add-point:BEFORE FIELD bgegstus name="construct.b.bgegstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegstus
            
            #add-point:AFTER FIELD bgegstus name="construct.a.bgegstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgegstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegstus
            #add-point:ON ACTION controlp INFIELD bgegstus name="construct.c.bgegstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgeg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg007
            #add-point:ON ACTION controlp INFIELD bgeg007 name="construct.c.bgeg007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'03') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg007  #顯示到畫面上
            NEXT FIELD bgeg007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg007
            #add-point:BEFORE FIELD bgeg007 name="construct.b.bgeg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg007
            
            #add-point:AFTER FIELD bgeg007 name="construct.a.bgeg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg013
            #add-point:ON ACTION controlp INFIELD bgeg013 name="construct.c.bgeg013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg013  #顯示到畫面上
            NEXT FIELD bgeg013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg013
            #add-point:BEFORE FIELD bgeg013 name="construct.b.bgeg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg013
            
            #add-point:AFTER FIELD bgeg013 name="construct.a.bgeg013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg016
            #add-point:ON ACTION controlp INFIELD bgeg016 name="construct.c.bgeg016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg016  #顯示到畫面上
            NEXT FIELD bgeg016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg016
            #add-point:BEFORE FIELD bgeg016 name="construct.b.bgeg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg016
            
            #add-point:AFTER FIELD bgeg016 name="construct.a.bgeg016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg019
            #add-point:ON ACTION controlp INFIELD bgeg019 name="construct.c.bgeg019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg019  #顯示到畫面上
            NEXT FIELD bgeg019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg019
            #add-point:BEFORE FIELD bgeg019 name="construct.b.bgeg019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg019
            
            #add-point:AFTER FIELD bgeg019 name="construct.a.bgeg019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg022
            #add-point:BEFORE FIELD bgeg022 name="construct.b.bgeg022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg022
            
            #add-point:AFTER FIELD bgeg022 name="construct.a.bgeg022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg022
            #add-point:ON ACTION controlp INFIELD bgeg022 name="construct.c.bgeg022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgeg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg009
            #add-point:ON ACTION controlp INFIELD bgeg009 name="construct.c.bgeg009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg009  #顯示到畫面上
            NEXT FIELD bgeg009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg009
            #add-point:BEFORE FIELD bgeg009 name="construct.b.bgeg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg009
            
            #add-point:AFTER FIELD bgeg009 name="construct.a.bgeg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg014
            #add-point:ON ACTION controlp INFIELD bgeg014 name="construct.c.bgeg014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg014  #顯示到畫面上
            NEXT FIELD bgeg014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg014
            #add-point:BEFORE FIELD bgeg014 name="construct.b.bgeg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg014
            
            #add-point:AFTER FIELD bgeg014 name="construct.a.bgeg014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg017
            #add-point:ON ACTION controlp INFIELD bgeg017 name="construct.c.bgeg017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg017  #顯示到畫面上
            NEXT FIELD bgeg017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg017
            #add-point:BEFORE FIELD bgeg017 name="construct.b.bgeg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg017
            
            #add-point:AFTER FIELD bgeg017 name="construct.a.bgeg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg020
            #add-point:ON ACTION controlp INFIELD bgeg020 name="construct.c.bgeg020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg020  #顯示到畫面上
            NEXT FIELD bgeg020                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg020
            #add-point:BEFORE FIELD bgeg020 name="construct.b.bgeg020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg020
            
            #add-point:AFTER FIELD bgeg020 name="construct.a.bgeg020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg023
            #add-point:ON ACTION controlp INFIELD bgeg023 name="construct.c.bgeg023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg023  #顯示到畫面上
            NEXT FIELD bgeg023                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg023
            #add-point:BEFORE FIELD bgeg023 name="construct.b.bgeg023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg023
            
            #add-point:AFTER FIELD bgeg023 name="construct.a.bgeg023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg012
            #add-point:ON ACTION controlp INFIELD bgeg012 name="construct.c.bgeg012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg012  #顯示到畫面上
            NEXT FIELD bgeg012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg012
            #add-point:BEFORE FIELD bgeg012 name="construct.b.bgeg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg012
            
            #add-point:AFTER FIELD bgeg012 name="construct.a.bgeg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg015
            #add-point:ON ACTION controlp INFIELD bgeg015 name="construct.c.bgeg015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg015  #顯示到畫面上
            NEXT FIELD bgeg015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg015
            #add-point:BEFORE FIELD bgeg015 name="construct.b.bgeg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg015
            
            #add-point:AFTER FIELD bgeg015 name="construct.a.bgeg015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg018
            #add-point:ON ACTION controlp INFIELD bgeg018 name="construct.c.bgeg018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg018  #顯示到畫面上
            NEXT FIELD bgeg018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg018
            #add-point:BEFORE FIELD bgeg018 name="construct.b.bgeg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg018
            
            #add-point:AFTER FIELD bgeg018 name="construct.a.bgeg018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg021
            #add-point:ON ACTION controlp INFIELD bgeg021 name="construct.c.bgeg021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg021  #顯示到畫面上
            NEXT FIELD bgeg021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg021
            #add-point:BEFORE FIELD bgeg021 name="construct.b.bgeg021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg021
            
            #add-point:AFTER FIELD bgeg021 name="construct.a.bgeg021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg024
            #add-point:ON ACTION controlp INFIELD bgeg024 name="construct.c.bgeg024"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg024  #顯示到畫面上
            NEXT FIELD bgeg024                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg024
            #add-point:BEFORE FIELD bgeg024 name="construct.b.bgeg024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg024
            
            #add-point:AFTER FIELD bgeg024 name="construct.a.bgeg024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg049
            #add-point:BEFORE FIELD bgeg049 name="construct.b.bgeg049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg049
            
            #add-point:AFTER FIELD bgeg049 name="construct.a.bgeg049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeg049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg049
            #add-point:ON ACTION controlp INFIELD bgeg049 name="construct.c.bgeg049"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bgegseq,bgeg010_2,bgeg007_2,bgeg007_desc,bgeg009_2,bgeg009_desc,bgeg049, 
          bgeg012_2,bgeg012_desc,bgeg013_2,bgeg013_desc,bgeg014_2,bgeg014_desc,bgeg015_2,bgeg015_desc, 
          bgeg016_2,bgeg016_desc,bgeg017_2,bgeg017_desc,bgeg018_2,bgeg018_desc,bgeg019_2,bgeg019_desc, 
          bgeg020_2,bgeg020_desc,bgeg021_2,bgeg021_desc,bgeg022_2,bgeg023_2,bgeg023_desc,bgeg024_2,bgeg024_desc, 
          bgeg035,bgeg036,bgeg037,bgeg100,bgeg008,bgeg047,bgeg048,bgeg050,bgegownid,bgegowndp,bgegcrtid, 
          bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt
           FROM s_detail1[1].bgegseq,s_detail1[1].bgeg010_2,s_detail1[1].bgeg007_2,s_detail1[1].bgeg007_desc, 
               s_detail1[1].bgeg009_2,s_detail1[1].bgeg009_desc,s_detail1[1].bgeg049,s_detail1[1].bgeg012_2, 
               s_detail1[1].bgeg012_desc,s_detail1[1].bgeg013_2,s_detail1[1].bgeg013_desc,s_detail1[1].bgeg014_2, 
               s_detail1[1].bgeg014_desc,s_detail1[1].bgeg015_2,s_detail1[1].bgeg015_desc,s_detail1[1].bgeg016_2, 
               s_detail1[1].bgeg016_desc,s_detail1[1].bgeg017_2,s_detail1[1].bgeg017_desc,s_detail1[1].bgeg018_2, 
               s_detail1[1].bgeg018_desc,s_detail1[1].bgeg019_2,s_detail1[1].bgeg019_desc,s_detail1[1].bgeg020_2, 
               s_detail1[1].bgeg020_desc,s_detail1[1].bgeg021_2,s_detail1[1].bgeg021_desc,s_detail1[1].bgeg022_2, 
               s_detail1[1].bgeg023_2,s_detail1[1].bgeg023_desc,s_detail1[1].bgeg024_2,s_detail1[1].bgeg024_desc, 
               s_detail1[1].bgeg035,s_detail1[1].bgeg036,s_detail1[1].bgeg037,s_detail1[1].bgeg100,s_detail1[1].bgeg008, 
               s_detail1[1].bgeg047,s_detail1[1].bgeg048,s_detail1[1].bgeg050,s_detail2[1].bgegownid, 
               s_detail2[1].bgegowndp,s_detail2[1].bgegcrtid,s_detail2[1].bgegcrtdp,s_detail2[1].bgegcrtdt, 
               s_detail2[1].bgegmodid,s_detail2[1].bgegmoddt,s_detail2[1].bgegcnfid,s_detail2[1].bgegcnfdt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgegcrtdt>>----
         AFTER FIELD bgegcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgegmoddt>>----
         AFTER FIELD bgegmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgegcnfdt>>----
         AFTER FIELD bgegcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgegpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegseq
            #add-point:BEFORE FIELD bgegseq name="construct.b.page1.bgegseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegseq
            
            #add-point:AFTER FIELD bgegseq name="construct.a.page1.bgegseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgegseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegseq
            #add-point:ON ACTION controlp INFIELD bgegseq name="construct.c.page1.bgegseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg010_2
            #add-point:BEFORE FIELD bgeg010_2 name="construct.b.page1.bgeg010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg010_2
            
            #add-point:AFTER FIELD bgeg010_2 name="construct.a.page1.bgeg010_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg010_2
            #add-point:ON ACTION controlp INFIELD bgeg010_2 name="construct.c.page1.bgeg010_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgeg007_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg007_2
            #add-point:ON ACTION controlp INFIELD bgeg007_2 name="construct.c.page1.bgeg007_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg007_2  #顯示到畫面上
            NEXT FIELD bgeg007_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg007_2
            #add-point:BEFORE FIELD bgeg007_2 name="construct.b.page1.bgeg007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg007_2
            
            #add-point:AFTER FIELD bgeg007_2 name="construct.a.page1.bgeg007_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg007_desc
            #add-point:ON ACTION controlp INFIELD bgeg007_desc name="construct.c.page1.bgeg007_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'03') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg007_desc  #顯示到畫面上
            NEXT FIELD bgeg007_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg007_desc
            #add-point:BEFORE FIELD bgeg007_desc name="construct.b.page1.bgeg007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg007_desc
            
            #add-point:AFTER FIELD bgeg007_desc name="construct.a.page1.bgeg007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg009_2
            #add-point:ON ACTION controlp INFIELD bgeg009_2 name="construct.c.page1.bgeg009_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg009_2  #顯示到畫面上
            NEXT FIELD bgeg009_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg009_2
            #add-point:BEFORE FIELD bgeg009_2 name="construct.b.page1.bgeg009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg009_2
            
            #add-point:AFTER FIELD bgeg009_2 name="construct.a.page1.bgeg009_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg009_desc
            #add-point:ON ACTION controlp INFIELD bgeg009_desc name="construct.c.page1.bgeg009_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg009_desc  #顯示到畫面上
            NEXT FIELD bgeg009_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg009_desc
            #add-point:BEFORE FIELD bgeg009_desc name="construct.b.page1.bgeg009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg009_desc
            
            #add-point:AFTER FIELD bgeg009_desc name="construct.a.page1.bgeg009_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg049
            #add-point:BEFORE FIELD bgeg049 name="construct.b.page1.bgeg049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg049
            
            #add-point:AFTER FIELD bgeg049 name="construct.a.page1.bgeg049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg049
            #add-point:ON ACTION controlp INFIELD bgeg049 name="construct.c.page1.bgeg049"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgeg012_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg012_2
            #add-point:ON ACTION controlp INFIELD bgeg012_2 name="construct.c.page1.bgeg012_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg012_2  #顯示到畫面上
            NEXT FIELD bgeg012_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg012_2
            #add-point:BEFORE FIELD bgeg012_2 name="construct.b.page1.bgeg012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg012_2
            
            #add-point:AFTER FIELD bgeg012_2 name="construct.a.page1.bgeg012_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg012_desc
            #add-point:ON ACTION controlp INFIELD bgeg012_desc name="construct.c.page1.bgeg012_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg012_desc  #顯示到畫面上
            NEXT FIELD bgeg012_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg012_desc
            #add-point:BEFORE FIELD bgeg012_desc name="construct.b.page1.bgeg012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg012_desc
            
            #add-point:AFTER FIELD bgeg012_desc name="construct.a.page1.bgeg012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg013_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg013_2
            #add-point:ON ACTION controlp INFIELD bgeg013_2 name="construct.c.page1.bgeg013_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg013_2  #顯示到畫面上
            NEXT FIELD bgeg013_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg013_2
            #add-point:BEFORE FIELD bgeg013_2 name="construct.b.page1.bgeg013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg013_2
            
            #add-point:AFTER FIELD bgeg013_2 name="construct.a.page1.bgeg013_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg013_desc
            #add-point:ON ACTION controlp INFIELD bgeg013_desc name="construct.c.page1.bgeg013_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg013_desc  #顯示到畫面上
            NEXT FIELD bgeg013_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg013_desc
            #add-point:BEFORE FIELD bgeg013_desc name="construct.b.page1.bgeg013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg013_desc
            
            #add-point:AFTER FIELD bgeg013_desc name="construct.a.page1.bgeg013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg014_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg014_2
            #add-point:ON ACTION controlp INFIELD bgeg014_2 name="construct.c.page1.bgeg014_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg014_2  #顯示到畫面上
            NEXT FIELD bgeg014_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg014_2
            #add-point:BEFORE FIELD bgeg014_2 name="construct.b.page1.bgeg014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg014_2
            
            #add-point:AFTER FIELD bgeg014_2 name="construct.a.page1.bgeg014_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg014_desc
            #add-point:ON ACTION controlp INFIELD bgeg014_desc name="construct.c.page1.bgeg014_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' "
            CALL q_ooeg001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg014_desc  #顯示到畫面上
            NEXT FIELD bgeg014_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg014_desc
            #add-point:BEFORE FIELD bgeg014_desc name="construct.b.page1.bgeg014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg014_desc
            
            #add-point:AFTER FIELD bgeg014_desc name="construct.a.page1.bgeg014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg015_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg015_2
            #add-point:ON ACTION controlp INFIELD bgeg015_2 name="construct.c.page1.bgeg015_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg015_2  #顯示到畫面上
            NEXT FIELD bgeg015_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg015_2
            #add-point:BEFORE FIELD bgeg015_2 name="construct.b.page1.bgeg015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg015_2
            
            #add-point:AFTER FIELD bgeg015_2 name="construct.a.page1.bgeg015_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg015_desc
            #add-point:ON ACTION controlp INFIELD bgeg015_desc name="construct.c.page1.bgeg015_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg015_desc  #顯示到畫面上
            NEXT FIELD bgeg015_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg015_desc
            #add-point:BEFORE FIELD bgeg015_desc name="construct.b.page1.bgeg015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg015_desc
            
            #add-point:AFTER FIELD bgeg015_desc name="construct.a.page1.bgeg015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg016_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg016_2
            #add-point:ON ACTION controlp INFIELD bgeg016_2 name="construct.c.page1.bgeg016_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg016_2  #顯示到畫面上
            NEXT FIELD bgeg016_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg016_2
            #add-point:BEFORE FIELD bgeg016_2 name="construct.b.page1.bgeg016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg016_2
            
            #add-point:AFTER FIELD bgeg016_2 name="construct.a.page1.bgeg016_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg016_desc
            #add-point:ON ACTION controlp INFIELD bgeg016_desc name="construct.c.page1.bgeg016_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg016_desc  #顯示到畫面上
            NEXT FIELD bgeg016_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg016_desc
            #add-point:BEFORE FIELD bgeg016_desc name="construct.b.page1.bgeg016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg016_desc
            
            #add-point:AFTER FIELD bgeg016_desc name="construct.a.page1.bgeg016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg017_2
            #add-point:ON ACTION controlp INFIELD bgeg017_2 name="construct.c.page1.bgeg017_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg017_2  #顯示到畫面上
            NEXT FIELD bgeg017_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg017_2
            #add-point:BEFORE FIELD bgeg017_2 name="construct.b.page1.bgeg017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg017_2
            
            #add-point:AFTER FIELD bgeg017_2 name="construct.a.page1.bgeg017_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg017_desc
            #add-point:ON ACTION controlp INFIELD bgeg017_desc name="construct.c.page1.bgeg017_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg017_desc  #顯示到畫面上
            NEXT FIELD bgeg017_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg017_desc
            #add-point:BEFORE FIELD bgeg017_desc name="construct.b.page1.bgeg017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg017_desc
            
            #add-point:AFTER FIELD bgeg017_desc name="construct.a.page1.bgeg017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg018_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg018_2
            #add-point:ON ACTION controlp INFIELD bgeg018_2 name="construct.c.page1.bgeg018_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg018_2  #顯示到畫面上
            NEXT FIELD bgeg018_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg018_2
            #add-point:BEFORE FIELD bgeg018_2 name="construct.b.page1.bgeg018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg018_2
            
            #add-point:AFTER FIELD bgeg018_2 name="construct.a.page1.bgeg018_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg018_desc
            #add-point:ON ACTION controlp INFIELD bgeg018_desc name="construct.c.page1.bgeg018_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg018_desc  #顯示到畫面上
            NEXT FIELD bgeg018_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg018_desc
            #add-point:BEFORE FIELD bgeg018_desc name="construct.b.page1.bgeg018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg018_desc
            
            #add-point:AFTER FIELD bgeg018_desc name="construct.a.page1.bgeg018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg019_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg019_2
            #add-point:ON ACTION controlp INFIELD bgeg019_2 name="construct.c.page1.bgeg019_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg019_2  #顯示到畫面上
            NEXT FIELD bgeg019_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg019_2
            #add-point:BEFORE FIELD bgeg019_2 name="construct.b.page1.bgeg019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg019_2
            
            #add-point:AFTER FIELD bgeg019_2 name="construct.a.page1.bgeg019_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg019_desc
            #add-point:ON ACTION controlp INFIELD bgeg019_desc name="construct.c.page1.bgeg019_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg019_desc  #顯示到畫面上
            NEXT FIELD bgeg019_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg019_desc
            #add-point:BEFORE FIELD bgeg019_desc name="construct.b.page1.bgeg019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg019_desc
            
            #add-point:AFTER FIELD bgeg019_desc name="construct.a.page1.bgeg019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg020_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg020_2
            #add-point:ON ACTION controlp INFIELD bgeg020_2 name="construct.c.page1.bgeg020_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg020_2  #顯示到畫面上
            NEXT FIELD bgeg020_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg020_2
            #add-point:BEFORE FIELD bgeg020_2 name="construct.b.page1.bgeg020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg020_2
            
            #add-point:AFTER FIELD bgeg020_2 name="construct.a.page1.bgeg020_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg020_desc
            #add-point:ON ACTION controlp INFIELD bgeg020_desc name="construct.c.page1.bgeg020_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg020_desc  #顯示到畫面上
            NEXT FIELD bgeg020_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg020_desc
            #add-point:BEFORE FIELD bgeg020_desc name="construct.b.page1.bgeg020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg020_desc
            
            #add-point:AFTER FIELD bgeg020_desc name="construct.a.page1.bgeg020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg021_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg021_2
            #add-point:ON ACTION controlp INFIELD bgeg021_2 name="construct.c.page1.bgeg021_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg021_2  #顯示到畫面上
            NEXT FIELD bgeg021_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg021_2
            #add-point:BEFORE FIELD bgeg021_2 name="construct.b.page1.bgeg021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg021_2
            
            #add-point:AFTER FIELD bgeg021_2 name="construct.a.page1.bgeg021_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg021_desc
            #add-point:ON ACTION controlp INFIELD bgeg021_desc name="construct.c.page1.bgeg021_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg021_desc  #顯示到畫面上
            NEXT FIELD bgeg021_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg021_desc
            #add-point:BEFORE FIELD bgeg021_desc name="construct.b.page1.bgeg021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg021_desc
            
            #add-point:AFTER FIELD bgeg021_desc name="construct.a.page1.bgeg021_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg022_2
            #add-point:BEFORE FIELD bgeg022_2 name="construct.b.page1.bgeg022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg022_2
            
            #add-point:AFTER FIELD bgeg022_2 name="construct.a.page1.bgeg022_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg022_2
            #add-point:ON ACTION controlp INFIELD bgeg022_2 name="construct.c.page1.bgeg022_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgeg023_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg023_2
            #add-point:ON ACTION controlp INFIELD bgeg023_2 name="construct.c.page1.bgeg023_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg023_2  #顯示到畫面上
            NEXT FIELD bgeg023_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg023_2
            #add-point:BEFORE FIELD bgeg023_2 name="construct.b.page1.bgeg023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg023_2
            
            #add-point:AFTER FIELD bgeg023_2 name="construct.a.page1.bgeg023_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg023_desc
            #add-point:ON ACTION controlp INFIELD bgeg023_desc name="construct.c.page1.bgeg023_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg023_desc  #顯示到畫面上
            NEXT FIELD bgeg023_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg023_desc
            #add-point:BEFORE FIELD bgeg023_desc name="construct.b.page1.bgeg023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg023_desc
            
            #add-point:AFTER FIELD bgeg023_desc name="construct.a.page1.bgeg023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg024_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg024_2
            #add-point:ON ACTION controlp INFIELD bgeg024_2 name="construct.c.page1.bgeg024_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg024_2  #顯示到畫面上
            NEXT FIELD bgeg024_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg024_2
            #add-point:BEFORE FIELD bgeg024_2 name="construct.b.page1.bgeg024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg024_2
            
            #add-point:AFTER FIELD bgeg024_2 name="construct.a.page1.bgeg024_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg024_desc
            #add-point:ON ACTION controlp INFIELD bgeg024_desc name="construct.c.page1.bgeg024_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg024_desc  #顯示到畫面上
            NEXT FIELD bgeg024_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg024_desc
            #add-point:BEFORE FIELD bgeg024_desc name="construct.b.page1.bgeg024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg024_desc
            
            #add-point:AFTER FIELD bgeg024_desc name="construct.a.page1.bgeg024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg035
            #add-point:ON ACTION controlp INFIELD bgeg035 name="construct.c.page1.bgeg035"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg035  #顯示到畫面上
            NEXT FIELD bgeg035                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg035
            #add-point:BEFORE FIELD bgeg035 name="construct.b.page1.bgeg035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg035
            
            #add-point:AFTER FIELD bgeg035 name="construct.a.page1.bgeg035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg036
            #add-point:BEFORE FIELD bgeg036 name="construct.b.page1.bgeg036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg036
            
            #add-point:AFTER FIELD bgeg036 name="construct.a.page1.bgeg036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg036
            #add-point:ON ACTION controlp INFIELD bgeg036 name="construct.c.page1.bgeg036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgeg037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg037
            #add-point:ON ACTION controlp INFIELD bgeg037 name="construct.c.page1.bgeg037"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg037  #顯示到畫面上
            NEXT FIELD bgeg037                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg037
            #add-point:BEFORE FIELD bgeg037 name="construct.b.page1.bgeg037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg037
            
            #add-point:AFTER FIELD bgeg037 name="construct.a.page1.bgeg037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg100
            #add-point:ON ACTION controlp INFIELD bgeg100 name="construct.c.page1.bgeg100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeg100  #顯示到畫面上
            NEXT FIELD bgeg100                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg100
            #add-point:BEFORE FIELD bgeg100 name="construct.b.page1.bgeg100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg100
            
            #add-point:AFTER FIELD bgeg100 name="construct.a.page1.bgeg100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg008
            #add-point:BEFORE FIELD bgeg008 name="construct.b.page1.bgeg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg008
            
            #add-point:AFTER FIELD bgeg008 name="construct.a.page1.bgeg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg008
            #add-point:ON ACTION controlp INFIELD bgeg008 name="construct.c.page1.bgeg008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg047
            #add-point:BEFORE FIELD bgeg047 name="construct.b.page1.bgeg047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg047
            
            #add-point:AFTER FIELD bgeg047 name="construct.a.page1.bgeg047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg047
            #add-point:ON ACTION controlp INFIELD bgeg047 name="construct.c.page1.bgeg047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg048
            #add-point:BEFORE FIELD bgeg048 name="construct.b.page1.bgeg048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg048
            
            #add-point:AFTER FIELD bgeg048 name="construct.a.page1.bgeg048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg048
            #add-point:ON ACTION controlp INFIELD bgeg048 name="construct.c.page1.bgeg048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg050
            #add-point:BEFORE FIELD bgeg050 name="construct.b.page1.bgeg050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg050
            
            #add-point:AFTER FIELD bgeg050 name="construct.a.page1.bgeg050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeg050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg050
            #add-point:ON ACTION controlp INFIELD bgeg050 name="construct.c.page1.bgeg050"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgegownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegownid
            #add-point:ON ACTION controlp INFIELD bgegownid name="construct.c.page2.bgegownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgegownid  #顯示到畫面上
            NEXT FIELD bgegownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegownid
            #add-point:BEFORE FIELD bgegownid name="construct.b.page2.bgegownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegownid
            
            #add-point:AFTER FIELD bgegownid name="construct.a.page2.bgegownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgegowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegowndp
            #add-point:ON ACTION controlp INFIELD bgegowndp name="construct.c.page2.bgegowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgegowndp  #顯示到畫面上
            NEXT FIELD bgegowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegowndp
            #add-point:BEFORE FIELD bgegowndp name="construct.b.page2.bgegowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegowndp
            
            #add-point:AFTER FIELD bgegowndp name="construct.a.page2.bgegowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgegcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegcrtid
            #add-point:ON ACTION controlp INFIELD bgegcrtid name="construct.c.page2.bgegcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgegcrtid  #顯示到畫面上
            NEXT FIELD bgegcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegcrtid
            #add-point:BEFORE FIELD bgegcrtid name="construct.b.page2.bgegcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegcrtid
            
            #add-point:AFTER FIELD bgegcrtid name="construct.a.page2.bgegcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgegcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegcrtdp
            #add-point:ON ACTION controlp INFIELD bgegcrtdp name="construct.c.page2.bgegcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgegcrtdp  #顯示到畫面上
            NEXT FIELD bgegcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegcrtdp
            #add-point:BEFORE FIELD bgegcrtdp name="construct.b.page2.bgegcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegcrtdp
            
            #add-point:AFTER FIELD bgegcrtdp name="construct.a.page2.bgegcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegcrtdt
            #add-point:BEFORE FIELD bgegcrtdt name="construct.b.page2.bgegcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgegmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegmodid
            #add-point:ON ACTION controlp INFIELD bgegmodid name="construct.c.page2.bgegmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgegmodid  #顯示到畫面上
            NEXT FIELD bgegmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegmodid
            #add-point:BEFORE FIELD bgegmodid name="construct.b.page2.bgegmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegmodid
            
            #add-point:AFTER FIELD bgegmodid name="construct.a.page2.bgegmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegmoddt
            #add-point:BEFORE FIELD bgegmoddt name="construct.b.page2.bgegmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgegcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegcnfid
            #add-point:ON ACTION controlp INFIELD bgegcnfid name="construct.c.page2.bgegcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgegcnfid  #顯示到畫面上
            NEXT FIELD bgegcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegcnfid
            #add-point:BEFORE FIELD bgegcnfid name="construct.b.page2.bgegcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegcnfid
            
            #add-point:AFTER FIELD bgegcnfid name="construct.a.page2.bgegcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegcnfdt
            #add-point:BEFORE FIELD bgegcnfdt name="construct.b.page2.bgegcnfdt"
            
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
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"bgeg022_2","bgeg022")
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
 
{<section id="abgt510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt510_query()
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
   CALL g_bgeg_d.clear()
   CALL g_bgeg2_d.clear()
   CALL g_bgeg3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgt510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt510_browser_fill(g_wc)
      CALL abgt510_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgt510_browser_fill("F")
   
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
      CALL abgt510_fetch("F") 
   END IF
   
   CALL abgt510_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt510_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_bgeg010_str       STRING
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
   
   #CALL abgt510_browser_fill(p_flag)
   
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
   
   LET g_bgeg_m.bgeg001 = g_browser[g_current_idx].b_bgeg001
   LET g_bgeg_m.bgeg002 = g_browser[g_current_idx].b_bgeg002
   LET g_bgeg_m.bgeg003 = g_browser[g_current_idx].b_bgeg003
   LET g_bgeg_m.bgeg004 = g_browser[g_current_idx].b_bgeg004
   LET g_bgeg_m.bgeg005 = g_browser[g_current_idx].b_bgeg005
   LET g_bgeg_m.bgeg006 = g_browser[g_current_idx].b_bgeg006
   LET g_bgeg_m.bgeg007 = g_browser[g_current_idx].b_bgeg007
   LET g_bgeg_m.bgeg009 = g_browser[g_current_idx].b_bgeg009
   LET g_bgeg_m.bgeg010 = g_browser[g_current_idx].b_bgeg010
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010 INTO g_bgeg_m.bgeg002, 
       g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023, 
       g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg049, 
       g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bgeg_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgeg_m_mask_o.* =  g_bgeg_m.*
   CALL abgt510_bgeg_t_mask()
   LET g_bgeg_m_mask_n.* =  g_bgeg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt510_set_act_visible()
   CALL abgt510_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   #重新抓取樣式
   CALL s_abg2_get_bgaw(g_bgeg_m.bgeg011) RETURNING g_bgaw1,g_bgaw2
   #重写单头锁资料sql
   LET g_forupd_sql = " SELECT bgeg002,'',bgeg003,bgeg004,'','','',bgeg011,bgeg001,bgeg005,bgeg006,bgegstus, 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','',''", 
                      " FROM bgeg_t",
                      " WHERE bgegent= ? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND  
                          bgeg005=? AND bgeg006=? "
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET g_forupd_sql = g_forupd_sql," AND bgeg007=? "
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET g_forupd_sql = g_forupd_sql," AND bgeg009=? "
   END IF
   
   #将单头核算项组成的组合码转换成查询条件
   LET l_bgeg010_str=g_bgeg_m.bgeg010
   IF cl_null(l_bgeg010_str) THEN
      LET l_bgeg010_str = " 1=1 "
   ELSE
      LET l_bgeg010_str=cl_replace_str(l_bgeg010_str,"=","='")
      LET l_bgeg010_str=cl_replace_str(l_bgeg010_str,"/","' AND ")
      LET l_bgeg010_str=l_bgeg010_str,"' "
   END IF
   LET g_forupd_sql = g_forupd_sql," AND ",l_bgeg010_str
   
   LET g_forupd_sql = g_forupd_sql," FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt510_hcl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   #end add-point
 
   #保存單頭舊值
   LET g_bgeg_m_t.* = g_bgeg_m.*
   LET g_bgeg_m_o.* = g_bgeg_m.*
   
   #重新顯示   
   CALL abgt510_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt510.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt510_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bgeg_d.clear()
   CALL g_bgeg2_d.clear()
   CALL g_bgeg3_d.clear()
 
 
   INITIALIZE g_bgeg_m.* TO NULL             #DEFAULT 設定
   LET g_bgeg001_t = NULL
   LET g_bgeg002_t = NULL
   LET g_bgeg003_t = NULL
   LET g_bgeg004_t = NULL
   LET g_bgeg005_t = NULL
   LET g_bgeg006_t = NULL
   LET g_bgeg007_t = NULL
   LET g_bgeg009_t = NULL
   LET g_bgeg010_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_bgeg_m.bgeg001 = "20"
      LET g_bgeg_m.bgeg005 = "1"
      LET g_bgeg_m.bgeg006 = "1"
      LET g_bgeg_m.bgegstus = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_bgeg_m_t.* = g_bgeg_m.*
      CALL cl_set_comp_visible("bgeg007,bgeg007_desc_t,bgeg009,bgeg013,bgeg013_desc_t,bgeg014,bgeg014_desc_t,bgeg015,bgeg015_desc_t,bgeg016,bgeg016_desc_t,bgeg017,bgeg017_desc_t,",TRUE)
      CALL cl_set_comp_visible("bgeg018,bgeg018_desc_t,bgeg019,bgeg019_desc_t,bgeg022,bgeg023,bgeg023_desc_t,bgeg024,bgeg024_desc_t,bgeg012,bgeg012_desc_t,bgeg020,bgeg020_desc_tbgeg021,bgeg021_desc_t,group_1",TRUE)
      CASE g_bgeg_m.bgegstus 
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
 
      CALL abgt510_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
 
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bgeg_m.* TO NULL
         INITIALIZE g_bgeg_d TO NULL
         INITIALIZE g_bgeg2_d TO NULL
         INITIALIZE g_bgeg3_d TO NULL
 
         CALL abgt510_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgeg_m.* = g_bgeg_m_t.*
         CALL abgt510_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bgeg_d.clear()
      #CALL g_bgeg2_d.clear()
      #CALL g_bgeg3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt510_set_act_visible()
   CALL abgt510_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
   LET g_bgeg010_t = g_bgeg_m.bgeg010
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                      " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                      ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                      ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                      ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                      ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                      ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
                      ," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
                      ," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
                      ," AND bgeg010 = '", g_bgeg_m.bgeg010, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgt510_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010 INTO g_bgeg_m.bgeg002, 
       g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023, 
       g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg049, 
       g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc
   
   #遮罩相關處理
   LET g_bgeg_m_mask_o.* =  g_bgeg_m.*
   CALL abgt510_bgeg_t_mask()
   LET g_bgeg_m_mask_n.* =  g_bgeg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgeg_m.bgeg002,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg004_desc, 
       g_bgeg_m.bgaa002,g_bgeg_m.bgaa003,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg007_desc_t,g_bgeg_m.bgeg013, 
       g_bgeg_m.bgeg013_desc_t,g_bgeg_m.bgeg016,g_bgeg_m.bgeg016_desc_t,g_bgeg_m.bgeg019,g_bgeg_m.bgeg019_desc_t, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg014_desc_t,g_bgeg_m.bgeg017,g_bgeg_m.bgeg017_desc_t, 
       g_bgeg_m.bgeg020,g_bgeg_m.bgeg020_desc_t,g_bgeg_m.bgeg023,g_bgeg_m.bgeg023_desc_t,g_bgeg_m.bgeg012, 
       g_bgeg_m.bgeg012_desc_t,g_bgeg_m.bgeg015,g_bgeg_m.bgeg015_desc_t,g_bgeg_m.bgeg018,g_bgeg_m.bgeg018_desc_t, 
       g_bgeg_m.bgeg021,g_bgeg_m.bgeg021_desc_t,g_bgeg_m.bgeg024,g_bgeg_m.bgeg024_desc_t,g_bgeg_m.bgeg049 
 
   
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt510_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #由于主键位置不确定在单头或单身，锁资料SQL不同，需重写
   CALL abgt510_modify_1()
   RETURN
   #end add-point
   
   IF g_bgeg_m.bgeg001 IS NULL
   OR g_bgeg_m.bgeg002 IS NULL
   OR g_bgeg_m.bgeg003 IS NULL
   OR g_bgeg_m.bgeg004 IS NULL
   OR g_bgeg_m.bgeg005 IS NULL
   OR g_bgeg_m.bgeg006 IS NULL
   OR g_bgeg_m.bgeg007 IS NULL
   OR g_bgeg_m.bgeg009 IS NULL
   OR g_bgeg_m.bgeg010 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
   LET g_bgeg010_t = g_bgeg_m.bgeg010
 
   CALL s_transaction_begin()
   
   OPEN abgt510_cl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt510_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010 INTO g_bgeg_m.bgeg002, 
       g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023, 
       g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg049, 
       g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc
   
   #遮罩相關處理
   LET g_bgeg_m_mask_o.* =  g_bgeg_m.*
   CALL abgt510_bgeg_t_mask()
   LET g_bgeg_m_mask_n.* =  g_bgeg_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt510_show()
   WHILE TRUE
      LET g_bgeg001_t = g_bgeg_m.bgeg001
      LET g_bgeg002_t = g_bgeg_m.bgeg002
      LET g_bgeg003_t = g_bgeg_m.bgeg003
      LET g_bgeg004_t = g_bgeg_m.bgeg004
      LET g_bgeg005_t = g_bgeg_m.bgeg005
      LET g_bgeg006_t = g_bgeg_m.bgeg006
      LET g_bgeg007_t = g_bgeg_m.bgeg007
      LET g_bgeg009_t = g_bgeg_m.bgeg009
      LET g_bgeg010_t = g_bgeg_m.bgeg010
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgt510_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgeg_m.* = g_bgeg_m_t.*
         CALL abgt510_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgeg_m.bgeg001 != g_bgeg001_t 
      OR g_bgeg_m.bgeg002 != g_bgeg002_t 
      OR g_bgeg_m.bgeg003 != g_bgeg003_t 
      OR g_bgeg_m.bgeg004 != g_bgeg004_t 
      OR g_bgeg_m.bgeg005 != g_bgeg005_t 
      OR g_bgeg_m.bgeg006 != g_bgeg006_t 
      OR g_bgeg_m.bgeg007 != g_bgeg007_t 
      OR g_bgeg_m.bgeg009 != g_bgeg009_t 
      OR g_bgeg_m.bgeg010 != g_bgeg010_t 
 
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
   CALL abgt510_set_act_visible()
   CALL abgt510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                      " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                      ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                      ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                      ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                      ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                      ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
                      ," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
                      ," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
                      ," AND bgeg010 = '", g_bgeg_m.bgeg010, "' "
 
   #填到對應位置
   CALL abgt510_browser_fill("")
 
   CALL abgt510_idx_chk()
 
   CLOSE abgt510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt510.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt510_input(p_cmd)
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
   DEFINE l_bgeg007              LIKE bgeg_t.bgeg007
   DEFINE l_bgeg009              LIKE bgeg_t.bgeg009
   DEFINE l_ooef019              LIKE ooef_t.ooef019
   DEFINE l_ooef001              LIKE ooef_t.ooef001
   DEFINE l_ooed005              LIKE ooed_t.ooed005
   DEFINE l_bgea018              LIKE bgea_t.bgea018
   DEFINE l_bgea016              LIKE bgea_t.bgea016
   DEFINE l_bgea017              LIKE bgea_t.bgea017
   DEFINE l_bgea019              LIKE bgea_t.bgea019
   DEFINE l_bgea005              LIKE bgea_t.bgea005
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
   DISPLAY BY NAME g_bgeg_m.bgeg002,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg004_desc, 
       g_bgeg_m.bgaa002,g_bgeg_m.bgaa003,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg007_desc_t,g_bgeg_m.bgeg013, 
       g_bgeg_m.bgeg013_desc_t,g_bgeg_m.bgeg016,g_bgeg_m.bgeg016_desc_t,g_bgeg_m.bgeg019,g_bgeg_m.bgeg019_desc_t, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg014_desc_t,g_bgeg_m.bgeg017,g_bgeg_m.bgeg017_desc_t, 
       g_bgeg_m.bgeg020,g_bgeg_m.bgeg020_desc_t,g_bgeg_m.bgeg023,g_bgeg_m.bgeg023_desc_t,g_bgeg_m.bgeg012, 
       g_bgeg_m.bgeg012_desc_t,g_bgeg_m.bgeg015,g_bgeg_m.bgeg015_desc_t,g_bgeg_m.bgeg018,g_bgeg_m.bgeg018_desc_t, 
       g_bgeg_m.bgeg021,g_bgeg_m.bgeg021_desc_t,g_bgeg_m.bgeg024,g_bgeg_m.bgeg024_desc_t,g_bgeg_m.bgeg049 
 
   
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
   LET g_forupd_sql = "SELECT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015, 
       bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, 
       bgeg100,bgeg008,bgeg047,bgeg048,bgeg050,bgegseq,bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt, 
       bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq FROM bgeg_t WHERE bgegent=? AND bgeg001=? AND  
       bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=? AND bgeg007=? AND bgeg009=?  
       AND bgeg010=? AND bgeg008=? AND bgegseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   #重写单身锁资料sql
   #161220-00036#1--mod--str--
#   LET g_forupd_sql = "SELECT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015, 
#       bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, 
#       bgeg100,bgeg101,0,bgeg047,bgeg048,bgeg050,bgegseq,bgegownid,bgegowndp, 
#       bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq FROM bgeg_t WHERE  
#       bgegent=? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=?  
#       AND bgeg007=? AND bgeg009=? AND bgeg010=? AND bgegseq=? FOR UPDATE"
   LET g_forupd_sql = "SELECT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015,", 
       "bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, ",
       "bgeg100,0,bgeg047,bgeg048,bgeg050,bgegseq,bgegownid,bgegowndp, ",
       "bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq ",
       "  FROM bgeg_t ",
       " WHERE bgegent=? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=?",  
       "   AND bgeg007=? AND bgeg009=? AND bgeg010=? AND bgegseq=? FOR UPDATE"
   #161220-00036#1--mod--end
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt510_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt510_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013, 
       g_bgeg_m.bgeg016,g_bgeg_m.bgeg019,g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017, 
       g_bgeg_m.bgeg020,g_bgeg_m.bgeg023,g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021, 
       g_bgeg_m.bgeg024,g_bgeg_m.bgeg049
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   CALL cl_set_combo_scc_part('bgeg005','8958','1')
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt510.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001, 
          g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013, 
          g_bgeg_m.bgeg016,g_bgeg_m.bgeg019,g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017, 
          g_bgeg_m.bgeg020,g_bgeg_m.bgeg023,g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021, 
          g_bgeg_m.bgeg024,g_bgeg_m.bgeg049 
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
               CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_m.bgeg007,g_bgeg_m.bgeg049)
            END IF
            #新增时从预算编号开始录入
            IF p_cmd ='a' THEN
               NEXT FIELD bgeg002
            END IF
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg002
            
            #add-point:AFTER FIELD bgeg002 name="input.a.bgeg002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg002
            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg002_desc

            IF NOT cl_null(g_bgeg_m.bgeg002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg002 != g_bgeg002_t)) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgeg_m.bgeg002
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"

                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_bgaa001") THEN
                     #预算编号需是使用预测的（bgaa006=1.使用）
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_bgeg_m.bgeg002
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_bgeg_m.bgeg002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeg_m.bgeg002 = g_bgeg_m_t.bgeg002
                        CALL s_desc_get_budget_desc(g_bgeg_m.bgeg002) RETURNING g_bgeg_m.bgeg002_desc
                        DISPLAY BY NAME g_bgeg_m.bgeg002_desc
                        NEXT FIELD CURRENT
                     END IF
                     #预算编号+管理组织 检核
                     IF NOT cl_null(g_bgeg_m.bgeg004) THEN
                        CALL s_abg2_bgai002_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,'03')
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bgeg_m.bgeg002," + ",g_bgeg_m.bgeg004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_m.bgeg002 = g_bgeg_m_t.bgeg002
                           CALL s_desc_get_budget_desc(g_bgeg_m.bgeg002) RETURNING g_bgeg_m.bgeg002_desc
                           DISPLAY BY NAME g_bgeg_m.bgeg002_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bgeg_m.bgeg002 = g_bgeg_m_t.bgeg002
                     CALL s_desc_get_budget_desc(g_bgeg_m.bgeg002) RETURNING g_bgeg_m.bgeg002_desc
                     DISPLAY BY NAME g_bgeg_m.bgeg002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #抓取預算樣表
                  IF NOT cl_null(g_bgeg_m.bgeg004) THEN
                     SELECT DISTINCT bgai008 INTO g_bgeg_m.bgeg011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bgeg_m.bgeg002 AND bgai002=g_bgeg_m.bgeg004
                     CALL s_abg2_get_bgaw(g_bgeg_m.bgeg011) RETURNING g_bgaw1,g_bgaw2
                     #设置核算项显示位置
                     CALL abgt510_set_hsx_visible()
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
                     AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                        OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                   g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgeg_m.bgeg002
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_m.bgeg002 = g_bgeg_m_t.bgeg002
                           CALL s_desc_get_budget_desc(g_bgeg_m.bgeg002) RETURNING g_bgeg_m.bgeg002_desc
                           DISPLAY BY NAME g_bgeg_m.bgeg002_desc
                           #重新抓取樣式
                           SELECT DISTINCT bgai008 INTO g_bgeg_m.bgeg011 FROM bgai_t
                            WHERE bgaient=g_enterprise AND bgai001=g_bgeg_m.bgeg002 AND bgai002=g_bgeg_m.bgeg004
                           CALL s_abg2_get_bgaw(g_bgeg_m.bgeg011) RETURNING g_bgaw1,g_bgaw2
                           #设置核算项显示位置
                           CALL abgt510_set_hsx_visible()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #抓取預算週期和預算期別
                  CALL s_abgt340_sel_bgaa(g_bgeg_m.bgeg002) RETURNING g_bgeg_m.bgaa002,g_bgeg_m.bgaa003,g_max_period
                  DISPLAY BY NAME g_bgeg_m.bgaa002,g_bgeg_m.bgaa003
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
         BEFORE FIELD bgeg002
            #add-point:BEFORE FIELD bgeg002 name="input.b.bgeg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg002
            #add-point:ON CHANGE bgeg002 name="input.g.bgeg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg003
            #add-point:BEFORE FIELD bgeg003 name="input.b.bgeg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg003
            
            #add-point:AFTER FIELD bgeg003 name="input.a.bgeg003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) AND NOT cl_null(g_bgeg_m.bgeg007) AND NOT cl_null(g_bgeg_m.bgeg009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t  OR g_bgeg_m.bgeg007 != g_bgeg007_t  OR g_bgeg_m.bgeg009 != g_bgeg009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgeg_t WHERE "||"bgegent = " ||g_enterprise|| " AND "||"bgeg001 = '"||g_bgeg_m.bgeg001 ||"' AND "|| "bgeg002 = '"||g_bgeg_m.bgeg002 ||"' AND "|| "bgeg003 = '"||g_bgeg_m.bgeg003 ||"' AND "|| "bgeg004 = '"||g_bgeg_m.bgeg004 ||"' AND "|| "bgeg005 = '"||g_bgeg_m.bgeg005 ||"' AND "|| "bgeg006 = '"||g_bgeg_m.bgeg006 ||"' AND "|| "bgeg007 = '"||g_bgeg_m.bgeg007 ||"' AND "|| "bgeg009 = '"||g_bgeg_m.bgeg009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            IF NOT cl_null(g_bgeg_m.bgeg003) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg003 != g_bgeg003_t)) THEN
                  #確認欄位值在特定區間內
                  IF NOT cl_ap_chk_range(g_bgeg_m.bgeg003,"0","0","","","azz-00079",1) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #主鍵檢查
            IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
               AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t)  
                                  )
               ) THEN 
                  CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                              g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgeg_m.bgeg003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg003 = g_bgeg_m_t.bgeg003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg003
            #add-point:ON CHANGE bgeg003 name="input.g.bgeg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg004
            
            #add-point:AFTER FIELD bgeg004 name="input.a.bgeg004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg002
            LET g_ref_fields[2] = g_bgeg_m.bgeg004
            CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg004_desc

            IF NOT cl_null(g_bgeg_m.bgeg004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg004 != g_bgeg004_t)) THEN
                  CALL s_abg2_bgai002_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,'03')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_m.bgeg004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg004 = g_bgeg_m_t.bgeg004
                     CALL s_desc_get_bgai002_desc(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004) RETURNING g_bgeg_m.bgeg004_desc
                     DISPLAY BY NAME g_bgeg_m.bgeg004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #抓取預算樣表
                  IF NOT cl_null(g_bgeg_m.bgeg002) THEN
                     SELECT DISTINCT bgai008 INTO g_bgeg_m.bgeg011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bgeg_m.bgeg002 AND bgai002=g_bgeg_m.bgeg004
                     CALL s_abg2_get_bgaw(g_bgeg_m.bgeg011) RETURNING g_bgaw1,g_bgaw2
                     #设置核算项显示位置
                     CALL abgt510_set_hsx_visible()
                  END IF
                  #主鍵檢查
                  IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
                     AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                        OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                   g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgeg_m.bgeg004
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_m.bgeg004 = g_bgeg_m_t.bgeg004
                           CALL s_desc_get_bgai002_desc(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004) RETURNING g_bgeg_m.bgeg004_desc
                           DISPLAY BY NAME g_bgeg_m.bgeg004_desc
                           #重新抓取樣式
                           SELECT DISTINCT bgai008 INTO g_bgeg_m.bgeg011 FROM bgai_t
                            WHERE bgaient=g_enterprise AND bgai001=g_bgeg_m.bgeg002 AND bgai002=g_bgeg_m.bgeg004
                           CALL s_abg2_get_bgaw(g_bgeg_m.bgeg011) RETURNING g_bgaw1,g_bgaw2
                           #设置核算项显示位置
                           CALL abgt510_set_hsx_visible()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg004
            #add-point:BEFORE FIELD bgeg004 name="input.b.bgeg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg004
            #add-point:ON CHANGE bgeg004 name="input.g.bgeg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg011
            #add-point:BEFORE FIELD bgeg011 name="input.b.bgeg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg011
            
            #add-point:AFTER FIELD bgeg011 name="input.a.bgeg011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg011
            #add-point:ON CHANGE bgeg011 name="input.g.bgeg011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg001
            #add-point:BEFORE FIELD bgeg001 name="input.b.bgeg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg001
            
            #add-point:AFTER FIELD bgeg001 name="input.a.bgeg001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) AND NOT cl_null(g_bgeg_m.bgeg007) AND NOT cl_null(g_bgeg_m.bgeg009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t  OR g_bgeg_m.bgeg007 != g_bgeg007_t  OR g_bgeg_m.bgeg009 != g_bgeg009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgeg_t WHERE "||"bgegent = " ||g_enterprise|| " AND "||"bgeg001 = '"||g_bgeg_m.bgeg001 ||"' AND "|| "bgeg002 = '"||g_bgeg_m.bgeg002 ||"' AND "|| "bgeg003 = '"||g_bgeg_m.bgeg003 ||"' AND "|| "bgeg004 = '"||g_bgeg_m.bgeg004 ||"' AND "|| "bgeg005 = '"||g_bgeg_m.bgeg005 ||"' AND "|| "bgeg006 = '"||g_bgeg_m.bgeg006 ||"' AND "|| "bgeg007 = '"||g_bgeg_m.bgeg007 ||"' AND "|| "bgeg009 = '"||g_bgeg_m.bgeg009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg001
            #add-point:ON CHANGE bgeg001 name="input.g.bgeg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg005
            #add-point:BEFORE FIELD bgeg005 name="input.b.bgeg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg005
            
            #add-point:AFTER FIELD bgeg005 name="input.a.bgeg005"
            #主鍵檢查
            IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
               AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t) 
                                  )
               ) THEN 
                  CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                             g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgeg_m.bgeg005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg005 = g_bgeg_m_t.bgeg005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg005
            #add-point:ON CHANGE bgeg005 name="input.g.bgeg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg006
            #add-point:BEFORE FIELD bgeg006 name="input.b.bgeg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg006
            
            #add-point:AFTER FIELD bgeg006 name="input.a.bgeg006"
            #主鍵檢查
            IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
               AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t)  
                                  )
               ) THEN 
                  CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                             g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgeg_m.bgeg006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg006 = g_bgeg_m_t.bgeg006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg006
            #add-point:ON CHANGE bgeg006 name="input.g.bgeg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg010
            #add-point:BEFORE FIELD bgeg010 name="input.b.bgeg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg010
            
            #add-point:AFTER FIELD bgeg010 name="input.a.bgeg010"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) AND NOT cl_null(g_bgeg_m.bgeg007) AND NOT cl_null(g_bgeg_m.bgeg009) AND NOT cl_null(g_bgeg_m.bgeg010) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t  OR g_bgeg_m.bgeg007 != g_bgeg007_t  OR g_bgeg_m.bgeg009 != g_bgeg009_t  OR g_bgeg_m.bgeg010 != g_bgeg010_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgeg_t WHERE "||"bgegent = " ||g_enterprise|| " AND "||"bgeg001 = '"||g_bgeg_m.bgeg001 ||"' AND "|| "bgeg002 = '"||g_bgeg_m.bgeg002 ||"' AND "|| "bgeg003 = '"||g_bgeg_m.bgeg003 ||"' AND "|| "bgeg004 = '"||g_bgeg_m.bgeg004 ||"' AND "|| "bgeg005 = '"||g_bgeg_m.bgeg005 ||"' AND "|| "bgeg006 = '"||g_bgeg_m.bgeg006 ||"' AND "|| "bgeg007 = '"||g_bgeg_m.bgeg007 ||"' AND "|| "bgeg009 = '"||g_bgeg_m.bgeg009 ||"' AND "|| "bgeg010 = '"||g_bgeg_m.bgeg010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg010
            #add-point:ON CHANGE bgeg010 name="input.g.bgeg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegstus
            #add-point:BEFORE FIELD bgegstus name="input.b.bgegstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegstus
            
            #add-point:AFTER FIELD bgegstus name="input.a.bgegstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgegstus
            #add-point:ON CHANGE bgegstus name="input.g.bgegstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg007
            
            #add-point:AFTER FIELD bgeg007 name="input.a.bgeg007"

            IF NOT cl_null(g_bgeg_m.bgeg007) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg007 != g_bgeg_m_t.bgeg007 OR cl_null(g_bgeg_m_t.bgeg007))) THEN
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgeg_m.bgeg007
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     #檢查失敗時後續處理
                     LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                     CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
                     NEXT FIELD CURRENT
                  END IF
                 
                  #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_bgeg_m.bgeg007,'03')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_m.bgeg007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                     CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #检查预算编号+版本+预算管理组织+销售方式下预算组织或预算上层组织是否已存在汇总资料abgt520，如果存在，不可录入
                  IF NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) AND
                     NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) THEN
                     #预算组织是否存在汇总资料
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM bgeg_t
                      WHERE bgegent=g_enterprise AND bgeg001='30'
                        AND bgeg002=g_bgeg_m.bgeg002 AND bgeg003=g_bgeg_m.bgeg003
                        AND bgeg004=g_bgeg_m.bgeg004 AND bgeg005=g_bgeg_m.bgeg005
                        AND bgeg006='2' AND bgeg007 = g_bgeg_m.bgeg007
                        AND bgegstus<>'X'
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00231'
                        LET g_errparam.extend =g_bgeg_m.bgeg007
                        #161215-00014#2--mod--str--
#                        LET g_errparam.replace[1] = 'abgt520'
#                        LET g_errparam.replace[2] = cl_get_progname('abgt520',g_lang,"2")
                        LET g_errparam.replace[1] = cl_get_progname('abgt520',g_lang,"2")
                        #161215-00014#2--mod--end
                        LET g_errparam.exeprog = 'abgt520'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                        CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
                        DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
                        NEXT FIELD CURRENT
                     END IF
                     #预算组织的上层组织是否存在汇总资料
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgeg_m.bgeg002
                     #抓取上层组织
                     IF NOT cl_null(l_bgaa010) THEN
                        SELECT ooed005 INTO l_ooed005 FROM ooed_t
                          WHERE ooedent=g_enterprise AND ooed001='4'
                            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                            AND ooed004=g_bgeg_m.bgeg007
                        IF NOT cl_null(l_ooed005) THEN
                           LET l_cnt = 0
                           SELECT COUNT(1) INTO l_cnt FROM bgeg_t
                            WHERE bgegent=g_enterprise AND bgeg001='30'
                              AND bgeg002=g_bgeg_m.bgeg002 AND bgeg003=g_bgeg_m.bgeg003
                              AND bgeg004=g_bgeg_m.bgeg004 AND bgeg005=g_bgeg_m.bgeg005
                              AND bgeg006='2' AND bgeg007 = l_ooed005
                              AND bgegstus<>'X'
                           IF l_cnt > 0 THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00232'
                              LET g_errparam.extend =g_bgeg_m.bgeg007
                              #161215-00014#2--mod--str--
#                             LET g_errparam.replace[1] = 'abgt520'
#                             LET g_errparam.replace[2] = cl_get_progname('abgt520',g_lang,"2")
                             LET g_errparam.replace[1] = cl_get_progname('abgt520',g_lang,"2")
                             #161215-00014#2--mod--end
                              LET g_errparam.exeprog = 'abgt520'
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                              CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
                              DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
                     AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                        OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                   g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgeg_m.bgeg007
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #预算料号在单头
                  
                  IF g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009) THEN
                     LET l_bgea017 = ''
                     LET l_bgea005 = ''
                     SELECT bgea005,bgea017 INTO l_bgea005,l_bgea017
                       FROM bgea_t
                      WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_m.bgeg009
                        AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_m.bgeg007
                     #161215-00014#2--add--str--
                     #该预算料号没有维护对应的预算细项！
                     IF cl_null(l_bgea005) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00204'
                        LET g_errparam.extend =g_bgeg_m.bgeg007," + ",g_bgeg_m.bgeg009
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                        NEXT FIELD CURRENT
                     END IF
                     #161215-00014#2--add--end
                     #预算细项权限检查abgi090
                     CALL s_abg2_bgai006_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,g_bgeg_m.bgeg007,'03',l_bgea005)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend =l_bgea005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                        NEXT FIELD CURRENT
                     END IF
                     LET g_bgeg_m.bgeg049 = l_bgea005
                     
                     #设置单头启用核算项
                     CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_m.bgeg007,g_bgeg_m.bgeg049)
                     
                     IF NOT cl_null(l_bgea017) AND 
                        ((g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_m.bgeg016)) OR 
                         (g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_m.bgeg017))
                        ) THEN
                        #检核料号带出的交易客商是否正确,若正确的复制给交易客商
                        CALL s_abg2_bgap001_chk_1(l_bgea017,g_bgeg_m.bgeg007)
                        IF cl_null(g_errno) THEN
                           #收付款客商
                           IF g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_m.bgeg016) THEN
                              LET g_bgeg_m.bgeg016 = l_bgea017
                              CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg016) RETURNING g_bgeg_m.bgeg016_desc_t
                              DISPLAY BY NAME g_bgeg_m.bgeg016,g_bgeg_m.bgeg016_desc_t
                           END IF
                           #账款客商
                           IF g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_m.bgeg017) THEN
                              LET g_bgeg_m.bgeg017 = l_bgea017
                              CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg017) RETURNING g_bgeg_m.bgeg017_desc_t
                              DISPLAY BY NAME g_bgeg_m.bgeg017,g_bgeg_m.bgeg017_desc_t
                           END IF
                        END IF
                     END IF
                  END IF
                  
               END IF
            END IF
            CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
            DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg007
            #add-point:BEFORE FIELD bgeg007 name="input.b.bgeg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg007
            #add-point:ON CHANGE bgeg007 name="input.g.bgeg007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg013
            
            #add-point:AFTER FIELD bgeg013 name="input.a.bgeg013"
            IF NOT cl_null(g_bgeg_m.bgeg013) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg013 != g_bgeg_m_t.bgeg013 OR cl_null(g_bgeg_m_t.bgeg013))) THEN
                  #部门基础资料检核
                  CALL s_department_chk(g_bgeg_m.bgeg013,g_today) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_m.bgeg013 = g_bgeg_m_t.bgeg013
                     CALL s_desc_get_department_desc(g_bgeg_m.bgeg013) RETURNING g_bgeg_m.bgeg013_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg013_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bgeg_m.bgeg013,g_bgeg_m.bgeg007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_m.bgeg013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg013 = g_bgeg_m_t.bgeg013
                     CALL s_desc_get_department_desc(g_bgeg_m.bgeg013) RETURNING g_bgeg_m.bgeg013_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg013_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               #抓取部门对应利润中心
               IF g_bgaw1[4]='Y' AND cl_null(g_bgeg_m.bgeg014) AND g_bgal.bgal006 = 'Y' THEN
                  SELECT ooeg004 INTO g_bgeg_m.bgeg014 FROM ooeg_t
                   WHERE ooegent=g_enterprise AND ooeg001=g_bgeg_m.bgeg013
                  CALL s_desc_get_department_desc(g_bgeg_m.bgeg014) RETURNING g_bgeg_m.bgeg014_desc_t
                  DISPLAY BY NAME g_bgeg_m.bgeg014,g_bgeg_m.bgeg014_desc_t
               END IF
            END IF
            CALL s_desc_get_department_desc(g_bgeg_m.bgeg013) RETURNING g_bgeg_m.bgeg013_desc_t
            DISPLAY BY NAME g_bgeg_m.bgeg013_desc_t
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg013
            #add-point:BEFORE FIELD bgeg013 name="input.b.bgeg013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg013
            #add-point:ON CHANGE bgeg013 name="input.g.bgeg013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg016
            
            #add-point:AFTER FIELD bgeg016 name="input.a.bgeg016"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg016
            CALL ap_ref_array2(g_ref_fields,"SELECT bgapl003 FROM bgapl_t WHERE bgaplent="||g_enterprise||" AND bgapl001=? AND bgapl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg016_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg016_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg016) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg016 != g_bgeg_m_t.bgeg016 OR cl_null(g_bgeg_m_t.bgeg016))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgeg_m.bgeg016,g_bgeg_m.bgeg007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg016
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg016 = g_bgeg_m_t.bgeg016
                     CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg016) RETURNING g_bgeg_m.bgeg016_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg016_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg016
            #add-point:BEFORE FIELD bgeg016 name="input.b.bgeg016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg016
            #add-point:ON CHANGE bgeg016 name="input.g.bgeg016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg019
            
            #add-point:AFTER FIELD bgeg019 name="input.a.bgeg019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg019
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent="||g_enterprise||" AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg019_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg019_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg019) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg019 != g_bgeg_m_t.bgeg019 OR cl_null(g_bgeg_m_t.bgeg019))) THEN
                  CALL s_voucher_glaq024_chk(g_bgeg_m.bgeg019)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg019
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg019 = g_bgeg_m_t.bgeg019
                     CALL s_desc_get_rtaxl003_desc(g_bgeg_m.bgeg019) RETURNING g_bgeg_m.bgeg019_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg019_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg019
            #add-point:BEFORE FIELD bgeg019 name="input.b.bgeg019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg019
            #add-point:ON CHANGE bgeg019 name="input.g.bgeg019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg022
            #add-point:BEFORE FIELD bgeg022 name="input.b.bgeg022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg022
            
            #add-point:AFTER FIELD bgeg022 name="input.a.bgeg022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg022
            #add-point:ON CHANGE bgeg022 name="input.g.bgeg022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg009
            #add-point:BEFORE FIELD bgeg009 name="input.b.bgeg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg009
            
            #add-point:AFTER FIELD bgeg009 name="input.a.bgeg009"
            IF NOT cl_null(g_bgeg_m.bgeg009) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg009 != g_bgeg_m_t.bgeg009 OR cl_null(g_bgeg_m_t.bgeg009))) THEN
                  CALL s_abgt510_bgeg009_chk(g_bgeg_m.bgeg005,g_bgeg_m.bgeg009,g_bgeg_m.bgeg002,g_bgeg_m.bgeg007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_m.bgeg009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg009 = g_bgeg_m_t.bgeg009
                     NEXT FIELD CURRENT
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
                     AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                        OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                        OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                        OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t) 
                                        )
                     ) THEN 
                        CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                   g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgeg_m.bgeg009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_m.bgeg009 = g_bgeg_m_t.bgeg009
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               
                  #对应预算细项
                  #采购来源1.外部采购单
                  LET l_bgea017 = ''
                  LET l_bgea005 = ''
                  IF NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg007) THEN
                     SELECT bgea005,bgea017 INTO l_bgea005,l_bgea017
                       FROM bgea_t
                      WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_m.bgeg009
                        AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_m.bgeg007
                     #预算细项权限检查abgi090
                     CALL s_abg2_bgai006_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,g_bgeg_m.bgeg007,'03',l_bgea005)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend =l_bgea005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeg_m.bgeg009 = g_bgeg_m_t.bgeg009
                        NEXT FIELD CURRENT
                     END IF
                     LET g_bgeg_m.bgeg049 = l_bgea005
                  END IF
                  
                  #设置单头启用核算项
                  CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_m.bgeg007,g_bgeg_m.bgeg049)
                  #收付款客商、账款客商 设置默认值
                  IF NOT cl_null(l_bgea017) AND 
                     ((g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_m.bgeg016)) OR 
                      (g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_m.bgeg017))
                     ) THEN
                     #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                     CALL s_abg2_bgap001_chk_1(l_bgea017,g_bgeg_m.bgeg007)
                     IF cl_null(g_errno) THEN
                        #收付款客商
                        IF g_bgaw1[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_m.bgeg016) THEN
                           LET g_bgeg_m.bgeg016 = l_bgea017
                           CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg016) RETURNING g_bgeg_m.bgeg016_desc_t
                           DISPLAY BY NAME g_bgeg_m.bgeg016,g_bgeg_m.bgeg016_desc_t
                        END IF
                        #账款客商
                        IF g_bgaw1[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_m.bgeg017) THEN
                           LET g_bgeg_m.bgeg017 = l_bgea017
                           CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg017) RETURNING g_bgeg_m.bgeg017_desc_t
                           DISPLAY BY NAME g_bgeg_m.bgeg017,g_bgeg_m.bgeg017_desc_t
                        END IF
                     END IF
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg009
            #add-point:ON CHANGE bgeg009 name="input.g.bgeg009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg014
            
            #add-point:AFTER FIELD bgeg014 name="input.a.bgeg014"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg014
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? ","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg014_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg014_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg014) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg014 != g_bgeg_m_t.bgeg014 OR cl_null(g_bgeg_m_t.bgeg014))) THEN
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bgeg_m.bgeg014,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg014
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg014 = g_bgeg_m_t.bgeg014
                     CALL s_desc_get_department_desc(g_bgeg_m.bgeg014) RETURNING g_bgeg_m.bgeg014_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg014_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bgeg_m.bgeg014,g_bgeg_m.bgeg007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_m.bgeg014
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg014 = g_bgeg_m_t.bgeg014
                     CALL s_desc_get_department_desc(g_bgeg_m.bgeg014) RETURNING g_bgeg_m.bgeg014_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg014_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg014
            #add-point:BEFORE FIELD bgeg014 name="input.b.bgeg014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg014
            #add-point:ON CHANGE bgeg014 name="input.g.bgeg014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg017
            
            #add-point:AFTER FIELD bgeg017 name="input.a.bgeg017"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg017
            CALL ap_ref_array2(g_ref_fields,"SELECT bgapl003 FROM bgapl_t WHERE bgaplent="||g_enterprise||" AND bgapl001=? AND bgapl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg017_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg017_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg017) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg017 != g_bgeg_m_t.bgeg017 OR cl_null(g_bgeg_m_t.bgeg017))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgeg_m.bgeg017,g_bgeg_m.bgeg007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg017
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg017 = g_bgeg_m_t.bgeg017
                     CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg017) RETURNING g_bgeg_m.bgeg017_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg017_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg017
            #add-point:BEFORE FIELD bgeg017 name="input.b.bgeg017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg017
            #add-point:ON CHANGE bgeg017 name="input.g.bgeg017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg020
            
            #add-point:AFTER FIELD bgeg020 name="input.a.bgeg020"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg020
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent="||g_enterprise||" AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg020_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg020_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg020) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg020 != g_bgeg_m_t.bgeg020 OR cl_null(g_bgeg_m_t.bgeg020))) THEN
                  CALL s_aap_project_chk(g_bgeg_m.bgeg020) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg020
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg020 = g_bgeg_m_t.bgeg020
                     CALL s_desc_get_oojdl003_desc(g_bgeg_m.bgeg020) RETURNING g_bgeg_m.bgeg020_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg020_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg020
            #add-point:BEFORE FIELD bgeg020 name="input.b.bgeg020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg020
            #add-point:ON CHANGE bgeg020 name="input.g.bgeg020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg023
            
            #add-point:AFTER FIELD bgeg023 name="input.a.bgeg023"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg023
            CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent="||g_enterprise||" AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg023_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg023_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg023) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg023 != g_bgeg_m_t.bgeg023 OR cl_null(g_bgeg_m_t.bgeg023))) THEN
                  CALL s_voucher_glaq052_chk(g_bgeg_m.bgeg023) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg023
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg023 = g_bgeg_m_t.bgeg023
                     CALL s_desc_get_oojdl003_desc(g_bgeg_m.bgeg023) RETURNING g_bgeg_m.bgeg023_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg023_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg023
            #add-point:BEFORE FIELD bgeg023 name="input.b.bgeg023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg023
            #add-point:ON CHANGE bgeg023 name="input.g.bgeg023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg012
            
            #add-point:AFTER FIELD bgeg012 name="input.a.bgeg012"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent="||g_enterprise||" AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg012_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg012_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg012) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg012 != g_bgeg_m_t.bgeg012 OR cl_null(g_bgeg_m_t.bgeg012))) THEN
                  #员工基础资料检查
                  CALL s_employee_chk(g_bgeg_m.bgeg012) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_m.bgeg012 = g_bgeg_m_t.bgeg012
                     CALL s_desc_get_person_desc(g_bgeg_m.bgeg012) RETURNING g_bgeg_m.bgeg012_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg012_desc_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，人员在单头时，人员归属据点归属法人必须等于g_site归属法人
                  #其他情况，人员归属据点归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(1,g_bgeg_m.bgeg012,g_bgeg_m.bgeg007)                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_m.bgeg012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg012 = g_bgeg_m_t.bgeg012
                     CALL s_desc_get_person_desc(g_bgeg_m.bgeg012) RETURNING g_bgeg_m.bgeg012_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg012_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg012
            #add-point:BEFORE FIELD bgeg012 name="input.b.bgeg012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg012
            #add-point:ON CHANGE bgeg012 name="input.g.bgeg012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg015
            
            #add-point:AFTER FIELD bgeg015 name="input.a.bgeg015"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg015
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg015_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg015_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg015) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg015 != g_bgeg_m_t.bgeg015 OR cl_null(g_bgeg_m_t.bgeg015))) THEN
                  CALL s_azzi650_chk_exist('287',g_bgeg_m.bgeg015) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_m.bgeg015 = g_bgeg_m_t.bgeg015
                     CALL s_desc_get_acc_desc('287',g_bgeg_m.bgeg015) RETURNING g_bgeg_m.bgeg015_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg015_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg015
            #add-point:BEFORE FIELD bgeg015 name="input.b.bgeg015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg015
            #add-point:ON CHANGE bgeg015 name="input.g.bgeg015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg018
            
            #add-point:AFTER FIELD bgeg018 name="input.a.bgeg018"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='281' AND oocql002=? AND oocql003=? ","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg018_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg018_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg018) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg018 != g_bgeg_m_t.bgeg018 OR cl_null(g_bgeg_m_t.bgeg018))) THEN
                  CALL s_azzi650_chk_exist('281',g_bgeg_m.bgeg018) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_m.bgeg018 = g_bgeg_m_t.bgeg018
                     CALL s_desc_get_acc_desc('281',g_bgeg_m.bgeg018) RETURNING g_bgeg_m.bgeg018_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg018_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg018
            #add-point:BEFORE FIELD bgeg018 name="input.b.bgeg018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg018
            #add-point:ON CHANGE bgeg018 name="input.g.bgeg018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg021
            
            #add-point:AFTER FIELD bgeg021 name="input.a.bgeg021"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg020
            LET g_ref_fields[2] = g_bgeg_m.bgeg021
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent="||g_enterprise||" AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg021_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg021_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg021 != g_bgeg_m_t.bgeg021 OR cl_null(g_bgeg_m_t.bgeg021))) THEN
                  CALL s_voucher_glaq028_chk(g_bgeg_m.bgeg020,g_bgeg_m.bgeg021)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_m.bgeg021
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_m.bgeg021 = g_bgeg_m_t.bgeg021
                     CALL s_desc_get_wbs_desc(g_bgeg_m.bgeg020,g_bgeg_m.bgeg021) RETURNING g_bgeg_m.bgeg021_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg021_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg021
            #add-point:BEFORE FIELD bgeg021 name="input.b.bgeg021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg021
            #add-point:ON CHANGE bgeg021 name="input.g.bgeg021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg024
            
            #add-point:AFTER FIELD bgeg024 name="input.a.bgeg024"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgeg_m.bgeg024
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgeg_m.bgeg024_desc_t = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgeg_m.bgeg024_desc_t
            IF NOT cl_null(g_bgeg_m.bgeg024) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_bgeg_m.bgeg024 != g_bgeg_m_t.bgeg024 OR cl_null(g_bgeg_m_t.bgeg024))) THEN
                  CALL s_azzi650_chk_exist('2002',g_bgeg_m.bgeg024) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_m.bgeg024 = g_bgeg_m_t.bgeg024
                     CALL s_desc_get_acc_desc('2002',g_bgeg_m.bgeg024) RETURNING g_bgeg_m.bgeg024_desc_t
                     DISPLAY BY NAME g_bgeg_m.bgeg024_desc_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg024
            #add-point:BEFORE FIELD bgeg024 name="input.b.bgeg024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg024
            #add-point:ON CHANGE bgeg024 name="input.g.bgeg024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg049
            #add-point:BEFORE FIELD bgeg049 name="input.b.bgeg049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg049
            
            #add-point:AFTER FIELD bgeg049 name="input.a.bgeg049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg049
            #add-point:ON CHANGE bgeg049 name="input.g.bgeg049"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgeg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg002
            #add-point:ON ACTION controlp INFIELD bgeg002 name="input.c.bgeg002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaa006 = '1' "
 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg002 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg002 TO bgeg002              #

            NEXT FIELD bgeg002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg003
            #add-point:ON ACTION controlp INFIELD bgeg003 name="input.c.bgeg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgeg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg004
            #add-point:ON ACTION controlp INFIELD bgeg004 name="input.c.bgeg004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='03' OR bgai005='00')" 
            IF NOT cl_null(g_bgeg_m.bgeg002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_bgeg_m.bgeg002,"' "
            END IF
 
            CALL q_bgai002()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg004 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg004 TO bgeg004              #

            NEXT FIELD bgeg004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg011
            #add-point:ON ACTION controlp INFIELD bgeg011 name="input.c.bgeg011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaw001()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg011 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg011 TO bgeg011              #

            NEXT FIELD bgeg011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg001
            #add-point:ON ACTION controlp INFIELD bgeg001 name="input.c.bgeg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgeg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg005
            #add-point:ON ACTION controlp INFIELD bgeg005 name="input.c.bgeg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgeg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg006
            #add-point:ON ACTION controlp INFIELD bgeg006 name="input.c.bgeg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgeg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg010
            #add-point:ON ACTION controlp INFIELD bgeg010 name="input.c.bgeg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgegstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegstus
            #add-point:ON ACTION controlp INFIELD bgegstus name="input.c.bgegstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgeg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg007
            #add-point:ON ACTION controlp INFIELD bgeg007 name="input.c.bgeg007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg007             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,'03') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg007 = g_qryparam.return1              
            #LET g_bgeg_m.ooef001 = g_qryparam.return2 
            DISPLAY g_bgeg_m.bgeg007 TO bgeg007              #
            #DISPLAY g_bgeg_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD bgeg007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg013
            #add-point:ON ACTION controlp INFIELD bgeg013 name="input.c.bgeg013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgeg_m.bgeg007) THEN
                  LET l_ooef001 = g_bgeg_m.bgeg007
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
 
            LET g_bgeg_m.bgeg013 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg013 TO bgeg013              #

            NEXT FIELD bgeg013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg016
            #add-point:ON ACTION controlp INFIELD bgeg016 name="input.c.bgeg016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            #当预算组织在单头
            IF g_bgaw1[1]='Y'  THEN
               LET l_bgeg007 = g_bgeg_m.bgeg007
            ELSE
               LET l_bgeg007 = g_site
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgeg007,"')"
 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg016 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg016 TO bgeg016              #

            NEXT FIELD bgeg016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg019
            #add-point:ON ACTION controlp INFIELD bgeg019 name="input.c.bgeg019"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg019 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg019 TO bgeg019              #

            NEXT FIELD bgeg019                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg022
            #add-point:ON ACTION controlp INFIELD bgeg022 name="input.c.bgeg022"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgeg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg009
            #add-point:ON ACTION controlp INFIELD bgeg009 name="input.c.bgeg009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgas001 IN (SELECT bgea003 FROM bgea_t ",
                                   "              WHERE bgeaent=",g_enterprise," AND bgeastus='Y' "
            IF NOT cl_null(g_bgeg_m.bgeg002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgea001='",g_bgeg_m.bgeg002,"' "
            END IF
            IF NOT cl_null(g_bgeg_m.bgeg007) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgea002='",g_bgeg_m.bgeg007,"' "
            END IF
            LET g_qryparam.where = g_qryparam.where," )"
            CALL q_bgas001() 
             
            LET g_bgeg_m.bgeg009 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg009 TO bgeg009              #

            NEXT FIELD bgeg009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg014
            #add-point:ON ACTION controlp INFIELD bgeg014 name="input.c.bgeg014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s
             #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgeg_m.bgeg007) THEN
                  LET l_ooef001 = g_bgeg_m.bgeg007
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
 
            LET g_bgeg_m.bgeg014 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg014 TO bgeg014              #

            NEXT FIELD bgeg014                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg017
            #add-point:ON ACTION controlp INFIELD bgeg017 name="input.c.bgeg017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            #当预算组织在单头
            IF g_bgaw1[1]='Y' THEN
               LET l_bgeg007 = g_bgeg_m.bgeg007
            ELSE
               LET l_bgeg007 = g_site
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgeg007,"')"
 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg017 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg017 TO bgeg017              #

            NEXT FIELD bgeg017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg020
            #add-point:ON ACTION controlp INFIELD bgeg020 name="input.c.bgeg020"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg020 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg020 TO bgeg020              #

            NEXT FIELD bgeg020                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg023
            #add-point:ON ACTION controlp INFIELD bgeg023 name="input.c.bgeg023"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg023 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg023 TO bgeg023              #

            NEXT FIELD bgeg023                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg012
            #add-point:ON ACTION controlp INFIELD bgeg012 name="input.c.bgeg012"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgeg_m.bgeg007) THEN
                  LET l_ooef001 = g_bgeg_m.bgeg007
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
 
            LET g_bgeg_m.bgeg012 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg012 TO bgeg012              #

            NEXT FIELD bgeg012                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg015
            #add-point:ON ACTION controlp INFIELD bgeg015 name="input.c.bgeg015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg015             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg015 = g_qryparam.return1              
            #LET g_bgeg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_m.bgeg015 TO bgeg015              #
            #DISPLAY g_bgeg_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg018
            #add-point:ON ACTION controlp INFIELD bgeg018 name="input.c.bgeg018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg018             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg018 = g_qryparam.return1              
            #LET g_bgeg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_m.bgeg018 TO bgeg018              #
            #DISPLAY g_bgeg_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg021
            #add-point:ON ACTION controlp INFIELD bgeg021 name="input.c.bgeg021"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            IF NOT cl_null(g_bgeg_m.bgeg020) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bgeg_m.bgeg020,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg021 = g_qryparam.return1              

            DISPLAY g_bgeg_m.bgeg021 TO bgeg021              #

            NEXT FIELD bgeg021                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg024
            #add-point:ON ACTION controlp INFIELD bgeg024 name="input.c.bgeg024"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_m.bgeg024             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgeg_m.bgeg024 = g_qryparam.return1              
            #LET g_bgeg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_m.bgeg024 TO bgeg024              #
            #DISPLAY g_bgeg_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg024                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgeg049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg049
            #add-point:ON ACTION controlp INFIELD bgeg049 name="input.c.bgeg049"
            
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
            DISPLAY BY NAME g_bgeg_m.bgeg001             
                            ,g_bgeg_m.bgeg002   
                            ,g_bgeg_m.bgeg003   
                            ,g_bgeg_m.bgeg004   
                            ,g_bgeg_m.bgeg005   
                            ,g_bgeg_m.bgeg006   
                            ,g_bgeg_m.bgeg007   
                            ,g_bgeg_m.bgeg009   
                            ,g_bgeg_m.bgeg010   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_m.bgeg007,g_bgeg_m.bgeg049)
            #预算组织检核
            IF g_bgaw1[1]='Y' THEN
               #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
               #2.檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_bgeg_m.bgeg007,'03')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_bgeg_m.bgeg007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgeg_m.bgeg007 = g_bgeg_m_t.bgeg007
                  CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
                  DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
                  NEXT FIELD bgeg007
               END IF
            END IF
             
            #预算料号检核
            IF g_bgaw1[2]='Y' THEN 
               CALL s_abgt510_bgeg009_chk(g_bgeg_m.bgeg005,g_bgeg_m.bgeg009,g_bgeg_m.bgeg002,g_bgeg_m.bgeg007)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_bgeg_m.bgeg009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgeg_m.bgeg009 = g_bgeg_m_t.bgeg009
                  NEXT FIELD bgeg009
               END IF
            END IF
            
            #主鍵檢查
            IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
               AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR g_bgaw1[1]='N' )
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR g_bgaw1[2]='N' ) 
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                  OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t)
                                  OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t)  
                                  )
               ) THEN 
                  CALL s_abgt510_head_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                             g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgaw1[1],g_bgaw1[2])
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgeg002
                  END IF
               END IF
            END IF
            
         IF 1=2 THEN
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgt510_bgeg_t_mask_restore('restore_mask_o')
            
               UPDATE bgeg_t SET (bgeg002,bgeg003,bgeg004,bgeg011,bgeg001,bgeg005,bgeg006,bgeg010,bgegstus, 
                   bgeg007,bgeg013,bgeg016,bgeg019,bgeg022,bgeg009,bgeg014,bgeg017,bgeg020,bgeg023,bgeg012, 
                   bgeg015,bgeg018,bgeg021,bgeg024,bgeg049) = (g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
                   g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg010, 
                   g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019, 
                   g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020, 
                   g_bgeg_m.bgeg023,g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021, 
                   g_bgeg_m.bgeg024,g_bgeg_m.bgeg049)
                WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg001_t
                  AND bgeg002 = g_bgeg002_t
                  AND bgeg003 = g_bgeg003_t
                  AND bgeg004 = g_bgeg004_t
                  AND bgeg005 = g_bgeg005_t
                  AND bgeg006 = g_bgeg006_t
                  AND bgeg007 = g_bgeg007_t
                  AND bgeg009 = g_bgeg009_t
                  AND bgeg010 = g_bgeg010_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgeg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgeg_m.bgeg001
               LET gs_keys_bak[1] = g_bgeg001_t
               LET gs_keys[2] = g_bgeg_m.bgeg002
               LET gs_keys_bak[2] = g_bgeg002_t
               LET gs_keys[3] = g_bgeg_m.bgeg003
               LET gs_keys_bak[3] = g_bgeg003_t
               LET gs_keys[4] = g_bgeg_m.bgeg004
               LET gs_keys_bak[4] = g_bgeg004_t
               LET gs_keys[5] = g_bgeg_m.bgeg005
               LET gs_keys_bak[5] = g_bgeg005_t
               LET gs_keys[6] = g_bgeg_m.bgeg006
               LET gs_keys_bak[6] = g_bgeg006_t
               LET gs_keys[7] = g_bgeg_m.bgeg007
               LET gs_keys_bak[7] = g_bgeg007_t
               LET gs_keys[8] = g_bgeg_m.bgeg009
               LET gs_keys_bak[8] = g_bgeg009_t
               LET gs_keys[9] = g_bgeg_m.bgeg010
               LET gs_keys_bak[9] = g_bgeg010_t
               LET gs_keys[10] = g_bgeg_d[g_detail_idx].bgeg008
               LET gs_keys_bak[10] = g_bgeg_d_t.bgeg008
               LET gs_keys[11] = g_bgeg_d[g_detail_idx].bgegseq
               LET gs_keys_bak[11] = g_bgeg_d_t.bgegseq
               CALL abgt510_update_b('bgeg_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bgeg_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bgeg_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgt510_bgeg_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
            END IF
         END IF
         
            IF p_cmd = 'u' THEN
               #將遮罩欄位還原
               CALL abgt510_bgeg_t_mask_restore('restore_mask_o')
               
               #重写更新单头资料UPDATE
               LET l_success = TRUE
               CALL abgt510_update_head() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  INITIALIZE gs_keys TO NULL 
                  LET gs_keys[1] = g_bgeg_m.bgeg001
                  LET gs_keys_bak[1] = g_bgeg001_t
                  LET gs_keys[2] = g_bgeg_m.bgeg002
                  LET gs_keys_bak[2] = g_bgeg002_t
                  LET gs_keys[3] = g_bgeg_m.bgeg003
                  LET gs_keys_bak[3] = g_bgeg003_t
                  LET gs_keys[4] = g_bgeg_m.bgeg004
                  LET gs_keys_bak[4] = g_bgeg004_t
                  LET gs_keys[5] = g_bgeg_m.bgeg005
                  LET gs_keys_bak[5] = g_bgeg005_t
                  LET gs_keys[6] = g_bgeg_m.bgeg006
                  LET gs_keys_bak[6] = g_bgeg006_t
                  LET gs_keys[7] = g_bgeg_m.bgeg007
                  LET gs_keys_bak[7] = g_bgeg007_t
                  LET gs_keys[8] = g_bgeg_m.bgeg009
                  LET gs_keys_bak[8] = g_bgeg009_t
                  LET gs_keys[9] = g_bgeg_d[g_detail_idx].bgeg008
                  LET gs_keys_bak[9] = g_bgeg_d_t.bgeg008
                  LET gs_keys[10] = g_bgeg_d[g_detail_idx].bgeg010
                  LET gs_keys_bak[10] = g_bgeg_d_t.bgeg010
                  LET gs_keys[11] = g_bgeg_d[g_detail_idx].bgegseq
                  LET gs_keys_bak[11] = g_bgeg_d_t.bgegseq
                  CALL abgt510_update_b('bgeg_t',gs_keys,gs_keys_bak,"'1'")
                  CALL s_transaction_end('Y','0')
               END IF
               #將遮罩欄位進行遮蔽
               CALL abgt510_bgeg_t_mask_restore('restore_mask_n')
            ELSE 
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgt510_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bgeg001_t = g_bgeg_m.bgeg001
           LET g_bgeg002_t = g_bgeg_m.bgeg002
           LET g_bgeg003_t = g_bgeg_m.bgeg003
           LET g_bgeg004_t = g_bgeg_m.bgeg004
           LET g_bgeg005_t = g_bgeg_m.bgeg005
           LET g_bgeg006_t = g_bgeg_m.bgeg006
           LET g_bgeg007_t = g_bgeg_m.bgeg007
           LET g_bgeg009_t = g_bgeg_m.bgeg009
           LET g_bgeg010_t = g_bgeg_m.bgeg010
 
           
           IF g_bgeg_d.getLength() = 0 THEN
              NEXT FIELD bgeg008
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgt510.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgeg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgeg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt510_b_fill(g_wc2) #test 
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
            CALL abgt510_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgt510_cl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgt510_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt510_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgeg_d[l_ac].bgeg008 IS NOT NULL
               AND g_bgeg_d[l_ac].bgegseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgeg_d_t.* = g_bgeg_d[l_ac].*  #BACKUP
               LET g_bgeg_d_o.* = g_bgeg_d[l_ac].*  #BACKUP
               CALL abgt510_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgt510_set_no_entry_b(l_cmd)
               OPEN abgt510_bcl USING g_enterprise,g_bgeg_m.bgeg001,
                                                g_bgeg_m.bgeg002,
                                                g_bgeg_m.bgeg003,
                                                g_bgeg_m.bgeg004,
                                                g_bgeg_m.bgeg005,
                                                g_bgeg_m.bgeg006,
                                                g_bgeg_m.bgeg007,
                                                g_bgeg_m.bgeg009,
                                                g_bgeg_m.bgeg010,
 
                                                g_bgeg_d_t.bgeg008
                                                ,g_bgeg_d_t.bgegseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt510_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt510_bcl INTO g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010,g_bgeg_d[l_ac].bgeg007, 
                      g_bgeg_d[l_ac].bgeg009,g_bgeg_d[l_ac].bgeg049,g_bgeg_d[l_ac].bgeg012,g_bgeg_d[l_ac].bgeg013, 
                      g_bgeg_d[l_ac].bgeg014,g_bgeg_d[l_ac].bgeg015,g_bgeg_d[l_ac].bgeg016,g_bgeg_d[l_ac].bgeg017, 
                      g_bgeg_d[l_ac].bgeg018,g_bgeg_d[l_ac].bgeg019,g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021, 
                      g_bgeg_d[l_ac].bgeg022,g_bgeg_d[l_ac].bgeg023,g_bgeg_d[l_ac].bgeg024,g_bgeg_d[l_ac].bgeg035, 
                      g_bgeg_d[l_ac].bgeg036,g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg008, 
                      g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048,g_bgeg_d[l_ac].bgeg050,g_bgeg2_d[l_ac].bgegseq, 
                      g_bgeg2_d[l_ac].bgegownid,g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid, 
                      g_bgeg2_d[l_ac].bgegcrtdp,g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid, 
                      g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt, 
                      g_bgeg3_d[l_ac].bgegseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgeg_d_t.bgeg008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgeg_d_mask_o[l_ac].* =  g_bgeg_d[l_ac].*
                  CALL abgt510_bgeg_t_mask()
                  LET g_bgeg_d_mask_n[l_ac].* =  g_bgeg_d[l_ac].*
                  
                  CALL abgt510_ref_show()
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
            CALL abgt510_idx_chk()
            
            
            CALL s_transaction_begin()
            
            
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               CASE
                  #预算组织在单头 AND #预算料号在单头
                  WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
                     OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
                         g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009
                  #预算组织在单头 AND #预算料号在单身
                  WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
                     OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
                         g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007
                  #预算组织在单身 AND #预算料号在单头
                  WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
                     OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
                         g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg009
                  #预算组织在单身 AND #预算料号在单身
                  WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
                     OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
                         g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006
               END CASE
               #当错写为-404 表示没有定义锁单头abgt510_hcl 这中情况出现在，打开作业直接点新增，没有走fetch  
               IF STATUS = '-404' THEN 
                  #重写单头锁资料sql
                  LET g_sql = " SELECT bgeg002,'',bgeg003,bgeg004,'','','',bgeg011,bgeg001,bgeg005,bgeg006,bgegstus, 
                      '','','','','','','','','','','','','','','','','','','','','','','','','','','','',''", 
                                     " FROM bgeg_t",
                                     " WHERE bgegent= ? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND  
                                         bgeg005=? AND bgeg006=? "
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     LET g_sql = g_sql," AND bgeg007='",g_bgeg_m.bgeg007,"'"
                  END IF
                  #预算料号在单头
                  IF g_bgaw1[2] = 'Y' THEN
                     LET g_sql = g_sql," AND bgeg009='",g_bgeg_m.bgeg009,"'"
                  END IF
                  LET g_sql = g_sql,"FOR UPDATE"
                  
                  LET g_sql = cl_sql_forupd(g_sql)                #轉換不同資料庫語法
                  LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
                  DECLARE abgt510_hcl2 CURSOR FROM g_sql                 # LOCK CURSOR
                  OPEN abgt510_hcl2 USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
                                         g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006
                  IF STATUS THEN
                     CLOSE abgt510_hcl2
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN abgt510_hcl2:" 
                     LET g_errparam.code   = STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     RETURN
                  END IF
               ELSE               
                  IF STATUS THEN
                     CLOSE abgt510_hcl
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN abgt510_hcl:" 
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
               AND g_bgeg_d[l_ac].bgeg008 IS NOT NULL
               AND g_bgeg_d[l_ac].bgeg010 IS NOT NULL
               AND g_bgeg_d[l_ac].bgegseq IS NOT NULL
               AND ((g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 IS NOT NULL) OR (g_bgaw2[1]='Y' AND g_bgeg_d[l_ac].bgeg007 IS NOT NULL))
               AND ((g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 IS NOT NULL) OR (g_bgaw2[2]='Y' AND g_bgeg_d[l_ac].bgeg009 IS NOT NULL))
            THEN
               LET l_cmd='u'
               LET g_bgeg_d_t.* = g_bgeg_d[l_ac].*  #BACKUP
               LET g_bgeg_d_o.* = g_bgeg_d[l_ac].*  #BACKUP
               CALL abgt510_set_entry_b(l_cmd)
               CALL abgt510_set_no_entry_b(l_cmd)
               
               #预算组织在单头
               IF g_bgaw1[1] = 'Y' THEN
                  LET l_bgeg007 = g_bgeg_m.bgeg007
               ELSE
                  LET l_bgeg007 = g_bgeg_d_t.bgeg007
               END IF
               
               #预算料号在单头
               IF g_bgaw1[2] = 'Y' THEN
                  LET l_bgeg009 = g_bgeg_m.bgeg009
               ELSE
                  LET l_bgeg009 = g_bgeg_d_t.bgeg009
               END IF
            
               OPEN abgt510_bcl USING g_enterprise,g_bgeg_m.bgeg001,
                                                g_bgeg_m.bgeg002,
                                                g_bgeg_m.bgeg003,
                                                g_bgeg_m.bgeg004,
                                                g_bgeg_m.bgeg005,
                                                g_bgeg_m.bgeg006,
                                                l_bgeg007,
                                                l_bgeg009,
                                                g_bgeg_d_t.bgeg010,
                                                g_bgeg_d_t.bgegseq
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt510_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt510_bcl INTO g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010,g_bgeg_d[l_ac].bgeg007, 
                      g_bgeg_d[l_ac].bgeg009,g_bgeg_d[l_ac].bgeg049,g_bgeg_d[l_ac].bgeg012,g_bgeg_d[l_ac].bgeg013, 
                      g_bgeg_d[l_ac].bgeg014,g_bgeg_d[l_ac].bgeg015,g_bgeg_d[l_ac].bgeg016,g_bgeg_d[l_ac].bgeg017, 
                      g_bgeg_d[l_ac].bgeg018,g_bgeg_d[l_ac].bgeg019,g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021, 
                      g_bgeg_d[l_ac].bgeg022,g_bgeg_d[l_ac].bgeg023,g_bgeg_d[l_ac].bgeg024,g_bgeg_d[l_ac].bgeg035, 
                      g_bgeg_d[l_ac].bgeg036,g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100,#g_bgeg_d[l_ac].bgeg101, #161220-00036#1 mark bgeg101
                      g_bgeg_d[l_ac].bgeg008,g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048,g_bgeg_d[l_ac].bgeg050,
                      g_bgeg2_d[l_ac].bgegseq,g_bgeg2_d[l_ac].bgegownid,g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid, 
                      g_bgeg2_d[l_ac].bgegcrtdp,g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid, 
                      g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt, 
                      g_bgeg3_d[l_ac].bgegseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgeg_d_t.bgeg008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgeg_d_mask_o[l_ac].* =  g_bgeg_d[l_ac].*
                  CALL abgt510_bgeg_t_mask()
                  LET g_bgeg_d_mask_n[l_ac].* =  g_bgeg_d[l_ac].*
                  
                  CALL abgt510_ref_show()
                  CALL cl_show_fld_cont()
                  
                  #设置单头启用核算项
                  CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg049)
                  #设置单身启用核算项
                  CALL abgt510_set_detail_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg049)
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            #end add-point  
            
 
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bgeg_d_t.* TO NULL
            INITIALIZE g_bgeg_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgeg_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgeg2_d[l_ac].bgegownid = g_user
      LET g_bgeg2_d[l_ac].bgegowndp = g_dept
      LET g_bgeg2_d[l_ac].bgegcrtid = g_user
      LET g_bgeg2_d[l_ac].bgegcrtdp = g_dept 
      LET g_bgeg2_d[l_ac].bgegcrtdt = cl_get_current()
      LET g_bgeg2_d[l_ac].bgegmodid = g_user
      LET g_bgeg2_d[l_ac].bgegmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_bgeg_d[l_ac].num1 = "0"
      LET g_bgeg_d[l_ac].price1 = "0"
      LET g_bgeg_d[l_ac].amt1 = "0"
      LET g_bgeg_d[l_ac].num2 = "0"
      LET g_bgeg_d[l_ac].price2 = "0"
      LET g_bgeg_d[l_ac].amt2 = "0"
      LET g_bgeg_d[l_ac].num3 = "0"
      LET g_bgeg_d[l_ac].price3 = "0"
      LET g_bgeg_d[l_ac].amt3 = "0"
      LET g_bgeg_d[l_ac].num4 = "0"
      LET g_bgeg_d[l_ac].price4 = "0"
      LET g_bgeg_d[l_ac].amt4 = "0"
      LET g_bgeg_d[l_ac].num5 = "0"
      LET g_bgeg_d[l_ac].price5 = "0"
      LET g_bgeg_d[l_ac].amt5 = "0"
      LET g_bgeg_d[l_ac].num6 = "0"
      LET g_bgeg_d[l_ac].price6 = "0"
      LET g_bgeg_d[l_ac].amt6 = "0"
      LET g_bgeg_d[l_ac].num7 = "0"
      LET g_bgeg_d[l_ac].price7 = "0"
      LET g_bgeg_d[l_ac].amt7 = "0"
      LET g_bgeg_d[l_ac].num8 = "0"
      LET g_bgeg_d[l_ac].price8 = "0"
      LET g_bgeg_d[l_ac].amt8 = "0"
      LET g_bgeg_d[l_ac].num9 = "0"
      LET g_bgeg_d[l_ac].price9 = "0"
      LET g_bgeg_d[l_ac].amt9 = "0"
      LET g_bgeg_d[l_ac].num10 = "0"
      LET g_bgeg_d[l_ac].price10 = "0"
      LET g_bgeg_d[l_ac].amt10 = "0"
      LET g_bgeg_d[l_ac].num11 = "0"
      LET g_bgeg_d[l_ac].price11 = "0"
      LET g_bgeg_d[l_ac].amt11 = "0"
      LET g_bgeg_d[l_ac].num12 = "0"
      LET g_bgeg_d[l_ac].price12 = "0"
      LET g_bgeg_d[l_ac].amt12 = "0"
      LET g_bgeg_d[l_ac].num13 = "0"
      LET g_bgeg_d[l_ac].price13 = "0"
      LET g_bgeg_d[l_ac].amt13 = "0"
      LET g_bgeg_d[l_ac].bgeg008 = "0"
      LET g_bgeg_d[l_ac].bgeg050 = "2"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_bgeg_d_t.* = g_bgeg_d[l_ac].*     #新輸入資料
            LET g_bgeg_d_o.* = g_bgeg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt510_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgt510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgeg_d[li_reproduce_target].* = g_bgeg_d[li_reproduce].*
               LET g_bgeg2_d[li_reproduce_target].* = g_bgeg2_d[li_reproduce].*
               LET g_bgeg3_d[li_reproduce_target].* = g_bgeg3_d[li_reproduce].*
 
               LET g_bgeg_d[g_bgeg_d.getLength()].bgeg008 = NULL
               LET g_bgeg_d[g_bgeg_d.getLength()].bgegseq = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #项次
            IF g_bgeg_d[l_ac].bgegseq IS NULL OR g_bgeg_d[l_ac].bgegseq = 0 THEN
               LET l_sql = "SELECT MAX(bgegseq)+1 FROM bgeg_t ",
                           " WHERE bgegent=",g_enterprise,
                           "   AND bgeg001='",g_bgeg_m.bgeg001,"'",
                           "   AND bgeg002='",g_bgeg_m.bgeg002,"'",
                           "   AND bgeg003='",g_bgeg_m.bgeg003,"'",
                           "   AND bgeg004='",g_bgeg_m.bgeg004,"'",
                           "   AND bgeg005='",g_bgeg_m.bgeg005,"'",
                           "   AND bgeg006='",g_bgeg_m.bgeg006,"'"
               #预算组织在单头
               IF g_bgaw1[1] = 'Y' THEN
                  LET l_sql = l_sql," AND bgeg007='",g_bgeg_m.bgeg007,"'"
               END IF
               #预算料号在单头
               IF g_bgaw1[2] = 'Y' THEN
                  LET l_sql = l_sql," AND bgeg009='",g_bgeg_m.bgeg009,"'"
               END IF
               PREPARE abgt510_seq_pr FROM l_sql
               EXECUTE abgt510_seq_pr INTO g_bgeg_d[l_ac].bgegseq
               IF g_bgeg_d[l_ac].bgegseq IS NULL THEN
                  LET g_bgeg_d[l_ac].bgegseq = 1
               END IF
            END IF
            
            #交易币别、汇率
            LET g_bgeg_d[l_ac].bgeg100=g_bgeg_m.bgaa003
#            LET g_bgeg_d[l_ac].bgeg101=1 #161220-00036#1 marl
            
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               LET g_bgeg_d[l_ac].bgeg007 = g_bgeg_m.bgeg007
            END IF
            
            #上层组织
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
               SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
                WHERE bgaaent=g_enterprise AND bgaa001=g_bgeg_m.bgeg002
               IF cl_null(l_bgaa010) THEN
                  LET g_bgeg_d[l_ac].bgeg047 = g_bgeg_d[l_ac].bgeg007
               ELSE
                  SELECT ooed005 INTO g_bgeg_d[l_ac].bgeg047 FROM ooed_t
                   WHERE ooedent=g_enterprise AND ooed001='4'
                     AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                     AND ooed004=g_bgeg_d[l_ac].bgeg007
                  IF cl_null(g_bgeg_d[l_ac].bgeg047) THEN
                     LET g_bgeg_d[l_ac].bgeg047 = g_bgeg_d[l_ac].bgeg007
                  END IF
               END IF
            END IF
            
            #预算料号在单头
            IF g_bgaw1[2] = 'Y' THEN
               LET g_bgeg_d[l_ac].bgeg009 = g_bgeg_m.bgeg009
               LET g_bgeg_d[l_ac].bgeg049 = g_bgeg_m.bgeg049
            END IF
            
            #稅别、含税否、销售单位
            #预算组织、预算料号都在单头
            IF g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' THEN
               LET l_bgea017 = ''
               SELECT bgea018,bgea016,bgea017,bgea019 
                  INTO g_bgeg_d[l_ac].bgeg035,g_bgeg_d[l_ac].bgeg037,l_bgea017,g_bgeg_d[l_ac].bgeg100
                  FROM bgea_t
                 WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_m.bgeg009
                   AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_m.bgeg007
               IF NOT cl_null(l_bgea017) AND 
                  ((g_bgaw2[6]='Y' AND g_bgal.bgal008='Y') OR (g_bgaw2[7]='Y' AND g_bgal.bgal009='Y')) THEN
                  #检核料号带出的交易客商是否正确,若正确的复制给交易客商
                  CALL s_abg2_bgap001_chk_1(l_bgea017,g_bgeg_m.bgeg007)
                  IF cl_null(g_errno) THEN
                     #收付款客商
                     IF g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' THEN
                        LET g_bgeg_d[l_ac].bgeg016 = l_bgea017
                        CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg016) RETURNING g_bgeg_d[l_ac].bgeg016_desc
                        LET g_bgeg_d[l_ac].bgeg016_desc = g_bgeg_d[l_ac].bgeg016," ",g_bgeg_d[l_ac].bgeg016_desc
                     END IF
                     #账款客商
                     IF g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' THEN
                        LET g_bgeg_d[l_ac].bgeg017 = l_bgea017
                        CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg017) RETURNING g_bgeg_d[l_ac].bgeg017_desc
                        LET g_bgeg_d[l_ac].bgeg017_desc = g_bgeg_d[l_ac].bgeg017," ",g_bgeg_d[l_ac].bgeg017_desc
                     END IF
                  END IF
               END IF
               
               IF NOT cl_null(g_bgeg_d[l_ac].bgeg035) THEN
                  SELECT oodb005 INTO g_bgeg_d[l_ac].bgeg036 FROM oodb_t
                   WHERE oodbent=g_enterprise AND oodb002=g_bgeg_d[l_ac].bgeg035
                     AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgeg_m.bgeg007)
               END IF
#               CALL s_abg_get_bg_rate(g_bgeg_m.bgeg002,g_today,g_bgeg_d[l_ac].bgeg100,g_bgeg_m.bgaa003) RETURNING g_bgeg_d[l_ac].bgeg101 #161220-00036#1 mark
            
               #设置单身启用核算项
               CALL abgt510_set_detail_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_m.bgeg007,g_bgeg_m.bgeg049)
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
            SELECT COUNT(1) INTO l_count FROM bgeg_t 
             WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg_m.bgeg001
               AND bgeg002 = g_bgeg_m.bgeg002
               AND bgeg003 = g_bgeg_m.bgeg003
               AND bgeg004 = g_bgeg_m.bgeg004
               AND bgeg005 = g_bgeg_m.bgeg005
               AND bgeg006 = g_bgeg_m.bgeg006
               AND bgeg007 = g_bgeg_m.bgeg007
               AND bgeg009 = g_bgeg_m.bgeg009
               AND bgeg010 = g_bgeg_m.bgeg010
 
               AND bgeg008 = g_bgeg_d[l_ac].bgeg008
               AND bgegseq = g_bgeg_d[l_ac].bgegseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO bgeg_t
                           (bgegent,
                            bgeg002,bgeg003,bgeg004,bgeg011,bgeg001,bgeg005,bgeg006,bgeg010,bgegstus,bgeg007,bgeg013,bgeg016,bgeg019,bgeg022,bgeg009,bgeg014,bgeg017,bgeg020,bgeg023,bgeg012,bgeg015,bgeg018,bgeg021,bgeg024,bgeg049,
                            bgeg008,bgegseq
                            ,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037,bgeg100,bgeg047,bgeg048,bgeg050,bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt) 
                     VALUES(g_enterprise,
                            g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019,g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023,g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg049,
                            g_bgeg_d[l_ac].bgeg008,g_bgeg_d[l_ac].bgegseq
                            ,g_bgeg_d[l_ac].bgeg049,g_bgeg_d[l_ac].bgeg012,g_bgeg_d[l_ac].bgeg013,g_bgeg_d[l_ac].bgeg014, 
                                g_bgeg_d[l_ac].bgeg015,g_bgeg_d[l_ac].bgeg016,g_bgeg_d[l_ac].bgeg017, 
                                g_bgeg_d[l_ac].bgeg018,g_bgeg_d[l_ac].bgeg019,g_bgeg_d[l_ac].bgeg020, 
                                g_bgeg_d[l_ac].bgeg021,g_bgeg_d[l_ac].bgeg022,g_bgeg_d[l_ac].bgeg023, 
                                g_bgeg_d[l_ac].bgeg024,g_bgeg_d[l_ac].bgeg035,g_bgeg_d[l_ac].bgeg036, 
                                g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg047, 
                                g_bgeg_d[l_ac].bgeg048,g_bgeg_d[l_ac].bgeg050,g_bgeg2_d[l_ac].bgegownid, 
                                g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid,g_bgeg2_d[l_ac].bgegcrtdp, 
                                g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid,g_bgeg2_d[l_ac].bgegmoddt, 
                                g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgeg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
            #组合key bgeg010
            CALL abgt510_get_bgeg010()
            
            #预算组织在单头
            IF g_bgaw1[1]='Y' THEN 
               LET l_bgeg007 = g_bgeg_m.bgeg007
            ELSE
               LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
            END IF
            #预算料号在单头
            IF g_bgaw1[2]='Y' THEN 
               LET l_bgeg009 = g_bgeg_m.bgeg009
            ELSE
               LET l_bgeg009 = g_bgeg_d[l_ac].bgeg009
            END IF
            CALL s_abgt510_detail_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                          g_bgeg_m.bgeg006,l_bgeg007,l_bgeg009,g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010)
            RETURNING l_success
            IF l_success = FALSE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00004'
               LET g_errparam.extend =g_bgeg_d[l_ac].bgegseq
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD bgegseq
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bgeg_t 
             WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg_m.bgeg001
               AND bgeg002 = g_bgeg_m.bgeg002
               AND bgeg003 = g_bgeg_m.bgeg003
               AND bgeg004 = g_bgeg_m.bgeg004
               AND bgeg005 = g_bgeg_m.bgeg005
               AND bgeg006 = g_bgeg_m.bgeg006
               AND bgeg007 = l_bgeg007
               AND bgeg009 = l_bgeg009
               AND bgeg010 = g_bgeg_d[l_ac].bgeg010
               AND bgegseq = g_bgeg_d[l_ac].bgegseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #插入数据库
               CALL abgt510_insert_bgeg() RETURNING l_success

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
               INITIALIZE g_bgeg_d[l_ac].* TO NULL
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
               IF abgt510_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bgeg_m.bgeg001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg002
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg003
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg004
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg005
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg006
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg007
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg009
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_m.bgeg010
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_d_t.bgeg008
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeg_d_t.bgegseq
 
 
                  #刪除下層單身
                  IF NOT abgt510_key_delete_b(gs_keys,'bgeg_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgt510_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgt510_bcl
               LET l_count = g_bgeg_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgeg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgegseq
            #add-point:BEFORE FIELD bgegseq name="input.b.page1.bgegseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgegseq
            
            #add-point:AFTER FIELD bgegseq name="input.a.page1.bgegseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  g_bgeg_m.bgeg001 IS NOT NULL AND g_bgeg_m.bgeg002 IS NOT NULL AND g_bgeg_m.bgeg003 IS NOT NULL AND g_bgeg_m.bgeg004 IS NOT NULL AND g_bgeg_m.bgeg005 IS NOT NULL AND g_bgeg_m.bgeg006 IS NOT NULL AND g_bgeg_m.bgeg007 IS NOT NULL AND g_bgeg_m.bgeg009 IS NOT NULL AND g_bgeg_d[g_detail_idx].bgeg008 IS NOT NULL AND g_bgeg_d[g_detail_idx].bgeg010 IS NOT NULL AND g_bgeg_d[g_detail_idx].bgegseq IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t OR g_bgeg_m.bgeg002 != g_bgeg002_t OR g_bgeg_m.bgeg003 != g_bgeg003_t OR g_bgeg_m.bgeg004 != g_bgeg004_t OR g_bgeg_m.bgeg005 != g_bgeg005_t OR g_bgeg_m.bgeg006 != g_bgeg006_t OR g_bgeg_m.bgeg007 != g_bgeg007_t OR g_bgeg_m.bgeg009 != g_bgeg009_t OR g_bgeg_d[g_detail_idx].bgeg008 != g_bgeg_d_t.bgeg008 OR g_bgeg_d[g_detail_idx].bgeg010 != g_bgeg_d_t.bgeg010 OR g_bgeg_d[g_detail_idx].bgegseq != g_bgeg_d_t.bgegseq)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgeg_t WHERE "||"bgegent = " ||g_enterprise|| " AND "||"bgeg001 = '"||g_bgeg_m.bgeg001 ||"' AND "|| "bgeg002 = '"||g_bgeg_m.bgeg002 ||"' AND "|| "bgeg003 = '"||g_bgeg_m.bgeg003 ||"' AND "|| "bgeg004 = '"||g_bgeg_m.bgeg004 ||"' AND "|| "bgeg005 = '"||g_bgeg_m.bgeg005 ||"' AND "|| "bgeg006 = '"||g_bgeg_m.bgeg006 ||"' AND "|| "bgeg007 = '"||g_bgeg_m.bgeg007 ||"' AND "|| "bgeg009 = '"||g_bgeg_m.bgeg009 ||"' AND "|| "bgeg008 = '"||g_bgeg_d[g_detail_idx].bgeg008 ||"' AND "|| "bgeg010 = '"||g_bgeg_d[g_detail_idx].bgeg010 ||"' AND "|| "bgegseq = '"||g_bgeg_d[g_detail_idx].bgegseq ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #主鍵檢查
            IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
               AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
               AND NOT cl_null(g_bgeg_d[l_ac].bgegseq)
               AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg007)))
               AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg009)))
            THEN 
               IF p_cmd = 'a' 
               OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                  OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                  OR ((g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t ) OR (g_bgaw2[1]='Y' AND g_bgeg_d[l_ac].bgeg007!=g_bgeg_d_t.bgeg007))
                                  OR ((g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t ) OR (g_bgaw2[2]='Y' AND g_bgeg_d[l_ac].bgeg009!=g_bgeg_d_t.bgeg009)) 
                                  )
               ) THEN 
                  #组合key bgeg010
                  CALL abgt510_get_bgeg010()
                  
                  #预算组织在单头
                  IF g_bgaw1[1]='Y' THEN 
                     LET l_bgeg007 = g_bgeg_m.bgeg007
                  ELSE
                     LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
                  END IF
                  #预算料号在单头
                  IF g_bgaw1[2]='Y' THEN 
                     LET l_bgeg009 = g_bgeg_m.bgeg009
                  ELSE
                     LET l_bgeg009 = g_bgeg_d[l_ac].bgeg009
                  END IF
                  
                  CALL s_abgt510_detail_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                g_bgeg_m.bgeg006,l_bgeg007,l_bgeg009,g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgegseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgegseq = g_bgeg_d_t.bgegseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgegseq
            #add-point:ON CHANGE bgegseq name="input.g.page1.bgegseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg010_2
            #add-point:BEFORE FIELD bgeg010_2 name="input.b.page1.bgeg010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg010_2
            
            #add-point:AFTER FIELD bgeg010_2 name="input.a.page1.bgeg010_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg010_2
            #add-point:ON CHANGE bgeg010_2 name="input.g.page1.bgeg010_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg007_2
            #add-point:BEFORE FIELD bgeg007_2 name="input.b.page1.bgeg007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg007_2
            
            #add-point:AFTER FIELD bgeg007_2 name="input.a.page1.bgeg007_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg007_2
            #add-point:ON CHANGE bgeg007_2 name="input.g.page1.bgeg007_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg007_desc
            #add-point:BEFORE FIELD bgeg007_desc name="input.b.page1.bgeg007_desc"
            LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d[l_ac].bgeg007
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg007_desc
            
            #add-point:AFTER FIELD bgeg007_desc name="input.a.page1.bgeg007_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg007_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg007_desc <> g_bgeg_d_t.bgeg007 OR cl_null(g_bgeg_d_t.bgeg007))) THEN
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bgeg_d[l_ac].bgeg007_desc
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     #檢查失敗時後續處理
                     LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                     NEXT FIELD CURRENT
                  END IF
                 
                  #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_bgeg_d[l_ac].bgeg007_desc,'03')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgeg007_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                     NEXT FIELD CURRENT
                  END IF
                  
                  #检查预算编号+版本+预算管理组织+销售方式下预算组织或预算上层组织是否已存在汇总资料abgt520，如果存在，不可录入
                  IF NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) AND
                     NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) THEN
                     #预算组织是否存在汇总资料
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM bgeg_t
                      WHERE bgegent=g_enterprise AND bgeg001='30'
                        AND bgeg002=g_bgeg_m.bgeg002 AND bgeg003=g_bgeg_m.bgeg003
                        AND bgeg004=g_bgeg_m.bgeg004 AND bgeg005=g_bgeg_m.bgeg005
                        AND bgeg006='2' AND bgeg007 = g_bgeg_d[l_ac].bgeg007_desc
                        AND bgegstus<>'X'
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00231'
                        LET g_errparam.extend =g_bgeg_d[l_ac].bgeg007_desc
                        #161215-00014#2--mod--str--
#                        LET g_errparam.replace[1] = 'abgt520'
#                        LET g_errparam.replace[2] = cl_get_progname('abgt520',g_lang,"2")
                        LET g_errparam.replace[1] = cl_get_progname('abgt520',g_lang,"2")
                        #161215-00014#2--mod--end
                        LET g_errparam.exeprog = 'abgt520'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                        NEXT FIELD CURRENT
                     END IF
                     #预算组织的上层组织是否存在汇总资料
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgeg_m.bgeg002
                     #抓取上层组织
                     IF NOT cl_null(l_bgaa010) THEN
                        SELECT ooed005 INTO l_ooed005 FROM ooed_t
                          WHERE ooedent=g_enterprise AND ooed001='4'
                            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                            AND ooed004=g_bgeg_d[l_ac].bgeg007_desc
                        IF NOT cl_null(l_ooed005) THEN
                           LET l_cnt = 0
                           SELECT COUNT(1) INTO l_cnt FROM bgeg_t
                            WHERE bgegent=g_enterprise AND bgeg001='30'
                              AND bgeg002=g_bgeg_m.bgeg002 AND bgeg003=g_bgeg_m.bgeg003
                              AND bgeg004=g_bgeg_m.bgeg004 AND bgeg005=g_bgeg_m.bgeg005
                              AND bgeg006='2' AND bgeg007 = l_ooed005
                              AND bgegstus<>'X'
                           IF l_cnt > 0 THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'abg-00232'
                              LET g_errparam.extend =g_bgeg_d[l_ac].bgeg007_desc
                              #161215-00014#2--mod--str--
#                              LET g_errparam.replace[1] = 'abgt520'
#                              LET g_errparam.replace[2] = cl_get_progname('abgt520',g_lang,"2")
                              LET g_errparam.replace[1] = cl_get_progname('abgt520',g_lang,"2")
                              #161215-00014#2--mod--end
                              LET g_errparam.exeprog = 'abgt520'
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
                     AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
                     AND NOT cl_null(g_bgeg_d[l_ac].bgegseq)
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg007_desc)))
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg009)))
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                        OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                        OR ((g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t ) OR (g_bgaw2[1]='Y' AND g_bgeg_d[l_ac].bgeg007_desc!=g_bgeg_d_t.bgeg007 ))
                                        OR ((g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t ) OR (g_bgaw2[2]='Y' AND g_bgeg_d[l_ac].bgeg009!=g_bgeg_d_t.bgeg009)) 
                                        )
                     ) THEN
                        #组合key bgeg010
                        CALL abgt510_get_bgeg010()
                        
                        #预算料号在单头
                        IF g_bgaw1[2]='Y' THEN 
                           LET l_bgeg009 = g_bgeg_m.bgeg009
                        ELSE
                           LET l_bgeg009 = g_bgeg_d[l_ac].bgeg009
                        END IF
                        CALL s_abgt510_detail_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                      g_bgeg_m.bgeg006,g_bgeg_d[l_ac].bgeg007_desc,l_bgeg009,g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010)
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgeg_d[l_ac].bgeg007_desc
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #稅别、含税否、销售单位
                  #预算料号有值时，重新设置预设值及核算项启用
                  #预算料号在单头
                  LET l_bgea018 = ''
                  LET l_bgea016 = ''
                  LET l_bgea017 = ''
                  LET l_bgea019 = ''
                  LET l_bgea005 = ''
                  IF g_bgaw1[2] = 'Y' THEN
                     IF NOT cl_null(g_bgeg_m.bgeg009) THEN
                        SELECT bgea005,bgea018,bgea016,bgea017,bgea019 
                          INTO l_bgea005,l_bgea018,l_bgea016,l_bgea017,l_bgea019
                          FROM bgea_t
                         WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_m.bgeg009
                           AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_d[l_ac].bgeg007_desc
                        #161215-00014#2--add--str--
                        #该预算料号没有维护对应的预算细项！
                        IF cl_null(l_bgea005) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abg-00204'
                           LET g_errparam.extend =g_bgeg_d[l_ac].bgeg007_desc," + ",g_bgeg_m.bgeg009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                           NEXT FIELD CURRENT
                        END IF
                        #161215-00014#2--add--end
                        #预算细项权限检查abgi090
                        CALL s_abg2_bgai006_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,g_bgeg_d[l_ac].bgeg007_desc,'03',l_bgea005)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend =l_bgea005
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                           NEXT FIELD CURRENT
                        END IF
                        LET g_bgeg_m.bgeg049 = l_bgea005
                        
                        #设置单头启用核算项
                        CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007_desc,g_bgeg_m.bgeg049)
                        #设置单身启用核算项
                        CALL abgt510_set_detail_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007_desc,g_bgeg_m.bgeg049)
                     END IF
                  ELSE      
                     #预算料在单身
                     IF NOT cl_null(g_bgeg_d[l_ac].bgeg009) THEN
                        SELECT bgea005,bgea018,bgea016,bgea017,bgea019 
                          INTO l_bgea005,l_bgea018,l_bgea016,l_bgea017,l_bgea019
                          FROM bgea_t
                         WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_d[l_ac].bgeg009
                           AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_d[l_ac].bgeg007_desc
                        #161215-00014#2--add--str--
                        #该预算料号没有维护对应的预算细项！
                        IF cl_null(l_bgea005) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abg-00204'
                           LET g_errparam.extend =g_bgeg_d[l_ac].bgeg007_desc," + ",g_bgeg_d[l_ac].bgeg009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                           NEXT FIELD CURRENT
                        END IF
                        #161215-00014#2--add--end
                        #预算细项权限检查abgi090
                        CALL s_abg2_bgai006_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,g_bgeg_d[l_ac].bgeg007_desc,'03',l_bgea005)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend =l_bgea005
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d_t.bgeg007
                           NEXT FIELD CURRENT
                        END IF
                        LET g_bgeg_d[l_ac].bgeg049 = l_bgea005
                        
                        #设置单头启用核算项
                        CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007_desc,g_bgeg_d[l_ac].bgeg049)
                        #设置单身启用核算项
                        CALL abgt510_set_detail_hsx_entry(g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007_desc,g_bgeg_d[l_ac].bgeg049)
                     END IF
                  END IF
                  
                  #收付款客商、账款客商
                  IF NOT cl_null(l_bgea017) THEN
                     IF (g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_d[l_ac].bgeg016) ) OR 
                        (g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_d[l_ac].bgeg017) )THEN
                        #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                        CALL s_abg2_bgap001_chk_1(l_bgea017,g_bgeg_d[l_ac].bgeg007_desc)
                        IF cl_null(g_errno) THEN
                           #收付款客商
                           IF g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_d[l_ac].bgeg016) THEN
                              LET g_bgeg_d[l_ac].bgeg016 = l_bgea017
                              CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg016) RETURNING g_bgeg_d[l_ac].bgeg016_desc
                              LET g_bgeg_d[l_ac].bgeg016_desc = g_bgeg_d[l_ac].bgeg016," ",g_bgeg_d[l_ac].bgeg016_desc
                           END IF
                           #账款客商
                           IF g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_d[l_ac].bgeg017) THEN
                              LET g_bgeg_d[l_ac].bgeg017 = l_bgea017
                              CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg017) RETURNING g_bgeg_d[l_ac].bgeg017_desc
                              LET g_bgeg_d[l_ac].bgeg017_desc = g_bgeg_d[l_ac].bgeg017," ",g_bgeg_d[l_ac].bgeg017_desc
                           END IF
                        END IF
                     END IF
                  END IF
                  
                  #稅别、含税否
                  IF NOT cl_null(l_bgea018) AND cl_null(g_bgeg_d[l_ac].bgeg035) THEN
                     LET g_bgeg_d[l_ac].bgeg035 = l_bgea018
                     SELECT oodb005 INTO g_bgeg_d[l_ac].bgeg036 FROM oodb_t
                      WHERE oodbent=g_enterprise AND oodb002=g_bgeg_d[l_ac].bgeg035
                        AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgeg_d[l_ac].bgeg007_desc)
                  END IF
                  
                  #销售单位
                  IF NOT cl_null(l_bgea016) AND cl_null(g_bgeg_d[l_ac].bgeg037) THEN
                     LET g_bgeg_d[l_ac].bgeg037 = l_bgea016
                  END IF
                  
                  #币别、汇率
                  IF NOT cl_null(l_bgea019) AND cl_null(g_bgeg_d[l_ac].bgeg100) THEN
                     LET g_bgeg_d[l_ac].bgeg100 = l_bgea019
#                     CALL s_abg_get_bg_rate(g_bgeg_m.bgeg002,g_today,g_bgeg_d[l_ac].bgeg100,g_bgeg_m.bgaa003) RETURNING g_bgeg_d[l_ac].bgeg101 #161220-00036#1 mark
                  END IF
                  
                  #上层组织
                  IF NOT cl_null(g_bgeg_d[l_ac].bgeg007_desc) THEN
                     SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bgeg_m.bgeg002
                     IF cl_null(l_bgaa010) THEN
                        LET g_bgeg_d[l_ac].bgeg047 = g_bgeg_d[l_ac].bgeg007_desc
                     ELSE
                        SELECT ooed005 INTO g_bgeg_d[l_ac].bgeg047 FROM ooed_t
                         WHERE ooedent=g_enterprise AND ooed001='4'
                           AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
                           AND ooed004=g_bgeg_d[l_ac].bgeg007_desc
                        IF cl_null(g_bgeg_d[l_ac].bgeg047) THEN
                           LET g_bgeg_d[l_ac].bgeg047 = g_bgeg_d[l_ac].bgeg007_desc
                        END IF
                     END IF
                  END IF
               END IF
               LET g_bgeg_d[l_ac].bgeg007 = g_bgeg_d[l_ac].bgeg007_desc
               CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg007) RETURNING g_bgeg_d[l_ac].bgeg007_desc
               LET g_bgeg_d[l_ac].bgeg007_desc = g_bgeg_d[l_ac].bgeg007,"  ",g_bgeg_d[l_ac].bgeg007_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg007 = g_bgeg_d[l_ac].bgeg007_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg007_desc
            #add-point:ON CHANGE bgeg007_desc name="input.g.page1.bgeg007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg009_2
            #add-point:BEFORE FIELD bgeg009_2 name="input.b.page1.bgeg009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg009_2
            
            #add-point:AFTER FIELD bgeg009_2 name="input.a.page1.bgeg009_2"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg009_2
            #add-point:ON CHANGE bgeg009_2 name="input.g.page1.bgeg009_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg009_desc
            #add-point:BEFORE FIELD bgeg009_desc name="input.b.page1.bgeg009_desc"
            LET g_bgeg_d[l_ac].bgeg009_desc = g_bgeg_d[l_ac].bgeg009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg009_desc
            
            #add-point:AFTER FIELD bgeg009_desc name="input.a.page1.bgeg009_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg009_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg009_desc <> g_bgeg_d_t.bgeg009 OR cl_null(g_bgeg_d_t.bgeg009))) THEN
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt510_bgeg009_chk(g_bgeg_m.bgeg005,g_bgeg_d[l_ac].bgeg009_desc,g_bgeg_m.bgeg002,g_bgeg_m.bgeg007)
                  ELSE
                  #预算组织在单身
                     CALL s_abgt510_bgeg009_chk(g_bgeg_m.bgeg005,g_bgeg_d[l_ac].bgeg009_desc,g_bgeg_m.bgeg002,g_bgeg_d[l_ac].bgeg007)
                  END IF 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgeg009_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg009_desc = g_bgeg_d_t.bgeg009
                     NEXT FIELD CURRENT
                  END IF
               
                  #主鍵檢查
                  IF NOT cl_null(g_bgeg_m.bgeg001) AND NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg003) 
                     AND NOT cl_null(g_bgeg_m.bgeg004) AND NOT cl_null(g_bgeg_m.bgeg005) AND NOT cl_null(g_bgeg_m.bgeg006) 
                     AND NOT cl_null(g_bgeg_d[l_ac].bgegseq)
                     AND ((g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007)) OR (g_bgaw2[1]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg007)))
                     AND ((g_bgaw1[2]='Y' AND NOT cl_null(g_bgeg_m.bgeg009)) OR (g_bgaw2[2]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg009_desc)))
                  THEN 
                     IF p_cmd = 'a' 
                     OR ( p_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t 
                                        OR g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t 
                                        OR ((g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t ) OR (g_bgaw2[1]='Y' AND g_bgeg_d[l_ac].bgeg007!=g_bgeg_d_t.bgeg007 ))
                                        OR ((g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t ) OR (g_bgaw2[2]='Y' AND g_bgeg_d[l_ac].bgeg009_desc!=g_bgeg_d_t.bgeg009)) 
                                        )
                     ) THEN 
                        #组合key bgeg010
                        CALL abgt510_get_bgeg010()
                  
                        #预算组织在单头
                        IF g_bgaw1[1]='Y' THEN 
                           LET l_bgeg007 = g_bgeg_m.bgeg007
                        ELSE
                           LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
                        END IF
                        
                        CALL s_abgt510_detail_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                      g_bgeg_m.bgeg006,l_bgeg007,g_bgeg_d[l_ac].bgeg009_desc,g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010)
                        RETURNING l_success
                        IF l_success = FALSE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'std-00004'
                           LET g_errparam.extend =g_bgeg_d[l_ac].bgeg009_desc
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgeg_d[l_ac].bgeg009_desc = g_bgeg_d_t.bgeg009
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               
                  #对应预算细项 #稅别、含税否、销售单位
                  #采购来源1.外部采购单
                  LET l_bgea018 = ''
                  LET l_bgea016 = ''
                  LET l_bgea017 = ''
                  LET l_bgea019 = ''
                  LET l_bgea005 = ''
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     IF NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_m.bgeg007) THEN
                        SELECT bgea005,bgea018,bgea016,bgea017,bgea019
                          INTO l_bgea005,l_bgea018,l_bgea016,l_bgea017,l_bgea019
                          FROM bgea_t
                         WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_d[l_ac].bgeg009_desc
                           AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_m.bgeg007
                     END IF
                  ELSE
                  #预算组织在单身
                     IF NOT cl_null(g_bgeg_m.bgeg002) AND NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
                        SELECT bgea005,bgea018,bgea016,bgea017,bgea019
                          INTO l_bgea005,l_bgea018,l_bgea016,l_bgea017,l_bgea019
                          FROM bgea_t
                         WHERE bgeaent=g_enterprise AND bgea003=g_bgeg_d[l_ac].bgeg009_desc
                           AND bgea001=g_bgeg_m.bgeg002 AND bgea002=g_bgeg_d[l_ac].bgeg007
                     END IF
                  END IF
                  
                  #设置核算项可可录入否
                  #预算组织在单头
                  IF g_bgaw1[1]='Y' THEN 
                     LET l_bgeg007 = g_bgeg_m.bgeg007
                  ELSE
                     LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
                  END IF
                  #预算细项权限检查abgi090
                  CALL s_abg2_bgai006_chk(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,l_bgeg007,'03',l_bgea005)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =l_bgea005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg009_desc = g_bgeg_d_t.bgeg009
                     NEXT FIELD CURRENT
                  END IF
                  LET g_bgeg_d[l_ac].bgeg049 = l_bgea005
                        
                  #设置单头启用核算项
                  CALL abgt510_set_head_hsx_entry(g_bgeg_m.bgeg002,l_bgeg007,g_bgeg_d[l_ac].bgeg049)
                  #设置单身启用核算项
                  CALL abgt510_set_detail_hsx_entry(g_bgeg_m.bgeg002,l_bgeg007,g_bgeg_d[l_ac].bgeg049) 
                  
                  #收付款客商、账款客商
                  IF NOT cl_null(l_bgea017) THEN
                     IF (g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_d[l_ac].bgeg016) ) OR 
                        (g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_d[l_ac].bgeg017) )THEN
                        #检核料号带出的交易客商是否正确，若正确的复制给交易客商
                        CALL s_abg2_bgap001_chk_1(l_bgea017,g_bgeg_d[l_ac].bgeg007)
                        IF cl_null(g_errno) THEN
                           #收付款客商
                           IF g_bgaw2[6]='Y' AND g_bgal.bgal008='Y' AND cl_null(g_bgeg_d[l_ac].bgeg016) THEN
                              LET g_bgeg_d[l_ac].bgeg016 = l_bgea017
                              CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg016) RETURNING g_bgeg_d[l_ac].bgeg016_desc
                              LET g_bgeg_d[l_ac].bgeg016_desc = g_bgeg_d[l_ac].bgeg016," ",g_bgeg_d[l_ac].bgeg016_desc
                           END IF
                           #账款客商
                           IF g_bgaw2[7]='Y' AND g_bgal.bgal009='Y' AND cl_null(g_bgeg_d[l_ac].bgeg017) THEN
                              LET g_bgeg_d[l_ac].bgeg017 = l_bgea017
                              CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg017) RETURNING g_bgeg_d[l_ac].bgeg017_desc
                              LET g_bgeg_d[l_ac].bgeg017_desc = g_bgeg_d[l_ac].bgeg017," ",g_bgeg_d[l_ac].bgeg017_desc
                           END IF
                        END IF
                     END IF
                  END IF
                  
                  #稅别、含税否
                  IF NOT cl_null(l_bgea018) AND cl_null(g_bgeg_d[l_ac].bgeg035) THEN
                     LET g_bgeg_d[l_ac].bgeg035 = l_bgea018
                     SELECT oodb005 INTO g_bgeg_d[l_ac].bgeg036 FROM oodb_t
                      WHERE oodbent=g_enterprise AND oodb002=g_bgeg_d[l_ac].bgeg035
                        AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgeg_d[l_ac].bgeg007)
                  END IF
                  
                  #销售单位
                  IF NOT cl_null(l_bgea016) AND cl_null(g_bgeg_d[l_ac].bgeg037) THEN
                     LET g_bgeg_d[l_ac].bgeg037 = l_bgea016
                  END IF
                  
                  #币别、汇率
                  IF NOT cl_null(l_bgea019) AND cl_null(g_bgeg_d[l_ac].bgeg100) THEN
                     LET g_bgeg_d[l_ac].bgeg100 = l_bgea019
#                     CALL s_abg_get_bg_rate(g_bgeg_m.bgeg002,g_today,g_bgeg_d[l_ac].bgeg100,g_bgeg_m.bgaa003) RETURNING g_bgeg_d[l_ac].bgeg101 #161220-00036#1 mark
                  END IF              
               END IF 
               LET g_bgeg_d[l_ac].bgeg009 = g_bgeg_d[l_ac].bgeg009_desc
               #采购来源1.外部采购单,抓取料件的品名规格
               CALL s_desc_get_bgas001_desc(g_bgeg_d[l_ac].bgeg009) RETURNING l_bgasl003,l_bgasl004
               LET g_bgeg_d[l_ac].bgeg009_desc = g_bgeg_d[l_ac].bgeg009,"  ",l_bgasl003,"  ",l_bgasl004
            ELSE
               LET g_bgeg_d[l_ac].bgeg009 = g_bgeg_d[l_ac].bgeg009_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg009_desc
            #add-point:ON CHANGE bgeg009_desc name="input.g.page1.bgeg009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg049
            #add-point:BEFORE FIELD bgeg049 name="input.b.page1.bgeg049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg049
            
            #add-point:AFTER FIELD bgeg049 name="input.a.page1.bgeg049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg049
            #add-point:ON CHANGE bgeg049 name="input.g.page1.bgeg049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg012_2
            #add-point:BEFORE FIELD bgeg012_2 name="input.b.page1.bgeg012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg012_2
            
            #add-point:AFTER FIELD bgeg012_2 name="input.a.page1.bgeg012_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg012_2
            #add-point:ON CHANGE bgeg012_2 name="input.g.page1.bgeg012_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg012_desc
            #add-point:BEFORE FIELD bgeg012_desc name="input.b.page1.bgeg012_desc"
            LET g_bgeg_d[l_ac].bgeg012_desc = g_bgeg_d[l_ac].bgeg012
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg012_desc
            
            #add-point:AFTER FIELD bgeg012_desc name="input.a.page1.bgeg012_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg012_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg012_desc <> g_bgeg_d_t.bgeg012 OR cl_null(g_bgeg_d_t.bgeg012))) THEN
                  #员工基础资料检查
                  CALL s_employee_chk(g_bgeg_d[l_ac].bgeg012_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_d[l_ac].bgeg012_desc = g_bgeg_d_t.bgeg012
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，人员在单头时，人员归属据点归属法人必须等于g_site归属法人
                  #其他情况，人员归属据点归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(1,g_bgeg_d[l_ac].bgeg012_desc,g_bgeg_m.bgeg007)                  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(1,g_bgeg_d[l_ac].bgeg012_desc,g_bgeg_d[l_ac].bgeg007)
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgeg012_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg012_desc = g_bgeg_d_t.bgeg012
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_bgeg_d[l_ac].bgeg012 = g_bgeg_d[l_ac].bgeg012_desc
               CALL s_desc_get_person_desc(g_bgeg_d[l_ac].bgeg012) RETURNING g_bgeg_d[l_ac].bgeg012_desc
               LET g_bgeg_d[l_ac].bgeg012_desc = g_bgeg_d[l_ac].bgeg012,"  ",g_bgeg_d[l_ac].bgeg012_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg012 = g_bgeg_d[l_ac].bgeg012_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg012_desc
            #add-point:ON CHANGE bgeg012_desc name="input.g.page1.bgeg012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg013_2
            #add-point:BEFORE FIELD bgeg013_2 name="input.b.page1.bgeg013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg013_2
            
            #add-point:AFTER FIELD bgeg013_2 name="input.a.page1.bgeg013_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg013_2
            #add-point:ON CHANGE bgeg013_2 name="input.g.page1.bgeg013_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg013_desc
            #add-point:BEFORE FIELD bgeg013_desc name="input.b.page1.bgeg013_desc"
            LET g_bgeg_d[l_ac].bgeg013_desc = g_bgeg_d[l_ac].bgeg013
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg013_desc
            
            #add-point:AFTER FIELD bgeg013_desc name="input.a.page1.bgeg013_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg013_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg013_desc <> g_bgeg_d_t.bgeg013 OR cl_null(g_bgeg_d_t.bgeg013))) THEN
                  #部门基础资料检核
                  CALL s_department_chk(g_bgeg_d[l_ac].bgeg013_desc,g_today) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_d[l_ac].bgeg013_desc = g_bgeg_d_t.bgeg013
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(2,g_bgeg_d[l_ac].bgeg013_desc,g_bgeg_m.bgeg007)  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(2,g_bgeg_d[l_ac].bgeg013_desc,g_bgeg_d[l_ac].bgeg007) 
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgeg013_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg013_desc = g_bgeg_d_t.bgeg013
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #抓取部门对应利润中心
               IF g_bgaw2[4]='Y' AND cl_null(g_bgeg_d[l_ac].bgeg014) AND g_bgal.bgal006 = 'Y' THEN
                  SELECT ooeg004 INTO g_bgeg_d[l_ac].bgeg014 FROM ooeg_t
                   WHERE ooegent=g_enterprise AND ooeg001=g_bgeg_d[l_ac].bgeg013_desc
                  CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg014) RETURNING g_bgeg_d[l_ac].bgeg014_desc
                  LET g_bgeg_d[l_ac].bgeg014_desc = g_bgeg_d[l_ac].bgeg014,"  ",g_bgeg_d[l_ac].bgeg014_desc
               END IF
               LET g_bgeg_d[l_ac].bgeg013 = g_bgeg_d[l_ac].bgeg013_desc
               CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg013) RETURNING g_bgeg_d[l_ac].bgeg013_desc
               LET g_bgeg_d[l_ac].bgeg013_desc = g_bgeg_d[l_ac].bgeg013,"  ",g_bgeg_d[l_ac].bgeg013_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg013 = g_bgeg_d[l_ac].bgeg013_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg013_desc
            #add-point:ON CHANGE bgeg013_desc name="input.g.page1.bgeg013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg014_2
            #add-point:BEFORE FIELD bgeg014_2 name="input.b.page1.bgeg014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg014_2
            
            #add-point:AFTER FIELD bgeg014_2 name="input.a.page1.bgeg014_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg014_2
            #add-point:ON CHANGE bgeg014_2 name="input.g.page1.bgeg014_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg014_desc
            #add-point:BEFORE FIELD bgeg014_desc name="input.b.page1.bgeg014_desc"
            LET g_bgeg_d[l_ac].bgeg014_desc = g_bgeg_d[l_ac].bgeg014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg014_desc
            
            #add-point:AFTER FIELD bgeg014_desc name="input.a.page1.bgeg014_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg014_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg014_desc <> g_bgeg_d_t.bgeg014 OR cl_null(g_bgeg_d_t.bgeg014))) THEN
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bgeg_d[l_ac].bgeg014_desc,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg014_desc
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg014_desc = g_bgeg_d_t.bgeg014
                     NEXT FIELD CURRENT
                  END IF
                  
                  #当预算组织在单身，部门在单头时，部门归属法人必须等于g_site归属法人
                  #其他情况，部门归属法人必须等于预算组织归属法人
                  #预算组织在单头
                  IF g_bgaw1[1] = 'Y' THEN
                     CALL s_abgt340_comp_chk(2,g_bgeg_d[l_ac].bgeg014_desc,g_bgeg_m.bgeg007)                  
                  ELSE
                  #预算组织在单身
                     CALL s_abgt340_comp_chk(2,g_bgeg_d[l_ac].bgeg014_desc,g_bgeg_d[l_ac].bgeg007)
                  END IF  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgeg014_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg014_desc = g_bgeg_d_t.bgeg014
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg014 = g_bgeg_d[l_ac].bgeg014_desc
               CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg014) RETURNING g_bgeg_d[l_ac].bgeg014_desc
               LET g_bgeg_d[l_ac].bgeg014_desc = g_bgeg_d[l_ac].bgeg014,"  ",g_bgeg_d[l_ac].bgeg014_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg014 = g_bgeg_d[l_ac].bgeg014_desc
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg014_desc
            #add-point:ON CHANGE bgeg014_desc name="input.g.page1.bgeg014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg015_2
            #add-point:BEFORE FIELD bgeg015_2 name="input.b.page1.bgeg015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg015_2
            
            #add-point:AFTER FIELD bgeg015_2 name="input.a.page1.bgeg015_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg015_2
            #add-point:ON CHANGE bgeg015_2 name="input.g.page1.bgeg015_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg015_desc
            #add-point:BEFORE FIELD bgeg015_desc name="input.b.page1.bgeg015_desc"
            LET g_bgeg_d[l_ac].bgeg015_desc = g_bgeg_d[l_ac].bgeg015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg015_desc
            
            #add-point:AFTER FIELD bgeg015_desc name="input.a.page1.bgeg015_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg015_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg015_desc <> g_bgeg_d_t.bgeg015 OR cl_null(g_bgeg_d_t.bgeg015))) THEN
                  CALL s_azzi650_chk_exist('287',g_bgeg_d[l_ac].bgeg015_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_d[l_ac].bgeg015_desc = g_bgeg_d_t.bgeg015
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg015 = g_bgeg_d[l_ac].bgeg015_desc
               CALL s_desc_get_acc_desc('287',g_bgeg_d[l_ac].bgeg015) RETURNING g_bgeg_d[l_ac].bgeg015_desc
               LET g_bgeg_d[l_ac].bgeg015_desc = g_bgeg_d[l_ac].bgeg015,"  ",g_bgeg_d[l_ac].bgeg015_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg015 = g_bgeg_d[l_ac].bgeg015_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg015_desc
            #add-point:ON CHANGE bgeg015_desc name="input.g.page1.bgeg015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg016_2
            #add-point:BEFORE FIELD bgeg016_2 name="input.b.page1.bgeg016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg016_2
            
            #add-point:AFTER FIELD bgeg016_2 name="input.a.page1.bgeg016_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg016_2
            #add-point:ON CHANGE bgeg016_2 name="input.g.page1.bgeg016_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg016_desc
            #add-point:BEFORE FIELD bgeg016_desc name="input.b.page1.bgeg016_desc"
            LET g_bgeg_d[l_ac].bgeg016_desc = g_bgeg_d[l_ac].bgeg016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg016_desc
            
            #add-point:AFTER FIELD bgeg016_desc name="input.a.page1.bgeg016_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg016_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg016_desc <> g_bgeg_d_t.bgeg016 OR cl_null(g_bgeg_d_t.bgeg016))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgeg_d[l_ac].bgeg016_desc,g_bgeg_d[l_ac].bgeg007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg016_desc
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg016_desc = g_bgeg_d_t.bgeg016
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg016 = g_bgeg_d[l_ac].bgeg016_desc
               CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg016) RETURNING g_bgeg_d[l_ac].bgeg016_desc
               LET g_bgeg_d[l_ac].bgeg016_desc = g_bgeg_d[l_ac].bgeg016,"  ",g_bgeg_d[l_ac].bgeg016_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg016 = g_bgeg_d[l_ac].bgeg016_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg016_desc
            #add-point:ON CHANGE bgeg016_desc name="input.g.page1.bgeg016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg017_2
            #add-point:BEFORE FIELD bgeg017_2 name="input.b.page1.bgeg017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg017_2
            
            #add-point:AFTER FIELD bgeg017_2 name="input.a.page1.bgeg017_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg017_2
            #add-point:ON CHANGE bgeg017_2 name="input.g.page1.bgeg017_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg017_desc
            #add-point:BEFORE FIELD bgeg017_desc name="input.b.page1.bgeg017_desc"
            LET g_bgeg_d[l_ac].bgeg017_desc = g_bgeg_d[l_ac].bgeg017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg017_desc
            
            #add-point:AFTER FIELD bgeg017_desc name="input.a.page1.bgeg017_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg017_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg017_desc <> g_bgeg_d_t.bgeg017 OR cl_null(g_bgeg_d_t.bgeg017))) THEN
                  CALL s_abg2_bgap001_chk_1(g_bgeg_d[l_ac].bgeg017_desc,g_bgeg_d[l_ac].bgeg007)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg017_desc
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg017_desc = g_bgeg_d_t.bgeg017
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg017 = g_bgeg_d[l_ac].bgeg017_desc
               CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg017) RETURNING g_bgeg_d[l_ac].bgeg017_desc
               LET g_bgeg_d[l_ac].bgeg017_desc = g_bgeg_d[l_ac].bgeg017,"  ",g_bgeg_d[l_ac].bgeg017_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg017 = g_bgeg_d[l_ac].bgeg017_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg017_desc
            #add-point:ON CHANGE bgeg017_desc name="input.g.page1.bgeg017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg018_2
            #add-point:BEFORE FIELD bgeg018_2 name="input.b.page1.bgeg018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg018_2
            
            #add-point:AFTER FIELD bgeg018_2 name="input.a.page1.bgeg018_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg018_2
            #add-point:ON CHANGE bgeg018_2 name="input.g.page1.bgeg018_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg018_desc
            #add-point:BEFORE FIELD bgeg018_desc name="input.b.page1.bgeg018_desc"
            LET g_bgeg_d[l_ac].bgeg018_desc = g_bgeg_d[l_ac].bgeg018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg018_desc
            
            #add-point:AFTER FIELD bgeg018_desc name="input.a.page1.bgeg018_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg018_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg018_desc <> g_bgeg_d_t.bgeg018 OR cl_null(g_bgeg_d_t.bgeg018))) THEN
                  CALL s_azzi650_chk_exist('281',g_bgeg_d[l_ac].bgeg018_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_d[l_ac].bgeg018_desc = g_bgeg_d_t.bgeg018
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg018 = g_bgeg_d[l_ac].bgeg018_desc
               CALL s_desc_get_acc_desc('281',g_bgeg_d[l_ac].bgeg018) RETURNING g_bgeg_d[l_ac].bgeg018_desc
               LET g_bgeg_d[l_ac].bgeg018_desc = g_bgeg_d[l_ac].bgeg018,"  ",g_bgeg_d[l_ac].bgeg018_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg018 = g_bgeg_d[l_ac].bgeg018_desc
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg018_desc
            #add-point:ON CHANGE bgeg018_desc name="input.g.page1.bgeg018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg019_2
            #add-point:BEFORE FIELD bgeg019_2 name="input.b.page1.bgeg019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg019_2
            
            #add-point:AFTER FIELD bgeg019_2 name="input.a.page1.bgeg019_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg019_2
            #add-point:ON CHANGE bgeg019_2 name="input.g.page1.bgeg019_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg019_desc
            #add-point:BEFORE FIELD bgeg019_desc name="input.b.page1.bgeg019_desc"
            LET g_bgeg_d[l_ac].bgeg019_desc = g_bgeg_d[l_ac].bgeg019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg019_desc
            
            #add-point:AFTER FIELD bgeg019_desc name="input.a.page1.bgeg019_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg019_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg019_desc <> g_bgeg_d_t.bgeg019 OR cl_null(g_bgeg_d_t.bgeg019))) THEN
                  CALL s_voucher_glaq024_chk(g_bgeg_d[l_ac].bgeg019_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg019_desc
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg019_desc = g_bgeg_d_t.bgeg019
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg019 = g_bgeg_d[l_ac].bgeg019_desc
               CALL s_desc_get_rtaxl003_desc(g_bgeg_d[l_ac].bgeg019) RETURNING g_bgeg_d[l_ac].bgeg019_desc
               LET g_bgeg_d[l_ac].bgeg019_desc = g_bgeg_d[l_ac].bgeg019,"  ",g_bgeg_d[l_ac].bgeg019_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg019 = g_bgeg_d[l_ac].bgeg019_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg019_desc
            #add-point:ON CHANGE bgeg019_desc name="input.g.page1.bgeg019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg020_2
            #add-point:BEFORE FIELD bgeg020_2 name="input.b.page1.bgeg020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg020_2
            
            #add-point:AFTER FIELD bgeg020_2 name="input.a.page1.bgeg020_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg020_2
            #add-point:ON CHANGE bgeg020_2 name="input.g.page1.bgeg020_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg020_desc
            #add-point:BEFORE FIELD bgeg020_desc name="input.b.page1.bgeg020_desc"
            LET g_bgeg_d[l_ac].bgeg020_desc = g_bgeg_d[l_ac].bgeg020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg020_desc
            
            #add-point:AFTER FIELD bgeg020_desc name="input.a.page1.bgeg020_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg020_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg020_desc <> g_bgeg_d_t.bgeg020 OR cl_null(g_bgeg_d_t.bgeg020))) THEN
                  CALL s_aap_project_chk(g_bgeg_d[l_ac].bgeg020_desc) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg020_desc
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg020_desc = g_bgeg_d_t.bgeg020
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_bgeg_d[l_ac].bgeg020 = g_bgeg_d[l_ac].bgeg020_desc
               CALL s_desc_get_oojdl003_desc(g_bgeg_d[l_ac].bgeg020) RETURNING g_bgeg_d[l_ac].bgeg020_desc
               LET g_bgeg_d[l_ac].bgeg020_desc = g_bgeg_d[l_ac].bgeg020,"  ",g_bgeg_d[l_ac].bgeg020_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg020 = g_bgeg_d[l_ac].bgeg020_desc
            END IF
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg020_desc
            #add-point:ON CHANGE bgeg020_desc name="input.g.page1.bgeg020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg021_2
            #add-point:BEFORE FIELD bgeg021_2 name="input.b.page1.bgeg021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg021_2
            
            #add-point:AFTER FIELD bgeg021_2 name="input.a.page1.bgeg021_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg021_2
            #add-point:ON CHANGE bgeg021_2 name="input.g.page1.bgeg021_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg021_desc
            #add-point:BEFORE FIELD bgeg021_desc name="input.b.page1.bgeg021_desc"
            LET g_bgeg_d[l_ac].bgeg021_desc = g_bgeg_d[l_ac].bgeg021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg021_desc
            
            #add-point:AFTER FIELD bgeg021_desc name="input.a.page1.bgeg021_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg021_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg021_desc <> g_bgeg_d_t.bgeg021 OR cl_null(g_bgeg_d_t.bgeg021))) THEN
                  CALL s_voucher_glaq028_chk(g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg021_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg021_desc = g_bgeg_d_t.bgeg021
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg021 = g_bgeg_d[l_ac].bgeg021_desc
               CALL s_desc_get_wbs_desc(g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021) RETURNING g_bgeg_d[l_ac].bgeg021_desc
               LET g_bgeg_d[l_ac].bgeg021_desc = g_bgeg_d[l_ac].bgeg021,"  ",g_bgeg_d[l_ac].bgeg021_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg021 = g_bgeg_d[l_ac].bgeg021_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg021_desc
            #add-point:ON CHANGE bgeg021_desc name="input.g.page1.bgeg021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg022_2
            #add-point:BEFORE FIELD bgeg022_2 name="input.b.page1.bgeg022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg022_2
            
            #add-point:AFTER FIELD bgeg022_2 name="input.a.page1.bgeg022_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg022_2
            #add-point:ON CHANGE bgeg022_2 name="input.g.page1.bgeg022_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg023_2
            #add-point:BEFORE FIELD bgeg023_2 name="input.b.page1.bgeg023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg023_2
            
            #add-point:AFTER FIELD bgeg023_2 name="input.a.page1.bgeg023_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg023_2
            #add-point:ON CHANGE bgeg023_2 name="input.g.page1.bgeg023_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg023_desc
            #add-point:BEFORE FIELD bgeg023_desc name="input.b.page1.bgeg023_desc"
            LET g_bgeg_d[l_ac].bgeg023_desc = g_bgeg_d[l_ac].bgeg023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg023_desc
            
            #add-point:AFTER FIELD bgeg023_desc name="input.a.page1.bgeg023_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg023_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg023_desc <> g_bgeg_d_t.bgeg023 OR cl_null(g_bgeg_d_t.bgeg023))) THEN
                  CALL s_voucher_glaq052_chk(g_bgeg_d[l_ac].bgeg023_desc) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgeg_d[l_ac].bgeg023_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeg_d[l_ac].bgeg023_desc = g_bgeg_d_t.bgeg023
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg023 = g_bgeg_d[l_ac].bgeg023_desc
               CALL s_desc_get_oojdl003_desc(g_bgeg_d[l_ac].bgeg023) RETURNING g_bgeg_d[l_ac].bgeg023_desc
               LET g_bgeg_d[l_ac].bgeg023_desc = g_bgeg_d[l_ac].bgeg023,"  ",g_bgeg_d[l_ac].bgeg023_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg023 = g_bgeg_d[l_ac].bgeg023_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg023_desc
            #add-point:ON CHANGE bgeg023_desc name="input.g.page1.bgeg023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg024_2
            #add-point:BEFORE FIELD bgeg024_2 name="input.b.page1.bgeg024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg024_2
            
            #add-point:AFTER FIELD bgeg024_2 name="input.a.page1.bgeg024_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg024_2
            #add-point:ON CHANGE bgeg024_2 name="input.g.page1.bgeg024_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg024_desc
            #add-point:BEFORE FIELD bgeg024_desc name="input.b.page1.bgeg024_desc"
            LET g_bgeg_d[l_ac].bgeg024_desc = g_bgeg_d[l_ac].bgeg024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg024_desc
            
            #add-point:AFTER FIELD bgeg024_desc name="input.a.page1.bgeg024_desc"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg024_desc) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg024_desc <> g_bgeg_d_t.bgeg024 OR cl_null(g_bgeg_d_t.bgeg024))) THEN
                  CALL s_azzi650_chk_exist('2002',g_bgeg_d[l_ac].bgeg024_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_bgeg_d[l_ac].bgeg024_desc = g_bgeg_d_t.bgeg024
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET g_bgeg_d[l_ac].bgeg024 = g_bgeg_d[l_ac].bgeg024_desc
               CALL s_desc_get_acc_desc('2002',g_bgeg_d[l_ac].bgeg024) RETURNING g_bgeg_d[l_ac].bgeg024_desc
               LET g_bgeg_d[l_ac].bgeg024_desc = g_bgeg_d[l_ac].bgeg024,"  ",g_bgeg_d[l_ac].bgeg024_desc
            ELSE
               LET g_bgeg_d[l_ac].bgeg024 = g_bgeg_d[l_ac].bgeg024_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg024_desc
            #add-point:ON CHANGE bgeg024_desc name="input.g.page1.bgeg024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg035
            #add-point:BEFORE FIELD bgeg035 name="input.b.page1.bgeg035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg035
            
            #add-point:AFTER FIELD bgeg035 name="input.a.page1.bgeg035"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg035) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg035 <> g_bgeg_d_t.bgeg035 OR cl_null(g_bgeg_d_t.bgeg035))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  IF g_bgaw1[1] = 'Y' THEN
                     LET l_bgeg007 = g_bgeg_m.bgeg007
                  ELSE
                     LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
                  END IF
                  LET g_chkparam.arg1 = l_bgeg007
                  LET g_chkparam.arg2 = g_bgeg_d[l_ac].bgeg035
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_bgeg_d[l_ac].bgeg035 = g_bgeg_d_t.bgeg035
                     NEXT FIELD CURRENT
                  END IF
                  SELECT oodb005 INTO g_bgeg_d[l_ac].bgeg036 FROM oodb_t
                   WHERE oodbent=g_enterprise AND oodb002=g_bgeg_d[l_ac].bgeg035
                     AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_bgeg007)
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg035
            #add-point:ON CHANGE bgeg035 name="input.g.page1.bgeg035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg036
            #add-point:BEFORE FIELD bgeg036 name="input.b.page1.bgeg036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg036
            
            #add-point:AFTER FIELD bgeg036 name="input.a.page1.bgeg036"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg036
            #add-point:ON CHANGE bgeg036 name="input.g.page1.bgeg036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg037
            #add-point:BEFORE FIELD bgeg037 name="input.b.page1.bgeg037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg037
            
            #add-point:AFTER FIELD bgeg037 name="input.a.page1.bgeg037"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg037) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg037 <> g_bgeg_d_t.bgeg037 OR cl_null(g_bgeg_d_t.bgeg037))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgeg_d[l_ac].bgeg037
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgeg_d[l_ac].bgeg037 = g_bgeg_d_t.bgeg037
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg037
            #add-point:ON CHANGE bgeg037 name="input.g.page1.bgeg037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg100
            #add-point:BEFORE FIELD bgeg100 name="input.b.page1.bgeg100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg100
            
            #add-point:AFTER FIELD bgeg100 name="input.a.page1.bgeg100"
            IF NOT cl_null(g_bgeg_d[l_ac].bgeg100) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].bgeg100 <> g_bgeg_d_t.bgeg100 OR cl_null(g_bgeg_d_t.bgeg100))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgeg_d[l_ac].bgeg100
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  IF NOT cl_chk_exist("v_ooai001") THEN
                     LET g_bgeg_d[l_ac].bgeg100 = g_bgeg_d_t.bgeg100
                     NEXT FIELD CURRENT
                  END IF
#                  CALL s_abg_get_bg_rate(g_bgeg_m.bgeg002,g_today,g_bgeg_d[l_ac].bgeg100,g_bgeg_m.bgaa003) RETURNING g_bgeg_d[l_ac].bgeg101 #161220-00036#1 mark
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg100
            #add-point:ON CHANGE bgeg100 name="input.g.page1.bgeg100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num1
            #add-point:BEFORE FIELD num1 name="input.b.page1.num1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num1
            
            #add-point:AFTER FIELD num1 name="input.a.page1.num1"
            IF NOT cl_null(g_bgeg_d[l_ac].num1) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num1 <> g_bgeg_d_t.num1 OR cl_null(g_bgeg_d_t.num1))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num1,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num1 = g_bgeg_d_t.num1
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price1) THEN
                     LET g_bgeg_d[l_ac].amt1 = g_bgeg_d[l_ac].num1 * g_bgeg_d[l_ac].price1
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt1,2) 
                        RETURNING g_bgeg_d[l_ac].amt1
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt1
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
            IF NOT cl_null(g_bgeg_d[l_ac].price1) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price1 <> g_bgeg_d_t.price1 OR cl_null(g_bgeg_d_t.price1))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price1,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price1 = g_bgeg_d_t.price1
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price1,1) 
                     RETURNING g_bgeg_d[l_ac].price1
                  IF NOT cl_null(g_bgeg_d[l_ac].num1) THEN
                     LET g_bgeg_d[l_ac].amt1 = g_bgeg_d[l_ac].num1 * g_bgeg_d[l_ac].price1
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt1,2) 
                        RETURNING g_bgeg_d[l_ac].amt1
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt1
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
            IF NOT cl_null(g_bgeg_d[l_ac].num2) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num2 <> g_bgeg_d_t.num2 OR cl_null(g_bgeg_d_t.num2))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num2,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num2 = g_bgeg_d_t.num2
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price2) THEN
                     LET g_bgeg_d[l_ac].amt2 = g_bgeg_d[l_ac].num2 * g_bgeg_d[l_ac].price2
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt2,2) 
                        RETURNING g_bgeg_d[l_ac].amt2
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt2
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
            IF NOT cl_null(g_bgeg_d[l_ac].price2) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price2 <> g_bgeg_d_t.price2 OR cl_null(g_bgeg_d_t.price2))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price2,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price2 = g_bgeg_d_t.price2
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price2,1) 
                     RETURNING g_bgeg_d[l_ac].price2
                  IF NOT cl_null(g_bgeg_d[l_ac].num2) THEN
                     LET g_bgeg_d[l_ac].amt2 = g_bgeg_d[l_ac].num2 * g_bgeg_d[l_ac].price2
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt2,2) 
                        RETURNING g_bgeg_d[l_ac].amt2
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt2
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
            IF NOT cl_null(g_bgeg_d[l_ac].num3) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num3 <> g_bgeg_d_t.num3 OR cl_null(g_bgeg_d_t.num3))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num3,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num3 = g_bgeg_d_t.num3
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price3) THEN
                     LET g_bgeg_d[l_ac].amt3 = g_bgeg_d[l_ac].num3 * g_bgeg_d[l_ac].price3
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt3,2) 
                        RETURNING g_bgeg_d[l_ac].amt3
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt3
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
            IF NOT cl_null(g_bgeg_d[l_ac].price3) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price3 <> g_bgeg_d_t.price3 OR cl_null(g_bgeg_d_t.price3))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price3,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price3 = g_bgeg_d_t.price3
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price3,1) 
                        RETURNING g_bgeg_d[l_ac].price3
                  IF NOT cl_null(g_bgeg_d[l_ac].num3) THEN
                     LET g_bgeg_d[l_ac].amt3 = g_bgeg_d[l_ac].num3 * g_bgeg_d[l_ac].price3
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt3,2) 
                        RETURNING g_bgeg_d[l_ac].amt3
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt3
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
            IF NOT cl_null(g_bgeg_d[l_ac].num4) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num4 <> g_bgeg_d_t.num4 OR cl_null(g_bgeg_d_t.num4))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num4,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num4 = g_bgeg_d_t.num4
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price4) THEN
                     LET g_bgeg_d[l_ac].amt4 = g_bgeg_d[l_ac].num4 * g_bgeg_d[l_ac].price4
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt4,2) 
                        RETURNING g_bgeg_d[l_ac].amt4
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt4
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
            IF NOT cl_null(g_bgeg_d[l_ac].price4) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price4 <> g_bgeg_d_t.price4 OR cl_null(g_bgeg_d_t.price4))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price4,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price4 = g_bgeg_d_t.price4
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price4,1) 
                     RETURNING g_bgeg_d[l_ac].price4
                  IF NOT cl_null(g_bgeg_d[l_ac].num4) THEN
                     LET g_bgeg_d[l_ac].amt4 = g_bgeg_d[l_ac].num4 * g_bgeg_d[l_ac].price4
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt4,2) 
                        RETURNING g_bgeg_d[l_ac].amt4
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt4
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
            IF NOT cl_null(g_bgeg_d[l_ac].num5) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num5 <> g_bgeg_d_t.num5 OR cl_null(g_bgeg_d_t.num5))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num5,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num5 = g_bgeg_d_t.num5
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price5) THEN
                     LET g_bgeg_d[l_ac].amt5 = g_bgeg_d[l_ac].num5 * g_bgeg_d[l_ac].price5
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt5,2) 
                        RETURNING g_bgeg_d[l_ac].amt5
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt5
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
            IF NOT cl_null(g_bgeg_d[l_ac].price5) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price5 <> g_bgeg_d_t.price5 OR cl_null(g_bgeg_d_t.price5))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price5,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price5 = g_bgeg_d_t.price5
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price5,1) 
                     RETURNING g_bgeg_d[l_ac].price5
                  IF NOT cl_null(g_bgeg_d[l_ac].num5) THEN
                     LET g_bgeg_d[l_ac].amt5 = g_bgeg_d[l_ac].num5 * g_bgeg_d[l_ac].price5
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt5,2) 
                        RETURNING g_bgeg_d[l_ac].amt5
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt5
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
            IF NOT cl_null(g_bgeg_d[l_ac].num6) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num6 <> g_bgeg_d_t.num6 OR cl_null(g_bgeg_d_t.num6))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num6,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num6 = g_bgeg_d_t.num6
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price6) THEN
                     LET g_bgeg_d[l_ac].amt6 = g_bgeg_d[l_ac].num6 * g_bgeg_d[l_ac].price6
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt6,2) 
                        RETURNING g_bgeg_d[l_ac].amt6
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt6
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
            IF NOT cl_null(g_bgeg_d[l_ac].price6) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price6 <> g_bgeg_d_t.price6 OR cl_null(g_bgeg_d_t.price6))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price6,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price6 = g_bgeg_d_t.price6
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price6,1) 
                     RETURNING g_bgeg_d[l_ac].price6
                  IF NOT cl_null(g_bgeg_d[l_ac].num6) THEN
                     LET g_bgeg_d[l_ac].amt6 = g_bgeg_d[l_ac].num6 * g_bgeg_d[l_ac].price6
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt6,2) 
                        RETURNING g_bgeg_d[l_ac].amt6
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt6
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
            IF NOT cl_null(g_bgeg_d[l_ac].num7) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num7 <> g_bgeg_d_t.num7 OR cl_null(g_bgeg_d_t.num7))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num7,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num7 = g_bgeg_d_t.num7
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price7) THEN
                     LET g_bgeg_d[l_ac].amt7 = g_bgeg_d[l_ac].num7 * g_bgeg_d[l_ac].price7
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt7,2) 
                        RETURNING g_bgeg_d[l_ac].amt7
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt7
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
            IF NOT cl_null(g_bgeg_d[l_ac].price7) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price7 <> g_bgeg_d_t.price7 OR cl_null(g_bgeg_d_t.price7))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price7,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price7 = g_bgeg_d_t.price7
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price7,1) 
                     RETURNING g_bgeg_d[l_ac].price7
                  IF NOT cl_null(g_bgeg_d[l_ac].num7) THEN
                     LET g_bgeg_d[l_ac].amt7 = g_bgeg_d[l_ac].num7 * g_bgeg_d[l_ac].price7
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt7,2) 
                        RETURNING g_bgeg_d[l_ac].amt7
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt7
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
            IF NOT cl_null(g_bgeg_d[l_ac].num8) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num8 <> g_bgeg_d_t.num8 OR cl_null(g_bgeg_d_t.num8))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num8,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num8 = g_bgeg_d_t.num8
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price8) THEN
                     LET g_bgeg_d[l_ac].amt8 = g_bgeg_d[l_ac].num8 * g_bgeg_d[l_ac].price8
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt8,2) 
                        RETURNING g_bgeg_d[l_ac].amt8
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt8
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
            IF NOT cl_null(g_bgeg_d[l_ac].price8) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price8 <> g_bgeg_d_t.price8 OR cl_null(g_bgeg_d_t.price8))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price8,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price8 = g_bgeg_d_t.price8
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price8,1) 
                     RETURNING g_bgeg_d[l_ac].price8
                  IF NOT cl_null(g_bgeg_d[l_ac].num8) THEN
                     LET g_bgeg_d[l_ac].amt8 = g_bgeg_d[l_ac].num8 * g_bgeg_d[l_ac].price8
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt8,2) 
                        RETURNING g_bgeg_d[l_ac].amt8
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt8
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
            IF NOT cl_null(g_bgeg_d[l_ac].num9) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num9 <> g_bgeg_d_t.num9 OR cl_null(g_bgeg_d_t.num9))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num9,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num9 = g_bgeg_d_t.num9
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price9) THEN
                     LET g_bgeg_d[l_ac].amt9 = g_bgeg_d[l_ac].num9 * g_bgeg_d[l_ac].price9
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt9,2) 
                        RETURNING g_bgeg_d[l_ac].amt9
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt9
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
            IF NOT cl_null(g_bgeg_d[l_ac].price9) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price9 <> g_bgeg_d_t.price9 OR cl_null(g_bgeg_d_t.price9))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price9,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price9 = g_bgeg_d_t.price9
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price9,1) 
                     RETURNING g_bgeg_d[l_ac].price9
                  IF NOT cl_null(g_bgeg_d[l_ac].num9) THEN
                     LET g_bgeg_d[l_ac].amt9 = g_bgeg_d[l_ac].num9 * g_bgeg_d[l_ac].price9
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt9,2) 
                        RETURNING g_bgeg_d[l_ac].amt9
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt9
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
            IF NOT cl_null(g_bgeg_d[l_ac].num10) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num10 <> g_bgeg_d_t.num10 OR cl_null(g_bgeg_d_t.num10))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num10,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num10 = g_bgeg_d_t.num10
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price10) THEN
                     LET g_bgeg_d[l_ac].amt10 = g_bgeg_d[l_ac].num10 * g_bgeg_d[l_ac].price10
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt10,2) 
                        RETURNING g_bgeg_d[l_ac].amt10
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt10
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
            IF NOT cl_null(g_bgeg_d[l_ac].price10) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price10 <> g_bgeg_d_t.price10 OR cl_null(g_bgeg_d_t.price10))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price10,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price10 = g_bgeg_d_t.price10
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price10,1) 
                     RETURNING g_bgeg_d[l_ac].price10
                  IF NOT cl_null(g_bgeg_d[l_ac].num10) THEN
                     LET g_bgeg_d[l_ac].amt10 = g_bgeg_d[l_ac].num10 * g_bgeg_d[l_ac].price10
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt10,2) 
                        RETURNING g_bgeg_d[l_ac].amt10
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt10
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
            IF NOT cl_null(g_bgeg_d[l_ac].num11) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num11 <> g_bgeg_d_t.num11 OR cl_null(g_bgeg_d_t.num11))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num11,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num11 = g_bgeg_d_t.num11
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price11) THEN
                     LET g_bgeg_d[l_ac].amt11 = g_bgeg_d[l_ac].num11 * g_bgeg_d[l_ac].price11
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt11,2) 
                        RETURNING g_bgeg_d[l_ac].amt11
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt11
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
            IF NOT cl_null(g_bgeg_d[l_ac].price11) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price11 <> g_bgeg_d_t.price11 OR cl_null(g_bgeg_d_t.price11))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price11,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price11 = g_bgeg_d_t.price11
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price11,1) 
                        RETURNING g_bgeg_d[l_ac].price11
                  IF NOT cl_null(g_bgeg_d[l_ac].num11) THEN
                     LET g_bgeg_d[l_ac].amt11 = g_bgeg_d[l_ac].num11 * g_bgeg_d[l_ac].price11
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt11,2) 
                        RETURNING g_bgeg_d[l_ac].amt11
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt11
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
            IF NOT cl_null(g_bgeg_d[l_ac].num12) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num12 <> g_bgeg_d_t.num12 OR cl_null(g_bgeg_d_t.num12))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num12,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num12 = g_bgeg_d_t.num12
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price12) THEN
                     LET g_bgeg_d[l_ac].amt12 = g_bgeg_d[l_ac].num12 * g_bgeg_d[l_ac].price12
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt12,2) 
                        RETURNING g_bgeg_d[l_ac].amt12
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt12
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
            IF NOT cl_null(g_bgeg_d[l_ac].price12) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price12 <> g_bgeg_d_t.price12 OR cl_null(g_bgeg_d_t.price12))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price12,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price12 = g_bgeg_d_t.price12
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price12,1) 
                        RETURNING g_bgeg_d[l_ac].price12
                  IF NOT cl_null(g_bgeg_d[l_ac].num12) THEN
                     LET g_bgeg_d[l_ac].amt12 = g_bgeg_d[l_ac].num12 * g_bgeg_d[l_ac].price12
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt12,2) 
                        RETURNING g_bgeg_d[l_ac].amt12
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt12
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
            IF NOT cl_null(g_bgeg_d[l_ac].num13) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].num13 <> g_bgeg_d_t.num13 OR cl_null(g_bgeg_d_t.num13))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].num13,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].num13 = g_bgeg_d_t.num13
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgeg_d[l_ac].price13) THEN
                     LET g_bgeg_d[l_ac].amt13 = g_bgeg_d[l_ac].num13 * g_bgeg_d[l_ac].price13
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt13,2) 
                        RETURNING g_bgeg_d[l_ac].amt13
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt13
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
            IF NOT cl_null(g_bgeg_d[l_ac].price13) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bgeg_d[l_ac].price13 <> g_bgeg_d_t.price13 OR cl_null(g_bgeg_d_t.price13))) THEN
                  IF NOT cl_ap_chk_Range(g_bgeg_d[l_ac].price13,"0","1","","","azz-00079",1) THEN
                     LET g_bgeg_d[l_ac].price13 = g_bgeg_d_t.price13
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].price13,1) 
                        RETURNING g_bgeg_d[l_ac].price13
                  IF NOT cl_null(g_bgeg_d[l_ac].num13) THEN
                     LET g_bgeg_d[l_ac].amt13 = g_bgeg_d[l_ac].num13 * g_bgeg_d[l_ac].price13
                     CALL s_curr_round(g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].amt13,2) 
                        RETURNING g_bgeg_d[l_ac].amt13
                     DISPLAY BY NAME g_bgeg_d[l_ac].amt13
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
         BEFORE FIELD bgeg008
            #add-point:BEFORE FIELD bgeg008 name="input.b.page1.bgeg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg008
            
            #add-point:AFTER FIELD bgeg008 name="input.a.page1.bgeg008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgeg_m.bgeg001 IS NOT NULL AND g_bgeg_m.bgeg002 IS NOT NULL AND g_bgeg_m.bgeg003 IS NOT NULL AND g_bgeg_m.bgeg004 IS NOT NULL AND g_bgeg_m.bgeg005 IS NOT NULL AND g_bgeg_m.bgeg006 IS NOT NULL AND g_bgeg_m.bgeg007 IS NOT NULL AND g_bgeg_m.bgeg009 IS NOT NULL AND g_bgeg_d[g_detail_idx].bgeg008 IS NOT NULL AND g_bgeg_d[g_detail_idx].bgeg010 IS NOT NULL AND g_bgeg_d[g_detail_idx].bgegseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgeg_m.bgeg001 != g_bgeg001_t OR g_bgeg_m.bgeg002 != g_bgeg002_t OR g_bgeg_m.bgeg003 != g_bgeg003_t OR g_bgeg_m.bgeg004 != g_bgeg004_t OR g_bgeg_m.bgeg005 != g_bgeg005_t OR g_bgeg_m.bgeg006 != g_bgeg006_t OR g_bgeg_m.bgeg007 != g_bgeg007_t OR g_bgeg_m.bgeg009 != g_bgeg009_t OR g_bgeg_d[g_detail_idx].bgeg008 != g_bgeg_d_t.bgeg008 OR g_bgeg_d[g_detail_idx].bgeg010 != g_bgeg_d_t.bgeg010 OR g_bgeg_d[g_detail_idx].bgegseq != g_bgeg_d_t.bgegseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgeg_t WHERE "||"bgegent = " ||g_enterprise|| " AND "||"bgeg001 = '"||g_bgeg_m.bgeg001 ||"' AND "|| "bgeg002 = '"||g_bgeg_m.bgeg002 ||"' AND "|| "bgeg003 = '"||g_bgeg_m.bgeg003 ||"' AND "|| "bgeg004 = '"||g_bgeg_m.bgeg004 ||"' AND "|| "bgeg005 = '"||g_bgeg_m.bgeg005 ||"' AND "|| "bgeg006 = '"||g_bgeg_m.bgeg006 ||"' AND "|| "bgeg007 = '"||g_bgeg_m.bgeg007 ||"' AND "|| "bgeg009 = '"||g_bgeg_m.bgeg009 ||"' AND "|| "bgeg008 = '"||g_bgeg_d[g_detail_idx].bgeg008 ||"' AND "|| "bgeg010 = '"||g_bgeg_d[g_detail_idx].bgeg010 ||"' AND "|| "bgegseq = '"||g_bgeg_d[g_detail_idx].bgegseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg008
            #add-point:ON CHANGE bgeg008 name="input.g.page1.bgeg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg047
            #add-point:BEFORE FIELD bgeg047 name="input.b.page1.bgeg047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg047
            
            #add-point:AFTER FIELD bgeg047 name="input.a.page1.bgeg047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg047
            #add-point:ON CHANGE bgeg047 name="input.g.page1.bgeg047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg048
            #add-point:BEFORE FIELD bgeg048 name="input.b.page1.bgeg048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg048
            
            #add-point:AFTER FIELD bgeg048 name="input.a.page1.bgeg048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg048
            #add-point:ON CHANGE bgeg048 name="input.g.page1.bgeg048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeg050
            #add-point:BEFORE FIELD bgeg050 name="input.b.page1.bgeg050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeg050
            
            #add-point:AFTER FIELD bgeg050 name="input.a.page1.bgeg050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeg050
            #add-point:ON CHANGE bgeg050 name="input.g.page1.bgeg050"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgegseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgegseq
            #add-point:ON ACTION controlp INFIELD bgegseq name="input.c.page1.bgegseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg010_2
            #add-point:ON ACTION controlp INFIELD bgeg010_2 name="input.c.page1.bgeg010_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg007_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg007_2
            #add-point:ON ACTION controlp INFIELD bgeg007_2 name="input.c.page1.bgeg007_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg007             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg007 = g_qryparam.return1              
            #LET g_bgeg_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg007 TO bgeg007_2              #
            #DISPLAY g_bgeg_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgeg007_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg007_desc
            #add-point:ON ACTION controlp INFIELD bgeg007_desc name="input.c.page1.bgeg007_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg007_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgeg_m.bgeg002,g_bgeg_m.bgeg004,g_user,'03') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg007_desc = g_qryparam.return1  
            LET g_bgeg_d[l_ac].bgeg007 = g_qryparam.return1  
            #LET g_bgeg_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg007_desc TO bgeg007_desc              #
            #DISPLAY g_bgeg_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgeg007_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg009_2
            #add-point:ON ACTION controlp INFIELD bgeg009_2 name="input.c.page1.bgeg009_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg009 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg009 TO bgeg009_2              #

            NEXT FIELD bgeg009_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg009_desc
            #add-point:ON ACTION controlp INFIELD bgeg009_desc name="input.c.page1.bgeg009_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg009_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            LET g_qryparam.where = " bgas001 IN (SELECT bgea003 FROM bgea_t ",
                                   "              WHERE bgeaent=",g_enterprise," AND bgeastus='Y' "
            IF NOT cl_null(g_bgeg_m.bgeg002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgea001='",g_bgeg_m.bgeg002,"' "
            END IF
            #预算组织在单头
            IF g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgea002='",g_bgeg_m.bgeg007,"' "
            END IF
            #预算组织在单身
            IF g_bgaw2[1]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgea002='",g_bgeg_d[l_ac].bgeg007,"' "
            END IF
            LET g_qryparam.where = g_qryparam.where," )"
               
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg009_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg009 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg009_desc TO bgeg009_desc              #

            NEXT FIELD bgeg009_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg049
            #add-point:ON ACTION controlp INFIELD bgeg049 name="input.c.page1.bgeg049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg012_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg012_2
            #add-point:ON ACTION controlp INFIELD bgeg012_2 name="input.c.page1.bgeg012_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg012 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg012 TO bgeg012_2              #

            NEXT FIELD bgeg012_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg012_desc
            #add-point:ON ACTION controlp INFIELD bgeg012_desc name="input.c.page1.bgeg012_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg012_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgeg_m.bgeg007) THEN
                  LET l_ooef001 = g_bgeg_m.bgeg007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
                  LET l_ooef001 = g_bgeg_d[l_ac].bgeg007
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
 
            LET g_bgeg_d[l_ac].bgeg012_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg012 = g_qryparam.return1  
            DISPLAY g_bgeg_d[l_ac].bgeg012_desc TO bgeg012_desc              #

            NEXT FIELD bgeg012_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg013_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg013_2
            #add-point:ON ACTION controlp INFIELD bgeg013_2 name="input.c.page1.bgeg013_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

 
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg013 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg013 TO bgeg013_2              #

            NEXT FIELD bgeg013_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg013_desc
            #add-point:ON ACTION controlp INFIELD bgeg013_desc name="input.c.page1.bgeg013_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg013_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgeg_m.bgeg007) THEN
                  LET l_ooef001 = g_bgeg_m.bgeg007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
                  LET l_ooef001 = g_bgeg_d[l_ac].bgeg007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "

 
            CALL q_ooeg001_13()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg013_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg013 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg013_desc TO bgeg013_desc              #

            NEXT FIELD bgeg013_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg014_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg014_2
            #add-point:ON ACTION controlp INFIELD bgeg014_2 name="input.c.page1.bgeg014_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s

 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg014 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg014 TO bgeg014_2              #

            NEXT FIELD bgeg014_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg014_desc
            #add-point:ON ACTION controlp INFIELD bgeg014_desc name="input.c.page1.bgeg014_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg014_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               IF NOT cl_null(g_bgeg_m.bgeg007) THEN
                  LET l_ooef001 = g_bgeg_m.bgeg007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            ELSE
            #预算组织在单身
               IF NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
                  LET l_ooef001 = g_bgeg_d[l_ac].bgeg007
               ELSE
                  LET l_ooef001 = g_site
               END IF
            END IF
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_ooef001
            LET g_qryparam.where = " ooeg009='",l_ooef017,"' "

 
            CALL q_ooeg001_10()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg014_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg014 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg014_desc TO bgeg014_desc              #

            NEXT FIELD bgeg014_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg015_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg015_2
            #add-point:ON ACTION controlp INFIELD bgeg015_2 name="input.c.page1.bgeg015_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg015             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg015 = g_qryparam.return1              
            #LET g_bgeg_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg015 TO bgeg015_2              #
            #DISPLAY g_bgeg_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg015_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg015_desc
            #add-point:ON ACTION controlp INFIELD bgeg015_desc name="input.c.page1.bgeg015_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg015_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg015_desc = g_qryparam.return1  
            LET g_bgeg_d[l_ac].bgeg015 = g_qryparam.return1
            #LET g_bgeg_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg015_desc TO bgeg015_desc              #
            #DISPLAY g_bgeg_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg015_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg016_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg016_2
            #add-point:ON ACTION controlp INFIELD bgeg016_2 name="input.c.page1.bgeg016_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg016 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg016 TO bgeg016_2              #

            NEXT FIELD bgeg016_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg016_desc
            #add-point:ON ACTION controlp INFIELD bgeg016_desc name="input.c.page1.bgeg016_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg016_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            LET l_bgeg007 = ''
            #当预算组织在单头
            IF g_bgaw1[1]='Y' THEN
               LET l_bgeg007 = g_bgeg_m.bgeg007
            END IF
            #当预算组织在单身
            IF g_bgaw2[1]='Y' THEN
               LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
            END IF
            LET g_qryparam.where = g_qryparam.where,
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",l_bgeg007,"')"
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg016_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg016 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg016_desc TO bgeg016_desc              #

            NEXT FIELD bgeg016_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg017_2
            #add-point:ON ACTION controlp INFIELD bgeg017_2 name="input.c.page1.bgeg017_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg017 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg017 TO bgeg017_2              #

            NEXT FIELD bgeg017_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg017_desc
            #add-point:ON ACTION controlp INFIELD bgeg017_desc name="input.c.page1.bgeg017_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg017_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus='Y'"
            LET l_bgeg007 = ''
            #当预算组织在单头
            IF g_bgaw1[1]='Y' AND NOT cl_null(g_bgeg_m.bgeg007) THEN
               LET l_bgeg007 = g_bgeg_m.bgeg007
            END IF
            #当预算组织在单身
            IF g_bgaw2[1]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
               LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
            END IF
            IF NOT cl_null(l_bgeg007) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t ",
                                      "                  WHERE bgaqent=",g_enterprise,
                                      "                    AND bgaqsite='",l_bgeg007,"')"
            END IF
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg017_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg017 = g_qryparam.return1 
            DISPLAY g_bgeg_d[l_ac].bgeg017_desc TO bgeg017_desc              #

            NEXT FIELD bgeg017_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg018_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg018_2
            #add-point:ON ACTION controlp INFIELD bgeg018_2 name="input.c.page1.bgeg018_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg018             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg018 = g_qryparam.return1              
            #LET g_bgeg_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg018 TO bgeg018_2              #
            #DISPLAY g_bgeg_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg018_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg018_desc
            #add-point:ON ACTION controlp INFIELD bgeg018_desc name="input.c.page1.bgeg018_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg018_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg018_desc = g_qryparam.return1 
            LET g_bgeg_d[l_ac].bgeg018 = g_qryparam.return1
            #LET g_bgeg_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg018_desc TO bgeg018_desc              #
            #DISPLAY g_bgeg_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg018_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg019_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg019_2
            #add-point:ON ACTION controlp INFIELD bgeg019_2 name="input.c.page1.bgeg019_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg019 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg019 TO bgeg019_2              #

            NEXT FIELD bgeg019_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg019_desc
            #add-point:ON ACTION controlp INFIELD bgeg019_desc name="input.c.page1.bgeg019_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg019_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
            CALL q_rtax001_1()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg019_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg019 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg019_desc TO bgeg019_desc              #

            NEXT FIELD bgeg019_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg020_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg020_2
            #add-point:ON ACTION controlp INFIELD bgeg020_2 name="input.c.page1.bgeg020_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg020 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg020 TO bgeg020_2              #

            NEXT FIELD bgeg020_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg020_desc
            #add-point:ON ACTION controlp INFIELD bgeg020_desc name="input.c.page1.bgeg020_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg020_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg020_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg020 = g_qryparam.return1 
            DISPLAY g_bgeg_d[l_ac].bgeg020_desc TO bgeg020_desc              #

            NEXT FIELD bgeg020_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg021_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg021_2
            #add-point:ON ACTION controlp INFIELD bgeg021_2 name="input.c.page1.bgeg021_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg021 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg021 TO bgeg021_2              #

            NEXT FIELD bgeg021_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg021_desc
            #add-point:ON ACTION controlp INFIELD bgeg021_desc name="input.c.page1.bgeg021_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg021_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = "pjbb012='1'"
            IF g_bgaw1[14]='Y' AND NOT cl_null(g_bgeg_m.bgeg020) THEN
               LET g_qryparam.where = g_qryparam.where," AND pjbb001='",g_bgeg_m.bgeg020,"'"
            END IF
            IF g_bgaw2[14]='Y' AND NOT cl_null(g_bgeg_d[l_ac].bgeg020) THEN
               LET g_qryparam.where = g_qryparam.where," AND pjbb001='",g_bgeg_d[l_ac].bgeg020,"'"
            END IF
 
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg021_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg021 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg021_desc TO bgeg021_desc              #

            NEXT FIELD bgeg021_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg022_2
            #add-point:ON ACTION controlp INFIELD bgeg022_2 name="input.c.page1.bgeg022_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg023_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg023_2
            #add-point:ON ACTION controlp INFIELD bgeg023_2 name="input.c.page1.bgeg023_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg023 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg023 TO bgeg023_2              #

            NEXT FIELD bgeg023_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg023_desc
            #add-point:ON ACTION controlp INFIELD bgeg023_desc name="input.c.page1.bgeg023_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg023_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg023_desc = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg023 = g_qryparam.return1
            DISPLAY g_bgeg_d[l_ac].bgeg023_desc TO bgeg023_desc              #

            NEXT FIELD bgeg023_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg024_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg024_2
            #add-point:ON ACTION controlp INFIELD bgeg024_2 name="input.c.page1.bgeg024_2"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg024             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg024 = g_qryparam.return1              
            #LET g_bgeg_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg024 TO bgeg024_2              #
            #DISPLAY g_bgeg_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg024_2                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg024_desc
            #add-point:ON ACTION controlp INFIELD bgeg024_desc name="input.c.page1.bgeg024_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg024_desc             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg024_desc = g_qryparam.return1 
            LET g_bgeg_d[l_ac].bgeg024 = g_qryparam.return1
            #LET g_bgeg_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bgeg_d[l_ac].bgeg024_desc TO bgeg024_desc              #
            #DISPLAY g_bgeg_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bgeg024_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg035
            #add-point:ON ACTION controlp INFIELD bgeg035 name="input.c.page1.bgeg035"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg035             #給予default值
            LET g_qryparam.default2 = "" #g_bgeg_d[l_ac].oodb005 #含稅否
            LET g_qryparam.default3 = "" #g_bgeg_d[l_ac].oodb006 #稅率
            LET g_qryparam.default4 = "" #g_bgeg_d[l_ac].oodbl004 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s
            #预算组织在单头
            IF g_bgaw1[1] = 'Y' THEN
               SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgeg_m.bgeg007
            ELSE
               IF NOT cl_null(g_bgeg_d[l_ac].bgeg007) THEN
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_bgeg_d[l_ac].bgeg007
               ELSE
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site
               END IF
            END IF
            
            #給予arg
            LET g_qryparam.arg1 =l_ooef019
 
            CALL q_oodb002_5()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg035 = g_qryparam.return1              
            LET g_bgeg_d[l_ac].bgeg036 = g_qryparam.return2 
            #LET g_bgeg_d[l_ac].oodb006 = g_qryparam.return3 
            #LET g_bgeg_d[l_ac].oodbl004 = g_qryparam.return4 
            DISPLAY g_bgeg_d[l_ac].bgeg035 TO bgeg035              #
            DISPLAY g_bgeg_d[l_ac].bgeg036 TO bgeg036 #含稅否
            #DISPLAY g_bgeg_d[l_ac].oodb006 TO oodb006 #稅率
            #DISPLAY g_bgeg_d[l_ac].oodbl004 TO oodbl004 #說明
            NEXT FIELD bgeg035                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg036
            #add-point:ON ACTION controlp INFIELD bgeg036 name="input.c.page1.bgeg036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg037
            #add-point:ON ACTION controlp INFIELD bgeg037 name="input.c.page1.bgeg037"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg037             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_imao002_01()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg037 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg037 TO bgeg037              #

            NEXT FIELD bgeg037                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg100
            #add-point:ON ACTION controlp INFIELD bgeg100 name="input.c.page1.bgeg100"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgeg_d[l_ac].bgeg100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_bgeg_d[l_ac].bgeg100 = g_qryparam.return1              

            DISPLAY g_bgeg_d[l_ac].bgeg100 TO bgeg100              #

            NEXT FIELD bgeg100                          #返回原欄位



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
 
 
         #Ctrlp:input.c.page1.bgeg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg008
            #add-point:ON ACTION controlp INFIELD bgeg008 name="input.c.page1.bgeg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg047
            #add-point:ON ACTION controlp INFIELD bgeg047 name="input.c.page1.bgeg047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg048
            #add-point:ON ACTION controlp INFIELD bgeg048 name="input.c.page1.bgeg048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgeg050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeg050
            #add-point:ON ACTION controlp INFIELD bgeg050 name="input.c.page1.bgeg050"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgeg_d[l_ac].* = g_bgeg_d_t.*
               CLOSE abgt510_bcl
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
               LET g_errparam.extend = g_bgeg_d[l_ac].bgeg008 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgeg_d[l_ac].* = g_bgeg_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bgeg2_d[l_ac].bgegmodid = g_user 
LET g_bgeg2_d[l_ac].bgegmoddt = cl_get_current()
LET g_bgeg2_d[l_ac].bgegmodid_desc = cl_get_username(g_bgeg2_d[l_ac].bgegmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF 1=2 THEN
               #end add-point
         
               #將遮罩欄位還原
               CALL abgt510_bgeg_t_mask_restore('restore_mask_o')
         
               UPDATE bgeg_t SET (bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg009,bgeg010, 
                   bgegseq,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,bgeg018,bgeg019,bgeg020, 
                   bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037,bgeg100,bgeg008,bgeg047,bgeg048, 
                   bgeg050,bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid, 
                   bgegcnfdt) = (g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
                   g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010, 
                   g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg049,g_bgeg_d[l_ac].bgeg012,g_bgeg_d[l_ac].bgeg013, 
                   g_bgeg_d[l_ac].bgeg014,g_bgeg_d[l_ac].bgeg015,g_bgeg_d[l_ac].bgeg016,g_bgeg_d[l_ac].bgeg017, 
                   g_bgeg_d[l_ac].bgeg018,g_bgeg_d[l_ac].bgeg019,g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021, 
                   g_bgeg_d[l_ac].bgeg022,g_bgeg_d[l_ac].bgeg023,g_bgeg_d[l_ac].bgeg024,g_bgeg_d[l_ac].bgeg035, 
                   g_bgeg_d[l_ac].bgeg036,g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg008, 
                   g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048,g_bgeg_d[l_ac].bgeg050,g_bgeg2_d[l_ac].bgegownid, 
                   g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid,g_bgeg2_d[l_ac].bgegcrtdp,g_bgeg2_d[l_ac].bgegcrtdt, 
                   g_bgeg2_d[l_ac].bgegmodid,g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt) 
 
                WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg_m.bgeg001 
                 AND bgeg002 = g_bgeg_m.bgeg002 
                 AND bgeg003 = g_bgeg_m.bgeg003 
                 AND bgeg004 = g_bgeg_m.bgeg004 
                 AND bgeg005 = g_bgeg_m.bgeg005 
                 AND bgeg006 = g_bgeg_m.bgeg006 
                 AND bgeg007 = g_bgeg_m.bgeg007 
                 AND bgeg009 = g_bgeg_m.bgeg009 
                 AND bgeg010 = g_bgeg_m.bgeg010 
 
                 AND bgeg008 = g_bgeg_d_t.bgeg008 #項次   
                 AND bgegseq = g_bgeg_d_t.bgegseq  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               END IF
               
               #將遮罩欄位還原
               CALL abgt510_bgeg_t_mask_restore('restore_mask_o')
               
               #主键检查
               #组合key bgeg010
               CALL abgt510_get_bgeg010()
               
               #预算组织在单头
               IF g_bgaw1[1]='Y' THEN 
                  LET l_bgeg007 = g_bgeg_m.bgeg007
               ELSE
                  LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
               END IF
               #预算料号在单头
               IF g_bgaw1[2]='Y' THEN 
                  LET l_bgeg009 = g_bgeg_m.bgeg009
               ELSE
                  LET l_bgeg009 = g_bgeg_d[l_ac].bgeg009
               END IF
               
               IF g_bgeg_m.bgeg001 != g_bgeg001_t  OR g_bgeg_m.bgeg002 != g_bgeg002_t  OR g_bgeg_m.bgeg003 != g_bgeg003_t OR
                  g_bgeg_m.bgeg004 != g_bgeg004_t  OR g_bgeg_m.bgeg005 != g_bgeg005_t  OR g_bgeg_m.bgeg006 != g_bgeg006_t OR
                  ((g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 != g_bgeg007_t ) OR (g_bgaw2[1]='Y' AND g_bgeg_d[l_ac].bgeg007!=g_bgeg_d_t.bgeg007)) OR
                  ((g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 != g_bgeg009_t ) OR (g_bgaw2[2]='Y' AND g_bgeg_d[l_ac].bgeg009!=g_bgeg_d_t.bgeg009)) 
               THEN                   
                  CALL s_abgt510_detail_key_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                                g_bgeg_m.bgeg006,l_bgeg007,l_bgeg009,g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend =g_bgeg_d[l_ac].bgegseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgegseq
                  END IF
               END IF
               
               #重写单身更新
               CALL abgt510_update_detail() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgeg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bgeg_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgeg_m.bgeg001
               LET gs_keys_bak[1] = g_bgeg001_t
               LET gs_keys[2] = g_bgeg_m.bgeg002
               LET gs_keys_bak[2] = g_bgeg002_t
               LET gs_keys[3] = g_bgeg_m.bgeg003
               LET gs_keys_bak[3] = g_bgeg003_t
               LET gs_keys[4] = g_bgeg_m.bgeg004
               LET gs_keys_bak[4] = g_bgeg004_t
               LET gs_keys[5] = g_bgeg_m.bgeg005
               LET gs_keys_bak[5] = g_bgeg005_t
               LET gs_keys[6] = g_bgeg_m.bgeg006
               LET gs_keys_bak[6] = g_bgeg006_t
               LET gs_keys[7] = g_bgeg_m.bgeg007
               LET gs_keys_bak[7] = g_bgeg007_t
               LET gs_keys[8] = g_bgeg_m.bgeg009
               LET gs_keys_bak[8] = g_bgeg009_t
               LET gs_keys[9] = g_bgeg_m.bgeg010
               LET gs_keys_bak[9] = g_bgeg010_t
               LET gs_keys[10] = g_bgeg_d[g_detail_idx].bgeg008
               LET gs_keys_bak[10] = g_bgeg_d_t.bgeg008
               LET gs_keys[11] = g_bgeg_d[g_detail_idx].bgegseq
               LET gs_keys_bak[11] = g_bgeg_d_t.bgegseq
               CALL abgt510_update_b('bgeg_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bgeg_m),util.JSON.stringify(g_bgeg_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgeg_m),util.JSON.stringify(g_bgeg_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt510_bgeg_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bgeg_m.bgeg001
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg002
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg003
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg004
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg005
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg006
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg007
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg009
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_m.bgeg010
 
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_d_t.bgeg008
               LET ls_keys[ls_keys.getLength()+1] = g_bgeg_d_t.bgegseq
 
               CALL abgt510_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            #检查单头是否存在未录入的核算项资料
            CALL abgt510_head_hsx_chk() #161215-00014#2 add
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgt510_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgeg_d[l_ac].* = g_bgeg_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgt510_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bgeg_d.getLength() = 0 THEN
               NEXT FIELD bgeg008
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgeg_d[li_reproduce_target].* = g_bgeg_d[li_reproduce].*
               LET g_bgeg2_d[li_reproduce_target].* = g_bgeg2_d[li_reproduce].*
               LET g_bgeg3_d[li_reproduce_target].* = g_bgeg3_d[li_reproduce].*
 
               LET g_bgeg_d[li_reproduce_target].bgeg008 = NULL
               LET g_bgeg_d[li_reproduce_target].bgegseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgeg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgeg_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bgeg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt510_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgt510_idx_chk()
            CALL abgt510_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
      DISPLAY ARRAY g_bgeg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt510_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 3
            CALL abgt510_idx_chk()
            CALL abgt510_ui_detailshow()
        
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
            NEXT FIELD bgeg001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgegseq
               WHEN "s_detail2"
                  NEXT FIELD bgegseq_2
               WHEN "s_detail3"
                  NEXT FIELD bgegseq_3
 
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
#   CALL cl_set_combo_scc('bgeg005','8985') #161220-00036#1 mark
   CALL cl_set_combo_scc('bgeg005','8958') #161220-00036#1 add
   CLOSE abgt510_hcl
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt510_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #重新抓取樣式
   CALL s_abg2_get_bgaw(g_bgeg_m.bgeg011) RETURNING g_bgaw1,g_bgaw2
   
   #设置核算项显示位置
   CALL abgt510_set_hsx_visible()
   
   #抓取預算週期和預算期別
   CALL s_abgt340_sel_bgaa(g_bgeg_m.bgeg002) RETURNING g_bgeg_m.bgaa002,g_bgeg_m.bgaa003,g_max_period
   DISPLAY BY NAME g_bgeg_m.bgaa002,g_bgeg_m.bgaa003
   #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
   IF g_max_period < 13 THEN
      CALL cl_set_comp_visible("num13,price13,amt13,tnum13,tprice13,tamt13",FALSE)
   ELSE
      CALL cl_set_comp_visible("num13,price13,amt13,tnum13,tprice13,tamt13",TRUE)
   END IF
      
   #抓取单头核算项说明
   CALL abgt510_head_hsx_desc()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgt510_b_fill(g_wc2) #第一階單身填充
      CALL abgt510_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bgeg_m.bgeg002,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg004_desc, 
       g_bgeg_m.bgaa002,g_bgeg_m.bgaa003,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg007_desc_t,g_bgeg_m.bgeg013, 
       g_bgeg_m.bgeg013_desc_t,g_bgeg_m.bgeg016,g_bgeg_m.bgeg016_desc_t,g_bgeg_m.bgeg019,g_bgeg_m.bgeg019_desc_t, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg014_desc_t,g_bgeg_m.bgeg017,g_bgeg_m.bgeg017_desc_t, 
       g_bgeg_m.bgeg020,g_bgeg_m.bgeg020_desc_t,g_bgeg_m.bgeg023,g_bgeg_m.bgeg023_desc_t,g_bgeg_m.bgeg012, 
       g_bgeg_m.bgeg012_desc_t,g_bgeg_m.bgeg015,g_bgeg_m.bgeg015_desc_t,g_bgeg_m.bgeg018,g_bgeg_m.bgeg018_desc_t, 
       g_bgeg_m.bgeg021,g_bgeg_m.bgeg021_desc_t,g_bgeg_m.bgeg024,g_bgeg_m.bgeg024_desc_t,g_bgeg_m.bgeg049 
 
 
   CALL abgt510_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CASE g_bgeg_m.bgegstus 
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
 
{<section id="abgt510.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgt510_ref_show()
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
   FOR l_ac = 1 TO g_bgeg_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgeg2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_bgeg3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgt510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt510_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgeg_t.bgeg001 
   DEFINE l_oldno     LIKE bgeg_t.bgeg001 
   DEFINE l_newno02     LIKE bgeg_t.bgeg002 
   DEFINE l_oldno02     LIKE bgeg_t.bgeg002 
   DEFINE l_newno03     LIKE bgeg_t.bgeg003 
   DEFINE l_oldno03     LIKE bgeg_t.bgeg003 
   DEFINE l_newno04     LIKE bgeg_t.bgeg004 
   DEFINE l_oldno04     LIKE bgeg_t.bgeg004 
   DEFINE l_newno05     LIKE bgeg_t.bgeg005 
   DEFINE l_oldno05     LIKE bgeg_t.bgeg005 
   DEFINE l_newno06     LIKE bgeg_t.bgeg006 
   DEFINE l_oldno06     LIKE bgeg_t.bgeg006 
   DEFINE l_newno07     LIKE bgeg_t.bgeg007 
   DEFINE l_oldno07     LIKE bgeg_t.bgeg007 
   DEFINE l_newno08     LIKE bgeg_t.bgeg009 
   DEFINE l_oldno08     LIKE bgeg_t.bgeg009 
   DEFINE l_newno09     LIKE bgeg_t.bgeg010 
   DEFINE l_oldno09     LIKE bgeg_t.bgeg010 
 
   DEFINE l_master    RECORD LIKE bgeg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgeg_t.* #此變數樣板目前無使用
 
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
 
   IF g_bgeg_m.bgeg001 IS NULL
      OR g_bgeg_m.bgeg002 IS NULL
      OR g_bgeg_m.bgeg003 IS NULL
      OR g_bgeg_m.bgeg004 IS NULL
      OR g_bgeg_m.bgeg005 IS NULL
      OR g_bgeg_m.bgeg006 IS NULL
      OR g_bgeg_m.bgeg007 IS NULL
      OR g_bgeg_m.bgeg009 IS NULL
      OR g_bgeg_m.bgeg010 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
   LET g_bgeg010_t = g_bgeg_m.bgeg010
 
   
   LET g_bgeg_m.bgeg001 = ""
   LET g_bgeg_m.bgeg002 = ""
   LET g_bgeg_m.bgeg003 = ""
   LET g_bgeg_m.bgeg004 = ""
   LET g_bgeg_m.bgeg005 = ""
   LET g_bgeg_m.bgeg006 = ""
   LET g_bgeg_m.bgeg007 = ""
   LET g_bgeg_m.bgeg009 = ""
   LET g_bgeg_m.bgeg010 = ""
 
   LET g_master_insert = FALSE
   CALL abgt510_set_entry('a')
   CALL abgt510_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bgeg_m.bgeg001 = "20"
   LET g_bgeg_m.bgeg005 = "1"
   LET g_bgeg_m.bgeg006 = "1"
   LET g_bgeg_m.bgegstus = 'N'
   CASE g_bgeg_m.bgegstus 
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
   LET g_bgeg_m.bgeg011 = ''
   LET g_bgeg_m.bgaa002 = ''
   LET g_bgeg_m.bgaa003 = ''
   #end add-point
   
   #清空key欄位的desc
      LET g_bgeg_m.bgeg002_desc = ''
   DISPLAY BY NAME g_bgeg_m.bgeg002_desc
   LET g_bgeg_m.bgeg004_desc = ''
   DISPLAY BY NAME g_bgeg_m.bgeg004_desc
   LET g_bgeg_m.bgeg007_desc_t = ''
   DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
 
   
   CALL abgt510_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bgeg_m.* TO NULL
      INITIALIZE g_bgeg_d TO NULL
      INITIALIZE g_bgeg2_d TO NULL
      INITIALIZE g_bgeg3_d TO NULL
 
      CALL abgt510_show()
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
   CALL abgt510_set_act_visible()
   CALL abgt510_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
   LET g_bgeg010_t = g_bgeg_m.bgeg010
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                      " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                      ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                      ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                      ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                      ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                      ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
                      ," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
                      ," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
                      ," AND bgeg010 = '", g_bgeg_m.bgeg010, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgt510_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt510_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgeg_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_sql       STRING
   DEFINE l_bgeg001_t LIKE bgeg_t.bgeg001
   DEFINE l_bgeg002_t LIKE bgeg_t.bgeg002
   DEFINE l_bgeg003_t LIKE bgeg_t.bgeg003
   DEFINE l_bgeg004_t LIKE bgeg_t.bgeg004
   DEFINE l_bgeg005_t LIKE bgeg_t.bgeg005
   DEFINE l_bgeg006_t LIKE bgeg_t.bgeg006
   DEFINE l_bgeg007_t LIKE bgeg_t.bgeg007
   DEFINE l_bgeg009_t LIKE bgeg_t.bgeg009
   DEFINE l_success   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt510_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   IF 1=2 THEN
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgeg_t
    WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg001_t
    AND bgeg002 = g_bgeg002_t
    AND bgeg003 = g_bgeg003_t
    AND bgeg004 = g_bgeg004_t
    AND bgeg005 = g_bgeg005_t
    AND bgeg006 = g_bgeg006_t
    AND bgeg007 = g_bgeg007_t
    AND bgeg009 = g_bgeg009_t
    AND bgeg010 = g_bgeg010_t
 
       INTO TEMP abgt510_detail
   
   #將key修正為調整後   
   UPDATE abgt510_detail 
      #更新key欄位
      SET bgeg001 = g_bgeg_m.bgeg001
          , bgeg002 = g_bgeg_m.bgeg002
          , bgeg003 = g_bgeg_m.bgeg003
          , bgeg004 = g_bgeg_m.bgeg004
          , bgeg005 = g_bgeg_m.bgeg005
          , bgeg006 = g_bgeg_m.bgeg006
          , bgeg007 = g_bgeg_m.bgeg007
          , bgeg009 = g_bgeg_m.bgeg009
          , bgeg010 = g_bgeg_m.bgeg010
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgegownid = g_user 
       , bgegowndp = g_dept
       , bgegcrtid = g_user
       , bgegcrtdp = g_dept 
       , bgegcrtdt = ld_date
       , bgegmodid = g_user
       , bgegmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bgeg_t SELECT * FROM abgt510_detail
   
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
   
   LET l_sql = "SELECT * FROM bgeg_t",
               " WHERE bgegent =", g_enterprise," AND bgeg001 ='", g_bgeg001_t,"'",
               "   AND bgeg002 ='",g_bgeg002_t,"'",
               "   AND bgeg003 ='",g_bgeg003_t,"'",
               "   AND bgeg004 ='",g_bgeg004_t,"'",
               "   AND bgeg005 ='",g_bgeg005_t,"'",
               "   AND bgeg006 ='",g_bgeg006_t,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql,"   AND bgeg007 ='",g_bgeg007_t,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql,"   AND bgeg009 ='",g_bgeg009_t,"'"
   END IF
   LET l_sql = l_sql," INTO TEMP abgt510_detail"
   PREPARE abgt510_rep_pr FROM l_sql
   EXECUTE abgt510_rep_pr
   
   #將key修正為調整後   
   LET l_sql = "UPDATE abgt510_detail ",
               #更新key欄位
               "   SET bgeg001 = '",g_bgeg_m.bgeg001,"'",
               "      ,bgeg002 = '",g_bgeg_m.bgeg002,"'",
               "      ,bgeg003 = '",g_bgeg_m.bgeg003,"'",
               "      ,bgeg004 = '",g_bgeg_m.bgeg004,"'",
               "      ,bgeg005 = '",g_bgeg_m.bgeg005,"'",
               "      ,bgeg006 = '",g_bgeg_m.bgeg006,"'",
               
              #更新共用欄位
              #應用 a13 樣板自動產生(Version:4)
               "      ,bgegownid = '",g_user,"'", 
               "      ,bgegowndp = '",g_dept,"'",
               "      ,bgegcrtid = '",g_user,"'",
               "      ,bgegcrtdp = '",g_dept,"'", 
               "      ,bgegcrtdt = to_date('",ld_date,"','YYYY-MM-DD hh24:mi:ss') ",
               "      ,bgegmodid = '",g_user,"'",
               "      ,bgegmoddt =  to_date('",ld_date,"','YYYY-MM-DD hh24:mi:ss') ",
               "      ,bgegcnfid = NULL",
               "      ,bgegcnfdt = NULL",
               "      ,bgegstus = 'N'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql,"      ,bgeg007 = '",g_bgeg_m.bgeg007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql,"      ,bgeg009 = '",g_bgeg_m.bgeg009,"'"
   END IF
   
   PREPARE abgt510_rep_pr2 FROM l_sql
   EXECUTE abgt510_rep_pr2
                                       
   #將資料塞回原table   
   INSERT INTO bgeg_t SELECT * FROM abgt510_detail
   
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
   DROP TABLE abgt510_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   #记录旧值主键
   LET l_bgeg001_t = g_bgeg001_t
   LET l_bgeg002_t = g_bgeg002_t
   LET l_bgeg003_t = g_bgeg003_t
   LET l_bgeg004_t = g_bgeg004_t
   LET l_bgeg005_t = g_bgeg005_t
   LET l_bgeg006_t = g_bgeg006_t
   LET l_bgeg007_t = g_bgeg007_t
   LET l_bgeg009_t = g_bgeg009_t
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
   CALL abgt510_update_head() RETURNING l_success 
   IF l_success = FALSE THEN
      CALL s_transaction_end('N','0')
      #还原旧主键
      LET g_bgeg001_t = l_bgeg001_t 
      LET g_bgeg002_t = l_bgeg002_t 
      LET g_bgeg003_t = l_bgeg003_t 
      LET g_bgeg004_t = l_bgeg004_t 
      LET g_bgeg005_t = l_bgeg005_t 
      LET g_bgeg006_t = l_bgeg006_t 
      LET g_bgeg007_t = l_bgeg007_t 
      LET g_bgeg009_t = l_bgeg009_t 
      RETURN
   END IF
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
   LET g_bgeg010_t = g_bgeg_m.bgeg010
 
   
   DROP TABLE abgt510_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt510_delete()
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
   CALL abgt510_delete_1()
   RETURN
   #end add-point
   
   IF g_bgeg_m.bgeg001 IS NULL
   OR g_bgeg_m.bgeg002 IS NULL
   OR g_bgeg_m.bgeg003 IS NULL
   OR g_bgeg_m.bgeg004 IS NULL
   OR g_bgeg_m.bgeg005 IS NULL
   OR g_bgeg_m.bgeg006 IS NULL
   OR g_bgeg_m.bgeg007 IS NULL
   OR g_bgeg_m.bgeg009 IS NULL
   OR g_bgeg_m.bgeg010 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgt510_cl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt510_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010 INTO g_bgeg_m.bgeg002, 
       g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgeg010,g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg009,g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023, 
       g_bgeg_m.bgeg012,g_bgeg_m.bgeg015,g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg049, 
       g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc
   
   #遮罩相關處理
   LET g_bgeg_m_mask_o.* =  g_bgeg_m.*
   CALL abgt510_bgeg_t_mask()
   LET g_bgeg_m_mask_n.* =  g_bgeg_m.*
   
   CALL abgt510_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
 
      #end add-point
      
      DELETE FROM bgeg_t WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg_m.bgeg001
                                                               AND bgeg002 = g_bgeg_m.bgeg002
                                                               AND bgeg003 = g_bgeg_m.bgeg003
                                                               AND bgeg004 = g_bgeg_m.bgeg004
                                                               AND bgeg005 = g_bgeg_m.bgeg005
                                                               AND bgeg006 = g_bgeg_m.bgeg006
                                                               AND bgeg007 = g_bgeg_m.bgeg007
                                                               AND bgeg009 = g_bgeg_m.bgeg009
                                                               AND bgeg010 = g_bgeg_m.bgeg010
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
 
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
      #   CLOSE abgt510_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bgeg_d.clear() 
      CALL g_bgeg2_d.clear()       
      CALL g_bgeg3_d.clear()       
 
     
      CALL abgt510_ui_browser_refresh()  
      #CALL abgt510_ui_headershow()  
      #CALL abgt510_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt510_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt510_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt510_cl
 
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt510_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_bgeg010_str       STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bgeg_d.clear()
   CALL g_bgeg2_d.clear()
   CALL g_bgeg3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015, 
       bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, 
       bgeg100,bgeg008,bgeg047,bgeg048,bgeg050,bgegseq,bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt, 
       bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooag011 FROM bgeg_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgegownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgegowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgegcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgegcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgegmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgegcnfid  ",
 
               " WHERE bgegent= ? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=? AND bgeg007=? AND bgeg009=? AND bgeg010=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgeg_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #重写单身抓取sql
   #161220-00036#1--mod--str--
#   LET g_sql = "SELECT  DISTINCT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015, 
#       bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, 
#       bgeg100,bgeg101,0 bgeg008,bgeg047,'',bgeg050,bgegseq,bgegownid,bgegowndp, 
#       bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq,t1.ooag011 ,t2.ooefl003 , 
#       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 FROM bgeg_t",
   LET g_sql = "SELECT  DISTINCT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015,", 
       "bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, ",
       "bgeg100,0 bgeg008,bgeg047,'',bgeg050,bgegseq,bgegownid,bgegowndp, ",
       "bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq,t1.ooag011 ,t2.ooefl003 , ",
       "t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ",
       "  FROM bgeg_t",
   #161220-00036#1--mod--end       
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgegownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgegowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgegcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgegcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgegmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgegcnfid  ",
 
               " WHERE bgegent= ? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=? "  
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET g_sql = g_sql," AND bgeg007='",g_bgeg_m.bgeg007,"' "
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET g_sql = g_sql," AND bgeg009='",g_bgeg_m.bgeg009,"' "
   END IF
   
   #将单头核算项组成的组合码转换成查询条件
   LET l_bgeg010_str=g_bgeg_m.bgeg010
   IF cl_null(l_bgeg010_str) THEN
      LET l_bgeg010_str = " 1=1 "
   ELSE
      LET l_bgeg010_str=cl_replace_str(l_bgeg010_str,"=","='")
      LET l_bgeg010_str=cl_replace_str(l_bgeg010_str,"/","' AND ")
      LET l_bgeg010_str=l_bgeg010_str,"' "
   END IF
   LET g_sql = g_sql," AND ",l_bgeg010_str
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgeg_t")
   END IF
   LET g_sql = g_sql, " ORDER BY bgeg_t.bgegseq"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   PREPARE abgt510_pb_1 FROM g_sql
   DECLARE b_fill_cs_1 CURSOR FOR abgt510_pb_1
   OPEN b_fill_cs_1 USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006
   
   LET g_cnt = l_ac
   LET l_ac = 1                                            
   FOREACH b_fill_cs_1 INTO g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010,g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg009, 
       g_bgeg_d[l_ac].bgeg049,g_bgeg_d[l_ac].bgeg012,g_bgeg_d[l_ac].bgeg013,g_bgeg_d[l_ac].bgeg014, 
       g_bgeg_d[l_ac].bgeg015,g_bgeg_d[l_ac].bgeg016,g_bgeg_d[l_ac].bgeg017,g_bgeg_d[l_ac].bgeg018, 
       g_bgeg_d[l_ac].bgeg019,g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021,g_bgeg_d[l_ac].bgeg022, 
       g_bgeg_d[l_ac].bgeg023,g_bgeg_d[l_ac].bgeg024,g_bgeg_d[l_ac].bgeg035,g_bgeg_d[l_ac].bgeg036, 
#       g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg101,g_bgeg_d[l_ac].bgeg008, #161220-00036#1 mrk
       g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg008, #161220-00036#1 add
       g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048,g_bgeg_d[l_ac].bgeg050,g_bgeg2_d[l_ac].bgegseq,
       g_bgeg2_d[l_ac].bgegownid,g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid,
       g_bgeg2_d[l_ac].bgegcrtdp,g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid,
       g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt, 
       g_bgeg3_d[l_ac].bgegseq,g_bgeg2_d[l_ac].bgegownid_desc,g_bgeg2_d[l_ac].bgegowndp_desc,g_bgeg2_d[l_ac].bgegcrtid_desc, 
       g_bgeg2_d[l_ac].bgegcrtdp_desc,g_bgeg2_d[l_ac].bgegmodid_desc,g_bgeg2_d[l_ac].bgegcnfid_desc 
    
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF           
     
      #抓取项次对应的每个期别的数量、单价、销售金额
      CALL abgt510_get_num_and_price()
      #显示单身核算项说明
      CALL abgt510_detail_hsx_desc()
   
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
   CALL g_bgeg_d.deleteElement(g_bgeg_d.getLength())
   CALL g_bgeg2_d.deleteElement(g_bgeg2_d.getLength())
   
   DISPLAY g_rec_b TO FORMONLY.cnt    
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgeg_d.getLength()
      LET g_bgeg_d_mask_o[l_ac].* =  g_bgeg_d[l_ac].*
      CALL abgt510_bgeg_t_mask()
      LET g_bgeg_d_mask_n[l_ac].* =  g_bgeg_d[l_ac].*
   END FOR
   
   LET g_bgeg2_d_mask_o.* =  g_bgeg2_d.*
   FOR l_ac = 1 TO g_bgeg2_d.getLength()
      LET g_bgeg2_d_mask_o[l_ac].* =  g_bgeg2_d[l_ac].*
      CALL abgt510_bgeg_t_mask()
      LET g_bgeg2_d_mask_n[l_ac].* =  g_bgeg2_d[l_ac].*
   END FOR
   LET l_ac = g_cnt
   LET g_cnt = 0 
   
   #调整资讯页签填充单身
   CALL abgt510_b_fill2(l_ac)
   
   FREE abgt510_pb_1   
   RETURN
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgt510_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bgeg_t.bgeg008,bgeg_t.bgegseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt510_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt510_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
          g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg010 INTO g_bgeg_d[l_ac].bgegseq, 
          g_bgeg_d[l_ac].bgeg010,g_bgeg_d[l_ac].bgeg007,g_bgeg_d[l_ac].bgeg009,g_bgeg_d[l_ac].bgeg049, 
          g_bgeg_d[l_ac].bgeg012,g_bgeg_d[l_ac].bgeg013,g_bgeg_d[l_ac].bgeg014,g_bgeg_d[l_ac].bgeg015, 
          g_bgeg_d[l_ac].bgeg016,g_bgeg_d[l_ac].bgeg017,g_bgeg_d[l_ac].bgeg018,g_bgeg_d[l_ac].bgeg019, 
          g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021,g_bgeg_d[l_ac].bgeg022,g_bgeg_d[l_ac].bgeg023, 
          g_bgeg_d[l_ac].bgeg024,g_bgeg_d[l_ac].bgeg035,g_bgeg_d[l_ac].bgeg036,g_bgeg_d[l_ac].bgeg037, 
          g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg008,g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048, 
          g_bgeg_d[l_ac].bgeg050,g_bgeg2_d[l_ac].bgegseq,g_bgeg2_d[l_ac].bgegownid,g_bgeg2_d[l_ac].bgegowndp, 
          g_bgeg2_d[l_ac].bgegcrtid,g_bgeg2_d[l_ac].bgegcrtdp,g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid, 
          g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt,g_bgeg3_d[l_ac].bgegseq, 
          g_bgeg2_d[l_ac].bgegownid_desc,g_bgeg2_d[l_ac].bgegowndp_desc,g_bgeg2_d[l_ac].bgegcrtid_desc, 
          g_bgeg2_d[l_ac].bgegcrtdp_desc,g_bgeg2_d[l_ac].bgegmodid_desc,g_bgeg2_d[l_ac].bgegcnfid_desc  
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
 
            CALL g_bgeg_d.deleteElement(g_bgeg_d.getLength())
      CALL g_bgeg2_d.deleteElement(g_bgeg2_d.getLength())
      CALL g_bgeg3_d.deleteElement(g_bgeg3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
  
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgeg_d.getLength()
      LET g_bgeg_d_mask_o[l_ac].* =  g_bgeg_d[l_ac].*
      CALL abgt510_bgeg_t_mask()
      LET g_bgeg_d_mask_n[l_ac].* =  g_bgeg_d[l_ac].*
   END FOR
   
   LET g_bgeg2_d_mask_o.* =  g_bgeg2_d.*
   FOR l_ac = 1 TO g_bgeg2_d.getLength()
      LET g_bgeg2_d_mask_o[l_ac].* =  g_bgeg2_d[l_ac].*
      CALL abgt510_bgeg_t_mask()
      LET g_bgeg2_d_mask_n[l_ac].* =  g_bgeg2_d[l_ac].*
   END FOR
   LET g_bgeg3_d_mask_o.* =  g_bgeg3_d.*
   FOR l_ac = 1 TO g_bgeg3_d.getLength()
      LET g_bgeg3_d_mask_o[l_ac].* =  g_bgeg3_d[l_ac].*
      CALL abgt510_bgeg_t_mask()
      LET g_bgeg3_d_mask_n[l_ac].* =  g_bgeg3_d[l_ac].*
   END FOR
 
 
   FREE abgt510_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt510_idx_chk()
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
      IF g_detail_idx > g_bgeg_d.getLength() THEN
         LET g_detail_idx = g_bgeg_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgeg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgeg_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgeg2_d.getLength() THEN
         LET g_detail_idx = g_bgeg2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgeg2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgeg2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_bgeg3_d.getLength() THEN
         LET g_detail_idx = g_bgeg3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgeg3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgeg3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt510_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_bgeg038       LIKE bgeg_t.bgeg038
   DEFINE l_bgeg039       LIKE bgeg_t.bgeg039
   DEFINE l_bgeg040       LIKE bgeg_t.bgeg040
   DEFINE l_bgeg041       LIKE bgeg_t.bgeg041
   DEFINE l_bgeg042       LIKE bgeg_t.bgeg042
   DEFINE l_bgeg043       LIKE bgeg_t.bgeg043
   DEFINE l_bgeg044       LIKE bgeg_t.bgeg044
   DEFINE l_bgeg045       LIKE bgeg_t.bgeg045
   DEFINE l_bgeg046       LIKE bgeg_t.bgeg046
   DEFINE l_bgeg102       LIKE bgeg_t.bgeg102
   DEFINE l_amt1          LIKE bgeg_t.bgeg040
   DEFINE l_amt2          LIKE bgeg_t.bgeg040
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bgeg_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF pi_idx < 1 THEN
      RETURN
   END IF
   
   CALL g_bgeg3_d.clear()
   
   LET l_sql="SELECT bgeg038,bgeg039,bgeg040,bgeg041,bgeg042,bgeg043,bgeg044,bgeg045,bgeg046,bgeg102",
             "  FROM bgeg_t ",
             " WHERE bgegent =  ",g_enterprise,
             "   AND bgeg001 = '",g_bgeg_m.bgeg001,"'",
             "   AND bgeg002 = '",g_bgeg_m.bgeg002,"'",
             "   AND bgeg003 = '",g_bgeg_m.bgeg003,"'",
             "   AND bgeg004 = '",g_bgeg_m.bgeg004,"'",
             "   AND bgeg005 = '",g_bgeg_m.bgeg005,"'",
             "   AND bgeg006 = '",g_bgeg_m.bgeg006,"'",
             "   AND bgeg010 = '",g_bgeg_d[pi_idx].bgeg010,"'",
             "   AND bgegseq =  ",g_bgeg_d[pi_idx].bgegseq,
             "   AND bgeg008 = ? "
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg_m.bgeg007,"'"
   ELSE
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg_d[pi_idx].bgeg007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg_m.bgeg009,"'"
   ELSE
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg_d[pi_idx].bgeg009,"'"
   END IF
   PREPARE abgt510_b_fill2_pr FROM l_sql
   
   
   #第一行：基准金额
   LET g_bgeg3_d[1].bgegseq = g_bgeg_d[pi_idx].bgegseq #项次
   LET g_bgeg3_d[1].content = '1'
   #第二行：本层调整
   LET g_bgeg3_d[2].bgegseq = g_bgeg_d[pi_idx].bgegseq #项次
   LET g_bgeg3_d[2].content = '2'
   #第三行：上层调整
   LET g_bgeg3_d[3].bgegseq = g_bgeg_d[pi_idx].bgegseq #项次
   LET g_bgeg3_d[3].content = '3'
   #第四行：核准金额   
   LET g_bgeg3_d[4].bgegseq = g_bgeg_d[pi_idx].bgegseq #项次
   LET g_bgeg3_d[4].content = '4'
   FOR l_i = 1 TO g_max_period
      #161220-00036#1--add--str--
      LET l_bgeg038 = 0
      LET l_bgeg039 = 0
      LET l_bgeg040 = 0
      LET l_bgeg041 = 0
      LET l_bgeg042 = 0
      LET l_bgeg043 = 0
      LET l_bgeg044 = 0
      LET l_bgeg045 = 0
      LET l_bgeg046 = 0
      LET l_bgeg102 = 0
      LET l_amt1 = 0
      LET l_amt2 = 0
      #161220-00036#1--add--end
      EXECUTE abgt510_b_fill2_pr USING l_i
      INTO l_bgeg038,l_bgeg039,l_bgeg040,l_bgeg041,l_bgeg042,l_bgeg043,
           l_bgeg044,l_bgeg045,l_bgeg046,l_bgeg102 
      #调整金额=调整数量*（基准单价+调整单价）+基准数量*调整单价
      #本层调整金额
      LET l_amt1 = l_bgeg041 * (l_bgeg039 + l_bgeg042) + l_bgeg038 * l_bgeg042
      #上层调整
      LET l_amt2 = l_bgeg043 * (l_bgeg039 + l_bgeg044) + l_bgeg038 * l_bgeg044       
      CASE l_i
         WHEN 1 
            LET g_bgeg3_d[1].tnum1 = l_bgeg038
            LET g_bgeg3_d[1].tprice1 = l_bgeg039
            LET g_bgeg3_d[1].tamt1 = l_bgeg040
            LET g_bgeg3_d[2].tnum1 = l_bgeg041
            LET g_bgeg3_d[2].tprice1 = l_bgeg042
            LET g_bgeg3_d[2].tamt1 = l_amt1
            LET g_bgeg3_d[3].tnum1 = l_bgeg043
            LET g_bgeg3_d[3].tprice1 = l_bgeg044
            LET g_bgeg3_d[3].tamt1 = l_amt2
            LET g_bgeg3_d[4].tnum1 = l_bgeg045
            LET g_bgeg3_d[4].tprice1 = l_bgeg046
            LET g_bgeg3_d[4].tamt1 = l_bgeg102
         WHEN 2 
            LET g_bgeg3_d[1].tnum2 = l_bgeg038
            LET g_bgeg3_d[1].tprice2 = l_bgeg039
            LET g_bgeg3_d[1].tamt2 = l_bgeg040
            LET g_bgeg3_d[2].tnum2 = l_bgeg041
            LET g_bgeg3_d[2].tprice2 = l_bgeg042
            LET g_bgeg3_d[2].tamt2 = l_amt1
            LET g_bgeg3_d[3].tnum2 = l_bgeg043
            LET g_bgeg3_d[3].tprice2 = l_bgeg044
            LET g_bgeg3_d[3].tamt2 = l_amt2
            LET g_bgeg3_d[4].tnum2 = l_bgeg045
            LET g_bgeg3_d[4].tprice2 = l_bgeg046
            LET g_bgeg3_d[4].tamt2 = l_bgeg102
         WHEN 3 
            LET g_bgeg3_d[1].tnum3 = l_bgeg038
            LET g_bgeg3_d[1].tprice3 = l_bgeg039
            LET g_bgeg3_d[1].tamt3 = l_bgeg040
            LET g_bgeg3_d[2].tnum3 = l_bgeg041
            LET g_bgeg3_d[2].tprice3 = l_bgeg042
            LET g_bgeg3_d[2].tamt3 = l_amt1
            LET g_bgeg3_d[3].tnum3 = l_bgeg043
            LET g_bgeg3_d[3].tprice3 = l_bgeg044
            LET g_bgeg3_d[3].tamt3 = l_amt2
            LET g_bgeg3_d[4].tnum3 = l_bgeg045
            LET g_bgeg3_d[4].tprice3 = l_bgeg046
            LET g_bgeg3_d[4].tamt3 = l_bgeg102
         WHEN 4 
            LET g_bgeg3_d[1].tnum4 = l_bgeg038
            LET g_bgeg3_d[1].tprice4 = l_bgeg039
            LET g_bgeg3_d[1].tamt4 = l_bgeg040
            LET g_bgeg3_d[2].tnum4 = l_bgeg041
            LET g_bgeg3_d[2].tprice4 = l_bgeg042
            LET g_bgeg3_d[2].tamt4 = l_amt1
            LET g_bgeg3_d[3].tnum4 = l_bgeg043
            LET g_bgeg3_d[3].tprice4 = l_bgeg044
            LET g_bgeg3_d[3].tamt4 = l_amt2
            LET g_bgeg3_d[4].tnum4 = l_bgeg045
            LET g_bgeg3_d[4].tprice4 = l_bgeg046
            LET g_bgeg3_d[4].tamt4 = l_bgeg102
         WHEN 5
            LET g_bgeg3_d[1].tnum5 = l_bgeg038
            LET g_bgeg3_d[1].tprice5 = l_bgeg039
            LET g_bgeg3_d[1].tamt5 = l_bgeg040
            LET g_bgeg3_d[2].tnum5 = l_bgeg041
            LET g_bgeg3_d[2].tprice5 = l_bgeg042
            LET g_bgeg3_d[2].tamt5 = l_amt1
            LET g_bgeg3_d[3].tnum5 = l_bgeg043
            LET g_bgeg3_d[3].tprice5 = l_bgeg044
            LET g_bgeg3_d[3].tamt5 = l_amt2
            LET g_bgeg3_d[4].tnum5 = l_bgeg045
            LET g_bgeg3_d[4].tprice5 = l_bgeg046
            LET g_bgeg3_d[4].tamt5 = l_bgeg102
         WHEN 6 
            LET g_bgeg3_d[1].tnum6 = l_bgeg038
            LET g_bgeg3_d[1].tprice6 = l_bgeg039
            LET g_bgeg3_d[1].tamt6 = l_bgeg040
            LET g_bgeg3_d[2].tnum6 = l_bgeg041
            LET g_bgeg3_d[2].tprice6 = l_bgeg042
            LET g_bgeg3_d[2].tamt6 = l_amt1
            LET g_bgeg3_d[3].tnum6 = l_bgeg043
            LET g_bgeg3_d[3].tprice6 = l_bgeg044
            LET g_bgeg3_d[3].tamt6 = l_amt2
            LET g_bgeg3_d[4].tnum6 = l_bgeg045
            LET g_bgeg3_d[4].tprice6 = l_bgeg046
            LET g_bgeg3_d[4].tamt6 = l_bgeg102
         WHEN 7 
            LET g_bgeg3_d[1].tnum7 = l_bgeg038
            LET g_bgeg3_d[1].tprice7 = l_bgeg039
            LET g_bgeg3_d[1].tamt7 = l_bgeg040
            LET g_bgeg3_d[2].tnum7 = l_bgeg041
            LET g_bgeg3_d[2].tprice7 = l_bgeg042
            LET g_bgeg3_d[2].tamt7 = l_amt1
            LET g_bgeg3_d[3].tnum7 = l_bgeg043
            LET g_bgeg3_d[3].tprice7 = l_bgeg044
            LET g_bgeg3_d[3].tamt7 = l_amt2
            LET g_bgeg3_d[4].tnum7 = l_bgeg045
            LET g_bgeg3_d[4].tprice7 = l_bgeg046
            LET g_bgeg3_d[4].tamt7 = l_bgeg102
         WHEN 8 
            LET g_bgeg3_d[1].tnum8 = l_bgeg038
            LET g_bgeg3_d[1].tprice8 = l_bgeg039
            LET g_bgeg3_d[1].tamt8 = l_bgeg040
            LET g_bgeg3_d[2].tnum8 = l_bgeg041
            LET g_bgeg3_d[2].tprice8 = l_bgeg042
            LET g_bgeg3_d[2].tamt8 = l_amt1
            LET g_bgeg3_d[3].tnum8 = l_bgeg043
            LET g_bgeg3_d[3].tprice8 = l_bgeg044
            LET g_bgeg3_d[3].tamt8 = l_amt2
            LET g_bgeg3_d[4].tnum8 = l_bgeg045
            LET g_bgeg3_d[4].tprice8 = l_bgeg046
            LET g_bgeg3_d[4].tamt8 = l_bgeg102
         WHEN 9 
            LET g_bgeg3_d[1].tnum9 = l_bgeg038
            LET g_bgeg3_d[1].tprice9 = l_bgeg039
            LET g_bgeg3_d[1].tamt9 = l_bgeg040
            LET g_bgeg3_d[2].tnum9 = l_bgeg041
            LET g_bgeg3_d[2].tprice9 = l_bgeg042
            LET g_bgeg3_d[2].tamt9 = l_amt1
            LET g_bgeg3_d[3].tnum9 = l_bgeg043
            LET g_bgeg3_d[3].tprice9 = l_bgeg044
            LET g_bgeg3_d[3].tamt9 = l_amt2
            LET g_bgeg3_d[4].tnum9 = l_bgeg045
            LET g_bgeg3_d[4].tprice9 = l_bgeg046
            LET g_bgeg3_d[4].tamt9 = l_bgeg102
         WHEN 10 
            LET g_bgeg3_d[1].tnum10 = l_bgeg038
            LET g_bgeg3_d[1].tprice10 = l_bgeg039
            LET g_bgeg3_d[1].tamt10 = l_bgeg040
            LET g_bgeg3_d[2].tnum10 = l_bgeg041
            LET g_bgeg3_d[2].tprice10 = l_bgeg042
            LET g_bgeg3_d[2].tamt10 = l_amt1
            LET g_bgeg3_d[3].tnum10 = l_bgeg043
            LET g_bgeg3_d[3].tprice10 = l_bgeg044
            LET g_bgeg3_d[3].tamt10 = l_amt2
            LET g_bgeg3_d[4].tnum10 = l_bgeg045
            LET g_bgeg3_d[4].tprice10 = l_bgeg046
            LET g_bgeg3_d[4].tamt10 = l_bgeg102
         WHEN 11 
            LET g_bgeg3_d[1].tnum11 = l_bgeg038
            LET g_bgeg3_d[1].tprice11 = l_bgeg039
            LET g_bgeg3_d[1].tamt11 = l_bgeg040
            LET g_bgeg3_d[2].tnum11 = l_bgeg041
            LET g_bgeg3_d[2].tprice11 = l_bgeg042
            LET g_bgeg3_d[2].tamt11 = l_amt1
            LET g_bgeg3_d[3].tnum11 = l_bgeg043
            LET g_bgeg3_d[3].tprice11 = l_bgeg044
            LET g_bgeg3_d[3].tamt11 = l_amt2
            LET g_bgeg3_d[4].tnum11 = l_bgeg045
            LET g_bgeg3_d[4].tprice11 = l_bgeg046
            LET g_bgeg3_d[4].tamt11 = l_bgeg102
         WHEN 12 
            LET g_bgeg3_d[1].tnum12 = l_bgeg038
            LET g_bgeg3_d[1].tprice12 = l_bgeg039
            LET g_bgeg3_d[1].tamt12 = l_bgeg040
            LET g_bgeg3_d[2].tnum12 = l_bgeg041
            LET g_bgeg3_d[2].tprice12 = l_bgeg042
            LET g_bgeg3_d[2].tamt12 = l_amt1
            LET g_bgeg3_d[3].tnum12 = l_bgeg043
            LET g_bgeg3_d[3].tprice12 = l_bgeg044
            LET g_bgeg3_d[3].tamt12 = l_amt2
            LET g_bgeg3_d[4].tnum12 = l_bgeg045
            LET g_bgeg3_d[4].tprice12 = l_bgeg046
            LET g_bgeg3_d[4].tamt12 = l_bgeg102
         WHEN 13 
            LET g_bgeg3_d[1].tnum13 = l_bgeg038
            LET g_bgeg3_d[1].tprice13 = l_bgeg039
            LET g_bgeg3_d[1].tamt13 = l_bgeg040
            LET g_bgeg3_d[2].tnum13 = l_bgeg041
            LET g_bgeg3_d[2].tprice13 = l_bgeg042
            LET g_bgeg3_d[2].tamt13 = l_amt1
            LET g_bgeg3_d[3].tnum13 = l_bgeg043
            LET g_bgeg3_d[3].tprice13 = l_bgeg044
            LET g_bgeg3_d[3].tamt13 = l_amt2
            LET g_bgeg3_d[4].tnum13 = l_bgeg045
            LET g_bgeg3_d[4].tprice13 = l_bgeg046
            LET g_bgeg3_d[4].tamt13 = l_bgeg102
      END CASE
   END FOR
   
   #合计
   LET l_sql="SELECT SUM(bgeg040),",
             "       SUM(bgeg041 * (bgeg039 + bgeg042) + bgeg038 * bgeg042),",
             "       SUM(bgeg043 * (bgeg039 + bgeg044) + bgeg038 * bgeg044),",
             "       SUM(bgeg102)",
             "  FROM bgeg_t ",
             " WHERE bgegent =  ",g_enterprise,
             "   AND bgeg001 = '",g_bgeg_m.bgeg001,"'",
             "   AND bgeg002 = '",g_bgeg_m.bgeg002,"'",
             "   AND bgeg003 = '",g_bgeg_m.bgeg003,"'",
             "   AND bgeg004 = '",g_bgeg_m.bgeg004,"'",
             "   AND bgeg005 = '",g_bgeg_m.bgeg005,"'",
             "   AND bgeg006 = '",g_bgeg_m.bgeg006,"'",
             "   AND bgeg010 = '",g_bgeg_d[pi_idx].bgeg010,"'",
             "   AND bgegseq =  ",g_bgeg_d[pi_idx].bgegseq
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg_m.bgeg007,"'"
   ELSE
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg_d[pi_idx].bgeg007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg_m.bgeg009,"'"
   ELSE
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg_d[pi_idx].bgeg009,"'"
   END IF
   PREPARE abgt510_b_fill2_sum_pr FROM l_sql
   EXECUTE abgt510_b_fill2_sum_pr INTO g_bgeg3_d[1].sum,g_bgeg3_d[2].sum,g_bgeg3_d[3].sum,g_bgeg3_d[4].sum 
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgt510_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   DEFINE l_sql           STRING
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   IF 1=2 THEN
   #end add-point
   
   DELETE FROM bgeg_t
    WHERE bgegent = g_enterprise AND bgeg001 = g_bgeg_m.bgeg001 AND
                              bgeg002 = g_bgeg_m.bgeg002 AND
                              bgeg003 = g_bgeg_m.bgeg003 AND
                              bgeg004 = g_bgeg_m.bgeg004 AND
                              bgeg005 = g_bgeg_m.bgeg005 AND
                              bgeg006 = g_bgeg_m.bgeg006 AND
                              bgeg007 = g_bgeg_m.bgeg007 AND
                              bgeg009 = g_bgeg_m.bgeg009 AND
                              bgeg010 = g_bgeg_m.bgeg010 AND
 
          bgeg008 = g_bgeg_d_t.bgeg008
      AND bgegseq = g_bgeg_d_t.bgegseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   END IF
   
   LET l_sql = "DELETE FROM bgeg_t ",
                " WHERE bgegent = ",g_enterprise,
                "   AND bgeg001 ='",g_bgeg_m.bgeg001,"'",
                "   AND bgeg002 ='",g_bgeg_m.bgeg002,"'",
                "   AND bgeg003 ='",g_bgeg_m.bgeg003,"'",
                "   AND bgeg004 ='",g_bgeg_m.bgeg004,"'",
                "   AND bgeg005 ='",g_bgeg_m.bgeg005,"'",
                "   AND bgeg006 ='",g_bgeg_m.bgeg006,"'"
    #预算组织在单头
    IF g_bgaw1[1] = 'Y' THEN
       LET l_sql = l_sql," AND bgeg007 ='",g_bgeg_m.bgeg007,"'"
    ELSE
       LET l_sql = l_sql," AND bgeg007 ='",g_bgeg_d_t.bgeg007,"'"
    END IF
    #预算料号在单头
    IF g_bgaw1[2] = 'Y' THEN
       LET l_sql = l_sql," AND bgeg009 ='",g_bgeg_m.bgeg009,"'"
    ELSE
       LET l_sql = l_sql," AND bgeg009 ='",g_bgeg_d_t.bgeg009,"'"
    END IF
    LET l_sql = l_sql," AND bgeg010 ='",g_bgeg_d_t.bgeg010,"'",
                      " AND bgegseq = ",g_bgeg_d_t.bgegseq
                      
    PREPARE abgt510_before_delete_pr FROM l_sql
    EXECUTE abgt510_before_delete_pr
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
 
{<section id="abgt510.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt510_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgt510.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt510_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgt510.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt510_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgt510.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgt510_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bgeg_d[l_ac].bgeg008 = g_bgeg_d_t.bgeg008 
      AND g_bgeg_d[l_ac].bgegseq = g_bgeg_d_t.bgegseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt510_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgt510.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt510_lock_b(ps_table,ps_page)
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
   #CALL abgt510_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt510.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt510_unlock_b(ps_table,ps_page)
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
 
{<section id="abgt510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt510_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg009,bgeg010",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bgeg006",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg009,bgeg010",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("bgeg007,bgeg009",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt510.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt510_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt510_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt510_set_act_visible()
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
 
{<section id="abgt510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt510_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bgeg_m.bgegstus NOT MATCHES "[NDR]" THEN   
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt510.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt510_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt510.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt510_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt510_default_search()
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
      LET ls_wc = ls_wc, " bgeg001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgeg002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bgeg003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bgeg004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bgeg005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bgeg006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " bgeg007 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " bgeg009 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " bgeg010 = '", g_argv[09], "' AND "
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
 
{<section id="abgt510.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt510_fill_chk(ps_idx)
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
 
{<section id="abgt510.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgt510_modify_detail_chk(ps_record)
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
         LET ls_return = "bgegseq"
      WHEN "s_detail2"
         LET ls_return = "bgegseq_2"
      WHEN "s_detail3"
         LET ls_return = "bgegseq_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgt510.mask_functions" >}
&include "erp/abg/abgt510_mask.4gl"
 
{</section>}
 
{<section id="abgt510.state_change" >}
    
 
{</section>}
 
{<section id="abgt510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt510_set_pk_array()
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
   LET g_pk_array[1].values = g_bgeg_m.bgeg001
   LET g_pk_array[1].column = 'bgeg001'
   LET g_pk_array[2].values = g_bgeg_m.bgeg002
   LET g_pk_array[2].column = 'bgeg002'
   LET g_pk_array[3].values = g_bgeg_m.bgeg003
   LET g_pk_array[3].column = 'bgeg003'
   LET g_pk_array[4].values = g_bgeg_m.bgeg004
   LET g_pk_array[4].column = 'bgeg004'
   LET g_pk_array[5].values = g_bgeg_m.bgeg005
   LET g_pk_array[5].column = 'bgeg005'
   LET g_pk_array[6].values = g_bgeg_m.bgeg006
   LET g_pk_array[6].column = 'bgeg006'
   LET g_pk_array[7].values = g_bgeg_m.bgeg007
   LET g_pk_array[7].column = 'bgeg007'
   LET g_pk_array[8].values = g_bgeg_m.bgeg009
   LET g_pk_array[8].column = 'bgeg009'
   LET g_pk_array[9].values = g_bgeg_m.bgeg010
   LET g_pk_array[9].column = 'bgeg010'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt510_msgcentre_notify(lc_state)
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
   CALL abgt510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgeg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt510.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 设置核算项在单头或是单身，以及是否显示
# Memo...........:
# Usage..........: CALL abgt510_set_hsx_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/28 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_set_hsx_visible()
   DEFINE l_flag1        LIKE type_t.num5 #单头显示核算项个数
   
   LET l_flag1 = 0
   #单头显示栏位
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg007,bgeg007_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg007,bgeg007_desc_t",FALSE)
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg009",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg009",FALSE)
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg013,bgeg013_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg013,bgeg013_desc_t",FALSE)
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg014,bgeg014_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg014,bgeg014_desc_t",FALSE)
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg015,bgeg015_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg015,bgeg015_desc_t",FALSE)
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg016,bgeg016_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg016,bgeg016_desc_t",FALSE)
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg017,bgeg017_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg017,bgeg017_desc_t",FALSE)
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg018,bgeg018_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg018,bgeg018_desc_t",FALSE)
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg019,bgeg019_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg019,bgeg019_desc_t",FALSE)
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg022",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg022",FALSE)
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg023,bgeg023_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg023,bgeg023_desc_t",FALSE)
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg024,bgeg024_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg024,bgeg024_desc_t",FALSE)
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg012,bgeg012_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg012,bgeg012_desc_t",FALSE)
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg020,bgeg020_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg020,bgeg020_desc_t",FALSE)
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg021,bgeg021_desc_t",TRUE)
      LET l_flag1 = l_flag1 + 1
   ELSE
      CALL cl_set_comp_visible("bgeg021,bgeg021_desc_t",FALSE)
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
      CALL cl_set_comp_visible("bgeg007_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg007_desc",FALSE)
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg009_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg009_desc",FALSE)
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg013_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg013_desc",FALSE)
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg014_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg014_desc",FALSE)
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg015_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg015_desc",FALSE)
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg016_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg016_desc",FALSE)
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg017_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg017_desc",FALSE)
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg018_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg018_desc",FALSE)
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg019_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg019_desc",FALSE)
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg022_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg022_2",FALSE)
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg023_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg023_desc",FALSE)
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg024_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg024_desc",FALSE)
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg012_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg012_desc",FALSE)
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg020_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg020_desc",FALSE)
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      CALL cl_set_comp_visible("bgeg021_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("bgeg021_desc",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据预算编号+预算组织+预算细项设置核算项的启用情况，启用时可以录入，不启用时不可录入，默认给空白
# Memo...........:
# Usage..........: CALL abgt510_set_head_hsx_entry(p_bgeg002,p_bgeg007,p_bgeg049)
# Input parameter: p_bgeg002      预算编号
#                : p_bgeg007      预算组织
#                : p_bgeg049      预算细项
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_set_head_hsx_entry(p_bgeg002,p_bgeg007,p_bgeg049)
   DEFINE p_bgeg002       LIKE bgeg_t.bgeg002
   DEFINE p_bgeg007       LIKE bgeg_t.bgeg007
   DEFINE p_bgeg049       LIKE bgeg_t.bgeg049
   
   IF cl_null(p_bgeg002) OR cl_null(p_bgeg007) OR cl_null(p_bgeg049) THEN
      RETURN
   END IF
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=p_bgeg002
      AND bgal002=p_bgeg007 AND bgal003=p_bgeg049
   #单头核算项栏位录入设置
   #部门
   IF g_bgaw1[3]='Y' THEN
      IF g_bgal.bgal005 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg013",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg013",FALSE)
         LET g_bgeg_m.bgeg013 = ' '
         LET g_bgeg_m.bgeg013_desc_t = ''
      END IF
   END IF
   #利润成本中心
   IF g_bgaw1[4]='Y' THEN
      IF g_bgal.bgal006 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg014",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg014",FALSE)
         LET g_bgeg_m.bgeg014 = ' '
         LET g_bgeg_m.bgeg014_desc_t = ''
      END IF
   END IF
   #区域
   IF g_bgaw1[5]='Y' THEN
      IF g_bgal.bgal007 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg015",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg015",FALSE)
         LET g_bgeg_m.bgeg015 = ' '
         LET g_bgeg_m.bgeg015_desc_t = ''
      END IF
   END IF
   #收付款客商
   IF g_bgaw1[6]='Y' THEN
      IF g_bgal.bgal008 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg016",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg016",FALSE)
         LET g_bgeg_m.bgeg016 = ' '
         LET g_bgeg_m.bgeg016_desc_t = ''
      END IF
   END IF 
   #账款客商
   IF g_bgaw1[7]='Y' THEN
      IF g_bgal.bgal009 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg017",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg017",FALSE)
         LET g_bgeg_m.bgeg017 = ' '
         LET g_bgeg_m.bgeg017_desc_t = ''
      END IF
   END IF  
   #客群
   IF g_bgaw1[8]='Y' THEN
      IF g_bgal.bgal010 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg018",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg018",FALSE)
         LET g_bgeg_m.bgeg018 = ' '
         LET g_bgeg_m.bgeg018_desc_t = ''
      END IF
   END IF
   #产品类别
   IF g_bgaw1[9]='Y' THEN
      IF g_bgal.bgal011 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg019",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg019",FALSE)
         LET g_bgeg_m.bgeg019 = ' '
         LET g_bgeg_m.bgeg019_desc_t = ''
      END IF
   END IF
   #经营方式
   IF g_bgaw1[10]='Y' THEN
      IF g_bgal.bgal025 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg022",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg022",FALSE)
         LET g_bgeg_m.bgeg022 = ' '
      END IF
   END IF
   #通路
   IF g_bgaw1[11]='Y' THEN
      IF g_bgal.bgal026 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg023",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg023",FALSE)
         LET g_bgeg_m.bgeg023 = ' '
         LET g_bgeg_m.bgeg023_desc_t = ''
      END IF
   END IF
   #品牌
   IF g_bgaw1[12]='Y' THEN
      IF g_bgal.bgal027 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg024",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg024",FALSE)
         LET g_bgeg_m.bgeg024 = ' '
         LET g_bgeg_m.bgeg024_desc_t = ''
      END IF
   END IF
   #人员
   IF g_bgaw1[13]='Y' THEN
      IF g_bgal.bgal012 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg012",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg012",FALSE)
         LET g_bgeg_m.bgeg012 = ' '
         LET g_bgeg_m.bgeg012_desc_t = ''
      END IF
   END IF
   #专案
   IF g_bgaw1[14]='Y' THEN
      IF g_bgal.bgal013 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg020",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg020",FALSE)
         LET g_bgeg_m.bgeg020 = ' '
         LET g_bgeg_m.bgeg020_desc_t = ''
      END IF
   END IF
   #WBS
   IF g_bgaw1[15]='Y' THEN
      IF g_bgal.bgal014 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg021",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg021",FALSE)
         LET g_bgeg_m.bgeg021 = ' '
         LET g_bgeg_m.bgeg021_desc_t = ''
      END IF
   END IF
   DISPLAY BY NAME g_bgeg_m.bgeg013,g_bgeg_m.bgeg014,g_bgeg_m.bgeg015,g_bgeg_m.bgeg016,g_bgeg_m.bgeg017,
                   g_bgeg_m.bgeg018,g_bgeg_m.bgeg019,g_bgeg_m.bgeg020,g_bgeg_m.bgeg021,g_bgeg_m.bgeg022,
                   g_bgeg_m.bgeg023,g_bgeg_m.bgeg024,
                   g_bgeg_m.bgeg013_desc_t,g_bgeg_m.bgeg014_desc_t,g_bgeg_m.bgeg015_desc_t,g_bgeg_m.bgeg016_desc_t,
                   g_bgeg_m.bgeg017_desc_t,g_bgeg_m.bgeg018_desc_t,g_bgeg_m.bgeg019_desc_t,g_bgeg_m.bgeg020_desc_t,
                   g_bgeg_m.bgeg021_desc_t,g_bgeg_m.bgeg023_desc_t,g_bgeg_m.bgeg024_desc_t
   
END FUNCTION

################################################################################
# Descriptions...: 根据预算编号+预算组织+预算细项设置核算项的启用情况，启用时可以录入，不启用时不可录入，默认给空白
# Memo...........:
# Usage..........: CALL abgt510_set_detail_hsx_entry(p_bgeg002,p_bgeg007,p_bgeg049)
# Input parameter: p_bgeg002      预算编号
#                : p_bgeg007      预算组织
#                : p_bgeg049      预算细项
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_set_detail_hsx_entry(p_bgeg002,p_bgeg007,p_bgeg049)
   DEFINE p_bgeg002       LIKE bgeg_t.bgeg002
   DEFINE p_bgeg007       LIKE bgeg_t.bgeg007
   DEFINE p_bgeg049       LIKE bgeg_t.bgeg049
   
   IF cl_null(p_bgeg002) OR cl_null(p_bgeg007) OR cl_null(p_bgeg049) THEN
      RETURN
   END IF
   
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=p_bgeg002
      AND bgal002=p_bgeg007 AND bgal003=p_bgeg049
   #单身核算项栏位录入设置
   #部门
   IF g_bgaw2[3]='Y' THEN
      IF g_bgal.bgal005 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg013_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg013_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg013 = ' '
      END IF
   END IF
   #利润成本中心
   IF g_bgaw2[4]='Y' THEN
      IF g_bgal.bgal006 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg014_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg014_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg014 = ' '
      END IF
   END IF
   #区域
   IF g_bgaw2[5]='Y' THEN
      IF g_bgal.bgal007 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg015_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg015_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg015 = ' '
      END IF
   END IF
   #收付款客商
   IF g_bgaw2[6]='Y' THEN
      IF g_bgal.bgal008 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg016_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg016_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg016 = ' '
      END IF
   END IF 
   #账款客商
   IF g_bgaw2[7]='Y' THEN
      IF g_bgal.bgal009 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg017_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg017_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg017 = ' '
      END IF
   END IF  
   #客群
   IF g_bgaw2[8]='Y' THEN
      IF g_bgal.bgal010 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg018_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg018_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg018 = ' '
      END IF
   END IF
   #产品类别
   IF g_bgaw2[9]='Y' THEN
      IF g_bgal.bgal011 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg019_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg019_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg019 = ' '
      END IF
   END IF
   #经营方式
   IF g_bgaw2[10]='Y' THEN
      IF g_bgal.bgal025 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg022_2",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg022_2",FALSE)
         LET g_bgeg_d[l_ac].bgeg022 = ' '
      END IF
   END IF
   #通路
   IF g_bgaw2[11]='Y' THEN
      IF g_bgal.bgal026 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg023_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg023_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg023 = ' '
      END IF
   END IF
   #品牌
   IF g_bgaw2[12]='Y' THEN
      IF g_bgal.bgal027 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg024_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg024_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg024 = ' '
      END IF
   END IF
   #人员
   IF g_bgaw2[13]='Y' THEN
      IF g_bgal.bgal012 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg012_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg012_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg012 = ' '
      END IF
   END IF
   #专案
   IF g_bgaw2[14]='Y' THEN
      IF g_bgal.bgal013 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg020_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg020_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg020 = ' '
      END IF
   END IF
   #WBS
   IF g_bgaw2[15]='Y' THEN
      IF g_bgal.bgal014 = 'Y' THEN
         CALL cl_set_comp_entry("bgeg021_desc",TRUE)
      ELSE
         CALL cl_set_comp_entry("bgeg021_desc",FALSE)
         LET g_bgeg_d[l_ac].bgeg021 = ' '
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示单头核算项说明
# Memo...........:
# Usage..........: CALL abgt510_head_hsx_desc()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_head_hsx_desc()
   #单头显示栏位
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgeg_m.bgeg007) RETURNING g_bgeg_m.bgeg007_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg007_desc_t
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgeg_m.bgeg013) RETURNING g_bgeg_m.bgeg013_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg013_desc_t
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgeg_m.bgeg014) RETURNING g_bgeg_m.bgeg014_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg014_desc_t
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      CALL s_desc_get_acc_desc('287',g_bgeg_m.bgeg015) RETURNING g_bgeg_m.bgeg015_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg015_desc_t
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg016) RETURNING g_bgeg_m.bgeg016_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg016_desc_t
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgeg_m.bgeg017) RETURNING g_bgeg_m.bgeg017_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg017_desc_t
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      CALL s_desc_get_acc_desc('281',g_bgeg_m.bgeg018) RETURNING g_bgeg_m.bgeg018_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg018_desc_t
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      CALL s_desc_get_rtaxl003_desc(g_bgeg_m.bgeg019) RETURNING g_bgeg_m.bgeg019_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg019_desc_t
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgeg_m.bgeg023) RETURNING g_bgeg_m.bgeg023_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg023_desc_t
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      CALL s_desc_get_acc_desc('2002',g_bgeg_m.bgeg024) RETURNING g_bgeg_m.bgeg024_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg024_desc_t
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      CALL s_desc_get_person_desc(g_bgeg_m.bgeg012) RETURNING g_bgeg_m.bgeg012_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg012_desc_t
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgeg_m.bgeg020) RETURNING g_bgeg_m.bgeg020_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg020_desc_t
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      CALL s_desc_get_wbs_desc(g_bgeg_m.bgeg020,g_bgeg_m.bgeg021) RETURNING g_bgeg_m.bgeg021_desc_t
      DISPLAY BY NAME g_bgeg_m.bgeg021_desc_t
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 获取该项次对应的各个期别的数量、单价、销售金额
# Memo...........:
# Usage..........: CALL abgt510_get_num_and_price()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_get_num_and_price()
   DEFINE l_sql          STRING
   DEFINE l_bgeg008      LIKE bgeg_t.bgeg008
   DEFINE l_bgeg038      LIKE bgeg_t.bgeg038
   DEFINE l_bgeg039      LIKE bgeg_t.bgeg039
   DEFINE l_bgeg040      LIKE bgeg_t.bgeg040
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   
   LET l_sql="SELECT bgeg008,bgeg038,bgeg039,bgeg040 ",
             "  FROM bgeg_t ",
             " WHERE bgegent=",g_enterprise," AND bgeg001='",g_bgeg_m.bgeg001,"' ",
             "   AND bgeg002='",g_bgeg_m.bgeg002,"' AND bgeg003='",g_bgeg_m.bgeg003,"' ",
             "   AND bgeg004='",g_bgeg_m.bgeg004,"' AND bgeg005='",g_bgeg_m.bgeg005,"' ",
             "   AND bgeg006='",g_bgeg_m.bgeg006,"' AND bgegseq=",g_bgeg_d[l_ac].bgegseq
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg007='",g_bgeg_m.bgeg007,"'"
   ELSE
      LET l_sql = l_sql," AND bgeg007='",g_bgeg_d[l_ac].bgeg007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg009='",g_bgeg_m.bgeg009,"'"
   ELSE
      LET l_sql = l_sql," AND bgeg009='",g_bgeg_d[l_ac].bgeg009,"'"
   END IF
   LET l_sql = l_sql," ORDER BY bgeg008"
   PREPARE abgt510_sel_amt_pr FROM l_sql
   DECLARE abgt510_sel_amt_cs CURSOR FOR abgt510_sel_amt_pr
   
   FOREACH abgt510_sel_amt_cs INTO l_bgeg008,l_bgeg038,l_bgeg039,l_bgeg040
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CASE l_bgeg008
         WHEN 1
            LET g_bgeg_d[l_ac].num1=l_bgeg038
            LET g_bgeg_d[l_ac].price1=l_bgeg039
            LET g_bgeg_d[l_ac].amt1=l_bgeg040
         WHEN 2
            LET g_bgeg_d[l_ac].num2=l_bgeg038
            LET g_bgeg_d[l_ac].price2=l_bgeg039
            LET g_bgeg_d[l_ac].amt2=l_bgeg040
         WHEN 3
            LET g_bgeg_d[l_ac].num3=l_bgeg038
            LET g_bgeg_d[l_ac].price3=l_bgeg039
            LET g_bgeg_d[l_ac].amt3=l_bgeg040
         WHEN 4
            LET g_bgeg_d[l_ac].num4=l_bgeg038
            LET g_bgeg_d[l_ac].price4=l_bgeg039
            LET g_bgeg_d[l_ac].amt4=l_bgeg040
         WHEN 5
            LET g_bgeg_d[l_ac].num5=l_bgeg038
            LET g_bgeg_d[l_ac].price5=l_bgeg039
            LET g_bgeg_d[l_ac].amt5=l_bgeg040
         WHEN 6
            LET g_bgeg_d[l_ac].num6=l_bgeg038
            LET g_bgeg_d[l_ac].price6=l_bgeg039
            LET g_bgeg_d[l_ac].amt6=l_bgeg040 
         WHEN 7
            LET g_bgeg_d[l_ac].num7=l_bgeg038
            LET g_bgeg_d[l_ac].price7=l_bgeg039
            LET g_bgeg_d[l_ac].amt7=l_bgeg040
         WHEN 8
            LET g_bgeg_d[l_ac].num8=l_bgeg038
            LET g_bgeg_d[l_ac].price8=l_bgeg039
            LET g_bgeg_d[l_ac].amt8=l_bgeg040
         WHEN 9
            LET g_bgeg_d[l_ac].num9=l_bgeg038
            LET g_bgeg_d[l_ac].price9=l_bgeg039
            LET g_bgeg_d[l_ac].amt9=l_bgeg040
         WHEN 10
            LET g_bgeg_d[l_ac].num10=l_bgeg038
            LET g_bgeg_d[l_ac].price10=l_bgeg039
            LET g_bgeg_d[l_ac].amt10=l_bgeg040
         WHEN 11
            LET g_bgeg_d[l_ac].num11=l_bgeg038
            LET g_bgeg_d[l_ac].price11=l_bgeg039
            LET g_bgeg_d[l_ac].amt11=l_bgeg040
         WHEN 12
            LET g_bgeg_d[l_ac].num12=l_bgeg038
            LET g_bgeg_d[l_ac].price12=l_bgeg039
            LET g_bgeg_d[l_ac].amt12=l_bgeg040    
         WHEN 13
            LET g_bgeg_d[l_ac].num13=l_bgeg038
            LET g_bgeg_d[l_ac].price13=l_bgeg039
            LET g_bgeg_d[l_ac].amt13=l_bgeg040 
      END CASE      
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 获取核算项单身核算项说明
# Memo...........:
# Usage..........: CALL abgt510_detail_hsx_desc()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_detail_hsx_desc()
   DEFINE l_bgasl003    LIKE bgasl_t.bgasl003
   DEFINE l_bgasl004    LIKE bgasl_t.bgasl004
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   
   #单身显示栏位
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg007) RETURNING g_bgeg_d[l_ac].bgeg007_desc
      LET g_bgeg_d[l_ac].bgeg007_desc=g_bgeg_d[l_ac].bgeg007,"  ",g_bgeg_d[l_ac].bgeg007_desc
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      #抓取料件的品名规格
      CALL s_desc_get_bgas001_desc(g_bgeg_d[l_ac].bgeg009) RETURNING l_bgasl003,l_bgasl004
      LET g_bgeg_d[l_ac].bgeg009_desc = g_bgeg_d[l_ac].bgeg009,"  ",l_bgasl003,"  ",l_bgasl004
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg013) RETURNING g_bgeg_d[l_ac].bgeg013_desc
      LET g_bgeg_d[l_ac].bgeg013_desc=g_bgeg_d[l_ac].bgeg013,"  ",g_bgeg_d[l_ac].bgeg013_desc
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      CALL s_desc_get_department_desc(g_bgeg_d[l_ac].bgeg014) RETURNING g_bgeg_d[l_ac].bgeg014_desc
      LET g_bgeg_d[l_ac].bgeg014_desc=g_bgeg_d[l_ac].bgeg014,"  ",g_bgeg_d[l_ac].bgeg014_desc
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      CALL s_desc_get_acc_desc('287',g_bgeg_d[l_ac].bgeg015) RETURNING g_bgeg_d[l_ac].bgeg015_desc
      LET g_bgeg_d[l_ac].bgeg015_desc=g_bgeg_d[l_ac].bgeg015,"  ",g_bgeg_d[l_ac].bgeg015_desc
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg016) RETURNING g_bgeg_d[l_ac].bgeg016_desc
      LET g_bgeg_d[l_ac].bgeg016_desc=g_bgeg_d[l_ac].bgeg016,"  ",g_bgeg_d[l_ac].bgeg016_desc
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      CALL s_desc_get_bgap001_desc(g_bgeg_d[l_ac].bgeg017) RETURNING g_bgeg_d[l_ac].bgeg017_desc
      LET g_bgeg_d[l_ac].bgeg017_desc=g_bgeg_d[l_ac].bgeg017,"  ",g_bgeg_d[l_ac].bgeg017_desc
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      CALL s_desc_get_acc_desc('281',g_bgeg_d[l_ac].bgeg018) RETURNING g_bgeg_d[l_ac].bgeg018_desc
      LET g_bgeg_d[l_ac].bgeg018_desc=g_bgeg_d[l_ac].bgeg018,"  ",g_bgeg_d[l_ac].bgeg018_desc
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      CALL s_desc_get_rtaxl003_desc(g_bgeg_d[l_ac].bgeg019) RETURNING g_bgeg_d[l_ac].bgeg019_desc
      LET g_bgeg_d[l_ac].bgeg019_desc=g_bgeg_d[l_ac].bgeg019,"  ",g_bgeg_d[l_ac].bgeg019_desc
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgeg_d[l_ac].bgeg023) RETURNING g_bgeg_d[l_ac].bgeg023_desc
      LET g_bgeg_d[l_ac].bgeg023_desc=g_bgeg_d[l_ac].bgeg023,"  ",g_bgeg_d[l_ac].bgeg023_desc
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      CALL s_desc_get_acc_desc('2002',g_bgeg_d[l_ac].bgeg024) RETURNING g_bgeg_d[l_ac].bgeg024_desc
      LET g_bgeg_d[l_ac].bgeg024_desc=g_bgeg_d[l_ac].bgeg024,"  ",g_bgeg_d[l_ac].bgeg024_desc
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      CALL s_desc_get_person_desc(g_bgeg_d[l_ac].bgeg012) RETURNING g_bgeg_d[l_ac].bgeg012_desc
      LET g_bgeg_d[l_ac].bgeg012_desc=g_bgeg_d[l_ac].bgeg012,"  ",g_bgeg_d[l_ac].bgeg012_desc
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      CALL s_desc_get_oojdl003_desc(g_bgeg_d[l_ac].bgeg020) RETURNING g_bgeg_d[l_ac].bgeg020_desc
      LET g_bgeg_d[l_ac].bgeg020_desc=g_bgeg_d[l_ac].bgeg020,"  ",g_bgeg_d[l_ac].bgeg020_desc
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      CALL s_desc_get_wbs_desc(g_bgeg_d[l_ac].bgeg020,g_bgeg_d[l_ac].bgeg021) RETURNING g_bgeg_d[l_ac].bgeg021_desc
      LET g_bgeg_d[l_ac].bgeg021_desc=g_bgeg_d[l_ac].bgeg021,"  ",g_bgeg_d[l_ac].bgeg021_desc
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 插入bgeg_t资料
# Memo...........:
# Usage..........: CALL abgt510_insert_bgeg()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     执行结果TRUE/FALSE 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_insert_bgeg()
   DEFINE l_bgeg RECORD  #銷售預算主檔
          bgegent LIKE bgeg_t.bgegent, #企业编号
          bgeg001 LIKE bgeg_t.bgeg001, #来源作业
          bgeg002 LIKE bgeg_t.bgeg002, #预算编号
          bgeg003 LIKE bgeg_t.bgeg003, #版本
          bgeg004 LIKE bgeg_t.bgeg004, #管理组织
          bgeg005 LIKE bgeg_t.bgeg005, #销售来源
          bgeg006 LIKE bgeg_t.bgeg006, #数据类型
          bgeg007 LIKE bgeg_t.bgeg007, #预算组织
          bgeg008 LIKE bgeg_t.bgeg008, #预算期别
          bgeg009 LIKE bgeg_t.bgeg009, #预算料件
          bgeg010 LIKE bgeg_t.bgeg010, #组合KEY
          bgegseq LIKE bgeg_t.bgegseq, #项次
          bgeg011 LIKE bgeg_t.bgeg011, #预算样表
          bgeg012 LIKE bgeg_t.bgeg012, #人员
          bgeg013 LIKE bgeg_t.bgeg013, #部门
          bgeg014 LIKE bgeg_t.bgeg014, #成本利润中心
          bgeg015 LIKE bgeg_t.bgeg015, #区域
          bgeg016 LIKE bgeg_t.bgeg016, #收付款客商
          bgeg017 LIKE bgeg_t.bgeg017, #账款客商
          bgeg018 LIKE bgeg_t.bgeg018, #客群
          bgeg019 LIKE bgeg_t.bgeg019, #产品类别
          bgeg020 LIKE bgeg_t.bgeg020, #项目编号
          bgeg021 LIKE bgeg_t.bgeg021, #WBS
          bgeg022 LIKE bgeg_t.bgeg022, #经营方式
          bgeg023 LIKE bgeg_t.bgeg023, #渠道
          bgeg024 LIKE bgeg_t.bgeg024, #品牌
          bgeg025 LIKE bgeg_t.bgeg025, #自由核算项一
          bgeg026 LIKE bgeg_t.bgeg026, #自由核算项二
          bgeg027 LIKE bgeg_t.bgeg027, #自由核算项三
          bgeg028 LIKE bgeg_t.bgeg028, #自由核算项四
          bgeg029 LIKE bgeg_t.bgeg029, #自由核算项五
          bgeg030 LIKE bgeg_t.bgeg030, #自由核算项六
          bgeg031 LIKE bgeg_t.bgeg031, #自由核算项七
          bgeg032 LIKE bgeg_t.bgeg032, #自由核算项八
          bgeg033 LIKE bgeg_t.bgeg033, #自由核算项九
          bgeg034 LIKE bgeg_t.bgeg034, #自由核算项十
          bgeg035 LIKE bgeg_t.bgeg035, #税种
          bgeg036 LIKE bgeg_t.bgeg036, #含税否
          bgeg037 LIKE bgeg_t.bgeg037, #销售单位
          bgeg038 LIKE bgeg_t.bgeg038, #交易数量
          bgeg039 LIKE bgeg_t.bgeg039, #单价
          bgeg040 LIKE bgeg_t.bgeg040, #原币销售金额
          bgeg041 LIKE bgeg_t.bgeg041, #本层调整数量
          bgeg042 LIKE bgeg_t.bgeg042, #本层调整单价
          bgeg043 LIKE bgeg_t.bgeg043, #上层调整数量
          bgeg044 LIKE bgeg_t.bgeg044, #上层调整单价
          bgeg045 LIKE bgeg_t.bgeg045, #核准数量
          bgeg046 LIKE bgeg_t.bgeg046, #核准单价
          bgeg047 LIKE bgeg_t.bgeg047, #上层组织
          bgeg048 LIKE bgeg_t.bgeg048, #转凭证否
          bgeg049 LIKE bgeg_t.bgeg049, #预算细项
          bgeg050 LIKE bgeg_t.bgeg050, #编制起点
          bgeg051 LIKE bgeg_t.bgeg051, #生产预算抛转否
          bgeg100 LIKE bgeg_t.bgeg100, #交易币种
          bgeg101 LIKE bgeg_t.bgeg101, #汇率
          bgeg102 LIKE bgeg_t.bgeg102, #核准原币销售金额
          bgeg103 LIKE bgeg_t.bgeg103, #核准原币税前金额
          bgeg104 LIKE bgeg_t.bgeg104, #核准原币税额
          bgeg105 LIKE bgeg_t.bgeg105, #核准原币含税金额
          bgegownid LIKE bgeg_t.bgegownid, #资料所有者
          bgegowndp LIKE bgeg_t.bgegowndp, #资料所有部门
          bgegcrtid LIKE bgeg_t.bgegcrtid, #资料录入者
          bgegcrtdp LIKE bgeg_t.bgegcrtdp, #资料录入部门
          bgegcrtdt LIKE bgeg_t.bgegcrtdt, #资料创建日
          bgegmodid LIKE bgeg_t.bgegmodid, #资料更改者
          bgegmoddt LIKE bgeg_t.bgegmoddt, #最近更改日
          bgegcnfid LIKE bgeg_t.bgegcnfid, #资料审核者
          bgegcnfdt LIKE bgeg_t.bgegcnfdt, #数据审核日
          bgegstus LIKE bgeg_t.bgegstus, #状态码
          bgegud001 LIKE bgeg_t.bgegud001, #自定义字段(文本)001
          bgegud002 LIKE bgeg_t.bgegud002, #自定义字段(文本)002
          bgegud003 LIKE bgeg_t.bgegud003, #自定义字段(文本)003
          bgegud004 LIKE bgeg_t.bgegud004, #自定义字段(文本)004
          bgegud005 LIKE bgeg_t.bgegud005, #自定义字段(文本)005
          bgegud006 LIKE bgeg_t.bgegud006, #自定义字段(文本)006
          bgegud007 LIKE bgeg_t.bgegud007, #自定义字段(文本)007
          bgegud008 LIKE bgeg_t.bgegud008, #自定义字段(文本)008
          bgegud009 LIKE bgeg_t.bgegud009, #自定义字段(文本)009
          bgegud010 LIKE bgeg_t.bgegud010, #自定义字段(文本)010
          bgegud011 LIKE bgeg_t.bgegud011, #自定义字段(数字)011
          bgegud012 LIKE bgeg_t.bgegud012, #自定义字段(数字)012
          bgegud013 LIKE bgeg_t.bgegud013, #自定义字段(数字)013
          bgegud014 LIKE bgeg_t.bgegud014, #自定义字段(数字)014
          bgegud015 LIKE bgeg_t.bgegud015, #自定义字段(数字)015
          bgegud016 LIKE bgeg_t.bgegud016, #自定义字段(数字)016
          bgegud017 LIKE bgeg_t.bgegud017, #自定义字段(数字)017
          bgegud018 LIKE bgeg_t.bgegud018, #自定义字段(数字)018
          bgegud019 LIKE bgeg_t.bgegud019, #自定义字段(数字)019
          bgegud020 LIKE bgeg_t.bgegud020, #自定义字段(数字)020
          bgegud021 LIKE bgeg_t.bgegud021, #自定义字段(日期时间)021
          bgegud022 LIKE bgeg_t.bgegud022, #自定义字段(日期时间)022
          bgegud023 LIKE bgeg_t.bgegud023, #自定义字段(日期时间)023
          bgegud024 LIKE bgeg_t.bgegud024, #自定义字段(日期时间)024
          bgegud025 LIKE bgeg_t.bgegud025, #自定义字段(日期时间)025
          bgegud026 LIKE bgeg_t.bgegud026, #自定义字段(日期时间)026
          bgegud027 LIKE bgeg_t.bgegud027, #自定义字段(日期时间)027
          bgegud028 LIKE bgeg_t.bgegud028, #自定义字段(日期时间)028
          bgegud029 LIKE bgeg_t.bgegud029, #自定义字段(日期时间)029
          bgegud030 LIKE bgeg_t.bgegud030  #自定义字段(日期时间)030
   END RECORD
   DEFINE l_i            LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgeg103      LIKE bgeg_t.bgeg103
   DEFINE l_bgeg104      LIKE bgeg_t.bgeg104
   DEFINE l_bgeg105      LIKE bgeg_t.bgeg105
   DEFINE l_day        LIKE type_t.num5 #161220-00036#1 add
   DEFINE l_date       LIKE type_t.dat  #161220-00036#1 add
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgeg.bgeg007 = g_bgeg_m.bgeg007
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgeg.bgeg009 = g_bgeg_m.bgeg009
      LET l_bgeg.bgeg049 = g_bgeg_m.bgeg049
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgeg.bgeg013 = g_bgeg_m.bgeg013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgeg.bgeg014 = g_bgeg_m.bgeg014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgeg.bgeg015 = g_bgeg_m.bgeg015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgeg.bgeg016 = g_bgeg_m.bgeg016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgeg.bgeg017 = g_bgeg_m.bgeg017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgeg.bgeg018 = g_bgeg_m.bgeg018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgeg.bgeg019 = g_bgeg_m.bgeg019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgeg.bgeg022= g_bgeg_m.bgeg022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgeg.bgeg023= g_bgeg_m.bgeg023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgeg.bgeg024= g_bgeg_m.bgeg024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgeg.bgeg012= g_bgeg_m.bgeg012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgeg.bgeg020= g_bgeg_m.bgeg020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgeg.bgeg021= g_bgeg_m.bgeg021
   END IF
   
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgeg.bgeg007 = g_bgeg_d[l_ac].bgeg007
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgeg.bgeg009 = g_bgeg_d[l_ac].bgeg009
      LET l_bgeg.bgeg049 = g_bgeg_d[l_ac].bgeg049
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgeg.bgeg013 = g_bgeg_d[l_ac].bgeg013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgeg.bgeg014 = g_bgeg_d[l_ac].bgeg014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgeg.bgeg015 = g_bgeg_d[l_ac].bgeg015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgeg.bgeg016 = g_bgeg_d[l_ac].bgeg016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgeg.bgeg017 = g_bgeg_d[l_ac].bgeg017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgeg.bgeg018 = g_bgeg_d[l_ac].bgeg018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgeg.bgeg019 = g_bgeg_d[l_ac].bgeg019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgeg.bgeg022= g_bgeg_d[l_ac].bgeg022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgeg.bgeg023= g_bgeg_d[l_ac].bgeg023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgeg.bgeg024= g_bgeg_d[l_ac].bgeg024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgeg.bgeg012= g_bgeg_d[l_ac].bgeg012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgeg.bgeg020= g_bgeg_d[l_ac].bgeg020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgeg.bgeg021= g_bgeg_d[l_ac].bgeg021
   END IF
   
   #当核算项不使用时，核算项默认给空格
   #部门
   IF g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N' THEN
      LET l_bgeg.bgeg013 = ' '
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N' THEN
      LET l_bgeg.bgeg014 = ' '
   END IF
   #区域
   IF g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N' THEN
      LET l_bgeg.bgeg015 = ' '
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N' THEN
      LET l_bgeg.bgeg016 = ' '
   END IF
   #账款客商
   IF g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N' THEN
      LET l_bgeg.bgeg017 = ' '
   END IF
   #客群
   IF g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N' THEN
      LET l_bgeg.bgeg018 = ' '
   END IF
   #产品类别
   IF g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N' THEN
      LET l_bgeg.bgeg019 = ' '
   END IF
   #经营方式
   IF g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N' THEN
      LET l_bgeg.bgeg022= ' '
   END IF
   #通路
   IF g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N' THEN
      LET l_bgeg.bgeg023= ' '
   END IF
   #品牌
   IF g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N' THEN
      LET l_bgeg.bgeg024= ' '
   END IF
   #人员
   IF g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N' THEN
      LET l_bgeg.bgeg012= ' '
   END IF
   #专案
   IF g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N' THEN
      LET l_bgeg.bgeg020= ' '
   END IF
   #WBS
   IF g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N' THEN
      LET l_bgeg.bgeg021= ' '
   END IF
   
   #组合key bgeg010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET l_bgeg.bgeg010 = "bgeg013=",l_bgeg.bgeg013,"/",
                        "bgeg014=",l_bgeg.bgeg014,"/",
                        "bgeg015=",l_bgeg.bgeg015,"/",
                        "bgeg016=",l_bgeg.bgeg016,"/",
                        "bgeg017=",l_bgeg.bgeg017,"/",
                        "bgeg018=",l_bgeg.bgeg018,"/",
                        "bgeg019=",l_bgeg.bgeg019,"/",
                        "bgeg022=",l_bgeg.bgeg022,"/",
                        "bgeg023=",l_bgeg.bgeg023,"/",
                        "bgeg024=",l_bgeg.bgeg024,"/",
                        "bgeg012=",l_bgeg.bgeg012,"/",
                        "bgeg020=",l_bgeg.bgeg020,"/",
                        "bgeg021=",l_bgeg.bgeg021,""
   
   LET l_bgeg.bgeg041 = 0
   LET l_bgeg.bgeg042 = 0
   LET l_bgeg.bgeg043 = 0
   LET l_bgeg.bgeg044 = 0
   LET l_bgeg.bgeg051 = 'N'
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgeg.bgeg008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num1
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price1
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt1
         WHEN 2
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num2
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price2
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt2
         WHEN 3
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num3
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price3
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt3
         WHEN 4
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num4
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price4
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt4
         WHEN 5
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num5
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price5
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt5
         WHEN 6
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num6
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price6
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt6
         WHEN 7
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num7
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price7
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt7
         WHEN 8
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num8
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price8
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt8
         WHEN 9
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num9
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price9
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt9
         WHEN 10
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num10
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price10
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt10
         WHEN 11
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num11
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price11
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt11
         WHEN 12
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num12
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price12
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt12
         WHEN 13
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num13
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price13
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt13
      END CASE
      #161215-00014#2--add--str--
      IF cl_null(l_bgeg.bgeg038) THEN LET l_bgeg.bgeg038 = 0 END IF
      IF cl_null(l_bgeg.bgeg039) THEN LET l_bgeg.bgeg039 = 0 END IF
      IF cl_null(l_bgeg.bgeg040) THEN LET l_bgeg.bgeg040 = 0 END IF
      #161215-00014#2--add--end
      LET l_bgeg.bgeg045 = l_bgeg.bgeg038
      LET l_bgeg.bgeg046 = l_bgeg.bgeg039
      LET l_bgeg.bgeg102 = l_bgeg.bgeg040
      #161220-00036#1--add--str--
      #汇率
      #170103-00013#1--mod--str--
#      CALL s_date_get_max_day(g_bgeg_m.bgaa002,l_bgeg.bgeg008) RETURNING l_day
#      LET l_date=MDY(l_bgeg.bgeg008,l_day,g_bgeg_m.bgaa002)
      CALL s_abg2_get_max_bgac002(g_bgeg_m.bgaa002,l_bgeg.bgeg008) RETURNING l_date
      #170103-00013#1--mod--end
      CALL s_abg_get_bg_rate(g_bgeg_m.bgeg002,l_date,g_bgeg_d[l_ac].bgeg100,g_bgeg_m.bgaa003)
      RETURNING l_bgeg.bgeg101
      #161220-00036#1--add--end
      #以稅別計算出來含税金额、未税金额、税额
#      CALL s_tax_count(l_bgeg.bgeg007,g_bgeg_d[l_ac].bgeg035,l_bgeg.bgeg102,l_bgeg.bgeg045,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg101)#161220-00036#1 mark
      CALL s_tax_count(l_bgeg.bgeg007,g_bgeg_d[l_ac].bgeg035,l_bgeg.bgeg102,l_bgeg.bgeg045,g_bgeg_d[l_ac].bgeg100,l_bgeg.bgeg101)#161220-00036#1 add
      RETURNING l_bgeg.bgeg103,l_bgeg.bgeg104,l_bgeg.bgeg105,l_bgeg103,l_bgeg104,l_bgeg105
      
      INSERT INTO bgeg_t
            (bgegent,bgeg002,bgeg003,bgeg004,bgeg011,bgeg001,bgeg005,bgeg006,bgegstus,
             bgeg007,bgeg009,bgeg008,bgeg010,bgegseq,
             bgeg049,bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,
             bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,
             bgeg035,bgeg036,bgeg037,bgeg100,
             bgeg101,bgeg038,bgeg039,bgeg040,
             bgeg041,bgeg042,bgeg043,bgeg044,bgeg045,bgeg046,
             bgeg047,bgeg048,bgeg050,bgeg051,
             bgeg102,bgeg103,bgeg104,bgeg105,
             bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt,
             bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt) 
      VALUES(g_enterprise,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,
             g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgegstus,
             l_bgeg.bgeg007,l_bgeg.bgeg009,l_bgeg.bgeg008,l_bgeg.bgeg010,g_bgeg_d[l_ac].bgegseq,
             l_bgeg.bgeg049,l_bgeg.bgeg012,l_bgeg.bgeg013,l_bgeg.bgeg014,l_bgeg.bgeg015,l_bgeg.bgeg016,l_bgeg.bgeg017,
             l_bgeg.bgeg018,l_bgeg.bgeg019,l_bgeg.bgeg020,l_bgeg.bgeg021,l_bgeg.bgeg022,l_bgeg.bgeg023,l_bgeg.bgeg024,
             g_bgeg_d[l_ac].bgeg035,g_bgeg_d[l_ac].bgeg036,g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100, 
#             g_bgeg_d[l_ac].bgeg101,l_bgeg.bgeg038,l_bgeg.bgeg039,l_bgeg.bgeg040, #161220-00036#1 mark
             l_bgeg.bgeg101,l_bgeg.bgeg038,l_bgeg.bgeg039,l_bgeg.bgeg040, #161220-00036#1 add
             l_bgeg.bgeg041,l_bgeg.bgeg042,l_bgeg.bgeg043,l_bgeg.bgeg044,l_bgeg.bgeg045,l_bgeg.bgeg046,
             g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048,g_bgeg_d[l_ac].bgeg050,l_bgeg.bgeg051,
             l_bgeg.bgeg102,l_bgeg.bgeg103,l_bgeg.bgeg104,l_bgeg.bgeg105,
             g_bgeg2_d[l_ac].bgegownid,g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid, 
             g_bgeg2_d[l_ac].bgegcrtdp,g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid, 
             g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid,g_bgeg2_d[l_ac].bgegcnfdt) 
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
# Usage..........: CALL abgt510_update_head()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_update_head()
   DEFINE l_sql           STRING
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING 
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_bgeg RECORD  #銷售預算主檔
          bgegent LIKE bgeg_t.bgegent, #企业编号
          bgeg001 LIKE bgeg_t.bgeg001, #来源作业
          bgeg002 LIKE bgeg_t.bgeg002, #预算编号
          bgeg003 LIKE bgeg_t.bgeg003, #版本
          bgeg004 LIKE bgeg_t.bgeg004, #管理组织
          bgeg005 LIKE bgeg_t.bgeg005, #销售来源
          bgeg006 LIKE bgeg_t.bgeg006, #数据类型
          bgeg007 LIKE bgeg_t.bgeg007, #预算组织
          bgeg008 LIKE bgeg_t.bgeg008, #预算期别
          bgeg009 LIKE bgeg_t.bgeg009, #预算料件
          bgeg010 LIKE bgeg_t.bgeg010, #组合KEY
          bgegseq LIKE bgeg_t.bgegseq, #项次
          bgeg011 LIKE bgeg_t.bgeg011, #预算样表
          bgeg012 LIKE bgeg_t.bgeg012, #人员
          bgeg013 LIKE bgeg_t.bgeg013, #部门
          bgeg014 LIKE bgeg_t.bgeg014, #成本利润中心
          bgeg015 LIKE bgeg_t.bgeg015, #区域
          bgeg016 LIKE bgeg_t.bgeg016, #收付款客商
          bgeg017 LIKE bgeg_t.bgeg017, #账款客商
          bgeg018 LIKE bgeg_t.bgeg018, #客群
          bgeg019 LIKE bgeg_t.bgeg019, #产品类别
          bgeg020 LIKE bgeg_t.bgeg020, #项目编号
          bgeg021 LIKE bgeg_t.bgeg021, #WBS
          bgeg022 LIKE bgeg_t.bgeg022, #经营方式
          bgeg023 LIKE bgeg_t.bgeg023, #渠道
          bgeg024 LIKE bgeg_t.bgeg024, #品牌
          bgeg025 LIKE bgeg_t.bgeg025, #自由核算项一
          bgeg026 LIKE bgeg_t.bgeg026, #自由核算项二
          bgeg027 LIKE bgeg_t.bgeg027, #自由核算项三
          bgeg028 LIKE bgeg_t.bgeg028, #自由核算项四
          bgeg029 LIKE bgeg_t.bgeg029, #自由核算项五
          bgeg030 LIKE bgeg_t.bgeg030, #自由核算项六
          bgeg031 LIKE bgeg_t.bgeg031, #自由核算项七
          bgeg032 LIKE bgeg_t.bgeg032, #自由核算项八
          bgeg033 LIKE bgeg_t.bgeg033, #自由核算项九
          bgeg034 LIKE bgeg_t.bgeg034, #自由核算项十
          bgeg035 LIKE bgeg_t.bgeg035, #税种
          bgeg036 LIKE bgeg_t.bgeg036, #含税否
          bgeg037 LIKE bgeg_t.bgeg037, #销售单位
          bgeg038 LIKE bgeg_t.bgeg038, #交易数量
          bgeg039 LIKE bgeg_t.bgeg039, #单价
          bgeg040 LIKE bgeg_t.bgeg040, #原币销售金额
          bgeg041 LIKE bgeg_t.bgeg041, #本层调整数量
          bgeg042 LIKE bgeg_t.bgeg042, #本层调整单价
          bgeg043 LIKE bgeg_t.bgeg043, #上层调整数量
          bgeg044 LIKE bgeg_t.bgeg044, #上层调整单价
          bgeg045 LIKE bgeg_t.bgeg045, #核准数量
          bgeg046 LIKE bgeg_t.bgeg046, #核准单价
          bgeg047 LIKE bgeg_t.bgeg047, #上层组织
          bgeg048 LIKE bgeg_t.bgeg048, #转凭证否
          bgeg049 LIKE bgeg_t.bgeg049, #预算细项
          bgeg050 LIKE bgeg_t.bgeg050, #编制起点
          bgeg051 LIKE bgeg_t.bgeg051, #生产预算抛转否
          bgeg100 LIKE bgeg_t.bgeg100, #交易币种
          bgeg101 LIKE bgeg_t.bgeg101, #汇率
          bgeg102 LIKE bgeg_t.bgeg102, #核准原币销售金额
          bgeg103 LIKE bgeg_t.bgeg103, #核准原币税前金额
          bgeg104 LIKE bgeg_t.bgeg104, #核准原币税额
          bgeg105 LIKE bgeg_t.bgeg105, #核准原币含税金额
          bgegownid LIKE bgeg_t.bgegownid, #资料所有者
          bgegowndp LIKE bgeg_t.bgegowndp, #资料所有部门
          bgegcrtid LIKE bgeg_t.bgegcrtid, #资料录入者
          bgegcrtdp LIKE bgeg_t.bgegcrtdp, #资料录入部门
          bgegcrtdt LIKE bgeg_t.bgegcrtdt, #资料创建日
          bgegmodid LIKE bgeg_t.bgegmodid, #资料更改者
          bgegmoddt LIKE bgeg_t.bgegmoddt, #最近更改日
          bgegcnfid LIKE bgeg_t.bgegcnfid, #资料审核者
          bgegcnfdt LIKE bgeg_t.bgegcnfdt, #数据审核日
          bgegstus LIKE bgeg_t.bgegstus, #状态码
          bgegud001 LIKE bgeg_t.bgegud001, #自定义字段(文本)001
          bgegud002 LIKE bgeg_t.bgegud002, #自定义字段(文本)002
          bgegud003 LIKE bgeg_t.bgegud003, #自定义字段(文本)003
          bgegud004 LIKE bgeg_t.bgegud004, #自定义字段(文本)004
          bgegud005 LIKE bgeg_t.bgegud005, #自定义字段(文本)005
          bgegud006 LIKE bgeg_t.bgegud006, #自定义字段(文本)006
          bgegud007 LIKE bgeg_t.bgegud007, #自定义字段(文本)007
          bgegud008 LIKE bgeg_t.bgegud008, #自定义字段(文本)008
          bgegud009 LIKE bgeg_t.bgegud009, #自定义字段(文本)009
          bgegud010 LIKE bgeg_t.bgegud010, #自定义字段(文本)010
          bgegud011 LIKE bgeg_t.bgegud011, #自定义字段(数字)011
          bgegud012 LIKE bgeg_t.bgegud012, #自定义字段(数字)012
          bgegud013 LIKE bgeg_t.bgegud013, #自定义字段(数字)013
          bgegud014 LIKE bgeg_t.bgegud014, #自定义字段(数字)014
          bgegud015 LIKE bgeg_t.bgegud015, #自定义字段(数字)015
          bgegud016 LIKE bgeg_t.bgegud016, #自定义字段(数字)016
          bgegud017 LIKE bgeg_t.bgegud017, #自定义字段(数字)017
          bgegud018 LIKE bgeg_t.bgegud018, #自定义字段(数字)018
          bgegud019 LIKE bgeg_t.bgegud019, #自定义字段(数字)019
          bgegud020 LIKE bgeg_t.bgegud020, #自定义字段(数字)020
          bgegud021 LIKE bgeg_t.bgegud021, #自定义字段(日期时间)021
          bgegud022 LIKE bgeg_t.bgegud022, #自定义字段(日期时间)022
          bgegud023 LIKE bgeg_t.bgegud023, #自定义字段(日期时间)023
          bgegud024 LIKE bgeg_t.bgegud024, #自定义字段(日期时间)024
          bgegud025 LIKE bgeg_t.bgegud025, #自定义字段(日期时间)025
          bgegud026 LIKE bgeg_t.bgegud026, #自定义字段(日期时间)026
          bgegud027 LIKE bgeg_t.bgegud027, #自定义字段(日期时间)027
          bgegud028 LIKE bgeg_t.bgegud028, #自定义字段(日期时间)028
          bgegud029 LIKE bgeg_t.bgegud029, #自定义字段(日期时间)029
          bgegud030 LIKE bgeg_t.bgegud030  #自定义字段(日期时间)030
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
   DEFINE l_bgeg010_t     LIKE bgeg_t.bgeg010
   
   LET r_success = TRUE
                
   LET l_str1="bgeg002,bgeg003,bgeg004,bgeg011,bgeg001,bgeg005,bgeg006,bgegstus"
   LET l_str2="'",g_bgeg_m.bgeg002,"','",g_bgeg_m.bgeg003,"','",g_bgeg_m.bgeg004,"','",g_bgeg_m.bgeg011,"',", 
              "'",g_bgeg_m.bgeg001,"','",g_bgeg_m.bgeg005,"','",g_bgeg_m.bgeg006,"','",g_bgeg_m.bgegstus,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_str1=l_str1,",bgeg007"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_str1=l_str1,",bgeg009,bgeg049"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg009,"','",g_bgeg_m.bgeg049,"'"
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_str1=l_str1,",bgeg013"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg013,"'"
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_str1=l_str1,",bgeg014"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg014,"'"
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_str1=l_str1,",bgeg015"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg015,"'"
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_str1=l_str1,",bgeg016"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg016,"'"
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_str1=l_str1,",bgeg017"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg017,"'"
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_str1=l_str1,",bgeg018"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg018,"'"
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_str1=l_str1,",bgeg019"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg019,"'"
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_str1=l_str1,",bgeg022"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg022,"'"
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_str1=l_str1,",bgeg023"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg023,"'"
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_str1=l_str1,",bgeg024"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg024,"'"
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_str1=l_str1,",bgeg012"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg012,"'"
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_str1=l_str1,",bgeg020"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg020,"'"
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_str1=l_str1,",bgeg021"
      LET l_str2=l_str2,",'",g_bgeg_m.bgeg021,"'"
   END IF
   
   LET l_sql = "UPDATE bgeg_t SET (",l_str1,") = (",l_str2,")",
               " WHERE bgegent =  ",g_enterprise,
               "   AND bgeg001 = '",g_bgeg001_t,"'",
               "   AND bgeg002 = '",g_bgeg002_t,"'",
               "   AND bgeg003 = '",g_bgeg003_t,"'",
               "   AND bgeg004 = '",g_bgeg004_t,"'",
               "   AND bgeg005 = '",g_bgeg005_t,"'",
               "   AND bgeg006 = '",g_bgeg006_t,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg007_t,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg009_t,"'"
   END IF
   PREPARE abgt510_update_head_pr FROM l_sql
   EXECUTE abgt510_update_head_pr
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeg_t" 
         LET g_errparam.code   = "std-00009" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
   LET l_sql = "SELECT DISTINCT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,",
               "       bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,bgeg018,",
               "       bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024 ",
               "  FROM bgeg_t ",
               " WHERE bgegent =  ",g_enterprise,
               "   AND bgeg001 = '",g_bgeg_m.bgeg001,"'",
               "   AND bgeg002 = '",g_bgeg_m.bgeg002,"'",
               "   AND bgeg003 = '",g_bgeg_m.bgeg003,"'",
               "   AND bgeg004 = '",g_bgeg_m.bgeg004,"'",
               "   AND bgeg005 = '",g_bgeg_m.bgeg005,"'",
               "   AND bgeg006 = '",g_bgeg_m.bgeg006,"'"
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg_m.bgeg007,"'"
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg_m.bgeg009,"'"
   END IF
   PREPARE abgt510_update_head_pr2 FROM l_sql
   DECLARE abgt510_update_head_cs2 CURSOR FOR abgt510_update_head_pr2
   
   FOREACH abgt510_update_head_cs2 INTO l_bgeg.bgegseq,l_bgeg010_t,l_bgeg.bgeg007,l_bgeg.bgeg009,l_bgeg.bgeg049,
                                        l_bgeg.bgeg012,l_bgeg.bgeg013,l_bgeg.bgeg014,l_bgeg.bgeg015,
                                        l_bgeg.bgeg016,l_bgeg.bgeg017,l_bgeg.bgeg018,l_bgeg.bgeg019,
                                        l_bgeg.bgeg020,l_bgeg.bgeg021,l_bgeg.bgeg022,l_bgeg.bgeg023,
                                        l_bgeg.bgeg024
      SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
             bgal010,bgal011,bgal012,bgal013,bgal014,
             bgal025,bgal026,bgal027 
        INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
             l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
             l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
        FROM bgal_t 
       WHERE bgalent=g_enterprise AND bgal001=g_bgeg_m.bgeg002
         AND bgal002=l_bgeg.bgeg007 AND bgal003=l_bgeg.bgeg049
      #部门
      IF (g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N') OR l_bgal.bgal005 = 'N' THEN
         LET l_bgeg.bgeg013 = ' '
      END IF
      #利润成本中心
      IF (g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N') OR l_bgal.bgal006 = 'N'  THEN
         LET l_bgeg.bgeg014 = ' '
      END IF
      #区域
      IF (g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N') OR l_bgal.bgal007 = 'N'  THEN
         LET l_bgeg.bgeg015 = ' '
      END IF
      #收付款客商
      IF (g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N') OR l_bgal.bgal008 = 'N'  THEN
         LET l_bgeg.bgeg016 = ' '
      END IF
      #账款客商
      IF (g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N') OR l_bgal.bgal009 = 'N'  THEN
         LET l_bgeg.bgeg017 = ' '
      END IF
      #客群
      IF (g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N') OR l_bgal.bgal010 = 'N'  THEN
         LET l_bgeg.bgeg018 = ' '
      END IF
      #产品类别
      IF (g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N') OR l_bgal.bgal011 = 'N' THEN
         LET l_bgeg.bgeg019 = ' '
      END IF
      #经营方式
      IF (g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N') OR l_bgal.bgal025 = 'N' THEN
         LET l_bgeg.bgeg022= ' '
      END IF
      #通路
      IF (g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N') OR l_bgal.bgal026 = 'N' THEN
         LET l_bgeg.bgeg023= ' '
      END IF
      #品牌
      IF (g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N') OR l_bgal.bgal027 = 'N' THEN
         LET l_bgeg.bgeg024= ' '
      END IF
      #人员
      IF (g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N') OR l_bgal.bgal012 = 'N' THEN
         LET l_bgeg.bgeg012= ' '
      END IF
      #专案
      IF (g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N') OR l_bgal.bgal013 = 'N' THEN
         LET l_bgeg.bgeg020= ' '
      END IF
      #WBS
      IF (g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N') OR l_bgal.bgal014 = 'N' THEN
         LET l_bgeg.bgeg021= ' '
      END IF
      
      #组合key bgeg010
      #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
      #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
      LET l_bgeg.bgeg010 = "bgeg013=",l_bgeg.bgeg013,"/",
                           "bgeg014=",l_bgeg.bgeg014,"/",
                           "bgeg015=",l_bgeg.bgeg015,"/",
                           "bgeg016=",l_bgeg.bgeg016,"/",
                           "bgeg017=",l_bgeg.bgeg017,"/",
                           "bgeg018=",l_bgeg.bgeg018,"/",
                           "bgeg019=",l_bgeg.bgeg019,"/",
                           "bgeg022=",l_bgeg.bgeg022,"/",
                           "bgeg023=",l_bgeg.bgeg023,"/",
                           "bgeg024=",l_bgeg.bgeg024,"/",
                           "bgeg012=",l_bgeg.bgeg012,"/",
                           "bgeg020=",l_bgeg.bgeg020,"/",
                           "bgeg021=",l_bgeg.bgeg021,""
                           
      UPDATE bgeg_t SET (bgeg010,bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,
                         bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,
                         bgeg023,bgeg024) = (l_bgeg.bgeg010,l_bgeg.bgeg012, 
                         l_bgeg.bgeg013,l_bgeg.bgeg014,l_bgeg.bgeg015,l_bgeg.bgeg016, 
                         l_bgeg.bgeg017,l_bgeg.bgeg018,l_bgeg.bgeg019,l_bgeg.bgeg020, 
                         l_bgeg.bgeg021,l_bgeg.bgeg022,l_bgeg.bgeg023,l_bgeg.bgeg024)
       WHERE bgegent = g_enterprise 
         AND bgeg001 = g_bgeg_m.bgeg001 
         AND bgeg002 = g_bgeg_m.bgeg002 
         AND bgeg003 = g_bgeg_m.bgeg003 
         AND bgeg004 = g_bgeg_m.bgeg004 
         AND bgeg005 = g_bgeg_m.bgeg005 
         AND bgeg006 = g_bgeg_m.bgeg006 
         AND bgeg007 = l_bgeg.bgeg007
         AND bgeg009 = l_bgeg.bgeg009
         AND bgeg010 = l_bgeg010_t
         AND bgegseq = l_bgeg.bgegseq 
     CASE
        WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgeg_t" 
           LET g_errparam.code   = "std-00009" 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOREACH
           
        WHEN SQLCA.sqlcode #其他錯誤
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
# Usage..........: CALL abgt510_update_detail()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     执行结果TRUE/FALSE
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_update_detail()
   DEFINE l_bgeg RECORD  #銷售預算主檔
          bgegent LIKE bgeg_t.bgegent, #企业编号
          bgeg001 LIKE bgeg_t.bgeg001, #来源作业
          bgeg002 LIKE bgeg_t.bgeg002, #预算编号
          bgeg003 LIKE bgeg_t.bgeg003, #版本
          bgeg004 LIKE bgeg_t.bgeg004, #管理组织
          bgeg005 LIKE bgeg_t.bgeg005, #销售来源
          bgeg006 LIKE bgeg_t.bgeg006, #数据类型
          bgeg007 LIKE bgeg_t.bgeg007, #预算组织
          bgeg008 LIKE bgeg_t.bgeg008, #预算期别
          bgeg009 LIKE bgeg_t.bgeg009, #预算料件
          bgeg010 LIKE bgeg_t.bgeg010, #组合KEY
          bgegseq LIKE bgeg_t.bgegseq, #项次
          bgeg011 LIKE bgeg_t.bgeg011, #预算样表
          bgeg012 LIKE bgeg_t.bgeg012, #人员
          bgeg013 LIKE bgeg_t.bgeg013, #部门
          bgeg014 LIKE bgeg_t.bgeg014, #成本利润中心
          bgeg015 LIKE bgeg_t.bgeg015, #区域
          bgeg016 LIKE bgeg_t.bgeg016, #收付款客商
          bgeg017 LIKE bgeg_t.bgeg017, #账款客商
          bgeg018 LIKE bgeg_t.bgeg018, #客群
          bgeg019 LIKE bgeg_t.bgeg019, #产品类别
          bgeg020 LIKE bgeg_t.bgeg020, #项目编号
          bgeg021 LIKE bgeg_t.bgeg021, #WBS
          bgeg022 LIKE bgeg_t.bgeg022, #经营方式
          bgeg023 LIKE bgeg_t.bgeg023, #渠道
          bgeg024 LIKE bgeg_t.bgeg024, #品牌
          bgeg025 LIKE bgeg_t.bgeg025, #自由核算项一
          bgeg026 LIKE bgeg_t.bgeg026, #自由核算项二
          bgeg027 LIKE bgeg_t.bgeg027, #自由核算项三
          bgeg028 LIKE bgeg_t.bgeg028, #自由核算项四
          bgeg029 LIKE bgeg_t.bgeg029, #自由核算项五
          bgeg030 LIKE bgeg_t.bgeg030, #自由核算项六
          bgeg031 LIKE bgeg_t.bgeg031, #自由核算项七
          bgeg032 LIKE bgeg_t.bgeg032, #自由核算项八
          bgeg033 LIKE bgeg_t.bgeg033, #自由核算项九
          bgeg034 LIKE bgeg_t.bgeg034, #自由核算项十
          bgeg035 LIKE bgeg_t.bgeg035, #税种
          bgeg036 LIKE bgeg_t.bgeg036, #含税否
          bgeg037 LIKE bgeg_t.bgeg037, #销售单位
          bgeg038 LIKE bgeg_t.bgeg038, #交易数量
          bgeg039 LIKE bgeg_t.bgeg039, #单价
          bgeg040 LIKE bgeg_t.bgeg040, #原币销售金额
          bgeg041 LIKE bgeg_t.bgeg041, #本层调整数量
          bgeg042 LIKE bgeg_t.bgeg042, #本层调整单价
          bgeg043 LIKE bgeg_t.bgeg043, #上层调整数量
          bgeg044 LIKE bgeg_t.bgeg044, #上层调整单价
          bgeg045 LIKE bgeg_t.bgeg045, #核准数量
          bgeg046 LIKE bgeg_t.bgeg046, #核准单价
          bgeg047 LIKE bgeg_t.bgeg047, #上层组织
          bgeg048 LIKE bgeg_t.bgeg048, #转凭证否
          bgeg049 LIKE bgeg_t.bgeg049, #预算细项
          bgeg050 LIKE bgeg_t.bgeg050, #编制起点
          bgeg051 LIKE bgeg_t.bgeg051, #生产预算抛转否
          bgeg100 LIKE bgeg_t.bgeg100, #交易币种
          bgeg101 LIKE bgeg_t.bgeg101, #汇率
          bgeg102 LIKE bgeg_t.bgeg102, #核准原币销售金额
          bgeg103 LIKE bgeg_t.bgeg103, #核准原币税前金额
          bgeg104 LIKE bgeg_t.bgeg104, #核准原币税额
          bgeg105 LIKE bgeg_t.bgeg105, #核准原币含税金额
          bgegownid LIKE bgeg_t.bgegownid, #资料所有者
          bgegowndp LIKE bgeg_t.bgegowndp, #资料所有部门
          bgegcrtid LIKE bgeg_t.bgegcrtid, #资料录入者
          bgegcrtdp LIKE bgeg_t.bgegcrtdp, #资料录入部门
          bgegcrtdt LIKE bgeg_t.bgegcrtdt, #资料创建日
          bgegmodid LIKE bgeg_t.bgegmodid, #资料更改者
          bgegmoddt LIKE bgeg_t.bgegmoddt, #最近更改日
          bgegcnfid LIKE bgeg_t.bgegcnfid, #资料审核者
          bgegcnfdt LIKE bgeg_t.bgegcnfdt, #数据审核日
          bgegstus LIKE bgeg_t.bgegstus, #状态码
          bgegud001 LIKE bgeg_t.bgegud001, #自定义字段(文本)001
          bgegud002 LIKE bgeg_t.bgegud002, #自定义字段(文本)002
          bgegud003 LIKE bgeg_t.bgegud003, #自定义字段(文本)003
          bgegud004 LIKE bgeg_t.bgegud004, #自定义字段(文本)004
          bgegud005 LIKE bgeg_t.bgegud005, #自定义字段(文本)005
          bgegud006 LIKE bgeg_t.bgegud006, #自定义字段(文本)006
          bgegud007 LIKE bgeg_t.bgegud007, #自定义字段(文本)007
          bgegud008 LIKE bgeg_t.bgegud008, #自定义字段(文本)008
          bgegud009 LIKE bgeg_t.bgegud009, #自定义字段(文本)009
          bgegud010 LIKE bgeg_t.bgegud010, #自定义字段(文本)010
          bgegud011 LIKE bgeg_t.bgegud011, #自定义字段(数字)011
          bgegud012 LIKE bgeg_t.bgegud012, #自定义字段(数字)012
          bgegud013 LIKE bgeg_t.bgegud013, #自定义字段(数字)013
          bgegud014 LIKE bgeg_t.bgegud014, #自定义字段(数字)014
          bgegud015 LIKE bgeg_t.bgegud015, #自定义字段(数字)015
          bgegud016 LIKE bgeg_t.bgegud016, #自定义字段(数字)016
          bgegud017 LIKE bgeg_t.bgegud017, #自定义字段(数字)017
          bgegud018 LIKE bgeg_t.bgegud018, #自定义字段(数字)018
          bgegud019 LIKE bgeg_t.bgegud019, #自定义字段(数字)019
          bgegud020 LIKE bgeg_t.bgegud020, #自定义字段(数字)020
          bgegud021 LIKE bgeg_t.bgegud021, #自定义字段(日期时间)021
          bgegud022 LIKE bgeg_t.bgegud022, #自定义字段(日期时间)022
          bgegud023 LIKE bgeg_t.bgegud023, #自定义字段(日期时间)023
          bgegud024 LIKE bgeg_t.bgegud024, #自定义字段(日期时间)024
          bgegud025 LIKE bgeg_t.bgegud025, #自定义字段(日期时间)025
          bgegud026 LIKE bgeg_t.bgegud026, #自定义字段(日期时间)026
          bgegud027 LIKE bgeg_t.bgegud027, #自定义字段(日期时间)027
          bgegud028 LIKE bgeg_t.bgegud028, #自定义字段(日期时间)028
          bgegud029 LIKE bgeg_t.bgegud029, #自定义字段(日期时间)029
          bgegud030 LIKE bgeg_t.bgegud030  #自定义字段(日期时间)030
   END RECORD
   DEFINE l_i            LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgeg007_t    LIKE bgeg_t.bgeg007
   DEFINE l_bgeg009_t    LIKE bgeg_t.bgeg009
   DEFINE l_bgeg103      LIKE bgeg_t.bgeg103
   DEFINE l_bgeg104      LIKE bgeg_t.bgeg104
   DEFINE l_bgeg105      LIKE bgeg_t.bgeg105
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
      LET l_bgeg.bgeg007 = g_bgeg_m.bgeg007
      LET l_bgeg007_t = g_bgeg007_t
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgeg.bgeg009 = g_bgeg_m.bgeg009
      LET l_bgeg.bgeg049 = g_bgeg_m.bgeg049
      LET l_bgeg009_t = g_bgeg009_t
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgeg.bgeg013 = g_bgeg_m.bgeg013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgeg.bgeg014 = g_bgeg_m.bgeg014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgeg.bgeg015 = g_bgeg_m.bgeg015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgeg.bgeg016 = g_bgeg_m.bgeg016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgeg.bgeg017 = g_bgeg_m.bgeg017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgeg.bgeg018 = g_bgeg_m.bgeg018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgeg.bgeg019 = g_bgeg_m.bgeg019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgeg.bgeg022= g_bgeg_m.bgeg022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgeg.bgeg023= g_bgeg_m.bgeg023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgeg.bgeg024= g_bgeg_m.bgeg024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgeg.bgeg012= g_bgeg_m.bgeg012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgeg.bgeg020= g_bgeg_m.bgeg020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgeg.bgeg021= g_bgeg_m.bgeg021
   END IF
   
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgeg.bgeg007 = g_bgeg_d[l_ac].bgeg007
      LET l_bgeg007_t = g_bgeg_d_t.bgeg007
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgeg.bgeg009 = g_bgeg_d[l_ac].bgeg009
      LET l_bgeg.bgeg049 = g_bgeg_d[l_ac].bgeg049
      LET l_bgeg009_t = g_bgeg_d_t.bgeg009
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgeg.bgeg013 = g_bgeg_d[l_ac].bgeg013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgeg.bgeg014 = g_bgeg_d[l_ac].bgeg014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgeg.bgeg015 = g_bgeg_d[l_ac].bgeg015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgeg.bgeg016 = g_bgeg_d[l_ac].bgeg016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgeg.bgeg017 = g_bgeg_d[l_ac].bgeg017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgeg.bgeg018 = g_bgeg_d[l_ac].bgeg018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgeg.bgeg019 = g_bgeg_d[l_ac].bgeg019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgeg.bgeg022= g_bgeg_d[l_ac].bgeg022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgeg.bgeg023= g_bgeg_d[l_ac].bgeg023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgeg.bgeg024= g_bgeg_d[l_ac].bgeg024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgeg.bgeg012= g_bgeg_d[l_ac].bgeg012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgeg.bgeg020= g_bgeg_d[l_ac].bgeg020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgeg.bgeg021= g_bgeg_d[l_ac].bgeg021
   END IF
   
   #当核算项不使用时，核算项默认给空格
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
          l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
          l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=g_bgeg_m.bgeg002
      AND bgal002=l_bgeg.bgeg007 AND bgal003=l_bgeg.bgeg049
      
   #部门
   IF (g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N') OR l_bgal.bgal005 = 'N' THEN
      LET l_bgeg.bgeg013 = ' '
   END IF
   #利润成本中心
   IF (g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N') OR l_bgal.bgal006 = 'N'  THEN
      LET l_bgeg.bgeg014 = ' '
   END IF
   #区域
   IF (g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N') OR l_bgal.bgal007 = 'N'  THEN
      LET l_bgeg.bgeg015 = ' '
   END IF
   #收付款客商
   IF (g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N') OR l_bgal.bgal008 = 'N'  THEN
      LET l_bgeg.bgeg016 = ' '
   END IF
   #账款客商
   IF (g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N') OR l_bgal.bgal009 = 'N'  THEN
      LET l_bgeg.bgeg017 = ' '
   END IF
   #客群
   IF (g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N') OR l_bgal.bgal010 = 'N'  THEN
      LET l_bgeg.bgeg018 = ' '
   END IF
   #产品类别
   IF (g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N') OR l_bgal.bgal011 = 'N' THEN
      LET l_bgeg.bgeg019 = ' '
   END IF
   #经营方式
   IF (g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N') OR l_bgal.bgal025 = 'N' THEN
      LET l_bgeg.bgeg022= ' '
   END IF
   #通路
   IF (g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N') OR l_bgal.bgal026 = 'N' THEN
      LET l_bgeg.bgeg023= ' '
   END IF
   #品牌
   IF (g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N') OR l_bgal.bgal027 = 'N' THEN
      LET l_bgeg.bgeg024= ' '
   END IF
   #人员
   IF (g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N') OR l_bgal.bgal012 = 'N' THEN
      LET l_bgeg.bgeg012= ' '
   END IF
   #专案
   IF (g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N') OR l_bgal.bgal013 = 'N' THEN
      LET l_bgeg.bgeg020= ' '
   END IF
   #WBS
   IF (g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N') OR l_bgal.bgal014 = 'N' THEN
      LET l_bgeg.bgeg021= ' '
   END IF
   
   #组合key bgeg010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET l_bgeg.bgeg010 = "bgeg013=",l_bgeg.bgeg013,"/",
                        "bgeg014=",l_bgeg.bgeg014,"/",
                        "bgeg015=",l_bgeg.bgeg015,"/",
                        "bgeg016=",l_bgeg.bgeg016,"/",
                        "bgeg017=",l_bgeg.bgeg017,"/",
                        "bgeg018=",l_bgeg.bgeg018,"/",
                        "bgeg019=",l_bgeg.bgeg019,"/",
                        "bgeg022=",l_bgeg.bgeg022,"/",
                        "bgeg023=",l_bgeg.bgeg023,"/",
                        "bgeg024=",l_bgeg.bgeg024,"/",
                        "bgeg012=",l_bgeg.bgeg012,"/",
                        "bgeg020=",l_bgeg.bgeg020,"/",
                        "bgeg021=",l_bgeg.bgeg021,""
   
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgeg.bgeg008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num1
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price1
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt1
         WHEN 2
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num2
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price2
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt2
         WHEN 3
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num3
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price3
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt3
         WHEN 4
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num4
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price4
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt4
         WHEN 5
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num5
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price5
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt5
         WHEN 6
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num6
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price6
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt6
         WHEN 7
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num7
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price7
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt7
         WHEN 8
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num8
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price8
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt8
         WHEN 9
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num9
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price9
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt9
         WHEN 10
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num10
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price10
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt10
         WHEN 11
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num11
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price11
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt11
         WHEN 12
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num12
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price12
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt12
         WHEN 13
            LET l_bgeg.bgeg038 = g_bgeg_d[l_ac].num13
            LET l_bgeg.bgeg039 = g_bgeg_d[l_ac].price13
            LET l_bgeg.bgeg040 = g_bgeg_d[l_ac].amt13
      END CASE
      #161215-00014#2--add--str--
      IF cl_null(l_bgeg.bgeg038) THEN LET l_bgeg.bgeg038 = 0 END IF
      IF cl_null(l_bgeg.bgeg039) THEN LET l_bgeg.bgeg039 = 0 END IF
      IF cl_null(l_bgeg.bgeg040) THEN LET l_bgeg.bgeg040 = 0 END IF
      #161215-00014#2--add--end
      LET l_bgeg.bgeg045 = l_bgeg.bgeg038
      LET l_bgeg.bgeg046 = l_bgeg.bgeg039
      LET l_bgeg.bgeg102 = l_bgeg.bgeg040
      #161220-00036#1--add--str--
      #汇率
      #170103-00013#1--mod--str--
#      CALL s_date_get_max_day(g_bgeg_m.bgaa002,l_bgeg.bgeg008) RETURNING l_day
#      LET l_date=MDY(l_bgeg.bgeg008,l_day,g_bgeg_m.bgaa002)
      CALL s_abg2_get_max_bgac002(g_bgeg_m.bgaa002,l_bgeg.bgeg008) RETURNING l_date
      #170103-00013#1--mod--end
      CALL s_abg_get_bg_rate(g_bgeg_m.bgeg002,l_date,g_bgeg_d[l_ac].bgeg100,g_bgeg_m.bgaa003)
      RETURNING l_bgeg.bgeg101
      #161220-00036#1--add--end
      #以稅別計算出來含税金额、未税金额、税额
#      CALL s_tax_count(l_bgeg.bgeg007,g_bgeg_d[l_ac].bgeg035,l_bgeg.bgeg102,l_bgeg.bgeg045,g_bgeg_d[l_ac].bgeg100,g_bgeg_d[l_ac].bgeg101)#161220-00036#1 mark
      CALL s_tax_count(l_bgeg.bgeg007,g_bgeg_d[l_ac].bgeg035,l_bgeg.bgeg102,l_bgeg.bgeg045,g_bgeg_d[l_ac].bgeg100,l_bgeg.bgeg101)#161220-00036#1 add
      RETURNING l_bgeg.bgeg103,l_bgeg.bgeg104,l_bgeg.bgeg105,l_bgeg103,l_bgeg104,l_bgeg105
 
      UPDATE bgeg_t SET (bgeg007,bgeg009,bgegseq,bgeg010,bgeg049, 
          bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,bgeg018,bgeg019,bgeg020, 
          bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037,bgeg100,bgeg101,bgeg038,bgeg039, 
          bgeg040,bgeg047,bgeg048,bgeg045,bgeg046,bgeg102,
          bgeg103,bgeg104,bgeg105,
          bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt, 
          bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt) = (l_bgeg.bgeg007,l_bgeg.bgeg009, 
          g_bgeg_d[l_ac].bgegseq,g_bgeg_d[l_ac].bgeg010,l_bgeg.bgeg049,l_bgeg.bgeg012, 
          l_bgeg.bgeg013,l_bgeg.bgeg014,l_bgeg.bgeg015,l_bgeg.bgeg016, 
          l_bgeg.bgeg017,l_bgeg.bgeg018,l_bgeg.bgeg019,l_bgeg.bgeg020, 
          l_bgeg.bgeg021,l_bgeg.bgeg022,l_bgeg.bgeg023,l_bgeg.bgeg024, 
          g_bgeg_d[l_ac].bgeg035,g_bgeg_d[l_ac].bgeg036,g_bgeg_d[l_ac].bgeg037,g_bgeg_d[l_ac].bgeg100, 
#          g_bgeg_d[l_ac].bgeg101,l_bgeg.bgeg038,l_bgeg.bgeg039,l_bgeg.bgeg040, #161220-00036#1 mark
          l_bgeg.bgeg101,l_bgeg.bgeg038,l_bgeg.bgeg039,l_bgeg.bgeg040, #161220-00036#1 add
          g_bgeg_d[l_ac].bgeg047,g_bgeg_d[l_ac].bgeg048,l_bgeg.bgeg045,l_bgeg.bgeg046,l_bgeg.bgeg102,
          l_bgeg.bgeg103,l_bgeg.bgeg104,l_bgeg.bgeg105,
          g_bgeg2_d[l_ac].bgegownid,g_bgeg2_d[l_ac].bgegowndp,g_bgeg2_d[l_ac].bgegcrtid,g_bgeg2_d[l_ac].bgegcrtdp, 
          g_bgeg2_d[l_ac].bgegcrtdt,g_bgeg2_d[l_ac].bgegmodid,g_bgeg2_d[l_ac].bgegmoddt,g_bgeg2_d[l_ac].bgegcnfid, 
          g_bgeg2_d[l_ac].bgegcnfdt)
       WHERE bgegent = g_enterprise 
        AND bgeg001 = g_bgeg_m.bgeg001 
        AND bgeg002 = g_bgeg_m.bgeg002 
        AND bgeg003 = g_bgeg_m.bgeg003 
        AND bgeg004 = g_bgeg_m.bgeg004 
        AND bgeg005 = g_bgeg_m.bgeg005 
        AND bgeg006 = g_bgeg_m.bgeg006 
        AND bgeg007 = l_bgeg007_t 
        AND bgeg009 = l_bgeg009_t 
        AND bgeg008 = l_bgeg.bgeg008 #期别  
        AND bgeg010 = g_bgeg_d_t.bgeg010  
        AND bgegseq = g_bgeg_d_t.bgegseq  
     CASE
        WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgeg_t" 
           LET g_errparam.code   = "std-00009" 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOR
           
        WHEN SQLCA.sqlcode #其他錯誤
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
# Descriptions...: 根据核算项组合key值bgeg010
# Memo...........:
# Usage..........: CALL abgt510_get_bgeg010()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_get_bgeg010()
  DEFINE l_bgeg RECORD  #銷售預算主檔
          bgeg007 LIKE bgeg_t.bgeg007, #预算组织
          bgeg009 LIKE bgeg_t.bgeg009, #预算料件
          bgeg010 LIKE bgeg_t.bgeg010, #组合KEY
          bgeg011 LIKE bgeg_t.bgeg011, #预算样表
          bgeg012 LIKE bgeg_t.bgeg012, #人员
          bgeg013 LIKE bgeg_t.bgeg013, #部门
          bgeg014 LIKE bgeg_t.bgeg014, #成本利润中心
          bgeg015 LIKE bgeg_t.bgeg015, #区域
          bgeg016 LIKE bgeg_t.bgeg016, #收付款客商
          bgeg017 LIKE bgeg_t.bgeg017, #账款客商
          bgeg018 LIKE bgeg_t.bgeg018, #客群
          bgeg019 LIKE bgeg_t.bgeg019, #产品类别
          bgeg020 LIKE bgeg_t.bgeg020, #项目编号
          bgeg021 LIKE bgeg_t.bgeg021, #WBS
          bgeg022 LIKE bgeg_t.bgeg022, #经营方式
          bgeg023 LIKE bgeg_t.bgeg023, #渠道
          bgeg024 LIKE bgeg_t.bgeg024, #品牌
          bgeg049 LIKE bgeg_t.bgeg049  #预算细项
   END RECORD
   
   #核算项在单头
   #预算组织
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgeg.bgeg007 = g_bgeg_m.bgeg007
   END IF
   #预算料号
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgeg.bgeg009 = g_bgeg_m.bgeg009
      LET l_bgeg.bgeg049 = g_bgeg_m.bgeg049
   END IF
   #部门
   IF g_bgaw1[3] = 'Y' THEN
      LET l_bgeg.bgeg013 = g_bgeg_m.bgeg013
   END IF
   #利润成本中心
   IF g_bgaw1[4] = 'Y' THEN
      LET l_bgeg.bgeg014 = g_bgeg_m.bgeg014
   END IF
   #区域
   IF g_bgaw1[5] = 'Y' THEN
      LET l_bgeg.bgeg015 = g_bgeg_m.bgeg015
   END IF
   #收付款客商
   IF g_bgaw1[6] = 'Y' THEN
      LET l_bgeg.bgeg016 = g_bgeg_m.bgeg016
   END IF
   #账款客商
   IF g_bgaw1[7] = 'Y' THEN
      LET l_bgeg.bgeg017 = g_bgeg_m.bgeg017
   END IF
   #客群
   IF g_bgaw1[8] = 'Y' THEN
      LET l_bgeg.bgeg018 = g_bgeg_m.bgeg018
   END IF
   #产品类别
   IF g_bgaw1[9] = 'Y' THEN
      LET l_bgeg.bgeg019 = g_bgeg_m.bgeg019
   END IF
   #经营方式
   IF g_bgaw1[10] = 'Y' THEN
      LET l_bgeg.bgeg022= g_bgeg_m.bgeg022
   END IF
   #通路
   IF g_bgaw1[11] = 'Y' THEN
      LET l_bgeg.bgeg023= g_bgeg_m.bgeg023
   END IF
   #品牌
   IF g_bgaw1[12] = 'Y' THEN
      LET l_bgeg.bgeg024= g_bgeg_m.bgeg024
   END IF
   #人员
   IF g_bgaw1[13] = 'Y' THEN
      LET l_bgeg.bgeg012= g_bgeg_m.bgeg012
   END IF
   #专案
   IF g_bgaw1[14] = 'Y' THEN
      LET l_bgeg.bgeg020= g_bgeg_m.bgeg020
   END IF
   #WBS
   IF g_bgaw1[15] = 'Y' THEN
      LET l_bgeg.bgeg021= g_bgeg_m.bgeg021
   END IF
   #核算项在单身
   #预算组织
   IF g_bgaw2[1] = 'Y' THEN
      LET l_bgeg.bgeg007 = g_bgeg_d[l_ac].bgeg007
   END IF
   #预算料号
   IF g_bgaw2[2] = 'Y' THEN
      LET l_bgeg.bgeg009 = g_bgeg_d[l_ac].bgeg009
      LET l_bgeg.bgeg049 = g_bgeg_d[l_ac].bgeg049
   END IF
   #部门
   IF g_bgaw2[3] = 'Y' THEN
      LET l_bgeg.bgeg013 = g_bgeg_d[l_ac].bgeg013
   END IF
   #利润成本中心
   IF g_bgaw2[4] = 'Y' THEN
      LET l_bgeg.bgeg014 = g_bgeg_d[l_ac].bgeg014
   END IF
   #区域
   IF g_bgaw2[5] = 'Y' THEN
      LET l_bgeg.bgeg015 = g_bgeg_d[l_ac].bgeg015
   END IF
   #收付款客商
   IF g_bgaw2[6] = 'Y' THEN
      LET l_bgeg.bgeg016 = g_bgeg_d[l_ac].bgeg016
   END IF
   #账款客商
   IF g_bgaw2[7] = 'Y' THEN
      LET l_bgeg.bgeg017 = g_bgeg_d[l_ac].bgeg017
   END IF
   #客群
   IF g_bgaw2[8] = 'Y' THEN
      LET l_bgeg.bgeg018 = g_bgeg_d[l_ac].bgeg018
   END IF
   #产品类别
   IF g_bgaw2[9] = 'Y' THEN
      LET l_bgeg.bgeg019 = g_bgeg_d[l_ac].bgeg019
   END IF
   #经营方式
   IF g_bgaw2[10] = 'Y' THEN
      LET l_bgeg.bgeg022= g_bgeg_d[l_ac].bgeg022
   END IF
   #通路
   IF g_bgaw2[11] = 'Y' THEN
      LET l_bgeg.bgeg023= g_bgeg_d[l_ac].bgeg023
   END IF
   #品牌
   IF g_bgaw2[12] = 'Y' THEN
      LET l_bgeg.bgeg024= g_bgeg_d[l_ac].bgeg024
   END IF
   #人员
   IF g_bgaw2[13] = 'Y' THEN
      LET l_bgeg.bgeg012= g_bgeg_d[l_ac].bgeg012
   END IF
   #专案
   IF g_bgaw2[14] = 'Y' THEN
      LET l_bgeg.bgeg020= g_bgeg_d[l_ac].bgeg020
   END IF
   #WBS
   IF g_bgaw2[15] = 'Y' THEN
      LET l_bgeg.bgeg021= g_bgeg_d[l_ac].bgeg021
   END IF
   
   #组合key bgeg010
   #依據预算编号，预算组织，判斷該预算细项是否做部門管理， 利潤成本中心管理，區域管理，
   #收付款客商管理，账款客商管理，客群管理，產品類別，經營方式，渠道，品牌，人員，專案，wbs管理
   LET g_bgeg_d[l_ac].bgeg010 = "bgeg013=",l_bgeg.bgeg013,"/",
                                "bgeg014=",l_bgeg.bgeg014,"/",
                                "bgeg015=",l_bgeg.bgeg015,"/",
                                "bgeg016=",l_bgeg.bgeg016,"/",
                                "bgeg017=",l_bgeg.bgeg017,"/",
                                "bgeg018=",l_bgeg.bgeg018,"/",
                                "bgeg019=",l_bgeg.bgeg019,"/",
                                "bgeg022=",l_bgeg.bgeg022,"/",
                                "bgeg023=",l_bgeg.bgeg023,"/",
                                "bgeg024=",l_bgeg.bgeg024,"/",
                                "bgeg012=",l_bgeg.bgeg012,"/",
                                "bgeg020=",l_bgeg.bgeg020,"/",
                                "bgeg021=",l_bgeg.bgeg021,""
END FUNCTION

################################################################################
# Descriptions...: 状态码变更
# Memo...........:
# Usage..........: CALL abgt510_statechange()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"

   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_bgegmodid  LIKE bgeg_t.bgegmodid
   DEFINE l_bgegmoddt  LIKE bgeg_t.bgegmoddt
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgeg_m.bgeg001 IS NULL
   OR g_bgeg_m.bgeg002 IS NULL
   OR g_bgeg_m.bgeg003 IS NULL
   OR g_bgeg_m.bgeg004 IS NULL
   OR g_bgeg_m.bgeg005 IS NULL
   OR g_bgeg_m.bgeg006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 IS NULL)
 
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
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009
      #预算组织在单头 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007
      #预算组织在单身 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg009
      #预算组织在单身 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt510_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt510_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009 INTO g_bgeg_m.bgeg002,g_bgeg_m.bgeg003, 
       g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgegstus, 
       g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019,g_bgeg_m.bgeg022,g_bgeg_m.bgeg009, 
       g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023,g_bgeg_m.bgeg049,g_bgeg_m.bgeg015, 
       g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg012,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc 
   
 
   CALL abgt510_show()
 
   CASE g_bgeg_m.bgegstus
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
   IF g_bgeg_m.bgegstus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00044'
      LET g_errparam.extend = g_bgeg_m.bgeg002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt510_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
     
   IF g_bgeg_m.bgegstus = 'FC' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00020'
      LET g_errparam.extend = g_bgeg_m.bgeg002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt510_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgeg_m.bgegstus
            
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
      CASE g_bgeg_m.bgegstus
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #abgt510中状态为最终审核时不可以异动状态要去abgt520中异动
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
            IF NOT abgt510_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt510_hcl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abgt510_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt510_hcl
            RETURN
         END IF
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL cl_err_collect_init()
            #取消审核检查
            CALL s_abgt510_unconfirm_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,
                                         g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009) 
            RETURNING l_success
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #维度检核
            CALL abgt340_02(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                                  g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg011)
            RETURNING l_success
            #审核
            CALL cl_err_collect_init()
            IF l_success = TRUE THEN
               CALL s_abgt510_confirm_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,
                                          g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009) 
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
               CLOSE abgt510_hcl         
               RETURN
            END IF
            #无效检查
            CALL s_abgt510_void_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,
                                    g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009) 
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
      g_bgeg_m.bgegstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt510_hcl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #判断执行结果，当失败时，回滚数据库
   CALL cl_err_collect_show()
   IF l_success = FALSE  THEN
      CALL s_transaction_end('N','0')
      CLOSE abgt510_hcl
      RETURN
   END IF
   #end add-point
   
   LET l_bgegmodid = g_user
   LET l_bgegmoddt = cl_get_current()
   LET g_bgeg_m.bgegstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   LET l_sql="UPDATE bgeg_t ",
             "   SET bgegstus = '",g_bgeg_m.bgegstus,"',",
             "       bgegmodid = '",l_bgegmodid,"',",
             "       bgegmoddt = to_date('",l_bgegmoddt,"','YYYY-MM-DD hh24:mi:ss'), "
   IF lc_state = 'Y' THEN
      LET l_sql=l_sql," bgegcnfid = '",g_user,"',",
                      " bgegcnfdt = to_date('",l_bgegmoddt,"','YYYY-MM-DD hh24:mi:ss') "
   ELSE
      LET l_sql=l_sql," bgegcnfid = NULL,",
                      " bgegcnfdt = NULL "
   END IF
   LET l_sql=l_sql," WHERE bgegent =  ",g_enterprise,
                   "   AND bgeg001 = '",g_bgeg_m.bgeg001,"'",
                   "   AND bgeg002 = '",g_bgeg_m.bgeg002,"'", 
                   "   AND bgeg003 = '",g_bgeg_m.bgeg003,"'", 
                   "   AND bgeg004 = '",g_bgeg_m.bgeg004,"'", 
                   "   AND bgeg005 = '",g_bgeg_m.bgeg005,"'", 
                   "   AND bgeg006 = '",g_bgeg_m.bgeg006,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg007 = '",g_bgeg_m.bgeg007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql = l_sql," AND bgeg009 = '",g_bgeg_m.bgeg009,"'"
   END IF         
   PREPARE abgt510_state_upd_pr FROM l_sql
   EXECUTE abgt510_state_upd_pr
   
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
      DISPLAY BY NAME g_bgeg_m.bgeg002,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg004_desc, 
       g_bgeg_m.bgaa002,g_bgeg_m.bgaa003,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006, 
       g_bgeg_m.bgegstus,g_bgeg_m.bgeg007,g_bgeg_m.bgeg007_desc_t,g_bgeg_m.bgeg009,g_bgeg_m.bgeg049, 
       g_bgeg_m.bgeg012,g_bgeg_m.bgeg012_desc_t,g_bgeg_m.bgeg013,g_bgeg_m.bgeg013_desc_t,g_bgeg_m.bgeg014, 
       g_bgeg_m.bgeg014_desc_t,g_bgeg_m.bgeg015,g_bgeg_m.bgeg015_desc_t,g_bgeg_m.bgeg016,g_bgeg_m.bgeg016_desc_t, 
       g_bgeg_m.bgeg017,g_bgeg_m.bgeg017_desc_t,g_bgeg_m.bgeg018,g_bgeg_m.bgeg018_desc_t,g_bgeg_m.bgeg019, 
       g_bgeg_m.bgeg019_desc_t,g_bgeg_m.bgeg020,g_bgeg_m.bgeg020_desc_t,g_bgeg_m.bgeg021,g_bgeg_m.bgeg021_desc_t, 
       g_bgeg_m.bgeg022,g_bgeg_m.bgeg023,g_bgeg_m.bgeg023_desc_t,g_bgeg_m.bgeg024,g_bgeg_m.bgeg024_desc_t 

   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgt510_hcl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('statechange:'||lc_state)
  
END FUNCTION

################################################################################
# Descriptions...: 重写修改
# Memo...........:
# Usage..........: CALL abgt510_modify_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_modify_1()
   #add-point:modify段define name="modify.define_customerization"

   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"

   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"

   #end add-point
   
   IF g_bgeg_m.bgeg001 IS NULL
   OR g_bgeg_m.bgeg002 IS NULL
   OR g_bgeg_m.bgeg003 IS NULL
   OR g_bgeg_m.bgeg004 IS NULL
   OR g_bgeg_m.bgeg005 IS NULL
   OR g_bgeg_m.bgeg006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 IS NULL)
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgeg001_t = g_bgeg_m.bgeg001
   LET g_bgeg002_t = g_bgeg_m.bgeg002
   LET g_bgeg003_t = g_bgeg_m.bgeg003
   LET g_bgeg004_t = g_bgeg_m.bgeg004
   LET g_bgeg005_t = g_bgeg_m.bgeg005
   LET g_bgeg006_t = g_bgeg_m.bgeg006
   LET g_bgeg007_t = g_bgeg_m.bgeg007
   LET g_bgeg009_t = g_bgeg_m.bgeg009
 
   CALL s_transaction_begin()
   
   CASE
      #预算组织在单头 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'Y' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009
      #预算组织在单头 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007
      #预算组织在单身 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg009
      #预算组织在单身 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt510_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt510_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009 INTO g_bgeg_m.bgeg002,g_bgeg_m.bgeg003, 
       g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgegstus, 
       g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019,g_bgeg_m.bgeg022,g_bgeg_m.bgeg009, 
       g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023,g_bgeg_m.bgeg049,g_bgeg_m.bgeg015, 
       g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg012,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc 

   
   #遮罩相關處理
   LET g_bgeg_m_mask_o.* =  g_bgeg_m.*
   CALL abgt510_bgeg_t_mask()
   LET g_bgeg_m_mask_n.* =  g_bgeg_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt510_show()
   WHILE TRUE
      LET g_bgeg001_t = g_bgeg_m.bgeg001
      LET g_bgeg002_t = g_bgeg_m.bgeg002
      LET g_bgeg003_t = g_bgeg_m.bgeg003
      LET g_bgeg004_t = g_bgeg_m.bgeg004
      LET g_bgeg005_t = g_bgeg_m.bgeg005
      LET g_bgeg006_t = g_bgeg_m.bgeg006
      LET g_bgeg007_t = g_bgeg_m.bgeg007
      LET g_bgeg009_t = g_bgeg_m.bgeg009
 
 
      #add-point:modify段修改前 name="modify.before_input"
      LET g_bgeg_m_t.* = g_bgeg_m.*
      #end add-point
      
      CALL abgt510_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"

      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgeg_m.* = g_bgeg_m_t.*
         CALL abgt510_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgeg_m.bgeg001 != g_bgeg001_t 
      OR g_bgeg_m.bgeg002 != g_bgeg002_t 
      OR g_bgeg_m.bgeg003 != g_bgeg003_t 
      OR g_bgeg_m.bgeg004 != g_bgeg004_t 
      OR g_bgeg_m.bgeg005 != g_bgeg005_t 
      OR g_bgeg_m.bgeg006 != g_bgeg006_t 
      OR g_bgeg_m.bgeg007 != g_bgeg007_t 
      OR g_bgeg_m.bgeg009 != g_bgeg009_t 
 
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
   CALL abgt510_set_act_visible()
   CALL abgt510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgegent = " ||g_enterprise|| " AND",
                      " bgeg001 = '", g_bgeg_m.bgeg001, "' "
                      ," AND bgeg002 = '", g_bgeg_m.bgeg002, "' "
                      ," AND bgeg003 = '", g_bgeg_m.bgeg003, "' "
                      ," AND bgeg004 = '", g_bgeg_m.bgeg004, "' "
                      ," AND bgeg005 = '", g_bgeg_m.bgeg005, "' "
                      ," AND bgeg006 = '", g_bgeg_m.bgeg006, "' "
                      ," AND bgeg007 = '", g_bgeg_m.bgeg007, "' "
                      ," AND bgeg009 = '", g_bgeg_m.bgeg009, "' "
 
   #填到對應位置
   CALL abgt510_browser_fill("")
 
   CALL abgt510_idx_chk()
 
   CLOSE abgt510_hcl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('modify')
END FUNCTION

################################################################################
# Descriptions...: 重写删除
# Memo...........:
# Usage..........: CALL abgt510_delete_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_delete_1()
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
   
   IF g_bgeg_m.bgeg001 IS NULL
   OR g_bgeg_m.bgeg002 IS NULL
   OR g_bgeg_m.bgeg003 IS NULL
   OR g_bgeg_m.bgeg004 IS NULL
   OR g_bgeg_m.bgeg005 IS NULL
   OR g_bgeg_m.bgeg006 IS NULL
   OR (g_bgaw1[1]='Y' AND g_bgeg_m.bgeg007 IS NULL)
   OR (g_bgaw1[2]='Y' AND g_bgeg_m.bgeg009 IS NULL)
 
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
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009
      #预算组织在单头 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'Y' AND g_bgaw1[2] = 'N' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007
      #预算组织在单身 AND #预算料号在单头
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'Y' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg009
      #预算组织在单身 AND #预算料号在单身
      WHEN g_bgaw1[1] = 'N' AND g_bgaw1[2] = 'N' 
         OPEN abgt510_hcl USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,
             g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006
   END CASE
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt510_hcl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt510_hcl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt510_master_referesh USING g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004, 
       g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009 INTO g_bgeg_m.bgeg002,g_bgeg_m.bgeg003, 
       g_bgeg_m.bgeg004,g_bgeg_m.bgeg011,g_bgeg_m.bgeg001,g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgegstus, 
       g_bgeg_m.bgeg007,g_bgeg_m.bgeg013,g_bgeg_m.bgeg016,g_bgeg_m.bgeg019,g_bgeg_m.bgeg022,g_bgeg_m.bgeg009, 
       g_bgeg_m.bgeg014,g_bgeg_m.bgeg017,g_bgeg_m.bgeg020,g_bgeg_m.bgeg023,g_bgeg_m.bgeg049,g_bgeg_m.bgeg015, 
       g_bgeg_m.bgeg018,g_bgeg_m.bgeg021,g_bgeg_m.bgeg024,g_bgeg_m.bgeg012,g_bgeg_m.bgeg002_desc,g_bgeg_m.bgeg004_desc 

   
   #遮罩相關處理
   LET g_bgeg_m_mask_o.* =  g_bgeg_m.*
   CALL abgt510_bgeg_t_mask()
   LET g_bgeg_m_mask_n.* =  g_bgeg_m.*
   
   CALL abgt510_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"

      #end add-point
      LET l_sql = "DELETE FROM bgeg_t ",
                  " WHERE bgegent = ",g_enterprise,
                  "   AND bgeg001 ='",g_bgeg_m.bgeg001,"'",
                  "   AND bgeg002 ='",g_bgeg_m.bgeg002,"'",
                  "   AND bgeg003 ='",g_bgeg_m.bgeg003,"'",
                  "   AND bgeg004 ='",g_bgeg_m.bgeg004,"'",
                  "   AND bgeg005 ='",g_bgeg_m.bgeg005,"'",
                  "   AND bgeg006 ='",g_bgeg_m.bgeg006,"'"
      #预算组织在单头
      IF g_bgaw1[1] = 'Y' THEN
         LET l_sql = l_sql,"   AND bgeg007 ='",g_bgeg_m.bgeg007,"'"
      END IF
      #预算料号在单头
      IF g_bgaw1[2] = 'Y' THEN
         LET l_sql = l_sql,"   AND bgeg009 ='",g_bgeg_m.bgeg009,"'"
      END IF
      PREPARE abgt510_delete_pr FROM l_sql
      EXECUTE abgt510_delete_pr
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
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
      CALL g_bgeg_d.clear() 
      CALL g_bgeg2_d.clear()       
      CALL g_bgeg3_d.clear()       
 
     
      CALL abgt510_ui_browser_refresh()  
      #CALL abgt510_ui_headershow()  
      #CALL abgt510_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt510_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt510_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt510_hcl
 
   #功能已完成,通報訊息中心
   CALL abgt510_msgcentre_notify('delete')
    
END FUNCTION

################################################################################
# Descriptions...: 调用abgt510_01预算调整子作业调整金额
# Memo...........:
# Usage..........: CALL abgt510_adjust(p_type)
# Input parameter: p_type      1.本层调整 2.上层调整
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_adjust(p_type)
   DEFINE p_type         LIKE type_t.num5
   DEFINE l_bgeg007      LIKE bgeg_t.bgeg007
   DEFINE l_bgeg009      LIKE bgeg_t.bgeg009
   DEFINE l_sql,l_sql1   STRING
   DEFINE l_cnt          LIKE type_t.num5
   
   IF cl_null(g_bgeg_m.bgeg001) OR cl_null(g_bgeg_m.bgeg002) OR cl_null(g_bgeg_m.bgeg003) OR
      cl_null(g_bgeg_m.bgeg004) OR cl_null(g_bgeg_m.bgeg005) OR cl_null(g_bgeg_m.bgeg006) THEN
      RETURN
   END IF
   
   IF g_bgeg_m.bgegstus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00218"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF g_bgeg_m.bgegstus = 'FC' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00020"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF l_ac < 1 OR cl_null(g_bgeg_d[l_ac].bgegseq) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-400"
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #检核预算组织或预算组织的上层组织是否已存在与abgt520中，如果存在，不可调整
   LET l_sql1 ="  FROM bgeg_t ",
               " WHERE bgegent=",g_enterprise,
               "   AND bgeg001 = '",g_bgeg_m.bgeg001,"'",
               "   AND bgeg002 = '",g_bgeg_m.bgeg002,"'", 
               "   AND bgeg003 = '",g_bgeg_m.bgeg003,"'", 
               "   AND bgeg004 = '",g_bgeg_m.bgeg004,"'", 
               "   AND bgeg005 = '",g_bgeg_m.bgeg005,"'", 
               "   AND bgeg006 = '",g_bgeg_m.bgeg006,"'"
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_sql1 = l_sql1," AND bgeg007 = '",g_bgeg_m.bgeg007,"'"
   END IF
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_sql1 = l_sql1," AND bgeg009 = '",g_bgeg_m.bgeg009,"'"
   END IF    
   LET l_cnt = 0
   #预算组织
   LET l_sql="SELECT COUNT(1) FROM bgeg_t",
             " WHERE bgegent=",g_enterprise, 
             "   AND bgeg001='30'",
             "   AND bgeg002='",g_bgeg_m.bgeg002,"'",
             "   AND bgeg003='",g_bgeg_m.bgeg003,"'",
             "   AND bgeg004='",g_bgeg_m.bgeg004,"'",
             "   AND bgeg005='",g_bgeg_m.bgeg005,"'",
             "   AND bgeg006='2'",
             "   AND bgegstus <> 'X'",
             "   AND bgeg007 IN (SELECT DISTINCT bgeg007 ",l_sql1,")"
   PREPARE abgt510_bgeg007_pr FROM l_sql
   EXECUTE abgt510_bgeg007_pr INTO l_cnt
   IF cl_null(l_cnt) THEN  LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'abg-00229'
      #161215-00014#2--mod--str--
#      LET g_errparam.replace[1] = 'abgt520'
#      LET g_errparam.replace[2] = cl_get_progname('abgt520',g_lang,"2")
      LET g_errparam.replace[1] = cl_get_progname('abgt520',g_lang,"2")
      #161215-00014#2--mod--end
      LET g_errparam.exeprog = 'abgt520'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   LET l_cnt = 0
   #预算组织的上层组织
   LET l_sql="SELECT COUNT(1) FROM bgeg_t",
             " WHERE bgegent=",g_enterprise, 
             "   AND bgeg001='30'",
             "   AND bgeg002='",g_bgeg_m.bgeg002,"'",
             "   AND bgeg003='",g_bgeg_m.bgeg003,"'",
             "   AND bgeg004='",g_bgeg_m.bgeg004,"'",
             "   AND bgeg005='",g_bgeg_m.bgeg005,"'",
             "   AND bgeg006='2'",
             "   AND bgegstus <> 'X'",
             "   AND bgeg007 IN (SELECT DISTINCT bgeg047 ",l_sql1,")"
   PREPARE abgt510_bgeg007_pr2 FROM l_sql
   EXECUTE abgt510_bgeg007_pr2 INTO l_cnt
   IF cl_null(l_cnt) THEN  LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'abg-00230'
      #161215-00014#2--mod--str--
#      LET g_errparam.replace[1] = 'abgt520'
#      LET g_errparam.replace[2] = cl_get_progname('abgt520',g_lang,"2")
      LET g_errparam.replace[1] = cl_get_progname('abgt520',g_lang,"2")
      #161215-00014#2--mod--end
      LET g_errparam.exeprog = 'abgt520'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #重写单身锁资料sql
   #161220-00036#1--mod--str--
#   LET g_forupd_sql = "SELECT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015, 
#       bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, 
#       bgeg100,bgeg101,0,bgeg047,bgeg048,bgeg050,bgegseq,bgegownid,bgegowndp, 
#       bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq FROM bgeg_t WHERE  
#       bgegent=? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=?  
#       AND bgeg007=? AND bgeg009=? AND bgeg010=? AND bgegseq=? FOR UPDATE"
   LET g_forupd_sql = "SELECT bgegseq,bgeg010,bgeg007,bgeg009,bgeg049,bgeg012,bgeg013,bgeg014,bgeg015, ",
       "bgeg016,bgeg017,bgeg018,bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024,bgeg035,bgeg036,bgeg037, ",
       "bgeg100,0,bgeg047,bgeg048,bgeg050,bgegseq,bgegownid,bgegowndp, ",
       "bgegcrtid,bgegcrtdp,bgegcrtdt,bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt,bgegseq ",
       "  FROM bgeg_t ",
       " WHERE bgegent=? AND bgeg001=? AND bgeg002=? AND bgeg003=? AND bgeg004=? AND bgeg005=? AND bgeg006=?",  
       "   AND bgeg007=? AND bgeg009=? AND bgeg010=? AND bgegseq=? FOR UPDATE"
   #161220-00036#1--mod--end
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt510_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   
   #锁住这笔项次资料
   #预算组织在单头
   IF g_bgaw1[1] = 'Y' THEN
      LET l_bgeg007 = g_bgeg_m.bgeg007
   ELSE
      LET l_bgeg007 = g_bgeg_d[l_ac].bgeg007
   END IF
   
   #预算料号在单头
   IF g_bgaw1[2] = 'Y' THEN
      LET l_bgeg009 = g_bgeg_m.bgeg009
   ELSE
      LET l_bgeg009 = g_bgeg_d[l_ac].bgeg009
   END IF
   CALL s_transaction_begin()
   OPEN abgt510_bcl2 USING g_enterprise,g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,
                          g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,l_bgeg007,l_bgeg009,g_bgeg_d[l_ac].bgeg010,
                          g_bgeg_d[l_ac].bgegseq
                 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt510_bcl2:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      CLOSE abgt510_bcl2
      RETURN
   END IF
   CALL abgt340_01(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                   g_bgeg_m.bgeg006,l_bgeg007,l_bgeg009,g_bgeg_d[l_ac].bgeg010,g_bgeg_d[l_ac].bgegseq,p_type)
   CLOSE abgt510_bcl2
   CALL s_transaction_end('Y','0')
   CALL abgt510_b_fill2(l_ac)
END FUNCTION

################################################################################
# Descriptions...: BPM提交
# Memo...........:
# Usage..........: CALL abgt510_send()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/08 By 02599
# Modify.........: 
################################################################################
PRIVATE FUNCTION abgt510_send()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success1   LIKE type_t.num5
   
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
  
   CALL abgt510_set_pk_array()
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bgeg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bgeg_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段 
   CALL cl_err_collect_init()
   #维度检核
   CALL abgt340_02(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,g_bgeg_m.bgeg005,
                   g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009,g_bgeg_m.bgeg011)
   RETURNING l_success
   #审核检查
   IF l_success = TRUE THEN
      CALL s_abgt510_confirm_chk(g_bgeg_m.bgeg001,g_bgeg_m.bgeg002,g_bgeg_m.bgeg003,g_bgeg_m.bgeg004,
                                 g_bgeg_m.bgeg005,g_bgeg_m.bgeg006,g_bgeg_m.bgeg007,g_bgeg_m.bgeg009) 
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
   #CALL abgt510_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt510_ui_headershow()
   CALL abgt510_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: BPM抽单
# Memo...........:
# Usage..........: CALL abgt510_draw_out()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/08 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_draw_out()
   
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt510_ui_headershow()  
   CALL abgt510_ui_detailshow()
 
 
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 当预算细项维护了单身才能抓取到值时，需检查单头核算项是否都录入
# Memo...........: #161215-00014#2
# Usage..........: CALL abgt510_head_hsx_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/15 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt510_head_hsx_chk()
   DEFINE l_flag        LIKE type_t.num5
   
   IF cl_null(g_bgeg_d[l_ac].bgegseq) THEN
      RETURN
   END IF
   #预算料号在单身或预算料号在单头+预算组织在单身，这两种情况预算细项都在进入单身中抓取到值
   IF NOT (g_bgaw2[2]='Y' OR (g_bgaw1[2]='Y' AND g_bgaw2[1]='Y')) THEN
      RETURN
   END IF
   LET l_flag = 0
   #部门
   IF g_bgaw1[3]='Y' AND g_bgal.bgal005 = 'Y' AND cl_null(g_bgeg_m.bgeg013) THEN
      LET l_flag = l_flag + 1
   END IF
   #利润成本中心
   IF g_bgaw1[4]='Y' AND g_bgal.bgal006 = 'Y' AND cl_null(g_bgeg_m.bgeg014) THEN
      LET l_flag = l_flag + 1
   END IF
   #区域
   IF g_bgaw1[5]='Y' AND g_bgal.bgal007 = 'Y' AND cl_null(g_bgeg_m.bgeg015) THEN
      LET l_flag = l_flag + 1
   END IF
   #收付款客商
   IF g_bgaw1[6]='Y' AND g_bgal.bgal008 = 'Y' AND cl_null(g_bgeg_m.bgeg016) THEN
      LET l_flag = l_flag + 1
   END IF 
   #账款客商
   IF g_bgaw1[7]='Y' AND g_bgal.bgal009 = 'Y' AND cl_null(g_bgeg_m.bgeg017) THEN
      LET l_flag = l_flag + 1
   END IF  
   #客群
   IF g_bgaw1[8]='Y' AND g_bgal.bgal010 = 'Y' AND cl_null(g_bgeg_m.bgeg018) THEN
      LET l_flag = l_flag + 1
   END IF
   #产品类别
   IF g_bgaw1[9]='Y' AND g_bgal.bgal011 = 'Y' AND cl_null(g_bgeg_m.bgeg019) THEN
      LET l_flag = l_flag + 1
   END IF
   #经营方式
   IF g_bgaw1[10]='Y' AND g_bgal.bgal025 = 'Y' AND cl_null(g_bgeg_m.bgeg022) THEN
      LET l_flag = l_flag + 1
   END IF
   #通路
   IF g_bgaw1[11]='Y' AND g_bgal.bgal026 = 'Y' AND cl_null(g_bgeg_m.bgeg023) THEN
      LET l_flag = l_flag + 1
   END IF
   #品牌
   IF g_bgaw1[12]='Y' AND g_bgal.bgal027 = 'Y' AND cl_null(g_bgeg_m.bgeg023) THEN
      LET l_flag = l_flag + 1
   END IF
   #人员
   IF g_bgaw1[13]='Y' AND g_bgal.bgal012 = 'Y' AND cl_null(g_bgeg_m.bgeg012) THEN
      LET l_flag = l_flag + 1
   END IF
   #专案
   IF g_bgaw1[14]='Y' AND g_bgal.bgal013 = 'Y' AND cl_null(g_bgeg_m.bgeg020) THEN
      LET l_flag = l_flag + 1
   END IF
   #WBS
   IF g_bgaw1[15]='Y' AND g_bgal.bgal014 = 'Y' AND cl_null(g_bgeg_m.bgeg021) THEN
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
 
