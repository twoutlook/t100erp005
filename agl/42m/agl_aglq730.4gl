#該程式已解開Section, 不再透過樣板產出!
{<section id="aglq730.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000062
#+ 
#+ Filename...: aglq730
#+ Description: 科目核算項二維查詢作業
#+ Creator....: 02599(2014/03/23)
#+ Modifier...: 02599(2014/03/26)
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aglq730.global" >}
#130726-00001#95   2015/06/02 增加列印功能
#151204-00013#3    2016/01/12   By 02599   当未勾选‘含月结凭证’是，要排除CE凭证中科目属性为6.损益类科目和XC凭证中科目属性为5.成本类科目
#150827-00036#15   2016/02/22   By 02599   最右增加一列合计金额,为本行前面所有列金额合计;最后一行增加合计,为本列金额合计
#160302-00006#1    2016/03/02   By 07675   原本单身为可查询作业，增加二次筛选功能 
#160505-00007#15   2016/06/03   By 01531   效能优化
#160711-00030#1    2016/07/11   By 02599   BUG修改，b_fill1段SQL语句错误，在栏位说明后面缺少逗号
#160727-00019#3  2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aglq730_print_tmp -->aglq730_tmp01
#160824-00004#2  2016/08/31  By 02599  排除XC凭证时限定科目费用类别glac010<>N.非费用科目
#160912-00013#1  2016/09/12  By 02599  '余额型态'下拉框只显示'1.发生额'和'2.累计余额'
#160824-00004#4  2016/09/23  By 02599  排除XC类凭证时，继续增加条件：来源单据的成本凭证类型(xcea002)<>(7 OR 9)
#161027-00022#1  2016/10/27  By 02599  含月结凭证=N时，在排除XC凭证时，增加条件：来源成本单据的成本类型(xrea002)=9 and 科目对应的费用类别(glac010)=费用类型。
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS "../../cfg/top_report.inc"   #130726-00001#95 Add
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glar_d RECORD
       #statepic       LIKE type_t.chr1,
       sel            LIKE type_t.chr1,
       glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   amt11 LIKE glaq_t.glaq003, 
   amt12 LIKE glaq_t.glaq003, 
   amt13 LIKE glaq_t.glaq003, 
   amt21 LIKE glaq_t.glaq003, 
   amt22 LIKE glaq_t.glaq003, 
   amt23 LIKE glaq_t.glaq003, 
   amt31 LIKE glaq_t.glaq003, 
   amt32 LIKE glaq_t.glaq003, 
   amt33 LIKE glaq_t.glaq003, 
   amt41 LIKE glaq_t.glaq003, 
   amt42 LIKE glaq_t.glaq003, 
   amt43 LIKE glaq_t.glaq003, 
   amt51 LIKE glaq_t.glaq003, 
   amt52 LIKE glaq_t.glaq003, 
   amt53 LIKE glaq_t.glaq003, 
   amt61 LIKE glaq_t.glaq003, 
   amt62 LIKE glaq_t.glaq003, 
   amt63 LIKE glaq_t.glaq003, 
   amt71 LIKE glaq_t.glaq003, 
   amt72 LIKE glaq_t.glaq003, 
   amt73 LIKE glaq_t.glaq003, 
   amt81 LIKE glaq_t.glaq003, 
   amt82 LIKE glaq_t.glaq003, 
   amt83 LIKE glaq_t.glaq003, 
   amt91 LIKE glaq_t.glaq003, 
   amt92 LIKE glaq_t.glaq003, 
   amt93 LIKE glaq_t.glaq003, 
   amt101 LIKE glaq_t.glaq003, 
   amt102 LIKE glaq_t.glaq003, 
   amt103 LIKE glaq_t.glaq003, 
   amt111 LIKE glaq_t.glaq003, 
   amt112 LIKE glaq_t.glaq003, 
   amt113 LIKE glaq_t.glaq003, 
   amt121 LIKE glaq_t.glaq003, 
   amt122 LIKE glaq_t.glaq003, 
   amt123 LIKE glaq_t.glaq003, 
   amt131 LIKE glaq_t.glaq003, 
   amt132 LIKE glaq_t.glaq003, 
   amt133 LIKE glaq_t.glaq003, 
   amt141 LIKE glaq_t.glaq003, 
   amt142 LIKE glaq_t.glaq003, 
   amt143 LIKE glaq_t.glaq003, 
   amt151 LIKE glaq_t.glaq003, 
   amt152 LIKE glaq_t.glaq003, 
   amt153 LIKE glaq_t.glaq003, 
   amt161 LIKE glaq_t.glaq003, 
   amt162 LIKE glaq_t.glaq003, 
   amt163 LIKE glaq_t.glaq003, 
   amt171 LIKE glaq_t.glaq003, 
   amt172 LIKE glaq_t.glaq003, 
   amt173 LIKE glaq_t.glaq003, 
   amt181 LIKE glaq_t.glaq003, 
   amt182 LIKE glaq_t.glaq003, 
   amt183 LIKE glaq_t.glaq003, 
   amt191 LIKE glaq_t.glaq003, 
   amt192 LIKE glaq_t.glaq003, 
   amt193 LIKE glaq_t.glaq003, 
   amt201 LIKE glaq_t.glaq003, 
   amt202 LIKE glaq_t.glaq003, 
   amt203 LIKE glaq_t.glaq003, 
   amt211 LIKE glaq_t.glaq003, 
   amt212 LIKE glaq_t.glaq003, 
   amt213 LIKE glaq_t.glaq003, 
   amt221 LIKE glaq_t.glaq003, 
   amt222 LIKE glaq_t.glaq003, 
   amt223 LIKE glaq_t.glaq003, 
   amt231 LIKE glaq_t.glaq003, 
   amt232 LIKE glaq_t.glaq003, 
   amt233 LIKE glaq_t.glaq003, 
   amt241 LIKE glaq_t.glaq003, 
   amt242 LIKE glaq_t.glaq003, 
   amt243 LIKE glaq_t.glaq003, 
   amt251 LIKE glaq_t.glaq003, 
   amt252 LIKE glaq_t.glaq003, 
   amt253 LIKE glaq_t.glaq003, 
   amt261 LIKE glaq_t.glaq003, 
   amt262 LIKE glaq_t.glaq003, 
   amt263 LIKE glaq_t.glaq003, 
   amt271 LIKE glaq_t.glaq003, 
   amt272 LIKE glaq_t.glaq003, 
   amt273 LIKE glaq_t.glaq003, 
   amt281 LIKE glaq_t.glaq003, 
   amt282 LIKE glaq_t.glaq003, 
   amt283 LIKE glaq_t.glaq003, 
   amt291 LIKE glaq_t.glaq003, 
   amt292 LIKE glaq_t.glaq003, 
   amt293 LIKE glaq_t.glaq003, 
   amt301 LIKE glaq_t.glaq003, 
   amt302 LIKE glaq_t.glaq003, 
   amt303 LIKE glaq_t.glaq003,
   amt311 LIKE glaq_t.glaq003, 
   amt312 LIKE glaq_t.glaq003, 
   amt313 LIKE glaq_t.glaq003, 
   amt321 LIKE glaq_t.glaq003, 
   amt322 LIKE glaq_t.glaq003, 
   amt323 LIKE glaq_t.glaq003, 
   amt331 LIKE glaq_t.glaq003, 
   amt332 LIKE glaq_t.glaq003, 
   amt333 LIKE glaq_t.glaq003, 
   amt341 LIKE glaq_t.glaq003, 
   amt342 LIKE glaq_t.glaq003, 
   amt343 LIKE glaq_t.glaq003, 
   amt351 LIKE glaq_t.glaq003, 
   amt352 LIKE glaq_t.glaq003, 
   amt353 LIKE glaq_t.glaq003, 
   amt361 LIKE glaq_t.glaq003, 
   amt362 LIKE glaq_t.glaq003, 
   amt363 LIKE glaq_t.glaq003, 
   amt371 LIKE glaq_t.glaq003, 
   amt372 LIKE glaq_t.glaq003, 
   amt373 LIKE glaq_t.glaq003, 
   amt381 LIKE glaq_t.glaq003, 
   amt382 LIKE glaq_t.glaq003, 
   amt383 LIKE glaq_t.glaq003, 
   amt391 LIKE glaq_t.glaq003, 
   amt392 LIKE glaq_t.glaq003, 
   amt393 LIKE glaq_t.glaq003,
   amt401 LIKE glaq_t.glaq003, 
   amt402 LIKE glaq_t.glaq003, 
   amt403 LIKE glaq_t.glaq003,
   amt411 LIKE glaq_t.glaq003, 
   amt412 LIKE glaq_t.glaq003, 
   amt413 LIKE glaq_t.glaq003, 
   amt421 LIKE glaq_t.glaq003, 
   amt422 LIKE glaq_t.glaq003, 
   amt423 LIKE glaq_t.glaq003, 
   amt431 LIKE glaq_t.glaq003, 
   amt432 LIKE glaq_t.glaq003, 
   amt433 LIKE glaq_t.glaq003, 
   amt441 LIKE glaq_t.glaq003, 
   amt442 LIKE glaq_t.glaq003, 
   amt443 LIKE glaq_t.glaq003, 
   amt451 LIKE glaq_t.glaq003, 
   amt452 LIKE glaq_t.glaq003, 
   amt453 LIKE glaq_t.glaq003, 
   amt461 LIKE glaq_t.glaq003, 
   amt462 LIKE glaq_t.glaq003, 
   amt463 LIKE glaq_t.glaq003, 
   amt471 LIKE glaq_t.glaq003, 
   amt472 LIKE glaq_t.glaq003, 
   amt473 LIKE glaq_t.glaq003, 
   amt481 LIKE glaq_t.glaq003, 
   amt482 LIKE glaq_t.glaq003, 
   amt483 LIKE glaq_t.glaq003, 
   amt491 LIKE glaq_t.glaq003, 
   amt492 LIKE glaq_t.glaq003, 
   amt493 LIKE glaq_t.glaq003,
   amt501 LIKE glaq_t.glaq003, 
   amt502 LIKE glaq_t.glaq003, 
   amt503 LIKE glaq_t.glaq003,
   amt511 LIKE glaq_t.glaq003, 
   amt512 LIKE glaq_t.glaq003, 
   amt513 LIKE glaq_t.glaq003, 
   amt521 LIKE glaq_t.glaq003, 
   amt522 LIKE glaq_t.glaq003, 
   amt523 LIKE glaq_t.glaq003, 
   amt531 LIKE glaq_t.glaq003, 
   amt532 LIKE glaq_t.glaq003, 
   amt533 LIKE glaq_t.glaq003, 
   amt541 LIKE glaq_t.glaq003, 
   amt542 LIKE glaq_t.glaq003, 
   amt543 LIKE glaq_t.glaq003, 
   amt551 LIKE glaq_t.glaq003, 
   amt552 LIKE glaq_t.glaq003, 
   amt553 LIKE glaq_t.glaq003, 
   amt561 LIKE glaq_t.glaq003, 
   amt562 LIKE glaq_t.glaq003, 
   amt563 LIKE glaq_t.glaq003, 
   amt571 LIKE glaq_t.glaq003, 
   amt572 LIKE glaq_t.glaq003, 
   amt573 LIKE glaq_t.glaq003, 
   amt581 LIKE glaq_t.glaq003, 
   amt582 LIKE glaq_t.glaq003, 
   amt583 LIKE glaq_t.glaq003, 
   amt591 LIKE glaq_t.glaq003, 
   amt592 LIKE glaq_t.glaq003, 
   amt593 LIKE glaq_t.glaq003,
   amt601 LIKE glaq_t.glaq003, 
   amt602 LIKE glaq_t.glaq003, 
   amt603 LIKE glaq_t.glaq003,
   amt611 LIKE glaq_t.glaq003, 
   amt612 LIKE glaq_t.glaq003, 
   amt613 LIKE glaq_t.glaq003, 
   amt621 LIKE glaq_t.glaq003, 
   amt622 LIKE glaq_t.glaq003, 
   amt623 LIKE glaq_t.glaq003, 
   amt631 LIKE glaq_t.glaq003, 
   amt632 LIKE glaq_t.glaq003, 
   amt633 LIKE glaq_t.glaq003, 
   amt641 LIKE glaq_t.glaq003, 
   amt642 LIKE glaq_t.glaq003, 
   amt643 LIKE glaq_t.glaq003, 
   amt651 LIKE glaq_t.glaq003, 
   amt652 LIKE glaq_t.glaq003, 
   amt653 LIKE glaq_t.glaq003, 
   amt661 LIKE glaq_t.glaq003, 
   amt662 LIKE glaq_t.glaq003, 
   amt663 LIKE glaq_t.glaq003, 
   amt671 LIKE glaq_t.glaq003, 
   amt672 LIKE glaq_t.glaq003, 
   amt673 LIKE glaq_t.glaq003, 
   amt681 LIKE glaq_t.glaq003, 
   amt682 LIKE glaq_t.glaq003, 
   amt683 LIKE glaq_t.glaq003, 
   amt691 LIKE glaq_t.glaq003, 
   amt692 LIKE glaq_t.glaq003, 
   amt693 LIKE glaq_t.glaq003,
   amt701 LIKE glaq_t.glaq003, 
   amt702 LIKE glaq_t.glaq003, 
   amt703 LIKE glaq_t.glaq003,
   amt711 LIKE glaq_t.glaq003, 
   amt712 LIKE glaq_t.glaq003, 
   amt713 LIKE glaq_t.glaq003, 
   amt721 LIKE glaq_t.glaq003, 
   amt722 LIKE glaq_t.glaq003, 
   amt723 LIKE glaq_t.glaq003, 
   amt731 LIKE glaq_t.glaq003, 
   amt732 LIKE glaq_t.glaq003, 
   amt733 LIKE glaq_t.glaq003, 
   amt741 LIKE glaq_t.glaq003, 
   amt742 LIKE glaq_t.glaq003, 
   amt743 LIKE glaq_t.glaq003, 
   amt751 LIKE glaq_t.glaq003, 
   amt752 LIKE glaq_t.glaq003, 
   amt753 LIKE glaq_t.glaq003, 
   amt761 LIKE glaq_t.glaq003, 
   amt762 LIKE glaq_t.glaq003, 
   amt763 LIKE glaq_t.glaq003, 
   amt771 LIKE glaq_t.glaq003, 
   amt772 LIKE glaq_t.glaq003, 
   amt773 LIKE glaq_t.glaq003, 
   amt781 LIKE glaq_t.glaq003, 
   amt782 LIKE glaq_t.glaq003, 
   amt783 LIKE glaq_t.glaq003, 
   amt791 LIKE glaq_t.glaq003, 
   amt792 LIKE glaq_t.glaq003, 
   amt793 LIKE glaq_t.glaq003,
   amt801 LIKE glaq_t.glaq003, 
   amt802 LIKE glaq_t.glaq003, 
   amt803 LIKE glaq_t.glaq003,
   amt811 LIKE glaq_t.glaq003, 
   amt812 LIKE glaq_t.glaq003, 
   amt813 LIKE glaq_t.glaq003, 
   amt821 LIKE glaq_t.glaq003, 
   amt822 LIKE glaq_t.glaq003, 
   amt823 LIKE glaq_t.glaq003, 
   amt831 LIKE glaq_t.glaq003, 
   amt832 LIKE glaq_t.glaq003, 
   amt833 LIKE glaq_t.glaq003, 
   amt841 LIKE glaq_t.glaq003, 
   amt842 LIKE glaq_t.glaq003, 
   amt843 LIKE glaq_t.glaq003, 
   amt851 LIKE glaq_t.glaq003, 
   amt852 LIKE glaq_t.glaq003, 
   amt853 LIKE glaq_t.glaq003, 
   amt861 LIKE glaq_t.glaq003, 
   amt862 LIKE glaq_t.glaq003, 
   amt863 LIKE glaq_t.glaq003, 
   amt871 LIKE glaq_t.glaq003, 
   amt872 LIKE glaq_t.glaq003, 
   amt873 LIKE glaq_t.glaq003, 
   amt881 LIKE glaq_t.glaq003, 
   amt882 LIKE glaq_t.glaq003, 
   amt883 LIKE glaq_t.glaq003, 
   amt891 LIKE glaq_t.glaq003, 
   amt892 LIKE glaq_t.glaq003, 
   amt893 LIKE glaq_t.glaq003,
   amt901 LIKE glaq_t.glaq003, 
   amt902 LIKE glaq_t.glaq003, 
   amt903 LIKE glaq_t.glaq003,
   amt911 LIKE glaq_t.glaq003, 
   amt912 LIKE glaq_t.glaq003, 
   amt913 LIKE glaq_t.glaq003, 
   amt921 LIKE glaq_t.glaq003, 
   amt922 LIKE glaq_t.glaq003, 
   amt923 LIKE glaq_t.glaq003, 
   amt931 LIKE glaq_t.glaq003, 
   amt932 LIKE glaq_t.glaq003, 
   amt933 LIKE glaq_t.glaq003, 
   amt941 LIKE glaq_t.glaq003, 
   amt942 LIKE glaq_t.glaq003, 
   amt943 LIKE glaq_t.glaq003, 
   amt951 LIKE glaq_t.glaq003, 
   amt952 LIKE glaq_t.glaq003, 
   amt953 LIKE glaq_t.glaq003, 
   amt961 LIKE glaq_t.glaq003, 
   amt962 LIKE glaq_t.glaq003, 
   amt963 LIKE glaq_t.glaq003, 
   amt971 LIKE glaq_t.glaq003, 
   amt972 LIKE glaq_t.glaq003, 
   amt973 LIKE glaq_t.glaq003, 
   amt981 LIKE glaq_t.glaq003, 
   amt982 LIKE glaq_t.glaq003, 
   amt983 LIKE glaq_t.glaq003, 
   amt991 LIKE glaq_t.glaq003, 
   amt992 LIKE glaq_t.glaq003, 
   amt993 LIKE glaq_t.glaq003,
   amt1001 LIKE glaq_t.glaq003, 
   amt1002 LIKE glaq_t.glaq003, 
   amt1003 LIKE glaq_t.glaq003,
   sum1 LIKE glaq_t.glaq003,    #150827-00036#15 add
   sum2 LIKE glaq_t.glaq003,    #150827-00036#15 add
   sum3 LIKE glaq_t.glaq003     #150827-00036#15 add
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glar_d
DEFINE g_master_t                   type_g_glar_d
DEFINE g_glar_d          DYNAMIC ARRAY OF type_g_glar_d
DEFINE g_glar_d_t        type_g_glar_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       sdate           LIKE glap_t.glapdocdt,  #起始日期
       syear           LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       edate           LIKE glap_t.glapdocdt,  #截止日期
       eyear           LIKE glap_t.glap002,    #截止年度
       eperiod         LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       fix_acc         LIKE type_t.chr2, 
       stype           LIKE type_t.chr1, 
       show_acc        LIKE type_t.chr1, 
       glac005	       LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	       LIKE glac_t.glac009,
       show_ad         LIKE type_t.chr1,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1
       END RECORD
DEFINE g_wc1           STRING
DEFINE g_glar009       LIKE glar_t.glar009
DEFINE g_glar001       DYNAMIC ARRAY OF VARCHAR(24)  #科目編號
DEFINE g_glar012       DYNAMIC ARRAY OF RECORD  #核算項
       glar012         LIKE type_t.chr30,
       glad0171        LIKE glad_t.glad0171
       END RECORD
DEFINE g_col           LIKE type_t.num5
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aglq730.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aglq730_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq730_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq730 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq730_init()   
 
      #進入選單 Menu (="N")
      CALL aglq730_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq730
      
   END IF 
   
   CLOSE aglq730_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq730_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aglq730.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq730_init()
   #add-point:init段define
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   LET g_detail_idx  = 1
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('fix_acc','9934')
#   CALL cl_set_combo_scc('stype','9925')  #160912-00013#1 mark
   CALL cl_set_combo_scc_part('stype','9925','1,2') #160912-00013#1 add
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
   CALL aglq730_glaald_desc(g_glaald)
   CALL aglq730_set_default_value()
   LET g_col=0
   CALL aglq730_set_acc_visible()
   #建立临时表
   CALL aglq730_create_temp_table()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglq730.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq730_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define

   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   CALL aglq730_query()
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glar_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aglq730_fetch()
               #add-point:input段before row

               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
            NEXT FIELD sel
      
         
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION exchange_ld
 
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN 
               #add-point:ON ACTION exchange_ld
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glar_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq730_glaald_desc(g_glaald)
               CALL aglq730_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               CALL aglq730_xg()   ##130726-00001#95 Add
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aglq730_query()
               #add-point:ON ACTION query
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               #END add-point
            END IF
 
      
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq730_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL aglq730_glaald_desc(g_glaald)
            CALL aglq730_set_default_value()
            LET g_col=0
            CALL aglq730_set_acc_visible()
            CALL aglq730_query()
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL aglq730_b_fill()
            CALL aglq730_fetch()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glar_d)
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF         
      
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="aglq730.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq730_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_flag1          LIKE type_t.chr1
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
   
   #建立临时表
   CALL aglq730_create_temp_table()
   LET l_flag=TRUE
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glar_d.clear()
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
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON glar001
           FROM s_detail1[1].b_glar001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上

            NEXT FIELD b_glar001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar001
            #add-point:BEFORE FIELD b_glar001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar001
            
            #add-point:AFTER FIELD b_glar001

            #END add-point
            
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      INPUT BY NAME tm.sdate,tm.edate,tm.ctype,tm.fix_acc,tm.stype,
                    tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD sdate
            IF NOT cl_null(tm.sdate) THEN
               CALL s_get_accdate(g_glaa003,tm.sdate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
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
               END IF
               LET tm.syear=l_glav002
               LET tm.speriod=l_glav006
               DISPLAY tm.syear,tm.speriod TO syear,speriod 
            END IF
         AFTER FIELD edate
            IF NOT cl_null(tm.edate) THEN
               CALL s_get_accdate(g_glaa003,tm.edate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
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
               END IF
               LET tm.eyear=l_glav002
               LET tm.eperiod=l_glav006
               DISPLAY tm.eyear,tm.eperiod TO eyear,eperiod 
            END IF
         ON CHANGE ctype
            IF tm.ctype NOT MATCHES '[0123]' THEN
               NEXT FIELD ctype
            END IF
         AFTER FIELD stype
            IF tm.stype NOT MATCHES '[12]' THEN
               NEXT FIELD stype
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
         
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF

         AFTER FIELD show_ce
            IF tm.show_ce NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD show_ye
            IF tm.show_ye NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
         
      END INPUT
      
      BEFORE DIALOG
         #預設
         CALL aglq730_show()
         #150827-00036#15--add--str--
         LET g_glar_d[1].glar001 = ""
         DISPLAY ARRAY g_glar_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #150827-00036#15--add--end
        
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #預設
         CALL aglq730_show()
         CALL aglq730_glaald_desc(g_glaald)
         CALL aglq730_set_default_value()
         LET g_col=0
         CALL aglq730_set_acc_visible()
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
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET l_flag=FALSE
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   IF l_flag=TRUE THEN
      CALL aglq730_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq730_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq730_acc_name()
      CALL aglq730_set_acc_visible()
   END IF
   CALL aglq730_b_fill1()
   #end add-point
        
   LET g_error_show = 1
   CALL aglq730_b_fill()
   LET l_ac = g_master_idx
   CALL aglq730_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      CALL cl_err("",-100,1)
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglq730.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq730_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   {</Local define>}
   #add-point:b_fill段define
 
   #end add-point
 
   #add-point:b_fill段sql_before
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   LET g_sql = "SELECT  UNIQUE glar001,'','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','' FROM glar_t",
 
 
               "",
               " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET g_sql = g_sql, " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
  
   #add-point:b_fill段sql_after
   
   #end add-point
  
   PREPARE aglq730_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq730_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glar_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].amt11, 
       g_glar_d[l_ac].amt12,g_glar_d[l_ac].amt13,g_glar_d[l_ac].amt21,g_glar_d[l_ac].amt22,g_glar_d[l_ac].amt23, 
       g_glar_d[l_ac].amt31,g_glar_d[l_ac].amt32,g_glar_d[l_ac].amt33,g_glar_d[l_ac].amt41,g_glar_d[l_ac].amt42, 
       g_glar_d[l_ac].amt43,g_glar_d[l_ac].amt51,g_glar_d[l_ac].amt52,g_glar_d[l_ac].amt53,g_glar_d[l_ac].amt61, 
       g_glar_d[l_ac].amt62,g_glar_d[l_ac].amt63,g_glar_d[l_ac].amt71,g_glar_d[l_ac].amt72,g_glar_d[l_ac].amt73, 
       g_glar_d[l_ac].amt81,g_glar_d[l_ac].amt82,g_glar_d[l_ac].amt83,g_glar_d[l_ac].amt91,g_glar_d[l_ac].amt92, 
       g_glar_d[l_ac].amt93,g_glar_d[l_ac].amt101,g_glar_d[l_ac].amt102,g_glar_d[l_ac].amt103,g_glar_d[l_ac].amt111, 
       g_glar_d[l_ac].amt112,g_glar_d[l_ac].amt113,g_glar_d[l_ac].amt121,g_glar_d[l_ac].amt122,g_glar_d[l_ac].amt123, 
       g_glar_d[l_ac].amt131,g_glar_d[l_ac].amt132,g_glar_d[l_ac].amt133,g_glar_d[l_ac].amt141,g_glar_d[l_ac].amt142, 
       g_glar_d[l_ac].amt143,g_glar_d[l_ac].amt151,g_glar_d[l_ac].amt152,g_glar_d[l_ac].amt153,g_glar_d[l_ac].amt161, 
       g_glar_d[l_ac].amt162,g_glar_d[l_ac].amt163,g_glar_d[l_ac].amt171,g_glar_d[l_ac].amt172,g_glar_d[l_ac].amt173, 
       g_glar_d[l_ac].amt181,g_glar_d[l_ac].amt182,g_glar_d[l_ac].amt183,g_glar_d[l_ac].amt191,g_glar_d[l_ac].amt192, 
       g_glar_d[l_ac].amt193,g_glar_d[l_ac].amt201,g_glar_d[l_ac].amt202,g_glar_d[l_ac].amt203,g_glar_d[l_ac].amt211, 
       g_glar_d[l_ac].amt212,g_glar_d[l_ac].amt213,g_glar_d[l_ac].amt221,g_glar_d[l_ac].amt222,g_glar_d[l_ac].amt223, 
       g_glar_d[l_ac].amt231,g_glar_d[l_ac].amt232,g_glar_d[l_ac].amt233,g_glar_d[l_ac].amt241,g_glar_d[l_ac].amt242, 
       g_glar_d[l_ac].amt243,g_glar_d[l_ac].amt251,g_glar_d[l_ac].amt252,g_glar_d[l_ac].amt253,g_glar_d[l_ac].amt261, 
       g_glar_d[l_ac].amt262,g_glar_d[l_ac].amt263,g_glar_d[l_ac].amt271,g_glar_d[l_ac].amt272,g_glar_d[l_ac].amt273, 
       g_glar_d[l_ac].amt281,g_glar_d[l_ac].amt282,g_glar_d[l_ac].amt283,g_glar_d[l_ac].amt291,g_glar_d[l_ac].amt292, 
       g_glar_d[l_ac].amt293,g_glar_d[l_ac].amt301,g_glar_d[l_ac].amt302,g_glar_d[l_ac].amt303
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET g_glar_d[l_ac].sel = "N"
      #LET g_glar_d[l_ac].statepic = cl_get_actipic(g_glar_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL aglq730_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
 
   
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq730_pb
   
   LET l_ac = 1
   CALL aglq730_fetch()
   
      CALL aglq730_filter_show('glar001','b_glar001')
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq730.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq730_fetch()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:fetch段define
 
   #end add-point
   
 
   
   LET li_ac = l_ac 
   
 
   
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
 
   #add-point:單身填充後
   
   #end add-point 
   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq730.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq730_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glar_d[l_ac].glar001
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glar_d[l_ac].glar001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glar_d[l_ac].glar001_desc

   #end add-point
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq730.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq730_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
    
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
      CONSTRUCT g_wc_filter ON glar001
                          FROM s_detail1[1].b_glar001
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
                     DISPLAY aglq730_filter_parser('glar001') TO s_detail1[1].b_glar001
                     
      ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
 
            NEXT FIELD b_glar001                     #返回原欄位
 
 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar001
            #add-point:BEFORE FIELD b_glar001
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar001
            
            #add-point:AFTER FIELD b_glar001
 
            #END add-point
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL aglq730_filter_show('glar001','b_glar001')
 
 
  
    CALL aglq730_b_fill1()
#   CALL aglq730_b_fill()
#   CALL aglq730_fetch()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq730.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq730_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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
 
{<section id="aglq730.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq730_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aglq730_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq730.insert" >}
#+ insert
PRIVATE FUNCTION aglq730_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq730.modify" >}
#+ modify
PRIVATE FUNCTION aglq730_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq730.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq730_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq730.delete" >}
#+ delete
PRIVATE FUNCTION aglq730_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq730.other_function" >}
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq730_create_temp_table()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_create_temp_table()
   DROP TABLE aglq730_tmp
   CREATE TEMP TABLE aglq730_tmp(
   glar001       VARCHAR(24),
   glar001_desc  VARCHAR(500),
   amt11         DECIMAL(20,6),
   amt12         DECIMAL(20,6),
   amt13         DECIMAL(20,6),
   amt21         DECIMAL(20,6),
   amt22         DECIMAL(20,6),
   amt23         DECIMAL(20,6),
   amt31         DECIMAL(20,6),
   amt32         DECIMAL(20,6),
   amt33         DECIMAL(20,6),
   amt41         DECIMAL(20,6),
   amt42         DECIMAL(20,6),
   amt43         DECIMAL(20,6),
   amt51         DECIMAL(20,6),
   amt52         DECIMAL(20,6),
   amt53         DECIMAL(20,6),
   amt61         DECIMAL(20,6),
   amt62         DECIMAL(20,6),
   amt63         DECIMAL(20,6),
   amt71         DECIMAL(20,6),
   amt72         DECIMAL(20,6),
   amt73         DECIMAL(20,6),
   amt81         DECIMAL(20,6),
   amt82         DECIMAL(20,6),
   amt83         DECIMAL(20,6),
   amt91         DECIMAL(20,6),
   amt92         DECIMAL(20,6),
   amt93         DECIMAL(20,6),
   amt101        DECIMAL(20,6),
   amt102        DECIMAL(20,6),
   amt103        DECIMAL(20,6),
   amt111        DECIMAL(20,6),
   amt112        DECIMAL(20,6),
   amt113        DECIMAL(20,6),
   amt121        DECIMAL(20,6),
   amt122        DECIMAL(20,6),
   amt123        DECIMAL(20,6),
   amt131        DECIMAL(20,6),
   amt132        DECIMAL(20,6),
   amt133        DECIMAL(20,6),
   amt141        DECIMAL(20,6),
   amt142        DECIMAL(20,6),
   amt143        DECIMAL(20,6),
   amt151        DECIMAL(20,6),
   amt152        DECIMAL(20,6),
   amt153        DECIMAL(20,6),
   amt161        DECIMAL(20,6),
   amt162        DECIMAL(20,6),
   amt163        DECIMAL(20,6),
   amt171        DECIMAL(20,6),
   amt172        DECIMAL(20,6),
   amt173        DECIMAL(20,6),
   amt181        DECIMAL(20,6),
   amt182        DECIMAL(20,6),
   amt183        DECIMAL(20,6),
   amt191        DECIMAL(20,6),
   amt192        DECIMAL(20,6),
   amt193        DECIMAL(20,6),
   amt201        DECIMAL(20,6),
   amt202        DECIMAL(20,6),
   amt203        DECIMAL(20,6),
   amt211        DECIMAL(20,6),
   amt212        DECIMAL(20,6),
   amt213        DECIMAL(20,6),
   amt221        DECIMAL(20,6),
   amt222        DECIMAL(20,6),
   amt223        DECIMAL(20,6),
   amt231        DECIMAL(20,6),
   amt232        DECIMAL(20,6),
   amt233        DECIMAL(20,6),
   amt241        DECIMAL(20,6),
   amt242        DECIMAL(20,6),
   amt243        DECIMAL(20,6),
   amt251        DECIMAL(20,6),
   amt252        DECIMAL(20,6),
   amt253        DECIMAL(20,6),
   amt261        DECIMAL(20,6),
   amt262        DECIMAL(20,6),
   amt263        DECIMAL(20,6),
   amt271        DECIMAL(20,6),
   amt272        DECIMAL(20,6),
   amt273        DECIMAL(20,6),
   amt281        DECIMAL(20,6),
   amt282        DECIMAL(20,6),
   amt283        DECIMAL(20,6),
   amt291        DECIMAL(20,6),
   amt292        DECIMAL(20,6),
   amt293        DECIMAL(20,6),
   amt301        DECIMAL(20,6),
   amt302        DECIMAL(20,6),
   amt303        DECIMAL(20,6),
   amt311        DECIMAL(20,6),
   amt312        DECIMAL(20,6),
   amt313        DECIMAL(20,6),
   amt321        DECIMAL(20,6),
   amt322        DECIMAL(20,6),
   amt323        DECIMAL(20,6),
   amt331        DECIMAL(20,6),
   amt332        DECIMAL(20,6),
   amt333        DECIMAL(20,6),
   amt341        DECIMAL(20,6),
   amt342        DECIMAL(20,6),
   amt343        DECIMAL(20,6),
   amt351        DECIMAL(20,6),
   amt352        DECIMAL(20,6),
   amt353        DECIMAL(20,6),
   amt361        DECIMAL(20,6),
   amt362        DECIMAL(20,6),
   amt363        DECIMAL(20,6),
   amt371        DECIMAL(20,6),
   amt372        DECIMAL(20,6),
   amt373        DECIMAL(20,6),
   amt381        DECIMAL(20,6),
   amt382        DECIMAL(20,6),
   amt383        DECIMAL(20,6),
   amt391        DECIMAL(20,6),
   amt392        DECIMAL(20,6),
   amt393        DECIMAL(20,6),
   amt401        DECIMAL(20,6),
   amt402        DECIMAL(20,6),
   amt403        DECIMAL(20,6),
   amt411        DECIMAL(20,6),
   amt412        DECIMAL(20,6),
   amt413        DECIMAL(20,6),
   amt421        DECIMAL(20,6),
   amt422        DECIMAL(20,6),
   amt423        DECIMAL(20,6),
   amt431        DECIMAL(20,6),
   amt432        DECIMAL(20,6),
   amt433        DECIMAL(20,6),
   amt441        DECIMAL(20,6),
   amt442        DECIMAL(20,6),
   amt443        DECIMAL(20,6),
   amt451        DECIMAL(20,6),
   amt452        DECIMAL(20,6),
   amt453        DECIMAL(20,6),
   amt461        DECIMAL(20,6),
   amt462        DECIMAL(20,6),
   amt463        DECIMAL(20,6),
   amt471        DECIMAL(20,6),
   amt472        DECIMAL(20,6),
   amt473        DECIMAL(20,6),
   amt481        DECIMAL(20,6),
   amt482        DECIMAL(20,6),
   amt483        DECIMAL(20,6),
   amt491        DECIMAL(20,6),
   amt492        DECIMAL(20,6),
   amt493        DECIMAL(20,6),
   amt501        DECIMAL(20,6),
   amt502        DECIMAL(20,6),
   amt503        DECIMAL(20,6),
   amt511        DECIMAL(20,6),
   amt512        DECIMAL(20,6),
   amt513        DECIMAL(20,6),
   amt521        DECIMAL(20,6),
   amt522        DECIMAL(20,6),
   amt523        DECIMAL(20,6),
   amt531        DECIMAL(20,6),
   amt532        DECIMAL(20,6),
   amt533        DECIMAL(20,6),
   amt541        DECIMAL(20,6),
   amt542        DECIMAL(20,6),
   amt543        DECIMAL(20,6),
   amt551        DECIMAL(20,6),
   amt552        DECIMAL(20,6),
   amt553        DECIMAL(20,6),
   amt561        DECIMAL(20,6),
   amt562        DECIMAL(20,6),
   amt563        DECIMAL(20,6),
   amt571        DECIMAL(20,6),
   amt572        DECIMAL(20,6),
   amt573        DECIMAL(20,6),
   amt581        DECIMAL(20,6),
   amt582        DECIMAL(20,6),
   amt583        DECIMAL(20,6),
   amt591        DECIMAL(20,6),
   amt592        DECIMAL(20,6),
   amt593        DECIMAL(20,6),
   amt601        DECIMAL(20,6),
   amt602        DECIMAL(20,6),
   amt603        DECIMAL(20,6),
   amt611        DECIMAL(20,6),
   amt612        DECIMAL(20,6),
   amt613        DECIMAL(20,6),
   amt621        DECIMAL(20,6),
   amt622        DECIMAL(20,6),
   amt623        DECIMAL(20,6),
   amt631        DECIMAL(20,6),
   amt632        DECIMAL(20,6),
   amt633        DECIMAL(20,6),
   amt641        DECIMAL(20,6),
   amt642        DECIMAL(20,6),
   amt643        DECIMAL(20,6),
   amt651        DECIMAL(20,6),
   amt652        DECIMAL(20,6),
   amt653        DECIMAL(20,6),
   amt661        DECIMAL(20,6),
   amt662        DECIMAL(20,6),
   amt663        DECIMAL(20,6),
   amt671        DECIMAL(20,6),
   amt672        DECIMAL(20,6),
   amt673        DECIMAL(20,6),
   amt681        DECIMAL(20,6),
   amt682        DECIMAL(20,6),
   amt683        DECIMAL(20,6),
   amt691        DECIMAL(20,6),
   amt692        DECIMAL(20,6),
   amt693        DECIMAL(20,6),
   amt701        DECIMAL(20,6),
   amt702        DECIMAL(20,6),
   amt703        DECIMAL(20,6),
   amt711        DECIMAL(20,6),
   amt712        DECIMAL(20,6),
   amt713        DECIMAL(20,6),
   amt721        DECIMAL(20,6),
   amt722        DECIMAL(20,6),
   amt723        DECIMAL(20,6),
   amt731        DECIMAL(20,6),
   amt732        DECIMAL(20,6),
   amt733        DECIMAL(20,6),
   amt741        DECIMAL(20,6),
   amt742        DECIMAL(20,6),
   amt743        DECIMAL(20,6),
   amt751        DECIMAL(20,6),
   amt752        DECIMAL(20,6),
   amt753        DECIMAL(20,6),
   amt761        DECIMAL(20,6),
   amt762        DECIMAL(20,6),
   amt763        DECIMAL(20,6),
   amt771        DECIMAL(20,6),
   amt772        DECIMAL(20,6),
   amt773        DECIMAL(20,6),
   amt781        DECIMAL(20,6),
   amt782        DECIMAL(20,6),
   amt783        DECIMAL(20,6),
   amt791        DECIMAL(20,6),
   amt792        DECIMAL(20,6),
   amt793        DECIMAL(20,6),
   amt801        DECIMAL(20,6),
   amt802        DECIMAL(20,6),
   amt803        DECIMAL(20,6),
   amt811        DECIMAL(20,6),
   amt812        DECIMAL(20,6),
   amt813        DECIMAL(20,6),
   amt821        DECIMAL(20,6),
   amt822        DECIMAL(20,6),
   amt823        DECIMAL(20,6),
   amt831        DECIMAL(20,6),
   amt832        DECIMAL(20,6),
   amt833        DECIMAL(20,6),
   amt841        DECIMAL(20,6),
   amt842        DECIMAL(20,6),
   amt843        DECIMAL(20,6),
   amt851        DECIMAL(20,6),
   amt852        DECIMAL(20,6),
   amt853        DECIMAL(20,6),
   amt861        DECIMAL(20,6),
   amt862        DECIMAL(20,6),
   amt863        DECIMAL(20,6),
   amt871        DECIMAL(20,6),
   amt872        DECIMAL(20,6),
   amt873        DECIMAL(20,6),
   amt881        DECIMAL(20,6),
   amt882        DECIMAL(20,6),
   amt883        DECIMAL(20,6),
   amt891        DECIMAL(20,6),
   amt892        DECIMAL(20,6),
   amt893        DECIMAL(20,6),
   amt901        DECIMAL(20,6),
   amt902        DECIMAL(20,6),
   amt903        DECIMAL(20,6),
   amt911        DECIMAL(20,6),
   amt912        DECIMAL(20,6),
   amt913        DECIMAL(20,6),
   amt921        DECIMAL(20,6),
   amt922        DECIMAL(20,6),
   amt923        DECIMAL(20,6),
   amt931        DECIMAL(20,6),
   amt932        DECIMAL(20,6),
   amt933        DECIMAL(20,6),
   amt941        DECIMAL(20,6),
   amt942        DECIMAL(20,6),
   amt943        DECIMAL(20,6),
   amt951        DECIMAL(20,6),
   amt952        DECIMAL(20,6),
   amt953        DECIMAL(20,6),
   amt961        DECIMAL(20,6),
   amt962        DECIMAL(20,6),
   amt963        DECIMAL(20,6),
   amt971        DECIMAL(20,6),
   amt972        DECIMAL(20,6),
   amt973        DECIMAL(20,6),
   amt981        DECIMAL(20,6),
   amt982        DECIMAL(20,6),
   amt983        DECIMAL(20,6),
   amt991        DECIMAL(20,6),
   amt992        DECIMAL(20,6),
   amt993        DECIMAL(20,6),
   amt1001       DECIMAL(20,6),
   amt1002       DECIMAL(20,6),
   amt1003       DECIMAL(20,6))
END FUNCTION
################################################################################
# Descriptions...: 為XG報表建立臨時表
# Memo...........:
# Usage..........: CALL aglq730_create_for_xg()
#                  RETURNING ---
# Input parameter:
# Return code....:
# Date & Author..: 2015/06/02 By 01727
# Modify.........: #130726-00001#95 Add
################################################################################
PRIVATE FUNCTION aglq730_create_for_xg()
      DROP TABLE aglq730_tmp01;           #160727-00019#3  Mod  aglq730_print_tmp -->aglq730_tmp01
      CREATE TEMP TABLE aglq730_tmp01(    #160727-00019#3  Mod  aglq730_print_tmp -->aglq730_tmp01
            glar001        VARCHAR(24),
            glar001_desc   VARCHAR(500),
            amt11           DECIMAL(20,6),
            amt12           DECIMAL(20,6),
            amt13           DECIMAL(20,6),
            amt21           DECIMAL(20,6),
            amt22           DECIMAL(20,6),
            amt23           DECIMAL(20,6),
            amt31           DECIMAL(20,6),
            amt32           DECIMAL(20,6),
            amt33           DECIMAL(20,6),
            amt41           DECIMAL(20,6),
            amt42           DECIMAL(20,6),
            amt43           DECIMAL(20,6),
            amt51           DECIMAL(20,6),
            amt52           DECIMAL(20,6),
            amt53           DECIMAL(20,6),
            amt61           DECIMAL(20,6),
            amt62           DECIMAL(20,6),
            amt63           DECIMAL(20,6),
            amt71           DECIMAL(20,6),
            amt72           DECIMAL(20,6),
            amt73           DECIMAL(20,6),
            amt81           DECIMAL(20,6),
            amt82           DECIMAL(20,6),
            amt83           DECIMAL(20,6),
            amt91           DECIMAL(20,6),
            amt92           DECIMAL(20,6),
            amt93           DECIMAL(20,6),
            amt101          DECIMAL(20,6),
            amt102          DECIMAL(20,6),
            amt103          DECIMAL(20,6),
            amt111          DECIMAL(20,6),
            amt112          DECIMAL(20,6),
            amt113          DECIMAL(20,6),
            amt121          DECIMAL(20,6),
            amt122          DECIMAL(20,6),
            amt123          DECIMAL(20,6),
            amt131          DECIMAL(20,6),
            amt132          DECIMAL(20,6),
            amt133          DECIMAL(20,6),
            amt141          DECIMAL(20,6),
            amt142          DECIMAL(20,6),
            amt143          DECIMAL(20,6),
            amt151          DECIMAL(20,6),
            amt152          DECIMAL(20,6),
            amt153          DECIMAL(20,6),
            amt161          DECIMAL(20,6),
            amt162          DECIMAL(20,6),
            amt163          DECIMAL(20,6),
            amt171          DECIMAL(20,6),
            amt172          DECIMAL(20,6),
            amt173          DECIMAL(20,6),
            amt181          DECIMAL(20,6),
            amt182          DECIMAL(20,6),
            amt183          DECIMAL(20,6),
            amt191          DECIMAL(20,6),
            amt192          DECIMAL(20,6),
            amt193          DECIMAL(20,6),
            amt201          DECIMAL(20,6),
            amt202          DECIMAL(20,6),
            amt203          DECIMAL(20,6),
            amt211          DECIMAL(20,6),
            amt212          DECIMAL(20,6),
            amt213          DECIMAL(20,6),
            amt221          DECIMAL(20,6),
            amt222          DECIMAL(20,6),
            amt223          DECIMAL(20,6),
            amt231          DECIMAL(20,6),
            amt232          DECIMAL(20,6),
            amt233          DECIMAL(20,6),
            amt241          DECIMAL(20,6),
            amt242          DECIMAL(20,6),
            amt243          DECIMAL(20,6),
            amt251          DECIMAL(20,6),
            amt252          DECIMAL(20,6),
            amt253          DECIMAL(20,6),
            amt261          DECIMAL(20,6),
            amt262          DECIMAL(20,6),
            amt263          DECIMAL(20,6),
            amt271          DECIMAL(20,6),
            amt272          DECIMAL(20,6),
            amt273          DECIMAL(20,6),
            amt281          DECIMAL(20,6),
            amt282          DECIMAL(20,6),
            amt283          DECIMAL(20,6),
            amt291          DECIMAL(20,6),
            amt292          DECIMAL(20,6),
            amt293          DECIMAL(20,6),
            amt301          DECIMAL(20,6),
            amt302          DECIMAL(20,6),
            amt303          DECIMAL(20,6),
            amt311          DECIMAL(20,6),
            amt312          DECIMAL(20,6),
            amt313          DECIMAL(20,6),
            amt321          DECIMAL(20,6),
            amt322          DECIMAL(20,6),
            amt323          DECIMAL(20,6),
            amt331          DECIMAL(20,6),
            amt332          DECIMAL(20,6),
            amt333          DECIMAL(20,6),
            amt341          DECIMAL(20,6),
            amt342          DECIMAL(20,6),
            amt343          DECIMAL(20,6),
            amt351          DECIMAL(20,6),
            amt352          DECIMAL(20,6),
            amt353          DECIMAL(20,6),
            amt361          DECIMAL(20,6),
            amt362          DECIMAL(20,6),
            amt363          DECIMAL(20,6),
            amt371          DECIMAL(20,6),
            amt372          DECIMAL(20,6),
            amt373          DECIMAL(20,6),
            amt381          DECIMAL(20,6),
            amt382          DECIMAL(20,6),
            amt383          DECIMAL(20,6),
            amt391          DECIMAL(20,6),
            amt392          DECIMAL(20,6),
            amt393          DECIMAL(20,6),
            amt401          DECIMAL(20,6),
            amt402          DECIMAL(20,6),
            amt403          DECIMAL(20,6),
            amt411          DECIMAL(20,6),
            amt412          DECIMAL(20,6),
            amt413          DECIMAL(20,6),
            amt421          DECIMAL(20,6),
            amt422          DECIMAL(20,6),
            amt423          DECIMAL(20,6),
            amt431          DECIMAL(20,6),
            amt432          DECIMAL(20,6),
            amt433          DECIMAL(20,6),
            amt441          DECIMAL(20,6),
            amt442          DECIMAL(20,6),
            amt443          DECIMAL(20,6),
            amt451          DECIMAL(20,6),
            amt452          DECIMAL(20,6),
            amt453          DECIMAL(20,6),
            amt461          DECIMAL(20,6),
            amt462          DECIMAL(20,6),
            amt463          DECIMAL(20,6),
            amt471          DECIMAL(20,6),
            amt472          DECIMAL(20,6),
            amt473          DECIMAL(20,6),
            amt481          DECIMAL(20,6),
            amt482          DECIMAL(20,6),
            amt483          DECIMAL(20,6),
            amt491          DECIMAL(20,6),
            amt492          DECIMAL(20,6),
            amt493          DECIMAL(20,6),
            amt501          DECIMAL(20,6),
            amt502          DECIMAL(20,6),
            amt503          DECIMAL(20,6),
            amt511          DECIMAL(20,6),
            amt512          DECIMAL(20,6),
            amt513          DECIMAL(20,6),
            amt521          DECIMAL(20,6),
            amt522          DECIMAL(20,6),
            amt523          DECIMAL(20,6),
            amt531          DECIMAL(20,6),
            amt532          DECIMAL(20,6),
            amt533          DECIMAL(20,6),
            amt541          DECIMAL(20,6),
            amt542          DECIMAL(20,6),
            amt543          DECIMAL(20,6),
            amt551          DECIMAL(20,6),
            amt552          DECIMAL(20,6),
            amt553          DECIMAL(20,6),
            amt561          DECIMAL(20,6),
            amt562          DECIMAL(20,6),
            amt563          DECIMAL(20,6),
            amt571          DECIMAL(20,6),
            amt572          DECIMAL(20,6),
            amt573          DECIMAL(20,6),
            amt581          DECIMAL(20,6),
            amt582          DECIMAL(20,6),
            amt583          DECIMAL(20,6),
            amt591          DECIMAL(20,6),
            amt592          DECIMAL(20,6),
            amt593          DECIMAL(20,6),
            amt601          DECIMAL(20,6),
            amt602          DECIMAL(20,6),
            amt603          DECIMAL(20,6),
            amt611          DECIMAL(20,6),
            amt612          DECIMAL(20,6),
            amt613          DECIMAL(20,6),
            amt621          DECIMAL(20,6),
            amt622          DECIMAL(20,6),
            amt623          DECIMAL(20,6),
            amt631          DECIMAL(20,6),
            amt632          DECIMAL(20,6),
            amt633          DECIMAL(20,6),
            amt641          DECIMAL(20,6),
            amt642          DECIMAL(20,6),
            amt643          DECIMAL(20,6),
            amt651          DECIMAL(20,6),
            amt652          DECIMAL(20,6),
            amt653          DECIMAL(20,6),
            amt661          DECIMAL(20,6),
            amt662          DECIMAL(20,6),
            amt663          DECIMAL(20,6),
            amt671          DECIMAL(20,6),
            amt672          DECIMAL(20,6),
            amt673          DECIMAL(20,6),
            amt681          DECIMAL(20,6),
            amt682          DECIMAL(20,6),
            amt683          DECIMAL(20,6),
            amt691          DECIMAL(20,6),
            amt692          DECIMAL(20,6),
            amt693          DECIMAL(20,6),
            amt701          DECIMAL(20,6),
            amt702          DECIMAL(20,6),
            amt703          DECIMAL(20,6),
            amt711          DECIMAL(20,6),
            amt712          DECIMAL(20,6),
            amt713          DECIMAL(20,6),
            amt721          DECIMAL(20,6),
            amt722          DECIMAL(20,6),
            amt723          DECIMAL(20,6),
            amt731          DECIMAL(20,6),
            amt732          DECIMAL(20,6),
            amt733          DECIMAL(20,6),
            amt741          DECIMAL(20,6),
            amt742          DECIMAL(20,6),
            amt743          DECIMAL(20,6),
            amt751          DECIMAL(20,6),
            amt752          DECIMAL(20,6),
            amt753          DECIMAL(20,6),
            amt761          DECIMAL(20,6),
            amt762          DECIMAL(20,6),
            amt763          DECIMAL(20,6),
            amt771          DECIMAL(20,6),
            amt772          DECIMAL(20,6),
            amt773          DECIMAL(20,6),
            amt781          DECIMAL(20,6),
            amt782          DECIMAL(20,6),
            amt783          DECIMAL(20,6),
            amt791          DECIMAL(20,6),
            amt792          DECIMAL(20,6),
            amt793          DECIMAL(20,6),
            amt801          DECIMAL(20,6),
            amt802          DECIMAL(20,6),
            amt803          DECIMAL(20,6),
            amt811          DECIMAL(20,6),
            amt812          DECIMAL(20,6),
            amt813          DECIMAL(20,6),
            amt821          DECIMAL(20,6),
            amt822          DECIMAL(20,6),
            amt823          DECIMAL(20,6),
            amt831          DECIMAL(20,6),
            amt832          DECIMAL(20,6),
            amt833          DECIMAL(20,6),
            amt841          DECIMAL(20,6),
            amt842          DECIMAL(20,6),
            amt843          DECIMAL(20,6),
            amt851          DECIMAL(20,6),
            amt852          DECIMAL(20,6),
            amt853          DECIMAL(20,6),
            amt861          DECIMAL(20,6),
            amt862          DECIMAL(20,6),
            amt863          DECIMAL(20,6),
            amt871          DECIMAL(20,6),
            amt872          DECIMAL(20,6),
            amt873          DECIMAL(20,6),
            amt881          DECIMAL(20,6),
            amt882          DECIMAL(20,6),
            amt883          DECIMAL(20,6),
            amt891          DECIMAL(20,6),
            amt892          DECIMAL(20,6),
            amt893          DECIMAL(20,6),
            amt901          DECIMAL(20,6),
            amt902          DECIMAL(20,6),
            amt903          DECIMAL(20,6),
            amt911          DECIMAL(20,6),
            amt912          DECIMAL(20,6),
            amt913          DECIMAL(20,6),
            amt921          DECIMAL(20,6),
            amt922          DECIMAL(20,6),
            amt923          DECIMAL(20,6),
            amt931          DECIMAL(20,6),
            amt932          DECIMAL(20,6),
            amt933          DECIMAL(20,6),
            amt941          DECIMAL(20,6),
            amt942          DECIMAL(20,6),
            amt943          DECIMAL(20,6),
            amt951          DECIMAL(20,6),
            amt952          DECIMAL(20,6),
            amt953          DECIMAL(20,6),
            amt961          DECIMAL(20,6),
            amt962          DECIMAL(20,6),
            amt963          DECIMAL(20,6),
            amt971          DECIMAL(20,6),
            amt972          DECIMAL(20,6),
            amt973          DECIMAL(20,6),
            amt981          DECIMAL(20,6),
            amt982          DECIMAL(20,6),
            amt983          DECIMAL(20,6),
            amt991          DECIMAL(20,6),
            amt992          DECIMAL(20,6),
            amt993          DECIMAL(20,6),
            amt1001         DECIMAL(20,6),
            amt1002         DECIMAL(20,6),
            amt1003         DECIMAL(20,6),
            l_glaald_desc   VARCHAR(500),
            l_glaacomp_desc  VARCHAR(500),
            l_curr          VARCHAR(500),
            l_sdate         VARCHAR(500),       #起始日期
            l_edate         VARCHAR(500),       #截止日期
            l_ctype         VARCHAR(500),       #多本位幣
            l_fix_acc       VARCHAR(500), 
            l_stype         VARCHAR(500), 
            l_glac005	    SMALLINT,
            l_stus          VARCHAR(500)
          )
END FUNCTION
################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq730_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022 
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
   
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
#   CALL cl_set_comp_visible("ctype",TRUE)
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
#         CALL cl_set_comp_visible("ctype",FALSE)
#         LET tm.ctype=''
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
#         LET tm.ctype='1'
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
#         LET tm.ctype='2'  
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
#         LET tm.ctype='3'
   END CASE
   LET tm.ctype='0'
END FUNCTION
################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq730_set_default_value()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_set_default_value()
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
   LET tm.sdate=l_pdate_s  #起始日期
   LET tm.syear=l_glav002
   LET tm.speriod=l_glav006
   LET tm.edate=l_pdate_e  #截止日期
   LET tm.eyear=l_glav002
   LET tm.eperiod=l_glav006
  
   #核算項
   LET tm.fix_acc='1'
   #餘額形態
   LET tm.stype='1'
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
   #150827-00036#2--add--str--
   #含審計調整傳票
   LET tm.show_ad='Y'
   #150827-00036#2--add--end
END FUNCTION
################################################################################
# Descriptions...: 科目说明
# Memo...........:
# Usage..........: CALL aglq730_glar001_desc(p_glar001)
#                  RETURNING r_desc
# Input parameter: p_glar001   科目編號
# Return code....: r_desc      科目說明
# Date & Author..: 2014/03/14 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_glar001_desc(p_glar001)
   DEFINE p_glar001   LIKE glar_t.glar001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glar001
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION
################################################################################
# Descriptions...: 抓取數據
# Memo...........:
# Usage..........: CALL aglq730_get_data()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_get_data()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_sql5,l_sql6         STRING
   DEFINE l_wc                  STRING 
   DEFINE l_amt1           LIKE type_t.num20_6
   DEFINE l_amt2           LIKE type_t.num20_6
   DEFINE l_amt3           LIKE type_t.num20_6
   DEFINE l_amt4           LIKE type_t.num20_6
   DEFINE l_amt5           LIKE type_t.num20_6
   DEFINE l_amt6           LIKE type_t.num20_6
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_glac008        LIKE glac_t.glac008
   DEFINE l_str,l_str1,l_str2     STRING
   DEFINE l_str3,l_str4,l_str5    STRING
   DEFINE l_i,l_j          LIKE type_t.num5
   DEFINE l_str6           STRING  #核算项类型
   DEFINE l_flag_free_acc  LIKE type_t.num5 #標示是否為自由核算項
   DEFINE l_sql_free       STRING #自由核算項類型條件組sql
   DEFINE l_glaq002        STRING
   DEFINE l_glac002_str    STRING              #151204-00013#3 add
   DEFINE l_glav004        LIKE glav_t.glav004 #160824-00004#4 add
   
   #刪除臨時表中資料
   DELETE FROM aglq730_tmp
   CALL g_glar001.clear()
   CALL g_glar012.clear()
   
   CALL s_get_accdate(g_glaa003,'',tm.syear,tm.speriod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   CALL s_get_accdate(g_glaa003,'',tm.eyear,tm.eperiod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #判斷是否是整期間查詢
   IF tm.sdate=l_pdate_s1 AND tm.edate=l_pdate_e2 THEN
      LET l_flag=TRUE
   ELSE
      LET l_flag=FALSE
   END IF
   
   LET l_wc=cl_replace_str(g_wc,'glar001','glaq002')
   LET l_sql5=cl_replace_str(g_wc,'glar001','glac002')
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
#151204-00013#3--mark--str--
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#      LET l_sql3="'CE'"
#   END IF
#151204-00013#3--mark--end
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'YE'"
      ELSE
         LET l_sql3="'YE'" 
      END IF
   END IF
   #150827-00036#2--add--str--
   #顯示AD審計調整傳票否
   IF tm.show_ad<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'AD' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'AD'"
      ELSE
         LET l_sql3="'AD'" 
      END IF
   END IF
   #150827-00036#2--add--end
   IF NOT cl_null(l_sql3) THEN
      LET l_sql3=" AND glap007 IN (",l_sql3,")"
   END IF 
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   
   #單頭所選核算項
   CALL aglq730_get_acc_filed() RETURNING l_str,l_str1,l_str2,l_str5,l_str6
   
   #判斷是否為自由核算項
   IF tm.fix_acc='15' OR tm.fix_acc='16' OR tm.fix_acc='17' OR tm.fix_acc='18' OR tm.fix_acc='19' OR
      tm.fix_acc='20' OR tm.fix_acc='21' OR tm.fix_acc='22' OR tm.fix_acc='23' OR tm.fix_acc='24' THEN
      LET l_flag_free_acc = TRUE 
   ELSE
      LET l_flag_free_acc = FALSE
   END IF
   
   #抓出所有符合條件的會計科目
   LET g_sql="SELECT DISTINCT glac002 FROM glac_t",
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' AND ",l_sql5,l_sql1,
             "   AND glac002 IN (SELECT glad001 FROM glad_t ",
             "                    WHERE gladent =",g_enterprise," AND gladld='",g_glaald,"' AND ",l_str5,
             "                   )",
             " ORDER BY glac002"
   PREPARE aglq730_glar001_pr FROM g_sql
   DECLARE aglq730_glar001_cr CURSOR FOR aglq730_glar001_pr
   #整期间且不跨年查询
   IF l_flag=TRUE AND tm.syear=tm.eyear THEN
      IF l_flag_free_acc = TRUE  THEN #自由核算項
         LET l_sql=" (SELECT DISTINCT ",l_str,",",l_str6,      #抓取核算項編號
                   "   FROM glar_t",
                   "   LEFT OUTER JOIN glad_t ON gladent=glarent AND gladld=glarld AND glad001=glar001",
                   "   LEFT OUTER JOIN glac_t ON glacent=glarent AND glac002=glar001 AND glac001='",g_glaa004,"'",
                   "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' "
      ELSE
         LET l_sql=" (SELECT DISTINCT ",l_str,    #抓取核算項編號
                   "   FROM glar_t",
                   "   LEFT OUTER JOIN glac_t ON glacent=glarent AND glac002=glar001 AND glac001='",g_glaa004,"'",
                   "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                   "    AND ",l_str," <> ' ' "
      END IF
      
      #發生額
      IF tm.stype='1' THEN 
         LET l_sql=l_sql," AND glar002=",tm.syear,
                         " AND glar003 BETWEEN ",tm.speriod," AND ",tm.eperiod
      ELSE  #累計額
         LET l_sql=l_sql," AND glar002=",tm.syear,
                         " AND glar003<=",tm.eperiod
      END IF
      LET l_sql=l_sql,l_sql1," AND ",g_wc,")"      
      #單據狀態      
      IF tm.stus MATCHES '[23]' THEN
         LET l_sql=l_sql," UNION ALL "
         IF l_flag_free_acc = TRUE  THEN #自由核算項
            LET l_sql=l_sql,"(SELECT DISTINCT ",l_str2,",",l_str6,
                           "    FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                           "    LEFT OUTER JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002",
                           "    LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                           "   WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' "
         ELSE            
            LET l_sql=l_sql,"(SELECT DISTINCT ",l_str2,
                           "    FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                           "    LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                           "   WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                           "    AND ",l_str1," <> ' ' "
         END IF
         
         #發生額
         IF tm.stype='1' THEN 
            LET l_sql=l_sql,"    AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
         ELSE  #累計額
            LET l_sql=l_sql,"    AND glapdocdt <='",tm.edate,"' AND glap002>=",tm.syear
         END IF
         CASE
             WHEN tm.stus='2'
                LET l_sql=l_sql," AND glapstus='Y'"
             WHEN tm.stus='3'
                LET l_sql=l_sql," AND glapstus IN ('Y','N')"
         END CASE
         LET l_sql=l_sql,l_sql1,l_sql2," AND ",l_wc," )"
      END IF
      
      #抓取核算項編號
      IF l_flag_free_acc = TRUE  THEN #自由核算項
         #10個自由核算項
         LET l_sql="SELECT DISTINCT ",l_str,",",l_str6,
                   "  FROM (",l_sql,")",
                   " ORDER BY ",l_str6,",",l_str
      ELSE
         #14個固定核算項
         LET l_sql="SELECT DISTINCT ",l_str,
                   "  FROM (",l_sql,")",
                   " ORDER BY ",l_str
      END IF
   ELSE
      IF l_flag_free_acc = TRUE  THEN #自由核算項
         LET l_sql="SELECT DISTINCT ",l_str1,",",l_str6,
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "  LEFT OUTER JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002",
                   "  LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' "
      ELSE
         LET l_sql="SELECT DISTINCT ",l_str1,
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "  LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "   AND ",l_str1," <> ' '"
      END IF
      
      #發生額
      IF tm.stype='1' THEN
         LET l_sql=l_sql,"   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
      ELSE  #累計額
         LET l_sql=l_sql,"   AND glapdocdt <='",tm.edate,"' AND glap002>=",tm.syear
      END IF
      LET l_sql=l_sql,l_sql1,l_sql2,l_sql4," AND ",l_wc," ORDER BY ",l_str1          
   END IF
   
   PREPARE aglq730_acc_pr FROM l_sql
   DECLARE aglq730_acc_cr CURSOR FOR aglq730_acc_pr   
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #160824-00004#4--add--str--
   #抓取該年第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   #160824-00004#4--add--end
   
   #科目編號
   LET l_i=1
   FOREACH aglq730_glar001_cr INTO g_glar001[l_i]
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','FOREACH aglq730_glar001_cr','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq730_glar001_cr'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      LET l_i=l_i+1
   END FOREACH
   LET l_i=l_i-1
   CALL g_glar001.deleteElement(g_glar001.getLength())
   IF l_i=0 THEN RETURN END IF
   
   #核算項編號
   LET l_j=1
   FOREACH aglq730_acc_cr INTO g_glar012[l_j].glar012,g_glar012[l_j].glad0171
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','FOREACH aglq730_acc_cr','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq730_acc_cr'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      LET l_j=l_j+1
      IF l_j>100 THEN
         EXIT FOREACH
      END IF
   END FOREACH
   LET l_j=l_j-1
   LET g_col=l_j
   CALL g_glar012.deleteElement(g_glar012.getLength())
   IF g_col=0 THEN RETURN END IF
   
   IF l_flag_free_acc = TRUE  THEN #自由核算項
      LET l_sql_free=" (SELECT DISTINCT glad001 FROM glad_t ",
                     "   WHERE gladent=",g_enterprise," AND gladld='",g_glaald,"' ",
                     "     AND ",l_str5,
                     "     AND ",l_str6," = ? )"
   END IF
   
   #發生額
   #整期間(借-貸)且狀態選擇1：已過帳，且没有跨年查询时
   LET l_sql="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar002=",tm.syear,
             "   AND glar003 BETWEEN ",tm.speriod," AND ",tm.eperiod," AND glar003<>0 ",
             "   AND glar001=? AND ",l_str,"=? "
   IF l_flag_free_acc = TRUE  THEN #自由核算項
      LET l_sql=l_sql," AND glar001 IN ",l_sql_free
   END IF
   PREPARE aglq730_sel_pr1 FROM l_sql
  
   #累計額
   #整期間(借-貸)且狀態選擇1：已過帳,且没有跨年查询时
   LET l_sql="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar001=? AND ",l_str,"=? ",
             "   AND glar002=",tm.syear,
             "   AND glar003<=",tm.eperiod," AND glar003<>0 "
   IF l_flag_free_acc = TRUE  THEN #自由核算項
      LET l_sql=l_sql," AND glar001 IN ",l_sql_free
   END IF
   PREPARE aglq730_sel_pr3 FROM l_sql

   
   #年初數
   LET l_sql="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar001=? AND ",l_str,"=? ",
             "   AND glar002=? AND glar003<=?"
   IF l_flag_free_acc = TRUE  THEN #自由核算項
      LET l_sql=l_sql," AND glar001 IN ",l_sql_free
   END IF
   PREPARE aglq730_sel_pr5 FROM l_sql

#160505-00007#15 add s----
   LET l_sql = " SELECT glac008 FROM glac_t ",
               "  WHERE glacent= '",g_enterprise,"' AND glac001= '",g_glaa004,"' AND glac002=? "
   PREPARE aglq730_pr_glac008 FROM l_sql 
#160505-00007#15 add e----    
   
   FOR l_i=1 TO g_glar001.getLength()
#160505-00007#15 mod s----   
#      SELECT glac008 INTO l_glac008 FROM glac_t
#       WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=g_glar001[l_i]
      EXECUTE aglq730_pr_glac008 USING g_glar001[l_i] INTO l_glac008
#160505-00007#15 mod e----       
      LET l_str3="glar001"
      LET l_str4="'",g_glar001[l_i],"'"
      
      #抓取科目对应的明细科目或者独立科目
      CALL s_voucher_get_glac_str(g_glaa004,g_glar001[l_i]) RETURNING l_glaq002
      
      #160824-00004#4--add--str--
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = "'",g_glar001[l_i],"'"
      END IF
      #160824-00004#4--add--end
      
      #151204-00013#3--add--str--
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
      END IF
      #151204-00013#3--add--end
      #当该统治科目没有下层明细科目时，抓取该科目本身资料
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = " AND glaq002 ='",g_glar001[l_i],"'"
      ELSE
         LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
      END IF
      
      FOR l_j=1 TO g_col
         #發生額
         IF tm.stype='1' THEN
            LET l_amt1 = 0
            LET l_amt2 = 0
            LET l_amt3 = 0
            IF l_flag=TRUE AND tm.syear=tm.eyear AND tm.stus='1' THEN
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr1 USING g_glar001[l_i],g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                           INTO l_amt1,l_amt2,l_amt3
               ELSE
                  EXECUTE aglq730_sel_pr1 USING g_glar001[l_i],g_glar012[l_j].glar012
                                           INTO l_amt1,l_amt2,l_amt3
               END IF
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq730_sel_pr1','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
#               IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#3 mark
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  #151204-00013#3 add
                  #發生額：抓取YE、AD憑證金額
                  LET l_sql="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                             "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                             " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                             "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                             l_glaq002," AND ",l_str1,"=? ",
                             l_sql3," AND glapstus='S'"
                  IF l_flag_free_acc = TRUE  THEN #自由核算項
                     LET l_sql=l_sql," AND glaq002 IN ",l_sql_free
                  END IF
                  PREPARE aglq730_sel_pr6 FROM l_sql                 
                  LET l_amt4 = 0
                  LET l_amt5 = 0
                  LET l_amt6 = 0
                  IF l_flag_free_acc = TRUE  THEN #自由核算項
                     EXECUTE aglq730_sel_pr6 USING g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                              INTO l_amt4,l_amt5,l_amt6
                  ELSE
                     EXECUTE aglq730_sel_pr6 USING g_glar012[l_j].glar012
                                              INTO l_amt4,l_amt5,l_amt6
                  END IF      
                  IF SQLCA.sqlcode THEN
#                     CALL cl_errmsg('','aglq730_sel_pr6','',SQLCA.sqlcode,1)
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq730_sel_pr6'
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
               #發生額
               #破期或狀態選擇2:含已審核或3：全部時發生額(借-貸)
               LET l_sql="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                          "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                          " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                          "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                          l_glaq002," AND ",l_str1,"=? ",
                          l_sql2,l_sql4
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  LET l_sql=l_sql," AND glaq002 IN ",l_sql_free
               END IF
               PREPARE aglq730_sel_pr2 FROM l_sql     
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr2 USING g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                           INTO l_amt1,l_amt2,l_amt3
               ELSE
                  EXECUTE aglq730_sel_pr2 USING g_glar012[l_j].glar012
                                           INTO l_amt1,l_amt2,l_amt3
               END IF
                
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq730_sel_pr2','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr2'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            END IF
            #151204-00013#3--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_sql="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                         "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         l_glaq002," AND ",l_str1,"=? ",
                         l_sql4,
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
#                         "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                         "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                         "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                         "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                         "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                         "                                               AND xcea001 BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         "                                     )",
                         "        )",
                         #160824-00004#4--add--end
                         "       )"
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  LET l_sql=l_sql," AND glaq002 IN ",l_sql_free
               END IF
               PREPARE aglq730_sel_pr6_1 FROM l_sql              
               LET l_amt4 = 0
               LET l_amt5 = 0
               LET l_amt6 = 0        
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr6_1 USING g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                           INTO l_amt4,l_amt5,l_amt6
               ELSE
                  EXECUTE aglq730_sel_pr6_1 USING g_glar012[l_j].glar012
                                           INTO l_amt4,l_amt5,l_amt6
               END IF
              
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr6_1'
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
            #151204-00013#3--add--end
         ELSE
            #累計額
            LET l_amt1 = 0
            LET l_amt2 = 0
            LET l_amt3 = 0
            LET l_amt4 = 0
            LET l_amt5 = 0
            LET l_amt6 = 0
            #整期且狀態=1：已過帳
            IF tm.edate=l_pdate_e2 AND tm.syear=tm.eyear AND tm.stus='1' THEN
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr3 USING g_glar001[l_i],g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                           INTO l_amt1,l_amt2,l_amt3
               ELSE
                  EXECUTE aglq730_sel_pr3 USING g_glar001[l_i],g_glar012[l_j].glar012
                                           INTO l_amt1,l_amt2,l_amt3
               END IF
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq730_sel_pr3','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr3'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
#               IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#3 mark
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#3 add                
                  #累計額：抓取YE、AD憑證金額
                  LET l_sql="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                            "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                            " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                            "   AND glapdocdt <= ? AND glap002>=? ",
                            l_glaq002," AND ",l_str1,"=? ",
                            l_sql3," AND glapstus='S'"
                  IF l_flag_free_acc = TRUE  THEN #自由核算項
                     LET l_sql=l_sql," AND glaq002 IN ",l_sql_free
                  END IF
                  PREPARE aglq730_sel_pr7 FROM l_sql
                  
                  IF l_flag_free_acc = TRUE  THEN #自由核算項
                     EXECUTE aglq730_sel_pr7 USING tm.edate,tm.syear,g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                           INTO l_amt4,l_amt5,l_amt6
                  ELSE
                     EXECUTE aglq730_sel_pr7 USING tm.edate,tm.syear,g_glar012[l_j].glar012
                                           INTO l_amt4,l_amt5,l_amt6
                  END IF
                 
                  IF SQLCA.sqlcode THEN
#                     CALL cl_errmsg('','aglq730_sel_pr7','',SQLCA.sqlcode,1)
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq730_sel_pr7'
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
               #累計額
               #破期或狀態選擇2:含已審核或3：全部時累計額(借-貸) 
               LET l_sql="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                         "   AND glapdocdt <= ? AND glap002>=? ",
                         l_glaq002," AND ",l_str1,"=? ",
                         l_sql2,l_sql4
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  LET l_sql=l_sql," AND glaq002 IN ",l_sql_free
               END IF
               PREPARE aglq730_sel_pr4 FROM l_sql
              
              #破期或者狀態-2：含已審核或3：全部
               LET l_period=0
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr5 USING g_glar001[l_i],g_glar012[l_j].glar012,tm.eyear,l_period,g_glar012[l_j].glad0171
                                           INTO l_amt1,l_amt2,l_amt3
               ELSE
                  EXECUTE aglq730_sel_pr5 USING g_glar001[l_i],g_glar012[l_j].glar012,tm.eyear,l_period
                                           INTO l_amt1,l_amt2,l_amt3
               END IF              
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq730_sel_pr5','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr5'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr4 USING tm.edate,tm.syear,g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                           INTO l_amt4,l_amt5,l_amt6
               ELSE
                  EXECUTE aglq730_sel_pr4 USING tm.edate,tm.syear,g_glar012[l_j].glar012
                                           INTO l_amt4,l_amt5,l_amt6
               END IF               
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq730_sel_pr4','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr4'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
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
            END IF
            #151204-00013#3--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN            
               LET l_sql="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                         "   AND glapdocdt <= ? AND glap002>=? ",
                         l_glaq002," AND ",l_str1,"=? ",
                         l_sql4,
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
#                         "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                         "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                         "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                         "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                         "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                         "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",tm.edate,"'",
                         "                                     )",
                         "        )",
                         #160824-00004#4--add--end
                         "       )"
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  LET l_sql=l_sql," AND glaq002 IN ",l_sql_free
               END IF
               PREPARE aglq730_sel_pr7_1 FROM l_sql  
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               IF l_flag_free_acc = TRUE  THEN #自由核算項
                  EXECUTE aglq730_sel_pr7_1 USING tm.edate,tm.syear,g_glar012[l_j].glar012,g_glar012[l_j].glad0171
                                            INTO l_amt4,l_amt5,l_amt6
               ELSE
                  EXECUTE aglq730_sel_pr7_1 USING tm.edate,tm.syear,g_glar012[l_j].glar012
                                            INTO l_amt4,l_amt5,l_amt6
               END IF              
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq730_sel_pr7'
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
            #151204-00013#3--add--end
         END IF
         
         IF l_glac008='2' THEN
            LET l_amt1=(-1)*l_amt1
            LET l_amt2=(-1)*l_amt2
            LET l_amt3=(-1)*l_amt3
         END IF
         
         LET l_str3=l_str3,",amt",l_j USING '<<<',"1",
                           ",amt",l_j USING '<<<',"2",
                           ",amt",l_j USING '<<<',"3"
         LET l_str4=l_str4,",",l_amt1,",",l_amt2,",",l_amt3
      END FOR
       
      LET g_sql="INSERT INTO aglq730_tmp (",l_str3,")",
                " VALUES (",l_str4,")"
      PREPARE aglq730_ins_tmp FROM g_sql
      EXECUTE aglq730_ins_tmp
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','ins aglq730_tmp','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'ins aglq730_tmp'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
   END FOR
   
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq730_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 獲取核算項對應的字段名
# Memo...........:
# Usage..........: CALL aglq730_get_acc_filed()
#                  RETURNING r_str,r_str1
# Return code....: r_str     glar_t表中對應核算項字段名
#                : r_str1    glaq_t表中對應核算項字段名
# Date & Author..: 2014/3/27 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_get_acc_filed()
   DEFINE r_str,r_str1,r_str2,r_str3,r_str4  STRING
   
   LET r_str4="''"
   CASE
      WHEN tm.fix_acc='1' 
         LET r_str="glar012"
         LET r_str1="glaq017"
         LET r_str2="glaq017 glar012"
         LET r_str3=" 1=1"
      WHEN tm.fix_acc='2' 
         LET r_str="glar013"
         LET r_str1="glaq018" 
         LET r_str2="glaq018 glar013" 
         LET r_str3=" glad007='Y' "         
      WHEN tm.fix_acc='3' 
         LET r_str="glar014"
         LET r_str1="glaq019"
         LET r_str2="glaq019 glar014"
         LET r_str3=" glad008='Y' "
      WHEN tm.fix_acc='4' 
         LET r_str="glar015"
         LET r_str1="glaq020"
         LET r_str2="glaq020 glar015"
         LET r_str3=" glad009='Y' "
      WHEN tm.fix_acc='5' 
         LET r_str="glar016"
         LET r_str1="glaq021"
         LET r_str2="glaq021 glar016"
         LET r_str3=" glad010='Y' "
      WHEN tm.fix_acc='6' 
         LET r_str="glar017"
         LET r_str1="glaq022" 
         LET r_str2="glaq022 glar017" 
         LET r_str3=" glad027='Y' "
      WHEN tm.fix_acc='7' 
         LET r_str="glar018"
         LET r_str1="glaq023"
         LET r_str2="glaq023 glar018"
         LET r_str3=" glad011='Y' "
      WHEN tm.fix_acc='8' 
         LET r_str="glar019"
         LET r_str1="glaq024"
         LET r_str2="glaq024 glar019"
         LET r_str3=" glad012='Y' "
      #經營方式
      WHEN tm.fix_acc='9' 
         LET r_str="glar051"
         LET r_str1="glaq051"
         LET r_str2="glaq051 glar051"
         LET r_str3=" glad031='Y' "
      #渠道
      WHEN tm.fix_acc='10' 
         LET r_str="glar052"
         LET r_str1="glaq052"
         LET r_str2="glaq052 glar052"
         LET r_str3=" glad032='Y' "
      #品牌
      WHEN tm.fix_acc='11' 
         LET r_str="glar053"
         LET r_str1="glaq053"
         LET r_str2="glaq053 glar053"
         LET r_str3=" glad033='Y' "
      WHEN tm.fix_acc='12' 
         LET r_str="glar020"
         LET r_str1="glaq025"
         LET r_str2="glaq025 glar020"
         LET r_str3=" glad013='Y' "
#      WHEN tm.fix_acc='10' 
#         LET r_str="glar021"
#         LET r_str1="glaq026"
#         LET r_str2="glaq026 glar021"
      WHEN tm.fix_acc='13' 
         LET r_str="glar022"
         LET r_str1="glaq027"
         LET r_str2="glaq027 glar022"
         LET r_str3=" glad015='Y' "
      WHEN tm.fix_acc='14' 
         LET r_str="glar023"
         LET r_str1="glaq028" 
         LET r_str2="glaq028 glar023"
         LET r_str3=" glad016='Y' "
      WHEN tm.fix_acc='15' 
         LET r_str="glar024"
         LET r_str1="glaq029" 
         LET r_str2="glaq029 glar024"
         LET r_str3=" glad017='Y' "
         LET r_str4="glad0171"
      WHEN tm.fix_acc='16' 
         LET r_str="glar025"
         LET r_str1="glaq030" 
         LET r_str2="glaq030 glar025"
         LET r_str3=" glad018='Y' "
         LET r_str4="glad0181"
      WHEN tm.fix_acc='17' 
         LET r_str="glar026"
         LET r_str1="glaq031" 
         LET r_str2="glaq031 glar026"
         LET r_str3=" glad019='Y' "
         LET r_str4="glad0191"
      WHEN tm.fix_acc='18' 
         LET r_str="glar027"
         LET r_str1="glaq032" 
         LET r_str2="glaq032 glar027"
         LET r_str3=" glad020='Y' "
         LET r_str4="glad0201"
      WHEN tm.fix_acc='19' 
         LET r_str="glar028"
         LET r_str1="glaq033" 
         LET r_str2="glaq033 glar028"
         LET r_str3=" glad021='Y' "
         LET r_str4="glad0211"
      WHEN tm.fix_acc='20' 
         LET r_str="glar029"
         LET r_str1="glaq034" 
         LET r_str2="glaq034 glar029"
         LET r_str3=" glad022='Y' "
         LET r_str4="glad0221"
      WHEN tm.fix_acc='21' 
         LET r_str="glar030"
         LET r_str1="glaq035" 
         LET r_str2="glaq035 glar030"
         LET r_str3=" glad023='Y' "
         LET r_str4="glad0231"
      WHEN tm.fix_acc='22' 
         LET r_str="glar031"
         LET r_str1="glaq036" 
         LET r_str2="glaq036 glar031"
         LET r_str3=" glad024='Y' "
         LET r_str4="glad0241"
      WHEN tm.fix_acc='23' 
         LET r_str="glar032"
         LET r_str1="glaq037" 
         LET r_str2="glaq037 glar032"
         LET r_str3=" glad025='Y' "
         LET r_str4="glad0251"
      WHEN tm.fix_acc='24' 
         LET r_str="glar033"
         LET r_str1="glaq038" 
         LET r_str2="glaq038 glar033"
         LET r_str3=" glad026='Y' "
         LET r_str4="glad0261"
   END CASE
   RETURN r_str,r_str1,r_str2,r_str3,r_str4
END FUNCTION
################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq730_show()
# Date & Author..:  2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_show()
   DEFINE l_i   LIKE type_t.num5
   DEFINE l_str STRING
   
   DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.ctype,tm.fix_acc,tm.stype,
           tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           sdate,syear,speriod,edate,eyear,eperiod,ctype,fix_acc,stype,
           show_acc,glac005,stus,glac009,show_ad,show_ce,show_ye
   #隱藏單身中核算項欄位
   FOR l_i=1 TO g_col
       LET l_str="amt",l_i USING '<<<',"1,",
                 "amt",l_i USING '<<<',"2,",
                 "amt",l_i USING '<<<',"3"
       CALL cl_set_comp_visible(l_str,FALSE)
   END FOR
   #隐藏合计栏位
   CALL cl_set_comp_visible('sum1,sum2,sum3',FALSE)  #150827-00036#15 add
END FUNCTION

################################################################################
# Descriptions...: 獲取核算項說明并顯示在單身欄位說明
# Memo...........:
# Usage..........: CALL aglq730_acc_name()
# Date & Author..: 2014/3/27 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_acc_name()
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_j       LIKE type_t.num5
   DEFINE l_str     STRING
   DEFINE l_str1    STRING
   DEFINE l_str2    STRING
   DEFINE l_str3    STRING
   DEFINE l_str4    STRING
   
   LET l_str3=cl_getmsg("axr-00092",g_lang)
   LET l_str3=l_str3.subString(2,l_str3.getLength()) #(本位幣二)
   LET l_str4=cl_getmsg("axr-00093",g_lang)
   LET l_str4=l_str4.subString(2,l_str4.getLength()) #(本位幣三)
   
   LET l_j = 3
   FOR l_i=1 TO g_glar012.getLength()
      #核算項說明
      CALL aglq730_fix_acc_desc(g_glar012[l_i].glar012,g_glar012[l_i].glad0171) RETURNING l_str
      IF cl_null(l_str) THEN
         LET l_str="  "
      END IF
      #本位幣一
      LET l_str1="amt",l_i USING '<<<',"1"
      CALL cl_set_comp_att_text(l_str1,l_str)
     #LET g_xg_fieldname[l_i + 2] = l_str    #130726-00001#95 Add
      LET g_xg_fieldname[l_j] = l_str    #yangtt---15/6/10
      LET l_j = l_j + 1                  #yangtt---15/6/10
       
      #本位幣二
      LET l_str1="amt",l_i USING '<<<',"2"
      LET l_str2=l_str,l_str3 
      CALL cl_set_comp_att_text(l_str1,l_str2) 
     #LET g_xg_fieldname[l_i + 3] = l_str2   #130726-00001#95 Add
      LET g_xg_fieldname[l_j] = l_str2   #yangtt---15/6/10
      LET l_j = l_j + 1                  #yangtt---15/6/10
      
      #本位幣三
      LET l_str1="amt",l_i USING '<<<',"3"
      LET l_str2=l_str,l_str4 
      CALL cl_set_comp_att_text(l_str1,l_str2)      
     #LET g_xg_fieldname[l_i + 4] = l_str3   #130726-00001#95 Add
      LET g_xg_fieldname[l_j] = l_str2   #yangtt---15/6/10
      LET l_j = l_j + 1                  #yangtt---15/6/10
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 設置單身核算項欄位顯示
# Memo...........:
# Usage..........: CALL aglq730_set_acc_visible()
# Date & Author..: 2014/3/27 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_set_acc_visible()
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_str     STRING
   DEFINE l_str1    STRING
   DEFINE l_str2    STRING
   
   #150827-00036#15--add--str--
   #是否顯示合計欄位
   IF g_col = 0 THEN 
      CALL cl_set_comp_visible('sum1,sum2,sum3',FALSE)
   ELSE
      CALL cl_set_comp_visible('sum1',TRUE)
      #本位幣二
      IF tm.ctype='1' OR tm.ctype='3' THEN
         CALL cl_set_comp_visible('sum2',TRUE)
      ELSE
         CALL cl_set_comp_visible('sum2',FALSE)
      END IF
      #本位幣三
      IF tm.ctype='2' OR tm.ctype='3' THEN
         CALL cl_set_comp_visible('sum3',TRUE)
      ELSE
         CALL cl_set_comp_visible('sum3',FALSE)
      END IF
   END IF
   #150827-00036#15--add--end
   
   #核算項顯示列數
   FOR l_i=1 TO g_col
       IF l_i=1 THEN
          LET l_str="amt",l_i USING '<<<',"1"
          LET l_str1="amt",l_i USING '<<<',"2"
          LET l_str2="amt",l_i USING '<<<',"3"
       ELSE
          LET l_str=l_str,",amt",l_i USING '<<<',"1"
          LET l_str1=l_str1,",amt",l_i USING '<<<',"2"
          LET l_str2=l_str2,",amt",l_i USING '<<<',"3"
       END IF
   END FOR
   CALL cl_set_comp_visible(l_str,TRUE)
   #本位幣二
   IF tm.ctype='1' OR tm.ctype='3' THEN
      CALL cl_set_comp_visible(l_str1,TRUE)
   ELSE
      CALL cl_set_comp_visible(l_str1,FALSE)
   END IF
   #本位幣三
   IF tm.ctype='2' OR tm.ctype='3' THEN
      CALL cl_set_comp_visible(l_str2,TRUE)
   ELSE
      CALL cl_set_comp_visible(l_str2,FALSE)
   END IF
   #核算項隱藏列數
   FOR l_i=g_col+1 TO 100
       LET l_str="amt",l_i USING '<<<',"1,",
                 "amt",l_i USING '<<<',"2,",
                 "amt",l_i USING '<<<',"3"
       CALL cl_set_comp_visible(l_str,FALSE)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 獲取核算項說明
# Memo...........:
# Usage..........: CALL aglq730_fix_acc_desc(p_acc,p_glad0171)
#                  RETURNING r_desc
# Input parameter: p_acc     核算項編號
#                : p_glad0171核算項類型
# Return code....: r_desc    說明
# Date & Author..: 2014/3/27 By 02599
# Modify.........: 加核算項類型
################################################################################
PRIVATE FUNCTION aglq730_fix_acc_desc(p_acc,p_glad0171)
   DEFINE p_acc          LIKE type_t.chr30
   DEFINE p_glad0171     LIKE glad_t.glad0171
   DEFINE l_ooag011      LIKE ooag_t.ooag011
   DEFINE r_desc         STRING
   
   LET r_desc=''
   CASE tm.fix_acc
      #營運據點
      WHEN '1'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]
      
      #部門
      WHEN '2'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]

      #成本中心
      WHEN '3'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]

      #區域
      WHEN '4'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = '287'
         LET g_ref_fields[2] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1] 
      
      #交易客戶
      WHEN '5'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]
      
      #帳款客戶
      WHEN '6'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]
      
      #客群   
      WHEN '7'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = '281'
         LET g_ref_fields[2] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1] 
      
      #產品類別
      WHEN '8'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]
         
      #經營方式
      WHEN '9'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = '6013'
         LET g_ref_fields[2] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]
      
      #渠道
      WHEN '10'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1]
       
      #品牌   
      WHEN '11'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = '2002'
         LET g_ref_fields[2] = p_acc
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_desc=g_rtn_fields[1] 
         
      #人員編號
      WHEN '12'
         SELECT ooag011 INTO l_ooag011 FROM ooag_t 
          WHERE ooagent = g_enterprise AND ooag001 = p_acc
         LET r_desc=l_ooag011 
