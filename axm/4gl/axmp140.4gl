#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp140.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2015-09-01 11:44:22), PR版次:0016(2017-04-21 18:47:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000127
#+ Filename...: axmp140
#+ Description: 信用評核重新計算作業
#+ Creator....: 02040(2014-04-30 13:34:37)
#+ Modifier...: 02040 -SD/PR- TOPSTD
 
{</section>}
 
{<section id="axmp140.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151125-00014#1  2015/11/26 By 02040  判斷額度幣別、額度客戶不一致時，要更新信用額度異動檔(條件調整)
#150708-00007#1  2016/06/21 By 02097  修改背景處理程式段
#160903-00001#1  2016/09/05 By 02040  調整當不計算此項目時，EXIT FOREACH 改為CONTINUE FOREACH，讓其它項目也能計算到
#160909-00080#1  2016/09/13 By 02097  修改開窗
#160922-00029#1  2016/09/22 By 02040  交易對象和額度對象不一致時，需重新抓取額度客戶的信用額度資料
#160926-00001#1  2016/09/26 By 02040  信用額度重算時，項目的異動類型不一致時，需更新信用額度異動檔
#160810-00026#1  2016/09/29 By Sarah  效能優化
#160906-00029#1  2017/03/07 By fion   調整取匯率改用s_credit_get_exrate
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
        #150930-00021#1 20151001 mark by beckxie---S
        #y          LIKE  type_t.num5,
        #p          LIKE  type_t.num5,
        #150930-00021#1 20151001 mark by beckxie---E
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pmab003 LIKE pmab_t.pmab003, 
   pmab004 LIKE pmab_t.pmab004, 
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
 
{<section id="axmp140.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #150930-00021#1 20151001 mark by beckxie---S
   #LET lc_param.y = g_argv[1]
   #LET lc_param.p = g_argv[2]
   #LET g_master.wc = g_argv[3]
   #LET ls_js = util.JSON.stringify(lc_param) 
   #150930-00021#1 20151001 mark by beckxie---E
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axmp140_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp140 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmp140_init()
 
      #進入選單 Menu (="N")
      CALL axmp140_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp140
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp140.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmp140_init()
 
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
 
{<section id="axmp140.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp140_ui_dialog()
 
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
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmab003,pmab004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               CALL cl_qbe_init()

               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab003
            #add-point:ON ACTION controlp INFIELD pmab003 name="construct.c.pmab003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE               
           #CALL q_pmaa001()                         #160909-00080#1 mark
            CALL q_pmaa001_4()                       #160909-00080#1
            DISPLAY g_qryparam.return1 TO pmab003    #顯示到畫面上
            NEXT FIELD pmab003                       #返回原欄位  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab003
            #add-point:BEFORE FIELD pmab003 name="construct.b.pmab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab003
            
            #add-point:AFTER FIELD pmab003 name="construct.a.pmab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab004
            #add-point:ON ACTION controlp INFIELD pmab004 name="construct.c.pmab004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '296'
            CALL q_oocq002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab004    #顯示到畫面上
            NEXT FIELD pmab004                       #返回原欄位        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab004
            #add-point:BEFORE FIELD pmab004 name="construct.b.pmab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab004
            
            #add-point:AFTER FIELD pmab004 name="construct.a.pmab004"
            
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
            CALL axmp140_get_buffer(l_dialog)
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
         CALL axmp140_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF    
      IF g_master.wc = ' 1=1' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00379'
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CONTINUE WHILE
      ELSE
         LET g_bgjob = "N"      
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
                 CALL axmp140_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmp140_transfer_argv(ls_js)
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
 
{<section id="axmp140.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmp140_transfer_argv(ls_js)
 
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
 
{<section id="axmp140.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmp140_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_value    STRING
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING                       #160810-00026#1 add
   DEFINE l_msg       STRING                       #160810-00026#1 add
   DEFINE l_amount    LIKE xmab_t.xmab009
   DEFINE l_pmab  RECORD
       pmabsite   LIKE pmab_t.pmabsite,            #營運據點
       pmab001    LIKE pmab_t.pmab001,             #交易對象編號
       pmab003    LIKE pmab_t.pmab003,             #額度交易對象
       pmab004    LIKE pmab_t.pmab004,             #信用評核等級
       pmab005    LIKE pmab_t.pmab005,             #額度計算幣別
       pmab006    LIKE pmab_t.pmab006              #企業額度
              END RECORD
   DEFINE l_xmab  RECORD
       xmab001    LIKE xmab_t.xmab001,             #計算項目
       xmab002    LIKE xmab_t.xmab002,             #異動類型
       xmab007    LIKE xmab_t.xmab007,             #交易幣別
       xmab009    LIKE xmab_t.xmab009,             #交易含稅金額
       xmab010    LIKE xmab_t.xmab010,             #已沖銷金額
       xmab013    LIKE xmab_t.xmab013,             #據點匯率
       xmab020    LIKE xmab_t.xmab020              #集團匯率
              END RECORD
   DEFINE l_xmac  RECORD
       xmac011    LIKE xmac_t.xmac011,             #訂單未出貨金額
       xmac012    LIKE xmac_t.xmac012,             #出通單金額
       xmac013    LIKE xmac_t.xmac013,             #出貨未開發票金額
       xmac014    LIKE xmac_t.xmac014,             #銷退折讓金額
       xmac015    LIKE xmac_t.xmac015,             #發票應收帳款
       xmac016    LIKE xmac_t.xmac016,             #未兌現應收票據金額
       xmac017    LIKE xmac_t.xmac017,             #已沖帳未確認金額
       xmac018    LIKE xmac_t.xmac018,             #LC收狀金額
       xmac019    LIKE xmac_t.xmac019,             #待抵帳款金額
       xmac041    LIKE xmac_t.xmac041,             #採購未收貨金額
       xmac042    LIKE xmac_t.xmac042,             #收貨未入庫金額
       xmac043    LIKE xmac_t.xmac043,             #入庫未立應付金額
       xmac044    LIKE xmac_t.xmac044,             #倉退金額
       xmac045    LIKE xmac_t.xmac045,             #發票應付金額
       xmac046    LIKE xmac_t.xmac046,             #應付待抵金額
       xmac047    LIKE xmac_t.xmac047,             #已沖帳金額
       xmac048    LIKE xmac_t.xmac048              #未兌現應付票據金額       
              END RECORD
DEFINE l_xmab005    LIKE xmab_t.xmab005
DEFINE l_xmab007    LIKE xmab_t.xmab007
DEFINE l_xmab012    LIKE xmab_t.xmab012
DEFINE l_xmab013    LIKE xmab_t.xmab013
DEFINE l_para_id    LIKE ooab_t.ooab001           #160810-00026#1 add
DEFINE l_para_data  LIKE type_t.chr80
DEFINE l_exchange   LIKE xmab_t.xmab013
DEFINE l_pmabsite   LIKE pmab_t.pmabsite          #151016 polly add
DEFINE l_pmab003    LIKE pmab_t.pmab003           #151016 polly add
DEFINE l_xmaa002    LIKE xmaa_t.xmaa002           #160926-00001#1 add
DEFINE l_xmaa004    LIKE xmaa_t.xmaa004           #160926-00001#1 add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET li_stus = TRUE
   LET l_success = TRUE
   LET li_p01_status = TRUE #150708-00007#1
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET ls_sql = "SELECT COUNT(1) ",   #160810-00026#1 mod COUNT(*)->COUNT(1)
                   "  FROM pmab_t ",
                   " WHERE pmabent = ",g_enterprise,
                   "   AND pmab002 NOT IN ('1','4') ",
                   #"   AND ",g_master.wc   #150930-00021#1 20151002 mark by beckxie
                   "    AND ",lc_param.wc   #150930-00021#1 20151002  add by beckxie
      PREPARE axmp140_process_count FROM ls_sql
      LET li_count = 0
      EXECUTE axmp140_process_count INTO li_count
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axmp140_process_cs CURSOR FROM ls_sql
#  FOREACH axmp140_process_cs INTO
   #add-point:process段process name="process.process"

   LET l_sql = " SELECT COUNT(1) ",   #160810-00026#1 mod COUNT(*)->COUNT(1)
               "   FROM xmaa_t ",
              #"  WHERE xmaaent = '",g_enterprise,"'",   #160901-00068#1
               "  WHERE xmaaent = ? ",        #160901-00068#1   #160810-00026#1 mod g_enterprise->?
               "    AND xmaa001 = ? ",
               "    AND xmaa002 = ? "
   PREPARE axmp140_process_sel_xmaa_count FROM l_sql
   
   #--151016--polly--add--(s)
   LET l_sql = "SELECT DISTINCT pmabsite,pmab003",
               "   FROM pmab_t ",
               "  WHERE pmabent = ",g_enterprise,
               "    AND pmab002 NOT IN ('1','4') ",
               "    AND ",lc_param.wc,
               "  ORDER BY pmab003 "               
   PREPARE axmp140_process_sel_pmab003_pr FROM l_sql
   DECLARE axmp140_process_sel_pmab003_cs CURSOR FOR axmp140_process_sel_pmab003_pr   
   #--151016--polly--add--(e)

   #160922-00029#1-s-add
    LET l_sql = "SELECT pmab004,pmab005,pmab006 ",
                "  FROM pmab_t ",
                " WHERE pmabent = ?",   #160810-00026#1 mod g_enterprise->?
                "   AND pmabsite = ? ",
                "   AND pmab001 = ? "
    PREPARE axmp140_pmab001_pre FROM l_sql            
   #160922-00029#1-e-add
   
   #160926-00001#1-s-add
    LET l_sql = "SELECT xmaa002,xmaa004 FROM xmaa_t ",
                " WHERE xmaaent = ?",   #160810-00026#1 mod g_enterprise->?
                "   AND xmaa001 = ? "
   PREPARE axmp140_xmaa_pr FROM l_sql
   DECLARE axmp140_xmaa_cs CURSOR FOR axmp140_xmaa_pr                
   #160926-00001#1-e-add

   #依據UI畫面的額度對象與信用評等QBE條件，且pmab002不等於'1:不查核'或'4:依據集團設置'
   #抓取符合條件的交易對象據點資料進行計算，並將相同額度對象與信用評等的資料放在一起計算
   LET l_sql = " SELECT pmabsite,pmab001,pmab003,pmab004,pmab005,pmab006 ",
               "   FROM pmab_t ",
               "  WHERE pmabent = ",g_enterprise,
               "    AND pmab002 NOT IN ('1','4') ",
              #"    AND ",g_master.wc,    #150930-00021#1 20151002 mark by beckxie
               "    AND ",lc_param.wc,    #150930-00021#1 20151002  add by beckxie
               "  ORDER BY pmab003,pmab004 "
   PREPARE axmp140_process_sel_pmab_pr FROM l_sql
   DECLARE axmp140_process_sel_pmab_cs CURSOR FOR axmp140_process_sel_pmab_pr

#160810-00026#1-s add
#效能考量,搬到FOREACH外

   LET l_sql = "SELECT ooab002 FROM ooab_t",
               " WHERE ooabent = ?",
               "   AND ooabsite = ?",
               "   AND ooab001 = ?"   
   PREPARE axmp140_sel_ooab002_pr FROM l_sql

   LET l_sql = "SELECT COUNT(1) ",
               "  FROM xmac_t ",
               " WHERE xmacent = ?",
               "   AND xmacsite = ?",
               "   AND xmac001 = ?"
   PREPARE axmp140_process_sel_xmac001_cnt_pr FROM l_sql   

   #取出所有符合條件的信用評核異動明細資料
   #依據相同的計算項目、異動類型與交易幣別對交易金額進行匯總
   LET l_sql = " SELECT xmab001,xmab002,xmab007,SUM(xmab009),SUM(xmab010),xmab013,xmab020",
               "   FROM xmab_t ",
               "  WHERE xmabent = ?",
               "    AND xmab006 = ?",
               "    AND xmab008 = ?",
               "    AND xmab017 = 'N' ",
               "    AND (xmab009 - xmab010) > 0 "
  #IF l_pmab.pmabsite <> 'ALL' THEN
   LET l_sql1 = l_sql," AND xmab005 = ?"
  #END IF
   LET l_sql = l_sql ," GROUP BY xmab001,xmab002,xmab007,xmab013,xmab020 "
   LET l_sql1= l_sql1," GROUP BY xmab001,xmab002,xmab007,xmab013,xmab020 "
   
   #沒過濾交易營運據點
   PREPARE axmp140_process_sel_xmab_pr FROM l_sql
   DECLARE axmp140_process_sel_xmab_cs CURSOR FOR axmp140_process_sel_xmab_pr
   
   #有過濾交易營運據點
   PREPARE axmp140_process_sel_xmab_pr1 FROM l_sql1
   DECLARE axmp140_process_sel_xmab_cs1 CURSOR FOR axmp140_process_sel_xmab_pr1

   #更新異動檔的匯率   
   LET l_sql = "SELECT DISTINCT xmab005,xmab007,xmab012 FROM xmab_t",
               "  WHERE xmabent = ?",
               "    AND xmab005 = ?",             #交易營運據點
               "    AND xmab008 = ?"
   PREPARE axmp140_sel_pmab005_pr FROM l_sql
   DECLARE axmp140_sel_pmab005_cs CURSOR FOR axmp140_sel_pmab005_pr
   
   #更新交易對像信用餘額檔：
   LET l_msg = cl_getmsg('axm-00547',g_lang)
   
   LET l_para_id = 'S-BAS-0013'
      
   LET l_sql = "INSERT INTO xmac_t (xmacent,xmacsite,xmac001,xmac011,xmac012,",
               "                    xmac013, xmac014,xmac015,xmac016,xmac017,",
               "                    xmac018, xmac019,xmac041,xmac042,xmac043,",
               "                    xmac044, xmac045,xmac046,xmac047,xmac048)",
               "            VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)"
   PREPARE axmp140_insert_xmac_prep FROM l_sql
   
   LET l_sql = "UPDATE xmac_t",
               "   SET xmac011 = ? , xmac012 = ? , xmac013 = ? , xmac014 = ? , xmac015 = ? ,",
               "       xmac016 = ? , xmac017 = ? , xmac018 = ? , xmac019 = ? ,",
               "       xmac041 = ? , xmac042 = ? , xmac043 = ? , xmac044 = ? , xmac045 = ? ,",
               "       xmac046 = ? , xmac047 = ? , xmac048 = ?",
               " WHERE xmacent = ?",
               "   AND xmacsite = ?",
               "   AND xmac001 = ?"
   PREPARE axmp140_update_xmac_prep FROM l_sql
   
   #更新異動檔的額度客戶
   LET l_sql = "UPDATE xmab_t",
               "   SET xmab008 = ?",
               " WHERE xmabent = ?",
               "   AND xmab005 = ?",
               "   AND xmab006 = ?"
   PREPARE axmp140_update_xmab008_prep FROM l_sql
   
   #更新異動檔的額度幣別   
   LET l_sql = "UPDATE xmab_t",
               "   SET xmab012 = ?",
               " WHERE xmabent = ?",
               "   AND xmab005 = ?",
               "   AND xmab008 = ?"
   PREPARE axmp140_update_xmab012_prep FROM l_sql
   
   LET l_sql = "UPDATE xmab_t",
               "   SET xmab013 = ?",
               " WHERE xmabent = ?",
               "   AND xmab008 = ?",
               "   AND xmab005 = ?",
               "   AND xmab007 = ?",
               "   AND xmab012 = ?"
   PREPARE axmp140_update_xmab013_prep FROM l_sql
   
   LET l_sql = "UPDATE xmab_t",
               "   SET xmab002 = ?",
               " WHERE xmabent = ?",
               "   AND xmab001 = ?",
               "   AND xmab008 = ?"
   PREPARE axmp140_update_xmab002_prep FROM l_sql

   LET l_sql = "SELECT COUNT(1) ",
               "  FROM xmab_t ",
               " WHERE xmabent = ?",
               "   AND xmab005 = ?",                        #交易營運據點
               "   AND xmab006 = ?",                        #交易客戶
               "   AND (xmab008 <> ? OR xmab008 IS NULL)"   #額度客戶
   PREPARE axmp140_process_sel_xmab_568cnt_pr1 FROM l_sql

   LET l_sql = "SELECT COUNT(1) ",
               "  FROM xmab_t ",
               " WHERE xmabent = ?",
               "   AND xmab005 = ?",          #交易營運據點
               "   AND xmab006 = ?",          #交易客戶
               "   AND xmab008 IS NOT NULL"   #額度客戶
   PREPARE axmp140_process_sel_xmab_568cnt_pr2 FROM l_sql


   LET l_sql = "SELECT COUNT(1) ",
               "  FROM xmab_t ",
               " WHERE xmabent = ?",
               "   AND xmab005 = ?",                        #交易營運據點
               "   AND xmab006 = ?",                        #交易客戶
               "   AND (xmab012 <> ? OR xmab012 IS NULL)"   #額度幣別
   PREPARE axmp140_process_sel_xmab_5612cnt_pr1 FROM l_sql

   LET l_sql = "SELECT COUNT(1) ",
               "  FROM xmab_t ",
               " WHERE xmabent = ?",
               "   AND xmab005 = ?",          #交易營運據點
               "   AND xmab006 = ?",          #交易客戶
               "   AND xmab012 IS NOT NULL"   #額度幣別
   PREPARE axmp140_process_sel_xmab_5612cnt_pr2 FROM l_sql

   LET l_sql = "SELECT COUNT(1) ",
               "  FROM xmac_t ",
               " WHERE xmacent = ?",
               "   AND xmacsite = ?",
               "   AND xmac001 = ?",
               "   AND xmac002 <> ?"
   PREPARE axmp140_process_sel_xmac_cnt_pr1 FROM l_sql

   #更新餘額檔的額度幣別
   LET l_sql = "UPDATE xmac_t",
               "   SET xmac002 = ?",
               " WHERE xmacent = ?",
               "   AND xmacsite = ?",
               "   AND xmac001 = ?",
               "   AND xmac002 <> ?"
   PREPARE axmp140_process_upd_xmac002_pr FROM l_sql


#160810-00026#1-e add

   
   #--151016--polly--add--(s)
   FOREACH axmp140_process_sel_pmab003_cs INTO l_pmabsite,l_pmab003   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axmp140_process_sel_pmab003_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      IF NOT l_success THEN
         LET li_stus = FALSE
         LET l_success = TRUE
      END IF   

      LET l_xmac.xmac011 = 0
      LET l_xmac.xmac012 = 0
      LET l_xmac.xmac013 = 0
      LET l_xmac.xmac014 = 0
      LET l_xmac.xmac015 = 0
      LET l_xmac.xmac016 = 0
      LET l_xmac.xmac017 = 0
      LET l_xmac.xmac018 = 0
      LET l_xmac.xmac019 = 0
      LET l_xmac.xmac041 = 0
      LET l_xmac.xmac042 = 0
      LET l_xmac.xmac043 = 0
      LET l_xmac.xmac044 = 0
      LET l_xmac.xmac045 = 0
      LET l_xmac.xmac046 = 0
      LET l_xmac.xmac047 = 0
      LET l_xmac.xmac048 = 0         

      LET l_cnt = 0
     #160810-00026#1-s mod
     #SELECT COUNT(*) INTO l_cnt
     #  FROM xmac_t
     # WHERE xmacent = g_enterprise
     #   AND xmacsite = l_pmabsite
     #   AND xmac001 = l_pmab003
      EXECUTE axmp140_process_sel_xmac001_cnt_pr USING g_enterprise,l_pmabsite,l_pmab003 INTO l_cnt
     #160810-00026#1-e mod
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
        #160810-00026#1-s mod
        #INSERT INTO xmac_t(xmacent,xmacsite,xmac001,xmac011,xmac012,
        #                   xmac013, xmac014,xmac015,xmac016,xmac017,
        #                   xmac018, xmac019,xmac041,xmac042,xmac043,
        #                   xmac044, xmac045,xmac046,xmac047,xmac048)
        #     VALUES(g_enterprise  ,l_pmabsite     ,l_pmab003     ,l_xmac.xmac011,l_xmac.xmac012,
        #            l_xmac.xmac013, l_xmac.xmac014,l_xmac.xmac015,l_xmac.xmac016,l_xmac.xmac017,
        #            l_xmac.xmac018, l_xmac.xmac019,l_xmac.xmac041,l_xmac.xmac042,l_xmac.xmac043,
        #            l_xmac.xmac044, l_xmac.xmac045,l_xmac.xmac046,l_xmac.xmac047,l_xmac.xmac048)
         EXECUTE axmp140_insert_xmac_prep
           USING g_enterprise  ,l_pmabsite     ,l_pmab003     ,l_xmac.xmac011,l_xmac.xmac012,
                 l_xmac.xmac013, l_xmac.xmac014,l_xmac.xmac015,l_xmac.xmac016,l_xmac.xmac017,
                 l_xmac.xmac018, l_xmac.xmac019,l_xmac.xmac041,l_xmac.xmac042,l_xmac.xmac043,
                 l_xmac.xmac044, l_xmac.xmac045,l_xmac.xmac046,l_xmac.xmac047,l_xmac.xmac048
        #160810-00026#1-e mod
         #160903-00001#1-s-add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'INS xmac_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF         
         #160903-00001#1-e-add
      ELSE
         #160810-00026#1-s mod
         #UPDATE xmac_t
         #   SET xmac011 = l_xmac.xmac011,
         #       xmac012 = l_xmac.xmac012,
         #       xmac013 = l_xmac.xmac013,
         #       xmac014 = l_xmac.xmac014,
         #       xmac015 = l_xmac.xmac015,
         #       xmac016 = l_xmac.xmac016,
         #       xmac017 = l_xmac.xmac017,
         #       xmac018 = l_xmac.xmac018,
         #       xmac019 = l_xmac.xmac019,
         #       xmac041 = l_xmac.xmac041,
         #       xmac042 = l_xmac.xmac042,
         #       xmac043 = l_xmac.xmac043,
         #       xmac044 = l_xmac.xmac044,
         #       xmac045 = l_xmac.xmac045,
         #       xmac046 = l_xmac.xmac046,
         #       xmac047 = l_xmac.xmac047,
         #       xmac048 = l_xmac.xmac048
         # WHERE xmacent = g_enterprise
         #   AND xmacsite = l_pmabsite
         #   AND xmac001 = l_pmab003
         EXECUTE axmp140_update_xmac_prep
           USING l_xmac.xmac011,l_xmac.xmac012,l_xmac.xmac013,l_xmac.xmac014,l_xmac.xmac015,
                 l_xmac.xmac016,l_xmac.xmac017,l_xmac.xmac018,l_xmac.xmac019,
                 l_xmac.xmac041,l_xmac.xmac042,l_xmac.xmac043,l_xmac.xmac044,l_xmac.xmac045,
                 l_xmac.xmac046,l_xmac.xmac047,l_xmac.xmac048,
                 g_enterprise  ,l_pmabsite    ,l_pmab003
        #160810-00026#1-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE xmac_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END IF
   END FOREACH
   #--151016--polly--add--(e)


   INITIALIZE l_pmab.* TO NULL
   FOREACH axmp140_process_sel_pmab_cs INTO l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab003,
                                            l_pmab.pmab004,l_pmab.pmab005,l_pmab.pmab006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axmp140_process_sel_pmab_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      IF NOT l_success THEN
         LET li_stus = FALSE
         LET l_success = TRUE
      END IF

      IF g_bgjob <> "Y" THEN
         #更新交易對像信用餘額檔：
        #160810-00026#1-s mod
        #LET ls_value = cl_getmsg('axm-00547',g_lang)," ",l_pmab.pmab003
         LET ls_value = l_msg," ",l_pmab.pmab003
        #160810-00026#1-e mod
         CALL cl_progress_no_window_ing(ls_value)
      END IF      

     #--151016--polly--mark--(s)           
     #LET l_xmac.xmac011 = 0
     #LET l_xmac.xmac012 = 0
     #LET l_xmac.xmac013 = 0
     #LET l_xmac.xmac014 = 0
     #LET l_xmac.xmac015 = 0
     #LET l_xmac.xmac016 = 0
     #LET l_xmac.xmac017 = 0
     #LET l_xmac.xmac018 = 0
     #LET l_xmac.xmac019 = 0
     #LET l_xmac.xmac041 = 0
     #LET l_xmac.xmac042 = 0
     #LET l_xmac.xmac043 = 0
     #LET l_xmac.xmac044 = 0
     #LET l_xmac.xmac045 = 0
     #LET l_xmac.xmac046 = 0
     #LET l_xmac.xmac047 = 0
     #LET l_xmac.xmac048 = 0         
     #
     #LET l_cnt = 0
     #SELECT COUNT(*) INTO l_cnt
     #  FROM xmac_t
     # WHERE xmacent = g_enterprise
     #   AND xmacsite = l_pmab.pmabsite
     #   AND xmac001 = l_pmab.pmab003
     #IF cl_null(l_cnt) OR l_cnt = 0 THEN
     #   INSERT INTO xmac_t(xmacent,xmacsite,xmac001,xmac011,xmac012,
     #                      xmac013, xmac014,xmac015,xmac016,xmac017,
     #                      xmac018, xmac019,xmac041,xmac042,xmac043,
     #                      xmac044, xmac045,xmac046,xmac047,xmac048)
     #        VALUES(  g_enterprise,l_pmab.pmabsite,l_pmab.pmab003,l_xmac.xmac011,l_xmac.xmac012,
     #               l_xmac.xmac013, l_xmac.xmac014,l_xmac.xmac015,l_xmac.xmac016,l_xmac.xmac017,
     #               l_xmac.xmac018, l_xmac.xmac019,l_xmac.xmac041,l_xmac.xmac042,l_xmac.xmac043,
     #               l_xmac.xmac044, l_xmac.xmac045,l_xmac.xmac046,l_xmac.xmac047,l_xmac.xmac048)
     #ELSE
     #   UPDATE xmac_t
     #      SET xmac011 = l_xmac.xmac011,
     #          xmac012 = l_xmac.xmac012,
     #          xmac013 = l_xmac.xmac013,
     #          xmac014 = l_xmac.xmac014,
     #          xmac015 = l_xmac.xmac015,
     #          xmac016 = l_xmac.xmac016,
     #          xmac017 = l_xmac.xmac017,
     #          xmac018 = l_xmac.xmac018,
     #          xmac019 = l_xmac.xmac019,
     #          xmac041 = l_xmac.xmac041,
     #          xmac042 = l_xmac.xmac042,
     #          xmac043 = l_xmac.xmac043,
     #          xmac044 = l_xmac.xmac044,
     #          xmac045 = l_xmac.xmac045,
     #          xmac046 = l_xmac.xmac046,
     #          xmac047 = l_xmac.xmac047,
     #          xmac048 = l_xmac.xmac048
     #    WHERE xmacent = g_enterprise
     #      AND xmacsite = l_pmab.pmabsite
     #      AND xmac001 = l_pmab.pmab003
     #   IF SQLCA.sqlcode THEN
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.code = SQLCA.sqlcode
     #      LET g_errparam.extend = 'UPDATE xmac_t'
     #      LET g_errparam.popup = TRUE
     #      CALL cl_err()
     #      LET l_success = FALSE
     #      EXIT FOREACH
     #   END IF
     #END IF
     #--151016--polly--mark--(e)
     #160922-00029#1-s-add
      IF l_pmab.pmab001 <> l_pmab.pmab003 THEN
         LET l_pmab.pmab004 = ''
         LET l_pmab.pmab005 = ''
         LET l_pmab.pmab006 = ''
        #60810-00026#1-s mod
        #EXECUTE axmp140_pmab001_pre USING l_pmab.pmabsite,l_pmab.pmab003
         EXECUTE axmp140_pmab001_pre USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab003
        #60810-00026#1-e mod
            INTO l_pmab.pmab004,l_pmab.pmab005,l_pmab.pmab006         
      END IF
     #160922-00029#1-e-add
      #調整異動檔
      IF l_pmab.pmabsite <> 'ALL' THEN
         #檢查異動檔的額度客戶是否一致
         LET l_cnt = 0 
         IF NOT cl_null(l_pmab.pmab003) THEN              #151125-00014#1 add
           #160810-00026#1-e mod
           #SELECT COUNT(*) INTO l_cnt
           #  FROM xmab_t
           # WHERE xmabent = g_enterprise
           #   AND xmab005 = l_pmab.pmabsite              #交易營運據點
           #   AND xmab006 = l_pmab.pmab001               #交易客戶
           #  #AND xmab008 <> l_pmab.pmab003              #額度客戶 #151125-00014#1 mark
           #   AND (xmab008 <> l_pmab.pmab003 OR xmab008 IS NULL)  #額度客戶 #151125-00014#1 add
            EXECUTE axmp140_process_sel_xmab_568cnt_pr2 USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab003 INTO l_cnt
           #160810-00026#1-e mod
        #151125-00014#1--add--(s) 
         ELSE
           #160810-00026#1-s mod
           #SELECT COUNT(*) INTO l_cnt
           #  FROM xmab_t
           # WHERE xmabent = g_enterprise
           #   AND xmab005 = l_pmab.pmabsite                                  #交易營運據點
           #   AND xmab006 = l_pmab.pmab001                                   #交易客戶
           #   AND xmab008 IS NOT NULL                                        #額度客戶
            EXECUTE axmp140_process_sel_xmab_568cnt_pr2 USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab001 INTO l_cnt
           #160810-00026#1-e mod
         #151125-00014#1--add--(e)      
         END IF
         
         IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
            #更新異動檔的額度客戶
           #60810-00026#1-s mod
           #UPDATE xmab_t
           #   SET xmab008 = l_pmab.pmab003
           # WHERE xmabent = g_enterprise
           #   AND xmab005 = l_pmab.pmabsite              #交易營運據點
           #   AND xmab006 = l_pmab.pmab001               #交易客戶
            EXECUTE axmp140_update_xmab008_prep USING l_pmab.pmab003,g_enterprise,l_pmab.pmabsite,l_pmab.pmab001
           #60810-00026#1-e mod
         END IF 
         
         #檢查異動檔的額度幣別是否一致
         LET l_cnt = 0 
         IF NOT cl_null(l_pmab.pmab005) THEN              #151125-00014#1 add
           #160810-00026#1-s mod
           #SELECT COUNT(*) INTO l_cnt
           #  FROM xmab_t
           # WHERE xmabent = g_enterprise
           #   AND xmab005 = l_pmab.pmabsite              #交易營運據點
           #   AND xmab006 = l_pmab.pmab001               #交易客戶
           #  #AND xmab012 <> l_pmab.pmab005              #額度幣別  #151125-00014#1 mark
           #   AND (xmab012 <> l_pmab.pmab005 OR xmab012 IS NULL)   #額度幣別 #151125-00014#1 add
            EXECUTE axmp140_process_sel_xmab_5612cnt_pr1 USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab005 INTO l_cnt
           #160810-00026#1-e mod
       #151125-00014#1--add--(s)                 
          ELSE
           #160810-00026#1-s mod
           #SELECT COUNT(*) INTO l_cnt
           #  FROM xmab_t
           # WHERE xmabent = g_enterprise
           #   AND xmab005 = l_pmab.pmabsite                        #交易營運據點
           #   AND xmab006 = l_pmab.pmab001                         #交易客戶
           #   AND xmab012 IS NOT NULL                              #額度幣別
            EXECUTE axmp140_process_sel_xmab_5612cnt_pr2 USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab001 INTO l_cnt
           #160810-00026#1-e mod
         END IF  
        #151125-00014#1--add--(e) 
         IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
            #更新異動檔的額度幣別 
           #60810-00026#1-s mod
           # UPDATE xmab_t
           #    SET xmab012 = l_pmab.pmab005
           #  WHERE xmabent = g_enterprise
           #    AND xmab005 = l_pmab.pmabsite              #交易營運據點
           #    AND xmab008 = l_pmab.pmab003
            EXECUTE axmp140_update_xmab012_prep USING l_pmab.pmab005,g_enterprise,l_pmab.pmabsite,l_pmab.pmab003
           #60810-00026#1-e mod               
               
#160810-00026#1-s mark
#影響效能,搬到FOREACH外
#            #更新異動檔的匯率
#            LET l_sql = "SELECT DISTINCT xmab005,xmab007,xmab012 FROM xmab_t",
#                        "  WHERE xmabent = ",g_enterprise,
#                        "    AND xmab005 = '",l_pmab.pmabsite,"' ",             #交易營運據點
#                        "    AND xmab008 = '",l_pmab.pmab003,"' "                      
#            PREPARE axmp140_sel_pmab005_pr FROM l_sql
#            DECLARE axmp140_sel_pmab005_cs CURSOR FOR axmp140_sel_pmab005_pr
#160810-00026#1-e mark
           #160810-00026#1-s mod
           #FOREACH axmp140_sel_pmab005_cs INTO l_xmab005,l_xmab007,l_xmab012
            FOREACH axmp140_sel_pmab005_cs USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab003
                                           INTO l_xmab005,l_xmab007,l_xmab012
           #160810-00026#1-e mod
             　LET l_xmab013 = 0
               LET l_exchange = 0
               IF NOT cl_null(l_xmab012) THEN
                 #160810-00026#1-s mod
                 #CALL cl_get_para(g_enterprise,l_xmab005,'S-BAS-0013') RETURNING l_para_data                  
                  EXECUTE axmp140_sel_ooab002_pr USING g_enterprise,l_xmab005,l_para_id INTO l_para_data
                 #160810-00026#1-e mod
                 #CALL s_aooi160_get_exrate('1',l_xmab005,g_today,l_xmab007,l_xmab012,0,l_para_data) RETURNING l_exchange   #160906-00029#1 mark
                  CALL s_credit_get_exrate('1',l_xmab005,g_today,l_xmab007,l_xmab012,0,l_para_data) RETURNING l_exchange    #160906-00029#1 add
                  LET l_xmab013 = l_exchange
                 #160810-00026#1-s mod
                 #UPDATE xmab_t
                 #   SET xmab013 = l_xmab013
                 # WHERE xmabent = g_enterprise
                 #   AND xmab008 = l_pmab.pmab003
                 #   AND xmab005 = l_xmab005
                 #   AND xmab007 = l_xmab007
                 #   AND xmab012 = l_xmab012
                  EXECUTE axmp140_update_xmab013_prep
                    USING l_xmab013,g_enterprise,l_pmab.pmab003,l_xmab005,l_xmab007,l_xmab012
                 #160810-00026#1-e mod
               END IF          
            END FOREACH      
         END IF
         #160926-00001#1-s-add                  
         #重新更新信用評核異動明細檔的異動類型
        #160810-00026#1-s mod
        #FOREACH axmp140_xmaa_cs USING l_pmab.pmab004 INTO l_xmaa002,l_xmaa004
         FOREACH axmp140_xmaa_cs USING g_enterprise,l_pmab.pmab004 INTO l_xmaa002,l_xmaa004
        #160810-00026#1-e mod
           #160810-00026#1-s mod
           #UPDATE xmab_t
           #   SET xmab002 = l_xmaa004
           # WHERE xmabent = g_enterprise
           #   AND xmab001 = l_xmaa002
           #   AND xmab008 = l_pmab.pmab003
            EXECUTE axmp140_update_xmab002_prep USING l_xmaa004,g_enterprise,l_xmaa002,l_pmab.pmab003
           #160810-00026#1-e mod
         END FOREACH
         #160926-00001#1-e-add
      END IF   
      
      
      #檢查餘額檔的額度幣別是否一致      
      LET l_cnt = 0
     #160810-00026#1-s mod
     #SELECT COUNT(*) INTO l_cnt
     #  FROM xmac_t
     # WHERE xmacent = g_enterprise
     #   AND xmacsite = l_pmab.pmabsite
     #   AND xmac001 = l_pmab.pmab003
     #   AND xmac002 <> l_pmab.pmab005
      EXECUTE axmp140_process_sel_xmac_cnt_pr1 USING g_enterprise,l_pmab.pmabsite,l_pmab.pmab003,l_pmab.pmab005 INTO l_cnt
     #160810-00026#1-e mod
      IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
         #更新餘額檔的額度幣別
        #160810-00026#1-s mod
        #UPDATE xmac_t
        #   SET xmac002 = l_pmab.pmab005
        # WHERE xmacent = g_enterprise
        #   AND xmacsite = l_pmab.pmabsite
        #   AND xmac001 = l_pmab.pmab003
        #   AND xmac002 <> l_pmab.pmab005
         EXECUTE axmp140_process_upd_xmac002_pr USING l_pmab.pmab005,g_enterprise,l_pmab.pmabsite,l_pmab.pmab003,l_pmab.pmab005
        #160810-00026#1-e mod
         #IF l_pmab.pmabsite <> 'ALL' THEN            
         #   #更新異動檔的額度幣別   
         #   UPDATE xmab_t
         #      SET xmab012 = l_pmab.pmab005
         #    WHERE xmabent = g_enterprise
         #      AND xmab005 = l_pmab.pmabsite              #交易營運據點
         #      AND xmab008 = l_pmab.pmab003          
         #   #更新異動檔的匯率
         #   LET l_sql = "SELECT DISTINCT xmab005,xmab007,xmab012 FROM xmab_t",
         #               "  WHERE xmabent = ",g_enterprise,
         #               "    AND xmab005 = '",l_pmab.pmabsite,"' ",             #交易營運據點
         #               "    AND xmab008 = '",l_pmab.pmab003,"' "
         #             
         #   PREPARE axmp140_sel_pmab005_pr FROM l_sql
         #   DECLARE axmp140_sel_pmab005_cs CURSOR FOR axmp140_sel_pmab005_pr
         #   FOREACH axmp140_sel_pmab005_cs INTO l_xmab005,l_xmab007,l_xmab012
         #   　LET l_xmab013 = 0
         #     LET l_exchange = 0
         #     IF NOT cl_null(l_xmab012) THEN
         #        CALL cl_get_para(g_enterprise,l_xmab005,'S-BAS-0013') RETURNING l_para_data
         #        CALL s_aooi160_get_exrate('1',l_xmab005,g_today,l_xmab007,l_xmab012,0,l_para_data) RETURNING l_exchange
         #        LET l_xmab013 = l_exchange
         #        UPDATE xmab_t
         #           SET xmab013 = l_xmab013
         #         WHERE xmabent = g_enterprise
         #           AND xmab008 = l_pmab.pmab003
         #           AND xmab005 = l_xmab005
         #           AND xmab007 = l_xmab007
         #           AND xmab012 = l_xmab012
         #     END IF          
         #   END FOREACH
         #END IF    
      END IF              

#160810-00026#1-s mark
#影響效能,搬到FOREACH外
#      #取出所有符合條件的信用評核異動明細資料
#      #依據相同的計算項目、異動類型與交易幣別對交易金額進行匯總
#      LET l_sql = " SELECT xmab001,xmab002,xmab007,SUM(xmab009),SUM(xmab010), ",
#                  "        xmab013,xmab020  ",
#                  "   FROM xmab_t ",
#                  "  WHERE xmabent = ",g_enterprise,
#                  "    AND xmab006 = '",l_pmab.pmab001,"' ",
#                  "    AND xmab008 = '",l_pmab.pmab003,"' ",
#                  "    AND xmab017 = 'N' ",
#                  "    AND (xmab009 - xmab010) > 0 "
#      #當下營運據點
#      IF l_pmab.pmabsite <> 'ALL' THEN
#         LET l_sql = l_sql," AND xmab005 = '",l_pmab.pmabsite,"' "
#      END IF
#      LET l_sql = l_sql," GROUP BY xmab001,xmab002,xmab007,xmab013,xmab020 "
#      PREPARE axmp140_process_sel_xmab_pr FROM l_sql
#      DECLARE axmp140_process_sel_xmab_cs CURSOR FOR axmp140_process_sel_xmab_pr
#160810-00026#1-e mark

      INITIALIZE l_xmab.* TO NULL
#160810-00026#1-s add
      IF l_pmab.pmabsite <> 'ALL' THEN
         #與ELSE段的FOREACH只差別在這段多傳了一個pmabsite的USING變數
         FOREACH axmp140_process_sel_xmab_cs1 USING g_enterprise,l_pmab.pmab001,l_pmab.pmab003,l_pmab.pmabsite
                                              INTO l_xmab.xmab001,l_xmab.xmab002,l_xmab.xmab007,
                                                   l_xmab.xmab009,l_xmab.xmab010,l_xmab.xmab013,
                                                   l_xmab.xmab020
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'axmp140_process_sel_pmab_cs1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE  #160903-00001#1 add
               EXIT FOREACH
            END IF
                           
            #若異動明細的計算項目在信用評等的公式中找不到有設置該計算項目時，則此異動明細不需要計算
            LET l_cnt = 0
            EXECUTE axmp140_process_sel_xmaa_count USING g_enterprise,l_pmab.pmab004,l_xmab.xmab001 INTO l_cnt
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               CONTINUE FOREACH
            END IF
   
            #計算該項目的信用耗用金額
            #(交易金額-已沖銷金額)*百分比*加減項*交易幣別與額度幣別匯率)
            LET l_amount = l_xmab.xmab009 - l_xmab.xmab010
            LET l_exchange = 0
            LET l_exchange = l_xmab.xmab013            
            IF cl_null(l_exchange) THEN LET l_exchange = 0 END IF
           
            IF NOT s_credit_upd_xmac_count(g_site,l_xmab.xmab007,l_amount,l_xmab.xmab001,'1','1',l_pmab.pmabsite,l_pmab.pmab003,l_pmab.pmab004,l_pmab.pmab005,l_pmab.pmab006,l_exchange) THEN
               LET l_success = FALSE
               EXIT FOREACH
            END IF
   
            INITIALIZE l_xmab.* TO NULL
         END FOREACH
         CLOSE axmp140_process_sel_xmab_cs1
      ELSE
#160810-00026#1-e add
        #160810-00026#1-s mod
        #OPEN axmp140_process_sel_xmab_cs
        #FOREACH axmp140_process_sel_xmab_cs USING INTO l_xmab.xmab001,l_xmab.xmab002,l_xmab.xmab007,
        #                                               l_xmab.xmab009,l_xmab.xmab010,l_xmab.xmab013,
        #                                               l_xmab.xmab020
         FOREACH axmp140_process_sel_xmab_cs USING g_enterprise,l_pmab.pmab001,l_pmab.pmab003
                                             INTO l_xmab.xmab001,l_xmab.xmab002,l_xmab.xmab007,
                                                  l_xmab.xmab009,l_xmab.xmab010,l_xmab.xmab013,
                                                  l_xmab.xmab020
        #160810-00026#1-e mod
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'axmp140_process_sel_pmab_cs'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE  #160903-00001#1 add
               EXIT FOREACH
            END IF

            #若異動明細的計算項目在信用評等的公式中找不到有設置該計算項目時，則此異動明細不需要計算
            LET l_cnt = 0
           #160810-00026#1-s mod
           #EXECUTE axmp140_process_sel_xmaa_count USING l_pmab.pmab004,l_xmab.xmab001 INTO l_cnt
            EXECUTE axmp140_process_sel_xmaa_count USING g_enterprise,l_pmab.pmab004,l_xmab.xmab001 INTO l_cnt
           #160810-00026#1-e mod
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
              #EXIT FOREACH        #160903-00001#1 mark
               CONTINUE FOREACH    #160903-00001#1 add
            END IF

            #計算該項目的信用耗用金額
            #(交易金額-已沖銷金額)*百分比*加減項*交易幣別與額度幣別匯率)
            LET l_amount = l_xmab.xmab009 - l_xmab.xmab010
            LET l_exchange = 0
           #IF l_pmab.pmabsite = 'ALL' THEN      #160810-00026#1 mark
               LET l_exchange = l_xmab.xmab020
           #ELSE                                 #160810-00026#1 mark
           #   LET l_exchange = l_xmab.xmab013   #160810-00026#1 mark
           #END IF                               #160810-00026#1 mark
            IF cl_null(l_exchange) THEN LET l_exchange = 0 END IF
           
            IF NOT s_credit_upd_xmac_count(g_site,l_xmab.xmab007,l_amount,l_xmab.xmab001,'1','1',l_pmab.pmabsite,l_pmab.pmab003,l_pmab.pmab004,l_pmab.pmab005,l_pmab.pmab006,l_exchange) THEN
               LET l_success = FALSE
               EXIT FOREACH
            END IF
   
            INITIALIZE l_xmab.* TO NULL
         END FOREACH
         CLOSE axmp140_process_sel_xmab_cs         
      END IF   #160810-00026#1 add
      
      INITIALIZE l_pmab.* TO NULL
   END FOREACH

   IF NOT l_success OR NOT li_stus THEN
      CALL s_transaction_end('N',0)
   END IF
   CALL s_transaction_end('Y',0)
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
      #150708-00007#1--(S)
      IF NOT l_success THEN
         LET li_p01_status = FALSE
      END IF
      IF g_schedule.gzpa003 = 1 THEN 
         IF cl_chk_process_exists(g_parentsession,g_account) THEN
            CALL cl_ask_confirm("std-00012") RETURNING li_stus
         END IF
      END IF 
      DISPLAY cl_getmsg_parm("azz-01007",g_lang,'')
      #150708-00007#1--(E)
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axmp140_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axmp140.get_buffer" >}
PRIVATE FUNCTION axmp140_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmp140.msgcentre_notify" >}
PRIVATE FUNCTION axmp140_msgcentre_notify()
 
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
 
{<section id="axmp140.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
