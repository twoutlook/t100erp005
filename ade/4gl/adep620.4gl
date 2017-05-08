#該程式未解開Section, 採用最新樣板產出!
{<section id="adep620.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-01-29 17:32:55), PR版次:0003(2016-09-05 14:38:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: adep620
#+ Description: 配銷銷售月結批次主程式
#+ Creator....: 02749(2014-12-31 09:17:34)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adep620.global" >}
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
        type          LIKE type_t.chr10,
        deba041       LIKE deba_t.deba041,
        deba042       LIKE deba_t.deba042,
        extend_flag   LIKE type_t.chr1,
        recalculated  LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       debasite LIKE type_t.chr10, 
   l_deba041 LIKE type_t.num5, 
   l_deba042 LIKE type_t.num5, 
   l_extend_flag LIKE type_t.chr500, 
   l_recalculated LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_org   STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
#argv[1] type_t.chr10 #處理類型：1.單品 2.門店組織
#end add-point
 
{</section>}
 
{<section id="adep620.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   LET g_argv[2] = cl_replace_str(g_argv[2], '\"', '')
   LET g_argv[3] = cl_replace_str(g_argv[3], '\"', '')
   LET g_argv[4] = cl_replace_str(g_argv[4], '\"', '')
   LET g_argv[5] = cl_replace_str(g_argv[5], '\"', '')
   LET g_argv[6] = cl_replace_str(g_argv[6], '\"', '')

   #DISPLAY 'g_argv[1]',g_argv[1]
   #DISPLAY 'g_argv[2]',g_argv[2]
   #DISPLAY 'g_argv[3]',g_argv[3]
   #DISPLAY 'g_argv[4]',g_argv[4]
   #DISPLAY 'g_argv[5]',g_argv[5]
   #DISPLAY 'g_argv[6]',g_argv[6]

   LET lc_param.type = g_argv[1]
   LET lc_param.deba041 = g_argv[2]
   LET lc_param.deba042 = g_argv[3]
   LET lc_param.extend_flag = g_argv[4]
   LET lc_param.recalculated = g_argv[5]
   LET lc_param.wc = g_argv[6]

   LET ls_js = util.JSON.stringify(lc_param)
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由07開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[07]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep620_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep620 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep620_init()
 
      #進入選單 Menu (="N")
      CALL adep620_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL adep620_drop_org_tmp()
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep620
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep620.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep620_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL adep620_create_org_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adep620.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep620_ui_dialog()
 
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
   #ken
   IF MONTH(g_today) - 1 = 0 THEN
      LET g_master.l_deba041 = YEAR(g_today) - 1
      LET g_master.l_deba042 = 12
   ELSE
      LET g_master.l_deba041 = YEAR(g_today)
      LET g_master.l_deba042 = MONTH(g_today) - 1
   END IF
   
   LET g_master.l_extend_flag = 'N'
   LET g_master.l_recalculated = 'N'
   DISPLAY BY NAME g_master.l_deba041,g_master.l_deba042,g_master.l_extend_flag,g_master.l_recalculated
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_deba041,g_master.l_deba042,g_master.l_extend_flag,g_master.l_recalculated  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_deba041
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_deba041,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_deba041
            END IF 
 
 
 
            #add-point:AFTER FIELD l_deba041 name="input.a.l_deba041"
            IF NOT cl_null(g_master.l_deba041) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_deba041
            #add-point:BEFORE FIELD l_deba041 name="input.b.l_deba041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_deba041
            #add-point:ON CHANGE l_deba041 name="input.g.l_deba041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_deba042
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_deba042,"1","1","12","1","azz-00087",1) THEN
               NEXT FIELD l_deba042
            END IF 
 
 
 
            #add-point:AFTER FIELD l_deba042 name="input.a.l_deba042"
            IF NOT cl_null(g_master.l_deba042) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_deba042
            #add-point:BEFORE FIELD l_deba042 name="input.b.l_deba042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_deba042
            #add-point:ON CHANGE l_deba042 name="input.g.l_deba042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_extend_flag
            #add-point:BEFORE FIELD l_extend_flag name="input.b.l_extend_flag"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_extend_flag
            
            #add-point:AFTER FIELD l_extend_flag name="input.a.l_extend_flag"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_extend_flag
            #add-point:ON CHANGE l_extend_flag name="input.g.l_extend_flag"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_recalculated
            #add-point:BEFORE FIELD l_recalculated name="input.b.l_recalculated"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_recalculated
            
            #add-point:AFTER FIELD l_recalculated name="input.a.l_recalculated"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_recalculated
            #add-point:ON CHANGE l_recalculated name="input.g.l_recalculated"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_deba041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_deba041
            #add-point:ON ACTION controlp INFIELD l_deba041 name="input.c.l_deba041"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_deba042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_deba042
            #add-point:ON ACTION controlp INFIELD l_deba042 name="input.c.l_deba042"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_extend_flag
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_extend_flag
            #add-point:ON ACTION controlp INFIELD l_extend_flag name="input.c.l_extend_flag"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_recalculated
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_recalculated
            #add-point:ON ACTION controlp INFIELD l_recalculated name="input.c.l_recalculated"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON debasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
 
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.debasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debasite
            #add-point:ON ACTION controlp INFIELD debasite name="construct.c.debasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debasite  #顯示到畫面上
            NEXT FIELD debasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debasite
            #add-point:BEFORE FIELD debasite name="construct.b.debasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debasite
            
            #add-point:AFTER FIELD debasite name="construct.a.debasite"
            IF NOT cl_null(g_master.wc) THEN
               LET g_org = GET_FLDBUF(debasite)
               DISPLAY "g_org: ",g_org
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
            CALL adep620_get_buffer(l_dialog)
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
         CALL adep620_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.type         = g_argv[1]
      LET lc_param.deba041      = g_master.l_deba041
      LET lc_param.deba042      = g_master.l_deba042
      LET lc_param.extend_flag  = g_master.l_extend_flag
      LET lc_param.recalculated = g_master.l_recalculated
      LET lc_param.wc           = g_master.wc
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
                 CALL adep620_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep620_transfer_argv(ls_js)
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
 
{<section id="adep620.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep620_transfer_argv(ls_js)
 
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
   LET la_cmdrun.param[1] = la_param.type
   LET la_cmdrun.param[2] = la_param.deba041
   LET la_cmdrun.param[3] = la_param.deba042
   LET la_cmdrun.param[4] = la_param.extend_flag
   LET la_cmdrun.param[5] = la_param.recalculated
   LET la_cmdrun.param[6] = la_param.wc
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="adep620.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep620_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_loop        LIKE type_t.num5   #160225-00040#5 Add By Ken 160314
   DEFINE l_msg         STRING             #160225-00040#5 Add By Ken 160314   
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
      #160225-00040#5 Add By Ken 160314(S)
      LET l_loop = 3
      CALL cl_progress_bar_no_window(l_loop)  
      #160225-00040#5 Add By Ken 160314(E)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep620_process_cs CURSOR FROM ls_sql
#  FOREACH adep620_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   #160225-00040#5 Add By Ken 160314(S)  資料準備 
   LET l_msg = cl_getmsg('ade-00114',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)    
   #160225-00040#5 Add By Ken 160314(E) 
   
   #lori522612  150205  mark ----------------------(S)
   #LET l_cnt = 0
   #SELECT COUNT(*) INTO l_cnt FROM adep620_org_tmp
   #IF l_cnt > 0 THEN
   #  DELETE FROM adep620_org_tmp
   #END IF
   #lori522612  150205  mark ----------------------(E)   
   CALL s_transaction_begin()
   DELETE FROM adep620_org_tmp
   #lori522612  150205  add ----------------------(E)  
   CALL adep620_extand_org(g_master.l_extend_flag,g_org)
   
   #160225-00040#5 Add By Ken 160314(S)   產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#5 Add By Ken 160314(e) 
   
   IF NOT adep620_data_process(lc_param.type,lc_param.deba041,lc_param.deba042,lc_param.recalculated) THEN
      CALL s_transaction_end('N',0)
   ELSE
      CALL s_transaction_end('Y',0) 
   END IF
   
   #160225-00040#5 Add By Ken 160314(S)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg) 
   #160225-00040#5 Add By Ken 160314(E) 
   
   CALL cl_err_collect_show()
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
   CALL adep620_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep620.get_buffer" >}
PRIVATE FUNCTION adep620_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_deba041 = p_dialog.getFieldBuffer('l_deba041')
   LET g_master.l_deba042 = p_dialog.getFieldBuffer('l_deba042')
   LET g_master.l_extend_flag = p_dialog.getFieldBuffer('l_extend_flag')
   LET g_master.l_recalculated = p_dialog.getFieldBuffer('l_recalculated')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep620.msgcentre_notify" >}
PRIVATE FUNCTION adep620_msgcentre_notify()
 
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
 
{<section id="adep620.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 月結批次處理
# Memo...........:
# Usage..........: adep620_data_process(p_type,p_deba041,p_deba042,p_recalculated)
#                  RETURNING r_success
# Input parameter: p_type         處理類型(1.單品 2.門店組織)
#                  p_deba041      月結年度
#                  p_deba042      月結月份
#                  p_recalculated 是否刪除已結算過的資料
# Return code....: r_success
# Date & Author..: 2015/01/05 By Ken
# Modify.........:
################################################################################
PUBLIC FUNCTION adep620_data_process(p_type,p_deba041,p_deba042,p_recalculated)
DEFINE l_sql              STRING
DEFINE r_success          LIKE type_t.num5
DEFINE p_type             LIKE type_t.chr10
DEFINE p_deba041          LIKE deba_t.deba041
DEFINE p_deba042          LIKE deba_t.deba042
DEFINE p_recalculated     LIKE type_t.chr1
DEFINE l_ooef001          LIKE ooef_t.ooef001
DEFINE l_sour_flag        LIKE type_t.chr1
DEFINE l_count            LIKE type_t.num5

   LET r_success = TRUE
   
   
   LET l_sql = "SELECT ooef001 FROM adep620_org_tmp"
   PREPARE adep620_tmp_table_pre FROM l_sql
   DECLARE adep620_tmp_table_cur CURSOR FOR adep620_tmp_table_pre
   FOREACH adep620_tmp_table_cur INTO l_ooef001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'adep620_tmp_table_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success         
   END IF 
      IF p_type = 1 THEN
         SELECT COUNT(*) INTO l_count FROM deba_t
          WHERE debaent = g_enterprise  #160905-00003#5 Add By Ken 160905
            AND debasite = l_ooef001      
      ELSE
         SELECT COUNT(*) INTO l_count FROM debu_t
          WHERE debuent = g_enterprise  #160905-00003#5 Add By Ken 160905
            AND debusite = l_ooef001
      END IF
      
      IF l_count > 0 THEN
         LET l_sour_flag = 'Y'
      ELSE
         LET l_sour_flag = 'N'
      END IF
      
      LET l_sql = "UPDATE adep620_org_tmp SET sour_flag = ? where ooef001 = ? "
      PREPARE adep620_org_tmp_update FROM l_sql
      EXECUTE adep620_org_tmp_update USING l_sour_flag,l_ooef001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adep620_org_tmp_update"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
   END FOREACH
   
  
   LET l_sql = "DELETE FROM debu_t ",
                     " WHERE debuent = ",g_enterprise,
                     "   AND EXISTS(SELECT 1 FROM adep620_org_tmp WHERE ooef001 = debusite) ",
                     "   AND debu002 = ? AND debu003 = ? "
   #DISPLAY l_sql             
   PREPARE adep620_del_debu FROM l_sql
   
   LET g_sql = "INSERT INTO  debu_t (",
               "       debuent,debusite,debu001,debu002,debu003,",
               "       debu004,debu005, debu006,debu007,debu008,",
               "       debu009,debu010, debu011,debu012,debu013,",
               "       debu014,debu015, debu016,debu017,debu018,",
               "       debu019,debu020, debu021,debu022,debu023,",
               "       debu024,debu025, debu026,debu027,debu028,",
               "       debu029,debu030, debu031,debu032,debu033,",
               "       debu034,debu035, debu036,debu037,debu038,",
               "       debu039,debu040,debu041 ) ",
               "SELECT debaent,debasite,'',deba041,deba042,",
               #150108-00008#1 Modify-S By Ken 150426
               #"       ' ','','',deba009,deba043,",
               "       ' ','','',deba009,COALESCE(deba043,' '),",
               #150108-00008#1 Modify-E
               "       deba011,deba012,deba013,deba014,'',",
               "       deba016,'',deba018,COALESCE(SUM(COALESCE(deba019,0)),0),deba020,",
               "       COALESCE(SUM(COALESCE(deba021,0)),0),COALESCE(SUM(COALESCE(deba022,0)),0), ",
               "       COALESCE(SUM(COALESCE(deba023,0)),0),COALESCE(SUM(COALESCE(deba024,0)),0), ",
               "       COALESCE(SUM(COALESCE(deba025,0)),0),COALESCE(SUM(COALESCE(deba026,0)),0), ",
               "       COALESCE(SUM(COALESCE(deba026,0)),0)-COALESCE(SUM(COALESCE(deba023,0)),0), ",
               #lori522612  150205  add ----------------------(S)
               #增加判斷分母為0時的處理
               #"       (COALESCE(SUM(COALESCE(deba026,0)),0)-COALESCE(SUM(COALESCE(deba023,0)),0))/COALESCE(SUM(COALESCE(deba026,0)),0)*100, ",
               "      (CASE WHEN COALESCE(SUM(COALESCE(deba026,0)),0) = 0 THEN 0 ",
               "            ELSE (COALESCE(SUM(COALESCE(deba026,0)),0)-COALESCE(SUM(COALESCE(deba023,0)),0))/COALESCE(SUM(COALESCE(deba026,0)),0)*100 ",
               "       END),",
               #lori522612  150205  add ----------------------(E)
               "       COALESCE(SUM(COALESCE(deba029,0)),0),COALESCE(SUM(COALESCE(deba030,0)),0), ",
               "       COALESCE(SUM(COALESCE(deba031,0)),0),COALESCE(SUM(COALESCE(deba032,0)),0), ",
               "       '',COALESCE(SUM(COALESCE(deba034,0)),0),'',",
               "       '','','','','',",
               "       COALESCE(SUM(COALESCE(deba044,0)),0),deba010,deba006 ",
               "  FROM deba_t t0 ",
               "  WHERE debaent = ",g_enterprise,       #lori522612  150205  add 
               "    AND deba041 = ",p_deba041,          #lori522612  150205  mod 
               "    AND deba042 = ",p_deba042,          #lori522612  150205  mod 
               " AND EXISTS(SELECT 1 FROM adep620_org_tmp t2 WHERE t2.ooef001 = t0.debasite) ",
               " AND NOT EXISTS(SELECT 1 FROM debu_t t1 ",
               "                        WHERE t1.debuent = t0.debaent ",
               "                          AND t1.debusite = t0.debasite ",
               "                          AND t1.debu002 = t0.deba041 ",
               "                          AND t1.debu003 = t0.deba042 ",
               "                          AND t1.debu004 = t0.deba005 ",           
               "                          AND t1.debu007 = t0.deba009 ",
               "                          AND t1.debu008 = t0.deba043 ",
               "                          AND t1.debu016 = t0.deba018 ",
               "                          AND t1.debu018 = t0.deba020 ",
               "                          AND t1.debu020 = t0.deba022)",
               " GROUP BY debaent,debasite,deba041,deba042,deba009,",
               "          deba043,deba011,deba012,deba013,deba014,",
               "          deba016,deba018,deba020,deba010,deba006 "  
   #DISPLAY g_sql                  
   PREPARE adep620_ins_debu FROM g_sql
   
   LET l_sql = "DELETE FROM debv_t ",
               " WHERE debvent = ",g_enterprise,
               "   AND EXISTS(SELECT 1 FROM adep620_org_tmp WHERE ooef001 = debvsite) ",
               "   AND debv002 = ? AND debv003 = ? "
   PREPARE adep620_del_debv FROM l_sql
   #DISPLAY l_sql 
   
   LET g_sql = "INSERT INTO debv_t (",
               "       debvent,debvsite,debv001,debv002,debv003,",
               "       debv012,debv013, debv014,debv015,debv016,",
               "       debv017,debv018, debv019,debv020,debv025,",
               "       debv026,debv027,debv028) ",
               "SELECT debuent,debusite,debu001,debu002,debu003,",
               "       COALESCE(SUM(COALESCE(debu019,0)),0),COALESCE(SUM(COALESCE(debu020,0)),0),COALESCE(SUM(COALESCE(debu021,0)),0),COALESCE(SUM(COALESCE(debu022,0)),0),COALESCE(SUM(COALESCE(debu023,0)),0),",
               "       COALESCE(SUM(COALESCE(debu024,0)),0),COALESCE(SUM(COALESCE(debu025,0)),0),(COALESCE(SUM(COALESCE(debu025,0)),0)/COALESCE(SUM(COALESCE(debu024,0)),0))*100,COALESCE(SUM(COALESCE(debu027,0)),0),COALESCE(SUM(COALESCE(debu032,0)),0),",
               "       COALESCE(SUM(COALESCE(debu039,0)),0),COALESCE(SUM(COALESCE(debu030,0)),0),'' ",
               "  FROM debu_t t0 ",
               "  WHERE debuent = ",g_enterprise,   #lori522612  150205  add 
               "    AND debu002 = ",p_deba041,      #lori522612  150205  mod 
               "    AND debu003 = ",p_deba042,      #lori522612  150205  mod 
               " AND EXISTS(SELECT 1 FROM adep620_org_tmp t2 WHERE t2.ooef001 = t0.debusite) ", 
               " AND NOT EXISTS(SELECT 1 FROM debv_t t1 ",
               "                 WHERE t1.debvent = t0.debuent ",
               "                   AND t1.debvsite = t0.debusite ",
               "                   AND t1.debv002 = t0.debu002 ",
               "                   AND t1.debv003 = t0.debu003 )",              
               " GROUP BY debuent,debusite,debu001,debu002,debu003 "
   #DISPLAY g_sql 
   PREPARE adep620_ins_debv FROM g_sql   

   #lori522612  150204  add ----------------------(S)
   #沒有符合條件的結算資料
   LET l_count = 0
   LET g_sql = "SELECT COUNT(*) ",
               "  FROM deba_t t0 ",
               " WHERE debaent = ",g_enterprise,   
               "   AND deba041 = ",p_deba041,      #lori522612  150205  mod 
               "   AND deba042 = ",p_deba042,      #lori522612  150205  mod 
               " AND EXISTS(SELECT 1 FROM adep620_org_tmp t2 WHERE t2.ooef001 = t0.debasite) "
   PREPARE adep620_cnt_sour FROM g_sql           
   EXECUTE adep620_cnt_sour INTO l_count
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00075'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success       
   END IF
   #lori522612  150204  add ----------------------(E)

   IF p_type = 1 THEN
      IF p_recalculated = 'Y' THEN         
         EXECUTE adep620_del_debu USING p_deba041,p_deba042
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del adep620_debu"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF        
      END IF
      EXECUTE adep620_ins_debu
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins adep620_debu"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      IF p_recalculated = 'Y' THEN
         EXECUTE adep620_del_debv USING p_deba041,p_deba042
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del adep620_debv"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF        
      END IF

      EXECUTE adep620_ins_debv
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins adep620_debv"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   LET l_sql = "SELECT ooef001 FROM adep620_org_tmp WHERE sour_flag = 'N' "
   PREPARE adep620_tmp_table_n_pre FROM l_sql
   DECLARE adep620_tmp_table_n_cur CURSOR FOR adep620_tmp_table_n_pre
   FOREACH adep620_tmp_table_n_cur INTO l_ooef001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'adep620_tmp_table_n_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success         
   END IF 
   
      INITIALIZE g_errparam TO NULL
      IF p_type = 1 THEN
         LET g_errparam.code =  "ade-00070"   
      ELSE
         LET g_errparam.code =  "ade-00071"   
      END IF
      LET g_errparam.extend = ''    
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_ooef001
      CALL cl_err()
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 建立結算組織暫存檔
# Memo...........:
# Usage..........: CALL adep620_create_org_tmp()
# Date & Author..: 2014/12/31 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adep620_create_org_tmp()
   WHENEVER ERROR CONTINUE
   
   CALL adep620_drop_org_tmp()
   CREATE TEMP TABLE adep620_org_tmp(
      ooef001   LIKE ooef_t.ooef001,
      sour_flag LIKE type_t.chr1)
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL adep620_drop_org_tmp()
# Date & Author..: 2014/12/31 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adep620_drop_org_tmp()
   WHENEVER ERROR CONTINUE   

   DROP TABLE adep620_org_tmp
END FUNCTION

################################################################################
# Descriptions...: 列出要進行結算的組織
# Memo...........: 執行注意...
#                  CALL adep620_create_org_tmp
#                  CALL s_transaction_begin
#                  CALL adep620_extand_org
#                  CALL s_transaction_end
#                  CALL adep620_drop_org_tmp
# Usage..........: CALL adep620_extand_org(p_extend_flag,p_org)
# Input parameter: p_extend_flag    是否展下階組織
#                  p_org            結算組織,STRING
# Date & Author..: 2014/12/31 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adep620_extand_org(p_extend_flag,p_org)
   DEFINE p_extend_flag   LIKE type_t.chr1
   DEFINE p_org           STRING
   DEFINE l_sql           STRING   
   DEFINE l_ooed004       LIKE ooed_t.ooed004   
   DEFINE l_ooed001       LIKE ooed_t.ooed001 
   DEFINE tok             base.StringTokenizer   
   
   WHENEVER ERROR CONTINUE
   
   #lori522612  150205  add ----------------------(S)
   #LET l_ooed001 = '11'    #物流組織
   #動態取aooi500的組織類型設定
   LET l_ooed001 = ''
   SELECT ooez006 INTO l_ooed001 
     FROM ooez_t 
    WHERE ooezent = g_enterprise
      AND ooez001 = g_prog
      AND ooez002 = '1'
   IF cl_null(l_ooed001) THEN
      LET l_ooed001 = '11'    #物流組織
   END IF   
   #lori522612  150205  add ----------------------(E)
   
   #展下階組織
   LET l_sql = "INSERT INTO adep620_org_tmp(ooef001) ",
               "SELECT DISTINCT ooed004 ",
               "  FROM ooed_t ",
               " WHERE     ooedent = ",g_enterprise,
               "       AND ooed001 = '",l_ooed001,"' ",               
               "       AND ooed006 <= '",g_today,"'",
               "       AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
               "       AND ooed004 IN ",
               "              (    SELECT ooed004 ",
               "                     FROM ooed_t ",
               "               START WITH     ooed005 = ? ", 
               "                          AND ooed001 = '",l_ooed001,"' ",
               "                          AND ooed006 <= '",g_today,"'",
               "                          AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
               "               CONNECT BY NOCYCLE     PRIOR ooed004 = ooed005 ",
               "                                  AND ooed001 = '",l_ooed001,"' ",
               "                                  AND ooed006 <= '",g_today,"'",
               "                                  AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
               "               UNION ",
               "               SELECT ooed004 ",
               "                 FROM ooed_t ",
               "                WHERE ooed004 = ? ) "
   PREPARE adep620_org FROM l_sql   
   
   #拆出組織
   LET tok = base.StringTokenizer.create(p_org,"|")
   
   WHILE tok.hasMoreTokens()
      LET l_ooed004  = ''    
      LET l_ooed004 = tok.nextToken()             
      
      IF NOT cl_null(l_ooed004) THEN
         IF p_extend_flag = 'N' THEN
            INSERT INTO adep620_org_tmp(ooef001) VALUES(l_ooed004)
         ELSE
            EXECUTE adep620_org USING l_ooed004,l_ooed004
         END IF 
      END IF       
   END WHILE
   
END FUNCTION

#end add-point
 
{</section>}
 
