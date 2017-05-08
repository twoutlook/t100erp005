#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp802.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-08-05 14:50:42), PR版次:0001(2016-09-02 12:52:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000011
#+ Filename...: anmp802
#+ Description: 資金自動計息作業
#+ Creator....: 01531(2016-08-04 13:49:07)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="anmp802.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
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
       nmbc002 LIKE nmbc_t.nmbc002, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   ar LIKE type_t.num20_6, 
   d LIKE type_t.num10, 
   cin LIKE type_t.chr10, 
   cin_desc LIKE type_t.chr80, 
   tout LIKE type_t.chr10, 
   tout_desc LIKE type_t.chr80, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_sql_bank        STRING             
DEFINE g_para_date       LIKE type_t.dat      
DEFINE g_site_str        STRING     
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_nmbc002_str     STRING 
DEFINE g_glaa001     LIKE glaa_t.glaa001
DEFINE g_glaald      LIKE glaa_t.glaald
DEFINE g_glaa004     LIKE glaa_t.glaa004
DEFINE g_glaa005     LIKE glaa_t.glaa005 
DEFINE g_ooef006     LIKE ooef_t.ooef006
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa016     LIKE glaa_t.glaa016
DEFINE g_glaa017     LIKE glaa_t.glaa017
DEFINE g_glaa018     LIKE glaa_t.glaa018
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_glaa020     LIKE glaa_t.glaa020
DEFINE g_glaa021     LIKE glaa_t.glaa021
DEFINE g_glaa022     LIKE glaa_t.glaa022
DEFINE g_glaa003     LIKE glaa_t.glaa003   #会计周期参照表号   
DEFINE g_glaa024     LIKE glaa_t.glaa024   #单据别参照表号 
DEFINE g_str         STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmp802.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL anmp802_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp802 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmp802_init()
 
      #進入選單 Menu (="N")
      CALL anmp802_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp802
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp802.init" >}
#+ 初始化作業
PRIVATE FUNCTION anmp802_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_ooef017 LIKE ooef_t.ooef017  
   DEFINE l_glaa003 LIKE glaa_t.glaa003
   DEFINE l_yy      LIKE type_t.num5
   DEFINE l_mm      LIKE type_t.num5   
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
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-4007') RETURNING g_para_date

   SELECT glaald INTO g_glaald FROM glaa_t WHERE glaaent = g_enterprise AND glaa014 = 'Y' AND glaacomp = 
   (SELECT ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site)
   CALL s_fin_date_get_period_value('',g_glaald,g_today)RETURNING g_sub_success,l_yy,l_mm
      
   SELECT glaa003 INTO l_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
      
   CALL s_fin_date_get_period_range(l_glaa003,l_yy,l_mm) RETURNING g_master.bdate,g_master.edate

   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site 
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-4015') RETURNING g_master.ar   #年利率
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-4016') RETURNING g_master.d    #计算天数
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-4008') RETURNING g_master.cin  #存提码存入 
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-4009') RETURNING g_master.tout #存提码提取
   CALL anmp802_desc(g_master.cin) RETURNING g_master.cin_desc
   CALL anmp802_desc(g_master.tout) RETURNING g_master.tout_desc
   DISPLAY g_master.cin_desc TO cin_desc
   DISPLAY g_master.tout_desc TO tout_desc
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp802.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp802_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cin_t     LIKE type_t.chr10
   DEFINE l_tout_t    LIKE type_t.chr10
   DEFINE l_cnt       LIKE type_t.num5     
   DEFINE l_yy_b      LIKE type_t.num5
   DEFINE l_yy_e      LIKE type_t.num5
   DEFINE l_mm_b      LIKE type_t.num5
   DEFINE l_mm_e      LIKE type_t.num5 
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_yy        LIKE type_t.num5
   DEFINE l_mm        LIKE type_t.num5   
   DEFINE l_bdate     LIKE type_t.dat    
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bdate,g_master.edate,g_master.ar,g_master.d,g_master.cin,g_master.tout, 
             g_master.nmbadocno 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            IF NOT cl_null(g_master.bdate) THEN 
               IF g_master.bdate < g_para_date THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03011'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bdate = g_today
                  DISPLAY BY NAME g_master.bdate
                  NEXT FIELD bdate               
               END IF
               
               CALL s_fin_date_get_period_value('',g_glaald,g_master.bdate)RETURNING g_sub_success,l_yy,l_mm
                  
               SELECT glaa003 INTO l_glaa003 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_glaald
                  
               CALL s_fin_date_get_period_range(l_glaa003,l_yy,l_mm) RETURNING l_bdate,g_master.edate
               DISPLAY g_master.edate TO edate    
               
               IF NOT cl_null(g_master.edate) THEN
                  IF g_master.edate < g_master.bdate THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00063'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bdate = g_today
                     DISPLAY BY NAME g_master.bdate
                     NEXT FIELD bdate               
                  END IF
                  LET l_yy_b = YEAR(g_master.bdate) 
                  LET l_yy_e = YEAR(g_master.edate)  
                  LET l_mm_b = MONTH(g_master.bdate) 
                  LET l_mm_e = MONTH(g_master.edate)
                  IF l_yy_b <> l_yy_e OR l_mm_b <> l_mm_e THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03015'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bdate = g_today
                     DISPLAY BY NAME g_master.bdate
                     NEXT FIELD bdate                    
                  END IF                  
               END IF
               LET g_master.edate = s_date_get_last_date(g_master.bdate)  
               DISPLAY g_master.edate TO edate
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            IF NOT cl_null(g_master.edate) OR cl_null(g_master.bdate) THEN     
               IF g_master.edate < g_master.bdate THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD edate               
               END IF               
               LET l_yy_b = YEAR(g_master.bdate) 
               LET l_yy_e = YEAR(g_master.edate)  
               LET l_mm_b = MONTH(g_master.bdate) 
               LET l_mm_e = MONTH(g_master.edate)
               IF l_yy_b <> l_yy_e OR l_mm_b <> l_mm_e THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03015'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD edate                    
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ar
            #add-point:BEFORE FIELD ar name="input.b.ar"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ar
            
            #add-point:AFTER FIELD ar name="input.a.ar"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ar
            #add-point:ON CHANGE ar name="input.g.ar"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD d
            #add-point:BEFORE FIELD d name="input.b.d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD d
            
            #add-point:AFTER FIELD d name="input.a.d"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE d
            #add-point:ON CHANGE d name="input.g.d"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cin
            
            #add-point:AFTER FIELD cin name="input.a.cin"
            IF NOT cl_null(g_master.cin) THEN 
               #應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.cin
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
             
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL anmp802_desc(g_master.cin) RETURNING g_master.cin_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.cin = l_cin_t 
                  DISPLAY g_master.cin TO cin                 
                  CALL anmp802_desc(g_master.cin) RETURNING g_master.cin_desc
                  NEXT FIELD CURRENT
               END IF
               CALL anmp802_desc(g_master.cin) RETURNING g_master.cin_desc

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cin
            #add-point:BEFORE FIELD cin name="input.b.cin"
            IF NOT cl_null(g_master.cin) THEN 
               LET l_cin_t = g_master.cin 
            END IF   
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cin
            #add-point:ON CHANGE cin name="input.g.cin"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD tout
            
            #add-point:AFTER FIELD tout name="input.a.tout"
            IF NOT cl_null(g_master.tout) THEN 
               #應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.tout
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
             
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL anmp802_desc(g_master.tout) RETURNING g_master.tout_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.tout = l_tout_t  
                  DISPLAY g_master.tout TO tout  
                  CALL anmp802_desc(g_master.tout) RETURNING g_master.tout_desc
                  NEXT FIELD CURRENT
               END IF
               CALL anmp802_desc(g_master.tout) RETURNING g_master.tout_desc

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD tout
            #add-point:BEFORE FIELD tout name="input.b.tout"
            IF NOT cl_null(g_master.tout) THEN 
               LET l_tout_t = g_master.tout 
            END IF   
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE tout
            #add-point:ON CHANGE tout name="input.g.tout"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocno
            #add-point:BEFORE FIELD nmbadocno name="input.b.nmbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocno
            
            #add-point:AFTER FIELD nmbadocno name="input.a.nmbadocno"
            IF NOT cl_null(g_master.nmbadocno) THEN    
               #是否可以使用单别
               SELECT COUNT(*) INTO l_cnt FROM oobl_t
                WHERE ooblent = g_enterprise
                  AND oobl001 = g_master.nmbadocno
                  AND oobl002 = 'anmt310'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00250'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = 'anmt310'
                  LET g_errparam.replace[2] = g_master.nmbadocno
                  CALL cl_err()
                  NEXT FIELD nmbadocno                 
               END IF 
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbadocno
            #add-point:ON CHANGE nmbadocno name="input.g.nmbadocno"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.ar
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ar
            #add-point:ON ACTION controlp INFIELD ar name="input.c.ar"
            
            #END add-point
 
 
         #Ctrlp:input.c.d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD d
            #add-point:ON ACTION controlp INFIELD d name="input.c.d"
            
            #END add-point
 
 
         #Ctrlp:input.c.cin
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cin
            #add-point:ON ACTION controlp INFIELD cin name="input.c.cin"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.cin
            LET g_qryparam.where = " nmaj002 = '1'"
            CALL q_nmaj001()
            LET g_master.cin = g_qryparam.return1
            CALL anmp802_desc(g_master.cin)  RETURNING g_master.cin_desc                    
            DISPLAY g_master.cin TO cin
            DISPLAY g_master.cin_desc TO cin_desc   
            NEXT FIELD cin
            #END add-point
 
 
         #Ctrlp:input.c.tout
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD tout
            #add-point:ON ACTION controlp INFIELD tout name="input.c.tout"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.tout
            LET g_qryparam.where = " nmaj002 = '2'"
            CALL q_nmaj001()
            LET g_master.tout = g_qryparam.return1
            CALL anmp802_desc(g_master.tout)  RETURNING g_master.tout_desc                    
            DISPLAY g_master.tout TO tout
            DISPLAY g_master.tout_desc TO tout_desc   
            NEXT FIELD tout
            #END add-point
 
 
         #Ctrlp:input.c.nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno
            #add-point:ON ACTION controlp INFIELD nmbadocno name="input.c.nmbadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.nmbadocno             #給予default值
            SELECT glaa024 INTO g_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_site AND glaa014 = 'Y'
            #給予arg
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'anmt310'" 

 
            CALL q_ooba002_4()                                #呼叫開窗
 
            LET g_master.nmbadocno = g_qryparam.return1              

            DISPLAY g_master.nmbadocno TO nmbadocno              #

            NEXT FIELD nmbadocno                          #返回原欄位



            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON nmbc002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.nmbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbc002
            #add-point:ON ACTION controlp INFIELD nmbc002 name="construct.c.nmbc002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING g_site_str         
            LET g_site_str = cl_replace_str(g_site_str,"ooef001","nmaa002")     
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_site_str CLIPPED," AND nmas002 IN (",g_sql_bank,") ",    
                                   " AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')"  #160326-00001#27
                                   
            CALL q_nmas001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbc002  #顯示到畫面上
            NEXT FIELD nmbc002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbc002
            #add-point:BEFORE FIELD nmbc002 name="construct.b.nmbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbc002
            
            #add-point:AFTER FIELD nmbc002 name="construct.a.nmbc002"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_nmbc002_str
            LET g_nmbc002_str = cl_replace_str(g_nmbc002_str,"|","','")           
            CALL s_axrt300_get_site(g_user,'','1') RETURNING g_site_str 
            LET g_site_str = cl_replace_str(g_site_str,"ooef001","nmaa002")  
            IF g_nmbc002_str = "*" THEN
               LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
                           "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str,
                           "    AND nmas002 IN (",g_sql_bank,") ",  
                           "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')"
            ELSE
               LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
                           "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str," AND nmas002 IN ('",g_nmbc002_str,"') ",  
                           "    AND nmas002 IN (",g_sql_bank,") ",  
                           "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')"            
            END IF
            PREPARE anmp802_count_pre FROM g_sql
            EXECUTE anmp802_count_pre INTO l_cnt 
            IF l_cnt = 0 THEN 
               DISPLAY '' TO nmbc002
               NEXT FIELD nmbc002               
            END IF  
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
            CALL anmp802_get_buffer(l_dialog)
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
         CALL anmp802_init()
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
                 CALL anmp802_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = anmp802_transfer_argv(ls_js)
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
 
