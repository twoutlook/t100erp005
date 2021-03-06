#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq851.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2015-03-05 17:34:39), PR版次:0008(2016-10-27 17:18:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: aglq851
#+ Description: 科目多期間二維查詢
#+ Creator....: 02599(2015-03-03 16:57:36)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq851.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#151204-00013#8    2016/01/12   By 02599   当未勾选‘含月结凭证’是，要排除CE凭证中科目属性为6.损益类科目和XC凭证中科目属性为5.成本类科目
#160505-00007#20   2016/06/07   By 02599   程式优化
#160727-00019#3  2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aglq851_print_tmp -->aglq851_tmp01
#160824-00004#2  2016/08/31  By 02599  排除XC凭证时限定科目费用类别glac010<>N.非费用科目
#160912-00013#1  2016/09/12 By 02599 '余额型态'下拉框只显示'1.发生额'和'2.累计余额'
#160913-00017#4  2016/09/21 By 07900  AGL模组调整交易客商开窗
#160824-00004#4  2016/09/23 By 02599  排除XC类凭证时，继续增加条件：来源单据的成本凭证类型(xcea002)<>(7 OR 9)
#161021-00037#2  2016/10/24 By 06821  組織類型與職能開窗調整
#161027-00022#1  2016/10/27 By 02599  含月结凭证=N时，在排除XC凭证时，增加条件：来源成本单据的成本类型(xrea002)=9 and 科目对应的费用类别(glac010)=费用类型。
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
GLOBALS "../../cfg/top_report.inc"    #20150527 add lujh
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       glaald LIKE type_t.chr500, 
   glaald_desc LIKE type_t.chr80, 
   glaacomp LIKE type_t.chr500, 
   glaacomp_desc LIKE type_t.chr80, 
   glaa001 LIKE type_t.chr500, 
   glaa016 LIKE type_t.chr500, 
   glaa020 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq002_desc LIKE type_t.chr500, 
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
   amt14 LIKE type_t.num20_6, 
   amt15 LIKE type_t.num20_6, 
   amt16 LIKE type_t.num20_6, 
   amt17 LIKE type_t.num20_6, 
   amt18 LIKE type_t.num20_6, 
   amt19 LIKE type_t.num20_6, 
   amt20 LIKE type_t.num20_6, 
   amt21 LIKE type_t.num20_6, 
   amt22 LIKE type_t.num20_6, 
   amt23 LIKE type_t.num20_6, 
   amt24 LIKE type_t.num20_6, 
   amt25 LIKE type_t.num20_6, 
   amt26 LIKE type_t.num20_6, 
   amt27 LIKE type_t.num20_6, 
   amt28 LIKE type_t.num20_6, 
   amt29 LIKE type_t.num20_6, 
   amt30 LIKE type_t.num20_6, 
   amt31 LIKE type_t.num20_6, 
   amt32 LIKE type_t.num20_6, 
   amt33 LIKE type_t.num20_6, 
   amt34 LIKE type_t.num20_6, 
   amt35 LIKE type_t.num20_6, 
   amt36 LIKE type_t.num20_6, 
   amt37 LIKE type_t.num20_6, 
   amt38 LIKE type_t.num20_6, 
   amt39 LIKE type_t.num20_6, 
   amt40 LIKE type_t.num20_6, 
   amt41 LIKE type_t.num20_6, 
   amt42 LIKE type_t.num20_6, 
   amt43 LIKE type_t.num20_6, 
   amt44 LIKE type_t.num20_6, 
   amt45 LIKE type_t.num20_6, 
   amt46 LIKE type_t.num20_6, 
   amt47 LIKE type_t.num20_6, 
   amt48 LIKE type_t.num20_6, 
   amt49 LIKE type_t.num20_6, 
   amt50 LIKE type_t.num20_6, 
   amt51 LIKE type_t.num20_6, 
   amt52 LIKE type_t.num20_6, 
   amt53 LIKE type_t.num20_6, 
   amt54 LIKE type_t.num20_6, 
   amt55 LIKE type_t.num20_6, 
   amt56 LIKE type_t.num20_6, 
   amt57 LIKE type_t.num20_6, 
   amt58 LIKE type_t.num20_6, 
   amt59 LIKE type_t.num20_6, 
   amt60 LIKE type_t.num20_6, 
   amt61 LIKE type_t.num20_6, 
   amt62 LIKE type_t.num20_6, 
   amt63 LIKE type_t.num20_6, 
   amt64 LIKE type_t.num20_6, 
   amt65 LIKE type_t.num20_6, 
   amt66 LIKE type_t.num20_6, 
   amt67 LIKE type_t.num20_6, 
   amt68 LIKE type_t.num20_6, 
   amt69 LIKE type_t.num20_6, 
   amt70 LIKE type_t.num20_6, 
   amt71 LIKE type_t.num20_6, 
   amt72 LIKE type_t.num20_6, 
   amt73 LIKE type_t.num20_6, 
   amt74 LIKE type_t.num20_6, 
   amt75 LIKE type_t.num20_6, 
   amt76 LIKE type_t.num20_6, 
   amt77 LIKE type_t.num20_6, 
   amt78 LIKE type_t.num20_6, 
   amt79 LIKE type_t.num20_6, 
   amt80 LIKE type_t.num20_6, 
   amt81 LIKE type_t.num20_6, 
   amt82 LIKE type_t.num20_6, 
   amt83 LIKE type_t.num20_6, 
   amt84 LIKE type_t.num20_6, 
   amt85 LIKE type_t.num20_6, 
   amt86 LIKE type_t.num20_6, 
   amt87 LIKE type_t.num20_6, 
   amt88 LIKE type_t.num20_6, 
   amt89 LIKE type_t.num20_6, 
   amt90 LIKE type_t.num20_6, 
   amt91 LIKE type_t.num20_6, 
   amt92 LIKE type_t.num20_6, 
   amt93 LIKE type_t.num20_6, 
   amt94 LIKE type_t.num20_6, 
   amt95 LIKE type_t.num20_6, 
   amt96 LIKE type_t.num20_6, 
   amt97 LIKE type_t.num20_6, 
   amt98 LIKE type_t.num20_6, 
   amt99 LIKE type_t.num20_6, 
   amt100 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       glaq002 LIKE glaq_t.glaq002, 
   glaq002_2_desc LIKE type_t.chr500, 
   amt101 LIKE type_t.num20_6, 
   amt102 LIKE type_t.num20_6, 
   amt103 LIKE type_t.num20_6, 
   amt104 LIKE type_t.num20_6, 
   amt105 LIKE type_t.num20_6, 
   amt106 LIKE type_t.num20_6, 
   amt107 LIKE type_t.num20_6, 
   amt108 LIKE type_t.num20_6, 
   amt109 LIKE type_t.num20_6, 
   amt110 LIKE type_t.num20_6, 
   amt111 LIKE type_t.num20_6, 
   amt112 LIKE type_t.num20_6, 
   amt113 LIKE type_t.num20_6, 
   amt114 LIKE type_t.num20_6, 
   amt115 LIKE type_t.num20_6, 
   amt116 LIKE type_t.num20_6, 
   amt117 LIKE type_t.num20_6, 
   amt118 LIKE type_t.num20_6, 
   amt119 LIKE type_t.num20_6, 
   amt120 LIKE type_t.num20_6, 
   amt121 LIKE type_t.num20_6, 
   amt122 LIKE type_t.num20_6, 
   amt123 LIKE type_t.num20_6, 
   amt124 LIKE type_t.num20_6, 
   amt125 LIKE type_t.num20_6, 
   amt126 LIKE type_t.num20_6, 
   amt127 LIKE type_t.num20_6, 
   amt128 LIKE type_t.num20_6, 
   amt129 LIKE type_t.num20_6, 
   amt130 LIKE type_t.num20_6, 
   amt131 LIKE type_t.num20_6, 
   amt132 LIKE type_t.num20_6, 
   amt133 LIKE type_t.num20_6, 
   amt134 LIKE type_t.num20_6, 
   amt135 LIKE type_t.num20_6, 
   amt136 LIKE type_t.num20_6, 
   amt137 LIKE type_t.num20_6, 
   amt138 LIKE type_t.num20_6, 
   amt139 LIKE type_t.num20_6, 
   amt140 LIKE type_t.num20_6, 
   amt141 LIKE type_t.num20_6, 
   amt142 LIKE type_t.num20_6, 
   amt143 LIKE type_t.num20_6, 
   amt144 LIKE type_t.num20_6, 
   amt145 LIKE type_t.num20_6, 
   amt146 LIKE type_t.num20_6, 
   amt147 LIKE type_t.num20_6, 
   amt148 LIKE type_t.num20_6, 
   amt149 LIKE type_t.num20_6, 
   amt150 LIKE type_t.num20_6, 
   amt151 LIKE type_t.num20_6, 
   amt152 LIKE type_t.num20_6, 
   amt153 LIKE type_t.num20_6, 
   amt154 LIKE type_t.num20_6, 
   amt155 LIKE type_t.num20_6, 
   amt156 LIKE type_t.num20_6, 
   amt157 LIKE type_t.num20_6, 
   amt158 LIKE type_t.num20_6, 
   amt159 LIKE type_t.num20_6, 
   amt160 LIKE type_t.num20_6, 
   amt161 LIKE type_t.num20_6, 
   amt162 LIKE type_t.num20_6, 
   amt163 LIKE type_t.num20_6, 
   amt164 LIKE type_t.num20_6, 
   amt165 LIKE type_t.num20_6, 
   amt166 LIKE type_t.num20_6, 
   amt167 LIKE type_t.num20_6, 
   amt168 LIKE type_t.num20_6, 
   amt169 LIKE type_t.num20_6, 
   amt170 LIKE type_t.num20_6, 
   amt171 LIKE type_t.num20_6, 
   amt172 LIKE type_t.num20_6, 
   amt173 LIKE type_t.num20_6, 
   amt174 LIKE type_t.num20_6, 
   amt175 LIKE type_t.num20_6, 
   amt176 LIKE type_t.num20_6, 
   amt177 LIKE type_t.num20_6, 
   amt178 LIKE type_t.num20_6, 
   amt179 LIKE type_t.num20_6, 
   amt180 LIKE type_t.num20_6, 
   amt181 LIKE type_t.num20_6, 
   amt182 LIKE type_t.num20_6, 
   amt183 LIKE type_t.num20_6, 
   amt184 LIKE type_t.num20_6, 
   amt185 LIKE type_t.num20_6, 
   amt186 LIKE type_t.num20_6, 
   amt187 LIKE type_t.num20_6, 
   amt188 LIKE type_t.num20_6, 
   amt189 LIKE type_t.num20_6, 
   amt190 LIKE type_t.num20_6, 
   amt191 LIKE type_t.num20_6, 
   amt192 LIKE type_t.num20_6, 
   amt193 LIKE type_t.num20_6, 
   amt194 LIKE type_t.num20_6, 
   amt195 LIKE type_t.num20_6, 
   amt196 LIKE type_t.num20_6, 
   amt197 LIKE type_t.num20_6, 
   amt198 LIKE type_t.num20_6, 
   amt199 LIKE type_t.num20_6, 
   amt200 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       glaq002 LIKE glaq_t.glaq002, 
   glaq002_3_desc LIKE type_t.chr500, 
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
   amt213 LIKE type_t.num20_6, 
   amt214 LIKE type_t.num20_6, 
   amt215 LIKE type_t.num20_6, 
   amt216 LIKE type_t.num20_6, 
   amt217 LIKE type_t.num20_6, 
   amt218 LIKE type_t.num20_6, 
   amt219 LIKE type_t.num20_6, 
   amt220 LIKE type_t.num20_6, 
   amt221 LIKE type_t.num20_6, 
   amt222 LIKE type_t.num20_6, 
   amt223 LIKE type_t.num20_6, 
   amt224 LIKE type_t.num20_6, 
   amt225 LIKE type_t.num20_6, 
   amt226 LIKE type_t.num20_6, 
   amt227 LIKE type_t.num20_6, 
   amt228 LIKE type_t.num20_6, 
   amt229 LIKE type_t.num20_6, 
   amt230 LIKE type_t.num20_6, 
   amt231 LIKE type_t.num20_6, 
   amt232 LIKE type_t.num20_6, 
   amt233 LIKE type_t.num20_6, 
   amt234 LIKE type_t.num20_6, 
   amt235 LIKE type_t.num20_6, 
   amt236 LIKE type_t.num20_6, 
   amt237 LIKE type_t.num20_6, 
   amt238 LIKE type_t.num20_6, 
   amt239 LIKE type_t.num20_6, 
   amt240 LIKE type_t.num20_6, 
   amt241 LIKE type_t.num20_6, 
   amt242 LIKE type_t.num20_6, 
   amt243 LIKE type_t.num20_6, 
   amt244 LIKE type_t.num20_6, 
   amt245 LIKE type_t.num20_6, 
   amt246 LIKE type_t.num20_6, 
   amt247 LIKE type_t.num20_6, 
   amt248 LIKE type_t.num20_6, 
   amt249 LIKE type_t.num20_6, 
   amt250 LIKE type_t.num20_6, 
   amt251 LIKE type_t.num20_6, 
   amt252 LIKE type_t.num20_6, 
   amt253 LIKE type_t.num20_6, 
   amt254 LIKE type_t.num20_6, 
   amt255 LIKE type_t.num20_6, 
   amt256 LIKE type_t.num20_6, 
   amt257 LIKE type_t.num20_6, 
   amt258 LIKE type_t.num20_6, 
   amt259 LIKE type_t.num20_6, 
   amt260 LIKE type_t.num20_6, 
   amt261 LIKE type_t.num20_6, 
   amt262 LIKE type_t.num20_6, 
   amt263 LIKE type_t.num20_6, 
   amt264 LIKE type_t.num20_6, 
   amt265 LIKE type_t.num20_6, 
   amt266 LIKE type_t.num20_6, 
   amt267 LIKE type_t.num20_6, 
   amt268 LIKE type_t.num20_6, 
   amt269 LIKE type_t.num20_6, 
   amt270 LIKE type_t.num20_6, 
   amt271 LIKE type_t.num20_6, 
   amt272 LIKE type_t.num20_6, 
   amt273 LIKE type_t.num20_6, 
   amt274 LIKE type_t.num20_6, 
   amt275 LIKE type_t.num20_6, 
   amt276 LIKE type_t.num20_6, 
   amt277 LIKE type_t.num20_6, 
   amt278 LIKE type_t.num20_6, 
   amt279 LIKE type_t.num20_6, 
   amt280 LIKE type_t.num20_6, 
   amt281 LIKE type_t.num20_6, 
   amt282 LIKE type_t.num20_6, 
   amt283 LIKE type_t.num20_6, 
   amt284 LIKE type_t.num20_6, 
   amt285 LIKE type_t.num20_6, 
   amt286 LIKE type_t.num20_6, 
   amt287 LIKE type_t.num20_6, 
   amt288 LIKE type_t.num20_6, 
   amt289 LIKE type_t.num20_6, 
   amt290 LIKE type_t.num20_6, 
   amt291 LIKE type_t.num20_6, 
   amt292 LIKE type_t.num20_6, 
   amt293 LIKE type_t.num20_6, 
   amt294 LIKE type_t.num20_6, 
   amt295 LIKE type_t.num20_6, 
   amt296 LIKE type_t.num20_6, 
   amt297 LIKE type_t.num20_6, 
   amt298 LIKE type_t.num20_6, 
   amt299 LIKE type_t.num20_6, 
   amt300 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa026       LIKE glaa_t.glaa026
