#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp440.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-12-14 09:45:51), PR版次:0012(2017-01-11 18:30:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: aapp440
#+ Description: 發票請款單批次產生核銷單
#+ Creator....: 02114(2015-12-14 09:45:51)
#+ Modifier...: 02114 -SD/PR- 04152
 
{</section>}
 
{<section id="aapp440.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#20 2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#43 2016/04/25 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161006-00005#3  2016/10/12 By 08732    組織類型與職能開窗調整
#161108-00004#1  2016/11/08 By dorishsu 當anmt460來源為IV:發票請款單 且暫付否 為 Y 時, 直接抓取 anmt460單身科目(nmcl003),給予沖銷科目(apde016)
#161108-00017#1  2016/11/09 By Reanna   程式中INSERT INTO 有星號作整批調整
#161104-00024#1  2016/11/10 By 08729    處理DEFINE有星號
#161115-00042#3  2016/11/16 By 08171    開窗範圍處理(1付款對象控制組4請款單號)+b_fill加控制組條件
#161125-00021#1  2016/11/25 By Reanna   增加自定義欄位
#161208-00026#1  2016/12/09 By 08729    針對SELECT有星號的部分進行展開
#161229-00047#19 2017/01/10 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#161229-00047#76 2017/01/11 By Reanna   修正 #161229-00047#19 bug
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
        apeasite            LIKE apea_t.apeasite,
        apeasite_desc       LIKE type_t.chr80,
        apeacomp            LIKE apea_t.apeacomp,
        apeacomp_desc       LIKE type_t.chr80,
        apea019             LIKE apea_t.apea019,
        apea020             LIKE apea_t.apea020,
        type                LIKE type_t.chr1,
        apdasite            LIKE apda_t.apdasite,
        apdasite_desc       LIKE type_t.chr80,
        apdadocno           LIKE apda_t.apdadocno,
        apda003             LIKE apda_t.apda003,
        apda003_desc        LIKE type_t.chr80,
        apdadocdt           LIKE apda_t.apdadocdt,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel                 LIKE type_t.chr1,
        apebdocno           LIKE apeb_t.apebdocno,
        apeadocdt           LIKE apea_t.apeadocdt,
        apebseq             LIKE apeb_t.apebseq,
        apeborga            LIKE apeb_t.apeborga,
        apeborga_desc       LIKE type_t.chr80,
        apeb002             LIKE apeb_t.apeb002,
        apeb031             LIKE apeb_t.apeb031,
        apeb007             LIKE apeb_t.apeb007,
        apeb008             LIKE apeb_t.apeb008,
        apeb011             LIKE apeb_t.apeb011,
        apeb012             LIKE apeb_t.apeb012,
        apeb100             LIKE apeb_t.apeb100,
        apeb108             LIKE apeb_t.apeb108,
        apeb101             LIKE apeb_t.apeb101,
        apeb118             LIKE apeb_t.apeb118
                      END RECORD  
DEFINE g_input        type_parameter
DEFINE g_ld           LIKE glaa_t.glaald
DEFINE g_glaa024      LIKE glaa_t.glaa024
DEFINE g_comp         LIKE apda_t.apdacomp
DEFINE g_wc_string    STRING
DEFINE g_sfin3007     LIKE apca_t.apcadocdt
DEFINE g_rec_b        LIKE type_t.num5
DEFINE g_sql_ctrl     STRING                 #161115-00042#3 add
DEFINE g_comp_str     STRING                 #161229-00047#19
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp440.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #161229-00047#76 add ------
      SELECT ooef017 INTO g_input.apeacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
         AND ooefstus = 'Y'
      CALL s_fin_get_wc_str(g_input.apeacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#76 add end---
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp440 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp440_init()   
 
      #進入選單 Menu (="N")
      CALL aapp440_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp440
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp440.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp440_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_comp_str() RETURNING g_wc_string   #161006-00005#3  add
   CALL s_fin_get_wc_str(g_wc_string) RETURNING g_wc_string     #161006-00005#3  add
   #161229-00047#19 mark ------
   ##161115-00042#3 --s add
   #SELECT ooef017 INTO g_input.apeacomp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apeacomp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#3 --e add
   #161229-00047#19 mark end---
   CALL aapp440_default() #161229-00047#76
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp440.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp440_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_choice     LIKE type_t.chr1
   DEFINE l_ld         LIKE glaa_t.glaald #161115-00042#3 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #CALL aapp440_default() #161229-00047#76 mark
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp440_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
      
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.apeasite     ,g_input.apeasite_desc,  
                       g_input.apeacomp     ,g_input.apeacomp_desc,
                       g_input.apea019      ,g_input.apea020,            
                       g_input.type         ,g_input.apdasite,            
                       g_input.apdasite_desc,g_input.apdadocno,           
                       g_input.apda003      ,g_input.apda003_desc,        
                       g_input.apdadocdt     
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            BEFORE INPUT 

               
            AFTER FIELD apeasite      
               LET g_input.apeasite_desc = ''
               IF NOT cl_null(g_input.apeasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apeasite,'','','6','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apeasite = ''
                     LET g_input.apeasite_desc = s_desc_get_department_desc(g_input.apeasite)
                     DISPLAY BY NAME g_input.apeasite,g_input.apeasite_desc
                     NEXT FIELD apeasite
                  END IF
               END IF
               LET g_input.apeasite_desc = s_desc_get_department_desc(g_input.apeasite)
               DISPLAY BY NAME g_input.apeasite_desc
               #營運據點取得帳別與法人
               CALL s_fin_orga_get_comp_ld(g_input.apeasite) RETURNING g_sub_success,g_errno,g_input.apeacomp,g_ld
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apeacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#3 add #161229-00047#19 mark
               #161229-00047#19 add ------
               CALL s_fin_get_wc_str(g_input.apeacomp) RETURNING g_comp_str
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
               #161229-00047#19 add end---
               LET g_input.apeacomp_desc = s_desc_get_department_desc(g_input.apeacomp)
               DISPLAY BY NAME g_input.apeacomp_desc
               CALL aapp440_visible()
            
            
            AFTER FIELD apeacomp
               IF NOT cl_null(g_input.apeacomp) THEN
                  #取得帳務組織下所屬成員
                  CALL s_fin_account_center_sons_query('6',g_input.apeacomp,g_today,'1')
                  #取得帳務組織底下所屬的法人範圍
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_string
                  #將取回的字串轉換為SQL條件
                  CALL s_fin_get_wc_str(g_wc_string) RETURNING g_wc_string
                  #比對輸入的法人是否在資金組織下
                  IF s_chr_get_index_of(g_wc_string,g_input.apeacomp,'1') = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apeacomp = ''
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapp440_visible()
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apeacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#3 add #161229-00047#19 mark
                  #161229-00047#19 add ------
                  CALL s_fin_get_wc_str(g_input.apeacomp) RETURNING g_comp_str
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
                  #161229-00047#19 add end---
               END IF
               LET g_input.apeacomp_desc = s_desc_get_department_desc(g_input.apeacomp)
               DISPLAY BY NAME g_input.apeacomp_desc 

            ON CHANGE type
               IF g_input.type = '3' THEN 
                  CALL cl_set_comp_required('apdadocdt',TRUE)
               ELSE
                  CALL cl_set_comp_required('apdadocdt',FALSE)
               END IF
               
            AFTER FIELD apdasite
               LET g_input.apdasite_desc = ' '
               DISPLAY BY NAME g_input.apdasite_desc
               IF NOT cl_null(g_input.apdasite) THEN
                  #161006-00005#3   mark---s
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  #INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  #LET g_chkparam.arg1 = g_input.apdasite
                  #160318-00025#43  2016/04/25  by pengxin  add(S)
                  #LET g_errshow = TRUE #是否開窗 
                  #LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#43  2016/04/25  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  #IF NOT cl_chk_exist("v_ooef001") THEN
                  #   #檢查失敗時後續處理
                  #   LET g_input.apdasite = ''
                  #   LET g_input.apdasite_desc = s_desc_get_department_desc(g_input.apdasite)
                  #   DISPLAY BY NAME g_input.apdasite_desc
                  #   NEXT FIELD CURRENT
                  #END IF
                  #161006-00005#3   mark---e                  
                  
                  #161006-00005#3   add---s
                  CALL s_fin_account_center_with_ld_chk(g_input.apdasite,'','','3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD apdasite
                  END IF   
                  #161006-00005#3   add---e
                  
                  #取得所屬法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_input.apdasite) RETURNING g_sub_success,g_errno,g_comp,g_ld  
                  CALL s_ld_sel_glaa(g_ld,'glaa024') RETURNING g_sub_success,g_glaa024  
                  CALL cl_get_para(g_enterprise,g_comp,'S-FIN-3007') RETURNING g_sfin3007                  
               END IF           
               LET g_input.apdasite_desc = s_desc_get_department_desc(g_input.apdasite)
               DISPLAY BY NAME g_input.apdasite_desc
               
               CALL aapp440_get_docno() RETURNING g_input.apdadocno
               
            AFTER FIELD apda003
               LET g_input.apda003_desc = ' '
               DISPLAY BY NAME g_input.apda003_desc
               IF NOT cl_null(g_input.apda003) THEN
                  CALL s_voucher_glaq013_chk(g_input.apda003)
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     #(s_voucher_glaq013_chk)aoo-00071->sub-01302
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi130'
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                   
                     LET g_input.apda003 = ''
                     LET g_input.apda003_desc = s_desc_get_person_desc(g_input.apda003)
                     DISPLAY BY NAME g_input.apda003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF           
               LET g_input.apda003_desc = s_desc_get_person_desc(g_input.apda003)
               DISPLAY BY NAME g_input.apda003_desc
               
            AFTER FIELD apdadocdt
               IF NOT cl_null(g_input.apdadocdt) THEN               
                  IF NOT cl_null(g_sfin3007) THEN
                     IF g_input.apdadocdt <= g_sfin3007 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00110'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.apdadocdt= ''
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            
            ON ACTION controlp INFIELD apeasite
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apeasite
               #LET g_qryparam.where = " ooef206 = 'Y' "   #161006-00005#3  mark
               #CALL q_ooef001()                           #161006-00005#3  mark
               CALL q_ooef001_33()                         #161006-00005#3  add 
               LET g_input.apeasite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.apeasite) RETURNING g_input.apeasite_desc
               DISPLAY BY NAME g_input.apeasite,g_input.apeasite_desc
               NEXT FIELD apeasite   
            
            ON ACTION controlp INFIELD apeacomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apeacomp
               IF NOT cl_null(g_input.apeasite) THEN
                  CALL s_fin_account_center_sons_query('6',g_input.apeasite,g_today,'')
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_string
                  CALL s_fin_get_wc_str(g_wc_string) RETURNING g_wc_string
                  LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_string CLIPPED
               ELSE
                  LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_string CLIPPED
               END IF
               CALL q_ooef001()
               LET g_input.apeacomp = g_qryparam.return1
               DISPLAY BY NAME g_input.apeacomp
               LET g_input.apeacomp_desc = s_desc_get_department_desc(g_input.apeacomp)
               DISPLAY BY NAME g_input.apeacomp_desc
               NEXT FIELD apeacomp   
                  
            ON ACTION controlp INFIELD apdasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apdasite       #給予default值
               #CALL q_ooef001()     #161006-00005#3  mark
               CALL q_ooef001_46()   #161006-00005#3  add                                #呼叫開窗
               LET g_input.apdasite = g_qryparam.return1        #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_input.apdasite) RETURNING g_input.apdasite_desc
               DISPLAY BY NAME g_input.apdasite,g_input.apdasite_desc
               NEXT FIELD apdasite   

            ON ACTION controlp INFIELD apdadocno
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_input.apdadocno             #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = g_glaa024
               LET g_qryparam.arg2 = 'aapt420'
               
               CALL q_ooba002_1()                                #呼叫開窗
               
               LET g_input.apdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_input.apdadocno TO apdadocno              #顯示到畫面上
               
               NEXT FIELD apdadocno                          #返回原欄位
               
            ON ACTION controlp INFIELD apda003
		     	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apda003      #給予default值
               CALL q_ooag001()                                #呼叫開窗
               LET g_input.apda003 = g_qryparam.return1       #將開窗取得的值回傳到變數
               CALL s_desc_get_person_desc(g_input.apda003) RETURNING g_input.apda003_desc
               DISPLAY BY NAME g_input.apda003,g_input.apda003_desc
               NEXT FIELD apda003  
         END INPUT
         
         #查詢QBE
         CONSTRUCT BY NAME g_wc ON apeadocno,apea005,apeb002,apeborga,apeb008,apeb011,apeb100,apeb031

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
            ON ACTION controlp INFIELD apeadocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         LET g_qryparam.where = "     apeastus = 'Y' AND apeasite = '",g_input.apeasite,"'",
   	                                " AND apea019 = ",g_input.apea019,
   	                                " AND apea020 = ",g_input.apea020,
   	                                " AND apebdocno||apebseq NOT IN (SELECT apce049||apce050 FROM apce_t ",
                                      "                                 WHERE apceent=",g_enterprise," AND apceld='",g_ld,"'",
                                      "                                   AND apce049 IS NOT NULL AND apce050 IS NOT NULL ",
                                      "                                )"
               #161115-00042#3 --s add
               #查詢依帳套權限管理
               SELECT glaald INTO l_ld 
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_input.apeacomp
                  AND glaa014 = 'Y'
               LET g_qryparam.where = g_qryparam.where," AND apeald = '",l_ld,"'"
               #161115-00042#3 --e add
               CALL q_apeadocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apeadocno  #顯示到畫面上  
               NEXT FIELD apeadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD apea005
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         #161115-00042#3 --s add
   	         IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                         "          WHERE pmaaent = ",g_enterprise,
                                         "            AND ",g_sql_ctrl,
                                         "            AND pmaaent = apcaent ",
                                         "            AND pmaa001 = apca005 ) "
               #161115-00042#3 --e add
               END IF
               CALL q_apca005()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apea005  #顯示到畫面上  
               NEXT FIELD apea005                     #返回原欄位 
   
            ON ACTION controlp INFIELD apeb002
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         LET g_qryparam.where = " apeastus = 'Y'"
   	         #161115-00042#3 --s add
               #查詢依帳套權限管理
               SELECT glaald INTO l_ld 
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_input.apeacomp
                  AND glaa014 = 'Y'
               LET g_qryparam.where = g_qryparam.where," AND apeald = '",l_ld,"'"
               #161115-00042#3 --e add
               CALL q_apeb002_1()
               DISPLAY g_qryparam.return1 TO apeb002  #顯示到畫面上  
               NEXT FIELD apeb002                     #返回原欄位  
               
            ON ACTION controlp INFIELD apeborga
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " ooef201 = 'Y' AND ooef001 IN ",g_wc_string CLIPPED   #161006-00005#3  add   
               CALL q_ooef001()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO apeborga  #顯示到畫面上
               NEXT FIELD apeborga                     #返回原欄位
             
            ON ACTION controlp INFIELD apeb008
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         LET g_qryparam.where = " apeastus = 'Y'"
               CALL q_apeb008()
               DISPLAY g_qryparam.return1 TO apeb008  #顯示到畫面上  
               NEXT FIELD apeb008  

            ON ACTION controlp INFIELD apeb100
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               CALL q_ooai001()
               DISPLAY g_qryparam.return1 TO apeb100  #顯示到畫面上  
               NEXT FIELD apeb100   
         END CONSTRUCT
         
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aapp440_fetch()              
               
            ON CHANGE sel
               IF cl_null(g_input.apdadocdt) AND g_detail_d[l_ac].apeadocdt < = g_sfin3007 THEN  
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'axc-00226'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               UPDATE aapp440_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE apebdocno = g_detail_d[l_ac].apebdocno 
                  AND apebseq = g_detail_d[l_ac].apebseq
         
         END INPUT
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
               UPDATE aapp440_tmp 
                  SET sel = g_detail_d[li_idx].sel
                WHERE apebdocno = g_detail_d[li_idx].apebdocno 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF cl_null(g_input.apdadocdt) AND g_detail_d[li_idx].apeadocdt < = g_sfin3007 THEN 
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               UPDATE aapp440_tmp 
                  SET sel = g_detail_d[li_idx].sel
                WHERE apebdocno = g_detail_d[li_idx].apebdocno 
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
                  IF cl_null(g_input.apdadocdt) AND g_detail_d[li_idx].apeadocdt < = g_sfin3007 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'axc-00226'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  LET g_detail_d[li_idx].sel = "Y"
                  UPDATE aapp440_tmp 
                     SET sel = g_detail_d[li_idx].sel
                   WHERE apebdocno = g_detail_d[li_idx].apebdocno
                     AND apebseq = g_detail_d[li_idx].apebseq
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
                  UPDATE aapp440_tmp 
                     SET sel = g_detail_d[li_idx].sel
                   WHERE apebdocno = g_detail_d[li_idx].apebdocno
                     AND apebseq = g_detail_d[li_idx].apebseq
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapp440_filter()
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
            CALL aapp440_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_input.* TO NULL
            CALL aapp440_default()
            CALL g_detail_d.clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp440_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_choice = FALSE
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_choice = TRUE
               END IF
            END FOR
            #沒選取資料
            IF NOT l_choice THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'axr-00159'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
            ELSE
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               CALL aapp440_p() RETURNING g_sub_success
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00217'   #單據還原成功
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  CALL s_transaction_end('N',0)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00218'   #單據還原失敗
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               CALL cl_err_collect_show()
            END IF
            CALL aapp440_b_fill()
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
 
{<section id="aapp440.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp440_query()
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
   CALL aapp440_b_fill()
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
 
{<section id="aapp440.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp440_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success             LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
   
   CALL aapp440_create_tmp() RETURNING l_success
   DELETE FROM aapp440_tmp
   
   LET g_sql = "SELECT 'N',apebdocno,apeadocdt,apebseq,apeborga,'',",
               "        apeb002,apeb031,apeb007,apeb008,apeb011,apeb012, ",
               "        apeb100,apeb108,apeb101,apeb118 ",
               "  FROM apea_t,apeb_t ",
               " WHERE apeaent = ? ",
               "   AND apeaent = apebent ",
               "   AND apeadocno = apebdocno ",
               "   AND apeasite='",g_input.apeasite,"'",
               "   AND apeacomp='",g_input.apeacomp,"'",
               "   AND apea019=",g_input.apea019,
               "   AND apea020=",g_input.apea020,
               "   AND apeastus = 'Y' ",
               "   AND apebdocno||apebseq  NOT IN (SELECT apce049||apce050 FROM apce_t ",
               "                                       WHERE apceent=",g_enterprise," AND apceld='",g_ld,"'",
               "                                         AND apce049 IS NOT NULL AND apce050 IS NOT NULL ",
               "                                )",
               "   AND ",g_wc,
               #161115-00042#3 --s add
               "   AND EXISTS (SELECT 1 FROM pmaa_t ",
               "               WHERE pmaaent = ",g_enterprise,
               "               AND ",g_sql_ctrl,
               "               AND pmaaent = apeaent ",
               "               AND pmaa001 = apea005 ) ",
               #161115-00042#3 --e add
               " ORDER BY apebdocno,apeadocdt,apebseq"
   #end add-point
 
   PREPARE aapp440_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp440_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"



   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
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
      #INSERT INTO aapp440_tmp VALUES(g_detail_d[l_ac].*) #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO aapp440_tmp (sel,apebdocno,apeadocdt,apebseq,apeborga,
                               apeborga_desc,apeb002,apeb031,apeb007,apeb008,
                               apeb011,apeb012,apeb100,apeb108,apeb101,
                               apeb118
                              )
      VALUES (g_detail_d[l_ac].sel,g_detail_d[l_ac].apebdocno,g_detail_d[l_ac].apeadocdt,g_detail_d[l_ac].apebseq,g_detail_d[l_ac].apeborga,
              g_detail_d[l_ac].apeborga_desc,g_detail_d[l_ac].apeb002,g_detail_d[l_ac].apeb031,g_detail_d[l_ac].apeb007,g_detail_d[l_ac].apeb008,
              g_detail_d[l_ac].apeb011,g_detail_d[l_ac].apeb012,g_detail_d[l_ac].apeb100,g_detail_d[l_ac].apeb108,g_detail_d[l_ac].apeb101,
              g_detail_d[l_ac].apeb118
             )
      #161108-00017#1 add end---
      #end add-point
      
      CALL aapp440_detail_show()      
 
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
   FREE aapp440_sel
   
   LET l_ac = 1
   CALL aapp440_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp440.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp440_fetch()
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
 
{<section id="aapp440.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp440_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp440.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp440_filter()
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
   
   CALL aapp440_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp440.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp440_filter_parser(ps_field)
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
 
{<section id="aapp440.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp440_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp440_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp440.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 發票代碼顯示與隱藏
PRIVATE FUNCTION aapp440_visible()
   DEFINE l_isai002     LIKE isai_t.isai002
   
   SELECT isai002 INTO l_isai002
     FROM ooef_t
     LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
    WHERE ooefent = g_enterprise
      AND ooef001 = g_input.apeacomp
   IF l_isai002 = "1" THEN
      CALL cl_set_comp_visible('b_apeb007',FALSE)
   ELSE
      CALL cl_set_comp_visible('b_apeb007',TRUE)
   END IF
END FUNCTION
# 賦默認值
PRIVATE FUNCTION aapp440_default()
   DEFINE l_sql            STRING
   
   LET g_input.apeasite = g_site
   LET g_input.apeasite_desc = s_desc_get_department_desc(g_input.apeasite)
   DISPLAY BY NAME g_input.apeasite_desc
   
   CALL s_fin_orga_get_comp_ld(g_input.apeasite) RETURNING g_sub_success,g_errno,g_input.apeacomp,g_ld
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apeacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#3 add #161229-00047#19 mark
   #161229-00047#19 add ------
   CALL s_fin_get_wc_str(g_input.apeacomp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#19 add end---
   LET g_input.apeacomp_desc = s_desc_get_department_desc(g_input.apeacomp)
   DISPLAY BY NAME g_input.apeacomp_desc
   
   LET g_input.apea019 = YEAR(g_today)
   LET g_input.apea020 = MONTH(g_today)
   LET g_input.type = '1'
   LET g_input.apdasite = g_site
   LET g_input.apdasite_desc = s_desc_get_department_desc(g_input.apdasite)
   DISPLAY BY NAME g_input.apdasite_desc
   
   CALL s_fin_orga_get_comp_ld(g_input.apdasite) RETURNING g_sub_success,g_errno,g_comp,g_ld
   CALL s_ld_sel_glaa(g_ld,'glaa024') RETURNING g_sub_success,g_glaa024 
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-3007') RETURNING g_sfin3007
   LET g_input.apda003 = g_user
   LET g_input.apda003_desc = s_desc_get_person_desc(g_input.apda003)
   DISPLAY BY NAME g_input.apda003_desc
   
   LET g_input.apdadocdt = g_today
   
   CALL aapp440_get_docno() RETURNING g_input.apdadocno
END FUNCTION
# 抓取默認單別
PRIVATE FUNCTION aapp440_get_docno()
   DEFINE l_sql            STRING
   DEFINE r_docno          LIKE apda_t.apdadocno

   LET r_docno = ''
   LET l_sql = "SELECT DISTINCT ooba002 ",
               "  FROM ooba_t ",
               "  LEFT OUTER JOIN ooac_t ",
               "    ON ooacent = oobaent ",
               "   AND ooac001 = ooba001 ",
               "   AND ooac002 = ooba002 ",
               " WHERE oobaent = ",g_enterprise,
               "   AND ooba002 IN (SELECT oobl001 ",
               "                     FROM oobl_t ",
               "                    WHERE ooblent = ",g_enterprise,
               "                      AND oobl002 = 'aapt420')",
               "   AND oobastus = 'Y' ",
               "   AND ooba001 = '",g_glaa024,"'",
               " ORDER BY ooba002 "
   PREPARE ooba_pre1 FROM l_sql
   DECLARE ooba_cur1 SCROLL CURSOR WITH HOLD FOR ooba_pre1
   OPEN ooba_cur1
   FETCH FIRST ooba_cur1 INTO r_docno
   CLOSE ooba_cur1
   
   RETURN r_docno
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION aapp440_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE aapp440_tmp;
   CREATE TEMP TABLE aapp440_tmp(
      sel                  VARCHAR(1),
      apebdocno            VARCHAR(20),
      apeadocdt            DATE,
      apebseq              INTEGER,
      apeborga             VARCHAR(10),
      apeborga_desc        VARCHAR(80),
      apeb002              VARCHAR(20),
      apeb031              DATE,
      apeb007              VARCHAR(20),
      apeb008              VARCHAR(20),
      apeb011              DATE,
      apeb012              VARCHAR(10),
      apeb100              VARCHAR(10),
      apeb108              DECIMAL(20,6),
      apeb101              DECIMAL(20,10),
      apeb118              DECIMAL(20,6)
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 批處理邏輯
PRIVATE FUNCTION aapp440_p()
   DEFINE l_sql               STRING
   DEFINE l_apebdocno         LIKE apeb_t.apebdocno
   DEFINE l_apeb031           LIKE apeb_t.apeb031
   DEFINE l_apea005           LIKE apea_t.apea005
   DEFINE l_apeadocdt         LIKE apea_t.apeadocdt
   #DEFINE l_apda              RECORD LIKE apda_t.*  #161104-00024#1 mark
   #161104-00024#1-add(s)
   DEFINE l_apda  RECORD  #付款核銷單單頭檔
          apdaent   LIKE apda_t.apdaent, #企業編號
          apdacomp  LIKE apda_t.apdacomp, #法人
          apdald    LIKE apda_t.apdald, #帳套
          apdadocno LIKE apda_t.apdadocno, #單號
          apdadocdt LIKE apda_t.apdadocdt, #單據日期
          apdasite  LIKE apda_t.apdasite, #帳務組織
          apda001   LIKE apda_t.apda001, #帳款單性質
          apda002   LIKE apda_t.apda002, #NO USE
          apda003   LIKE apda_t.apda003, #帳務人員
          apda004   LIKE apda_t.apda004, #帳款核銷對象
          apda005   LIKE apda_t.apda005, #付款對象
          apda006   LIKE apda_t.apda006, #一次性交易識別碼
          apda007   LIKE apda_t.apda007, #產生方式
          apda008   LIKE apda_t.apda008, #來源參考單號
          apda009   LIKE apda_t.apda009, #沖帳批序號
          apda010   LIKE apda_t.apda010, #集團代付付單號
          apda011   LIKE apda_t.apda011, #差異處理
          apda012   LIKE apda_t.apda012, #退款類型
          apda013   LIKE apda_t.apda013, #分錄底稿是否可重新產生
          apda014   LIKE apda_t.apda014, #拋轉傳票號碼
          apda015   LIKE apda_t.apda015, #作廢理由碼
          apda016   LIKE apda_t.apda016, #列印次數
          apda017   LIKE apda_t.apda017, #MEMO備註
          apda018   LIKE apda_t.apda018, #付款(攤銷)理由碼
          apda019   LIKE apda_t.apda019, #攤銷目的方式
          apda020   LIKE apda_t.apda020, #分攤金額方式
          apda021   LIKE apda_t.apda021, #目的成本要素
          apda113   LIKE apda_t.apda113, #應核銷本幣金額
          apda123   LIKE apda_t.apda123, #應核銷本幣二金額
          apda133   LIKE apda_t.apda133, #應核銷本幣三金額
          apdaownid LIKE apda_t.apdaownid, #資料所有者
          apdaowndp LIKE apda_t.apdaowndp, #資料所屬部門
          apdacrtid LIKE apda_t.apdacrtid, #資料建立者
          apdacrtdp LIKE apda_t.apdacrtdp, #資料建立部門
          apdacrtdt LIKE apda_t.apdacrtdt, #資料創建日
          apdamodid LIKE apda_t.apdamodid, #資料修改者
          apdamoddt LIKE apda_t.apdamoddt, #最近修改日
          apdacnfid LIKE apda_t.apdacnfid, #資料確認者
          apdacnfdt LIKE apda_t.apdacnfdt, #資料確認日
          apdapstid LIKE apda_t.apdapstid, #資料過帳者
          apdapstdt LIKE apda_t.apdapstdt, #資料過帳日
          apdastus  LIKE apda_t.apdastus, #狀態碼
          apdaud001 LIKE apda_t.apdaud001, #自定義欄位(文字)001
          apdaud002 LIKE apda_t.apdaud002, #自定義欄位(文字)002
          apdaud003 LIKE apda_t.apdaud003, #自定義欄位(文字)003
          apdaud004 LIKE apda_t.apdaud004, #自定義欄位(文字)004
          apdaud005 LIKE apda_t.apdaud005, #自定義欄位(文字)005
          apdaud006 LIKE apda_t.apdaud006, #自定義欄位(文字)006
          apdaud007 LIKE apda_t.apdaud007, #自定義欄位(文字)007
          apdaud008 LIKE apda_t.apdaud008, #自定義欄位(文字)008
          apdaud009 LIKE apda_t.apdaud009, #自定義欄位(文字)009
          apdaud010 LIKE apda_t.apdaud010, #自定義欄位(文字)010
          apdaud011 LIKE apda_t.apdaud011, #自定義欄位(數字)011
          apdaud012 LIKE apda_t.apdaud012, #自定義欄位(數字)012
          apdaud013 LIKE apda_t.apdaud013, #自定義欄位(數字)013
          apdaud014 LIKE apda_t.apdaud014, #自定義欄位(數字)014
          apdaud015 LIKE apda_t.apdaud015, #自定義欄位(數字)015
          apdaud016 LIKE apda_t.apdaud016, #自定義欄位(數字)016
          apdaud017 LIKE apda_t.apdaud017, #自定義欄位(數字)017
          apdaud018 LIKE apda_t.apdaud018, #自定義欄位(數字)018
          apdaud019 LIKE apda_t.apdaud019, #自定義欄位(數字)019
          apdaud020 LIKE apda_t.apdaud020, #自定義欄位(數字)020
          apdaud021 LIKE apda_t.apdaud021, #自定義欄位(日期時間)021
          apdaud022 LIKE apda_t.apdaud022, #自定義欄位(日期時間)022
          apdaud023 LIKE apda_t.apdaud023, #自定義欄位(日期時間)023
          apdaud024 LIKE apda_t.apdaud024, #自定義欄位(日期時間)024
          apdaud025 LIKE apda_t.apdaud025, #自定義欄位(日期時間)025
          apdaud026 LIKE apda_t.apdaud026, #自定義欄位(日期時間)026
          apdaud027 LIKE apda_t.apdaud027, #自定義欄位(日期時間)027
          apdaud028 LIKE apda_t.apdaud028, #自定義欄位(日期時間)028
          apdaud029 LIKE apda_t.apdaud029, #自定義欄位(日期時間)029
          apdaud030 LIKE apda_t.apdaud030, #自定義欄位(日期時間)030
          apda104   LIKE apda_t.apda104, #原幣借方金額合計
          apda105   LIKE apda_t.apda105, #原幣貸方金額合計
          apda114   LIKE apda_t.apda114, #本幣借方金額合計
          apda115   LIKE apda_t.apda115, #本幣貸方金額合計
          apda124   LIKE apda_t.apda124, #本位幣二借方金額合計
          apda125   LIKE apda_t.apda125, #本位幣二貸方金額合計
          apda134   LIKE apda_t.apda134, #本位幣三借方金額合計
          apda135   LIKE apda_t.apda135, #本位幣三貸方金額合計
          apda022   LIKE apda_t.apda022, #經營方式
          apda023   LIKE apda_t.apda023  #請款單號
              END RECORD
   #161104-00024#1-add(e)
   DEFINE l_success           LIKE type_t.num5
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_glaa121           LIKE glaa_t.glaa121
   DEFINE l_ap_slip           LIKE apda_t.apdadocno
   DEFINE l_dfin0030          LIKE type_t.chr1
   DEFINE l_apce109_c         LIKE apce_t.apce109
   DEFINE l_apce119_c         LIKE apce_t.apce119
   DEFINE l_apce129_c         LIKE apce_t.apce129
   DEFINE l_apce139_c         LIKE apce_t.apce139
   
   LET r_success = TRUE
   
   IF g_input.type = '1' THEN    #依請款單號產生 
      LET l_sql = "SELECT DISTINCT apebdocno,apeb031,apea005,apeadocdt FROM apea_t,apeb_t "
   END IF
   
   IF g_input.type = '2' THEN    #依付款到期日＋付款對象合併產生 
      LET l_sql = "SELECT DISTINCT '',apeb031,apea005,apeadocdt FROM apea_t,apeb_t "
   END IF
   
   IF g_input.type = '3' THEN    #依付款對象產生 
      LET l_sql = "SELECT DISTINCT '','',apea005,apeadocdt FROM apea_t,apeb_t "
   END IF
   
   LET l_sql = l_sql," WHERE apeaent = ",g_enterprise,
                     "   AND apeaent=apebent AND apeadocno=apebdocno",
                     "   AND apebdocno||apebseq IN (SELECT apebdocno||apebseq FROM aapp440_tmp WHERE sel = 'Y')"
                     
   PREPARE aapp440_pre FROM l_sql
   DECLARE aapp440_cs CURSOR FOR aapp440_pre
   
   SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_ld
   
   FOREACH aapp440_cs INTO l_apebdocno,l_apeb031,l_apea005,l_apeadocdt
      IF cl_null(g_input.apdadocdt) THEN 
         LET g_input.apdadocdt = l_apeadocdt
      END IF
   
      LET l_apda.apdaent   = g_enterprise
      LET l_apda.apdacomp  = g_comp
      LET l_apda.apdald    = g_ld
      LET l_apda.apdadocdt = g_input.apdadocdt
      LET l_apda.apdasite  = g_input.apdasite
      LET l_apda.apda001   = '45'
      LET l_apda.apda003   = g_input.apda003
      LET l_apda.apda004   = ''	         
      LET l_apda.apda005   = l_apea005
      LET l_apda.apda006   = ''
      LET l_apda.apda007   = '0'
      LET l_apda.apda013   = 'Y'
      LET l_apda.apda016	= 0
      #LET l_apda.apda113 =sum(本單之apce119)	#應核銷本幣金額
      LET l_apda.apda123   =0	           
      LET l_apda.apda133   =0	        
      LET l_apda.apdastus  ='N'
      LET l_apda.apdaownid = g_user
      LET l_apda.apdaowndp = g_dept
      LET l_apda.apdacrtid = g_user
      LET l_apda.apdacrtdp = g_dept
      LET l_apda.apdacrtdt = cl_get_current()
      
      CALL s_aooi200_fin_gen_docno(l_apda.apdald,'','',g_input.apdadocno,l_apda.apdadocdt,'aapt420')
           RETURNING g_sub_success,l_apda.apdadocno
      IF g_sub_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_apda.apdadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
      
      #INSERT INTO apda_t VALUES(l_apda.*) #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO apda_t (apdaent,apdacomp,apdald,apdadocno,apdadocdt,apdasite,
                          apda001,apda002,apda003,apda004,apda005,
                          apda006,apda007,apda008,apda009,apda010,
                          apda011,apda012,apda013,apda014,apda015,
                          apda016,apda017,apda018,apda019,apda020,
                          apda021,apda113,apda123,apda133,
                          apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,
                          apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid,
                          apdapstdt,apdastus,
                          #161125-00021#1 add ------
                          apdaud001,apdaud002,apdaud003,apdaud004,apdaud005,
                          apdaud006,apdaud007,apdaud008,apdaud009,apdaud010,
                          apdaud011,apdaud012,apdaud013,apdaud014,apdaud015,
                          apdaud016,apdaud017,apdaud018,apdaud019,apdaud020,
                          apdaud021,apdaud022,apdaud023,apdaud024,apdaud025,
                          apdaud026,apdaud027,apdaud028,apdaud029,apdaud030,
                          #161125-00021#1 add end---
                          apda104,apda105,apda114,apda115,apda124,
                          apda125,apda134,apda135,apda022,apda023
                         )
      VALUES (l_apda.apdaent,l_apda.apdacomp,l_apda.apdald,l_apda.apdadocno,l_apda.apdadocdt,l_apda.apdasite,
              l_apda.apda001,l_apda.apda002,l_apda.apda003,l_apda.apda004,l_apda.apda005,
              l_apda.apda006,l_apda.apda007,l_apda.apda008,l_apda.apda009,l_apda.apda010,
              l_apda.apda011,l_apda.apda012,l_apda.apda013,l_apda.apda014,l_apda.apda015,
              l_apda.apda016,l_apda.apda017,l_apda.apda018,l_apda.apda019,l_apda.apda020,
              l_apda.apda021,l_apda.apda113,l_apda.apda123,l_apda.apda133,
              l_apda.apdaownid,l_apda.apdaowndp,l_apda.apdacrtid,l_apda.apdacrtdp,l_apda.apdacrtdt,
              l_apda.apdamodid,l_apda.apdamoddt,l_apda.apdacnfid,l_apda.apdacnfdt,l_apda.apdapstid,
              l_apda.apdapstdt,l_apda.apdastus,
              #161125-00021#1 add ------
              l_apda.apdaud001,l_apda.apdaud002,l_apda.apdaud003,l_apda.apdaud004,l_apda.apdaud005,
              l_apda.apdaud006,l_apda.apdaud007,l_apda.apdaud008,l_apda.apdaud009,l_apda.apdaud010,
              l_apda.apdaud011,l_apda.apdaud012,l_apda.apdaud013,l_apda.apdaud014,l_apda.apdaud015,
              l_apda.apdaud016,l_apda.apdaud017,l_apda.apdaud018,l_apda.apdaud019,l_apda.apdaud020,
              l_apda.apdaud021,l_apda.apdaud022,l_apda.apdaud023,l_apda.apdaud024,l_apda.apdaud025,
              l_apda.apdaud026,l_apda.apdaud027,l_apda.apdaud028,l_apda.apdaud029,l_apda.apdaud030,
              #161125-00021#1 add end---
              l_apda.apda104,l_apda.apda105,l_apda.apda114,l_apda.apda115,l_apda.apda124,
              l_apda.apda125,l_apda.apda134,l_apda.apda135,l_apda.apda022,l_apda.apda023
             )
      #161108-00017#1 add end---
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert into apda_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      #账款单身资料
      CALL aapp440_ins_apce(l_apda.apdadocno,l_apda.apdald,l_apebdocno,l_apeb031,l_apea005) RETURNING l_success
      IF l_success = FALSE THEN
         LET r_success = FALSE
      END IF
      #付款单身资料
      CALL aapp440_ins_apde(l_apda.apdadocno,l_apda.apdald) RETURNING l_success
      IF l_success = FALSE THEN
         LET r_success = FALSE
      END IF
      
      #更新单头金额
      #借方金额
      SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
        INTO l_apda.apda104,l_apda.apda114,l_apda.apda124,l_apda.apda134
      FROM apce_t
      WHERE apceent=g_enterprise AND apceld=l_apda.apdald 
        AND apcedocno=l_apda.apdadocno AND apce015='D'
      IF cl_null(l_apda.apda104) THEN LET l_apda.apda104=0 END IF
      IF cl_null(l_apda.apda114) THEN LET l_apda.apda114=0 END IF
      IF cl_null(l_apda.apda124) THEN LET l_apda.apda124=0 END IF
      IF cl_null(l_apda.apda134) THEN LET l_apda.apda134=0 END IF
      
      #付款单身贷方金额
      SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)
        INTO l_apda.apda105,l_apda.apda115,l_apda.apda125,l_apda.apda135
      FROM apde_t
      WHERE apdeent=g_enterprise AND apdeld=l_apda.apdald 
        AND apdedocno=l_apda.apdadocno AND apde015='C'
      IF cl_null(l_apda.apda105) THEN LET l_apda.apda105=0 END IF
      IF cl_null(l_apda.apda115) THEN LET l_apda.apda115=0 END IF
      IF cl_null(l_apda.apda125) THEN LET l_apda.apda125=0 END IF
      IF cl_null(l_apda.apda135) THEN LET l_apda.apda135=0 END IF
      
      #账款资料的贷方金额
      SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
        INTO l_apce109_c,l_apce119_c,l_apce129_c,l_apce139_c
      FROM apce_t
      WHERE apceent=g_enterprise AND apceld=l_apda.apdald 
        AND apcedocno=l_apda.apdadocno AND apce015='C'
      IF cl_null(l_apce109_c) THEN LET l_apce109_c=0 END IF
      IF cl_null(l_apce119_c) THEN LET l_apce119_c=0 END IF
      IF cl_null(l_apce129_c) THEN LET l_apce129_c=0 END IF
      IF cl_null(l_apce139_c) THEN LET l_apce139_c=0 END IF
      #贷方金额
      LET l_apda.apda105 = l_apda.apda105 + l_apce109_c
      LET l_apda.apda115 = l_apda.apda115 + l_apce119_c
      LET l_apda.apda125 = l_apda.apda125 + l_apce129_c
      LET l_apda.apda135 = l_apda.apda135 + l_apce139_c
      
      #應核銷本幣金額LET apda113 =sum(本單之apce109)	#應核銷本幣金額
      LET l_apda.apda113 = l_apda.apda114 + l_apce119_c
      LET l_apda.apda123 = l_apda.apda124 + l_apce129_c
      LET l_apda.apda133 = l_apda.apda134 + l_apce139_c
      
      UPDATE apda_t SET apda113=l_apda.apda113,
                        apda123=l_apda.apda123,
                        apda133=l_apda.apda133,
                        apda104=l_apda.apda104,
                        apda114=l_apda.apda114,
                        apda124=l_apda.apda124,
                        apda134=l_apda.apda134,
                        apda105=l_apda.apda105,
                        apda115=l_apda.apda115,
                        apda125=l_apda.apda125,
                        apda135=l_apda.apda135
      WHERE apdaent=g_enterprise AND apdald=l_apda.apdald AND apdadocno=l_apda.apdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update apda_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      
      #产生分录底稿
      IF r_success =TRUE THEN
         CALL s_aooi200_fin_get_slip(l_apda.apdadocno) RETURNING l_success,l_ap_slip               
         CALL s_fin_get_doc_para(l_apda.apdald,l_apda.apdadocno,l_ap_slip,'D-FIN-0030') RETURNING l_dfin0030
         IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y'THEN
            CALL s_pre_voucher_ins('AP','P20',l_apda.apdald,l_apda.apdadocno,l_apda.apdadocdt,'2')
            RETURNING l_success
            IF l_success = FALSE THEN 
               LET r_success = FALSE
            END IF
         END IF
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION
# 插入账款单身
PRIVATE FUNCTION aapp440_ins_apce(p_apdadocno,p_apdald,p_apebdocno,p_apeb031,p_apea005)
   DEFINE p_apdadocno             LIKE apda_t.apdadocno
   DEFINE p_apdald                LIKE apda_t.apdald
   DEFINE p_apebdocno             LIKE apeb_t.apebdocno
   DEFINE p_apeb031               LIKE apeb_t.apeb031
   DEFINE p_apea005               LIKE apea_t.apea005
   #DEFINE l_apeb                  RECORD LIKE apeb_t.* #161104-00024#1 mark
   #DEFINE l_apce                  RECORD LIKE apce_t.* #161104-00024#1 mark
   #DEFINE l_apda                  RECORD LIKE apda_t.* #161104-00024#1 mark
   #161104-00024#1-add(s)
   DEFINE l_apeb  RECORD  #付款申請帳款明細檔
          apebent   LIKE apeb_t.apebent, #企業編號
          apebcomp  LIKE apeb_t.apebcomp, #法人
          apebsite  LIKE apeb_t.apebsite, #資金中心
          apebld    LIKE apeb_t.apebld, #帳套
          apeborga  LIKE apeb_t.apeborga, #帳務歸屬組織
          apebdocno LIKE apeb_t.apebdocno, #沖銷單單號
          apebseq   LIKE apeb_t.apebseq, #項次
          apeb001   LIKE apeb_t.apeb001, #來源作業
          apeb002   LIKE apeb_t.apeb002, #對帳單號
          apeb003   LIKE apeb_t.apeb003, #沖銷帳款單單號
          apeb004   LIKE apeb_t.apeb004, #沖銷帳款單項次
          apeb005   LIKE apeb_t.apeb005, #沖銷帳款單帳期
          apeb006   LIKE apeb_t.apeb006, #款別性質
          apeb007   LIKE apeb_t.apeb007, #發票編號
          apeb008   LIKE apeb_t.apeb008, #發票號碼
          apeb010   LIKE apeb_t.apeb010, #摘要說明
          apeb013   LIKE apeb_t.apeb013, #帳款對象
          apeb015   LIKE apeb_t.apeb015, #沖銷加減項
          apeb016   LIKE apeb_t.apeb016, #沖銷科目
          apeb024   LIKE apeb_t.apeb024, #付款單號
          apeb025   LIKE apeb_t.apeb025, #付款單項次
          apeb028   LIKE apeb_t.apeb028, #產生方式
          apeb031   LIKE apeb_t.apeb031, #應付到期日
          apeb100   LIKE apeb_t.apeb100, #幣別
          apeb101   LIKE apeb_t.apeb101, #匯率
          apeb109   LIKE apeb_t.apeb109, #原幣已沖銷金額
          apeb119   LIKE apeb_t.apeb119, #本幣已沖銷金額
          apebud001 LIKE apeb_t.apebud001, #自定義欄位(文字)001
          apebud002 LIKE apeb_t.apebud002, #自定義欄位(文字)002
          apebud003 LIKE apeb_t.apebud003, #自定義欄位(文字)003
          apebud004 LIKE apeb_t.apebud004, #自定義欄位(文字)004
          apebud005 LIKE apeb_t.apebud005, #自定義欄位(文字)005
          apebud006 LIKE apeb_t.apebud006, #自定義欄位(文字)006
          apebud007 LIKE apeb_t.apebud007, #自定義欄位(文字)007
          apebud008 LIKE apeb_t.apebud008, #自定義欄位(文字)008
          apebud009 LIKE apeb_t.apebud009, #自定義欄位(文字)009
          apebud010 LIKE apeb_t.apebud010, #自定義欄位(文字)010
          apebud011 LIKE apeb_t.apebud011, #自定義欄位(數字)011
          apebud012 LIKE apeb_t.apebud012, #自定義欄位(數字)012
          apebud013 LIKE apeb_t.apebud013, #自定義欄位(數字)013
          apebud014 LIKE apeb_t.apebud014, #自定義欄位(數字)014
          apebud015 LIKE apeb_t.apebud015, #自定義欄位(數字)015
          apebud016 LIKE apeb_t.apebud016, #自定義欄位(數字)016
          apebud017 LIKE apeb_t.apebud017, #自定義欄位(數字)017
          apebud018 LIKE apeb_t.apebud018, #自定義欄位(數字)018
          apebud019 LIKE apeb_t.apebud019, #自定義欄位(數字)019
          apebud020 LIKE apeb_t.apebud020, #自定義欄位(數字)020
          apebud021 LIKE apeb_t.apebud021, #自定義欄位(日期時間)021
          apebud022 LIKE apeb_t.apebud022, #自定義欄位(日期時間)022
          apebud023 LIKE apeb_t.apebud023, #自定義欄位(日期時間)023
          apebud024 LIKE apeb_t.apebud024, #自定義欄位(日期時間)024
          apebud025 LIKE apeb_t.apebud025, #自定義欄位(日期時間)025
          apebud026 LIKE apeb_t.apebud026, #自定義欄位(日期時間)026
          apebud027 LIKE apeb_t.apebud027, #自定義欄位(日期時間)027
          apebud028 LIKE apeb_t.apebud028, #自定義欄位(日期時間)028
          apebud029 LIKE apeb_t.apebud029, #自定義欄位(日期時間)029
          apebud030 LIKE apeb_t.apebud030, #自定義欄位(日期時間)030
          apeb011   LIKE apeb_t.apeb011, #發票日期
          apeb012   LIKE apeb_t.apeb012, #發票類型
          apeb108   LIKE apeb_t.apeb108, #原幣請款金額
          apeb118   LIKE apeb_t.apeb118, #本幣請款金額
          apeb023   LIKE apeb_t.apeb023  #付款對象
              END RECORD
   DEFINE l_apce  RECORD  #應付沖帳明細
          apceent   LIKE apce_t.apceent, #企業編號
          apcecomp  LIKE apce_t.apcecomp, #法人
          apcelegl  LIKE apce_t.apcelegl, #核算組織
          apcesite  LIKE apce_t.apcesite, #帳務組織
          apceld    LIKE apce_t.apceld, #帳套
          apceorga  LIKE apce_t.apceorga, #帳務歸屬組織
          apcedocno LIKE apce_t.apcedocno, #沖銷單單號
          apceseq   LIKE apce_t.apceseq, #項次
          apce001   LIKE apce_t.apce001, #來源作業
          apce002   LIKE apce_t.apce002, #沖銷類型
          apce003   LIKE apce_t.apce003, #沖銷帳款單單號
          apce004   LIKE apce_t.apce004, #沖銷帳款單項次
          apce005   LIKE apce_t.apce005, #分期帳款序
          apce006   LIKE apce_t.apce006, #no use
          apce007   LIKE apce_t.apce007, #no use
          apce008   LIKE apce_t.apce008, #票據號碼/ 現金銀存帳戶
          apce009   LIKE apce_t.apce009, #no use
          apce010   LIKE apce_t.apce010, #摘要說明
          apce011   LIKE apce_t.apce011, #理由碼
          apce012   LIKE apce_t.apce012, #銀存存提碼
          apce013   LIKE apce_t.apce013, #現金異動碼
          apce014   LIKE apce_t.apce014, #no use
          apce015   LIKE apce_t.apce015, #沖銷加減項
          apce016   LIKE apce_t.apce016, #沖銷科目
          apce017   LIKE apce_t.apce017, #業務人員
          apce018   LIKE apce_t.apce018, #業務部門
          apce019   LIKE apce_t.apce019, #責任中心
          apce020   LIKE apce_t.apce020, #產品類別
          apce021   LIKE apce_t.apce021, #no use
          apce022   LIKE apce_t.apce022, #專案編號
          apce023   LIKE apce_t.apce023, #WBS編號
          apce024   LIKE apce_t.apce024, #第二參考單號
          apce025   LIKE apce_t.apce025, #第二參考單號項次
          apce026   LIKE apce_t.apce026, #no use
          apce027   LIKE apce_t.apce027, #應稅折抵否
          apce028   LIKE apce_t.apce028, #產生方式
          apce029   LIKE apce_t.apce029, #傳票號碼
          apce030   LIKE apce_t.apce030, #傳票項次
          apce031   LIKE apce_t.apce031, #付款(票)到期日
          apce032   LIKE apce_t.apce032, #應付款日
          apce033   LIKE apce_t.apce033, #no use
          apce034   LIKE apce_t.apce034, #no use
          apce035   LIKE apce_t.apce035, #區域
          apce036   LIKE apce_t.apce036, #客戶分類
          apce037   LIKE apce_t.apce037, #no use
          apce038   LIKE apce_t.apce038, #帳款對象
          apce039   LIKE apce_t.apce039, #no use
          apce040   LIKE apce_t.apce040, #no use
          apce041   LIKE apce_t.apce041, #no use
          apce042   LIKE apce_t.apce042, #no use
          apce043   LIKE apce_t.apce043, #no use
          apce044   LIKE apce_t.apce044, #經營方式
          apce045   LIKE apce_t.apce045, #通路
          apce046   LIKE apce_t.apce046, #品牌
          apce047   LIKE apce_t.apce047, #發票編號
          apce048   LIKE apce_t.apce048, #發票號碼
          apce049   LIKE apce_t.apce049, #付款申請單號碼
          apce050   LIKE apce_t.apce050, #付款申請單項次
          apce051   LIKE apce_t.apce051, #自由核算項一
          apce052   LIKE apce_t.apce052, #自由核算項二
          apce053   LIKE apce_t.apce053, #自由核算項三
          apce054   LIKE apce_t.apce054, #自由核算項四
          apce055   LIKE apce_t.apce055, #自由核算項五
          apce056   LIKE apce_t.apce056, #自由核算項六
          apce057   LIKE apce_t.apce057, #自由核算項七
          apce058   LIKE apce_t.apce058, #自由核算項八
          apce059   LIKE apce_t.apce059, #自由核算項九
          apce060   LIKE apce_t.apce060, #自由核算項十
          apce100   LIKE apce_t.apce100, #幣別
          apce101   LIKE apce_t.apce101, #匯率
          apce104   LIKE apce_t.apce104, #原幣應稅折抵稅額
          apce109   LIKE apce_t.apce109, #原幣沖帳金額
          apce114   LIKE apce_t.apce114, #本幣應稅折抵稅額
          apce119   LIKE apce_t.apce119, #本幣沖帳金額
          apce120   LIKE apce_t.apce120, #本位幣二幣別
          apce124   LIKE apce_t.apce124, #本位幣二應稅折抵稅額
          apce121   LIKE apce_t.apce121, #本位幣二匯率
          apce129   LIKE apce_t.apce129, #本位幣二沖帳金額
          apce130   LIKE apce_t.apce130, #本位幣三幣別
          apce131   LIKE apce_t.apce131, #本位幣三匯率
          apce134   LIKE apce_t.apce134, #本位幣三應稅折抵稅額
          apce139   LIKE apce_t.apce139, #本位幣三沖帳金額
          apceud001 LIKE apce_t.apceud001, #自定義欄位(文字)001
          apceud002 LIKE apce_t.apceud002, #自定義欄位(文字)002
          apceud003 LIKE apce_t.apceud003, #自定義欄位(文字)003
          apceud004 LIKE apce_t.apceud004, #自定義欄位(文字)004
          apceud005 LIKE apce_t.apceud005, #自定義欄位(文字)005
          apceud006 LIKE apce_t.apceud006, #自定義欄位(文字)006
          apceud007 LIKE apce_t.apceud007, #自定義欄位(文字)007
          apceud008 LIKE apce_t.apceud008, #自定義欄位(文字)008
          apceud009 LIKE apce_t.apceud009, #自定義欄位(文字)009
          apceud010 LIKE apce_t.apceud010, #自定義欄位(文字)010
          apceud011 LIKE apce_t.apceud011, #自定義欄位(數字)011
          apceud012 LIKE apce_t.apceud012, #自定義欄位(數字)012
          apceud013 LIKE apce_t.apceud013, #自定義欄位(數字)013
          apceud014 LIKE apce_t.apceud014, #自定義欄位(數字)014
          apceud015 LIKE apce_t.apceud015, #自定義欄位(數字)015
          apceud016 LIKE apce_t.apceud016, #自定義欄位(數字)016
          apceud017 LIKE apce_t.apceud017, #自定義欄位(數字)017
          apceud018 LIKE apce_t.apceud018, #自定義欄位(數字)018
          apceud019 LIKE apce_t.apceud019, #自定義欄位(數字)019
          apceud020 LIKE apce_t.apceud020, #自定義欄位(數字)020
          apceud021 LIKE apce_t.apceud021, #自定義欄位(日期時間)021
          apceud022 LIKE apce_t.apceud022, #自定義欄位(日期時間)022
          apceud023 LIKE apce_t.apceud023, #自定義欄位(日期時間)023
          apceud024 LIKE apce_t.apceud024, #自定義欄位(日期時間)024
          apceud025 LIKE apce_t.apceud025, #自定義欄位(日期時間)025
          apceud026 LIKE apce_t.apceud026, #自定義欄位(日期時間)026
          apceud027 LIKE apce_t.apceud027, #自定義欄位(日期時間)027
          apceud028 LIKE apce_t.apceud028, #自定義欄位(日期時間)028
          apceud029 LIKE apce_t.apceud029, #自定義欄位(日期時間)029
          apceud030 LIKE apce_t.apceud030, #自定義欄位(日期時間)030
          apce103   LIKE apce_t.apce103, #原幣未稅沖銷額
          apce113   LIKE apce_t.apce113, #本位未稅沖銷額
          apce123   LIKE apce_t.apce123, #本位幣二未稅沖銷額
          apce133   LIKE apce_t.apce133, #本位幣三未稅沖銷額
          apce061   LIKE apce_t.apce061  #付款對象
              END RECORD
   DEFINE l_apda  RECORD  #付款核銷單單頭檔
          apdaent   LIKE apda_t.apdaent, #企業編號
          apdacomp  LIKE apda_t.apdacomp, #法人
          apdald    LIKE apda_t.apdald, #帳套
          apdadocno LIKE apda_t.apdadocno, #單號
          apdadocdt LIKE apda_t.apdadocdt, #單據日期
          apdasite  LIKE apda_t.apdasite, #帳務組織
          apda001   LIKE apda_t.apda001, #帳款單性質
          apda002   LIKE apda_t.apda002, #NO USE
          apda003   LIKE apda_t.apda003, #帳務人員
          apda004   LIKE apda_t.apda004, #帳款核銷對象
          apda005   LIKE apda_t.apda005, #付款對象
          apda006   LIKE apda_t.apda006, #一次性交易識別碼
          apda007   LIKE apda_t.apda007, #產生方式
          apda008   LIKE apda_t.apda008, #來源參考單號
          apda009   LIKE apda_t.apda009, #沖帳批序號
          apda010   LIKE apda_t.apda010, #集團代付付單號
          apda011   LIKE apda_t.apda011, #差異處理
          apda012   LIKE apda_t.apda012, #退款類型
          apda013   LIKE apda_t.apda013, #分錄底稿是否可重新產生
          apda014   LIKE apda_t.apda014, #拋轉傳票號碼
          apda015   LIKE apda_t.apda015, #作廢理由碼
          apda016   LIKE apda_t.apda016, #列印次數
          apda017   LIKE apda_t.apda017, #MEMO備註
          apda018   LIKE apda_t.apda018, #付款(攤銷)理由碼
          apda019   LIKE apda_t.apda019, #攤銷目的方式
          apda020   LIKE apda_t.apda020, #分攤金額方式
          apda021   LIKE apda_t.apda021, #目的成本要素
          apda113   LIKE apda_t.apda113, #應核銷本幣金額
          apda123   LIKE apda_t.apda123, #應核銷本幣二金額
          apda133   LIKE apda_t.apda133, #應核銷本幣三金額
          apdaownid LIKE apda_t.apdaownid, #資料所有者
          apdaowndp LIKE apda_t.apdaowndp, #資料所屬部門
          apdacrtid LIKE apda_t.apdacrtid, #資料建立者
          apdacrtdp LIKE apda_t.apdacrtdp, #資料建立部門
          apdacrtdt LIKE apda_t.apdacrtdt, #資料創建日
          apdamodid LIKE apda_t.apdamodid, #資料修改者
          apdamoddt LIKE apda_t.apdamoddt, #最近修改日
          apdacnfid LIKE apda_t.apdacnfid, #資料確認者
          apdacnfdt LIKE apda_t.apdacnfdt, #資料確認日
          apdapstid LIKE apda_t.apdapstid, #資料過帳者
          apdapstdt LIKE apda_t.apdapstdt, #資料過帳日
          apdastus  LIKE apda_t.apdastus, #狀態碼
          apdaud001 LIKE apda_t.apdaud001, #自定義欄位(文字)001
          apdaud002 LIKE apda_t.apdaud002, #自定義欄位(文字)002
          apdaud003 LIKE apda_t.apdaud003, #自定義欄位(文字)003
          apdaud004 LIKE apda_t.apdaud004, #自定義欄位(文字)004
          apdaud005 LIKE apda_t.apdaud005, #自定義欄位(文字)005
          apdaud006 LIKE apda_t.apdaud006, #自定義欄位(文字)006
          apdaud007 LIKE apda_t.apdaud007, #自定義欄位(文字)007
          apdaud008 LIKE apda_t.apdaud008, #自定義欄位(文字)008
          apdaud009 LIKE apda_t.apdaud009, #自定義欄位(文字)009
          apdaud010 LIKE apda_t.apdaud010, #自定義欄位(文字)010
          apdaud011 LIKE apda_t.apdaud011, #自定義欄位(數字)011
          apdaud012 LIKE apda_t.apdaud012, #自定義欄位(數字)012
          apdaud013 LIKE apda_t.apdaud013, #自定義欄位(數字)013
          apdaud014 LIKE apda_t.apdaud014, #自定義欄位(數字)014
          apdaud015 LIKE apda_t.apdaud015, #自定義欄位(數字)015
          apdaud016 LIKE apda_t.apdaud016, #自定義欄位(數字)016
          apdaud017 LIKE apda_t.apdaud017, #自定義欄位(數字)017
          apdaud018 LIKE apda_t.apdaud018, #自定義欄位(數字)018
          apdaud019 LIKE apda_t.apdaud019, #自定義欄位(數字)019
          apdaud020 LIKE apda_t.apdaud020, #自定義欄位(數字)020
          apdaud021 LIKE apda_t.apdaud021, #自定義欄位(日期時間)021
          apdaud022 LIKE apda_t.apdaud022, #自定義欄位(日期時間)022
          apdaud023 LIKE apda_t.apdaud023, #自定義欄位(日期時間)023
          apdaud024 LIKE apda_t.apdaud024, #自定義欄位(日期時間)024
          apdaud025 LIKE apda_t.apdaud025, #自定義欄位(日期時間)025
          apdaud026 LIKE apda_t.apdaud026, #自定義欄位(日期時間)026
          apdaud027 LIKE apda_t.apdaud027, #自定義欄位(日期時間)027
          apdaud028 LIKE apda_t.apdaud028, #自定義欄位(日期時間)028
          apdaud029 LIKE apda_t.apdaud029, #自定義欄位(日期時間)029
          apdaud030 LIKE apda_t.apdaud030, #自定義欄位(日期時間)030
          apda104   LIKE apda_t.apda104, #原幣借方金額合計
          apda105   LIKE apda_t.apda105, #原幣貸方金額合計
          apda114   LIKE apda_t.apda114, #本幣借方金額合計
          apda115   LIKE apda_t.apda115, #本幣貸方金額合計
          apda124   LIKE apda_t.apda124, #本位幣二借方金額合計
          apda125   LIKE apda_t.apda125, #本位幣二貸方金額合計
          apda134   LIKE apda_t.apda134, #本位幣三借方金額合計
          apda135   LIKE apda_t.apda135, #本位幣三貸方金額合計
          apda022   LIKE apda_t.apda022, #經營方式
          apda023   LIKE apda_t.apda023  #請款單號
              END RECORD
   #161104-00024#1-add(e)
   DEFINE l_sql                   STRING
   DEFINE r_success               LIKE type_t.num5
   DEFINE l_cnt                   LIKE type_t.num5
   #DEFINE l_glaa                  RECORD LIKE glaa_t.* #161104-00024#1 mark
   #161104-00024#1-add(s)
   DEFINE l_glaa  RECORD  #帳套資料檔
          glaaent   LIKE glaa_t.glaaent, #企業編號
          glaaownid LIKE glaa_t.glaaownid, #資料所有者
          glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
          glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
          glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
          glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
          glaamodid LIKE glaa_t.glaamodid, #資料修改者
          glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
          glaastus  LIKE glaa_t.glaastus, #狀態碼
          glaald    LIKE glaa_t.glaald, #帳套編號
          glaacomp  LIKE glaa_t.glaacomp, #歸屬法人
          glaa001   LIKE glaa_t.glaa001, #使用幣別
          glaa002   LIKE glaa_t.glaa002, #匯率參照表號
          glaa003   LIKE glaa_t.glaa003, #會計週期參照表號
          glaa004   LIKE glaa_t.glaa004, #會計科目參照表號
          glaa005   LIKE glaa_t.glaa005, #現金變動參照表號
          glaa006   LIKE glaa_t.glaa006, #月結方式
          glaa007   LIKE glaa_t.glaa007, #年結方式
          glaa008   LIKE glaa_t.glaa008, #平行記帳否
          glaa009   LIKE glaa_t.glaa009, #傳票登入方式
          glaa010   LIKE glaa_t.glaa010, #現行年度
          glaa011   LIKE glaa_t.glaa011, #現行期別
          glaa012   LIKE glaa_t.glaa012, #最後過帳日期
          glaa013   LIKE glaa_t.glaa013, #關帳日期
          glaa014   LIKE glaa_t.glaa014, #主帳套
          glaa015   LIKE glaa_t.glaa015, #啟用本位幣二
          glaa016   LIKE glaa_t.glaa016, #本位幣二
          glaa017   LIKE glaa_t.glaa017, #本位幣二換算基準
          glaa018   LIKE glaa_t.glaa018, #本位幣二匯率採用
          glaa019   LIKE glaa_t.glaa019, #啟用本位幣三
          glaa020   LIKE glaa_t.glaa020, #本位幣三
          glaa021   LIKE glaa_t.glaa021, #本位幣三換算基準
          glaa022   LIKE glaa_t.glaa022, #本位幣三匯率採用
          glaa023   LIKE glaa_t.glaa023, #次帳套帳務產生時機
          glaa024   LIKE glaa_t.glaa024, #單據別參照表號
          glaa025   LIKE glaa_t.glaa025, #本位幣一匯率採用
          glaa026   LIKE glaa_t.glaa026, #幣別參照表號
          glaa100   LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
          glaa101   LIKE glaa_t.glaa101, #傳票總號輸入時機
          glaa102   LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
          glaa103   LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
          glaa111   LIKE glaa_t.glaa111, #應計調整單別
          glaa112   LIKE glaa_t.glaa112, #期末結轉單別
          glaa113   LIKE glaa_t.glaa113, #年底結轉單別
          glaa120   LIKE glaa_t.glaa120, #成本計算類型
          glaa121   LIKE glaa_t.glaa121, #子模組啟用分錄底稿
          glaa122   LIKE glaa_t.glaa122, #總帳可維護資金異動明細
          glaa027   LIKE glaa_t.glaa027, #單據據點編號
          glaa130   LIKE glaa_t.glaa130, #合併帳套否
          glaa131   LIKE glaa_t.glaa131, #分層合併
          glaa132   LIKE glaa_t.glaa132, #平均匯率計算方式
          glaa133   LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
          glaa134   LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
          glaa135   LIKE glaa_t.glaa135, #現流表間接法群組參照表號
          glaa136   LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
          glaa137   LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
          glaa138   LIKE glaa_t.glaa138, #合併報表編制期別
          glaa139   LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
          glaa140   LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
          glaa123   LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
          glaa124   LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
          glaa028   LIKE glaa_t.glaa028  #匯率來源
              END RECORD
   #161104-00024#1-add(e)
   DEFINE l_success               LIKE type_t.num5
   DEFINE l_rate                  LIKE apce_t.apce101
   DEFINE ls_js                   STRING
   DEFINE lc_param                RECORD
            apca004               LIKE apca_t.apca004
                   END RECORD
   
   LET r_success = TRUE
   
   #SELECT * INTO l_apda.* FROM apda_t WHERE apdaent = g_enterprise AND apdald = p_apdald AND apdadocno = p_apdadocno #161208-00026#1 mark
   #161208-00026#1-add(s)
   SELECT apdaent,apdacomp,apdald,apdadocno,apdadocdt,
          apdasite,apda001,apda002,apda003,apda004,
          apda005,apda006,apda007,apda008,apda009,
          apda010,apda011,apda012,apda013,apda014,
          apda015,apda016,apda017,apda018,apda019,
          apda020,apda021,apda113,apda123,apda133,
          apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,
          apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid,
          apdapstdt,apdastus,apdaud001,apdaud002,apdaud003,
          apdaud004,apdaud005,apdaud006,apdaud007,apdaud008,
          apdaud009,apdaud010,apdaud011,apdaud012,apdaud013,
          apdaud014,apdaud015,apdaud016,apdaud017,apdaud018,
          apdaud019,apdaud020,apdaud021,apdaud022,apdaud023,
          apdaud024,apdaud025,apdaud026,apdaud027,apdaud028,
          apdaud029,apdaud030,apda104,apda105,apda114,
          apda115,apda124,apda125,apda134,apda135,
          apda022,apda023 
     INTO l_apda.* 
     FROM apda_t
    WHERE apdaent = g_enterprise 
      AND apdald = p_apdald 
      AND apdadocno = p_apdadocno
   #161208-00026#1-add(e)
   #LET l_sql = "SELECT apeb_t.* FROM apea_t,apeb_t ", #161208-00026#1 mark
   #161208-00026#1-add(s)
   LET l_sql = "SELECT apebent,apebcomp,apebsite,apebld,apeborga,
                       apebdocno,apebseq,apeb001,apeb002,apeb003,
                       apeb004,apeb005,apeb006,apeb007,apeb008,
                       apeb010,apeb013,apeb015,apeb016,apeb024,
                       apeb025,apeb028,apeb031,apeb100,apeb101,
                       apeb109,apeb119,apebud001,apebud002,apebud003,
                       apebud004,apebud005,apebud006,apebud007,apebud008,
                       apebud009,apebud010,apebud011,apebud012,apebud013,
                       apebud014,apebud015,apebud016,apebud017,apebud018,
                       apebud019,apebud020,apebud021,apebud022,apebud023,
                       apebud024,apebud025,apebud026,apebud027,apebud028,
                       apebud029,apebud030,apeb011,apeb012,apeb108,
                       apeb118,apeb023
                  FROM apea_t,apeb_t ",
   #161208-00026#1-add(e)
               " WHERE apebent = ",g_enterprise,
               "   AND apeaent = apebent ",
               "   AND apeadocno = apebdocno "
   
   IF g_input.type = '1' THEN    #依請款單號產生 
      LET l_sql = l_sql," AND apebdocno = '",p_apebdocno,"'"
   END IF
   
   IF g_input.type = '2' THEN    #依付款到期日＋付款對象合併產生 
      LET l_sql = l_sql," AND apeb031 = '",p_apeb031,"'",
                        " AND apea005 = '",p_apea005,"'"
   END IF
   
   IF g_input.type = '3' THEN    #依付款對象產生 
      LET l_sql = l_sql," AND apea005 = '",p_apea005,"'"
   END IF
   LET l_sql=l_sql," AND apebdocno||apebseq IN (SELECT apebdocno||apebseq FROM aapp440_tmp WHERE sel = 'Y')"
   PREPARE aapp440_apce_pre FROM l_sql
   DECLARE aapp440_apce_cs CURSOR FOR aapp440_apce_pre
   
   INITIALIZE l_apce.* TO NULL
   LET l_apce.apceent   = g_enterprise
   LET l_apce.apcecomp  = l_apda.apdacomp
   LET l_apce.apcelegl  = ''
   LET l_apce.apcesite  = l_apda.apdasite 
   LET l_apce.apceld    = l_apda.apdald
   LET l_apce.apcedocno = p_apdadocno
   LET l_apce.apce001   = 'aapt420'	 
   LET l_apce.apce104   = 0
   LET l_apce.apce114   = 0
   LET l_apce.apce124   = 0
   LET l_apce.apce134   = 0
   
   #SELECT * INTO l_glaa.* FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_apdald  #161208-00026#1 mark
   #161208-00026#1-add(s)
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,
          glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,
          glaa005,glaa006,glaa007,glaa008,glaa009,
          glaa010,glaa011,glaa012,glaa013,glaa014,
          glaa015,glaa016,glaa017,glaa018,glaa019,
          glaa020,glaa021,glaa022,glaa023,glaa024,
          glaa025,glaa026,glaa100,glaa101,glaa102,
          glaa103,glaa111,glaa112,glaa113,glaa120,
          glaa121,glaa122,glaa027,glaa130,glaa131,
          glaa132,glaa133,glaa134,glaa135,glaa136,
          glaa137,glaa138,glaa139,glaa140,glaa123,
          glaa124,glaa028 
     INTO l_glaa.* 
     FROM glaa_t 
    WHERE glaaent=g_enterprise 
      AND glaald=p_apdald
   #161208-00026#1-add(e)
   
   #FOREACH aapp440_apce_cs INTO l_apeb.* #161208-00026#1 mark
   #161208-00026#1-add(s)
   FOREACH aapp440_apce_cs INTO l_apeb.apebent,l_apeb.apebcomp,l_apeb.apebsite,l_apeb.apebld,l_apeb.apeborga, 
                                l_apeb.apebdocno,l_apeb.apebseq,l_apeb.apeb001,l_apeb.apeb002,l_apeb.apeb003, 
                                l_apeb.apeb004,l_apeb.apeb005,l_apeb.apeb006,l_apeb.apeb007,l_apeb.apeb008, 
                                l_apeb.apeb010,l_apeb.apeb013,l_apeb.apeb015,l_apeb.apeb016,l_apeb.apeb024,
                                l_apeb.apeb025,l_apeb.apeb028,l_apeb.apeb031,l_apeb.apeb100,l_apeb.apeb101,
                                l_apeb.apeb109,l_apeb.apeb119,l_apeb.apebud001,l_apeb.apebud002,l_apeb.apebud003, 
                                l_apeb.apebud004,l_apeb.apebud005,l_apeb.apebud006,l_apeb.apebud007,l_apeb.apebud008, 
                                l_apeb.apebud009,l_apeb.apebud010,l_apeb.apebud011,l_apeb.apebud012,l_apeb.apebud013, 
                                l_apeb.apebud014,l_apeb.apebud015,l_apeb.apebud016,l_apeb.apebud017,l_apeb.apebud018, 
                                l_apeb.apebud019,l_apeb.apebud020,l_apeb.apebud021,l_apeb.apebud022,l_apeb.apebud023, 
                                l_apeb.apebud024,l_apeb.apebud025,l_apeb.apebud026,l_apeb.apebud027,l_apeb.apebud028, 
                                l_apeb.apebud029,l_apeb.apebud030,l_apeb.apeb011,l_apeb.apeb012,l_apeb.apeb108,
                                l_apeb.apeb118,l_apeb.apeb023
   #161208-00026#1-add(e)           
      LET l_apce.apceorga  = l_apeb.apeborga
      SELECT MAX(apceseq)+1 INTO l_apce.apceseq
        FROM apce_t
       WHERE apceent = g_enterprise
         AND apceld = l_apce.apceld
         AND apcedocno = l_apce.apcedocno
      IF cl_null(l_apce.apceseq) THEN
         LET l_apce.apceseq = 1
      END IF
      
      LET l_apce.apce003 = l_apeb.apeb003
      LET l_apce.apce004 = l_apeb.apeb004
      LET l_apce.apce005 = l_apeb.apeb005
      LET l_apce.apce016 = l_apeb.apeb016
      
      #業務人員/業務部門
      SELECT apca014,apca015 INTO l_apce.apce017,l_apce.apce018
        FROM apca_t
       WHERE apcaent = g_enterprise
         AND apcald = l_apce.apceld
         AND apcadocno = l_apce.apce003
         
      #應付款日/#付款(票)到期日
      SELECT apcc003,apcc004 INTO l_apce.apce031,l_apce.apce032
        FROM apcc_t
       WHERE apccent = g_enterprise
         AND apccdocno = l_apce.apce003
         AND apccseq = l_apce.apce004
         AND apcc001 = l_apce.apce005         

      LET l_apce.apce038 = l_apeb.apeb013	
      LET l_apce.apce047 = l_apeb.apeb007	
      LET l_apce.apce048 = l_apeb.apeb008	
      LET l_apce.apce049 = l_apeb.apebdocno
      LET l_apce.apce050 = l_apeb.apebseq
      LET l_apce.apce100 = l_apeb.apeb100	
      LET l_apce.apce101 = l_apeb.apeb101	
      IF l_apeb.apeb108 < 0 THEN
         LET l_apce.apce002   = '41'  
         LET l_apce.apce109 = l_apeb.apeb108 * -1
         LET l_apce.apce119 = l_apeb.apeb118 * -1
      ELSE
         LET l_apce.apce002   = '40'  
         LET l_apce.apce109 = l_apeb.apeb108
         LET l_apce.apce119 = l_apeb.apeb118
      END IF
      
      #借贷别apeb015
      LET l_apce.apce015 = s_fin_get_scc_value('8506',l_apce.apce002,'1')
      
      #抓取本位币二三汇率
      LET lc_param.apca004 = l_apda.apda005
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(l_apda.apdacomp,l_apda.apdald,l_apda.apdadocdt,l_apce.apce100,ls_js)
           RETURNING l_rate,l_apce.apce121,l_apce.apce131
      #本位币二
      IF l_glaa.glaa015='Y' THEN
         LET l_apce.apce120 = l_glaa.glaa016
         IF l_glaa.glaa017='1' THEN
            LET l_apce.apce129 = l_apce.apce109 * l_apce.apce121
         ELSE
            LET l_apce.apce129 = l_apce.apce119 * l_apce.apce121
         END IF
         CALL s_curr_round_ld('1',l_apce.apceld,l_apce.apce120,l_apce.apce129,2) 
         RETURNING l_success,g_errno,l_apce.apce129
      ELSE
         LET l_apce.apce121 = 0
         LET l_apce.apce129 = 0
      END IF
      #本位币三
      IF l_glaa.glaa019='Y' THEN
         LET l_apce.apce130 = l_glaa.glaa020
         IF l_glaa.glaa020='1' THEN
            LET l_apce.apce139 = l_apce.apce109 * l_apce.apce131
         ELSE
            LET l_apce.apce139 = l_apce.apce119 * l_apce.apce131
         END IF
         CALL s_curr_round_ld('1',l_apce.apceld,l_apce.apce130,l_apce.apce139,2) 
         RETURNING l_success,g_errno,l_apce.apce139
      ELSE
         LET l_apce.apce131 = 0
         LET l_apce.apce139 = 0
      END IF
      
      #INSERT INTO apce_t VALUES(l_apce.*) #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO apce_t (apceent,apcecomp,apcelegl,apcesite,apceld,
                          apceorga,apcedocno,apceseq,
                          apce001,apce002,apce003,apce004,apce005,
                          apce006,apce007,apce008,apce009,apce010,
                          apce011,apce012,apce013,apce014,apce015,
                          apce016,apce017,apce018,apce019,apce020,
                          apce021,apce022,apce023,apce024,apce025,
                          apce026,apce027,apce028,apce029,apce030,
                          apce031,apce032,apce033,apce034,apce035,
                          apce036,apce037,apce038,apce039,apce040,
                          apce041,apce042,apce043,apce044,apce045,
                          apce046,apce047,apce048,apce049,apce050,
                          apce051,apce052,apce053,apce054,apce055,
                          apce056,apce057,apce058,apce059,apce060,
                          apce100,apce101,apce104,apce109,apce114,
                          apce119,apce120,apce124,apce121,apce129,
                          apce130,apce131,apce134,apce139,
                          apceud001,apceud002,apceud003,apceud004,apceud005,
                          apceud006,apceud007,apceud008,apceud009,apceud010,
                          apceud011,apceud012,apceud013,apceud014,apceud015,
                          apceud016,apceud017,apceud018,apceud019,apceud020,
                          apceud021,apceud022,apceud023,apceud024,apceud025,
                          apceud026,apceud027,apceud028,apceud029,apceud030,
                          apce103,apce113,apce123,apce133,apce061
                         )
      VALUES (l_apce.apceent,l_apce.apcecomp,l_apce.apcelegl,l_apce.apcesite,l_apce.apceld,
              l_apce.apceorga,l_apce.apcedocno,l_apce.apceseq,
              l_apce.apce001,l_apce.apce002,l_apce.apce003,l_apce.apce004,l_apce.apce005,
              l_apce.apce006,l_apce.apce007,l_apce.apce008,l_apce.apce009,l_apce.apce010,
              l_apce.apce011,l_apce.apce012,l_apce.apce013,l_apce.apce014,l_apce.apce015,
              l_apce.apce016,l_apce.apce017,l_apce.apce018,l_apce.apce019,l_apce.apce020,
              l_apce.apce021,l_apce.apce022,l_apce.apce023,l_apce.apce024,l_apce.apce025,
              l_apce.apce026,l_apce.apce027,l_apce.apce028,l_apce.apce029,l_apce.apce030,
              l_apce.apce031,l_apce.apce032,l_apce.apce033,l_apce.apce034,l_apce.apce035,
              l_apce.apce036,l_apce.apce037,l_apce.apce038,l_apce.apce039,l_apce.apce040,
              l_apce.apce041,l_apce.apce042,l_apce.apce043,l_apce.apce044,l_apce.apce045,
              l_apce.apce046,l_apce.apce047,l_apce.apce048,l_apce.apce049,l_apce.apce050,
              l_apce.apce051,l_apce.apce052,l_apce.apce053,l_apce.apce054,l_apce.apce055,
              l_apce.apce056,l_apce.apce057,l_apce.apce058,l_apce.apce059,l_apce.apce060,
              l_apce.apce100,l_apce.apce101,l_apce.apce104,l_apce.apce109,l_apce.apce114,
              l_apce.apce119,l_apce.apce120,l_apce.apce124,l_apce.apce121,l_apce.apce129,
              l_apce.apce130,l_apce.apce131,l_apce.apce134,l_apce.apce139,
              l_apce.apceud001,l_apce.apceud002,l_apce.apceud003,l_apce.apceud004,l_apce.apceud005,
              l_apce.apceud006,l_apce.apceud007,l_apce.apceud008,l_apce.apceud009,l_apce.apceud010,
              l_apce.apceud011,l_apce.apceud012,l_apce.apceud013,l_apce.apceud014,l_apce.apceud015,
              l_apce.apceud016,l_apce.apceud017,l_apce.apceud018,l_apce.apceud019,l_apce.apceud020,
              l_apce.apceud021,l_apce.apceud022,l_apce.apceud023,l_apce.apceud024,l_apce.apceud025,
              l_apce.apceud026,l_apce.apceud027,l_apce.apceud028,l_apce.apceud029,l_apce.apceud030,
              l_apce.apce103,l_apce.apce113,l_apce.apce123,l_apce.apce133,l_apce.apce061
             )
      #161108-00017#1 add end---
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'insert into apce_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF      
   END FOREACH 
   
   #账款单身是否有资料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM apce_t 
    WHERE apceent=g_enterprise AND apceld=p_apdald AND apcedocno=p_apdadocno
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00422'
      LET g_errparam.extend = p_apdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
# 插入付款单身
PRIVATE FUNCTION aapp440_ins_apde(p_apdadocno,p_apdald)
   DEFINE p_apdadocno             LIKE apda_t.apdadocno
   DEFINE p_apdald                LIKE apda_t.apdald
   DEFINE p_apebdocno             LIKE apeb_t.apebdocno
   DEFINE p_apeb031               LIKE apeb_t.apeb031
   DEFINE p_apea005               LIKE apea_t.apea005
   #DEFINE l_apda                  RECORD LIKE apda_t.* #161104-00024#1 mark
   #DEFINE l_apde                  RECORD LIKE apde_t.* #161104-00024#1 mark
   #DEFINE l_nmck                  RECORD LIKE nmck_t.* #161104-00024#1 mark
   #DEFINE l_nmcl                  RECORD LIKE nmcl_t.* #161104-00024#1 mark
   #161104-00024#1 mark
   #161104-00024#1-add(s)
   DEFINE l_apda  RECORD  #付款核銷單單頭檔
          apdaent   LIKE apda_t.apdaent, #企業編號
          apdacomp  LIKE apda_t.apdacomp, #法人
          apdald    LIKE apda_t.apdald, #帳套
          apdadocno LIKE apda_t.apdadocno, #單號
          apdadocdt LIKE apda_t.apdadocdt, #單據日期
          apdasite  LIKE apda_t.apdasite, #帳務組織
          apda001   LIKE apda_t.apda001, #帳款單性質
          apda002   LIKE apda_t.apda002, #NO USE
          apda003   LIKE apda_t.apda003, #帳務人員
          apda004   LIKE apda_t.apda004, #帳款核銷對象
          apda005   LIKE apda_t.apda005, #付款對象
          apda006   LIKE apda_t.apda006, #一次性交易識別碼
          apda007   LIKE apda_t.apda007, #產生方式
          apda008   LIKE apda_t.apda008, #來源參考單號
          apda009   LIKE apda_t.apda009, #沖帳批序號
          apda010   LIKE apda_t.apda010, #集團代付付單號
          apda011   LIKE apda_t.apda011, #差異處理
          apda012   LIKE apda_t.apda012, #退款類型
          apda013   LIKE apda_t.apda013, #分錄底稿是否可重新產生
          apda014   LIKE apda_t.apda014, #拋轉傳票號碼
          apda015   LIKE apda_t.apda015, #作廢理由碼
          apda016   LIKE apda_t.apda016, #列印次數
          apda017   LIKE apda_t.apda017, #MEMO備註
          apda018   LIKE apda_t.apda018, #付款(攤銷)理由碼
          apda019   LIKE apda_t.apda019, #攤銷目的方式
          apda020   LIKE apda_t.apda020, #分攤金額方式
          apda021   LIKE apda_t.apda021, #目的成本要素
          apda113   LIKE apda_t.apda113, #應核銷本幣金額
          apda123   LIKE apda_t.apda123, #應核銷本幣二金額
          apda133   LIKE apda_t.apda133, #應核銷本幣三金額
          apdaownid LIKE apda_t.apdaownid, #資料所有者
          apdaowndp LIKE apda_t.apdaowndp, #資料所屬部門
          apdacrtid LIKE apda_t.apdacrtid, #資料建立者
          apdacrtdp LIKE apda_t.apdacrtdp, #資料建立部門
          apdacrtdt LIKE apda_t.apdacrtdt, #資料創建日
          apdamodid LIKE apda_t.apdamodid, #資料修改者
          apdamoddt LIKE apda_t.apdamoddt, #最近修改日
          apdacnfid LIKE apda_t.apdacnfid, #資料確認者
          apdacnfdt LIKE apda_t.apdacnfdt, #資料確認日
          apdapstid LIKE apda_t.apdapstid, #資料過帳者
          apdapstdt LIKE apda_t.apdapstdt, #資料過帳日
          apdastus  LIKE apda_t.apdastus, #狀態碼
          apdaud001 LIKE apda_t.apdaud001, #自定義欄位(文字)001
          apdaud002 LIKE apda_t.apdaud002, #自定義欄位(文字)002
          apdaud003 LIKE apda_t.apdaud003, #自定義欄位(文字)003
          apdaud004 LIKE apda_t.apdaud004, #自定義欄位(文字)004
          apdaud005 LIKE apda_t.apdaud005, #自定義欄位(文字)005
          apdaud006 LIKE apda_t.apdaud006, #自定義欄位(文字)006
          apdaud007 LIKE apda_t.apdaud007, #自定義欄位(文字)007
          apdaud008 LIKE apda_t.apdaud008, #自定義欄位(文字)008
          apdaud009 LIKE apda_t.apdaud009, #自定義欄位(文字)009
          apdaud010 LIKE apda_t.apdaud010, #自定義欄位(文字)010
          apdaud011 LIKE apda_t.apdaud011, #自定義欄位(數字)011
          apdaud012 LIKE apda_t.apdaud012, #自定義欄位(數字)012
          apdaud013 LIKE apda_t.apdaud013, #自定義欄位(數字)013
          apdaud014 LIKE apda_t.apdaud014, #自定義欄位(數字)014
          apdaud015 LIKE apda_t.apdaud015, #自定義欄位(數字)015
          apdaud016 LIKE apda_t.apdaud016, #自定義欄位(數字)016
          apdaud017 LIKE apda_t.apdaud017, #自定義欄位(數字)017
          apdaud018 LIKE apda_t.apdaud018, #自定義欄位(數字)018
          apdaud019 LIKE apda_t.apdaud019, #自定義欄位(數字)019
          apdaud020 LIKE apda_t.apdaud020, #自定義欄位(數字)020
          apdaud021 LIKE apda_t.apdaud021, #自定義欄位(日期時間)021
          apdaud022 LIKE apda_t.apdaud022, #自定義欄位(日期時間)022
          apdaud023 LIKE apda_t.apdaud023, #自定義欄位(日期時間)023
          apdaud024 LIKE apda_t.apdaud024, #自定義欄位(日期時間)024
          apdaud025 LIKE apda_t.apdaud025, #自定義欄位(日期時間)025
          apdaud026 LIKE apda_t.apdaud026, #自定義欄位(日期時間)026
          apdaud027 LIKE apda_t.apdaud027, #自定義欄位(日期時間)027
          apdaud028 LIKE apda_t.apdaud028, #自定義欄位(日期時間)028
          apdaud029 LIKE apda_t.apdaud029, #自定義欄位(日期時間)029
          apdaud030 LIKE apda_t.apdaud030, #自定義欄位(日期時間)030
          apda104   LIKE apda_t.apda104, #原幣借方金額合計
          apda105   LIKE apda_t.apda105, #原幣貸方金額合計
          apda114   LIKE apda_t.apda114, #本幣借方金額合計
          apda115   LIKE apda_t.apda115, #本幣貸方金額合計
          apda124   LIKE apda_t.apda124, #本位幣二借方金額合計
          apda125   LIKE apda_t.apda125, #本位幣二貸方金額合計
          apda134   LIKE apda_t.apda134, #本位幣三借方金額合計
          apda135   LIKE apda_t.apda135, #本位幣三貸方金額合計
          apda022   LIKE apda_t.apda022, #經營方式
          apda023   LIKE apda_t.apda023  #請款單號
              END RECORD
   DEFINE l_apde  RECORD  #付款及差異處理明細檔
          apdeent   LIKE apde_t.apdeent, #企業編號
          apdecomp  LIKE apde_t.apdecomp, #法人
          apdeld    LIKE apde_t.apdeld, #帳套
          apdedocno LIKE apde_t.apdedocno, #沖銷單單號
          apdeseq   LIKE apde_t.apdeseq, #項次
          apdesite  LIKE apde_t.apdesite, #帳務中心
          apdeorga  LIKE apde_t.apdeorga, #帳務歸屬組織
          apde001   LIKE apde_t.apde001, #來源作業
          apde002   LIKE apde_t.apde002, #沖銷帳款類型
          apde003   LIKE apde_t.apde003, #已付款單號
          apde004   LIKE apde_t.apde004, #沖銷單項次
          apde006   LIKE apde_t.apde006, #款別編號
          apde008   LIKE apde_t.apde008, #帳戶/票券號碼
          apde009   LIKE apde_t.apde009, #已轉資料
          apde010   LIKE apde_t.apde010, #摘要說明
          apde011   LIKE apde_t.apde011, #銀行存提碼
          apde012   LIKE apde_t.apde012, #現金變動碼
          apde013   LIKE apde_t.apde013, #轉入客商碼
          apde014   LIKE apde_t.apde014, #轉入帳款單編號
          apde015   LIKE apde_t.apde015, #沖銷加減項
          apde016   LIKE apde_t.apde016, #沖銷會科
          apde017   LIKE apde_t.apde017, #業務人員
          apde018   LIKE apde_t.apde018, #業務部門
          apde019   LIKE apde_t.apde019, #責任中心
          apde020   LIKE apde_t.apde020, #產品類別
          apde021   LIKE apde_t.apde021, #票據類型
          apde022   LIKE apde_t.apde022, #專案編號
          apde023   LIKE apde_t.apde023, #WBS編號
          apde024   LIKE apde_t.apde024, #票據號碼
          apde028   LIKE apde_t.apde028, #產生方式
          apde029   LIKE apde_t.apde029, #傳票號碼
          apde030   LIKE apde_t.apde030, #傳票項次
          apde032   LIKE apde_t.apde032, #付款日
          apde035   LIKE apde_t.apde035, #區域
          apde036   LIKE apde_t.apde036, #客群
          apde038   LIKE apde_t.apde038, #對象
          apde039   LIKE apde_t.apde039, #受款銀行
          apde040   LIKE apde_t.apde040, #受款帳號
          apde041   LIKE apde_t.apde041, #受款人全名
          apde042   LIKE apde_t.apde042, #經營方式
          apde043   LIKE apde_t.apde043, #通路
          apde044   LIKE apde_t.apde044, #品牌
          apde045   LIKE apde_t.apde045, #摘要
          apde046   LIKE apde_t.apde046, #付款申請單
          apde047   LIKE apde_t.apde047, #付款申請單項次
          apde051   LIKE apde_t.apde051, #自由核算項一
          apde052   LIKE apde_t.apde052, #自由核算項二
          apde053   LIKE apde_t.apde053, #自由核算項三
          apde054   LIKE apde_t.apde054, #自由核算項四
          apde055   LIKE apde_t.apde055, #自由核算項五
          apde056   LIKE apde_t.apde056, #自由核算項六
          apde057   LIKE apde_t.apde057, #自由核算項七
          apde058   LIKE apde_t.apde058, #自由核算項八
          apde059   LIKE apde_t.apde059, #自由核算項九
          apde060   LIKE apde_t.apde060, #自由核算項十
          apde100   LIKE apde_t.apde100, #幣別
          apde101   LIKE apde_t.apde101, #匯率
          apde104   LIKE apde_t.apde104, #原幣應稅折抵稅額
          apde109   LIKE apde_t.apde109, #原幣沖帳金額
          apde119   LIKE apde_t.apde119, #本幣沖帳金額
          apde120   LIKE apde_t.apde120, #本位幣二幣別
          apde121   LIKE apde_t.apde121, #本位幣二匯率
          apde129   LIKE apde_t.apde129, #本位幣二沖帳金額
          apde130   LIKE apde_t.apde130, #本位幣三幣別
          apde131   LIKE apde_t.apde131, #本位幣三匯率
          apde139   LIKE apde_t.apde139, #本位幣三沖帳金額
          apdeud001 LIKE apde_t.apdeud001, #自定義欄位(文字)001
          apdeud002 LIKE apde_t.apdeud002, #自定義欄位(文字)002
          apdeud003 LIKE apde_t.apdeud003, #自定義欄位(文字)003
          apdeud004 LIKE apde_t.apdeud004, #自定義欄位(文字)004
          apdeud005 LIKE apde_t.apdeud005, #自定義欄位(文字)005
          apdeud006 LIKE apde_t.apdeud006, #自定義欄位(文字)006
          apdeud007 LIKE apde_t.apdeud007, #自定義欄位(文字)007
          apdeud008 LIKE apde_t.apdeud008, #自定義欄位(文字)008
          apdeud009 LIKE apde_t.apdeud009, #自定義欄位(文字)009
          apdeud010 LIKE apde_t.apdeud010, #自定義欄位(文字)010
          apdeud011 LIKE apde_t.apdeud011, #自定義欄位(數字)011
          apdeud012 LIKE apde_t.apdeud012, #自定義欄位(數字)012
          apdeud013 LIKE apde_t.apdeud013, #自定義欄位(數字)013
          apdeud014 LIKE apde_t.apdeud014, #自定義欄位(數字)014
          apdeud015 LIKE apde_t.apdeud015, #自定義欄位(數字)015
          apdeud016 LIKE apde_t.apdeud016, #自定義欄位(數字)016
          apdeud017 LIKE apde_t.apdeud017, #自定義欄位(數字)017
          apdeud018 LIKE apde_t.apdeud018, #自定義欄位(數字)018
          apdeud019 LIKE apde_t.apdeud019, #自定義欄位(數字)019
          apdeud020 LIKE apde_t.apdeud020, #自定義欄位(數字)020
          apdeud021 LIKE apde_t.apdeud021, #自定義欄位(日期時間)021
          apdeud022 LIKE apde_t.apdeud022, #自定義欄位(日期時間)022
          apdeud023 LIKE apde_t.apdeud023, #自定義欄位(日期時間)023
          apdeud024 LIKE apde_t.apdeud024, #自定義欄位(日期時間)024
          apdeud025 LIKE apde_t.apdeud025, #自定義欄位(日期時間)025
          apdeud026 LIKE apde_t.apdeud026, #自定義欄位(日期時間)026
          apdeud027 LIKE apde_t.apdeud027, #自定義欄位(日期時間)027
          apdeud028 LIKE apde_t.apdeud028, #自定義欄位(日期時間)028
          apdeud029 LIKE apde_t.apdeud029, #自定義欄位(日期時間)029
          apdeud030 LIKE apde_t.apdeud030, #自定義欄位(日期時間)030
          apde061   LIKE apde_t.apde061    #應付來源
              END RECORD
   DEFINE l_nmck  RECORD  #應付匯款主檔
          nmckent   LIKE nmck_t.nmckent, #企業編號
          nmckcomp  LIKE nmck_t.nmckcomp, #法人
          nmckdocno LIKE nmck_t.nmckdocno, #單據號碼
          nmckdocdt LIKE nmck_t.nmckdocdt, #單據日期
          nmcksite  LIKE nmck_t.nmcksite, #資金中心
          nmck001   LIKE nmck_t.nmck001, #來源類型
          nmck002   LIKE nmck_t.nmck002, #款別編號
          nmck003   LIKE nmck_t.nmck003, #帳務人員
          nmck004   LIKE nmck_t.nmck004, #交易帳戶編碼
          nmck005   LIKE nmck_t.nmck005, #付款對象
          nmck006   LIKE nmck_t.nmck006, #一次性交易對象識別碼
          nmck007   LIKE nmck_t.nmck007, #產生方式
          nmck008   LIKE nmck_t.nmck008, #手續費負擔者
          nmck009   LIKE nmck_t.nmck009, #存提碼
          nmck010   LIKE nmck_t.nmck010, #現金變動碼
          nmck011   LIKE nmck_t.nmck011, #到期日
          nmck012   LIKE nmck_t.nmck012, #實際匯款日
          nmck013   LIKE nmck_t.nmck013, #匯入銀行
          nmck014   LIKE nmck_t.nmck014, #匯入帳號
          nmck015   LIKE nmck_t.nmck015, #匯入戶名
          nmck016   LIKE nmck_t.nmck016, #通知受匯人 EMAIL
          nmck017   LIKE nmck_t.nmck017, #iban no
          nmck018   LIKE nmck_t.nmck018, #swift code
          nmck019   LIKE nmck_t.nmck019, #帳務單號
          nmck020   LIKE nmck_t.nmck020, #次帳一帳務單號
          nmck021   LIKE nmck_t.nmck021, #次帳二帳務單號
          nmck022   LIKE nmck_t.nmck022, #經辦人
          nmck023   LIKE nmck_t.nmck023, #款別分類
          nmck024   LIKE nmck_t.nmck024, #支票簿號
          nmck025   LIKE nmck_t.nmck025, #票據號碼
          nmck026   LIKE nmck_t.nmck026, #票況
          nmck027   LIKE nmck_t.nmck027, #禁止背書轉讓
          nmck028   LIKE nmck_t.nmck028, #票據保證金百分比
          nmck029   LIKE nmck_t.nmck029, #票據保證金金額
          nmck030   LIKE nmck_t.nmck030, #計息利率條件
          nmck031   LIKE nmck_t.nmck031, #計息利率
          nmck032   LIKE nmck_t.nmck032, #承兌銀行編號
          nmck033   LIKE nmck_t.nmck033, #對方會科
          nmck034   LIKE nmck_t.nmck034, #寄領方式
          nmck035   LIKE nmck_t.nmck035, #寄領日期
          nmck036   LIKE nmck_t.nmck036, #重立帳單號
          nmck100   LIKE nmck_t.nmck100, #幣別
          nmck101   LIKE nmck_t.nmck101, #匯率
          nmck103   LIKE nmck_t.nmck103, #原幣金額
          nmck113   LIKE nmck_t.nmck113, #本幣金額
          nmck114   LIKE nmck_t.nmck114, #重評後本幣金額
          nmck121   LIKE nmck_t.nmck121, #本位幣二匯率
          nmck124   LIKE nmck_t.nmck124, #重評後本位幣二金額
          nmck123   LIKE nmck_t.nmck123, #本位幣二金額
          nmck131   LIKE nmck_t.nmck131, #本位幣三匯率
          nmck133   LIKE nmck_t.nmck133, #本位幣三金額
          nmck134   LIKE nmck_t.nmck134, #重評後本位幣三金額
          nmckstus  LIKE nmck_t.nmckstus, #狀態碼
          nmckownid LIKE nmck_t.nmckownid, #資料所有者
          nmckowndp LIKE nmck_t.nmckowndp, #資料所屬部門
          nmckcrtid LIKE nmck_t.nmckcrtid, #資料建立者
          nmckcrtdp LIKE nmck_t.nmckcrtdp, #資料建立部門
          nmckcrtdt LIKE nmck_t.nmckcrtdt, #資料創建日
          nmckmodid LIKE nmck_t.nmckmodid, #資料修改者
          nmckmoddt LIKE nmck_t.nmckmoddt, #最近修改日
          nmckcnfid LIKE nmck_t.nmckcnfid, #資料確認者
          nmckcnfdt LIKE nmck_t.nmckcnfdt, #資料確認日
          nmckud001 LIKE nmck_t.nmckud001, #自定義欄位(文字)001
          nmckud002 LIKE nmck_t.nmckud002, #自定義欄位(文字)002
          nmckud003 LIKE nmck_t.nmckud003, #自定義欄位(文字)003
          nmckud004 LIKE nmck_t.nmckud004, #自定義欄位(文字)004
          nmckud005 LIKE nmck_t.nmckud005, #自定義欄位(文字)005
          nmckud006 LIKE nmck_t.nmckud006, #自定義欄位(文字)006
          nmckud007 LIKE nmck_t.nmckud007, #自定義欄位(文字)007
          nmckud008 LIKE nmck_t.nmckud008, #自定義欄位(文字)008
          nmckud009 LIKE nmck_t.nmckud009, #自定義欄位(文字)009
          nmckud010 LIKE nmck_t.nmckud010, #自定義欄位(文字)010
          nmckud011 LIKE nmck_t.nmckud011, #自定義欄位(數字)011
          nmckud012 LIKE nmck_t.nmckud012, #自定義欄位(數字)012
          nmckud013 LIKE nmck_t.nmckud013, #自定義欄位(數字)013
          nmckud014 LIKE nmck_t.nmckud014, #自定義欄位(數字)014
          nmckud015 LIKE nmck_t.nmckud015, #自定義欄位(數字)015
          nmckud016 LIKE nmck_t.nmckud016, #自定義欄位(數字)016
          nmckud017 LIKE nmck_t.nmckud017, #自定義欄位(數字)017
          nmckud018 LIKE nmck_t.nmckud018, #自定義欄位(數字)018
          nmckud019 LIKE nmck_t.nmckud019, #自定義欄位(數字)019
          nmckud020 LIKE nmck_t.nmckud020, #自定義欄位(數字)020
          nmckud021 LIKE nmck_t.nmckud021, #自定義欄位(日期時間)021
          nmckud022 LIKE nmck_t.nmckud022, #自定義欄位(日期時間)022
          nmckud023 LIKE nmck_t.nmckud023, #自定義欄位(日期時間)023
          nmckud024 LIKE nmck_t.nmckud024, #自定義欄位(日期時間)024
          nmckud025 LIKE nmck_t.nmckud025, #自定義欄位(日期時間)025
          nmckud026 LIKE nmck_t.nmckud026, #自定義欄位(日期時間)026
          nmckud027 LIKE nmck_t.nmckud027, #自定義欄位(日期時間)027
          nmckud028 LIKE nmck_t.nmckud028, #自定義欄位(日期時間)028
          nmckud029 LIKE nmck_t.nmckud029, #自定義欄位(日期時間)029
          nmckud030 LIKE nmck_t.nmckud030, #自定義欄位(日期時間)030
          nmck037   LIKE nmck_t.nmck037, #本行他行
          nmck038   LIKE nmck_t.nmck038, #同城異城
          nmck039   LIKE nmck_t.nmck039, #對公對私
          nmck040   LIKE nmck_t.nmck040, #省份
          nmck041   LIKE nmck_t.nmck041, #城市
          nmck042   LIKE nmck_t.nmck042, #附言
          nmck043   LIKE nmck_t.nmck043, #暫付否
          nmck044   LIKE nmck_t.nmck044, #保證金帳戶
          nmck045   LIKE nmck_t.nmck045, #保證金來源帳戶
          nmck046   LIKE nmck_t.nmck046, #保證金幣別
          nmck047   LIKE nmck_t.nmck047, #存提碼（入）
          nmck048   LIKE nmck_t.nmck048, #存提碼（出）
          nmck049   LIKE nmck_t.nmck049, #現金變動碼（入）
          nmck050   LIKE nmck_t.nmck050, #現金變動碼（出）
          nmck051   LIKE nmck_t.nmck051  #保證金劃撥單號
              END RECORD
   DEFINE l_nmcl  RECORD  #應付匯款來源明細檔
          nmclent   LIKE nmcl_t.nmclent, #企業編號
          nmclcomp  LIKE nmcl_t.nmclcomp, #法人
          nmcldocno LIKE nmcl_t.nmcldocno, #單據號碼
          nmclseq   LIKE nmcl_t.nmclseq, #序號
          nmclorga  LIKE nmcl_t.nmclorga, #來源組織
          nmcl001   LIKE nmcl_t.nmcl001, #請款單號
          nmcl002   LIKE nmcl_t.nmcl002, #項次
          nmcl003   LIKE nmcl_t.nmcl003, #對方會科
          nmcl103   LIKE nmcl_t.nmcl103, #請款原幣金額
          nmcl113   LIKE nmcl_t.nmcl113, #請款本幣金額
          nmcl121   LIKE nmcl_t.nmcl121, #本位幣二匯率
          nmcl123   LIKE nmcl_t.nmcl123, #本位幣二金額
          nmcl131   LIKE nmcl_t.nmcl131, #本位幣三匯率
          nmcl133   LIKE nmcl_t.nmcl133, #本位幣三金額
          nmclud001 LIKE nmcl_t.nmclud001, #自定義欄位(文字)001
          nmclud002 LIKE nmcl_t.nmclud002, #自定義欄位(文字)002
          nmclud003 LIKE nmcl_t.nmclud003, #自定義欄位(文字)003
          nmclud004 LIKE nmcl_t.nmclud004, #自定義欄位(文字)004
          nmclud005 LIKE nmcl_t.nmclud005, #自定義欄位(文字)005
          nmclud006 LIKE nmcl_t.nmclud006, #自定義欄位(文字)006
          nmclud007 LIKE nmcl_t.nmclud007, #自定義欄位(文字)007
          nmclud008 LIKE nmcl_t.nmclud008, #自定義欄位(文字)008
          nmclud009 LIKE nmcl_t.nmclud009, #自定義欄位(文字)009
          nmclud010 LIKE nmcl_t.nmclud010, #自定義欄位(文字)010
          nmclud011 LIKE nmcl_t.nmclud011, #自定義欄位(數字)011
          nmclud012 LIKE nmcl_t.nmclud012, #自定義欄位(數字)012
          nmclud013 LIKE nmcl_t.nmclud013, #自定義欄位(數字)013
          nmclud014 LIKE nmcl_t.nmclud014, #自定義欄位(數字)014
          nmclud015 LIKE nmcl_t.nmclud015, #自定義欄位(數字)015
          nmclud016 LIKE nmcl_t.nmclud016, #自定義欄位(數字)016
          nmclud017 LIKE nmcl_t.nmclud017, #自定義欄位(數字)017
          nmclud018 LIKE nmcl_t.nmclud018, #自定義欄位(數字)018
          nmclud019 LIKE nmcl_t.nmclud019, #自定義欄位(數字)019
          nmclud020 LIKE nmcl_t.nmclud020, #自定義欄位(數字)020
          nmclud021 LIKE nmcl_t.nmclud021, #自定義欄位(日期時間)021
          nmclud022 LIKE nmcl_t.nmclud022, #自定義欄位(日期時間)022
          nmclud023 LIKE nmcl_t.nmclud023, #自定義欄位(日期時間)023
          nmclud024 LIKE nmcl_t.nmclud024, #自定義欄位(日期時間)024
          nmclud025 LIKE nmcl_t.nmclud025, #自定義欄位(日期時間)025
          nmclud026 LIKE nmcl_t.nmclud026, #自定義欄位(日期時間)026
          nmclud027 LIKE nmcl_t.nmclud027, #自定義欄位(日期時間)027
          nmclud028 LIKE nmcl_t.nmclud028, #自定義欄位(日期時間)028
          nmclud029 LIKE nmcl_t.nmclud029, #自定義欄位(日期時間)029
          nmclud030 LIKE nmcl_t.nmclud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#1-add(e)
   DEFINE l_apce050               LIKE apce_t.apce050
   DEFINE l_glaa015               LIKE glaa_t.glaa015
   DEFINE l_glaa016               LIKE glaa_t.glaa016
   DEFINE l_glaa019               LIKE glaa_t.glaa019
   DEFINE l_glaa020               LIKE glaa_t.glaa020
   DEFINE l_sql                   STRING
   DEFINE r_success               LIKE type_t.num5
   DEFINE l_cnt                   LIKE type_t.num5
   
   LET r_success = TRUE
   
   #SELECT * INTO l_apda.* FROM apda_t WHERE apdaent = g_enterprise AND apdald = p_apdald AND apdadocno = p_apdadocno #161208-00026#1 mark
   #161208-00026#1-add(s)
   SELECT apdaent,apdacomp,apdald,apdadocno,apdadocdt,
          apdasite,apda001,apda002,apda003,apda004,
          apda005,apda006,apda007,apda008,apda009,
          apda010,apda011,apda012,apda013,apda014,
          apda015,apda016,apda017,apda018,apda019,
          apda020,apda021,apda113,apda123,apda133,
          apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,
          apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid,
          apdapstdt,apdastus,apdaud001,apdaud002,apdaud003,
          apdaud004,apdaud005,apdaud006,apdaud007,apdaud008,
          apdaud009,apdaud010,apdaud011,apdaud012,apdaud013,
          apdaud014,apdaud015,apdaud016,apdaud017,apdaud018,
          apdaud019,apdaud020,apdaud021,apdaud022,apdaud023,
          apdaud024,apdaud025,apdaud026,apdaud027,apdaud028,
          apdaud029,apdaud030,apda104,apda105,apda114,
          apda115,apda124,apda125,apda134,apda135,
          apda022,apda023 
     INTO l_apda.* 
     FROM apda_t 
    WHERE apdaent = g_enterprise 
      AND apdald = p_apdald 
      AND apdadocno = p_apdadocno
   #161208-00026#1-add(e)
   SELECT glaa015,glaa016,glaa019,glaa020 INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
   FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_apdald
   INITIALIZE l_apde.* TO NULL
   LET l_apde.apdeent = g_enterprise         # 企業編號
   LET l_apde.apdecomp = l_apda.apdacomp	   #  法人
   LET l_apde.apdeld	= l_apda.apdald	      #  帳套
   LET l_apde.apdedocno = l_apda.apdadocno	#  沖銷單單號
   LET l_apde.apdesite = l_apda.apdasite	   #  帳務中心
   LET l_apde.apde001 = 'aapt420' 	         #  來源作業
   LET l_apde.apde002 = '10'	               #  沖銷帳款類型
   
   LET l_sql="SELECT DISTINCT nmcldocno,nmcl001 ",
             "  FROM apce_t,nmcl_t",
             " WHERE apceent=nmclent AND apce049=nmcl001 AND apce050=nmcl002 ",
             "   AND apceent=",g_enterprise," AND apceld='",p_apdald,"'",
             "   AND apcedocno='",p_apdadocno,"'",
             "   AND nmclcomp='",l_apda.apdacomp,"'",
             " ORDER BY nmcldocno,nmcl001"
   PREPARE aapp440_sel_pre FROM l_sql
   DECLARE aapp440_sel_cs CURSOR FOR aapp440_sel_pre
   
   FOREACH aapp440_sel_cs INTO l_nmcl.nmcldocno,l_nmcl.nmcl001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH aapp440_sel_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      #項次
      SELECT MAX(apdeseq)+1 INTO l_apde.apdeseq
        FROM apde_t
       WHERE apdeent = g_enterprise
         AND apdeld = l_apde.apdeld
         AND apdedocno = l_apde.apdedocno
      IF cl_null(l_apde.apdeseq) THEN
         LET l_apde.apdeseq = 1
      END IF
      #SELECT * INTO l_nmck.* FROM nmck_t #161208-00026#1 mark
      #161208-00026#1-add(s)
      SELECT nmckent,nmckcomp,nmckdocno,nmckdocdt,nmcksite,
             nmck001,nmck002,nmck003,nmck004,nmck005,
             nmck006,nmck007,nmck008,nmck009,nmck010,
             nmck011,nmck012,nmck013,nmck014,nmck015,
             nmck016,nmck017,nmck018,nmck019,nmck020,
             nmck021,nmck022,nmck023,nmck024,nmck025,
             nmck026,nmck027,nmck028,nmck029,nmck030,
             nmck031,nmck032,nmck033,nmck034,nmck035,
             nmck036,nmck100,nmck101,nmck103,nmck113,
             nmck114,nmck121,nmck124,nmck123,nmck131,
             nmck133,nmck134,nmckstus,nmckownid,nmckowndp,
             nmckcrtid,nmckcrtdp,nmckcrtdt,nmckmodid,nmckmoddt,
             nmckcnfid,nmckcnfdt,nmckud001,nmckud002,nmckud003,
             nmckud004,nmckud005,nmckud006,nmckud007,nmckud008,
             nmckud009,nmckud010,nmckud011,nmckud012,nmckud013,
             nmckud014,nmckud015,nmckud016,nmckud017,nmckud018,
             nmckud019,nmckud020,nmckud021,nmckud022,nmckud023,
             nmckud024,nmckud025,nmckud026,nmckud027,nmckud028,
             nmckud029,nmckud030,nmck037,nmck038,nmck039,
             nmck040,nmck041,nmck042,nmck043,nmck044,
             nmck045,nmck046,nmck047,nmck048,nmck049,
             nmck050,nmck051 
        INTO l_nmck.* FROM nmck_t 
      #161208-00026#1-add(e)
       WHERE nmckent=g_enterprise AND nmckcomp=l_apda.apdacomp AND nmckdocno=l_nmcl.nmcldocno
             
      LET l_apde.apde003 = l_nmck.nmckdocno	  #已付款單號
      LET l_apde.apde006 = l_nmck.nmck023	     #款別代碼
      LET l_apde.apde021 = l_nmck.nmck002      #票据类型
      #帳戶/票券號碼
      #款别类别为10现金或20银行电汇款
      IF l_apde.apde006 = '10' OR l_apde.apde006 = '20' THEN
         LET l_apde.apde008 = l_nmck.nmck004 #帳戶
         LET l_apde.apde024 = ''
         #沖銷會科
         #161108-00004#1---add---str--
         #當anmt460來源IV:發票請款單 且暫付否 為 Y 時, 直接抓取 anmt460 單身科目
         IF l_nmck.nmck001 = 'IV' AND l_nmck.nmck043 = 'Y' THEN
            SELECT nmcl003 INTO l_apde.apde016 
              FROM nmcl_t
             WHERE nmclent = g_enterprise
               AND nmclcomp = l_apda.apdacomp
               AND nmcldocno = l_apde.apde003
               AND nmclseq = 1
         ELSE 
         #161108-00004#1---add---end--
            SELECT DISTINCT glab005 INTO l_apde.apde016  #anmi121
             FROM glab_t
            WHERE glabent = g_enterprise
              AND glabld  = l_apde.apdeld
              AND glab001 = '40'
              AND glab002 = '40'
              AND glab003 = l_apde.apde008
         END IF   #161108-00004#1 add  
      END IF 
      #款别类别为30票据
      IF l_apde.apde006 = '30' THEN
         LET l_apde.apde008 = ''
         LET l_apde.apde024 = l_nmck.nmck025  #票券號碼
         #沖銷會科
         SELECT DISTINCT glab006 INTO l_apde.apde016  #agli190 
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld  = l_apde.apdeld
            AND glab001 = '21'
            AND glab002 = '30'
            AND glab003 = l_apde.apde021
      END IF
      
      LET l_apde.apde009 = 'Y'	             #已轉資料
      LET l_apde.apde011 = l_nmck.nmck009	    #銀行存提碼
      LET l_apde.apde012 = l_nmck.nmck010	    #現金變動碼
      LET l_apde.apde015 = 'C'	             #沖銷加減項
      LET l_apde.apde032 = l_nmck.nmck011	    #付款日
      LET l_apde.apde039 = l_nmck.nmck013	    #受款銀行
      LET l_apde.apde040 = l_nmck.nmck014	    #受款帳號
      LET l_apde.apde041 = l_nmck.nmck015	    #受款人全名
      LET l_apde.apde046 = l_nmcl.nmcl001	    #付款申請單
      LET l_apde.apde047 = ''          	    #付款申請單項次
      LET l_apde.apde100 = l_nmck.nmck100	    #幣別
      LET l_apde.apde101 = l_nmck.nmck101	    #匯率
      LET l_apde.apde104 = 0	                # 幣應稅折抵稅額
      #沖帳金額, 依該單出現在應付匯款或票據的 單身的金額合計即為沖帳金額
            #原幣沖帳金額 #本幣沖帳金額 #本位幣二沖帳金額 #本位幣三沖帳金額
      SELECT SUM(nmcl103),SUM(nmcl113),SUM(nmcl123),SUM(nmcl133)
        INTO l_apde.apde109,l_apde.apde119,l_apde.apde129,l_apde.apde139
        FROM nmcl_t
       WHERE nmclent=g_enterprise AND nmclcomp=l_apde.apdecomp
         AND nmcldocno=l_nmcl.nmcldocno AND nmcl001=l_nmcl.nmcl001
      #帳務歸屬組織   
      SELECT DISTINCT nmclorga,nmcl121,nmcl131 
        INTO l_apde.apdeorga,l_nmcl.nmcl121,l_nmcl.nmcl131
        FROM nmcl_t
       WHERE nmclent=g_enterprise AND nmclcomp=l_apde.apdecomp
         AND nmcldocno=l_nmcl.nmcldocno AND nmcl001=l_nmcl.nmcl001
         
      IF l_glaa015 = 'Y' THEN
         LET l_apde.apde120 = l_glaa016       #本位幣二幣別
         LET l_apde.apde121 = l_nmcl.nmcl121  #本位幣二匯率
      ELSE
         LET l_apde.apde120 = ''              #本位幣二幣別
         LET l_apde.apde121 = 0               #本位幣二匯率
         LET l_apde.apde129 = 0               #本位幣二沖帳金額
      END IF
      IF l_glaa019 = 'Y' THEN
         LET l_apde.apde130 = l_glaa020       #本位幣三幣別
         LET l_apde.apde131 = l_nmcl.nmcl131  #本位幣三匯率
      ELSE
         LET l_apde.apde130 = ''              #本位幣三幣別
         LET l_apde.apde131 = 0               #本位幣三匯率
      END IF
      #INSERT INTO apde_t VALUES(l_apde.*) #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO apde_t (apdeent,apdecomp,apdeld,apdedocno,apdeseq,
                          apdesite,apdeorga,
                          apde001,apde002,apde003,apde004,apde006,
                          apde008,apde009,apde010,apde011,apde012,
                          apde013,apde014,apde015,apde016,apde017,
                          apde018,apde019,apde020,apde021,apde022,
                          apde023,apde024,apde028,apde029,apde030,
                          apde032,apde035,apde036,apde038,apde039,
                          apde040,apde041,apde042,apde043,apde044,
                          apde045,apde046,apde047,apde051,apde052,
                          apde053,apde054,apde055,apde056,apde057,
                          apde058,apde059,apde060,apde100,apde101,
                          apde104,apde109,apde119,apde120,apde121,
                          apde129,apde130,apde131,apde139,
                          #161125-00021#1 add ------
                          apdeud001,apdeud002,apdeud003,apdeud004,apdeud005,
                          apdeud006,apdeud007,apdeud008,apdeud009,apdeud010,
                          apdeud011,apdeud012,apdeud013,apdeud014,apdeud015,
                          apdeud016,apdeud017,apdeud018,apdeud019,apdeud020,
                          apdeud021,apdeud022,apdeud023,apdeud024,apdeud025,
                          apdeud026,apdeud027,apdeud028,apdeud029,apdeud030,
                          #161125-00021#1 add end---
                          apde061
                         )
      VALUES (l_apde.apdeent,l_apde.apdecomp,l_apde.apdeld,l_apde.apdedocno,l_apde.apdeseq,
              l_apde.apdesite,l_apde.apdeorga,
              l_apde.apde001,l_apde.apde002,l_apde.apde003,l_apde.apde004,l_apde.apde006,
              l_apde.apde008,l_apde.apde009,l_apde.apde010,l_apde.apde011,l_apde.apde012,
              l_apde.apde013,l_apde.apde014,l_apde.apde015,l_apde.apde016,l_apde.apde017,
              l_apde.apde018,l_apde.apde019,l_apde.apde020,l_apde.apde021,l_apde.apde022,
              l_apde.apde023,l_apde.apde024,l_apde.apde028,l_apde.apde029,l_apde.apde030,
              l_apde.apde032,l_apde.apde035,l_apde.apde036,l_apde.apde038,l_apde.apde039,
              l_apde.apde040,l_apde.apde041,l_apde.apde042,l_apde.apde043,l_apde.apde044,
              l_apde.apde045,l_apde.apde046,l_apde.apde047,l_apde.apde051,l_apde.apde052,
              l_apde.apde053,l_apde.apde054,l_apde.apde055,l_apde.apde056,l_apde.apde057,
              l_apde.apde058,l_apde.apde059,l_apde.apde060,l_apde.apde100,l_apde.apde101,
              l_apde.apde104,l_apde.apde109,l_apde.apde119,l_apde.apde120,l_apde.apde121,
              l_apde.apde129,l_apde.apde130,l_apde.apde131,l_apde.apde139,
              #161125-00021#1 add ------
              l_apde.apdeud001,l_apde.apdeud002,l_apde.apdeud003,l_apde.apdeud004,l_apde.apdeud005,
              l_apde.apdeud006,l_apde.apdeud007,l_apde.apdeud008,l_apde.apdeud009,l_apde.apdeud010,
              l_apde.apdeud011,l_apde.apdeud012,l_apde.apdeud013,l_apde.apdeud014,l_apde.apdeud015,
              l_apde.apdeud016,l_apde.apdeud017,l_apde.apdeud018,l_apde.apdeud019,l_apde.apdeud020,
              l_apde.apdeud021,l_apde.apdeud022,l_apde.apdeud023,l_apde.apdeud024,l_apde.apdeud025,
              l_apde.apdeud026,l_apde.apdeud027,l_apde.apdeud028,l_apde.apdeud029,l_apde.apdeud030,
              #161125-00021#1 add end---
              l_apde.apde061
             )
      #161108-00017#1 add end---
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'insert into apde_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH

   #付款单身是否有资料
#   LET l_cnt = 0
#   SELECT COUNT(*) INTO l_cnt FROM apde_t 
#    WHERE apdeent=g_enterprise AND apdeld=p_apdald AND apdedocno=p_apdadocno
#   IF l_cnt = 0 THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'aap-00423'
#      LET g_errparam.extend = p_apdadocno
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#   END IF
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
