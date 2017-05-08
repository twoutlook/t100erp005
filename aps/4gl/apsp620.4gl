#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp620.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0026(2016-10-11 16:51:52), PR版次:0026(2016-12-09 14:14:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000222
#+ Filename...: apsp620
#+ Description: APS產生工單作業
#+ Creator....: 01588(2014-04-07 15:48:24)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp620.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151117-00019#1 特性sfaa011，抓取料件的預設BOM特性(imae037)做預設
#160316-00016#5  2016/03/23  By  dorislai  修正新增完工單後，開啟工單(asft300)的部分
#160318-00025#47 2016/04/29  By  07959     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v) 
#160512-00016#8  2016/05/23  By  ming      增加欄位psos063 保稅否  
#160608-00013#3  2016/06/21  By  ming      執行process時，先檢查有無新版本，有的話，跳出錯誤訊息「該APS版本：%1已有新一版本資料，請重新查詢後再進行處理」 
#160824-00003#1  2016/10/12  By  dorislai  生產數量(poso045)，需多扣除APS算出來的已轉工單量(psos024)
#161024-00057#15 2016/10/26  By  Whitney   刪除apsp620_sfae_ins()和sfae相關程式
#161109-00085#15 2016/11/15  By 08993      整批調整系統星號寫法
#161109-00085#61 2016/11/29  By 08171      整批調整系統星號寫法
#161101-00012#1  2016/12/02  By  dorislai  新增在勾選資料時，將資料LCOK，若資料已被其他人LOCK，跳出錯誤訊息提示
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
        psos001          LIKE psos_t.psos001,
        sfaadocno        LIKE sfaa_t.sfaadocno,
        sfaa057          LIKE sfaa_t.sfaa057,
        sfaa017          LIKE sfaa_t.sfaa017,
        l_auto_confirm   LIKE type_t.chr1,        #151209-00022 by stellar add 
        l_delay          LIKE type_t.chr1,        #延遲單據是否不產生
        l_delay_days     LIKE type_t.num5,        #延遲超過幾天的單據不產生工單
        psos057          LIKE psos_t.psos057,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel             LIKE type_t.chr1,       #選擇
     psos054         LIKE psos_t.psos054,    #料號
     psos054_desc    LIKE type_t.chr80,      #品名
     psos054_desc_1  LIKE type_t.chr80,      #規格
     psos055         LIKE psos_t.psos055,    #產品特徵 
     #160512-00016#8 20160523 add by ming -----(S)  
     psos063         LIKE psos_t.psos063,    #保稅否  
     #160512-00016#8 20160523 add by ming -----(E) 
     imaf013         LIKE imaf_t.imaf013,    #補給策略
     imaa009         LIKE imaa_t.imaa009,    #產品分類
     imaa009_desc    LIKE type_t.chr80,      #說明
     imae011         LIKE imae_t.imae011,    #生管分類
     imae011_desc    LIKE type_t.chr80,      #說明
     psos036         LIKE psos_t.psos036,    #生產數量 
     #ming 20150626 add -------------------------------(S) 
     qty             LIKE psos_t.psos036,    #本次生產數量 
     #ming 20150626 add -------------------------------(E) 
     imae016         LIKE imae_t.imae016,    #單位
     imae016_desc    LIKE type_t.chr80,      #說明
     psos012         LIKE psos_t.psos012,    #預計開工日
     psos011         LIKE psos_t.psos011,    #預計完工日
     psos021         LIKE psos_t.psos021,    #需求單號
     imae012         LIKE imae_t.imae012,    #計劃員
     imae012_desc    LIKE type_t.chr80,      #全名 
     #ming 20150626 add -------------------------------(S) 
     psos062         LIKE psos_t.psos062,    #已轉數量 
     #ming 20150626 add -------------------------------(E) 
     psos057         LIKE psos_t.psos057,    #已轉單號
     psos058         LIKE psos_t.psos058,    #產生工單單號
     psos004         LIKE psos_t.psos004,    #APS虛擬單號
     imaa006         LIKE imaa_t.imaa006     #基礎單位
                     END RECORD
                     
TYPE type_g_detail2_d RECORD 
     pspa001         LIKE pspa_t.pspa001,    #APS版本
     pspa002         LIKE pspa_t.pspa002,    #執行日期時間
     pspa012         LIKE pspa_t.pspa012,    #料號
     pspa013         LIKE pspa_t.pspa013,    #產品特徵
     pspa011         LIKE pspa_t.pspa011,    #供需日期
     pspa020         LIKE pspa_t.pspa020,    #類別
     pspa006         LIKE pspa_t.pspa006,    #單號
     pspa009         LIKE pspa_t.pspa009,    #供需數量
     quantity        LIKE pspa_t.pspa009     #預計結存量
                      END RECORD
                     
DEFINE g_detail2_cnt  LIKE type_t.num5
DEFINE g_detail2_d    DYNAMIC ARRAY OF type_g_detail2_d    
DEFINE g_param        type_parameter
DEFINE g_detail_idx   LIKE type_t.num5
DEFINE g_detail2_idx  LIKE type_t.num5
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_psos002      LIKE psos_t.psos002
DEFINE g_oobb007      LIKE type_t.chr1

#mod--161109-00085#15 By 08993--(s)
#DEFINE g_sfaa         RECORD LIKE sfaa_t.*   #mark--161109-00085#15 By 08993--(s)
DEFINE g_sfaa RECORD  #工單單頭檔
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
       #161109-00085#61 --s add
       sfaaud001 LIKE sfaa_t.sfaaud001, #自定義欄位(文字)001
       sfaaud002 LIKE sfaa_t.sfaaud002, #自定義欄位(文字)002
       sfaaud003 LIKE sfaa_t.sfaaud003, #自定義欄位(文字)003
       sfaaud004 LIKE sfaa_t.sfaaud004, #自定義欄位(文字)004
       sfaaud005 LIKE sfaa_t.sfaaud005, #自定義欄位(文字)005
       sfaaud006 LIKE sfaa_t.sfaaud006, #自定義欄位(文字)006
       sfaaud007 LIKE sfaa_t.sfaaud007, #自定義欄位(文字)007
       sfaaud008 LIKE sfaa_t.sfaaud008, #自定義欄位(文字)008
       sfaaud009 LIKE sfaa_t.sfaaud009, #自定義欄位(文字)009
       sfaaud010 LIKE sfaa_t.sfaaud010, #自定義欄位(文字)010
       sfaaud011 LIKE sfaa_t.sfaaud011, #自定義欄位(數字)011
       sfaaud012 LIKE sfaa_t.sfaaud012, #自定義欄位(數字)012
       sfaaud013 LIKE sfaa_t.sfaaud013, #自定義欄位(數字)013
       sfaaud014 LIKE sfaa_t.sfaaud014, #自定義欄位(數字)014
       sfaaud015 LIKE sfaa_t.sfaaud015, #自定義欄位(數字)015
       sfaaud016 LIKE sfaa_t.sfaaud016, #自定義欄位(數字)016
       sfaaud017 LIKE sfaa_t.sfaaud017, #自定義欄位(數字)017
       sfaaud018 LIKE sfaa_t.sfaaud018, #自定義欄位(數字)018
       sfaaud019 LIKE sfaa_t.sfaaud019, #自定義欄位(數字)019
       sfaaud020 LIKE sfaa_t.sfaaud020, #自定義欄位(數字)020
       sfaaud021 LIKE sfaa_t.sfaaud021, #自定義欄位(日期時間)021
       sfaaud022 LIKE sfaa_t.sfaaud022, #自定義欄位(日期時間)022
       sfaaud023 LIKE sfaa_t.sfaaud023, #自定義欄位(日期時間)023
       sfaaud024 LIKE sfaa_t.sfaaud024, #自定義欄位(日期時間)024
       sfaaud025 LIKE sfaa_t.sfaaud025, #自定義欄位(日期時間)025
       sfaaud026 LIKE sfaa_t.sfaaud026, #自定義欄位(日期時間)026
       sfaaud027 LIKE sfaa_t.sfaaud027, #自定義欄位(日期時間)027
       sfaaud028 LIKE sfaa_t.sfaaud028, #自定義欄位(日期時間)028
       sfaaud029 LIKE sfaa_t.sfaaud029, #自定義欄位(日期時間)029
       sfaaud030 LIKE sfaa_t.sfaaud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
