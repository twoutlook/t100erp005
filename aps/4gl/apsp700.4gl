#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2017-01-24 14:11:24), PR版次:0010(2017-01-24 14:39:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000080
#+ Filename...: apsp700
#+ Description: APS訂單需求轉單作業
#+ Creator....: 04441(2014-10-16 11:35:45)
#+ Modifier...: 06978 -SD/PR- 06978
 
{</section>}
 
{<section id="apsp700.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151209-00022#7  15/12/18  by Sarah  增加二次篩選功能
#160316-00016#9  16/03/24  by dorislai 增加單位的檢查
#160318-00025#50 16/04/27  By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息 
#160608-00013#2  16/06/20  By ming     psph007=pspa006  調整為  psph010=pspa006 
#160608-00013#3  16/06/21  By ming     執行process時，先檢查有無新版本，有的話，跳出錯誤訊息「該APS版本：%1已有新一版本資料，請重新查詢後再進行處理」 
#160714-00026#1  16/09/20  By dorislai 1.修改master_type_0。 (1)拿掉psph010 = psph009的條件 (2)psph040改抓psph017
#                                      2.因為來源訂單串到所有相關的單據，mark apsp700_browser_expand()  3.g_psoq002(執行日期時間)改抓 MAX(pspa002)
#161024-00057#17 16/10/26  By Whitney  刪除apsp700_sfae_ins()及sfae_t相關程式
#161109-00085#17 16/11/15  By 08993    整批調整系統星號寫法
#170120-00041#1  17/01/24  By ywtsai   修改單身日期改取供給時間(psph031)
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

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
    psoq001         LIKE psoq_t.psoq001,         #APS版本
    psoq001_desc    LIKE type_t.chr80,           #說明
    pmdadocno       LIKE pmda_t.pmdadocno,       #請購單別
    pmdadocno_desc  LIKE type_t.chr80,           #說明
    sfaadocno       LIKE sfaa_t.sfaadocno,       #工單單別
    sfaadocno_desc  LIKE type_t.chr80,           #說明
    
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
    sel                LIKE type_t.chr1,
    psoq004            LIKE psoq_t.psoq004,      #訂單編號
    psoq043            LIKE psoq_t.psoq043,      #料件編號
    psoq043_desc       LIKE type_t.chr80,        #品名
    psoq043_desc_desc  LIKE type_t.chr80,        #規格
    psoq044            LIKE psoq_t.psoq044,      #產品特徵
    psoq044_desc       LIKE type_t.chr80,        #說明
    psoq022            LIKE psoq_t.psoq022,      #數量
    psoq032            LIKE psoq_t.psoq032,      #單位
    psoq032_desc       LIKE type_t.chr80,        #說明
    psoq007            LIKE psoq_t.psoq007,      #約定交貨日
    psoq024            LIKE psoq_t.psoq024       #預計完工日
                   END RECORD
DEFINE g_browser  DYNAMIC ARRAY OF RECORD        #資料瀏覽之欄位
    b_show             LIKE type_t.chr100,       #外顯欄位
    b_pid              LIKE type_t.chr100,       #父節點id
    b_id               LIKE type_t.chr100,       #本身節點id
    b_exp              LIKE type_t.chr100,       #是否展開
    b_hasC             LIKE type_t.num5,         #是否有子節點
    b_isExp            LIKE type_t.num5,         #是否已展開
    #tree自定義欄位
    psph016            LIKE psph_t.psph016,      #類型
    chk                LIKE type_t.chr1,         #選擇
    psph040            LIKE psph_t.psph040,      #料件編號
    psph040_desc       LIKE type_t.chr80,        #品名
    psph040_desc_desc  LIKE type_t.chr80,        #規格
    psph020            LIKE psph_t.psph020,      #數量
    pspc014            LIKE pspc_t.pspc014,      #單位
    pspc014_desc       LIKE type_t.chr80,        #說明
    #psph019            LIKE psph_t.psph019,      #日期        #170120-00041#1 mark
    psph031            LIKE psph_t.psph031,      #日期         #170120-00041#1 add
    pspc054            LIKE pspc_t.pspc054       #已轉單
                   END RECORD
DEFINE g_param         type_parameter
DEFINE g_detail_idx    LIKE type_t.num5
DEFINE g_detail2_idx   LIKE type_t.num5
DEFINE g_detail2_cnt   LIKE type_t.num5
DEFINE g_ooef004       LIKE ooef_t.ooef004
DEFINE g_psoq002       LIKE psoq_t.psoq002
DEFINE g_psos055       LIKE psos_t.psos055
#mod--161109-00085#17 By 08993--(s)
#DEFINE g_sfaa   RECORD LIKE sfaa_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE g_sfaa   RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
          END RECORD 
#mod--161109-00085#17 By 08993--(e)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp700.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
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
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp700 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp700_init()   
 
      #進入選單 Menu (="N")
      CALL apsp700_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp700
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apsp700_tmp

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp700.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp700_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_psph016','4027')
   LET g_detail_idx = 1
   LET g_detail2_idx = 1
   
   CREATE TEMP TABLE apsp700_tmp(
       sfaadocno  LIKE sfaa_t.sfaadocno)

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp700.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp700_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.num5
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_detail2_cnt = g_browser.getLength()
   LET g_ooef004 = ''
   SELECT ooef004 INTO g_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_site

   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsp700_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_param.wc ON psoq004,psoq007,psoq024,psoq043
	   
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD psoq004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_psoq004()
               DISPLAY g_qryparam.return1 TO psoq004
               NEXT FIELD psoq004

            ON ACTION controlp INFIELD psoq043
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO psoq043
               NEXT FIELD psoq043

         END CONSTRUCT

         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_param.psoq001
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
         
            AFTER FIELD psoq001
               LET g_param.psoq001_desc = ''
               DISPLAY g_param.psoq001_desc TO psoq001_desc
               IF cl_null(g_param.psoq001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00052'
                  LET g_errparam.extend = g_param.psoq001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_param.psoq001
                  LET g_errshow = TRUE   #160318-00025#50
                  LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"    #160318-00025#50
                  IF NOT cl_chk_exist("v_psca001") THEN
                     CALL apsp700_psoq001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL apsp700_psoq001_ref()
            
            ON ACTION controlp INFIELD psoq001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.psoq001
               CALL q_psca001()
               LET g_param.psoq001 = g_qryparam.return1
               DISPLAY g_param.psoq001 TO psoq001
               CALL apsp700_psoq001_ref()
               NEXT FIELD psoq001

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT
         
         INPUT BY NAME g_param.pmdadocno,g_param.sfaadocno
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT

            AFTER FIELD pmdadocno
               LET g_param.pmdadocno_desc = ''
               DISPLAY g_param.pmdadocno_desc TO pmdadocno_desc
               IF NOT cl_null(g_param.pmdadocno) THEN 
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用
                  CALL s_control_chk_doc('1',g_param.pmdadocno,'3',g_user,g_dept,'','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     CALL s_aooi200_get_slip_desc(g_param.pmdadocno) RETURNING g_param.pmdadocno_desc
                     DISPLAY g_param.pmdadocno_desc TO pmdadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_param.pmdadocno,'apmt400') THEN
                     CALL s_aooi200_get_slip_desc(g_param.pmdadocno) RETURNING g_param.pmdadocno_desc
                     DISPLAY g_param.pmdadocno_desc TO pmdadocno_desc
                     NEXT FIELD CURRENT   
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_param.pmdadocno) RETURNING g_param.pmdadocno_desc
               DISPLAY g_param.pmdadocno_desc TO pmdadocno_desc

            AFTER FIELD sfaadocno
               LET g_param.sfaadocno_desc = ''
               DISPLAY g_param.sfaadocno_desc TO sfaadocno_desc
               IF NOT cl_null(g_param.sfaadocno) THEN 
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用
                  CALL s_control_chk_doc('1',g_param.sfaadocno,'3',g_user,g_dept,'','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     CALL s_aooi200_get_slip_desc(g_param.sfaadocno) RETURNING g_param.sfaadocno_desc
                     DISPLAY g_param.sfaadocno_desc TO sfaadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_param.sfaadocno,'asft300') THEN
                     CALL s_aooi200_get_slip_desc(g_param.sfaadocno) RETURNING g_param.sfaadocno_desc
                     DISPLAY g_param.sfaadocno_desc TO sfaadocno_desc
                     NEXT FIELD CURRENT   
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_param.sfaadocno) RETURNING g_param.sfaadocno_desc
               DISPLAY g_param.sfaadocno_desc TO sfaadocno_desc

            ON ACTION controlp INFIELD pmdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.pmdadocno
               LET g_qryparam.arg1 = g_ooef004
               LET g_qryparam.arg2 = 'apmt400'
               CALL q_ooba002_1()
               LET g_param.pmdadocno = g_qryparam.return1
               DISPLAY g_param.pmdadocno TO pmdadocno
               CALL s_aooi200_get_slip_desc(g_param.pmdadocno) RETURNING g_param.pmdadocno_desc
               DISPLAY g_param.pmdadocno_desc TO pmdadocno_desc
               NEXT FIELD pmdadocno

            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.sfaadocno
               LET g_qryparam.arg1 = g_ooef004
               LET g_qryparam.arg2 = 'asft300'
               CALL q_ooba002_1()
               LET g_param.sfaadocno = g_qryparam.return1
               DISPLAY g_param.sfaadocno TO sfaadocno
               CALL s_aooi200_get_slip_desc(g_param.sfaadocno) RETURNING g_param.sfaadocno_desc
               DISPLAY g_param.sfaadocno_desc TO sfaadocno_desc
               NEXT FIELD sfaadocno

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT

         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt)
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail")
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               CALL apsp700_fetch()
               
         END DISPLAY

         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_detail2_cnt)
         
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_browse") 
               
            BEFORE DISPLAY
               LET g_detail2_idx = DIALOG.getCurrentRow("s_browse")

#            ON EXPAND (g_detail2_idx)
#               #樹展開
#               CALL apsp700_browser_expand()
#               LET g_browser[g_detail2_idx].b_isExp = 1
            
            ON ACTION doubleClick
               IF (g_browser[g_detail2_idx].pspc054 = "N" OR
                   g_browser[g_detail2_idx].pspc054 IS NULL) AND 
                  (g_browser[g_detail2_idx].psph016 = "NP" OR
                   g_browser[g_detail2_idx].psph016 = "NM") THEN
                  IF g_browser[g_detail2_idx].chk = "Y" THEN
                     LET g_browser[g_detail2_idx].chk = "N"
                  ELSE
                     #160316-00016#9-mod-(S)