DEFINE g_max_period_s  LIKE glap_t.glap004
DEFINE g_max_period_e  LIKE glap_t.glap004
#查询条件定义
DEFINE tm              RECORD
       syear           LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       eyear           LIKE glap_t.glap002,    #截止年度
       eperiod         LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       kind            LIKE type_t.chr1, 
       fix_type        LIKE type_t.chr2,
       fix_acc         LIKE type_t.chr1000, 
       show_acc        LIKE type_t.chr1, 
       glac005	        LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	        LIKE glac_t.glac009,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1
       END RECORD
DEFINE g_text            DYNAMIC ARRAY OF RECORD
       yy                LIKE glap_t.glap002,
       mm                LIKE glap_t.glap004,
       fix               LIKE type_t.chr80,
       fix_desc        LIKE type_t.chr1000,  #160505-00007#20 add
       glad0171          LIKE type_t.chr100  
       END RECORD
DEFINE g_str_glaq002   STRING
DEFINE g_field           LIKE type_t.chr100
DEFINE g_field_1         LIKE type_t.chr100
DEFINE g_field_2         LIKE type_t.chr100
DEFINE g_field_3         LIKE type_t.chr100
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
 
{<section id="aglq851.main" >}
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
   DECLARE aglq851_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq851_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq851_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq851 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq851_init()   
 
      #進入選單 Menu (="N")
      CALL aglq851_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq851
      
   END IF 
   
   CLOSE aglq851_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq851.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq851_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
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
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('fix_type','9934')
#   CALL cl_set_combo_scc('kind','9925') #160912-00013#1 mark
   CALL cl_set_combo_scc_part('kind','9925','1,2') #160912-00013#1 add
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF      
   CALL aglq851_glaald_desc(g_glaald)
   CALL aglq851_set_default_value()
   
   CALL aglq851_create_for_xg()    #20150527 add lujh
   #end add-point
 
   CALL aglq851_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq851.default_search" >}
PRIVATE FUNCTION aglq851_default_search()
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
 
