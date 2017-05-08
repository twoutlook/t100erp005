#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp020.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-03-15 16:30:45), PR版次:0003(2016-10-31 16:01:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: afmp020
#+ Description: 融資系統整批拋轉憑證作業
#+ Creator....: 01727(2016-03-04 15:28:15)
#+ Modifier...: 01727 -SD/PR- 08171
 
{</section>}
 
{<section id="afmp020.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#11  2016/03/25 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#33   2016/08/10 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   s_afmt145_fm_tmp -->afmt145_tmp01
#161028-00032#1    2016/10/28 By 08171   AFM_帳套/法人/來源組織權限控管,交易對象參考控制組
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
   glapld             LIKE glap_t.glapld,
   glapld_desc        LIKE type_t.chr80, 
   glapcomp           LIKE glap_t.glapcomp,
   glapcomp_desc      LIKE type_t.chr80,
   glapdocno          LIKE glap_t.glapdocno,
   glapdocdt          LIKE glap_t.glapdocdt,
   fmct001            LIKE fmct_t.fmct001,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
   sel           LIKE type_t.chr1,
   fmctdocno     LIKE fmct_t.fmctdocno,
   fmctdocdt     LIKE fmct_t.fmctdocdt,
   fmct001       LIKE fmct_t.fmct001,
   glaq003       LIKE glaq_t.glaq003,
   glaq004       LIKE glaq_t.glaq004,
   glapdocno     LIKE glap_t.glapdocno
END RECORD

DEFINE g_master         type_parameter
DEFINE g_glaa121        LIKE glaa_t.glaa121
DEFINE g_glav002        LIKE glav_t.glav002
DEFINE g_glav005        LIKE glav_t.glav005
DEFINE g_sdate_s        LIKE glav_t.glav004
DEFINE g_sdate_e        LIKE glav_t.glav004
DEFINE g_glav006        LIKE glav_t.glav006
DEFINE g_glav007        LIKE glav_t.glav007
DEFINE g_pdate_s        LIKE glav_t.glav004
DEFINE g_pdate_e        LIKE glav_t.glav004
DEFINE g_wdate_s        LIKE glav_t.glav004
DEFINE g_wdate_e        LIKE glav_t.glav004
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmp020.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmp020 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmp020_init()   
 
      #進入選單 Menu (="N")
      CALL afmp020_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afmp020
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afmp020.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmp020_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success    LIKE type_t.chr1
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part("fmct001","8035","M14,M17,M18,M19")
   CALL cl_set_combo_scc_part("b_fmct001","8035","M14,M17,M18,M19")
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmp020.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp020_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_errno     LIKE gzze_t.gzze001
   DEFINE l_success   LIKE type_t.num10
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_glaa013   LIKE glaa_t.glaa013
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_glav002   LIKE glav_t.glav002
   DEFINE l_glav002_2 LIKE glav_t.glav002
   DEFINE l_glav006   LIKE glav_t.glav006
   DEFINE l_glav006_2 LIKE glav_t.glav006  
   DEFINE l_glaa024   LIKE glaa_t.glaa024
   DEFINE l_glaa014   LIKE glaa_t.glaa014 
   DEFINE r_success   LIKE type_t.num10
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_comp_wc   STRING  #161028-00032#1
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
         CALL afmp020_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.glapld,g_master.glapdocno,g_master.glapdocdt,g_master.fmct001
            ATTRIBUTE(WITHOUT DEFAULTS)
                   
            BEFORE INPUT
               IF cl_null(g_master.glapld) THEN
                  SELECT ooef017 INTO g_master.glapcomp
                    FROM ooef_t
                   WHERE ooefent=g_enterprise
                     AND ooef001=g_site
                     AND ooefstus='Y'
                  SELECT glaald INTO g_master.glapld FROM glaa_t WHERE glaaent = g_enterprise 
                                                                   AND glaacomp = g_master.glapcomp 
                                                                   AND glaa014 = 'Y'
                  CALL s_desc_get_department_desc(g_master.glapcomp) RETURNING   g_master.glapcomp_desc
                  CALL s_desc_get_ld_desc(g_master.glapld)  RETURNING   g_master.glapld_desc                                                   
               END IF
               IF cl_null(g_master.glapdocdt) THEN
                  LET g_master.glapdocdt=g_today
               END IF
               SELECT glaa121 INTO g_glaa121 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glapld
               LET g_master.fmct001='M14'
               DISPLAY BY NAME  g_master.glapcomp,g_master.glapcomp_desc,g_master.glapld,g_master.glapld_desc,g_master.glapdocdt
               
         AFTER FIELD glapld           
            IF NOT cl_null(g_master.glapld) THEN
               #161028-00032#1 --s add
               CALL s_fin_ld_chk(g_master.glapld,g_user,'Y')RETURNING g_sub_success,g_errno  
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_errparam.replace[1] = 'agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog = 'agli010'
                  LET g_master.glapld = ''                   
                  CALL s_desc_get_ld_desc(g_master.glapld) RETURNING g_master.glapld_desc
                  DISPLAY BY NAME g_master.glapld_desc
                  NEXT FIELD CURRENT
               END IF      
               #161028-00032#1 --e add
               LET l_count=0
               SELECT COUNT(*) INTO l_count 
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_master.glapld
                  AND glaa014 ='Y'
               IF cl_null(l_count) OR l_count=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00016'
                  LET g_errparam.extend = g_master.glapld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.glapld=''
                  NEXT FIELD CURRENT                                                   
               END IF  
               #主帳套
               LET l_glaa014 =''
               SELECT glaa014 INTO l_glaa014 
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_master.glapld
               IF cl_null(l_glaa014 ) OR l_glaa014<>'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00071'
                  LET g_errparam.extend = g_master.glapld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.glapld=''
                  NEXT FIELD CURRENT                                                   
               END IF             
               #檢查帳套的權限設定agli010
               IF NOT s_ld_chk_authorization(g_user,g_master.glapld)THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302' #'agl-00051'  #160318-00005#11 mod  
                  LET g_errparam.extend = g_master.glapld
                  #160318-00005#11   --add--str
                  LET g_errparam.replace[1] ='agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog    ='agli010'
                  #160318-00005#11  --add--end
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.glapld=''
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_master.glapdocdt) THEN
                  LET l_glaa013=''
                  SELECT glaa013 INTO l_glaa013
                    FROM glaa_t
                   WHERE glaaent=g_enterprise
                     AND glaald=g_master.glapld
                  IF NOT cl_null(l_glaa013) AND l_glaa013>=g_master.glapdocdt THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00324'
                     LET g_errparam.extend = g_master.glapdocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_master.glapld=''
                     NEXT FIELD CURRENT
                  END IF  
               END IF
               SELECT glaa121 INTO g_glaa121 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glapld   #140829-00070#30 15/01/13   Add
 
            END IF    
            CALL s_desc_get_ld_desc(g_master.glapld)  RETURNING   g_master.glapld_desc 
            SELECT glaacomp INTO g_master.glapcomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glapld
            CALL s_desc_get_department_desc(g_master.glapcomp) RETURNING   g_master.glapcomp_desc
            DISPLAY BY NAME  g_master.glapcomp,g_master.glapcomp_desc,g_master.glapld,g_master.glapld_desc  

         AFTER FIELD glapdocno 
            IF NOT cl_null(g_master.glapdocno) THEN
               LET l_errno=''
               CALL afmp020_glapdocno_chk(g_master.glapdocno) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.glapdocno
                  #160318-00005#11   --add--str
                  LET g_errparam.replace[1] ='aooi200'
                  LET g_errparam.replace[2] = cl_get_progname('aooi200',g_lang,"2")
                  LET g_errparam.exeprog    ='aooi200'
                  #160318-00005#11  --add--end

                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_master.glapdocno = ''
                  NEXT FIELD glapdocno
               END IF             
            END IF
               
         AFTER FIELD glapdocdt
            IF NOT cl_null(g_master.glapdocdt) THEN 
               #憑證日期在關帳日期之後            
               IF NOT cl_null(g_master.glapld) THEN                 
                  LET l_glaa013=''
                  SELECT glaa003,glaa013 INTO l_glaa003,l_glaa013
                    FROM glaa_t
                   WHERE glaaent=g_enterprise
                     AND glaald=g_master.glapld
                  IF NOT cl_null(l_glaa013) AND l_glaa013>=g_master.glapdocdt THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00324'
                     LET g_errparam.extend = g_master.glapdocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_master.glapdocdt=''
                     NEXT FIELD CURRENT
                  END IF                                                               
               END IF
               CALL s_get_accdate(l_glaa003,g_master.glapdocdt,'','') 
               RETURNING l_flag,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                         g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
            END IF

         ON ACTION controlp INFIELD glapld
            #161028-00032#1 --s add
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL afmp020_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            #161028-00032#1 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glapld
            LET g_qryparam.arg1 = g_user #161028-00032#1 add
            LET g_qryparam.arg2 = g_dept #161028-00032#1 add
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,"" #161028-00032#1 add
            CALL q_authorised_ld()
            LET g_master.glapld = g_qryparam.return1
            DISPLAY g_master.glapld TO glapld
            CALL s_desc_get_ld_desc(g_master.glapld)  RETURNING   g_master.glapld_desc
            SELECT glaacomp INTO g_master.glapcomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glapld
            CALL s_desc_get_department_desc(g_master.glapcomp) RETURNING   g_master.glapcomp_desc
            DISPLAY BY NAME  g_master.glapcomp,g_master.glapcomp_desc,g_master.glapld,g_master.glapld_desc
            NEXT FIELD glapld


         ON ACTION controlp INFIELD glapdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glapdocno
            CALL s_ld_sel_glaa(g_master.glapld,'glaa024') RETURNING  r_success,l_glaa024
            LET g_qryparam.where = "ooba001 = '",l_glaa024,"' AND oobx002 = 'AGL' AND oobx003 = 'aglt310' "
            CALL q_ooba002_4()
            LET g_master.glapdocno = g_qryparam.return1
            DISPLAY BY NAME g_master.glapdocno
            NEXT FIELD glapdocno
         END INPUT
         
         
         
         CONSTRUCT BY NAME g_master.wc ON fmctdocno,fmctdocdt,fmctownid
     
            ON ACTION controlp INFIELD fmctdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_master.glapld
               LET g_qryparam.where = " glap008 = '",g_master.fmct001,"'"
               CALL q_afmdocno()
               DISPLAY g_qryparam.return1 TO fmctdocno
               NEXT FIELD fmctdocno
               
            ON ACTION controlp INFIELD fmctownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001() 
               DISPLAY g_qryparam.return1 TO fmctownid
               NEXT FIELD fmctownid
         END CONSTRUCT
         
         
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
              ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
               
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
            LET g_master.glapdocdt=g_today
            LET g_master.fmct001='1'
            NEXT FIELD glapld         #140829-00070#30 Add
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
            CALL afmp020_filter()
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
            CALL afmp020_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afmp020_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF cl_null(g_master.glapld) OR cl_null(g_master.glapdocno) OR cl_null(g_master.glapdocdt) OR cl_null(g_master.fmct001) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'anm-00328'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()                       
            ELSE
               #2015/01/20 add by qiull 
               LET l_flag = 'N'
               FOR l_i = 1 TO g_detail_cnt
                   IF g_detail_d[l_i].sel = 'Y' THEN
                      LET l_flag = 'Y'
                      EXIT FOR 
                   END IF
               END FOR 
               IF l_flag = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'axr-00159'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                
                  EXIT DIALOG
               END IF 
               #2015/01/20 add by qiull 
               CALL afmp020_process()
               IF g_success ='N' THEN
                  CONTINUE DIALOG
               END IF               
               IF g_bgjob = "N" THEN            
                  CALL cl_ask_confirm3("std-00012","")
               END IF
               CALL afmp020_b_fill()
               CALL afmp020_fetch()            
               NEXT FIELD glapld
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
 