#      #預算編號
#      WHEN '10'
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = p_acc
#         CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET r_desc=g_rtn_fields[1]  
      #专案   
      WHEN '13'
         CALL s_desc_get_project_desc(p_acc) RETURNING r_desc
      #WBS
      WHEN '14'
         CALL s_desc_get_wbs_desc('',p_acc) RETURNING r_desc
   END CASE
   #自由核算項
   IF tm.fix_acc='15' OR tm.fix_acc='16' OR tm.fix_acc='17' OR tm.fix_acc='18' OR tm.fix_acc='19' OR
      tm.fix_acc='20' OR tm.fix_acc='21' OR tm.fix_acc='22' OR tm.fix_acc='23' OR tm.fix_acc='24' THEN
      CALL s_voucher_free_account_desc(p_glad0171,p_acc) RETURNING r_desc
   END IF
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: CALL aglq730_b_fill1()
# Date & Author..: 2014/3/27 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq730_b_fill1()
   #150827-00036#15--add--str--
   DEFINE l_sql                STRING
   DEFINE l_i                  LIKE type_t.num5
   DEFINE l_str,l_str1,l_str2  STRING
   DEFINE l_sum1               LIKE glaq_t.glaq003
   DEFINE l_sum2               LIKE glaq_t.glaq003
   DEFINE l_sum3               LIKE glaq_t.glaq003
   DEFINE l_sum_glar           type_g_glar_d
   DEFINE l_cnt                LIKE type_t.num5
   #150827-00036#15--add--end

