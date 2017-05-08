#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-01-08 16:33:55), PR版次:0008(2016-12-01 15:28:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000062
#+ Filename...: axrp200
#+ Description: 結算應收帳款批次產生作業
#+ Creator....: 01727(2015-05-12 14:55:35)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp200.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151201-00002#5  2016/01/06 By 01727    天河程序回收產品,1.費用單區分是否含發票用不同的單別產生
#                                                       2.增加內部結算
#160318-00025#42 2016/04/25 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00005#1  2016/05/06 By 01531    取法人據點之交易對象檔,若取不到法人據點時, 取 據點代碼='ALL'
#161021-00050#3  2016/10/24 By 08729    處理組織開窗
#161123-00048#4  2016/11/25 By 08729    開窗增加過濾據點
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
   glav002 LIKE glav_t.glav002, 
   glav006 LIKE glav_t.glav006, 
   b_check5 LIKE type_t.chr500, 
   b_check1 LIKE type_t.chr500, 
   b_check3 LIKE type_t.chr500, 
   b_check2 LIKE type_t.chr500, 
   b_check4 LIKE type_t.chr500, 
   b_comb LIKE type_t.chr500, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   source LIKE type_t.chr500, 
   xrca007 LIKE xrca_t.xrca007, 
   xrca007_desc LIKE type_t.chr80, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocno_desc LIKE type_t.chr80, 
   xrca011 LIKE xrca_t.xrca011, 
   xrca011_desc LIKE type_t.chr80, 
   xrca003 LIKE xrca_t.xrca003, 
   xrca003_desc LIKE type_t.chr80, 
   xrca008 LIKE xrca_t.xrca008, 
   xrca008_desc LIKE type_t.chr80, 
   b_comb1 LIKE type_t.chr500, 
   stbesite LIKE stbe_t.stbesite, 
   stbd021 LIKE stbd_t.stbd021, 
   stbedocno LIKE stbe_t.stbedocno, 
   stbd022 LIKE stbd_t.stbd022, 
   stbd002 LIKE stbd_t.stbd002, 
   stbd001 LIKE stbd_t.stbd001, 
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
DEFINE g_xrca           type_xrca
DEFINE g_xrcb           type_xrcb

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列

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
 
{<section id="axrp200.main" >}
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
  #CALL axrp200_def()    #151201-00002#5 Mark
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
      LET g_master.b_comb = g_argv[06]
      LET g_master.xrcadocno = g_argv[07]
      #LET g_master.xrcbdocno = g_argv[08]   #151201-00002#61 mark lujh
      LET g_master.source = g_argv[08]       #151201-00002#61 add lujh
      LET g_master.xrcadocdt = g_argv[09]
      LET g_master.wc = "stbedocno = '",g_argv[10],"'"
      LET g_master.b_check5 = 'Y'
      LET g_master.b_check1 = 'N'
      LET g_master.b_check2 = 'N'
      LET g_master.b_check3 = 'N'
      LET g_master.b_check4 = 'N'
      LET g_master.xrcadocdt = g_today
      LET g_master.b_comb1 = '2'    
      LET g_master.xrca003 = g_user 
     #151201-00002#5 Add  ---(E)---
      #end add-point
      CALL axrp200_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp200 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp200_init()
 
      #進入選單 Menu (="N")
      CALL axrp200_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp200
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp200.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrp200_init()
 
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
 