{<section id="afmp020.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmp020_query()
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
   CALL afmp020_b_fill()
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
 
{<section id="afmp020.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmp020_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_bdate     LIKE glav_t.glav004
   DEFINE l_edate     LIKE glav_t.glav004
   DEFINE l_glaa013   LIKE glaa_t.glaa013
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_glav002   LIKE glav_t.glav002
   DEFINE l_glav006   LIKE glav_t.glav006
   DEFINE l_fmct001   LIKE fmct_t.fmct001
   DEFINE l_wc        STRING
   DEFINE ls_wc1      STRING
   DEFINE ls_wc2      STRING
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.chr1
   DEFINE l_fmct001_t LIKE fmct_t.fmct001
   DEFINE l_glaa024   LIKE glaa_t.glaa024 #单据别参照表号        #liuym add 2014/12/26
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_errno     LIKE gzze_t.gzze001

   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc =" 1=1 "
   END IF

   SELECT glaa003,glaa013 INTO l_glaa003,l_glaa013 FROM glaa_t
    WHERE glaaent=g_enterprise
      AND glaald=g_master.glapld
   CALL s_get_accdate(l_glaa003,g_master.glapdocdt,'','') 
   RETURNING l_flag,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
             g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e

   #提取借方金額和貸方金額
   LET l_sql = "SELECT SUM(d),SUM(c) FROM afmt145_tmp01 ",       #160727-00019#33 Mod   s_afmt145_fm_tmp -->afmt145_tmp01
               " WHERE docno='?'"
   PREPARE afmp020_amount FROM l_sql

   LET ls_wc1 ="SELECT fmctdocno,fmctdocdt,DECODE (fmct001, '01','M14', '02','M17', '03','M18') fmct001,",
               "       fmct002,fmctent FROM fmct_t                                                      ",
               " WHERE fmctent = '",g_enterprise,"' AND fmctstus = 'Y' AND fmct002 IS NULL              ",
               "    AND fmctld = '",g_master.glapld,"'",
               "    AND fmctcomp = '",g_master.glapcomp,"'"

   LET ls_wc2 ="SELECT fmdfdocno fmctdocno,fmdfdocdt fmctdocdt,'M19' fmct001,fmdf003 fmct002,fmdfent fmctent ",
               "  FROM fmdf_t WHERE fmdfent = '",g_enterprise,"' AND fmdfstus = 'Y' AND fmdf003 IS NULL",
               "    AND fmdfld = '",g_master.glapld,"'",
               "    AND fmdfcomp = '",g_master.glapcomp,"'"

   LET g_sql = "SELECT DISTINCT 'N',fmctdocno,fmctdocdt,fmct001,0,0,fmct002 ",
               "  FROM (",ls_wc1 CLIPPED," UNION ",ls_wc2 CLIPPED,")",
               " WHERE fmctent =? ",
               "   AND fmct001 = '",g_master.fmct001,"'",
               "   AND ",g_master.wc CLIPPED,
               "   AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_master.glapdocdt,"'"

   #end add-point
 
   PREPARE afmp020_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmp020_sel
   
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
      IF g_detail_d[l_ac].fmct001 = 'M19' THEN
         SELECT SUM(fmdg115) INTO g_detail_d[l_ac].glaq003 FROM fmdg_t WHERE fmdgent = g_enterprise
            AND fmdgdocno = g_detail_d[l_ac].fmctdocno
            AND fmdgld = g_master.glapld
      ELSE
         SELECT SUM(fmcu011) INTO g_detail_d[l_ac].glaq003 FROM fmcu_t WHERE fmcuent = g_enterprise
            AND fmcudono = g_detail_d[l_ac].fmctdocno
            AND fmculd = g_master.glapld
      END IF
      IF g_detail_d[l_ac].glaq003 < 0 THEN
         LET g_detail_d[l_ac].glaq003 = g_detail_d[l_ac].glaq003 * -1
      END IF
      LET g_detail_d[l_ac].glaq004 = g_detail_d[l_ac].glaq003

      IF g_glaa121 = 'N' THEN
         IF g_detail_d[l_ac].fmct001 = 'M19' THEN
            LET l_wc = "fmdfdocno = '"||g_detail_d[l_ac].fmctdocno||"'"
         ELSE
            LET l_wc = "fmctdocno = '"||g_detail_d[l_ac].fmctdocno||"'"
         END IF

         IF g_detail_d[l_ac].fmct001 = 'M14' THEN
            LET l_fmct001='afmt145'
         END IF
         IF g_detail_d[l_ac].fmct001 = 'M17' THEN
            LET l_fmct001='afmt175'
         END IF
         IF g_detail_d[l_ac].fmct001 = 'M18' THEN
            LET l_fmct001='afmt185'
         END IF
         IF g_detail_d[l_ac].fmct001 = 'M19' THEN
            LET l_fmct001='afmt190'
         END IF     

         LET l_success=TRUE

         CALL s_afmt145_gen_fm('1',g_master.glapld,g_master.glapdocdt,g_master.glapdocno,'0',l_wc,'N',g_detail_d[l_ac].fmct001)
            RETURNING l_success
         EXECUTE afmp020_amount USING g_detail_d[l_ac].fmctdocno INTO g_detail_d[l_ac].glaq003,g_detail_d[l_ac].glaq004
      ELSE
         SELECT SUM(glgb003),SUM(glgb004) INTO g_detail_d[l_ac].glaq003,g_detail_d[l_ac].glaq004 FROM glgb_t
          WHERE glgbent = g_enterprise
            AND glgbdocno = g_detail_d[l_ac].fmctdocno
      END IF


      #end add-point
      
      CALL afmp020_detail_show()      
 
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
   FREE afmp020_sel
   
   LET l_ac = 1
   CALL afmp020_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp020.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmp020_fetch()
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
 
{<section id="afmp020.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmp020_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp020.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afmp020_filter()
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
   
   CALL afmp020_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afmp020.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afmp020_filter_parser(ps_field)
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
 
{<section id="afmp020.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afmp020_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmp020_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmp020.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 拋磚還原
# Memo...........:
# Usage..........: CALL afmp020_process()
# Input parameter: 
# Return code....: 
# Date & Author..: 20141202 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp020_process()
DEFINE l_i          LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_success    LIKE type_t.chr1
DEFINE l_start_no   LIKE glap_t.glapdocno
DEFINE l_end_no     LIKE glap_t.glapdocno   
DEFINE l_str        STRING 
DEFINE l_wc         STRING
DEFINE l_sql        STRING
DEFINE l_fmct001    LIKE fmct_t.fmct001
DEFINE l_type       LIKE type_t.chr5
DEFINE l_slip_success   LIKE type_t.num5
DEFINE l_conf_success   LIKE type_t.num5
DEFINE l_dfin0031       LIKE type_t.chr1
DEFINE l_dfin0032       LIKE type_t.chr1
DEFINE l_gl_slip        LIKE ooba_t.ooba002 
DEFINE l_slip            LIKE ooba_t.ooba002

   LET g_success = 'Y'
   LET l_cnt=0

   CALL cl_err_collect_init()
   LET l_success=TRUE
   CALL s_voucher_cre_nm_tmp_table() RETURNING l_success
   CALL s_transaction_begin()

   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR 
      END IF

      IF g_detail_d[l_i].fmct001 = 'M19' THEN
         LET l_wc = "fmdfdocno = '"||g_detail_d[l_i].fmctdocno||"'"
      ELSE
         LET l_wc = "fmctdocno = '"||g_detail_d[l_i].fmctdocno||"'"
      END IF

      IF g_detail_d[l_i].fmct001 = 'M14' THEN
         LET l_fmct001='afmt145'
      END IF
      IF g_detail_d[l_i].fmct001 = 'M17' THEN
         LET l_fmct001='afmt175'
      END IF
      IF g_detail_d[l_i].fmct001 = 'M18' THEN
         LET l_fmct001='afmt185'
      END IF
      IF g_detail_d[l_i].fmct001 = 'M19' THEN
         LET l_fmct001='afmt190'
      END IF     

      LET l_success=TRUE

      IF g_glaa121 = 'Y' THEN
         LET l_wc =" glgbdocno = '"||g_detail_d[l_i].fmctdocno||"'"
         CALL s_pre_voucher_ins_glap('FM',g_detail_d[l_i].fmct001,g_master.glapld,g_master.glapdocdt,g_master.glapdocno,'1',l_wc) RETURNING l_success,l_start_no,l_end_no
      ELSE
         CALL s_afmt145_gen_fm('1',g_master.glapld,g_master.glapdocdt,g_master.glapdocno,'0',l_wc,'N',l_fmct001) RETURNING l_success
      END IF

      IF l_success THEN
         LET g_success = 'Y'
         IF cl_null (l_str)  THEN
            LET l_str = l_start_no
         ELSE   
            LET l_str = l_str,"/'",l_start_no,"'"
         END IF
         LET l_cnt = l_cnt + 1   #生成拋轉單號筆數
      END IF

   END FOR

   IF g_success = 'N' THEN
      CALL s_transaction_end('N',1)
   ELSE
      CALL s_transaction_end('Y',1)    
   END IF

  #憑證單號顯示
   IF g_success = 'Y' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = ""
       LET g_errparam.code   = "anm-00304"
       LET g_errparam.popup  = TRUE
       LET g_errparam.replace[1] = l_cnt
       LET g_errparam.replace[2] = l_str
       CALL cl_err()
   END IF 
   CALL cl_err_collect_show()

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afmp020_glapdocno_chk(p_glapdocno)
#                  RETURNING r_errno
# Input parameter: p_glapdocno    單別
# Return code....: r_errno        錯誤信息
# Date & Author..: 20121202 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp020_glapdocno_chk(p_glapdocno)
DEFINE p_glapdocno      LIKE glap_t.glapdocno
DEFINE l_oobastus       LIKE ooba_t.oobastus
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_glaa024        LIKE glaa_t.glaa024
DEFINE r_success        LIKE type_t.num10

   CALL s_ld_sel_glaa(g_master.glapld,'glaa024') RETURNING  r_success,l_glaa024       
   LET r_errno = ''
   SELECT oobastus INTO l_oobastus
     FROM ooba_t LEFT OUTER JOIN oobx_t ON (oobaent=oobxent AND ooba002=oobx001)
    WHERE oobaent = g_enterprise
      AND ooba001 = l_glaa024        #单据别参照表号
      AND ooba002 = p_glapdocno    #单据别
      AND oobx002 = 'AGL'          #模组
      AND oobx003 ='aglt310'      #单据性质
   CASE
      WHEN SQLCA.SQLCODE =100  LET r_errno = 'aim-00056'
      WHEN l_oobastus = 'N'    LET r_errno = 'sub-01302'   #'aim-00057'#160318-00005#11 mod 
   END CASE

   RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161028-00032#1
# Usage..........: CALL afmp020_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161028 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp020_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

#end add-point
 
{</section>}
 