END RECORD
#mod--161109-00085#15 By 08993--(e)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp620.main" >}
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
      OPEN WINDOW w_apsp620 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp620_init()   
 
      #進入選單 Menu (="N")
      CALL apsp620_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp620
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp620.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp620_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("imaf013","2022")
   CALL cl_set_combo_scc("sfaa057","4010")
   CALL cl_set_combo_scc("b_imaf013","2022")
   CALL cl_set_combo_scc("b_pspa020","5440")
   LET g_param.sfaa057 = '1'
   LET g_param.psos057 = 'N'
   LET g_errshow = 1
   LET g_detail_idx = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp620.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp620_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sfaadocno_desc   LIKE type_t.chr80
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_sfaa057_o        LIKE sfaa_t.sfaa017
   DEFINE ls_result          STRING 
   #ming 20150626 add ----------------------------(S) 
   DEFINE l_qty_o            LIKE psos_t.psos036
   #ming 20150626 add ----------------------------(E) 
   #161101-00012#1-s-add
   DEFINE l_sql              STRING
   DEFINE l_psos001          LIKE psos_t.psos001
   DEFINE l_psos002          LIKE psos_t.psos002
   DEFINE l_psos004          LIKE psos_t.psos004
   DEFINE l_cnt              LIKE type_t.num5
   #161101-00012#1-e-add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_param.l_auto_confirm = 'N'   #151209-00022 by stellar add
   LET g_ooef004 = ''
   SELECT ooef004 INTO g_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   LET l_sfaa057_o = g_param.sfaa057
   LET g_oobb007 = 'Y'
   CALL apsp620_set_entry()
   CALL apsp620_set_no_entry()
   #161101-00012#1-s-add
   CALL apsp620_cre_tmp()       
   CALL s_transaction_begin()
   #--檢查是否有被LOCK
   LET l_sql = " SELECT psos001,psos002,psos004,psos005 FROM psos_t ",
               "  WHERE psosent = ? ",
               "    AND psossite='",g_site,"'",
               "    AND psos001 = ? ",
               "    AND psos002 = ? ",
               "    AND psos004 = ? ",
               "    AND psos009 = 1 ",  #建議單據(is_new)
               "   FOR UPDATE SKIP LOCKED"
   PREPARE apsp620_chk_lock_pre FROM l_sql
   DECLARE apsp620_chk_lock_curs CURSOR FOR apsp620_chk_lock_pre
   #--LOCK
   LET l_sql = " SELECT psos001,psos002,psos004,psos005 FROM psos_t ",
               "  WHERE psosent = ? ",
               "    AND psossite='",g_site,"'",
               "    AND psos001 = ? ",
               "    AND psos002 = ? ",
               "    AND psos004 = ? ",
               "    AND psos009 = 1 ",  #建議單據(is_new)
               "   FOR UPDATE "
   DECLARE apsp620_lock_curs CURSOR FROM l_sql 
   #--抓取tmp存的資料
   LET l_sql = " SELECT psos001,psos002,psos004 FROM apsp620_tmp "
   PREPARE apsp620_tmp_pre FROM l_sql
   DECLARE apsp620_tmp_curs CURSOR FOR apsp620_tmp_pre
   #161101-00012#1-e-add
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsp620_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_param.wc ON imae012,psos012,psos011,imaa009,imae011,psos054,imaf013
         
            AFTER FIELD psos012
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)
            
            AFTER FIELD psos011
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)
         
            ON ACTION controlp INFIELD imae012
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imae012
               NEXT FIELD imae012
         
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009
               
            ON ACTION controlp INFIELD imae011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcf011()
               DISPLAY g_qryparam.return1 TO imae011
               NEXT FIELD imae011
               
            ON ACTION controlp INFIELD psos054
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO psos054
               NEXT FIELD psos054
              
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_param.psos001 ATTRIBUTE(WITHOUT DEFAULTS)
         
            AFTER FIELD psos001
               DISPLAY '' TO psos001_desc
               IF NOT cl_null(g_param.psos001) THEN
                  IF NOT apsp620_psos001_chk(g_param.psos001) THEN
                     LET g_param.psos001 = ''
                     DISPLAY BY NAME g_param.psos001
                     DISPLAY '' TO psos001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161101-00012#1-s-add
                  #抓取執行日期時間
                  SELECT MAX(psos002) INTO g_psos002
                   FROM psos_t
                  WHERE psosent = g_enterprise
                    AND psossite= g_site
                    AND psos001 = g_param.psos001
                    AND psos009 = '1'
                  #161101-00012#1-e-add
               END IF
               CALL apsp620_psos001_ref()
         
            ON ACTION controlp INFIELD psos001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.psos001
               LET g_qryparam.where = " pscasite = '",g_site,"'"
               CALL q_psca001()
               LET g_param.psos001 = g_qryparam.return1
               DISPLAY BY NAME g_param.psos001
               CALL apsp620_psos001_ref()
               NEXT FIELD psos001
         
         END INPUT
         
         INPUT BY NAME g_param.sfaadocno,g_param.sfaa057,g_param.sfaa017,g_param.l_auto_confirm,g_param.psos057   #151209-00022 by stellar add l_auto_confirm
                ATTRIBUTE(WITHOUT DEFAULTS)
               
            AFTER FIELD sfaadocno
               DISPLAY '' TO sfaadocno_desc
               IF NOT cl_null(g_param.sfaadocno) THEN
                  CALL s_aooi200_chk_slip(g_site,'',g_param.sfaadocno,'asft300')
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_param.sfaadocno = ''
                     DISPLAY BY NAME g_param.sfaadocno
                     DISPLAY '' TO sfaadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #顯示單別說明
                  CALL s_aooi200_get_slip_desc(g_param.sfaadocno)
                       RETURNING l_sfaadocno_desc
                  DISPLAY l_sfaadocno_desc TO sfaadocno_desc
                
                  #預設委外類型、可否修改
                  LET g_oobb007 = ''
                  SELECT oobb005,oobb007 INTO g_param.sfaa057,g_oobb007
                    FROM oobb_t
                   WHERE oobbent = g_enterprise
                     AND oobb001 = g_ooef004
                     AND oobb002 = g_param.sfaadocno
                     AND oobb004 = 'sfaa057'
                  IF cl_null(g_param.sfaa057) THEN
                     LET g_param.sfaa057 = '1'
                  END IF
                  IF cl_null(g_oobb007) THEN
                     LET g_oobb007 = 'Y'
                  END IF
                  IF g_param.sfaa057 <> l_sfaa057_o THEN
                     LET g_param.sfaa017 = ''
                     DISPLAY BY NAME g_param.sfaa017
                     DISPLAY '' TO sfaa017_desc
                  END IF
                  LET l_sfaa057_o = g_param.sfaa057
               END IF
               CALL apsp620_set_entry()
               CALL apsp620_set_no_entry()
               
            ON CHANGE sfaa057
               IF g_param.sfaa057 <> l_sfaa057_o THEN
                  LET g_param.sfaa017 = ''
                  DISPLAY BY NAME g_param.sfaa017
                  DISPLAY '' TO sfaa017_desc
               END IF
               LET l_sfaa057_o = g_param.sfaa057
               
            AFTER FIELD sfaa017
               DISPLAY '' TO sfaa017_desc
               IF NOT cl_null(g_param.sfaa017) THEN
                  IF NOT apsp620_sfaa017_chk(g_param.sfaa017) THEN
                     LET g_param.sfaa017 = ''
                     DISPLAY BY NAME g_param.sfaa017
                     DISPLAY '' TO sfaa017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL apsp620_sfaa017_ref()
         
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.sfaadocno
               LET g_qryparam.arg1 = g_ooef004
               LET g_qryparam.arg2 = 'asft300'
               CALL q_ooba002_1()
               LET g_param.sfaadocno = g_qryparam.return1
               DISPLAY BY NAME g_param.sfaadocno
               #顯示單別說明
               CALL s_aooi200_get_slip_desc(g_param.sfaadocno)
                    RETURNING l_sfaadocno_desc
               DISPLAY l_sfaadocno_desc TO sfaadocno_desc
               NEXT FIELD sfaadocno
               
            ON ACTION controlp INFIELD sfaa017
               #先選擇是否委外，再決定開部門或廠商的窗
               IF cl_null(g_param.sfaa057) THEN
                  NEXT FIELD sfaa057
               END IF
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.sfaa017
               CASE g_param.sfaa057 
                  WHEN '1'   #部門
                       LET g_qryparam.arg1 = g_today
                       CALL q_ooeg001()
                  WHEN '2'
                       CALL q_pmaa001_3()
               END CASE
               LET g_param.sfaa017 = g_qryparam.return1
               DISPLAY BY NAME g_param.sfaa017
               CALL apsp620_sfaa017_ref()
               NEXT FIELD sfaa017
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                    INSERT ROW = FALSE,
                    DELETE ROW = FALSE,
                    APPEND ROW = FALSE)
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1") 
               #ming 20150626 add ------------------------(S) 
               LET l_qty_o = g_detail_d[g_detail_idx].qty
               #ming 20150626 add ------------------------(E) 
               CALL apsp620_fetch()
               
            ON CHANGE b_sel
               #ming 20150626 modify --------------------------(S) 
               #IF g_detail_d[g_detail_idx].psos057 = 'Y' THEN
               IF g_detail_d[g_detail_idx].psos036 = g_detail_d[g_detail_idx].psos062 THEN
               #ming 20150626 modify --------------------------(E) 
                  IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aps-00103'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET g_detail_d[g_detail_idx].sel = 'N'
                  END IF
               END IF 
               #161101-00012#1-s-add
               IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                  LET l_psos001 = ''
                  LET l_psos002 = ''
                  LET l_psos004 = ''
                  #檢查是否有被其他使用者使用中
                  EXECUTE apsp620_chk_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[g_detail_idx].psos004 
                                                INTO l_psos001,l_psos002,l_psos004
                  IF cl_null(l_psos001) OR cl_null(l_psos002) OR cl_null(l_psos004) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'aps-00201'  #工單編號：%1，正在被其他使用者處理中
                     LET g_errparam.popup  = TRUE
                     LET g_errparam.replace[1] = g_detail_d[g_detail_idx].psos004 
                     LET g_detail_d[g_detail_idx].sel = 'N'
                     CALL cl_err()
                     NEXT FIELD b_sel 
                  END IF
                  #寫入tmp
                  INSERT INTO apsp620_tmp VALUES(g_param.psos001,g_psos002,g_detail_d[g_detail_idx].psos004)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_tmp:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD b_sel
                  END IF
                  #LOCK資料
                  OPEN apsp620_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[g_detail_idx].psos004
               ELSE
                  LET g_detail_d[g_detail_idx].sel = 'N'
                  DELETE FROM apsp620_tmp WHERE psos001=g_param.psos001 AND psos002=g_psos002 AND psos004=g_detail_d[g_detail_idx].psos004
                  CALL s_transaction_end('Y','0')
                  CLOSE apsp620_lock_curs          #釋放所有LOCK
                  IF s_transaction_chk("N",0) THEN
                     CALL s_transaction_begin()
                  END IF 
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM apsp620_tmp
                   WHERE psos001=g_param.psos001 AND psos002=g_psos002 
                  #重新LOCK
                  IF l_cnt > 0 THEN
                     LET l_psos001 = ''
                     LET l_psos002 = ''
                     LET l_psos004 = ''
                     FOREACH apsp620_tmp_curs INTO l_psos001,l_psos002,l_psos004
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "apsp620_tmp_curs:",SQLERRMESSAGE 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           EXIT FOREACH
                        END IF
                        OPEN apsp620_lock_curs USING g_enterprise,l_psos001,l_psos002,l_psos004
                     END FOREACH
                  END IF
               END IF
               #161101-00012#1-e-add
            #ming 20150626 add ----------------------------------(S) 
            AFTER FIELD b_qty
               IF NOT cl_null(g_detail_d[g_detail_idx].qty) THEN
                  IF g_detail_d[g_detail_idx].qty <= 0 THEN 
                     IF g_detail_d[g_detail_idx].psos036 <> g_detail_d[g_detail_idx].psos062 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'ade-00016'     #數量不可小於等於0 
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                        LET g_detail_d[g_detail_idx].qty = l_qty_o
                        NEXT FIELD CURRENT
                     END IF 
                  END IF

                  IF g_detail_d[g_detail_idx].qty >
                     (g_detail_d[g_detail_idx].psos036 - g_detail_d[g_detail_idx].psos062) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'asf-00337'     #數量不可大於剩餘可生產數量 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     LET g_detail_d[g_detail_idx].qty = l_qty_o
                     NEXT FIELD CURRENT
                  END IF
               END IF

               LET l_qty_o = g_detail_d[g_detail_idx].qty
            #ming 20150626 add ----------------------------------(E) 
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail2_cnt)
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
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
            CALL cl_err_collect_init()  #161101-00012#1-add
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               #161101-00012#1-s-add(搬下方的#ming 20150626 modify)
               #建議數量 = 已轉數量 時，代表已經全部轉單完畢 
               IF g_detail_d[li_idx].psos036 = g_detail_d[li_idx].psos062 THEN
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               #161101-00012#1-e-add
               #161101-00012#1-s-add
               LET l_psos001 = ''
               LET l_psos002 = ''
               LET l_psos004 = ''
               #檢查是否有被其他使用者使用中
               EXECUTE apsp620_chk_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[li_idx].psos004 
                                             INTO l_psos001,l_psos002,l_psos004
               IF cl_null(l_psos001) OR cl_null(l_psos002) OR cl_null(l_psos004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00201'  #工單編號：%1，正在被其他使用者處理中
                  LET g_errparam.popup  = TRUE
                  LET g_errparam.replace[1] = g_detail_d[li_idx].psos004 
                  LET g_detail_d[li_idx].sel = 'N'
                  CALL cl_err()
               ELSE
                  #寫入tmp
                  INSERT INTO apsp620_tmp VALUES(g_param.psos001,g_psos002,g_detail_d[li_idx].psos004)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_tmp:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD b_sel
                  END IF
                  #LOCK資料
                  OPEN apsp620_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[li_idx].psos004
               END IF
               #161101-00012#1-e-add
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            #FOR li_idx = 1 TO g_detail_d.getLength()  #161101-00012#1-mark
               #161101-00012#1-s-mark(移至上方)
               ##ming 20150626 modify ----------------------(S) 
               ##IF g_detail_d[li_idx].psos057 = 'Y' THEN
               ##    LET g_detail_d[li_idx].sel = "N"
               ##END IF
               ##建議數量 = 已轉數量 時，代表已經全部轉單完畢 
               #IF g_detail_d[li_idx].psos036 = g_detail_d[li_idx].psos062 THEN
               #   LET g_detail_d[li_idx].sel = 'N'
               #END IF
               ##ming 20150626 modify ----------------------(E) 
               #161101-00012#1-e-mark
            #END FOR  #161101-00012#1-mark
            CALL cl_err_collect_show()  #161101-00012#1-add
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               #161101-00012#1-s-add
               DELETE FROM apsp620_tmp WHERE psos001=g_param.psos001 AND psos002=g_psos002 AND psos004=g_detail_d[li_idx].psos004
               #161101-00012#1-e-add   
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            #161101-00012#1-s-add
            CALL s_transaction_end('Y','0')
            CLOSE apsp620_lock_curs          #釋放所有LOCK
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF 
            #161101-00012#1-e-add  
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  #ming 20150626 modify ---------------------------(S) 
                  #IF g_detail_d[li_idx].psos057 = 'Y' THEN
                  #   LET g_detail_d[li_idx].sel = "N"
                  #END IF
                  IF g_detail_d[li_idx].psos036 = g_detail_d[li_idx].psos062 THEN
                     LET g_detail_d[li_idx].sel = 'N'
                  END IF
                  #ming 20150626 modify ---------------------------(E) 
                  #161101-00012#1-s-add  
                  IF g_detail_d[li_idx].sel = 'Y' THEN
                     LET l_psos001 = ''
                     LET l_psos002 = ''
                     LET l_psos004 = ''
                     #檢查是否有被其他使用者使用中
                     EXECUTE apsp620_chk_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[li_idx].psos004 
                                                   INTO l_psos001,l_psos002,l_psos004
                     IF cl_null(l_psos001) OR cl_null(l_psos002) OR cl_null(l_psos004) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aps-00201'  #工單編號：%1，正在被其他使用者處理中
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_detail_d[li_idx].psos004 
                        LET g_detail_d[li_idx].sel = 'N'
                        CALL cl_err()
                        NEXT FIELD b_sel
                     END IF
                     #寫入tmp
                     INSERT INTO apsp620_tmp VALUES(g_param.psos001,g_psos002,g_detail_d[li_idx].psos004)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "ins_tmp:",SQLERRMESSAGE 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD b_sel
                     END IF
                     #LOCK資料
                     OPEN apsp620_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[li_idx].psos004
                  END IF
                  #161101-00012#1-e-add  
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
            #161101-00012#1-s-add  
            CALL s_transaction_end('Y','0')
            CLOSE apsp620_lock_curs          #釋放所有LOCK
            FOR li_idx = 1 TO g_detail_d.getLength()
               #檢查是否存在tmp中
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM apsp620_tmp
                WHERE psos001=g_param.psos001 AND psos002=g_psos002  AND psos004=g_detail_d[li_idx].psos004
               IF l_cnt > 0 THEN
                  #N->刪除資料；Y->重新LOCK
                  IF g_detail_d[li_idx].sel = "N" THEN
                     #檢查是否存在tmp中，存在的話需刪除tmp的資料(表示畫面上已經勾選掉了，但tmp資料沒刪掉)
                     DELETE FROM apsp620_tmp WHERE psos001=g_param.psos001 AND psos002=g_psos002 AND psos004=g_detail_d[li_idx].psos004
                  ELSE
                     IF s_transaction_chk("N",0) THEN
                        CALL s_transaction_begin()
                     END IF  
                     #重新LOCK
                     OPEN apsp620_lock_curs USING g_enterprise,g_param.psos001,g_psos002,g_detail_d[li_idx].psos004
                  END IF
               END IF
            END FOR
            #161101-00012#1-e-add        
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apsp620_filter()
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
            CALL apsp620_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #151209-00022 by stellar add ----- (S)
            LET g_wc_filter = " 1=1"
            LET g_wc_filter_t = " 1=1"
            CALL apsp620_b_fill()
            #151209-00022 by stellar add ----- (E)
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp620_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL s_transaction_end('Y','0')  #161101-00012#1-add
            IF cl_null(g_param.sfaadocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aps-00101'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD sfaadocno
            END IF
            CALL apsp620_batch_execute()
            CALL apsp620_query()
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
 
{<section id="apsp620.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp620_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_param.psos001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00102'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL apsp620_b_fill()
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
 
{<section id="apsp620.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp620_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_imaa006       LIKE imaa_t.imaa006
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   IF cl_null(g_param.wc) THEN
      LET g_param.wc = " 1=1"
   END IF
   
   #151209-00022 by stellar add ----- (S)
   IF NOT cl_null(g_wc_filter) THEN
      LET g_param.wc = g_param.wc CLIPPED," AND ",g_wc_filter CLIPPED
   END IF
   #151209-00022 by stellar add ----- (E)
   
   SELECT MAX(psos002) INTO g_psos002
     FROM psos_t
    WHERE psosent = g_enterprise
      AND psossite= g_site
      AND psos001 = g_param.psos001
      AND psos009 = '1'
   #160824-00003#1-s-mod  psos045多扣psos024
   ##160512-00016#8 20160523 modify by ming -----(S)    
   ##加入psos063
   ###2015/09/17 by stellar modify ----- (S)
   ###stellar修改：psos036改成psos045
   ###LET g_sql = " SELECT 'N',psos054,imaal003,imaal004,psos055,imaf013,imaa009,'',imae011,'',psos036, ",
   ##LET g_sql = " SELECT 'N',psos054,imaal003,imaal004,psos055,imaf013,imaa009,'',imae011,'',psos045, ",
   ###2015/09/17 by stellar modify ----- (E)  
   #LET g_sql = " SELECT 'N',psos054,imaal003,imaal004,psos055,COALESCE(psos063,'N'), ",
   #            "        imaf013,imaa009,'',imae011,'',psos045, ",
   ##160512-00016#8 20160523 modify by ming -----(E) 
   LET g_sql = " SELECT 'N',psos054,imaal003,imaal004,psos055,COALESCE(psos063,'N'), ",
               "        imaf013,imaa009,'',imae011,'',(psos045-psos024), ",
   #160824-00003#1-e-mod
               "        '',imae016,'',psos012,psos011,psos021,imae012,'',COALESCE(psos062,0),psos057,psos058,psos004, ",
               "        imaa006 ",
               "   FROM psos_t ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = psosent AND imaal001 = psos054 AND imaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN imaa_t ON imaaent = psosent AND imaa001 = psos054 ",
               "   LEFT OUTER JOIN imaf_t ON imafent = psosent AND imafsite= psossite AND imaf001 = psos054 ",
               "   LEFT OUTER JOIN imae_t ON imaeent = psosent AND imaesite= psossite AND imae001 = psos054 ",
               "  WHERE psosent = ? ",
               "    AND psossite='",g_site,"'",
               "    AND psos001 ='",g_param.psos001,"'",
               "    AND psos002 ='",g_psos002,"'",
               "    AND psos009 = 1 ",  #建議單據(is_new)
               "    AND ",g_param.wc CLIPPED
               
   #已轉單據是否顯示
   #ming 20150626 modify -----------------------------------(S) 
   #已轉單的判斷邏輯修改 
   #改用「已轉數量」與「建議數量」判斷 
   #當已轉數量<建議量，則為未轉單 
   #IF g_param.psos057 = 'N' THEN
   #   LET g_sql = g_sql CLIPPED," AND (psos057 = 'N' OR psos057 IS NULL) "
   #END IF
   IF g_param.psos057 = 'N' THEN
      #160824-00003#1-s-mod 多扣除psos024
      ##2015/09/17 by stellar modify ----- (S)
      ##stellar修改：psos036改成psos045
      ##LET g_sql = g_sql CLIPPED," AND (COALESCE(psos062,0) < psos036 )"
      #LET g_sql = g_sql CLIPPED," AND (COALESCE(psos062,0) < psos045 )"
      ##2015/09/17 by stellar modify ----- (E)
      LET g_sql = g_sql CLIPPED," AND (COALESCE(psos062,0) < (psos045-psos024) )"
      #160824-00003#1-e-mod
   #ELSE
   #   LET g_sql = g_sql CLIPPED," AND (COALESCE(psos062,0) = psos036 )"
   END IF
   #ming 20150626 modify -----------------------------------(E) 
   LET g_sql = g_sql CLIPPED," ORDER BY psos054,psos055 "
   #end add-point
 
   PREPARE apsp620_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp620_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].psos054,g_detail_d[l_ac].psos054_desc,g_detail_d[l_ac].psos054_desc_1,
      #160512-00016#8 20160523 modify by ming -----(S) 
      #g_detail_d[l_ac].psos055,g_detail_d[l_ac].imaf013,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,
      g_detail_d[l_ac].psos055,g_detail_d[l_ac].psos063,
      g_detail_d[l_ac].imaf013,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,
      #160512-00016#8 20160523 modify by ming -----(S) 
      g_detail_d[l_ac].imae011,g_detail_d[l_ac].imae011_desc,g_detail_d[l_ac].psos036,g_detail_d[l_ac].qty,
      g_detail_d[l_ac].imae016,
      g_detail_d[l_ac].imae016_desc,g_detail_d[l_ac].psos012,g_detail_d[l_ac].psos011,g_detail_d[l_ac].psos021,
      g_detail_d[l_ac].imae012,g_detail_d[l_ac].imae012_desc,g_detail_d[l_ac].psos062,g_detail_d[l_ac].psos057,
      g_detail_d[l_ac].psos058,
      g_detail_d[l_ac].psos004,
      g_detail_d[l_ac].imaa006
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
      #數量由基礎單位轉換為生產單位的數量
      #160316-00016#6-mod-(S) 多判斷有基礎單位&生產單位再進行轉換
#      CALL s_aooi250_convert_qty(g_detail_d[l_ac].psos054,g_detail_d[l_ac].imaa006,
#                                 g_detail_d[l_ac].imae016,g_detail_d[l_ac].psos036)
#             RETURNING l_success,g_detail_d[l_ac].psos036
      IF NOT cl_null(g_detail_d[l_ac].imaa006) AND NOT cl_null(g_detail_d[l_ac].imae016) THEN
         CALL s_aooi250_convert_qty(g_detail_d[l_ac].psos054,g_detail_d[l_ac].imaa006,
                                 g_detail_d[l_ac].imae016,g_detail_d[l_ac].psos036)
             RETURNING l_success,g_detail_d[l_ac].psos036
      END IF
      #160316-00016#6-mod-(E)       
      #預設 本次生產數量 
      #建議量-已轉數量的剩餘數量 
      LET g_detail_d[l_ac].qty = g_detail_d[l_ac].psos036 - g_detail_d[l_ac].psos062
      #end add-point
      
      CALL apsp620_detail_show()      
 
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
   FREE apsp620_sel
   
   LET l_ac = 1
   CALL apsp620_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   #161101-00012#1-s-add
   CALL s_transaction_end('Y','0')  
   IF s_transaction_chk("N",0) THEN
      CALL s_transaction_begin()
   END IF 
   #161101-00012#1-e-add
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp620.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp620_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_gzcb003       LIKE gzcb_t.gzcb003
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   
   IF g_detail_idx > g_detail_cnt THEN
      LET g_detail_idx = g_detail_cnt
   END IF
   
   IF cl_null(g_detail_idx) OR g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET g_sql = "SELECT pspa001,pspa002,pspa012,pspa013,pspa011,pspa020,pspa006,pspa009 ",
               "  FROM pspa_t ",
               " WHERE pspaent = ",g_enterprise,
               "   AND pspasite='",g_site,"'",
               "   AND pspa001 ='",g_param.psos001,"'",
               "   AND pspa002 ='",g_psos002,"'",
               "   AND pspa012 ='",g_detail_d[g_detail_idx].psos054,"'",
               "   AND NVL(pspa013,' ') = NVL('",g_detail_d[g_detail_idx].psos055,"',' ')",
               " ORDER BY pspa011 "
               
   PREPARE apsp620_sel2 FROM g_sql
   DECLARE b_fill2_curs CURSOR FOR apsp620_sel2
   
   LET l_ac = 1
   FOREACH b_fill2_curs INTO g_detail2_d[l_ac].pspa001,g_detail2_d[l_ac].pspa002,g_detail2_d[l_ac].pspa012,
                             g_detail2_d[l_ac].pspa013,g_detail2_d[l_ac].pspa011,g_detail2_d[l_ac].pspa020,
                             g_detail2_d[l_ac].pspa006,g_detail2_d[l_ac].pspa009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #數量由基礎單位轉換為生產單位的數量
      #160316-00016#5-mod-(S)
#      CALL s_aooi250_convert_qty(g_detail_d[g_detail_idx].psos054,g_detail_d[g_detail_idx].imaa006,
#                                 g_detail_d[g_detail_idx].imae016,g_detail2_d[l_ac].pspa009)
#             RETURNING l_success,g_detail2_d[l_ac].pspa009
      IF NOT cl_null(g_detail_d[g_detail_idx].imaa006) AND NOT cl_null(g_detail_d[g_detail_idx].imae016) THEN
         CALL s_aooi250_convert_qty(g_detail_d[g_detail_idx].psos054,g_detail_d[g_detail_idx].imaa006,
                                    g_detail_d[g_detail_idx].imae016,g_detail2_d[l_ac].pspa009)
                RETURNING l_success,g_detail2_d[l_ac].pspa009
      END IF
      #160316-00016#5-mod-(E)
      #抓取系統應用欄位一來決定正負
      LET l_gzcb003 = 0
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb001 = '5440'
         AND gzcb002 = g_detail2_d[l_ac].pspa020
      IF cl_null(l_gzcb003) THEN LET l_gzcb003 = 0 END IF
      
      IF l_ac = 1 THEN
         LET g_detail2_d[l_ac].quantity = g_detail2_d[l_ac].pspa009 * l_gzcb003
      ELSE
         LET g_detail2_d[l_ac].quantity = g_detail2_d[l_ac-1].quantity + (g_detail2_d[l_ac].pspa009 * l_gzcb003)
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH

   LET g_detail2_cnt = l_ac - 1
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsp620.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp620_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   #產品分類說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].imaa009
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_lang||"'",
        "") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
   
   #生管分類說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].imae011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='204' AND oocql002=? AND oocql003='"||g_lang||"'",
        "") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].imae011_desc = '', g_rtn_fields[1] , ''
   
   #單位說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].imae016
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_lang||"'",
        "") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].imae016_desc = '', g_rtn_fields[1] , ''
   
   #計劃員全名
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].imae012
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ",
        "") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].imae012_desc = '', g_rtn_fields[1] , ''
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp620.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp620_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   {  #151209-00022 by stellar add
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   }   #151209-00022 by stellar add 
   
   #151209-00022 by stellar add ----- (S)
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CONSTRUCT g_wc_filter ON psos054,psos055,imaf013,imaa009,imae011,psos036,imae016,psos012,psos011,psos021,
                            imae012,psos062,psos057,psos058,psos004
        FROM s_detail1[1].b_psos054,s_detail1[1].b_psos055,s_detail1[1].b_imaf013,s_detail1[1].b_imaa009,s_detail1[1].b_imae011,
             s_detail1[1].b_psos036,s_detail1[1].b_imae016,s_detail1[1].b_psos012,s_detail1[1].b_psos011,s_detail1[1].b_psos021,
             s_detail1[1].b_imae012,s_detail1[1].b_psos062,s_detail1[1].b_psos057,s_detail1[1].b_psos058,s_detail1[1].b_psos004
      
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_psos054
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaf001()
         DISPLAY g_qryparam.return1 TO b_psos054
         NEXT FIELD b_psos054
      
      ON ACTION controlp INFIELD b_imaa009
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_rtax001()
         DISPLAY g_qryparam.return1 TO b_imaa009
         NEXT FIELD b_imaa009
         
      ON ACTION controlp INFIELD b_imae011
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imcf011()
         DISPLAY g_qryparam.return1 TO b_imae011
         NEXT FIELD b_imae011
         
      ON ACTION controlp INFIELD b_imae016
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()
         DISPLAY g_qryparam.return1 TO b_imae016
         NEXT FIELD b_imae016
      
      ON ACTION controlp INFIELD b_imae012
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001_2()
         DISPLAY g_qryparam.return1 TO b_imae012
         NEXT FIELD b_imae012
         
      ON ACTION controlp INFIELD b_psos058
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_sfaadocno_1()
         DISPLAY g_qryparam.return1 TO b_psos058
         NEXT FIELD b_psos058
      
   END CONSTRUCT
   #151209-00022 by stellar add ----- (E)
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp620_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp620.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp620_filter_parser(ps_field)
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
 
