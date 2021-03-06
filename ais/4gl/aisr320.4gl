#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-10-24 17:45:43), PR版次:0004(2016-10-26 10:14:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: aisr320
#+ Description: 銷項發票明細表列印
#+ Creator....: 05016(2014-07-02 10:52:22)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisr320.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#3  2016/01/21 By albireo    增加控制組判斷
#160920-00019#5  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#28 2016/10/24 By Reanna     1.法人(isafcomp)增加azzi800控卡，開窗改用q_ooef001()
#                                         2.開票部門(isaf006)開窗後顯示的資料需存在aisi090
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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       isafcomp LIKE type_t.chr10, 
   isafcomp_desc LIKE type_t.chr80, 
   isaf001 LIKE type_t.chr1, 
   isaf002 LIKE type_t.chr10, 
   isaf008 LIKE type_t.chr2, 
   isaf009 LIKE type_t.chr500, 
   isaf036 LIKE type_t.chr10, 
   isafsite LIKE type_t.chr500, 
   isaf051 LIKE type_t.chr10, 
   isaf010 LIKE type_t.chr20, 
   isaf011 LIKE type_t.chr20, 
   isaf053 LIKE type_t.chr500, 
   isaf016 LIKE type_t.chr10, 
   isaf018 LIKE type_t.num26_10, 
   isaf017 LIKE type_t.chr500, 
   isaf100 LIKE type_t.chr10, 
   isaf005 LIKE type_t.chr20, 
   isaf006 LIKE type_t.chr10,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ooef019            LIKE ooef_t.ooef019