{<section id="anmp802.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION anmp802_transfer_argv(ls_js)
 
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
 
{<section id="anmp802.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION anmp802_process(ls_js)
 
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
#  DECLARE anmp802_process_cs CURSOR FROM ls_sql
#  FOREACH anmp802_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL anmp802_p()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL anmp802_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="anmp802.get_buffer" >}
PRIVATE FUNCTION anmp802_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
   LET g_master.ar = p_dialog.getFieldBuffer('ar')
   LET g_master.d = p_dialog.getFieldBuffer('d')
   LET g_master.cin = p_dialog.getFieldBuffer('cin')
   LET g_master.tout = p_dialog.getFieldBuffer('tout')
   LET g_master.nmbadocno = p_dialog.getFieldBuffer('nmbadocno')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmp802.msgcentre_notify" >}
PRIVATE FUNCTION anmp802_msgcentre_notify()
 
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
 
{<section id="anmp802.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 存提码说明
# Memo...........:
# Usage..........: CALL anmp802_desc(p_str)
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_desc(p_str)
DEFINE p_str   LIKE  type_t.chr10
DEFINE p_desc  STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_str
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET p_desc = '', g_rtn_fields[1] , ''
   RETURN p_desc 
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp802_p()
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_p()
   DEFINE l_str1    LIKE type_t.chr500
   DEFINE l_str2    LIKE type_t.chr500 

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   
   LET g_coll_title[1] = cl_getmsg('anm-03016',g_dlang)
   LET g_coll_title[2] = cl_getmsg('afa-00211',g_dlang)
   LET g_coll_title[3] = cl_getmsg('aap-00154',g_dlang)  

   
   LET g_success = TRUE
   
   CALL s_transaction_begin()

   #检查内部银行资料权限，汇总报错显示 
   CALL anmp802_chk()
   
   CALL anmp802_pr()  RETURNING g_success 
   
   IF g_success = TRUE THEN 
#      LET l_str1 = NULL
#      LET l_str2 = NULL
#      LET g_sql = " SELECT DISTINCT nmbadocno FROM nmba_t WHERE nmbaent = '",g_enterprise,"'", 
#                  "    AND nmba003 = 'anmp802' ",
#                  "    AND nmbadocdt = '",g_master.edate,"'"
#                                    
#      PREPARE anmp802_nmba_prep FROM g_sql
#      DECLARE anmp802_nmba_curs CURSOR FOR anmp802_nmba_prep
#      FOREACH anmp802_nmba_curs INTO l_str1
#         LET l_str2 = l_str1," ",l_str2
#      END FOREACH  
      
      CALL s_transaction_end('Y','0')
      #显示产生的anmt310单据编号
      IF NOT cl_null(g_str) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-00322'
         LET g_errparam.extend = g_str
         LET g_errparam.popup = TRUE
         CALL cl_err()  
      END IF          
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()
 
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmp802_chk()
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_chk()
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5  
DEFINE l_nmas002   LIKE nmas_t.nmas002

   IF cl_null(g_master.wc) THEN
      LET g_wc = " 1=1"
      LET g_master.wc = " 1=1"
   END IF
   
   LET g_wc = cl_replace_str(g_master.wc,"nmbc002","nmas002")
   
   IF g_nmbc002_str = "*"  THEN 
      LET g_sql = " SELECT nmas002 FROM nmas_t,nmaa_t ",
                  "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",
                  "    AND ",g_site_str, #azzi800使用据点权限
                  "    AND nmas002 IN (",g_sql_bank,") ",  #anmi120用户&部门权限
                  "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')",#开户银行为有效的内部银行
                  "    AND ",g_wc CLIPPED 
   ELSE               
      LET g_sql = " SELECT nmas002 FROM nmas_t,nmaa_t ",
                  "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",
                  "    AND ",g_wc CLIPPED 
   END IF             
   PREPARE anmp802_nmas002_pre FROM g_sql 
   DECLARE anmp802_nmas002_cur CURSOR FOR anmp802_nmas002_pre
   FOREACH anmp802_nmas002_cur INTO l_nmas002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmas002:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF 

      IF g_nmbc002_str <> "*" THEN
         #基础检查
         CALL anmp802_chk_nmas002(l_nmas002) RETURNING l_success
      END IF
 
   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp802_chk_nmas002(p_nmas002)
# Input parameter:  
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_chk_nmas002(p_nmas002)
DEFINE p_nmas002   LIKE nmas_t.nmas002
DEFINE l_cnt       LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
   LET r_success = TRUE   
   
   
   
   #交易账户是否存在
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ", 
               "  AND nmasent = '",g_enterprise,"' AND nmas002 = '",p_nmas002,"'"
   PREPARE anmp802_chk_pre1 FROM g_sql
   EXECUTE anmp802_chk_pre1 INTO l_cnt    
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'ade-00009'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      LET r_success = FALSE
      RETURN r_success    
   END IF
   
   #交易账户是否有效
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ", 
               "  AND nmasent = '",g_enterprise,"' AND nmas002 = '",p_nmas002,"' AND nmaastus = 'Y'"
   PREPARE anmp802_chk_pre2 FROM g_sql
   EXECUTE anmp802_chk_pre2 INTO l_cnt    
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-03013'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET r_success = FALSE      
      RETURN r_success           
   END IF   
   
   #交易账户对应的开户银行是否是内部银行
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ",
               "    AND nmasent = '",g_enterprise,"' AND nmas002 = '",p_nmas002,"' AND nmaastus = 'Y'",
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0' AND nmab001 = nmaa004)"
   PREPARE anmp802_chk_pre3 FROM g_sql
   EXECUTE anmp802_chk_pre3 INTO l_cnt 
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-00250'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE      
      RETURN r_success        
   END IF 
   
   #g_user是否有azzi800权限
   LET l_cnt = 0 
   LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
               "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str,
               "    AND nmas002 = '",p_nmas002,"'",  
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0' AND nmab001 = nmaa004)"
   PREPARE anmp802_chk_pre4 FROM g_sql
   EXECUTE anmp802_chk_pre4 INTO l_cnt 
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-03014'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      LET r_success = FALSE 
      RETURN r_success          
   END IF                
   
   #g_user是否有交易账户权限
   LET l_cnt = 0 
   LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
               "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str,
               "    AND nmas002 = '",p_nmas002,"'",  
               "    AND nmas002 IN (",g_sql_bank,") ", 
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0' AND nmab001 = nmaa004)"
   PREPARE anmp802_chk_pre5 FROM g_sql
   EXECUTE anmp802_chk_pre5 INTO l_cnt 
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-00574'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE 
      RETURN r_success          
   END IF     
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp802_chk_anmt310(p_nmas002)
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_chk_anmt310(p_nmas002)
#日期范围（当月,不跨月）+内部账户检查内部利息是否已计提
#若已计提过则汇总报错,未计提的继续执行
DEFINE r_success LIKE type_t.num5
DEFINE l_nmbb003 LIKE nmbb_t.nmbb003
DEFINE l_nmbbdocno LIKE nmbb_t.nmbbdocno
DEFINE l_nmbadocdt LIKE nmba_t.nmbadocdt
DEFINE p_nmas002   LIKE nmas_t.nmas002
DEFINE l_first_day LIKE nmbc_t.nmbc005


   LET r_success = TRUE
   LET l_first_day = s_date_get_first_date(g_master.bdate)
   LET g_sql = " SELECT DISTINCT nmbb003,nmbadocdt,nmbbdocno FROM nmba_t,nmbb_t ", 
               "  WHERE nmbaent = nmbbent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", 
               "    AND nmbadocdt > '",g_master.bdate,"' AND nmbadocdt >= '",l_first_day,"' AND nmba003 ='anmp802' ", #anmp802
               "    AND nmbb003 = '",p_nmas002,"'"  
   PREPARE anmp802_nmbb_pre FROM g_sql 
   DECLARE anmp802_nmbb_cur CURSOR FOR anmp802_nmbb_pre

   
   FOREACH anmp802_nmbb_cur INTO l_nmbb003,l_nmbadocdt,l_nmbbdocno
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbb:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_nmbb003) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-03012'
         LET g_errparam.popup = TRUE
         #LET g_errparam.replace[1] = ""
         LET g_errparam.coll_vals[1] = l_nmbb003
         LET g_errparam.coll_vals[2] = l_nmbadocdt
         LET g_errparam.coll_vals[3] = l_nmbbdocno
         #LET g_errparam.sqlerr = 0 #(有需要再設定，0則不顯示)
         LET r_success = FALSE
         CALL cl_err()      
      END IF
      
   END FOREACH
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp802_create_tmp()
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_create_tmp()
DROP TABLE anmp802_tmp;
 CREATE TEMP TABLE anmp802_tmp(
     nmbccomp    VARCHAR(10),     
     nmbcorga   VARCHAR(10),     
     nmbc002    VARCHAR(10),     
     nmbc100    VARCHAR(10),     
     nmbc005    DATE,
     nmbc006    VARCHAR(1),      #cy0901     
     nmbc103    DECIMAL(20,6),    
     nmbc113    DECIMAL(20,6),
     nmbc123    DECIMAL(20,6),
     nmbc133    DECIMAL(20,6),
     qc103      DECIMAL(20,6),       #原币期初
     qc113      DECIMAL(20,6),       #本币期初
     qc123      DECIMAL(20,6),       #本位币二期初
     qc133      DECIMAL(20,6),       #本位币三期初
     bal103     DECIMAL(20,6),       #原币余额
     bal113     DECIMAL(20,6),       #本币余额
     bal123     DECIMAL(20,6),       #本位币二余额
     bal133     DECIMAL(20,6),       #本位币三余额
     ydn103     DECIMAL(20,6),       #原币当期异动
     ydn113     DECIMAL(20,6),       #本币当期异动
     ydn123     DECIMAL(20,6),       #本位币一当期异动
     ydn133     DECIMAL(20,6),       #本位币二当期异动
     acc103     DECIMAL(20,6),       #原币日息 
     acc113     DECIMAL(20,6),       #本币日息
     acc123     DECIMAL(20,6),       #本位币二日息
     acc133     DECIMAL(20,6)     #本位币三日息 
 );
 DROP TABLE anmp802_tmp2;
 CREATE TEMP TABLE anmp802_tmp2(
     nmbccomp    VARCHAR(10),     
     nmbcorga   VARCHAR(10),     
     nmbc002    VARCHAR(10),     
     nmbc100    VARCHAR(10), 
     nmbb001    VARCHAR(1),       #存入提出     
     acc103     DECIMAL(20,6),       #日息 
     acc113     DECIMAL(20,6),       #日息
     acc123     DECIMAL(20,6),       #日息
     acc133     DECIMAL(20,6)     #日息      
 );
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp802_pr()
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_pr()
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_tmp        RECORD
     nmbccomp   LIKE nmbc_t.nmbccomp,     
     nmbcorga  LIKE nmbc_t.nmbcorga,     
     nmbc002   LIKE nmbc_t.nmbc002,     
     nmbc100   LIKE nmbc_t.nmbc100,     
     nmbc005   LIKE nmbc_t.nmbc005,     
     nmbc103   LIKE nmbc_t.nmbc103,    
     nmbc113   LIKE nmbc_t.nmbc113,
     nmbc123   LIKE nmbc_t.nmbc123,
     nmbc133   LIKE nmbc_t.nmbc133,
     qc103     LIKE nmbc_t.nmbc103,  #期初
     qc113     LIKE nmbc_t.nmbc113,  #期初
     qc123     LIKE nmbc_t.nmbc123,  #期初
     qc133     LIKE nmbc_t.nmbc133,  #期初
     bal103    LIKE nmbc_t.nmbc103,  #余额
     bal113    LIKE nmbc_t.nmbc113,  #余额
     bal123    LIKE nmbc_t.nmbc123,  #余额
     bal133    LIKE nmbc_t.nmbc133,  #余额
     ydn103    LIKE nmbc_t.nmbc103,  #当期异动
     ydn113    LIKE nmbc_t.nmbc113,  #当期异动
     ydn123    LIKE nmbc_t.nmbc123,  #当期异动
     ydn133    LIKE nmbc_t.nmbc133,  #当期异动
     acc103    LIKE nmbc_t.nmbc103,  #日息 
     acc113    LIKE nmbc_t.nmbc113,  #日息
     acc123    LIKE nmbc_t.nmbc123,  #日息 
     acc133    LIKE nmbc_t.nmbc133   #日息     
                    END RECORD 
DEFINE l_nmbccomp LIKE nmbc_t.nmbccomp
DEFINE l_nmbcorga LIKE nmbc_t.nmbcorga
DEFINE l_nmbc002  LIKE nmbc_t.nmbc002
DEFINE l_nmbc100  LIKE nmbc_t.nmbc100
DEFINE l_first_day  LIKE nmbc_t.nmbc005
DEFINE l_yy       LIKE type_t.num5
DEFINE l_mm       LIKE type_t.num5
DEFINE l_yy1      LIKE type_t.num5
DEFINE l_mm1      LIKE type_t.num5
DEFINE l_dd       LIKE type_t.num5
DEFINE l_day      LIKE type_t.num5
DEFINE l_glaa003  LIKE glaa_t.glaa003
DEFINE l_edate    LIKE type_t.dat
DEFINE l_bdate    LIKE type_t.dat


   CALL anmp802_create_tmp()
   DELETE FROM anmp802_tmp
  
   LET r_success = TRUE   

   SELECT glaald INTO g_glaald FROM glaa_t WHERE glaaent = g_enterprise AND glaa014 = 'Y' AND glaacomp = 
   (SELECT ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site)
      
   #插入临时表资料   
   LET g_wc = cl_replace_str(g_master.wc,"nmbc002","nmas002")
   IF g_nmbc002_str = "*"  THEN
      LET g_sql = " SELECT DISTINCT nmbccomp,nmbcorga,nmbc002,nmbc100 ",  #cy0901
                  "   FROM nmbc_t ",
                  "  WHERE nmbc001 = 'anmp801' AND nmbcorga IN ( SELECT nmaa002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 )", #来源组织等于anmi120交易账户的开户组织
                  "    AND nmbc002 IN (SELECT nmas002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",  #交易账户是内部银行
                  "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0'))" 
   ELSE
      LET g_sql = " SELECT DISTINCT nmbccomp,nmbcorga,nmbc002,nmbc100 ", #cy0901
                  "   FROM nmbc_t ",
                  "  WHERE nmbc001 = 'anmp801' AND nmbcorga IN ( SELECT nmaa002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_wc CLIPPED,")", #来源组织等于anmi120交易账户的开户组织
                  "    AND nmbc002 IN (SELECT nmas002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",  #交易账户是内部银行
                  "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')) ",
                  "    AND ",g_master.wc CLIPPED                  
   END IF   
   PREPARE anmp802_nmbc_pre3 FROM g_sql 
   DECLARE anmp802_nmbc_cur3 CURSOR FOR anmp802_nmbc_pre3 
   FOREACH anmp802_nmbc_cur3 INTO l_nmbccomp,l_nmbcorga,l_nmbc002,l_nmbc100
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbc3:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  

 
      #检查是否已计提内部利息，汇总报错显示 
      CALL anmp802_chk_anmt310(l_nmbc002) RETURNING l_success
      
      IF l_success THEN 
           #ins tmp
           LET g_sql = " INSERT INTO anmp802_tmp ",                                                                #期初 余额 当期异动 日息
                       "    SELECT nmbccomp,nmbcorga,nmbc002,nmbc100,nmbc005,nmbc006,",  #cy0901
                       "    CASE WHEN nmbc006 = '1' THEN SUM(nmbc103) ELSE SUM(nmbc103)*(-1) END ,",
                       "    CASE WHEN nmbc006 = '1' THEN SUM(nmbc113) ELSE SUM(nmbc113)*(-1) END ,",
                       "    CASE WHEN nmbc006 = '1' THEN SUM(nmbc123) ELSE SUM(nmbc123)*(-1) END,",
                       "    CASE WHEN nmbc006 = '1' THEN SUM(nmbc133) ELSE SUM(nmbc133)*(-1) END,",
                       "           0,0,0,0, 0,0,0,0, 0,0,0,0 ,0,0,0,0 ",
                       "      FROM nmbc_t ",
                       "     WHERE nmbcent = '",g_enterprise,"'",
                       "       AND nmbccomp = '",l_nmbccomp,"'",
                       "       AND nmbcorga = '",l_nmbcorga,"'",
                       "       AND nmbc002 = '",l_nmbc002,"'",
                       "       AND nmbc100 = '",l_nmbc100,"'",
                       "       AND nmbc001 = 'anmp801' ",
                       "  GROUP BY nmbccomp,nmbcorga,nmbc002,nmbc100,nmbc005,nmbc006 "
          PREPARE anmp802_tmp_pre1 FROM g_sql
          EXECUTE anmp802_tmp_pre1 
      END IF      
         
   END FOREACH  
   
   #临时表资料更新
   LET g_sql = " SELECT nmbccomp,nmbcorga,nmbc002,nmbc100,nmbc005,nmbc103,nmbc113,nmbc123,nmbc133,",
               "        qc103,qc113,qc123,qc133,bal103,bal113,bal123,bal133,ydn103,ydn113,ydn123,ydn133,acc103,acc113,acc123,acc133  ",
               "   FROM anmp802_tmp ",
               "  ORDER BY nmbccomp,nmbcorga,nmbc005,nmbc002,nmbc100" 
   PREPARE anmp802_tmp_pre2 FROM g_sql 
   DECLARE anmp802_tmp_cur2 CURSOR FOR anmp802_tmp_pre2 
   FOREACH anmp802_tmp_cur2 INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbc3:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  

      #nmbx 期初
      LET l_yy = YEAR(l_tmp.nmbc005)
      LET l_mm = MONTH(l_tmp.nmbc005)
      LET l_dd = DAY(l_tmp.nmbc005)
            
      IF l_mm = 1 THEN 
         LET l_yy = l_yy - 1 
         LET l_mm = 12
      ELSE
         LET l_yy = l_yy
         LET l_mm = l_mm -1         
      END IF
      SELECT SUM(nmbx103-nmbx104),SUM(nmbx113-nmbx114),SUM(nmbx123-nmbx124),SUM(nmbx133-nmbx134)
        INTO l_tmp.qc103,l_tmp.qc113,l_tmp.qc123,l_tmp.qc133
        FROM nmbx_t
       WHERE nmbxent = g_enterprise AND nmbxcomp = l_tmp.nmbccomp AND nmbxorga = l_tmp.nmbcorga
         AND nmbx001 = l_yy AND nmbx002 = l_mm AND nmbx003 = l_tmp.nmbc002

      IF cl_null(l_tmp.qc103) THEN LET l_tmp.qc103 = 0 END IF
      IF cl_null(l_tmp.qc113) THEN LET l_tmp.qc113 = 0 END IF
      IF cl_null(l_tmp.qc123) THEN LET l_tmp.qc123 = 0 END IF
      IF cl_null(l_tmp.qc133) THEN LET l_tmp.qc133 = 0 END IF
      
      #nmbc 当期异动
      LET l_first_day = s_date_get_first_date(l_tmp.nmbc005)
      IF g_master.bdate <> l_first_day THEN
         SELECT CASE WHEN nmbc006='1' THEN SUM(nmbc103) ELSE SUM(nmbc103)*(-1) END , #cy0901
                CASE WHEN nmbc006='1' THEN SUM(nmbc113) ELSE SUM(nmbc113)*(-1) END ,
                CASE WHEN nmbc006='1' THEN SUM(nmbc123) ELSE SUM(nmbc123)*(-1) END ,
                CASE WHEN nmbc006='1' THEN SUM(nmbc133) ELSE SUM(nmbc133)*(-1) END 
           INTO l_tmp.ydn103,l_tmp.ydn113,l_tmp.ydn123,l_tmp.ydn133
           FROM nmbc_t WHERE nmbcent =  g_enterprise 
                         AND nmbccomp = l_tmp.nmbccomp 
                         AND nmbcorga = l_tmp.nmbcorga 
                         AND nmbc002 = l_tmp.nmbc002 
                         AND nmbc100 = l_tmp.nmbc100 
                         AND nmbc001 = 'anmp802'   
                         AND nmbc005 < g_master.bdate
                         AND nmbc005 >=l_first_day 
           GROUP BY nmbc006              
      ELSE
         LET l_tmp.ydn103 = 0 
         LET l_tmp.ydn113 = 0
         LET l_tmp.ydn123 = 0
         LET l_tmp.ydn133 = 0
      END IF   

      IF cl_null(l_tmp.ydn103) THEN LET l_tmp.ydn103 = 0 END IF
      IF cl_null(l_tmp.ydn113) THEN LET l_tmp.ydn113 = 0 END IF
      IF cl_null(l_tmp.ydn123) THEN LET l_tmp.ydn123 = 0 END IF
      IF cl_null(l_tmp.ydn133) THEN LET l_tmp.ydn133 = 0 END IF

      LET l_tmp.bal103 = l_tmp.qc103 + l_tmp.ydn103 + l_tmp.nmbc103 #余额 #cy0901
      LET l_tmp.bal113 = l_tmp.qc113 + l_tmp.ydn113 + l_tmp.nmbc113 #余额
      LET l_tmp.bal123 = l_tmp.qc123 + l_tmp.ydn123 + l_tmp.nmbc123 #余额
      LET l_tmp.bal133 = l_tmp.qc133 + l_tmp.ydn133 + l_tmp.nmbc133 #余额


      CALL s_fin_date_get_period_value('',g_glaald,l_tmp.nmbc005)RETURNING g_sub_success,l_yy1,l_mm1
         
      SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaald
         
      CALL s_fin_date_get_period_range(l_glaa003,l_yy1,l_mm1) RETURNING l_bdate,l_edate #当期起始/截止日期
      LET l_day = DAY(l_edate) - DAY(l_bdate) + 1 #当期总天数

      LET l_tmp.acc103 = (g_master.ar/g_master.d/100) * l_tmp.bal103 * (l_day-l_dd+1)
      LET l_tmp.acc113 = (g_master.ar/g_master.d/100) * l_tmp.bal113 * (l_day-l_dd+1)
      LET l_tmp.acc123 = (g_master.ar/g_master.d/100) * l_tmp.bal123 * (l_day-l_dd+1)
      LET l_tmp.acc133 = (g_master.ar/g_master.d/100) * l_tmp.bal133 * (l_day-l_dd+1)
 
      
      UPDATE anmp802_tmp SET qc103 = l_tmp.qc103,
                             qc113 = l_tmp.qc113,
                             qc123 = l_tmp.qc123,
                             qc133 = l_tmp.qc133,
                             ydn103 = l_tmp.ydn103,
                             ydn113 = l_tmp.ydn113,
                             ydn123 = l_tmp.ydn123,
                             ydn133 = l_tmp.ydn133,
                             bal103 = l_tmp.bal103,
                             bal113 = l_tmp.bal113,
                             bal123 = l_tmp.bal123,
                             bal133 = l_tmp.bal133,
                             acc103 = l_tmp.acc103,
                             acc113 = l_tmp.acc113,
                             acc123 = l_tmp.acc123,
                             acc133 = l_tmp.acc133
               WHERE nmbccomp = l_tmp.nmbccomp 
                 AND nmbcorga = l_tmp.nmbcorga 
                 AND nmbc002 = l_tmp.nmbc002 
                 AND nmbc100 = l_tmp.nmbc100 
                 AND nmbc005 = l_tmp.nmbc005
         IF SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "upd tmp"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF                   

   END FOREACH

   CALL anmp802_ins_tmp2()  
   
   CALL anmp802_ins_anmt310() RETURNING r_success
   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp802_ins_tmp2()
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_ins_tmp2()
 
    LET g_sql = " INSERT INTO anmp802_tmp2 ",
                " SELECT nmbccomp,nmbcorga,nmbc002,nmbc100,",
                "  CASE WHEN nmbccomp = nmbcorga THEN 2 ELSE 1 END ,",
                "   SUM(acc103),SUM(acc113),SUM(acc123),SUM(acc133) FROM anmp802_tmp ",
                " GROUP BY nmbccomp,nmbcorga,nmbc002,nmbc100 "
    PREPARE anmp802_tmp2_pre FROM g_sql
    EXECUTE anmp802_tmp2_pre                
    
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmp802_ins_anmt310()
# Input parameter: 
# Date & Author..: 2016/08/05 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp802_ins_anmt310()
DEFINE l_nmba RECORD  #銀存收支主檔
       nmbaent LIKE nmba_t.nmbaent, #企业编号
       nmbaownid LIKE nmba_t.nmbaownid, #资料所有者
       nmbaowndp LIKE nmba_t.nmbaowndp, #资料所有部门
       nmbacrtid LIKE nmba_t.nmbacrtid, #资料录入者
       nmbacrtdp LIKE nmba_t.nmbacrtdp, #资料录入部门
       nmbacrtdt LIKE nmba_t.nmbacrtdt, #资料创建日
       nmbamodid LIKE nmba_t.nmbamodid, #资料更改者
       nmbamoddt LIKE nmba_t.nmbamoddt, #最近更改日
       nmbacnfid LIKE nmba_t.nmbacnfid, #资料审核者
       nmbacnfdt LIKE nmba_t.nmbacnfdt, #数据审核日
       nmbastus LIKE nmba_t.nmbastus, #审核码
       nmbacomp LIKE nmba_t.nmbacomp, #法人
       nmbadocno LIKE nmba_t.nmbadocno, #收支单号
       nmbadocdt LIKE nmba_t.nmbadocdt, #收支日期
       nmbasite LIKE nmba_t.nmbasite, #资金中心
       nmba001 LIKE nmba_t.nmba001, #缴款部门
       nmba002 LIKE nmba_t.nmba002, #账务人员
       nmba003 LIKE nmba_t.nmba003, #来源作业类型
       nmba004 LIKE nmba_t.nmba004, #交易对象
       nmba005 LIKE nmba_t.nmba005, #一次性交易对象识别码
       nmba006 LIKE nmba_t.nmba006, #暂收否
       nmba007 LIKE nmba_t.nmba007, #账务单号
       nmba008 LIKE nmba_t.nmba008, #缴款人员
       nmba009 LIKE nmba_t.nmba009, #核准日期
       nmba010 LIKE nmba_t.nmba010, #账套二账务单号
       nmba011 LIKE nmba_t.nmba011, #账套三账务单号
       nmba012 LIKE nmba_t.nmba012, #立账否(for流通)
       nmba013 LIKE nmba_t.nmba013, #起始日期
       nmba014 LIKE nmba_t.nmba014, #截止日期
       nmba015 LIKE nmba_t.nmba015  #往来据点
END RECORD   
DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企业编号
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支单号
       nmbbseq LIKE nmbb_t.nmbbseq, #项次
       nmbborga LIKE nmbb_t.nmbborga, #来源组织
       nmbblegl LIKE nmbb_t.nmbblegl, #核算组织
       nmbb001 LIKE nmbb_t.nmbb001, #异动别
       nmbb002 LIKE nmbb_t.nmbb002, #存提码
       nmbb003 LIKE nmbb_t.nmbb003, #交易账户编码
       nmbb004 LIKE nmbb_t.nmbb004, #币种
       nmbb005 LIKE nmbb_t.nmbb005, #汇率
       nmbb006 LIKE nmbb_t.nmbb006, #主账套原币金额
       nmbb007 LIKE nmbb_t.nmbb007, #主账套本币金额
       nmbb008 LIKE nmbb_t.nmbb008, #主账套已冲原币金额
       nmbb009 LIKE nmbb_t.nmbb009, #主账套已冲本币金额
       nmbb010 LIKE nmbb_t.nmbb010, #现金变动码
       nmbb011 LIKE nmbb_t.nmbb011, #本位币二币种
       nmbb012 LIKE nmbb_t.nmbb012, #本位币二汇率
       nmbb013 LIKE nmbb_t.nmbb013, #本位币二金额
       nmbb014 LIKE nmbb_t.nmbb014, #本位币二已冲金额
       nmbb015 LIKE nmbb_t.nmbb015, #本位币三币种
       nmbb016 LIKE nmbb_t.nmbb016, #本位币三汇率
       nmbb017 LIKE nmbb_t.nmbb017, #本位币三金额
       nmbb018 LIKE nmbb_t.nmbb018, #本位币三已冲金额
       nmbb019 LIKE nmbb_t.nmbb019, #辅助账套一汇率
       nmbb020 LIKE nmbb_t.nmbb020, #辅助账套一原币已冲
       nmbb021 LIKE nmbb_t.nmbb021, #辅助账套一本币已冲
       nmbb022 LIKE nmbb_t.nmbb022, #辅助账套二汇率
       nmbb023 LIKE nmbb_t.nmbb023, #辅助账套二原币已冲
       nmbb024 LIKE nmbb_t.nmbb024, #辅助账套二本币已冲
       nmbb025 LIKE nmbb_t.nmbb025, #备注
       nmbb026 LIKE nmbb_t.nmbb026, #交易对象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易对象识别码
       nmbb028 LIKE nmbb_t.nmbb028, #款别编码
       nmbb029 LIKE nmbb_t.nmbb029, #款别分类
       nmbb030 LIKE nmbb_t.nmbb030, #票据号码
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有价券数量
       nmbb033 LIKE nmbb_t.nmbb033, #有价券面额
       nmbb034 LIKE nmbb_t.nmbb034, #有价券起始编号
       nmbb035 LIKE nmbb_t.nmbb035, #有价券结束编号
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡银行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡号
       nmbb038 LIKE nmbb_t.nmbb038, #手续费
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收机构
       nmbb040 LIKE nmbb_t.nmbb040, #背书转入
       nmbb041 LIKE nmbb_t.nmbb041, #发票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票况
       nmbb043 LIKE nmbb_t.nmbb043, #票据付款银行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率种类
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #转付交易对象
       nmbb047 LIKE nmbb_t.nmbb047, #票据流通期间
       nmbb048 LIKE nmbb_t.nmbb048, #贴现利率种类
       nmbb049 LIKE nmbb_t.nmbb049, #贴现利率
       nmbb050 LIKE nmbb_t.nmbb050, #贴现期间
       nmbb051 LIKE nmbb_t.nmbb051, #贴现拨款原币金额
       nmbb052 LIKE nmbb_t.nmbb052, #贴现拨款本币金额
       nmbb053 LIKE nmbb_t.nmbb053, #缴款人员
       nmbb054 LIKE nmbb_t.nmbb054, #缴款部门
       nmbb055 LIKE nmbb_t.nmbb055, #POS缴款单号
       nmbb056 LIKE nmbb_t.nmbb056, #入账汇率
       nmbb057 LIKE nmbb_t.nmbb057, #入账原币金额
       nmbb058 LIKE nmbb_t.nmbb058, #入账主账套本币金额
       nmbb059 LIKE nmbb_t.nmbb059, #入账主账套本位币二汇率
       nmbb060 LIKE nmbb_t.nmbb060, #入账主账套本位币二金额
       nmbb061 LIKE nmbb_t.nmbb061, #入账主账套本位币三汇率
       nmbb062 LIKE nmbb_t.nmbb062, #入账主账套本位币三金额
       nmbb063 LIKE nmbb_t.nmbb063, #对方会科
       nmbb064 LIKE nmbb_t.nmbb064, #差异处理状态
       nmbb065 LIKE nmbb_t.nmbb065, #开票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重评后本币金额
       nmbb067 LIKE nmbb_t.nmbb067, #重评后本位币二金额
       nmbb068 LIKE nmbb_t.nmbb068, #重评后本位币三金额
       nmbb069 LIKE nmbb_t.nmbb069, #质押否
       nmbb070 LIKE nmbb_t.nmbb070  #往来据点
END RECORD   
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企业编号
       glbcld LIKE glbc_t.glbcld, #账套
       glbccomp LIKE glbc_t.glbccomp, #营运据点
       glbcdocno LIKE glbc_t.glbcdocno, #凭证编号
       glbcseq LIKE glbc_t.glbcseq, #项次
       glbcseq1 LIKE glbc_t.glbcseq1, #序号
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期别
       glbc003 LIKE glbc_t.glbc003, #借贷别
       glbc004 LIKE glbc_t.glbc004, #现金变动码
       glbc005 LIKE glbc_t.glbc005, #关系人
       glbc006 LIKE glbc_t.glbc006, #交易币种
       glbc007 LIKE glbc_t.glbc007, #汇率
       glbc008 LIKE glbc_t.glbc008, #原币金额
       glbc009 LIKE glbc_t.glbc009, #本币金额
       glbc010 LIKE glbc_t.glbc010, #数据源
       glbc011 LIKE glbc_t.glbc011, #汇率(本位币二)
       glbc012 LIKE glbc_t.glbc012, #金额(本位币二)
       glbc013 LIKE glbc_t.glbc013, #汇率(本位币三)
       glbc014 LIKE glbc_t.glbc014, #金额(本位币三)
       glbc015 LIKE glbc_t.glbc015  #状态码
END RECORD  
   DEFINE l_success   LIKE type_t.num5 
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_ooef016     LIKE ooef_t.ooef016
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_ooam003     LIKE ooam_t.ooam003
 
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5   
   DEFINE g_cnt         LIKE type_t.num5
   LET r_success = TRUE
   
   LET g_sql =" SELECT DISTINCT nmbccomp FROM anmp802_tmp "        
   PREPARE anmp802_tmp2_pre1 FROM g_sql 
   DECLARE anmp802_tmp2_cur1 CURSOR FOR anmp802_tmp2_pre1

   LET g_sql =" SELECT nmbccomp,nmbcorga,nmbc002,nmbc100,nmbb001,SUM(acc103) FROM anmp802_tmp2 ",
              "  WHERE nmbccomp = ? ",
              "  GROUP BY nmbccomp,nmbcorga,nmbc002,nmbc100,nmbb001 "
   PREPARE anmp802_tmp2_pre2 FROM g_sql 
   DECLARE anmp802_tmp2_cur2 CURSOR FOR anmp802_tmp2_pre2 
   
   LET g_str = NULL
   FOREACH anmp802_tmp2_cur1 INTO l_nmba.nmbacomp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH tmp2:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF    
      SELECT glaa001,glaald,glaa004,glaa005,glaa015,
             glaa016,glaa017,glaa018,glaa019,glaa020,
             glaa021,glaa022,glaa003,glaa024                      
        INTO g_glaa001,g_glaald,g_glaa004,g_glaa005,g_glaa015,
             g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
             g_glaa021,g_glaa022,g_glaa003,g_glaa024             
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_nmba.nmbacomp
         AND glaa014 = 'Y'
  
      
      LET l_nmba.nmbaent = g_enterprise
      LET l_nmba.nmbaownid = g_user
      LET l_nmba.nmbaowndp = g_dept
      LET l_nmba.nmbacrtid = g_user
      LET l_nmba.nmbacrtdp = g_dept 
      LET l_nmba.nmbacrtdt = cl_get_current()
      LET l_nmba.nmbamodid = ""
      LET l_nmba.nmbamoddt = ""
      LET l_nmba.nmbacnfid = g_user
      LET l_nmba.nmbacnfdt = cl_get_current()
      LET l_nmba.nmbastus = 'N'
      LET l_nmba.nmbacomp  = l_nmba.nmbacomp
      LET l_nmba.nmbadocdt = g_master.edate  
      LET l_nmba.nmbasite = l_nmba.nmbacomp
      LET l_nmba.nmba001 = g_site
      LET l_nmba.nmba002 = g_user
      LET l_nmba.nmba003 = 'anmp802' #anmp802
      LET l_nmba.nmba004 = g_site
      LET l_nmba.nmba015 = 'N'  
      LET l_nmba.nmba013 = g_today
      LET l_nmba.nmba014 = g_today
      LET l_nmba.nmba009 = ''
      CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_master.nmbadocno,l_nmba.nmbadocdt,'anmt310')  
         RETURNING r_success,l_nmba.nmbadocno   
      IF r_success  = FALSE  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF  
      LET g_str = g_str," ",l_nmba.nmbadocno  #用于显示执行完成后产生的anmt310单据号

      INSERT INTO nmba_t(nmbaent,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,
                         nmbacrtdt,nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt,
                         nmbastus,nmbacomp,nmbadocno,nmbadocdt,nmbasite,
                         nmba001,nmba002,nmba003,nmba004,nmba005,
                         nmba006,nmba007,nmba008,nmba009,nmba010,
                         nmba011,nmba012,nmba013,nmba014,nmba015) 
                  VALUES(l_nmba.nmbaent,  l_nmba.nmbaownid,l_nmba.nmbaowndp,l_nmba.nmbacrtid,l_nmba.nmbacrtdp,
                         l_nmba.nmbacrtdt,l_nmba.nmbamodid,l_nmba.nmbamoddt,l_nmba.nmbacnfid,l_nmba.nmbacnfdt,
                         l_nmba.nmbastus, l_nmba.nmbacomp, l_nmba.nmbadocno,l_nmba.nmbadocdt,l_nmba.nmbasite,
                         l_nmba.nmba001,  l_nmba.nmba002,  l_nmba.nmba003,  l_nmba.nmba004,  l_nmba.nmba005,
                         l_nmba.nmba006,  l_nmba.nmba007,  l_nmba.nmba008,  l_nmba.nmba009,  l_nmba.nmba010,
                         l_nmba.nmba011,  l_nmba.nmba012,  l_nmba.nmba013,  l_nmba.nmba014,  l_nmba.nmba015)
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE   
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmba"
         LET g_errparam.popup = FALSE
         LET r_success = FALSE
         CALL cl_err()
      END IF