{<section id="apsp620.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp620_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp620_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp620.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: APS版本校驗
# Memo...........:
# Usage..........: CALL apsp620_psos001_chk(p_psos001)
#                  RETURNING r_success
# Input parameter: p_psos001      APS版本
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/14 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_psos001_chk(p_psos001)
DEFINE p_psos001         LIKE psos_t.psos001
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_psos001) THEN
      RETURN r_success
   END IF

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_psos001
   #160318-00025#47  2016/04/29  by pengxin  add(S)
   LET g_errshow = TRUE #是否開窗 
   LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"
   #160318-00025#47  2016/04/29  by pengxin  add(E)
   IF NOT cl_chk_exist("v_psca001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: APS版本說明
# Memo...........:
# Usage..........: CALL apsp620_psos001_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/14 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_psos001_ref()
DEFINE l_psos001_desc    LIKE type_t.chr80

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_param.psos001
   CALL ap_ref_array2(g_ref_fields,"SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscalsite='"||g_site||"' AND pscal001=? AND pscal002='"||g_lang||"'",
       "") RETURNING g_rtn_fields
   LET l_psos001_desc = '', g_rtn_fields[1] , ''
   DISPLAY l_psos001_desc TO psos001_desc
END FUNCTION

################################################################################
# Descriptions...: 欄位可輸入
# Memo...........:
# Usage..........: CALL apsp620_set_entry()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/14 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_set_entry()

   CALL cl_set_comp_entry("sfaa057",TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉
# Memo...........:
# Usage..........: CALL apsp620_set_no_entry()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/14 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_set_no_entry()
   
   IF NOT cl_null(g_oobb007) AND g_oobb007 = 'N' THEN
      CALL cl_set_comp_entry("sfaa057",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 部門/廠商校驗
# Memo...........:
# Usage..........: CALL apsp620_sfaa017_chk(p_sfaa017)
#                  RETURNING r_success
# Input parameter: p_sfaa017      部門/廠商
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/15 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfaa017_chk(p_sfaa017)
DEFINE p_sfaa017         LIKE sfaa_t.sfaa017
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_sfaa017) THEN
      RETURN r_success
   END IF

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_sfaa017
   CASE g_param.sfaa057
      WHEN '1'   #廠內
           LET g_chkparam.arg2 = g_today
           #160318-00025#47  2016/04/29  by pengxin  add(S)
           LET g_errshow = TRUE #是否開窗 
           LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
           #160318-00025#47  2016/04/29  by pengxin  add(E)
           IF NOT cl_chk_exist("v_ooeg001") THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN '2'
           
           IF NOT cl_chk_exist("v_pmaa001_1") THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
   END CASE

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 部門/廠商說明
# Memo...........:
# Usage..........: CALL apsp620_sfaa017_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/15 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfaa017_ref()
DEFINE l_sfaa017_desc    LIKE type_t.chr80

   CASE g_param.sfaa057
      WHEN '1'   #廠內
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_param.sfaa017
           CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'",
                "") RETURNING g_rtn_fields
           LET l_sfaa017_desc = '', g_rtn_fields[1] , ''
           DISPLAY l_sfaa017_desc TO sfaa017_desc
      WHEN '2'   #委外
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_param.sfaa017
           CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'",
                "") RETURNING g_rtn_fields
           LET l_sfaa017_desc = '', g_rtn_fields[1] , ''
           DISPLAY l_sfaa017_desc TO sfaa017_desc
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 批次作業
# Memo...........:
# Usage..........: CALL apsp620_batch_execute()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_batch_execute()
DEFINE l_sel_cnt         LIKE type_t.num5
DEFINE l_tot_success     LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_str             STRING
DEFINE ls_js             STRING
DEFINE lc_param          type_parameter
DEFINE la_param          RECORD
          prog           STRING,
          param          DYNAMIC ARRAY OF STRING
                         END RECORD
