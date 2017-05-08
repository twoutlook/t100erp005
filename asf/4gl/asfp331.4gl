#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp331.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(1900-01-01 00:00:00), PR版次:0005(2017-01-23 10:43:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: asfp331
#+ Description: 觸控螢幕報工作業
#+ Creator....: 04441(2016-01-14 15:58:29)
#+ Modifier...: 00000 -SD/PR- 04441
 
{</section>}
 
{<section id="asfp331.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#170117-00038#1   2017/01/18  By Whitney  調整s_asft335_chk_qty()傳入參數
#170120-00043#1   2017/01/23  By Whitney  s_asft335_chk_qty()增加傳入參數報工類別
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
       fflabel_1 LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#s01
DEFINE g_sffb01_m         RECORD
    sffb009_01            LIKE sffb_t.sffb009,
    sffb009_01_desc       LIKE ecaa_t.ecaa002,
    sffb007_01            LIKE sffb_t.sffb007,
    sffb007_01_desc       LIKE oocql_t.oocql004,
    sffb004_01            LIKE sffb_t.sffb004,
    sffb004_01_desc       LIKE oogd_t.oogd002,
    sffb010_01            LIKE sffb_t.sffb010,
    sffb010_01_desc       LIKE mrba_t.mrba004
                      END RECORD
#s02
 TYPE type_g_sffb02_m     RECORD
    sffb009_02            LIKE sffb_t.sffb009,
    sffb009_02_desc       LIKE ecaa_t.ecaa002,
    sffb007_02            LIKE sffb_t.sffb007,
    sffb007_02_desc       LIKE oocql_t.oocql004,
    sffb004_02            LIKE sffb_t.sffb004,
    sffb004_02_desc       LIKE oogd_t.oogd002,
    sffb010_02            LIKE sffb_t.sffb010,
    sffb010_02_desc       LIKE mrba_t.mrba004,
    docno_1               LIKE ooba_t.ooba002,
    docno_2               LIKE ooba_t.ooba002,
    docno_3               LIKE ooba_t.ooba002,
    docno_4               LIKE ooba_t.ooba002,
    docno_5               LIKE ooba_t.ooba002,
    docno_6               LIKE ooba_t.ooba002,
    sfhb003               LIKE sfhb_t.sfhb003,
    sfhb004               LIKE sfhb_t.sfhb004
                      END RECORD
DEFINE g_sffb02_m         type_g_sffb02_m
DEFINE g_sffb02_m_t       type_g_sffb02_m
#s04
DEFINE num                STRING
DEFINE g_type             LIKE type_t.num5
#s05
 TYPE type_g_sffb_m       RECORD
    sffb005               LIKE sffb_t.sffb005,
    sffb006               LIKE sffb_t.sffb006,
    sffb012               LIKE sffb_t.sffb012,
    sffb013               LIKE sffb_t.sffb013,
    sffb014               LIKE sffb_t.sffb014,
    sffb015               LIKE sffb_t.sffb015,
    sffb017               LIKE sffb_t.sffb017,
    sffb018               LIKE sffb_t.sffb018,
    sffb019               LIKE sffb_t.sffb019
                      END RECORD
DEFINE g_sffb_m           type_g_sffb_m
DEFINE g_sffb_m_o         type_g_sffb_m
#s06
DEFINE g_sfcb06_m         RECORD
    sfcbdocno_06          LIKE sfcb_t.sfcbdocno,
    sfcb001_06            LIKE sfcb_t.sfcb001
                      END RECORD
 TYPE type_g_sffd_d       RECORD
    sffdseq1              LIKE sffd_t.sffdseq1,   #項序
    sffd001               LIKE sffd_t.sffd001,    #異常項目
    sffd001_desc          LIKE oocql_t.oocql004,
    sffd002               LIKE sffd_t.sffd002,    #數量
    sffd003               LIKE sffd_t.sffd003     #備註
                      END RECORD
DEFINE g_sffd_d           DYNAMIC ARRAY OF type_g_sffd_d
DEFINE g_sffd_d_t         type_g_sffd_d
#s07
DEFINE g_sfha_m           RECORD
    sfha004               LIKE sfha_t.sfha004,
    sfha005               LIKE sfha_t.sfha005
                      END RECORD
 TYPE type_g_sfha_d       RECORD
    seq                   LIKE sfhb_t.sfhbseq,
    sfha013               LIKE sfha_t.sfha013,
    sfha013_desc          LIKE sfha_t.sfha013,
    sfha013_desc_1        LIKE sfha_t.sfha013,
    sfha015               LIKE sfha_t.sfha015,
    sfha008               LIKE sfha_t.sfha008
                      END RECORD
DEFINE g_sfha_d           DYNAMIC ARRAY OF type_g_sfha_d
DEFINE g_sfha_d_t         type_g_sfha_d
#s08
DEFINE g_sfcb08_m         RECORD
    sfcbdocno_08          LIKE sfcb_t.sfcbdocno,
    sfcb001_08            LIKE sfcb_t.sfcb001
                      END RECORD
 TYPE type_g_sffc_d       RECORD
    sffc001               LIKE sffc_t.sffc001,     #項目
    sffc001_desc          LIKE oocql_t.oocql004,
    sffc002               LIKE sffc_t.sffc002,     #型態
    sffc003               LIKE sffc_t.sffc003,     #下限
    sffc004               LIKE sffc_t.sffc004,     #上限
    sffc005               LIKE sffc_t.sffc005,     #預設值
    sffc006               LIKE sffc_t.sffc006      #必要
                      END RECORD
DEFINE g_sffc_d           DYNAMIC ARRAY OF type_g_sffc_d
DEFINE g_sffc_d_t         type_g_sffc_d
#s09
DEFINE g_sfcb09_m         RECORD
    sfcbdocno_09          LIKE sfcb_t.sfcbdocno,
    sfcb001_09            LIKE sfcb_t.sfcb001
                      END RECORD
#s10
DEFINE g_sfcb1_d  DYNAMIC ARRAY OF RECORD
    sfcbdocno_1           LIKE sfcb_t.sfcbdocno,
    sfcb001_1             LIKE sfcb_t.sfcb001,
    sfaa010_1             LIKE sfaa_t.sfaa010,
    sfaa010_1_desc        LIKE imaal_t.imaal003,
    sfaa010_1_desc_1      LIKE imaal_t.imaal004,
    sfcb003_1             LIKE sfcb_t.sfcb003,
    sfcb003_1_desc        LIKE oocql_t.oocql004,
    sfcb004_1             LIKE sfcb_t.sfcb004,
    sfcb046_1             LIKE sfcb_t.sfcb046
                      END RECORD
DEFINE g_sfcb2_d  DYNAMIC ARRAY OF RECORD
    sfcbdocno_2           LIKE sfcb_t.sfcbdocno,
    sfcb001_2             LIKE sfcb_t.sfcb001,
    sfaa010_2             LIKE sfaa_t.sfaa010,
    sfaa010_2_desc        LIKE imaal_t.imaal003,
    sfaa010_2_desc_1      LIKE imaal_t.imaal004,
    sfcb003_2             LIKE sfcb_t.sfcb003,
    sfcb003_2_desc        LIKE oocql_t.oocql004,
    sfcb004_2             LIKE sfcb_t.sfcb004,
    sfcb047_2             LIKE sfcb_t.sfcb047
                      END RECORD
DEFINE g_sfcb3_d  DYNAMIC ARRAY OF RECORD
    sfcbdocno_3           LIKE sfcb_t.sfcbdocno,
    sfcb001_3             LIKE sfcb_t.sfcb001,
    sfaa010_3             LIKE sfaa_t.sfaa010,
    sfaa010_3_desc        LIKE imaal_t.imaal003,
    sfaa010_3_desc_1      LIKE imaal_t.imaal004,
    sfcb003_3             LIKE sfcb_t.sfcb003,
    sfcb003_3_desc        LIKE oocql_t.oocql004,
    sfcb004_3             LIKE sfcb_t.sfcb004,
    sfcb050_3             LIKE sfcb_t.sfcb050
                      END RECORD
DEFINE g_sfcb4_d  DYNAMIC ARRAY OF RECORD
    sfcbdocno_4           LIKE sfcb_t.sfcbdocno,
    sfcb001_4             LIKE sfcb_t.sfcb001,
    sfaa010_4             LIKE sfaa_t.sfaa010,
    sfaa010_4_desc        LIKE imaal_t.imaal003,
    sfaa010_4_desc_1      LIKE imaal_t.imaal004,
    sfcb003_4             LIKE sfcb_t.sfcb003,
    sfcb003_4_desc        LIKE oocql_t.oocql004,
    sfcb004_4             LIKE sfcb_t.sfcb004,
    sfcb048_4             LIKE sfcb_t.sfcb048
                      END RECORD
DEFINE g_sfcb5_d  DYNAMIC ARRAY OF RECORD
    sfcbdocno_5           LIKE sfcb_t.sfcbdocno,
    sfcb001_5             LIKE sfcb_t.sfcb001,
    sfaa010_5             LIKE sfaa_t.sfaa010,
    sfaa010_5_desc        LIKE imaal_t.imaal003,
    sfaa010_5_desc_1      LIKE imaal_t.imaal004,
    sfcb003_5             LIKE sfcb_t.sfcb003,
    sfcb003_5_desc        LIKE oocql_t.oocql004,
    sfcb004_5             LIKE sfcb_t.sfcb004,
    sfcb049_5             LIKE sfcb_t.sfcb049
                      END RECORD
DEFINE g_detail_cnt       LIKE type_t.num10  #單身總筆數
DEFINE g_detail_idx       LIKE type_t.num10  #單身目前所在筆數
DEFINE g_current_page     LIKE type_t.num10  #目前所在頁數
#
DEFINE g_rec_b            LIKE type_t.num10
DEFINE l_ac               LIKE type_t.num10
DEFINE pa_array   DYNAMIC ARRAY OF RECORD
    value                 STRING,
    label_tag             STRING,
    label                 STRING
                      END RECORD
GLOBALS
   DEFINE g_notneed_labeltag   BOOLEAN
   DEFINE mi_return_array      BOOLEAN
END GLOBALS
DEFINE g_sel_sfcb_next_sql     STRING             #存s_asft335_get_next_station递归时cursor的sql  
DEFINE g_sel_sfcb_prev_sql     STRING             #存s_asft335_get_prev_station递归时cursor的sql
 type type_sfcb_prev  RECORD               #用来存放g_sfcb_next所有报工的上站资料，所存的资料计算后得出下站应该有多少数量
    chk                   LIKE type_t.chr1,       #去除重复使用的，N是没去过重复的，Y是去重之后的结果   
    sfcbdocno             LIKE sfcb_t.sfcbdocno,  #工单单号
    sfcb001               LIKE sfcb_t.sfcb001,    #RunCard单号
    sfcb003               LIKE sfcb_t.sfcb003,    #作业编号
    sfcb004               LIKE sfcb_t.sfcb004,    #制程序
    sfcb005               LIKE sfcb_t.sfcb005,    #群组性质
    sfcb006               LIKE sfcb_t.sfcb006,    #群组
    type                  LIKE sffb_t.sffb001,    #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
    sfcb021               LIKE sfcb_t.sfcb021,    #转出单位换算率分子
    sfcb022               LIKE sfcb_t.sfcb022,    #转出单位换算率分母
    amt                   LIKE sfcb_t.sfcb050,    #与上面type匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
    sfcb053               LIKE sfcb_t.sfcb053,    #转入单位换算率分子
    sfcb054               LIKE sfcb_t.sfcb054     #转入单位换算率分母
                      END RECORD
 type type_sfcb_next  RECORD               #用来存放审核报工当站的下一站资料 
    chk                   LIKE type_t.chr1,       #去除重复使用的，N是没去过重复的，Y是去重之后的结果
    sfcbdocno             LIKE sfcb_t.sfcbdocno,
    sfcb001               LIKE sfcb_t.sfcb001,
    sfcb003               LIKE sfcb_t.sfcb003,
    sfcb004               LIKE sfcb_t.sfcb004,
    sfcb005               LIKE sfcb_t.sfcb005,     #群组性质
    sfcb006               LIKE sfcb_t.sfcb006,     #群组
    type                  LIKE sffb_t.sffb001,     #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
    sfcb021               LIKE sfcb_t.sfcb021,     #转出单位换算率分子
    sfcb022               LIKE sfcb_t.sfcb022,     #转出单位换算率分母
    amt                   LIKE sfcb_t.sfcb050,     #与上面匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
    sfcb053               LIKE sfcb_t.sfcb053,     #转入单位换算率分子
    sfcb054               LIKE sfcb_t.sfcb054      #转入单位换算率分母
                      END RECORD

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfp331.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL asfp331_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp331 WITH FORM cl_ap_formpath("asf",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL asfp331_init()
 
      #進入選單 Menu (="N")
      CALL asfp331_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp331
   END IF
 
   #add-point:作業離開前 name="main.exit"
#   FREE sql_oocq_pb
#   FREE sffb009_02_desc_pb
#   FREE sffb004_02_desc_pb
#   FREE sffb010_02_desc_pb
#   FREE sel_ooba_pb
#   FREE sfhb003_pb
#   FREE sfhb004_pb
#   FREE sfha013_pb
   DROP TABLE movein_tmp
   DROP TABLE checkin_tmp
   DROP TABLE checkout_tmp
   DROP TABLE moveout_tmp
   DROP TABLE processing_tmp
   DROP TABLE check_tmp
   DROP TABLE defect_tmp
   DROP TABLE offline_tmp
   DROP TABLE s_asft335_tmp01
   DROP TABLE s_asft335_tmp02

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp331.init" >}
#+ 初始化作業
PRIVATE FUNCTION asfp331_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE ls_4stpath   STRING
   DEFINE ls_4tmpath   STRING
   DEFINE l_sql        STRING
   DEFINE ls_file      STRING
   DEFINE ls_result    STRING
   DEFINE ls_count     LIKE type_t.num5
   DEFINE lc_channel   base.Channel

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
   
   #inport style
   LET ls_4stpath = os.Path.join(FGL_GETENV("ERP"), os.Path.join("cfg", os.Path.join("4st", os.Path.join(g_lang, "asfp331.4st"))))
   CALL ui.Interface.loadStyles(ls_4stpath)
   LET ls_4tmpath = os.Path.join(FGL_GETENV("ERP"), os.Path.join("cfg", os.Path.join("4tm", "asfp331.4tm")))
   CALL gfrm_curr2.loadTopMenu(ls_4tmpath)
   
   #嵌入畫面
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s01"), "main_grid01", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s10"), "main_grid02", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s09"), "main_grid03", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s08"), "main_grid04", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s05"), "main_grid05", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s02"), "main_grid08", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s03"), "main_grid09", "VBox", "mainlayout")
   
   #隱藏嵌入畫面
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   CALL cl_set_comp_visible("main_vbox04",FALSE)
   CALL cl_set_comp_visible("main_vbox05",FALSE)
   CALL cl_set_comp_visible("main_vbox08",FALSE)
   CALL cl_set_comp_visible("main_vbox09",FALSE)
   
   #create temp table
   CREATE TEMP TABLE movein_tmp(
       sfcbdocno     LIKE sfcb_t.sfcbdocno,
       sfcb001       LIKE sfcb_t.sfcb001,
       sfcb002       LIKE sfcb_t.sfcb002,
       sfaa010       LIKE sfaa_t.sfaa010,
       imaal003      LIKE imaal_t.imaal003,
       imaal004      LIKE imaal_t.imaal004,
       sfcb003       LIKE sfcb_t.sfcb003,
       oocql004      LIKE oocql_t.oocql004,
       sfcb004       LIKE sfcb_t.sfcb004,
       sfcb046       LIKE sfcb_t.sfcb046)
   CREATE TEMP TABLE checkin_tmp(
       sfcbdocno     LIKE sfcb_t.sfcbdocno,
       sfcb001       LIKE sfcb_t.sfcb001,
       sfcb002       LIKE sfcb_t.sfcb002,
       sfaa010       LIKE sfaa_t.sfaa010,
       imaal003      LIKE imaal_t.imaal003,
       imaal004      LIKE imaal_t.imaal004,
       sfcb003       LIKE sfcb_t.sfcb003,
       oocql004      LIKE oocql_t.oocql004,
       sfcb004       LIKE sfcb_t.sfcb004,
       sfcb047       LIKE sfcb_t.sfcb047)
   CREATE TEMP TABLE checkout_tmp(
       sfcbdocno     LIKE sfcb_t.sfcbdocno,
       sfcb001       LIKE sfcb_t.sfcb001,
       sfcb002       LIKE sfcb_t.sfcb002,
       sfaa010       LIKE sfaa_t.sfaa010,
       imaal003      LIKE imaal_t.imaal003,
       imaal004      LIKE imaal_t.imaal004,
       sfcb003       LIKE sfcb_t.sfcb003,
       oocql004      LIKE oocql_t.oocql004,
       sfcb004       LIKE sfcb_t.sfcb004,
       sfcb048       LIKE sfcb_t.sfcb048)
   CREATE TEMP TABLE moveout_tmp(
       sfcbdocno     LIKE sfcb_t.sfcbdocno,
       sfcb001       LIKE sfcb_t.sfcb001,
       sfcb002       LIKE sfcb_t.sfcb002,
       sfaa010       LIKE sfaa_t.sfaa010,
       imaal003      LIKE imaal_t.imaal003,
       imaal004      LIKE imaal_t.imaal004,
       sfcb003       LIKE sfcb_t.sfcb003,
       oocql004      LIKE oocql_t.oocql004,
       sfcb004       LIKE sfcb_t.sfcb004,
       sfcb049       LIKE sfcb_t.sfcb049)
   CREATE TEMP TABLE processing_tmp(
       sfcbdocno     LIKE sfcb_t.sfcbdocno,
       sfcb001       LIKE sfcb_t.sfcb001,
       sfcb002       LIKE sfcb_t.sfcb002,
       sfaa010       LIKE sfaa_t.sfaa010,
       imaal003      LIKE imaal_t.imaal003,
       imaal004      LIKE imaal_t.imaal004,
       sfcb003       LIKE sfcb_t.sfcb003,
       oocql004      LIKE oocql_t.oocql004,
       sfcb004       LIKE sfcb_t.sfcb004,
       sfcb050       LIKE sfcb_t.sfcb050)
   CREATE TEMP TABLE check_tmp(
       sffc001       LIKE sffc_t.sffc001,
       oocql004      LIKE oocql_t.oocql004,
       sffc002       LIKE sffc_t.sffc002,
       sffc003       LIKE sffc_t.sffc003,
       sffc004       LIKE sffc_t.sffc004,
       sffc005       LIKE sffc_t.sffc005,
       sffc006       LIKE sffc_t.sffc006)
   CREATE TEMP TABLE defect_tmp(
       sffdseq1      LIKE sffd_t.sffdseq1,
       sffd001       LIKE sffd_t.sffd001,
       sffd001_desc  LIKE oocql_t.oocql004,
       sffd002       LIKE sffd_t.sffd002,
       sffd003       LIKE sffd_t.sffd003)
   CREATE TEMP TABLE offline_tmp(
       seq           LIKE sfhb_t.sfhbseq,
       sfha013       LIKE sfha_t.sfha013,
       sfha015       LIKE sfha_t.sfha015,
       sfha008       LIKE sfha_t.sfha008)
   
   #s_asft335_cre_tmp_table
   
   #用来存放审核报工当站的下一站资料
   DROP TABLE s_asft335_tmp01
   CREATE TEMP TABLE s_asft335_tmp01(
       chk           LIKE type_t.chr1,       #去除重复使用的，N是没去过重复的，Y是去重之后的结果
       sfcbdocno     LIKE sfcb_t.sfcbdocno,
       sfcb001       LIKE sfcb_t.sfcb001,
       sfcb003       LIKE sfcb_t.sfcb003,
       sfcb004       LIKE sfcb_t.sfcb004,
       sfcb005       LIKE sfcb_t.sfcb005,    #群组性质
       sfcb006       LIKE sfcb_t.sfcb006,    #群组
       type          LIKE sffb_t.sffb001,    #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
       sfcb021       LIKE sfcb_t.sfcb021,    #转出单位换算率分子
       sfcb022       LIKE sfcb_t.sfcb022,    #转出单位换算率分母
       amt           LIKE sfcb_t.sfcb050,    #与上面匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
       sfcb053       LIKE sfcb_t.sfcb053,    #转入单位换算率分子
       sfcb054       LIKE sfcb_t.sfcb054)    #转入单位换算率分母
   #用来_prevsfcb_next所有报工的上站资料，所存_prev算后得出下站应该有多少数量
   DROP TABLE s_asft335_tmp02
   CREATE TEMP TABLE s_asft335_tmp02(
       chk           LIKE type_t.chr1,       #去除重复使用的，N是没去过重复的，Y是去重之后的结果   
       sfcbdocno     LIKE sfcb_t.sfcbdocno,  #工单单号
       sfcb001       LIKE sfcb_t.sfcb001,    #RunCard单号
       sfcb003       LIKE sfcb_t.sfcb003,    #作业编号
       sfcb004       LIKE sfcb_t.sfcb004,    #制程序
       sfcb005       LIKE sfcb_t.sfcb005,    #群组性质
       sfcb006       LIKE sfcb_t.sfcb006,    #群组
       type          LIKE sffb_t.sffb001,    #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
       sfcb021       LIKE sfcb_t.sfcb021,    #转出单位换算率分子
       sfcb022       LIKE sfcb_t.sfcb022,    #转出单位换算率分母
       amt           LIKE sfcb_t.sfcb050,    #与上面type匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
       sfcb053       LIKE sfcb_t.sfcb053,    #转入单位换算率分子
       sfcb054       LIKE sfcb_t.sfcb054)    #转入单位换算率分母
   
   #set combo
   
   LET l_sql = " SELECT DISTINCT oocql002,oocql004 ",
               "   FROM oocq_t,oocql_t ",
               "  WHERE oocqlent = ",g_enterprise,
               "    AND oocql001 = ? ",
               "    AND oocql003 = '"||g_dlang||"' ",
               "    AND oocqlent = oocqent ",
               "    AND oocql001 = oocq001 ",
               "    AND oocql002 = oocq002 ",
               "    AND oocqstus = 'Y' ",
               "  ORDER BY oocql002 "
   PREPARE sql_oocq_pb FROM l_sql
   DECLARE sql_oocq_cs CURSOR FOR sql_oocq_pb
   
   #工作站
   LET l_sql = " SELECT DISTINCT ecaa002 FROM ecaa_t ",
               "  WHERE ecaaent = ",g_enterprise,
               "    AND ecaasite = '",g_site,"' ",
               "    AND ecaastus = 'Y' ",
               "  ORDER BY ecaa002 "
   PREPARE sffb009_02_desc_pb FROM l_sql
   DECLARE sffb009_02_desc_cs CURSOR FOR sffb009_02_desc_pb
   
   #班別
   LET l_sql = " SELECT DISTINCT oogd002 ",
               "   FROM oogd_t ",
               "  WHERE oogdent = ",g_enterprise,
               "    AND oogdsite = '",g_site,"' ",
               "    AND oogdstus = 'Y' ",
               "  ORDER BY oogd002 "
   PREPARE sffb004_02_desc_pb FROM l_sql
   DECLARE sffb004_02_desc_cs CURSOR FOR sffb004_02_desc_pb
   
   #機台
   LET l_sql = " SELECT DISTINCT mrba004 ",
               "   FROM mrba_t ",
               "  WHERE mrbaent = ",g_enterprise,
               "    AND mrbasite = '",g_site,"' ",
               "    AND mrbastus = 'Y' ",
               "    AND mrba100 = '1' ",
               "  ORDER BY mrba004 "
   PREPARE sffb010_02_desc_pb FROM l_sql
   DECLARE sffb010_02_desc_cs CURSOR FOR sffb010_02_desc_pb
   
   #單別
   LET l_sql = " SELECT DISTINCT ooba002,oobxl003 ",
               "   FROM ooba_t LEFT OUTER JOIN oobxl_t ON oobaent = oobxlent AND ooba002 = oobxl001 AND oobxl002 = '"||g_dlang||"',oobx_t,ooef_t ",
               "  WHERE oobaent = ",g_enterprise," AND oobastus = 'Y' ",
               "    AND ooefent = oobaent AND ooef001 = '",g_site,"' ",
               "    AND oobaent = oobxent AND ooba002 = oobx001 ",
               "    AND ooba001 = ooef004 AND oobx003= ? ",
               "  ORDER BY ooba002 "
   PREPARE sel_ooba_pb FROM l_sql
   DECLARE sel_ooba_cs CURSOR FOR sel_ooba_pb
   
   #庫位
   LET l_sql = " SELECT DISTINCT inaa001 ",
               "   FROM inaa_t ",
               "  WHERE inaaent = ",g_enterprise,
               "    AND inaasite = '",g_site,"' ",
               "    AND inaastus = 'Y' ",
               "  ORDER BY inaa001 "
   PREPARE sfhb003_pb FROM l_sql
   DECLARE sfhb003_cs CURSOR FOR sfhb003_pb
   
   #儲位
   LET l_sql = " SELECT DISTINCT inab002 ",
               "   FROM inab_t ",
               "  WHERE inabent = ",g_enterprise,
               "    AND inabsite = '",g_site,"' ",
               "    AND inabstus = 'Y' ",
               "  ORDER BY inab002 "
   PREPARE sfhb004_pb FROM l_sql
   DECLARE sfhb004_cs CURSOR FOR sfhb004_pb
   
   #料號
   LET l_sql = " SELECT DISTINCT imaf001 ",
               "   FROM imaf_t,imaa_t ",
               "  WHERE imaaent = ",g_enterprise,
               "    AND imaaent = imafent ",
               "    AND imaa001 = imaf001 ",
               "    AND imafsite = '",g_site,"' ",
               "    AND imaastus = 'Y' ",
               "  ORDER BY imaf001 "
   PREPARE sfha013_pb FROM l_sql
   DECLARE sfha013_cs CURSOR FOR sfha013_pb
   
   #讀取存在本機的設置－工作站、機台、作業、班別
   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),"asfp331.txt")
   CALL FGL_GETFILE("C:/asfp331.txt",ls_file)
   IF os.Path.exists(ls_file) THEN
	   LET lc_channel = base.Channel.create()
	   CALL lc_channel.openFile(ls_file,"r")
	   LET ls_count = 0
      WHILE TRUE
         LET ls_result = lc_channel.readLine()
         IF lc_channel.isEof() THEN
            EXIT WHILE
         END IF