#                     LET g_browser[g_detail2_idx].chk = "Y"
                     IF cl_null(g_browser[g_detail2_idx].pspc014) THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code = 'aps-00176'  #單據編號：%1、料号：%2的單位不可空白，請檢查料件基本資料維護作業！若單位有重新設定，請重新執行APS或APS手調器，重新產出資料！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_browser[g_detail2_idx].b_show    #單據編號
                        LET g_errparam.replace[2] = g_browser[g_detail2_idx].psph040    #料號
                        LET g_browser[g_detail2_idx].chk = "N"
                        CALL cl_err()
                     ELSE
                        LET g_browser[g_detail2_idx].chk = "Y"
                     END IF
                     #160316-00016#9-mod-(E)
                     
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_browser[g_detail2_idx].b_show
                  LET g_errparam.code   = 'aps-00126'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
            
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_browser.getLength()
               IF (g_browser[g_detail2_idx].pspc054 = "N" OR
                   g_browser[g_detail2_idx].pspc054 IS NULL) AND 
                  (g_browser[li_idx].psph016 = "NP" OR
                   g_browser[li_idx].psph016 = "NM") THEN
                  LET g_browser[li_idx].chk = "Y"
               END IF
            END FOR

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            FOR li_idx = 1 TO g_browser.getLength()
               IF g_browser[li_idx].chk = "Y" THEN
                  LET g_browser[li_idx].chk = "N"
               END IF
            END FOR

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_browser.getLength()
               IF DIALOG.isRowSelected("s_browse", li_idx) THEN
                  IF (g_browser[g_detail2_idx].pspc054 = "N" OR
                      g_browser[g_detail2_idx].pspc054 IS NULL) AND 
                     (g_browser[li_idx].psph016 = "NP" OR
                      g_browser[li_idx].psph016 = "NM") THEN
                     LET g_browser[li_idx].chk = "Y"
                  END IF
               END IF
            END FOR

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_browser.getLength()
               IF DIALOG.isRowSelected("s_browse", li_idx) THEN
                  IF g_browser[li_idx].chk = "Y" THEN
                     LET g_browser[li_idx].chk = "N"
                  END IF
               END IF
            END FOR

            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apsp700_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL apsp700_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
           #151209-00022#7 add -----(S)
            LET g_wc_filter = '1=1'
            CALL apsp700_b_fill()
           #151209-00022#7 add -----(E)
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp700_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"

         ON ACTION batch_execute
            IF cl_null(g_param.pmdadocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00603'
               LET g_errparam.extend = 'pmdadocno'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD pmdadocno
            END IF
            IF cl_null(g_param.sfaadocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00603'
               LET g_errparam.extend = 'sfaadocno'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD sfaadocno
            END IF
            LET l_flag = 0
            FOR li_idx = 1 TO g_browser.getLength()
               IF g_browser[li_idx].chk = "Y" THEN
                  LET l_flag = 1
                  IF g_browser[li_idx].psph016 = "NP" THEN
                     LET l_flag = 2
                     EXIT FOR
                  END IF
               END IF
            END FOR
            IF l_flag = 0 THEN
               CALL cl_ask_pressanykey('-400')
            ELSE
               CALL apmp700_process(l_flag)
            END IF
            CONTINUE DIALOG

         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp700.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp700_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_param.psoq001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00102'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL apsp700_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp700.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp700_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   IF cl_null(g_param.wc) THEN
      LET g_param.wc = " 1=1"
   END IF

  #151209-00022#7 add -----(S)
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
  #151209-00022#7 add -----(E)
  
   #用APS版本抓最新的執行日期時間
   LET g_psoq002 = ''
   #160714-00026#1-s-mod 
   #SELECT MAX(psoq002) INTO g_psoq002 FROM psoq_t
   # WHERE psoqent = g_enterprise AND psoqsite= g_site
   #   AND psoq001 = g_param.psoq001
   SELECT MAX(pspa002) INTO g_psoq002 FROM pspa_t
    WHERE pspaent = g_enterprise AND pspasite= g_site
      AND pspa001 = g_param.psoq001
   #160714-00026#1-e-mod
   
   LET g_sql = " SELECT 'N',psoq004,psoq043,imaal003,imaal004,psoq044,'', ",
               "        psoq022,psoq032,oocal003,psoq007,psoq024 ",
               "   FROM psoq_t ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = psoqent AND imaal001 = psoq043 AND imaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN oocal_t ON oocalent = psoqent AND oocal001 = psoq032 AND oocal002 = '",g_dlang,"'",
               "  WHERE psoqent = ? ",
               "    AND psoqsite='",g_site,"'",
               "    AND psoq001 ='",g_param.psoq001,"'",
               "    AND psoq002 ='",g_psoq002,"'",
               "    AND ",g_param.wc CLIPPED,
               "   AND ",g_wc_filter CLIPPED   #151209-00022#4 add               
   LET g_sql = g_sql CLIPPED," ORDER BY psoq004,psoq043 "
   #end add-point
 
   PREPARE apsp700_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp700_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].psoq004,g_detail_d[l_ac].psoq043,
      g_detail_d[l_ac].psoq043_desc,g_detail_d[l_ac].psoq043_desc_desc,g_detail_d[l_ac].psoq044,
      g_detail_d[l_ac].psoq044_desc,g_detail_d[l_ac].psoq022,g_detail_d[l_ac].psoq032,
      g_detail_d[l_ac].psoq032_desc,g_detail_d[l_ac].psoq007,g_detail_d[l_ac].psoq024
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
 
      #end add-point
      
      CALL apsp700_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apsp700_sel
   
   LET l_ac = 1
   CALL apsp700_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp700.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp700_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_n             LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #160714-00026#1-s-mod  1.psph040改為psph017  2.makr「AND psph010 = psph009」
   #LET g_sql = " SELECT UNIQUE psph010,psph016,'N',psph040,imaal003,imaal004,psph020,'','',psph019,'' ",
   #            "   FROM psph_t ",
   #            "   LEFT OUTER JOIN imaal_t ON imaalent = psphent AND imaal001 = psph040 AND imaal002 = '",g_dlang,"'",
   #            "  WHERE psphent = '",g_enterprise,"' ",
   #            "    AND psphsite = '",g_site,"' ",
   #            "    AND psph001 = '",g_param.psoq001,"' ",
   #            "    AND psph002 = '",g_psoq002,"' ",
   #            "    AND psph009 = '",g_detail_d[g_detail_idx].psoq004,"' ",
   #            "    AND psph016 IN ('M','I','P','NM','NP') ",
   #            #160608-00013#2 20160620 modify by ming -----(S) 
   #            #"    AND psph007 = psph009 ",
   #            "    AND psph010 = psph009 ",
   #            #160608-00013#2 20160620 modify by ming -----(E) 
   #            "  ORDER BY psph016,psph040 "
   #LET g_sql = " SELECT UNIQUE psph010,psph016,'N',psph017,imaal003,imaal004,psph020,'','',psph019,'' ",              #170120-00041#1 mark
   LET g_sql = " SELECT UNIQUE psph010,psph016,'N',psph017,imaal003,imaal004,psph020,'','',psph031,'' ",               #170120-00041#1 add
               "   FROM psph_t ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = psphent AND imaal001 = psph017 AND imaal002 = '",g_dlang,"'",
               "  WHERE psphent = '",g_enterprise,"' ",
               "    AND psphsite = '",g_site,"' ",
               "    AND psph001 = '",g_param.psoq001,"' ",
               "    AND psph002 = '",g_psoq002,"' ",
               "    AND psph009 = '",g_detail_d[g_detail_idx].psoq004,"' ",
               "    AND psph016 IN ('M','I','P','NM','NP') ",
               ##160608-00013#2 20160620 modify by ming -----(S) 
               ##"    AND psph007 = psph009 ",
               #"    AND psph010 = psph009 ",
               ##160608-00013#2 20160620 modify by ming -----(E) 
               "  ORDER BY psph016,psph017 "
   #160714-00026#1-e-mod
   PREPARE master_type_0 FROM g_sql
   DECLARE master_typecur_0 CURSOR WITH HOLD FOR master_type_0

   #LET g_sql = " SELECT UNIQUE psph010,psph016,'N',psph040,imaal003,imaal004,psph020,'','',psph019,'' ",              #170120-00041#1 mark
   LET g_sql = " SELECT UNIQUE psph010,psph016,'N',psph040,imaal003,imaal004,psph020,'','',psph031,'' ",               #170120-00041#1 add
               "   FROM psph_t ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = psphent AND imaal001 = psph040 AND imaal002 = '",g_dlang,"'",
               "  WHERE psphent = '",g_enterprise,"' ",
               "    AND psphsite = '",g_site,"' ",
               "    AND psph001 = '",g_param.psoq001,"' ",
               "    AND psph002 = '",g_psoq002,"' ",
               "    AND psph009 = '",g_detail_d[g_detail_idx].psoq004,"' ",
               "    AND psph016 IN ('M','I','P','NM','NP') ",
               #160608-00013#2 20160620 modify by ming -----(S) 
               #"    AND psph007 = ? ",
               "    AND psph010 = ? ",
               #160608-00013#2 20160620 modify by ming -----(E) 
               "  ORDER BY psph016,psph040 "
   PREPARE master_type_1 FROM g_sql
   DECLARE master_typecur_1 CURSOR WITH HOLD FOR master_type_1

   LET g_sql = " SELECT COUNT(psph010) ",
                "   FROM psph_t ",
                "  WHERE psphent = '",g_enterprise,"' ",
                "    AND psphsite = '",g_site,"' ",
                "    AND psph001 = '",g_param.psoq001,"' ",
                "    AND psph002 = '",g_psoq002,"' ",
                #160608-00013#2 20160620 modify by ming -----(S) 
                #"    AND psph007 = ? ",
                "    AND psph010 = ? ",
                #160608-00013#2 20160620 modify by ming -----(E) 
                "    AND psph009 = '",g_detail_d[g_detail_idx].psoq004,"' ",
                "    AND psph016 IN ('M','I','P','NM','NP') ",
                "  ORDER BY psph016,psph040 "
   PREPARE master_type_2 FROM g_sql
   
   CALL g_browser.clear()
   LET l_ac = 1

   FOREACH master_typecur_0 INTO g_browser[l_ac].b_show,
                                 g_browser[l_ac].psph016,g_browser[l_ac].chk,
                                 g_browser[l_ac].psph040,g_browser[l_ac].psph040_desc,
                                 g_browser[l_ac].psph040_desc_desc,g_browser[l_ac].psph020,
                                 g_browser[l_ac].pspc014,g_browser[l_ac].pspc014_desc,
                                 #g_browser[l_ac].psph019,g_browser[l_ac].pspc054              #170120-00041#1 mark
                                 g_browser[l_ac].psph031,g_browser[l_ac].pspc054               #170120-00041#1 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL apsp700_fetch_detail(g_browser[l_ac].b_show,g_browser[l_ac].psph016,g_browser[l_ac].psph040)
           RETURNING g_browser[l_ac].pspc014,g_browser[l_ac].pspc054
      LET g_browser[l_ac].b_pid   = '0' CLIPPED
      LET g_browser[l_ac].b_id    = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp   = TRUE
      LET g_browser[l_ac].b_isExp = TRUE
      #160714-00026#1-s-mark 最上階的訂單，就會帶出所有單據了，故這段可以mark
      #LET l_n = 0
      #EXECUTE master_type_2 USING g_browser[l_ac].b_show INTO l_n
      #IF cl_null(l_n) OR l_n = 0 THEN
      #   LET g_browser[l_ac].b_hasC = FALSE
      #ELSE
      #   LET g_browser[l_ac].b_hasC = TRUE
      #   CALL apsp700_browser_expand(l_ac)
      #   LET l_ac = g_browser.getLength()
      #END IF
      #160714-00026#1-e-mark
      LET l_ac = l_ac + 1
   END FOREACH
   
   LET g_detail2_cnt = l_ac - 1
   CALL g_browser.deleteElement(l_ac)
   LET l_ac = g_browser.getLength()
   
   #160714-00026#1-s-mark  最上階的訂單，就會帶出所有單據了，故這段可以mark
   #FOR l_n = 1 TO g_browser.getLength()
   #    IF g_browser[l_n].b_hasC = TRUE AND g_browser[l_n].b_isExp is null THEN
   #      CALL apsp700_browser_expand(l_n)
   #   END IF
   #END FOR
   #160714-00026#1-e-mark

   FREE master_type_0
   FREE master_type_1
   FREE master_type_2

   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsp700.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp700_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   CALL s_feature_description(g_detail_d[l_ac].psoq043,g_detail_d[l_ac].psoq044)
        RETURNING l_success,g_detail_d[l_ac].psoq044_desc
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp700.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp700_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
{
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
}
  #151209-00022#7 add -----(S)
   CONSTRUCT g_wc_filter ON psoq004,psoq043,psoq044,psoq022,
                            psoq032,psoq007,psoq024
        FROM s_detail1[1].b_psoq004,s_detail1[1].b_psoq043,s_detail1[1].b_psoq044,s_detail1[1].b_psoq022,
             s_detail1[1].b_psoq032,s_detail1[1].b_psoq007,s_detail1[1].b_psoq024

      BEFORE CONSTRUCT      

      ON ACTION controlp INFIELD b_psoq004        #訂單單號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE         
         CALL q_psoq004()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_psoq004  #顯示到畫面上
         NEXT FIELD b_psoq004                     #返回原欄位

      ON ACTION controlp INFIELD b_psoq043          #料件編號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaa001_9()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_psoq043    #顯示到畫面上
         NEXT FIELD b_psoq043                       #返回原欄位

      ON ACTION controlp INFIELD b_psoq032          #單位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_psoq032    #顯示到畫面上
         NEXT FIELD b_psoq032                       #返回原欄位
      
   END CONSTRUCT
  #151209-00022#7 add -----(E)
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp700_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp700.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp700_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="apsp700.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp700_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp700.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: APS版本說明
# Memo...........:
# Usage..........: CALL apsp700_psoq001_ref()
# Input parameter: no
# Return code....: no
# Date & Author..: 141017 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_psoq001_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_param.psoq001
   CALL ap_ref_array2(g_ref_fields,"SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscalsite='"||g_site||"' AND pscal001=? AND pscal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_param.psoq001_desc = g_rtn_fields[1]
   DISPLAY g_param.psoq001_desc TO psoq001_desc
END FUNCTION

################################################################################
# Descriptions...: 依單據類型抓取對應的單位及已轉單
# Memo...........:
# Usage..........: CALL apsp700_fetch_detail(p_psph010,p_psph016,p_psph040)
#                  RETURNING r_pspc014,r_pspc054
# Input parameter: p_psph010   單號
#                : p_psph016   類型
#                : p_psph040   料號
# Return code....: r_pspc014   單位
#                : r_pspc054   已轉單
# Date & Author..: 141020 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_fetch_detail(p_psph010,p_psph016,p_psph040)
DEFINE p_psph010       LIKE psph_t.psph010
DEFINE p_psph016       LIKE psph_t.psph016
DEFINE p_psph040       LIKE psph_t.psph040
DEFINE r_pspc014       LIKE pspc_t.pspc014
DEFINE r_pspc054       LIKE pspc_t.pspc054

   LET r_pspc014 = ''
   LET r_pspc054 = ''

   CASE
      WHEN p_psph016 = 'M' OR p_psph016 = 'NM'
         #工單結果檔
         SELECT psos017,psos057
           INTO r_pspc014,r_pspc054
           FROM psos_t
          WHERE psosent = g_enterprise
            AND psossite = g_site
            AND psos001 = g_param.psoq001
            AND psos002 = g_psoq002
            AND psos004 = p_psph010
      WHEN p_psph016 = 'P' OR p_psph016 = 'NP'
         #採購單結果檔
         SELECT pspc014,pspc054
           INTO r_pspc014,r_pspc054
           FROM pspc_t
          WHERE pspcent = g_enterprise
            AND pspcsite = g_site
            AND pspc001 = g_param.psoq001
            AND pspc002 = g_psoq002
            AND pspc004 = p_psph010
      WHEN p_psph016 = 'I'
         #取料件的基楚單位
         SELECT imaa006 INTO r_pspc014 FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = p_psph040
      OTHERWISE
   END CASE

   RETURN r_pspc014,r_pspc054

END FUNCTION

################################################################################
# Descriptions...: 產生工單及請購單
# Memo...........:
# Usage..........: CALL apmp700_process(p_flag)
# Input parameter: p_flag   1:無NP單據、2:有NP單據
# Return code....: no
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp700_process(p_flag)
DEFINE p_flag         LIKE type_t.num5
DEFINE li_ac          LIKE type_t.num5
DEFINE li_count       LIKE type_t.num5
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE la_param  RECORD
    prog     STRING,
    param    DYNAMIC ARRAY OF STRING
             END RECORD
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_str          STRING
DEFINE l_pmdadocno    LIKE pmda_t.pmdadocno
DEFINE l_sfaadocno    LIKE sfaa_t.sfaadocno 
   #160608-00013#3 20160621 add by ming -----(S)  
   DEFINE l_max_psoq002 LIKE psoq_t.psoq002 
   #160608-00013#3 20160621 add by ming -----(E) 

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN

   END IF
   
   #160608-00013#3 20160621 add by ming -----(S) 
   LET l_max_psoq002 = '' 
   SELECT MAX(psoq002) INTO l_max_psoq002 
     FROM psoq_t
    WHERE psoqent = g_enterprise 
      AND psoqsite= g_site
      AND psoq001 = g_param.psoq001
   IF l_max_psoq002 <> g_psoq002 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'aps-00189' 
      LET g_errparam.popup  = TRUE 
      LET g_errparam.replace[1] = g_param.psoq001 
      CALL  cl_err() 
      
      RETURN 
   END IF 
   #160608-00013#3 20160621 add by ming -----(E) 

   CALL s_transaction_begin()
   LET l_tot_success = TRUE
   LET l_success = TRUE
   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('apsp700',"lbl_name") RETURNING g_coll_title[1],g_coll_title[1]  #單據編號
   DELETE FROM apsp700_tmp

   LET l_str = ''
   LET l_pmdadocno = ''
   IF p_flag = 2 THEN
      CALL apsp700_ins_pmda() RETURNING l_pmdadocno,l_success
   END IF

   LET li_count = 0
   FOR li_ac = 1 TO g_browser.getLength()
      IF g_browser[li_ac].chk = 'N' THEN
         CONTINUE FOR
      END IF
      #160316-00016#9-add-(S)
      IF cl_null(g_browser[li_ac].pspc014) THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code = 'aps-00176'  #單據編號：%1、料号：%2的單位不可空白，請檢查料件基本資料維護作業！若單位有重新設定，請重新執行APS或APS手調器，重新產出資料！
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_browser[g_detail2_idx].b_show    #單據編號
         LET g_errparam.replace[2] = g_browser[g_detail2_idx].psph040    #料號
         CALL cl_err()
      ELSE
      #160316-00016#9-add-(E)
         IF NOT l_success THEN
            LET l_tot_success = FALSE
            LET l_success = TRUE
         END IF
         
         CASE g_browser[li_ac].psph016
            WHEN 'NP'  #APS新開採購單
               IF apsp700_ins_pmdb(l_pmdadocno,g_browser[li_ac].b_show) THEN
                  LET li_count = li_count + 1
               END IF
            WHEN 'NM'  #APS新開工單
               #產生工單
               CALL apsp700_asft300_gen(g_browser[li_ac].b_show)
                    RETURNING l_success
               IF NOT l_success THEN
                  CONTINUE FOR
               END IF
               #更新已轉單據='Y'、產生工單單號=sfaadocno
               UPDATE psos_t SET psos057 = 'Y',
                                 psos058 = g_sfaa.sfaadocno
                WHERE psosent = g_enterprise
                  AND psossite= g_site
                  AND psos001 = g_param.psoq001
                  AND psos002 = g_psoq002
                  AND psos004 = g_browser[li_ac].b_show
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'upd psos_t'
                  LET g_errparam.popup = TRUE
                  LET g_errparam.coll_vals[1] = g_browser[li_ac].b_show
                  CALL cl_err()
                  LET l_success = FALSE
               ELSE
                  LET li_count = li_count + 1
                  #161109-00085#17-s mod
#                  INSERT INTO apsp700_tmp VALUES(g_sfaa.sfaadocno)   #161109-00085#17-s mark
                  INSERT INTO apsp700_tmp(sfaadocno) 
                                   VALUES(g_sfaa.sfaadocno)
                  #161109-00085#17-e mod
                  IF cl_null(l_str) THEN
                     LET l_str = " (sfaadocno = '", g_sfaa.sfaadocno,"') "
                  ELSE
                     LET l_str = l_str," OR (sfaadocno = '", g_sfaa.sfaadocno,"') "
                  END IF
               END IF
            OTHERWISE EXIT CASE
         END CASE
       END IF #160316-00016#9-add
   END FOR

   CALL cl_err_collect_show()
   
   IF NOT l_success THEN
      LET l_tot_success = FALSE
   END IF

   IF li_count = 0 THEN
      #無符合條件的資料產生！
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET l_tot_success = FALSE
   END IF
   
   IF l_tot_success THEN
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()
      CALL s_azzi902_get_gzzd('apsp700',"lbl_name") RETURNING g_coll_title[1],g_coll_title[1]  #單據編號
      INITIALIZE g_errparam TO NULL
      IF NOT cl_null(l_pmdadocno) THEN
         #成功產生請購單！
         LET g_errparam.code = 'aps-00135'
         LET g_errparam.coll_vals[1] = l_pmdadocno
         CALL cl_err()
      END IF
      LET l_sfaadocno = ''
      DECLARE apsp700_process_sel_tmp_cur CURSOR FOR
         SELECT sfaadocno FROM apsp700_tmp
      FOREACH apsp700_process_sel_tmp_cur INTO l_sfaadocno
         #成功產生工單！
         LET g_errparam.code = 'aps-00136'
         LET g_errparam.coll_vals[1] = l_sfaadocno
         CALL cl_err()
         LET l_sfaadocno = ''
      END FOREACH
      CALL cl_err_collect_show()
      
      IF cl_ask_confirm('aps-00127') THEN
         IF NOT cl_null(l_pmdadocno) THEN
            LET la_param.prog = 'apmt400'
            LET la_param.param[1] = l_pmdadocno
            LET ls_js = util.JSON.stringify(la_param )
            CALL cl_cmdrun(ls_js)
         END IF
         IF NOT cl_null(l_str) THEN
            LET la_param.prog = 'asft300'
            LET la_param.param[1] = ''
            LET la_param.param[2] = ''
            LET la_param.param[3] = l_str
            LET ls_js = util.JSON.stringify(la_param )
            CALL cl_cmdrun(ls_js)
         END IF
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      CALL cl_ask_confirm3("std-00012","")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 工單產生
# Memo...........:
# Usage..........: CALL apsp700_asft300_gen(p_psos004)
#                  RETURNING r_success
# Input parameter: p_psos004
# Return code....: TRUE/FALSE
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_asft300_gen(p_psos004)
DEFINE p_psos004         LIKE psos_t.psos004
DEFINE r_success         LIKE type_t.num5
DEFINE l_num             LIKE type_t.num5

   LET r_success = TRUE
   
   #產生工單單頭
   CALL apsp700_sfaa_ins(p_psos004) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生工單來源
   CALL apsp700_sfab_ins(p_psos004) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生生產料號明細
   CALL apsp700_sfac_ins(p_psos004) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生備料
   CALL s_asft300_02(g_sfaa.sfaadocno,g_sfaa.sfaa003,g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa015,g_sfaa.sfaa012,'N')
        RETURNING r_success,l_num
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #取替代
   CALL apsp700_replace(p_psos004) RETURNING r_success
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增工單單頭
# Memo...........:
# Usage..........: CALL apsp700_sfaa_ins(p_psos004)
#                  RETURNING r_success
# Input parameter: p_psos004
# Return code....: TRUE/FALSE
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_sfaa_ins(p_psos004)
DEFINE p_psos004         LIKE psos_t.psos004
DEFINE r_success         LIKE type_t.num5
DEFINE l_doclen          LIKE ooaa_t.ooaa002
DEFINE l_psos021         LIKE psos_t.psos021
DEFINE l_str             STRING
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   INITIALIZE g_sfaa.* TO NULL

   LET g_sfaa.sfaaent = g_enterprise
   LET g_sfaa.sfaasite = g_site
   LET g_sfaa.sfaaownid = g_user
   LET g_sfaa.sfaaowndp = g_dept
   LET g_sfaa.sfaacrtid = g_user
   LET g_sfaa.sfaacrtdp = g_dept
   LET g_sfaa.sfaacrtdt = cl_get_current()
   LET g_sfaa.sfaastus = "N"
   LET g_sfaa.sfaadocdt = g_today
   LET g_sfaa.sfaa001 = "0"
   LET g_sfaa.sfaa002 = g_user
   LET g_sfaa.sfaa004 = '1'  
   LET g_sfaa.sfaa005 = '3'   #3.計畫
   LET g_sfaa.sfaa011 = ' '
   LET g_sfaa.sfaa012 = 0
   LET g_sfaa.sfaa038 = "N"
   LET g_sfaa.sfaa039 = "N"
   LET g_sfaa.sfaa040 = "N"
   LET g_sfaa.sfaa041 = "N"
   LET g_sfaa.sfaa042 = "N"
   LET g_sfaa.sfaa043 = "N"
   LET g_sfaa.sfaa044 = "N"
   LET g_sfaa.sfaa049 = "0"
   LET g_sfaa.sfaa050 = "0"
   LET g_sfaa.sfaa051 = "0"
   LET g_sfaa.sfaa055 = "0"
   LET g_sfaa.sfaa056 = "0"
   LET g_sfaa.sfaa057 = '1'
   LET g_sfaa.sfaa062 = "Y"
   LET g_sfaa.sfaa071 = 0     #160425-00019 by whitney add 齊料套數

   LET g_psos055 = ''
   LET l_psos021 = ''
   SELECT psos004,psos021,psos054,COALESCE(psos036,0),psos017,psos012,psos011,psos055
     INTO g_sfaa.sfaa006,l_psos021,g_sfaa.sfaa010,g_sfaa.sfaa012,
          g_sfaa.sfaa013,g_sfaa.sfaa019,g_sfaa.sfaa020,g_psos055
     FROM psos_t
    WHERE psosent = g_enterprise
      AND psossite= g_site
      AND psos001 = g_param.psoq001
      AND psos002 = g_psoq002
      AND psos004 = p_psos004
   
   #取得單據流水號總長度(aoos010)
   LET l_doclen = cl_get_para(g_enterprise,g_site,'E-COM-0005')
   LET l_str = l_psos021
   LET g_sfaa.sfaa022 = l_str.subString(1,l_doclen)
   LET l_str = l_str.subString(l_doclen+2,l_str.getLength())
   LET l_cnt = l_str.getIndexOf('-',1)
   LET g_sfaa.sfaa023 = l_str.subString(1,l_cnt-1)
   LET l_str = l_str.subString(l_cnt+1,l_str.getLength())
   LET l_cnt = l_str.getIndexOf('-',1)
   LET g_sfaa.sfaa024 = l_str.subString(1,l_cnt-1)
   LET g_sfaa.sfaa064 = l_str.subString(l_cnt+1,l_str.getLength())

   CALL apsp700_doc_default()

   #自動編號
   CALL s_aooi200_gen_docno(g_site,g_param.sfaadocno,g_today,'asft300')
        RETURNING r_success,g_sfaa.sfaadocno
   IF NOT r_success THEN
      RETURN r_success
   END IF

   #預設工單類型
   SELECT oobb005 INTO g_sfaa.sfaa003 FROM oobb_t
    WHERE oobbent = g_enterprise
      AND oobb001 = g_ooef004
      AND oobb002 = g_sfaa.sfaadocno
      AND oobb004 = 'sfaa003'
   IF cl_null(g_sfaa.sfaa003) THEN
      LET g_sfaa.sfaa003 = '1'
   END IF

   #預設製程否
   LET g_sfaa.sfaa061 = cl_get_doc_para(g_enterprise,g_site,g_sfaa.sfaadocno,'D-MFG-0041')
   IF cl_null(g_sfaa.sfaa061) THEN
      LET g_sfaa.sfaa061 = 'N'
   END IF

   #預設FQC否
   LET g_sfaa.sfaa044 = cl_get_doc_para(g_enterprise,g_site,g_sfaa.sfaadocno,'D-MFG-0042')
   IF cl_null(g_sfaa.sfaa044) THEN
      LET g_sfaa.sfaa044 = 'N'
   END IF

   #參考單位、參考數量
   SELECT imaf015 INTO g_sfaa.sfaa060 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = g_sfaa.sfaa010
   IF NOT cl_null(g_sfaa.sfaa060) THEN
      CALL s_aooi250_convert_qty(g_sfaa.sfaa010,g_sfaa.sfaa013,g_sfaa.sfaa060,g_sfaa.sfaa012)
           RETURNING r_success,g_sfaa.sfaa058
      IF NOT r_success THEN
         RETURN r_success
      END IF
   END IF
   
   #完工超入容差率
   SELECT imae020 INTO g_sfaa.sfaa027 FROM imae_t
    WHERE imaeent = g_enterprise 
      AND imaesite = g_site 
      AND imae001 = g_sfaa.sfaa010
   IF cl_null(g_sfaa.sfaa027) THEN
      LET g_sfaa.sfaa027 = 0
   END IF
   
   #若有使用製程，則預設料件據點資料的製程編號
   IF g_sfaa.sfaa061 = 'Y' THEN
      SELECT imae033 INTO g_sfaa.sfaa016 FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite= g_site
         AND imae001 = g_sfaa.sfaa010
   END IF
   
   INSERT INTO sfaa_t (sfaaent,sfaasite,sfaadocno,sfaadocdt,
          sfaa001,sfaa002,sfaa003,sfaa004,sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,sfaa010,
          sfaa011,sfaa012,sfaa013,sfaa014,sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,
          sfaa021,sfaa022,sfaa023,sfaa024,sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,
          sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,
          sfaa041,sfaa042,sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,
          sfaa051,sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,
          sfaastus,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,
          sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,sfaapstid,sfaapstdt)
      VALUES (g_sfaa.sfaaent,g_sfaa.sfaasite,g_sfaa.sfaadocno,g_sfaa.sfaadocdt,
              g_sfaa.sfaa001,g_sfaa.sfaa002,g_sfaa.sfaa003,g_sfaa.sfaa004,g_sfaa.sfaa005,
              g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,g_sfaa.sfaa010,
              g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa014,g_sfaa.sfaa015,
              g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,g_sfaa.sfaa019,g_sfaa.sfaa020,
              g_sfaa.sfaa021,g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,g_sfaa.sfaa025,
              g_sfaa.sfaa026,g_sfaa.sfaa027,g_sfaa.sfaa028,g_sfaa.sfaa029,g_sfaa.sfaa030,
              g_sfaa.sfaa031,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,g_sfaa.sfaa035,
              g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,g_sfaa.sfaa040,
              g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,g_sfaa.sfaa045,
              g_sfaa.sfaa046,g_sfaa.sfaa047,g_sfaa.sfaa048,g_sfaa.sfaa049,g_sfaa.sfaa050,
              g_sfaa.sfaa051,g_sfaa.sfaa055,g_sfaa.sfaa056,g_sfaa.sfaa057,g_sfaa.sfaa058,
              g_sfaa.sfaa059,g_sfaa.sfaa060,g_sfaa.sfaa061,g_sfaa.sfaa062,
              g_sfaa.sfaastus,g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,
              g_sfaa.sfaacrtdp,g_sfaa.sfaacrtdt,g_sfaa.sfaamodid,g_sfaa.sfaamoddt,
              g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,g_sfaa.sfaapstid,g_sfaa.sfaapstdt)
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins sfaa_t"
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = p_psos004
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生工單來源
# Memo...........:
# Usage..........: CALL apsp700_sfab_ins(p_psos004)
#                  RETURNING r_success
# Input parameter: p_psos004
# Return code....: TRUE/FALSE
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_sfab_ins(p_psos004)
DEFINE p_psos004         LIKE psos_t.psos004
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfabseq,sfab001,
                      sfab002,sfab003,sfab004,sfab005,sfab006,sfab007)
      VALUES(g_sfaa.sfaaent,g_sfaa.sfaasite,g_sfaa.sfaadocno,1,g_sfaa.sfaa005,
             p_psos004,'','','',1,g_sfaa.sfaa012)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins sfab_t"
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = p_psos004
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生生產料號明細
# Memo...........:
# Usage..........: CALL apsp700_sfac_ins(p_psos004)
#                  RETURNING r_success
# Input parameter: p_psos004
# Return code....: TRUE/FALSE
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_sfac_ins(p_psos004)
DEFINE p_psos004         LIKE psos_t.psos004
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_sql1            STRING
DEFINE l_sql2            STRING
DEFINE l_sql3            STRING
#mod--161109-00085#17 By 08993--(s)
#DEFINE l_sfac            RECORD LIKE sfac_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE l_sfac            RECORD  #工單聯產品檔
       sfacent LIKE sfac_t.sfacent, #企業編號
       sfacsite LIKE sfac_t.sfacsite, #營運據點
       sfacdocno LIKE sfac_t.sfacdocno, #單號
       sfac001 LIKE sfac_t.sfac001, #料件編號
       sfac002 LIKE sfac_t.sfac002, #類型
       sfac003 LIKE sfac_t.sfac003, #預計產出量
       sfac004 LIKE sfac_t.sfac004, #單位
       sfac005 LIKE sfac_t.sfac005, #實際產出數量
       sfacseq LIKE sfac_t.sfacseq, #項次
       sfac006 LIKE sfac_t.sfac006, #產品特徵
       sfac007 LIKE sfac_t.sfac007  #保稅否
          END RECORD
#mod--161109-00085#17 By 08993--(e)
DEFINE l_n               LIKE type_t.num5

   LET r_success = TRUE
  
   #聯產品
   LET l_sql1 = " SELECT UNIQUE bmab003,'2',bmab004*",g_sfaa.sfaa012/100,",'',0,' ' ",
                "   FROM bmab_t ",
                "  WHERE bmabent = '",g_enterprise,"'",
                "    AND bmabsite = '",g_site,"'",
                "    AND bmab001 = '",g_sfaa.sfaa010,"'",
                "    AND bmab002 = '",g_sfaa.sfaa011,"'"
                
   #多產出主件
   LET l_sql2 = " SELECT UNIQUE bmad003,'3',bmad004*",g_sfaa.sfaa012,",bmad005,0,' ' ",
                "   FROM bmad_t ",
                "  WHERE bmadent = '",g_enterprise,"'",
                "    AND bmadsite = '",g_site,"'",
                "    AND bmad001 = '",g_sfaa.sfaa010,"'",
                "    AND bmad002 = '",g_sfaa.sfaa011,"'"
   
   #副產品
   LET l_sql3 = " SELECT UNIQUE bmac003,'5',bmac005/bmac006*",g_sfaa.sfaa012,",bmac004,0,' ' ",
                "   FROM bmac_t ",
                "  WHERE bmacent = '",g_enterprise,"'",
                "    AND bmacsite = '",g_site,"'",
                "    AND bmac001 = '",g_sfaa.sfaa010,"'",
                "    AND bmac002 = '",g_sfaa.sfaa011,"'"
   
   LET l_sql = l_sql1," UNION ",l_sql2," UNION ",l_sql3
   PREPARE apsp700_sfac_pre FROM l_sql
   DECLARE apsp700_sfac_cs CURSOR FOR apsp700_sfac_pre
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM bmad_t 
    WHERE bmadent = g_enterprise
      AND bmadsite = g_site
      AND bmad001 = g_sfaa.sfaa010
      AND bmad002 = g_sfaa.sfaa011
   IF cl_null(l_n) OR l_n = 0 THEN
      INITIALIZE l_sfac.* TO NULL
      
      LET l_sfac.sfacent = g_sfaa.sfaaent
      LET l_sfac.sfacsite= g_sfaa.sfaasite
      LET l_sfac.sfacdocno = g_sfaa.sfaadocno
      
      SELECT MAX(sfacseq)+1 INTO l_sfac.sfacseq
        FROM sfac_t
       WHERE sfacent = g_enterprise
         AND sfacsite= g_site
         AND sfacdocno = g_sfaa.sfaadocno
      IF cl_null(l_sfac.sfacseq) THEN
         LET l_sfac.sfacseq = 1
      END IF
      
      LET l_sfac.sfac001 = g_sfaa.sfaa010
      LET l_sfac.sfac002 = '1'
      LET l_sfac.sfac003 = g_sfaa.sfaa012
      LET l_sfac.sfac004 = g_sfaa.sfaa013
      LET l_sfac.sfac005 = 0
      LET l_sfac.sfac006 = g_psos055
      
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,
                         sfac002,sfac003,sfac004,sfac005,sfac006)
         VALUES(l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfacseq,l_sfac.sfac001,
                l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfac_t"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = p_psos004
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   INITIALIZE l_sfac.* TO NULL
   
   FOREACH apsp700_sfac_cs INTO l_sfac.sfac001,l_sfac.sfac002,l_sfac.sfac003,
                                l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH apsp700_sfac_cs:"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = p_psos004
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      IF cl_null(l_sfac.sfac001) THEN
         CONTINUE FOREACH
      END IF
      
      LET l_sfac.sfacent = g_sfaa.sfaaent
      LET l_sfac.sfacsite= g_sfaa.sfaasite
      LET l_sfac.sfacdocno = g_sfaa.sfaadocno
      
      SELECT MAX(sfacseq)+1 INTO l_sfac.sfacseq
        FROM sfac_t
       WHERE sfacent = g_enterprise
         AND sfacsite= g_site
         AND sfacdocno = g_sfaa.sfaadocno
      IF cl_null(l_sfac.sfacseq) THEN
         LET l_sfac.sfacseq = 1
      END IF
      
      IF cl_null(l_sfac.sfac004) THEN
         SELECT bmaa004 INTO l_sfac.sfac004 FROM bmaa_t
          WHERE bmaaent = g_enterprise
            AND bmaasite= g_site
            AND bmaa001 = g_sfaa.sfaa010
            AND bmaa002 = g_sfaa.sfaa011
      END IF
      
      #聯產品
      IF l_sfac.sfac002 = '2' THEN
         LET l_sfac.sfac006 = g_psos055
      END IF
      
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,
                         sfac002,sfac003,sfac004,sfac005,sfac006)
         VALUES(l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfacseq,l_sfac.sfac001,
                l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfac_t"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = p_psos004
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      INITIALIZE l_sfac.* TO NULL
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取替代
# Memo...........:
# Usage..........: CALL apsp700_replace(p_psos004)
#                  RETURNING r_success
# Input parameter: p_psos004
# Return code....: TRUE/FALSE
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_replace(p_psos004)
DEFINE p_psos004         LIKE psos_t.psos004
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#17 By 08993--(s)
#DEFINE l_psot            RECORD LIKE psot_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE l_psot            RECORD  #相依性需求結果檔
       psotent LIKE psot_t.psotent, #企業編號
       psotsite LIKE psot_t.psotsite, #營運據點
       psot001 LIKE psot_t.psot001, #APS版本
       psot002 LIKE psot_t.psot002, #執行日期時間
       psot003 LIKE psot_t.psot003, #工單編號
       psot004 LIKE psot_t.psot004, #領料序
       psot005 LIKE psot_t.psot005, #需求序號
       psot006 LIKE psot_t.psot006, #元件品號
       psot007 LIKE psot_t.psot007, #預計完工日
       psot008 LIKE psot_t.psot008, #開立日
       psot009 LIKE psot_t.psot009, #主件品號
       psot010 LIKE psot_t.psot010, #計畫批號
       psot011 LIKE psot_t.psot011, #預計領用日
       psot012 LIKE psot_t.psot012, #應領用量
       psot013 LIKE psot_t.psot013, #自動領料
       psot014 LIKE psot_t.psot014, #EPR工單編號
       psot015 LIKE psot_t.psot015, #原主料料號
       psot016 LIKE psot_t.psot016, #上階需求料號
       psot017 LIKE psot_t.psot017, #耗率數量
       psot018 LIKE psot_t.psot018, #客供料
       psot019 LIKE psot_t.psot019, #取替代型態
       psot020 LIKE psot_t.psot020, #品號
       psot021 LIKE psot_t.psot021, #品號特徵碼
       psot022 LIKE psot_t.psot022, #工單品號
       psot023 LIKE psot_t.psot023, #工單特徵碼
       psot024 LIKE psot_t.psot024, #需求(主料)品號
       psot025 LIKE psot_t.psot025, #需求品號特徵碼
       psot026 LIKE psot_t.psot026, #上階品號
       psot027 LIKE psot_t.psot027, #上階特徵碼
       psot028 LIKE psot_t.psot028, #材料類型
       psot029 LIKE psot_t.psot029, #超領率
       psot030 LIKE psot_t.psot030, #缺領率
       psot031 LIKE psot_t.psot031, #作業編號
       psot032 LIKE psot_t.psot032, #投料間距
       psot033 LIKE psot_t.psot033, #被取代數量
       psot034 LIKE psot_t.psot034, #替代群組碼
       psot035 LIKE psot_t.psot035, #群組碼
       psot036 LIKE psot_t.psot036, #供應套數
       psot037 LIKE psot_t.psot037, #BOM序號
       psot038 LIKE psot_t.psot038, #BOM順序號
       psot039 LIKE psot_t.psot039, #領料用量(變動)
       psot040 LIKE psot_t.psot040, #領料用量(固定)
       psot041 LIKE psot_t.psot041, #部位
       psot042 LIKE psot_t.psot042, #作業序
       psot043 LIKE psot_t.psot043  #保稅否
          END RECORD
#mod--161109-00085#17 By 08993--(e)
DEFINE l_sfba013         LIKE sfba_t.sfba013
#mod--161109-00085#17 By 08993--(s)
#DEFINE l_sfba            RECORD LIKE sfba_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE l_sfba            RECORD  #工單備料單身檔
       sfbaent LIKE sfba_t.sfbaent, #企業編號
       sfbasite LIKE sfba_t.sfbasite, #營運據點
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba001 LIKE sfba_t.sfba001, #上階料號
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba005 LIKE sfba_t.sfba005, #BOM料號
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba007 LIKE sfba_t.sfba007, #投料時距
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba009 LIKE sfba_t.sfba009, #倒扣料
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba012 LIKE sfba_t.sfba012, #允許誤差率
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba018 LIKE sfba_t.sfba018, #盤虧數量
       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
       sfba021 LIKE sfba_t.sfba021, #產品特徵
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba024 LIKE sfba_t.sfba024, #調整應發數量
       sfba025 LIKE sfba_t.sfba025, #超領數量
       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
       sfba027 LIKE sfba_t.sfba027, #SET替代群組
       sfba028 LIKE sfba_t.sfba028, #客供料
       sfba029 LIKE sfba_t.sfba029, #指定發料批號
       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
       sfbaud001 LIKE sfba_t.sfbaud001, #自定義欄位(文字)001
       sfbaud002 LIKE sfba_t.sfbaud002, #自定義欄位(文字)002
       sfbaud003 LIKE sfba_t.sfbaud003, #自定義欄位(文字)003
       sfbaud004 LIKE sfba_t.sfbaud004, #自定義欄位(文字)004
       sfbaud005 LIKE sfba_t.sfbaud005, #自定義欄位(文字)005
       sfbaud006 LIKE sfba_t.sfbaud006, #自定義欄位(文字)006
       sfbaud007 LIKE sfba_t.sfbaud007, #自定義欄位(文字)007
       sfbaud008 LIKE sfba_t.sfbaud008, #自定義欄位(文字)008
       sfbaud009 LIKE sfba_t.sfbaud009, #自定義欄位(文字)009
       sfbaud010 LIKE sfba_t.sfbaud010, #自定義欄位(文字)010
       sfbaud011 LIKE sfba_t.sfbaud011, #自定義欄位(數字)011
       sfbaud012 LIKE sfba_t.sfbaud012, #自定義欄位(數字)012
       sfbaud013 LIKE sfba_t.sfbaud013, #自定義欄位(數字)013
       sfbaud014 LIKE sfba_t.sfbaud014, #自定義欄位(數字)014
       sfbaud015 LIKE sfba_t.sfbaud015, #自定義欄位(數字)015
       sfbaud016 LIKE sfba_t.sfbaud016, #自定義欄位(數字)016
       sfbaud017 LIKE sfba_t.sfbaud017, #自定義欄位(數字)017
       sfbaud018 LIKE sfba_t.sfbaud018, #自定義欄位(數字)018
       sfbaud019 LIKE sfba_t.sfbaud019, #自定義欄位(數字)019
       sfbaud020 LIKE sfba_t.sfbaud020, #自定義欄位(數字)020
       sfbaud021 LIKE sfba_t.sfbaud021, #自定義欄位(日期時間)021
       sfbaud022 LIKE sfba_t.sfbaud022, #自定義欄位(日期時間)022
       sfbaud023 LIKE sfba_t.sfbaud023, #自定義欄位(日期時間)023
       sfbaud024 LIKE sfba_t.sfbaud024, #自定義欄位(日期時間)024
       sfbaud025 LIKE sfba_t.sfbaud025, #自定義欄位(日期時間)025
       sfbaud026 LIKE sfba_t.sfbaud026, #自定義欄位(日期時間)026
       sfbaud027 LIKE sfba_t.sfbaud027, #自定義欄位(日期時間)027
       sfbaud028 LIKE sfba_t.sfbaud028, #自定義欄位(日期時間)028
       sfbaud029 LIKE sfba_t.sfbaud029, #自定義欄位(日期時間)029
       sfbaud030 LIKE sfba_t.sfbaud030, #自定義欄位(日期時間)030
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035  #SET替代套數
          END RECORD
#mod--161109-00085#17 By 08993--(e)
DEFINE l_bmea011         LIKE bmea_t.bmea011
DEFINE l_bmea012         LIKE bmea_t.bmea012

   LET r_success = TRUE
   
   DECLARE apsp700_replace_cs CURSOR FOR
    #mod--161109-00085#17 By 08993--(s)
#    SELECT * FROM psot_t   #mark--161109-00085#17 By 08993--(s)
    SELECT psotent,psotsite,psot001,psot002,psot003,psot004,psot005,psot006,psot007,psot008,psot009,psot010,
           psot011,psot012,psot013,psot014,psot015,psot016,psot017,psot018,psot019,psot020,psot021,psot022,
           psot023,psot024,psot025,psot026,psot027,psot028,psot029,psot030,psot031,psot032,psot033,psot034,
           psot035,psot036,psot037,psot038,psot039,psot040,psot041,psot042,psot043 
       FROM psot_t
    #mod--161109-00085#17 By 08993--(e)
     WHERE psotent = g_enterprise
       AND psotsite= g_site
       AND psot001 = g_param.psoq001
       AND psot002 = g_psoq002
       AND psot003 = p_psos004
       AND psot015 <> psot020   #原主料料號psot015<>元件品號psot020
   #mod--161109-00085#17 By 08993--(s)
#   FOREACH apsp700_replace_cs INTO l_psot.*   #mark--161109-00085#17 By 08993--(s)
   FOREACH apsp700_replace_cs INTO l_psot.psotent,l_psot.psotsite,l_psot.psot001,l_psot.psot002,l_psot.psot003,
                                   l_psot.psot004,l_psot.psot005,l_psot.psot006,l_psot.psot007,l_psot.psot008,
                                   l_psot.psot009,l_psot.psot010,l_psot.psot011,l_psot.psot012,l_psot.psot013,
                                   l_psot.psot014,l_psot.psot015,l_psot.psot016,l_psot.psot017,l_psot.psot018,
                                   l_psot.psot019,l_psot.psot020,l_psot.psot021,l_psot.psot022,l_psot.psot023,
                                   l_psot.psot024,l_psot.psot025,l_psot.psot026,l_psot.psot027,l_psot.psot028,
                                   l_psot.psot029,l_psot.psot030,l_psot.psot031,l_psot.psot032,l_psot.psot033,
                                   l_psot.psot034,l_psot.psot035,l_psot.psot036,l_psot.psot037,l_psot.psot038,
                                   l_psot.psot039,l_psot.psot040,l_psot.psot041,l_psot.psot042,l_psot.psot043
   #mod--161109-00085#17 By 08993--(e)                              
      
      IF l_psot.psot031 IS NULL THEN
         LET l_psot.psot031 = ' '
      END IF
      IF l_psot.psot041 IS NULL THEN
         LET l_psot.psot041 = ' '
      END IF
      IF l_psot.psot042 IS NULL THEN
         LET l_psot.psot042 = ' '
      END IF
      
      INITIALIZE l_sfba.* TO NULL
      #mod--161109-00085#17 By 08993--(s)
#      SELECT * INTO l_sfba.*   #mark--161109-00085#17 By 08993--(s) 
      SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005,sfba006,sfba007,
             sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015,sfba016,sfba017,sfba018,sfba019,sfba020,
             sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,sfba029,sfba030,
             sfbaud001,sfbaud002,sfbaud003,sfbaud004,sfbaud005,sfbaud006,
             sfbaud007,sfbaud008,sfbaud009,sfbaud010,sfbaud011,sfbaud012,
             sfbaud013,sfbaud014,sfbaud015,sfbaud016,sfbaud017,sfbaud018,
             sfbaud019,sfbaud020,sfbaud021,sfbaud022,sfbaud023,sfbaud024,
             sfbaud025,sfbaud026,sfbaud027,sfbaud028,sfbaud029,sfbaud030,
             sfba031,sfba032,sfba033,sfba034,sfba035
        INTO l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba001,l_sfba.sfba002,
             l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,
             l_sfba.sfba010,l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,l_sfba.sfba016,
             l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,
             l_sfba.sfba024,l_sfba.sfba025,l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028,l_sfba.sfba029,l_sfba.sfba030,
             l_sfba.sfbaud001,l_sfba.sfbaud002,l_sfba.sfbaud003,l_sfba.sfbaud004,l_sfba.sfbaud005,l_sfba.sfbaud006,
             l_sfba.sfbaud007,l_sfba.sfbaud008,l_sfba.sfbaud009,l_sfba.sfbaud010,l_sfba.sfbaud011,l_sfba.sfbaud012,
             l_sfba.sfbaud013,l_sfba.sfbaud014,l_sfba.sfbaud015,l_sfba.sfbaud016,l_sfba.sfbaud017,l_sfba.sfbaud018,
             l_sfba.sfbaud019,l_sfba.sfbaud020,l_sfba.sfbaud021,l_sfba.sfbaud022,l_sfba.sfbaud023,l_sfba.sfbaud024,
             l_sfba.sfbaud025,l_sfba.sfbaud026,l_sfba.sfbaud027,l_sfba.sfbaud028,l_sfba.sfbaud029,l_sfba.sfbaud030,
             l_sfba.sfba031,l_sfba.sfba032,l_sfba.sfba033,l_sfba.sfba034,l_sfba.sfba035
      #mod--161109-00085#17 By 08993--(e)
        FROM sfba_t
       WHERE sfbaent = g_sfaa.sfaaent
         AND sfbasite= g_sfaa.sfaasite
         AND sfbadocno = g_sfaa.sfaadocno
         AND sfbaseq1 = 0
         AND NVL(sfba002,' ') = NVL(l_psot.psot041,' ')
         AND NVL(sfba003,' ') = NVL(l_psot.psot031,' ')
         AND NVL(sfba004,' ') = NVL(l_psot.psot042,' ')
         AND sfba005 = l_psot.psot015
         
      LET l_sfba013 = l_sfba.sfba013
         
      SELECT MAX(sfbaseq1)+1 INTO l_sfba.sfbaseq1
        FROM sfba_t
       WHERE sfbaent = l_sfba.sfbaent
         AND sfbasite= l_sfba.sfbasite
         AND sfbadocno = l_sfba.sfbadocno
         AND sfbaseq = l_sfba.sfbaseq
      LET l_sfba.sfba006 = l_psot.psot020
      LET l_sfba.sfba007 = 0
      LET l_sfba.sfba010 = 0
      LET l_sfba.sfba011 = 0
      LET l_sfba.sfba012 = 0
      LET l_sfba.sfba015 = 0
      LET l_sfba.sfba016 = 0
      LET l_sfba.sfba017 = 0
      LET l_sfba.sfba018 = 0
      SELECT bmea011,bmea012,bmea013
        INTO l_bmea011,l_bmea012,l_sfba.sfba014
        FROM bmea_t
       WHERE bmeaent = l_sfba.sfbaent
         AND bmeasite= l_sfba.sfbasite
         AND bmea001 = g_sfaa.sfaa010
         AND bmea002 = g_sfaa.sfaa011
         AND bmea003 = l_sfba.sfba005
         AND bmea004 = l_sfba.sfba002
         AND bmea005 = l_sfba.sfba003
         AND bmea006 = l_sfba.sfba004
         AND bmea008 = l_sfba.sfba006
         
      LET l_sfba.sfba022 = l_bmea011/l_bmea012
      LET l_sfba.sfba013 = l_psot.psot033 * l_sfba.sfba022
      LET l_sfba.sfba023 = 0
      LET l_sfba.sfba024 = 0
      LET l_sfba.sfba025 = 0
      LET l_sfba.sfba026 = '1'
      LET l_sfba.sfba028 = 'N'
      IF g_sfaa.sfaa004 = '1' THEN
         LET l_sfba.sfba009 = 'N'
      END IF
      IF g_sfaa.sfaa004 = '2' THEN
         LET l_sfba.sfba009 = 'Y'
      END IF
      #mod--161109-00085#17 By 08993--(s)
#      INSERT INTO sfba_t (sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,
#                    sfba001,sfba002,sfba003,sfba004,sfba005,sfba006,sfba007,sfba008,sfba009,sfba010,
#                    sfba011,sfba012,sfba013,sfba014,sfba015,sfba016,sfba017,sfba018,sfba019,sfba020,
#                    sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028)
#         VALUES(l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
#                l_sfba.sfba001,l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,
#                l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,l_sfba.sfba010,
#                l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,
#                l_sfba.sfba016,l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,
#                l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,l_sfba.sfba024,l_sfba.sfba025,
#                l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028)
      INSERT INTO sfba_t (sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,
                    sfba001,sfba002,sfba003,sfba004,sfba005,sfba006,sfba007,sfba008,sfba009,sfba010,
                    sfba011,sfba012,sfba013,sfba014,sfba015,sfba016,sfba017,sfba018,sfba019,sfba020,
                    sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,sfba029,sfba030,
                    sfbaud001,sfbaud002,sfbaud003,sfbaud004,sfbaud005,sfbaud006,
                    sfbaud007,sfbaud008,sfbaud009,sfbaud010,sfbaud011,sfbaud012,
                    sfbaud013,sfbaud014,sfbaud015,sfbaud016,sfbaud017,sfbaud018,
                    sfbaud019,sfbaud020,sfbaud021,sfbaud022,sfbaud023,sfbaud024,
                    sfbaud025,sfbaud026,sfbaud027,sfbaud028,sfbaud029,sfbaud030,
                    sfba031,sfba032,sfba033,sfba034,sfba035)
         VALUES(l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
                l_sfba.sfba001,l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,
                l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,l_sfba.sfba010,
                l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,
                l_sfba.sfba016,l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,
                l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,l_sfba.sfba024,l_sfba.sfba025,
                l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028,l_sfba.sfba029,l_sfba.sfba030,
                l_sfba.sfbaud001,l_sfba.sfbaud002,l_sfba.sfbaud003,l_sfba.sfbaud004,l_sfba.sfbaud005,l_sfba.sfbaud006,
                l_sfba.sfbaud007,l_sfba.sfbaud008,l_sfba.sfbaud009,l_sfba.sfbaud010,l_sfba.sfbaud011,l_sfba.sfbaud012,
                l_sfba.sfbaud013,l_sfba.sfbaud014,l_sfba.sfbaud015,l_sfba.sfbaud016,l_sfba.sfbaud017,l_sfba.sfbaud018,
                l_sfba.sfbaud019,l_sfba.sfbaud020,l_sfba.sfbaud021,l_sfba.sfbaud022,l_sfba.sfbaud023,l_sfba.sfbaud024,
                l_sfba.sfbaud025,l_sfba.sfbaud026,l_sfba.sfbaud027,l_sfba.sfbaud028,l_sfba.sfbaud029,l_sfba.sfbaud030,
                l_sfba.sfba031,l_sfba.sfba032,l_sfba.sfba033,l_sfba.sfba034,l_sfba.sfba035)
      #mod--161109-00085#17 By 08993--(s)          
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfba_t"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = p_psos004
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      UPDATE sfba_t SET sfba013 = l_sfba013 - l_psot.psot033
       WHERE sfbaent = l_sfba.sfbaent 
         AND sfbasite= l_sfba.sfbasite
         AND sfbadocno = l_sfba.sfbadocno
         AND sfbaseq = l_sfba.sfbaseq
         AND sfbaseq1= 0
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd sfba013"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = p_psos004
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增請購單單頭頭檔
# Memo...........:
# Usage..........: CALL apsp700_ins_pmda()
#                  RETURNING r_pmdadocno,r_success
# Input parameter: no
# Return code....: r_pmdadocno   請購單號
#                : r_success     執行狀態
# Date & Author..: 141021 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_ins_pmda()
DEFINE r_success  LIKE type_t.num5
DEFINE l_pmda  RECORD
    pmdadocno  LIKE pmda_t.pmdadocno,
    pmdacrtdt  LIKE pmda_t.pmdacrtdt,
    pmdastus   LIKE pmda_t.pmdastus,
    pmda001    LIKE pmda_t.pmda001,     #版次
    pmda004    LIKE pmda_t.pmda004,     #單價為必要輸入
    pmda006    LIKE pmda_t.pmda006,     #預算控管否
    pmda007    LIKE pmda_t.pmda007,     #費用部門
    pmda012    LIKE pmda_t.pmda012,     #單價含稅否
    pmda020    LIKE pmda_t.pmda020      #納入 MPS/MRP計算
           END RECORD
DEFINE l_success  LIKE type_t.num5

   LET r_success = TRUE

   INITIALIZE l_pmda.* TO NULL
   LET l_pmda.pmdacrtdt = cl_get_current()
   LET l_pmda.pmdastus  = "N"
   LET l_pmda.pmda001   = "0"
   LET l_pmda.pmda004   = "N"
   LET l_pmda.pmda006   = "N"
   LET l_pmda.pmda007   = g_dept
   LET l_pmda.pmda012   = "N"
   LET l_pmda.pmda020   = "Y"

   CALL s_aooi200_gen_docno(g_site,g_param.pmdadocno,g_today,'apmt400')
        RETURNING l_success,l_pmda.pmdadocno

   INSERT INTO pmda_t (pmdaent,pmdasite,pmdadocno,pmdadocdt,pmdastus,
                       pmda001,pmda002,pmda003,pmda004,pmda007,pmda020, 
                       pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt)
               VALUES (g_enterprise,g_site,l_pmda.pmdadocno,g_today,l_pmda.pmdastus, 
                       l_pmda.pmda001,g_user,g_dept,l_pmda.pmda004,l_pmda.pmda007,l_pmda.pmda020,
                       g_user,g_dept,g_user,g_dept,l_pmda.pmdacrtdt) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins pmda_t'
      CALL cl_err()
      LET r_success = FALSE
   END IF

   RETURN l_pmda.pmdadocno,r_success
END FUNCTION

################################################################################
# Descriptions...: 新增請購單明細檔
# Memo...........:
# Usage..........: CALL apsp600_ins_pmdb(p_pmdadocno,p_pspc004)
# Input parameter: p_pmdadocno
#                : p_pspc004
# Return code....: TRUE OR FALSE
# Date & Author..: 140505 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_ins_pmdb(p_pmdadocno,p_pspc004)
DEFINE p_pmdadocno LIKE pmdb_t.pmdbdocno
DEFINE p_pspc004   LIKE pspc_t.pspc004
DEFINE r_success   LIKE type_t.num5
DEFINE l_pspc001   LIKE pspc_t.pspc001
DEFINE l_pspc002   LIKE pspc_t.pspc002
DEFINE l_pmdb  RECORD
    pmdbseq  LIKE pmdb_t.pmdbseq,
    pmdb001  LIKE pmdb_t.pmdb001,  #來源單號
    pmdb004  LIKE pmdb_t.pmdb004,  #料件編號
    pmdb005  LIKE pmdb_t.pmdb005,  #產品特徵
    pmdb006  LIKE pmdb_t.pmdb006,  #需求數量
    pmdb007  LIKE pmdb_t.pmdb007,  #單位
    pmdb008  LIKE pmdb_t.pmdb008,
    pmdb009  LIKE pmdb_t.pmdb009,
    pmdb010  LIKE pmdb_t.pmdb010,
    pmdb011  LIKE pmdb_t.pmdb011,
    pmdb014  LIKE pmdb_t.pmdb014,  #供應商選擇
    pmdb019  LIKE pmdb_t.pmdb019,  #參考單價
    pmdb030  LIKE pmdb_t.pmdb030,  #需求日期
    pmdb032  LIKE pmdb_t.pmdb032,  #行狀態
    pmdb033  LIKE pmdb_t.pmdb033,  #緊急度
    pmdb041  LIKE pmdb_t.pmdb041,  #允許部份交貨
    pmdb042  LIKE pmdb_t.pmdb042,  #允許提前交貨
    pmdb043  LIKE pmdb_t.pmdb043,  #保稅
    pmdb044  LIKE pmdb_t.pmdb044,  #納入MRP
    pmdb045  LIKE pmdb_t.pmdb045,  #交期凍結否
    pmdb049  LIKE pmdb_t.pmdb049   #已轉採購量
             END RECORD
DEFINE l_success   LIKE type_t.num5
DEFINE l_time1     LIKE type_t.num5
DEFINE l_time2     LIKE type_t.num5
DEFINE l_imaf175   LIKE imaf_t.imaf175

   LET r_success = TRUE
   INITIALIZE l_pmdb.* TO NULL

   SELECT pspc050,pspc051,pspc034,pspc014,pspc045,pspc004,pspc001,pspc002
     INTO l_pmdb.pmdb004,l_pmdb.pmdb005,l_pmdb.pmdb006,l_pmdb.pmdb007,
          l_pmdb.pmdb030,l_pmdb.pmdb001,l_pspc001,l_pspc002
     FROM pspc_t
    WHERE pspcent = g_enterprise
      AND pspcsite = g_site
      AND pspc001 = g_param.psoq001
      AND pspc002 = g_psoq002
      AND pspc004 = p_pspc004

   LET l_pmdb.pmdb014 = "1"      
   LET l_pmdb.pmdb019 = "0"      
   LET l_pmdb.pmdb032 = "1"      
   LET l_pmdb.pmdb033 = "1"      
   LET l_pmdb.pmdb041 = "Y"      
   LET l_pmdb.pmdb042 = "Y"      
   LET l_pmdb.pmdb043 = "N"      
   LET l_pmdb.pmdb044 = "Y"      
   LET l_pmdb.pmdb045 = "Y"      
   LET l_pmdb.pmdb049 = 0        
   
   #料件據點進銷存檔設置的參考單位、採購計價單位
   SELECT imaf015,imaf144 INTO l_pmdb.pmdb009,l_pmdb.pmdb011 FROM imaf_t
    WHERE imafent = g_enterprise AND imafsite = g_site
      AND imaf001 = l_pmdb.pmdb004
   #參考數量由交易數量乘上交易單位與參考單位的換算率做預設
   IF NOT cl_null(l_pmdb.pmdb009) THEN
      CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb009,l_pmdb.pmdb006)
           RETURNING l_success,l_pmdb.pmdb008
   END IF
   #計價數量由交易數量乘上交易單位與計價單位的換算率做預設
   IF NOT cl_null(l_pmdb.pmdb011) THEN
      CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb011,l_pmdb.pmdb006)
           RETURNING l_success,l_pmdb.pmdb010
   END IF

   IF NOT cl_null(l_pmdb.pmdb030) THEN
      LET l_time1 = l_pmdb.pmdb030 - g_today  #需求日期 - g_today
      LET l_time2 = 0                         #[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數
      SELECT (imaf171+imaf172+imaf173+imaf174),imaf175 INTO l_time2,l_imaf175 FROM imaf_t 
        WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004
      
      #1.若輸入的需求日期 - g_today >[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數時，則[C:緊急度] = '1'(一般)
      IF l_time1 >= l_time2 THEN
         LET l_pmdb.pmdb033 = '1'
      END IF
      
      #2.若輸入的需求日期 - g_today <[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數，
      #   且需求日期 - g_today >[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '2'(緊急)
      IF l_time1 < l_time2 AND l_time1 >= l_imaf175 THEN
         LET l_pmdb.pmdb033 = '2'
      END IF
      
      #3.若輸入的需求日期 - g_today <[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '3'(特急)
      IF l_time1 < l_imaf175 THEN
         LET l_pmdb.pmdb033 = '3'
      END IF
      
   END IF

   SELECT MAX(pmdbseq)+1 INTO l_pmdb.pmdbseq FROM pmdb_t
     WHERE pmdbent = g_enterprise AND pmdbdocno = p_pmdadocno
   IF cl_null(l_pmdb.pmdbseq) OR l_pmdb.pmdbseq = 0 THEN
      LET l_pmdb.pmdbseq = 1
   END IF
   
   INSERT INTO pmdb_t(pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb004,
                      pmdb005,pmdb006,pmdb007,pmdb008,pmdb009,pmdb010,
                      pmdb011,pmdb014,pmdb019,pmdb030,pmdb032,pmdb033,
                      pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb049) 
               VALUES(g_enterprise,g_site,p_pmdadocno,l_pmdb.pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb004,
                      l_pmdb.pmdb005,l_pmdb.pmdb006,l_pmdb.pmdb007,l_pmdb.pmdb008,l_pmdb.pmdb009,l_pmdb.pmdb010,
                      l_pmdb.pmdb011,l_pmdb.pmdb014,l_pmdb.pmdb019,l_pmdb.pmdb030,l_pmdb.pmdb032,l_pmdb.pmdb033,
                      l_pmdb.pmdb041,l_pmdb.pmdb042,l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,l_pmdb.pmdb049) 
   IF SQLCA.sqlcode THEN
     INITIALIZE g_errparam.* TO NULL
     LET g_errparam.code = SQLCA.sqlcode
     LET g_errparam.extend = 'ins pmdb_t'
     LET g_errparam.coll_vals[1] = l_pmdb.pmdb001
     CALL cl_err()
     LET r_success = FALSE  
   ELSE
      UPDATE pspc_t SET pspc054 = 'Y',
                        pspc055 = p_pmdadocno,
                        pspc056 = l_pmdb.pmdbseq
       WHERE pspcent = g_enterprise
         AND pspcsite = g_site
         AND pspc001 = l_pspc001
         AND pspc002 = l_pspc002
         AND pspc004 = l_pmdb.pmdb001
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam.* TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'upd pspc_t'
        LET g_errparam.coll_vals[1] = l_pmdb.pmdb001
        CALL cl_err()
        LET r_success = FALSE  
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: Tree子節點展開
# Memo...........:
# Usage..........: CALL apsp700_browser_expand(p_pid)
# Input parameter: p_pid
# Return code....: no
# Date & Author..: 150224 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_browser_expand(p_pid)
DEFINE p_pid           LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_m             LIKE type_t.num5


   LET l_m = 1
   LET l_ac = p_pid + 1
   CALL g_browser.insertElement(l_ac)

   FOREACH master_typecur_1 USING g_browser[p_pid].b_show
      INTO g_browser[l_ac].b_show,
           g_browser[l_ac].psph016,g_browser[l_ac].chk,
           g_browser[l_ac].psph040,g_browser[l_ac].psph040_desc,
           g_browser[l_ac].psph040_desc_desc,g_browser[l_ac].psph020,
           g_browser[l_ac].pspc014,g_browser[l_ac].pspc014_desc,
           #g_browser[l_ac].psph019,g_browser[l_ac].pspc054               #170120-00041#1 mark
           g_browser[l_ac].psph031,g_browser[l_ac].pspc054                #170120-00041#1 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