DEFINE ls_js1            STRING   #151209-00022 by stellar add 
   #160608-00013#3 20160621 add by ming -----(S) 
   DEFINE l_max_psos002  LIKE psos_t.psos002 
   #160608-00013#3 20160621 add by ming -----(S) 

   #160608-00013#3 20160621 add by ming -----(S) 
   LET l_max_psos002 = '' 
   SELECT MAX(psos002) INTO l_max_psos002 
     FROM psos_t 
    WHERE psosent  = g_enterprise 
      AND psossite = g_site 
      AND psos001  = g_param.psos001
      AND psos009  = '1' 
      
   IF l_max_psos002 <> g_psos002 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'aps-00189' 
      LET g_errparam.popup  = TRUE 
      LET g_errparam.replace[1] = g_param.psos001 
      CALL cl_err() 
      
      RETURN 
   END IF 
   #160608-00013#3 20160621 add by ming -----(E) 

   LET l_sel_cnt = 0
   LET l_tot_success = TRUE
   LET l_success = TRUE
   LET l_str = ''
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   LET ls_js = util.JSON.stringify(g_param)
   
   FOR l_ac = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel = 'N' THEN
         CONTINUE FOR
      END IF
   
      IF NOT l_success THEN
         LET l_tot_success = FALSE
      END IF
      LET l_success = TRUE
      
      #累計選擇'Y'的筆數
      LET l_sel_cnt = l_sel_cnt + 1
      
      #151209-00022 by stellar modify ----- (S)
      #與apsp621共用
