#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp720.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-07 16:06:42), PR版次:0001(2017-01-04 17:04:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp720
#+ Description: 人工預算憑證生成
#+ Creator....: 05016(2016-12-07 10:01:00)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgp720.global" >}
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
       bgba001 LIKE bgba_t.bgba001, 
   bgba001_desc LIKE type_t.chr80, 
   bgba003 LIKE bgba_t.bgba003, 
   bgba002 LIKE bgba_t.bgba002, 
   bgba002_desc LIKE type_t.chr80, 
   bgba006 LIKE bgba_t.bgba006, 
   bgba010 LIKE bgba_t.bgba010, 
   bgba010_desc LIKE type_t.chr80, 
   bgba004_s LIKE type_t.num5, 
   bgba004_e LIKE type_t.num5, 
   bgbadocno LIKE bgba_t.bgbadocno, 
   bgbadocno_desc LIKE type_t.chr80, 
   bgcj007 LIKE type_t.chr10, 
   bgbadocno_1 LIKE type_t.chr20, 
   bgbadocno_2 LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_bgaa      RECORD
         bgaa002   LIKE bgaa_t.bgaa002,
         bgaa003   LIKE bgaa_t.bgaa003,
         bgaa008   LIKE bgaa_t.bgaa008,   #預算細項參照表號
         bgaa009   LIKE bgaa_t.bgaa009,   #現金變動碼參照表
         bgaa011   LIKE bgaa_t.bgaa011
                   END RECORD

