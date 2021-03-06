#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp441.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-03-12 11:50:28), PR版次:0003(2016-08-17 16:00:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: axmp441
#+ Description: 銷售合約差異金額調整作業
#+ Creator....: 04441(2015-03-06 09:19:17)
#+ Modifier...: 04441 -SD/PR- 08734
 
{</section>}
 
{<section id="axmp441.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#38   2016/04/20  By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160816-00001#11  2016/08/17  By 08734     抓取理由碼改CALL sub
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
        type             LIKE type_t.chr1,
        docno            LIKE ooba_t.ooba002,
        xmdl050          LIKE xmdl_t.xmdl050,
        item             LIKE xmdl_t.xmdl008,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
    sel                LIKE type_t.chr1,
    xmde001            LIKE xmde_t.xmde001,
    xmde002            LIKE xmde_t.xmde002,
    xmde005            LIKE xmde_t.xmde005,
    xmdx004            LIKE xmdx_t.xmdx004,
    xmdx004_desc       LIKE pmaal_t.pmaal004,
    xmde006            LIKE xmde_t.xmde006,
    xmde006_desc       LIKE imaal_t.imaal003,
    xmde006_desc_desc  LIKE imaal_t.imaal004,
    xmde007            LIKE xmde_t.xmde007,
    xmde007_desc       LIKE type_t.chr80,
    xmde003            LIKE xmde_t.xmde003,
    xmde004            LIKE xmde_t.xmde004,
    xmde017            LIKE xmde_t.xmde017,
    xmde018            LIKE xmde_t.xmde018,
    xmde019            LIKE xmde_t.xmde019,
    xmde020            LIKE xmde_t.xmde020,
    xmde021            LIKE xmde_t.xmde021,
    xmde014            LIKE xmde_t.xmde014,
    xmde015            LIKE xmde_t.xmde015,
    xmde016            LIKE xmde_t.xmde016,
    xmde010            LIKE xmde_t.xmde010,
    xmde011            LIKE xmde_t.xmde011,
    xmde012            LIKE xmde_t.xmde012,
    xmde013            LIKE xmde_t.xmde013
                   END RECORD
TYPE type_g_detail2_d  RECORD
    xmdk007            LIKE xmdk_t.xmdk007,
    xmdk007_desc       LIKE pmaal_t.pmaal004,
    xmdk010            LIKE xmdk_t.xmdk010,
    xmdk010_desc       LIKE ooibl_t.ooibl004,
    xmdk011            LIKE xmdk_t.xmdk011,
    xmdk011_desc       LIKE oocql_t.oocql004,
    xmdk012            LIKE xmdk_t.xmdk012,
    xmdk012_desc       LIKE oodbl_t.oodbl004,
    xmdk013            LIKE xmdk_t.xmdk013,
    xmdk014            LIKE xmdk_t.xmdk014,
    xmdk016            LIKE xmdk_t.xmdk016,
    xmdk016_desc       LIKE ooail_t.ooail003,
    xmdk017            LIKE xmdk_t.xmdk017,
    xmdxdocno          LIKE xmdx_t.xmdxdocno
                   END RECORD
TYPE type_g_detail3_d  RECORD
    xmdlseq            LIKE xmdl_t.xmdlseq,
    xmdl008            LIKE xmdl_t.xmdl008,
    xmdl008_desc       LIKE imaal_t.imaal003,
    xmdl008_desc_desc  LIKE imaal_t.imaal004,
    xmdl009            LIKE xmdl_t.xmdl009,
    xmdl009_desc       LIKE type_t.chr80,
    xmdl017            LIKE xmdl_t.xmdl017,
    xmdl017_desc       LIKE oocal_t.oocal003,
    xmdl018            LIKE xmdl_t.xmdl018,
    xmdl019            LIKE xmdl_t.xmdl019,
    xmdl019_desc       LIKE oocal_t.oocal003,
    xmdl020            LIKE xmdl_t.xmdl020,
    xmdl021            LIKE xmdl_t.xmdl021,
    xmdl021_desc       LIKE oocal_t.oocal003,
    xmdl022            LIKE xmdl_t.xmdl022,
    xmdl025            LIKE xmdl_t.xmdl025,
    xmdl025_desc       LIKE oodbl_t.oodbl004,
    xmdl026            LIKE xmdl_t.xmdl026,
    xmdl024            LIKE xmdl_t.xmdl024,
    xmdl027            LIKE xmdl_t.xmdl027,
    xmdl028            LIKE xmdl_t.xmdl028,
    xmdl029            LIKE xmdl_t.xmdl029,
    xmdl050            LIKE xmdl_t.xmdl050,
    xmdl050_desc       LIKE type_t.chr80,
    xmdl094            LIKE xmdl_t.xmdl094,
    xmdl095            LIKE xmdl_t.xmdl095
                   END RECORD
DEFINE g_detail2_idx   LIKE type_t.num5
DEFINE g_detail3_idx   LIKE type_t.num5
DEFINE g_detail2_cnt   LIKE type_t.num10
DEFINE g_detail3_cnt   LIKE type_t.num10
DEFINE g_detail2_d     DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d     DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail2_d_o   type_g_detail2_d
DEFINE g_detail3_d_o   type_g_detail3_d
DEFINE g_param         type_parameter
DEFINE g_param_o       type_parameter

DEFINE g_ooef004       LIKE ooef_t.ooef004
DEFINE g_gzcb004       LIKE gzcb_t.gzcb004

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp441.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp441 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp441_init()   
 
      #進入選單 Menu (="N")
      CALL axmp441_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp441
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_axmp441_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp441.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp441_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_param.type = '1'
   
   LET g_ooef004 = ''
   SELECT ooef004 INTO g_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_site 
      AND ooefstus = 'Y'
   
   LET g_gzcb004 = ''
   #160816-00001#11  2016/08/17  By 08734 Mark
  # SELECT gzcb004 INTO g_gzcb004
  #   FROM gzcb_t
  #  WHERE gzcb001 = '24'
  #    AND gzcb002 = 'axmt600'
   LET g_gzcb004 = s_fin_get_scc_value('24','axmt600','2')  #160816-00001#11  2016/08/17  By 08734 add

   CALL s_axmp441_create_tmp_table()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp441.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp441_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE ls_result          STRING
   DEFINE l_docno_desc       LIKE oobal_t.oobal004
   DEFINE l_xmdl050_desc     LIKE type_t.chr80
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.num5
   DEFINE l_where            STRING
   DEFINE l_oodbl004         LIKE oodbl_t.oodbl004
   DEFINE l_oodb005          LIKE oodb_t.oodb005
   DEFINE l_oodb006          LIKE oodb_t.oodb006
   DEFINE l_oodb011          LIKE oodb_t.oodb011
   DEFINE l_xmdk007          LIKE xmdk_t.xmdk007
   DEFINE l_xmdk016          LIKE xmdk_t.xmdk016
   DEFINE l_xmdk017          LIKE xmdk_t.xmdk017
   DEFINE l_xrcd113          LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114          LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115          LIKE xrcd_t.xrcd115
   DEFINE l_cnt              LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   DELETE FROM axmp441_tmp
   DELETE FROM axmp441_tmp1
   DELETE FROM axmp441_tmp2
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp441_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_param.wc ON xmdxdocno,xmdx004,xmde006,imaa009,xmdx002,
                                         xmdx003,imaf111,xmdx015,xmde005
         
            AFTER FIELD xmdx015
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)
         
            ON ACTION controlp INFIELD xmdxdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " xmdxstus = 'Y' "
               CALL q_xmdxdocno()
               DISPLAY g_qryparam.return1 TO xmdxdocno
               NEXT FIELD xmdxdocno
         
            ON ACTION controlp INFIELD xmdx004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xmdx004
               NEXT FIELD xmdx004
         
            ON ACTION controlp INFIELD xmde006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO xmde006
               NEXT FIELD xmde006
         
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009
         
            ON ACTION controlp INFIELD xmdx002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO xmdx002
               NEXT FIELD xmdx002
         
            ON ACTION controlp INFIELD xmdx003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_3()
               DISPLAY g_qryparam.return1 TO xmdx003
               NEXT FIELD xmdx003
         
            ON ACTION controlp INFIELD imaf111
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf111()
               DISPLAY g_qryparam.return1 TO imaf111
               NEXT FIELD imaf111
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_param.type,g_param.docno,g_param.xmdl050,g_param.item
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            BEFORE INPUT
               CALL cl_set_comp_required("item",FALSE)
               IF g_param.type = '2' THEN
                  CALL cl_set_comp_required("item",TRUE)
               END IF
               LET g_param_o.* = g_param.*
               
            AFTER FIELD type
               IF NOT cl_null(g_param.type) THEN
                  IF g_param.type <> g_param_o.type OR cl_null(g_param_o.type) THEN
                     IF NOT axmp441_del_tmp_chk() THEN
                        LET g_param.type = g_param_o.type
                     END IF
                     CALL cl_set_comp_required("item",FALSE)
                     IF g_param.type = '2' THEN
                        CALL cl_set_comp_required("item",TRUE)
                     END IF
                  END IF
               END IF
               LET g_param_o.type = g_param.type
                
            AFTER FIELD docno
               DISPLAY '' TO docno_desc
               IF NOT cl_null(g_param.docno) THEN
                  IF g_param.docno <> g_param_o.docno OR cl_null(g_param_o.docno) THEN
                     IF NOT axmp441_del_tmp_chk() THEN
                        LET g_param.docno = g_param_o.docno
                     END IF
                     IF NOT s_aooi200_chk_slip(g_site,'',g_param.docno,'axmt600') THEN
                        LET g_param.docno = g_param_o.docno
                        DISPLAY BY NAME g_param.docno
                        CALL s_aooi200_get_slip_desc(g_param.docno)
                             RETURNING l_docno_desc
                        DISPLAY l_docno_desc TO docno_desc
                        NEXT FIELD CURRENT
                     END IF
                     #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
                     CALL s_control_chk_doc('1',g_param.docno,'2',g_user,g_dept,'','')
                          RETURNING l_success,l_flag
                     IF NOT l_success OR NOT l_flag THEN
                        LET g_param.docno = g_param_o.docno
                        DISPLAY BY NAME g_param.docno
                        CALL s_aooi200_get_slip_desc(g_param.docno)
                             RETURNING l_docno_desc
                        DISPLAY l_docno_desc TO docno_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_param.docno)
                    RETURNING l_docno_desc
               DISPLAY l_docno_desc TO docno_desc
               LET g_param_o.docno = g_param.docno
               
            AFTER FIELD xmdl050
               DISPLAY '' TO xmdl050_desc
               IF NOT cl_null(g_param.xmdl050) THEN
                  IF g_param.xmdl050 <> g_param_o.xmdl050 OR cl_null(g_param_o.xmdl050) THEN
                     IF NOT axmp441_del_tmp_chk() THEN
                        LET g_param.xmdl050 = g_param_o.xmdl050
                     END IF
                     IF NOT s_azzi650_chk_exist(g_gzcb004,g_param.xmdl050) THEN
                        LET g_param.xmdl050 = g_param_o.xmdl050
                        DISPLAY BY NAME g_param.xmdl050
                        CALL s_axmp441_reason_ref(g_param.xmdl050)
                             RETURNING l_xmdl050_desc
                        DISPLAY l_xmdl050_desc TO xmdl050_desc
                        NEXT FIELD CURRENT
                     END IF
                     #檢核輸入的理由碼是否在單據別限制範圍內
                     CALL s_control_chk_doc('8',g_param.docno,g_param.xmdl050,'','','','')
                          RETURNING l_success,l_flag
                     IF NOT l_success OR NOT l_flag THEN
                        LET g_param.xmdl050 = g_param_o.xmdl050
                        DISPLAY BY NAME g_param.xmdl050
                        CALL s_axmp441_reason_ref(g_param.xmdl050)
                             RETURNING l_xmdl050_desc
                        DISPLAY l_xmdl050_desc TO xmdl050_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_axmp441_reason_ref(g_param.xmdl050)
                    RETURNING l_xmdl050_desc
               DISPLAY l_xmdl050_desc TO xmdl050_desc
               LET g_param_o.xmdl050 = g_param.xmdl050
               
            AFTER FIELD item
               IF NOT cl_null(g_param.item) THEN
                  IF g_param.item <> g_param_o.item OR cl_null(g_param_o.item) THEN
                     IF NOT axmp441_del_tmp_chk() THEN
                        LET g_param.item = g_param_o.item
                     END IF
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_param.item
                     IF NOT cl_chk_exist("v_imaf001_16") THEN
                        LET g_param.item = g_param_o.item
                        DISPLAY BY NAME g_param.item
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               LET g_param_o.item = g_param.item
            
            ON ACTION controlp INFIELD docno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.docno
               LET g_qryparam.arg1 = g_ooef004
               LET g_qryparam.arg2 = 'axmt600'
               CALL q_ooba002_1()
               LET g_param.docno = g_qryparam.return1
               DISPLAY BY NAME g_param.docno
               CALL s_aooi200_get_slip_desc(g_param.docno)
                    RETURNING l_docno_desc
               DISPLAY l_docno_desc TO docno_desc
               NEXT FIELD docno
               
            ON ACTION controlp INFIELD xmdl050
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.xmdl050
               CALL s_control_get_doc_sql('oocq002',g_param.docno,'8')
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               LET g_qryparam.arg1 = g_gzcb004
               CALL q_oocq002()
               LET g_param.xmdl050 = g_qryparam.return1
               DISPLAY BY NAME g_param.xmdl050
               CALL s_axmp441_reason_ref(g_param.xmdl050)
                    RETURNING l_xmdl050_desc
               DISPLAY l_xmdl050_desc TO xmdl050_desc
               NEXT FIELD xmdl050
               
            ON ACTION controlp INFIELD item
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.item
               CALL s_control_get_item_sql('2',g_site,g_user,g_dept,g_param.docno)
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               CALL q_imaf001_17()
               LET g_param.item = g_qryparam.return1
               DISPLAY BY NAME g_param.item
               NEXT FIELD item
               
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE INPUT
               IF cl_null(g_param.docno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00532'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD docno
               END IF
               IF cl_null(g_param.xmdl050) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00622'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD xmdl050
               END IF
               IF g_param.type = '2' AND cl_null(g_param.item) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00623'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD item
               END IF
               CALL FGL_SET_ARR_CURR(g_master_idx)
               LET g_master_idx = DIALOG.getCurrentRow("s_detail1")

            BEFORE ROW
               LET g_master_idx = DIALOG.getCurrentRow("s_detail1")
               
            ON CHANGE b_sel
               CALL s_axmp441_upd_tmp(g_detail_d[g_master_idx].sel,
                                      g_detail_d[g_master_idx].xmde001,
                                      g_detail_d[g_master_idx].xmde002,
                                      g_detail_d[g_master_idx].xmde003,
                                      g_detail_d[g_master_idx].xmde004,
                                      g_detail_d[g_master_idx].xmde017,
                                      g_detail_d[g_master_idx].xmde018,
                                      g_param.type,g_param.item,g_param.xmdl050)
               CALL axmp441_fetch()
               
         END INPUT
         
         INPUT ARRAY g_detail2_d FROM s_detail2.*
            ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE INPUT
               IF cl_null(g_param.docno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00532'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD docno
               END IF
               IF cl_null(g_param.xmdl050) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00622'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD xmdl050
               END IF
               IF g_param.type = '2' AND cl_null(g_param.item) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00623'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD item
               END IF
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               IF cl_null(g_detail2_idx) OR g_detail2_idx = 0 THEN
                  NEXT FIELD b_sel
               END IF
               LET g_detail2_d_o.* = g_detail2_d[g_detail2_idx].*

            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               CALL axmp441_fetch_1()

            AFTER FIELD b_xmdk007
               LET g_detail2_d[g_detail2_idx].xmdk007_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].xmdk007) THEN
                  IF g_detail2_d[g_detail2_idx].xmdk007 <> g_detail2_d_o.xmdk007 OR cl_null(g_detail2_d_o.xmdk007) THEN
                     IF NOT s_axmt540_client_chk(g_param.docno,'1',g_detail2_d[g_detail2_idx].xmdk007,'') THEN
                        LET g_detail2_d[g_detail2_idx].xmdk007 = g_detail2_d_o.xmdk007
                        CALL s_desc_get_trading_partner_abbr_desc(g_detail2_d[g_detail2_idx].xmdk007)
                             RETURNING g_detail2_d[g_detail2_idx].xmdk007_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_desc_get_trading_partner_abbr_desc(g_detail2_d[g_detail2_idx].xmdk007)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk007_desc
               LET g_detail2_d_o.xmdk007 = g_detail2_d[g_detail2_idx].xmdk007

            AFTER FIELD b_xmdk010
               LET g_detail2_d[g_detail2_idx].xmdk010_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].xmdk010) THEN         
                  IF g_detail2_d[g_detail2_idx].xmdk010 <> g_detail2_d_o.xmdk010 OR cl_null(g_detail2_d_o.xmdk010) THEN
                     IF NOT s_axmt540_receive_condition_chk(g_detail2_d[g_detail2_idx].xmdk007,g_detail2_d[g_detail2_idx].xmdk010) THEN
                        LET g_detail2_d[g_detail2_idx].xmdk010 = g_detail2_d_o.xmdk010
                        CALL s_desc_get_ooib002_desc(g_detail2_d[g_detail2_idx].xmdk010)
                             RETURNING g_detail2_d[g_detail2_idx].xmdk010_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_desc_get_ooib002_desc(g_detail2_d[g_detail2_idx].xmdk010)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk010_desc
               LET g_detail2_d_o.xmdk010 = g_detail2_d[g_detail2_idx].xmdk010

            AFTER FIELD b_xmdk011
               LET g_detail2_d[g_detail2_idx].xmdk011_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].xmdk011) THEN
                  IF g_detail2_d[g_detail2_idx].xmdk010 <> g_detail2_d_o.xmdk010 OR cl_null(g_detail2_d_o.xmdk010) THEN
                     IF NOT s_azzi650_chk_exist('238',g_detail2_d[g_detail2_idx].xmdk011) THEN
                        LET g_detail2_d[g_detail2_idx].xmdk011 = g_detail2_d_o.xmdk011
                        CALL s_desc_get_acc_desc('238',g_detail2_d[g_detail2_idx].xmdk011)
                             RETURNING g_detail2_d[g_detail2_idx].xmdk011_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF            
               END IF 
               CALL s_desc_get_acc_desc('238',g_detail2_d[g_detail2_idx].xmdk011)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk011_desc
               LET g_detail2_d_o.xmdk011 = g_detail2_d[g_detail2_idx].xmdk011

            AFTER FIELD b_xmdk012
               LET g_detail2_d[g_detail2_idx].xmdk012_desc = ''
               IF NOT cl_null(g_detail2_d[g_detail2_idx].xmdk012) THEN 
                  IF g_detail2_d[g_detail2_idx].xmdk012 <> g_detail2_d_o.xmdk012 OR cl_null(g_detail2_d_o.xmdk012) THEN
                     #檢查、取得稅別、單價含稅否
                     CALL s_tax_chk(g_site,g_detail2_d[g_detail2_idx].xmdk012)
                     RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011 
                     IF NOT l_success THEN
                        LET g_detail2_d[g_detail2_idx].xmdk012 = g_detail2_d_o.xmdk012
                        CALL s_desc_get_tax_desc1(g_site,g_detail2_d[g_detail2_idx].xmdk012)
                             RETURNING g_detail2_d[g_detail2_idx].xmdk012_desc
                        NEXT FIELD CURRENT
                     END IF       
                     LET g_detail2_d[g_detail2_idx].xmdk013 = l_oodb006
                     LET g_detail2_d[g_detail2_idx].xmdk014 = l_oodb005
                  END IF
               END IF 
               CALL s_desc_get_tax_desc1(g_site,g_detail2_d[g_detail2_idx].xmdk012)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk012_desc
               LET g_detail2_d_o.xmdk012 = g_detail2_d[g_detail2_idx].xmdk012

         AFTER FIELD b_xmdk016
            LET g_detail2_d[g_detail2_idx].xmdk016_desc = ''
            IF NOT cl_null(g_detail2_d[g_detail2_idx].xmdk016) THEN      
               IF g_detail2_d[g_detail2_idx].xmdk016 <> g_detail2_d_o.xmdk016 OR cl_null(g_detail2_d_o.xmdk016) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site               
                  LET g_chkparam.arg2 = g_detail2_d[g_detail2_idx].xmdk016
                  #160318-00025#38  2016/04/20  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#38  2016/04/20  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_detail2_d[g_detail2_idx].xmdk016 = g_detail2_d_o.xmdk016
                     CALL s_desc_get_currency_desc(g_detail2_d[g_detail2_idx].xmdk016)
                          RETURNING g_detail2_d[g_detail2_idx].xmdk016_desc
                     NEXT FIELD CURRENT
                  END IF
                  #帶出匯率
                  CALL s_axmp441_get_exchange(g_detail2_d[g_detail2_idx].xmdk007,g_detail2_d[g_detail2_idx].xmdk016)
                       RETURNING g_detail2_d[g_detail2_idx].xmdk017
               END IF
            END IF                         
            CALL s_desc_get_currency_desc(g_detail2_d[g_detail2_idx].xmdk016)
                 RETURNING g_detail2_d[g_detail2_idx].xmdk016_desc
            LET g_detail2_d_o.xmdk016 = g_detail2_d[g_detail2_idx].xmdk016

            ON ACTION controlp INFIELD b_xmdk007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].xmdk007
			      #單據別是否設置限用的資料
               CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,g_param.docno)
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF 
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()
               LET g_detail2_d[g_detail2_idx].xmdk007 = g_qryparam.return1
               DISPLAY g_detail2_d[g_detail2_idx].xmdk007 TO b_xmdk007
               CALL s_desc_get_trading_partner_abbr_desc(g_detail2_d[g_detail2_idx].xmdk007)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk007_desc
               NEXT FIELD b_xmdk007

            ON ACTION controlp INFIELD b_xmdk010
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].xmdk010
               LET g_qryparam.arg1 = g_detail2_d[g_detail2_idx].xmdk007
               CALL q_pmad002_3()
               LET g_detail2_d[g_detail2_idx].xmdk010 = g_qryparam.return1
               DISPLAY g_detail2_d[g_detail2_idx].xmdk010 TO b_xmdk010
               CALL s_desc_get_ooib002_desc(g_detail2_d[g_detail2_idx].xmdk010)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk010_desc
               NEXT FIELD b_xmdk010

            ON ACTION controlp INFIELD b_xmdk011
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].xmdk011
               LET g_qryparam.arg1 = '238'
               CALL q_oocq002()
               LET g_detail2_d[g_detail2_idx].xmdk011 = g_qryparam.return1
               DISPLAY g_detail2_d[g_detail2_idx].xmdk011 TO b_xmdk011
               CALL s_desc_get_acc_desc('238',g_detail2_d[g_detail2_idx].xmdk011)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk011_desc
               NEXT FIELD b_xmdk011

            ON ACTION controlp INFIELD b_xmdk012
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].xmdk012
               LET g_qryparam.arg1 = g_site
               CALL q_oodb002_3()
               LET g_detail2_d[g_detail2_idx].xmdk012 = g_qryparam.return1
               DISPLAY g_detail2_d[g_detail2_idx].xmdk012 TO b_xmdk012
               CALL s_desc_get_tax_desc1(g_site,g_detail2_d[g_detail2_idx].xmdk012)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk012_desc
               NEXT FIELD b_xmdk012

            ON ACTION controlp INFIELD b_xmdk016
	   	   	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[g_detail2_idx].xmdk016
               LET g_qryparam.arg1 = g_site
               CALL q_ooaj002_1()
               LET g_detail2_d[g_detail2_idx].xmdk016 = g_qryparam.return1
               DISPLAY g_detail2_d[g_detail2_idx].xmdk016 TO b_xmdk016
               CALL s_desc_get_currency_desc(g_detail2_d[g_detail2_idx].xmdk016)
                    RETURNING g_detail2_d[g_detail2_idx].xmdk016_desc
               NEXT FIELD b_xmdk016

            ON ROW CHANGE
               UPDATE axmp441_tmp1
                  SET xmdk007 = g_detail2_d[g_detail2_idx].xmdk007,
                      xmdk010 = g_detail2_d[g_detail2_idx].xmdk010,
                      xmdk011 = g_detail2_d[g_detail2_idx].xmdk011,
                      xmdk012 = g_detail2_d[g_detail2_idx].xmdk012,
                      xmdk013 = g_detail2_d[g_detail2_idx].xmdk013,
                      xmdk014 = g_detail2_d[g_detail2_idx].xmdk014,
                      xmdk016 = g_detail2_d[g_detail2_idx].xmdk016,
                      xmdk017 = g_detail2_d[g_detail2_idx].xmdk017
                WHERE xmdxdocno = g_detail2_d[g_detail2_idx].xmdxdocno

         END INPUT
         
         INPUT ARRAY g_detail3_d FROM s_detail3.*
            ATTRIBUTE(COUNT = g_detail3_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail3_idx)
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")
               IF cl_null(g_detail3_idx) OR g_detail3_idx = 0 THEN
                  NEXT FIELD b_sel
               END IF
               LET g_detail3_d_o.* = g_detail3_d[g_detail3_idx].*
               IF g_param.type = '2' THEN
                  CALL cl_set_comp_entry("b_xmdl008",TRUE)
               ELSE
                  CALL cl_set_comp_entry("b_xmdl008",FALSE)
               END IF

            BEFORE ROW
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")

            AFTER FIELD b_xmdl008
               LET g_detail3_d[g_detail3_idx].xmdl008_desc = ''
               LET g_detail3_d[g_detail3_idx].xmdl008_desc_desc = ''
               IF NOT cl_null(g_detail3_d[g_detail3_idx].xmdl008) THEN
                  IF g_detail3_d[g_detail3_idx].xmdl008 <> g_detail3_d_o.xmdl008 OR cl_null(g_detail3_d_o.xmdl008) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_detail3_d[g_detail3_idx].xmdl008
                     IF NOT cl_chk_exist("v_imaf001_16") THEN
                        LET g_detail3_d[g_detail3_idx].xmdl008 = g_detail3_d_o.xmdl008
                        CALL s_desc_get_item_desc(g_detail3_d[g_detail3_idx].xmdl008)
                             RETURNING g_detail3_d[g_detail3_idx].xmdl008_desc,g_detail3_d[g_detail3_idx].xmdl008_desc_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_desc_get_item_desc(g_detail3_d[g_detail3_idx].xmdl008)
                    RETURNING g_detail3_d[g_detail3_idx].xmdl008_desc,g_detail3_d[g_detail3_idx].xmdl008_desc_desc
               LET g_detail3_d_o.xmdl008 = g_detail3_d[g_detail3_idx].xmdl008

            AFTER FIELD b_xmdl024
               IF NOT cl_null(g_detail3_d[g_detail3_idx].xmdl024) THEN
                  IF g_detail3_d[g_detail3_idx].xmdl024 <> g_detail3_d_o.xmdl024 OR cl_null(g_detail3_d_o.xmdl024) THEN
                     IF NOT cl_ap_chk_range(g_detail3_d[g_detail3_idx].xmdl024,"0","1","","","azz-00079",1) THEN
                        LET g_detail3_d[g_detail3_idx].xmdl024 = g_detail3_d_o.xmdl024
                        NEXT FIELD CURRENT
                     END IF
                     #匯率
                     LET l_xmdk007 = ''
                     LET l_xmdk016 = ''
                     SELECT xmdx004,xmdx005 INTO l_xmdk007,l_xmdk016
                       FROM xmdx_t
                      WHERE xmdxent = g_enterprise
                        AND xmdxdocno = g_detail3_d[g_detail3_idx].xmdl094
                     CALL s_axmp441_get_exchange(l_xmdk007,l_xmdk016)
                          RETURNING l_xmdk017
                     CALL s_tax_count(g_site,g_detail3_d[g_detail3_idx].xmdl025,g_detail3_d[g_detail3_idx].xmdl024,1,l_xmdk016,l_xmdk017)
                          RETURNING g_detail3_d[g_detail3_idx].xmdl027,g_detail3_d[g_detail3_idx].xmdl029,g_detail3_d[g_detail3_idx].xmdl028,l_xrcd113,l_xrcd114,l_xrcd115
                  END IF
               END IF
               LET g_detail3_d_o.xmdl024 = g_detail3_d[g_detail3_idx].xmdl024

            AFTER FIELD b_xmdl050
               LET g_detail3_d[g_detail3_idx].xmdl050_desc = ''
               IF NOT cl_null(g_detail3_d[g_detail3_idx].xmdl050) THEN
                  IF g_detail3_d[g_detail3_idx].xmdl050 <> g_detail3_d_o.xmdl050 OR cl_null(g_detail3_d_o.xmdl050) THEN
                     IF NOT s_azzi650_chk_exist(g_gzcb004,g_detail3_d[g_detail3_idx].xmdl050) THEN
                        LET g_detail3_d[g_detail3_idx].xmdl050 = g_detail3_d_o.xmdl050
                        CALL s_axmp441_reason_ref(g_detail3_d[g_detail3_idx].xmdl050)
                             RETURNING g_detail3_d[g_detail3_idx].xmdl050_desc
                        NEXT FIELD CURRENT
                     END IF
                     #檢核輸入的理由碼是否在單據別限制範圍內
                     CALL s_control_chk_doc('8',g_param.docno,g_detail3_d[g_detail3_idx].xmdl050,'','','','')
                          RETURNING l_success,l_flag
                     IF NOT l_success OR NOT l_flag THEN
                           LET g_detail3_d[g_detail3_idx].xmdl050 = g_detail3_d_o.xmdl050
                           CALL s_axmp441_reason_ref(g_detail3_d[g_detail3_idx].xmdl050)
                                RETURNING g_detail3_d[g_detail3_idx].xmdl050_desc
                           NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_axmp441_reason_ref(g_detail3_d[g_detail3_idx].xmdl050)
                    RETURNING g_detail3_d[g_detail3_idx].xmdl050_desc
               LET g_detail3_d_o.xmdl050 = g_detail3_d[g_detail3_idx].xmdl050

            ON ACTION controlp INFIELD b_xmdl008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[g_detail3_idx].xmdl008
               CALL s_control_get_item_sql('2',g_site,g_user,g_dept,g_param.docno)
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               CALL q_imaf001_17()
               LET g_detail3_d[g_detail3_idx].xmdl008 = g_qryparam.return1
               CALL s_desc_get_item_desc(g_detail3_d[g_detail3_idx].xmdl008)
                    RETURNING g_detail3_d[g_detail3_idx].xmdl008_desc,g_detail3_d[g_detail3_idx].xmdl008_desc_desc
               NEXT FIELD b_xmdl008

            ON ACTION controlp INFIELD b_xmdl050
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[g_detail3_idx].xmdl050
               CALL s_control_get_doc_sql('oocq002',g_param.docno,'8')
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               LET g_qryparam.arg1 = g_gzcb004
               CALL q_oocq002()
               LET g_detail3_d[g_detail3_idx].xmdl050 = g_qryparam.return1
               CALL s_axmp441_reason_ref(g_detail3_d[g_detail3_idx].xmdl050)
                    RETURNING g_detail3_d[g_detail3_idx].xmdl050_desc
               NEXT FIELD b_xmdl050

            ON ROW CHANGE
               UPDATE axmp441_tmp1
                  SET xmdl008 = g_detail3_d[g_detail3_idx].xmdl008,
                      xmdl024 = g_detail3_d[g_detail3_idx].xmdl024,
                      xmdl027 = g_detail3_d[g_detail3_idx].xmdl027,
                      xmdl028 = g_detail3_d[g_detail3_idx].xmdl028,
                      xmdl029 = g_detail3_d[g_detail3_idx].xmdl029,
                      xmdl050 = g_detail3_d[g_detail3_idx].xmdl050
                WHERE xmdlseq = g_detail3_d[g_detail3_idx].xmdlseq

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
               CALL s_axmp441_upd_tmp(g_detail_d[li_idx].sel,
                                      g_detail_d[li_idx].xmde001,
                                      g_detail_d[li_idx].xmde002,
                                      g_detail_d[li_idx].xmde003,
                                      g_detail_d[li_idx].xmde004,
                                      g_detail_d[li_idx].xmde017,
                                      g_detail_d[li_idx].xmde018,
                                      g_param.type,g_param.item,g_param.xmdl050)

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL axmp441_fetch()

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               CALL s_axmp441_upd_tmp(g_detail_d[li_idx].sel,
                                      g_detail_d[li_idx].xmde001,
                                      g_detail_d[li_idx].xmde002,
                                      g_detail_d[li_idx].xmde003,
                                      g_detail_d[li_idx].xmde004,
                                      g_detail_d[li_idx].xmde017,
                                      g_detail_d[li_idx].xmde018,
                                      g_param.type,g_param.item,g_param.xmdl050)

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            CALL axmp441_fetch()

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
                  CALL s_axmp441_upd_tmp(g_detail_d[li_idx].sel,
                                         g_detail_d[li_idx].xmde001,
                                         g_detail_d[li_idx].xmde002,
                                         g_detail_d[li_idx].xmde003,
                                         g_detail_d[li_idx].xmde004,
                                         g_detail_d[li_idx].xmde017,
                                         g_detail_d[li_idx].xmde018,
                                         g_param.type,g_param.item,g_param.xmdl050)
               END IF
            END FOR
            CALL axmp441_fetch()

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL s_axmp441_upd_tmp(g_detail_d[li_idx].sel,
                                         g_detail_d[li_idx].xmde001,
                                         g_detail_d[li_idx].xmde002,
                                         g_detail_d[li_idx].xmde003,
                                         g_detail_d[li_idx].xmde004,
                                         g_detail_d[li_idx].xmde017,
                                         g_detail_d[li_idx].xmde018,
                                         g_param.type,g_param.item,g_param.xmdl050)
               END IF
            END FOR
            CALL axmp441_fetch()

            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmp441_filter()
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
            CALL axmp441_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp441_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF cl_null(g_param.docno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00532'
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD docno
            END IF
            IF cl_null(g_param.xmdl050) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00622'
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD xmdl050
            END IF
            IF g_param.type = '2' AND cl_null(g_param.item) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00623'
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD item
            END IF
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM axmp441_tmp
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD b_sel
            END IF
            CALL s_axmp441(g_param.docno)
            CALL axmp441_b_fill()
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
 
{<section id="axmp441.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp441_query()
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
   CALL axmp441_b_fill()
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
 
{<section id="axmp441.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp441_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   IF cl_null(g_param.wc) THEN
      LET g_param.wc = " 1=1"
   END IF
   
   LET g_sql = " SELECT 'N',xmde001,xmde002,xmde005,xmdx004, ",
               "        pmaal004,xmde006,imaal003,imaal004,xmde007, ",
               "        '',xmde003,xmde004,xmde017,xmde018, ",
               "        xmde019,xmde020,xmde021,xmde014,xmde015, ",
               "        xmde016,xmde010,xmde011,xmde012,xmde013 ",
               "   FROM xmde_t ",
               "   LEFT OUTER JOIN pmaal_t ON pmaalent = xmdeent AND pmaal001 = xmde006 AND pmaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN imaal_t ON imaalent = xmdeent AND imaal001 = xmde006 AND imaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN imaa_t ON imaaent = xmdeent AND imaa001 = xmde006 ",
               "   LEFT OUTER JOIN imaf_t ON imafent = xmdeent AND imafsite= xmdesite AND imaf001 = xmde006 ",
               "   LEFT OUTER JOIN xmdx_t ON xmdxent = xmdeent AND xmdxdocno = xmde001 ",
               "  WHERE xmdeent = ? ",
               "    AND xmdesite='",g_site,"' ",
               "    AND xmde025 ='1' ",
               "    AND xmdxstus = 'Y' ",
               "    AND ",g_param.wc CLIPPED,
               "  ORDER BY xmde001,xmde002 "

   #end add-point
 
   PREPARE axmp441_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp441_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   DELETE FROM axmp441_tmp
   DELETE FROM axmp441_tmp1
   DELETE FROM axmp441_tmp2

   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].xmde001,g_detail_d[l_ac].xmde002,g_detail_d[l_ac].xmde005,g_detail_d[l_ac].xmdx004,
   g_detail_d[l_ac].xmdx004_desc,g_detail_d[l_ac].xmde006,g_detail_d[l_ac].xmde006_desc,g_detail_d[l_ac].xmde006_desc_desc,g_detail_d[l_ac].xmde007,
   g_detail_d[l_ac].xmde007_desc,g_detail_d[l_ac].xmde003,g_detail_d[l_ac].xmde004,g_detail_d[l_ac].xmde017,g_detail_d[l_ac].xmde018,
   g_detail_d[l_ac].xmde019,g_detail_d[l_ac].xmde020,g_detail_d[l_ac].xmde021,g_detail_d[l_ac].xmde014,g_detail_d[l_ac].xmde015,
   g_detail_d[l_ac].xmde016,g_detail_d[l_ac].xmde010,g_detail_d[l_ac].xmde011,g_detail_d[l_ac].xmde012,g_detail_d[l_ac].xmde013
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
      CALL s_feature_description(g_detail_d[l_ac].xmde006,g_detail_d[l_ac].xmde007)
           RETURNING l_success,g_detail_d[l_ac].xmde007_desc
      #end add-point
      
      CALL axmp441_detail_show()      
 
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
   FREE axmp441_sel
   
   LET l_ac = 1
   CALL axmp441_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp441.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp441_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   
   LET g_sql = " SELECT xmdk007,'',xmdk010,'',xmdk011, ",
               "        '',xmdk012,'',xmdk013,xmdk014, ",
               "        xmdk016,'',xmdk017,xmdxdocno ",
               "   FROM axmp441_tmp1 ",
               "  ORDER BY xmdxdocno "
               
   PREPARE axmp441_fetch_pre1 FROM g_sql
   DECLARE axmp441_fetch_curs CURSOR FOR axmp441_fetch_pre1

   LET l_ac = 1
   FOREACH axmp441_fetch_curs INTO g_detail2_d[l_ac].xmdk007,g_detail2_d[l_ac].xmdk007_desc,
                                   g_detail2_d[l_ac].xmdk010,g_detail2_d[l_ac].xmdk010_desc,
                                   g_detail2_d[l_ac].xmdk011,g_detail2_d[l_ac].xmdk011_desc ,
                                   g_detail2_d[l_ac].xmdk012,g_detail2_d[l_ac].xmdk012_desc,
                                   g_detail2_d[l_ac].xmdk013,g_detail2_d[l_ac].xmdk014,
                                   g_detail2_d[l_ac].xmdk016,g_detail2_d[l_ac].xmdk016_desc,
                                   g_detail2_d[l_ac].xmdk017,g_detail2_d[l_ac].xmdxdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      CALL s_desc_get_trading_partner_abbr_desc(g_detail2_d[l_ac].xmdk007)
           RETURNING g_detail2_d[l_ac].xmdk007_desc

      CALL s_desc_get_ooib002_desc(g_detail2_d[l_ac].xmdk010)
           RETURNING g_detail2_d[l_ac].xmdk010_desc

      CALL s_desc_get_acc_desc('238',g_detail2_d[l_ac].xmdk011)
           RETURNING g_detail2_d[l_ac].xmdk011_desc

      CALL s_desc_get_tax_desc1(g_site,g_detail2_d[l_ac].xmdk012)
           RETURNING g_detail2_d[l_ac].xmdk012_desc

      CALL s_desc_get_currency_desc(g_detail2_d[l_ac].xmdk016)
           RETURNING g_detail2_d[l_ac].xmdk016_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH

   LET g_detail2_cnt = l_ac - 1
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   
   FREE axmp441_fetch_pre1
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmp441.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp441_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp441.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp441_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   DEFINE ls_result          STRING

   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"

   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()

   CONSTRUCT g_wc_filter ON xmde001,xmde002,xmde005,xmdx004,xmde006,xmde007,xmde003,xmde004,xmde017,xmde018,
                            xmde019,xmde020,xmde021,xmde014,xmde015,xmde016,xmde010,xmde011,xmde012,xmde013
        FROM s_detail1[1].b_xmde001,s_detail1[1].b_xmde002,s_detail1[1].b_xmde005,s_detail1[1].b_xmdx004,s_detail1[1].b_xmde006,
             s_detail1[1].b_xmde007,s_detail1[1].b_xmde003,s_detail1[1].b_xmde004,s_detail1[1].b_xmde017,s_detail1[1].b_xmde018,
             s_detail1[1].b_xmde019,s_detail1[1].b_xmde020,s_detail1[1].b_xmde021,s_detail1[1].b_xmde014,s_detail1[1].b_xmde015,
             s_detail1[1].b_xmde016,s_detail1[1].b_xmde010,s_detail1[1].b_xmde011,s_detail1[1].b_xmde012,s_detail1[1].b_xmde013
           
      BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD b_xmde001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmdxdocno()
            DISPLAY g_qryparam.return1 TO b_xmde001
            NEXT FIELD b_xmde001
            
         ON ACTION controlp INFIELD b_xmdx004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()
            DISPLAY g_qryparam.return1 TO b_xmdx004
            NEXT FIELD b_xmdx004
            
         ON ACTION controlp INFIELD b_xmde006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()
            DISPLAY g_qryparam.return1 TO b_xmde006
            NEXT FIELD b_xmde006
   
         ON ACTION controlp INFIELD b_xmde003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_xmde003()
            DISPLAY g_qryparam.return1 TO b_xmde003
            NEXT FIELD b_xmde003

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL axmp441_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp441.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp441_filter_parser(ps_field)
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
 
{<section id="axmp441.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp441_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmp441_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp441.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 銷退單身資訊
# Memo...........:
# Usage..........: CALL axmp441_fetch_1()
# Input parameter: no
# Return code....: no
# Date & Author..: 150310 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp441_fetch_1()
DEFINE li_ac        LIKE type_t.num10
DEFINE l_success    LIKE type_t.num5
   
   LET li_ac = l_ac 
   
   CALL g_detail3_d.clear()
   
   IF g_detail2_idx > g_detail2_cnt THEN
      LET g_detail2_idx = g_detail2_cnt
   END IF
   
   IF cl_null(g_detail2_idx) OR g_detail2_idx <= 0 THEN
      RETURN
   END IF
   
   LET g_sql = " SELECT xmdlseq,xmdl008,'','',xmdl009, ",
               "        '',xmdl017,'',xmdl018,xmdl019, ",
               "        '',xmdl020,xmdl021,'',xmdl022, ",
               "        xmdl025,'',xmdl026,xmdl024,xmdl027, ",
               "        xmdl028,xmdl029,xmdl050,xmdl094,xmdl095 ",
               "   FROM axmp441_tmp2 ",
               "  WHERE xmdl094 = '",g_detail2_d[g_detail2_idx].xmdxdocno,"' ",
               "  ORDER BY xmdlseq "
               
   PREPARE axmp441_fetch_pre2 FROM g_sql
   DECLARE axmp441_fetch_cur2 CURSOR FOR axmp441_fetch_pre2

   LET l_ac = 1
   FOREACH axmp441_fetch_cur2 INTO g_detail3_d[l_ac].xmdlseq,g_detail3_d[l_ac].xmdl008,
                                   g_detail3_d[l_ac].xmdl008_desc,g_detail3_d[l_ac].xmdl008_desc_desc,
                                   g_detail3_d[l_ac].xmdl009,g_detail3_d[l_ac].xmdl009_desc,
                                   g_detail3_d[l_ac].xmdl017,g_detail3_d[l_ac].xmdl017_desc,
                                   g_detail3_d[l_ac].xmdl018,g_detail3_d[l_ac].xmdl019,
                                   g_detail3_d[l_ac].xmdl019_desc,g_detail3_d[l_ac].xmdl020,
                                   g_detail3_d[l_ac].xmdl021,g_detail3_d[l_ac].xmdl021_desc,
                                   g_detail3_d[l_ac].xmdl022,g_detail3_d[l_ac].xmdl025,
                                   g_detail3_d[l_ac].xmdl025_desc,g_detail3_d[l_ac].xmdl026,
                                   g_detail3_d[l_ac].xmdl024,g_detail3_d[l_ac].xmdl027,
                                   g_detail3_d[l_ac].xmdl028,g_detail3_d[l_ac].xmdl029,
                                   g_detail3_d[l_ac].xmdl050,g_detail3_d[l_ac].xmdl094,
                                   g_detail3_d[l_ac].xmdl095
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      CALL s_desc_get_item_desc(g_detail3_d[l_ac].xmdl008)
           RETURNING g_detail3_d[l_ac].xmdl008_desc,g_detail3_d[l_ac].xmdl008_desc_desc

      CALL s_feature_description(g_detail3_d[l_ac].xmdl008,g_detail3_d[l_ac].xmdl009)
           RETURNING l_success,g_detail3_d[l_ac].xmdl009_desc

      CALL s_desc_get_unit_desc(g_detail3_d[l_ac].xmdl017)
           RETURNING g_detail3_d[l_ac].xmdl017_desc

      CALL s_desc_get_unit_desc(g_detail3_d[l_ac].xmdl019)
           RETURNING g_detail3_d[l_ac].xmdl019_desc

      CALL s_desc_get_unit_desc(g_detail3_d[l_ac].xmdl021)
           RETURNING g_detail3_d[l_ac].xmdl021_desc

      CALL s_desc_get_tax_desc1(g_site,g_detail3_d[l_ac].xmdl025)
           RETURNING g_detail3_d[l_ac].xmdl025_desc

      CALL s_axmp441_reason_ref(g_detail3_d[l_ac].xmdl050)
           RETURNING g_detail3_d[l_ac].xmdl050_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH

   LET g_detail3_cnt = l_ac - 1
   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
   
   FREE axmp441_fetch_pre2
   
   LET l_ac = li_ac

END FUNCTION

################################################################################
# Descriptions...: 修改INPUT條件後，要清空已選擇資料
# Memo...........:
# Usage..........: CALL axmp441_del_tmp_chk()
# Input parameter: no
# Return code....: 
# Date & Author..: 150311 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp441_del_tmp_chk()
DEFINE l_cnt        LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM axmp441_tmp
   IF l_cnt > 0 THEN
      IF cl_ask_confirm('axm-00624') THEN
         DELETE FROM axmp441_tmp
         DELETE FROM axmp441_tmp1
         DELETE FROM axmp441_tmp2
         CALL axmp441_b_fill()
      ELSE
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