#      #產生工單
#      CALL apsp620_asft300_gen()
#           RETURNING l_success
#      IF NOT l_success THEN
#         CONTINUE FOR
#      END IF
#      
#      #更新已轉單據='Y'、產生工單單號=sfaadocno
#      #ming 20150626 modify ---------------------(S) 
#      #UPDATE psos_t SET psos057 = 'Y',
#      #                  psos058 = g_sfaa.sfaadocno
#      UPDATE psos_t SET psos057 = 'Y',
#                        psos058 = g_sfaa.sfaadocno,
#                        psos062 = COALESCE(psos062,0) + g_detail_d[l_ac].qty
#      #ming 20150626 modify ---------------------(E) 
#       WHERE psosent = g_enterprise
#         AND psossite= g_site
#         AND psos001 = g_param.psos001
#         AND psos002 = g_psos002
#         AND psos004 = g_detail_d[l_ac].psos004
#      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#         LET l_success = FALSE
#         
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'upd psos_t'
#         LET g_errparam.popup = TRUE
#         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
#         CALL cl_err()
#
#         CONTINUE FOR
#      END IF

      #呼叫應用元件產生工單，並更新psos_t
      LET ls_js1 = util.JSON.stringify(g_detail_d[l_ac])
      #傳入參數：APS版本、工單單別、委外、部門/廠商、單據是否確認、psos_t資料
      CALL s_apsp620_process(g_psos002,ls_js,ls_js1)
           RETURNING l_success,g_sfaa.sfaadocno
      IF NOT l_success THEN
         CONTINUE FOR
      END IF
      #151209-00022 by stellar modify ----- (E)
      
      IF cl_null(l_str) THEN
         LET l_str = " (sfaadocno = '", g_sfaa.sfaadocno,"') "
      ELSE
         LET l_str = l_str," OR (sfaadocno = '", g_sfaa.sfaadocno,"') "
      END IF
   END FOR
   
   CALL cl_err_collect_show()
   LET l_success = l_tot_success
   #160316-00016#5-add-(S) 若有成功建立工單，需讓將程式asft300開啟
   IF NOT cl_null (l_str) THEN
      LET l_success = TRUE
   END IF
   #160316-00016#5-add-(E)
   IF cl_null(l_sel_cnt) OR l_sel_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00063'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN
         LET la_param.prog = 'asft300'
         LET la_param.param[1] = ''
         LET la_param.param[2] = ''
         LET la_param.param[3] = l_str
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 工單產生
# Memo...........:
# Usage..........: CALL apsp620_asft300_gen()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/19 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_asft300_gen()
DEFINE r_success         LIKE type_t.num5
DEFINE l_num             LIKE type_t.num5

   LET r_success = TRUE
   
   #產生工單單頭
   CALL apsp620_sfaa_ins()
        RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生工單來源
   CALL apsp620_sfab_ins()
        RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生生產料號明細
   CALL apsp620_sfac_ins()
        RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生備料
   CALL s_asft300_02(g_sfaa.sfaadocno,g_sfaa.sfaa003,g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa015,
                     g_sfaa.sfaa012,'N')
        RETURNING r_success,l_num
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #取替代
   CALL apsp620_replace()
        RETURNING r_success
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 工單單頭預設欄位
# Memo...........:
# Usage..........: CALL apsp620_sfaa_init()
#                       RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/19 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfaa_init()
DEFINE r_success         LIKE type_t.num5
#2015/07/22 by stellar add ----- (S)
DEFINE l_pos1            LIKE type_t.num5
DEFINE l_pos2            LIKE type_t.num5
DEFINE ls_psos021        STRING
DEFINE l_seq             LIKE type_t.num5
DEFINE l_seq1            LIKE type_t.num5
DEFINE l_seq2            LIKE type_t.num5
DEFINE l_result          LIKE type_t.chr80
DEFINE l_result1         LIKE type_t.chr80
DEFINE l_result2         LIKE type_t.chr80
#2015/07/22 by stellar add ----- (E)
DEFINE l_doc_len         LIKE type_t.num5   #2015/08/21 by stellar add

   LET r_success = TRUE
   
   LET g_sfaa.sfaaent = g_enterprise
   LET g_sfaa.sfaasite = g_site
   LET g_sfaa.sfaaownid = g_user
   LET g_sfaa.sfaaowndp = g_dept
   LET g_sfaa.sfaacrtid = g_user
   LET g_sfaa.sfaacrtdp = g_dept
   LET g_sfaa.sfaacrtdt = cl_get_current()
   LET g_sfaa.sfaamodid = ""
   LET g_sfaa.sfaamoddt = ""
   LET g_sfaa.sfaastus = "N"
   LET g_sfaa.sfaadocno = g_param.sfaadocno
   LET g_sfaa.sfaadocdt = g_today
   LET g_sfaa.sfaa001 = "0"
   LET g_sfaa.sfaa002 = g_user
   LET g_sfaa.sfaa003 = '1'   #2015/06/08 by stellar add
   LET g_sfaa.sfaa005 = '3'   #3.計畫
   LET g_sfaa.sfaa006 = g_detail_d[l_ac].psos004
   LET g_sfaa.sfaa010 = g_detail_d[l_ac].psos054
   LET g_sfaa.sfaa011 = ' '
   #151117-00019#1-add-(S)
   SELECT imae037 INTO g_sfaa.sfaa011 
     FROM imae_t
    WHERE imaeent = g_enterprise
      AND imaesite= g_site
      AND imae001 = g_sfaa.sfaa010
   IF cl_null(g_sfaa.sfaa011) THEN
      LET g_sfaa.sfaa011 = ' '
   END IF
   #151117-00019#1-add-(E)
   #ming 20150626 modify ----------------------(S) 
   #LET g_sfaa.sfaa012 = g_detail_d[l_ac].psos036
   LET g_sfaa.sfaa012 = g_detail_d[l_ac].qty
   #ming 20150626 modify ----------------------(E) 
   LET g_sfaa.sfaa013 = g_detail_d[l_ac].imae016
   LET g_sfaa.sfaa017 = g_param.sfaa017
   LET g_sfaa.sfaa019 = g_detail_d[l_ac].psos012
   LET g_sfaa.sfaa020 = g_detail_d[l_ac].psos011
   #2015/07/22 by stellar modify ----- (S)
