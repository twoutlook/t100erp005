#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp020.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2017-02-08 17:29:28), PR版次:0004(2017-02-08 17:46:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: abgp020
#+ Description: 產生滾動預算
#+ Creator....: 03080(2015-09-03 15:33:57)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgp020.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161006-00005#10   161020    By 08732      組織類型與職能開窗調整
#170116-00074#6    170207    By 05016      畫面修改 1.預算編號開窗: 不限定使用預測否 皆要開窗 2.單身帶出 abgi090 有權限的組織 , 可操作模組=財務或 ALL 
  

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
   bgaf001 LIKE bgaf_t.bgaf001,
   bgaf002 LIKE bgaf_t.bgaf002,
   bgaf003 LIKE bgaf_t.bgaf003,
   bgaf004 LIKE bgaf_t.bgaf004,
   bgaf005 LIKE bgaf_t.bgaf005,
   bgaf006 LIKE bgaf_t.bgaf006,
   bgaa005 LIKE bgaa_t.bgaa005,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       bgaf004 LIKE type_t.chr10, 
   bgaf004_desc LIKE type_t.chr80, 
   bgaa002 LIKE type_t.chr500, 
   bgaf005 LIKE type_t.chr10, 
   bgaf006 LIKE type_t.chr1, 
   bgaa005 LIKE type_t.chr10, 
   bgaf001 LIKE type_t.chr10, 
   bgaf001_desc LIKE type_t.chr80, 
   bgaf002 LIKE type_t.dat, 
   bgaf003 LIKE type_t.dat, 
   bgae005 LIKE type_t.chr500, 
   bgae001 LIKE type_t.chr500, 
   glac002 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 

DEFINE g_master_o type_master
DEFINE g_userorga        STRING   #161006-00005#10   add
#161006-00005#10 ---s---
TYPE type_g_detail_d RECORD 
   sel           LIKE type_t.chr1,
   bgbc003       LIKE bgbc_t.bgbc003,
   bgbc003_desc  LIKE type_t.chr500
