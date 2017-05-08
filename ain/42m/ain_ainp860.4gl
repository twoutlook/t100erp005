#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp860.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2014-12-19 16:01:49), PR版次:0013(2016-11-24 15:54:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000109
#+ Filename...: ainp860
#+ Description: 盤點標籤重新計算作業
#+ Creator....: 01534(2014-07-08 09:24:33)
#+ Modifier...: 01534 -SD/PR- 06137
 
{</section>}
 
{<section id="ainp860.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151229-00017#1  15/12/29 by Sarah   抓取在製工單時應過濾sfaa065='0'
#151229-00017#2  15/12/30 by Sarah   在製工單重計產生盤點標籤時會出現錯誤訊息inpf_t+std-00009
#160321-00006#1  16/04/20 By lixh    回写aint820库存重计日
#160517-00029#2  16/05/26 By earl    新增條碼盤點標籤功能
#160512-00004#1  16/06/20 By Whitney inai012製造日期改抓inae010
#161104-00002#3  16/11/04 By 06137   調整系統*寫法
#161123-00042#3  161124 By 06137  161104-00002 星號寫法, 應補上自定義欄位
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
       inpadocno LIKE inpa_t.inpadocno, 
   inpa002 LIKE inpa_t.inpa002, 
   inpa002_desc LIKE type_t.chr80, 
   inpadocno_desc LIKE type_t.chr80, 
   date01 LIKE type_t.dat, 
   stock LIKE type_t.chr1, 
   blank1 LIKE type_t.chr1, 
   number1 LIKE type_t.num10, 
   work LIKE type_t.chr1, 
   blank2 LIKE type_t.chr1, 
   number2 LIKE type_t.num10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_t type_master
DEFINE g_sql1            STRING
DEFINE g_sql2            STRING
DEFINE g_sql3            STRING
DEFINE g_sql4            STRING
DEFINE g_stagecomplete   LIKE type_t.num5
DEFINE g_count           LIKE type_t.num5
DEFINE g_count2          LIKE type_t.num5
DEFINE l_ac              LIKE type_t.num5
DEFINE b_date            LIKE inpd_t.inpd017 
DEFINE g_datetime        DATETIME YEAR TO SECOND  #160517-00029#2  16/05/26  By earl add

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp860.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ainp860_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp860 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainp860_init()
 
      #進入選單 Menu (="N")
      CALL ainp860_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp860
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp860.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainp860_init()
 
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
   LET g_master.date01 = g_today
   DISPLAY g_master.date01 TO date01
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp860.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp860_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      LET g_errshow = 1
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.inpadocno,g_master.stock,g_master.blank1,g_master.number1,g_master.work, 
             g_master.blank2,g_master.number2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.stock = 'N'
               LET g_master.blank1 = 'N'
               LET g_master.work = 'N'
               LET g_master.blank2 = 'N'
               LET g_master.number1 = ''
               LET g_master.number2 = ''
               CALL ainp860_set_entry()
               CALL ainp860_set_no_required()
               CALL ainp860_set_required()                 
               CALL ainp860_set_no_entry()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpadocno
            
            #add-point:AFTER FIELD inpadocno name="input.a.inpadocno"
               CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc
               IF NOT cl_null(g_master.inpadocno) THEN 

                  INITIALIZE g_chkparam.* TO NULL
               
                  LET g_chkparam.arg1 = g_master.inpadocno
                  
                  IF cl_chk_exist("v_inpadocno") THEN
                  ELSE
                     LET g_master.inpadocno = g_master_t.inpadocno
                     CALL ainp860_inpa002_desc()
                     NEXT FIELD inpadocno
                  END IF 
                  #未過賬
                  SELECT COUNT(*) INTO l_cnt FROM inpd_t
                   WHERE inpdent = g_enterprise
                     AND inpdsite = g_site
                     AND inpd008 = g_master.inpadocno
                     AND inpdstus = 'S'
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ain-00303"
                     LET g_errparam.extend = "inpd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()    
                     LET g_master.inpadocno = g_master_t.inpadocno                           
                     NEXT FIELD inpadocno
                  END IF                  
                  CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc                  
                  CALL ainp860_inpa002_desc()
               ELSE 
                  LET g_master.inpa002 = ''
                  LET g_master.inpa002_desc = ''                     
               END IF
               CALL ainp860_set_entry()
               CALL ainp860_set_no_required()
               CALL ainp860_set_required()
               CALL ainp860_set_no_entry()               
               NEXT FIELD stock
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpadocno
            #add-point:BEFORE FIELD inpadocno name="input.b.inpadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpadocno
            #add-point:ON CHANGE inpadocno name="input.g.inpadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stock
            #add-point:BEFORE FIELD stock name="input.b.stock"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stock
            
            #add-point:AFTER FIELD stock name="input.a.stock"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stock
            #add-point:ON CHANGE stock name="input.g.stock"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD blank1
            #add-point:BEFORE FIELD blank1 name="input.b.blank1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD blank1
            
            #add-point:AFTER FIELD blank1 name="input.a.blank1"
            CALL ainp860_set_entry()
            CALL ainp860_set_no_required()
            CALL ainp860_set_required()            
            CALL ainp860_set_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE blank1
            #add-point:ON CHANGE blank1 name="input.g.blank1"
            CALL ainp860_set_entry()
            CALL ainp860_set_no_required()
            CALL ainp860_set_required()            
            CALL ainp860_set_no_entry()
            IF g_master.blank1 = 'N' THEN 
               LET g_master.number1 = ''
               DISPLAY g_master.number1 TO number1
            END IF            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.number1,"0","1","","","azz-00079",1) THEN
               NEXT FIELD number1
            END IF 
 
 
 
            #add-point:AFTER FIELD number1 name="input.a.number1"
            IF NOT cl_null(g_master.number1) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD number1
            #add-point:BEFORE FIELD number1 name="input.b.number1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE number1
            #add-point:ON CHANGE number1 name="input.g.number1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD work
            #add-point:BEFORE FIELD work name="input.b.work"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD work
            
            #add-point:AFTER FIELD work name="input.a.work"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE work
            #add-point:ON CHANGE work name="input.g.work"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD blank2
            #add-point:BEFORE FIELD blank2 name="input.b.blank2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD blank2
            
            #add-point:AFTER FIELD blank2 name="input.a.blank2"
            CALL ainp860_set_entry()
            CALL ainp860_set_no_required()
            CALL ainp860_set_required()            
            CALL ainp860_set_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE blank2
            #add-point:ON CHANGE blank2 name="input.g.blank2"
            CALL ainp860_set_entry()
            CALL ainp860_set_no_required()
            CALL ainp860_set_required()            
            CALL ainp860_set_no_entry()
            IF g_master.blank2 = 'N' THEN 
               LET g_master.number2 = ''
               DISPLAY g_master.number2 TO number2
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.number2,"0","1","","","azz-00079",1) THEN
               NEXT FIELD number2
            END IF 
 
 
 
            #add-point:AFTER FIELD number2 name="input.a.number2"
            IF NOT cl_null(g_master.number2) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD number2
            #add-point:BEFORE FIELD number2 name="input.b.number2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE number2
            #add-point:ON CHANGE number2 name="input.g.number2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.inpadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpadocno
            #add-point:ON ACTION controlp INFIELD inpadocno name="input.c.inpadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.inpadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inpadocno_3()                                #呼叫開窗

            LET g_master.inpadocno = g_qryparam.return1              

            DISPLAY g_master.inpadocno TO inpadocno              #

            NEXT FIELD inpadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stock
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stock
            #add-point:ON ACTION controlp INFIELD stock name="input.c.stock"
            
            #END add-point
 
 
         #Ctrlp:input.c.blank1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD blank1
            #add-point:ON ACTION controlp INFIELD blank1 name="input.c.blank1"
            
            #END add-point
 
 
         #Ctrlp:input.c.number1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD number1
            #add-point:ON ACTION controlp INFIELD number1 name="input.c.number1"
            
            #END add-point
 
 
         #Ctrlp:input.c.work
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD work
            #add-point:ON ACTION controlp INFIELD work name="input.c.work"
            
            #END add-point
 
 
         #Ctrlp:input.c.blank2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD blank2
            #add-point:ON ACTION controlp INFIELD blank2 name="input.c.blank2"
            
            #END add-point
 
 
         #Ctrlp:input.c.number2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD number2
            #add-point:ON ACTION controlp INFIELD number2 name="input.c.number2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
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
            CALL ainp860_get_buffer(l_dialog)
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
         CALL ainp860_init()
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
                 CALL ainp860_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainp860_transfer_argv(ls_js)
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
 
