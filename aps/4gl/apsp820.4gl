#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp820.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-10-14 09:15:47), PR版次:0007(2016-11-28 11:04:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: apsp820
#+ Description: 集團MRP產生工單作業
#+ Creator....: 03079(2015-01-09 17:11:18)
#+ Modifier...: 07024 -SD/PR- 08993
 
{</section>}
 
{<section id="apsp820.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#47 2016/04/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v) 
#160512-00016#12 2016/05/25 By ming     增加欄位 psgb029 保稅否
#160824-00034#2  2016/10/14 By dorislai 拿掉#160512-00016#12加的欄位(psgb029)
#161024-00057#18 2016/10/26 By Whitney  刪除insert into sfae_t相關程式
#161109-00085#17 2016/11/15 By 08993    整批調整系統星號寫法
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
 
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
                        sel               LIKE type_t.chr1,          #選擇 
                        psgb002           LIKE psgb_t.psgb002,       #料件編號  
                        psgb002_desc      LIKE imaal_t.imaal003,     #品名  
                        psgb002_desc_desc LIKE imaal_t.imaal004,     #規格  
                        psgb003           LIKE psgb_t.psgb003,       #產品特徵 
                        psgb003_desc      LIKE type_t.chr500,        #產品特徵說明 
                        #160824-00034#2-s-mark
                        ##160512-00016#12 20160525 add by ming -----(S) 
                        #psgb029           LIKE psgb_t.psgb029,       #保稅否 
                        ##160512-00016#12 20160525 add by ming -----(E) 
                        #160824-00034#2-e-mark
                        imaf013           LIKE imaf_t.imaf013,       #補給策略 
                        imaa009           LIKE imaa_t.imaa009,       #產品分類 
                        imaa009_desc      LIKE type_t.chr500,        #產品分類說明 
                        imae011           LIKE imae_t.imae011,       #生管分類 
                        imae011_desc      LIKE type_t.chr500,        #生管分類說明 
                        psgb022           LIKE psgb_t.psgb022,       #建議生產數量 
                        imae016           LIKE imae_t.imae016,       #單位 
                        imae016_desc      LIKE type_t.chr500,        #單位說明 
                        sfaa012           LIKE sfaa_t.sfaa012,       #轉工單量 
                        sfaa019           LIKE sfaa_t.sfaa019,       #預計開工日 
                        psgb004           LIKE psgb_t.psgb004,       #預計完工日 
                        imae012           LIKE imae_t.imae012,       #計畫員  
                        imae012_desc      LIKE type_t.chr500,        #計畫員說明 
                        psgb028           LIKE psgb_t.psgb028        #已轉工單 
                     END RECORD
DEFINE g_detail_d_t  type_g_detail_d 

TYPE type_tm         RECORD
                        wc                STRING,                    #QBE 
                        psfa001           LIKE psfa_t.psfa001,       #集團MRP版本 
                        psfa001_desc      LIKE type_t.chr500,
                        psfb003           LIKE psfb_t.psfb003,       #營運據點 
                        psfb003_desc      LIKE type_t.chr500,
                        ooba002           LIKE ooba_t.ooba002,       #工單單別 
                        sfaa057           LIKE sfaa_t.sfaa057,       #委外 
                        sfaa017           LIKE sfaa_t.sfaa017,       #部門/廠商 
                        check01           LIKE type_t.chr1           #顯示已轉單資料 
                     END RECORD
DEFINE tm            type_tm
DEFINE tm_o          type_tm
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE g_oobb007     LIKE oobb_t.oobb007
#mod--161109-00085#17 By 08993--(s)
#DEFINE g_sfaa        RECORD LIKE sfaa_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE g_sfaa        RECORD  #工單單頭檔
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
 
{<section id="apsp820.main" >}
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
      OPEN WINDOW w_apsp820 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp820_init()   
 
      #進入選單 Menu (="N")
      CALL apsp820_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp820
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp820.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp820_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET tm.check01 = 'N'     #顯示已轉單資料  

   CALL cl_set_combo_scc('imaf013','2022')
   CALL cl_set_combo_scc('b_imaf013','2022')
   CALL cl_set_combo_scc('sfaa057','4010')

   LET tm.sfaa057 = '1'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp820.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp820_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_site    LIKE type_t.chr10
   DEFINE l_success LIKE type_t.num5
   DEFINE l_flag    LIKE type_t.num5
   DEFINE l_ooef004 LIKE ooef_t.ooef004
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsp820_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME tm.wc ON imae012,psgb004,imaa009,
                                    imae011,psgb002,imaf013
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD imae012     #計畫員   
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imae012
               NEXT FIELD imae012

            ON ACTION controlp INFIELD imaa009     #產品分類  
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009

            ON ACTION controlp INFIELD imae011     #生管分類  
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcf011()
               DISPLAY g_qryparam.return1 TO imae011
               NEXT FIELD imae011

            ON ACTION controlp INFIELD psgb002     #料件編號  
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO psgb002 
               NEXT FIELD psgb002

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.psfa001,tm.psfb003 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD psfa001
               LET tm.psfa001_desc = ''
               DISPLAY BY NAME tm.psfa001_desc

               IF cl_null(tm.psfa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00129'     #請先輸入集團MRP版本  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(tm.psfa001) THEN
                  IF tm.psfa001 != tm_o.psfa001 OR cl_null(tm_o.psfa001) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = tm.psfa001
                     #160318-00025#47  2016/04/29  by pengxin  add(S)
                     LET g_errshow = TRUE #是否開窗 
                     LET g_chkparam.err_str[1] = "aps-00092:sub-01302|apsi800|",cl_get_progname("apsi800",g_lang,"2"),"|:EXEPROGapsi800"
                     #160318-00025#47  2016/04/29  by pengxin  add(E)
                     IF NOT cl_chk_exist("v_psfa001") THEN
                        LET tm.psfa001 = tm_o.psfa001
                        CALL apsp820_psfa001_ref(tm.psfa001)
                             RETURNING tm.psfa001_desc
                        DISPLAY BY NAME tm.psfa001_desc
                        NEXT FIELD CURRENT
                     END IF 
                     
                     LET tm.psfb003 = ''
                     LET tm.ooba002 = ''
                     LET tm_o.psfb003 = ''
                     LET tm_o.ooba002 = ''
                     LET tm.psfb003_desc = ''
                     DISPLAY BY NAME tm.psfb003,tm.ooba002,tm.psfb003_desc
                  END IF
               END IF

               LET tm_o.psfa001 = tm.psfa001

               CALL apsp820_psfa001_ref(tm.psfa001) RETURNING tm.psfa001_desc
               DISPLAY BY NAME tm.psfa001_desc

            AFTER FIELD psfb003
               LET tm.psfb003_desc = ''
               DISPLAY BY NAME tm.psfb003_desc
               IF NOT cl_null(tm.psfb003) THEN
                  IF tm.psfb003 != tm_o.psfb003 OR cl_null(tm_o.psfb003) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = tm.psfa001     #集團MRP版本 
                     LET g_chkparam.arg2 = tm.psfb003     #營運據點 
                     IF NOT cl_chk_exist("v_psfb003") THEN
                        LET tm.psfb003 = tm_o.psfb003
                        CALL apsp820_psfb003_ref(tm.psfb003)
                             RETURNING tm.psfb003_desc
                        DISPLAY BY NAME tm.psfb003_desc 
                        NEXT FIELD CURRENT
                     END IF

                     LET tm.ooba002 = ''
                     DISPLAY BY NAME tm.ooba002
                  END IF
               END IF

               LET tm_o.psfb003 = tm.psfb003
               CALL apsp820_psfb003_ref(tm.psfb003) RETURNING tm.psfb003_desc
               DISPLAY BY NAME tm.psfb003_desc

            ON ACTION controlp INFIELD psfa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.psfa001
               CALL q_psfa001()
               LET tm.psfa001 = g_qryparam.return1
               DISPLAY BY NAME tm.psfa001
               CALL apsp820_psfa001_ref(tm.psfa001) RETURNING tm.psfa001_desc
               DISPLAY BY NAME tm.psfa001_desc
               NEXT FIELD psfa001

            ON ACTION controlp INFIELD psfb003
               IF cl_null(tm.psfa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00129'      #請先輸入集團MRP版本  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD psfa001
               END IF
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.psfb003
               LET g_qryparam.arg1 = tm.psfa001
               CALL q_psfb003()
               LET tm.psfb003 = g_qryparam.return1
               DISPLAY BY NAME tm.psfb003
               CALL apsp820_psfb003_ref(tm.psfb003) RETURNING tm.psfb003_desc
               DISPLAY BY NAME tm.psfb003_desc
               NEXT FIELD psfb003

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT

         INPUT BY NAME tm.ooba002,tm.sfaa057,tm.sfaa017,tm.check01 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD ooba002
               IF NOT cl_null(tm.ooba002) THEN
                  LET l_site = g_site 
                  LET g_site = tm.psfb003

                  IF NOT s_aooi200_chk_slip(tm.psfb003,'',tm.ooba002,'asft300') THEN
                     LET g_site = l_site
                     NEXT FIELD CURRENT
                  END IF
                  LET g_site = l_site

                  LET l_ooef004 = ''
                  SELECT ooef004 INTO l_ooef004
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = tm.psfb003
                  #預設委外類型、可否修改 
                  LET g_oobb007 = ''
                  SELECT oobb005,oobb007 INTO tm.sfaa057,g_oobb007
                    FROM oobb_t
                   WHERE oobbent = g_enterprise
                     AND oobb001 = l_ooef004
                     AND oobb002 = tm.ooba002
                     AND oobb004 = 'sfaa057'
                  IF cl_null(tm.sfaa057) THEN
                     LET tm.sfaa057 = '1'
                  END IF

                  IF tm.sfaa057 <> tm_o.sfaa057 THEN
                     LET tm.sfaa017 = '' 
                     DISPLAY BY NAME tm.sfaa017
                  END IF
                  LET tm_o.sfaa057 = tm.sfaa057
               END IF

               CALL apsp820_set_entry()
               CALL apsp820_set_no_entry()

            ON CHANGE sfaa057
               IF tm.sfaa057 <> tm_o.sfaa057 THEN
                  LET tm.sfaa017 = ''
                  DISPLAY BY NAME tm.sfaa017
               END IF
               LET tm_o.sfaa057 = tm.sfaa057

            AFTER FIELD sfaa017
               IF NOT cl_null(tm.sfaa017) THEN
                  IF NOT apsp820_sfaa017_chk(tm.sfaa017) THEN
                     LET tm.sfaa017 = ''
                     DISPLAY BY NAME tm.sfaa017
                     NEXT FIELD CURRENT
                  END IF
               END IF

            ON ACTION controlp INFIELD ooba002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE 
               LET g_qryparam.default1 = tm.ooba002

               LET l_site = g_site
               LET g_site = tm.psfb003
               LET l_ooef004 = ''
               SELECT ooef004 INTO l_ooef004
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = tm.psfb003

               LET g_qryparam.arg1 = l_ooef004
               LET g_qryparam.arg2 = 'asft300'
               CALL q_ooba002_1()
               LET g_site = l_site
               LET tm.ooba002 = g_qryparam.return1
               DISPLAY BY NAME tm.ooba002
               NEXT FIELD ooba002

            ON ACTION controlp INFIELD sfaa017
               #先選擇是否委外，再決定開部門或廠商 
               IF cl_null(tm.sfaa057) THEN
                  NEXT FIELD sfaa057
               END IF
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.sfaa017 
               CASE tm.sfaa057
                  WHEN '1'
                     LET g_qryparam.arg1 = g_today
                     CALL q_ooeg001()
                  WHEN '2'
                     CALL q_pmaa001_3()
               END CASE
               LET tm.sfaa017 = g_qryparam.return1
               DISPLAY BY NAME tm.sfaa017
               NEXT FIELD sfaa017

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT

         INPUT ARRAY g_detail_d FROM s_detail1.*
               ATTRIBUTE(COUNT=g_detail_cnt,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS,
                         INSERT ROW = FALSE,
                         DELETE ROW = FALSE,
                         APPEND ROW = FALSE)
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1") 
               
               CALL apsp820_set_entry_b('',g_detail_idx)
               CALL apsp820_set_no_entry_b('',g_detail_idx)

            ON CHANGE b_sel
               IF g_detail_d[g_detail_idx].sel = 'Y' AND (g_detail_d[g_detail_idx].psgb028 = 'Y') THEN
                  CALL cl_ask_pressanykey('aps-00109')     #已產生對應的單據，無法重複執行！  
                  LET g_detail_d[g_detail_idx].sel = 'N'
               END IF

            AFTER FIELD sfaa012
               IF NOT cl_null(g_detail_d[g_detail_idx].sfaa012) THEN
                  IF g_detail_d[g_detail_idx].sfaa012 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ade-00016'     #數量不可小於等於0   
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF

                  #計畫預計開工日 
                  CALL apsp820_get_sfaa019(g_detail_d[g_detail_idx].psgb002,
                                           g_detail_d[g_detail_idx].sfaa012, 
                                           g_detail_d[g_detail_idx].psgb004)
                       RETURNING g_detail_d[g_detail_idx].sfaa019
               END IF

            AFTER ROW

            AFTER INPUT
         END INPUT 
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
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
               IF g_detail_d[li_idx].psgb028 = 'Y' THEN
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
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
               IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                  IF g_detail_d[li_idx].psgb028 = 'Y' THEN
                     LET g_detail_d[li_idx].sel = 'N'
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
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apsp820_filter()
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
            IF cl_null(tm.psfa001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'aps-00129'     #請先輸入集團MRP版本 
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD psfa001
            END IF

            IF cl_null(tm.psfb003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'agl-00291'     #營運據點不可為空  
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD psfb003
            END IF

            IF cl_null(tm.ooba002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'agl-00122'     #傳入單別為空 
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD ooba002
            END IF
            #end add-point
            CALL apsp820_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            LET g_wc_filter   = " 1=1"
            LET g_wc_filter_t = " 1=1"
            CALL apsp820_b_fill()

            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp820_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF cl_null(tm.psfa001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'aps-00129'     #請先輸入集團MRP版本   
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD psfa001
            END IF
            IF cl_null(tm.psfb003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'agl-00291'     #營運據點不可為空  
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD psfb003
            END IF
            IF cl_null(tm.ooba002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'agl-00122'     #傳入單別為空  
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD ooba002
            END IF

            CALL apsp820_batch_execute() 
            CALL apsp820_b_fill()
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
 
{<section id="apsp820.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp820_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL apsp820_b_fill()
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
 
{<section id="apsp820.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp820_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1 " END IF
   IF cl_null(g_wc_filter) THEN LET g_wc_filter = " 1=1 " END IF  #151209-00022#9 by whitney add

   LET ls_wc = ''
   IF tm.check01 = 'N' THEN
      LET ls_wc = " (psgb028 = 'N' OR psgb028 IS NULL) "
   ELSE
      LET ls_wc = " 1=1 "
   END IF
   
   #160824-00034#2-s-mod
   ##160512-00016#12 20160525 modify by ming -----(S) 
   ##LET g_sql = "SELECT 'N',psgb002,'','',psgb003,'',imaf013,imaa009,'', ", 
   #LET g_sql = "SELECT 'N',psgb002,'','',psgb003,'',psgb029,imaf013,imaa009,'', ", 
   ##160512-00016#12 20160525 modify by ming -----(E) 
   LET g_sql = "SELECT 'N',psgb002,'','',psgb003,'',imaf013,imaa009,'', ", 
   #160824-00034#2-e-mod
               "       imae011,'',psgb022,imae016,'','','',psgb004,imae012,'',psgb028 ",
               "  FROM psgb_t LEFT OUTER JOIN imae_t ON imaeent  = '",g_enterprise,"' ",
               "                                    AND imaesite = '",tm.psfb003,"' ",
               "                                    AND imae001  = psgb002 ",
               "              LEFT OUTER JOIN imaf_t ON imafent  = '",g_enterprise,"' ",
               "                                    AND imafsite = '",tm.psfb003,"' ",
               "                                    AND imaf001  = psgb002 ",
               "              LEFT OUTER JOIN imaa_t ON imaaent  = '",g_enterprise,"' ",
               "                                    AND imaa001  = psgb002 ",
               " WHERE psgbent  = ? ",
               "   AND psgb001  = '",tm.psfa001,"' ",    #MRP版本 
               "   AND psgbsite = '",tm.psfb003,"' ",    #營運據點  
               "   AND psgb022  > 0 ",
               "   AND ",tm.wc CLIPPED,
               "   AND ",ls_wc CLIPPED,
               "   AND ",g_wc_filter CLIPPED,  #151209-00022#9 by whitney add
               " ORDER BY psgb002 "
   #end add-point
 
   PREPARE apsp820_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp820_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].psgb002,g_detail_d[l_ac].psgb002_desc,
      g_detail_d[l_ac].psgb002_desc_desc,g_detail_d[l_ac].psgb003,g_detail_d[l_ac].psgb003_desc,
      #160824-00034#2-s-mark
      ##160512-00016#12 20160525 add by ming -----(S) 
      #g_detail_d[l_ac].psgb029, 
      ##160512-00016#12 20160525 add by ming -----(E) 
      #160824-00034#2-e-mark
      g_detail_d[l_ac].imaf013,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,
      g_detail_d[l_ac].imae011,g_detail_d[l_ac].imae011_desc,g_detail_d[l_ac].psgb022,
      g_detail_d[l_ac].imae016,g_detail_d[l_ac].imae016_desc,g_detail_d[l_ac].sfaa012,
      g_detail_d[l_ac].sfaa019,g_detail_d[l_ac].psgb004,g_detail_d[l_ac].imae012,
      g_detail_d[l_ac].imae012_desc,g_detail_d[l_ac].psgb028
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
      #在這裡的錯誤訊息都不要出現 
      CALL cl_err_collect_init()

      #控制組的檢查 
      CALL s_control_check_item(g_detail_d[l_ac].psgb002,'3',tm.psfb003,g_user,g_dept,tm.ooba002)
           RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_init()
         CALL cl_err_collect_show()
         CONTINUE FOREACH
      END IF

      CALL cl_err_collect_init()
      CALL cl_err_collect_show()

      #轉工單量預設為建議生產數量 
      LET g_detail_d[l_ac].sfaa012 = g_detail_d[l_ac].psgb022

      CALL apsp820_get_sfaa019(g_detail_d[l_ac].psgb002,
                               g_detail_d[l_ac].sfaa012,
                               g_detail_d[l_ac].psgb004)
           RETURNING g_detail_d[l_ac].sfaa019
      #end add-point
      
      CALL apsp820_detail_show()      
 
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
   FREE apsp820_sel
   
   LET l_ac = 1
   CALL apsp820_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp820.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp820_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsp820.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp820_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   #取品名 規格 
   CALL s_desc_get_item_desc(g_detail_d[l_ac].psgb002)
        RETURNING g_detail_d[l_ac].psgb002_desc,
                  g_detail_d[l_ac].psgb002_desc_desc

   #取得產品特徵說明 
   CALL s_feature_description(g_detail_d[l_ac].psgb002,g_detail_d[l_ac].psgb003)
        RETURNING l_success,g_detail_d[l_ac].psgb003_desc

   #取得產品分類說明 
   CALL s_desc_get_rtaxl003_desc(g_detail_d[l_ac].imaa009)
        RETURNING g_detail_d[l_ac].imaa009_desc

   #取得生管分類說明 
   CALL s_desc_get_acc_desc('204',g_detail_d[l_ac].imae011)
        RETURNING g_detail_d[l_ac].imae011_desc

   #取得單位說明 
   CALL s_desc_get_unit_desc(g_detail_d[l_ac].imae016)
        RETURNING g_detail_d[l_ac].imae016_desc

   #取得計畫員說明 
   CALL s_desc_get_person_desc(g_detail_d[l_ac].imae012)
        RETURNING g_detail_d[l_ac].imae012_desc
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp820.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp820_filter()
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
   LET l_ac = 1
   LET g_detail_cnt = 1
   
   #160824-00034#2-s-mod
   ##160512-00016#12 20160525 modify by ming -----(S) 
   ##CONSTRUCT g_wc_filter ON psgb002,psgb003,imaf013,imaa009,imae011,psgb022, 
   #CONSTRUCT g_wc_filter ON psgb002,psgb003,psgb029,imaf013,imaa009,imae011,psgb022, 
   ##160512-00016#12 20160525 modify by ming -----(E) 
   #                         imae016,sfaa012,sfaa019,psgb004,imae012,psgb028
   #     #160512-00016#12 20160525 modify by ming -----(S) 
   #     #FROM s_detail1[1].b_psgb002,s_detail1[1].b_psgb003,s_detail1[1].b_imaf013,s_detail1[1].b_imaa009, 
   #     FROM s_detail1[1].b_psgb002,s_detail1[1].b_psgb003,s_detail1[1].b_psgb029, 
   #          s_detail1[1].b_imaf013,s_detail1[1].b_imaa009, 
   #     #160512-00016#12 20160525 modify by ming -----(E) 
   #          s_detail1[1].b_imae011,s_detail1[1].b_psgb022,s_detail1[1].b_imae016,s_detail1[1].b_sfaa012,
   #          s_detail1[1].b_sfaa019,s_detail1[1].b_psgb004,s_detail1[1].b_imae012,s_detail1[1].b_psgb028
   CONSTRUCT g_wc_filter ON psgb002,psgb003,imaf013,imaa009,imae011,psgb022, 
                            imae016,sfaa012,sfaa019,psgb004,imae012,psgb028
        FROM s_detail1[1].b_psgb002,s_detail1[1].b_psgb003,s_detail1[1].b_imaf013,s_detail1[1].b_imaa009,
             s_detail1[1].b_imae011,s_detail1[1].b_psgb022,s_detail1[1].b_imae016,s_detail1[1].b_sfaa012,
             s_detail1[1].b_sfaa019,s_detail1[1].b_psgb004,s_detail1[1].b_imae012,s_detail1[1].b_psgb028
   #160824-00034#2-e-mod
   
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_psgb002        #料件編號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaf001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_psgb002  #顯示到畫面上
         NEXT FIELD b_psgb002                     #返回原欄位    
         
      ON ACTION controlp INFIELD b_imaa009        #產品分類
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_rtax001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
         NEXT FIELD b_imaa009                     #返回原欄位
         
      ON ACTION controlp INFIELD b_imae011        #生管分類
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imcf011()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imae011  #顯示到畫面上
         NEXT FIELD b_imae011                     #返回原欄位
       
      ON ACTION controlp INFIELD b_imae016        #單位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imae016  #顯示到畫面上
         NEXT FIELD b_imae016                     #返回原欄位
          
      ON ACTION controlp INFIELD b_imae012        #計畫員
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imae012  #顯示到畫面上
         NEXT FIELD b_imae012                     #返回原欄位
       
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp820_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp820.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp820_filter_parser(ps_field)
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
 
{<section id="apsp820.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp820_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp820_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp820.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apsp820_psfa001_ref(p_psfal001)
   DEFINE p_psfal001     LIKE psfal_t.psfal001
   DEFINE r_psfal003     LIKE psfal_t.psfal003

   LET r_psfal003 = ''
   SELECT psfal003 INTO r_psfal003
     FROM psfal_t
    WHERE psfalent = g_enterprise
      AND psfal001 = p_psfal001
      AND psfal002 = g_dlang

   RETURN r_psfal003
END FUNCTION

PRIVATE FUNCTION apsp820_psfb003_ref(p_psfb003)
   DEFINE p_psfb003     LIKE psfb_t.psfb003
   DEFINE r_ooefl003    LIKE ooefl_t.ooefl003

   LET r_ooefl003 = ''
   SELECT ooefl003 INTO r_ooefl003
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = p_psfb003
      AND ooefl002 = g_dlang

   RETURN r_ooefl003
END FUNCTION

PRIVATE FUNCTION apsp820_set_entry()
   CALL cl_set_comp_entry("sfaa057",TRUE)
END FUNCTION

PRIVATE FUNCTION apsp820_set_no_entry()
   IF g_oobb007 = 'N' THEN
      CALL cl_set_comp_entry("sfaa057",FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION apsp820_set_entry_b(p_cmd,p_ac)
   DEFINE p_cmd     LIKE type_t.chr1
   DEFINE p_ac      LIKE type_t.num5

   CALL cl_set_comp_entry("b_sfaa012",TRUE)
END FUNCTION

PRIVATE FUNCTION apsp820_set_no_entry_b(p_cmd,p_ac)
   DEFINE p_cmd     LIKE type_t.chr1
   DEFINE p_ac      LIKE type_t.num5

   IF g_detail_d[p_ac].psgb028 = 'Y' THEN
      CALL cl_set_comp_entry("b_sfaa012",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查部門或是廠商
# Memo...........:
# Usage..........: CALL apsp820_sfaa017_chk(p_sfaa017)
#                  RETURNING r_success
# Input parameter: p_sfaa017
# Return code....: r_success
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_sfaa017_chk(p_sfaa017)
   DEFINE p_sfaa017      LIKE sfaa_t.sfaa017
   DEFINE r_success      LIKE type_t.num5

   LET r_success = TRUE

   IF cl_null(p_sfaa017) THEN
      RETURN r_success
   END IF

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_sfaa017
   CASE tm.sfaa057
      WHEN '1'
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
# Descriptions...: 計算預計開工日
# Memo...........:
# Usage..........: CALL apsp820_get_sfaa019(p_sfaa010,p_sfaa012,p_sfaa020)
#                  RETURNING r_sfaa019
# Input parameter: p_sfaa010：生產料號 
#                : p_sfaa012：生產數量 
#                : p_sfaa020：預計完工日 
# Return code....: r_sfaa019：預計開工日 
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_get_sfaa019(p_sfaa010,p_sfaa012,p_sfaa020)
   DEFINE p_sfaa010     LIKE sfaa_t.sfaa010     #生產料號  
   DEFINE p_sfaa012     LIKE sfaa_t.sfaa012     #生產數量 
   DEFINE p_sfaa020     LIKE sfaa_t.sfaa020     #預計完工日 
   DEFINE r_sfaa019     LIKE sfaa_t.sfaa019     #預計開工日 
   DEFINE l_success     LIKE type_t.num5

   LET r_sfaa019 = ''

   IF cl_null(p_sfaa010) OR cl_null(p_sfaa012) OR cl_null(p_sfaa020) THEN
      RETURN r_sfaa019
   END IF

   CALL s_asft300_06('2',p_sfaa010,p_sfaa012,p_sfaa020)
        RETURNING l_success,r_sfaa019

   RETURN r_sfaa019
END FUNCTION

################################################################################
# Descriptions...: 將選取的資料轉成工單 
# Memo...........:
# Usage..........: CALL apsp820_batch_execute()
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_batch_execute()
   DEFINE l_sel_cnt       LIKE type_t.num5
   DEFINE l_tot_success   LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE ls_js           STRING
   DEFINE lc_param        type_parameter
   DEFINE la_param        RECORD
                             prog     STRING,
                             param    DYNAMIC ARRAY OF STRING
                          END RECORD
   DEFINE l_str           STRING
   DEFINE l_site          LIKE gzxa_t.gzxa007

   LET l_sel_cnt = 0
   LET l_success = TRUE
   LET l_tot_success = TRUE
   LET l_str = ''

   CALL s_transaction_begin()
   CALL cl_err_collect_init()

   FOR l_ac = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel = 'N' THEN
         CONTINUE FOR
      END IF

      IF NOT l_success THEN
         LET l_tot_success = FALSE
      END IF
      LET l_success = TRUE 
      
      #累計選擇的筆數 
      LET l_sel_cnt = l_sel_cnt + 1

      #產生工單 
      CALL apsp820_asft300_gen()
           RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOR
      END IF

      #更新為已轉單資料 
      UPDATE psgb_t SET psgb028 = 'Y'
       WHERE psgbent = g_enterprise
         AND psgb001 = tm.psfa001
         AND psgb002 = g_detail_d[l_ac].psgb002
         AND psgb003 = g_detail_d[l_ac].psgb003
         AND psgb004 = g_detail_d[l_ac].psgb004
         AND psgbsite = tm.psfb003 
         #AND psgb029  = g_detail_d[l_ac].psgb029     #160512-00016#12 20160525 add by ming #160824-00034#2-mark
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET l_success = FALSE

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd psgb_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         CONTINUE FOR
      END IF
      
      IF cl_null(l_str) THEN
         LET l_str = " '",g_sfaa.sfaadocno,"' "
      ELSE
         LET l_str = l_str,","," '",g_sfaa.sfaadocno,"' "
      END IF
   END FOR

   CALL cl_err_collect_show()
   IF NOT l_tot_success THEN
      LET l_success = FALSE
   END IF

   IF cl_null(l_sel_cnt) OR l_sel_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'afa-00063'
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN
         ##記錄azzi800的預設營運據點編號 
         #SELECT gzxa007 INTO l_site
         #  FROM gzxa_t
         # WHERE gzxaent = g_enterprise
         #   AND gzxa001 = g_account
         #
         ##更換營運據點 
         #UPDATE gzxa_t SET gzxa007 = tm.psfb003
         # WHERE gzxaent = g_enterprise
         #   AND gzxa001 = g_account 
         
         #切換營運據點 
         CALL FGL_SETENV("T100CROSSSITEBYPROG",tm.psfb003)

         LET la_param.prog = 'asft300'
         LET la_param.param[1] = ''
         LET la_param.param[2] = ''
         LET la_param.param[3] = "sfaadocno IN (",l_str,") "
         LET ls_js= util.JSON.stringify(la_param)
         CALL cl_cmdrun_wait(ls_js)

         ##還原預設營運據點 
         #UPDATE gzxa_t SET gzxa007 = l_site
         # WHERE gzxaent = g_enterprise
         #   AND gzxa001 = g_account 
         
         #還原營運據點  
         CALL FGL_SETENV("T100CROSSSITEBYPROG","")
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 工單產生
# Memo...........:
# Usage..........: CALL apsp820_asft300_gen()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_asft300_gen()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_num         LIKE type_t.num5
   DEFINE l_site        LIKE type_t.chr10

   LET r_success = TRUE

   #產生工單單頭 
   CALL apsp820_sfaa_ins() RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF

   #產生生產料號明細  
   CALL apsp820_sfac_ins() RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   #產生備料前要修改g_site 
   LET l_site = g_site
   LET g_site = tm.psfb003
   
   #產生備料 
   CALL s_asft300_02(g_sfaa.sfaadocno,g_sfaa.sfaa003,g_sfaa.sfaa010,
                     g_sfaa.sfaa011,g_sfaa.sfaa015,g_sfaa.sfaa012,'N')
        RETURNING r_success,l_num
   
   #還原g_site 
   LET g_site = l_site   
   
   IF NOT r_success THEN
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 工單單頭預設欄位
# Memo...........:
# Usage..........: CALL apsp820_sfaa_init()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_sfaa_init()
   DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   LET g_sfaa.sfaaent   = g_enterprise
   LET g_sfaa.sfaasite  = tm.psfb003
   LET g_sfaa.sfaaownid = g_user
   LET g_sfaa.sfaaowndp = g_dept
   LET g_sfaa.sfaacrtid = g_user
   LET g_sfaa.sfaacrtdp = g_dept
   LET g_sfaa.sfaacrtdt = cl_get_current()
   LET g_sfaa.sfaamodid = ''
   LET g_sfaa.sfaamoddt = ''
   LET g_sfaa.sfaastus  = 'N'
   LET g_sfaa.sfaadocno = tm.ooba002
   LET g_sfaa.sfaadocdt = g_today
   LET g_sfaa.sfaa001   = '0'
   LET g_sfaa.sfaa002   = g_user 
   #160512-00016#12 20160525 add by ming -----(S) 
   LET g_sfaa.sfaa003   = '1'                         #工單類型：1.一般工單
   #160512-00016#12 20160525 add by ming -----(E) 
   LET g_sfaa.sfaa005   = '3'                         #3.計畫 
   LET g_sfaa.sfaa006   = ''                          #來源單號 
   LET g_sfaa.sfaa010   = g_detail_d[l_ac].psgb002    #生產料號 
   LET g_sfaa.sfaa011   = ' '
   LET g_sfaa.sfaa012   = g_detail_d[l_ac].sfaa012
   LET g_sfaa.sfaa013   = g_detail_d[l_ac].imae016    #生產單位  
   LET g_sfaa.sfaa017   = tm.sfaa017
   LET g_sfaa.sfaa019   = g_detail_d[l_ac].sfaa019    #預計開工日 
   LET g_sfaa.sfaa020   = g_detail_d[l_ac].psgb004    #預計完工日  
   LET g_sfaa.sfaa022   = ''                          #參考原始單據 
   LET g_sfaa.sfaa038   = 'N'
   LET g_sfaa.sfaa039   = 'N' 
   LET g_sfaa.sfaa040   = 'N'
   LET g_sfaa.sfaa041   = 'N'
   LET g_sfaa.sfaa042   = 'N'
   LET g_sfaa.sfaa043   = 'N'
   LET g_sfaa.sfaa044   = 'N'
   LET g_sfaa.sfaa049   = '0'
   LET g_sfaa.sfaa050   = '0'
   LET g_sfaa.sfaa051   = '0'
   LET g_sfaa.sfaa055   = '0'
   LET g_sfaa.sfaa056   = '0'
   LET g_sfaa.sfaa057   = tm.sfaa057
   LET g_sfaa.sfaa062   = 'Y'
   LET g_sfaa.sfaa004   = '1'
   LET g_sfaa.sfaa071   = 0                           #160425-00019 by whitney add 齊料套數 
   
   #160824-00034#2-s-mod
   ##160512-00016#12 20160525 add by ming -----(S) 
   #LET g_sfaa.sfaa072   = g_detail_d[l_ac].psgb029    #保稅否 
   #IF cl_null(g_sfaa.sfaa072) THEN 
   #   LET g_sfaa.sfaa072 = 'N' 
   #END IF 
   ##160512-00016#12 20160525 add by ming -----(E) 
   LET g_sfaa.sfaa072 = 'N'
   #160824-00034#2-e-mod

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增工單單頭
# Memo...........:
# Usage..........: CALL apsp820_sfaa_ins()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_sfaa_ins()
   DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   INITIALIZE g_sfaa.* TO NULL

   #給予初始值 
   CALL apsp820_sfaa_init() RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF

   #單別預設欄位 
   CALL apsp820_sfaa_docno_default() RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF

   #自動編號 
   CALL s_aooi200_gen_docno(tm.psfb003,g_sfaa.sfaadocno,g_sfaa.sfaadocdt,'asft300')
        RETURNING r_success,g_sfaa.sfaadocno
   IF NOT r_success THEN
      RETURN r_success
   END IF

   #參考單位、參考數量  
   SELECT imaf015 INTO g_sfaa.sfaa060
     FROM imaf_t
    WHERE imafent  = g_enterprise
      AND imafsite = tm.psfb003
      AND imaf001  = g_sfaa.sfaa010
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
    WHERE imaeent  = g_enterprise
      AND imaesite = tm.psfb003
      AND imae001  = g_sfaa.sfaa010
   IF cl_null(g_sfaa.sfaa027) THEN
      LET g_sfaa.sfaa027 = 0
   END IF

   #若有使用製程，則預設料件據點資料的製程編號  
   IF g_sfaa.sfaa061 = 'Y' THEN
      SELECT imae033 INTO g_sfaa.sfaa016
        FROM imae_t
       WHERE imaeent  = g_enterprise
         AND imaesite = tm.psfb003 
         AND imae001  = g_sfaa.sfaa010
   END IF
   
   #mod--161109-00085#17 By 08993--(s)
#   INSERT INTO sfaa_t VALUES(g_sfaa.*)   #mark--161109-00085#17 By 08993--(s)
   INSERT INTO sfaa_t(sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
                      sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
                      sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
                      sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
                      sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
                      sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
                      sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
                      sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
                      sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,sfaa070,sfaaud001,sfaaud002,sfaaud003,sfaaud004,
                      sfaaud005,sfaaud006,sfaaud007,sfaaud008,sfaaud009,sfaaud010,sfaaud011,sfaaud012,sfaaud013,sfaaud014,
                      sfaaud015,sfaaud016,sfaaud017,sfaaud018,sfaaud019,sfaaud020,sfaaud021,sfaaud022,sfaaud023,sfaaud024,
                      sfaaud025,sfaaud026,sfaaud027,sfaaud028,sfaaud029,sfaaud030,sfaa071,sfaa072) 
               VALUES(g_sfaa.sfaaent,g_sfaa.sfaaownid,g_sfaa.sfaaowndp,g_sfaa.sfaacrtid,g_sfaa.sfaacrtdp,
                      g_sfaa.sfaacrtdt,g_sfaa.sfaamodid,g_sfaa.sfaamoddt,g_sfaa.sfaacnfid,g_sfaa.sfaacnfdt,
                      g_sfaa.sfaapstid,g_sfaa.sfaapstdt,g_sfaa.sfaastus,g_sfaa.sfaasite,g_sfaa.sfaadocno,
                      g_sfaa.sfaadocdt,g_sfaa.sfaa001,g_sfaa.sfaa002,g_sfaa.sfaa003,g_sfaa.sfaa004,
                      g_sfaa.sfaa005,g_sfaa.sfaa006,g_sfaa.sfaa007,g_sfaa.sfaa008,g_sfaa.sfaa009,
                      g_sfaa.sfaa010,g_sfaa.sfaa011,g_sfaa.sfaa012,g_sfaa.sfaa013,g_sfaa.sfaa014,
                      g_sfaa.sfaa015,g_sfaa.sfaa016,g_sfaa.sfaa017,g_sfaa.sfaa018,g_sfaa.sfaa019,
                      g_sfaa.sfaa020,g_sfaa.sfaa021,g_sfaa.sfaa022,g_sfaa.sfaa023,g_sfaa.sfaa024,
                      g_sfaa.sfaa025,g_sfaa.sfaa026,g_sfaa.sfaa027,g_sfaa.sfaa028,g_sfaa.sfaa029,
                      g_sfaa.sfaa030,g_sfaa.sfaa031,g_sfaa.sfaa032,g_sfaa.sfaa033,g_sfaa.sfaa034,
                      g_sfaa.sfaa035,g_sfaa.sfaa036,g_sfaa.sfaa037,g_sfaa.sfaa038,g_sfaa.sfaa039,
                      g_sfaa.sfaa040,g_sfaa.sfaa041,g_sfaa.sfaa042,g_sfaa.sfaa043,g_sfaa.sfaa044,
                      g_sfaa.sfaa045,g_sfaa.sfaa046,g_sfaa.sfaa047,g_sfaa.sfaa048,g_sfaa.sfaa049,
                      g_sfaa.sfaa050,g_sfaa.sfaa051,g_sfaa.sfaa052,g_sfaa.sfaa053,g_sfaa.sfaa054,
                      g_sfaa.sfaa055,g_sfaa.sfaa056,g_sfaa.sfaa057,g_sfaa.sfaa058,g_sfaa.sfaa059,
                      g_sfaa.sfaa060,g_sfaa.sfaa061,g_sfaa.sfaa062,g_sfaa.sfaa063,g_sfaa.sfaa064,
                      g_sfaa.sfaa065,g_sfaa.sfaa066,g_sfaa.sfaa067,g_sfaa.sfaa068,g_sfaa.sfaa069,
                      g_sfaa.sfaa070,g_sfaa.sfaaud001,g_sfaa.sfaaud002,g_sfaa.sfaaud003,g_sfaa.sfaaud004,
                      g_sfaa.sfaaud005,g_sfaa.sfaaud006,g_sfaa.sfaaud007,g_sfaa.sfaaud008,g_sfaa.sfaaud009,
                      g_sfaa.sfaaud010,g_sfaa.sfaaud011,g_sfaa.sfaaud012,g_sfaa.sfaaud013,g_sfaa.sfaaud014,
                      g_sfaa.sfaaud015,g_sfaa.sfaaud016,g_sfaa.sfaaud017,g_sfaa.sfaaud018,g_sfaa.sfaaud019,
                      g_sfaa.sfaaud020,g_sfaa.sfaaud021,g_sfaa.sfaaud022,g_sfaa.sfaaud023,g_sfaa.sfaaud024,
                      g_sfaa.sfaaud025,g_sfaa.sfaaud026,g_sfaa.sfaaud027,g_sfaa.sfaaud028,g_sfaa.sfaaud029,
                      g_sfaa.sfaaud030,g_sfaa.sfaa071,g_sfaa.sfaa072)
   #mod--161109-00085#17 By 08993--(e)

   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE

      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'ins sfaa_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單別預設欄位
# Memo...........:
# Usage..........: CALL apsp820_sfaa_docno_default()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_sfaa_docno_default()
   DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   #參考asft300，修改成取單別預設值的方式 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaadocdt',g_sfaa.sfaadocdt)
        RETURNING g_sfaa.sfaadocdt

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa001',g_sfaa.sfaa001)
        RETURNING g_sfaa.sfaa001

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa002',g_sfaa.sfaa002)
        RETURNING g_sfaa.sfaa002

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa003',g_sfaa.sfaa003)
        RETURNING g_sfaa.sfaa003

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa004',g_sfaa.sfaa004)
        RETURNING g_sfaa.sfaa004

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa005',g_sfaa.sfaa005)
        RETURNING g_sfaa.sfaa005

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa006',g_sfaa.sfaa006)
        RETURNING g_sfaa.sfaa006

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa007',g_sfaa.sfaa007)
        RETURNING g_sfaa.sfaa007

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa008',g_sfaa.sfaa008)
        RETURNING g_sfaa.sfaa008

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa009',g_sfaa.sfaa009)
        RETURNING g_sfaa.sfaa009 
        
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa010',g_sfaa.sfaa010)
        RETURNING g_sfaa.sfaa010

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa011',g_sfaa.sfaa011)
        RETURNING g_sfaa.sfaa011

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa012',g_sfaa.sfaa012)
        RETURNING g_sfaa.sfaa012

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa013',g_sfaa.sfaa013)
        RETURNING g_sfaa.sfaa013

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa014',g_sfaa.sfaa014)
        RETURNING g_sfaa.sfaa014

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa015',g_sfaa.sfaa015)
        RETURNING g_sfaa.sfaa015

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa016',g_sfaa.sfaa016)
        RETURNING g_sfaa.sfaa016

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa017',g_sfaa.sfaa017)
        RETURNING g_sfaa.sfaa017

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa018',g_sfaa.sfaa018)
        RETURNING g_sfaa.sfaa018

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa019',g_sfaa.sfaa019)
        RETURNING g_sfaa.sfaa019 
        
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa020',g_sfaa.sfaa020)
        RETURNING g_sfaa.sfaa020

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa021',g_sfaa.sfaa021)
        RETURNING g_sfaa.sfaa021

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa022',g_sfaa.sfaa022)
        RETURNING g_sfaa.sfaa022

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa023',g_sfaa.sfaa023)
        RETURNING g_sfaa.sfaa023

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa024',g_sfaa.sfaa024)
        RETURNING g_sfaa.sfaa024

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa025',g_sfaa.sfaa025)
        RETURNING g_sfaa.sfaa025

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa026',g_sfaa.sfaa026)
        RETURNING g_sfaa.sfaa026

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa028',g_sfaa.sfaa028)
        RETURNING g_sfaa.sfaa028

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa029',g_sfaa.sfaa029)
        RETURNING g_sfaa.sfaa029

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa030',g_sfaa.sfaa030)
        RETURNING g_sfaa.sfaa030 
        
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa031',g_sfaa.sfaa031)
        RETURNING g_sfaa.sfaa031

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa032',g_sfaa.sfaa032)
        RETURNING g_sfaa.sfaa032

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa033',g_sfaa.sfaa033)
        RETURNING g_sfaa.sfaa033

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa034',g_sfaa.sfaa034)
        RETURNING g_sfaa.sfaa034

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa035',g_sfaa.sfaa035)
        RETURNING g_sfaa.sfaa035

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa036',g_sfaa.sfaa036)
        RETURNING g_sfaa.sfaa036

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa037',g_sfaa.sfaa037)
        RETURNING g_sfaa.sfaa037

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa038',g_sfaa.sfaa038)
        RETURNING g_sfaa.sfaa038

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa039',g_sfaa.sfaa039)
        RETURNING g_sfaa.sfaa039

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa040',g_sfaa.sfaa040)
        RETURNING g_sfaa.sfaa040 
        
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa041',g_sfaa.sfaa041)
        RETURNING g_sfaa.sfaa041

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa042',g_sfaa.sfaa042)
        RETURNING g_sfaa.sfaa042

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa043',g_sfaa.sfaa043)
        RETURNING g_sfaa.sfaa043

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa044',g_sfaa.sfaa044)
        RETURNING g_sfaa.sfaa044

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa045',g_sfaa.sfaa045)
        RETURNING g_sfaa.sfaa045

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa046',g_sfaa.sfaa046)
        RETURNING g_sfaa.sfaa046

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa047',g_sfaa.sfaa047)
        RETURNING g_sfaa.sfaa047

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa048',g_sfaa.sfaa048)
        RETURNING g_sfaa.sfaa048

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa049',g_sfaa.sfaa049)
        RETURNING g_sfaa.sfaa049

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa050',g_sfaa.sfaa050)
        RETURNING g_sfaa.sfaa050 
        
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa051',g_sfaa.sfaa051)
        RETURNING g_sfaa.sfaa051

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa055',g_sfaa.sfaa055)
        RETURNING g_sfaa.sfaa055

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa056',g_sfaa.sfaa056)
        RETURNING g_sfaa.sfaa056

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa057',g_sfaa.sfaa057)
        RETURNING g_sfaa.sfaa057

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa058',g_sfaa.sfaa058)
        RETURNING g_sfaa.sfaa058

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa059',g_sfaa.sfaa059)
        RETURNING g_sfaa.sfaa059

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa060',g_sfaa.sfaa060)
        RETURNING g_sfaa.sfaa060

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa061',g_sfaa.sfaa061)
        RETURNING g_sfaa.sfaa061

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa062',g_sfaa.sfaa062)
        RETURNING g_sfaa.sfaa062

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa063',g_sfaa.sfaa063)
        RETURNING g_sfaa.sfaa063 
        
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa064',g_sfaa.sfaa064)
        RETURNING g_sfaa.sfaa064

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa065',g_sfaa.sfaa065)
        RETURNING g_sfaa.sfaa065

   #產生的工單生管結案狀態(sfaa065)請預設為0  
   LET g_sfaa.sfaa065 = '0'

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa068',g_sfaa.sfaa068)
        RETURNING g_sfaa.sfaa068

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa069',g_sfaa.sfaa069)
        RETURNING g_sfaa.sfaa069

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaa070',g_sfaa.sfaa070)
        RETURNING g_sfaa.sfaa070

   CALL s_aooi200_get_doc_default(tm.psfb003,'1',g_sfaa.sfaadocno,'sfaastus',g_sfaa.sfaastus)
        RETURNING g_sfaa.sfaastus

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生生產料號明細
# Memo...........:
# Usage..........: CALL apsp820_sfac_ins()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/01/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp820_sfac_ins()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_sql1        STRING
   DEFINE l_sql2        STRING
   DEFINE l_sql3        STRING
   #mod--161109-00085#17 By 08993--(s)
#   DEFINE l_sfac        RECORD LIKE sfac_t.*   #mark--161109-00085#17 By 08993--(s)
   DEFINE l_sfac        RECORD  #工單聯產品檔
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
          sfac007 LIKE sfac_t.sfac007  #保稅否
                  END RECORD
   #mod--161109-00085#17 By 08993--(e)
   DEFINE l_n           LIKE type_t.num5

   LET r_success = TRUE

   #聯產品 
   LET l_sql1 = "SELECT UNIQUE bmab003,'2',bmab004*",g_sfaa.sfaa012/100,",'',0,' ' ",
                "  FROM bmab_t ",
                " WHERE bmabent  = '",g_enterprise,"' ",
                "   AND bmabsite = '",tm.psfb003,"' ",
                "   AND bmab001  = '",g_sfaa.sfaa010,"' ",
                "   AND bmab002  = '",g_sfaa.sfaa011,"' "

   #多產出主件 
   LET l_sql2 = "SELECT UNIQUE bmad003,'3',bmad004*",g_sfaa.sfaa012,",bmad005,0,' ' ",
                "  FROM bmad_t ",
                " WHERE bmadent  = '",g_enterprise,"' ",
                "   AND bmadsite = '",tm.psfb003,"' ",
                "   AND bmad001  = '",g_sfaa.sfaa010,"' ",
                "   AND bmad002  = '",g_sfaa.sfaa011,"' "

   #副產品  
   LET l_sql3 = "SELECT UNIQUE bmac003,'5',bmac005/bmac006*",g_sfaa.sfaa012,",bmac004,0,' ' ",
                "  FROM bmac_t ",
                " WHERE bmacent  = '",g_enterprise,"' ",
                "   AND bmacsite = '",tm.psfb003,"' ",
                "   AND bmac001  = '",g_sfaa.sfaa010,"' ",
                "   AND bmac002  = '",g_sfaa.sfaa011,"' "

   LET l_sql = l_sql1," UNION ",l_sql2," UNION ",l_sql3
   PREPARE apsp820_sfac_prep FROM l_sql
   DECLARE apsp820_sfac_curs CURSOR FOR apsp820_sfac_prep

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM bmad_t
    WHERE bmadent  = g_enterprise
      AND bmadsite = tm.psfb003
      AND bmad001  = g_sfaa.sfaa010
      AND bmad002  = g_sfaa.sfaa011
   IF cl_null(l_n) OR l_n = 0 THEN
      INITIALIZE l_sfac.* TO NULL

      LET l_sfac.sfacent   = g_sfaa.sfaaent
      LET l_sfac.sfacsite  = g_sfaa.sfaasite
      LET l_sfac.sfacdocno = g_sfaa.sfaadocno 
      
      SELECT MAX(sfacseq) + 1 INTO l_sfac.sfacseq
        FROM sfac_t
       WHERE sfacent   = g_sfaa.sfaaent
         AND sfacsite  = g_sfaa.sfaasite
         AND sfacdocno = g_sfaa.sfaadocno
      IF cl_null(l_sfac.sfacseq) THEN
         LET l_sfac.sfacseq = 1
      END IF

      LET l_sfac.sfac001 = g_sfaa.sfaa010
      LET l_sfac.sfac002 = '1'
      LET l_sfac.sfac003 = g_sfaa.sfaa012
      LET l_sfac.sfac004 = g_sfaa.sfaa013
      LET l_sfac.sfac005 = 0
      LET l_sfac.sfac006 = g_detail_d[l_ac].psgb003 
      
      #160824-00034#2-s-mod
      ##160512-00016#12 20160525 add by ming -----(S) 
      #LET l_sfac.sfac007 = g_detail_d[l_ac].psgb029 
      #IF cl_null(l_sfac.sfac007) THEN 
      #   LET l_sfac.sfac007 = 'N' 
      #END IF 
      ##160512-00016#12 20160525 add by ming -----(E) 
      LET l_sfac.sfac007 = 'N' 
      #160824-00034#2-e-mod
      
      #mod--161109-00085#17 By 08993--(s)
#      INSERT INTO sfac_t VALUES(l_sfac.*)   #mark--161109-00085#17 By 08993--(s)
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfac001,sfac002,sfac003,sfac004,sfac005,sfacseq,sfac006,
                         sfacud001,sfacud002,sfacud003,sfacud004,sfacud005,sfacud006,sfacud007,sfacud008,sfacud009,sfacud010,
                         sfacud011,sfacud012,sfacud013,sfacud014,sfacud015,sfacud016,sfacud017,sfacud018,sfacud019,sfacud020,
                         sfacud021,sfacud022,sfacud023,sfacud024,sfacud025,sfacud026,sfacud027,sfacud028,sfacud029,sfacud030,sfac007) 
                  VALUES(l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfac001,l_sfac.sfac002,
                         l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfacseq,l_sfac.sfac006,
                         l_sfac.sfacud001,l_sfac.sfacud002,l_sfac.sfacud003,l_sfac.sfacud004,l_sfac.sfacud005,
                         l_sfac.sfacud006,l_sfac.sfacud007,l_sfac.sfacud008,l_sfac.sfacud009,l_sfac.sfacud010,
                         l_sfac.sfacud011,l_sfac.sfacud012,l_sfac.sfacud013,l_sfac.sfacud014,l_sfac.sfacud015,
                         l_sfac.sfacud016,l_sfac.sfacud017,l_sfac.sfacud018,l_sfac.sfacud019,l_sfac.sfacud020,
                         l_sfac.sfacud021,l_sfac.sfacud022,l_sfac.sfacud023,l_sfac.sfacud024,l_sfac.sfacud025,
                         l_sfac.sfacud026,l_sfac.sfacud027,l_sfac.sfacud028,l_sfac.sfacud029,l_sfac.sfacud030,l_sfac.sfac007)
      #mod--161109-00085#17 By 08993--(e)

      IF SQLCA.sqlcode THEN
         LET r_success = FALSE

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins sfac_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END IF 
   
   INITIALIZE l_sfac.* TO NULL

   FOREACH apsp820_sfac_curs INTO l_sfac.sfac001,l_sfac.sfac002,l_sfac.sfac003,
                                  l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH apsp820_sfac_curs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF cl_null(l_sfac.sfac001) THEN
         CONTINUE FOREACH
      END IF

      LET l_sfac.sfacent   = g_sfaa.sfaaent
      LET l_sfac.sfacsite  = g_sfaa.sfaasite
      LET l_sfac.sfacdocno = g_sfaa.sfaadocno

      SELECT MAX(sfacseq) + 1 INTO l_sfac.sfacseq
        FROM sfac_t
       WHERE sfacent   = g_sfaa.sfaaent
         AND sfacsite  = g_sfaa.sfaasite 
         AND sfacdocno = g_sfaa.sfaadocno
      IF cl_null(l_sfac.sfacseq) THEN
         LET l_sfac.sfacseq = 1
      END IF

      IF cl_null(l_sfac.sfac004) THEN
         SELECT bmaa004 INTO l_sfac.sfac004
           FROM bmaa_t
          WHERE bmaaent  = g_enterprise
            AND bmaasite = tm.psfb003
            AND bmaa001  = g_sfaa.sfaa010
            AND bmaa002  = g_sfaa.sfaa011
      END IF

      #聯產品 
      IF l_sfac.sfac002 = '2' THEN
         LET l_sfac.sfac006 = g_detail_d[l_ac].psgb003
      END IF
      
      #160512-00016#12 20160525 add by ming -----(S) 
      LET l_sfac.sfac007 = 'N' 
      #160512-00016#12 20160525 add by ming -----(E) 

      #mod--161109-00085#17 By 08993--(s)
#      INSERT INTO sfac_t VALUES(l_sfac.*)   #mark--161109-00085#17 By 08993--(s)
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfac001,sfac002,sfac003,sfac004,sfac005,sfacseq,sfac006,
                         sfacud001,sfacud002,sfacud003,sfacud004,sfacud005,sfacud006,sfacud007,sfacud008,sfacud009,sfacud010,
                         sfacud011,sfacud012,sfacud013,sfacud014,sfacud015,sfacud016,sfacud017,sfacud018,sfacud019,sfacud020,
                         sfacud021,sfacud022,sfacud023,sfacud024,sfacud025,sfacud026,sfacud027,sfacud028,sfacud029,sfacud030,sfac007) 
                  VALUES(l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfac001,l_sfac.sfac002,
                         l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfacseq,l_sfac.sfac006,
                         l_sfac.sfacud001,l_sfac.sfacud002,l_sfac.sfacud003,l_sfac.sfacud004,l_sfac.sfacud005,
                         l_sfac.sfacud006,l_sfac.sfacud007,l_sfac.sfacud008,l_sfac.sfacud009,l_sfac.sfacud010,
                         l_sfac.sfacud011,l_sfac.sfacud012,l_sfac.sfacud013,l_sfac.sfacud014,l_sfac.sfacud015,
                         l_sfac.sfacud016,l_sfac.sfacud017,l_sfac.sfacud018,l_sfac.sfacud019,l_sfac.sfacud020,
                         l_sfac.sfacud021,l_sfac.sfacud022,l_sfac.sfacud023,l_sfac.sfacud024,l_sfac.sfacud025,
                         l_sfac.sfacud026,l_sfac.sfacud027,l_sfac.sfacud028,l_sfac.sfacud029,l_sfac.sfacud030,l_sfac.sfac007)
      #mod--161109-00085#17 By 08993--(e)

      IF SQLCA.sqlcode THEN
         LET r_success = FALSE

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins sfac_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         EXIT FOREACH
      END IF

      INITIALIZE l_sfac.* TO NULL
   END FOREACH

   RETURN r_success 
   
END FUNCTION

#end add-point
 
{</section>}
 
