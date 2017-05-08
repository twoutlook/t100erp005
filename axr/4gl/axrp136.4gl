#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp136.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-04-22 16:46:41), PR版次:0011(2016-12-01 14:34:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: axrp136
#+ Description: 零售日結帳款單批次產生作業
#+ Creator....: 01727(2015-04-20 14:38:31)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp136.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150417-00007#29 2015/06/01 BY 01727    增加賒銷作業
#150417-00007#60 2015/06/11 By 01727    產生axrt350 axrt370部分,根據經營方式+品類取得收入科目,若取不到再走之前邏輯
#150417-00007#69 2015/06/16 By 01727    axri201差异处理的SCC加入4，免赔贷方，axrp136差异处理的逻辑段的免赔的借贷方以axri201的科目直接写入
#151201-00002#53 2016/01/06 By 01727    天河程序回收產品
#151201-00002#62 2016/02/23 By 01727    賒銷部分由axrp146產生
#160509-00004#09 2016/05/11 By 02114    租賃日結修改
#160509-00004#34 2016/05/30 By 02114    axrp136的产生帐款明细时debz串到款别，默认是agli190的款别的科目
#160811-00009#4  2016/08/22 By 01531    账务中心/法人/账套权限控管
#161021-00050#2  2016/10/24 By 08729    處理組織開窗
#161128-00061#3  2016/12/01 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
   b_comb LIKE type_t.chr500, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   l_xrcadocno LIKE type_t.chr500, 
   debz002 LIKE debz_t.debz002, 
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
         xrcb052        LIKE xrcb_t.xrcb052,    #160509-00004#09 add lujh
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
         xrcb136        LIKE xrcb_t.xrcb136
END RECORD
 TYPE type_xrde RECORD
         xrdeent        LIKE xrde_t.xrdeent,
         xrdecomp       LIKE xrde_t.xrdecomp,
         xrdeld         LIKE xrde_t.xrdeld,
         xrdedocno      LIKE xrde_t.xrdedocno,
         xrdeseq        LIKE xrde_t.xrdeseq,
         xrdesite       LIKE xrde_t.xrdesite,
         xrdeorga       LIKE xrde_t.xrdeorga,
         xrde001        LIKE xrde_t.xrde001,
         xrde002        LIKE xrde_t.xrde002,
         xrde003        LIKE xrde_t.xrde003,
         xrde004        LIKE xrde_t.xrde004,
         xrde006        LIKE xrde_t.xrde006,
         xrde007        LIKE xrde_t.xrde007,
         xrde008        LIKE xrde_t.xrde008,
         xrde010        LIKE xrde_t.xrde010,
         xrde011        LIKE xrde_t.xrde011,
         xrde012        LIKE xrde_t.xrde012,
         xrde013        LIKE xrde_t.xrde013,
         xrde014        LIKE xrde_t.xrde014,
         xrde015        LIKE xrde_t.xrde015,
         xrde016        LIKE xrde_t.xrde016,
         xrde017        LIKE xrde_t.xrde017,
         xrde018        LIKE xrde_t.xrde018,
         xrde019        LIKE xrde_t.xrde019,
         xrde020        LIKE xrde_t.xrde020,
         xrde022        LIKE xrde_t.xrde022,
         xrde023        LIKE xrde_t.xrde023,
         xrde028        LIKE xrde_t.xrde028,
         xrde029        LIKE xrde_t.xrde029,
         xrde030        LIKE xrde_t.xrde030,
         xrde035        LIKE xrde_t.xrde035,
         xrde036        LIKE xrde_t.xrde036,
         xrde038        LIKE xrde_t.xrde038,
         xrde039        LIKE xrde_t.xrde039,
         xrde040        LIKE xrde_t.xrde040,
         xrde041        LIKE xrde_t.xrde041,
         xrde042        LIKE xrde_t.xrde042,
         xrde043        LIKE xrde_t.xrde043,
         xrde044        LIKE xrde_t.xrde044,
         xrde045        LIKE xrde_t.xrde045,
         xrde046        LIKE xrde_t.xrde046,
         xrde047        LIKE xrde_t.xrde047,
         xrde048        LIKE xrde_t.xrde048,
         xrde049        LIKE xrde_t.xrde049,
         xrde050        LIKE xrde_t.xrde050,
         xrde051        LIKE xrde_t.xrde051,
         xrde100        LIKE xrde_t.xrde100,
         xrde101        LIKE xrde_t.xrde101,
         xrde109        LIKE xrde_t.xrde109,
         xrde119        LIKE xrde_t.xrde119,
         xrde120        LIKE xrde_t.xrde120,
         xrde121        LIKE xrde_t.xrde121,
         xrde129        LIKE xrde_t.xrde129,
         xrde130        LIKE xrde_t.xrde130,
         xrde131        LIKE xrde_t.xrde131,
         xrde139        LIKE xrde_t.xrde139
END RECORD
 TYPE type_debz RECORD
         debzsite       LIKE debz_t.debzsite,
         debz001        LIKE debz_t.debz001,
         debz002        LIKE debz_t.debz002,
         debz003        LIKE debz_t.debz003,
         debz004        LIKE debz_t.debz004,
         debz005        LIKE debz_t.debz005,
         debz006        LIKE debz_t.debz006,
         debz007        LIKE debz_t.debz007,
         debz008        LIKE debz_t.debz008,
         debz009        LIKE debz_t.debz009,
         debz010        LIKE debz_t.debz010,
         debz011        LIKE debz_t.debz011,
         debz012        LIKE debz_t.debz012,
         debz013        LIKE debz_t.debz013,
         debz014        LIKE debz_t.debz014,
         debz015        LIKE debz_t.debz015,
         debz016        LIKE debz_t.debz016,
         debz017        LIKE debz_t.debz017,
         debz018        LIKE debz_t.debz018   ##150417-00007#60 Add
END RECORD
 TYPE type_deby RECORD
         debysite       LIKE deby_t.debysite,
         deby001        LIKE deby_t.deby001,
         deby002        LIKE deby_t.deby002,
         deby003        LIKE deby_t.deby003,
         deby004        LIKE deby_t.deby004,
         deby005        LIKE deby_t.deby005,
         deby006        LIKE deby_t.deby006,
         deby007        LIKE deby_t.deby007,
         deby008        LIKE deby_t.deby008,
         deby009        LIKE deby_t.deby009,
         deby010        LIKE deby_t.deby010,
         deby011        LIKE deby_t.deby011,
         deby012        LIKE deby_t.deby012,
         deby013        LIKE deby_t.deby013,
         deby014        LIKE deby_t.deby014,
         deby015        LIKE deby_t.deby015,
         deby016        LIKE deby_t.deby016,
         deby017        LIKE deby_t.deby017,
         deby018        LIKE deby_t.deby018
END RECORD
 TYPE type_deaf RECORD
         deafsite       LIKE deaf_t.deafsite,
         deafdocno      LIKE deaf_t.deafdocno,
         deafstatu      LIKE deaf_t.deafstatu,
         deafdocdt      LIKE deaf_t.deafdocdt,
         deaf001        LIKE deaf_t.deaf001,
         deaf002        LIKE deaf_t.deaf002,
         deaf003        LIKE deaf_t.deaf003,
         deaf004        LIKE deaf_t.deaf004,
         deaf005        LIKE deaf_t.deaf005,
         deaf006        LIKE deaf_t.deaf006,
         deaf007        LIKE deaf_t.deaf007,
         deaf008        LIKE deaf_t.deaf008,
         deaf009        LIKE deaf_t.deaf009,
         deaf010        LIKE deaf_t.deaf010,
         deaf011        LIKE deaf_t.deaf011,
         deaf012        LIKE deaf_t.deaf012,
         deaf013        LIKE deaf_t.deaf013,
         deaf014        LIKE deaf_t.deaf014,
         deaf015        LIKE deaf_t.deaf015,
         deaf016        LIKE deaf_t.deaf016,
         deaf017        LIKE deaf_t.deaf017,
         deaf018        LIKE deaf_t.deaf018,
         deaf020        LIKE deaf_t.deaf020,
         deaf023        LIKE deaf_t.deaf023,       #160509-00004#9 add lujh
         #160509-00004#40--add--str--lujh
         deaf024        LIKE deaf_t.deaf024,
         deaf025        LIKE deaf_t.deaf025,
         deaf026        LIKE deaf_t.deaf026,
         deaf027        LIKE deaf_t.deaf027
         #160509-00004#40--add--end--lujh
END RECORD

#130726-00001#95 Add  ---(S)---
 TYPE type_rtja RECORD
         orders         LIKE type_t.chr200,
         rtja000        LIKE rtja_t.rtja000,
         rtjasite       LIKE rtja_t.rtjasite,
         rtjadocno      LIKE rtja_t.rtjadocno,
         rtja002        LIKE rtja_t.rtja002,
         rtja025        LIKE rtja_t.rtja025,
         rtja026        LIKE rtja_t.rtja026,
         rtja028        LIKE rtja_t.rtja028,
         rtjf003        LIKE rtjf_t.rtjf003,
         rtjf027        LIKE rtjf_t.rtjf027
END RECORD
#130726-00001#95 Add  ---(E)---
#160509-00004#9--add--str--lujh
DEFINE g_origin_str    STRING
DEFINE g_comp          LIKE glaa_t.glaacomp
DEFINE g_xrcbseq       LIKE xrcb_t.xrcbseq
#160509-00004#9--add--end--lujh
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp136.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axrp136_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp136 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp136_init()
 
      #進入選單 Menu (="N")
      CALL axrp136_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp136
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axrp136_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp136.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrp136_init()
 
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
   LET g_master.debz002   = NULL
   CALL s_fin_create_account_center_tmp()   
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success
   CALL axrp136_create_tmp() RETURNING l_success         #160509-00004#9 add lujh
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp136.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp136_ui_dialog()
 
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
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrcasite,g_master.xrcald,g_master.b_comb,g_master.xrcadocno,g_master.l_xrcadocno, 
             g_master.debz002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL axrp136_def()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcasite
            
            #add-point:AFTER FIELD xrcasite name="input.a.xrcasite"
            IF NOT cl_null(g_master.xrcasite) THEN
               #161021-00050#2-add(s)
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
               #161021-00050#2-add(e)    
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               IF NOT l_success THEN NEXT FIELD CURRENT END IF
            ELSE
               LET g_master.xrcasite_desc = ''
            END IF
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            CALL axrp136_get_comp(g_master.xrcald)    #160509-00004#9 add lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcasite
            #add-point:BEFORE FIELD xrcasite name="input.b.xrcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcasite
            #add-point:ON CHANGE xrcasite name="input.g.xrcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="input.a.xrcald"
            IF NOT cl_null(g_master.xrcald) THEN 
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_master.xrcald_desc = ''
            END IF
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            CALL axrp136_get_comp(g_master.xrcald)    #160509-00004#9 add lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="input.b.xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcald
            #add-point:ON CHANGE xrcald name="input.g.xrcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_comb
            #add-point:BEFORE FIELD b_comb name="input.b.b_comb"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_comb
            
            #add-point:AFTER FIELD b_comb name="input.a.b_comb"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_comb
            #add-point:ON CHANGE b_comb name="input.g.b_comb"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="input.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
            IF NOT cl_null(g_master.xrcadocno) THEN
               SELECT glaa024 INTO l_glaa024 FROM glaa_t
                 WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_glaa024
               LET g_chkparam.arg2 = g_master.xrcadocno
               IF NOT s_aooi200_fin_chk_slip(g_master.xrcald,l_glaa024,g_master.xrcadocno,'axrt350') THEN
                  LET g_master.xrcadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocno
            #add-point:ON CHANGE xrcadocno name="input.g.xrcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcadocno
            #add-point:BEFORE FIELD l_xrcadocno name="input.b.l_xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcadocno
            
            #add-point:AFTER FIELD l_xrcadocno name="input.a.l_xrcadocno"
            IF NOT cl_null(g_master.l_xrcadocno) THEN
               SELECT glaa024 INTO l_glaa024 FROM glaa_t
                 WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_glaa024
               LET g_chkparam.arg2 = g_master.l_xrcadocno
               IF NOT s_aooi200_fin_chk_slip(g_master.xrcald,l_glaa024,g_master.l_xrcadocno,'axrt370') THEN
                  LET g_master.l_xrcadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcadocno
            #add-point:ON CHANGE l_xrcadocno name="input.g.l_xrcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debz002
            #add-point:BEFORE FIELD debz002 name="input.b.debz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debz002
            
            #add-point:AFTER FIELD debz002 name="input.a.debz002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE debz002
            #add-point:ON CHANGE debz002 name="input.g.debz002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcasite
            #add-point:ON ACTION controlp INFIELD xrcasite name="input.c.xrcasite"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcasite             #給予default值
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 

            #給予arg

            #CALL q_ooef001()                                        #呼叫開窗   #161021-00050#2 mark
            LET g_qryparam.where = " ooefstus = 'Y' "                           #161021-00050#2 add
            CALL q_ooef001_46()                                                 #161021-00050#2 add
            LET g_master.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
            IF NOT cl_null(g_master.xrcasite) THEN
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
            END IF
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            NEXT FIELD xrcasite

            #END add-point
 
 
         #Ctrlp:input.c.xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="input.c.xrcald"
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_today,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL axrp136_get_ooef001_wc(ls_wc) RETURNING ls_wc  
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
            END IF
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            NEXT FIELD xrcald                              #返回原欄位  

            #END add-point
 
 
         #Ctrlp:input.c.b_comb
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb
            #add-point:ON ACTION controlp INFIELD b_comb name="input.c.b_comb"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcadocno             #給予default值
            #給予arg
            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'axrt350'

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.xrcadocno = g_qryparam.return1              
            DISPLAY g_master.xrcadocno TO xrcadocno              #
            NEXT FIELD xrcadocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.l_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcadocno
            #add-point:ON ACTION controlp INFIELD l_xrcadocno name="input.c.l_xrcadocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xrcadocno             #給予default值
            #給予arg
            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'axrt370'

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.l_xrcadocno = g_qryparam.return1              
            DISPLAY g_master.l_xrcadocno TO l_xrcadocno              #
            NEXT FIELD l_xrcadocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.debz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debz002
            #add-point:ON ACTION controlp INFIELD debz002 name="input.c.debz002"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xrcasite_desc,xrcald_desc
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcasite
            #add-point:BEFORE FIELD xrcasite name="construct.b.xrcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcasite
            
            #add-point:AFTER FIELD xrcasite name="construct.a.xrcasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcasite
            #add-point:ON ACTION controlp INFIELD xrcasite name="construct.c.xrcasite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcasite_desc
            #add-point:BEFORE FIELD xrcasite_desc name="construct.b.xrcasite_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcasite_desc
            
            #add-point:AFTER FIELD xrcasite_desc name="construct.a.xrcasite_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcasite_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcasite_desc
            #add-point:ON ACTION controlp INFIELD xrcasite_desc name="construct.c.xrcasite_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="construct.b.xrcald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="construct.a.xrcald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="construct.c.xrcald"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald_desc
            #add-point:BEFORE FIELD xrcald_desc name="construct.b.xrcald_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald_desc
            
            #add-point:AFTER FIELD xrcald_desc name="construct.a.xrcald_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcald_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald_desc
            #add-point:ON ACTION controlp INFIELD xrcald_desc name="construct.c.xrcald_desc"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL axrp136_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
         AFTER DIALOG 
            CALL axrp136_91_chk()
            IF NOT cl_null(g_errno) AND cl_null(g_master.l_xrcadocno) THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = g_errno
               LET g_errparam.popup  = TRUE 
               CALL cl_err() 
               NEXT FIELD l_xrcadocno 
            END IF
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
         CALL axrp136_init()
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
                 CALL axrp136_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrp136_transfer_argv(ls_js)
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
 