{<section id="aglq851.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq851_ui_dialog() 
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
   CALL aglq851_query()
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL aglq851_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
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
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aglq851_init()
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
               CALL aglq851_detail_action_trans()
               LET g_master_idx = l_ac
               CALL aglq851_b_fill2()
 
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
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aglq851_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            CALL cl_set_act_visible("accept", FALSE)
            NEXT FIELD sel
            #end add-point
            NEXT FIELD glaald
 
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
 
            CALL aglq851_cs()
 
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
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq851_fetch('F')
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
            CALL aglq851_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq851_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq851_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq851_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq851_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq851_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL aglq851_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL aglq851_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL aglq851_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL aglq851_b_fill()
 
         
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
               IF tm.ctype = '0' THEN 
                  CALL aglq851_xg('1')
               END IF
               
               IF tm.ctype = '1' THEN 
                  CALL aglq851_xg('1')
                  
                  IF g_glaa015 = 'Y' THEN
                     CALL aglq851_xg('2')
                  END IF
               END IF
               
               IF tm.ctype = '2' THEN 
                  CALL aglq851_xg('1')
                  
                  IF g_glaa019 = 'Y' THEN
                     CALL aglq851_xg('3')
                  END IF
               END IF
               
               IF tm.ctype = '3' THEN 
                  CALL aglq851_xg('1')
                  
                  IF g_glaa015 = 'Y' THEN
                     CALL aglq851_xg('2')
                  END IF
                  
                  IF g_glaa019 = 'Y' THEN
                     CALL aglq851_xg('3')
                  END IF
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               IF tm.ctype = '0' THEN 
                  CALL aglq851_xg('1')
               END IF
               
               IF tm.ctype = '1' THEN 
                  CALL aglq851_xg('1')
                  
                  IF g_glaa015 = 'Y' THEN
                     CALL aglq851_xg('2')
                  END IF
               END IF
               
               IF tm.ctype = '2' THEN 
                  CALL aglq851_xg('1')
                  
                  IF g_glaa019 = 'Y' THEN
                     CALL aglq851_xg('3')
                  END IF
               END IF
               
               IF tm.ctype = '3' THEN 
                  CALL aglq851_xg('1')
                  
                  IF g_glaa015 = 'Y' THEN
                     CALL aglq851_xg('2')
                  END IF
                  
                  IF g_glaa019 = 'Y' THEN
                     CALL aglq851_xg('3')
                  END IF
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL aglq851_query()
               EXIT DIALOG
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exchange_ld
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN
               
               #add-point:ON ACTION exchange_ld name="menu.exchange_ld"
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_detail.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq851_glaald_desc(g_glaald)
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
 
{<section id="aglq851.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION aglq851_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   RETURN
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
 
   PREPARE aglq851_pre FROM g_sql
   DECLARE aglq851_curs SCROLL CURSOR WITH HOLD FOR aglq851_pre
   OPEN aglq851_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE aglq851_precount FROM g_cnt_sql
   EXECUTE aglq851_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL aglq851_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aglq851.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION aglq851_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
 
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
   CALL aglq851_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851.show" >}
PRIVATE FUNCTION aglq851_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   DISPLAY g_glaald,g_glaald_desc TO glaald,glaald_desc
   DISPLAY g_glaacomp,g_glaacomp_desc TO glaacomp,glaacomp_desc
   DISPLAY g_glaa001,g_glaa016,g_glaa020 TO glaa001,glaa016,glaa020
   DISPLAY tm.syear,tm.speriod,tm.eyear,tm.eperiod,tm.ctype,tm.kind,tm.fix_type,tm.fix_acc,
           tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ce,tm.show_ye
        TO syear,speriod,eyear,eperiod,ctype,kind,fix_type,fix_acc,
           show_acc,glac005,stus,glac009,show_ce,show_ye
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL aglq851_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq851_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   RETURN
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   
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
   CALL aglq851_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq851_detail_action_trans()
 
   CALL aglq851_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq851_b_fill2()
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
 
{<section id="aglq851.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq851_detail_show(ps_page)
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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION aglq851_maintain_prog()
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
 
{<section id="aglq851.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq851_detail_action_trans()
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
 
{<section id="aglq851.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq851_detail_index_setting()
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
 
{<section id="aglq851.mask_functions" >}
 &include "erp/agl/aglq851_mask.4gl"
 
{</section>}
 
{<section id="aglq851.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq851_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2015/03/03 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq851_glaald_desc(p_glaald)
   DEFINE p_glaald       LIKE glaa_t.glaald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaald 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa003,glaa004,
          glaa015,glaa016,glaa019,glaa020,glaa026
     INTO g_glaacomp,g_glaa001,g_glaa003,g_glaa004,
          g_glaa015,g_glaa016,g_glaa019,g_glaa020,g_glaa026
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
   
   DISPLAY g_glaald,g_glaald_desc TO glaald,glaald_desc
   DISPLAY g_glaacomp,g_glaacomp_desc TO glaacomp,glaacomp_desc
   DISPLAY g_glaa001,g_glaa016,g_glaa020 TO glaa001,glaa016,glaa020
   
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
      CALL cl_set_comp_visible("page_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
      CALL cl_set_comp_visible("page_2",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
      CALL cl_set_comp_visible("page_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
      CALL cl_set_comp_visible("page_3",FALSE)
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
   LET tm.ctype='0'
END FUNCTION

################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq851_set_default_value()
# Date & Author..: 2015/03/03 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq851_set_default_value()
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
   DEFINE l_str,l_str2,l_str3   STRING
   DEFINE l_i              LIKE type_t.num5
   
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
   
   #起始年度期別
   LET tm.syear=l_glav002
   LET tm.speriod=l_glav006
   #獲取現行會計週期最大期別
   SELECT MAX(glav006) INTO g_max_period_s FROM glav_t 
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   #截止年度期別
   LET tm.eperiod=l_glav006 + 1
   IF tm.eperiod > g_max_period_s THEN
      LET tm.eyear=l_glav002 + 1
      LET tm.eperiod=1
   ELSE
      LET tm.eyear=l_glav002
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
   
   #單身欄位顯示設置
   FOR l_i = 1 TO 100
       IF cl_null(l_str) THEN 
          LET l_str = l_str,"amt",l_i USING '<<<' CLIPPED
       ELSE
          LET l_str = l_str,",amt",l_i USING '<<<' CLIPPED       
       END IF
       IF g_glaa015 = 'Y' THEN
          IF cl_null(l_str2) THEN 
             LET l_str2 = l_str2,"amt",l_i + 100 USING '<<<' CLIPPED
          ELSE
             LET l_str2 = l_str2,",amt",l_i + 100 USING '<<<' CLIPPED       
          END IF
       END IF
       IF g_glaa019 = 'Y' THEN
          IF cl_null(l_str3) THEN 
             LET l_str3 = l_str3,"amt",l_i + 200 USING '<<<' CLIPPED
          ELSE
             LET l_str3 = l_str3,",amt",l_i + 200 USING '<<<' CLIPPED       
          END IF
       END IF
    END FOR
    CALL cl_set_comp_visible(l_str,FALSE)
    IF g_glaa015 = 'Y' THEN
       CALL cl_set_comp_visible(l_str2,FALSE)
    END IF
    IF g_glaa019 = 'Y' THEN
       CALL cl_set_comp_visible(l_str3,FALSE)
    END IF
END FUNCTION

################################################################################
# Descriptions...: 查询操作
# Memo...........:
# Usage..........: CALL aglq851_query()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq851_query()
   DEFINE ls_wc           LIKE type_t.chr500
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_i             LIKE type_t.num5
   
   LET l_str = NULL
   LET l_str2 = NULL
   LET l_str3 = NULL
   FOR l_i = 1 TO g_text.getLength()
      IF cl_null(l_str) THEN 
         LET l_str = l_str,"amt",l_i USING '<<<' CLIPPED
      ELSE
         LET l_str = l_str,",amt",l_i USING '<<<' CLIPPED       
      END IF
      IF g_glaa015 = 'Y' THEN
         IF cl_null(l_str2) THEN 
            LET l_str2 = l_str2,"amt",l_i + 100 USING '<<<' CLIPPED
         ELSE
            LET l_str2 = l_str2,",amt",l_i + 100 USING '<<<' CLIPPED       
         END IF
      END IF
      IF g_glaa019 = 'Y' THEN
         IF cl_null(l_str3) THEN 
            LET l_str3 = l_str3,"amt",l_i + 200 USING '<<<' CLIPPED
         ELSE
            LET l_str3 = l_str3,",amt",l_i + 200 USING '<<<' CLIPPED       
         END IF
      END IF
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible(l_str2,FALSE)
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible(l_str3,FALSE)
   END IF
   
   IF NOT cl_null(tm.ctype) THEN
      CALL cl_set_comp_visible('page_2,page_3',TRUE)
      CASE tm.ctype
         WHEN '0'
            CALL cl_set_comp_visible('page_2,page_3',FALSE)
         WHEN '1'
            CALL cl_set_comp_visible('page_3',FALSE)
         WHEN '2'
            CALL cl_set_comp_visible('page_2',FALSE)
      END CASE
   END IF
               
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_detail.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_str_glaq002 ON glaq002 FROM glaq002
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glaq002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_glaa004) THEN
               LET g_qryparam.where = "glac001 = '",g_glaa004,"'"
            END IF
            CALL aglt310_04()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq002
            NEXT FIELD glaq002                     #返回原欄位
               
      END CONSTRUCT
      
      INPUT tm.syear,tm.speriod,tm.eyear,tm.eperiod,tm.ctype,tm.kind,tm.fix_type,tm.fix_acc,
            tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ce,tm.show_ye 
         FROM syear,speriod,eyear,eperiod,ctype,kind,fix_type,fix_acc,
              show_acc,glac005,stus,glac009,show_ce,show_ye     
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT

            AFTER FIELD syear
               IF NOT cl_null(tm.syear) THEN
                  IF NOT cl_null(tm.eyear) THEN
                     IF tm.syear>tm.eyear THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00378'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
               
                        NEXT FIELD syear
                     END IF
                     IF NOT cl_null(tm.speriod) AND NOT cl_null(tm.eperiod) THEN
                        IF tm.syear=tm.eyear AND tm.speriod>tm.eperiod THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afa-00379'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                       
                           NEXT FIELD speriod
                        END IF 
                     END IF
                  END IF
               END IF
               
            AFTER FIELD speriod
               IF NOT cl_null(tm.speriod) THEN
                  IF NOT cl_null(tm.syear) THEN
                     #獲取現行會計週期最大期別
                     SELECT MAX(glav006) INTO g_max_period_s FROM glav_t 
                     WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
                     IF NOT cl_ap_chk_Range(tm.speriod,"0","1",g_max_period_s,"1","azz-00087",1) THEN
                        NEXT FIELD speriod
                     END IF
                  END IF
                  IF NOT cl_null(tm.syear) AND NOT cl_null(tm.eyear) AND NOT cl_null(tm.eperiod) THEN
                     IF tm.syear=tm.eyear AND tm.speriod > tm.eperiod THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00379'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
               
                        NEXT FIELD speriod
                     END IF
                  END IF
               END IF
         
            AFTER FIELD eyear
               IF NOT cl_null(tm.eyear) THEN
                  IF NOT cl_null(tm.syear) THEN
                     IF tm.syear>tm.eyear THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00378'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
            
                        NEXT FIELD eyear
                     END IF
                     IF NOT cl_null(tm.speriod) AND NOT cl_null(tm.eperiod) THEN
                        IF tm.syear=tm.eyear AND tm.speriod>tm.eperiod THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afa-00379'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                       
                           NEXT FIELD eperiod
                        END IF 
                     END IF
                  END IF
               END IF
            
            AFTER FIELD eperiod
               IF NOT cl_null(tm.eperiod) THEN
                  IF NOT cl_null(tm.syear) THEN
                     #獲取現行會計週期最大期別
                     SELECT MAX(glav006) INTO g_max_period_e FROM glav_t 
                     WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
                     IF NOT cl_ap_chk_Range(tm.speriod,"0","1",g_max_period_e,"1","azz-00087",1) THEN
                        NEXT FIELD speriod
                     END IF
                  END IF
                  IF NOT cl_null(tm.syear) AND NOT cl_null(tm.eyear) AND NOT cl_null(tm.speriod) THEN
                     IF tm.syear=tm.eyear AND tm.speriod > tm.eperiod THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00379'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
               
                        NEXT FIELD eperiod
                     END IF
                  END IF
               END IF
               
            ON CHANGE ctype
               IF tm.ctype NOT MATCHES '[0123]' THEN
                  NEXT FIELD ctype
               END IF
               IF NOT cl_null(tm.ctype) THEN
                  CALL cl_set_comp_visible('page_2,page_3',TRUE)
                  CASE tm.ctype
                     WHEN '0'
                        CALL cl_set_comp_visible('page_2,page_3',FALSE)
                     WHEN '1'
                        CALL cl_set_comp_visible('page_3',FALSE)
                     WHEN '2'
                        CALL cl_set_comp_visible('page_2',FALSE)
                  END CASE
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
                    
            ON ACTION controlp INFIELD fix_acc
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE tm.fix_type
                  WHEN '1' #營運據點
                     LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
                     CALL q_ooef001()
                  WHEN '2' #部門
                     LET g_qryparam.where = "ooegstus='Y'"
                     CALL q_ooeg001_4()
                  WHEN '3' #利潤/成本中心
                     LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
                     CALL q_ooeg001_4() 
                  WHEN '4' #區域
                     LET g_qryparam.arg1 = '287'
                     CALL q_oocq002_287()  
                  WHEN '5' #交易客商
                      CALL q_pmaa001_25()      #160913-00017#4  add
                        #CALL q_pmaa001()        #160913-00017#4  mark    
                  WHEN '6' #帳款客戶
                      CALL q_pmaa001_25()      #160913-00017#4  add
                       #CALL q_pmaa001()        #160913-00017#4  mark    
                  WHEN '7' #客群
                     CALL q_oocq002_281() 
                  WHEN '8' #產品類別
                     CALL q_rtax001_1() 
                  WHEN '9' #經營方式
                     LET g_qryparam.arg1 = '6013'
                     CALL q_gzcb001()
                  WHEN '10' #渠道
                     CALL q_oojd001_2()
                  WHEN '11' #品牌
                     CALL q_oocq002_2002() 
                  WHEN '12' #人員
                     CALL q_ooag001_8()
                  WHEN '13' #專案
                     CALL q_pjba001()
                  WHEN '14' #WBS
                     LET g_qryparam.where = "pjbb012='1' "
                     CALL q_pjbb002()
                  WHEN '15' #自由核算項一
                     CALL q_glar024()
                  WHEN '16' #自由核算項二
                     CALL q_glar025()
                  WHEN '17' #自由核算項三
                     CALL q_glar026()
                  WHEN '18' #自由核算項四
                     CALL q_glar027()
                  WHEN '19' #自由核算項五
                     CALL q_glar028()
                  WHEN '20' #自由核算項六
                     CALL q_glar029()
                  WHEN '21' #自由核算項七
                     CALL q_glar030()
                  WHEN '22' #自由核算項八
                     CALL q_glar031()
                  WHEN '23' #自由核算項九
                     CALL q_glar032()
                  WHEN '24' #自由核算項十
                     CALL q_glar033()
               END CASE
               LET tm.fix_acc = g_qryparam.return1
               DISPLAY tm.fix_acc TO fix_acc  #顯示到畫面上
               NEXT FIELD fix_acc               
      END INPUT
      
      BEFORE DIALOG
         DISPLAY g_glaald,g_glaald_desc TO glaald,glaald_desc
         DISPLAY g_glaacomp,g_glaacomp_desc TO glaacomp,glaacomp_desc
         DISPLAY g_glaa001,g_glaa016,g_glaa020 TO glaa001,glaa016,glaa020
         DISPLAY tm.syear,tm.speriod,tm.eyear,tm.eperiod,tm.ctype,tm.kind,tm.fix_type,tm.fix_acc,
                 tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ce,tm.show_ye
              TO syear,speriod,eyear,eperiod,ctype,kind,fix_type,fix_acc,
                 show_acc,glac005,stus,glac009,show_ce,show_ye
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
      RETURN
   END IF
   #科目条件
   IF cl_null(g_str_glaq002) THEN LET g_str_glaq002 = " 1=1" END IF

   LET g_error_show = 1
   
   #抓取符合條件的資料
   CALL cl_err_collect_init()
   LET g_success = TRUE
   CALL aglq851_set_text()
   IF g_text.getLength() > 0 THEN
      CALL aglq851_get_data()
   END IF
   IF g_success = FALSE THEN
      CALL cl_err_collect_show()
      CALL g_detail.clear()
      CALL g_detail2.clear()
      CALL g_detail3.clear() 
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
   
   LET g_error_show = 0
   LET l_ac = g_master_idx
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = -100 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   CALL cl_set_act_visible("accept,cancel", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 获取单身每列资料及说明
# Memo...........:
# Usage..........: CALL aglq851_set_text()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq851_set_text()
   DEFINE l_tok  base.stringTokenizer
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_desc          STRING
   DEFINE lc_fix_desc     STRING
   DEFINE l_index         LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_str1          STRING   #金額顯示格式
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_n,l_num       LIKE type_t.num5
   DEFINE l_format        STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_glaq002_str   STRING  #单头录入的科目查询条件
   DEFINE l_fix_acc       STRING  #单头录入的核算项查询条件
   DEFINE l_fix           LIKE type_t.chr80 #核算项编号
   DEFINE l_glfa011       LIKE glfa_t.glfa011
   DEFINE l_glad0171      LIKE type_t.chr100
   DEFINE l_k             LIKE type_t.num5
   DEFINE l_text_fix      DYNAMIC ARRAY OF RECORD
          fix             LIKE type_t.chr80,
          fix_desc        LIKE type_t.chr1000,  #160505-00007#20 add
          glad0171        LIKE type_t.chr100
          END RECORD
   DEFINE l_sql1,l_sql2,l_sql3    STRING
   DEFINE l_sdate         LIKE type_t.dat
   DEFINE l_edate         LIKE type_t.dat
   DEFINE l_max_period    LIKE type_t.num5
   DEFINE l_ooaj004       LIKE ooaj_t.ooaj004
   #160505-00007#20--add--str--
   DEFINE l_desc_sql      STRING 
   DEFINE l_yy_desc       STRING
   DEFINE l_mm_desc       STRING
   DEFINE l_fix_desc      LIKE type_t.chr1000
   #160505-00007#20--add--end
   
   CALL g_text.clear()
   LET l_n = 0
   
   LET g_field=""
   LET g_field_1=" ''"
   LET g_field_2=''
   LET g_field_3=''
   LET l_desc_sql=" '' " #160505-00007#20 add
   #設置核算項查詢條件
   #帳套+核算項
   IF NOT cl_null(tm.fix_type) THEN
      CASE tm.fix_type
         WHEN '1' #營運據點
            LET g_field="glaq017"
            LET g_field_3="glar012"
            LET l_desc_sql = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = glaq017 AND ooefl002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '2' #部門
            LET g_field="glaq018"
            LET g_field_2="glad007"
            LET g_field_3="glar013"
            LET l_desc_sql = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = glaq018 AND ooefl002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '3' #利潤/成本中心
            LET g_field="glaq019"
            LET g_field_2="glad008"
            LET g_field_3="glar014"
            LET l_desc_sql = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = glaq019 AND ooefl002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '4' #區域
            LET g_field="glaq020"
            LET g_field_2="glad009"
            LET g_field_3="glar015"
            LET l_desc_sql = "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '287' AND oocql002 = glaq020 AND oocql003='",g_dlang,"')" #160505-00007#20 add
         WHEN '5' #交易客商
            LET g_field="glaq021"
            LET g_field_2="glad010"
            LET g_field_3="glar016"
            LET l_desc_sql = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = glaq021 AND pmaal002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '6' #帳款客戶
            LET g_field="glaq022"
            LET g_field_2="glad027"
            LET g_field_3="glar017"
            LET l_desc_sql = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = glaq022 AND pmaal002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '7' #客群
            LET g_field="glaq023"
            LET g_field_2="glad011"
            LET g_field_3="glar018"
            LET l_desc_sql = "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '281' AND oocql002 = glaq023 AND oocql003='",g_dlang,"')" #160505-00007#20 add
         WHEN '8' #產品類別
            LET g_field="glaq024"
            LET g_field_2="glad012"
            LET g_field_3="glar019"
            LET l_desc_sql = "(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = '",g_enterprise,"' AND rtaxl001 = glaq024 AND rtaxl002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '9' #經營方式
            LET g_field="glaq051"
            LET g_field_2="glad031"
            LET g_field_3="glar051"
            LET l_desc_sql = "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6013' AND gzcbl002 = glaq051 AND gzcbl003 ='",g_dlang,"')" #160505-00007#20 add
         WHEN '10' #渠道
            LET g_field="glaq052"
            LET g_field_2="glad032"
            LET g_field_3="glar052"
            LET l_desc_sql = "(SELECT oojdl003 FROM oojdl_t WHERE oojdlent = '",g_enterprise,"' AND oojdl001 = glaq052 AND oojdl002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '11' #品牌
            LET g_field="glaq053" 
            LET g_field_2="glad033"
            LET g_field_3="glar053"
            LET l_desc_sql = "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '2002' AND oocql002 = glaq053 AND oocql003='",g_dlang,"')" #160505-00007#20 add
         WHEN '12' #人員
            LET g_field="glaq025"
            LET g_field_2="glad013"
            LET g_field_3="glar020"
            LET l_desc_sql = "(SELECT ooag011 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 = glaq025 )" #160505-00007#20 add
         WHEN '13' #專案
            LET g_field="glaq027"
            LET g_field_2="glad015"
            LET g_field_3="glar022"
            LET l_desc_sql = "(SELECT pjbal003 FROM pjbal_t WHERE pjbalent = '",g_enterprise,"' AND pjbal001 = glaq027 AND pjbal002 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '14' #WBS
            LET g_field="glaq028"
            LET g_field_2="glad016"
            LET g_field_3="glar023"
            LET l_desc_sql = "(SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = '",g_enterprise,"' AND pjbbl001 = glaq027 AND pjbbl002 = glaq028 AND pjbbl003 = '",g_dlang,"')" #160505-00007#20 add
         WHEN '15' #自由核算項一
            LET g_field="glaq029"
            LET g_field_1="glad0171"
            LET g_field_2="glad017"
            LET g_field_3="glar024"
         WHEN '16' #自由核算項二
            LET g_field="glaq030"
            LET g_field_1="glad0181"
            LET g_field_2="glad018"
            LET g_field_3="glar025"
         WHEN '17' #自由核算項三
            LET g_field="glaq031"
            LET g_field_1="glad0191"
            LET g_field_2="glad019"
            LET g_field_3="glar026"
         WHEN '18' #自由核算項四
            LET g_field="glaq032"
            LET g_field_1="glad0201"
            LET g_field_2="glad020"
            LET g_field_3="glar027"
         WHEN '19' #自由核算項五
            LET g_field="glaq033"
            LET g_field_1="glad0211"
            LET g_field_2="glad021"
            LET g_field_3="glar028"
         WHEN '20' #自由核算項六
            LET g_field="glaq034"
            LET g_field_1="glad0221"
            LET g_field_2="glad022"
            LET g_field_3="glar029"
         WHEN '21' #自由核算項七
            LET g_field="glaq035"
            LET g_field_1="glad0231"
            LET g_field_2="glad023"
            LET g_field_3="glar030"
         WHEN '22' #自由核算項八
            LET g_field="glaq036"
            LET g_field_1="glad0241"
            LET g_field_2="glad024"
            LET g_field_3="glar031"
         WHEN '23' #自由核算項九
            LET g_field="glaq037"
            LET g_field_1="glad0251"
            LET g_field_2="glad025"
            LET g_field_3="glar032"
         WHEN '24' #自由核算項十
            LET g_field="glaq038"
            LET g_field_1="glad0261"
            LET g_field_2="glad026"
            LET g_field_3="glar033"
      END CASE
   END IF
   
   #顯示統制科目否l_sql1
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
#151204-00013#8--mark--str--   
#   #顯示月結CE憑證否l_sql2
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#   END IF
#151204-00013#8--mark--end
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
   END IF
   
   #單據狀態l_sql3
   CASE
      WHEN tm.stus='1'
         LET l_sql3=l_sql3," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql3=l_sql3," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql3=l_sql3," AND glapstus IN ('S','Y','N') "
   END CASE
   
   #起始年度期别对应的最小日期
   SELECT MIN(glav004) INTO l_sdate FROM glav_t
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=tm.speriod
   #截止年度期别对应的最大日期
   SELECT MAX(glav004) INTO l_edate FROM glav_t
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.eyear AND glav006=tm.eperiod
   
   #設置核算項查詢條件
   #帳套+核算項
   IF NOT cl_null(tm.fix_type) THEN
      LET g_sql="SELECT DISTINCT ",g_field,",",g_field_1,      #抓取核算項編號
                "       ,",l_desc_sql,   #160505-00007#20 add
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                "   LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"' "
      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
         LET g_sql=g_sql,"  LEFT OUTER JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002"
      END IF
      LET g_sql=g_sql," WHERE glaqent=",g_enterprise,
                      "   AND glaqld = '",g_glaald,"' ",l_sql1,l_sql2,l_sql3
                      
      #發生額
      IF tm.kind='1' THEN
         LET g_sql=g_sql," AND glapdocdt BETWEEN '",l_sdate,"' AND '",l_edate,"'"
      ELSE  #累計額
         LET g_sql=g_sql," AND glapdocdt <='",l_edate,"' AND glap002>=",tm.syear
      END IF
      
      #核算項條件
      IF NOT cl_null(tm.fix_acc) THEN
         LET l_fix_acc=tm.fix_acc
         LET l_num =l_fix_acc.getIndexOf('*',1)
         IF l_num>0 THEN
            LET l_fix_acc=cl_replace_str(tm.fix_acc,"*","%")
            LET g_sql=g_sql," AND ",g_field," LIKE '",l_fix_acc,"' "
         ELSE
            LET l_fix_acc=cl_replace_str(tm.fix_acc,"|","','")
            LET l_fix_acc="'",l_fix_acc,"'"
            LET g_sql=g_sql," AND ",g_field," IN ( ",l_fix_acc," ) "
         END IF
      ELSE
         IF tm.fix_type='1' OR tm.fix_type='2' OR tm.fix_type='3' OR tm.fix_type='4' OR tm.fix_type='5' OR
            tm.fix_type='6' OR tm.fix_type='7' OR tm.fix_type='8' OR tm.fix_type='9' OR tm.fix_type='10' OR
            tm.fix_type='11' OR tm.fix_type='12' OR tm.fix_type='13' OR tm.fix_type='14'  THEN
            LET g_sql=g_sql," AND ",g_field," <> ' ' "
         END IF
      END IF
      
      #科目条件
      LET g_sql=g_sql," AND ",g_str_glaq002,
                      " ORDER BY ",g_field,",",g_field_1  
      PREPARE aglq851_fix_pr FROM g_sql
      DECLARE aglq851_fix_cs CURSOR FOR aglq851_fix_pr 
      
      CALL l_text_fix.clear()
      FOREACH aglq851_fix_cs INTO l_fix,l_glad0171,l_fix_desc #160505-00007#20 add l_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'FOREACH aglq851_fix_cs'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         LET l_i = l_text_fix.getLength()+1
         LET l_text_fix[l_i].fix=l_fix CLIPPED
         LET l_text_fix[l_i].glad0171=l_glad0171 CLIPPED
         LET l_text_fix[l_i].fix_desc=l_fix_desc  #160505-00007#20 add
         LET l_n = l_n +1 
      END FOREACH 
   END IF
   #獲取所有年度期別組合作為明細列
   LET l_n = 0
   FOR l_i=tm.syear TO tm.eyear
      IF l_i = tm.syear THEN
         LET l_j = tm.speriod
      ELSE
         LET l_j = 1
      END IF
      IF l_i = tm.eyear THEN
         LET l_max_period = tm.eperiod
      ELSE
         #獲取現行會計週期最大期別
         SELECT MAX(glav006) INTO l_max_period FROM glav_t 
         WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=l_i
      END IF
      WHILE l_j <= l_max_period
         IF NOT cl_null(tm.fix_type) THEN 
            FOR l_k=1 TO l_text_fix.getLength()
               LET l_n = g_text.getLength() +1
               LET g_text[l_n].yy=l_i
               LET g_text[l_n].mm=l_j
               LET g_text[l_n].fix=l_text_fix[l_k].fix
               LET g_text[l_n].fix_desc=l_text_fix[l_k].fix_desc #160505-00007#20 add
               LET g_text[l_n].glad0171=l_text_fix[l_k].glad0171
            END FOR
         ELSE
            LET l_n = g_text.getLength() +1
            LET g_text[l_n].yy=l_i
            LET g_text[l_n].mm=l_j
         END IF
         LET l_j=l_j+1
      END WHILE
   END FOR
   
   
   #是否有符合的帳套或營運據點
   IF l_n = 0 THEN
      RETURN 
   END IF
  
   LET l_yy_desc=cl_getmsg("agl-00274",g_dlang) #年 #160505-00007#20 add
   LET l_mm_desc=cl_getmsg("axc-00589",g_dlang) #期 #160505-00007#20 add
   
   LET l_str = NULL
   LET l_str2= NULL
   LET l_str3= NULL
   FOR l_i = 1 TO g_text.getLength()
      IF cl_null(l_str) THEN 
         LET l_str = l_str CLIPPED,"amt" CLIPPED,l_i USING '<<<<' 
      ELSE
         LET l_str = l_str CLIPPED,",amt" CLIPPED,l_i USING '<<<<' 
      END IF
      IF g_glaa015 = 'Y' THEN
         IF cl_null(l_str2) THEN 
            LET l_str2 = l_str2 CLIPPED,"amt" CLIPPED,l_i + 100 USING '<<<<' 
         ELSE
            LET l_str2 = l_str2 CLIPPED,",amt" CLIPPED,l_i + 100 USING '<<<<' 
         END IF
      END IF
      IF g_glaa019 = 'Y' THEN
         IF cl_null(l_str3) THEN 
            LET l_str3 = l_str3 CLIPPED,"amt" CLIPPED,l_i + 200 USING '<<<<' 
         ELSE
            LET l_str3 = l_str3 CLIPPED,",amt" CLIPPED,l_i + 200 USING '<<<<' 
         END IF
      END IF
      #列說明格式‘2015年03期’
      #160505-00007#20--mod--str--
#      LET l_desc=g_text[l_i].yy USING "&&&&",cl_getmsg("agl-00274",g_dlang),
#                 g_text[l_i].mm USING '&&',cl_getmsg("axc-00589",g_dlang)
      LET l_desc=g_text[l_i].yy USING "&&&&",l_yy_desc,
                 g_text[l_i].mm USING '&&',l_mm_desc
      #160505-00007#20--mod--end
      #按照核算項匯總金額
      IF NOT cl_null(tm.fix_type) THEN  #帳套+核算项
#160505-00007#20--mark--str--
#         CASE tm.fix_type
#            WHEN '1' #營運據點
#               CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '2' #部門
#               CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '3' #利潤成本中心
#               CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '4' #區域
#               CALL s_desc_get_acc_desc('287',g_text[l_i].fix) RETURNING lc_fix_desc 
#            WHEN '5' #交易客商
#               CALL s_desc_get_trading_partner_abbr_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '6' #帳款客戶
#               CALL s_desc_get_trading_partner_abbr_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '7' #客群
#               CALL s_desc_get_acc_desc('281',g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '8' #產品分類
#               CALL s_desc_get_rtaxl003_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '9' #经营方式
#               CALL s_desc_gzcbl004_desc('6013',g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '10' #渠道
#               CALL s_desc_get_oojdl003_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '11' #品牌
#               CALL s_desc_get_acc_desc('2002',g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '12' #人員
#               CALL s_desc_get_person_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '13' #专案
#               CALL s_desc_get_project_desc(g_text[l_i].fix) RETURNING lc_fix_desc
#            WHEN '14' #WBS
#               #CALL s_desc_get_wbs_desc('',g_text[l_i].fix) RETURNING lc_fix_desc
#               LET lc_fix_desc = g_text[l_i].fix
#         END CASE
#160505-00007#20--mark--end
         
         #核算项说明
         LET lc_fix_desc = g_text[l_i].fix_desc #160505-00007#20 add
         
         IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
            tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
            CALL s_voucher_free_account_desc(g_text[l_i].glad0171,g_text[l_i].fix) 
            RETURNING lc_fix_desc
         END IF
         #核算項編號+說明
         IF cl_null(lc_fix_desc) THEN
            LET lc_fix_desc=g_text[l_i].fix
         ELSE
            LET lc_fix_desc="(",g_text[l_i].fix,")",lc_fix_desc
         END IF
         IF tm.syear=tm.eyear THEN
            #列說明格式‘03期(SY)事业部’
#            LET l_desc=g_text[l_i].mm USING '&&',cl_getmsg("axc-00589",g_dlang),lc_fix_desc #160505-00007#20 mark
            LET l_desc=g_text[l_i].mm USING '&&',l_mm_desc,lc_fix_desc #160505-00007#20 add
         ELSE
            #列說明格式‘2015年03期(SY)事业部’
            #160505-00007#20--mod--str--
#            LET l_desc=g_text[l_i].yy USING "&&&&",cl_getmsg("agl-00274",g_dlang),
#                       g_text[l_i].mm USING '&&',cl_getmsg("axc-00589",g_dlang),lc_fix_desc
            LET l_desc=g_text[l_i].yy USING "&&&&",l_yy_desc,
                       g_text[l_i].mm USING '&&',l_mm_desc,lc_fix_desc 
            #160505-00007#20--mod--end           
         END IF
      END IF       
      LET l_index = l_i USING "<<<<"
      CALL cl_set_comp_att_text("amt" || l_index,l_desc)
      IF g_glaa015 = 'Y' THEN
         LET l_index = l_i+100 USING "<<<<"
         CALL cl_set_comp_att_text("amt" || l_index,l_desc)
      END IF
      IF g_glaa019 = 'Y' THEN
         LET l_index = l_i+200 USING "<<<<"
         CALL cl_set_comp_att_text("amt" || l_index,l_desc)
      END IF
   END FOR
   
   CALL cl_set_comp_visible(l_str,TRUE)
   #取本幣的金额小數位數
   CALL s_curr_sel_ooaj004(g_glaa026,g_glaa001) RETURNING l_ooaj004
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str1 = ""
   FOR l_j=1 TO l_ooaj004
       LET l_str1 = l_str1,"&"
   END FOR
   IF NOT cl_null(l_str1) THEN
      LET l_format = l_format,'.',l_str1
   END IF
   CALL cl_set_comp_format(l_str,l_format)
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible(l_str2,TRUE)
      #取本幣的金额小數位數
      CALL s_curr_sel_ooaj004(g_glaa026,g_glaa016) RETURNING l_ooaj004
      #設置單身金額欄位格式
      LET l_format = "---,---,---,--&"
      LET l_str1 = ""
      FOR l_j=1 TO l_ooaj004
          LET l_str1 = l_str1,"&"
      END FOR
      IF NOT cl_null(l_str1) THEN
         LET l_format = l_format,'.',l_str1
      END IF
      CALL cl_set_comp_format(l_str2,l_format)
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible(l_str3,TRUE)
      #取本幣的金额小數位數
      CALL s_curr_sel_ooaj004(g_glaa026,g_glaa020) RETURNING l_ooaj004
      #設置單身金額欄位格式
      LET l_format = "---,---,---,--&"
      LET l_str1 = ""
      FOR l_j=1 TO l_ooaj004
          LET l_str1 = l_str1,"&"
      END FOR
      IF NOT cl_null(l_str1) THEN
         LET l_format = l_format,'.',l_str1
      END IF
      CALL cl_set_comp_format(l_str3,l_format)
   END IF

   LET l_str = NULL 
   LET l_str2= NULL
   LET l_str3= NULL 
   FOR l_i = g_text.getLength()+1 TO 100
      IF cl_null(l_str) THEN 
         LET l_str = l_str CLIPPED,"amt" CLIPPED,l_i USING '<<<<' 
      ELSE
         LET l_str = l_str CLIPPED,",amt" CLIPPED,l_i USING '<<<<' 
      END IF
      IF g_glaa015 = 'Y' THEN
         IF cl_null(l_str2) THEN 
            LET l_str2 = l_str2 CLIPPED,"amt" CLIPPED,l_i + 100 USING '<<<<' 
         ELSE
            LET l_str2 = l_str2 CLIPPED,",amt" CLIPPED,l_i + 100 USING '<<<<' 
         END IF
      END IF
      IF g_glaa019 = 'Y' THEN
         IF cl_null(l_str3) THEN 
             LET l_str3 = l_str3 CLIPPED,"amt",l_i + 200 USING '<<<<'
          ELSE
             LET l_str3 = l_str3 CLIPPED,",amt",l_i + 200 USING '<<<<'       
          END IF
      END IF
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)
   IF g_glaa015 = 'Y' THEN
       CALL cl_set_comp_visible(l_str2,FALSE)
    END IF
    IF g_glaa019 = 'Y' THEN
       CALL cl_set_comp_visible(l_str3,FALSE)
    END IF
END FUNCTION

################################################################################
# Descriptions...: 获取科目资料及金额
# Memo...........:
# Usage..........: CALL aglq851_get_data()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq851_get_data()
   DEFINE l_str_glaq002               STRING
   DEFINE l_sql1,l_sql2,l_sql3,l_sql4 STRING
   DEFINE l_sql_1,l_sql_2,l_sql_3     STRING
   DEFINE l_glac002                   LIKE glac_t.glac002
   DEFINE l_glac003                   LIKE glac_t.glac003
   DEFINE l_glac008                   LIKE glac_t.glac008
   DEFINE l_field_value               LIKE type_t.chr100
   DEFINE l_amt1,l_amt2,l_amt3        LIKE type_t.num20_6
   DEFINE l_amt4,l_amt5,l_amt6        LIKE type_t.num20_6
   DEFINE l_i,l_j                     LIKE type_t.num10
   DEFINE l_glaq002                   STRING
   #151204-00013#8--add--str--
   DEFINE l_glac002_str               STRING 
   DEFINE l_sql_11                    STRING
   DEFINE l_sql_12                    STRING
   #151204-00013#8--add--end
   #160505-00007#20--add--str--
   DEFINE l_sql_pr1                   STRING
   DEFINE l_sql_pr2                   STRING
   DEFINE l_sql_pr3                   STRING
   DEFINE l_sql_pr11                  STRING
   DEFINE l_sql_pr12                  STRING
   DEFINE l_glacl004                  LIKE glacl_t.glacl004
   #160505-00007#20--add--end
   DEFINE l_glav004             LIKE glav_t.glav004 #160824-00004#4 add
   
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
#151204-00013#8--mark--str--   
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#   END IF
#151204-00013#8--mark--end
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
   END IF
   
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql3=l_sql3," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql3=l_sql3," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql3=l_sql3," AND glapstus IN ('S','Y','N') "
   END CASE
   
   #抓出所有符合條件的會計科目
   #160505-00007#20--mod--str--
#   LET g_sql="SELECT DISTINCT glac002 FROM glac_t",
   LET g_sql="SELECT DISTINCT glac002,glacl004,glac003,glac008  FROM glac_t",
             "  LEFT JOIN glacl_t ON glaclent=glacent AND glacl001=glac001 AND glacl002=glac002 AND glacl003='",g_dlang,"'",
   #160505-00007#20--mod--end
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' ",l_sql1
   #科目条件
   LET l_str_glaq002=cl_replace_str(g_str_glaq002,"glaq002","glac002")
   LET g_sql=g_sql," AND ",l_str_glaq002
   #當勾選核算項類型時查詢啟用該核算項的科目
   IF NOT cl_null(tm.fix_type) AND tm.fix_type<> '1' THEN
      LET g_sql=g_sql," AND glac002 IN (SELECT DISTINCT glad001 FROM glad_t ",
                      "                  WHERE gladent =",g_enterprise," AND gladld = '",g_glaald,"'",
                      "                    AND ",g_field_2," = 'Y' ",
                      "                   )"
   END IF
   LET g_sql=g_sql," ORDER BY glac002"
   PREPARE aglq850_glac002_pr FROM g_sql
   DECLARE aglq850_glac002_cs CURSOR FOR aglq850_glac002_pr
   
   #160505-00007#20--add--str--
   #程式优化，将SQL语句拿到FOREACH外
   IF NOT cl_null(tm.fix_type) THEN
      #發生額(借-貸)且狀態為1：已過帳
      LET l_sql_pr1="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise,
                    "   AND glapld = '",g_glaald,"' ",
                    "   AND glap002 = ? AND glap004 = ?",
                    "   AND ",g_field,"=? ",l_sql2,l_sql3
      
      #累計額(借-貸)且狀態為1：已過帳
      LET l_sql_pr2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise,
                    "   AND glapld = '",g_glaald,"' ",
                    "   AND glap002 = ? AND glap004 <= ?",
                    "   AND ",g_field,"=? ",l_sql2,l_sql3
      #年初數
      LET l_sql_pr3="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                    " WHERE glarent=",g_enterprise,
                    "   AND glarld ='",g_glaald,"'",
                    "   AND glar002 = ? AND glar003=0",
                    "   AND glar001 = ? AND ",g_field_3,"=? "
                  
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #發生額(借-貸)且狀態為
         LET l_sql_pr11="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                        " WHERE glaqent=",g_enterprise,
                        "   AND glapld = '",g_glaald,"' ",
                        "   AND glap002 = ? AND glap004 = ?",
                        "   AND ",g_field,"=? ",l_sql3
         
         #累計額(借-貸)且狀態為1：已過帳
         LET l_sql_pr12="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                        " WHERE glaqent=",g_enterprise,
                        "   AND glapld = '",g_glaald,"' ",
                        "   AND glap002 = ? AND glap004 <= ?",
                        "   AND ",g_field,"=? ",l_sql3
      END IF
   ELSE
      #發生額(借-貸)且狀態為1：已過帳
      LET l_sql_pr1="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise,
                    "   AND glapld = '",g_glaald,"' ",
                    "   AND glap002 = ? AND glap004 = ?",
                    l_sql2,l_sql3
      
      #累計額(借-貸)且狀態為1：已過帳
      LET l_sql_pr2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise,
                    "   AND glapld = '",g_glaald,"' ",
                    "   AND glap002 = ? AND glap004 <= ?",
                    l_sql2,l_sql3
      
      #年初數
      LET l_sql_pr3="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                    " WHERE glarent=",g_enterprise,
                    "   AND glarld ='",g_glaald,"'",
                    "   AND glar002 = ? AND glar003=0",
                    "   AND glar001 = ? "

      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #發生額(借-貸)且狀態為1：已過帳
         LET l_sql_pr11="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                        " WHERE glaqent=",g_enterprise,
                        "   AND glapld = '",g_glaald,"' ",
                        "   AND glap002 = ? AND glap004 = ?",
                        l_sql3
         
         #累計額(借-貸)且狀態為1：已過帳
         LET l_sql_pr12="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                        " WHERE glaqent=",g_enterprise,
                        "   AND glapld = '",g_glaald,"' ",
                        "   AND glap002 = ? AND glap004 <= ?",
                        l_sql3
      END IF
   END IF
      
   IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
      tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
      LET l_sql4=" AND (SELECT DISTINCT glad001 FROM glad_t ",
                 "       WHERE gladent=",g_enterprise,
                 "         AND gladld='",g_glaald,"'",
                 "         AND ",g_field_2," = 'Y' ",
                 "         AND ",g_field_1," = ?)"
      LET l_sql_pr1=l_sql_pr1,l_sql4
      LET l_sql_pr2=l_sql_pr2,l_sql4
      LET l_sql_pr3=l_sql_pr3,l_sql4
      
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         LET l_sql_pr11=l_sql_pr11,l_sql4
         LET l_sql_pr12=l_sql_pr12,l_sql4
      END IF
   END IF
         
   #年初數
   PREPARE aglq850_sel_pr3 FROM l_sql_pr3
   #160505-00007#20--add--end
   
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   LET l_i=1
   FOREACH aglq850_glac002_cs INTO l_glac002
                                  ,l_glacl004,l_glac003,l_glac008  #160505-00007#20 add 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq850_glac002_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      LET g_detail[l_i].sel='N'
      LET g_detail[l_i].glaq002=l_glac002
      #會計科目名稱
#160505-00007#20--mod--str--
#      SELECT glacl004 INTO g_detail[l_i].glaq002_desc FROM glacl_t
#       WHERE glaclent = g_enterprise
#         AND glacl001 = g_glaa004
#         AND glacl002 = l_glac002
#         AND glacl003 = g_dlang
      LET g_detail[l_i].glaq002_desc=l_glacl004
#160505-00007#20--mod--end
      #本位幣二
      IF g_glaa015 = 'Y' THEN
         LET g_detail2[l_i].glaq002=l_glac002
         LET g_detail2[l_i].glaq002_2_desc=g_detail[l_i].glaq002_desc
      END IF
      #本位幣三
      IF g_glaa019 = 'Y' THEN
         LET g_detail3[l_i].glaq002=l_glac002
         LET g_detail3[l_i].glaq002_3_desc=g_detail[l_i].glaq002_desc
      END IF
      
      #餘額方向
#160505-00007#20--mark--str--
#      SELECT glac003,glac008 INTO l_glac003,l_glac008 FROM glac_t
#       WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glac002
#160505-00007#20--mark--end
#      #當統制科目時匯總該統制科目下層所以明細科目
#      IF l_glac003 = '1' THEN
#         LET l_glac002=l_glac002,"%"
#      END IF
      
      #抓取科目对应的明细科目或者独立科目
      #当为统治科目时抓取下层明细科目
      LET l_glaq002=''  #160824-00004#4 aadd
      IF l_glac003='1' THEN #160505-00007#20 add
      CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
      END IF #160824-00004#4 add
      #160505-00007#20--add--str--
#      ELSE #160824-00004#4 add
      IF cl_null(l_glaq002) THEN  #160824-00004#4 add
         LET l_glaq002="'",l_glac002,"'"
      END IF
      #160505-00007#20--add--end
      
      #151204-00013#8--add--str--
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
      END IF
      #151204-00013#8--add--end
      
      #当该统治科目没有下层明细科目时，抓取该科目本身资料
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = " AND glaq002 ='",l_glac002,"'"
      ELSE
         LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
      END IF
      
      IF NOT cl_null(tm.fix_type) THEN
         #發生額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--
#         LET l_sql_1="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                     "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                     " WHERE glaqent=",g_enterprise,
#                     "   AND glapld = '",g_glaald,"' ",
#                     "   AND glap002 = ? AND glap004 = ?",
#                     l_glaq002,
#                     "   AND ",g_field,"=? ",l_sql2,l_sql3
#160505-00007#20--mark--end
         LET l_sql_1=l_sql_pr1,l_glaq002 #160505-00007#20 add
         
         #累計額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--
#         LET l_sql_2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                     "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                     " WHERE glaqent=",g_enterprise,
#                     "   AND glapld = '",g_glaald,"' ",
#                     "   AND glap002 = ? AND glap004 <= ?",
#                     l_glaq002,
#                     "   AND ",g_field,"=? ",l_sql2,l_sql3
#160505-00007#20--mark--end
         LET l_sql_2=l_sql_pr2,l_glaq002 #160505-00007#20 add
#160505-00007#20--mark--str--
#         #年初數
#         LET l_sql_3="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
#                     " WHERE glarent=",g_enterprise,
#                     "   AND glarld ='",g_glaald,"'",
#                     "   AND glar002 = ? AND glar003=0",
#                     "   AND glar001 = ? AND ",g_field_3,"=? "
#160505-00007#20--mark--end                     
         #151204-00013#8--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            #發生額(借-貸)且狀態為
#160505-00007#20--mark--str--
#            LET l_sql_11="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                        " WHERE glaqent=",g_enterprise,
#                        "   AND glapld = '",g_glaald,"' ",
#                        "   AND glap002 = ? AND glap004 = ?",
#                        l_glaq002,
#                        "   AND ",g_field,"=? ",l_sql3,
#160505-00007#20--mark--end
          LET l_sql_11= l_sql_pr11,l_glaq002, #160505-00007#20 add
                        "   AND (",
                        "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac007='6' ",l_glac002_str,"))",
                        "         OR ",
                        "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                        "                                         AND glac007='5' ",l_glac002_str,#"))",  #160824-00004#4 mark '))'
                        #160824-00004#4--add--str--
                        "                                     )",
#                        "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                        "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                        "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                        "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                        "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                        "                                               AND xcea004=? AND xcea005=? ",
                        "                                     )",
                        "        )",
                        #160824-00004#4--add--end
                        "       )"
            
            #累計額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--
#            LET l_sql_12="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                        " WHERE glaqent=",g_enterprise,
#                        "   AND glapld = '",g_glaald,"' ",
#                        "   AND glap002 = ? AND glap004 <= ?",
#                        l_glaq002,
#                        "   AND ",g_field,"=? ",l_sql3,
#160505-00007#20--mark--end
          LET l_sql_12= l_sql_pr12,l_glaq002,       #160505-00007#20 add  
                        "   AND (",
                        "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac007='6' ",l_glac002_str,"))",
                        "         OR ",
                        "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                        "                                         AND glac007='5' ",l_glac002_str,#"))",  #160824-00004#4 mark '))'
                        #160824-00004#4--add--str--
                        "                                     )",
#                        "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                        "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                        "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                        "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                        "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                        "                                               AND xcea004=? AND xcea005<=? ",
                        "                                     )",
                        "        )",
                        #160824-00004#4--add--end
                        "       )"
         END IF
         #151204-00013#8--add--end
      ELSE
         #發生額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--
#         LET l_sql_1="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                     "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                     " WHERE glaqent=",g_enterprise,
#                     "   AND glapld = '",g_glaald,"' ",
#                     "   AND glap002 = ? AND glap004 = ?",
#                     l_glaq002,l_sql2,l_sql3
#160505-00007#20--mark--end
         LET l_sql_1=l_sql_pr1,l_glaq002 #160505-00007#20 add
         #累計額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--         
#         LET l_sql_2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                     "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                     " WHERE glaqent=",g_enterprise,
#                     "   AND glapld = '",g_glaald,"' ",
#                     "   AND glap002 = ? AND glap004 <= ?",
#                     l_glaq002,l_sql2,l_sql3
#160505-00007#20--mark--end
         LET l_sql_2=l_sql_pr2,l_glaq002  #160505-00007#20 add
#160505-00007#20--mark--str--
#         #年初數
#         LET l_sql_3="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
#                     " WHERE glarent=",g_enterprise,
#                     "   AND glarld ='",g_glaald,"'",
#                     "   AND glar002 = ? AND glar003=0",
#                     "   AND glar001 = ? "
#160505-00007#20--mark--end         
         #151204-00013#8--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            #發生額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--
#            LET l_sql_11="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                        " WHERE glaqent=",g_enterprise,
#                        "   AND glapld = '",g_glaald,"' ",
#                        "   AND glap002 = ? AND glap004 = ?",
#                        l_glaq002,l_sql3,
#160505-00007#20--mark--end 
            LET l_sql_11=l_sql_pr11,l_glaq002,  #160505-00007#20 add
                        "   AND (",
                        "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac007='6' ",l_glac002_str,"))",
                        "         OR ",
                        "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                        "                                         AND glac007='5' ",l_glac002_str,#"))",  #160824-00004#4 mark '))'
                        #160824-00004#4--add--str--
                        "                                     )",
#                        "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                        "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                        "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                        "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                        "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                        "                                               AND xcea004=? AND xcea005=? ",
                        "                                     )",
                        "        )",
                        #160824-00004#4--add--end
                        "       )"
            
            #累計額(借-貸)且狀態為1：已過帳
#160505-00007#20--mark--str--
#            LET l_sql_12="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
#                        "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                        " WHERE glaqent=",g_enterprise,
#                        "   AND glapld = '",g_glaald,"' ",
#                        "   AND glap002 = ? AND glap004 <= ?",
#                        l_glaq002,l_sql3,
#160505-00007#20--mark--end
            LET l_sql_12=l_sql_pr12,l_glaq002,  #160505-00007#20 add
                        "   AND (",
                        "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac007='6' ",l_glac002_str,"))",
                        "         OR ",
                        "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                        "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                        "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                        "                                         AND glac007='5' ",l_glac002_str,#"))",  #160824-00004#4 mark '))'
                        #160824-00004#4--add--str--
                        "                                     )",
