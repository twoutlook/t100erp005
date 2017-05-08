#該程式已解開Section, 不再透過樣板產出!
{<section id="astp860.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000008
#+ 
#+ Filename...: astp860
#+ Description: 促銷商戶費用分攤批次計算作業
#+ Creator....: 07142(2016-07-31 21:24:29)
#+ Modifier...: 07142(2016-07-31 21:24:29) -SD/PR- 02481
 
{</section>}
 
{<section id="astp860.global" >}
#應用 p01 樣板自動產生(Version:16)
#add-point:填寫註解說明
#161024-00025#6   2016/10/31   By 02481   aooi500规范调整
#161111-00028#3   2016/11/16   by 02481   标准程式定义采用宣告模式,弃用.*写法
#Memos
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
        l_date           date,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       prhbsite LIKE prhb_t.prhbsite, 
   prhbdocno LIKE prhb_t.prhbdocno, 
   prhb001 LIKE prhb_t.prhb001, 
   prhb002 LIKE prhb_t.prhb002, 
   rtja101 LIKE rtja_t.rtja101, 
   mhbe001_desc LIKE type_t.chr80, 
   l_date LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable)
define g_wc1   STRING 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="astp860.main" >}
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
      CALL astp860_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp860 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp860_init()
 
      #進入選單 Menu (="N")
      CALL astp860_ui_dialog()
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp860
   END IF
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success
   DROP TABLE stka_tmp
   DROP TABLE stkb_tmp
   DROP TABLE astp860_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp860.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp860_init()
 
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
   CALL cl_set_combo_scc('prhb001','6952') 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp860.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp860_ui_dialog()
 
   #add-point:ui_dialog段define (客製用)

   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define 

   #end add-point
   
   #add-point:ui_dialog段before dialog

   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2
      LET g_master.l_date = g_today - 1
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME  g_master.l_date 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.l_date = g_today - 1
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
  
            #add-point:BEFORE FIELD prhb001 name="input.b.prhb001"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
        
            
            #add-point:AFTER FIELD prhb001 name="input.a.prhb001"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
 
            #add-point:ON CHANGE prhb001 name="input.g.prhb001"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_date
            #add-point:BEFORE FIELD l_date name="input.b.l_date"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_date
            
            #add-point:AFTER FIELD l_date name="input.a.l_date"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_date
            #add-point:ON CHANGE l_date name="input.g.l_date"

            #END add-point 
 
 
 
                     #Ctrlp:input.c.prhb001
         #應用 a03 樣板自動產生(Version:3)
 
            #add-point:ON ACTION controlp INFIELD prhb001 name="input.c.prhb001"

            #END add-point
 
 
         #Ctrlp:input.c.l_date
         #應用 a03 樣板自動產生(Version:3)
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
         CONSTRUCT BY NAME g_master.wc ON prhbsite,prhbdocno,prhb001,prhb002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"

               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prhbsite
            #add-point:BEFORE FIELD prhbsite name="construct.b.prhbsite"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prhbsite
            
            #add-point:AFTER FIELD prhbsite name="construct.a.prhbsite"

            #END add-point
            
 
 
         #Ctrlp:construct.c.prhbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prhbsite
            #add-point:ON ACTION controlp INFIELD prhbsite name="construct.c.prhbsite"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prhbsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prhbsite  #顯示到畫面上
            NEXT FIELD prhbsite 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prhbdocno
            #add-point:BEFORE FIELD prhbdocno name="construct.b.prhbdocno"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prhbdocno
            
            #add-point:AFTER FIELD prhbdocno name="construct.a.prhbdocno"

            #END add-point
            
 
 
         #Ctrlp:construct.c.prhbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prhbdocno
            #add-point:ON ACTION controlp INFIELD prhbdocno name="construct.c.prhbdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prhadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prhbdocno  #顯示到畫面上
            NEXT FIELD prhbdocno
            #END add-point
 
 
         #Ctrlp:construct.c.prhb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prhb002
            #add-point:ON ACTION controlp INFIELD prhb002 name="construct.c.prhb002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prhb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prhb002  #顯示到畫面上
            NEXT FIELD prhb002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prhb002
            #add-point:BEFORE FIELD prhb002 name="construct.b.prhb002"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prhb002
            
            #add-point:AFTER FIELD prhb002 name="construct.a.prhb002"

            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"

            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct
         CONSTRUCT BY NAME g_wc1 ON rtja101
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD rtja101
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.arg1 = g_site
                CALL q_mhbc001_1()
                DISPLAY g_qryparam.return1 TO rtja101 
                NEXT FIELD rtja101
             END CONSTRUCT
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
            CALL astp860_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            DISPLAY g_site TO prhasite
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
          ON ACTION accept
            
          ON ACTION cancel
           LET g_action_choice = "exit"    #160614-00011#1
           EXIT DIALOG          
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
         CALL astp860_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog
      LET lc_param.l_date=g_master.l_date 
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
                 CALL astp860_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp860_transfer_argv(ls_js)
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
 
