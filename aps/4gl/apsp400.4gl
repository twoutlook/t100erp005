#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2014-07-24 18:47:45), PR版次:0018(2016-12-30 18:23:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000242
#+ Filename...: apsp400
#+ Description: MDS匯總計算作業
#+ Creator....: 01588(2014-03-13 18:44:26)
#+ Modifier...: 01588 -SD/PR- 04441
 
{</section>}
 
{<section id="apsp400.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#50 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160509-00009#11 2016/05/20 By ming     psbb014 保稅否欄位，依照imaf034預設給值
#160530-00010#1  2016/06/06 By ming     1.來源是訂單/預先訂單時，psbb014由xmdc021決定 
#                                       2.來源是獨立需求時，psbb014由psab013而來 
#160613-00024#1  2016/06/26 By ming     當MDS計算策略維護作業apsi001設定分攤方式中的數量進位方式為 依料件最小生產數量及批量
#                                       在計算過程中，有最小生產數量 或 最小生產批量為0，會造成計算結果錯誤
#160630-00013#1  2016/06/30 By ming     l_totsuccess沒有功能，主因在於沒有放在最外層的foreach，導致每次都被重新設定 
#160608-00020#1  2016/07/06 By ming     訂單與預測沖銷方式的調整。
#                                       以預測為主時，當預測的期間內有預測，直接抓預測，排除訂單；如果沒預測就會抓訂單。 
#                                       反之，以訂單為主，一樣當期間內有訂單，就抓訂單，沒有訂單才會考慮預測
#160822-00033#1  2016/09/08 By dorislai apsp400_get_forecast裡的SQL，條件多加版本
#160731-00983#1  2016/09/10 By dorislai 刪除psbb_t時過濾site
#160819-00013#1  2016/09/12 By dorislai 修改需求單160613-00024#1的做法，改成生產單位批量(imae017)、最小生產數量(imae018)，0的話不管控
#                                       有任一欄位<>0，則需進行控管，順序：最小生產批量→生產單位批量
#160912-00040#1  2016/10/17 By dorislai 延續#160608-00020#1，預測的期間，當訂單為主，訂單有資料就抓訂單，沒的話，抓銷售預測資料；
#                                                                 反之，當銷售預測為主，銷售預測有資料有抓銷售預測，沒的話，抓訂單的資料
#161109-00085#16 2016/11/15 By 08993    整批調整系統星號寫法
#161110-00022#1  2016/11/16 By ywtsai   修正取訂單資料判斷預先訂單時，單據性質需判斷5(預先訂單)
#161109-00085#61 2016/11/25 By 08171    整批調整系統星號寫法
#161230-00073#1  2016/12/30 By Whitney  修正#161109-00085#61
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
   psba001               LIKE psba_t.psba001,
   base_date             LIKE type_t.dat,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       psba001 LIKE psba_t.psba001, 
   psba001_desc LIKE type_t.chr80, 
   base_date LIKE type_t.chr500, 
   psba002 LIKE psba_t.psba002, 
   psba003 LIKE psba_t.psba003, 
   psba004 LIKE psba_t.psba004, 
   psba005 LIKE psba_t.psba005, 
   psba007 LIKE psba_t.psba007, 
   psba007_desc LIKE type_t.chr80, 
   psba008 LIKE psba_t.psba008, 
   psba009 LIKE psba_t.psba009, 
   psba010 LIKE psba_t.psba010, 
   psba011 LIKE psba_t.psba011, 
   psba012 LIKE psba_t.psba012, 
   psba006 LIKE psba_t.psba006, 
   psba013 LIKE psba_t.psba013, 
   psba014 LIKE psba_t.psba014, 
   psba015 LIKE psba_t.psba015, 
   psba017 LIKE psba_t.psba017, 
   psba018 LIKE psba_t.psba018, 
   psba019 LIKE psba_t.psba019, 
   psba016 LIKE psba_t.psba016, 
   psba020 LIKE psba_t.psba020, 
   psba021 LIKE psba_t.psba021, 
   psba022 LIKE psba_t.psba022, 
   psba023 LIKE psba_t.psba023, 
   psba024 LIKE psba_t.psba024, 
   psba025 LIKE psba_t.psba025, 
   psba026 LIKE psba_t.psba026, 
   psba027 LIKE psba_t.psba027, 
   psba028 LIKE psba_t.psba028, 
   psba029 LIKE psba_t.psba029, 
   psba030 LIKE psba_t.psba030, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE l_ac              LIKE type_t.num5
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_target          STRING

 type type_g_forecast      RECORD
        xmig001          LIKE xmig_t.xmig001,   #預測編號
        xmig002          LIKE xmig_t.xmig002,   #預測起始日
        xmig003          LIKE xmig_t.xmig003,   #預測版本
        xmig004          LIKE xmig_t.xmig004,   #預測組織
        xmig005          LIKE xmig_t.xmig005,   #業務員
        xmig006          LIKE xmig_t.xmig006,   #預測料號
        xmig007          LIKE xmig_t.xmig007,   #產品特徵
        xmig008          LIKE xmig_t.xmig008,   #客戶
        xmig009          LIKE xmig_t.xmig009,   #通路
        xmig010          LIKE xmig_t.xmig010,   #期別
        xmig011          LIKE xmig_t.xmig011,   #起始日
        xmig012          LIKE xmig_t.xmig012,   #截止日
        quantity         LIKE xmig_t.xmig013,   #預測數量-業務預測數量/生管確認數量
        xmig017          LIKE xmig_t.xmig017,   #預測類型
        xmig018          LIKE xmig_t.xmig018    #單位
                         END RECORD
                         
 type type_g_order         RECORD
        xmdadocno        LIKE xmda_t.xmdadocno, #單號
        xmda002          LIKE xmda_t.xmda002,   #業務員
        xmda003          LIKE xmda_t.xmda003,   #銷售組織
        xmda004          LIKE xmda_t.xmda004,   #客戶
        xmda023          LIKE xmda_t.xmda023,   #通路
        xmddseq          LIKE xmdd_t.xmddseq,   #項次
        xmddseq1         LIKE xmdd_t.xmddseq1,  #項序
        xmddseq2         LIKE xmdd_t.xmddseq2,  #分批序
        xmdd001          LIKE xmdd_t.xmdd001,   #料號
        xmdd002          LIKE xmdd_t.xmdd002,   #產品特徵
        xmdd004          LIKE xmdd_t.xmdd004,   #單位
        quantity         LIKE xmdd_t.xmdd006,   #數量
        xmdd011          LIKE xmdd_t.xmdd011,   #需求日期
        xmdd013          LIKE xmdd_t.xmdd013,   #嚴守交期
        xmdc021          LIKE xmdc_t.xmdc021    #保稅否     #160530-00010#1 20160606 add 
                         END RECORD
type type_g_sort         RECORD
        sort1            LIKE type_t.num5,      #單據排序
        psbbdocno        LIKE psbb_t.psbbdocno, #單據編號
        psbbseq          LIKE psbb_t.psbbseq,   #項次
        psbbseq1         LIKE psbb_t.psbbseq1,  #項序
        psbbseq2         LIKE psbb_t.psbbseq2,  #分批序
        psbb001          LIKE psbb_t.psbb001,   #MDS編號
        psbb002          LIKE psbb_t.psbb002,   #單據類型
        psbb007          LIKE psbb_t.psbb007,   #需求日期
        psbb008          LIKE psbb_t.psbb008,   #客戶
        oocq009          LIKE oocq_t.oocq009,   #客戶重要性
        xmdc020          LIKE xmdc_t.xmdc020    #緊急度
                         END RECORD
                         
DEFINE g_forecast        type_g_forecast
DEFINE g_order           type_g_order
DEFINE g_sort            type_g_sort
#mod--161109-00085#16 By 08993--(s)
#DEFINE g_psba            RECORD LIKE psba_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE g_psba RECORD  #MDS計算策略檔
       psbaent LIKE psba_t.psbaent, #企業編號
       psba001 LIKE psba_t.psba001, #MDS編號
       psba002 LIKE psba_t.psba002, #需求來源-銷售預測
       psba003 LIKE psba_t.psba003, #需求來源-訂單
       psba004 LIKE psba_t.psba004, #需求來源-預先訂單
       psba005 LIKE psba_t.psba005, #需求來源-獨立需求
       psba006 LIKE psba_t.psba006, #需求滿足方式
       psba007 LIKE psba_t.psba007, #指定預測編號
       psba008 LIKE psba_t.psba008, #訂單與預測沖銷方式
       psba009 LIKE psba_t.psba009, #預測需求來源
       psba010 LIKE psba_t.psba010, #預測無效天數
       psba011 LIKE psba_t.psba011, #逾期訂單是否納入
       psba012 LIKE psba_t.psba012, #最長允許逾交天數
       psba013 LIKE psba_t.psba013, #單據順序1
       psba014 LIKE psba_t.psba014, #單據順序2
       psba015 LIKE psba_t.psba015, #單據順序3
       psba016 LIKE psba_t.psba016, #優先順序時距
       psba017 LIKE psba_t.psba017, #重要性順序1
       psba018 LIKE psba_t.psba018, #重要性順序2
       psba019 LIKE psba_t.psba019, #重要性順序3
       psba020 LIKE psba_t.psba020, #預測需求分攤方式
       psba021 LIKE psba_t.psba021, #數量進位方式
       psba022 LIKE psba_t.psba022, #數量進位指定量
       psba023 LIKE psba_t.psba023, #餘量策略
       psba024 LIKE psba_t.psba024, #工作日分攤比-星期一
       psba025 LIKE psba_t.psba025, #工作日分攤比-星期二
       psba026 LIKE psba_t.psba026, #工作日分攤比-星期三
       psba027 LIKE psba_t.psba027, #工作日分攤比-星期四
       psba028 LIKE psba_t.psba028, #工作日分攤比-星期五
       psba029 LIKE psba_t.psba029, #工作日分攤比-星期六
       psba030 LIKE psba_t.psba030, #工作日分攤比-星期日
       psbaownid LIKE psba_t.psbaownid, #資料所有者
       psbaowndp LIKE psba_t.psbaowndp, #資料所屬部門
       psbacrtid LIKE psba_t.psbacrtid, #資料建立者
       psbacrtdp LIKE psba_t.psbacrtdp, #資料建立部門
       psbacrtdt LIKE psba_t.psbacrtdt, #資料創建日
       psbamodid LIKE psba_t.psbamodid, #資料修改者
       psbamoddt LIKE psba_t.psbamoddt, #最近修改日
       psbastus LIKE psba_t.psbastus, #狀態碼
       #161109-00085#61 --s add
       psbaud001 LIKE psba_t.psbaud001, #自定義欄位(文字)001
       psbaud002 LIKE psba_t.psbaud002, #自定義欄位(文字)002
       psbaud003 LIKE psba_t.psbaud003, #自定義欄位(文字)003
       psbaud004 LIKE psba_t.psbaud004, #自定義欄位(文字)004
       psbaud005 LIKE psba_t.psbaud005, #自定義欄位(文字)005
       psbaud006 LIKE psba_t.psbaud006, #自定義欄位(文字)006
       psbaud007 LIKE psba_t.psbaud007, #自定義欄位(文字)007
       psbaud008 LIKE psba_t.psbaud008, #自定義欄位(文字)008
       psbaud009 LIKE psba_t.psbaud009, #自定義欄位(文字)009
       psbaud010 LIKE psba_t.psbaud010, #自定義欄位(文字)010
       psbaud011 LIKE psba_t.psbaud011, #自定義欄位(數字)011
       psbaud012 LIKE psba_t.psbaud012, #自定義欄位(數字)012
       psbaud013 LIKE psba_t.psbaud013, #自定義欄位(數字)013
       psbaud014 LIKE psba_t.psbaud014, #自定義欄位(數字)014
       psbaud015 LIKE psba_t.psbaud015, #自定義欄位(數字)015
       psbaud016 LIKE psba_t.psbaud016, #自定義欄位(數字)016
       psbaud017 LIKE psba_t.psbaud017, #自定義欄位(數字)017
       psbaud018 LIKE psba_t.psbaud018, #自定義欄位(數字)018
       psbaud019 LIKE psba_t.psbaud019, #自定義欄位(數字)019
       psbaud020 LIKE psba_t.psbaud020, #自定義欄位(數字)020
       psbaud021 LIKE psba_t.psbaud021, #自定義欄位(日期時間)021
       psbaud022 LIKE psba_t.psbaud022, #自定義欄位(日期時間)022
       psbaud023 LIKE psba_t.psbaud023, #自定義欄位(日期時間)023
       psbaud024 LIKE psba_t.psbaud024, #自定義欄位(日期時間)024
       psbaud025 LIKE psba_t.psbaud025, #自定義欄位(日期時間)025
       psbaud026 LIKE psba_t.psbaud026, #自定義欄位(日期時間)026
       psbaud027 LIKE psba_t.psbaud027, #自定義欄位(日期時間)027
       psbaud028 LIKE psba_t.psbaud028, #自定義欄位(日期時間)028
       psbaud029 LIKE psba_t.psbaud029, #自定義欄位(日期時間)029
       psbaud030 LIKE psba_t.psbaud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psba031 LIKE psba_t.psba031  #MDS計算日期時間
               END RECORD
#mod--161109-00085#16 By 08993--(e)

DEFINE g_order_day       DYNAMIC ARRAY OF RECORD
         date            LIKE type_t.dat,       #訂單需求日
         qty             LIKE psbb_t.psbb006    #訂單需求量
                         END RECORD
DEFINE g_psbb_sort       LIKE type_t.num10
DEFINE g_psbe            DYNAMIC ARRAY OF RECORD
         psbe002         LIKE psbe_t.psbe002,
         psbe003         LIKE psbe_t.psbe003
                         END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp400.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apsp400_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp400 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsp400_init()
 
      #進入選單 Menu (="N")
      CALL apsp400_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp400
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp400.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp400_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
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
   LET g_errshow = 1
   CALL cl_set_combo_scc('psba008','5402')
   CALL cl_set_combo_scc('psba009','5403')
   CALL cl_set_combo_scc('psba011','8016')
   CALL cl_set_combo_scc('psba006','5420')
   CALL cl_set_combo_scc('psba013','5404')
   CALL cl_set_combo_scc('psba014','5404')
   CALL cl_set_combo_scc('psba015','5404')
   CALL cl_set_combo_scc('psba017','5405')
   CALL cl_set_combo_scc('psba018','5405')
   CALL cl_set_combo_scc('psba019','5405')
   CALL cl_set_combo_scc('psba016','5421')
   CALL cl_set_combo_scc('psba020','5406')
   CALL cl_set_combo_scc('psba021','5407')
   CALL cl_set_combo_scc('psba023','5408')
   CALL cl_set_combo_scc_part('psbe003','5421','1,2,3')
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   LET g_errshow = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp400_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"


   INITIALIZE lc_param.* TO NULL
   LET lc_param.base_date = g_today
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT lc_param.psba001,lc_param.base_date FROM psba001,base_date
               ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               LET lc_param.base_date = g_today
               DISPLAY BY NAME lc_param.base_date
            
            AFTER FIELD psba001
               CALL apsp400_psba001_ref(lc_param.psba001) 
               IF NOT cl_null(lc_param.psba001) THEN
                  IF NOT apsp400_psba001_chk(lc_param.psba001) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
            ON ACTION controlp INFIELD psba001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = lc_param.psba001
               CALL q_psba001()
               LET lc_param.psba001 = g_qryparam.return1
               DISPLAY lc_param.psba001 TO psba001
               
               CALL apsp400_psba001_ref(lc_param.psba001)
               
               NEXT FIELD psba001
         END INPUT
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_psbe TO s_detail1.* ATTRIBUTES(COUNT=l_ac)
            BEFORE DISPLAY
         END DISPLAY 
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apsp400_get_buffer(l_dialog)
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
         CALL apsp400_init()
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
                 CALL apsp400_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsp400_transfer_argv(ls_js)
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
 
{<section id="apsp400.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsp400_transfer_argv(ls_js)
 
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
   LET la_cmdrun.param[1] = la_param.psba001
   LET la_cmdrun.param[2] = la_param.base_date
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="apsp400.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp400_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_msg       STRING
   DEFINE l_psba031   LIKE psba_t.psba031   #2015/06/03 by stellar add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   INITIALIZE g_psba.* TO NULL
   #mod--161109-00085#16 By 08993--(s)
#   SELECT * INTO g_psba.*   #mark--161109-00085#16 By 08993--(s) 
   #161109-00085#61 --s mark
   #SELECT psbaent,psba001,psba002,psba003,psba004,psba005,psba006,psba007,psba008,psba009,psba010,psba011,psba012,
   #       psba013,psba014,psba015,psba016,psba017,psba018,psba019,psba020,psba021,psba022,psba023,psba024,psba025,
   #       psba026,psba027,psba028,psba029,psba030,psbaownid,psbaowndp,psbacrtid,psbacrtdp,psbacrtdt,psbamodid,psbamoddt,
   #       psbastus,psba031 
   #  INTO g_psba.psbaent,g_psba.psba001,g_psba.psba002,g_psba.psba003,g_psba.psba004,g_psba.psba005,g_psba.psba006,g_psba.psba007,
   #       g_psba.psba008,g_psba.psba009,g_psba.psba010,g_psba.psba011,g_psba.psba012,g_psba.psba013,g_psba.psba014,g_psba.psba015,
   #       g_psba.psba016,g_psba.psba017,g_psba.psba018,g_psba.psba019,g_psba.psba020,g_psba.psba021,g_psba.psba022,g_psba.psba023,
   #       g_psba.psba024,g_psba.psba025,g_psba.psba026,g_psba.psba027,g_psba.psba028,g_psba.psba029,g_psba.psba030,g_psba.psbaownid,
   #       g_psba.psbaowndp,g_psba.psbacrtid,g_psba.psbacrtdp,g_psba.psbacrtdt,g_psba.psbamodid,g_psba.psbamoddt,g_psba.psbastus,g_psba.psba031
   #161109-00085#61 --e mark
   #mod--161109-00085#16 By 08993--(e)
   #161109-00085#61 --s add
   SELECT psbaent,psba001,psba002,psba003,psba004,
          psba005,psba006,psba007,psba008,psba009,
          psba010,psba011,psba012,psba013,psba014,
          psba015,psba016,psba017,psba018,psba019,
          psba020,psba021,psba022,psba023,psba024,
          psba025,psba026,psba027,psba028,psba029,
          psba030,psbaownid,psbaowndp,psbacrtid,psbacrtdp,
          psbacrtdt,psbamodid,psbamoddt,psbastus,psbaud001,
          psbaud002,psbaud003,psbaud004,psbaud005,psbaud006,
          psbaud007,psbaud008,psbaud009,psbaud010,psbaud011,
          psbaud012,psbaud013,psbaud014,psbaud015,psbaud016,
          psbaud017,psbaud018,psbaud019,psbaud020,psbaud021,
          psbaud022,psbaud023,psbaud024,psbaud025,psbaud026,
          psbaud027,psbaud028,psbaud029,psbaud030,psba031
     INTO g_psba.psbaent,g_psba.psba001,g_psba.psba002,g_psba.psba003,g_psba.psba004,
          g_psba.psba005,g_psba.psba006,g_psba.psba007,g_psba.psba008,g_psba.psba009,
          g_psba.psba010,g_psba.psba011,g_psba.psba012,g_psba.psba013,g_psba.psba014,
          g_psba.psba015,g_psba.psba016,g_psba.psba017,g_psba.psba018,g_psba.psba019,
          g_psba.psba020,g_psba.psba021,g_psba.psba022,g_psba.psba023,g_psba.psba024,
          g_psba.psba025,g_psba.psba026,g_psba.psba027,g_psba.psba028,g_psba.psba029,
          g_psba.psba030,g_psba.psbaownid,g_psba.psbaowndp,g_psba.psbacrtid,g_psba.psbacrtdp,
          g_psba.psbacrtdt,g_psba.psbamodid,g_psba.psbamoddt,g_psba.psbastus,g_psba.psbaud001,
          g_psba.psbaud002,g_psba.psbaud003,g_psba.psbaud004,g_psba.psbaud005,g_psba.psbaud006,
          g_psba.psbaud007,g_psba.psbaud008,g_psba.psbaud009,g_psba.psbaud010,g_psba.psbaud011,
          g_psba.psbaud012,g_psba.psbaud013,g_psba.psbaud014,g_psba.psbaud015,g_psba.psbaud016,
          g_psba.psbaud017,g_psba.psbaud018,g_psba.psbaud019,g_psba.psbaud020,g_psba.psbaud021,
          g_psba.psbaud022,g_psba.psbaud023,g_psba.psbaud024,g_psba.psbaud025,g_psba.psbaud026,
          g_psba.psbaud027,g_psba.psbaud028,g_psba.psbaud029,g_psba.psbaud030,g_psba.psba031
   #161109-00085#61 --e add
     FROM psba_t
    WHERE psbaent = g_enterprise
      AND psba001 = lc_param.psba001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = lc_param.psba001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   IF NOT apsp400_create_temptable() THEN
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = 6
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsp400_process_cs CURSOR FROM ls_sql
#  FOREACH apsp400_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   #160613-00024#1 20160626 modify -----(S) 
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   #160613-00024#1 20160626 modify -----(E) 
   LET l_success = TRUE
   
   #刪除MDS舊有資料(psbb_t、psbc_t、psbd_t)
   #part1
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('aps-00060',g_dlang)
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   IF NOT apsp400_del_mds() THEN
      LET l_success = FALSE
   END IF
   
   #取得銷售預測資料
   #part2
   IF l_success THEN
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00064',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      CALL apsp400_get_forecast(lc_param.base_date)
           RETURNING l_success
   END IF
   
   #取得訂單資料
   #part3
   IF l_success THEN
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00065',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      CALL apsp400_get_order(lc_param.base_date)
           RETURNING l_success
   END IF
   
   #預測與訂單沖銷
   #part4
   IF l_success THEN
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00066',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      #當銷售預測及訂單都有勾選時，就要依據預測與訂單沖銷方式來做沖銷
      IF g_psba.psba002 = 'Y' AND (g_psba.psba003 = 'Y' OR g_psba.psba004 = 'Y') THEN
         #預測與訂單沖銷方式
         CASE g_psba.psba008
            WHEN '0'
                 #160608-00020#1 20160706 modify -----(S) 
                 #以訂單為主 
                 ##只考量訂單
                 ##直接抓取訂單資料寫入MDS淨需求檔(psbb_t)
                 #CALL apsp400_order_ins_psbb()
                 #     RETURNING l_success
                 #     
                 CALL apsp400_for_order_main()
                      RETURNING l_success
                 #160608-00020#1 20160706 modify -----(E) 
            WHEN '1'
                 #160608-00020#1 20160706 modify -----(S) 
                 #以預測為主
                 ##只考量預測
                 ##計算預測資料分配到天，並寫入MDS淨需求檔(psbb_t)
                 #DECLARE forecast_cs1 CURSOR FOR 
                 # SELECT * FROM forecast_tmp
                 #FOREACH forecast_cs1 INTO g_forecast.*
                 #   CALL apsp400_apportion(g_forecast.quantity,0)
                 #        RETURNING l_success 
                 #   #160613-00024#1 20160626 mark -----(S) 
                 #   #因為此迴圈中只有處理這個，所以不用出錯就離開
                 #   #IF NOT l_success THEN
                 #   #   EXIT FOREACH
                 #   #END IF
                 #   #160613-00024#1 20160626 mark -----(E) 
                 #END FOREACH
                 
                 CALL apsp400_for_forecast_main()
                      RETURNING l_success
                 #160608-00020#1 20160706 modify -----(E) 
            WHEN '2'
                 #兩者取其大
                 CALL apsp400_contra(lc_param.base_date)
                      RETURNING l_success
         END CASE
      ELSE
         #只有銷售預測勾選
         IF g_psba.psba002 = 'Y' THEN
            #計算預測資料分配到天，並寫入MDS淨需求檔(psbb_t)
            DECLARE forecast_cs2 CURSOR FOR 
             #SELECT * FROM forecast_tmp #161109-00085#61 mark
             #161109-00085#61 --s add
             SELECT xmig001,xmig002,xmig003,xmig004,xmig005,
                    xmig006,xmig007,xmig008,xmig009,xmig010,
                    xmig011,xmig012,quantity,xmig017,xmig018
               FROM forecast_tmp
            #161109-00085#61 --e add
            #FOREACH forecast_cs2 INTO g_forecast.* #161109-00085#61 mark
            #161109-00085#61 --s add
            FOREACH forecast_cs2 INTO g_forecast.xmig001,g_forecast.xmig002,g_forecast.xmig003,g_forecast.xmig004,g_forecast.xmig005, 
                                      g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,g_forecast.xmig010, 
                                      g_forecast.xmig011,g_forecast.xmig012,g_forecast.quantity,g_forecast.xmig017,g_forecast.xmig018 
            #161109-00085#61 --e add
               CALL apsp400_apportion(g_forecast.quantity,0)
                    RETURNING l_success
               #160613-00024#1 20160626 mark -----(S) 
               #IF NOT l_success THEN
               #   EXIT FOREACH
               #END IF
               #160613-00024#1 20160626 mark -----(E) 
            END FOREACH
         END IF
      
         #只有訂單/預先訂單勾選
         IF g_psba.psba003 = 'Y' OR g_psba.psba004 = 'Y' THEN
            #直接抓取訂單資料寫入MDS淨需求檔(psbb_t)
            CALL apsp400_order_ins_psbb()
                 RETURNING l_success
         END IF
      END IF
   END IF
   
   #獨立需求
   #part5
   IF l_success THEN
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00067',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      IF g_psba.psba005 = 'Y' THEN
         CALL apsp400_independent_demand()
              RETURNING l_success
      END IF
   END IF
   
   #排列優先順序
   #part6
   IF l_success THEN
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00068',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      CALL apsp400_psbb_sort(lc_param.base_date)
           RETURNING l_success
   END IF
   
   #2015/06/03 by stellar add ----- (S)
   #更新MDS計算日期時間psba031
   IF l_success THEN
      LET l_psba031 = cl_get_current()
      UPDATE psba_t SET psba031 = l_psba031
       WHERE psbaent = g_psba.psbaent
         AND psba001 = g_psba.psba001
      IF SQLCA.sqlcode THEN
         LET l_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd psba031"
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
      END IF
   END IF
   #2015/06/03 by stellar add ----- (E)
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF NOT l_success THEN
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_showmsg() 
         CALL cl_err_collect_show() 
         #160613-00024#1 20160626 modify -----(E) 
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apsp400_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp400.get_buffer" >}
PRIVATE FUNCTION apsp400_get_buffer(p_dialog)
 
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
 
{<section id="apsp400.msgcentre_notify" >}
PRIVATE FUNCTION apsp400_msgcentre_notify()
 
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
 
{<section id="apsp400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: MDS編號檢查
# Memo...........:
# Usage..........: CALL apsp400_psba001_chk(p_psba001)
#                  RETURNING r_success
# Input parameter: p_psba001      MDS編號
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_psba001_chk(p_psba001)
DEFINE p_psba001         LIKE psba_t.psba001
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_psba001) THEN
      RETURN r_success
   END IF
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_psba001
   LET g_errshow = TRUE   #160318-00025#50
   LET g_chkparam.err_str[1] = "aps-00044:sub-01302|apsi001|",cl_get_progname("apsi001",g_lang,"2"),"|:EXEPROGapsi001"    #160318-00025#50
   IF NOT cl_chk_exist("v_psba001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 抓取MDS編號說明
# Memo...........:
# Usage..........: CALL apsp400_psba001_ref(p_psba001)
#                  
# Input parameter: p_psba001      MDS編號
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/03/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_psba001_ref(p_psba001)
DEFINE p_psba001         LIKE psba_t.psba001
DEFINE l_psba001_desc    LIKE psbal_t.psbal003
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psba            RECORD LIKE psba_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psba RECORD  #MDS計算策略檔
       psbaent LIKE psba_t.psbaent, #企業編號
       psba001 LIKE psba_t.psba001, #MDS編號
       psba002 LIKE psba_t.psba002, #需求來源-銷售預測
       psba003 LIKE psba_t.psba003, #需求來源-訂單
       psba004 LIKE psba_t.psba004, #需求來源-預先訂單
       psba005 LIKE psba_t.psba005, #需求來源-獨立需求
       psba006 LIKE psba_t.psba006, #需求滿足方式
       psba007 LIKE psba_t.psba007, #指定預測編號
       psba008 LIKE psba_t.psba008, #訂單與預測沖銷方式
       psba009 LIKE psba_t.psba009, #預測需求來源
       psba010 LIKE psba_t.psba010, #預測無效天數
       psba011 LIKE psba_t.psba011, #逾期訂單是否納入
       psba012 LIKE psba_t.psba012, #最長允許逾交天數
       psba013 LIKE psba_t.psba013, #單據順序1
       psba014 LIKE psba_t.psba014, #單據順序2
       psba015 LIKE psba_t.psba015, #單據順序3
       psba016 LIKE psba_t.psba016, #優先順序時距
       psba017 LIKE psba_t.psba017, #重要性順序1
       psba018 LIKE psba_t.psba018, #重要性順序2
       psba019 LIKE psba_t.psba019, #重要性順序3
       psba020 LIKE psba_t.psba020, #預測需求分攤方式
       psba021 LIKE psba_t.psba021, #數量進位方式
       psba022 LIKE psba_t.psba022, #數量進位指定量
       psba023 LIKE psba_t.psba023, #餘量策略
       psba024 LIKE psba_t.psba024, #工作日分攤比-星期一
       psba025 LIKE psba_t.psba025, #工作日分攤比-星期二
       psba026 LIKE psba_t.psba026, #工作日分攤比-星期三
       psba027 LIKE psba_t.psba027, #工作日分攤比-星期四
       psba028 LIKE psba_t.psba028, #工作日分攤比-星期五
       psba029 LIKE psba_t.psba029, #工作日分攤比-星期六
       psba030 LIKE psba_t.psba030, #工作日分攤比-星期日
       psbaownid LIKE psba_t.psbaownid, #資料所有者
       psbaowndp LIKE psba_t.psbaowndp, #資料所屬部門
       psbacrtid LIKE psba_t.psbacrtid, #資料建立者
       psbacrtdp LIKE psba_t.psbacrtdp, #資料建立部門
       psbacrtdt LIKE psba_t.psbacrtdt, #資料創建日
       psbamodid LIKE psba_t.psbamodid, #資料修改者
       psbamoddt LIKE psba_t.psbamoddt, #最近修改日
       psbastus LIKE psba_t.psbastus, #狀態碼
       #161109-00085#61 --s add
       psbaud001 LIKE psba_t.psbaud001, #自定義欄位(文字)001
       psbaud002 LIKE psba_t.psbaud002, #自定義欄位(文字)002
       psbaud003 LIKE psba_t.psbaud003, #自定義欄位(文字)003
       psbaud004 LIKE psba_t.psbaud004, #自定義欄位(文字)004
       psbaud005 LIKE psba_t.psbaud005, #自定義欄位(文字)005
       psbaud006 LIKE psba_t.psbaud006, #自定義欄位(文字)006
       psbaud007 LIKE psba_t.psbaud007, #自定義欄位(文字)007
       psbaud008 LIKE psba_t.psbaud008, #自定義欄位(文字)008
       psbaud009 LIKE psba_t.psbaud009, #自定義欄位(文字)009
       psbaud010 LIKE psba_t.psbaud010, #自定義欄位(文字)010
       psbaud011 LIKE psba_t.psbaud011, #自定義欄位(數字)011
       psbaud012 LIKE psba_t.psbaud012, #自定義欄位(數字)012
       psbaud013 LIKE psba_t.psbaud013, #自定義欄位(數字)013
       psbaud014 LIKE psba_t.psbaud014, #自定義欄位(數字)014
       psbaud015 LIKE psba_t.psbaud015, #自定義欄位(數字)015
       psbaud016 LIKE psba_t.psbaud016, #自定義欄位(數字)016
       psbaud017 LIKE psba_t.psbaud017, #自定義欄位(數字)017
       psbaud018 LIKE psba_t.psbaud018, #自定義欄位(數字)018
       psbaud019 LIKE psba_t.psbaud019, #自定義欄位(數字)019
       psbaud020 LIKE psba_t.psbaud020, #自定義欄位(數字)020
       psbaud021 LIKE psba_t.psbaud021, #自定義欄位(日期時間)021
       psbaud022 LIKE psba_t.psbaud022, #自定義欄位(日期時間)022
       psbaud023 LIKE psba_t.psbaud023, #自定義欄位(日期時間)023
       psbaud024 LIKE psba_t.psbaud024, #自定義欄位(日期時間)024
       psbaud025 LIKE psba_t.psbaud025, #自定義欄位(日期時間)025
       psbaud026 LIKE psba_t.psbaud026, #自定義欄位(日期時間)026
       psbaud027 LIKE psba_t.psbaud027, #自定義欄位(日期時間)027
       psbaud028 LIKE psba_t.psbaud028, #自定義欄位(日期時間)028
       psbaud029 LIKE psba_t.psbaud029, #自定義欄位(日期時間)029
       psbaud030 LIKE psba_t.psbaud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psba031 LIKE psba_t.psba031  #MDS計算日期時間
               END RECORD
#mod--161109-00085#16 By 08993--(e)

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_psba001
   CALL ap_ref_array2(g_ref_fields,"SELECT psbal003 FROM psbal_t WHERE psbalent='"||g_enterprise||"' AND psbal001=? AND psbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_psba001_desc = '', g_rtn_fields[1] , ''
   DISPLAY l_psba001_desc TO psba001_desc
   
   INITIALIZE l_psba.* TO NULL
   #mod--161109-00085#16 By 08993--(s)
#   SELECT * INTO l_psba.*   #mark--161109-00085#16 By 08993--(s)
   #161109-00085#61 --s mark
   #SELECT psbaent,psba001,psba002,psba003,psba004,psba005,psba006,psba007,psba008,psba009,psba010,psba011,psba012,
   #       psba013,psba014,psba015,psba016,psba017,psba018,psba019,psba020,psba021,psba022,psba023,psba024,psba025,
   #       psba026,psba027,psba028,psba029,psba030,psbaownid,psbaowndp,psbacrtid,psbacrtdp,psbacrtdt,psbamodid,psbamoddt,
   #       psbastus,psba031 
   #  INTO l_psba.psbaent,l_psba.psba001,l_psba.psba002,l_psba.psba003,l_psba.psba004,l_psba.psba005,l_psba.psba006,
   #       l_psba.psba007,l_psba.psba008,l_psba.psba009,l_psba.psba010,l_psba.psba011,l_psba.psba012,l_psba.psba013,
   #       l_psba.psba014,l_psba.psba015,l_psba.psba016,l_psba.psba017,l_psba.psba018,l_psba.psba019,l_psba.psba020,
   #       l_psba.psba021,l_psba.psba022,l_psba.psba023,l_psba.psba024,l_psba.psba025,l_psba.psba026,l_psba.psba027,
   #       l_psba.psba028,l_psba.psba029,l_psba.psba030,l_psba.psbaownid,l_psba.psbaowndp,l_psba.psbacrtid,l_psba.psbacrtdp,
   #       l_psba.psbacrtdt,l_psba.psbamodid,l_psba.psbamoddt,l_psba.psbastus,l_psba.psba031
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   SELECT psbaent,psba001,psba002,psba003,psba004,
          psba005,psba006,psba007,psba008,psba009,
          psba010,psba011,psba012,psba013,psba014,
          psba015,psba016,psba017,psba018,psba019,
          psba020,psba021,psba022,psba023,psba024,
          psba025,psba026,psba027,psba028,psba029,
          psba030,psbaownid,psbaowndp,psbacrtid,psbacrtdp,
          psbacrtdt,psbamodid,psbamoddt,psbastus,psbaud001,
          psbaud002,psbaud003,psbaud004,psbaud005,psbaud006,
          psbaud007,psbaud008,psbaud009,psbaud010,psbaud011,
          psbaud012,psbaud013,psbaud014,psbaud015,psbaud016,
          psbaud017,psbaud018,psbaud019,psbaud020,psbaud021,
          psbaud022,psbaud023,psbaud024,psbaud025,psbaud026,
          psbaud027,psbaud028,psbaud029,psbaud030,psba031
     INTO l_psba.psbaent,l_psba.psba001,l_psba.psba002,l_psba.psba003,l_psba.psba004,
          l_psba.psba005,l_psba.psba006,l_psba.psba007,l_psba.psba008,l_psba.psba009,
          l_psba.psba010,l_psba.psba011,l_psba.psba012,l_psba.psba013,l_psba.psba014,
          l_psba.psba015,l_psba.psba016,l_psba.psba017,l_psba.psba018,l_psba.psba019,
          l_psba.psba020,l_psba.psba021,l_psba.psba022,l_psba.psba023,l_psba.psba024,
          l_psba.psba025,l_psba.psba026,l_psba.psba027,l_psba.psba028,l_psba.psba029,
          l_psba.psba030,l_psba.psbaownid,l_psba.psbaowndp,l_psba.psbacrtid,l_psba.psbacrtdp,
          l_psba.psbacrtdt,l_psba.psbamodid,l_psba.psbamoddt,l_psba.psbastus,l_psba.psbaud001,
          l_psba.psbaud002,l_psba.psbaud003,l_psba.psbaud004,l_psba.psbaud005,l_psba.psbaud006,
          l_psba.psbaud007,l_psba.psbaud008,l_psba.psbaud009,l_psba.psbaud010,l_psba.psbaud011,
          l_psba.psbaud012,l_psba.psbaud013,l_psba.psbaud014,l_psba.psbaud015,l_psba.psbaud016,
          l_psba.psbaud017,l_psba.psbaud018,l_psba.psbaud019,l_psba.psbaud020,l_psba.psbaud021,
          l_psba.psbaud022,l_psba.psbaud023,l_psba.psbaud024,l_psba.psbaud025,l_psba.psbaud026,
          l_psba.psbaud027,l_psba.psbaud028,l_psba.psbaud029,l_psba.psbaud030,l_psba.psba031
   #161109-00085#61 --e add
   #mod--161109-00085#16 By 08993--(e)
     FROM psba_t
    WHERE psbaent = g_enterprise
      AND psba001 = p_psba001
   
   DISPLAY BY NAME l_psba.psba002,l_psba.psba003,l_psba.psba004,l_psba.psba005,l_psba.psba006,
                   l_psba.psba007,l_psba.psba008,l_psba.psba009,l_psba.psba010,l_psba.psba011,
                   l_psba.psba012,l_psba.psba013,l_psba.psba014,l_psba.psba015,l_psba.psba016,
                   l_psba.psba017,l_psba.psba018,l_psba.psba019,l_psba.psba020,l_psba.psba021,
                   l_psba.psba022,l_psba.psba023,l_psba.psba024,l_psba.psba025,l_psba.psba026,
                   l_psba.psba027,l_psba.psba028,l_psba.psba029,l_psba.psba030
                   
   IF l_psba.psba016 = '4' THEN
      #自訂時距
      CALL apsp400_b_fill(l_psba.psba001) 
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刪除MDS舊有資料
# Memo...........:
# Usage..........: CALL apsp400_del_mds()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/18 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_del_mds()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
  
   #MDS淨需求檔
   DELETE FROM psbb_t 
    WHERE psbbent = g_enterprise
      AND psbbsite = g_site  #160731-00983#1-add
      AND psbb001 = g_psba.psba001
      
   IF SQLCA.sqlcode THEN 
      #160613-00024#1 20160626 modify -----(S) 
      #CALL cl_errmsg('del psbb',g_psba.psba001,'',SQLCA.sqlcode,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'del psbb_t ',g_psba.psba001
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err() 
      #160613-00024#1 20160626 modify -----(E) 
      LET r_success = FALSE
   END IF
   
   #MDS銷售預測沖銷單頭檔
   DELETE FROM psbc_t
    WHERE psbcent = g_enterprise
      AND psbc001 = g_psba.psba001
   IF SQLCA.sqlcode THEN 
      #160613-00024#1 20160626 modify -----(S) 
      #CALL cl_errmsg('del psbc',g_psba.psba001,'',SQLCA.sqlcode,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'del pspc_t ',g_psba.psba001
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #160613-00024#1 20160626 modify -----(E) 
      LET r_success = FALSE
   END IF
   
   #MDS銷售預測沖銷單身檔
   DELETE FROM psbd_t
    WHERE psbdent = g_enterprise
      AND psbd001 = g_psba.psba001
   IF SQLCA.sqlcode THEN 
      #160613-00024#1 20160626 modify -----(S) 
      #CALL cl_errmsg('del psbd',g_psba.psba001,'',SQLCA.sqlcode,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'del psbd_t ',g_psba.psba001
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #160613-00024#1 20160626 modify -----(E) 
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 取得銷售預測資料
# Memo...........:
# Usage..........: CALL apsp400_get_forecast(p_base_date)
#                  RETURNING r_success
# Input parameter: p_base_date    計算基準日
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/19 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_get_forecast(p_base_date)
DEFINE p_base_date       LIKE type_t.dat
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_imaa006         LIKE imaa_t.imaa006
DEFINE l_xmig016         LIKE xmig_t.xmig016

   LET r_success = TRUE
   IF cl_null(p_base_date) THEN
      RETURN r_success
   END IF
   
   #需求來源-銷售預測 = 'N'
   IF cl_null(g_psba.psba002) OR g_psba.psba002 = 'N' THEN
      RETURN r_success
   END IF
   
   #抓取銷售預測資料
   #160822-00033#1-s-mod
   #LET l_sql = "SELECT xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009, ",
   #            "       xmig010,xmig011,xmig012,xmig013,xmig017,xmig018,xmig016 ",
   #            "  FROM xmig_t ",
   #            " WHERE xmigent = ",g_enterprise,
   #            "   AND xmigsite= '",g_site,"'",
   #            "   AND xmig001 = '",g_psba.psba007,"'",
   #            "   AND xmig002 = (SELECT MAX(xmig002) FROM xmig_t ",
   #            "                   WHERE xmigent = ",g_enterprise,
   #            "                     AND xmigsite= '",g_site,"'",
   #            "                     AND xmig001 = '",g_psba.psba007,"')",
   #            "   AND xmig012 >= '",p_base_date,"'"
   LET l_sql = "SELECT xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009, ",
               "       xmig010,xmig011,xmig012,xmig013,xmig017,xmig018,xmig016 ",
               "  FROM xmig_t a",
               " WHERE xmigent = ",g_enterprise,
               "   AND xmigsite= '",g_site,"'",
               "   AND xmig001 = '",g_psba.psba007,"'",
               "   AND xmig002 = (SELECT MAX(b.xmig002) FROM xmig_t  b ",
               "                   WHERE b.xmigent = a.xmigent ",
               "                     AND b.xmigsite = a.xmigsite ",
               "                     AND b.xmig001 = a.xmig001)",
               "   AND xmig003 = (SELECT MAX(c.xmig003) FROM xmig_t  c ",
               "                   WHERE c.xmigent = a.xmigent ",
               "                     AND c.xmigsite = a.xmigsite ",
               "                     AND c.xmig001 = a.xmig001 ",
               "                     AND c.xmig002 = a.xmig002)",
               "   AND xmig012 >= '",p_base_date,"'"
   #160822-00033#1-e-mod
   
   #2015/06/03 by stellar add ----- (S)
   #若沖銷方式不是2.兩者取其大，就不用記錄MDS預測沖銷單頭檔(psbc_t)內的無效數量
   #所以也就不用撈取無效的資料
   #2016/02/16 by stellar modify ----- (S)
#   IF g_psba.psba008 <> '2' THEN
   IF g_psba.psba008 <> '2' AND g_psba.psba010 > 0 THEN   #0表示不使用預測無效天數
   #2016/02/16 by stellar modify ----- (E)
      LET l_sql = l_sql CLIPPED,
                  " AND xmig011 > '",p_base_date + g_psba.psba010,"'"
   END IF
   #2015/06/03 by stellar add ----- (E)
   
   PREPARE forecast_pre FROM l_sql
   DECLARE forecast_cs CURSOR FOR forecast_pre
   
   #FOREACH forecast_cs INTO g_forecast.*,l_xmig016 #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH forecast_cs INTO  g_forecast.xmig001,g_forecast.xmig002,g_forecast.xmig003,g_forecast.xmig004,g_forecast.xmig005, 
                             g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,g_forecast.xmig010, 
                             g_forecast.xmig011,g_forecast.xmig012,g_forecast.quantity,g_forecast.xmig017,g_forecast.xmig018,
                             l_xmig016
   #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("FOREACH forecast_cs","","",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH forecast_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.code   = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      IF g_psba.psba009 = '2' THEN
         LET g_forecast.quantity = l_xmig016
      END IF
      
      #單位轉換為基礎單位
      SELECT imaa006 INTO l_imaa006 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_forecast.xmig006
         
      #訂單換算成基礎單位的數量
      CALL s_aooi250_convert_qty(g_forecast.xmig006,g_forecast.xmig018,l_imaa006,g_forecast.quantity)
           RETURNING r_success,g_forecast.quantity
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      LET g_forecast.xmig018 = l_imaa006
      
      #mod--161109-00085#16 By 08993--(s)
#      INSERT INTO forecast_tmp VALUES (g_forecast.*)   #mark--161109-00085#16 By 08993--(s)
      INSERT INTO forecast_tmp (xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,
                                xmig009,xmig010,xmig011,xmig012,quantity,xmig017,xmig018) 
                        VALUES (g_forecast.xmig001,g_forecast.xmig002,g_forecast.xmig003,g_forecast.xmig004,g_forecast.xmig005,
                                g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,g_forecast.xmig010,
                                g_forecast.xmig011,g_forecast.xmig012,g_forecast.quantity,g_forecast.xmig017,g_forecast.xmig018 )          
      #mod--161109-00085#16 By 08993--(e)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("ins forecast",g_forecast.xmig001,"",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins forecast',g_forecast.xmig001
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 取得訂單/預先訂單資料
# Memo...........:
# Usage..........: CALL apsp400_get_order(p_base_date)
#                  RETURNING r_success
# Input parameter: p_base_date    計算基準日
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/18 By stellar0130
# Modify.........: 160530-00010#1  2016/06/06 By ming sql多抓取xmdc021
################################################################################
PRIVATE FUNCTION apsp400_get_order(p_base_date)
DEFINE p_base_date       LIKE type_t.dat
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_imaa006         LIKE imaa_t.imaa006

   LET r_success = TRUE
   IF cl_null(p_base_date) THEN
      RETURN r_success
   END IF
   
   IF g_psba.psba003 = 'N' AND g_psba.psba004 = 'N' THEN
      RETURN r_success
   END IF
   
   #抓取訂單資料
   LET l_sql = "SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023, ",
               "       xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002, ",
               "       xmdd004,(xmdd006-xmdd014+xmdd015) amt,xmdd011, ", 
               #160530-00010#1 20160606 modify by ming -----(S) 
               #"       xmdd013 ",
               "       xmdd013,xmdc021 ", 
               #160530-00010#1 20160606 modify by ming -----(E) 
               "  FROM xmda_t,xmdc_t,xmdd_t ",
               " WHERE xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmdaent = xmddent ",
               "   AND xmdadocno = xmdddocno ",
               "   AND xmdcseq = xmddseq ",
               "   AND xmdaent = ",g_enterprise,
               "   AND xmdcunit= '",g_site,"'",    #出貨地點
               "   AND xmda019 = 'Y' ",            #納入MRP計算
               "   AND xmdastus= 'Y' ",            #已確認訂單
               "   AND xmdd017 <> '5' ",           #單身未結案
               "   AND (xmdd006 - xmdd014 + xmdd015) > 0 "
   #逾交訂單是否納入
   IF g_psba.psba011 = 'Y' THEN
      LET l_sql = l_sql CLIPPED," AND xmdd011 >= '",p_base_date-g_psba.psba012,"'"
   ELSE
      LET l_sql = l_sql CLIPPED," AND xmdd011 >= '",p_base_date,"'"
   END IF
   
   #預先訂單='N'
   IF g_psba.psba004 = 'N' THEN
      #LET l_sql = l_sql CLIPPED," AND xmda005 <> '7' "      #161110-00022#1 mark
      LET l_sql = l_sql CLIPPED," AND xmda005 <> '5' "       #161110-00022#1 add
   END IF
   
   #訂單='N'
   IF g_psba.psba003 = 'N' THEN
      #LET l_sql = l_sql CLIPPED," AND xmda005 = '7' "       #161110-00022#1 mark
      LET l_sql = l_sql CLIPPED," AND xmda005 = '5' "        #161110-00022#1 add
   END IF
               
   PREPARE order_pre FROM l_sql
   DECLARE order_cs CURSOR FOR order_pre
   
   #FOREACH order_cs INTO g_order.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH order_cs INTO g_order.xmdadocno,g_order.xmda002,g_order.xmda003,g_order.xmda004,g_order.xmda023,  
                         g_order.xmddseq,g_order.xmddseq1,g_order.xmddseq2,g_order.xmdd001,g_order.xmdd002,  
                         g_order.xmdd004,g_order.quantity,g_order.xmdd011,g_order.xmdd013,g_order.xmdc021  
   #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("FOREACH order_cs","","",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH order_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #訂單單位轉為基礎單位
      SELECT imaa006 INTO l_imaa006 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_order.xmdd001
      
      #訂單換算成基礎單位的數量
      CALL s_aooi250_convert_qty(g_order.xmdd001,g_order.xmdd004,l_imaa006,g_order.quantity)
           RETURNING r_success,g_order.quantity
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      LET g_order.xmdd004 = l_imaa006
      
      #mod--161109-00085#16 By 08993--(s)
#      INSERT INTO order_tmp VALUES (g_order.*)   #mark--161109-00085#16 By 08993--(s)
      INSERT INTO order_tmp (xmdadocno,xmda002,xmda003,xmda004,xmda023,xmddseq,xmddseq1,xmddseq2,xmdd001,
                             xmdd002,xmdd004,quantity,xmdd011,xmdd013,xmdc021)
                     VALUES (g_order.xmdadocno,g_order.xmda002,g_order.xmda003,g_order.xmda004,g_order.xmda023,
                             g_order.xmddseq,g_order.xmddseq1,g_order.xmddseq2,g_order.xmdd001,g_order.xmdd002,
                             g_order.xmdd004,g_order.quantity,g_order.xmdd011,g_order.xmdd013,g_order.xmdc021)
      #mod--161109-00085#16 By 08993--(e)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("ins order",g_order.xmdadocno,"",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins order ',g_order.xmdadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 預測與訂單沖銷
# Memo...........:
# Usage..........: CALL apsp400_contra(p_base_date)
#                  RETURNING r_success
# Input parameter: p_base_date    計算基準日
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/18 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_contra(p_base_date)
DEFINE p_base_date       LIKE type_t.dat
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psbc            RECORD LIKE psbc_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psbc RECORD  #MDS銷售預測沖銷單頭檔
       psbcent LIKE psbc_t.psbcent, #企業編號
       psbcsite LIKE psbc_t.psbcsite, #營運據點
       psbc001 LIKE psbc_t.psbc001, #MDS編號
       psbc002 LIKE psbc_t.psbc002, #預測組織
       psbc003 LIKE psbc_t.psbc003, #業務員
       psbc004 LIKE psbc_t.psbc004, #預測料號
       psbc005 LIKE psbc_t.psbc005, #產品特徵
       psbc006 LIKE psbc_t.psbc006, #客戶
       psbc007 LIKE psbc_t.psbc007, #通路
       psbc008 LIKE psbc_t.psbc008, #期別
       psbc009 LIKE psbc_t.psbc009, #起始日期
       psbc010 LIKE psbc_t.psbc010, #截止日期
       psbc011 LIKE psbc_t.psbc011, #需求類型
       psbc012 LIKE psbc_t.psbc012, #預測數量
       psbc013 LIKE psbc_t.psbc013, #無效數量
       psbc014 LIKE psbc_t.psbc014, #被沖銷數量
       psbc015 LIKE psbc_t.psbc015, #沖銷後餘量
       psbc016 LIKE psbc_t.psbc016, #預測編號
       psbc017 LIKE psbc_t.psbc017, #預測起始日期
       psbc018 LIKE psbc_t.psbc018, #預測版本
      #psbc019 LIKE psbc_t.psbc019  #MDS計算日期時間  #161109-00085#61 mark
       #161109-00085#61 --s add 
       psbc019 LIKE psbc_t.psbc019, #MDS計算日期時間
       psbcud001 LIKE psbc_t.psbcud001, #自定義欄位(文字)001
       psbcud002 LIKE psbc_t.psbcud002, #自定義欄位(文字)002
       psbcud003 LIKE psbc_t.psbcud003, #自定義欄位(文字)003
       psbcud004 LIKE psbc_t.psbcud004, #自定義欄位(文字)004
       psbcud005 LIKE psbc_t.psbcud005, #自定義欄位(文字)005
       psbcud006 LIKE psbc_t.psbcud006, #自定義欄位(文字)006
       psbcud007 LIKE psbc_t.psbcud007, #自定義欄位(文字)007
       psbcud008 LIKE psbc_t.psbcud008, #自定義欄位(文字)008
       psbcud009 LIKE psbc_t.psbcud009, #自定義欄位(文字)009
       psbcud010 LIKE psbc_t.psbcud010, #自定義欄位(文字)010
       psbcud011 LIKE psbc_t.psbcud011, #自定義欄位(數字)011
       psbcud012 LIKE psbc_t.psbcud012, #自定義欄位(數字)012
       psbcud013 LIKE psbc_t.psbcud013, #自定義欄位(數字)013
       psbcud014 LIKE psbc_t.psbcud014, #自定義欄位(數字)014
       psbcud015 LIKE psbc_t.psbcud015, #自定義欄位(數字)015
       psbcud016 LIKE psbc_t.psbcud016, #自定義欄位(數字)016
       psbcud017 LIKE psbc_t.psbcud017, #自定義欄位(數字)017
       psbcud018 LIKE psbc_t.psbcud018, #自定義欄位(數字)018
       psbcud019 LIKE psbc_t.psbcud019, #自定義欄位(數字)019
       psbcud020 LIKE psbc_t.psbcud020, #自定義欄位(數字)020
       psbcud021 LIKE psbc_t.psbcud021, #自定義欄位(日期時間)021
       psbcud022 LIKE psbc_t.psbcud022, #自定義欄位(日期時間)022
       psbcud023 LIKE psbc_t.psbcud023, #自定義欄位(日期時間)023
       psbcud024 LIKE psbc_t.psbcud024, #自定義欄位(日期時間)024
       psbcud025 LIKE psbc_t.psbcud025, #自定義欄位(日期時間)025
       psbcud026 LIKE psbc_t.psbcud026, #自定義欄位(日期時間)026
       psbcud027 LIKE psbc_t.psbcud027, #自定義欄位(日期時間)027
       psbcud028 LIKE psbc_t.psbcud028, #自定義欄位(日期時間)028
       psbcud029 LIKE psbc_t.psbcud029, #自定義欄位(日期時間)029
       psbcud030 LIKE psbc_t.psbcud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add 
END RECORD
#mod--161109-00085#16 By 08993--(e)

DEFINE l_cnt             LIKE type_t.num5
DEFINE l_xmia011         LIKE xmia_t.xmia011
DEFINE l_xmia012         LIKE xmia_t.xmia012
DEFINE l_xmia013         LIKE xmia_t.xmia013
DEFINE l_xmia014         LIKE xmia_t.xmia014
DEFINE L_xmia015         LIKE xmia_t.xmia015
DEFINE l_ooed002         LIKE ooed_t.ooed002
DEFINE l_ooed003         LIKE ooed_t.ooed003 
DEFINE l_psbc002         LIKE psbc_t.psbc002
DEFINE l_psbc003         LIKE psbc_t.psbc003
DEFINE l_psbc004         LIKE psbc_t.psbc004
DEFINE l_psbc005         LIKE psbc_t.psbc005
DEFINE l_psbc006         LIKE psbc_t.psbc006
DEFINE l_psbc007         LIKE psbc_t.psbc007
DEFINE l_psbc008         LIKE psbc_t.psbc008
DEFINE l_psbc012         LIKE psbc_t.psbc012
DEFINE l_psbc013         LIKE psbc_t.psbc013
DEFINE l_forecast_quantity LIKE psbc_t.psbc012
DEFINE l_order_quantity  LIKE xmdd_t.xmdd006
DEFINE l_quantity        LIKE xmdd_t.xmdd006
DEFINE l_psbd019         LIKE psbd_t.psbd019
DEFINE l_current_time    DATETIME YEAR TO SECOND 
   #160613-00024#1 20160626 add -----(S) 
   DEFINE l_totsuccess   LIKE type_t.num5
   #160613-00024#1 20160626 add -----(E) 

   LET r_success = TRUE
   IF cl_null(p_base_date) THEN
      RETURN r_success
   END IF
   
   #先做來源為業務預測資料的沖銷，再做計畫性下階料的沖銷
   #業務預測的沖銷要考慮沖銷條件，計畫性下階料直接以料號做沖銷
   #LET l_sql = "SELECT * FROM forecast_tmp ", #161109-00085#61 mark
   #161109-00085#61 --s add
   LET l_sql = " SELECT xmig001,xmig002,xmig003,xmig004,xmig005, ",
               "        xmig006,xmig007,xmig008,xmig009,xmig010, ",
               "        xmig011,xmig012,quantity,xmig017,xmig018 ",
               "   FROM forecast_tmp",
   #161109-00085#61 --e add
               " ORDER BY xmig017 "
   PREPARE forecast_tmp_pre FROM l_sql
   DECLARE forecast_tmp_cs CURSOR FOR forecast_tmp_pre
   
   #160630-00013#1 20160630 add by ming -----(S) 
   #打從一開始就應該放在這裡.....
   LET l_totsuccess = TRUE
   #160630-00013#1 20160630 add by ming -----(E) 
   
   #FOREACH forecast_tmp_cs INTO g_forecast.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH forecast_tmp_cs INTO g_forecast.xmig001,g_forecast.xmig002,g_forecast.xmig003,g_forecast.xmig004,g_forecast.xmig005, 
                                g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,g_forecast.xmig010, 
                                g_forecast.xmig011,g_forecast.xmig012,g_forecast.quantity,g_forecast.xmig017,g_forecast.xmig018 
   #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("FOREACH forecast_tmp","","",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH forecast_tmp'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err() 
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_forecast_quantity = g_forecast.quantity
      
      #當資料不存在時，新增MDS預測沖銷單頭檔(psbc_t)
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM psbc_t
       WHERE psbcent = g_enterprise
         AND psbcsite= g_site
         AND psbc001 = g_psba.psba001
         AND psbc002 = g_forecast.xmig004
         AND psbc003 = g_forecast.xmig005
         AND psbc004 = g_forecast.xmig006
         AND psbc005 = g_forecast.xmig007
         AND psbc006 = g_forecast.xmig008
         AND psbc007 = g_forecast.xmig009
         AND psbc008 = g_forecast.xmig010
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         #先將預測資料寫入MDS預測沖銷單頭檔(psbc_t)
         INITIALIZE l_psbc.* TO NULL
         LET l_psbc.psbc001 = g_psba.psba001
         LET l_psbc.psbc002 = g_forecast.xmig004
         LET l_psbc.psbc003 = g_forecast.xmig005
         LET l_psbc.psbc004 = g_forecast.xmig006
         LET l_psbc.psbc005 = g_forecast.xmig007
         LET l_psbc.psbc006 = g_forecast.xmig008
         LET l_psbc.psbc007 = g_forecast.xmig009
         LET l_psbc.psbc008 = g_forecast.xmig010
         LET l_psbc.psbc009 = g_forecast.xmig011
         LET l_psbc.psbc010 = g_forecast.xmig012
         LET l_psbc.psbc011 = g_psba.psba009
         LET l_psbc.psbc012 = l_forecast_quantity
         LET l_psbc.psbc013 = 0
         LET l_psbc.psbc014 = 0
         LET l_psbc.psbc015 = 0
         LET l_psbc.psbc016 = g_forecast.xmig001
         LET l_psbc.psbc017 = g_forecast.xmig002
         LET l_psbc.psbc018 = g_forecast.xmig003
         LET l_current_time = cl_get_current()
      
         INSERT INTO psbc_t (psbcent,psbcsite,psbc001,psbc002,psbc003,psbc004,psbc005,
                             psbc006,psbc007,psbc008,psbc009,psbc010,psbc011,psbc012,
                             psbc013,psbc014,psbc015,psbc016,psbc017,psbc018,psbc019)
            VALUES (g_enterprise,g_site,l_psbc.psbc001,l_psbc.psbc002,l_psbc.psbc003,
                    l_psbc.psbc004,l_psbc.psbc005,l_psbc.psbc006,l_psbc.psbc007,
                    l_psbc.psbc008,l_psbc.psbc009,l_psbc.psbc010,l_psbc.psbc011,
                    l_psbc.psbc012,l_psbc.psbc013,l_psbc.psbc014,l_psbc.psbc015,
                    l_psbc.psbc016,l_psbc.psbc017,l_psbc.psbc018,l_current_time)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            #160613-00024#1 20160626 modify -----(S) 
            #CALL cl_errmsg('ins psbc_t',l_psbc.psbc001,'',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins psbc_t ',l_psbc.psbc001
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #160613-00024#1 20160626 modify -----(E) 
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      
      #若起始日期小於等於無效預測日的話，就不管預測資料
      IF g_forecast.xmig012 <= p_base_date + g_psba.psba010 THEN
         #將預測數量更新到MDS預測沖銷單頭檔(psbc_t)內的無效數量
         UPDATE psbc_t SET psbc013 = psbc013 + l_psbc.psbc012
          WHERE psbcent = g_enterprise
            AND psbcsite= g_site
            AND psbc001 = g_psba.psba001
            AND psbc002 = g_forecast.xmig004
            AND psbc003 = g_forecast.xmig005
            AND psbc004 = g_forecast.xmig006
            AND psbc005 = g_forecast.xmig007
            AND psbc006 = g_forecast.xmig008
            AND psbc007 = g_forecast.xmig009
            AND psbc008 = g_forecast.xmig010
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
            #160613-00024#1 20160626 modify -----(S) 
            #CALL cl_errmsg('upd psbc_t',l_psbc.psbc001,'',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'upd psbc_t ',l_psbc.psbc001
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #160613-00024#1 20160626 modify -----(E) 
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         CONTINUE FOREACH
      END IF
      
      #依預測類型抓取訂單數量
      LET l_order_quantity = 0
      IF g_forecast.xmig017 = '1' THEN
         #1.業務預測
         
         #訂單數量
        #LET l_sql = "SELECT * FROM order_tmp ", #161109-00085#61 mark
        #161109-00085#61 --s add
         LET l_sql = "SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023, ",
                     "       xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002, ",  
                     "       xmdd004,quantity,xmdd011,xmdd013,xmdc021 ",
                     "FROM order_tmp ",
        #161109-00085#61 --e add    
                     " WHERE xmdd001 IN (SELECT imaf001 FROM imaf_t ",
                     "                    WHERE imafent = ",g_enterprise,
                     "                      AND imafsite= '",g_site,"'",
                     "                      AND imaf125 = '",g_forecast.xmig006,"')",
                     "   AND xmdd011 BETWEEN '",g_forecast.xmig011,"' AND '",g_forecast.xmig012,"' "
         
         #判斷預測方式可沖銷
         SELECT xmia011,xmia012,xmia013,xmia014,xmia015
           INTO l_xmia011,l_xmia012,l_xmia013,l_xmia014,l_xmia015
           FROM xmia_t
          WHERE xmiaent = g_enterprise
            AND xmia001 = g_forecast.xmig001
           
         #預測組織
         IF l_xmia011 = 'Y' THEN
            LET l_ooed002 = ''
            LET l_ooed003 = ''
            SELECT DISTINCT ooed002,ooed003 INTO l_ooed002,l_ooed003
              FROM ooed_t
             WHERE ooedent = g_enterprise
               AND ooed001 = '2'
               AND ooed004 = g_forecast.xmig004
               AND ooed006 <= p_base_date
               AND (ooed007 > p_base_date OR ooed007 IS NULL)
            IF NOT cl_null(l_ooed002) AND NOT cl_null(l_ooed003) THEN
               LET l_sql = l_sql CLIPPED," AND (xmda003 IN (SELECT ooed004 FROM ooed_t ",
                                         "                 CONNECT BY ooed005 = prior ooed004 ",
                                         "                     AND ooedent = ",g_enterprise,
                                         "                     AND ooed001 = '2' ",
                                         "                     AND ooed002 = '",l_ooed002,"'",
                                         "                     AND ooed003 = '",l_ooed003,"'",
                                         "                     AND ooed002 <> ooed005 ",
                                         "                   START WITH ooed005 = '",g_forecast.xmig004,"'",
                                         "                     AND ooedent = ",g_enterprise,
                                         "                     AND ooed001 = '2' ",
                                         "                     AND ooed002 = '",l_ooed002,"'",
                                         "                     AND ooed003 = '",l_ooed003,"')",
                                         "   OR xmda003 = '",g_forecast.xmig004,"')"
            ELSE
               LET l_sql = l_sql CLIPPED," AND xmda003 = '",g_forecast.xmig004,"'"
            END IF
         END IF
         
         #業務員
         IF l_xmia012 = 'Y' THEN
            LET l_sql = l_sql CLIPPED," AND xmda002 = '",g_forecast.xmig005,"'"
         END IF
         
         #客戶
         IF l_xmia013 = 'Y' THEN
            LET l_sql = l_sql CLIPPED," AND xmda004 = '",g_forecast.xmig008,"'"
         END IF
         
         #通路
         IF l_xmia014 = 'Y' THEN
            LET l_sql = l_sql CLIPPED," AND xmda023 = '",g_forecast.xmig009,"'"
         END IF
         
         #產品特徵
         IF l_xmia015 = 'Y' THEN
            LET l_sql = l_sql CLIPPED," AND xmdd002 = '",g_forecast.xmig007,"'"
         END IF
  
      ELSE
         #2.計畫性下階料
         
         #直接依料號抓取未沖銷訂單數量
         #LET l_sql = "SELECT * FROM order_tmp ", #161109-00085#61 mark
         #161109-00085#61 --s add
         LET l_sql = "SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023, ",
                     "       xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002, ",  
                     "       xmdd004,quantity,xmdd011,xmdd013,xmdc021 ",
                     "FROM order_tmp ",
         #161109-00085#61 --e add  
                     " WHERE pmdd001 IN (SELECT imaf001 FROM imaf_t ",
                     "                    WHERE imafent = ",g_enterprise,
                     "                      AND imafsite= '",g_site,"'",
                     "                      AND imaf125 = '",g_forecast.xmig006,"')"
      END IF
      
      LET l_sql = l_sql CLIPPED," ORDER BY xmdd011 "
      
      PREPARE order_quantity_pre FROM l_sql
      DECLARE order_quantity_cs CURSOR FOR order_quantity_pre
      
      LET l_order_quantity = 0
      CALL g_order_day.clear()
      LET l_ac = 1
      #160630-00013#1 20160630 mark -----(S) 
      #l_totsuccess應該移到foreach外去預設 
      ##160613-00024#1 20160626 add -----(S) 
      #LET l_totsuccess = TRUE 
      ##160613-00024#1 20160626 add -----(E) 
      #160630-00013#1 20160630 mark -----(E) 
      #FOREACH order_quantity_cs INTO g_order.* #161109-00085#61 mark
      #161109-00085#61 --s add
      FOREACH order_quantity_cs INTO g_order.xmdadocno,g_order.xmda002,g_order.xmda003,g_order.xmda004,g_order.xmda023,
                                     g_order.xmddseq,g_order.xmddseq1,g_order.xmddseq2,g_order.xmdd001,g_order.xmdd002,
                                     g_order.xmdd004,g_order.quantity,g_order.xmdd011,g_order.xmdd013,g_order.xmdc021 
      #161109-00085#61 --e add 
         LET l_order_quantity = l_order_quantity + g_order.quantity
         
         #記錄該訂單的日期和數量，後續分配到天會用到
         LET g_order_day[l_ac].date = g_order.xmdd011
         LET g_order_day[l_ac].qty  = g_order.quantity
         LET l_ac = l_ac + 1
      
         #記錄預測資料是被哪些訂單沖銷，
         #把抓到的訂單資料寫入MDS銷售預測單身檔內
         INSERT INTO psbd_t (psbdent,psbdsite,psbd001,psbd002,psbd003,psbd004,psbd005,
                             psbd006,psbd007,psbd008,psbd009,psbd010,psbd011,psbd012,
                             psbd013,psbd014,psbd015,psbd016,psbd017,psbd018,psbd019,
                             psbd020)
             VALUES (g_enterprise,g_site,g_psba.psba001,g_forecast.xmig004,g_forecast.xmig005,
                     g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,
                     g_forecast.xmig010,g_order.xmdadocno,g_order.xmddseq,g_order.xmddseq1,
                     g_order.xmddseq2,g_order.xmda003,g_order.xmda002,g_order.xmdd001,
                     g_order.xmdd002,g_order.xmda004,g_order.xmda023,g_order.quantity,
                     g_order.xmdd011)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            #160613-00024#1 20160626 modify -----(S) 
            #CALL cl_errmsg('ins psbd_t','','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins psbd_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #160613-00024#1 20160626 modify -----(E) 
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      #比較預測數量與訂單數量，訂單較大者不做處理，預測較大者，則將預測超出訂單的數量寫入淨需求檔內
      IF l_forecast_quantity > l_order_quantity THEN
         
         #將沖銷後預測量做分配到天的動作，並將分配到天的資料寫入淨需求檔內
         CALL apsp400_apportion(l_forecast_quantity,l_order_quantity)
              RETURNING r_success
         IF NOT r_success THEN
            #160613-00024#1 20160626 modify -----(S) 
            #EXIT FOREACH
            LET l_totsuccess = FALSE
            LET r_success = TRUE
            #160613-00024#1 20160626 modify -----(E) 
         END IF
      END IF
      
   END FOREACH 
   
   #160613-00024#1 20160626 add -----(S) 
   IF NOT l_totsuccess THEN
      LET r_success = FALSE
      #160630-00013#1 20160630 add -----(S) 
      RETURN r_success 
      #160630-00013#1 20160630 add -----(E) 
   END IF    
   
   
   #160613-00024#1 20160626 add -----(E) 
    
   #更新MDS銷售預測沖銷單頭檔的訂單沖銷量=訂單數量
   #及預測剩餘量=預測量-無效量-訂單沖銷量，如果小於0時，則更改為0 
   DECLARE psbc_cs CURSOR FOR
    SELECT psbc002,psbc003,psbc004,psbc005,psbc006,psbc007,psbc008,
           psbc012,psbc013
      FROM psbc_t
     WHERE psbcent = g_enterprise
       AND psbcsite= g_site
       AND psbc001 = g_psba.psba001
   FOREACH psbc_cs INTO l_psbc002,l_psbc003,l_psbc004,l_psbc005,l_psbc006,l_psbc007,l_psbc008,
                        l_psbc012,l_psbc013
      
      LET l_psbd019 = 0
      SELECT SUM(psbd019) INTO l_psbd019
        FROM psbd_t
       WHERE psbdent = g_enterprise
         AND psbdsite= g_site
         AND psbd001 = g_psba.psba001
         AND psbd002 = l_psbc002
         AND psbd003 = l_psbc003
         AND psbd004 = l_psbc004
         AND psbd005 = l_psbc005
         AND psbd006 = l_psbc006
         AND psbd007 = l_psbc007
         AND psbd008 = l_psbc008
      IF cl_null(l_psbd019) THEN
         LET l_psbd019 = 0
      END IF
      
      LET l_quantity = l_psbc012 - l_psbc013 - l_psbd019
      IF l_quantity < 0 THEN
         LET l_quantity = 0
      END IF
      
      UPDATE psbc_t SET psbc014 = l_psbd019,
                        psbc015 = l_quantity
       WHERE psbcent = g_enterprise
         AND psbcsite= g_site
         AND psbc001 = g_psba.psba001
         AND psbc002 = l_psbc002
         AND psbc003 = l_psbc003
         AND psbc004 = l_psbc004
         AND psbc005 = l_psbc005
         AND psbc006 = l_psbc006
         AND psbc007 = l_psbc007
         AND psbc008 = l_psbc008
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg('upd psbc_t','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd psbc_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   #把訂單寫入淨需求檔
   CALL apsp400_order_ins_psbb()
        RETURNING r_success
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 預測量分配到天
# Memo...........:
# Usage..........: CALL apsp400_apportion(p_forecast_qty,p_order_qty)
#                  RETURNING r_success
# Input parameter: p_forecast_qty 預測量
#                : p_order_qty    訂單數量
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/20 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_apportion(p_forecast_qty,p_order_qty)
DEFINE p_forecast_qty    LIKE psbb_t.psbb006
DEFINE p_order_qty       LIKE psbb_t.psbb006
DEFINE r_success         LIKE type_t.num5
DEFINE l_qty             LIKE psbb_t.psbb006       #沖銷後數量
DEFINE l_qty1            LIKE psbb_t.psbb006       #當天/週還可分配的預測量
DEFINE l_qty2            LIKE psbb_t.psbb006       #當天還可分配的預測量
DEFINE l_ooef008         LIKE ooef_t.ooef008       #行事曆參照表號
DEFINE l_ooef009         LIKE ooef_t.ooef009       #製造行事曆對應類別
DEFINE l_workdays        LIKE type_t.num5          #起始日期到截止日期的工作天
DEFINE l_workdays1       LIKE type_t.num5          #需求預測的實際需要的工作天
DEFINE l_imae017         LIKE imae_t.imae017       #生產批量
DEFINE l_imae018         LIKE imae_t.imae018       #最小生產數量
DEFINE l_carry           LIKE psbb_t.psbb006       #依料件的生產批量及最小生產數量去得出最小生產數量
DEFINE l_num             LIKE psbb_t.psbb006       #計算的過渡
DEFINE l_num1            LIKE psbb_t.psbb006       #計算的過渡
DEFINE l_workday_qty     LIKE psbb_t.psbb006       #每個工作天的預測需求量
DEFINE l_remainder       LIKE psbb_t.psbb006       #餘量
DEFINE l_firstday_qty    LIKE psbb_t.psbb006       #第一天的工作量
DEFINE l_lastday_qty     LIKE psbb_t.psbb006       #最後一天的工作量
DEFINE l_first_workdate  LIKE type_t.dat           #第一天工作天的日期
DEFINE l_last_workdate   LIKE type_t.dat           #最後一天工作天的日期
DEFINE l_order_remainder LIKE psbb_t.psbb006       #在最後一天工作天之後的訂單量
DEFINE l_order_qty       LIKE psbb_t.psbb006       #當日/週訂單量
DEFINE l_workdate        LIKE psbb_t.psbb007       #當日日期
DEFINE l_i               LIKE type_t.num5
DEFINE l_j               LIKE type_t.num5
DEFINE l_ac              LIKE type_t.num5
DEFINE l_week_day        LIKE type_t.num5          #當週的工作天
DEFINE l_week_qty        LIKE psbb_t.psbb006       #當週的預測量
DEFINE l_denominator     LIKE type_t.num20_6       #分攤百分比-分母
DEFINE l_molecular       DYNAMIC ARRAY OF LIKE type_t.num20_6       #分攤百分比-分子
DEFINE l_day_qty         DYNAMIC ARRAY OF RECORD   #當週工作天的分配預測量
         date            LIKE type_t.dat,
         qty             LIKE psbb_t.psbb006
                         END RECORD
DEFINE l_week_totqty     LIKE psbb_t.psbb006       #當週累計的分配預測量
DEFINE l_product         LIKE type_t.num5        
DEFINE l_ooga002         LIKE ooga_t.ooga002
DEFINE l_oogc008         LIKE oogc_t.oogc008
DEFINE l_oogc015         LIKE oogc_t.oogc015
DEFINE l_min_date        LIKE type_t.dat
DEFINE l_max_date        LIKE type_t.dat
DEFINE l_date            LIKE type_t.dat
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_week_lastday    LIKE type_t.dat   #當週最後一天工作天   #2015/06/03 by stellar add
DEFINE l_control_num     LIKE type_t.num5  #紀錄當天的產能       160819-00013#1-add


   LET r_success = TRUE
   
   LET l_qty = p_forecast_qty - p_order_qty
   IF l_qty <= 0 THEN
      RETURN r_success
   END IF
   
   #抓取行事曆參照表號及製造行事曆對應類別
   SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   #取得起始日期到截止日期的工作天
   LET l_first_workdate = g_forecast.xmig011 - 1
   CALL s_date_get_workdays(g_site,l_ooef008,l_ooef009,l_first_workdate,g_forecast.xmig012)
        RETURNING l_workdays
   LET l_workdays = l_workdays
   
   #2015/02/13 by stellar add ----- (S)
   #若工作天數=0，將數量當成餘量歸屬第一天或最後一天
   IF l_workdays = 0 THEN
      IF g_psba.psba023 = '1' THEN   #最後一天
         CALL apsp400_forecast_ins_psbb(g_forecast.xmig012,l_qty)
              RETURNING r_success
      ELSE                           #第一天
         CALL apsp400_forecast_ins_psbb(g_forecast.xmig011,l_qty)
              RETURNING r_success
      END IF
      
      RETURN r_success
   END IF
   #2015/02/13 by stellar add ----- (E)
   
   IF g_psba.psba021 = '1' THEN
      #依料件最小生產數量與批量進位:
      
      #1.抓取生產批量、最小生產數量
      SELECT imae017,imae018 INTO l_imae017,l_imae018
        FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite= g_site
         AND imae001 = g_forecast.xmig006 
      
      #160819-00013#1-s-mark
      ##160613-00024#1 20160626 add -----(S) 
      #IF (l_imae017 = 0 OR cl_null(l_imae017)) OR
      #   (l_imae018 = 0 OR cl_null(l_imae018)) THEN
      #   IF l_imae017 = 0 OR cl_null(l_imae017) THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.extend = ''
      #      LET g_errparam.code   = 'aps-00190'
      #      LET g_errparam.popup  = TRUE
      #      LET g_errparam.replace[1] = g_forecast.xmig006
      #      CALL cl_err()
      #   END IF
      #
      #   IF l_imae018 = 0 OR cl_null(l_imae018) THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.extend = ''
      #      LET g_errparam.code   = 'aps-00191'
      #      LET g_errparam.popup  = TRUE
      #      LET g_errparam.replace[1] = g_forecast.xmig006
      #      CALL cl_err()
      #   END IF
      #
      #   LET r_success = FALSE
      #   RETURN r_success
      #END IF
      #160613-00024#1 20160626 add -----(E) 
      #160819-00013#1-e-mark
      
      #2.依生產批量、最小生產數量去計算最小生產數量
      #160819-00013#1-s-mod
      #CALL s_num_round('4',l_imae018/l_imae017,0)
      #     RETURNING l_product
      ##160315-00001#1 by stellar modify ----- (S)
      ##LET l_carry = l_imae018 * l_product
      #LET l_carry = l_imae017 * l_product
      ##160315-00001#1 by stellar modify ----- (E)
      IF (l_imae017 <> 0 AND NOT cl_null(l_imae017)) AND (l_imae018 <> 0 AND NOT cl_null(l_imae018)) THEN
         CALL s_num_round('4',l_imae018/l_imae017,0)
           RETURNING l_product
         LET l_carry = l_imae017 * l_product
         LET l_control_num = l_imae017
      ELSE
         IF l_imae018 <> 0 AND NOT cl_null(l_imae018) THEN
            LET l_carry = l_imae018
            LET l_control_num = l_imae018
         END IF
         IF l_imae017 <> 0 AND NOT cl_null(l_imae017) THEN
            LET l_carry = l_imae017
            LET l_control_num = l_imae017
         END IF
      END IF
      #160819-00013#1-e-mod  
   ELSE
      #數量進位指定量
      #LET l_imae017 = g_psba.psba022  #160819-00013#1-s-mod
      LET l_control_num = g_psba.psba022   #160819-00013#1-e-mod
      LET l_carry = g_psba.psba022
   END IF
   
   #計算每天可工作量:
   #1.計算每天可工作量(未進位)
   LET l_num = g_forecast.quantity / l_workdays
   #2.進位
   IF l_num <= l_carry THEN
      LET l_workday_qty = l_carry
   ELSE
      #160819-00013#1-s-mod
      #CALL s_num_round('4',l_num/l_imae017,0)
      #     RETURNING l_num1
      #LET l_workday_qty = l_num1 * l_imae017
      CALL s_num_round('4',l_num/l_control_num,0)
           RETURNING l_num1
      LET l_workday_qty = l_num1 * l_control_num
      #160819-00013#1-e-mod
   END IF
   
   #花費的工作天
   CALL s_num_round('4',g_forecast.quantity/l_workday_qty,0)
        RETURNING l_workdays1
        
   #餘量
   LET l_remainder = (l_workday_qty*l_workdays1) - g_forecast.quantity
   IF l_remainder <> 0 THEN
      LET l_remainder = l_workday_qty - l_remainder
   END IF
   
   #餘量歸屬
   IF l_remainder > 0 THEN 
      IF g_psba.psba023 = '1' THEN
         #最後一天
         LET l_lastday_qty = l_remainder
         LET l_firstday_qty= l_workday_qty
      ELSE
         #第一天
         LET l_firstday_qty= l_workday_qty + l_remainder
         LET l_lastday_qty = l_workday_qty
         LET l_workdays1 = l_workdays1 - 1
      END IF
   ELSE
      LET l_firstday_qty= l_workday_qty
      LET l_lastday_qty = l_workday_qty
   END IF
   
   #最後一天花費的工作天的日期
   CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_first_workdate,0,l_workdays1)
        RETURNING l_last_workdate
   
   #在花費的工作天之後的訂單量
   LET l_order_remainder = 0
   FOR l_i = g_order_day.getLength() TO 1 STEP -1
      IF cl_null(g_order_day[l_i].date) THEN
         CONTINUE FOR
      END IF
      IF g_order_day[l_i].date > l_last_workdate THEN
         LET l_order_remainder = l_order_remainder + g_order_day[l_i].qty
         LET l_ac = l_i
      ELSE
         LET l_ac = l_i
         EXIT FOR
      END IF
      IF l_j = 0 THEN
         LET l_ac = 0
      END IF
   END FOR
   
   #預測需求分攤方式
   #2015/01/20 by stellar modify ----- (S)
   #增加兩個選項處理
#   IF g_psba.psba020 = '1' THEN
   CASE g_psba.psba020
      WHEN '1'
   #2015/01/20 by stellar modify ----- (E)
         #依工作天數平均分攤
         FOR l_i = l_workdays1 TO 1 STEP -1
            LET l_order_qty = 0
            IF l_ac > 0 THEN
               CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_first_workdate,0,l_i)
                    RETURNING l_workdate
               FOR l_j = l_ac TO 1 STEP -1
                  #當天訂單量
                  IF l_workdate = g_order_day[l_j].date THEN
                     LET l_order_qty = g_order_day[l_j].qty
                  ELSE
                     LET l_ac = l_j
                     EXIT FOR
                  END IF
               END FOR
            END IF
               
            #當天可分配量 - 當天訂單量 - 訂單剩餘量
            CASE 
               WHEN l_i = l_workdays1
                    #最後一天            
                    LET l_qty1 = l_lastday_qty - l_order_qty - l_order_remainder
               WHEN l_i = 1
                    #第一天
                    LET l_qty1 = l_firstday_qty - l_order_qty - l_order_remainder
               OTHERWISE
                    LET l_qty1 = l_workday_qty - l_order_qty - l_order_remainder
            END CASE
               
            #若大於0，表示當天還可分配的預測量
            IF l_qty1 > 0 THEN
               CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_first_workdate,0,l_i)
                    RETURNING l_workdate
               IF l_qty > l_qty1 THEN
                  #若尚未分配的預測量 > 當天還可分配的預測量，則將當天還可分配的預測量新增進淨需求檔(psbb_t)
                  CALL apsp400_forecast_ins_psbb(l_workdate,l_qty1)
                       RETURNING r_success
                  IF NOT r_success THEN
                     EXIT FOR
                  END IF
                  LET l_qty = l_qty - l_qty1
               ELSE
                  #若尚未分配的預測量 <=當天還可分配的預測量，則將尚未分配的預測量新增進淨需求檔(psbb_t)
                  CALL apsp400_forecast_ins_psbb(l_workdate,l_qty)
                       RETURNING r_success
                  EXIT FOR
               END IF
               #訂單剩餘量
               LET l_order_remainder = 0
            ELSE
               #訂單剩餘量
               LET l_order_remainder = l_qty1 * (-1)
            END IF
         END FOR
   #2015/01/20 by stellar modify ----- (S)
#   ELSE
      WHEN '2'
   #2015/01/20 by stellar modify ----- (E)
         #依工作天數進行週分攤
         DECLARE oogc_cs CURSOR FOR
          SELECT DISTINCT oogc008,oogc015 
            FROM oogc_t
           WHERE oogcent = g_enterprise
             AND oogc001 = l_ooef008
             AND oogc002 = l_ooef009
             AND oogc003 > l_first_workdate
             AND oogc003 <= l_last_workdate
           ORDER BY oogc008 DESC
         
         FOREACH oogc_cs INTO l_oogc008,l_oogc015
            
            CALL l_day_qty.clear()
            
            #本週的起始日、截止日
            SELECT MIN(oogc003),MAX(oogc003)
              INTO l_min_date,l_max_date
              FROM oogc_t
             WHERE oogcent = g_enterprise
               AND oogc001 = l_ooef008
               AND oogc002 = l_ooef009
               AND oogc008 = l_oogc008
               AND oogc015 = l_oogc015
               
            LET l_min_date = l_min_date - 1
   #         IF l_first_workdate > l_min_date THEN
   #            LET l_min_date = l_first_workdate
   #         END IF
   #         
   #         IF l_last_workdate < l_max_date THEN
   #            LET l_max_date = l_last_workdate 
   #         END IF
                           
            #當週訂單量
            LET l_order_qty = 0
            IF l_ac >= 1 THEN
               FOR l_j = l_ac TO 1 STEP -1
                  IF cl_null(g_order_day[l_j].date) THEN
                     CONTINUE FOR
                  END IF
   #               IF g_order_day[l_j].date >= l_min_date THEN
                  IF g_order_day[l_j].date > l_min_date THEN
                     LET l_order_qty = l_order_qty + g_order_day[l_j].qty
                  ELSE
                     LET l_ac = l_j
                     EXIT FOR
                  END IF
               END FOR
               IF l_j = 0 THEN
                  LET l_ac = 0
               END IF
            END IF
            
            #當週分配的天數
            
            CALL s_date_get_workdays(g_site,l_ooef008,l_ooef009,l_min_date,l_max_date)
                 RETURNING l_week_day
                   
            #當週的可分配量
            LET l_week_qty = 0
            CASE 
               WHEN l_min_date > l_first_workdate AND l_max_date < l_last_workdate
                    CALL s_date_get_workdays(g_site,l_ooef008,l_ooef009,l_min_date,l_max_date)
                         RETURNING l_week_day
               WHEN l_min_date <= l_first_workdate AND l_max_date < l_last_workdate
                    CALL s_date_get_workdays(g_site,l_ooef008,l_ooef009,l_first_workdate,l_max_date)
                         RETURNING l_week_day
                    LET l_week_day = l_week_day - 1
                    LET l_week_qty = l_firstday_qty
               WHEN l_min_date > l_first_workdate AND l_max_date >= l_last_workdate
                    CALL s_date_get_workdays(g_site,l_ooef008,l_ooef009,l_min_date,l_last_workdate)
                         RETURNING l_week_day
                    LET l_week_day = l_week_day - 1
                    LET l_week_qty = l_lastday_qty
               WHEN l_min_date <= l_first_workdate AND l_max_date >= l_last_workdate
                    CALL s_date_get_workdays(g_site,l_ooef008,l_ooef009,l_first_workdate,l_last_workdate)
                         RETURNING l_week_day
                    LET l_week_day = l_week_day - 2
                    LET l_week_qty = l_firstday_qty + l_lastday_qty
            END CASE
            LET l_week_qty = l_week_qty + l_week_day * l_workday_qty
            
            #剩餘預測量
            LET l_qty1 = l_week_qty - l_order_qty - l_order_remainder
               
            #若大於0，表示當週還可分配的預測量
            IF l_qty1 > 0 THEN
               
               IF l_qty > l_qty1 THEN
                  #若尚未分配的預測量 > 當週還可分配的預測量，則將當週還可分配的預測量新增進淨需求檔(psbb_t)
                  LET l_qty = l_qty - l_qty1 
               ELSE
                  #若尚未分配的預測量 <=當週還可分配的預測量，則將尚未分配的預測量新增進淨需求檔(psbb_t)
                  LET l_qty1 = l_qty
                  LET l_qty = 0
               END IF
               
               #當週的工作天百分比-分母
               LET l_denominator = 0
               #160315-00001#1 by stellar modify ----- (S)
#               LET l_cnt = l_max_date - l_min_date + 1
               LET l_cnt = l_max_date - l_min_date
               #160315-00001#1 by stellar modify ----- (E)
               FOR l_i = 1 TO l_cnt
                  CALL s_date_get_date(l_min_date,0,l_i)
                       RETURNING l_date
                    
                  #確認日期是否為工作天
                  IF s_date_chk_workday(g_site,l_ooef008,l_ooef009,l_date) THEN
                     #該日期為星期?
                     SELECT ooga002 INTO l_ooga002 
                       FROM ooga_t
                      WHERE oogaent = g_enterprise
                        AND ooga001 = l_date
                     CASE l_ooga002
                        WHEN '1'
                             LET l_denominator = l_denominator + g_psba.psba024
                             LET l_molecular[l_i] = g_psba.psba024
                        WHEN '2'
                             LET l_denominator = l_denominator + g_psba.psba025
                             LET l_molecular[l_i] = g_psba.psba025
                        WHEN '3'
                             LET l_denominator = l_denominator + g_psba.psba026
                             LET l_molecular[l_i] = g_psba.psba026
                        WHEN '4'
                             LET l_denominator = l_denominator + g_psba.psba027
                             LET l_molecular[l_i] = g_psba.psba027
                        WHEN '5'
                             LET l_denominator = l_denominator + g_psba.psba028
                             LET l_molecular[l_i] = g_psba.psba028
                        WHEN '6'
                             LET l_denominator = l_denominator + g_psba.psba029
                             LET l_molecular[l_i] = g_psba.psba029
                        WHEN '0'
                             LET l_denominator = l_denominator + g_psba.psba030
                             LET l_molecular[l_i] = g_psba.psba030
                     END CASE
                     #2015/06/03 by stellar add ---- (S)
                     IF l_molecular[l_i] > 0 THEN   
                        LET l_week_lastday = l_date   #當週最後一天工作天 
                     END IF
                     #2015/06/03 by stellar add ---- (E)
                  ELSE
                     LET l_molecular[l_i] = 0
                  END IF
               END FOR
   
               #將預測未沖銷數量依比率分給當週的每一個工作天
               LET l_remainder = 0
               LET l_week_totqty = 0   #2015/06/03 by stellar add
               FOR l_i = 1 TO l_cnt
                  #若該天分配比率=0，就不分配
                  IF l_molecular[l_i] = 0 THEN
                     CONTINUE FOR
                  END IF
               
                  CALL s_date_get_date(l_min_date,0,l_i)
                       RETURNING l_date
                  IF NOT s_date_chk_workday(g_site,l_ooef008,l_ooef009,l_date) THEN
                     CONTINUE FOR
                  END IF
   #               #小於起始日期，就不計算
   #               IF l_date < l_first_workdate THEN
   #                  CONTINUE FOR
   #               END IF
   #               #大於截止日期，就不計算
   #               IF l_date > l_last_workdate THEN
   #                  EXIT FOR
   #               END IF
                  
                  LET l_qty2 = l_qty1 * l_molecular[l_i]/l_denominator
                  IF l_qty2 <= l_carry THEN
                     LET l_qty2 = l_carry
                  ELSE
                     #160819-00013#1-s-mod
                     #CALL s_num_round('4',l_qty2/l_imae017,0)
                     #     RETURNING l_num1
                     #LET l_qty2 = l_num1 * l_imae017
                     CALL s_num_round('4',l_qty2/l_control_num,0)
                          RETURNING l_num1
                     LET l_qty2 = l_num1 * l_control_num
                     #160819-00013#1-e-mod
                  END IF
                 
                  LET l_week_totqty = l_week_totqty + l_qty2
                  IF l_week_totqty > l_qty1 THEN
                     #餘量
                     #2015/06/03 by stellar modify ----- (S)
#                     LET l_remainder = l_qty2
                     LET l_remainder = l_qty1 - (l_week_totqty - l_qty2)
                     IF l_remainder > 0 THEN   #160315-00001#1 by stellar add
                        IF l_remainder <= l_carry THEN
                           LET l_remainder = l_carry
                        ELSE
                           #160819-00013#1-s-mod
                           #CALL s_num_round('4',l_remainder/l_imae017,0)
                           #     RETURNING l_num1
                           #LET l_remainder = l_num1 * l_imae017
                           CALL s_num_round('4',l_remainder/l_control_num,0)
                                RETURNING l_num1
                           LET l_remainder = l_num1 * l_control_num
                           #160819-00013#1-e-mod
                        END IF
                        #2015/06/03 by stellar modify ----- (E)
                    END IF #160315-00001#1 by stellar add
                     EXIT FOR
                  ELSE
                     LET l_day_qty[l_i].date= l_date
                     LET l_day_qty[l_i].qty = l_qty2
                  END IF
               END FOR
            
               #餘量歸屬
               IF l_remainder > 0 THEN 
                  IF g_psba.psba023 = '1' THEN
                     #最後一天
                     #2015/06/03 by stellar modify ----- (S)
#                     LET l_day_qty[l_i+1].date = l_day_qty[l_i].date
#                     LET l_day_qty[l_i+1].qty = l_remainder
                     LET l_day_qty[l_i].date = l_week_lastday
                     LET l_day_qty[l_i].qty = l_remainder
                     #2015/06/03 by stellar modify ----- (E)
                  ELSE
                     #第一天
                     LET l_day_qty[1].qty = l_day_qty[1].qty+l_remainder
                  END IF
               END IF
               
               FOR l_i = 1 TO l_day_qty.getLength() 
                  IF cl_null(l_day_qty[l_i].date) THEN
                     CONTINUE FOR
                  END IF
                  CALL apsp400_forecast_ins_psbb(l_day_qty[l_i].date,l_day_qty[l_i].qty)
                       RETURNING r_success
                  IF NOT r_success THEN
                     EXIT FOR
                  END IF
               END FOR
               
               IF NOT r_success THEN
                  EXIT FOREACH
               END IF
               
               #訂單剩餘量
               LET l_order_remainder = 0
               IF l_qty = 0 THEN
                  EXIT FOREACH
               END IF
            ELSE
               #訂單剩餘量
               LET l_order_remainder = l_qty1 * (-1)
            END IF
         END FOREACH
   #2015/01/20 by stellar modify ----- (S)
#   END IF
      WHEN '3'
         #不分攤-以預測起始日為準
         CALL apsp400_forecast_ins_psbb(g_forecast.xmig011,l_qty)
              RETURNING r_success
      WHEN '4'
         #不分攤-以預測截止日為準
         CALL apsp400_forecast_ins_psbb(g_forecast.xmig012,l_qty)
              RETURNING r_success
   END CASE
   #2015/01/20 by stellar modify ----- (E)
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: Create銷售預測及訂單的Temp Table
# Memo...........:
# Usage..........: CALL apsp400_create_temptable()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/19 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_create_temptable()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE forecast_tmp
   CREATE TEMP TABLE forecast_tmp(
      xmig001        LIKE xmig_t.xmig001,
      xmig002        LIKE xmig_t.xmig002,
      xmig003        LIKE xmig_t.xmig003,
      xmig004        LIKE xmig_t.xmig004,
      xmig005        LIKE xmig_t.xmig005,
      xmig006        LIKE xmig_t.xmig006,
      xmig007        LIKE xmig_t.xmig007,
      xmig008        LIKE xmig_t.xmig008,
      xmig009        LIKE xmig_t.xmig009,
      xmig010        LIKE xmig_t.xmig010,
      xmig011        LIKE xmig_t.xmig011,
      xmig012        LIKE xmig_t.xmig012,
      quantity       LIKE xmig_t.xmig013,
      xmig017        LIKE xmig_t.xmig017,
      xmig018        LIKE xmig_t.xmig018)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create forecast_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE order_tmp
   CREATE TEMP TABLE order_tmp(
      xmdadocno      LIKE xmda_t.xmdadocno,
      xmda002        LIKE xmda_t.xmda002,
      xmda003        LIKE xmda_t.xmda003,
      xmda004        LIKE xmda_t.xmda004,
      xmda023        LIKE xmda_t.xmda023,
      xmddseq        LIKE xmdd_t.xmddseq,
      xmddseq1       LIKE xmdd_t.xmddseq1,
      xmddseq2       LIKE xmdd_t.xmddseq2,
      xmdd001        LIKE xmdd_t.xmdd001,
      xmdd002        LIKE xmdd_t.xmdd002,
      xmdd004        LIKE xmdd_t.xmdd004,
      quantity       LIKE xmdd_t.xmdd006,
      xmdd011        LIKE xmdd_t.xmdd011,
      xmdd013        LIKE xmdd_t.xmdd013, 
      xmdc021        LIKE xmdc_t.xmdc021)     #160530-00010#1 20160606 add by ming 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create order_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
      
   DROP TABLE sort_tmp
   CREATE TEMP TABLE sort_tmp(
      sort1          LIKE type_t.num5,
      psbbdocno      LIKE psbb_t.psbbdocno,
      psbbseq        LIKE psbb_t.psbbseq,
      psbbseq1       LIKE psbb_t.psbbseq1,
      psbbseq2       LIKE psbb_t.psbbseq2,
      psbb001        LIKE psbb_t.psbb001,
      psbb002        LIKE psbb_t.psbb002,
      psbb007        LIKE psbb_t.psbb007,
      psbb008        LIKE psbb_t.psbb008,
      oocq009        LIKE oocq_t.oocq009, 
      xmdc020        LIKE xmdc_t.xmdc020)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create sort_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 抓取MDS計算策略自定時距檔
# Memo...........:
# Usage..........: CALL apsp400_b_fill(p_psba001)
#                  
# Input parameter: p_psba001      MDS編號
#                : 
# Return code....:
#                : 
# Date & Author..: 2014/03/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_b_fill(p_psba001)
DEFINE p_psba001         LIKE psba_t.psba001

   DECLARE sel_psbe_cs CURSOR FOR
    SELECT psbe002,psbe003 FROM psbe_t
     WHERE psbeent = g_enterprise
       AND psbe001 = p_psba001
       
   CALL g_psbe.clear()
   
   LET l_ac = 1
   FOREACH sel_psbe_cs INTO g_psbe[l_ac].psbe002,g_psbe[l_ac].psbe003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET l_ac = l_ac - 1
   CALL g_psbe.deleteElement(g_psbe.getLength())
   
END FUNCTION
################################################################################
# Descriptions...: 需求預測寫入淨需求檔
# Memo...........:
# Usage..........: CALL apsp400_forecast_ins_psbb(p_psbb007,p_psbb006)
#                  RETURNING r_success
# Input parameter: p_psbb007      需求日期
#                : p_psbb006      需求數量
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/24 By stellar0130
# Modify.........: 160509-00009#11 2016/05/20 by ming psbb014從imaf034預設
################################################################################
PRIVATE FUNCTION apsp400_forecast_ins_psbb(p_psbb007,p_psbb006)
DEFINE p_psbb007         LIKE psbb_t.psbb007
DEFINE p_psbb006         LIKE psbb_t.psbb006
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psbb            RECORD LIKE psbb_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psbb RECORD  #MDS淨需求檔
       psbbent LIKE psbb_t.psbbent, #企業編號
       psbbsite LIKE psbb_t.psbbsite, #營運據點
       psbb001 LIKE psbb_t.psbb001, #MDS編號
       psbb002 LIKE psbb_t.psbb002, #單據類型
       psbbdocno LIKE psbb_t.psbbdocno, #單據編號
       psbbseq LIKE psbb_t.psbbseq, #項次
       psbbseq1 LIKE psbb_t.psbbseq1, #項序
       psbbseq2 LIKE psbb_t.psbbseq2, #分批序
       psbb003 LIKE psbb_t.psbb003, #料件編號
       psbb004 LIKE psbb_t.psbb004, #產品特徵
       psbb005 LIKE psbb_t.psbb005, #單位
       psbb006 LIKE psbb_t.psbb006, #需求數量
       psbb007 LIKE psbb_t.psbb007, #需求日期
       psbb008 LIKE psbb_t.psbb008, #客戶編號
       psbb009 LIKE psbb_t.psbb009, #業務員
       psbb010 LIKE psbb_t.psbb010, #銷售組織
       psbb011 LIKE psbb_t.psbb011, #通路
       psbb012 LIKE psbb_t.psbb012, #優先順序
       psbb013 LIKE psbb_t.psbb013, #嚴守交期
       #161109-00085#61 --s add 
       psbbud001 LIKE psbb_t.psbbud001, #自定義欄位(文字)001
       psbbud002 LIKE psbb_t.psbbud002, #自定義欄位(文字)002
       psbbud003 LIKE psbb_t.psbbud003, #自定義欄位(文字)003
       psbbud004 LIKE psbb_t.psbbud004, #自定義欄位(文字)004
       psbbud005 LIKE psbb_t.psbbud005, #自定義欄位(文字)005
       psbbud006 LIKE psbb_t.psbbud006, #自定義欄位(文字)006
       psbbud007 LIKE psbb_t.psbbud007, #自定義欄位(文字)007
       psbbud008 LIKE psbb_t.psbbud008, #自定義欄位(文字)008
       psbbud009 LIKE psbb_t.psbbud009, #自定義欄位(文字)009
       psbbud010 LIKE psbb_t.psbbud010, #自定義欄位(文字)010
       psbbud011 LIKE psbb_t.psbbud011, #自定義欄位(數字)011
       psbbud012 LIKE psbb_t.psbbud012, #自定義欄位(數字)012
       psbbud013 LIKE psbb_t.psbbud013, #自定義欄位(數字)013
       psbbud014 LIKE psbb_t.psbbud014, #自定義欄位(數字)014
       psbbud015 LIKE psbb_t.psbbud015, #自定義欄位(數字)015
       psbbud016 LIKE psbb_t.psbbud016, #自定義欄位(數字)016
       psbbud017 LIKE psbb_t.psbbud017, #自定義欄位(數字)017
       psbbud018 LIKE psbb_t.psbbud018, #自定義欄位(數字)018
       psbbud019 LIKE psbb_t.psbbud019, #自定義欄位(數字)019
       psbbud020 LIKE psbb_t.psbbud020, #自定義欄位(數字)020
       psbbud021 LIKE psbb_t.psbbud021, #自定義欄位(日期時間)021
       psbbud022 LIKE psbb_t.psbbud022, #自定義欄位(日期時間)022
       psbbud023 LIKE psbb_t.psbbud023, #自定義欄位(日期時間)023
       psbbud024 LIKE psbb_t.psbbud024, #自定義欄位(日期時間)024
       psbbud025 LIKE psbb_t.psbbud025, #自定義欄位(日期時間)025
       psbbud026 LIKE psbb_t.psbbud026, #自定義欄位(日期時間)026
       psbbud027 LIKE psbb_t.psbbud027, #自定義欄位(日期時間)027
       psbbud028 LIKE psbb_t.psbbud028, #自定義欄位(日期時間)028
       psbbud029 LIKE psbb_t.psbbud029, #自定義欄位(日期時間)029
       psbbud030 LIKE psbb_t.psbbud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psbb014 LIKE psbb_t.psbb014  #保稅否
END RECORD
#mod--161109-00085#16 By 08993--(e)

   LET r_success = TRUE
   
   INITIALIZE l_psbb.* TO NULL
   LET l_psbb.psbbdocno = 'FORCAST'
   LET l_psbb.psbb001 = g_psba.psba001
   SELECT MAX(psbbseq)+1 INTO l_psbb.psbbseq
     FROM psbb_t
    WHERE psbbent = g_enterprise
      AND psbbsite= g_site
      AND psbbdocno = l_psbb.psbbdocno
      AND psbb001 = l_psbb.psbb001
   IF cl_null(l_psbb.psbbseq) THEN
      LET l_psbb.psbbseq = 1
   END IF
   LET l_psbb.psbbseq1= 0
   LET l_psbb.psbbseq2= 0
   LET l_psbb.psbb002 = '2'
   LET l_psbb.psbb003 = g_forecast.xmig006
   LET l_psbb.psbb004 = g_forecast.xmig007
   LET l_psbb.psbb005 = g_forecast.xmig018
   LET l_psbb.psbb006 = p_psbb006
   LET l_psbb.psbb007 = p_psbb007
   LET l_psbb.psbb008 = g_forecast.xmig008
   LET l_psbb.psbb009 = g_forecast.xmig005
   LET l_psbb.psbb010 = g_forecast.xmig004
   LET l_psbb.psbb011 = g_forecast.xmig009
   LET l_psbb.psbb012 = ''
   LET l_psbb.psbb013 = 'N' 
   
   #160509-00009#11 20160520 add by ming -----(S) 
   SELECT imaf034 INTO l_psbb.psbb014 
     FROM imaf_t 
    WHERE imafent  = g_enterprise 
      AND imafsite = g_site 
      AND imaf001  = l_psbb.psbb003  
   IF cl_null(l_psbb.psbb014) THEN 
      LET l_psbb.psbb014 = 'N' 
   END IF 
   #160509-00009#11 20160520 add by ming -----(E) 
      
   #160509-00009#11 20160520 modify by ming -----(S) 
   #INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
   #                    psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
   #                    psbb008,psbb009,psbb010,psbb011,psbb012,psbb013)
   #   VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
   #           l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
   #           l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
   #           l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
   #           l_psbb.psbb012,l_psbb.psbb013)
   INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
                       psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
                       psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
      VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
              l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
              l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
              l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
              l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
   #160509-00009#11 20160520 modify by ming -----(E) 
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
      #160613-00024#1 20160626 modify -----(S) 
      #CALL cl_errmsg('ins psbb_t','','',SQLCA.sqlcode,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'ins psbb_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #160613-00024#1 20160626 modify -----(E) 
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 訂單寫入淨需求檔
# Memo...........:
# Usage..........: CALL apsp400_order_ins_psbb()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/20 By stellar0130
# Modify.........: 160509-00009#11 2016/05/20 by ming psbb014從imaf034預設
#                  160530-00010#1  2016/06/06 By ming psbb014的資料改由xmdc021而來
################################################################################
PRIVATE FUNCTION apsp400_order_ins_psbb()
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psbb            RECORD LIKE psbb_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psbb RECORD  #MDS淨需求檔
       psbbent LIKE psbb_t.psbbent, #企業編號
       psbbsite LIKE psbb_t.psbbsite, #營運據點
       psbb001 LIKE psbb_t.psbb001, #MDS編號
       psbb002 LIKE psbb_t.psbb002, #單據類型
       psbbdocno LIKE psbb_t.psbbdocno, #單據編號
       psbbseq LIKE psbb_t.psbbseq, #項次
       psbbseq1 LIKE psbb_t.psbbseq1, #項序
       psbbseq2 LIKE psbb_t.psbbseq2, #分批序
       psbb003 LIKE psbb_t.psbb003, #料件編號
       psbb004 LIKE psbb_t.psbb004, #產品特徵
       psbb005 LIKE psbb_t.psbb005, #單位
       psbb006 LIKE psbb_t.psbb006, #需求數量
       psbb007 LIKE psbb_t.psbb007, #需求日期
       psbb008 LIKE psbb_t.psbb008, #客戶編號
       psbb009 LIKE psbb_t.psbb009, #業務員
       psbb010 LIKE psbb_t.psbb010, #銷售組織
       psbb011 LIKE psbb_t.psbb011, #通路
       psbb012 LIKE psbb_t.psbb012, #優先順序
       psbb013 LIKE psbb_t.psbb013, #嚴守交期
       #161109-00085#61 --s add 
       psbbud001 LIKE psbb_t.psbbud001, #自定義欄位(文字)001
       psbbud002 LIKE psbb_t.psbbud002, #自定義欄位(文字)002
       psbbud003 LIKE psbb_t.psbbud003, #自定義欄位(文字)003
       psbbud004 LIKE psbb_t.psbbud004, #自定義欄位(文字)004
       psbbud005 LIKE psbb_t.psbbud005, #自定義欄位(文字)005
       psbbud006 LIKE psbb_t.psbbud006, #自定義欄位(文字)006
       psbbud007 LIKE psbb_t.psbbud007, #自定義欄位(文字)007
       psbbud008 LIKE psbb_t.psbbud008, #自定義欄位(文字)008
       psbbud009 LIKE psbb_t.psbbud009, #自定義欄位(文字)009
       psbbud010 LIKE psbb_t.psbbud010, #自定義欄位(文字)010
       psbbud011 LIKE psbb_t.psbbud011, #自定義欄位(數字)011
       psbbud012 LIKE psbb_t.psbbud012, #自定義欄位(數字)012
       psbbud013 LIKE psbb_t.psbbud013, #自定義欄位(數字)013
       psbbud014 LIKE psbb_t.psbbud014, #自定義欄位(數字)014
       psbbud015 LIKE psbb_t.psbbud015, #自定義欄位(數字)015
       psbbud016 LIKE psbb_t.psbbud016, #自定義欄位(數字)016
       psbbud017 LIKE psbb_t.psbbud017, #自定義欄位(數字)017
       psbbud018 LIKE psbb_t.psbbud018, #自定義欄位(數字)018
       psbbud019 LIKE psbb_t.psbbud019, #自定義欄位(數字)019
       psbbud020 LIKE psbb_t.psbbud020, #自定義欄位(數字)020
       psbbud021 LIKE psbb_t.psbbud021, #自定義欄位(日期時間)021
       psbbud022 LIKE psbb_t.psbbud022, #自定義欄位(日期時間)022
       psbbud023 LIKE psbb_t.psbbud023, #自定義欄位(日期時間)023
       psbbud024 LIKE psbb_t.psbbud024, #自定義欄位(日期時間)024
       psbbud025 LIKE psbb_t.psbbud025, #自定義欄位(日期時間)025
       psbbud026 LIKE psbb_t.psbbud026, #自定義欄位(日期時間)026
       psbbud027 LIKE psbb_t.psbbud027, #自定義欄位(日期時間)027
       psbbud028 LIKE psbb_t.psbbud028, #自定義欄位(日期時間)028
       psbbud029 LIKE psbb_t.psbbud029, #自定義欄位(日期時間)029
       psbbud030 LIKE psbb_t.psbbud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psbb014 LIKE psbb_t.psbb014  #保稅否
END RECORD
#mod--161109-00085#16 By 08993--(e)

   #160509-00009#11 20160520 add by ming -----(S)
   DEFINE l_sql          STRING 
   #160509-00009#11 20160520 add by ming -----(E)

   LET r_success = TRUE
   
   DECLARE order_cs1 CURSOR FOR
    #SELECT * FROM order_tmp #161109-00085#61 mark
    #161109-00085#61 --s add
    #161230-00073#1-s
    #SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023
    #       xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002
    SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023,
           xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,
    #161230-00073#1-e
           xmdd004,quantity,xmdd011,xmdd013,xmdc021 
      FROM order_tmp 
    #161109-00085#61 --e add
   #160530-00010#1 20160606 mark -----(S) 
   ##160509-00009#11 20160520 add by ming -----(S) 
   #LET l_sql = "SELECT imaf034 FROM imaf_t ", 
   #            " WHERE imafent  = '",g_enterprise,"' ",
   #            "   AND imafsite = '",g_site,"' ", 
   #            "   AND imaf001  = ? " 
   #PREPARE apsp400_order_ins_psbb_get_imaf034_prep FROM l_sql 
   ##160509-00009#11 20160520 add by ming -----(E) 
   #160530-00010#1 20160606 mark -----(E) 
  
   #FOREACH order_cs1 INTO g_order.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH order_cs1 INTO g_order.xmdadocno,g_order.xmda002,g_order.xmda003,g_order.xmda004,g_order.xmda023,
                          g_order.xmddseq,g_order.xmddseq1,g_order.xmddseq2,g_order.xmdd001,g_order.xmdd002,
                          g_order.xmdd004,g_order.quantity,g_order.xmdd011,g_order.xmdd013,g_order.xmdc021 
   #161109-00085#61 --e add
      INITIALIZE l_psbb.* TO NULL
      LET l_psbb.psbbdocno = g_order.xmdadocno
      LET l_psbb.psbbseq = g_order.xmddseq
      LET l_psbb.psbbseq1= g_order.xmddseq1
      LET l_psbb.psbbseq2= g_order.xmddseq2
      LET l_psbb.psbb001 = g_psba.psba001
      LET l_psbb.psbb002 = '1'
      LET l_psbb.psbb003 = g_order.xmdd001
      LET l_psbb.psbb004 = g_order.xmdd002
      LET l_psbb.psbb005 = g_order.xmdd004
      LET l_psbb.psbb006 = g_order.quantity
      LET l_psbb.psbb007 = g_order.xmdd011
      LET l_psbb.psbb008 = g_order.xmda004
      LET l_psbb.psbb009 = g_order.xmda002
      LET l_psbb.psbb010 = g_order.xmda003
      LET l_psbb.psbb011 = g_order.xmda023
      LET l_psbb.psbb012 = ''
      LET l_psbb.psbb013 = g_order.xmdd013 
      
      #160509-00009#11 20160520 add by ming -----(S) 
      #160530-00010#1 20160606 modify by ming -----(S) 
      #EXECUTE apsp400_order_ins_psbb_get_imaf034_prep USING l_psbb.psbb003 
      #                                                 INTO l_psbb.psbb014 
      LET l_psbb.psbb014 = g_order.xmdc021
      #160530-00010#1 20160606 modify by ming -----(E) 
      IF cl_null(l_psbb.psbb014) THEN 
         LET l_psbb.psbb014 = 'N' 
      END IF 
      #160509-00009#11 20160520 add by ming -----(E) 
      
      #160509-00009#11 20160520 add by ming -----(S) 
      #INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
      #                    psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
      #                    psbb008,psbb009,psbb010,psbb011,psbb012,psbb013)
      #   VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
      #           l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
      #           l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
      #           l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
      #           l_psbb.psbb012,l_psbb.psbb013)
      INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
                          psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
                          psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
         VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
                 l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
                 l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
                 l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
                 l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
      #160509-00009#11 20160520 add by ming -----(E) 
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg('ins psbb_t','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins psbb_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 獨立需求新增到淨需求檔
# Memo...........:
# Usage..........: CALL apsp400_independent_demand()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/25 By stellar0130
# Modify.........: 160509-00009#11 2016/05/20 by ming psbb014從imaf034預設
#                  160530-00010#1  2016/06/06 By ming psbb014改由psab013而來
################################################################################
PRIVATE FUNCTION apsp400_independent_demand()
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psbb            RECORD LIKE psbb_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psbb RECORD  #MDS淨需求檔
       psbbent LIKE psbb_t.psbbent, #企業編號
       psbbsite LIKE psbb_t.psbbsite, #營運據點
       psbb001 LIKE psbb_t.psbb001, #MDS編號
       psbb002 LIKE psbb_t.psbb002, #單據類型
       psbbdocno LIKE psbb_t.psbbdocno, #單據編號
       psbbseq LIKE psbb_t.psbbseq, #項次
       psbbseq1 LIKE psbb_t.psbbseq1, #項序
       psbbseq2 LIKE psbb_t.psbbseq2, #分批序
       psbb003 LIKE psbb_t.psbb003, #料件編號
       psbb004 LIKE psbb_t.psbb004, #產品特徵
       psbb005 LIKE psbb_t.psbb005, #單位
       psbb006 LIKE psbb_t.psbb006, #需求數量
       psbb007 LIKE psbb_t.psbb007, #需求日期
       psbb008 LIKE psbb_t.psbb008, #客戶編號
       psbb009 LIKE psbb_t.psbb009, #業務員
       psbb010 LIKE psbb_t.psbb010, #銷售組織
       psbb011 LIKE psbb_t.psbb011, #通路
       psbb012 LIKE psbb_t.psbb012, #優先順序
       psbb013 LIKE psbb_t.psbb013, #嚴守交期
       #161109-00085#61 --s add
       psbbud001 LIKE psbb_t.psbbud001, #自定義欄位(文字)001
       psbbud002 LIKE psbb_t.psbbud002, #自定義欄位(文字)002
       psbbud003 LIKE psbb_t.psbbud003, #自定義欄位(文字)003
       psbbud004 LIKE psbb_t.psbbud004, #自定義欄位(文字)004
       psbbud005 LIKE psbb_t.psbbud005, #自定義欄位(文字)005
       psbbud006 LIKE psbb_t.psbbud006, #自定義欄位(文字)006
       psbbud007 LIKE psbb_t.psbbud007, #自定義欄位(文字)007
       psbbud008 LIKE psbb_t.psbbud008, #自定義欄位(文字)008
       psbbud009 LIKE psbb_t.psbbud009, #自定義欄位(文字)009
       psbbud010 LIKE psbb_t.psbbud010, #自定義欄位(文字)010
       psbbud011 LIKE psbb_t.psbbud011, #自定義欄位(數字)011
       psbbud012 LIKE psbb_t.psbbud012, #自定義欄位(數字)012
       psbbud013 LIKE psbb_t.psbbud013, #自定義欄位(數字)013
       psbbud014 LIKE psbb_t.psbbud014, #自定義欄位(數字)014
       psbbud015 LIKE psbb_t.psbbud015, #自定義欄位(數字)015
       psbbud016 LIKE psbb_t.psbbud016, #自定義欄位(數字)016
       psbbud017 LIKE psbb_t.psbbud017, #自定義欄位(數字)017
       psbbud018 LIKE psbb_t.psbbud018, #自定義欄位(數字)018
       psbbud019 LIKE psbb_t.psbbud019, #自定義欄位(數字)019
       psbbud020 LIKE psbb_t.psbbud020, #自定義欄位(數字)020
       psbbud021 LIKE psbb_t.psbbud021, #自定義欄位(日期時間)021
       psbbud022 LIKE psbb_t.psbbud022, #自定義欄位(日期時間)022
       psbbud023 LIKE psbb_t.psbbud023, #自定義欄位(日期時間)023
       psbbud024 LIKE psbb_t.psbbud024, #自定義欄位(日期時間)024
       psbbud025 LIKE psbb_t.psbbud025, #自定義欄位(日期時間)025
       psbbud026 LIKE psbb_t.psbbud026, #自定義欄位(日期時間)026
       psbbud027 LIKE psbb_t.psbbud027, #自定義欄位(日期時間)027
       psbbud028 LIKE psbb_t.psbbud028, #自定義欄位(日期時間)028
       psbbud029 LIKE psbb_t.psbbud029, #自定義欄位(日期時間)029
       psbbud030 LIKE psbb_t.psbbud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psbb014 LIKE psbb_t.psbb014  #保稅否
END RECORD
#mod--161109-00085#16 By 08993--(e)
DEFINE l_psaadocno       LIKE psaa_t.psaadocno
DEFINE l_psabseq         LIKE psab_t.psabseq
DEFINE l_psab001         LIKE psab_t.psab001
DEFINE l_psab002         LIKE psab_t.psab002
DEFINE l_psab003         LIKE psab_t.psab003
DEFINE l_psab004         LIKE psab_t.psab004
DEFINE l_psab005         LIKE psab_t.psab005
DEFINE l_psab009         LIKE psab_t.psab009 
   #160509-00009#11 20160520 add by ming -----(S)
   DEFINE l_sql           STRING 
   #160509-00009#11 20160520 add by ming -----(E)
   #160530-00010#1 20160606 add by ming -----(S) 
   DEFINE l_psab013       LIKE psab_t.psab013
   #160530-00010#1 20160606 add by ming -----(E) 

   LET r_success = TRUE
   
   IF g_psba.psba005 = 'N' THEN
      RETURN r_success
   END IF
   
   DECLARE psab_cs CURSOR FOR
    #160530-00010#1 20160606 modify by ming -----(S) 
    #SELECT psaadocno,psabseq,psab001,psab002,psab003,psab004,(psab005-psab006),psab009
    SELECT psaadocno,psabseq,psab001,psab002,psab003,psab004,(psab005-psab006),psab009,
           psab013
    #160530-00010#1 20160606 modify by ming -----(E) 
      FROM psaa_t,psab_t
     WHERE psaaent = psabent
       AND psaadocno = psabdocno
       AND psaaent = g_enterprise
       AND psaasite= g_site
       AND psaastus = 'Y'
       AND psab008 = 'N'            #未結案
       AND (psab005 - psab006) > 0  #還有需求量 
       
   #160530-00010#1 20160606 mark by ming -----(S) 
   ##160509-00009#11 20160520 add by ming -----(S) 
   #LET l_sql = "SELECT imaf034 FROM imaf_t ", 
   #            " WHERE imafent  = '",g_enterprise,"' ",
   #            "   AND imafsite = '",g_site,"' ", 
   #            "   AND imaf001  = ? " 
   #PREPARE apsp400_id_get_imaf034_prep FROM l_sql 
   ##160509-00009#11 20160520 add by ming -----(E) 
   #160530-00010#1 20160606 mark by ming -----(E) 
  
   FOREACH psab_cs INTO l_psaadocno,l_psabseq,l_psab001,l_psab002,l_psab003,l_psab004,
                        #160530-00010#1 20160606 modify by ming -----(S) 
                        #l_psab005,l_psab009
                        l_psab005,l_psab009,l_psab013
                        #160530-00010#1 20160606 modify by ming -----(E) 
      INITIALIZE l_psbb.* TO NULL
      LET l_psbb.psbbdocno = l_psaadocno
      LET l_psbb.psbbseq = l_psabseq
      LET l_psbb.psbbseq1= 0
      LET l_psbb.psbbseq2= 0
      LET l_psbb.psbb001 = g_psba.psba001
      LET l_psbb.psbb002 = '3'
      LET l_psbb.psbb003 = l_psab001
      LET l_psbb.psbb004 = l_psab002
      #料件的基礎單位
      SELECT imaa006 INTO l_psbb.psbb005
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_psbb.psbb003
      
      #數量要轉換為料件基礎單位的數量
      CALL s_aooi250_convert_qty(l_psbb.psbb003,l_psab004,l_psbb.psbb005,l_psab005)
           RETURNING r_success,l_psbb.psbb006
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      LET l_psbb.psbb007 = l_psab003
      LET l_psbb.psbb008 = ''
      LET l_psbb.psbb009 = ''
      LET l_psbb.psbb010 = ''
      LET l_psbb.psbb011 = ''
      LET l_psbb.psbb012 = ''
      LET l_psbb.psbb013 = l_psab009 
      
      #160509-00009#11 20160520 add by ming -----(S) 
      #160530-00010#1 20160606 modify by ming -----(S) 
      #EXECUTE apsp400_id_get_imaf034_prep USING l_psbb.psbb003 
      #                                     INTO l_psbb.psbb014 
      LET l_psbb.psbb014 = l_psab013                                     
      #160530-00010#1 20160606 modify by ming -----(E) 
      IF cl_null(l_psbb.psbb014) THEN 
         LET l_psbb.psbb014 = 'N' 
      END IF 
      #160509-00009#11 20160520 add by ming -----(E) 
      
      #160509-00009#11 20160520 add by ming -----(S) 
      #INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
      #                    psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
      #                    psbb008,psbb009,psbb010,psbb011,psbb012,psbb013)
      #   VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
      #           l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
      #           l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
      #           l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
      #           l_psbb.psbb012,l_psbb.psbb013)
      INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
                          psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
                          psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
         VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
                 l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
                 l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
                 l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
                 l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
      #160509-00009#11 20160520 add by ming -----(E) 
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg('ins psbb_t','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins psbb_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 排列優先順序
# Memo...........:
# Usage..........: CALL apsp400_psbb_sort(p_base_date)
#                  RETURNING r_success
# Input parameter: p_base_date    計算基準日
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/24 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_psbb_sort(p_base_date)
DEFINE p_base_date       LIKE type_t.dat
DEFINE r_success         LIKE type_t.num5
DEFINE l_ooef008         LIKE ooef_t.ooef008
DEFINE l_ooef009         LIKE ooef_t.ooef009
DEFINE l_min_date        LIKE type_t.dat
DEFINE l_max_date        LIKE type_t.dat
DEFINE l_date            LIKE type_t.dat
DEFINE l_oogc008         LIKE oogc_t.oogc008
DEFINE l_oogc015         LIKE oogc_t.oogc015
DEFINE l_min             LIKE type_t.dat
DEFINE l_max             LIKE type_t.dat
DEFINE l_day             LIKE type_t.num5
DEFINE l_month           LIKE type_t.num5
DEFINE l_days            LIKE type_t.num5
DEFINE l_i               LIKE type_t.num5
DEFINE l_date_t          LIKE type_t.dat
DEFINE l_psbe003         LIKE psbe_t.psbe003
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_cnt1            LIKE type_t.num5

   LET r_success = TRUE
   LET g_psbb_sort = 0
   
   SELECT ooef008,ooef009 
     INTO l_ooef008,l_ooef009
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   SELECT MIN(psbb007),MAX(psbb007) INTO l_min_date,l_max_date
     FROM psbb_t
    WHERE psbbent = g_enterprise
      AND psbbsite= g_site
      AND psbb001 = g_psba.psba001
   LET l_day = l_max_date - l_min_date + 1
   
   CASE g_psba.psba016
      WHEN '1'   #週
           FOR l_i = 1 TO l_day+7 STEP 7
              CALL s_date_get_date(l_min_date,0,l_i)
                   RETURNING l_date
              #本日的週別
              SELECT oogc008,oogc015 INTO l_oogc008,l_oogc015
                FROM oogc_t
               WHERE oogcent = g_enterprise
                 AND oogc001 = l_ooef008
                 AND oogc002 = l_ooef009
                 AND oogc003 = l_date
              #本週的起始日、截止日
              SELECT MIN(oogc003),MAX(oogc003)
                INTO l_min,l_max
                FROM oogc_t
               WHERE oogcent = g_enterprise
                 AND oogc001 = l_ooef008
                 AND oogc002 = l_ooef009
                 AND oogc008 = l_oogc008
                 AND oogc015 = l_oogc015
              #依據本週的起始日、截止日排序
              CALL apsp400_psbb_sort1(l_min,l_max)
                   RETURNING r_success
              IF NOT r_success THEN
                 EXIT FOR
              END IF
           END FOR
      WHEN '2'   #旬
           FOR l_i = 1 TO l_day+10 STEP 10
              CALL s_date_get_date(l_min_date,0,l_i)
                   RETURNING l_date
              CASE 
                 WHEN DAY(l_date) <= 10
                      LET l_min = MDY(MONTH(l_date),1,YEAR(l_date))
                      LET l_max = MDY(MONTH(l_date),10,YEAR(l_date))
                 WHEN (DAY(l_date) > 10 AND DAY(l_date) <= 20)
                      LET l_min = MDY(MONTH(l_date),11,YEAR(l_date))
                      LET l_max = MDY(MONTH(l_date),20,YEAR(l_date))
                 WHEN (DAY(l_date) > 20)
                      LET l_min = MDY(MONTH(l_date),21,YEAR(l_date))
                      CALL s_date_get_max_day(YEAR(l_date),MONTH(l_date))
                           RETURNING l_days
                      LET l_max = MDY(MONTH(l_date),l_days,YEAR(l_date))
              END CASE
              #依據本旬的起始日、截止日排序
              CALL apsp400_psbb_sort1(l_min,l_max)
                   RETURNING r_success
              IF NOT r_success THEN
                 EXIT FOR
              END IF
           END FOR
      WHEN '3'   #月
           LET l_date = l_min_date
           FOR l_month = MONTH(l_min_date) TO MONTH(l_max_date)
              LET l_min = MDY(l_month,1,YEAR(l_date))
              CALL s_date_get_max_day(YEAR(l_date),MONTH(l_date))
                   RETURNING l_days
              LET l_max = MDY(l_month,l_days,YEAR(l_date))
              LET l_date= l_date + l_days
              
              #依據本月的起始日、截止日排序
              CALL apsp400_psbb_sort1(l_min,l_max)
                   RETURNING r_success
              IF NOT r_success THEN
                 EXIT FOR
              END IF
           END FOR
      WHEN '4'   #自訂
           #小於計算基準日的，則為同一時距
           IF l_min_date < p_base_date THEN
              #先抓第一筆資料是為週/旬/月
              DECLARE psbe_cs1 CURSOR FOR
               SELECT psbe003 FROM psbe_t
                WHERE psbeent = g_enterprise
                  AND psbe001 = g_psba.psba001
                ORDER BY psbe002
              FOREACH psbe_cs1 INTO l_psbe003
                 EXIT FOREACH
              END FOREACH
              
              CASE l_psbe003
                 WHEN '1'   #週
                      #本日的週別
                      SELECT oogc008,oogc015 INTO l_oogc008,l_oogc015
                        FROM oogc_t
                       WHERE oogcent = g_enterprise
                         AND oogc001 = l_ooef008
                         AND oogc002 = l_ooef009
                         AND oogc003 = p_base_date
                      #本週的起始日、截止日
                      SELECT MIN(oogc003),MAX(oogc003)
                        INTO l_min,l_max
                        FROM oogc_t
                       WHERE oogcent = g_enterprise
                         AND oogc001 = l_ooef008
                         AND oogc002 = l_ooef009
                         AND oogc008 = l_oogc008
                         AND oogc015 = l_oogc015
                 WHEN '2'   #旬
                      CASE
                         WHEN DAY(p_base_date) <= 10
                              LET l_min = MDY(MONTH(p_base_date),1,YEAR(p_base_date))
                         WHEN (DAY(p_base_date) > 10 AND DAY(p_base_date) <= 20) 
                              LET l_min = MDY(MONTH(p_base_date),11,YEAR(p_base_date))
                         WHEN DAY(p_base_date) > 20
                              LET l_min = MDY(MONTH(p_base_date),21,YEAR(p_base_date))
                      END CASE
                      
                 WHEN '3'   #月
                      LET l_min = MDY(MONTH(p_base_date),1,YEAR(p_base_date))
              END CASE
              IF l_min_date < l_min THEN
                 CALL apsp400_psbb_sort1(l_min_date,l_min-1)
                      RETURNING r_success
                 LET l_min_date = l_min
              END IF
           END IF
           
           IF NOT r_success THEN
              RETURN r_success
           END IF
           
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt 
             FROM psbe_t
            WHERE psbeent = g_enterprise
              AND psbe001 = g_psba.psba001
           IF cl_null(l_cnt) THEN
              LET l_cnt = 0
           END IF
           
           IF l_cnt > 0 THEN
              LET l_date_t = l_min_date
              DECLARE psbe_cs CURSOR FOR
               SELECT psbe003 FROM psbe_t
                WHERE psbeent = g_enterprise
                  AND psbe001 = g_psba.psba001
                ORDER BY psbe002
                      
              LET l_cnt1 = 1
              FOREACH psbe_cs INTO l_psbe003
                 LET l_date = l_date_t
                 CASE l_psbe003
                    WHEN '1'   #週
                         #本日的週別
                         SELECT oogc008,oogc015 INTO l_oogc008,l_oogc015
                           FROM oogc_t
                          WHERE oogcent = g_enterprise
                            AND oogc001 = l_ooef008
                            AND oogc002 = l_ooef009
                            AND oogc003 = l_date
                         #本週的起始日、截止日
                         SELECT MIN(oogc003),MAX(oogc003)
                           INTO l_min,l_max
                           FROM oogc_t
                          WHERE oogcent = g_enterprise
                            AND oogc001 = l_ooef008
                            AND oogc002 = l_ooef009
                            AND oogc008 = l_oogc008
                            AND oogc015 = l_oogc015
                   WHEN '2'   #旬
                        CASE 
                           WHEN DAY(l_date) <= 10
                                LET l_min = MDY(MONTH(l_date),1,YEAR(l_date))
                                LET l_max = MDY(MONTH(l_date),10,YEAR(l_date))
                           WHEN (DAY(l_date) > 10 AND DAY(l_date) <= 20)
                                LET l_min = MDY(MONTH(l_date),11,YEAR(l_date))
                                LET l_max = MDY(MONTH(l_date),20,YEAR(l_date))
                           WHEN (DAY(l_date) > 20)
                                LET l_min = MDY(MONTH(l_date),21,YEAR(l_date))
                                CALL s_date_get_max_day(YEAR(l_date),MONTH(l_date))
                                     RETURNING l_days
                                LET l_max = MDY(MONTH(l_date),l_days,YEAR(l_date))
                         END CASE
                    WHEN '3'   #月
                         LET l_min = l_date 
                         CALL s_date_get_max_day(YEAR(l_date),MONTH(l_date))
                              RETURNING l_days
                         LET l_max = MDY(MONTH(l_date),l_days,YEAR(l_date))
                 END CASE
              
                 #依據自訂的起始日、截止日排序
                 IF l_cnt1 < l_cnt THEN
                    CALL apsp400_psbb_sort1(l_min,l_max)
                         RETURNING r_success
                 ELSE
                    CALL apsp400_psbb_sort1(l_min,l_max_date)
                         RETURNING r_success
                 END IF
                 IF NOT r_success THEN
                    EXIT FOREACH
                 END IF
                 LET l_cnt1 = l_cnt1 + 1
                 LET l_date_t = l_max + 1
              END FOREACH
           ELSE
              #將超過時間的資料視為最後一個時距
              IF l_max < l_max_date THEN
                 CALL apsp400_psbb_sort1(l_min_date,l_max_date)
                      RETURNING r_success
              END IF
           END IF
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 由起始日到截止日，根據apsi001的需求滿足方式排序
# Memo...........:
# Usage..........: CALL apsp400_psbb_sort1(p_date1,p_date2)
#                  RETURNING r_success
# Input parameter: p_date1        起始日
#                : p_date2        截止日
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/03/25 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_psbb_sort1(p_date1,p_date2)
DEFINE p_date1           LIKE type_t.dat
DEFINE p_date2           LIKE type_t.dat
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_sort            STRING

   LET r_success = TRUE
   
   #抓取psbb_t資料新增到temp table
   DELETE FROM sort_tmp
   DECLARE psbb_cs CURSOR FOR
    SELECT 9,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb001,psbb002,
           psbb007,psbb008,'',''
      FROM psbb_t
     WHERE psbbent = g_enterprise
       AND psbbsite= g_site
       AND psbb001 = g_psba.psba001
       AND psbb007 BETWEEN p_date1 AND p_date2
   #FOREACH psbb_cs INTO g_sort.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH psbb_cs INTO g_sort.sort1,g_sort.psbbdocno,g_sort.psbbseq,g_sort.psbbseq1,g_sort.psbbseq2, 
                        g_sort.psbb001,g_sort.psbb002,g_sort.psbb007,g_sort.psbb008,g_sort.oocq009,  
                        g_sort.xmdc020
   #161109-00085#61 --e add
      #單據排序
      IF g_psba.psba013 = g_sort.psbb002 THEN
         LET g_sort.sort1 = 1
      END IF
      IF g_psba.psba014 = g_sort.psbb002 THEN
         LET g_sort.sort1 = 2
      END IF
      IF g_psba.psba015 = g_sort.psbb002 THEN
         LET g_sort.sort1 = 3
      END IF
     
      IF NOT cl_null(g_sort.psbb008) THEN
         SELECT oocq009 INTO g_sort.oocq009
           FROM pmaa_t,oocq_t
          WHERE pmaaent = oocqent
            AND oocq001 = '286'
            AND pmaa094 = oocq002
            AND pmaaent = g_enterprise
            AND pmaa001 = g_sort.psbb008
         IF cl_null(g_sort.oocq009) THEN
            LET g_sort.oocq009 = 'A'
         END IF
      ELSE
         LET g_sort.oocq009 = 'A'
      END IF
      
      #若單據類型非訂單的，則緊急度=1.一般
      IF g_sort.psbb002 = '1' THEN
         SELECT xmdc020 INTO g_sort.xmdc020
           FROM xmdc_t
          WHERE xmdcent = g_enterprise
            AND xmdcdocno = g_sort.psbbdocno
            AND xmdcseq = g_sort.psbbseq
         IF SQLCA.sqlcode THEN 
            #160613-00024#1 20160626 modify -----(S) 
            #CALL cl_errmsg("sel xmdc020",g_sort.psbbdocno||','||g_sort.psbbseq,"",SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'sel xmdc020 ',g_sort.psbbdocno,",",g_sort.psbbseq
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #160613-00024#1 20160626 modify -----(E) 
            LET r_success = FALSE
           EXIT FOREACH
         END IF
      ELSE
         LET g_sort.xmdc020 = '1'
      END IF
      
      #mod--161109-00085#16 By 08993--(s)      
#      INSERT INTO sort_tmp VALUES (g_sort.*)   #mark--161109-00085#16 By 08993--(s)
      INSERT INTO sort_tmp (sort1,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb001,psbb002,psbb007,psbb008,oocq009,xmdc020) 
                    VALUES (g_sort.sort1,g_sort.psbbdocno,g_sort.psbbseq,g_sort.psbbseq1,g_sort.psbbseq2,g_sort.psbb001,
                            g_sort.psbb002,g_sort.psbb007,g_sort.psbb008,g_sort.oocq009,g_sort.xmdc020)
      #mod--161109-00085#16 By 08993--(e)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("ins sort","","",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins sort'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET l_sort = ""
   CASE g_psba.psba017
      WHEN '1' 
           LET l_sort = "xmdc020"
      WHEN '2'
           LET l_sort = "psbb007"
      WHEN '3' 
           LET l_sort = "oocq009"
   END CASE
   
   CASE g_psba.psba018
      WHEN '1' 
           LET l_sort = l_sort,",xmdc020"
      WHEN '2'
           LET l_sort = l_sort,",psbb007"
      WHEN '3' 
           LET l_sort = l_sort,",oocq009"
   END CASE
   
   CASE g_psba.psba019
      WHEN '1' 
           LET l_sort = l_sort,",xmdc020"
      WHEN '2'
           LET l_sort = l_sort,",psbb007"
      WHEN '3' 
           LET l_sort = l_sort,",oocq009"
   END CASE
   
   
   #LET l_sql = "SELECT * FROM sort_tmp " #161109-00085#61 mark
   #161109-00085#61 --s add
   LET l_sql = "SELECT sort1,psbbdocno,psbbseq,psbbseq1,psbbseq2, ",
               "       psbb001,psbb002,psbb007,psbb008,oocq009,  ",
               "       xmdc020 FROM sort_tmp "
   #161109-00085#61 --e add
   IF g_psba.psba006 = '1' THEN
      LET l_sql = l_sql CLIPPED," ORDER BY sort1,",l_sort CLIPPED
   ELSE
      LET l_sql = l_sql CLIPPED," ORDER BY ",l_sort CLIPPED,",sort1"
   END IF
   
   PREPARE sort_tmp_pre FROM l_sql
   DECLARE sort_tmp_cs CURSOR FOR sort_tmp_pre
   
   #FOREACH sort_tmp_cs INTO g_sort.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH sort_tmp_cs INTO g_sort.sort1,g_sort.psbbdocno,g_sort.psbbseq,g_sort.psbbseq1,g_sort.psbbseq2, 
                            g_sort.psbb001,g_sort.psbb002,g_sort.psbb007,g_sort.psbb008,g_sort.oocq009,  
                            g_sort.xmdc020
   #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN 
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("FOREACH sort_tmp_cs","","",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH sort_tmp_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   
      LET g_psbb_sort = g_psbb_sort + 10
      UPDATE psbb_t SET psbb012 = g_psbb_sort
       WHERE psbbent = g_enterprise
         AND psbbsite= g_site
         AND psbbdocno = g_sort.psbbdocno
         AND psbbseq = g_sort.psbbseq
         AND psbbseq1= g_sort.psbbseq1
         AND psbbseq2= g_sort.psbbseq2
         AND psbb001 = g_sort.psbb001
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         #160613-00024#1 20160626 modify -----(S) 
         #CALL cl_errmsg("upd psbb_t","","",SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd psbb_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #160613-00024#1 20160626 modify -----(E) 
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 以訂單為主
# Memo...........:
# Usage..........: CALL apsp400_for_order_main()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2016/07/06 By ming
# Modify.........: 160912-00040#1 by dorislai 訂單與預測沖銷方式的調整
#                :                架構：1.先讓訂單寫完資料 
#                :                      2.抓取各預測期間，再判斷各期期間中是否有訂單資料，沒的話，再抓取銷售預測資料
################################################################################
PRIVATE FUNCTION apsp400_for_order_main()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_date        LIKE xmig_t.xmig011  
   DEFINE l_success     LIKE type_t.num5
   #mod--161109-00085#16 By 08993--(s)
   #DEFINE l_psbb            RECORD LIKE psbb_t.*   #mark--161109-00085#16 By 08993--(s)
   DEFINE l_psbb RECORD  #MDS淨需求檔
          psbbent LIKE psbb_t.psbbent, #企業編號
          psbbsite LIKE psbb_t.psbbsite, #營運據點
          psbb001 LIKE psbb_t.psbb001, #MDS編號
          psbb002 LIKE psbb_t.psbb002, #單據類型
          psbbdocno LIKE psbb_t.psbbdocno, #單據編號
          psbbseq LIKE psbb_t.psbbseq, #項次
          psbbseq1 LIKE psbb_t.psbbseq1, #項序
          psbbseq2 LIKE psbb_t.psbbseq2, #分批序
          psbb003 LIKE psbb_t.psbb003, #料件編號
          psbb004 LIKE psbb_t.psbb004, #產品特徵
          psbb005 LIKE psbb_t.psbb005, #單位
          psbb006 LIKE psbb_t.psbb006, #需求數量
          psbb007 LIKE psbb_t.psbb007, #需求日期
          psbb008 LIKE psbb_t.psbb008, #客戶編號
          psbb009 LIKE psbb_t.psbb009, #業務員
          psbb010 LIKE psbb_t.psbb010, #銷售組織
          psbb011 LIKE psbb_t.psbb011, #通路
          psbb012 LIKE psbb_t.psbb012, #優先順序
          psbb013 LIKE psbb_t.psbb013, #嚴守交期
          #161109-00085#61 --s add
          psbbud001 LIKE psbb_t.psbbud001, #自定義欄位(文字)001
          psbbud002 LIKE psbb_t.psbbud002, #自定義欄位(文字)002
          psbbud003 LIKE psbb_t.psbbud003, #自定義欄位(文字)003
          psbbud004 LIKE psbb_t.psbbud004, #自定義欄位(文字)004
          psbbud005 LIKE psbb_t.psbbud005, #自定義欄位(文字)005
          psbbud006 LIKE psbb_t.psbbud006, #自定義欄位(文字)006
          psbbud007 LIKE psbb_t.psbbud007, #自定義欄位(文字)007
          psbbud008 LIKE psbb_t.psbbud008, #自定義欄位(文字)008
          psbbud009 LIKE psbb_t.psbbud009, #自定義欄位(文字)009
          psbbud010 LIKE psbb_t.psbbud010, #自定義欄位(文字)010
          psbbud011 LIKE psbb_t.psbbud011, #自定義欄位(數字)011
          psbbud012 LIKE psbb_t.psbbud012, #自定義欄位(數字)012
          psbbud013 LIKE psbb_t.psbbud013, #自定義欄位(數字)013
          psbbud014 LIKE psbb_t.psbbud014, #自定義欄位(數字)014
          psbbud015 LIKE psbb_t.psbbud015, #自定義欄位(數字)015
          psbbud016 LIKE psbb_t.psbbud016, #自定義欄位(數字)016
          psbbud017 LIKE psbb_t.psbbud017, #自定義欄位(數字)017
          psbbud018 LIKE psbb_t.psbbud018, #自定義欄位(數字)018
          psbbud019 LIKE psbb_t.psbbud019, #自定義欄位(數字)019
          psbbud020 LIKE psbb_t.psbbud020, #自定義欄位(數字)020
          psbbud021 LIKE psbb_t.psbbud021, #自定義欄位(日期時間)021
          psbbud022 LIKE psbb_t.psbbud022, #自定義欄位(日期時間)022
          psbbud023 LIKE psbb_t.psbbud023, #自定義欄位(日期時間)023
          psbbud024 LIKE psbb_t.psbbud024, #自定義欄位(日期時間)024
          psbbud025 LIKE psbb_t.psbbud025, #自定義欄位(日期時間)025
          psbbud026 LIKE psbb_t.psbbud026, #自定義欄位(日期時間)026
          psbbud027 LIKE psbb_t.psbbud027, #自定義欄位(日期時間)027
          psbbud028 LIKE psbb_t.psbbud028, #自定義欄位(日期時間)028
          psbbud029 LIKE psbb_t.psbbud029, #自定義欄位(日期時間)029
          psbbud030 LIKE psbb_t.psbbud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          psbb014 LIKE psbb_t.psbb014  #保稅否
   END RECORD
   #mod--161109-00085#16 By 08993--(e) 
   DEFINE l_cnt         LIKE type_t.num10
   #160912-00040#1-s-add
   DEFINE l_sql1        STRING               
   DEFINE l_bdate       LIKE xmic_t.xmic002  
   DEFINE l_edate       LIKE xmic_t.xmic002  
   DEFINE l_xmib003     LIKE xmib_t.xmib003
   #160912-00040#1-e-add
   
   LET r_success = TRUE
   
   #160912-00040#1-s-mark
#   LET l_sql = "SELECT xmdd011 ",
#               "  FROM order_tmp ",
#               " UNION ",
#               "SELECT xmig011 ",
#               "  FROM forecast_tmp "
#   PREPARE apsp400_order_main_union_date_prep FROM l_sql
#   DECLARE apsp400_order_main_union_date_curs CURSOR FOR apsp400_order_main_union_date_prep
#
#   LET l_sql = "SELECT * ",
#               "  FROM order_tmp ",
#               " WHERE xmdd011 = ? "
#   PREPARE apsp400_order_main_get_order_prep FROM l_sql
#   DECLARE apsp400_order_main_get_order_curs CURSOR FOR apsp400_order_main_get_order_prep
#
#   LET l_sql = "SELECT * ",
#               "  FROM forecast_tmp ",
#               " WHERE xmig011 = ? "
#   PREPARE apsp400_order_main_get_forecast_prep FROM l_sql
#   DECLARE apsp400_order_main_get_forecast_curs CURSOR FOR apsp400_order_main_get_forecast_prep 
#   
#   FOREACH apsp400_order_main_union_date_curs INTO l_date
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'foreach:'
#         LET g_errparam.code   = SQLCA.sqlcode
#         LET g_errparam.popup  = TRUE
#         CALL cl_err()
#
#         LET r_success = FALSE
#         EXIT FOREACH
#      END IF
#
#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt
#        FROM order_tmp
#       WHERE xmdd011 = l_date
#      IF l_cnt > 0 THEN
#         #以訂單為主，因此有訂單的資料時，就先拿訂單的，找不到時才找預測的 
#         FOREACH apsp400_order_main_get_order_curs USING l_date
#                                                    INTO g_order.*
#            INITIALIZE l_psbb.* TO NULL
#            LET l_psbb.psbbdocno = g_order.xmdadocno
#            LET l_psbb.psbbseq   = g_order.xmddseq
#            LET l_psbb.psbbseq1  = g_order.xmddseq1
#            LET l_psbb.psbbseq2  = g_order.xmddseq2
#            LET l_psbb.psbb001   = g_psba.psba001
#            LET l_psbb.psbb002   = '1'
#            LET l_psbb.psbb003   = g_order.xmdd001
#            LET l_psbb.psbb004   = g_order.xmdd002 
#            LET l_psbb.psbb005   = g_order.xmdd004
#            LET l_psbb.psbb006   = g_order.quantity
#            LET l_psbb.psbb007   = g_order.xmdd011
#            LET l_psbb.psbb008   = g_order.xmda004
#            LET l_psbb.psbb009   = g_order.xmda002
#            LET l_psbb.psbb010   = g_order.xmda003
#            LET l_psbb.psbb011   = g_order.xmda023
#            LET l_psbb.psbb012   = ''
#            LET l_psbb.psbb013   = g_order.xmdd013
#            LET l_psbb.psbb014   = g_order.xmdc021
#            IF cl_null(l_psbb.psbb014) THEN
#               LET l_psbb.psbb014 = 'N'
#            END IF
#
#            INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
#                                psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
#                                psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
#               VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
#                       l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
#                       l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
#                       l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
#                       l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
#            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = 'ins psbb_t'
#               LET g_errparam.code   = SQLCA.sqlcode
#               LET g_errparam.popup  = TRUE
#               CALL cl_err()
#               LET r_success = FALSE 
#               EXIT FOREACH
#            END IF
#         END FOREACH
#      ELSE
#         LET l_success = TRUE
#         FOREACH apsp400_order_main_get_forecast_curs USING l_date
#                                                       INTO g_forecast.*
#            CALL apsp400_apportion(g_forecast.quantity,0)
#                 RETURNING l_success
#            IF NOT l_success THEN
#               LET r_success = FALSE
#            END IF
#         END FOREACH
#      END IF
#
#   END FOREACH
   #160912-00040#1-e-mark
   
   #160912-00040#1-s-add
   #取得起始日期
   LET l_bdate = ''
   SELECT MAX(a.xmic002) INTO l_bdate FROM xmic_t a
    WHERE a.xmicent = g_enterprise
      AND a.xmic004 = g_site
      AND a.xmic001 = g_psba.psba007
      AND a.xmic002 = (SELECT MAX(b.xmic002) FROM xmic_t b
                        WHERE b.xmicent = g_enterprise
                          AND b.xmic004 = g_site
                          AND b.xmic001 = g_psba.psba007)
      AND a.xmic003 = (SELECT MAX(c.xmic003) FROM xmic_t c
                        WHERE c.xmicent = g_enterprise
                          AND c.xmic004 = g_site
                          AND c.xmic001 = g_psba.psba007
                          AND c.xmic002 = a.xmic002)
   #取得預測日期
   LET l_sql = "SELECT xmib003 FROM xmib_t ",
               " WHERE xmibent = '",g_enterprise,"'",
               "   AND xmib001 = '",g_psba.psba007,"'"
   PREPARE apsp400_order_get_xmib_prep FROM l_sql
   DECLARE apsp400_order_get_xmib_curs CURSOR FOR apsp400_order_get_xmib_prep
   
   #取得訂單資料                       
   LET l_sql = "SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023,xmddseq,xmddseq1,xmddseq2,xmdd001,",
               "       xmdd002,xmdd004,quantity,xmdd011,xmdd013,xmdc021  ",
               "  FROM order_tmp "
   PREPARE apsp400_order_main_get_order_prep FROM l_sql
   DECLARE apsp400_order_main_get_order_curs CURSOR FOR apsp400_order_main_get_order_prep
   
   #取得銷售預測資料
   LET l_sql = "SELECT xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009,xmig010,",
               "       xmig011,xmig012,quantity,xmig017,xmig018 ",
               "  FROM forecast_tmp ",
               " WHERE xmig011 BETWEEN ? AND ? "
   PREPARE apsp400_order_main_get_forecast_prep FROM l_sql
   DECLARE apsp400_order_main_get_forecast_curs CURSOR FOR apsp400_order_main_get_forecast_prep 
   
   #先寫入訂單資料
   FOREACH apsp400_order_main_get_order_curs INTO g_order.xmdadocno,g_order.xmda002,g_order.xmda003,g_order.xmda004,g_order.xmda023,
                                                  g_order.xmddseq,g_order.xmddseq1,g_order.xmddseq2,g_order.xmdd001,g_order.xmdd002,
                                                  g_order.xmdd004,g_order.quantity,g_order.xmdd011,g_order.xmdd013,g_order.xmdc021 
           
      INITIALIZE l_psbb.* TO NULL
      LET l_psbb.psbbdocno = g_order.xmdadocno
      LET l_psbb.psbbseq   = g_order.xmddseq
      LET l_psbb.psbbseq1  = g_order.xmddseq1
      LET l_psbb.psbbseq2  = g_order.xmddseq2
      LET l_psbb.psbb001   = g_psba.psba001
      LET l_psbb.psbb002   = '1'
      LET l_psbb.psbb003   = g_order.xmdd001
      LET l_psbb.psbb004   = g_order.xmdd002 
      LET l_psbb.psbb005   = g_order.xmdd004
      LET l_psbb.psbb006   = g_order.quantity
      LET l_psbb.psbb007   = g_order.xmdd011
      LET l_psbb.psbb008   = g_order.xmda004
      LET l_psbb.psbb009   = g_order.xmda002
      LET l_psbb.psbb010   = g_order.xmda003
      LET l_psbb.psbb011   = g_order.xmda023
      LET l_psbb.psbb012   = ''
      LET l_psbb.psbb013   = g_order.xmdd013
      LET l_psbb.psbb014   = g_order.xmdc021
      IF cl_null(l_psbb.psbb014) THEN
         LET l_psbb.psbb014 = 'N'
      END IF
  
      INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
                          psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
                          psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
         VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
                 l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
                 l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
                 l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011,
                 l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins psbb_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE 
         EXIT FOREACH
      END IF
   END FOREACH
   
   #若無起始日期(axmt171)，就不需往下做抓取日期的部分
   IF cl_null(l_bdate) THEN
      RETURN r_success
   END IF 
   
   #若預測期間，沒有訂單資料，則抓取銷售預測資料
   LET l_xmib003 = ''
   FOREACH apsp400_order_get_xmib_curs INTO l_xmib003
      #以起始日期，取得截止日期
      CALL apsp400_get_edate(l_xmib003,l_bdate) RETURNING l_edate
      
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM order_tmp
       WHERE xmdd011 BETWEEN l_bdate AND l_edate
       
      IF l_cnt = 0 THEN
         LET l_success = TRUE
         FOREACH apsp400_order_main_get_forecast_curs USING l_bdate,l_edate
                                                      INTO g_forecast.xmig001,g_forecast.xmig002,g_forecast.xmig003,g_forecast.xmig004,g_forecast.xmig005,
                                                           g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,g_forecast.xmig010,
                                                           g_forecast.xmig011,g_forecast.xmig012,g_forecast.quantity,g_forecast.xmig017,g_forecast.xmig018
            CALL apsp400_apportion(g_forecast.quantity,0)
                 RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF
         END FOREACH
      END IF
      
      LET l_bdate = l_edate + 1
   END FOREACH
   #160912-00040#1-e-add
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 以預測為主 
# Memo...........:
# Usage..........: CALL apsp400_for_forecast_main()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2016/07/06 By ming
# Modify.........: 160912-00040#1 by dorislai 訂單與預測沖銷方式的調整
#                :                架構：1.先讓銷售預測寫完資料 
#                :                      2.抓取各預測期間，再判斷各期期間中是否有銷售預測資料，沒的話，再抓取訂單資料
################################################################################
PRIVATE FUNCTION apsp400_for_forecast_main()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_date        LIKE xmig_t.xmig011
   DEFINE l_success     LIKE type_t.num5
   #mod--161109-00085#16 By 08993--(s)
   #DEFINE l_psbb            RECORD LIKE psbb_t.*   #mark--161109-00085#16 By 08993--(s)
   DEFINE l_psbb RECORD  #MDS淨需求檔
          psbbent LIKE psbb_t.psbbent, #企業編號
          psbbsite LIKE psbb_t.psbbsite, #營運據點
          psbb001 LIKE psbb_t.psbb001, #MDS編號
          psbb002 LIKE psbb_t.psbb002, #單據類型
          psbbdocno LIKE psbb_t.psbbdocno, #單據編號
          psbbseq LIKE psbb_t.psbbseq, #項次
          psbbseq1 LIKE psbb_t.psbbseq1, #項序
          psbbseq2 LIKE psbb_t.psbbseq2, #分批序
          psbb003 LIKE psbb_t.psbb003, #料件編號
          psbb004 LIKE psbb_t.psbb004, #產品特徵
          psbb005 LIKE psbb_t.psbb005, #單位
          psbb006 LIKE psbb_t.psbb006, #需求數量
          psbb007 LIKE psbb_t.psbb007, #需求日期
          psbb008 LIKE psbb_t.psbb008, #客戶編號
          psbb009 LIKE psbb_t.psbb009, #業務員
          psbb010 LIKE psbb_t.psbb010, #銷售組織
          psbb011 LIKE psbb_t.psbb011, #通路
          psbb012 LIKE psbb_t.psbb012, #優先順序
          psbb013 LIKE psbb_t.psbb013, #嚴守交期
          #161109-00085#61 --s add
          psbbud001 LIKE psbb_t.psbbud001, #自定義欄位(文字)001
          psbbud002 LIKE psbb_t.psbbud002, #自定義欄位(文字)002
          psbbud003 LIKE psbb_t.psbbud003, #自定義欄位(文字)003
          psbbud004 LIKE psbb_t.psbbud004, #自定義欄位(文字)004
          psbbud005 LIKE psbb_t.psbbud005, #自定義欄位(文字)005
          psbbud006 LIKE psbb_t.psbbud006, #自定義欄位(文字)006
          psbbud007 LIKE psbb_t.psbbud007, #自定義欄位(文字)007
          psbbud008 LIKE psbb_t.psbbud008, #自定義欄位(文字)008
          psbbud009 LIKE psbb_t.psbbud009, #自定義欄位(文字)009
          psbbud010 LIKE psbb_t.psbbud010, #自定義欄位(文字)010
          psbbud011 LIKE psbb_t.psbbud011, #自定義欄位(數字)011
          psbbud012 LIKE psbb_t.psbbud012, #自定義欄位(數字)012
          psbbud013 LIKE psbb_t.psbbud013, #自定義欄位(數字)013
          psbbud014 LIKE psbb_t.psbbud014, #自定義欄位(數字)014
          psbbud015 LIKE psbb_t.psbbud015, #自定義欄位(數字)015
          psbbud016 LIKE psbb_t.psbbud016, #自定義欄位(數字)016
          psbbud017 LIKE psbb_t.psbbud017, #自定義欄位(數字)017
          psbbud018 LIKE psbb_t.psbbud018, #自定義欄位(數字)018
          psbbud019 LIKE psbb_t.psbbud019, #自定義欄位(數字)019
          psbbud020 LIKE psbb_t.psbbud020, #自定義欄位(數字)020
          psbbud021 LIKE psbb_t.psbbud021, #自定義欄位(日期時間)021
          psbbud022 LIKE psbb_t.psbbud022, #自定義欄位(日期時間)022
          psbbud023 LIKE psbb_t.psbbud023, #自定義欄位(日期時間)023
          psbbud024 LIKE psbb_t.psbbud024, #自定義欄位(日期時間)024
          psbbud025 LIKE psbb_t.psbbud025, #自定義欄位(日期時間)025
          psbbud026 LIKE psbb_t.psbbud026, #自定義欄位(日期時間)026
          psbbud027 LIKE psbb_t.psbbud027, #自定義欄位(日期時間)027
          psbbud028 LIKE psbb_t.psbbud028, #自定義欄位(日期時間)028
          psbbud029 LIKE psbb_t.psbbud029, #自定義欄位(日期時間)029
          psbbud030 LIKE psbb_t.psbbud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          psbb014 LIKE psbb_t.psbb014  #保稅否
   END RECORD
   #mod--161109-00085#16 By 08993--(e)  
   DEFINE l_cnt         LIKE type_t.num10
   #160912-00040#1-s-add
   DEFINE l_sql1        STRING               
   DEFINE l_bdate       LIKE xmic_t.xmic002  
   DEFINE l_edate       LIKE xmic_t.xmic002  
   DEFINE l_xmib003     LIKE xmib_t.xmib003
   #160912-00040#1-e-add
   
   LET r_success = TRUE
   
   #160912-00040#1-s-mark
#   LET l_sql = "SELECT xmdd011 ",
#               "  FROM order_tmp ",
#               " UNION ",
#               "SELECT xmig011 ",
#               "  FROM forecast_tmp "
#   PREPARE apsp400_forecast_main_union_date_prep FROM  l_sql
#   DECLARE apsp400_forecast_main_union_date_curs CURSOR FOR apsp400_forecast_main_union_date_prep
#
#   LET l_sql = "SELECT * ",
#               "  FROM order_tmp ",
#               " WHERE xmdd011 = ? "
#   PREPARE apsp400_forecast_main_get_order_prep FROM l_sql
#   DECLARE apsp400_forecast_main_get_order_curs CURSOR FOR apsp400_forecast_main_union_date_prep
#
#   LET l_sql = "SELECT * ",
#               "  FROM forecast_tmp ",
#               " WHERE xmig011 = ? "
#   PREPARE apsp400_forecast_main_get_forecast_prep FROM l_sql
#   DECLARE apsp400_forecast_main_get_forecast_curs CURSOR FOR apsp400_forecast_main_get_forecast_prep 
#   
#   FOREACH apsp400_forecast_main_union_date_curs INTO l_date
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'foreach:'
#         LET g_errparam.code   = SQLCA.sqlcode
#         LET g_errparam.popup  = TRUE
#         CALL cl_err()
#
#         LET r_success = FALSE
#         EXIT FOREACH
#      END IF
#
#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt
#        FROM forecast_tmp
#       WHERE xmig011 = l_date
#      IF l_cnt > 0 THEN
#         LET l_success = TRUE
#         FOREACH apsp400_forecast_main_get_forecast_curs USING l_date
#                                                          INTO g_forecast.*
#            CALL apsp400_apportion(g_forecast.quantity,0)
#                 RETURNING l_success
#            IF NOT l_success THEN
#               LET r_success = FALSE
#            END IF
#         END FOREACH
#      ELSE
#         FOREACH apsp400_forecast_main_get_order_curs USING l_date
#                                                       INTO g_order.*
#            INITIALIZE l_psbb.* TO NULL 
#            LET l_psbb.psbbdocno = g_order.xmdadocno
#            LET l_psbb.psbbseq   = g_order.xmddseq
#            LET l_psbb.psbbseq1  = g_order.xmddseq1
#            LET l_psbb.psbbseq2  = g_order.xmddseq2
#            LET l_psbb.psbb001   = g_psba.psba001
#            LET l_psbb.psbb002   = '1'
#            LET l_psbb.psbb003   = g_order.xmdd001
#            LET l_psbb.psbb004   = g_order.xmdd002
#            LET l_psbb.psbb005   = g_order.xmdd004
#            LET l_psbb.psbb006   = g_order.quantity
#            LET l_psbb.psbb007   = g_order.xmdd011
#            LET l_psbb.psbb008   = g_order.xmda004
#            LET l_psbb.psbb009   = g_order.xmda002
#            LET l_psbb.psbb010   = g_order.xmda003
#            LET l_psbb.psbb011   = g_order.xmda023
#            LET l_psbb.psbb012   = ''
#            LET l_psbb.psbb013   = g_order.xmdd013
#            LET l_psbb.psbb014   = g_order.xmdc021
#            IF cl_null(l_psbb.psbb014) THEN
#               LET l_psbb.psbb014 = 'N'
#            END IF
#
#            INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
#                                psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
#                                psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
#               VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
#                       l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
#                       l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
#                       l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011, 
#                       l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
#            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = 'ins psbb_t'
#               LET g_errparam.code   = SQLCA.sqlcode
#               LET g_errparam.popup  = TRUE
#               CALL cl_err()
#
#               LET r_success = FALSE
#               EXIT FOREACH
#            END IF
#         END FOREACH
#      END IF
#
#   END FOREACH
   #160912-00040#1-e-mark
   
   #160912-00040#1-s-add
   #取得起始日期
   LET l_bdate = ''
   SELECT MAX(a.xmic002) INTO l_bdate FROM xmic_t a
    WHERE a.xmicent = g_enterprise
      AND a.xmic004 = g_site
      AND a.xmic001 = g_psba.psba007
      AND a.xmic002 = (SELECT MAX(b.xmic002) FROM xmic_t b
                        WHERE b.xmicent = g_enterprise
                          AND b.xmic004 = g_site
                          AND b.xmic001 = g_psba.psba007)
      AND a.xmic003 = (SELECT MAX(c.xmic003) FROM xmic_t c
                        WHERE c.xmicent = g_enterprise
                          AND c.xmic004 = g_site
                          AND c.xmic001 = g_psba.psba007
                          AND c.xmic002 = a.xmic002)
   #取得預測日期
   LET l_sql = "SELECT xmib003 FROM xmib_t ",
               " WHERE xmibent = '",g_enterprise,"'",
               "   AND xmib001 = '",g_psba.psba007,"'"
   PREPARE apsp400_forecast_get_xmib_prep FROM l_sql
   DECLARE apsp400_forecast_get_xmib_curs CURSOR FOR apsp400_forecast_get_xmib_prep
   
   #取得訂單資料                       
   LET l_sql = "SELECT xmdadocno,xmda002,xmda003,xmda004,xmda023,xmddseq,xmddseq1,xmddseq2,xmdd001,",
               "       xmdd002,xmdd004,quantity,xmdd011,xmdd013,xmdc021  ",
               "  FROM order_tmp ",
               " WHERE xmdd011 BETWEEN ? AND ? "
   PREPARE apsp400_forecast_main_get_order_prep FROM l_sql
   DECLARE apsp400_forecast_main_get_order_curs CURSOR FOR apsp400_forecast_main_get_order_prep
   
   #取得銷售預測資料
   LET l_sql = "SELECT xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009,xmig010,",
               "       xmig011,xmig012,quantity,xmig017,xmig018 ",
               "  FROM forecast_tmp "
   PREPARE apsp400_forecast_main_get_forecast_prep FROM l_sql
   DECLARE apsp400_forecast_main_get_forecast_curs CURSOR FOR apsp400_forecast_main_get_forecast_prep 
   
   #先寫入銷售預測資料
   FOREACH apsp400_forecast_main_get_forecast_curs INTO g_forecast.xmig001,g_forecast.xmig002,g_forecast.xmig003,g_forecast.xmig004,g_forecast.xmig005,
                                                     g_forecast.xmig006,g_forecast.xmig007,g_forecast.xmig008,g_forecast.xmig009,g_forecast.xmig010,
                                                     g_forecast.xmig011,g_forecast.xmig012,g_forecast.quantity,g_forecast.xmig017,g_forecast.xmig018
      LET l_success = TRUE
      CALL apsp400_apportion(g_forecast.quantity,0)
           RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH
   
   #若無起始日期(axmt171)，就不需往下做抓取日期的部分
   IF cl_null(l_bdate) THEN
      RETURN r_success
   END IF 
   
   #若預測期間，沒有銷售預測資料，則抓取訂單資料
   LET l_xmib003 = ''
   FOREACH apsp400_forecast_get_xmib_curs INTO l_xmib003
      #以起始日期，取得截止日期
      CALL apsp400_get_edate(l_xmib003,l_bdate) RETURNING l_edate
      
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM forecast_tmp
       WHERE quantity > 0
         AND xmig011 BETWEEN l_bdate AND l_edate
       
      IF l_cnt = 0 THEN
         LET l_success = TRUE
         FOREACH apsp400_forecast_main_get_order_curs USING l_bdate,l_edate
                                                      INTO g_order.xmdadocno,g_order.xmda002,g_order.xmda003,g_order.xmda004,g_order.xmda023,
                                                           g_order.xmddseq,g_order.xmddseq1,g_order.xmddseq2,g_order.xmdd001,g_order.xmdd002,
                                                           g_order.xmdd004,g_order.quantity,g_order.xmdd011,g_order.xmdd013,g_order.xmdc021 
            INITIALIZE l_psbb.* TO NULL 
            LET l_psbb.psbbdocno = g_order.xmdadocno
            LET l_psbb.psbbseq   = g_order.xmddseq
            LET l_psbb.psbbseq1  = g_order.xmddseq1
            LET l_psbb.psbbseq2  = g_order.xmddseq2
            LET l_psbb.psbb001   = g_psba.psba001
            LET l_psbb.psbb002   = '1'
            LET l_psbb.psbb003   = g_order.xmdd001
            LET l_psbb.psbb004   = g_order.xmdd002
            LET l_psbb.psbb005   = g_order.xmdd004
            LET l_psbb.psbb006   = g_order.quantity
            LET l_psbb.psbb007   = g_order.xmdd011
            LET l_psbb.psbb008   = g_order.xmda004
            LET l_psbb.psbb009   = g_order.xmda002
            LET l_psbb.psbb010   = g_order.xmda003
            LET l_psbb.psbb011   = g_order.xmda023
            LET l_psbb.psbb012   = ''
            LET l_psbb.psbb013   = g_order.xmdd013
            LET l_psbb.psbb014   = g_order.xmdc021
            IF cl_null(l_psbb.psbb014) THEN
               LET l_psbb.psbb014 = 'N'
            END IF

            INSERT INTO psbb_t (psbbent,psbbsite,psbbdocno,psbbseq,psbbseq1,psbbseq2,
                                psbb001,psbb002,psbb003,psbb004,psbb005,psbb006,psbb007,
                                psbb008,psbb009,psbb010,psbb011,psbb012,psbb013,psbb014)
               VALUES (g_enterprise,g_site,l_psbb.psbbdocno,l_psbb.psbbseq,l_psbb.psbbseq1,
                       l_psbb.psbbseq2,l_psbb.psbb001,l_psbb.psbb002,l_psbb.psbb003,
                       l_psbb.psbb004,l_psbb.psbb005,l_psbb.psbb006,l_psbb.psbb007,
                       l_psbb.psbb008,l_psbb.psbb009,l_psbb.psbb010,l_psbb.psbb011, 
                       l_psbb.psbb012,l_psbb.psbb013,l_psbb.psbb014)
            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins psbb_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      
      LET l_bdate = l_edate + 1
   END FOREACH
   #160912-00040#1-e-add
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 取得截止日期
# Memo...........:
# Usage..........: CALL apsp400_get_edate(p_xmib003,p_bdate)
#                  RETURNING r_edate
# Input parameter: p_xmib003      預測週期
#                : p_bdate        起始日期
# Return code....: r_edate        截止日期
# Date & Author..: 2016/10/17 By dorislai (160912-00040#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp400_get_edate(p_xmib003,p_bdate)
   DEFINE l_year        LIKE type_t.num10
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_day         LIKE type_t.num5
   DEFINE p_xmib003     LIKE xmib_t.xmib003
   DEFINE p_bdate       LIKE xmic_t.xmic002  
   DEFINE r_edate       LIKE xmic_t.xmic002  
   
   LET r_edate = ''
   
   CASE p_xmib003
      WHEN '0'   #日
         LET r_edate = p_bdate
      WHEN '1'   #週(7天）
         LET r_edate = p_bdate + 6
      WHEN '2'   #旬(10天)
         LET r_edate = p_bdate + 9
      WHEN '3'   #月
         LET l_year  = YEAR(p_bdate)
         LET l_month = MONTH(p_bdate)
         LET l_day   = DAY(p_bdate)
         IF l_month MOD 12 = 0 THEN
           LET l_year = l_year + 1
           LET l_month = 1
         ELSE
           LET l_month = l_month + 1
         END IF
         LET r_edate = MDY(l_month,l_day,l_year) - 1
   END CASE
   
   RETURN r_edate
   
END FUNCTION

#end add-point
 
{</section>}
 
