#該程式未解開Section, 採用最新樣板產出!
{<section id="astp206.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-03-16 10:58:51), PR版次:0009(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000153
#+ Filename...: astp206
#+ Description: 結算關帳批處理作業
#+ Creator....: 03247(2014-06-25 16:23:48)
#+ Modifier...: 07959 -SD/PR- 00000
 
{</section>}
 
{<section id="astp206.global" >}
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
#        stausite         STRING,
#        stau001          STRING,
#        stau003          LIKE stau_t.stau003,
#        stau004          LIKE stau_t.stau004,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       ooef001 LIKE type_t.chr500, 
   gzcb002 LIKE type_t.chr500, 
   stau003 LIKE type_t.dat, 
   stau004 LIKE type_t.num10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc2    STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp206.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp206_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp206 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp206_init()
 
      #進入選單 Menu (="N")
      CALL astp206_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp206
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp206.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp206_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
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
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp206.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp206_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE tok        base.stringtokenizer
   DEFINE l_stausite LIKE stau_t.stausite
   DEFINE l_tok      STRING
   DEFINE l_stau001  LIKE stau_t.stau001
   DEFINE l_stau004  STRING
   DEFINE l_ooefstus LIKE ooef_t.ooefstus
   DEFINE l_len      LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_str      LIKE type_t.chr1
   DEFINE l_month    LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.stau003,g_master.stau004 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stau003
            #add-point:BEFORE FIELD stau003 name="input.b.stau003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stau003
            
            #add-point:AFTER FIELD stau003 name="input.a.stau003"
            IF NOT cl_null(g_master.stau003) THEN
               CALL astp206_stau004_default(g_master.stau003)
               RETURNING g_master.stau004
            END IF
                 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stau003
            #add-point:ON CHANGE stau003 name="input.g.stau003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stau004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.stau004,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD stau004
            END IF 
 
 
 
            #add-point:AFTER FIELD stau004 name="input.a.stau004"
            IF NOT cl_null(g_master.stau004) THEN
               LET l_stau004 = g_master.stau004
               LET l_len = l_stau004.getLength()
               IF l_len <> 6 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00098'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD stau004
               END IF
               FOR l_n=1 TO l_len
                  LET l_str = l_stau004.subString(l_n,l_n)
                  IF l_str NOT MATCHES '[0123456789]' THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00098'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     NEXT FIELD stau004
                     EXIT FOR
                  END IF
               END FOR
               LET l_month = l_stau004.subString(5,6) USING '<<'
               IF cl_null(l_month) OR l_month < 1 OR l_month > 12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00098'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD stau004
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stau004
            #add-point:BEFORE FIELD stau004 name="input.b.stau004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stau004
            #add-point:ON CHANGE stau004 name="input.g.stau004"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.stau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stau003
            #add-point:ON ACTION controlp INFIELD stau003 name="input.c.stau003"
            
            #END add-point
 
 
         #Ctrlp:input.c.stau004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stau004
            #add-point:ON ACTION controlp INFIELD stau004 name="input.c.stau004"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON ooef001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef001
            #add-point:ON ACTION controlp INFIELD ooef001 name="construct.c.ooef001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef212 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stausite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO ooef001  #顯示到畫面上
            NEXT FIELD ooef001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef001
            #add-point:BEFORE FIELD ooef001 name="construct.b.ooef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef001
            
            #add-point:AFTER FIELD ooef001 name="construct.a.ooef001"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         #CONSTRUCT BY NAME lc_param.wc ON gzcb002       #150603-00026#8--mark by dongsz
         CONSTRUCT BY NAME g_wc2 ON gzcb002        #150603-00026#8--add by dongsz
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               #DISPLAY g_today TO prbk006
               
            ON ACTION controlp INFIELD gzcb002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '6072'
               CALL q_gzcb002_01()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO gzcb002    #顯示到畫面上
               NEXT FIELD gzcb002                       #返回原欄位
               
            AFTER FIELD gzcb002

               
            
               
         END CONSTRUCT           
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
#         INPUT lc_param.stausite,lc_param.stau001,lc_param.stau003,lc_param.stau004 
#            FROM stausite,stau001,stau003,stau004 ATTRIBUTE(WITHOUT DEFAULTS)
#            
#            BEFORE INPUT
#            
#            AFTER FIELD stausite
#               LET tok = base.StringTokenizer.create(lc_param.stausite,"|")
#               WHILE tok.hasMoreTokens()
#                  LET l_tok=tok.nextToken()
#                  LET l_stausite = l_tok
#                  SELECT COUNT(*) INTO l_n
#                    FROM ooef_t
#                   WHERE ooef001 = l_stausite
#                     AND ooefent = g_enterprise
#                  IF l_n < 1 THEN
#                     CALL cl_err(l_stausite,'apm-00248',1)
#                     LET lc_param.stausite = ""
#                     DISPLAY lc_param.stausite TO stausite
#                     NEXT FIELD stausite
#                     EXIT WHILE
#                  END IF
#                  SELECT ooefstus INTO l_ooefstus
#                    FROM ooef_t
#                   WHERE ooef001 = l_stausite
#                     AND ooefent = g_enterprise
#                  IF l_ooefstus <> 'Y' THEN
#                     CALL cl_err(l_stausite,'apm-00249',1)
#                     LET lc_param.stausite = ""
#                     DISPLAY lc_param.stausite TO stausite
#                     NEXT FIELD stausite
#                     EXIT WHILE
#                  END IF
#                  SELECT COUNT(*) INTO l_n FROM ooef_t
#                   WHERE ooefent = g_enterprise
#                     AND ooef001 = l_stausite 
#                     AND ooef212 = 'Y'
#                  IF l_n < 1 THEN
#                     CALL cl_err(l_stausite,'art-00218',1)
#                     LET lc_param.stausite = ""
#                     DISPLAY lc_param.stausite TO stausite
#                     NEXT FIELD stausite
#                     EXIT WHILE
#                  END IF
#               END WHILE
#            
#            AFTER FIELD stau001
#               LET tok = base.StringTokenizer.create(lc_param.stau001,"|")
#               WHILE tok.hasMoreTokens()
#                  LET l_tok=tok.nextToken()
#                  LET l_stau001 = l_tok
#                  SELECT COUNT(*) INTO l_n
#                    FROM gzcb_t
#                   WHERE gzcb001 = '6072' 
#                     AND gzcb002 = l_stau001
#                  IF l_n < 1 THEN
#                     CALL cl_err(l_stau001,'ast-00099',1)
#                     LET lc_param.stau001 = ""
#                     DISPLAY lc_param.stau001 TO stau001
#                     NEXT FIELD stau001
#                     EXIT WHILE
#                  END IF
#               END WHILE
#
#               AFTER FIELD stau003
#                  IF NOT cl_null(lc_param.stau003) THEN
#                     CALL astp206_stau004_default(lc_param.stau003)
#                        RETURNING lc_param.stau004
#                  END IF
#                  
#               AFTER FIELD stau004
#                  IF NOT cl_null(lc_param.stau004) THEN
#                     LET l_stau004 = lc_param.stau004
#                     LET l_len = l_stau004.getLength()
#                     IF l_len <> 6 THEN
#                        CALL cl_err('','ast-00098',1)
#                        NEXT FIELD stau004
#                     END IF
#                     FOR l_n=1 TO l_len
#                        LET l_str = l_stau004.subString(l_n,l_n)
#                        IF l_str NOT MATCHES '[0123456789]' THEN
#                           CALL cl_err('','ast-00098',1)
#                           NEXT FIELD stau004
#                           EXIT FOR
#                        END IF
#                     END FOR
#                     LET l_month = l_stau004.subString(5,6) USING '<<'
#                     IF cl_null(l_month) OR l_month < 1 OR l_month > 12 THEN
#                        CALL cl_err('','ast-00098',1)
#                        NEXT FIELD stau004
#                     END IF
#                  END IF
#            
#            ON ACTION controlp INFIELD stausite
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = "c"
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.where = " ooef212 = 'Y'"
#               CALL q_ooef001()                       #呼叫開窗
#               LET lc_param.stausite = g_qryparam.return1
#               DISPLAY lc_param.stausite TO stausite   #顯示到畫面上
#               LET g_qryparam.where = ""
#               NEXT FIELD stausite                       #返回原欄位
#            
#            ON ACTION controlp INFIELD stau001
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = "c"
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.arg1 = '6072'
#               CALL q_gzcb002_01()                      #呼叫開窗
#               LET lc_param.stau001 = g_qryparam.return1
#               DISPLAY lc_param.stau001 TO stau001      #顯示到畫面上
#               LET g_qryparam.where = ""
#               NEXT FIELD stau001                       #返回原欄位
#               
#         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL astp206_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.stau003 = g_today
            CALL astp206_stau004_default(g_master.stau003)
                RETURNING g_master.stau004 
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
            LET g_wc2 = ''            #150603-00026#8--add by dongsz
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
         CALL astp206_init()
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
                 CALL astp206_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp206_transfer_argv(ls_js)
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
 
{<section id="astp206.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp206_transfer_argv(ls_js)
 
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
 
{<section id="astp206.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp206_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_where     STRING
   DEFINE l_msg         STRING           #160225-00040#16 20160328 add by beckxie
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
#   LET l_where = s_aooi500_sql_where(g_prog,'stausite')
   IF cl_null(g_master.wc) OR g_master.wc = " 1=1" THEN
      LET g_master.wc = " ooef001 like '%' "
   END IF
   #150603-00026#8--mark by dongsz--str---
#   IF cl_null(lc_param.wc) OR lc_param.wc = " 1=1" THEN
#      LET lc_param.wc = " gzcb002 like '%'"
#   END IF
   IF cl_null(g_wc2) OR g_wc2 = " 1=1" THEN
      LET g_wc2 = " gzcb002 like '%'"
   END IF
   #150603-00026#8--mark by dongsz--end---
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(2)   #160225-00040#16 20160328 add by beckxie
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp206_process_cs CURSOR FROM ls_sql
#  FOREACH astp206_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   #160225-00040#16 20160328 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#16 20160328 add by beckxie---E
   CALL astp206_ins_stau(ls_js)
   #160225-00040#16 20160328 add by beckxie---S
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#16 20160328 add by beckxie---E
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end("N","0")
   ELSE
      CALL s_transaction_end("Y","0")
   END IF
   INITIALIZE g_master.* TO NULL
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
   CALL astp206_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp206.get_buffer" >}
PRIVATE FUNCTION astp206_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.stau003 = p_dialog.getFieldBuffer('stau003')
   LET g_master.stau004 = p_dialog.getFieldBuffer('stau004')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp206.msgcentre_notify" >}
PRIVATE FUNCTION astp206_msgcentre_notify()
 
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
 
{<section id="astp206.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 更新結算會計資料
# Memo...........:
# Usage..........: CALL astp206_ins_stau(ls_js)
# Date & Author..: 20140626 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION astp206_ins_stau(ls_js)
DEFINE lc_param       type_parameter
DEFINE ls_js          STRING
DEFINE tok            base.stringtokenizer
DEFINE l_tok          STRING
DEFINE l_sql          STRING
DEFINE l_staucrtdt    DATETIME YEAR TO SECOND
DEFINE l_gzcb002      LIKE gzcb_t.gzcb002
DEFINE l_ooef001      LIKE ooef_t.ooef001
DEFINE l_ooef017      LIKE ooef_t.ooef017
DEFINE l_glaa003      LIKE glaa_t.glaa003
DEFINE l_date         LIKE stau_t.stau003
DEFINE r_flag         LIKE type_t.chr1
DEFINE r_errno        LIKE type_t.chr100
DEFINE r_glav002      LIKE glav_t.glav002
DEFINE r_glav005      LIKE glav_t.glav005
DEFINE r_sdate_s      LIKE glav_t.glav004
DEFINE r_sdate_e      LIKE glav_t.glav004
DEFINE r_glav006      LIKE glav_t.glav006
DEFINE r_pdate_s      LIKE glav_t.glav004
DEFINE r_pdate_e      LIKE glav_t.glav004
DEFINE r_glav007      LIKE glav_t.glav007
DEFINE r_wdate_s      LIKE glav_t.glav004
DEFINE r_wdate_e      LIKE glav_t.glav004
DEFINE l_str          STRING
DEFINE l_str1         LIKE type_t.chr4
DEFINE l_str2         LIKE type_t.chr2

   CALL util.JSON.parse(ls_js,lc_param)
   LET g_errno = ""
   
   CALL cl_err_collect_init()
   LET l_date = g_master.stau003
   LET l_date = l_date + 1
   LET l_sql = " SELECT ooef001 FROM ooef_t ",
               "  WHERE ooefent = '",g_enterprise,"' ",
               "    AND ooef212 = 'Y' ",
               "    AND ",g_master.wc,
               "    AND ooefstus = 'Y' "
   PREPARE sel_ooef_pre FROM l_sql
   DECLARE sel_ooef_cs  CURSOR FOR sel_ooef_pre
   FOREACH sel_ooef_cs  INTO l_ooef001
      LET l_ooef017 = NULL
      LET l_glaa003 = NULL
      #抓取法人對應會計週期參照表
      SELECT ooef017 INTO l_ooef017
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_ooef001
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_ooef017
         AND glaa014 = 'Y'
      IF cl_null(l_glaa003) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ast-00183"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_ooef001
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      #取得會計週期資料
      CALL s_get_accdate(l_glaa003,l_date,'','')
         RETURNING r_flag,r_errno,r_glav002,r_glav005,r_sdate_s,r_sdate_e,r_glav006,r_pdate_s,r_pdate_e,r_glav007,r_wdate_s,r_wdate_e
      IF r_flag = 'Y' THEN
         LET l_str1 = r_glav002 CLIPPED
         LET l_str2 = r_glav006 CLIPPED USING '&&'
         LET l_str = l_str1,l_str2
         LET g_master.stau004 = l_str
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = r_errno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      END IF
         
      LET l_sql = " SELECT gzcb002 FROM gzcb_t ",
                  "  WHERE gzcb001 = '6072' ",
                  #"    AND ",lc_param.wc CLIPPED     #150603-00026#8--mark by dongsz
                  "    AND ",g_wc2 CLIPPED            #150603-00026#8--add by dongsz
      PREPARE sel_gzcb_pre FROM l_sql
      DECLARE sel_gzcb_cs  CURSOR FOR sel_gzcb_pre
      FOREACH sel_gzcb_cs  INTO l_gzcb002         
         LET l_staucrtdt = cl_get_current()
         LET l_sql = " MERGE INTO stau_t ",
                     " USING (SELECT ooef001 FROM ooef_t ",
                     "         WHERE ooefent = '",g_enterprise,"' ",
                     "           AND ooef212 = 'Y' ",
                     "           AND ooef001 = '",l_ooef001,"' ",
                     "           AND ooefstus = 'Y') ",
                     #"    ON (stausite = ooef001 AND stau001 = '",l_gzcb002,"') ", #mark by geza 20160302
                     "    ON (stausite = ooef001 AND stau001 = '",l_gzcb002,"' AND stauent = '",g_enterprise,"') ", #add by geza 20160302 #160128-00001#11
                     "  WHEN MATCHED THEN ",
                     "       UPDATE SET stau003 = '",g_master.stau003,"',stau004 = '",g_master.stau004,"', ",
                     "                  staumodid = '",g_user,"',staumoddt = to_date('",l_staucrtdt,"','YYYY-MM-DD hh24:mi:ss') ",
                     "  WHEN NOT MATCHED THEN ",
                     "       INSERT(stauent,stausite,stau001,stau002,stau003,stau004,stauownid,stauowndp,staucrtid,staucrtdp,staucrtdt) ",
                     "       VALUES('",g_enterprise,"',ooef001,'",l_gzcb002,"','1','",g_master.stau003,"','",g_master.stau004,"', ",
                     "              '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',to_date('",l_staucrtdt,"','YYYY-MM-DD hh24:mi:ss')) "
         PREPARE sel_stau_pre FROM l_sql
         EXECUTE sel_stau_pre
         IF SQLCA.sqlcode THEN
            LET g_errno = SQLCA.sqlcode
            RETURN
         END IF
      END FOREACH
   END FOREACH
   CALL cl_err_collect_show()

END FUNCTION

################################################################################
# Descriptions...: 計算結算會計期
# Memo...........:
# Usage..........: CALL astp206_stau004_default(p_stau003)
# Date & Author..: 20140626 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION astp206_stau004_default(p_stau003)
DEFINE p_stau003      LIKE stau_t.stau003
DEFINE l_year   LIKE type_t.chr5
DEFINE l_month  LIKE type_t.chr5
DEFINE l_str    LIKE type_t.chr5
DEFINE l_stau004 LIKE type_t.chr10
   
   LET l_month = MONTH(p_stau003)
   LET l_year = YEAR(p_stau003)
   LET l_str = l_month+1 USING '&&'
   IF l_month = 12 THEN
      LET l_year = l_year + 1
      LET l_str = '01'
   END IF
   LET l_stau004 = l_year,l_str
   RETURN l_stau004

END FUNCTION

#end add-point
 
{</section>}
 
