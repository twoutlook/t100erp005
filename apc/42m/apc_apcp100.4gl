#該程式未解開Section, 採用最新樣板產出!
{<section id="apcp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-08-14 14:27:10), PR版次:0004(2016-03-03 09:11:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: apcp100
#+ Description: 前臺後臺統計分析批處理作業
#+ Creator....: 03247(2015-08-03 11:20:39)
#+ Modifier...: 03247 -SD/PR- 06814
 
{</section>}
 
{<section id="apcp100.global" >}
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
   pcar001      LIKE pcar_t.pcar001,
   receiver     LIKE type_t.chr500, 
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pcarsite LIKE type_t.chr10, 
   pcar001 LIKE type_t.dat, 
   receiver LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單身 type 宣告
 TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   pcas002 LIKE pcas_t.pcas002, 
   pcas003 LIKE pcas_t.pcas003, 
   pcas004 LIKE pcas_t.pcas004, 
   pcas0031 LIKE type_t.chr80, 
   pcas0041 LIKE type_t.chr80, 
   pcasstus LIKE pcas_t.pcasstus
       END RECORD
 TYPE type_g_detail2 RECORD
       pcas001 LIKE pcas_t.pcas001, 
   pcas002 LIKE pcas_t.pcas002, 
   pcas003 LIKE pcas_t.pcas003, 
   pcas004 LIKE pcas_t.pcas004
       END RECORD
 
 TYPE type_g_detail3 RECORD
       pcat002 LIKE pcat_t.pcat002, 
   pcat003 LIKE pcat_t.pcat003, 
   pcat003_desc LIKE type_t.chr500, 
   pcat005 LIKE pcat_t.pcat005, 
   pcat0051 LIKE type_t.chr80, 
   pcat0052 LIKE type_t.chr80, 
   pcat0053 LIKE type_t.chr80, 
   pcatstus LIKE pcat_t.pcatstus
       END RECORD
 
 TYPE type_g_detail4 RECORD
       pcat001 LIKE pcat_t.pcat001, 
   pcat002 LIKE pcat_t.pcat002, 
   pcat004 LIKE pcat_t.pcat004, 
   pcat004_desc LIKE type_t.chr500, 
   pcat005 LIKE pcat_t.pcat005
       END RECORD
 
 TYPE type_g_detail5 RECORD
       rtjadocdt LIKE rtja_t.rtjadocdt, 
   pcat001 LIKE pcat_t.pcat001, 
   pcat002 LIKE pcat_t.pcat002, 
   pcat003 LIKE pcat_t.pcat003, 
   pcat003_1_desc LIKE type_t.chr500, 
   pcat005 LIKE pcat_t.pcat005, 
   rtja033 LIKE rtja_t.rtja033, 
   rtja034 LIKE rtja_t.rtja034, 
   rtja035 LIKE rtja_t.rtja035, 
   rtjapstdt LIKE rtja_t.rtjapstdt, 
   rtjf036 LIKE rtjf_t.rtjf036
       END RECORD
   
 TYPE type_g_detail6 RECORD
       pcaw002 LIKE type_t.chr500,
   pcaw005 LIKE pcaw_t.pcaw005, 
   pcaw005_desc LIKE type_t.chr500,        
   pcaw008 LIKE type_t.chr500, 
   pcaw012 LIKE type_t.chr500, 
   pcaw0081 LIKE type_t.chr80, 
   pcaw0121 LIKE type_t.chr80
       END RECORD
       
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
 
DEFINE g_detail4     DYNAMIC ARRAY OF type_g_detail4
DEFINE g_detail4_t   type_g_detail4
 
DEFINE g_detail5     DYNAMIC ARRAY OF type_g_detail5
DEFINE g_detail5_t   type_g_detail5

DEFINE g_detail6     DYNAMIC ARRAY OF type_g_detail6
DEFINE g_detail6_t   type_g_detail6

DEFINE g_flag         LIKE type_t.chr1     #狀態是否異常
DEFINE g_flag1        LIKE type_t.chr1     #是否有延误上传
DEFINE g_pcarsite     LIKE pcar_t.pcarsite
DEFINE g_pcarsite_desc LIKE ooefl_t.ooefl003
DEFINE g_pcarstus     LIKE pcar_t.pcarstus
DEFINE g_pcar001      LIKE pcar_t.pcar001
DEFINE g_amt_f        LIKE type_t.num10
DEFINE g_amt_b        LIKE type_t.num10
DEFINE g_sum_f        LIKE type_t.num20_6
DEFINE g_sum_b        LIKE type_t.num20_6
DEFINE g_pcas_str     STRING         #正常上傳統計
DEFINE g_pcat_str     STRING         #正常上傳款別統計
DEFINE g_pcas_str1    STRING         #延誤上傳統計
DEFINE g_pcaw_str     STRING         #異常機號統計
DEFINE l_ac           LIKE type_t.num10             #目前處理的ARRAY CNT
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apcp100.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_aooi500_create_temp() RETURNING l_success
      #end add-point
      CALL apcp100_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apcp100 WITH FORM cl_ap_formpath("apc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apcp100_init()
 
      #進入選單 Menu (="N")
      CALL apcp100_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apcp100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apcp100.init" >}
#+ 初始化作業
PRIVATE FUNCTION apcp100_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
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
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apcp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apcp100_ui_dialog()
 
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
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.pcar001,g_master.receiver 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcar001
            #add-point:BEFORE FIELD pcar001 name="input.b.pcar001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcar001
            
            #add-point:AFTER FIELD pcar001 name="input.a.pcar001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcar001
            #add-point:ON CHANGE pcar001 name="input.g.pcar001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD receiver
            #add-point:BEFORE FIELD receiver name="input.b.receiver"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD receiver
            
            #add-point:AFTER FIELD receiver name="input.a.receiver"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE receiver
            #add-point:ON CHANGE receiver name="input.g.receiver"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.pcar001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcar001
            #add-point:ON ACTION controlp INFIELD pcar001 name="input.c.pcar001"
            
            #END add-point
 
 
         #Ctrlp:input.c.receiver
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD receiver
            #add-point:ON ACTION controlp INFIELD receiver name="input.c.receiver"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pcarsite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pcarsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcarsite
            #add-point:ON ACTION controlp INFIELD pcarsite name="construct.c.pcarsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pcarsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcarsite  #顯示到畫面上
            NEXT FIELD pcarsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcarsite
            #add-point:BEFORE FIELD pcarsite name="construct.b.pcarsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcarsite
            
            #add-point:AFTER FIELD pcarsite name="construct.a.pcarsite"
            
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
            CALL apcp100_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.pcar001 = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
            LET g_master.pcar001 = g_master.pcar001 - 1
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
         CALL apcp100_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.pcar001 = g_master.pcar001
      LET lc_param.receiver = g_master.receiver
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
                 CALL apcp100_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apcp100_transfer_argv(ls_js)
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
 
{<section id="apcp100.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apcp100_transfer_argv(ls_js)
 
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
 
{<section id="apcp100.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apcp100_process(ls_js)
 
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
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE ls_text       STRING
   DEFINE l_site        LIKE type_t.chr500
   DEFINE l_date        LIKE type_t.chr500
   DEFINE l_amt_f       LIKE type_t.chr500
   DEFINE l_amt_b       LIKE type_t.chr500
   DEFINE l_sum_f       LIKE type_t.chr500
   DEFINE l_sum_b       LIKE type_t.chr500
   DEFINE l_where       STRING
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_str         STRING
   DEFINE l_msg         STRING             #160225-00040#11 20160302 add by beckxie
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
   IF cl_null(lc_param.pcar001) THEN
     LET lc_param.pcar001 = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
     LET lc_param.pcar001 = lc_param.pcar001 - 1
   END IF
   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = " 1=1"
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #160225-00040#11 20160302 add by beckxie---S
      CALL cl_progress_bar_no_window(4)   
      #160225-00040#11 20160302 add by beckxie---E
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apcp100_process_cs CURSOR FROM ls_sql
#  FOREACH apcp100_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040#11 20160302 add by beckxie---S
   LET l_msg = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#11 20160302 add by beckxie---E
   LET g_flag = 'N'
   LET g_flag1 = 'N'
   #LET l_where = s_aooi500_q_where(g_prog,'pcarsite',g_site,'c')
   #DISPLAY "l_where:",l_where
   #LET lc_param.wc = lc_param.wc," AND ",l_where
   LET lc_param.wc = cl_replace_str(lc_param.wc,"pcarsite","ooef001")
   LET g_pcar001 = lc_param.pcar001
   LET l_sql = " SELECT ooef001 FROM ooef_t ",
               "  WHERE ooefent = ",g_enterprise," ",
               "    AND ",lc_param.wc
   PREPARE sel_ooef_pre FROM l_sql
   DECLARE sel_ooef_cs  CURSOR FOR sel_ooef_pre
   #信件內容
   LET l_site = cl_getmsg('apc-00037',g_dlang)
   LET l_date = cl_getmsg('apc-00038',g_dlang)
   LET l_amt_f = cl_getmsg('apc-00039',g_dlang)
   LET l_amt_b = cl_getmsg('apc-00041',g_dlang)
   LET l_sum_f = cl_getmsg('apc-00040',g_dlang)
   LET l_sum_b = cl_getmsg('apc-00042',g_dlang)
   #160225-00040#11 20160302 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#11 20160302 add by beckxie---E
   FOREACH sel_ooef_cs  INTO l_ooef001
      LET g_pcarsite = l_ooef001
      SELECT ooefl003 INTO g_pcarsite_desc FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = g_pcarsite
         AND ooefl002 = g_dlang
      LET g_amt_f = 0
      LET g_sum_f = 0
      LET g_amt_b = 0
      LET g_sum_b = 0
      LET l_sql = " SELECT pcar002,pcar003 FROM pcar_t ",
                  "  WHERE pcarent = ",g_enterprise," ",
                  "    AND pcarsite = '",g_pcarsite,"' ",
                  "    AND pcar001 = '",lc_param.pcar001,"' "
      PREPARE sel_pcar_pre FROM l_sql
      EXECUTE sel_pcar_pre INTO g_amt_f,g_sum_f
      IF cl_null(g_amt_f) THEN
         LET g_amt_f = 0
      END IF
      IF cl_null(g_sum_f) THEN
         LET g_sum_f = 0
      END IF
      
      LET l_sql = " SELECT COUNT(DISTINCT rtjadocno),SUM(rtja049) FROM rtja_t ",
                  "  WHERE rtjaent = ",g_enterprise," ",
                  "    AND rtjasite = '",g_pcarsite,"' ",
                  "    AND rtjadocdt = '",lc_param.pcar001,"' ",
                  "    AND rtja032 = '2' "
                  #"    AND to_char(rtjadocdt,'YYYYMMDD') = to_char(rtjacrtdt,'YYYYMMDD') "
      PREPARE sel_rtja_pre FROM l_sql
      EXECUTE sel_rtja_pre INTO g_amt_b,g_sum_b
      IF cl_null(g_amt_b) THEN
         LET g_amt_b = 0
      END IF
      IF cl_null(g_sum_b) THEN
         LET g_sum_b = 0
      END IF
      
      IF g_sum_f <> 0 OR g_sum_f <> 0 OR g_amt_b <> 0 OR g_sum_b <> 0 THEN
         IF g_amt_f = g_amt_b AND g_sum_f = g_sum_b THEN
            LET g_flag = 'N'
         ELSE
            LET g_flag = 'Y'
         END IF
      ELSE
         CONTINUE FOREACH
      END IF
      
      CALL apcp100_b_fill(g_pcarsite,lc_param.pcar001)
      
      #发出mail
      #LET g_pcarstus = '1'
      IF g_pcarstus = '1' THEN
         #单头显示
         IF cl_null(ls_text) THEN
            LET ls_text = l_site,g_pcarsite,"   ",g_pcarsite_desc,"          ",l_date,g_pcar001,"\n",l_amt_f,g_amt_f USING '#########&',"          ",l_amt_b,g_amt_b USING '#########&',"\n",
                          l_sum_f,g_sum_f USING '#########&.&&',"          ",l_sum_b,g_sum_b USING '#########&.&&',"\n"
         ELSE
            LET ls_text = ls_text,"\n\n",l_site,g_pcarsite,"   ",g_pcarsite_desc,"          ",l_date,g_pcar001,"\n",l_amt_f,g_amt_f USING '#########&',"          ",l_amt_b,g_amt_b USING '#########&',"\n",
                          l_sum_f,g_sum_f USING '#########&.&&',"          ",l_sum_b,g_sum_b USING '#########&.&&',"\n"
         END IF
         #单头下的横线
         LET ls_text = ls_text,"——————————————————————————————————————————————","\n"
         #LET ls_text = ls_text,g_pcas_str,"\n",g_pcat_str,"\n"
         #20151105--dongsz add--str
         IF cl_null(g_pcas_str) THEN
            LET ls_text = ls_text,g_pcat_str,"\n"
         ELSE
            LET ls_text = ls_text,g_pcas_str,"\n"
            IF NOT cl_null(g_pcaw_str) THEN
               LET ls_text = ls_text,g_pcaw_str,"\n"
            END IF
         END IF
         #20151105--dongsz add--end
         #LET ls_text = ls_text,g_pcas_str,"\n"
         IF g_flag1 = 'Y' THEN
            LET ls_text = ls_text,g_pcas_str1,"\n"
         END IF
         LET ls_text = ls_text,"\n"
      END IF
   END FOREACH
   IF NOT cl_null(ls_text) THEN
      #备注
      LET l_str = cl_getmsg('apc-00051',g_dlang)
      LET ls_text = ls_text,"\n\n",l_str
   END IF
   #160225-00040#11 20160302 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#11 20160302 add by beckxie---E
   CALL apcp100_send_mail(ls_text,lc_param.receiver) 
   #160225-00040#11 20160302 add by beckxie---S
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#11 20160302 add by beckxie---E
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apcp100_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apcp100.get_buffer" >}
PRIVATE FUNCTION apcp100_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.pcar001 = p_dialog.getFieldBuffer('pcar001')
   LET g_master.receiver = p_dialog.getFieldBuffer('receiver')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apcp100.msgcentre_notify" >}
PRIVATE FUNCTION apcp100_msgcentre_notify()
 
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
 
{<section id="apcp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 填充資料明細
# Memo...........:
# Usage..........: CALL apcp100_b_fill(p_pcarsite,p_pcar001)
# Date & Author..: 20150803 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION apcp100_b_fill(p_pcarsite,p_pcar001)
DEFINE p_pcarsite      LIKE pcar_t.pcarsite
DEFINE p_pcar001       LIKE pcar_t.pcar001
DEFINE l_sql           STRING
DEFINE l_sql1          STRING
DEFINE l_str           STRING
DEFINE l_str1          STRING
DEFINE l_str2          STRING
DEFINE l_str3          STRING
DEFINE l_str4          STRING
DEFINE l_str5          STRING
DEFINE l_str6          STRING
DEFINE l_str7          STRING

   #add-point:陣列清空
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   CALL g_detail5.clear()
   CALL g_detail6.clear()
   LET g_pcas_str = ''
   LET g_pcat_str = ''
   LET g_pcaw_str = ''    #20151207 dongsz add 
   LET g_pcas_str1 = ''   #20151207 dongsz add
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:2)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   #正常上传统计
   LET l_sql = " SELECT '',(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) a, ",
               "        0,0,COALESCE(COUNT(DISTINCT rtjadocno),0),COALESCE(SUM(rtja049),0) ",
               "   FROM rtja_t ",
               "  WHERE rtjaent = ",g_enterprise," ",
               "    AND rtjasite = '",p_pcarsite,"' ",
               "    AND rtjadocdt = '",p_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY '',(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) ",
               " UNION ",
               " SELECT '',(CASE pcas002 WHEN '0' THEN '1' WHEN '2' THEN '1' WHEN '5' THEN '1' WHEN '6' THEN '2' WHEN '7' THEN '2' END), ",
               "        COALESCE(SUM(pcas003),0),COALESCE(SUM(pcas004),0),0,0 ",
               "   FROM pcas_t ",
               "  WHERE pcasent = ",g_enterprise," ",
               "    AND pcassite = '",p_pcarsite,"' ",
               "    AND pcas001 = '",p_pcar001,"' ",
               "    AND (CASE pcas002 WHEN '0' THEN '1' WHEN '2' THEN '1' WHEN '5' THEN '1' WHEN '6' THEN '2' WHEN '7' THEN '2' END) NOT IN ( ",
               "         SELECT (CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) FROM rtja_t ",
               "          WHERE rtjaent = ",g_enterprise," AND rtjasite = '",p_pcarsite,"' AND rtjadocdt = '",p_pcar001,"' ",
               "            AND rtja032 = '2' AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD')) ",
               "  GROUP BY '',(CASE pcas002 WHEN '0' THEN '1' WHEN '2' THEN '1' WHEN '5' THEN '1' WHEN '6' THEN '2' WHEN '7' THEN '2' END) ",
               "  ORDER BY a "
   PREPARE sel_pcas_pre FROM l_sql
   DECLARE sel_pcas_cs  CURSOR FOR sel_pcas_pre
   FOREACH sel_pcas_cs  INTO g_detail[l_ac].sel,g_detail[l_ac].pcas002,g_detail[l_ac].pcas003,g_detail[l_ac].pcas004,
                             g_detail[l_ac].pcas0031,g_detail[l_ac].pcas0041
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF g_detail[l_ac].pcas003 = 0 AND g_detail[l_ac].pcas004 = 0 THEN
         #销售
         IF g_detail[l_ac].pcas002 = '1' THEN
            LET l_sql1 = " SELECT COALESCE(SUM(pcas003),0),COALESCE(SUM(pcas004),0) FROM pcas_t ",
                         "  WHERE pcasent = ",g_enterprise," AND pcassite = '",p_pcarsite,"' ",
                         "    AND pcas001 = '",p_pcar001,"' AND pcas002 IN ('0','2','5') "
            PREPARE sel_rtja_pre1 FROM l_sql1
            EXECUTE sel_rtja_pre1 INTO g_detail[l_ac].pcas003,g_detail[l_ac].pcas004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
         #充值
         IF g_detail[l_ac].pcas002 = '2' THEN
            LET l_sql1 = " SELECT COALESCE(SUM(pcas003),0),COALESCE(SUM(pcas004),0) FROM pcas_t ",
                         "  WHERE pcasent = ",g_enterprise," AND pcassite = '",p_pcarsite,"' ",
                         "    AND pcas001 = '",p_pcar001,"' AND pcas002 IN ('6','7') "
            PREPARE sel_rtja_pre2 FROM l_sql1
            EXECUTE sel_rtja_pre2 INTO g_detail[l_ac].pcas003,g_detail[l_ac].pcas004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
      END IF
      
      #狀態
      LET l_str = cl_getmsg('apc-00044',g_dlang)    #异常说明
      LET l_str1 = cl_getmsg('apc-00045',g_dlang)   #异常类型
      #单据类型
      IF g_detail[l_ac].pcas002 = '1' THEN
         LET l_str2 = cl_getmsg('apc-00046',g_dlang)   
      ELSE
         LET l_str2 = cl_getmsg('apc-00047',g_dlang)
      END IF
      LET l_str3 = cl_getmsg('apc-00039',g_dlang)   #前台数量
      LET l_str4 = cl_getmsg('apc-00041',g_dlang)   #后台数量
      LET l_str5 = cl_getmsg('apc-00040',g_dlang)   #前台金额
      LET l_str6 = cl_getmsg('apc-00042',g_dlang)   #后台金额
      IF g_detail[l_ac].pcas003 <> g_detail[l_ac].pcas0031 OR g_detail[l_ac].pcas004 <> g_detail[l_ac].pcas0041 THEN
#         IF cl_null(g_pcas_str) THEN
#            LET g_pcas_str = l_str,"\n","          ","          ",l_str3 USING '############',l_str5 USING '############',l_str4 USING '############',l_str6 USING '############',"\n",
#                             "          ",l_str2 USING '##########',g_detail[l_ac].pcas003 USING '###########&',g_detail[l_ac].pcas004 USING '########&.&&',g_detail[l_ac].pcas0031 USING '###########&',g_detail[l_ac].pcas0041 USING '########&.&&',"\n"
#         ELSE
#            LET g_pcas_str = g_pcas_str,"          ",l_str2 USING '##########',g_detail[l_ac].pcas003 USING '###########&',g_detail[l_ac].pcas004 USING '########&.&&',g_detail[l_ac].pcas0031 USING '###########&',g_detail[l_ac].pcas0041 USING '########&.&&',"\n"
#         END IF
         IF cl_null(g_pcas_str) THEN
            LET g_pcas_str = l_str,l_str1,l_str2,"     ",l_str3,g_detail[l_ac].pcas003 USING '---------&',"     ",l_str4,g_detail[l_ac].pcas0031 USING '---------&',"     ",l_str5,g_detail[l_ac].pcas004 USING '---------&.&&',"     ",l_str6,g_detail[l_ac].pcas0041 USING '---------&.&&',"\n"
         ELSE
            LET g_pcas_str = g_pcas_str,l_str,l_str1,l_str2,"     ",l_str3,g_detail[l_ac].pcas003 USING '---------&',"     ",l_str4,g_detail[l_ac].pcas0031 USING '---------&',"     ",l_str5,g_detail[l_ac].pcas004 USING '---------&.&&',"     ",l_str6,g_detail[l_ac].pcas0041 USING '---------&.&&',"\n"
         END IF
         LET g_detail[l_ac].pcasstus = '1'
         LET g_flag = 'Y'
      ELSE
         LET g_detail[l_ac].pcasstus = '0'
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point
   
   #20151111--dongsz add--str
   IF g_flag = 'Y' THEN
      #异常机号明细页签
                  #后台销售金额
      LET l_sql = " SELECT rtja036,rtja037,pcab003,0,0,COALESCE(COUNT(DISTINCT rtjadocno),0),0 ",
                  "   FROM rtja_t LEFT JOIN pcab_t ON pcabent = rtjaent AND pcab001 = rtja037 ",
                  "  WHERE rtjaent = ",g_enterprise," ",
                  "    AND rtjasite = '",p_pcarsite,"' ",
                  "    AND rtjadocdt = '",p_pcar001,"' ",
                  "    AND rtja032 = '2' ",
                  "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "    AND rtja000 IN ('artt610','artt700') ",
                  "  GROUP BY rtja036,rtja037,pcab003 ",
                  " UNION ",
                  #后台充值金额
                  " SELECT rtja036,rtja037,pcab003,0,0,0,COALESCE(COUNT(DISTINCT rtjadocno),0) ",
                  "   FROM rtja_t LEFT JOIN pcab_t ON pcabent = rtjaent AND pcab001 = rtja037 ",
                  "  WHERE rtjaent = ",g_enterprise," ",
                  "    AND rtjasite = '",p_pcarsite,"' ",
                  "    AND rtjadocdt = '",p_pcar001,"' ",
                  "    AND rtja032 = '2' ",
                  "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "    AND rtja000 IN ('ammt425') ",
                  "    AND rtja036||rtja037 NOT IN (SELECT rtja036||rtja037 FROM rtja_t WHERE rtjaent = ",g_enterprise," ",
                  "                                    AND rtjasite = '",p_pcarsite,"' AND rtjadocdt = '",p_pcar001,"' ",
                  "                                    AND rtja032 = '2' AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "                                    AND rtja000 IN ('artt610','artt700')) ",
                  "  GROUP BY rtja036,rtja037,pcab003 ",
                  " UNION ",
                  #前台销售金额
                  " SELECT pcaw002,pcaw005,pcab003,pcaw008,pcaw012,0,0 ",
                  "   FROM (SELECT pcaw002,pcaw005,pcab003,pcaw008,pcaw012,row_number() over (partition by pcaw002,pcaw005 order by pcaw003 desc) num ",
                  "           FROM pcaw_t LEFT JOIN pcab_t ON pcabent = pcawent AND pcab001 = pcaw005 ",
                  "          WHERE pcawent = ",g_enterprise," AND pcawsite = '",p_pcarsite,"' ",
                  "            AND pcaw001 = '",p_pcar001,"' AND pcaw004 = '0') ",
                  "  WHERE num = 1 ",
                  "    AND pcaw002||pcaw005 NOT IN (SELECT rtja036||rtja037 FROM rtja_t WHERE rtjaent = ",g_enterprise," ",
                  "                                    AND rtjasite = '",p_pcarsite,"' AND rtjadocdt = '",p_pcar001,"' ",
                  "                                    AND rtja032 = '2' AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "                                    AND rtja000 IN ('artt610','artt700','ammt425')) ",
                  "  ORDER BY rtja036,rtja037 "
      PREPARE sel_pcaw_pre FROM l_sql
      DECLARE sel_pcaw_cs  CURSOR FOR sel_pcaw_pre
      LET l_ac = 1
      FOREACH sel_pcaw_cs  INTO g_detail6[l_ac].pcaw002,g_detail6[l_ac].pcaw005,g_detail6[l_ac].pcaw005_desc,g_detail6[l_ac].pcaw008,
                                g_detail6[l_ac].pcaw012,g_detail6[l_ac].pcaw0081,g_detail6[l_ac].pcaw0121
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #后台充值数量
         IF g_detail6[l_ac].pcaw0121 = 0 THEN
            LET l_sql1 = " SELECT COALESCE(COUNT(DISTINCT rtjadocno),0) FROM rtja_t ",
                         "  WHERE rtjaent = ",g_enterprise," ",
                         "    AND rtjasite = '",p_pcarsite,"' ",
                         "    AND rtjadocdt = '",p_pcar001,"' ",
                         "    AND rtja032 = '2' ",
                         "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                         "    AND rtja000 IN ('ammt425') ",
                         "    AND rtja036 = '",g_detail6[l_ac].pcaw002,"' ",
                         "    AND rtja037 = '",g_detail6[l_ac].pcaw005,"' "
            PREPARE sel_rtja_pre4 FROM l_sql1
            EXECUTE sel_rtja_pre4 INTO g_detail6[l_ac].pcaw0121
            IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
       
         #前台数量
         IF g_detail6[l_ac].pcaw008 = 0 AND g_detail6[l_ac].pcaw012 = 0 THEN
            LET l_sql1 = " SELECT pcaw008,pcaw012 FROM pcaw_t ",
                         "  WHERE pcawent = ",g_enterprise," AND pcawsite = '",p_pcarsite,"' ",
                         "    AND pcaw001 = '",p_pcar001,"' AND pcaw004 = '0' ",
                         "    AND pcaw002 = '",g_detail6[l_ac].pcaw002,"' ",
                         "    AND pcaw005 = '",g_detail6[l_ac].pcaw005,"' ",
                         "    AND pcaw003 = (SELECT MAX(pcaw003) FROM pcaw_t WHERE pcawent = ",g_enterprise," ",
                         "                      AND pcawsite = '",p_pcarsite,"' ",
                         "                      AND pcaw001 = '",p_pcar001,"' AND pcaw004 = '0' ",
                         "                      AND pcaw002 = '",g_detail6[l_ac].pcaw002,"' ",
                         "                      AND pcaw005 = '",g_detail6[l_ac].pcaw005,"') "
            PREPARE sel_rtja_pre5 FROM l_sql1
            EXECUTE sel_rtja_pre5 INTO g_detail6[l_ac].pcaw008,g_detail6[l_ac].pcaw012
            IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
         
         LET g_detail6[l_ac].pcaw008 = g_detail6[l_ac].pcaw008 USING '---------&'
         LET g_detail6[l_ac].pcaw0081 = g_detail6[l_ac].pcaw0081 USING '---------&'
         LET g_detail6[l_ac].pcaw012 = g_detail6[l_ac].pcaw012 USING '---------&'
         LET g_detail6[l_ac].pcaw0121 = g_detail6[l_ac].pcaw0121 USING '---------&'
         
         IF g_detail6[l_ac].pcaw008 = g_detail6[l_ac].pcaw0081 AND g_detail6[l_ac].pcaw012 = g_detail6[l_ac].pcaw0121 THEN
            LET g_detail6[l_ac].pcaw002 = NULL
            LET g_detail6[l_ac].pcaw005 = NULL
            LET g_detail6[l_ac].pcaw005_desc = NULL
            LET g_detail6[l_ac].pcaw008 = NULL
            LET g_detail6[l_ac].pcaw012 = NULL
            LET g_detail6[l_ac].pcaw0081 = NULL
            LET g_detail6[l_ac].pcaw0121 = NULL
            CONTINUE FOREACH
         END IF
         
         #LET l_str = cl_getmsg('apc-00060',g_dlang)     #异常机号明细资料
         IF g_detail6[l_ac].pcaw008 = 0 AND g_detail6[l_ac].pcaw012 = 0 THEN
            LET l_str = cl_getmsg('apc-00060',g_dlang)
         ELSE
            LET l_str = cl_getmsg('apc-00063',g_dlang)
         END IF
         LET l_str1 = cl_getmsg('apc-00055',g_dlang)    #机号
         LET l_str2 = cl_getmsg('apc-00056',g_dlang)    #前台销售数量
         LET l_str3 = cl_getmsg('apc-00057',g_dlang)    #前台充值数量
         LET l_str4 = cl_getmsg('apc-00058',g_dlang)    #后台销售数量
         LET l_str5 = cl_getmsg('apc-00059',g_dlang)    #后台充值数量
         LET l_str6 = cl_getmsg('apc-00061',g_dlang)    #收银员
         LET l_str7 = cl_getmsg('apc-00062',g_dlang)    #姓名
         
#         IF cl_null(g_pcaw_str) THEN
#            LET g_pcaw_str = l_str,"\n","          ",l_str1 USING '##########',l_str6 USING '##########',l_str7 USING '##################',l_str2 USING '###############',l_str3 USING '###############',l_str4 USING '###############',l_str5 USING '###############',"\n",
#                             "          ",g_detail6[l_ac].pcaw002 USING '<<<<<<<<<<','     ',g_detail6[l_ac].pcaw005 USING '<<<<<<<<<<',g_detail6[l_ac].pcaw005_desc USING '##################',g_detail6[l_ac].pcaw008 USING '##############&',g_detail6[l_ac].pcaw012 USING '##############&',
#                             g_detail6[l_ac].pcaw0081 USING '##############&',g_detail6[l_ac].pcaw0121 USING '##############&',"\n"
#         ELSE
#            LET g_pcaw_str = g_pcaw_str,"          ",g_detail6[l_ac].pcaw002 USING '<<<<<<<<<<','     ',g_detail6[l_ac].pcaw005 USING '<<<<<<<<<<',g_detail6[l_ac].pcaw005_desc USING '##################',g_detail6[l_ac].pcaw008 USING '##############&',g_detail6[l_ac].pcaw012 USING '##############&',
#                             g_detail6[l_ac].pcaw0081 USING '##############&',g_detail6[l_ac].pcaw0121 USING '##############&',"\n"
#         END IF
         IF cl_null(g_pcaw_str) THEN
            LET g_pcaw_str = l_str,l_str1,g_detail6[l_ac].pcaw002,"     ",l_str6,g_detail6[l_ac].pcaw005,"     ",l_str7,g_detail6[l_ac].pcaw005_desc,"     ",
                             l_str2,g_detail6[l_ac].pcaw008 USING '---------&',"     ",l_str3,g_detail6[l_ac].pcaw012 USING '---------&',"     ",l_str4,g_detail6[l_ac].pcaw0081 USING '---------&',"     ",l_str5,g_detail6[l_ac].pcaw0121 USING '---------&',"\n"
         ELSE
            LET g_pcaw_str = g_pcaw_str,l_str,l_str1,g_detail6[l_ac].pcaw002,"     ",l_str6,g_detail6[l_ac].pcaw005,"     ",l_str7,g_detail6[l_ac].pcaw005_desc,"     ",
                             l_str2,g_detail6[l_ac].pcaw008 USING '---------&',"     ",l_str3,g_detail6[l_ac].pcaw012 USING '---------&',"     ",l_str4,g_detail6[l_ac].pcaw0081 USING '---------&',"     ",l_str5,g_detail6[l_ac].pcaw0121 USING '---------&',"\n"
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
   END IF
   #20151111--dongsz add--end
 
   #add-point:b_fill段資料填充(其他單身)
   #延误上传统计
   LET l_sql = " SELECT rtjacrtdt,(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) a, ",
               "        COALESCE(COUNT(DISTINCT rtjadocno),0),COALESCE(SUM(rtja049),0) FROM rtja_t ",
               "  WHERE rtjaent = ",g_enterprise," ",
               "    AND rtjasite = '",p_pcarsite,"' ",
               "    AND rtjadocdt = '",p_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')>to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY rtjacrtdt,(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) ",
               "  ORDER BY rtjacrtdt,a "
   PREPARE sel_rtja_pre3 FROM l_sql
   DECLARE sel_rtja_cs3  CURSOR FOR sel_rtja_pre3
   LET l_ac = 1
   FOREACH sel_rtja_cs3  INTO g_detail2[l_ac].pcas001,g_detail2[l_ac].pcas002,g_detail2[l_ac].pcas003,g_detail2[l_ac].pcas004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_str = cl_getmsg('apc-00052',g_dlang)     #异常说明
      LET l_str1 = cl_getmsg('apc-00053',g_dlang)    #POS营业日期
      LET l_str2 = cl_getmsg('apc-00045',g_dlang)    #单据类型
      IF g_detail2[l_ac].pcas002 = '1' THEN
         LET l_str3 = cl_getmsg('apc-00046',g_dlang) #销售  
      ELSE
         LET l_str3 = cl_getmsg('apc-00047',g_dlang) #充值
      END IF
      LET l_str4 = cl_getmsg('apc-00041',g_dlang)    #后台数量
      LET l_str5 = cl_getmsg('apc-00042',g_dlang)    #后台金额

#      IF cl_null(g_pcas_str1) THEN
#         LET g_pcas_str1 = l_str,"\n","          ",l_str1 USING '####################',l_str2 USING '##########',l_str4 USING '###############',l_str5 USING '###############',"\n",
#                           "          ",g_detail2[l_ac].pcas001 USING '####################',l_str3 USING '##########',g_detail2[l_ac].pcas003 USING '##############&',g_detail2[l_ac].pcas004 USING '###########&.&&',"\n"
#      ELSE
#         LET g_pcas_str1 = g_pcas_str1,"          ",g_detail2[l_ac].pcas001 USING '####################',l_str3 USING '##########',g_detail2[l_ac].pcas003 USING '##############&',g_detail2[l_ac].pcas004 USING '###########&.&&',"\n"
#      END IF
      IF cl_null(g_pcas_str1) THEN
         LET g_pcas_str1 = l_str,l_str1,g_detail2[l_ac].pcas001,"     ",l_str2,l_str3,"     ",l_str4,g_detail2[l_ac].pcas003 USING '---------&',"     ",l_str5,g_detail2[l_ac].pcas004 USING '------&.&&',"\n"
      ELSE
         LET g_pcas_str1 = g_pcas_str1,l_str,l_str1,g_detail2[l_ac].pcas001,"     ",l_str2,l_str3,"     ",l_str4,g_detail2[l_ac].pcas003 USING '---------&',"     ",l_str5,g_detail2[l_ac].pcas004 USING '------&.&&',"\n"
      END IF

      LET g_flag1 = 'Y'        #是否有延误上传
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   #正常上传款别统计
   LET l_sql = " SELECT rtjf030,rtjf002,0,COALESCE(SUM(rtjf031),0),0,0 FROM rtjf_t,rtja_t ",
               "  WHERE rtjfent = ",g_enterprise," ",
               "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
               "    AND rtjfsite = '",p_pcarsite,"' ",
               "    AND rtjadocdt = '",p_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY rtjf030,rtjf002 ",
               #"    AND rtjf030 = '",g_detail3[l_ac].pcat002,"' ",
               #"    AND rtjf002 = '",g_detail3[l_ac].pcat003,"' "
               " UNION ",
               " SELECT pcat002,pcat004,COALESCE(SUM(pcat005),0),0,0,0 FROM pcat_t ",
               "  WHERE pcatent = ",g_enterprise," ",
               "    AND pcatsite = '",p_pcarsite,"' ",
               "    AND pcat001 = '",p_pcar001,"' ",
               "    AND pcat002||pcat004 NOT IN (SELECT DISTINCT rtjf030||rtjf002 FROM rtjf_t,rtja_t ",
               "                                  WHERE rtjfent = ",g_enterprise," ",
               "                                    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
               "                                    AND rtjfsite = '",p_pcarsite,"' ",
               "                                    AND rtjadocdt = '",p_pcar001,"' AND rtja032 = '2' ",
               "                                    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD')) ",
               "  GROUP BY pcat002,pcat004 ",
               "  ORDER BY rtjf030,rtjf002 "
   #LET l_sql = " SELECT pcat002,pcat003,COALESCE(SUM(pcat005),0),0,0,0 FROM pcat_t ",
   #            "  WHERE pcatent = ",g_enterprise," ",
   #            "    AND pcatsite = '",g_master.pcarsite,"' ",
   #            "    AND pcat001 = '",g_pcar001,"' ",
   #            "  GROUP BY pcat002,pcat003 "
   PREPARE sel_pcat_pre FROM l_sql
   DECLARE sel_pcat_cs  CURSOR FOR sel_pcat_pre
   LET l_ac = 1
   FOREACH sel_pcat_cs  INTO g_detail3[l_ac].pcat002,g_detail3[l_ac].pcat003,g_detail3[l_ac].pcat005,
                             g_detail3[l_ac].pcat0051,g_detail3[l_ac].pcat0052,g_detail3[l_ac].pcat0053
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #前台金额
      IF g_detail3[l_ac].pcat005 = 0 THEN
         LET l_sql1 = " SELECT COALESCE(SUM(pcat005),0) FROM pcat_t ",
                      "  WHERE pcatent = ",g_enterprise," ",
                      "    AND pcatsite = '",p_pcarsite,"' ",
                      "    AND pcat001 = '",p_pcar001,"' ",
                      "    AND pcat002 = '",g_detail3[l_ac].pcat002,"' ",
                      "    AND pcat004 = '",g_detail3[l_ac].pcat003,"' "
         PREPARE sel_rtjf_pre FROM l_sql1
         EXECUTE sel_rtjf_pre INTO g_detail3[l_ac].pcat005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      END IF
      ##后台金额
      #LET l_sql1 = " SELECT COALESCE(SUM(rtjf031),0) FROM rtjf_t,rtja_t ",
      #             "  WHERE rtjfent = ",g_enterprise," ",
      #             "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
      #             "    AND rtjfsite = '",g_master.pcarsite,"' ",
      #             "    AND rtjadocdt = '",g_pcar001,"' ",
      #             "    AND rtja032 = '2' ",
      #             "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
      #             "    AND rtjf030 = '",g_detail3[l_ac].pcat002,"' ",
      #             "    AND rtjf002 = '",g_detail3[l_ac].pcat003,"' "
      #PREPARE sel_rtjf_pre FROM l_sql1
      #EXECUTE sel_rtjf_pre INTO g_detail3[l_ac].pcat0051
      #IF SQLCA.sqlcode THEN
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "FOREACH:" 
      #   LET g_errparam.code   = SQLCA.sqlcode 
      #   LET g_errparam.popup  = TRUE 
      #   CALL cl_err()
      #   EXIT FOREACH
      #END IF
      
      #日结金额、对账金额
      LET l_sql1 = " SELECT COALESCE(SUM(deaf007),0),COALESCE(SUM(deaf006),0) FROM deaf_t ",
                   "  WHERE deafent = ",g_enterprise," ",
                   "    AND deafsite = '",p_pcarsite,"' ",
                   "    AND deafdocdt = '",p_pcar001,"' ",
                   "    AND deaf004 = '",g_detail3[l_ac].pcat002,"' ",
                   "    AND deaf005 = '",g_detail3[l_ac].pcat003,"' "
      PREPARE sel_deaf_pre FROM l_sql1
      EXECUTE sel_deaf_pre INTO g_detail3[l_ac].pcat0052,g_detail3[l_ac].pcat0053
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #状态
      LET l_str1 = cl_getmsg('apc-00048',g_dlang)    #异常说明
      LET l_str2 = cl_getmsg('apc-00049',g_dlang)    #收银员
      LET l_str3 = cl_getmsg('apc-00050',g_dlang)    #ERP款别
      LET l_str4 = cl_getmsg('apc-00040',g_dlang)    #前台金额
      LET l_str5 = cl_getmsg('apc-00042',g_dlang)    #后台金额
      IF g_detail3[l_ac].pcat005 <> g_detail3[l_ac].pcat0051 THEN
#         IF cl_null(g_pcat_str) THEN
#            LET g_pcat_str = l_str1,"\n","          ",l_str2 USING '##########',l_str3 USING '###############',l_str4 USING '###############',l_str5 USING '###############',"\n",
#                             "          ",g_detail3[l_ac].pcat002 USING '##########',g_detail3[l_ac].pcat003 USING '###############',g_detail3[l_ac].pcat005 USING '###########&.&&',g_detail3[l_ac].pcat0051 USING '###########&.&&',"\n"
#         ELSE
#            LET g_pcat_str = g_pcat_str,"          ",g_detail3[l_ac].pcat002 USING '##########',g_detail3[l_ac].pcat003 USING '###############',g_detail3[l_ac].pcat005 USING '###########&.&&',g_detail3[l_ac].pcat0051 USING '###########&.&&',"\n"
#         END IF
         IF cl_null(g_pcat_str) THEN
            LET g_pcat_str = l_str1,l_str2,g_detail3[l_ac].pcat002,"     ",l_str3,g_detail3[l_ac].pcat003,"     ",l_str4,g_detail3[l_ac].pcat005 USING '------&.&&',l_str5,g_detail3[l_ac].pcat0051 USING '------&.&&',"\n"
         ELSE
            LET g_pcat_str = g_pcat_str,l_str1,l_str2,g_detail3[l_ac].pcat002,"     ",l_str3,g_detail3[l_ac].pcat003,"     ",l_str4,g_detail3[l_ac].pcat005 USING '------&.&&',l_str5,g_detail3[l_ac].pcat0051 USING '------&.&&',"\n"
         END IF
         LET g_detail3[l_ac].pcatstus = '1'
         LET g_flag = 'Y'
      ELSE
         LET g_detail3[l_ac].pcatstus = '0'
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   
#   #延误上传款别统计
#   LET l_sql = " SELECT rtjacrtdt,rtjf030,rtjf002,COALESCE(SUM(rtjf031),0) ",
#               "   FROM rtjf_t,rtja_t ",
#               "  WHERE rtjfent = ",g_enterprise," ",
#               "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
#               "    AND rtjfsite = '",g_master.pcarsite,"' ",
#               "    AND rtjadocdt = '",g_pcar001,"' ",
#               "    AND rtja032 = '2' ",
#               "    AND to_char(rtjadocdt,'YYYYMMDD')>to_char(rtjacrtdt,'YYYYMMDD') ",
#               "  GROUP BY rtjacrtdt,rtjf030,rtjf002 ",
#               "  ORDER BY rtjacrtdt,rtjf030,rtjf002 "
#   PREPARE sel_rtjf_pre1 FROM l_sql
#   DECLARE sel_rtjf_cs1  CURSOR FOR sel_rtjf_pre1
#   LET l_ac = 1
#   FOREACH sel_rtjf_cs1  INTO g_detail4[l_ac].pcat001,g_detail4[l_ac].pcat002,g_detail4[l_ac].pcat004,g_detail4[l_ac].pcat005
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#      
#      LET l_ac = l_ac + 1
#   END FOREACH
#   
#   #延误上传款别明细
#   LET l_sql = " SELECT rtjadocdt,rtjacrtdt,rtjf030,rtjf002,COALESCE(SUM(rtjf031),0),rtja033,rtja034,rtja035,rtjapstdt,rtjf036 ",
#               "   FROM rtjf_t,rtja_t ",
#               "  WHERE rtjfent = ",g_enterprise," ",
#               "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
#               "    AND rtjfsite = '",g_master.pcarsite,"' ",
#               "    AND rtjadocdt = '",g_pcar001,"' ",
#               "    AND rtja032 = '2' ",
#               "    AND to_char(rtjadocdt,'YYYYMMDD')>to_char(rtjacrtdt,'YYYYMMDD') ",
#               "  GROUP BY rtjadocdt,rtjacrtdt,rtjf030,rtjf002,rtja033,rtja034,rtja035,rtjapstdt,rtjf036 ",
#               "  ORDER BY rtjadocdt,rtjacrtdt,rtjf030,rtjf002 "
#   PREPARE sel_rtjf_pre2 FROM l_sql
#   DECLARE sel_rtjf_cs2  CURSOR FOR sel_rtjf_pre2
#   LET l_ac = 1
#   FOREACH sel_rtjf_cs2  INTO g_detail5[l_ac].rtjadocdt,g_detail5[l_ac].pcat001,g_detail5[l_ac].pcat002,
#                              g_detail5[l_ac].pcat003,g_detail5[l_ac].pcat005,g_detail5[l_ac].rtja033,
#                              g_detail5[l_ac].rtja034,g_detail5[l_ac].rtja035,g_detail5[l_ac].rtjapstdt,
#                              g_detail5[l_ac].rtjf036
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#      
#      LET l_ac = l_ac + 1
#   END FOREACH
 
   #add-point:陣列長度調整
   CALL g_detail.deleteElement(g_detail.getLength())
   CALL g_detail2.deleteElement(g_detail2.getLength())
   CALL g_detail3.deleteElement(g_detail3.getLength())
   CALL g_detail4.deleteElement(g_detail4.getLength())
   CALL g_detail5.deleteElement(g_detail5.getLength())
   CALL g_detail6.deleteElement(g_detail5.getLength())
   
   #單頭狀態
   IF g_flag = 'Y' THEN
      LET g_pcarstus = '1'
   ELSE
      LET g_pcarstus = '0'
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 狀態異常時寄出mail
# Memo...........:
# Usage..........: CALL apcp100_send_mail(ls_text,p_receiver)
# Date & Author..: 20150807 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION apcp100_send_mail(ls_text,p_receiver)
DEFINE p_receiver   LIKE type_t.chr500
DEFINE ls_text      STRING
DEFINE ls_tmp       STRING
DEFINE li_result    LIKE type_t.num5
DEFINE ls_file      STRING
DEFINE lc_channel   base.Channel
DEFINE ls_path      STRING
DEFINE l_subject    STRING

   IF cl_null(ls_text) THEN
      RETURN
   END IF

   #信件暫存檔案路徑
   LET ls_file = "apcp100-mail_",FGL_GETPID() USING "<<<<<",".txt"
   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file)

   IF os.Path.exists(ls_file) THEN
      IF os.Path.delete(ls_file) THEN END IF
   END IF

   #信件檔案
   LET lc_channel = base.Channel.create()
   CALL lc_channel.openFile(ls_file CLIPPED, "w" )
   CALL lc_channel.setDelimiter("")
   #信件內容
   #LET l_site = cl_getmsg('apc-00037',g_dlang)
   #LET l_date = cl_getmsg('apc-00038',g_dlang)
   #LET l_amt_f = cl_getmsg('apc-00039',g_dlang)
   #LET l_amt_b = cl_getmsg('apc-00041',g_dlang)
   #LET l_sum_f = cl_getmsg('apc-00040',g_dlang)
   #LET l_sum_b = cl_getmsg('apc-00042',g_dlang)
   #LET ls_text = l_site,g_pcarsite,"          ",l_date,g_pcar001,"\n",l_amt_f,g_amt_f,"          ",l_amt_b,g_amt_b,"\n",l_sum_f,g_sum_f,"          ",l_sum_b,g_sum_b,"\n"
   CALL lc_channel.write(ls_text)
   CALL lc_channel.close()

   #信件主旨
   LET l_subject = cl_getmsg('apc-00036',g_dlang)
   LET g_xml.subject = l_subject
   #信件本文
   LET g_xml.body = ls_file
   #DISPLAY "g_xml.body:",g_xml.body
   #寄信人
  #LET g_xml.sender = "t100.digiwin@yahoo.com.tw"  #必須要寫@後面的mail address
   #收件者
   LET g_xml.recipient = p_receiver

   #寄發mail
   #CALL cl_msgcentre() RETURNING ls_tmp
   CALL cl_send_mail(g_xml.recipient,g_xml.subject,ls_text)
   #IF ls_tmp.getIndexOf("successfully",1) THEN
   #   CALL cl_ask_anykey()
   #ELSE
   #   CALL cl_ask_end2(2) RETURNING li_result
   #END IF

END FUNCTION

#end add-point
 
{</section>}
 
