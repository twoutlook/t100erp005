#該程式未解開Section, 採用最新樣板產出!
{<section id="apjp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-08-18 18:08:37), PR版次:0004(2017-02-17 17:12:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: apjp100
#+ Description: 專案材料轉請購作業
#+ Creator....: 01534(2015-07-28 17:44:11)
#+ Modifier...: 01534 -SD/PR- 01996
 
{</section>}
 
{<section id="apjp100.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#31   2016/04/11  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...:   No.161124-00048#14   2016/12/15  By 08734    星号整批调整
#+ Modifier...:   No.160711-00040#23   2017/02/16  By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                                            CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
          sel                  LIKE type_t.chr1,
          pjbd005              LIKE pjbd_t.pjbd005,
          pjbd005_desc         LIKE type_t.chr500,
          pjbd005_desc_desc    LIKE type_t.chr500,
          pjbd004              LIKE pjbd_t.pjbd004,
          pjbd004_desc         LIKE type_t.chr500,
          imaf141              LIKE imaf_t.imaf141,
          imaf141_desc         LIKE type_t.chr500,
          pjbd006              LIKE pjbd_t.pjbd006,
          pjbd006_desc         LIKE type_t.chr500, 
          pjbd007              LIKE pjbd_t.pjbd007,
          pjbd011              LIKE pjbd_t.pjbd011,  
          dz_pmdb006           LIKE pmdb_t.pmdb006,
          pmdb006              LIKE pmdb_t.pmdb006, 
          pmdb030              LIKE pmdb_t.pmdb030,
          pmda002              LIKE pmda_t.pmda002,
          pmda002_desc         LIKE type_t.chr500,
          pjbd001              LIKE pjbd_t.pjbd001,
          pjbd001_desc         LIKE type_t.chr500,
          pjbd002              LIKE pjbd_t.pjbd002,
          pjbd002_desc         LIKE type_t.chr500,
          pjbd003              LIKE pjbd_t.pjbd003
      END RECORD  
DEFINE  g_detail_d_t           type_g_detail_d   
DEFINE  g_pmdadocno            LIKE pmda_t.pmdadocno 
DEFINE  g_pmdadocno_t          LIKE pmda_t.pmdadocno 
DEFINE  g_pmda002              LIKE pmda_t.pmda002
DEFINE  g_pmda003              LIKE pmda_t.pmda003
DEFINE  g_pmda002_t            LIKE pmda_t.pmda002
DEFINE  g_pmda003_t            LIKE pmda_t.pmda003
DEFINE  g_pmdadocno_desc       LIKE type_t.chr500
DEFINE  g_pmda002_desc         LIKE type_t.chr500
DEFINE  g_pmda003_desc         LIKE type_t.chr500
DEFINE  g_pjbd001              LIKE pmda_t.pmda012
DEFINE  g_pmda002_1            LIKE pmda_t.pmda012
DEFINE  g_pjbd004              LIKE pmda_t.pmda012
DEFINE  g_imaf141              LIKE pmda_t.pmda012
DEFINE  l_ooef004              LIKE ooef_t.ooef004
DEFINE  g_rec_b                LIKE type_t.num10
#DEFINE  g_pmda                 RECORD LIKE pmda_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE g_pmda RECORD  #請購單單頭頭檔
       pmdaent LIKE pmda_t.pmdaent, #企業編號
       pmdaownid LIKE pmda_t.pmdaownid, #資料所有者
       pmdaowndp LIKE pmda_t.pmdaowndp, #資料所屬部門
       pmdacrtid LIKE pmda_t.pmdacrtid, #資料建立者
       pmdacrtdp LIKE pmda_t.pmdacrtdp, #資料建立部門
       pmdacrtdt LIKE pmda_t.pmdacrtdt, #資料創建日
       pmdamodid LIKE pmda_t.pmdamodid, #資料修改者
       pmdamoddt LIKE pmda_t.pmdamoddt, #最近修改日
       pmdacnfid LIKE pmda_t.pmdacnfid, #資料確認者
       pmdacnfdt LIKE pmda_t.pmdacnfdt, #資料確認日
       pmdapstid LIKE pmda_t.pmdapstid, #資料過帳者
       pmdapstdt LIKE pmda_t.pmdapstdt, #資料過帳日
       pmdastus LIKE pmda_t.pmdastus, #狀態碼
       pmdasite LIKE pmda_t.pmdasite, #營運據點
       pmdadocno LIKE pmda_t.pmdadocno, #請購單號
       pmdadocdt LIKE pmda_t.pmdadocdt, #請購日期
       pmda001 LIKE pmda_t.pmda001, #版次
       pmda002 LIKE pmda_t.pmda002, #請購人員
       pmda003 LIKE pmda_t.pmda003, #請購部門
       pmda004 LIKE pmda_t.pmda004, #單價為必要輸入
       pmda005 LIKE pmda_t.pmda005, #幣別
       pmda006 LIKE pmda_t.pmda006, #No Use
       pmda007 LIKE pmda_t.pmda007, #費用部門
       pmda008 LIKE pmda_t.pmda008, #請購總未稅金額
       pmda009 LIKE pmda_t.pmda009, #請購總含稅金額
       pmda010 LIKE pmda_t.pmda010, #稅別
       pmda011 LIKE pmda_t.pmda011, #稅率
       pmda012 LIKE pmda_t.pmda012, #單價含稅否
       pmda020 LIKE pmda_t.pmda020, #納入APS計算
       pmda021 LIKE pmda_t.pmda021, #運送方式
       pmda022 LIKE pmda_t.pmda022, #備註
       pmda200 LIKE pmda_t.pmda200, #來源類型
       pmda201 LIKE pmda_t.pmda201, #採購方式
       pmda202 LIKE pmda_t.pmda202, #所屬品類
       pmda203 LIKE pmda_t.pmda203, #需求組織
       pmda204 LIKE pmda_t.pmda204, #採購中心
       pmda205 LIKE pmda_t.pmda205, #配送中心
       pmda206 LIKE pmda_t.pmda206, #配送倉
       pmda207 LIKE pmda_t.pmda207, #到貨日期
       pmda208 LIKE pmda_t.pmda208, #包裝總數量
       pmda900 LIKE pmda_t.pmda900, #保留欄位str
       pmda999 LIKE pmda_t.pmda999, #保留欄位end
       pmda023 LIKE pmda_t.pmda023, #留置原因
       pmda024 LIKE pmda_t.pmda024, #送貨地址
       pmda025 LIKE pmda_t.pmda025, #帳款地址
       pmda209 LIKE pmda_t.pmda209, #包裝總金額
       pmda210 LIKE pmda_t.pmda210, #品種數
       pmda211 LIKE pmda_t.pmda211, #需求時間
       pmda027 LIKE pmda_t.pmda027, #前端單號
       pmda028 LIKE pmda_t.pmda028 #前端類型
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
#DEFINE  g_pmdb                 RECORD LIKE pmdb_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE g_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企業編號
       pmdbsite LIKE pmdb_t.pmdbsite, #營運據點
       pmdbdocno LIKE pmdb_t.pmdbdocno, #請購單號
       pmdbseq LIKE pmdb_t.pmdbseq, #項次
       pmdb001 LIKE pmdb_t.pmdb001, #來源單號
       pmdb002 LIKE pmdb_t.pmdb002, #來源項次
       pmdb003 LIKE pmdb_t.pmdb003, #來源項序
       pmdb004 LIKE pmdb_t.pmdb004, #料件編號
       pmdb005 LIKE pmdb_t.pmdb005, #產品特徵
       pmdb006 LIKE pmdb_t.pmdb006, #需求數量
       pmdb007 LIKE pmdb_t.pmdb007, #單位
       pmdb008 LIKE pmdb_t.pmdb008, #參考數量
       pmdb009 LIKE pmdb_t.pmdb009, #參考單位
       pmdb010 LIKE pmdb_t.pmdb010, #計價數量
       pmdb011 LIKE pmdb_t.pmdb011, #計價單位
       pmdb012 LIKE pmdb_t.pmdb012, #包裝容器
       pmdb014 LIKE pmdb_t.pmdb014, #供應商選擇
       pmdb015 LIKE pmdb_t.pmdb015, #供應商編號
       pmdb016 LIKE pmdb_t.pmdb016, #付款條件
       pmdb017 LIKE pmdb_t.pmdb017, #交易條件
       pmdb018 LIKE pmdb_t.pmdb018, #稅率
       pmdb019 LIKE pmdb_t.pmdb019, #參考單價
       pmdb020 LIKE pmdb_t.pmdb020, #參考未稅金額
       pmdb021 LIKE pmdb_t.pmdb021, #參考含稅金額
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由碼
       pmdb032 LIKE pmdb_t.pmdb032, #行狀態
       pmdb033 LIKE pmdb_t.pmdb033, #緊急度
       pmdb034 LIKE pmdb_t.pmdb034, #專案編號
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活動編號
       pmdb037 LIKE pmdb_t.pmdb037, #收貨據點
       pmdb038 LIKE pmdb_t.pmdb038, #收貨庫位
       pmdb039 LIKE pmdb_t.pmdb039, #收貨儲位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允許部份交貨
       pmdb042 LIKE pmdb_t.pmdb042, #允許提前交貨
       pmdb043 LIKE pmdb_t.pmdb043, #保稅
       pmdb044 LIKE pmdb_t.pmdb044, #納入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期凍結否
       pmdb046 LIKE pmdb_t.pmdb046, #費用部門
       pmdb048 LIKE pmdb_t.pmdb048, #收貨時段
       pmdb049 LIKE pmdb_t.pmdb049, #已轉採購量
       pmdb050 LIKE pmdb_t.pmdb050, #備註
       pmdb051 LIKE pmdb_t.pmdb051, #結案/留置理由碼
       pmdb200 LIKE pmdb_t.pmdb200, #商品條碼
       pmdb201 LIKE pmdb_t.pmdb201, #包裝單位
       pmdb202 LIKE pmdb_t.pmdb202, #件裝數
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送倉庫
       pmdb205 LIKE pmdb_t.pmdb205, #採購中心
       pmdb206 LIKE pmdb_t.pmdb206, #採購員
       pmdb207 LIKE pmdb_t.pmdb207, #採購方式
       pmdb208 LIKE pmdb_t.pmdb208, #經營方式
       pmdb209 LIKE pmdb_t.pmdb209, #結算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促銷開始日
       pmdb211 LIKE pmdb_t.pmdb211, #促銷結束日
       pmdb212 LIKE pmdb_t.pmdb212, #要貨件數
       pmdb250 LIKE pmdb_t.pmdb250, #合理庫存
       pmdb251 LIKE pmdb_t.pmdb251, #最高庫存
       pmdb252 LIKE pmdb_t.pmdb252, #現有庫存
       pmdb253 LIKE pmdb_t.pmdb253, #入庫在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一週銷量
       pmdb255 LIKE pmdb_t.pmdb255, #前二週銷量
       pmdb256 LIKE pmdb_t.pmdb256, #前三週銷量
       pmdb257 LIKE pmdb_t.pmdb257, #前四週銷量
       pmdb258 LIKE pmdb_t.pmdb258, #要貨在途量
       pmdb259 LIKE pmdb_t.pmdb259, #週平均銷量
       pmdb900 LIKE pmdb_t.pmdb900, #保留欄位str
       pmdb999 LIKE pmdb_t.pmdb999, #保留欄位end
       pmdb260 LIKE pmdb_t.pmdb260, #收貨部門
       pmdb052 LIKE pmdb_t.pmdb052, #來源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #補貨規格說明
       pmdb053 LIKE pmdb_t.pmdb053, #預算細項
       pmdb213 LIKE pmdb_t.pmdb213, #參考進價
       pmdb054 LIKE pmdb_t.pmdb054, #庫存管理特徵
       pmdb214 LIKE pmdb_t.pmdb214 #需求時間
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE  g_status               LIKE type_t.num5
DEFINE  l_pjbd                 type_g_detail_d
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjp100.main" >}
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
   CALL cl_ap_init("apj","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjp100 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apjp100_init()   
 
      #進入選單 Menu (="N")
      CALL apjp100_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apjp100
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apjp100_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apjp100.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apjp100_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
   
   DROP TABLE apjp100_tmp;
   CREATE TEMP TABLE apjp100_tmp(
          sel                   VARCHAR(1),
          pjbd005               VARCHAR(40),
          pjbd005_desc          VARCHAR(500),
          pjbd005_desc_desc     VARCHAR(500),
          imaa009               VARCHAR(10),
          pjbd004_desc          VARCHAR(500),
          imaf141               VARCHAR(10),
          imaf141_desc          VARCHAR(500),
          pjbd006               VARCHAR(10),
          pjbd006_desc          VARCHAR(500), 
          pjbd007               DECIMAL(20,6),
          pjbd011               DECIMAL(20,6),  
          dz_pmdb006            DECIMAL(20,6),
          pmdb006               DECIMAL(20,6), 
          pmdb030               DATE,
          imaf142               VARCHAR(20),
          pmda002_desc          VARCHAR(500),
          pjbd001               VARCHAR(20),
          pjbd001_desc          VARCHAR(500),
          pjbd002               VARCHAR(30),
          pjbd002_desc          VARCHAR(500),
          pjbd003               INTEGER
   );     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apjp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apjp100_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sql1                 STRING   #160711-00040#23 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_errshow = 1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apjp100_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pjbd001,pjbd002,imaa009,imaf141,pjbd005
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD pjbd001
               #add-point:ON ACTION controlp INFIELD pjbn001
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		  	      LET g_qryparam.reqry = FALSE
               CALL q_pjba001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pjbd001      #顯示到畫面上
               NEXT FIELD pjbd001
               
            ON ACTION controlp INFIELD pjbd002
               #add-point:ON ACTION controlp INFIELD pjbo002
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_pjbb002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pjbd002      #顯示到畫面上
           
               NEXT FIELD pjbd002                         #返回原欄位     
        
            ON ACTION controlp INFIELD imaa009
               #add-point:ON ACTION controlp INFIELD pjbo002
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009      #顯示到畫面上
           
               NEXT FIELD imaa009                        #返回原欄位 
                              
            ON ACTION controlp INFIELD imaf141
               #add-point:ON ACTION controlp INFIELD pjbo002
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_imce141()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf141      #顯示到畫面上
           
               NEXT FIELD imaf141                         #返回原欄位 
               
            ON ACTION controlp INFIELD pjbd005
               #add-point:ON ACTION controlp INFIELD pjbo002
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_imaf001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pjbd005      #顯示到畫面上
           
               NEXT FIELD pjbd005                         #返回原欄位 
               
         END CONSTRUCT
         

         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_pmdadocno,g_pmda002,g_pmda003 FROM pmdadocno,pmda002,pmda003 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
            
               IF cl_null(g_pmda002) THEN LET g_pmda002 = g_user END IF
               IF cl_null(g_pmda003) THEN LET g_pmda003 = g_dept END IF
               CALL s_desc_get_person_desc(g_pmda002) RETURNING g_pmda002_desc
               DISPLAY g_pmda002_desc TO pmda002_desc     
               CALL s_desc_get_department_desc(g_pmda003) RETURNING g_pmda003_desc
               DISPLAY g_pmda003_desc TO pmda003_desc                
               DISPLAY g_pmda002 TO pmda002
               DISPLAY g_pmda003 TO pmda003
               
            AFTER FIELD pmdadocno
            
               CALL s_aooi200_get_slip_desc(g_pmdadocno) RETURNING g_pmdadocno_desc
               DISPLAY BY NAME g_pmdadocno_desc
               
               IF NOT cl_null(g_pmdadocno) THEN                      
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用
                  CALL s_control_chk_doc('1',g_pmdadocno,'3',g_pmda002,g_pmda003,'','') RETURNING l_success,l_flag
                  IF l_success THEN
                     IF NOT l_flag THEN
                        #CALL cl_err(g_pmdadocno,'apm-00254',1)
                        LET g_pmdadocno = g_pmdadocno_t
                        CALL s_aooi200_get_slip_desc(g_pmdadocno) RETURNING g_pmdadocno_desc
                        DISPLAY BY NAME g_pmdadocno_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET g_pmdadocno = g_pmdadocno_t
                     CALL s_aooi200_get_slip_desc(g_pmdadocno) RETURNING g_pmdadocno_desc
                     DISPLAY BY NAME g_pmdadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
#                  #依據輸入的單別抓取單別的[C:預算控管]參數值，預設給pmda006(預算控管)
#                  CALL cl_get_doc_para(g_enterprise,g_site,g_pmdadocno,'D-COM-0002') RETURNING g_pmda_m.pmda006
#                  IF cl_null(g_pmda_m.pmda006) THEN
#                     LET g_pmda_m.pmda006 = 'N'
#                  END IF
#                  
#                  DISPLAY BY NAME g_pmda_m.pmda006
                  
                  IF NOT s_aooi200_chk_slip(g_site,'',g_pmdadocno,'apmt400') THEN
                     LET g_pmdadocno = g_pmdadocno_t
                     CALL s_aooi200_get_slip_desc(g_pmdadocno) RETURNING g_pmdadocno_desc
                     DISPLAY BY NAME g_pmdadocno_desc
                     NEXT FIELD CURRENT   
                  END IF
               END IF   
               
            AFTER FIELD pmda002
               CALL s_desc_get_person_desc(g_pmda002) RETURNING g_pmda002_desc
               DISPLAY g_pmda002_desc TO pmda002_desc
               IF NOT cl_null(g_pmda002) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmda002
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#31  add
              
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_pmda003 FROM ooag_t
                      WHERE ooag001 = g_pmda002 AND ooagent = g_enterprise
                     DISPLAY g_pmda003 TO pmda003
              
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmda002 = g_pmda002_t
                     CALL s_desc_get_person_desc(g_pmda002) RETURNING g_pmda002_desc
                     DISPLAY g_pmda002_desc TO pmda002_desc
                     NEXT FIELD CURRENT
                  END IF             
               END IF  
               CALL s_desc_get_person_desc(g_pmda002) RETURNING g_pmda002_desc
               DISPLAY g_pmda002_desc TO pmda002_desc            
               LET g_pmda002_t = g_pmda002
               
            AFTER FIELD pmda003
               CALL s_desc_get_department_desc(g_pmda003) RETURNING g_pmda003_desc
               DISPLAY g_pmda003_desc TO pmda003_desc 
               IF NOT cl_null(g_pmda003) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmda003
                  LET g_chkparam.arg2 = g_today
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#31  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
              
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmda003 = g_pmda003_t
                     CALL s_desc_get_department_desc(g_pmda003) RETURNING g_pmda003_desc
                     DISPLAY g_pmda003_desc TO pmda003_desc     
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               CALL s_desc_get_department_desc(g_pmda003) RETURNING g_pmda003_desc
               DISPLAY g_pmda003_desc TO pmda003_desc                
               LET g_pmda003_t = g_pmda003

            ON ACTION controlp INFIELD pmdadocno          
           
	            INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	            LET g_qryparam.reqry = FALSE
           
               LET g_qryparam.default1 = g_pmdadocno             #給予default值
           
               #給予arg
               LET g_qryparam.arg1 = l_ooef004 #
               LET g_qryparam.arg2 = 'apmt400'
               #160711-00040#23 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#23 add(e)
               CALL q_ooba002_1()                                #呼叫開窗
           
               LET g_pmdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
           
               DISPLAY g_pmdadocno TO pmdadocno              #顯示到畫面上
               CALL s_aooi200_get_slip_desc(g_pmdadocno) RETURNING g_pmdadocno_desc
               DISPLAY BY NAME g_pmdadocno_desc
           
               NEXT FIELD pmdadocno                          #返回原欄位
               
                  
            ON ACTION controlp INFIELD pmda002
               #add-point:ON ACTION controlp INFIELD pjbo010
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_pmda002             #給予default值
   		      	
               CALL q_ooag001()                       #呼叫開窗  
            
               LET g_pmda002 = g_qryparam.return1
            
               DISPLAY g_pmda002 TO pmda002           #
            
               NEXT FIELD pmda002                #返回原欄位          

            ON ACTION controlp INFIELD pmda003
               #add-point:ON ACTION controlp INFIELD pjbo010
               #此段落由子樣板a08產生
               #開窗c段
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE 
		      	LET g_qryparam.default1 = g_pmda003             #給予default值
		      	LET g_qryparam.arg1 = g_today
               CALL q_ooeg001()                                #呼叫開窗		      	
               LET g_pmda003 = g_qryparam.return1
               
               DISPLAY g_pmda003 TO pmda003           #
                       
               NEXT FIELD pmda003   
               
         END INPUT
         
         INPUT g_pjbd001,g_pmda002_1,g_pjbd004,g_imaf141 FROM l_pjbd001,l_pmda002,l_pjbd004,l_imaf141 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
            
            AFTER FIELD l_pjbd001
            
               IF cl_null(g_pjbd001) THEN
               
               END IF
               
            AFTER INPUT
            
         END INPUT    

         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
                    
            #自訂ACTION(detail_input,page_2)
            
            
            BEFORE INPUT
               IF cl_null(g_pmdadocno) THEN
                  NEXT FIELD pmdadocno
               END IF
               
            BEFORE ROW

               LET l_ac = ARR_CURR()  
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
               AFTER FIELD pmdb006
                  #確認欄位值在特定區間內
                  IF NOT cl_ap_chk_range(g_detail_d[l_ac].pmdb006,"0.000","0","","","azz-00079",1) THEN
                     NEXT FIELD pmdb006
                  END IF 
                  IF NOT cl_null(g_detail_d[l_ac].pmdb006) AND NOT cl_null(g_detail_d[l_ac].dz_pmdb006) THEN
                     IF g_detail_d[l_ac].pmdb006 > g_detail_d[l_ac].dz_pmdb006 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apj-00053'
                        LET g_errparam.extend = g_detail_d[l_ac].pmdb006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()  
                        LET g_detail_d[l_ac].pmdb006 = g_detail_d_t.pmdb006                        
                        NEXT FIELD pmdb006                  
                     END IF
                  END IF
                  LET g_detail_d_t.pmdb006 = g_detail_d[l_ac].pmdb006 
                  
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
            LET g_pjbd001 = 'N'
            LET g_pmda002_1 = 'N'
            LET g_pjbd004 = 'N'
            LET g_imaf141 = 'N'
            DISPLAY g_pjbd001 TO l_pjbd001
            DISPLAY g_pmda002_1 TO l_pmda002
            DISPLAY g_pjbd004 TO l_pjbd004
            DISPLAY g_imaf141 TO l_imaf141
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
            CALL apjp100_filter()
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
            CALL apjp100_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apjp100_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute    
            CALL apjp100_gene_pmda_pmdb()
            CALL apjp100_b_fill()
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
 
{<section id="apjp100.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apjp100_query()
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
   CALL apjp100_b_fill()
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
 
{<section id="apjp100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apjp100_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_str           STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
   
   LET g_sql = " SELECT DISTINCT 'Y',pjbd005,'','',imaa009,'',imaf141,'',pjbd006,'',pjbd007,pjbd011,0,0,pjbb005,imaf142,'',pjbd001,'',pjbd002,'',pjbd003 FROM pjbd_t ",
               "   LEFT OUTER JOIN imaf_t ON pjbdent = imafent AND pjbd005 = imaf001 ",
               "   LEFT OUTER JOIN imaa_t ON pjbdent = imaaent AND pjbd005 = imaa001 ",
               "   LEFT OUTER JOIN pjbb_t ON pjbbent = pjbdent AND pjbb001 = pjbd001 AND pjbb002 = pjbd002 ",
               "   LEFT OUTER JOIN pjba_t ON pjbaent = pjbdent AND pjba001 = pjbd001 ",
               
               "  WHERE pjbdent = ? ",
               "    AND pjbb012 IN ('0','1')",
               "    AND pjbd005 IS NOT NULL ",
               "    AND pjbastus = 'Y' ",
               "    AND imafsite = '",g_site,"'",
               "    AND ",g_wc

   LET l_str = ''
   IF g_pjbd001 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "pjbd001 "
      ELSE
         LET l_str = l_str,",","pjbd001"
      END IF      
   END IF   
   IF g_pmda002_1 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "imaf142"  #20151007
      ELSE
         LET l_str = l_str,",","imaf142"
      END IF
   END IF
   IF g_pjbd004 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "imaa009"
      ELSE
         LET l_str = l_str,",","imaa009"
      END IF   
   END IF
   IF g_imaf141 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "imaf141"
      ELSE
         LET l_str = l_str,",","imaf141"
      END IF    
   END IF
   IF g_pjbd001 = 'Y' OR g_pmda002_1 = 'Y' OR g_pjbd004 = 'Y' OR g_imaf141 = 'Y' THEN    
      LET g_sql = g_sql," ORDER BY ",l_str
   ELSE
      LET g_sql = g_sql," ORDER BY pjbd001,pjbd002,pjbd005"   
   END IF   
   #end add-point
 
   PREPARE apjp100_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apjp100_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
           g_detail_d[l_ac].sel,g_detail_d[l_ac].pjbd005,g_detail_d[l_ac].pjbd005_desc,g_detail_d[l_ac].pjbd005_desc_desc,g_detail_d[l_ac].pjbd004,g_detail_d[l_ac].pjbd004_desc,g_detail_d[l_ac].imaf141,g_detail_d[l_ac].imaf141_desc,g_detail_d[l_ac].pjbd006,g_detail_d[l_ac].pjbd006_desc,
           g_detail_d[l_ac].pjbd007,g_detail_d[l_ac].pjbd011,g_detail_d[l_ac].dz_pmdb006,g_detail_d[l_ac].pmdb006,g_detail_d[l_ac].pmdb030,g_detail_d[l_ac].pmda002,g_detail_d[l_ac].pmda002_desc,g_detail_d[l_ac].pjbd001,g_detail_d[l_ac].pjbd001_desc,g_detail_d[l_ac].pjbd002,g_detail_d[l_ac].pjbd002_desc,
           g_detail_d[l_ac].pjbd003           
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
      IF g_detail_d[l_ac].pjbd001 IS NULL THEN
         LET g_detail_d[l_ac].pjbd001 = ' '
      END IF
      IF g_detail_d[l_ac].pmda002 IS NULL THEN
         LET g_detail_d[l_ac].pmda002 = ' '
      END IF   
      IF g_detail_d[l_ac].pjbd004 IS NULL THEN
         LET g_detail_d[l_ac].pjbd004 = ' '
      END IF  
      IF g_detail_d[l_ac].imaf141 IS NULL THEN
         LET g_detail_d[l_ac].imaf141 = ' '
      END IF   
      
      IF cl_null(g_detail_d[l_ac].pjbd011) THEN
         LET g_detail_d[l_ac].pjbd011 = 0
      END IF
      LET g_detail_d[l_ac].dz_pmdb006 = g_detail_d[l_ac].pjbd007 - g_detail_d[l_ac].pjbd011
      IF cl_null(g_detail_d[l_ac].dz_pmdb006) THEN
         LET g_detail_d[l_ac].dz_pmdb006 = 0
      END IF
      LET g_detail_d[l_ac].pmdb006 = g_detail_d[l_ac].dz_pmdb006 
      IF g_detail_d[l_ac].dz_pmdb006 = 0 THEN
         CONTINUE FOREACH
      END IF
      CALL s_desc_get_item_desc(g_detail_d[l_ac].pjbd005) RETURNING g_detail_d[l_ac].pjbd005_desc,g_detail_d[l_ac].pjbd005_desc_desc
      CALL s_desc_get_rtaxl003_desc(g_detail_d[l_ac].pjbd004) RETURNING g_detail_d[l_ac].pjbd004_desc
      CALL s_desc_get_acc_desc('203',g_detail_d[l_ac].imaf141) RETURNING g_detail_d[l_ac].imaf141_desc
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].pjbd006) RETURNING g_detail_d[l_ac].pjbd006_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmda002) RETURNING g_detail_d[l_ac].pmda002_desc
      SELECT pjbal003 INTO g_detail_d[l_ac].pjbd001_desc FROM pjbal_t
       WHERE pjbalent = g_enterprise
         AND pjbal001 = g_detail_d[l_ac].pjbd001
         AND pjbal002 = g_lang
      SELECT pjbbl004 INTO g_detail_d[l_ac].pjbd002_desc FROM pjbbl_t
       WHERE pjbblent = g_enterprise
         AND pjbbl001 = g_detail_d[l_ac].pjbd001
         AND pjbbl002 = g_detail_d[l_ac].pjbd002
         AND pjbbl003 = g_lang   

      #產品分類
      SELECT imaa009 INTO g_detail_d[l_ac].pjbd004 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_detail_d[l_ac].pjbd005
      CALL s_desc_get_rtaxl003_desc(g_detail_d[l_ac].pjbd004) RETURNING g_detail_d[l_ac].pjbd004_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmda002) RETURNING g_detail_d[l_ac].pmda002_desc

      #插入臨時表
#      INSERT INTO apjp100_tmp(sel,pjbd005,pjbd005_desc,pjbd005_desc_desc,pjbd004,pjbd004_desc,imaf141,imaf141_desc,
#                              pjbd006,pjbd006_desc,pjbd007,pjbd011,dz_pmdb006,pmdb006,pmdb030,pmda002,pmda002_desc,
#                              pjbd001,pjbd001_desc,pjbd002,pjbd002_desc,pjbd003)
#                      VALUES (g_detail_d[l_ac].sel,g_detail_d[l_ac].pjbd005,g_detail_d[l_ac].pjbd005_desc,g_detail_d[l_ac].pjbd005_desc_desc,g_detail_d[l_ac].pjbd004,g_detail_d[l_ac].pjbd004_desc,g_detail_d[l_ac].imaf141,g_detail_d[l_ac].imaf141_desc,
#                              g_detail_d[l_ac].pjbd006,g_detail_d[l_ac].pjbd006_desc,g_detail_d[l_ac].pjbd007,g_detail_d[l_ac].pjbd011,g_detail_d[l_ac].dz_pmdb006,g_detail_d[l_ac].pmdb006,g_detail_d[l_ac].pmdb030,g_detail_d[l_ac].pmda002,g_detail_d[l_ac].pmda002_desc,
#                              g_detail_d[l_ac].pjbd001,g_detail_d[l_ac].pjbd001_desc,g_detail_d[l_ac].pjbd002,g_detail_d[l_ac].pjbd002_desc,g_detail_d[l_ac].pjbd003)          
          
      #end add-point
      
      CALL apjp100_detail_show()      
 
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
   FREE apjp100_sel
   
   LET l_ac = 1
   CALL apjp100_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apjp100.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apjp100_fetch()
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
 
{<section id="apjp100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apjp100_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apjp100.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apjp100_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apjp100_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apjp100.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apjp100_filter_parser(ps_field)
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
 
{<section id="apjp100.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apjp100_filter_show(ps_field,ps_object)
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
   LET ls_condition = apjp100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apjp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjp100_gene_pmda_pmdb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjp100_gene_pmda_pmdb()
DEFINE   ls_sql       STRING
DEFINE   i            LIKE type_t.num10
DEFINE   l_flag       LIKE type_t.chr1
DEFINE   l_flag1      LIKE type_t.chr1
DEFINE   l_flag2      LIKE type_t.chr1
DEFINE   l_pjbd001_t  LIKE pjbd_t.pjbd001
DEFINE   l_pmda002_t  LIKE pmda_t.pmda002
DEFINE   l_pjbd004_t  LIKE pjbd_t.pjbd004
DEFINE   l_imaf141_t  LIKE imaf_t.imaf141
DEFINE   la_param   RECORD
         prog       STRING,
         actionid   STRING,
         background LIKE type_t.chr1,
         param      DYNAMIC ARRAY OF STRING
         END RECORD
DEFINE   ls_js      STRING
DEFINE   l_pjbd     type_g_detail_d
DEFINE   l_str      STRING   
DEFINE   l_sql      STRING

   DELETE FROM apjp100_tmp;
   FOR i = 1 TO g_detail_d.getLength()
      IF g_detail_d[i].sel = 'N' THEN
         CONTINUE FOR
      END IF
      INSERT INTO apjp100_tmp(sel,pjbd005,pjbd005_desc,pjbd005_desc_desc,imaa009,pjbd004_desc,imaf141,imaf141_desc,
                              pjbd006,pjbd006_desc,pjbd007,pjbd011,dz_pmdb006,pmdb006,pmdb030,imaf142,pmda002_desc,
                              pjbd001,pjbd001_desc,pjbd002,pjbd002_desc,pjbd003)
                      VALUES (g_detail_d[i].sel,g_detail_d[i].pjbd005,g_detail_d[i].pjbd005_desc,g_detail_d[i].pjbd005_desc_desc,g_detail_d[i].pjbd004,g_detail_d[i].pjbd004_desc,g_detail_d[i].imaf141,g_detail_d[i].imaf141_desc,
                              g_detail_d[i].pjbd006,g_detail_d[i].pjbd006_desc,g_detail_d[i].pjbd007,g_detail_d[i].pjbd011,g_detail_d[i].dz_pmdb006,g_detail_d[i].pmdb006,g_detail_d[i].pmdb030,g_detail_d[i].pmda002,g_detail_d[i].pmda002_desc,
                              g_detail_d[i].pjbd001,g_detail_d[i].pjbd001_desc,g_detail_d[i].pjbd002,g_detail_d[i].pjbd002_desc,g_detail_d[i].pjbd003)                           
   END FOR   
   LET i = i - 1
   CALL g_detail_d.deleteElement(g_detail_d.getLength()) 
   
   LET l_pjbd001_t = ''
   LET l_pmda002_t = ''
   LET l_pjbd004_t = ''
   LET l_imaf141_t = ''
   LET ls_sql = ''
   LET l_flag = 'N'
   LET l_flag1 = 'N'
   LET l_flag2 = 'N'
   CALL cl_err_collect_init()

   LET l_sql = " SELECT DISTINCT * FROM apjp100_tmp WHERE 1=1"  
   LET l_str = ''
   IF g_pjbd001 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "pjbd001 "
      ELSE
         LET l_str = l_str,",","pjbd001"
      END IF      
   END IF   
   IF g_pmda002_1 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "imaf142"  #20151007
      ELSE
         LET l_str = l_str,",","imaf142"
      END IF
   END IF
   IF g_pjbd004 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "imaa009"
      ELSE
         LET l_str = l_str,",","imaa009"
      END IF   
   END IF
   IF g_imaf141 = 'Y' THEN
      IF cl_null(l_str) THEN
         LET l_str = "imaf141"
      ELSE
         LET l_str = l_str,",","imaf141"
      END IF    
   END IF
   IF g_pjbd001 = 'Y' OR g_pmda002_1 = 'Y' OR g_pjbd004 = 'Y' OR g_imaf141 = 'Y' THEN    
      LET l_sql = l_sql," ORDER BY ",l_str
   ELSE
      LET l_sql = l_sql," ORDER BY pjbd001,pjbd002,pjbd005"   
   END IF
   PREPARE apjp100_tmp_sel FROM l_sql
   DECLARE b_fill_tmp_curs CURSOR WITH HOLD FOR apjp100_tmp_sel   
   FOREACH b_fill_tmp_curs INTO l_pjbd.sel,l_pjbd.pjbd005,l_pjbd.pjbd005_desc,l_pjbd.pjbd005_desc_desc,l_pjbd.pjbd004,l_pjbd.pjbd004_desc,l_pjbd.imaf141,l_pjbd.imaf141_desc,
                                l_pjbd.pjbd006,l_pjbd.pjbd006_desc,l_pjbd.pjbd007,l_pjbd.pjbd011,l_pjbd.dz_pmdb006,l_pjbd.pmdb006,l_pjbd.pmdb030,l_pjbd.pmda002,l_pjbd.pmda002_desc,
                                l_pjbd.pjbd001,l_pjbd.pjbd001_desc,l_pjbd.pjbd002,l_pjbd.pjbd002_desc,l_pjbd.pjbd003
      IF l_pjbd.sel = 'N' THEN
         CONTINUE FOREACH
      END IF
      CALL s_transaction_begin()
      LET l_flag = 'N'
      LET l_flag1 = 'N'
      LET l_flag2 = 'N'
      IF g_pjbd001 = 'Y' THEN
         IF l_pjbd.pjbd001 <> l_pjbd001_t OR l_pjbd001_t IS NULL THEN
            LET l_flag = 'Y'
            LET l_pjbd001_t = l_pjbd.pjbd001
         END IF
      END IF
      IF g_pmda002_1 = 'Y' THEN
         IF l_pjbd.pmda002 <> l_pmda002_t OR l_pmda002_t IS NULL THEN
            LET l_flag = 'Y'
            LET l_pmda002_t = l_pjbd.pmda002
         END IF
      END IF   
      IF g_pjbd004 = 'Y' THEN
         IF l_pjbd.pjbd004 <> l_pjbd004_t OR l_pjbd004_t IS NULL THEN
            LET l_flag = 'Y'
            LET l_pjbd004_t = l_pjbd.pjbd004
         END IF
      END IF 
      IF g_imaf141 = 'Y' THEN
         IF l_pjbd.imaf141 <> l_imaf141_t OR l_imaf141_t IS NULL THEN
            LET l_flag = 'Y'
            LET l_imaf141_t = l_pjbd.imaf141
         END IF
      END IF   
      IF g_pjbd001 = 'N' AND  g_pmda002_1 = 'N' AND g_pjbd004 = 'N' AND g_imaf141 = 'N' THEN    
         LET l_flag = 'Y'
      END IF      
      IF l_flag = 'Y' THEN
         IF NOT apjp100_ins_pmda() THEN
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH               
         END IF
         IF cl_null(ls_sql) THEN
            LET ls_sql = " pmdadocno IN ('",g_pmda.pmdadocno,"'"
         ELSE
            LET ls_sql = ls_sql,",","'",g_pmda.pmdadocno,"'"        
         END IF          
      END IF 

      #產生單身
      IF NOT apjp100_ins_pmdb(l_pjbd.*) THEN
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH   
      ELSE
         CALL s_transaction_end('Y','0')  
         LET l_flag2 = 'Y'        
      END IF
            
      LET l_flag1 = 'Y'   
   END FOREACH
#   FOR i = 1 TO g_detail_d.getLength()
#      IF g_detail_d[i].sel = 'N' THEN
#         CONTINUE FOR
#      END IF
#      CALL s_transaction_begin()
#      LET l_flag = 'N'
#      LET l_flag1 = 'N'
#      LET l_flag2 = 'N'
#      IF g_pjbd001 = 'Y' THEN
#         IF g_detail_d[i].pjbd001 <> l_pjbd001_t OR l_pjbd001_t IS NULL THEN
#            LET l_flag = 'Y'
#            LET l_pjbd001_t = g_detail_d[i].pjbd001
#         END IF
#      END IF
#      IF g_pmda002_1 = 'Y' THEN
#         IF g_detail_d[i].pmda002 <> l_pmda002_t OR l_pmda002_t IS NULL THEN
#            LET l_flag = 'Y'
#            LET l_pmda002_t = g_detail_d[i].pmda002
#         END IF
#      END IF   
#      IF g_pjbd004 = 'Y' THEN
#         IF g_detail_d[i].pjbd004 <> l_pjbd004_t OR l_pjbd004_t IS NULL THEN
#            LET l_flag = 'Y'
#            LET l_pjbd004_t = g_detail_d[i].pjbd004
#         END IF
#      END IF 
#      IF g_imaf141 = 'Y' THEN
#         IF g_detail_d[i].imaf141 <> l_imaf141_t OR l_imaf141_t IS NULL THEN
#            LET l_flag = 'Y'
#            LET l_imaf141_t = g_detail_d[i].imaf141
#         END IF
#      END IF   
#      IF g_pjbd001 = 'N' AND  g_pmda002_1 = 'N' AND g_pjbd004 = 'N' AND g_imaf141 = 'N' THEN    
#         LET l_flag = 'Y'
#      END IF      
#      IF l_flag = 'Y' THEN
#         IF NOT apjp100_ins_pmda() THEN
#            CALL s_transaction_end('N','0')
#            CONTINUE FOR               
#         END IF
#         IF cl_null(ls_sql) THEN
#            LET ls_sql = " pmdadocno IN ('",g_pmda.pmdadocno,"'"
#         ELSE
#            LET ls_sql = ls_sql,",","'",g_pmda.pmdadocno,"'"        
#         END IF          
#      END IF 
#
#      #產生單身
#      LET l_pjbd.* = g_detail_d[i].*
#      #IF NOT apjp100_ins_pmdb(g_detail_d[i].*) THEN
#      IF NOT apjp100_ins_pmdb(l_pjbd.*) THEN
#         CALL s_transaction_end('N','0')
#         CONTINUE FOR   
#      ELSE
#         CALL s_transaction_end('Y','0')  
#         LET l_flag2 = 'Y'        
#      END IF
#            
#      LET l_flag1 = 'Y'
#   END FOR
   
   IF NOT cl_null(ls_sql) THEN
      LET ls_sql = ls_sql,")"
   END IF   
   LET g_status = 100 
   DISPLAY g_status TO stagecomplete
   CALL cl_err_collect_show()  
   IF l_flag1 = 'Y' AND l_flag2 = 'Y' THEN
      #执行成功    
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      INITIALIZE la_param.* TO NULL
      LET la_param.prog     = 'apmt400'
      LET la_param.param[1] =  ''
      LET la_param.param[2] = ls_sql
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun(ls_js)    
   END IF    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjp100_ins_pmda()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjp100_ins_pmda()
DEFINE   r_success       LIKE type_t.num5
DEFINE   l_pmda010_desc  LIKE type_t.chr500
DEFINE   l_success       LIKE type_t.num5
DEFINE   l_oodb011       LIKE oodb_t.oodb011

   LET r_success = TRUE
   
   IF NOT cl_null(g_pmdadocno) THEN
      CALL s_aooi200_gen_docno(g_site,g_pmdadocno,g_today,'apmt400') RETURNING l_success,g_pmda.pmdadocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_pmda.pmdadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE        
      END IF   
   END IF
   LET g_pmda.pmdadocdt = g_today
   LET g_pmda.pmda001 = 0
   LET g_pmda.pmda002 = g_pmda002
   LET g_pmda.pmda003 = g_pmda003
   LET g_pmda.pmda007 = g_pmda.pmda003
   LET g_pmda.pmda004 = 'N'
   LET g_pmda.pmda012 = 'N'
   LET g_pmda.pmda020 = 'Y'
   LET g_pmda.pmdastus = 'N'
   LET g_pmda.pmdasite = g_site

   #依據輸入的單別抓取單別的[C:預算控管]參數值，預設給pmda006(預算控管)
   CALL cl_get_doc_para(g_enterprise,g_site,g_pmda.pmdadocno,'D-COM-0002') RETURNING g_pmda.pmda006
   IF cl_null(g_pmda.pmda006) THEN
      LET g_pmda.pmda006 = 'N'
   END IF

   LET g_pmda.pmdadocdt = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmdadocdt',g_pmda.pmdadocdt)
   LET g_pmda.pmda002 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda002',g_pmda.pmda002)
   LET g_pmda.pmda003 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda003',g_pmda.pmda003)
   LET g_pmda.pmda004 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda004',g_pmda.pmda004)
   LET g_pmda.pmda010 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda010',g_pmda.pmda010)
   LET g_pmda.pmda005 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda005',g_pmda.pmda005)
   LET g_pmda.pmda007 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda007',g_pmda.pmda007)
   LET g_pmda.pmda021 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda021',g_pmda.pmda021)
   LET g_pmda.pmda020 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda020',g_pmda.pmda020)
   LET g_pmda.pmda022 = s_aooi200_get_doc_default(g_site,'1',g_pmda.pmdadocno,'pmda022',g_pmda.pmda022)
   
   #根據稅別帶出稅率、含稅否等
   IF NOT cl_null(g_pmda.pmda010) THEN
      CALL s_tax_chk(g_site,g_pmda.pmda010)
          RETURNING l_success,l_pmda010_desc,g_pmda.pmda012,g_pmda.pmda011,l_oodb011
   END IF
   
#   LET g_pmda.ooan005 = ''
#   IF NOT cl_null(g_pmda.pmda005) THEN
#      LET l_ooef016 = ''
#      SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#      CALL s_aooi160_get_exrate('1',g_site,g_today,g_pmda.pmda005,l_ooef016,0,'11') RETURNING g_pmda.ooan005
#   END IF
   LET g_pmda.pmdacrtdt = cl_get_current()
   LET g_pmda.pmdamoddt = cl_get_current()
   INSERT INTO pmda_t (pmdaent,pmdasite,pmdadocno,pmdadocdt,pmda001,pmda002,pmda003,pmda004,pmda005,pmda006,pmda007,pmda008,
                       pmda009,pmda010,pmda011,pmda012,pmda020,pmda021,pmda022,pmda023,pmda200,pmda201,pmdastus,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,
                       pmdacrtdt,pmdamodid,pmdamoddt)
               VALUES (g_enterprise,g_site,g_pmda.pmdadocno,g_pmda.pmdadocdt,g_pmda.pmda001,g_pmda.pmda002,g_pmda.pmda003,g_pmda.pmda004,
                       g_pmda.pmda005,g_pmda.pmda006,g_pmda.pmda007,g_pmda.pmda008,g_pmda.pmda009,g_pmda.pmda010,g_pmda.pmda011,g_pmda.pmda012,
                       g_pmda.pmda020,g_pmda.pmda021,g_pmda.pmda022,g_pmda.pmda023,g_pmda.pmda200,g_pmda.pmda201,g_pmda.pmdastus,g_user,g_dept,g_user,g_dept,
                       g_pmda.pmdacrtdt,g_user,g_pmda.pmdamoddt)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ins pmda_t'
      LET g_errparam.extend = g_pmda.pmdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE        
   END IF                  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjp100_ins_pmdb(p_pjbd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjp100_ins_pmdb(p_pjbd)
DEFINE   p_pjbd          type_g_detail_d
DEFINE   l_pjbd011       LIKE pjbd_t.pjbd011
DEFINE   r_success       LIKE type_t.num5
DEFINE   l_success       LIKE type_t.num5

   LET r_success = TRUE
   LET g_pmdb.pmdb052 = "0"
   LET g_pmdb.pmdb006 = "0"
   LET g_pmdb.pmdb008 = "0"
   LET g_pmdb.pmdb010 = "0"
   LET g_pmdb.pmdb032 = "1"
   LET g_pmdb.pmdb033 = "1"
   LET g_pmdb.pmdb049 = "0"
   LET g_pmdb.pmdb014 = "1"
   LET g_pmdb.pmdb019 = "0"
#   LET g_pmdb.pmdb041 = "Y"
#   LET g_pmdb.pmdb042 = "Y"
   LET g_pmdb.pmdb043 = "N"
#   LET g_pmdb.pmdb044 = "Y"
#   LET g_pmdb.pmdb045 = "Y"
   LET g_pmdb.pmdb030 = p_pjbd.pmdb030   #add by 20151007 需求日期
   LET g_pmdb.pmdb032= "1"    #行狀態
   LET g_pmdb.pmdb033 = "1"   #緊急度
   LET g_pmdb.pmdb049 = 0     #已轉採購量
   
   LET g_pmdb.pmdb018 = g_pmda.pmda011  #稅率
   LET g_pmdb.pmdb020 = 0
   LET g_pmdb.pmdb021 = 0
   
   LET g_pmdb.pmdb046 = g_pmda.pmda007  #費用部門
   
   LET g_pmdb.pmdb044 = g_pmda.pmda020  #MRP/MPS計算
   LET g_pmdb.pmdb045 = "N"   #MRP交期凍結
   LET g_pmdb.pmdb041 = "N"   #允許部分交貨
   LET g_pmdb.pmdb042 = "N"   #允許提前交貨   
            
   SELECT MAX(pmdbseq)+1 INTO g_pmdb.pmdbseq FROM pmdb_t
    WHERE pmdbent = g_enterprise
      AND pmdbdocno = g_pmda.pmdadocno
   IF cl_null(g_pmdb.pmdbseq) THEN 
      LET g_pmdb.pmdbseq = 1
   END IF
   LET g_pmdb.pmdb001 = p_pjbd.pjbd001
   LET g_pmdb.pmdb002 = p_pjbd.pjbd003
   LET g_pmdb.pmdb004 = p_pjbd.pjbd005
   LET g_pmdb.pmdb006 = p_pjbd.pmdb006
   LET g_pmdb.pmdb007 = p_pjbd.pjbd006
   LET g_pmdb.pmdb037 = g_site
   LET g_pmdb.pmdb034 = p_pjbd.pjbd001
   LET g_pmdb.pmdb035 = p_pjbd.pjbd002
   SELECT imaf015,imaf176,imaf157 INTO g_pmdb.pmdb009,g_pmdb.pmdb048,g_pmdb.pmdb012
      FROM imaf_t
      WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb.pmdb004
   
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
      SELECT imaf144 INTO g_pmdb.pmdb011 FROM imaf_t
         WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb.pmdb004                      
   END IF
   
   #計算參考數量
   IF (NOT cl_null(g_pmdb.pmdb004)) AND (NOT cl_null(g_pmdb.pmdb009)) AND (NOT cl_null(g_pmdb.pmdb007)) THEN
      CALL s_aooi250_convert_qty(g_pmdb.pmdb004,g_pmdb.pmdb007,g_pmdb.pmdb009,g_pmdb.pmdb006)
           RETURNING l_success,g_pmdb.pmdb008
      IF NOT cl_null(g_pmdb.pmdb008) THEN
         CALL apjp100_unit_round(g_pmdb.pmdb011,g_pmdb.pmdb008) RETURNING g_pmdb.pmdb008
      END IF
   END IF
   
   #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
   #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
   IF (cl_get_para(g_enterprise,g_site,'S-BAS-0019')) = "Y" AND (NOT cl_null(g_pmdb.pmdb004)) AND (NOT cl_null(g_pmdb.pmdb011)) AND (NOT cl_null(g_pmdb.pmdb007)) THEN  #體參數使用採購計價單位
      CALL s_aooi250_convert_qty(g_pmdb.pmdb004,g_pmdb.pmdb007,g_pmdb.pmdb011,g_pmdb.pmdb006)
           RETURNING l_success,g_pmdb.pmdb010
      IF NOT cl_null(g_pmdb.pmdb010) THEN
         CALL apjp100_unit_round(g_pmdb.pmdb011,g_pmdb.pmdb010) RETURNING g_pmdb.pmdb010
      END IF 
   END IF
          
   INSERT INTO pmdb_t 
         (pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb007,pmdb006,
          pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033,
          pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034,
          pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046) 
        VALUES(g_enterprise,g_site,g_pmda.pmdadocno,g_pmdb.pmdbseq,g_pmdb.pmdb001,g_pmdb.pmdb002, 
               g_pmdb.pmdb003,g_pmdb.pmdb004,g_pmdb.pmdb005,g_pmdb.pmdb007,g_pmdb.pmdb006,g_pmdb.pmdb009, 
               g_pmdb.pmdb008,g_pmdb.pmdb011,g_pmdb.pmdb010,g_pmdb.pmdb030,g_pmdb.pmdb048,g_pmdb.pmdb031, 
               g_pmdb.pmdb050,g_pmdb.pmdb032,g_pmdb.pmdb051,g_pmdb.pmdb033,g_pmdb.pmdb049,g_pmdb.pmdb012, 
               g_pmdb.pmdb014,g_pmdb.pmdb015,g_pmdb.pmdb016,g_pmdb.pmdb017,g_pmdb.pmdb018,g_pmdb.pmdb019, 
               g_pmdb.pmdb020,g_pmdb.pmdb021,g_pmdb.pmdb034,g_pmdb.pmdb035,g_pmdb.pmdb036,g_pmdb.pmdb037,
               g_pmdb.pmdb038,g_pmdb.pmdb039,g_pmdb.pmdb041,g_pmdb.pmdb042,g_pmdb.pmdb043,g_pmdb.pmdb044,
               g_pmdb.pmdb045,g_pmdb.pmdb046) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmdb_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_success = FALSE
   END IF

   #add by lixh 20151007
   #回寫pjbd011
#   SELECT pjbd011 INTO l_pjbd011 FROM pjbd_t
#    WHERE pjbdent = g_enterprise
#      AND pjbd001 = p_pjbd.pjbd001 
#      AND pjbd002 = p_pjbd.pjbd002 
#      AND pjbd003 = p_pjbd.pjbd003
#   IF cl_null(l_pjbd011) THEN LET l_pjbd011 = 0 END IF   
   UPDATE pjbd_t SET pjbd011 = (CASE WHEN pjbd011 IS NULL THEN 0 ELSE pjbd011 END) + g_pmdb.pmdb006
#    UPDATE pjbd_t SET pjbd011 = l_pjbd011 + g_pmdb.pmdb006
    WHERE pjbdent = g_enterprise
      AND pjbd001 = p_pjbd.pjbd001 
      AND pjbd002 = p_pjbd.pjbd002 
      AND pjbd003 = p_pjbd.pjbd003
   #add by lixh 20151007
      
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjp100_unit_round(p_pmdb007,p_pmdb006)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjp100_unit_round(p_pmdb007,p_pmdb006)
DEFINE p_pmdb007   LIKE pmdb_t.pmdb007     #單位
DEFINE p_pmdb006   LIKE pmdb_t.pmdb006     #數量
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型 
DEFINE r_pmdb006   LIKE pmdb_t.pmdb006     #數量
        
   LET l_success = NULL
   LET l_ooca002 = 0
   LET l_ooca004 = NULL
   LET r_pmdb006 = 0
   
   #抓取单位档中的小数位数和舍入类型
   IF NOT cl_null(p_pmdb007) THEN
      CALL s_aooi250_get_msg(p_pmdb007) RETURNING l_success,l_ooca002,l_ooca004
      IF l_success THEN
         IF NOT cl_null(p_pmdb006) THEN
            CALL s_num_round(l_ooca004,p_pmdb006,l_ooca002) RETURNING r_pmdb006
            RETURN r_pmdb006
         END IF
      END IF
   END IF
   RETURN r_pmdb006
END FUNCTION

#end add-point
 
{</section>}
 
