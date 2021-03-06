#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp832.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-01-08 10:13:31), PR版次:0007(2017-01-11 18:32:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aapp832
#+ Description: 供應商費用分攤作業(零售)
#+ Creator....: 02114(2016-01-07 18:29:31)
#+ Modifier...: 02114 -SD/PR- 04152
 
{</section>}
 
{<section id="aapp832.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160812-00027#3  2016/08/16 By 06821    全面盤點應付程式帳套權限控管
#160920-00019#2  2016/09/21 By 08732    交易對象開窗校驗調整
#161006-00005#7  2016/10/12 By 08732    組織類型與職能開窗調整
#161104-00024#1  2016/11/08 By 08729    處理DEFINE有星號
#161115-00046#1  2016/11/23 By 08729    開窗增加過濾據點
#161229-00047#21 2017/01/11 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       apddsite LIKE apdd_t.apddsite, 
   apddsite_desc LIKE type_t.chr80, 
   apddcomp LIKE apdd_t.apddcomp, 
   apddcomp_desc LIKE type_t.chr80, 
   stbadocno LIKE stba_t.stbadocno, 
   stbadocdt LIKE stba_t.stbadocdt, 
   apdd001 LIKE apdd_t.apdd001, 
   apdd002 LIKE apdd_t.apdd002, 
   apdddocno LIKE apdd_t.apdddocno, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_sql_ctrl      STRING               #160920-00019#2---add
DEFINE g_wc_cs_comp    STRING               #161006-00005#7   add
DEFINE g_comp          LIKE glaa_t.glaacomp #161115-00046#1 add
DEFINE g_comp_str      STRING               #161229-00047#21
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp832.main" >}
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
      #161229-00047#21 add ------
      SELECT ooef017 INTO g_master.apddcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
         AND ooefstus = 'Y'
      CALL s_fin_get_wc_str(g_master.apddcomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#21 add end---
      #end add-point
      CALL aapp832_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp832 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp832_init()
 
      #進入選單 Menu (="N")
      CALL aapp832_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp832
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp832.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp832_init()
 
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
   #161006-00005#7   add---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp 
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp  
   #161006-00005#7   add---e
   #160920-00019#2---s
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00046#1 mark
   #160920-00019#2---e
   #161115-00046#1-add(s)
   SELECT ooef017 INTO g_master.apddcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_master.apddcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#21 mark
   #161115-00046#1-add(e)
   #161229-00047#21 add ------
   CALL s_fin_get_wc_str(g_master.apddcomp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#21 add end---
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp832.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp832_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_ooef004     LIKE ooef_t.ooef004
   DEFINE l_success     LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #账务中心
   #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_master.apddsite,g_errno
   CALL s_desc_get_department_desc(g_master.apddsite) RETURNING g_master.apddsite_desc
   #法人   
   SELECT ooef017 INTO g_master.apddcomp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.apddsite
   CALL s_desc_get_department_desc(g_master.apddcomp) RETURNING g_master.apddcomp_desc
   SELECT glaald INTO g_glaald FROM glaa_t
    WHERE glaaent=g_enterprise AND glaacomp=g_master.apddcomp AND glaa014='Y'
   #单据日期
   LET g_master.stbadocdt = g_today
   DISPLAY BY NAME g_master.apddsite,g_master.apddsite_desc,g_master.apddcomp,g_master.apddcomp_desc,g_master.stbadocdt
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apddsite,g_master.apddcomp,g_master.stbadocno,g_master.stbadocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apddsite
            
            #add-point:AFTER FIELD apddsite name="input.a.apddsite"
            IF NOT cl_null(g_master.apddsite) THEN
#mak by chenhz 15/11/16(s) 切换运营据点之后，更改门店仍然报错，暂时先mark掉不管控               
#              CALL s_fin_account_center_with_ld_chk(g_master.apddsite,g_glaald,g_user,'3','N','',g_today)
#              RETURNING l_success,g_errno
#              IF NOT cl_null(g_errno) THEN
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = g_errno
#                 LET g_errparam.extend = g_master.apddsite
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()                  
#                 NEXT FIELD CURRENT
#              END IF
#mak by chenhz 15/11/16(e)
               
               #161006-00005#7   add---s
               CALL s_fin_account_center_with_ld_chk(g_master.apddsite,g_glaald,g_user,'3','N','',g_today)
               RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.apddsite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                  
                  NEXT FIELD CURRENT
               END IF
               #161006-00005#7   add---e
            END IF
            LET g_master.apddsite_desc = s_desc_get_department_desc(g_master.apddsite)
            DISPLAY BY NAME g_master.apddsite_desc
            #營運據點取得帳別與法人
            CALL s_fin_orga_get_comp_ld(g_master.apddsite) RETURNING g_sub_success,g_errno,g_master.apddcomp,g_glaald
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_master.apddcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00046#1-add #161229-00047#21 mark
            #161229-00047#21 add ------
            CALL s_fin_get_wc_str(g_master.apddcomp) RETURNING g_comp_str
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            #161229-00047#21 add end---
            LET g_master.apddcomp_desc = s_desc_get_department_desc(g_master.apddcomp)
            DISPLAY BY NAME g_master.apddcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apddsite
            #add-point:BEFORE FIELD apddsite name="input.b.apddsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apddsite
            #add-point:ON CHANGE apddsite name="input.g.apddsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apddcomp
            
            #add-point:AFTER FIELD apddcomp name="input.a.apddcomp"
            IF NOT cl_null(g_master.apddcomp) THEN
               CALL s_fin_account_center_sons_query('3',g_master.apddsite,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               SELECT glaald INTO g_glaald FROM glaa_t 
                WHERE glaaent=g_enterprise AND glaacomp=g_master.apddcomp AND glaa014='Y'
               #CALL s_fin_account_center_with_ld_chk(g_master.apddsite,g_glaald,g_user,'3','Y','',g_today)
               CALL s_fin_site_belong_to_comp_chk(g_master.apddsite,g_master.apddcomp)   #161006-00005#7   add
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apddcomp = ''
                  CALL s_desc_get_department_desc(g_master.apddcomp) RETURNING g_master.apddcomp_desc  
                  DISPLAY BY NAME g_master.apddcomp_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_department_desc(g_master.apddcomp) RETURNING g_master.apddcomp_desc                    
            DISPLAY BY NAME g_master.apddcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apddcomp
            #add-point:BEFORE FIELD apddcomp name="input.b.apddcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apddcomp
            #add-point:ON CHANGE apddcomp name="input.g.apddcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbadocno
            #add-point:BEFORE FIELD stbadocno name="input.b.stbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbadocno
            
            #add-point:AFTER FIELD stbadocno name="input.a.stbadocno"
            IF NOT cl_null(g_master.stbadocno) THEN
               IF NOT s_aooi200_chk_slip(g_site,'',g_master.stbadocno,'astt320') THEN
                  LET g_master.stbadocno =  ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbadocno
            #add-point:ON CHANGE stbadocno name="input.g.stbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbadocdt
            #add-point:BEFORE FIELD stbadocdt name="input.b.stbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbadocdt
            
            #add-point:AFTER FIELD stbadocdt name="input.a.stbadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbadocdt
            #add-point:ON CHANGE stbadocdt name="input.g.stbadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apddsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apddsite
            #add-point:ON ACTION controlp INFIELD apddsite name="input.c.apddsite"
            #add by chenhz 15/11/16 增加开窗功能    
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
      #      LET g_qryparam.where = s_aooi500_q_where(g_prog,'xcczucsite',g_site,'c')
            #CALL q_ooef001_24()                           #呼叫開窗 #160812-00027#3 mark
            #CALL q_ooef001()                               #呼叫開窗 #160812-00027#3 add   #161006-00005#7   mark
            CALL q_ooef001_46()                                                           #161006-00005#7   add 
            LET g_master.apddsite = g_qryparam.return1              
            DISPLAY g_master.apddsite TO apddsite  #顯示到畫面上
            NEXT FIELD apddsite                      #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apddcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apddcomp
            #add-point:ON ACTION controlp INFIELD apddcomp name="input.c.apddcomp"
            #add by chenhz 15/11/16 增加开窗功能    
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apddcomp
            #LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp   #161006-00005#7   mark  
            #161006-00005#7   add---s
            IF NOT cl_null(g_master.apddsite) THEN
               CALL s_fin_account_center_sons_query('3',g_master.apddsite,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp,
			                          " AND ooef003 = 'Y'"   
            ELSE
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp,
			                          " AND ooef003 = 'Y'"   
            END IF
            CALL q_ooef001()          
            #161006-00005#7   add---e
            #CALL q_ooef001_8()       #161006-00005#7   mark                    #呼叫開窗
            LET g_master.apddcomp = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO apddcomp  #顯示到畫面上
            NEXT FIELD apddcomp                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.stbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbadocno
            #add-point:ON ACTION controlp INFIELD stbadocno name="input.c.stbadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.stbadocno             #給予default值

            #給予arg
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_master.apddcomp AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = 'astt320' #


            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.stbadocno = g_qryparam.return1              

            DISPLAY g_master.stbadocno TO stbadocno              #

            NEXT FIELD stbadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbadocdt
            #add-point:ON ACTION controlp INFIELD stbadocdt name="input.c.stbadocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apdd001,apdd002,apdddocno
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdd001
            #add-point:BEFORE FIELD apdd001 name="construct.b.apdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdd001
            
            #add-point:AFTER FIELD apdd001 name="construct.a.apdd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdd001
            #add-point:ON ACTION controlp INFIELD apdd001 name="construct.c.apdd001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002='3')"   #160920-00019#2---mark
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdd001  #顯示到畫面上
            NEXT FIELD apdd001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdd002
            #add-point:BEFORE FIELD apdd002 name="construct.b.apdd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdd002
            
            #add-point:AFTER FIELD apdd002 name="construct.a.apdd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdd002
            #add-point:ON ACTION controlp INFIELD apdd002 name="construct.c.apdd002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " stanstus='Y' AND stan029 = '3' AND stanent = ",g_enterprise
            CALL q_stan001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdd002  #顯示到畫面上
            NEXT FIELD apdd002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdddocno
            #add-point:BEFORE FIELD apdddocno name="construct.b.apdddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdddocno
            
            #add-point:AFTER FIELD apdddocno name="construct.a.apdddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdddocno
            #add-point:ON ACTION controlp INFIELD apdddocno name="construct.c.apdddocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcastus='Y' "
            CALL q_apdddocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdddocno  #顯示到畫面上
            NEXT FIELD apdddocno                     #返回原欄位
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
            CALL aapp832_get_buffer(l_dialog)
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
         CALL aapp832_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
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
                 CALL aapp832_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp832_transfer_argv(ls_js)
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
 
{<section id="aapp832.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp832_transfer_argv(ls_js)
 
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
 
{<section id="aapp832.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp832_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapp832_process_cs CURSOR FROM ls_sql
#  FOREACH aapp832_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL aapp832_p()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aapp832_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp832.get_buffer" >}
PRIVATE FUNCTION aapp832_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apddsite = p_dialog.getFieldBuffer('apddsite')
   LET g_master.apddcomp = p_dialog.getFieldBuffer('apddcomp')
   LET g_master.stbadocno = p_dialog.getFieldBuffer('stbadocno')
   LET g_master.stbadocdt = p_dialog.getFieldBuffer('stbadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp832.msgcentre_notify" >}
PRIVATE FUNCTION aapp832_msgcentre_notify()
 
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
 
{<section id="aapp832.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 产生费用单
# Memo...........:
# Usage..........: CALL aapp832_p()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp832_p()
   DEFINE g_success            LIKE type_t.num5
   DEFINE l_sql                STRING
   DEFINE l_success            LIKE type_t.num5
   DEFINE l_apcald             LIKE apca_t.apcald
   DEFINE l_apcadocno          LIKE apca_t.apcadocno
   DEFINE l_apca057            LIKE apca_t.apca057
   DEFINE l_apdd001          LIKE apdd_t.apdd001
   DEFINE l_apdd002          LIKE apdd_t.apdd002
   DEFINE l_apdd003          LIKE apdd_t.apdd003
   DEFINE l_apdd007          LIKE apdd_t.apdd007
   DEFINE l_apdd005          LIKE apdd_t.apdd005
   DEFINE l_apdd009          LIKE apdd_t.apdd009
   DEFINE l_apdd012          LIKE apdd_t.apdd012
   #DEFINE l_stba               RECORD LIKE stba_t.* #161104-00024#1 mark
   #DEFINE l_stbb               RECORD LIKE stbb_t.* #161104-00024#1 mark
   #161104-00024#1-add(s)
   DEFINE l_stba RECORD  #費用單資料表
       stbaent    LIKE stba_t.stbaent, #企業編號
       stbasite   LIKE stba_t.stbasite, #營運據點
       stbaunit   LIKE stba_t.stbaunit, #應用組織
       stbadocno  LIKE stba_t.stbadocno, #單據編號
       stbadocdt  LIKE stba_t.stbadocdt, #單據日期
       stba001    LIKE stba_t.stba001, #結算中心
       stba002    LIKE stba_t.stba002, #供應商編號
       stba003    LIKE stba_t.stba003, #經營方式
       stba004    LIKE stba_t.stba004, #結算方式
       stba005    LIKE stba_t.stba005, #結算類型
       stba006    LIKE stba_t.stba006, #來源類型
       stba007    LIKE stba_t.stba007, #來源單號
       stba008    LIKE stba_t.stba008, #人員
       stba009    LIKE stba_t.stba009, #部門
       stbastus   LIKE stba_t.stbastus, #狀態碼
       stbaownid  LIKE stba_t.stbaownid, #資料所屬者
       stbaowndp  LIKE stba_t.stbaowndp, #資料所有部門
       stbacrtid  LIKE stba_t.stbacrtid, #資料建立者
       stbacrtdp  LIKE stba_t.stbacrtdp, #資料建立部門
       stbacrtdt  LIKE stba_t.stbacrtdt, #資料創建日
       stbamodid  LIKE stba_t.stbamodid, #資料修改者
       stbamoddt  LIKE stba_t.stbamoddt, #最近修改日
       stbacnfid  LIKE stba_t.stbacnfid, #資料確認者
       stbacnfdt  LIKE stba_t.stbacnfdt, #資料確認日
       stbaud001  LIKE stba_t.stbaud001, #自定義欄位(文字)001
       stbaud002  LIKE stba_t.stbaud002, #自定義欄位(文字)002
       stbaud003  LIKE stba_t.stbaud003, #自定義欄位(文字)003
       stbaud004  LIKE stba_t.stbaud004, #自定義欄位(文字)004
       stbaud005  LIKE stba_t.stbaud005, #自定義欄位(文字)005
       stbaud006  LIKE stba_t.stbaud006, #自定義欄位(文字)006
       stbaud007  LIKE stba_t.stbaud007, #自定義欄位(文字)007
       stbaud008  LIKE stba_t.stbaud008, #自定義欄位(文字)008
       stbaud009  LIKE stba_t.stbaud009, #自定義欄位(文字)009
       stbaud010  LIKE stba_t.stbaud010, #自定義欄位(文字)010
       stbaud011  LIKE stba_t.stbaud011, #自定義欄位(數字)011
       stbaud012  LIKE stba_t.stbaud012, #自定義欄位(數字)012
       stbaud013  LIKE stba_t.stbaud013, #自定義欄位(數字)013
       stbaud014  LIKE stba_t.stbaud014, #自定義欄位(數字)014
       stbaud015  LIKE stba_t.stbaud015, #自定義欄位(數字)015
       stbaud016  LIKE stba_t.stbaud016, #自定義欄位(數字)016
       stbaud017  LIKE stba_t.stbaud017, #自定義欄位(數字)017
       stbaud018  LIKE stba_t.stbaud018, #自定義欄位(數字)018
       stbaud019  LIKE stba_t.stbaud019, #自定義欄位(數字)019
       stbaud020  LIKE stba_t.stbaud020, #自定義欄位(數字)020
       stbaud021  LIKE stba_t.stbaud021, #自定義欄位(日期時間)021
       stbaud022  LIKE stba_t.stbaud022, #自定義欄位(日期時間)022
       stbaud023  LIKE stba_t.stbaud023, #自定義欄位(日期時間)023
       stbaud024  LIKE stba_t.stbaud024, #自定義欄位(日期時間)024
       stbaud025  LIKE stba_t.stbaud025, #自定義欄位(日期時間)025
       stbaud026  LIKE stba_t.stbaud026, #自定義欄位(日期時間)026
       stbaud027  LIKE stba_t.stbaud027, #自定義欄位(日期時間)027
       stbaud028  LIKE stba_t.stbaud028, #自定義欄位(日期時間)028
       stbaud029  LIKE stba_t.stbaud029, #自定義欄位(日期時間)029
       stbaud030  LIKE stba_t.stbaud030, #自定義欄位(日期時間)030
       stba010    LIKE stba_t.stba010, #合約編號
       stba011    LIKE stba_t.stba011, #幣別
       stba012    LIKE stba_t.stba012, #稅別
       stba013    LIKE stba_t.stba013, #專櫃編號/鋪位編號
       stba014    LIKE stba_t.stba014, #費用類型
       stba015    LIKE stba_t.stba015, #交款狀態
       stba000    LIKE stba_t.stba000, #程式編號
       stba016    LIKE stba_t.stba016, #交款人
       stba017    LIKE stba_t.stba017, #結算帳期
       stba018    LIKE stba_t.stba018, #結算日期
       stba019    LIKE stba_t.stba019, #開始日期
       stba020    LIKE stba_t.stba020, #結束日期
       stba021    LIKE stba_t.stba021, #成本總額
       stba022    LIKE stba_t.stba022, #法人
       stba023    LIKE stba_t.stba023, #會員折扣金額
       stba024    LIKE stba_t.stba024, #no_use
       stba025    LIKE stba_t.stba025, #合約帳期
       stba026    LIKE stba_t.stba026, #計算日期
       stba027    LIKE stba_t.stba027  #促銷協議項次
             END RECORD
   DEFINE l_stbb RECORD  #費用單明細資料表
       stbbent    LIKE stbb_t.stbbent, #企業編號
       stbbunit   LIKE stbb_t.stbbunit, #應用組織
       stbbsite   LIKE stbb_t.stbbsite, #營運據點
       stbbdocno  LIKE stbb_t.stbbdocno, #單據編號
       stbbseq    LIKE stbb_t.stbbseq, #項次
       stbb001    LIKE stbb_t.stbb001, #費用編號
       stbb002    LIKE stbb_t.stbb002, #幣別
       stbb003    LIKE stbb_t.stbb003, #稅別
       stbb004    LIKE stbb_t.stbb004, #價款類別
       stbb005    LIKE stbb_t.stbb005, #起始日期
       stbb006    LIKE stbb_t.stbb006, #截止日期
       stbb007    LIKE stbb_t.stbb007, #結算會計期
       stbb008    LIKE stbb_t.stbb008, #財務會計期
       stbb009    LIKE stbb_t.stbb009, #費用金額
       stbb010    LIKE stbb_t.stbb010, #承擔對象
       stbb011    LIKE stbb_t.stbb011, #所屬品類
       stbb012    LIKE stbb_t.stbb012, #所屬部門
       stbb013    LIKE stbb_t.stbb013, #結算對象
       stbb014    LIKE stbb_t.stbb014, #財務會計期別
       stbb015    LIKE stbb_t.stbb015, #納入結算單否
       stbb016    LIKE stbb_t.stbb016, #票扣否
       stbb017    LIKE stbb_t.stbb017, #備註
       stbb018    LIKE stbb_t.stbb018, #結算帳期
       stbb019    LIKE stbb_t.stbb019, #結算日期
       stbb020    LIKE stbb_t.stbb020, #日結成本類型
       stbb021    LIKE stbb_t.stbb021, #調整日期
       stbb022    LIKE stbb_t.stbb022, #商品編號
       stbb023    LIKE stbb_t.stbb023, #庫區編號
       stbb024    LIKE stbb_t.stbb024, #专柜编号
       stbb025    LIKE stbb_t.stbb025, #應收金額
       stbb026    LIKE stbb_t.stbb026, #實收金額
       stbb027    LIKE stbb_t.stbb027, #費率
       stbb028    LIKE stbb_t.stbb028, #成本金額
       stbb029    LIKE stbb_t.stbb029, #促銷銷售額
       stbb030    LIKE stbb_t.stbb030, #費用歸屬類型
       stbb031    LIKE stbb_t.stbb031, #費用歸屬組織
       stbb032    LIKE stbb_t.stbb032, #銷售數量
       stbb033    LIKE stbb_t.stbb033  #銷售單位
             END RECORD
   #161104-00024#1-add(e)
   DEFINE l_seq                LIKE type_t.num10
   DEFINE l_cnt                LIKE type_t.num5
   DEFINE l_count              LIKE type_t.num5
   DEFINE l_n                  LIKE type_t.num5
   DEFINE l_ooef017            LIKE ooef_t.ooef017
   DEFINE l_stan014            LIKE stan_t.stan014
   DEFINE l_ooag003            LIKE ooag_t.ooag003      #add by chenhz 15/11/17
   DEFINE l_apdd014          LIKE apdd_t.apdd014  #add by chenhz 15/11/17
   DEFINE l_apdd013          LIKE apdd_t.apdd013  #add by chenhz 15/11/17  
   DEFINE l_apdd018          LIKE apdd_t.apdd018  #add by chenhz 15/11/17  
   DEFINE l_apdd016          LIKE apdd_t.apdd016  #add by chenhz 15/11/17  
   DEFINE l_apdd017          LIKE apdd_t.apdd017  #add by chenhz 15/11/17
   DEFINE l_apddorga         LIKE apdd_t.apddorga #add BY chenhz 15/12/09 

   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   CALL cl_err_collect_init()
   LET g_success = TRUE
   
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF
   
   LET l_sql = "SELECT DISTINCT apcadocno,apcald,apca057,apdd001,apdd002,apdd007,apdd005,apddorga",
               "  FROM apca_t,apdd_t",
               " WHERE apcaent=apddent AND apcald=apddld AND apcadocno=apdddocno",
               "   AND apddent= ",g_enterprise,
          #     "   AND apddsite='",g_master.apddsite,"'",  mark by chenhz aapp832单头的门店，法人不起作用
          #     "   AND apddcomp='",g_master.apddcomp,"'",
               "   AND apdd011='N' ",
               "   AND ",g_master.wc,
               "   and apcastus = 'Y' ",#add by chenhz 15/11/17： 只有capt332中以审核的单据才能批量产生
               " ORDER BY apcadocno,apcald,apca057,apdd001,apdd002,apdd007,apdd005"
      
   PREPARE aapp832_sel_pr FROM l_sql
   DECLARE aapp832_sel_cs CURSOR WITH HOLD FOR aapp832_sel_pr
   LET l_count=0  #记录插入的费用单笔数
   FOREACH aapp832_sel_cs INTO l_apcadocno,l_apcald,l_apca057,l_apdd001,l_apdd002,l_apdd007,l_apdd005,l_apddorga
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aapp832_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
      END IF
       
        
      #费用单单头
      INITIALIZE l_stba.* TO NULL
      LET l_stba.stbaent = g_enterprise
     # LET l_stba.stbasite = g_master.apddsite #mark by chenhz不根据aapp832单头的门店，直接根据apddorga产生门店
     # LET l_stba.stbaunit = g_master.apddsite
      LET l_stba.stbasite = l_apddorga
      LET l_stba.stbaunit = l_apddorga
      LET l_stba.stbadocdt = g_master.stbadocdt
      
      #单号
      CALL s_aooi200_gen_docno(g_site,g_master.stbadocno,l_stba.stbadocdt,'astt320') RETURNING l_success,l_stba.stbadocno
      #供应商
      LET l_stba.stba002 = l_apdd001
      #合同
      LET l_stba.stba010 = l_apdd002
      #结算中心/经营方式/结算方式/结算类型  抓合同astm301
      SELECT distinct stan015,stan002,stan009,stan010 
        INTO l_stba.stba001,l_stba.stba003,l_stba.stba004,l_stba.stba005
        FROM stan_t
       WHERE stanent=g_enterprise 
         AND stan001=l_apdd002
      
      #来源类型
      LET l_stba.stba006 = '131'
      #来源单号
      LET l_stba.stba007 = l_apcadocno
      #人员
      LET l_stba.stba008 = l_apca057
      #部门
      SELECT ooag003 INTO l_stba.stba009 FROM ooag_t WHERE ooagent=g_enterprise AND ooag001=l_stba.stba008
      #币别
      LET l_stba.stba011 = l_apdd005
      #税别
      LET l_stba.stba012 = l_apdd007
      #专柜编号
      #如果合同编号的经营方式为扣率代销，则说明要写入专柜编号
      IF l_stba.stba003 = '3' THEN
      #LET l_stba.stba013
      END IF
      #费用类型
      LET l_stba.stba014 ='1'
      #交款状态
      LET l_stba.stba015 = 'N'
      #程序编号
      LET l_stba.stba000 = 'astt320'
      LET l_stba.stbastus = 'Y'          #modify by chenhz 15/11/17 插入的时候默认审核状态为Y
      LET l_stba.stbaownid = g_user
      LET l_stba.stbaowndp = g_dept
      LET l_stba.stbacrtid = g_user
      LET l_stba.stbacrtdp = g_dept
      LET l_stba.stbacrtdt = cl_get_current()
      
#add by chenhz 15/11/17(s) 根据合同astm301带出签订法人，签订人员，人员部门
       SELECT DISTINCT stan014,stan038 INTO l_stba.stba008,l_stba.stba009 #法人，签订人员，人员部门
         FROM stan_t
        WHERE stan005 = l_stba.stba002   
         # AND stanunit = l_stba.stbasite
          AND stanent = l_stba.stbaent 
          and stan029 = '3' #有效合同
#add by chenhz 15/11/17(e)       
#add by chenhz 15/12/14(s) 法人不抓合同，根据capt332单身门店去抓取       
       SELECT ooef017 INTO l_ooef017
         FROM ooef_t 
        WHERE ooef001 = l_stba.stbasite
          AND ooefent = g_enterprise
#add by chenhz 15/12/14(e)

      INSERT INTO stba_t(stbaent,stbasite,stbaunit,stbadocno,stbadocdt,
                         stba001,stba002,stba003,stba004,stba005,
                         stba006,stba007,stba008,stba009,stba010,
                         stba011,stba012,stba013,stba014,stba015,
                         stba000,stbastus,
                         stbaownid,stbaowndp,stbacrtid,stbacrtdp,stbacrtdt,
                         stba022)                                        #add by chenhz 15/11/17 添加法人，人员，部门
      VALUES(l_stba.stbaent,l_stba.stbasite,l_stba.stbaunit,l_stba.stbadocno,l_stba.stbadocdt,
             l_stba.stba001,l_stba.stba002, l_stba.stba003, l_stba.stba004,  l_stba.stba005,
             l_stba.stba006,l_stba.stba007, l_stba.stba008, l_stba.stba009,  l_stba.stba010,
             l_stba.stba011,l_stba.stba012, l_stba.stba013, l_stba.stba014,  l_stba.stba015,
             l_stba.stba000,l_stba.stbastus,
             l_stba.stbaownid,l_stba.stbaowndp,l_stba.stbacrtid,l_stba.stbacrtdp,l_stba.stbacrtdt,
             l_ooef017)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "ins stba_t "
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE
      END IF
     
      #费用单单身
      LET l_sql="SELECT apdd003,apdd012,SUM(apdd009),apdd014,apdd013,apdd018,apdd016,apdd017,apddorga  ",  #add by chenhz 15/11/17 apdd014,apdd013,apdd018,apdd016,apdd017,apdd014  
                "  FROM apdd_t ",
                " WHERE apddent=",g_enterprise," AND apdddocno='",l_apcadocno,"' AND apddld='",l_apcald,"'",
                #"   AND apddsite='",g_master.apddsite,"'",mark by chenhz aapp832单头的门店，法人不起作用
                #"   AND apddcomp='",g_master.apddcomp,"'",mark by chenhz aapp832单头的门店，法人不起作用
                "   AND apdd001='",l_apdd001,"' AND apdd002='",l_apdd002,"'",
                "   AND apdd005='",l_apdd005,"' AND apdd007='",l_apdd007,"'",
                "   AND apdd011='N' ",
                " GROUP BY apdd003,apdd012,apdd014,apdd013,apdd018,apdd016,apdd017,apddorga ",
                " ORDER BY apdd003,apdd012,apdd014,apdd013,apdd018,apdd016,apdd017,apddorga"
      PREPARE aapp832_sel_pr2 FROM l_sql
      DECLARE aapp832_sel_cs2 CURSOR WITH HOLD FOR aapp832_sel_pr2
      LET l_seq = 1
      FOREACH aapp832_sel_cs2 INTO l_apdd003,l_apdd012,l_apdd009,l_apdd014,l_apdd013,l_apdd018,l_apdd016,l_apdd017,l_apddorga
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:aapp832_sel_cs2"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF
         
#add by chenhz 15/11/17(s) 不允许capt332中，单号、供应商、费用编号、金额相同的数据产生      
     LET l_n = 0     
     SELECT count(*) INTO l_n FROM stba_t,stbb_t
      WHERE stba007 = l_apcadocno   #来源单号
        AND stba002 = l_apdd001   #供应商
        AND stbb001 = l_apdd003   #费用编号
        AND stbb009 = l_apdd009   #金额
        AND stbb017 = l_apdd014   #备注
        AND stbadocno = stbbdocno
        and stbastus = 'Y'
        
     IF l_n > 0 THEN 
        CONTINUE FOREACH
     END IF
 #add by chenhz 15/11/17(e)          
         
         #费用单单身
         INITIALIZE l_stbb.* TO NULL
         LET l_stbb.stbbent = l_stba.stbaent
         LET l_stbb.stbbsite = l_apddorga
         LET l_stbb.stbbunit = l_stba.stbaunit
         LET l_stbb.stbbdocno = l_stba.stbadocno
         LET l_stbb.stbbseq = l_seq
         #费用编号
         LET l_stbb.stbb001 = l_apdd003
         #币别
         LET l_stbb.stbb002 = l_apdd005
         #税别
         LET l_stbb.stbb003 = l_apdd007
         #价款类别/纳入结算单否/票扣否
         SELECT stae006,stae011,stae007 INTO l_stbb.stbb004,l_stbb.stbb015,l_stbb.stbb016
           FROM stae_t
          WHERE staeent=g_enterprise AND stae001=l_apdd003 AND staestus='Y'
         #起始日期
         LET l_stbb.stbb005 = l_stba.stbadocdt
         #截止日期
         LET l_stbb.stbb006 = l_stba.stbadocdt
         #结算会计期/#财务会计年度/l_stbb.stbb014
         CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,'astt320')
         RETURNING l_success,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb014
         #费用金额
         LET l_stbb.stbb009 = l_apdd009
         #承担对象
         LET l_stbb.stbb010 = '1'
         #所属品类
         LET l_stbb.stbb011 = l_apdd012
         #所属部门
         LET l_stbb.stbb012 = ''
         #结算对象
         LET l_stbb.stbb013 = '1'
         #含发票否
#         SELECT stajud001 INTO l_stbb.stbbud001 FROM staj_t   #mark by chenhz 15/11/17
#          WHERE stajent=g_enterprise AND staj001=l_apdd002

          
         INSERT INTO stbb_t(stbbent,stbbsite,stbbunit,stbbdocno,stbbseq,
                            stbb001,stbb002,stbb003,stbb004,stbb005,
                            stbb006,stbb007,stbb008,stbb009,stbb010,
                            stbb011,stbb012,stbb013,stbb014,stbb015,
                            stbb016,stbbud001,stbb017,stbb019)                         #add  by chenhz 15/11/17添加stbb017,stbb019
         VALUES(l_stbb.stbbent,l_stbb.stbbsite,l_stbb.stbbunit,l_stbb.stbbdocno,l_stbb.stbbseq,
                l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,l_stbb.stbb005,
                l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,
                l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,l_stbb.stbb014,l_apdd016,
                l_apdd017,l_apdd018,l_apdd014,l_apdd013)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins stbb_t "
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE
         END IF
         #更新apdd_t对应的抛转否=Y
         UPDATE apdd_t SET apdd011='Y'
          WHERE apddent=g_enterprise AND apddld=l_apcald AND apdddocno=l_apcadocno
          #  AND apddsite=g_master.apddsite AND apddcomp=g_master.apddcomp mark by chenhz aapp832单头的门店，法人不起作用
            AND apdd001=l_apdd001 AND apdd002=l_apdd002
            AND apdd005=l_apdd005 AND apdd007=l_apdd007
            AND apdd003=l_apdd003 AND apdd012=l_apdd012
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "upd apdd_t "
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE
         END IF
         LET l_seq = l_seq + 1
            
      END FOREACH
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM stbb_t
       WHERE stbbent=g_enterprise AND stbbdocno=l_stbb.stbbdocno
      #没有单身资料时，删除单头资料
      IF l_cnt = 0 THEN
         DELETE FROM stba_t WHERE stbaent=l_stba.stbaent AND stbadocno=l_stba.stbadocno
      ELSE
         LET l_count = l_count + 1
         CALL aapp832_confirmed(l_stba.stbadocno,l_stba.stbastus)   #将数据写进结算底稿中（参考astt320中点击"审核"的操作）  
      END IF
      

       
   END FOREACH
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "agl-00167"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = FALSE
   END IF
   
   IF g_success = FALSE THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF

   CALL cl_err_collect_show()
END FUNCTION

################################################################################
# Descriptions...: aapp832跑批次状态默认为审核并且写进结算底稿中
# Date & Author..: 15/11/18 By chenhz
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp832_confirmed(l_stbadocno,l_stbastus)
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_errno        LIKE type_t.chr100
   DEFINE l_stbacnfdt    LIKE stba_t.stbacnfdt
   DEFINE l_stbamoddt    LIKE stba_t.stbamoddt
   DEFINE l_stbamodid    LIKE stba_t.stbamodid
   define l_stbadocno    like stba_t.stbadocno
   define l_stbastus     like stba_t.stbastus
   
   LET l_success = TRUE
   LET l_stbacnfdt = cl_get_current()
   LET l_stbamoddt = cl_get_current()
 #     CALL s_transaction_begin()  #事务开始
      
         CALL s_astt320_conf_chk(l_stbadocno,l_stbastus) RETURNING l_success,l_errno
         
         # IF l_success THEN
         #   IF cl_ask_confirm('lib-014') THEN   呼叫确认审核的弹窗
               #150527-00027#1 add by geza (S)
               #astt320审核更新结算底稿，astt322,astt323不更新
         #      IF g_type = '1' THEN
              #     CALL s_transaction_begin()
                   CALL s_astt320_conf_upd(l_stbadocno,l_stbastus) RETURNING l_success,l_errno
                   UPDATE stba_t SET stbacnfid = g_user,
                                     stbacnfdt = l_stbacnfdt
                    WHERE stbaent = g_enterprise 
                      AND stbadocno = l_stbadocno
                      
                   IF NOT l_success THEN
               #       CALL s_transaction_end('N','0')
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = l_errno
                      LET g_errparam.extend = l_stbadocno
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   
                      RETURN
                   ELSE
            #          CALL s_transaction_end('Y','1')
                   END IF
       #        END IF 
  
   LET l_stbamodid = g_user
   LET l_stbamoddt = cl_get_current()

   
   #異動修改人/修改日期
   UPDATE stba_t 
      SET (stbamodid,stbamoddt) 
        = (l_stbamodid,l_stbamoddt)     
    WHERE stbaent = g_enterprise 
      AND stbadocno = l_stbadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
 #   CALL s_transaction_end('Y','0')
  END IF  
END FUNCTION

#end add-point
 
{</section>}
 