#                        "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                        "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                        "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                        "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                        "                                               AND xcea002 ='9'  AND xcea101 IS NOT NULL",  #161027-00022#1 add
                        "                                               AND xcea004=? AND xcea005<=? ",
                        "                                     )",
                        "        )",
                        #160824-00004#4--add--end
                        "       )"
         END IF
         #151204-00013#8--add--end
      END IF
#160505-00007#20--mark--str--     
#      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
#         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
#         LET l_sql4=" AND (SELECT DISTINCT glad001 FROM glad_t ",
#                    "       WHERE gladent=",g_enterprise,
#                    "         AND gladld='",g_glaald,"'",
#                    "         AND ",g_field_2," = 'Y' ",
#                    "         AND ",g_field_1," = ?)"
#         LET l_sql_1=l_sql_1,l_sql4
#         LET l_sql_2=l_sql_2,l_sql4
#         LET l_sql_3=l_sql_3,l_sql4
#         
#         #151204-00013#8--add--str--
#         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
#         IF tm.show_ce <> 'Y' THEN
#            LET l_sql_11=l_sql_11,l_sql4
#            LET l_sql_12=l_sql_12,l_sql4
#         END IF
#         #151204-00013#8--add--end
#      END IF
#160505-00007#20--mark--end         
      #發生額(借-貸)
      PREPARE aglq850_sel_pr1 FROM l_sql_1 
      #整期間累計額(借-貸)
      PREPARE aglq850_sel_pr2 FROM l_sql_2
      #年初數
