#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp870.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-07-31 10:59:33), PR版次:0004(2016-12-09 11:13:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: ainp870
#+ Description: 空白標籤產生作業
#+ Creator....: 01534(2014-07-08 14:20:38)
#+ Modifier...: 01534 -SD/PR- 08734
 
{</section>}
 
{<section id="ainp870.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161124-00048#4  16/12/09 By 08734   星号整批调整
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
   blank1 LIKE type_t.chr1, 
   number1 LIKE type_t.num10, 
   blank2 LIKE type_t.chr1, 
   number2 LIKE type_t.num10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_t  type_master
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp870.main" >}
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
      CALL ainp870_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp870 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainp870_init()
 
      #進入選單 Menu (="N")
      CALL ainp870_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp870
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp870.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainp870_init()
 
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
   IF cl_null(g_master.blank1) THEN LET g_master.blank1 = 'N' END IF
   IF cl_null(g_master.blank2) THEN LET g_master.blank2 = 'N' END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp870.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp870_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt       LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.inpadocno,g_master.blank1,g_master.number1,g_master.blank2,g_master.number2  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.blank1 = 'N'
               LET g_master.blank2 = 'N'
               LET g_master.number1 = ''
               LET g_master.number2 = ''
               CALL ainp870_set_entry()
               CALL ainp870_set_no_required()
               CALL ainp870_set_required()                 
               CALL ainp870_set_no_entry()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpadocno
            
            #add-point:AFTER FIELD inpadocno name="input.a.inpadocno"
               CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc
               DISPLAY BY NAME g_master.inpadocno_desc  
               IF NOT cl_null(g_master.inpadocno) THEN 

                  INITIALIZE g_chkparam.* TO NULL
               
                  LET g_chkparam.arg1 = g_master.inpadocno
                  
                  IF cl_chk_exist("v_inpadocno") THEN
                  ELSE
                     LET g_master.inpadocno = g_master_t.inpadocno
                     CALL ainp870_inpa002_desc()
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
                     LET g_errparam.code = "ain-00302"
                     LET g_errparam.extend = "inpd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     LET g_master.inpadocno = g_master_t.inpadocno      
                     CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc 
                     DISPLAY BY NAME g_master.inpadocno_desc                     
                     NEXT FIELD inpadocno
                  END IF                  
                  CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc 
                  DISPLAY BY NAME g_master.inpadocno_desc                  
                  CALL ainp870_inpa002_desc()
               ELSE 
                  LET g_master.inpa002 = ''
                  LET g_master.inpa002_desc = '' 
                  DISPLAY BY NAME g_master.inpa002_desc 
                  DISPLAY BY NAME g_master.inpa002                  
               END IF
               CALL ainp870_set_entry()
               CALL ainp870_set_no_required()
               CALL ainp870_set_required()                 
               CALL ainp870_set_no_entry()               
               NEXT FIELD blank1
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
         BEFORE FIELD blank1
            #add-point:BEFORE FIELD blank1 name="input.b.blank1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD blank1
            
            #add-point:AFTER FIELD blank1 name="input.a.blank1"
               CALL ainp870_set_entry()
               CALL ainp870_set_no_required()
               CALL ainp870_set_required()                 
               CALL ainp870_set_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE blank1
            #add-point:ON CHANGE blank1 name="input.g.blank1"
               CALL ainp870_set_entry()
               CALL ainp870_set_no_required()
               CALL ainp870_set_required()                 
               CALL ainp870_set_no_entry()
            IF g_master.blank1 = 'N' THEN 
               LET g_master.number1 = ''
               DISPLAY g_master.number1 TO number1
            END IF                   
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.number1,"0","0","","","azz-00079",1) THEN
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
         BEFORE FIELD blank2
            #add-point:BEFORE FIELD blank2 name="input.b.blank2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD blank2
            
            #add-point:AFTER FIELD blank2 name="input.a.blank2"
               CALL ainp870_set_entry()
               CALL ainp870_set_no_required()
               CALL ainp870_set_required()                 
               CALL ainp870_set_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE blank2
            #add-point:ON CHANGE blank2 name="input.g.blank2"
               CALL ainp870_set_entry()
               CALL ainp870_set_no_required()
               CALL ainp870_set_required()                 
               CALL ainp870_set_no_entry()
            IF g_master.blank2 = 'N' THEN 
               LET g_master.number2 = ''
               DISPLAY g_master.number2 TO number2
            END IF                   
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.number2,"0","0","","","azz-00079",1) THEN
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
            
            CALL q_inpadocno_3()                                #呼叫開窗

            LET g_master.inpadocno = g_qryparam.return1              

            DISPLAY g_master.inpadocno TO inpadocno              #

            NEXT FIELD inpadocno                          #返回原欄位


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
            CALL ainp870_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
               LET g_master.blank1 = 'N'
               LET g_master.blank2 = 'N'
               LET g_master.number1 = ''
               LET g_master.number2 = ''
               DISPLAY g_master.blank1 TO blank1
               DISPLAY g_master.blank2 TO blank2
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
         CALL ainp870_init()
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
                 CALL ainp870_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainp870_transfer_argv(ls_js)
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
 