#160505-00007#15 mod s------
#   LET g_sql = "SELECT UNIQUE glar001,'',",
   LET g_sql = "SELECT UNIQUE glar001,",
               " (SELECT glacl004 FROM glacl_t WHERE glaclent='",g_enterprise,"' AND glacl001 = '",g_glaa004,"' AND glacl002 = glar001 AND glacl003='",g_dlang,"'),", #160711-00030#1 add ','
#160505-00007#15 mod e------               
               "       amt11,amt12,amt13,    amt21,amt22,amt23,    amt31,amt32,amt33,    amt41,amt42,amt43,    amt51,amt52,amt53,",
               "       amt61,amt62,amt63,    amt71,amt72,amt73,    amt81,amt82,amt83,    amt91,amt92,amt93,    amt101,amt102,amt103,",
               "       amt111,amt112,amt113, amt121,amt122,amt123, amt131,amt132,amt133, amt141,amt142,amt143, amt151,amt152,amt153,",
               "       amt161,amt162,amt163, amt171,amt172,amt173, amt181,amt182,amt183, amt191,amt192,amt193, amt201,amt202,amt203,",
               "       amt211,amt212,amt213, amt221,amt222,amt223, amt231,amt232,amt233, amt241,amt242,amt243, amt251,amt252,amt253,",
               "       amt261,amt262,amt263, amt271,amt272,amt273, amt281,amt282,amt283, amt291,amt292,amt293, amt301,amt302,amt303,",
               "       amt311,amt312,amt313, amt321,amt322,amt323, amt331,amt332,amt333, amt341,amt342,amt243, amt351,amt352,amt353,",
               "       amt361,amt362,amt363, amt371,amt372,amt373, amt381,amt382,amt383, amt391,amt392,amt293, amt401,amt402,amt403,",
               "       amt411,amt412,amt413, amt421,amt422,amt423, amt431,amt432,amt433, amt441,amt442,amt443, amt451,amt452,amt453,",
               "       amt461,amt462,amt463, amt471,amt472,amt473, amt481,amt482,amt483, amt491,amt492,amt493, amt501,amt502,amt503,",
               "       amt511,amt512,amt513, amt521,amt522,amt523, amt531,amt532,amt533, amt541,amt542,amt543, amt551,amt552,amt553,",
               "       amt561,amt562,amt563, amt571,amt572,amt573, amt581,amt582,amt583, amt591,amt592,amt593, amt601,amt602,amt603,",
               "       amt611,amt612,amt613, amt621,amt622,amt623, amt631,amt632,amt633, amt641,amt642,amt643, amt651,amt652,amt653,",
               "       amt661,amt662,amt663, amt671,amt672,amt673, amt681,amt682,amt683, amt691,amt692,amt693, amt701,amt702,amt703,",
               "       amt711,amt712,amt713, amt721,amt722,amt723, amt731,amt732,amt733, amt741,amt742,amt743, amt751,amt752,amt753,",
               "       amt761,amt762,amt763, amt771,amt772,amt773, amt781,amt782,amt783, amt791,amt792,amt793, amt801,amt802,amt803,",
               "       amt811,amt812,amt813, amt821,amt822,amt823, amt831,amt832,amt833, amt841,amt842,amt843, amt851,amt852,amt853,",
               "       amt861,amt862,amt863, amt871,amt872,amt873, amt881,amt882,amt883, amt891,amt892,amt893, amt901,amt902,amt903,",
               "       amt911,amt912,amt913, amt921,amt922,amt923, amt931,amt932,amt933, amt941,amt942,amt943, amt951,amt952,amt953,",
               "       amt961,amt962,amt963, amt971,amt972,amt973, amt981,amt982,amt983, amt991,amt992,amt993, amt1001,amt1002,amt1003",
               #"  FROM aglq730_tmp ORDER BY glar001 "
               "  FROM aglq730_tmp ", #160302-00006#1  ADD by 07675
               "   WHERE 1=1 "      #160302-00006#1  ADD by 07675
   LET g_sql = g_sql, " AND ",g_wc_filter #160302-00006#1 ADD by 07675
   LET g_sql = g_sql," ORDER BY glar001 "#160302-00006#1 ADD by 07675
   PREPARE aglq730_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq730_pb1