{<section id="ainp860.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainp860_transfer_argv(ls_js)
 
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
 
{<section id="ainp860.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainp860_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1
   #DEFINE l_inpa      RECORD LIKE inpa_t.*    #161104-00002#3 Mark By Ken 161105
   #161104-00002#3 Add By Ken 161105(S)
DEFINE l_inpa RECORD  #盤點計劃單頭檔
       inpaent LIKE inpa_t.inpaent, #企業編號
       inpasite LIKE inpa_t.inpasite, #營運據點
       inpadocno LIKE inpa_t.inpadocno, #計劃單號
       inpadocdt LIKE inpa_t.inpadocdt, #輸入日期
       inpa001 LIKE inpa_t.inpa001, #盤點類型
       inpa002 LIKE inpa_t.inpa002, #計劃人員
       inpa003 LIKE inpa_t.inpa003, #計劃部門
       inpa004 LIKE inpa_t.inpa004, #總負責人
       inpa005 LIKE inpa_t.inpa005, #存貨預計凍結日
       inpa006 LIKE inpa_t.inpa006, #存貨實際凍結日
       inpa007 LIKE inpa_t.inpa007, #備註
       inpa008 LIKE inpa_t.inpa008, #盤點輸入方式
       inpa009 LIKE inpa_t.inpa009, #現有庫存初盤一
       inpa010 LIKE inpa_t.inpa010, #現有庫存初盤二
       inpa011 LIKE inpa_t.inpa011, #現有庫存複盤一
       inpa012 LIKE inpa_t.inpa012, #現有庫存複盤二
       inpa013 LIKE inpa_t.inpa013, #在製工單初盤一
       inpa014 LIKE inpa_t.inpa014, #在製工單初盤二
       inpa015 LIKE inpa_t.inpa015, #在製工單複盤一
       inpa016 LIKE inpa_t.inpa016, #在製工單複盤二
       inpa017 LIKE inpa_t.inpa017, #包含已無庫存量
       inpa018 LIKE inpa_t.inpa018, #存貨盤點單別
       inpa019 LIKE inpa_t.inpa019, #存貨空白單別
       inpa020 LIKE inpa_t.inpa020, #產生方式
       inpa021 LIKE inpa_t.inpa021, #在製盤點單別
       inpa022 LIKE inpa_t.inpa022, #在製空白單別
       inpa023 LIKE inpa_t.inpa023, #盤點列印方式
       inpa024 LIKE inpa_t.inpa024, #顯示帳上庫存數
       inpa025 LIKE inpa_t.inpa025, #存貨排序一
       inpa026 LIKE inpa_t.inpa026, #存貨排序二
       inpa027 LIKE inpa_t.inpa027, #存貨排序三
       inpa028 LIKE inpa_t.inpa028, #存貨排序四
       inpa029 LIKE inpa_t.inpa029, #存貨排序五
       inpa030 LIKE inpa_t.inpa030, #存貨排序六
       inpa031 LIKE inpa_t.inpa031, #分群碼選項
       inpa032 LIKE inpa_t.inpa032, #在製排序一
       inpa033 LIKE inpa_t.inpa033, #在製排序二
       inpa034 LIKE inpa_t.inpa034, #在製排序三
       inpa035 LIKE inpa_t.inpa035, #在製排序四
       inpa036 LIKE inpa_t.inpa036, #在製排序五
       inpa037 LIKE inpa_t.inpa037, #在製排序六
       inpa038 LIKE inpa_t.inpa038, #開始日期
       inpa039 LIKE inpa_t.inpa039, #截止日期
       inpa050 LIKE inpa_t.inpa050, #盤點雜收單別
       inpa051 LIKE inpa_t.inpa051, #盤點雜發單別
       inpa052 LIKE inpa_t.inpa052, #盤點發料單別
       inpa053 LIKE inpa_t.inpa053, #盤點退料單別
       inpa054 LIKE inpa_t.inpa054, #盤點超領單別
       inpaownid LIKE inpa_t.inpaownid, #資料所有者
       inpaowndp LIKE inpa_t.inpaowndp, #資料所屬部門
       inpacrtid LIKE inpa_t.inpacrtid, #資料建立者
       inpacrtdp LIKE inpa_t.inpacrtdp, #資料建立部門
       inpacrtdt LIKE inpa_t.inpacrtdt, #資料創建日
       inpamodid LIKE inpa_t.inpamodid, #資料修改者
       inpamoddt LIKE inpa_t.inpamoddt, #最近修改日
       inpacnfid LIKE inpa_t.inpacnfid, #資料確認者
       inpacnfdt LIKE inpa_t.inpacnfdt, #資料確認日
       inpapstid LIKE inpa_t.inpapstid, #資料過帳者
       inpapstdt LIKE inpa_t.inpapstdt, #資料過帳日
       inpastus LIKE inpa_t.inpastus, #狀態碼
       inpa040 LIKE inpa_t.inpa040, #盤點日期
       inpa041 LIKE inpa_t.inpa041, #最近重計日
       inpa042 LIKE inpa_t.inpa042, #在製盤差處理倉
       inpa043 LIKE inpa_t.inpa043,  #在製盤差處理儲位
       #161123-00042#3 Add By Ken 161124(S)
       inpaud001 LIKE inpa_t.inpaud001, #自定義欄位(文字)001
       inpaud002 LIKE inpa_t.inpaud002, #自定義欄位(文字)002
       inpaud003 LIKE inpa_t.inpaud003, #自定義欄位(文字)003
       inpaud004 LIKE inpa_t.inpaud004, #自定義欄位(文字)004
       inpaud005 LIKE inpa_t.inpaud005, #自定義欄位(文字)005
       inpaud006 LIKE inpa_t.inpaud006, #自定義欄位(文字)006
       inpaud007 LIKE inpa_t.inpaud007, #自定義欄位(文字)007
       inpaud008 LIKE inpa_t.inpaud008, #自定義欄位(文字)008
       inpaud009 LIKE inpa_t.inpaud009, #自定義欄位(文字)009
       inpaud010 LIKE inpa_t.inpaud010, #自定義欄位(文字)010
       inpaud011 LIKE inpa_t.inpaud011, #自定義欄位(數字)011
       inpaud012 LIKE inpa_t.inpaud012, #自定義欄位(數字)012
       inpaud013 LIKE inpa_t.inpaud013, #自定義欄位(數字)013
       inpaud014 LIKE inpa_t.inpaud014, #自定義欄位(數字)014
       inpaud015 LIKE inpa_t.inpaud015, #自定義欄位(數字)015
       inpaud016 LIKE inpa_t.inpaud016, #自定義欄位(數字)016
       inpaud017 LIKE inpa_t.inpaud017, #自定義欄位(數字)017
       inpaud018 LIKE inpa_t.inpaud018, #自定義欄位(數字)018
       inpaud019 LIKE inpa_t.inpaud019, #自定義欄位(數字)019
       inpaud020 LIKE inpa_t.inpaud020, #自定義欄位(數字)020
       inpaud021 LIKE inpa_t.inpaud021, #自定義欄位(日期時間)021
       inpaud022 LIKE inpa_t.inpaud022, #自定義欄位(日期時間)022
       inpaud023 LIKE inpa_t.inpaud023, #自定義欄位(日期時間)023
       inpaud024 LIKE inpa_t.inpaud024, #自定義欄位(日期時間)024
       inpaud025 LIKE inpa_t.inpaud025, #自定義欄位(日期時間)025
       inpaud026 LIKE inpa_t.inpaud026, #自定義欄位(日期時間)026
       inpaud027 LIKE inpa_t.inpaud027, #自定義欄位(日期時間)027
       inpaud028 LIKE inpa_t.inpaud028, #自定義欄位(日期時間)028
       inpaud029 LIKE inpa_t.inpaud029, #自定義欄位(日期時間)029
       inpaud030 LIKE inpa_t.inpaud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD   
   #161104-00002#3 Add By Ken 161105(E)
   DEFINE l_cnt_xd    LIKE type_t.num5
   DEFINE l_cnt_cj    LIKE type_t.num5
   DEFINE l_inai010   LIKE inai_t.inai010
   DEFINE l_inpf_cnt  LIKE type_t.num5
   DEFINE l_inpg_cnt  LIKE type_t.num5
   DEFINE l_inpe_cnt  LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5  
   DEFINE l_recount   LIKE type_t.num5   
   DEFINE l_inpc001   LIKE inpc_t.inpc001
   #161104-00002#3 Mark By Ken 161105(S)
   #DEFINE l_inag      RECORD LIKE inag_t.*
   #DEFINE l_inpd      RECORD LIKE inpd_t.*
   #161104-00002#3 Mark By Ken 161105(E)
   #161104-00002#3 Add By Ken 161105(S)
DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企業編號
       inagsite LIKE inag_t.inagsite, #營運據點
       inag001 LIKE inag_t.inag001, #料件編號
       inag002 LIKE inag_t.inag002, #產品特徵
       inag003 LIKE inag_t.inag003, #庫存管理特徵
       inag004 LIKE inag_t.inag004, #庫位編號
       inag005 LIKE inag_t.inag005, #儲位編號
       inag006 LIKE inag_t.inag006, #批號
       inag007 LIKE inag_t.inag007, #庫存單位
       inag008 LIKE inag_t.inag008, #帳面庫存數量
       inag009 LIKE inag_t.inag009, #實際庫存數量
       inag010 LIKE inag_t.inag010, #庫存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本庫否
       inag013 LIKE inag_t.inag013, #揀貨優先序
       inag014 LIKE inag_t.inag014, #最近一次盤點日期
       inag015 LIKE inag_t.inag015, #最後異動日期
       inag016 LIKE inag_t.inag016, #呆滯日期
       inag017 LIKE inag_t.inag017, #第一次入庫日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #備置數量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二進位碼
       inag024 LIKE inag_t.inag024, #參考單位
       inag025 LIKE inag_t.inag025, #參考數量
       inag026 LIKE inag_t.inag026, #最近一次檢驗日期
       inag027 LIKE inag_t.inag027, #下次檢驗日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人員
       inag030 LIKE inag_t.inag030, #留置部門
       inag031 LIKE inag_t.inag031, #留置單號
       inag032 LIKE inag_t.inag032, #基礎單位
       inag033 LIKE inag_t.inag033  #基礎單位數量
END RECORD   
DEFINE l_inpd RECORD  #盤點明細檔
       inpdent LIKE inpd_t.inpdent, #企業編號
       inpdsite LIKE inpd_t.inpdsite, #營運據點
       inpddocno LIKE inpd_t.inpddocno, #標籤編號
       inpdseq LIKE inpd_t.inpdseq, #項次
       inpd001 LIKE inpd_t.inpd001, #料件編號
       inpd002 LIKE inpd_t.inpd002, #產品特徵
       inpd003 LIKE inpd_t.inpd003, #庫存管理特徵
       inpd004 LIKE inpd_t.inpd004, #包裝容器編號
       inpd005 LIKE inpd_t.inpd005, #庫位編號
       inpd006 LIKE inpd_t.inpd006, #儲位編號
       inpd007 LIKE inpd_t.inpd007, #批號
       inpd008 LIKE inpd_t.inpd008, #盤點計劃單號
       inpd009 LIKE inpd_t.inpd009, #空白標籤
       inpd010 LIKE inpd_t.inpd010, #庫存單位
       inpd011 LIKE inpd_t.inpd011, #現有庫存量
       inpd012 LIKE inpd_t.inpd012, #參考單位
       inpd013 LIKE inpd_t.inpd013, #參考單位現有庫存量
       inpd014 LIKE inpd_t.inpd014, #理由碼
       inpd015 LIKE inpd_t.inpd015, #備註
       inpd016 LIKE inpd_t.inpd016, #產生人員
       inpd017 LIKE inpd_t.inpd017, #產生日期
       inpd018 LIKE inpd_t.inpd018, #列印日期
       inpd019 LIKE inpd_t.inpd019, #列印次數
       inpd030 LIKE inpd_t.inpd030, #盤點數量-初盤(一)
       inpd031 LIKE inpd_t.inpd031, #參考單位盤點量-初盤(一)
       inpd032 LIKE inpd_t.inpd032, #輸入人員-初盤(一)
       inpd033 LIKE inpd_t.inpd033, #輸入日期-初盤(一)
       inpd034 LIKE inpd_t.inpd034, #盤點人員-初盤(一)
       inpd035 LIKE inpd_t.inpd035, #盤點日期-初盤(一)
       inpd036 LIKE inpd_t.inpd036, #盤點數量-初盤(二)
       inpd037 LIKE inpd_t.inpd037, #參考單位盤點量-初盤(二)
       inpd038 LIKE inpd_t.inpd038, #輸入人員-初盤(二)
       inpd039 LIKE inpd_t.inpd039, #輸入日期-初盤(二)
       inpd040 LIKE inpd_t.inpd040, #盤點人員-初盤(二)
       inpd041 LIKE inpd_t.inpd041, #盤點日期-初盤(二)
       inpd050 LIKE inpd_t.inpd050, #盤點數量-複盤(一)
       inpd051 LIKE inpd_t.inpd051, #參考單位盤點量-複盤(一)
       inpd052 LIKE inpd_t.inpd052, #輸入人員-複盤(一)
       inpd053 LIKE inpd_t.inpd053, #輸入日期-複盤(一)
       inpd054 LIKE inpd_t.inpd054, #盤點人員-複盤(一)
       inpd055 LIKE inpd_t.inpd055, #盤點日期-複盤(一)
       inpd056 LIKE inpd_t.inpd056, #盤點數量-複盤(二)
       inpd057 LIKE inpd_t.inpd057, #參考單位盤點量-複盤(二)
       inpd058 LIKE inpd_t.inpd058, #輸入人員-複盤(二)
       inpd059 LIKE inpd_t.inpd059, #輸入日期-複盤(二)
       inpd060 LIKE inpd_t.inpd060, #盤點人員-複盤(二)
       inpd061 LIKE inpd_t.inpd061, #盤點日期-複盤(二)
       inpdownid LIKE inpd_t.inpdownid, #資料所有者
       inpdowndp LIKE inpd_t.inpdowndp, #資料所屬部門
       inpdcrtid LIKE inpd_t.inpdcrtid, #資料建立者
       inpdcrtdp LIKE inpd_t.inpdcrtdp, #資料建立部門
       inpdcrtdt LIKE inpd_t.inpdcrtdt, #資料創建日
       inpdmodid LIKE inpd_t.inpdmodid, #資料修改者
       inpdmoddt LIKE inpd_t.inpdmoddt, #最近修改日
       inpdcnfid LIKE inpd_t.inpdcnfid, #資料確認者
       inpdcnfdt LIKE inpd_t.inpdcnfdt, #資料確認日
       inpdpstid LIKE inpd_t.inpdpstid, #資料過帳者
       inpdpstdt LIKE inpd_t.inpdpstdt, #資料過帳日
       inpdstus LIKE inpd_t.inpdstus,    #狀態碼
       #161123-00042#3 Add By Ken 161124(S)
       inpdud001 LIKE inpd_t.inpdud001, #自定義欄位(文字)001
       inpdud002 LIKE inpd_t.inpdud002, #自定義欄位(文字)002
       inpdud003 LIKE inpd_t.inpdud003, #自定義欄位(文字)003
       inpdud004 LIKE inpd_t.inpdud004, #自定義欄位(文字)004
       inpdud005 LIKE inpd_t.inpdud005, #自定義欄位(文字)005
       inpdud006 LIKE inpd_t.inpdud006, #自定義欄位(文字)006
       inpdud007 LIKE inpd_t.inpdud007, #自定義欄位(文字)007
       inpdud008 LIKE inpd_t.inpdud008, #自定義欄位(文字)008
       inpdud009 LIKE inpd_t.inpdud009, #自定義欄位(文字)009
       inpdud010 LIKE inpd_t.inpdud010, #自定義欄位(文字)010
       inpdud011 LIKE inpd_t.inpdud011, #自定義欄位(數字)011
       inpdud012 LIKE inpd_t.inpdud012, #自定義欄位(數字)012
       inpdud013 LIKE inpd_t.inpdud013, #自定義欄位(數字)013
       inpdud014 LIKE inpd_t.inpdud014, #自定義欄位(數字)014
       inpdud015 LIKE inpd_t.inpdud015, #自定義欄位(數字)015
       inpdud016 LIKE inpd_t.inpdud016, #自定義欄位(數字)016
       inpdud017 LIKE inpd_t.inpdud017, #自定義欄位(數字)017
       inpdud018 LIKE inpd_t.inpdud018, #自定義欄位(數字)018
       inpdud019 LIKE inpd_t.inpdud019, #自定義欄位(數字)019
       inpdud020 LIKE inpd_t.inpdud020, #自定義欄位(數字)020
       inpdud021 LIKE inpd_t.inpdud021, #自定義欄位(日期時間)021
       inpdud022 LIKE inpd_t.inpdud022, #自定義欄位(日期時間)022
       inpdud023 LIKE inpd_t.inpdud023, #自定義欄位(日期時間)023
       inpdud024 LIKE inpd_t.inpdud024, #自定義欄位(日期時間)024
       inpdud025 LIKE inpd_t.inpdud025, #自定義欄位(日期時間)025
       inpdud026 LIKE inpd_t.inpdud026, #自定義欄位(日期時間)026
       inpdud027 LIKE inpd_t.inpdud027, #自定義欄位(日期時間)027
       inpdud028 LIKE inpd_t.inpdud028, #自定義欄位(日期時間)028
       inpdud029 LIKE inpd_t.inpdud029, #自定義欄位(日期時間)029
       inpdud030 LIKE inpd_t.inpdud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
   #161104-00002#3 Add By Ken 161105(E)
   DEFINE g_inpddocno LIKE inpa_t.inpadocno
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   #161104-00002#3 Mark By Ken 161105(S) 
   #DEFINE l_inpe      RECORD LIKE inpe_t.*
   #DEFINE l_inpf      RECORD LIKE inpf_t.*   
   #DEFINE l_inpg      RECORD LIKE inpg_t.*  
   #DEFINE l_sfaa      RECORD LIKE sfaa_t.*   
   #DEFINE l_sfba      RECORD LIKE sfba_t.*     
   #DEFINE l_inai      RECORD LIKE inai_t.* 
   #DEFINE l_imaf      RECORD LIKE imaf_t.*
   #161104-00002#3 Mark By Ken 161105(E)    
   DEFINE l_imaf071   LIKE imaf_t.imaf071
   DEFINE l_imaf081   LIKE imaf_t.imaf081
   #161104-00002#3 Add By Ken 161105(S)
DEFINE l_inpe RECORD  #盤點單製造批序號明細檔
       inpeent LIKE inpe_t.inpeent, #企業編號
       inpesite LIKE inpe_t.inpesite, #營運據點
       inpedocno LIKE inpe_t.inpedocno, #盤點編號
       inpeseq LIKE inpe_t.inpeseq, #項次
       inpeseq2 LIKE inpe_t.inpeseq2, #序號
       inpe001 LIKE inpe_t.inpe001, #料件編號
       inpe002 LIKE inpe_t.inpe002, #產品特徵
       inpe003 LIKE inpe_t.inpe003, #庫存管理特徵
       inpe004 LIKE inpe_t.inpe004, #包裝容器編號
       inpe005 LIKE inpe_t.inpe005, #庫位
       inpe006 LIKE inpe_t.inpe006, #儲位
       inpe007 LIKE inpe_t.inpe007, #批號
       inpe008 LIKE inpe_t.inpe008, #製造批號
       inpe009 LIKE inpe_t.inpe009, #製造序號
       inpe010 LIKE inpe_t.inpe010, #製造日期
       inpe011 LIKE inpe_t.inpe011, #有效日期
       inpe012 LIKE inpe_t.inpe012, #現有庫存量
       inpe030 LIKE inpe_t.inpe030, #盤點數量-初盤(一)
       inpe031 LIKE inpe_t.inpe031, #輸入人員-初盤(一)
       inpe032 LIKE inpe_t.inpe032, #輸入日期-初盤(一)
       inpe033 LIKE inpe_t.inpe033, #盤點人員-初盤(一)
       inpe034 LIKE inpe_t.inpe034, #盤點日期-初盤(一)
       inpe035 LIKE inpe_t.inpe035, #盤點數量-初盤(二)
       inpe036 LIKE inpe_t.inpe036, #輸入人員-初盤(二)
       inpe037 LIKE inpe_t.inpe037, #輸入日期-初盤(二)
       inpe038 LIKE inpe_t.inpe038, #盤點人員-初盤(二)
       inpe039 LIKE inpe_t.inpe039, #盤點日期-初盤(二)
       inpe050 LIKE inpe_t.inpe050, #盤點數量-複盤(一)
       inpe051 LIKE inpe_t.inpe051, #輸入人員-複盤(一)
       inpe052 LIKE inpe_t.inpe052, #輸入日期-複盤(一)
       inpe053 LIKE inpe_t.inpe053, #盤點人員-複盤(一)
       inpe054 LIKE inpe_t.inpe054, #盤點日期-複盤(一)
       inpe055 LIKE inpe_t.inpe055, #盤點數量-複盤(二)
       inpe056 LIKE inpe_t.inpe056, #輸入人員-複盤(二)
       inpe057 LIKE inpe_t.inpe057, #輸入日期-複盤(二)
       inpe058 LIKE inpe_t.inpe058, #盤點人員-複盤(二)
       inpe059 LIKE inpe_t.inpe059,  #盤點日期-複盤(二)
       #161123-00042#3 Add By Ken 161124(S)
       inpeud001 LIKE inpe_t.inpeud001, #自定義欄位(文字)001
       inpeud002 LIKE inpe_t.inpeud002, #自定義欄位(文字)002
       inpeud003 LIKE inpe_t.inpeud003, #自定義欄位(文字)003
       inpeud004 LIKE inpe_t.inpeud004, #自定義欄位(文字)004
       inpeud005 LIKE inpe_t.inpeud005, #自定義欄位(文字)005
       inpeud006 LIKE inpe_t.inpeud006, #自定義欄位(文字)006
       inpeud007 LIKE inpe_t.inpeud007, #自定義欄位(文字)007
       inpeud008 LIKE inpe_t.inpeud008, #自定義欄位(文字)008
       inpeud009 LIKE inpe_t.inpeud009, #自定義欄位(文字)009
       inpeud010 LIKE inpe_t.inpeud010, #自定義欄位(文字)010
       inpeud011 LIKE inpe_t.inpeud011, #自定義欄位(數字)011
       inpeud012 LIKE inpe_t.inpeud012, #自定義欄位(數字)012
       inpeud013 LIKE inpe_t.inpeud013, #自定義欄位(數字)013
       inpeud014 LIKE inpe_t.inpeud014, #自定義欄位(數字)014
       inpeud015 LIKE inpe_t.inpeud015, #自定義欄位(數字)015
       inpeud016 LIKE inpe_t.inpeud016, #自定義欄位(數字)016
       inpeud017 LIKE inpe_t.inpeud017, #自定義欄位(數字)017
       inpeud018 LIKE inpe_t.inpeud018, #自定義欄位(數字)018
       inpeud019 LIKE inpe_t.inpeud019, #自定義欄位(數字)019
       inpeud020 LIKE inpe_t.inpeud020, #自定義欄位(數字)020
       inpeud021 LIKE inpe_t.inpeud021, #自定義欄位(日期時間)021
       inpeud022 LIKE inpe_t.inpeud022, #自定義欄位(日期時間)022
       inpeud023 LIKE inpe_t.inpeud023, #自定義欄位(日期時間)023
       inpeud024 LIKE inpe_t.inpeud024, #自定義欄位(日期時間)024
       inpeud025 LIKE inpe_t.inpeud025, #自定義欄位(日期時間)025
       inpeud026 LIKE inpe_t.inpeud026, #自定義欄位(日期時間)026
       inpeud027 LIKE inpe_t.inpeud027, #自定義欄位(日期時間)027
       inpeud028 LIKE inpe_t.inpeud028, #自定義欄位(日期時間)028
       inpeud029 LIKE inpe_t.inpeud029, #自定義欄位(日期時間)029
       inpeud030 LIKE inpe_t.inpeud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD   
DEFINE l_inpf RECORD  #在製工單盤點單頭檔
       inpfent LIKE inpf_t.inpfent, #企業編號
       inpfsite LIKE inpf_t.inpfsite, #營運據點
       inpfdocno LIKE inpf_t.inpfdocno, #標籤編號
       inpfseq LIKE inpf_t.inpfseq, #項次
       inpf001 LIKE inpf_t.inpf001, #工單單號
       inpf002 LIKE inpf_t.inpf002, #作業編號
       inpf003 LIKE inpf_t.inpf003, #生產料號
       inpf004 LIKE inpf_t.inpf004, #盤點計劃單號
       inpf005 LIKE inpf_t.inpf005, #空白標籤
       inpf006 LIKE inpf_t.inpf006, #部門供應商
       inpf007 LIKE inpf_t.inpf007, #生產數量
       inpf008 LIKE inpf_t.inpf008, #生產單位
       inpf009 LIKE inpf_t.inpf009, #製程編號
       inpf010 LIKE inpf_t.inpf010, #已發料套數
       inpf011 LIKE inpf_t.inpf011, #已入庫合格量
       inpf012 LIKE inpf_t.inpf012, #已入庫不合格量
       inpf013 LIKE inpf_t.inpf013, #報廢量
       inpf014 LIKE inpf_t.inpf014, #備註
       inpf015 LIKE inpf_t.inpf015, #產生人員
       inpf016 LIKE inpf_t.inpf016, #產生日期
       inpf017 LIKE inpf_t.inpf017, #列印日期
       inpf018 LIKE inpf_t.inpf018, #列印次數
       inpf020 LIKE inpf_t.inpf020, #輸入人員-初盤一
       inpf021 LIKE inpf_t.inpf021, #輸入日期-初盤一
       inpf022 LIKE inpf_t.inpf022, #輸入人員-初盤二
       inpf023 LIKE inpf_t.inpf023, #輸入日期-初盤二
       inpf024 LIKE inpf_t.inpf024, #輸入人員-複盤一
       inpf025 LIKE inpf_t.inpf025, #輸入日期-複盤一
       inpf026 LIKE inpf_t.inpf026, #輸入人員-複盤二
       inpf027 LIKE inpf_t.inpf027, #輸入日期-複盤二
       inpfownid LIKE inpf_t.inpfownid, #資料所有者
       inpfowndp LIKE inpf_t.inpfowndp, #資料所有部門
       inpfcrtid LIKE inpf_t.inpfcrtid, #資料建立者
       inpfcrtdp LIKE inpf_t.inpfcrtdp, #資料建立部門
       inpfcrtdt LIKE inpf_t.inpfcrtdt, #資料創建日
       inpfmodid LIKE inpf_t.inpfmodid, #資料修改者
       inpfmoddt LIKE inpf_t.inpfmoddt, #最近修改日
       inpfcnfid LIKE inpf_t.inpfcnfid, #資料確認者
       inpfcnfdt LIKE inpf_t.inpfcnfdt, #資料確認日
       inpfpstid LIKE inpf_t.inpfpstid, #資料過帳者
       inpfpstdt LIKE inpf_t.inpfpstdt, #資料過帳日
       inpfstus LIKE inpf_t.inpfstus,    #狀態碼
       #161123-00042#3 Add By Ken 161124(S)
       inpfud001 LIKE inpf_t.inpfud001, #自定義欄位(文字)001
       inpfud002 LIKE inpf_t.inpfud002, #自定義欄位(文字)002
       inpfud003 LIKE inpf_t.inpfud003, #自定義欄位(文字)003
       inpfud004 LIKE inpf_t.inpfud004, #自定義欄位(文字)004
       inpfud005 LIKE inpf_t.inpfud005, #自定義欄位(文字)005
       inpfud006 LIKE inpf_t.inpfud006, #自定義欄位(文字)006
       inpfud007 LIKE inpf_t.inpfud007, #自定義欄位(文字)007
       inpfud008 LIKE inpf_t.inpfud008, #自定義欄位(文字)008
       inpfud009 LIKE inpf_t.inpfud009, #自定義欄位(文字)009
       inpfud010 LIKE inpf_t.inpfud010, #自定義欄位(文字)010
       inpfud011 LIKE inpf_t.inpfud011, #自定義欄位(數字)011
       inpfud012 LIKE inpf_t.inpfud012, #自定義欄位(數字)012
       inpfud013 LIKE inpf_t.inpfud013, #自定義欄位(數字)013
       inpfud014 LIKE inpf_t.inpfud014, #自定義欄位(數字)014
       inpfud015 LIKE inpf_t.inpfud015, #自定義欄位(數字)015
       inpfud016 LIKE inpf_t.inpfud016, #自定義欄位(數字)016
       inpfud017 LIKE inpf_t.inpfud017, #自定義欄位(數字)017
       inpfud018 LIKE inpf_t.inpfud018, #自定義欄位(數字)018
       inpfud019 LIKE inpf_t.inpfud019, #自定義欄位(數字)019
       inpfud020 LIKE inpf_t.inpfud020, #自定義欄位(數字)020
       inpfud021 LIKE inpf_t.inpfud021, #自定義欄位(日期時間)021
       inpfud022 LIKE inpf_t.inpfud022, #自定義欄位(日期時間)022
       inpfud023 LIKE inpf_t.inpfud023, #自定義欄位(日期時間)023
       inpfud024 LIKE inpf_t.inpfud024, #自定義欄位(日期時間)024
       inpfud025 LIKE inpf_t.inpfud025, #自定義欄位(日期時間)025
       inpfud026 LIKE inpf_t.inpfud026, #自定義欄位(日期時間)026
       inpfud027 LIKE inpf_t.inpfud027, #自定義欄位(日期時間)027
       inpfud028 LIKE inpf_t.inpfud028, #自定義欄位(日期時間)028
       inpfud029 LIKE inpf_t.inpfud029, #自定義欄位(日期時間)029
       inpfud030 LIKE inpf_t.inpfud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
DEFINE l_inpg RECORD  #在製工單盤點明細檔
       inpgent LIKE inpg_t.inpgent, #企業編號
       inpgsite LIKE inpg_t.inpgsite, #營運據點
       inpgdocno LIKE inpg_t.inpgdocno, #標籤編號
       inpgseq LIKE inpg_t.inpgseq, #項次
       inpgseq1 LIKE inpg_t.inpgseq1, #項序
       inpgseq2 LIKE inpg_t.inpgseq2, #序號
       inpg001 LIKE inpg_t.inpg001, #發料料號
       inpg002 LIKE inpg_t.inpg002, #作業編號
       inpg003 LIKE inpg_t.inpg003, #製程式
       inpg004 LIKE inpg_t.inpg004, #標準QPA
       inpg005 LIKE inpg_t.inpg005, #實際QPA
       inpg006 LIKE inpg_t.inpg006, #應發數量
       inpg007 LIKE inpg_t.inpg007, #單位
       inpg008 LIKE inpg_t.inpg008, #已發數量
       inpg009 LIKE inpg_t.inpg009, #報廢數量
       inpg010 LIKE inpg_t.inpg010, #庫存管理特徵
       inpg011 LIKE inpg_t.inpg011, #超領數量
       inpg012 LIKE inpg_t.inpg012, #應盤數量
       inpg013 LIKE inpg_t.inpg013, #理由碼
       inpg014 LIKE inpg_t.inpg014, #備註
       inpg030 LIKE inpg_t.inpg030, #盤點數量-初盤(一)
       inpg031 LIKE inpg_t.inpg031, #盤點人員-初盤(一)
       inpg032 LIKE inpg_t.inpg032, #盤點日期-初盤(一)
       inpg033 LIKE inpg_t.inpg033, #盤點數量-初盤(二)
       inpg034 LIKE inpg_t.inpg034, #盤點人員-初盤(二)
       inpg035 LIKE inpg_t.inpg035, #盤點日期-初盤(二)
       inpg050 LIKE inpg_t.inpg050, #盤點數量-複盤(一)
       inpg051 LIKE inpg_t.inpg051, #盤點人員-複盤(一)
       inpg052 LIKE inpg_t.inpg052, #盤點日期-複盤(一)
       inpg053 LIKE inpg_t.inpg053, #盤點數量-複盤(二)
       inpg054 LIKE inpg_t.inpg054, #盤點人員-複盤(二)
       inpg055 LIKE inpg_t.inpg055, #盤點日期-複盤(二)
       inpg015 LIKE inpg_t.inpg015,  #產品特徵
       #161123-00042#3 Add By Ken 161124(S)
       inpgud001 LIKE inpg_t.inpgud001, #自定義欄位(文字)001
       inpgud002 LIKE inpg_t.inpgud002, #自定義欄位(文字)002
       inpgud003 LIKE inpg_t.inpgud003, #自定義欄位(文字)003
       inpgud004 LIKE inpg_t.inpgud004, #自定義欄位(文字)004
       inpgud005 LIKE inpg_t.inpgud005, #自定義欄位(文字)005
       inpgud006 LIKE inpg_t.inpgud006, #自定義欄位(文字)006
       inpgud007 LIKE inpg_t.inpgud007, #自定義欄位(文字)007
       inpgud008 LIKE inpg_t.inpgud008, #自定義欄位(文字)008
       inpgud009 LIKE inpg_t.inpgud009, #自定義欄位(文字)009
       inpgud010 LIKE inpg_t.inpgud010, #自定義欄位(文字)010
       inpgud011 LIKE inpg_t.inpgud011, #自定義欄位(數字)011
       inpgud012 LIKE inpg_t.inpgud012, #自定義欄位(數字)012
       inpgud013 LIKE inpg_t.inpgud013, #自定義欄位(數字)013
       inpgud014 LIKE inpg_t.inpgud014, #自定義欄位(數字)014
       inpgud015 LIKE inpg_t.inpgud015, #自定義欄位(數字)015
       inpgud016 LIKE inpg_t.inpgud016, #自定義欄位(數字)016
       inpgud017 LIKE inpg_t.inpgud017, #自定義欄位(數字)017
       inpgud018 LIKE inpg_t.inpgud018, #自定義欄位(數字)018
       inpgud019 LIKE inpg_t.inpgud019, #自定義欄位(數字)019
       inpgud020 LIKE inpg_t.inpgud020, #自定義欄位(數字)020
       inpgud021 LIKE inpg_t.inpgud021, #自定義欄位(日期時間)021
       inpgud022 LIKE inpg_t.inpgud022, #自定義欄位(日期時間)022
       inpgud023 LIKE inpg_t.inpgud023, #自定義欄位(日期時間)023
       inpgud024 LIKE inpg_t.inpgud024, #自定義欄位(日期時間)024
       inpgud025 LIKE inpg_t.inpgud025, #自定義欄位(日期時間)025
       inpgud026 LIKE inpg_t.inpgud026, #自定義欄位(日期時間)026
       inpgud027 LIKE inpg_t.inpgud027, #自定義欄位(日期時間)027
       inpgud028 LIKE inpg_t.inpgud028, #自定義欄位(日期時間)028
       inpgud029 LIKE inpg_t.inpgud029, #自定義欄位(日期時間)029
       inpgud030 LIKE inpg_t.inpgud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072,  #保稅否
       #161123-00042#3 Add By Ken 161124(S)
       sfaaud001 LIKE sfaa_t.sfaaud001, #自定義欄位(文字)001
       sfaaud002 LIKE sfaa_t.sfaaud002, #自定義欄位(文字)002
       sfaaud003 LIKE sfaa_t.sfaaud003, #自定義欄位(文字)003
       sfaaud004 LIKE sfaa_t.sfaaud004, #自定義欄位(文字)004
       sfaaud005 LIKE sfaa_t.sfaaud005, #自定義欄位(文字)005
       sfaaud006 LIKE sfaa_t.sfaaud006, #自定義欄位(文字)006
       sfaaud007 LIKE sfaa_t.sfaaud007, #自定義欄位(文字)007
       sfaaud008 LIKE sfaa_t.sfaaud008, #自定義欄位(文字)008
       sfaaud009 LIKE sfaa_t.sfaaud009, #自定義欄位(文字)009
       sfaaud010 LIKE sfaa_t.sfaaud010, #自定義欄位(文字)010
       sfaaud011 LIKE sfaa_t.sfaaud011, #自定義欄位(數字)011
       sfaaud012 LIKE sfaa_t.sfaaud012, #自定義欄位(數字)012
       sfaaud013 LIKE sfaa_t.sfaaud013, #自定義欄位(數字)013
       sfaaud014 LIKE sfaa_t.sfaaud014, #自定義欄位(數字)014
       sfaaud015 LIKE sfaa_t.sfaaud015, #自定義欄位(數字)015
       sfaaud016 LIKE sfaa_t.sfaaud016, #自定義欄位(數字)016
       sfaaud017 LIKE sfaa_t.sfaaud017, #自定義欄位(數字)017
       sfaaud018 LIKE sfaa_t.sfaaud018, #自定義欄位(數字)018
       sfaaud019 LIKE sfaa_t.sfaaud019, #自定義欄位(數字)019
       sfaaud020 LIKE sfaa_t.sfaaud020, #自定義欄位(數字)020
       sfaaud021 LIKE sfaa_t.sfaaud021, #自定義欄位(日期時間)021
       sfaaud022 LIKE sfaa_t.sfaaud022, #自定義欄位(日期時間)022
       sfaaud023 LIKE sfaa_t.sfaaud023, #自定義欄位(日期時間)023
       sfaaud024 LIKE sfaa_t.sfaaud024, #自定義欄位(日期時間)024
       sfaaud025 LIKE sfaa_t.sfaaud025, #自定義欄位(日期時間)025
       sfaaud026 LIKE sfaa_t.sfaaud026, #自定義欄位(日期時間)026
       sfaaud027 LIKE sfaa_t.sfaaud027, #自定義欄位(日期時間)027
       sfaaud028 LIKE sfaa_t.sfaaud028, #自定義欄位(日期時間)028
       sfaaud029 LIKE sfaa_t.sfaaud029, #自定義欄位(日期時間)029
       sfaaud030 LIKE sfaa_t.sfaaud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbaent LIKE sfba_t.sfbaent, #企業編號
       sfbasite LIKE sfba_t.sfbasite, #營運據點
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba001 LIKE sfba_t.sfba001, #上階料號
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba005 LIKE sfba_t.sfba005, #BOM料號
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba007 LIKE sfba_t.sfba007, #投料時距
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba009 LIKE sfba_t.sfba009, #倒扣料
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba012 LIKE sfba_t.sfba012, #允許誤差率
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba018 LIKE sfba_t.sfba018, #盤虧數量
       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
       sfba021 LIKE sfba_t.sfba021, #產品特徵
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba024 LIKE sfba_t.sfba024, #調整應發數量
       sfba025 LIKE sfba_t.sfba025, #超領數量
       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
       sfba027 LIKE sfba_t.sfba027, #SET替代群組
       sfba028 LIKE sfba_t.sfba028, #客供料
       sfba029 LIKE sfba_t.sfba029, #指定發料批號
       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035,  #SET替代套數
       #161123-00042#3 Add By Ken 161124(S)
       sfbaud001 LIKE sfba_t.sfbaud001, #自定義欄位(文字)001
       sfbaud002 LIKE sfba_t.sfbaud002, #自定義欄位(文字)002
       sfbaud003 LIKE sfba_t.sfbaud003, #自定義欄位(文字)003
       sfbaud004 LIKE sfba_t.sfbaud004, #自定義欄位(文字)004
       sfbaud005 LIKE sfba_t.sfbaud005, #自定義欄位(文字)005
       sfbaud006 LIKE sfba_t.sfbaud006, #自定義欄位(文字)006
       sfbaud007 LIKE sfba_t.sfbaud007, #自定義欄位(文字)007
       sfbaud008 LIKE sfba_t.sfbaud008, #自定義欄位(文字)008
       sfbaud009 LIKE sfba_t.sfbaud009, #自定義欄位(文字)009
       sfbaud010 LIKE sfba_t.sfbaud010, #自定義欄位(文字)010
       sfbaud011 LIKE sfba_t.sfbaud011, #自定義欄位(數字)011
       sfbaud012 LIKE sfba_t.sfbaud012, #自定義欄位(數字)012
       sfbaud013 LIKE sfba_t.sfbaud013, #自定義欄位(數字)013
       sfbaud014 LIKE sfba_t.sfbaud014, #自定義欄位(數字)014
       sfbaud015 LIKE sfba_t.sfbaud015, #自定義欄位(數字)015
       sfbaud016 LIKE sfba_t.sfbaud016, #自定義欄位(數字)016
       sfbaud017 LIKE sfba_t.sfbaud017, #自定義欄位(數字)017
       sfbaud018 LIKE sfba_t.sfbaud018, #自定義欄位(數字)018
       sfbaud019 LIKE sfba_t.sfbaud019, #自定義欄位(數字)019
       sfbaud020 LIKE sfba_t.sfbaud020, #自定義欄位(數字)020
       sfbaud021 LIKE sfba_t.sfbaud021, #自定義欄位(日期時間)021
       sfbaud022 LIKE sfba_t.sfbaud022, #自定義欄位(日期時間)022
       sfbaud023 LIKE sfba_t.sfbaud023, #自定義欄位(日期時間)023
       sfbaud024 LIKE sfba_t.sfbaud024, #自定義欄位(日期時間)024
       sfbaud025 LIKE sfba_t.sfbaud025, #自定義欄位(日期時間)025
       sfbaud026 LIKE sfba_t.sfbaud026, #自定義欄位(日期時間)026
       sfbaud027 LIKE sfba_t.sfbaud027, #自定義欄位(日期時間)027
       sfbaud028 LIKE sfba_t.sfbaud028, #自定義欄位(日期時間)028
       sfbaud029 LIKE sfba_t.sfbaud029, #自定義欄位(日期時間)029
       sfbaud030 LIKE sfba_t.sfbaud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企業編號
       inaisite LIKE inai_t.inaisite, #營運據點
       inai001 LIKE inai_t.inai001, #料件編號
       inai002 LIKE inai_t.inai002, #產品特徵
       inai003 LIKE inai_t.inai003, #庫存管理特徵
       inai004 LIKE inai_t.inai004, #庫位編號
       inai005 LIKE inai_t.inai005, #儲位編號
       inai006 LIKE inai_t.inai006, #批號
       inai007 LIKE inai_t.inai007, #製造批號
       inai008 LIKE inai_t.inai008, #製造序號
       inai009 LIKE inai_t.inai009, #庫存單位
       inai010 LIKE inai_t.inai010, #帳面基礎單位庫存數量
       inai011 LIKE inai_t.inai011, #實際基礎單位庫存數量
       inai012 LIKE inai_t.inai012, #製造日期
       inai013 LIKE inai_t.inai013, #Tag二進位碼
       inai014 LIKE inai_t.inai014  #基礎單位
END RECORD
DEFINE l_imaf RECORD  #料件據點進銷存檔
       imafent LIKE imaf_t.imafent, #企業編號
       imafsite LIKE imaf_t.imafsite, #營運據點
       imaf001 LIKE imaf_t.imaf001, #料件編號
       imaf011 LIKE imaf_t.imaf011, #主分群
       imaf012 LIKE imaf_t.imaf012, #存貨管制方法
       imaf013 LIKE imaf_t.imaf013, #補給策略
       imaf014 LIKE imaf_t.imaf014, #需求計算方法
       imaf015 LIKE imaf_t.imaf015, #參考單位
       imaf016 LIKE imaf_t.imaf016, #據點生命週期
       imaf017 LIKE imaf_t.imaf017, #稅別
       imaf018 LIKE imaf_t.imaf018, #使用附屬零件
       imaf021 LIKE imaf_t.imaf021, #期間採購月數
       imaf022 LIKE imaf_t.imaf022, #期間採購日數
       imaf023 LIKE imaf_t.imaf023, #期間補足量
       imaf024 LIKE imaf_t.imaf024, #再訂貨點
       imaf025 LIKE imaf_t.imaf025, #再訂貨點量
       imaf026 LIKE imaf_t.imaf026, #安全庫存量
       imaf027 LIKE imaf_t.imaf027, #警戒庫存量
       imaf031 LIKE imaf_t.imaf031, #有效期月數
       imaf032 LIKE imaf_t.imaf032, #有效期加天數
       imaf033 LIKE imaf_t.imaf033, #檢疫/隔離天數
       imaf034 LIKE imaf_t.imaf034, #保稅料件
       imaf035 LIKE imaf_t.imaf035, #對應非保稅料號
       imaf051 LIKE imaf_t.imaf051, #庫存分群
       imaf052 LIKE imaf_t.imaf052, #倉管員
       imaf053 LIKE imaf_t.imaf053, #據點庫存單位
       imaf054 LIKE imaf_t.imaf054, #庫存多單位
       imaf055 LIKE imaf_t.imaf055, #庫存管理特微
       imaf056 LIKE imaf_t.imaf056, #no use
       imaf057 LIKE imaf_t.imaf057, #ABC碼
       imaf058 LIKE imaf_t.imaf058, #存貨備置策略
       imaf059 LIKE imaf_t.imaf059, #撿貨策略
       imaf061 LIKE imaf_t.imaf061, #庫存批號控管方式
       imaf062 LIKE imaf_t.imaf062, #庫存批號自動編碼否
       imaf063 LIKE imaf_t.imaf063, #庫存批號編碼方式
       imaf064 LIKE imaf_t.imaf064, #庫存批號唯一性檢查控管
       imaf071 LIKE imaf_t.imaf071, #製造批號控管方式
       imaf072 LIKE imaf_t.imaf072, #製造批號自動編碼否
       imaf073 LIKE imaf_t.imaf073, #製造批號編碼方式
       imaf074 LIKE imaf_t.imaf074, #製造批號唯一性檢查控管
       imaf081 LIKE imaf_t.imaf081, #序號控管方式
       imaf082 LIKE imaf_t.imaf082, #序號自動編碼否
       imaf083 LIKE imaf_t.imaf083, #序號編碼方式
       imaf084 LIKE imaf_t.imaf084, #序號唯一性檢查控管
       imaf091 LIKE imaf_t.imaf091, #預設庫位
       imaf092 LIKE imaf_t.imaf092, #預設儲位
       imaf093 LIKE imaf_t.imaf093, #no use
       imaf094 LIKE imaf_t.imaf094, #盤點容差數
       imaf095 LIKE imaf_t.imaf095, #盤點容差率
       imaf096 LIKE imaf_t.imaf096, #開帳呆滯日期
       imaf097 LIKE imaf_t.imaf097, #no use
       imaf101 LIKE imaf_t.imaf101, #調撥批量
       imaf102 LIKE imaf_t.imaf102, #最小調撥數量
       imaf111 LIKE imaf_t.imaf111, #銷售分群
       imaf112 LIKE imaf_t.imaf112, #銷售單位
       imaf113 LIKE imaf_t.imaf113, #銷售計價單位
       imaf114 LIKE imaf_t.imaf114, #銷售批量
       imaf115 LIKE imaf_t.imaf115, #最小銷售數量
       imaf116 LIKE imaf_t.imaf116, #銷售批量控管方式
       imaf117 LIKE imaf_t.imaf117, #保證(固)月數
       imaf118 LIKE imaf_t.imaf118, #保證(固)天數
       imaf121 LIKE imaf_t.imaf121, #預設內外銷
       imaf122 LIKE imaf_t.imaf122, #訂單子件拆解方式
       imaf123 LIKE imaf_t.imaf123, #慣用包裝容器
       imaf124 LIKE imaf_t.imaf124, #銷售備貨提前天數
       imaf125 LIKE imaf_t.imaf125, #預測料號
       imaf126 LIKE imaf_t.imaf126, #出貨替代
       imaf127 LIKE imaf_t.imaf127, #統計除外商品
       imaf128 LIKE imaf_t.imaf128, #銷售超交率
       imaf141 LIKE imaf_t.imaf141, #採購分群
       imaf142 LIKE imaf_t.imaf142, #採購員
       imaf143 LIKE imaf_t.imaf143, #採購單位
       imaf144 LIKE imaf_t.imaf144, #採購計價單位
       imaf145 LIKE imaf_t.imaf145, #採購單位批量
       imaf146 LIKE imaf_t.imaf146, #最小採購數量
       imaf147 LIKE imaf_t.imaf147, #採購批量控管方式
       imaf148 LIKE imaf_t.imaf148, #經濟訂購量
       imaf149 LIKE imaf_t.imaf149, #平均訂購量
       imaf151 LIKE imaf_t.imaf151, #預設內外購
       imaf152 LIKE imaf_t.imaf152, #供應商選擇方式
       imaf153 LIKE imaf_t.imaf153, #主要供應商
       imaf154 LIKE imaf_t.imaf154, #主供應商分配限量
       imaf155 LIKE imaf_t.imaf155, #分配進位倍數
       imaf156 LIKE imaf_t.imaf156, #供貨模式
       imaf157 LIKE imaf_t.imaf157, #慣用包裝容器
       imaf158 LIKE imaf_t.imaf158, #接單拆解方式(採購)
       imaf161 LIKE imaf_t.imaf161, #採購替代
       imaf162 LIKE imaf_t.imaf162, #採購收貨替代
       imaf163 LIKE imaf_t.imaf163, #採購合約沖銷
       imaf164 LIKE imaf_t.imaf164, #採購時損耗率
       imaf165 LIKE imaf_t.imaf165, #採購時備品率
       imaf166 LIKE imaf_t.imaf166, #採購超交率
       imaf171 LIKE imaf_t.imaf171, #採購文件前置時間
       imaf172 LIKE imaf_t.imaf172, #採購交貨前置時間
       imaf173 LIKE imaf_t.imaf173, #採購到廠前置時間
       imaf174 LIKE imaf_t.imaf174, #採購入庫前置時間
       imaf175 LIKE imaf_t.imaf175, #嚴守交期前置時間
       imaf176 LIKE imaf_t.imaf176, #收貨時段
       imafownid LIKE imaf_t.imafownid, #資料所有者
       imafowndp LIKE imaf_t.imafowndp, #資料所有部門
       imafcrtid LIKE imaf_t.imafcrtid, #資料建立者
       imafcrtdp LIKE imaf_t.imafcrtdp, #資料建立部門
       imafcrtdt LIKE imaf_t.imafcrtdt, #資料創建日
       imafmodid LIKE imaf_t.imafmodid, #資料修改者
       imafmoddt LIKE imaf_t.imafmoddt, #最近修改日
       imafcnfid LIKE imaf_t.imafcnfid, #資料確認者
       imafcnfdt LIKE imaf_t.imafcnfdt, #資料確認日
       imafstus LIKE imaf_t.imafstus, #狀態碼
       imaf177 LIKE imaf_t.imaf177, #箱盒號條碼管理
       imaf178 LIKE imaf_t.imaf178, #條碼編碼方式
       imaf179 LIKE imaf_t.imaf179, #條碼包裝數量
       imaf129 LIKE imaf_t.imaf129, #銷售合約沖銷
       imaf130 LIKE imaf_t.imaf130,  #銷售時備品率
       #161123-00042#3 Add By Ken 161124(S)
       imafud001 LIKE imaf_t.imafud001, #自定義欄位(文字)001
       imafud002 LIKE imaf_t.imafud002, #自定義欄位(文字)002
       imafud003 LIKE imaf_t.imafud003, #自定義欄位(文字)003
       imafud004 LIKE imaf_t.imafud004, #自定義欄位(文字)004
       imafud005 LIKE imaf_t.imafud005, #自定義欄位(文字)005
       imafud006 LIKE imaf_t.imafud006, #自定義欄位(文字)006
       imafud007 LIKE imaf_t.imafud007, #自定義欄位(文字)007
       imafud008 LIKE imaf_t.imafud008, #自定義欄位(文字)008
       imafud009 LIKE imaf_t.imafud009, #自定義欄位(文字)009
       imafud010 LIKE imaf_t.imafud010, #自定義欄位(文字)010
       imafud011 LIKE imaf_t.imafud011, #自定義欄位(數字)011
       imafud012 LIKE imaf_t.imafud012, #自定義欄位(數字)012
       imafud013 LIKE imaf_t.imafud013, #自定義欄位(數字)013
       imafud014 LIKE imaf_t.imafud014, #自定義欄位(數字)014
       imafud015 LIKE imaf_t.imafud015, #自定義欄位(數字)015
       imafud016 LIKE imaf_t.imafud016, #自定義欄位(數字)016
       imafud017 LIKE imaf_t.imafud017, #自定義欄位(數字)017
       imafud018 LIKE imaf_t.imafud018, #自定義欄位(數字)018
       imafud019 LIKE imaf_t.imafud019, #自定義欄位(數字)019
       imafud020 LIKE imaf_t.imafud020, #自定義欄位(數字)020
       imafud021 LIKE imaf_t.imafud021, #自定義欄位(日期時間)021
       imafud022 LIKE imaf_t.imafud022, #自定義欄位(日期時間)022
       imafud023 LIKE imaf_t.imafud023, #自定義欄位(日期時間)023
       imafud024 LIKE imaf_t.imafud024, #自定義欄位(日期時間)024
       imafud025 LIKE imaf_t.imafud025, #自定義欄位(日期時間)025
       imafud026 LIKE imaf_t.imafud026, #自定義欄位(日期時間)026
       imafud027 LIKE imaf_t.imafud027, #自定義欄位(日期時間)027
       imafud028 LIKE imaf_t.imafud028, #自定義欄位(日期時間)028
       imafud029 LIKE imaf_t.imafud029, #自定義欄位(日期時間)029
       imafud030 LIKE imaf_t.imafud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
   #161104-00002#3 Add By Ken 161105(E)
  #DEFINE l_sfbadocno_t  LIKE sfba_t.sfbadocno   #151229-00017#2 mark
   DEFINE l_sfaadocno_t  LIKE sfaa_t.sfaadocno   #151229-00017#2 add
   DEFINE l_sfba003_t    LIKE sfba_t.sfba003  
   DEFINE l_inpddocno    LIKE inpd_t.inpddocno
   DEFINE l_inpdseq      LIKE inpd_t.inpdseq
   DEFINE l_inpd011      LIKE inpd_t.inpd011
   DEFINE l_inpedocno    LIKE inpe_t.inpedocno
   DEFINE l_inpeseq      LIKE inpe_t.inpeseq
   DEFINE l_inpeseq2     LIKE inpe_t.inpeseq2
   DEFINE l_inal005      LIKE inal_t.inal005
   DEFINE l_inal014      LIKE inal_t.inal014
   DEFINE s_inal014      LIKE inal_t.inal014
   DEFINE l_inpe012      LIKE inpe_t.inpe012   
   DEFINE l_inat015      LIKE inat_t.inat015
   DEFINE l_inat021      LIKE inat_t.inat021
   DEFINE l_yy           LIKE type_t.num5
   DEFINE l_mm           LIKE type_t.num5   
   DEFINE l_inaj004      LIKE inaj_t.inaj004
   DEFINE l_inaj011      LIKE inaj_t.inaj011
   DEFINE s_sum          LIkE inag_t.inag008
   DEFINE s_ck_sum       LIkE inag_t.inag008   
   DEFINE l_inpa009      LIKE inpa_t.inpa009
   DEFINE l_inpa010      LIKE inpa_t.inpa009
   DEFINE l_inpa011      LIKE inpa_t.inpa009
   DEFINE l_inpa012      LIKE inpa_t.inpa009
   DEFINE l_inpd030      LIKE inpd_t.inpd030
   DEFINE l_inpd031      LIKE inpd_t.inpd030
   DEFINE l_inpd036      LIKE inpd_t.inpd030
   DEFINE l_inpd037      LIKE inpd_t.inpd030
   DEFINE l_inpd050      LIKE inpd_t.inpd030
   DEFINE l_inpd051      LIKE inpd_t.inpd030
   DEFINE l_inpd056      LIKE inpd_t.inpd030
   DEFINE l_inpd057      LIKE inpd_t.inpd030   
   DEFINE l_inpa008      LIKE inpa_t.inpa008
   DEFINE l_inaj026      LIKE inaj_t.inaj026
   DEFINE l_inaj027      LIKE inaj_t.inaj027
   DEFINE l_inpfdocno    LIKE inpf_t.inpfdocno
   DEFINE l_inpfseq      LIKE inpf_t.inpfseq
   DEFINE l_yes          LIKE type_t.chr1 
   DEFINE l_inpt001      LIKE inpt_t.inpt001 
   DEFINE l_slip         STRING   
   DEFINE l_sql          STRING  
   DEFINE l_sql1         STRING      
   
   #160517-00029#2  16/05/26  By earl add s
   DEFINE l_sub_js    STRING
   
   DEFINE l_sub_param  RECORD
      cmd         LIKE type_t.chr1,        #1.INSERT 2.UPDATE
      inpa017     LIKE inpa_t.inpa017,     #包含已無庫存量
      inpa008     LIKE inpa_t.inpa008,     #盤點輸入方式
      inpa009     LIKE inpa_t.inpa009,     #現有庫存初盤一
      inpa010     LIKE inpa_t.inpa010,     #現有庫存初盤二
      inpa011     LIKE inpa_t.inpa011,     #現有庫存複盤一
      inpa012     LIKE inpa_t.inpa012,     #現有庫存複盤二
      datatime    DATETIME YEAR TO SECOND, #異動時間
      inpddocno   LIKE inpd_t.inpddocno,   #標籤編號
      inpdseq     LIKE inpd_t.inpdseq,     #項次
      inpd008     LIKE inpd_t.inpd008,     #盤點計畫單號
      inpd009     LIKE inpd_t.inpd009,     #空白標籤
      inpdownid   LIKE inpd_t.inpdownid,
      inpdowndp   LIKE inpd_t.inpdowndp,
      inpdcrtid   LIKE inpd_t.inpdcrtid,
      inpdcrtdp   LIKE inpd_t.inpdcrtdp,
      inpd001     LIKE inpd_t.inpd001,     #料件編號
      inpd002     LIKE inpd_t.inpd002,     #產品特徵
      inpd003     LIKE inpd_t.inpd003,     #庫存管理特徵
      inpd005     LIKE inpd_t.inpd005,     #庫位編號
      inpd006     LIKE inpd_t.inpd006,     #儲位編號
      inpd007     LIKE inpd_t.inpd007,     #批號
      inpd010     LIKE inpd_t.inpd010,     #庫存單位
      inpd012     LIKE inpd_t.inpd012      #參考單位
                       END RECORD
   #160517-00029#2  16/05/26  By earl add e
   
   DEFINE l_inae010   LIKE inae_t.inae010  #160512-00004#1 by whitney add
   
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
#  DECLARE ainp860_process_cs CURSOR FROM ls_sql
#  FOREACH ainp860_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   LET l_flag = 'Y'
   LET l_success = TRUE
   #add by lixh20141218
   LET l_yy = YEAR(g_master.date01)
   LET l_mm = MONTH(g_master.date01)
   LET b_date = MDY(l_mm,1,l_yy)  
   IF l_mm = 1 THEN 
      LET l_mm = 12
      LET l_yy = l_yy - 1
   ELSE
      LET l_mm = l_mm - 1   
   END IF 
   #add by lixh20141218
   LET l_cnt_xd = 0
   SELECT COUNT(*) INTO l_cnt_xd FROM inpc_t
    WHERE inpcent = g_enterprise
      AND inpcsite = g_site
      AND inpcdocno = g_master.inpadocno
   IF cl_null(l_cnt_xd) THEN LET l_cnt_xd = 0 END IF 
   #161104-00002#3 Mark By Ken 161105(S)
   #SELECT * INTO l_inpa.* FROM inpa_t 
   # WHERE inpaent = g_enterprise
   #   AND inpasite = g_site
   #   AND inpadocno = g_master.inpadocno
   #161104-00002#3 Mark By Ken 161105(E)
   
   #161104-00002#3 Add By Ken 161105(S)
   SELECT inpaent,inpasite,inpadocno,inpadocdt,inpa001, 
          inpa002,inpa003,inpa004,inpa005,inpa006,
          inpa007,inpa008,inpa009,inpa010,inpa011,
          inpa012,inpa013,inpa014,inpa015,inpa016,
          inpa017,inpa018,inpa019,inpa020,inpa021,
          inpa022,inpa023,inpa024,inpa025,inpa026,
          inpa027,inpa028,inpa029,inpa030,inpa031,
          inpa032,inpa033,inpa034,inpa035,inpa036,
          inpa037,inpa038,inpa039,inpa050,inpa051,
          inpa052,inpa053,inpa054,inpaownid,inpaowndp,
          inpacrtid,inpacrtdp,inpacrtdt,inpamodid,inpamoddt,
          inpacnfid,inpacnfdt,inpapstid,inpapstdt,inpastus,
          inpa040,inpa041,inpa042,inpa043,
          #161123-00042#3 Add By Ken 161124(S)
          inpaud001,inpaud002,inpaud003,inpaud004,inpaud005,
          inpaud006,inpaud007,inpaud008,inpaud009,inpaud010,
          inpaud011,inpaud012,inpaud013,inpaud014,inpaud015,
          inpaud016,inpaud017,inpaud018,inpaud019,inpaud020,
          inpaud021,inpaud022,inpaud023,inpaud024,inpaud025,
          inpaud026,inpaud027,inpaud028,inpaud029,inpaud030
          #161123-00042#3 Add By Ken 161124(E)
     INTO l_inpa.inpaent   ,       l_inpa.inpasite  ,       l_inpa.inpadocno ,       l_inpa.inpadocdt ,       l_inpa.inpa001   ,
          l_inpa.inpa002   ,       l_inpa.inpa003   ,       l_inpa.inpa004   ,       l_inpa.inpa005   ,       l_inpa.inpa006   ,
          l_inpa.inpa007   ,       l_inpa.inpa008   ,       l_inpa.inpa009   ,       l_inpa.inpa010   ,       l_inpa.inpa011   ,
          l_inpa.inpa012   ,       l_inpa.inpa013   ,       l_inpa.inpa014   ,       l_inpa.inpa015   ,       l_inpa.inpa016   ,
          l_inpa.inpa017   ,       l_inpa.inpa018   ,       l_inpa.inpa019   ,       l_inpa.inpa020   ,       l_inpa.inpa021   ,
          l_inpa.inpa022   ,       l_inpa.inpa023   ,       l_inpa.inpa024   ,       l_inpa.inpa025   ,       l_inpa.inpa026   ,
          l_inpa.inpa027   ,       l_inpa.inpa028   ,       l_inpa.inpa029   ,       l_inpa.inpa030   ,       l_inpa.inpa031   ,
          l_inpa.inpa032   ,       l_inpa.inpa033   ,       l_inpa.inpa034   ,       l_inpa.inpa035   ,       l_inpa.inpa036   ,
          l_inpa.inpa037   ,       l_inpa.inpa038   ,       l_inpa.inpa039   ,       l_inpa.inpa050   ,       l_inpa.inpa051   ,
          l_inpa.inpa052   ,       l_inpa.inpa053   ,       l_inpa.inpa054   ,       l_inpa.inpaownid ,       l_inpa.inpaowndp ,
          l_inpa.inpacrtid ,       l_inpa.inpacrtdp ,       l_inpa.inpacrtdt ,       l_inpa.inpamodid ,       l_inpa.inpamoddt ,
          l_inpa.inpacnfid ,       l_inpa.inpacnfdt ,       l_inpa.inpapstid ,       l_inpa.inpapstdt ,       l_inpa.inpastus  ,
          l_inpa.inpa040   ,       l_inpa.inpa041   ,       l_inpa.inpa042   ,       l_inpa.inpa043   ,
          #161123-00042#3 Add By Ken 161124(S)
          l_inpa.inpaud001,l_inpa.inpaud002,l_inpa.inpaud003,l_inpa.inpaud004,l_inpa.inpaud005,
          l_inpa.inpaud006,l_inpa.inpaud007,l_inpa.inpaud008,l_inpa.inpaud009,l_inpa.inpaud010,
          l_inpa.inpaud011,l_inpa.inpaud012,l_inpa.inpaud013,l_inpa.inpaud014,l_inpa.inpaud015,
          l_inpa.inpaud016,l_inpa.inpaud017,l_inpa.inpaud018,l_inpa.inpaud019,l_inpa.inpaud020,
          l_inpa.inpaud021,l_inpa.inpaud022,l_inpa.inpaud023,l_inpa.inpaud024,l_inpa.inpaud025,
          l_inpa.inpaud026,l_inpa.inpaud027,l_inpa.inpaud028,l_inpa.inpaud029,l_inpa.inpaud030
          #161123-00042#3 Add By Ken 161124(E)                  
     FROM inpa_t 
    WHERE inpaent = g_enterprise
      AND inpasite = g_site
      AND inpadocno = g_master.inpadocno
   #161104-00002#3 Add By Ken 161105(E)      
      
   IF g_master.stock = 'Y' THEN   #現有庫存盤點
      LET g_sql3 = " SELECT COUNT(*) FROM inag_t,imaf_t ",
                   "  WHERE inagent = imafent ",
                   "    AND inagsite = imafsite ",
                   "    AND inag001 = imaf001 ",
                   "    AND inagent = '",g_enterprise,"'",
                   "    AND inagsite = '",g_site,"'" 
      IF l_cnt_xd > 0 THEN 
         LET g_sql3 = g_sql3," AND inag004 IN (",
                           " SELECT inpc001 FROM inpc_t ",
                           "  WHERE inpcent = '",g_enterprise,"'",
                           "    AND inpcsite = '",g_site,"'",
                           "    AND inpcdocno = '",g_master.inpadocno,"'",
                           " )"      
      END IF
      IF l_inpa.inpa017 = 'N' THEN
         LET g_sql3 = g_sql3," AND inag008 > 0"
      END IF 
      PREPARE ainp850_inag_count FROM g_sql3
      EXECUTE ainp850_inag_count INTO g_count
      FREE ainp850_inag_count
      IF cl_null(g_count) THEN LET g_count = 0 END IF
   END IF
   
   IF g_master.work = 'Y' THEN   #在製工單盤點
      LET g_sql4 = " SELECT COUNT(*) FROM sfaa_t,sfba_t ",
                   "  WHERE sfaaent = sfbaent ",
                   "    AND sfaadocno = sfbadocno ",
                   "    AND sfaaent = '",g_enterprise,"'",
                   "    AND sfaasite = '",g_site,"'",
                   "    AND sfaa065 = '0' ",
                   "    AND sfba013 > 0 "
      PREPARE ainp850_sfaa_count FROM g_sql4
      EXECUTE ainp850_sfaa_count INTO g_count2
      IF cl_null(g_count2) THEN LET g_count2 = 0 END IF      
   END IF    
   LET g_count = g_count + g_count2   
   IF g_master.number1 <> 0 THEN
      LET g_count = g_count + g_master.number1
   END IF
    IF g_master.number2 <> 0 THEN
       LET g_count = g_count + g_master.number2
   END IF  
   
   IF g_master.stock = 'Y' AND NOT cl_null(l_inpa.inpa018) THEN   #現有庫存盤點
      #LET g_sql = " SELECT * FROM inag_t,imaf_t ",   #161104-00002#3 Mark By Ken 161105
      #161104-00002#3 Add By Ken 161105(S)
      LET g_sql = " SELECT inagent,inagsite,inag001,inag002,inag003, ",
                  "        inag004,inag005,inag006,inag007,inag008,  ",
                  "        inag009,inag010,inag011,inag012,inag013,  ",
                  "        inag014,inag015,inag016,inag017,inag018,  ",
                  "        inag019,inag020,inag021,inag022,inag023,  ",
                  "        inag024,inag025,inag026,inag027,inag028,  ",
                  "        inag029,inag030,inag031,inag032,inag033,  ",
                  "        imafent,imafsite,imaf001,imaf011,imaf012, ",
                  "        imaf013,imaf014,imaf015,imaf016,imaf017,  ",
                  "        imaf018,imaf021,imaf022,imaf023,imaf024,  ",
                  "        imaf025,imaf026,imaf027,imaf031,imaf032,  ",
                  "        imaf033,imaf034,imaf035,imaf051,imaf052,  ",
                  "        imaf053,imaf054,imaf055,imaf056,imaf057,  ",
                  "        imaf058,imaf059,imaf061,imaf062,imaf063,  ",
                  "        imaf064,imaf071,imaf072,imaf073,imaf074,  ",
                  "        imaf081,imaf082,imaf083,imaf084,imaf091,  ",
                  "        imaf092,imaf093,imaf094,imaf095,imaf096,  ",
                  "        imaf097,imaf101,imaf102,imaf111,imaf112,  ",
                  "        imaf113,imaf114,imaf115,imaf116,imaf117,  ",
                  "        imaf118,imaf121,imaf122,imaf123,imaf124,  ",
                  "        imaf125,imaf126,imaf127,imaf128,imaf141,  ",
                  "        imaf142,imaf143,imaf144,imaf145,imaf146,  ",
                  "        imaf147,imaf148,imaf149,imaf151,imaf152,  ",
                  "        imaf153,imaf154,imaf155,imaf156,imaf157,  ",
                  "        imaf158,imaf161,imaf162,imaf163,imaf164,  ",
                  "        imaf165,imaf166,imaf171,imaf172,imaf173,  ",
                  "        imaf174,imaf175,imaf176,imafownid,imafowndp,",
                  "        imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt, ",
                  "        imafcnfid,imafcnfdt,imafstus,imaf177,imaf178, ",
                  "        imaf179,imaf129,imaf130, ",
                  #161123-00042#3 Add By Ken 161124(S)
                  "        imafud001,imafud002,imafud003,imafud004,imafud005, ",
                  "        imafud006,imafud007,imafud008,imafud009,imafud010, ",
                  "        imafud011,imafud012,imafud013,imafud014,imafud015, ",
                  "        imafud016,imafud017,imafud018,imafud019,imafud020, ",
                  "        imafud021,imafud022,imafud023,imafud024,imafud025, ",
                  "        imafud026,imafud027,imafud028,imafud029,imafud030  ",
                  #161123-00042#3 Add By Ken 161124(E)
                  "   FROM inag_t,imaf_t ",
      #161104-00002#3 Add By Ken 161105(E) 
                  "  WHERE inagent = imafent ",
                  "    AND inagsite = imafsite ",
                  "    AND inag001 = imaf001 ",
                  "    AND inagent = '",g_enterprise,"'",
                  "    AND inagsite = '",g_site,"'"
      IF l_cnt_xd > 0 THEN             
         LET g_sql = g_sql," AND inag004 IN (",
                           " SELECT inpc001 FROM inpc_t ",
                           "  WHERE inpcent = '",g_enterprise,"'",
                           "    AND inpcsite = '",g_site,"'",
                           "    AND inpcdocno = '",g_master.inpadocno,"'",
                           " )"
      END IF  
      
      #160104-00001 by whitney mark start
      #IF l_inpa.inpa017 = 'N' THEN
      #   LET g_sql = g_sql," AND inag008 > 0"
      #END IF  
      #160104-00001 by whitney mark end
      
      CALL ainp860_inpd_order(l_inpa.inpa025,TRUE,l_inpa.inpa031)
      CALL ainp860_inpd_order(l_inpa.inpa026,FALSE,l_inpa.inpa031)
      CALL ainp860_inpd_order(l_inpa.inpa027,FALSE,l_inpa.inpa031)
      CALL ainp860_inpd_order(l_inpa.inpa028,FALSE,l_inpa.inpa031)
      CALL ainp860_inpd_order(l_inpa.inpa029,FALSE,l_inpa.inpa031)
      CALL ainp860_inpd_order(l_inpa.inpa030,FALSE,l_inpa.inpa031)
      
      PREPARE ainp860_inag_pre FROM g_sql
      DECLARE ainp860_inag_cur CURSOR FOR ainp860_inag_pre  

      IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
         LET g_inpddocno = ''
         SELECT DISTINCT inpddocno INTO g_inpddocno FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpdsite = g_site
            AND inpd008 = g_master.inpadocno
               
         IF NOT cl_null(l_inpa.inpa018) AND cl_null(g_inpddocno) THEN
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa018,g_today,'aint830') 
                 RETURNING r_success,g_inpddocno            
         END IF
      END IF

      #FOREACH ainp860_inag_cur INTO l_inag.*,l_imaf.*   #161104-00002#3 Mark By Ken 161105
      #161104-00002#3 Add By Ken 161105(S)
      FOREACH ainp860_inag_cur INTO l_inag.inagent  ,       l_inag.inagsite ,       l_inag.inag001  ,       l_inag.inag002  ,       l_inag.inag003  ,
                                    l_inag.inag004  ,       l_inag.inag005  ,       l_inag.inag006  ,       l_inag.inag007  ,       l_inag.inag008  ,
                                    l_inag.inag009  ,       l_inag.inag010  ,       l_inag.inag011  ,       l_inag.inag012  ,       l_inag.inag013  ,
                                    l_inag.inag014  ,       l_inag.inag015  ,       l_inag.inag016  ,       l_inag.inag017  ,       l_inag.inag018  ,
                                    l_inag.inag019  ,       l_inag.inag020  ,       l_inag.inag021  ,       l_inag.inag022  ,       l_inag.inag023  ,
                                    l_inag.inag024  ,       l_inag.inag025  ,       l_inag.inag026  ,       l_inag.inag027  ,       l_inag.inag028  ,
                                    l_inag.inag029  ,       l_inag.inag030  ,       l_inag.inag031  ,       l_inag.inag032  ,       l_inag.inag033  ,
                                    l_imaf.imafent  ,       l_imaf.imafsite ,       l_imaf.imaf001  ,       l_imaf.imaf011  ,       l_imaf.imaf012  ,
                                    l_imaf.imaf013  ,       l_imaf.imaf014  ,       l_imaf.imaf015  ,       l_imaf.imaf016  ,       l_imaf.imaf017  ,
                                    l_imaf.imaf018  ,       l_imaf.imaf021  ,       l_imaf.imaf022  ,       l_imaf.imaf023  ,       l_imaf.imaf024  ,
                                    l_imaf.imaf025  ,       l_imaf.imaf026  ,       l_imaf.imaf027  ,       l_imaf.imaf031  ,       l_imaf.imaf032  ,
                                    l_imaf.imaf033  ,       l_imaf.imaf034  ,       l_imaf.imaf035  ,       l_imaf.imaf051  ,       l_imaf.imaf052  ,
                                    l_imaf.imaf053  ,       l_imaf.imaf054  ,       l_imaf.imaf055  ,       l_imaf.imaf056  ,       l_imaf.imaf057  ,
                                    l_imaf.imaf058  ,       l_imaf.imaf059  ,       l_imaf.imaf061  ,       l_imaf.imaf062  ,       l_imaf.imaf063  ,
                                    l_imaf.imaf064  ,       l_imaf.imaf071  ,       l_imaf.imaf072  ,       l_imaf.imaf073  ,       l_imaf.imaf074  ,
                                    l_imaf.imaf081  ,       l_imaf.imaf082  ,       l_imaf.imaf083  ,       l_imaf.imaf084  ,       l_imaf.imaf091  ,
                                    l_imaf.imaf092  ,       l_imaf.imaf093  ,       l_imaf.imaf094  ,       l_imaf.imaf095  ,       l_imaf.imaf096  ,
                                    l_imaf.imaf097  ,       l_imaf.imaf101  ,       l_imaf.imaf102  ,       l_imaf.imaf111  ,       l_imaf.imaf112  ,
                                    l_imaf.imaf113  ,       l_imaf.imaf114  ,       l_imaf.imaf115  ,       l_imaf.imaf116  ,       l_imaf.imaf117  ,
                                    l_imaf.imaf118  ,       l_imaf.imaf121  ,       l_imaf.imaf122  ,       l_imaf.imaf123  ,       l_imaf.imaf124  ,
                                    l_imaf.imaf125  ,       l_imaf.imaf126  ,       l_imaf.imaf127  ,       l_imaf.imaf128  ,       l_imaf.imaf141  ,
                                    l_imaf.imaf142  ,       l_imaf.imaf143  ,       l_imaf.imaf144  ,       l_imaf.imaf145  ,       l_imaf.imaf146  ,
                                    l_imaf.imaf147  ,       l_imaf.imaf148  ,       l_imaf.imaf149  ,       l_imaf.imaf151  ,       l_imaf.imaf152  ,
                                    l_imaf.imaf153  ,       l_imaf.imaf154  ,       l_imaf.imaf155  ,       l_imaf.imaf156  ,       l_imaf.imaf157  ,
                                    l_imaf.imaf158  ,       l_imaf.imaf161  ,       l_imaf.imaf162  ,       l_imaf.imaf163  ,       l_imaf.imaf164  ,
                                    l_imaf.imaf165  ,       l_imaf.imaf166  ,       l_imaf.imaf171  ,       l_imaf.imaf172  ,       l_imaf.imaf173  ,
                                    l_imaf.imaf174  ,       l_imaf.imaf175  ,       l_imaf.imaf176  ,       l_imaf.imafownid,       l_imaf.imafowndp,
                                    l_imaf.imafcrtid,       l_imaf.imafcrtdp,       l_imaf.imafcrtdt,       l_imaf.imafmodid,       l_imaf.imafmoddt,
                                    l_imaf.imafcnfid,       l_imaf.imafcnfdt,       l_imaf.imafstus ,       l_imaf.imaf177  ,       l_imaf.imaf178  ,
                                    l_imaf.imaf179  ,       l_imaf.imaf129  ,       l_imaf.imaf130  ,
                                    #161123-00042#3 Add By Ken 161124(S)
                                    l_imaf.imafud001,l_imaf.imafud002,l_imaf.imafud003,l_imaf.imafud004,l_imaf.imafud005,
                                    l_imaf.imafud006,l_imaf.imafud007,l_imaf.imafud008,l_imaf.imafud009,l_imaf.imafud010,
                                    l_imaf.imafud011,l_imaf.imafud012,l_imaf.imafud013,l_imaf.imafud014,l_imaf.imafud015,
                                    l_imaf.imafud016,l_imaf.imafud017,l_imaf.imafud018,l_imaf.imafud019,l_imaf.imafud020,
                                    l_imaf.imafud021,l_imaf.imafud022,l_imaf.imafud023,l_imaf.imafud024,l_imaf.imafud025,
                                    l_imaf.imafud026,l_imaf.imafud027,l_imaf.imafud028,l_imaf.imafud029,l_imaf.imafud030 
                                    #161123-00042#3 Add By Ken 161124(E)
      #161104-00002#3 Add By Ken 161105(E)
         INITIALIZE l_inpd.* TO NULL
         #add by lixh 20141218
         LET l_inpddocno = ''
         LET l_inpdseq = ''
         LET l_inpd011 = ''
         SELECT inpddocno,inpdseq,inpd011,inpd030,inpd031,inpd036,inpd037,inpd050,inpd051,inpd056,inpd057 
           INTO l_inpddocno,l_inpdseq,l_inpd011,l_inpd030,l_inpd031,l_inpd036,l_inpd037,l_inpd050,l_inpd051,l_inpd056,l_inpd057 
           FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpdsite = g_site
            AND inpd001 = l_inag.inag001
            AND inpd002 = l_inag.inag002
            AND inpd003 = l_inag.inag003
            AND inpd005 = l_inag.inag004
            AND inpd006 = l_inag.inag005
            AND inpd007 = l_inag.inag006
            AND inpd010 = l_inag.inag007
            AND inpd008 = g_master.inpadocno

         #160104-00001 by whitney add start
         IF l_inpa.inpa017 = 'N' AND l_inag.inag008 <= 0 AND cl_null(l_inpddocno) THEN
            CONTINUE FOREACH
         END IF  
         #160104-00001 by whitney add end

#         IF NOT cl_null(l_inpddocno) THEN   #盤點標籤已經存在
            LET l_inat015 = 0
            LET l_inat021 = 0
            SELECT inat015,inat021 INTO l_inat015,l_inat021 FROM inat_t
             WHERE inatent = g_enterprise
               AND inatsite = g_site
               AND inat001 = l_inag.inag001
               AND inat002 = l_inag.inag002
               AND inat003 = l_inag.inag003
               AND inat004 = l_inag.inag004
               AND inat005 = l_inag.inag005
               AND inat006 = l_inag.inag006
               AND inat007 = l_inag.inag007
               AND inat008 = l_yy
               AND inat009 = l_mm
            IF cl_null(l_inat015) THEN LET l_inat015 = 0 END IF
            IF cl_null(l_inat021) THEN LET l_inat021 = 0 END IF
            LET l_sql = " SELECT inaj004,inaj011,inaj026,inaj027 FROM inaj_t ",
                        "  WHERE inajent = '",g_enterprise,"'",
                        "    AND inajsite = '",g_site,"'",
                        "    AND inaj005 = '",l_inag.inag001,"'",
                        "    AND inaj006 = '",l_inag.inag002,"'", 
                        "    AND inaj007 = '",l_inag.inag003,"'",
                        "    AND inaj008 = '",l_inag.inag004,"'",
                        "    AND inaj009 = '",l_inag.inag005,"'",
                        "    AND inaj010 = '",l_inag.inag006,"'",
                        "    AND inaj012 = '",l_inag.inag007,"'",
                        #20151026 by stellar modify ----- (S)
                        #stellar modify:與庫存月結統一，避免兩日期月份不一樣時，會重覆計算到
#                        "    AND inaj023 >= '",b_date,"'",
#                        "    AND inaj023 <= '",g_master.date01,"'"
                        "    AND inaj022 >= '",b_date,"'",
                        "    AND inaj022 <= '",g_master.date01,"'"
                        #20151026 by stellar modify ----- (E)
            PREPARE ainp860_pb_inaj FROM l_sql
            DECLARE b_fill_cs_inaj CURSOR FOR ainp860_pb_inaj  
#           OPEN b_fill_cs_inaj USING l_inag.inag001,l_inag.inag002,l_inag.inag003,l_inag.inag004,l_inag.inag005,l_inag.inag006,l_inag.inag007
            LET s_sum = 0
            LET s_ck_sum = 0
            FOREACH b_fill_cs_inaj INTO l_inaj004,l_inaj011,l_inaj026,l_inaj027
               IF cl_null(l_inaj011) THEN LET l_inaj011 = 0 END IF
               LET s_sum = s_sum + l_inaj004*l_inaj011 
               LET s_ck_sum = s_ck_sum + l_inaj026*l_inaj027
            END FOREACH

#            IF s_sum <> 0 THEN   #20151026 by stellar mark:避免inaj無資料時無法更新
               LET l_inpd011 = l_inat015 + s_sum
               LET l_inpd.inpd011 = l_inpd011
               IF NOT cl_null(l_inpddocno) THEN
                  UPDATE inpd_t SET inpd011 = l_inpd011                                   
                   WHERE inpdent = g_enterprise
                     AND inpdsite = g_site
                     AND inpddocno = l_inpddocno
                     AND inpdseq = l_inpdseq
               END IF   
               SELECT inpa009,inpa010,inpa011,inpa012,inpa008 INTO l_inpa009,l_inpa010,l_inpa011,l_inpa012,l_inpa008 FROM inpa_t
                WHERE inpaent = g_enterprise
                  AND inpasite = g_site
                  AND inpadocno = g_master.inpadocno
               IF l_inpa008 = '2' THEN  #盤差輸入              
                  IF l_inpa012 = 'Y' THEN
#                     LET l_inpd.inpd056 = l_inpd056+s_sum
#                     LET l_inpd.inpd057 = l_inpd057+s_ck_sum                    
                     LET l_inpd.inpd056 = l_inpd011
                     LET l_inpd.inpd057 = l_inat021+s_ck_sum   
                  END IF
                  IF l_inpa011 = 'Y' THEN
                     LET l_inpd.inpd050 = l_inpd011
                     LET l_inpd.inpd051 = l_inat021+s_ck_sum
                  END IF
                  IF l_inpa010 = 'Y' THEN
                     LET l_inpd.inpd036 = l_inpd011
                     LET l_inpd.inpd037 = l_inat021+s_ck_sum
                  END IF
                  IF l_inpa009 = 'Y' THEN
                     LET l_inpd.inpd030 = l_inpd011
                     LET l_inpd.inpd031 = l_inat021+s_ck_sum
                  END IF 
                  IF NOT cl_null(l_inpddocno) THEN
                     UPDATE inpd_t SET inpd030 = l_inpd.inpd030,
                                       inpd031 = l_inpd.inpd031,
                                       inpd036 = l_inpd.inpd036,
                                       inpd037 = l_inpd.inpd037,
                                       inpd050 = l_inpd.inpd050,
                                       inpd051 = l_inpd.inpd051,
                                       inpd056 = l_inpd.inpd056,
                                       inpd057 = l_inpd.inpd057
                      WHERE inpdent = g_enterprise
                        AND inpdsite = g_site
                        AND inpddocno = l_inpddocno
                        AND inpdseq = l_inpdseq
                  END IF
               END IF
               
               #160517-00029#2  16/05/26  By earl add s
               IF NOT cl_null(l_inpddocno) THEN
                  LET g_datetime = cl_get_current()
                  
                  INITIALIZE l_sub_param.* TO NULL
                  LET l_sub_param.cmd       = '2'              #1.INSERT 2.UPDATE
                  LET l_sub_param.inpa017   = l_inpa.inpa017   #包含已無庫存量
                  LET l_sub_param.inpa008   = l_inpa.inpa008   #盤點輸入方式
                  LET l_sub_param.inpa009   = l_inpa.inpa009   #現有庫存初盤一
                  LET l_sub_param.inpa010   = l_inpa.inpa010   #現有庫存初盤二
                  LET l_sub_param.inpa011   = l_inpa.inpa011   #現有庫存複盤一
                  LET l_sub_param.inpa012   = l_inpa.inpa012   #現有庫存複盤二
                  LET l_sub_param.datatime  = g_datetime       #異動時間
                  LET l_sub_param.inpddocno = l_inpddocno      #標籤編號
                  LET l_sub_param.inpdseq   = l_inpdseq        #項次
                  LET l_sub_param.inpd001   = l_inag.inag001   #料件編號
                  LET l_sub_param.inpd003   = l_inag.inag003   #庫存管理特徵
                  LET l_sub_param.inpd005   = l_inag.inag004   #庫位編號
                  LET l_sub_param.inpd006   = l_inag.inag005   #儲位編號
                  LET l_sub_param.inpd007   = l_inag.inag006   #批號
                  LET l_sub_param.inpd010   = l_inag.inag007   #庫存單位
                  
                  LET l_sub_js = util.JSON.stringify(l_sub_param)
                  IF NOT s_abci200_bcah(l_sub_js) THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF
               #160517-00029#2  16/05/26  By earl add e
               
               
#            END IF   #20151026 by stellar mark 
         #不存在新增  
         #add by lixh 20141218
         IF cl_null(l_inpddocno) THEN   #盤點標籤不存在新增          
            IF l_inpa.inpa020 = '2' THEN   #同盤點卡號用項次呈現  
               LET l_inpd.inpddocno = g_inpddocno 
               SELECT MAX(inpdseq)+1 INTO l_inpd.inpdseq FROM inpd_t
                WHERE inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpddocno = g_inpddocno
               IF cl_null(l_inpd.inpdseq) THEN LET l_inpd.inpdseq = 1 END IF   
            ELSE     #一料一卡號
               CALL s_aooi200_gen_docno(g_site,l_inpa.inpa018,g_today,'aint830') 
                    RETURNING r_success,l_inpd.inpddocno     
               LET l_inpd.inpdseq = 0     
            END IF  
            LET l_inpd.inpd001 = l_inag.inag001
            LET l_inpd.inpd002 = l_inag.inag002
            LET l_inpd.inpd003 = l_inag.inag003     
            LET l_inpd.inpd005 = l_inag.inag004
            LET l_inpd.inpd006 = l_inag.inag005
            LET l_inpd.inpd007 = l_inag.inag006   
            LET l_inpd.inpd008 = g_master.inpadocno       
            LET l_inpd.inpd009 = 'N'    
            LET l_inpd.inpd010 = l_inag.inag007
            LET l_cnt_cj = 0
            SELECT COUNT(*) INTO l_cnt_cj FROM inpd_t
             WHERE inpdent = g_enterprise
               AND inpdsite = g_site
               AND inpd001 = l_inpd.inpd001
               AND inpd002 = l_inpd.inpd002
               AND inpd003 = l_inpd.inpd003
               AND inpd005 = l_inpd.inpd005
               AND inpd006 = l_inpd.inpd006
               AND inpd007 = l_inpd.inpd007
               AND inpd010 = l_inpd.inpd010
            IF cl_null(l_cnt_cj) THEN LET l_cnt = 0 END IF
            IF l_cnt_cj > 0 AND l_inpa.inpa008 = '1' THEN    #全盤輸入
               CONTINUE FOREACH
            END IF         
#            LET l_inpd.inpd011 = l_inag.inag009     #20141222 mark by lixh 
            LET l_inpd.inpd016 = g_user
            LET l_inpd.inpd017 = g_today
            
            IF l_inpa.inpa008 = '2' THEN   #盤差輸入
#               CALL ainp860_inpd_recount() RETURNING l_recount
#               IF l_inpa.inpa009 = 'Y' THEN          #20141222 mark by lixh    
#                  LET l_inpd.inpd030 = l_inag.inag008
#                  LET l_inpd.inpd031 = l_inag.inag025
#               END IF
#               IF l_inpa.inpa010 = 'Y' THEN
#                  LET l_inpd.inpd036 = l_inag.inag008
#                  LET l_inpd.inpd037 = l_inag.inag025            
#               END IF       
#               IF l_inpa.inpa011 = 'Y' THEN
#                  LET l_inpd.inpd050 = l_inag.inag008
#                  LET l_inpd.inpd051 = l_inag.inag025            
#               END IF   
#               IF l_inpa.inpa012 = 'Y' THEN
#                  LET l_inpd.inpd056 = l_inag.inag008
#                  LET l_inpd.inpd057= l_inag.inag025            
#               END IF              
            ELSE    #全輸入
              #mark by lixh 20150324
#               LET l_inpd.inpd030 = 0
#               LET l_inpd.inpd031 = 0
#               LET l_inpd.inpd036 = 0
#               LET l_inpd.inpd037 = 0
#               LET l_inpd.inpd050 = 0
#               LET l_inpd.inpd051 = 0
#               LET l_inpd.inpd056 = 0
#               LET l_inpd.inpd057 = 0
              #mark by lixh 20150324 
              #add by lixh 20150324
               LET l_inpd.inpd030 = ''
               LET l_inpd.inpd031 = ''
               LET l_inpd.inpd036 = ''
               LET l_inpd.inpd037 = ''
               LET l_inpd.inpd050 = ''
               LET l_inpd.inpd051 = ''
               LET l_inpd.inpd056 = ''
               LET l_inpd.inpd057 = ''           
              #add by lixh 20150324
            END IF
            LET l_inpd.inpdownid = g_user
            LET l_inpd.inpdowndp = g_dept
            LET l_inpd.inpdcrtid = g_user
            LET l_inpd.inpdcrtdp = g_dept  
            LET l_inpd.inpdcrtdt = g_today
            LET l_inpd.inpdstus = 'N'           
            INSERT INTO inpd_t (inpdent,inpdsite,inpddocno,inpdseq,inpd001,inpd002,inpd003,inpd005,inpd006,inpd007,inpd008,inpd009,
                                inpd010,inpd011,inpd012,inpd016,inpd017,inpd030,inpd031,inpd036,inpd037,inpd050,inpd051,inpd056,inpd057,
                                inpdownid,inpdowndp,inpdcrtid,inpdcrtdp,inpdcrtdt,inpdstus) 
                                
                        VALUES (g_enterprise,g_site,l_inpd.inpddocno,l_inpd.inpdseq,l_inpd.inpd001,l_inpd.inpd002,l_inpd.inpd003,l_inpd.inpd005,l_inpd.inpd006,l_inpd.inpd007,l_inpd.inpd008,l_inpd.inpd009,
                                l_inpd.inpd010,l_inpd.inpd011,l_inpd.inpd012,l_inpd.inpd016,l_inpd.inpd017,l_inpd.inpd030,l_inpd.inpd031,l_inpd.inpd036,l_inpd.inpd037,l_inpd.inpd050,l_inpd.inpd051,l_inpd.inpd056,l_inpd.inpd057,
                                l_inpd.inpdownid,l_inpd.inpdowndp,l_inpd.inpdcrtid,l_inpd.inpdcrtdp,l_inpd.inpdcrtdt,l_inpd.inpdstus)  
            
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inpe_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')
               RETURN                
            END IF 
            
            #160517-00029#2  16/05/26  By earl add s
            LET g_datetime = cl_get_current()
            
            INITIALIZE l_sub_param.* TO NULL
            LET l_sub_param.cmd       = '1'              #1.INSERT 2.UPDATE
            LET l_sub_param.inpa017   = l_inpa.inpa017   #包含已無庫存量
            LET l_sub_param.inpa008   = l_inpa.inpa008   #盤點輸入方式
            LET l_sub_param.inpa009   = l_inpa.inpa009   #現有庫存初盤一
            LET l_sub_param.inpa010   = l_inpa.inpa010   #現有庫存初盤二
            LET l_sub_param.inpa011   = l_inpa.inpa011   #現有庫存複盤一
            LET l_sub_param.inpa012   = l_inpa.inpa012   #現有庫存複盤二
            LET l_sub_param.datatime  = g_datetime       #異動時間
            LET l_sub_param.inpddocno = l_inpd.inpddocno #標籤編號
            LET l_sub_param.inpdseq   = l_inpd.inpdseq   #項次
            LET l_sub_param.inpd008   = l_inpd.inpd008   #盤點計畫單號
            LET l_sub_param.inpd009   = l_inpd.inpd009   #空白標籤
            LET l_sub_param.inpdownid = l_inpd.inpdownid  
            LET l_sub_param.inpdowndp = l_inpd.inpdowndp  
            LET l_sub_param.inpdcrtid = l_inpd.inpdcrtid  
            LET l_sub_param.inpdcrtdp = l_inpd.inpdcrtdp  
            LET l_sub_param.inpd001   = l_inpd.inpd001   #料件編號
            LET l_sub_param.inpd002   = l_inpd.inpd002   #產品特徵
            LET l_sub_param.inpd003   = l_inpd.inpd003   #庫存管理特徵
            LET l_sub_param.inpd005   = l_inpd.inpd005   #庫位編號
            LET l_sub_param.inpd006   = l_inpd.inpd006   #儲位編號
            LET l_sub_param.inpd007   = l_inpd.inpd007   #批號
            LET l_sub_param.inpd010   = l_inpd.inpd010   #庫存單位
            LET l_sub_param.inpd012   = l_inpd.inpd012   #參考單位
            
            LET l_sub_js = util.JSON.stringify(l_sub_param)
            IF NOT s_abci200_bcah(l_sub_js) THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            #160517-00029#2  16/05/26  By earl add e
            
         END IF
         LET g_master.stagenow = l_inpd.inpd001
         DISPLAY g_master.stagenow TO stagenow
         
         SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_inpd.inpd001
         IF l_imaf071 <>'2' OR l_imaf081 <>'2' THEN   #批序號管理
            
            #161104-00002#3 Mark By Ken 161105(S)
            #160512-00004#1 by whitney modify start
            #LET l_sql = " SELECT * FROM inai_t ",
            #LET l_sql = " SELECT inae010,inai_t.* FROM inai_t ",
            #            "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
            #160512-00004#1 by whitney modify end
            #161104-00002#3 Mark By Ken 161105(E)
            #161104-00002#3 Add By Ken 161105(S)
            LET l_sql = " SELECT inae010, ",
                        "        inaient,inaisite,inai001,inai002,inai003,  ",
                        "        inai004,inai005,inai006,inai007,inai008,   ",
                        "        inai009,inai010,inai011,inai012,inai013,   ",
                        "        inai014 ",
                        "   FROM inai_t ",
                        "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",            
            #161104-00002#3 Add By Ken 161105(E)
                        "  WHERE inaient = '",g_enterprise,"'",
                        "    AND inaisite = '",g_site,"'",
#                        "    AND inai001 = '",l_inpd.inpd001,"'",
#                        "    AND inai002 = '",l_inpd.inpd002,"'",
#                        "    AND inai003 = '",l_inpd.inpd003,"'",
#                        "    AND inai004 = '",l_inpd.inpd005,"'",
#                        "    AND inai005 = '",l_inpd.inpd006,"'",
#                        "    AND inai006 = '",l_inpd.inpd007,"'",
#                        "    AND inai009 = '",l_inpd.inpd010,"'"
                        "    AND inai001 = '",l_inag.inag001,"'",
                        "    AND inai002 = '",l_inag.inag002,"'",
                        "    AND inai003 = '",l_inag.inag003,"'",
                        "    AND inai004 = '",l_inag.inag004,"'",
                        "    AND inai005 = '",l_inag.inag005,"'",
                        "    AND inai006 = '",l_inag.inag006,"'",
                        "    AND inai009 = '",l_inag.inag007,"'"
            PREPARE ainp860_inai_pre FROM l_sql
            DECLARE ainp860_inai_cur CURSOR FOR ainp860_inai_pre
                        
            LET l_inpe.inpeent = g_enterprise
            LET l_inpe.inpesite = g_site
            LET l_inpe.inpedocno = l_inpd.inpddocno
            LET l_inpe.inpeseq = l_inpd.inpdseq
            LET l_inpe.inpe001 = l_inpd.inpd001
            LET l_inpe.inpe002 = l_inpd.inpd002
            LET l_inpe.inpe003 = l_inpd.inpd003
            LET l_inpe.inpe004 = l_inpd.inpd004
            LET l_inpe.inpe005 = l_inpd.inpd005
            LET l_inpe.inpe006 = l_inpd.inpd006
            LET l_inpe.inpe007 = l_inpd.inpd007
            
            #FOREACH ainp860_inai_cur INTO l_inae010,l_inai.*  #160512-00004#1 by whitney add l_inae010  #161104-00002#3 Mark By Ken 161105
            #161104-00002#3 Add By Ken 161105(S)
            FOREACH ainp860_inai_cur INTO l_inae010,  #160512-00004#1 by whitney add l_inae010
                                          l_inai.inaient  ,l_inai.inaisite ,l_inai.inai001  ,l_inai.inai002  ,l_inai.inai003  ,
                                          l_inai.inai004  ,l_inai.inai005  ,l_inai.inai006  ,l_inai.inai007  ,l_inai.inai008  ,
                                          l_inai.inai009  ,l_inai.inai010  ,l_inai.inai011  ,l_inai.inai012  ,l_inai.inai013  ,
                                          l_inai.inai014  
            #161104-00002#3 Add By Ken 161105(E)
               IF NOT cl_null(l_inpddocno) THEN     #已產生盤點單
                  LET l_inpedocno = ''
                  LET l_inpeseq = ''
                  LET l_inpeseq2 = ''
                  SELECT inpedocno,inpeseq,inpeseq2,inpe012 INTO l_inpedocno,l_inpeseq,l_inpeseq2,l_inpe012 FROM inpe_t
                   WHERE inpeent = g_enterprise
                     AND inpesite = g_site
                     AND inpedocno = l_inpddocno
                     AND inpeseq = l_inpdseq
                     AND inpe001 = l_inai.inai001
                     AND inpe002 = l_inai.inai002
                     AND inpe003 = l_inai.inai003
                     AND inpe005 = l_inai.inai004
                     AND inpe006 = l_inai.inai005
                     AND inpe007 = l_inai.inai006
                     AND inpe008 = l_inai.inai007
                     AND inpe009 = l_inai.inai009
               
                  IF NOT cl_null(l_inpeseq2) THEN  #有則更新
                     LET l_sql = " SELECT inal005,inal014 FROM inal_t ",
                                 "   WHERE inalent = '",g_enterprise,"'",
                                 "     AND inalsite = '",g_site,"'",
                                 "     AND inal006 = '",l_inai.inai001,"'",
                                 "     AND inal007 = '",l_inai.inai002,"'",
                                 "     AND inal008 = '",l_inai.inai003,"'",
                                 "     AND inal009 = '",l_inai.inai004,"'",
                                 "     AND inal010 = '",l_inai.inai005,"'",
                                 "     AND inal011 = '",l_inai.inai006,"'",
                                 "     AND inal012 = '",l_inai.inai007,"'",
                                 "     AND inal013 = '",l_inai.inai008,"'",
                                 "     AND inal017 >= '",b_date,"'",
                                 "     AND inal017 <= '",g_master.date01,"'"
                                 
                     PREPARE ainp860_inal_pre FROM l_sql
                     DECLARE ainp860_inal_cur CURSOR FOR ainp860_inal_pre    
                     LET s_inal014 = 0                  
                     FOREACH ainp860_inal_cur INTO l_inal005,l_inal014
                        IF cl_null(l_inal014) THEN 
                           LET l_inal014 = 0
                        END IF       
                        LET s_inal014 = s_inal014 + l_inal005*l_inal014                    
                     END FOREACH     
                     UPDATE inpe_t SET inpe012 = l_inpe012 + s_inal014
                      WHERE inpeent = g_enterprise
                        AND inpesite = g_site
                        AND inpedocno = l_inpedocno
                        AND inpeseq = l_inpeseq
                        AND inpeseq = l_inpeseq2                       
                  END IF
               END IF   
               IF (NOT cl_null(l_inpddocno) AND cl_null(l_inpeseq2)) OR cl_null(l_inpddocno) THEN 
                  LET l_inpe.inpedocno = l_inpddocno
                  LET l_inpe.inpeseq = l_inpdseq
                  IF NOT cl_null(l_inpddocno) AND cl_null(l_inpeseq2) THEN
                     SELECT MAX(inpeseq2)+1 INTO l_inpe.inpeseq2 FROM inpe_t
                      WHERE inpeent = g_enterprise
                        AND inpesite = g_site
                        AND inpedocno = l_inpddocno
                        AND inpeseq = l_inpdseq
                        
                     IF cl_null(l_inpe.inpeseq2) THEN
                        LET l_inpe.inpeseq2 = 1
                     END IF                     
                  END IF
                  IF cl_null(l_inpddocno) THEN
                     SELECT MAX(inpeseq2)+1 INTO l_inpe.inpeseq2 FROM inpe_t
                      WHERE inpeent = g_enterprise
                        AND inpesite = g_site
                        AND inpedocno = l_inpe.inpedocno
                        AND inpeseq = l_inpe.inpeseq
                     IF cl_null(l_inpe.inpeseq2) THEN
                        LET l_inpe.inpeseq2 = 1
                     END IF 
                  END IF
                  LET l_inpe.inpe008 = l_inai.inai007
                  LET l_inpe.inpe009 = l_inai.inai008
                  LET l_inpe.inpe012 = l_inai.inai011
                  LET l_inpe.inpe010 = l_inae010  #160512-00004#1 by whitney modify l_inai.inai012->l_inae010
                  SELECT COUNT(*) INTO l_inpe_cnt FROM inpe_t
                   WHERE inpeent = g_enterprise
                     AND inpesite = g_site
                     AND inpe001 = l_inpe.inpe001
                     AND inpe002 = l_inpe.inpe002
                     AND inpe003 = l_inpe.inpe003
                     AND inpe005 = l_inpe.inpe005
                     AND inpe006 = l_inpe.inpe006
                     AND inpe007 = l_inpe.inpe007
                     AND inpe008 = l_inpe.inpe008
                     AND inpe009 = l_inpe.inpe009
                  IF cl_null(l_inpe_cnt) THEN LET l_inpe_cnt = 0 END IF 
                  IF l_inpe_cnt > 0 AND l_inpa.inpa008 = '1' THEN
                     CONTINUE FOREACH
                  END IF  
#                  CALL ainp860_inpe_recount() RETURNING l_inai010               
                  IF l_inpa.inpa008 = '2' THEN   #盤差輸入
                     LET l_inpe.inpe030 = l_inai.inai010
                     IF l_inpa.inpa010 = 'Y' THEN
                        LET l_inpe.inpe035 = l_inai.inai010
                     END IF
                     IF l_inpa.inpa011 = 'Y' THEN
                        LET l_inpe.inpe050 = l_inai.inai010
                     END IF 
                     IF l_inpa.inpa012 = 'Y' THEN
                        LET l_inpe.inpe055 = l_inai.inai010
                     END IF  
                  ELSE
                    #add by lixh 20150324
                     LET l_inpe.inpe030 = ''
                     LET l_inpe.inpe035 = ''
                     LET l_inpe.inpe050 = ''
                     LET l_inpe.inpe055 = ''
                    #add by lixh 20150324 
                  END IF             
               
#                  INSERT INTO inpe_t(inpeent,inpesite,inpedocno,inpeseq,inpeseq2,inpe001,inpe002,inpe003,inpe004,inpe005,
#                                     inpe006,inpe007,inpe008,inpe009,inpe010,inpe012,inpe30,inpe35,inpe50,inpe55)                                  
#                              VALUES(l_inpe.inpeent,l_inpe.inpesite,l_inpe.inpedocno,l_inpe.inpeseq,l_inpe.inpeseq2,l_inpe.inpe001,
#                                     l_inpe.inpe002,l_inpe.inpe003,l_inpe.inpe004,l_inpe.inpe005,l_inpe.inpe006,l_inpe.inpe007,l_inpe.inpe008,
#                                     l_inpe.inpe009,l_inpe.inpe010,l_inpe.inpe012,l_inpe.inpe030,l_inpe.inpe035,l_inpe.inpe050,l_inpe.inpe055)  

               INSERT INTO inpe_t (inpeent,inpesite,inpedocno,inpeseq,inpeseq2,inpe001,inpe002,inpe003,inpe004,inpe005,
                                   inpe006,inpe007,inpe008,inpe009,inpe010,inpe012,inpe030,inpe035,inpe050,inpe055)                                  
                           VALUES (l_inpe.inpeent,l_inpe.inpesite,l_inpe.inpedocno,l_inpe.inpeseq,l_inpe.inpeseq2,l_inpe.inpe001,
                                   l_inpe.inpe002,l_inpe.inpe003,l_inpe.inpe004,l_inpe.inpe005,l_inpe.inpe006,l_inpe.inpe007,l_inpe.inpe008,
                                   l_inpe.inpe009,l_inpe.inpe010,l_inpe.inpe012,l_inpe.inpe030,l_inpe.inpe035,l_inpe.inpe050,l_inpe.inpe055)   
                                   
                  IF SQLCA.sqlerrd[3] = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "inpe_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                     CALL s_transaction_end('N','0')
                     RETURN                
                  END IF  
               END IF               
            END FOREACH            
         END IF         
         LET g_master.stagenow = l_inpd.inpd001
         DISPLAY g_master.stagenow TO stagenow 
         LET g_stagecomplete = l_ac/g_count 
         IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
            LET g_stagecomplete = 40
         END IF   
         IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
            DISPLAY g_stagecomplete TO stagecomplete
         END IF   
         CALL ui.Interface.refresh() 
         LET l_ac = l_ac + 1                                      
         INITIALIZE l_inag.* TO NULL
         INITIALIZE l_inai.* TO NULL           
      END FOREACH        
   END IF
      IF g_master.blank1 = 'Y' AND g_master.number1 > 0 AND NOT cl_null(l_inpa.inpa019) THEN   #產生空白標籤
         IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
            LET g_inpddocno = ''
            SELECT DISTINCT inpddocno INTO g_inpddocno FROM inpd_t
             WHERE inpdent = g_enterprise
               AND inpdsite = g_site
               AND inpd008 = g_master.inpadocno
            IF NOT cl_null(l_inpa.inpa019) AND cl_null(g_inpddocno)  THEN
               CALL s_aooi200_gen_docno(g_site,l_inpa.inpa019,g_today,'aint830') 
                    RETURNING r_success,g_inpddocno            
            END IF
         END IF   
         FOR l_i = 1 TO g_master.number1
                INITIALIZE l_inpd.* TO NULL
                
                IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
                   LET l_inpd.inpddocno = g_inpddocno 
                   SELECT MAX(inpdseq)+1 INTO l_inpd.inpdseq FROM inpd_t
                    WHERE inpdent = g_enterprise
                      AND inpdsite = g_site
                      AND inpddocno = g_inpddocno    
                   IF cl_null(l_inpd.inpdseq) THEN LET l_inpd.inpdseq = 1 END IF      
                ELSE
                   #一料一盤點卡號 =>不同資料，依序增加   
                   LET g_inpddocno = ''
                   CALL s_aooi200_gen_docno(g_site,l_inpa.inpa019,g_today,'aint830')    
                        RETURNING r_success,g_inpddocno      
                   LET l_inpd.inpddocno = g_inpddocno    
                   LET l_inpd.inpdseq = 0                   
                END IF
                
                LET l_inpd.inpd008 = g_master.inpadocno
                LET l_inpd.inpd009 ='Y'
                LET l_inpd.inpd016 = g_user
                LET l_inpd.inpd017 = g_today   
                LET l_inpd.inpdownid = g_user
                LET l_inpd.inpdowndp = g_dept
                LET l_inpd.inpdcrtid = g_user
                LET l_inpd.inpdcrtdp = g_dept  
                LET l_inpd.inpdcrtdt = g_today
                LET l_inpd.inpdstus = 'N'
                #160704-00014 by whitney add start
                LET l_inpd.inpd030 = ''
                LET l_inpd.inpd031 = ''
                LET l_inpd.inpd036 = ''
                LET l_inpd.inpd037 = ''
                LET l_inpd.inpd050 = ''
                LET l_inpd.inpd051 = ''
                LET l_inpd.inpd056 = ''
                LET l_inpd.inpd057 = ''
                #160704-00014 by whitney add end
                INSERT INTO inpd_t (inpdent,inpdsite,inpddocno,inpdseq,inpd008,inpd009,inpd016,inpd017,
                                    inpd030,inpd031,inpd036,inpd037,inpd050,inpd051,inpd056,inpd057,  #160704-00014 by whitney add
                                    inpdownid,inpdowndp,inpdcrtid,inpdcrtdp,inpdcrtdt,inpdstus)
                            VALUES (g_enterprise,g_site,l_inpd.inpddocno,l_inpd.inpdseq,l_inpd.inpd008,l_inpd.inpd009,l_inpd.inpd016,l_inpd.inpd017,
                                    l_inpd.inpd030,l_inpd.inpd031,l_inpd.inpd036,l_inpd.inpd037,l_inpd.inpd050,l_inpd.inpd051,l_inpd.inpd056,l_inpd.inpd057,  #160704-00014 by whitney add
                                    l_inpd.inpdownid,l_inpd.inpdowndp,l_inpd.inpdcrtid,l_inpd.inpdcrtdp,l_inpd.inpdcrtdt,l_inpd.inpdstus)  
                IF SQLCA.sqlerrd[3] = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "std-00009"
                   LET g_errparam.extend = "inpd_t"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   CALL s_transaction_end('N','0')
                   RETURN                
                END IF  
               LET g_stagecomplete = l_ac/g_count    
               IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
                  LET g_stagecomplete = 40
               END IF                
               IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
                  DISPLAY g_stagecomplete TO stagecomplete
               END IF   
               CALL ui.Interface.refresh() 
               LET l_ac = l_ac + 1                  
         END FOR           
      END IF      
#   END IF
   
   #[T:在製工單盤點單頭檔]未過帳且生產料號不為空白   
   
   IF g_master.work = 'Y' AND NOT cl_null(l_inpa.inpa021) THEN   #在製工單盤點
      LET g_sql1 = " SELECT DISTINCT sfaadocno,sfaa010,sfaa017,sfaa012,sfaa013,sfaa016,sfaa049,sfaa050,sfaa051,sfaa056,sfba003 FROM sfaa_t,sfba_t ",
                   "  WHERE sfaaent = sfbaent ",
                   "    AND sfaadocno = sfbadocno ",
                   "    AND sfaaent = '",g_enterprise,"'",
                   "    AND sfaasite = '",g_site,"'",
                   "    AND sfaa065 = '0' ",  #151229-00017#1 mod '1'->'0'
                   "    AND sfba013 > 0 ",
                   "  ORDER BY sfaadocno,sfba003"                   
      CALL ainp860_inpf_order(l_inpa.inpa032,TRUE) 
      CALL ainp860_inpf_order(l_inpa.inpa033,FALSE)      
      CALL ainp860_inpf_order(l_inpa.inpa034,FALSE) 
      CALL ainp860_inpf_order(l_inpa.inpa035,FALSE) 
      CALL ainp860_inpf_order(l_inpa.inpa036,FALSE) 
      CALL ainp860_inpf_order(l_inpa.inpa037,FALSE)       
      #[T:在製工單盤點單頭檔]未過帳且生產料號不為空白      
      PREPARE ainp860_sfaa_pre FROM g_sql1
      DECLARE ainp860_sfaa_cur CURSOR FOR ainp860_sfaa_pre  
      
      IF l_inpa.inpa020 = '2' THEN  #同盤點卡號，用項次呈現
      
         SELECT DISTINCT inpfdocno INTO g_inpddocno FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpfsite = g_site
            AND inpf004 = g_master.inpadocno
            
         IF NOT cl_null(l_inpa.inpa021) AND cl_null(g_inpddocno) THEN
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa021,g_today,'aint835')    
                RETURNING r_success,g_inpddocno         
         END IF
      END IF  
     #LET l_sfbadocno_t = ''   #151229-00017#2 mark
      LET l_sfaadocno_t = ''   #151229-00017#2 add
      LET l_sfba003_t = ''      