#--ins nmbb---
      LET g_cnt = 1
      FOREACH anmp802_tmp2_cur2 USING l_nmba.nmbacomp 
         INTO l_nmbb.nmbbcomp,l_nmbb.nmbborga,l_nmbb.nmbb003,l_nmbb.nmbb004,l_nmbb.nmbb001,l_nmbb.nmbb006#,l_nmbb.nmbb007,l_nmbb.nmbb013,l_nmbb.nmbb017 
        IF SQLCA.sqlcode THEN  
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "FOREACH tmp2_2:" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOREACH
        END IF       
        LET l_nmbb.nmbbent = g_enterprise
        LET l_nmbb.nmbbdocno = l_nmba.nmbadocno 
        LET l_nmbb.nmbblegl = g_site
        LET l_nmbb.nmbb008 = 0 
        LET l_nmbb.nmbb009 = 0
        LET l_nmbb.nmbb014 = 0
        LET l_nmbb.nmbb018 = 0
        LET l_nmbb.nmbb070 = 'N'
                          
        SELECT ooef016 INTO l_ooef016 FROM ooef_t 
         WHERE ooefent = g_enterprise AND ooef001 = l_nmbb.nmbbcomp
         
        SELECT ooab002 INTO l_ooab002 FROM ooab_t
         WHERE ooabent = g_enterprise AND ooabsite= l_nmbb.nmbbcomp
           AND ooab001 = 'S-FIN-4004'      
         
                                  #匯率參照表;帳套; 日期;   來源幣別
        CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_nmbb.nmbb004,
                                  #目的幣別;交易金額;匯類類型
                                  l_ooef016,0,l_ooab002)
              RETURNING l_nmbb.nmbb005   

 
        LET l_nmbb.nmbb007 = l_nmbb.nmbb006*l_nmbb.nmbb005
        LET l_nmbb.nmbb011 = g_glaa016

        IF g_glaa015 = 'Y' THEN 
           #來源幣別
           LET l_ooam003 = ''
           IF g_glaa017 = '1' THEN
              LET l_ooam003 = l_nmbb.nmbb004
           ELSE   #表示帳簿幣別 
              LET l_ooam003 = g_glaa001           #帳套使用幣別
           END IF
        
                                    #     帳套;       日期;           來源幣別
           CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                     #目的幣別; 交易金額; 匯類類型
                                     g_glaa016,0,g_glaa018)
           RETURNING l_nmbb.nmbb012
           IF g_glaa017 = '1' THEN #原幣
              LET l_nmbb.nmbb013 = l_nmbb.nmbb006 * l_nmbb.nmbb012
           ELSE #本幣
              LET l_nmbb.nmbb013 = l_nmbb.nmbb007 * l_nmbb.nmbb012
           END IF
        END IF
  
        LET l_nmbb.nmbb015 = g_glaa020
        #本位幣三  
        IF g_glaa019 = 'Y' THEN 
           #來源幣別
           LET l_ooam003 = ''
           IF g_glaa021 = '1' THEN
              LET l_ooam003 = l_nmbb.nmbb004
           ELSE   #表示帳簿幣別 
              LET l_ooam003 = g_glaa001           #帳套使用幣別
           END IF
           
                                    #     帳套;       日期;           來源幣別
           CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                     #目的幣別; 交易金額; 匯類類型
                                     g_glaa020,0,g_glaa022)
           RETURNING l_nmbb.nmbb016
           IF g_glaa021 = '1' THEN
              LET l_nmbb.nmbb017 = l_nmbb.nmbb006 * l_nmbb.nmbb016
           ELSE
              LET l_nmbb.nmbb017 = l_nmbb.nmbb007 * l_nmbb.nmbb016
           END IF
        END IF
   
        LET l_nmbb.nmbb053 = g_user
        LET l_nmbb.nmbb054 = g_dept
        LET l_nmbb.nmbb056 = l_nmbb.nmbb005	     #繳款匯率            
        LET l_nmbb.nmbb057 = l_nmbb.nmbb006	     #主帳套原幣金額(繳款)
        LET l_nmbb.nmbb058 = l_nmbb.nmbb007	     #主帳套本幣金額(繳款)
        LET l_nmbb.nmbb059 = l_nmbb.nmbb012	     #主帳套本位幣二匯率(繳款)
        LET l_nmbb.nmbb060 = l_nmbb.nmbb013	     #主帳套本位幣二金額(繳款)
        LET l_nmbb.nmbb061 = l_nmbb.nmbb016	     #主帳套本位幣三匯率(繳款)
        LET l_nmbb.nmbb062 = l_nmbb.nmbb017	     #主帳套本位幣三金額(繳款)  

 
        LET l_nmbb.nmbbseq = g_cnt 
        IF l_nmbb.nmbb001 = 1 THEN
           LET l_nmbb.nmbb002 = g_master.cin
        ELSE
           LET l_nmbb.nmbb002 = g_master.tout        
        END IF   
        #现金变动码
        SELECT nmad003 INTO l_nmbb.nmbb010
          FROM nmad_t
         WHERE nmadent = g_enterprise
           AND nmad001 = g_glaa005
           AND nmad002 = l_nmbb.nmbb002   
           
       IF l_nmbb.nmbb007 < 0 THEN #金额小于0，更新存提码
          LET l_nmbb.nmbb007 = l_nmbb.nmbb007 *(-1)
          LET l_nmbb.nmbb006 = l_nmbb.nmbb006 *(-1)
          LET l_nmbb.nmbb012 = l_nmbb.nmbb012 *(-1)
          LET l_nmbb.nmbb013 = l_nmbb.nmbb013 *(-1)
          LET l_nmbb.nmbb016 = l_nmbb.nmbb016 *(-1)
          LET l_nmbb.nmbb017 = l_nmbb.nmbb017 *(-1)
          LET l_nmbb.nmbb057 = l_nmbb.nmbb057 *(-1)
          LET l_nmbb.nmbb058 = l_nmbb.nmbb058 *(-1)
          LET l_nmbb.nmbb059 = l_nmbb.nmbb059 *(-1)
          LET l_nmbb.nmbb060 = l_nmbb.nmbb060 *(-1)
          LET l_nmbb.nmbb061 = l_nmbb.nmbb061 *(-1)
          LET l_nmbb.nmbb062 = l_nmbb.nmbb062 *(-1)
          LET l_nmbb.nmbb001 = '2' 
          LET l_nmbb.nmbb002 = g_master.tout
       END IF       
 
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb007,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb007
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb006,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb006
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb012,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb012
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb013,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb013
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb016,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb016
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb017,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb017   

        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb057,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb057
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb058,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb058
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb059,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb059
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb060,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb060
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb061,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb061
        CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb062,2)
           RETURNING l_success,g_errno,l_nmbb.nmbb062     
           
       INSERT INTO nmbb_t(nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,
                          nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,
                          nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,
                          nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,
                          nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,
                          nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,
                          nmbb025,nmbb026,nmbb027,nmbb028,nmbb029,
                          nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,
                          nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,
                          nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,
                          nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,
                          nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,
                          nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,
                          nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,
                          nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,
                          nmbb070)
                   VALUES(l_nmbb.nmbbent, l_nmbb.nmbbcomp,l_nmbb.nmbbdocno,l_nmbb.nmbbseq,l_nmbb.nmbborga,
                          l_nmbb.nmbblegl,l_nmbb.nmbb001, l_nmbb.nmbb002,  l_nmbb.nmbb003,l_nmbb.nmbb004,
                          l_nmbb.nmbb005, l_nmbb.nmbb006, l_nmbb.nmbb007,  l_nmbb.nmbb008,l_nmbb.nmbb009,
                          l_nmbb.nmbb010, l_nmbb.nmbb011, l_nmbb.nmbb012,  l_nmbb.nmbb013,l_nmbb.nmbb014,
                          l_nmbb.nmbb015, l_nmbb.nmbb016, l_nmbb.nmbb017,  l_nmbb.nmbb018,l_nmbb.nmbb019,
                          l_nmbb.nmbb020, l_nmbb.nmbb021, l_nmbb.nmbb022,  l_nmbb.nmbb023,l_nmbb.nmbb024,
                          l_nmbb.nmbb025, l_nmbb.nmbb026, l_nmbb.nmbb027,  l_nmbb.nmbb028,l_nmbb.nmbb029,
                          l_nmbb.nmbb030, l_nmbb.nmbb031, l_nmbb.nmbb032,  l_nmbb.nmbb033,l_nmbb.nmbb034,
                          l_nmbb.nmbb035, l_nmbb.nmbb036, l_nmbb.nmbb037,  l_nmbb.nmbb038,l_nmbb.nmbb039,
                          l_nmbb.nmbb040, l_nmbb.nmbb041, l_nmbb.nmbb042,  l_nmbb.nmbb043,l_nmbb.nmbb044,
                          l_nmbb.nmbb045, l_nmbb.nmbb046, l_nmbb.nmbb047,  l_nmbb.nmbb048,l_nmbb.nmbb049,
                          l_nmbb.nmbb050, l_nmbb.nmbb051, l_nmbb.nmbb052,  l_nmbb.nmbb053,l_nmbb.nmbb054,
                          l_nmbb.nmbb055, l_nmbb.nmbb056, l_nmbb.nmbb057,  l_nmbb.nmbb058,l_nmbb.nmbb059,
                          l_nmbb.nmbb060, l_nmbb.nmbb061, l_nmbb.nmbb062,  l_nmbb.nmbb063,l_nmbb.nmbb064,
                          l_nmbb.nmbb065, l_nmbb.nmbb066, l_nmbb.nmbb067,  l_nmbb.nmbb068,l_nmbb.nmbb069,
                          l_nmbb.nmbb070)
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE    
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbb"
            LET g_errparam.popup = FALSE
            LET r_success = FALSE
            CALL cl_err()
         END IF    

