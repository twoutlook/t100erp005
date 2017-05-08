#該程式未解開Section, 採用最新樣板產出!
{<section id="astp403.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-09-14 09:58:38), PR版次:0004(2016-09-13 18:03:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: astp403
#+ Description: 專櫃合約開帳歷史費用設定批次作業
#+ Creator....: 06254(2015-09-15 15:32:55)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="astp403.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160905-00007#16   2016/09/05  By 02599       SQL条件增加ent
#160913-00034#1    2016/09/13 by 08172   q_pmaa001開窗替换
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
       stfasite LIKE type_t.chr10, 
   stfa005 LIKE type_t.chr20, 
   stfa010 LIKE type_t.chr10, 
   l_date LIKE type_t.chr500, 
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
 
{<section id="astp403.main" >}
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
      CALL astp403_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp403 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp403_init()
 
      #進入選單 Menu (="N")
      CALL astp403_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp403
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp403.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp403_init()
 
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
 
{<section id="astp403.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp403_ui_dialog()
 
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
   LET g_master.l_date=g_today
   DISPLAY g_master.l_date TO l_date
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_date 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
              
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_date
            #add-point:BEFORE FIELD l_date name="input.b.l_date"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_date
            
            #add-point:AFTER FIELD l_date name="input.a.l_date"
            IF g_master.l_date>g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00380'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                                
                  NEXT FIELD l_date
             END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_date
            #add-point:ON CHANGE l_date name="input.g.l_date"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_date
            #add-point:ON ACTION controlp INFIELD l_date name="input.c.l_date"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stfasite,stfa005,stfa010
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               DISPLAY g_site TO stfasite
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfasite
            #add-point:ON ACTION controlp INFIELD stfasite name="construct.c.stfasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfasite  #顯示到畫面上
            NEXT FIELD stfasite   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfasite
            #add-point:BEFORE FIELD stfasite name="construct.b.stfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfasite
            
            #add-point:AFTER FIELD stfasite name="construct.a.stfasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa005
            #add-point:ON ACTION controlp INFIELD stfa005 name="construct.c.stfa005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa005  #顯示到畫面上
            NEXT FIELD stfa005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfa005
            #add-point:BEFORE FIELD stfa005 name="construct.b.stfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfa005
            
            #add-point:AFTER FIELD stfa005 name="construct.a.stfa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stfa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa010
            #add-point:ON ACTION controlp INFIELD stfa010 name="construct.c.stfa010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#1 -s by 08172
            LET g_qryparam.arg1 = "('3')"
            CALL q_pmaa001_1()
#            CALL q_pmaa001()                           #呼叫開窗
            #160913-00034#1 -e by 08172
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfa010
            #add-point:BEFORE FIELD stfa010 name="construct.b.stfa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfa010
            
            #add-point:AFTER FIELD stfa010 name="construct.a.stfa010"
            
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
            CALL astp403_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_today TO l_date
           
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
         CALL astp403_init()
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
                 CALL astp403_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp403_transfer_argv(ls_js)
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
 
{<section id="astp403.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp403_transfer_argv(ls_js)
 
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
 
{<section id="astp403.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp403_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_success    LIKE type_t.num5
   DEFINE l_msg         STRING           #160225-00040#17 20160328 add by beckxie
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #160225-00040#17 20160328 add by beckxie---S
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_bar_no_window(2)   
   END IF
   #160225-00040#17 20160328 add by beckxie---E 
   #開啟事務
   CALL s_transaction_begin()
   
   #160225-00040#17 20160328 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#17 20160328 add by beckxie---E
   CALL astp403_update(g_master.wc,g_master.l_date) RETURNING ls_success
   
   IF ls_success THEN 
       CALL s_transaction_end('Y','0')
   ELSE
       CALL s_transaction_end('N','0')
   END IF 
   #160225-00040#17 20160328 add by beckxie---S
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#17 20160328 add by beckxie---E
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp403_process_cs CURSOR FROM ls_sql
#  FOREACH astp403_process_cs INTO
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
   CALL astp403_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp403.get_buffer" >}
PRIVATE FUNCTION astp403_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_date = p_dialog.getFieldBuffer('l_date')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp403.msgcentre_notify" >}
PRIVATE FUNCTION astp403_msgcentre_notify()
 
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
 
{<section id="astp403.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astp403_update(p_wc,p_date)
#                  RETURNING r_success
# Input parameter: p_wc           QBE条件
#                : p_date         执行日期
# Return code....: r_success      成功否
# Date & Author..: 2015/9/18 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION astp403_update(p_wc,p_date)
DEFINE p_wc          STRING
DEFINE p_date        DATE
DEFINE l_sql         STRING
DEFINE l_sql2        STRING
DEFINE l_sql3        STRING
DEFINE l_sql4        STRING
DEFINE l_sql5        STRING
DEFINE l_sql6        STRING
DEFINE l_sql7        STRING
DEFINE l_sql8        STRING
DEFINE l_sql9        STRING
DEFINE l_sql10       STRING
DEFINE l_sql11       STRING
DEFINE l_sql12       STRING
DEFINE l_sql13       STRING
DEFINE l_sql14       STRING
DEFINE l_sql15       STRING
DEFINE l_sql16       STRING
DEFINE l_sql17       STRING
DEFINE l_sql18       STRING
DEFINE l_sql19       STRING
DEFINE l_sql20       STRING
DEFINE l_sql21       STRING
DEFINE l_sql22       STRING
DEFINE l_sql23       STRING
DEFINE l_sql24       STRING
DEFINE l_sql25       STRING
DEFINE l_sql26       STRING
DEFINE l_sql27       STRING
DEFINE l_sql28       STRING
DEFINE l_sql29       STRING
DEFINE r_success     LIKE type_t.num5
DEFINE l_i           LIKE type_t.num5

       LET r_success=TRUE
       
       
       #更新结算账期
       LET l_sql="UPDATE stfj_t SET stfj005='Y'",
                 " WHERE stfj004 < to_date ('",p_date,"','yy/mm/dd') ",
                 "   AND stfjent =",g_enterprise, #160905-00007#16 add
                 "   AND stfj005 = 'N' ",
                 "   AND stfjsite='",g_site,"'",
                 "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001=stfj001 AND ",p_wc CLIPPED,
                 "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                 
                 
       PREPARE astp403_upd_stfj FROM l_sql
       EXECUTE astp403_upd_stfj
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "upd stfb_t:stfb011" 
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET r_success=FALSE
          RETURN
       END IF

       #更新费用明细的下次计算日，下次费用开始日，下次费用截止日
       #----1.按年、期初、按自然月计费计算
       FOR l_i=1 to 10000
           IF l_i=1 THEN
              LET l_sql2="UPDATE stfb_t SET stfb015 = add_months(stfb013,0),",
                         "                  stfb016 = add_months(stfb013,0),",
                         "                  stfb017 = add_months(trunc(stfb013,'yyyy'),12)-1",
                         " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '1' ",
                         "   AND stfb007 = '1' ",
                         "   AND stfb020 = 'Y' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb FROM l_sql2
               EXECUTE astp403_upd_stfb
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t:stfb011" 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql3="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,0),",
                        "                  stfb016 = add_months(stfb017+1,0),",
                        "                  stfb017 = add_months(trunc(stfb017+1,'yyyy'),12)-1",
                        " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                        "   AND stfbent =",g_enterprise, #160905-00007#16 add
                        "   AND stfb006 = '1' ",
                        "   AND stfb007 = '1' ",
                        "   AND stfb020 = 'Y' ",
                        "   AND stfbsite='",g_site,"'",
                        "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                        "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb02 FROM l_sql3
             EXECUTE astp403_upd_stfb02           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF           
       END FOR
       
       #----2.按年、期初、按非自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql4="UPDATE stfb_t SET stfb015 = add_months(stfb013,0),",
                         "                  stfb016 = add_months(stfb013,0),",
                         "                  stfb017 = add_months(stfb013,12)-1",
                         " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '1' ",
                         "   AND stfb007 = '1' ",
                         "   AND stfb020 = 'N' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb03 FROM l_sql4
               EXECUTE astp403_upd_stfb03
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql5="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,0),",
                        "                  stfb016 = add_months(stfb017+1,0),",
                        "                  stfb017 = add_months(stfb017+1,12)-1",
                        " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                        "   AND stfbent =",g_enterprise, #160905-00007#16 add
                        "   AND stfb006 = '1' ",
                        "   AND stfb007 = '1' ",
                        "   AND stfb020 = 'N' ",
                        "   AND stfbsite='",g_site,"'",
                        "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                        "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb04 FROM l_sql5
             EXECUTE astp403_upd_stfb04           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----3.按年、期末、按自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql6="UPDATE stfb_t SET stfb015 = add_months(trunc(stfb013,'yyyy'),12)-1,",
                         "                  stfb016 = add_months(stfb013,0),",
                         "                  stfb017 = add_months(trunc(stfb013,'yyyy'),12)-1",
                         " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '1' ",
                         "   AND stfb007 = '2' ",
                         "   AND stfb020 = 'Y' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb05 FROM l_sql6
               EXECUTE astp403_upd_stfb05
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql7="UPDATE stfb_t SET stfb015 = add_months(trunc(stfb017+1,'yyyy'),12)-1,",
                        "                  stfb016 = add_months(stfb017+1,0),",
                        "                  stfb017 = add_months(trunc(stfb017+1,'yyyy'),12)-1",
                        " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                        "   AND stfbent =",g_enterprise, #160905-00007#16 add
                        "   AND stfb006 = '1' ",
                        "   AND stfb007 = '2' ",
                        "   AND stfb020 = 'Y' ",
                        "   AND stfbsite='",g_site,"'",
                        "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                        "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb06 FROM l_sql7
             EXECUTE astp403_upd_stfb06           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----4.按年、期末、按非自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql8="UPDATE stfb_t SET stfb015 = add_months(stfb013,12)-1,",
                         "                  stfb016 = add_months(stfb013,0),",
                         "                  stfb017 = add_months(stfb013,12)-1",
                         " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '1' ",
                         "   AND stfb007 = '2' ",
                         "   AND stfb020 = 'N' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb07 FROM l_sql8
               EXECUTE astp403_upd_stfb07
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql9="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,12)-1,",
                        "                  stfb016 = add_months(stfb017+1,0),",
                        "                  stfb017 = add_months(stfb017+1,12)-1",
                        " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                        "   AND stfbent =",g_enterprise, #160905-00007#16 add
                        "   AND stfb006 = '1' ",
                        "   AND stfb007 = '2' ",
                        "   AND stfb020 = 'N' ",
                        "   AND stfbsite='",g_site,"'",
                        "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                        "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb08 FROM l_sql9
             EXECUTE astp403_upd_stfb08           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----5.按季度、期初、按自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql10="UPDATE stfb_t SET stfb015 = add_months(stfb013,0),",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(trunc(stfb013,'Q'),3)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '2' ",
                          "   AND stfb007 = '1' ",
                          "   AND stfb020 = 'Y' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb09 FROM l_sql10
               EXECUTE astp403_upd_stfb09
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql11="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,0),",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(trunc(stfb017+1,'Q'),3)-1",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '2' ",
                         "   AND stfb007 = '1' ",
                         "   AND stfb020 = 'Y' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb10 FROM l_sql11
             EXECUTE astp403_upd_stfb10           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----6.按季度、期初、按非自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql12="UPDATE stfb_t SET stfb015 = add_months(stfb013,0),",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(stfb013,3)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '2' ",
                          "   AND stfb007 = '1' ",
                          "   AND stfb020 = 'N' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb11 FROM l_sql12
               EXECUTE astp403_upd_stfb11
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql13="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,0),",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(stfb017+1,3)-1",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '2' ",
                         "   AND stfb007 = '1' ",
                         "   AND stfb020 = 'N' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb12 FROM l_sql13
             EXECUTE astp403_upd_stfb12           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----7.按季度、期末、按自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql14="UPDATE stfb_t SET stfb015 = add_months(trunc(stfb013,'Q'),3)-1,",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(trunc(stfb013,'Q'),3)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '2' ",
                          "   AND stfb007 = '2' ",
                          "   AND stfb020 = 'Y' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb13 FROM l_sql14
               EXECUTE astp403_upd_stfb13
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql15="UPDATE stfb_t SET stfb015 = add_months(trunc(stfb017+1,'Q'),3)-1,",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(trunc(stfb017+1,'Q'),3)-1 ",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '2' ",
                         "   AND stfb007 = '2' ",
                         "   AND stfb020 = 'Y' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb14 FROM l_sql15
             EXECUTE astp403_upd_stfb14           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----8.按季度、期末、非自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql16="UPDATE stfb_t SET stfb015 = add_months(stfb013,3)-1,",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(stfb013,3)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '2' ",
                          "   AND stfb007 = '2' ",
                          "   AND stfb020 = 'N' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb15 FROM l_sql16
               EXECUTE astp403_upd_stfb15
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql17="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,3)-1,",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(stfb017+1,3)-1 ",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '2' ",
                         "   AND stfb007 = '2' ",
                         "   AND stfb020 = 'N' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb16 FROM l_sql17
             EXECUTE astp403_upd_stfb16           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----9.按月、期初、自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql18="UPDATE stfb_t SET stfb015 = add_months(stfb013,0),",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(trunc(stfb013,'mm'),1)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '3' ",
                          "   AND stfb007 = '1' ",
                          "   AND stfb020 = 'Y' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb17 FROM l_sql18
               EXECUTE astp403_upd_stfb17
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql19="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,0),",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(trunc(stfb017+1,'mm'),1)-1 ",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '3' ",
                         "   AND stfb007 = '1' ",
                         "   AND stfb020 = 'Y' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb18 FROM l_sql19
             EXECUTE astp403_upd_stfb18           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       #----10.按月、期初、非自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql20="UPDATE stfb_t SET stfb015 = add_months(stfb013,0),",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(stfb013,1)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '3' ",
                          "   AND stfb007 = '1' ",
                          "   AND stfb020 = 'N' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb19 FROM l_sql20
               EXECUTE astp403_upd_stfb19
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql21="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,0),",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(stfb017+1,1)-1 ",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '3' ",
                         "   AND stfb007 = '1' ",
                         "   AND stfb020 = 'N' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb20 FROM l_sql21
             EXECUTE astp403_upd_stfb20           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       
       #----11.按月、期末、自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql22="UPDATE stfb_t SET stfb015 = add_months(trunc(stfb013,'mm'),1)-1,",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(trunc(stfb013,'mm'),1)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '3' ",
                          "   AND stfb007 = '2' ",
                          "   AND stfb020 = 'Y' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb21 FROM l_sql22
               EXECUTE astp403_upd_stfb21
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql23="UPDATE stfb_t SET stfb015 = add_months(trunc(stfb017+1,'mm'),1)-1,",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(trunc(stfb017+1,'mm'),1)-1 ",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '3' ",
                         "   AND stfb007 = '2' ",
                         "   AND stfb020 = 'Y' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb22 FROM l_sql23
             EXECUTE astp403_upd_stfb22           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR 
             END IF 
           END IF
       END FOR
       
       
       #----12.按月、期末、非自然月计费计算
       FOR l_i=1 TO 10000
           IF l_i=1 THEN
              LET l_sql24="UPDATE stfb_t SET stfb015 = add_months(stfb013,1)-1,",
                          "                  stfb016 = add_months(stfb013,0),",
                          "                  stfb017 = add_months(stfb013,1)-1",
                          " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd') ",
                          "   AND stfbent =",g_enterprise, #160905-00007#16 add
                          "   AND stfb006 = '3' ",
                          "   AND stfb007 = '2' ",
                          "   AND stfb020 = 'N' ",
                          "   AND stfbsite='",g_site,"'",
                          "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                          "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
                         
               PREPARE astp403_upd_stfb23 FROM l_sql24
               EXECUTE astp403_upd_stfb23
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "upd stfb_t " 
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success=FALSE
                  RETURN
              END IF
           ELSE
             LET l_sql25="UPDATE stfb_t SET stfb015 = add_months(stfb017+1,1)-1,",
                         "                  stfb016 = add_months(stfb017+1,0),",
                         "                  stfb017 = add_months(stfb017+1,1)-1 ",
                         " WHERE stfb015 < to_date('",p_date,"','yy/mm/dd') ",
                         "   AND stfbent =",g_enterprise, #160905-00007#16 add
                         "   AND stfb006 = '3' ",
                         "   AND stfb007 = '2' ",
                         "   AND stfb020 = 'N' ",
                         "   AND stfbsite='",g_site,"'",
                         "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                         "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
             PREPARE astp403_upd_stfb24 FROM l_sql25
             EXECUTE astp403_upd_stfb24           
             IF SQLCA.sqlerrd[3]=0 THEN
                EXIT FOR               
             END IF 
           END IF
       END FOR
       
       #----13.按单次、期末计算
       LET l_sql26="UPDATE stfb_t SET stfb015=NULL,stfb016=NULL,stfb017=NULL ",
                   " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd')",
                   "   AND stfbent =",g_enterprise, #160905-00007#16 add
                   "   AND stfb006 = '4' ",
                   "   AND stfb004 = '2' ",
                   "   AND stfbsite='",g_site,"'",
                   "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                   "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
       
       PREPARE astp403_upd_stfb25 FROM l_sql26
       EXECUTE astp403_upd_stfb25
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "upd stfb_t " 
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET r_success=FALSE
          RETURN
       END IF
       #----14.按单次、期初计算
       LET l_sql27="UPDATE stfb_t SET stfb015=NULL,stfb016=NULL,stfb017=NULL ",
                   " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd')",
                   "   AND stfbent =",g_enterprise, #160905-00007#16 add
                   "   AND stfb006 = '4' ",
                   "   AND stfb004 = '1' ",
                   "   AND stfbsite='",g_site,"'",
                   "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                   "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
       
       PREPARE astp403_upd_stfb26 FROM l_sql27
       EXECUTE astp403_upd_stfb26
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "upd stfb_t " 
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET r_success=FALSE
          RETURN
       END IF
       
       #----15.按结算单、期初计算
       LET l_sql28="UPDATE stfb_t SET stfb015 = (SELECT MIN(stfj002) FROM stfj_t WHERE stfj001=stfb001 AND stfj005='N' AND stfjent=",g_enterprise,"),", #160905-00007#16 add stfjent
                   "                  stfb016 = (SELECT MIN(stfj002) FROM stfj_t WHERE stfj001=stfb001 AND stfj005='N' AND stfjent=",g_enterprise,"),", #160905-00007#16 add stfjent
                   "                  stfb017 = (SELECT MIN(stfj003) FROM STFJ_T WHERE stfj001=stfb001 AND stfj005='N' AND stfjent=",g_enterprise,")",  #160905-00007#16 add stfjent
                   " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd')",
                   "   AND stfbent =",g_enterprise, #160905-00007#16 add
                   "   AND stfb006 = '5' ",
                   "   AND stfb004 = '1' ",
                   "   AND stfbsite='",g_site,"'",
                   "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                   "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
       
       PREPARE astp403_upd_stfb27 FROM l_sql28
       EXECUTE astp403_upd_stfb27
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "upd stfb_t " 
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET r_success=FALSE
          RETURN
       END IF
       
       #----16.按结算单、期末计算
       LET l_sql29="UPDATE stfb_t SET stfb015 = (SELECT MIN(stfj004) FROM stfj_t WHERE stfj001=stfb001 AND stfj005='N' AND stfjent=",g_enterprise,"),", #160905-00007#16 add stfjent
                   "                  stfb016 = (SELECT MIN(stfj002) FROM stfj_t WHERE stfj001=stfb001 AND stfj005='N' AND stfjent=",g_enterprise,"),", #160905-00007#16 add stfjent
                   "                  stfb017 = (SELECT MIN(stfj003) FROM STFJ_T WHERE stfj001=stfb001 AND stfj005='N' AND stfjent=",g_enterprise,")",  #160905-00007#16 add stfjent
                   " WHERE stfb013 < to_date('",p_date,"','yy/mm/dd')",
                   "   AND stfbent =",g_enterprise, #160905-00007#16 add
                   "   AND stfb006 = '5' ",
                   "   AND stfb004 = '2' ",
                   "   AND stfbsite='",g_site,"'",
                   "   AND EXISTS (SELECT 1 FROM stfa_t WHERE stfa001 = stfb001 AND ",p_wc CLIPPED,
                   "               AND stfaent=",g_enterprise,")" #160905-00007#16 add
       
       PREPARE astp403_upd_stfb28 FROM l_sql29
       EXECUTE astp403_upd_stfb28
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "upd stfb_t " 
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET r_success=FALSE
          RETURN
       END IF
       
       RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