#     FOREACH ainp860_sfaa_cur INTO l_sfaa.*,l_sfba.*
      FOREACH ainp860_sfaa_cur INTO l_sfaa.sfaadocno,l_sfaa.sfaa010,l_sfaa.sfaa017,l_sfaa.sfaa012,l_sfaa.sfaa013,
                                    l_sfaa.sfaa016,l_sfaa.sfaa049,l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa056,
                                    l_sfba.sfba003
         IF cl_null(l_sfba.sfba003) THEN LET l_sfba.sfba003 = ' ' END IF   #151229-00017#2 add
         
         #add by lixh 20151013
         CALL s_aooi200_get_slip(l_sfaa.sfaadocno) RETURNING l_success,l_slip
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM inpt_t
          WHERE inptent = g_enterprise
            AND inptdocno = g_master.inpadocno 
         IF l_cnt > 0 THEN
            LET l_sql = " SELECT DISTINCT inpt001 FROM inpt_t ",
                        "  WHERE inptent = ",g_enterprise,
                        "    AND inptdocno = '",g_master.inpadocno,"'"
            PREPARE ainp850_inpt_sel FROM l_sql
            DECLARE ainp850_inpt_cur CURSOR FOR ainp850_inpt_sel   
            LET l_yes = 'N' 
            FOREACH ainp850_inpt_cur INTO l_inpt001
               IF l_slip = l_inpt001 THEN
                  LET l_yes = 'Y'
                  EXIT FOREACH
               END IF
            END FOREACH
            IF l_yes = 'N' THEN
               CONTINUE FOREACH
            END IF
         END IF         
         #add by lixh 20151013
         
         IF l_inpa.inpa020 = '2' THEN 
            LET l_inpf.inpfdocno = g_inpddocno
           #151229-00017#2 mod -----(S)
           #IF l_sfbadocno_t <> l_sfba.sfbadocno OR l_sfbadocno_t IS NULL OR
           #  (l_sfbadocno_t = l_sfba.sfbadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN
            IF l_sfaadocno_t <> l_sfaa.sfaadocno OR l_sfaadocno_t IS NULL OR
              (l_sfaadocno_t = l_sfaa.sfaadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN
           #151229-00017#2 mod -----(E)
               SELECT MAX(inpfseq)+1 INTO l_inpf.inpfseq FROM inpf_t
                WHERE inpfent = g_enterprise
                  AND inpfsite = g_site
                  AND inpfdocno = g_inpddocno
              #LET l_sfbadocno_t = l_sfba.sfbadocno   #151229-00017#2 mark
               LET l_sfaadocno_t = l_sfaa.sfaadocno   #151229-00017#2 add
               LET l_sfba003_t = l_sfba.sfba003       
               IF cl_null(l_inpf.inpfseq) THEN LET l_inpf.inpfseq = 1 END IF               
            END IF               
         ELSE
            #一料一盤點卡
            IF NOT cl_null(l_inpa.inpa021) THEN               
              #151229-00017#2 mod -----(S)
              #IF l_sfbadocno_t <> l_sfba.sfbadocno OR l_sfbadocno_t IS NULL OR
              #  (l_sfbadocno_t = l_sfba.sfbadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN
               IF l_sfaadocno_t <> l_sfaa.sfaadocno OR l_sfaadocno_t IS NULL OR
                 (l_sfaadocno_t = l_sfaa.sfaadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN
              #151229-00017#2 mod -----(E)
                  CALL s_aooi200_gen_docno(g_site,l_inpa.inpa021,g_today,'aint835')    
                       RETURNING r_success,g_inpddocno  
                 #LET l_sfbadocno_t = l_sfba.sfbadocno   #151229-00017#2 mark
                  LET l_sfaadocno_t = l_sfaa.sfaadocno   #151229-00017#2 add
                  LET l_sfba003_t = l_sfba.sfba003                        
               END IF                   
            END IF      
            LET l_inpf.inpfdocno = g_inpddocno
            LET l_inpf.inpfseq = 0
         END IF
         
         LET l_inpf.inpf001 = l_sfaa.sfaadocno
         LET l_inpf.inpf002 = l_sfba.sfba003
         LET l_inpf.inpf003 = l_sfaa.sfaa010
         LET l_inpf.inpf004 = g_master.inpadocno
         LET l_inpf_cnt = 0
         
         SELECT COUNT(*) INTO l_inpf_cnt FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpfsite = g_site
            AND inpf001 = l_sfaa.sfaadocno
            AND inpf002 = l_sfba.sfba003
            AND inpf004 = g_master.inpadocno
            
         IF l_inpf_cnt > 0 THEN   #重新計算數量
            
         END IF 
         
         LET l_inpf.inpf005 = 'N'
         LET l_inpf.inpf006 = l_sfaa.sfaa017
         LET l_inpf.inpf007 = l_sfaa.sfaa012
         LET l_inpf.inpf008 = l_sfaa.sfaa013
         LET l_inpf.inpf009 = l_sfaa.sfaa016
         LET l_inpf.inpf010 = l_sfaa.sfaa049
         LET l_inpf.inpf011 = l_sfaa.sfaa050
         LET l_inpf.inpf012 = l_sfaa.sfaa051
         LET l_inpf.inpf013 = l_sfaa.sfaa056
         LET l_inpf.inpf015 = g_user
         LET l_inpf.inpf016 = g_today
         LET l_inpf.inpfownid = g_user
         LET l_inpf.inpfowndp = g_dept
         LET l_inpf.inpfcrtid = g_user
         LET l_inpf.inpfcrtdp = g_dept
         LET l_inpf.inpfcrtdt = g_today
         LET l_inpf.inpfstus = 'N'
         IF l_inpf_cnt = 0 THEN   #新增
            
            INSERT INTO inpf_t (inpfent,inpfsite,inpfdocno,inpfseq,inpf001,inpf002,inpf003,inpf004,inpf005,inpf006,inpf007,inpf008,inpf009,
                                inpf010,inpf011,inpf012,inpf013,inpf015,inpf016,inpfownid,inpfowndp,inpfcrtid,inpfcrtdp,inpfcrtdt,inpfstus)
                        VALUES (g_enterprise,g_site,l_inpf.inpfdocno,l_inpf.inpfseq,l_inpf.inpf001,l_inpf.inpf002,l_inpf.inpf003,l_inpf.inpf004,
                                l_inpf.inpf005,l_inpf.inpf006,l_inpf.inpf007,l_inpf.inpf008,l_inpf.inpf009,l_inpf.inpf010,l_inpf.inpf011,l_inpf.inpf012,
                                l_inpf.inpf013,l_inpf.inpf015,l_inpf.inpf016,l_inpf.inpfownid,l_inpf.inpfowndp,l_inpf.inpfcrtid,l_inpf.inpfcrtdp,l_inpf.inpfcrtdt,
                                l_inpf.inpfstus)
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inpf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               RETURN                
            END IF  
         ELSE
            #UPDATE            
            SELECT inpfdocno,inpfseq INTO l_inpfdocno,l_inpfseq FROM inpf_t
             WHERE inpfent = g_enterprise
               AND inpfsite = g_site
               AND inpf001 = l_inpf.inpf001
               AND inpf004 = g_master.inpadocno    
               
            UPDATE inpf_t SET inpf007 = l_inpf.inpf007,
                              inpf010 = l_inpf.inpf010,
                              inpf011 = l_inpf.inpf011,
                              inpf012 = l_inpf.inpf012,
                              inpf013 = l_inpf.inpf013
              WHERE inpfent = g_enterprise
                AND inpfsite = g_site
                AND inpfdocno = l_inpfdocno
                AND inpfseq = l_inpfseq                
                              
                              
         END IF         
         LET g_master.stagenow = l_inpf.inpf003
         DISPLAY g_master.stagenow TO stagenow      
         IF l_inpf_cnt > 0 THEN         
            #LET g_sql2 = " SELECT * FROM sfba_t",   #161104-00002#3 Mark By Ken 161105
            #161104-00002#3 Add By Ken 161105(S)
            LET g_sql2 = " SELECT ",
                         "        sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,  ",
                         "        sfba001,sfba002,sfba003,sfba004,sfba005,      ",
                         "        sfba006,sfba007,sfba008,sfba009,sfba010,      ",
                         "        sfba011,sfba012,sfba013,sfba014,sfba015,      ",
                         "        sfba016,sfba017,sfba018,sfba019,sfba020,      ",
                         "        sfba021,sfba022,sfba023,sfba024,sfba025,      ",
                         "        sfba026,sfba027,sfba028,sfba029,sfba030,      ",
                         "        sfba031,sfba032,sfba033,sfba034,sfba035,      ",
                         #161123-00042#3 Add By Ken 161124(S)
                         "        sfbaud001,sfbaud002,sfbaud003,sfbaud004,sfbaud005, ",
                         "        sfbaud006,sfbaud007,sfbaud008,sfbaud009,sfbaud010, ",
                         "        sfbaud011,sfbaud012,sfbaud013,sfbaud014,sfbaud015, ",
                         "        sfbaud016,sfbaud017,sfbaud018,sfbaud019,sfbaud020, ",
                         "        sfbaud021,sfbaud022,sfbaud023,sfbaud024,sfbaud025, ",
                         "        sfbaud026,sfbaud027,sfbaud028,sfbaud029,sfbaud030 ",
                         #161123-00042#3 Add By Ken 161124(E)
                         "   FROM sfba_t",
            #161104-00002#3 Add By Ken 161105(E)
                         "  WHERE sfbaent = '",g_enterprise,"'",
                         "    AND sfbadocno = '",l_sfaa.sfaadocno,"'",
                         "    AND sfba003 = '",l_sfba.sfba003,"'",
                         "    AND sfbasite = '",g_site,"'"
         ELSE
            #add by lixh 20141219
            #LET g_sql2 = " SELECT * FROM sfba_t",      #161104-00002#3 Mark By Ken 161105
            #161104-00002#3 Add By Ken 161105(S)
            LET g_sql2 = " SELECT ",
                         "        sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,  ",
                         "        sfba001,sfba002,sfba003,sfba004,sfba005,      ",
                         "        sfba006,sfba007,sfba008,sfba009,sfba010,      ",
                         "        sfba011,sfba012,sfba013,sfba014,sfba015,      ",
                         "        sfba016,sfba017,sfba018,sfba019,sfba020,      ",
                         "        sfba021,sfba022,sfba023,sfba024,sfba025,      ",
                         "        sfba026,sfba027,sfba028,sfba029,sfba030,      ",
                         "        sfba031,sfba032,sfba033,sfba034,sfba035,       ",
                         #161123-00042#3 Add By Ken 161124(S)
                         "        sfbaud001,sfbaud002,sfbaud003,sfbaud004,sfbaud005, ",
                         "        sfbaud006,sfbaud007,sfbaud008,sfbaud009,sfbaud010, ",
                         "        sfbaud011,sfbaud012,sfbaud013,sfbaud014,sfbaud015, ",
                         "        sfbaud016,sfbaud017,sfbaud018,sfbaud019,sfbaud020, ",
                         "        sfbaud021,sfbaud022,sfbaud023,sfbaud024,sfbaud025, ",
                         "        sfbaud026,sfbaud027,sfbaud028,sfbaud029,sfbaud030 ",
                         #161123-00042#3 Add By Ken 161124(E)                         
                         "   FROM sfba_t",
            #161104-00002#3 Add By Ken 161105(E)            
                         "  WHERE sfbaent = '",g_enterprise,"'",
                         "    AND sfbadocno = '",l_sfaa.sfaadocno,"'",
                         "    AND sfba003 = '",l_sfba.sfba003,"'",
                         "    AND sfbasite = '",g_site,"'"         
         END IF             
         PREPARE ainp860_sfba_pre FROM g_sql2
         DECLARE ainp860_sfba_cur CURSOR FOR ainp860_sfba_pre   
         #FOREACH ainp860_sfba_cur INTO l_sfba.*    #161104-00002#3 Mark By Ken 161105
         #161104-00002#3 Add By Ken 161105(S)
         FOREACH ainp860_sfba_cur INTO 
                                  l_sfba.sfbaent   ,   l_sfba.sfbasite  ,   l_sfba.sfbadocno ,   l_sfba.sfbaseq   ,   l_sfba.sfbaseq1  ,
                                  l_sfba.sfba001   ,   l_sfba.sfba002   ,   l_sfba.sfba003   ,   l_sfba.sfba004   ,   l_sfba.sfba005   ,
                                  l_sfba.sfba006   ,   l_sfba.sfba007   ,   l_sfba.sfba008   ,   l_sfba.sfba009   ,   l_sfba.sfba010   ,
                                  l_sfba.sfba011   ,   l_sfba.sfba012   ,   l_sfba.sfba013   ,   l_sfba.sfba014   ,   l_sfba.sfba015   ,
                                  l_sfba.sfba016   ,   l_sfba.sfba017   ,   l_sfba.sfba018   ,   l_sfba.sfba019   ,   l_sfba.sfba020   ,
                                  l_sfba.sfba021   ,   l_sfba.sfba022   ,   l_sfba.sfba023   ,   l_sfba.sfba024   ,   l_sfba.sfba025   ,
                                  l_sfba.sfba026   ,   l_sfba.sfba027   ,   l_sfba.sfba028   ,   l_sfba.sfba029   ,   l_sfba.sfba030   ,
                                  l_sfba.sfba031   ,   l_sfba.sfba032   ,   l_sfba.sfba033   ,   l_sfba.sfba034   ,   l_sfba.sfba035   ,
                                  #161123-00042#3 Add By Ken 161124(S)
                                  l_sfba.sfbaud001,l_sfba.sfbaud002,l_sfba.sfbaud003,l_sfba.sfbaud004,l_sfba.sfbaud005,
                                  l_sfba.sfbaud006,l_sfba.sfbaud007,l_sfba.sfbaud008,l_sfba.sfbaud009,l_sfba.sfbaud010,
                                  l_sfba.sfbaud011,l_sfba.sfbaud012,l_sfba.sfbaud013,l_sfba.sfbaud014,l_sfba.sfbaud015,
                                  l_sfba.sfbaud016,l_sfba.sfbaud017,l_sfba.sfbaud018,l_sfba.sfbaud019,l_sfba.sfbaud020,
                                  l_sfba.sfbaud021,l_sfba.sfbaud022,l_sfba.sfbaud023,l_sfba.sfbaud024,l_sfba.sfbaud025,
                                  l_sfba.sfbaud026,l_sfba.sfbaud027,l_sfba.sfbaud028,l_sfba.sfbaud029,l_sfba.sfbaud030
                                  #161123-00042#3 Add By Ken 161124(E)
         #161104-00002#3 Add By Ken 161105(E)
            LET l_inpg.inpgdocno = l_inpf.inpfdocno
            LET l_inpg.inpgseq = l_inpf.inpfseq
#            LET l_inpg.inpgseq1 = l_sfba.sfbaseq 
#            LET l_inpg.inpgseq2 = l_sfba.sfbaseq1 
            #add by lixh 20151023
            LET l_inpg.inpgseq1 = l_sfba.sfbaseq1    
            SELECT MAX(inpgseq2)+1 INTO l_inpg.inpgseq2 FROM inpg_t
             WHERE inpgent = g_enterprise
               AND inpgsite = g_site
               AND inpgdocno = l_inpg.inpgdocno
               AND inpgseq = l_inpg.inpgseq
               AND inpgseq1 = l_inpg.inpgseq1
            IF cl_null(l_inpg.inpgseq2) THEN LET l_inpg.inpgseq2 = 1 END IF   
            #add by lixh 20151023 
            LET l_inpg.inpg001 = l_sfba.sfba006
            LET l_inpg.inpg002 = l_sfba.sfba003
            LET l_inpg.inpg003 = l_sfba.sfba004
            LET l_inpg.inpg004 = l_sfba.sfba010
            LET l_inpg.inpg005 = l_sfba.sfba011            
            LET l_inpg.inpg006 = l_sfba.sfba013
            LET l_inpg.inpg007 = l_sfba.sfba014
            LET l_inpg.inpg008 = l_sfba.sfba016
            LET l_inpg.inpg009 = l_sfba.sfba017
            LET l_inpg.inpg010 = l_sfba.sfba021
            LET l_inpg.inpg011 = l_sfba.sfba025
            LET l_inpg.inpg015 = l_sfba.sfba021 #產品特徵   #add by lixh 20151110
            LET l_inpg.inpg012 = (l_sfaa.sfaa050+l_sfaa.sfaa056)*(l_sfba.sfba010/l_sfba.sfba011)+l_sfba.sfba017
            IF l_inpa.inpa008 = '1' THEN   #全盤輸入
               #add by lixh 20150324
               LET l_inpg.inpg030 = ''
               LET l_inpg.inpg033 = ''
               LET l_inpg.inpg050 = ''
               LET l_inpg.inpg053 = ''
               #add by lixh 20150324
            END IF
            IF l_inpa.inpa008 = '2' THEN   #盘差输入
               LET l_inpg.inpg030 = l_inpg.inpg012
               LET l_inpg.inpg033 = l_inpg.inpg012
               LET l_inpg.inpg050 = l_inpg.inpg012
               LET l_inpg.inpg053 = l_inpg.inpg012            
            END IF  
            
            LET l_inpg_cnt = 0
            IF l_inpf_cnt > 0 THEN
            
               SELECT COUNT(*) INTO l_inpg_cnt FROM inpg_t
                WHERE inpgent = g_enterprise
                  AND inpgsite = g_site
                  AND inpgdocno = l_inpfdocno
                  AND inpgseq = l_inpfseq
                  AND inpgseq1 = l_inpg.inpgseq1
                  AND inpgseq2 = l_inpg.inpgseq2
                  AND inpg001 = l_sfba.sfba006
                  AND inpg002 = l_sfba.sfba003
               IF cl_null(l_inpg_cnt) THEN LET l_inpg_cnt = 0 END IF                    
            END IF   
               
            IF cl_null(l_inpg_cnt) THEN LET l_inpg_cnt = 0 END IF   
            IF (l_inpf_cnt > 0 AND l_inpg_cnt = 0) OR l_inpf_cnt = 0  THEN            
               INSERT INTO inpg_t (inpgent,inpgsite,inpgdocno,inpgseq,inpgseq1,inpgseq2,inpg001,inpg002,inpg003,inpg004,
                                 inpg005,inpg006,inpg007,inpg008,inpg009,inpg010,inpg011,inpg012,inpg015,inpg030,inpg033,inpg050,inpg053)    #add by lixh 20151110 add inpg015
                                  
                          VALUES(g_enterprise,g_site,l_inpg.inpgdocno,l_inpg.inpgseq,l_inpg.inpgseq1,l_inpg.inpgseq2,l_inpg.inpg001,l_inpg.inpg002,l_inpg.inpg003,l_inpg.inpg004,
                                 l_inpg.inpg005,l_inpg.inpg006,l_inpg.inpg007,l_inpg.inpg008,l_inpg.inpg009,l_inpg.inpg010,l_inpg.inpg011,l_inpg.inpg012,l_inpg.inpg015,
                                 l_inpg.inpg030,l_inpg.inpg033,l_inpg.inpg050,l_inpg.inpg053) 
               IF SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "inpf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  CALL s_transaction_end('N','0')
                  RETURN                
               END IF 
            ELSE
               #重計數量
               #update
               UPDATE inpg_t SET inpg030 = l_inpg.inpg030,
                                 inpg033 = l_inpg.inpg033,
                                 inpg050 = l_inpg.inpg050,
                                 inpg053 = l_inpg.inpg035
                 WHERE inpgent = g_enterprise
                   AND inpgsite = g_site
                   AND inpgdocno = l_inpg.inpgdocno
                   AND inpgseq = l_inpg.inpgseq
                   AND inpgseq1 = l_inpg.inpgseq1
                   AND inpgseq2 = l_inpg.inpgseq2                   
                                 
            END IF  
         LET g_master.stagenow = l_inpf.inpf003
         DISPLAY g_master.stagenow TO stagenow 
         LET g_stagecomplete = l_ac/g_count 
         IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
            LET g_stagecomplete = 40
         END IF          
         IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
            DISPLAY g_stagecomplete TO stagecomplete
         END IF   
         CALL ui.Interface.refresh() 
         LET l_ac = l_ac + 1               
         END FOREACH         
      END FOREACH
      END IF
      IF g_master.blank2 = 'Y' THEN   #產生在製程工單空白標籤
         LET g_inpddocno = ''
         IF NOT cl_null(l_inpa.inpa022) THEN
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa022,g_today,'aint835')    
                 RETURNING r_success,g_inpddocno            
         END IF
      　 FOR l_i = 1 TO g_master.number2
             IF l_inpa.inpa020 = '2' THEN    #同盤點卡
                LET l_inpf.inpfdocno = g_inpddocno
                LET l_inpf.inpfseq = l_i
             END IF
             IF l_inpa.inpa020 = '1' THEN    #一料一盤點卡
                CALL s_aooi200_gen_docno(g_site,l_inpa.inpa022,g_today,'aint835')    
                     RETURNING r_success,g_inpddocno 
                LET l_inpf.inpfdocno = g_inpddocno     
                LET l_inpf.inpfseq = 0
             END IF      
             LET l_inpf.inpf005 = 'Y'
             LET l_inpf.inpf004 = g_master.inpadocno
             LET l_inpf.inpf015 = g_user
             LET l_inpf.inpf016 = g_today     
             LET l_inpf.inpfownid = g_user
             LET l_inpf.inpfowndp = g_dept
             LET l_inpf.inpfcrtid = g_user
             LET l_inpf.inpfcrtdp = g_dept
             LET l_inpf.inpfcrtdt = g_today
             LET l_inpf.inpfstus = 'N'       
             INSERT INTO inpf_t (inpfent,inpfsite,inpfdocno,inpfseq,inpf004,inpf005,inpf015,inpf016,inpfownid,inpfowndp,inpfcrtid,
                                 inpfcrtdp,inpfcrtdt,inpfstus)
                         VALUES (g_enterprise,g_site,l_inpf.inpfdocno,l_inpf.inpfseq,l_inpf.inpf004,l_inpf.inpf005,l_inpf.inpf015,l_inpf.inpf016,
                                 l_inpf.inpfownid,l_inpf.inpfowndp,l_inpf.inpfcrtid,l_inpf.inpfcrtdp,l_inpf.inpfcrtdt,l_inpf.inpfstus) 
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inpf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               RETURN                
            END IF   
            LET g_stagecomplete = l_ac/g_count 
            IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
               LET g_stagecomplete = 40
            END IF             
            IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
               DISPLAY g_stagecomplete TO stagecomplete
            END IF   
            CALL ui.Interface.refresh() 
            LET l_ac = l_ac + 1                 
         END FOR
      END IF
      DISPLAY 100 TO stagecomplete
#   END IF  
   #add by lixh 20151103
   UPDATE inpb_t SET inpb002 = 'Y',
                     inpb003 = 100,
                     inpb006 = g_user,
                     inpb007 = g_today
    WHERE inpbent = g_enterprise
      AND inpbsite = g_site
      AND inpbdocno = g_master.inpadocno
      AND inpb001 = '5'
   #add by lixh 20151103  
   
#160321-00006#1  
   UPDATE inpa_t SET inpa041 = g_today
    WHERE inpaent = g_enterprise
      AND inpasite = g_site
      AND inpadocno = g_master.inpadocno
#160321-00006#1 

   CALL s_transaction_end('Y','0')
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
   CALL ainp860_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ainp860.get_buffer" >}
PRIVATE FUNCTION ainp860_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.inpadocno = p_dialog.getFieldBuffer('inpadocno')
   LET g_master.stock = p_dialog.getFieldBuffer('stock')
   LET g_master.blank1 = p_dialog.getFieldBuffer('blank1')
   LET g_master.number1 = p_dialog.getFieldBuffer('number1')
   LET g_master.work = p_dialog.getFieldBuffer('work')
   LET g_master.blank2 = p_dialog.getFieldBuffer('blank2')
   LET g_master.number2 = p_dialog.getFieldBuffer('number2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainp860.msgcentre_notify" >}
PRIVATE FUNCTION ainp860_msgcentre_notify()
 
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
 
{<section id="ainp860.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 員工说明
# Memo...........:
# Usage..........: CALL ainp860_inpa002_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_inpa002_desc()
DEFINE l_yy    LIKE type_t.num5
DEFINE l_mm    LIKE type_t.num5
DEFINE l_date  LIKE inpd_t.inpd017

   SELECT inpa002,inpa040 INTO g_master.inpa002,l_date FROM inpa_t 
    WHERE inpaent = g_enterprise
      AND inpadocno = g_master.inpadocno
   CALL s_desc_get_person_desc(g_master.inpa002) RETURNING g_master.inpa002_desc
   
   LET g_master.date01 = l_date
   IF cl_null(g_master.date01) THEN LET g_master.date01 = g_today END IF

   LET l_yy = YEAR(l_date)
   LET l_mm = MONTH(l_date)
   LET b_date = MDY(l_mm,1,l_yy)  
   IF l_mm = 1 THEN 
      LET l_mm = 12
      LET l_yy = l_yy - 1
   ELSE
      LET l_mm = l_mm - 1   
   END IF 
   
   DISPLAY BY NAME g_master.inpa002_desc
   DISPLAY BY NAME g_master.inpa002
   DISPLAY g_master.date01 TO date01
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp860_set_entry()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_set_entry()
   CALL cl_set_comp_entry("stock,blank1,number1,work,blank2,number2",TRUE) 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp860_set_no_entry()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_set_no_entry()
DEFINE l_inpa009    LIKE inpa_t.inpa009
DEFINE l_inpa010    LIKE inpa_t.inpa009
DEFINE l_inpa011    LIKE inpa_t.inpa009
DEFINE l_inpa012    LIKE inpa_t.inpa009
DEFINE l_inpa013    LIKE inpa_t.inpa009
DEFINE l_inpa014    LIKE inpa_t.inpa009
DEFINE l_inpa015    LIKE inpa_t.inpa009
DEFINE l_inpa016    LIKE inpa_t.inpa009

#   SELECT inpa009,inpa010,inpa011,inpa012,inpa013,inpa014,inpa015,inpa016 
#     INTO l_inpa009,l_inpa010,l_inpa011,l_inpa012,l_inpa013,l_inpa014,l_inpa015,l_inpa016
#     FROM inpa_t
#    WHERE inpaent = g_enterprise
#      AND inpadocno = g_master.inpadocno
#      
#   IF l_inpa009 = 'N' AND l_inpa010 = 'N' AND l_inpa011 = 'N' AND l_inpa012 = 'N' THEN
#      CALL cl_set_comp_entry("stock,blank1,number1",FALSE)      
#   END IF
#   
#   IF l_inpa013 = 'N' AND l_inpa014 = 'N' AND l_inpa015 = 'N' AND l_inpa016 = 'N' THEN
#      CALL cl_set_comp_entry("work,blank2,number2",FALSE)      
#   END IF   
#   IF g_master.blank1 = 'N' THEN
#      CALL cl_set_comp_entry("number1",FALSE)
#   END IF
#   IF g_master.blank2 = 'N' THEN
#      CALL cl_set_comp_entry("number2",FALSE)
#   END IF 

   CALL cl_set_comp_entry("stock,blank1,number1,work,blank2,number2",TRUE)  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp860_inpd_order(p_order,p_flag,p_inpa031)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_inpd_order(p_order,p_flag,p_inpa031)
DEFINE p_order   LIKE type_t.chr1
DEFINE p_flag    LIKE type_t.num5
DEFINE p_inpa031 LIKE inpa_t.inpa031

   IF cl_null(p_order) OR p_order = '7' THEN
      RETURN
   END IF    
   IF cl_null(g_sql) THEN LET g_sql = " 1=1 " END IF
   IF p_flag THEN
      LET g_sql = g_sql ," ORDER BY "
   END IF
   IF p_order = '1' THEN
      IF p_flag THEN 
         LET g_sql = g_sql," imaf052"
      ELSE
         LET g_sql = g_sql,",imaf052"  
      END IF         
   END IF
   IF p_order = '2' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag004"
      ELSE
         LET g_sql = g_sql,",inag004"
      END IF   
   END IF  
   IF p_order = '3' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag005"
      ELSE
         LET g_sql = g_sql,",inag005"
      END IF   
   END IF    
   IF p_order = '4' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag006"
      ELSE         
         LET g_sql = g_sql,",inag006"
      END IF
   END IF
   IF p_order = '5' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag001"
      ELSE   
         LET g_sql = g_sql,",inag001"
      END IF   
   END IF 
   IF p_order = '6' THEN
      IF p_inpa031 = '1' THEN    #產品分群
         IF p_flag THEN 
            LET g_sql = g_sql," imaf011"
         ELSE            
            LET g_sql = g_sql,",imaf011"
         END IF   
      END IF
      IF p_inpa031 = '2' THEN    #庫存分群
         IF p_flag THEN 
            LET g_sql = g_sql," imaf051"
         ELSE   
            LET g_sql = g_sql,",imaf051"
         END IF   
      END IF
   END IF   
   IF p_order = '8' THEN
      IF p_flag THEN 
         LET g_sql = g_sql," imaf057"
      ELSE
         LET g_sql = g_sql,",imaf057"
      END IF    
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp860_inpf_order(p_order,p_flag)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_inpf_order(p_order,p_flag)
DEFINE p_order   LIKE type_t.chr1
DEFINE p_flag    LIKE type_t.num5
   IF cl_null(p_order) THEN RETURN END IF
   IF cl_null(g_sql1) THEN LET g_sql1 = " 1=1 " END IF
#   IF p_flag THEN
#      LET g_sql1= g_sql1 ," ORDER BY "
#   END IF
   IF p_order = '1' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa010"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa010"      
#      END IF   
      LET g_sql1 = g_sql1,",sfaa010"
   END IF
   IF p_order = '2' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa020"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa020"
#      END IF      
      LET g_sql1 = g_sql1,",sfaa020"
   END IF   
   IF p_order = '3' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaastus"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaastus" 
#      END IF  
      LET g_sql1 = g_sql1,",sfaastus"
   END IF   
   IF p_order = '4' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa003"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa003"  
#      END IF  
      LET g_sql1 = g_sql1,",sfaa003"
   END IF   
   IF p_order = '5' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaadocno"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaadocno"     
#      END IF    
      LET g_sql1 = g_sql1,",sfaadocno" 
   END IF  
   IF p_order = '6' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa017"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa017"  
#      END IF         
      LET g_sql1 = g_sql1,",sfaa017"  
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 現有庫存數量重計
# Memo...........:
# Usage..........: CALL ainp860_inpd_recount()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_inpd_recount()

END FUNCTION

################################################################################
# Descriptions...: 批序號數量重計
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_inpe_recount()

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp860_set_required()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_set_required()
   IF g_master.blank1 = 'Y' THEN  
      CALL cl_set_comp_required("number1",TRUE)
   END IF
   IF g_master.blank2 = 'Y' THEN    
      CALL cl_set_comp_required("number2",TRUE)
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp860_set_no_required()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp860_set_no_required()
   CALL cl_set_comp_required("number1",FALSE)
   CALL cl_set_comp_required("number2",FALSE)
END FUNCTION

#end add-point
 
{</section>}
 