#   LET g_sfaa.sfaa022 = g_detail_d[l_ac].psos021
   LET ls_psos021 = g_detail_d[l_ac].psos021
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0005') RETURNING l_doc_len   #2015/08/21 by stellar add
#   IF ls_psos021.getLength() > 20 THEN         #2015/08/21 by stellar mark
   IF ls_psos021.getLength() > l_doc_len THEN   #2015/08/21 by stellar add
      LET l_pos1 = l_doc_len + 2   #2015/08/21 by stellar modify
      LET l_pos2 = ls_psos021.getIndexOf('-',l_pos1) - 1
      LET l_seq = ls_psos021.subString(l_pos1,l_pos2)
      LET l_pos1 = l_pos2 + 2
      LET l_pos2 = ls_psos021.getIndexOf('-',l_pos1) - 1
      LET l_seq1 = ls_psos021.subString(l_pos1,l_pos2)
      IF cl_null(l_seq1) THEN LET l_seq1 = 0 END IF
      LET l_pos1 = l_pos2 + 2
      LET l_pos2 = ls_psos021.getLength()
      LET l_seq2 = ls_psos021.subString(l_pos1,l_pos2)
      IF cl_null(l_seq2) THEN LET l_seq2 = 0 END IF
      SELECT LENGTH(TRIM(TRANSLATE(l_sql, '0123456789', ' '))) INTO l_result FROM DUAL
      SELECT LENGTH(TRIM(TRANSLATE(l_sql1, '0123456789', ' '))) INTO l_result1 FROM DUAL
      SELECT LENGTH(TRIM(TRANSLATE(l_sql2, '0123456789', ' '))) INTO l_result2 FROM DUAL
      IF cl_null(l_result) AND cl_null(l_result1) AND cl_null(l_result2) AND 
         NOT cl_null(l_seq) AND NOT cl_null(l_seq1) AND NOT cl_null(l_seq2) THEN
         LET g_sfaa.sfaa022 = ls_psos021.subString(1,l_doc_len)   #2015/08/21 by stellar modify
         LET g_sfaa.sfaa023 = l_seq
         LET g_sfaa.sfaa024 = l_seq1
         LET g_sfaa.sfaa064 = l_seq2
      ELSE
         LET g_sfaa.sfaa022 = g_detail_d[l_ac].psos021
      END IF
   ELSE
      LET g_sfaa.sfaa022 = g_detail_d[l_ac].psos021
   END IF
   #2015/07/22 by stellar modify ----- (E)
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
   LET g_sfaa.sfaa057 = g_param.sfaa057
   LET g_sfaa.sfaa061 = 'N'   #2015/06/05 by stellar add
   LET g_sfaa.sfaa062 = "Y"
   LET g_sfaa.sfaa004 = '1'  
   LET g_sfaa.sfaa071 = 0     #160425-00019 by whitney add 齊料套數
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增工單單頭
# Memo...........:
# Usage..........: CALL apsp620_sfaa_ins()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/19 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfaa_ins()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   INITIALIZE g_sfaa.* TO NULL
   
   #給予初始值
   CALL apsp620_sfaa_init()
        RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #單別預設欄位
   CALL apsp620_sfaa_docno_default()
        RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   #自動編號
   CALL s_aooi200_gen_docno(g_site,g_sfaa.sfaadocno,g_sfaa.sfaadocdt,'asft300')
        RETURNING r_success,g_sfaa.sfaadocno
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #參考單位、參考數量
   SELECT imaf015 INTO g_sfaa.sfaa060
     FROM imaf_t
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
   SELECT imae020 INTO g_sfaa.sfaa027
     FROM imae_t
    WHERE imaeent = g_enterprise 
      AND imaesite = g_site 
      AND imae001 = g_sfaa.sfaa010
   IF cl_null(g_sfaa.sfaa027) THEN
      LET g_sfaa.sfaa027 = 0
   END IF
   
   #若有使用製程，則預設料件據點資料的製程編號
   IF g_sfaa.sfaa061 = 'Y' THEN
      SELECT imae033 INTO g_sfaa.sfaa016 
        FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite= g_site
         AND imae001 = g_sfaa.sfaa010
   END IF
   
   INSERT INTO sfaa_t (sfaaent,sfaasite,sfaadocno,sfaa001,sfaadocdt,sfaa003,sfaa057,sfaa002,sfaa004,sfaastus,
                       sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,sfaa022,sfaa023,sfaa024,sfaa021,sfaa025,
                       sfaa010,sfaa011,sfaa012,sfaa013,sfaa058,sfaa060,sfaa061,sfaa016,sfaa017,sfaa018,
                       sfaa019,sfaa020,sfaa014,sfaa028,sfaa015,sfaa029,sfaa026,sfaa030,sfaa027,sfaa031,
                       sfaa062,sfaa032,sfaa033,sfaa034,sfaa035,sfaa059,sfaa036,sfaa037,sfaa038,sfaa039,
                       sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,sfaa045,sfaa049,sfaa046,sfaa050,sfaa047,
                       sfaa051,sfaa048,sfaa055,sfaa056,
                       sfaa064,   #2015/07/22 by stellar add
                       sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
                       sfaapstid,sfaapstdt)
      VALUES (g_sfaa.sfaaent,g_sfaa.sfaasite,g_sfaa.sfaadocno,g_sfaa.sfaa001,g_sfaa.sfaadocdt,
              g_sfaa.sfaa003,g_sfaa.sfaa057,g_sfaa.sfaa002,g_sfaa.sfaa004,g_sfaa.sfaastus,
              g_sfaa.sfaa005,g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,
              g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,g_sfaa.sfaa021,g_sfaa.sfaa025,
              g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa058,
              g_sfaa.sfaa060,g_sfaa.sfaa061,g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,
              g_sfaa.sfaa019,g_sfaa.sfaa020,g_sfaa.sfaa014,g_sfaa.sfaa028,g_sfaa.sfaa015,
              g_sfaa.sfaa029,g_sfaa.sfaa026,g_sfaa.sfaa030,g_sfaa.sfaa027,g_sfaa.sfaa031,
              g_sfaa.sfaa062,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,g_sfaa.sfaa035,
              g_sfaa.sfaa059,g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,
              g_sfaa.sfaa040,g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,
              g_sfaa.sfaa045,g_sfaa.sfaa049,g_sfaa.sfaa046,g_sfaa.sfaa050,g_sfaa.sfaa047,
              g_sfaa.sfaa051,g_sfaa.sfaa048,g_sfaa.sfaa055,g_sfaa.sfaa056,
              g_sfaa.sfaa064,   #2015/07/22 by stellar add
              g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,g_sfaa.sfaacrtdp,g_sfaa.sfaacrtdt,
              g_sfaa.sfaamodid,g_sfaa.sfaamoddt,g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,g_sfaa.sfaapstid,
              g_sfaa.sfaapstdt)
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins sfaa_t"
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單別預設欄位
# Memo...........:
# Usage..........: CALL apsp620_sfaa_docno_default()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/19 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfaa_docno_default()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   #2015/02/24 by stellar modify ----- (S)
#   #預設工單類型
#   SELECT oobb005 INTO g_sfaa.sfaa003 
#     FROM oobb_t
#    WHERE oobbent = g_enterprise
#      AND oobb001 = g_ooef004
#      AND oobb002 = g_sfaa.sfaadocno
#      AND oobb004 = 'sfaa003'
#   IF cl_null(g_sfaa.sfaa003) THEN
#      LET g_sfaa.sfaa003 = '1'
#   END IF
#   
#   #預設製程否
#   LET g_sfaa.sfaa061 = cl_get_doc_para(g_enterprise,g_site,g_sfaa.sfaadocno,'D-MFG-0041')
#   IF cl_null(g_sfaa.sfaa061) THEN
#      LET g_sfaa.sfaa061 = 'N'
#   END IF
#   
#   #預設FQC否
#   LET g_sfaa.sfaa044 = cl_get_doc_para(g_enterprise,g_site,g_sfaa.sfaadocno,'D-MFG-0042')
#   IF cl_null(g_sfaa.sfaa044) THEN
#      LET g_sfaa.sfaa044 = 'N'
#   END IF

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
   #2015/02/24 by stellar modify ----- (E)
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取替代
# Memo...........:
# Usage..........: CALL apsp620_replace()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/05/20 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_replace()
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#15 By 08993--(s)
#DEFINE l_psot            RECORD LIKE psot_t.*   #mark--161109-00085#15 By 08993--(s)
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
#mod--161109-00085#15 By 08993--(e)
DEFINE l_sfba013         LIKE sfba_t.sfba013
#mod--161109-00085#15 By 08993--(s)
#DEFINE l_sfba            RECORD LIKE sfba_t.*   #mark--161109-00085#15 By 08993--(s)
DEFINE l_sfba RECORD  #工單備料單身檔
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
       #161109-00085#61 --s add
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
       #161109-00085#61 --e add
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035  #SET替代套數
END RECORD
#mod--161109-00085#15 By 08993--(e)

