#該程式已解開Section, 不再透過樣板產出!
{<section id="astp802.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000004
#+ 
#+ Filename...: astp802
#+ Description: 
#+ Creator....: 07142(2016-05-27 16:40:22)
#+ Modifier...: 07142(2016-05-30 10:49:51) -SD/PR- 06189
 
{</section>}
 
{<section id="astp802.global" >}
#應用 p01 樣板自動產生(Version:14)
#add-point:填寫註解說明
#add by geza 20161026 #161024-00025#10 aooi500规范
#end add-point 
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目

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
   #add-point:自定背景執行須傳遞的參數(Module Variable)

   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
   stjm004 LIKE stjm_t.stjm004, 
   md LIKE type_t.chr500, 
   sd LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_stjedocno  LIKE stie_t.stiedocno

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="astp802.main" >}
MAIN
   #add-point:main段define (客製用)
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define 
   DEFINE l_success LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call
      
      #end add-point
      CALL astp802_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp802 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp802_init()
 
      #進入選單 Menu (="N")
      CALL astp802_ui_dialog()
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp802
   END IF
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp802.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp802_init()
 
   #add-point:init段define (客製用)
   
   #end add-point
   #add-point:ui_dialog段define 
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
   #add-point:畫面資料初始化
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp802.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp802_ui_dialog()
 
   #add-point:ui_dialog段define (客製用)

   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define 
   define l_n   int 
   #end add-point
   
   #add-point:ui_dialog段before dialog

   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2
      let g_master.md='Y'
      let g_master.sd='Y'
      #let g_master.stjesite=g_site
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
        CONSTRUCT BY NAME g_wc ON stjesite,stje001
        BEFORE CONSTRUCT
        ON ACTION controlp INFIELD stjesite
            #add-point:ON ACTION controlp INFIELD stjesite name="input.c.stjesite"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stjesite 
            NEXT FIELD stjesite
         ON ACTION controlp INFIELD stje001
            #add-point:ON ACTION controlp INFIELD stje001 name="input.c.stje001"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stje001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stje001
            NEXT FIELD stje001
         end construct         
         
         INPUT BY NAME g_master.stjm004,g_master.md,g_master.sd 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"

 

 

 

 

 
                
                  
 

 

 
             
 

 

 
     
 

 
         BEFORE FIELD stjm004
            #add-point:BEFORE FIELD stjm004 name="input.b.stjm004"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stjm004
            
            #add-point:AFTER FIELD stjm004 name="input.a.stjm004"
#            IF g_master.stjm004 IS NOT NULL THEN
#               IF g_master.stjm004 > g_today THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.extend = g_master.stjm004
#                  LET g_errparam.code   = 'amm-00207'
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stjm004
            #add-point:ON CHANGE stjm004 name="input.g.stjm004"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD md
            #add-point:BEFORE FIELD md name="input.b.md"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD md
            
            #add-point:AFTER FIELD md name="input.a.md"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE md
            #add-point:ON CHANGE md name="input.g.md"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sd
            #add-point:BEFORE FIELD sd name="input.b.sd"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sd
            
            #add-point:AFTER FIELD sd name="input.a.sd"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sd
            #add-point:ON CHANGE sd name="input.g.sd"

            #END add-point 
 
 
 
                     #Ctrlp:input.c.stjesite
         #應用 a03 樣板自動產生(Version:3)
            #add-point:ON ACTION controlp INFIELD stjesite name="input.c.stjesite"
 
            #END add-point
 
 
         #Ctrlp:input.c.stje008
         #應用 a03 樣板自動產生(Version:3)
            #add-point:ON ACTION controlp INFIELD stje008 name="input.c.stje008"
 
            #END add-point
 
 
         #Ctrlp:input.c.stje007
         #應用 a03 樣板自動產生(Version:3)
            #add-point:ON ACTION controlp INFIELD stje007 name="input.c.stje007"
 
            #END add-point
 
 
         #Ctrlp:input.c.stje001
         #應用 a03 樣板自動產生(Version:3)
            #add-point:ON ACTION controlp INFIELD stje001 name="input.c.stje001"
 
            #END add-point
 
 
         #Ctrlp:input.c.stjm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stjm004
            #add-point:ON ACTION controlp INFIELD stjm004 name="input.c.stjm004"

            #END add-point
 
 
         #Ctrlp:input.c.md
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD md
            #add-point:ON ACTION controlp INFIELD md name="input.c.md"

            #END add-point
 
 
         #Ctrlp:input.c.sd
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sd
            #add-point:ON ACTION controlp INFIELD sd name="input.c.sd"

            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
            IF g_master.md='N' AND g_master.sd='N' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ""
                 LET g_errparam.code = 'ast-00796'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 next field md
             END IF 
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"

            #end add-point
         END INPUT
 
 
 
         
         
      
         #add-point:ui_dialog段construct

         #end add-point
         #add-point:ui_dialog段input

         #end add-point
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL astp802_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            LET g_master.stjm004 = g_today-1
            DISPLAY g_site TO stjesite
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear

         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear

            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action

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
         CALL astp802_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog

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
                 CALL astp802_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp802_transfer_argv(ls_js)
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
 
         #add-point:ui_dialog段after schedule

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
 
