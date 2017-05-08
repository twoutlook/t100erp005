#該程式未解開Section, 採用最新樣板產出!
{<section id="aimp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-03-16 15:31:05), PR版次:0003(2017-02-10 10:49:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000071
#+ Filename...: aimp100
#+ Description: 料件存量計算及列印作業
#+ Creator....: 02295(2014-12-11 10:27:16)
#+ Modifier...: 02295 -SD/PR- 08734
 
{</section>}
 
{<section id="aimp100.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151213-00001#1  2016/03/15 By xianghui 增加列印差异百分比以及一些报表栏位的调整
#170207-00018#1  2017/02/10 By 08734    ROWNUM整批调整
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
       imaa001 LIKE imaa_t.imaa001, 
   imaa009 LIKE imaa_t.imaa009, 
   a LIKE type_t.chr500, 
   per LIKE type_t.chr500, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   b LIKE type_t.chr500, 
   c LIKE type_t.chr500, 
   xmid001 LIKE xmid_t.xmid001, 
   d LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_stage DYNAMIC ARRAY OF RECORD 
             xmib002     LIKE xmib_t.xmib002,
             xmib003     LIKE xmib_t.xmib003,
             bdate       LIKE type_t.dat, 
             edate       LIKE type_t.dat,
             xmid_total  LIKE xmid_t.xmid015,
             inaj_total  LIKE inaj_t.inaj011
             END RECORD
             
DEFINE g_imaa  RECORD 
         imaa001 LIKE imaa_t.imaa001,
         imaa009 LIKE imaa_t.imaa009
        END RECORD
#151213-00001#1 ---mod---begin        
DEFINE g_bdate  LIKE bmba_t.bmba005,    
       g_edate  LIKE bmba_t.bmba005           
DEFINE g_bmba DYNAMIC ARRAY OF RECORD       #每階存放資料
          bmba001 LIKE bmba_t.bmba001,    #主件料號
          bmba003 LIKE bmba_t.bmba003     #元件料號
      END RECORD      
DEFINE g_i        LIKE type_t.num5
#151213-00001#1 ---mod---end
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aimp100.main" >}
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
      CALL aimp100_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimp100 WITH FORM cl_ap_formpath("aim",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aimp100_init()
 
      #進入選單 Menu (="N")
      CALL aimp100_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aimp100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aimp100.init" >}
#+ 初始化作業
PRIVATE FUNCTION aimp100_init()
 
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
   CALL cl_set_combo_scc("a","2216")
   CALL cl_set_combo_scc("b","2217")
   CALL cl_set_combo_scc("c","2218")
   LET g_master.a = '1'
   LET g_master.b = '1'
   LET g_master.c = '1'
   LET g_master.d = 'N'
   LET g_master.per = 0          #151213-00001#1
   LET g_master.bdate = ''       #151213-00001#1
   LET g_master.edate = ''       #151213-00001#1
   CALL aimp100_set_comp_entry()   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimp100_ui_dialog()
 
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
         INPUT BY NAME g_master.a,g_master.per,g_master.bdate,g_master.edate,g_master.b,g_master.c,g_master.xmid001, 
             g_master.d 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
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
            CALL aimp100_set_comp_entry()
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD per
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.per,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD per
            END IF 
 
 
 
            #add-point:AFTER FIELD per name="input.a.per"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD per
            #add-point:BEFORE FIELD per name="input.b.per"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE per
            #add-point:ON CHANGE per name="input.g.per"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            IF NOT cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN    
               IF g_master.bdate > g_master.edate THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'axm-00397'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.edate = ''
                  NEXT FIELD CURRENT                  
               END IF
            END IF  
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="input.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="input.a.c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c
            #add-point:ON CHANGE c name="input.g.c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmid001
            #add-point:BEFORE FIELD xmid001 name="input.b.xmid001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmid001
            
            #add-point:AFTER FIELD xmid001 name="input.a.xmid001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmid001
            #add-point:ON CHANGE xmid001 name="input.g.xmid001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD d
            #add-point:BEFORE FIELD d name="input.b.d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD d
            
            #add-point:AFTER FIELD d name="input.a.d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE d
            #add-point:ON CHANGE d name="input.g.d"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.per
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD per
            #add-point:ON ACTION controlp INFIELD per name="input.c.per"
            
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
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmid001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmid001
            #add-point:ON ACTION controlp INFIELD xmid001 name="input.c.xmid001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xmid001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_xmia001_1()                                #呼叫開窗

            LET g_master.xmid001 = g_qryparam.return1              

            DISPLAY g_master.xmid001 TO xmid001              #

            NEXT FIELD xmid001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD d
            #add-point:ON ACTION controlp INFIELD d name="input.c.d"
            
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
            #LET g_qryparam.where = " imaastus = 'Y' "
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
            CALL aimp100_get_buffer(l_dialog)
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
            CALL aimp100_x01(g_master.wc,g_master.bdate,g_master.edate,g_master.b,g_master.c,g_master.xmid001,g_master.per)   #151213-00001#1 add per
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
         CALL aimp100_init()
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
                 CALL aimp100_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aimp100_transfer_argv(ls_js)
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
 
{<section id="aimp100.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aimp100_transfer_argv(ls_js)
 
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
 
{<section id="aimp100.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aimp100_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_imaa      RECORD 
            imaa001    LIKE imaa_t.imaa001,
            imaa006    LIKE imaa_t.imaa006,
            imaf171    LIKE imaf_t.imaf171,
            imaf172    LIKE imaf_t.imaf172,
            imaf173    LIKE imaf_t.imaf173,
            imaf174    LIKE imaf_t.imaf174,
            imaf021    LIKE imaf_t.imaf021,
            imaf022    LIKE imaf_t.imaf022
            END RECORD
   DEFINE l_fac       LIKE type_t.num20_6
   DEFINE l_leadtime  LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_imaf023   LIKE imaf_t.imaf023   #期間補足量
   DEFINE l_imaf025   LIKE imaf_t.imaf025   #再訂購點量
   DEFINE l_imaf026   LIKE imaf_t.imaf026   #安全存量
   DEFINE l_inaj_sum  LIKE inaj_t.inaj011
   DEFINE l_days      LIKE type_t.num5
   DEFINE i           LIKE type_t.num5
   DEFINE l_amt_total LIKE type_t.num20_6
   DEFINE l_amt       LIKE type_t.num20_6
   DEFINE l_d         LIKE type_t.num20_6
   DEFINE l_bdate     LIKE type_t.dat
   DEFINE l_edate     LIKE type_t.dat
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   WHENEVER ERROR CONTINUE
   
   CALL s_transaction_begin()
   
   CREATE TEMP TABLE ainq210_tmp
   (  xmid014     VARCHAR(10),
      xmid015     DECIMAL(20,6)
   );  
   
   LET g_sql = " INSERT INTO ainq210_tmp ",
               " SELECT DISTINCT xmid014,MAX(xmid015) FROM xmid_t,xmic_t ",
               " WHERE xmicent = xmident AND xmic001 = xmid001 AND xmic002 = xmid002 ",
               "   AND xmic003 = xmid003 AND xmic004 = xmid004 AND xmic005 = xmid005 AND xmic006 = xmid006 ",
               "   AND xmident = '",g_enterprise,"'",
               "   AND xmicstus = 'Y' ",
               "   AND xmid001 = '",g_master.xmid001,"'",
               "   AND xmid007 = ? ",
               "   AND xmid012 BETWEEN ? AND ? ",
               " GROUP BY xmid014 "
   PREPARE tmp_ins FROM g_sql

   LET g_sql = " SELECT * FROM ainq210_tmp "
   PREPARE tmp_sel_pr FROM g_sql
   DECLARE tmp_sel_cr CURSOR FOR tmp_sel_pr
   
   #料件單位時間消耗量
   LET g_sql = "SELECT SUM(inaj011*inaj014) ",
               "  FROM inaj_t ",
               " WHERE inajent = '",g_enterprise,"'",
               "   AND inajsite = '",g_site,"'",
               "   AND inaj005 = ? ",
               "   AND inaj004 = -1 ",
               "   AND inaj022 BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'"
   PREPARE aimp100_get_sum FROM g_sql              
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET ls_sql = " SELECT COUNT(*) FROM (",
                   " SELECT DISTINCT imaa001,imaa006,imaf171,imaf172,imaf173,imaf174,imaf021,imaf022 ",
                   "   FROM imaa_t,imaf_t ",
                   "  WHERE imaaent = imafent AND imaa001 = imaf001",
                   "    AND imaaent = '",g_enterprise,"' ",
                   "    AND imaastus = 'Y'",
                   "    AND imafsite = '",g_site,"'",
                   "    AND ",g_master.wc,")"
      PREPARE aimp100_process_count FROM ls_sql
      EXECUTE aimp100_process_count INTO li_count      
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aimp100_process_cs CURSOR FROM ls_sql
#  FOREACH aimp100_process_cs INTO
   #add-point:process段process name="process.process"
   CALL aimp100_fill_stage()
   
   #安全係數
    CASE g_master.b
        WHEN '1'
             LET l_fac = 1.3
        WHEN '2'
             LET l_fac = 1.6
        WHEN '3'
             LET l_fac = 2.4
    END CASE  
    
   LET ls_sql = " SELECT DISTINCT imaa001,imaa006,imaf171,imaf172,imaf173,imaf174,imaf021,imaf022 FROM imaa_t,imaf_t ",
                "  WHERE imaaent = imafent AND imaa001 = imaf001",
                "    AND imaaent = '",g_enterprise,"' ",
                "    AND imaastus = 'Y'",
                "    AND imafsite = '",g_site,"'",
                "    AND ",g_master.wc
                
   PREPARE aimp100_process_pr FROM ls_sql 
   DECLARE aimp100_process_cs CURSOR FOR aimp100_process_pr
   FOREACH aimp100_process_cs INTO l_imaa.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF      
      
      CALL cl_progress_no_window_ing(l_imaa.imaa001)
      
      ------計算安全存量------
      #前置時間
      LET l_leadtime = l_imaa.imaf171+l_imaa.imaf172+l_imaa.imaf173+l_imaa.imaf174
      IF cl_null(l_leadtime) THEN LET l_leadtime = 1 END IF
      IF l_leadtime < 1 AND l_leadtime >= 0 THEN LET l_leadtime = 1 END IF 
      
      #期數
      LET l_n = g_stage.getLength()
          
      #標準差
      CALL aimp100_fill_total(l_imaa.imaa001,l_imaa.imaa006)
      LET l_amt_total = 0
      LET l_amt = 0      
      FOR i= 1 TO l_n
         LET l_amt = (g_stage[i].xmid_total-g_stage[i].inaj_total)*(g_stage[i].xmid_total-g_stage[i].inaj_total)
         LET l_amt_total = l_amt_total + l_amt
      END FOR
      IF cl_null(l_amt_total) THEN LET l_amt_total = 0 END IF 
      LET l_d = util.Math.sqrt(l_amt_total/l_n)
      LET l_imaf026 = l_fac* util.Math.sqrt(l_leadtime)*l_d
      IF g_master.d = 'Y' AND g_master.a MATCHES '[14]' THEN 
         UPDATE imaf_t
            SET imaf026 = l_imaf026
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_imaa.imaa001            
      END IF       
      ------計算再訂購點量------
      LET l_bdate = g_master.bdate
      LET l_edate = g_master.edate
      LET l_days = l_edate - l_bdate
      
      #料件單位時間消耗量
#      SELECT SUM(inaj011*inaj014) 
#        INTO l_inaj_sum
#        FROM inaj_t
#       WHERE inajent = g_enterprise
#         AND inajsite = g_site
#         AND inaj005 = l_imaa.imaa001
#         AND inaj004 = -1
#         AND inaj022 BETWEEN g_master.bdate AND g_master.edate
      EXECUTE aimp100_get_sum USING l_imaa.imaa001 INTO l_inaj_sum
      IF cl_null(l_inaj_sum) THEN LET l_inaj_sum = 0 END IF   
      LET l_imaf025 = (l_inaj_sum/l_days)*l_leadtime + l_imaf026      
      IF g_master.d = 'Y' AND g_master.a MATCHES '[24]' THEN 
         UPDATE imaf_t
            SET imaf025 = l_imaf025
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_imaa.imaa001            
      END IF      
            
      ------計算期間補足量------
      LET l_imaf023 = (l_inaj_sum/l_days)*(l_leadtime+(l_imaa.imaf021*30+l_imaa.imaf022))+l_imaf026
      IF cl_null(l_imaf023) THEN LET l_imaf023 = 0 END IF
      IF g_master.d = 'Y' AND g_master.a MATCHES '[34]' THEN
         UPDATE imaf_t
            SET imaf023 = l_imaf023
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_imaa.imaa001            
      END IF 
   END FOREACH
   
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
   CALL aimp100_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aimp100.get_buffer" >}
PRIVATE FUNCTION aimp100_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.per = p_dialog.getFieldBuffer('per')
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
   LET g_master.b = p_dialog.getFieldBuffer('b')
   LET g_master.c = p_dialog.getFieldBuffer('c')
   LET g_master.xmid001 = p_dialog.getFieldBuffer('xmid001')
   LET g_master.d = p_dialog.getFieldBuffer('d')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimp100.msgcentre_notify" >}
PRIVATE FUNCTION aimp100_msgcentre_notify()
 
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
 
{<section id="aimp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aimp100_set_comp_entry()
  
  CALL cl_set_comp_entry("b,c",TRUE)
  IF g_master.a NOT MATCHES '[14]' THEN 
     CALL cl_set_comp_entry("b,c",FALSE)
  END IF
  CALL cl_set_comp_required("per",TRUE)
END FUNCTION

PRIVATE FUNCTION aimp100_fill_stage()
DEFINE l_sql     STRING
DEFINE l_yy       LIKE type_t.num5
DEFINE l_mm       LIKE type_t.num5
DEFINE l_dd       LIKE type_t.num5
DEFINE l_dd_1     LIKE type_t.num5
DEFINE l_ac       LIKE type_t.num5
DEFINE l_e_date   LIKE xmic_t.xmic002


   WHENEVER ERROR CONTINUE
   
   LET l_sql = "SELECT DISTINCT xmib002,xmib003 FROM xmib_t WHERE xmibent = '",g_enterprise,"'",
               "   AND xmib001 = '",g_master.xmid001,"' ORDER BY xmib002 "
   PREPARE ainq210_pre1 FROM l_sql 
   DECLARE ainq210_cur1 CURSOR FOR ainq210_pre1
   LET l_ac = 1
   FOREACH ainq210_cur1 INTO g_stage[l_ac].xmib002,g_stage[l_ac].xmib003
      IF g_stage[l_ac].xmib002 = 1 THEN
         LET g_stage[l_ac].bdate = g_master.bdate
         LET l_yy = YEAR(g_stage[l_ac].bdate)
         LET l_mm = MONTH(g_stage[l_ac].bdate)
         LET l_dd = DAY(g_stage[l_ac].bdate)

         IF g_stage[l_ac].xmib003 = '0' THEN   #天
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate
         END IF
         IF g_stage[l_ac].xmib003 = '1' THEN   #周
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 6
         END IF
         IF g_stage[l_ac].xmib003 = '2' THEN   #旬
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 9
         END IF
         IF g_stage[l_ac].xmib003 = '3' THEN   #月
            IF l_dd = 1 THEN
               CALL s_date_get_last_date(g_stage[l_ac].bdate) RETURNING g_stage[l_ac].edate
            ELSE
               IF l_mm = 12 THEN
                  LET l_yy = l_yy +1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF
               LET g_stage[l_ac].edate = MDY(l_mm,l_dd-1,l_yy)
            END IF
         END IF
      ELSE
         LET l_yy = YEAR(g_stage[l_ac-1].edate)
         LET l_mm = MONTH(g_stage[l_ac-1].edate)
         LET l_dd = DAY(g_stage[l_ac-1].edate)
         LET g_stage[l_ac].bdate = g_stage[l_ac-1].edate + 1
         IF g_stage[l_ac].xmib003 = '0' THEN   #天
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate
         END IF
         IF g_stage[l_ac].xmib003 = '1' THEN   #周
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 6
         END IF
         IF g_stage[l_ac].xmib003 = '2' THEN   #旬
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 9
         END IF
         IF g_stage[l_ac].xmib003 = '3' THEN   #月
            CALL s_date_get_last_date(g_stage[l_ac-1].edate) RETURNING l_e_date
            IF g_stage[l_ac-1].edate = l_e_date THEN   #最後一天
               LET l_dd = 1
            END IF
            IF l_dd = 1 THEN
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF
               LET g_stage[l_ac].bdate = MDY(l_mm,1,l_yy)
               CALL s_date_get_last_date(g_stage[l_ac].bdate) RETURNING g_stage[l_ac].edate
            ELSE
               LET g_stage[l_ac].bdate = MDY(l_mm,l_dd+1,l_yy)
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF
               LET g_stage[l_ac].edate = MDY(l_mm,l_dd,l_yy)
            END IF
         END IF
      END IF
      IF g_stage[l_ac].bdate > g_master.edate THEN 
          INITIALIZE g_stage[l_ac].* TO NULL                         # Default cond
          CALL g_stage.deleteElement(l_ac)
          EXIT FOREACH 
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   LET l_ac = l_ac - 1
   CALL g_stage.deleteElement(g_stage.getlength())
   
END FUNCTION

PRIVATE FUNCTION aimp100_fill_total(p_imaa001,p_imaa006)
DEFINE p_imaa001  LIKE imaa_t.imaa001,
       p_imaa006  LIKE imaa_t.imaa006
DEFINE i,j   LIKE type_t.num5
DEFINE l_sql STRING
DEFINE l_xmid014  LIKE xmid_t.xmid014,
       l_xmid015  LIKE xmid_t.xmid015 
DEFINE l_rate     LIKE inaj_t.inaj014         
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_bmaa002  LIKE bmaa_t.bmaa002  #151213-00001#1 

  WHENEVER ERROR CONTINUE
  
  LET j =g_stage.getlength()
  FOR i= 1 TO j

     #将销售预测的资料按单位分组，抓取每种单位下数量的最大值插入到临时表中
     #在将这些数量换算成料件基础单位的数量更新临时表
     #最后抓去临时表中数量最大的值作为销售预测数量
     DELETE FROM ainq210_tmp;
     EXECUTE tmp_ins USING p_imaa001,g_stage[i].bdate,g_stage[i].edate
     
     FOREACH tmp_sel_cr INTO l_xmid014,l_xmid015  
        CALL s_aimi190_get_convert(p_imaa001,l_xmid014,p_imaa006) RETURNING g_success,l_rate
        IF g_success THEN 
           LET l_xmid015 = l_xmid015 * l_rate
        END IF
        UPDATE ainq210_tmp
           SET xmid015 = l_xmid015
         WHERE xmid014 = l_xmid014  
     END FOREACH
     SELECT MAX(xmid015) INTO g_stage[i].xmid_total
       FROM ainq210_tmp
     IF cl_null(g_stage[i].xmid_total) THEN LET g_stage[i].xmid_total = 0 END IF
     
     SELECT SUM(inaj014*inaj011) INTO g_stage[i].inaj_total
       FROM inaj_t
      WHERE inajent = g_enterprise
        AND inajsite = g_site
        AND inaj005 = p_imaa001
        AND inaj004 = -1
        AND inaj022 BETWEEN g_stage[i].bdate AND g_stage[i].edate  
     IF cl_null(g_stage[i].inaj_total) THEN LET g_stage[i].inaj_total = 0 END IF

     LET l_cnt = 0 
     #151213-00001#1 ---mod---begin
#    SELECT COUNT(*) INTO l_cnt
#      FROM bmba_t
#     WHERE bmbaent = g_enterprise
#       AND bmbasite = g_site
#       AND bmba003 = p_imaa001
#    IF l_cnt > 0 THEN
#       CALL aimp100_root_bom(0,'',p_imaa001,i)
#    END IF     
     LET g_bdate = g_stage[i].bdate
     LET g_edate = g_stage[i].bdate
     LET l_sql = "SELECT COUNT(*) ", 
                 "  FROM bmaa_t,bmba_t ",
                 " WHERE bmaaent = bmbaent ",
                 "   AND bmaasite = bmbasite  ",     
                 "   AND bmaa001 = bmba001 ",
                 "   AND bmaa002 = bmba002 ",
                 "   AND bmbaent = '",g_enterprise,"'",
                 "   AND bmbasite = '",g_site,"'",
                 "   AND bmba003 = '",p_imaa001,"'",
                 "   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
                 "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",
                 "   AND bmaastus = 'Y' "
     PREPARE aimp100_get_bom1 FROM l_sql
     EXECUTE aimp100_get_bom1 INTO l_cnt     
     IF l_cnt > 0 THEN
        LET l_bmaa002 = ' '      
       #170207-00018#1    2017/02/10   By 08734 mark(S)
       # LET l_sql = "SELECT bmba002 ", 
       #             "  FROM bmaa_t,bmba_t ",
       #             " WHERE bmaaent = bmbaent ",
       #             "   AND bmaasite = bmbasite  ",     
       #             "   AND bmaa001 = bmba001 ",
       #             "   AND bmaa002 = bmba002 ",
       #             "   AND bmbaent = '",g_enterprise,"'",
       #             "   AND bmbasite = '",g_site,"'",
       #             "   AND bmba003 = '",p_imaa001,"'",
       #             "   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
       #             "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",
       #             "   AND bmaastus = 'Y' ",
       #             "   AND rownum = 1 ",
       #             " ORDER BY bmaa002"
       #170207-00018#1    2017/02/10   By 08734 mark(E)  
        #170207-00018#1    2017/02/10   By 08734 add(S)       
        LET l_sql = " SELECT a.bmba002 FROM ( ",     
                    " SELECT bmba002 ", 
                    "  FROM bmaa_t,bmba_t ",
                    " WHERE bmaaent = bmbaent ",
                    "   AND bmaasite = bmbasite  ",     
                    "   AND bmaa001 = bmba001 ",
                    "   AND bmaa002 = bmba002 ",
                    "   AND bmbaent = '",g_enterprise,"'",
                    "   AND bmbasite = '",g_site,"'",
                    "   AND bmba003 = '",p_imaa001,"'",
                    "   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
                    "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",
                    "   AND bmaastus = 'Y' ",
                    " ORDER BY bmaa002 ) a ",
                    " WHERE rownum = 1 "
        #170207-00018#1    2017/02/10   By 08734 add(E)
        PREPARE aimp100_get_bom2 FROM l_sql
        EXECUTE aimp100_get_bom2 INTO l_bmaa002        
        CALL aimp100_root_bom(0,l_bmaa002,p_imaa001,i)
     END IF
     #151213-00001#1 ---mod---end
  END FOR
END FUNCTION

PRIVATE FUNCTION aimp100_root_bom(p_level,p_bmba002,p_bmba003,p_i)
DEFINE p_level LIKE type_t.num5,
       p_bmba002 LIKE bmba_t.bmba002,
       p_bmba003 LIKE bmba_t.bmba003,
       l_imaa006 LIKE imaa_t.imaa006,
       p_i LIKE type_t.num5
DEFINE sr DYNAMIC ARRAY OF RECORD       #每階存放資料
          bmba001 LIKE bmba_t.bmba001,    #主件料號
          bmba002 LIKE bmba_t.bmba002,
          bmba003 LIKE bmba_t.bmba003,    #元件料號
          bmba011 LIKE type_t.num20_6     #QPA
      END RECORD
DEFINE i      LIKE type_t.num5
DEFINE l_ac   LIKE type_t.num5
DEFINE l_sql STRING
DEFINE l_xmid014  LIKE xmid_t.xmid014,
       l_xmid015  LIKE xmid_t.xmid015 
DEFINE l_rate     LIKE inaj_t.inaj014  
DEFINE l_xmid_total LIKE xmid_t.xmid015
DEFINE l_inaj_total LIKE inaj_t.inaj014
DEFINE l_idx      LIKE type_t.num5 #151213-00001#1 

    WHENEVER ERROR CONTINUE
    
    LET p_level = p_level + 1
    IF p_level = 1 THEN
        INITIALIZE sr[1].* TO NULL
        LET sr[1].bmba001 = p_bmba003
        LET g_i = 1
    END IF
    LET g_bdate = g_stage[p_i].bdate    #151213-00001#1
    LET g_edate = g_stage[p_i].bdate    #151213-00001#1  
    LET g_sql = "SELECT DISTINCT bmba001,bmba002,bmba003,bmba011/bmba012 FROM bmba_t",
                " WHERE bmbaent='",g_enterprise,"' AND bmbasite='",g_site,"' ",
                "   AND bmba003='",p_bmba003,"'"
    IF p_bmba002 IS NOT NULL THEN 
       LET g_sql = g_sql," AND bmba002 ='",p_bmba002,"'" 
    END IF
    #151213-00001#1 ---mod---begin
    #LET g_sql = g_sql,"   AND to_char(bmba005,'YYYY-MM-DD')<='",g_stage[p_i].bdate,"' ",
    #                  "   AND (bmba006 IS NULL OR to_char(bmba006,'YYYY-MM-DD')>'",g_stage[p_i].bdate,"')",
    LET g_sql = g_sql,"   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
                      "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",                      
                      " ORDER BY bmba001 "
    #151213-00001#1---mod---end                  
    PREPARE aimp100_bom_pre FROM g_sql
    DECLARE aimp100_bom_cs CURSOR FOR aimp100_bom_pre    
    WHILE TRUE
      LET l_ac = 1
      FOREACH aimp100_bom_cs INTO sr[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         #151213-00001#1 ---mod---begin
         FOR l_idx = 1 TO g_i
            IF sr[l_ac].bmba001 = g_bmba[l_idx].bmba003 THEN 
               CONTINUE FOREACH
            END IF
         END FOR
         LET g_bmba[g_i].bmba001 = sr[l_ac].bmba001
         LET g_bmba[g_i].bmba003 = sr[l_ac].bmba003
         LET g_i = g_i + 1
         #151213-00001#1 ---mod---end
         LET l_ac = l_ac + 1
         
      END FOREACH 
      FOR i=1 TO l_ac-1

         #将销售预测的资料按单位分组，抓取每种单位下数量的最大值插入到临时表中
         #在将这些数量换算成料件基础单位的数量更新临时表
         #最后抓去临时表中数量最大的值作为销售预测数量
         DELETE FROM ainq210_tmp;
         EXECUTE tmp_ins USING sr[i].bmba001,g_stage[p_i].bdate,g_stage[p_i].edate
         SELECT imaa006 INTO l_imaa006 
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = sr[i].bmba001          
         FOREACH tmp_sel_cr INTO l_xmid014,l_xmid015  
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               EXIT FOREACH
            END IF            
            CALL s_aimi190_get_convert(sr[i].bmba001,l_xmid014,l_imaa006) RETURNING g_success,l_rate
            IF g_success THEN 
               LET l_xmid015 = l_xmid015 * l_rate
            END IF
            UPDATE ainq210_tmp
               SET xmid015 = l_xmid015
             WHERE xmid014 = l_xmid014  
         END FOREACH
         SELECT MAX(xmid015) INTO l_xmid_total
           FROM ainq210_tmp
         IF cl_null(l_xmid_total) THEN LET l_xmid_total = 0 END IF         
         LET l_xmid_total = l_xmid_total*sr[i].bmba011
         LET g_stage[p_i].xmid_total = g_stage[p_i].xmid_total + l_xmid_total

         SELECT SUM(inaj014*inaj011) INTO l_inaj_total
           FROM inaj_t
          WHERE inajent = g_enterprise
            AND inajsite = g_site
            AND inaj005 = sr[i].bmba001
            AND inaj004 = -1
            AND inaj022 BETWEEN g_stage[p_i].bdate AND g_stage[p_i].edate  
         IF cl_null(l_inaj_total) THEN LET l_inaj_total = 0 END IF
         LET l_inaj_total = l_inaj_total*sr[i].bmba011
         LET g_stage[p_i].inaj_total = g_stage[p_i].inaj_total + l_inaj_total         
         
         
         CALL aimp100_root_bom(p_level,sr[i].bmba002,sr[i].bmba001,p_i)
      END FOR
      IF l_ac = 1 THEN 
         EXIT WHILE
      END IF
   END WHILE   
END FUNCTION

#end add-point
 
{</section>}
 