#      IF cl_null(g_browser[l_ac].b_show) THEN
#         EXIT FOREACH
#      END IF
      
      CALL apsp700_fetch_detail(g_browser[l_ac].b_show,g_browser[l_ac].psph016,g_browser[l_ac].psph040)
           RETURNING g_browser[l_ac].pspc014,g_browser[l_ac].pspc054
      LET g_browser[l_ac].b_pid   = g_browser[p_pid].b_id
      LET g_browser[l_ac].b_id    = g_browser[p_pid].b_id||"."||l_m
      LET g_browser[l_ac].b_exp   = TRUE
      LET g_browser[l_ac].b_isExp = TRUE
      LET l_n = 0
      EXECUTE master_type_2 USING g_browser[l_ac].b_show INTO l_n
      IF cl_null(l_n) OR l_n = 0 THEN
         LET g_browser[l_ac].b_hasC = FALSE
      ELSE
         LET g_browser[l_ac].b_hasC = TRUE
         LET g_browser[l_ac].b_isExp = ''
      END IF
      LET l_m = l_m + 1
      LET l_ac = l_ac + 1
      CALL g_browser.insertElement(l_ac)
   END FOREACH
   
   CALL g_browser.deleteElement(l_ac)
   LET l_ac = g_browser.getLength()