#160505-00007#15 add s------
   LET g_sql =" SELECT COUNT(*) FROM glac_t ", 
              "  WHERE glac002=glac004 ",
              "    AND glacent='",g_enterprise,"' AND glac001='",g_glaa004,"'",
              "    AND glac002=? "
   PREPARE aglq730_pb2 FROM g_sql           
#160505-00007#15 add e------

   #150827-00036#15--add--str--
   #合計
   #最右边一列合计
   FOR l_i=1 TO g_col
     IF l_i=1 THEN
        LET l_str="amt",l_i USING '<<<',"1"
        LET l_str1="amt",l_i USING '<<<',"2"
        LET l_str2="amt",l_i USING '<<<',"3"
     ELSE
        LET l_str=l_str,"+amt",l_i USING '<<<',"1"
        LET l_str1=l_str1,"+amt",l_i USING '<<<',"2"
        LET l_str2=l_str2,"+amt",l_i USING '<<<',"3"
     END IF
   END FOR
   LET l_sql="SELECT SUM(",l_str,"),SUM(",l_str1,"),SUM(",l_str2,")",
             "  FROM aglq730_tmp ",
             " WHERE glar001=? "
   PREPARE aglq730_sum_pr FROM l_sql
   
   #最下边一行合计
   LET l_sql = "SELECT ",
               "       SUM(amt11),SUM(amt12),SUM(amt13),    SUM(amt21),SUM(amt22),SUM(amt23),    SUM(amt31),SUM(amt32),SUM(amt33),    SUM(amt41),SUM(amt42),SUM(amt43),    SUM(amt51),SUM(amt52),SUM(amt53),",
               "       SUM(amt61),SUM(amt62),SUM(amt63),    SUM(amt71),SUM(amt72),SUM(amt73),    SUM(amt81),SUM(amt82),SUM(amt83),    SUM(amt91),SUM(amt92),SUM(amt93),    SUM(amt101),SUM(amt102),SUM(amt103),",
               "       SUM(amt111),SUM(amt112),SUM(amt113), SUM(amt121),SUM(amt122),SUM(amt123), SUM(amt131),SUM(amt132),SUM(amt133), SUM(amt141),SUM(amt142),SUM(amt143), SUM(amt151),SUM(amt152),SUM(amt153),",
               "       SUM(amt161),SUM(amt162),SUM(amt163), SUM(amt171),SUM(amt172),SUM(amt173), SUM(amt181),SUM(amt182),SUM(amt183), SUM(amt191),SUM(amt192),SUM(amt193), SUM(amt201),SUM(amt202),SUM(amt203),",
               "       SUM(amt211),SUM(amt212),SUM(amt213), SUM(amt221),SUM(amt222),SUM(amt223), SUM(amt231),SUM(amt232),SUM(amt233), SUM(amt241),SUM(amt242),SUM(amt243), SUM(amt251),SUM(amt252),SUM(amt253),",
               "       SUM(amt261),SUM(amt262),SUM(amt263), SUM(amt271),SUM(amt272),SUM(amt273), SUM(amt281),SUM(amt282),SUM(amt283), SUM(amt291),SUM(amt292),SUM(amt293), SUM(amt301),SUM(amt302),SUM(amt303),",
               "       SUM(amt311),SUM(amt312),SUM(amt313), SUM(amt321),SUM(amt322),SUM(amt323), SUM(amt331),SUM(amt332),SUM(amt333), SUM(amt341),SUM(amt342),SUM(amt243), SUM(amt351),SUM(amt352),SUM(amt353),",
               "       SUM(amt361),SUM(amt362),SUM(amt363), SUM(amt371),SUM(amt372),SUM(amt373), SUM(amt381),SUM(amt382),SUM(amt383), SUM(amt391),SUM(amt392),SUM(amt293), SUM(amt401),SUM(amt402),SUM(amt403),",
               "       SUM(amt411),SUM(amt412),SUM(amt413), SUM(amt421),SUM(amt422),SUM(amt423), SUM(amt431),SUM(amt432),SUM(amt433), SUM(amt441),SUM(amt442),SUM(amt443), SUM(amt451),SUM(amt452),SUM(amt453),",
               "       SUM(amt461),SUM(amt462),SUM(amt463), SUM(amt471),SUM(amt472),SUM(amt473), SUM(amt481),SUM(amt482),SUM(amt483), SUM(amt491),SUM(amt492),SUM(amt493), SUM(amt501),SUM(amt502),SUM(amt503),",
               "       SUM(amt511),SUM(amt512),SUM(amt513), SUM(amt521),SUM(amt522),SUM(amt523), SUM(amt531),SUM(amt532),SUM(amt533), SUM(amt541),SUM(amt542),SUM(amt543), SUM(amt551),SUM(amt552),SUM(amt553),",
               "       SUM(amt561),SUM(amt562),SUM(amt563), SUM(amt571),SUM(amt572),SUM(amt573), SUM(amt581),SUM(amt582),SUM(amt583), SUM(amt591),SUM(amt592),SUM(amt593), SUM(amt601),SUM(amt602),SUM(amt603),",
               "       SUM(amt611),SUM(amt612),SUM(amt613), SUM(amt621),SUM(amt622),SUM(amt623), SUM(amt631),SUM(amt632),SUM(amt633), SUM(amt641),SUM(amt642),SUM(amt643), SUM(amt651),SUM(amt652),SUM(amt653),",
               "       SUM(amt661),SUM(amt662),SUM(amt663), SUM(amt671),SUM(amt672),SUM(amt673), SUM(amt681),SUM(amt682),SUM(amt683), SUM(amt691),SUM(amt692),SUM(amt693), SUM(amt701),SUM(amt702),SUM(amt703),",
               "       SUM(amt711),SUM(amt712),SUM(amt713), SUM(amt721),SUM(amt722),SUM(amt723), SUM(amt731),SUM(amt732),SUM(amt733), SUM(amt741),SUM(amt742),SUM(amt743), SUM(amt751),SUM(amt752),SUM(amt753),",
               "       SUM(amt761),SUM(amt762),SUM(amt763), SUM(amt771),SUM(amt772),SUM(amt773), SUM(amt781),SUM(amt782),SUM(amt783), SUM(amt791),SUM(amt792),SUM(amt793), SUM(amt801),SUM(amt802),SUM(amt803),",
               "       SUM(amt811),SUM(amt812),SUM(amt813), SUM(amt821),SUM(amt822),SUM(amt823), SUM(amt831),SUM(amt832),SUM(amt833), SUM(amt841),SUM(amt842),SUM(amt843), SUM(amt851),SUM(amt852),SUM(amt853),",
               "       SUM(amt861),SUM(amt862),SUM(amt863), SUM(amt871),SUM(amt872),SUM(amt873), SUM(amt881),SUM(amt882),SUM(amt883), SUM(amt891),SUM(amt892),SUM(amt893), SUM(amt901),SUM(amt902),SUM(amt903),",
               "       SUM(amt911),SUM(amt912),SUM(amt913), SUM(amt921),SUM(amt922),SUM(amt923), SUM(amt931),SUM(amt932),SUM(amt933), SUM(amt941),SUM(amt942),SUM(amt943), SUM(amt951),SUM(amt952),SUM(amt953),",
               "       SUM(amt961),SUM(amt962),SUM(amt963), SUM(amt971),SUM(amt972),SUM(amt973), SUM(amt981),SUM(amt982),SUM(amt983), SUM(amt991),SUM(amt992),SUM(amt993), SUM(amt1001),SUM(amt1002),SUM(amt1003)",
               "  FROM aglq730_tmp "
   #勾选统治科目时，抓取最上次统治科目+独立科目金额。反之，抓取的是明细科目+独立科目金额
   IF tm.show_acc = 'Y' THEN
      LET l_sql=l_sql," WHERE glar001 IN (SELECT glac002 FROM glac_t ",
                      "                   WHERE glac002=glac004 AND glacent=",g_enterprise," AND glac001='",g_glaa004,"')"
   END IF
   PREPARE aglq730_sum_pr1 FROM l_sql

   LET l_sum1=0
   LET l_sum2=0
   LET l_sum3=0
   #150827-00036#15--add--end
   
   CALL g_glar_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc, 
       g_glar_d[l_ac].amt11,g_glar_d[l_ac].amt12,g_glar_d[l_ac].amt13,g_glar_d[l_ac].amt21,g_glar_d[l_ac].amt22,
       g_glar_d[l_ac].amt23,g_glar_d[l_ac].amt31,g_glar_d[l_ac].amt32,g_glar_d[l_ac].amt33,g_glar_d[l_ac].amt41,
       g_glar_d[l_ac].amt42,g_glar_d[l_ac].amt43,g_glar_d[l_ac].amt51,g_glar_d[l_ac].amt52,g_glar_d[l_ac].amt53,
       g_glar_d[l_ac].amt61,g_glar_d[l_ac].amt62,g_glar_d[l_ac].amt63,g_glar_d[l_ac].amt71,g_glar_d[l_ac].amt72,
       g_glar_d[l_ac].amt73,g_glar_d[l_ac].amt81,g_glar_d[l_ac].amt82,g_glar_d[l_ac].amt83,g_glar_d[l_ac].amt91,
       g_glar_d[l_ac].amt92,g_glar_d[l_ac].amt93,g_glar_d[l_ac].amt101,g_glar_d[l_ac].amt102,g_glar_d[l_ac].amt103,
       g_glar_d[l_ac].amt111,g_glar_d[l_ac].amt112,g_glar_d[l_ac].amt113,g_glar_d[l_ac].amt121,g_glar_d[l_ac].amt122,
       g_glar_d[l_ac].amt123,g_glar_d[l_ac].amt131,g_glar_d[l_ac].amt132,g_glar_d[l_ac].amt133,g_glar_d[l_ac].amt141,
       g_glar_d[l_ac].amt142,g_glar_d[l_ac].amt143,g_glar_d[l_ac].amt151,g_glar_d[l_ac].amt152,g_glar_d[l_ac].amt153,
       g_glar_d[l_ac].amt161,g_glar_d[l_ac].amt162,g_glar_d[l_ac].amt163,g_glar_d[l_ac].amt171,g_glar_d[l_ac].amt172,
       g_glar_d[l_ac].amt173,g_glar_d[l_ac].amt181,g_glar_d[l_ac].amt182,g_glar_d[l_ac].amt183,g_glar_d[l_ac].amt191,
       g_glar_d[l_ac].amt192,g_glar_d[l_ac].amt193,g_glar_d[l_ac].amt201,g_glar_d[l_ac].amt202,g_glar_d[l_ac].amt203,
       g_glar_d[l_ac].amt211,g_glar_d[l_ac].amt212,g_glar_d[l_ac].amt213,g_glar_d[l_ac].amt221,g_glar_d[l_ac].amt222,
       g_glar_d[l_ac].amt223,g_glar_d[l_ac].amt231,g_glar_d[l_ac].amt232,g_glar_d[l_ac].amt233,g_glar_d[l_ac].amt241,
       g_glar_d[l_ac].amt242,g_glar_d[l_ac].amt243,g_glar_d[l_ac].amt251,g_glar_d[l_ac].amt252,g_glar_d[l_ac].amt253,
       g_glar_d[l_ac].amt261,g_glar_d[l_ac].amt262,g_glar_d[l_ac].amt263,g_glar_d[l_ac].amt271,g_glar_d[l_ac].amt272,
       g_glar_d[l_ac].amt273,g_glar_d[l_ac].amt281,g_glar_d[l_ac].amt282,g_glar_d[l_ac].amt283,g_glar_d[l_ac].amt291,
       g_glar_d[l_ac].amt292,g_glar_d[l_ac].amt293,g_glar_d[l_ac].amt301,g_glar_d[l_ac].amt302,g_glar_d[l_ac].amt303,
       g_glar_d[l_ac].amt311,g_glar_d[l_ac].amt312,g_glar_d[l_ac].amt313,g_glar_d[l_ac].amt321,g_glar_d[l_ac].amt322,
       g_glar_d[l_ac].amt323,g_glar_d[l_ac].amt331,g_glar_d[l_ac].amt332,g_glar_d[l_ac].amt333,g_glar_d[l_ac].amt341,
       g_glar_d[l_ac].amt342,g_glar_d[l_ac].amt343,g_glar_d[l_ac].amt351,g_glar_d[l_ac].amt352,g_glar_d[l_ac].amt353,
       g_glar_d[l_ac].amt361,g_glar_d[l_ac].amt362,g_glar_d[l_ac].amt363,g_glar_d[l_ac].amt371,g_glar_d[l_ac].amt372,
       g_glar_d[l_ac].amt373,g_glar_d[l_ac].amt381,g_glar_d[l_ac].amt382,g_glar_d[l_ac].amt383,g_glar_d[l_ac].amt391,
       g_glar_d[l_ac].amt392,g_glar_d[l_ac].amt393,g_glar_d[l_ac].amt401,g_glar_d[l_ac].amt402,g_glar_d[l_ac].amt403,
       g_glar_d[l_ac].amt411,g_glar_d[l_ac].amt412,g_glar_d[l_ac].amt413,g_glar_d[l_ac].amt421,g_glar_d[l_ac].amt422,
       g_glar_d[l_ac].amt423,g_glar_d[l_ac].amt431,g_glar_d[l_ac].amt432,g_glar_d[l_ac].amt433,g_glar_d[l_ac].amt441,
       g_glar_d[l_ac].amt442,g_glar_d[l_ac].amt443,g_glar_d[l_ac].amt451,g_glar_d[l_ac].amt452,g_glar_d[l_ac].amt453,
       g_glar_d[l_ac].amt461,g_glar_d[l_ac].amt462,g_glar_d[l_ac].amt463,g_glar_d[l_ac].amt471,g_glar_d[l_ac].amt472,
       g_glar_d[l_ac].amt473,g_glar_d[l_ac].amt481,g_glar_d[l_ac].amt482,g_glar_d[l_ac].amt483,g_glar_d[l_ac].amt491,
       g_glar_d[l_ac].amt492,g_glar_d[l_ac].amt493,g_glar_d[l_ac].amt501,g_glar_d[l_ac].amt502,g_glar_d[l_ac].amt503,
       g_glar_d[l_ac].amt511,g_glar_d[l_ac].amt512,g_glar_d[l_ac].amt513,g_glar_d[l_ac].amt521,g_glar_d[l_ac].amt522,
       g_glar_d[l_ac].amt523,g_glar_d[l_ac].amt531,g_glar_d[l_ac].amt532,g_glar_d[l_ac].amt533,g_glar_d[l_ac].amt541,
       g_glar_d[l_ac].amt542,g_glar_d[l_ac].amt543,g_glar_d[l_ac].amt551,g_glar_d[l_ac].amt552,g_glar_d[l_ac].amt553,
       g_glar_d[l_ac].amt561,g_glar_d[l_ac].amt562,g_glar_d[l_ac].amt563,g_glar_d[l_ac].amt571,g_glar_d[l_ac].amt572,
       g_glar_d[l_ac].amt573,g_glar_d[l_ac].amt581,g_glar_d[l_ac].amt582,g_glar_d[l_ac].amt583,g_glar_d[l_ac].amt591,
       g_glar_d[l_ac].amt592,g_glar_d[l_ac].amt593,g_glar_d[l_ac].amt601,g_glar_d[l_ac].amt602,g_glar_d[l_ac].amt603,
       g_glar_d[l_ac].amt611,g_glar_d[l_ac].amt612,g_glar_d[l_ac].amt613,g_glar_d[l_ac].amt621,g_glar_d[l_ac].amt622,
       g_glar_d[l_ac].amt623,g_glar_d[l_ac].amt631,g_glar_d[l_ac].amt632,g_glar_d[l_ac].amt633,g_glar_d[l_ac].amt641,
       g_glar_d[l_ac].amt642,g_glar_d[l_ac].amt643,g_glar_d[l_ac].amt651,g_glar_d[l_ac].amt652,g_glar_d[l_ac].amt653,
       g_glar_d[l_ac].amt661,g_glar_d[l_ac].amt662,g_glar_d[l_ac].amt663,g_glar_d[l_ac].amt671,g_glar_d[l_ac].amt672,
       g_glar_d[l_ac].amt673,g_glar_d[l_ac].amt681,g_glar_d[l_ac].amt682,g_glar_d[l_ac].amt683,g_glar_d[l_ac].amt691,
       g_glar_d[l_ac].amt692,g_glar_d[l_ac].amt693,g_glar_d[l_ac].amt701,g_glar_d[l_ac].amt702,g_glar_d[l_ac].amt703,
       g_glar_d[l_ac].amt711,g_glar_d[l_ac].amt712,g_glar_d[l_ac].amt713,g_glar_d[l_ac].amt721,g_glar_d[l_ac].amt722,
       g_glar_d[l_ac].amt723,g_glar_d[l_ac].amt731,g_glar_d[l_ac].amt732,g_glar_d[l_ac].amt733,g_glar_d[l_ac].amt741,
       g_glar_d[l_ac].amt742,g_glar_d[l_ac].amt743,g_glar_d[l_ac].amt751,g_glar_d[l_ac].amt752,g_glar_d[l_ac].amt753,
       g_glar_d[l_ac].amt761,g_glar_d[l_ac].amt762,g_glar_d[l_ac].amt763,g_glar_d[l_ac].amt771,g_glar_d[l_ac].amt772,
       g_glar_d[l_ac].amt773,g_glar_d[l_ac].amt781,g_glar_d[l_ac].amt782,g_glar_d[l_ac].amt783,g_glar_d[l_ac].amt791,
       g_glar_d[l_ac].amt792,g_glar_d[l_ac].amt793,g_glar_d[l_ac].amt801,g_glar_d[l_ac].amt802,g_glar_d[l_ac].amt803,
       g_glar_d[l_ac].amt811,g_glar_d[l_ac].amt812,g_glar_d[l_ac].amt813,g_glar_d[l_ac].amt821,g_glar_d[l_ac].amt822,
       g_glar_d[l_ac].amt823,g_glar_d[l_ac].amt831,g_glar_d[l_ac].amt832,g_glar_d[l_ac].amt833,g_glar_d[l_ac].amt841,
       g_glar_d[l_ac].amt842,g_glar_d[l_ac].amt843,g_glar_d[l_ac].amt851,g_glar_d[l_ac].amt852,g_glar_d[l_ac].amt853,
       g_glar_d[l_ac].amt861,g_glar_d[l_ac].amt862,g_glar_d[l_ac].amt863,g_glar_d[l_ac].amt871,g_glar_d[l_ac].amt872,
       g_glar_d[l_ac].amt873,g_glar_d[l_ac].amt881,g_glar_d[l_ac].amt882,g_glar_d[l_ac].amt883,g_glar_d[l_ac].amt891,
       g_glar_d[l_ac].amt892,g_glar_d[l_ac].amt893,g_glar_d[l_ac].amt901,g_glar_d[l_ac].amt902,g_glar_d[l_ac].amt903,
       g_glar_d[l_ac].amt911,g_glar_d[l_ac].amt912,g_glar_d[l_ac].amt913,g_glar_d[l_ac].amt921,g_glar_d[l_ac].amt922,
       g_glar_d[l_ac].amt923,g_glar_d[l_ac].amt931,g_glar_d[l_ac].amt932,g_glar_d[l_ac].amt933,g_glar_d[l_ac].amt941,
       g_glar_d[l_ac].amt942,g_glar_d[l_ac].amt943,g_glar_d[l_ac].amt951,g_glar_d[l_ac].amt952,g_glar_d[l_ac].amt953,
       g_glar_d[l_ac].amt961,g_glar_d[l_ac].amt962,g_glar_d[l_ac].amt963,g_glar_d[l_ac].amt971,g_glar_d[l_ac].amt972,
       g_glar_d[l_ac].amt973,g_glar_d[l_ac].amt981,g_glar_d[l_ac].amt982,g_glar_d[l_ac].amt983,g_glar_d[l_ac].amt991,
       g_glar_d[l_ac].amt992,g_glar_d[l_ac].amt993,g_glar_d[l_ac].amt1001,g_glar_d[l_ac].amt1002,g_glar_d[l_ac].amt1003
     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #科目說明
