#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-09-26 09:05:30), PR版次:0003(2016-11-11 15:02:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000005
#+ Filename...: aapp350
#+ Description: 退貨折讓證明單列印
#+ Creator....: 08171(2016-09-09 17:57:27)
#+ Modifier...: 08171 -SD/PR- 08992
 
{</section>}
 
{<section id="aapp350.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#161027-00019#1  2016/10/28  By 08171  增加過濾條件當 aisi080 的紅字發票是否必須對應原始發票(isai003) 為 Y 的倉退折讓資料作為列印內容
#161109-00065#1  2016/11/11  By 08171  aapp350列印時有發票資料才能列印,因此批次查詢時應排除無發票資料的單據
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
        apbb004        LIKE apbb_t.apbb004, 
        apbb004_desc   LIKE type_t.chr500,
        apbbcomp       LIKE apbb_t.apbbcomp, 
        apbbcomp_desc  LIKE type_t.chr500,
        apbb008        LIKE apbb_t.apbb008,
        apbb008_desc   LIKE type_t.chr500,
        l_apbbdocdt_s  LIKE apbb_t.apbbdocdt,  #單據日期範圍起
        l_apbbdocdt_e  LIKE apbb_t.apbbdocdt,  #單據日期範圍迄
        l_print_type   LIKE type_t.chr1,       #套表否
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel          LIKE type_t.chr1,
        apbadocno    LIKE apba_t.apbadocno,
        apbbdocdt    LIKE apbb_t.apbbdocdt,  
        apbb002      LIKE apbb_t.apbb002,  
        apbb029      LIKE apbb_t.apbb029,  
        apbb026      LIKE apbb_t.apbb026,  
        apbb027      LIKE apbb_t.apbb027,  
        apbb028      LIKE apbb_t.apbb028
                     END RECORD
                  
DEFINE g_master      type_parameter 

DEFINE g_ooef019     LIKE ooef_t.ooef019
DEFINE g_glaald      LIKE glaa_t.glaald
DEFINE g_ctl_where   STRING                #交易對象控制組WHERE CON
DEFINE g_wc_apbbcomp STRING
DEFINE g_master_wc   STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp350.main" >}
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
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp350 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp350_init()   
 
      #進入選單 Menu (="N")
      CALL aapp350_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp350
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp350.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp350_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL aapp350_qbe_clear()
   LET g_ctl_where = NULL
   CALL s_control_get_customer_sql('2',g_master.apbbcomp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp350_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_isac003   LIKE isac_t.isac003
   DEFINE l_isac008   LIKE isac_t.isac008
   DEFINE l_count     LIKE type_t.num10 
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapp350_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp350_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON apbbdocno,apbb002,apbb051,apbb052
         
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            AFTER CONSTRUCT
         
            ON ACTION controlp INFIELD apbbdocno
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " apbb004 = '",g_master.apbb004,"' ",
			                             " AND apbbcomp = '",g_master.apbbcomp,"' ",
			                             " AND apbb008 = '",g_master.apbb008,"' ",
			                             " AND (apbbdocdt BETWEEN '",g_master.l_apbbdocdt_s,"' AND '",g_master.l_apbbdocdt_e,"') ",
                                      " AND apbb050 = '2' ",     #發票性質
                                      " AND apbbstus = 'Y' "     #確認狀態
                                      
               IF NOT cl_null(g_ctl_where) AND NOT g_ctl_where = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_ctl_where,
                                                          "                AND pmaaent = apbbent ",
                                                          "                AND pmaa001 = apbb002 )"
               END IF                        
               CALL q_apbbdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbbdocno  #顯示到畫面上
               NEXT FIELD apbbdocno                     #返回原欄位
            
            ON ACTION controlp INFIELD apbb002
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               IF NOT cl_null(g_ctl_where) AND NOT g_ctl_where = ' 1=1'  THEN
               LET g_qryparam.where = g_ctl_where
               END IF
               CALL q_pmaa001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbb002    #顯示到畫面上
               NEXT FIELD apbb002 
            
            ON ACTION controlp INFIELD apbb051
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbb051    #顯示到畫面
               NEXT FIELD apbb051                       #返回原欄
            
            ON ACTION controlp INFIELD apbb052
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooef001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbb052  #顯示到畫面上
               NEXT FIELD apbb052                     #返回原欄位
            
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_master.apbb004,g_master.apbbcomp,g_master.apbb008,g_master.l_apbbdocdt_s,g_master.l_apbbdocdt_e,g_master.l_print_type 
          FROM apbb004,apbbcomp,apbb008,l_apbbdocdt_s,l_apbbdocdt_e,l_print_type
               
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
                 CALL aapp350_qbe_clear()
            AFTER FIELD apbb004
               LET g_master.apbb004_desc = ''
               LET g_master.apbbcomp_desc = ''
               DISPLAY BY NAME g_master.apbb004_desc,g_master.apbbcomp_desc
               IF NOT cl_null(g_master.apbb004) THEN
                  CALL s_fin_account_center_sons_query('3',g_master.apbb004,g_today,'1')
                  CALL s_fin_account_center_chk(g_master.apbb004,'','3',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apbb004 = ''
                     LET g_master.apbbcomp = ''
                     LET g_master.apbb004_desc = s_desc_get_department_desc(g_master.apbb004)
                     LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp)               
                     DISPLAY BY NAME g_master.apbb004,g_master.apbb004_desc,g_master.apbbcomp,g_master.apbbcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_fin_orga_get_comp_ld(g_master.apbb004) RETURNING g_sub_success,g_errno,g_master.apbbcomp,g_glaald
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apbb004 = ''
                     LET g_master.apbbcomp = ''
                     LET g_master.apbb004_desc = s_desc_get_department_desc(g_master.apbb004)
                     LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp)               
                     DISPLAY BY NAME g_master.apbb004,g_master.apbb004_desc,g_master.apbbcomp,g_master.apbbcomp_desc
                     NEXT FIELD CURRENT
                  END IF   
                   
                  IF NOT cl_null(g_master.apbbcomp)THEN
                     CALL s_fin_account_center_with_ld_chk(g_master.apbb004,g_glaald,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.apbb004 = ''
                        LET g_master.apbb004_desc = s_desc_get_department_desc(g_master.apbb004)           
                        DISPLAY BY NAME g_master.apbb004,g_master.apbb004_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_fin_account_center_sons_query('3',g_master.apbb004,g_today,'1')
               LET g_master.apbb004_desc = s_desc_get_department_desc(g_master.apbb004)
               LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp)               
               DISPLAY BY NAME g_master.apbb004,g_master.apbb004_desc,g_master.apbbcomp,g_master.apbbcomp_desc
            
            AFTER FIELD apbbcomp
               LET g_master.apbbcomp_desc = ''
               DISPLAY BY NAME g_master.apbbcomp_desc
               IF NOT cl_null(g_master.apbbcomp) THEN
                  CALL s_fin_comp_chk(g_master.apbbcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apbbcomp = ''
                     LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp) 
                     DISPLAY BY NAME g_master.apbbcomp,g_master.apbbcomp_desc                   
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_master.apbb004)THEN
                     CALL s_fin_account_center_with_ld_chk(g_master.apbb004,g_glaald,g_user,'3','Y','',g_today) 
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00127'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.apbbcomp = ''
                        LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp) 
                        DISPLAY BY NAME g_master.apbbcomp,g_master.apbbcomp_desc
                        NEXT FIELD CURRENT
                     END IF   
                  END IF
                  CALL s_fin_account_center_sons_query('3',g_master.apbb004,g_today,'')
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_apbbcomp
                  CALL s_fin_get_wc_str(g_wc_apbbcomp) RETURNING g_wc_apbbcomp
                  #檢查輸入帳套是否存在帳務中心下帳套範圍內
                  IF s_chr_get_index_of(g_wc_apbbcomp,g_master.apbbcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apbbcomp = ''
                     LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp) 
                     DISPLAY BY NAME g_master.apbbcomp,g_master.apbbcomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #取得稅區
               SELECT ooef019 INTO g_ooef019 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_master.apbbcomp AND ooefstus = 'Y'
               #控制組範圍
               LET g_ctl_where = NULL
               CALL s_control_get_customer_sql('2',g_master.apbbcomp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where
               LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp)               
               DISPLAY BY NAME g_master.apbbcomp,g_master.apbbcomp_desc
            
            AFTER FIELD apbb008
               LET g_master.apbb008_desc = ''
               DISPLAY BY NAME g_master.apbb008_desc
               IF NOT cl_null(g_master.apbb008) THEN  
                  INITIALIZE g_chkparam.* TO NULL      
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_master.apbb008
                  IF cl_chk_exist("v_isac002_2") THEN
                     #檢查成功時後續處理
                     SELECT isac003,isac008 INTO l_isac003,l_isac008  #發票歸屬進銷項
                       FROM isac_t
                      WHERE isacent = g_enterprise
                        AND isac001 = g_ooef019
                        AND isac002 = g_master.apbb008
                     
                     IF l_isac003 <> '3' THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00158'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.apbb008 = ''
                        LET g_master.apbb008_desc = s_desc_get_invoice_type_desc1(g_master.apbbcomp,g_master.apbb008)
                        DISPLAY BY NAME g_master.apbb008,g_master.apbb008_desc                     #顯示到畫面上
                        NEXT FIELD CURRENT
                     END IF    

                     #排除收據類聯別
                     IF l_isac008 ='0' OR l_isac008 ='4' THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00289'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.apbb008 = ''
                        LET g_master.apbb008_desc = s_desc_get_invoice_type_desc1(g_master.apbbcomp,g_master.apbb008)
                        DISPLAY BY NAME g_master.apbb008,g_master.apbb008_desc                     #顯示到畫面上
                        NEXT FIELD CURRENT
                     END IF  

                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.apbb008 = ''
                     LET g_master.apbb008_desc = s_desc_get_invoice_type_desc1(g_master.apbbcomp,g_master.apbb008)
                     DISPLAY BY NAME g_master.apbb008,g_master.apbb008_desc                     #顯示到畫面上
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               LET g_master.apbb008_desc = s_desc_get_invoice_type_desc1(g_master.apbbcomp,g_master.apbb008)
               DISPLAY BY NAME g_master.apbb008,g_master.apbb008_desc
            
            AFTER FIELD l_apbbdocdt_s
               IF NOT cl_null(g_master.l_apbbdocdt_s) AND NOT cl_null(g_master.l_apbbdocdt_e) THEN
                  IF g_master.l_apbbdocdt_s > g_master.l_apbbdocdt_e THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00336'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.l_apbbdocdt_s = ''
                     DISPLAY BY NAME g_master.l_apbbdocdt_s
                     NEXT FIELD l_apbbdocdt_s 
                  END IF
               END IF
            
            AFTER FIELD l_apbbdocdt_e
               IF NOT cl_null(g_master.l_apbbdocdt_e) THEN
                  IF g_master.l_apbbdocdt_s > g_master.l_apbbdocdt_e THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00336'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.l_apbbdocdt_e = ''
                     DISPLAY BY NAME g_master.l_apbbdocdt_e
                     NEXT FIELD l_apbbdocdt_e 
                  END IF
               END IF
          
            #帳務中心
            ON ACTION controlp INFIELD apbb004
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.apbb004      #給予default值
               CALL q_ooef001()                                #呼叫開窗
               LET g_master.apbb004 = g_qryparam.return1                        
               LET g_master.apbb004_desc = s_desc_get_department_desc(g_master.apbb004)
               DISPLAY BY NAME g_master.apbb004,g_master.apbb004_desc
               NEXT FIELD apbb004                             #返回原欄位

            #法人代碼
            ON ACTION controlp INFIELD apbbcomp 
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.apbbcomp             #給予default值
               CALL s_fin_account_center_sons_query('3',g_master.apbb004,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_apbbcomp
               CALL s_fin_get_wc_str(g_wc_apbbcomp) RETURNING g_wc_apbbcomp
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_apbbcomp CLIPPED," "
               CALL q_ooef001()                                #呼叫開窗
               LET g_master.apbbcomp = g_qryparam.return1   
               LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp)               
               DISPLAY BY NAME g_master.apbbcomp,g_master.apbbcomp_desc
               NEXT FIELD apbbcomp  

            #發票類型
            ON ACTION controlp INFIELD apbb008
               #開窗i段
               SELECT ooef019 INTO g_ooef019 FROM ooef_t              #稅區
                WHERE ooefent = g_enterprise AND ooef001 = g_master.apbbcomp AND ooefstus = 'Y'
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		    	   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.apbb008                                #給予default值
               LET g_qryparam.where = " isac001 = '",g_ooef019,"' AND isac003 = '3' AND isac008 NOT IN ('0','4') "
               CALL q_isac002()                                                         #呼叫開窗
               LET g_master.apbb008 = g_qryparam.return1                                 #將開窗取得的值回傳到變數
               LET g_master.apbb008_desc = s_desc_get_invoice_type_desc1(g_master.apbbcomp,g_master.apbb008)
               DISPLAY g_master.apbb008_desc TO apbb008_desc
               NEXT FIELD apbb008  
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
               
            ON CHANGE b_sel
               IF g_master.l_print_type = '2' THEN #非套表
                  IF g_detail_d[l_ac].sel = "Y" THEN #如果有勾選才要判斷
                     LET l_count = 0
                     FOR li_idx = 1 TO g_detail_d.getLength()
                        IF g_detail_d[li_idx].sel = "Y" THEN 
                           LET l_count = l_count + 1
                        END IF
                     END FOR 
                             
                     IF l_count>1 THEN  #不能超過一筆
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00344'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                                    
                        LET g_detail_d[l_ac].sel = "N"                        
                     END IF
                  END IF
               END IF
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
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            IF g_master.l_print_type = '2' THEN                  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00344'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err() 
               FOR li_idx = 1 TO g_detail_d.getLength()                     
                  LET g_detail_d[li_idx].sel = "N"
               END FOR              
            END IF
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
            IF g_master.l_print_type = '2' THEN
               LET l_count = 0
               FOR li_idx = 1 TO g_detail_d.getLength()
                  IF g_detail_d[li_idx].sel = "Y" THEN 
                     LET l_count = l_count + 1
                  END IF
               END FOR            
               IF l_count>1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00344'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()   
                  LET l_ac = ARR_CURR()               
                  LET g_detail_d[l_ac].sel = "N"                 
               END IF
            END IF
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
            CALL aapp350_filter()
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
            CALL aapp350_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL aapp350_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp350_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL aapp350_process()
            CALL aapp350_b_fill()
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
 