{<section id="axrp136.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrp136_transfer_argv(ls_js)
 
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
 
{<section id="axrp136.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrp136_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   #2015/06/11--add--str--
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002
  
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
   IF cl_null(l_ooaa002) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00363"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #2015/06/11--add--end
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axrp136_process_cs CURSOR FROM ls_sql
#  FOREACH axrp136_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL axrp136_get_ar()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axrp136_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp136.get_buffer" >}
PRIVATE FUNCTION axrp136_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xrcasite = p_dialog.getFieldBuffer('xrcasite')
   LET g_master.xrcald = p_dialog.getFieldBuffer('xrcald')
   LET g_master.b_comb = p_dialog.getFieldBuffer('b_comb')
   LET g_master.xrcadocno = p_dialog.getFieldBuffer('xrcadocno')
   LET g_master.l_xrcadocno = p_dialog.getFieldBuffer('l_xrcadocno')
   LET g_master.debz002 = p_dialog.getFieldBuffer('debz002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrp136.msgcentre_notify" >}
PRIVATE FUNCTION axrp136_msgcentre_notify()
 
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
 
{<section id="axrp136.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 定义需要使用的CURSOR
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/08/27 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp136_def_curs()
   DEFINE l_origin_str    STRING
   DEFINE l_sql           STRING
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002
   DEFINE l_glaa023       LIKE glaa_t.glaa023   #1:主账套 2:第一辅账 3:第二辅账

   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002

   LET l_glaa023 = 0
   SELECT CASE WHEN glaa014 = 'Y' THEN '0' ELSE glaa023 END + 1 INTO l_glaa023
     FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_master.xrcald

   #160509-00004#9--mark--str--lujh
   #CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_master.debz002,'')
   #CALL s_fin_account_center_sons_str()RETURNING l_origin_str
   #IF cl_null(l_origin_str) THEN LET l_origin_str = g_master.xrcasite END IF
   #CALL axrp136_get_ooef001_wc(l_origin_str)RETURNING l_origin_str
   #160509-00004#9--mark--end--lujh
   LET l_origin_str = g_origin_str     #160509-00004#9 add lujh

   #STEP2 --(S)--- 定义CURSOR
   CASE
      WHEN l_glaa023 = '1'
         LET l_str1 = " AND (debz015 IS NULL OR debz015 =0) "
         LET l_str2 = " AND (deby016 IS NULL OR deby016 =0) "
         LET l_str3 = " AND deaf011 = 'N' "
      WHEN l_glaa023 = '2'
         LET l_str1 = " AND (debz016 IS NULL OR debz016 =0) "
         LET l_str2 = " AND (deby017 IS NULL OR deby017 =0) "
         LET l_str3 = " AND deaf021 = 'N' "
      WHEN l_glaa023 = '3'
         LET l_str1 = " AND debz017 IS NULL OR debz017 =0 "
         LET l_str2 = " AND deby018 IS NULL OR deby018 =0 "
         LET l_str3 = " AND deaf022 = 'N' "
   END CASE
   LET l_sql = "SELECT DISTINCT debzsite FROM debz_t ",
               " WHERE debzent = '",g_enterprise,"'",
               "   AND debz002 = '",g_master.debz002,"'",
               "   AND debzent = '",g_enterprise,"'",
               "   AND debzsite IN ",l_origin_str CLIPPED,l_str1 CLIPPED,
               " UNION ",
               "SELECT DISTINCT debysite FROM deby_t ",
               " WHERE debyent = '",g_enterprise,"'",
               "   AND deby003 = '",g_master.debz002,"'",
               "   AND debyent = '",g_enterprise,"'",
               "   AND debysite IN ",l_origin_str CLIPPED,l_str2 CLIPPED,
               " UNION ",
               "SELECT deafsite FROM deaf_t,deag_t ",
               " WHERE deagent = deafent AND deagdocno = deafdocno",
               "   AND deagent = deafent                          ",
               "   AND deagdocdt = '",g_master.debz002,"'",
               "   AND deagent = '",g_enterprise,"'",
               "   AND deaf009 IN ('1','2','4','6','7')",
               "   AND deagstus = 'Y' ",      #20150729 add lujh
               "   AND deagsite IN ",l_origin_str CLIPPED,l_str3 CLIPPED
   PREPARE axrp136_site_prep FROM l_sql
   DECLARE axrp136_site_curs CURSOR FOR axrp136_site_prep
   #STEP2 --(E)--- 定义CURSOR

   #STEP3 --(S)--- 定义CURSOR
   CASE
      WHEN l_glaa023 = '1'
         LET l_str3 = " AND deaf011 = 'N' "
      WHEN l_glaa023 = '2'
         LET l_str3 = " AND deaf021 = 'N' "
      WHEN l_glaa023 = '3'
         LET l_str3 = " AND deaf022 = 'N' "
   END CASE
   #2015/06/16 Add
   LET l_sql = "SELECT rtjf030,deag004 FROM",
               "(SELECT DISTINCT rtjf030 FROM rtja_t,rtjf_t",
               " WHERE rtjaent   = rtjfent",
               "   AND rtjadocno = rtjfdocno",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND rtjadocdt = '",g_master.debz002,"'",
               "   AND rtjasite  = ? ",
               "   AND rtjf001 <> '91' ",
               "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = xrcbent ",
               "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld    ",
               "                      AND xrcald = '",g_master.xrcald,"'               ",
               "                      AND xrcastus <> 'X' AND xrcb002 = rtjadocno)     ",
               "   AND rtjastus = 'S'",
               "   AND rtja000 IN ('ammt405','agct405','artt600','artt610','crtt620')) LEFT JOIN ",   #20150729 add crtt620 lujh
               "(SELECT DISTINCT deag004 FROM deaf_t,deag_t ",
               " WHERE deagent = deafent AND deagdocno = deafdocno",
               "   AND deagent = deafent                          ",
               "   AND deagdocdt = '",g_master.debz002,"'",
               "   AND deagent = '",g_enterprise,"' ",l_str3 CLIPPED,
               "   AND deagstus = 'Y'",
               "   AND deafsite = ?)",
               " ON rtjf030 = deag004"
   PREPARE axrp136_rtjf030_prep FROM l_sql
   DECLARE axrp136_rtjf030_curs CURSOR FOR axrp136_rtjf030_prep
   #STEP3 --(E)--- 定义CURSOR

   #STEP5 --(S)--- 定义CURSOR
   CASE
      WHEN l_glaa023 = '1'
         LET l_str1 = " AND (debz015 IS NULL OR debz015 =0) "
         LET l_str2 = " AND (deby016 IS NULL OR deby016 =0) "
      WHEN l_glaa023 = '2'
         LET l_str1 = " AND (debz016 IS NULL OR debz016 =0) "
         LET l_str2 = " AND (deby017 IS NULL OR deby017 =0) "
      WHEN l_glaa023 = '3'
         LET l_str1 = " AND (debz017 IS NULL OR debz017 =0) "
         LET l_str2 = " AND (deby018 IS NULL OR deby018 =0) "
   END CASE
   LET l_sql = "SELECT SUM(debz012)",
               "  FROM debz_t ",
               " WHERE debzent = '",g_enterprise,"'",
               "   AND debz002 = '",g_master.debz002,"' ",l_str1 CLIPPED,
               "   AND debzsite = ?"
   PREPARE axrp136_diff_debz_prep FROM l_sql

   LET l_sql = "SELECT SUM(deby004-deby012)",
               "  FROM deby_t ",
               " WHERE debyent = '",g_enterprise,"'",
               "   AND deby003 = '",g_master.debz002,"' ",l_str2 CLIPPED,
               "   AND debysite = ?"
   PREPARE axrp136_diff_deby_prep FROM l_sql


   LET l_sql = "SELECT SUM(deby012)",
               "  FROM deby_t ",
               " WHERE debyent = '",g_enterprise,"'",
               "   AND deby003 = '",g_master.debz002,"' ",l_str2 CLIPPED,
               "   AND debysite = ?"
   PREPARE axrp136_other_deby_prep FROM l_sql

   #STEP5 --(E)--- 定义CURSOR

   #STEP6 --(S)--- 定义CURSOR
   CASE
      WHEN l_glaa023 = '1'
         LET l_str1 = " AND (debz015 IS NULL OR debz015 =0) "
      WHEN l_glaa023 = '2'
         LET l_str1 = " AND (debz016 IS NULL OR debz016 =0) "
      WHEN l_glaa023 = '3'
         LET l_str1 = " AND (debz017 IS NULL OR debz017 =0) "
   END CASE
   LET l_sql = "SELECT debzsite,debz001,debz002,debz003,debz004,debz005,debz006,rtaw001,debz008,",
               "       SUM(debz009),SUM(debz010),SUM(debz011),SUM(debz012),SUM(debz013),debz014,debz015,debz016,debz017,",
               "       debz018",           #150417-00007#60   Add
               "  FROM debz_t,rtaw_t ",
               " WHERE debzent = '",g_enterprise,"'",
               "   AND debz002 = '",g_master.debz002,"' ",l_str1 CLIPPED,
               "   AND rtaw002 = debz007",
               "   AND rtaw003 = '",l_ooaa002,"'",
               "   AND rtawent = debzent",
               "   AND debzsite = ?",
               " GROUP BY debzsite,debz001,debz002,debz003,debz004,debz005,debz006,rtaw001,debz008,",
               "          debz014,debz015,debz016,debz017,debz018"
   PREPARE axrp136_debz_prep FROM l_sql
   DECLARE axrp136_debz_curs CURSOR FOR axrp136_debz_prep
   #STEP6 --(E)--- 定义CURSOR

   #STEP8 --(S)--- 定义CURSOR
   CASE
      WHEN l_glaa023 = '1'
         LET l_str3 = " AND deaf011 = 'N' "
      WHEN l_glaa023 = '2'
         LET l_str3 = " AND deaf021 = 'N' "
      WHEN l_glaa023 = '3'
         LET l_str3 = " AND deaf022 = 'N' "
   END CASE
   LET l_sql = "SELECT deafsite,deafdocno,deafstatu,deafdocdt,         ",
               "       deaf001,deaf002,deaf003,deaf004,deaf005,deaf006,",
               "       deaf007,deaf008,deaf009,deaf010,deaf011,deaf012,",
               "       deaf013,deaf014,deaf015,deaf016,deaf017,deaf018,deaf020,deaf023, ", #160509-00004#9 add deaf023 lujh 
               "       deaf024,deaf025,deaf026,deaf027 ",  #160509-00004#40 add lujh
               "  FROM deaf_t,deag_t ",   
               " WHERE deagent = deafent AND deagdocno = deafdocno",
               "   AND deagent = deafent                          ",
               "   AND deagdocdt = '",g_master.debz002,"'",
               "   AND deagent = '",g_enterprise,"'",
               "   AND deagstus = 'Y' ",      #20150729 add lujh
               "   AND deafsite = ? ",l_str3 CLIPPED,
               " UNION ",
               "SELECT rtjfsite,rtjadocno,'',rtjf025,",
               "       rtjf027,rtjf028,'',rtjf030,rtjf002,rtjf003,",
               "       0,0,'','','','',",
               "       '',0,0,'','','',0,0, ",    #160509-00004#9 add 0 lujh 
               "       '','','',0 ",              #160509-00004#40 add lujh
               "  FROM rtja_t,rtjf_t",
               " WHERE rtjaent   = rtjfent",
               "   AND rtjadocno = rtjfdocno",
               "   AND rtjadocdt = '",g_master.debz002,"'",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND rtjasite  = ? ",
               "   AND rtjf001   = '91' ",
               "   AND rtjastus = 'S'"
   PREPARE axrp136_deaf_prep FROM l_sql
   DECLARE axrp136_deaf_curs CURSOR FOR axrp136_deaf_prep
   #STEP8 --(E)--- 定义CURSOR

   #STEP9 --(S)--- 定义CURSOR
   #150417-00007#29 Add  ---(S)---
   LET l_sql = "SELECT rtjadocdt||'@'||rtja002||'@'||rtja025||'@'||rtja026||'@'||CASE WHEN rtjf003 > 0 THEN 1 ELSE 2 END||'@'||rtja053,",
               "       rtja000,rtjasite,rtjadocno,rtja002,rtja025,rtja026,rtja028,rtjf003,rtjf027,rtja053 ",
               "  FROM rtja_t,rtjf_t",
               " WHERE rtjaent   = rtjfent",
               "   AND rtjadocno = rtjfdocno",
               "   AND rtjadocdt = '",g_master.debz002,"'",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND rtjasite  = ? ",
               "   AND rtjf001   = '91' ",
               "   AND rtjastus = 'S'",
               "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = xrcbent ",
               "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld    ",
               "                      AND xrcald = '",g_master.xrcald,"'               ",
               "                      AND xrcastus <> 'X' AND xrcb002 = rtjadocno)     ",
               "   AND rtja000 IN ('ammt405','agct405','artt600','artt610','artt620')"   #20150729 add crtt620 lujh
              ," ORDER BY rtjadocdt,rtja002,rtja025,rtja026,rtjf003,rtja053"
   PREPARE axrp136_rtjf_prep FROM l_sql
   DECLARE axrp136_rtjf_curs CURSOR FOR axrp136_rtjf_prep
   #150417-00007#29 Add  ---(E)---
   #STEP9 --(E)--- 定义CURSOR
   
   #160509-00004#9--add--str--lujh
   #STEP11 ---(S)---
   LET l_sql ="SELECT DISTINCT deaf026,ooef017 ",
              "  FROM deag_t,deaf_t ",
              "  LEFT OUTER JOIN ooef_t ",
              "    ON deafent = ooefent ",
              "   AND deaf026 = ooef001 ",
              " WHERE deafent = ",g_enterprise,
              "   AND deagent = deafent ",
              "   AND deagdocno = deafdocno ",
              "   AND deagdocdt = '",g_master.debz002,"'",
              "   AND deafsite = ? "
   PREPARE axrp136_deaf026_prep FROM l_sql
   DECLARE axrp136_deaf026_curs CURSOR FOR axrp136_deaf026_prep
   #STEP11 ---(S)---
   
   #STEP12 --(S)--- 定义CURSOR
   CASE
      WHEN l_glaa023 = '1'
         LET l_str1 = " AND (debz015 IS NULL OR debz015 =0) "
      WHEN l_glaa023 = '2'
         LET l_str1 = " AND (debz016 IS NULL OR debz016 =0) "
      WHEN l_glaa023 = '3'
         LET l_str1 = " AND (debz017 IS NULL OR debz017 =0) "
   END CASE
   LET l_sql = "SELECT debzsite,debz005,rtaw001,debz008,debz014,debz018,rtjf002,SUM(rtjf031) ",
               "  FROM (",
               "SELECT DISTINCT debzsite,debz005,rtaw001,debz008,",
               "       debz014,debz018,rtjf002,rtjf031",    
               "  FROM debz_t,rtaw_t,rtjf_t ",
               " WHERE debzent = '",g_enterprise,"'",
               "   AND debz002 = '",g_master.debz002,"' ",l_str1 CLIPPED,
               "   AND rtaw002 = debz007",
               "   AND rtaw003 = '",l_ooaa002,"'",
               "   AND rtawent = debzent",
               "   AND debzsite = ?",
               "   AND debzent = rtjfent ",
               "   AND debz002 = rtjf025 ",
               "   AND debz005 = rtjf027 ",
               "   AND debzsite = rtjfsite ",
               "   AND debz005 = ? ",           #160509-00004#34 add lujh
               "   )",
               " GROUP BY debzsite,debz005,rtaw001,debz008,debz014,debz018,rtjf002"
   PREPARE axrp136_debz018_5_prep FROM l_sql
   DECLARE axrp136_debz018_5_curs CURSOR FOR axrp136_debz018_5_prep
   
   
   #161128-00061#3-----modify--begin----------
   #LET l_sql = "SELECT * FROM xrcb_t ",
   LET l_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
               "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
               "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
               "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
               "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
               "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
               "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
               "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
               "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
               "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
               "xrcb058,xrcb059,xrcb060,xrcb107 FROM xrcb_t",
   #161128-00061#3-----modify--begin----------
               " WHERE xrcbent = ",g_enterprise,
               "   AND xrcbld = '",g_master.xrcald,"'", 
               "   AND xrcbdocno = ? "
   PREPARE axrp136_xrcb_prep FROM l_sql
   DECLARE axrp136_xrcb_curs CURSOR FOR axrp136_xrcb_prep
   
   #161128-00061#3-----modify--begin----------
   #LET l_sql = "SELECT * FROM xrcc_t ",
   LET l_sql = "SELECT xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,",
               "xrcc006,xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,",
               "xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,",
               "xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,xrcc123,xrcc124,xrcc125,",
               "xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,",
               "xrcc137,xrcc138,xrcc139,xrcc015,xrcc016,xrcc017 FROM xrcc_t ",
   #161128-00061#3-----modify--end----------
               " WHERE xrccent = ",g_enterprise,
               "   AND xrccld = '",g_master.xrcald,"'", 
               "   AND xrccdocno = ? "
   PREPARE axrp136_xrcc_prep FROM l_sql
   DECLARE axrp136_xrcc_curs CURSOR FOR axrp136_xrcc_prep
   
   
   #161128-00061#3-----modify--begin----------
   #LET l_sql = "SELECT * FROM xrde_t ",
    LET l_sql = "SELECT xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,",
                "xrde004,xrde006,xrde007,xrde008,xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,xrde016,",
                "xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,xrde035,xrde036,",
                "xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,xrde046,xrde047,xrde048,",
                "xrde049,xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,",
                "xrde131,xrde139,xrde032,xrde108,xrde118 FROM xrde_t",
   #161128-00061#3-----modify--end----------
               " WHERE xrdeent = ",g_enterprise,
               "   AND xrdeld = '",g_master.xrcald,"'", 
               "   AND xrdedocno = ? "
   PREPARE axrp136_xrde_prep FROM l_sql
   DECLARE axrp136_xrde_curs CURSOR FOR axrp136_xrde_prep
   #STEP12 --(E)--- 定义CURSOR
   #160509-00004#9--add--end--lujh
   
   #160509-00004#34--add--str--lujh
   #161128-00061#3-----modify--begin----------
   #LET l_sql = "SELECT * FROM xrcb_t ",
    LET l_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
               "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
               "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
               "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
               "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
               "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
               "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
               "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
               "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
               "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
               "xrcb058,xrcb059,xrcb060,xrcb107 FROM xrcb_t",
   #161128-00061#3-----modify--end----------
               " WHERE xrcbent = ",g_enterprise,
               "   AND xrcbld = '",g_master.xrcald,"'", 
               "   AND xrcbdocno = ? ",
               "   AND xrcb001 IN ('19','29')"
   PREPARE axrp136_xrcb_prep1 FROM l_sql
   DECLARE axrp136_xrcb_curs1 CURSOR FOR axrp136_xrcb_prep1
   #160509-00004#34--add--end--lujh
END FUNCTION
################################################################################
# Descriptions...: 給帳務中心、帳套賦默認值
# Memo...........:
# Usage..........: CALL axrp136_def()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2015/04/20 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp136_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_xrcacomp    LIKE xrca_t.xrcacomp
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003

   IF cl_null(g_master.xrcasite) OR cl_null(g_master.xrcald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xrcasite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_master.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_master.xrcald 
      LET g_comp = l_xrcacomp         #160509-00004#9 add lujh   

      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_master.xrcald   = ''
      END IF

      CALL s_axrt300_xrca_ref('xrcald',g_master.xrcald,'','') RETURNING l_success,g_master.xrcald_desc
      CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
      DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
   END IF

   IF cl_null(g_master.b_comb)  THEN LET g_master.b_comb = '1' END IF
   IF cl_null(g_master.debz002) THEN LET g_master.debz002 = g_today END IF
   DISPLAY BY NAME g_master.b_comb,g_master.debz002

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp136_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQL可用的数据集
# Date & Author..: 2015/04/20 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp136_get_ooef001_wc(p_wc)
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
# Descriptions...: 產生日結單據
# Memo...........:
# Usage..........: CALL axrp136_get_ar()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2015/04/20 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp136_get_ar()
   DEFINE l_xrca          type_xrca
   DEFINE l_xrcb          type_xrcb
   DEFINE l_xrde          type_xrde
   DEFINE l_debz          type_debz
   DEFINE l_rtja          type_rtja   #130726-00001#95 Add
   DEFINE l_deaf          type_deaf   #130726-00001#95 Add
   DEFINE l_debz_site     DYNAMIC ARRAY OF RECORD
             debzsite     LIKE debz_t.debzsite
                          END RECORD
   DEFINE l_sql           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_tot_success   LIKE type_t.num5
   DEFINE l_ac            LIKE type_t.num5
   DEFINE l_glaa001       LIKE glaa_t.glaa001
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glaa016       LIKE glaa_t.glaa016
   DEFINE l_glaa020       LIKE glaa_t.glaa020
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_xrcd009       LIKE xrcd_t.xrcd009
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_glaa121       LIKE glaa_t.glaa121
   DEFINE l_xrcadocno     LIKE xrca_t.xrcadocno
   DEFINE l_sfin2017      LIKE xrca_t.xrca007
   DEFINE l_dfin0030      LIKE type_t.chr1
   DEFINE l_dfin00301     LIKE type_t.chr1
   DEFINE l_xrca035       LIKE xrca_t.xrca035
   DEFINE l_xrca036       LIKE xrca_t.xrca036
   DEFINE l_imaa003       LIKE imaa_t.imaa003
   DEFINE l_ooeg004       LIKE ooeg_t.ooeg004
   DEFINE l_imaal003      LIKE imaal_t.imaal003
   DEFINE l_imaal004      LIKE imaal_t.imaal004
   DEFINE l_glab005       LIKE glab_t.glab005
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_oodbl004      LIKE oodbl_t.oodbl004
   DEFINE l_oodb011       LIKE oodb_t.oodb011
   DEFINE l_pcab002       LIKE pcab_t.pcab002
   DEFINE l_pcab005       LIKE pcab_t.pcab005
   DEFINE l_deag004       LIKE deag_t.deag004
   DEFINE l_rtjf030       LIKE rtjf_t.rtjf030
   DEFINE l_pcab003       LIKE pcab_t.pcab003
   DEFINE l_xrcbseq       LIKE xrcb_t.xrcbseq
   DEFINE l_xrcb019       LIKE xrcb_t.xrcb019
   DEFINE l_xrdeseq       LIKE xrde_t.xrdeseq
   DEFINE l_xrcb021       LIKE xrcb_t.xrcb021
   DEFINE l_glab002       LIKE glab_t.glab002
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_ooef108       LIKE ooef_t.ooef108
   DEFINE l_pmab105       LIKE pmab_t.pmab105
   DEFINE l_order         LIKE type_t.chr200      #130726-00001#95 Add
   DEFINE l_pmab084       LIKE pmab_t.pmab084     #130726-00001#95 Add
   DEFINE l_sfin2018      LIKE xrca_t.xrca011     #130726-00001#95 Add
   DEFINE l_sfin2021      LIKE type_t.chr1
   DEFINE l_start_no_14   LIKE xrca_t.xrcadocno   #130726-00001#95 Add
   DEFINE l_end_no_14     LIKE xrca_t.xrcadocno   #130726-00001#95 Add
   DEFINE l_start_no_141  LIKE xrca_t.xrcadocno   #130726-00001#95 Add
   DEFINE l_end_no_141    LIKE xrca_t.xrcadocno   #130726-00001#95 Add
   #2015/06/11--add--str--
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002
   DEFINE l_rtax001       LIKE rtax_t.rtax001
   DEFINE l_rtax003       LIKE rtax_t.rtax003
   DEFINE l_rtax004       LIKE rtax_t.rtax004
   DEFINE l_debz012       LIKE debz_t.debz012
   DEFINE l_deby004       LIKE deby_t.deby004
   DEFINE l_rtjf003       LIKE rtjf_t.rtjf003
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_rtja053       LIKE rtja_t.rtja053
   DEFINE l_glaa023       LIKE glaa_t.glaa023   #1:主账套 2:第一辅账 3:第二辅账
   #160509-00004#9--add--str--lujh
   DEFINE l_deaf026       LIKE deaf_t.deaf026 
   DEFINE l_ooef017       LIKE ooef_t.ooef017 
   DEFINE l_ld            LIKE glaa_t.glaald
   DEFINE l_docno         LIKE xrca_t.xrcadocno
   DEFINE l_xrcbld_t      LIKE xrcb_t.xrcbld
   DEFINE l_xrdeld_t      LIKE xrde_t.xrdeld
   DEFINE l_xedesite_t    LIKE xrde_t.xrdesite
   DEFINE l_ooie034       LIKE ooie_t.ooie034
   DEFINE l_xrcb105       LIKE xrcb_t.xrcb105
   DEFINE l_xrcb115       LIKE xrcb_t.xrcb115
   DEFINE l_xrcb105_max   LIKE xrcb_t.xrcb105
   DEFINE l_xrcbseq_max   LIKE xrcb_t.xrcbseq
   #160509-00004#9--add--end--lujh
   #161128-00061#3-----modify--begin----------
   #DEFINE l_glaa          RECORD LIKE glaa_t.*
   #DEFINE l_xrca_t        RECORD LIKE xrca_t.*
   #DEFINE l_xrcb_t        RECORD LIKE xrcb_t.*
   #DEFINE l_xrcc_t        RECORD LIKE xrcc_t.*
   #DEFINE l_xrde_t        RECORD LIKE xrde_t.*   
    DEFINE l_glaa RECORD  #帳套資料檔
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

   DEFINE l_xrcb_t RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
   DEFINE l_xrcc_t RECORD  #多帳期明細
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
   DEFINE l_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD

   #161128-00061#3-----modify--end----------   
   #160509-00004#9--add--end--lujh

  #STEP1 在AR端判断是否已经产生日结资料
  #STEP2 取得日结日的所有营运据点-->根据营运据点拆单
  #STEP3 检查营业员缴款:销售整合收款明细(rtjf_t)和门店收银缴款(deaf)比对是否营业员全部缴款 --> 只有赊销且金额为0的营业员不做缴款否检查
  #  产生axrt350资料
  #STEP4 根据营运据点拆单产生应收单头资料
  #STEP5 取得当天debz、deby的总金额 判断是否需要做抹零处理
  #STEP6 根据debz(合计)资料产生账款明细 管理品类为93、94时取销售额其他取应收金额
  #STEP7 若销售折让金额不等于0且管理品类为93、94将折让金额写入差异明细(29)
  #STEP8 根据adt402(deaf_t-->未考虑赊销)和rtjf_t(仅赊销部分)的资料产生直接冲账部分
  #      1.deaf006金额、rtjf003(赊销)金额 写入直接收款
  #      2.deaf009为1、2、3、6、7则有长短款写入直接收款(1、3、7为短款)
  #      3.deaf020<>0存在其他金额,写入直接收款,根据金额正负判断19或29
  #      4.deaf015<>0为串币,串币金额写入直接收款
  #      5.回写deaf011(财务处理否) ---->只有一个财务判断栏位
  #  产生axrt370资料
  #STEP9 把日结日没有产生赊销的单据产生至赊销(这里要增加账套判断)  --> 放到axrp146處理
  #STEP10回写debz deby财务立帐金额
  #STEP11从adet402中抓取门店与单身代收银据点的对应关系,插入到临时表中
  #STEP12经营方式为租赁时改抓rtjf,按款别拆分插入xrcb(xrcb单身增加款别字段)
  #STEP13产生代收银据点的账务

   DELETE FROM axrp136_tmp      #160509-00004#9 add lujh  #STEP11

   CALL axrp136_def_curs()
   
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002

   INITIALIZE l_xrca TO NULL
   INITIALIZE l_debz TO NULL

   LET l_flag = 'N'

   SELECT glaa001,glaa003,glaa016,glaa020,glaa024,glaacomp,glaa121
     INTO l_glaa001,l_glaa003,l_glaa016,l_glaa020,l_glaa024,l_glaacomp,l_glaa121
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald

   LET l_glaa023 = 0
   SELECT CASE WHEN glaa014 = 'Y' THEN '0' ELSE glaa023 END + 1 INTO l_glaa023
     FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_master.xrcald

   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2017') RETURNING l_sfin2017
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2018') RETURNING l_sfin2018
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2021') RETURNING l_sfin2021
   CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
   CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.l_xrcadocno,'D-FIN-0030') RETURNING l_dfin00301

   #STEP1 ---(S)---
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocdt = g_master.debz002
      AND xrcald = g_master.xrcald
      AND xrcasite = g_master.xrcasite
      AND xrcastus <> 'X'
      AND xrca001 = '14'
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axr-00362'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   #STEP1 ---(E)---

   #STEP2 ---(S)---
   LET l_ac = 1
   FOREACH axrp136_site_curs INTO l_debz_site[l_ac].debzsite
      IF cl_null(l_debz_site[l_ac].debzsite) THEN CONTINUE FOREACH END IF
      
      #160509-00004#40--mark--str--lujh
      #160509-00004#9--add--str--lujh
      #STEP11 ---(S)---
      #FOREACH axrp136_deaf026_curs USING l_debz_site[l_ac].debzsite INTO l_deaf026,l_ooef017        
      #   IF l_ooef017 <> g_comp THEN 
      #      CALL axrp136_01(l_deaf026) RETURNING l_ld,l_docno 
      #      INSERT INTO axrp136_tmp VALUES(l_debz_site[l_ac].debzsite,l_deaf026,l_ld,l_docno)
      #   END IF
      #END FOREACH
      #STEP11 ---(E)---
      #160509-00004#9--add--end--lujh
      #160509-00004#40--mark--end--lujh
      
      LET l_ac = l_ac + 1
   END FOREACH
   CALL l_debz_site.deleteElement(l_ac)
   IF l_debz_site.getLength() < 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   #STEP2 ---(E)---

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   LET l_success = TRUE

   #STEP3 ---(S)---
   FOR l_ac = 1 TO l_debz_site.getLength()
      FOREACH axrp136_rtjf030_curs USING l_debz_site[l_ac].debzsite,l_debz_site[l_ac].debzsite INTO l_rtjf030,l_deag004
         IF cl_null(l_deag004) THEN

            #只有赊销且金额为0的营业员不做缴款否检查
            LET l_count = 0
            SELECT COUNT(DISTINCT rtjf001) INTO l_count FROM rtja_t,rtjf_t
             WHERE rtjaent   = rtjfent
               AND rtjadocno = rtjfdocno
               AND rtjaent = g_enterprise
               AND rtjadocdt = g_master.debz002
               AND rtjasite  = l_debz_site[l_ac].debzsite
               AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = xrcbent
                                  AND xrcadocno = xrcbdocno AND xrcald = xrcbld   
                                  AND xrcastus <> 'X' AND xrcb002 = rtjadocno)    
               AND rtjastus = 'S'
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count < 2 THEN
               LET l_count = 0
               SELECT COUNT(DISTINCT rtjf001) INTO l_count FROM rtja_t,rtjf_t
                WHERE rtjaent   = rtjfent
                  AND rtjadocno = rtjfdocno
                  AND rtjaent = g_enterprise
                  AND rtjadocdt = g_master.debz002
                  AND rtjasite  = l_debz_site[l_ac].debzsite
                  AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = xrcbent
                                     AND xrcadocno = xrcbdocno AND xrcald = xrcbld   
                                     AND xrcastus <> 'X' AND xrcb002 = rtjadocno)    
                  AND rtjastus = 'S'
                  AND rtjf001 = '91'
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 1 THEN
                  CONTINUE FOREACH
               END IF
            END IF

            SELECT pcab003 INTO l_pcab003 FROM pcab_t WHERE pcabent = g_enterprise
               AND pcab001 = l_rtjf030
            LET l_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_rtjf030
            LET g_errparam.code   = 'axr-00344'
            LET g_errparam.popup  = TRUE
            LET g_errparam.replace[1] = l_pcab003
            CALL cl_err()
         END IF
      END FOREACH

   END FOR
   IF NOT l_success THEN
      CALL cl_err_collect_show()
      RETURN
   END IF
   #2015/06/16 Add
   #STEP3 ---(E)---

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   LET l_tot_success = TRUE
   CALL s_transaction_begin()

   FOR l_ac = 1 TO l_debz_site.getLength()
      #STEP4 ---(S)---
      SELECT ooef108 INTO l_ooef108 FROM ooef_t WHERE ooefent = g_enterprise
         AND ooef001 = l_debz_site[l_ac].debzsite
      SELECT pmab105 INTO l_pmab105 FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = l_glaacomp AND pmab001 = l_ooef108

      IF NOT cl_null(l_pmab105) THEN
         LET l_sfin2017 = l_pmab105
      END IF

      SELECT glab005 INTO l_xrca035 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = l_sfin2017       # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_01'

      SELECT glab005 INTO l_xrca036 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = l_sfin2017       # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_21'

      CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.debz002,'axrt350')
         RETURNING l_success,l_xrcadocno
      IF NOT l_success THEN
         LET l_tot_success = l_success
      END IF

     #150417-00007#29 Add  ---(S)---
      IF cl_null(l_start_no_14) THEN LET l_start_no_14 = l_xrcadocno END IF
      LET l_end_no_14 = l_xrcadocno
     #150417-00007#29 Add  ---(E)---

      LET l_xrca.xrcaent = g_enterprise
      LET l_xrca.xrcastus = 'N'
      LET l_xrca.xrcacomp = l_glaacomp
      LET l_xrca.xrcald = g_master.xrcald
      LET l_xrca.xrcadocno = l_xrcadocno
      LET l_xrca.xrcadocdt = g_master.debz002
      LET l_xrca.xrcasite = g_master.xrcasite
      LET l_xrca.xrca001 = '14'
      LET l_xrca.xrca003 = g_user
      LET l_xrca.xrca004 = l_ooef108
      LET l_xrca.xrca005 = l_ooef108
      LET l_xrca.xrca006 = ''
      LET l_xrca.xrca007 = l_sfin2017
      LET l_xrca.xrca008 = ''
      LET l_xrca.xrca009 = g_master.debz002
      LET l_xrca.xrca010 = g_master.debz002
      LET l_xrca.xrca011 = ''   #由單身第一筆回寫
      LET l_xrca.xrca012 = 0    #由單身第一筆回寫
      LET l_xrca.xrca013 = ''   #由單身第一筆回寫
      LET l_xrca.xrca014 = g_user
      LET l_xrca.xrca015 = g_dept
      LET l_xrca.xrca016 = '13'
      LET l_xrca.xrca017 = '0'
      LET l_xrca.xrca018 = ''
      LET l_xrca.xrca019 = ''
      LET l_xrca.xrca020 = ''
      LET l_xrca.xrca021 = 'N'
      LET l_xrca.xrca022 = ''
      LET l_xrca.xrca023 = ''
      LET l_xrca.xrca024 = ''
      LET l_xrca.xrca025 = ''
      LET l_xrca.xrca026 = ''
      LET l_xrca.xrca028 = ''
      LET l_xrca.xrca029 = 1
      LET l_xrca.xrca030 = 0
      LET l_xrca.xrca031 = 0
      LET l_xrca.xrca032 = 0
      LET l_xrca.xrca033 = ''
      LET l_xrca.xrca034 = ''
      LET l_xrca.xrca035 = l_xrca035
      LET l_xrca.xrca036 = l_xrca036
      LET l_xrca.xrca037 = 'Y'   #需要再看
      LET l_xrca.xrca038 = ''
      LET l_xrca.xrca039 = 0
      LET l_xrca.xrca040 = 'N'
      LET l_xrca.xrca041 = ''
      LET l_xrca.xrca042 = ''
      LET l_xrca.xrca043 = ''
      LET l_xrca.xrca044 = 0
      LET l_xrca.xrca045 = ''
      LET l_xrca.xrca046 = 'N'
      LET l_xrca.xrca047 = ''
      LET l_xrca.xrca048 = ''
      LET l_xrca.xrca049 = ''
      LET l_xrca.xrca050 = 0
      LET l_xrca.xrca051 = ''
      LET l_xrca.xrca052 = 0
      LET l_xrca.xrca053 = ''
      LET l_xrca.xrca054 = ''
      LET l_xrca.xrca055 = ''
      LET l_xrca.xrca056 = ''
      LET l_xrca.xrca057 = ''
      LET l_xrca.xrca058 = ''
      LET l_xrca.xrca059 = ''
      LET l_xrca.xrca060 = ''
      LET l_xrca.xrca061 = ''
      LET l_xrca.xrca062 = ''
      LET l_xrca.xrca063 = ''
      LET l_xrca.xrca064 = 0
      LET l_xrca.xrca065 = ''
      LET l_xrca.xrca066 = ''
      LET l_xrca.xrca100 = l_glaa001
      LET l_xrca.xrca101 = 1
      LET l_xrca.xrca103 = 0
      LET l_xrca.xrca104 = 0
      LET l_xrca.xrca106 = 0
      LET l_xrca.xrca107 = 0
      LET l_xrca.xrca108 = 0
      LET l_xrca.xrca113 = 0
      LET l_xrca.xrca114 = 0
      LET l_xrca.xrca116 = 0
      LET l_xrca.xrca117 = 0
      LET l_xrca.xrca118 = 0
      LET l_xrca.xrca120 = l_glaa016
      LET l_xrca.xrca121 = 0
      LET l_xrca.xrca123 = 0
      LET l_xrca.xrca124 = 0
      LET l_xrca.xrca126 = 0
      LET l_xrca.xrca127 = 0
      LET l_xrca.xrca128 = 0
      LET l_xrca.xrca130 = l_glaa020
      LET l_xrca.xrca131 = 0
      LET l_xrca.xrca133 = 0
      LET l_xrca.xrca134 = 0
      LET l_xrca.xrca136 = 0
      LET l_xrca.xrca137 = 0
      LET l_xrca.xrca138 = 0
      LET l_xrca.xrcaownid = g_user
      LET l_xrca.xrcaowndp = g_dept
      LET l_xrca.xrcacrtid = g_user
      LET l_xrca.xrcacrtdp = g_dept 
      LET l_xrca.xrcacrtdt = cl_get_current()
      LET l_xrca.xrcamodid = g_user
      LET l_xrca.xrcamoddt = cl_get_current()
      LET l_xrca.xrcacnfid = ''
      LET l_xrca.xrcacnfdt = ''
      LET l_xrca.xrcapstid = ''
      LET l_xrca.xrcapstdt = ''

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
                  VALUES(l_xrca.xrcaent,l_xrca.xrcastus,l_xrca.xrcacomp,l_xrca.xrcald,l_xrca.xrcadocno,l_xrca.xrcadocdt,l_xrca.xrcasite,
                         l_xrca.xrca001,l_xrca.xrca003,l_xrca.xrca004,l_xrca.xrca005,l_xrca.xrca006,l_xrca.xrca007,
                         l_xrca.xrca008,l_xrca.xrca009,l_xrca.xrca010,l_xrca.xrca011,l_xrca.xrca012,l_xrca.xrca013,
                         l_xrca.xrca014,l_xrca.xrca015,l_xrca.xrca016,l_xrca.xrca017,l_xrca.xrca018,l_xrca.xrca019,
                         l_xrca.xrca020,l_xrca.xrca021,l_xrca.xrca022,l_xrca.xrca023,l_xrca.xrca024,l_xrca.xrca025,
                         l_xrca.xrca026,l_xrca.xrca028,l_xrca.xrca029,l_xrca.xrca030,l_xrca.xrca031,l_xrca.xrca032,
                         l_xrca.xrca033,l_xrca.xrca034,l_xrca.xrca035,l_xrca.xrca036,l_xrca.xrca037,l_xrca.xrca038,
                         l_xrca.xrca039,l_xrca.xrca040,l_xrca.xrca041,l_xrca.xrca042,l_xrca.xrca043,l_xrca.xrca044,
                         l_xrca.xrca045,l_xrca.xrca046,l_xrca.xrca047,l_xrca.xrca048,l_xrca.xrca049,l_xrca.xrca050,
                         l_xrca.xrca051,l_xrca.xrca052,l_xrca.xrca053,l_xrca.xrca054,l_xrca.xrca055,l_xrca.xrca056,
                         l_xrca.xrca057,l_xrca.xrca058,l_xrca.xrca059,l_xrca.xrca060,l_xrca.xrca061,l_xrca.xrca062,
                         l_xrca.xrca063,l_xrca.xrca064,l_xrca.xrca065,l_xrca.xrca066,l_xrca.xrca100,l_xrca.xrca101,
                         l_xrca.xrca103,l_xrca.xrca104,l_xrca.xrca106,l_xrca.xrca107,l_xrca.xrca108,l_xrca.xrca113,
                         l_xrca.xrca114,l_xrca.xrca116,l_xrca.xrca117,l_xrca.xrca118,l_xrca.xrca120,l_xrca.xrca121,
                         l_xrca.xrca123,l_xrca.xrca124,l_xrca.xrca126,l_xrca.xrca127,l_xrca.xrca128,l_xrca.xrca130,
                         l_xrca.xrca131,l_xrca.xrca133,l_xrca.xrca134,l_xrca.xrca136,l_xrca.xrca137,l_xrca.xrca138,
                         l_xrca.xrcaownid,l_xrca.xrcaowndp,l_xrca.xrcacrtid,l_xrca.xrcacrtdp,
                         l_xrca.xrcacrtdt,l_xrca.xrcamodid,l_xrca.xrcamoddt,l_xrca.xrcacnfid,
                         l_xrca.xrcacnfdt,l_xrca.xrcapstid,l_xrca.xrcapstdt)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xrca.xrcadocno
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_tot_success = FALSE
      END IF

      LET l_xrcbseq = 0
      #STEP4 ---(E)---

      #STEP5 ---(S)---
      #2015/07/01 BY 01727 增加抹零的处理
      EXECUTE axrp136_diff_debz_prep USING l_debz_site[l_ac].debzsite INTO l_debz012
      EXECUTE axrp136_diff_deby_prep USING l_debz_site[l_ac].debzsite INTO l_deby004

      LET l_debz012 = l_debz012 - l_deby004

      #160509-00004#9--mark--str--lujh
      #LET l_rtax001=l_debz.debz007
      #WHILE TRUE
      #   SELECT rtax003,rtax004 INTO l_rtax003,l_rtax004 FROM rtax_t
      #    WHERE rtaxent=g_enterprise AND rtax001=l_rtax001
      #   IF l_rtax004 = l_ooaa002 THEN
      #      LET l_xrcb.xrcb012 = l_rtax001
      #      EXIT WHILE
      #   ELSE
      #      LET l_rtax001 = l_rtax003
      #   END IF
      #   IF l_rtax004 < l_ooaa002 THEN
      #      EXIT WHILE
      #   END IF
      #END WHILE
      #160509-00004#9--mark--end--lujh
      
      #160509-00004#9--add--str--lujh
      SELECT rtaw001 INTO l_xrcb.xrcb012
        FROM rtaw_t
       WHERE rtawent = g_enterprise
         AND rtaw002 = l_debz.debz007
         AND rtaw003 = l_ooaa002
      #160509-00004#9--add--end--lujh

      IF l_debz012 > 0 THEN
         INITIALIZE l_xrcb TO NULL

         LET l_xrcb.xrcbent   = l_xrca.xrcaent
         LET l_xrcb.xrcbld    = l_xrca.xrcald
         LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
         LET l_xrcb.xrcbseq   = l_xrcbseq + 1
         LET l_xrcb.xrcbsite  = l_xrca.xrcasite
         LET l_xrcb.xrcborga  = l_xrca.xrcasite
         LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
         IF l_debz012 > 0 THEN
            LET l_xrcb.xrcb001   = '29'
            LET l_xrcb.xrcb022   = -1
         ELSE
            LET l_xrcb.xrcb001   = '19'
            LET l_xrcb.xrcb022   = 1
            LET l_debz012 = l_debz012 * -1
         END IF
         LET l_xrcb.xrcb002   = ''
         LET l_xrcb.xrcb003   = ''
         LET l_xrcb.xrcb004   = ''
         LET l_xrcb.xrcb005   = ''
         LET l_xrcb.xrcb006   = ''
         LET l_xrcb.xrcb007   = 1
         LET l_xrcb.xrcb008   = ''
         LET l_xrcb.xrcb009   = ''
         LET l_xrcb.xrcb010   = ''
         LET l_xrcb.xrcb011   = ''
         LET l_xrcb.xrcb012   = ''
         LET l_xrcb.xrcb013   = ''
         LET l_xrcb.xrcb014   = ''
         LET l_xrcb.xrcb015   = ''
         LET l_xrcb.xrcb016   = ''
         LET l_xrcb.xrcb017   = ''
         LET l_xrcb.xrcb018   = ''
         LET l_xrcb.xrcb019   = ''
         LET l_xrcb.xrcb020   = ''
        #根據品類取得科目
         SELECT glab005 INTO l_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
            AND glabld  = l_xrcb.xrcbld
            AND glab001 = '13'
            AND glab002 = '6736'
            AND glab003 = '9'
         LET l_xrcb.xrcb023   = 'N'
         LET l_xrcb.xrcb024   = ''
         LET l_xrcb.xrcb025   = ''
         LET l_xrcb.xrcb026   = ''
         LET l_xrcb.xrcb027   = ''
         LET l_xrcb.xrcb028   = ''
         LET l_xrcb.xrcb029   = l_xrca.xrca035
         LET l_xrcb.xrcb030   = ''
         LET l_xrcb.xrcb031   = ''
         LET l_xrcb.xrcb032   = ''
         LET l_xrcb.xrcb033   = ''
         LET l_xrcb.xrcb034   = ''
         LET l_xrcb.xrcb035   = ''
         LET l_xrcb.xrcb036   = ''
         LET l_xrcb.xrcb037   = ''
         LET l_xrcb.xrcb038   = ''
         LET l_xrcb.xrcb039   = ''
         LET l_xrcb.xrcb040   = ''
         LET l_xrcb.xrcb041   = ''
         LET l_xrcb.xrcb042   = ''
         LET l_xrcb.xrcb043   = ''
         LET l_xrcb.xrcb044   = ''
         LET l_xrcb.xrcb045   = ''
         LET l_xrcb.xrcb046   = ''
         LET l_xrcb.xrcb047   = ''
         LET l_xrcb.xrcb048   = ''
         LET l_xrcb.xrcb049   = ''
         LET l_xrcb.xrcb050   = ''
         LET l_xrcb.xrcb051   = ''
         LET l_xrcb.xrcb100   = l_xrca.xrca100
         LET l_xrcb.xrcb101   = l_debz012
         LET l_xrcb.xrcb102   = l_xrca.xrca101
         LET l_xrcb.xrcb103   = l_debz012
         LET l_xrcb.xrcb104   = 0
         LET l_xrcb.xrcb105   = l_debz012
         LET l_xrcb.xrcb106   = 0
         LET l_xrcb.xrcb111   = l_debz012
         LET l_xrcb.xrcb113   = l_debz012
         LET l_xrcb.xrcb114   = 0
         LET l_xrcb.xrcb115   = l_debz012
         LET l_xrcb.xrcb116   = 0
         LET l_xrcb.xrcb117   = 0
         LET l_xrcb.xrcb118   = 0
         LET l_xrcb.xrcb119   = 0
         LET l_xrcb.xrcb123   = l_debz012
         LET l_xrcb.xrcb124   = 0
         LET l_xrcb.xrcb125   = l_debz012
         LET l_xrcb.xrcb133   = l_debz012
         LET l_xrcb.xrcb134   = 0
         LET l_xrcb.xrcb135   = l_debz012
         #其他本位幣留下接口，暫不處理
         LET l_xrcb.xrcb121   = 0
         LET l_xrcb.xrcb126   = 0
         LET l_xrcb.xrcb131   = 0
         LET l_xrcb.xrcb136   = 0

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
                            xrcb133,xrcb134,xrcb135,xrcb136)
                     VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                            l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                            l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                            l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                            l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                            l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                            l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                            l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                            l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                            l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                            l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                            l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                            l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                            l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)

         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         END IF
         LET l_xrcbseq = l_xrcbseq + 1
      END IF

      #产生溢收
      LET l_deby004 = 0
      EXECUTE axrp136_other_deby_prep USING l_debz_site[l_ac].debzsite INTO l_deby004
      IF cl_null(l_deby004) THEN lET l_deby004 = 0 END IF

      IF l_deby004 > 0 THEN
         INITIALIZE l_xrcb TO NULL

         LET l_xrcb.xrcbent   = l_xrca.xrcaent
         LET l_xrcb.xrcbld    = l_xrca.xrcald
         LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
         LET l_xrcb.xrcbseq   = l_xrcbseq + 1
         LET l_xrcb.xrcbsite  = l_xrca.xrcasite
         LET l_xrcb.xrcborga  = l_xrca.xrcasite
         LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
         LET l_xrcb.xrcb001   = '19'
         LET l_xrcb.xrcb022   = 1
         LET l_xrcb.xrcb002   = ''
         LET l_xrcb.xrcb003   = ''
         LET l_xrcb.xrcb004   = ''
         LET l_xrcb.xrcb005   = ''
         LET l_xrcb.xrcb006   = ''
         LET l_xrcb.xrcb007   = 1
         LET l_xrcb.xrcb008   = ''
         LET l_xrcb.xrcb009   = ''
         LET l_xrcb.xrcb010   = ''
         LET l_xrcb.xrcb011   = ''
         LET l_xrcb.xrcb012   = ''
         LET l_xrcb.xrcb013   = ''
         LET l_xrcb.xrcb014   = ''
         LET l_xrcb.xrcb015   = ''
         LET l_xrcb.xrcb016   = ''
         LET l_xrcb.xrcb017   = ''
         LET l_xrcb.xrcb018   = ''
         LET l_xrcb.xrcb019   = ''
         LET l_xrcb.xrcb020   = ''
        #根據品類取得科目
         SELECT glab005 INTO l_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
            AND glabld  = l_xrcb.xrcbld
            AND glab001 = '13'
            AND glab002 = '6736'
            AND glab003 = '11'
         LET l_xrcb.xrcb023   = 'N'
         LET l_xrcb.xrcb024   = ''
         LET l_xrcb.xrcb025   = ''
         LET l_xrcb.xrcb026   = ''
         LET l_xrcb.xrcb027   = ''
         LET l_xrcb.xrcb028   = ''
         LET l_xrcb.xrcb029   = l_xrca.xrca035
         LET l_xrcb.xrcb030   = ''
         LET l_xrcb.xrcb031   = ''
         LET l_xrcb.xrcb032   = ''
         LET l_xrcb.xrcb033   = ''
         LET l_xrcb.xrcb034   = ''
         LET l_xrcb.xrcb035   = ''
         LET l_xrcb.xrcb036   = ''
         LET l_xrcb.xrcb037   = ''
         LET l_xrcb.xrcb038   = ''
         LET l_xrcb.xrcb039   = ''
         LET l_xrcb.xrcb040   = ''
         LET l_xrcb.xrcb041   = ''
         LET l_xrcb.xrcb042   = ''
         LET l_xrcb.xrcb043   = ''
         LET l_xrcb.xrcb044   = ''
         LET l_xrcb.xrcb045   = ''
         LET l_xrcb.xrcb046   = ''
         LET l_xrcb.xrcb047   = ''
         LET l_xrcb.xrcb048   = ''
         LET l_xrcb.xrcb049   = ''
         LET l_xrcb.xrcb050   = ''
         LET l_xrcb.xrcb051   = ''
         LET l_xrcb.xrcb100   = l_xrca.xrca100
         LET l_xrcb.xrcb101   = l_deby004
         LET l_xrcb.xrcb102   = l_xrca.xrca101
         LET l_xrcb.xrcb103   = l_deby004
         LET l_xrcb.xrcb104   = 0
         LET l_xrcb.xrcb105   = l_deby004
         LET l_xrcb.xrcb106   = 0
         LET l_xrcb.xrcb111   = l_deby004
         LET l_xrcb.xrcb113   = l_deby004
         LET l_xrcb.xrcb114   = 0
         LET l_xrcb.xrcb115   = l_deby004
         LET l_xrcb.xrcb116   = 0
         LET l_xrcb.xrcb117   = 0
         LET l_xrcb.xrcb118   = 0
         LET l_xrcb.xrcb119   = 0
         LET l_xrcb.xrcb123   = l_deby004
         LET l_xrcb.xrcb124   = 0
         LET l_xrcb.xrcb125   = l_deby004
         LET l_xrcb.xrcb133   = l_deby004
         LET l_xrcb.xrcb134   = 0
         LET l_xrcb.xrcb135   = l_deby004
         #其他本位幣留下接口，暫不處理
         LET l_xrcb.xrcb121   = 0
         LET l_xrcb.xrcb126   = 0
         LET l_xrcb.xrcb131   = 0
         LET l_xrcb.xrcb136   = 0

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
                            xrcb133,xrcb134,xrcb135,xrcb136)
                     VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                            l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                            l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                            l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                            l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                            l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                            l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                            l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                            l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                            l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                            l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                            l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                            l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                            l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)

         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         END IF
         LET l_xrcbseq = l_xrcbseq + 1
      END IF

      #STEP5 ---(E)---

      #STEP6 ---(S)---
      FOREACH axrp136_debz_curs USING l_debz_site[l_ac].debzsite INTO l_debz.*
         #160509-00004#9--add--str--lujh
         #STEP12 ---(S)---
         IF l_debz.debz018 = '5' THEN 
            CALL axrp136_debz018_5(l_debz_site[l_ac].debzsite,l_xrcbseq,l_xrca.xrcadocno,l_glaacomp,l_debz.debz005)   #160509-00004#34 add l_debz.debz005 lujh 
            RETURNING l_tot_success,l_xrcbseq,l_flag
            LET l_xrcb.xrcbseq = l_xrcbseq
            CONTINUE FOREACH
         END IF
         #STEP12 ---(E)---
         #160509-00004#9--add--end--lujh

         INITIALIZE l_xrcb TO NULL

         LET l_imaal003 = NULL
         SELECT rtaxl003 INTO l_imaal003 FROM rtaxl_t
          WHERE rtaxlent = g_enterprise AND rtaxl001 = l_debz.debz007 AND rtaxl002 = g_lang

         LET l_ooeg004 = NULL
         SELECT ooeg004 INTO l_ooeg004 FROM ooeg_t
          WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015

         SELECT imaal003,imaal004 INTO l_imaal003,l_imaal004 FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = l_debz.debz007 AND imaal002 = g_lang

         LET l_xrcb019 = NULL
         SELECT inaa110 INTO l_xrcb019 FROM inaa_t WHERE inaaent = g_enterprise
            AND inaasite = l_debz.debzsite
            AND inaa001  = l_debz.debz014

         LET l_xrcb.xrcbent   = l_xrca.xrcaent
         LET l_xrcb.xrcbld    = l_xrca.xrcald
         LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
         LET l_xrcb.xrcbseq   = l_xrcbseq + 1
         LET l_xrcb.xrcbsite  = l_xrca.xrcasite
         LET l_xrcb.xrcborga  = l_debz.debzsite
         LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
         LET l_xrcb.xrcb001   = '13'
         LET l_xrcb.xrcb002   = ''
         LET l_xrcb.xrcb003   = ''
         LET l_xrcb.xrcb004   = l_debz.debz007
         LET l_xrcb.xrcb005   = l_imaal003
         LET l_xrcb.xrcb006   = ''
         LET l_xrcb.xrcb007   = 1
         LET l_xrcb.xrcb008   = ''
         LET l_xrcb.xrcb009   = ''
         LET l_xrcb.xrcb010   = l_xrca.xrca015
         LET l_xrcb.xrcb011   = l_ooeg004
         #LET l_xrcb.xrcb012   = l_imaa003 #2015/6/11 mark
        #C150819-003 Mod  ---(S)---    因为通过rtaw_t可以直接取到管理品类，这里直接抓取科目,不用在调用递归函数
        ##2015/6/11--add--str--
        ##根据系统参数设置aoos010设定的品类管理层数抓取的产品类别
        #LET l_rtax001=l_debz.debz007
        #WHILE TRUE
        #   SELECT rtax003,rtax004 INTO l_rtax003,l_rtax004 FROM rtax_t
        #    WHERE rtaxent=g_enterprise AND rtax001=l_rtax001
        #   IF l_rtax004 = l_ooaa002 THEN
        #      LET l_xrcb.xrcb012 = l_rtax001
        #      EXIT WHILE
        #   ELSE
        #      LET l_rtax001 = l_rtax003
        #   END IF
        #   IF l_rtax004 < l_ooaa002 THEN
        #      EXIT WHILE
        #   END IF
        #END WHILE
        ##2015/6/11--add--end
         LET l_xrcb.xrcb012 = l_debz.debz007
        #C150819-003 Mod  ---(E)---
         LET l_xrcb.xrcb013   = ''
         LET l_xrcb.xrcb014   = ''
         LET l_xrcb.xrcb015   = ''
         LET l_xrcb.xrcb016   = ''
         LET l_xrcb.xrcb017   = ''
         LET l_xrcb.xrcb018   = l_debz.debz005
         LET l_xrcb.xrcb019   = l_xrcb019
         LET l_xrcb.xrcb020   = l_debz.debz008
        #150417-00007#25 Add  ---(S)---
       #C150819-003 Add  ---(S)---    因为通过rtaw_t可以直接取到管理品类，这里直接抓取科目,不用在调用递归函数
       ##根據品類取得科目
       # CALL axrp136_get_glab005(l_xrcb.xrcbld,l_debz.debz018,l_debz.debz007) RETURNING l_xrcb.xrcb021

        #根據品類取得科目
         SELECT glab005 INTO l_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
            AND glabld  = l_xrcb.xrcbld
            AND glab001 = 'RTAX'
            AND glab002 = l_debz.debz018
            AND glab003 = l_debz.debz007

        #160509-00004#34--mark--str--lujh
        #C150819-003 Add  ---(E)---
        #IF cl_null(l_xrcb.xrcb021) THEN
        #   LET l_xrcb.xrcb021   = l_xrca.xrca035
        #END IF
        #150417-00007#25 Add  ---(E)---
        #160509-00004#34--mark--end--lujh
        #LET l_xrcb.xrcb021   = l_xrca.xrca035   #150417-00007#25 Mark
         LET l_xrcb.xrcb022   = 1
         LET l_xrcb.xrcb023   = 'N'
         LET l_xrcb.xrcb024   = ''
         LET l_xrcb.xrcb025   = ''
         LET l_xrcb.xrcb026   = ''
         LET l_xrcb.xrcb027   = ''   #流通待補欄位
         LET l_xrcb.xrcb028   = ''
         LET l_xrcb.xrcb029   = l_xrca.xrca035
         LET l_xrcb.xrcb030   = ''
         LET l_xrcb.xrcb031   = ''
         LET l_xrcb.xrcb032   = ''
         LET l_xrcb.xrcb033   = l_debz.debz018
         LET l_xrcb.xrcb034   = ''
         LET l_xrcb.xrcb035   = ''
         LET l_xrcb.xrcb036   = ''
         IF l_xrcb.xrcb021 = '2241.03' THEN   #151201-00002#53  天河固定寫法
            LET l_xrcb.xrcb037   = '306061'   #151201-00002#53  天河固定寫法
         ELSE
            LET l_xrcb.xrcb037   = ''
         END IF
         LET l_xrcb.xrcb038   = ''
         LET l_xrcb.xrcb039   = ''
         LET l_xrcb.xrcb040   = ''
         LET l_xrcb.xrcb041   = ''
         LET l_xrcb.xrcb042   = ''
         LET l_xrcb.xrcb043   = ''
         LET l_xrcb.xrcb044   = ''
         LET l_xrcb.xrcb045   = ''
         LET l_xrcb.xrcb046   = ''
         LET l_xrcb.xrcb047   = ''
         LET l_xrcb.xrcb048   = ''
         LET l_xrcb.xrcb049   = ''
         LET l_xrcb.xrcb050   = ''
         LET l_xrcb.xrcb051   = l_xrca.xrca014
         LET l_xrcb.xrcb100   = l_xrca.xrca100

         CALL s_tax_chk(l_glaacomp,l_xrcb.xrcb020)
            RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011
         IF l_debz.debz007 = '93' OR l_debz.debz007 = '94' THEN
            IF l_xrca.xrca013 = 'Y' THEN
               LET l_xrcb.xrcb101   = l_debz.debz010   #20150720 Mod l_debz.debz012 --> l_debz.debz010
            ELSE
               LET l_xrcb.xrcb101   = l_debz.debz010 - l_debz.debz009   #20150720 Mod l_debz.debz012 --> l_debz.debz010
            END IF
         ELSE
            IF l_xrca.xrca013 = 'Y' THEN
               LET l_xrcb.xrcb101   = l_debz.debz012
            ELSE
               LET l_xrcb.xrcb101   = l_debz.debz012 - l_debz.debz009
            END IF
         END IF
         

         CALL s_tax_ins(l_xrca.xrcadocno,l_xrcb.xrcbseq,0,l_glaacomp,
                        l_xrcb.xrcb101 * l_xrcb.xrcb007,l_xrcb.xrcb020,
                        l_xrcb.xrcb007,l_xrcb.xrcb100,l_xrca.xrca101,l_xrca.xrcald,l_xrca.xrca121,l_xrca.xrca131)
            RETURNING l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,
                      l_xrcb.xrcb113,l_xrcb.xrcb114,l_xrcb.xrcb115,
                      l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,
                      l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135
             
         #160509-00004#34--add--str--lujh             
         LET l_xrcb.xrcb103 = l_debz.debz012
         LET l_xrcb.xrcb104 = 0
         LET l_xrcb.xrcb105 = l_debz.debz012
         LET l_xrcb.xrcb113 = l_xrcb.xrcb103
         LET l_xrcb.xrcb114 = l_xrcb.xrcb104
         LET l_xrcb.xrcb115 = l_xrcb.xrcb105
         #160509-00004#34--add--end--lujh
         
         DELETE FROM xrcd_t WHERE xrcdent = g_enterprise AND xrcddocno = l_xrca.xrcadocno AND xrcdseq = l_xrcb.xrcbseq

         IF l_sfin2021 = 'N' THEN
            UPDATE xrcd_t SET xrcd009 = l_xrcb.xrcb021
             WHERE xrcdent = g_enterprise
               AND xrcddocno = l_xrca.xrcadocno
               AND xrcdld = l_xrca.xrcald
               AND xrcdseq = l_xrcb.xrcbseq
         ELSE  
            SELECT glab005 INTO l_xrcd009 FROM glab_t 
             WHERE glabld = g_master.xrcald 
               AND glabent = g_enterprise
               AND glab002 = l_sfin2017       # 帳款類別
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab003 = '8304_29'
            UPDATE xrcd_t SET xrcd009 = l_xrcd009
             WHERE xrcdent = g_enterprise
               AND xrcddocno = l_xrca.xrcadocno
               AND xrcdld = l_xrca.xrcald
               AND xrcdseq = l_xrcb.xrcbseq
         END IF

         LET l_xrcb.xrcb102   = l_xrca.xrca101
         LET l_xrcb.xrcb106   = 0
         LET l_xrcb.xrcb111   = l_debz.debz010 - l_debz.debz009
         LET l_xrcb.xrcb116   = 0
         LET l_xrcb.xrcb117   = 0
         LET l_xrcb.xrcb118   = 0
         LET l_xrcb.xrcb119   = 0
         #其他本位幣留下接口，暫不處理
         LET l_xrcb.xrcb121   = 0
         LET l_xrcb.xrcb126   = 0
         LET l_xrcb.xrcb131   = 0
         LET l_xrcb.xrcb136   = 0

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
                            xrcb133,xrcb134,xrcb135,xrcb136)
                     VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                            l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                            l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                            l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                            l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                            l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                            l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                            l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                            l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                            l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                            l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                            l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                            l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                            l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         ELSE
            LET l_flag = 'Y'
         END IF

         IF l_xrcb.xrcbseq = 1 THEN
            CALL s_tax_chk(l_glaacomp,l_xrcb.xrcb020)
               RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011

            UPDATE xrca_t SET xrca011 = l_xrcb.xrcb020,
                              xrca012 = l_xrca.xrca012,
                              xrca013 = l_xrca.xrca013
             WHERE xrcaent = g_enterprise
               AND xrcadocno = l_xrca.xrcadocno
               AND xrcald    = l_xrca.xrcald
         END IF

         LET l_xrcbseq = l_xrcbseq + 1

         #STEP7 ---(S)---
         #20150720 Add ---(S)---
         IF l_debz.debz011 <> 0 AND (l_rtax001 = '93' OR l_rtax001 = '94') THEN
            INITIALIZE l_xrcb TO NULL

            SELECT glab005 INTO l_xrcb021 FROM glab_t 
             WHERE glabld = g_master.xrcald
               AND glabent = g_enterprise
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab002 = '6736'
               AND glab003 = '10'  #折扣

            LET l_xrcb.xrcbent   = l_xrca.xrcaent
            LET l_xrcb.xrcbld    = l_xrca.xrcald
            LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
            LET l_xrcb.xrcbseq   = l_xrcbseq + 1
            LET l_xrcb.xrcbsite  = l_xrca.xrcasite
            LET l_xrcb.xrcborga  = l_debz.debzsite
            LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
            IF l_debz.debz011 > 0 THEN
               LET l_xrcb.xrcb001   = '29'
               LET l_xrcb.xrcb022   = -1
            ELSE
               LET l_xrcb.xrcb001   = '19'
               LET l_xrcb.xrcb022   = 1
               LET l_debz.debz011 = l_debz.debz011 * -1
            END IF
            LET l_xrcb.xrcb002   = ''
            LET l_xrcb.xrcb003   = ''
            LET l_xrcb.xrcb004   = l_debz.debz007
            LET l_xrcb.xrcb005   = l_imaal003
            LET l_xrcb.xrcb006   = ''
            LET l_xrcb.xrcb007   = 1
            LET l_xrcb.xrcb008   = ''
            LET l_xrcb.xrcb009   = ''
            LET l_xrcb.xrcb010   = l_xrca.xrca015
            LET l_xrcb.xrcb011   = l_ooeg004
            #根据系统参数设置aoos010设定的品类管理层数抓取的产品类别
            #160509-00004#9--mark--str--lujh
            #LET l_rtax001=l_debz.debz007
            #WHILE TRUE
            #   SELECT rtax003,rtax004 INTO l_rtax003,l_rtax004 FROM rtax_t
            #    WHERE rtaxent=g_enterprise AND rtax001=l_rtax001
            #   IF l_rtax004 = l_ooaa002 THEN
            #      LET l_xrcb.xrcb012 = l_rtax001
            #      EXIT WHILE
            #   ELSE
            #      LET l_rtax001 = l_rtax003
            #   END IF
            #   IF l_rtax004 < l_ooaa002 THEN
            #      EXIT WHILE
            #   END IF
            #END WHILE
            #160509-00004#9--mark--end--lujh
            
            #160509-00004#9--add--str--lujh
            SELECT rtaw001 INTO l_xrcb.xrcb012
              FROM rtaw_t
             WHERE rtawent = g_enterprise
               AND rtaw002 = l_debz.debz007
               AND rtaw003 = l_ooaa002
            #160509-00004#9--add--end--lujh
            
            LET l_xrcb.xrcb013   = ''
            LET l_xrcb.xrcb014   = ''
            LET l_xrcb.xrcb015   = ''
            LET l_xrcb.xrcb016   = ''
            LET l_xrcb.xrcb017   = ''
            LET l_xrcb.xrcb018   = l_debz.debz005
            LET l_xrcb.xrcb019   = l_xrcb019
            LET l_xrcb.xrcb020   = l_debz.debz008
            LET l_xrcb.xrcb021   = l_xrcb021
            LET l_xrcb.xrcb023   = 'N'
            LET l_xrcb.xrcb024   = ''
            LET l_xrcb.xrcb025   = ''
            LET l_xrcb.xrcb026   = ''
            LET l_xrcb.xrcb027   = ''   #流通待補欄位
            LET l_xrcb.xrcb028   = ''
            LET l_xrcb.xrcb029   = l_xrca.xrca035
            LET l_xrcb.xrcb030   = ''
            LET l_xrcb.xrcb031   = ''
            LET l_xrcb.xrcb032   = ''
            LET l_xrcb.xrcb033   = l_debz.debz018
            LET l_xrcb.xrcb034   = ''
            LET l_xrcb.xrcb035   = ''
            LET l_xrcb.xrcb036   = ''
            IF l_xrcb.xrcb021 = '2241.03' THEN   #151201-00002#53  天河固定寫法
               LET l_xrcb.xrcb037   = '306061'   #151201-00002#53  天河固定寫法
            ELSE
               LET l_xrcb.xrcb037   = ''
            END IF
            LET l_xrcb.xrcb038   = ''
            LET l_xrcb.xrcb039   = ''
            LET l_xrcb.xrcb040   = ''
            LET l_xrcb.xrcb041   = ''
            LET l_xrcb.xrcb042   = ''
            LET l_xrcb.xrcb043   = ''
            LET l_xrcb.xrcb044   = ''
            LET l_xrcb.xrcb045   = ''
            LET l_xrcb.xrcb046   = ''
            LET l_xrcb.xrcb047   = ''
            LET l_xrcb.xrcb048   = ''
            LET l_xrcb.xrcb049   = ''
            LET l_xrcb.xrcb050   = ''
            LET l_xrcb.xrcb051   = l_xrca.xrca014
            LET l_xrcb.xrcb100   = l_xrca.xrca100
            LET l_xrcb.xrcb101   = l_debz.debz011
            LET l_xrcb.xrcb102   = l_xrca.xrca101
            LET l_xrcb.xrcb103   = l_debz.debz011
            LET l_xrcb.xrcb104   = 0
            LET l_xrcb.xrcb105   = l_debz.debz011
            LET l_xrcb.xrcb106   = 0
            LET l_xrcb.xrcb111   = l_debz.debz011
            LET l_xrcb.xrcb113   = l_debz.debz011
            LET l_xrcb.xrcb114   = 0
            LET l_xrcb.xrcb115   = l_debz.debz011
            LET l_xrcb.xrcb116   = 0
            LET l_xrcb.xrcb117   = 0
            LET l_xrcb.xrcb118   = 0
            LET l_xrcb.xrcb119   = 0
            LET l_xrcb.xrcb123   = l_debz.debz011
            LET l_xrcb.xrcb124   = 0
            LET l_xrcb.xrcb125   = l_debz.debz011
            LET l_xrcb.xrcb133   = l_debz.debz011
            LET l_xrcb.xrcb134   = 0
            LET l_xrcb.xrcb135   = l_debz.debz011
            #其他本位幣留下接口，暫不處理
            LET l_xrcb.xrcb121   = 0
            LET l_xrcb.xrcb126   = 0
            LET l_xrcb.xrcb131   = 0
            LET l_xrcb.xrcb136   = 0

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
                               xrcb133,xrcb134,xrcb135,xrcb136)
                        VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                               l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                               l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                               l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                               l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                               l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                               l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                               l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                               l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                               l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                               l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                               l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                               l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                               l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_tot_success = FALSE
            ELSE
               LET l_flag = 'Y'
            END IF

            LET l_xrcbseq = l_xrcbseq + 1
         END IF
         #20150720 Add ---(E)---
         #STEP7 ---(E)---

      END FOREACH
      #STEP6 ---(E)---

      LET l_xrdeseq = 0

      #處理直接收款与長短款
      LET l_xrcbseq = l_xrcb.xrcbseq
      LET l_xrdeseq = l_xrde.xrdeseq

      #STEP8 ---(S)---
      FOREACH axrp136_deaf_curs USING l_debz_site[l_ac].debzsite,l_debz_site[l_ac].debzsite INTO l_deaf.*

         #處理直接收款  ---(S)---
         INITIALIZE l_xrde TO NULL
         
         #160509-00004#40--add--str--lujh
         IF l_deaf.deaf024 = 'N' AND l_deaf.deaf026 <> l_debz_site[l_ac].debzsite THEN 
            CONTINUE FOREACH
         END IF
         #160509-00004#40--add--end--lujh
         
         #160509-00004#34--mark--str--lujh
         #SELECT glab002,glab009 INTO l_glab002,l_glab005 FROM glab_t WHERE glabent = g_enterprise    #160509-00004#9 change glab007 to glab0009
         #   AND glab001 = '21' AND glab003 = l_deaf.deaf005
         #   AND glabld = l_xrca.xrcald
         #IF cl_null(l_glab005) THEN
         #160509-00004#34--mark--end--lujh
            SELECT glab002,glab005 INTO l_glab002,l_glab005 FROM glab_t WHERE glabent = g_enterprise
               AND glab001 = '21' AND glab003 = l_deaf.deaf005
               AND glabld = l_xrca.xrcald
         #END IF   #160509-00004#34 mark lujh

         LET l_xrde.xrdeent  = l_xrca.xrcaent
         LET l_xrde.xrdecomp = l_xrca.xrcacomp
         LET l_xrde.xrdeld   = l_xrca.xrcald
         LET l_xrde.xrdedocno= l_xrca.xrcadocno
         LET l_xrde.xrdeseq  = l_xrdeseq + 1
         LET l_xrde.xrdesite = l_xrca.xrcasite
         LET l_xrde.xrdeorga = l_deaf.deafsite
         LET l_xrde.xrde001  = 'axrt350'
         LET l_xrde.xrde002  = '10'
         LET l_xrde.xrde003  = ''
         LET l_xrde.xrde004  = ''
         LET l_xrde.xrde006  = l_glab002
         LET l_xrde.xrde007  = l_deaf.deaf005
         LET l_xrde.xrde008  = ''
         LET l_xrde.xrde010  = ''
         LET l_xrde.xrde011  = ''
         LET l_xrde.xrde012  = ''
         LET l_xrde.xrde013  = ''
         LET l_xrde.xrde014  = ''
         LET l_xrde.xrde015  = 'D'
         LET l_xrde.xrde016  = l_glab005
         LET l_xrde.xrde017  = l_xrca.xrca014
         LET l_xrde.xrde018  = ''
         LET l_xrde.xrde019  = ''
         LET l_xrde.xrde020  = ''
         LET l_xrde.xrde022  = ''
         LET l_xrde.xrde023  = ''
         LET l_xrde.xrde028  = '0'
         LET l_xrde.xrde029  = ''
         LET l_xrde.xrde030  = ''
         LET l_xrde.xrde035  = ''
         LET l_xrde.xrde036  = ''
         SELECT COUNT(*) INTO l_count FROM rtjf_t WHERE rtjfdocno = l_deaf.deafdocno AND rtjfent = g_enterprise
            AND rtjf001 = '91'
         IF cl_null(l_count) THEN lET l_count = 0 END IF
         IF l_count > 0 THEN
            SELECT rtja002 INTO l_xrde.xrde038 FROM rtja_t WHERE rtjadocno = l_deaf.deafdocno AND rtjaent = g_enterprise
         ELSE
            LET l_xrde.xrde038  = ''
         END IF
         LET l_xrde.xrde039  = ''
         LET l_xrde.xrde040  = ''
         LET l_xrde.xrde041  = ''
         LET l_xrde.xrde042  = ''
         LET l_xrde.xrde043  = ''
         LET l_xrde.xrde044  = ''
         LET l_xrde.xrde045  = ''
         LET l_xrde.xrde046  = ''
         LET l_xrde.xrde047  = ''
         LET l_xrde.xrde048  = ''
         LET l_xrde.xrde049  = ''
         LET l_xrde.xrde050  = ''
         LET l_xrde.xrde051  = ''
        #151201-00002#53 Add  ---(S)---
         SELECT ooie002 INTO l_xrde.xrde100 FROM ooie_t WHERE ooieent = g_enterprise
            AND ooiesite = l_xrde.xrdecomp
            AND ooie001  = l_deaf.deaf005
         LET l_xrde.xrde109  = l_deaf.deaf006 - l_deaf.deaf023     #160509-00004#34 add l_deaf.deaf023 lujh
         IF NOT cl_null(l_xrde.xrde100) AND l_xrde.xrde100 <> l_glaa001 THEN
            CALL s_aooi160_get_exrate_avg('2',l_xrca.xrcald,l_xrca.xrcadocdt,l_xrde.xrde100,l_glaa001,1,'11')
               RETURNING l_success,g_errno,l_xrde.xrde101
         ELSE
            LET l_xrde.xrde101 = 1
         END IF
         LET l_xrde.xrde119  = l_xrde.xrde109 * l_xrde.xrde101    #160509-00004#34 change l_deaf.deaf006 to l_xrde.xrde109 lujh
        #151201-00002#53 Add  ---(E)---
         #其他本位幣留出接口暫不處理
         LET l_xrde.xrde120  = ''
         LET l_xrde.xrde121  = 0
         LET l_xrde.xrde129  = 0
         LET l_xrde.xrde130  = ''
         LET l_xrde.xrde131  = 0
         LET l_xrde.xrde139  = 0

         INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,
                            xrde001,xrde002,xrde003,xrde004,xrde006,xrde007,xrde008,
                            xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,
                            xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,
                            xrde023,xrde028,xrde029,xrde030,xrde035,xrde036,
                            xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,
                            xrde044,xrde045,xrde046,xrde047,xrde048,xrde049,
                            xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,
                            xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,
                            l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,l_xrde.xrde008,
                            l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,
                            l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,
                            l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,l_xrde.xrde035,l_xrde.xrde036,
                            l_xrde.xrde038,l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,
                            l_xrde.xrde044,l_xrde.xrde045,l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,l_xrde.xrde049,
                            l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,
                            l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139)

         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         ELSE
            LET l_flag = 'Y'
         END IF

         LET l_xrdeseq = l_xrdeseq + 1
         #處理直接收款  ---(E)---

         IF l_deaf.deaf009 = '1' OR l_deaf.deaf009 = '7' THEN
            LET l_deaf.deaf008 = l_deaf.deaf008 * -1
         END IF

         SELECT pcab002,pcab005 INTO l_pcab002,l_pcab005 FROM pcab_t WHERE pcabent = g_enterprise AND pcab001 = l_deag004

         #處理長短款  ---(S)---
         IF l_deaf.deaf009 = '1' OR l_deaf.deaf009 = '2' OR l_deaf.deaf009 = '3' OR l_deaf.deaf009 = '6' OR l_deaf.deaf009 = '7' THEN
            SELECT glab005 INTO l_xrcb021 FROM glab_t 
             WHERE glabld = g_master.xrcald
               AND glabent = g_enterprise
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab002 = '6736'
               AND glab003 = l_deaf.deaf009

            INITIALIZE l_xrcb TO NULL

            LET l_xrcb.xrcbent   = l_xrca.xrcaent
            LET l_xrcb.xrcbld    = l_xrca.xrcald
            LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
            LET l_xrcb.xrcbseq   = l_xrcbseq + 1
            LET l_xrcb.xrcbsite  = l_xrca.xrcasite
            LET l_xrcb.xrcborga  = l_xrca.xrcasite
            LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
           #2015/06/29 Mod  ---(S)---
           #全部放到其他加项
           #1.营业员赔款算其他应收款
           #2.营业员多收营业外收入
           #LET l_xrcb.xrcb001   = '19'
           #LET l_xrcb.xrcb022   = 1
            IF l_deaf.deaf009 = '1' OR l_deaf.deaf009 = '3' OR l_deaf.deaf009 = '7' THEN
               LET l_xrcb.xrcb001   = '29'
               LET l_xrcb.xrcb022   = -1
               IF l_deaf.deaf008 < 0 THEN
                  LET l_deaf.deaf008 = l_deaf.deaf008 * -1
               END IF
            ELSE
               LET l_xrcb.xrcb001   = '19'
               LET l_xrcb.xrcb022   = 1
            END IF
           #2015/06/29 Mod  ---(E)---
            LET l_xrcb.xrcb002   = ''
            LET l_xrcb.xrcb003   = ''
            LET l_xrcb.xrcb004   = ''
            LET l_xrcb.xrcb005   = ''
            LET l_xrcb.xrcb006   = ''
            LET l_xrcb.xrcb007   = 1
            LET l_xrcb.xrcb008   = l_deaf.deafdocno
            LET l_xrcb.xrcb009   = ''
            LET l_xrcb.xrcb010   = l_pcab005
            LET l_xrcb.xrcb011   = l_ooeg004
            LET l_xrcb.xrcb012   = ''
            LET l_xrcb.xrcb013   = ''
            LET l_xrcb.xrcb014   = ''
            LET l_xrcb.xrcb015   = ''
            LET l_xrcb.xrcb016   = ''
            LET l_xrcb.xrcb017   = ''
            LET l_xrcb.xrcb018   = ''
            LET l_xrcb.xrcb019   = ''
            LET l_xrcb.xrcb020   = ''
           #150417-00007#25 Add  ---(S)---
           #根據品類取得科目
            SELECT glab005 INTO l_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
               AND glabld  = l_xrcb.xrcbld
               AND glab001 = '13'
               AND glab002 = '6736'
               AND glab003 = l_deaf.deaf009
            IF cl_null(l_xrcb.xrcb021) THEN
               LET l_xrcb.xrcb021   = l_xrcb021
            END IF
           #150417-00007#25 Add  ---(E)---
           #LET l_xrcb.xrcb021   = l_xrcb021
            LET l_xrcb.xrcb023   = 'N'
            LET l_xrcb.xrcb024   = ''
            LET l_xrcb.xrcb025   = ''
            LET l_xrcb.xrcb026   = ''
            LET l_xrcb.xrcb027   = ''   #流通待補欄位
            LET l_xrcb.xrcb028   = ''
            LET l_xrcb.xrcb029   = l_xrca.xrca035
            LET l_xrcb.xrcb030   = ''
            LET l_xrcb.xrcb031   = ''
            LET l_xrcb.xrcb032   = ''
            LET l_xrcb.xrcb033   = ''
            LET l_xrcb.xrcb034   = ''
            LET l_xrcb.xrcb035   = ''
            LET l_xrcb.xrcb036   = ''
            LET l_xrcb.xrcb037   = ''
            LET l_xrcb.xrcb038   = ''
            LET l_xrcb.xrcb039   = ''
            LET l_xrcb.xrcb040   = ''
            LET l_xrcb.xrcb041   = ''
            LET l_xrcb.xrcb042   = ''
            LET l_xrcb.xrcb043   = ''
            LET l_xrcb.xrcb044   = ''
            LET l_xrcb.xrcb045   = ''
            LET l_xrcb.xrcb046   = ''
            LET l_xrcb.xrcb047   = ''
            LET l_xrcb.xrcb048   = ''
            LET l_xrcb.xrcb049   = ''
            LET l_xrcb.xrcb050   = ''
            LET l_xrcb.xrcb051   = l_pcab002
            LET l_deaf.deaf008 = l_deaf.deaf008 * l_xrde.xrde101
            LET l_xrcb.xrcb100   = l_xrca.xrca100
            LET l_xrcb.xrcb101   = l_deaf.deaf008
            LET l_xrcb.xrcb102   = l_xrca.xrca101
            LET l_xrcb.xrcb103   = l_deaf.deaf008
            LET l_xrcb.xrcb104   = 0
            LET l_xrcb.xrcb105   = l_deaf.deaf008
            LET l_xrcb.xrcb106   = 0
            LET l_xrcb.xrcb111   = l_deaf.deaf008
            LET l_xrcb.xrcb113   = l_deaf.deaf008
            LET l_xrcb.xrcb114   = 0
            LET l_xrcb.xrcb115   = l_deaf.deaf008
            LET l_xrcb.xrcb116   = 0
            LET l_xrcb.xrcb117   = 0
            LET l_xrcb.xrcb118   = 0
            LET l_xrcb.xrcb119   = 0
            LET l_xrcb.xrcb123   = l_deaf.deaf008
            LET l_xrcb.xrcb124   = 0
            LET l_xrcb.xrcb125   = l_deaf.deaf008
            LET l_xrcb.xrcb133   = l_deaf.deaf008
            LET l_xrcb.xrcb134   = 0
            LET l_xrcb.xrcb135   = l_deaf.deaf008
            #其他本位幣留下接口，暫不處理
            LET l_xrcb.xrcb121   = 0
            LET l_xrcb.xrcb126   = 0
            LET l_xrcb.xrcb131   = 0
            LET l_xrcb.xrcb136   = 0

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
                               xrcb133,xrcb134,xrcb135,xrcb136)
                        VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                               l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                               l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                               l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                               l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                               l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                               l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                               l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                               l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                               l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                               l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                               l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                               l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                               l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)

            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_tot_success = FALSE
            END IF
            LET l_xrcbseq = l_xrcbseq + 1

            #160509-00004#9--add--str--lujh
            UPDATE deaf_t SET deaf011 = 'Y'
             WHERE deafent = g_enterprise
               AND deafdocno = l_deaf.deafdocno
               AND deaf005 = l_deaf.deaf005
            #160509-00004#9--add--end--lujh
         END IF
         #處理長短款  ---(E)---

         #處理其他金额 ---(S)---
         IF l_deaf.deaf020 <> 0 THEN

            INITIALIZE l_xrcb TO NULL

            LET l_xrcb.xrcbent   = l_xrca.xrcaent
            LET l_xrcb.xrcbld    = l_xrca.xrcald
            LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
            LET l_xrcb.xrcbseq   = l_xrcbseq + 1
            LET l_xrcb.xrcbsite  = l_xrca.xrcasite
            LET l_xrcb.xrcborga  = l_xrca.xrcasite
            LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
            IF l_deaf.deaf020 > 0 THEN
               LET l_xrcb.xrcb001 = '19'
               LET l_xrcb.xrcb022 = 1
               LET l_xrcb.xrcb021   = '1221.09.03'   #151201-00002#53 天河固定寫法
               LET l_xrcb.xrcb029   = l_xrca.xrca035
            ELSE
               LET l_xrcb.xrcb001 = '29'
               LET l_xrcb.xrcb022 = -1
               LET l_deaf.deaf020 = l_deaf.deaf020 * -1
               LET l_xrcb.xrcb029   = '1221.09.03'   #151201-00002#53 天河固定寫法
               LET l_xrcb.xrcb021   = l_xrca.xrca035
            END IF
               LET l_xrcb.xrcb021   = '1221.09.03'   #151201-00002#53 天河固定寫法
               LET l_xrcb.xrcb029   = l_xrca.xrca035
            LET l_xrcb.xrcb002   = ''
            LET l_xrcb.xrcb003   = ''
            LET l_xrcb.xrcb004   = ''
            LET l_xrcb.xrcb005   = ''
            LET l_xrcb.xrcb006   = ''
            LET l_xrcb.xrcb007   = 1
            LET l_xrcb.xrcb008   = l_deaf.deafdocno
            LET l_xrcb.xrcb009   = ''
            LET l_xrcb.xrcb010   = l_pcab005
            LET l_xrcb.xrcb011   = l_ooeg004
            LET l_xrcb.xrcb012   = ''
            LET l_xrcb.xrcb013   = ''
            LET l_xrcb.xrcb014   = ''
            LET l_xrcb.xrcb015   = ''
            LET l_xrcb.xrcb016   = ''
            LET l_xrcb.xrcb017   = ''
            LET l_xrcb.xrcb018   = ''
            LET l_xrcb.xrcb019   = ''
            LET l_xrcb.xrcb020   = ''
            LET l_xrcb.xrcb023   = 'N'
            LET l_xrcb.xrcb024   = ''
            LET l_xrcb.xrcb025   = ''
            LET l_xrcb.xrcb026   = ''
            LET l_xrcb.xrcb027   = ''   #流通待補欄位
            LET l_xrcb.xrcb028   = ''
            LET l_xrcb.xrcb030   = ''
            LET l_xrcb.xrcb031   = ''
            LET l_xrcb.xrcb032   = ''
            LET l_xrcb.xrcb033   = ''
            LET l_xrcb.xrcb034   = ''
            LET l_xrcb.xrcb035   = ''
            LET l_xrcb.xrcb036   = ''
            LET l_xrcb.xrcb037   = ''
            LET l_xrcb.xrcb038   = ''
            LET l_xrcb.xrcb039   = ''
            LET l_xrcb.xrcb040   = ''
            LET l_xrcb.xrcb041   = ''
            LET l_xrcb.xrcb042   = ''
            LET l_xrcb.xrcb043   = ''
            LET l_xrcb.xrcb044   = ''
            LET l_xrcb.xrcb045   = ''
            LET l_xrcb.xrcb046   = ''
            LET l_xrcb.xrcb047   = ''
            LET l_xrcb.xrcb048   = ''
            LET l_xrcb.xrcb049   = ''
            LET l_xrcb.xrcb050   = ''
            LET l_xrcb.xrcb051   = l_pcab002
            LET l_xrcb.xrcb100   = l_xrca.xrca100
            LET l_xrcb.xrcb101   = l_deaf.deaf008
            LET l_xrcb.xrcb102   = l_xrca.xrca101
            LET l_xrcb.xrcb103   = l_deaf.deaf020
            LET l_xrcb.xrcb104   = 0
            LET l_xrcb.xrcb105   = l_deaf.deaf020
            LET l_xrcb.xrcb106   = 0
            LET l_xrcb.xrcb111   = l_deaf.deaf020
            LET l_xrcb.xrcb113   = l_deaf.deaf020
            LET l_xrcb.xrcb114   = 0
            LET l_xrcb.xrcb115   = l_deaf.deaf020
            LET l_xrcb.xrcb116   = 0
            LET l_xrcb.xrcb117   = 0
            LET l_xrcb.xrcb118   = 0
            LET l_xrcb.xrcb119   = 0
            LET l_xrcb.xrcb123   = l_deaf.deaf020
            LET l_xrcb.xrcb124   = 0
            LET l_xrcb.xrcb125   = l_deaf.deaf020
            LET l_xrcb.xrcb133   = l_deaf.deaf020
            LET l_xrcb.xrcb134   = 0
            LET l_xrcb.xrcb135   = l_deaf.deaf020
            #其他本位幣留下接口，暫不處理
            LET l_xrcb.xrcb121   = 0
            LET l_xrcb.xrcb126   = 0
            LET l_xrcb.xrcb131   = 0
            LET l_xrcb.xrcb136   = 0

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
                               xrcb133,xrcb134,xrcb135,xrcb136)
                        VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                               l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                               l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                               l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                               l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                               l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                               l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                               l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                               l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                               l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                               l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                               l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                               l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                               l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)

            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_tot_success = FALSE
            END IF
            LET l_xrcbseq = l_xrcbseq + 1

            #160509-00004#9--add--str--lujh
            UPDATE deaf_t SET deaf011 = 'Y'
             WHERE deafent = g_enterprise
               AND deafdocno = l_deaf.deafdocno
               AND deaf005 = l_deaf.deaf005
            #160509-00004#9--add--end--lujh
         END IF
         #處理其他金额 ---(S)---
         
         #160509-00004#9--add--str--lujh
         #处理手续费 ---(S)---
         IF l_deaf.deaf023 <> 0 THEN

            INITIALIZE l_xrcb TO NULL

            LET l_xrcb.xrcbent   = l_xrca.xrcaent
            LET l_xrcb.xrcbld    = l_xrca.xrcald
            LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
            LET l_xrcb.xrcbseq   = l_xrcbseq + 1
            LET l_xrcb.xrcbsite  = l_xrca.xrcasite
            LET l_xrcb.xrcborga  = l_xrca.xrcasite
            LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
            LET l_xrcb.xrcb001 = '19'
            LET l_xrcb.xrcb022 = 1
            SELECT glab005 INTO l_xrcb.xrcb021
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = l_xrcb.xrcbld
               AND glab001 = '13'
               AND glab002 = '6736'
               AND glab003 = '14'
            LET l_xrcb.xrcb029   = l_xrcb.xrcb021
            LET l_xrcb.xrcb002   = ''
            LET l_xrcb.xrcb003   = ''
            LET l_xrcb.xrcb004   = ''
            LET l_xrcb.xrcb005   = ''
            LET l_xrcb.xrcb006   = ''
            LET l_xrcb.xrcb007   = 1
            LET l_xrcb.xrcb008   = l_deaf.deafdocno
            LET l_xrcb.xrcb009   = ''
            LET l_xrcb.xrcb010   = l_pcab005
            LET l_xrcb.xrcb011   = l_ooeg004
            LET l_xrcb.xrcb012   = ''
            LET l_xrcb.xrcb013   = ''
            LET l_xrcb.xrcb014   = ''
            LET l_xrcb.xrcb015   = ''
            LET l_xrcb.xrcb016   = ''
            LET l_xrcb.xrcb017   = ''
            LET l_xrcb.xrcb018   = ''
            LET l_xrcb.xrcb019   = ''
            LET l_xrcb.xrcb020   = ''
            LET l_xrcb.xrcb023   = 'N'
            LET l_xrcb.xrcb024   = ''
            LET l_xrcb.xrcb025   = ''
            LET l_xrcb.xrcb026   = ''
            LET l_xrcb.xrcb027   = ''   #流通待補欄位
            LET l_xrcb.xrcb028   = ''
            LET l_xrcb.xrcb030   = ''
            LET l_xrcb.xrcb031   = ''
            LET l_xrcb.xrcb032   = ''
            LET l_xrcb.xrcb033   = ''
            LET l_xrcb.xrcb034   = ''
            LET l_xrcb.xrcb035   = ''
            LET l_xrcb.xrcb036   = ''
            LET l_xrcb.xrcb037   = ''
            LET l_xrcb.xrcb038   = ''
            LET l_xrcb.xrcb039   = ''
            LET l_xrcb.xrcb040   = ''
            LET l_xrcb.xrcb041   = ''
            LET l_xrcb.xrcb042   = ''
            LET l_xrcb.xrcb043   = ''
            LET l_xrcb.xrcb044   = ''
            LET l_xrcb.xrcb045   = ''
            LET l_xrcb.xrcb046   = ''
            LET l_xrcb.xrcb047   = ''
            LET l_xrcb.xrcb048   = ''
            LET l_xrcb.xrcb049   = ''
            LET l_xrcb.xrcb050   = ''
            LET l_xrcb.xrcb051   = l_pcab002
            LET l_xrcb.xrcb052   = l_deaf.deaf005
            LET l_xrcb.xrcb100   = l_xrca.xrca100
            LET l_xrcb.xrcb101   = l_deaf.deaf008
            LET l_xrcb.xrcb102   = l_xrca.xrca101
            LET l_xrcb.xrcb103   = l_deaf.deaf023
            LET l_xrcb.xrcb104   = 0
            LET l_xrcb.xrcb105   = l_deaf.deaf023
            LET l_xrcb.xrcb106   = 0
            LET l_xrcb.xrcb111   = l_deaf.deaf023
            LET l_xrcb.xrcb113   = l_deaf.deaf023
            LET l_xrcb.xrcb114   = 0
            LET l_xrcb.xrcb115   = l_deaf.deaf023
            LET l_xrcb.xrcb116   = 0
            LET l_xrcb.xrcb117   = 0
            LET l_xrcb.xrcb118   = 0
            LET l_xrcb.xrcb119   = 0
            LET l_xrcb.xrcb123   = l_deaf.deaf023
            LET l_xrcb.xrcb124   = 0
            LET l_xrcb.xrcb125   = l_deaf.deaf023
            LET l_xrcb.xrcb133   = l_deaf.deaf023
            LET l_xrcb.xrcb134   = 0
            LET l_xrcb.xrcb135   = l_deaf.deaf023
            #其他本位幣留下接口，暫不處理
            LET l_xrcb.xrcb121   = 0
            LET l_xrcb.xrcb126   = 0
            LET l_xrcb.xrcb131   = 0
            LET l_xrcb.xrcb136   = 0

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
                               xrcb133,xrcb134,xrcb135,xrcb136,xrcb052)   #160509-00004#9 add xrcb052 lujh
                        VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                               l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                               l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                               l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                               l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                               l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                               l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                               l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                               l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                               l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                               l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                               l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                               l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                               l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136,l_xrcb.xrcb052)   #160509-00004#9 add l_xrcb.xrcb052 lujh

            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_tot_success = FALSE
            END IF
            LET l_xrcbseq = l_xrcbseq + 1

         END IF
         #处理手续费 ---(E)---
         #160509-00004#9--add--end--lujh

         #處理串幣  ---(S)---
         IF l_deaf.deaf015 <> 0 THEN
            LET l_xrde.xrdeent  = l_xrca.xrcaent
            LET l_xrde.xrdecomp = l_xrca.xrcacomp
            LET l_xrde.xrdeld   = l_xrca.xrcald
            LET l_xrde.xrdedocno= l_xrca.xrcadocno
            LET l_xrde.xrdeseq  = l_xrdeseq + 1
            LET l_xrde.xrdesite = l_xrca.xrcasite
            LET l_xrde.xrdeorga = l_xrca.xrcasite
            LET l_xrde.xrde001  = 'axrt350'
            LET l_xrde.xrde002  = '10'
            LET l_xrde.xrde003  = ''
            LET l_xrde.xrde004  = ''
            LET l_xrde.xrde006  = l_glab002
            LET l_xrde.xrde007  = l_deaf.deaf005
            LET l_xrde.xrde008  = ''
            LET l_xrde.xrde010  = ''
            LET l_xrde.xrde011  = ''
            LET l_xrde.xrde012  = ''
            LET l_xrde.xrde013  = ''
            LET l_xrde.xrde014  = ''
            IF l_deaf.deaf015 > 0 THEN
               LET l_deaf.deaf008 = l_deaf.deaf015
               LET l_xrde.xrde015  = 'C'
            ELSE
               LET l_deaf.deaf008 = l_deaf.deaf015 * -1
               LET l_xrde.xrde015  = 'D'
            END IF
            LET l_xrde.xrde016  = l_glab005
            LET l_xrde.xrde017  = l_xrca.xrca014
            LET l_xrde.xrde018  = ''
            LET l_xrde.xrde019  = ''
            LET l_xrde.xrde020  = ''
            LET l_xrde.xrde022  = ''
            LET l_xrde.xrde023  = ''
            LET l_xrde.xrde028  = '0'
            LET l_xrde.xrde029  = ''
            LET l_xrde.xrde030  = ''
            LET l_xrde.xrde035  = ''
            LET l_xrde.xrde036  = ''
            LET l_xrde.xrde038  = ''
            LET l_xrde.xrde039  = ''
            LET l_xrde.xrde040  = ''
            LET l_xrde.xrde041  = ''
            LET l_xrde.xrde042  = ''
            LET l_xrde.xrde043  = ''
            LET l_xrde.xrde044  = ''
            LET l_xrde.xrde045  = ''
            LET l_xrde.xrde046  = ''
            LET l_xrde.xrde047  = ''
            LET l_xrde.xrde048  = ''
            LET l_xrde.xrde049  = ''
            LET l_xrde.xrde050  = ''
            LET l_xrde.xrde051  = ''
            LET l_xrde.xrde100  = l_xrca.xrca100
            LET l_xrde.xrde101  = 1
            LET l_xrde.xrde109  = l_deaf.deaf008
            LET l_xrde.xrde119  = l_deaf.deaf008
            #其他本位幣留出接口暫不處理
            LET l_xrde.xrde120  = ''
            LET l_xrde.xrde121  = 0
            LET l_xrde.xrde129  = 0
            LET l_xrde.xrde130  = ''
            LET l_xrde.xrde131  = 0
            LET l_xrde.xrde139  = 0

            INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,
                               xrde001,xrde002,xrde003,xrde004,xrde006,xrde007,xrde008,
                               xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,
                               xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,
                               xrde023,xrde028,xrde029,xrde030,xrde035,xrde036,
                               xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,
                               xrde044,xrde045,xrde046,xrde047,xrde048,xrde049,
                               xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,
                               xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                        VALUES(l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,
                               l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,l_xrde.xrde008,
                               l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,
                               l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,
                               l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,l_xrde.xrde035,l_xrde.xrde036,
                               l_xrde.xrde038,l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,
                               l_xrde.xrde044,l_xrde.xrde045,l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,l_xrde.xrde049,
                               l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,
                               l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139)

            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_tot_success = FALSE
            END IF
            LET l_xrdeseq = l_xrdeseq + 1
         END IF
         #處理串幣  ---(E)---

         #160509-00004#9--mark--str--lujh
         UPDATE deaf_t SET deaf011 = 'Y'
          WHERE deafent = g_enterprise
            AND deafdocno = l_deaf.deafdocno
            AND deaf005 = l_deaf.deaf005
         #160509-00004#9--mark--end--lujh

      END FOREACH
      #STEP8 ---(E)---

      SELECT ABS(SUM(xrcb103 * xrcb022)),ABS(SUM(xrcb104 * xrcb022)),ABS(SUM(xrcb113 * xrcb022)),ABS(SUM(xrcb114 * xrcb022)),
             ABS(SUM(xrcb123 * xrcb022)),ABS(SUM(xrcb124 * xrcb022)),ABS(SUM(xrcb133 * xrcb022)),ABS(SUM(xrcb134 * xrcb022))  
        INTO l_xrca.xrca103,l_xrca.xrca104,l_xrca.xrca113,l_xrca.xrca114, 
             l_xrca.xrca123,l_xrca.xrca124,l_xrca.xrca133,l_xrca.xrca134     
        FROM xrcb_t
       WHERE xrcbent = g_enterprise AND xrcbld = l_xrca.xrcald AND xrcbdocno = l_xrca.xrcadocno
         AND xrcb001 NOT IN ('19','29')
      IF cl_null(l_xrca.xrca103) THEN LET l_xrca.xrca103 = 0 END IF 
      IF cl_null(l_xrca.xrca104) THEN LET l_xrca.xrca104 = 0 END IF 
      IF cl_null(l_xrca.xrca113) THEN LET l_xrca.xrca113 = 0 END IF 
      IF cl_null(l_xrca.xrca114) THEN LET l_xrca.xrca114 = 0 END IF
      IF cl_null(l_xrca.xrca123) THEN LET l_xrca.xrca123 = 0 END IF 
      IF cl_null(l_xrca.xrca124) THEN LET l_xrca.xrca124 = 0 END IF
      IF cl_null(l_xrca.xrca133) THEN LET l_xrca.xrca133 = 0 END IF 
      IF cl_null(l_xrca.xrca134) THEN LET l_xrca.xrca134 = 0 END IF

      LET l_xrca.xrca107 = 0
      LET l_xrca.xrca117 = 0
      SELECT SUM(xrde109 * CASE WHEN xrde015 = 'D' THEN 1 ELSE -1 END),
             SUM(xrde119 * CASE WHEN xrde015 = 'D' THEN 1 ELSE -1 END)
        INTO l_xrca.xrca107,l_xrca.xrca117
        FROM xrde_t
       WHERE xrdeent = g_enterprise   AND xrdedocno = l_xrca.xrcadocno
         AND xrdeld  = l_xrca.xrcald

      UPDATE xrca_t SET (xrca103,xrca104,xrca107,
                         xrca113,xrca114,xrca117,
                         xrca123,xrca124,xrca133,xrca134)
                      = (l_xrca.xrca103,l_xrca.xrca104,l_xrca.xrca107,
                         l_xrca.xrca113,l_xrca.xrca114,l_xrca.xrca117,
                         l_xrca.xrca123,l_xrca.xrca124,l_xrca.xrca133,l_xrca.xrca134) 
       WHERE xrcaent = g_enterprise AND xrcald = l_xrca.xrcald AND xrcadocno = l_xrca.xrcadocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xrca.xrcadocno
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_tot_success = FALSE
      END IF
      #2015/06/29 Mod  ---(S)---
     #CALL s_axrt300_installments(l_xrca.xrcald,l_xrca.xrcadocno) RETURNING l_success 
     #IF NOT l_success THEN
     #   LET l_tot_success = l_success
     #END IF
      UPDATE xrca_t SET xrca108 = xrca103 + xrca104,
                        xrca118 = xrca113 + xrca114
       WHERE xrcaent = g_enterprise AND xrcald = l_xrca.xrcald AND xrcadocno = l_xrca.xrcadocno
      #2015/06/29 Mod  ---(S)---

      IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         LET g_prog = 'axrt350'
         CALL s_pre_voucher_ins('AR','R10',l_xrca.xrcald,l_xrca.xrcadocno,l_xrca.xrcadocdt,'1') RETURNING l_success
         IF NOT l_success THEN
         LET l_tot_success = l_success
         END IF
         LET g_prog = 'axrp136'
      END IF

      IF l_flag = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'agl-00167'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_tot_success = FALSE
      END IF

     #151201-00002#62 Mark ---(S)---
     #STEP9 ---(S)---
     #130726-00001#95 Add  ---(S)---
      INITIALIZE l_xrca TO NULL
      OPEN axrp136_rtjf_curs USING l_debz_site[l_ac].debzsite
      FOREACH axrp136_rtjf_curs INTO l_rtja.*,l_rtja053
         IF cl_null(l_order) OR (NOT cl_null(l_order) AND l_order <> l_rtja.orders) THEN
            #非第一筆FOREACH資料,需要更新上一筆資料單頭金額
            IF NOT cl_null(l_order) THEN
               SELECT ABS(SUM(xrcb103 * xrcb022)),ABS(SUM(xrcb104 * xrcb022)),
                      ABS(SUM(xrcb113 * xrcb022)),ABS(SUM(xrcb114 * xrcb022)),
                      ABS(SUM(xrcb123 * xrcb022)),ABS(SUM(xrcb124 * xrcb022)),
                      ABS(SUM(xrcb133 * xrcb022)),ABS(SUM(xrcb134 * xrcb022))  
                 INTO l_xrca.xrca103,l_xrca.xrca104,
                      l_xrca.xrca113,l_xrca.xrca114, 
                      l_xrca.xrca123,l_xrca.xrca124,
                      l_xrca.xrca133,l_xrca.xrca134     
                 FROM xrcb_t
                WHERE xrcbent = g_enterprise AND xrcbld = l_xrca.xrcald AND xrcbdocno = l_xrca.xrcadocno
                  AND xrcb001 NOT IN ('19','29')
               IF cl_null(l_xrca.xrca103) THEN LET l_xrca.xrca103 = 0 END IF 
               IF cl_null(l_xrca.xrca104) THEN LET l_xrca.xrca104 = 0 END IF 
               IF cl_null(l_xrca.xrca113) THEN LET l_xrca.xrca113 = 0 END IF 
               IF cl_null(l_xrca.xrca114) THEN LET l_xrca.xrca114 = 0 END IF
               IF cl_null(l_xrca.xrca123) THEN LET l_xrca.xrca123 = 0 END IF 
               IF cl_null(l_xrca.xrca124) THEN LET l_xrca.xrca124 = 0 END IF
               IF cl_null(l_xrca.xrca133) THEN LET l_xrca.xrca133 = 0 END IF 
               IF cl_null(l_xrca.xrca134) THEN LET l_xrca.xrca134 = 0 END IF
     
               LET l_xrca.xrca107 = 0
               LET l_xrca.xrca117 = 0
               SELECT SUM(xrde109 * CASE WHEN xrde015 = 'D' THEN 1 ELSE -1 END),
                      SUM(xrde119 * CASE WHEN xrde015 = 'D' THEN 1 ELSE -1 END)
                 INTO l_xrca.xrca107,l_xrca.xrca117
                 FROM xrde_t
                WHERE xrdeent = g_enterprise   AND xrdedocno = l_xrca.xrcadocno
                  AND xrdeld  = l_xrca.xrcald
              
               UPDATE xrca_t SET (xrca103,xrca104,xrca107,
                                  xrca113,xrca114,xrca117,
                                  xrca123,xrca124,xrca133,xrca134)
                               = (l_xrca.xrca103,l_xrca.xrca104,l_xrca.xrca107,
                                  l_xrca.xrca113,l_xrca.xrca114,l_xrca.xrca117,
                                  l_xrca.xrca123,l_xrca.xrca124,l_xrca.xrca133,l_xrca.xrca134) 
                WHERE xrcaent = g_enterprise AND xrcald = l_xrca.xrcald AND xrcadocno = l_xrca.xrcadocno
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = l_xrca.xrcadocno
                  LET g_errparam.code   = SQLCA.SQLCODE
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET l_tot_success = FALSE
               END IF
              #20150724--unmark--str--lujh
               #2015/06/29 Mod  ---(S)---
              CALL s_axrt300_installments(l_xrca.xrcald,l_xrca.xrcadocno) RETURNING l_success 
              IF NOT l_success THEN
                 LET l_tot_success = l_success
              END IF
              #20150724--unmark--end--lujh
               UPDATE xrca_t SET xrca108 = xrca103 + xrca104,
                                 xrca118 = xrca113 + xrca114
                WHERE xrcaent = g_enterprise AND xrcald = l_xrca.xrcald AND xrcadocno = l_xrca.xrcadocno
               #2015/06/29 Mod  ---(S)---
     
               IF NOT cl_null(l_rtja053) AND l_rtja053 = 'Y' THEN
                  UPDATE xrcc_t SET xrcc109 = xrcc108,
                                    xrcc119 = xrcc118
                   WHERE xrccent = g_enterprise
                     AND xrccld = l_xrca.xrcald
                     AND xrccdocno = l_xrca.xrcadocno
               END IF
     
               IF l_glaa121 = 'Y' AND l_dfin00301 = 'Y' THEN
                  LET g_prog = 'axrt350'
                  CALL s_pre_voucher_ins('AR','R10',l_xrca.xrcald,l_xrca.xrcadocno,l_xrca.xrcadocdt,'1') RETURNING l_success
                  IF NOT l_success THEN
                  LET l_tot_success = l_success
                  END IF
                  LET g_prog = 'axrp136'
               END IF
            END IF
     
            #符合拆單原則進行拆單
            INITIALIZE l_xrca TO NULL
     
            CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.l_xrcadocno,g_master.debz002,'axrt370')
               RETURNING l_success,l_xrcadocno
            IF NOT l_success THEN
               LET l_tot_success = l_success
            END IF
            SELECT pmab105 INTO l_pmab105 FROM pmab_t
             WHERE pmabent = g_enterprise AND pmabsite = l_glaacomp AND pmab001 = l_rtja.rtja002
     
            SELECT glab005 INTO l_xrca035 FROM glab_t 
             WHERE glabld = g_master.xrcald 
               AND glabent = g_enterprise
               AND glab002 = l_sfin2017       # 帳款類別
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab003 = '8304_01'
     
            SELECT glab005 INTO l_xrca036 FROM glab_t 
             WHERE glabld = g_master.xrcald 
               AND glabent = g_enterprise
               AND glab002 = l_sfin2017       # 帳款類別
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab003 = '8304_21'
     
            SELECT pmab084 INTO l_pmab084
              FROM pmab_t    
             WHERE pmabent = g_enterprise AND pmabsite = l_glaacomp AND pmab001 = l_rtja.rtja002
     
            LET l_xrca.xrcaent = g_enterprise
            LET l_xrca.xrcastus = 'N'
            LET l_xrca.xrcacomp = l_glaacomp
            LET l_xrca.xrcald = g_master.xrcald
            LET l_xrca.xrcadocno = l_xrcadocno
            LET l_xrca.xrcadocdt = g_master.debz002
            LET l_xrca.xrcasite = g_master.xrcasite
            IF l_rtja.rtjf003 > 0 THEN
               LET l_xrca.xrca001 = '141'
            ELSE
               LET l_xrca.xrca001 = '241'
            END IF
            LET l_xrca.xrca003 = g_user
            LET l_xrca.xrca004 = l_rtja.rtja002
            LET l_xrca.xrca005 = l_rtja.rtja002
            LET l_xrca.xrca006 = ''
            LET l_xrca.xrca007 = l_pmab105
            LET l_xrca.xrca008 = l_rtja.rtja025
            LET l_xrca.xrca009 = g_master.debz002
            LET l_xrca.xrca010 = g_master.debz002
            LET l_xrca.xrca011 = l_sfin2018
            CALL s_tax_chk(l_glaacomp,l_xrca.xrca011)
               RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011
            LET l_xrca.xrca014 = g_user
            LET l_xrca.xrca015 = g_dept
            LET l_xrca.xrca016 = '13'            #20150601
            LET l_xrca.xrca017 = '0'
            LET l_xrca.xrca018 = ''
            LET l_xrca.xrca019 = ''
            LET l_xrca.xrca020 = 'N'
            LET l_xrca.xrca021 = 'N'
            LET l_xrca.xrca022 = ''
            LET l_xrca.xrca023 = ''
            LET l_xrca.xrca024 = ''
            LET l_xrca.xrca025 = ''
            LET l_xrca.xrca026 = ''
            LET l_xrca.xrca028 = ''
            LET l_xrca.xrca029 = 1
            LET l_xrca.xrca030 = 0
            LET l_xrca.xrca031 = 0
            LET l_xrca.xrca032 = 0
            LET l_xrca.xrca033 = ''
            LET l_xrca.xrca034 = ''
            LET l_xrca.xrca035 = l_xrca035
            LET l_xrca.xrca036 = l_xrca036
            LET l_xrca.xrca037 = 'Y'   #需要再看
            LET l_xrca.xrca038 = ''
            LET l_xrca.xrca039 = 0
            LET l_xrca.xrca040 = 'N'
            LET l_xrca.xrca041 = ''
            LET l_xrca.xrca042 = ''
            LET l_xrca.xrca043 = ''
            LET l_xrca.xrca044 = 0
            LET l_xrca.xrca045 = ''
            LET l_xrca.xrca046 = 'N'
            LET l_xrca.xrca047 = ''
            LET l_xrca.xrca048 = ''
            LET l_xrca.xrca049 = ''
            LET l_xrca.xrca050 = 0
            LET l_xrca.xrca051 = ''
            LET l_xrca.xrca052 = 0
            LET l_xrca.xrca053 = ''
            LET l_xrca.xrca054 = ''
            LET l_xrca.xrca055 = ''
            LET l_xrca.xrca056 = ''
            LET l_xrca.xrca057 = ''
            LET l_xrca.xrca058 = ''
            LET l_xrca.xrca059 = ''
            LET l_xrca.xrca060 = ''
            LET l_xrca.xrca061 = ''
            LET l_xrca.xrca062 = ''
            LET l_xrca.xrca063 = ''
            LET l_xrca.xrca064 = 0
            LET l_xrca.xrca065 = ''
            LET l_xrca.xrca066 = ''
            LET l_xrca.xrca100 = l_rtja.rtja026
            LET l_xrca.xrca101 = 1
            LET l_xrca.xrca103 = 0
            LET l_xrca.xrca104 = 0
            LET l_xrca.xrca106 = 0
            LET l_xrca.xrca107 = 0
            LET l_xrca.xrca108 = 0
            LET l_xrca.xrca113 = 0
            LET l_xrca.xrca114 = 0
            LET l_xrca.xrca116 = 0
            LET l_xrca.xrca117 = 0
            LET l_xrca.xrca118 = 0
            LET l_xrca.xrca120 = l_glaa016
            LET l_xrca.xrca121 = 0
            LET l_xrca.xrca123 = 0
            LET l_xrca.xrca124 = 0
            LET l_xrca.xrca126 = 0
            LET l_xrca.xrca127 = 0
            LET l_xrca.xrca128 = 0
            LET l_xrca.xrca130 = l_glaa020
            LET l_xrca.xrca131 = 0
            LET l_xrca.xrca133 = 0
            LET l_xrca.xrca134 = 0
            LET l_xrca.xrca136 = 0
            LET l_xrca.xrca137 = 0
            LET l_xrca.xrca138 = 0
            LET l_xrca.xrcaownid = g_user
            LET l_xrca.xrcaowndp = g_dept
            LET l_xrca.xrcacrtid = g_user
            LET l_xrca.xrcacrtdp = g_dept 
            LET l_xrca.xrcacrtdt = cl_get_current()
            LET l_xrca.xrcamodid = g_user
            LET l_xrca.xrcamoddt = cl_get_current()
            LET l_xrca.xrcacnfid = ''
            LET l_xrca.xrcacnfdt = ''
            LET l_xrca.xrcapstid = ''
            LET l_xrca.xrcapstdt = ''
     
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
                        VALUES(l_xrca.xrcaent,l_xrca.xrcastus,l_xrca.xrcacomp,l_xrca.xrcald,l_xrca.xrcadocno,l_xrca.xrcadocdt,l_xrca.xrcasite,
                               l_xrca.xrca001,l_xrca.xrca003,l_xrca.xrca004,l_xrca.xrca005,l_xrca.xrca006,l_xrca.xrca007,
                               l_xrca.xrca008,l_xrca.xrca009,l_xrca.xrca010,l_xrca.xrca011,l_xrca.xrca012,l_xrca.xrca013,
                               l_xrca.xrca014,l_xrca.xrca015,l_xrca.xrca016,l_xrca.xrca017,l_xrca.xrca018,l_xrca.xrca019,
                               l_xrca.xrca020,l_xrca.xrca021,l_xrca.xrca022,l_xrca.xrca023,l_xrca.xrca024,l_xrca.xrca025,
                               l_xrca.xrca026,l_xrca.xrca028,l_xrca.xrca029,l_xrca.xrca030,l_xrca.xrca031,l_xrca.xrca032,
                               l_xrca.xrca033,l_xrca.xrca034,l_xrca.xrca035,l_xrca.xrca036,l_xrca.xrca037,l_xrca.xrca038,
                               l_xrca.xrca039,l_xrca.xrca040,l_xrca.xrca041,l_xrca.xrca042,l_xrca.xrca043,l_xrca.xrca044,
                               l_xrca.xrca045,l_xrca.xrca046,l_xrca.xrca047,l_xrca.xrca048,l_xrca.xrca049,l_xrca.xrca050,
                               l_xrca.xrca051,l_xrca.xrca052,l_xrca.xrca053,l_xrca.xrca054,l_xrca.xrca055,l_xrca.xrca056,
                               l_xrca.xrca057,l_xrca.xrca058,l_xrca.xrca059,l_xrca.xrca060,l_xrca.xrca061,l_xrca.xrca062,
                               l_xrca.xrca063,l_xrca.xrca064,l_xrca.xrca065,l_xrca.xrca066,l_xrca.xrca100,l_xrca.xrca101,
                               l_xrca.xrca103,l_xrca.xrca104,l_xrca.xrca106,l_xrca.xrca107,l_xrca.xrca108,l_xrca.xrca113,
                               l_xrca.xrca114,l_xrca.xrca116,l_xrca.xrca117,l_xrca.xrca118,l_xrca.xrca120,l_xrca.xrca121,
                               l_xrca.xrca123,l_xrca.xrca124,l_xrca.xrca126,l_xrca.xrca127,l_xrca.xrca128,l_xrca.xrca130,
                               l_xrca.xrca131,l_xrca.xrca133,l_xrca.xrca134,l_xrca.xrca136,l_xrca.xrca137,l_xrca.xrca138,
                               l_xrca.xrcaownid,l_xrca.xrcaowndp,l_xrca.xrcacrtid,l_xrca.xrcacrtdp,
                               l_xrca.xrcacrtdt,l_xrca.xrcamodid,l_xrca.xrcamoddt,l_xrca.xrcacnfid,
                               l_xrca.xrcacnfdt,l_xrca.xrcapstid,l_xrca.xrcapstdt)
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrca.xrcadocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_tot_success = FALSE
            END IF
     
            LET l_xrcbseq = 0
         END IF
         LET l_order = l_rtja.orders
     
         IF cl_null(l_start_no_141) THEN LET l_start_no_141 = l_xrcadocno END IF
         LET l_end_no_141 = l_xrcadocno
     
         INITIALIZE l_xrcb TO NULL
     
         LET l_ooeg004 = NULL
         SELECT ooeg004 INTO l_ooeg004 FROM ooeg_t
          WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015
     
         IF l_rtja.rtjf003 < 0 THEN
            LET l_rtja.rtjf003 = l_rtja.rtjf003 * -1
         END IF
     
         LET l_xrcb.xrcbent   = l_xrca.xrcaent
         LET l_xrcb.xrcbld    = l_xrca.xrcald
         LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
         LET l_xrcb.xrcbseq   = l_xrcbseq + 1
         LET l_xrcb.xrcbsite  = l_xrca.xrcasite
         LET l_xrcb.xrcborga  = l_rtja.rtjasite
         LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
         LET l_xrcb.xrcb001   = '13'      #20150601
         LET l_xrcb.xrcb002   = l_rtja.rtjadocno
         LET l_xrcb.xrcb003   = ''
         LET l_xrcb.xrcb004   = ''
         LET l_xrcb.xrcb005   = ''
         LET l_xrcb.xrcb006   = ''
         LET l_xrcb.xrcb007   = 1
         LET l_xrcb.xrcb008   = ''
         LET l_xrcb.xrcb009   = ''
         LET l_xrcb.xrcb010   = l_xrca.xrca015
         LET l_xrcb.xrcb011   = l_ooeg004
         LET l_xrcb.xrcb012   = ''
         LET l_xrcb.xrcb013   = ''
         LET l_xrcb.xrcb014   = ''
         LET l_xrcb.xrcb015   = ''
         LET l_xrcb.xrcb016   = ''
         LET l_xrcb.xrcb017   = ''
         LET l_xrcb.xrcb018   = l_rtja.rtjf027
         LET l_xrcb.xrcb019   = ''
         LET l_xrcb.xrcb020   = l_sfin2018
         LET l_xrcb.xrcb021   = l_xrca.xrca035
         LET l_xrcb.xrcb022   = 1
         LET l_xrcb.xrcb023   = 'N'
         LET l_xrcb.xrcb024   = ''
         LET l_xrcb.xrcb025   = ''
         LET l_xrcb.xrcb026   = ''
         LET l_xrcb.xrcb027   = ''   #流通待補欄位
         LET l_xrcb.xrcb028   = ''
         LET l_xrcb.xrcb029   = l_xrca.xrca035
         LET l_xrcb.xrcb030   = ''
         LET l_xrcb.xrcb031   = ''
         LET l_xrcb.xrcb032   = ''
         LET l_xrcb.xrcb033   = ''
         LET l_xrcb.xrcb034   = ''
         LET l_xrcb.xrcb035   = ''
         LET l_xrcb.xrcb036   = ''
         LET l_xrcb.xrcb037   = ''
         LET l_xrcb.xrcb038   = ''
         LET l_xrcb.xrcb039   = ''
         LET l_xrcb.xrcb040   = ''
         LET l_xrcb.xrcb041   = ''
         LET l_xrcb.xrcb042   = ''
         LET l_xrcb.xrcb043   = ''
         LET l_xrcb.xrcb044   = ''
         LET l_xrcb.xrcb045   = ''
         LET l_xrcb.xrcb046   = ''
         LET l_xrcb.xrcb047   = ''
         LET l_xrcb.xrcb048   = ''
         LET l_xrcb.xrcb049   = ''
         LET l_xrcb.xrcb050   = ''
         LET l_xrcb.xrcb051   = l_xrca.xrca014
         LET l_xrcb.xrcb100   = l_xrca.xrca100
     
         LET l_xrcb.xrcb101   = l_rtja.rtjf003
     
         CALL s_tax_ins(l_xrca.xrcadocno,l_xrcb.xrcbseq,0,l_glaacomp,
                        l_xrcb.xrcb101 * l_xrcb.xrcb007,l_xrcb.xrcb020,
                        l_xrcb.xrcb007,l_xrcb.xrcb100,l_xrca.xrca101,l_xrca.xrcald,l_xrca.xrca121,l_xrca.xrca131)
            RETURNING l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,
                      l_xrcb.xrcb113,l_xrcb.xrcb114,l_xrcb.xrcb115,
                      l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,
                      l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135
      
         LET l_xrcb.xrcb102   = l_xrca.xrca101
         LET l_xrcb.xrcb106   = 0
         LET l_xrcb.xrcb111   = l_xrcb.xrcb101 * l_xrca.xrca101
         LET l_xrcb.xrcb116   = 0
         LET l_xrcb.xrcb117   = 0
         LET l_xrcb.xrcb118   = 0
         LET l_xrcb.xrcb119   = 0
         #其他本位幣留下接口，暫不處理
         LET l_xrcb.xrcb121   = 0
         LET l_xrcb.xrcb126   = 0
         LET l_xrcb.xrcb131   = 0
         LET l_xrcb.xrcb136   = 0
     
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
                            xrcb133,xrcb134,xrcb135,xrcb136)
                     VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                            l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                            l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                            l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                            l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                            l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                            l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                            l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                            l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                            l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                            l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                            l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                            l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                            l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         END IF
         LET l_xrcbseq = l_xrcbseq + 1
     
      END FOREACH
      IF NOT cl_null(l_xrca.xrcadocno) THEN
         SELECT ABS(SUM(xrcb103 * xrcb022)),ABS(SUM(xrcb104 * xrcb022)),
                ABS(SUM(xrcb113 * xrcb022)),ABS(SUM(xrcb114 * xrcb022)),
                ABS(SUM(xrcb123 * xrcb022)),ABS(SUM(xrcb124 * xrcb022)),
                ABS(SUM(xrcb133 * xrcb022)),ABS(SUM(xrcb134 * xrcb022))  
           INTO l_xrca.xrca103,l_xrca.xrca104,
                l_xrca.xrca113,l_xrca.xrca114, 
                l_xrca.xrca123,l_xrca.xrca124,
                l_xrca.xrca133,l_xrca.xrca134     
           FROM xrcb_t
          WHERE xrcbent = g_enterprise AND xrcbld = l_xrca.xrcald AND xrcbdocno = l_xrca.xrcadocno
            AND xrcb001 NOT IN ('19','29')
         IF cl_null(l_xrca.xrca103) THEN LET l_xrca.xrca103 = 0 END IF 
         IF cl_null(l_xrca.xrca104) THEN LET l_xrca.xrca104 = 0 END IF 
         IF cl_null(l_xrca.xrca113) THEN LET l_xrca.xrca113 = 0 END IF 
         IF cl_null(l_xrca.xrca114) THEN LET l_xrca.xrca114 = 0 END IF
         IF cl_null(l_xrca.xrca123) THEN LET l_xrca.xrca123 = 0 END IF 
         IF cl_null(l_xrca.xrca124) THEN LET l_xrca.xrca124 = 0 END IF
         IF cl_null(l_xrca.xrca133) THEN LET l_xrca.xrca133 = 0 END IF 
         IF cl_null(l_xrca.xrca134) THEN LET l_xrca.xrca134 = 0 END IF
     
         LET l_xrca.xrca107 = 0
         LET l_xrca.xrca117 = 0
         SELECT SUM(xrde109 * CASE WHEN xrde015 = 'D' THEN 1 ELSE -1 END),
                SUM(xrde119 * CASE WHEN xrde015 = 'D' THEN 1 ELSE -1 END)
           INTO l_xrca.xrca107,l_xrca.xrca117
           FROM xrde_t
          WHERE xrdeent = g_enterprise   AND xrdedocno = l_xrca.xrcadocno
            AND xrdeld  = l_xrca.xrcald
     
         UPDATE xrca_t SET (xrca103,xrca104,xrca107,
                            xrca113,xrca114,xrca117,
                            xrca123,xrca124,xrca133,xrca134)
                         = (l_xrca.xrca103,l_xrca.xrca104,l_xrca.xrca107,
                            l_xrca.xrca113,l_xrca.xrca114,l_xrca.xrca117,
                            l_xrca.xrca123,l_xrca.xrca124,l_xrca.xrca133,l_xrca.xrca134) 
          WHERE xrcaent = g_enterprise AND xrcald = l_xrca.xrcald AND xrcadocno = l_xrca.xrcadocno
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         END IF
        #20150724--unmark--str--lujh
         #2015/06/29 Mod  ---(S)---
        CALL s_axrt300_installments(l_xrca.xrcald,l_xrca.xrcadocno) RETURNING l_success 
        IF NOT l_success THEN
           LET l_tot_success = l_success
        END IF
        #20150724--unmark--end--lujh
         UPDATE xrca_t SET xrca108 = xrca103 + xrca104,
                           xrca118 = xrca113 + xrca114
          WHERE xrcaent = g_enterprise AND xrcald = l_xrca.xrcald AND xrcadocno = l_xrca.xrcadocno
         #2015/06/29 Mod  ---(S)---
     
         IF NOT cl_null(l_rtja053) AND l_rtja053 = 'Y' THEN
            UPDATE xrcc_t SET xrcc109 = xrcc108,
                              xrcc119 = xrcc118
             WHERE xrccent = g_enterprise
               AND xrccld = l_xrca.xrcald
               AND xrccdocno = l_xrca.xrcadocno
         END IF
     
         IF l_glaa121 = 'Y' AND l_dfin00301 = 'Y' THEN
            LET g_prog = 'axrt350'
            CALL s_pre_voucher_ins('AR','R10',l_xrca.xrcald,l_xrca.xrcadocno,l_xrca.xrcadocdt,'1') RETURNING l_success
            IF NOT l_success THEN
            LET l_tot_success = l_success
            END IF
            LET g_prog = 'axrp136'
         END IF
      END IF
     #130726-00001#95 Add  ---(E)---
     #STEP9 ---(E)---
     #151201-00002#62 Mark ---(E)---

     #STEP10 ---(S)---
      CASE
         WHEN l_glaa023 = '1'
            UPDATE debz_t SET debz015 = debz012
             WHERE debzent = g_enterprise
               AND debzsite= l_debz.debzsite
               AND debz002 = l_debz.debz002

            UPDATE deby_t SET deby016 = deby003
             WHERE debyent = g_enterprise
               AND debysite= l_debz.debzsite
               AND deby003 = l_debz.debz002
         WHEN l_glaa023 = '2'
            UPDATE debz_t SET debz016 = debz012
             WHERE debzent = g_enterprise
               AND debzsite= l_debz.debzsite
               AND debz002 = l_debz.debz002

            UPDATE deby_t SET deby017 = deby003
             WHERE debyent = g_enterprise
               AND debysite= l_debz.debzsite
               AND deby003 = l_debz.debz002
         WHEN l_glaa023 = '3'
            UPDATE debz_t SET debz017 = debz012
             WHERE debzent = g_enterprise
               AND debzsite= l_debz.debzsite
               AND debz002 = l_debz.debz002

            UPDATE deby_t SET deby018 = deby003
             WHERE debyent = g_enterprise
               AND debysite= l_debz.debzsite
               AND deby003 = l_debz.debz002
     END CASE
     #STEP10 ---(E)---

     #160509-00004#40--mark--str--lujh
     ##160509-00004#9--add--str--lujh
     ##STEP13---(S)---
     #LET l_deaf026 = ''    LET l_ld = ''    LET l_docno = ''
     #SELECT deaf026,ld,docno INTO l_deaf026,l_ld,l_docno
     #  FROM axrp136_tmp 
     # WHERE deafsite = l_debz_site[l_ac].debzsite
     #
     #IF NOT cl_null(l_deaf026) AND NOT cl_null(l_ld) AND NOT cl_null(l_docno) THEN 
     #   INITIALIZE l_glaa   TO NULL
     #   INITIALIZE l_xrca_t TO NULL
     #   INITIALIZE l_xrcb_t TO NULL
     #   INITIALIZE l_xrcc_t TO NULL
     #   INITIALIZE l_xrde_t TO NULL
     #   
     #   SELECT * INTO l_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_ld
     #   
     #   LET l_dfin00301 = ''
     #   CALL s_fin_get_doc_para(l_xrca_t.xrcald,l_glaa.glaacomp,l_docno,'D-FIN-0030') RETURNING l_dfin00301
     #   
     #   CALL s_aooi200_fin_gen_docno(l_ld,l_glaa.glaa024,l_glaa.glaa003,l_docno,g_master.debz002,'axrt350')
     #       RETURNING l_success,l_docno
     #   IF NOT l_success THEN
     #      LET l_tot_success = l_success
     #   END IF
     #   
     #   #复制单头
     #   SELECT * INTO l_xrca_t.* FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = g_master.xrcald AND xrcadocno = l_end_no_14
     #   LET l_xrca_t.xrcald = l_ld
     #   LET l_xrca_t.xrcadocno = l_docno
     #   LET l_xrca_t.xrcasite = l_deaf026
     #   LET l_xrca_t.xrca018 = l_end_no_14
     #   INSERT INTO xrca_t VALUES(l_xrca_t.*)
     #   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.extend = l_xrca_t.xrcadocno
     #      LET g_errparam.code   = SQLCA.SQLCODE
     #      LET g_errparam.popup  = TRUE
     #      CALL cl_err()
     #      LET l_tot_success = FALSE
     #   END IF
     #   #复制单身
     #   FOREACH axrp136_xrcb_curs USING l_end_no_14 INTO l_xrcb_t.*
     #      LET l_xrcbld_t = l_xrcb_t.xrcbld
     #      LET l_xrcb_t.xrcbld = l_ld
     #      LET l_xrcb_t.xrcbdocno = l_docno
     #      LET l_xrcb_t.xrcbsite = l_deaf026
     #      LET l_xrcb_t.xrcborga  = l_deaf026
     #      LET l_xrcb_t.xrcblegl  = l_glaa.glaacomp
     #      
     #      LET l_glab005 = ''
     #      SELECT glab005 INTO l_glab005
     #        FROM glab_t
     #       WHERE glabent = g_enterprise
     #         AND glabld = l_xrcbld_t
     #         AND glab001 = '13'
     #         AND glab002 = '6736'
     #         AND glab003 = '14'
     #         
     #      IF l_glab005 = l_xrcb_t.xrcb021 AND l_xrcb_t.xrcb021 = l_xrcb_t.xrcb029 THEN    #手续费科目
     #         SELECT glab005 INTO l_xrcb_t.xrcb021
     #           FROM glab_t
     #          WHERE glabent = g_enterprise
     #            AND glabld = l_xrcb_t.xrcbld
     #            AND glab001 = '13'
     #            AND glab002 = '6736'
     #            AND glab003 = '14'
     #            
     #         LET l_xrcb_t.xrcb029 = l_xrcb_t.xrcb021
     #         #手续费只会在代收银据点体现,所以门店的手续费资料删除
     #         DELETE FROM xrcb_t 
     #          WHERE xrcbent = g_enterprise
     #            AND xrcbld = l_xrcbld_t
     #            AND xrcbdocno = l_end_no_14
     #            AND xrcbseq = l_xrcb_t.xrcbseq
     #            
     #         UPDATE xrcb_t SET xrcb103 = xrcb103 - l_xrcb_t.xrcb103,
     #                           xrcb105 = xrcb105 - l_xrcb_t.xrcb105,
     #                           xrcb113 = xrcb113 - l_xrcb_t.xrcb113,
     #                           xrcb115 = xrcb115 - l_xrcb_t.xrcb115
     #          WHERE xrcbent = g_enterprise
     #            AND xrcbld = l_xrcb_t.xrcbld
     #            AND xrcbdocno = l_xrcb_t.xrcbdocno
     #            AND xrcb052 = l_xrcb_t.xrcb052
     #            AND xrcb001 NOT IN ('19','29')   
     #         
     #      ELSE
     #         #agli190代收银科目
     #         SELECT glab009 INTO l_xrcb_t.xrcb021 FROM glab_t WHERE glabent = g_enterprise
     #            AND glabld  = l_xrcb_t.xrcbld
     #            AND glab001 = '21'
     #            AND glab003 = l_xrcb_t.xrcb052
     #      END IF
     #      
     #      #160509-00004#34--add--str--lujh
     #      IF NOT cl_null(l_xrcb_t.xrcb018) THEN 
     #         SELECT glab005 INTO l_xrcb_t.xrcb021 
     #           FROM glab_t 
     #          WHERE glabent = g_enterprise
     #            AND glabld = l_xrcb_t.xrcbld
     #            AND glab002 = l_xrca_t.xrca007 # 帳款類別
     #            AND glab001 = '13'             # 應收帳務類型科目設定
     #            AND glab003 = '8304_21'
     #      ELSE
     #         #根據品類取得科目
     #         SELECT glab005 INTO l_xrcb_t.xrcb021 
     #           FROM glab_t 
     #          WHERE glabent = g_enterprise
     #            AND glabld  = l_xrcb_t.xrcbld
     #            AND glab001 = 'RTAX'
     #            AND glab002 = l_xrcb_t.xrcb033
     #            AND glab003 = l_xrcb_t.xrcb012
     #      END IF
     #      #160509-00004#34--add--end--lujh
     #
     #      INSERT INTO xrcb_t VALUES(l_xrcb_t.*)
     #      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #         INITIALIZE g_errparam TO NULL
     #         LET g_errparam.extend = l_xrcb_t.xrcbdocno
     #         LET g_errparam.code   = SQLCA.SQLCODE
     #         LET g_errparam.popup  = TRUE
     #         CALL cl_err()
     #         LET l_tot_success = FALSE
     #      END IF
     #      
     #      #160509-00004#34--add--str--lujh
     #      #复制好之后,将当前门店单身账款明细里款别对应的资金入帐是否当前据点为N的资料删除
     #      SELECT ooie034 INTO l_ooie034
     #        FROM ooie_t
     #       WHERE ooieent = g_enterprise
     #         AND ooiesite = l_xrcb_t.xrcborga
     #         AND ooie001 = l_xrcb_t.xrcb052
     #         
     #      IF l_ooie034 = 'N' THEN 
     #         DELETE FROM xrcb_t 
     #          WHERE xrcbent = g_enterprise 
     #            AND xrcbld = l_xrcbld_t 
     #            AND xrcbdocno = l_end_no_14
     #            AND xrcbseq = l_xrde_t.xrdeseq
     #            
     #         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #            INITIALIZE g_errparam TO NULL
     #            LET g_errparam.extend = l_end_no_14
     #            LET g_errparam.code   = SQLCA.SQLCODE
     #            LET g_errparam.popup  = TRUE
     #            CALL cl_err()
     #            LET l_tot_success = FALSE
     #         END IF
     #      END IF
     #      #160509-00004#34--add--end--lujh
     #      
     #   END FOREACH 
     #   
     #   #复制多账期
     #   FOREACH axrp136_xrcc_curs USING l_end_no_14 INTO l_xrcc_t.*
     #      LET l_xrcc_t.xrccld = l_ld
     #      LET l_xrcc_t.xrccdocno = l_docno
     #      LET l_xrcc_t.xrccsite = l_deaf026
     #      LET l_xrcc_t.xrcccomp  = l_glaa.glaacomp
     #      LET l_xrcc_t.xrcclegl  = l_glaa.glaacomp
     #      
     #      INSERT INTO xrcc_t VALUES(l_xrcc_t.*)
     #      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #         INITIALIZE g_errparam TO NULL
     #         LET g_errparam.extend = l_xrcc_t.xrccdocno
     #         LET g_errparam.code   = SQLCA.SQLCODE
     #         LET g_errparam.popup  = TRUE
     #         CALL cl_err()
     #         LET l_tot_success = FALSE
     #      END IF
     #   END FOREACH 
     #   
     #   #复制直接冲账
     #   FOREACH axrp136_xrde_curs USING l_end_no_14 INTO l_xrde_t.*
     #      LET l_xrdeld_t = l_xrde_t.xrdeld
     #      LET l_xedesite_t = l_xrde_t.xrdesite
     #      LET l_xrde_t.xrdeld = l_ld
     #      LET l_xrde_t.xrdedocno = l_docno
     #      LET l_xrde_t.xrdesite = l_deaf026
     #      LET l_xrde_t.xrdecomp  = l_glaa.glaacomp
     #      SELECT MAX(xrdeseq) + 1 INTO l_xrde_t.xrdeseq
     #        FROM xrde_t
     #       WHERE xrdeent = g_enterprise
     #         AND xrdeld = l_xrde_t.xrdeld
     #         AND xrdedocno = l_xrde_t.xrdedocno
     #         
     #      IF cl_null(l_xrde_t.xrdeseq) THEN 
     #         LET l_xrde_t.xrdeseq = 1
     #      END IF
     #      
     #      #将有手续费的款别,将金额拆开来
     #      LET l_glab005 = ''
     #      SELECT glab005 INTO l_glab005
     #        FROM glab_t
     #       WHERE glabent = g_enterprise
     #         AND glabld = l_xrde_t.xrdeld
     #         AND glab001 = '13'
     #         AND glab002 = '6736'
     #         AND glab003 = '14'
     #         
     #      LET l_xrcb105 = 0     LET l_xrcb115 = 0
     #      SELECT SUM(xrcb105),SUM(xrcb115) INTO l_xrcb105,l_xrcb115
     #        FROM xrcb_t
     #       WHERE xrcbent = g_enterprise
     #         AND xrcbld = l_xrde_t.xrdeld
     #         AND xrcbdocno = l_xrde_t.xrdedocno
     #         AND xrcb021 = xrcb029
     #         AND xrcb021 = l_glab005
     #         AND xrcb052 = l_xrde_t.xrde007
     #         
     #      IF cl_null(l_xrcb105) THEN LET l_xrcb105 = 0 END IF
     #      IF cl_null(l_xrcb115) THEN LET l_xrcb115 = 0 END IF
     #         
     #      LET l_xrde_t.xrde109 = l_xrde_t.xrde109 - l_xrcb105
     #      LET l_xrde_t.xrde119 = l_xrde_t.xrde119 - l_xrcb115
     #      
     #      #160509-00004#34--add--str--lujh
     #      LET l_ooie034 = ''
     #      SELECT ooie034 INTO l_ooie034
     #        FROM ooie_t
     #       WHERE ooieent = g_enterprise
     #         AND ooiesite = l_xrde_t.xrdesite
     #         AND ooie001 = l_xrde_t.xrde007 
     #         
     #      IF l_ooie034 = 'Y' THEN 
     #         SELECT glab009 INTO l_xrde_t.xrde016 
     #           FROM glab_t 
     #          WHERE glabent = g_enterprise    
     #            AND glab001 = '21' 
     #            AND glab003 = l_xrde_t.xrde007 
     #            AND glabld = l_xrde_t.xrdeld
     #      ELSE
     #         SELECT glab005 INTO l_xrde_t.xrde016 
     #           FROM glab_t 
     #          WHERE glabent = g_enterprise    
     #            AND glab001 = '21' 
     #            AND glab003 = l_xrde_t.xrde007 
     #            AND glabld = l_xrde_t.xrdeld
     #      END IF
     #      #160509-00004#34--add--end--lujh
     #      
     #      INSERT INTO xrde_t VALUES(l_xrde_t.*)
     #      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #         INITIALIZE g_errparam TO NULL
     #         LET g_errparam.extend = l_xrde_t.xrdedocno
     #         LET g_errparam.code   = SQLCA.SQLCODE
     #         LET g_errparam.popup  = TRUE
     #         CALL cl_err()
     #         LET l_tot_success = FALSE
     #      END IF
     #      
     #      #将手续费单独插一行
     #      IF l_xrcb105 <> 0 THEN 
     #         SELECT MAX(xrdeseq) + 1 INTO l_xrde_t.xrdeseq
     #           FROM xrde_t
     #          WHERE xrdeent = g_enterprise
     #            AND xrdeld = l_xrde_t.xrdeld
     #            AND xrdedocno = l_xrde_t.xrdedocno
     #            
     #         IF cl_null(l_xrde_t.xrdeseq) THEN 
     #            LET l_xrde_t.xrdeseq = 1
     #         END IF
     #         
     #         LET l_xrde_t.xrde109 = l_xrcb105
     #         LET l_xrde_t.xrde119 = l_xrcb115
     #         LET l_xrde_t.xrde016 = l_glab005
     #         
     #         INSERT INTO xrde_t VALUES(l_xrde_t.*)
     #         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #            INITIALIZE g_errparam TO NULL
     #            LET g_errparam.extend = l_xrde_t.xrdedocno
     #            LET g_errparam.code   = SQLCA.SQLCODE
     #            LET g_errparam.popup  = TRUE
     #            CALL cl_err()
     #            LET l_tot_success = FALSE
     #         END IF
     #      END IF
     #      
     #      #复制好之后,将当前门店直接收款里款别对应的资金入帐是否当前据点为N的资料删除
     #      LET l_ooie034 = ''
     #      SELECT ooie034 INTO l_ooie034
     #        FROM ooie_t
     #       WHERE ooieent = g_enterprise
     #         AND ooiesite = l_xedesite_t
     #         AND ooie001 = l_xrde_t.xrde007 
     #         
     #      IF l_ooie034 = 'N' THEN 
     #         DELETE FROM xrde_t 
     #          WHERE xrdeent = g_enterprise 
     #            AND xrdeld = l_xrdeld_t 
     #            AND xrdedocno = l_end_no_14
     #            AND xrdeseq = l_xrde_t.xrdeseq
     #         
     #         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #            INITIALIZE g_errparam TO NULL
     #            LET g_errparam.extend = l_end_no_14
     #            LET g_errparam.code   = SQLCA.SQLCODE
     #            LET g_errparam.popup  = TRUE
     #            CALL cl_err()
     #            LET l_tot_success = FALSE
     #         END IF
     #      END IF
     #   END FOREACH 
     #   
     #   CALL s_axrt300_installments(l_glaa.glaald,l_xrca_t.xrcadocno) RETURNING l_success 
     #   IF NOT l_success THEN
     #      LET l_tot_success = l_success
     #   END IF
     #   
     #   CALL s_axrt300_installments(g_master.xrcald,l_end_no_14) RETURNING l_success 
     #   IF NOT l_success THEN
     #      LET l_tot_success = l_success
     #   END IF
     #   
     #   IF l_glaa.glaa121 = 'Y' AND l_dfin00301 = 'Y' THEN
     #      DELETE FROM glga_t WHERE glgaent = g_enterprise AND glgald = l_glaa.glaald AND glgadocno = l_xrca_t.xrcadocno
     #      DELETE FROM glgb_t WHERE glgbent = g_enterprise AND glgbld = l_glaa.glaald AND glgbdocno = l_xrca_t.xrcadocno
     #      LET g_prog = 'axrt350'
     #      CALL s_pre_voucher_ins('AR','R10',l_glaa.glaald,l_xrca_t.xrcadocno,l_xrca_t.xrcadocdt,'1') RETURNING l_success
     #      IF NOT l_success THEN
     #      LET l_tot_success = l_success
     #      END IF
     #      LET g_prog = 'axrp136'
     #   END IF
     #   
     #   IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
     #      DELETE FROM glga_t WHERE glgaent = g_enterprise AND glgald = g_master.xrcald AND glgadocno = l_end_no_14
     #      DELETE FROM glgb_t WHERE glgbent = g_enterprise AND glgbld = g_master.xrcald AND glgbdocno = l_end_no_14
     #      LET g_prog = 'axrt350'
     #      CALL s_pre_voucher_ins('AR','R10',g_master.xrcald,l_end_no_14,l_xrca_t.xrcadocdt,'1') RETURNING l_success
     #      IF NOT l_success THEN
     #      LET l_tot_success = l_success
     #      END IF
     #      LET g_prog = 'axrp136'
     #   END IF
     #END IF
     ##STEP13---(E)---
     ##160509-00004#9--add--end--lujh
     #160509-00004#40--mark--end--lujh
     
     #160509-00004#34--add--str--lujh
     FOREACH axrp136_xrcb_curs1 USING l_end_no_14 INTO l_xrcb_t.*
        LET l_glab005 = ''
        SELECT glab005 INTO l_glab005
          FROM glab_t
         WHERE glabent = g_enterprise
           AND glabld = l_xrcb_t.xrcbld
           AND glab001 = '13'
           AND glab002 = '6736'
           AND glab003 = '14'
           
        SELECT MAX(xrcb105) INTO l_xrcb105_max
          FROM xrcb_t
         WHERE xrcbent = g_enterprise
           AND xrcbld = l_xrcb_t.xrcbld
           AND xrcbdocno = l_xrcb_t.xrcbdocno
           AND xrcb052 = l_xrcb_t.xrcb052
           
        SELECT xrcbseq INTO l_xrcbseq_max
          FROM xrcb_t
         WHERE xrcbent = g_enterprise
           AND xrcbld = l_xrcb_t.xrcbld
           AND xrcbdocno = l_xrcb_t.xrcbdocno
           AND xrcb105 = l_xrcb105_max
           
        IF l_glab005 = l_xrcb_t.xrcb021  THEN    #手续费科目
           UPDATE xrcb_t SET xrcb103 = xrcb103 - l_xrcb_t.xrcb103,
                             xrcb105 = xrcb105 - l_xrcb_t.xrcb105,
                             xrcb113 = xrcb113 - l_xrcb_t.xrcb113,
                             xrcb115 = xrcb115 - l_xrcb_t.xrcb115
            WHERE xrcbent = g_enterprise
              AND xrcbld = l_xrcb_t.xrcbld
              AND xrcbdocno = l_xrcb_t.xrcbdocno
              AND xrcb052 = l_xrcb_t.xrcb052
              AND xrcbseq = l_xrcbseq_max
              AND xrcb001 NOT IN ('19','29')   
              
           IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = l_xrcb_t.xrcbdocno
              LET g_errparam.code   = SQLCA.SQLCODE
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              LET l_tot_success = FALSE
           END IF   
        END IF        
     END FOREACH 
     #160509-00004#34--add--end--lujh
   END FOR

   DISPLAY "End Time: ",time

   IF l_tot_success THEN
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00341'
      LET g_errparam.replace[1] = l_start_no_14      #l_xrca.xrcadocno #130726-00001#95 Mark
      LET g_errparam.replace[2] = l_end_no_14        #l_xrca.xrcadocno #130726-00001#95 Mark
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
     #130726-00001#95 Add  ---(S)---
     #IF NOT cl_null(l_start_no_141) THEN
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.code = 'axr-00342'
     #   LET g_errparam.replace[1] = l_start_no_141
     #   LET g_errparam.replace[2] = l_end_no_141
     #   LET g_errparam.extend = ''
     #   LET g_errparam.popup = TRUE
     #   CALL cl_err()
     #END IF
     #130726-00001#95 Add  ---(E)---
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()