#      CALL aglq730_glar001_desc(g_glar_d[l_ac].glar001) RETURNING g_glar_d[l_ac].glar001_desc #160505-00007#15
      
      #150827-00036#15--add--str--
      #最右一列合计金额
      EXECUTE aglq730_sum_pr USING g_glar_d[l_ac].glar001
                             INTO g_glar_d[l_ac].sum1,g_glar_d[l_ac].sum2,g_glar_d[l_ac].sum3
      #最后一行对应的合计列合计金额
      IF tm.show_acc = 'Y' THEN
         LET l_cnt=0
#160505-00007#15 add s------         
#         SELECT COUNT(*) INTO l_cnt FROM glac_t 
#         WHERE glac002=glac004
#           AND glacent=g_enterprise AND glac001=g_glaa004
#           AND glac002=g_glar_d[l_ac].glar001
         EXECUTE aglq730_pb2 USING g_glar_d[l_ac].glar001 INTO l_cnt
#160505-00007#15 add e------         
         IF l_cnt = 1 THEN
            LET l_sum1=l_sum1+g_glar_d[l_ac].sum1
            LET l_sum2=l_sum2+g_glar_d[l_ac].sum2
            LET l_sum3=l_sum3+g_glar_d[l_ac].sum3
         END IF
      ELSE
         LET l_sum1=l_sum1+g_glar_d[l_ac].sum1
         LET l_sum2=l_sum2+g_glar_d[l_ac].sum2
         LET l_sum3=l_sum3+g_glar_d[l_ac].sum3
      END IF
      #150827-00036#15--add--end
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   
   #150827-00036#15--add--str--
   #合計
   EXECUTE aglq730_sum_pr1 
   INTO l_sum_glar.amt11,l_sum_glar.amt12,l_sum_glar.amt13,  l_sum_glar.amt21,l_sum_glar.amt22,l_sum_glar.amt23,
        l_sum_glar.amt31,l_sum_glar.amt32,l_sum_glar.amt33,  l_sum_glar.amt41,l_sum_glar.amt42,l_sum_glar.amt43,
        l_sum_glar.amt51,l_sum_glar.amt52,l_sum_glar.amt53,  l_sum_glar.amt61,l_sum_glar.amt62,l_sum_glar.amt63,
        l_sum_glar.amt71,l_sum_glar.amt72,l_sum_glar.amt73,  l_sum_glar.amt81,l_sum_glar.amt82,l_sum_glar.amt83,
        l_sum_glar.amt91,l_sum_glar.amt92,l_sum_glar.amt93,  l_sum_glar.amt101,l_sum_glar.amt102,l_sum_glar.amt103,
        l_sum_glar.amt111,l_sum_glar.amt112,l_sum_glar.amt113,  l_sum_glar.amt121,l_sum_glar.amt122,l_sum_glar.amt123,
        l_sum_glar.amt131,l_sum_glar.amt132,l_sum_glar.amt133,  l_sum_glar.amt141,l_sum_glar.amt142,l_sum_glar.amt143,
        l_sum_glar.amt151,l_sum_glar.amt152,l_sum_glar.amt153,  l_sum_glar.amt161,l_sum_glar.amt162,l_sum_glar.amt163,
        l_sum_glar.amt171,l_sum_glar.amt172,l_sum_glar.amt173,  l_sum_glar.amt181,l_sum_glar.amt182,l_sum_glar.amt183,
        l_sum_glar.amt191,l_sum_glar.amt192,l_sum_glar.amt193,  l_sum_glar.amt201,l_sum_glar.amt202,l_sum_glar.amt203,
        l_sum_glar.amt211,l_sum_glar.amt212,l_sum_glar.amt213,  l_sum_glar.amt221,l_sum_glar.amt222,l_sum_glar.amt223,
        l_sum_glar.amt231,l_sum_glar.amt232,l_sum_glar.amt233,  l_sum_glar.amt241,l_sum_glar.amt242,l_sum_glar.amt243,
        l_sum_glar.amt251,l_sum_glar.amt252,l_sum_glar.amt253,  l_sum_glar.amt261,l_sum_glar.amt262,l_sum_glar.amt263,
        l_sum_glar.amt271,l_sum_glar.amt272,l_sum_glar.amt273,  l_sum_glar.amt281,l_sum_glar.amt282,l_sum_glar.amt283,
        l_sum_glar.amt291,l_sum_glar.amt292,l_sum_glar.amt293,  l_sum_glar.amt301,l_sum_glar.amt302,l_sum_glar.amt303,
        l_sum_glar.amt311,l_sum_glar.amt312,l_sum_glar.amt313,  l_sum_glar.amt321,l_sum_glar.amt322,l_sum_glar.amt323,
        l_sum_glar.amt331,l_sum_glar.amt332,l_sum_glar.amt333,  l_sum_glar.amt341,l_sum_glar.amt342,l_sum_glar.amt343,
        l_sum_glar.amt351,l_sum_glar.amt352,l_sum_glar.amt353,  l_sum_glar.amt361,l_sum_glar.amt362,l_sum_glar.amt363,
        l_sum_glar.amt371,l_sum_glar.amt372,l_sum_glar.amt373,  l_sum_glar.amt381,l_sum_glar.amt382,l_sum_glar.amt383,
        l_sum_glar.amt391,l_sum_glar.amt392,l_sum_glar.amt393,  l_sum_glar.amt401,l_sum_glar.amt402,l_sum_glar.amt403,
        l_sum_glar.amt411,l_sum_glar.amt412,l_sum_glar.amt413,  l_sum_glar.amt421,l_sum_glar.amt422,l_sum_glar.amt423,
        l_sum_glar.amt431,l_sum_glar.amt432,l_sum_glar.amt433,  l_sum_glar.amt441,l_sum_glar.amt442,l_sum_glar.amt443,
        l_sum_glar.amt451,l_sum_glar.amt452,l_sum_glar.amt453,  l_sum_glar.amt461,l_sum_glar.amt462,l_sum_glar.amt463,
        l_sum_glar.amt471,l_sum_glar.amt472,l_sum_glar.amt473,  l_sum_glar.amt481,l_sum_glar.amt482,l_sum_glar.amt483,
        l_sum_glar.amt491,l_sum_glar.amt492,l_sum_glar.amt493,  l_sum_glar.amt501,l_sum_glar.amt502,l_sum_glar.amt503,
        l_sum_glar.amt511,l_sum_glar.amt512,l_sum_glar.amt513,  l_sum_glar.amt521,l_sum_glar.amt522,l_sum_glar.amt523,
        l_sum_glar.amt531,l_sum_glar.amt532,l_sum_glar.amt533,  l_sum_glar.amt541,l_sum_glar.amt542,l_sum_glar.amt543,
        l_sum_glar.amt551,l_sum_glar.amt552,l_sum_glar.amt553,  l_sum_glar.amt561,l_sum_glar.amt562,l_sum_glar.amt563,
        l_sum_glar.amt571,l_sum_glar.amt572,l_sum_glar.amt573,  l_sum_glar.amt581,l_sum_glar.amt582,l_sum_glar.amt583,
        l_sum_glar.amt591,l_sum_glar.amt592,l_sum_glar.amt593,  l_sum_glar.amt601,l_sum_glar.amt602,l_sum_glar.amt603,
        l_sum_glar.amt611,l_sum_glar.amt612,l_sum_glar.amt613,  l_sum_glar.amt621,l_sum_glar.amt622,l_sum_glar.amt623,
        l_sum_glar.amt631,l_sum_glar.amt632,l_sum_glar.amt633,  l_sum_glar.amt641,l_sum_glar.amt642,l_sum_glar.amt643,
        l_sum_glar.amt651,l_sum_glar.amt652,l_sum_glar.amt653,  l_sum_glar.amt661,l_sum_glar.amt662,l_sum_glar.amt663,
        l_sum_glar.amt671,l_sum_glar.amt672,l_sum_glar.amt673,  l_sum_glar.amt681,l_sum_glar.amt682,l_sum_glar.amt683,
        l_sum_glar.amt691,l_sum_glar.amt692,l_sum_glar.amt693,  l_sum_glar.amt701,l_sum_glar.amt702,l_sum_glar.amt703,
        l_sum_glar.amt711,l_sum_glar.amt712,l_sum_glar.amt713,  l_sum_glar.amt721,l_sum_glar.amt722,l_sum_glar.amt723,
        l_sum_glar.amt731,l_sum_glar.amt732,l_sum_glar.amt733,  l_sum_glar.amt741,l_sum_glar.amt742,l_sum_glar.amt743,
        l_sum_glar.amt751,l_sum_glar.amt752,l_sum_glar.amt753,  l_sum_glar.amt761,l_sum_glar.amt762,l_sum_glar.amt763,
        l_sum_glar.amt771,l_sum_glar.amt772,l_sum_glar.amt773,  l_sum_glar.amt781,l_sum_glar.amt782,l_sum_glar.amt783,
        l_sum_glar.amt791,l_sum_glar.amt792,l_sum_glar.amt793,  l_sum_glar.amt801,l_sum_glar.amt802,l_sum_glar.amt803,
        l_sum_glar.amt811,l_sum_glar.amt812,l_sum_glar.amt813,  l_sum_glar.amt821,l_sum_glar.amt822,l_sum_glar.amt823,
        l_sum_glar.amt831,l_sum_glar.amt832,l_sum_glar.amt833,  l_sum_glar.amt841,l_sum_glar.amt842,l_sum_glar.amt843,
        l_sum_glar.amt851,l_sum_glar.amt852,l_sum_glar.amt853,  l_sum_glar.amt861,l_sum_glar.amt862,l_sum_glar.amt863,
        l_sum_glar.amt871,l_sum_glar.amt872,l_sum_glar.amt873,  l_sum_glar.amt881,l_sum_glar.amt882,l_sum_glar.amt883,
        l_sum_glar.amt891,l_sum_glar.amt892,l_sum_glar.amt893,  l_sum_glar.amt901,l_sum_glar.amt902,l_sum_glar.amt903,
        l_sum_glar.amt911,l_sum_glar.amt912,l_sum_glar.amt913,  l_sum_glar.amt921,l_sum_glar.amt922,l_sum_glar.amt923,
        l_sum_glar.amt931,l_sum_glar.amt932,l_sum_glar.amt933,  l_sum_glar.amt941,l_sum_glar.amt942,l_sum_glar.amt943,
        l_sum_glar.amt951,l_sum_glar.amt952,l_sum_glar.amt953,  l_sum_glar.amt961,l_sum_glar.amt962,l_sum_glar.amt963,
        l_sum_glar.amt971,l_sum_glar.amt972,l_sum_glar.amt973,  l_sum_glar.amt981,l_sum_glar.amt982,l_sum_glar.amt983,
        l_sum_glar.amt991,l_sum_glar.amt992,l_sum_glar.amt993,  l_sum_glar.amt1001,l_sum_glar.amt1002,l_sum_glar.amt1003
        
   DISPLAY l_sum_glar.amt11,l_sum_glar.amt12,l_sum_glar.amt13,  l_sum_glar.amt21,l_sum_glar.amt22,l_sum_glar.amt23,
        l_sum_glar.amt31,l_sum_glar.amt32,l_sum_glar.amt33,  l_sum_glar.amt41,l_sum_glar.amt42,l_sum_glar.amt43,
        l_sum_glar.amt51,l_sum_glar.amt52,l_sum_glar.amt53,  l_sum_glar.amt61,l_sum_glar.amt62,l_sum_glar.amt63,
        l_sum_glar.amt71,l_sum_glar.amt72,l_sum_glar.amt73,  l_sum_glar.amt81,l_sum_glar.amt82,l_sum_glar.amt83,
        l_sum_glar.amt91,l_sum_glar.amt92,l_sum_glar.amt93,  l_sum_glar.amt101,l_sum_glar.amt102,l_sum_glar.amt103,
        l_sum_glar.amt111,l_sum_glar.amt112,l_sum_glar.amt113,  l_sum_glar.amt121,l_sum_glar.amt122,l_sum_glar.amt123,
        l_sum_glar.amt131,l_sum_glar.amt132,l_sum_glar.amt133,  l_sum_glar.amt141,l_sum_glar.amt142,l_sum_glar.amt143,
        l_sum_glar.amt151,l_sum_glar.amt152,l_sum_glar.amt153,  l_sum_glar.amt161,l_sum_glar.amt162,l_sum_glar.amt163,
        l_sum_glar.amt171,l_sum_glar.amt172,l_sum_glar.amt173,  l_sum_glar.amt181,l_sum_glar.amt182,l_sum_glar.amt183,
        l_sum_glar.amt191,l_sum_glar.amt192,l_sum_glar.amt193,  l_sum_glar.amt201,l_sum_glar.amt202,l_sum_glar.amt203,
        l_sum_glar.amt211,l_sum_glar.amt212,l_sum_glar.amt213,  l_sum_glar.amt221,l_sum_glar.amt222,l_sum_glar.amt223,
        l_sum_glar.amt231,l_sum_glar.amt232,l_sum_glar.amt233,  l_sum_glar.amt241,l_sum_glar.amt242,l_sum_glar.amt243,
        l_sum_glar.amt251,l_sum_glar.amt252,l_sum_glar.amt253,  l_sum_glar.amt261,l_sum_glar.amt262,l_sum_glar.amt263,
        l_sum_glar.amt271,l_sum_glar.amt272,l_sum_glar.amt273,  l_sum_glar.amt281,l_sum_glar.amt282,l_sum_glar.amt283,
        l_sum_glar.amt291,l_sum_glar.amt292,l_sum_glar.amt293,  l_sum_glar.amt301,l_sum_glar.amt302,l_sum_glar.amt303,
        l_sum_glar.amt311,l_sum_glar.amt312,l_sum_glar.amt313,  l_sum_glar.amt321,l_sum_glar.amt322,l_sum_glar.amt323,
        l_sum_glar.amt331,l_sum_glar.amt332,l_sum_glar.amt333,  l_sum_glar.amt341,l_sum_glar.amt342,l_sum_glar.amt343,
        l_sum_glar.amt351,l_sum_glar.amt352,l_sum_glar.amt353,  l_sum_glar.amt361,l_sum_glar.amt362,l_sum_glar.amt363,
        l_sum_glar.amt371,l_sum_glar.amt372,l_sum_glar.amt373,  l_sum_glar.amt381,l_sum_glar.amt382,l_sum_glar.amt383,
        l_sum_glar.amt391,l_sum_glar.amt392,l_sum_glar.amt393,  l_sum_glar.amt401,l_sum_glar.amt402,l_sum_glar.amt403,
        l_sum_glar.amt411,l_sum_glar.amt412,l_sum_glar.amt413,  l_sum_glar.amt421,l_sum_glar.amt422,l_sum_glar.amt423,
        l_sum_glar.amt431,l_sum_glar.amt432,l_sum_glar.amt433,  l_sum_glar.amt441,l_sum_glar.amt442,l_sum_glar.amt443,
        l_sum_glar.amt451,l_sum_glar.amt452,l_sum_glar.amt453,  l_sum_glar.amt461,l_sum_glar.amt462,l_sum_glar.amt463,
        l_sum_glar.amt471,l_sum_glar.amt472,l_sum_glar.amt473,  l_sum_glar.amt481,l_sum_glar.amt482,l_sum_glar.amt483,
        l_sum_glar.amt491,l_sum_glar.amt492,l_sum_glar.amt493,  l_sum_glar.amt501,l_sum_glar.amt502,l_sum_glar.amt503,
        l_sum_glar.amt511,l_sum_glar.amt512,l_sum_glar.amt513,  l_sum_glar.amt521,l_sum_glar.amt522,l_sum_glar.amt523,
        l_sum_glar.amt531,l_sum_glar.amt532,l_sum_glar.amt533,  l_sum_glar.amt541,l_sum_glar.amt542,l_sum_glar.amt543,
        l_sum_glar.amt551,l_sum_glar.amt552,l_sum_glar.amt553,  l_sum_glar.amt561,l_sum_glar.amt562,l_sum_glar.amt563,
        l_sum_glar.amt571,l_sum_glar.amt572,l_sum_glar.amt573,  l_sum_glar.amt581,l_sum_glar.amt582,l_sum_glar.amt583,
        l_sum_glar.amt591,l_sum_glar.amt592,l_sum_glar.amt593,  l_sum_glar.amt601,l_sum_glar.amt602,l_sum_glar.amt603,
        l_sum_glar.amt611,l_sum_glar.amt612,l_sum_glar.amt613,  l_sum_glar.amt621,l_sum_glar.amt622,l_sum_glar.amt623,
        l_sum_glar.amt631,l_sum_glar.amt632,l_sum_glar.amt633,  l_sum_glar.amt641,l_sum_glar.amt642,l_sum_glar.amt643,
        l_sum_glar.amt651,l_sum_glar.amt652,l_sum_glar.amt653,  l_sum_glar.amt661,l_sum_glar.amt662,l_sum_glar.amt663,
        l_sum_glar.amt671,l_sum_glar.amt672,l_sum_glar.amt673,  l_sum_glar.amt681,l_sum_glar.amt682,l_sum_glar.amt683,
        l_sum_glar.amt691,l_sum_glar.amt692,l_sum_glar.amt693,  l_sum_glar.amt701,l_sum_glar.amt702,l_sum_glar.amt703,
        l_sum_glar.amt711,l_sum_glar.amt712,l_sum_glar.amt713,  l_sum_glar.amt721,l_sum_glar.amt722,l_sum_glar.amt723,
        l_sum_glar.amt731,l_sum_glar.amt732,l_sum_glar.amt733,  l_sum_glar.amt741,l_sum_glar.amt742,l_sum_glar.amt743,
        l_sum_glar.amt751,l_sum_glar.amt752,l_sum_glar.amt753,  l_sum_glar.amt761,l_sum_glar.amt762,l_sum_glar.amt763,
        l_sum_glar.amt771,l_sum_glar.amt772,l_sum_glar.amt773,  l_sum_glar.amt781,l_sum_glar.amt782,l_sum_glar.amt783,
        l_sum_glar.amt791,l_sum_glar.amt792,l_sum_glar.amt793,  l_sum_glar.amt801,l_sum_glar.amt802,l_sum_glar.amt803,
        l_sum_glar.amt811,l_sum_glar.amt812,l_sum_glar.amt813,  l_sum_glar.amt821,l_sum_glar.amt822,l_sum_glar.amt823,
        l_sum_glar.amt831,l_sum_glar.amt832,l_sum_glar.amt833,  l_sum_glar.amt841,l_sum_glar.amt842,l_sum_glar.amt843,
        l_sum_glar.amt851,l_sum_glar.amt852,l_sum_glar.amt853,  l_sum_glar.amt861,l_sum_glar.amt862,l_sum_glar.amt863,
        l_sum_glar.amt871,l_sum_glar.amt872,l_sum_glar.amt873,  l_sum_glar.amt881,l_sum_glar.amt882,l_sum_glar.amt883,
        l_sum_glar.amt891,l_sum_glar.amt892,l_sum_glar.amt893,  l_sum_glar.amt901,l_sum_glar.amt902,l_sum_glar.amt903,
        l_sum_glar.amt911,l_sum_glar.amt912,l_sum_glar.amt913,  l_sum_glar.amt921,l_sum_glar.amt922,l_sum_glar.amt923,
        l_sum_glar.amt931,l_sum_glar.amt932,l_sum_glar.amt933,  l_sum_glar.amt941,l_sum_glar.amt942,l_sum_glar.amt943,
        l_sum_glar.amt951,l_sum_glar.amt952,l_sum_glar.amt953,  l_sum_glar.amt961,l_sum_glar.amt962,l_sum_glar.amt963,
        l_sum_glar.amt971,l_sum_glar.amt972,l_sum_glar.amt973,  l_sum_glar.amt981,l_sum_glar.amt982,l_sum_glar.amt983,
        l_sum_glar.amt991,l_sum_glar.amt992,l_sum_glar.amt993,  l_sum_glar.amt1001,l_sum_glar.amt1002,l_sum_glar.amt1003
   TO 
        FORMONLY.sum11,FORMONLY.sum12,FORMONLY.sum13,  FORMONLY.sum21,FORMONLY.sum22,FORMONLY.sum23,
        FORMONLY.sum31,FORMONLY.sum32,FORMONLY.sum33,  FORMONLY.sum41,FORMONLY.sum42,FORMONLY.sum43,
        FORMONLY.sum51,FORMONLY.sum52,FORMONLY.sum53,  FORMONLY.sum61,FORMONLY.sum62,FORMONLY.sum63,
        FORMONLY.sum71,FORMONLY.sum72,FORMONLY.sum73,  FORMONLY.sum81,FORMONLY.sum82,FORMONLY.sum83,
        FORMONLY.sum91,FORMONLY.sum92,FORMONLY.sum93,  FORMONLY.sum101,FORMONLY.sum102,FORMONLY.sum103,
        FORMONLY.sum111,FORMONLY.sum112,FORMONLY.sum113,  FORMONLY.sum121,FORMONLY.sum122,FORMONLY.sum123,
        FORMONLY.sum131,FORMONLY.sum132,FORMONLY.sum133,  FORMONLY.sum141,FORMONLY.sum142,FORMONLY.sum143,
        FORMONLY.sum151,FORMONLY.sum152,FORMONLY.sum153,  FORMONLY.sum161,FORMONLY.sum162,FORMONLY.sum163,
        FORMONLY.sum171,FORMONLY.sum172,FORMONLY.sum173,  FORMONLY.sum181,FORMONLY.sum182,FORMONLY.sum183,
        FORMONLY.sum191,FORMONLY.sum192,FORMONLY.sum193,  FORMONLY.sum201,FORMONLY.sum202,FORMONLY.sum203,
        FORMONLY.sum211,FORMONLY.sum212,FORMONLY.sum213,  FORMONLY.sum221,FORMONLY.sum222,FORMONLY.sum223,
        FORMONLY.sum231,FORMONLY.sum232,FORMONLY.sum233,  FORMONLY.sum241,FORMONLY.sum242,FORMONLY.sum243,
        FORMONLY.sum251,FORMONLY.sum252,FORMONLY.sum253,  FORMONLY.sum261,FORMONLY.sum262,FORMONLY.sum263,
        FORMONLY.sum271,FORMONLY.sum272,FORMONLY.sum273,  FORMONLY.sum281,FORMONLY.sum282,FORMONLY.sum283,
        FORMONLY.sum291,FORMONLY.sum292,FORMONLY.sum293,  FORMONLY.sum301,FORMONLY.sum302,FORMONLY.sum303,
        FORMONLY.sum311,FORMONLY.sum312,FORMONLY.sum313,  FORMONLY.sum321,FORMONLY.sum322,FORMONLY.sum323,
        FORMONLY.sum331,FORMONLY.sum332,FORMONLY.sum333,  FORMONLY.sum341,FORMONLY.sum342,FORMONLY.sum343,
        FORMONLY.sum351,FORMONLY.sum352,FORMONLY.sum353,  FORMONLY.sum361,FORMONLY.sum362,FORMONLY.sum363,
        FORMONLY.sum371,FORMONLY.sum372,FORMONLY.sum373,  FORMONLY.sum381,FORMONLY.sum382,FORMONLY.sum383,
        FORMONLY.sum391,FORMONLY.sum392,FORMONLY.sum393,  FORMONLY.sum401,FORMONLY.sum402,FORMONLY.sum403,
        FORMONLY.sum411,FORMONLY.sum412,FORMONLY.sum413,  FORMONLY.sum421,FORMONLY.sum422,FORMONLY.sum423,
        FORMONLY.sum431,FORMONLY.sum432,FORMONLY.sum433,  FORMONLY.sum441,FORMONLY.sum442,FORMONLY.sum443,
        FORMONLY.sum451,FORMONLY.sum452,FORMONLY.sum453,  FORMONLY.sum461,FORMONLY.sum462,FORMONLY.sum463,
        FORMONLY.sum471,FORMONLY.sum472,FORMONLY.sum473,  FORMONLY.sum481,FORMONLY.sum482,FORMONLY.sum483,
        FORMONLY.sum491,FORMONLY.sum492,FORMONLY.sum493,  FORMONLY.sum501,FORMONLY.sum502,FORMONLY.sum503,
        FORMONLY.sum511,FORMONLY.sum512,FORMONLY.sum513,  FORMONLY.sum521,FORMONLY.sum522,FORMONLY.sum523,
        FORMONLY.sum531,FORMONLY.sum532,FORMONLY.sum533,  FORMONLY.sum541,FORMONLY.sum542,FORMONLY.sum543,
        FORMONLY.sum551,FORMONLY.sum552,FORMONLY.sum553,  FORMONLY.sum561,FORMONLY.sum562,FORMONLY.sum563,
        FORMONLY.sum571,FORMONLY.sum572,FORMONLY.sum573,  FORMONLY.sum581,FORMONLY.sum582,FORMONLY.sum583,
        FORMONLY.sum591,FORMONLY.sum592,FORMONLY.sum593,  FORMONLY.sum601,FORMONLY.sum602,FORMONLY.sum603,
        FORMONLY.sum611,FORMONLY.sum612,FORMONLY.sum613,  FORMONLY.sum621,FORMONLY.sum622,FORMONLY.sum623,
        FORMONLY.sum631,FORMONLY.sum632,FORMONLY.sum633,  FORMONLY.sum641,FORMONLY.sum642,FORMONLY.sum643,
        FORMONLY.sum651,FORMONLY.sum652,FORMONLY.sum653,  FORMONLY.sum661,FORMONLY.sum662,FORMONLY.sum663,
        FORMONLY.sum671,FORMONLY.sum672,FORMONLY.sum673,  FORMONLY.sum681,FORMONLY.sum682,FORMONLY.sum683,
        FORMONLY.sum691,FORMONLY.sum692,FORMONLY.sum693,  FORMONLY.sum701,FORMONLY.sum702,FORMONLY.sum703,
        FORMONLY.sum711,FORMONLY.sum712,FORMONLY.sum713,  FORMONLY.sum721,FORMONLY.sum722,FORMONLY.sum723,
        FORMONLY.sum731,FORMONLY.sum732,FORMONLY.sum733,  FORMONLY.sum741,FORMONLY.sum742,FORMONLY.sum743,
        FORMONLY.sum751,FORMONLY.sum752,FORMONLY.sum753,  FORMONLY.sum761,FORMONLY.sum762,FORMONLY.sum763,
        FORMONLY.sum771,FORMONLY.sum772,FORMONLY.sum773,  FORMONLY.sum781,FORMONLY.sum782,FORMONLY.sum783,
        FORMONLY.sum791,FORMONLY.sum792,FORMONLY.sum793,  FORMONLY.sum801,FORMONLY.sum802,FORMONLY.sum803,
        FORMONLY.sum811,FORMONLY.sum812,FORMONLY.sum813,  FORMONLY.sum821,FORMONLY.sum822,FORMONLY.sum823,
        FORMONLY.sum831,FORMONLY.sum832,FORMONLY.sum833,  FORMONLY.sum841,FORMONLY.sum842,FORMONLY.sum843,
        FORMONLY.sum851,FORMONLY.sum852,FORMONLY.sum853,  FORMONLY.sum861,FORMONLY.sum862,FORMONLY.sum863,
        FORMONLY.sum871,FORMONLY.sum872,FORMONLY.sum873,  FORMONLY.sum881,FORMONLY.sum882,FORMONLY.sum883,
        FORMONLY.sum891,FORMONLY.sum892,FORMONLY.sum893,  FORMONLY.sum901,FORMONLY.sum902,FORMONLY.sum903,
        FORMONLY.sum911,FORMONLY.sum912,FORMONLY.sum913,  FORMONLY.sum921,FORMONLY.sum922,FORMONLY.sum923,
        FORMONLY.sum931,FORMONLY.sum932,FORMONLY.sum933,  FORMONLY.sum941,FORMONLY.sum942,FORMONLY.sum943,
        FORMONLY.sum951,FORMONLY.sum952,FORMONLY.sum953,  FORMONLY.sum961,FORMONLY.sum962,FORMONLY.sum963,
        FORMONLY.sum971,FORMONLY.sum972,FORMONLY.sum973,  FORMONLY.sum981,FORMONLY.sum982,FORMONLY.sum983,
        FORMONLY.sum991,FORMONLY.sum992,FORMONLY.sum993,  FORMONLY.sum1001,FORMONLY.sum1002,FORMONLY.sum1003
   DISPLAY l_sum1 TO FORMONLY.sum10
   DISPLAY l_sum2 TO FORMONLY.sum20
   DISPLAY l_sum3 TO FORMONLY.sum30
   
   #150827-00036#15--add--end
   
   LET g_error_show = 0
   CALL g_glar_d.deleteElement(g_glar_d.getLength())
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_cnt = 0
   LET l_ac = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   CALL aglq730_filter_show('glar001','b_glar001')
