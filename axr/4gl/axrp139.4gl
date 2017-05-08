#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp139.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-05-20 18:20:25), PR版次:0012(2016-12-23 10:23:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: axrp139
#+ Description: 租賃費用認列收入批次立帳作業
#+ Creator....: 05948(2016-05-19 14:37:04)
#+ Modifier...: 05948 -SD/PR- 07900
 
{</section>}
 
{<section id="axrp139.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150609-00004#30   2016/06/13  by liyan  增加xrcb055,xrcb056,xrcb057取值邏輯
#160509-00004#63   2016/06/14  By 02114  如果来源单号+项次在anmt564中已经存在,则把应收单号回写anmt564中的nmee027栏位
#160509-00004#86   2016/06/28  By 02114  anmt564已经弃用,改成了axrt800,原本axrp139和axrt211与anmt564之前的卡控改成与axrt800的卡控
#160811-00009#4    2016/08/22  By 01531  账务中心/法人/账套权限控管
#160905-00007#18   2016/09/05  By 01531  调整系统中无ENT的SQL条件增加ent
#161021-00050#3    2016/10/24  By 08729  處理組織開窗
#161123-00048#4    2016/11/25  By 08729  開窗增加過濾據點
#161128-00061#3    2016/12/01  by 02481  标准程式定义采用宣告模式,弃用.*写法
#161223-00004#1    2016/12/23  By 07900  'g_enterpise'->'g_enterprise'
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       xrcasite LIKE xrca_t.xrcasite, 
   xrcasite_desc LIKE type_t.chr80, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE type_t.chr80, 
   glav002 LIKE glav_t.glav002, 
   glav006 LIKE glav_t.glav006, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocno_desc LIKE type_t.chr80, 
   xrca008 LIKE xrca_t.xrca008, 
   xrca008_desc LIKE type_t.chr80, 
   xrca007 LIKE xrca_t.xrca007, 
   xrca007_desc LIKE type_t.chr80, 
   b_check2 LIKE type_t.chr500, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   stbc008 LIKE stbc_t.stbc008, 
   stbc004 LIKE stbc_t.stbc004, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 TYPE type_xrca RECORD
         xrcaent        LIKE xrca_t.xrcaent,
         xrcastus       LIKE xrca_t.xrcastus,
         xrcacomp       LIKE xrca_t.xrcacomp,
         xrcald         LIKE xrca_t.xrcald,
         xrcadocno      LIKE xrca_t.xrcadocno,
         xrcadocdt      LIKE xrca_t.xrcadocdt,
         xrcasite       LIKE xrca_t.xrcasite,
         xrca001        LIKE xrca_t.xrca001,
         xrca003        LIKE xrca_t.xrca003,
         xrca004        LIKE xrca_t.xrca004,
         xrca005        LIKE xrca_t.xrca005,
         xrca006        LIKE xrca_t.xrca006,
         xrca007        LIKE xrca_t.xrca007,
         xrca008        LIKE xrca_t.xrca008,
         xrca009        LIKE xrca_t.xrca009,
         xrca010        LIKE xrca_t.xrca010,
         xrca011        LIKE xrca_t.xrca011,
         xrca012        LIKE xrca_t.xrca012,
         xrca013        LIKE xrca_t.xrca013,
         xrca014        LIKE xrca_t.xrca014,
         xrca015        LIKE xrca_t.xrca015,
         xrca016        LIKE xrca_t.xrca016,
         xrca017        LIKE xrca_t.xrca017,
         xrca018        LIKE xrca_t.xrca018,
         xrca019        LIKE xrca_t.xrca019,
         xrca020        LIKE xrca_t.xrca020,
         xrca021        LIKE xrca_t.xrca021,
         xrca022        LIKE xrca_t.xrca022,
         xrca023        LIKE xrca_t.xrca023,
         xrca024        LIKE xrca_t.xrca024,
         xrca025        LIKE xrca_t.xrca025,
         xrca026        LIKE xrca_t.xrca026,
         xrca028        LIKE xrca_t.xrca028,
         xrca029        LIKE xrca_t.xrca029,
         xrca030        LIKE xrca_t.xrca030,
         xrca031        LIKE xrca_t.xrca031,
         xrca032        LIKE xrca_t.xrca032,
         xrca033        LIKE xrca_t.xrca033,
         xrca034        LIKE xrca_t.xrca034,
         xrca035        LIKE xrca_t.xrca035,
         xrca036        LIKE xrca_t.xrca036,
         xrca037        LIKE xrca_t.xrca037,
         xrca038        LIKE xrca_t.xrca038,
         xrca039        LIKE xrca_t.xrca039,
         xrca040        LIKE xrca_t.xrca040,
         xrca041        LIKE xrca_t.xrca041,
         xrca042        LIKE xrca_t.xrca042,
         xrca043        LIKE xrca_t.xrca043,
         xrca044        LIKE xrca_t.xrca044,
         xrca045        LIKE xrca_t.xrca045,
         xrca046        LIKE xrca_t.xrca046,
         xrca047        LIKE xrca_t.xrca047,
         xrca048        LIKE xrca_t.xrca048,
         xrca049        LIKE xrca_t.xrca049,
         xrca050        LIKE xrca_t.xrca050,
         xrca051        LIKE xrca_t.xrca051,
         xrca052        LIKE xrca_t.xrca052,
         xrca053        LIKE xrca_t.xrca053,
         xrca054        LIKE xrca_t.xrca054,
         xrca055        LIKE xrca_t.xrca055,
         xrca056        LIKE xrca_t.xrca056,
         xrca057        LIKE xrca_t.xrca057,
         xrca058        LIKE xrca_t.xrca058,
         xrca059        LIKE xrca_t.xrca059,
         xrca060        LIKE xrca_t.xrca060,
         xrca061        LIKE xrca_t.xrca061,
         xrca062        LIKE xrca_t.xrca062,
         xrca063        LIKE xrca_t.xrca063,
         xrca064        LIKE xrca_t.xrca064,
         xrca065        LIKE xrca_t.xrca065,
         xrca066        LIKE xrca_t.xrca066,
         xrca100        LIKE xrca_t.xrca100,
         xrca101        LIKE xrca_t.xrca101,
         xrca103        LIKE xrca_t.xrca103,
         xrca104        LIKE xrca_t.xrca104,
         xrca106        LIKE xrca_t.xrca106,
         xrca107        LIKE xrca_t.xrca107,
         xrca108        LIKE xrca_t.xrca108,
         xrca113        LIKE xrca_t.xrca113,
         xrca114        LIKE xrca_t.xrca114,
         xrca116        LIKE xrca_t.xrca116,
         xrca117        LIKE xrca_t.xrca117,
         xrca118        LIKE xrca_t.xrca118,
         xrca120        LIKE xrca_t.xrca120,
         xrca121        LIKE xrca_t.xrca121,
         xrca123        LIKE xrca_t.xrca123,
         xrca124        LIKE xrca_t.xrca124,
         xrca126        LIKE xrca_t.xrca126,
         xrca127        LIKE xrca_t.xrca127,
         xrca128        LIKE xrca_t.xrca128,
         xrca130        LIKE xrca_t.xrca130,
         xrca131        LIKE xrca_t.xrca131,
         xrca133        LIKE xrca_t.xrca133,
         xrca134        LIKE xrca_t.xrca134,
         xrca136        LIKE xrca_t.xrca136,
         xrca137        LIKE xrca_t.xrca137,
         xrca138        LIKE xrca_t.xrca138,
         xrcaownid      LIKE xrca_t.xrcaownid,
         xrcaowndp      LIKE xrca_t.xrcaowndp,
         xrcacrtid      LIKE xrca_t.xrcacrtid,
         xrcacrtdp      LIKE xrca_t.xrcacrtdp,
         xrcacrtdt      LIKE xrca_t.xrcacrtdt,
         xrcamodid      LIKE xrca_t.xrcamodid,
         xrcamoddt      LIKE xrca_t.xrcamoddt,
         xrcacnfid      LIKE xrca_t.xrcacnfid,
         xrcacnfdt      LIKE xrca_t.xrcacnfdt,
         xrcapstid      LIKE xrca_t.xrcapstid,
         xrcapstdt      LIKE xrca_t.xrcapstdt
END RECORD

 TYPE type_xrcb RECORD
         xrcbent        LIKE xrcb_t.xrcbent,
         xrcbld         LIKE xrcb_t.xrcbld, 
         xrcbdocno      LIKE xrcb_t.xrcbdocno,
         xrcbseq        LIKE xrcb_t.xrcbseq,
         xrcbsite       LIKE xrcb_t.xrcbsite,
         xrcborga       LIKE xrcb_t.xrcborga,
         xrcblegl       LIKE xrcb_t.xrcblegl,
         xrcb001        LIKE xrcb_t.xrcb001,
         xrcb002        LIKE xrcb_t.xrcb002,
         xrcb003        LIKE xrcb_t.xrcb003,
         xrcb004        LIKE xrcb_t.xrcb004,
         xrcb005        LIKE xrcb_t.xrcb005,
         xrcb006        LIKE xrcb_t.xrcb006,
         xrcb007        LIKE xrcb_t.xrcb007,
         xrcb008        LIKE xrcb_t.xrcb008,
         xrcb009        LIKE xrcb_t.xrcb009,
         xrcb010        LIKE xrcb_t.xrcb010,
         xrcb011        LIKE xrcb_t.xrcb011,
         xrcb012        LIKE xrcb_t.xrcb012,
         xrcb013        LIKE xrcb_t.xrcb013,
         xrcb014        LIKE xrcb_t.xrcb014,
         xrcb015        LIKE xrcb_t.xrcb015,
         xrcb016        LIKE xrcb_t.xrcb016,
         xrcb017        LIKE xrcb_t.xrcb017,
         xrcb018        LIKE xrcb_t.xrcb018,
         xrcb019        LIKE xrcb_t.xrcb019,
         xrcb020        LIKE xrcb_t.xrcb020,
         xrcb021        LIKE xrcb_t.xrcb021,
         xrcb022        LIKE xrcb_t.xrcb022,
         xrcb023        LIKE xrcb_t.xrcb023,
         xrcb024        LIKE xrcb_t.xrcb024,
         xrcb025        LIKE xrcb_t.xrcb025,
         xrcb026        LIKE xrcb_t.xrcb026,
         xrcb027        LIKE xrcb_t.xrcb027,
         xrcb028        LIKE xrcb_t.xrcb028,
         xrcb029        LIKE xrcb_t.xrcb029,
         xrcb030        LIKE xrcb_t.xrcb030,
         xrcb031        LIKE xrcb_t.xrcb031,
         xrcb032        LIKE xrcb_t.xrcb032,
         xrcb033        LIKE xrcb_t.xrcb033,
         xrcb034        LIKE xrcb_t.xrcb034,
         xrcb035        LIKE xrcb_t.xrcb035,
         xrcb036        LIKE xrcb_t.xrcb036,
         xrcb037        LIKE xrcb_t.xrcb037,
         xrcb038        LIKE xrcb_t.xrcb038,
         xrcb039        LIKE xrcb_t.xrcb039,
         xrcb040        LIKE xrcb_t.xrcb040,
         xrcb041        LIKE xrcb_t.xrcb041,
         xrcb042        LIKE xrcb_t.xrcb042,
         xrcb043        LIKE xrcb_t.xrcb043,
         xrcb044        LIKE xrcb_t.xrcb044,
         xrcb045        LIKE xrcb_t.xrcb045,
         xrcb046        LIKE xrcb_t.xrcb046,
         xrcb047        LIKE xrcb_t.xrcb047,
         xrcb048        LIKE xrcb_t.xrcb048,
         xrcb049        LIKE xrcb_t.xrcb049,
         xrcb050        LIKE xrcb_t.xrcb050,
         xrcb051        LIKE xrcb_t.xrcb051,
         xrcb053        LIKE xrcb_t.xrcb053,    #160509-00004#62 add lujh
         xrcb054        LIKE xrcb_t.xrcb054,    #160509-00004#62 add lujh
         xrcb058        LIKE xrcb_t.xrcb058,    #160509-00004#67 add lujh
         xrcb059        LIKE xrcb_t.xrcb059,    #160509-00004#67 add lujh
         xrcb060        LIKE xrcb_t.xrcb060,    #160509-00004#67 add lujh
         xrcb100        LIKE xrcb_t.xrcb100,
         xrcb101        LIKE xrcb_t.xrcb101,
         xrcb102        LIKE xrcb_t.xrcb102,
         xrcb103        LIKE xrcb_t.xrcb103,
         xrcb104        LIKE xrcb_t.xrcb104,
         xrcb105        LIKE xrcb_t.xrcb105,
         xrcb106        LIKE xrcb_t.xrcb106,
         xrcb111        LIKE xrcb_t.xrcb111,
         xrcb113        LIKE xrcb_t.xrcb113,
         xrcb114        LIKE xrcb_t.xrcb114,
         xrcb115        LIKE xrcb_t.xrcb115,
         xrcb116        LIKE xrcb_t.xrcb116,
         xrcb117        LIKE xrcb_t.xrcb117,
         xrcb118        LIKE xrcb_t.xrcb118,
         xrcb119        LIKE xrcb_t.xrcb119,
         xrcb121        LIKE xrcb_t.xrcb121,
         xrcb123        LIKE xrcb_t.xrcb123,
         xrcb124        LIKE xrcb_t.xrcb124,
         xrcb125        LIKE xrcb_t.xrcb125,
         xrcb126        LIKE xrcb_t.xrcb126,
         xrcb131        LIKE xrcb_t.xrcb131,
         xrcb133        LIKE xrcb_t.xrcb133,
         xrcb134        LIKE xrcb_t.xrcb134,
         xrcb135        LIKE xrcb_t.xrcb135,
         xrcb136        LIKE xrcb_t.xrcb136,
         xrcb055        LIKE xrcb_t.xrcb055,    #add by liyan 
         xrcb056        LIKE xrcb_t.xrcb056,    #add by liyan
         xrcb057        LIKE xrcb_t.xrcb057     #add by liyan
END RECORD
DEFINE g_xrca           type_xrca
DEFINE g_xrcb           type_xrcb

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#161128-00061#3-----modify--begin----------
#DEFINE g_glaa                RECORD LIKE glaa_t.*
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
       
#161128-00061#3-----modify--end----------


DEFINE g_glav002        LIKE glav_t.glav002
DEFINE g_glav005        LIKE glav_t.glav005
DEFINE g_sdate_s        LIKE glav_t.glav004
DEFINE g_sdate_e        LIKE glav_t.glav004
DEFINE g_glav006        LIKE glav_t.glav006
DEFINE g_glav007        LIKE glav_t.glav007
DEFINE g_pdate_s        LIKE glav_t.glav004
DEFINE g_pdate_e        LIKE glav_t.glav004
DEFINE g_wdate_s        LIKE glav_t.glav004
DEFINE g_wdate_e        LIKE glav_t.glav004
DEFINE g_sql_ctrl       STRING                #161123-00048#4-add
DEFINE g_comp           LIKE glaa_t.glaacomp  #161123-00048#4-add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp139.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success         LIKE type_t.num5   #20150422 add lujh
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
  #CALL axrp139_def()    #151201-00002#5 Mark
   CALL s_fin_create_account_center_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success    #2014/12/4
   CALL s_axrt300_create_tmp()

  #151201-00002#5 Add  ---(S)---
   IF NOT cl_null(g_argv[01]) THEN
      LET g_bgjob = g_argv[01]
   END IF
  #151201-00002#5 Add  ---(E)---

   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
     #151201-00002#5 Add  ---(S)---
      LET g_master.xrcasite = g_argv[02]
      LET g_master.xrcald = g_argv[03]
      LET g_master.glav002 = g_argv[04]
      LET g_master.glav006 = g_argv[05]
      LET g_master.xrcadocno = g_argv[06]
      LET g_master.xrcadocdt = g_argv[08]
      LET g_master.wc = "stbedocno = '",g_argv[09],"'"
      LET g_master.b_check2 = 'Y'
      LET g_master.xrcadocdt = g_today
     #151201-00002#5 Add  ---(E)---
      #end add-point
      CALL axrp139_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp139 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp139_init()
 
      #進入選單 Menu (="N")
      CALL axrp139_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp139
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp139.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrp139_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success         LIKE type_t.num5
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('xmdk000','2077','1,2,3,6')
   CALL s_fin_create_account_center_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success
   CALL s_axrt300_create_tmp()
   CALL cl_set_combo_scc("source","8350")     #151201-00002#61 add lujh
   #161123-00048#4-add
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl
   #161123-00048#4-add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp139.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp139_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_s               LIKE type_t.num5
   DEFINE l_n               LIKE type_t.num5
   DEFINE l_ooef004         LIKE ooef_t.ooef004
   DEFINE l_ooef019         LIKE ooef_t.ooef019
   DEFINE l_flag1           LIKE type_t.chr1       
   DEFINE l_errno           LIKE type_t.chr100
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_glaa003         LIKE glaa_t.glaa003
   DEFINE l_glaacomp        LIKE glaa_t.glaacomp
   DEFINE l_origin_str      STRING
  #151201-00002#5 Add  ---(S)---
   DEFINE l_dfin1004        LIKE ooac_t.ooac004
   DEFINE l_dfin0030        LIKE type_t.chr1
  #151201-00002#5 Add  ---(E)---
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrcadocno,g_master.xrca008,g_master.xrca007,g_master.b_check2,g_master.xrcadocdt  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
            #帳款單別
            LET g_master.xrcadocno_desc = ''
            DISPLAY BY NAME g_master.xrcadocno_desc
            IF NOT cl_null(g_master.xrcadocno) THEN 
               CALL s_aooi200_fin_chk_slip(g_master.xrcald,l_glaa024,g_master.xrcadocno,'axrt211') RETURNING l_success   #160509-00004#62 change axrt210 to axrt211 lujh
               IF l_success = FALSE THEN 
                  LET g_master.xrcadocno = ''
                  NEXT FIELD xrcadocno
               END IF
               CALL s_fin_get_doc_para(g_master.xrcald,'',g_master.xrcadocno,'D-FIN-1004') RETURNING l_dfin1004
               CALL s_fin_get_doc_para(g_master.xrcald,'',g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.xrcadocno)RETURNING g_master.xrcadocno_desc
            DISPLAY BY NAME g_master.xrcadocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="input.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocno
            #add-point:ON CHANGE xrcadocno name="input.g.xrcadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca008
            
            #add-point:AFTER FIELD xrca008 name="input.a.xrca008"
            IF NOT cl_null(g_master.xrca008) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xrca008
               LET g_chkparam.arg2 = ' '
               #160318-00025#42  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apm-00184:sub-01302|aooi714|",cl_get_progname("aooi714",g_lang,"2"),"|:EXEPROGaooi714"
               #160318-00025#42  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooib002_1") THEN
                  LET g_master.xrca008 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca008
            #add-point:BEFORE FIELD xrca008 name="input.b.xrca008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca008
            #add-point:ON CHANGE xrca008 name="input.g.xrca008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca007
            
            #add-point:AFTER FIELD xrca007 name="input.a.xrca007"
            IF NOT cl_null(g_master.xrca007) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xrca007
               #160318-00025#42  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00200:sub-01302|axri012|",cl_get_progname("axri012",g_lang,"2"),"|:EXEPROGaxri012"
               #160318-00025#42  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_oocq002_3111") THEN
                  LET g_master.xrca007 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca007
            #add-point:BEFORE FIELD xrca007 name="input.b.xrca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca007
            #add-point:ON CHANGE xrca007 name="input.g.xrca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check2
            #add-point:BEFORE FIELD b_check2 name="input.b.b_check2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check2
            
            #add-point:AFTER FIELD b_check2 name="input.a.b_check2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check2
            #add-point:ON CHANGE b_check2 name="input.g.b_check2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocdt
            #add-point:BEFORE FIELD xrcadocdt name="input.b.xrcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocdt
            
            #add-point:AFTER FIELD xrcadocdt name="input.a.xrcadocdt"
            IF NOT cl_null(g_master.xrcadocdt) THEN
               CALL s_axrt300_date_chk(g_master.xrcasite,g_master.xrcadocdt) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "axr-00299"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  NEXT FIELD CURRENT
               END IF
#160509-00004#93--mark by lvjh-- str -- 这段管控移至 AFTER DIALOG
#               #150210-00011(1)--20150330--add--
#               CALL s_get_accdate(l_glaa003,g_master.xrcadocdt,'','') 
#               RETURNING l_flag1,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
#                         g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
#               #150210-00011(1)--20150330--add--
#                   
#               #160509-00004#66--add--str--lujh                   
#               IF (g_glav002 = g_master.glav002 AND g_glav006 <> g_master.glav006) OR g_glav002 <> g_master.glav002 THEN 
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = "axr-01019"
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err() 
#                  NEXT FIELD CURRENT
#               END IF
#               #160509-00004#66--add--end--lujh
#160509-00004#93--mark by lvjh-- end -- 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocdt
            #add-point:ON CHANGE xrcadocdt name="input.g.xrcadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            SELECT ooef004 INTO l_ooef004 from ooef_t where ooefent = g_enterprise AND ooef001 = l_glaacomp
            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaald = g_master.xrcald     
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcadocno             #給予default值
            #給予arg
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'axrt211'   #160509-00004#62 change axrt210 to axrt211 lujh
            
            CALL q_ooba002_1()
            LET g_master.xrcadocno = g_qryparam.return1              
            DISPLAY g_master.xrcadocno TO xrcadocno              #
            CALL s_aooi200_fin_get_slip_desc(g_master.xrcadocno)RETURNING g_master.xrcadocno_desc
            NEXT FIELD xrcadocno  
            #END add-point
 
 
         #Ctrlp:input.c.xrca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca008
            #add-point:ON ACTION controlp INFIELD xrca008 name="input.c.xrca008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrca008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooib001_1()                                #呼叫開窗

            LET g_master.xrca008 = g_qryparam.return1              

            DISPLAY g_master.xrca008 TO xrca008              #

            NEXT FIELD xrca008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca007
            #add-point:ON ACTION controlp INFIELD xrca007 name="input.c.xrca007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrca007             #給予default值
            LET g_qryparam.default2 = "" #g_master.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3111" #          
            CALL q_oocq002()                                #呼叫開窗
            LET g_master.xrca007 = g_qryparam.return1              
            DISPLAY g_master.xrca007 TO xrca007              #
            NEXT FIELD xrca007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.b_check2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check2
            #add-point:ON ACTION controlp INFIELD b_check2 name="input.c.b_check2"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocdt
            #add-point:ON ACTION controlp INFIELD xrcadocdt name="input.c.xrcadocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stbc008,stbc004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stbc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc008
            #add-point:ON ACTION controlp INFIELD stbc008 name="construct.c.stbc008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161123-00048#4-add(s)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161123-00048#4-add(e)
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc008  #顯示到畫面上
            NEXT FIELD stbc008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc008
            #add-point:BEFORE FIELD stbc008 name="construct.b.stbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc008
            
            #add-point:AFTER FIELD stbc008 name="construct.a.stbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc004
            #add-point:ON ACTION controlp INFIELD stbc004 name="construct.c.stbc004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stbc003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc004  #顯示到畫面上
            NEXT FIELD stbc004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc004
            #add-point:BEFORE FIELD stbc004 name="construct.b.stbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc004
            
            #add-point:AFTER FIELD stbc004 name="construct.a.stbc004"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.xrcasite,g_master.xrcald,g_master.glav002,g_master.glav006
            ATTRIBUTE(WITHOUT DEFAULTS)
                             
            AFTER FIELD xrcasite
               IF NOT cl_null(g_master.xrcasite) THEN
                  #161021-00050#3-add(s)
                  CALL s_fin_account_center_with_ld_chk(g_master.xrcasite,g_master.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_master.xrcasite
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.xrcasite = ''
                        LET g_master.xrcald = ''
                        LET g_master.xrcasite_desc = ''
                        LET g_master.xrcald_desc = ''
                        DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                        DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
                        NEXT FIELD CURRENT
                     END IF
                  #161021-00050#3-add(e) 
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
                  DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                  DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
                  IF NOT l_success THEN NEXT FIELD CURRENT END IF
                  CALL s_axrt300_date_chk(g_master.xrcasite,g_master.xrcadocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axr-00299"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_master.xrcasite_desc = ''
               END IF
               SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               #161128-00061#3-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#3-----modify--end----------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#4-add

            AFTER FIELD xrcald
               IF NOT cl_null(g_master.xrcald) THEN 
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
                  DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                  DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
                  IF NOT l_success THEN
                     SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
                      WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
                     #161128-00061#3-----modify--begin----------
                     #SELECT * INTO g_glaa.* 
                      SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                             glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                             glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                             glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                             glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                             glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                     #161128-00061#3-----modify--end----------
                     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_master.xrcald_desc = ''
               END IF
               #161128-00061#3-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#3-----modify--end---------- 
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#4-add

             AFTER FIELD glav002
               SELECT count(*) INTO l_n FROM glav_t
                WHERE glav001 IN (select glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_master.xrcald)
                  AND glavent = g_enterprise
                  AND glav002=g_master.glav002
               IF l_n = 0 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "axr-01010"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  NEXT FIELD glva002
               END IF 
            
            AFTER FIELD glav006
               SELECT count(*) INTO l_n FROM glav_t
                WHERE glav001 IN (select glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_master.xrcald)
                  AND glavent = g_enterprise
                  AND glav002=g_master.glav002
                  and glav006=g_master.glav006
               IF l_n = 0 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "axr-01011"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  NEXT FIELD glva006
               END IF 
            
            ON ACTION controlp INFIELD xrcasite
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrcasite             #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 

               #給予arg

               #CALL q_ooef001()                                        #呼叫開窗    #161021-00050#3 mark
               LET g_qryparam.where = " ooefstus = 'Y' "                            #161021-00050#3 add
               CALL q_ooef001_46()                                                  #161021-00050#3 add
               LET g_master.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
               IF NOT cl_null(g_master.xrcasite) THEN
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
                  SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               END IF
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               NEXT FIELD xrcasite

            ON ACTION controlp INFIELD xrcald
               CALL s_fin_create_account_center_tmp()   
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc
               #將取回的字串轉換為SQL條件
               CALL axrp139_get_ooef001_wc(ls_wc) RETURNING ls_wc  
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrcald             #給予default值
#160811-00009#4 mod s---              
#              IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#              ELSE
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#              END IF
              LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#160811-00009#4 mod e---
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL  q_authorised_ld()                                  #呼叫開窗
               LET g_master.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
               IF NOT cl_null(g_master.xrcald) THEN
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
                  SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               END IF
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               NEXT FIELD xrcald                              #返回原欄位  

         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL axrp139_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL axrp139_def()
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            INITIALIZE g_master.* TO NULL
            CALL axrp139_def()
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         #160509-00004#93--add by lvjh-- str -- 
         AFTER DIALOG
            #150210-00011(1)--20150330--add--
            CALL s_get_accdate(l_glaa003,g_master.xrcadocdt,'','') 
            RETURNING l_flag1,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                      g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
            #150210-00011(1)--20150330--add--
                
            #160509-00004#66--add--str--lujh                   
            IF (g_glav002 = g_master.glav002 AND g_glav006 <> g_master.glav006) OR g_glav002 <> g_master.glav002 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "axr-01019"
               LET g_errparam.popup  = TRUE 
               CALL cl_err() 
               NEXT FIELD xrcadocdt
            END IF
            #160509-00004#66--add--end--lujh
         #160509-00004#93--add by lvjh-- end --
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axrp139_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axrp139_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrp139_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrp139.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrp139_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axrp139.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrp139_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_gzzd005         LIKE gzzd_t.gzzd005
   #20150422--add--str--lujh
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_tot_success     LIKE type_t.num5
   DEFINE l_start_no        LIKE xrca_t.xrcadocno
   DEFINE l_end_no          LIKE xrca_t.xrcadocno
   #20150422--add--end--lujh
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
  ##執行步驟:
  ##STEP1.取得符合條件的出貨單據
  ##STEP2.產生應收單據
  #LET li_count = 2
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axrp139_process_cs CURSOR FROM ls_sql
#  FOREACH axrp139_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"

      CALL axrp139_get_ar()     
      RETURN
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      #20150422--add--str--lujh
      #錯誤訊息匯總初始化
      CALL cl_err_collect_init()
      LET g_success    = 'Y'
      LET g_totsuccess = 'Y'

     #CALL axrp139_get_data()
     #
     #IF g_success = 'N' THEN
     #   CALL cl_err_collect_show()
     #   DROP TABLE axrp139_xmdk_tmp
     #   #清空進度條
     #   DISPLAY '' ,0 TO stagenow,stagecomplete
     #   DROP TABLE axrp131_xmdk_tmp
     #   RETURN
     #   RETURN
     #END IF

      CALL s_axrt300_create_tmp()

      CALL s_transaction_begin()

      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp139' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step2'
      CALL cl_progress_no_window_ing(l_gzzd005)
      DROP TABLE axrp139_xmdk_tmp

      IF g_success = 'N' THEN
         #清空進度條
         DISPLAY '' ,0 TO stagenow,stagecomplete
      END IF

      RETURN
      #20150422--add--end--lujh
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axrp139_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp139.get_buffer" >}
PRIVATE FUNCTION axrp139_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xrcadocno = p_dialog.getFieldBuffer('xrcadocno')
   LET g_master.xrca008 = p_dialog.getFieldBuffer('xrca008')
   LET g_master.xrca007 = p_dialog.getFieldBuffer('xrca007')
   LET g_master.b_check2 = p_dialog.getFieldBuffer('b_check2')
   LET g_master.xrcadocdt = p_dialog.getFieldBuffer('xrcadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrp139.msgcentre_notify" >}
PRIVATE FUNCTION axrp139_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp139.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 給帳務中心、帳套賦默認值
# Memo...........:
# Usage..........: CALL axrp139_def()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp139_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_xrcacomp    LIKE xrca_t.xrcacomp
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_errno       LIKE type_t.chr100
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_glav002     LIKE glav_t.glav002
   DEFINE l_glav005     LIKE glav_t.glav005
   DEFINE l_sdate_s     LIKE glav_t.glav004
   DEFINE l_sdate_e     LIKE glav_t.glav004
   DEFINE l_glav006     LIKE glav_t.glav006
   DEFINE l_glav007     LIKE glav_t.glav007
   DEFINE l_wdate_s     LIKE glav_t.glav004
   DEFINE l_wdate_e     LIKE glav_t.glav004

   IF cl_null(g_master.xrcasite) OR cl_null(g_master.xrcald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xrcasite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_master.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_master.xrcald   
      CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_xrcacomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#4-add
      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_master.xrcald   = ''
      END IF

      CALL s_axrt300_xrca_ref('xrcald',g_master.xrcald,'','') RETURNING l_success,g_master.xrcald_desc
      CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
      DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
   END IF

   IF cl_null(g_master.xrcadocdt) THEN LET g_master.xrcadocdt = g_today END IF
   SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_master.xrcald
   IF NOT cl_null(l_glaa003) THEN
      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(l_glaa003,g_today,'','')
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   END IF

   LET g_master.glav002 = l_glav002
   LET g_master.glav006 = l_glav006
   let g_master.b_check2 = 'Y'

   CALL cl_set_comp_entry('xrcadocno',TRUE)
  # CALL cl_set_comp_visible('stbd001,stbd022,xrcadocno',TRUE)
   IF cl_null(g_master.b_check2) THEN LET g_master.b_check2 = 'N' END IF
   DISPLAY BY NAME g_master.xrcadocdt,g_master.glav002,g_master.glav006,g_master.b_check2
                

END FUNCTION
################################################################################
# Descriptions...: 依據客戶編號獲取默認值
# Memo...........:
# Usage..........: CALL axrp139_xrca004_ref()
#                  RETURNING r_xrca.*
# Input parameter: 
# Return code....: r_xrca         返回默认值
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp139_xrca004_ref()
DEFINE l_ooba002      LIKE ooba_t.ooba002
DEFINE l_success      LIKE type_t.num5
DEFINE l_pmab085      LIKE pmab_t.pmab085
#161128-00061#3-----modify--begin----------
#DEFINE l_ooib         RECORD LIKE ooib_t.*
DEFINE l_ooib RECORD  #收付款條件主檔
       ooibent LIKE ooib_t.ooibent, #企業編號
       ooibownid LIKE ooib_t.ooibownid, #資料所有者
       ooibowndp LIKE ooib_t.ooibowndp, #資料所屬部門
       ooibcrtid LIKE ooib_t.ooibcrtid, #資料建立者
       ooibcrtdp LIKE ooib_t.ooibcrtdp, #資料建立部門
       ooibcrtdt LIKE ooib_t.ooibcrtdt, #資料創建日
       ooibmodid LIKE ooib_t.ooibmodid, #資料修改者
       ooibmoddt LIKE ooib_t.ooibmoddt, #最近修改日
       ooibstus LIKE ooib_t.ooibstus, #狀態碼
       ooib001 LIKE ooib_t.ooib001, #收款/付款
       ooib002 LIKE ooib_t.ooib002, #收付款條件編號
       ooib004 LIKE ooib_t.ooib004, #款別性質
       ooib005 LIKE ooib_t.ooib005, #慣用繳款優惠條件
       ooib006 LIKE ooib_t.ooib006, #訂金收取否
       ooib007 LIKE ooib_t.ooib007, #現付交易否
       ooib011 LIKE ooib_t.ooib011, #應收付款起算基準
       ooib012 LIKE ooib_t.ooib012, #應收付款日加(季)
       ooib013 LIKE ooib_t.ooib013, #應收付款日加(月)
       ooib014 LIKE ooib_t.ooib014, #應收付款日加(日)
       ooib021 LIKE ooib_t.ooib021, #帳款兌現起算基準
       ooib022 LIKE ooib_t.ooib022, #帳款兌現日加(季)
       ooib023 LIKE ooib_t.ooib023, #帳款兌現日加(月)
       ooib024 LIKE ooib_t.ooib024, #帳款兌現日加(日)
       ooib025 LIKE ooib_t.ooib025, #慣用多帳期類型　
       ooib026 LIKE ooib_t.ooib026  #尾款性質
       END RECORD
#161128-00061#3-----modify--end----------
DEFINE l_glaa001      LIKE glaa_t.glaa001
DEFINE l_glaa025      LIKE glaa_t.glaa025
#151201-00002#5 Add  ---(S)---
DEFINE l_pmaa204      LIKE pmaa_t.pmaa204   #经营方式 
DEFINE l_sfin8001     LIKE type_t.chr10     #自营应收默认账款类型
DEFINE l_sfin8002     LIKE type_t.chr10     #联营应收默认账款类型
#151201-00002#5 Add  ---(E)---
DEFINE r_xrca         RECORD
          xrca005     LIKE xrca_t.xrca005,
          xrca006     LIKE xrca_t.xrca006,
          xrca007     LIKE xrca_t.xrca007,
          xrca008     LIKE xrca_t.xrca008,
          xrca009     LIKE xrca_t.xrca009,
          xrca010     LIKE xrca_t.xrca010,
          xrca011     LIKE xrca_t.xrca011,
          xrca014     LIKE xrca_t.xrca014,
          xrca015     LIKE xrca_t.xrca015,
          xrca046     LIKE xrca_t.xrca046,
          xrca058     LIKE xrca_t.xrca058,
          xrca061     LIKE xrca_t.xrca061,
          xrca100     LIKE xrca_t.xrca100,
          xrca101     LIKE xrca_t.xrca101,
          xrca121     LIKE xrca_t.xrca121,
          xrca131     LIKE xrca_t.xrca131
                      END RECORD
DEFINE l_cnt      LIKE type_t.num5      #160505-00005#1
DEFINE l_xrcacomp LIKE xrca_t.xrcacomp  #160505-00005#1                      

   #新增/修改帳款對象後,依帳款對象更新客戶慣用資料
   
   ################################################
   #      STEP1-7 欄位取用原則:
   #      取 xrcacomp =pmabsite  為條件取  
   ################################################  

   #160505-00005#1# add--str--
   #检查是否抛转据点，若没则抓取pmabsite=ALL的相关栏位资料
   LET l_cnt = 0
   LET l_xrcacomp = NULL
   SELECT COUNT(*) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_xrca.xrcacomp AND pmab001 = g_xrca.xrca004
   IF l_cnt = 0 THEN 
      LET l_xrcacomp = "ALL" 
   ELSE
      LET l_xrcacomp = g_xrca.xrcacomp   
   END IF
   #160505-00005#1# add--end--

   SELECT glaa001,glaa025 INTO l_glaa001,l_glaa025 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_xrca.xrcald

   #STEP1.獲取交易對象簡稱
   
   #STEP2.帶出主要應收條件
   SELECT pmab087 INTO r_xrca.xrca008 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #應收日期/票據到期日
   #161128-00061#3-----modify--begin----------
   #SELECT * INTO l_ooib.* 
    SELECT ooibent,ooibownid,ooibowndp,ooibcrtid,ooibcrtdp,ooibcrtdt,ooibmodid,ooibmoddt,ooibstus,
           ooib001,ooib002,ooib004,ooib005,ooib006,ooib007,ooib011,ooib012,ooib013,ooib014,ooib021,
           ooib022,ooib023,ooib024,ooib025,ooib026 INTO l_ooib.* 
   #161128-00061#3-----modify--end----------
   FROM ooib_t WHERE ooibent = g_enterprise AND ooib001 = '2' AND ooib002 = r_xrca.xrca008
   IF NOT cl_null(g_xrca.xrca004) AND NOT cl_null(r_xrca.xrca008) THEN    #20160615 add lujh
      CALL s_fin_date_ar_receivable(g_xrca.xrcasite,g_xrca.xrca004,r_xrca.xrca008,g_xrca.xrcadocdt,
      g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') RETURNING l_success,r_xrca.xrca009,r_xrca.xrca010
   #20160615--add--str--lujh
   ELSE
      LET r_xrca.xrca009 = g_today
      LET r_xrca.xrca010 = g_today
   END IF
   #20160615--add--end--lujh
   
   #STEP3.帳款類別
   SELECT pmab105 INTO r_xrca.xrca007 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp


   #STEP4.業務人員/業務部門
   SELECT pmab081 INTO r_xrca.xrca014 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   SELECT ooag003 INTO r_xrca.xrca015 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = r_xrca.xrca014
   
   #STEP5.稅別/含稅否/稅率
#   SELECT pmab084 INTO r_xrca.xrca011 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #STEP6.慣用幣別/匯率
   LET r_xrca.xrca100 = l_glaa001
   #計算各個本位筆匯率
#   CASE g_master.b_comb1
#      WHEN '2'  #依立帳日匯率(aooi160)
#          CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,l_glaa001,0,l_glaa025)
#               RETURNING r_xrca.xrca101
#      WHEN '3'  #依立帳日月平均匯率(aooi170)
#          CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,l_glaa001,0,l_glaa025)
#               RETURNING g_sub_success,g_errno,r_xrca.xrca101
#   END CASE
  
   #STEP7.預開發票日
   SELECT pmab083 INTO l_pmab085 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp

   IF NOT cl_null(l_pmab085) THEN
      IF l_pmab085 = '30' THEN
         #月結彙總開立發票
         IF MONTH(g_xrca.xrcadocdt) = 12 THEN
            #立帳日期為12月份,則依照條件開立發票日為12月31號
            LET r_xrca.xrca061 = MDY(12,31,YEAR(g_xrca.xrcadocdt))
         ELSE
            #立帳日期的下一個月減一天
            LET r_xrca.xrca061 = MDY(MONTH(g_xrca.xrcadocdt) + 1,1,YEAR(g_xrca.xrcadocdt)) - 1
         END IF
      ELSE
         LET r_xrca.xrca061 = g_xrca.xrcadocdt
      END IF
   END IF

   #SETP8.收款客戶   
   SELECT pmac002 INTO r_xrca.xrca005 FROM pmac_t
    WHERE pmacent = g_enterprise AND pmac001 = g_xrca.xrca004 
      AND pmac003 = '1' AND pmac004 = 'Y' AND pmacstus = 'Y'
   IF SQLCA.sqlcode = 100 THEN
      LET r_xrca.xrca005 = g_xrca.xrca004
   END IF
      
   #SETP9.關係人   
   SELECT pmaa047 INTO r_xrca.xrca046 FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004     

   #SETP10.慣用銷售分類取
#   SELECT pmab089 INTO r_xrca.xrca058 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #SETP11.客戶分類
   SELECT pmaa090 INTO r_xrca.xrca006 FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004 

   RETURN r_xrca.*

END FUNCTION

################################################################################
# Descriptions...: 產生應收單據
# Memo...........:
# Usage..........: CALL axrp139_get_ar()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp139_get_ar()
   DEFINE l_sql            STRING
   DEFINE l_origin_str     STRING
   DEFINE l_xrca           RECORD
          xrca005          LIKE xrca_t.xrca005,
          xrca006          LIKE xrca_t.xrca006,
          xrca007          LIKE xrca_t.xrca007,
          xrca008          LIKE xrca_t.xrca008,
          xrca009          LIKE xrca_t.xrca009,
          xrca010          LIKE xrca_t.xrca010,
          xrca011          LIKE xrca_t.xrca011,
          xrca014          LIKE xrca_t.xrca014,
          xrca015          LIKE xrca_t.xrca015,
          xrca046          LIKE xrca_t.xrca046,
          xrca058          LIKE xrca_t.xrca058,
          xrca061          LIKE xrca_t.xrca061,
          xrca100          LIKE xrca_t.xrca100,
          xrca101          LIKE xrca_t.xrca101,
          xrca121          LIKE xrca_t.xrca121,
          xrca131          LIKE xrca_t.xrca131
                           END RECORD
   DEFINE l_stbc           DYNAMIC ARRAY OF RECORD 
             #160509-00004#73--mark--str--lujh   
             #stbc013       LIKE stbc_t.stbc013,   
             #stbc008       LIKE stbc_t.stbc008,
             #160509-00004#73--mark--end--lujh   
             stbc060       LIKE stbc_t.stbc060      #160509-00004#73 add lujh
             #160509-00004#73--mark--str--lujh   
             #stbc014       LIKE stbc_t.stbc014,
             #stbc009       LIKE stbc_t.stbc009,
             #stbc025       LIKE stbc_t.stbc025
             #160509-00004#73--mark--end--lujh   
                           END RECORD
   #160509-00004#73--mark--str--lujh
   #DEFINE l_stbc1           RECORD         
   #          stbcent       LIKE stbc_t.stbcent,
   #          stbcsite      LIKE stbc_t.stbcsite,
   #          stbc001       LIKE stbc_t.stbc001,
   #          stbc004       LIKE stbc_t.stbc004,
   #          stbc005       LIKE stbc_t.stbc005,
   #          stbc009       LIKE stbc_t.stbc009,
   #          stbc012       LIKE stbc_t.stbc012,
   #          stbc016       LIKE stbc_t.stbc016,
   #          stbc025       LIKE stbc_t.stbc025,
   #          stbc036       LIKE stbc_t.stbc036
   #                        END RECORD
   #160509-00004#73--mark--end--lujh
   DEFINE l_success        LIKE type_t.num5
   DEFINE t_success        LIKE type_t.chr1    #151201-00002#5 Add
   DEFINE l_tot_success    LIKE type_t.num5
   DEFINE l_ac             LIKE type_t.num5
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_glaa001        LIKE glaa_t.glaa001
   DEFINE l_glaa002        LIKE glaa_t.glaa002
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_glaa016        LIKE glaa_t.glaa016
   DEFINE l_glaa020        LIKE glaa_t.glaa020
   DEFINE l_glaa024        LIKE glaa_t.glaa024
   DEFINE l_glaa025        LIKE glaa_t.glaa025
   DEFINE l_glaacomp       LIKE glaa_t.glaacomp
   DEFINE l_glaa121        LIKE glaa_t.glaa121
   DEFINE l_glab005        LIKE glab_t.glab005
   DEFINE l_xrca035        LIKE xrca_t.xrca035
   DEFINE l_xrca036        LIKE xrca_t.xrca036
   DEFINE l_stbddocno      LIKE stbd_t.stbddocno
   DEFINE l_xrcadocno      LIKE xrca_t.xrcadocno
   DEFINE l_oodbl004       LIKE oodbl_t.oodbl004
   DEFINE l_oodb011        LIKE oodb_t.oodb011
   DEFINE l_sfin2017       LIKE xrca_t.xrca007
   DEFINE l_dfin0030       LIKE type_t.chr1
   DEFINE l_start_no       LIKE xrca_t.xrcadocno
   DEFINE l_end_no         LIKE xrca_t.xrcadocno
   DEFINE l_stan006        LIKE stan_t.stan006
   DEFINE l_stan007        LIKE stan_t.stan007
   DEFINE l_stan008        LIKE stan_t.stan008
   DEFINE l_ooefl003       LIKE ooefl_t.ooefl003
   DEFINE l_oodb005        LIKE oodb_t.oodb005
   DEFINE l_oodb006        LIKE oodb_t.oodb006
   DEFINE l_diff           LIKE xrcb_t.xrcb103
   DEFINE l_diff1          LIKE xrcb_t.xrcb103
   DEFINE l_xrcd009        LIKE xrcd_t.xrcd009
   DEFINE l_count1         LIKE type_t.num5
   DEFINE l_conf_success   LIKE type_t.num5
   DEFINE l_slip_success   LIKE type_t.num5
   DEFINE l_doc_success    LIKE type_t.num5  
   DEFINE l_ooba002        LIKE ooba_t.ooba002
   DEFINE l_dfin0031       LIKE type_t.chr1
   DEFINE l_dfin0032       LIKE type_t.chr1
   DEFINE l_stae005        LIKE stae_t.stae005    #160509-00004#66 add lujh
   #160509-00004#67--add--str--lujh
   DEFINE l_stae014        LIKE stae_t.stae014
   DEFINE l_stae_comp      LIKE ooef_t.ooef017
   DEFINE l_stbc_comp      LIKE ooef_t.ooef017
   #161128-00061#3-----modify--begin----------
  #DEFINE l_stbc1          RECORD LIKE stbc_t.*   #160509-00004#73 add lujh
  #DEFINE l_stbc2          RECORD LIKE stbc_t.*
  #DEFINE l_stbd           RECORD LIKE stbd_t.*
  #DEFINE l_stbe           RECORD LIKE stbe_t.*
   DEFINE l_stbc1 RECORD  #結算底稿
       stbcent LIKE stbc_t.stbcent, #企業編號
       stbcsite LIKE stbc_t.stbcsite, #營運據點
       stbc001 LIKE stbc_t.stbc001, #結算中心
       stbc002 LIKE stbc_t.stbc002, #單據日期
       stbc003 LIKE stbc_t.stbc003, #單據類別
       stbc004 LIKE stbc_t.stbc004, #單據編號
       stbc005 LIKE stbc_t.stbc005, #項次
       stbc006 LIKE stbc_t.stbc006, #業務結算期
       stbc007 LIKE stbc_t.stbc007, #財務會計年度
       stbc008 LIKE stbc_t.stbc008, #對象編號
       stbc009 LIKE stbc_t.stbc009, #經營方式
       stbc010 LIKE stbc_t.stbc010, #結算方式
       stbc011 LIKE stbc_t.stbc011, #結算類型
       stbc012 LIKE stbc_t.stbc012, #費用編號
       stbc013 LIKE stbc_t.stbc013, #幣別
       stbc014 LIKE stbc_t.stbc014, #稅別
       stbc015 LIKE stbc_t.stbc015, #價款類別
       stbc016 LIKE stbc_t.stbc016, #方向
       stbc017 LIKE stbc_t.stbc017, #價外金額
       stbc018 LIKE stbc_t.stbc018, #價內金額
       stbc019 LIKE stbc_t.stbc019, #未結算金額
       stbc020 LIKE stbc_t.stbc020, #已結算金額
       stbc021 LIKE stbc_t.stbc021, #未校驗金額
       stbc022 LIKE stbc_t.stbc022, #已收款金額
       stbc023 LIKE stbc_t.stbc023, #未立帳金額
       stbc024 LIKE stbc_t.stbc024, #已立帳金額
       stbc025 LIKE stbc_t.stbc025, #所屬品類
       stbc026 LIKE stbc_t.stbc026, #所屬部門
       stbc027 LIKE stbc_t.stbc027, #對象類別
       stbc028 LIKE stbc_t.stbc028, #財務會計期別
       stbc029 LIKE stbc_t.stbc029, #網點編號
       stbc030 LIKE stbc_t.stbc030, #結算合約編號
       stbc031 LIKE stbc_t.stbc031, #承擔對象
       stbc032 LIKE stbc_t.stbc032, #結算對象
       stbcstus LIKE stbc_t.stbcstus, #狀態碼
       stbc033 LIKE stbc_t.stbc033, #专柜编号
       stbc034 LIKE stbc_t.stbc034, #數量
       stbc035 LIKE stbc_t.stbc035, #已立帳數量
       stbc036 LIKE stbc_t.stbc036, #單價
       stbc037 LIKE stbc_t.stbc037, #納入結算單否
       stbc038 LIKE stbc_t.stbc038, #票扣否
       stbc039 LIKE stbc_t.stbc039, #結算扣率
       stbc040 LIKE stbc_t.stbc040, #結算日期
       stbc041 LIKE stbc_t.stbc041, #日結成本類型
       stbc042 LIKE stbc_t.stbc042, #銷售金額
       stbc043 LIKE stbc_t.stbc043, #商品編號
       stbc044 LIKE stbc_t.stbc044, #商品品類
       stbc045 LIKE stbc_t.stbc045, #開始日期
       stbc046 LIKE stbc_t.stbc046, #結束日期
       stbc047 LIKE stbc_t.stbc047, #已立帳金額帳套二
       stbc048 LIKE stbc_t.stbc048, #已立帳金額帳套三
       stbc049 LIKE stbc_t.stbc049, #主帳套暫估金額
       stbc050 LIKE stbc_t.stbc050, #帳套二暫估金額
       stbc051 LIKE stbc_t.stbc051, #帳套三暫估金額
       stbc052 LIKE stbc_t.stbc052, #已立帳數量帳套二
       stbc053 LIKE stbc_t.stbc053, #已立帳數量帳套三
       stbc054 LIKE stbc_t.stbc054, #主帳套暫估數量
       stbc055 LIKE stbc_t.stbc055, #帳套二暫估數量
       stbc056 LIKE stbc_t.stbc056, #帳套三暫估數量
       stbc057 LIKE stbc_t.stbc057, #已結算數量
       stbc058 LIKE stbc_t.stbc058, #含發票否
       stbc059 LIKE stbc_t.stbc059, #費用歸屬類型
       stbc060 LIKE stbc_t.stbc060, #費用歸屬組織
       stbc061 LIKE stbc_t.stbc061, #應收結算金額
       stbc062 LIKE stbc_t.stbc062, #帳套二應收結算金額
       stbc063 LIKE stbc_t.stbc063, #帳套三應收結算金額
       stbc064 LIKE stbc_t.stbc064  #收入立帳否
        END RECORD
   DEFINE l_stbc2 RECORD  #結算底稿
       stbcent LIKE stbc_t.stbcent, #企業編號
       stbcsite LIKE stbc_t.stbcsite, #營運據點
       stbc001 LIKE stbc_t.stbc001, #結算中心
       stbc002 LIKE stbc_t.stbc002, #單據日期
       stbc003 LIKE stbc_t.stbc003, #單據類別
       stbc004 LIKE stbc_t.stbc004, #單據編號
       stbc005 LIKE stbc_t.stbc005, #項次
       stbc006 LIKE stbc_t.stbc006, #業務結算期
       stbc007 LIKE stbc_t.stbc007, #財務會計年度
       stbc008 LIKE stbc_t.stbc008, #對象編號
       stbc009 LIKE stbc_t.stbc009, #經營方式
       stbc010 LIKE stbc_t.stbc010, #結算方式
       stbc011 LIKE stbc_t.stbc011, #結算類型
       stbc012 LIKE stbc_t.stbc012, #費用編號
       stbc013 LIKE stbc_t.stbc013, #幣別
       stbc014 LIKE stbc_t.stbc014, #稅別
       stbc015 LIKE stbc_t.stbc015, #價款類別
       stbc016 LIKE stbc_t.stbc016, #方向
       stbc017 LIKE stbc_t.stbc017, #價外金額
       stbc018 LIKE stbc_t.stbc018, #價內金額
       stbc019 LIKE stbc_t.stbc019, #未結算金額
       stbc020 LIKE stbc_t.stbc020, #已結算金額
       stbc021 LIKE stbc_t.stbc021, #未校驗金額
       stbc022 LIKE stbc_t.stbc022, #已收款金額
       stbc023 LIKE stbc_t.stbc023, #未立帳金額
       stbc024 LIKE stbc_t.stbc024, #已立帳金額
       stbc025 LIKE stbc_t.stbc025, #所屬品類
       stbc026 LIKE stbc_t.stbc026, #所屬部門
       stbc027 LIKE stbc_t.stbc027, #對象類別
       stbc028 LIKE stbc_t.stbc028, #財務會計期別
       stbc029 LIKE stbc_t.stbc029, #網點編號
       stbc030 LIKE stbc_t.stbc030, #結算合約編號
       stbc031 LIKE stbc_t.stbc031, #承擔對象
       stbc032 LIKE stbc_t.stbc032, #結算對象
       stbcstus LIKE stbc_t.stbcstus, #狀態碼
       stbc033 LIKE stbc_t.stbc033, #专柜编号
       stbc034 LIKE stbc_t.stbc034, #數量
       stbc035 LIKE stbc_t.stbc035, #已立帳數量
       stbc036 LIKE stbc_t.stbc036, #單價
       stbc037 LIKE stbc_t.stbc037, #納入結算單否
       stbc038 LIKE stbc_t.stbc038, #票扣否
       stbc039 LIKE stbc_t.stbc039, #結算扣率
       stbc040 LIKE stbc_t.stbc040, #結算日期
       stbc041 LIKE stbc_t.stbc041, #日結成本類型
       stbc042 LIKE stbc_t.stbc042, #銷售金額
       stbc043 LIKE stbc_t.stbc043, #商品編號
       stbc044 LIKE stbc_t.stbc044, #商品品類
       stbc045 LIKE stbc_t.stbc045, #開始日期
       stbc046 LIKE stbc_t.stbc046, #結束日期
       stbc047 LIKE stbc_t.stbc047, #已立帳金額帳套二
       stbc048 LIKE stbc_t.stbc048, #已立帳金額帳套三
       stbc049 LIKE stbc_t.stbc049, #主帳套暫估金額
       stbc050 LIKE stbc_t.stbc050, #帳套二暫估金額
       stbc051 LIKE stbc_t.stbc051, #帳套三暫估金額
       stbc052 LIKE stbc_t.stbc052, #已立帳數量帳套二
       stbc053 LIKE stbc_t.stbc053, #已立帳數量帳套三
       stbc054 LIKE stbc_t.stbc054, #主帳套暫估數量
       stbc055 LIKE stbc_t.stbc055, #帳套二暫估數量
       stbc056 LIKE stbc_t.stbc056, #帳套三暫估數量
       stbc057 LIKE stbc_t.stbc057, #已結算數量
       stbc058 LIKE stbc_t.stbc058, #含發票否
       stbc059 LIKE stbc_t.stbc059, #費用歸屬類型
       stbc060 LIKE stbc_t.stbc060, #費用歸屬組織
       stbc061 LIKE stbc_t.stbc061, #應收結算金額
       stbc062 LIKE stbc_t.stbc062, #帳套二應收結算金額
       stbc063 LIKE stbc_t.stbc063, #帳套三應收結算金額
       stbc064 LIKE stbc_t.stbc064  #收入立帳否
        END RECORD
   DEFINE l_stbd RECORD  #結算單資料表
       stbdent LIKE stbd_t.stbdent, #企業編號
       stbdunit LIKE stbd_t.stbdunit, #應用組織
       stbdsite LIKE stbd_t.stbdsite, #營運據點
       stbddocno LIKE stbd_t.stbddocno, #單據編號
       stbddocdt LIKE stbd_t.stbddocdt, #單據日期
       stbd001 LIKE stbd_t.stbd001, #合約編號
       stbd002 LIKE stbd_t.stbd002, #供應商編號
       stbd003 LIKE stbd_t.stbd003, #經營方式
       stbd004 LIKE stbd_t.stbd004, #結算帳期
       stbd005 LIKE stbd_t.stbd005, #起始日期
       stbd006 LIKE stbd_t.stbd006, #截止日期
       stbd007 LIKE stbd_t.stbd007, #上期結存金額
       stbd008 LIKE stbd_t.stbd008, #本期銷貨成本
       stbd009 LIKE stbd_t.stbd009, #本期進貨金額
       stbd010 LIKE stbd_t.stbd010, #本期退貨金額
       stbd011 LIKE stbd_t.stbd011, #本期折讓金額
       stbd012 LIKE stbd_t.stbd012, #稅額
       stbd013 LIKE stbd_t.stbd013, #價稅合計
       stbd014 LIKE stbd_t.stbd014, #本期預付金額
       stbd015 LIKE stbd_t.stbd015, #本期價外扣款
       stbd016 LIKE stbd_t.stbd016, #貨款扣費用否
       stbd017 LIKE stbd_t.stbd017, #應結算金額
       stbd018 LIKE stbd_t.stbd018, #實際計算金額
       stbd019 LIKE stbd_t.stbd019, #本期結存金額
       stbd020 LIKE stbd_t.stbd020, #結算標識
       stbd021 LIKE stbd_t.stbd021, #人員
       stbd022 LIKE stbd_t.stbd022, #部門
       stbd023 LIKE stbd_t.stbd023, #結算地點
       stbd024 LIKE stbd_t.stbd024, #納稅編號
       stbd025 LIKE stbd_t.stbd025, #銀行編號
       stbd026 LIKE stbd_t.stbd026, #銀行帳號
       stbd027 LIKE stbd_t.stbd027, #發票日期
       stbd028 LIKE stbd_t.stbd028, #發票號碼
       stbd029 LIKE stbd_t.stbd029, #付款日期
       stbd030 LIKE stbd_t.stbd030, #發票人
       stbd031 LIKE stbd_t.stbd031, #生效日期
       stbd032 LIKE stbd_t.stbd032, #失效日期
       stbd033 LIKE stbd_t.stbd033, #備註
       stbdstus LIKE stbd_t.stbdstus, #狀態碼
       stbdownid LIKE stbd_t.stbdownid, #資料所屬者
       stbdowndp LIKE stbd_t.stbdowndp, #資料所有部門
       stbdcrtid LIKE stbd_t.stbdcrtid, #資料建立者
       stbdcrtdp LIKE stbd_t.stbdcrtdp, #資料建立部門
       stbdcrtdt LIKE stbd_t.stbdcrtdt, #資料創建日
       stbdmodid LIKE stbd_t.stbdmodid, #資料修改者
       stbdmoddt LIKE stbd_t.stbdmoddt, #最近修改日
       stbdcnfid LIKE stbd_t.stbdcnfid, #資料確認者
       stbdcnfdt LIKE stbd_t.stbdcnfdt, #資料確認日
       stbd034 LIKE stbd_t.stbd034, #主帳套帳款金額
       stbd035 LIKE stbd_t.stbd035, #次帳套一帳款金額
       stbd036 LIKE stbd_t.stbd036, #次帳套二帳款金額
       stbd000 LIKE stbd_t.stbd000, #結算單類型
       stbd037 LIKE stbd_t.stbd037, #专柜编号
       stbd038 LIKE stbd_t.stbd038, #預估應付日
       stbd039 LIKE stbd_t.stbd039, #資料類型
       stbd040 LIKE stbd_t.stbd040, #本期銷售金額
       stbd041 LIKE stbd_t.stbd041, #合約狀態
       stbd042 LIKE stbd_t.stbd042, #含發票否
       stbd043 LIKE stbd_t.stbd043, #財務會計年度
       stbd044 LIKE stbd_t.stbd044, #財務會計期別
       stbd045 LIKE stbd_t.stbd045, #本期開票金額
       stbd046 LIKE stbd_t.stbd046, #付款供應商
       stbd047 LIKE stbd_t.stbd047, #檔案編號
       stbd048 LIKE stbd_t.stbd048, #結演算法人
       stbd049 LIKE stbd_t.stbd049, #管理品類
       stbd050 LIKE stbd_t.stbd050, #品牌
       stbd051 LIKE stbd_t.stbd051, #上期結存費用
       stbd052 LIKE stbd_t.stbd052, #實際結算結存貨款
       stbd053 LIKE stbd_t.stbd053, #實際結算結存費用
       stbd054 LIKE stbd_t.stbd054, #實際結算銷貨成本
       stbd055 LIKE stbd_t.stbd055, #實際結算收貨金額
       stbd056 LIKE stbd_t.stbd056, #實際結算退貨金額
       stbd057 LIKE stbd_t.stbd057, #實際結算費用金額
       stbd058 LIKE stbd_t.stbd058, #實際結算稅額合計
       stbd059 LIKE stbd_t.stbd059, #實際結算總金額
       stbd060 LIKE stbd_t.stbd060  #列印次數
       END RECORD
   DEFINE l_stbe RECORD  #結算單明細資料
       stbeent LIKE stbe_t.stbeent, #企業編號
       stbesite LIKE stbe_t.stbesite, #營運據點
       stbecomp LIKE stbe_t.stbecomp, #所屬法人
       stbedocno LIKE stbe_t.stbedocno, #單據編號
       stbeseq LIKE stbe_t.stbeseq, #單據項次
       stbe001 LIKE stbe_t.stbe001, #來源類別
       stbe002 LIKE stbe_t.stbe002, #來源單據
       stbe003 LIKE stbe_t.stbe003, #來源項次
       stbe004 LIKE stbe_t.stbe004, #來源日期
       stbe005 LIKE stbe_t.stbe005, #費用編號
       stbe006 LIKE stbe_t.stbe006, #起始日期
       stbe007 LIKE stbe_t.stbe007, #截止日期
       stbe008 LIKE stbe_t.stbe008, #幣別
       stbe009 LIKE stbe_t.stbe009, #稅別
       stbe010 LIKE stbe_t.stbe010, #價款類別
       stbe011 LIKE stbe_t.stbe011, #方向
       stbe012 LIKE stbe_t.stbe012, #價外金額
       stbe013 LIKE stbe_t.stbe013, #價內金額
       stbe014 LIKE stbe_t.stbe014, #未結算金額
       stbe015 LIKE stbe_t.stbe015, #已結算金額
       stbe016 LIKE stbe_t.stbe016, #本次結算金額
       stbe017 LIKE stbe_t.stbe017, #結算方式
       stbe018 LIKE stbe_t.stbe018, #結算類型
       stbe019 LIKE stbe_t.stbe019, #所屬品類
       stbe020 LIKE stbe_t.stbe020, #所屬部門
       stbe021 LIKE stbe_t.stbe021, #主帳套帳款金額
       stbe022 LIKE stbe_t.stbe022, #次帳套一帳款金額
       stbe023 LIKE stbe_t.stbe023, #次帳套二帳款金額
       stbe024 LIKE stbe_t.stbe024, #納入結算單否
       stbe025 LIKE stbe_t.stbe025, #票扣否
       stbe026 LIKE stbe_t.stbe026, #數量
       stbe027 LIKE stbe_t.stbe027, #單價
       stbe028 LIKE stbe_t.stbe028, #专柜编号
       stbe029 LIKE stbe_t.stbe029, #no use
       stbe030 LIKE stbe_t.stbe030, #no use
       stbe031 LIKE stbe_t.stbe031, #結算扣率
       stbe032 LIKE stbe_t.stbe032, #備註
       stbe033 LIKE stbe_t.stbe033, #日結成本類型
       stbe034 LIKE stbe_t.stbe034, #銷售金額
       stbe035 LIKE stbe_t.stbe035, #費用歸屬類型
       stbe036 LIKE stbe_t.stbe036, #費用歸屬組織
       stbe037 LIKE stbe_t.stbe037, #應收結算金額
       stbe038 LIKE stbe_t.stbe038, #帳套二應收結算金額
       stbe039 LIKE stbe_t.stbe039, #帳套三應收結算金額
       stbe040 LIKE stbe_t.stbe040  #收入立帳否
   END RECORD
   #161128-00061#3-----modify--end----------
   DEFINE l_xrcbseq        LIKE xrcb_t.xrcbseq
   DEFINE l_stbc022        LIKE stbc_t.stbc022
   DEFINE l_stbe016        LIKE stbe_t.stbe016
   #160509-00004#67--add--end--lujh

   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING,
          p_style           LIKE type_t.chr10,       #類型 axrt300 axrt340
          p_check           STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_gen_doc_flag   LIKE type_t.chr1  #160509-00004#93--add by lvjh 是否产生单据标识符
   
   #160509-00004#93--add by lvjh-- str -- 
   LET l_gen_doc_flag = 'N'
   LET l_success = TRUE
   #160509-00004#93--add by lvjh-- end -- 

   #151201-00002#5 Add  ---(S)---
   CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
      RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
   DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
   DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
   #151201-00002#5 Add  ---(E)---

   CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_master.xrcadocdt,'')
   CALL s_fin_account_center_sons_str()RETURNING l_origin_str
   IF cl_null(l_origin_str) THEN LET l_origin_str = g_master.xrcasite END IF
   CALL axrp139_get_ooef001_wc(l_origin_str)RETURNING l_origin_str

   #151201-00002#5 Add  ---(S)---
   SELECT glaa001,glaa002,glaa003,glaa016,glaa020,glaa024,glaa025,glaacomp,glaa121
     INTO l_glaa001,l_glaa002,l_glaa003,l_glaa016,l_glaa020,l_glaa024,l_glaa025,l_glaacomp,l_glaa121
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald

   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2017') RETURNING l_sfin2017
   #151201-00002#5 Add  ---(E)---

   #LET l_sql=" SELECT DISTINCT stbc013,stbc008,stbc060,stbc014 FROM stbc_t ",  #币别 对象编号 费用归属组织 税别   160509-00004#73 mark lujh
   LET l_sql=" SELECT DISTINCT stbc060 FROM stbc_t ",  #费用归属组织     160509-00004#73 add lujh
             "  WHERE (SELECT ooef017 FROM ooef_t WHERE ooefent='",g_enterprise,"' AND ooef001=stbc060) ='",l_glaacomp,"' ",
             "    AND stbc007='",g_master.glav002,"' ",
             "    AND stbc028='",g_master.glav006,"' ",
             "    AND ",g_master.wc,
             "    AND stbc009='5' ",
             #160509-00004#93--mod by lvjh-- str -- stbe_t中没有进行收入立账的费用归属组织也应该抓取
             "    AND ((STBC064 = 'N' OR STBC064 IS NULL) ",
             "        OR EXISTS(SELECT 1 ",
             "                    FROM STBE_T ",
             "                   WHERE STBEENT = STBCENT ",
             "                     AND STBE002 = STBC004 ",
             "                     AND STBE003 = STBC005 ",
             "                     AND (STBE040 = 'N' OR STBE040 IS NULL))) "
             #"    AND (stbc064 = 'N' OR stbc064 IS NULL ) "   #160509-00004#67 add lujh
             #160509-00004#93--mod by lvjh-- end -- 
             #160509-00004#67--mark--str--lujh
             #"    AND stbc001 IN ",l_origin_str," ",
             #"    AND stbc004||'#'||stbc005 NOT IN (SELECT DISTINCT xrcb002||'#'||xrcb003 
             #                                        FROM xrcb_t 
             #                                       WHERE xrcb001='30') "
             #160509-00004#67--mark--end--lujh
   PREPARE axrp139_stbc_prep FROM l_sql
   DECLARE axrp139_stbc_curs CURSOR FOR axrp139_stbc_prep 
   
   #160509-00004#67--add--str--lujh
   #取出当月的结算单
   #161128-00061#3-----modify--begin----------
   #LET l_sql = "SELECT * ",
    LET l_sql = "SELECT stbdent,stbdunit,stbdsite,stbddocno,stbddocdt,stbd001,stbd002,stbd003,stbd004,stbd005,",
                "stbd006,stbd007,stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,",
                "stbd018,stbd019,stbd020,stbd021,stbd022,stbd023,stbd024,stbd025,stbd026,stbd027,stbd028,stbd029,",
                "stbd030,stbd031,stbd032,stbd033,stbdstus,stbdownid,stbdowndp,stbdcrtid,stbdcrtdp,stbdcrtdt,stbdmodid,",
                "stbdmoddt,stbdcnfid,stbdcnfdt,stbd034,stbd035,stbd036,stbd000,stbd037,stbd038,stbd039,stbd040,",
                "stbd041,stbd042,stbd043,stbd044,stbd045,stbd046,stbd047,stbd048,stbd049,stbd050,stbd051,stbd052,",
                "stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059,stbd060,stbeent,stbesite,stbecomp,stbedocno,",
                "stbeseq,stbe001,stbe002,stbe003,stbe004,stbe005,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,",
                "stbe013,stbe014,stbe015,stbe016,stbe017,stbe018,stbe019,stbe020,stbe021,stbe022,stbe023,stbe024,stbe025,",
                "stbe026,stbe027,stbe028,stbe029,stbe030,stbe031,stbe032,stbe033,stbe034,stbe035,stbe036,stbe037,stbe038,",
                "stbe039,stbe040 ",
   #161128-00061#3-----modify--end---------
               "   FROM stbd_t,stbe_t ",
               "  WHERE stbdent = ",g_enterprise,
               "    AND stbddocno = stbedocno ",
               "    AND stbdstus = 'Y' ",
               "    AND stbd043 = '",g_master.glav002,"'",
               "    AND stbd044 = '",g_master.glav006,"'",
               "    AND (stbe040 = 'N' OR stbe040 IS NULL ) ",   
               "    AND EXISTS(SELECT 1 FROM stbc_t WHERE stbcent=stbeent AND stbc004=stbe002 AND stbc005=stbe003 AND ",g_master.wc,") ", #160509-00004#93--add by lvjh-- stbe_t的数据抓取也需要加入QBE条件的管控
               "    AND (SELECT ooef017 FROM ooef_t WHERE ooefent='",g_enterprise,"' AND ooef001=stbe036) ='",l_glaacomp,"'"

   PREPARE axrp139_stbe_prep FROM l_sql
   DECLARE axrp139_stbe_curs CURSOR FOR axrp139_stbe_prep 
   #160509-00004#67--add--end--lujh
   
   LET l_ac = 1
   FOREACH axrp139_stbc_curs INTO l_stbc[l_ac].*  
      LET l_ac = l_ac + 1
   END FOREACH
   CALL l_stbc.deleteElement(l_ac)
   IF l_stbc.getLength() < 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   LET l_tot_success = TRUE
   CALL s_transaction_begin()

   FOR l_ac = 1 TO l_stbc.getLength()


      INITIALIZE g_xrca TO NULL
      INITIALIZE g_xrcb TO NULL

      
      CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
      CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt211')   #160509-00004#62 change axrt210 to axrt211 lujh
         RETURNING l_success,l_xrcadocno
      #151201-00002#61--add--end--lujh   
         
     #151201-00002#5 Add  ---(E)---
      IF NOT l_success THEN
         LET l_tot_success = l_success
      END IF
      IF cl_null(l_start_no) THEN
         LET l_start_no = l_xrcadocno
      END IF
      LET l_end_no = l_xrcadocno

      LET g_xrca.xrcaent = g_enterprise
      LET g_xrca.xrcastus = 'N'
      LET g_xrca.xrcacomp = l_glaacomp
      LET g_xrca.xrcald = g_master.xrcald
      LET g_xrca.xrcadocno = l_xrcadocno
      LET g_xrca.xrcadocdt = g_master.xrcadocdt
      LET g_xrca.xrcasite = g_master.xrcasite
      LET g_xrca.xrca001 = '181'
      LET g_xrca.xrca003 = g_user
      #LET g_xrca.xrca004 = l_stbc[l_ac].stbc008   #160509-00004#73 mark lujh
      LET g_xrca.xrca004 = ''                      #160509-00004#73 add lujh   
      CALL axrp139_xrca004_ref() RETURNING l_xrca.*
      LET g_xrca.xrca005 = l_xrca.xrca005
      LET g_xrca.xrca006 = l_xrca.xrca006
      IF cl_null(g_master.xrca007) THEN
         LET g_xrca.xrca007 = l_xrca.xrca007
      ELSE
         LET g_xrca.xrca007 = g_master.xrca007
      END IF
      IF cl_null(g_master.xrca008) THEN
         LET g_xrca.xrca008 = l_xrca.xrca008
      ELSE
         LET g_xrca.xrca008 = g_master.xrca008
      END IF
      LET g_xrca.xrca009 = l_xrca.xrca009
      LET g_xrca.xrca010 = l_xrca.xrca010
      #LET g_xrca.xrca011 = l_stbc[l_ac].stbc014  #160509-00004#73 mark lujh
      LET g_xrca.xrca011 = ''                     #160509-00004#73 add lujh   
      IF NOT cl_null(g_xrca.xrca011) THEN        #20160615 add lujh 
         CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
            RETURNING l_success,l_oodbl004,g_xrca.xrca013,g_xrca.xrca012,l_oodb011
      END IF  #20160615 ADD lujh 
      SELECT oodb006 INTO g_xrca.xrca012 FROM oodb_t
       WHERE oodbent=g_enterprise
         AND oodb001 IN (select ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_glaacomp)
         AND oodb002=g_xrca.xrca011     
      LET g_xrca.xrca014=l_xrca.xrca014
      LET g_xrca.xrca015=l_xrca.xrca015
      
      LET g_xrca.xrca016 = '30'    #151201-00002#5 Add
      LET g_xrca.xrca017 = '0'
      
      LET g_xrca.xrca019 = ''
      LET g_xrca.xrca020 = 'N'
      LET g_xrca.xrca021 = ''
      LET g_xrca.xrca022 = ''
      LET g_xrca.xrca023 = ''
      LET g_xrca.xrca024 = ''
      LET g_xrca.xrca025 = '0'
      LET g_xrca.xrca026 = '0'
      LET g_xrca.xrca028 = '0'
      LET g_xrca.xrca029 = '0'
      LET g_xrca.xrca030 = ''
      LET g_xrca.xrca031 = ''
      LET g_xrca.xrca032 = ''
      LET g_xrca.xrca033 = ''
      CALL s_department_get_respon_center(g_xrca.xrca015,g_xrca.xrcadocdt)
         RETURNING l_success,g_errno,g_xrca.xrca034,l_ooefl003
               
      IF cl_null(g_xrca.xrca035) THEN   
         SELECT glab005 INTO g_xrca.xrca035 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_01'
      END IF 
      IF cl_null(g_xrca.xrca036) THEN 
         SELECT glab005 INTO g_xrca.xrca036 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_21'
      END IF 
      LET g_xrca.xrca037 = l_dfin0030
      LET g_xrca.xrca038 = ''
      LET g_xrca.xrca039 = 0
      LET g_xrca.xrca040 = '0'
      LET g_xrca.xrca041 = ''
      LET g_xrca.xrca042 = ''
      LET g_xrca.xrca043 = ''
      LET g_xrca.xrca044 = ''
      LET g_xrca.xrca045 = ''
      LET g_xrca.xrca046 = l_xrca.xrca046
      LET g_xrca.xrca047 = ''
      LET g_xrca.xrca048 = ''
      LET g_xrca.xrca049 = l_glaacomp
      LET g_xrca.xrca050 = 1
      LET g_xrca.xrca051 = ''
      LET g_xrca.xrca052 = 0
      LET g_xrca.xrca053 = ''
      LET g_xrca.xrca054 = ''
      LET g_xrca.xrca055 = ''
      LET g_xrca.xrca056 = 0
      LET g_xrca.xrca057 = g_xrca.xrca004
      LET g_xrca.xrca058 = ''
      
      LET g_xrca.xrca059 = ''
      
      LET g_xrca.xrca060 = '3'
      LET g_xrca.xrca061 = ''
      LET g_xrca.xrca062 = ''
      LET g_xrca.xrca063 = ''
      LET g_xrca.xrca064 = ''
      LET g_xrca.xrca065 = ''
      LET g_xrca.xrca066 = '' 
      #LET g_xrca.xrca100 = l_stbc[l_ac].stbc013    #160509-00004#73 mark lujh
      LET g_xrca.xrca100 = l_glaa001                #160509-00004#73 add lujh
      IF g_xrca.xrca100 = l_glaa001 THEN
         LET g_xrca.xrca101 = 1
      ELSE
#         CASE g_master.b_comb1
#            WHEN '1'  #依立帳日匯率(aooi160)
#                CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,
#                                          g_xrca.xrca100,l_glaa001,0,l_glaa025)
#                     RETURNING g_xrca.xrca101
#            WHEN '2'  #依立帳日匯率(aooi160)
                CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,
                                          g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_xrca.xrca101
#            WHEN '3'  #依立帳日月平均匯率(aooi170)
#                CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,
#                                              g_xrca.xrca100,l_glaa001,0,l_glaa025)
#                     RETURNING g_sub_success,g_errno,g_xrca.xrca101
#         END CASE
      END IF
      LET g_xrca.xrca103 = 0
      LET g_xrca.xrca104 = 0
      LET g_xrca.xrca106 = 0
      LET g_xrca.xrca107 = 0
      LET g_xrca.xrca108 = 0
      LET g_xrca.xrca113 = 0
      LET g_xrca.xrca114 = 0
      LET g_xrca.xrca116 = 0
      LET g_xrca.xrca117 = 0
      LET g_xrca.xrca118 = 0
      LET g_xrca.xrca120 = l_glaa016
      LET g_xrca.xrca121 = 0
      LET g_xrca.xrca123 = 0
      LET g_xrca.xrca124 = 0
      LET g_xrca.xrca126 = 0
      LET g_xrca.xrca127 = 0
      LET g_xrca.xrca128 = 0
      LET g_xrca.xrca130 = l_glaa020
      LET g_xrca.xrca131 = 0
      LET g_xrca.xrca133 = 0
      LET g_xrca.xrca134 = 0
      LET g_xrca.xrca136 = 0
      LET g_xrca.xrca137 = 0
      LET g_xrca.xrca138 = 0
      LET g_xrca.xrcaownid = g_user
      LET g_xrca.xrcaowndp = g_dept
      LET g_xrca.xrcacrtid = g_user
      LET g_xrca.xrcacrtdp = g_dept 
      LET g_xrca.xrcacrtdt = cl_get_current()
      LET g_xrca.xrcamodid = g_user
      LET g_xrca.xrcamoddt = cl_get_current()
      LET g_xrca.xrcacnfid = ''
      LET g_xrca.xrcacnfdt = ''
      LET g_xrca.xrcapstid = ''
      LET g_xrca.xrcapstdt = ''

      INSERT INTO xrca_t(xrcaent,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrcasite,
                         xrca001,xrca003,xrca004,xrca005,xrca006,xrca007,
                         xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,
                         xrca014,xrca015,xrca016,xrca017,xrca018,xrca019,
                         xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,
                         xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,
                         xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,
                         xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,
                         xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,
                         xrca051,xrca052,xrca053,xrca054,xrca055,xrca056,
                         xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,
                         xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,
                         xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,
                         xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,
                         xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,
                         xrca131,xrca133,xrca134,xrca136,xrca137,xrca138,
                         xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,
                         xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
                         xrcacnfdt,xrcapstid,xrcapstdt)
                  VALUES(g_xrca.xrcaent,g_xrca.xrcastus,g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,g_xrca.xrcasite,
                         g_xrca.xrca001,g_xrca.xrca003,g_xrca.xrca004,g_xrca.xrca005,g_xrca.xrca006,g_xrca.xrca007,
                         g_xrca.xrca008,g_xrca.xrca009,g_xrca.xrca010,g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013,
                         g_xrca.xrca014,g_xrca.xrca015,g_xrca.xrca016,g_xrca.xrca017,g_xrca.xrca018,g_xrca.xrca019,
                         g_xrca.xrca020,g_xrca.xrca021,g_xrca.xrca022,g_xrca.xrca023,g_xrca.xrca024,g_xrca.xrca025,
                         g_xrca.xrca026,g_xrca.xrca028,g_xrca.xrca029,g_xrca.xrca030,g_xrca.xrca031,g_xrca.xrca032,
                         g_xrca.xrca033,g_xrca.xrca034,g_xrca.xrca035,g_xrca.xrca036,g_xrca.xrca037,g_xrca.xrca038,
                         g_xrca.xrca039,g_xrca.xrca040,g_xrca.xrca041,g_xrca.xrca042,g_xrca.xrca043,g_xrca.xrca044,
                         g_xrca.xrca045,g_xrca.xrca046,g_xrca.xrca047,g_xrca.xrca048,g_xrca.xrca049,g_xrca.xrca050,
                         g_xrca.xrca051,g_xrca.xrca052,g_xrca.xrca053,g_xrca.xrca054,g_xrca.xrca055,g_xrca.xrca056,
                         g_xrca.xrca057,g_xrca.xrca058,g_xrca.xrca059,g_xrca.xrca060,g_xrca.xrca061,g_xrca.xrca062,
                         g_xrca.xrca063,g_xrca.xrca064,g_xrca.xrca065,g_xrca.xrca066,g_xrca.xrca100,g_xrca.xrca101,
                         g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca106,g_xrca.xrca107,g_xrca.xrca108,g_xrca.xrca113,
                         g_xrca.xrca114,g_xrca.xrca116,g_xrca.xrca117,g_xrca.xrca118,g_xrca.xrca120,g_xrca.xrca121,
                         g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca126,g_xrca.xrca127,g_xrca.xrca128,g_xrca.xrca130,
                         g_xrca.xrca131,g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca136,g_xrca.xrca137,g_xrca.xrca138,
                         g_xrca.xrcaownid,g_xrca.xrcaowndp,g_xrca.xrcacrtid,g_xrca.xrcacrtdp,
                         g_xrca.xrcacrtdt,g_xrca.xrcamodid,g_xrca.xrcamoddt,g_xrca.xrcacnfid,
                         g_xrca.xrcacnfdt,g_xrca.xrcapstid,g_xrca.xrcapstdt)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_xrca.xrcadocno
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_tot_success = FALSE
         #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
         LET l_gen_doc_flag = 'N'
         EXIT FOR
         #160509-00004#93--add by lvjh-- end -- 
      END IF


      #LET l_sql = " SELECT stbcent,stbcsite,stbc001,stbc004,stbc005,stbc009,stbc012,stbc016,stbc025,stbc036",  #160509-00004#73 mark lujh
      #161128-00061#3-----modify--begin----------
      #LET l_sql = " SELECT * ",      #160509-00004#73 add lujh
      LET l_sql = " SELECT stbcent,stbcsite,stbc001,stbc002,stbc003,stbc004,stbc005,stbc006,stbc007,",
                  "stbc008,stbc009,stbc010,stbc011,stbc012,stbc013,stbc014,stbc015,stbc016,stbc017,",
                  "stbc018,stbc019,stbc020,stbc021,stbc022,stbc023,stbc024,stbc025,stbc026,stbc027,",
                  "stbc028,stbc029,stbc030,stbc031,stbc032,stbcstus,stbc033,stbc034,stbc035,stbc036,",
                  "stbc037,stbc038,stbc039,stbc040,stbc041,stbc042,stbc043,stbc044,stbc045,stbc046,",
                  "stbc047,stbc048,stbc049,stbc050,stbc051,stbc052,stbc053,stbc054,stbc055,stbc056,",
                  "stbc057,stbc058,stbc059,stbc060,stbc061,stbc062,stbc063,stbc064 ", 
      #161128-00061#3-----modify--end----------
               "   FROM stbc_t ",
               "  WHERE (select ooef017 FROM ooef_t WHERE ooefent='",g_enterprise,"' AND ooef001=stbc060) ='",l_glaacomp,"' ",
               "    AND stbc007='",g_master.glav002,"' ",
               "    AND stbc028='",g_master.glav006,"' ",
               "    AND ",g_master.wc,
               "    AND stbc009='5' ",
               "    AND (STBC064 = 'N' OR STBC064 IS NULL)",   #160509-00004#93--add by lvjh-- 抓取stbc_t数据需要加上立账标识符判断
               #160509-00004#73--mark--str--lujh
               #"    AND stbc013='",l_stbc[l_ac].stbc013,"' ",  
               #"    AND stbc008='",l_stbc[l_ac].stbc008,"' ", 
               #160509-00004#73--mark--end--lujh               
               "    AND stbc060='",l_stbc[l_ac].stbc060,"' "
               #"    AND stbc014='",l_stbc[l_ac].stbc014,"' "   #160509-00004#73 mark lujh
               #"    AND stbc001 IN ",l_origin_str," "
      LET g_xrcb.xrcbseq = 0
      PREPARE axrp139_stbc1_prep FROM l_sql
      DECLARE axrp139_stbc1_curs CURSOR FOR axrp139_stbc1_prep
      FOREACH axrp139_stbc1_curs INTO l_stbc1.*
         #160509-00004#67--mark--str--lujh
         #LET l_count1 = 0
         #SELECT COUNT(*) INTO l_count1 FROM xrcb_t 
         # WHERE xrcbent = g_enterprise 
         #   AND xrcb002 = l_stbc1.stbc004
         #   AND xrcb003 = l_stbc1.stbc005
         #   and xrcb001='30'
         #IF cl_null(l_count1) THEN LET l_count1 = 0 END IF
         #IF l_count1 = 1 THEN 
         #   CONTINUE FOREACH 
         #END IF
         #160509-00004#67--mark--end--lujh
         
         #160509-00004#66--add--str--lujh
         SELECT stae005 INTO l_stae005
           FROM stae_t
          WHERE staeent = g_enterprise
            AND stae001 = l_stbc1.stbc012
            
         IF l_stae005 <> '2' THEN 
            CONTINUE FOREACH 
         END IF
         #160509-00004#66--add--end--lujh
         
         #160509-00004#67--add--str--lujh
         SELECT ooef017 INTO l_stae_comp
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_stbc[l_ac].stbc060
            
         SELECT ooef017 INTO l_stbc_comp
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_stbc1.stbc001
         #160509-00004#67--add--str--lujh
         
         #INITIALIZE g_xrcb TO NULL        
         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq   = g_xrcb.xrcbseq + 1
         LET g_xrcb.xrcbent   = g_enterprise
         LET g_xrcb.xrcbld    = g_xrca.xrcald
         LET g_xrcb.xrcbsite  = g_xrca.xrcasite
         LET g_xrcb.xrcborga  = l_stbc[l_ac].stbc060
         SELECT ooef017 INTO g_xrca.xrcacomp FROM ooef_t
          WHERE ooefent=g_enterprise
            AND ooef001=g_xrcb.xrcborga
         LET g_xrcb.xrcblegl  = g_xrca.xrcacomp
         LET g_xrcb.xrcb001 = '30'
         LET g_xrcb.xrcb002 = l_stbc1.stbc004
         LET g_xrcb.xrcb003 = l_stbc1.stbc005
         LET g_xrcb.xrcb004 = l_stbc1.stbc012
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = ''
         LET g_xrcb.xrcb007 = 1
         LET g_xrcb.xrcb008 = l_stbc1.stbc004
         LET g_xrcb.xrcb009 = l_stbc1.stbc005
         SELECT stba008 INTO g_xrcb.xrcb010
           FROM stba_t
          WHERE stbadocno = l_stbc1.stbc004
            AND stbaent = g_enterprise  #160905-00007#18   #161223-00004#1 mod  g_enterpise -> g_enterprise
         SELECT ooeg004 INTO g_xrcb.xrcb011 FROM ooeg_t WHERE ooegent = g_enterprise
            AND ooeg001 = g_xrcb.xrcb010
         LET g_xrcb.xrcb012 = l_stbc1.stbc025
         LET g_xrcb.xrcb013 = 'N'
         LET g_xrcb.xrcb014 = l_stbc1.stbc012
         LET g_xrcb.xrcb015 = ''
         LET g_xrcb.xrcb016 = ''
         LET g_xrcb.xrcb017 = ''
         LET g_xrcb.xrcb018 = ''
         LET g_xrcb.xrcb019 = '1'
         #LET g_xrcb.xrcb020 = l_stbc[l_ac].stbc014    #160509-00004#73 mark lujh 
         LET g_xrcb.xrcb020 = l_stbc1.stbc014          #160509-00004#73 add lujh 
         SELECT glab005,glab006 INTO g_xrcb.xrcb029,g_xrcb.xrcb021
           FROM glab_t 
          WHERE glabld = g_xrcb.xrcbld
            AND glab001 = 'AR'
            AND glab002 = l_stbc1.stbc009
            AND glab003 = l_stbc1.stbc012
            AND glabent = g_enterprise  #160905-00007#18
            
         IF cl_null(g_xrcb.xrcb021) THEN
            LET g_xrcb.xrcb021 = g_xrca.xrca036
         END IF
         IF cl_null(g_xrcb.xrcb029) THEN   #20160615 change xrcb021 to xrcb029 lujh
            LET g_xrcb.xrcb029 = g_xrca.xrca035 
         END IF        

         #160509-00004#67--add--str--lujh
         SELECT glab013 INTO g_xrcb.xrcb058 FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_xrca.xrcald
            AND glab002 = l_stbc1.stbc009
            AND glab003 = g_xrcb.xrcb004
            AND glab001 = 'AR'
         #160509-00004#67--add--end--lujh

         LET g_xrcb.xrcb022 = l_stbc1.stbc016
         LET g_xrcb.xrcb023 ='N'
         LET g_xrcb.xrcb024 = ''
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = 0
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008
         LET g_xrcb.xrcb032 = ''
         LET g_xrcb.xrcb033 = l_stbc1.stbc009         #20160616 add lujh
         LET g_xrcb.xrcb034 = ''
         LET g_xrcb.xrcb035 = ''
         LET g_xrcb.xrcb036 = ''
         LET g_xrcb.xrcb037 = ''
         LET g_xrcb.xrcb038 = ''
         LET g_xrcb.xrcb039 = ''
         LET g_xrcb.xrcb040 = ''
         LET g_xrcb.xrcb041 = ''
         LET g_xrcb.xrcb042 = ''
         LET g_xrcb.xrcb043 = ''
         LET g_xrcb.xrcb044 = ''
         LET g_xrcb.xrcb045 = ''
         LET g_xrcb.xrcb046 = ''
         LET g_xrcb.xrcb047 = ''
         LET g_xrcb.xrcb048 = ''
         LET g_xrcb.xrcb049 = ''
         LET g_xrcb.xrcb050 = ''
         LET g_xrcb.xrcb051 = ''
         IF l_stae_comp = l_stbc_comp THEN    #160509-00004#73 add lujh
            #LET g_xrcb.xrcb053 = l_stbc[l_ac].stbc008    #160509-00004#62 add lujh   160509-00004#73 mark lujh
            #LET g_xrcb.xrcb054 = l_stbc[l_ac].stbc008    #160509-00004#62 add lujh   160509-00004#73 mark lujh
            #160509-00004#73--add--str--lujh
            LET g_xrcb.xrcb053 = l_stbc1.stbc008          
            LET g_xrcb.xrcb054 = l_stbc1.stbc008    
            #160509-00004#73--add--end--lujh
         #160509-00004#73--add--str--lujh
         ELSE
            SELECT ooef024 INTO g_xrcb.xrcb053
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_stbc1.stbc001
            LET g_xrcb.xrcb054 = l_stbc1.stbc008
         END IF
         #160509-00004#73--add--end--lujh
         LET g_xrcb.xrcb100 = g_xrca.xrca100
         LET g_xrcb.xrcb101 = l_stbc1.stbc036
         LET g_xrcb.xrcb102 = g_xrca.xrca101
         LET g_xrcb.xrcb106 = 0
         LET g_xrcb.xrcb116 = 0
         LET g_xrcb.xrcb117 = 0
         LET g_xrcb.xrcb118 = 0
         LET g_xrcb.xrcb119 = 0
         LET g_xrcb.xrcb121 = 0
         LET g_xrcb.xrcb126 = 0
         LET g_xrcb.xrcb131 = 0
         LET g_xrcb.xrcb136 = 0
         CALL s_axrt300_exrate(l_glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,l_glaa001,
                               g_xrcb.xrcb101,g_xrca.xrca101,l_glaacomp)
            RETURNING l_success,g_xrcb.xrcb111
         CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,l_glaacomp,
                        g_xrcb.xrcb007*g_xrcb.xrcb101,g_xrcb.xrcb020,
                        g_xrcb.xrcb007,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
            RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                      g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                      g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                      g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
         #因需求,這裡需要把前端金額和產生交易稅明細後的金額做對比,以前端金額為准,將差異放入交易稅明細中
         IF NOT cl_null(g_xrca.xrca011) THEN     #20160615 add lujh
            CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
               RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         END IF   #20160615 add lujh
         #add by liyan--str--
         SELECT stbc022 INTO l_stbc022 FROM stbc_t
          WHERE stbcent = g_enterprise
            AND stbc001 = l_stbc1.stbc001
            AND stbc004 = l_stbc1.stbc004
            AND stbc005 = l_stbc1.stbc005
            
         #160509-00004#67--add--str--lujh
         SELECT SUM(stbe016) INTO l_stbe016
           FROM stbd_t,stbe_t
          WHERE stbdent = g_enterprise
            AND stbddocno = stbedocno
            AND stbdstus = 'Y'
            AND ((stbd043 = g_master.glav002 AND stbd044 < g_master.glav006) OR
                  stbd043 < g_master.glav002)
            AND stbe002 = l_stbc1.stbc004                  
            AND stbe003 = l_stbc1.stbc005
         IF cl_null(l_stbe016) THEN 
            LET l_stbe016 = 0
         END IF
         LET g_xrcb.xrcb055 = l_stbc022 + l_stbe016
         #160509-00004#67--add--end--lujh
            
         LET g_xrcb.xrcb057 = 0
         LET g_xrcb.xrcb056 = g_xrcb.xrcb105 - g_xrcb.xrcb055
         #add by liyan --end--
         
         #160509-00004#93--mod by lvjh-- str -- 增加不同法人的科目抓取逻辑
         #160509-00004#67--add--str--lujh
         #如果费用归属组织的法人与结算中心的法人一样,则判断费用单是否已经入结算单(astt840),
         #如果已经入结算单且结算单已经审核,则抓结算单上的本次结算金额放到xrcb057
         IF l_stae_comp = l_stbc_comp THEN 
            LET l_n = 0
            SELECT COUNT(*) INTO l_n
              FROM stbd_t,stbe_t
             WHERE stbdent = g_enterprise
               AND stbddocno = stbedocno
               AND stbdstus = 'Y'
               AND (stbe040 = 'N' OR stbe040 IS NULL )
               AND stbe002 = l_stbc1.stbc004
               AND stbe003 = l_stbc1.stbc005
               AND stbd043 = g_master.glav002
               AND stbd044 = g_master.glav006
               
            IF l_n > 0 THEN 
               SELECT stbe016 INTO g_xrcb.xrcb057
                 FROM stbd_t,stbe_t
                WHERE stbdent = g_enterprise
                  AND stbddocno = stbedocno
                  AND stbdstus = 'Y'
                  AND (stbe040 = 'N' OR stbe040 IS NULL )
                  AND stbe002 = l_stbc1.stbc004
                  AND stbe003 = l_stbc1.stbc005
                  AND stbd043 = g_master.glav002
                  AND stbd044 = g_master.glav006
                  
               LET g_xrcb.xrcb056 = g_xrcb.xrcb105 - g_xrcb.xrcb055 - g_xrcb.xrcb057
               
               UPDATE stbe_t SET stbe040 = 'Y'
                WHERE EXISTS(SELECT 1 FROM stbd_t
                              WHERE stbdent = g_enterprise
                                AND stbddocno = stbedocno
                                AND stbdstus = 'Y'
                                AND stbd043 = g_master.glav002
                                AND stbd044 = g_master.glav006)
                  AND (stbe040 = 'N' OR stbe040 IS NULL )
                  AND stbe002 = l_stbc1.stbc004
                  AND stbe003 = l_stbc1.stbc005
            END IF
                  
            SELECT glab012 INTO g_xrcb.xrcb059 FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_xrca.xrcald
               AND glab002 = l_stbc1.stbc009
               AND glab003 = g_xrcb.xrcb004
               AND glab001 = 'AR'
         ELSE
            SELECT glab005 INTO g_xrcb.xrcb059 FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_xrca.xrcald
               AND glab002 = l_stbc1.stbc009
               AND glab003 = g_xrcb.xrcb004
               AND glab001 = 'AR'
         END IF
         LET g_xrcb.xrcb060 = '2'
         #160509-00004#67--add--end--lujh
         #160509-00004#93--mod by lvjh-- end -- 
         
         #160509-00004#73--add--str--lujh
         #IF l_oodb005 = 'Y' THEN
         #   LET g_xrcb.xrcb105 = g_xrcb.xrcb007*g_xrcb.xrcb101
         #   LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
         #   LET g_xrcb.xrcb103 = g_xrcb.xrcb105 - g_xrcb.xrcb104
         #
         #   LET g_xrcb.xrcb115 = g_xrcb.xrcb007*g_xrcb.xrcb111
         #   LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
         #   LET g_xrcb.xrcb113 = g_xrcb.xrcb115 - g_xrcb.xrcb114
         #ELSE
         #   LET g_xrcb.xrcb103 = g_xrcb.xrcb007*g_xrcb.xrcb101
         #   LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
         #   LET g_xrcb.xrcb105 = g_xrcb.xrcb103 + g_xrcb.xrcb104
         #
         #   LET g_xrcb.xrcb113 = g_xrcb.xrcb007*g_xrcb.xrcb111
         #   LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
         #   LET g_xrcb.xrcb115 = g_xrcb.xrcb113 + g_xrcb.xrcb114
         #END IF
         #UPDATE  xrcd_t SET xrcd103 = xrcd103 + l_diff,
         #                   xrcd105 = xrcd105 + l_diff,
         #                   xrcd113 = xrcd113 + l_diff1,
         #                   xrcd115 = xrcd115 + l_diff1
         # WHERE xrcdent = g_enterprise
         #   AND xrcddocno = g_xrca.xrcadocno
         #   AND xrcdld = g_xrca.xrcald
         #   AND xrcdseq = g_xrcb.xrcbseq
         #160509-00004#73--add--end--lujh
            
         #SELECT glab005 INTO l_xrcd009 FROM glab_t 
         # WHERE glabld = g_xrca.xrcald 
         #   AND glabent = g_enterprise
         #   AND glab002 = g_xrca.xrca007   # 帳款類別
         #   AND glab001 = '13'             # 應收帳務類型科目設定
         #   AND glab003 = '8304_29'
         #UPDATE xrcd_t SET xrcd009 = l_xrcd009
         # WHERE xrcd009 IS NULL
         #   AND xrcdent = g_enterprise
         #   AND xrcddocno = g_xrca.xrcadocno
         #   AND xrcdld = g_xrca.xrcald

         INSERT INTO xrcb_t(xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcblegl,
                            xrcb001,xrcb002,xrcb003,xrcb004,xrcb005,xrcb006,
                            xrcb007,xrcb008,xrcb009,xrcb010,xrcb011,xrcb012,
                            xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,
                            xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,
                            xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,
                            xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,
                            xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,
                            xrcb043,xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,
                            xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,
                            xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,
                            xrcb114,xrcb115,xrcb116,xrcb117,xrcb118,xrcb119,
                            xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,
                            xrcb133,xrcb134,xrcb135,xrcb136,xrcb055,xrcb056,
                            xrcb057,xrcb053,xrcb054,xrcb058,xrcb059,xrcb060)   #160509-00004#62 add xrcb053,xrcb054 lujh   #160509-00004#67 add xrcb058,xrcb059,xrcb060 lujh  
                     VALUES(g_xrcb.xrcbent,g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrcb.xrcbsite,g_xrcb.xrcborga,g_xrcb.xrcblegl,
                            g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003,g_xrcb.xrcb004,g_xrcb.xrcb005,g_xrcb.xrcb006,
                            g_xrcb.xrcb007,g_xrcb.xrcb008,g_xrcb.xrcb009,g_xrcb.xrcb010,g_xrcb.xrcb011,g_xrcb.xrcb012,
                            g_xrcb.xrcb013,g_xrcb.xrcb014,g_xrcb.xrcb015,g_xrcb.xrcb016,g_xrcb.xrcb017,g_xrcb.xrcb018,
                            g_xrcb.xrcb019,g_xrcb.xrcb020,g_xrcb.xrcb021,g_xrcb.xrcb022,g_xrcb.xrcb023,g_xrcb.xrcb024,
                            g_xrcb.xrcb025,g_xrcb.xrcb026,g_xrcb.xrcb027,g_xrcb.xrcb028,g_xrcb.xrcb029,g_xrcb.xrcb030,
                            g_xrcb.xrcb031,g_xrcb.xrcb032,g_xrcb.xrcb033,g_xrcb.xrcb034,g_xrcb.xrcb035,g_xrcb.xrcb036,
                            g_xrcb.xrcb037,g_xrcb.xrcb038,g_xrcb.xrcb039,g_xrcb.xrcb040,g_xrcb.xrcb041,g_xrcb.xrcb042,
                            g_xrcb.xrcb043,g_xrcb.xrcb044,g_xrcb.xrcb045,g_xrcb.xrcb046,g_xrcb.xrcb047,g_xrcb.xrcb048,
                            g_xrcb.xrcb049,g_xrcb.xrcb050,g_xrcb.xrcb051,g_xrcb.xrcb100,g_xrcb.xrcb101,g_xrcb.xrcb102,
                            g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,g_xrcb.xrcb106,g_xrcb.xrcb111,g_xrcb.xrcb113,
                            g_xrcb.xrcb114,g_xrcb.xrcb115,g_xrcb.xrcb116,g_xrcb.xrcb117,g_xrcb.xrcb118,g_xrcb.xrcb119,
                            g_xrcb.xrcb121,g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,g_xrcb.xrcb126,g_xrcb.xrcb131,
                            g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136,g_xrcb.xrcb055,g_xrcb.xrcb056,
                            g_xrcb.xrcb057,g_xrcb.xrcb053,g_xrcb.xrcb054,g_xrcb.xrcb058,g_xrcb.xrcb059,g_xrcb.xrcb060)   #160509-00004#62 add xrcb053,xrcb054 lujh    #160509-00004#67 add xrcb058,xrcb059,xrcb060 lujh
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
            #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
            LET l_gen_doc_flag = 'N'
            EXIT FOR
            #160509-00004#93--add by lvjh-- end -- 
         END IF
         
         #160509-00004#67--add--str--lujh
         UPDATE stbc_t SET stbc064 = 'Y'
          WHERE stbcent = g_enterprise
            AND stbc004 = l_stbc1.stbc004
            AND stbc005 = l_stbc1.stbc005
         #160509-00004#67--add--end--lujh
         
         #160509-00004#86--mark--str--lujh
         ##160509-00004#63--add--str--lujh
         #LET l_n = 0
         #SELECT COUNT(*) INTO l_n
         #  FROM nmee_t
         # WHERE nmeeent = g_enterprise
         #   AND nmee003||nmee004 = g_xrcb.xrcb002||g_xrcb.xrcb003
         #   
         #IF l_n > 0 THEN 
         #   UPDATE nmee_t SET nmee027 = g_xrcb.xrcbdocno
         #    WHERE nmeeent = g_enterprise
         #      AND nmee003||nmee004 = g_xrcb.xrcb002||g_xrcb.xrcb003
         #      AND nmeedocno IN (SELECT nmbadocno FROM nmba_t,nmee_t 
         #                         WHERE nmbaent = g_enterprise
         #                           AND nmbaent = nmeeent
         #                           AND nmbadocno = nmeedocno
         #                           AND nmbastus = 'Y'
         #                           AND nmee003||nmee004 = g_xrcb.xrcb002||g_xrcb.xrcb003)
         #      
         #   IF SQLCA.SQLCODE THEN
         #      INITIALIZE g_errparam TO NULL
         #      LET g_errparam.extend = g_xrca.xrcadocno
         #      LET g_errparam.code   = SQLCA.SQLCODE
         #      LET g_errparam.popup  = TRUE
         #      CALL cl_err()
         #      LET l_success = FALSE
         #   END IF
         #END IF
         ##160509-00004#63--add--end--lujh
         #160509-00004#86--mark--end--lujh
         
         #160509-00004#86--add--str--lujh
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM xrce_t
          WHERE xrceent = g_enterprise
            AND xrce003||xrce004 = g_xrcb.xrcb002||g_xrcb.xrcb003
            
         IF l_n > 0 THEN 
            UPDATE xrce_t SET xrce059 = g_xrcb.xrcbdocno
             WHERE xrceent = g_enterprise
               AND xrce003||xrce004 = g_xrcb.xrcb002||g_xrcb.xrcb003
               AND xrcedocno IN (SELECT xrdadocno FROM xrda_t,xrce_t 
                                  WHERE xrdaent = g_enterprise
                                    AND xrdaent = xrceent
                                    AND xrdald = xrceld
                                    AND xrdadocno = xrcedocno
                                    AND xrdastus = 'Y'
                                    AND xrce003||xrce004 = g_xrcb.xrcb002||g_xrcb.xrcb003)
               
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success = FALSE
               #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
               LET l_gen_doc_flag = 'N'
               EXIT FOR
               #160509-00004#93--add by lvjh-- end -- 
            END IF
         END IF
         #160509-00004#86--add--end--lujh
                       
         DELETE FROM xrcf_t WHERE xrcfent = g_enterprise
            AND xrcfld = g_xrca.xrcald
            AND xrcfdocno = g_xrca.xrcadocno
            AND xrcfseq = g_xrcb_t.xrcbseq
         
         LET l_gen_doc_flag = 'Y'   #160509-00004#93--add by lvjh-- 单据写入成功则将生成单据标识符置为Y

      END FOREACH  
      
      LET l_xrcbseq = g_xrcb.xrcbseq
      
      #160509-00004#67--add--str--lujh
      INITIALIZE g_xrcb TO NULL
      INITIALIZE l_stbd TO NULL
      INITIALIZE l_stbe TO NULL
         
      LET g_xrcb.xrcbseq = l_xrcbseq
      FOREACH axrp139_stbe_curs INTO l_stbd.*,l_stbe.*
      
       #161128-00061#3-----modify--begin----------
       # SELECT * INTO l_stbc2.* 
         SELECT stbcent,stbcsite,stbc001,stbc002,stbc003,stbc004,stbc005,stbc006,stbc007,
                stbc008,stbc009,stbc010,stbc011,stbc012,stbc013,stbc014,stbc015,stbc016,
                stbc017,stbc018,stbc019,stbc020,stbc021,stbc022,stbc023,stbc024,stbc025,
                stbc026,stbc027,stbc028,stbc029,stbc030,stbc031,stbc032,stbcstus,stbc033,
                stbc034,stbc035,stbc036,stbc037,stbc038,stbc039,stbc040,stbc041,stbc042,
                stbc043,stbc044,stbc045,stbc046,stbc047,stbc048,stbc049,stbc050,stbc051,
                stbc052,stbc053,stbc054,stbc055,stbc056,stbc057,stbc058,stbc059,stbc060,
                stbc061,stbc062,stbc063,stbc064 INTO l_stbc2.*
       #161128-00061#3-----modify--end----------  
         FROM stbc_t WHERE stbcent = g_enterprise AND stbc004 = l_stbe.stbe002 AND stbc005 = l_stbe.stbe003 
      
         SELECT stae005 INTO l_stae005   
           FROM stae_t
          WHERE staeent = g_enterprise
            AND stae001 = l_stbe.stbe005
            
         IF l_stae005 <> '2' THEN 
            CONTINUE FOREACH 
         END IF
         
         #因为当月的结算单对应的费用单资料上面一步已经产生,所以这一步只要抓非当期的费用单资料
         IF l_stbd.stbd043 = l_stbc2.stbc007 AND l_stbd.stbd044 = l_stbc2.stbc028 AND l_stbe.stbe040='Y' THEN 
            CONTINUE FOREACH 
         END IF
         
         LET l_stae_comp = ''
         SELECT ooef017 INTO l_stae_comp
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_stbe.stbe036
            
         LET l_stbc_comp = ''
         SELECT ooef017 INTO l_stbc_comp
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_stbd.stbdunit
            
         IF l_stae_comp <> l_stbc_comp THEN 
            CONTINUE FOREACH 
         END IF
            
         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq   = g_xrcb.xrcbseq + 1
         LET g_xrcb.xrcbent   = g_enterprise
         LET g_xrcb.xrcbld    = g_xrca.xrcald
         LET g_xrcb.xrcbsite  = g_xrca.xrcasite
         LET g_xrcb.xrcborga  = l_stbc[l_ac].stbc060
         SELECT ooef017 INTO g_xrca.xrcacomp FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_xrcb.xrcborga
         LET g_xrcb.xrcblegl  = g_xrca.xrcacomp
         LET g_xrcb.xrcb001 = '30'
         LET g_xrcb.xrcb002 = l_stbc2.stbc004
         LET g_xrcb.xrcb003 = l_stbc2.stbc005
         LET g_xrcb.xrcb004 = l_stbc2.stbc012
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = ''
         LET g_xrcb.xrcb007 = 1
         LET g_xrcb.xrcb008 = l_stbc2.stbc004
         LET g_xrcb.xrcb009 = l_stbc2.stbc005
         SELECT stba008 INTO g_xrcb.xrcb010
           FROM stba_t
          WHERE stbadocno = l_stbc2.stbc004
            AND stbaent = g_enterprise  #160905-00007#18   #161223-00004#1 mod  g_enterpise -> g_enterprise
         SELECT ooeg004 INTO g_xrcb.xrcb011 FROM ooeg_t WHERE ooegent = g_enterprise
            AND ooeg001 = g_xrcb.xrcb010
         LET g_xrcb.xrcb012 = l_stbc2.stbc025
         LET g_xrcb.xrcb013 = 'N'
         LET g_xrcb.xrcb014 = l_stbc2.stbc012
         LET g_xrcb.xrcb015 = ''
         LET g_xrcb.xrcb016 = ''
         LET g_xrcb.xrcb017 = ''
         LET g_xrcb.xrcb018 = ''
         LET g_xrcb.xrcb019 = '1'
         LET g_xrcb.xrcb020 = l_stbc2.stbc014
         SELECT glab005,glab006 INTO g_xrcb.xrcb029,g_xrcb.xrcb021
           FROM glab_t 
          WHERE glabld = g_xrcb.xrcbld
            AND glab001 = 'AR'
            AND glab002 = l_stbc2.stbc009
            AND glab003 = l_stbc2.stbc012
            AND glabent = g_enterprise  #160905-00007#18
            
         IF cl_null(g_xrcb.xrcb021) THEN
            LET g_xrcb.xrcb021 = g_xrca.xrca036
         END IF
         IF cl_null(g_xrcb.xrcb029) THEN   
            LET g_xrcb.xrcb029 = g_xrca.xrca035 
         END IF    
       
         SELECT glab013,glab012 INTO g_xrcb.xrcb058,g_xrcb.xrcb059 FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_xrca.xrcald
            AND glab002 = l_stbc2.stbc009
            AND glab003 = g_xrcb.xrcb004
            AND glab001 = 'AR'
       
         LET g_xrcb.xrcb022 = l_stbc2.stbc016
         LET g_xrcb.xrcb023 ='N'
         LET g_xrcb.xrcb024 = ''
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = 0
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008
         LET g_xrcb.xrcb032 = ''
         LET g_xrcb.xrcb033 = l_stbc2.stbc009         
         LET g_xrcb.xrcb034 = ''
         LET g_xrcb.xrcb035 = ''
         LET g_xrcb.xrcb036 = ''
         LET g_xrcb.xrcb037 = ''
         LET g_xrcb.xrcb038 = ''
         LET g_xrcb.xrcb039 = ''
         LET g_xrcb.xrcb040 = ''
         LET g_xrcb.xrcb041 = ''
         LET g_xrcb.xrcb042 = ''
         LET g_xrcb.xrcb043 = ''
         LET g_xrcb.xrcb044 = ''
         LET g_xrcb.xrcb045 = ''
         LET g_xrcb.xrcb046 = ''
         LET g_xrcb.xrcb047 = ''
         LET g_xrcb.xrcb048 = ''
         LET g_xrcb.xrcb049 = ''
         LET g_xrcb.xrcb050 = ''
         LET g_xrcb.xrcb051 = ''
         LET g_xrcb.xrcb053 = l_stbc2.stbc008    
         LET g_xrcb.xrcb054 = l_stbc2.stbc008    
         LET g_xrcb.xrcb100 = g_xrca.xrca100
         LET g_xrcb.xrcb101 = 0
         LET g_xrcb.xrcb102 = g_xrca.xrca101
         LET g_xrcb.xrcb106 = 0
         LET g_xrcb.xrcb116 = 0
         LET g_xrcb.xrcb117 = 0
         LET g_xrcb.xrcb118 = 0
         LET g_xrcb.xrcb119 = 0
         LET g_xrcb.xrcb121 = 0
         LET g_xrcb.xrcb126 = 0
         LET g_xrcb.xrcb131 = 0
         LET g_xrcb.xrcb136 = 0
         CALL s_axrt300_exrate(l_glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,l_glaa001,
                               g_xrcb.xrcb101,g_xrca.xrca101,l_glaacomp)
            RETURNING l_success,g_xrcb.xrcb111
         CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,l_glaacomp,
                        g_xrcb.xrcb007*g_xrcb.xrcb101,g_xrcb.xrcb020,
                        g_xrcb.xrcb007,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
            RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                      g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                      g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                      g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
         #因需求,這裡需要把前端金額和產生交易稅明細後的金額做對比,以前端金額為准,將差異放入交易稅明細中
         IF NOT cl_null(g_xrca.xrca011) THEN     
            CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
               RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         END IF   
         
         IF (l_stbc2.stbc007 = l_stbd.stbd043  AND l_stbc2.stbc028 < l_stbd.stbd044) OR l_stbc2.stbc007 < l_stbd.stbd043 THEN 
            LET g_xrcb.xrcb060 = '1'
         END IF
         
         IF (l_stbc2.stbc007 = l_stbd.stbd043  AND l_stbc2.stbc028 > l_stbd.stbd044) OR l_stbc2.stbc007 > l_stbd.stbd043 THEN 
            LET g_xrcb.xrcb060 = '3'
         END IF
       
         #SELECT stbc022 INTO g_xrcb.xrcb055 FROM stbc_t
         # WHERE stbcent=g_enterprise
         #   AND stbc001=l_stbc2.stbc001
         #   AND stbc004=l_stbc2.stbc004
         #   AND stbc005=l_stbc2.stbc005 
         LET g_xrcb.xrcb057 = l_stbe.stbe016
         IF g_xrcb.xrcb060 = '3' THEN 
            LET g_xrcb.xrcb055 = g_xrcb.xrcb057
         ELSE
            LET g_xrcb.xrcb055 = 0
         END IF
         LET g_xrcb.xrcb056 = 0
         
         #160509-00004#93--add by lvjh-- str -- 
         #因为当月的结算单对应的费用单资料上面一步已经产生,所以这一步只要抓非当期的费用单资料
         IF l_stbd.stbd043 = l_stbc2.stbc007 AND l_stbd.stbd044 = l_stbc2.stbc028 THEN 
            LET g_xrcb.xrcb105 = 0
            LET g_xrcb.xrcb055 = 0
            LET g_xrcb.xrcb056 = 0
         END IF
         #160509-00004#93--add by lvjh-- end -- 
         
         #160509-00004#73--mark--str--lujh
         #IF l_oodb005 = 'Y' THEN
         #   LET g_xrcb.xrcb105 = g_xrcb.xrcb007*g_xrcb.xrcb101
         #   LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
         #   LET g_xrcb.xrcb103 = g_xrcb.xrcb105 - g_xrcb.xrcb104
         #
         #   LET g_xrcb.xrcb115 = g_xrcb.xrcb007*g_xrcb.xrcb111
         #   LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
         #   LET g_xrcb.xrcb113 = g_xrcb.xrcb115 - g_xrcb.xrcb114
         #ELSE
         #   LET g_xrcb.xrcb103 = g_xrcb.xrcb007*g_xrcb.xrcb101
         #   LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
         #   LET g_xrcb.xrcb105 = g_xrcb.xrcb103 + g_xrcb.xrcb104
         #
         #   LET g_xrcb.xrcb113 = g_xrcb.xrcb007*g_xrcb.xrcb111
         #   LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
         #   LET g_xrcb.xrcb115 = g_xrcb.xrcb113 + g_xrcb.xrcb114
         #END IF
         #UPDATE  xrcd_t SET xrcd103 = xrcd103 + l_diff,
         #                   xrcd105 = xrcd105 + l_diff,
         #                   xrcd113 = xrcd113 + l_diff1,
         #                   xrcd115 = xrcd115 + l_diff1
         # WHERE xrcdent = g_enterprise
         #   AND xrcddocno = g_xrca.xrcadocno
         #   AND xrcdld = g_xrca.xrcald
         #   AND xrcdseq = g_xrcb.xrcbseq
         #160509-00004#73--mark--end--lujh
            
         INSERT INTO xrcb_t(xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcblegl,
                            xrcb001,xrcb002,xrcb003,xrcb004,xrcb005,xrcb006,
                            xrcb007,xrcb008,xrcb009,xrcb010,xrcb011,xrcb012,
                            xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,
                            xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,
                            xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,
                            xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,
                            xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,
                            xrcb043,xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,
                            xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,
                            xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,
                            xrcb114,xrcb115,xrcb116,xrcb117,xrcb118,xrcb119,
                            xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,
                            xrcb133,xrcb134,xrcb135,xrcb136,xrcb055,xrcb056,
                            xrcb057,xrcb053,xrcb054,xrcb058,xrcb059,xrcb060)   
                     VALUES(g_xrcb.xrcbent,g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrcb.xrcbsite,g_xrcb.xrcborga,g_xrcb.xrcblegl,
                            g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003,g_xrcb.xrcb004,g_xrcb.xrcb005,g_xrcb.xrcb006,
                            g_xrcb.xrcb007,g_xrcb.xrcb008,g_xrcb.xrcb009,g_xrcb.xrcb010,g_xrcb.xrcb011,g_xrcb.xrcb012,
                            g_xrcb.xrcb013,g_xrcb.xrcb014,g_xrcb.xrcb015,g_xrcb.xrcb016,g_xrcb.xrcb017,g_xrcb.xrcb018,
                            g_xrcb.xrcb019,g_xrcb.xrcb020,g_xrcb.xrcb021,g_xrcb.xrcb022,g_xrcb.xrcb023,g_xrcb.xrcb024,
                            g_xrcb.xrcb025,g_xrcb.xrcb026,g_xrcb.xrcb027,g_xrcb.xrcb028,g_xrcb.xrcb029,g_xrcb.xrcb030,
                            g_xrcb.xrcb031,g_xrcb.xrcb032,g_xrcb.xrcb033,g_xrcb.xrcb034,g_xrcb.xrcb035,g_xrcb.xrcb036,
                            g_xrcb.xrcb037,g_xrcb.xrcb038,g_xrcb.xrcb039,g_xrcb.xrcb040,g_xrcb.xrcb041,g_xrcb.xrcb042,
                            g_xrcb.xrcb043,g_xrcb.xrcb044,g_xrcb.xrcb045,g_xrcb.xrcb046,g_xrcb.xrcb047,g_xrcb.xrcb048,
                            g_xrcb.xrcb049,g_xrcb.xrcb050,g_xrcb.xrcb051,g_xrcb.xrcb100,g_xrcb.xrcb101,g_xrcb.xrcb102,
                            g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,g_xrcb.xrcb106,g_xrcb.xrcb111,g_xrcb.xrcb113,
                            g_xrcb.xrcb114,g_xrcb.xrcb115,g_xrcb.xrcb116,g_xrcb.xrcb117,g_xrcb.xrcb118,g_xrcb.xrcb119,
                            g_xrcb.xrcb121,g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,g_xrcb.xrcb126,g_xrcb.xrcb131,
                            g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136,g_xrcb.xrcb055,g_xrcb.xrcb056,
                            g_xrcb.xrcb057,g_xrcb.xrcb053,g_xrcb.xrcb054,g_xrcb.xrcb058,g_xrcb.xrcb059,g_xrcb.xrcb060)  
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
            #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
            LET l_gen_doc_flag = 'N'
            EXIT FOR
            #160509-00004#93--add by lvjh-- end -- 
         END IF
         
         UPDATE stbe_t SET stbe040 = 'Y'
          WHERE stbeent = g_enterprise
            AND stbedocno = l_stbd.stbddocno
            AND stbe002 = l_stbe.stbe002
            AND stbe003 = l_stbe.stbe003
            
         LET l_gen_doc_flag = 'Y'   #160509-00004#93--add by lvjh-- 单据写入成功则将生成单据标识符置为Y
      END FOREACH
      #160509-00004#67--add--end--lujh
      
      #160509-00004#73--add--str---lujh
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM xrcb_t
       WHERE xrcbent = g_enterprise
         AND xrcbld = g_xrca.xrcald
         AND xrcbdocno = g_xrca.xrcadocno
         
      IF l_n = 0 THEN 
         DELETE FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
         CONTINUE FOR
      END IF
      #160509-00004#73--add--end---lujh
      
      SELECT stba008,stba009 INTO g_xrca.xrca014,g_xrca.xrca015
        FROM stba_t
       WHERE stbadocno = (SELECT xrcb002 FROM xrcb_t 
                             WHERE xrcbent=g_enterprise 
                               AND xrcbld=g_master.xrcald 
                               AND xrcbdocno=g_xrca.xrcadocno 
                               AND xrcbseq='1')
         AND stbaent=g_enterprise 
      UPDATE xrca_t SET xrca018 = (SELECT xrcb002 from xrcb_t 
                                    WHERE xrcbent=g_enterprise 
                                      AND xrcbld=g_master.xrcald 
                                      AND xrcbdocno=g_xrca.xrcadocno 
                                      AND xrcbseq='1'),
                        xrca014= g_xrca.xrca014,
                        xrca015=g_xrca.xrca015                              
       WHERE xrcadocno=g_xrcb.xrcbdocno  
         AND xrcaent=g_enterprise 
         AND xrcald=g_master.xrcald                  
      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
      CALL s_axrt300_xrca_upd(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
      #產生直接沖帳
      #20160615--mark--str--lujh   王霞说直接拿掉
      #IF g_master.b_check2='Y' THEN 
      #   CALL axrp139_ins_xrce()
      #END IF 
      #20160615--mark--end--lujh
      
      #產生多帳期
      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
      IF l_success = FALSE OR l_success = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_master.xrcadocno
         LET g_errparam.code   = 'aap-00092'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
         LET l_gen_doc_flag = 'N'
         EXIT FOR
         #160509-00004#93--add by lvjh-- end -- 
      END IF
       
      IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         LET g_prog = 'axrt211'
         CALL s_pre_voucher_ins('AR','R10',g_glaa.glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
         IF NOT l_success THEN
            LET l_doc_success = FALSE
            #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
            LET l_gen_doc_flag = 'N'
            EXIT FOR
            #160509-00004#93--add by lvjh-- end -- 
         END IF
         LET g_prog = 'axrp139'
      END IF
       
      #151125-00006#1---add---s  执行立即审核功能
      CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_slip_success,l_ooba002
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
       
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL s_axrp133_immediately_conf(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_conf_success
         IF NOT l_conf_success THEN 
            LET l_doc_success = FALSE
            #160509-00004#93--add by lvjh-- str -- 写入数据出错则重置生成单据标识符为N，表示生成单据失败，需要回滚异动
            LET l_gen_doc_flag = 'N'
            EXIT FOR
            #160509-00004#93--add by lvjh-- end -- 
         END IF 
      END IF 

   END FOR
   
   #160509-00004#93--add by lvjh-- str -- 
   IF l_gen_doc_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_tot_success = FALSE
   END IF
   #160509-00004#93--add by lvjh-- end -- 

   IF l_tot_success THEN
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = l_start_no
      LET g_errparam.replace[2] = l_end_no
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp139_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp139_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp139_ins_xrce()

   DEFINE l_xrcadocdt   LIKE xrca_t.xrcadocdt
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            prog           STRING,
            param          DYNAMIC ARRAY OF STRING,
            p_style        LIKE type_t.chr10,       #類型 axrt300 axrt340
            p_check        STRING
                        END RECORD
   DEFINE l_xrccdocno   LIKE xrcc_t.xrccdocno
   DEFINE l_xrccseq     LIKE xrcc_t.xrccseq
   DEFINE l_xrcc001     LIKE xrcc_t.xrcc001
   DEFINE l_xrca060     LIKE xrca_t.xrca060
   DEFINE l_xrca103     LIKE xrca_t.xrca103
   DEFINE l_xrca113     LIKE xrca_t.xrca113
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrcc        RECORD LIKE xrcc_t.*
   #DEFINE l_xrce        RECORD LIKE xrce_t.*
   DEFINE l_xrcc RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企業編號
       xrccld LIKE xrcc_t.xrccld, #帳套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #應收帳款單號碼
       xrccseq LIKE xrcc_t.xrccseq, #項次
       xrcc001 LIKE xrcc_t.xrcc001, #期別
       xrcc002 LIKE xrcc_t.xrcc002, #應收收款類別
       xrcc003 LIKE xrcc_t.xrcc003, #應收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容許票據到期日
       xrcc005 LIKE xrcc_t.xrcc005, #帳款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正負值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算組織
       xrcc008 LIKE xrcc_t.xrcc008, #發票編號
       xrcc009 LIKE xrcc_t.xrcc009, #發票號碼
       xrccsite LIKE xrcc_t.xrccsite, #帳務中心
       xrcc010 LIKE xrcc_t.xrcc010, #發票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出貨單據日期
       xrcc012 LIKE xrcc_t.xrcc012, #立帳日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易認定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入庫扣帳日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原幣別
       xrcc101 LIKE xrcc_t.xrcc101, #原幣匯率
       xrcc102 LIKE xrcc_t.xrcc102, #原幣重估後匯率
       xrcc103 LIKE xrcc_t.xrcc103, #重評價調整數
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原幣應收金額
       xrcc109 LIKE xrcc_t.xrcc109, #原幣收款沖帳金額
       xrcc113 LIKE xrcc_t.xrcc113, #本幣重評價調整數
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本幣應收金額
       xrcc119 LIKE xrcc_t.xrcc119, #本幣收款沖帳金額
       xrcc120 LIKE xrcc_t.xrcc120, #本位幣二幣別
       xrcc121 LIKE xrcc_t.xrcc121, #本位幣二匯率
       xrcc122 LIKE xrcc_t.xrcc122, #本位幣二重估後匯率
       xrcc123 LIKE xrcc_t.xrcc123, #本位幣二重評價調整數
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位幣二應收金額
       xrcc129 LIKE xrcc_t.xrcc129, #本位幣二收款沖帳金額
       xrcc130 LIKE xrcc_t.xrcc130, #本位幣三幣別
       xrcc131 LIKE xrcc_t.xrcc131, #本位幣三匯率
       xrcc132 LIKE xrcc_t.xrcc132, #本位幣三重估後匯率
       xrcc133 LIKE xrcc_t.xrcc133, #本位幣三重評價調整數
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位幣三應收金額
       xrcc139 LIKE xrcc_t.xrcc139, #本位幣三收款沖帳金額
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD
   DEFINE l_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企業編號
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #帳套
       xrcedocno LIKE xrce_t.xrcedocno, #沖銷單單號
       xrceseq LIKE xrce_t.xrceseq, #項次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #帳務中心
       xrceorga LIKE xrce_t.xrceorga, #帳務歸屬組織
       xrce001 LIKE xrce_t.xrce001, #來源作業
       xrce002 LIKE xrce_t.xrce002, #沖銷類型
       xrce003 LIKE xrce_t.xrce003, #沖銷帳款單單號
       xrce004 LIKE xrce_t.xrce004, #沖銷帳款單項次
       xrce005 LIKE xrce_t.xrce005, #沖銷帳款單帳期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要說明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #沖銷加減項
       xrce016 LIKE xrce_t.xrce016, #沖銷科目
       xrce017 LIKE xrce_t.xrce017, #業務人員
       xrce018 LIKE xrce_t.xrce018, #業務部門
       xrce019 LIKE xrce_t.xrce019, #責任中心
       xrce020 LIKE xrce_t.xrce020, #產品類別
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #專案編號
       xrce023 LIKE xrce_t.xrce023, #WBS編號
       xrce024 LIKE xrce_t.xrce024, #第二參考單號
       xrce025 LIKE xrce_t.xrce025, #第二參考單號項次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #應稅折抵否
       xrce028 LIKE xrce_t.xrce028, #產生方式
       xrce029 LIKE xrce_t.xrce029, #傳票號碼
       xrce030 LIKE xrce_t.xrce030, #傳票項次
       xrce035 LIKE xrce_t.xrce035, #區域
       xrce036 LIKE xrce_t.xrce036, #客戶分類
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #對象
       xrce039 LIKE xrce_t.xrce039, #經營方式
       xrce040 LIKE xrce_t.xrce040, #通路
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算項一
       xrce043 LIKE xrce_t.xrce043, #自由核算項二
       xrce044 LIKE xrce_t.xrce044, #自由核算項三
       xrce045 LIKE xrce_t.xrce045, #自由核算項四
       xrce046 LIKE xrce_t.xrce046, #自由核算項五
       xrce047 LIKE xrce_t.xrce047, #自由核算項六
       xrce048 LIKE xrce_t.xrce048, #自由核算項七
       xrce049 LIKE xrce_t.xrce049, #自由核算項八
       xrce050 LIKE xrce_t.xrce050, #自由核算項九
       xrce051 LIKE xrce_t.xrce051, #自由核算項十
       xrce053 LIKE xrce_t.xrce053, #發票編號
       xrce054 LIKE xrce_t.xrce054, #發票號碼
       xrce100 LIKE xrce_t.xrce100, #幣別
       xrce101 LIKE xrce_t.xrce101, #匯率
       xrce104 LIKE xrce_t.xrce104, #原幣應稅折抵稅額
       xrce109 LIKE xrce_t.xrce109, #原幣沖帳金額
       xrce114 LIKE xrce_t.xrce114, #本幣應稅折抵稅額
       xrce119 LIKE xrce_t.xrce119, #本幣沖帳金額
       xrce120 LIKE xrce_t.xrce120, #本位幣二幣別
       xrce121 LIKE xrce_t.xrce121, #本位幣二匯率
       xrce124 LIKE xrce_t.xrce124, #本位幣二應稅折抵稅額
       xrce129 LIKE xrce_t.xrce129, #本位幣二沖帳金額
       xrce130 LIKE xrce_t.xrce130, #本位幣二幣別
       xrce131 LIKE xrce_t.xrce131, #本位幣三匯率
       xrce134 LIKE xrce_t.xrce134, #本位幣三應稅折抵稅額
       xrce139 LIKE xrce_t.xrce139, #本位幣三沖帳金額
       xrce055 LIKE xrce_t.xrce055, #費用編號
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #預收待抵單號
       xrce058 LIKE xrce_t.xrce058, #應付單號
       xrce103 LIKE xrce_t.xrce103, #未稅原幣沖銷額
       xrce113 LIKE xrce_t.xrce113, #未稅本幣沖銷額
       xrce123 LIKE xrce_t.xrce123, #本位幣二未稅沖銷額
       xrce133 LIKE xrce_t.xrce133, #本位幣三未稅沖銷額
       xrce059 LIKE xrce_t.xrce059  #預收單號
       END RECORD

   #161128-00061#3-----modify--end----------
   DEFINE l_xrca        RECORD
             xrca014    LIKE xrca_t.xrca014,
             xrca015    LIKE xrca_t.xrca015,
             xrca033    LIKE xrca_t.xrca033,
             xrca034    LIKE xrca_t.xrca034,
             xrca035    LIKE xrca_t.xrca035,
             xrca100    LIKE xrca_t.xrca100
                        END RECORD
   DEFINE t_xrca        RECORD
             xrca004    LIKE xrca_t.xrca004,
			    xrca005    LIKE xrca_t.xrca005,
             xrca100    LIKE xrca_t.xrca100,
             xrca103    LIKE xrca_t.xrca103,
             xrca104    LIKE xrca_t.xrca104,
             xrca113    LIKE xrca_t.xrca113,
             xrca114    LIKE xrca_t.xrca114,
             xrca101    LIKE xrca_t.xrca101,
             xrca121    LIKE xrca_t.xrca121,
             xrca131    LIKE xrca_t.xrca131,
			    xrcadocdt  LIKE xrca_t.xrcadocdt
                        END RECORD
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   DEFINE l_ooef014     LIKE ooef_t.ooef014
   DEFINE l_ooaj004     LIKE ooaj_t.ooaj004
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE type_t.chr10
   #150316-00013#1 By 01727 Add  ---(S)---
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   DEFINE l_sfin1002    LIKE type_t.chr1
   DEFINE l_xrce109     LIKE xrce_t.xrce109
   DEFINE l_xrce119     LIKE xrce_t.xrce119
   DEFINE l_xrce129     LIKE xrce_t.xrce129
   DEFINE l_xrce139     LIKE xrce_t.xrce139
   #150316-00013#1 By 01727 Add  ---(E)---
   DEFINE l_sfin2020    LIKE type_t.chr1   #151130-00015#3   Add
   DEFINE l_wc2         STRING             #151130-00015#3   Add
   #150930-00010#3---add--str--
   DEFINE l_sfin2002    LIKE type_t.chr1
   DEFINE l_apce109     LIKE apce_t.apce109
   DEFINE l_apce119     LIKE apce_t.apce119
   DEFINE l_apce129     LIKE apce_t.apce129
   DEFINE l_apce139     LIKE apce_t.apce139
   #150930-00010#3---add--end--

   #151130-00015#3 Mod 為了使元件可以公用,將元件重寫.舊邏輯存入s_axrp133_ins_xrce_bak中

   #IF cl_null(ls_js) THEN RETURN END IF
   #CALL util.JSON.parse(ls_js,lc_param)
   #LET lc_param.p_check = lc_param.p_check.toUpperCase()
  #LET lc_param.p_check.getLength() <> 6 THEN RETURN END IF
   #IF lc_param.p_check = 'NNNNNN' THEN RETURN END IF
   #IF lc_param.p_style = 'axrt340' THEN RETURN END IF

   #161128-00061#3-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#3-----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcb.xrcbld
   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
      
   #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
   CALL s_curr_sel_ooaj004(l_ooef014,g_glaa.glaa001)
        RETURNING l_ooaj004

   SELECT xrca004,xrca005,xrca100,xrca103,xrca104,
          xrca113,xrca114,xrca101,xrca121,xrca131,xrcadocdt
     INTO t_xrca.xrca004,t_xrca.xrca005,t_xrca.xrca100,t_xrca.xrca103,t_xrca.xrca104,
          t_xrca.xrca113,t_xrca.xrca114,t_xrca.xrca101,t_xrca.xrca121,t_xrca.xrca131,t_xrca.xrcadocdt
     FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcb.xrcbdocno
      AND xrcald    = g_xrcb.xrcbld

        
   #STEP1:若發票單身有"27:其他待抵單"則先沖銷其他待抵單
   #STEP2:依據"自動沖銷"的勾選項,彙整待抵單

   #勾選訂金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=21 之訂金待抵
   #勾選銷退待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=22 之銷退待抵
   #勾選預收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=23 之预收待抵
   #勾選其他待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=29 之其他扣抵
   #勾選溢收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=24 之溢收待抵
   #勾選押金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=25 之押金待抵

   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcb.xrcbld
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1002') RETURNING l_sfin1002
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2020') RETURNING l_sfin2020   #151130-00015#3   Add
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2002') RETURNING l_sfin2002   #150930-00010#3   add

   IF l_sfin2020 MATCHES '[Yy]' THEN
      #本應收單號單身的出貨單,對應的訂單,對應的應收單,對應的待抵單

      #應收單單身對應的出貨單   g_xrcb.xrcbdocno,g_xrca.xrcald
      LET l_wc2 = "SELECT xrcb002 || '#' || xrcb003 FROM xrcb_t WHERE xrcbent = '",g_enterprise,"'    ",
                  "   AND xrcbld = '",g_xrcb.xrcbld,"' AND xrcb001 = '30' AND xrcbdocno = '",g_xrcb.xrcbdocno,"'"
      #出貨單單身對應的訂單
      LET l_wc2 = "SELECT stbc004 || '#' || stbc005 FROM stbc_t WHERE stbcent = '",g_enterprise,"'  ",
                  "   AND stbc004 || '#' || stbc005 IN (",l_wc2 CLIPPED,")"
      #訂單對應的訂單應收單
      LET l_wc2 = "SELECT xrcbdocno FROM xrcb_t WHERE xrcbent = '",g_enterprise,"' ",
                  "   AND xrcbld = '",g_xrcb.xrcbld,"' AND xrcb001 = '3'               ",
                  "   AND xrcb002 || '#' || xrcb003 IN (",l_wc2 CLIPPED,")         "
      #訂單應收單對應的待抵單
      LET l_wc2 = " xrca018 IN (",l_wc2 CLIPPED,")"
   ELSE
      LET l_wc2 = " 1=1"
   END IF
 
   IF NOT cl_null(l_wc) THEN LET l_wc = l_wc,"," END IF
   LET l_wc = "'23'"

   LET l_wc = " xrca004 = '",t_xrca.xrca004,"' AND xrca005 = '",t_xrca.xrca005,"' AND xrca001 IN (",l_wc CLIPPED,")"

   LET l_sql = "SELECT xrccdocno,xrccseq,xrcc001,1 flag,xrcadocdt,CASE WHEN xrca100 = '",t_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t  ",
               " WHERE xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
               "   AND xrccld = '",g_xrcb.xrcbld,"'                                               ",
               "   AND xrcc108 - xrcc109 > 0                                                        ",
               "   AND xrcadocdt <= '",t_xrca.xrcadocdt,"'                                        ",
               "   AND ",l_wc2 CLIPPED,   #151130-00015#3 Add
               "   AND ",l_wc  CLIPPED," ORDER BY flag ASC,xrcadocdt"
   PREPARE s_axrp132_xrce_prep FROM l_sql
   DECLARE s_axrp132_xrce_curs CURSOR FOR s_axrp132_xrce_prep

   LET l_xrce.xrceseq = 0
   LET l_xrca103 = t_xrca.xrca103 + t_xrca.xrca104
   LET l_xrca113 = t_xrca.xrca113 + t_xrca.xrca114

   FOREACH s_axrp132_xrce_curs INTO l_xrccdocno,l_xrccseq,l_xrcc001
      IF l_xrca103 = 0 THEN EXIT FOREACH END IF

      SELECT xrca014,xrca015,xrca033,xrca034,xrca035,xrca100
        INTO l_xrca.xrca014,l_xrca.xrca015,l_xrca.xrca033,l_xrca.xrca034,l_xrca.xrca035,l_xrca.xrca100
        FROM xrca_t WHERE xrcaent = g_enterprise
         AND xrcadocno = l_xrccdocno AND xrcald = g_master.xrcald
      #161128-00061#3-----modify--begin----------   
      #SELECT * INTO l_xrcc.* 
      SELECT xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,
             xrcc006,xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,
             xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,
             xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,
             xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,
             xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrcc015,xrcc016,xrcc017 INTO l_xrcc.* 
      #161128-00061#3-----modify--end----------
      FROM xrcc_t WHERE xrccent = g_enterprise
         AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq
         AND xrcc001 = l_xrcc001 AND xrccld = g_xrcb.xrcbld

      #150316-00013#1 By 01727 Add  ---(S)---
      #待抵單的可用餘額=xrcc108 - xrcc109 - 已沖帳但未確認金額
      #即等同於 xrcc108 - SUM(xrce109)
      LET l_xrce109 = 0    LET l_xrce119 = 0   LET l_xrce129 = 0   LET l_xrce139 = 0
      IF l_sfin1002 = '1' THEN
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
           INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t
          WHERE xrceent = g_enterprise       AND xrceld  = g_xrca.xrcald 
            AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
            AND xrcedocno IN (SELECT xrcadocno FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcald = g_xrcb.xrcbld AND xrcastus = 'N')
           #2016/02/23   Mark By 01727
           #AND xrcedocno IN (SELECT xrdadocno FROM xrda_t WHERE xrdaent = g_enterprise
           #   AND xrdald = p_xrcald AND xrdastus = 'N')
           #2016/02/23   Mark By 01727
      ELSE
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
           INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t
          WHERE xrceent = g_enterprise       AND xrceld  = g_xrca.xrcald 
            AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
            AND xrce005 = l_xrcc.xrcc001
            AND xrcedocno IN (SELECT xrcadocno FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcald = g_xrcb.xrcbld AND xrcastus = 'N')
           #2016/02/23   Mark By 01727
           #AND xrcedocno IN (SELECT xrdadocno FROM xrda_t WHERE xrdaent = g_enterprise
           #   AND xrdald = p_xrcald AND xrdastus = 'N')
           #2016/02/23   Mark By 01727
      END IF
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
      #150930-00010#3---mark---str-
#      LET l_xrcc.xrcc109 = l_xrcc.xrcc109 - l_xrce109
#      LET l_xrcc.xrcc119 = l_xrcc.xrcc119 - l_xrce119
#      LET l_xrcc.xrcc129 = l_xrcc.xrcc129 - l_xrce129
#      LET l_xrcc.xrcc139 = l_xrcc.xrcc139 - l_xrce139
#      IF l_xrcc.xrcc108 - l_xrcc.xrcc109 = 0 THEN CONTINUE FOREACH END IF
      #150930-00010#3---mark---end-
      #150316-00013#1 By 01727 Add  ---(E)---
      #150930-00010#3---add---str-
      #待抵單的可用餘額=xrcc108 - xrcc109 - 已沖帳但未確認金額
      #即等同於 xrcc108 - SUM(xrce109)
      LET l_apce109 = 0    LET l_apce119 = 0   LET l_apce129 = 0   LET l_apce139 = 0
      IF l_sfin2002 = '1' THEN
         SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
           INTO l_apce109,l_apce119,l_apce129,l_apce139
           FROM apce_t
          WHERE apceent = g_enterprise       AND apceld  = g_xrca.xrcald 
            AND apce003 = l_xrcc.xrccdocno   AND apce004 = l_xrcc.xrccseq
            AND apcedocno IN (SELECT apdadocno FROM apda_t WHERE apdaent = g_enterprise
               AND apdald = g_xrcb.xrcbld AND apdastus = 'N')
      ELSE
         SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
           INTO l_apce109,l_apce119,l_apce129,l_apce139
           FROM apce_t
          WHERE apceent = g_enterprise       AND apceld  = g_xrca.xrcald 
            AND apce003 = l_xrcc.xrccdocno   AND apce004 = l_xrcc.xrccseq
            AND apce005 = l_xrcc.xrcc001
            AND apcedocno IN (SELECT apdadocno FROM apda_t WHERE apdaent = g_enterprise
               AND apdald = g_xrcb.xrcbld AND apdastus = 'N')
      END IF
      IF cl_null(l_apce109) THEN LET l_apce109 = 0 END IF
      IF cl_null(l_apce119) THEN LET l_apce119 = 0 END IF
      IF cl_null(l_apce129) THEN LET l_apce129 = 0 END IF
      IF cl_null(l_apce139) THEN LET l_apce139 = 0 END IF
      LET l_xrcc.xrcc109 = l_xrcc.xrcc109 - l_xrce109 + l_apce109
      LET l_xrcc.xrcc119 = l_xrcc.xrcc119 - l_xrce119 + l_apce119
      LET l_xrcc.xrcc129 = l_xrcc.xrcc129 - l_xrce129 + l_apce129
      LET l_xrcc.xrcc139 = l_xrcc.xrcc139 - l_xrce139 + l_apce139
      IF l_xrcc.xrcc108 - l_xrcc.xrcc109 = 0 THEN CONTINUE FOREACH END IF
      #150930-00010#3---add---end-
      LET l_xrce.xrceent = g_enterprise
      LET l_xrce.xrcecomp= g_glaa.glaacomp
      LET l_xrce.xrceld  = g_xrcb.xrcbld
      LET l_xrce.xrcedocno=g_xrcb.xrcbdocno
      LET l_xrce.xrceseq = l_xrce.xrceseq + 1
      LET l_xrce.xrcelegl= l_xrcc.xrcclegl
      LET l_xrce.xrcesite= l_xrcc.xrccsite
      LET l_xrce.xrceorga= l_xrcc.xrccsite
      LET l_xrce.xrce001 = lc_param.p_style
      LET l_xrce.xrce002 = '31'
      LET l_xrce.xrce003 = l_xrcc.xrccdocno
      LET l_xrce.xrce004 = l_xrccseq
      LET l_xrce.xrce005 = l_xrcc.xrcc001
      LET l_xrce.xrce006 = ''
      LET l_xrce.xrce008 = ''
      LET l_xrce.xrce009 = ''
      LET l_xrce.xrce010 = ''
      LET l_xrce.xrce011 = ''
      LET l_xrce.xrce012 = ''
      LET l_xrce.xrce013 = ''
      LET l_xrce.xrce014 = ''
      LET l_xrce.xrce015 = 'D'
      LET l_xrce.xrce016 = l_xrca.xrca035
      LET l_xrce.xrce017 = l_xrca.xrca014
      LET l_xrce.xrce018 = l_xrca.xrca015
      LET l_xrce.xrce019 = l_xrca.xrca034
      LET l_xrce.xrce020 = ''
      LET l_xrce.xrce022 = l_xrca.xrca033
      LET l_xrce.xrce023 = ''
      LET l_xrce.xrce024 = ''
      LET l_xrce.xrce025 = ''
      LET l_xrce.xrce026 = ''
     #150316-00013#1 By 01727 Mark ---(S)---
     #SELECT xrca060 INTO l_xrca060 FROM xrca_t
     # WHERE xrcald = g_master.xrcald
     #   AND xrca019 = l_xrce.xrce003
     #150316-00013#1 By 01727 Mark ---(S)---
     #150316-00013#1 By 01727 Add  ---(S)---
      SELECT xrca060 INTO l_xrca060 FROM xrca_t
       WHERE xrcald = g_xrcb.xrcbld
         AND xrcadocno = l_xrce.xrce003
         AND xrcaent = g_enterprise
     #150316-00013#1 By 01727 Add  ---(S)---
      IF l_xrca060 = '2' THEN
         LET l_xrce.xrce027 = 'Y'
      ELSE
         LET l_xrce.xrce027 = 'N'
      END IF
      LET l_xrce.xrce028 = ''
      LET l_xrce.xrce029 = ''
      LET l_xrce.xrce030 = ''
      LET l_xrce.xrce035 = ''
      LET l_xrce.xrce036 = ''
      LET l_xrce.xrce037 = ''
      LET l_xrce.xrce038 = ''
      LET l_xrce.xrce104 = 0
      LET l_xrce.xrce114 = 0
      LET l_xrce.xrce124 = 0
      LET l_xrce.xrce134 = 0
      LET l_xrce.xrce100 = l_xrcc.xrcc100
      LET l_xrce.xrce101 = l_xrcc.xrcc102
      LET l_xrce.xrce120 = l_xrcc.xrcc120
      LET l_xrce.xrce121 = l_xrcc.xrcc122
      LET l_xrce.xrce130 = l_xrcc.xrcc130
      LET l_xrce.xrce131 = l_xrcc.xrcc132

      IF t_xrca.xrca100 = l_xrca.xrca100 THEN
         IF l_xrca103 > l_xrcc.xrcc108 - l_xrcc.xrcc109 THEN
            LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
            LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
            LET l_xrca103 = l_xrca103 - l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
         ELSE
            LET l_xrce.xrce007 = l_xrca103
            LET l_xrce.xrce109 = l_xrca103
            LET l_xrce.xrce119 = l_xrca103 * l_xrcc.xrcc101
            LET l_xrce.xrce129 = l_xrca103 * l_xrcc.xrcc121
            LET l_xrce.xrce139 = l_xrca103 * l_xrcc.xrcc131
            LET l_xrca103 = 0
            LET l_xrca113 = 0
         END IF
      ELSE
         IF l_xrca113 > l_xrcc.xrcc118 - l_xrcc.xrcc119 THEN
            LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
            LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
            LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrca103 = l_xrca113 / t_xrca.xrca101
         ELSE
            LET l_xrce.xrce007 = l_xrca113 / l_xrcc.xrcc101
            LET l_xrce.xrce007 = s_num_round('1',l_xrce.xrce007,l_ooaj004)
            LET l_xrce.xrce109 = l_xrce.xrce007
            LET l_xrce.xrce119 = l_xrca113
            LET l_xrce.xrce129 = l_xrce.xrce109 * l_xrcc.xrcc121
            LET l_xrce.xrce139 = l_xrce.xrce109 * l_xrcc.xrcc131
            LET l_xrca113 = 0
            LET l_xrca103 = 0
         END IF
      END IF

      #161128-00061#3-----modify--begin----------
      #INSERT INTO xrce_t VALUES (l_xrce.*)
      INSERT INTO xrce_t (xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,xrce001,
                          xrce002,xrce003,xrce004,xrce005,xrce006,xrce007,xrce008,xrce009,xrce010,xrce011,
                          xrce012,xrce013,xrce014,xrce015,xrce016,xrce017,xrce018,xrce019,xrce020,xrce021,
                          xrce022,xrce023,xrce024,xrce025,xrce026,xrce027,xrce028,xrce029,xrce030,xrce035,
                          xrce036,xrce037,xrce038,xrce039,xrce040,xrce041,xrce042,xrce043,xrce044,xrce045,
                          xrce046,xrce047,xrce048,xrce049,xrce050,xrce051,xrce053,xrce054,xrce100,xrce101,
                          xrce104,xrce109,xrce114,xrce119,xrce120,xrce121,xrce124,xrce129,xrce130,xrce131,
                          xrce134,xrce139,xrce055,xrce056,xrce057,xrce058,xrce103,xrce113,xrce123,xrce133,xrce059)
       VALUES (l_xrce.xrceent,l_xrce.xrcecomp,l_xrce.xrceld,l_xrce.xrcedocno,l_xrce.xrceseq,l_xrce.xrcelegl,l_xrce.xrcesite,l_xrce.xrceorga,l_xrce.xrce001,
               l_xrce.xrce002,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005,l_xrce.xrce006,l_xrce.xrce007,l_xrce.xrce008,l_xrce.xrce009,l_xrce.xrce010,l_xrce.xrce011,
               l_xrce.xrce012,l_xrce.xrce013,l_xrce.xrce014,l_xrce.xrce015,l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,l_xrce.xrce019,l_xrce.xrce020,l_xrce.xrce021,
               l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce024,l_xrce.xrce025,l_xrce.xrce026,l_xrce.xrce027,l_xrce.xrce028,l_xrce.xrce029,l_xrce.xrce030,l_xrce.xrce035,
               l_xrce.xrce036,l_xrce.xrce037,l_xrce.xrce038,l_xrce.xrce039,l_xrce.xrce040,l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,l_xrce.xrce044,l_xrce.xrce045,
               l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,l_xrce.xrce049,l_xrce.xrce050,l_xrce.xrce051,l_xrce.xrce053,l_xrce.xrce054,l_xrce.xrce100,l_xrce.xrce101,
               l_xrce.xrce104,l_xrce.xrce109,l_xrce.xrce114,l_xrce.xrce119,l_xrce.xrce120,l_xrce.xrce121,l_xrce.xrce124,l_xrce.xrce129,l_xrce.xrce130,l_xrce.xrce131,
               l_xrce.xrce134,l_xrce.xrce139,l_xrce.xrce055,l_xrce.xrce056,l_xrce.xrce057,l_xrce.xrce058,l_xrce.xrce103,l_xrce.xrce113,l_xrce.xrce123,l_xrce.xrce133,l_xrce.xrce059)
      #161128-00061#3-----modify--end----------
      IF SQLCA.sqlcode THEN
         LET g_success = 'N' RETURN
      END IF

   END FOREACH

   LET l_xrce.xrce109 = 0
   LET l_xrce.xrce119 = 0
   LET l_xrce.xrce129 = 0
   LET l_xrce.xrce139 = 0

  #非應稅折抵存入xrca107
   SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
     INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
      AND xrcedocno = g_xrcb.xrcbdocno AND xrceld = g_xrcb.xrcbld
      AND xrce027 = 'N'
   IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
   CALL s_curr_round_ld('1',g_xrca.xrcald,t_xrca.xrca100,l_xrce.xrce119 / t_xrca.xrca101,2)
      RETURNING l_success,l_errno,l_xrce.xrce109
   
   IF g_glaa.glaa015 = 'Y' THEN
      IF g_glaa.glaa017 = '1' THEN
         LET l_xrce.xrce129 = l_xrce.xrce109 * t_xrca.xrca121
      ELSE
         LET l_xrce.xrce129 = l_xrce.xrce119 * t_xrca.xrca121
      END IF
   END IF
   IF g_glaa.glaa019 = 'Y' THEN
      IF g_glaa.glaa021 = '1' THEN
         LET l_xrce.xrce139 = l_xrce.xrce109 * t_xrca.xrca131
      ELSE
         LET l_xrce.xrce139 = l_xrce.xrce119 * t_xrca.xrca131
      END IF
   END IF
   UPDATE xrca_t SET xrca107 = l_xrce.xrce109,
                     xrca117 = l_xrce.xrce119,
                     xrca127 = l_xrce.xrce129,
                     xrca137 = l_xrce.xrce139
    WHERE xrcaent = g_enterprise
      AND xrcadocno =g_xrcb.xrcbdocno
      AND xrcald = g_xrcb.xrcbld
  #應稅折抵存入xrca106
   LET l_xrce.xrce109 = 0
   LET l_xrce.xrce119 = 0
   LET l_xrce.xrce129 = 0
   LET l_xrce.xrce139 = 0
   SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
     INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
      AND xrcedocno = g_xrcb.xrcbdocno AND xrceld = g_xrcb.xrcbld
      AND xrce027 = 'Y'
   IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
   CALL s_curr_round_ld('1',g_xrcb.xrcbld,t_xrca.xrca100,l_xrce.xrce119 / t_xrca.xrca101,2)
      RETURNING l_success,l_errno,l_xrce.xrce109
   
   IF g_glaa.glaa015 = 'Y' THEN
      IF g_glaa.glaa017 = '1' THEN
         LET l_xrce.xrce129 = l_xrce.xrce109 * t_xrca.xrca121
      ELSE
         LET l_xrce.xrce129 = l_xrce.xrce119 * t_xrca.xrca121
      END IF
   END IF
   IF g_glaa.glaa019 = 'Y' THEN
      IF g_glaa.glaa021 = '1' THEN
         LET l_xrce.xrce139 = l_xrce.xrce109 * t_xrca.xrca131
      ELSE
         LET l_xrce.xrce139 = l_xrce.xrce119 * t_xrca.xrca131
      END IF
   END IF
   UPDATE xrca_t SET xrca106 = l_xrce.xrce109,
                     xrca116 = l_xrce.xrce119,
                     xrca126 = l_xrce.xrce129,
                     xrca136 = l_xrce.xrce139
    WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcb.xrcbdocno
      AND xrcald = g_xrcb.xrcbld

END FUNCTION

#end add-point
 
{</section>}
 
