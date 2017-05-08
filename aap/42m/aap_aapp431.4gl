#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp431.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-04-13 17:09:36), PR版次:0007(2017-01-11 18:30:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: aapp431
#+ Description: 付款沖銷單批次取消確認作業
#+ Creator....: 03538(2015-04-13 16:59:44)
#+ Modifier...: 03538 -SD/PR- 04152
 
{</section>}
 
{<section id="aapp431.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161014-00053#6  2016/10/21 By 06814    補上控制組邏輯
#161006-00005#18 2016/10/26 By 08732    組織類型與職能開窗調整
#161115-00042#2  2016/11/18 By 08732    開窗範圍處理(1帳款對象控制組)+process加控制組條件
#161229-00047#18 2017/01/10 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#161229-00047#76 2017/01/11 By Reanna   修正 #161229-00047#18 bug
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
         apdasite       LIKE apda_t.apdasite,
         apdald         LIKE apda_t.apdald,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       apdasite LIKE type_t.chr10, 
   apdasite_desc LIKE type_t.chr80, 
   apdald LIKE type_t.chr5, 
   apdald_desc LIKE type_t.chr80, 
   apdadocno LIKE type_t.chr20, 
   apdadocdt LIKE type_t.dat, 
   apda003 LIKE type_t.chr20, 
   apda005 LIKE type_t.chr10, 
   apdacnfid LIKE type_t.chr20, 
   apdacnfdt LIKE type_t.dat, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_apdacomp    LIKE ooef_t.ooef001
DEFINE g_wc_apdasite STRING
DEFINE g_wc_apdald   STRING
DEFINE g_sql_ctrl    STRING   #161014-00053#6 20161021 add by beckxie
DEFINE g_comp_str    STRING   #161229-00047#18
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp431.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_fin_create_account_center_tmp()
      #161229-00047#76 add ------
      SELECT ooef017 INTO g_apdacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
         AND ooefstus = 'Y'
      CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#76 add end---
      #end add-point
      CALL aapp431_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp431 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp431_init()
 
      #進入選單 Menu (="N")
      CALL aapp431_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp431
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp431.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp431_init()
 
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
   CALL s_fin_create_account_center_tmp()
   #161014-00053#6 20161021 add by beckxie---S
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 mark
   #161014-00053#6 20161021 add by beckxie---E
   
   #161229-00047#18 mark ------
   ##161115-00042#2   add---s
   #SELECT ooef017 INTO g_apdacomp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdacomp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#2 add---e
   #161229-00047#18 mark end---
   
   CALL aapp431_qbeclear() #161229-00047#76
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp431.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp431_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #CALL aapp431_qbeclear() #161229-00047#76 mark
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
 
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apdasite,g_master.apdald 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="input.a.apdasite"
            IF NOT cl_null(g_master.apdasite) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.apdasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apdasite = ''
                  LET g_master.apdasite_desc = ''
                  LET g_master.apdald = ''
                  LET g_master.apdald_desc = ''
                  LET g_wc_apdasite = ''
                  LET g_wc_apdald   = ''
                  DISPLAY BY NAME g_master.apdasite,g_master.apdasite_desc,g_master.apdald,g_master.apdald_desc
                  NEXT FIELD CURRENT
               END IF
               
               #帳務中心預設主帳套及主帳套所屬法人及其他預設值         
               CALL s_fin_orga_get_comp_ld(g_master.apdasite) RETURNING g_sub_success,g_errno,g_apdacomp,g_master.apdald
               
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#18 mark
               #161229-00047#18 add ------
               CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
               #161229-00047#18 add end---
               
               CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apdasite
               CALL s_fin_get_wc_str(g_wc_apdasite) RETURNING g_wc_apdasite
               #取得帳務中心底下的帳套範圍               
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
               CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald
               
               LET g_master.apdasite_desc= s_desc_get_department_desc(g_master.apdasite)
               LET g_master.apdald_desc  = s_desc_get_ld_desc(g_master.apdald)
               DISPLAY BY NAME g_master.apdasite_desc,g_master.apdald,g_master.apdald_desc
            ELSE                        
               LET g_master.apdasite_desc = ''
               LET g_master.apdald = ''
               LET g_master.apdald_desc = ''
               LET g_wc_apdasite = ''
               LET g_wc_apdald   = ''
               DISPLAY BY NAME g_master.apdasite_desc,g_master.apdald,g_master.apdald_desc
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="input.b.apdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdasite
            #add-point:ON CHANGE apdasite name="input.g.apdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
            LET g_master.apdald_desc = ''
            IF NOT cl_null(g_master.apdald) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','N',g_wc_apdald,g_today)
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apdald = ''
                  LET g_master.apdald_desc = ''
                  DISPLAY BY NAME g_master.apdald,g_master.apdald_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#18 mark
            #161229-00047#18 add ------
            CALL s_ld_sel_glaa(g_master.apdald,'glaacomp') RETURNING g_sub_success,g_apdacomp
            CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            #161229-00047#18 add end---
            LET g_master.apdald_desc  = s_desc_get_ld_desc(g_master.apdald)
            DISPLAY BY NAME g_master.apdald_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdald
            #add-point:ON CHANGE apdald name="input.g.apdald"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="input.c.apdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdasite
            #CALL q_ooef001()     #161006-00005#18   mark
            CALL q_ooef001_46()   #161006-00005#18   add
            LET g_master.apdasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.apdasite) RETURNING g_master.apdasite_desc
            DISPLAY BY NAME g_master.apdasite,g_master.apdasite_desc
            NEXT FIELD apdasite
            #END add-point
 
 
         #Ctrlp:input.c.apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdald
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apdald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_master.apdald = g_qryparam.return1
            LET g_master.apdald_desc  = s_desc_get_ld_desc(g_master.apdald)
            DISPLAY BY NAME g_master.apdald,g_master.apdald_desc
            NEXT FIELD apdald
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apdadocno,apdadocdt,apda003,apda005,apdacnfid,apdacnfdt
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="construct.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="construct.a.apdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="construct.c.apdadocno"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "      apdastus = 'Y' ",  
                                   "  AND apda001 = '45' ",
                                   "  AND apda007 <> '1' ",   #排除非人工                                   
                                   "  AND apdald = '",g_master.apdald,"' ",
                                   "  AND apdasite IN ",g_wc_apdasite," ",
                                   "  AND apda014 IS NULL "                                
            CALL q_apdadocno_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdadocno  #顯示到畫面上
            NEXT FIELD apdadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="construct.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="construct.a.apdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="construct.c.apdadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="construct.b.apda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="construct.a.apda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="construct.c.apda003"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda003  #顯示到畫面上
            NEXT FIELD apda003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda005
            #add-point:BEFORE FIELD apda005 name="construct.b.apda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda005
            
            #add-point:AFTER FIELD apda005 name="construct.a.apda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda005
            #add-point:ON ACTION controlp INFIELD apda005 name="construct.c.apda005"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            #161014-00053#6 20161021 add by beckxie---S
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161014-00053#6 20161021 add by beckxie---E
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda005  #顯示到畫面上
            NEXT FIELD apda005                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.apdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacnfid
            #add-point:ON ACTION controlp INFIELD apdacnfid name="construct.c.apdacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacnfid  #顯示到畫面上
            NEXT FIELD apdacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacnfid
            #add-point:BEFORE FIELD apdacnfid name="construct.b.apdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacnfid
            
            #add-point:AFTER FIELD apdacnfid name="construct.a.apdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacnfdt
            #add-point:BEFORE FIELD apdacnfdt name="construct.b.apdacnfdt"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL aapp431_get_buffer(l_dialog)
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
            CALL aapp431_qbeclear()
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
         CALL aapp431_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.apdasite  = g_master.apdasite
      LET lc_param.apdald    = g_master.apdald
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
                 CALL aapp431_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp431_transfer_argv(ls_js)
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
 