END FUNCTION
# 检查是否有赊销单据，如果有则赊销单别不可为空
#160509-00004#9 add lujh
PRIVATE FUNCTION axrp136_91_chk()
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sql           STRING
   
   LET g_errno = ''
   CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_master.debz002,'')
   CALL s_fin_account_center_sons_str()RETURNING g_origin_str
   IF cl_null(g_origin_str) THEN LET g_origin_str = g_master.xrcasite END IF
   CALL axrp136_get_ooef001_wc(g_origin_str)RETURNING g_origin_str
   
   LET l_cnt = 0
   LET l_sql = "SELECT COUNT(*) ",
               "  FROM rtja_t,rtjf_t",
               " WHERE rtjaent   = rtjfent",
               "   AND rtjadocno = rtjfdocno",
               "   AND rtjadocdt = '",g_master.debz002,"'",
               "   AND rtjaent   = '",g_enterprise,"'",
               "   AND rtjasite  IN ",g_origin_str CLIPPED,
               "   AND rtjf001   = '91' ",
               "   AND rtjastus  = 'S'",
               "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = xrcbent ",
               "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld    ",
               "                      AND xrcald = '",g_master.xrcald,"'               ",
               "                      AND xrcastus <> 'X' AND xrcb002 = rtjadocno)     ",
               "   AND rtja000 IN ('ammt405','agct405','artt600','artt610','artt620')  ",   
               " ORDER BY rtjadocdt,rtja002,rtja025,rtja026,rtjf003,rtja053"
   PREPARE axrp136_91_count_pre FROM l_sql
   EXECUTE axrp136_91_count_pre INTO l_cnt
   IF l_cnt > 0 THEN 
      LET g_errno = "axr-01008"
   END IF
   