{<section id="astp860.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp860_transfer_argv(ls_js)
 
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
 
{<section id="astp860.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp860_process(ls_js)
 
   #add-point:process段define (客製用)
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define 
   DEFINE l_msg         STRING 
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
     CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp860_process_cs CURSOR FROM ls_sql
#  FOREACH astp860_process_cs INTO
   #add-point:process段process
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   IF cl_null(lc_param.l_date) THEN       
      LET lc_param.l_date = g_today - 1
   END IF 
   IF cl_null(g_wc1) THEN       
      LET g_wc1 = "1=1"
   END IF
   IF cl_null(lc_param.wc) THEN       
      LET lc_param.wc = "1=1"
   END IF
   CALL astp860_cra_tmp()   
   IF NOT astp860(lc_param.wc,lc_param.l_date) THEN 
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF                         
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL astp860_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp860.get_buffer" >}
PRIVATE FUNCTION astp860_get_buffer(p_dialog)
 
   #add-point:process段define (客製用)

   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define

   #end add-point
 
   
   #LET g_master.prhb001 = p_dialog.getFieldBuffer('prhb001')
   LET g_master.l_date = p_dialog.getFieldBuffer('l_date')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理

   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp860.msgcentre_notify" >}
PRIVATE FUNCTION astp860_msgcentre_notify()
 
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
 
{<section id="astp860.other_function" readonly="Y" >}
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
PRIVATE FUNCTION astp860_ins_stkb()
#161111-00028#3----modify--------begin-------
#DEFINE l_stka   RECORD LIKE stka_t.*
#DEFINE l_prhb   RECORD LIKE prhb_t.*
DEFINE l_stka RECORD  #促銷商戶費用分攤明細檔
       stkaent LIKE stka_t.stkaent, #企業代碼
       stkaunit LIKE stka_t.stkaunit, #應用執行組織物件
       stkasite LIKE stka_t.stkasite, #營運據點
       stkadocno LIKE stka_t.stkadocno, #單號
       stkaseq LIKE stka_t.stkaseq, #項次
       stka001 LIKE stka_t.stka001, #分攤日期
       stka002 LIKE stka_t.stka002, #促銷協議編號
       stka003 LIKE stka_t.stka003, #促銷類型
       stka004 LIKE stka_t.stka004, #促銷規則編號
       stka005 LIKE stka_t.stka005, #商戶編號
       stka006 LIKE stka_t.stka006, #鋪位編號
       stka007 LIKE stka_t.stka007, #合約編號
       stka008 LIKE stka_t.stka008, #贈品數量
       stka009 LIKE stka_t.stka009, #贈品金額
       stka010 LIKE stka_t.stka010, #卡券編號
       stka011 LIKE stka_t.stka011  #分攤金額
       END RECORD
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3----modify--------end-------
DEFINE l_money  LIKE stka_t.stka011
DEFINE l_price1 LIKE stka_t.stka011
DEFINE l_year   varchar(5)
DEFINE l_month  varchar(5)
DEFINE l_stkb015 LIKE stkb_t.stkb015
DEFINE l_stkb016 LIKE stkb_t.stkb016
DEFINE l_bizhong VARCHAR(20)
DEFINE l_stkbseq LIKE stkb_t.stkbseq
DEFINE l_seq LIKE stkb_t.stkbseq
DEFINE l_sql     STRING
DEFINE l_ins_sql     STRING
DEFINE l_stjn006_sum  LIKE stjn_t.stjn006
DEFINE l_stkb016_max  LIKE stkb_t.stkb016
DEFINE l_stkb007      LIKE stkb_t.stkb007
DEFINE l_stkb008      LIKE stkb_t.stkb008
DEFINE l_success      LIKE type_t.num5

LET l_success = TRUE 

   LET l_sql=" SELECT stkasite,stka002,stka003,stka004,stka005,stka006,stka007,bizhong,sum(stka008),sum(stka009),SUM(stka011) ",
             " FROM stka_tmp ",
             " GROUP BY stkasite,stka002,stka003,stka004,stka005,stka006,stka007,bizhong ",
             " order by stka002 "     
    PREPARE astp860_pb_stkb FROM l_sql
    DECLARE astp860_curs_stkb CURSOR FOR astp860_pb_stkb    
    FOREACH astp860_curs_stkb INTO l_stka.stkasite,l_stka.stka002,l_stka.stka003,l_stka.stka004,l_stka.stka005,l_stka.stka006,
                                    l_stka.stka007,l_bizhong,l_stkb007,l_stkb008,l_money 
       IF l_money = 0 THEN 
          CONTINUE FOREACH
       END IF           
       SELECT max(stkbseq) INTO l_seq FROM stkb_t
       WHERE stkbdocno=l_stka.stka002 AND stkbent=g_enterprise 
       IF cl_null(l_seq) THEN
          SELECT max(stkbseq) INTO l_stkbseq FROM stkb_tmp
          WHERE stkbdocno=l_stka.stka002 AND stkbent=g_enterprise 
          IF cl_null(l_stkbseq) THEN          
             LET l_stkbseq=1
          ELSE 
             LET l_stkbseq=l_stkbseq+1
          END IF 
       ELSE
          SELECT max(stkbseq) INTO l_stkbseq FROM stkb_tmp
          WHERE stkbdocno=l_stka.stka002 AND stkbent=g_enterprise        
          IF cl_null(l_stkbseq) THEN
             let l_stkbseq=l_seq+1
          ELSE
             LET l_stkbseq=l_stkbseq+1
          END IF
       END IF 
       SELECT prhb004,prhb005,prhb006,prhb007,prhb008,prhb009
       INTO  l_prhb.prhb004,l_prhb.prhb005,l_prhb.prhb006,l_prhb.prhb007,l_prhb.prhb008,l_prhb.prhb009       
       FROM  prhb_t
       WHERE prhbent=g_enterprise AND prhbsite=l_stka.stkasite AND prhbdocno=l_stka.stka002
         AND prhb001=l_stka.stka003 AND prhb002=l_stka.stka004
     
       LET l_year=YEAR(l_prhb.prhb004)
       LET l_month=MONTH(l_prhb.prhb004)
       LET l_sql=" SELECT SUM(stjn006)  from stjn_t where stjnent= ",g_enterprise, 
                 " and stjn001='",l_stka.stka007,"'  and  to_char(stjn002,'yyyy')=",l_year,
                 "  AND to_char(stjn002,'mm')=",l_month,
                 "  AND stjn005='10001' "
        PREPARE astp860_stjn_pb FROM l_sql  
        EXECUTE astp860_stjn_pb INTO l_stjn006_sum
       LET l_stkb016_max=l_stjn006_sum * l_prhb.prhb007 * (l_prhb.prhb006/100)   ##商场承担的最大金额
       IF l_prhb.prhb008='1' THEN
       	  LET l_price1=l_money-l_prhb.prhb009         ##按比例商场应该承担的金额
       	  LET l_stkb015=l_prhb.prhb009
       ELSE
       	  LET l_price1=l_money*(1-l_prhb.prhb009/100)
       	  LET l_stkb015=l_money*(l_prhb.prhb009/100)
       END IF 
       IF l_stkb016_max<l_price1	 THEN      ##如果商场承担的最大的金额小于算出来的金额，多于的部分由商户自己承担 
          LET l_stkb016=l_stkb016_max
          CALL s_curr_round('',l_bizhong,l_stkb016,'2') RETURNING l_stkb016 
          LET l_stkb015=l_money-l_stkb016
       ELSE
       	  LET l_stkb015=l_stkb015
       	  CALL s_curr_round('',l_bizhong,l_stkb015,'2') RETURNING l_stkb015 
       	  LET l_stkb016=l_money-l_stkb015
       END IF 
       
       IF l_stka.stka003 MATCHES '[56]' THEN
       
       ELSE
          LET l_stkb007=0
          LET l_stkb008=0
       END IF
       LET l_ins_sql=" INSERT INTO stkb_tmp (stkbent,stkbsite,stkbunit,stkbdocno,stkbseq,",
                    " stkb001,stkb002,stkb003,stkb004,stkb005,",
                    " stkb006,stkb007,stkb008,stkb009,stkb010,",
                    " stkb011,stkb012,stkb013,stkb014,stkb015,",
                    " stkb016) ",
              
                    "VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,'',?, ?,?,?,?,?,?)"
               PREPARE ins_stkb_tmp1 FROM l_ins_sql
               EXECUTE ins_stkb_tmp1 USING  g_enterprise,l_stka.stkasite,l_stka.stkasite,l_stka.stka002,l_stkbseq,
                                           l_stka.stka003,l_stka.stka004,l_prhb.prhb004,l_stka.stka005,l_stka.stka006,
                                           l_stka.stka007,l_stkb007,l_stkb008,l_money,
                                           l_prhb.prhb005,l_prhb.prhb007,l_prhb.prhb006,l_prhb.prhb009,l_stkb015,
                                           l_stkb016
              IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stkb_tmp:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  #CALL s_transaction_end('N','0')
                  LET l_success = FALSE
                  RETURN l_success
               END IF              
     END FOREACH
     LET l_ins_sql= " insert into stkb_t select * from stkb_tmp "
     PREPARE ins_stkb FROM l_ins_sql
     EXECUTE ins_stkb 
     IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "EXECUTE:ins_stkb" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
        LET l_success = FALSE
        RETURN l_success
     END IF
     RETURN l_success 
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
PRIVATE FUNCTION astp860_ins_stba()
#161111-00028#3--modify---begin------
#DEFINE l_stkb   record like stkb_t.*
#DEFINE l_stba   RECORD LIKE stba_t.*
#DEFINE l_stbb   RECORD LIKE stbb_t.*
DEFINE l_stba RECORD  #費用單資料表
       stbaent LIKE stba_t.stbaent, #企業編號
       stbasite LIKE stba_t.stbasite, #營運據點
       stbaunit LIKE stba_t.stbaunit, #應用組織
       stbadocno LIKE stba_t.stbadocno, #單據編號
       stbadocdt LIKE stba_t.stbadocdt, #單據日期
       stba001 LIKE stba_t.stba001, #結算中心
       stba002 LIKE stba_t.stba002, #供應商編號
       stba003 LIKE stba_t.stba003, #經營方式
       stba004 LIKE stba_t.stba004, #結算方式
       stba005 LIKE stba_t.stba005, #結算類型
       stba006 LIKE stba_t.stba006, #來源類型
       stba007 LIKE stba_t.stba007, #來源單號
       stba008 LIKE stba_t.stba008, #人員
       stba009 LIKE stba_t.stba009, #部門
       stbastus LIKE stba_t.stbastus, #狀態碼
       stbaownid LIKE stba_t.stbaownid, #資料所屬者
       stbaowndp LIKE stba_t.stbaowndp, #資料所有部門
       stbacrtid LIKE stba_t.stbacrtid, #資料建立者
       stbacrtdp LIKE stba_t.stbacrtdp, #資料建立部門
       stbacrtdt LIKE stba_t.stbacrtdt, #資料創建日
       stbamodid LIKE stba_t.stbamodid, #資料修改者
       stbamoddt LIKE stba_t.stbamoddt, #最近修改日
       stbacnfid LIKE stba_t.stbacnfid, #資料確認者
       stbacnfdt LIKE stba_t.stbacnfdt, #資料確認日
       stba010 LIKE stba_t.stba010, #合約編號
       stba011 LIKE stba_t.stba011, #幣別
       stba012 LIKE stba_t.stba012, #稅別
       stba013 LIKE stba_t.stba013, #專櫃編號/鋪位編號
       stba014 LIKE stba_t.stba014, #費用類型
       stba015 LIKE stba_t.stba015, #交款狀態
       stba000 LIKE stba_t.stba000, #程式編號
       stba016 LIKE stba_t.stba016, #交款人
       stba017 LIKE stba_t.stba017, #結算帳期
       stba018 LIKE stba_t.stba018, #結算日期
       stba019 LIKE stba_t.stba019, #開始日期
       stba020 LIKE stba_t.stba020, #結束日期
       stba021 LIKE stba_t.stba021, #成本總額
       stba022 LIKE stba_t.stba022, #法人
       stba023 LIKE stba_t.stba023, #會員折扣金額
       stba024 LIKE stba_t.stba024, #no_use
       stba025 LIKE stba_t.stba025, #合約帳期
       stba026 LIKE stba_t.stba026, #計算日期
       stba027 LIKE stba_t.stba027  #促銷協議項次
       END RECORD
       
DEFINE l_stbb RECORD  #費用單明細資料表
       stbbent LIKE stbb_t.stbbent, #企業編號
       stbbunit LIKE stbb_t.stbbunit, #應用組織
       stbbsite LIKE stbb_t.stbbsite, #營運據點
       stbbdocno LIKE stbb_t.stbbdocno, #單據編號
       stbbseq LIKE stbb_t.stbbseq, #項次
       stbb001 LIKE stbb_t.stbb001, #費用編號
       stbb002 LIKE stbb_t.stbb002, #幣別
       stbb003 LIKE stbb_t.stbb003, #稅別
       stbb004 LIKE stbb_t.stbb004, #價款類別
       stbb005 LIKE stbb_t.stbb005, #起始日期
       stbb006 LIKE stbb_t.stbb006, #截止日期
       stbb007 LIKE stbb_t.stbb007, #結算會計期
       stbb008 LIKE stbb_t.stbb008, #財務會計期
       stbb009 LIKE stbb_t.stbb009, #費用金額
       stbb010 LIKE stbb_t.stbb010, #承擔對象
       stbb011 LIKE stbb_t.stbb011, #所屬品類
       stbb012 LIKE stbb_t.stbb012, #所屬部門
       stbb013 LIKE stbb_t.stbb013, #結算對象
       stbb014 LIKE stbb_t.stbb014, #財務會計期別
       stbb015 LIKE stbb_t.stbb015, #納入結算單否
       stbb016 LIKE stbb_t.stbb016, #票扣否
       stbb017 LIKE stbb_t.stbb017, #備註
       stbb018 LIKE stbb_t.stbb018, #結算帳期
       stbb019 LIKE stbb_t.stbb019, #結算日期
       stbb020 LIKE stbb_t.stbb020, #日結成本類型
       stbb021 LIKE stbb_t.stbb021, #調整日期
       stbb022 LIKE stbb_t.stbb022, #商品編號
       stbb023 LIKE stbb_t.stbb023, #庫區編號
       stbb024 LIKE stbb_t.stbb024, #专柜编号
       stbb025 LIKE stbb_t.stbb025, #應收金額
       stbb026 LIKE stbb_t.stbb026, #實收金額
       stbb027 LIKE stbb_t.stbb027, #費率
       stbb028 LIKE stbb_t.stbb028, #成本金額
       stbb029 LIKE stbb_t.stbb029, #促銷銷售額
       stbb030 LIKE stbb_t.stbb030, #費用歸屬類型
       stbb031 LIKE stbb_t.stbb031, #費用歸屬組織
       stbb032 LIKE stbb_t.stbb032, #銷售數量
       stbb033 LIKE stbb_t.stbb033, #銷售單位
       stbbud001 LIKE stbb_t.stbbud001 
       END RECORD 
       
DEFINE l_stkb RECORD  #租賃促銷折扣明細表
       stkbent LIKE stkb_t.stkbent, #企业代码
       stkbunit LIKE stkb_t.stkbunit, #應用組織
       stkbsite LIKE stkb_t.stkbsite, #营运组织
       stkbdocno LIKE stkb_t.stkbdocno, #促銷協議編號
       stkbseq LIKE stkb_t.stkbseq, #項次
       stkb001 LIKE stkb_t.stkb001, #促銷類型
       stkb002 LIKE stkb_t.stkb002, #促銷規則編號
       stkb003 LIKE stkb_t.stkb003, #費用日期
       stkb004 LIKE stkb_t.stkb004, #商戶編號
       stkb005 LIKE stkb_t.stkb005, #鋪位編號
       stkb006 LIKE stkb_t.stkb006, #合約編號
       stkb007 LIKE stkb_t.stkb007, #贈品數量
       stkb008 LIKE stkb_t.stkb008, #贈品金額
       stkb009 LIKE stkb_t.stkb009, #卡券編號
       stkb010 LIKE stkb_t.stkb010, #折扣金額
       stkb011 LIKE stkb_t.stkb011, #費用編號
       stkb012 LIKE stkb_t.stkb012, #場租倍數
       stkb013 LIKE stkb_t.stkb013, #費用臨界值比率
       stkb014 LIKE stkb_t.stkb014, #商戶承擔費用比例
       stkb015 LIKE stkb_t.stkb015, #商戶承擔費用金額
       stkb016 LIKE stkb_t.stkb016  #賣場承擔費用金額
       END RECORD
#161111-00028#3--modify---end--------
DEFINE l_sql    STRING
DEFINE l_ins_sql    STRING
DEFINE l_stkb006 LIKE stkb_t.stkb006
DEFINE r_success     LIKE type_t.num5
DEFINE l_suc         LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE r_doctype     LIKE rtai_t.rtai004
DEFINE r_insert       LIKE type_t.num5
DEFINE r_stau004    LIKE stau_t.stau004
DEFINE r_period     LIKE type_t.num5
DEFINE r_period2    LIKE type_t.num5
DEFINE l_f          INT
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_cnt1         LIKE type_t.num10
DEFINE l_cnm         LIKE type_t.num10
DEFINE l_stae010     LIKE stae_t.stae010
DEFINE l_stbb018     LIKE stbb_t.stbb018
DEFINE l_prhbseq     like prhb_t.prhbseq

LET l_success=TRUE
LET l_sql=" SELECT distinct stkb006  ",
             " FROM stkb_tmp ",
             " order by stkb006 "     
   PREPARE astp860_pb_stba FROM l_sql
   DECLARE astp860_curs_stba CURSOR FOR astp860_pb_stba    
   
#LET l_sql=" SELECT  *   ",  #161111-00028#3--mark
#161111-00028#3--add---begin------
 LET l_sql=" SELECT  stkbent,stkbunit,stkbsite,stkbdocno,stkbseq,stkb001,stkb002,stkb003,stkb004,",
            "stkb005,stkb006,stkb007,stkb008,stkb009,stkb010,stkb011,stkb012,stkb013,stkb014,stkb015,stkb016",
#161111-00028#3--add---end--------
             " FROM stkb_tmp ",
             " where stkbent= ",g_enterprise,
             "   and stkb006 = ? "            
   PREPARE astp860_pb_stbb FROM l_sql
   DECLARE astp860_curs_stbb CURSOR FOR astp860_pb_stbb 
      
   FOREACH astp860_curs_stba INTO l_stkb006
      
      FOREACH astp860_curs_stbb USING l_stkb006 INTO l_stkb.*
         IF l_stkb.stkb001 MATCHES '[123456]' THEN 
           SELECT prhbseq INTO l_prhbseq FROM prhb_t
           WHERE prhbent=g_enterprise AND prhbdocno=l_stkb.stkbdocno
           AND prhb001=l_stkb.stkb001 AND prhb002=l_stkb.stkb002
         ELSE
           SELECT prhbseq INTO l_prhbseq FROM prhb_t
           WHERE prhbent=g_enterprise AND prhbdocno=l_stkb.stkbdocno
           AND prhb001=l_stkb.stkb001
         END IF 
         SELECT COUNT(*) INTO l_f FROM stba_t
         WHERE stbaent=g_enterprise AND stbasite=l_stkb.stkbsite
           AND stba010=l_stkb.stkb006 AND stba006='12' 
           AND stbadocdt=l_stkb.stkb003 AND stba007=l_stkb.stkbdocno and stba027=l_prhbseq
           
         IF l_f=0 THEN 
            LET l_stba.stbadocdt=l_stkb.stkb003
            LET l_stba.stba002=l_stkb.stkb004
            LET l_stba.stba013=l_stkb.stkb005
            LET l_stba.stba010=l_stkb.stkb006
            LET l_stba.stbasite=l_stkb.stkbsite
            LET l_stba.stba027=l_prhbseq
            LET l_stba.stba006='12'
            LET l_stba.stba007=l_stkb.stkbdocno
            LET l_stba.stba008=g_user
            LET l_stba.stba009=g_dept
            LET l_stba.stbastus='N'
            LET l_stba.stba015='N'
            LET l_stba.stba000 = 'astt810'      
            LET l_stba.stba003 ='5'
            LET l_stba.stbaownid = g_user
            LET l_stba.stbaowndp = g_dept
            LET l_stba.stbacrtid = g_user
            LET l_stba.stbacrtdp = g_dept
            LET l_stba.stba025 =''
            LET l_stba.stba026 =''
            LET l_stba.stbacrtdt = cl_get_current()
            IF cl_null(l_stba.stba010)   THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'ast-00823'
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #CALL s_transaction_end('N','0')
               LET l_success=FALSE               
               RETURN l_success 
               #CONTINUE FOREACH
            END IF 
            LET r_insert=TRUE
            CALL s_aooi500_default('astt810','stbaunit',l_stba.stbasite) RETURNING r_insert,l_stba.stbaunit
            IF NOT r_insert THEN
               LET l_success=FALSE               
               RETURN l_success  
            END IF
            
            CALL s_aooi500_default('astt810','stba001',l_stba.stbasite) RETURNING r_insert,l_stba.stba001
            IF NOT r_insert THEN
               LET l_success=FALSE               
               RETURN l_success 
            END IF
            	
            SELECT ooef017 INTO l_stba.stba022
            FROM ooef_t
            WHERE ooefent=g_enterprise
            AND ooef001=l_stba.stbaunit
            
            CALL s_arti200_get_def_doc_type(l_stba.stbaunit,'astt810','1')
            RETURNING r_success,r_doctype
            LET l_stba.stbadocno = r_doctype
            CALL s_aooi200_gen_docno(g_site,l_stba.stbadocno,l_stba.stbadocdt,'astt810') RETURNING l_suc,l_stba.stbadocno
            
            IF NOT l_suc THEN
               LET l_success='N'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00003'
               LET g_errparam.extend = l_stba.stba002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success=FALSE               
               RETURN l_success                     
            END IF
            LET l_sql = "SELECT   stje031,stje032, ",  
                          "       stje036,stje038,stje017,stje018, ",  
                          "       stje030",                                  
                          "  FROM stje_t ",
                          " WHERE stjeent = ",g_enterprise,
                          "   and stje001 = '",l_stba.stba010,"' "
               PREPARE astt320_sel_stje008 FROM l_sql
               DISPLAY "SOUR SQL: ",l_sql   
            LET l_sql = "SELECT COUNT(*) FROM (",l_sql,") "
               PREPARE astt320_cnt_stje008 FROM l_sql         
            LET l_cnm = 0
               EXECUTE astt320_cnt_stje008 INTO l_cnm   
            IF l_cnm = 1 THEN
               EXECUTE astt320_sel_stje008 INTO  l_stba.stba004, l_stba.stba005,
                                                 l_stba.stba011, l_stba.stba012, 
                                                 l_stba.stba008, l_stba.stba009, 
                                                 l_stba.stba001     
               LET l_sql = "SELECT MIN(stjoseq) ",
                            "  FROM stjo_t ",
                            " WHERE stjoent = ",g_enterprise,
                            "   AND stjo001 = '",l_stba.stba010,"' ",
                            "   AND stjo005 = 'N' "
                   PREPARE astt320_get_stjo002_pre3 FROM l_sql
                   EXECUTE astt320_get_stjo002_pre3 INTO l_stba.stba025 
             END IF  
   
             LET l_ins_sql=" INSERT INTO stba_t (stbaent,stbaunit,stbadocdt,stbadocno,stba002,",
                    "stba010,stba000,stba013,stba003,stba005,",
                    "stba004,stba015,stbastus,stba027,",
                    "stba006,stba007,stba001,stba022,stba025,",
                    "stbasite,stba026,stba011,stba012,stba008,",
                    "stba009,stbaownid,stbaowndp,stbacrtid,stbacrtdp,stbacrtdt)",
                    "VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?, ?,?,?,?,?, ?,?,?,?)"
               PREPARE ins_stba FROM l_ins_sql
               EXECUTE ins_stba USING g_enterprise,l_stba.stbaunit,l_stba.stbadocdt,l_stba.stbadocno,l_stba.stba002, 
                       l_stba.stba010,l_stba.stba000,l_stba.stba013,l_stba.stba003,l_stba.stba005,
                       l_stba.stba004,l_stba.stba015,l_stba.stbastus,l_stba.stba027,
                       l_stba.stba006,l_stba.stba007,l_stba.stba001,l_stba.stba022,l_stba.stba025,
                       l_stba.stbasite,l_stba.stba026,l_stba.stba011,l_stba.stba012,l_stba.stba008, 
                       l_stba.stba009,l_stba.stbaownid,l_stba.stbaowndp,l_stba.stbacrtid, 
                       l_stba.stbacrtdp,l_stba.stbacrtdt
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "stba_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success=FALSE               
                RETURN l_success
             END IF
          ELSE
            #SELECT * INTO l_stba.*    #161111-00028#3--mark
            #161111-00028#3---ADD----BEGIN---------
             SELECT stbaent,stbasite,stbaunit,stbadocno,stbadocdt,stba001,stba002,stba003,stba004,
                    stba005,stba006,stba007,stba008,stba009,stbastus,stbaownid,stbaowndp,stbacrtid,
                    stbacrtdp,stbacrtdt,stbamodid,stbamoddt,stbacnfid,stbacnfdt,stba010,stba011,stba012,
                    stba013,stba014,stba015,stba000,stba016,stba017,stba018,stba019,stba020,stba021,
                    stba022,stba023,stba024,stba025,stba026,stba027 INTO l_stba.*
            #161111-00028#3---ADD----END-----------
             FROM stba_t 
             WHERE stbaent=g_enterprise AND stbasite=l_stkb.stkbsite
               AND stba010=l_stkb.stkb006 AND stba006='12' 
               AND stbadocdt=l_stkb.stkb003 AND stba007=l_stkb.stkbdocno and stba027=l_prhbseq
          END IF 
          LET l_stbb.stbb001=l_stkb.stkb011
          LET l_stbb.stbb009=l_stkb.stkb015
          LET l_stbb.stbb005=l_stba.stbadocdt
          LET l_stbb.stbb006=l_stba.stbadocdt
          SELECT MAX(stbbseq) INTO l_stbb.stbbseq
          FROM stbb_t 
          WHERE stbbent=g_enterprise and stbbdocno=l_stba.stbadocno
          IF cl_null(l_stbb.stbbseq) THEN 
          	  LET l_stbb.stbbseq=1
          ELSE
          	  LET l_stbb.stbbseq=l_stbb.stbbseq+1
          END IF 
          SELECT stae013,stae014,stae011,stae007,stae010 
          INTO l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb015,l_stbb.stbb016,l_stae010
          FROM stae_t 
          WHERE stae001=l_stbb.stbb001 AND staeent=g_enterprise
          IF cl_null(l_stbb.stbb015) THEN
             LET l_stbb.stbb015 = 'Y' 
          END IF
          IF cl_null(l_stbb.stbb016) THEN
             LET l_stbb.stbb016 = 'N' 
          END IF
          IF  l_stbb.stbb030 ='1' THEN 
          	   LET l_stbb.stbb031=l_stba.stbaunit
          END IF
          LET l_stbb.stbb002=l_stba.stba011               
          IF l_stbb.stbb016='Y' THEN 
             SELECT stje038 INTO l_stbb.stbb003
             FROM stje_t
             WHERE stjeent = g_enterprise
             AND stje001 = l_stba.stba010
          ELSE
              LET l_stbb.stbb003=l_stae010
          END IF 
          LET l_cnt1 = 0
          SELECT COUNT(*) INTO l_cnt1
          FROM stji_t
          WHERE stji001 = l_stba.stba010
          AND stjient = g_enterprise
          AND stji002 = l_stbb.stbb001   
          IF  l_cnt1 > 0 THEN
             SELECT stji010,stji007,stji008 INTO l_stbb.stbb003,l_stbb.stbb015,l_stbb.stbb016 #定义账期的税别  
             FROM stji_t
             WHERE stji001 = l_stba.stba010
               AND stjient = g_enterprise
               AND stji002 = l_stbb.stbb001                    
          END IF
          IF cl_null(l_stbb.stbb003) THEN 
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "" 
             LET g_errparam.code   = 'asf-00228'
             LET g_errparam.popup  = FALSE 
             CALL cl_err()
             LET l_success=FALSE               
             RETURN l_success 
          END IF 
          CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,'astt320')
             RETURNING r_success,r_stau004,r_period,r_period2
          LET l_stbb.stbb007 = r_stau004
          LET l_stbb.stbb008 = r_period
          LET l_stbb.stbb014 = r_period2
          CALL s_expense_get_stbb019(l_stba.stba010,l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbbsite)           
             RETURNING  l_stbb018,l_stbb.stbb019 
          LET l_stbb.stbb012 = l_stba.stba009
          LET l_stbb.stbb010='1'
          LET l_stbb.stbb013='1'
          SELECT stje028 INTO l_stbb.stbb011
              FROM stje_t
             WHERE stjeent = g_enterprise
               AND stje001 = l_stba.stba010
           CALL s_curr_round('',l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009 
          LET l_ins_sql="	INSERT INTO stbb_t(stbbent,stbbdocno,stbbseq,stbb001,stbb030,",
                               "stbb031,stbb015,stbb016,stbb002,stbb003,",
                               "stbb004,stbb005,stbb006,stbb007,stbb008,",
                               "stbb014,stbb019,stbb009,stbb010,stbb013,",
                                "stbbsite,stbb012,stbb011,stbb017,stbbunit)", 
            "VALUES(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?)"
            PREPARE ins_stbb FROM l_ins_sql
            EXECUTE ins_stbb  USING g_enterprise,l_stba.stbadocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb030,
                  l_stbb.stbb031,l_stbb.stbb015,l_stbb.stbb016,l_stbb.stbb002,l_stbb.stbb003,
                  l_stbb.stbb004,l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,
                  l_stbb.stbb014,l_stbb.stbb019,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb013,
                  g_site,l_stbb.stbb012,l_stbb.stbb011,l_stbb.stbb017,l_stba.stbaunit
            IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "stbb_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success=FALSE               
                RETURN l_success
            END IF
         END FOREACH
      END FOREACH
      
      RETURN l_success      
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
PRIVATE FUNCTION astp860_cra_tmp()
DEFINE l_sql        STRING

DROP TABLE stka_tmp
DROP TABLE stkb_tmp

LET l_sql = " SELECT * FROM stka_t WHERE 1=0 INTO TEMP stka_tmp "
PREPARE cre_tmp_pre1 FROM l_sql
LET l_sql = " SELECT * FROM stkb_t WHERE 1=0 INTO TEMP stkb_tmp "
PREPARE cre_tmp_pre2 FROM l_sql 

 
EXECUTE cre_tmp_pre1
EXECUTE cre_tmp_pre2
ALTER TABLE stka_tmp ADD (bizhong varchar(20))

   CREATE TEMP TABLE astp860_tmp (
       gcao001   VARCHAR(30)
        )  

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
PRIVATE FUNCTION astp860_01(l_prhb)
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE l_price  LIKE stka_t.stka011
DEFINE l_rtja101  LIKE rtja_t.rtja101
DEFINE l_rtja102  LIKE rtja_t.rtja102
DEFINE l_rtja105  LIKE rtja_t.rtja105
DEFINE l_rtjf103  LIKE rtjf_t.rtjf103
DEFINE l_rtjadocno LIKE rtja_t.rtjadocno
DEFINE l_stkaseq LIKE stka_t.stkaseq
DEFINE l_seq         LIKE stka_t.stkaseq
DEFINE l_sql     STRING 
DEFINE l_ins_sql  STRING 
DEFINE l_success1      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_stbastus     LIKE stba_t.stbastus
DEFINE l_stbadocno     LIKE stba_t.stbadocno
DEFINE l_rtja026      LIKE rtja_t.rtja026
DEFINE l_error        string 
LET l_success1 = TRUE 
LET l_error=''   
LET l_sql=" SELECT rtjadocno,rtja101,rtja102,rtja105,rtja026,rtjf103,SUM(rtjc013) ",
             " FROM rtjc_t ",
             " LEFT JOIN rtjf_t ON rtjfent=rtjcent AND rtjfdocno=rtjcdocno AND rtjf103=rtjc103 ",
             " LEFT JOIN rtja_t ON rtjaent=rtjcent AND rtjadocno=rtjcdocno ",
             " WHERE rtjfent= ",g_enterprise,
             " AND rtjf025 BETWEEN ? AND ? ",
             " AND rtjadocdt BETWEEN ? AND ? ",
             " AND rtja000 = 'artt621' ",
             " and rtjasite='",l_prhb.prhbsite,"'",
             " AND rtjc003 = ?  and ",g_wc1,
             " GROUP BY rtjadocno,rtja101,rtja102,rtja105,rtjf103 ",
             " ORDER BY rtjadocno "
                         
   PREPARE astp860_pb1_1 FROM l_sql
   DECLARE astp860_curs1_1 CURSOR FOR astp860_pb1_1 
      
      FOREACH astp860_curs1_1 USING l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhbdocno
                               INTO l_rtjadocno,l_rtja101,l_rtja102,l_rtja105,l_rtja026,l_rtjf103,l_price
       
       SELECT stbastus,stbadocno INTO l_stbastus,l_stbadocno
       FROM stba_t
       WHERE stbaent=l_prhb.prhbent
         AND stba006='12'
         AND stba007=l_prhb.prhbdocno
         AND stba010=l_rtja105
         AND stbadocdt=l_prhb.prhb004
            AND stba027=l_prhb.prhbseq
       IF NOT cl_null(l_stbadocno) THEN 
          IF l_stbastus='Y'  THEN
             LET l_error=l_error,"|",l_stbadocno
             CONTINUE FOREACH  
          ELSE
                   
             DELETE FROM stka_t WHERE stkaent=l_prhb.prhbent AND stka002=l_prhb.prhbdocno
                                  AND stka003=l_prhb.prhb001 AND stka004=l_prhb.prhb002
                                  AND stkadocno=l_rtjadocno
             DELETE FROM stkb_t WHERE stkbent=l_prhb.prhbent AND stkbdocno=l_prhb.prhbdocno
                                  AND stkb001=l_prhb.prhb001 AND stkb002=l_prhb.prhb002
                                  AND stkb006=l_rtja105
             DELETE FROM stbb_t where stbbent=l_prhb.prhbent
                                  AND stbbdocno in (select stbadocno from stba_t 
                                  where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004  and stba027=l_prhb.prhbseq) 
             DELETE FROM stba_t where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004  and stba027=l_prhb.prhbseq
          
          END IF
       END IF        
       SELECT max(stkaseq) INTO l_seq FROM stka_t
          WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
          IF cl_null(l_seq) THEN
             SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
             WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
             IF cl_null(l_stkaseq) THEN 
                LET l_stkaseq=1
             ELSE 
                LET l_stkaseq=l_stkaseq+1
             END IF
          ELSE 
             SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
             WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
              IF cl_null(l_stkaseq) THEN 
                 LET l_stkaseq=l_seq+1
              ELSE 
                 LET l_stkaseq=l_stkaseq+1
              END IF
          END IF 
       	                         
       LET l_ins_sql=" INSERT INTO stka_tmp (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                       " stka001,stka002,stka003,stka004,stka005,",
                       " stka006,stka007,stka008,stka009,stka010,",
                       " stka011,bizhong) ",
                
                      "VALUES (?,?,?,?,?,  ?,?,?,?,?,  ?,?,0,0,'',  ?,?)"
                 PREPARE ins_stka_tmp1 FROM l_ins_sql
                 EXECUTE ins_stka_tmp1 USING  g_enterprise,l_prhb.prhbsite,l_prhb.prhbsite,l_rtjadocno,l_stkaseq,
                                              l_prhb.prhb004,l_prhb.prhbdocno,l_prhb.prhb001,l_prhb.prhb002,l_rtja102,
                                              l_rtja101,l_rtja105,l_price,l_rtja026
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = "ins_stka_tmp1:",SQLERRMESSAGE 
                    LET g_errparam.code   = SQLCA.sqlcode 
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    LET l_success1 = FALSE
                    RETURN l_success1
                 END IF              
       END FOREACH
   LET l_ins_sql= " INSERT INTO stka_t (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011) ",
                   " SELECT stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011 FROM stka_tmp "
     PREPARE ins_stka1 FROM l_ins_sql
     EXECUTE ins_stka1 
     IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "EXECUTE:ins_stka1" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
        LET l_success1 = FALSE
        RETURN l_success1
     END IF
    IF NOT cl_null(l_error) THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = l_error
       LET g_errparam.code   = 'ast-00447'
       LET g_errparam.popup  = FALSE 
       CALL cl_err()
    END IF 
    IF l_success1 THEN      
       CALL astp860_ins_stkb() RETURNING l_success
       IF NOT l_success  THEN
          LET l_success1 = FALSE
          RETURN l_success1
       ELSE        
          CALL astp860_ins_stba() RETURNING l_success
          IF NOT l_success  THEN
            LET l_success1 = FALSE
            RETURN l_success1
          END IF
       END IF
    ELSE       
       LET l_success1 = FALSE
       RETURN l_success1
    END IF
   RETURN l_success1    
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
PRIVATE FUNCTION astp860_03(l_prhb)
DEFINE l_sql   STRING
DEFINE l_ins_sql   STRING
DEFINE l_sql1  STRING
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE l_mmbt005     LIKE mmbt_t.mmbt005
DEFINE l_rtja101     LIKE rtja_t.rtja101
DEFINE l_rtja102     LIKE rtja_t.rtja102
DEFINE l_rtja105     LIKE rtja_t.rtja105
DEFINE l_rtja026     LIKE rtja_t.rtja026
DEFINE l_rtjf004     LIKE rtjf_t.rtjf004
DEFINE l_price       LIKE mmau_t.mmau009
DEFINE l_stka011     LIKE stka_t.stka011
DEFINE l_stkaseq     LIKE stka_t.stkaseq
DEFINE l_seq     LIKE stka_t.stkaseq
DEFINE l_rtjadocno   LIKE rtja_t.rtjadocno
DEFINE l_rtjadocdt   LIKE rtja_t.rtjadocdt
DEFINE l_success1      LIKE type_t.num5
DEFINE l_stbastus     LIKE stba_t.stbastus
DEFINE l_success      LIKE type_t.num5
DEFINE l_rtjf103      LIKE rtjf_t.rtjf103
DEFINE l_stbadocno    LIKE stba_t.stbadocno
DEFINE l_prhbdocno    LIKE prhb_t.prhbdocno
DEFINE l_error        STRING 
LET l_success1 = TRUE
LET l_error='' 
SELECT mmbt005 INTO l_mmbt005 FROM mmbt_t  
WHERE mmbtent=l_prhb.prhbent AND mmbt001=l_prhb.prhb002

LET l_sql1=" SELECT distinct rtjadocno,rtjadocdt,rtja026,rtjf103,rtja101 ,rtja102 ,rtja105,rtjf004 ",
           " FROM rtja_t,rtjf_t ",
           " WHERE  rtjaent=rtjfent AND rtjadocno=rtjfdocno   ", 
           "   AND  rtjfent=?  AND rtja000='artt621' ",
           " AND rtjf013 = ?  AND rtjf001='60'  and ",g_wc1,
           " and rtjasite='",l_prhb.prhbsite,"'",
           " AND rtjf025 BETWEEN ?  AND ?    ",
           " AND rtjadocdt BETWEEN ?  AND ?    ",
           " ORDER BY rtjadocno " 
    PREPARE astp860_pb3_1 FROM l_sql1
    DECLARE astp860_curs3_1 CURSOR FOR astp860_pb3_1                                        
       FOREACH astp860_curs3_1 USING g_enterprise,l_mmbt005,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004
                                INTO l_rtjadocno,l_rtjadocdt,l_rtja026,l_rtjf103,l_rtja101,l_rtja102,l_rtja105,l_rtjf004
                                
          SELECT stbastus,stbadocno INTO l_stbastus,l_stbadocno
          FROM stba_t
          WHERE stbaent=l_prhb.prhbent
            AND stba006='12'
            AND stba007=l_prhb.prhbdocno
            AND stba010=l_rtja105
            and stbadocdt=l_prhb.prhb004
            and stba027=l_prhb.prhbseq
          IF NOT cl_null(l_stbadocno) THEN 
             IF l_stbastus = 'Y'  THEN
                LET l_error=l_error,"|",l_stbadocno          
                CONTINUE FOREACH
             ELSE 
                DELETE FROM stka_t WHERE stkaent=l_prhb.prhbent AND stka002=l_prhb.prhbdocno
                                     AND stka003=l_prhb.prhb001 AND stka004=l_prhb.prhb002
                                     AND stkadocno=l_rtjadocno
                DELETE FROM stkb_t WHERE stkbent=l_prhb.prhbent AND stkbdocno=l_prhb.prhbdocno
                                     AND stkb001=l_prhb.prhb001 AND stkb002=l_prhb.prhb002
                                     AND stkb006=l_rtja105
                DELETE FROM stbb_t WHERE stbbent=l_prhb.prhbent
                                    AND stbbdocno IN (select stbadocno FROM stba_t 
                                    WHERE stbaent=l_prhb.prhbent AND stba006='12' 
                                     AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                     AND stbadocdt=l_prhb.prhb004 AND stba027=l_prhb.prhbseq) 
                DELETE FROM stba_t WHERE stbaent=l_prhb.prhbent AND stba006='12' 
                                    AND stba007=l_prhbdocno AND stba010=l_rtja105
                                    AND stbadocdt=l_prhb.prhb004 AND stba027=l_prhb.prhbseq
             END IF
          END IF           
           select SUM(mmau009-mmau014) into l_price 
           from mmau_t 
           where mmauent=g_enterprise and mmau001=l_rtjf004 and mmau005=l_rtjadocno        
           LET l_price = l_price * (-1)
          IF l_price =0 THEN 
             CONTINUE FOREACH
          END IF 
          SELECT max(stkaseq) INTO l_seq FROM stka_t
          WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
          IF cl_null(l_seq) THEN
             SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
             WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
             IF cl_null(l_stkaseq) THEN 
                LET l_stkaseq=1
             ELSE 
                LET l_stkaseq=l_stkaseq+1
             END IF
          ELSE 
             SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
             WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
              IF cl_null(l_stkaseq) THEN 
                 LET l_stkaseq=l_seq+1
              ELSE 
                 LET l_stkaseq=l_stkaseq+1
              END IF
          END IF
          CALL s_curr_round('',l_rtja026,l_price,'2') RETURNING l_price           
          LET l_ins_sql=" INSERT INTO stka_tmp (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                                               " stka001,stka002,stka003,stka004,stka005,",
                                               " stka006,stka007,stka008,stka009,stka010,",
                                               " stka011,bizhong) ",
          
                         "VALUES (?,?,?,?,?,  ?,?,?,?,?,  ?,?,0,0,?,  ?,?)"
          PREPARE ins_stka_tmp3 FROM l_ins_sql
          EXECUTE ins_stka_tmp3 USING  g_enterprise,l_prhb.prhbsite,l_prhb.prhbsite,l_rtjadocno,l_stkaseq,
                                       l_rtjadocdt,l_prhb.prhbdocno,l_prhb.prhb001,l_prhb.prhb002,l_rtja102,
                                       l_rtja101,l_rtja105,l_rtjf004,l_price,l_rtja026 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "ins_stka_tmp3:",SQLERRMESSAGE 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success1 = FALSE
             RETURN l_success1
          END IF                         
       END FOREACH
    LET l_ins_sql= " INSERT INTO stka_t (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011) ",
                   " SELECT stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011 FROM stka_tmp "
     PREPARE ins_stka3 FROM l_ins_sql
     EXECUTE ins_stka3 
     IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "EXECUTE:ins_stka3" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
        LET l_success1 = FALSE
        RETURN l_success1
     END IF
     IF NOT cl_null(l_error) THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = l_error
       LET g_errparam.code   = 'ast-00447'
       LET g_errparam.popup  = FALSE 
       CALL cl_err()
    END IF 
    IF l_success1 THEN      
       CALL astp860_ins_stkb() RETURNING l_success
       IF NOT l_success  THEN
          LET l_success1 = FALSE
          RETURN l_success1
       ELSE        
          CALL astp860_ins_stba() RETURNING l_success
          IF NOT l_success  THEN
             LET l_success1 = FALSE
             RETURN l_success1
          END IF
       END IF
    ELSE       
       LET l_success1 = FALSE
       RETURN l_success1
    END IF
    RETURN l_success1    
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
PRIVATE FUNCTION astp860_04(l_prhb)
DEFINE l_sql   STRING
DEFINE l_ins_sql   STRING
DEFINE l_sql1  STRING
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE l_rtja101     LIKE rtja_t.rtja101
DEFINE l_rtja102     LIKE rtja_t.rtja102
DEFINE l_rtja105     LIKE rtja_t.rtja105
DEFINE l_rtjf016     LIKE rtjf_t.rtjf016
DEFINE l_rtjf013     LIKE rtjf_t.rtjf013
DEFINE l_rtjf018     LIKE rtjf_t.rtjf018
DEFINE l_price       LIKE gcao_t.gcao004
DEFINE l_stka011     LIKE stka_t.stka011
DEFINE l_stkaseq     LIKE stka_t.stkaseq
DEFINE l_seq         LIKE stka_t.stkaseq
DEFINE l_stbastus     LIKE stba_t.stbastus
DEFINE l_rtjadocno   LIKE rtja_t.rtjadocno
DEFINE l_rtjadocdt   LIKE rtja_t.rtjadocdt
DEFINE l_rtjf103     LIKE rtjf_t.rtjf103
DEFINE l_rtja026     LIKE rtja_t.rtja026
DEFINE l_success1      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_gcao001      LIKE gcao_t.gcao001
DEFINE l_prhbdocno    LIKE prhb_t.prhbdocno
DEFINE l_error   string 
DEFINE l_stbadocno   LIKE stba_t.stbadocno
LET l_success1=true
LET l_error='' 
#LET l_prhbdocno=l_prhb.prhbdocno,l_prhb.prhbseq    
LET l_sql1=" SELECT rtjadocno,rtjadocdt,rtja026,rtjf103,rtja101 ,rtja102 ,rtja105,rtjf016,rtjf013,rtjf018  ",
           " FROM rtja_t,rtjf_t",
           " WHERE rtjaent=rtjfent AND rtjadocno=rtjfdocno  ",
           " AND   rtjaent=?   ",
           " AND rtjf013 = ?  AND rtjf001='40'  AND rtja000='artt621'  and ",g_wc1,
           " and rtjasite='",l_prhb.prhbsite,"'",
           " AND rtjf025 BETWEEN ?  AND ?   ",
           " AND rtjadocdt BETWEEN ?  AND ?    ",
           " ORDER BY rtjadocno  "
    PREPARE astp860_pb4_1 FROM l_sql1
    DECLARE astp860_curs4_1 CURSOR FOR astp860_pb4_1
                                                  
       FOREACH astp860_curs4_1 USING g_enterprise,l_prhb.prhb002,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004
                                INTO l_rtjadocno,l_rtjadocdt,l_rtja026,l_rtjf103,l_rtja101,l_rtja102,l_rtja105,l_rtjf016,l_rtjf013,l_rtjf018
                                
          SELECT stbastus,stbadocno INTO l_stbastus,l_stbadocno
          FROM stba_t
          WHERE stbaent=l_prhb.prhbent
            AND stba006='12'
            AND stba007=l_prhb.prhbdocno
            AND stba010=l_rtja105
             and stbadocdt=l_prhb.prhb004
             and stba027=l_prhb.prhbseq
          IF NOT cl_null(l_stbadocno) THEN 
             IF l_stbastus='Y'  THEN
                LET l_error=l_error,"|",l_stbadocno
                CONTINUE FOREACH
             ELSE
                DELETE FROM stka_t WHERE stkaent=l_prhb.prhbent AND stka002=l_prhb.prhbdocno
                                     AND stka003=l_prhb.prhb001 AND stka004=l_prhb.prhb002
                                     AND stkadocno=l_rtjadocno
                DELETE FROM stkb_t WHERE stkbent=l_prhb.prhbent AND stkbdocno=l_prhb.prhbdocno
                                     AND stkb001=l_prhb.prhb001 AND stkb002=l_prhb.prhb002
                                     AND stkb006=l_rtja105
                DELETE FROM stbb_t where stbbent=l_prhb.prhbent
                                  AND stbbdocno in (select stbadocno from stba_t 
                                  where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq) 
                DELETE FROM stba_t where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq
                  
             END IF
          END IF 
          CALL astp860_ins_tmp(l_rtjf013,l_rtjf016,l_rtjf018)
          let l_sql= " select gcao001 from astp860_tmp order by gcao001"
           PREPARE astp860_pb4_2 FROM l_sql
           DECLARE astp860_curs4_2 CURSOR FOR astp860_pb4_2
           FOREACH astp860_curs4_2  into l_gcao001
              SELECT sum(gcao004-gcao032) INTO l_price 
              FROM gcao_t 
              WHERE gcaoent=g_enterprise AND gcao001=l_gcao001                           
              IF cl_null(l_price) OR l_price=0 THEN 
                 CONTINUE FOREACH
              END IF 
              SELECT max(stkaseq) INTO l_seq FROM stka_t
              WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
              IF cl_null(l_seq) THEN
                 SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
                 WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
                 IF cl_null(l_stkaseq) THEN 
                    LET l_stkaseq=1
                 ELSE 
                    LET l_stkaseq=l_stkaseq+1
                 END IF
              ELSE 
                 SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
                 WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
                  IF cl_null(l_stkaseq) THEN 
                     LET l_stkaseq=l_seq+1
                  ELSE 
                     LET l_stkaseq=l_stkaseq+1
                  END IF
              END IF
              CALL s_curr_round('',l_rtja026,l_price,'2') RETURNING l_price               
              LET l_ins_sql=" INSERT INTO stka_tmp (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                                                   " stka001,stka002,stka003,stka004,stka005,",
                                                   " stka006,stka007,stka008,stka009,stka010,",
                                                   " stka011,bizhong) ",
              
                             "VALUES (?,?,?,?,?,  ?,?,?,?,?,  ?,?,0,0,?,  ?,?)"
              PREPARE ins_stka_tmp4 FROM l_ins_sql
              EXECUTE ins_stka_tmp4 USING  g_enterprise,l_prhb.prhbsite,l_prhb.prhbsite,l_rtjadocno,l_stkaseq,
                                           l_rtjadocdt,l_prhb.prhbdocno,l_prhb.prhb001,l_prhb.prhb002,l_rtja102,
                                           l_rtja101,l_rtja105,l_gcao001,l_price,l_rtja026
               IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "ins_stka_tmp4:",SQLERRMESSAGE 
                 LET g_errparam.code   = SQLCA.sqlcode 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 LET l_success1 = FALSE
                 RETURN l_success1
                 EXIT FOREACH
              END IF
           END FOREACH              
       END FOREACH
     LET l_ins_sql= " INSERT INTO stka_t (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011) ",
                   " SELECT stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011 FROM stka_tmp "
     PREPARE ins_stka4 FROM l_ins_sql
     EXECUTE ins_stka4 
     IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "EXECUTE:ins_stka4" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
        LET l_success1 = FALSE
        RETURN l_success1
     END IF
     IF NOT cl_null(l_error) THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = l_error
       LET g_errparam.code   = 'ast-00447'
       LET g_errparam.popup  = FALSE 
       CALL cl_err()
    END IF 
    IF l_success1 THEN      
       CALL astp860_ins_stkb() RETURNING l_success
       IF NOT l_success  THEN
          LET l_success1 = FALSE
          RETURN l_success1
       ELSE        
          CALL astp860_ins_stba() RETURNING l_success
          IF NOT l_success  THEN
             LET l_success1 = FALSE
             RETURN l_success1
          END IF
       END IF
    ELSE       
        LET l_success1 = FALSE
        RETURN l_success1
    END IF
    RETURN l_success1    
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
PRIVATE FUNCTION astp860_05(l_prhb)
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE l_price         LIKE stka_t.stka011
DEFINE l_money         LIKE stka_t.stka011
DEFINE l_sum_money         LIKE stka_t.stka011
DEFINE l_rtja101       LIKE rtja_t.rtja101
DEFINE l_rtja102       LIKE rtja_t.rtja102
DEFINE l_rtja105       LIKE rtja_t.rtja105
DEFINE l_rtja049       LIKE rtja_t.rtja049
DEFINE l_rtjf103       LIKE rtjf_t.rtjf103
DEFINE l_rtjadocno     LIKE rtja_t.rtjadocno
DEFINE l_docno     LIKE rtja_t.rtjadocno
DEFINE l_stbastus     LIKE stba_t.stbastus
DEFINE l_stkaseq       LIKE stka_t.stkaseq
DEFINE l_stka011       LIKE stka_t.stka011
DEFINE l_seq           LIKE stka_t.stkaseq
DEFINE l_sql           STRING 
DEFINE l_sql1          STRING 
DEFINE l_sql_cou          STRING 
DEFINE l_m             INT
DEFINE l_t             INT
DEFINE l_price1         LIKE rtja_t.rtja049
DEFINE l_ins_sql       STRING 
DEFINE l_success1      LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_rtjb031       LIKE rtjb_t.rtjb031
DEFINE l_prdh015       LIKE prdh_t.prdh015
DEFINE l_rtja026       LIKE rtja_t.rtja026
DEFINE l_error         STRING 
DEFINE l_stbadocno     LIKE stba_t.stbadocno
DEFINE l_prdw011       LIKE prdw_t.prdw011
DEFINE l_prdhdocno     LIKE prdh_t.prdhdocno
LET l_success1 = TRUE
LET l_error='' 
   SELECT  UNIQUE prdh015,prdw011,prdhdocno INTO l_prdh015,l_prdw011,l_prdhdocno
   FROM prdh_t 
   INNER JOIN prdw_t ON prdw001 = prdh001  
   WHERE prdhent=g_enterprise  AND prdh001=l_prhb.prhb002 
     AND prdhdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent=g_enterprise and prda001=l_prhb.prhb002  
     AND prda002=(select max(prda002) from prda_t where prdaent=g_enterprise and prda001=l_prhb.prhb002 ))
#    IF l_prdw011='Y' THEN
#       CALL s_get_price_mtype(l_prdhdocno) RETURNING l_wcc      
#    ELSE
#       LET l_wcc = '1=1'
#    END IF    
    LET l_sql= " select rtjadocno,sum(rtjb020) ",
               " from rtja_t,rtjb_t ",
               " where  rtjbent=rtjaent and rtjbdocno=rtjadocno ",
               "   and rtjaent = ",g_enterprise,
               "   and rtja000= 'aprt281' ",
               "   and rtja108= '",l_prhb.prhb002,"' " ,
               " group by rtjadocno ",
               " order by rtjadocno "
                      
   PREPARE astp860_pb5_1 FROM l_sql
   DECLARE astp860_curs5_1 CURSOR FOR astp860_pb5_1 
   
   IF l_prdh015 = '1' THEN
   	  LET l_sql1=" SELECT SUM (rtjf031) ", 
   	             " FROM rtjf_t ", 
   	             " WHERE rtjfent= ",g_enterprise, #" and ",l_wcc
   	             " AND rtjf103 IN (select prek002 FROM prek_t WHERE prekent='",g_enterprise,"' AND prekdocno= ?)  "
   	   
         
      LET l_sql=" SELECT rtjadocno,rtja101,rtja102,rtja105,rtja026,rtjf103,sum(rtjf031) ",
                   " FROM rtja_t,rtjf_t  ",
                   " WHERE rtjaent= ",g_enterprise,
                   "   and rtjfent=rtjaent AND rtjfdocno=rtjadocno",
                   "   and rtja000='artt621' and ",g_wc1,
                   "   AND rtjf103 IN (select prek002 FROM prek_t WHERE prekent= ",g_enterprise ,
                   "              AND prekdocno= ?) ",
                   "   and rtjasite='",l_prhb.prhbsite,"'",
                   "   AND rtjadocdt BETWEEN ? AND ? ",
                   "   AND rtjf025   BETWEEN ? AND ? ",
                   "   group by rtjadocno,rtja101,rtja102,rtja105,rtja026,rtjf103 ",
                   "   ORDER BY rtjadocno,rtja101,rtja102,rtja105,rtjf103 "
   ELSE 
   	  LET l_sql1=" SELECT SUM (rtja049) ", 
   	             " FROM rtja_t ", 
   	             " WHERE rtjaent= ",g_enterprise, 
   	             " AND rtjadocno IN (select distinct prek003 FROM prek_t WHERE prekent='",g_enterprise,"' AND prekdocno= ?)  "
   	            
   	  LET l_sql=" SELECT distinct rtjadocno,rtja101,rtja102,rtja105,rtja026,'',rtja049 ",
                   " FROM rtja_t  ",
                   " LEFT JOIN rtjf_t ON rtjfent=rtjaent AND rtjfdocno=rtjadocno ",
                   " WHERE rtjaent= ",g_enterprise,
                   " and rtja000='artt621' and ",g_wc1,
                   " AND rtjadocno IN (select prek003 FROM prek_t WHERE prekent= ",g_enterprise ,
                   "              AND prekdocno= ?) ",
                   " and rtjasite='",l_prhb.prhbsite,"'",
                   " AND rtjadocdt BETWEEN ? AND ? ",
                   " AND rtjf025   BETWEEN ? AND ? ",
                   " ORDER BY rtjadocno,rtja101,rtja102,rtja105 "
   END IF 
                               
   PREPARE astp860_pb5_2 FROM l_sql
   DECLARE astp860_curs5_2 CURSOR FOR astp860_pb5_2 
      
      FOREACH astp860_curs5_1  INTO l_docno,l_price 
         PREPARE astp860_cou_pb FROM l_sql1  
         EXECUTE astp860_cou_pb into l_sum_money USING l_docno
         
         let l_sql_cou= " select count(*) from (",l_sql,") " 
         PREPARE count_pb5 FROM l_sql_cou
         EXECUTE count_pb5 USING l_docno,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004 INTO l_m
         LET l_t=0
         LET l_price1=0  
         FOREACH astp860_curs5_2 USING l_docno,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004 
                                  INTO l_rtjadocno,l_rtja101,l_rtja102,l_rtja105,l_rtja026,l_rtjf103,l_money
            SELECT stbastus,stbadocno INTO l_stbastus,l_stbadocno
            FROM stba_t
            WHERE stbaent=l_prhb.prhbent
              AND stba006='12'
              AND stba007=l_prhb.prhbdocno
              AND stba010=l_rtja105
               and stbadocdt=l_prhb.prhb004
               and stba027=l_prhb.prhbseq
            IF NOT cl_null(l_stbadocno)  THEN 
               IF l_stbastus='Y'  THEN
                  LET l_error=l_error,"|",l_stbadocno
                  CONTINUE FOREACH
               ELSE
                DELETE FROM stka_t WHERE stkaent=l_prhb.prhbent AND stka002=l_prhb.prhbdocno
                                     AND stka003=l_prhb.prhb001 AND stka004=l_prhb.prhb002
                                     AND stkadocno=l_rtjadocno
                DELETE FROM stkb_t WHERE stkbent=l_prhb.prhbent AND stkbdocno=l_prhb.prhbdocno
                                     AND stkb001=l_prhb.prhb001 AND stkb002=l_prhb.prhb002
                                     AND stkb006=l_rtja105
                DELETE FROM stbb_t where stbbent=l_prhb.prhbent
                                  AND stbbdocno in (select stbadocno from stba_t 
                                  where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq) 
                DELETE FROM stba_t where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004  and stba027=l_prhb.prhbseq
                  
               END IF
            END IF 
            SELECT max(stkaseq) INTO l_seq FROM stka_t
            WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
            IF cl_null(l_seq) THEN
               SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
               WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
               IF cl_null(l_stkaseq) THEN 
                  LET l_stkaseq=1
               ELSE 
                  LET l_stkaseq=l_stkaseq+1
               END IF
            ELSE 
               SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
               WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
                IF cl_null(l_stkaseq) THEN 
                   LET l_stkaseq=l_seq+1
                ELSE 
                   LET l_stkaseq=l_stkaseq+1
                END IF
            END IF
            let l_t =l_t + 1
            IF l_t <> l_m THEN             
       	      LET l_stka011=l_money/l_sum_money*l_price
       	      CALL s_curr_round('',l_rtja026,l_stka011,'2') RETURNING l_stka011 
       	      LET l_price1=l_price1+l_stka011
       	      
       	   ELSE
       	      LET l_stka011=l_price-l_price1
       	   END IF 
            IF l_stka011=0 THEN 
               CONTINUE FOREACH
            END IF                
            LET l_ins_sql=" INSERT INTO stka_tmp (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                            " stka001,stka002,stka003,stka004,stka005,",
                            " stka006,stka007,stka008,stka009,stka010,",
                            " stka011,bizhong) ",
                     
                           "VALUES (?,?,?,?,?,  ?,?,?,?,?,  ?,?,0,0,'',  ?,?)"
                      PREPARE ins_stka_tmp5 FROM l_ins_sql
                      EXECUTE ins_stka_tmp5 USING  g_enterprise,l_prhb.prhbsite,l_prhb.prhbsite,l_rtjadocno,l_stkaseq,
                                                   l_prhb.prhb004,l_prhb.prhbdocno,l_prhb.prhb001,l_prhb.prhb002,l_rtja102,
                                                   l_rtja101,l_rtja105,l_stka011,l_rtja026
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "ins_stka_tmp1:",SQLERRMESSAGE 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         LET l_success1 = FALSE
                         RETURN l_success1
                         EXIT FOREACH
                      END IF              
         END FOREACH
      END FOREACH
    LET l_ins_sql= " INSERT INTO stka_t (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011) ",
                   " SELECT stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011 FROM stka_tmp "
    PREPARE ins_stka5 FROM l_ins_sql
    EXECUTE ins_stka5 
    IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "EXECUTE:ins_stka1" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
       LET l_success1 = FALSE
       RETURN l_success1
    END IF
    IF NOT cl_null(l_error) THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = l_error
       LET g_errparam.code   = 'ast-00447'
       LET g_errparam.popup  = FALSE 
       CALL cl_err()
    END IF 
   IF l_success1 THEN      
      CALL astp860_ins_stkb() RETURNING l_success
      IF NOT l_success  THEN
       LET l_success1 = FALSE
       RETURN l_success1
      ELSE        
         CALL astp860_ins_stba() RETURNING l_success
         IF NOT l_success  THEN
            LET l_success1 = FALSE
            RETURN l_success1
         END IF
      END IF
   ELSE       
       LET l_success1 = FALSE
       RETURN l_success1
   END IF
   RETURN l_success1
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
PRIVATE FUNCTION astp860_06(l_prhb)
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE l_price         LIKE stka_t.stka011
DEFINE l_money         LIKE stka_t.stka011
DEFINE l_rtja101       LIKE rtja_t.rtja101
DEFINE l_rtja102       LIKE rtja_t.rtja102
DEFINE l_rtja105       LIKE rtja_t.rtja105
DEFINE l_rtja049       LIKE rtja_t.rtja049
DEFINE l_rtjf103       LIKE rtjf_t.rtjf103
DEFINE l_rtjadocno     LIKE rtja_t.rtjadocno
DEFINE l_docno     LIKE rtja_t.rtjadocno
DEFINE l_stbastus     LIKE stba_t.stbastus
DEFINE l_stkaseq       LIKE stka_t.stkaseq
DEFINE l_stka011       LIKE stka_t.stka011
DEFINE l_seq           LIKE stka_t.stkaseq
DEFINE l_sql           STRING 
DEFINE l_sql1          STRING 
DEFINE l_m             INT
DEFINE l_t             INT
DEFINE l_price1         LIKE rtja_t.rtja049
DEFINE l_ins_sql       STRING 
DEFINE l_success1      LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_rtjb031       LIKE rtjb_t.rtjb031
DEFINE l_rtja026       LIKE rtja_t.rtja026
DEFINE l_error         STRING 
DEFINE l_stbadocno     LIKE stba_t.stbadocno
LET l_success1 = TRUE
LET l_error=''    
LET l_sql=" SELECT DISTINCT rtjadocno,sum(rtjc013)",
             " FROM rtja_t,rtjc_t  ",
             " where rtjcent=rtjaent AND rtjcdocno=rtjadocno",
             " and rtjaent= ",g_enterprise,
             " and rtja000='aprt280' ",
             " AND rtjc003 = ? ",
             " group by rtjadocno ",
             " ORDER BY rtjadocno "
                         
   PREPARE astp860_pb6_1 FROM l_sql
   DECLARE astp860_curs6_1 CURSOR FOR astp860_pb6_1 
   
LET l_sql=" SELECT rtjadocno,rtja101,rtja102,rtja105,rtja049.rtja026 ",
             " FROM rtja_t,rtjf_t  ",
             " where  rtjfent=rtjaent AND rtjfdocno=rtjadocno ",
             " and  rtjaent= ",g_enterprise,
             " and rtja000='artt621' and ",g_wc1,
             " AND rtjadocno IN (select prek003 FROM prek_t WHERE prekent= ",g_enterprise ,
             "              AND prekdocno= ?) ",
             " and rtjasite='",l_prhb.prhbsite,"'",
             " AND rtjadocdt BETWEEN ? AND ? ",
             " AND rtjf025   BETWEEN ? AND ? ",
             " ORDER BY rtjadocno "
                         
   PREPARE astp860_pb6_2 FROM l_sql
   DECLARE astp860_curs6_2 CURSOR FOR astp860_pb6_2 
      
      FOREACH astp860_curs6_1 USING l_prhb.prhb002  INTO l_docno,l_price 
      
         SELECT sum(rtja049) INTO l_rtja049
         FROM rtja_t 
         WHERE rtjaent=g_enterprise
           AND rtjadocdt between l_prhb.prhb003 and l_prhb.prhb004
           AND rtjadocno IN (select prek003 FROM prek_t WHERE prekent=g_enterprise 
                           AND prekdocno=l_docno)
                           
         let l_sql1= " select count(*) from (",l_sql,") " 
         PREPARE count_pb FROM l_sql1
         EXECUTE count_pb USING l_docno,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004 INTO l_m
         let l_t=0
         LET l_price1=0           
         FOREACH astp860_curs6_2 USING l_docno,l_prhb.prhb003,l_prhb.prhb004,l_prhb.prhb003,l_prhb.prhb004 
                                  INTO l_rtjadocno,l_rtja101,l_rtja102,l_rtja105,l_money,l_rtja026
            SELECT stbastus,stbadocno INTO l_stbastus,l_stbadocno
            FROM stba_t
            WHERE stbaent=l_prhb.prhbent
              AND stba006='12'
              AND stba007=l_prhb.prhbdocno
              AND stba010=l_rtja105
              and stbadocdt=l_prhb.prhb004
              and stba027=l_prhb.prhbseq
            IF NOT cl_null(l_stbadocno) THEN 
               IF l_stbastus='Y'  THEN
                  LET l_error=l_error,"|",l_stbadocno
                  CONTINUE FOREACH
               ELSE
               
                DELETE FROM stka_t WHERE stkaent=l_prhb.prhbent AND stka002=l_prhb.prhbdocno
                                     AND stka003=l_prhb.prhb001 AND stka004=l_prhb.prhb002
                                     AND stkadocno=l_rtjadocno
                DELETE FROM stkb_t WHERE stkbent=l_prhb.prhbent AND stkbdocno=l_prhb.prhbdocno
                                     AND stkb001=l_prhb.prhb001 AND stkb002=l_prhb.prhb002
                                     AND stkb006=l_rtja105
                DELETE FROM stbb_t where stbbent=l_prhb.prhbent
                                  AND stbbdocno in (select stbadocno from stba_t 
                                  where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq) 
                DELETE FROM stba_t where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq 
               END IF
            END IF 
            SELECT max(stkaseq) INTO l_seq FROM stka_t
            WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
            IF cl_null(l_seq) THEN
               SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
               WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
               IF cl_null(l_stkaseq) THEN 
                  LET l_stkaseq=1
               ELSE 
                  LET l_stkaseq=l_stkaseq+1
               END IF
            ELSE 
               SELECT max(stkaseq) INTO l_stkaseq FROM stka_tmp
               WHERE stkadocno=l_rtjadocno AND stkaent=g_enterprise
                IF cl_null(l_stkaseq) THEN 
                   LET l_stkaseq=l_seq+1
                ELSE 
                   LET l_stkaseq=l_stkaseq+1
                END IF
            END IF
            let l_t =l_t + 1
            IF l_t <> l_m THEN             
       	      LET l_stka011=l_money/l_rtja049*l_price
       	      LET l_price1=l_price1+l_stka011
       	   ELSE
       	      LET l_stka011=l_price-l_price1
       	   END IF 
                   	      
            LET l_ins_sql=" INSERT INTO stka_tmp (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                            " stka001,stka002,stka003,stka004,stka005,",
                            " stka006,stka007,stka008,stka009,stka010,",
                            " stka011,bizhong) ",
                     
                           "VALUES (?,?,?,?,?,  ?,?,?,?,?,  ?,?,0,0,'',  ?,?)"
                      PREPARE ins_stka_tmp6 FROM l_ins_sql
                      EXECUTE ins_stka_tmp6 USING  g_enterprise,l_prhb.prhbsite,l_prhb.prhbsite,l_rtjadocno,l_stkaseq,
                                                   l_prhb.prhb004,l_prhb.prhbdocno,l_prhb.prhb001,l_prhb.prhb002,l_rtja102,
                                                   l_rtja101,l_rtja105,l_stka011,l_rtja026
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "ins_stka_tmp1:",SQLERRMESSAGE 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         LET l_success1 = FALSE
                         RETURN l_success1
                         EXIT FOREACH
                      END IF              
         END FOREACH
      END FOREACH
    LET l_ins_sql= " INSERT INTO stka_t (stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011) ",
                   " SELECT stkaent,stkaunit,stkasite,stkadocno,stkaseq,",
                   " stka001,stka002,stka003,stka004,stka005,",
                   " stka006,stka007,stka008,stka009,stka010,",
                   " stka011 FROM stka_tmp "
    PREPARE ins_stka6 FROM l_ins_sql
    EXECUTE ins_stka6 
    IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "EXECUTE:ins_stka1" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
       LET l_success1 = FALSE
       RETURN l_success1
    END IF
    IF NOT cl_null(l_error) THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = l_error
       LET g_errparam.code   = 'ast-00447'
       LET g_errparam.popup  = FALSE 
       CALL cl_err()
    END IF 
   IF l_success1 THEN      
      CALL astp860_ins_stkb() RETURNING l_success
      IF NOT l_success  THEN
       LET l_success1 = FALSE
       RETURN l_success1
      ELSE        
         CALL astp860_ins_stba() RETURNING l_success
         IF NOT l_success  THEN
            LET l_success1 = FALSE
            RETURN l_success1
         END IF
      END IF
   ELSE       
       LET l_success1 = FALSE
       RETURN l_success1
   END IF
   RETURN l_success1
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
PRIVATE FUNCTION astp860_07(l_prhb)
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE l_price  LIKE stka_t.stka011
DEFINE l_price1  LIKE stka_t.stka011
DEFINE l_rtja101  LIKE rtja_t.rtja101
DEFINE l_rtja102  LIKE rtja_t.rtja102
DEFINE l_rtja105  LIKE rtja_t.rtja105
DEFINE l_rtja026     LIKE rtja_t.rtja026
DEFINE l_rtjadocno LIKE rtja_t.rtjadocno
DEFINE l_year   varchar(5)
DEFINE l_month  varchar(5)
DEFINE l_stbastus     LIKE stba_t.stbastus
DEFINE l_stkb015 LIKE stkb_t.stkb015
DEFINE l_stkb016 LIKE stkb_t.stkb016
DEFINE l_stkbseq LIKE stkb_t.stkbseq
DEFINE l_prhbdocno  LIKE prhb_t.prhbdocno
DEFINE l_seq LIKE stkb_t.stkbseq
DEFINE l_sql     STRING 
DEFINE l_ins_sql  STRING 
DEFINE l_stjn006_sum  LIKE stjn_t.stjn006
DEFINE l_stkb016_max  LIKE stkb_t.stkb016
DEFINE l_success1      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_cnt          INT
DEFINE l_error         STRING 
DEFINE l_stbadocno     LIKE stba_t.stbadocno
LET l_success1=TRUE
LET l_error='' 
#let l_prhbdocno=l_prhb.prhbdocno,l_prhb.prhbseq   
LET l_sql=" SELECT rtja101,rtja102,rtja105,rtja026,SUM(rtja049) ",
             " FROM rtja_t ",
             " WHERE  rtjaent= ",g_enterprise,
             " and rtjasite='",l_prhb.prhbsite,"'",
             " AND rtja000='artt621'  and ",g_wc1,
             " AND rtjadocdt BETWEEN ? AND ? ",
            # " AND rtjf025   BETWEEN ? AND ? ",
             " GROUP BY rtja101,rtja102,rtja105,rtja026 "
                         
   PREPARE astp860_pb7_1 FROM l_sql
   DECLARE astp860_curs7_1 CURSOR FOR astp860_pb7_1 
      
      FOREACH astp860_curs7_1 USING l_prhb.prhb003,l_prhb.prhb004
                                 INTO l_rtja101,l_rtja102,l_rtja105,l_rtja026,l_price
         SELECT stbastus,stbadocno INTO l_stbastus,l_stbadocno
         FROM stba_t
         WHERE stbaent=l_prhb.prhbent
           AND stba006='12'
           AND stba007=l_prhb.prhbdocno
           AND stba010=l_rtja105
            and stbadocdt=l_prhb.prhb004
        IF NOT cl_null(l_stbadocno) THEN 
           IF l_stbastus='Y'  THEN
              LET l_error=l_error,"|",l_stbadocno
              CONTINUE FOREACH
           ELSE
                DELETE FROM stkb_t WHERE stkbent=l_prhb.prhbent AND stkbdocno=l_prhb.prhbdocno
                                     AND stkb001=l_prhb.prhb001 
                                     AND stkb006=l_rtja105
               DELETE FROM stbb_t where stbbent=l_prhb.prhbent
                                  AND stbbdocno in (select stbadocno from stba_t 
                                  where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq) 
               DELETE FROM stba_t where stbaent=l_prhb.prhbent AND stba006='12' 
                                  AND stba007=l_prhb.prhbdocno AND stba010=l_rtja105
                                  AND stbadocdt=l_prhb.prhb004 and stba027=l_prhb.prhbseq
           END IF
        END IF 
        IF l_price =0 THEN 
           CONTINUE FOREACH
        END IF 
        SELECT max(stkbseq) INTO l_seq FROM stkb_t
        WHERE stkbdocno=l_prhb.prhbdocno AND stkbent=g_enterprise
         IF cl_null(l_seq) THEN
            SELECT max(stkbseq) INTO l_stkbseq FROM stkb_tmp
            WHERE stkbdocno=l_prhb.prhbdocno AND stkbent=g_enterprise
            IF cl_null(l_stkbseq) THEN          
               LET l_stkbseq=1
            ELSE 
               LET l_stkbseq=l_stkbseq+1
            END IF 
         ELSE
            SELECT max(stkbseq) INTO l_stkbseq FROM stkb_tmp
            WHERE stkbdocno=l_prhb.prhbdocno AND stkbent=g_enterprise     
            IF cl_null(l_stkbseq) THEN
               LET l_stkbseq=l_seq+1
            ELSE
               LET l_stkbseq=l_stkbseq+1
            END IF
         END IF          
         #LET l_year=YEAR(l_prhb.prhb004)
         #LET l_month=MONTH(l_prhb.prhb004)
         #LET l_sql=" SELECT SUM(stjn006)  FROM stjn_t WHERE stjnent= ",g_enterprise, 
        #         " AND stjn001='",l_rtja105,"'  AND  to_char(stjn002,'yyyy')=",l_year,
        #         "  AND to_char(stjn002,'mm')=",l_month,
        #         "  AND stjn005='10001' "
         #PREPARE astp860_stjn_pb7 FROM l_sql  
        # EXECUTE astp860_stjn_pb7 INTO l_stjn006_sum
         #LET l_stkb016_max=l_stjn006_sum * l_prhb.prhb007 * (l_prhb.prhb006/100)   ##商场承担的最大金额
         IF l_prhb.prhb008='1' THEN
         	  #LET l_price1=l_price-l_prhb.prhb009         ##按比例商场应该承担的金额
         	  LET l_stkb015=l_prhb.prhb009
         	  let l_stkb016=0
         ELSE
         	  LET l_stkb015=l_price*(l_prhb.prhb009/100)
         	  let l_stkb016=0
         END IF 
#         IF l_stkb016_max<l_price1	THEN        ##如果商场承担的最大的金额小于算出来的金额，多于的部分由商户自己承担 
#            LET l_stkb016=l_stkb016_max
#            LET l_stkb015=l_price-l_stkb016
#         ELSE
#         	  LET l_stkb015=l_stkb015
#         	  LET l_stkb016=l_price-l_stkb015
#         END IF 
        
          CALL s_curr_round('',l_rtja026,l_stkb015,'2') RETURNING l_stkb015 
          CALL s_curr_round('',l_rtja026,l_stkb016,'2') RETURNING l_stkb016
         LET l_ins_sql=" INSERT INTO stkb_tmp (stkbent,stkbsite,stkbunit,stkbdocno,stkbseq,",
                       " stkb001,stkb002,stkb003,stkb004,stkb005,",
                       " stkb006,stkb007,stkb008,stkb009,stkb010,",
                       " stkb011,stkb012,stkb013,stkb014,stkb015,",
                       " stkb016) ",
                
                      "VALUES (?,?,?,?,?, ?,?,?,?,?, ?,0,0,'',?, ?,?,?,?,?,?)"
                 PREPARE ins_stkb_tmp FROM l_ins_sql
                 EXECUTE ins_stkb_tmp USING  g_enterprise,l_prhb.prhbsite,l_prhb.prhbsite,l_prhb.prhbdocno,l_stkbseq,
                                             l_prhb.prhb001,l_prhb.prhb002,l_prhb.prhb004,l_rtja102,l_rtja101,
                                             l_rtja105,l_price,
                                             l_prhb.prhb005,l_prhb.prhb007,l_prhb.prhb006,l_prhb.prhb009,l_stkb015,
                                             l_stkb016
                  IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stkb_tmp:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success1 = FALSE
                  RETURN l_success1
               END IF              
         END FOREACH
     LET l_ins_sql= " INSERT INTO stkb_t SELECT * FROM stkb_tmp "
     PREPARE ins_stkb7 FROM l_ins_sql
     EXECUTE ins_stkb7 
     IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "EXECUTE:ins_stkb7" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
        LET l_success1 = FALSE
        RETURN l_success1
     END IF
     IF NOT cl_null(l_error) THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = l_error
       LET g_errparam.code   = 'ast-00447'
       LET g_errparam.popup  = FALSE 
       CALL cl_err()
    END IF 
     IF l_success1 THEN      
        CALL astp860_ins_stba() RETURNING l_success
        IF NOT l_success  THEN
           LET l_success1 = FALSE
           RETURN l_success1
        END IF
     ELSE       
       LET l_success1 = FALSE
       RETURN l_success1
    END IF 
    RETURN l_success1
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
PRIVATE FUNCTION astp860_ins_tmp(l_rtjf013,l_rtjf016,l_rtjf018)
DEFINE l_seq      int
DEFINE l_sql      string 
DEFINE i          INT 
DEFINE l_m         INT 
DEFINE l_gcaf009  LIKE gcaf_t.gcaf009
DEFINE l_gcaf006  LIKE gcaf_t.gcaf006
DEFINE l_gcaf007  LIKE gcaf_t.gcaf007
DEFINE l_gcaf008  LIKE gcaf_t.gcaf008
DEFINE l_rtjf016  LIKE rtjf_t.rtjf016
DEFINE l_rtjf013  LIKE rtjf_t.rtjf013
DEFINE l_rtjf018  LIKE rtjf_t.rtjf018
DELETE FROM astp860_tmp
select gcaf006,gcaf007,gcaf008,gcaf009 into l_gcaf006,l_gcaf007,l_gcaf008,l_gcaf009
from gcaf_t 
where gcaf001=l_rtjf013
  and gcafent=g_enterprise
LET l_sql="SELECT lpad(lpad(substr('",l_rtjf016,"', ",l_gcaf007,"+1, ",l_gcaf006,") + LEVEL - 1,",l_gcaf009,",0),",l_gcaf006,",'",l_gcaf008,"') FROM dual", 
          " CONNECT BY LEVEL <= ",l_rtjf018," "
LET l_sql="INSERT INTO astp860_tmp ",l_sql
    PREPARE astp860_ins_tmp FROM l_sql  
    EXECUTE astp860_ins_tmp
IF SQLCA.sqlcode THEN
   INITIALIZE g_errparam TO NULL 
   LET g_errparam.extend = "astp860_tmp:",SQLERRMESSAGE 
   LET g_errparam.code   = SQLCA.sqlcode 
   LET g_errparam.popup  = TRUE 
   CALL cl_err()
END IF
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
PRIVATE FUNCTION astp860(p_wc,p_date)
#DEFINE l_prhb   RECORD LIKE prhb_t.*  #161111-00028#3--MARK
#161111-00028#3---add--begin---------
DEFINE l_prhb RECORD  #促銷協議明細檔
       prhbdocno LIKE prhb_t.prhbdocno, #單號
       prhbseq LIKE prhb_t.prhbseq, #項次
       prhb001 LIKE prhb_t.prhb001, #促銷類型
       prhb002 LIKE prhb_t.prhb002, #規則編號
       prhb003 LIKE prhb_t.prhb003, #促銷開始日期
       prhb004 LIKE prhb_t.prhb004, #促銷結束日期
       prhb005 LIKE prhb_t.prhb005, #商戶承擔費用編碼
       prhb006 LIKE prhb_t.prhb006, #費用臨界值比率
       prhb007 LIKE prhb_t.prhb007, #場租倍數
       prhb008 LIKE prhb_t.prhb008, #商戶承擔方式
       prhb009 LIKE prhb_t.prhb009, #商戶承擔比例/金額
       prhb010 LIKE prhb_t.prhb010, #備註
       prhbent LIKE prhb_t.prhbent, #企業編號
       prhbsite LIKE prhb_t.prhbsite, #營運據點
       prhbunit LIKE prhb_t.prhbunit, #應用組織
       prhbownid LIKE prhb_t.prhbownid, #資料所屬者
       prhbowndp LIKE prhb_t.prhbowndp, #資料所屬部門
       prhbcrtid LIKE prhb_t.prhbcrtid, #
       prhbcrtdp LIKE prhb_t.prhbcrtdp, #
       prhbcrtdt LIKE prhb_t.prhbcrtdt, #資料創建日
       prhbmodid LIKE prhb_t.prhbmodid, #
       prhbmoddt LIKE prhb_t.prhbmoddt, #
       prhbcnfid LIKE prhb_t.prhbcnfid, #
       prhbcnfdt LIKE prhb_t.prhbcnfdt, #
       prhbpstid LIKE prhb_t.prhbpstid, #資料過帳者
       prhbpstdt LIKE prhb_t.prhbpstdt, #資料過帳日
       prhbstus LIKE prhb_t.prhbstus    #狀態碼
       END RECORD
#161111-00028#3---add--end-----------
DEFINE p_wc     STRING 
DEFINE p_date   date
DEFINE l_sql    STRING
DEFINE r_success      LIKE type_t.num5 
DEFINE l_where     STRING    #161024-00025#6--ADD

CALL s_transaction_begin() 
CALL cl_err_collect_init() 

#161024-00025#6--ADD----BEGIN--------------
CALL s_aooi500_sql_where(g_prog,'prhasite') RETURNING l_where
LET p_wc=p_wc," AND ",l_where
#161024-00025#6--ADD----END----------------
   
   
 #LET l_sql=" SELECT prhb_t.*  ",  #161111-00028#3--mark
 #161111-00028#3--add--begin----------
  LET l_sql=" SELECT prhbdocno,prhbseq,prhb001,prhb002,prhb003,prhb004,prhb005,prhb006,prhb007,",
            "prhb008,prhb009,prhb010,prhbent,prhbsite,prhbunit,prhbownid,prhbowndp,prhbcrtid,",
            "prhbcrtdp,prhbcrtdt,prhbmodid,prhbmoddt,prhbcnfid,prhbcnfdt,prhbpstid,prhbpstdt,prhbstus",
 #161111-00028#3--add--end------------
             " FROM prhb_t,prha_t ",
             " WHERE prhbent = ",g_enterprise,
             " AND prhaent =prhbent AND prhadocno=prhbdocno AND prhastus='Y' ",
             "   AND prhb004 = '",p_date,"' AND ",p_wc,
             " ORDER BY prhbdocno "     
   PREPARE astp860_pbz FROM l_sql
   DECLARE astp860_cursz CURSOR FOR astp860_pbz
   FOREACH astp860_cursz INTO l_prhb.* 
      CASE 
         WHEN l_prhb.prhb001 MATCHES '[12]'
              CALL astp860_01(l_prhb.*) returning r_success
              IF NOT r_success THEN 
                 EXIT FOREACH
              END IF         
         WHEN l_prhb.prhb001 = "3"
              CALL astp860_03(l_prhb.*) returning r_success
              IF NOT r_success THEN 
                 EXIT FOREACH
              END IF
         WHEN l_prhb.prhb001 = "4"
              CALL astp860_04(l_prhb.*) returning r_success
              IF NOT r_success THEN 
                 EXIT FOREACH
              END IF
         WHEN l_prhb.prhb001 = "5"
              CALL astp860_05(l_prhb.*) returning r_success
              IF NOT r_success THEN 
                 EXIT FOREACH
              END IF
         WHEN l_prhb.prhb001 = "6"
              CALL astp860_06(l_prhb.*) returning r_success
              IF NOT r_success THEN 
                 EXIT FOREACH
              END IF
         WHEN l_prhb.prhb001 = "7"
              CALL astp860_07(l_prhb.*) returning r_success
              IF NOT r_success THEN 
                 EXIT FOREACH
              END IF
      END CASE
      DELETE FROM stka_tmp
      DELETE FROM stkb_tmp
   END FOREACH
      IF NOT r_success THEN 
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN FALSE
       ELSE
         CALL s_transaction_end('N','0')
         CALL s_transaction_end('Y','0')
         RETURN TRUE
       END IF 
END FUNCTION

#end add-point
 
{</section>}
 