{<section id="axrp200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp200_ui_dialog()
 
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
         INPUT BY NAME g_master.b_check5,g_master.b_check1,g_master.b_check3,g_master.b_check2,g_master.b_check4, 
             g_master.b_comb,g_master.xrcadocdt,g_master.source,g_master.xrca007,g_master.xrcadocno, 
             g_master.xrca011,g_master.xrca003,g_master.xrca008,g_master.b_comb1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check5
            #add-point:BEFORE FIELD b_check5 name="input.b.b_check5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check5
            
            #add-point:AFTER FIELD b_check5 name="input.a.b_check5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check5
            #add-point:ON CHANGE b_check5 name="input.g.b_check5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check1
            #add-point:BEFORE FIELD b_check1 name="input.b.b_check1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check1
            
            #add-point:AFTER FIELD b_check1 name="input.a.b_check1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check1
            #add-point:ON CHANGE b_check1 name="input.g.b_check1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check3
            #add-point:BEFORE FIELD b_check3 name="input.b.b_check3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check3
            
            #add-point:AFTER FIELD b_check3 name="input.a.b_check3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check3
            #add-point:ON CHANGE b_check3 name="input.g.b_check3"
            
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
         BEFORE FIELD b_check4
            #add-point:BEFORE FIELD b_check4 name="input.b.b_check4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check4
            
            #add-point:AFTER FIELD b_check4 name="input.a.b_check4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check4
            #add-point:ON CHANGE b_check4 name="input.g.b_check4"
            
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
           #151201-00002#5 Add  ---(S)---
            IF NOT cl_null(g_master.b_comb) THEN
               IF g_master.b_comb = '1' THEN
                  CALL cl_set_comp_entry('xrcadocno',TRUE)
                  CALL cl_set_comp_visible('stbd001,stbd022',TRUE)
               ELSE
                  CALL cl_set_comp_entry('xrcadocno',FALSE)
                  CALL cl_set_comp_visible('stbd001,stbd022',FALSE)
               END IF
            END IF
           #151201-00002#5 Add  ---(E)---
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
               #150210-00011(1)--20150330--add--
               CALL s_get_accdate(l_glaa003,g_master.xrcadocdt,'','') 
               RETURNING l_flag1,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                         g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
               #150210-00011(1)--20150330--add--
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocdt
            #add-point:ON CHANGE xrcadocdt name="input.g.xrcadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD source
            #add-point:BEFORE FIELD source name="input.b.source"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD source
            
            #add-point:AFTER FIELD source name="input.a.source"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE source
            #add-point:ON CHANGE source name="input.g.source"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
           #151201-00002#5 Mark ---(S)---
           #IF NOT cl_null(g_master.xrcadocno) THEN
           #   INITIALIZE g_chkparam.* TO NULL
           #   LET g_chkparam.arg1 = l_glaa024
           #   LET g_chkparam.arg2 = g_master.xrcadocno
           #   IF NOT s_aooi200_fin_chk_slip(g_master.xrcald,l_glaa024,g_master.xrcadocno,'axrt210') THEN
           #      LET g_master.xrcadocno = ''
           #      NEXT FIELD CURRENT
           #   END IF
           #END IF
           #151201-00002#5 Mark ---(E)---
           #151201-00002#5 Add  ---(S)---
            #帳款單別
            LET g_master.xrcadocno_desc = ''
            DISPLAY BY NAME g_master.xrcadocno_desc
            IF NOT cl_null(g_master.xrcadocno) THEN 
               CALL s_aooi200_fin_chk_slip(g_master.xrcald,l_glaa024,g_master.xrcadocno,'axrt210') RETURNING l_success
               IF l_success = FALSE THEN 
                  LET g_master.xrcadocno = ''
                  NEXT FIELD xrcadocno
               END IF
               CALL s_fin_get_doc_para(g_master.xrcald,'',g_master.xrcadocno,'D-FIN-1004') RETURNING l_dfin1004
               CALL s_fin_get_doc_para(g_master.xrcald,'',g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
               #151201-00002#61--mark--str--lujh
               #IF l_dfin1004 <> 'Y' THEN 
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.extend = g_master.xrcadocno
               #   LET g_errparam.code   = "aap-00412"
               #   LET g_errparam.popup  = TRUE
               #   CALL cl_err()
               #   LET g_master.xrcadocno = ''
               #   NEXT FIELD xrcadocno
               #END IF
               #151201-00002#61--mark--end--lujh
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.xrcadocno)RETURNING g_master.xrcadocno_desc
            DISPLAY BY NAME g_master.xrcadocno_desc
           #151201-00002#5 Add  ---(E)---
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
         AFTER FIELD xrca011
            
            #add-point:AFTER FIELD xrca011 name="input.a.xrca011"
            IF NOT cl_null(g_master.xrca011) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_glaacomp
               LET g_chkparam.arg2 = g_master.xrca011
               #160318-00025#42  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
               #160318-00025#42  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_oodb002") THEN
                  LET g_master.xrca011 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca011
            #add-point:BEFORE FIELD xrca011 name="input.b.xrca011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca011
            #add-point:ON CHANGE xrca011 name="input.g.xrca011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca003
            
            #add-point:AFTER FIELD xrca003 name="input.a.xrca003"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca003
            #add-point:BEFORE FIELD xrca003 name="input.b.xrca003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca003
            #add-point:ON CHANGE xrca003 name="input.g.xrca003"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_comb1
            #add-point:BEFORE FIELD b_comb1 name="input.b.b_comb1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_comb1
            
            #add-point:AFTER FIELD b_comb1 name="input.a.b_comb1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_comb1
            #add-point:ON CHANGE b_comb1 name="input.g.b_comb1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.b_check5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check5
            #add-point:ON ACTION controlp INFIELD b_check5 name="input.c.b_check5"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check1
            #add-point:ON ACTION controlp INFIELD b_check1 name="input.c.b_check1"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check3
            #add-point:ON ACTION controlp INFIELD b_check3 name="input.c.b_check3"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check2
            #add-point:ON ACTION controlp INFIELD b_check2 name="input.c.b_check2"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check4
            #add-point:ON ACTION controlp INFIELD b_check4 name="input.c.b_check4"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_comb
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb
            #add-point:ON ACTION controlp INFIELD b_comb name="input.c.b_comb"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocdt
            #add-point:ON ACTION controlp INFIELD xrcadocdt name="input.c.xrcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.source
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD source
            #add-point:ON ACTION controlp INFIELD source name="input.c.source"
            
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
            LET g_qryparam.where= " oocq002 IN (SELECT glab002 FROM glab_t WHERE glab001 = '13' AND glabld = '",g_master.xrcald,"' AND glabent = ",g_enterprise,")" #161123-00048#4-add
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_master.xrca007 = g_qryparam.return1              
            #LET g_master.oocq002 = g_qryparam.return2 
            DISPLAY g_master.xrca007 TO xrca007              #
            #DISPLAY g_master.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD xrca007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
           #151201-00002#5 Mark ---(S)---
           ##開窗i段
           #INITIALIZE g_qryparam.* TO NULL
           #LET g_qryparam.state = 'i'
           #LET g_qryparam.reqry = FALSE
           #LET g_qryparam.default1 = g_master.xrcadocno             #給予default值
           ##給予arg
           #SELECT ooef004 INTO l_ooef004 from ooef_t where ooefent = g_enterprise AND ooef001 = l_glaacomp
           #SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise
           #   AND glaald = g_master.xrcald
           #LET g_qryparam.arg1 = l_glaa024
           #LET g_qryparam.arg2 = 'axrt210'
           #CALL q_ooba002_1()                                #呼叫開窗
           #LET g_master.xrcadocno = g_qryparam.return1              
           #DISPLAY g_master.xrcadocno TO xrcadocno              #
           #NEXT FIELD xrcadocno                          #返回原欄位
           #151201-00002#5 Mark ---(E)---
           #151201-00002#5 Add  ---(S)---
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
            LET g_qryparam.arg2 = 'axrt210'
            #151201-00002#61--mark--str--lujh
            #LET g_qryparam.arg3 = 'D-FIN-1004'   #E-FINC1001
            #LET g_qryparam.arg4 = "'Y'"
            #CALL q_ooba002_11()                                #呼叫開窗
            #151201-00002#61--mark--end--lujh
            
            CALL q_ooba002_1()
            LET g_master.xrcadocno = g_qryparam.return1              
            DISPLAY g_master.xrcadocno TO xrcadocno              #
            CALL s_aooi200_fin_get_slip_desc(g_master.xrcadocno)RETURNING g_master.xrcadocno_desc
            NEXT FIELD xrcadocno  
           #151201-00002#5 Add  ---(E)---


            #END add-point
 
 
         #Ctrlp:input.c.xrca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca011
            #add-point:ON ACTION controlp INFIELD xrca011 name="input.c.xrca011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrca011             #給予default值
            LET g_qryparam.default2 = "" #g_master.oodb002 #稅別代碼
            LET g_qryparam.default3 = "" #g_master.oodb005 #含稅否
            LET g_qryparam.default4 = "" #g_master.oodb006 #稅率

            LET g_qryparam.where = " oodb004 ='1' " 

            #給予arg
            SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_glaacomp
            LET g_qryparam.arg1 = l_ooef019

            CALL q_oodb002_5()                                #呼叫開窗

            LET g_master.xrca011 = g_qryparam.return1              
            #LET g_master.oodb002 = g_qryparam.return2 
            #LET g_master.oodb005 = g_qryparam.return3 
            #LET g_master.oodb006 = g_qryparam.return4 
            DISPLAY g_master.xrca011 TO xrca011              #
            #DISPLAY g_master.oodb002 TO oodb002 #稅別代碼
            #DISPLAY g_master.oodb005 TO oodb005 #含稅否
            #DISPLAY g_master.oodb006 TO oodb006 #稅率
            NEXT FIELD xrca011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca003
            #add-point:ON ACTION controlp INFIELD xrca003 name="input.c.xrca003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrca003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_master.xrca003 = g_qryparam.return1              

            DISPLAY g_master.xrca003 TO xrca003              #

            NEXT FIELD xrca003                          #返回原欄位


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
 
 
         #Ctrlp:input.c.b_comb1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb1
            #add-point:ON ACTION controlp INFIELD b_comb1 name="input.c.b_comb1"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stbesite,stbd021,stbedocno,stbd022,stbd002,stbd001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stbesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbesite
            #add-point:ON ACTION controlp INFIELD stbesite name="construct.c.stbesite"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL s_fin_account_center_sons_query('12',g_master.xrcasite,g_today,'')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where    = "ooef212 = 'Y' AND ooef001 IN ",l_origin_str CLIPPED,""
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbesite  #顯示到畫面上
            NEXT FIELD stbesite                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbesite
            #add-point:BEFORE FIELD stbesite name="construct.b.stbesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbesite
            
            #add-point:AFTER FIELD stbesite name="construct.a.stbesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd021
            #add-point:ON ACTION controlp INFIELD stbd021 name="construct.c.stbd021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbd021  #顯示到畫面上
            NEXT FIELD stbd021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd021
            #add-point:BEFORE FIELD stbd021 name="construct.b.stbd021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd021
            
            #add-point:AFTER FIELD stbd021 name="construct.a.stbd021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbedocno
            #add-point:BEFORE FIELD stbedocno name="construct.b.stbedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbedocno
            
            #add-point:AFTER FIELD stbedocno name="construct.a.stbedocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbedocno
            #add-point:ON ACTION controlp INFIELD stbedocno name="construct.c.stbedocno"
           #151201-00002#5 Mark ---(S)---
           ##開窗c段
           #INITIALIZE g_qryparam.* TO NULL
           #LET g_qryparam.state = 'c' 
           #LET g_qryparam.reqry = FALSE
           #CALL s_fin_account_center_sons_query('12',g_master.xrcasite,g_today,'')
           #CALL s_fin_account_center_comp_str()RETURNING l_origin_str
           #IF cl_null(l_origin_str) THEN
           #   LET l_origin_str = g_master.xrcasite
           #END IF
           #CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
           #LET g_qryparam.where    = " stbesite IN ",l_origin_str CLIPPED,"",
           #                          " AND stbe024 = 'Y'",
           #                          " AND stbe025 = 'N'",
           #                          " AND (stbe021 IS NULL OR stbe021 < stbe016)",
           #                          " AND TO_CHAR(stbddocdt,'YYYY') = ",g_master.glav002,
           #                          " AND TO_CHAR(stbddocdt,'MM') = ",g_master.glav006
           #CALL q_stbddocno_1()                           #呼叫開窗
           #DISPLAY g_qryparam.return1 TO stbedocno  #顯示到畫面上
           #NEXT FIELD stbedocno                     #返回原欄位
           #151201-00002#5 Mark ---(E)---
           #151201-00002#5 Add  ---(S)---
           #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF g_master.b_comb = '1' THEN
               CALL s_fin_account_center_sons_query('12',g_master.xrcasite,g_today,'')
               CALL s_fin_account_center_sons_str()RETURNING l_origin_str
               IF cl_null(l_origin_str) THEN
                  LET l_origin_str = g_master.xrcasite
               END IF
               CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where    = " stbesite IN ",l_origin_str CLIPPED,"",
                                         " AND stbe024 = 'Y'",
                                         " AND stbe025 = 'N'",
                                         " AND (stbe021 IS NULL OR stbe021 <> stbe016)",
                                         " AND TO_CHAR(stbddocdt,'YYYY') = ",g_master.glav002,
                                         " AND TO_CHAR(stbddocdt,'MM') = ",g_master.glav006
               #161123-00048#4-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaaent = stbdent ",
                                                          "                AND pmaa001 = stbd046 )"
               END IF
               #161123-00048#4-add(e)                          
               CALL q_stbddocno_1()                           #呼叫開窗
            ELSE
               SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaald = g_master.xrcald
               LET g_qryparam.where = "stdh026 = '",l_glaacomp,"' AND stdh027 = '2'"
               CALL q_stdgdocno_1()                           #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO stbedocno  #顯示到畫面上
            NEXT FIELD stbedocno                     #返回原欄位
           #151201-00002#5 Add  ---(E)---
            #END add-point
 
 
         #Ctrlp:construct.c.stbd022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd022
            #add-point:ON ACTION controlp INFIELD stbd022 name="construct.c.stbd022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbd022  #顯示到畫面上
            NEXT FIELD stbd022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd022
            #add-point:BEFORE FIELD stbd022 name="construct.b.stbd022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd022
            
            #add-point:AFTER FIELD stbd022 name="construct.a.stbd022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd002
            #add-point:ON ACTION controlp INFIELD stbd002 name="construct.c.stbd002"
            #應用 a08 樣板自動產生(Version:2)
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
            DISPLAY g_qryparam.return1 TO stbd002  #顯示到畫面上
            NEXT FIELD stbd002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd002
            #add-point:BEFORE FIELD stbd002 name="construct.b.stbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd002
            
            #add-point:AFTER FIELD stbd002 name="construct.a.stbd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd001
            #add-point:ON ACTION controlp INFIELD stbd001 name="construct.c.stbd001"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stan001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbd001  #顯示到畫面上
            NEXT FIELD stbd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd001
            #add-point:BEFORE FIELD stbd001 name="construct.b.stbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd001
            
            #add-point:AFTER FIELD stbd001 name="construct.a.stbd001"
            
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
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_master.xrcald_desc = ''
               END IF
               SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#4-add

            ON ACTION controlp INFIELD xrcasite
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrcasite             #給予default值
               LET g_qryparam.where = " ooef201 = 'Y' "

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
               CALL axrp200_get_ooef001_wc(ls_wc) RETURNING ls_wc  
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrcald             #給予default值
               IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
               ELSE
                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
               END IF
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
            CALL axrp200_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL axrp200_def()
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
            CALL axrp200_def()
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
         CALL axrp200_init()
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
                 CALL axrp200_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrp200_transfer_argv(ls_js)
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
 
{<section id="axrp200.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrp200_transfer_argv(ls_js)
 
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
 
{<section id="axrp200.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrp200_process(ls_js)
 
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
#  DECLARE axrp200_process_cs CURSOR FROM ls_sql
#  FOREACH axrp200_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"

     #CALL axrp200_get_ar()   #151201-00002#5 Mark
     #151201-00002#5 Add  ---(S)---
      IF g_master.b_comb = '1' THEN
         CALL axrp200_get_ar()
      ELSE
         CALL axrp200_get_ar1()
      END IF
     #151201-00002#5 Add  ---(E)---
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

     #CALL axrp200_get_data()
     #
     #IF g_success = 'N' THEN
     #   CALL cl_err_collect_show()
     #   DROP TABLE axrp200_xmdk_tmp
     #   #清空進度條
     #   DISPLAY '' ,0 TO stagenow,stagecomplete
     #   DROP TABLE axrp131_xmdk_tmp
     #   RETURN
     #   RETURN
     #END IF

      CALL s_axrt300_create_tmp()

      CALL s_transaction_begin()

      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp200' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step2'
      CALL cl_progress_no_window_ing(l_gzzd005)
     #CALL axrp200_get_ar()   #151201-00002#5 Mark
     #151201-00002#5 Add  ---(S)---
      IF g_master.b_comb = '1' THEN
         CALL axrp200_get_ar()
      ELSE
         CALL axrp200_get_ar1()
      END IF
     #151201-00002#5 Add  ---(E)---

      DROP TABLE axrp200_xmdk_tmp

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
   CALL axrp200_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp200.get_buffer" >}
PRIVATE FUNCTION axrp200_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.b_check5 = p_dialog.getFieldBuffer('b_check5')
   LET g_master.b_check1 = p_dialog.getFieldBuffer('b_check1')
   LET g_master.b_check3 = p_dialog.getFieldBuffer('b_check3')
   LET g_master.b_check2 = p_dialog.getFieldBuffer('b_check2')
   LET g_master.b_check4 = p_dialog.getFieldBuffer('b_check4')
   LET g_master.b_comb = p_dialog.getFieldBuffer('b_comb')
   LET g_master.xrcadocdt = p_dialog.getFieldBuffer('xrcadocdt')
   LET g_master.source = p_dialog.getFieldBuffer('source')
   LET g_master.xrca007 = p_dialog.getFieldBuffer('xrca007')
   LET g_master.xrcadocno = p_dialog.getFieldBuffer('xrcadocno')
   LET g_master.xrca011 = p_dialog.getFieldBuffer('xrca011')
   LET g_master.xrca003 = p_dialog.getFieldBuffer('xrca003')
   LET g_master.xrca008 = p_dialog.getFieldBuffer('xrca008')
   LET g_master.b_comb1 = p_dialog.getFieldBuffer('b_comb1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrp200.msgcentre_notify" >}
PRIVATE FUNCTION axrp200_msgcentre_notify()
 
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
 
{<section id="axrp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 給帳務中心、帳套賦默認值
# Memo...........:
# Usage..........: CALL axrp200_def()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp200_def()
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

   LET g_master.xrca003 = g_user

  #151201-00002#5 Add  ---(S)---
   LET g_master.b_comb = '1'
   CALL cl_set_comp_entry('xrcadocno',TRUE)
   CALL cl_set_comp_visible('stbd001,stbd022,xrcadocno',TRUE)
  #151201-00002#5 Add  ---(E)---
  
   LET g_master.source = '1'     #151201-00002#61 add lujh 

   IF cl_null(g_master.b_comb1)  THEN LET g_master.b_comb1 = '2'  END IF
   IF cl_null(g_master.b_check1) THEN LET g_master.b_check1 = 'N' END IF
   IF cl_null(g_master.b_check2) THEN LET g_master.b_check2 = 'N' END IF
   IF cl_null(g_master.b_check3) THEN LET g_master.b_check3 = 'N' END IF
   IF cl_null(g_master.b_check4) THEN LET g_master.b_check4 = 'N' END IF
   IF cl_null(g_master.b_check5) THEN LET g_master.b_check5 = 'Y' END IF
   DISPLAY BY NAME g_master.xrcadocdt,g_master.glav002,g_master.glav006,g_master.b_comb1,
                   g_master.b_check1,g_master.b_check2,g_master.b_check3,
                   g_master.b_check4,g_master.b_check5

END FUNCTION
################################################################################
# Descriptions...: 依據客戶編號獲取默認值
# Memo...........:
# Usage..........: CALL axrp200_xrca004_ref()
#                  RETURNING r_xrca.*
# Input parameter: 
# Return code....: r_xrca         返回默认值
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp200_xrca004_ref()
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
  #SELECT * INTO l_ooib.* FROM ooib_t WHERE ooibent = g_enterprise AND ooib001 = '2' AND ooib002 = r_xrca.xrca008
  #CALL s_fin_date_ar_receivable(g_xrca.xrcasite,g_xrca.xrca004,r_xrca.xrca008,g_xrca.xrcadocdt,
  #  g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') RETURNING l_success,r_xrca.xrca009,r_xrca.xrca010
   
   #STEP3.帳款類別
   SELECT pmab105 INTO r_xrca.xrca007 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp

  #151201-00002#5 Add  ---(S)---
   IF cl_null(r_xrca.xrca007) THEN 
      CALL cl_get_para(g_enterprise,g_xrca.xrcacomp,'S-FIN-8001') RETURNING l_sfin8001
      CALL cl_get_para(g_enterprise,g_xrca.xrcacomp,'S-FIN-8002') RETURNING l_sfin8002
      #经营方式
      SELECT pmaa204 INTO l_pmaa204 
        FROM pmaa_t
       WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004
       
      IF l_pmaa204 = '1' THEN 
         LET r_xrca.xrca007 = l_sfin8001
      ELSE
         LET r_xrca.xrca007 = l_sfin8002
      END IF
   END IF
  #151201-00002#5 Add  ---(E)---

   #STEP4.業務人員/業務部門
   SELECT pmab081 INTO r_xrca.xrca014 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   SELECT ooag003 INTO r_xrca.xrca015 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = r_xrca.xrca014
   
   #STEP5.稅別/含稅否/稅率
   SELECT pmab084 INTO r_xrca.xrca011 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #STEP6.慣用幣別/匯率
   LET r_xrca.xrca100 = l_glaa001
   #計算各個本位筆匯率
   CASE g_master.b_comb1
      WHEN '2'  #依立帳日匯率(aooi160)
          CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,l_glaa001,0,l_glaa025)
               RETURNING r_xrca.xrca101
      WHEN '3'  #依立帳日月平均匯率(aooi170)
          CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,l_glaa001,0,l_glaa025)
               RETURNING g_sub_success,g_errno,r_xrca.xrca101
   END CASE

  #CALL s_axrt300_get_exrate(g_xrca.xrcadocdt,g_xrca.xrcald,g_xrca.xrcacomp,r_xrca.xrca100)
  #   RETURNING l_success,r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
   
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
   SELECT pmab089 INTO r_xrca.xrca058 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #SETP11.客戶分類
   SELECT pmaa090 INTO r_xrca.xrca006 FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004 

   RETURN r_xrca.*

END FUNCTION

################################################################################
# Descriptions...: 產生應收單據
# Memo...........:
# Usage..........: CALL axrp200_get_ar()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp200_get_ar()
   DEFINE l_sql         STRING
   DEFINE l_origin_str  STRING
   DEFINE l_xrca        RECORD
          xrca005       LIKE xrca_t.xrca005,
          xrca006       LIKE xrca_t.xrca006,
          xrca007       LIKE xrca_t.xrca007,
          xrca008       LIKE xrca_t.xrca008,
          xrca009       LIKE xrca_t.xrca009,
          xrca010       LIKE xrca_t.xrca010,
          xrca011       LIKE xrca_t.xrca011,
          xrca014       LIKE xrca_t.xrca014,
          xrca015       LIKE xrca_t.xrca015,
          xrca046       LIKE xrca_t.xrca046,
          xrca058       LIKE xrca_t.xrca058,
          xrca061       LIKE xrca_t.xrca061,
          xrca100       LIKE xrca_t.xrca100,
          xrca101       LIKE xrca_t.xrca101,
          xrca121       LIKE xrca_t.xrca121,
          xrca131       LIKE xrca_t.xrca131
                        END RECORD
   DEFINE l_stbd        DYNAMIC ARRAY OF RECORD
             stbddocno  LIKE stbd_t.stbddocno,
             stbdsite   LIKE stbd_t.stbdsite,
             stbd001    LIKE stbd_t.stbd001,
             stbd002    LIKE stbd_t.stbd002,
             stbd003    LIKE stbd_t.stbd003,
             stbd021    LIKE stbd_t.stbd021,
             stbd022    LIKE stbd_t.stbd022,
             stbd038    LIKE stbd_t.stbd038,
             stbd042  LIKE stbd_t.stbd042   #151201-00002#5 Add
                        END RECORD
   DEFINE l_stbe        RECORD
             stbedocno  LIKE stbe_t.stbedocno,
             stbeseq    LIKE stbe_t.stbeseq,
             stbesite   LIKE stbe_t.stbesite,
             stbecomp   LIKE stbe_t.stbecomp,
             stbe002    LIKE stbe_t.stbe002,
             stbe003    LIKE stbe_t.stbe003,
             stbe005    LIKE stbe_t.stbe005,
             stbe009    LIKE stbe_t.stbe009,
             stbe011    LIKE stbe_t.stbe011,
             stbe016    LIKE stbe_t.stbe016,
             stbe019    LIKE stbe_t.stbe019,
             stbe020    LIKE stbe_t.stbe020
                        END RECORD
   DEFINE l_success     LIKE type_t.num5
   DEFINE t_success     LIKE type_t.chr1    #151201-00002#5 Add
   DEFINE l_tot_success LIKE type_t.num5
   DEFINE l_ac          LIKE type_t.num5
   DEFINE l_glaa001     LIKE glaa_t.glaa001
   DEFINE l_glaa002     LIKE glaa_t.glaa002
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_glaa016     LIKE glaa_t.glaa016
   DEFINE l_glaa020     LIKE glaa_t.glaa020
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_glaa025     LIKE glaa_t.glaa025
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   DEFINE l_glaa121     LIKE glaa_t.glaa121
   DEFINE l_glab005     LIKE glab_t.glab005
   DEFINE l_xrca035     LIKE xrca_t.xrca035
   DEFINE l_xrca036     LIKE xrca_t.xrca036
   DEFINE l_stbddocno   LIKE stbd_t.stbddocno
   DEFINE l_xrcadocno   LIKE xrca_t.xrcadocno
   DEFINE l_oodbl004    LIKE oodbl_t.oodbl004
   DEFINE l_oodb011     LIKE oodb_t.oodb011
   DEFINE l_sfin2017    LIKE xrca_t.xrca007
   DEFINE l_dfin0030    LIKE type_t.chr1
   DEFINE l_start_no    LIKE xrca_t.xrcadocno
   DEFINE l_end_no      LIKE xrca_t.xrcadocno
   DEFINE l_stan006     LIKE stan_t.stan006
   DEFINE l_stan007     LIKE stan_t.stan007
   DEFINE l_stan008     LIKE stan_t.stan008
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003
   DEFINE l_oodb005     LIKE oodb_t.oodb005
   DEFINE l_oodb006     LIKE oodb_t.oodb006
   DEFINE l_diff        LIKE xrcb_t.xrcb103
   DEFINE l_diff1       LIKE xrcb_t.xrcb103
   DEFINE l_xrcd009     LIKE xrcd_t.xrcd009
   #151201-00002#5 Add  ---(S)---
   DEFINE l_count1      LIKE type_t.num5
   #151201-00002#5 Add  ---(E)---

   #151201-00002#5 Add  ---(S)---
   CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
      RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
   DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
   DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
   #151201-00002#5 Add  ---(E)---

   CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_master.xrcadocdt,'')
   CALL s_fin_account_center_sons_str()RETURNING l_origin_str
   IF cl_null(l_origin_str) THEN LET l_origin_str = g_master.xrcasite END IF
   CALL axrp200_get_ooef001_wc(l_origin_str)RETURNING l_origin_str

   #151201-00002#5 Add  ---(S)---
   SELECT glaa001,glaa002,glaa003,glaa016,glaa020,glaa024,glaa025,glaacomp,glaa121
     INTO l_glaa001,l_glaa002,l_glaa003,l_glaa016,l_glaa020,l_glaa024,l_glaa025,l_glaacomp,l_glaa121
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald

   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2017') RETURNING l_sfin2017
   #151201-00002#5 Add  ---(E)---

   #根據astt340單號進行拆單
  #LET l_sql = "SELECT DISTINCT stbddocno,stbdsite,stbd001,stbd002,stbd003,stbd021,stbd022,stbd038 ",   #151201-00002#5 Mark
   LET l_sql = "SELECT DISTINCT stbddocno,stbdsite,stbd001,stbd002,stbd003,stbd021,stbd022,stbd038,stbd042", #151201-00002#5 Add
               "  FROM stbd_t,stbe_t WHERE stbdent = '",g_enterprise,"' ",
               "   AND stbddocno = stbedocno ",
               "   AND stbeent = stbdent",
               "   AND stbe001 = '3'",
               "   AND stbe024 = 'Y'",
               "   AND stbe025 = 'N'",
              #"   AND (stbe016 - stbe021 > 0 OR stbe021 IS NULL)",   #151201-00002#5 Mark
               "   AND TO_CHAR(stbddocdt,'YYYY') = ",g_master.glav002,
               "   AND TO_CHAR(stbddocdt,'MM') = ",g_master.glav006,
               "   AND stbesite IN ",l_origin_str CLIPPED,
              #151201-00002#5 Add  ---(S)---
               "   AND (stbe016 - stbe021 <> 0 OR stbe021 IS NULL)",
               "   AND stbdstus = 'Y'",
               "   AND stbesite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",l_glaacomp,"')",
              #151201-00002#5 Add  ---(E)---
               "   AND ",g_master.wc CLIPPED
   PREPARE axrp200_stbd_prep FROM l_sql
   DECLARE axrp200_stbd_curs CURSOR FOR axrp200_stbd_prep

   LET l_ac = 1
   FOREACH axrp200_stbd_curs INTO l_stbd[l_ac].*  
      LET l_ac = l_ac + 1
   END FOREACH
   CALL l_stbd.deleteElement(l_ac)
   IF l_stbd.getLength() < 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   LET l_sql = "SELECT stbedocno,stbeseq,stbesite,stbecomp,stbe002,stbe003,stbe005,stbe009,stbe011,stbe016,stbe019,stbe020",
               "  FROM stbe_t,stae_t",
               " WHERE stbeent = '",g_enterprise,"'",
               "   AND staeent = stbeent",
               "   AND staestus = 'Y'",
               "   AND stae001 = stbe005",
               "   AND stbe001 = '3'",
               "   AND stbe024 = 'Y'",
               "   AND stbe025 = 'N'",
              #"   AND (stbe016 - stbe021 > 0 OR stbe021 IS NULL)",   #151201-00002#5 Mark
              #"   AND stbedocno = ? "                                #151201-00002#5 Mark
              #151201-00002#5 Add  ---(S)---
               "   AND stbe016 > 0  ",
               "   AND (stbe016 - stbe021 <> 0 OR stbe021 IS NULL)",
               "   AND stbedocno = ? "
              #151201-00002#5 Add  ---(E)---
   PREPARE axrp200_stbe_prep1 FROM l_sql
   DECLARE axrp200_stbe_curs1 CURSOR FOR axrp200_stbe_prep1

  #151201-00002#5 Add  ---(S)---
   LET l_sql = "SELECT stbedocno,stbeseq,stbesite,stbecomp,stbe002,stbe003,stbe005,stbe009,stbe011,stbe016,stbe019,stbe020",
               "  FROM stbe_t,stae_t",
               " WHERE stbeent = '",g_enterprise,"'",
               "   AND staeent = stbeent",
               "   AND staestus = 'Y'",
               "   AND stae001 = stbe005",
               "   AND stbe001 = '3'",
               "   AND stbe024 = 'Y'",
               "   AND stbe025 = 'N'",
               "   AND stbe016 < 0  ",
               "   AND (stbe016 - stbe021 <> 0 OR stbe021 IS NULL)",
               "   AND stbedocno = ? "
   PREPARE axrp200_stbe_prep2 FROM l_sql
   DECLARE axrp200_stbe_curs2 CURSOR FOR axrp200_stbe_prep2
  #151201-00002#5 Add  ---(E)---

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   LET l_tot_success = TRUE
   CALL s_transaction_begin()

  #151201-00002#5 Mark ---(S)---
  #SELECT glaa001,glaa002,glaa003,glaa016,glaa020,glaa024,glaa025,glaacomp,glaa121
  #  INTO l_glaa001,l_glaa002,l_glaa003,l_glaa016,l_glaa020,l_glaa024,l_glaa025,l_glaacomp,l_glaa121
  #  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
  #CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2017') RETURNING l_sfin2017
  #CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
  #151201-00002#5 Mark ---(E)---

   FOR l_ac = 1 TO l_stbd.getLength()
     #151201-00002#5 Add  ---(S)---
      LET l_count1 = 0
      SELECT COUNT(*) INTO l_count1 FROM stbe_t WHERE stbeent = g_enterprise AND stbedocno = l_stbd[l_ac].stbddocno
         AND stbe001 = '3'   AND stbe024 = 'Y'
         AND stbe025 = 'N'   AND stbe016 > 0
         AND stbe016 - stbe021 <> 0
      IF cl_null(l_count1) THEN LET l_count1 = 0 END IF
      IF l_count1 < 1 THEN CONTINUE FOR END IF
     #151201-00002#5 Add  ---(E)---

      INITIALIZE g_xrca TO NULL
      INITIALIZE g_xrcb TO NULL

     #151201-00002#5 Mark ---(S)---
     #CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt210')
     #   RETURNING l_success,l_xrcadocno
     #151201-00002#5 Mark ---(E)---
     #151201-00002#5 Add  ---(S)---
      #151201-00002#61--mark--str--lujh
      #IF l_stbd[l_ac].stbd042 = 'Y' THEN
      #   CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
      #   CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt210')
      #      RETURNING l_success,l_xrcadocno
      #ELSE
      #   CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcbdocno,'D-FIN-0030') RETURNING l_dfin0030
      #   CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcbdocno,g_master.xrcadocdt,'axrt210')
      #      RETURNING l_success,l_xrcadocno
      #END IF
      #151201-00002#61--mark--end--lujh
      
      #151201-00002#61--add--str--lujh
      IF g_master.source = '1' THEN 
         IF l_stbd[l_ac].stbd042 = 'N' THEN
            CONTINUE FOR
         END IF
      ELSE
         IF l_stbd[l_ac].stbd042 = 'Y' THEN
            CONTINUE FOR
         END IF
      END IF
      
      CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
      CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt210')
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

     #151201-00002#5 Mark ---(S)---
     #SELECT stan006,stan007,stan008 INTO l_stan006,l_stan007,l_stan008
     #  FROM stan_t WHERE stanent = g_enterprise
     #   AND stan001 = l_stbd[l_ac].stbd001
     #151201-00002#5 Mark ---(E)---
     #151201-00002#5 Add  ---(S)---
      IF l_stbd[l_ac].stbd003 = '4' OR l_stbd[l_ac].stbd003 = '5' THEN
         SELECT stfa032,stfa034,stfa035 INTO l_stan006,l_stan007,l_stan008
           FROM stfa_t WHERE stfaent = g_enterprise
            AND stfa001 = l_stbd[l_ac].stbd001
      ELSE
         SELECT stan006,stan007,stan008 INTO l_stan006,l_stan007,l_stan008
           FROM stan_t WHERE stanent = g_enterprise
            AND stan001 = l_stbd[l_ac].stbd001
      END IF
     #151201-00002#5 Add  ---(E)---

      LET g_xrca.xrcaent = g_enterprise
      LET g_xrca.xrcastus = 'N'
      LET g_xrca.xrcacomp = l_glaacomp
      LET g_xrca.xrcald = g_master.xrcald
      LET g_xrca.xrcadocno = l_xrcadocno
      IF cl_null(g_master.xrcadocdt) THEN
         LET g_xrca.xrcadocdt = g_today
      ELSE
         LET g_xrca.xrcadocdt = g_master.xrcadocdt
      END IF
      LET g_xrca.xrcasite = g_master.xrcasite
      LET g_xrca.xrca001 = '18'
      IF cl_null(g_master.xrca003) THEN
         LET g_xrca.xrca003 = g_user
      ELSE
         LET g_xrca.xrca003 = g_master.xrca003
      END IF
      LET g_xrca.xrca004 = l_stbd[l_ac].stbd002
      CALL axrp200_xrca004_ref() RETURNING l_xrca.*
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
      LET g_xrca.xrca009 = l_stbd[l_ac].stbd038
      LET g_xrca.xrca010 = l_stbd[l_ac].stbd038
      IF cl_null(l_stan007) THEN
         IF cl_null(g_master.xrca011) THEN
            LET g_xrca.xrca011 = l_xrca.xrca011
         ELSE
            LET g_xrca.xrca011 = g_master.xrca011
         END IF
      ELSE
      LET g_xrca.xrca011 = l_stan007
      END IF
      CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
         RETURNING l_success,l_oodbl004,g_xrca.xrca013,g_xrca.xrca012,l_oodb011
   
      LET g_xrca.xrca014 = l_stbd[l_ac].stbd021
      LET g_xrca.xrca015 = l_stbd[l_ac].stbd022
     #LET g_xrca.xrca016 = '18'   #151201-00002#5 Mark
      LET g_xrca.xrca016 = '3'    #151201-00002#5 Add
      LET g_xrca.xrca017 = '0'
      LET g_xrca.xrca018 = l_stbd[l_ac].stbddocno
      LET g_xrca.xrca019 = ''
      LET g_xrca.xrca020 = 'N'
      LET g_xrca.xrca021 = ''
      LET g_xrca.xrca022 = l_stbd[l_ac].stbd001
      LET g_xrca.xrca023 = ''
      LET g_xrca.xrca024 = ''
      LET g_xrca.xrca025 = ''
      LET g_xrca.xrca026 = ''
      LET g_xrca.xrca028 = ''
      LET g_xrca.xrca029 = 1
      LET g_xrca.xrca030 = 0
      LET g_xrca.xrca031 = 0
      LET g_xrca.xrca032 = 0
      LET g_xrca.xrca033 = ''
      CALL s_department_get_respon_center(g_xrca.xrca015,g_xrca.xrcadocdt)
         RETURNING l_success,g_errno,g_xrca.xrca034,l_ooefl003

      SELECT glab005 INTO l_xrca035 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = g_xrca.xrca007   # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_01'

      SELECT glab005 INTO l_xrca036 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = g_xrca.xrca007   # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_21'

      LET g_xrca.xrca035 = l_xrca035
      LET g_xrca.xrca036 = l_xrca036
      LET g_xrca.xrca037 = l_dfin0030
      LET g_xrca.xrca038 = ''
      LET g_xrca.xrca039 = 0
      LET g_xrca.xrca040 = 'N'
      LET g_xrca.xrca041 = ''
      LET g_xrca.xrca042 = ''
      LET g_xrca.xrca043 = ''
      LET g_xrca.xrca044 = 0
      LET g_xrca.xrca045 = ''
      LET g_xrca.xrca046 = l_xrca.xrca046
      LET g_xrca.xrca047 = ''
      LET g_xrca.xrca048 = ''
      LET g_xrca.xrca049 = l_stbd[l_ac].stbdsite
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
      LET g_xrca.xrca064 = 0
      LET g_xrca.xrca065 = ''
      LET g_xrca.xrca066 = ''
      LET g_xrca.xrca100 = l_stan006
      IF l_stan006 = l_glaa001 THEN
         LET g_xrca.xrca101 = 1
      ELSE
         CASE g_master.b_comb1
            WHEN '1'  #依立帳日匯率(aooi160)
                CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,
                                          g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_xrca.xrca101
            WHEN '2'  #依立帳日匯率(aooi160)
                CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,
                                          g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_xrca.xrca101
            WHEN '3'  #依立帳日月平均匯率(aooi170)
                CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,
                                              g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_sub_success,g_errno,g_xrca.xrca101
         END CASE
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
      END IF

      LET g_xrcb.xrcbseq = 0
      FOREACH axrp200_stbe_curs1 USING l_stbd[l_ac].stbddocno INTO l_stbe.*

         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq   = g_xrcb.xrcbseq + 1
         LET g_xrcb.xrcbent   = g_enterprise
         LET g_xrcb.xrcbld    = g_xrca.xrcald
         LET g_xrcb.xrcbsite  = g_xrca.xrcasite
         LET g_xrcb.xrcborga  = l_stbe.stbesite
         LET g_xrcb.xrcblegl  = l_stbe.stbecomp
         LET g_xrcb.xrcb001 = '3'
         LET g_xrcb.xrcb002 = l_stbe.stbedocno
         LET g_xrcb.xrcb003 = l_stbe.stbeseq
         LET g_xrcb.xrcb004 = l_stbe.stbe019
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = ''
         LET g_xrcb.xrcb007 = 1
         LET g_xrcb.xrcb008 = l_stbe.stbe002
         LET g_xrcb.xrcb009 = l_stbe.stbe003
         LET g_xrcb.xrcb010 = l_stbe.stbe020
         SELECT ooeg004 INTO g_xrcb.xrcb011 FROM ooeg_t WHERE ooegent = g_enterprise
            AND ooeg001 = g_xrcb.xrcb010
         LET g_xrcb.xrcb012 = l_stbe.stbe019
         LET g_xrcb.xrcb013 = 'N'
         LET g_xrcb.xrcb014 = l_stbe.stbe005
         LET g_xrcb.xrcb015 = ''
         LET g_xrcb.xrcb016 = ''
         LET g_xrcb.xrcb017 = ''
         LET g_xrcb.xrcb018 = ''
         LET g_xrcb.xrcb019 = '1'
         LET g_xrcb.xrcb020 = l_stbe.stbe009
         SELECT glab006 INTO g_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_xrcb.xrcbld
            AND glab001 = 'AR'
            AND glab002 = l_stbd[l_ac].stbd003
            AND glab003 = l_stbe.stbe005
         IF cl_null(g_xrcb.xrcb021) THEN
            LET g_xrcb.xrcb021 = g_xrca.xrca036
         END IF
        #151201-00002#5 Mark ---(S)---
        #SELECT glab005 INTO g_xrcb.xrcb029 FROM glab_t WHERE glabent = g_enterprise
        #   AND glabld = g_xrcb.xrcbld
        #   AND glab001 = 'AR'
        #   AND glab002 = l_stbd[l_ac].stbd003
        #   AND glab003 = l_stbe.stbe005
        #IF cl_null(g_xrcb.xrcb029) THEN
        #   LET g_xrcb.xrcb029 = g_xrca.xrca035
        #END IF
        #151201-00002#5 Mark ---(E)---
         LET g_xrcb.xrcb029 = g_xrca.xrca035   #151201-00002#5 Add
         LET g_xrcb.xrcb022 = l_stbe.stbe011
         LET g_xrcb.xrcb024 = ''
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = 0
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
        #LET g_xrcb.xrcb029 = g_xrca.xrca035
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008
         LET g_xrcb.xrcb032 = ''
         LET g_xrcb.xrcb033 = ''
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
         LET g_xrcb.xrcb051 = g_xrca.xrca014
         LET g_xrcb.xrcb100 = g_xrca.xrca100
         LET g_xrcb.xrcb101 = l_stbe.stbe016
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
         CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
            RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         IF l_oodb005 = 'Y' THEN
            LET g_xrcb.xrcb105 = g_xrcb.xrcb007*g_xrcb.xrcb101
            LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
            LET g_xrcb.xrcb103 = g_xrcb.xrcb105 - g_xrcb.xrcb104
         
            LET g_xrcb.xrcb115 = g_xrcb.xrcb007*g_xrcb.xrcb111
            LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
            LET g_xrcb.xrcb113 = g_xrcb.xrcb115 - g_xrcb.xrcb114
         ELSE
            LET g_xrcb.xrcb103 = g_xrcb.xrcb007*g_xrcb.xrcb101
            LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
            LET g_xrcb.xrcb105 = g_xrcb.xrcb103 + g_xrcb.xrcb104
         
            LET g_xrcb.xrcb113 = g_xrcb.xrcb007*g_xrcb.xrcb111
            LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
            LET g_xrcb.xrcb115 = g_xrcb.xrcb113 + g_xrcb.xrcb114
         END IF
         UPDATE  xrcd_t SET xrcd103 = xrcd103 + l_diff,
                            xrcd105 = xrcd105 + l_diff,
                            xrcd113 = xrcd113 + l_diff1,
                            xrcd115 = xrcd115 + l_diff1
          WHERE xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
            AND xrcdseq = g_xrcb.xrcbseq
         SELECT glab005 INTO l_xrcd009 FROM glab_t 
          WHERE glabld = g_xrca.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_29'
         UPDATE xrcd_t SET xrcd009 = l_xrcd009
          WHERE xrcd009 IS NULL
            AND xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
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
                            g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         DELETE FROM xrcf_t WHERE xrcfent = g_enterprise
            AND xrcfld = g_xrca.xrcald
            AND xrcfdocno = g_xrca.xrcadocno
            AND xrcfseq = g_xrcb_t.xrcbseq
         CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,'Y') RETURNING g_xrcb.xrcb023
         UPDATE xrcb_t SET xrcb023 = g_xrcb.xrcb023
          WHERE xrcbent = g_enterprise
            AND xrcbld = g_xrcb.xrcbld
            AND xrcbdocno = g_xrcb.xrcbdocno
            AND xrcbseq = g_xrcb.xrcbseq

         UPDATE stbe_t SET stbe021 = stbe016
          WHERE stbeent = g_enterprise
            AND stbedocno = l_stbe.stbedocno
            AND stbeseq = l_stbe.stbeseq

      END FOREACH 

      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
      CALL s_axrt300_xrca_upd(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success

      IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL s_pre_voucher_ins('AR','R10',g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
         IF NOT l_success THEN
            LET l_tot_success = FALSE
         END IF
      END IF

   END FOR

  #151201-00002#5 Add  ---(S)---
   FOR l_ac = 1 TO l_stbd.getLength()
      LET l_count1 = 0
      SELECT COUNT(*) INTO l_count1 FROM stbe_t WHERE stbeent = g_enterprise AND stbedocno = l_stbd[l_ac].stbddocno
         AND stbe001 = '3'   AND stbe024 = 'Y'
         AND stbe025 = 'N'   AND stbe016 < 0
         AND stbe016 - stbe021 <> 0

      IF cl_null(l_count1) THEN LET l_count1 = 0 END IF
      IF l_count1 < 1 THEN CONTINUE FOR END IF

      INITIALIZE g_xrca TO NULL
      INITIALIZE g_xrcb TO NULL

      #151201-00002#61--mark--str--lujh
      #IF l_stbd[l_ac].stbd042 = 'Y' THEN
      #   CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
      #   CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt210')
      #      RETURNING l_success,l_xrcadocno
      #ELSE
      #   CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcbdocno,'D-FIN-0030') RETURNING l_dfin0030
      #   CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcbdocno,g_master.xrcadocdt,'axrt210')
      #      RETURNING l_success,l_xrcadocno
      #END IF
      #151201-00002#61--mark--end--lujh
      
      #151201-00002#61--add--str--lujh
      IF g_master.source = '1' THEN 
         IF l_stbd[l_ac].stbd042 = 'N' THEN
            CONTINUE FOR
         END IF
      ELSE
         IF l_stbd[l_ac].stbd042 = 'Y' THEN
            CONTINUE FOR
         END IF
      END IF
      
      CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
      CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt210')
         RETURNING l_success,l_xrcadocno
      #151201-00002#61--add--end--lujh 
      
      IF NOT l_success THEN
         LET l_tot_success = l_success
      END IF
      IF cl_null(l_start_no) THEN
         LET l_start_no = l_xrcadocno
      END IF
      LET l_end_no = l_xrcadocno

      IF l_stbd[l_ac].stbd003 = '4' OR l_stbd[l_ac].stbd003 = '5' THEN
         SELECT stfa032,stfa034,stfa035 INTO l_stan006,l_stan007,l_stan008
           FROM stfa_t WHERE stfaent = g_enterprise
            AND stfa001 = l_stbd[l_ac].stbd001
      ELSE
         SELECT stan006,stan007,stan008 INTO l_stan006,l_stan007,l_stan008
           FROM stan_t WHERE stanent = g_enterprise
            AND stan001 = l_stbd[l_ac].stbd001
      END IF

      LET g_xrca.xrcaent = g_enterprise
      LET g_xrca.xrcastus = 'N'
      LET g_xrca.xrcacomp = l_glaacomp
      LET g_xrca.xrcald = g_master.xrcald
      LET g_xrca.xrcadocno = l_xrcadocno
      IF cl_null(g_master.xrcadocdt) THEN
         LET g_xrca.xrcadocdt = g_today
      ELSE
         LET g_xrca.xrcadocdt = g_master.xrcadocdt
      END IF
      LET g_xrca.xrcasite = g_master.xrcasite
      LET g_xrca.xrca001 = '28'
      IF cl_null(g_master.xrca003) THEN
         LET g_xrca.xrca003 = g_user
      ELSE
         LET g_xrca.xrca003 = g_master.xrca003
      END IF
      LET g_xrca.xrca004 = l_stbd[l_ac].stbd002
      CALL axrp200_xrca004_ref() RETURNING l_xrca.*
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
      LET g_xrca.xrca009 = l_stbd[l_ac].stbd038
      LET g_xrca.xrca010 = l_stbd[l_ac].stbd038
      IF cl_null(l_stan007) THEN
         IF cl_null(g_master.xrca011) THEN
            LET g_xrca.xrca011 = l_xrca.xrca011
         ELSE
            LET g_xrca.xrca011 = g_master.xrca011
         END IF
      ELSE
      LET g_xrca.xrca011 = l_stan007
      END IF
      CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
         RETURNING l_success,l_oodbl004,g_xrca.xrca013,g_xrca.xrca012,l_oodb011
   
      LET g_xrca.xrca014 = l_stbd[l_ac].stbd021
      LET g_xrca.xrca015 = l_stbd[l_ac].stbd022
      LET g_xrca.xrca016 = '3'
      LET g_xrca.xrca017 = '0'
      LET g_xrca.xrca018 = l_stbd[l_ac].stbddocno
      LET g_xrca.xrca019 = ''
      LET g_xrca.xrca020 = 'N'
      LET g_xrca.xrca021 = ''
      LET g_xrca.xrca022 = l_stbd[l_ac].stbd001
      LET g_xrca.xrca023 = ''
      LET g_xrca.xrca024 = ''
      LET g_xrca.xrca025 = ''
      LET g_xrca.xrca026 = ''
      LET g_xrca.xrca028 = ''
      LET g_xrca.xrca029 = 1
      LET g_xrca.xrca030 = 0
      LET g_xrca.xrca031 = 0
      LET g_xrca.xrca032 = 0
      LET g_xrca.xrca033 = ''
      CALL s_department_get_respon_center(g_xrca.xrca015,g_xrca.xrcadocdt)
         RETURNING l_success,g_errno,g_xrca.xrca034,l_ooefl003

      SELECT glab005 INTO l_xrca035 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = g_xrca.xrca007   # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_01'

      SELECT glab005 INTO l_xrca036 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = g_xrca.xrca007   # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_21'

      LET g_xrca.xrca035 = l_xrca035
      LET g_xrca.xrca036 = l_xrca036
      LET g_xrca.xrca037 = l_dfin0030
      LET g_xrca.xrca038 = ''
      LET g_xrca.xrca039 = 0
      LET g_xrca.xrca040 = 'N'
      LET g_xrca.xrca041 = ''
      LET g_xrca.xrca042 = ''
      LET g_xrca.xrca043 = ''
      LET g_xrca.xrca044 = 0
      LET g_xrca.xrca045 = ''
      LET g_xrca.xrca046 = l_xrca.xrca046
      LET g_xrca.xrca047 = ''
      LET g_xrca.xrca048 = ''
      LET g_xrca.xrca049 = l_stbd[l_ac].stbdsite
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
      LET g_xrca.xrca064 = 0
      LET g_xrca.xrca065 = ''
      LET g_xrca.xrca066 = ''
      LET g_xrca.xrca100 = l_stan006
      IF l_stan006 = l_glaa001 THEN
         LET g_xrca.xrca101 = 1
      ELSE
         CASE g_master.b_comb1
            WHEN '1'  #依立帳日匯率(aooi160)
                CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,
                                          g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_xrca.xrca101
            WHEN '2'  #依立帳日匯率(aooi160)
                CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,
                                          g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_xrca.xrca101
            WHEN '3'  #依立帳日月平均匯率(aooi170)
                CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,
                                              g_xrca.xrca100,l_glaa001,0,l_glaa025)
                     RETURNING g_sub_success,g_errno,g_xrca.xrca101
         END CASE
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
      END IF

      LET g_xrcb.xrcbseq = 0
      FOREACH axrp200_stbe_curs2 USING l_stbd[l_ac].stbddocno INTO l_stbe.*

         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq   = g_xrcb.xrcbseq + 1
         LET g_xrcb.xrcbent   = g_enterprise
         LET g_xrcb.xrcbld    = g_xrca.xrcald
         LET g_xrcb.xrcbsite  = g_xrca.xrcasite
         LET g_xrcb.xrcborga  = l_stbe.stbesite
         LET g_xrcb.xrcblegl  = l_stbe.stbecomp
         LET g_xrcb.xrcb001 = '3'
         LET g_xrcb.xrcb002 = l_stbe.stbedocno
         LET g_xrcb.xrcb003 = l_stbe.stbeseq
         LET g_xrcb.xrcb004 = l_stbe.stbe019
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = ''
         LET g_xrcb.xrcb007 = 1
         LET g_xrcb.xrcb008 = l_stbe.stbe002
         LET g_xrcb.xrcb009 = l_stbe.stbe003
         LET g_xrcb.xrcb010 = l_stbe.stbe020
         SELECT ooeg004 INTO g_xrcb.xrcb011 FROM ooeg_t WHERE ooegent = g_enterprise
            AND ooeg001 = g_xrcb.xrcb010
         LET g_xrcb.xrcb012 = l_stbe.stbe019
         LET g_xrcb.xrcb013 = 'N'
         LET g_xrcb.xrcb014 = l_stbe.stbe005
         LET g_xrcb.xrcb015 = ''
         LET g_xrcb.xrcb016 = ''
         LET g_xrcb.xrcb017 = ''
         LET g_xrcb.xrcb018 = ''
         LET g_xrcb.xrcb019 = '1'
         LET g_xrcb.xrcb020 = l_stbe.stbe009

         SELECT glab006 INTO g_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_xrcb.xrcbld
            AND glab001 = 'AR'
            AND glab002 = l_stbd[l_ac].stbd003
            AND glab003 = l_stbe.stbe005
         IF cl_null(g_xrcb.xrcb021) THEN
            LET g_xrcb.xrcb021 = g_xrca.xrca036
         END IF
         LET g_xrcb.xrcb029 = g_xrca.xrca035
         LET g_xrcb.xrcb022 = l_stbe.stbe011
         LET g_xrcb.xrcb024 = ''
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = 0
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008
         LET g_xrcb.xrcb032 = ''
         LET g_xrcb.xrcb033 = ''
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
         LET g_xrcb.xrcb051 = g_xrca.xrca014
         LET g_xrcb.xrcb100 = g_xrca.xrca100
         LET g_xrcb.xrcb101 = l_stbe.stbe016 * -1
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
         CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
            RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         IF l_oodb005 = 'Y' THEN
            LET g_xrcb.xrcb105 = g_xrcb.xrcb007*g_xrcb.xrcb101
            LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
            LET g_xrcb.xrcb103 = g_xrcb.xrcb105 - g_xrcb.xrcb104
         
            LET g_xrcb.xrcb115 = g_xrcb.xrcb007*g_xrcb.xrcb111
            LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
            LET g_xrcb.xrcb113 = g_xrcb.xrcb115 - g_xrcb.xrcb114
         ELSE
            LET g_xrcb.xrcb103 = g_xrcb.xrcb007*g_xrcb.xrcb101
            LET l_diff = g_xrcb.xrcb105 - g_xrcb.xrcb104 - g_xrcb.xrcb103
            LET g_xrcb.xrcb105 = g_xrcb.xrcb103 + g_xrcb.xrcb104
         
            LET g_xrcb.xrcb113 = g_xrcb.xrcb007*g_xrcb.xrcb111
            LET l_diff1 = g_xrcb.xrcb115 - g_xrcb.xrcb114 - g_xrcb.xrcb113
            LET g_xrcb.xrcb115 = g_xrcb.xrcb113 + g_xrcb.xrcb114
         END IF
         UPDATE  xrcd_t SET xrcd103 = xrcd103 + l_diff,
                            xrcd105 = xrcd105 + l_diff,
                            xrcd113 = xrcd113 + l_diff1,
                            xrcd115 = xrcd115 + l_diff1
          WHERE xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
            AND xrcdseq = g_xrcb.xrcbseq
         SELECT glab005 INTO l_xrcd009 FROM glab_t 
          WHERE glabld = g_xrca.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_29'
         UPDATE xrcd_t SET xrcd009 = l_xrcd009
          WHERE xrcd009 IS NULL
            AND xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
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
                            g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         DELETE FROM xrcf_t WHERE xrcfent = g_enterprise
            AND xrcfld = g_xrca.xrcald
            AND xrcfdocno = g_xrca.xrcadocno
            AND xrcfseq = g_xrcb_t.xrcbseq
         CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,'Y') RETURNING g_xrcb.xrcb023
         UPDATE xrcb_t SET xrcb023 = g_xrcb.xrcb023
          WHERE xrcbent = g_enterprise
            AND xrcbld = g_xrcb.xrcbld
            AND xrcbdocno = g_xrcb.xrcbdocno
            AND xrcbseq = g_xrcb.xrcbseq

         UPDATE stbe_t SET stbe021 = stbe016
          WHERE stbeent = g_enterprise
            AND stbedocno = l_stbe.stbedocno
            AND stbeseq = l_stbe.stbeseq

      END FOREACH 

      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
      CALL s_axrt300_xrca_upd(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success

      IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL s_pre_voucher_ins('AR','R10',g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
         IF NOT l_success THEN
            LET l_tot_success = FALSE
         END IF
      END IF

   END FOR
  #151201-00002#5 Add  ---(E)---

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
# Descriptions...: 產生應收單據 For 内部结算
# Memo...........:
# Usage..........: CALL axrp200_get_ar1()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2016/01/08 By 01727
# Modify.........: #151201-00002#5 Add
################################################################################
PRIVATE FUNCTION axrp200_get_ar1()
   DEFINE l_sql         STRING
   DEFINE l_origin_str  STRING
   DEFINE l_xrca        RECORD
          xrca005       LIKE xrca_t.xrca005,
          xrca006       LIKE xrca_t.xrca006,
          xrca007       LIKE xrca_t.xrca007,
          xrca008       LIKE xrca_t.xrca008,
          xrca009       LIKE xrca_t.xrca009,
          xrca010       LIKE xrca_t.xrca010,
          xrca011       LIKE xrca_t.xrca011,
          xrca014       LIKE xrca_t.xrca014,
          xrca015       LIKE xrca_t.xrca015,
          xrca046       LIKE xrca_t.xrca046,
          xrca058       LIKE xrca_t.xrca058,
          xrca061       LIKE xrca_t.xrca061,
          xrca100       LIKE xrca_t.xrca100,
          xrca101       LIKE xrca_t.xrca101,
          xrca121       LIKE xrca_t.xrca121,
          xrca131       LIKE xrca_t.xrca131
                        END RECORD
   DEFINE l_stdg        DYNAMIC ARRAY OF RECORD
             stdgdocno  LIKE stbd_t.stbddocno,
             stdgsite   LIKE stbd_t.stbdsite,
             stdg006    LIKE stbd_t.stbd001,
             stdh009    LIKE stdh_t.stdh009,
             stdh020    LIKE stdh_t.stdh020
                        END RECORD
   DEFINE l_stdh        RECORD
             stdhdocno  LIKE stdh_t.stdhdocno,
             stdhseq    LIKE stdh_t.stdhseq,
             stdhsite   LIKE stdh_t.stdhsite,
             stdh001    LIKE stdh_t.stdh001,
             stdh002    LIKE stdh_t.stdh002,
             stdh003    LIKE stdh_t.stdh003,
             stdh004    LIKE stdh_t.stdh004,
             stdh006    LIKE stdh_t.stdh006,
             stdh007    LIKE stdh_t.stdh007,
             stdh009    LIKE stdh_t.stdh009,
             stdh010    LIKE stdh_t.stdh010,
             stdh011    LIKE stdh_t.stdh011,
             stdh012    LIKE stdh_t.stdh012,
             stdh020    LIKE stdh_t.stdh020,
             stdh026    LIKE stdh_t.stdh026
                        END RECORD
   DEFINE l_success     LIKE type_t.num5
   DEFINE t_success     LIKE type_t.chr1
   DEFINE l_tot_success LIKE type_t.num5
   DEFINE l_ac          LIKE type_t.num5
   DEFINE l_glaa001     LIKE glaa_t.glaa001
   DEFINE l_glaa002     LIKE glaa_t.glaa002
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_glaa016     LIKE glaa_t.glaa016
   DEFINE l_glaa020     LIKE glaa_t.glaa020
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_glaa025     LIKE glaa_t.glaa025
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   DEFINE l_glaa121     LIKE glaa_t.glaa121
   DEFINE l_glab005     LIKE glab_t.glab005
   DEFINE l_xrca035     LIKE xrca_t.xrca035
   DEFINE l_xrca036     LIKE xrca_t.xrca036
   DEFINE l_stbddocno   LIKE stbd_t.stbddocno
   DEFINE l_xrcadocno   LIKE xrca_t.xrcadocno
   DEFINE l_oodbl004    LIKE oodbl_t.oodbl004
   DEFINE l_oodb011     LIKE oodb_t.oodb011
   DEFINE l_dfin0030    LIKE type_t.chr1
   DEFINE l_start_no    LIKE xrca_t.xrcadocno
   DEFINE l_end_no      LIKE xrca_t.xrcadocno
   DEFINE l_stan006     LIKE stan_t.stan006
   DEFINE l_stan007     LIKE stan_t.stan007
   DEFINE l_stan008     LIKE stan_t.stan008
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003
   DEFINE l_oodb005     LIKE oodb_t.oodb005
   DEFINE l_oodb006     LIKE oodb_t.oodb006
   DEFINE l_diff        LIKE xrcb_t.xrcb103
   DEFINE l_diff1       LIKE xrcb_t.xrcb103
   DEFINE l_xrcd009     LIKE xrcd_t.xrcd009
   DEFINE l_ooaa002     LIKE ooaa_t.ooaa002

   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002

   CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
      RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
   DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
   DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc

   LET g_master.wc = cl_replace_str(g_master.wc,"stbesite","stdgsite")
   LET g_master.wc = cl_replace_str(g_master.wc,"stbedocno","stdgdocno")
   LET g_master.wc = cl_replace_str(g_master.wc,"stbd021","stdg006")
   LET g_master.wc = cl_replace_str(g_master.wc,"stbd002","stdh020")

   SELECT glaa001,glaa002,glaa003,glaa016,glaa020,glaa024,glaa025,glaacomp,glaa121
     INTO l_glaa001,l_glaa002,l_glaa003,l_glaa016,l_glaa020,l_glaa024,l_glaa025,l_glaacomp,l_glaa121
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald

   #根據astt740單號進行拆單
   LET l_sql = "SELECT DISTINCT stdgdocno,stdgsite,stdg006,stdh009,stdh020",
               "  FROM stdg_t, stdh_t WHERE stdgent = '",g_enterprise,"' ",
               "   AND stdgent = stdhent",
               "   AND stdgdocno = stdhdocno",
               "   AND stdh012 - stdh028 > 0",
              #"   AND stdh001 IN ('') AND stdh002 IN ('')",   疑问20150920
               "   AND stdh027 = '2'",
               "   AND stdgstus = 'Y'",
               "   AND TO_CHAR(stdgdocdt,'YYYY') = ",g_master.glav002,
               "   AND TO_CHAR(stdgdocdt,'MM') = ",g_master.glav006,
               "   AND ",g_master.wc CLIPPED
   PREPARE axrp200_stdg_prep FROM l_sql
   DECLARE axrp200_stdg_curs CURSOR FOR axrp200_stdg_prep

   LET l_ac = 1
   FOREACH axrp200_stdg_curs INTO l_stdg[l_ac].*  
      LET l_ac = l_ac + 1
   END FOREACH
   CALL l_stdg.deleteElement(l_ac)
   IF l_stdg.getLength() < 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   LET l_sql = "SELECT stdhdocno,stdhseq,stdhsite,stdh001,stdh002,stdh003,stdh004,stdh006,",
               "       stdh007  ,stdh009,stdh010 ,stdh011,stdh012,stdh020,stdh026",
               "  FROM stdh_t",
               " WHERE stdhent = '",g_enterprise,"'",
               "   AND stdh027 = '2'",
               "   AND stdhdocno = ? ",
               "   AND stdh009   = ? ",
               "   AND stdh012 - stdh028 > 0"
   PREPARE axrp200_stdh_prep FROM l_sql
   DECLARE axrp200_stdh_curs CURSOR FOR axrp200_stdh_prep

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   LET l_tot_success = TRUE
   CALL s_transaction_begin()

   FOR l_ac = 1 TO l_stdg.getLength()
      INITIALIZE g_xrca TO NULL
      INITIALIZE g_xrcb TO NULL

     #这里先按照不含发票的单据来做,等前端单据确认后在做是否汗发票的处理
      CALL s_fin_get_doc_para(g_master.xrcald,l_glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030   #151201-00002#61 change xrcbdocno to xrcadocno lujh 
      CALL s_aooi200_fin_gen_docno(g_master.xrcald,l_glaa024,l_glaa003,g_master.xrcadocno,g_master.xrcadocdt,'axrt210')  #151201-00002#61 change xrcbdocno to xrcadocno lujh 
         RETURNING l_success,l_xrcadocno

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
      IF cl_null(g_master.xrcadocdt) THEN
         LET g_xrca.xrcadocdt = g_today
      ELSE
         LET g_xrca.xrcadocdt = g_master.xrcadocdt
      END IF
      LET g_xrca.xrcasite = g_master.xrcasite
      LET g_xrca.xrca001 = '18'
      IF cl_null(g_master.xrca003) THEN
         LET g_xrca.xrca003 = g_user
      ELSE
         LET g_xrca.xrca003 = g_master.xrca003
      END IF
      LET g_xrca.xrca004 = l_stdg[l_ac].stdh020
      CALL axrp200_xrca004_ref() RETURNING l_xrca.*
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
      
      LET g_xrca.xrca011 = l_xrca.xrca011
      IF NOT cl_null(l_stdg[l_ac].stdh009) THEN
         LET g_xrca.xrca011 = l_stdg[l_ac].stdh009
      END IF
      IF NOT cl_null(g_master.xrca011) THEN
         LET g_xrca.xrca011 = g_master.xrca011
      END IF
      CALL s_tax_chk(l_glaacomp,g_xrca.xrca011)
         RETURNING l_success,l_oodbl004,g_xrca.xrca013,g_xrca.xrca012,l_oodb011
   
      LET g_xrca.xrca014 = l_stdg[l_ac].stdg006
      SELECT ooag003 INTO g_xrca.xrca015 FROM ooag_t WHERE ooagent = g_enterprise
         AND ooag001 = l_stdg[l_ac].stdg006
      LET g_xrca.xrca016 = '31'
      LET g_xrca.xrca017 = '0'
      LET g_xrca.xrca018 = l_stdg[l_ac].stdgdocno
      LET g_xrca.xrca019 = ''
      LET g_xrca.xrca020 = 'N'
      LET g_xrca.xrca021 = ''
      LET g_xrca.xrca022 = ''
      LET g_xrca.xrca023 = ''
      LET g_xrca.xrca024 = ''
      LET g_xrca.xrca025 = ''
      LET g_xrca.xrca026 = ''
      LET g_xrca.xrca028 = ''
      LET g_xrca.xrca029 = 1
      LET g_xrca.xrca030 = 0
      LET g_xrca.xrca031 = 0
      LET g_xrca.xrca032 = 0
      LET g_xrca.xrca033 = ''
      CALL s_department_get_respon_center(g_xrca.xrca015,g_xrca.xrcadocdt)
         RETURNING l_success,g_errno,g_xrca.xrca034,l_ooefl003

      SELECT glab005 INTO l_xrca035 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = g_xrca.xrca007   # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_01'

      SELECT glab005 INTO l_xrca036 FROM glab_t 
       WHERE glabld = g_master.xrcald 
         AND glabent = g_enterprise
         AND glab002 = g_xrca.xrca007   # 帳款類別
         AND glab001 = '13'             # 應收帳務類型科目設定
         AND glab003 = '8304_21'

      LET g_xrca.xrca035 = l_xrca035
      LET g_xrca.xrca036 = l_xrca036
      LET g_xrca.xrca037 = l_dfin0030
      LET g_xrca.xrca038 = ''
      LET g_xrca.xrca039 = 0
      LET g_xrca.xrca040 = 'N'
      LET g_xrca.xrca041 = ''
      LET g_xrca.xrca042 = ''
      LET g_xrca.xrca043 = ''
      LET g_xrca.xrca044 = 0
      LET g_xrca.xrca045 = ''
      LET g_xrca.xrca046 = l_xrca.xrca046
      LET g_xrca.xrca047 = ''
      LET g_xrca.xrca048 = ''
      LET g_xrca.xrca049 = g_xrca.xrcasite
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
      LET g_xrca.xrca064 = 0
      LET g_xrca.xrca065 = ''
      LET g_xrca.xrca066 = ''
      LET g_xrca.xrca100 = l_glaa001
      LET g_xrca.xrca101 = 1
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
      END IF

      LET g_xrcb.xrcbseq = 0
      FOREACH axrp200_stdh_curs USING l_stdg[l_ac].stdgdocno,l_stdg[l_ac].stdh009 INTO l_stdh.*

         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq   = g_xrcb.xrcbseq + 1
         LET g_xrcb.xrcbent   = g_enterprise
         LET g_xrcb.xrcbld    = g_xrca.xrcald
         LET g_xrcb.xrcbsite  = g_xrca.xrcasite
         LET g_xrcb.xrcborga  = l_stdh.stdhsite
         LET g_xrcb.xrcblegl  = l_stdh.stdh026
         LET g_xrcb.xrcb001 = '31'
         LET g_xrcb.xrcb002 = l_stdh.stdhdocno
         LET g_xrcb.xrcb003 = l_stdh.stdhseq
         LET g_xrcb.xrcb004 = l_stdh.stdh006
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = ''
         LET g_xrcb.xrcb007 = 1
         LET g_xrcb.xrcb008 = l_stdh.stdh003
         LET g_xrcb.xrcb009 = l_stdh.stdh004
         LET g_xrcb.xrcb010 = g_xrca.xrca015
         SELECT ooeg004 INTO g_xrcb.xrcb011 FROM ooeg_t WHERE ooegent = g_enterprise
            AND ooeg001 = g_xrcb.xrcb010
         SELECT rtaw001 INTO g_xrcb.xrcb012 FROM rtaw_t,imaa_t WHERE imaaent = g_enterprise
            AND imaa009 = rtaw002
            AND rtaw003 = l_ooaa002
            AND imaa001 = g_xrcb.xrcb004
            AND imaaent = rtawent

         LET g_xrcb.xrcb013 = 'N'
         LET g_xrcb.xrcb014 = l_stdh.stdh007
         LET g_xrcb.xrcb015 = ''
         LET g_xrcb.xrcb016 = ''
         LET g_xrcb.xrcb017 = ''
         LET g_xrcb.xrcb018 = ''
         LET g_xrcb.xrcb019 = '1'
         LET g_xrcb.xrcb020 = l_stdh.stdh009
         SELECT glab006 INTO g_xrcb.xrcb021 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_xrcb.xrcbld
            AND glab001 = 'AR'
            AND glab003 = l_stdh.stdh007
         IF cl_null(g_xrcb.xrcb021) THEN
            LET g_xrcb.xrcb021 = g_xrca.xrca036
         END IF
         LET g_xrcb.xrcb029 = g_xrca.xrca035
         LET g_xrcb.xrcb022 = l_stdh.stdh010
         LET g_xrcb.xrcb023 = 'N'
         LET g_xrcb.xrcb024 = ''
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = 0
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008
         LET g_xrcb.xrcb032 = ''
         LET g_xrcb.xrcb033 = ''
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
         LET g_xrcb.xrcb051 = g_xrca.xrca014
         LET g_xrcb.xrcb100 = g_xrca.xrca100
         LET g_xrcb.xrcb101 = 1
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
         LET g_xrcb.xrcb111 = g_xrcb.xrcb101
         CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,l_glaacomp,
                        g_xrcb.xrcb007*g_xrcb.xrcb101,g_xrcb.xrcb020,
                        g_xrcb.xrcb007,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
            RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                      g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                      g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                      g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
        #为取消计算后产生的汇差,这里金额直接去前端资料，然后再回写交易税明细
         LET g_xrcb.xrcb103 = l_stdh.stdh011
         LET g_xrcb.xrcb104 = l_stdh.stdh012 - l_stdh.stdh011
         LET g_xrcb.xrcb105 = l_stdh.stdh012
         LET g_xrcb.xrcb113 = l_stdh.stdh011
         LET g_xrcb.xrcb114 = l_stdh.stdh012 - l_stdh.stdh011
         LET g_xrcb.xrcb115 = l_stdh.stdh012
         UPDATE  xrcd_t SET xrcd103 = g_xrcb.xrcb103,
                            xrcd104 = g_xrcb.xrcb104,
                            xrcd105 = g_xrcb.xrcb105,
                            xrcd113 = g_xrcb.xrcb113,
                            xrcd114 = g_xrcb.xrcb114,
                            xrcd115 = g_xrcb.xrcb115
          WHERE xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
            AND xrcdseq = g_xrcb.xrcbseq
         SELECT glab005 INTO l_xrcd009 FROM glab_t 
          WHERE glabld = g_xrca.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_29'
         UPDATE xrcd_t SET xrcd009 = l_xrcd009
          WHERE xrcd009 IS NULL
            AND xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
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
                            g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_xrca.xrcadocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF

      END FOREACH 

      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
      CALL s_axrt300_xrca_upd(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success

      IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL s_pre_voucher_ins('AR','R10',g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
         IF NOT l_success THEN
            LET l_tot_success = FALSE
         END IF
      END IF

   END FOR

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
# Descriptions...: 產生直接沖帳資料
# Memo...........:
# Usage..........: CALL axrp200_ins_xrce()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp200_ins_xrce()
   DEFINE l_count             LIKE type_t.num5
   DEFINE l_seq               LIKE type_t.num5
   DEFINE l_xrccdocno         LIKE xrcc_t.xrccdocno
   DEFINE l_xrccseq           LIKE xrcc_t.xrccseq
   DEFINE l_xrcc001           LIKE xrcc_t.xrcc001
   DEFINE l_xrca060           LIKE xrca_t.xrca060
   DEFINE l_xrca103           LIKE xrca_t.xrca103
   DEFINE l_xrca113           LIKE xrca_t.xrca113
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrca              RECORD LIKE xrca_t.*
   #DEFINE g_xrcb              RECORD LIKE xrcb_t.*
   #DEFINE l_xrcc              RECORD LIKE xrcc_t.*
   #DEFINE l_xrce              RECORD LIKE xrce_t.*
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

   DEFINE g_xrcb RECORD  #應收憑單單身
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
   #161128-00061#3-----modify--end----------    
   DEFINE l_sql               STRING
   DEFINE ls_wc               STRING
   DEFINE l_wc1               STRING
   DEFINE l_ooef014           LIKE ooef_t.ooef014
   DEFINE l_ooaj004           LIKE ooaj_t.ooaj004
   DEFINE l_xrca100           LIKE xrca_t.xrca100
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_errno             LIKE type_t.chr10
   DEFINE l_glaa001           LIKE glaa_t.glaa001
   DEFINE l_glaa015           LIKE glaa_t.glaa015
   DEFINE l_glaa017           LIKE glaa_t.glaa017
   DEFINE l_glaa019           LIKE glaa_t.glaa019
   DEFINE l_glaa021           LIKE glaa_t.glaa021
   DEFINE l_glaacomp          LIKE glaa_t.glaacomp
   DEFINE l_sfin1002          LIKE type_t.chr1
   DEFINE l_xrce109           LIKE xrce_t.xrce109
   DEFINE l_xrce119           LIKE xrce_t.xrce119
   DEFINE l_xrce129           LIKE xrce_t.xrce129
   DEFINE l_xrce139           LIKE xrce_t.xrce139
      
   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = l_glaacomp

   SELECT glaa001,glaa015,glaa017,glaa019,glaa021
     INTO l_glaa001,l_glaa015,l_glaa017,l_glaa019,l_glaa021
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca.xrcald

   #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
   CALL s_curr_sel_ooaj004(l_ooef014,l_glaa001)
        RETURNING l_ooaj004

   #STEP1:若發票單身有"27:其他待抵單"則先沖銷其他待抵單
   #STEP2:依據"自動沖銷"的勾選項,彙整待抵單

   #勾選訂金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=21 之訂金待抵
   #勾選銷退待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=22 之銷退待抵
   #勾選預收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=23 之预收待抵
   #勾選其他待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=29 之其他扣抵
   #勾選溢收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=24 之溢收待抵
   #勾選押金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=25 之押金待抵

   IF 'axrt210' = 'axrt340' THEN RETURN END IF

   #150316-00013#1 By 01727 Add  ---(S)---
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-1002') RETURNING l_sfin1002
   #150316-00013#1 By 01727 Add  ---(E)---

   LET ls_wc = " xrca004 = '",g_xrca.xrca004,"' AND xrca005 = '",g_xrca.xrca005,"' "
   LET l_count = 0
   IF g_master.b_check1 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"'21'"
   ELSE
      LET l_count = l_count + 1
   END IF

   IF g_master.b_check2 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"'23'"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check3 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"'29'"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check4 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"'25'"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check5 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"'27'"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF l_count > 0 THEN LET ls_wc = ls_wc," AND xrca001 IN (",l_wc1,")" ELSE RETURN END IF

   LET l_sql = "(SELECT xrccdocno,xrccseq,xrcc001,1 flag,xrcadocdt,CASE WHEN xrca100 = '",g_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t       ",
               " WHERE xrccld = '",g_master.xrcald,"'                                               ",
               "   AND xrcc108 - xrcc109 > 0                                                        ",
               "   AND xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
               "   AND EXISTS (SELECT 1 FROM isag_t WHERE isagent = '",g_enterprise,"'              ",
               "                  AND isag001 = '26' AND isagcomp = '",g_xrca.xrcacomp,"'           ",
               "                  AND isag002 = xrccdocno AND isag003 = xrccseq                     ",
               "                  AND isagdocno IN ( SELECT DISTINCT xrcb002 FROM xrcb_t            ",
               "                                      WHERE xrcbent = '",g_enterprise,"'            ",
               "                                        AND xrcbdocno = '",g_xrca.xrcadocno,"'      ",
               "                                        AND xrcbld = '",g_xrca.xrcald,"'          ))"

   LET l_sql = l_sql," UNION "

   LET l_sql = l_sql,"SELECT xrccdocno,xrccseq,xrcc001,2 flag,xrcadocdt,CASE WHEN xrca100 = '",g_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t  ",
               " WHERE xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
               "   AND xrccld = '",g_master.xrcald,"'                                               ",
               "   AND xrcc108 - xrcc109 > 0                                                        ",
               "   AND xrcadocdt <= '",g_master.xrcadocdt,"'                                        ",
               "   AND ",ls_wc,") ORDER BY flag ASC,flag1 ASC,xrcadocdt"
   PREPARE axrp132_xrce_prep FROM l_sql
   DECLARE axrp132_xrce_curs CURSOR FOR axrp132_xrce_prep

   LET l_xrce.xrceseq = 0
   LET l_xrca103 = g_xrca.xrca103 + g_xrca.xrca104
   LET l_xrca113 = g_xrca.xrca113 + g_xrca.xrca114

   FOREACH axrp132_xrce_curs INTO l_xrccdocno,l_xrccseq,l_xrcc001
      IF l_xrca103 = 0 THEN EXIT FOREACH END IF
      
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
   
      FROM xrca_t WHERE xrcaent = g_enterprise
         AND xrcadocno = l_xrccdocno AND xrcald = g_master.xrcald
       
      #161128-00061#3-----modify--begin----------       
      #SELECT * INTO g_xrcb.* 
      SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
             xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
             xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
             xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
             xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
             xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
             xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
             xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
             xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,
             xrcb059,xrcb060,xrcb107 INTO g_xrcb.* 
      #161128-00061#3-----modify--end----------
      FROM xrcb_t WHERE xrcbent = g_enterprise
         AND xrcbdocno = l_xrccdocno AND xrcbseq = l_xrccseq AND xrcbld = g_master.xrcald
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
         AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq AND xrcc001 = l_xrcc001 AND xrccld = g_master.xrcald

      #150316-00013#1 By 01727 Add  ---(S)---
      #待抵單的可用餘額=xrcc108 - xrcc109 - 已沖帳但未確認金額
      #即等同於 xrcc108 - SUM(xrce109)
      LET l_xrce109 = 0    LET l_xrce119 = 0   LET l_xrce129 = 0   LET l_xrce139 = 0
      IF l_sfin1002 = '1' THEN
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
           INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t
          WHERE xrceent = g_enterprise       AND xrceld  = g_master.xrcald
            AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
      ELSE
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
           INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t
          WHERE xrceent = g_enterprise       AND xrceld  = g_master.xrcald
            AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
            AND xrce005 = l_xrcc.xrcc001
      END IF
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
      LET l_xrcc.xrcc109 = l_xrce109
      LET l_xrcc.xrcc119 = l_xrce119
      LET l_xrcc.xrcc129 = l_xrce129
      LET l_xrcc.xrcc139 = l_xrce139
      #150316-00013#1 By 01727 Add  ---(E)---
      LET l_xrce.xrceent = g_enterprise
      LET l_xrce.xrcecomp= l_glaacomp
      LET l_xrce.xrceld  = g_master.xrcald
      LET l_xrce.xrcedocno=g_xrca.xrcadocno
      LET l_xrce.xrceseq = l_xrce.xrceseq + 1
      LET l_xrce.xrcelegl= l_xrcc.xrcclegl
      LET l_xrce.xrcesite= l_xrcc.xrccsite
      LET l_xrce.xrceorga= l_xrcc.xrccsite
      LET l_xrce.xrce001 = 'axrt340'
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
      LET l_xrce.xrce018 = g_xrcb.xrcb010
      LET l_xrce.xrce019 = g_xrcb.xrcb011
      LET l_xrce.xrce020 = g_xrcb.xrcb012
      LET l_xrce.xrce021 = g_xrcb.xrcb017
      LET l_xrce.xrce022 = g_xrcb.xrcb015
      LET l_xrce.xrce023 = g_xrcb.xrcb016
      LET l_xrce.xrce024 = g_xrcb.xrcb002
      LET l_xrce.xrce025 = g_xrcb.xrcb003
      LET l_xrce.xrce026 = ''
     #150316-00013#1 By 01727 Mark ---(S)---
     #SELECT xrca060 INTO l_xrca060 FROM xrca_t
     # WHERE xrcald = g_master.xrcald
     #   AND xrca019 = l_xrce.xrce003
     #150316-00013#1 By 01727 Mark ---(S)---
     #150316-00013#1 By 01727 Add  ---(S)---
      SELECT xrca060 INTO l_xrca060 FROM xrca_t
       WHERE xrcald = g_master.xrcald
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

      IF g_xrca.xrca100 = l_xrca.xrca100 THEN
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
            LET l_xrca113 = l_xrca113 - l_xrca103 * l_xrcc.xrcc101
            IF l_xrca113 < 0 THEN LET l_xrca113 = 0 END IF
         END IF
      ELSE
         IF l_xrca113 > l_xrcc.xrcc118 - l_xrcc.xrcc119 THEN
            LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
            LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
            LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrca103 = l_xrca113 / g_xrca.xrca101
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
      AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
      AND xrce027 = 'N'
   IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
   CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
      RETURNING l_success,l_errno,l_xrce.xrce109
   
   IF l_glaa015 = 'Y' THEN
      IF l_glaa017 = '1' THEN
         LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
      ELSE
         LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
      END IF
   END IF
   IF l_glaa019 = 'Y' THEN
      IF l_glaa021 = '1' THEN
         LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
      ELSE
         LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
      END IF
   END IF
   UPDATE xrca_t SET xrca107 = l_xrce.xrce109,
                     xrca117 = l_xrce.xrce119,
                     xrca127 = l_xrce.xrce129,
                     xrca137 = l_xrce.xrce139
    WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrca.xrcadocno
      AND xrcald = g_xrca.xrcald
  #應稅折抵存入xrca106
   LET l_xrce.xrce109 = 0
   LET l_xrce.xrce119 = 0
   LET l_xrce.xrce129 = 0
   LET l_xrce.xrce139 = 0
   SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
     INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
      AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
      AND xrce027 = 'Y'
   IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
   CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
      RETURNING l_success,l_errno,l_xrce.xrce109
   
   IF l_glaa015 = 'Y' THEN
      IF l_glaa017 = '1' THEN
         LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
      ELSE
         LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
      END IF
   END IF
   IF l_glaa019 = 'Y' THEN
      IF l_glaa021 = '1' THEN
         LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
      ELSE
         LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
      END IF
   END IF
   UPDATE xrca_t SET xrca106 = l_xrce.xrce109,
                     xrca116 = l_xrce.xrce119,
                     xrca126 = l_xrce.xrce129,
                     xrca136 = l_xrce.xrce139
    WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrca.xrcadocno
      AND xrcald = g_xrca.xrcald

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp200_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp200_get_ooef001_wc(p_wc)
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
# Descriptions...: 回寫結算底稿
# Memo...........:
# Usage..........: CALL axrp200_upd_stbc(p_xrcald,p_xrcadocno)
#                  RETURNING r_success
# Input parameter: p_xrcald       帳套
#                : p_xrcadocno    應收單號
# Return code....: r_success      成功否
# Date & Author..: 2016/01/08 By 01727
# Modify.........: #151201-00002#5 Add
################################################################################
PRIVATE FUNCTION axrp200_upd_stbc(p_xrcald,p_xrcadocno)
   DEFINE p_xrcald      LIKE xrca_t.xrcald
   DEFINE p_xrcadocno   LIKE xrca_t.xrcadocno
   DEFINE l_sql         STRING
   DEFINE l_xrcborga    LIKE xrcb_t.xrcborga
   DEFINE l_xrcb008     LIKE xrcb_t.xrcb008
   DEFINE l_xrcb009     LIKE xrcb_t.xrcb009
   DEFINE l_xrcb105     LIKE xrcb_t.xrcb105
   DEFINE r_success     LIKE type_t.num5

   LET l_sql = "SELECT xrcborga,xrcb008,xrcb009,xrcb105 FROM xrcb_t WHERE xrcbent = '",g_enterprise,"'",
               "   AND xrcbld = '",p_xrcald,"' AND xrcbdocno = '",p_xrcadocno,"'"
   PREPARE axrt210_stbc_prep FROM l_sql
   DECLARE axrt210_stbc_curs CURSOR FOR axrt210_stbc_prep

   LET r_success = TRUE

   FOREACH axrt210_stbc_curs INTO l_xrcborga,l_xrcb008,l_xrcb009,l_xrcb105
      UPDATE stbc_t SET stbc024 = stbc018
       WHERE stbcent = g_enterprise
         AND stbcsite= l_xrcborga
         AND stbc004 = l_xrcb008
         AND stbc005 = l_xrcb009
      IF SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 回寫費用單
# Memo...........:
# Usage..........: CALL axrp200_upd_stbc(p_xrcald,p_xrcadocno)
#                  RETURNING r_success
# Input parameter: p_xrcald       帳套
#                : p_xrcadocno    應收單號
# Return code....: r_success      成功否
# Date & Author..: 2016/01/08 By 01727
# Modify.........: #151201-00002#5 Add
################################################################################
PRIVATE FUNCTION axrp200_upd_stdg(p_xrcald,p_xrcadocno)
   DEFINE p_xrcald      LIKE xrca_t.xrcald
   DEFINE p_xrcadocno   LIKE xrca_t.xrcadocno
   DEFINE l_sql         STRING
   DEFINE l_xrcb002     LIKE xrcb_t.xrcb002
   DEFINE l_xrcb003     LIKE xrcb_t.xrcb003
   DEFINE r_success     LIKE type_t.num5

   LET l_sql = "SELECT xrcb002,xrcb003 FROM xrcb_t WHERE xrcbent = '",g_enterprise,"'",
               "   AND xrcbld = '",p_xrcald,"' AND xrcbdocno = '",p_xrcadocno,"'"
   PREPARE axrt210_stdg_prep FROM l_sql
   DECLARE axrt210_stdg_curs CURSOR FOR axrt210_stdg_prep

   LET r_success = TRUE

   FOREACH axrt210_stdg_curs INTO l_xrcb002,l_xrcb003
      UPDATE stdh_t SET stdh028 = stdh012
       WHERE stdhent  = g_enterprise
         AND stdhdocno= l_xrcb002
         AND stdhseq  = l_xrcb003
      IF SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH

   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