END FUNCTION

################################################################################
# Descriptions...: 單別預設欄位
# Memo...........:
# Usage..........: CALL apsp700_doc_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 150226 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp700_doc_default()

   LET g_sfaa.sfaadocdt = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaadocdt',g_sfaa.sfaadocdt)
   LET g_sfaa.sfaa001 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa001',g_sfaa.sfaa001)
   LET g_sfaa.sfaa003 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa003',g_sfaa.sfaa003)
   LET g_sfaa.sfaa057 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa057',g_sfaa.sfaa057)
   LET g_sfaa.sfaa002 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa002',g_sfaa.sfaa002)
   LET g_sfaa.sfaa004 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa004',g_sfaa.sfaa004)
   LET g_sfaa.sfaastus = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaastus',g_sfaa.sfaastus)
   LET g_sfaa.sfaa005 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa005',g_sfaa.sfaa005)
   LET g_sfaa.sfaa006 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa006',g_sfaa.sfaa006)
   LET g_sfaa.sfaa007 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa007',g_sfaa.sfaa007)
   LET g_sfaa.sfaa008 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa008',g_sfaa.sfaa008)
   LET g_sfaa.sfaa063 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa063',g_sfaa.sfaa063)
   LET g_sfaa.sfaa009 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa009',g_sfaa.sfaa009)
   LET g_sfaa.sfaa022 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa022',g_sfaa.sfaa022)
   LET g_sfaa.sfaa023 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa023',g_sfaa.sfaa023)
   LET g_sfaa.sfaa024 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa024',g_sfaa.sfaa024)
   LET g_sfaa.sfaa064 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa064',g_sfaa.sfaa064)
   LET g_sfaa.sfaa021 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa021',g_sfaa.sfaa021)
   LET g_sfaa.sfaa025 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa025',g_sfaa.sfaa025)
   LET g_sfaa.sfaa010 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa010',g_sfaa.sfaa010)
   LET g_sfaa.sfaa011 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa011',g_sfaa.sfaa011)
   LET g_sfaa.sfaa012 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa012',g_sfaa.sfaa012)
   LET g_sfaa.sfaa013 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa013',g_sfaa.sfaa013)
   LET g_sfaa.sfaa058 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa058',g_sfaa.sfaa058)
   LET g_sfaa.sfaa060 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa060',g_sfaa.sfaa060)
   LET g_sfaa.sfaa061 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa061',g_sfaa.sfaa061)
   LET g_sfaa.sfaa016 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa016',g_sfaa.sfaa016)
   LET g_sfaa.sfaa017 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa017',g_sfaa.sfaa017)
   LET g_sfaa.sfaa018 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa018',g_sfaa.sfaa018)
   LET g_sfaa.sfaa019 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa019',g_sfaa.sfaa019)
   LET g_sfaa.sfaa020 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa020',g_sfaa.sfaa020)
   LET g_sfaa.sfaa014 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa014',g_sfaa.sfaa014)
   LET g_sfaa.sfaa028 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa028',g_sfaa.sfaa028)
   LET g_sfaa.sfaa015 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa015',g_sfaa.sfaa015)
   LET g_sfaa.sfaa029 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa029',g_sfaa.sfaa029)
   LET g_sfaa.sfaa026 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa026',g_sfaa.sfaa026)
   LET g_sfaa.sfaa030 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa030',g_sfaa.sfaa030)
   LET g_sfaa.sfaa031 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa031',g_sfaa.sfaa031)
   LET g_sfaa.sfaa062 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa062',g_sfaa.sfaa062)
   LET g_sfaa.sfaa032 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa032',g_sfaa.sfaa032)
   LET g_sfaa.sfaa068 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa068',g_sfaa.sfaa068)
   LET g_sfaa.sfaa033 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa033',g_sfaa.sfaa033)
   LET g_sfaa.sfaa034 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa034',g_sfaa.sfaa034)
   LET g_sfaa.sfaa035 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa035',g_sfaa.sfaa035)
   LET g_sfaa.sfaa059 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa059',g_sfaa.sfaa059)
   LET g_sfaa.sfaa036 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa036',g_sfaa.sfaa036)
   LET g_sfaa.sfaa037 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa037',g_sfaa.sfaa037)
   LET g_sfaa.sfaa038 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa038',g_sfaa.sfaa038)
   LET g_sfaa.sfaa039 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa039',g_sfaa.sfaa039)
   LET g_sfaa.sfaa040 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa040',g_sfaa.sfaa040)
   LET g_sfaa.sfaa041 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa041',g_sfaa.sfaa041)
   LET g_sfaa.sfaa042 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa042',g_sfaa.sfaa042)
   LET g_sfaa.sfaa043 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa043',g_sfaa.sfaa043)
   LET g_sfaa.sfaa044 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa044',g_sfaa.sfaa044)
   LET g_sfaa.sfaa069 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa069',g_sfaa.sfaa069)
   LET g_sfaa.sfaa070 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa070',g_sfaa.sfaa070)
   LET g_sfaa.sfaa065 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa065',g_sfaa.sfaa065)
   LET g_sfaa.sfaa045 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa045',g_sfaa.sfaa045)
   LET g_sfaa.sfaa046 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa046',g_sfaa.sfaa046)
   LET g_sfaa.sfaa049 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa049',g_sfaa.sfaa049)
   LET g_sfaa.sfaa050 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa050',g_sfaa.sfaa050)
   LET g_sfaa.sfaa047 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa047',g_sfaa.sfaa047)
   LET g_sfaa.sfaa051 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa051',g_sfaa.sfaa051)
   LET g_sfaa.sfaa048 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa048',g_sfaa.sfaa048)
   LET g_sfaa.sfaa055 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa055',g_sfaa.sfaa055)
   LET g_sfaa.sfaa056 = s_aooi200_get_doc_default(g_site,'1',g_sfaa.sfaadocno,'sfaa056',g_sfaa.sfaa056)

END FUNCTION

#end add-point
 
{</section>}
 