#      PREPARE aglq850_sel_pr3 FROM l_sql_3  #160505-00007#20 mark
          
      #151204-00013#8--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #發生額(借-貸)
         PREPARE aglq850_sel_pr1_1 FROM l_sql_11 
         #整期間累計額(借-貸)
         PREPARE aglq850_sel_pr2_1 FROM l_sql_12
      END IF
      #151204-00013#8--add--end
      
      FOR l_j = 1 TO g_text.getLength()
         #當選擇核算項資料時傳入核算項值，按年度+期别+核算項匯總科目金額
         #當未選擇核算項時傳入帳套值，按年度+期别匯總科目金額
         #發生額
         IF tm.kind='1' THEN
            IF NOT cl_null(tm.fix_type) THEN
               IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
                  tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
                  EXECUTE aglq850_sel_pr1 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix,g_text[l_j].glad0171
                                           INTO l_amt1,l_amt2,l_amt3
               ELSE
                  EXECUTE aglq850_sel_pr1 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix
                                           INTO l_amt1,l_amt2,l_amt3
               END IF
            ELSE
               EXECUTE aglq850_sel_pr1 USING g_text[l_j].yy,g_text[l_j].mm
                                        INTO l_amt1,l_amt2,l_amt3
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_sel_pr1'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            
            #151204-00013#8--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               IF NOT cl_null(tm.fix_type) THEN
                  IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
                     tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
                     EXECUTE aglq850_sel_pr1_1 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix,g_text[l_j].glad0171
                                                    ,g_text[l_j].yy,g_text[l_j].mm #160824-00004#4 add
                                              INTO l_amt4,l_amt5,l_amt6
                  ELSE
                     EXECUTE aglq850_sel_pr1_1 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix
                                                    ,g_text[l_j].yy,g_text[l_j].mm #160824-00004#4 add
                                              INTO l_amt4,l_amt5,l_amt6
                  END IF
               ELSE
                  EXECUTE aglq850_sel_pr1_1 USING g_text[l_j].yy,g_text[l_j].mm
                                                 ,g_text[l_j].yy,g_text[l_j].mm #160824-00004#4 add
                                           INTO l_amt4,l_amt5,l_amt6
               END IF
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq850_sel_pr1_1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_success = FALSE
               END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               LET l_amt1 = l_amt1 - l_amt4
               LET l_amt2 = l_amt2 - l_amt5
               LET l_amt3 = l_amt3 - l_amt6
            END IF
            #151204-00013#8--add--end
         ELSE
         #累計額
            #年初數
            IF NOT cl_null(tm.fix_type) THEN
               IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
                  tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
                  EXECUTE aglq850_sel_pr3 USING g_text[l_j].yy,g_detail[l_i].glaq002,g_text[l_j].fix,g_text[l_j].glad0171
                                           INTO l_amt1,l_amt2,l_amt3
               ELSE
                  EXECUTE aglq850_sel_pr3 USING g_text[l_j].yy,g_detail[l_i].glaq002,g_text[l_j].fix
                                           INTO l_amt1,l_amt2,l_amt3
               END IF
            ELSE
               EXECUTE aglq850_sel_pr3 USING g_text[l_j].yy,g_detail[l_i].glaq002
                                        INTO l_amt1,l_amt2,l_amt3
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_sel_pr3'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF
            #到截止日期金額匯總
            IF NOT cl_null(tm.fix_type) THEN
               IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
                  tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
                  EXECUTE aglq850_sel_pr2 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix,g_text[l_j].glad0171
                                        INTO l_amt4,l_amt5,l_amt6
               ELSE
                  EXECUTE aglq850_sel_pr2 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix
                                           INTO l_amt4,l_amt5,l_amt6
               END IF
            ELSE
               EXECUTE aglq850_sel_pr2 USING g_text[l_j].yy,g_text[l_j].mm
                                        INTO l_amt4,l_amt5,l_amt6
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_sel_pr2'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF 
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            LET l_amt1=l_amt1+l_amt4
            LET l_amt2=l_amt2+l_amt5
            LET l_amt3=l_amt3+l_amt6
            
            #151204-00013#8--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               IF NOT cl_null(tm.fix_type) THEN
                  IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
                     tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
                     EXECUTE aglq850_sel_pr2_1 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix,g_text[l_j].glad0171
                                                    ,g_text[l_j].yy,g_text[l_j].mm #160824-00004#4 add
                                                INTO l_amt4,l_amt5,l_amt6
                  ELSE
                     EXECUTE aglq850_sel_pr2_1 USING g_text[l_j].yy,g_text[l_j].mm,g_text[l_j].fix
                                                    ,g_text[l_j].yy,g_text[l_j].mm #160824-00004#4 add
                                                INTO l_amt4,l_amt5,l_amt6
                  END IF
               ELSE
                  EXECUTE aglq850_sel_pr2_1 USING g_text[l_j].yy,g_text[l_j].mm
                                                 ,g_text[l_j].yy,g_text[l_j].mm #160824-00004#4 add
                                             INTO l_amt4,l_amt5,l_amt6
               END IF
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq850_sel_pr2_1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_success = FALSE
               END IF 
               
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               LET l_amt1=l_amt1 - l_amt4
               LET l_amt2=l_amt2 - l_amt5
               LET l_amt3=l_amt3 - l_amt6
            END IF
            #151204-00013#8--add--end
         END IF
         #餘額方向，當glac008=1在借方時，餘額=借-貸；當glac008=2在貸方，餘額=貸-借
         IF l_glac008='2' THEN
            LET l_amt1=(-1)*l_amt1
            LET l_amt2=(-1)*l_amt2
            LET l_amt3=(-1)*l_amt3
         END IF
         CASE l_j
            WHEN 1   LET g_detail[l_i].amt1 = l_amt1
                     LET g_detail2[l_i].amt101 = l_amt2
                     LET g_detail3[l_i].amt201 = l_amt3                     
            WHEN 2   LET g_detail[l_i].amt2 = l_amt1
                     LET g_detail2[l_i].amt102 = l_amt2
                     LET g_detail3[l_i].amt202 = l_amt3                     
            WHEN 3   LET g_detail[l_i].amt3 = l_amt1
                     LET g_detail2[l_i].amt103 = l_amt2
                     LET g_detail3[l_i].amt203 = l_amt3                     
            WHEN 4   LET g_detail[l_i].amt4 = l_amt1  
                     LET g_detail2[l_i].amt104 = l_amt2
                     LET g_detail3[l_i].amt204 = l_amt3                     
            WHEN 5   LET g_detail[l_i].amt5 = l_amt1
                     LET g_detail2[l_i].amt105 = l_amt2
                     LET g_detail3[l_i].amt205 = l_amt3                     
            WHEN 6   LET g_detail[l_i].amt6 = l_amt1
                     LET g_detail2[l_i].amt106 = l_amt2
                     LET g_detail3[l_i].amt206 = l_amt3                     
            WHEN 7   LET g_detail[l_i].amt7 = l_amt1
                     LET g_detail2[l_i].amt107 = l_amt2
                     LET g_detail3[l_i].amt207 = l_amt3                     
            WHEN 8   LET g_detail[l_i].amt8 = l_amt1
                     LET g_detail2[l_i].amt108 = l_amt2
                     LET g_detail3[l_i].amt208 = l_amt3                     
            WHEN 9   LET g_detail[l_i].amt9 = l_amt1
                     LET g_detail2[l_i].amt109 = l_amt2
                     LET g_detail3[l_i].amt209 = l_amt3
            WHEN 10  LET g_detail[l_i].amt10 = l_amt1 
                     LET g_detail2[l_i].amt110 = l_amt2
                     LET g_detail3[l_i].amt210 = l_amt3                     
            WHEN 11  LET g_detail[l_i].amt11 = l_amt1
                     LET g_detail2[l_i].amt111 = l_amt2
                     LET g_detail3[l_i].amt211 = l_amt3                     
            WHEN 12  LET g_detail[l_i].amt12 = l_amt1
                     LET g_detail2[l_i].amt112 = l_amt2
                     LET g_detail3[l_i].amt212 = l_amt3                     
            WHEN 13  LET g_detail[l_i].amt13 = l_amt1
                     LET g_detail2[l_i].amt113 = l_amt2
                     LET g_detail3[l_i].amt213 = l_amt3                     
            WHEN 14  LET g_detail[l_i].amt14 = l_amt1
                     LET g_detail2[l_i].amt114 = l_amt2
                     LET g_detail3[l_i].amt214 = l_amt3            
            WHEN 15  LET g_detail[l_i].amt15 = l_amt1
                     LET g_detail2[l_i].amt115 = l_amt2
                     LET g_detail3[l_i].amt215 = l_amt3                     
            WHEN 16  LET g_detail[l_i].amt16 = l_amt1 
                     LET g_detail2[l_i].amt116 = l_amt2
                     LET g_detail3[l_i].amt216 = l_amt3                     
            WHEN 17  LET g_detail[l_i].amt17 = l_amt1
                     LET g_detail2[l_i].amt117 = l_amt2
                     LET g_detail3[l_i].amt217 = l_amt3                     
            WHEN 18  LET g_detail[l_i].amt18 = l_amt1     
                     LET g_detail2[l_i].amt118 = l_amt2
                     LET g_detail3[l_i].amt218 = l_amt3                     
            WHEN 19  LET g_detail[l_i].amt19 = l_amt1
                     LET g_detail2[l_i].amt119 = l_amt2
                     LET g_detail3[l_i].amt219 = l_amt3                     
            WHEN 20  LET g_detail[l_i].amt20 = l_amt1
                     LET g_detail2[l_i].amt120 = l_amt2
                     LET g_detail3[l_i].amt220 = l_amt3                     
            WHEN 21  LET g_detail[l_i].amt21 = l_amt1
                     LET g_detail2[l_i].amt121 = l_amt2
                     LET g_detail3[l_i].amt221 = l_amt3
            WHEN 22  LET g_detail[l_i].amt22 = l_amt1 
                     LET g_detail2[l_i].amt122 = l_amt2
                     LET g_detail3[l_i].amt222 = l_amt3
            WHEN 23  LET g_detail[l_i].amt23 = l_amt1
                     LET g_detail2[l_i].amt123 = l_amt2
                     LET g_detail3[l_i].amt223 = l_amt3                     
            WHEN 24  LET g_detail[l_i].amt24 = l_amt1
                     LET g_detail2[l_i].amt124 = l_amt2
                     LET g_detail3[l_i].amt224 = l_amt3                     
            WHEN 25  LET g_detail[l_i].amt25 = l_amt1
                     LET g_detail2[l_i].amt125 = l_amt2
                     LET g_detail3[l_i].amt225 = l_amt3
            WHEN 26  LET g_detail[l_i].amt26 = l_amt1
                     LET g_detail2[l_i].amt126 = l_amt2
                     LET g_detail3[l_i].amt226 = l_amt3
            WHEN 27  LET g_detail[l_i].amt27 = l_amt1
                     LET g_detail2[l_i].amt127 = l_amt2
                     LET g_detail3[l_i].amt227 = l_amt3
            WHEN 28  LET g_detail[l_i].amt28 = l_amt1
                     LET g_detail2[l_i].amt128 = l_amt2
                     LET g_detail3[l_i].amt228 = l_amt3
            WHEN 29  LET g_detail[l_i].amt29 = l_amt1 
                     LET g_detail2[l_i].amt129 = l_amt2
                     LET g_detail3[l_i].amt229 = l_amt3
            WHEN 30  LET g_detail[l_i].amt30 = l_amt1
                     LET g_detail2[l_i].amt130 = l_amt2
                     LET g_detail3[l_i].amt230 = l_amt3
            WHEN 31  LET g_detail[l_i].amt31 = l_amt1  
                     LET g_detail2[l_i].amt131 = l_amt2
                     LET g_detail3[l_i].amt231 = l_amt3
            WHEN 32  LET g_detail[l_i].amt32 = l_amt1
                     LET g_detail2[l_i].amt132 = l_amt2
                     LET g_detail3[l_i].amt232 = l_amt3
            WHEN 33  LET g_detail[l_i].amt33 = l_amt1
                     LET g_detail2[l_i].amt133 = l_amt2
                     LET g_detail3[l_i].amt233 = l_amt3
            WHEN 34  LET g_detail[l_i].amt34 = l_amt1
                     LET g_detail2[l_i].amt134 = l_amt2
                     LET g_detail3[l_i].amt234 = l_amt3
            WHEN 35  LET g_detail[l_i].amt35 = l_amt1
                     LET g_detail2[l_i].amt135 = l_amt2
                     LET g_detail3[l_i].amt235 = l_amt3
            WHEN 36  LET g_detail[l_i].amt36 = l_amt1
                     LET g_detail2[l_i].amt136 = l_amt2
                     LET g_detail3[l_i].amt236 = l_amt3
            WHEN 37  LET g_detail[l_i].amt37 = l_amt1
                     LET g_detail2[l_i].amt137 = l_amt2
                     LET g_detail3[l_i].amt237 = l_amt3
            WHEN 38  LET g_detail[l_i].amt38 = l_amt1
                     LET g_detail2[l_i].amt138 = l_amt2
                     LET g_detail3[l_i].amt238 = l_amt3
            WHEN 39  LET g_detail[l_i].amt39 = l_amt1
                     LET g_detail2[l_i].amt139 = l_amt2
                     LET g_detail3[l_i].amt239 = l_amt3
            WHEN 40  LET g_detail[l_i].amt40 = l_amt1
                     LET g_detail2[l_i].amt140 = l_amt2
                     LET g_detail3[l_i].amt240 = l_amt3
            WHEN 41  LET g_detail[l_i].amt41 = l_amt1
                     LET g_detail2[l_i].amt141 = l_amt2
                     LET g_detail3[l_i].amt241 = l_amt3
            WHEN 42  LET g_detail[l_i].amt42 = l_amt1
                     LET g_detail2[l_i].amt142 = l_amt2
                     LET g_detail3[l_i].amt242 = l_amt3
            WHEN 43  LET g_detail[l_i].amt43 = l_amt1
                     LET g_detail2[l_i].amt143 = l_amt2
                     LET g_detail3[l_i].amt243 = l_amt3
            WHEN 44  LET g_detail[l_i].amt44 = l_amt1  
                     LET g_detail2[l_i].amt144 = l_amt2
                     LET g_detail3[l_i].amt244 = l_amt3
            WHEN 45  LET g_detail[l_i].amt45 = l_amt1
                     LET g_detail2[l_i].amt145 = l_amt2
                     LET g_detail3[l_i].amt245 = l_amt3
            WHEN 46  LET g_detail[l_i].amt46 = l_amt1
                     LET g_detail2[l_i].amt146 = l_amt2
                     LET g_detail3[l_i].amt246 = l_amt3
            WHEN 47  LET g_detail[l_i].amt47 = l_amt1
                     LET g_detail2[l_i].amt147 = l_amt2
                     LET g_detail3[l_i].amt247 = l_amt3
            WHEN 48  LET g_detail[l_i].amt48 = l_amt1
                     LET g_detail2[l_i].amt148 = l_amt2
                     LET g_detail3[l_i].amt248 = l_amt3
            WHEN 49  LET g_detail[l_i].amt49 = l_amt1
                     LET g_detail2[l_i].amt149 = l_amt2
                     LET g_detail3[l_i].amt249 = l_amt3
            WHEN 50  LET g_detail[l_i].amt50 = l_amt1
                     LET g_detail2[l_i].amt150 = l_amt2
                     LET g_detail3[l_i].amt250 = l_amt3
            WHEN 51  LET g_detail[l_i].amt51 = l_amt1
                     LET g_detail2[l_i].amt151 = l_amt2
                     LET g_detail3[l_i].amt251 = l_amt3
            WHEN 52  LET g_detail[l_i].amt52 = l_amt1
                     LET g_detail2[l_i].amt152 = l_amt2
                     LET g_detail3[l_i].amt252 = l_amt3
            WHEN 53  LET g_detail[l_i].amt53 = l_amt1
                     LET g_detail2[l_i].amt153 = l_amt2
                     LET g_detail3[l_i].amt253 = l_amt3
            WHEN 54  LET g_detail[l_i].amt54 = l_amt1
                     LET g_detail2[l_i].amt154 = l_amt2
                     LET g_detail3[l_i].amt254 = l_amt3
            WHEN 55  LET g_detail[l_i].amt55 = l_amt1
                     LET g_detail2[l_i].amt155 = l_amt2
                     LET g_detail3[l_i].amt255 = l_amt3
            WHEN 56  LET g_detail[l_i].amt56 = l_amt1
                     LET g_detail2[l_i].amt156 = l_amt2
                     LET g_detail3[l_i].amt256 = l_amt3
            WHEN 57  LET g_detail[l_i].amt57 = l_amt1
                     LET g_detail2[l_i].amt157 = l_amt2
                     LET g_detail3[l_i].amt257 = l_amt3
            WHEN 58  LET g_detail[l_i].amt58 = l_amt1
                     LET g_detail2[l_i].amt158 = l_amt2
                     LET g_detail3[l_i].amt258 = l_amt3
            WHEN 59  LET g_detail[l_i].amt59 = l_amt1
                     LET g_detail2[l_i].amt159 = l_amt2
                     LET g_detail3[l_i].amt259 = l_amt3
            WHEN 60  LET g_detail[l_i].amt60 = l_amt1
                     LET g_detail2[l_i].amt160 = l_amt2
                     LET g_detail3[l_i].amt260 = l_amt3
            WHEN 61  LET g_detail[l_i].amt61 = l_amt1
                     LET g_detail2[l_i].amt161 = l_amt2
                     LET g_detail3[l_i].amt261 = l_amt3
            WHEN 62  LET g_detail[l_i].amt62 = l_amt1
                     LET g_detail2[l_i].amt162 = l_amt2
                     LET g_detail3[l_i].amt262 = l_amt3
            WHEN 63  LET g_detail[l_i].amt63 = l_amt1
                     LET g_detail2[l_i].amt163 = l_amt2
                     LET g_detail3[l_i].amt263 = l_amt3
            WHEN 64  LET g_detail[l_i].amt64 = l_amt1  
                     LET g_detail2[l_i].amt164 = l_amt2
                     LET g_detail3[l_i].amt264 = l_amt3
            WHEN 65  LET g_detail[l_i].amt65 = l_amt1
                     LET g_detail2[l_i].amt165 = l_amt2
                     LET g_detail3[l_i].amt265 = l_amt3
            WHEN 66  LET g_detail[l_i].amt66 = l_amt1
                     LET g_detail2[l_i].amt166 = l_amt2
                     LET g_detail3[l_i].amt266 = l_amt3
            WHEN 67  LET g_detail[l_i].amt67 = l_amt1
                     LET g_detail2[l_i].amt167 = l_amt2
                     LET g_detail3[l_i].amt267 = l_amt3
            WHEN 68  LET g_detail[l_i].amt68 = l_amt1
                     LET g_detail2[l_i].amt168 = l_amt2
                     LET g_detail3[l_i].amt268 = l_amt3
            WHEN 69  LET g_detail[l_i].amt69 = l_amt1
                     LET g_detail2[l_i].amt169 = l_amt2
                     LET g_detail3[l_i].amt269 = l_amt3
            WHEN 70  LET g_detail[l_i].amt70 = l_amt1
                     LET g_detail2[l_i].amt170 = l_amt2
                     LET g_detail3[l_i].amt270 = l_amt3
            WHEN 71  LET g_detail[l_i].amt71 = l_amt1
                     LET g_detail2[l_i].amt171 = l_amt2
                     LET g_detail3[l_i].amt271 = l_amt3
            WHEN 72  LET g_detail[l_i].amt72 = l_amt1
                     LET g_detail2[l_i].amt172 = l_amt2
                     LET g_detail3[l_i].amt272 = l_amt3
            WHEN 73  LET g_detail[l_i].amt73 = l_amt1
                     LET g_detail2[l_i].amt173 = l_amt2
                     LET g_detail3[l_i].amt273 = l_amt3
            WHEN 74  LET g_detail[l_i].amt74 = l_amt1
                     LET g_detail2[l_i].amt174 = l_amt2
                     LET g_detail3[l_i].amt274 = l_amt3          
            WHEN 75  LET g_detail[l_i].amt75 = l_amt1
                     LET g_detail2[l_i].amt175 = l_amt2
                     LET g_detail3[l_i].amt275 = l_amt3
            WHEN 76  LET g_detail[l_i].amt76 = l_amt1
                     LET g_detail2[l_i].amt176 = l_amt2
                     LET g_detail3[l_i].amt276 = l_amt3
            WHEN 77  LET g_detail[l_i].amt77 = l_amt1
                     LET g_detail2[l_i].amt177 = l_amt2
                     LET g_detail3[l_i].amt277 = l_amt3
            WHEN 78  LET g_detail[l_i].amt78 = l_amt1
                     LET g_detail2[l_i].amt178 = l_amt2
                     LET g_detail3[l_i].amt278 = l_amt3
            WHEN 79  LET g_detail[l_i].amt79 = l_amt1
                     LET g_detail2[l_i].amt179 = l_amt2
                     LET g_detail3[l_i].amt279 = l_amt3
            WHEN 80  LET g_detail[l_i].amt80 = l_amt1
                     LET g_detail2[l_i].amt180 = l_amt2
                     LET g_detail3[l_i].amt280 = l_amt3
            WHEN 81  LET g_detail[l_i].amt81 = l_amt1
                     LET g_detail2[l_i].amt181 = l_amt2
                     LET g_detail3[l_i].amt281 = l_amt3
            WHEN 82  LET g_detail[l_i].amt82 = l_amt1
                     LET g_detail2[l_i].amt182 = l_amt2
                     LET g_detail3[l_i].amt282 = l_amt3
            WHEN 83  LET g_detail[l_i].amt83 = l_amt1
                     LET g_detail2[l_i].amt183 = l_amt2
                     LET g_detail3[l_i].amt283 = l_amt3
            WHEN 84  LET g_detail[l_i].amt84 = l_amt1 
                     LET g_detail2[l_i].amt184 = l_amt2
                     LET g_detail3[l_i].amt284 = l_amt3
            WHEN 85  LET g_detail[l_i].amt85 = l_amt1
                     LET g_detail2[l_i].amt185 = l_amt2
                     LET g_detail3[l_i].amt285 = l_amt3
            WHEN 86  LET g_detail[l_i].amt86 = l_amt1
                     LET g_detail2[l_i].amt186 = l_amt2
                     LET g_detail3[l_i].amt286 = l_amt3
            WHEN 87  LET g_detail[l_i].amt87 = l_amt1
                     LET g_detail2[l_i].amt187 = l_amt2
                     LET g_detail3[l_i].amt287 = l_amt3
            WHEN 88  LET g_detail[l_i].amt88 = l_amt1
                     LET g_detail2[l_i].amt188 = l_amt2
                     LET g_detail3[l_i].amt288 = l_amt3
            WHEN 89  LET g_detail[l_i].amt89 = l_amt1
                     LET g_detail2[l_i].amt189 = l_amt2
                     LET g_detail3[l_i].amt289 = l_amt3
            WHEN 90  LET g_detail[l_i].amt90 = l_amt1
                     LET g_detail2[l_i].amt190 = l_amt2
                     LET g_detail3[l_i].amt290 = l_amt3
            WHEN 91  LET g_detail[l_i].amt91 = l_amt1
                     LET g_detail2[l_i].amt191 = l_amt2
                     LET g_detail3[l_i].amt291 = l_amt3
            WHEN 92  LET g_detail[l_i].amt92 = l_amt1
                     LET g_detail2[l_i].amt192 = l_amt2
                     LET g_detail3[l_i].amt292 = l_amt3
            WHEN 93  LET g_detail[l_i].amt93 = l_amt1
                     LET g_detail2[l_i].amt193 = l_amt2
                     LET g_detail3[l_i].amt293 = l_amt3
            WHEN 94  LET g_detail[l_i].amt94 = l_amt1
                     LET g_detail2[l_i].amt194 = l_amt2
                     LET g_detail3[l_i].amt294 = l_amt3
            WHEN 95  LET g_detail[l_i].amt95 = l_amt1
                     LET g_detail2[l_i].amt195 = l_amt2
                     LET g_detail3[l_i].amt295 = l_amt3
            WHEN 96  LET g_detail[l_i].amt96 = l_amt1
                     LET g_detail2[l_i].amt196 = l_amt2
                     LET g_detail3[l_i].amt296 = l_amt3
            WHEN 97  LET g_detail[l_i].amt97 = l_amt1
                     LET g_detail2[l_i].amt197 = l_amt2
                     LET g_detail3[l_i].amt297 = l_amt3
            WHEN 98  LET g_detail[l_i].amt98 = l_amt1
                     LET g_detail2[l_i].amt198 = l_amt2
                     LET g_detail3[l_i].amt298 = l_amt3
            WHEN 99  LET g_detail[l_i].amt99 = l_amt1
                     LET g_detail2[l_i].amt199 = l_amt2
                     LET g_detail3[l_i].amt299 = l_amt3
            WHEN 100 LET g_detail[l_i].amt100 = l_amt1
                     LET g_detail2[l_i].amt200 = l_amt2
                     LET g_detail3[l_i].amt300 = l_amt3
         END CASE   
      END FOR
      LET l_i = l_i + 1
   END FOREACH 
   LET g_detail_cnt = g_detail.getLength() 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   