{<section id="ainp870.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainp870_transfer_argv(ls_js)
 
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
 
{<section id="ainp870.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainp870_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   #DEFINE l_inpa      RECORD LIKE inpa_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpa RECORD  #盤點計劃單頭檔
       inpaent LIKE inpa_t.inpaent, #企业编号
       inpasite LIKE inpa_t.inpasite, #营运据点
       inpadocno LIKE inpa_t.inpadocno, #计划单号
       inpadocdt LIKE inpa_t.inpadocdt, #录入日期
       inpa001 LIKE inpa_t.inpa001, #盘点类型
       inpa002 LIKE inpa_t.inpa002, #计划人员
       inpa003 LIKE inpa_t.inpa003, #计划部门
       inpa004 LIKE inpa_t.inpa004, #总负责人
       inpa005 LIKE inpa_t.inpa005, #存货预计冻结日
       inpa006 LIKE inpa_t.inpa006, #存货实际冻结日
       inpa007 LIKE inpa_t.inpa007, #备注
       inpa008 LIKE inpa_t.inpa008, #盘点录入方式
       inpa009 LIKE inpa_t.inpa009, #现有库存初盘一
       inpa010 LIKE inpa_t.inpa010, #现有库存初盘二
       inpa011 LIKE inpa_t.inpa011, #现有库存复盘一
       inpa012 LIKE inpa_t.inpa012, #现有库存复盘二
       inpa013 LIKE inpa_t.inpa013, #在制工单初盘一
       inpa014 LIKE inpa_t.inpa014, #在制工单初盘二
       inpa015 LIKE inpa_t.inpa015, #在制工单复盘一
       inpa016 LIKE inpa_t.inpa016, #在制工单复盘二
       inpa017 LIKE inpa_t.inpa017, #包含已无库存量
       inpa018 LIKE inpa_t.inpa018, #存货盘点单别
       inpa019 LIKE inpa_t.inpa019, #存货空白单别
       inpa020 LIKE inpa_t.inpa020, #生成方式
       inpa021 LIKE inpa_t.inpa021, #在制盘点单别
       inpa022 LIKE inpa_t.inpa022, #在制空白单别
       inpa023 LIKE inpa_t.inpa023, #盘点打印方式
       inpa024 LIKE inpa_t.inpa024, #显示账上库存数
       inpa025 LIKE inpa_t.inpa025, #存货排序一
       inpa026 LIKE inpa_t.inpa026, #存货排序二
       inpa027 LIKE inpa_t.inpa027, #存货排序三
       inpa028 LIKE inpa_t.inpa028, #存货排序四
       inpa029 LIKE inpa_t.inpa029, #存货排序五
       inpa030 LIKE inpa_t.inpa030, #存货排序六
       inpa031 LIKE inpa_t.inpa031, #分群码选项
       inpa032 LIKE inpa_t.inpa032, #在制排序一
       inpa033 LIKE inpa_t.inpa033, #在制排序二
       inpa034 LIKE inpa_t.inpa034, #在制排序三
       inpa035 LIKE inpa_t.inpa035, #在制排序四
       inpa036 LIKE inpa_t.inpa036, #在制排序五
       inpa037 LIKE inpa_t.inpa037, #在制排序六
       inpa038 LIKE inpa_t.inpa038, #开始日期
       inpa039 LIKE inpa_t.inpa039, #截止日期
       inpa050 LIKE inpa_t.inpa050, #盘点杂收单别
       inpa051 LIKE inpa_t.inpa051, #盘点杂发单别
       inpa052 LIKE inpa_t.inpa052, #盘点发料单别
       inpa053 LIKE inpa_t.inpa053, #盘点退料单别
       inpa054 LIKE inpa_t.inpa054, #盘点超领单别
       inpaownid LIKE inpa_t.inpaownid, #资料所有者
       inpaowndp LIKE inpa_t.inpaowndp, #资料所有部门
       inpacrtid LIKE inpa_t.inpacrtid, #资料录入者
       inpacrtdp LIKE inpa_t.inpacrtdp, #资料录入部门
       inpacrtdt LIKE inpa_t.inpacrtdt, #资料创建日
       inpamodid LIKE inpa_t.inpamodid, #资料更改者
       inpamoddt LIKE inpa_t.inpamoddt, #最近更改日
       inpacnfid LIKE inpa_t.inpacnfid, #资料审核者
       inpacnfdt LIKE inpa_t.inpacnfdt, #数据审核日
       inpapstid LIKE inpa_t.inpapstid, #资料过账者
       inpapstdt LIKE inpa_t.inpapstdt, #资料过账日
       inpastus LIKE inpa_t.inpastus, #状态码
       inpa040 LIKE inpa_t.inpa040, #盘点日期
       inpa041 LIKE inpa_t.inpa041, #最近重计日
       inpa042 LIKE inpa_t.inpa042, #在制盘差处理仓
       inpa043 LIKE inpa_t.inpa043 #在制盘差处理储位
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   DEFINE l_cnt       LIKE type_t.num5  
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1   
   #DEFINE l_inpd      RECORD LIKE inpd_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpd RECORD  #盤點明細檔
       inpdent LIKE inpd_t.inpdent, #企业编号
       inpdsite LIKE inpd_t.inpdsite, #营运据点
       inpddocno LIKE inpd_t.inpddocno, #标签编号
       inpdseq LIKE inpd_t.inpdseq, #项次
       inpd001 LIKE inpd_t.inpd001, #料件编号
       inpd002 LIKE inpd_t.inpd002, #产品特征
       inpd003 LIKE inpd_t.inpd003, #库存管理特征
       inpd004 LIKE inpd_t.inpd004, #包装容器编号
       inpd005 LIKE inpd_t.inpd005, #库位编号
       inpd006 LIKE inpd_t.inpd006, #储位编号
       inpd007 LIKE inpd_t.inpd007, #批号
       inpd008 LIKE inpd_t.inpd008, #盘点计划单号
       inpd009 LIKE inpd_t.inpd009, #空白标签
       inpd010 LIKE inpd_t.inpd010, #库存单位
       inpd011 LIKE inpd_t.inpd011, #现有库存量
       inpd012 LIKE inpd_t.inpd012, #参考单位
       inpd013 LIKE inpd_t.inpd013, #参考单位现有库存量
       inpd014 LIKE inpd_t.inpd014, #理由码
       inpd015 LIKE inpd_t.inpd015, #备注
       inpd016 LIKE inpd_t.inpd016, #生成人员
       inpd017 LIKE inpd_t.inpd017, #生成日期
       inpd018 LIKE inpd_t.inpd018, #打印日期
       inpd019 LIKE inpd_t.inpd019, #打印次数
       inpd030 LIKE inpd_t.inpd030, #盘点数量-初盘(一)
       inpd031 LIKE inpd_t.inpd031, #参考单位盘点量-初盘(一)
       inpd032 LIKE inpd_t.inpd032, #录入人员-初盘(一)
       inpd033 LIKE inpd_t.inpd033, #录入日期-初盘(一)
       inpd034 LIKE inpd_t.inpd034, #盘点人员-初盘(一)
       inpd035 LIKE inpd_t.inpd035, #盘点日期-初盘(一)
       inpd036 LIKE inpd_t.inpd036, #盘点数量-初盘(二)
       inpd037 LIKE inpd_t.inpd037, #参考单位盘点量-初盘(二)
       inpd038 LIKE inpd_t.inpd038, #录入人员-初盘(二)
       inpd039 LIKE inpd_t.inpd039, #录入日期-初盘(二)
       inpd040 LIKE inpd_t.inpd040, #盘点人员-初盘(二)
       inpd041 LIKE inpd_t.inpd041, #盘点日期-初盘(二)
       inpd050 LIKE inpd_t.inpd050, #盘点数量-复盘(一)
       inpd051 LIKE inpd_t.inpd051, #参考单位盘点量-复盘(一)
       inpd052 LIKE inpd_t.inpd052, #录入人员-复盘(一)
       inpd053 LIKE inpd_t.inpd053, #录入日期-复盘(一)
       inpd054 LIKE inpd_t.inpd054, #盘点人员-复盘(一)
       inpd055 LIKE inpd_t.inpd055, #盘点日期-复盘(一)
       inpd056 LIKE inpd_t.inpd056, #盘点数量-复盘(二)
       inpd057 LIKE inpd_t.inpd057, #参考单位盘点量-复盘(二)
       inpd058 LIKE inpd_t.inpd058, #录入人员-复盘(二)
       inpd059 LIKE inpd_t.inpd059, #录入日期-复盘(二)
       inpd060 LIKE inpd_t.inpd060, #盘点人员-复盘(二)
       inpd061 LIKE inpd_t.inpd061, #盘点日期-复盘(二)
       inpdownid LIKE inpd_t.inpdownid, #资料所有者
       inpdowndp LIKE inpd_t.inpdowndp, #资料所有部门
       inpdcrtid LIKE inpd_t.inpdcrtid, #资料录入者
       inpdcrtdp LIKE inpd_t.inpdcrtdp, #资料录入部门
       inpdcrtdt LIKE inpd_t.inpdcrtdt, #资料创建日
       inpdmodid LIKE inpd_t.inpdmodid, #资料更改者
       inpdmoddt LIKE inpd_t.inpdmoddt, #最近更改日
       inpdcnfid LIKE inpd_t.inpdcnfid, #资料审核者
       inpdcnfdt LIKE inpd_t.inpdcnfdt, #数据审核日
       inpdpstid LIKE inpd_t.inpdpstid, #资料过账者
       inpdpstdt LIKE inpd_t.inpdpstdt, #资料过账日
       inpdstus LIKE inpd_t.inpdstus #状态码
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   DEFINE g_inpddocno LIKE inpa_t.inpadocno
   DEFINE r_success   LIKE type_t.num5
   #DEFINE l_inpf      RECORD LIKE inpf_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpf RECORD  #在製工單盤點單頭檔
       inpfent LIKE inpf_t.inpfent, #企业编号
       inpfsite LIKE inpf_t.inpfsite, #营运据点
       inpfdocno LIKE inpf_t.inpfdocno, #标签编号
       inpfseq LIKE inpf_t.inpfseq, #项次
       inpf001 LIKE inpf_t.inpf001, #工单单号
       inpf002 LIKE inpf_t.inpf002, #作业编号
       inpf003 LIKE inpf_t.inpf003, #生产料号
       inpf004 LIKE inpf_t.inpf004, #盘点计划单号
       inpf005 LIKE inpf_t.inpf005, #空白标签
       inpf006 LIKE inpf_t.inpf006, #部门供应商
       inpf007 LIKE inpf_t.inpf007, #生产数量
       inpf008 LIKE inpf_t.inpf008, #生产单位
       inpf009 LIKE inpf_t.inpf009, #工艺编号
       inpf010 LIKE inpf_t.inpf010, #已发料套数
       inpf011 LIKE inpf_t.inpf011, #已入库合格量
       inpf012 LIKE inpf_t.inpf012, #已入库不合格量
       inpf013 LIKE inpf_t.inpf013, #报废量
       inpf014 LIKE inpf_t.inpf014, #备注
       inpf015 LIKE inpf_t.inpf015, #生成人员
       inpf016 LIKE inpf_t.inpf016, #生成日期
       inpf017 LIKE inpf_t.inpf017, #打印日期
       inpf018 LIKE inpf_t.inpf018, #打印次数
       inpf020 LIKE inpf_t.inpf020, #录入人员-初盘一
       inpf021 LIKE inpf_t.inpf021, #录入日期-初盘一
       inpf022 LIKE inpf_t.inpf022, #录入人员-初盘二
       inpf023 LIKE inpf_t.inpf023, #录入日期-初盘二
       inpf024 LIKE inpf_t.inpf024, #录入人员-复盘一
       inpf025 LIKE inpf_t.inpf025, #录入日期-复盘一
       inpf026 LIKE inpf_t.inpf026, #录入人员-复盘二
       inpf027 LIKE inpf_t.inpf027, #录入日期-复盘二
       inpfownid LIKE inpf_t.inpfownid, #资料所有者
       inpfowndp LIKE inpf_t.inpfowndp, #资料所有部门
       inpfcrtid LIKE inpf_t.inpfcrtid, #资料录入者
       inpfcrtdp LIKE inpf_t.inpfcrtdp, #资料录入部门
       inpfcrtdt LIKE inpf_t.inpfcrtdt, #资料创建日
       inpfmodid LIKE inpf_t.inpfmodid, #资料更改者
       inpfmoddt LIKE inpf_t.inpfmoddt, #最近更改日
       inpfcnfid LIKE inpf_t.inpfcnfid, #资料审核者
       inpfcnfdt LIKE inpf_t.inpfcnfdt, #数据审核日
       inpfpstid LIKE inpf_t.inpfpstid, #资料过账者
       inpfpstdt LIKE inpf_t.inpfpstdt, #资料过账日
       inpfstus LIKE inpf_t.inpfstus #状态码
END RECORD 
#161124-00048#4  16/12/09 By 08734 add(E)  
   #DEFINE l_inpg      RECORD LIKE inpg_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpg RECORD  #在製工單盤點明細檔
       inpgent LIKE inpg_t.inpgent, #企业编号
       inpgsite LIKE inpg_t.inpgsite, #营运据点
       inpgdocno LIKE inpg_t.inpgdocno, #标签编号
       inpgseq LIKE inpg_t.inpgseq, #项次
       inpgseq1 LIKE inpg_t.inpgseq1, #项序
       inpgseq2 LIKE inpg_t.inpgseq2, #序号
       inpg001 LIKE inpg_t.inpg001, #发料料号
       inpg002 LIKE inpg_t.inpg002, #作业编号
       inpg003 LIKE inpg_t.inpg003, #工艺序
       inpg004 LIKE inpg_t.inpg004, #标准QPA
       inpg005 LIKE inpg_t.inpg005, #实际QPA
       inpg006 LIKE inpg_t.inpg006, #应发数量
       inpg007 LIKE inpg_t.inpg007, #单位
       inpg008 LIKE inpg_t.inpg008, #已发数量
       inpg009 LIKE inpg_t.inpg009, #报废数量
       inpg010 LIKE inpg_t.inpg010, #库存管理特征
       inpg011 LIKE inpg_t.inpg011, #超领数量
       inpg012 LIKE inpg_t.inpg012, #应盘数量
       inpg013 LIKE inpg_t.inpg013, #理由码
       inpg014 LIKE inpg_t.inpg014, #备注
       inpg030 LIKE inpg_t.inpg030, #盘点数量-初盘(一)
       inpg031 LIKE inpg_t.inpg031, #盘点人员-初盘(一)
       inpg032 LIKE inpg_t.inpg032, #盘点日期-初盘(一)
       inpg033 LIKE inpg_t.inpg033, #盘点数量-初盘(二)
       inpg034 LIKE inpg_t.inpg034, #盘点人员-初盘(二)
       inpg035 LIKE inpg_t.inpg035, #盘点日期-初盘(二)
       inpg050 LIKE inpg_t.inpg050, #盘点数量-复盘(一)
       inpg051 LIKE inpg_t.inpg051, #盘点人员-复盘(一)
       inpg052 LIKE inpg_t.inpg052, #盘点日期-复盘(一)
       inpg053 LIKE inpg_t.inpg053, #盘点数量-复盘(二)
       inpg054 LIKE inpg_t.inpg054, #盘点人员-复盘(二)
       inpg055 LIKE inpg_t.inpg055, #盘点日期-复盘(二)
       inpg015 LIKE inpg_t.inpg015 #产品特征
END RECORD   
#161124-00048#4  16/12/09 By 08734 add(E)   
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_sql       STRING        
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
#  DECLARE ainp870_process_cs CURSOR FROM ls_sql
#  FOREACH ainp870_process_cs INTO
   #add-point:process段process name="process.process"
   #SELECT * INTO l_inpa.* FROM inpa_t   #161124-00048#4  16/12/09 By 08734 mark
   SELECT inpaent,inpasite,inpadocno,inpadocdt,inpa001,inpa002,inpa003,inpa004,inpa005,inpa006,inpa007,inpa008,inpa009,inpa010,inpa011,inpa012,inpa013,inpa014,inpa015,inpa016,inpa017,inpa018,inpa019,inpa020,inpa021,inpa022,inpa023,inpa024,inpa025,inpa026,inpa027,inpa028,inpa029,
       inpa030,inpa031,inpa032,inpa033,inpa034,inpa035,inpa036,inpa037,inpa038,inpa039,inpa050,inpa051,inpa052,inpa053,inpa054,inpaownid,inpaowndp,inpacrtid,inpacrtdp,inpacrtdt,inpamodid,inpamoddt,inpacnfid,inpacnfdt,inpapstid,inpapstdt,inpastus,inpa040,inpa041,inpa042,inpa043  #161124-00048#4  16/12/09 By 08734 add 
    INTO l_inpa.* FROM inpa_t
    WHERE inpaent = g_enterprise
      AND inpasite = g_site
      AND inpadocno = g_master.inpadocno
   CALL s_transaction_begin()   
   IF g_master.blank1 = 'Y' THEN   #現有庫存空白標籤
      IF g_master.blank1 = 'Y' AND g_master.number1 > 0 THEN   #產生空白標籤
         IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
            IF NOT cl_null(l_inpa.inpa019) THEN
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
                INSERT INTO inpd_t (inpdent,inpdsite,inpddocno,inpdseq,inpd008,inpd009,inpd016,inpd017,inpdownid,inpdowndp,
                                    inpdcrtid,inpdcrtdp,inpdcrtdt,inpdstus)
                            VALUES (g_enterprise,g_site,l_inpd.inpddocno,l_inpd.inpdseq,l_inpd.inpd008,l_inpd.inpd009,
                                    l_inpd.inpd016,l_inpd.inpd017,l_inpd.inpdownid,l_inpd.inpdowndp,l_inpd.inpdcrtid,
                                    l_inpd.inpdcrtdp,l_inpd.inpdcrtdt,l_inpd.inpdstus)  
                IF SQLCA.sqlerrd[3] = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "std-00009"
                   LET g_errparam.extend = "inpd_t"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()                     
                   CALL s_transaction_end('N','0')
                   RETURN                
                END IF                
            END FOR        
      END IF    
   END IF
   CALL s_transaction_end('Y','0')
   CALL s_transaction_begin()  
   IF g_master.blank2 = 'Y' THEN   #在製工單空白標籤
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
               LET g_errparam.code = 'std-00009'
               LET g_errparam.extend = "inpf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
               CALL s_transaction_end('N','0')
               RETURN                
            END IF           
         END FOR
      END IF
   END IF 
   DISPLAY 100 TO stagecomplete
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
   CALL ainp870_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ainp870.get_buffer" >}
PRIVATE FUNCTION ainp870_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.inpadocno = p_dialog.getFieldBuffer('inpadocno')
   LET g_master.blank1 = p_dialog.getFieldBuffer('blank1')
   LET g_master.number1 = p_dialog.getFieldBuffer('number1')
   LET g_master.blank2 = p_dialog.getFieldBuffer('blank2')
   LET g_master.number2 = p_dialog.getFieldBuffer('number2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainp870.msgcentre_notify" >}
PRIVATE FUNCTION ainp870_msgcentre_notify()
 
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
 
{<section id="ainp870.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 人員说明
# Memo...........:
# Usage..........: CALL ainp870_inpa002_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp870_inpa002_desc()
   SELECT inpa002 INTO g_master.inpa002 FROM inpa_t 
    WHERE inpaent = g_enterprise
      AND inpadocno = g_master.inpadocno   
   CALL s_desc_get_person_desc(g_master.inpa002) RETURNING g_master.inpa002_desc 
   DISPLAY BY NAME g_master.inpa002_desc 
   DISPLAY BY NAME g_master.inpa002
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp870_set_no_entry()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp870_set_no_entry()
DEFINE l_inpa009    LIKE inpa_t.inpa009
DEFINE l_inpa010    LIKE inpa_t.inpa009
DEFINE l_inpa011    LIKE inpa_t.inpa009
DEFINE l_inpa012    LIKE inpa_t.inpa009
DEFINE l_inpa013    LIKE inpa_t.inpa009
DEFINE l_inpa014    LIKE inpa_t.inpa009
DEFINE l_inpa015    LIKE inpa_t.inpa009
DEFINE l_inpa016    LIKE inpa_t.inpa009

   SELECT inpa009,inpa010,inpa011,inpa012,inpa013,inpa014,inpa015,inpa016 
     INTO l_inpa009,l_inpa010,l_inpa011,l_inpa012,l_inpa013,l_inpa014,l_inpa015,l_inpa016
     FROM inpa_t
    WHERE inpaent = g_enterprise
      AND inpadocno = g_master.inpadocno
      
   IF l_inpa009 = 'N' AND l_inpa010 = 'N' AND l_inpa011 = 'N' AND l_inpa012 = 'N' THEN
      CALL cl_set_comp_entry("blank1,number1",FALSE)      
   END IF
   
   IF l_inpa013 = 'N' AND l_inpa014 = 'N' AND l_inpa015 = 'N' AND l_inpa016 = 'N' THEN
      CALL cl_set_comp_entry("blank2,number2",FALSE)      
   END IF   
   IF g_master.blank1 = 'N' THEN
      CALL cl_set_comp_entry("number1",FALSE)
   END IF
   IF g_master.blank2 = 'N' THEN
      CALL cl_set_comp_entry("number2",FALSE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp870_set_entry()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp870_set_entry()
   CALL cl_set_comp_entry("blank1,number1,blank2,number2",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp870_set_no_required()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp870_set_no_required()
   CALL cl_set_comp_required("number1",FALSE)
   CALL cl_set_comp_required("number2",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp870_set_required()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp870_set_required()
   IF g_master.blank1 = 'Y' THEN  
      CALL cl_set_comp_required("number1",TRUE)
   END IF
   IF g_master.blank2 = 'Y' THEN    
      CALL cl_set_comp_required("number2",TRUE)
   END IF  
END FUNCTION

#end add-point
 
{</section>}
 