DEFINE l_bmea011         LIKE bmea_t.bmea011
DEFINE l_bmea012         LIKE bmea_t.bmea012

   LET r_success = TRUE
   
   DECLARE apsp620_replace_cs CURSOR FOR
    #mod--161109-00085#15 By 08993--(s)
#    SELECT * FROM psot_t   #mark--161109-00085#15 By 08993--(s)
    SELECT psotent,psotsite,psot001,psot002,psot003,psot004,psot005,psot006,psot007,psot008,psot009,psot010,
           psot011,psot012,psot013,psot014,psot015,psot016,psot017,psot018,psot019,psot020,psot021,psot022,
           psot023,psot024,psot025,psot026,psot027,psot028,psot029,psot030,psot031,psot032,psot033,psot034,
           psot035,psot036,psot037,psot038,psot039,psot040,psot041,psot042,psot043 
     FROM psot_t
    #mod--161109-00085#15 By 08993--(e)
     WHERE psotent = g_enterprise
       AND psotsite= g_site
       AND psot001 = g_param.psos001
       AND psot002 = g_psos002
       AND psot003 = g_detail_d[l_ac].psos004
       AND psot015 <> psot020   #原主料料號psot015<>元件品號psot020
   #mod--161109-00085#15 By 08993--(s)
#   FOREACH apsp620_replace_cs INTO l_psot.*   #mark--161109-00085#15 By 08993--(s)
   FOREACH apsp620_replace_cs INTO l_psot.psotent,l_psot.psotsite,l_psot.psot001,l_psot.psot002,l_psot.psot003,
                                   l_psot.psot004,l_psot.psot005,l_psot.psot006,l_psot.psot007,l_psot.psot008,
                                   l_psot.psot009,l_psot.psot010,l_psot.psot011,l_psot.psot012,l_psot.psot013,
                                   l_psot.psot014,l_psot.psot015,l_psot.psot016,l_psot.psot017,l_psot.psot018,
                                   l_psot.psot019,l_psot.psot020,l_psot.psot021,l_psot.psot022,l_psot.psot023,
                                   l_psot.psot024,l_psot.psot025,l_psot.psot026,l_psot.psot027,l_psot.psot028,
                                   l_psot.psot029,l_psot.psot030,l_psot.psot031,l_psot.psot032,l_psot.psot033,
                                   l_psot.psot034,l_psot.psot035,l_psot.psot036,l_psot.psot037,l_psot.psot038,
                                   l_psot.psot039,l_psot.psot040,l_psot.psot041,l_psot.psot042,l_psot.psot043
   #mod--161109-00085#15 By 08993--(e)
      
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
      #mod--161109-00085#15 By 08993--(s)