END FUNCTION

################################################################################
# Descriptions...: 列印XG報表
# Memo...........:
# Usage..........: CALL aglq851_xg()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By lujh
# Modify.........: 
################################################################################
PRIVATE FUNCTION aglq851_xg(p_type)
   DEFINE p_type         LIKE type_t.chr10
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_title        LIKE type_t.chr200
   DEFINE lc_fix_desc    STRING

   IF p_type = '1' THEN 
      DELETE FROM aglq851_tmp01              #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
      
      FOR l_i = 1 TO g_detail.getLength()
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_glaa004
         LET g_ref_fields[2] = g_detail[l_i].glaq002
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_detail[l_i].glaq002_desc = '', g_rtn_fields[1] , ''
      
         INSERT INTO aglq851_tmp01(glaq002,glaq002_desc,            #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
                                       amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,
                                       amt11,amt12,amt13,amt14,amt15,amt16,amt17,amt18,amt19,amt20,
                                       amt21,amt22,amt23,amt24,amt25,amt26,amt27,amt28,amt29,amt30,
                                       amt31,amt32,amt33,amt34,amt35,amt36,amt37,amt38,amt39,amt40,
                                       amt41,amt42,amt43,amt44,amt45,amt46,amt47,amt48,amt49,amt50,
                                       amt51,amt52,amt53,amt54,amt55,amt56,amt57,amt58,amt59,amt60,
                                       amt61,amt62,amt63,amt64,amt65,amt66,amt67,amt68,amt69,amt70,
                                       amt71,amt72,amt73,amt74,amt75,amt76,amt77,amt78,amt79,amt80,
                                       amt81,amt82,amt83,amt84,amt85,amt86,amt87,amt88,amt89,amt90,
                                       amt91,amt92,amt93,amt94,amt95,amt96,amt97,amt98,amt99,amt100)
            VALUES(g_detail[l_i].glaq002,g_detail[l_i].glaq002_desc,  
                   g_detail[l_i].amt1,g_detail[l_i].amt2,g_detail[l_i].amt3,g_detail[l_i].amt4,g_detail[l_i].amt5,
                   g_detail[l_i].amt6,g_detail[l_i].amt7,g_detail[l_i].amt8,g_detail[l_i].amt9,g_detail[l_i].amt10,
                   g_detail[l_i].amt11,g_detail[l_i].amt12,g_detail[l_i].amt13,g_detail[l_i].amt14,g_detail[l_i].amt15,
                   g_detail[l_i].amt16,g_detail[l_i].amt17,g_detail[l_i].amt18,g_detail[l_i].amt19,g_detail[l_i].amt20,
                   g_detail[l_i].amt21,g_detail[l_i].amt22,g_detail[l_i].amt23,g_detail[l_i].amt24,g_detail[l_i].amt25,
                   g_detail[l_i].amt26,g_detail[l_i].amt27,g_detail[l_i].amt28,g_detail[l_i].amt29,g_detail[l_i].amt30,
                   g_detail[l_i].amt31,g_detail[l_i].amt32,g_detail[l_i].amt33,g_detail[l_i].amt34,g_detail[l_i].amt35,
                   g_detail[l_i].amt36,g_detail[l_i].amt37,g_detail[l_i].amt38,g_detail[l_i].amt39,g_detail[l_i].amt40,
                   g_detail[l_i].amt41,g_detail[l_i].amt42,g_detail[l_i].amt43,g_detail[l_i].amt44,g_detail[l_i].amt45,
                   g_detail[l_i].amt46,g_detail[l_i].amt47,g_detail[l_i].amt48,g_detail[l_i].amt49,g_detail[l_i].amt50,
                   g_detail[l_i].amt51,g_detail[l_i].amt52,g_detail[l_i].amt53,g_detail[l_i].amt54,g_detail[l_i].amt55,
                   g_detail[l_i].amt56,g_detail[l_i].amt57,g_detail[l_i].amt58,g_detail[l_i].amt59,g_detail[l_i].amt60,
                   g_detail[l_i].amt61,g_detail[l_i].amt62,g_detail[l_i].amt63,g_detail[l_i].amt64,g_detail[l_i].amt65,
                   g_detail[l_i].amt66,g_detail[l_i].amt67,g_detail[l_i].amt68,g_detail[l_i].amt69,g_detail[l_i].amt70,
                   g_detail[l_i].amt71,g_detail[l_i].amt72,g_detail[l_i].amt73,g_detail[l_i].amt74,g_detail[l_i].amt75,
                   g_detail[l_i].amt76,g_detail[l_i].amt77,g_detail[l_i].amt78,g_detail[l_i].amt79,g_detail[l_i].amt80,
                   g_detail[l_i].amt81,g_detail[l_i].amt82,g_detail[l_i].amt83,g_detail[l_i].amt84,g_detail[l_i].amt85,
                   g_detail[l_i].amt86,g_detail[l_i].amt87,g_detail[l_i].amt88,g_detail[l_i].amt89,g_detail[l_i].amt90,
                   g_detail[l_i].amt91,g_detail[l_i].amt92,g_detail[l_i].amt93,g_detail[l_i].amt94,g_detail[l_i].amt95,
                   g_detail[l_i].amt96,g_detail[l_i].amt97,g_detail[l_i].amt98,g_detail[l_i].amt99,g_detail[l_i].amt100)
      END FOR
   END IF
   
   IF p_type = '2' THEN 
      DELETE FROM aglq851_tmp01          #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
      
      FOR l_i = 1 TO g_detail2.getLength()
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_glaa004
         LET g_ref_fields[2] = g_detail2[l_i].glaq002
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_detail2[l_i].glaq002_2_desc = '', g_rtn_fields[1] , ''
      
         INSERT INTO aglq851_tmp01(glaq002,glaq002_desc,            #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
                                       amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,
                                       amt11,amt12,amt13,amt14,amt15,amt16,amt17,amt18,amt19,amt20,
                                       amt21,amt22,amt23,amt24,amt25,amt26,amt27,amt28,amt29,amt30,
                                       amt31,amt32,amt33,amt34,amt35,amt36,amt37,amt38,amt39,amt40,
                                       amt41,amt42,amt43,amt44,amt45,amt46,amt47,amt48,amt49,amt50,
                                       amt51,amt52,amt53,amt54,amt55,amt56,amt57,amt58,amt59,amt60,
                                       amt61,amt62,amt63,amt64,amt65,amt66,amt67,amt68,amt69,amt70,
                                       amt71,amt72,amt73,amt74,amt75,amt76,amt77,amt78,amt79,amt80,
                                       amt81,amt82,amt83,amt84,amt85,amt86,amt87,amt88,amt89,amt90,
                                       amt91,amt92,amt93,amt94,amt95,amt96,amt97,amt98,amt99,amt100)
            VALUES(g_detail2[l_i].glaq002,g_detail2[l_i].glaq002_2_desc,  
                   g_detail2[l_i].amt101,g_detail2[l_i].amt102,g_detail2[l_i].amt103,g_detail2[l_i].amt104,g_detail2[l_i].amt105,
                   g_detail2[l_i].amt106,g_detail2[l_i].amt107,g_detail2[l_i].amt108,g_detail2[l_i].amt109,g_detail2[l_i].amt110,
                   g_detail2[l_i].amt111,g_detail2[l_i].amt112,g_detail2[l_i].amt113,g_detail2[l_i].amt114,g_detail2[l_i].amt115,
                   g_detail2[l_i].amt116,g_detail2[l_i].amt117,g_detail2[l_i].amt118,g_detail2[l_i].amt119,g_detail2[l_i].amt120,
                   g_detail2[l_i].amt121,g_detail2[l_i].amt122,g_detail2[l_i].amt123,g_detail2[l_i].amt124,g_detail2[l_i].amt125,
                   g_detail2[l_i].amt126,g_detail2[l_i].amt127,g_detail2[l_i].amt128,g_detail2[l_i].amt129,g_detail2[l_i].amt130,
                   g_detail2[l_i].amt131,g_detail2[l_i].amt132,g_detail2[l_i].amt133,g_detail2[l_i].amt134,g_detail2[l_i].amt135,
                   g_detail2[l_i].amt136,g_detail2[l_i].amt137,g_detail2[l_i].amt138,g_detail2[l_i].amt139,g_detail2[l_i].amt140,
                   g_detail2[l_i].amt141,g_detail2[l_i].amt142,g_detail2[l_i].amt143,g_detail2[l_i].amt144,g_detail2[l_i].amt145,
                   g_detail2[l_i].amt146,g_detail2[l_i].amt147,g_detail2[l_i].amt148,g_detail2[l_i].amt149,g_detail2[l_i].amt150,
                   g_detail2[l_i].amt151,g_detail2[l_i].amt152,g_detail2[l_i].amt153,g_detail2[l_i].amt154,g_detail2[l_i].amt155,
                   g_detail2[l_i].amt156,g_detail2[l_i].amt157,g_detail2[l_i].amt158,g_detail2[l_i].amt159,g_detail2[l_i].amt160,
                   g_detail2[l_i].amt161,g_detail2[l_i].amt162,g_detail2[l_i].amt163,g_detail2[l_i].amt164,g_detail2[l_i].amt165,
                   g_detail2[l_i].amt166,g_detail2[l_i].amt167,g_detail2[l_i].amt168,g_detail2[l_i].amt169,g_detail2[l_i].amt170,
                   g_detail2[l_i].amt171,g_detail2[l_i].amt172,g_detail2[l_i].amt173,g_detail2[l_i].amt174,g_detail2[l_i].amt175,
                   g_detail2[l_i].amt176,g_detail2[l_i].amt177,g_detail2[l_i].amt178,g_detail2[l_i].amt179,g_detail2[l_i].amt180,
                   g_detail2[l_i].amt181,g_detail2[l_i].amt182,g_detail2[l_i].amt183,g_detail2[l_i].amt184,g_detail2[l_i].amt185,
                   g_detail2[l_i].amt186,g_detail2[l_i].amt187,g_detail2[l_i].amt188,g_detail2[l_i].amt189,g_detail2[l_i].amt190,
                   g_detail2[l_i].amt191,g_detail2[l_i].amt192,g_detail2[l_i].amt193,g_detail2[l_i].amt194,g_detail2[l_i].amt195,
                   g_detail2[l_i].amt196,g_detail2[l_i].amt197,g_detail2[l_i].amt198,g_detail2[l_i].amt199,g_detail2[l_i].amt200)
      END FOR
   END IF
   
   IF p_type = '3' THEN 
      DELETE FROM aglq851_tmp01           #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
      
      FOR l_i = 1 TO g_detail3.getLength()
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_glaa004
         LET g_ref_fields[2] = g_detail3[l_i].glaq002
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_detail3[l_i].glaq002_3_desc = '', g_rtn_fields[1] , ''
      
         INSERT INTO aglq851_tmp01(glaq002,glaq002_desc,       #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
                                       amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,
                                       amt11,amt12,amt13,amt14,amt15,amt16,amt17,amt18,amt19,amt20,
                                       amt21,amt22,amt23,amt24,amt25,amt26,amt27,amt28,amt29,amt30,
                                       amt31,amt32,amt33,amt34,amt35,amt36,amt37,amt38,amt39,amt40,
                                       amt41,amt42,amt43,amt44,amt45,amt46,amt47,amt48,amt49,amt50,
                                       amt51,amt52,amt53,amt54,amt55,amt56,amt57,amt58,amt59,amt60,
                                       amt61,amt62,amt63,amt64,amt65,amt66,amt67,amt68,amt69,amt70,
                                       amt71,amt72,amt73,amt74,amt75,amt76,amt77,amt78,amt79,amt80,
                                       amt81,amt82,amt83,amt84,amt85,amt86,amt87,amt88,amt89,amt90,
                                       amt91,amt92,amt93,amt94,amt95,amt96,amt97,amt98,amt99,amt100)
            VALUES(g_detail3[l_i].glaq002,g_detail3[l_i].glaq002_3_desc,  
                   g_detail3[l_i].amt201,g_detail3[l_i].amt202,g_detail3[l_i].amt203,g_detail3[l_i].amt204,g_detail3[l_i].amt205,
                   g_detail3[l_i].amt206,g_detail3[l_i].amt207,g_detail3[l_i].amt208,g_detail3[l_i].amt209,g_detail3[l_i].amt210,
                   g_detail3[l_i].amt211,g_detail3[l_i].amt212,g_detail3[l_i].amt213,g_detail3[l_i].amt214,g_detail3[l_i].amt215,
                   g_detail3[l_i].amt216,g_detail3[l_i].amt217,g_detail3[l_i].amt218,g_detail3[l_i].amt219,g_detail3[l_i].amt220,
                   g_detail3[l_i].amt221,g_detail3[l_i].amt222,g_detail3[l_i].amt223,g_detail3[l_i].amt224,g_detail3[l_i].amt225,
                   g_detail3[l_i].amt226,g_detail3[l_i].amt227,g_detail3[l_i].amt228,g_detail3[l_i].amt229,g_detail3[l_i].amt230,
                   g_detail3[l_i].amt231,g_detail3[l_i].amt232,g_detail3[l_i].amt233,g_detail3[l_i].amt234,g_detail3[l_i].amt235,
                   g_detail3[l_i].amt236,g_detail3[l_i].amt237,g_detail3[l_i].amt238,g_detail3[l_i].amt239,g_detail3[l_i].amt240,
                   g_detail3[l_i].amt241,g_detail3[l_i].amt242,g_detail3[l_i].amt243,g_detail3[l_i].amt244,g_detail3[l_i].amt245,
                   g_detail3[l_i].amt246,g_detail3[l_i].amt247,g_detail3[l_i].amt248,g_detail3[l_i].amt249,g_detail3[l_i].amt250,
                   g_detail3[l_i].amt251,g_detail3[l_i].amt252,g_detail3[l_i].amt253,g_detail3[l_i].amt254,g_detail3[l_i].amt255,
                   g_detail3[l_i].amt256,g_detail3[l_i].amt257,g_detail3[l_i].amt258,g_detail3[l_i].amt259,g_detail3[l_i].amt260,
                   g_detail3[l_i].amt261,g_detail3[l_i].amt262,g_detail3[l_i].amt263,g_detail3[l_i].amt264,g_detail3[l_i].amt265,
                   g_detail3[l_i].amt266,g_detail3[l_i].amt267,g_detail3[l_i].amt268,g_detail3[l_i].amt269,g_detail3[l_i].amt270,
                   g_detail3[l_i].amt271,g_detail3[l_i].amt272,g_detail3[l_i].amt273,g_detail3[l_i].amt274,g_detail3[l_i].amt275,
                   g_detail3[l_i].amt276,g_detail3[l_i].amt277,g_detail3[l_i].amt278,g_detail3[l_i].amt279,g_detail3[l_i].amt280,
                   g_detail3[l_i].amt281,g_detail3[l_i].amt282,g_detail3[l_i].amt283,g_detail3[l_i].amt284,g_detail3[l_i].amt285,
                   g_detail3[l_i].amt286,g_detail3[l_i].amt287,g_detail3[l_i].amt288,g_detail3[l_i].amt289,g_detail3[l_i].amt290,
                   g_detail3[l_i].amt291,g_detail3[l_i].amt292,g_detail3[l_i].amt293,g_detail3[l_i].amt294,g_detail3[l_i].amt295,
                   g_detail3[l_i].amt296,g_detail3[l_i].amt297,g_detail3[l_i].amt298,g_detail3[l_i].amt299,g_detail3[l_i].amt300)
      END FOR
   END IF

   FOR l_i = 1 TO g_text.getLength()
     #列說明格式‘2015年03期’
     LET l_title = g_text[l_i].yy USING "&&&&",cl_getmsg("agl-00274",g_dlang),
                   g_text[l_i].mm USING '&&',cl_getmsg("axc-00589",g_dlang)
                   
     #按照核算項匯總金額
     IF NOT cl_null(tm.fix_type) THEN  #帳套+核算项
        CASE tm.fix_type
           WHEN '1' #營運據點
              CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '2' #部門
              CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '3' #利潤成本中心
              CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '4' #區域
              CALL s_desc_get_acc_desc('287',g_text[l_i].fix) RETURNING lc_fix_desc 
           WHEN '5' #交易客商
              CALL s_desc_get_trading_partner_abbr_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '6' #帳款客戶
              CALL s_desc_get_trading_partner_abbr_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '7' #客群
              CALL s_desc_get_acc_desc('281',g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '8' #產品分類
              CALL s_desc_get_rtaxl003_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '9' #经营方式
              CALL s_desc_gzcbl004_desc('6013',g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '10' #渠道
              CALL s_desc_get_oojdl003_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '11' #品牌
              CALL s_desc_get_acc_desc('2002',g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '12' #人員
              CALL s_desc_get_person_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '13' #专案
              CALL s_desc_get_project_desc(g_text[l_i].fix) RETURNING lc_fix_desc
           WHEN '14' #WBS
              #CALL s_desc_get_wbs_desc('',g_text[l_i].fix) RETURNING lc_fix_desc
              LET lc_fix_desc = g_text[l_i].fix
        END CASE
        IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
           tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
           CALL s_voucher_free_account_desc(g_text[l_i].glad0171,g_text[l_i].fix) 
           RETURNING lc_fix_desc
        END IF
        #核算項編號+說明
        IF cl_null(lc_fix_desc) THEN
           LET lc_fix_desc=g_text[l_i].fix
        ELSE
           LET lc_fix_desc="(",g_text[l_i].fix,")",lc_fix_desc
        END IF
        IF tm.syear=tm.eyear THEN
           #列說明格式‘03期(SY)事业部’
           LET l_title = g_text[l_i].mm USING '&&',cl_getmsg("axc-00589",g_dlang),lc_fix_desc
        ELSE
           #列說明格式‘2015年03期(SY)事业部’
           LET l_title = g_text[l_i].yy USING "&&&&",cl_getmsg("agl-00274",g_dlang),
                         g_text[l_i].mm USING '&&',cl_getmsg("axc-00589",g_dlang),lc_fix_desc
        END IF
     END IF 
     
     LET g_xg_fieldname[2 + l_i] = l_title
   END FOR

   CALL aglq851_x01('1=1','aglq851_tmp01',l_i,p_type)  #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01

END FUNCTION

################################################################################
# Descriptions...: 為XG報表建立臨時表
# Memo...........:
# Usage..........: CALL aglq851_create_for_xg()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By lujh
# Modify.........: 
################################################################################
PRIVATE FUNCTION aglq851_create_for_xg()
   DROP TABLE aglq851_tmp01;                   #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
      CREATE TEMP TABLE aglq851_tmp01(        #160727-00019#3  Mod  aglq851_print_tmp -->aglq851_tmp01
            glaq002  VARCHAR(24), 
            glaq002_desc  VARCHAR(500), 
            amt1  DECIMAL(20,6), 
            amt2  DECIMAL(20,6), 
            amt3  DECIMAL(20,6), 
            amt4  DECIMAL(20,6), 
            amt5  DECIMAL(20,6), 
            amt6  DECIMAL(20,6), 
            amt7  DECIMAL(20,6), 
            amt8  DECIMAL(20,6), 
            amt9  DECIMAL(20,6), 
            amt10  DECIMAL(20,6), 
            amt11  DECIMAL(20,6), 
            amt12  DECIMAL(20,6), 
            amt13  DECIMAL(20,6), 
            amt14  DECIMAL(20,6), 
            amt15  DECIMAL(20,6), 
            amt16  DECIMAL(20,6), 
            amt17  DECIMAL(20,6), 
            amt18  DECIMAL(20,6), 
            amt19  DECIMAL(20,6), 
            amt20  DECIMAL(20,6), 
            amt21  DECIMAL(20,6), 
            amt22  DECIMAL(20,6), 
            amt23  DECIMAL(20,6), 
            amt24  DECIMAL(20,6), 
            amt25  DECIMAL(20,6), 
            amt26  DECIMAL(20,6), 
            amt27  DECIMAL(20,6), 
            amt28  DECIMAL(20,6), 
            amt29  DECIMAL(20,6), 
            amt30  DECIMAL(20,6), 
            amt31  DECIMAL(20,6), 
            amt32  DECIMAL(20,6), 
            amt33  DECIMAL(20,6), 
            amt34  DECIMAL(20,6), 
            amt35  DECIMAL(20,6), 
            amt36  DECIMAL(20,6), 
            amt37  DECIMAL(20,6), 
            amt38  DECIMAL(20,6), 
            amt39  DECIMAL(20,6), 
            amt40  DECIMAL(20,6), 
            amt41  DECIMAL(20,6), 
            amt42  DECIMAL(20,6), 
            amt43  DECIMAL(20,6), 
            amt44  DECIMAL(20,6), 
            amt45  DECIMAL(20,6), 
            amt46  DECIMAL(20,6), 
            amt47  DECIMAL(20,6), 
            amt48  DECIMAL(20,6), 
            amt49  DECIMAL(20,6), 
            amt50  DECIMAL(20,6), 
            amt51  DECIMAL(20,6), 
            amt52  DECIMAL(20,6), 
            amt53  DECIMAL(20,6), 
            amt54  DECIMAL(20,6), 
            amt55  DECIMAL(20,6), 
            amt56  DECIMAL(20,6), 
            amt57  DECIMAL(20,6), 
            amt58  DECIMAL(20,6), 
            amt59  DECIMAL(20,6), 
            amt60  DECIMAL(20,6), 
            amt61  DECIMAL(20,6), 
            amt62  DECIMAL(20,6), 
            amt63  DECIMAL(20,6), 
            amt64  DECIMAL(20,6), 
            amt65  DECIMAL(20,6), 
            amt66  DECIMAL(20,6), 
            amt67  DECIMAL(20,6), 
            amt68  DECIMAL(20,6), 
            amt69  DECIMAL(20,6), 
            amt70  DECIMAL(20,6), 
            amt71  DECIMAL(20,6), 
            amt72  DECIMAL(20,6), 
            amt73  DECIMAL(20,6), 
            amt74  DECIMAL(20,6), 
            amt75  DECIMAL(20,6), 
            amt76  DECIMAL(20,6), 
            amt77  DECIMAL(20,6), 
            amt78  DECIMAL(20,6), 
            amt79  DECIMAL(20,6), 
            amt80  DECIMAL(20,6), 
            amt81  DECIMAL(20,6), 
            amt82  DECIMAL(20,6), 
            amt83  DECIMAL(20,6), 
            amt84  DECIMAL(20,6), 
            amt85  DECIMAL(20,6), 
            amt86  DECIMAL(20,6), 
            amt87  DECIMAL(20,6), 
            amt88  DECIMAL(20,6), 
            amt89  DECIMAL(20,6), 
            amt90  DECIMAL(20,6), 
            amt91  DECIMAL(20,6), 
            amt92  DECIMAL(20,6), 
            amt93  DECIMAL(20,6), 
            amt94  DECIMAL(20,6), 
            amt95  DECIMAL(20,6), 
            amt96  DECIMAL(20,6), 
            amt97  DECIMAL(20,6), 
            amt98  DECIMAL(20,6), 
            amt99  DECIMAL(20,6), 
            amt100  DECIMAL(20,6)
          )
        
END FUNCTION

 
{</section>}
 
