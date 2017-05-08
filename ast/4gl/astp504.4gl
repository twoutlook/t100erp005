#該程式未解開Section, 採用最新樣板產出!
{<section id="astp504.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2017-01-10 18:06:58), PR版次:0008(2017-01-16 16:38:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: astp504
#+ Description: 專櫃合約月預扣成本批次產生作業
#+ Creator....: 02749(2015-06-01 02:26:30)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="astp504.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160705-00042#10   2016/07/13  By sakura   程式中寫死g_prog部分改寫MATCHES方式
#160727-00019#19   2016/08/15  By 08734    临时表长度超过15码的减少到15码以下
#161201-00043#1    2016/12/01  By lori     月預扣與保底計算的變數應在回圈中進行初始化
#160516-00014#42   2017/01/06  By lori     1.專櫃合約新增欄位：stfa057 終止保底計算，對應調整月預扣與保底差額的結算邏輯
#                                          2.取消毋須應用的暫存表欄位:stfe008_year/stfe008_date/stfe009_year/stfe009_date
#                                          3.月預扣補寫費率,調整結算截止日判斷
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
        stfasite LIKE type_t.chr500, 
        l_date   LIKE type_t.chr500, 
        l_del    LIKE type_t.chr500, 
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       stfasite LIKE type_t.chr500, 
   stfa005 LIKE stfa_t.stfa005, 
   stfa010 LIKE stfa_t.stfa010, 
   l_date LIKE type_t.chr500, 
   l_del LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 TYPE type_stga RECORD             
   stgaent       LIKE stga_t.stgaent  ,   #企業編號
   stgasite      LIKE stga_t.stgasite ,   #營運組織
   stgaunit      LIKE stga_t.stgaunit ,   #應用組織
   stga001       LIKE stga_t.stga001  ,   #銷售日期
   stga002       LIKE stga_t.stga002  ,   #商品編號
   stga003       LIKE stga_t.stga003  ,   #庫區編號
   stga004       LIKE stga_t.stga004  ,   #專櫃編號
   stga005       LIKE stga_t.stga005  ,   #供應商編號
   stga006       LIKE stga_t.stga006  ,   #費用編號
   stga007       LIKE stga_t.stga007  ,   #銷售數量
   stga008       LIKE stga_t.stga008  ,   #應收金額
   stga009       LIKE stga_t.stga009  ,   #實收金額
   stga010       LIKE stga_t.stga010  ,   #費率
   stga011       LIKE stga_t.stga011  ,   #費用金額
   stga012       LIKE stga_t.stga012  ,   #成本金額
   stga013       LIKE stga_t.stga013  ,   #日結成本類別 
   stga014       LIKE stga_t.stga014  ,   #價款類型
   stga015       LIKE stga_t.stga015  ,   #已結轉否
   stgadocno     LIKE stga_t.stgadocno,   #來源單號
   stga016       LIKE stga_t.stga016  ,   #銷售單單號    #150914-00002#45 151103 by lori add
   stga017       LIKE stga_t.stga017      #銷售單項次    #150914-00002#45 151103 by lori add
                       END RECORD
                       
#150805-00003#26 150916 by lori add---(S)
TYPE astp504_acc RECORD
      inaasite          LIKE inaa_t.inaasite,
      inaa001           LIKE inaa_t.inaa001, 
      inaa120           LIKE inaa_t.inaa120, 
      inaa135           LIKE inaa_t.inaa135, 
      inaa141           LIKE inaa_t.inaa141, 
      acc_date          LIKE glav_t.glav004,
      stff001           LIKE stff_t.stff001, 
      stff006           LIKE stff_t.stff006, 
      stff007           LIKE stff_t.stff007, 
      stff008           LIKE stff_t.stff008, 
      stfeseq           LIKE stfe_t.stfeseq, 
      stfe002           LIKE stfe_t.stfe002, 
      stfe003           LIKE stfe_t.stfe003, 
      stfe004           LIKE stfe_t.stfe004, 
      stfe005           LIKE stfe_t.stfe005, 
      stfe006           LIKE stfe_t.stfe006, 
      stfe007           LIKE stfe_t.stfe007, 
      stfe008           LIKE stfe_t.stfe008, 
      stfe009           LIKE stfe_t.stfe009, 
      stfe012           LIKE stfe_t.stfe012, 
      stfa010           LIKE stfa_t.stfa010,    
      stae006           LIKE stae_t.stae006, 
      receivable_flag   LIKE stab_t.stab010,
      preg051           LIKE preg_t.preg051,
      prei001           LIKE prei_t.prei001,
      prei059           LIKE prei_t.prei009,       
      debc013           LIKE debc_t.debc013,    
      debc016           LIKE debc_t.debc016,    
      debc020           LIKE debc_t.debc020,    
      stgg007           LIKE stgg_t.stgg007,    
      stgg008           LIKE stgg_t.stgg008,    
      stgg009           LIKE stgg_t.stgg009,    
      stgg010           LIKE stgg_t.stgg010  
                 END RECORD 
DEFINE g_counter_acc    STRING    #已有庫區結轉的專櫃,SQL只定義一次,作為後續過濾資料的篩選條件
#150805-00003#26 150916 by lori add---(E)  

#160225-00040#21 160428 by lori add---(E)
DEFINE g_progress        RECORD                 
          msg                  STRING,
          step_cnt             LIKE type_t.num10            
                         END RECORD
#160225-00040#21 160428 by lori add---(E)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp504.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')   #stfasite
   LET g_argv[2] = cl_replace_str(g_argv[4], '\"', '')   #l_date
   LET g_argv[3] = cl_replace_str(g_argv[5], '\"', '')   #l_del
   LET g_argv[4] = cl_replace_str(g_argv[6], '\"', '')   #wc
   
   DISPLAY 'g_argv[1]-stfasite: ',g_argv[1]
   DISPLAY 'g_argv[2]-l_date: ',g_argv[2]
   DISPLAY 'g_argv[3]-l_del: ',g_argv[3]
   DISPLAY 'g_argv[4]-l_del: ',g_argv[4]
   
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      LET lc_param.stfasite = g_argv[1]
      LET lc_param.l_date = g_argv[2]
      LET lc_param.l_del = g_argv[3] 
      LET lc_param.wc = g_argv[4]

      IF cl_null(lc_param.wc) THEN
         LET lc_param.wc = " 1=1 "
      END IF
      LET ls_js = util.JSON.stringify(lc_param)
      #end add-point
      CALL astp504_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp504 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp504_init()
 
      #進入選單 Menu (="N")
      CALL astp504_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp504
   END IF
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp504.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp504_init()
 
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
 
{<section id="astp504.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp504_ui_dialog()
 
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
         INPUT BY NAME g_master.stfasite,g_master.l_date,g_master.l_del 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.l_del = 'Y'
               DISPLAY BY NAME g_master.l_del
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfasite
            #add-point:BEFORE FIELD stfasite name="input.b.stfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfasite
            
            #add-point:AFTER FIELD stfasite name="input.a.stfasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stfasite
            #add-point:ON CHANGE stfasite name="input.g.stfasite"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_del
            #add-point:BEFORE FIELD l_del name="input.b.l_del"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_del
            
            #add-point:AFTER FIELD l_del name="input.a.l_del"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_del
            #add-point:ON CHANGE l_del name="input.g.l_del"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.stfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfasite
            #add-point:ON ACTION controlp INFIELD stfasite name="input.c.stfasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')
            
            CALL q_ooef001_24()
            
            LET g_master.stfasite = g_qryparam.return1
            DISPLAY BY NAME g_master.stfasite 
            NEXT FIELD stfasite                     
            #END add-point
 
 
         #Ctrlp:input.c.l_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_date
            #add-point:ON ACTION controlp INFIELD l_date name="input.c.l_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_del
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_del
            #add-point:ON ACTION controlp INFIELD l_del name="input.c.l_del"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stfa005,stfa010
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa005
            #add-point:ON ACTION controlp INFIELD stfa005 name="construct.c.stfa005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_mhae001_2()                    
                                                   
            DISPLAY g_qryparam.return1 TO stfa005 
            NEXT FIELD stfa005                    
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
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            
            CALL q_pmaa001_1()                    
            
            DISPLAY g_qryparam.return1 TO stfa010 
            NEXT FIELD stfa010                    
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
            CALL astp504_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.l_date = g_today
            LET g_master.l_del = 'N'
            
            DISPLAY g_master.l_date TO l_date
            DISPLAY g_master.l_del TO l_del
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
         CALL astp504_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.l_date   = g_master.l_date
      LET lc_param.stfasite = g_master.stfasite
      LET lc_param.l_date   = g_master.l_date  
      LET lc_param.l_del    = g_master.l_del
      LET lc_param.wc       = g_master.wc
 
      IF cl_null(lc_param.wc) THEN
         LET lc_param.wc = " 1=1 "
      END IF      
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
                 CALL astp504_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp504_transfer_argv(ls_js)
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
 
{<section id="astp504.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp504_transfer_argv(ls_js)
 
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
 
{<section id="astp504.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp504_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE l_ooef001        LIKE ooef_t.ooef001    #組織編號
   DEFINE l_debcsite       LIKE debc_t.debcsite   #門店
   DEFINE l_debc010        LIKE debc_t.debc010    #專櫃
   DEFINE l_mhae006        LIKE mhae_t.mhae006    #供應商
   DEFINE l_stga013        LIKE stga_t.stga013    #成本類型   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_success = ''
   IF NOT astp504_create_temp() THEN
      RETURN
   END IF
   
   INITIALIZE g_progress.* TO NULL   #160225-00040#21 160428 by lori add
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET g_progress.step_cnt = 5                           #160225-00040#21 160428 by lori add
      CALL cl_progress_bar_no_window(g_progress.step_cnt)   #160225-00040#21 160428 by lori add
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp504_process_cs CURSOR FROM ls_sql
#  FOREACH astp504_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()

   #0.初始化
   LET l_err_cnt = 0 
   #初始化-成本類型
   #160705-00042#10 160713 by sakura mark(S)
   #CASE g_prog
   #   WHEN 'astp504'
   #160705-00042#10 160713 by sakura mark(E)
   #160705-00042#10 160713 by sakura add(S)
   CASE 
      WHEN g_prog MATCHES 'astp504'
   #160705-00042#10 160713 by sakura add(E)
         LET l_stga013 = '3'
      #WHEN 'astp505'                 #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'astp505'   #160705-00042#10 160713 by sakura add
         LET l_stga013 = '4'
   END CASE   
   
   #150805-00003#26 150916 by lori add---(S)
   #SQL-已有庫區結轉的專櫃,作為後續過濾資料的篩選條件
   LET g_counter_acc = "(SELECT stga004 ",
                       "   FROM stga_t ",
                       "  WHERE stgaent = ",g_enterprise,
                       "    AND stga013 = '",l_stga013,"' ",                            #成本類型 
                       "    AND stga015 = 'Y' ",                                        #已結轉
                       "    AND EXISTS(SELECT 1 FROM astp504_org ",                     
                       "                WHERE stgasite = ooef001 ",                     #營運組織
                       "                  AND stga001 BETWEEN pdate_s AND pdate_e ",    #統計日期在本次計算的會計期間內
                       "                  AND acc_flag = 'N') ",                        #日結檔須在可結算的範圍
                       ")"                       
   #150805-00003#26 150916 by lori add---(E)   
   
   #1.取值
   #1.1.清除暫存檔   
   DELETE FROM astp504_org        #組織會計週期日起訖      
  #DELETE FROM astp504_debc       #門店日結資料           #150805-00003#36 150915 by lori mark
  #DELETE FROM astp504_stgg       #專櫃每日促銷銷售情況    #150805-00003#36 150915 by lori mark
  #DELETE FROM astp504_contract   #專櫃合同資料           #160727-00019#19 16/08/15 By 08734 mark
   DELETE FROM astp504_tmp01      #專櫃合同資料            #160727-00019#19 16/08/15 By 08734 add
  #DELETE FROM astp504_promotions #促銷資料               #150805-00003#36 150915 by lori mark
  #DELETE FROM astp504_stga       #已存在的銷售成本資料    #150805-00003#36 150915 by lori mark
  
   
   #1.2.取得要處理的資料
   LET l_success = ''
   CALL astp504_get_data(ls_js) RETURNING l_success
   #1.3.判斷結算的會計週期的結束日小於當前組織的日結關帳日期，大於當前組織的庫存關帳日列錯誤訊息
   LET l_sql = "SELECT UNIQUE ooef001 FROM astp504_org ",    
               " WHERE acc_flag = 'Y' "
   PREPARE astp504_acc_error_pre FROM l_sql
   DECLARE astp504_acc_error_cur CURSOR FOR astp504_acc_error_pre
   #DISPLAY "[astp504_acc_error_pre] ",l_sql
   
   FOREACH astp504_acc_error_cur INTO l_ooef001 
      #統計日期不可以小於當前組織的日結關帳日期，不可大於當前組織的庫存關帳日期！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ast-00303"
      LET g_errparam.extend = l_ooef001
      LET g_errparam.popup = TRUE
      CALL cl_err()    
   END FOREACH
   #1.4.判斷專櫃中是否含庫區資料已結轉,已結轉者不可重新結算 
   LET l_debcsite = ''
   LET l_debc010  = ''
   LET l_mhae006  = ''
   
   LET l_sql = "SELECT UNIQUE debcsite,debc010,mhae006 ",
               "  FROM astp504_debc ",
               " WHERE counter_acc > 0 "
   PREPARE astp504_stga015_exists_pre FROM l_sql 
   DECLARE astp504_stga015_exists_cur CURSOR FOR astp504_stga015_exists_pre     
   FOREACH astp504_stga015_exists_cur INTO l_debcsite,l_debc010,l_mhae006
      #供應商(%1)在組織(%2)的專櫃(%3)已有月預扣成本結轉資料，不可重新產生月預扣資料！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ast-00301"      
      LET g_errparam.extend = ""
      LET g_errparam.replace[1] = l_mhae006
      LET g_errparam.replace[2] = l_debcsite
      LET g_errparam.replace[3] = l_debc010
      LET g_errparam.popup = TRUE
      CALL cl_err() 
   END FOREACH
     
   #2.判斷是否重新結算
   ##2.1.如果刪除再重新結算(l_del = 'Y'),則刪除原結算資料
   ##2.2.如果不刪除重新結算(l_del = 'N'),則以訊息提示 
   #SQL-刪除已結算但未結轉的資料
   LET l_sql = "DELETE FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stga013 = '",l_stga013,"' ",                            #成本類型    
               "   AND EXISTS(SELECT 1 FROM astp504_org ",
               "               WHERE stgasite = ooef001 ",                     #營運組織
               "                 AND stga001 BETWEEN pdate_s AND pdate_e  ",   #統計日期
               "                 AND acc_flag = 'N') ",                        #日結檔須在可結算的範圍 
               "   AND stga004 NOT IN ",g_counter_acc                          #150805-00003#36 150916 by lori add
               #150805-00003#36 150916 by lori mark---(S)
               # "   AND EXISTS(SELECT 1 FROM astp504_debc ",                    
               # "               WHERE stgasite = debcsite ",                  #營運組織
               # "                 AND stga004 = debc010 ",                    #專櫃
               # "                 AND counter_acc = 'N') "                    #專櫃尚無庫區已結轉 
               #150805-00003#36 150916 by lori mark---(E)               
   PREPARE astp504_del_stga FROM l_sql 
   
   #150914-00002#45 151104 by lori add---(S)
   #SQL-已存在的結算資料
   LET l_sql = "SELECT COUNT(stgaent) ",
               "  FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stgasite = ? ",     #營運組織
               "   AND stga001  = ? ",     #銷售日期
               "   AND stga002  = ? ",     #商品編號
               "   AND stga003  = ? ",     #庫區編號
               "   AND stga013  = ? ",     #日結成本類型
               "   AND stgadocno = ?"      #來源單號
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_cnt_stga FROM l_sql
   
   #SQL-取成本類型IN('5','10','20','21')的成本金額
   #150914-00002#53 151203 by lori mod---(S)
   #調整成本類型：
   #   2:合同扣率成本調整   5:目標銷售成本          8:促銷扣率調整成本        9:促銷保底成本
   #  10:促銷目標銷售成本  13:銷退成本調整         16:促銷保底調整成本       17:合约扣率补差调整
   #  18:结算销退成本调整  20:合同目标销售成本调整  21:促銷目標銷售成本調整   22:串碼銷售調整成本
   #  150914-00002#53 151203 by lori mod---(E)
   LET l_sql = "SELECT SUM(COALESCE(stga012,0)) ",
               "  FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stgasite = ?  ",                    #營運組織
               "   AND stga001 BETWEEN ? AND ? ",          #銷售日期
               "   AND stga002  = ?  ",                    #商品編號
               "   AND stga003  = ?  ",                    #庫區編號
               "   AND stga013  = ?  ",                    #日結成本類型
               "   AND stgadocno = ? ",                    #來源單號
              #"   AND stga013 IN ('5','10','20','21') "   #成本類型                             #150914-00002#53 151203 by lori mark
               "   AND stga013 IN ('2','5','8','9','10','13','16','17','18','20','21','22') "   #150914-00002#53 151203 by lori add 
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_sel_stga FROM l_sql   
   #150914-00002#45 151104 by lori add---(E)
   #3.結算
   LET l_sql = "INSERT INTO stga_t(stgaent  ,stgasite ,stgaunit ,stga001  ,stga002  , ",
               "                   stga003  ,stga004  ,stga005  ,stga006  ,stga007  , ",
               "                   stga008  ,stga009  ,stga010  ,stga011  ,stga012  , ",
               "                   stga013  ,stga014  ,stga015  ,stgadocno,stga016  , ",    #150914-00002#45 151103 by lori add stga016
               "                   stga017 )           ",                                   #150914-00002#45 151103 by lori add stga017
               "VALUES(?  ,?  ,?  ,?  ,?  , ",
               "       ?  ,?  ,?  ,?  ,?  , ",
               "       ?  ,?  ,?  ,?  ,?  , ",
               "       ?  ,?  ,?  ,?  ,?  , ",    #150914-00002#45 151103 by lori add ?對應stga016 
               "       ? )     "                  #150914-00002#45 151103 by lori add ?對應stga017 
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_stga_ins FROM l_sql  
   
   CALL s_transaction_begin()
   
   #150805-00003#36 150916 by lori add---(S)
   IF lc_param.l_del = 'Y' THEN
      #SQL-刪除已結算過資料
      EXECUTE astp504_del_stga      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Delete stga_t"
         LET g_errparam.popup = TRUE
         CALL cl_err() 
      
         LET l_err_cnt = l_err_cnt + 1
      END IF 
      DISPLAY "[astp504_del_stga] CNT: ",SQLCA.sqlerrd[3]      
   END IF
   #150805-00003#36 150916 by lori add---(E)
   
   #160705-00042#10 160713 by sakura mark(S)   
   #CASE g_prog 
   #   WHEN 'astp504'
   #160705-00042#10 160713 by sakura mark(E)
   #160705-00042#10 160713 by sakura add(S)
   CASE  
      WHEN g_prog MATCHES 'astp504'
   #160705-00042#10 160713 by sakura add(E)      
         LET g_progress.msg = cl_getmsg('ast-00735',g_lang)   #160225-00040#21 160428 by lori add
         CALL cl_progress_no_window_ing(g_progress.msg)       #160225-00040#21 160428 by lori add
         
         IF NOT astp504_process_1(ls_js) THEN
            LET l_err_cnt = l_err_cnt + 1
         END IF    
      #WHEN 'astp505'                 #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'astp505'   #160705-00042#10 160713 by sakura add
         LET g_progress.msg = cl_getmsg('ast-00736',g_lang)   #160225-00040#21 160428 by lori add
         CALL cl_progress_no_window_ing(g_progress.msg)       #160225-00040#21 160428 by lori add      
      
         IF NOT astp504_process_2(ls_js) THEN
            LET l_err_cnt = l_err_cnt + 1
         END IF 
   END CASE
   
   IF l_err_cnt = 0 THEN
      CALL s_transaction_end('Y','1') 
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
   CALL cl_err_collect_show()
   LET l_success = ''
   CALL astp504_drop_temp() RETURNING l_success  
   
   LET g_progress.msg = cl_getmsg('std-00012',g_lang)   #160225-00040#21 160428 by lori add
   CALL cl_progress_no_window_ing(g_progress.msg)       #160225-00040#21 160428 by lori add   
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
   CALL astp504_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp504.get_buffer" >}
PRIVATE FUNCTION astp504_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.stfasite = p_dialog.getFieldBuffer('stfasite')
   LET g_master.l_date = p_dialog.getFieldBuffer('l_date')
   LET g_master.l_del = p_dialog.getFieldBuffer('l_del')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp504.msgcentre_notify" >}
PRIVATE FUNCTION astp504_msgcentre_notify()
 
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
 
{<section id="astp504.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 建立暫存檔
# Memo...........:
# Usage..........: CALL astp504_create_temp()
#                  RETURNING r_success
# Return Code....: r_success   處理結果
# Date & Author..: 2015/05/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp504_create_temp()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_err_cnt      LIKE type_t.num5
   DEFINE l_session      LIKE type_t.num10   #For Background Inf.
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   LET l_session = ''
   
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   DISPLAY "astp504-SessionId: ",l_session
   
   IF NOT astp504_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #組織會計週期日起訖
   #ooef001   營運組織
   #ooef017   法人
   #glaald    法人主帳套
   #glaa003   主帳套的會計期參照表
   #acc_year  會計年度
   #acc_mon   會計期別
   #pdate_s   會計期起始日
   #pdate_e   會計期結束日
   #cdate     關帳日期
   #acc_flag  結算結束日是否小於關帳日期,Y=大於關帳日不可結算, N=小於關帳日可結算
   CREATE TEMP TABLE astp504_org( 
      ooef001      LIKE ooef_t.ooef001,
      ooef017      LIKE ooef_t.ooef017,
      glaald       LIKE glaa_t.glaald,
      glaa003      LIKE glaa_t.glaa003,
      acc_year     LIKE glav_t.glav002,
      acc_mon      LIKE glav_t.glav006,
      pdate_s      LIKE glav_t.glav004,
      pdate_e      LIKE glav_t.glav004,
      c_date       LIKE type_t.dat,
      acc_flag     LIKE type_t.chr1)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create astp504_org:'  
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF

   #150805-00003#36 150915 by lori mark---(S)
   ##門店日結資料
   ##debcsite     門店編號
   ##debc010      專櫃編號
   ##debc005      庫區編號(常規庫區/促銷庫區)
   ##debc005_par  對應常規庫區 
   ##inaa135      庫區類型   
   ##debc013      銷售數量 
   ##debc016      原價金額    #150805-00003#41 150831 by lori 應收金額改取原價金額 
   ##debc020      實收金額
   ##debc002      統計日期
   ##mhae006      供應商編號  
   ##counter_acc  專櫃是否已有庫區結轉
   #CREATE TEMP TABLE astp504_debc(
   #   debcsite       LIKE debc_t.debcsite,
   #   debc010        LIKE debc_t.debc010,
   #   debc005        LIKE debc_t.debc005,
   #   debc005_par    LIKE debc_t.debc005,
   #   inaa135        LIKE inaa_t.inaa135,
   #   debc013        LIKE debc_t.debc013,
   #   debc016        LIKE debc_t.debc016,   #150805-00003#41 150831 by lori
   #   debc020        LIKE debc_t.debc020,
   #   debc002        LIKE debc_t.debc002,
   #   mhae006        LIKE mhae_t.mhae006,
   #   counter_acc    LIKE stga_t.stga015)
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Create astp504_debc:'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF
   #
   ##專櫃每日促銷銷售情況
   ##stggsite      營運組織
   ##stgg001       促銷日期
   ##stgg002       庫區編號 
   ##stgg002_par   庫區編號 
   ##inaa102       庫區類型
   ##stgg003       專櫃編號
   ##stgg004       供應商編號
   ##stgg005       樓層編號
   ##stgg006       應收金額
   ##stgg007       實收金額
   ##stgg008       實收毛利額
   ##stgg009       實收毛利率
   ##counter_acc  專櫃是否已有庫區結轉
   #CREATE TEMP TABLE astp504_stgg(
   #   stggsite       LIKE stgg_t.stggsite,  
   #   stgg001        LIKE stgg_t.stgg001 ,  
   #   stgg002        LIKE stgg_t.stgg002 ,
   #   stgg002_par    LIKE stgg_t.stgg002 ,
   #   inaa102        LIKE inaa_t.inaa102 ,      
   #   stgg003        LIKE stgg_t.stgg003 ,  
   #   stgg004        LIKE stgg_t.stgg004 ,  
   #   stgg005        LIKE stgg_t.stgg005 ,  
   #   stgg006        LIKE stgg_t.stgg006 ,  
   #   stgg007        LIKE stgg_t.stgg007 ,  
   #   stgg008        LIKE stgg_t.stgg008 ,  
   #   stgg009        LIKE stgg_t.stgg009 ,
   #   counter_acc    LIKE stga_t.stga015) 
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Create astp504_stgg:'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF
   #
   ##專櫃合同資料
   ##stfasite  營運組織
   ##stfa005   專櫃編號
   ##stfa001   合約編號
   ##stfa019   合約生效日期
   ##stfa020   合約失效日期
   ##stfeseq   保底項次
   ##stfe002   方案編號
   ##stfe008   保底方案開始日
   ##stfe009   保底方案結束日           
   ##stfe003   費用編號
   ##stfe004   保底方式
   ##stfe005   分量扣點方式
   ##stfe006   保底計算週期
   ##stfe007   月預扣標準
   ##stfe012   月預扣方式   
   ##stff005   庫區編號
   ##stff006   截止金額
   ##stff007   起始金額
   ##stff008   執行扣率
   ##stae006   價款類別  
   ##receivable_flag   應收FLAG;Y=採用應收金額,N=採用實收金額
   #CREATE TEMP TABLE astp504_contract(
   #    stfasite          LIKE stfa_t.stfasite,
   #    stfa005           LIKE stfa_t.stfa005,
   #    stfa001           LIKE stfa_t.stfa001,
   #    stfa019           LIKE stfa_t.stfa019,
   #    stfa020           LIKE stfa_t.stfa020,
   #    stfeseq           LIKE stfe_t.stfeseq,
   #    stfe002           LIKE stfe_t.stfe002,
   #    stfe008           LIKE stfe_t.stfe008,
   #    stfe009           LIKE stfe_t.stfe009,        
   #    stfe003           LIKE stfe_t.stfe003,
   #    stfe004           LIKE stfe_t.stfe004,
   #    stfe005           LIKE stfe_t.stfe005,
   #    stfe006           LIKE stfe_t.stfe006,
   #    stfe007           LIKE stfe_t.stfe007,
   #    stfe012           LIKE stfe_t.stfe012,
   #    stff005           LIKE stff_t.stff005,
   #    stff006           LIKE stff_t.stff006,
   #    stff007           LIKE stff_t.stff007,
   #    stff008           LIKE stff_t.stff008,
   #    stae006           LIKE stae_t.stae006,
   #    receivable_flag   LIKE type_t.chr1)
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Create astp504_contract:'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF
   #
   ##促銷資料
   ##stfa001       專櫃合約編號
   ##prei003       庫區編號
   ##prei003_par   對應常規庫區
   ##preh003       開始日期
   ##preh004       結束日期
   #CREATE TEMP TABLE astp504_promotions(
   #   stfa001     LIKE stfa_t.stfa001,
   #   prei003     LIKE prei_t.prei003,
   #   prei003_par LIKE prei_t.prei003,
   #   preh003     LIKE preh_t.preh003,
   #   preh004     LIKE preh_t.preh004) 
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'astp504_promotions:'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF
   #
   ##已存在的銷售成本資料
   ##stgasite     門店編號
   ##stga003      庫區編號
   ##stga004      專櫃編號
   ##stga005      供應商編號
   ##stga004_cnt  筆數
   #CREATE TEMP TABLE astp504_stga(   
   #   stgasite      LIKE stga_t.stgasite,
   #   stga003       LIKE stga_t.stga003 ,
   #   stga004       LIKE stga_t.stga004 ,
   #   stga005       LIKE stga_t.stga005 ,
   #   stga004_cnt   LIKE type_t.num5)
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'astp504_stga:'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF
   #150805-00003#36 150915 by lori mark---(E)
   
   #150805-00003#36 150915 by lori add---(S)   
   #專櫃庫區展開每日對應保底和銷售資料
   #inaasit           #營運據點(debcsite/stggsite)
   #inaa001           #庫區編號(debc005/stgg002)
   #inaa120           #專櫃編號(debc010/stgg003)
   #inaa135           #庫區適用類型(1.常規庫區 2.促銷庫區)
   #inaa141           #對應常規庫區
   #acc_date          #日期(glav004):銷售日(debc002)/促銷日期(stgg001)
   #stff001           #專櫃合同編號
   #stff006           #截止金額
   #stff007           #起始金額
   #stff008           #執行扣率
   #stfeseq           #保底項次
   #stfe002           #保底方案編號
   #stfe003           #費用編號
   #stfe004           #保底方式
   #stfe005           #分量扣點方式
   #stfe006           #保底計算週期
   #stfe007           #月預扣標準
   #stfe008           #保底開始日期
   #stfe009           #保底截止日期
   #stfe012           #月預扣方式
   #stfa010           #供應商編號/(stgg004)
   #stfa057           #終止保底計算           #160516-00014#42 170106 by lori add
   #stae006           #價款類別
   #receivable_flag   #應收FLAG(stab010):Y=採用應收金額,N=採用實收金額
   #preg051           #促銷類型     
   #prei001           #促銷規則編號   
   #prei059           #促銷參與保底否
   #debc013           #銷售數量
   #debc016           #原價金額
   #debc020           #實收金額
   #stgg007           #應收金額
   #stgg008           #實收金額
   #stgg009           #實收毛利額
   #stgg010           #實收毛利率     
   CREATE TEMP TABLE astp504_acc_tmp(          
      inaasite          LIKE inaa_t.inaasite,
      inaa001           LIKE inaa_t.inaa001, 
      inaa120           LIKE inaa_t.inaa120, 
      inaa135           LIKE inaa_t.inaa135, 
      inaa141           LIKE inaa_t.inaa141, 
      acc_date          LIKE glav_t.glav004,
      stff001           LIKE stff_t.stff001, 
      stff006           LIKE stff_t.stff006, 
      stff007           LIKE stff_t.stff007, 
      stff008           LIKE stff_t.stff008, 
      stfeseq           LIKE stfe_t.stfeseq, 
      stfe002           LIKE stfe_t.stfe002, 
      stfe003           LIKE stfe_t.stfe003, 
      stfe004           LIKE stfe_t.stfe004, 
      stfe005           LIKE stfe_t.stfe005, 
      stfe006           LIKE stfe_t.stfe006, 
      stfe007           LIKE stfe_t.stfe007, 
      stfe008           LIKE stfe_t.stfe008, 
      stfe009           LIKE stfe_t.stfe009, 
      stfe012           LIKE stfe_t.stfe012, 
      stfa010           LIKE stfa_t.stfa010, 
      stfa057           LIKE stfa_t.stfa057,   #160516-00014#42 170106 by lori add  
      stae006           LIKE stae_t.stae006, 
      receivable_flag   LIKE stab_t.stab010,
      preg051           LIKE preg_t.preg051,
      prei001           LIKE prei_t.prei001,
      prei059           LIKE prei_t.prei059,       
      debc013           LIKE debc_t.debc013,    
      debc016           LIKE debc_t.debc016,    
      debc020           LIKE debc_t.debc020,    
      stgg007           LIKE stgg_t.stgg007,    
      stgg008           LIKE stgg_t.stgg008,   
      stgg009           LIKE stgg_t.stgg009,    
      stgg010           LIKE stgg_t.stgg010)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'astp504_acc_tmp:'  
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET l_err_cnt = l_err_cnt + 1
   END IF   
   #150805-00003#36 150915 by lori add---(E)
   
   #160302-00016#1 160302 by lori add---(S)
  #CREATE TEMP TABLE astp504_contract(      #160727-00019#19 16/08/15 By 08734 mark
   CREATE TEMP TABLE astp504_tmp01(         #160727-00019#19 16/08/15 By 08734 add
      stfaent       LIKE stfa_t.stfaent,
      stfasite      LIKE stfa_t.stfasite,
      stfa005       LIKE stfa_t.stfa005,
      stfa001       LIKE stfa_t.stfa001,
      stfa010       LIKE stfa_t.stfa010,
      stfa057       LIKE stfa_t.stfa057,    #160516-00014#42 170106 by lori add
      stfeseq       LIKE stfe_t.stfeseq,
      stfe002       LIKE stfe_t.stfe002,
      stfe003       LIKE stfe_t.stfe003,
      stfe004       LIKE stfe_t.stfe004,
      stfe005       LIKE stfe_t.stfe005,      
      stfe006       LIKE stfe_t.stfe006,
      stfe007       LIKE stfe_t.stfe007,
      stfe008       LIKE stfe_t.stfe008,
     #stfe008_year  LIKE type_t.num5,       #160516-00014#42 170106 by lori mark
     #stfe008_date  LIKE stfe_t.stfe008,    #160516-00014#42 170106 by lori mark
      stfe009       LIKE stfe_t.stfe009,    
     #stfe009_year  LIKE type_t.num5,       #160516-00014#42 170106 by lori mark
     #stfe009_date  LIKE stfe_t.stfe009,    #160516-00014#42 170106 by lori mark
      stfe012       LIKE stfe_t.stfe012)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
     #LET g_errparam.extend = 'astp504_contract:'   #160727-00019#19 16/08/15 By 08734 mark
      LET g_errparam.extend = 'astp504_tmp01:'      #160727-00019#19 16/08/15 By 08734 add
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET l_err_cnt = l_err_cnt + 1
   END IF   
   #160302-00016#1 160302 by lori add---(E)
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL astp504_drop_temp()
#                  RETURNING r_success
# Return Code....: r_success   處理結果
# Date & Author..: 2015/05/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp504_drop_temp()
   DEFINE r_success      LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE

   DROP TABLE astp504_org 
   
   #150805-00003#36 150915 by lori mark---(S)
   #DROP TABLE astp504_debc
   #DROP TABLE astp504_stgg     
   #DROP TABLE astp504_contract   
   #DROP TABLE astp504_promotions
   #DROP TABLE astp504_stga           
   #150805-00003#36 150915 by lori mark---(E)
   
   DROP TABLE astp504_acc_tmp 
   
  #DROP TABLE astp504_contract       #150805-00003#36 150915 by lori add   #160727-00019#19 16/08/15 By 08734 mark
   DROP TABLE astp504_tmp01          #160727-00019#19 16/08/15 By 08734 add
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得批次處理的營運組織範圍,組織的關帳日期,組織的會計週期資訊
# Memo...........:
# Usage..........: CALL astp504_get_org_scope(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/05/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp504_get_org_scope(ls_js)
   DEFINE ls_js         STRING
   DEFINE r_success     LIKE type_t.num5
   DEFINE lc_param      type_parameter
   DEFINE l_err_cnt     LIKE type_t.num5
   DEFINE l_sql         STRING   
   DEFINE l_where       STRING
   DEFINE l_org_where   STRING
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE l_ooef017     LIKE ooef_t.ooef017
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_acc_year    LIKE glav_t.glav002
   DEFINE l_acc_mon     LIKE glav_t.glav006
   DEFINE l_pdate_s     LIKE glav_t.glav004
   DEFINE l_pdate_e     LIKE glav_t.glav004
   DEFINE l_cdate_1     LIKE type_t.dat
   DEFINE l_cdate_2     LIKE type_t.dat
   DEFINE l_acc_flag    LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
               
   #取得本次要結算(有專櫃合同者)的組織範圍和組織的前一會計週期起訖日
   #組織範圍取得方式:
   #(1)取有效的組織
   #(2)依(1)取得的組織篩選,需符合專櫃合約組織
   #   取專櫃合約時依輸入條件篩選:營運組織(lc_param.stfasite)/專櫃/供應商
   #(3)取專櫃合約的組織時,須依aooi500設定取得組織範圍並進行篩選
   #帳套,會計期參照表取得方式:
   #(1)取得組織所屬的法人ooef017
   #(2)依法人取得主帳套glaald,會計期參照表glaa003
   #會計日期起迄取得方式:
   #(1)依統計日期(lc_param.l_date)取出所屬的會計期參照表t2.glav001,會計年度t2.acc_year, 期別t2.acc_mon
   #(2)依(1)取同會計期參照表中的前一會計週期的年度acc_year, 期別acc_mon
   #   IF    t2.acc_mon = 1, 則前一週期的 年度t1.acc_year = t2.acc_year-1, 期別t1.acc_mon = 12 
   #   ELSE                  則前一週期的 年度t1.acc_year = t2.acc_year,   期別t1.acc_mon = t2.acc_mon-1 
   
   LET l_where = s_aooi500_sql_where(g_prog,"stfasite")
   LET l_org_where = lc_param.stfasite
   
   #批次輸入條件,字串轉換
   IF NOT cl_null(l_org_where) THEN
      LET l_org_where = cl_replace_str(l_org_where,"|","','")   
      LET l_org_where = "stfasite IN ('",l_org_where,"') "
   ELSE
      LET l_org_where = "1=1"
   END IF
   
   LET l_sql = "SELECT UNIQUE ooef001,ooef017,glaald,glaa003, ",     #組織編號,法人編號,法人主帳套,會計期參照表
               "              acc_year,acc_mon,pdate_s,pdate_e, ",   #會計年度,會計期別,會計期間起始日期,會計期間結束日期
               "              'N' ",                                 #結算結束日期是否小於關帳日期(此處為temp預設)
               "  FROM ooef_t, ",
               "       glaa_t ",
               "          LEFT JOIN (SELECT t1.glavent,t1.glav001,t1.glav002 acc_year,t1.glav006 acc_mon, ",
               "                            MIN(t1.glav004) pdate_s,MAX(t1.glav004) pdate_e ",
               "                       FROM glav_t t1 ",
               "                      WHERE EXISTS (SELECT 1 ",
               "                                      FROM (SELECT glavent,glav001, ",
               "                                                  (CASE WHEN glav006 = 1 THEN glav002 - 1 ",
               "                                                        ELSE glav002 ",
               "                                                    END) acc_year, ",
               "                                                  (CASE WHEN glav006 = 1 THEN 12 ",
               "                                                        ELSE glav006 - 1 ",
               "                                                    END) acc_mon ",
               "                                              FROM glav_t ",
               "                                             WHERE glav004 = '",lc_param.l_date,"' ",
               "                                           ) t2 ",
               "                                     WHERE t1.glavent = t2.glavent  AND t1.glav001 = t2.glav001 ",
               "                                       AND t1.glav002 = t2.acc_year AND t1.glav006 = t2.acc_mon ",
               "                                   ) ",
               "                      GROUP BY t1.glavent,t1.glav001,t1.glav002,t1.glav006) ",
               "                 ON glavent = glaaent AND glav001 = glaa003 ",
               "     WHERE ooefent = glaaent ",
               "       AND ooef017 = glaacomp ",
               "       AND ooefent = ",g_enterprise,
               "       AND ooefstus = 'Y' ",
               "       AND glaa014 = 'Y' ",
               "       AND EXISTS(SELECT 1 FROM stfa_t ",
               "                   WHERE stfaent = ooefent AND stfasite = ooef001 ",
               "                     AND ",l_org_where,   #篩選輸入的營運組織
               "                     AND ",lc_param.wc,   #篩選輸入的專櫃&供應商
               "                     AND ",l_where,")"    #篩選aooi500設定的組織
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_get_org_pre FROM l_sql
   DECLARE astp504_get_org_cur CURSOR FOR astp504_get_org_pre
  #DISPLAY "[astp504_get_org_cur] ",l_sql
   
   #寫入暫存檔
   LET l_sql = "INSERT INTO astp504_org(ooef001, ooef017,glaald, glaa003,acc_year ", 
               "                        ,acc_mon,pdate_s,pdate_e,c_date, acc_flag) ",
               "     VALUES(?,?,?,?,?,   ?,?,?,?,?) "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_ins_org_tmp FROM l_sql
   
   FOREACH astp504_get_org_cur INTO l_ooef001,l_ooef017,l_glaald,l_glaa003,
                                    l_acc_year,l_acc_mon,l_pdate_s,l_pdate_e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'astp504_get_org_cur'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF                                    
                                    
      LET l_cdate_1 = ''
     #LET l_cdate_2 = ''       
      
      LET l_cdate_1 = cl_get_para(g_enterprise,l_ooef001,"S-CIR-0001")   #取得門店日結關賬日
     #LET l_cdate_2 = cl_get_para(g_enterprise,l_ooef001,"S-MFG-0031")   #取得組織庫存關帳日
      
      IF cl_null(l_cdate_1) THEN
         LET l_cdate_1 = g_today
      END IF
      
     #IF cl_null(l_cdate_2) THEN
     #   LET l_cdate_2 = g_today
     #END IF      
      
     #IF l_pdate_e < l_cdate_1 OR l_pdate_e > l_cdate_2 THEN   #與庫存扣帳日無關
      IF l_pdate_e < l_cdate_1 THEN
         LET l_acc_flag = 'Y'
      ELSE
         LET l_acc_flag = 'N'
      END IF      
      
      #背景訊息提示##
      DISPLAY "Org: ",l_ooef001," ,Process Date: ",l_pdate_s," - ",l_pdate_e," acc_flag: ",l_acc_flag
      ##############
      
      #寫入暫存檔
      EXECUTE astp504_ins_org_tmp USING l_ooef001,l_ooef017,l_glaald,l_glaa003,
                                        l_acc_year,l_acc_mon,l_pdate_s,l_pdate_e,
                                        l_cdate_2,l_acc_flag
     #DISPLAY "[astp504_ins_org_tmp] CNT: ",SQLCA.sqlerrd[3]
      IF SQLCA.sqlcode THEN
         DISPLAY "[astp504_ins_org_tmp] ERROR: (",l_ooef001," , ",l_acc_year," , ",l_acc_mon,")",SQLCA.sqlerrd[2]
         LET l_err_cnt = l_err_cnt + 1
      END IF      
   END FOREACH
   
   #背景訊息提示##
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM astp504_org WHERE acc_flag = 'N'  
   DISPLAY "[astp504_org] PROCESS ROWS: ",l_cnt   
   ##############
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得批次處理的相關資料
# Memo...........:
# Usage..........: CALL astp504_get_data(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/05/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp504_get_data(ls_js)
   DEFINE ls_js            STRING
   DEFINE r_success        LIKE type_t.num5
   DEFINE lc_param         type_parameter
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE l_sql            STRING  
   DEFINE l_wc             STRING
   #160516-00014#42 170106 by lori add---(S)
   DEFINE l_stfaent        LIKE stfa_t.stfaent 
   DEFINE l_stfasite       LIKE stfa_t.stfasite
   DEFINE l_stfa005        LIKE stfa_t.stfa005 
   DEFINE l_stfa001        LIKE stfa_t.stfa001 
   DEFINE l_stfa057        LIKE stfa_t.stfa057
   DEFINE l_stfeseq        LIKE stfe_t.stfeseq 
   DEFINE l_stfe002        LIKE stfe_t.stfe002 
   DEFINE l_stfe006        LIKE stfe_t.stfe006 
   DEFINE l_stfe008        LIKE stfe_t.stfe008 
   DEFINE l_stfe009        LIKE stfe_t.stfe009  
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_stfe008_new    LIKE stfe_t.stfe008 
   DEFINE l_stfe009_new    LIKE stfe_t.stfe009  
   DEFINE l_mon_s          LIKE type_t.num5      #保底結算範圍換算:開始日期差異幾月
   DEFINE l_mon_e          LIKE type_t.num5      #保底結算範圍換算:截止日期差異幾月
   #160516-00014#42 170106 by lori add---(E)
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   
   #1.取得組織與會計期間 
   LET g_progress.msg = cl_getmsg('ast-00737',g_lang)   #160225-00040#21 160428 by lori add
   CALL cl_progress_no_window_ing(g_progress.msg)       #160225-00040#21 160428 by lori add
   
   IF NOT astp504_get_org_scope(ls_js) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #150805-00003#36 150915 by lori mark---(S)
   #
   #2.取得門店日結資料
   #LET l_wc = lc_param.wc
   #LET l_wc = cl_replace_str(l_wc,'stfa005','mhae001')        #專櫃
   #LET l_wc = cl_replace_str(l_wc,'stfa010','mhae006')        #供應商
   #
   #LET l_sql = "INSERT INTO astp504_debc( debcsite,   debc010,debc005, ",    
   #            "                          debc005_par,inaa135, ",
   #            "                          debc013,    debc016,debc020, ",   #150805-00003#41 150831 by lori debc018改取debc016 
   #            "                          debc002,    mhae006,counter_acc) ",
   #            "     SELECT debcsite,debc010,debc005, ",                    #門店編號,專櫃編號,庫區編號
   #            "            (CASE WHEN inaa135 = '1' THEN debc005 ",        #對應常規庫區 
   #            "                  ELSE inaa141 ",                           
   #            "              END), ",
   #            "            inaa135,debc013,debc016, ",                     #庫區類型,銷售數量,應收金額,   #150805-00003#41 150831 by lori debc018改取debc016 
   #            "            debc020,debc002,mhae006,'N' ",                  #實收金額,統計日期,供應商編號,專櫃是否已有庫區結轉         
   #            "       FROM debc_t,inaa_t,mhae_t ",    
   #            "      WHERE debcent = inaaent ",                                  
   #            "        AND debcsite = inaasite ",                                  
   #            "        AND debc005 = inaa001 ",
   #            "        AND debcent = mhaeent ",
   #            "        AND debcsite = mhaesite ",
   #            "        AND debc010 = mhae001 ",     
   #            "        AND debcent = ",g_enterprise  ,
   #            "        AND ",l_wc,                                                #過濾供應商/專櫃
   #            "        AND EXISTS(SELECT 1 FROM astp504_org ",                    
   #            "                    WHERE ooef001 = debcsite ",                    
   #            "                      AND debc002 BETWEEN pdate_s AND pdate_e ",   #日結檔統計日期介於會計週期期間
   #            "                      AND acc_flag = 'N') "                        #日結檔須在可結算的範圍                         
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_debc_ins FROM l_sql
   #EXECUTE astp504_debc_ins
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_debc_ins'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF 
   #DISPLAY "[astp504_debc_ins] SQL: ",l_sql
   #DISPLAY "[astp504_debc_ins] CNT: ",SQLCA.sqlerrd[3] 
   #
   ##2.1.更新專櫃目前的結算情況:是否有已結轉的庫區資料
   #LET l_sql = "UPDATE astp504_debc ",
   #            "   SET counter_acc = 'Y' ",
   #            " WHERE debc010 IN (SELECT stga004 FROM stga_t ",
   #            "                    WHERE stgaent = ",g_enterprise,
   #            "                      AND stga013 = '3' ",                                        #成本類型 
   #            "                      AND stga015 = 'Y' ",                                        #已結轉
   #            "                      AND EXISTS(SELECT 1 FROM astp504_org ",
   #            "                                  WHERE stgasite = ooef001 ",                     #營運組織
   #            "                                    AND stga001 BETWEEN pdate_s AND pdate_e ",    #統計日期 
   #            "                                    AND acc_flag = 'N')) "                        #日結檔須在可結算的範圍                 
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_debc_upd FROM l_sql
   #EXECUTE astp504_debc_upd
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_debc_upd'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF    
   #DISPLAY "[astp504_debc_upd] SQL: ",l_sql
   #DISPLAY "[astp504_debc_upd] CNT: ",SQLCA.sqlerrd[3]   
   #
   ##3.取得專櫃每日效益資料
   #LET l_wc = lc_param.wc
   #LET l_wc = cl_replace_str(l_wc,'stfa005','stgg003')        #專櫃
   #LET l_wc = cl_replace_str(l_wc,'stfa010','stgg004')        #供應商
   #
   #LET l_sql = "INSERT INTO astp504_stgg(stggsite,stgg001 ,stgg002 ,stgg002_par,inaa102 , ",
   #            "                         stgg003 ,stgg004 ,stgg005 ,stgg006    ,stgg007 , ",
   #            "                         stgg008 ,stgg009 ,counter_acc) ", 
   #            "SELECT stggsite,stgg001 ,stgg002 ,",                          #營運組織,促銷日期,庫區編號,
   #            "       (CASE WHEN inaa135 = '1' THEN stgg002 ",               #對應常規庫區 
   #            "             ELSE inaa141 ",                                  
   #            "         END), ",                                              
   #            "       inaa102,stgg003 ,stgg004 ,stgg005 ,stgg006 , ",        #庫區類型,專櫃編號,供應商編號,樓層編號,應收金額
   #            "       stgg007,stgg008  ,stgg009,'N'   ",                     #實收金額,實收毛利額,實收毛利率
   #            "  FROM stgg_t,inaa_t ",
   #            " WHERE stggent = inaaent ",
   #            "   AND stggsite = inaasite ",
   #            "   AND stgg002 = inaa001 ",
   #            "   AND stggent = ",g_enterprise,     
   #            "   AND ",l_wc,                                                #過濾供應商/專櫃
   #            "   AND EXISTS(SELECT 1 FROM astp504_org ",                    
   #            "               WHERE ooef001 = stggsite ",                    
   #            "                 AND stgg001 BETWEEN pdate_s AND pdate_e ",   #日結檔統計日期介於會計週期期間
   #            "                 AND acc_flag = 'N') "                        #日結檔須在可結算的範圍          
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_stgg_ins FROM l_sql
   #EXECUTE astp504_stgg_ins
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_stgg_ins'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF     
   #DISPLAY "[astp504_stgg_ins] SQL: ",l_sql  
   #DISPLAY "[astp504_stgg_ins] CNT: ",SQLCA.sqlerrd[3]
   #
   ##3.1.更新專櫃目前的結算情況:是否有已結轉的庫區資料
   #LET l_sql = "UPDATE astp504_stgg ",
   #            "   SET counter_acc = 'Y' ",
   #            " WHERE stgg003 IN (SELECT stga004 FROM stga_t ",
   #            "                    WHERE stgaent = ",g_enterprise,
   #            "                      AND stga013 = '3' ",                                        #成本類型 
   #            "                      AND stga015 = 'Y' ",                                        #已結轉
   #            "                      AND EXISTS(SELECT 1 FROM astp504_org ",
   #            "                                  WHERE stgasite = ooef001 ",                     #營運組織
   #            "                                    AND stga001 BETWEEN pdate_s AND pdate_e ",    #統計日期 
   #            "                                    AND acc_flag = 'N')) "                        #日結檔須在可結算的範圍  
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_stgg_upd FROM l_sql
   #EXECUTE astp504_stgg_upd
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_stgg_upd'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF    
   #DISPLAY "[astp504_stgg_upd] SQL: ",l_sql
   #DISPLAY "[astp504_stgg_upd] CNT: ",SQLCA.sqlerrd[3]
   #
   ##4.取得專櫃合約資訊:專櫃須符合步驟-1.的組織範圍, 且合同狀態須為合約已生效/合約已延期/合約已續約/合約清退中
   ##  取保底方案與明細資訊:保底日期須介於結算的會計週期
   #LET l_wc = lc_param.wc       #專櫃,供應商
   #
   #LET l_sql = "INSERT INTO astp504_contract(stfasite,stfa005,stfa001,stfa019,stfa020, ",         
   #            "                             stfeseq ,stfe002,stfe008,stfe009,stfe003, ",               
   #            "                             stfe004 ,stfe005,stfe006,stfe007,stfe012, ", 
   #            "                             stff005 ,stff006,stff007,stff008,stae006,",               
   #            "                             receivable_flag) ",           
   #            "   SELECT stfasite,stfa005,stfa001,stfa019,stfa020, ",        #營運組織,專櫃編號,合約編號,合約生效日期,合約失效期
   #            "          stfeseq ,stfe002,stfe008,stfe009,stfe003, ",        #項次,方案編號,保底方案開始日,保底方案結束日,費用編號
   #            "          stfe004 ,stfe005,stfe006,stfe007,stfe012, ",        #,保底方式,分量扣點方式,保底計算週期,月預扣標準,月預扣方式
   #            "          stff005 ,stff006,stff007,stff008, ",                #庫區編號,截止金額,起始金額,執行扣率
   #            "          (SELECT CASE stae006 ",                             #價款類別
   #            "                     WHEN '3' THEN '1' ",
   #            "                     WHEN ''  THEN '1' ",
   #            "                     ELSE stae006 ",
   #            "                  END ",
   #            "             FROM stae_t ",
   #            "            WHERE staeent = stfeent ",
   #            "              AND stae001 = stfe003 ",                  
   #            "              AND staestus = 'Y'), ",
   #            "          (SELECT stab010 ",                                  #應收FLAG
   #            "             FROM stab_t ",
   #            "            WHERE stabent = stfeent ",
   #            "              AND stab001 = stfe003 ",                        #費用編號
   #            "              AND stabstus = 'Y' ",
   #            "              AND stab008 = 'Y' ",
   #            "              AND stab009 = 'Y' ",
   #            "              AND EXISTS (SELECT 1 FROM stat_t ",
   #            "                           WHERE statent = stabent ",
   #            "                             AND stat001 = '4' ",             #經營方式=4.聯營
   #            "                             AND stat003 = stab001 ))",               
   #            "     FROM stff_t,stfe_t,stfa_t ",
   #            "    WHERE stffent = stfeent AND stff001 = stfe001 ",          #企業編號,專櫃合同編號
   #            "      AND stffseq = stfeseq AND stff002 = stfe002 ",          #項次,方案編號
   #            "      AND stfeent = stfaent AND stfe001 = stfa001 ",          #企業編號,專櫃合同編號
   #            "      AND stffent = ",g_enterprise,
   #            "      AND stfa004 IN ('3','4','5','6') ",                     #合約狀態
   #            "      AND ",l_wc,                                             #過濾供應商/專櫃
   #            "      AND EXISTS(SELECT 1 FROM astp504_org ",                 #保底日期介於結算的會計週期
   #            "                  WHERE ooef001 = stfasite ",
   #            "                    AND (stfe008 BETWEEN pdate_s AND pdate_e ",
   #            "                      OR stfe009 BETWEEN pdate_s AND pdate_e) ",
   #            "                    AND acc_flag = 'N') "                     #日結檔須在可結算的範圍 
   #CASE g_prog 
   #   WHEN 'astp504'
   #      LET l_sql = l_sql," AND stfe006 <> '1' ",                            #保底計算週期<>1.月
   #                       #" AND stfe007 > 0 ",                               #月預扣標準
   #                        " AND stfe012 <> '1' "                             #月預扣方式<>1.無月預扣
   #                                                  
   #   WHEN 'astp505'
   #      LET l_sql = l_sql," AND stfe004 <> '1' "                             #保底方式<>1.無保底 
   #END CASE
   #
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_contract_ins FROM l_sql
   #EXECUTE astp504_contract_ins
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_contract_ins'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF   
   ##DISPLAY "[astp504_contract_ins] SQL: ",l_sql  
   #DISPLAY "[astp504_contract_ins] CNT: ",SQLCA.sqlerrd[3]
   #
   #LET l_sql = "UPDATE astp504_contract ",
   #            "   SET receivable_flag = 'N' ",
   #            " WHERE receivable_flag IS NULL "
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_contract_upd FROM l_sql
   #EXECUTE astp504_contract_upd
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_contract_upd'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF   
   ##DISPLAY "[astp504_contract_upd] SQL: ",l_sql  
   #DISPLAY "[astp504_contract_upd] CNT: ",SQLCA.sqlerrd[3]
   #
   ##5.取得促銷談判資訊:依步驟-2.的庫區找到對應的促銷庫區,且有符合的促銷資訊
   ##  過濾條件:(1)促銷談判否=Y
   ##          (2)促銷開始-結束日期符合步驟-2.1.結算日期區間   
   #LET l_sql = "INSERT INTO astp504_promotions(stfa001,prei003,prei003_par,preh003,preh004) ",
   #            "     SELECT stfa001,prei003,inaa141,preh003,preh004 ",     #專櫃合約編號,庫區編號,對應常規庫區,開始日期,結束日期 
   #            "       FROM prei_t,preh_t,inaa_t,astp504_contract ",
   #            "      WHERE preient = prehent ",
   #            "        AND prei001 = preh001 ",                           #促銷編號 
   #            "        AND preient = inaaent ",
   #            "        AND preisite = inaasite ",
   #            "        AND prei003 = inaa001 ",
   #            "        AND inaasite = stfasite ",
   #            "        AND inaa141 = stff005 ",                           #所屬常規庫區
   #            "        AND prei059 = 'Y' ",                               #參與保底方案  
   #            "        AND prei081 = '1' ",                               #促銷談判狀態=1.已發布   
   #            "        AND inaa135 = '2' ",                               #庫區用途 = 2.促銷庫區 
   #            "        AND (preh003 BETWEEN stfe008 AND stfe009 ",
   #            "          OR preh004 BETWEEN stfe008 AND stfe009) ",
   #            "        AND EXISTS(SELECT 1 FROM preg_t ", 
   #            "                    WHERE pregent = prehent ", 
   #            "                      AND preg001 = preg001 ",            #促銷類型=1.主題促銷   #150805-00003#23 150908 by lori add
   #            "                      AND preg051 = '1' ",
   #            "                      AND pregstus IN ('Y','F')) ",     
   #            "        AND EXISTS(SELECT 1 FROM astp504_org ",            #促銷日期介於結算的會計週期
   #            "                    WHERE ooef001 = prehsite ",
   #            "                      AND (preh003 BETWEEN pdate_s AND pdate_e ",
   #            "                        OR preh004 BETWEEN pdate_s AND pdate_e) ",
   #            "                      AND acc_flag = 'N') "                #日結檔須在可結算的範圍               
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_promotions_ins FROM l_sql
   #EXECUTE astp504_promotions_ins
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_promotions_ins'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF     
   ##DISPLAY "[astp504_promotions_ins] SQL: ",l_sql
   #DISPLAY "[astp504_promotions_ins] CNT: ",SQLCA.sqlerrd[3]
   #
   #150805-00003#36 150915 by lori mark---(E)

   #160302-00016#1 160302 by lori add---(S)
   #找出專櫃對應的合同
   LET g_progress.msg = cl_getmsg('ast-00738',g_lang)   #160225-00040#21 160428 by lori add
   CALL cl_progress_no_window_ing(g_progress.msg)       #160225-00040#21 160428 by lori add
   
   #160516-00014#42 170106 by lori mod---(S)
   ##1.找出符合結算日期範圍的專櫃合同
   ##2.當期沒有合同的專櫃, 找出去年同期的合同, 再查無則再往前推一年, 以此推三年
   #LET l_sql =#"INSERT INTO astp504_contract(stfaent, stfasite,     stfa005,      stfa001,      stfa010, ",   #160727-00019#19 16/08/15 By 08734 mark
   #            "INSERT INTO astp504_tmp01(stfaent, stfasite,     stfa005,      stfa001,      stfa010, ",      #160727-00019#19 16/08/15 By 08734    7
   #            "                          stfeseq, stfe002,      stfe003,      stfe004,      stfe005, ",
   #            "                          stfe006, stfe007,      stfe008,      stfe008_year, stfe008_date, ",
   #            "                          stfe009, stfe009_year, stfe009_date, stfe012) ",
   #            "     SELECT stfaent, stfasite,     stfa005,      stfa001,      stfa010, ",
   #            "            stfeseq, stfe002,      stfe003,      stfe004,      stfe005, ",
   #            "            stfe006, stfe007,      stfe008,      stfe008_year, stfe008_date, ",
   #            "            stfe009, stfe009_year, stfe009_date, stfe012 ",
   #            "       FROM mhae_t t1, ",
   #            "            (SELECT stfaent, stfasite, stfa005, stfa001, stfa010,             ",
   #            "                    stfeseq, stfe002,  stfe003, stfe004, stfe005,             ",
   #            "                    stfe006, stfe007,  stfe008,                               ",
   #            "                    TO_NUMBER(TO_CHAR(stfe008, 'YYYY')) stfe008_year,         ",   
   #            "                    TO_DATE(TO_CHAR(stfe008, 'MM/DD'), 'MM/DD') stfe008_date, ",   
   #            "                    stfe009,                                                  ",    
   #            "                    TO_NUMBER(TO_CHAR(stfe009, 'YYYY')) stfe009_year,         ",   
   #            "                    TO_DATE(TO_CHAR(stfe009, 'MM/DD'), 'MM/DD') stfe009_date, ",   
   #            "                    stfe012                                                   ",
   #            "               FROM stfe_t, stfa_t                                            ",
   #            "              WHERE stfeent = stfaent                                         ",
   #            "                AND stfe001 = stfa001                                         ",
   #            "                AND stfa004 IN ('3', '4', '5', '6')) t2                       ",
   #            "      WHERE t1.mhaeent = ",g_enterprise,
   #            "        AND t1.mhaeent = t2.stfaent   ", 
   #            "        AND t1.mhaesite = t2.stfasite ",
   #            "        AND t1.mhae001 = t2.stfa001   ",
   #            "        AND EXISTS(SELECT 1 FROM astp504_org    ",   #過濾組織   
   #            "                    WHERE t2.stfasite = ooef001 ",  
   #           #160901-00054#1 160901 by lori mark---(S)                 
   #           #"                      AND (t2.stfe008_year BETWEEN acc_year-3 AND acc_year  ",   #保底日期介於結算的會計週期往前推的三年
   #           #"                        OR t2.stfe009_year BETWEEN acc_year-3 AND acc_year) ",
   #           #"                      AND (t2.stfe008_date BETWEEN TO_DATE(TO_CHAR(pdate_s, 'MM/DD'), 'MM/DD') AND TO_DATE(TO_CHAR(pdate_e, 'MM/DD'), 'MM/DD') ",
   #           #"                        OR t2.stfe009_date BETWEEN TO_DATE(TO_CHAR(pdate_s, 'MM/DD'), 'MM/DD') AND TO_DATE(TO_CHAR(pdate_e, 'MM/DD'), 'MM/DD')) ",                     
   #           #160901-00054#1 160901 by lori mark---(E) 
   #           #160901-00054#1 160901 by lori add---(S)
   #            "                      AND (stfe008 BETWEEN REPLACE(TO_CHAR(pdate_s,'YYYY/MM/DD'),acc_year,acc_year-3) AND pdate_e ",
   #            "                        OR stfe009 BETWEEN REPLACE(TO_CHAR(pdate_s,'YYYY/MM/DD'),acc_year,acc_year-3) AND pdate_e) ",              
   #           #160901-00054#1 160901 by lori add---(E) 
   #            "                      AND acc_flag = 'N') "
   
   #取可用合同的方式：保底結束日期在結算日期範圍內的最新一份合同
   #新增欄位：rtfa057(終止保底計算)
   #取消stfe008_year,stfe008_date,stfe009_year,stfe009_date   
   LET l_sql = "INSERT INTO astp504_tmp01(stfaent, stfasite, stfa005, stfa001, stfa010, ", 
               "                          stfa057,                                      ",   
               "                          stfeseq, stfe002,  stfe003, stfe004, stfe005, ",
               "                          stfe006, stfe007,  stfe008, stfe009, stfe012) ",
               "SELECT stfaent, stfasite, stfa005, stfa001,      stfa010, ",
               "       stfa057,                                           ",
               "       stfeseq, stfe002,  stfe003, stfe004, stfe005, ",
               "       stfe006, stfe007,  stfe008, stfe009, stfe012  ",
               "  FROM mhae_t, ",
               "       (SELECT stfaent, stfasite, stfa005, stfa001, stfa010, ",
               "               stfa057,                                      ",
               "               stfeseq, stfe002,  stfe003, stfe004, stfe005, ",
               "               stfe006, stfe007,  stfe008, stfe009, stfe012  ",       
               "          FROM stfe_t t1, stfa_t t2 ",
               "         WHERE t1.stfeent = t2.stfaent ",
               "           AND t1.stfe001 = t2.stfa001 ",
               "           AND t2.stfa004 IN ('3', '4', '5', '6') ",
               "           AND EXISTS (SELECT 1 ",
               "                         FROM (SELECT t4.stfaent,t4.stfasite,t4.stfa005,MAX(t3.stfe009) stfe009 ",   #取結算結束日期以前,保底結束日期最大的保底方案
               "                                 FROM stfe_t t3,stfa_t t4",
               "                                WHERE t3.stfeent = t4.stfaent AND t3.stfe001 = t4.stfa001 ",
               "                                  AND t4.stfa004 IN ('3', '4', '5', '6')",
               "                                  AND EXISTS (SELECT 1 FROM astp504_org ",     #過濾組織   
               "                                               WHERE t4.stfasite = ooef001 ",
               "                                                 AND t3.stfe009 <= pdate_e ",
               "                                                 AND acc_flag = 'N') ",
               "                                GROUP BY t4.stfaent,t4.stfasite,t4.stfa005) s1 ",
               "                       WHERE t2.stfaent = s1.stfaent AND t2.stfasite = s1.stfasite ",
               "                         AND t2.stfa005 = s1.stfa005 AND t1.stfe009 = s1.stfe009) ",
               "        ) ",
               " WHERE mhaeent  = ",g_enterprise,
               "   AND mhaeent  = stfaent   ", 
               "   AND mhaesite = stfasite ",
               "   AND mhae001  = stfa001   "
   #160516-00014#42 170106 by lori mod---(E)
   
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_contract_ins FROM l_sql    
   EXECUTE astp504_contract_ins   
   DISPLAY "[astp504_contract_ins] CNT:",SQLCA.sqlerrd[3]
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Error:astp504_contract_ins'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET l_err_cnt = l_err_cnt + 1
   END IF 
   
   #160516-00014#42 170106 by lori mark---(S)
   ##保留最新一份合同,舊的刪除
   #LET l_sql =#"DELETE FROM astp504_contract ",   #160727-00019#19 16/08/15 By 08734 mark
   #            "DELETE FROM astp504_tmp01 ",      #160727-00019#19 16/08/15 By 08734 add 
   #            " WHERE (stfaent,stfasite,stfa005,stfe009) NOT IN (SELECT stfaent,stfasite,stfa005,stfe009 ",
   #           #"                                                    FROM astp504_contract ",   #160727-00019#19 16/08/15 By 08734 mark
   #            "                                                    FROM astp504_tmp01 ",      #160727-00019#19 16/08/15 By 08734 add
   #           #"                                                   WHERE stfe009_year IN (SELECT MAX(stfe009_year) FROM astp504_contract ",   #160727-00019#19 16/08/15 By 08734 mark
   #            "                                                   WHERE stfe009_year IN (SELECT MAX(stfe009_year) FROM astp504_tmp01",       #160727-00019#19 16/08/15 By 08734 add
   #            "                                                                          GROUP BY stfaent,stfasite,stfa005))"
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_contract_del FROM l_sql   
   #EXECUTE astp504_contract_del   
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_contract_del'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF    
   ##160302-00016#1 160302 by lori add---(E)
   #160516-00014#42 170106 by lori mark---(E)
   
   #160516-00014#42 170106 by lori add---(S)
   #檢查在結算截止日期範圍前最新的合同
   #1.終止保底計算 = Y 結算日期範圍內若無保底設定，就不進行結算
   #2.終止保底計算 = N 結算日期範圍內取最接近結算日期的保底設定作為結算依據
   #3.取得合同後,將專櫃的其他日期合同刪除   
   LET l_sql = "SELECT stfaent, stfasite, stfa005, stfa001, stfa057, ",
               "       stfeseq, stfe002, stfe006,  stfe008, stfe009, ",
               "       pdate_s, pdate_e ",
               "  FROM astp504_tmp01 t1,astp504_org t2 ",
               " WHERE t1.stfasite = t2.ooef001 ",               
               "   AND EXISTS(SELECT 1 FROM  (SELECT stfaent, stfasite, stfa005,stfe002,MAX(stfe009) stfe009",
               "                                FROM astp504_tmp01 ",
               "                               GROUP BY stfaent, stfasite, stfa005, stfe002) s1 ",               
               "               WHERE t1.stfaent = s1.stfaent AND t1.stfasite = s1.stfasite ",
               "                 AND t1.stfa005 = s1.stfa005 AND t1.stfe002 = s1.stfe002 ",
               "                 AND t1.stfe009 = s1.stfe009) ",
               " ORDER BY stfaent, stfasite, stfa005, stfe002 "
   LET l_sql = cl_sql_add_mask(l_sql)               
   PREPARE astp504_contract_pre FROM l_sql
   DECLARE astp504_contract_cur CURSOR FOR astp504_contract_pre

   LET l_sql = "DELETE FROM astp504_tmp01 ",
               " WHERE stfaent = ? AND stfa001 = ? AND stfa005 = ? ",
               "   AND stfeseq = ? AND stfe002 = ? "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_del_contract FROM l_sql          
   
   LET l_stfaent   = '' 
   LET l_stfasite  = ''
   LET l_stfa005   = ''
   LET l_stfa057   = ''
   LET l_stfa001   = ''
   LET l_stfeseq   = ''
   LET l_stfe002   = ''
   LET l_stfe006   = ''
   LET l_stfe008   = ''
   LET l_stfe009   = ''
   LET l_pdate_s   = ''
   LET l_pdate_e   = ''
   
   FOREACH astp504_contract_cur INTO l_stfaent, l_stfasite, l_stfa005, l_stfa001, l_stfa057, 
                                     l_stfeseq, l_stfe002, l_stfe006,  l_stfe008, l_stfe009, 
                                     l_pdate_s, l_pdate_e   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Error:astp504_contract_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET l_err_cnt = l_err_cnt + 1
      END IF              
      
      IF l_stfe009 < l_pdate_s THEN              #取得的合同,保底截止日期小於結算起始日期
         IF l_stfa057 = 'Y' OR 
           (l_stfa057 = 'N' AND l_stfe009_new < l_pdate_s) THEN
            DELETE FROM astp504_tmp01 
             WHERE stfaent = l_stfaent AND stfa005 = l_stfa005
         END IF 
         
         IF l_stfa057 = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ast-00864"       #專櫃已終止保底計算，故不結算！
            LET g_errparam.replace[1] = l_stfa005
            LET g_errparam.replace[2] = l_stfa001
            LET g_errparam.popup = TRUE
            CALL cl_err() 

            EXECUTE astp504_del_contract USING l_stfaent,l_stfa001,l_stfa005,l_stfeseq,l_stfe002
         ELSE
            #推算最新保底結算起始日期   
            LET l_mon_s = ''
            LET l_mon_s = (MONTH(l_pdate_s) - MONTH(l_stfe008)) + ((YEAR(l_pdate_s) - YEAR(l_stfe008)) *12)
            
            #推算最新保底結算結束日期 
            LET l_mon_e = ''
            LET l_mon_e = (MONTH(l_pdate_s) - MONTH(l_stfe009)) + ((YEAR(l_pdate_s) - YEAR(l_stfe009)) *12)
            
            LET l_stfe008_new = ''
            LET l_stfe009_new = ''
            
            CASE l_stfe006
               WHEN '1'   #月
                  SELECT ADD_MONTHS(l_stfe008,l_mon_s) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,l_mon_e) INTO l_stfe009_new FROM DUAL
               WHEN '2'   #季
                  SELECT ADD_MONTHS(l_stfe008,CEIL(l_mon_s/4)*4) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,CEIL(l_mon_e/4)*4) INTO l_stfe009_new FROM DUAL
               WHEN '3'   #半年
                  SELECT ADD_MONTHS(l_stfe008,CEIL(l_mon_s/6)*6) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,CEIL(l_mon_e/6)*6) INTO l_stfe009_new FROM DUAL               
               WHEN '4'   #年
                  SELECT ADD_MONTHS(l_stfe008,CEIL(l_mon_s/12)*12) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,CEIL(l_mon_e/12)*12) INTO l_stfe009_new FROM DUAL               
            END CASE

            IF l_stfe009_new > l_pdate_e THEN   
               #最新保底結算範圍>結算截止日期,毋須結算
               EXECUTE astp504_del_contract USING l_stfaent,l_stfa005,l_stfa001,l_stfe002
            ELSE   
               #最新保底結算範圍<=結算截止日期,更新保底範圍
               UPDATE astp504_tmp01 
                  SET stfe008 = l_stfe008_new,
                      stfe009 = l_stfe009_new
                 WHERE stfaent = l_stfaent AND stfa001 = l_stfa001 AND stfa005 = l_stfa005 
                   AND stfeseq = l_stfeseq AND stfe002 = l_stfe002 
                IF SQLCA.sqlcode THEN   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Update astp504_tmp01:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF                  
            END IF
         END IF          
      END IF
      
      LET l_stfaent  = '' 
      LET l_stfasite = ''
      LET l_stfa005  = ''
      LET l_stfa001  = ''
      LET l_stfa057  = ''
      LET l_stfeseq  = ''
      LET l_stfe002  = ''
      LET l_stfe006  = ''
      LET l_stfe008  = ''
      LET l_stfe009  = ''
      LET l_pdate_s  = ''
      LET l_pdate_e  = ''     
   END FOREACH
   #160516-00014#42 170106 by lori mod---(S)
   
   LET g_progress.msg = cl_getmsg('ast-00739',g_lang)   #160225-00040#21 160428 by lori add
   CALL cl_progress_no_window_ing(g_progress.msg)       #160225-00040#21 160428 by lori add
   
   #150805-00003#36 150915 by lori add---(S)
   #SQL-針對處理的組織範圍下的庫區按會計期展出每一天, 及每天對應的保底方案和促銷規則
   #(1) inaa_t -> ooef_t = 找出inaasite的組織基本資料
   #(2) ooef_t -> glaa_t = 找出組織主帳套,會計期參照表
   #(3) glaa_t -> glav_t = 按會計期參照表展開會計期的每一天
   #(4) inaa_t -> stff_t = 找出對應常規庫區有設置在保底方案明細者,及保底金額
   #(5) stff_t -> stfe_t = 找出保底方式,月預扣方式,月平均的月預扣標準
   #(6) stfe_t -> stfa_t = 找出專櫃合同中對應的供應商
   #(7) inaa_t -> stfc_t = 找出存在於專櫃合同中的庫區
   #[注意] INSERT INTO 與SELECT 位置要對應
   ##160302-00016#1 160302 by lori 調整:
   #原(6) stfe_t -> stfa_t 改用 astp504_contract, 
   #astp504_contract 以專櫃取得本次結算範圍內的合同,若當年度沒有則取前一年度,以此類推取至前三年   
   
   LET l_wc = lc_param.wc       #專櫃,供應商
   LET l_wc = cl_replace_str(l_wc,'stfa005','inaa120')        #專櫃
   
   IF cl_null(l_wc) THEN
      LET l_wc = " 1=1 "
   END IF
   
   LET l_sql = "INSERT INTO astp504_acc_tmp( inaasite       ,inaa001,inaa120,inaa135,inaa141, ", 
               "                             acc_date       ,                                 ",
               "                             stff001        ,stff006,stff007,stff008,         ",
               "                             stfeseq        ,stfe002,stfe003,stfe004,stfe005, ",
               "                             stfe006        ,stfe007,stfe008,stfe009,stfe012, ",
               "                             stfa010        ,stfa057,                         ",   #160516-00014#42 170106 by lori add:stfa057
               "                             stae006        ,                                 ",
               "                             receivable_flag,                                 ",
               "                             preg051        ,prei001,prei059,                 ",
               "                             debc013        ,debc016,debc020,                 ",
               "                             stgg007        ,stgg008,stgg009)                 ",  
               " SELECT inaasite,inaa001,inaa120,inaa135,inaa141, ",              #營運據點,庫區編號,專櫃編號,庫區用途分類,對應常規庫區
               "        glav004,                                  ",              #日期
               "        stff001,stff006,stff007,stff008,          ",              #專櫃合同編號,截止金額,起始金額,執行扣率
               "        stfeseq,stfe002,stfe003,stfe004,stfe005,  ",              #保底項次,保底方案編號,費用編號,保底方式,分量扣點方式
               "        stfe006,stfe007,stfe008,stfe009,stfe012,  ",              #保底計算週期,月預扣標準,保底開始日期,保底截止日期,月預扣方式
               "        stfa010,stfa057,                          ",              #供應商編號,終止保底計算   #160516-00014#42 170106 by lori add:stfa057
               "        (SELECT CASE stae006                      ",              #價款類別
               "                    WHEN '3' THEN '1'             ",              
               "                    WHEN '' THEN '1'              ",              
               "                    ELSE stae006 END              ",              
               "           FROM stae_t                            ",              
               "          WHERE staeent = stfaent                 ",              #160302-00016#1 160302 by lori mod stfeent->stfaent             
               "            AND stae001 = stfe003                 ",              
               "            AND staestus = 'Y') stae006,          ",              
               "        COALESCE((SELECT stab010                  ",              #應收FLAG
               "                    FROM stab_t                   ",              
               "                   WHERE stabent = stfaent        ",              #160302-00016#1 160302 by lori mod stfeent->stfaent   
               "                     AND stab001 = stfe003        ",              #費用編號
               "                     AND stabstus = 'Y'           ",               
               "                     AND stab008 = 'Y'            ",               
               "                     AND stab009 = 'Y'            ",               
               "                     AND EXISTS(SELECT 1          ",               
               "                                  FROM stat_t     ",               
               "                                 WHERE statent = stabent    ",     
               "                                   AND stat001 = '4'        ",    #經營方式=4.聯營
               "                                   AND stat003 = stab001)), ",    
               "                 'N') stab010,                     ",             
               "       preg051,prei001,prei059,                    ",             #促銷類型,促銷規則編號,促銷參與保底否
               "       debc013,debc016,debc020,                    ",             #銷售數量,原價金額,實收金額
               "       stgg007,stgg008,stgg009                     ",             #應收金額,實收金額,實收毛利額
               "  FROM (SELECT inaaent,inaasite,inaa001,inaa120,inaa135, ",
               "               inaa141,glav004                           ",
               "          FROM inaa_t, ooef_t, glaa_t, glav_t            ",
               "         WHERE inaaent = ooefent AND inaasite = ooef001  ",
               "           AND ooefent = glaaent AND ooef017  = glaacomp ",
               "           AND glaaent = glavent AND glaa003  = glav001  ",
               "           AND inaaent = ",g_enterprise,
               "           AND inaastus = 'Y'    ", 
               "           AND ooefstus = 'Y'    ", 
               "           AND glaa014  = 'Y')   ",            #主帳套
               "        LEFT JOIN (SELECT preient,preisite,prei001,prei003,prei059,     ",
               "                          prei081,preh003,preh004,preg051               ",
               "                     FROM prei_t, preh_t ,preg_t                        ",
               "                    WHERE preient = prehent AND prei001 = preh001       ",
               "                      AND preient =pregent  AND prei001 = preg001       ",
               "                      AND prei081 = '1')                                ",   #促銷談判狀態=1.已發佈
               "               ON preient = inaaent AND preisite = inaasite             ",
               "              AND prei003 = inaa001                                     ",
               "              AND glav004 BETWEEN preh003 AND preh004                   ",   #日期介於促銷活動期間內
               "        LEFT JOIN (SELECT debcent,debcsite,debc002,debc005,debc010,     ",
               "                          COALESCE(SUM(COALESCE(debc013,0)),0) debc013, ",
               "                          COALESCE(SUM(COALESCE(debc016,0)),0) debc016, ",
               "                          COALESCE(SUM(COALESCE(debc020,0)),0) debc020  ",
               "                     FROM debc_t                                        ",
               "                    GROUP BY debcent,debcsite,debc002,debc005,debc010)  ",
               "               ON debcent = inaaent  AND debcsite = inaasite            ",
               "              AND debc002 = glav004  AND debc005 = inaa001              ",
               "              AND debc010 = inaa120                                     ", 
               "        LEFT JOIN (SELECT stggent,stggsite,stgg001,stgg002,stgg003,     ",
               "                          COALESCE(SUM(COALESCE(stgg007,0)),0) stgg007, ",
               "                          COALESCE(SUM(COALESCE(stgg008,0)),0) stgg008, ",
               "                          COALESCE(SUM(COALESCE(stgg009,0)),0) stgg009  ",
               "                     FROM stgg_t                                        ",    
               "                    GROUP BY stggent,stggsite,stgg001,stgg002,stgg003)  ",
               "               ON stggent = inaaent AND stggsite = inaasite             ",
               "              AND stgg001 = glav004 AND stgg002 = inaa001               ",
               "              AND stgg003 = inaa120,               ",
              #"        stff_t, stfe_t, stfa_t                     ",          #160302-00016#1 160302 by lori mark
              #"        stff_t, astp504_contract                   ",          #160302-00016#1 160302 by lori add   #160727-00019#19 16/08/15 By 08734 mark
               "        stff_t, astp504_tmp01                      ",          #160727-00019#19 16/08/15 By 08734 add
               " WHERE inaaent = stffent AND inaasite = stffsite AND inaa141 = stff005 ",                        
              #"   AND stffent = stfeent AND stff001  = stfe001 AND stff003 = stfeseq AND stff002 = stfe002 ",   #160302-00016#1 160302 by lori mark
              #"   AND stfeent = stfaent AND stfe001  = stfa001    ",                                            #160302-00016#1 160302 by lori mark
               "   AND glav004 BETWEEN stfe008 AND stfe009 ",                                                    #160302-00016#1 160302 by lori mark  #160407-00022#1 160407 by lori remark
               "   AND stffent = stfaent AND stff001  = stfa001 AND stff003 = stfeseq AND stff002 = stfe002 ",   #160302-00016#1 160302 by lori add             
              #"   AND TO_DATE(TO_CHAR(glav004,'MM/DD'),'MM/DD') BETWEEN stfe008_date AND stfe009_date ",        #160302-00016#1 160302 by lori add   #160407-00022#1 160407 by lori mark
              #"   AND stfa004 IN ('3', '4', '5', '6')  ",      #專櫃合同狀態   #160302-00016#1 160302 by lori mark
               "   AND stfe004 <> '1'  "                        #保底方式<>1.無保底   
               
               
   #IF g_prog = 'astp504' THEN        #160705-00042#10 160713 by sakura mark                              
   IF g_prog MATCHES 'astp504' THEN   #160705-00042#10 160713 by sakura add
      LET l_sql = l_sql,                                     
               "  AND stfe006 <> '1'  ",                        #保底計算週期<>1.月
               "  AND stfe012 <> '1'  "                         #月預扣方式<>1.無月預扣
   END IF 
   
   LET l_sql = l_sql,                                        
               "  AND EXISTS(SELECT 1 ",                        #庫區需存在於專櫃合同中
               "            FROM stfc_t               ", 
               "           WHERE stfcent = inaaent    ",
               "             AND stfcsite = inaasite  ",
               "             AND stfc002 = inaa001    ",
               "             AND stfcent = stfaent    ",
               "             AND stfc001 = stfa001)   ",
               "  AND ",l_wc,                                                  #過濾供應商/專櫃
               "  AND EXISTS(SELECT 1 FROM astp504_org ",                      #過濾組織 
               "              WHERE ooef001 = inaasite ",           
              #"                AND (stfe008 BETWEEN pdate_s AND pdate_e ",    #保底日期介於結算的會計週期   #160302-00016#1 160302 by lori mark
              #"                  OR stfe009 BETWEEN pdate_s AND pdate_e) ",                               #160302-00016#1 160302 by lori mark
               "                AND acc_flag = 'N') "                          #日結檔須在可結算的範圍 
               
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_ins FROM l_sql
   EXECUTE astp504_acc_tmp_ins
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Error:astp504_acc_tmp_ins'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET l_err_cnt = l_err_cnt + 1
   END IF     
  #DISPLAY "[astp504_acc_tmp_ins] SQL: ",l_sql
   DISPLAY "[astp504_acc_tmp_ins] CNT: ",SQLCA.sqlerrd[3]

   #150805-00003#36 150921 by lori mark---(S)
   #SQL-取得每日銷售資料
   #LET l_sql = "UPDATE astp504_acc_tmp                                                       ",
   #            "   SET                                                                       ",
   #            "       debc013 = ((SELECT COALESCE(SUM(COALESCE(debc013,0)),0)               ",   #銷售數量
   #            "                     FROM debc_t                                             ",
   #            "                    WHERE debcent = ",g_enterprise," AND debcsite = inaasite ",
   #            "                      AND debc002 = acc_date         AND debc005 = inaa001   ",
   #            "                      AND debc010 = inaa120 )),                              ",
   #            "       debc016 = ((SELECT COALESCE(SUM(COALESCE(debc016,0)),0)               ",   #原價金額
   #            "                     FROM debc_t                                             ",
   #            "                    WHERE debcent = ",g_enterprise," AND debcsite = inaasite ",
   #            "                      AND debc002 = acc_date         AND debc005 = inaa001   ",
   #            "                      AND debc010 = inaa120 )),                              ",
   #            "       debc020 = ((SELECT COALESCE(SUM(COALESCE(debc020,0)),0)               ",   #實收金額
   #            "                     FROM debc_t                                             ",
   #            "                    WHERE debcent = ",g_enterprise," AND debcsite = inaasite ",
   #            "                      AND debc002 = acc_date         AND debc005 = inaa001   ",
   #            "                      AND debc010 = inaa120 )),                              ",
   #            "       stgg007 = ((SELECT COALESCE(SUM(COALESCE(stgg007,0)),0)               ",   #應收金額
   #            "                     FROM stgg_t                                             ",
   #            "                    WHERE stggent = ",g_enterprise," AND stggsite = inaasite ",
   #            "                      AND stgg001 = acc_date         AND stgg002 = inaa001   ",
   #            "                      AND stgg003 = inaa120 )),                              ",
   #            "       stgg008 = ((SELECT COALESCE(SUM(COALESCE(stgg008,0)),0)               ",   #實收金額
   #            "                     FROM stgg_t                                             ",
   #            "                    WHERE stggent = ",g_enterprise," AND stggsite = inaasite ",
   #            "                      AND stgg001 = acc_date         AND stgg002 = inaa001   ",
   #            "                      AND stgg003 = inaa120 )),                              ",
   #            "       stgg009 = ((SELECT COALESCE(SUM(COALESCE(stgg009,0)),0)               ",   #實收毛利額
   #            "                     FROM stgg_t                                             ",
   #            "                    WHERE stggent = ",g_enterprise," AND stggsite = inaasite ",
   #            "                      AND stgg001 = acc_date         AND stgg002 = inaa001   ",
   #            "                      AND stgg003 = inaa120 )),                              ",
   #            "       stgg010 = ((SELECT COALESCE(SUM(COALESCE(stgg010,0)),0)               ",   #實收毛利率   
   #            "                     FROM stgg_t                                             ",
   #            "                    WHERE stggent = ",g_enterprise," AND stggsite = inaasite ",
   #            "                      AND stgg001 = acc_date         AND stgg002 = inaa001   ",
   #            "                      AND stgg003 = inaa120 ))                               "
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_acc_tmp_upd FROM l_sql
   #EXECUTE astp504_acc_tmp_upd
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'Error:astp504_acc_tmp_upd'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET l_err_cnt = l_err_cnt + 1
   #END IF     
   #DISPLAY "[astp504_acc_tmp_upd] SQL: ",l_sql
   #DISPLAY "[astp504_acc_tmp_upd] CNT: ",SQLCA.sqlerrd[3] 
   #150805-00003#36 150921 by lori mark---(E)
   
   #月預扣/保底計算資料
   #(1)取要結算的庫區資料
   #150805-00003#36 150922 by lori mark---(S)
   #CASE g_prog
   #   WHEN 'astp504'   
   #      LET l_sql = "SELECT UNIQUE inaasite,inaa120,inaa141,stff001,stfe003,  ",   #營運據點,專櫃編號,對應常規庫區,專櫃合同編號,費用編號
   #                  "              stae006, stfa010,pdate_s,pdate_e  ",            #價款類別,供應商編號,會計日期起,會計日期迄
   #                  "  FROM astp504_acc_tmp,astp504_org ",
   #                  " WHERE ooef001 = inaasite          ",
   #                  "   AND prei001 IS NULL             ",    #促銷編號為空=不參與促銷
   #                  "   AND acc_flag = 'N'              "
   #   WHEN 'astp505'
   #  
   #      LET l_sql = "SELECT inaasite,inaa120,inaa141,        stff001,stfa010, ",   #營運據點,專櫃編號,對應常規庫區,專櫃合同編號,供應商編號
   #                  "       stae006, stff008,receivable_flag,pdate_s,pdate_e, ",   #價款類別,會計日期起,會計日期迄,執行扣率,應收FLAG
   #                  "       stfeseq,stfe002,stfe003,         stfe004,stfe006, ",   #保底項次,保底方案編號,費用編號,保底方式,保底計算週期
   #                  "       stfe008,stfe009,stfe012,                          ",   #保底開始日期,保底截止日期,月預扣方式
   #                  "       (CASE WHEN stfe012 = '2' THEN stfe007             ",   #月預扣方式=2.月平均,則取月預扣標準   
   #                  "             WHEN stfe012 = '3' THEN stff006             ",   #月預扣方式=3.月累計,則取截止金額    
   #                  "        END) stfe007                                     ",   
   #                  "  FROM astp504_acc_tmp,astp504_org ",
   #                  " WHERE ooef001 = inaasite          ",
   #                  "   AND prei001 IS NULL             ",    #促銷編號為空=不參與促銷
   #                  "   AND acc_flag = 'N'              ",
   #                  "   AND stfe009 BETWEEN (SELECT pdate_s FROM astp504_org WHERE ooef001 = inaasite)  ",   #保底方案截止日落於本次結算的會計期間內才需要結算
   #                  "                   AND (SELECT pdate_e FROM astp504_org WHERE ooef001 = inaasite))  "                  
   #END CASE   
   #150805-00003#36 150922 by lori mark---(S)
   
   #150805-00003#36 150921 by lori add---(S)
   LET l_sql = "SELECT UNIQUE inaasite,inaa120,inaa141,        stff001,stfa010, ",   #營運據點,專櫃編號,對應常規庫區,專櫃合同編號,供應商編號
               "              stae006, stff008,receivable_flag,pdate_s,pdate_e, ",   #價款類別,會計日期起,會計日期迄,執行扣率,應收FLAG
               "              stfeseq,stfe002,stfe003,         stfe004,stfe006, ",   #保底項次,保底方案編號,費用編號,保底方式,保底計算週期
               "              stfe008,stfe009,stfe012,                          "    #保底開始日期,保底截止日期,月預扣方式
   
   #IF g_prog = 'astp504' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'astp504' THEN   #160705-00042#10 160713 by sakura add
      LET l_sql = l_sql,
               "              (CASE WHEN stfe012 = '2' THEN stfe007             ",   #月預扣方式=2.月平均,則取月預扣標準   
               "                    WHEN stfe012 = '3' THEN stff006             ",   #月預扣方式=3.月累計,則取截止金額    
               "               END) stfe007                                     "
   END IF

   #IF g_prog = 'astp505' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'astp505' THEN   #160705-00042#10 160713 by sakura add
      LET l_sql = l_sql,
               "              stff006              "                                 #保底目標金額
   END IF

   LET l_sql = l_sql,
               "  FROM astp504_acc_tmp,astp504_org ",
               " WHERE ooef001 = inaasite          ",
               "   AND inaa001 = inaa141           ",   
               "   AND acc_flag = 'N'              " 
   
   #160516-00014#42 170106 by lori mark---(S)
   ##IF g_prog = 'astp505' THEN        #160705-00042#10 160713 by sakura mark
   #IF g_prog MATCHES 'astp505' THEN   #160705-00042#10 160713 by sakura add
   #   #保底方案截止日落於本次結算的會計期間內才需要結算
   #   LET l_sql = l_sql,
   #               "   AND stfe009 BETWEEN (SELECT UNIQUE pdate_s FROM astp504_org WHERE ooef001 = inaasite) ",   
   #               "                   AND (SELECT UNIQUE pdate_e FROM astp504_org WHERE ooef001 = inaasite) "   
   #END IF   
   ##150805-00003#36 150921 by lori add---(E)
   #160516-00014#42 170106 by lori mark---(E)
   
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre1 FROM l_sql            
   DECLARE astp504_acc_tmp_sel_cur1 CURSOR FOR astp504_acc_tmp_sel_pre1   
   #DISPLAY "[astp504_acc_tmp_sel_pre1] SQL: ",l_sql 
  
   #(2)取要結算的庫區-實際銷售天數
   LET l_sql = "SELECT COUNT(*)                 ",
               "  FROM (SELECT UNIQUE acc_date  ",
               "          FROM astp504_acc_tmp  ",  
               "         WHERE inaasite = ?     ",
               "           AND inaa001 = ?      ",
               "           AND prei001 IS NULL  ",
               "           AND acc_flag = 'N'   ",
               "           AND (((stfe004 = '2' OR stfe004 = '3' OR '4')            ",
               "                  AND (debc016 IS NOT NULL OR debc020 IS NOT NULL)) ",
               "             OR ((stfe004 = '5' OR stfe004 = '6')                   ",
               "                 AND (stgg007 IS NOT NULL OR stgg008 IS NOT NULL))  ",
               "               ))                                                   "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre2 FROM l_sql            
   #DISPLAY "[astp504_acc_tmp_sel_pre2] SQL: ",l_sql
  
   #(3)保底基本資料
   LET l_sql = "SELECT UNIQUE stfeseq,stfe002,stfe004,stfe006,stfe008, ",   #保底項次,保底方案編號,保底方式,保底計算週期,保底開始日期
               "              stfe009,stfe012,                         ",   #保底截止日期,月預扣方式
               "              (CASE WHEN stfe012 = '2' THEN stfe007    ",   #月預扣方式=2.月平均,則取月預扣標準   
               "                    WHEN stfe012 = '3' THEN stff006    ",   #月預扣方式=3.月累計,則取截止金額    
               "               END) stfe007,           ",               
               "              stff008,receivable_flag  ",                   #執行扣率,應收FLAG
               " FROM astp504_acc_tmp,astp504_org      ",   
               "WHERE ooef001 = inaasite ",
               "  AND prei001 IS NULL    ",   #不參與促銷者
               "  AND inaasite = ?       ",   #營運組織
               "  AND inaa120  = ?       ",   #專櫃編號
               "  AND inaa141  = ?       ",   #對應常規庫區
               "  AND stff001  = ?       ",   #專櫃合同編號,
               "  AND stfe003  = ?       ",   #費用編號
               "  AND stae006  = ?       ",   #價款類型               
               "  AND acc_flag = 'N'     "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre3 FROM l_sql            
   DECLARE astp504_acc_tmp_sel_cur3 CURSOR FOR astp504_acc_tmp_sel_pre3
   #DISPLAY "[astp504_acc_tmp_sel_pre3] SQL: ",l_sql
   
   #(4)取得銷售資料-不參與促銷者&促銷且參與保底者
   LET l_sql = "SELECT COALESCE(SUM(COALESCE(debc013,0)),0),           ",   #銷售數量
               "       COALESCE(SUM(COALESCE(debc016,0)),0),           ",   #原價金額
               "       COALESCE(SUM(COALESCE(debc020,0)),0)            ",   #實收金額
               "  FROM(SELECT UNIQUE acc_date,debc013,debc016,debc020  ",
               "         FROM astp504_acc_tmp    ",   
               "        WHERE inaasite = ?       ",   #營運組織
               "          AND inaa120  = ?       ",   #專櫃編號
               "          AND inaa141  = ?       ",   #對應常規庫區
               "          AND stff001  = ?       ",   #專櫃合同編號,
               "          AND stfe003  = ?       ",   #費用編號
               "          AND stae006  = ?       ",   #價款類型   
               "          AND (     prei001 IS NULL         ",   #促銷編號為空=不參與促銷
               "               OR (     prei001 IS NOT NULL ",   #促銷編號不為空=參與促銷
               "                    AND prei059 = 'Y')      ",   #參與保底否
               "              )                             ",
               "          AND acc_date BETWEEN ? AND ?)     "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre4 FROM l_sql
   #DISPLAY "[astp504_acc_tmp_sel_pre4] SQL: ",l_sql
   
   #(5)取得銷售資料-同專櫃的總銷售金額
   LET l_sql = "SELECT COALESCE(SUM(COALESCE(debc016,0)),0),         ",   #原價金額
               "       COALESCE(SUM(COALESCE(debc020,0)),0)          ",   #實收金額
               "  FROM astp504_acc_tmp               ",  
               " WHERE inaasite = ?                  ",
               "   AND inaa120 = ?                   ",   #專櫃
               "   AND stfeseq = ?                   ",   #保底項次
               "   AND stfe002 = ?                   ",   #保底方案編號               
               "   AND (     prei001 IS NULL         ",   #促銷編號為空=不參與促銷
               "        OR (     prei001 IS NOT NULL ",   #促銷編號不為空=參與促銷
               "             AND prei059 = 'Y')      ",   #參與保底否
               "       )                             ",               
               "   AND acc_date BETWEEN ? AND ?      "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre5 FROM l_sql   
   #DISPLAY "[astp504_acc_tmp_sel_pre5] SQL: ",l_sql 
  
   #(6)取得銷售資料-促銷且不參與保底的天數
   LET l_sql = "SELECT COUNT(*) ",
               "  FROM (SELECT UNIQUE acc_date            ",   #銷售日期
               "          FROM astp504_acc_tmp            ", 
               "         WHERE inaasite = ?               ",
               "           AND inaa141 = ?                ",
               "           AND prei001 IS NOT NULL        ",
               "           AND prei059 = 'N'              ",   #參與保底否
               "           AND preg051 = '1'              ",   #促銷類型
               "           AND acc_date BETWEEN ? AND ?)  "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre6 FROM l_sql
   #DISPLAY "[astp504_acc_tmp_sel_pre6] SQL: ",l_sql 
  
   #(7)取得銷售資料-結算日期
   LET l_sql = "SELECT MAX(stfe009)                                       ",
               "  FROM (SELECT (CASE WHEN stfe009 > pdate_e THEN pdate_e  ",  
               "                                            ELSE stfe009  ",
               "                END) stfe009               ",
               "          FROM astp504_acc_tmp,astp504_org ",   
               "         WHERE ooef001 = inaasite          ",
               "           AND inaa001 = inaa141           ",
               "           AND inaasite = ?                ",
               "           AND inaa001  = ?                ",
               "           AND stfe003  = ?                ",
               "           AND prei001 IS NULL             ",    #促銷編號為空=不參與促銷
               "           AND acc_flag = 'N')             "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre7 FROM l_sql 
   #DISPLAY "[astp504_acc_tmp_sel_pre7] SQL: ",l_sql 
  
   #(8)取得保底資料-按高扣率聯合保時取得最高扣率
   LET l_sql = " SELECT MAX(stff008)     ",  
               "   FROM astp504_acc_tmp  ",                     
               "  WHERE stff001 = ?      ",       #合同編號
               "    AND stfeseq = ?      ",       #保底方案項次
               "    AND stfe002 = ?      "        #保底方案編號    
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre8 FROM l_sql    
   #DISPLAY "[astp504_acc_tmp_sel_pre8] SQL: ",l_sql    

   #(9)取得銷售資料-不排除不參與保底者(保底方式=毛利額/毛利率時使用)
   LET l_sql = "SELECT COALESCE(SUM(COALESCE(stgg007,0)),0),           ",   #應收金額
               "       COALESCE(SUM(COALESCE(stgg008,0)),0),           ",   #實收金額
               "       COALESCE(SUM(COALESCE(stgg009,0)),0),           ",   #實收毛利額
               "       COALESCE(SUM(COALESCE(stgg009,0)),0)            ",   #實收毛利率    
               "         /COALESCE(SUM(COALESCE(stgg008,0)),100)*100   ",
               "  FROM astp504_acc_tmp               ",          
               " WHERE inaasite = ?                  ",
               "   AND inaa141 = ?                   ",
               "   AND acc_date BETWEEN ? AND ?      "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre9 FROM l_sql

   #(10)取得保底資料-按高扣率聯合保時取得最高扣率的庫區
   LET l_sql = " SELECT UNIQUE inaa141   ",  
               "   FROM astp504_acc_tmp  ",   
               "  WHERE stff001 = ?      ",   #合同編號
               "    AND stfeseq = ?      ",   #保底方案項次
               "    AND stfe002 = ?      ",   #保底方案編號 
               "    AND stff008 = ?      "    #扣率              
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre10 FROM l_sql    
   #DISPLAY "[astp504_acc_tmp_sel_pre10] SQL: ",l_sql
   
   #(11)取得銷售資料-不排除不參與保底者(保底方式=毛利額/毛利率時使用)
   LET l_sql = "SELECT COALESCE(SUM(COALESCE(stgg007,0)),0),         ",   #應收金額
               "       COALESCE(SUM(COALESCE(stgg008,0)),0),         ",   #實收金額
               "       COALESCE(SUM(COALESCE(stgg009,0)),0),         ",   #實收毛利額
               "       COALESCE(SUM(COALESCE(stgg009,0)),0)          ",   #實收毛利率    
               "         /COALESCE(SUM(COALESCE(stgg008,0)),100)*100 ",    
               "  FROM astp504_acc_tmp               ",   
               " WHERE inaasite = ?                  ",
               "   AND inaa120 = ?                   ",   #專櫃
               "   AND stfeseq = ?                   ",   #保底項次
               "   AND stfe002 = ?                   ",   #保底方案編號 
               "   AND acc_date BETWEEN ? AND ?      "   
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre11 FROM l_sql    
   #DISPLAY "[astp504_acc_tmp_sel_pre11] SQL: ",l_sql
   
   #150805-00003#36 150915 by lori add---(E)
   
   #150914-00002#53 151231 by lori add---(S)
   LET l_sql = "SELECT COALESCE(SUM(COALESCE(stga008,0)),0), ",   #原價金額
               "       COALESCE(SUM(COALESCE(stga009,0)),0)  ",   #實收金額
               "  FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stgasite = ?   ",           #營運組織
               "   AND stga001 BETWEEN ? AND ? ",  #銷售日期
               "   AND stga003 = ?    ",           #庫區編號
               "   AND stga004 = ?    ",           #專櫃編號
               "   AND stga013 = '22' "            #日結成本類別
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre12 FROM l_sql    
   #DISPLAY "[astp504_acc_tmp_sel_pre12] SQL: ",l_sql  

   LET l_sql = "SELECT COALESCE(SUM(COALESCE(stga008,0)),0), ",   #原價金額
               "       COALESCE(SUM(COALESCE(stga009,0)),0)  ",   #實收金額
               "  FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stgasite = ?   ",           #營運組織
               "   AND stga001 BETWEEN ? AND ? ",  #銷售日期
               "   AND stga004 = ?    ",           #專櫃編號
               "   AND stga013 = '22' "            #日結成本類別
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astp504_acc_tmp_sel_pre13 FROM l_sql    
   #DISPLAY "[astp504_acc_tmp_sel_pre13] SQL: ",l_sql
   #150914-00002#53 151231 by lori add---(E)
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 月預扣結算
# Memo...........:
# Usage..........: CALL astp504_process_1(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/05/31 By Lori
# Modify.........: 2015/09/15 By Lori   #調整計算邏輯; 保底方是=6.毛利率聯合保不需要計算月預扣
################################################################################
PRIVATE FUNCTION astp504_process_1(ls_js)
   DEFINE ls_js            STRING
   DEFINE r_success        LIKE type_t.num5
   DEFINE lc_param         type_parameter
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE l_sql            STRING  
   DEFINE l_wc             STRING
   DEFINE l_stga           type_stga
   #150805-00003#36 150915 by lori mark---(S)
   #DEFINE l_debcsite       LIKE debc_t.debcsite,
   #       l_debc010        LIKE debc_t.debc010 ,
   #       l_debc005        LIKE debc_t.debc005 ,
   #       l_stfa001        LIKE stfa_t.stfa001 ,
   #       l_stfeseq        LIKE stfe_t.stfeseq ,     
   #       l_stfe002        LIKE stfe_t.stfe002 , 
   #       l_stfe006        LIKE stfe_t.stfe006 ,
   #       l_stfe008        LIKE stfe_t.stfe008 ,    
   #       l_stfe009        LIKE stfe_t.stfe009 ,
   #       l_stfe012        LIKE stfe_t.stfe012 ,       
   #       l_stff008        LIKE stff_t.stff008 , 
   #       l_stae006        LIKE stae_t.stae006 ,
   #       l_mhae006        LIKE mhae_t.mhae006 ,    
   #       l_stfe003        LIKE stfe_t.stfe003 ,
   #       l_stfe004        LIKE stfe_t.stfe004 ,       
   #       l_stfe007        LIKE stfe_t.stfe007 ,
   #       l_debc013        LIKE debc_t.debc013 ,
   #       l_debc016        LIKE debc_t.debc016       #150805-00003#41 150831 by lori debc018改取debc016 
   #DEFINE l_mon            LIKE type_t.num5          #第幾個月;月預扣方式=月累計時才使用  
   #DEFINE l_mon_days       LIKE type_t.num5          #當月實際天數   
   #DEFINE l_sale_days      LIKE type_t.num5             #當月實際銷售天數
   #150805-00003#36 150915 by lori mark---(E)
   
   #150805-00003#36 150915 by lori add---(S)        
   DEFINE l_acc                   astp504_acc
   DEFINE l_stff005               LIKE stff_t.stff005   #150923 by lori add
   DEFINE l_stff008               LIKE stff_t.stff008
   DEFINE l_debc013_amount        LIKE debc_t.debc013
   DEFINE l_debc016_amount        LIKE debc_t.debc016
   DEFINE l_debc020_amount        LIKE debc_t.debc020
   DEFINE l_stgg007_amount        LIKE stgg_t.stgg007
   DEFINE l_stgg008_amount        LIKE stgg_t.stgg008
   DEFINE l_stgg009_amount        LIKE stgg_t.stgg009
   DEFINE l_stgg010_amount        LIKE stgg_t.stgg010
   DEFINE l_stga012_amount        LIKE stga_t.stga012   #總月預扣差額
   DEFINE l_sale                  LIKE type_t.num20_6   #銷售金額
   DEFINE l_sale_amount           LIKE type_t.num20_6   #銷售總金額   
   DEFINE l_acc_start             LIKE type_t.dat       #結算起始日
   DEFINE l_acc_end               LIKE type_t.dat       #結算結束日
   DEFINE l_pdate_s               LIKE type_t.dat       #會計期間開始日期
   #150805-00003#36 150915 by lori add---(E)            
   DEFINE l_pdate_e               LIKE type_t.dat              #會計期間結束日期
   DEFINE l_no_part_days          LIKE type_t.num5             #不參與保底的銷售天數
   DEFINE l_withholding           LIKE debc_t.debc016          #本次月預扣金額
   DEFINE l_stga001               LIKE stga_t.stga001,         #150805-00003#36 150915 by lori add
          l_stga002               LIKE stga_t.stga002,
          l_stga008               LIKE stga_t.stga008,
          l_stga009               LIKE stga_t.stga009,
          l_stga010               LIKE stga_t.stga010,         #150805-00003#36 150915 by lori add
          l_stga011               LIKE stga_t.stga011,
          l_stga012               LIKE stga_t.stga012,         #150805-00003#36 150915 by lori add
          l_stga013               LIKE stga_t.stga013,
          l_stga015               LIKE stga_t.stga015,
          l_stgadocno             LIKE stga_t.stgadocno,
          l_stga016               LIKE stga_t.stga016,         #150914-00002#45 151103 by lori add
          l_stga017               LIKE stga_t.stga017          #150914-00002#45 151103 by lori add
   DEFINE l_ooef016               LIKE ooef_t.ooef016          #150914-00002#42 2015/10/28 s983961--add
   DEFINE l_cnt                   LIKE type_t.num5             #150914-00002#45 151103 by lori add
   DEFINE l_cost_amount           LIKE stga_t.stga012          #150914-00002#45 151103 by lori add
   DEFINE l_stga008_amount        LIKE stga_t.stga008          #150914-00002#53 151231 by lori add
   DEFINE l_stga009_amount        LIKE stga_t.stga009          #150914-00002#53 151231 by lori add
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   
   LET l_stga002 = ' '
  #LET l_stga008 = 0
  #LET l_stga009 = 0   
  #LET l_stga010 = ''       #150805-00003#36 150915 by lori add---月預扣不寫費率   #160516-00014#42 170116 by lori mark
  #LET l_stga011 = 0        #150914-00002#45 151103 by lori mark
   LET l_stga012 = 0        #150805-00003#36 150915 by lori add
   LET l_stga013 = '3'
   LET l_stga015 = 'N'
   #LET l_stgadocno = ' '   #150805-00003#36 150922 by lori mark
   LET l_stga016 = ''       #150914-00002#45 151103 by lori add
   LET l_stga017 = ''       #150914-00002#45 151103 by lori add
   
   
   #150805-00003#36 150915 by lori mark---(S)
   #
   #LET l_sql = #門店日結
   #            "SELECT debcsite,debc010,debc005_par,stfa001,stfeseq, ",            #組織,專櫃,常規庫區,合約編號,保底項次
   #            "       stfe002, stfe006,stfe008,    stfe009,stfe012, ",            #保底方案,保底計算方式,保底開始日,保底結束日,月預扣方式
   #            "       stff008, stae006,mhae006,    stfe003,stfe004, ",            #執行扣率,價款類別,供應商,費用,保底方式
   #            "       (CASE WHEN stfe012 = '2' THEN stfe007 ",                    #月預扣方式=2.月平均,則取月預扣標準
   #            "             WHEN stfe012 = '3' THEN stff006 ",                    #月預扣方式=2.月累計,則取截止金額
   #            "         END) stfe007, ",                                                   
   #            "       COALESCE(SUM(COALESCE(debc013,0)),0) debc013, ",            #銷售數量   
   #            "       SUM( ",                                                     #銷售金額
   #            "         COALESCE( ",
   #            "           (CASE WHEN receivable_flag = 'Y' THEN debc016 ",        #150805-00003#41 150831 by lori debc018改取debc016 
   #            "                  ELSE debc020 END) ",
   #            "                 ,0) ",
   #            "          ) debc016 ",                                             #150805-00003#41 150831 by lori debc018改取debc016           
   #            " FROM astp504_debc t1,astp504_contract t2 ",
   #            "WHERE t1.debcsite = t2.stfasite ",                                     #組織
   #            "  AND t1.debc010 = t2.stfa005 ",                                       #專櫃
   #            "  AND t1.debc005_par = t2.stff005 ",                                   #庫區
   #            "  AND ((t1.inaa135 = '1' ",                                            #常規庫區
   #            "        AND t1.debc002 BETWEEN stfe008 ",
   #            "                           AND COALESCE(stfe009, ",
   #            "                                       (SELECT pdate_e FROM astp504_org ",
   #            "                                         WHERE ooef001 = debcsite))) ", 
   #            "    OR( t1.inaa135 = '2' ",                                            #促銷庫區且是參與合同保底
   #            "        AND EXISTS (SELECT 1 FROM astp504_promotions t3 ",
   #            "                     WHERE t3.stfa001 = t1.mhae006 ",
   #            "                       AND t3.prei003_par = t1.debc005 ",
   #            "                       AND t1.debc002 BETWEEN preh003 ",
   #            "                                          AND COALESCE(preh004, ",
   #            "                                                      (SELECT pdate_e FROM astp504_org ",
   #            "                                                        WHERE ooef001 = debcsite)",
   #            "                                                      ) ",
   #            "                   ) ",  
   #            "      )) ",               
   #            "  AND t1.counter_acc = 'N' ",                                      #未有結轉的專櫃
   #            "  AND t2.stfe004 IN('2','3','4') ",                                #保底方式               
   #            "GROUP BY debcsite,debc010,debc005_par,stfa001,stfeseq, ",
   #            "         stfe002, stfe006,stfe008,    stfe009,stfe012, ",
   #            "         stff008, stae006,mhae006,    stfe003,stfe004, ",
   #            "         stfe007, stff006 ",
   #            ###
   #            "UNION ",
   #            #專櫃促銷-毛利額/毛利率
   #            "SELECT stggsite,stgg003,stgg002_par,stfa001,stfeseq, ",            #組織,專櫃,常規庫區,合約編號,保底項次
   #            "       stfe002, stfe006,stfe008,    stfe009,stfe012, ",            #保底方案,保底計算方式,保底開始日,保底結束日,月預扣方式
   #            "       stff008, stae006,stgg004,    stfe003,stfe004, ",            #執行扣率,價款類別,供應商,費用,保底方式
   #            "       (CASE WHEN stfe012 = '2' THEN stfe007 ",                    #月預扣方式=2.月平均,則取月預扣標準
   #            "             WHEN stfe012 = '3' THEN stff006 ",                    #月預扣方式=2.月累計,則取截止金額
   #            "         END) stfe007, ",                                                   
   #            "       0 debc013, ",                                               #銷售數量
   #            "       (CASE ",                                                    
   #            "           WHEN stfe004 = '5' ",                                 
   #            "              THEN COALESCE(SUM(COALESCE(stgg008,0)),0) ",         #實收毛利額 
   #            "           WHEN stfe004 = '6' ",
   #            "              THEN COALESCE(SUM(COALESCE(stgg008,0)),0) ",         #實收毛利率
   #            "                  /COALESCE(SUM(COALESCE(stgg007,0)),100)*100 ",  
   #            "         END) debc016 ",                                           #150805-00003#41 150831 by lori debc018改名debc016             
   #            " FROM astp504_stgg t1,astp504_contract t2 ",
   #            "WHERE t1.stggsite = t2.stfasite ",                                     #組織
   #            "  AND t1.stgg003 = t2.stfa005 ",                                       #專櫃
   #            "  AND t1.stgg002_par = t2.stff005 ",                                   #庫區            
   #            "  AND ((t1.inaa102 = '1' ",                                            #常規庫區
   #            "    AND t1.stgg001 BETWEEN stfe008 ",
   #            "                       AND COALESCE(stfe009,(SELECT pdate_e FROM astp504_org WHERE ooef001 = stggsite))) ",                                             
   #            "     OR( t1.inaa102 = '2' ",                                            #促銷庫區且是參與合同保底
   #            "        AND EXISTS (SELECT 1 FROM astp504_promotions t3 ",
   #            "                     WHERE t3.stfa001 = t1.stgg003 ",
   #            "                       AND t3.prei003_par = t1.stgg002_par ",
   #            "                       AND t1.stgg001 BETWEEN preh003 ",
   #            "                                          AND COALESCE(preh004, ",
   #            "                                                      (SELECT pdate_e FROM astp504_org WHERE ooef001 = t1.stggsite) ",
   #            "                                                      ) ",
   #            "                   )",
   #            "       )) ",    
   #            "  AND t1.counter_acc = 'N' ",                                      #未有結轉的專櫃 
   #            "  AND t2.stfe004 IN ('5','6') ",                                   #保底方式 
   #            "GROUP BY stggsite,stgg003,stgg002_par,stfa001,stfeseq, ",
   #            "         stfe002, stfe006,stfe008,    stfe009,stfe012, ",
   #            "         stff008, stae006,stgg004,    stfe003,stfe004, ",
   #            "         stfe007, stff006 "              
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_process_pre1 FROM l_sql
   #DECLARE astp504_process_cur1 CURSOR FOR astp504_process_pre1
   ##DISPLAY "[astp504_process_pre1] SQL: ",l_sql
   #   
   #
   #IF lc_param.l_del = 'Y' THEN
   #   #SQL-刪除已結算過資料
   #   EXECUTE astp504_del_stga
   #   DISPLAY "[astp504_del_stga(1)] CNT: ",SQLCA.sqlerrd[3]
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "Delete stga_t"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err() 
   #   
   #      LET l_err_cnt = l_err_cnt + 1
   #   END IF   
   #END IF
   #
   #DISPLAY "astp504 process star:",cl_get_current()
   #FOREACH astp504_process_cur1 INTO l_debcsite,l_debc010,l_debc005,l_stfa001,l_stfeseq, 
   #                                  l_stfe002, l_stfe006,l_stfe008,l_stfe009,l_stfe012, 
   #                                  l_stff008, l_stae006,l_mhae006,l_stfe003,l_stfe004, 
   #                                  l_stfe007, l_debc013,l_debc016                         #150805-00003#41 150831 by lori debc018改名debc016 
   #   INITIALIZE l_stga.* TO NULL
   #   LET l_mon = ''
   #   LET l_pdate_e = ''
   #   IF cl_null(l_debc016) THEN   #150805-00003#41 150831 by lori debc018改名debc016 
   #      LET l_debc016 = 0         #150805-00003#41 150831 by lori debc018改名debc016 
   #   END IF
   #   
   #   LET l_stga.stgaent   = g_enterprise  #企業編號
   #   LET l_stga.stgasite  = l_debcsite    #營運組織
   #   LET l_stga.stgaunit  = l_debcsite    #應用組織
   #   
   #   #銷售日期
   #   SELECT UNIQUE pdate_e               
   #     INTO l_pdate_e
   #     FROM astp504_org
   #    WHERE ooef001 = l_debcsite
   #   
   #   IF l_pdate_e > l_stfe009 THEN
   #      LET l_stga.stga001 = l_stfe009   
   #   ELSE
   #      LET l_stga.stga001 = l_pdate_e       
   #   END IF
   #   
   #   LET l_stga.stga002   = l_stga002      #商品編號
   #   LET l_stga.stga003   = l_debc005      #庫區編號
   #   LET l_stga.stga004   = l_debc010      #專櫃編號
   #   LET l_stga.stga005   = l_mhae006      #供應商編號
   #   LET l_stga.stga006   = l_stfe003      #費用編號
   #   LET l_stga.stga007   = l_debc013      #銷售數量
   #   LET l_stga.stga008   = l_stga008      #應收金額
   #   LET l_stga.stga009   = l_stga009      #實收金額
   #   
   #   #費率
   #   CASE l_stfe004
   #      WHEN '2'  #普通各自保
   #         LET l_stga.stga010   = l_stff008   
   #      WHEN '3'  #各自扣率聯合保
   #         LET l_stga.stga010   = l_stff008   
   #      WHEN '4'  #按高扣率聯合保
   #         SELECT MAX(stff008) 
   #           INTO l_stga.stga010
   #           FROM astp504_contract
   #          WHERE stfa001 = l_stfa001
   #            AND stfa002 = l_stfa002
   #            AND stfaseq = l_stfaseq 
   #      WHEN '5'  #按毛利額聯合保   
   #         LET l_stga.stga010   = l_stff008   
   #      WHEN '6'  #按毛利率聯合保  
   #         LET l_stga.stga010   = l_stff008            
   #   END CASE
   #   
   #   LET l_stga.stga011   = l_stga011      #費用金額
   #              
   #   #本次月預扣金額
   #   CASE l_stfe012 
   #      WHEN '2'   #月平均
   #         LET l_withholding = l_stfe007/l_mon_days*(l_sale_days-l_no_part_days)
   #      WHEN '3'   #月累計     
   #         LET l_mon = astp504_get_withholding_mon(l_debcsite,l_stfe008,l_stfe009)
   #         DISPLAY "Get Months: ",l_mon," stfe006: ",l_stfe006," stfe007: ",l_stfe007
   #         
   #         CASE l_stfe006
   #            WHEN '1'   #月
   #               LET l_withholding = l_stfe007
   #            WHEN '2'   #季
   #               LET l_withholding = l_stfe007/3*l_mon
   #            WHEN '3'   #半年
   #               LET l_withholding = l_stfe007/6*l_mon
   #            WHEN '4'   #年
   #               LET l_withholding = l_stfe007/12*l_mon
   #         END CASE
   #   END CASE
   #   
   #   #成本金額=月預扣差額
   #   #銷售金額>=本次月預扣金額,月預扣差額=0
   #   #銷售金額< 本次月預扣金額,月預扣差額=銷售金額-本次月預扣金額      
   #   IF l_debc016 >= l_withholding THEN                        #150805-00003#41 150831 by lori debc018改名debc016 
   #      LET l_stga.stga012 = 0 
   #   ELSE
   #      LET l_stga.stga012 = l_debc016 - l_withholding         #150805-00003#41 150831 by lori debc018改名debc016  
   #   END IF      
   #   
   #   LET l_stga.stga013   = l_stga013      #日結成本類別 
   #   LET l_stga.stga014   = l_stae006      #價款類型
   #   LET l_stga.stga015   = l_stga015      #已結轉否
   #   LET l_stga.stgadocno = l_stgadocno    #來源單號
   #   
   #   DISPLAY "Org.: ",l_debcsite," Subinv.: ",l_debc005," Sale: ",l_debc016," Goal: ",l_withholding      
   #   EXECUTE astp504_stga_ins USING l_stga.stgaent  ,l_stga.stgasite ,l_stga.stgaunit ,l_stga.stga001  ,l_stga.stga002  ,
   #                                  l_stga.stga003  ,l_stga.stga004  ,l_stga.stga005  ,l_stga.stga006  ,l_stga.stga007  ,
   #                                  l_stga.stga008  ,l_stga.stga009  ,l_stga.stga010  ,l_stga.stga011  ,l_stga.stga012  ,
   #                                  l_stga.stga013  ,l_stga.stga014  ,l_stga.stga015  ,l_stga.stgadocno         
   #   DISPLAY "[astp504_stga_ins(1)] CNT: ",SQLCA.sqlerrd[3]
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "Insert stga_t"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err() 
   #   
   #      LET l_err_cnt = l_err_cnt + 1
   #   END IF        
   #END FOREACH  
   #DISPLAY "astp504 process end:",cl_get_current()
   #
   #150805-00003#36 150915 by lori mark---(E)
   
   INITIALIZE l_acc.* TO NULL   #161201-00043#1 161201 by lori add
   
   #150805-00003#36 150915 by lori add---(S)
   #150805-00003#36 150922 by lori mark and add---(S) 
   ##取要結算的庫區資料
   #FOREACH astp504_acc_tmp_sel_cur1 INTO l_acc.inaasite,l_acc.inaa120,l_acc.inaa141,l_acc.stff001,l_acc.stfe003,   #營運據點,專櫃編號,對應常規庫區,專櫃合同編號,費用編號    
   #                                      l_acc.stae006, l_acc.stfa010,l_pdate_s,    l_pdate_e                      #價款類別,供應商編號,會計日期起,會計日期迄
   #
   FOREACH astp504_acc_tmp_sel_cur1 INTO l_acc.inaasite,l_acc.inaa120,l_acc.inaa141,        l_acc.stff001,l_acc.stfa010,   #營運據點,專櫃編號,對應常規庫區,專櫃合同編號,供應商編號
                                         l_acc.stae006, l_acc.stff008,l_acc.receivable_flag,l_pdate_s,    l_pdate_e,       #價款類別,會計日期起,會計日期迄,執行扣率,應收FLAG
                                         l_acc.stfeseq, l_acc.stfe002,l_acc.stfe003,        l_acc.stfe004,l_acc.stfe006,   #保底項次,保底方案編號,費用編號,保底方式,保底計算週期
                                         l_acc.stfe008, l_acc.stfe009,l_acc.stfe012,        l_acc.stfe007                  #保底開始日期,保底截止日期,月預扣方式,月預扣目標
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Process_1 Error:astp504_acc_tmp_sel_cur1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #DISPLAY "Oracle Error Code: ",SQLCA.sqlerrd[2]
      LET l_err_cnt = l_err_cnt + 1
   END IF                                         
   #150805-00003#36 150922 by lori mark and add---(E) 
      
      #150914-00002#45 151104 by lori add and mod---(S)
      #銷售日期
      LET l_stga001 = ''         
      EXECUTE astp504_acc_tmp_sel_pre7 USING l_acc.inaasite,l_acc.inaa141,l_acc.stfe003
                                        INTO l_stga001
                                        
      IF lc_param.l_del = 'N' THEN
         #批次條件不刪除已存在條件,但資料已存在時,則提示訊息
         LET l_cnt = 0
         EXECUTE astp504_cnt_stga USING l_acc.inaasite,l_stga001,l_stga002,l_acc.inaa141,l_stga013,     #營運組織,銷售日期,商品編號,庫區編號,日結成本類型
                                        l_acc.stfe002                                                   #來源單號  
                                  INTO l_cnt         
                                  
         IF l_cnt >= 0 THEN
            #組織(%1)所屬的庫區：%2已存在方底方案：%3,日期：%4的專櫃月預扣資料，不進行重新計算。
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ast-00494'
            LET g_errparam.replace[1] = l_acc.inaasite
            LET g_errparam.replace[2] = l_acc.inaa141
            LET g_errparam.replace[3] = l_acc.stfe002 
            LET g_errparam.replace[4] = l_stga001
            LET g_errparam.popup = TRUE
            CALL cl_err() 
         
            CONTINUE FOREACH
         END IF      
      END IF
      #150914-00002#45 151104 by lori add---(E)
   
      IF l_acc.stfe004 = '6' THEN
         CONTINUE FOREACH
      END IF
      
      DISPLAY "-----------------------------------------------------------------------------------------------"
      DISPLAY "組織: ",l_acc.inaasite," 專櫃: ",l_acc.inaa120," 庫區: ",l_acc.inaa141," 合同: ",l_acc.stff001," 費用: ",l_acc.stfe003
      
      LET l_acc_start      = ''    #結算起始日
      LET l_acc_end        = ''    #結算結束日
      LET l_no_part_days   = 0     #不參與保底的銷售天數
      LET l_withholding    = 0     #本次月預扣金額
      LET l_stga012_amount = 0     #總月預扣差額
      LET l_stff005        = ''    #150805-00003#36 150923 by lori add
      LET l_stff008        = 0
      LET l_sale           = 0
      LET l_sale_amount    = 0
      LET l_debc013_amount = 0                                                          
      LET l_debc016_amount = 0                                              
      LET l_debc020_amount = 0                                              
      LET l_stgg007_amount = 0 
      LET l_stgg008_amount = 0 
      LET l_stgg009_amount = 0 
      LET l_stgg010_amount = 0    
      LET l_stga008        = 0    #150914-00002#53 151231 by lori add
      LET l_stga009        = 0    #150914-00002#53 151231 by lori add
      LET l_stga008_amount = 0    #150914-00002#53 151231 by lori add 
      LET l_stga009_amount = 0    #150914-00002#53 151231 by lori add      
                                        
      #150805-00003#36 150922 by lori mark---(S)                                
      ##取要結算的庫區-實際銷售天數
      #EXECUTE astp504_acc_tmp_sel_pre2 USING l_acc.inaasite,l_acc.inaa001
      #                                  INTO l_sale_days
      ##保底基本資料
      #FOREACH astp504_acc_tmp_sel_cur3 USING l_acc.inaasite,l_acc.inaa120,l_acc.inaa141,l_acc.stff001,l_acc.stfe003,
      #                                       l_acc.stae006
      #                                  INTO l_acc.stfeseq,l_acc.stfe002,l_acc.stfe004,l_acc.stfe006,l_acc.stfe008,          #保底項次,保底方案編號,保底方式,保底計算週期,保底開始日期
      #                                       l_acc.stfe009,l_acc.stfe012,l_acc.stfe007,l_acc.stff008,l_acc.receivable_flag   #保底截止日期,月預扣方式,月預扣標準,執行扣率,應收FLAG    
      #150805-00003#36 150922 by lori mark---(E)
      
      #取結算起始日&月預扣目標金額
      CASE l_acc.stfe012          
         WHEN '2'   #月平均  
            IF l_acc.stfe008 < l_pdate_s THEN
               LET l_acc_start = l_pdate_s
            ELSE
               LET l_acc_start = l_acc.stfe008
            END IF             
         WHEN '3'   #月累計              
            LET l_acc_start = l_acc.stfe008
      END CASE
      
      #取結算結束日
      IF l_acc.stfe009 > l_pdate_s THEN       #160516-00014#42 170116 by lori add
         IF l_acc.stfe009 < l_pdate_e THEN
            LET l_acc_end = l_acc.stfe009
         ELSE
            LET l_acc_end = l_pdate_e
         END IF
     ELSE                                     #160516-00014#42 170116 by lori add
        LET l_acc_end = l_pdate_e             #160516-00014#42 170116 by lori add
     END IF                                   #160516-00014#42 170116 by lori add
      
      #取得銷售資料-不參與促銷者&促銷且參與保底者
      EXECUTE astp504_acc_tmp_sel_pre4 USING l_acc.inaasite,l_acc.inaa120,l_acc.inaa141,l_acc.stff001,l_acc.stfe003,
                                             l_acc.stae006,l_acc_start,l_acc_end
                                        INTO l_acc.debc013,l_acc.debc016,l_acc.debc020
      #取得銷售資料-不排除不參與保底者
      IF l_acc.stfe004 MATCHES "[56]" THEN   
         EXECUTE astp504_acc_tmp_sel_pre9 USING l_acc.inaasite,l_acc.inaa141,l_acc_start,l_acc_end
                                           INTO l_acc.stgg007,l_acc.stgg008,l_acc.stgg009,l_acc.stgg010          
      END IF
      
      #150914-00002#53 151231 by lori add---(S)
      #取得日結類型=22的實收與應收金額
      EXECUTE astp504_acc_tmp_sel_pre13 USING l_acc.inaasite,l_acc_start,l_acc_end,l_acc.inaa141,l_acc.inaa120
                                          INTO l_stga008,l_stga009   

      EXECUTE astp504_acc_tmp_sel_pre13 USING l_acc.inaasite,l_acc_start,l_acc_end,l_acc.inaa120
                                          INTO l_stga008_amount,l_stga009_amount  
      #150914-00002#53 151231 by lori add---(E)
      
      #3.各自扣率聯合保/4.按高扣率聯合保時需取得總銷售金額
      CASE
         WHEN l_acc.stfe004 MATCHES "[346]"
            #取得銷售資料-同專櫃同方案的總銷售金額
            EXECUTE astp504_acc_tmp_sel_pre5 USING l_acc.inaasite,l_acc.inaa120,l_acc.stfeseq,l_acc.stfe002,l_acc_start,l_acc_end
                                              INTO l_debc016_amount,l_debc020_amount
         
         WHEN l_acc.stfe004 MATCHES "[5]"          
           EXECUTE astp504_acc_tmp_sel_pre11 USING l_acc.inaasite,l_acc.inaa120,l_acc.stfeseq,l_acc.stfe002,l_acc_start,l_acc_end
                                              INTO l_stgg007_amount,l_stgg008_amount,l_stgg009_amount,l_stgg010_amount   
                                           
      END CASE
      
      #取得銷售資料-促銷且不參與保底的天數
      EXECUTE astp504_acc_tmp_sel_pre6 USING l_acc.inaasite,l_acc.inaa141,l_acc_start,l_acc_end 
                                        INTO l_no_part_days
      IF cl_null(l_no_part_days) THEN
         LET l_no_part_days = 0      
      END IF
      
      #取得費率
      #IF   保底方式=4.按高扣率聯合保 THEN 取最高扣率
      #ELSE 保底方式=2.普通各自保/3.各自扣率聯合保/5.按毛利額聯合保/6.按毛利率聯合保 THEN 取庫區本身的扣率
      IF l_acc.stfe004 = '4' THEN
         EXECUTE astp504_acc_tmp_sel_pre8 USING l_acc.stff001,l_acc.stfeseq,l_acc.stfe002
                                           INTO l_stff008     
         
         #150805-00003#36 150923 lori add---(S)
         #按高扣率聯合保只需按最高扣率的庫區寫入結算檔
         EXECUTE astp504_acc_tmp_sel_pre10 USING l_acc.stff001,l_acc.stfeseq,l_acc.stfe002,l_stff008
                                            INTO l_stff005             
         IF l_acc.inaa141 <> l_stff005 THEN
            CONTINUE FOREACH
         END IF
         #150805-00003#36 150923 lori add---(E)            
      ELSE
         LET l_stff008 = l_acc.stff008
      END IF          
      
      #本次月預扣金額
      IF l_acc.stfe004 MATCHES "[234]" THEN
         CASE l_acc.stfe012
            WHEN '2'   #月平均(結算日期起迄=自然月起迄)
               #本次月預扣金額=(月預扣目標金額/自然月天數)*(本次結算的保底天數-本次結算的不保底天數)         
               LET l_withholding = (l_acc.stfe007/(l_pdate_e-l_pdate_s+1))*((l_acc_end-l_acc_start+1)-l_no_part_days)                 
            WHEN '3'   #月累計
               #本次月預扣金額=(月預扣目標金額/方案的總保底天數)*(本次結算的保底天數-本次結算的不保底天數)         
               LET l_withholding = (l_acc.stfe007/(l_acc.stfe009-l_acc.stfe008+1))*((l_acc_end-l_acc_start+1)-l_no_part_days)               
         END CASE   
       
      ELSE
         CASE l_acc.stfe012
            WHEN '2'   #月平均(結算日期起迄=自然月起迄)
               #本次月預扣金額=(月預扣目標金額/自然月天數)*本次結算的天數         
               LET l_withholding = (l_acc.stfe007/(l_pdate_e-l_pdate_s+1))*(l_acc_end-l_acc_start+1)                
            WHEN '3'   #月累計
               #本次月預扣金額=(月預扣目標金額/方案的總保底天數)*本次結算的天數
               LET l_withholding = (l_acc.stfe007/(l_acc.stfe009-l_acc.stfe008+1))*(l_acc_end-l_acc_start+1) 
         END CASE                  
      END IF
      
      #本次銷售金額(l_sale)&總銷售金額(l_sale_amount)&月預扣差額(l_stga012)
      IF l_acc.stfe004 = '5' THEN
         LET l_sale        = l_acc.stgg009
         LET l_sale_amount = l_stgg009_amount        
      ELSE
         IF l_acc.receivable_flag = 'Y' THEN   
           #原價金額
           #LET l_sale        = l_acc.debc016                         #150914-00002#53 151231 by lori mark
           #LET l_sale_amount = l_debc016_amount                      #150914-00002#53 151231 by lori mark
            LET l_sale        = l_acc.debc016 + l_stga008             #150914-00002#53 151231 by lori add
            LET l_sale_amount = l_debc016_amount + l_stga008_amount   #150914-00002#53 151231 by lori add            
         ELSE                                  
           #實收金額
           #LET l_sale        = l_acc.debc020                         #150914-00002#53 151231 by lori mark
           #LET l_sale_amount = l_debc020_amount                      #150914-00002#53 151231 by lori mark
            LET l_sale        = l_acc.debc020 + l_stga009             #150914-00002#53 151231 by lori add
            LET l_sale_amount = l_debc020_amount  + l_stga008_amount  #150914-00002#53 151231 by lori add                            
         END IF
      END IF

      #無銷售資料時的防呆處理
      IF cl_null(l_sale) THEN
         LET l_sale = 0
      END IF

      IF cl_null(l_sale_amount) THEN
         LET l_sale_amount = 1   #分母不可為0
      END IF  
      
      CASE l_acc.stfe004 
         WHEN '2'   #2.普通各自保
            IF l_sale >= l_withholding THEN 
               LET l_stga012 = 0
            ELSE   
               #本次月預扣差額=(本次庫區銷售金額-本次月預扣金額)*各自扣率
               LET l_stga012 = (l_sale-l_withholding)*(l_stff008/100)  
            END IF
            
         WHEN '3'   #3.各自扣率聯合保
            IF l_sale_amount >= l_withholding THEN
               LET l_stga012 = 0
            ELSE
               #本次月預扣差額=(同專櫃同方案的總銷售金額-本次月預扣金額)*(庫區銷售金額/同專櫃同方案的總銷售金額)*各自扣率
               LET l_stga012 = (l_sale_amount-l_withholding)*(l_sale/l_sale_amount)*(l_stff008/100) 
            END IF
            
         WHEN '4'   #4.按高扣率聯合保   
            IF l_sale_amount >= l_withholding THEN
               LET l_stga012 = 0
            ELSE   
               #本次月預扣差額=(同專櫃同方案的總銷售金額-本次月預扣金額)*同方案中最高的扣率
               LET l_stga012 = (l_sale_amount-l_withholding)*(l_stff008/100)
            END IF
            
         WHEN '5'   #5.按毛利額聯合保
            IF l_sale_amount >= l_withholding THEN
               LET l_stga012 = 0
            ELSE 
               #本次月預扣差額=(同專櫃同方案的總銷售毛利額-本次月預扣金額)*(庫區銷售毛利金額/同專櫃同方案的總銷售毛利金額)*各自扣率               
               LET l_stga012 = (l_sale_amount-l_withholding)*(l_sale/l_sale_amount)*(l_stff008/100)
            END IF               
         
            #150914-00002#45 151104 by lori add---(S)
            LET l_cost_amount = 0
            EXECUTE astp504_sel_stga USING l_acc.inaasite,l_acc_start,l_acc_end,l_stga002,l_acc.inaa141,     #營運組織,結算起始日,結算結束日,商品編號,庫區編號
                                            l_stga013,l_acc.stfe002                                           #日結成本類型,來源單號  
                                      INTO l_cost_amount
                                      
            IF cl_null(l_cost_amount) THEN
               LET l_cost_amount = 0
            END IF
            
            LET l_stga012 = l_stga012 - l_cost_amount                          
            #150914-00002#45 151104 by lori add---(E)
            
         #150805-00003#36 150923 by lori mark---(S)  
         #WHEN '6'   #6.按毛利率聯合保
         #   #本次月預扣差額=(本次庫區銷售毛利率-保底毛利率)*本次庫區銷售金額*各自扣率
         #   LET l_stga012 = (l_stgg010_amount-l_acc.stfe007)*l_sale*(l_stff008/100)
         #150805-00003#36 150923 by lori mark---(E)  
      END CASE
      
      DISPLAY "    保底方案      : ",l_acc.stfe002," 保底方式: ",l_acc.stfe004," 保底起訖: ",l_acc.stfe008,"~",l_acc.stfe009
      DISPLAY "    月預扣方式    : ",l_acc.stfe012," 月預扣標準: ",l_acc.stfe007," 取原價否: ",l_acc.receivable_flag
      DISPLAY "    結算起訖      : ",l_acc_start,"~",l_acc_end," 本次應保底天數: ",l_acc_end-l_acc_start+1," 不保底天數: ",l_no_part_days
      DISPLAY "    本次月預扣金額: ",l_withholding,"(費率:",l_stff008,"%)"
      DISPLAY "    銷售金額      : ",l_sale
      DISPLAY "    方案總銷售金額: ",l_sale_amount
      DISPLAY "    本次月預扣差額: ",l_stga012         
      DISPLAY "-----------------------------------------------------------------------------------------------"

      #150914-00002#42 2015/10/29 s983961--add(s)
      #按當前幣別截取aooi150裡的用戶設置小數位 處理金額欄位
      SELECT ooef016 
        INTO l_ooef016
        FROM ooef_t 
       WHERE ooefent = g_enterprise 
         AND ooef001 = l_stga.stgasite
         
      IF NOT cl_null(l_ooef016) THEN   
         IF NOT cl_null(l_stga.stga008) AND l_stga.stga008 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga008,'2') RETURNING l_stga.stga008
         END IF
         
         IF NOT cl_null(l_stga.stga009) AND l_stga.stga009 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga009,'2') RETURNING l_stga.stga009
         END IF
         
         IF NOT cl_null(l_stga.stga011) AND l_stga.stga011 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga011,'2') RETURNING l_stga.stga011
         END IF
         
         IF NOT cl_null(l_stga.stga012) AND l_stga.stga012 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga012,'2') RETURNING l_stga.stga012
         END IF   
      END IF
      #150914-00002#42 2015/10/29 s983961--add(e)
      
      #150805-00003#36 150924 by lori add---(S)
      #月預扣差額=0者不需寫入
      IF cl_null(l_stga012) OR l_stga012 = 0 THEN
         CONTINUE FOREACH
      END IF
      #150805-00003#36 150924 by lori add---(E)
      
      INITIALIZE l_stga.* TO NULL
      
      LET l_stga.stgaent   = g_enterprise      #企業編號
      LET l_stga.stgasite  = l_acc.inaasite    #營運組織
      LET l_stga.stgaunit  = l_acc.inaasite    #應用組織
      LET l_stga.stga001   = l_stga001         #銷售日期   #150914-00002#45 151104 by lori add                                
      LET l_stga.stga002   = l_stga002         #商品編號
      LET l_stga.stga003   = l_acc.inaa141     #庫區編號
      LET l_stga.stga004   = l_acc.inaa120     #專櫃編號
      LET l_stga.stga005   = l_acc.stfa010     #供應商編號
      LET l_stga.stga006   = l_acc.stfe003     #費用編號
      LET l_stga.stga007   = l_acc.debc013     #銷售數量               
      LET l_stga.stga008   = l_stga008         #應收金額                
      LET l_stga.stga009   = l_stga009         #實收金額                
     #LET l_stga.stga010   = l_stga010         #費率       #160516-00014#42 170116 by lori mark              
      LET l_stga.stga010   = l_stff008                    #160516-00014#42 170116 by lori add
     #LET l_stga.stga011   = l_stga011         #費用金額   #150914-00002#45 151103 by lori mark
      LET l_stga.stga011   = l_stga012*(-1)               #150914-00002#45 151103 by lori add                
      LET l_stga.stga012   = l_stga012         #成本金額=月預扣差額     
      LET l_stga.stga013   = l_stga013         #日結成本類別            
      LET l_stga.stga014   = l_acc.stae006     #價款類型                
      LET l_stga.stga015   = l_stga015         #已結轉否                
      LET l_stga.stgadocno = l_acc.stfe002     #來源單號=保底方案編號 
      LET l_stga.stga016   = l_stga016         #銷售單號   #150914-00002#45 151103 by lori add
      LET l_stga.stga017   = l_stga017         #銷售項次   #150914-00002#45 151103 by lori add    
   
      EXECUTE astp504_stga_ins USING l_stga.stgaent  ,l_stga.stgasite ,l_stga.stgaunit ,l_stga.stga001  ,l_stga.stga002  ,
                                     l_stga.stga003  ,l_stga.stga004  ,l_stga.stga005  ,l_stga.stga006  ,l_stga.stga007  ,
                                     l_stga.stga008  ,l_stga.stga009  ,l_stga.stga010  ,l_stga.stga011  ,l_stga.stga012  ,
                                     l_stga.stga013  ,l_stga.stga014  ,l_stga.stga015  ,l_stga.stgadocno,l_stga.stga016  ,     #150914-00002#45 151103 by lori add stga016
                                     l_stga.stga017                                                                            #150914-00002#45 151103 by lori add stga017
      IF SQLCA.sqlcode THEN   
         INITIALIZE g_errparam TO NULL   
         LET g_errparam.code = SQLCA.sqlcode   
         LET g_errparam.extend = "Insert stga_t"   
         LET g_errparam.popup = TRUE
         CALL cl_err()                                     
         LET l_err_cnt = l_err_cnt + 1
      END IF  
      DISPLAY "[astp504_stga_ins(1)] CNT: ",SQLCA.sqlerrd[3] 
      INITIALIZE l_acc.* TO NULL   #161201-00043#1 161201 by lori add    
   END FOREACH   
   #150805-00003#36 150915 by lori add---(E)
      
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 保底方案結算
# Memo...........:
# Usage..........: CALL astp504_process_2(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/05/31 By Lori
# Modify.........: 2016/08/03 By Lori 毛利額聯合保的保底差額計算公式錯誤
################################################################################
PRIVATE FUNCTION astp504_process_2(ls_js)
   DEFINE ls_js            STRING
   DEFINE r_success        LIKE type_t.num5
   DEFINE lc_param         type_parameter
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE l_sql            STRING  
   DEFINE l_wc             STRING
   DEFINE l_stga           type_stga
   #150805-00003#36 150915 by lori mark---(S)
   #DEFINE l_pdate_ym       STRING
   #DEFINE l_stfe008_ym     STRING
   #DEFINE l_stfe009_ym     STRING
   #DEFINE l_debcsite       LIKE debc_t.debcsite,
   #       l_debc010        LIKE debc_t.debc010 ,
   #       l_debc005        LIKE debc_t.debc005 ,
   #       l_stfa001        LIKE stfa_t.stfa001 ,
   #       l_stfeseq        LIKE stfe_t.stfeseq ,     
   #       l_stfe002        LIKE stfe_t.stfe002 , 
   #       l_stfe006        LIKE stfe_t.stfe006 ,
   #       l_stfe008        LIKE stfe_t.stfe008 ,    
   #       l_stfe009        LIKE stfe_t.stfe009 ,
   #       l_stfe012        LIKE stfe_t.stfe012 ,       
   #       l_stff008        LIKE stff_t.stff008 , 
   #       l_stae006        LIKE stae_t.stae006 ,
   #       l_mhae006        LIKE mhae_t.mhae006 ,    
   #       l_stfe003        LIKE stfe_t.stfe003 ,
   #       l_stfe004        LIKE stfe_t.stfe004 ,       
   #       l_stff006        LIKE stff_t.stff006 ,
   #       l_debc013        LIKE debc_t.debc013 ,
   #       l_debc016        LIKE debc_t.debc016 ,    #150805-00003#41 150831 by lori debc018改名debc016 
   #       l_stgg007        LIKE stgg_t.stgg007          
   #DEFINE l_mon            LIKE type_t.num5         #第幾個月;月預扣方式=月累計時才使用  
   #DEFINE l_mon_days       LIKE type_t.num5         #當月實際天數
   #DEFINE l_sale_days      LIKE type_t.num5             #當月實際銷售天數
   #150805-00003#36 150915 by lori mark---(E)
   
   #150805-00003#36 150915 by lori add---(S)           
   DEFINE l_acc                   astp504_acc
   DEFINE l_stff005               LIKE stff_t.stff005   #150923 by lori add
   DEFINE l_stff008               LIKE stff_t.stff008
   DEFINE l_debc013_amount        LIKE debc_t.debc013
   DEFINE l_debc016_amount        LIKE debc_t.debc016
   DEFINE l_debc020_amount        LIKE debc_t.debc020
   DEFINE l_stgg007_amount        LIKE stgg_t.stgg007
   DEFINE l_stgg008_amount        LIKE stgg_t.stgg008
   DEFINE l_stgg009_amount        LIKE stgg_t.stgg009
   DEFINE l_stgg010_amount        LIKE stgg_t.stgg010
   DEFINE l_stga012_amount        LIKE stga_t.stga012   #總月預扣差額
   DEFINE l_sale                  LIKE type_t.num20_6   #銷售金額
   DEFINE l_sale_amount           LIKE type_t.num20_6   #銷售總金額   
   DEFINE l_acc_start             LIKE type_t.dat       #結算起始日
   DEFINE l_acc_end               LIKE type_t.dat       #結算結束日
   DEFINE l_pdate_s               LIKE type_t.dat       #會計期間開始日期 
   #150805-00003#36 150915 by lori add---(E)            
   DEFINE l_pdate_e        LIKE type_t.dat              #會計期間結束日期
   DEFINE l_no_part_days   LIKE type_t.num5             #不參與保底的銷售天數
   DEFINE l_withholding    LIKE debc_t.debc016          #本次月預扣金額
   DEFINE l_stga002        LIKE stga_t.stga002,
          l_stga008        LIKE stga_t.stga008,
          l_stga009        LIKE stga_t.stga009,
          l_stga011        LIKE stga_t.stga011,
          l_stga012        LIKE stga_t.stga012,         #150805-00003#36 150915 by lori add
          l_stga013        LIKE stga_t.stga013,
          l_stga015        LIKE stga_t.stga015,
          l_stgadocno      LIKE stga_t.stgadocno,
          l_stga016        LIKE stga_t.stga016,         #150914-00002#45 151103 by lori add
          l_stga017        LIKE stga_t.stga017          #150914-00002#45 151103 by lori add   
   DEFINE l_ooef016        LIKE ooef_t.ooef016          #150914-00002#42 2015/10/28 s983961--add
   DEFINE l_cnt            LIKE type_t.num5             #150914-00002#45 151103 by lori add
   DEFINE l_cost_amount    LIKE stga_t.stga012          #150914-00002#45 151103 by lori add
   DEFINE l_stga008_amount        LIKE stga_t.stga008          #150914-00002#53 151231 by lori add
   DEFINE l_stga009_amount        LIKE stga_t.stga009          #150914-00002#53 151231 by lori add
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   
   LET l_stga002 = ' '
  #LET l_stga008 = 0
  #LET l_stga009 = 0
  #LET l_stga011 = 0       #150914-00002#45 151103 by lori mark
   LET l_stga013 = '4'
   LET l_stga015 = 'N'
  #LET l_stgadocno = ' '   #150805-00003#36 150922 by lori mark
   LET l_stga016 = ''      #150914-00002#45 151103 by lori add
   LET l_stga017 = ''      #150914-00002#45 151103 by lori add
   
   #150805-00003#36 150915 by lori mark---(S)
   #LET l_sql = #門店日結
   #            "SELECT debcsite,debc010,debc005_par,stfa001,stfeseq, ",            #組織,專櫃,常規庫區,合約編號,保底項次
   #            "       stfe002, stfe006,stfe008,    stfe009,stfe012, ",            #保底方案,保底計算方式,保底開始日,保底結束日,月預扣方式
   #            "       stff008, stae006,mhae006,    stfe003,stfe004, ",            #執行扣率,價款類別,供應商,費用,保底方式
   #            "       stff006, ",                                                 #保底截止金額
   #            "       COALESCE(SUM(COALESCE(debc013,0)),0), ",                    #銷售數量
   #            "       COALESCE( ",                                                #銷售金額
   #            "         SUM( ",
   #            "           COALESCE( ",
   #            "             (CASE WHEN receivable_flag = 'Y' THEN debc016 ",      #150805-00003#41 150831 by lori debc018改取debc016 
   #            "                    ELSE debc020 END) ",
   #            "                   ,0) ",
   #            "            ),0), ",
   #            "      '' ",                                                        #實收金額(此不給值,用於保底方式=毛利率時計算)             
   #            " FROM astp504_debc t1,astp504_contract t2 ",
   #            "WHERE t1.debcsite = t2.stfasite ",                                     #組織
   #            "  AND t1.debc010 = t2.stfa005 ",                                       #專櫃
   #            "  AND t1.debc005_par = t2.stff005 ",                                   #庫區
   #            "  AND t1.debc002 BETWEEN stfe008 ",                                    #日期
   #            "                     AND COALESCE(stfe009, ",
   #            "                                  (SELECT pdate_e FROM astp504_org ",
   #            "                                    WHERE ooef001 = debcsite)) ",                 
   #            "  AND (t1.inaa135 = '1' ",                                             #常規庫區
   #            "    OR( t1.inaa135 = '2' ",                                            #促銷庫區且是參與合同保底
   #            "        AND EXISTS (SELECT 1 FROM astp504_promotions t3 ",
   #            "                     WHERE t3.stfa001 = t2.stfa001 ",
   #            "                       AND t3.prei003_par = t2.stff005) ",
   #            "      )) ",               
   #            "  AND t1.counter_acc = 'N' ",                                      #未有結轉的專櫃
   #            "  AND t2.stfe004 IN('2','3','4') ",                                #保底方式               
   #            "GROUP BY debcsite,debc010,debc005_par,stfa001,stfeseq, ",
   #            "         stfe002, stfe006,stfe008,    stfe009,stfe012, ",
   #            "         stff008, stae006,mhae006,    stfe003,stfe004, ",
   #            "         stfe007, stff006 ",              
   #            ###
   #            "UNION ",
   #            #專櫃促銷-毛利額/毛利率
   #            "SELECT stggsite,stgg003,stgg002_par,stfa001,stfeseq, ",            #組織,專櫃,常規庫區,合約編號,保底項次
   #            "       stfe002, stfe006,stfe008,    stfe009,stfe012, ",            #保底方案,保底計算方式,保底開始日,保底結束日,月預扣方式
   #            "       stff008, stae006,stgg004,    stfe003,stfe004, ",            #執行扣率,價款類別,供應商,費用,保底方式
   #            "       stff006, ",                                                 #保底截止金額                
   #            "       0, ",                                                       #銷售數量
   #            "       (CASE ",                                                    
   #            "           WHEN stfe004 = '5' ",                                 
   #            "              THEN COALESCE(SUM(COALESCE(stgg008,0)),0) ",         #實收毛利額 
   #            "           WHEN stfe004 = '6' ",
   #            "              THEN COALESCE(SUM(COALESCE(stgg008,0)),0) ",         #實收毛利率
   #            "                  /COALESCE(SUM(COALESCE(stgg007,0)),0)*100 ",      
   #            "         END), ",
   #            "       COALESCE(SUM(COALESCE(stgg007,0)),0) ",                     #實收金額               
   #            " FROM astp504_stgg t1,astp504_contract t2 ",
   #            "WHERE t1.stggsite = t2.stfasite ",                                     #組織
   #            "  AND t1.stgg003 = t2.stfa005 ",                                       #專櫃
   #            "  AND t1.stgg002_par = t2.stff005 ",                                   #庫區
   #            "  AND t1.stgg001 BETWEEN stfe008 ",                                    #日期
   #            "                     AND COALESCE(stfe009, ",
   #            "                                  (SELECT pdate_e FROM astp504_org ",
   #            "                                    WHERE ooef001 = debcsite)) ",                 
   #            "  AND (t1.inaa102 = '1' ",                                             #常規庫區
   #            "    OR( t1.inaa102 = '2' ",                                            #促銷庫區且是參與合同保底
   #            "        AND EXISTS (SELECT 1 FROM astp504_promotions t3 ",
   #            "                     WHERE t3.stfa001 = t2.stfa001 ",
   #            "                       AND t3.prei003_par = t2.stff005) ",
   #            "      )) ",               
   #            "  AND t1.counter_acc = 'N' ",                                      #未有結轉的專櫃 
   #            "  AND t2.stfe004 IN ('5','6') ",                                   #保底方式 
   #            "GROUP BY stggsite,stgg003,stgg002_par,stfa001,stfeseq, ",
   #            "         stfe002, stfe006,stfe008,    stfe009,stfe012, ",
   #            "         stff008, stae006,stgg004,    stfe003,stfe004, ",
   #            "         stfe007, stff006 "                         
   #LET l_sql = cl_sql_add_mask(l_sql)
   #PREPARE astp504_process_pre2 FROM l_sql
   #DECLARE astp504_process_cur2 CURSOR FOR astp504_process_pre2
   #DISPLAY "[astp504_process_pre2] SQL: ",l_sql
   #
   #IF lc_param.l_del = 'Y' THEN
   #   #SQL-刪除已結算過資料
   #   EXECUTE astp504_del_stga
   #   DISPLAY "[astp504_del_stga(1)] CNT: ",SQLCA.sqlerrd[3]
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "Delete stga_t"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err() 
   #   
   #      LET l_err_cnt = l_err_cnt + 1
   #   END IF   
   #END IF
   #
   #DISPLAY "astp505 process star:",cl_get_current()
   #FOREACH astp504_process_cur2 INTO l_debcsite,l_debc010,l_debc005,l_stfa001,l_stfeseq, 
   #                                  l_stfe002, l_stfe006,l_stfe008,l_stfe009,l_stfe012, 
   #                                  l_stff008, l_stae006,l_mhae006,l_stfe003,l_stfe004, 
   #                                  l_stff006, l_debc013,l_debc016,l_stgg007              #150805-00003#41 150831 by lori debc018改名debc016   
   #                                   
   #   #是否為保底結算月
   #   LET l_pdate_e = ''   
   #   SELECT UNIQUE pdate_e INTO l_pdate_e
   #     FROM adep504_org
   #    WHERE ooef001 = l_debcsite
   #   
   #   LET l_pdate_ym = YEAR(l_pdate_e) || MONTH(l_pdate_e)
   #   LET l_stfe008_ym = YEAR(l_stfe008) || MONTH(l_stfe008) 
   #   LET l_stfe009_ym = YEAR(l_stfe009) || MONTH(l_stfe009) 
   #         
   #   IF l_stfe006 <> '1' THEN
   #      IF cl_null(l_pdate_ym) OR l_pdate_ym <= l_stfe009_ym THEN
   #         CONTINUE FOREACH
   #      END IF
   #   END IF
   #   
   #   #保底結算-變數初始化
   #   INITIALIZE l_stga.* TO NULL
   #   LET l_mon = ''
   #   LET l_pdate_e = ''
   #   LET l_withholding = ''
   #   
   #   LET l_stga.stgaent   = g_enterprise  #企業編號
   #   LET l_stga.stgasite  = l_debcsite    #營運組織
   #   LET l_stga.stgaunit  = l_debcsite    #應用組織
   #   
   #   #銷售日期      
   #   IF l_pdate_e > l_stfe009 THEN
   #      LET l_stga.stga001 = l_stfe009   
   #   ELSE
   #      LET l_stga.stga001 = l_pdate_e       
   #   END IF
   #   
   #   LET l_stga.stga002   = l_stga002      #商品編號
   #   LET l_stga.stga003   = l_debc005      #庫區編號
   #   LET l_stga.stga004   = l_debc010      #專櫃編號
   #   LET l_stga.stga005   = l_mhae006      #供應商編號
   #   LET l_stga.stga006   = l_stfe003      #費用編號
   #   LET l_stga.stga007   = l_debc013      #銷售數量
   #   LET l_stga.stga008   = l_stga008      #應收金額
   #   LET l_stga.stga009   = l_stga009      #實收金額
   #   
   #   #費率
   #   CASE l_stfe004
   #      WHEN '2'  #普通各自保
   #         LET l_stga.stga010   = l_stff008   
   #      WHEN '3'  #各自扣率聯合保
   #         LET l_stga.stga010   = l_stff008   
   #      WHEN '4'  #按高扣率聯合保
   #         SELECT MAX(stff008) 
   #           INTO l_stga.stga010
   #           FROM astp504_contract
   #          WHERE stfa001 = l_stfa001
   #            AND stfa002 = l_stfa002
   #            AND stfaseq = l_stfaseq 
   #      WHEN '5'  #按毛利額聯合保   
   #         LET l_stga.stga010   = l_stff008   
   #      WHEN '6'  #按毛利率聯合保  
   #         LET l_stga.stga010   = l_stff008            
   #   END CASE
   #   
   #   LET l_stga.stga011   = l_stga011      #費用金額
   #              
   #   #保底日期範圍已產生的月預扣金額
   #   LET l_withholding = 0
   #   SELECT COALESCE(SUM(COALESCE(stga012,0)),0)
   #     INTO l_withholding
   #     FROM stga_t
   #    WHERE stgaent = g_enterprise
   #      AND stgasite = l_debcsite
   #      AND stga001 BETWEEN l_stfe008 AND l_stfe009
   #      AND stga003 = l_debc005
   #      AND stga013 = '3'
   #      AND stga004 = l_debc010         
   #          
   #   
   #   #成本金額=保底成本差額
   #   #(1)銷售金額>=保底金額,保底成本差額=0-保底日期範圍已產生的月預扣金額
   #   #   銷售金額< 保底金額,保底成本差額=(銷售金額-保底金額)*執行扣率/100-保底日期範圍已產生的月預扣金額 
   #   #(2)實際毛利額>=保底毛利額,保底成本差額=0-保底日期範圍已產生的月預扣金額
   #   #   實際毛利額< 保底毛利額,保底成本差額=(實際毛利額-保底毛利額)*執行扣率/100-保底日期範圍已產生的月預扣金額
   #   #(3)實際毛利率>=保底毛利率,保底成本差額=0-保底日期範圍已產生的月預扣金額
   #   #   實際毛利率< 保底毛利率,保底成本差額=(實際毛利率-保底毛利率)*實收金額*執行扣率/100-保底日期範圍已產生的月預扣金額         
   #   IF l_debc016 >= l_stff006 THEN                                                                     #150805-00003#41 150831 by lori debc018改名debc016 
   #      LET l_stga.stga012 = 0 - l_withholding
   #   ELSE
   #      IF l_stfe004 <> '6' THEN
   #         LET l_stga.stga012 = ((l_debc016-l_stff006)*l_stga.stga010/100) - l_withholding              #150805-00003#41 150831 by lori debc018改名debc016 
   #      ELSE
   #         LET l_stga.stga012 = ((l_debc016-l_stff006)*l_stgg007*l_stga.stga010/100) - l_withholding    #150805-00003#41 150831 by lori debc018改名debc016 
   #      END IF   
   #   END IF      
   #   
   #   LET l_stga.stga013   = l_stga013      #日結成本類別 
   #   LET l_stga.stga014   = l_stae006      #價款類型
   #   LET l_stga.stga015   = l_stga015      #已結轉否
   #   LET l_stga.stgadocno = l_stgadocno    #來源單號
   #      
   #   EXECUTE astp504_stga_ins USING l_stga.stgaent  ,l_stga.stgasite ,l_stga.stgaunit ,l_stga.stga001  ,l_stga.stga002  ,
   #                                  l_stga.stga003  ,l_stga.stga004  ,l_stga.stga005  ,l_stga.stga006  ,l_stga.stga007  ,
   #                                  l_stga.stga008  ,l_stga.stga009  ,l_stga.stga010  ,l_stga.stga011  ,l_stga.stga012  ,
   #                                  l_stga.stga013  ,l_stga.stga014  ,l_stga.stga015  ,l_stga.stgadocno                          
   #   DISPLAY "[astp504_stga_ins(2)] CNT: ",SQLCA.sqlerrd[3]  
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "Insert stga_t"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err() 
   #   
   #      LET l_err_cnt = l_err_cnt + 1
   #   END IF       
   #END FOREACH  
   #DISPLAY "astp505 process end:",cl_get_current()
   #150805-00003#36 150915 by lori mark---(E)astp504_acc_tmp_sel_cur1
   
   INITIALIZE l_acc.* TO NULL   #161201-00043#1 161201 by lori add
   #150805-00003#36 150915 by lori add---(S)
   FOREACH astp504_acc_tmp_sel_cur1 INTO l_acc.inaasite,l_acc.inaa120,l_acc.inaa141,        l_acc.stff001,l_acc.stfa010,   #營運據點,專櫃編號,對應常規庫區,專櫃合同編號,供應商編號
                                         l_acc.stae006, l_acc.stff008,l_acc.receivable_flag,l_pdate_s,    l_pdate_e,       #價款類別,會計日期起,會計日期迄,執行扣率,應收FLAG
                                         l_acc.stfeseq, l_acc.stfe002,l_acc.stfe003,        l_acc.stfe004,l_acc.stfe006,   #保底項次,保底方案編號,費用編號,保底方式,保底計算週期
                                         l_acc.stfe008, l_acc.stfe009,l_acc.stfe012,        l_acc.stff006                  #保底開始日期,保底截止日期,月預扣方式,保底目標金額
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Process_2 Error:astp504_acc_tmp_sel_cur1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      DISPLAY "Oracle Error Code: ",SQLCA.sqlerrd[2]
     #LET l_err_cnt = l_err_cnt + 1
   END IF 

      #150914-00002#45 151104 by lori add and mod---(S)
      IF lc_param.l_del = 'N' THEN
         #批次條件不刪除已存在條件,但資料已存在時,則提示訊息
         LET l_cnt = 0
         IF l_cnt >= 0 THEN
            #組織(%1)所屬的庫區：%2已存在方底方案：%3,日期：%4的專櫃保底資料，不進行重新計算。
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ast-00495'
            LET g_errparam.replace[1] = l_acc.inaasite
            LET g_errparam.replace[2] = l_acc.inaa141
            LET g_errparam.replace[3] = l_acc.stfe002 
            LET g_errparam.replace[4] = l_acc.stfe009
            LET g_errparam.popup = TRUE
            CALL cl_err() 
         
            CONTINUE FOREACH
         END IF      
      END IF
      #150914-00002#45 151104 by lori add---(E)

      LET l_acc_start      = ''    #結算起始日
      LET l_acc_end        = ''    #結算結束日
      LET l_no_part_days   = 0     #不參與保底的銷售天數
      LET l_withholding    = 0     #本次月預扣金額
      LET l_stga012_amount = 0     #總月預扣差額
      LET l_stff005        = ''    #150805-00003#36 150923 by lori add
      LET l_stff008        = 0
      LET l_sale           = 0
      LET l_sale_amount    = 0
      LET l_debc013_amount = 0                                                          
      LET l_debc016_amount = 0                                              
      LET l_debc020_amount = 0                                              
      LET l_stgg007_amount = 0 
      LET l_stgg008_amount = 0 
      LET l_stgg009_amount = 0 
      LET l_stgg010_amount = 0 
      LET l_stga008        = 0    #150914-00002#53 151231 by lori add
      LET l_stga009        = 0    #150914-00002#53 151231 by lori add
      LET l_stga008_amount = 0    #150914-00002#53 151231 by lori add 
      LET l_stga009_amount = 0    #150914-00002#53 151231 by lori add
      
      #取結算起始日&月預扣目標金額
      CASE l_acc.stfe012          
         WHEN '2'   #月平均  
            IF l_acc.stfe008 < l_pdate_s THEN
               LET l_acc_start = l_pdate_s
            ELSE
               LET l_acc_start = l_acc.stfe008
            END IF             
         WHEN '3'   #月累計              
            LET l_acc_start = l_acc.stfe008
      END CASE
      
      #取結算結束日
      IF l_acc.stfe009 < l_pdate_e THEN
         LET l_acc_end = l_acc.stfe009
      ELSE
         LET l_acc_end = l_pdate_e
      END IF
      
      #取得銷售資料-不參與促銷者&促銷且參與保底者
      EXECUTE astp504_acc_tmp_sel_pre4 USING l_acc.inaasite,l_acc.inaa120,l_acc.inaa141,l_acc.stff001,l_acc.stfe003,
                                             l_acc.stae006,l_acc.stfe008,l_acc.stfe009
                                        INTO l_acc.debc013,l_acc.debc016,l_acc.debc020
      #取得銷售資料-不排除不參與保底者
      IF l_acc.stfe004 MATCHES "[56]" THEN   
         EXECUTE astp504_acc_tmp_sel_pre9 USING l_acc.inaasite,l_acc.inaa141,l_acc.stfe008,l_acc.stfe009
                                           INTO l_acc.stgg007,l_acc.stgg008,l_acc.stgg009,l_acc.stgg010          
      END IF

      #150914-00002#53 151231 by lori add---(S)
      #取得日結類型=22的實收與應收金額
      EXECUTE astp504_acc_tmp_sel_pre13 USING l_acc.inaasite,l_acc_start,l_acc_end,l_acc.inaa141,l_acc.inaa120
                                          INTO l_stga008,l_stga009   

      EXECUTE astp504_acc_tmp_sel_pre13 USING l_acc.inaasite,l_acc_start,l_acc_end,l_acc.inaa120
                                          INTO l_stga008_amount,l_stga009_amount  
      #150914-00002#53 151231 by lori add---(E)
      
      #3.各自扣率聯合保/4.按高扣率聯合保時需取得總銷售金額
      CASE
         WHEN l_acc.stfe004 MATCHES "[34]"
            #取得銷售資料-同專櫃同方案的總銷售金額
            EXECUTE astp504_acc_tmp_sel_pre5 USING l_acc.inaasite,l_acc.inaa120,l_acc.stfeseq,l_acc.stfe002,l_acc.stfe008,l_acc.stfe009
                                              INTO l_debc016_amount,l_debc020_amount
         
         WHEN l_acc.stfe004 MATCHES "[56]"          
            EXECUTE astp504_acc_tmp_sel_pre11 USING l_acc.inaasite,l_acc.inaa120,l_acc.stfeseq,l_acc.stfe002,l_acc.stfe008,l_acc.stfe009
                                               INTO l_stgg007_amount,l_stgg008_amount,l_stgg009_amount,l_stgg010_amount   
                                           
      END CASE
      
      #取得銷售資料-促銷且不參與保底的天數
      EXECUTE astp504_acc_tmp_sel_pre6 USING l_acc.inaasite,l_acc.inaa141,l_acc.stfe008,l_acc.stfe009
                                        INTO l_no_part_days
                                        
      #取得費率
      #IF   保底方式=4.按高扣率聯合保 THEN 取最高扣率
      #ELSE 保底方式=2.普通各自保/3.各自扣率聯合保/5.按毛利額聯合保/6.按毛利率聯合保 THEN 取庫區本身的扣率
      IF l_acc.stfe004 = '4' THEN
         EXECUTE astp504_acc_tmp_sel_pre8 USING l_acc.stff001,l_acc.stfeseq,l_acc.stfe002
                                           INTO l_stff008     
         
         #150805-00003#36 150923 lori add---(S)
         #按高扣率聯合保只需按最高扣率的庫區寫入結算檔
         EXECUTE astp504_acc_tmp_sel_pre10 USING l_acc.stff001,l_acc.stfeseq,l_acc.stfe002,l_stff008
                                            INTO l_stff005             
         IF l_acc.inaa141 <> l_stff005 THEN
            CONTINUE FOREACH
         END IF
         #150805-00003#36 150923 lori add---(E)            
      ELSE
         LET l_stff008 = l_acc.stff008
      END IF 

      #銷售金額&總銷售金額
      CASE
         WHEN l_acc.stfe004 = '2' OR l_acc.stfe004 = '3' OR l_acc.stfe004 = '4'
            IF l_acc.receivable_flag = 'Y' THEN
              #原價金額
              #LET l_sale        = l_acc.debc016                         #150914-00002#53 151231 by lori mark
              #LET l_sale_amount = l_debc016_amount                      #150914-00002#53 151231 by lori mark
               LET l_sale        = l_acc.debc016 + l_stga008             #150914-00002#53 151231 by lori add
               LET l_sale_amount = l_debc016_amount + l_stga008_amount   #150914-00002#53 151231 by lori add            
            ELSE                                  
              #實收金額
              #LET l_sale        = l_acc.debc020                         #150914-00002#53 151231 by lori mark
              #LET l_sale_amount = l_debc020_amount                      #150914-00002#53 151231 by lori mark
               LET l_sale        = l_acc.debc020 + l_stga009             #150914-00002#53 151231 by lori add
               LET l_sale_amount = l_debc020_amount  + l_stga008_amount  #150914-00002#53 151231 by lori add
               END IF
            
         WHEN l_acc.stfe004 = '5'
            LET l_sale        = l_acc.stgg009
            LET l_sale_amount = l_stgg009_amount
            
         WHEN l_acc.stfe004 = '6'           
               LET l_sale        = l_acc.stgg008      #實收金額
               LET l_sale_amount = l_stgg008_amount   #總實收金額
      END CASE

      #保底日期範圍已產生的月預扣金額
      LET l_withholding = 0
      
      IF l_acc.stfe004 = '4' THEN
         #按高扣率聯合保,須加總整個專櫃中同方案的月預扣金額
         SELECT COALESCE(SUM(COALESCE(stga012,0)),0)
           INTO l_withholding
           FROM stga_t
          WHERE stgaent = g_enterprise
            AND stgasite = l_acc.inaasite
            AND stga001 BETWEEN l_acc.stfe008 AND l_acc.stfe009
            AND stga013 = '3'
            AND stgadocno = l_acc.stfe002    #來源單號=保底編號   #150805-00003#36 150922 lori add
            AND stga004 = l_acc.inaa120 
      ELSE
         #按高扣率聯合保,加總庫區的月預扣金額
         SELECT COALESCE(SUM(COALESCE(stga012,0)),0)
           INTO l_withholding
           FROM stga_t
          WHERE stgaent = g_enterprise
            AND stgasite = l_acc.inaasite
            AND stga001 BETWEEN l_acc.stfe008 AND l_acc.stfe009
            AND stga003 = l_acc.inaa141
            AND stga013 = '3'
            AND stgadocno = l_acc.stfe002    #來源單號=保底編號   #150805-00003#36 150922 lori add
            AND stga004 = l_acc.inaa120       
      END IF
      
      IF cl_null(l_withholding) THEN
         LET l_withholding = 0 
      END IF
      
      #保底金額=保底目標/保底方案總天數*參與保底天數  (註:須排除不參與保底的天數,毛利額無須排除不保底天數)
      CASE
         WHEN l_acc.stfe004 MATCHES "[234]"
            LET l_acc.stff006 = (l_acc.stff006/(l_acc.stfe009-l_acc.stfe008+1))*((l_acc.stfe009-l_acc.stfe008+1)-l_no_part_days)
         
        #WHEN l_acc.stfe004 = '5'
        #   LET l_acc.stff006 = l_acc.stff006  
        
        #WHEN l_acc.stfe004 = '6' 
        #   LET l_acc.stff006 = l_acc.stff006/100
            
      END CASE
      
      #保底成本差額
      #保底方式 = 2/3/4, 判斷 銷售金額   >= 目標保底金額?
      #保底方式 = 5,     判斷 實際毛利額 >= 目標毛利額?
      #保底方式 = 6,     判斷 實際毛利率 >= 目標毛利率?
      
      #160516-00014#19 160808 by lori mark and add---(S)
      #IF (l_acc.stfe004 <> '6' AND l_sale >= l_acc.stff006)
      #  OR (l_acc.stfe004 ='6' AND l_stgg010_amount >= l_acc.stff006) THEN   
      IF (l_acc.stfe004 <> '5' AND l_acc.stfe004 <> '6' AND l_sale >= l_acc.stff006)
        OR (l_acc.stfe004 ='5' AND l_stgg009_amount >= l_acc.stff006) 
        OR (l_acc.stfe004 ='6' AND l_stgg010_amount >= l_acc.stff006) THEN 
      #160516-00014#19 160808 by lori mark and add---(E)        
         #保底成本差額=0-保底日期範圍已產生的月預扣金額
         LET l_stga012 = 0 - l_withholding
      ELSE
         CASE l_acc.stfe004
            WHEN '2'   #2.普通各自保         
               #銷售金額< 保底金額,保底成本差額=(銷售金額-保底金額)*執行扣率/100-保底日期範圍已產生的月預扣金額
               LET l_stga012 = ((l_sale-l_acc.stff006)*(l_stff008/100)) - l_withholding
               
            WHEN '3'   #3.各自扣率聯合保
               #銷售金額< 保底金額,保底成本差額=(專櫃總銷售金額-保底金額)*銷售佔比*執行扣率/100-保底日期範圍已產生的月預扣金額
               LET l_stga012 = ((l_sale_amount-l_acc.stff006)*(l_sale/l_sale_amount)*(l_stff008/100)) - l_withholding
               
            WHEN '4'   #4.按高扣率聯合保   
               #銷售金額< 保底金額,保底成本差額=(專櫃總銷售金額-保底金額)*執行扣率/100-保底日期範圍已產生的同專櫃同方案月預扣金額
               LET l_stga012 = ((l_sale_amount-l_acc.stff006)*(l_stff008/100)) - l_withholding
               
            WHEN '5'   #5.按毛利額聯合保
               #實際毛利額< 保底毛利額,保底成本差額=(實際毛利額-保底毛利額)*毛利佔比*執行扣率/100-保底日期範圍已產生的月預扣金額
              #LET l_stga012 = ((l_sale_amount-l_acc.stff006)*(l_sale/l_sale_amount)*(l_stff008/100)) - l_withholding      #160516-00014#19 160808 by lori mark 
               LET l_stga012 = ((l_stgg009_amount-l_acc.stff006)*(l_sale/l_sale_amount)*(l_stff008/100)) - l_withholding   #160516-00014#19 160808 by lori add
       
            WHEN '6'   #6.按毛利率聯合保 
               #實際毛利率< 保底毛利率,保底成本差額=(實際毛利率-保底毛利率)*專櫃總實收金額*銷售佔比*執行扣率/100
               LET l_stga012 = ((l_stgg010_amount-l_acc.stff006)/100)*l_sale_amount*(l_sale/l_sale_amount)*(l_stff008/100)  
         END CASE
         
         #150914-00002#45 151104 by lori add---(S)
         IF l_acc.stfe004 MATCHES '[56]' THEN
            LET l_cost_amount = 0
            EXECUTE astp504_sel_stga USING l_acc.inaasite,l_acc.stfe008,l_acc.stfe009,l_stga002,l_acc.inaa141,      #營運組織,保底起始日,保底結束日,商品編號,庫區編號
                                            l_stga013,l_acc.stfe002                                                 #日結成本類型,來源單號  
                                      INTO l_cost_amount
                                      
            IF cl_null(l_cost_amount) THEN
               LET l_cost_amount = 0
            END IF
            
            LET l_stga012 = l_stga012 - l_cost_amount    
         END IF            
         #150914-00002#45 151104 by lori add---(E)         
      END IF 

      #150914-00002#42 2015/10/29 s983961--add(s)
      #按當前幣別截取aooi150裡的用戶設置小數位 處理金額欄位
      SELECT ooef016 
        INTO l_ooef016
        FROM ooef_t 
       WHERE ooefent = g_enterprise 
         AND ooef001 = l_stga.stgasite
      
      IF NOT cl_null(l_ooef016) THEN      
         IF NOT cl_null(l_stga.stga008) AND l_stga.stga008 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga008,'2') RETURNING l_stga.stga008
         END IF
         
         IF NOT cl_null(l_stga.stga009) AND l_stga.stga009 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga009,'2') RETURNING l_stga.stga009
         END IF
         
         IF NOT cl_null(l_stga.stga011) AND l_stga.stga011 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga011,'2') RETURNING l_stga.stga011
         END IF
         
         IF NOT cl_null(l_stga.stga012) AND l_stga.stga012 <> 0 THEN
            CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga012,'2') RETURNING l_stga.stga012
         END IF   
      END IF
      #150914-00002#42 2015/10/29 s983961--add(e)
      
      #150805-00003#36 150924 by lori add---(S)
      #保底差額=0者不需寫入
      IF cl_null(l_stga012) OR l_stga012 = 0 THEN
         CONTINUE FOREACH
      END IF
      #150805-00003#36 150924 by lori add---(E)
      
      #保底結算-變數初始化
      INITIALIZE l_stga.* TO NULL
      
      LET l_stga.stgaent   = g_enterprise      #企業編號
      LET l_stga.stgasite  = l_acc.inaasite    #營運組織
      LET l_stga.stgaunit  = l_acc.inaasite    #應用組織
      LET l_stga.stga001   = l_acc.stfe009     #銷售日期
      LET l_stga.stga002   = l_stga002         #商品編號
      LET l_stga.stga003   = l_acc.inaa141     #庫區編號
      LET l_stga.stga004   = l_acc.inaa120     #專櫃編號
      LET l_stga.stga005   = l_acc.stfa010     #供應商編號
      LET l_stga.stga006   = l_acc.stfe003     #費用編號
      LET l_stga.stga007   = l_acc.debc013     #銷售數量
      LET l_stga.stga008   = l_stga008         #應收金額
      LET l_stga.stga009   = l_stga009         #實收金額
      LET l_stga.stga010   = l_stff008         #費率
     #LET l_stga.stga011   = l_stga011         #費用金額           #150914-00002#45 151103 by lori mark
      LET l_stga.stga011   = l_stga012*(-1)                       #150914-00002#45 151103 by lori add
      LET  l_stga.stga012  = l_stga012         #成本金額=保底成本差額 
      LET l_stga.stga013   = l_stga013         #日結成本類別 
      LET l_stga.stga014   = l_acc.stae006     #價款類型
      LET l_stga.stga015   = l_stga015         #已結轉否
      LET l_stga.stgadocno = l_acc.stfe002     #來源單號=保底編號   #150805-00003#36 150922 lori add
      LET l_stga.stga016   = l_stga016         #銷售單號           #150914-00002#45 151103 by lori add
      LET l_stga.stga017   = l_stga017         #銷售項次           #150914-00002#45 151103 by lori add

      EXECUTE astp504_stga_ins USING l_stga.stgaent  ,l_stga.stgasite ,l_stga.stgaunit ,l_stga.stga001  ,l_stga.stga002  ,
                                     l_stga.stga003  ,l_stga.stga004  ,l_stga.stga005  ,l_stga.stga006  ,l_stga.stga007  ,
                                     l_stga.stga008  ,l_stga.stga009  ,l_stga.stga010  ,l_stga.stga011  ,l_stga.stga012  ,
                                     l_stga.stga013  ,l_stga.stga014  ,l_stga.stga015  ,l_stga.stgadocno,l_stga.stga016  ,   #150914-00002#45 151103 by lori add stga016
                                     l_stga.stga017                                                                          #150914-00002#45 151103 by lori add stga017                                     
      DISPLAY "[astp504_stga_ins(2)] CNT: ",SQLCA.sqlerrd[3]  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert stga_t"
         LET g_errparam.popup = TRUE
         CALL cl_err() 
      
         LET l_err_cnt = l_err_cnt + 1
      END IF
      
      DISPLAY "-----------------------------------------------------------------------------------------------"
      DISPLAY "組織: ",l_acc.inaasite," 專櫃: ",l_acc.inaa120," 庫區: ",l_acc.inaa141," 合同: ",l_acc.stff001," 費用(原價否): ",l_acc.stfe003,"(",l_acc.receivable_flag,")"
      DISPLAY "    保底方案      : ",l_acc.stfe002," 保底方式: ",l_acc.stfe004," 保底起訖: ",l_acc.stfe008,"~",l_acc.stfe009
      DISPLAY "    保底目標      : ",l_acc.stff006," (費率: ",l_stga.stga010,") 本次應保底天數: ",l_acc.stfe009-l_acc.stfe008+1," 不保底天數: ",l_no_part_days
      DISPLAY "    已產月預扣金額: ",l_withholding
      DISPLAY "    銷售金額      : ",l_sale
      DISPLAY "    方案總銷售金額: ",l_sale_amount   
      DISPLAY "    實際總毛利額    :",l_stgg010_amount
      DISPLAY "    實際毛利率    : ",l_stgg010_amount
      DISPLAY "    保底金額差額  : ",l_stga012         
      DISPLAY "-----------------------------------------------------------------------------------------------"   
      
      INITIALIZE l_acc.* TO NULL   #161201-00043#1 161201 by lori add
   END FOREACH   
   #150805-00003#36 150915 by lori add---(E)
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 當月預扣方示為月累計時,取得當前統計月是累計第幾月
# Memo...........:
# Usage..........: CALL astp504_get_withholding_mon(p_org,p_sdate,p_edate)
#                  RETURNING r_mon
# Input Parameter: p_org          組織編號
#                  p_sdate        起始日
#                  p_edate        結束日
# Return code....: r_mon          累計第幾月
# Date & Author..: 2015/07/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp504_get_withholding_mon(p_org,p_sdate,p_edate)
   DEFINE p_org          LIKE ooef_t.ooef001
   DEFINE p_sdate        LIKE type_t.dat
   DEFINE p_edate        LIKE type_t.dat
   DEFINE r_mon          LIKE type_t.num5
   DEFINE l_acc_mon      LIKE type_t.num5
   DEFINE l_acc_period   LIKE type_t.num5
   
   LET r_mon = ''
   LET l_acc_mon = ''
   
   SELECT acc_mon INTO l_acc_mon
     FROM astp504_org           
    WHERE ooef001 = p_org

   CASE
      WHEN MONTH(p_sdate) = l_acc_mon
         LET r_mon = 1
      WHEN MONTH(p_sdate) < l_acc_mon  
         LET r_mon = l_acc_mon - MONTH(p_sdate) + 1      
   END CASE
   
   RETURN r_mon
END FUNCTION

#end add-point
 
{</section>}
 