END FUNCTION
# 创建临时表
#160509-00004#9 add lujh
#STEP11
PRIVATE FUNCTION axrp136_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   DROP TABLE axrp136_tmp;
   CREATE TEMP TABLE axrp136_tmp(
   deafsite        LIKE deaf_t.deafsite, 
   deaf026         LIKE deaf_t.deaf026,
   ld              LIKE glaa_t.glaald,
   docno           LIKE xrca_t.xrcadocno
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
# 抓取法人
#160509-00004#9 add lujh
PRIVATE FUNCTION axrp136_get_comp(p_ld)
   DEFINE p_ld           LIKE glaa_t.glaald
   
   SELECT glaacomp INTO g_comp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
END FUNCTION
#STEP12经营方式为租赁时改抓rtjf按款别拆分插入xrcb
#160509-00004#9 add lujh
PRIVATE FUNCTION axrp136_debz018_5(p_site,p_seq,p_docno,p_comp,p_debz005)
   DEFINE p_site             LIKE debz_t.debzsite
   DEFINE p_seq              LIKE xrcb_t.xrcbseq
   DEFINE p_docno            LIKE xrca_t.xrcadocno
   DEFINE p_comp             LIKE xrca_t.xrcacomp
   DEFINE p_debz005          LIKE debz_t.debz005       #160509-00004#34 add lujh
   DEFINE l_imaal003         LIKE imaal_t.imaal003
   DEFINE l_ooeg004          LIKE ooeg_t.ooeg004
   DEFINE l_imaal004         LIKE imaal_t.imaal004
   DEFINE l_xrcb019          LIKE xrcb_t.xrcb019
   DEFINE l_rtax001          LIKE rtax_t.rtax001
   DEFINE l_oodbl004         LIKE oodbl_t.oodbl004
   DEFINE l_oodb011          LIKE oodb_t.oodb011
   DEFINE l_xrcb021          LIKE xrcb_t.xrcb021
   DEFINE l_xrcbseq          LIKE xrcb_t.xrcbseq
   DEFINE l_ooie034          LIKE ooie_t.ooie034
   DEFINE l_ooie036          LIKE ooie_t.ooie036   #160509-00004#40 add lujh
   #160509-00004#34--add--str--lujh
   DEFINE l_glab005          LIKE glab_t.glab005
   DEFINE l_deaf026          LIKE deaf_t.deaf026     
   DEFINE l_xrcb103          LIKE xrcb_t.xrcb103
   DEFINE l_xrcb104          LIKE xrcb_t.xrcb104
   DEFINE l_xrcb105          LIKE xrcb_t.xrcb105
   DEFINE l_xrcb113          LIKE xrcb_t.xrcb113
   DEFINE l_xrcb114          LIKE xrcb_t.xrcb114
   DEFINE l_xrcb115          LIKE xrcb_t.xrcb115
   #160509-00004#34--add--end--lujh
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_tot_success      LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.chr1
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrca_t        RECORD LIKE xrca_t.*
   #DEFINE l_xrcb_t        RECORD LIKE xrcb_t.*
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138  #本位幣三應收金額
       END RECORD

   DEFINE l_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
       #161128-00061#3-----modify--end----------
   DEFINE l_debz             RECORD 
                             debzsite       LIKE debz_t.debzsite,
                             debz005        LIKE debz_t.debz005,
                             debz007        LIKE debz_t.debz007,
                             debz008        LIKE debz_t.debz008,
                             debz014        LIKE debz_t.debz014,
                             debz018        LIKE debz_t.debz018,
                             rtjf002        LIKE rtjf_t.rtjf002,
                             rtjf031        LIKE rtjf_t.rtjf031                           
                             END RECORD
   #STEP12 ---(S)---
   INITIALIZE l_xrca TO NULL
   INITIALIZE l_xrcb TO NULL
   INITIALIZE l_debz TO NULL
   
   LET l_tot_success = TRUE
   LET l_xrcbseq = p_seq
   LET l_flag = 'N'
   
   #161128-00061#3-----modify--begin----------
   #SELECT * INTO l_xrca.*
   SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
          xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,
          xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,
          xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,
          xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,
          xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,
          xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,
          xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,
          xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,
          xrca133,xrca134,xrca136,xrca137,xrca138 INTO l_xrca.*    
   #161128-00061#3-----modify--end----------
   FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = g_master.xrcald AND xrcadocno = p_docno
   
   FOREACH axrp136_debz018_5_curs USING p_site,p_debz005 INTO l_debz.*     #160509-00004#34 add p_debz005 lujh
    
      INITIALIZE l_xrcb TO NULL
    
      LET l_ooeg004 = NULL
      SELECT ooeg004 INTO l_ooeg004 FROM ooeg_t
       WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015
    
      SELECT imaal003,imaal004 INTO l_imaal003,l_imaal004 FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = l_debz.debz007 AND imaal002 = g_lang
    
      LET l_xrcb019 = NULL
      SELECT inaa110 INTO l_xrcb019 FROM inaa_t WHERE inaaent = g_enterprise
         AND inaasite = l_debz.debzsite
         AND inaa001  = l_debz.debz014
       
      #160509-00004#40--mark--str--lujh
      ##160509-00004#34--add--str--lujh    
      #LET l_deaf026 = ''
      #SELECT deaf026 INTO l_deaf026
      #  FROM axrp136_tmp 
      # WHERE deafsite = l_debz.debzsite
      # 
      #LET l_deaf026 = l_debz.debzsite
      ##160509-00004#34--add--end--lujh  
      #160509-00004#40--mark--end--lujh
    
      LET l_xrcb.xrcbent   = l_xrca.xrcaent
      LET l_xrcb.xrcbld    = l_xrca.xrcald
      LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
      LET l_xrcb.xrcbseq   = l_xrcbseq + 1
      LET l_xrcb.xrcbsite  = l_xrca.xrcasite
      LET l_xrcb.xrcborga  = l_debz.debzsite            
      LET l_xrcb.xrcblegl  = l_debz.debzsite
      LET l_xrcb.xrcb001   = '13'
      LET l_xrcb.xrcb002   = ''
      LET l_xrcb.xrcb003   = ''
      LET l_xrcb.xrcb004   = l_debz.debz007
      LET l_xrcb.xrcb005   = l_imaal003
      LET l_xrcb.xrcb006   = ''
      LET l_xrcb.xrcb007   = 1
      LET l_xrcb.xrcb008   = ''
      LET l_xrcb.xrcb009   = ''
      LET l_xrcb.xrcb010   = l_xrca.xrca015
      LET l_xrcb.xrcb011   = l_ooeg004
      LET l_xrcb.xrcb012 = l_debz.debz007
      LET l_xrcb.xrcb013   = ''
      LET l_xrcb.xrcb014   = ''
      LET l_xrcb.xrcb015   = ''
      LET l_xrcb.xrcb016   = ''
      LET l_xrcb.xrcb017   = ''
      LET l_xrcb.xrcb018   = l_debz.debz005
      LET l_xrcb.xrcb019   = l_xrcb019
      LET l_xrcb.xrcb020   = l_debz.debz008
      LET l_xrcb.xrcb052   = l_debz.rtjf002
      

      SELECT ooie034,ooie036 INTO l_ooie034,l_ooie036    #160509-00004#40 add l_ooie036 lujh
        FROM ooie_t
       WHERE ooieent = g_enterprise
         AND ooiesite = l_debz.debzsite
         AND ooie001 = l_xrcb.xrcb052

      #160509-00004#40--add--str--lujh
      IF l_ooie034 = 'N' AND l_ooie036 <> l_debz.debzsite THEN 
         CONTINUE FOREACH
      END IF
      #160509-00004#40--add--end--lujh
      
      #agli190往来科目
      SELECT glab009 INTO l_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise     #160509-00004#34 change glab008 to glab009
         AND glabld  = l_xrcb.xrcbld
         AND glab001 = '21'
         AND glab003 = l_xrcb.xrcb052

    
      LET l_xrcb.xrcb022   = 1
      LET l_xrcb.xrcb023   = 'N'
      LET l_xrcb.xrcb024   = ''
      LET l_xrcb.xrcb025   = ''
      LET l_xrcb.xrcb026   = ''
      LET l_xrcb.xrcb027   = ''   #流通待補欄位
      LET l_xrcb.xrcb028   = ''
      LET l_xrcb.xrcb029   = l_xrca.xrca035
      LET l_xrcb.xrcb030   = ''
      LET l_xrcb.xrcb031   = ''
      LET l_xrcb.xrcb032   = ''
      LET l_xrcb.xrcb033   = l_debz.debz018
      LET l_xrcb.xrcb034   = ''
      LET l_xrcb.xrcb035   = ''
      LET l_xrcb.xrcb036   = ''
      LET l_xrcb.xrcb038   = ''
      LET l_xrcb.xrcb039   = ''
      LET l_xrcb.xrcb040   = ''
      LET l_xrcb.xrcb041   = ''
      LET l_xrcb.xrcb042   = ''
      LET l_xrcb.xrcb043   = ''
      LET l_xrcb.xrcb044   = ''
      LET l_xrcb.xrcb045   = ''
      LET l_xrcb.xrcb046   = ''
      LET l_xrcb.xrcb047   = ''
      LET l_xrcb.xrcb048   = ''
      LET l_xrcb.xrcb049   = ''
      LET l_xrcb.xrcb050   = ''
      LET l_xrcb.xrcb051   = l_xrca.xrca014
      LET l_xrcb.xrcb100   = l_xrca.xrca100
      
      #160509-00004#34--add--str--lujh
      SELECT DISTINCT rtja102 INTO l_xrcb.xrcb053
        FROM rtja_t,rtjf_t
       WHERE rtjaent   = g_enterprise
         AND rtjaent   = rtjfent
         AND rtjadocno = rtjfdocno
         AND rtjadocdt = g_master.debz002
         AND rtjasite  = l_xrcb.xrcborga
         AND rtjastus  = 'S'
         AND rtjf002   = l_xrcb.xrcb052
         AND rtjf027 = l_xrcb.xrcb018
         
      LET l_xrcb.xrcb054 = l_xrcb.xrcb053
      #160509-00004#34--add--end--lujh
    
      CALL s_tax_chk(p_comp,l_xrcb.xrcb020)
         RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011
#      IF l_debz.debz007 = '93' OR l_debz.debz007 = '94' THEN
#         IF l_xrca.xrca013 = 'Y' THEN
#            LET l_xrcb.xrcb101   = l_debz.debz010   #20150720 Mod l_debz.debz012 --> l_debz.debz010
#         ELSE
#            LET l_xrcb.xrcb101   = l_debz.debz010 - l_debz.debz009   #20150720 Mod l_debz.debz012 --> l_debz.debz010
#         END IF
#      ELSE
#         IF l_xrca.xrca013 = 'Y' THEN
#            LET l_xrcb.xrcb101   = l_debz.debz012
#         ELSE
#            LET l_xrcb.xrcb101   = l_debz.debz012 - l_debz.debz009
#         END IF
#      END IF
      
      LET l_xrcb.xrcb101 = l_debz.rtjf031 
      LET l_xrcb.xrcb103 = l_debz.rtjf031 
      LET l_xrcb.xrcb104 = 0
      LET l_xrcb.xrcb105 = l_debz.rtjf031 
      LET l_xrcb.xrcb113 = l_debz.rtjf031 
      LET l_xrcb.xrcb114 = 0
      LET l_xrcb.xrcb115 = l_debz.rtjf031 
    
      #CALL s_tax_ins(l_xrca.xrcadocno,l_xrcb.xrcbseq,0,p_comp,
      #               l_xrcb.xrcb101 * l_xrcb.xrcb007,l_xrcb.xrcb020,
      #               l_xrcb.xrcb007,l_xrcb.xrcb100,l_xrca.xrca101,l_xrca.xrcald,l_xrca.xrca121,l_xrca.xrca131)
      #   RETURNING l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,
      #             l_xrcb.xrcb113,l_xrcb.xrcb114,l_xrcb.xrcb115,
      #             l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,
      #             l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135
    
#      IF l_sfin2021 = 'N' THEN
#         UPDATE xrcd_t SET xrcd009 = l_xrcb.xrcb021
#          WHERE xrcdent = g_enterprise
#            AND xrcddocno = l_xrca.xrcadocno
#            AND xrcdld = l_xrca.xrcald
#            AND xrcdseq = l_xrcb.xrcbseq
#      ELSE  
#         SELECT glab005 INTO l_xrcd009 FROM glab_t 
#          WHERE glabld = g_master.xrcald 
#            AND glabent = g_enterprise
#            AND glab002 = l_sfin2017       # 帳款類別
#            AND glab001 = '13'             # 應收帳務類型科目設定
#            AND glab003 = '8304_29'
#         UPDATE xrcd_t SET xrcd009 = l_xrcd009
#          WHERE xrcdent = g_enterprise
#            AND xrcddocno = l_xrca.xrcadocno
#            AND xrcdld = l_xrca.xrcald
#            AND xrcdseq = l_xrcb.xrcbseq
#      END IF
    
      LET l_xrcb.xrcb102   = l_xrca.xrca101
      LET l_xrcb.xrcb106   = 0
      LET l_xrcb.xrcb111   = l_debz.rtjf031
      LET l_xrcb.xrcb116   = 0
      LET l_xrcb.xrcb117   = 0
      LET l_xrcb.xrcb118   = 0
      LET l_xrcb.xrcb119   = 0
      #其他本位幣留下接口，暫不處理
      LET l_xrcb.xrcb121   = 0
      LET l_xrcb.xrcb126   = 0
      LET l_xrcb.xrcb131   = 0
      LET l_xrcb.xrcb136   = 0
      
      #160509-00004#34--add--str--lujh
      LET l_glab005 = ''
      SELECT glab005 INTO l_glab005
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = l_xrcb.xrcbld
         AND glab001 = '13'
         AND glab002 = '6736'
         AND glab003 = '14'
         
      SELECT xrcb103,xrcb104,xrcb105,xrcb113,xrcb114,xrcb115
        INTO l_xrcb103,l_xrcb104,l_xrcb105,
             l_xrcb113,l_xrcb114,l_xrcb115
        FROM xrcb_t
       WHERE xrcbent = g_enterprise
         AND xrcb021 = l_glab005
         AND xrcb052 = l_xrcb.xrcb052
         AND xrcb001 IN ('19','29') 
 
      IF cl_null(l_xrcb103) THEN LET l_xrcb103 = 0 END IF
      IF cl_null(l_xrcb104) THEN LET l_xrcb104 = 0 END IF
      IF cl_null(l_xrcb105) THEN LET l_xrcb105 = 0 END IF
      IF cl_null(l_xrcb113) THEN LET l_xrcb113 = 0 END IF
      IF cl_null(l_xrcb114) THEN LET l_xrcb114 = 0 END IF
      IF cl_null(l_xrcb115) THEN LET l_xrcb115 = 0 END IF
         
      LET l_xrcb.xrcb103 = l_xrcb.xrcb103 - l_xrcb103
      LET l_xrcb.xrcb104 = l_xrcb.xrcb103 - l_xrcb104
      LET l_xrcb.xrcb105 = l_xrcb.xrcb103 - l_xrcb105
      #160509-00004#34--add--end--lujh            
    
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
                         xrcb133,xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054)  #160509-00004#34 add xrcb053,xrcb054 lujh
                  VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                         l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                         l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                         l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                         l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                         l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                         l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                         l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                         l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                         l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                         l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                         l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                         l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                         l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136,l_xrcb.xrcb052,l_xrcb.xrcb053,
                         l_xrcb.xrcb054)   #160509-00004#34 add l_xrcb.xrcb053,l_xrcb.xrcb054 lujh
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xrca.xrcadocno
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_tot_success = FALSE
      ELSE
         LET l_flag = 'Y'
      END IF
    
      IF l_xrcb.xrcbseq = 1 THEN
         CALL s_tax_chk(p_comp,l_xrcb.xrcb020)
            RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011
    
         UPDATE xrca_t SET xrca011 = l_xrcb.xrcb020,
                           xrca012 = l_xrca.xrca012,
                           xrca013 = l_xrca.xrca013
          WHERE xrcaent = g_enterprise
            AND xrcadocno = l_xrca.xrcadocno
            AND xrcald    = l_xrca.xrcald
      END IF
    
      LET l_xrcbseq = l_xrcbseq + 1
    
      #STEP7 ---(S)---
      #20150720 Add ---(S)---
      IF l_debz.rtjf031 <> 0 AND (l_rtax001 = '93' OR l_rtax001 = '94') THEN
         INITIALIZE l_xrcb TO NULL
         LET l_xrcb.xrcb052   = l_debz.rtjf002
    
         SELECT glab005 INTO l_xrcb021 FROM glab_t 
          WHERE glabld = g_master.xrcald
            AND glabent = g_enterprise
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab002 = '6736'
            AND glab003 = '10'  #折扣
    
         LET l_xrcb.xrcbent   = l_xrca.xrcaent
         LET l_xrcb.xrcbld    = l_xrca.xrcald
         LET l_xrcb.xrcbdocno = l_xrca.xrcadocno
         LET l_xrcb.xrcbseq   = l_xrcbseq + 1
         LET l_xrcb.xrcbsite  = l_xrca.xrcasite
         LET l_xrcb.xrcborga  = l_debz.debzsite
         LET l_xrcb.xrcblegl  = l_xrca.xrcacomp
         IF l_debz.rtjf031 > 0 THEN
            LET l_xrcb.xrcb001   = '29'
            LET l_xrcb.xrcb022   = -1
         ELSE
            LET l_xrcb.xrcb001   = '19'
            LET l_xrcb.xrcb022   = 1
            LET l_debz.rtjf031 = l_debz.rtjf031 * -1
         END IF
         LET l_xrcb.xrcb002   = ''
         LET l_xrcb.xrcb003   = ''
         LET l_xrcb.xrcb004   = l_debz.debz007
         LET l_xrcb.xrcb005   = l_imaal003
         LET l_xrcb.xrcb006   = ''
         LET l_xrcb.xrcb007   = 1
         LET l_xrcb.xrcb008   = ''
         LET l_xrcb.xrcb009   = ''
         LET l_xrcb.xrcb010   = l_xrca.xrca015
         LET l_xrcb.xrcb011   = l_ooeg004
         LET l_xrcb.xrcb012   = l_debz.debz007
         LET l_xrcb.xrcb013   = ''
         LET l_xrcb.xrcb014   = ''
         LET l_xrcb.xrcb015   = ''
         LET l_xrcb.xrcb016   = ''
         LET l_xrcb.xrcb017   = ''
         LET l_xrcb.xrcb018   = l_debz.debz005
         LET l_xrcb.xrcb019   = l_xrcb019
         LET l_xrcb.xrcb020   = l_debz.debz008
         LET l_xrcb.xrcb021   = l_xrcb021
         LET l_xrcb.xrcb023   = 'N'
         LET l_xrcb.xrcb024   = ''
         LET l_xrcb.xrcb025   = ''
         LET l_xrcb.xrcb026   = ''
         LET l_xrcb.xrcb027   = ''   #流通待補欄位
         LET l_xrcb.xrcb028   = ''
         LET l_xrcb.xrcb029   = l_xrca.xrca035
         LET l_xrcb.xrcb030   = ''
         LET l_xrcb.xrcb031   = ''
         LET l_xrcb.xrcb032   = ''
         LET l_xrcb.xrcb033   = l_debz.debz018
         LET l_xrcb.xrcb034   = ''
         LET l_xrcb.xrcb035   = ''
         LET l_xrcb.xrcb036   = ''
         LET l_xrcb.xrcb038   = ''
         LET l_xrcb.xrcb039   = ''
         LET l_xrcb.xrcb040   = ''
         LET l_xrcb.xrcb041   = ''
         LET l_xrcb.xrcb042   = ''
         LET l_xrcb.xrcb043   = ''
         LET l_xrcb.xrcb044   = ''
         LET l_xrcb.xrcb045   = ''
         LET l_xrcb.xrcb046   = ''
         LET l_xrcb.xrcb047   = ''
         LET l_xrcb.xrcb048   = ''
         LET l_xrcb.xrcb049   = ''
         LET l_xrcb.xrcb050   = ''
         LET l_xrcb.xrcb051   = l_xrca.xrca014
         LET l_xrcb.xrcb100   = l_xrca.xrca100
         LET l_xrcb.xrcb101   = l_debz.rtjf031
         LET l_xrcb.xrcb102   = l_xrca.xrca101
         LET l_xrcb.xrcb103   = l_debz.rtjf031
         LET l_xrcb.xrcb104   = 0
         LET l_xrcb.xrcb105   = l_debz.rtjf031
         LET l_xrcb.xrcb106   = 0
         LET l_xrcb.xrcb111   = l_debz.rtjf031
         LET l_xrcb.xrcb113   = l_debz.rtjf031
         LET l_xrcb.xrcb114   = 0
         LET l_xrcb.xrcb115   = l_debz.rtjf031
         LET l_xrcb.xrcb116   = 0
         LET l_xrcb.xrcb117   = 0
         LET l_xrcb.xrcb118   = 0
         LET l_xrcb.xrcb119   = 0
         LET l_xrcb.xrcb123   = l_debz.rtjf031
         LET l_xrcb.xrcb124   = 0
         LET l_xrcb.xrcb125   = l_debz.rtjf031
         LET l_xrcb.xrcb133   = l_debz.rtjf031
         LET l_xrcb.xrcb134   = 0
         LET l_xrcb.xrcb135   = l_debz.rtjf031
         #其他本位幣留下接口，暫不處理
         LET l_xrcb.xrcb121   = 0
         LET l_xrcb.xrcb126   = 0
         LET l_xrcb.xrcb131   = 0
         LET l_xrcb.xrcb136   = 0
    
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
                            xrcb133,xrcb134,xrcb135,xrcb136)
                     VALUES(l_xrcb.xrcbent,l_xrcb.xrcbld,l_xrcb.xrcbdocno,l_xrcb.xrcbseq,l_xrcb.xrcbsite,l_xrcb.xrcborga,l_xrcb.xrcblegl,
                            l_xrcb.xrcb001,l_xrcb.xrcb002,l_xrcb.xrcb003,l_xrcb.xrcb004,l_xrcb.xrcb005,l_xrcb.xrcb006,
                            l_xrcb.xrcb007,l_xrcb.xrcb008,l_xrcb.xrcb009,l_xrcb.xrcb010,l_xrcb.xrcb011,l_xrcb.xrcb012,
                            l_xrcb.xrcb013,l_xrcb.xrcb014,l_xrcb.xrcb015,l_xrcb.xrcb016,l_xrcb.xrcb017,l_xrcb.xrcb018,
                            l_xrcb.xrcb019,l_xrcb.xrcb020,l_xrcb.xrcb021,l_xrcb.xrcb022,l_xrcb.xrcb023,l_xrcb.xrcb024,
                            l_xrcb.xrcb025,l_xrcb.xrcb026,l_xrcb.xrcb027,l_xrcb.xrcb028,l_xrcb.xrcb029,l_xrcb.xrcb030,
                            l_xrcb.xrcb031,l_xrcb.xrcb032,l_xrcb.xrcb033,l_xrcb.xrcb034,l_xrcb.xrcb035,l_xrcb.xrcb036,
                            l_xrcb.xrcb037,l_xrcb.xrcb038,l_xrcb.xrcb039,l_xrcb.xrcb040,l_xrcb.xrcb041,l_xrcb.xrcb042,
                            l_xrcb.xrcb043,l_xrcb.xrcb044,l_xrcb.xrcb045,l_xrcb.xrcb046,l_xrcb.xrcb047,l_xrcb.xrcb048,
                            l_xrcb.xrcb049,l_xrcb.xrcb050,l_xrcb.xrcb051,l_xrcb.xrcb100,l_xrcb.xrcb101,l_xrcb.xrcb102,
                            l_xrcb.xrcb103,l_xrcb.xrcb104,l_xrcb.xrcb105,l_xrcb.xrcb106,l_xrcb.xrcb111,l_xrcb.xrcb113,
                            l_xrcb.xrcb114,l_xrcb.xrcb115,l_xrcb.xrcb116,l_xrcb.xrcb117,l_xrcb.xrcb118,l_xrcb.xrcb119,
                            l_xrcb.xrcb121,l_xrcb.xrcb123,l_xrcb.xrcb124,l_xrcb.xrcb125,l_xrcb.xrcb126,l_xrcb.xrcb131,
                            l_xrcb.xrcb133,l_xrcb.xrcb134,l_xrcb.xrcb135,l_xrcb.xrcb136)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_tot_success = FALSE
         ELSE
            LET l_flag = 'Y'
         END IF
    
         LET l_xrcbseq = l_xrcbseq + 1
    
      END IF
      #20150720 Add ---(E)---
      #STEP7 ---(E)---
    
   END FOREACH
   
   RETURN l_tot_success,l_xrcbseq,l_flag
   #STEP12 ---(E)---
END FUNCTION

#end add-point
 
{</section>}
 