DEFINE g_ld        LIKE glaa_t.glaald   
DEFINE g_glaa024   LIKE glaa_t.glaa024   
DEFINE g_master_o  type_master
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp720.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abgp720_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp720 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp720_init()
 
      #進入選單 Menu (="N")
      CALL abgp720_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp720
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp720.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp720_init()
 
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
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp720.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp720_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_site_str  STRING
   DEFINE l_bgaa006   LIKE bgaa_t.bgaa006
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL abgp720_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgba001,g_master.bgba002,g_master.bgba006,g_master.bgba010,g_master.bgba004_s, 
             g_master.bgba004_e,g_master.bgbadocno 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba001
            
            #add-point:AFTER FIELD bgba001 name="input.a.bgba001"
            LET g_master.bgba001_desc = ''
            DISPLAY BY NAME g_master.bgba001_desc
            IF NOT cl_null(g_master.bgba001) THEN
               IF g_master.bgba001 != g_master_o.bgba001 OR cl_null(g_master_o.bgba001) THEN                                
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.bgba001
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_bgaa001") THEN
                     #檢查失敗時後續處理
                     LET g_master.bgba001 = g_master_o.bgba001
                     CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
                     DISPLAY BY NAME g_master.bgba001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查是否使用預測,不使用才可執行
                  LET l_bgaa006 = ''
                  SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bgba001 AND bgaastus = 'Y'
                  IF l_bgaa006 != '1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00292'
                     LET g_errparam.extend = g_master.bgba001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgba001 = g_master_o.bgba001
                     CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
                     DISPLAY BY NAME g_master.bgba001_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.bgba010) THEN
                     CALL s_abg2_bgai002_chk(g_master.bgba001,g_master.bgba010,'07') 
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_master.bgba010
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.bgba001 = g_master_o.bgba001
                        CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
                        DISPLAY BY NAME g_master.bgba001_desc
                        LET g_master.bgba010 = ''
                        CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
                        DISPLAY BY NAME g_master.bgba010_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  INITIALIZE g_bgaa.* TO NULL
                  #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
                  SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
                    FROM bgaa_t
                   WHERE bgaaent = g_enterprise
                     AND bgaa001 = g_master.bgba001
                  LET g_master.bgba003 = g_bgaa.bgaa002 #預算週期
                  LET g_master.bgba006 = g_bgaa.bgaa003 #預算幣別
                  DISPLAY BY NAME g_master.bgba003,g_master.bgba006    

                  #根據各單身預算組織找主帳套
                  LET g_ld = ''
                  LET g_glaa024 = ''
                  SELECT glaald,glaa024 INTO g_ld,g_glaa024
                    FROM glaa_t,ooef_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = ooef017           
                     AND glaaent = ooefent
                     AND ooef001 = g_bgaa.bgaa011
                     AND glaa014 = 'Y'  
                  
                  #清空資料
                  LET g_master.bgbadocno = ''
                  LET g_master.bgbadocno_desc = ''
                  DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
               END IF
            END IF         
            CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
            DISPLAY BY NAME g_master.bgba001_desc       
            
            INITIALIZE g_bgaa.* TO NULL
            #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
            SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgba001
            LET g_master.bgba003 = g_bgaa.bgaa002 #預算週期
            LET g_master.bgba006 = g_bgaa.bgaa003 #預算幣別
            DISPLAY BY NAME g_master.bgba003,g_master.bgba006    
             
            #根據各單身預算組織找主帳套
            LET g_ld = ''
            LET g_glaa024 = ''
            SELECT glaald,glaa024 INTO g_ld,g_glaa024
              FROM glaa_t,ooef_t
             WHERE glaaent = g_enterprise
               AND glaacomp = ooef017           
               AND glaaent = ooefent
               AND ooef001 = g_bgaa.bgaa011
               AND glaa014 = 'Y'  
               
            LET g_master_o.* = g_master.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba001
            #add-point:BEFORE FIELD bgba001 name="input.b.bgba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba001
            #add-point:ON CHANGE bgba001 name="input.g.bgba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba002
            
            #add-point:AFTER FIELD bgba002 name="input.a.bgba002"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba002
            #add-point:BEFORE FIELD bgba002 name="input.b.bgba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba002
            #add-point:ON CHANGE bgba002 name="input.g.bgba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba006
            #add-point:BEFORE FIELD bgba006 name="input.b.bgba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba006
            
            #add-point:AFTER FIELD bgba006 name="input.a.bgba006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba006
            #add-point:ON CHANGE bgba006 name="input.g.bgba006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba010
            
            #add-point:AFTER FIELD bgba010 name="input.a.bgba010"
            LET g_master.bgba010_desc = ''
            DISPLAY BY NAME g_master.bgba010_desc
            IF NOT cl_null(g_master.bgba010) THEN
               IF g_master.bgba010 != g_master_o.bgba010 OR cl_null(g_master_o.bgba010) THEN 
                  CALL s_abg2_bgai002_chk(g_master.bgba001,g_master.bgba010,'07') 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.bgba010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgba010 = g_master_o.bgba010
                     CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
                     DISPLAY BY NAME g_master.bgba010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
            DISPLAY BY NAME g_master.bgba010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba010
            #add-point:BEFORE FIELD bgba010 name="input.b.bgba010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba010
            #add-point:ON CHANGE bgba010 name="input.g.bgba010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba004_s
            #add-point:BEFORE FIELD bgba004_s name="input.b.bgba004_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba004_s
            
            #add-point:AFTER FIELD bgba004_s name="input.a.bgba004_s"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba004_s
            #add-point:ON CHANGE bgba004_s name="input.g.bgba004_s"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba004_e
            #add-point:BEFORE FIELD bgba004_e name="input.b.bgba004_e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba004_e
            
            #add-point:AFTER FIELD bgba004_e name="input.a.bgba004_e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba004_e
            #add-point:ON CHANGE bgba004_e name="input.g.bgba004_e"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbadocno
            
            #add-point:AFTER FIELD bgbadocno name="input.a.bgbadocno"
            #沖銷單別
            IF NOT cl_null(g_master.bgbadocno) THEN
               IF NOT s_aooi200_fin_chk_docno(g_ld,'','',g_master.bgbadocno,g_today,'abgt030') THEN
                  LET g_master.bgbadocno = ''
                  CALL s_aooi200_fin_get_slip_desc(g_master.bgbadocno) RETURNING g_master.bgbadocno_desc
                  DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.bgbadocno) RETURNING g_master.bgbadocno_desc
            DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbadocno
            #add-point:BEFORE FIELD bgbadocno name="input.b.bgbadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbadocno
            #add-point:ON CHANGE bgbadocno name="input.g.bgbadocno"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba001
            #add-point:ON ACTION controlp INFIELD bgba001 name="input.c.bgba001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgba001
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '1' "   #使用預測才可以開
            CALL q_bgaa001()
            LET g_master.bgba001 = g_qryparam.return1
            CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
            
            #預算週期/預算幣別
            LET g_master.bgba003 = ''
            LET g_master.bgba006 = ''
            SELECT bgaa002,bgaa003 INTO g_master.bgba003,g_master.bgba006
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgba001
            DISPLAY BY NAME g_master.bgba003,g_master.bgba006,g_master.bgba001_desc 
            
            NEXT FIELD bgba001
            #END add-point
 
 
         #Ctrlp:input.c.bgba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba002
            #add-point:ON ACTION controlp INFIELD bgba002 name="input.c.bgba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba006
            #add-point:ON ACTION controlp INFIELD bgba006 name="input.c.bgba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba010
            #add-point:ON ACTION controlp INFIELD bgba010 name="input.c.bgba010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgba010             #給予default值
            LET g_qryparam.where = " bgaistus = 'Y' AND bgai003 = '",g_user,"' AND (bgai005 = '07' OR bgai005 = '00')"
            IF NOT cl_null(g_master.bgba001) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_master.bgba001,"' "
            END IF            
            CALL q_bgai002()                                #呼叫開窗
            LET g_master.bgba010 = g_qryparam.return1
            CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
            DISPLAY BY NAME g_master.bgba010,g_master.bgba010_desc
            NEXT FIELD bgba010
            #END add-point
 
 
         #Ctrlp:input.c.bgba004_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba004_s
            #add-point:ON ACTION controlp INFIELD bgba004_s name="input.c.bgba004_s"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba004_e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba004_e
            #add-point:ON ACTION controlp INFIELD bgba004_e name="input.c.bgba004_e"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbadocno
            #add-point:ON ACTION controlp INFIELD bgbadocno name="input.c.bgbadocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbadocno
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = 'abgt030'
            CALL q_ooba002_1()
            LET g_master.bgbadocno = g_qryparam.return1
            CALL s_aooi200_fin_get_slip_desc(g_master.bgbadocno) RETURNING g_master.bgbadocno_desc
            DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
            NEXT FIELD bgbadocno
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgcj007
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="construct.c.bgcj007"
            #應用 a08 樣板自動產生(Version:3)
             #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #2.檢查預算組織是否在abgi090中可操作的組織中
            LET l_site_str = ''
            CALL s_abg2_get_budget_site(g_master.bgba001,'',g_user,'07') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",l_site_str
            END IF
            CALL q_ooef001()                       #呼叫開窗     
            DISPLAY g_qryparam.return1 TO bgcj007  #顯示到畫面上
            NEXT FIELD bgcj007                     #返回原欄位  
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="construct.b.bgcj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="construct.a.bgcj007"
            
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
            CALL abgp720_get_buffer(l_dialog)
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
            CALL abgp720_qbe_clear()
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
         CALL abgp720_init()
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
                 CALL abgp720_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp720_transfer_argv(ls_js)
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
 