#      SELECT * INTO l_sfba.*   #mark--161109-00085#15 By 08993--(s)
      SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005,sfba006,
             sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015,sfba016,sfba017,sfba018,
             sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,sfba029,sfba030,
             sfba031,sfba032,sfba033,sfba034,sfba035 
        INTO l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba001,l_sfba.sfba002,
             l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,
             l_sfba.sfba010,l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,l_sfba.sfba016,
             l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,
             l_sfba.sfba024,l_sfba.sfba025,l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028,l_sfba.sfba029,l_sfba.sfba030,
             l_sfba.sfba031,l_sfba.sfba032,l_sfba.sfba033,l_sfba.sfba034,l_sfba.sfba035
      #mod--161109-00085#15 By 08993--(e)
      #161109-00085#61 下面INSERT INTO本身有展開,這裡不再展開自定義
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
      LET l_sfba.sfba006=l_psot.psot020
      LET l_sfba.sfba007=0
      LET l_sfba.sfba010=0
      LET l_sfba.sfba011=0
      LET l_sfba.sfba012=0
      LET l_sfba.sfba015=0
      LET l_sfba.sfba016=0
      LET l_sfba.sfba017=0
      LET l_sfba.sfba018=0
      SELECT bmea011,bmea012,bmea013 INTO l_bmea011,l_bmea012,l_sfba.sfba014
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
      #20150916 DSC.liquor add--------
      IF cl_null(l_sfba.sfba022) THEN
         LET l_sfba.sfba022 = 1
      END IF
      #20150916 DSC.liquor add end----
      #2014/10/30 by stellar modify ----------- (S)
#      LET l_sfba.sfba013 = l_psot.psot033 * l_sfba.sfba022
      LET l_sfba.sfba013 = l_psot.psot012
      #2014/10/30 by stellar modify ----------- (E)
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
      
      INSERT INTO sfba_t (sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,
                    sfba002,sfba003,sfba004,sfba005,sfba022,
                    sfba006,sfba021,sfba007,sfba008,sfba009,
                    sfba010,sfba011,sfba012,sfba023,sfba024,
                    sfba013,sfba014,sfba015,sfba016,sfba025,
                    sfba017,sfba018,sfba019,sfba020,sfba028,
                    sfba001,sfba026,sfba027)
         VALUES(l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
                l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,l_sfba.sfba022,
                l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,
                l_sfba.sfba010,l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba023,l_sfba.sfba024,
                l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,l_sfba.sfba016,l_sfba.sfba025,
                l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba028,
                l_sfba.sfba001,l_sfba.sfba026,l_sfba.sfba027)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfba_t"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      #2015/09/17 by stellar add ----- (S)
      #由替代量推算被替代量後，計算項次0的應發數量
      LET l_sfba013 = l_sfba013 - (l_psot.psot012/l_sfba.sfba022)
      #2015/09/17 by stellar add ----- (E)
      
#      UPDATE sfba_t SET sfba013 = l_sfba013 - l_psot.psot033   #2015/09/17 by stellar mark
      UPDATE sfba_t SET sfba013 = l_sfba013                     #2015/09/17 by stellar add
       WHERE sfbaent = l_sfba.sfbaent 
         AND sfbasite= l_sfba.sfbasite
         AND sfbadocno = l_sfba.sfbadocno
         AND sfbaseq = l_sfba.sfbaseq
         AND sfbaseq1= 0
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd sfba013"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
         CALL cl_err()
         
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生生產料號明細
# Memo...........:
# Usage..........: CALL apsp620_sfac_ins()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/09/18 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfac_ins()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_sql1            STRING
DEFINE l_sql2            STRING
DEFINE l_sql3            STRING
#mod--161109-00085#15 By 08993--(s)
#DEFINE l_sfac            RECORD LIKE sfac_t.*   #mark--161109-00085#15 By 08993--(s)
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
       #161109-00085#61 --s add
       sfacud001 LIKE sfac_t.sfacud001, #自定義欄位(文字)001
       sfacud002 LIKE sfac_t.sfacud002, #自定義欄位(文字)002
       sfacud003 LIKE sfac_t.sfacud003, #自定義欄位(文字)003
       sfacud004 LIKE sfac_t.sfacud004, #自定義欄位(文字)004
       sfacud005 LIKE sfac_t.sfacud005, #自定義欄位(文字)005
       sfacud006 LIKE sfac_t.sfacud006, #自定義欄位(文字)006
       sfacud007 LIKE sfac_t.sfacud007, #自定義欄位(文字)007
       sfacud008 LIKE sfac_t.sfacud008, #自定義欄位(文字)008
       sfacud009 LIKE sfac_t.sfacud009, #自定義欄位(文字)009
       sfacud010 LIKE sfac_t.sfacud010, #自定義欄位(文字)010
       sfacud011 LIKE sfac_t.sfacud011, #自定義欄位(數字)011
       sfacud012 LIKE sfac_t.sfacud012, #自定義欄位(數字)012
       sfacud013 LIKE sfac_t.sfacud013, #自定義欄位(數字)013
       sfacud014 LIKE sfac_t.sfacud014, #自定義欄位(數字)014
       sfacud015 LIKE sfac_t.sfacud015, #自定義欄位(數字)015
       sfacud016 LIKE sfac_t.sfacud016, #自定義欄位(數字)016
       sfacud017 LIKE sfac_t.sfacud017, #自定義欄位(數字)017
       sfacud018 LIKE sfac_t.sfacud018, #自定義欄位(數字)018
       sfacud019 LIKE sfac_t.sfacud019, #自定義欄位(數字)019
       sfacud020 LIKE sfac_t.sfacud020, #自定義欄位(數字)020
       sfacud021 LIKE sfac_t.sfacud021, #自定義欄位(日期時間)021
       sfacud022 LIKE sfac_t.sfacud022, #自定義欄位(日期時間)022
       sfacud023 LIKE sfac_t.sfacud023, #自定義欄位(日期時間)023
       sfacud024 LIKE sfac_t.sfacud024, #自定義欄位(日期時間)024
       sfacud025 LIKE sfac_t.sfacud025, #自定義欄位(日期時間)025
       sfacud026 LIKE sfac_t.sfacud026, #自定義欄位(日期時間)026
       sfacud027 LIKE sfac_t.sfacud027, #自定義欄位(日期時間)027
       sfacud028 LIKE sfac_t.sfacud028, #自定義欄位(日期時間)028
       sfacud029 LIKE sfac_t.sfacud029, #自定義欄位(日期時間)029
       sfacud030 LIKE sfac_t.sfacud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       sfac007 LIKE sfac_t.sfac007  #保稅否
          END RECORD
#mod--161109-00085#15 By 08993--(e)

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
   PREPARE apsp620_sfac_pre FROM l_sql
   DECLARE apsp620_sfac_cs CURSOR FOR apsp620_sfac_pre
   
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
      LET l_sfac.sfac006 = g_detail_d[l_ac].psos055
      #20150905 DSCliquor add-----
      IF cl_null(l_sfac.sfac006) THEN
         LET l_sfac.sfac006 = ' '
      END IF
      #20150905 DSC.liquor add end-----
      
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,
                         sfac001,sfac002,sfac003,sfac004,sfac005,sfac006)
         VALUES(l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfacseq,
                l_sfac.sfac001,l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,
                l_sfac.sfac006)
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfac_t"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
         CALL cl_err()
         
         RETURN r_success
      END IF
   END IF
   
   INITIALIZE l_sfac.* TO NULL
   
   FOREACH apsp620_sfac_cs INTO l_sfac.sfac001,l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,
                                l_sfac.sfac006
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH apsp620_sfac_cs:"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
         CALL cl_err()
         
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
         SELECT bmaa004 INTO l_sfac.sfac004 
           FROM bmaa_t
          WHERE bmaaent = g_enterprise
            AND bmaasite= g_site
            AND bmaa001 = g_sfaa.sfaa010
            AND bmaa002 = g_sfaa.sfaa011
      END IF
      
      #聯產品
      IF l_sfac.sfac002 = '2' THEN
         LET l_sfac.sfac006 = g_detail_d[l_ac].psos055
      END IF
      #20150905 DSCliquor add-----
      IF cl_null(l_sfac.sfac006) THEN
         LET l_sfac.sfac006 = ' '
      END IF
      #20150905 DSC.liquor add end-----
      
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,
                         sfac001,sfac002,sfac003,sfac004,sfac005,sfac006)
         VALUES(l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfacseq,
                l_sfac.sfac001,l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,
                l_sfac.sfac006)
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfac_t"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      INITIALIZE l_sfac.* TO NULL
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生工單來源
# Memo...........:
# Usage..........: CALL apsp620_sfab_ins()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/09/18 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_sfab_ins()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfabseq,
                      sfab001,sfab002,sfab003,sfab004,sfab005,sfab006,sfab007)
      VALUES(g_sfaa.sfaaent,g_sfaa.sfaasite,g_sfaa.sfaadocno,1,
             g_sfaa.sfaa005,g_detail_d[l_ac].psos004,'','','',1,g_sfaa.sfaa012)
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
         
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins sfab_t"
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = g_detail_d[l_ac].psos004
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   RETURN r_success
 
END FUNCTION

################################################################################
# Descriptions...: 建立tmp
# Memo...........:
# Usage..........: CALL apsp620_cre_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/1 By dorislai (#161101-00012#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp620_cre_tmp()
   DROP TABLE apsp620_tmp
   CREATE TEMP TABLE apsp620_tmp(
      psos001   LIKE  psos_t.psos001,  #APS版本 
      psos002   LIKE  psos_t.psos002,  #執行日期時間
      psos004   LIKE  psos_t.psos004   #工單編號
   )
END FUNCTION

#end add-point
 
{</section>}
 