#         LET ls_count = ls_count + 1
#         IF ls_count = 1 THEN
#            CONTINUE WHILE
#         END IF
         INITIALIZE g_sffb02_m.* TO NULL
         IF ls_result.getLength() > 0 THEN
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.sffb009_02
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.sffb007_02
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.sffb004_02
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.sffb010_02
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.docno_1
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.docno_2
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.docno_3
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.docno_4
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.docno_5
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.docno_6
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.sfhb003
            CALL asfp331_subString(ls_result) RETURNING ls_result,g_sffb02_m.sfhb004
         END IF
      END WHILE
      CALL lc_channel.close()
   END IF
   
   IF cl_null(g_sffb02_m.docno_1) THEN
      LET g_sffb02_m.docno_1 = cl_get_para(g_enterprise,g_site,'S-MFG-0035')
   END IF
   
   SELECT ecaa002 INTO g_sffb02_m.sffb009_02_desc
     FROM ecaa_t
    WHERE ecaaent = g_enterprise
      AND ecaasite = g_site
      AND ecaastus = 'Y'
      AND ecaa001 = g_sffb02_m.sffb009_02
   SELECT oocql004 INTO g_sffb02_m.sffb007_02_desc
     FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '221'
      AND oocql002 = g_sffb02_m.sffb007_02
      AND oocql003 = g_dlang
   SELECT oogd002 INTO g_sffb02_m.sffb004_02_desc
     FROM oogd_t
    WHERE oogdent = g_enterprise
      AND oogdsite = g_site
      AND oogd001 = g_sffb02_m.sffb004_02
   SELECT mrba004 INTO g_sffb02_m.sffb010_02_desc
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrbasite = g_site
      AND mrba001 = g_sffb02_m.sffb010_02

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp331.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp331_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_action_choice = 'menu'
   WHILE TRUE
      CASE g_action_choice
         WHEN 'menu'
            CALL cl_set_comp_visible("main_vbox01",TRUE)
            CALL asfp331_menu()
            CALL cl_set_comp_visible("main_vbox01",FALSE)
            
         WHEN 'movein'
            CALL cl_set_comp_visible("main_vbox03",TRUE)
            CALL asfp331_move('1')
            CALL cl_set_comp_visible("main_vbox03",FALSE)
            
         WHEN 'checkin'
            CALL cl_set_comp_visible("main_vbox04",TRUE)
            CALL asfp331_check('1')
            CALL cl_set_comp_visible("main_vbox04",FALSE)
            
         WHEN 'processing'
            CALL cl_set_comp_visible("main_vbox05",TRUE)
            CALL asfp331_processing()
            CALL cl_set_comp_visible("main_vbox05",FALSE)
            
         WHEN 'checkout'
            CALL cl_set_comp_visible("main_vbox04",TRUE)
            CALL asfp331_check('2')
            CALL cl_set_comp_visible("main_vbox04",FALSE)
            
         WHEN 'moveout'
            CALL cl_set_comp_visible("main_vbox03",TRUE)
            CALL asfp331_move('2')
            CALL cl_set_comp_visible("main_vbox03",FALSE)
            
         WHEN 'overview'
            CALL cl_set_comp_visible("main_vbox02",TRUE)
            CALL asfp331_overview()
            CALL cl_set_comp_visible("main_vbox02",FALSE)
            
         WHEN 'setup'
            CALL cl_set_comp_visible("main_vbox08",TRUE)
            CALL asfp331_setup()
            CALL cl_set_comp_visible("main_vbox08",FALSE)
            
         WHEN 'logout'
            EXIT WHILE
            
         WHEN 'exit'
            EXIT WHILE
            
         OTHERWISE
            EXIT WHILE
      END CASE
   END WHILE
   RETURN
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
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
            CALL asfp331_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
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
         CALL asfp331_init()
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
                 CALL asfp331_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = asfp331_transfer_argv(ls_js)
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
 
