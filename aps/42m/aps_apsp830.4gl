#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp830.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-12-17 10:32:46), PR版次:0004(2016-05-04 16:40:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: apsp830
#+ Description: 集團MRP產生調撥作業
#+ Creator....: 04441(2014-12-10 11:11:58)
#+ Modifier...: 04441 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp830.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#21  2016/04/19  BY 07900    校验代码重复错误讯息的修改
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
    sel                LIKE type_t.chr1,       #選擇
    psgcseq            LIKE psgc_t.psgcseq,    #項次
    psgc006            LIKE psgc_t.psgc006,    #撥入營運據點
    psgc006_desc       LIKE type_t.chr80,      #說明
    psgc002            LIKE psgc_t.psgc002,    #料件編號
    psgc002_desc       LIKE type_t.chr80,      #品名
    psgc002_desc_desc  LIKE type_t.chr80,      #規格
    psgc003            LIKE psgc_t.psgc003,    #產品特徵
    psgc003_desc       LIKE type_t.chr80,      #說明
    imaf141            LIKE imaf_t.imaf141,    #採購分類
    imaf141_desc       LIKE type_t.chr80,      #說明
    psgc007            LIKE psgc_t.psgc007,    #需求數量
    qty                LIKE psgc_t.psgc007,    #已指定庫位數量
    imaa006            LIKE imaa_t.imaa006,    #單位
    imaa006_desc       LIKE type_t.chr80,      #說明
    psgc004            LIKE psgc_t.psgc004,    #需求日
    imae012            LIKE imae_t.imae012,    #計畫員
    imae012_desc       LIKE type_t.chr80,      #全名
    psgc008            LIKE psgc_t.psgc008     #已轉單
                   END RECORD
TYPE type_g_detail2_d  RECORD
    inddseq            LIKE indd_t.inddseq,    #項次
    indd022            LIKE indd_t.indd022,    #撥出倉庫
    indd022_desc       LIKE type_t.chr80,      #說明
    indd023            LIKE indd_t.indd023,    #撥出儲位
    indd023_desc       LIKE type_t.chr80,      #說明
    indd024            LIKE indd_t.indd024,    #撥出批號
    indd102            LIKE indd_t.indd102,    #撥出庫存管理特徵
    indd006            LIKE indd_t.indd006,    #單位
    indd006_desc       LIKE type_t.chr80,      #說明
    indd103            LIKE indd_t.indd103,    #數量
    indd032            LIKE indd_t.indd032,    #撥入倉庫
    indd032_desc       LIKE type_t.chr80,      #說明
    indd033            LIKE indd_t.indd033,    #撥入儲位
    indd033_desc       LIKE type_t.chr80       #說明
                   END RECORD

DEFINE g_detail_idx    LIKE type_t.num5
DEFINE g_detail2_idx   LIKE type_t.num5
DEFINE g_detail2_cnt   LIKE type_t.num5        #單身2 總筆數
DEFINE g_detail2_d     DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_d_t   type_g_detail2_d

DEFINE tm              RECORD
    wc                 STRING,                 #QBE
    psgc001            LIKE psgc_t.psgc001,    #集團MRP版本
    psgc001_o          LIKE psgc_t.psgc001,    #集團MRP版本
    psgc001_desc       LIKE type_t.chr80,      #說明
    psgc005            LIKE psgc_t.psgc005,    #撥出營運據點
    psgc005_o          LIKE psgc_t.psgc005,    #撥出營運據點
    psgc005_desc       LIKE type_t.chr80,      #說明
    indcdocno          LIKE indc_t.indcdocno,  #調撥單別
    indcdocno_o        LIKE indc_t.indcdocno,  #調撥單別
    indc007            LIKE indc_t.indc007,    #在途成本倉
    indc109            LIKE indc_t.indc109,    #在途非成本倉
    chk                LIKE type_t.chr1        #顯示已轉單資料
                   END RECORD