{<section id="aapp350.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp350_query()
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
   CALL aapp350_b_fill()
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
 
{<section id="aapp350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp350_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc =" 1=1 "
   END IF
   
   LET g_sql = " SELECT DISTINCT 'N',apbadocno,apbbdocdt,apbb002,apbb029,apbb026,apbb027,apbb028 ",
               #"   FROM apbb_t,apba_t ", #161027-00019#1 mark
               #161027-00019#1 --s add
               "   FROM apbb_t ", 
               "   LEFT JOIN apba_t ON   apbbent = apbaent AND apbbdocno = apbadocno   ",
               "   LEFT JOIN ooef_t ON ooefent = apbbent AND ooef001 = apbbcomp AND ooefstus = 'Y' ", #串稅區
               "   LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001 ",
               #161027-00019#1 --e add
               "  WHERE apbbent = ? ",
               "    AND apbbent = apbaent AND apbbdocno = apbadocno ",
               "    AND apbb004 = '",g_master.apbb004,"' ",
               "    AND apbbcomp = '",g_master.apbbcomp,"' ",
               "    AND apbb008 = '",g_master.apbb008,"' ",
               "    AND (apbbdocdt BETWEEN '",g_master.l_apbbdocdt_s,"' AND '",g_master.l_apbbdocdt_e,"') ",
               "    AND apbb050 = '2' ",             #交易發票
               "    AND apbbstus = 'Y' ",            #確認狀態
               "    AND isai003 = 'Y' ",             #紅字發票是否必須對應原始發票 #161027-00019#1 add
               "    AND apba017 IS NOT NULL ",       #不可查到沒有發票號碼的資料   #161109-00065#1  add
               "    AND ",g_master.wc

   IF NOT cl_null(g_ctl_where) AND NOT g_ctl_where = '1=1' THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_ctl_where,
                        "                AND pmaaent = apbbent ",
                        "                AND pmaa001 = apbb002 )"    #控制組
   END IF

   LET g_sql = g_sql," ORDER BY apbadocno,apbbdocdt " 
              
   #end add-point
 
   PREPARE aapp350_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp350_sel
   
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
      
      #end add-point
      
      CALL aapp350_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN
      CALL g_detail_d.deleteElement(g_detail_d.getLength())
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapp350_sel
   
   LET l_ac = 1
   CALL aapp350_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp350.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp350_fetch()
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
 
{<section id="aapp350.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp350_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp350.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp350_filter()
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
   
   CALL aapp350_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp350.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp350_filter_parser(ps_field)
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
 
{<section id="aapp350.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp350_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 資料處理
# Memo...........:
# Usage..........: CALL aapp350_process()
# Date & Author..: 160225 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp350_process()
DEFINE l_i           LIKE type_t.num5  
DEFINE l_wc          STRING 
DEFINE l_print       STRING
DEFINE l_sql         STRING 
DEFINE l_apbbdocno   LIKE apbb_t.apbbdocno
DEFINE l_isam010     LIKE isam_t.isam010
DEFINE l_apbbstus    LIKE apbb_t.apbbstus
DEFINE l_success     LIKE type_t.num10
DEFINE l_count       LIKE type_t.num5
DEFINE l_wc_print    STRING           
DEFINE l_do          LIKE type_t.num5 
DEFINE li_count      LIKE type_t.num5 
   
   LET l_success = TRUE
   LET l_apbbdocno = ''  
   LET l_isam010 = ''   
   LET l_apbbstus = ''   
   LET l_count = 0
   
   #取得有勾選的開票單號
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR 
      ELSE
         #重撈狀態碼,避免b_fill有此筆,但實際上已被取消確認
         SELECT apbbstus INTO l_apbbstus FROM apbb_t 
          WHERE apbbent = g_enterprise 
          AND apbbcomp = g_master.apbbcomp 
          AND apbbdocno = g_detail_d[l_i].apbadocno
         
         IF l_apbbstus <> 'Y' THEN CONTINUE FOR END IF
         
         IF cl_null(l_wc) THEN
            LET l_wc = g_detail_d[l_i].apbadocno
         ELSE
            LET l_wc = l_wc,"','",g_detail_d[l_i].apbadocno
         END IF       
         LET l_count = l_count + 1
      END IF
   END FOR
   #如未勾選任何一筆資料
   IF cl_null(l_wc) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()       
      LET g_success = 'N'
      RETURN
   ELSE
      LET l_wc = "('",l_wc,"')"          
   END IF
   
   LET li_count = 0
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM apbb_t ", 
               "  WHERE apbbent = ",g_enterprise," ",
               "    AND apbbdocno IN ",l_wc,
               "    AND apbbstus = 'Y' "
   PREPARE aapp350_cnt FROM l_sql
   DECLARE aapp350_cnt_cs CURSOR FOR aapp350_cnt
   EXECUTE aapp350_cnt_cs INTO li_count
   CALL cl_progress_bar_no_window(li_count)    #給予總次數
   
   CALL s_transaction_begin()
   LET l_wc_print = '' 
   LET l_do = 0 
   #更新isat_t列印次數+1
   LET l_sql = " SELECT DISTINCT apbbdocno,isam010 ",
               "   FROM apbb_t ",                                                      
               "   LEFT JOIN isam_t ON apbbent = isament AND apbbdocno = isamdocno AND isam036 <> 22 ",
               "  WHERE apbbent = ",g_enterprise," ",
               "    AND apbbdocno IN ",l_wc,
               "    AND apbbstus = 'Y' "
   
   
   PREPARE aapp350_pre FROM l_sql
   DECLARE aapp350_cs CURSOR FOR aapp350_pre
   FOREACH aapp350_cs INTO l_apbbdocno,l_isam010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET l_success = FALSE
         EXIT FOREACH
      END IF 
      
      UPDATE isam_t
         SET isam044 = isam044+1 
       WHERE isament = g_enterprise 
         AND isamdocno = l_apbbdocno
         AND isam010 = l_isam010
         AND isam036 = '21'   #折讓開立
         
      IF SQLCA.sqlerrd[3] = 0 OR SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd_isam044"
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         CONTINUE FOREACH         
      END IF
      
      IF cl_null(l_wc_print) THEN
         LET l_wc_print = l_apbbdocno
      ELSE
         LET l_wc_print = l_wc_print,"','",l_apbbdocno
      END IF
      LET l_do = l_do +1
      CALL cl_progress_no_window_ing("") #每次執行推進
   END FOREACH
   
   IF l_do > 0 THEN
      CALL s_transaction_end('Y','0')
      CALL cl_progress_no_window_ing("")        #成功:最後一次次執行推進
   ELSE
      CALL s_transaction_end('N','0')
      DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條
      RETURN
   END IF
   IF NOT cl_null(l_wc_print) THEN
      LET l_wc_print = "('",l_wc_print,"')"      
   END IF
  
   #列印
   LET g_master_wc = " apbbent = ",g_enterprise," AND apbb004 = '",g_master.apbb004,"' ",
                     " AND apbbcomp = '",g_master.apbbcomp,"' ",
                     " AND apbbdocno IN ",l_wc_print CLIPPED 
                     
   CALL aapp350_g01(g_master_wc,g_master.l_print_type) #傳入l_print_type套表否條件
   
END FUNCTION

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aapp350_qbe_clear()
# Date & Author..: 160225 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp350_qbe_clear()
   CLEAR FORM
   CALL g_detail_d.clear()

   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_master.apbb004,g_errno
   
   #法人
   SELECT ooef017 INTO g_master.apbbcomp 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.apbb004
      
   #取得稅區
   SELECT ooef019 INTO g_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_master.apbbcomp AND ooefstus = 'Y'
    
   #套表否
   LET g_master.l_print_type = '2'
      
   #單頭說明   
   LET g_master.apbb004_desc = s_desc_get_department_desc(g_master.apbb004)
   LET g_master.apbbcomp_desc = s_desc_get_department_desc(g_master.apbbcomp) 
   DISPLAY BY NAME g_master.apbb004,g_master.apbb004_desc,g_master.apbbcomp,g_master.apbbcomp_desc
   
   #發票日期
   LET g_master.l_apbbdocdt_s = g_today
   LET g_master.l_apbbdocdt_e = g_today
   
   DISPLAY g_master.l_apbbdocdt_s TO l_apbbdocdt_s
   DISPLAY g_master.l_apbbdocdt_e TO l_apbbdocdt_e
   DISPLAY g_master.l_print_type  TO l_print_type
END FUNCTION

#end add-point
 
{</section>}
 