{<section id="aapp431.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp431_transfer_argv(ls_js)
 
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
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="aapp431.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp431_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql       STRING
   DEFINE l_wc        STRING
   DEFINE l_apda      RECORD
                      apdald       LIKE apda_t.apdald,
                      apdadocno    LIKE apda_t.apdadocno,
                      apda001      LIKE apda_t.apda001,
                      apdastus     LIKE apda_t.apdastus,
                      apdadocdt    LIKE apda_t.apdadocdt,
                      apdacomp     LIKE apda_t.apdacomp,
                      apdasite     LIKE apda_t.apdasite                      
                      END RECORD
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_sfin3008  LIKE type_t.chr80    #S-FIN-3008-付款單直接產生銀存支付帳   
   DEFINE l_prog      LIKE type_t.chr10    #備份現在執行的程式代號
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc        = lc_param.wc
      LET g_master.apdasite  = lc_param.apdasite
      LET g_master.apdald    = lc_param.apdald
      CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apdasite
      CALL s_fin_get_wc_str(g_wc_apdasite) RETURNING g_wc_apdasite
      #161229-00047#18 add ------
      SELECT ooef017 INTO g_apdacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_master.apdasite
         AND ooefstus = 'Y'
      CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#18 add end---
   END IF
   #INPUT欄位的是否輸入及檢核
   IF NOT cl_null(g_master.apdald) AND NOT cl_null(g_master.apdasite)THEN
      CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','N',g_wc_apdald,g_today)
         RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   ELSE
      #必要輸入其一欄位沒輸入
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'acr-00015'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF 
   
   IF g_master.wc = " 1=1" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00066'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #161229-00047#18 mark ------
   ##161115-00042#2   add---s
   ##交易對象開窗控制組
   #SELECT ooef017 INTO g_apdacomp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_master.apdasite
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdacomp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#2 add---e
   #161229-00047#18 mark end---
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapp431_process_cs CURSOR FROM ls_sql
#  FOREACH aapp431_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_wc  =  g_master.wc
   IF cl_null(l_wc) THEN LET l_wc = ' 1=1' END IF


   LET l_sql = " SELECT apdald,apdadocno,apda001,apdastus,apdadocdt,apdacomp,apdasite ",
               "   FROM apda_t ",
               "  WHERE apdaent = ",g_enterprise," ",
               "    AND apdald  = '",g_master.apdald,"' ",
               "    AND apdasite IN ",g_wc_apdasite," ",
               "    AND apda007 <> '1' ",   #排除非人工
               "    AND apdastus = 'Y' ",   
               "    AND apda001 = '45' ",   
               "    AND apda014 IS NULL ",  #未拋傳票
               "    AND ",l_wc CLIPPED                    
   PREPARE s_aapp431_apdap1 FROM l_sql
   DECLARE s_aapp431_apdac1 CURSOR WITH HOLD FOR s_aapp431_apdap1

   LET l_sql = "SELECT COUNT(*) FROM (",l_sql CLIPPED,")"
   PREPARE s_aapp431_countp1 FROM l_sql
   
   #檢核是否有符合條件的資料
   LET l_count = NULL
   EXECUTE s_aapp431_countp1 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF 
   IF l_count = 0 THEN
      #無符合條件資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   LET l_prog = g_prog    #備份程式代號
   LET g_prog = 'aapt420' 

   CALL cl_err_collect_init()
   FOREACH s_aapp431_apdac1 INTO l_apda.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.extend = 'FOREACH:s_aapp431_apdac1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      CALL cl_get_para(g_enterprise,l_apda.apdacomp,'S-FIN-3008') RETURNING l_sfin3008
      #取消確認前檢核
      IF NOT s_aapt420_unconf_chk(l_apda.apdald,l_apda.apdadocno,l_sfin3008) THEN
         #有檢核出錯誤,收集錯誤訊息
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00319'
         LET g_errparam.replace[1] = l_apda.apdald
         LET g_errparam.replace[2] = l_apda.apdadocno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      ELSE
         CALL s_transaction_begin()
         #取消確認段更新
         IF NOT s_aapt420_unconf_upd(l_apda.apdald,l_apda.apdadocno) THEN
            #更新失敗
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00319'
            LET g_errparam.replace[1] = l_apda.apdald
            LET g_errparam.replace[2] = l_apda.apdadocno
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
         ELSE
            #更新成功
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00318'
            LET g_errparam.replace[1] = l_apda.apdald
            LET g_errparam.replace[2] = l_apda.apdadocno
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('Y','0')
         END IF
      END IF
   END FOREACH 
   
   CALL cl_err_collect_show()
   LET g_prog = l_prog    #還原程式代號
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aapp431_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp431.get_buffer" >}
PRIVATE FUNCTION aapp431_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apdasite = p_dialog.getFieldBuffer('apdasite')
   LET g_master.apdald = p_dialog.getFieldBuffer('apdald')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp431.msgcentre_notify" >}
PRIVATE FUNCTION aapp431_msgcentre_notify()
 
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
 
{<section id="aapp431.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 回到預設值併清空qbe條件
# Memo...........:
# Date & Author..: 150107 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapp431_qbeclear()
   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_master.apdasite,g_master.apdald,g_apdacomp
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#18 mark
   #161229-00047#18 add ------
   CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#18 add end---
   
   CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apdasite
   CALL s_fin_get_wc_str(g_wc_apdasite) RETURNING g_wc_apdasite
   #取得帳務中心底下的帳套範圍
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
   CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald

   LET g_master.apdald_desc  = s_desc_get_ld_desc(g_master.apdald)
   LET g_master.apdasite_desc= s_desc_get_department_desc(g_master.apdasite)

   DISPLAY BY NAME g_master.apdald  ,g_master.apdald_desc,
                   g_master.apdasite,g_master.apdasite_desc
END FUNCTION

#end add-point
 
{</section>}
 
