#該程式未解開Section, 採用最新樣板產出!
{<section id="aimp120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-12-18 17:07:17), PR版次:0003(2017-02-16 10:08:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: aimp120
#+ Description: 料件銷售平均單價計算作業
#+ Creator....: 02295(2014-12-15 10:50:34)
#+ Modifier...: 02295 -SD/PR- 06978
 
{</section>}
 
{<section id="aimp120.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161202-00020#1   2016/12/05 By lixiang 条件选项的期间起止默认应该为空
#170215-00047#1   2017/02/16 By ywtsai  取得出貨單需判斷為已過帳的出貨單
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
       imaa001 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr10, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   a LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_imaa  RECORD 
         imaa001 LIKE imaa_t.imaa001,
         imaa009 LIKE imaa_t.imaa009
        END RECORD 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aimp120.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aimp120_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimp120 WITH FORM cl_ap_formpath("aim",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aimp120_init()
 
      #進入選單 Menu (="N")
      CALL aimp120_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aimp120
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aimp120.init" >}
#+ 初始化作業
PRIVATE FUNCTION aimp120_init()
 
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
   LET g_master.a = 'N'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimp120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimp120_ui_dialog()
 
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
      #161202-00020#1---s
      LET g_master.bdate = '' 
      LET g_master.edate = '' 
      DISPLAY BY NAME g_master.bdate,g_master.edate
      #161202-00020#1---e
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bdate,g_master.edate,g_master.a 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            IF NOT cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN    
               IF g_master.bdate > g_master.edate THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'axm-00397'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.bdate = ''
                  NEXT FIELD CURRENT                  
               END IF               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            IF NOT cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN    
               IF g_master.bdate > g_master.edate THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'axm-00397'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.bdate = ''
                  NEXT FIELD CURRENT                  
               END IF               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imaa001,imaa009
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               DISPLAY BY NAME g_imaa.imaa001,g_imaa.imaa009
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            NEXT FIELD imaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            LET g_imaa.imaa001 = GET_FLDBUF(imaa001)
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            LET g_imaa.imaa009 = GET_FLDBUF(imaa009)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="construct.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="construct.a.a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="construct.c.a"
            
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
            CALL aimp120_get_buffer(l_dialog)
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
         ON ACTION output
            CALL aimp120_x01(g_master.wc,g_master.bdate,g_master.edate)
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
         CALL aimp120_init()
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
                 CALL aimp120_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aimp120_transfer_argv(ls_js)
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
 
{<section id="aimp120.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aimp120_transfer_argv(ls_js)
 
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
 
{<section id="aimp120.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aimp120_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_xmdl   RECORD
             xmdldocno LIKE xmdl_t.xmdldocno,
             xmdlseq LIKE xmdl_t.xmdlseq,
             xmdl021 LIKE xmdl_t.xmdl021,
             xmdl022 LIKE xmdl_t.xmdl022,
             xmdl024 LIKE xmdl_t.xmdl024,
             xmdk017 LIKE xmdk_t.xmdk017,
             xmdl017 LIKE xmdl_t.xmdl017,
             xmdl018 LIKE xmdl_t.xmdl018
          END RECORD 
   DEFINE l_ant    LIKE type_t.num20_6
   DEFINE l_qty    LIKE type_t.num20_6 
   DEFINE l_imaa001 LIKE imaa_t.imaa001,
          l_imaa006 LIKE imaa_t.imaa006,
          l_imai222 LIKE imai_t.imai222,
          l_rate    LIKE inaj_t.inaj014  
   DEFINE l_count   LIKE type_t.num10  
   DEFINE l_cnt     LIKE type_t.num10 
   DEFINE l_stagenow STRING           
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
#  DECLARE aimp120_process_cs CURSOR FROM ls_sql
#  FOREACH aimp120_process_cs INTO
   #add-point:process段process name="process.process"
   #-------------------------------------計價單位，計價數量，單價 ，單頭匯率，採購單位，採購數量
   LET ls_sql = "SELECT xmdldocno,xmdlseq,xmdl021,xmdl022,xmdl024,xmdk017,xmdl017,xmdl018 ",
                "  FROM xmdl_t,xmdk_t",
                " WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno ",
                "   AND xmdkent = '",g_enterprise,"'",
                "   AND xmdksite = '",g_site,"'",
                "   AND xmdl008 = ? ",
                "   AND xmdkdocdt BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
                #"   AND xmdkstus = 'Y' "                #170215-00047#1 mark
                "   AND xmdkstus = 'S' "                 #170215-00047#1 add
   PREPARE aimp120_xmd_pr FROM ls_sql
   DECLARE aimp120_xmd_cs CURSOR FOR aimp120_xmd_pr

   LET ls_sql = " SELECT COUNT(*) FROM imaa_t ",
                "  WHERE imaaent ='",g_enterprise,"' AND ",g_master.wc
   PREPARE aimp120_count_pr FROM ls_sql
   EXECUTE aimp120_count_pr INTO l_count
   LET l_cnt = 1

   LET ls_sql = " SELECT DISTINCT imaa001,imaa006 FROM imaa_t ",
                "  WHERE imaaent ='",g_enterprise,"' AND ",g_master.wc
   DECLARE aimp120_process_cs CURSOR FROM ls_sql
   FOREACH aimp120_process_cs INTO l_imaa001,l_imaa006
      
      LET li_count = (l_cnt/l_count)*100
      DISPLAY li_count TO FORMONLY.stagecomplete
      LET l_stagenow = l_imaa001
      DISPLAY l_stagenow TO FORMONLY.stagenow
      
      LET l_ant = 0 
      LET l_qty = 0
      FOREACH aimp120_xmd_cs USING l_imaa001 INTO l_xmdl.*
      
         IF cl_null(l_xmdl.xmdk017) THEN LET l_xmdl.xmdk017 = 1 END IF
         #計價數量
         CALL s_aimi190_get_convert(l_imaa001,l_xmdl.xmdl021,l_imaa006) RETURNING g_success,l_rate
         IF g_success THEN 
            LET l_xmdl.xmdl022 = l_xmdl.xmdl022 * l_rate
         END IF
         LET l_ant = l_ant +l_xmdl.xmdl022 * l_xmdl.xmdl024 * l_xmdl.xmdk017
         
         #銷售數量
         CALL s_aimi190_get_convert(l_imaa001,l_xmdl.xmdl017,l_imaa006) RETURNING g_success,l_rate
         IF g_success THEN 
            LET l_xmdl.xmdl018 = l_xmdl.xmdl018 * l_rate
         END IF         
         LET l_qty = l_qty +l_xmdl.xmdl018 
      END FOREACH 
      LET l_imai222 = l_ant/l_qty
      
      IF g_master.a = 'Y' THEN 
         UPDATE imai_t
            SET imai222 = l_imai222
          WHERE imaient = g_enterprise
            AND imaisite = g_site
            AND imai001 = l_imaa001            
      END IF
      LET l_cnt = l_cnt + 1      
   END FOREACH
   
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
   CALL aimp120_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aimp120.get_buffer" >}
PRIVATE FUNCTION aimp120_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
   LET g_master.a = p_dialog.getFieldBuffer('a')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimp120.msgcentre_notify" >}
PRIVATE FUNCTION aimp120_msgcentre_notify()
 
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
 
{<section id="aimp120.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 