{<section id="asfp331.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION asfp331_transfer_argv(ls_js)
 
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
 
{<section id="asfp331.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION asfp331_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_n1          LIKE type_t.num5
   DEFINE l_n2          LIKE type_t.num5
   DEFINE l_sffb  RECORD
       sffbent    LIKE sffb_t.sffbent,     #企業編號
       sffbsite   LIKE sffb_t.sffbsite,    #營運據點
       sffbdocno  LIKE sffb_t.sffbdocno,   #報工單號
       sffbseq    LIKE sffb_t.sffbseq,     #項次
       sffbdocdt  LIKE sffb_t.sffbdocdt,   #單據日期
       sffb001    LIKE sffb_t.sffb001,     #報工類別1.Move in,2.Check in,3.報工,4.Check out,5.Move out
       sffb002    LIKE sffb_t.sffb002,     #報工人員
       sffb003    LIKE sffb_t.sffb003,     #部門
       sffb004    LIKE sffb_t.sffb004,     #報工班別
       sffb005    LIKE sffb_t.sffb005,     #工單單號
       sffb006    LIKE sffb_t.sffb006,     #Run Card
       sffb007    LIKE sffb_t.sffb007,     #作業編號
       sffb008    LIKE sffb_t.sffb008,     #製程式
       sffb009    LIKE sffb_t.sffb009,     #工作站
       sffb010    LIKE sffb_t.sffb010,     #機器編號
       sffb011    LIKE sffb_t.sffb011,     #作業人數
       sffb012    LIKE sffb_t.sffb012,     #完成日期
       sffb013    LIKE sffb_t.sffb013,     #完成時間
       sffb014    LIKE sffb_t.sffb014,     #工時
       sffb015    LIKE sffb_t.sffb015,     #機時
       sffb016    LIKE sffb_t.sffb016,     #單位
       sffb017    LIKE sffb_t.sffb017,     #良品數量
       sffb018    LIKE sffb_t.sffb018,     #報廢數量
       sffb019    LIKE sffb_t.sffb019,     #當站下線數量
       sffb020    LIKE sffb_t.sffb020,     #回收數量
       sffb023    LIKE sffb_t.sffb023,     #備註
       sffb024    LIKE sffb_t.sffb024,     #報工組別
       sffb025    LIKE sffb_t.sffb025,     #生產計畫
       sffb026    LIKE sffb_t.sffb026,     #生產料號
       sffb027    LIKE sffb_t.sffb027,     #BOM特性
       sffb028    LIKE sffb_t.sffb028,     #產品特徵
       sffbownid  LIKE sffb_t.sffbownid,   #資料所有者
       sffbowndp  LIKE sffb_t.sffbowndp,   #資料所屬部門
       sffbcrtid  LIKE sffb_t.sffbcrtid,   #資料建立者
       sffbcrtdp  LIKE sffb_t.sffbcrtdp,   #資料建立部門
       sffbcrtdt  LIKE sffb_t.sffbcrtdt,   #資料創建日
       sffbmodid  LIKE sffb_t.sffbmodid,   #資料修改者
       sffbmoddt  LIKE sffb_t.sffbmoddt,   #最近修改日
       sffbstus   LIKE sffb_t.sffbstus,    #狀態碼
       sffb029    LIKE sffb_t.sffb029,     #報工料號
       sffb030    LIKE sffb_t.sffb030      #成本中心
              END RECORD
   DEFINE l_sffd        type_g_sffd_d
   DEFINE l_sffc        type_g_sffc_d
   DEFINE l_sfhb  DYNAMIC ARRAY OF RECORD
       sfhb001    LIKE sfhb_t.sfhb001,
       sfhb002    LIKE sfhb_t.sfhb002,
       sfhb008    LIKE sfhb_t.sfhb008
              END RECORD
   DEFINE l_sfhb001     LIKE sfhb_t.sfhb001
   DEFINE l_sfhb002     LIKE sfhb_t.sfhb002
   DEFINE l_sfhb008     LIKE sfhb_t.sfhb008

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
#  DECLARE asfp331_process_cs CURSOR FROM ls_sql
#  FOREACH asfp331_process_cs INTO
   #add-point:process段process name="process.process"
   
   IF cl_null(g_sffb02_m.docno_1) OR
      cl_null(g_sffb02_m.docno_2) OR
      cl_null(g_sffb02_m.docno_3) OR
      cl_null(g_sffb02_m.docno_4) OR
      cl_null(g_sffb02_m.docno_5) OR
      cl_null(g_sffb02_m.docno_6) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend =  ""
      LET g_errparam.code   = 'asf-00716'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   LET l_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   INITIALIZE l_sffb.* TO NULL
   
   LET l_sffb.sffbent   = g_enterprise
   LET l_sffb.sffbsite  = g_site
   LET l_sffb.sffbseq   = 0
   LET l_sffb.sffbdocdt = cl_get_today()
   LET l_sffb.sffb002   = g_user
   LET l_sffb.sffb003   = g_dept
   LET l_sffb.sffb004   = g_sffb02_m.sffb004_02
   LET l_sffb.sffb009   = g_sffb02_m.sffb009_02
   LET l_sffb.sffb010   = g_sffb02_m.sffb010_02
   CASE g_action_choice
      WHEN 'movein'
         LET l_sffb.sffb001   = '1'
         LET l_sffb.sffb005   = g_sfcb09_m.sfcbdocno_09
         LET l_sffb.sffb006   = g_sfcb09_m.sfcb001_09
         LET l_sffb.sffbdocno = g_sffb02_m.docno_2  #160406 by whitney add
        #LET l_sffb.sffb023   = g_sffb02_m.docno_2  #160406 by whitney mark
         SELECT sfcb003,sfcb004 INTO l_sffb.sffb007,l_sffb.sffb008
           FROM movein_tmp
          WHERE sfcbdocno = l_sffb.sffb005
            AND sfcb001 = l_sffb.sffb006
      WHEN 'checkin'
         LET l_sffb.sffb001   = '2'
         LET l_sffb.sffb005   = g_sfcb08_m.sfcbdocno_08
         LET l_sffb.sffb006   = g_sfcb08_m.sfcb001_08
         LET l_sffb.sffbdocno = g_sffb02_m.docno_4  #160406 by whitney add
        #LET l_sffb.sffb023   = g_sffb02_m.docno_4  #160406 by whitney mark
         SELECT sfcb003,sfcb004 INTO l_sffb.sffb007,l_sffb.sffb008
           FROM checkin_tmp
          WHERE sfcbdocno = l_sffb.sffb005
            AND sfcb001 = l_sffb.sffb006
      WHEN 'processing'
         LET l_sffb.sffb001   = '3'
         LET l_sffb.sffb005   = g_sffb_m.sffb005
         LET l_sffb.sffb006   = g_sffb_m.sffb006
         LET l_sffb.sffbdocno = g_sffb02_m.docno_1  #160406 by whitney add
        #LET l_sffb.sffb023   = g_sffb02_m.docno_1  #160406 by whitney mark
         SELECT sfcb003,sfcb004 INTO l_sffb.sffb007,l_sffb.sffb008
           FROM processing_tmp
          WHERE sfcbdocno = l_sffb.sffb005
            AND sfcb001 = l_sffb.sffb006
      WHEN 'checkout'
         LET l_sffb.sffb001   = '4'
         LET l_sffb.sffb005   = g_sfcb08_m.sfcbdocno_08
         LET l_sffb.sffb006   = g_sfcb08_m.sfcb001_08
         LET l_sffb.sffbdocno = g_sffb02_m.docno_3  #160406 by whitney add
        #LET l_sffb.sffb023   = g_sffb02_m.docno_3  #160406 by whitney mark
         SELECT sfcb003,sfcb004 INTO l_sffb.sffb007,l_sffb.sffb008
           FROM checkout_tmp
          WHERE sfcbdocno = l_sffb.sffb005
            AND sfcb001 = l_sffb.sffb006
      WHEN 'moveout'
         LET l_sffb.sffb001   = '5'
         LET l_sffb.sffb005   = g_sfcb09_m.sfcbdocno_09
         LET l_sffb.sffb006   = g_sfcb09_m.sfcb001_09
         LET l_sffb.sffbdocno = g_sffb02_m.docno_5  #160406 by whitney add
        #LET l_sffb.sffb023   = g_sffb02_m.docno_5  #160406 by whitney mark
         SELECT sfcb003,sfcb004 INTO l_sffb.sffb007,l_sffb.sffb008
           FROM moveout_tmp
          WHERE sfcbdocno = l_sffb.sffb005
            AND sfcb001 = l_sffb.sffb006
      OTHERWISE
         EXIT CASE
   END CASE
   #160406 by whitney add start
   #因为产生的资料是在asft335查询维护的，所以作业编号写asft335的
   CALL s_aooi200_gen_docno(g_site,l_sffb.sffbdocno,l_sffb.sffbdocdt,'asft335')
        RETURNING l_success,l_sffb.sffbdocno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_sffb.sffbdocno
      LET g_errparam.code   = 'apm-00003'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160406 by whitney add end
#160406 by whitney mark start
#   #Light平台單號存流水碼，備註存放單別
#   LET l_n = 0
#   SELECT MAX(sffbdocno)+1 INTO l_n
#     FROM sffb_t
#    WHERE sffbent = g_enterprise
#   IF cl_null(l_n) OR l_n = 0 THEN
#      LET l_n = 1
#   END IF
#   LET l_sffb.sffbdocno = l_n USING "&&&&&&&&&&&&&&&&&&&&"
#160406 by whitney mark end
   IF l_sffb.sffb007 IS NULL THEN LET l_sffb.sffb007 = ' ' END IF
   IF l_sffb.sffb008 IS NULL THEN LET l_sffb.sffb008 = ' ' END IF
   LET l_sffb.sffb011   = 1
   LET l_sffb.sffb012   = cl_get_today()
   LET l_sffb.sffb013   = cl_get_time()
   LET l_sffb.sffb014 = s_asft335_get_working_time(l_sffb.sffb001,l_sffb.sffb005,l_sffb.sffb006,l_sffb.sffb007,l_sffb.sffb008,l_sffb.sffb012,l_sffb.sffb013)
   LET l_sffb.sffb015 = s_asft335_get_working_time(l_sffb.sffb001,l_sffb.sffb005,l_sffb.sffb006,l_sffb.sffb007,l_sffb.sffb008,l_sffb.sffb012,l_sffb.sffb013)
   CALL s_asft335_set_qty('','',l_sffb.sffb001,l_sffb.sffb005,l_sffb.sffb006,l_sffb.sffb007,l_sffb.sffb008)
        RETURNING l_sffb.sffb017,l_sffb.sffb016
   LET l_sffb.sffb018   = 0
   LET l_sffb.sffb019   = 0
   LET l_sffb.sffb020   = 0
   IF g_action_choice = 'processing' THEN
      LET l_sffb.sffb012 = g_sffb_m.sffb012
      LET l_sffb.sffb013 = g_sffb_m.sffb013
      LET l_sffb.sffb014 = g_sffb_m.sffb014
      LET l_sffb.sffb015 = g_sffb_m.sffb015
      LET l_sffb.sffb017 = g_sffb_m.sffb017
      LET l_sffb.sffb018 = g_sffb_m.sffb018
      LET l_sffb.sffb019 = g_sffb_m.sffb019
   END IF
   SELECT sfaa010,sfaa068 INTO l_sffb.sffb029,l_sffb.sffb030
     FROM sfaa_t
    WHERE sfaaent = l_sffb.sffbent
      AND sfaadocno = l_sffb.sffb005
   LET l_sffb.sffb023   = ''
   LET l_sffb.sffb025   = ''
   LET l_sffb.sffb026   = ''
   LET l_sffb.sffb027   = ''
   LET l_sffb.sffb028   = ''
   LET l_sffb.sffbownid = g_user
   LET l_sffb.sffbowndp = g_dept
   LET l_sffb.sffbcrtid = g_user
   LET l_sffb.sffbcrtdp = g_dept
   LET l_sffb.sffbcrtdt = cl_get_current()
   LET l_sffb.sffbmodid = g_user
   LET l_sffb.sffbmoddt = cl_get_current()
   LET l_sffb.sffbstus  = 'N'
   #報工組別
   SELECT oogf001 INTO l_sffb.sffb024
     FROM oogf_t 
    WHERE oogfent  = l_sffb.sffbent
      AND oogfsite = l_sffb.sffbsite
      AND oogf002  = l_sffb.sffb002
      AND oogfstus = 'Y'
      AND oogf003 <= l_sffb.sffbdocdt
      AND ROWNUM  <= 1
    ORDER BY oogf001
   #预设人数，这个组别在aooi428里，日期有效的条件下的人数
   LET l_n1 = 0
   SELECT COUNT(oogf002) INTO l_n1
     FROM oogf_t
    WHERE oogfent  = l_sffb.sffbent
      AND oogfsite = l_sffb.sffbsite
      AND oogf001  = l_sffb.sffb024
      AND oogfstus = 'Y'
      AND oogf003 <= l_sffb.sffbdocdt
   IF cl_null(l_n1) THEN LET l_n1 = 0 END IF
   #因为失效日期可能输可能没输，所以前面只统计大于等于生效日期的人数是不准的，还要减掉大于等于失效日期的人数
   LET l_n2 = 0
   SELECT COUNT(oogf002) INTO l_n2
     FROM oogf_t
    WHERE oogfent  = l_sffb.sffbent
      AND oogfsite = l_sffb.sffbsite
      AND oogf001  = l_sffb.sffb024
      AND oogfstus = 'Y'
      AND oogf004 <= l_sffb.sffbdocdt
   IF cl_null(l_n2) THEN LET l_n2 = 0 END IF
   LET l_sffb.sffb011 = l_n1 - l_n2
   #组别为空的时候，预设人数为1
   IF cl_null(l_sffb.sffb011) OR l_sffb.sffb011 = 0 THEN
      LET l_sffb.sffb011 = 1
   END IF
   
   #提交sffb
   INSERT INTO sffb_t(sffbent,sffbsite,sffbdocno,sffbseq,sffbdocdt,
                      sffb001,sffb002,sffb003,sffb004,sffb005,sffb006,sffb007,sffb008,sffb009,sffb010,
                      sffb011,sffb012,sffb013,sffb014,sffb015,sffb016,sffb017,sffb018,sffb019,sffb020,
                      sffb023,sffb024,sffb025,sffb026,sffb027,sffb028,sffb029,sffb030,
                      sffbownid,sffbowndp,sffbcrtid,sffbcrtdp,sffbcrtdt,sffbmodid,sffbmoddt,sffbstus)
          VALUES (l_sffb.sffbent,l_sffb.sffbsite,l_sffb.sffbdocno,l_sffb.sffbseq,l_sffb.sffbdocdt,
                  l_sffb.sffb001,l_sffb.sffb002,l_sffb.sffb003,l_sffb.sffb004,l_sffb.sffb005,
                  l_sffb.sffb006,l_sffb.sffb007,l_sffb.sffb008,l_sffb.sffb009,l_sffb.sffb010,
                  l_sffb.sffb011,l_sffb.sffb012,l_sffb.sffb013,l_sffb.sffb014,l_sffb.sffb015,
                  l_sffb.sffb016,l_sffb.sffb017,l_sffb.sffb018,l_sffb.sffb019,l_sffb.sffb020,
                  l_sffb.sffb023,l_sffb.sffb024,l_sffb.sffb025,l_sffb.sffb026,l_sffb.sffb027,
                  l_sffb.sffb028,l_sffb.sffb029,l_sffb.sffb030,
                  l_sffb.sffbownid,l_sffb.sffbowndp,l_sffb.sffbcrtid,l_sffb.sffbcrtdp,
                  l_sffb.sffbcrtdt,l_sffb.sffbmodid,l_sffb.sffbmoddt,l_sffb.sffbstus) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT sffb_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   
   #提交sffd
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM defect_tmp
   IF cl_null(l_n) THEN LET l_n = 0 END IF
   IF l_n > 0 THEN
      INITIALIZE l_sffd.* TO NULL
      DECLARE sel_defect_tmp_cs CURSOR FOR
         SELECT sffdseq1,sffd001,sffd002,sffd003 FROM defect_tmp
      FOREACH sel_defect_tmp_cs INTO l_sffd.sffdseq1,l_sffd.sffd001,l_sffd.sffd002,l_sffd.sffd003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "sel_defect_tmp_cs"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         INSERT INTO sffd_t(sffdent,sffdsite,sffddocno,sffdseq,sffdseq1,sffd001,sffd002,sffd003)
                VALUES(l_sffb.sffbent,l_sffb.sffbsite,l_sffb.sffbdocno,l_sffb.sffbseq,
                       l_sffd.sffdseq1,l_sffd.sffd001,l_sffd.sffd002,l_sffd.sffd003)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "INSERT sffd_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END FOREACH
      FREE sel_defect_tmp_cs
   END IF
   
   #提交sffc
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM check_tmp
   IF cl_null(l_n) THEN LET l_n = 0 END IF
   IF l_n > 0 THEN
      INITIALIZE l_sffc.* TO NULL
      DECLARE sel_check_tmp_cs CURSOR FOR
         SELECT sffc001,sffc002,sffc003,sffc004,sffc005,sffc006 FROM check_tmp
      FOREACH sel_check_tmp_cs INTO l_sffc.sffc001,l_sffc.sffc002,l_sffc.sffc003,
                                    l_sffc.sffc004,l_sffc.sffc005,l_sffc.sffc006
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "sel_check_tmp_cs"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         INSERT INTO sffc_t(sffcent,sffcsite,sffcdocno,sffcseq,sffc001,
                            sffc002,sffc003,sffc004,sffc005,sffc006)
                VALUES(l_sffb.sffbent,l_sffb.sffbsite,l_sffb.sffbdocno,l_sffb.sffbseq,l_sffc.sffc001,
                       l_sffc.sffc002,l_sffc.sffc003,l_sffc.sffc004,l_sffc.sffc005,l_sffc.sffc006)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "INSERT sffc_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END FOREACH
      FREE sel_check_tmp_cs
   END IF
   
   LET l_n = 1
   CALL l_sfhb.clear()
   DECLARE sel_offline_tmp CURSOR FOR
      SELECT sfha013,sfha015,sfha008 FROM offline_tmp
   FOREACH sel_offline_tmp INTO l_sfhb001,l_sfhb002,l_sfhb008
      LET l_sfhb[l_n].sfhb001 = l_sfhb001
      LET l_sfhb[l_n].sfhb002 = l_sfhb002
      LET l_sfhb[l_n].sfhb008 = l_sfhb008
      LET l_n = l_n + 1
   END FOREACH
   CALL l_sfhb.deleteElement(l_sfhb.getLength())
   
   IF NOT s_asft335_ins_shf(g_sffb02_m.docno_6,l_sffb.sffbdocno,l_sffb.sffbseq,g_sffb02_m.sfhb003,g_sffb02_m.sfhb004,l_sfhb) THEN
      LET l_success = FALSE
   END IF
   
   #报工单审核更新制程档   
   IF NOT s_asft335_conf(l_sffb.sffbdocno) THEN
      LET l_success = FALSE
   END IF
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_sffb.sffbdocno
      LET g_errparam.code   = 'asf-00128'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   ELSE
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'asf-00153'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
   CALL cl_err_collect_show()
   
   LET g_action_choice = 'menu'
   RETURN
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
 
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL asfp331_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="asfp331.get_buffer" >}
PRIVATE FUNCTION asfp331_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfp331.msgcentre_notify" >}
PRIVATE FUNCTION asfp331_msgcentre_notify()
 
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
 
{<section id="asfp331.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 主選單
# Memo...........: 
# Usage..........: CALL asfp331_menu()
# Input parameter: 
# Return code....: 
# Date & Author..: 160114 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_menu()

   MENU
   
      BEFORE MENU
         CLEAR FORM
         INITIALIZE g_sffb01_m.* TO NULL
         LET g_sffb01_m.sffb009_01 = g_sffb02_m.sffb009_02
         LET g_sffb01_m.sffb007_01 = g_sffb02_m.sffb007_02
         LET g_sffb01_m.sffb004_01 = g_sffb02_m.sffb004_02
         LET g_sffb01_m.sffb010_01 = g_sffb02_m.sffb010_02
         LET g_sffb01_m.sffb009_01_desc = g_sffb02_m.sffb009_02_desc
         LET g_sffb01_m.sffb007_01_desc = g_sffb02_m.sffb007_02_desc
         LET g_sffb01_m.sffb004_01_desc = g_sffb02_m.sffb004_02_desc
         LET g_sffb01_m.sffb010_01_desc = g_sffb02_m.sffb010_02_desc
         DISPLAY BY NAME g_sffb01_m.sffb009_01,g_sffb01_m.sffb009_01_desc,
                         g_sffb01_m.sffb007_01,g_sffb01_m.sffb007_01_desc,
                         g_sffb01_m.sffb004_01,g_sffb01_m.sffb004_01_desc,
                         g_sffb01_m.sffb010_01,g_sffb01_m.sffb010_01_desc
         
      ON ACTION movein
         LET g_action_choice = "movein"
         EXIT MENU
      
      ON ACTION checkin
         LET g_action_choice = "checkin"
         EXIT MENU
      
      ON ACTION processing
         LET g_action_choice = "processing"
         EXIT MENU
      
      ON ACTION checkout
         LET g_action_choice = "checkout"
         EXIT MENU
      
      ON ACTION moveout
         LET g_action_choice = "moveout"
         EXIT MENU
      
      ON ACTION overview
         LET g_action_choice = "overview"
         EXIT MENU
      
      ON ACTION setup
         LET g_action_choice = "setup"
         EXIT MENU
      
      ON ACTION logout
         LET g_action_choice = "logout"
         EXIT MENU
      
      #公用action
      ON ACTION close
         LET g_action_choice = "exit"
         EXIT MENU
      
      ON ACTION exit
         LET g_action_choice = "exit"
         EXIT MENU
      
      #主選單用ACTION
      &include "main_menu_exit_menu.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
   END MENU

END FUNCTION

################################################################################
# Descriptions...: 抓取目前在該站的工單
# Memo...........:
# Usage..........: CALL asfp331_sfcbdocno()
# Input parameter: 
# Return code....: 
# Date & Author..: 160115 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_sfcbdocno()
DEFINE l_sql        STRING
DEFINE l_sfcb  RECORD
    sfcbdocno  LIKE sfcb_t.sfcbdocno,
    sfcb001    LIKE sfcb_t.sfcb001,
    sfcb002    LIKE sfcb_t.sfcb002,
    sfaa010    LIKE sfaa_t.sfaa010,
    imaal003   LIKE imaal_t.imaal003,
    imaal004   LIKE imaal_t.imaal004,
    sfcb003    LIKE sfcb_t.sfcb003,
    oocql004   LIKE oocql_t.oocql004,
    sfcb004    LIKE sfcb_t.sfcb004,
    sfcb046    LIKE sfcb_t.sfcb046,
    sfcb047    LIKE sfcb_t.sfcb047,
    sfcb048    LIKE sfcb_t.sfcb048,
    sfcb049    LIKE sfcb_t.sfcb049,
    sfcb050    LIKE sfcb_t.sfcb050,
    sfcb017    LIKE sfcb_t.sfcb017
           END RECORD
DEFINE l_qty1       LIKE sfcb_t.sfcb050
DEFINE l_qty2       LIKE sfcb_t.sfcb050
DEFINE l_qty3       LIKE sfcb_t.sfcb050
DEFINE l_qty4       LIKE sfcb_t.sfcb050

   DELETE FROM movein_tmp
   DELETE FROM checkin_tmp
   DELETE FROM checkout_tmp
   DELETE FROM moveout_tmp
   DELETE FROM processing_tmp
   
   LET l_sql = " SELECT UNIQUE sfcbdocno,sfcb001,sfcb002,sfaa010,imaal003,imaal004,sfcb003,oocql004,sfcb004, ",
               "        NVL(sfcb046,0),NVL(sfcb047,0),NVL(sfcb048,0),NVL(sfcb049,0),NVL(sfcb050,0),sfcb017 ",
               "   FROM sfcb_t LEFT OUTER JOIN oocql_t ON oocqlent = sfcbent AND oocql001 = '221' AND oocql002 = sfcb003 AND oocql003 = '"||g_dlang||"' ",
               "      , sfaa_t LEFT OUTER JOIN imaal_t ON imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '"||g_dlang||"' ",
               "  WHERE sfcbent = ",g_enterprise," AND sfcbsite = '",g_site,"' ",
               "    AND sfaaent = sfcbent AND sfaasite = sfcbsite AND sfaadocno = sfcbdocno ",
               "    AND ( NVL(sfcb046,0) > 0 OR NVL(sfcb047,0) > 0 OR NVL(sfcb048,0) > 0 OR NVL(sfcb049,0) > 0 OR NVL(sfcb050,0) > 0 ) "
   IF NOT cl_null(g_sffb02_m.sffb007_02) THEN
      LET l_sql = l_sql," AND sfcb003 = '",g_sffb02_m.sffb007_02,"' "
   END IF
   IF NOT cl_null(g_sffb02_m.sffb009_02) THEN
      LET l_sql = l_sql," AND sfcb011 = '",g_sffb02_m.sffb009_02,"' "
   END IF
   LET l_sql = l_sql," ORDER BY sfcbdocno "
   PREPARE asfp331_sfcbdocno_pb FROM l_sql
   DECLARE asfp331_sfcbdocno_cs CURSOR FOR asfp331_sfcbdocno_pb
   
   INITIALIZE l_sfcb.* TO NULL
   FOREACH asfp331_sfcbdocno_cs
     INTO l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,l_sfcb.sfaa010,l_sfcb.imaal003,l_sfcb.imaal004,
          l_sfcb.sfcb003,l_sfcb.oocql004,l_sfcb.sfcb004,l_sfcb.sfcb046,l_sfcb.sfcb047,
          l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb017
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF l_sfcb.sfcb046 > 0 THEN
         INSERT INTO movein_tmp
                VALUES(l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,l_sfcb.sfaa010,
                       l_sfcb.imaal003,l_sfcb.imaal004,l_sfcb.sfcb003,
                       l_sfcb.oocql004,l_sfcb.sfcb004,l_sfcb.sfcb046)
      END IF
      
      IF l_sfcb.sfcb047 > 0 THEN
         INSERT INTO checkin_tmp
                VALUES(l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,l_sfcb.sfaa010,
                       l_sfcb.imaal003,l_sfcb.imaal004,l_sfcb.sfcb003,
                       l_sfcb.oocql004,l_sfcb.sfcb004,l_sfcb.sfcb047)
      END IF
      
      IF l_sfcb.sfcb048 > 0 THEN
         INSERT INTO checkout_tmp
                VALUES(l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,l_sfcb.sfaa010,
                       l_sfcb.imaal003,l_sfcb.imaal004,l_sfcb.sfcb003,
                       l_sfcb.oocql004,l_sfcb.sfcb004,l_sfcb.sfcb048)
      END IF
      
      IF l_sfcb.sfcb049 > 0 THEN
         INSERT INTO moveout_tmp
                VALUES(l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,l_sfcb.sfaa010,
                       l_sfcb.imaal003,l_sfcb.imaal004,l_sfcb.sfcb003,
                       l_sfcb.oocql004,l_sfcb.sfcb004,l_sfcb.sfcb049)
      END IF
      
      LET l_qty1 = 0
      LET l_qty2 = 0
      LET l_qty3 = 0
      LET l_qty4 = 0
      #若有PQC,則待處理數量應取PQC檢驗合格量
      IF l_sfcb.sfcb017 = 'Y' THEN
         #PQC檢驗合格量
         SELECT SUM(NVL(qcba023,0)) INTO l_sfcb.sfcb050
           FROM qcba_t
          WHERE qcbaent  = g_enterprise
            AND qcbasite = g_site
            AND qcba000  = '3'                     #PQC
            AND qcba001  = l_sfcb.sfcbdocno        #來源單據
            AND qcba029  = l_sfcb.sfcb001          #RunCard
            AND qcba006  = l_sfcb.sfcb003          #作業編號
            AND qcba007  = l_sfcb.sfcb004          #製程序
            AND (qcba022 = '1' OR qcba022 = '4')   #判定結果(1.合格 4.特採)
            AND qcbastus = 'Y'                     #狀態碼
         #扣除其他未审核报工单的良品转出量，不含本站良品转出，本站的显示在画面sffb017上
         #报工类型要多扣除当站下线，作废和回收，但是不能扣除本站的，本站的会显示在画面对应栏位上
         SELECT SUM(NVL(sffb017,0)),(SUM(NVL(sffb018,0))+SUM(NVL(sffb019,0))+SUM(NVL(sffb020,0)))
           INTO l_qty2,l_qty1
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = '3'
            AND sffb005  = l_sfcb.sfcbdocno
            AND sffb006  = l_sfcb.sfcb001
            AND sffb007  = l_sfcb.sfcb003
            AND sffb008  = l_sfcb.sfcb004
            AND sffbstus <> 'X'
         #本站的
         SELECT SUM(NVL(sffb017,0)),(SUM(NVL(sffb018,0))+SUM(NVL(sffb019,0))+SUM(NVL(sffb020,0)))
           INTO l_qty4,l_qty3
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = '3'
            AND sffb005  = l_sfcb.sfcbdocno
            AND sffb006  = l_sfcb.sfcb001
            AND sffb007  = l_sfcb.sfcb003
            AND sffb008  = l_sfcb.sfcb004
            AND sffbdocno = ''
            AND sffbseq  = ''
            AND sffbstus <> 'X'
      ELSE
         #报工类型要多扣除当站下线，作废和回收，但是不能扣除本站的，本站的会显示在画面对应栏位上
         SELECT SUM(NVL(sffb017,0)),(SUM(NVL(sffb018,0))+SUM(NVL(sffb019,0))+SUM(NVL(sffb020,0)))
           INTO l_qty2,l_qty1
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = '3'
            AND sffb005  = l_sfcb.sfcbdocno
            AND sffb006  = l_sfcb.sfcb001
            AND sffb007  = l_sfcb.sfcb003
            AND sffb008  = l_sfcb.sfcb004
            AND sffbstus = 'N'
         #本站的
         SELECT SUM(NVL(sffb017,0)),(SUM(NVL(sffb018,0))+SUM(NVL(sffb019,0))+SUM(NVL(sffb020,0)))
           INTO l_qty4,l_qty3
           FROM sffb_t
          WHERE sffbent   = g_enterprise
            AND sffbsite  = g_site
            AND sffb001   = '3'
            AND sffb005   = l_sfcb.sfcbdocno
            AND sffb006   = l_sfcb.sfcb001
            AND sffb007   = l_sfcb.sfcb003
            AND sffb008   = l_sfcb.sfcb004
            AND sffbdocno = ''
            AND sffbseq   = ''
            AND sffbstus  = 'N'
      END IF
      IF l_sfcb.sfcb050 IS NULL THEN LET l_sfcb.sfcb050 = 0 END IF
      IF l_qty1 IS NULL THEN LET l_qty1 = 0 END IF
      IF l_qty2 IS NULL THEN LET l_qty2 = 0 END IF 
      IF l_qty3 IS NULL THEN LET l_qty3 = 0 END IF
      IF l_qty4 IS NULL THEN LET l_qty4 = 0 END IF    
      LET l_sfcb.sfcb050 = l_sfcb.sfcb050 - l_qty1 + l_qty3 - l_qty2 + l_qty4   
      IF l_sfcb.sfcb050 > 0 THEN
         INSERT INTO processing_tmp
                VALUES(l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,l_sfcb.sfaa010,
                       l_sfcb.imaal003,l_sfcb.imaal004,l_sfcb.sfcb003,
                       l_sfcb.oocql004,l_sfcb.sfcb004,l_sfcb.sfcb050)
      END IF
      
      INITIALIZE l_sfcb.* TO NULL
   END FOREACH
   
   FREE asfp331_sfcbdocno_pb

END FUNCTION

################################################################################
# Descriptions...: 工單
# Memo...........:
# Usage..........: CALL asfp331_set_combo_sfcbdocno(p_tmp,p_field)
# Input parameter: 
# Return code....: 
# Date & Author..: 160118 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_set_combo_sfcbdocno(p_tmp,p_field)
DEFINE p_tmp        STRING
DEFINE p_field      STRING
DEFINE l_sql        STRING
DEFINE l_n          LIKE type_t.num5
DEFINE l_sfcbdocno  LIKE sfcb_t.sfcbdocno

   CALL asfp331_sfcbdocno()

   LET l_sql = " SELECT DISTINCT sfcbdocno FROM ",p_tmp," ORDER BY sfcbdocno "
   PREPARE asfp331_set_combo_sfcbdocno_pb FROM l_sql
   DECLARE asfp331_set_combo_sfcbdocno_cs CURSOR FOR asfp331_set_combo_sfcbdocno_pb
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH asfp331_set_combo_sfcbdocno_cs INTO l_sfcbdocno
      LET pa_array[l_n].value = l_sfcbdocno CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail(p_field, pa_array)
   FREE asfp331_set_combo_sfcbdocno_pb
END FUNCTION

################################################################################
# Descriptions...: R/C
# Memo...........:
# Usage..........: CALL asfp331_set_combo_sfcb001(p_tmp,p_sfcbdocno,p_field)
# Input parameter: 
# Return code....: 
# Date & Author..: 160118 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_set_combo_sfcb001(p_tmp,p_sfcbdocno,p_field)
DEFINE p_tmp        STRING
DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE p_field      STRING
DEFINE l_sql        STRING
DEFINE l_n          LIKE type_t.num5
DEFINE l_sfcb001    LIKE sfcb_t.sfcb001

   CALL asfp331_sfcbdocno()
   
   LET l_sql = " SELECT DISTINCT sfcb001 FROM ",p_tmp
   IF NOT cl_null(p_sfcbdocno) THEN
      LET l_sql = l_sql," WHERE sfcbdocno = '",p_sfcbdocno,"' "
   END IF
   LET l_sql = l_sql," ORDER BY sfcb001 "
   PREPARE asfp331_set_combo_sfcb001_pb FROM l_sql
   DECLARE asfp331_set_combo_sfcb001_cs CURSOR FOR asfp331_set_combo_sfcb001_pb
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH asfp331_set_combo_sfcb001_cs INTO l_sfcb001
      LET pa_array[l_n].value = l_sfcb001 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail(p_field, pa_array)
   FREE asfp331_set_combo_sfcb001_pb
END FUNCTION

################################################################################
# Descriptions...: 在線工單查看
# Memo...........: 
# Usage..........: CALL asfp331_overview()
# Input parameter: 
# Return code....: 
# Date & Author..: 160114 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_overview()

   CALL asfp331_sfcbdocno()
   CALL asfp331_overview_b_fill()
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      DISPLAY ARRAY g_sfcb1_d TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfp331_overview_idx_chk()
         BEFORE DISPLAY
            LET g_current_page = 1
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfp331_overview_idx_chk()
            DISPLAY g_sfcb1_d.getLength() TO h_count
      END DISPLAY

      DISPLAY ARRAY g_sfcb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            CALL asfp331_overview_idx_chk()
         BEFORE DISPLAY
            LET g_current_page = 2
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfp331_overview_idx_chk()
            DISPLAY g_sfcb2_d.getLength() TO h_count
      END DISPLAY

      DISPLAY ARRAY g_sfcb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            CALL asfp331_overview_idx_chk()
         BEFORE DISPLAY
            LET g_current_page = 3
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfp331_overview_idx_chk()
            DISPLAY g_sfcb3_d.getLength() TO h_count
      END DISPLAY

      DISPLAY ARRAY g_sfcb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_detail_cnt)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
            CALL asfp331_overview_idx_chk()
         BEFORE DISPLAY
            LET g_current_page = 4
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfp331_overview_idx_chk()
            DISPLAY g_sfcb4_d.getLength() TO h_count
      END DISPLAY

      DISPLAY ARRAY g_sfcb5_d TO s_detail5.* ATTRIBUTES(COUNT=g_detail_cnt)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
            CALL asfp331_overview_idx_chk()
         BEFORE DISPLAY
            LET g_current_page = 5
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfp331_overview_idx_chk()
            DISPLAY g_sfcb5_d.getLength() TO h_count
      END DISPLAY

      ON ACTION menu
         LET g_action_choice = 'menu'
         EXIT DIALOG

      ON ACTION close
         LET g_action_choice = 'exit'
         EXIT DIALOG

      ON ACTION exit
         LET g_action_choice = 'exit'
         EXIT DIALOG

      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
END FUNCTION

################################################################################
# Descriptions...: 單身陣列填充
# Memo...........:
# Usage..........: CALL asfp331_overview_b_fill()
# Input parameter: 
# Return code....: 
# Date & Author..: 160114 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_overview_b_fill()
DEFINE l_msg        STRING

   CALL g_sfcb1_d.clear()
   CALL g_sfcb2_d.clear()
   CALL g_sfcb3_d.clear()
   CALL g_sfcb4_d.clear()
   CALL g_sfcb5_d.clear()
   
   LET l_ac = 1
   DECLARE movein_cs CURSOR FOR
      SELECT sfcbdocno,sfcb001,sfaa010,imaal003,imaal004,sfcb003,oocql004,sfcb004,sfcb046
        FROM movein_tmp
   FOREACH movein_cs INTO g_sfcb1_d[l_ac].sfcbdocno_1,g_sfcb1_d[l_ac].sfcb001_1,g_sfcb1_d[l_ac].sfaa010_1,
                          g_sfcb1_d[l_ac].sfaa010_1_desc,g_sfcb1_d[l_ac].sfaa010_1_desc_1,g_sfcb1_d[l_ac].sfcb003_1,
                          g_sfcb1_d[l_ac].sfcb003_1_desc,g_sfcb1_d[l_ac].sfcb004_1,g_sfcb1_d[l_ac].sfcb046_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   IF l_ac > 1 THEN
      LET l_ac = l_ac - 1
   ELSE
      LET l_ac = 0
   END IF
   LET l_msg = cl_getmsg_parm('asf-00283',g_dlang,l_ac)
   CALL cl_set_comp_att_text('bpage_1',l_msg)
   
   LET l_ac = 1
   DECLARE checkin_cs CURSOR FOR
      SELECT sfcbdocno,sfcb001,sfaa010,imaal003,imaal004,sfcb003,oocql004,sfcb004,sfcb047
        FROM checkin_tmp
   FOREACH checkin_cs INTO g_sfcb2_d[l_ac].sfcbdocno_2,g_sfcb2_d[l_ac].sfcb001_2,g_sfcb2_d[l_ac].sfaa010_2,
                           g_sfcb2_d[l_ac].sfaa010_2_desc,g_sfcb2_d[l_ac].sfaa010_2_desc_1,g_sfcb2_d[l_ac].sfcb003_2,
                           g_sfcb2_d[l_ac].sfcb003_2_desc,g_sfcb2_d[l_ac].sfcb004_2,g_sfcb2_d[l_ac].sfcb047_2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   IF l_ac > 1 THEN
      LET l_ac = l_ac - 1
   ELSE
      LET l_ac = 0
   END IF
   LET l_msg = cl_getmsg_parm('asf-00284',g_dlang,l_ac)
   CALL cl_set_comp_att_text('page_2',l_msg)
   
   LET l_ac = 1
   DECLARE checkout_cs CURSOR FOR
      SELECT sfcbdocno,sfcb001,sfaa010,imaal003,imaal004,sfcb003,oocql004,sfcb004,sfcb048
        FROM checkout_tmp
   FOREACH checkout_cs INTO g_sfcb4_d[l_ac].sfcbdocno_4,g_sfcb4_d[l_ac].sfcb001_4,g_sfcb4_d[l_ac].sfaa010_4,
                            g_sfcb4_d[l_ac].sfaa010_4_desc,g_sfcb4_d[l_ac].sfaa010_4_desc_1,g_sfcb4_d[l_ac].sfcb003_4,
                            g_sfcb4_d[l_ac].sfcb003_4_desc,g_sfcb4_d[l_ac].sfcb004_4,g_sfcb4_d[l_ac].sfcb048_4
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   IF l_ac > 1 THEN
      LET l_ac = l_ac - 1
   ELSE
      LET l_ac = 0
   END IF
   LET l_msg = cl_getmsg_parm('asf-00286',g_dlang,l_ac)
   CALL cl_set_comp_att_text('page_4',l_msg)
   
   LET l_ac = 1
   DECLARE moveout_cs CURSOR FOR
      SELECT sfcbdocno,sfcb001,sfaa010,imaal003,imaal004,sfcb003,oocql004,sfcb004,sfcb049
        FROM moveout_tmp
   FOREACH moveout_cs INTO g_sfcb5_d[l_ac].sfcbdocno_5,g_sfcb5_d[l_ac].sfcb001_5,g_sfcb5_d[l_ac].sfaa010_5,
                           g_sfcb5_d[l_ac].sfaa010_5_desc,g_sfcb5_d[l_ac].sfaa010_5_desc_1,g_sfcb5_d[l_ac].sfcb003_5,
                           g_sfcb5_d[l_ac].sfcb003_5_desc,g_sfcb5_d[l_ac].sfcb004_5,g_sfcb5_d[l_ac].sfcb049_5
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   IF l_ac > 1 THEN
      LET l_ac = l_ac - 1
   ELSE
      LET l_ac = 0
   END IF
   LET l_msg = cl_getmsg_parm('asf-00287',g_dlang,l_ac)
   CALL cl_set_comp_att_text('page_5',l_msg)
   
   LET l_ac = 1
   DECLARE processing_cs CURSOR FOR
      SELECT sfcbdocno,sfcb001,sfaa010,imaal003,imaal004,sfcb003,oocql004,sfcb004,sfcb050
        FROM processing_tmp
   FOREACH processing_cs INTO g_sfcb3_d[l_ac].sfcbdocno_3,g_sfcb3_d[l_ac].sfcb001_3,g_sfcb3_d[l_ac].sfaa010_3,
                              g_sfcb3_d[l_ac].sfaa010_3_desc,g_sfcb3_d[l_ac].sfaa010_3_desc_1,g_sfcb3_d[l_ac].sfcb003_3,
                              g_sfcb3_d[l_ac].sfcb003_3_desc,g_sfcb3_d[l_ac].sfcb004_3,g_sfcb3_d[l_ac].sfcb050_3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   IF l_ac > 1 THEN
      LET l_ac = l_ac - 1
   ELSE
      LET l_ac = 0
   END IF
   LET l_msg = cl_getmsg_parm('asf-00285',g_dlang,l_ac)
   CALL cl_set_comp_att_text('page_3',l_msg)
   
   CALL g_sfcb1_d.deleteElement(g_sfcb1_d.getLength())
   CALL g_sfcb2_d.deleteElement(g_sfcb2_d.getLength())
   CALL g_sfcb3_d.deleteElement(g_sfcb3_d.getLength())
   CALL g_sfcb4_d.deleteElement(g_sfcb4_d.getLength())
   CALL g_sfcb5_d.deleteElement(g_sfcb5_d.getLength())
   
   LET l_ac = 1
   
   CLOSE movein_cs
   CLOSE checkin_cs
   CLOSE checkout_cs
   CLOSE moveout_cs
   CLOSE processing_cs
   FREE movein_cs
   FREE checkin_cs
   FREE checkout_cs
   FREE moveout_cs
   FREE processing_cs

END FUNCTION

################################################################################
# Descriptions...: 顯示正確的單身資料筆數
# Memo...........:
# Usage..........: CALL asfp331_overview_idx_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 160114 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_overview_idx_chk()

   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_sfcb1_d.getLength() THEN
         LET g_detail_idx = g_sfcb1_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_sfcb1_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO h_index
   END IF
   
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      IF g_detail_idx > g_sfcb2_d.getLength() THEN
         LET g_detail_idx = g_sfcb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfcb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO h_index
   END IF
   
   IF g_current_page = 3 THEN
      IF g_detail_idx > g_sfcb3_d.getLength() THEN
         LET g_detail_idx = g_sfcb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfcb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO h_index
   END IF
   
   IF g_current_page = 4 THEN
      IF g_detail_idx > g_sfcb4_d.getLength() THEN
         LET g_detail_idx = g_sfcb4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfcb4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO h_index
   END IF
   
   IF g_current_page = 5 THEN
      IF g_detail_idx > g_sfcb5_d.getLength() THEN
         LET g_detail_idx = g_sfcb5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfcb5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO h_index
   END IF

END FUNCTION

################################################################################
# Descriptions...: 進/出 站
# Memo...........: 
# Usage..........: CALL asfp331_move(p_type)
# Input parameter: 
# Return code....: 
# Date & Author..: 160115 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_move(p_type)
DEFINE p_type       LIKE type_t.chr1

   CLEAR FORM
   INITIALIZE g_sfcb09_m.* TO NULL
   
   CALL cl_set_comp_visible("move_in",FALSE)
   CALL cl_set_comp_visible("move_out",FALSE)
   
   CALL cl_set_act_visible("move_in,move_out",FALSE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      CONSTRUCT BY NAME g_wc ON sfcbdocno_09,sfcb001_09
         
         BEFORE FIELD sfcbdocno_09
            CASE p_type
               WHEN '1'
                  CALL cl_set_comp_visible("move_in",TRUE)
                  CALL asfp331_set_combo_sfcbdocno("movein_tmp","sfcbdocno_09")
#                  CALL asfp331_set_combo_sfcb001("movein_tmp",'',"sfcb001_09")
               WHEN '2'
                  CALL cl_set_comp_visible("move_out",TRUE)
                  CALL asfp331_set_combo_sfcbdocno("moveout_tmp","sfcbdocno_09")
#                  CALL asfp331_set_combo_sfcb001("moveout_tmp",'',"sfcb001_09")
            END CASE
         
         AFTER FIELD sfcbdocno_09
            LET g_sfcb09_m.sfcbdocno_09 = GET_FLDBUF(sfcbdocno_09)
            IF cl_null(g_sfcb09_m.sfcbdocno_09) THEN
               LET g_sfcb09_m.sfcb001_09 = ''
               DISPLAY BY NAME g_sfcb09_m.sfcb001_09
               CALL cl_set_act_visible("move_in,move_out",FALSE)
               ERROR "This field requires an entered value."
               NEXT FIELD CURRENT
            ELSE
               CASE p_type
                  WHEN '1'
                     CALL asfp331_set_combo_sfcb001("movein_tmp",g_sfcb09_m.sfcbdocno_09,"sfcb001_09")
                     SELECT sfcb001 INTO g_sfcb09_m.sfcb001_09
                       FROM movein_tmp
                      WHERE sfcbdocno = g_sfcb09_m.sfcbdocno_09
                        AND ROWNUM = 1
                  WHEN '2'
                     CALL asfp331_set_combo_sfcb001("moveout_tmp",g_sfcb09_m.sfcbdocno_09,"sfcb001_09")
                     SELECT sfcb001 INTO g_sfcb09_m.sfcb001_09
                       FROM moveout_tmp
                      WHERE sfcbdocno = g_sfcb09_m.sfcbdocno_09
                        AND ROWNUM = 1
               END CASE
               DISPLAY BY NAME g_sfcb09_m.sfcb001_09
               CALL cl_set_act_visible("move_in,move_out",TRUE)
            END IF
         
         AFTER FIELD sfcb001_09
            LET g_sfcb09_m.sfcb001_09 = GET_FLDBUF(sfcb001_09)
            IF cl_null(g_sfcb09_m.sfcbdocno_09) THEN
               CALL cl_set_act_visible("move_in,move_out",FALSE)
            ELSE
               CALL cl_set_act_visible("move_in,move_out",TRUE)
            END IF
         
      END CONSTRUCT

      ON ACTION move_in
         IF cl_null(g_sfcb09_m.sfcbdocno_09) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcbdocno_09
         END IF
         IF cl_null(g_sfcb09_m.sfcb001_09) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcb001_09
         END IF
         CALL asfp331_process('')
         ACCEPT DIALOG

      ON ACTION move_out
         IF cl_null(g_sfcb09_m.sfcbdocno_09) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcbdocno_09
         END IF
         IF cl_null(g_sfcb09_m.sfcb001_09) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcb001_09
         END IF
         CALL asfp331_process('')
         ACCEPT DIALOG

      ON ACTION menu
         LET g_action_choice = 'menu'
         EXIT DIALOG

      ON ACTION close
         LET g_action_choice = 'exit'
         EXIT DIALOG

      ON ACTION exit
         LET g_action_choice = 'exit'
         EXIT DIALOG

      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
END FUNCTION

################################################################################
# Descriptions...: check in/out
# Memo...........:
# Usage..........: CALL asfp331_check(p_type)
# Input parameter: 
# Return code....: 
# Date & Author..: 160115 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_check(p_type)
DEFINE p_type       LIKE type_t.chr1
DEFINE l_n          LIKE type_t.num5
DEFINE l_oocql001   LIKE oocql_t.oocql001
DEFINE l_oocql002   LIKE oocql_t.oocql002
DEFINE l_oocql004   LIKE oocql_t.oocql004

   #項目
   LET l_oocql001 = '223'
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sql_oocq_cs USING l_oocql001 INTO l_oocql002,l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('b_sffc001_desc',pa_array)
   
   CLEAR FORM
   INITIALIZE g_sfcb08_m.* TO NULL
   CALL g_sffc_d.clear()
   
   CALL cl_set_comp_visible("check_out",FALSE)
   CALL cl_set_comp_visible("check_in",FALSE)
   
   CALL cl_set_act_visible("check_in,check_out",FALSE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      CONSTRUCT BY NAME g_wc ON sfcbdocno_08,sfcb001_08
         
         BEFORE FIELD sfcbdocno_08
            CASE p_type
               WHEN '1'
                  CALL cl_set_comp_visible("check_in",TRUE)
                  CALL asfp331_set_combo_sfcbdocno("checkin_tmp","sfcbdocno_08")
#                  CALL asfp331_set_combo_sfcb001("checkin_tmp",'',"sfcb001_08")
               WHEN '2'
                  CALL cl_set_comp_visible("check_out",TRUE)
                  CALL asfp331_set_combo_sfcbdocno("checkout_tmp","sfcbdocno_08")
#                  CALL asfp331_set_combo_sfcb001("checkout_tmp",'',"sfcb001_08")
            END CASE
         
         AFTER FIELD sfcbdocno_08
            LET g_sfcb08_m.sfcbdocno_08 = GET_FLDBUF(sfcbdocno_08)
            IF cl_null(g_sfcb08_m.sfcbdocno_08) THEN
               LET g_sfcb08_m.sfcb001_08 = ''
               DISPLAY BY NAME g_sfcb08_m.sfcb001_08
               CALL cl_set_act_visible("check_in,check_out",FALSE)
               ERROR "This field requires an entered value."
               NEXT FIELD CURRENT
            ELSE
               CASE p_type
                  WHEN '1'
                     CALL asfp331_set_combo_sfcb001("checkin_tmp",g_sfcb08_m.sfcbdocno_08,"sfcb001_08")
                     SELECT sfcb001 INTO g_sfcb08_m.sfcb001_08
                       FROM checkin_tmp
                      WHERE sfcbdocno = g_sfcb08_m.sfcbdocno_08
                        AND ROWNUM = 1
                  WHEN '2'
                     CALL asfp331_set_combo_sfcb001("checkout_tmp",g_sfcb08_m.sfcbdocno_08,"sfcb001_08")
                     SELECT sfcb001 INTO g_sfcb08_m.sfcb001_08
                       FROM checkout_tmp
                      WHERE sfcbdocno = g_sfcb08_m.sfcbdocno_08
                        AND ROWNUM = 1
               END CASE
               DISPLAY BY NAME g_sfcb08_m.sfcb001_08
               CALL cl_set_act_visible("check_in,check_out",TRUE)
               CALL asfp331_check_sfcd(p_type)
            END IF
         
         AFTER FIELD sfcb001_08
            LET g_sfcb08_m.sfcb001_08 = GET_FLDBUF(sfcb001_08)
            IF cl_null(g_sfcb08_m.sfcb001_08) THEN
               CALL cl_set_act_visible("check_in,check_out",FALSE)
            ELSE
               CALL asfp331_check_sfcd(p_type)
               CALL cl_set_act_visible("check_in,check_out",TRUE)
            END IF
         
      END CONSTRUCT

      INPUT ARRAY g_sffc_d FROM s_detail_s08_1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                    INSERT ROW = FALSE, 
                    DELETE ROW = FALSE,
                    APPEND ROW = FALSE)
         
         BEFORE INPUT
            LET g_rec_b = g_sffc_d.getLength()
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO idx
            LET g_rec_b = g_sffc_d.getLength()
            DISPLAY g_rec_b TO cnt
            LET g_sffc_d_t.* = g_sffc_d[l_ac].*
         
         AFTER FIELD b_sffc005
            IF NOT cl_null(g_sffc_d[l_ac].sffc005) AND
               NOT cl_null(g_sffc_d[l_ac].sffc004) AND
               NOT cl_null(g_sffc_d[l_ac].sffc003) THEN
               IF g_sffc_d[l_ac].sffc005 > g_sffc_d[l_ac].sffc003 AND
                  g_sffc_d[l_ac].sffc005 < g_sffc_d[l_ac].sffc004 THEN
                  LET g_sffc_d[l_ac].sffc006 = 'Y'
               ELSE
                  LET g_sffc_d[l_ac].sffc006 = 'N'
               END IF
            END IF
         
         ON ACTION controlp INFIELD b_sffc005
            LET g_type = 15-3
            CALL asfp331_calculator(g_sffc_d[l_ac].sffc005)
            LET g_sffc_d[l_ac].sffc005 = num
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_sffc_d[l_ac].* = g_sffc_d_t.*
               EXIT DIALOG
            END IF
            UPDATE check_tmp SET (sffc005,sffc006) = (g_sffc_d[l_ac].sffc005,g_sffc_d[l_ac].sffc006)
             WHERE sffc001 = g_sffc_d[l_ac].sffc001
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "check_tmp"
                  LET g_errparam.code   = "std-00009"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_sffc_d[l_ac].* = g_sffc_d_t.*
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "check_tmp"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_sffc_d[l_ac].* = g_sffc_d_t.*
            END CASE
         
      END INPUT

      ON ACTION check_in
         IF cl_null(g_sfcb08_m.sfcbdocno_08) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcbdocno_08
         END IF
         IF cl_null(g_sfcb08_m.sfcb001_08) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcb001_08
         END IF
         ACCEPT DIALOG

      ON ACTION check_out
         IF cl_null(g_sfcb08_m.sfcbdocno_08) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcbdocno_08
         END IF
         IF cl_null(g_sfcb08_m.sfcb001_08) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sfcb001_08
         END IF
         ACCEPT DIALOG

      ON ACTION menu
         LET g_action_choice = 'menu'
         EXIT DIALOG

      ON ACTION close
         LET g_action_choice = 'exit'
         EXIT DIALOG

      ON ACTION exit
         LET g_action_choice = 'exit'
         EXIT DIALOG

      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   IF g_action_choice LIKE 'check%' THEN
      CALL asfp331_process('')
   END IF
   DELETE FROM check_tmp

END FUNCTION

################################################################################
# Descriptions...: 工單製程check in/out項目資料
# Memo...........:
# Usage..........: CALL asfp331_check_sfcd(p_type)
# Input parameter: 
# Return code....: 
# Date & Author..: 160122 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_check_sfcd(p_type)
DEFINE p_type       LIKE type_t.chr1
DEFINE l_sfcb002    LIKE sfcb_t.sfcb002

   DELETE FROM check_tmp
   
   IF cl_null(g_sfcb08_m.sfcbdocno_08) OR cl_null(g_sfcb08_m.sfcb001_08) THEN
      RETURN
   END IF
   
   LET l_sfcb002 = ''
   CASE p_type
      WHEN '1'
         SELECT sfcb002 INTO l_sfcb002
           FROM checkin_tmp 
          WHERE sfcbdocno = g_sfcb08_m.sfcbdocno_08
            AND sfcb001   = g_sfcb08_m.sfcb001_08
      WHEN '2'
         SELECT sfcb002 INTO l_sfcb002
           FROM checkout_tmp 
          WHERE sfcbdocno = g_sfcb08_m.sfcbdocno_08
            AND sfcb001   = g_sfcb08_m.sfcb001_08
   END CASE
   
   INSERT INTO check_tmp 
        SELECT sfcd003,oocql004,sfcd004,sfcd005,sfcd006,sfcd007,sfcd008
          FROM sfcd_t LEFT OUTER JOIN oocql_t ON oocqlent = sfcdent AND oocql001 = '223' AND oocql002 = sfcd003 AND oocql003 = g_dlang
         WHERE sfcdent = g_enterprise
           AND sfcdsite = g_site
           AND sfcddocno = g_sfcb08_m.sfcbdocno_08
           AND sfcd001 = g_sfcb08_m.sfcb001_08
           AND sfcd002 = l_sfcb002
           AND sfcd009 = p_type

   CALL g_sffc_d.clear()
   
   LET l_ac = 1
   DECLARE asfp331_check_sfcd_cs CURSOR FOR
      SELECT sffc001,oocql004,sffc002,sffc003,sffc004,sffc005,sffc006 FROM check_tmp
   FOREACH asfp331_check_sfcd_cs INTO g_sffc_d[l_ac].sffc001,g_sffc_d[l_ac].sffc001_desc,g_sffc_d[l_ac].sffc002,g_sffc_d[l_ac].sffc003,
                                      g_sffc_d[l_ac].sffc004,g_sffc_d[l_ac].sffc005,g_sffc_d[l_ac].sffc006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   IF l_ac > 1 THEN
      LET l_ac = l_ac - 1
   ELSE
      LET l_ac = 0
   END IF
   
   CALL g_sffc_d.deleteElement(g_sffc_d.getLength())
   
   LET l_ac = 1
   
   CLOSE asfp331_check_sfcd_cs
   FREE asfp331_check_sfcd_cs

END FUNCTION

################################################################################
# Descriptions...: 計算機
# Memo...........:
# Usage..........: CALL asfp331_calculator(p_num)
# Input parameter: 
# Return code....: 
# Date & Author..: 160118 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_calculator(p_num)
DEFINE p_num        LIKE type_t.num20_6

   OPEN WINDOW w_asfp331_s04 WITH FORM cl_ap_formpath("asf","asfp331_s04")
   
   MENU
   
      BEFORE MENU
         CLEAR FORM
         IF cl_null(p_num) OR p_num = 0 THEN
            LET num = 0
         ELSE
            LET num = p_num
            #没有小数点的整数不需要去0
            IF num <> 0 AND num.getIndexOf('.',1) > 0 THEN
               WHILE TRUE
                 IF num.substring(num.getlength(),num.getlength()) = '0' THEN
                    LET num = num.substring(1,num.getlength()-1)
                    IF num = '0' THEN
                       EXIT WHILE 
                    END IF
                    IF num = '.' THEN
                       LET num = '0'
                       EXIT WHILE
                    END IF
                 ELSE
                    IF num.substring(num.getlength(),num.getlength()) = '.' THEN
                       LET num = num.substring(1,num.getlength()-1)
                       EXIT WHILE
                    END IF
                    EXIT WHILE
                 END IF
               END WHILE
            END IF
         END IF
         DISPLAY BY NAME num
      
      ON ACTION cancel
         LET num = p_num
         EXIT MENU
      
      ON ACTION zero
         CALL asfp331_calculator_count('0')
      
      ON ACTION one
         CALL asfp331_calculator_count('1')
      
      ON ACTION two
         CALL asfp331_calculator_count('2')
      
      ON ACTION three
         CALL asfp331_calculator_count('3')
      
      ON ACTION four
         CALL asfp331_calculator_count('4')
      
      ON ACTION five
         CALL asfp331_calculator_count('5')
      
      ON ACTION six
         CALL asfp331_calculator_count('6')
      
      ON ACTION seven
         CALL asfp331_calculator_count('7')
      
      ON ACTION eight
         CALL asfp331_calculator_count('8')
      
      ON ACTION nine
         CALL asfp331_calculator_count('9')
      
      ON ACTION dot
         IF num.getIndexOf('.',1) = 0 THEN
            CALL asfp331_calculator_count('.')
         END IF
      
      ON ACTION del
         IF num.getlength() > 1 THEN
            LET num = num.substring(1,num.getlength()-1)
         ELSE
            LET num = 0
         END IF
         DISPLAY BY NAME num
      
      ON ACTION c
         LET num = 0
         DISPLAY BY NAME num
      
      ON ACTION enter
         EXIT MENU
      
      #主選單用ACTION
      &include "main_menu_exit_menu.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
   END MENU
   
   CLOSE WINDOW w_asfp331_s04

END FUNCTION

################################################################################
# Descriptions...: copy asfp330_calculator
# Memo...........:
# Usage..........: CALL asfp331_calculator_count(p_cmd)
# Input parameter: 
# Return code....: 
# Date & Author..: 160118 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_calculator_count(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE l_num        STRING

   IF cl_null(num) THEN
      LET num = 0
   ELSE
      #如果暂存数存在值，需要判断是否符合num20_6的格式，超出范围的按键需求都会被return，CE和DEL除外
      #判断1：总长不得大于20
      IF num.getIndexOf('.',1) > 0 THEN
         LET l_num = num.substring(1,num.getIndexOf('.',1))
      ELSE
         LET l_num = num
      END IF
      IF cl_null(g_type) THEN LET g_type = 15-3 END IF
      IF l_num.getlength() >= g_type THEN
         RETURN
      END IF
      #判断2：小数位不得大于6
      LET l_num = num.substring(num.getIndexOf('.',1),num.getlength())
      IF l_num.getlength() > 6 THEN
         RETURN
      END IF
   END IF
   
   IF num = '0' THEN   #原来是0的，再输一位不能变成07，要变成7这样的
      LET num = p_cmd CLIPPED
   ELSE
      LET num = num CLIPPED,p_cmd CLIPPED
   END IF
   
   DISPLAY BY NAME num
END FUNCTION

################################################################################
# Descriptions...: 報工
# Memo...........:
# Usage..........: asfp331_processing()
# Input parameter: 
# Return code....: 
# Date & Author..: 160119 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_processing()
DEFINE l_sffb007    LIKE sffb_t.sffb007
DEFINE l_sffb008    LIKE sffb_t.sffb008
DEFINE l_sffb016    LIKE sffb_t.sffb016
DEFINE l_sffb017    LIKE sffb_t.sffb017
#170117-00038#1-s
DEFINE ls_js        STRING
DEFINE lc_param     RECORD
    sffbdocno  LIKE sffb_t.sffbdocno,  #報工單號
    sffbseq    LIKE sffb_t.sffbseq,    #項次
    sffb001    LIKE sffb_t.sffb001,    #報工類別  #170120-00043#1
    sffb005    LIKE sffb_t.sffb005,    #工單單號
    sffb006    LIKE sffb_t.sffb006,    #Run Card
    sffb007    LIKE sffb_t.sffb007,    #作業編號
    sffb008    LIKE sffb_t.sffb008,    #製程式
    sffb017    LIKE sffb_t.sffb017,    #良品數量
    sffb018    LIKE sffb_t.sffb018,    #報廢數量
    sffb019    LIKE sffb_t.sffb019,    #當站下線數量
    sffb020    LIKE sffb_t.sffb020     #回收數量
                END RECORD
#170117-00038#1-e

   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s06"), "grid_s05_1", "VBox", "mainlayout")
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp331_s07"), "grid_s05_2", "VBox", "mainlayout")
   CALL cl_set_comp_visible("vbox_s05_1",FALSE)
   CALL cl_set_comp_visible("vbox_s05_2",FALSE)
   
   DELETE FROM defect_tmp
   DELETE FROM offline_tmp
   
   CLEAR FORM
   INITIALIZE g_sffb_m.* TO NULL
   LET g_sffb_m.sffb012 = cl_get_today()
   LET g_sffb_m.sffb013 = cl_get_time()
#   LET g_sffb_m.sffb013 = g_sffb_m.sffb013[1,5]
   LET g_sffb_m.sffb014 = 0
   LET g_sffb_m.sffb015 = 0
   LET g_sffb_m.sffb017 = 0
   LET g_sffb_m.sffb018 = 0
   LET g_sffb_m.sffb019 = 0
   DISPLAY BY NAME g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb012,
                   g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,
                   g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019
   LET g_sffb_m_o.* = g_sffb_m.*
   
   CALL cl_set_act_visible("defect,offline,processing",FALSE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      CONSTRUCT BY NAME g_wc ON sffb005,sffb006
         
         BEFORE FIELD sffb005
            CALL asfp331_set_combo_sfcbdocno("processing_tmp","sffb005")
#            CALL asfp331_set_combo_sfcb001("processing_tmp",'',"sffb006")
         
         AFTER FIELD sffb005
            LET g_sffb_m.sffb005 = GET_FLDBUF(sffb005)
            IF cl_null(g_sffb_m.sffb005) THEN
               LET g_sffb_m.sffb006 = ''
               DISPLAY BY NAME g_sffb_m.sffb006
               CALL cl_set_act_visible("defect,offline,processing",FALSE)
               ERROR "This field requires an entered value."
               NEXT FIELD sffb005
            ELSE
               IF g_sffb_m.sffb005 <> g_sffb_m_o.sffb005 OR cl_null(g_sffb_m_o.sffb005) THEN
                  CALL asfp331_set_combo_sfcb001("processing_tmp",g_sffb_m.sffb005,"sffb006")
                  LET l_sffb007 = ''
                  LET l_sffb008 = ''
                  LET l_sffb017 = 0
                  SELECT sfcb001,sfcb003,sfcb004,sfcb050 INTO g_sffb_m.sffb006,l_sffb007,l_sffb008,l_sffb017
                    FROM processing_tmp
                   WHERE sfcbdocno = g_sffb_m.sffb005
                     AND ROWNUM = 1
                  DISPLAY BY NAME g_sffb_m.sffb006
                  IF NOT s_asft335_chk_sffb0078('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008) THEN
                     LET g_sffb_m.sffb005 = g_sffb_m_o.sffb005
                     LET g_sffb_m.sffb006 = g_sffb_m_o.sffb006
                     DISPLAY BY NAME g_sffb_m.sffb005,g_sffb_m.sffb006
                     NEXT FIELD sffb005
                  END IF
                  CALL cl_set_act_visible("defect,offline,processing",TRUE)
                  LET g_sffb_m.sffb014 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  LET g_sffb_m.sffb015 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  CALL s_asft335_set_qty('','','3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008)
                       RETURNING g_sffb_m.sffb017,l_sffb016
                  DISPLAY BY NAME g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb017
                  LET g_sffb_m_o.sffb005 = g_sffb_m.sffb005
                  LET g_sffb_m_o.sffb006 = g_sffb_m.sffb006
                  LET g_sffb_m_o.sffb017 = g_sffb_m.sffb017
               END IF
            END IF
         
         AFTER FIELD sffb006
            LET g_sffb_m.sffb006 = GET_FLDBUF(sffb006)
            IF cl_null(g_sffb_m.sffb006) THEN
               CALL cl_set_act_visible("defect,offline,processing",FALSE)
            ELSE
               IF g_sffb_m.sffb006 <> g_sffb_m_o.sffb006 OR cl_null(g_sffb_m_o.sffb006) THEN
                  LET l_sffb007 = ''
                  LET l_sffb008 = ''
                  LET l_sffb017 = 0
                  SELECT sfcb003,sfcb004,sfcb050 INTO l_sffb007,l_sffb008,l_sffb017
                    FROM processing_tmp
                   WHERE sfcbdocno = g_sffb_m.sffb005
                     AND sfcb001 = g_sffb_m.sffb006
                  IF NOT s_asft335_chk_sffb0078('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008) THEN
                     LET g_sffb_m.sffb006 = g_sffb_m_o.sffb006
                     DISPLAY BY NAME g_sffb_m.sffb006
                     NEXT FIELD sffb006
                  END IF               
                  CALL cl_set_act_visible("defect,offline,processing",TRUE)
                  LET g_sffb_m.sffb014 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  LET g_sffb_m.sffb015 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  CALL s_asft335_set_qty('','','3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008)
                       RETURNING g_sffb_m.sffb017,l_sffb016
                  DISPLAY BY NAME g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb017
                  LET g_sffb_m_o.sffb006 = g_sffb_m.sffb006
                  LET g_sffb_m_o.sffb017 = g_sffb_m.sffb017
               END IF
            END IF
         
      END CONSTRUCT
      
      INPUT BY NAME g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,
                    g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019
            ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD sffb012
            IF NOT cl_null(g_sffb_m.sffb012) THEN
               IF g_sffb_m.sffb012 <> g_sffb_m_o.sffb012 OR cl_null(g_sffb_m_o.sffb012) THEN
                  LET g_sffb_m.sffb014 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  LET g_sffb_m.sffb015 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  DISPLAY BY NAME g_sffb_m.sffb014,g_sffb_m.sffb015
                  LET g_sffb_m_o.sffb012 = g_sffb_m.sffb012
               END IF
            END IF
         
         AFTER FIELD sffb013
            IF NOT cl_null(g_sffb_m.sffb013) THEN
               IF g_sffb_m.sffb013 <> g_sffb_m_o.sffb013 OR cl_null(g_sffb_m_o.sffb013) THEN
                  LET g_sffb_m.sffb014 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  LET g_sffb_m.sffb015 = s_asft335_get_working_time('3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  DISPLAY BY NAME g_sffb_m.sffb014,g_sffb_m.sffb015
                  LET g_sffb_m_o.sffb013 = g_sffb_m.sffb013
               END IF
            END IF
         
         AFTER FIELD sffb014
         
         AFTER FIELD sffb015
         
         AFTER FIELD sffb017
            IF NOT cl_null(g_sffb_m.sffb017) THEN
               IF g_sffb_m.sffb017 <> g_sffb_m_o.sffb017 OR cl_null(g_sffb_m_o.sffb017) THEN
                  IF NOT cl_ap_chk_Range(g_sffb_m.sffb017,"0.000","1","","","azz-00079",1) THEN
                     LET g_sffb_m.sffb017 = g_sffb_m_o.sffb017
                     DISPLAY BY NAME g_sffb_m.sffb017
                     NEXT FIELD sffb017
                  END IF
                  #170117-00038#1-s
                  #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,0,l_sffb017) THEN
                  LET lc_param.sffbdocno = ''                #報工單號
                  LET lc_param.sffbseq   = ''                #項次
                  LET lc_param.sffb001   = '3'               #報工類別  #170120-00043#1
                  LET lc_param.sffb005   = g_sffb_m.sffb005  #工單單號
                  LET lc_param.sffb006   = g_sffb_m.sffb006  #Run Card
                  LET lc_param.sffb007   = l_sffb007         #作業編號
                  LET lc_param.sffb008   = l_sffb008         #製程式
                  LET lc_param.sffb017   = g_sffb_m.sffb017  #良品數量
                  LET lc_param.sffb018   = g_sffb_m.sffb018  #報廢數量
                  LET lc_param.sffb019   = g_sffb_m.sffb019  #當站下線數量
                  LET lc_param.sffb020   = 0                 #回收數量
                  LET ls_js = util.JSON.stringify(lc_param)
                  IF NOT s_asft335_chk_qty(ls_js) THEN
                  #170117-00038#1-e
                     LET g_sffb_m.sffb017 = g_sffb_m_o.sffb017
                     DISPLAY BY NAME g_sffb_m.sffb017
                     NEXT FIELD sffb017
                  END IF
                  IF NOT s_asft335_chk_sffb017(g_sffb02_m.docno_1,'3',g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb017) THEN
                     LET g_sffb_m.sffb017 = g_sffb_m_o.sffb017
                     DISPLAY BY NAME g_sffb_m.sffb017
                     NEXT FIELD sffb017
                  END IF
                  LET g_sffb_m_o.sffb017 = g_sffb_m.sffb017
               END IF
            END IF
         
         AFTER FIELD sffb018
            IF NOT cl_null(g_sffb_m.sffb018) THEN
               IF g_sffb_m.sffb018 <> g_sffb_m_o.sffb018 OR cl_null(g_sffb_m_o.sffb018) THEN
                  IF NOT cl_ap_chk_Range(g_sffb_m.sffb018,"0.000","1","","","azz-00079",1) THEN
                     LET g_sffb_m.sffb018 = g_sffb_m_o.sffb018
                     DISPLAY BY NAME g_sffb_m.sffb018
                     NEXT FIELD sffb018
                  END IF
                  #170117-00038#1-s
                  #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,0,l_sffb017) THEN
                  LET lc_param.sffbdocno = ''                #報工單號
                  LET lc_param.sffbseq   = ''                #項次
                  LET lc_param.sffb001   = '3'               #報工類別  #170120-00043#1
                  LET lc_param.sffb005   = g_sffb_m.sffb005  #工單單號
                  LET lc_param.sffb006   = g_sffb_m.sffb006  #Run Card
                  LET lc_param.sffb007   = l_sffb007         #作業編號
                  LET lc_param.sffb008   = l_sffb008         #製程式
                  LET lc_param.sffb017   = g_sffb_m.sffb017  #良品數量
                  LET lc_param.sffb018   = g_sffb_m.sffb018  #報廢數量
                  LET lc_param.sffb019   = g_sffb_m.sffb019  #當站下線數量
                  LET lc_param.sffb020   = 0                 #回收數量
                  LET ls_js = util.JSON.stringify(lc_param)
                  IF NOT s_asft335_chk_qty(ls_js) THEN
                  #170117-00038#1-e
                     LET g_sffb_m.sffb018 = g_sffb_m_o.sffb018
                     DISPLAY BY NAME g_sffb_m.sffb018
                     NEXT FIELD sffb018
                  END IF
                  LET g_sffb_m_o.sffb018 = g_sffb_m.sffb018
               END IF
            END IF
         
         AFTER FIELD sffb019
            IF NOT cl_null(g_sffb_m.sffb019) THEN
               IF g_sffb_m.sffb019 <> g_sffb_m_o.sffb019 OR cl_null(g_sffb_m_o.sffb019) THEN
                  IF NOT cl_ap_chk_Range(g_sffb_m.sffb019,"0.000","1","","","azz-00079",1) THEN
                     LET g_sffb_m.sffb019 = g_sffb_m_o.sffb019
                     DISPLAY BY NAME g_sffb_m.sffb019
                     NEXT FIELD sffb019
                  END IF
                  #170117-00038#1-s
                  #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,l_sffb007,l_sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,0,l_sffb017) THEN
                  LET lc_param.sffbdocno = ''                #報工單號
                  LET lc_param.sffbseq   = ''                #項次
                  LET lc_param.sffb001   = '3'               #報工類別  #170120-00043#1
                  LET lc_param.sffb005   = g_sffb_m.sffb005  #工單單號
                  LET lc_param.sffb006   = g_sffb_m.sffb006  #Run Card
                  LET lc_param.sffb007   = l_sffb007         #作業編號
                  LET lc_param.sffb008   = l_sffb008         #製程式
                  LET lc_param.sffb017   = g_sffb_m.sffb017  #良品數量
                  LET lc_param.sffb018   = g_sffb_m.sffb018  #報廢數量
                  LET lc_param.sffb019   = g_sffb_m.sffb019  #當站下線數量
                  LET lc_param.sffb020   = 0                 #回收數量
                  LET ls_js = util.JSON.stringify(lc_param)
                  IF NOT s_asft335_chk_qty(ls_js) THEN
                  #170117-00038#1-e
                     LET g_sffb_m.sffb019 = g_sffb_m_o.sffb019
                     DISPLAY BY NAME g_sffb_m.sffb019
                     NEXT FIELD sffb019
                  END IF
                  LET g_sffb_m_o.sffb019 = g_sffb_m.sffb019
               END IF
            END IF
         
         ON ACTION controlp INFIELD sffb014
            LET g_type = 15-3
            CALL asfp331_calculator(g_sffb_m.sffb014)
            LET g_sffb_m.sffb014 = num
         
         ON ACTION controlp INFIELD sffb015
            LET g_type = 15-3
            CALL asfp331_calculator(g_sffb_m.sffb015)
            LET g_sffb_m.sffb015 = num
         
         ON ACTION controlp INFIELD sffb017
            LET g_type = 20-6
            CALL asfp331_calculator(g_sffb_m.sffb017)
            LET g_sffb_m.sffb017 = num
         
         ON ACTION controlp INFIELD sffb018
            LET g_type = 20-6
            CALL asfp331_calculator(g_sffb_m.sffb018)
            LET g_sffb_m.sffb018 = num
         
         ON ACTION controlp INFIELD sffb019
            LET g_type = 20-6
            CALL asfp331_calculator(g_sffb_m.sffb019)
            LET g_sffb_m.sffb019 = num
         
      END INPUT
      
      ON ACTION defect
         IF cl_null(g_sffb_m.sffb005) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sffb005
         END IF
         IF cl_null(g_sffb_m.sffb006) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sffb006
         END IF
         CALL cl_set_comp_visible("vbox_s05_1",TRUE)
         CALL cl_set_comp_visible("vbox_s05_3",FALSE)
         CALL asfp331_defect()
         CALL cl_set_comp_visible("vbox_s05_1",FALSE)
         CALL cl_set_comp_visible("vbox_s05_3",TRUE)
         DISPLAY g_sffb_m.sffb005 TO sffb005
         DISPLAY g_sffb_m.sffb006 TO sffb006
      
      ON ACTION offline
         IF cl_null(g_sffb_m.sffb005) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sffb005
         END IF
         IF cl_null(g_sffb_m.sffb006) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sffb006
         END IF
         CALL cl_set_comp_visible("vbox_s05_2",TRUE)
         CALL cl_set_comp_visible("vbox_s05_3",FALSE)
         CALL asfp331_offline()
         CALL cl_set_comp_visible("vbox_s05_2",FALSE)
         CALL cl_set_comp_visible("vbox_s05_3",TRUE)
         DISPLAY g_sffb_m.sffb005 TO sffb005
         DISPLAY g_sffb_m.sffb006 TO sffb006
      
      ON ACTION processing
         IF cl_null(g_sffb_m.sffb005) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sffb005
         END IF
         IF cl_null(g_sffb_m.sffb006) THEN
            ERROR "This field requires an entered value."
            NEXT FIELD sffb006
         END IF
         CALL asfp331_process('')
         ACCEPT DIALOG
      
      ON ACTION menu
         LET g_action_choice = 'menu'
         EXIT DIALOG
      
      ON ACTION close
         LET g_action_choice = 'exit'
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice = 'exit'
         EXIT DIALOG
      
      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   DELETE FROM defect_tmp
   DELETE FROM offline_tmp

END FUNCTION

################################################################################
# Descriptions...: 不良原因
# Memo...........:
# Usage..........: CALL asfp331_defect()
# Input parameter: 
# Return code....: 
# Date & Author..: 160120 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_defect()
DEFINE l_sql        STRING
DEFINE l_n          LIKE type_t.num5
DEFINE l_oocql001   LIKE oocql_t.oocql001
DEFINE l_oocql002   LIKE oocql_t.oocql002
DEFINE l_oocql004   LIKE oocql_t.oocql004

   #QC缺點原因
   LET l_oocql001 = '1053'
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sql_oocq_cs USING l_oocql001 INTO l_oocql002,l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sffd001_desc', pa_array)

   CLEAR FORM
   INITIALIZE g_sfcb06_m.* TO NULL
   CALL g_sffd_d.clear()
   
   LET g_sfcb06_m.sfcbdocno_06 = g_sffb_m.sffb005
   LET g_sfcb06_m.sfcb001_06 = g_sffb_m.sffb006
   DISPLAY BY NAME g_sfcb06_m.sfcbdocno_06,g_sfcb06_m.sfcb001_06
   
   LET l_ac = 1
   DECLARE asfp331_defect_cs CURSOR FOR
      SELECT sffdseq1,sffd001,sffd001_desc,sffd002,sffd003
        FROM defect_tmp
       ORDER BY sffdseq1
   FOREACH asfp331_defect_cs
      INTO g_sffd_d[l_ac].sffdseq1,g_sffd_d[l_ac].sffd001,g_sffd_d[l_ac].sffd001_desc,
           g_sffd_d[l_ac].sffd002,g_sffd_d[l_ac].sffd003
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_sffd_d.deleteElement(g_sffd_d.getLength())
   LET l_ac = 1
   FREE asfp331_defect_cs
   
   BEGIN WORK
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_sffd_d FROM s_detail_s06.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                    INSERT ROW = TRUE, 
                    DELETE ROW = TRUE,
                    APPEND ROW = TRUE)
         
         BEFORE INPUT
            LET g_rec_b = g_sffd_d.getLength()
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO idx
            LET g_rec_b = g_sffd_d.getLength()
            DISPLAY g_rec_b TO cnt
            LET g_sffd_d_t.* = g_sffd_d[l_ac].*
         
         BEFORE INSERT
            INITIALIZE g_sffd_d[l_ac].* TO NULL
            SELECT MAX(sffdseq1)+1 INTO g_sffd_d[l_ac].sffdseq1
              FROM defect_tmp
            IF cl_null(g_sffd_d[l_ac].sffdseq1) OR g_sffd_d[l_ac].sffdseq1 = 0 THEN
               LET g_sffd_d[l_ac].sffdseq1 = 1
            END IF
         
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_n = 1
            SELECT COUNT(*) INTO l_n
              FROM defect_tmp
             WHERE sffdseq1 = g_sffd_d[l_ac].sffdseq1
            IF l_n = 0 THEN
               INSERT INTO defect_tmp(sffdseq1,sffd001,sffd001_desc,sffd002,sffd003)
                      VALUES(g_sffd_d[l_ac].sffdseq1,g_sffd_d[l_ac].sffd001,g_sffd_d[l_ac].sffd001_desc,
                             g_sffd_d[l_ac].sffd002,g_sffd_d[l_ac].sffd003)
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.code   = "std-00006"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               INITIALIZE g_sffd_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "defect_tmp"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CANCEL INSERT
            ELSE
               LET g_rec_b = g_rec_b + 1
            END IF
         
         BEFORE DELETE
            DELETE FROM defect_tmp
             WHERE sffdseq1 = g_sffd_d[l_ac].sffdseq1
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "defect_tmp"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CANCEL DELETE
            ELSE
               LET g_rec_b = g_rec_b-1
            END IF
         
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sffd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
         BEFORE FIELD sffd001_desc
            #QC缺點原因
            LET l_oocql001 = '1053'
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sql_oocq_cs USING l_oocql001 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sffd001_desc', pa_array)
         
         ON CHANGE sffd001_desc
            IF cl_null(g_sffd_d[l_ac].sffd001_desc) THEN
               LET g_sffd_d[l_ac].sffd001 = ''
            ELSE
               SELECT oocql002 INTO g_sffd_d[l_ac].sffd001
                 FROM oocql_t
                WHERE oocqlent = g_enterprise
                  AND oocql001 = '1053'
                  AND oocql003 = g_dlang
                  AND oocql004 = g_sffd_d[l_ac].sffd001_desc
                  AND ROWNUM = 1
            END IF
         
         ON ACTION controlp INFIELD sffd002
            LET g_type = 20-6
            CALL asfp331_calculator(g_sffd_d[l_ac].sffd002)
            LET g_sffd_d[l_ac].sffd002 = num
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_sffd_d[l_ac].* = g_sffd_d_t.*
               EXIT DIALOG
            END IF
            UPDATE defect_tmp SET (sffd001,sffd001_desc,sffd002,sffd003) = (
                                 g_sffd_d[l_ac].sffd001,g_sffd_d[l_ac].sffd001_desc,
                                 g_sffd_d[l_ac].sffd002,g_sffd_d[l_ac].sffd003)
             WHERE sffdseq1 = g_sffd_d[l_ac].sffdseq1
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "defect_tmp"
                  LET g_errparam.code   = "std-00009"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_sffd_d[l_ac].* = g_sffd_d_t.*
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "defect_tmp"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_sffd_d[l_ac].* = g_sffd_d_t.*
            END CASE
         
      END INPUT

      ON ACTION accept
         COMMIT WORK
         ACCEPT DIALOG

      ON ACTION cancel
         ROLLBACK WORK
         EXIT DIALOG
         

      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG

END FUNCTION

################################################################################
# Descriptions...: 當站下線
# Memo...........:
# Usage..........: CALL asfp331_offline()
# Input parameter: 
# Return code....: 
# Date & Author..: 160120 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_offline()
DEFINE l_sql        STRING
DEFINE l_n          LIKE type_t.num5
DEFINE l_oocql004   LIKE oocql_t.oocql004

   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sfha013_cs INTO l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sfha013', pa_array)

   CLEAR FORM
   INITIALIZE g_sfha_m.* TO NULL
   CALL g_sfha_d.clear()
   
   LET g_sfha_m.sfha004 = g_sffb_m.sffb005
   LET g_sfha_m.sfha005 = g_sffb_m.sffb006
   DISPLAY BY NAME g_sfha_m.sfha004,g_sfha_m.sfha005
   
   LET l_ac = 1
   DECLARE asfp331_offline_cs CURSOR FOR
      SELECT seq,sfha013,sfha015,sfha008
        FROM offline_tmp
       ORDER BY sfha013,sfha015
   FOREACH asfp331_offline_cs
      INTO g_sfha_d[l_ac].seq,g_sfha_d[l_ac].sfha013,g_sfha_d[l_ac].sfha015,g_sfha_d[l_ac].sfha008
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_sfha_d.deleteElement(g_sfha_d.getLength())
   LET l_ac = 1
   FREE asfp331_offline_cs
   
   BEGIN WORK
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_sfha_d FROM s_detail_s07.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                    INSERT ROW = TRUE, 
                    DELETE ROW = TRUE,
                    APPEND ROW = TRUE)
         
         BEFORE INPUT
            LET g_rec_b = g_sfha_d.getLength()
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO idx
            LET g_rec_b = g_sfha_d.getLength()
            DISPLAY g_rec_b TO cnt
            LET g_sfha_d_t.* = g_sfha_d[l_ac].*
         
         BEFORE INSERT
            INITIALIZE g_sfha_d[l_ac].* TO NULL
            SELECT MAX(seq)+1 INTO g_sfha_d[l_ac].seq
              FROM offline_tmp
            IF cl_null(g_sfha_d[l_ac].seq) OR g_sfha_d[l_ac].seq = 0 THEN
               LET g_sfha_d[l_ac].seq = 1
            END IF
         
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_n = 1
            SELECT COUNT(*) INTO l_n
              FROM offline_tmp
             WHERE seq = g_sfha_d[l_ac].seq
            IF l_n = 0 THEN
               IF cl_null(g_sfha_d[l_ac].sfha015) THEN
                  LET g_sfha_d[l_ac].sfha015 = ' '
               END IF
               INSERT INTO offline_tmp(seq,sfha013,sfha015,sfha008)
                      VALUES(g_sfha_d[l_ac].seq,g_sfha_d[l_ac].sfha013,g_sfha_d[l_ac].sfha015,g_sfha_d[l_ac].sfha008)
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.code   = "std-00006"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               INITIALIZE g_sfha_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "offline_tmp"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CANCEL INSERT
            ELSE
               LET g_rec_b = g_rec_b + 1
            END IF
         
         BEFORE DELETE
            DELETE FROM offline_tmp
             WHERE seq = g_sfha_d[l_ac].seq
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "offline_tmp"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CANCEL DELETE
            ELSE
               LET g_rec_b = g_rec_b-1
            END IF
         
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sfha_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
         BEFORE FIELD sfha013
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sfha013_cs INTO l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sfha013', pa_array)
         
         AFTER FIELD sfha013
            IF cl_null(g_sfha_d[l_ac].sfha013) THEN
               LET g_sfha_d[l_ac].sfha015 = ''
            ELSE
               SELECT imaal003,imaal004 INTO g_sfha_d[l_ac].sfha013_desc,g_sfha_d[l_ac].sfha013_desc_1
                 FROM imaal_t
                WHERE imaalent = g_enterprise
                  AND imaal001 = g_sfha_d[l_ac].sfha013
                  AND imaal002 = g_dlang
            END IF
         
         ON ACTION controlp INFIELD sfha008
            LET g_type = 20-6
            CALL asfp331_calculator(g_sfha_d[l_ac].sfha008)
            LET g_sfha_d[l_ac].sfha008 = num
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_sfha_d[l_ac].* = g_sfha_d_t.*
               EXIT DIALOG
            END IF
            UPDATE offline_tmp SET (sfha013,sfha015,sfha008) = (g_sfha_d[l_ac].sfha013,g_sfha_d[l_ac].sfha015,g_sfha_d[l_ac].sfha008)
             WHERE seq = g_sfha_d[l_ac].seq
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "offline_tmp"
                  LET g_errparam.code   = "std-00009"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_sfha_d[l_ac].* = g_sfha_d_t.*
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "offline_tmp"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_sfha_d[l_ac].* = g_sfha_d_t.*
            END CASE
         
      END INPUT

      ON ACTION accept
         COMMIT WORK
         ACCEPT DIALOG

      ON ACTION cancel
         ROLLBACK WORK
         EXIT DIALOG
         

      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG

END FUNCTION

################################################################################
# Descriptions...: 參數設置
# Memo...........:
# Usage..........: CALL asfp331_setup()
# Input parameter: 
# Return code....: 
# Date & Author..: 160121 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_setup()
DEFINE ls_text      STRING
DEFINE ls_file      STRING
DEFINE lc_channel   base.Channel
DEFINE l_n          LIKE type_t.num5
DEFINE l_oocql001   LIKE oocql_t.oocql001
DEFINE l_oocql002   LIKE oocql_t.oocql002
DEFINE l_oocql004   LIKE oocql_t.oocql004
DEFINE l_oobx003    LIKE oobx_t.oobx003

   #工作站
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sffb009_02_desc_cs INTO l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sffb009_02_desc',pa_array)
   #作業
   LET l_oocql001 = '221'
   LET l_n = 1
   CALL pa_array.clear()
   LET pa_array[l_n].value = ''
   LET l_n = l_n + 1
   FOREACH sql_oocq_cs USING l_oocql001 INTO l_oocql002,l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sffb007_02_desc',pa_array)
   #班別
   LET l_n = 1
   CALL pa_array.clear()
   LET pa_array[l_n].value = ''
   LET l_n = l_n + 1
   FOREACH sffb004_02_desc_cs INTO l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sffb004_02_desc',pa_array)
   #機台
   LET l_n = 1
   CALL pa_array.clear()
   LET pa_array[l_n].value = ''
   LET l_n = l_n + 1
   FOREACH sffb010_02_desc_cs INTO l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sffb010_02_desc',pa_array)
   
   LET l_oobx003 = 'asft335'
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
      LET pa_array[l_n].value = l_oocql002 CLIPPED
      IF NOT g_notneed_labeltag THEN
         LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
      END IF
      LET pa_array[l_n].label = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('docno_1',pa_array)
   CALL cl_set_combo_detail('docno_2',pa_array)
   CALL cl_set_combo_detail('docno_3',pa_array)
   CALL cl_set_combo_detail('docno_4',pa_array)
   CALL cl_set_combo_detail('docno_5',pa_array)
   #當站下線
   LET l_oobx003 = 'asft337'
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
      LET pa_array[l_n].value = l_oocql002 CLIPPED
      IF NOT g_notneed_labeltag THEN
         LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
      END IF
      LET pa_array[l_n].label = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('docno_6',pa_array)
   #庫位
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sfhb003_cs INTO l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sfhb003', pa_array)
   #儲位
   LET l_n = 1
   CALL pa_array.clear()
   FOREACH sfhb004_cs INTO l_oocql004
      LET pa_array[l_n].value = l_oocql004 CLIPPED
      LET l_n = l_n + 1
   END FOREACH
   CALL cl_set_combo_detail('sfhb004', pa_array)

   DISPLAY BY NAME g_sffb02_m.sffb009_02,g_sffb02_m.sffb009_02_desc,
                   g_sffb02_m.sffb007_02,g_sffb02_m.sffb007_02_desc,
                   g_sffb02_m.sffb004_02,g_sffb02_m.sffb004_02_desc,
                   g_sffb02_m.sffb010_02,g_sffb02_m.sffb010_02_desc,
                   g_sffb02_m.docno_1,g_sffb02_m.docno_2,
                   g_sffb02_m.docno_3,g_sffb02_m.docno_4,
                   g_sffb02_m.docno_5,g_sffb02_m.docno_6,
                   g_sffb02_m.sfhb003,g_sffb02_m.sfhb004
   LET g_sffb02_m_t.* = g_sffb02_m.*
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT BY NAME g_sffb02_m.sffb009_02,g_sffb02_m.sffb009_02_desc,
                    g_sffb02_m.sffb007_02,g_sffb02_m.sffb007_02_desc,
                    g_sffb02_m.sffb004_02,g_sffb02_m.sffb004_02_desc,
                    g_sffb02_m.sffb010_02,g_sffb02_m.sffb010_02_desc,
                    g_sffb02_m.docno_1,g_sffb02_m.docno_2,
                    g_sffb02_m.docno_3,g_sffb02_m.docno_4,
                    g_sffb02_m.docno_5,g_sffb02_m.docno_6,
                    g_sffb02_m.sfhb003,g_sffb02_m.sfhb004
            ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE FIELD sffb009_02_desc
            #工作站
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sffb009_02_desc_cs INTO l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sffb009_02_desc',pa_array)
         
         ON CHANGE sffb009_02_desc
            IF cl_null(g_sffb02_m.sffb009_02_desc) THEN
               LET g_sffb02_m.sffb009_02 = ''
            ELSE
               SELECT ecaa001 INTO g_sffb02_m.sffb009_02
                 FROM ecaa_t
                WHERE ecaaent = g_enterprise
                  AND ecaasite = g_site
                  AND ecaastus = 'Y'
                  AND ecaa002 = g_sffb02_m.sffb009_02_desc
            END IF
         
         BEFORE FIELD sffb007_02_desc
            #作業
            LET l_oocql001 = '221'
            LET l_n = 1
            CALL pa_array.clear()
            LET pa_array[l_n].value = ''
            LET l_n = l_n + 1
            FOREACH sql_oocq_cs USING l_oocql001 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sffb007_02_desc',pa_array)
         
         ON CHANGE sffb007_02_desc
            IF cl_null(g_sffb02_m.sffb007_02_desc) THEN
               LET g_sffb02_m.sffb007_02 = ''
            ELSE
               SELECT oocql002 INTO g_sffb02_m.sffb007_02
                 FROM oocql_t
                WHERE oocqlent = g_enterprise
                  AND oocql001 = '221'
                  AND oocql004 = g_sffb02_m.sffb007_02_desc
                  AND oocql003 = g_dlang
            END IF
         
         BEFORE FIELD sffb004_02_desc
            #班別
            LET l_n = 1
            CALL pa_array.clear()
            LET pa_array[l_n].value = ''
            LET l_n = l_n + 1
            FOREACH sffb004_02_desc_cs INTO l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sffb004_02_desc',pa_array)
         
         ON CHANGE sffb004_02_desc
            IF cl_null(g_sffb02_m.sffb004_02_desc) THEN
               LET g_sffb02_m.sffb004_02 = ''
            ELSE
               SELECT oogd001 INTO g_sffb02_m.sffb004_02
                 FROM oogd_t
                WHERE oogdent = g_enterprise
                  AND oogdsite = g_site
                  AND oogd002 = g_sffb02_m.sffb004_02_desc
            END IF
         
         BEFORE FIELD sffb010_02_desc
            #機台
            LET l_n = 1
            CALL pa_array.clear()
            LET pa_array[l_n].value = ''
            LET l_n = l_n + 1
            FOREACH sffb010_02_desc_cs INTO l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sffb010_02_desc',pa_array)
         
         ON CHANGE sffb010_02_desc
            IF cl_null(g_sffb02_m.sffb010_02_desc) THEN
               LET g_sffb02_m.sffb010_02 = ''
            ELSE
               SELECT mrba001 INTO g_sffb02_m.sffb010_02
                 FROM mrba_t
                WHERE mrbaent = g_enterprise
                  AND mrbasite = g_site
                  AND mrba004 = g_sffb02_m.sffb010_02_desc
            END IF
         
         BEFORE FIELD docno_1
            LET l_oobx003 = 'asft335'
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql002 CLIPPED
               IF NOT g_notneed_labeltag THEN
                  LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
               END IF
               LET pa_array[l_n].label = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('docno_1',pa_array)
         
         BEFORE FIELD docno_2
            LET l_oobx003 = 'asft335'
            LET l_n = 1
            CALL pa_array.clear()
             FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql002 CLIPPED
               IF NOT g_notneed_labeltag THEN
                  LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
               END IF
               LET pa_array[l_n].label = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
           CALL cl_set_combo_detail('docno_2',pa_array)
         
         BEFORE FIELD docno_3
            LET l_oobx003 = 'asft335'
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql002 CLIPPED
               IF NOT g_notneed_labeltag THEN
                  LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
               END IF
               LET pa_array[l_n].label = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('docno_3',pa_array)
         
         BEFORE FIELD docno_4
            LET l_oobx003 = 'asft335'
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql002 CLIPPED
               IF NOT g_notneed_labeltag THEN
                  LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
               END IF
               LET pa_array[l_n].label = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('docno_4',pa_array)
         
         BEFORE FIELD docno_5
            LET l_oobx003 = 'asft335'
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql002 CLIPPED
               IF NOT g_notneed_labeltag THEN
                  LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
               END IF
               LET pa_array[l_n].label = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('docno_5',pa_array)
         
         BEFORE FIELD docno_6
            #當站下線
            LET l_oobx003 = 'asft337'
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sel_ooba_cs USING l_oobx003 INTO l_oocql002,l_oocql004
               LET pa_array[l_n].value = l_oocql002 CLIPPED
               IF NOT g_notneed_labeltag THEN
                  LET pa_array[l_n].label_tag = l_oocql002 CLIPPED
               END IF
               LET pa_array[l_n].label = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('docno_6',pa_array)
         
         BEFORE FIELD sfhb003
            #庫位
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sfhb003_cs INTO l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sfhb003', pa_array)
         
         BEFORE FIELD sfhb004
            #儲位
            LET l_n = 1
            CALL pa_array.clear()
            FOREACH sfhb004_cs INTO l_oocql004
               LET pa_array[l_n].value = l_oocql004 CLIPPED
               LET l_n = l_n + 1
            END FOREACH
            CALL cl_set_combo_detail('sfhb004', pa_array)
         
      END INPUT
      
      ON ACTION accept
         LET ls_text = g_sffb02_m.sffb009_02,"|",g_sffb02_m.sffb007_02,"|",
                       g_sffb02_m.sffb004_02,"|",g_sffb02_m.sffb010_02,"|",
                       g_sffb02_m.docno_1,"|",g_sffb02_m.docno_2,"|",
                       g_sffb02_m.docno_3,"|",g_sffb02_m.docno_4,"|",
                       g_sffb02_m.docno_5,"|",g_sffb02_m.docno_6,"|",
                       g_sffb02_m.sfhb003,"|",g_sffb02_m.sfhb004
         LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),"asfp331.txt")
	      LET lc_channel = base.Channel.create()
	      CALL lc_channel.openFile(ls_file,"w")
         CALL lc_channel.setDelimiter("")
         CALL lc_channel.write(ls_text)
         CALL FGL_PUTFILE(ls_file,"C:/asfp331.txt")
         CALL lc_channel.close()
         LET g_action_choice = 'menu'
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET g_sffb02_m.* = g_sffb02_m_t.*
         LET g_action_choice = 'menu'
         EXIT DIALOG
      
      ON ACTION close
         LET g_action_choice = 'exit'
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice = 'exit'
         EXIT DIALOG
      
      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG

END FUNCTION

################################################################################
# Descriptions...: |
# Memo...........:
# Usage..........: CALL asfp331_subString(p_str)
# Input parameter: 
# Return code....: 
# Date & Author..: 160125 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_subString(p_str)
DEFINE p_str        STRING
DEFINE r_str        STRING

   LET r_str = ''
   
   IF cl_null(p_str) THEN
      RETURN p_str,r_str
   END IF
   
   IF p_str.getIndexOf('|',1) = 0 THEN
      LET r_str = p_str.subString(1,p_str.getLength())
      LET p_str = ''
   ELSE
      LET r_str = p_str.subString(1,p_str.getIndexOf('|',1)-1)
      LET p_str = p_str.subString(p_str.getIndexOf('|',1)+1,p_str.getLength())
   END IF

   RETURN p_str,r_str
END FUNCTION

################################################################################
# Descriptions...: 新增当站下线单头资料
# Memo...........: copy s_asft335_ins_sfha
# Usage..........: CALL asfp331_ins_sfha(p_docno,p_seq,p_amt)
#                  RETURNING r_success
# Input parameter: p_docno        报工单号
#                : p_seq          报工单项次
#                : p_amt          当站下线数量
# Return code....: r_success      检查通过否
# Date & Author..: 140525 By wujie
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp331_ins_sfha(p_docno,p_seq,p_amt)
DEFINE p_docno      LIKE sffb_t.sffbdocno
DEFINE p_seq        LIKE sffb_t.sffbseq
DEFINE p_amt        LIKE sffb_t.sffb019
DEFINE r_success    LIKE type_t.num5
#DEFINE l_sfha       RECORD LIKE sfha_t.*
#DEFINE l_sfhb       RECORD LIKE sfhb_t.*
#DEFINE l_sfhc       RECORD LIKE sfhc_t.*
#DEFINE l_sffb       RECORD LIKE sffb_t.*
#DEFINE l_success    LIKE type_t.num5
#DEFINE l_slip       LIKE sffb_t.sffbdocno
#DEFINE l_n          LIKE type_t.num5
#DEFINE l_imaf061    LIKE imaf_t.imaf061
#DEFINE l_imaf032    LIKE imaf_t.imaf032
#
#   LET r_success = TRUE
#   
#   IF p_docno IS NULL THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'asf-00300'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#      
#   INITIALIZE l_sfha.* TO NULL
#   INITIALIZE l_sffb.* TO NULL
#
#   SELECT * INTO l_sffb.* FROM sffb_t
#    WHERE sffbent   = g_enterprise
#      AND sffbsite  = g_site
#      AND sffbdocno = p_docno
#      AND sffbseq   = p_seq
#   
#   IF l_sffb.sffb001 <> '3' OR p_amt IS NULL OR p_amt = 0 THEN
#      LET r_success = TRUE 
#      RETURN r_success
#   END IF
#   
##   CALL cl_getslip_get_slip(p_docno) RETURNING l_success,l_slip
##   IF NOT l_success THEN
##      LET r_success = FALSE
##      RETURN r_success
##   END IF   
##
##   LET l_sfha.sfhadocno = NULL
##   LET l_sfha.sfhadocno = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0061')
##   IF cl_null(l_sfha.sfhadocno) THEN
##      #报工单别对应的当站下线单别没有维护，请至aooi200中维护报工单别（1%）的对应当站下线单别（参数D-MFG-0061）
##      INITIALIZE g_errparam TO NULL
##      LET g_errparam.code = 'asf-00680'
##      LET g_errparam.extend = "GET D-MFG-0061 ERROR"
##      LET g_errparam.popup = TRUE
##      LET g_errparam.replace[1] = l_slip
##      CALL cl_err()
##      LET r_success = FALSE
##      RETURN r_success   
##   END IF
#   LET l_sfha.sfhadocdt  = l_sffb.sffbdocdt  #單據日期
#   #160406 by whitney add start
#   CALL s_aooi200_gen_docno(g_site,g_sffb02_m.docno_6,l_sfha.sfhadocdt,'asft337') RETURNING l_success,l_sfha.sfhadocno
#   IF NOT l_success THEN
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   #160406 by whitney add end
##160406 by whitney mark start
##   #Light平台單號存流水碼，備註存放單別
##   LET l_n = 0
##   SELECT MAX(sfhadocno)+1 INTO l_n
##     FROM sfha_t
##    WHERE sfhaent = g_enterprise
##   IF cl_null(l_n) OR l_n = 0 THEN
##      LET l_n = 1
##   END IF
##   LET l_sfha.sfhadocno = l_n USING "&&&&&&&&&&&&&&&&&&&&"
##   LET l_sfha.sfha009 = g_sffb02_m.docno_6
##160406 by whitney mark end
#   
#   LET l_sfha.sfhaent   = g_enterprise      #企業代碼
#   LET l_sfha.sfhasite  = g_site
#   LET l_sfha.sfha001   = l_sffb.sffbdocdt  #過帳日期
#   LET l_sfha.sfha002   = l_sffb.sffb002    #申請人員
#   LET l_sfha.sfha003   = l_sffb.sffb003    #申請部門
#   LET l_sfha.sfha004   = l_sffb.sffb005    #工單單號
#   LET l_sfha.sfha005   = l_sffb.sffb006    #Run Card
#   LET l_sfha.sfha006   = l_sffb.sffb007    #作業編號
#   LET l_sfha.sfha007   = l_sffb.sffb008    #製程序
#   LET l_sfha.sfha008   = p_amt             #當站下線數量
#   LET l_sfha.sfha010   = p_docno           #来源单号
#   LET l_sfha.sfha011   = p_seq             #来源单号项次
#   LET l_sfha.sfhaownid = g_user
#   LET l_sfha.sfhaowndp = g_dept
#   LET l_sfha.sfhacrtid = g_user
#   LET l_sfha.sfhacrtdp = g_dept
#   LET l_sfha.sfhacrtdt = cl_get_current()
#   LET l_sfha.sfhamodid = ""
#   LET l_sfha.sfhamoddt = ""
#   LET l_sfha.sfhastus  = 'N'
#   
#   INSERT INTO sfha_t VALUES(l_sfha.*)
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "ins sfha_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   
#   INITIALIZE l_sfhb.* TO NULL
#   DECLARE sel_offline_tmp CURSOR FOR
#      SELECT * FROM offline_tmp
#   FOREACH sel_offline_tmp INTO l_sfhb.sfhbseq,l_sfhb.sfhb001,l_sfhb.sfhb002,l_sfhb.sfhb008
#      LET l_sfhb.sfhbent   = g_enterprise        #企業代碼
#      LET l_sfhb.sfhbsite  = g_site              #營運據點
#      LET l_sfhb.sfhbdocno = l_sfha.sfhadocno    #單號
#      LET l_sfhb.sfhb003   = g_sffb02_m.sfhb003  #庫位
#      LET l_sfhb.sfhb004   = g_sffb02_m.sfhb004  #儲位
#      IF cl_null(l_sfhb.sfhb008) THEN LET l_sfhb.sfhb008 = 0 END IF
#      IF NOT cl_null(l_sfhb.sfhb001) THEN
#         #單位
#         SELECT imaa006 INTO l_sfhb.sfhb007
#           FROM imaa_t
#          WHERE imaaent = g_enterprise
#            AND imaa001 = l_sfhb.sfhb001
#         #參考單位
#         LET l_imaf032 = ''
#         LET l_imaf061 = ''
#         SELECT imaf015,imaf032,imaf061
#           INTO l_sfhb.sfhb009,l_imaf032,l_imaf061
#           FROM imaf_t
#          WHERE imafent = g_enterprise
#            AND imafsite = g_site
#            AND imaf001 = l_sfhb.sfhb001
#         #生效日期
#         IF l_imaf061 = '1' THEN
#            LET l_sfhb.sfhb011 = cl_get_today()
#            IF NOT cl_null(l_imaf032) THEN
#               LET l_sfhb.sfhb011 = l_sfhb.sfhb011 + l_imaf032
#            END IF
#         END IF
#         #參考數量
#         IF NOT cl_null(l_sfhb.sfhb007) AND cl_null(l_sfhb.sfhb009) THEN
#            CALL s_aooi250_convert_qty(l_sfhb.sfhb001,l_sfhb.sfhb007,l_sfhb.sfhb009,l_sfhb.sfhb008)
#               RETURNING l_success,l_sfhb.sfhb010
#         END IF
#      END IF
#      INSERT INTO sfhb_t VALUES(l_sfhb.*)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "ins sfhb_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET r_success = FALSE
#         CONTINUE FOREACH
#      END IF
#      INITIALIZE l_sfhc.* TO NULL
#      LET l_sfhc.sfhcent   = l_sfhb.sfhbent      #企業編號
#      LET l_sfhc.sfhcsite  = l_sfhb.sfhbsite     #營運據點
#      LET l_sfhc.sfhcdocno = l_sfhb.sfhbdocno    #單號
#      LET l_sfhc.sfhcseq   = l_sfhb.sfhbseq      #項次
#      LET l_sfhc.sfhcseq1  = l_sfhb.sfhbseq      #項序
#      LET l_sfhc.sfhc001   = l_sfhb.sfhb001      #料件編號
#      LET l_sfhc.sfhc002   = l_sfhb.sfhb002      #產品特徵
#      LET l_sfhc.sfhc003   = l_sfhb.sfhb003      #庫位
#      LET l_sfhc.sfhc004   = l_sfhb.sfhb004      #儲位
#      LET l_sfhc.sfhc007   = l_sfhb.sfhb007      #單位
#      LET l_sfhc.sfhc008   = l_sfhb.sfhb008      #數量
#      LET l_sfhc.sfhc009   = l_sfhb.sfhb009      #參考單位
#      LET l_sfhc.sfhc010   = l_sfhb.sfhb010      #參考數量
#      LET l_sfhc.sfhc011   = l_sfhb.sfhb011      #生效日期
#      INSERT INTO sfhc_t VALUES(l_sfhc.*)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "ins sfhc_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET r_success = FALSE
#         CONTINUE FOREACH
#      END IF
#      INITIALIZE l_sfhb.* TO NULL
#   END FOREACH
#   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