#--ins glbc---
       LET l_year = YEAR(l_nmba.nmbadocdt)
       LET l_month = MONTH(l_nmba.nmbadocdt)
       LET l_glbc.glbcent   = g_enterprise
       LET l_glbc.glbcld    = g_glaald
       LET l_glbc.glbccomp  = l_nmba.nmbacomp
       LET l_glbc.glbcdocno = l_nmba.nmbadocno 
       LET l_glbc.glbc001   = l_year
       LET l_glbc.glbc002   = l_month
       
       LET l_glbc.glbc005   = l_nmbb.nmbb026
       LET l_glbc.glbc006   = l_nmbb.nmbb004
       LET l_glbc.glbc007   = l_nmbb.nmbb005
       LET l_glbc.glbc008   = l_nmbb.nmbb006
       LET l_glbc.glbc009   = l_nmbb.nmbb007
       LET l_glbc.glbc010   = l_nmbb.nmbb001
       #--以下視主帳套有無啟用本位幣
       IF g_glaa015 = 'Y' THEN 
          LET l_glbc.glbc011 = l_nmbb.nmbb012
          LET l_glbc.glbc012 = l_nmbb.nmbb013
       END IF
       IF g_glaa019 = 'Y' THEN 
          LET l_glbc.glbc013 = l_nmbb.nmbb016
          LET l_glbc.glbc014 = l_nmbb.nmbb017
       END IF
       LET l_glbc.glbc015   = l_nmba.nmbastus    
       LET l_glbc.glbcseq = l_nmbb.nmbbseq             
       SELECT MAX(glbcseq1) + 1 INTO l_glbc.glbcseq1
         FROM glbc_t
        WHERE glbcent = g_enterprise
          AND glbcld =  l_glbc.glbcld
          AND glbcdocno = l_glbc.glbcdocno
          AND glbcseq = l_glbc.glbcseq
          AND glbc001 = l_glbc.glbc001
          AND glac002 = l_glbc.glbc002
       IF cl_null(l_glbc.glbcseq1) THEN 
          LET l_glbc.glbcseq1 = 1
       END IF      
       LET l_glbc.glbc003   = l_nmbb.nmbb001 
       LET l_glbc.glbc004   = l_nmbb.nmbb010
       INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,
                          glbcseq1,glbc001,glbc002,glbc003,glbc004,
                          glbc005,glbc006,glbc007,glbc008,glbc009,
                          glbc010,glbc011,glbc012,glbc013,glbc014,
                          glbc015)
                   VALUES(l_glbc.glbcent, l_glbc.glbcld, l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,
                          l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002, l_glbc.glbc003,  l_glbc.glbc004,
                          l_glbc.glbc005, l_glbc.glbc006,l_glbc.glbc007, l_glbc.glbc008,  l_glbc.glbc009,
                          l_glbc.glbc010, l_glbc.glbc011,l_glbc.glbc012, l_glbc.glbc013,  l_glbc.glbc014,
                          l_glbc.glbc015)
       IF SQLCA.sqlcode THEN
          LET r_success = FALSE    
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "ins glbc"
          LET g_errparam.popup = FALSE
          LET r_success = FALSE
          CALL cl_err()
       END IF 
       
       LET g_cnt = g_cnt + 1
     END FOREACH
   END FOREACH

   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