END FUNCTION
################################################################################
# Descriptions...: 列印XG報表
# Memo...........:
# Usage..........: CALL aglq730_xg()
#                  RETURNING ---
# Input parameter:
# Return code....:
# Date & Author..: 2015/06/02 By 07727
# Modify.........: #130726-00001#95 Add
################################################################################
PRIVATE FUNCTION aglq730_xg()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_title        LIKE type_t.chr200
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_glaald_desc  LIKE type_t.chr500
   DEFINE l_glaacomp_desc LIKE type_t.chr500
   DEFINE l_curr         LIKE type_t.chr500
   DEFINE l_sdate        LIKE type_t.chr500  #起始日期
   DEFINE l_edate        LIKE type_t.chr500  #截止日期
   DEFINE l_ctype        LIKE type_t.chr500  #多本位幣
   DEFINE l_fix_acc      LIKE type_t.chr500 
   DEFINE l_stype        LIKE type_t.chr500
   DEFINE l_stus         LIKE type_t.chr500

   CALL aglq730_create_for_xg()
   DELETE FROM aglq730_tmp01                      #160727-00019#3  Mod  aglq730_print_tmp -->aglq730_tmp01
   
   LET l_glaald_desc = g_glaald,"   ",g_glaald_desc
   LET l_glaacomp_desc = g_glaacomp,"    ",g_glaacomp_desc
   LET l_curr = g_glaa001,"  ",g_glaa016,"   ",g_glaa020
   LET l_sdate = tm.sdate,"  ",tm.syear," ",tm.speriod
   LET l_edate = tm.edate,"  ",tm.eyear," ",tm.eperiod
   LET l_ctype = tm.ctype,":",s_desc_gzcbl004_desc('9921',tm.ctype)
   LET l_fix_acc = tm.fix_acc,":",s_desc_gzcbl004_desc('9934',tm.fix_acc) 
   LET l_stype = tm.stype,":",s_desc_gzcbl004_desc('9925',tm.stype)
   LET l_stus = tm.stus,":",s_desc_gzcbl004_desc('9922',tm.stus)
   FOR l_i = 1 TO g_glar_d.getLength()
      INSERT INTO aglq730_tmp01(glar001,glar001_desc,             #160727-00019#3  Mod  aglq730_print_tmp -->aglq730_tmp01
                  amt11,amt12,amt13, amt21,amt22,amt23, amt31,amt32,amt33,
                  amt41,amt42,amt43, amt51,amt52,amt53, amt61,amt62,amt63,
                  amt71,amt72,amt73, amt81,amt82,amt83, amt91,amt92,amt93,
                  amt101,amt102,amt103, amt111,amt112,amt113, amt121,amt122,amt123,
                  amt131,amt132,amt133, amt141,amt142,amt143, amt151,amt152,amt153,
                  amt161,amt162,amt163, amt171,amt172,amt173, amt181,amt182,amt183,
                  amt191,amt192,amt193, amt201,amt202,amt203, amt211,amt212,amt213,
                  amt221,amt222,amt223, amt231,amt232,amt233, amt241,amt242,amt243,
                  amt251,amt252,amt253, amt261,amt262,amt263, amt271,amt272,amt273,
                  amt281,amt282,amt283, amt291,amt292,amt293, amt301,amt302,amt303,
                  amt311,amt312,amt313, amt321,amt322,amt323, amt331,amt332,amt333, amt341,amt342,amt343, amt351,amt352,amt353,
                  amt361,amt362,amt363, amt371,amt372,amt373, amt381,amt382,amt383, amt391,amt392,amt393, amt401,amt402,amt403,
                  amt411,amt412,amt413, amt421,amt422,amt423, amt431,amt432,amt433, amt441,amt442,amt443, amt451,amt452,amt453,
                  amt461,amt462,amt463, amt471,amt472,amt473, amt481,amt482,amt483, amt491,amt492,amt493, amt501,amt502,amt503,
                  amt511,amt512,amt513, amt521,amt522,amt523, amt531,amt532,amt533, amt541,amt542,amt543, amt551,amt552,amt553,
                  amt561,amt562,amt563, amt571,amt572,amt573, amt581,amt582,amt583, amt591,amt592,amt593, amt601,amt602,amt603,
                  amt611,amt612,amt613, amt621,amt622,amt623, amt631,amt632,amt633, amt641,amt642,amt643, amt651,amt652,amt653,
                  amt661,amt662,amt663, amt671,amt672,amt673, amt681,amt682,amt683, amt691,amt692,amt693, amt701,amt702,amt703,
                  amt711,amt712,amt713, amt721,amt722,amt723, amt731,amt732,amt733, amt741,amt742,amt743, amt751,amt752,amt753,
                  amt761,amt762,amt763, amt771,amt772,amt773, amt781,amt782,amt783, amt791,amt792,amt793, amt801,amt802,amt803,
                  amt811,amt812,amt813, amt821,amt822,amt823, amt831,amt832,amt833, amt841,amt842,amt843, amt851,amt852,amt853,
                  amt861,amt862,amt863, amt871,amt872,amt873, amt881,amt882,amt883, amt891,amt892,amt893, amt901,amt902,amt903,
                  amt911,amt912,amt913, amt921,amt922,amt923, amt931,amt932,amt933, amt941,amt942,amt943, amt951,amt952,amt953,
                  amt961,amt962,amt963, amt971,amt972,amt973, amt981,amt982,amt983, amt991,amt992,amt993, amt1001,amt1002,amt1003,
                  l_glaald_desc,l_glaacomp_desc,l_curr,l_sdate,l_edate,l_ctype,l_fix_acc,l_stype,l_glac005,l_stus)
         VALUES(g_glar_d[l_i].glar001,g_glar_d[l_i].glar001_desc,
                g_glar_d[l_i].amt11,g_glar_d[l_i].amt12,g_glar_d[l_i].amt13, g_glar_d[l_i].amt21,g_glar_d[l_i].amt22,g_glar_d[l_i].amt23, g_glar_d[l_i].amt31,g_glar_d[l_i].amt32,g_glar_d[l_i].amt33,
                g_glar_d[l_i].amt41,g_glar_d[l_i].amt42,g_glar_d[l_i].amt43, g_glar_d[l_i].amt51,g_glar_d[l_i].amt52,g_glar_d[l_i].amt53, g_glar_d[l_i].amt61,g_glar_d[l_i].amt62,g_glar_d[l_i].amt63,
                g_glar_d[l_i].amt71,g_glar_d[l_i].amt72,g_glar_d[l_i].amt73, g_glar_d[l_i].amt81,g_glar_d[l_i].amt82,g_glar_d[l_i].amt83, g_glar_d[l_i].amt91,g_glar_d[l_i].amt92,g_glar_d[l_i].amt93,
                g_glar_d[l_i].amt101,g_glar_d[l_i].amt102,g_glar_d[l_i].amt103, g_glar_d[l_i].amt111,g_glar_d[l_i].amt112,g_glar_d[l_i].amt113, g_glar_d[l_i].amt121,g_glar_d[l_i].amt122,g_glar_d[l_i].amt123,
                g_glar_d[l_i].amt131,g_glar_d[l_i].amt132,g_glar_d[l_i].amt133, g_glar_d[l_i].amt141,g_glar_d[l_i].amt142,g_glar_d[l_i].amt143, g_glar_d[l_i].amt151,g_glar_d[l_i].amt152,g_glar_d[l_i].amt153,
                g_glar_d[l_i].amt161,g_glar_d[l_i].amt162,g_glar_d[l_i].amt163, g_glar_d[l_i].amt171,g_glar_d[l_i].amt172,g_glar_d[l_i].amt173, g_glar_d[l_i].amt181,g_glar_d[l_i].amt182,g_glar_d[l_i].amt183,
                g_glar_d[l_i].amt191,g_glar_d[l_i].amt192,g_glar_d[l_i].amt193, g_glar_d[l_i].amt201,g_glar_d[l_i].amt202,g_glar_d[l_i].amt203, g_glar_d[l_i].amt211,g_glar_d[l_i].amt212,g_glar_d[l_i].amt213,
                g_glar_d[l_i].amt221,g_glar_d[l_i].amt222,g_glar_d[l_i].amt223, g_glar_d[l_i].amt231,g_glar_d[l_i].amt232,g_glar_d[l_i].amt233, g_glar_d[l_i].amt241,g_glar_d[l_i].amt242,g_glar_d[l_i].amt243,
                g_glar_d[l_i].amt251,g_glar_d[l_i].amt252,g_glar_d[l_i].amt253, g_glar_d[l_i].amt261,g_glar_d[l_i].amt262,g_glar_d[l_i].amt263, g_glar_d[l_i].amt271,g_glar_d[l_i].amt272,g_glar_d[l_i].amt273,
                g_glar_d[l_i].amt281,g_glar_d[l_i].amt282,g_glar_d[l_i].amt283, g_glar_d[l_i].amt291,g_glar_d[l_i].amt292,g_glar_d[l_i].amt293, g_glar_d[l_i].amt301,g_glar_d[l_i].amt302,g_glar_d[l_i].amt303,
                g_glar_d[l_i].amt311,g_glar_d[l_i].amt312,g_glar_d[l_i].amt313, g_glar_d[l_i].amt321,g_glar_d[l_i].amt322,g_glar_d[l_i].amt323,
                g_glar_d[l_i].amt331,g_glar_d[l_i].amt332,g_glar_d[l_i].amt333, g_glar_d[l_i].amt341,g_glar_d[l_i].amt342,g_glar_d[l_i].amt343,
                g_glar_d[l_i].amt351,g_glar_d[l_i].amt352,g_glar_d[l_i].amt353, g_glar_d[l_i].amt361,g_glar_d[l_i].amt362,g_glar_d[l_i].amt363,
                g_glar_d[l_i].amt371,g_glar_d[l_i].amt372,g_glar_d[l_i].amt373, g_glar_d[l_i].amt381,g_glar_d[l_i].amt382,g_glar_d[l_i].amt383,
                g_glar_d[l_i].amt391,g_glar_d[l_i].amt392,g_glar_d[l_i].amt393, g_glar_d[l_i].amt401,g_glar_d[l_i].amt402,g_glar_d[l_i].amt403,
                g_glar_d[l_i].amt411,g_glar_d[l_i].amt412,g_glar_d[l_i].amt413, g_glar_d[l_i].amt421,g_glar_d[l_i].amt422,g_glar_d[l_i].amt423,
                g_glar_d[l_i].amt431,g_glar_d[l_i].amt432,g_glar_d[l_i].amt433, g_glar_d[l_i].amt441,g_glar_d[l_i].amt442,g_glar_d[l_i].amt443,
                g_glar_d[l_i].amt451,g_glar_d[l_i].amt452,g_glar_d[l_i].amt453, g_glar_d[l_i].amt461,g_glar_d[l_i].amt462,g_glar_d[l_i].amt463,
                g_glar_d[l_i].amt471,g_glar_d[l_i].amt472,g_glar_d[l_i].amt473, g_glar_d[l_i].amt481,g_glar_d[l_i].amt482,g_glar_d[l_i].amt483,
                g_glar_d[l_i].amt491,g_glar_d[l_i].amt492,g_glar_d[l_i].amt493, g_glar_d[l_i].amt501,g_glar_d[l_i].amt502,g_glar_d[l_i].amt503,
                g_glar_d[l_i].amt511,g_glar_d[l_i].amt512,g_glar_d[l_i].amt513, g_glar_d[l_i].amt521,g_glar_d[l_i].amt522,g_glar_d[l_i].amt523,
                g_glar_d[l_i].amt531,g_glar_d[l_i].amt532,g_glar_d[l_i].amt533, g_glar_d[l_i].amt541,g_glar_d[l_i].amt542,g_glar_d[l_i].amt543,
                g_glar_d[l_i].amt551,g_glar_d[l_i].amt552,g_glar_d[l_i].amt553, g_glar_d[l_i].amt561,g_glar_d[l_i].amt562,g_glar_d[l_i].amt563,
                g_glar_d[l_i].amt571,g_glar_d[l_i].amt572,g_glar_d[l_i].amt573, g_glar_d[l_i].amt581,g_glar_d[l_i].amt582,g_glar_d[l_i].amt583,
                g_glar_d[l_i].amt591,g_glar_d[l_i].amt592,g_glar_d[l_i].amt593, g_glar_d[l_i].amt601,g_glar_d[l_i].amt602,g_glar_d[l_i].amt603,
                g_glar_d[l_i].amt611,g_glar_d[l_i].amt612,g_glar_d[l_i].amt613, g_glar_d[l_i].amt621,g_glar_d[l_i].amt622,g_glar_d[l_i].amt623,
                g_glar_d[l_i].amt631,g_glar_d[l_i].amt632,g_glar_d[l_i].amt633, g_glar_d[l_i].amt641,g_glar_d[l_i].amt642,g_glar_d[l_i].amt643,
                g_glar_d[l_i].amt651,g_glar_d[l_i].amt652,g_glar_d[l_i].amt653, g_glar_d[l_i].amt661,g_glar_d[l_i].amt662,g_glar_d[l_i].amt663,
                g_glar_d[l_i].amt671,g_glar_d[l_i].amt672,g_glar_d[l_i].amt673, g_glar_d[l_i].amt681,g_glar_d[l_i].amt682,g_glar_d[l_i].amt683,
                g_glar_d[l_i].amt691,g_glar_d[l_i].amt692,g_glar_d[l_i].amt693, g_glar_d[l_i].amt701,g_glar_d[l_i].amt702,g_glar_d[l_i].amt703,
                g_glar_d[l_i].amt711,g_glar_d[l_i].amt712,g_glar_d[l_i].amt713, g_glar_d[l_i].amt721,g_glar_d[l_i].amt722,g_glar_d[l_i].amt723,
                g_glar_d[l_i].amt731,g_glar_d[l_i].amt732,g_glar_d[l_i].amt733, g_glar_d[l_i].amt741,g_glar_d[l_i].amt742,g_glar_d[l_i].amt743,
                g_glar_d[l_i].amt751,g_glar_d[l_i].amt752,g_glar_d[l_i].amt753, g_glar_d[l_i].amt761,g_glar_d[l_i].amt762,g_glar_d[l_i].amt763,
                g_glar_d[l_i].amt771,g_glar_d[l_i].amt772,g_glar_d[l_i].amt773, g_glar_d[l_i].amt781,g_glar_d[l_i].amt782,g_glar_d[l_i].amt783,
                g_glar_d[l_i].amt791,g_glar_d[l_i].amt792,g_glar_d[l_i].amt793, g_glar_d[l_i].amt801,g_glar_d[l_i].amt802,g_glar_d[l_i].amt803,
                g_glar_d[l_i].amt811,g_glar_d[l_i].amt812,g_glar_d[l_i].amt813, g_glar_d[l_i].amt821,g_glar_d[l_i].amt822,g_glar_d[l_i].amt823,
                g_glar_d[l_i].amt831,g_glar_d[l_i].amt832,g_glar_d[l_i].amt833, g_glar_d[l_i].amt841,g_glar_d[l_i].amt842,g_glar_d[l_i].amt843,
                g_glar_d[l_i].amt851,g_glar_d[l_i].amt852,g_glar_d[l_i].amt853, g_glar_d[l_i].amt861,g_glar_d[l_i].amt862,g_glar_d[l_i].amt863,
                g_glar_d[l_i].amt871,g_glar_d[l_i].amt872,g_glar_d[l_i].amt873, g_glar_d[l_i].amt881,g_glar_d[l_i].amt882,g_glar_d[l_i].amt883,
                g_glar_d[l_i].amt891,g_glar_d[l_i].amt892,g_glar_d[l_i].amt893, g_glar_d[l_i].amt901,g_glar_d[l_i].amt902,g_glar_d[l_i].amt903,
                g_glar_d[l_i].amt911,g_glar_d[l_i].amt912,g_glar_d[l_i].amt913, g_glar_d[l_i].amt921,g_glar_d[l_i].amt922,g_glar_d[l_i].amt923,
                g_glar_d[l_i].amt931,g_glar_d[l_i].amt932,g_glar_d[l_i].amt933, g_glar_d[l_i].amt941,g_glar_d[l_i].amt942,g_glar_d[l_i].amt943,
                g_glar_d[l_i].amt951,g_glar_d[l_i].amt952,g_glar_d[l_i].amt953, g_glar_d[l_i].amt961,g_glar_d[l_i].amt962,g_glar_d[l_i].amt963,
                g_glar_d[l_i].amt971,g_glar_d[l_i].amt972,g_glar_d[l_i].amt973, g_glar_d[l_i].amt981,g_glar_d[l_i].amt982,g_glar_d[l_i].amt983,
                g_glar_d[l_i].amt991,g_glar_d[l_i].amt992,g_glar_d[l_i].amt993, g_glar_d[l_i].amt1001,g_glar_d[l_i].amt1002,g_glar_d[l_i].amt1003,
                l_glaald_desc,l_glaacomp_desc,l_curr,l_sdate,l_edate,l_ctype,l_fix_acc,l_stype,tm.glac005,l_stus)
   END FOR

   SELECT COUNT(*) INTO l_n FROM aglq730_tmp01               #160727-00019#3  Mod  aglq730_print_tmp -->aglq730_tmp01
   DISPLAY "aglq730:",l_n
   DISPLAY "SQLCA:",SQLCA.sqlerrd[2]
   CALL aglq730_x01(" 1=1","aglq730_tmp01",g_col,tm.ctype)   #160727-00019#3  Mod  aglq730_print_tmp -->aglq730_tmp01


END FUNCTION

 
{</section>}
 