#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp830.main" >}
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
      OPEN WINDOW w_apsp830 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp830_init()   
 
      #進入選單 Menu (="N")
      CALL apsp830_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp830
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apsp830_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp830.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp830_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"

   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   LET g_detail_idx  = 1
   LET g_detail2_idx = 1
   
   LET tm.chk  = 'N'

   CREATE TEMP TABLE apsp830_tmp(
    psgcseq             INTEGER,         #項次
    psgc006             VARCHAR(10),         #撥入營運據點
    inddseq             INTEGER,         #項次
    indd002             VARCHAR(40),         #料件編號
    indd004             VARCHAR(256),         #產品特徵
    indd022             VARCHAR(10),         #撥出倉庫
    indd023             VARCHAR(10),         #撥出儲位
    indd024             VARCHAR(30),         #撥出批號
    indd102             VARCHAR(30),         #撥出庫存管理特徵
    indd006             VARCHAR(10),         #單位
    indd103             DECIMAL(20,6),         #數量
    indd032             VARCHAR(10),         #撥入倉庫
    indd033             VARCHAR(10)     #撥入儲位
    )

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp830.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp830_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_g_site   LIKE type_t.chr10
   DEFINE l_ooef004  LIKE ooef_t.ooef004
   DEFINE l_where    STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_detail2_cnt = g_detail2_d.getLength()
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsp830_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME tm.wc ON imae012,psgc004,imaa009,imaf141,psgc002
	   
            BEFORE CONSTRUCT

            AFTER FIELD psgc004                  #需求日
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)

            ON ACTION controlp INFIELD imae012   #計畫員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imae012
               NEXT FIELD imae012

            ON ACTION controlp INFIELD imaa009   #產品分類
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009

            ON ACTION controlp INFIELD imaf141   #採購分類
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imce141()
               DISPLAY g_qryparam.return1 TO imaf141
               NEXT FIELD imaf141

            ON ACTION controlp INFIELD psgc002   #料件編號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO psgc002
               NEXT FIELD psgc002

         END CONSTRUCT

         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.psgc001,tm.psgc005
            ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT
               LET tm.psgc001_o = tm.psgc001
               LET tm.psgc005_o = tm.psgc005
         
            AFTER FIELD psgc001
               LET tm.psgc001_desc = ''
               IF tm.psgc001_o <> tm.psgc001 THEN
                  LET tm.psgc005 = ''
                  LET tm.psgc005_desc = ''
                  LET tm.indcdocno = ''
                  LET tm.indc007 = ''
                  LET tm.indc109 = ''
                  DISPLAY tm.psgc005 TO psgc005
                  DISPLAY tm.psgc005_desc TO psgc005_desc
                  DISPLAY tm.indcdocno TO indcdocno
                  DISPLAY tm.indc007 TO indc007
                  DISPLAY tm.indc109 TO indc109
               END IF
               IF NOT cl_null(tm.psgc001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = tm.psgc001
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aps-00092:sub-01302|apsi800|",cl_get_progname("apsi800",g_lang,"2"),"|:EXEPROGapsi800"
                 #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_psfa001") THEN
                     LET tm.psgc001 = tm.psgc001_o
                     CALL apsp830_psfa001_ref(tm.psgc001) RETURNING tm.psgc001_desc
                     DISPLAY tm.psgc001_desc TO psgc001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL apsp830_psfa001_ref(tm.psgc001) RETURNING tm.psgc001_desc
               DISPLAY tm.psgc001_desc TO psgc001_desc
               LET tm.psgc001_o = tm.psgc001
               LET tm.psgc005_o = tm.psgc005
         
            AFTER FIELD psgc005
               LET tm.psgc005_desc = ''
               IF tm.psgc005_o <> tm.psgc005 THEN
                  LET tm.indcdocno = ''
                  LET tm.indc007 = ''
                  LET tm.indc109 = ''
                  DISPLAY tm.indcdocno TO indcdocno
                  DISPLAY tm.indc007 TO indc007
                  DISPLAY tm.indc109 TO indc109
               END IF
               IF NOT cl_null(tm.psgc005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = tm.psgc001
                  LET g_chkparam.arg2 = tm.psgc005
                  IF NOT cl_chk_exist("v_psfb003") THEN
                     LET tm.psgc005 = tm.psgc005_o
                     CALL s_desc_get_department_desc(tm.psgc005) RETURNING tm.psgc005_desc
                     DISPLAY tm.psgc005_desc TO psgc005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_department_desc(tm.psgc005) RETURNING tm.psgc005_desc
               DISPLAY tm.psgc005_desc TO psgc005_desc
               LET tm.psgc005_o = tm.psgc005
         
            BEFORE FIELD psgc005
               IF cl_null(tm.psgc001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00129'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD psgc001
               END IF

            ON ACTION controlp INFIELD psgc001    #集團MRP版本
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.psgc001
               CALL q_psfa001()
               LET tm.psgc001 = g_qryparam.return1
               DISPLAY tm.psgc001 TO psgc001
               CALL apsp830_psfa001_ref(tm.psgc001) RETURNING tm.psgc001_desc
               DISPLAY tm.psgc001_desc TO psgc001_desc
               NEXT FIELD psgc001

            ON ACTION controlp INFIELD psgc005    #撥出營運據點
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.psgc005
               LET g_qryparam.arg1 = tm.psgc001
               CALL q_psfb003()
               LET tm.psgc005 = g_qryparam.return1
               DISPLAY tm.psgc005 TO psgc005
               CALL s_desc_get_department_desc(tm.psgc005) RETURNING tm.psgc005_desc
               DISPLAY tm.psgc005_desc TO psgc005_desc
               NEXT FIELD psgc005

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT
         
         INPUT BY NAME tm.indcdocno,tm.indc007,tm.indc109,tm.chk
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET l_g_site = g_site
               LET g_site = tm.psgc005
               LET l_ooef004 = ''
               SELECT ooef004 INTO l_ooef004 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site
               LET tm.indcdocno_o = tm.indcdocno

            AFTER FIELD indcdocno
               IF NOT cl_null(tm.indcdocno) THEN
                  IF NOT s_aooi200_chk_slip(tm.psgc005,'',tm.indcdocno,'aint340') THEN
                     LET tm.indcdocno = tm.indcdocno_o
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用  
                  CALL s_control_chk_doc('1',tm.indcdocno,'3',g_user,g_dept,'','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET tm.indcdocno = tm.indcdocno_o
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET tm.indcdocno_o = tm.indcdocno

            AFTER FIELD indc007
               IF NOT cl_null(tm.indc007) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = tm.indc007
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_11") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF

            AFTER FIELD indc109
               IF NOT cl_null(tm.indc109) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = tm.indc109
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_12") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF

            ON ACTION controlp INFIELD indcdocno  #調撥單別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.indcdocno
               LET g_qryparam.arg1 = l_ooef004
               LET g_qryparam.arg2 = "aint340" 
               CALL q_ooba002_8()
               LET tm.indcdocno = g_qryparam.return1              
               DISPLAY tm.indcdocno TO indcdocno
               NEXT FIELD indcdocno

            ON ACTION controlp INFIELD indc007    #在途成本倉
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.indc007
               CALL q_inaa001_16()
               LET tm.indc007 = g_qryparam.return1              
               DISPLAY tm.indc007 TO indc007
               NEXT FIELD indc007

            ON ACTION controlp INFIELD indc109    #在途非成本倉
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.indc109
               CALL q_inaa001_17()
               LET tm.indc109 = g_qryparam.return1              
               DISPLAY tm.indc109 TO indc109
               NEXT FIELD indc109

            AFTER INPUT
               LET g_site = l_g_site
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT

         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
            
            BEFORE INPUT
               LET g_detail_cnt = g_detail_d.getLength()
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               DISPLAY g_detail_idx TO FORMONLY.h_index
               CALL apsp830_fetch()
            
            ON CHANGE sel
               IF g_detail_d[g_detail_idx].sel = 'Y' AND g_detail_d[g_detail_idx].psgc008 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00130'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[g_detail_idx].sel = 'N'
               END IF
 
            AFTER ROW
 
            AFTER INPUT
 
         END INPUT

         INPUT ARRAY g_detail2_d FROM s_detail2.*
            ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = TRUE,
                      DELETE ROW = TRUE,
                      APPEND ROW = TRUE)

            BEFORE INPUT
               LET l_g_site = g_site
               LET g_site = tm.psgc005
               LET tm.indcdocno_o = tm.indcdocno
               LET g_detail2_cnt = g_detail2_d.getLength()
         
            BEFORE ROW
               LET g_detail2_idx = ARR_CURR()
               LET g_detail2_cnt = g_detail2_d.getLength()
         
            BEFORE INSERT
               SELECT MAX(inddseq)+1
                 INTO g_detail2_d[g_detail2_idx].inddseq
                 FROM apsp830_tmp
               IF g_detail2_d[g_detail2_idx].inddseq = 0 OR cl_null(g_detail2_d[g_detail2_idx].inddseq) THEN
                  LET g_detail2_d[g_detail2_idx].inddseq = 1
               END IF
               LET g_detail2_d[g_detail2_idx].indd103 = 0
               LET g_detail2_d_t.* = g_detail2_d[g_detail2_idx].*
         
            AFTER INSERT
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF
               INSERT INTO apsp830_tmp(psgcseq,psgc006,inddseq,indd002,indd004,indd022,indd023,
                                       indd024,indd102,indd006,indd103,indd032,indd033)
                  VALUES(g_detail_d[g_detail_idx].psgcseq,g_detail_d[g_detail_idx].psgc006,
                         g_detail2_d[g_detail2_idx].inddseq,g_detail_d[g_detail_idx].psgc002,
                         g_detail_d[g_detail_idx].psgc003,g_detail2_d[g_detail2_idx].indd022,
                         g_detail2_d[g_detail2_idx].indd023,g_detail2_d[g_detail2_idx].indd024,
                         g_detail2_d[g_detail2_idx].indd102,g_detail2_d[g_detail2_idx].indd006,
                         g_detail2_d[g_detail2_idx].indd103,g_detail2_d[g_detail2_idx].indd032,
                         g_detail2_d[g_detail2_idx].indd033)
               LET g_detail2_cnt = g_detail2_cnt + 1
               SELECT SUM(indd103) INTO g_detail_d[g_detail_idx].qty FROM apsp830_tmp
                WHERE psgcseq = g_detail_d[g_detail_idx].psgcseq
         
            BEFORE DELETE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               DELETE FROM apsp830_tmp
                WHERE psgcseq = g_detail_d[g_detail_idx].psgcseq
                  AND inddseq = g_detail2_d[g_detail2_idx].inddseq
               INITIALIZE g_detail2_d[g_detail2_idx].* TO NULL
               LET g_detail2_cnt = g_detail2_cnt - 1
         
            AFTER DELETE 
               SELECT SUM(indd103) INTO g_detail_d[g_detail_idx].qty FROM apsp830_tmp
                WHERE psgcseq = g_detail_d[g_detail_idx].psgcseq

            AFTER FIELD indd022
               LET g_detail2_d[g_detail2_idx].indd022_desc = ''
               LET g_detail2_d[g_detail2_idx].indd023_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN 
                  IF cl_null(g_detail2_d_t.indd022) OR (g_detail2_d[g_detail2_idx].indd022 <> g_detail2_d_t.indd022) THEN
                     IF NOT apsp830_inag_chk('1') THEN
                        LET  g_detail2_d[g_detail2_idx].indd022 = g_detail2_d_t.indd022
                        LET  g_detail2_d[g_detail2_idx].indd023 = g_detail2_d_t.indd023
                        LET  g_detail2_d[g_detail2_idx].indd024 = g_detail2_d_t.indd024
                        LET  g_detail2_d[g_detail2_idx].indd102 = g_detail2_d_t.indd102
                        CALL s_desc_get_stock_desc(g_site,g_detail2_d[g_detail2_idx].indd022)
                             RETURNING g_detail2_d[g_detail2_idx].indd022_desc
                        CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023)
                             RETURNING g_detail2_d[g_detail2_idx].indd023_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_desc_get_stock_desc(g_site,g_detail2_d[g_detail2_idx].indd022)
                    RETURNING g_detail2_d[g_detail2_idx].indd022_desc
               CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023)
                    RETURNING g_detail2_d[g_detail2_idx].indd023_desc

            AFTER FIELD indd023
               LET g_detail2_d[g_detail2_idx].indd023_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd023) THEN 
                  IF cl_null(g_detail2_d_t.indd023) OR (g_detail2_d[g_detail2_idx].indd023 <> g_detail2_d_t.indd023) THEN
                     IF NOT apsp830_inag_chk('2') THEN
                        LET  g_detail2_d[g_detail2_idx].indd023 = g_detail2_d_t.indd023
                        LET  g_detail2_d[g_detail2_idx].indd024 = g_detail2_d_t.indd024
                        LET  g_detail2_d[g_detail2_idx].indd102 = g_detail2_d_t.indd102
                        CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023)
                             RETURNING g_detail2_d[g_detail2_idx].indd023_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023)
                    RETURNING g_detail2_d[g_detail2_idx].indd023_desc

            AFTER FIELD indd024
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd024) THEN 
                  IF cl_null(g_detail2_d_t.indd024) OR (g_detail2_d[g_detail2_idx].indd024 <> g_detail2_d_t.indd024) THEN
                     IF NOT apsp830_inag_chk('') THEN
                        LET  g_detail2_d[g_detail2_idx].indd024 = g_detail2_d_t.indd024
                        LET  g_detail2_d[g_detail2_idx].indd102 = g_detail2_d_t.indd102
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            AFTER FIELD indd102
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd102) THEN 
                  IF cl_null(g_detail2_d_t.indd102) OR (g_detail2_d[g_detail2_idx].indd102 <> g_detail2_d_t.indd102) THEN
                     IF NOT apsp830_inag_chk('') THEN
                        LET  g_detail2_d[g_detail2_idx].indd102 = g_detail2_d_t.indd102
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            AFTER FIELD indd006
               LET g_detail2_d[g_detail2_idx].indd006_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd006) THEN 
                  IF cl_null(g_detail2_d_t.indd006) OR (g_detail2_d[g_detail2_idx].indd006 <> g_detail2_d_t.indd006) THEN
                     IF NOT apsp830_inag_chk('') THEN
                        LET g_detail2_d[g_detail2_idx].indd006 = g_detail2_d_t.indd006
                        CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                             RETURNING g_detail2_d[g_detail2_idx].indd006_desc
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_detail2_d[g_detail2_idx].indd103) THEN
                        CALL s_aooi250_take_decimals(g_detail2_d[g_detail2_idx].indd006,g_detail2_d[g_detail2_idx].indd103)
                             RETURNING l_success,g_detail2_d[g_detail2_idx].indd103
                     END IF
                  END IF 
               END IF 
               CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                    RETURNING g_detail2_d[g_detail2_idx].indd006_desc

            AFTER FIELD indd103
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd103) THEN
                  IF cl_null(g_detail2_d_t.indd103) OR (g_detail2_d[g_detail2_idx].indd103 <> g_detail2_d_t.indd103) THEN
                     IF NOT cl_null(g_detail2_d[g_detail2_idx].indd006) THEN
                        CALL s_aooi250_take_decimals(g_detail2_d[g_detail2_idx].indd006,g_detail2_d[g_detail2_idx].indd103)
                             RETURNING l_success,g_detail2_d[g_detail2_idx].indd103
                     END IF
                     IF NOT apsp830_indd103_chk() THEN
                        LET g_detail2_d[g_detail2_idx].indd103 = g_detail2_d_t.indd103
                        NEXT FIELD CURRENT
                     END IF 
                  END IF 
               END IF 

            AFTER FIELD indd032
               LET g_detail2_d[g_detail2_idx].indd032_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd032) THEN 
                  IF cl_null(g_detail2_d_t.indd032) OR (g_detail2_d[g_detail2_idx].indd032 <> g_detail2_d_t.indd032) THEN
                     IF NOT apsp830_indd_chk('1') THEN
                        LET g_detail2_d[g_detail2_idx].indd032 = g_detail2_d_t.indd032
                        CALL s_desc_get_stock_desc(g_detail_d[g_detail_idx].psgc006,g_detail2_d[g_detail2_idx].indd032)
                             RETURNING g_detail2_d[g_detail2_idx].indd032_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF 
               CALL s_desc_get_stock_desc(g_detail_d[g_detail_idx].psgc006,g_detail2_d[g_detail2_idx].indd032)
                    RETURNING g_detail2_d[g_detail2_idx].indd032_desc
 
            AFTER FIELD indd033
               LET g_detail2_d[g_detail2_idx].indd033_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd033) THEN
                  IF cl_null(g_detail2_d_t.indd033) OR (g_detail2_d[g_detail2_idx].indd033 <> g_detail2_d_t.indd033) THEN
                     IF NOT apsp830_indd_chk('2') THEN
                        LET g_detail2_d[g_detail2_idx].indd033 = g_detail2_d_t.indd033
                        CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd032,g_detail2_d[g_detail2_idx].indd033)
                             RETURNING g_detail2_d[g_detail2_idx].indd033_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF   
               CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd032,g_detail2_d[g_detail2_idx].indd033)
                    RETURNING g_detail2_d[g_detail2_idx].indd033_desc

            ON ACTION controlp INFIELD indd022
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].indd022
               LET g_qryparam.default2 = g_detail2_d[g_detail2_idx].indd023
               LET g_qryparam.default3 = g_detail2_d[g_detail2_idx].indd024
               LET g_qryparam.default4 = g_detail2_d[g_detail2_idx].indd102
               LET g_qryparam.default5 = g_detail2_d[g_detail2_idx].indd006
               LET g_qryparam.where = " 1=1"
               LET g_qryparam.arg1 = g_detail_d[g_detail_idx].psgc002
               LET g_qryparam.arg2 = g_detail_d[g_detail_idx].psgc003
               CALL s_control_get_doc_sql("inaa001",tm.indcdocno,'6') RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_where
               END IF
               CALL q_inag004_13()
               LET g_detail2_d[g_detail2_idx].indd022 = g_qryparam.return1
               LET g_detail2_d[g_detail2_idx].indd023 = g_qryparam.return2
               LET g_detail2_d[g_detail2_idx].indd024 = g_qryparam.return3
               LET g_detail2_d[g_detail2_idx].indd102 = g_qryparam.return4
               LET g_detail2_d[g_detail2_idx].indd006 = g_qryparam.return5
               CALL s_desc_get_stock_desc(g_site,g_detail2_d[g_detail2_idx].indd022)
                    RETURNING g_detail2_d[g_detail2_idx].indd022_desc
               CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023)
                    RETURNING g_detail2_d[g_detail2_idx].indd023_desc
               CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                    RETURNING g_detail2_d[g_detail2_idx].indd006_desc
               NEXT FIELD indd022

            ON ACTION controlp INFIELD indd023
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default2 = g_detail2_d[g_detail2_idx].indd023
               LET g_qryparam.default3 = g_detail2_d[g_detail2_idx].indd024
               LET g_qryparam.default4 = g_detail2_d[g_detail2_idx].indd102
               LET g_qryparam.default5 = g_detail2_d[g_detail2_idx].indd006
               LET g_qryparam.where = " 1=1"
               LET g_qryparam.arg1 = g_detail_d[g_detail_idx].psgc002
               LET g_qryparam.arg2 = g_detail_d[g_detail_idx].psgc003
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_detail2_d[g_detail2_idx].indd022,"' "
               END IF
               CALL q_inag004_13()
               LET g_detail2_d[g_detail2_idx].indd023 = g_qryparam.return2
               LET g_detail2_d[g_detail2_idx].indd024 = g_qryparam.return3
               LET g_detail2_d[g_detail2_idx].indd102 = g_qryparam.return4
               LET g_detail2_d[g_detail2_idx].indd006 = g_qryparam.return5
               CALL s_desc_get_locator_desc(g_site,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023)
                    RETURNING g_detail2_d[g_detail2_idx].indd023_desc
               CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                    RETURNING g_detail2_d[g_detail2_idx].indd006_desc
               NEXT FIELD indd023

            ON ACTION controlp INFIELD indd024
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default3 = g_detail2_d[g_detail2_idx].indd024
               LET g_qryparam.default4 = g_detail2_d[g_detail2_idx].indd102
               LET g_qryparam.default5 = g_detail2_d[g_detail2_idx].indd006
               LET g_qryparam.where = " 1=1"
               LET g_qryparam.arg1 = g_detail_d[g_detail_idx].psgc002
               LET g_qryparam.arg2 = g_detail_d[g_detail_idx].psgc003
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_detail2_d[g_detail2_idx].indd022,"' "
               END IF
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd023) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_detail2_d[g_detail2_idx].indd023,"' "
               END IF
               CALL q_inag004_13()
               LET g_detail2_d[g_detail2_idx].indd024 = g_qryparam.return3
               LET g_detail2_d[g_detail2_idx].indd102 = g_qryparam.return4
               LET g_detail2_d[g_detail2_idx].indd006 = g_qryparam.return5
               CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                    RETURNING g_detail2_d[g_detail2_idx].indd006_desc
               NEXT FIELD indd024

            ON ACTION controlp INFIELD indd102
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default4 = g_detail2_d[g_detail2_idx].indd102
               LET g_qryparam.default5 = g_detail2_d[g_detail2_idx].indd006
               LET g_qryparam.where = " 1=1"
               LET g_qryparam.arg1 = g_detail_d[g_detail_idx].psgc002
               LET g_qryparam.arg2 = g_detail_d[g_detail_idx].psgc003
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_detail2_d[g_detail2_idx].indd022,"' "
               END IF
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd023) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_detail2_d[g_detail2_idx].indd023,"' "
               END IF
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd024) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_detail2_d[g_detail2_idx].indd024,"' "
               END IF
               CALL q_inag004_13()
               LET g_detail2_d[g_detail2_idx].indd102 = g_qryparam.return4
               LET g_detail2_d[g_detail2_idx].indd006 = g_qryparam.return5
               CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                    RETURNING g_detail2_d[g_detail2_idx].indd006_desc
               NEXT FIELD indd102

            ON ACTION controlp INFIELD indd006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].indd006
               LET g_qryparam.where = " inag001 = '",g_detail_d[g_detail_idx].psgc002,"' AND ",
                                      " inag002 = '",g_detail_d[g_detail_idx].psgc003,"' "
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd102) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_detail2_d[g_detail2_idx].indd102,"' "
               END IF  
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_detail2_d[g_detail2_idx].indd022,"' "
               END IF 
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd023) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_detail2_d[g_detail2_idx].indd023,"' "
               END IF   
               IF NOT cl_null(g_detail2_d[g_detail2_idx].indd024) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_detail2_d[g_detail2_idx].indd024,"' "
               END IF    
               CALL q_inag007()
               LET g_detail2_d[g_detail2_idx].indd006 = g_qryparam.return1
               CALL s_desc_get_unit_desc(g_detail2_d[g_detail2_idx].indd006)
                    RETURNING g_detail2_d[g_detail2_idx].indd006_desc
               NEXT FIELD indd006

            ON ACTION controlp INFIELD indd032
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].indd032
               LET g_qryparam.arg1 = g_detail_d[g_detail_idx].psgc006
               LET g_qryparam.where = " 1=1"
               CALL s_control_get_doc_sql("inaa001",tm.indcdocno,'6') RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_where
               END IF
               CALL q_inaa001_4()
               LET g_detail2_d[g_detail2_idx].indd032 = g_qryparam.return1
               CALL s_desc_get_stock_desc(g_detail_d[g_detail_idx].psgc006,g_detail2_d[g_detail2_idx].indd032)
                    RETURNING g_detail2_d[g_detail2_idx].indd032_desc
               NEXT FIELD indd032

            ON ACTION controlp INFIELD indd033
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].indd033
               LET g_qryparam.arg1 = g_detail_d[g_detail_idx].psgc006
               LET g_qryparam.arg2 = g_detail2_d[g_detail2_idx].indd032
               CALL q_inab002_6()
               LET g_detail2_d[g_detail2_idx].indd033 = g_qryparam.return1
               CALL s_desc_get_locator_desc(g_detail_d[g_detail_idx].psgc006,g_detail2_d[g_detail2_idx].indd032,g_detail2_d[g_detail2_idx].indd033)
                    RETURNING g_detail2_d[g_detail2_idx].indd033_desc
               NEXT FIELD indd033

            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  LET g_detail2_d[g_detail2_idx].* = g_detail2_d_t.*
                  EXIT DIALOG 
               END IF
               UPDATE apsp830_tmp
                  SET indd022 = g_detail2_d[g_detail2_idx].indd022,
                      indd023 = g_detail2_d[g_detail2_idx].indd023,
                      indd024 = g_detail2_d[g_detail2_idx].indd024,
                      indd102 = g_detail2_d[g_detail2_idx].indd102,
                      indd006 = g_detail2_d[g_detail2_idx].indd006,
                      indd103 = g_detail2_d[g_detail2_idx].indd103,
                      indd032 = g_detail2_d[g_detail2_idx].indd032,
                      indd033 = g_detail2_d[g_detail2_idx].indd033
                WHERE psgcseq = g_detail_d[g_detail_idx].psgcseq
                  AND inddseq = g_detail2_d[g_detail2_idx].inddseq
               SELECT SUM(indd103) INTO g_detail_d[g_detail_idx].qty FROM apsp830_tmp
                WHERE psgcseq = g_detail_d[g_detail_idx].psgcseq

            AFTER ROW
                 
            AFTER INPUT
               LET g_site = l_g_site
         
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
               IF g_detail_d[li_idx].psgc008 = 'Y' THEN
                  LET g_detail_d[li_idx].sel = "N"
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
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF g_detail_d[li_idx].psgc008 = 'Y' THEN
                     LET g_detail_d[li_idx].sel = "N"
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
            CALL apsp830_filter()
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
            CALL apsp830_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            LET g_wc_filter   = " 1=1"
            LET g_wc_filter_t = " 1=1"
            CALL apsp830_b_fill()

            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp830_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_n = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_n = 1
                  EXIT FOR
               END IF
            END FOR
            IF l_n = 0 THEN
               CALL cl_ask_pressanykey('-400')
            ELSE
               IF cl_null(tm.indcdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00603'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD indcdocno
               END IF
               IF cl_null(tm.indc007) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00122'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD indc007
               END IF
               IF cl_null(tm.indc109) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00122'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD indc109
               END IF
               CALL apsp830_batch_execute()
               CALL apsp830_b_fill()
            END IF

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
 
{<section id="apsp830.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp830_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(tm.indcdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00603'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   #end add-point
        
   LET g_error_show = 1
   CALL apsp830_b_fill()
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
 
{<section id="apsp830.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp830_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   DELETE FROM apsp830_tmp

   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1 " END IF
   IF cl_null(g_wc_filter) THEN LET g_wc_filter = " 1=1 " END IF  #151209-00022#10 by whitney add

   LET ls_wc = ''
   IF tm.chk = 'N' THEN
      LET ls_wc = " (psgc008 = 'N' OR psgc008 IS NULL) "
   ELSE
      LET ls_wc = " 1=1 "
   END IF


   LET g_sql = " SELECT 'N',psgcseq,psgc006,'',psgc002,'','',psgc003,'',imaf141,'', ",
               "        psgc007,'0',imaa006,'',psgc004,imae012,'',psgc008 ",
               "   FROM psgc_t LEFT OUTER JOIN imaf_t ON imafent  = '",g_enterprise,"' ",
               "                                     AND imafsite = '",tm.psgc005,"' ",
               "                                     AND imaf001  = psgc002 ",
               "               LEFT OUTER JOIN imaa_t ON imaaent  = '",g_enterprise,"' ",
               "                                     AND imaa001  = psgc002 ",
               "               LEFT OUTER JOIN imae_t ON imaeent  = '",g_enterprise,"' ",
               "                                     AND imaesite = '",tm.psgc005,"' ",
               "                                     AND imae001  = psgc002 ",
               "  WHERE psgcent = ? ",
               "    AND psgc001 = '",tm.psgc001,"' ",  #MRP版本  
               "    AND psgc005 = '",tm.psgc005,"' ",  #營運據點  
               "    AND psgc007  > 0 ",
               "    AND ",tm.wc CLIPPED,
               "    AND ",ls_wc CLIPPED,
               "   AND ",g_wc_filter CLIPPED,  #151209-00022#10 by whitney add
               "  ORDER BY psgcseq,psgc006,psgc002,psgc003 "
   #end add-point
 
   PREPARE apsp830_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp830_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].psgcseq,g_detail_d[l_ac].psgc006,g_detail_d[l_ac].psgc006_desc,
      g_detail_d[l_ac].psgc002,g_detail_d[l_ac].psgc002_desc,g_detail_d[l_ac].psgc002_desc_desc,
      g_detail_d[l_ac].psgc003,g_detail_d[l_ac].psgc003_desc,g_detail_d[l_ac].imaf141,
      g_detail_d[l_ac].imaf141_desc,g_detail_d[l_ac].psgc007,g_detail_d[l_ac].qty,
      g_detail_d[l_ac].imaa006,g_detail_d[l_ac].imaa006_desc,g_detail_d[l_ac].psgc004,
      g_detail_d[l_ac].imae012,g_detail_d[l_ac].imae012_desc,g_detail_d[l_ac].psgc008
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

      CALL cl_err_collect_init()
      
      IF NOT s_control_check_item(g_detail_d[l_ac].psgc002,'5',tm.psgc005,g_user,g_dept,tm.indcdocno) THEN
         CONTINUE FOREACH
      END IF
      
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()

      #end add-point
      
      CALL apsp830_detail_show()      
 
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
   FREE apsp830_sel
   
   LET l_ac = 1
   CALL apsp830_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp830.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp830_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
 
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
   CALL g_detail2_d.clear()

   LET g_sql = " SELECT UNIQUE inddseq,indd022,'',indd023,'',indd024,indd102, ",
               "               indd006,'',indd103,indd032,'',indd033,'' ",
               "   FROM apsp830_tmp ",
               "  WHERE psgcseq = '",g_detail_d[g_detail_idx].psgcseq,"' ",
               "  ORDER BY indd022,indd023,indd024,indd102 "
   PREPARE apsp830_sel2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apsp830_sel2
   
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO 
      g_detail2_d[l_ac].inddseq,g_detail2_d[l_ac].indd022,g_detail2_d[l_ac].indd022_desc,
      g_detail2_d[l_ac].indd023,g_detail2_d[l_ac].indd023_desc,g_detail2_d[l_ac].indd024,
      g_detail2_d[l_ac].indd102,g_detail2_d[l_ac].indd006,g_detail2_d[l_ac].indd006_desc,
      g_detail2_d[l_ac].indd103,g_detail2_d[l_ac].indd032,g_detail2_d[l_ac].indd032_desc,
      g_detail2_d[l_ac].indd033,g_detail2_d[l_ac].indd033_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      CALL s_desc_get_stock_desc(tm.psgc005,g_detail2_d[l_ac].indd022) RETURNING g_detail2_d[l_ac].indd022_desc
      
      CALL s_desc_get_locator_desc(tm.psgc005,g_detail2_d[l_ac].indd022,g_detail2_d[l_ac].indd023) RETURNING g_detail2_d[l_ac].indd023_desc
      
      CALL s_desc_get_unit_desc(g_detail2_d[l_ac].indd006) RETURNING g_detail2_d[l_ac].indd006_desc
      
      CALL s_desc_get_stock_desc(g_detail_d[g_detail_idx].psgc006,g_detail2_d[l_ac].indd032) RETURNING g_detail2_d[l_ac].indd032_desc
      
      CALL s_desc_get_locator_desc(g_detail_d[g_detail_idx].psgc006,g_detail2_d[l_ac].indd032,g_detail2_d[l_ac].indd033) RETURNING g_detail2_d[l_ac].indd033_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH

   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())   

   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsp830.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp830_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"

   #撥入營運據點
   CALL s_desc_get_department_desc(g_detail_d[l_ac].psgc006) RETURNING g_detail_d[l_ac].psgc006_desc
   
   #料件編號
   CALL s_desc_get_item_desc(g_detail_d[l_ac].psgc002) RETURNING g_detail_d[l_ac].psgc002_desc,g_detail_d[l_ac].psgc002_desc_desc
   
   #產品特徵
   CALL s_feature_description(g_detail_d[l_ac].psgc002,g_detail_d[l_ac].psgc003) RETURNING l_success,g_detail_d[l_ac].psgc003_desc
   
   #採購分類
   CALL s_desc_get_acc_desc('203',g_detail_d[l_ac].imaf141) RETURNING g_detail_d[l_ac].imaf141_desc
   
   #單位
   CALL s_desc_get_unit_desc(g_detail_d[l_ac].imaa006) RETURNING g_detail_d[l_ac].imaa006_desc
   
   #計畫員
   CALL s_desc_get_person_desc(g_detail_d[l_ac].imae012) RETURNING g_detail_d[l_ac].imae012_desc

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp830.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp830_filter()
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
   
   CONSTRUCT g_wc_filter ON psgcseq,psgc006,psgc002,psgc003,imaf141,
                            psgc007,imaa006,psgc004,imae012,psgc008
        FROM s_detail1[1].psgcseq,s_detail1[1].psgc006,s_detail1[1].psgc002,s_detail1[1].psgc003,s_detail1[1].imaf141,
             s_detail1[1].psgc007,s_detail1[1].imaa006,s_detail1[1].psgc004,s_detail1[1].imae012,s_detail1[1].psgc008

      BEFORE CONSTRUCT
         
      ON ACTION controlp INFIELD psgc006        #撥入營運據點
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_psfb003()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO psgc006  #顯示到畫面上
         NEXT FIELD psgc006                     #返回原欄位
      
      ON ACTION controlp INFIELD psgc003        #料件編號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaf001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO psgc003  #顯示到畫面上
         NEXT FIELD psgc003                     #返回原欄位    
         
      ON ACTION controlp INFIELD imaf141        #採購分類
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imce141()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
         NEXT FIELD imaf141                     #返回原欄位
       
      ON ACTION controlp INFIELD imaa006        #單位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO imaa006  #顯示到畫面上
         NEXT FIELD imaa006                     #返回原欄位
         
      ON ACTION controlp INFIELD imae012        #計畫員
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO imae012  #顯示到畫面上
         NEXT FIELD imae012                     #返回原欄位
       
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp830_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp830.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp830_filter_parser(ps_field)
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
 
{<section id="apsp830.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp830_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp830_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp830.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 取得集團MRP版本說明
# Memo...........:
# Usage..........: CALL apsp830_psfa001_ref(p_psfal001)
#                  RETURNING r_psfal003
# Input parameter: p_psfal001   集團MRP版本
# Return code....: r_psfal003   說明
# Date & Author..: 141210 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_psfa001_ref(p_psfal001)
DEFINE p_psfal001  LIKE psfal_t.psfal001
DEFINE r_psfal003  LIKE psfal_t.psfal003

   LET r_psfal003 = ''
   SELECT psfal003 INTO r_psfal003
     FROM psfal_t
    WHERE psfalent = g_enterprise
      AND psfal001 = p_psfal001
      AND psfal002 = g_dlang

   RETURN r_psfal003
END FUNCTION

################################################################################
# Descriptions...: 撥出倉儲批檢核
# Memo...........:
# Usage..........: CALL apsp830_inag_chk(p_flag)
#                  RETURNING r_success
# Input parameter: p_flag(1:倉2:儲)
# Return code....: TRUE OR FALSE
# Date & Author..: 141212 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_inag_chk(p_flag)
DEFINE p_flag     LIKE type_t.chr1
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_flag     LIKE type_t.num5
DEFINE l_sql      STRING
DEFINE l_n        LIKE type_t.num5

   LET r_success = TRUE

   IF p_flag = '1' THEN
      IF NOT apsp830_control_group('1',g_site,g_detail2_d[g_detail2_idx].indd022) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   IF p_flag MATCHES "[12]" THEN
      CALL s_control_chk_doc('6',tm.indcdocno,g_detail2_d[g_detail2_idx].indd022,g_detail2_d[g_detail2_idx].indd023,'','','')
           RETURNING l_success,l_flag
      IF NOT l_success OR NOT l_flag THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   LET l_sql = " SELECT COUNT(*) FROM inag_t ",
               "  WHERE inagent = '",g_enterprise,"' ",
               "    AND inagsite= '",g_site,"' ",
               "    AND inag001 = '",g_detail_d[g_detail_idx].psgc002,"' ",
               "    AND inag002 = '",g_detail_d[g_detail_idx].psgc003,"' "
   IF NOT cl_null(g_detail2_d[g_detail2_idx].indd102) THEN
      LET l_sql = l_sql," AND inag003 = '",g_detail2_d[g_detail2_idx].indd102,"' "
   END IF
   IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN
      LET l_sql = l_sql," AND inag004 = '",g_detail2_d[g_detail2_idx].indd022,"' "
   END IF
   IF NOT cl_null(g_detail2_d[g_detail2_idx].indd023) THEN
      LET l_sql = l_sql," AND inag005 = '",g_detail2_d[g_detail2_idx].indd023,"' "
   END IF
   IF NOT cl_null(g_detail2_d[g_detail2_idx].indd024) THEN
      LET l_sql = l_sql," AND inag006 = '",g_detail2_d[g_detail2_idx].indd024,"' "
   END IF
   IF NOT cl_null(g_detail2_d[g_detail2_idx].indd006) THEN
      LET l_sql = l_sql," AND inag007 = '",g_detail2_d[g_detail2_idx].indd006,"' "
   END IF
   
   PREPARE sel_inag_pre1 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre1 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00119'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sql = l_sql," AND inag008 > 0 "
   PREPARE sel_inag_pre2 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre2 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00120'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 數量檢核
# Memo...........:
# Usage..........: CALL apsp830_indd103_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: TRUE OR FALSE
# Date & Author..: 141212 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_indd103_chk()
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_flag     LIKE type_t.num5
DEFINE l_imaf101  LIKE imaf_t.imaf101
DEFINE l_imaf102  LIKE imaf_t.imaf102
DEFINE l_num      LIKE type_t.num5

   LET r_success = TRUE
   
   #數量要大於零
   IF NOT cl_ap_chk_range(g_detail2_d[g_detail2_idx].indd103,"0.000","0","","","azz-00079",1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF 

   #在揀量
   IF NOT cl_null(g_detail2_d[g_detail2_idx].indd022) THEN  
      LET l_success = ''
      LET l_flag = ''      
      CALL s_inventory_check_inan(g_site,g_detail_d[g_detail_idx].psgc002,g_detail_d[g_detail_idx].psgc003,
                                  g_detail2_d[g_detail2_idx].indd102,g_detail2_d[g_detail2_idx].indd022,
                                  g_detail2_d[g_detail2_idx].indd023,g_detail2_d[g_detail2_idx].indd024,
                                  g_detail2_d[g_detail2_idx].indd006,g_detail2_d[g_detail2_idx].indd103,
                                  tm.indcdocno,g_detail2_d[g_detail2_idx].inddseq,'0','','') #160408-00035#9-add-'',''
         RETURNING l_success,l_flag
      IF NOT l_success OR l_flag = 0 THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
   END IF 

   IF NOT apsp830_inag_chk('') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF 

   LET l_imaf101 = 0
   LET l_imaf102 = 0
   SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = g_detail_d[g_detail_idx].psgc002
   IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
   IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
   #申請數量不可小於撥出據點最小調撥批量！
   IF g_detail2_d[g_detail2_idx].indd103 < l_imaf102 THEN                  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00339'
      LET g_errparam.extend = g_detail2_d[g_detail2_idx].indd103
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #申請數量必須是撥出據點調撥批量的整數倍！
   IF l_imaf101 <> 0 THEN 
      LET l_num = g_detail2_d[g_detail2_idx].indd103 MOD l_imaf101
      IF l_num <> 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00340'
         LET g_errparam.extend = g_detail2_d[g_detail2_idx].indd103
         LET g_errparam.popup = TRUE
         CALL cl_err()       
         LET r_success = FALSE
         RETURN r_success
      END IF 
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 撥入倉儲批檢核
# Memo...........:
# Usage..........: CALL apsp830_indd_chk(p_flag)
#                  RETURNING r_success
# Input parameter: p_flag(1:倉2:儲)
# Return code....: TRUE OR FALSE
# Date & Author..: 141212 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_indd_chk(p_flag)
DEFINE p_flag     LIKE type_t.chr1
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_flag     LIKE type_t.num5

   LET r_success = TRUE

   IF p_flag = '1' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_detail_d[g_detail_idx].psgc006
      LET g_chkparam.arg2 = g_detail2_d[g_detail2_idx].indd032
       #160318-00025#21  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
      #160318-00025#21  by 07900 --add-end
      IF NOT cl_chk_exist("v_inaa001") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT apsp830_control_group('2',g_detail_d[g_detail_idx].psgc006,g_detail2_d[g_detail2_idx].indd032) THEN     
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   IF p_flag = '2' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_detail_d[g_detail_idx].psgc006
      LET g_chkparam.arg2 = g_detail2_d[g_detail2_idx].indd032
      LET g_chkparam.arg3 = g_detail2_d[g_detail2_idx].indd033
      #160318-00025#21  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
      #160318-00025#21  by 07900 --add-end
      IF NOT cl_chk_exist("v_inab002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   CALL s_control_chk_doc('7',tm.indcdocno,g_detail2_d[g_detail2_idx].indd032,g_detail2_d[g_detail2_idx].indd033,'','','')
        RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 檢查當前庫位與單身中的其他項次對應的庫位是否存在相同的控制組
# Memo...........:
# Usage..........: CALL apsp830_control_group(p_flag,p_site,p_stock)
#                  RETURNING r_success
# Input parameter: p_flag   1:indd022/2:indd032
#                : p_site   營運據點
#                : p_stock  庫位
# Return code....: TRUE OR FALSE
# Date & Author..: 141212 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_control_group(p_flag,p_site,p_stock)
DEFINE p_flag       LIKE type_t.chr1
DEFINE p_site       LIKE indd_t.inddsite
DEFINE p_stock      LIKE indd_t.indd022
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_stock      LIKE indd_t.indd022
DEFINE l_oohl001    LIKE oohl_t.oohl001
DEFINE l_n          LIKE type_t.num5
DEFINE l_n1         LIKE type_t.num5
DEFINE l_n2         LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5

   LET r_success = TRUE

   CASE p_flag
      WHEN '1'
         LET l_sql = " SELECT DISTINCT indd022 "
      WHEN '2'
         LET l_sql = " SELECT DISTINCT indd032 "
      OTHERWISE EXIT CASE
   END CASE

   LET l_sql = l_sql," FROM apsp830_tmp WHERE inddent = '",g_enterprise,
                     #考慮到修改資料時，修改前的資料不需要再進行檢查
                     "  AND inddseq <> '",g_detail2_d[g_detail2_idx].inddseq,"' "
   PREPARE control_group_sel FROM l_sql
   DECLARE control_group_curs CURSOR FOR control_group_sel

   #獲得控制組編號
   LET l_sql = " SELECT oohl001 FROM oohl_t WHERE oohlent = '",g_enterprise,
               "    AND oohl002 = '",p_site,"' AND oohl003 = ? "
   PREPARE control_group_oohl001_sel FROM l_sql
   DECLARE control_group_oohl001_curs CURSOR FOR control_group_oohl001_sel

   LET l_flag = TRUE
   LET l_n1 = 0
   LET l_n2 = 0
   LET l_stock = ''
   FOREACH control_group_curs INTO l_stock
      #單身是否有資料
      LET l_n1 = l_n1 + 1
      
      LET l_oohl001 = ''
      FOREACH control_group_oohl001_curs USING l_stock INTO l_oohl001
         #判断其他单身的库位是否存在控制组
         LET l_n2 = l_n2 + 1

         #判斷當前輸入的庫位編號是否存在其他庫位編號的控制組中
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM oohl_t
          WHERE oohlent = g_enterprise AND oohl001 = l_oohl001
            AND oohl002 = p_site AND oohl003 = p_stock
         #存在一個相同的控制組編號，則其他的控制組編號無需再判斷
         IF l_n > 0 THEN
            LET l_flag = TRUE
            EXIT FOREACH
         ELSE
            LET l_flag = FALSE
         END IF

         LET l_oohl001 = ''
      END FOREACH
      
      #如果已經有一筆庫位的控制組編號與當前庫位不存在相同的控制組，則其他的單身庫位也無需在進行檢查
      IF NOT l_flag THEN
         EXIT FOREACH
      END IF
   
      LET l_stock = ''
   END FOREACH
   
   CLOSE control_group_curs
   CLOSE control_group_oohl001_curs
   FREE control_group_sel
   FREE control_group_oohl001_sel

   #如果其他单身的库位都不存在控制组中且單身有其他資料，再判断当前库位是否有控制组，若有，则报错
   IF l_n2 = 0 AND l_n1 > 0 THEN
      LET l_n = 0
      SELECT COUNT(oohl001) INTO l_n FROM oohl_t
        WHERE oohlent = g_enterprise AND oohl002 = p_site AND oohl003 = p_stock
      IF l_n > 0 THEN
         LET l_flag = FALSE
      END IF
   END IF

   IF NOT l_flag THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00274'
      LET g_errparam.extend = p_stock
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 產生兩階段撥出單(aint340)
# Memo...........:
# Usage..........: CALL apsp830_batch_execute()
# Input parameter: 
# Return code....: 
# Date & Author..: 141216 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_batch_execute()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE la_param  RECORD
    prog     STRING,
    param    DYNAMIC ARRAY OF STRING
             END RECORD
DEFINE l_success      LIKE type_t.num5
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_str          STRING               #開啟apmt510傳入的參數
DEFINE l_psgc006      LIKE psgc_t.psgc006
DEFINE l_indcdocno    LIKE indc_t.indcdocno
DEFINE l_g_site       LIKE type_t.chr10

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
   END IF

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_tot_success = TRUE
   LET l_str = ''
   LET l_g_site = g_site
   LET g_site = tm.psgc005

   #將相同撥入營運據點合併為同一張單
   LET l_psgc006 = ''
   DECLARE apsp830_batch_execute_cur CURSOR FOR
      SELECT DISTINCT psgc006 FROM apsp830_tmp
   FOREACH apsp830_batch_execute_cur INTO l_psgc006
      IF NOT l_success THEN
         LET l_tot_success = FALSE
         LET l_success = TRUE
      END IF
      
      CALL apsp830_ins_indc(l_psgc006) RETURNING l_success,l_indcdocno
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF

      IF cl_null(l_str) THEN
         LET l_str = " indcdocno = '",l_indcdocno,"' "
      ELSE
         LET l_str = l_str," OR indcdocno = '",l_indcdocno,"' "
      END IF

      CALL apsp830_ins_indd(l_indcdocno,l_psgc006) RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF

      LET l_psgc006 = ''
   END FOREACH

   CALL cl_err_collect_show()

   IF NOT l_success OR NOT l_tot_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN
         LET la_param.prog = 'aint340'
         LET la_param.param[1] = ''
         LET la_param.param[2] = l_str
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
   END IF

   IF g_bgjob = "N" THEN
      #前景作業完成處理
      CALL cl_ask_confirm3("std-00012","")
   END IF

   LET g_site = l_g_site

END FUNCTION

################################################################################
# Descriptions...: 調撥單單頭檔
# Memo...........:
# Usage..........: CALL apsp830_ins_indc(p_psgc006)
#                  RETURNING r_success
# Input parameter: p_psgc006   撥入營運據點
# Return code....: r_success   處理狀態
#                : r_indcdocno 單號
# Date & Author..: 141216 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_ins_indc(p_psgc006)
DEFINE p_psgc006    LIKE psgc_t.psgc006
DEFINE r_success    LIKE type_t.num5
DEFINE l_indc  RECORD
    indcent    LIKE indc_t.indcent,    #企業編號
    indcsite   LIKE indc_t.indcsite,   #營運據點
    indcunit   LIKE indc_t.indcunit,   #應用組織
    indcdocno  LIKE indc_t.indcdocno,  #調撥單號
    indcdocdt  LIKE indc_t.indcdocdt,  #調撥日期
    indc000    LIKE indc_t.indc000,    #單據性質
    indc001    LIKE indc_t.indc001,    #對應調撥單號
    indc002    LIKE indc_t.indc002,    #來源類別
    indc003    LIKE indc_t.indc003,    #來源單號
    indc004    LIKE indc_t.indc004,    #調撥人員
    indc005    LIKE indc_t.indc005,    #撥出營運據點
    indc006    LIKE indc_t.indc006,    #撥入營運據點
    indc007    LIKE indc_t.indc007,    #在途倉
    indc008    LIKE indc_t.indc008,    #備註
    indc021    LIKE indc_t.indc021,    #撥出確認人員
    indc022    LIKE indc_t.indc022,    #撥出確認日期
    indc023    LIKE indc_t.indc023,    #撥入確認人員
    indc024    LIKE indc_t.indc024,    #撥入確認日期
    indcstus   LIKE indc_t.indcstus,   #狀態碼
    indcownid  LIKE indc_t.indcownid,  #資料所有者
    indcowndp  LIKE indc_t.indcowndp,  #資料所屬部門
    indccrtid  LIKE indc_t.indccrtid,  #資料建立者
    indccrtdp  LIKE indc_t.indccrtdp,  #資料建立部門
    indccrtdt  LIKE indc_t.indccrtdt,  #資料創建日
    indc101    LIKE indc_t.indc101,    #調撥部門
    indc102    LIKE indc_t.indc102,    #檢驗方式
    indc103    LIKE indc_t.indc103,    #包裝單製作
    indc104    LIKE indc_t.indc104,    #Invoice製作
    indc105    LIKE indc_t.indc105,    #送貨地址
    indc106    LIKE indc_t.indc106,    #運輸方式
    indc107    LIKE indc_t.indc107,    #起運地點
    indc108    LIKE indc_t.indc108,    #到達地點
    indc109    LIKE indc_t.indc109,    #在途非成本庫位
    indc151    LIKE indc_t.indc151     #調撥理由
           END RECORD

   LET r_success = TRUE

   INITIALIZE l_indc.* TO NULL

   CALL s_aooi200_gen_docno(g_site,tm.indcdocno,g_today,'aint340') 
        RETURNING r_success,l_indc.indcdocno
   IF NOT r_success THEN
      RETURN r_success,l_indc.indcdocno
   END IF

   LET l_indc.indcent   = g_enterprise
   LET l_indc.indcsite  = g_site
   LET l_indc.indcunit  = g_site
   LET l_indc.indcdocdt	= g_today
   LET l_indc.indc000   = "2"
   LET l_indc.indc004   = g_user
   LET l_indc.indc005   = g_site
   LET l_indc.indcstus  = "N"
   LET l_indc.indcownid = g_user
   LET l_indc.indcowndp = g_dept
   LET l_indc.indccrtid = g_user
   LET l_indc.indccrtdp = g_dept
   LET l_indc.indccrtdt = cl_get_current()
   LET l_indc.indc101   = g_dept
   LET l_indc.indc102   = "1"
   LET l_indc.indc103   = "N"
   LET l_indc.indc104   = "N"

   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indcunit',l_indc.indcunit) RETURNING l_indc.indcunit
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indcdocdt',l_indc.indcdocdt) RETURNING l_indc.indcdocdt
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc000',l_indc.indc000) RETURNING l_indc.indc000
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc001',l_indc.indc001) RETURNING l_indc.indc001
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc002',l_indc.indc002) RETURNING l_indc.indc002
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc003',l_indc.indc003) RETURNING l_indc.indc003
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc004',l_indc.indc004) RETURNING l_indc.indc004
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc005',l_indc.indc005) RETURNING l_indc.indc005
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc006',l_indc.indc006) RETURNING l_indc.indc006
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc007',l_indc.indc007) RETURNING l_indc.indc007
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc008',l_indc.indc008) RETURNING l_indc.indc008
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc021',l_indc.indc021) RETURNING l_indc.indc021
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc022',l_indc.indc022) RETURNING l_indc.indc022
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc023',l_indc.indc023) RETURNING l_indc.indc023
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc024',l_indc.indc024) RETURNING l_indc.indc024
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc101',l_indc.indc101) RETURNING l_indc.indc101
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc102',l_indc.indc102) RETURNING l_indc.indc102
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc103',l_indc.indc103) RETURNING l_indc.indc103
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc104',l_indc.indc104) RETURNING l_indc.indc104
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc105',l_indc.indc105) RETURNING l_indc.indc105
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc106',l_indc.indc106) RETURNING l_indc.indc106
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc107',l_indc.indc107) RETURNING l_indc.indc107
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc108',l_indc.indc108) RETURNING l_indc.indc108
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc109',l_indc.indc109) RETURNING l_indc.indc109
   CALL s_aooi200_get_doc_default(g_site,'1',l_indc.indcdocno,'indc151',l_indc.indc151) RETURNING l_indc.indc151

   LET l_indc.indc002   = "1"  #1.手動輸入
   LET l_indc.indc003   = ""
   LET l_indc.indc006   = p_psgc006
   LET l_indc.indc007   = tm.indc007
   LET l_indc.indc008   = tm.indc109
   LET l_indc.indc109   = tm.indc109

   INSERT INTO indc_t(indcent,indcsite,indcunit,indcdocno,indcdocdt,indc000,
                      indc001,indc002,indc003,indc004,indc005,indc006,indc007,indc008,indc021,indc022,
                      indc023,indc024,indcstus,indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt,
                      indc101,indc102,indc103,indc104,indc105,indc106,indc107,indc108,indc109,indc151)
               VALUES(l_indc.indcent,l_indc.indcsite,l_indc.indcunit,l_indc.indcdocno,l_indc.indcdocdt,
                      l_indc.indc000,l_indc.indc001,l_indc.indc002,l_indc.indc003,l_indc.indc004,
                      l_indc.indc005,l_indc.indc006,l_indc.indc007,l_indc.indc008,l_indc.indc021,
                      l_indc.indc022,l_indc.indc023,l_indc.indc024,l_indc.indcstus,
                      l_indc.indcownid,l_indc.indcowndp,l_indc.indccrtid,l_indc.indccrtdp,l_indc.indccrtdt,
                      l_indc.indc101,l_indc.indc102,l_indc.indc103,l_indc.indc104,l_indc.indc105,
                      l_indc.indc106,l_indc.indc107,l_indc.indc108,l_indc.indc109,l_indc.indc151)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'ins indc_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF

   RETURN r_success,l_indc.indcdocno

END FUNCTION

################################################################################
# Descriptions...: 調撥單單身明細檔
# Memo...........:
# Usage..........: CALL apsp830_ins_indd(p_indcdocno,p_psgc006)
#                  RETURNING r_success
# Input parameter: p_indcdocno 單號
#                : p_psgc006   撥入營運據點
# Return code....: r_success   處理狀態
# Date & Author..: 141216 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp830_ins_indd(p_indcdocno,p_psgc006)
DEFINE p_indcdocno  LIKE indc_t.indcdocno
DEFINE p_psgc006    LIKE psgc_t.psgc006
DEFINE r_success    LIKE type_t.num5
DEFINE l_seq        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_rate       LIKE type_t.num5
DEFINE l_psgcseq    LIKE psgc_t.psgcseq
DEFINE l_indd  RECORD
    inddent    LIKE indd_t.inddent,    #企業編號
    inddsite   LIKE indd_t.inddsite,   #營運據點
    inddunit   LIKE indd_t.inddunit,   #應用組織
    indddocno  LIKE indd_t.indddocno,  #調撥單號
    inddseq    LIKE indd_t.inddseq,    #項次
    indd002    LIKE indd_t.indd002,    #商品編號
    indd004    LIKE indd_t.indd004,    #產品特徵
    indd006    LIKE indd_t.indd006,    #庫存單位
    indd021    LIKE indd_t.indd021,    #撥出數量
    indd022    LIKE indd_t.indd022,    #撥出庫位
    indd023    LIKE indd_t.indd023,    #撥出儲位
    indd024    LIKE indd_t.indd024,    #撥出批號
    indd031    LIKE indd_t.indd031,    #撥入數量
    indd032    LIKE indd_t.indd032,    #撥入庫位
    indd033    LIKE indd_t.indd033,    #撥入儲位
    indd034    LIKE indd_t.indd034,    #撥入批號
    indd040    LIKE indd_t.indd040,    #結案否
    indd102    LIKE indd_t.indd102,    #庫存管理特徵
    indd103    LIKE indd_t.indd103,    #撥出申請量
    indd104    LIKE indd_t.indd104,    #參考單位
    indd105    LIKE indd_t.indd105,    #撥出申請參考數量	
    indd106    LIKE indd_t.indd106,    #撥出合格參考數量	
    indd107    LIKE indd_t.indd107,    #撥入申請數量
    indd108    LIKE indd_t.indd108,    #撥入申請參考數量
    indd109    LIKE indd_t.indd109,    #撥入合格參考數量
    indd110    LIKE indd_t.indd110,    #差異量
    indd112    LIKE indd_t.indd112     #差異已調整量
           END RECORD

   LET r_success = TRUE

   LET l_seq = 0

   INITIALIZE l_indd.* TO NULL

   DECLARE apsp830_ins_indd_cur CURSOR FOR
      SELECT indd002,indd004,indd022,indd023,indd024,
             indd102,indd006,indd103,indd032,indd033
        FROM apsp830_tmp
       WHERE psgc006 = p_psgc006
   FOREACH apsp830_ins_indd_cur
      INTO l_indd.indd002,l_indd.indd004,l_indd.indd022,l_indd.indd023,l_indd.indd024,
           l_indd.indd102,l_indd.indd006,l_indd.indd103,l_indd.indd032,l_indd.indd033

      LET l_seq = l_seq + 1
      
      LET l_indd.inddent   = g_enterprise
      LET l_indd.inddsite  = g_site
      LET l_indd.inddunit  = g_site
      LET l_indd.indddocno = p_indcdocno
      LET l_indd.inddseq   = l_seq
      LET l_indd.indd021   = l_indd.indd103
      LET l_indd.indd031   = l_indd.indd103
      LET l_indd.indd034   = l_indd.indd024
      LET l_indd.indd040   = "N"
      LET l_indd.indd107   = l_indd.indd103
      LET l_indd.indd110   = 0
      LET l_indd.indd112   = 0
      SELECT imaf015 INTO l_indd.indd104 FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = l_indd.indd002
      #modify--2015/01/08 By shiun--(S)
#      CALL s_aimi190_get_convert(l_indd.indd002,l_indd.indd006,l_indd.indd104) 
#           RETURNING l_success,l_rate
      CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd104,l_indd.indd103)
           RETURNING l_success,l_indd.indd105
      #modify--2015/01/08 By shiun--(E)
      IF l_success THEN           
#         LET l_indd.indd105 = l_indd.indd103 * l_rate #mark--2015/01/08 By shiun
         CALL s_aooi250_take_decimals(l_indd.indd104,l_indd.indd105) RETURNING l_success,l_indd.indd105  
         LET l_indd.indd106 = l_indd.indd105
         LET l_indd.indd108 = l_indd.indd105
         LET l_indd.indd109 = l_indd.indd105
      END IF
      IF cl_null(l_indd.indd105) THEN LET l_indd.indd105 = 0 END IF
      IF cl_null(l_indd.indd106) THEN LET l_indd.indd106 = 0 END IF
      IF cl_null(l_indd.indd108) THEN LET l_indd.indd108 = 0 END IF
      IF cl_null(l_indd.indd109) THEN LET l_indd.indd109 = 0 END IF

      INSERT INTO indd_t(inddent,inddsite,inddunit,indddocno,inddseq,indd002,indd004,
                         indd006,indd021,indd022,indd023,indd024,indd031,indd032,indd033,indd034,indd040,
                         indd102,indd103,indd104,indd105,indd106,indd107,indd108,indd109,indd110,indd112)
                  VALUES(l_indd.inddent,l_indd.inddsite,l_indd.inddunit,l_indd.indddocno,
                         l_indd.inddseq,l_indd.indd002,l_indd.indd004,l_indd.indd006,
                         l_indd.indd021,l_indd.indd022,l_indd.indd023,l_indd.indd024,
                         l_indd.indd031,l_indd.indd032,l_indd.indd033,l_indd.indd034,l_indd.indd040,
                         l_indd.indd102,l_indd.indd103,l_indd.indd104,l_indd.indd105,l_indd.indd106,
                         l_indd.indd107,l_indd.indd108,l_indd.indd109,l_indd.indd110,l_indd.indd112)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins indd_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      INITIALIZE l_indd.* TO NULL
   END FOREACH

   IF r_success THEN
      LET l_psgcseq = ''
      DECLARE get_psgcseq_cur CURSOR FOR
         SELECT DISTINCT psgcseq
           FROM apsp830_tmp
          WHERE psgc006 = p_psgc006
      FOREACH get_psgcseq_cur INTO l_psgcseq
         UPDATE psgc_t set psgc008 = 'Y'
          WHERE psgcent = g_enterprise
            AND psgc001 = tm.psgc001
            AND psgcseq = l_psgcseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'upd psgc_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         LET l_psgcseq = ''
      END FOREACH
   END IF

   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