{<section id="abgp720.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp720_transfer_argv(ls_js)
 
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
 
{<section id="abgp720.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp720_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql           STRING
   DEFINE l_docno         LIKE bgba_t.bgbadocno
   DEFINE l_bggm006       LIKE bggm_t.bggm006
   DEFINE l_bggm007       LIKE bggm_t.bggm007
   DEFINE l_bgcj049       LIKE bgcj_t.bgcj049
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cnt_diffCurr  LIKE type_t.num10
   DEFINE l_do            LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5

   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #wc處理
   IF cl_null(g_master.wc) THEN LET g_master.wc = " 1=1" END IF
   #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
   INITIALIZE g_bgaa.* TO NULL
   SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgba001
   LET g_master.bgba003 = g_bgaa.bgaa002 #預算週期
   LET g_master.bgba006 = g_bgaa.bgaa003 #預算幣別
   DISPLAY BY NAME g_master.bgba003,g_master.bgba006
 
   #根據各單身預算組織找主帳套
   LET g_ld = ''
   SELECT glaald INTO g_ld FROM glaa_t,ooef_t
    WHERE glaaent = g_enterprise AND glaacomp = ooef017 AND glaaent = ooefent AND ooef001 = g_bgaa.bgaa011 AND glaa014 = 'Y' 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp720_process_cs CURSOR FROM ls_sql
#  FOREACH abgp720_process_cs INTO
   #add-point:process段process name="process.process"
   #                            預算組織/ 期別     
   LET l_sql = " SELECT DISTINCT bggm006,bggm007   ",
               "   FROM bggm_t,bggn_t ",
               "  WHERE bggment = ",g_enterprise," ",
               "    AND bggm001 = '20'             ",
               "    AND bggm002 ='",g_master.bgba001,"'   AND bggm003 ='",g_master.bgba002,"'    ",
               "    AND bggm007 BETWEEN '",g_master.bgba004_s,"'                                 ",
               "    AND '",g_master.bgba004_e,"'   AND ",g_master.wc,
               "    AND bggm010 IS NULL AND bggmstus = 'FC' ",
               "    ORDER BY bggm007 "
   PREPARE abgp720_bggm_p FROM l_sql
   DECLARE abgp720_bggm_c CURSOR FOR abgp720_bggm_p
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   LET l_success = TRUE
   LET g_master.bgbadocno_1 = ''    LET g_master.bgbadocno_2 = ''
   LET l_do = 0 LET l_bggm006  = '' LET l_bggm007  = ''
   
   FOREACH abgp720_bggm_c INTO l_bggm006,l_bggm007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:sel_bggm_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF   
      #寫入單頭    
      CALL abgp720_ins_bgba(l_bggm007,l_bggm006) RETURNING g_sub_success,l_docno #銷售
      IF NOT g_sub_success THEN LET l_success = FALSE EXIT FOREACH END IF
      #寫入第一組產生的單號
      IF cl_null(g_master.bgbadocno_1) THEN LET g_master.bgbadocno_1 = l_docno END IF            
      #寫入單身
      CALL abgp720_ins_bgbb(l_bggm007,l_bggm006,l_docno)RETURNING g_sub_success
      IF NOT g_sub_success THEN LET l_success = FALSE EXIT FOREACH END IF
      
      #計算是否有預算幣別<>交易幣別
      LET l_cnt_diffCurr = 0
      SELECT COUNT(1) INTO l_cnt_diffCurr FROM bgbb_t WHERE bgbbent = g_enterprise AND bgbbdocno = l_docno AND bgbb008 <> g_master.bgba006
      IF cl_null(l_cnt_diffCurr) THEN LET l_cnt_diffCurr = 0 END IF
      
      #回寫單頭外幣憑證否(更新bgba_t:bgba009)
      IF l_cnt_diffCurr <> 0 THEN
         UPDATE bgba_t SET bgba009 = 'Y' WHERE bgbaent = g_enterprise AND bgbadocno = l_docno
      END IF
      
      #回寫來源table:bgcm010 憑證單號
      UPDATE bggm_t SET bggm010 = l_docno 
       WHERE bggment = g_enterprise 
         AND bggm001 = '20'             AND bggmstus = 'FC'
         AND bggm002 = g_master.bgba001 AND bggm003 = g_master.bgba002
         AND bggm006 = l_bggm006
         AND bggm007 = l_bggm007       
                 
      IF SQLCA.SQLCODE OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "UPD_bgmj_t:bggm010_ERR"
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH   
      END IF         
      
      LET l_do = l_do + 1  
   END FOREACH
   
   #是否有資料執行
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'   #無資料產生
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')     
      CALL cl_err_collect_show()        
      RETURN
   END IF
   
   #commit or rollback      
   IF l_success THEN
      #寫入最後一組產生的單號
      LET g_master.bgbadocno_2 = l_docno              
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_show()
      DISPLAY BY NAME g_master.bgbadocno_1,g_master.bgbadocno_2
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'   #失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')       
      CALL cl_err_collect_show()        
      CALL abgp720_qbe_clear()         
      RETURN      
   END IF
   
   
   
   
   
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
   CALL abgp720_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp720.get_buffer" >}
PRIVATE FUNCTION abgp720_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgba001 = p_dialog.getFieldBuffer('bgba001')
   LET g_master.bgba002 = p_dialog.getFieldBuffer('bgba002')
   LET g_master.bgba006 = p_dialog.getFieldBuffer('bgba006')
   LET g_master.bgba010 = p_dialog.getFieldBuffer('bgba010')
   LET g_master.bgba004_s = p_dialog.getFieldBuffer('bgba004_s')
   LET g_master.bgba004_e = p_dialog.getFieldBuffer('bgba004_e')
   LET g_master.bgbadocno = p_dialog.getFieldBuffer('bgbadocno')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp720.msgcentre_notify" >}
PRIVATE FUNCTION abgp720_msgcentre_notify()
 
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
 
{<section id="abgp720.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL abgp720_qbe_clear()
# Date & Author..: 2016/12/07 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp720_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL   #畫面變數清空
   LET g_master.bgba004_s = MONTH(g_today)
   LET g_master.bgba004_e = MONTH(g_today)
   
   DISPLAY BY NAME g_master.bgba004_s,g_master.bgba004_e 
END FUNCTION

################################################################################
# Descriptions...: 預算管理組織檢核
# Memo...........:
# Usage..........: CALL abgp720_bgai002_chk(p_bgai001,p_bgai002)
# Date & Author..: 2016/12/07 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp720_bgai002_chk(p_bgai001,p_bgai002)
DEFINE p_bgai001           LIKE bgai_t.bgai001
DEFINE p_bgai002           LIKE bgai_t.bgai002
DEFINE l_cnt               LIKE type_t.num5
DEFINE l_bgaistus          LIKE bgai_t.bgaistus
DEFINE l_bgai008           LIKE bgai_t.bgai008
DEFINE r_success           LIKE type_t.num5
DEFINE r_errno             LIKE gzze_t.gzze001

   LET r_errno = '' LET r_success = TRUE
   IF NOT cl_null(p_bgai002) THEN
      #存在否
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt FROM bgai_t
       WHERE bgaient=g_enterprise AND bgai002=p_bgai002
         AND bgai003 = g_user AND (bgai005 ='07' OR bgai005 = '00')
      IF l_cnt = 0 THEN
         LET r_errno = 'abg-00048'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      #有效否
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt FROM bgai_t
       WHERE bgaient=g_enterprise AND bgai002=p_bgai002 AND bgaistus='Y'
         AND bgai003 = g_user AND (bgai005 ='07' OR bgai005 = '00')
      IF l_cnt = 0 THEN
         LET r_errno = 'abg-00198'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
   END IF
   #預算編+預算管理組織是否存在
   IF NOT cl_null(p_bgai001) AND NOT cl_null(p_bgai002) THEN
      SELECT DISTINCT bgaistus    INTO l_bgaistus FROM bgai_t
       WHERE bgaient=g_enterprise AND bgai002=p_bgai002 AND bgai001=p_bgai001 
         AND bgai003 = g_user AND (bgai005 ='07' OR bgai005 = '00')
      CASE
         WHEN sqlca.sqlcode=100 
            LET r_errno = 'abg-00199'
            LET r_success = FALSE
            RETURN r_success,r_errno
         WHEN l_bgaistus<>'Y'  
            LET r_errno = 'abg-00200'
            LET r_success = FALSE
            RETURN r_success,r_errno
      END CASE     
   END IF
   
   RETURN r_success,r_errno
   
END FUNCTION

################################################################################
# Descriptions...: 產生傳票單頭檔
# Memo...........:
# Usage..........: CALL abgp720_ins_bgba(p_bgba004,p_bgba005)
# Input parameter: p_bgba004       預算期別
#                : p_bgba005       預算組織
# Date & Author..: 2016/12/07 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp720_ins_bgba(p_bgba004,p_bgba005)
DEFINE p_bgba004     LIKE bgba_t.bgba004 #預算期別
DEFINE p_bgba005     LIKE bgba_t.bgba005 #預算組織
DEFINE l_bgac002     LIKE bgac_t.bgac002
DEFINE l_bgba        RECORD
         bgbaent     LIKE bgba_t.bgbaent,   #企業代碼
         bgbadocno   LIKE bgba_t.bgbadocno, #傳票編號
         bgba001     LIKE bgba_t.bgba001,   #預算編號
         bgba002     LIKE bgba_t.bgba002,   #版本
         bgba003     LIKE bgba_t.bgba003,   #預算週期
         bgba004     LIKE bgba_t.bgba004,   #預算期別
         bgba005     LIKE bgba_t.bgba005,   #預算組織
         bgba006     LIKE bgba_t.bgba006,   #預算幣別
         bgba007     LIKE bgba_t.bgba007,   #資料來源
         bgba008     LIKE bgba_t.bgba008,   #列印次數
         bgba009     LIKE bgba_t.bgba009,   #外幣憑證否
         bgba010     LIKE bgba_t.bgba010,   #管理組織
         bgbaownid   LIKE bgba_t.bgbaownid, #資料所有者
         bgbaowndp   LIKE bgba_t.bgbaowndp, #資料所屬部門
         bgbacrtid   LIKE bgba_t.bgbacrtid, #資料建立者
         bgbacrtdp   LIKE bgba_t.bgbacrtdp, #資料建立部門
         bgbacrtdt   LIKE bgba_t.bgbacrtdt, #資料創建日
         bgbamodid   LIKE bgba_t.bgbamodid, #資料修改者
         bgbamoddt   LIKE bgba_t.bgbamoddt, #最近修改日
         bgbacnfid   LIKE bgba_t.bgbacnfid, #資料確認者
         bgbacnfdt   LIKE bgba_t.bgbacnfdt, #資料確認日
         bgbastus    LIKE bgba_t.bgbastus   #狀態碼
                     END RECORD
DEFINE r_success     LIKE type_t.num5 
DEFINE r_docno       LIKE bgba_t.bgbadocno

   #寫入單頭
   
   #取單別
   LET l_bgac002 = '' #期別最後一天
   SELECT MAX(bgac002) INTO l_bgac002 FROM bgac_t 
    WHERE bgacent = g_enterprise AND bgac001 = g_master.bgba003 AND bgac004 = p_bgba004
   CALL s_aooi200_fin_gen_docno(g_ld,'','',g_master.bgbadocno,l_bgac002,'abgt030')
      RETURNING r_success,r_docno
     
   INITIALIZE l_bgba.* TO NULL
   LET l_bgba.bgbaent   = g_enterprise   
   LET l_bgba.bgbadocno = r_docno
   LET l_bgba.bgba001   = g_master.bgba001
   LET l_bgba.bgba002   = g_master.bgba002   
   LET l_bgba.bgba003   = g_master.bgba003  
   LET l_bgba.bgba004   = p_bgba004
   LET l_bgba.bgba005   = p_bgba005
   LET l_bgba.bgba006   = g_master.bgba006
   LET l_bgba.bgba007   = '50' 
   LET l_bgba.bgba008   = 0
   LET l_bgba.bgba009   = 'N'  #單身完成後update
   LET l_bgba.bgba010   = g_master.bgba010
   LET l_bgba.bgbaownid = g_user
   LET l_bgba.bgbaowndp = g_dept
   LET l_bgba.bgbacrtid = g_user
   LET l_bgba.bgbacrtdp = g_dept
   LET l_bgba.bgbacrtdt = g_today
   LET l_bgba.bgbamodid = ''
   LET l_bgba.bgbamoddt = ''
   LET l_bgba.bgbacnfid = ''
   LET l_bgba.bgbacnfdt = ''
   LET l_bgba.bgbastus  = 'N'
      
   INSERT INTO bgba_t(bgbaent,bgbadocno,bgba001,bgba002,bgba003,   
                      bgba004,bgba005,bgba006,bgba007,bgba008,
                      bgba009,bgba010,bgbaownid,bgbaowndp,bgbacrtid,
                      bgbacrtdp,bgbacrtdt,bgbamodid,bgbamoddt,bgbacnfid,
                      bgbacnfdt,bgbastus)
               VALUES(l_bgba.bgbaent,l_bgba.bgbadocno,l_bgba.bgba001,l_bgba.bgba002,l_bgba.bgba003,   
                      l_bgba.bgba004,l_bgba.bgba005,l_bgba.bgba006,l_bgba.bgba007,l_bgba.bgba008,
                      l_bgba.bgba009,l_bgba.bgba010,l_bgba.bgbaownid,l_bgba.bgbaowndp,l_bgba.bgbacrtid,
                      l_bgba.bgbacrtdp,l_bgba.bgbacrtdt,l_bgba.bgbamodid,l_bgba.bgbamoddt,l_bgba.bgbacnfid,
                      l_bgba.bgbacnfdt,l_bgba.bgbastus)                           

         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INS_bgba_ERR_FROM_bggm"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            LET r_docno = ''
            RETURN r_success,r_docno
         END IF



   RETURN r_success,r_docno
 

END FUNCTION

################################################################################
# Descriptions...: 銷售預算寫入bgbb單身
# Memo...........:
# Usage..........: CALL abgp720_ins_bgbb(p_bgba004,p_bgba005,p_docno)
#                  RETURNING g_sub_success
# Input parameter: p_bgba004       預算期別
#                : p_bgba005       預算組織
#                : p_docno         單據號碼
# Return code....: g_sub_success   成功否
# Date & Author..: 2016/11/08 By   05016
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp720_ins_bgbb(p_bgba004,p_bgba005,p_docno)
DEFINE p_bgba004       LIKE bgba_t.bgba004
DEFINE p_bgba005       LIKE bgba_t.bgba005
DEFINE p_docno         LIKE bgba_t.bgbadocno
DEFINE l_bggo RECORD  #人工費用預算明細檔
       bggo012 LIKE bggo_t.bggo012, #人員
       bggo013 LIKE bggo_t.bggo013, #部門
       bggo014 LIKE bggo_t.bggo014, #成本利潤中心
       bggo015 LIKE bggo_t.bggo015, #區域
       bggo016 LIKE bggo_t.bggo016, #收付款供應商
       bggo017 LIKE bggo_t.bggo017, #帳款客商
       bggo018 LIKE bggo_t.bggo018, #客群
       bggo019 LIKE bggo_t.bggo019, #產品類別
       bggo020 LIKE bggo_t.bggo020, #專案編號
       bggo021 LIKE bggo_t.bggo021, #WBS
       bggo022 LIKE bggo_t.bggo022, #經營方式
       bggo023 LIKE bggo_t.bggo023, #通路
       bggo024 LIKE bggo_t.bggo024, #品牌
       bggo025 LIKE bggo_t.bggo025, #自由核算項一
       bggo026 LIKE bggo_t.bggo026, #自由核算項二
       bggo027 LIKE bggo_t.bggo027, #自由核算項三
       bggo028 LIKE bggo_t.bggo028, #自由核算項四
       bggo029 LIKE bggo_t.bggo029, #自由核算項五
       bggo030 LIKE bggo_t.bggo030, #自由核算項六
       bggo031 LIKE bggo_t.bggo031, #自由核算項七
       bggo032 LIKE bggo_t.bggo032, #自由核算項八
       bggo033 LIKE bggo_t.bggo033, #自由核算項九
       bggo034 LIKE bggo_t.bggo034, #自由核算項十
       bggo039 LIKE bggo_t.bggo039, #借方預算細項
       bggo040 LIKE bggo_t.bggo040, #貸方預算細項
       bggo100 LIKE bggo_t.bggo100, #幣別
       bggo101 LIKE bggo_t.bggo101, #匯率
       bggo106 LIKE bggo_t.bggo106  #核准金額
END RECORD
DEFINE l_bgbb    RECORD  #預算憑證單身檔
       bgbbent   LIKE bgbb_t.bgbbent, #企業編號
       bgbb001   LIKE bgbb_t.bgbb001, #預算編號
       bgbbdocno LIKE bgbb_t.bgbbdocno, #單據編號
       bgbbseq   LIKE bgbb_t.bgbbseq, #項次
       bgbb002   LIKE bgbb_t.bgbb002, #預算細項
       bgbb003   LIKE bgbb_t.bgbb003, #借方金額
       bgbb004   LIKE bgbb_t.bgbb004, #貸方金額
       bgbb005   LIKE bgbb_t.bgbb005, #計量單位
       bgbb006   LIKE bgbb_t.bgbb006, #數量
       bgbb007   LIKE bgbb_t.bgbb007, #单价
       bgbb008   LIKE bgbb_t.bgbb008, #交易幣別
       bgbb009   LIKE bgbb_t.bgbb009, #汇率
       bgbb010   LIKE bgbb_t.bgbb010, #原幣金額
       bgbb011   LIKE bgbb_t.bgbb011, #部門
       bgbb012   LIKE bgbb_t.bgbb012, #利潤成本中心
       bgbb013   LIKE bgbb_t.bgbb013, #區域
       bgbb014   LIKE bgbb_t.bgbb014, #收付款客商
       bgbb015   LIKE bgbb_t.bgbb015, #帳款客商
       bgbb016   LIKE bgbb_t.bgbb016, #客群
       bgbb017   LIKE bgbb_t.bgbb017, #產品類別
       bgbb018   LIKE bgbb_t.bgbb018, #人員
       bgbb019   LIKE bgbb_t.bgbb019, #專案編號
       bgbb020   LIKE bgbb_t.bgbb020, #WBS
       bgbb021   LIKE bgbb_t.bgbb021, #經營方式
       bgbb022   LIKE bgbb_t.bgbb022, #通路
       bgbb023   LIKE bgbb_t.bgbb023, #品牌
       bgbb024   LIKE bgbb_t.bgbb024, #現金碼
       bgbb025   LIKE bgbb_t.bgbb025, #自由核算項一
       bgbb026   LIKE bgbb_t.bgbb026, #自由核算項二
       bgbb027   LIKE bgbb_t.bgbb027, #自由核算項三
       bgbb028   LIKE bgbb_t.bgbb028, #自由核算項四
       bgbb029   LIKE bgbb_t.bgbb029, #自由核算項五
       bgbb030   LIKE bgbb_t.bgbb030, #自由核算項六
       bgbb031   LIKE bgbb_t.bgbb031, #自由核算項七
       bgbb032   LIKE bgbb_t.bgbb032, #自由核算項八
       bgbb033   LIKE bgbb_t.bgbb033, #自由核算項九
       bgbb034   LIKE bgbb_t.bgbb034  #自由核算項十

END RECORD

DEFINE l_sql           STRING
DEFINE l_seq           LIKE type_t.num10
DEFINE l_i             LIKE type_t.num10                       
DEFINE l_bgae004       LIKE bgae_t.bgae004   #資產損益別      
DEFINE l_bgaq009       LIKE bgaq_t.bgaq009   #帳款類別
DEFINE l_comp          LIKE glaa_t.glaacomp
DEFINE l_site_ld       LIKE glaa_t.glaald
DEFINE l_bgao004       LIKE bgao_t.bgao004   #預算細項編號
DEFINE r_success       LIKE type_t.num5 

   LET l_seq = 0 
   LET r_success = TRUE


   LET l_sql =" SELECT bggo012,bggo013,bggo014,                     ",
              "        bggo015,bggo016,bggo017,bggo018,bggo019,     ",
              "        bggo020,bggo021,bggo022,bggo023,bggo024,     ",
              "        bggo025,bggo026,bggo027,bggo028,bggo029,     ",
              "        bggo030,bggo031,bggo032,bggo033,bggo034,     ",
              "        bggo039,bggo040,bggo100,bggo101,SUM(bggo106) ",
              "  FROM bggo_t                                   ",
              " WHERE bggoent = '",g_enterprise,"'             ",
              "   AND bggo001 = '20'                           ",
              "   AND bggo002 = '",g_master.bgba001,"'         ",
              "   AND bggo003 = '",g_master.bgba002,"'         ",
              "   AND bggo007 = '",p_bgba005,"'                ",
              "   AND bggo008 = '",p_bgba004,"'                ",
              "   GROUP BY bggo012,bggo013,bggo014,bggo015,bggo016,bggo017,bggo018,bggo019,bggo020,bggo021,bggo022,bggo023,bggo024, ",
              "            bggo025,bggo026,bggo027,bggo028,bggo029,bggo030,bggo031,bggo032,bggo033,bggo034,",
              "            bggo039,bggo040,bggo100,bggo101 ",          
              "   ORDER BY bggo012,bggo013,bggo014,bggo015,bggo016,bggo017,bggo018,bggo019,bggo020,bggo021,bggo022,bggo023,bggo024, ",
              "            bggo025,bggo026,bggo027,bggo028,bggo029,bggo030,bggo031,bggo032,bggo033,bggo034,                         ",
              "            bggo039,bggo040,bggo100,bggo101                                                                  "              
              
   PREPARE abgp720_bgao_p FROM l_sql
   DECLARE abgp720_bgao_c CURSOR FOR abgp720_bgao_p
   FOREACH abgp720_bgao_c INTO l_bggo.*      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:abgp720_bgao_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_bgbb.* TO NULL
      LET l_seq = l_seq +1 
      LET l_bgbb.bgbbent   = g_enterprise
      LET l_bgbb.bgbb001   = g_master.bgba001
      LET l_bgbb.bgbbdocno = p_docno
      LET l_bgbb.bgbb005   = ''             #計量單位
      LET l_bgbb.bgbb006   = 0              #數量
      LET l_bgbb.bgbb007   = 0              #單價
      LET l_bgbb.bgbb008   = l_bggo.bggo100 #交易幣別
      LET l_bgbb.bgbb009   = l_bggo.bggo101   #匯率
      LET l_bgbb.bgbb010   = l_bggo.bggo106   #原幣金額
      LET l_bgbb.bgbb011   = l_bggo.bggo013   #部門
      LET l_bgbb.bgbb012   = l_bggo.bggo014   #利潤成本中心
      LET l_bgbb.bgbb013   = l_bggo.bggo015   #區域
      LET l_bgbb.bgbb014   = l_bggo.bggo016   #收付款客商
      LET l_bgbb.bgbb015   = l_bggo.bggo017   #帳款客商
      LET l_bgbb.bgbb016   = l_bggo.bggo018   #客群
      LET l_bgbb.bgbb017   = l_bggo.bggo019   #產品類別
      LET l_bgbb.bgbb018   = l_bggo.bggo012   #人員
      LET l_bgbb.bgbb019   = l_bggo.bggo020   #專案編號
      LET l_bgbb.bgbb020   = l_bggo.bggo021   #WBS
      LET l_bgbb.bgbb021   = l_bggo.bggo022   #經營方式
      LET l_bgbb.bgbb022   = l_bggo.bggo023   #通路
      LET l_bgbb.bgbb023   = l_bggo.bggo024   #品牌
      LET l_bgbb.bgbb024   = ' '              #現金碼
      LET l_bgbb.bgbb025   = l_bggo.bggo025   #自由核算項一
      LET l_bgbb.bgbb026   = l_bggo.bggo026   #自由核算項二
      LET l_bgbb.bgbb027   = l_bggo.bggo027   #自由核算項三
      LET l_bgbb.bgbb028   = l_bggo.bggo028   #自由核算項四
      LET l_bgbb.bgbb029   = l_bggo.bggo029   #自由核算項五
      LET l_bgbb.bgbb030   = l_bggo.bggo030   #自由核算項六
      LET l_bgbb.bgbb031   = l_bggo.bggo031   #自由核算項七
      LET l_bgbb.bgbb032   = l_bggo.bggo032   #自由核算項八
      LET l_bgbb.bgbb033   = l_bggo.bggo033   #自由核算項九
      LET l_bgbb.bgbb034   = l_bggo.bggo034   #自由核算項十
      #單身寫入-----------------------借方
      LET l_bgbb.bgbbseq   = l_seq
      LET l_bgbb.bgbb002   = l_bggo.bggo039 #借方科目   
      LET l_bgbb.bgbb003   = l_bggo.bggo106*l_bggo.bggo101  #借方金額
      LET l_bgbb.bgbb004   = 0              #貸方金額      
       INSERT INTO bgbb_t(bgbbent,bgbb001,bgbbdocno,bgbbseq,bgbb002,
                        bgbb003,bgbb004,bgbb005,bgbb006,bgbb007,
                        bgbb008,bgbb009,bgbb010,bgbb011,bgbb012,
                        bgbb013,bgbb014,bgbb015,bgbb016,bgbb017,
                        bgbb018,bgbb019,bgbb020,bgbb021,bgbb022,
                        bgbb023,bgbb024,bgbb025,bgbb026,bgbb027,
                        bgbb028,bgbb029,bgbb030,bgbb031,bgbb032,
                        bgbb033,bgbb034)
           VALUES(g_enterprise,l_bgbb.bgbb001,l_bgbb.bgbbdocno,l_bgbb.bgbbseq,l_bgbb.bgbb002,
                  l_bgbb.bgbb003,l_bgbb.bgbb004,l_bgbb.bgbb005,l_bgbb.bgbb006,l_bgbb.bgbb007,
                  l_bgbb.bgbb008,l_bgbb.bgbb009,l_bgbb.bgbb010,l_bgbb.bgbb011,l_bgbb.bgbb012,
                  l_bgbb.bgbb013,l_bgbb.bgbb014,l_bgbb.bgbb015,l_bgbb.bgbb016,l_bgbb.bgbb017,
                  l_bgbb.bgbb018,l_bgbb.bgbb019,l_bgbb.bgbb020,l_bgbb.bgbb021,l_bgbb.bgbb022,
                  l_bgbb.bgbb023,l_bgbb.bgbb024,l_bgbb.bgbb025,l_bgbb.bgbb026,l_bgbb.bgbb027,
                  l_bgbb.bgbb028,l_bgbb.bgbb029,l_bgbb.bgbb030,l_bgbb.bgbb031,l_bgbb.bgbb032,
                  l_bgbb.bgbb033,l_bgbb.bgbb034) 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INS_ERR_FROM_bggo_1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF                
      #單身寫入-----------------------貸方             
      LET l_seq = l_seq +1 
      LET l_bgbb.bgbbseq  = l_seq
      LET l_bgbb.bgbb002  = l_bggo.bggo040 #貸方科目
      LET l_bgbb.bgbb003  = 0              #借方金額
      LET l_bgbb.bgbb004  = l_bggo.bggo106 *l_bggo.bggo101 #貸方金額       
      INSERT INTO bgbb_t(bgbbent,bgbb001,bgbbdocno,bgbbseq,bgbb002,
                        bgbb003,bgbb004,bgbb005,bgbb006,bgbb007,
                        bgbb008,bgbb009,bgbb010,bgbb011,bgbb012,
                        bgbb013,bgbb014,bgbb015,bgbb016,bgbb017,
                        bgbb018,bgbb019,bgbb020,bgbb021,bgbb022,
                        bgbb023,bgbb024,bgbb025,bgbb026,bgbb027,
                        bgbb028,bgbb029,bgbb030,bgbb031,bgbb032,
                        bgbb033,bgbb034)
           VALUES(g_enterprise,l_bgbb.bgbb001,l_bgbb.bgbbdocno,l_bgbb.bgbbseq,l_bgbb.bgbb002,
                  l_bgbb.bgbb003,l_bgbb.bgbb004,l_bgbb.bgbb005,l_bgbb.bgbb006,l_bgbb.bgbb007,
                  l_bgbb.bgbb008,l_bgbb.bgbb009,l_bgbb.bgbb010,l_bgbb.bgbb011,l_bgbb.bgbb012,
                  l_bgbb.bgbb013,l_bgbb.bgbb014,l_bgbb.bgbb015,l_bgbb.bgbb016,l_bgbb.bgbb017,
                  l_bgbb.bgbb018,l_bgbb.bgbb019,l_bgbb.bgbb020,l_bgbb.bgbb021,l_bgbb.bgbb022,
                  l_bgbb.bgbb023,l_bgbb.bgbb024,l_bgbb.bgbb025,l_bgbb.bgbb026,l_bgbb.bgbb027,
                  l_bgbb.bgbb028,l_bgbb.bgbb029,l_bgbb.bgbb030,l_bgbb.bgbb031,l_bgbb.bgbb032,
                  l_bgbb.bgbb033,l_bgbb.bgbb034) 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INS_ERR_FROM_bggo_2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH             
      END IF                                   
   END FOREACH   
       
   RETURN r_success            
END FUNCTION

#end add-point
 
{</section>}
 