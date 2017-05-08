#該程式未解開Section, 採用最新樣板產出!
{<section id="astp740.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-02-03 09:19:40), PR版次:0004(2016-10-27 11:22:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: astp740
#+ Description: 內部結算單批次產生作業
#+ Creator....: 03247(2015-02-02 10:10:41)
#+ Modifier...: 03247 -SD/PR- 08172
 
{</section>}
 
{<section id="astp740.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161024-00025#4   2016/10/24 by 08172   组织调整
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
       stdd001 LIKE type_t.chr10, 
   stdd004 LIKE type_t.chr10, 
   stdd005 LIKE type_t.chr10, 
   stau004 LIKE type_t.num10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp740.main" >}
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
      CALL astp740_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp740 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp740_init()
 
      #進入選單 Menu (="N")
      CALL astp740_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp740
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp740.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp740_init()
 
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
 
{<section id="astp740.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp740_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_stau004   STRING
   DEFINE l_len       LIKE type_t.num5
   DEFINE l_str       LIKE type_t.chr1
   DEFINE l_year      LIKE type_t.num5
   DEFINE l_month     LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_errno     LIKE type_t.chr100
   DEFINE l_glav005   LIKE glav_t.glav005
   DEFINE l_sdate_s   LIKE glav_t.glav004
   DEFINE l_sdate_e   LIKE glav_t.glav004
   DEFINE l_glav006   LIKE glav_t.glav006
   DEFINE l_pdate_s   LIKE glav_t.glav004
   DEFINE l_pdate_e   LIKE glav_t.glav004
   DEFINE l_glav007   LIKE glav_t.glav007
   DEFINE l_wdate_s   LIKE glav_t.glav004
   DEFINE l_wdate_e   LIKE glav_t.glav004
   DEFINE l_ooef017   LIKE ooef_t.ooef017
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_glav002   LIKE glav_t.glav002
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.stau004 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
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
         CONSTRUCT BY NAME g_master.wc ON stdd001,stdd004,stdd005
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stdd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdd001
            #add-point:ON ACTION controlp INFIELD stdd001 name="construct.c.stdd001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdgsite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdd001  #顯示到畫面上
            NEXT FIELD stdd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdd001
            #add-point:BEFORE FIELD stdd001 name="construct.b.stdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdd001
            
            #add-point:AFTER FIELD stdd001 name="construct.a.stdd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stdd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdd004
            #add-point:ON ACTION controlp INFIELD stdd004 name="construct.c.stdd004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO stdd004  #顯示到畫面上
            NEXT FIELD stdd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdd004
            #add-point:BEFORE FIELD stdd004 name="construct.b.stdd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdd004
            
            #add-point:AFTER FIELD stdd004 name="construct.a.stdd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stdd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdd005
            #add-point:ON ACTION controlp INFIELD stdd005 name="construct.c.stdd005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO stdd005  #顯示到畫面上
            NEXT FIELD stdd005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdd005
            #add-point:BEFORE FIELD stdd005 name="construct.b.stdd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdd005
            
            #add-point:AFTER FIELD stdd005 name="construct.a.stdd005"
            
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
            CALL astp740_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.stau004 = ''
            #抓取法人對應會計週期參照表
            LET l_ooef017 = NULL
            LET l_glaa003 = NULL
            SELECT ooef017 INTO l_ooef017
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            SELECT glaa003 INTO l_glaa003
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = l_ooef017
               AND glaa014 = 'Y'
            CALL s_get_accdate(l_glaa003,g_today,'','')
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            LET g_master.stau004 = l_glav002*100+l_glav006      
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
         CALL astp740_init()
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
                 CALL astp740_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp740_transfer_argv(ls_js)
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
 
{<section id="astp740.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp740_transfer_argv(ls_js)
 
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
 
{<section id="astp740.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp740_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_stdd001   LIKE stdd_t.stdd001
   DEFINE l_stdd001_t LIKE stdd_t.stdd001
   DEFINE l_stdd004   LIKE stdd_t.stdd004
   DEFINE l_stdd005   LIKE stdd_t.stdd005
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_docno     LIKE stdg_t.stdgdocno
   DEFINE r_doctype   LIKE rtai_t.rtai004
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_sql       STRING  
   DEFINE l_cmd       STRING
   DEFINE l_where     STRING   
   DEFINE l_str       STRING
   DEFINE l_cnt       LIKE type_t.num10
   DEFINE l_cnt1      LIKE type_t.num10
   DEFINE l_msg       LIKE type_t.chr100   #160225-00040#18 2016/04/13 s983961--add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(2)   #160225-00040#18 2016/04/13 s983961--add  
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp740_process_cs CURSOR FROM ls_sql
#  FOREACH astp740_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040#18 2016/04/13 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#18 2016/04/13 s983961--add(e)
   LET l_where = s_aooi500_q_where(g_prog,'stdgsite',g_site,'c')   #150308-00001#5  By benson add 'c'
#   CALL s_aooi500_sql_where(g_prog,'stdgsite') RETURNING l_where  #161024-00025#4 by 08172
   LET g_master.wc = g_master.wc," AND ",l_where
   LET g_master.wc = cl_replace_str(g_master.wc,'ooef001','stdd001')
   #對象1和對象2的條件互換
   LET l_str = g_master.wc
   LET l_str = cl_replace_str(l_str,'stdd004','stdd003')
   LET l_str = cl_replace_str(l_str,'stdd005','stdd004')
   LET l_str = cl_replace_str(l_str,'stdd003','stdd005')
   LET l_cnt = 0
   CALL cl_err_collect_init()
   LET l_cmd = ''
   LET l_stdd001_t = ''
   LET l_sql = " SELECT DISTINCT stdd001,stdd004,stdd005 ",
               "   FROM stdd_t ",
               "  WHERE stddent = ",g_enterprise," ",
               "    AND (",g_master.wc," OR ",l_str,") ",
               "  ORDER BY stdd001,stdd004,stdd005 "
   PREPARE sel_stdd_pre FROM l_sql
   DECLARE sel_stdd_cs  CURSOR WITH HOLD FOR sel_stdd_pre
   FOREACH sel_stdd_cs  INTO l_stdd001,l_stdd004,l_stdd005
      #add by geza 20151225(s)
      #asti702存在2笔及以上的对象1和对象2设置资料则不能产生内部结算单
      LET l_cnt1 = 0
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM stdd_t ",
                  "  WHERE stddent = ",g_enterprise," ",
                  "    AND (",g_master.wc," OR ",l_str,") "
      PREPARE sel_stdd_pre1 FROM l_sql 
      EXECUTE sel_stdd_pre1 INTO l_cnt1
      IF l_cnt1 > 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code = 'ast-00532'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH      
      END IF
      #add by geza 20151225(e)      
      IF NOT cl_null(l_stdd001_t) AND l_stdd001 = l_stdd001_t THEN
         CONTINUE FOREACH
      END IF
      CALL s_transaction_begin()
      #抓取默認單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(l_stdd001,'astt740','1')
          RETURNING r_success,r_doctype
      IF NOT r_success THEN
         LET l_cmd = "arti200"
         CALL s_transaction_end('N','0')
         EXIT FOREACH
      END IF
      #單別自動編號
      CALL s_aooi200_gen_docno(l_stdd001,r_doctype,g_today,'astt740')
         RETURNING l_flag,l_docno
      IF NOT l_flag THEN
         CALL s_transaction_end('N','0')
         EXIT FOREACH
      END IF
      
      #產生結算資料
      CALL s_astp740_ins_stdg(l_stdd001,l_stdd004,l_stdd005,g_master.stau004,l_docno)
         RETURNING r_success,l_stdd001_t
      IF NOT r_success THEN
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      END IF
      CALL s_transaction_end('Y','0')
      #單身無資料，則刪除單頭
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM stdh_t
       WHERE stdhent = g_enterprise
         AND stdhdocno = l_docno
      IF l_n < 1 THEN
         DELETE FROM stdg_t
          WHERE stdgent = g_enterprise
            AND stdgdocno = l_docno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_docno 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CONTINUE FOREACH
         END IF
      ELSE 
         LET l_cnt = l_cnt + 1      
      END IF
   END FOREACH
   IF l_cnt >= 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code = 'ast-00531'
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_cnt
      CALL cl_err()  
   END IF
   CALL cl_err_collect_show()
   IF NOT cl_null(l_cmd) THEN
      CALL cl_cmdrun_wait(l_cmd)
   END IF
   
   #160225-00040#18 2016/04/13 s983961--add(s)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)  
   #160225-00040#18 2016/04/13 s983961--add(e)   
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
   CALL astp740_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp740.get_buffer" >}
PRIVATE FUNCTION astp740_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.stau004 = p_dialog.getFieldBuffer('stau004')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp740.msgcentre_notify" >}
PRIVATE FUNCTION astp740_msgcentre_notify()
 
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
 
{<section id="astp740.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