{<section id="astp802.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp802_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用)
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define 
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="astp802.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp802_process(ls_js)
 
   #add-point:process段define (客製用)

   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define 
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_where       STRING
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理

   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress

      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp802_process_cs CURSOR FROM ls_sql
#  FOREACH astp802_process_cs INTO
   #add-point:process段process
   #CALL cl_err_collect_init()
   CALL s_transaction_begin()
   #add by geza 20161026 #161024-00025#10(S)
   CALL s_aooi500_sql_where(g_prog,'stjesite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   #add by geza 20161026 #161024-00025#10(E)
   if g_master.md='Y' then 
      call astp802_ht()
   end if 
   if g_master.sd='Y' then 
      call astp802_sq()
   end if 
   CALL s_transaction_end('Y','1')
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理

       let g_master.stjm004=g_today-1
      #end add-point
     # CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理

      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL astp802_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp802.get_buffer" >}
PRIVATE FUNCTION astp802_get_buffer(p_dialog)
 
   #add-point:process段define (客製用)

   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define

   #end add-point
 
   
   #LET g_master.stjesite = p_dialog.getFieldBuffer('stjesite')
   #LET g_master.stje008 = p_dialog.getFieldBuffer('stje008')
   #LET g_master.stje007 = p_dialog.getFieldBuffer('stje007')
   #LET g_master.stje001 = p_dialog.getFieldBuffer('stje001')
   LET g_master.stjm004 = p_dialog.getFieldBuffer('stjm004')
   LET g_master.md = p_dialog.getFieldBuffer('md')
   LET g_master.sd = p_dialog.getFieldBuffer('sd')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理

   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp802.msgcentre_notify" >}
PRIVATE FUNCTION astp802_msgcentre_notify()
 
   #add-point:process段define (客製用)
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp802.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astp802_ht()
   DEFINE l_sql  STRING
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_stje001 LIKE stje_t.stje001
   DEFINE l_stjoseq LIKE stjo_t.stjoseq
   DEFINE l_stjo004 LIKE stjo_t.stjo004
   DEFINE l_stjmseq LIKE stjm_t.stjmseq
   DEFINE l_stjm004 LIKE stjm_t.stjm004
   #LET l_cnt=0
   #LET l_sql="SELECT count(*) FROM stje_t WHERE stjeent='",g_enterprise,"' AND ",g_wc
   #PREPARE b_fill_cnt_pre FROM l_sql
   #EXECUTE b_fill_cnt_pre INTO l_cnt
   LET l_sql = " SELECT stje001",
               "   FROM stje_t ",
               "  WHERE stjeent = '",g_enterprise,"' AND ",g_wc
   PREPARE s_astp802_stje_pre FROM l_sql
   DECLARE s_astp802_stje_cs CURSOR FOR s_astp802_stje_pre
   LET l_sql = " SELECT stjoseq,stjo004",
               "   FROM stjo_t ",
               "  WHERE stjoent = '",g_enterprise,"'",
               "    AND stjo001=? ",
               "  ORDER BY stjoseq"
   PREPARE s_astp802_stjo_pre FROM l_sql
   DECLARE s_astp802_stjo_cs CURSOR FOR s_astp802_stjo_pre
   LET l_sql = " SELECT stjmseq,stjm006",
               "   FROM stjm_t ",
               "  WHERE stjment = '",g_enterprise,"'",
               "    AND stjm001=? ",
               "  ORDER BY stjmseq"
   PREPARE s_astp802_stjm_pre FROM l_sql
   DECLARE s_astp802_stjm_cs CURSOR FOR s_astp802_stjm_pre
   #DISPLAY '' ,0 TO stagenow,stagecomplete
   #CALL cl_progress_bar_no_window(l_cnt)
   FOREACH s_astp802_stje_cs INTO l_stje001
   #CALL cl_progress_no_window_ing(l_stje001)
      FOREACH s_astp802_stjo_cs USING l_stje001 INTO l_stjoseq,l_stjo004
         IF l_stjo004<g_master.stjm004 THEN 
            UPDATE stjo_t SET stjo005='Y' 
            WHERE stjoent = g_enterprise AND stjo001=l_stje001 AND stjoseq=l_stjoseq 
         ELSE 
       
         END IF
      END FOREACH
      FOREACH s_astp802_stjm_cs USING l_stje001 INTO l_stjmseq,l_stjm004
         IF l_stjm004<g_master.stjm004 THEN 
            UPDATE stjm_t SET stjm015='Y' 
            WHERE stjment = g_enterprise AND stjm001=l_stje001 AND stjmseq=l_stjmseq 
         ELSE 
       
         END IF
      END FOREACH
   END FOREACH      
      

   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astp802_sq()
   DEFINE l_sql  STRING
   DEFINE l_cnt  LIKE type_t.num5
   define l_stje001 like stje_t.stje001   
   DEFINE l_stioseq LIKE stio_t.stioseq
   DEFINE l_stio004 LIKE stio_t.stio004
   DEFINE l_stimseq LIKE stim_t.stimseq
   DEFINE l_stim004 LIKE stim_t.stim004
   #LET l_cnt=0
   #LET l_sql="SELECT count(*) INTO l_cnt FROM stje_t WHERE stjeent=? AND ",g_wc
   #PREPARE b_fill_cnt_pre1 FROM l_sql
   #EXECUTE b_fill_cnt_pre1 USING g_enterprise INTO l_cnt
   LET l_sql = " SELECT stje001",
               "   FROM stje_t ",
               "  WHERE stjeent = '",g_enterprise,"' AND ",g_wc
   PREPARE s_astp802_stie_pre FROM l_sql
   DECLARE s_astp802_stie_cs CURSOR FOR s_astp802_stie_pre
   LET l_sql = " SELECT stioseq,stio004",
               "   FROM stio_t ",
               "  WHERE stioent = '",g_enterprise,"'",
               "    AND stio001=? ",
               "    AND stiodocno=? ",
               "  ORDER BY stioseq"
   PREPARE s_astp802_stio_pre FROM l_sql
   DECLARE s_astp802_stio_cs CURSOR FOR s_astp802_stio_pre
   LET l_sql = " SELECT stimseq,stim006",
               "   FROM stim_t ",
               "  WHERE stiment = '",g_enterprise,"'",
               "    AND stim001=? ",
               "    AND stimdocno=? ",
               "  ORDER BY stimseq"
   PREPARE s_astp802_stim_pre FROM l_sql
   DECLARE s_astp802_stim_cs CURSOR FOR s_astp802_stim_pre
   #DISPLAY '' ,0 TO stagenow,stagecomplete
   #CALL cl_progress_bar_no_window(l_cnt)
   FOREACH s_astp802_stie_cs INTO l_stje001
      #CALL cl_progress_no_window_ing(l_stje001)
      SELECT stiedocno  INTO g_stjedocno  FROM stie_t 
      WHERE stieent = g_enterprise  AND stie001=l_stje001 AND stie005 IN (1,2,3)
      IF NOT cl_null(g_stjedocno) THEN 
      FOREACH s_astp802_stio_cs USING l_stje001,g_stjedocno INTO l_stioseq,l_stio004
         IF l_stio004<g_master.stjm004 THEN 
            UPDATE stio_t SET stio005='Y' 
            WHERE stioent = g_enterprise AND stio001=l_stje001 AND stioseq=l_stioseq AND stiodocno=g_stjedocno
         ELSE 
          
         END IF
      END FOREACH
      
      FOREACH s_astp802_stim_cs USING l_stje001,g_stjedocno INTO l_stimseq,l_stim004
         IF l_stim004<g_master.stjm004 THEN 
            UPDATE stim_t SET stim015='Y' 
            WHERE stiment = g_enterprise AND stim001=l_stje001  AND stimseq=l_stimseq AND stimdocno=g_stjedocno
         ELSE 
          
         END IF
      END FOREACH
    END IF 
   END FOREACH
   
END FUNCTION

#end add-point
 
{</section>}
 