END RECORD
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
#161006-00005#10 ---e---
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp020.main" >}
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
      CALL abgp020_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp020 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp020_init()
 
      #進入選單 Menu (="N")
      CALL abgp020_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp020
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp020.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp020_init()
 
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
   CALL cl_set_combo_scc('bgaf006','9991') 
   CALL cl_set_combo_scc('bgaa005',9401)
   CALL cl_set_combo_scc('bgae005','9407')
   #170116-00074#6 ---s---
   #161006-00005#910  mark ---s
   #CALL s_fin_create_account_center_tmp()   
   #CALL s_fin_azzi800_sons_query(g_today)
   #CALL s_fin_account_center_sons_str() RETURNING g_userorga
   #CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161006-00005#10  add ---e
   #170116-00074#6 mark ---e---
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp020.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp020_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_bgaa012   LIKE bgaa_t.bgaa012
   DEFINE l_bgaa008   LIKE bgaa_t.bgaa008
   DEFINE l_orga      STRING   #161006-00005#10   add
   DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料) #161006-00005#10 
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL abgp020_qbeclear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgaf004,g_master.bgaf005,g_master.bgaf006,g_master.bgaa005,g_master.bgaf001, 
             g_master.bgaf002,g_master.bgaf003 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaf004
            
            #add-point:AFTER FIELD bgaf004 name="input.a.bgaf004"
            #170116-00074#6  ---s---
            IF NOT cl_null(g_master.bgaf004) THEN               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgaf004
               LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
               IF cl_chk_exist("v_bgaa001") THEN
               ELSE
                  NEXT FIELD bgaf004
               END IF
               SELECT bgaa002 INTO g_master.bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bgaf004              
            END IF
               CALL s_desc_get_budget_desc(g_master.bgaf004) RETURNING g_master.bgaf004_desc
               DISPLAY BY NAME g_master.bgaf004_desc,g_master.bgaa002 
            #170116-00074#6  ---e---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaf004
            #add-point:BEFORE FIELD bgaf004 name="input.b.bgaf004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaf004
            #add-point:ON CHANGE bgaf004 name="input.g.bgaf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaf005
            #add-point:BEFORE FIELD bgaf005 name="input.b.bgaf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaf005
            
            #add-point:AFTER FIELD bgaf005 name="input.a.bgaf005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaf005
            #add-point:ON CHANGE bgaf005 name="input.g.bgaf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaf006
            #add-point:BEFORE FIELD bgaf006 name="input.b.bgaf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaf006
            
            #add-point:AFTER FIELD bgaf006 name="input.a.bgaf006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaf006
            #add-point:ON CHANGE bgaf006 name="input.g.bgaf006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa005
            #add-point:BEFORE FIELD bgaa005 name="input.b.bgaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa005
            
            #add-point:AFTER FIELD bgaa005 name="input.a.bgaa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa005
            #add-point:ON CHANGE bgaa005 name="input.g.bgaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaf001
            
            #add-point:AFTER FIELD bgaf001 name="input.a.bgaf001"
            
            LET g_master.bgaf001_desc = ' '
            DISPLAY BY NAME g_master.bgaf001_desc
            IF NOT cl_null(g_master.bgaf001) THEN
               IF g_master.bgaf001 != g_master_o.bgaf001 OR g_master_o.bgaf001 IS NULL THEN
                  CALL abgp020_bgaf001_chk(g_master.bgaf001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgaf001 = g_master_o.bgaf001
                     LET g_master.bgaf001_desc = s_desc_get_department_desc(g_master.bgaf001)
                     DISPLAY BY NAME g_master.bgaf001,g_master.bgaf001_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.bgaf001) AND NOT cl_null(g_master.bgaf002)
                     AND NOT cl_null(g_master.bgaf003)THEN
                     CALL abgp020_bgaf_chk(g_master.bgaf001,g_master.bgaf002,g_master.bgaf003)
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.bgaf001 = g_master_o.bgaf001
                        LET g_master.bgaf001_desc = s_desc_get_department_desc(g_master.bgaf001)
                        DISPLAY BY NAME g_master.bgaf001,g_master.bgaf001_desc
                        NEXT FIELD CURRENT
                     END IF
                     
                     CALL abgp020_bgaf_carry(g_master.bgaf001,g_master.bgaf002,g_master.bgaf003)
                  END IF
               END IF
            END IF
            LET g_master.bgaf001_desc = s_desc_get_department_desc(g_master.bgaf001)
            DISPLAY BY NAME g_master.bgaf001,g_master.bgaf001_desc            
            LET g_master_o.bgaf001 = g_master.bgaf001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaf001
            #add-point:BEFORE FIELD bgaf001 name="input.b.bgaf001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaf001
            #add-point:ON CHANGE bgaf001 name="input.g.bgaf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaf002
            #add-point:BEFORE FIELD bgaf002 name="input.b.bgaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaf002
            
            #add-point:AFTER FIELD bgaf002 name="input.a.bgaf002"
            IF NOT cl_null(g_master.bgaf002) THEN
               IF g_master.bgaf002 != g_master_o.bgaf002 OR g_master_o.bgaf002 IS NULL THEN
                  
                  IF NOT cl_null(g_master.bgaf001) AND NOT cl_null(g_master.bgaf002)
                     AND NOT cl_null(g_master.bgaf003)THEN
                     CALL abgp020_bgaf_chk(g_master.bgaf001,g_master.bgaf002,g_master.bgaf003)
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.bgaf001 = g_master_o.bgaf001
                        LET g_master.bgaf001_desc = s_desc_get_department_desc(g_master.bgaf001)
                        DISPLAY BY NAME g_master.bgaf001,g_master.bgaf001_desc
                        NEXT FIELD CURRENT
                     END IF
                     
                     CALL abgp020_bgaf_carry(g_master.bgaf001,g_master.bgaf002,g_master.bgaf003)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaf002
            #add-point:ON CHANGE bgaf002 name="input.g.bgaf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaf003
            #add-point:BEFORE FIELD bgaf003 name="input.b.bgaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaf003
            
            #add-point:AFTER FIELD bgaf003 name="input.a.bgaf003"
            IF NOT cl_null(g_master.bgaf003) THEN
               IF g_master.bgaf003 != g_master_o.bgaf003 OR g_master_o.bgaf003 IS NULL THEN
                  
                  IF NOT cl_null(g_master.bgaf001) AND NOT cl_null(g_master.bgaf002)
                     AND NOT cl_null(g_master.bgaf003)THEN
                     CALL abgp020_bgaf_chk(g_master.bgaf001,g_master.bgaf002,g_master.bgaf003)
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.bgaf001 = g_master_o.bgaf001
                        LET g_master.bgaf001_desc = s_desc_get_department_desc(g_master.bgaf001)
                        DISPLAY BY NAME g_master.bgaf001,g_master.bgaf001_desc
                        NEXT FIELD CURRENT
                     END IF
                     
                     CALL abgp020_bgaf_carry(g_master.bgaf001,g_master.bgaf002,g_master.bgaf003)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaf003
            #add-point:ON CHANGE bgaf003 name="input.g.bgaf003"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaf004
            #add-point:ON ACTION controlp INFIELD bgaf004 name="input.c.bgaf004"
            #170116-00074#6 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgaf004
            LET g_qryparam.where = "bgaastus = 'Y'"
            CALL q_bgaa001_1() 
            LET g_master.bgaf004 = g_qryparam.return1
            LET g_master.bgaf004_desc = s_desc_get_budget_desc(g_master.bgaf004)
            DISPLAY BY NAME g_master.bgaf004,g_master.bgaf004_desc
            NEXT FIELD bgaf004
            #170116-00074#6 ---e---
            #END add-point
 
 
         #Ctrlp:input.c.bgaf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaf005
            #add-point:ON ACTION controlp INFIELD bgaf005 name="input.c.bgaf005"
 
            #END add-point
 
 
         #Ctrlp:input.c.bgaf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaf006
            #add-point:ON ACTION controlp INFIELD bgaf006 name="input.c.bgaf006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa005
            #add-point:ON ACTION controlp INFIELD bgaa005 name="input.c.bgaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaf001
            #add-point:ON ACTION controlp INFIELD bgaf001 name="input.c.bgaf001"
            #161006-00005#10  add----s
            CALL s_fin_abg_center_sons_query(g_master.bgaf001,'','')  
            CALL s_fin_account_center_sons_str() RETURNING l_orga  
            CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            #161006-00005#10  add----e
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgaf001  #給予default值
            #LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) "        #161006-00005#10   mark
            LET g_qryparam.where = " ooef001 IN ", g_userorga," AND ooef001 IN ", l_orga   #161006-00005#10   add
            #CALL q_ooef001()     #161006-00005#10   mark
            CALL q_ooef001_77()   #161006-00005#10   add
            LET g_master.bgaf001 = g_qryparam.return1
            DISPLAY BY NAME g_master.bgaf001 
            NEXT FIELD bgaf001
            #END add-point
 
 
         #Ctrlp:input.c.bgaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaf002
            #add-point:ON ACTION controlp INFIELD bgaf002 name="input.c.bgaf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgaf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaf003
            #add-point:ON ACTION controlp INFIELD bgaf003 name="input.c.bgaf003"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgae005,bgae001,glac002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae005
            #add-point:BEFORE FIELD bgae005 name="construct.b.bgae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae005
            
            #add-point:AFTER FIELD bgae005 name="construct.a.bgae005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae005
            #add-point:ON ACTION controlp INFIELD bgae005 name="construct.c.bgae005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae001
            #add-point:BEFORE FIELD bgae001 name="construct.b.bgae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae001
            
            #add-point:AFTER FIELD bgae001 name="construct.a.bgae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae001
            #add-point:ON ACTION controlp INFIELD bgae001 name="construct.c.bgae001"
            #抓取走科目預算否
            LET l_bgaa012 = NULL   LET l_bgaa008 = NULL
            SELECT bgaa012 ,bgaa008
              INTO l_bgaa012,l_bgaa008
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgaf004
            
            
            IF l_bgaa012 = 'Y' THEN
               #抓取會計科目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "glac001 = '",l_bgaa008,"' AND  glac003 <>'1' "               #glac001(會計科目參照表)/glac003(科>
               CALL aglt310_04()
               DISPLAY g_qryparam.return1 TO bgae001
               NEXT FIELD CURRENT
            ELSE
               #抓取預算項目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " bgae006 = '",l_bgaa008,"' AND bgae007 = '1' "  #存在預算編號的預算項目參照表
               CALL q_bgae001()
               DISPLAY g_qryparam.return1 TO bgae001
               NEXT FIELD CURRENT
            END IF
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac002
            #add-point:BEFORE FIELD glac002 name="construct.b.glac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac002
            
            #add-point:AFTER FIELD glac002 name="construct.a.glac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac002
            #add-point:ON ACTION controlp INFIELD glac002 name="construct.c.glac002"
            #抓取走科目預算否
            LET l_bgaa012 = NULL   LET l_bgaa008 = NULL
            SELECT bgaa012 ,bgaa008
              INTO l_bgaa012,l_bgaa008
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgaf004
            
            
            IF l_bgaa012 = 'Y' THEN
               #抓取會計科目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "glac001 = '",l_bgaa008,"' AND  glac003 <>'1' "               #glac001(會計科目參照表)/glac003(科>
               CALL aglt310_04()
               DISPLAY g_qryparam.return1 TO glac002
               NEXT FIELD CURRENT
            ELSE
               #抓取預算項目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " bgae006 = '",l_bgaa008,"' AND bgae007 = '1' "  #存在預算編號的預算項目參照表
               CALL q_bgae001()
               DISPLAY g_qryparam.return1 TO glac002
               NEXT FIELD CURRENT
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
         #161006-00005#10 ---s---
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)                                        
            BEFORE ROW

         END INPUT
         #161006-00005#10 ---e---
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL abgp020_get_buffer(l_dialog)
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
            CALL abgp020_qbeclear()
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
         #170116-00074#6 ---s---
         ON ACTION accept
            CALL abgp020_b_fill()

         #170116-00074#6 ---e---   
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
         CALL abgp020_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.bgaf001 = g_master.bgaf001
      LET lc_param.bgaf002 = g_master.bgaf002
      LET lc_param.bgaf003 = g_master.bgaf003
      LET lc_param.bgaf004 = g_master.bgaf004
      LET lc_param.bgaf005 = g_master.bgaf005
      LET lc_param.bgaf006 = g_master.bgaf006
      LET lc_param.bgaa005 = g_master.bgaa005
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
                 CALL abgp020_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp020_transfer_argv(ls_js)
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
 
