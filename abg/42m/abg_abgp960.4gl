#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp960.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-28 14:07:56), PR版次:0001(2017-01-10 16:20:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp960
#+ Description: 預算憑證還原作業
#+ Creator....: 05016(2016-12-28 14:07:56)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgp960.global" >}
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
       bgba001 LIKE type_t.chr10, 
   bgba001_desc LIKE type_t.chr80, 
   bgba002 LIKE type_t.chr10, 
   bgba005 LIKE type_t.chr10, 
   bgba005_desc LIKE type_t.chr80, 
   bgba007 LIKE type_t.chr10, 
   bgbadocno LIKE type_t.chr20, 
   bgba004 LIKE type_t.num5, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_bgaa            RECORD
   bgaa002   LIKE bgaa_t.bgaa002,
   bgaa003   LIKE bgaa_t.bgaa003,
   bgaa008   LIKE bgaa_t.bgaa008,   #預算細項參照表號
   bgaa009   LIKE bgaa_t.bgaa009,   #現金變動碼參照表
   bgaa011   LIKE bgaa_t.bgaa011
         END RECORD
DEFINE g_glaald LIKE glaa_t.glaald

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp960.main" >}
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
      CALL abgp960_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp960 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp960_init()
 
      #進入選單 Menu (="N")
      CALL abgp960_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp960
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp960.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp960_init()
 
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
   CALL cl_set_combo_scc('bgba007','8965')
   CALL abgp960_qbe_clear()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp960.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp960_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_site_str STRING
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgba001,g_master.bgba002,g_master.bgba005,g_master.bgba007 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba001
            
            #add-point:AFTER FIELD bgba001 name="input.a.bgba001"
            IF NOT cl_null(g_master.bgba001) THEN
               CALL abgp960_bgba001_bgba005_chk(g_master.bgba001,g_master.bgba005)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  IF g_errno = 'sub-01302' THEN
                     LET g_errparam.replace[1] = 'abgi100'
                     LET g_errparam.replace[2] = cl_get_progname('abgi100',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi100'
                  END IF
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgba001 = ''
                  LET g_master.bgba001_desc = s_desc_get_budget_desc(g_master.bgba001)
                  DISPLAY BY NAME g_master.bgba001_desc,g_master.bgba001
                  NEXT FIELD CURRENT
               END IF              
               INITIALIZE g_bgaa.* TO NULL
               #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
               SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
                 FROM bgaa_t
                WHERE bgaaent = g_enterprise
                  AND bgaa001 = g_master.bgba001            
            END IF         
            LET g_master.bgba001_desc = s_desc_get_budget_desc(g_master.bgba001)
            DISPLAY BY NAME g_master.bgba001_desc,g_master.bgba001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba001
            #add-point:BEFORE FIELD bgba001 name="input.b.bgba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba001
            #add-point:ON CHANGE bgba001 name="input.g.bgba001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba002
            #add-point:BEFORE FIELD bgba002 name="input.b.bgba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba002
            
            #add-point:AFTER FIELD bgba002 name="input.a.bgba002"
            IF NOT cl_ap_chk_range(g_master.bgba002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bgba002
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba002
            #add-point:ON CHANGE bgba002 name="input.g.bgba002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba005
            
            #add-point:AFTER FIELD bgba005 name="input.a.bgba005"
            #預算組織
            IF NOT cl_null(g_master.bgba005) THEN
               CALL abgp960_bgba001_bgba005_chk(g_master.bgba001,g_master.bgba005)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  IF g_errno = 'sub-01302' THEN
                     LET g_errparam.replace[1] = 'abgi100'
                     LET g_errparam.replace[2] = cl_get_progname('abgi100',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi100'
                  END IF
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgba005      = ''
                  LET g_master.bgba005_desc = ''
                  DISPLAY BY NAME g_master.bgba005,g_master.bgba005_desc
                  NEXT FIELD CURRENT
               END IF                                                                           
            END IF
            SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
            WHERE glaaent = g_enterprise
              AND glaacomp = ooef017           AND glaaent = ooefent
              AND ooef001 = g_master.bgba005   AND glaa014 = 'Y'                       
            LET g_master.bgba005_desc = s_desc_get_department_desc(g_master.bgba005)
            DISPLAY BY NAME g_master.bgba005_desc,g_master.bgba005
    

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba005
            #add-point:BEFORE FIELD bgba005 name="input.b.bgba005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba005
            #add-point:ON CHANGE bgba005 name="input.g.bgba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba007
            #add-point:BEFORE FIELD bgba007 name="input.b.bgba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba007
            
            #add-point:AFTER FIELD bgba007 name="input.a.bgba007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba007
            #add-point:ON CHANGE bgba007 name="input.g.bgba007"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba001
            #add-point:ON ACTION controlp INFIELD bgba001 name="input.c.bgba001"
            #i開窗-預算編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgba001
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '1' "   #使用預測才可以開
            CALL q_bgaa001()
            LET g_master.bgba001 = g_qryparam.return1
            DISPLAY BY NAME g_master.bgba001
            NEXT FIELD bgba001
            #END add-point
 
 
         #Ctrlp:input.c.bgba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba002
            #add-point:ON ACTION controlp INFIELD bgba002 name="input.c.bgba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba005
            #add-point:ON ACTION controlp INFIELD bgba005 name="input.c.bgba005"
           #預算組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgba005
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t ",
                                   "              WHERE bgajent = ooefent AND bgajent = ",g_enterprise,
                                   "                AND bgaj001 = '",g_master.bgba001,"' AND bgajstus = 'Y') "
            CALL s_abg2_get_budget_site(g_master.bgba001,'',g_user,'07') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where CLIPPED,
                                   " AND ooef001 IN ",l_site_str                                                                                                       
            CALL q_ooef001()
            LET g_master.bgba005 = g_qryparam.return1
            DISPLAY BY NAME g_master.bgba005
            NEXT FIELD bgba005
            #END add-point
 
 
         #Ctrlp:input.c.bgba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba007
            #add-point:ON ACTION controlp INFIELD bgba007 name="input.c.bgba007"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgbadocno,bgba004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbadocno
            #add-point:BEFORE FIELD bgbadocno name="construct.b.bgbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbadocno
            
            #add-point:AFTER FIELD bgbadocno name="construct.a.bgbadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbadocno
            #add-point:ON ACTION controlp INFIELD bgbadocno name="construct.c.bgbadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "     bgba001 = '",g_master.bgba001,"' ",
                                   " AND bgba002 = '",g_master.bgba002,"' ",
                                   " AND bgba005 = '",g_master.bgba005,"' ",
                                   " AND bgba007 = '",g_master.bgba007,"' ",
                                   " AND bgbastus = 'N'                   "                        
            CALL q_bgbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbadocno  #顯示到畫面上
            NEXT FIELD bgbadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba004
            #add-point:BEFORE FIELD bgba004 name="construct.b.bgba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba004
            
            #add-point:AFTER FIELD bgba004 name="construct.a.bgba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba004
            #add-point:ON ACTION controlp INFIELD bgba004 name="construct.c.bgba004"
            
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
            CALL abgp960_get_buffer(l_dialog)
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
            CALL abgp960_qbe_clear()
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
         CALL abgp960_init()
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
                 CALL abgp960_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp960_transfer_argv(ls_js)
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
 
{<section id="abgp960.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp960_transfer_argv(ls_js)
 
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
 
{<section id="abgp960.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp960_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql         STRING              
   DEFINE l_docno       LIKE bgba_t.bgbadocno   
   DEFINE l_do          LIKE type_t.num5            
   DEFINE l_cnt         LIKE type_t.num5     
   DEFINE l_bgac002     LIKE bgac_t.bgac002
   DEFINE l_bgba004     LIKE bgba_t.bgba004
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
#  DECLARE abgp960_process_cs CURSOR FROM ls_sql
#  FOREACH abgp960_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   CALL s_transaction_begin()  
   LET g_success = TRUE
   LET l_do = 0
   LET g_prog = 'abgt030'
   IF cl_null(g_master.wc) THEN LET g_master.wc = ' 1=1' END IF
   
   LET l_sql = " SELECT bgbadocno,bgba004 FROM bgba_t        ",
               "  WHERE bgbaent = '",g_enterprise,"' ",
               "    AND bgbastus = 'N'                   ",
               "    AND bgba001 = '",g_master.bgba001,"' ",
               "    AND bgba002 = '",g_master.bgba002,"' ",
               "    AND bgba005 = '",g_master.bgba005,"' ",
               "    AND bgba007 = '",g_master.bgba007,"' ",
               "    AND ",g_master.wc
   PREPARE abgp960_del_docno_p FROM l_sql
   DECLARE abgp960_del_docno_c CURSOR FOR abgp960_del_docno_p
   FOREACH abgp960_del_docno_c INTO l_docno,l_bgba004
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "FOREACH:abgp960_del_docno_p"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_success = FALSE
          EXIT FOREACH
       END IF
      DELETE FROM bgba_t WHERE bgbaent = g_enterprise AND bgbadocno = l_docno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "DELETE bgba_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      DELETE FROM bgbb_t WHERE bgbbent = g_enterprise AND bgbbdocno = l_docno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "DELETE bgbb_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
       
      CASE g_master.bgba007
         WHEN 10 #10:銷售:bgcj048
            UPDATE bgcj_t SET bgcj048 =''
             WHERE bgcjent = g_enterprise
               AND bgcj048 = l_docno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'UPDATE bgcj_t',l_docno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF                         
         WHEN 20 #20:採購:bgeg048
            UPDATE bgeg_t SET bgeg048 =''
             WHERE bgegent = g_enterprise
               AND bgeg048 = l_docno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'UPDATE bgeg_t',l_docno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF           
          WHEN 40 # 40:費用:bgfb048
             UPDATE bgfb_t SET bgfb048 =''
              WHERE bgfbent = g_enterprise
                AND bgfb048 = l_docno 
             IF SQLCA.SQLCODE THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'UPDATE bgfb_t',l_docno
                LET g_errparam.code   = SQLCA.SQLCODE
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_success = FALSE
                EXIT FOREACH
             END IF           
          WHEN 50  #人工
             UPDATE bggm_t SET bggm010 = ''
              WHERE bggment = g_enterprise
                AND bggm010 = l_docno   
             IF SQLCA.SQLCODE THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'UPDATE bggm_t',l_docno
                LET g_errparam.code   = SQLCA.SQLCODE
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_success = FALSE
                EXIT FOREACH
             END IF                        
     END CASE
   
     #取當期最大日
     SELECT MAX(bgac002) INTO l_bgac002 FROM bgac_t 
      WHERE bgacent = g_enterprise AND bgac001 = g_bgaa.bgaa002 AND bgac004 = l_bgba004
     
      IF NOT s_aooi200_fin_del_docno(g_glaald,l_docno,l_bgac002) THEN
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      LET l_do = l_do +1 
   END FOREACH   
   LET g_prog = 'abgp960'
   
   IF g_success THEN         
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_show()
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'   #失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')       
      CALL cl_err_collect_show()        
      CALL abgp960_qbe_clear()         
      RETURN      
   END IF
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00313'   #失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')       
      CALL cl_err_collect_show()        
      CALL abgp960_qbe_clear()         
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
   CALL abgp960_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp960.get_buffer" >}
PRIVATE FUNCTION abgp960_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgba001 = p_dialog.getFieldBuffer('bgba001')
   LET g_master.bgba002 = p_dialog.getFieldBuffer('bgba002')
   LET g_master.bgba005 = p_dialog.getFieldBuffer('bgba005')
   LET g_master.bgba007 = p_dialog.getFieldBuffer('bgba007')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp960.msgcentre_notify" >}
PRIVATE FUNCTION abgp960_msgcentre_notify()
 
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
 
{<section id="abgp960.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預算編號/組織檢核
# Memo...........:
# Usage..........: CALL abgp960_bgba001_bgba005_chk(p_bgba001,p_bgba005)
# Date & Author..: 2017/01/03 By 05016
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp960_bgba001_bgba005_chk(p_bgba001,p_bgba005)
DEFINE p_bgba001     LIKE bgba_t.bgba001  #預算編號
DEFINE p_bgba005     LIKE bgba_t.bgba005  #預算組織
DEFINE l_bgaastus    LIKE bgaa_t.bgaastus
DEFINE l_bgaa006     LIKE bgaa_t.bgaa006 
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE r_success     LIKE type_t.num5
DEFINE l_count       LIKE type_t.num5

   LET r_errno = NULL
   LET r_success = TRUE
   IF NOT cl_null(p_bgba001)THEN       #單獨檢查預算編號
      CALL　s_abg2_bgaa001_chk(p_bgba001) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF      
   END IF
       
   #檢查組織跟預算編號
   IF NOT cl_null(p_bgba001) AND NOT cl_null(p_bgba005)THEN      
      LET l_count = 0
      SELECT COUNT(1) INTO l_count FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = p_bgba001
         AND bgai004 = p_bgba005 AND bgai003 = g_user
         AND(bgai005 = '07' OR bgai005 = '00')
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN       
         LET r_success = FALSE
         LET r_errno = 'abg-00212'
      END IF
      RETURN r_success,r_errno
   END IF
   
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL abgp960_qbe_clear()
# Date & Author..: 2017/01/03 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp960_qbe_clear()

   LET g_master.bgba001 = '' 
   LET g_master.bgba001_desc = ''
   LET g_master.bgba002 = ''
   LET g_master.bgba005 = ''
   LET g_master.bgba005_desc = ''
   LET g_master.bgba007 = '10'
   
   
   
   DISPLAY BY NAME g_master.bgba001,g_master.bgba001_desc,g_master.bgba002,
                   g_master.bgba005,g_master.bgba005_desc,g_master.bgba007
              

END FUNCTION

#end add-point
 
{</section>}
 