DEFINE g_success1           BOOLEAN
#151231-00010#3-----s
DEFINE g_ctl_where          STRING    #交易對象控制組WHERE CON
#151231-00010#3-----e
DEFINE g_wc_isafcomp        STRING    #161006-00005#28
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisr320.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisr320_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisr320 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisr320_init()
 
      #進入選單 Menu (="N")
      CALL aisr320_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisr320
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisr320.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisr320_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
   CALL cl_set_combo_scc_part('isaf001','9715','1,2,3')
   CALL cl_set_combo_scc_part('isaf036','9716','11,12,13,21,22,23,11Y,12Y,13Y,21Y,22Y')
   CALL cl_set_combo_scc_part('isaf053','9734','2,3')
   CALL aisr320_comp_ref() RETURNING g_master.isafcomp
   #151231-00010#3-----s
   CALL s_control_get_customer_sql('2',g_master.isafcomp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where
   #151231-00010#3-----e 
   CALL s_desc_get_department_desc(g_master.isafcomp) RETURNING g_master.isafcomp_desc
   DISPLAY g_master.isafcomp_desc TO isafcomp_desc
   LET g_master.isaf001 = '2'
   CALL s_fin_create_account_center_tmp()  #161006-00005#28
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisr320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr320_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_ooef019 LIKE ooef_t.ooef019
   DEFINE l_comp    LIKE ooef_t.ooef001
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.isafcomp,g_master.isaf001 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL s_desc_get_department_desc(g_master.isafcomp) RETURNING g_master.isafcomp_desc
               DISPLAY g_master.isafcomp_desc TO isafcomp_desc
               #161006-00005#28 add ------
               CALL s_fin_account_center_sons_query('3',g_site,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
               CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
               #161006-00005#28 add end---
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafcomp
            
            #add-point:AFTER FIELD isafcomp name="input.a.isafcomp"
            CALL aisr320_comp_chk() RETURNING g_success1,g_errno
            IF NOT g_success1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET g_master.isafcomp = ''
               LET g_master.isafcomp_desc = ''
               DISPLAY g_master.isafcomp_desc TO isafcomp_desc
               NEXT FIELD CURRENT
            END IF
            #161006-00005#28 add ------
            #檢查輸入帳套是否存在帳務中心下帳套範圍內
            IF s_chr_get_index_of(g_wc_isafcomp,g_master.isafcomp,1) = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00127'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.isafcomp = ''
               LET g_master.isafcomp_desc = ''
               DISPLAY g_master.isafcomp_desc TO isafcomp_desc
               NEXT FIELD CURRENT
            END IF
            #161006-00005#28 add end---
            CALL s_desc_get_department_desc(g_master.isafcomp) RETURNING g_master.isafcomp_desc
            DISPLAY g_master.isafcomp_desc TO isafcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafcomp
            #add-point:BEFORE FIELD isafcomp name="input.b.isafcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafcomp
            #add-point:ON CHANGE isafcomp name="input.g.isafcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf001
            #add-point:BEFORE FIELD isaf001 name="input.b.isaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf001
            
            #add-point:AFTER FIELD isaf001 name="input.a.isaf001"
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaf001
            #add-point:ON CHANGE isaf001 name="input.g.isaf001"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isafcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafcomp
            #add-point:ON ACTION controlp INFIELD isafcomp name="input.c.isafcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_2()   #161006-00005#28 mark
            LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_isafcomp CLIPPED  #161006-00005#28
            CALL q_ooef001()      #161006-00005#28
            LET g_master.isafcomp = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.isafcomp) RETURNING g_master.isafcomp_desc
            DISPLAY g_master.isafcomp_desc TO isafcomp_desc
            DISPLAY g_qryparam.return1 TO isafcomp
            NEXT FIELD isafcomp
            #END add-point
 
 
         #Ctrlp:input.c.isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf001
            #add-point:ON ACTION controlp INFIELD isaf001 name="input.c.isaf001"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON isaf002,isaf008,isaf009,isaf036,isafsite,isaf051,isaf010,isaf011, 
             isaf053,isaf016,isaf018,isaf017,isaf100,isaf005,isaf006
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.isaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf002
            #add-point:ON ACTION controlp INFIELD isaf002 name="construct.c.isaf002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#3-----s
            LET g_qryparam.where = g_ctl_where," AND EXISTS (SELECT 1 FROM pmab_t ",
                                               " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                               "   AND pmabsite = '",g_master.isafcomp,"' )"
            #151231-00010#3-----e
            #CALL q_pmaa001()  #呼叫開窗   #160920-00019#5--mark
            CALL q_pmaa001_13()           #160920-00019#5--add
            DISPLAY g_qryparam.return1 TO isaf002
            NEXT FIELD isaf002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf002
            #add-point:BEFORE FIELD isaf002 name="construct.b.isaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf002
            
            #add-point:AFTER FIELD isaf002 name="construct.a.isaf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf008
            #add-point:ON ACTION controlp INFIELD isaf008 name="construct.c.isaf008"
            #開窗c段
            SELECT ooef019 INTO g_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.isafcomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_ooef019,"' AND isac003 = 2 "
            CALL q_isac002()
            DISPLAY g_qryparam.return1 TO isaf008
            NEXT FIELD isaf008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf008
            #add-point:BEFORE FIELD isaf008 name="construct.b.isaf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf008
            
            #add-point:AFTER FIELD isaf008 name="construct.a.isaf008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf009
            #add-point:BEFORE FIELD isaf009 name="construct.b.isaf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf009
            
            #add-point:AFTER FIELD isaf009 name="construct.a.isaf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf009
            #add-point:ON ACTION controlp INFIELD isaf009 name="construct.c.isaf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf036
            #add-point:BEFORE FIELD isaf036 name="construct.b.isaf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf036
            
            #add-point:AFTER FIELD isaf036 name="construct.a.isaf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf036
            #add-point:ON ACTION controlp INFIELD isaf036 name="construct.c.isaf036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafsite
            #add-point:BEFORE FIELD isafsite name="construct.b.isafsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafsite
            
            #add-point:AFTER FIELD isafsite name="construct.a.isafsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isafsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafsite
            #add-point:ON ACTION controlp INFIELD isafsite name="construct.c.isafsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef017 = '",g_master.isafcomp,"' "
            CALL q_ooef001_11()
            DISPLAY g_qryparam.return1 TO isafsite
            NEXT FIELD isafsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf051
            #add-point:BEFORE FIELD isaf051 name="construct.b.isaf051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf051
            
            #add-point:AFTER FIELD isaf051 name="construct.a.isaf051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf051
            #add-point:ON ACTION controlp INFIELD isaf051 name="construct.c.isaf051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf010
            #add-point:BEFORE FIELD isaf010 name="construct.b.isaf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf010
            
            #add-point:AFTER FIELD isaf010 name="construct.a.isaf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf010
            #add-point:ON ACTION controlp INFIELD isaf010 name="construct.c.isaf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf011
            #add-point:BEFORE FIELD isaf011 name="construct.b.isaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf011
            
            #add-point:AFTER FIELD isaf011 name="construct.a.isaf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf011
            #add-point:ON ACTION controlp INFIELD isaf011 name="construct.c.isaf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf053
            #add-point:BEFORE FIELD isaf053 name="construct.b.isaf053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf053
            
            #add-point:AFTER FIELD isaf053 name="construct.a.isaf053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf053
            #add-point:ON ACTION controlp INFIELD isaf053 name="construct.c.isaf053"
            
            #END add-point
 
 
         #Ctrlp:construct.c.isaf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf016
            #add-point:ON ACTION controlp INFIELD isaf016 name="construct.c.isaf016"
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef017 = g_master.isafcomp
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_ooef019
            CALL q_oodb002_5()
            DISPLAY g_qryparam.return1 TO isaf016
            NEXT FIELD isaf016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf016
            #add-point:BEFORE FIELD isaf016 name="construct.b.isaf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf016
            
            #add-point:AFTER FIELD isaf016 name="construct.a.isaf016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf018
            #add-point:BEFORE FIELD isaf018 name="construct.b.isaf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf018
            
            #add-point:AFTER FIELD isaf018 name="construct.a.isaf018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf018
            #add-point:ON ACTION controlp INFIELD isaf018 name="construct.c.isaf018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf017
            #add-point:BEFORE FIELD isaf017 name="construct.b.isaf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf017
            
            #add-point:AFTER FIELD isaf017 name="construct.a.isaf017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf017
            #add-point:ON ACTION controlp INFIELD isaf017 name="construct.c.isaf017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf100
            #add-point:ON ACTION controlp INFIELD isaf100 name="construct.c.isaf100"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()
            DISPLAY g_qryparam.return1 TO isaf100
            NEXT FIELD isaf100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf100
            #add-point:BEFORE FIELD isaf100 name="construct.b.isaf100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf100
            
            #add-point:AFTER FIELD isaf100 name="construct.a.isaf100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf005
            #add-point:ON ACTION controlp INFIELD isaf005 name="construct.c.isaf005"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO isaf005
            NEXT FIELD isaf005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf005
            #add-point:BEFORE FIELD isaf005 name="construct.b.isaf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf005
            
            #add-point:AFTER FIELD isaf005 name="construct.a.isaf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf006
            #add-point:ON ACTION controlp INFIELD isaf006 name="construct.c.isaf006"
            #開票部門
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161006-00005#28 add ------
		      LET g_qryparam.where = " ooef001 IN (SELECT isaosite FROM isao_t",
		                             "              WHERE isaoent = ",g_enterprise," AND isaostus = 'Y')"
		      #161006-00005#28 add end---
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO isaf006
            NEXT FIELD isaf006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf006
            #add-point:BEFORE FIELD isaf006 name="construct.b.isaf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf006
            
            #add-point:AFTER FIELD isaf006 name="construct.a.isaf006"
            
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL aisr320_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aisr320_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            CALL aisr320_comp_ref() RETURNING g_master.isafcomp
            CALL s_desc_get_department_desc(g_master.isafcomp) RETURNING g_master.isafcomp_desc
            DISPLAY g_master.isafcomp_desc TO isafcomp_desc
            #151231-00010#3-----s
            CALL s_control_get_customer_sql('2',g_master.isafcomp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where   
            #151231-00010#3-----e 
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
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
         CALL aisr320_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL aisr320_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisr320_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aisr320.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisr320_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="aisr320.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisr320_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"isaf002,isaf008,isaf009,isaf036,isafsite,isaf051,isaf010,isaf011,isaf053,isaf016,isaf018,isaf017,isaf100,isaf005,isaf006")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF

   IF NOT cl_null(g_master.isaf001) THEN
      LET g_master.wc = g_master.wc CLIPPED," AND isafent = ",g_enterprise," AND isafcomp = '",g_master.isafcomp,"' AND isaf001 = '",g_master.isaf001,"' AND isafstus = 'Y' "      
   ELSE
      LET g_master.wc = g_master.wc CLIPPED," AND isafent = ",g_enterprise," AND isafcomp = '",g_master.isafcomp,"' AND isafstus = 'Y' "
   END IF
    
   #151231-00010#3-----s                                           
   LET g_master.wc = g_master.wc CLIPPED," AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t ",
                                                      " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                      "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                      "   AND pmabsite = '",g_master.isafcomp,"' ",
                                                      "   AND pmaaent = isafent AND pmaa001 = isaf003 )"
   #151231-00010#3-----e
   
   CALL aisr320_g01(g_master.wc) 
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisr320_process_cs CURSOR FROM ls_sql
#  FOREACH aisr320_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aisr320.get_buffer" >}
PRIVATE FUNCTION aisr320_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.isafcomp = p_dialog.getFieldBuffer('isafcomp')
   LET g_master.isaf001 = p_dialog.getFieldBuffer('isaf001')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 使用者所屬法人
# Memo...........:
# Usage..........: CALL aisr320_comp_ref()
################################################################################
PRIVATE FUNCTION aisr320_comp_ref()
DEFINE l_success        BOOLEAN
DEFINE l_lsaeld         LIKE glaa_t.glaald
DEFINE l_isaecomp       LIKE isae_t.isaecomp
DEFINE l_errno          LIKE type_t.num5
   
   CALL s_fin_ld_carry('',g_user) RETURNING l_success,l_lsaeld,l_isaecomp,l_errno
   RETURN l_isaecomp

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr320_comp_chk()
DEFINE l_count          LIKE type_t.num10  # 錯誤數目
DEFINE r_success        BOOLEAN
DEFINE r_errno          LIKE gzze_t.gzze001
   
   LET r_success = TRUE
   LET r_errno =''

   LET l_count = ''
   SELECT COUNT(*) INTO l_count
     FROM ooef_t
    WHERE ooefent  = g_enterprise
      AND ooef017  = g_master.isafcomp
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno ='anm-00037'
   END IF

   RETURN r_success,r_errno
END FUNCTION

#end add-point
 
{</section>}
 