{<section id="abgp020.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp020_transfer_argv(ls_js)
 
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
 
{<section id="abgp020.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp020_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5      #170116-00074#6 
   #170116-00074#6 ---s---
   DEFINE l_bgaf  RECORD
          bgaf001 LIKE bgaf_t.bgaf001,
          bgaf002 LIKE bgaf_t.bgaf002,
          bgaf003 LIKE bgaf_t.bgaf003,
          bgaf004 LIKE bgaf_t.bgaf004,
          bgaf005 LIKE bgaf_t.bgaf005,
          bgaf006 LIKE bgaf_t.bgaf006,
          bgaa005 LIKE bgaa_t.bgaa005,
          wc      STRING
      END RECORD
   DEFINE l_do    LIKE type_t.num5
   DEFINE l_ask   LIKE type_t.chr1
   #170116-00074#6---e---
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #170116-00074#6 ---s---
   INITIALIZE l_bgaf.* TO NULL   
   #編制匯率
   LET l_bgaf.wc = " 1=1" LET l_ask = 'N'
   SELECT bgaa005 INTO l_bgaf.bgaa005 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bgaf004
   LET l_bgaf.bgaf004 = g_master.bgaf004
   CALL s_transaction_begin()   
   CALL cl_err_collect_init()
   FOR l_n = 1 TO g_detail_d.getLength()   
      IF g_detail_d[l_n].sel = "Y" THEN
         SELECT DISTINCT bgaf002,bgaf003,bgaf005,bgaf006      #起始日期/截止日期/執行預算版本/滾動週期
           INTO l_bgaf.bgaf002,l_bgaf.bgaf003,
                l_bgaf.bgaf005,l_bgaf.bgaf006
           FROM bgaf_t
          WHERE bgafent = g_enterprise
            AND bgaf001 = g_detail_d[l_n].bgbc003  #預算組織
            AND bgaf004 = g_master.bgaf004         #預算編號  
         IF cl_null(l_bgaf.bgaf002) OR cl_null(l_bgaf.bgaf003) OR cl_null(l_bgaf.bgaf005) OR cl_null(l_bgaf.bgaf006) THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = 'abg-00111'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()                                    
            LET l_success = FALSE
            EXIT FOR
         END IF         
         LET l_bgaf.bgaf001 = g_detail_d[l_n].bgbc003
         LET ls_js = util.JSON.stringify(l_bgaf)              
         LET l_success = TRUE         
         CALL s_abgp020_ins_bgbd_count(ls_js)RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            CASE
               WHEN g_errno = 'abg-00113'
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = 'bgbd_count:'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT FOR
               WHEN g_errno = 'abg-00115'
                  IF l_ask = 'N' THEN  
                     IF cl_ask_confirm('abg-00114')THEN           #詢問已經產生過 是否重複產生            
                        LET l_ask = 'Y'                           #已經詢問過
                        CALL s_abgp020_del_bgbd(ls_js)RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET l_success = FALSE
                           EXIT FOR
                        END IF
                     ELSE
                        LET l_success = FALSE 
                        EXIT FOR
                     END IF
                  ELSE                  
                    CALL s_abgp020_del_bgbd(ls_js)RETURNING g_sub_success
                    IF NOT g_sub_success THEN
                       LET l_success = FALSE
                       EXIT FOR
                    END IF             
                  END IF
                  IF NOT l_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = 'bgbd_count:'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()               
                     EXIT FOR
                  END IF
            END CASE
         END IF
         IF l_success THEN
            CALL s_abgp020_ins_bgbd(ls_js)RETURNING l_success
         END IF
      END IF
   END FOR
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()
   #170116-00074#6 ---e---
   
   
   #170116-00074#6 mark ---s---
   #LET l_success = TRUE
   #CALL s_abgp020_ins_bgbd_count(ls_js)RETURNING g_sub_success,g_errno
   #IF NOT g_sub_success THEN
   #   CASE
   #      WHEN g_errno = 'abg-00113'
   #         INITIALIZE g_errparam.* TO NULL
   #         LET g_errparam.code = g_errno
   #         LET g_errparam.extend = 'bgbd_count:'
   #         LET g_errparam.popup = TRUE
   #         CALL cl_err()
   #         LET l_success = FALSE
   #      WHEN g_errno = 'abg-00115'
   #         IF cl_ask_confirm('abg-00114')THEN
   #            CALL s_abgp020_del_bgbd(ls_js)RETURNING g_sub_success
   #            IF NOT g_sub_success THEN
   #               LET l_success = FALSE
   #            END IF
   #         ELSE
   #            LET l_success = FALSE 
   #         END IF
   #         IF NOT l_success THEN
   #            INITIALIZE g_errparam.* TO NULL
   #            LET g_errparam.code = g_errno
   #            LET g_errparam.extend = 'bgbd_count:'
   #            LET g_errparam.popup = TRUE
   #            CALL cl_err()               
   #         END IF
   #   END CASE
   #END IF
   #
   #IF l_success THEN
   #   CALL s_transaction_begin()
   #   CALL cl_err_collect_init()
   #   CALL s_abgp020_ins_bgbd(ls_js)RETURNING g_sub_success
   #   IF g_sub_success THEN
   #      CALL s_transaction_end('Y','0')
   #   ELSE
   #      CALL s_transaction_end('N','0')
   #   END IF
   #   CALL cl_err_collect_show()
   #END IF
   #170116-00074#6 ---e---
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp020_process_cs CURSOR FROM ls_sql
#  FOREACH abgp020_process_cs INTO
   #add-point:process段process name="process.process"
   
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
   CALL abgp020_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp020.get_buffer" >}
PRIVATE FUNCTION abgp020_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgaf004 = p_dialog.getFieldBuffer('bgaf004')
   LET g_master.bgaf005 = p_dialog.getFieldBuffer('bgaf005')
   LET g_master.bgaf006 = p_dialog.getFieldBuffer('bgaf006')
   LET g_master.bgaa005 = p_dialog.getFieldBuffer('bgaa005')
   LET g_master.bgaf001 = p_dialog.getFieldBuffer('bgaf001')
   LET g_master.bgaf002 = p_dialog.getFieldBuffer('bgaf002')
   LET g_master.bgaf003 = p_dialog.getFieldBuffer('bgaf003')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp020.msgcentre_notify" >}
PRIVATE FUNCTION abgp020_msgcentre_notify()
 
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
 
{<section id="abgp020.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 執行預算設定檢核
# Memo...........:
# Usage..........: 
# Date & Author..: 150903 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp020_bgaf_chk(p_bgaf001,p_bgaf002,p_bgaf003)
   DEFINE p_bgaf001   LIKE bgaf_t.bgaf001
   DEFINE p_bgaf002   LIKE bgaf_t.bgaf002
   DEFINE p_bgaf003   LIKE bgaf_t.bgaf003
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_count     LIKE type_t.num10
   LET r_errno = ''
   LET r_success = TRUE
   
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM bgaf_t
    WHERE bgafent = g_enterprise
      AND bgaf001 = p_bgaf001
      AND bgaf002 = p_bgaf002
      AND bgaf003 = p_bgaf003
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno = 'abg-00111'
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION abgp020_qbeclear()
   INITIALIZE g_master.* TO NULL
   LET g_master.bgaf002 = ''
   LET g_master.bgaf003 = ''
   DISPLAY BY NAME g_master.bgaf001,g_master.bgaf001_desc,
                   g_master.bgaf002,g_master.bgaf003,
                   g_master.bgaf004,g_master.bgaf005,
                   g_master.bgaf006,g_master.bgaa005
   LET g_master_o.* = g_master.*
   CALL cl_set_comp_visible('bgae001,bgae005',TRUE)
   CALL cl_set_comp_visible('glac002',FALSE)   #albireo 151207
END FUNCTION

PRIVATE FUNCTION abgp020_bgaf001_chk(p_bgaf001)
DEFINE p_bgaf001   LIKE ooef_t.ooef001
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_ooef      RECORD
                      ooef205  LIKE ooef_t.ooef205,
                      ooefstus LIKE ooef_t.ooefstus
                      END RECORD

   LET r_success = TRUE
   LET r_errno   = ''
   INITIALIZE l_ooef.* TO NULL
   SELECT ooef205,ooefstus
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_bgaf001

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno = 'aoo-00094'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'apm-00249'
      WHEN l_ooef.ooef205 <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'axm-00159'
   END CASE

   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION abgp020_bgaf_carry(p_bgaf001,p_bgaf002,p_bgaf003)
   DEFINE p_bgaf001   LIKE bgaf_t.bgaf001
   DEFINE p_bgaf002   LIKE bgaf_t.bgaf002
   DEFINE p_bgaf003   LIKE bgaf_t.bgaf003
   DEFINE l_sql       STRING
   DEFINE l_bgaf      RECORD 
                      bgaf004   LIKE bgaf_t.bgaf004,
                      bgaf005   LIKE bgaf_t.bgaf005,
                      bgaf006   LIKE bgaf_t.bgaf006
                      END RECORD
   DEFINE l_bgaa005   LIKE bgaa_t.bgaa005
   DEFINE l_bgaa012   LIKE bgaa_t.bgaa012
   DEFINE l_bgaa008   LIKE bgaa_t.bgaa008   
                    
   INITIALIZE l_bgaf.* TO NULL
  
   LET l_sql = " SELECT bgaf004,bgaf005,bgaf006 ",
               "  FROM bgaf_t ",
               " WHERE bgafent = ",g_enterprise," ",
               "   AND bgaf001 = '",p_bgaf001,"' ",
               "   AND bgaf002 = '",p_bgaf002,"' ",
               "   AND bgaf003 = '",p_bgaf003,"' "
   PREPARE sel_bgafp1 FROM l_sql
   DECLARE sel_bgafc1 CURSOR FOR sel_bgafp1
   
   FOREACH sel_bgafc1 INTO l_bgaf.*
      EXIT FOREACH
   END FOREACH
   
   IF NOT cl_null(l_bgaf.bgaf004)THEN
      LET l_bgaa005 = NULL
      SELECT bgaa005 INTO l_bgaa005 FROM bgaa_t
       WHERE bgaaent = g_enterprise
         AND bgaa001 = l_bgaf.bgaf004
   END IF
   
   LET g_master.bgaf004 = l_bgaf.bgaf004
   LET g_master.bgaf004_desc =  s_desc_get_budget_desc(g_master.bgaf004)
   LET g_master.bgaf005 = l_bgaf.bgaf005
   LET g_master.bgaf006 = l_bgaf.bgaf006
   LET g_master.bgaa005 = l_bgaa005
   
   
   
   DISPLAY BY NAME g_master.bgaf004,g_master.bgaf004_desc,g_master.bgaf005,g_master.bgaf006,g_master.bgaa005
   
   #抓取走科目預算否
   LET l_bgaa012 = NULL   LET l_bgaa008 = NULL
   SELECT bgaa012 ,bgaa008
     INTO l_bgaa012,l_bgaa008
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgaf004
      
   CALL cl_set_comp_visible('bgae001,bgae005,glac002',TRUE)
   IF l_bgaa012 = 'Y' THEN
      CALL cl_set_comp_visible('bgae001,bgae005',FALSE)
   ELSE
      CALL cl_set_comp_visible('glac002',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........: 
# Usage..........: CALL abgp020_b_fill()
# Date & Author..: 2017/02/07 By Hans
# Modify.........: #170116-00074#6 
################################################################################
PRIVATE FUNCTION abgp020_b_fill()
DEFINE l_sql STRING
DEFINE l_site_str STRING


   CALL s_abg2_get_budget_site(g_master.bgaf004,'',g_user,'07') RETURNING l_site_str
   CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str

   CALL g_detail_d.clear()
   LET l_ac = 1  
   LET l_sql = " SELECT DISTINCT 'N',bgbc003,'' FROM bgbc_t     ",
               "  WHERE bgbcent = '",g_enterprise,"'     ",
               "    AND bgbc001 = '",g_master.bgaf004,"' ",
               "    AND bgbc003 IN ",l_site_str
   PREPARE abgp020_b_p FROM l_sql
   DECLARE abgp020_b_c CURSOR FOR abgp020_b_p
   FOREACH abgp020_b_c INTO g_detail_d[l_ac].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET g_detail_d[l_ac].bgbc003_desc = s_desc_get_department_desc(g_detail_d[l_ac].bgbc003)
      LET l_ac = l_ac + 1  
   END FOREACH   
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   IF l_ac = 1  THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "" 
       LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
