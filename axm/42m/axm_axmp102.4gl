#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp102.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(1900-01-01 00:00:00), PR版次:0002(2016-10-18 10:23:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: axmp102
#+ Description: 出貨單批處理作業下傳
#+ Creator....: 02481(2015-09-22 17:10:12)
#+ Modifier...: 00000 -SD/PR- 06021
 
{</section>}
 
{<section id="axmp102.global" >}
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
IMPORT FGL lib_cl_schedule
IMPORT util
IMPORT xml
IMPORT com
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
       stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_middb    STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp102.main" >}
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
   LET g_bgjob = "Y"   #直接跑背景
   IF cl_ap_chk_self_exists() THEN
     CALL cl_ap_exitprogram("0")
   END IF 
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axmp102_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp102 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmp102_init()
 
      #進入選單 Menu (="N")
      CALL axmp102_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp102
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp102.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmp102_init()
 
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
 
{<section id="axmp102.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp102_ui_dialog()
 
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
            CALL axmp102_get_buffer(l_dialog)
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
         CALL axmp102_init()
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
                 CALL axmp102_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmp102_transfer_argv(ls_js)
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
 
{<section id="axmp102.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmp102_transfer_argv(ls_js)
 
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
 
{<section id="axmp102.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmp102_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql      STRING   #单身sql
   DEFINE l_xmdk     RECORD
          doctype      LIKE type_t.chr5,  #截取订单单别
          xmdkent      LIKE type_t.chr10,
          xmdksite     LIKE xmdk_t.xmdksite,
          xmdkdocno    LIKE xmdk_t.xmdkdocno,
          xmdadocdt    LIKE xmdk_t.xmdkdocdt,
          xmdk000      LIKE xmdk_t.xmdk000,
          xmdk001      LIKE xmdk_t.xmdk001,
          xmdk002      LIKE xmdk_t.xmdk002,
          xmdk003      LIKE xmdk_t.xmdk003,
          xmdk006      LIKE xmdk_t.xmdk006,
          xmdk007      LIKE xmdk_t.xmdk007,
          xmdk008      LIKE xmdk_t.xmdk008,
          xmdk009      LIKE xmdk_t.xmdk009,
          xmdk010      LIKE xmdk_t.xmdk010,
          xmdk011      LIKE xmdk_t.xmdk011,
          xmdk012      LIKE xmdk_t.xmdk012,
          xmdk013      LIKE xmdk_t.xmdk013,
          xmdk014      LIKE xmdk_t.xmdk014,
          xmdk015      LIKE xmdk_t.xmdk015,
          xmdk016      LIKE xmdk_t.xmdk016,
          xmdk021      LIKE xmdk_t.xmdk021,
          xmdk022      LIKE xmdk_t.xmdk022,
          xmdk030      LIKE xmdk_t.xmdk030,
          xmdk031      LIKE xmdk_t.xmdk031,      
          xmdk051      LIKE xmdk_t.xmdk051,
          xmdk052      LIKE xmdk_t.xmdk052,
          xmdk053      LIKE xmdk_t.xmdk053,
          xmdk054      LIKE xmdk_t.xmdk054,
          xmdk046      LIKE xmdk_t.xmdk046,
          xmdk036      LIKE xmdk_t.xmdk036,
          xmdk202      LIKE xmdk_t.xmdk202,
          xmdk207      LIKE xmdk_t.xmdk207,
          xmdkstus     LIKE xmdk_t.xmdkstus,
          status       LIKE xmdk_t.xmdkstus,
          tran_status  LIKE type_t.chr2,    
          tran_time    LIKE type_t.chr20,
          xmda026      LIKE xmda_t.xmda026,
          xmda204      LIKE xmda_t.xmda204,
          xmdkcrtdt    LIKE xmdk_t.xmdkcrtdt,
          xmdkcrtid    LIKE xmdk_t.xmdkcrtid,
          xmdkmoddt    LIKE xmdk_t.xmdkmoddt,
          xmdkmodid    LIKE xmdk_t.xmdkmodid,
          xmdkcnfdt    LIKE xmdk_t.xmdkcnfdt,
          xmdkcnfid    LIKE xmdk_t.xmdkcnfid,
          xmdkpstdt    LIKE xmdk_t.xmdkpstdt,
          xmdkpstid    LIKE xmdk_t.xmdkpstid
                       END RECORD 
   DEFINE l_xmdl    DYNAMIC ARRAY OF RECORD      
         xmdlseq       LIKE xmdl_t.xmdlseq,
         xmdl003       LIKE xmdl_t.xmdl003,
         xmdl004       LIKE xmdl_t.xmdl004,
         xmdl008       LIKE xmdl_t.xmdl008,
         xmdl016       LIKE xmdl_t.xmdl016,
         xmdl017       LIKE xmdl_t.xmdl017,
         xmdl018       LIKE xmdl_t.xmdl018,
         xmdl024       LIKE xmdl_t.xmdl024,
         xmdl025       LIKE xmdl_t.xmdl025,
         xmdl026       LIKE xmdl_t.xmdl026,
         xmdl027       LIKE xmdl_t.xmdl027,
         xmdl028       LIKE xmdl_t.xmdl028,
         xmdl029       LIKE xmdl_t.xmdl029,
         xmdl051       LIKE xmdl_t.xmdl051,
         xmdl208       LIKE xmdl_t.xmdl208,
         xmdl210       LIKE xmdl_t.xmdl210,
         xmdl212       LIKE xmdl_t.xmdl212,
         xmdl226       LIKE xmdl_t.xmdl226,
         xmdc012       LIKE xmdc_t.xmdc012,
         xmdc025       LIKE xmdc_t.xmdc025,
         imaal003      LIKE imaal_t.imaal003,
         imaal004      LIKE imaal_t.imaal004
                       END RECORD  
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5     
   DEFINE l_xmdk046     LIKE xmdk_t.xmdk046
   DEFINE l_success     STRING
   DEFINE l_success2    STRING   
   DEFINE l_only_t      LIKE type_t.chr200
   DEFINE l_str         STRING
   DEFINE l_doctype     STRING
   DEFINE l_request_root xml.DomNode
   DEFINE l_node           xml.DomNode
   DEFINE l_begin    LIKE type_t.num5
   DEFINE l_e8       LIKE type_t.chr1
   DEFINE l_e2length LIKE type_t.num5
   DEFINE l_e4length LIKE type_t.num5
   DEFINE l_e3length LIKE type_t.num5
   DEFINE l_e1length LIKE type_t.num5
   DEFINE lr_result         RECORD
                              status LIKE type_t.num5,
                              data   STRING
                            END RECORD
   DEFINE l_xmdk_result     DYNAMIC ARRAY OF RECORD
                                ERP_FORM_NO    LIKE xmdk_t.xmdkdocno,
                                TENANTGROUP    LIKE type_t.chr10,
                                DOC_TYPE_CODE  LIKE type_t.chr5,
                                DOC_NO         LIKE xmdk_t.xmdkdocno,
                                tran_status    LIKE type_t.chr2,    
                                tran_time      LIKE type_t.chr20                                         
                            END RECORD

   DEFINE l_param   RECORD
             doc_type_parent LIKE type_t.chr5     #单据大类  
                    END RECORD
   DEFINE l_service   RECORD
                        ip       STRING,
                        id       STRING,
                        prod     STRING,   #產品別
                        srvname  STRING,   #服務名稱
                        async    BOOLEAN,  #非同步(option)
                        request  STRING
                      END RECORD       
   DEFINE l_resp_root  xml.DomDocument # xml.DomNode    
   DEFINE l_j          LIKE type_t.num5  
   DEFINE l_enterprise LIKE type_t.num5   
   DEFINE l_pmaa098    LIKE pmaa_t.pmaa098
   DEFINE l_xmda008    LIKE xmda_t.xmda008   #1126
   DEFINE l_xmda008_1  LIKE xmda_t.xmda008   #1126
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #切换到T100 中间库
   LET l_success2 = 'Y' 
   CALL axmp102_get_doctype_relues() RETURNING l_e8,l_e1length,l_e2length,l_e3length,l_e3length  #单别阶段
   LET l_enterprise = g_enterprise
   
   #20151022---add---begin---   
   #定义cursor 
   LET g_forupd_sql = "SELECT xmdkent,xmdkdocno,xmdk036,xmdk046 FROM xmdk_t WHERE xmdkent=? AND xmdkdocno=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmp102_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   #20151022---add---end----- 
   
   LET g_middb = cl_eai_db_connect(g_dbs) 
   SET CONNECTION g_middb
   IF  status THEN DISPLAY 'connect to g_middb error:',status RETURN  END IF #1216
   LET ls_sql = "SELECT '',xmdkent,xmdksite,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,xmdk003,xmdk006,",
             " xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk021,",
             " xmdk022,xmdk030,xmdk031,xmdk051,xmdk052,xmdk053,xmdk054,xmdk046,xmdk036,xmdk202,",
             " xmdk207,xmdkstus,status,tran_status,tran_time,xmda026,xmda204,xmdkcrtdt,xmdkcrtid,xmdkmoddt,xmdkmodid,xmdkcnfdt,xmdkcnfid,",
             " xmdkpstdt,xmdkpstid ",
             " FROM b2b_xmdk_t ",
             " LEFT JOIN b2b_xmda01_v ON  xmdaent = xmdkent AND xmdadocno = xmdk006 ",
             " WHERE tran_status = 'N' AND xmdk000='1' AND xmdkstus <> status ",
             " AND xmdksite in (select  ooabsite  from all_ooab02_v where ooabent = '" ,l_enterprise,"' and ooab001 = 'S-SYS-0002' and ooab002 = 'Y') ",
             " AND xmdkent = '",l_enterprise,"'",
             " AND ((xmdkstus = 'S' AND status = 'Y') OR (xmdkstus = 'Y' AND status = 'S'))",
             " ORDER BY tran_time ASC"
   PREPARE axmp102_sel_xmdk_pr FROM ls_sql
   DECLARE axmp102_sel_xmdk_cs CURSOR FOR axmp102_sel_xmdk_pr
   LET l_sql = "SELECT xmdlseq,xmdl003,xmdl004,xmdl008,xmdl016,xmdl017,xmdl018,xmdl024,xmdl025,xmdl026,xmdl027, ",
               " xmdl028,xmdl029,xmdl051,xmdl208,xmdl210,xmdl212,xmdl226,xmdc012,xmdc025,imaal003,imaal004",
               " FROM b2b_xmdl01_v ",
               " LEFT JOIN b2b_xmdc01_v ON  xmdcent = xmdlent AND xmdcdocno = xmdl003 AND xmdcseq=xmdl004 ", #20160112
               " LEFT JOIN all_imaal01_v ON imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_dlang,"'",
               " LEFT JOIN b2b_xmda01_v ON  xmdaent = xmdlent AND xmdadocno = xmdl003 ",    #1126
               " WHERE xmdlent = ? AND xmdldocno = ?  ORDER BY xmdlseq  "
   
   PREPARE axmp102_sel_xmdl_pr FROM l_sql
   DECLARE axmp102_sel_xmdl_cs CURSOR FOR axmp102_sel_xmdl_pr 
  
 #  LET g_forupd_sql = "SELECT xmdkent,xmdkdocno,xmdk036,xmdk046 FROM b2b_xmdk_t WHERE xmdkent=? AND xmdkdocno=? AND tran_time =? FOR UPDATE"
 #  LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
 #  LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
 #  DECLARE axmp102_md_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR中間庫資料
   
   DISPLAY 'start foreach:',cl_get_current()
   INITIALIZE l_xmdk.* TO NULL
   FOREACH axmp102_sel_xmdk_cs INTO  l_xmdk.*
      #1018------add-------------begin----------------
      IF SQLCA.sqlcode THEN
         EXIT FOREACH
      END IF
      #1018------add-------------end----------------
      #20151027---add---begin---
      LET l_pmaa098='N'
      SELECT pmaa098 INTO l_pmaa098 FROM all_pmaa01_v 
       WHERE pmaaent=l_enterprise AND pmaa001=l_xmdk.xmdk007
      
      #1018------add-------------begin---------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "reproduce:",SQLERRMESSAGE
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         EXIT FOREACH
      END IF
      #1018------add-------------end----------------      
      IF l_pmaa098 <> 'Y' THEN
         CONTINUE FOREACH 
      ELSE 
        DISPLAY 'l_pmaa098 = y'
        DISPLAY l_xmdk.xmdkdocno  
      END IF 
      #20151027---add---end---
      #1126---add--begin------
      #若订单没下放则出货单不下放
      IF NOT cl_null(l_xmdk.xmdk006) THEN
         IF cl_null(l_xmda008) THEN
            display 'PURCHASE_ORDER IS NULL'
            CONTINUE FOREACH
         ELSE
            display 'xmda008 =',l_xmda008
         END IF
      END IF
      #1126---add--end--------
      #若出货单有下放失败的前置数据则这笔后面的资料不下放
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt FROM b2b_xmdk_t WHERE xmdk000='1'  AND xmdkdocno = l_xmdk.xmdkdocno and xmdkent = l_enterprise 
      AND tran_time < l_xmdk.tran_time AND  tran_status = 'N'
      AND ((xmdkstus = 'S' AND status = 'Y') OR (xmdkstus = 'Y' AND status = 'S'))
      IF  l_cnt > 0 THEN
          CONTINUE FOREACH 
      END IF
      
      LET l_param.doc_type_parent = '9'  
      CALL cl_ws_create_request() RETURNING l_request_root   #组xml 请求段落
      CALL cl_ws_addParameterRecord(util.JSONObject.fromFGL(l_param))  #组param

      #若签收订单已经存在axmt580 则数据需过滤
       IF l_xmdk.xmdk002 = '3' THEN
          LET l_cnt = 0
          SELECT count(xmdkdocno) INTO l_cnt  FROM b2b_xmdk_t WHERE xmdkent = l_xmdk.xmdkent AND xmdk005 = l_xmdk.xmdkdocno
                                                            AND xmdk000 = '4'
          #1018------add-------------begin---------------- 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "reproduce:",SQLERRMESSAGE
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = TRUE
             EXIT FOREACH
          END IF
          #1018------add-------------end----------------
          IF l_cnt > 0 THEN
             CONTINUE FOREACH
          END IF          
       END IF
      #截取单号中的单别
      LET l_str = l_xmdk.xmdkdocno
      IF l_e8 = '1' THEN  #据点+单别 取第二段
         LET l_begin = l_e3length + l_e2length
         LET l_doctype = l_str.subString(l_begin+1,l_begin+l_e1length)
      ELSE
         LET l_begin = 0  #单别+据点取第一段
          LET l_doctype = l_str.subString(l_begin+1,l_e1length)
      END IF 
      LET l_xmdk.doctype = l_doctype      
      #组xml 
      LET l_node =  cl_ws_addMasterRecord("xmdk_t",util.JSONObject.fromFGL(l_xmdk))     #单头节点数据获取
      LET l_cnt = 1
      LET l_success = 'Y' #1126
      LET l_xmda008_1 = ''  #1126
      FOREACH  axmp102_sel_xmdl_cs USING l_xmdk.xmdkent,l_xmdk.xmdkdocno INTO l_xmdl[l_cnt].*,l_xmda008_1 #1126 
        IF SQLCA.sqlcode THEN
           EXIT FOREACH
         END IF
          #1126--add---begin-----------
         IF cl_null(l_xmdk.xmdk006) THEN   #若单头订单为空则需判断单身是否多笔订单出货 
            IF cl_null(l_xmda008_1) THEN  #若有一笔订单没下放EC 则该笔出货全部不下放EC
               LET l_success = 'N' 
               EXIT FOREACH
            END IF
         END IF
         #1126--add---end-------------
         CALL cl_ws_addDetailRecord(l_node , "xmdl_t",util.JSONObject.fromFGL(l_xmdl[l_cnt]) , l_cnt)
         LET l_cnt = l_cnt + 1
      END FOREACH
      CALL l_xmdl.deleteelement(l_cnt)
      LET l_cnt = l_cnt - 1 
      IF l_success = 'Y' THEN  #1126
      #单身组完
      SET CONNECTION g_dbs 
      IF status THEN DISPLAY  'connect to g_dbs error:',status EXIT FOREACH  END IF   #1216 
      LET l_service.ip =  cl_get_para(g_enterprise,"","E-SYS-0721")
      LET l_service.id =  cl_get_para(g_enterprise,"","E-SYS-0722")  
      LET l_service.prod    = "EC_B2B"
      LET l_service.srvname = "PurchaseStockDown"
      LET l_service.request = l_request_root.toString()
      DISPLAY 'start to eai',cl_get_current()
      CALL cl_eai_invokeSrv(util.JSONObject.fromFGL(l_service)) RETURNING lr_result.* 
      DISPLAY 'end to eai',cl_get_current()
      IF  status THEN DISPLAY 'call cross error:',status EXIT FOREACH  END IF     #1230
      LET l_cnt = 0 
      IF lr_result.status = 0 THEN
       LET l_resp_root = cl_ws_stringToXml(lr_result.data)  #讀取response string
       #讀取 Master node
       LET l_cnt = cl_ws_getMasterRecordLength("T_A_PR")  
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'wss-00002'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          RETURN
       END IF
       FOR l_j = 1 TO l_cnt
           LET l_node = cl_ws_getMasterRecord(l_j,'T_A_PR')
           LET l_xmdk_result[l_j].ERP_FORM_NO = cl_ws_getRecordField(l_node ,"ERP_FORM_NO")  
           LET l_xmdk_result[l_j].TENANTGROUP = cl_ws_getRecordField(l_node ,"TENANTGROUP")
           LET l_xmdk_result[l_j].DOC_TYPE_CODE = cl_ws_getRecordField(l_node ,"DOC_TYPE_CODE")   
           LET l_xmdk_result[l_j].DOC_NO = cl_ws_getRecordField(l_node ,"DOC_NO")
           LET l_xmdk_result[l_j].tran_status = cl_ws_getRecordField(l_node ,"tran_status")
           LET l_xmdk_result[l_j].tran_time = cl_ws_getRecordField(l_node ,"tran_time")
           IF cl_null(l_xmdk_result[l_j].DOC_NO) OR cl_null(l_xmdk_result[l_j].DOC_TYPE_CODE) THEN
              LET l_xmdk046 = '1'
              LET l_xmdk_result[l_j].DOC_NO = ''
           ELSE
              LET l_xmdk046 = '2' 
              LET l_xmdk_result[l_j].tran_status = 'Y'              
           END IF
           #更新正式库来源单号，来源类型
           IF cl_null(l_xmdk.xmdk036) AND l_xmdk_result[l_j].tran_status = 'Y'THEN  #集成单号为空才更新，避免反复触发到触发器 #1104
           CALL s_transaction_begin() 
           #20151022---add---begin--- 
           OPEN axmp102_cl USING g_enterprise,l_xmdk_result[l_j].ERP_FORM_NO
           IF STATUS THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = "OPEN axmp102_cl:"
              LET g_errparam.code   = STATUS
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              CLOSE axmp102_cl
              CALL s_transaction_end('N','0')
              RETURN
           END IF
           #20151022---add---end----- 
           UPDATE xmdk_t SET xmdk046 = l_xmdk046,
                                 xmdk036 = l_xmdk_result[l_j].DOC_NO
               WHERE  xmdkent = l_xmdk_result[l_j].TENANTGROUP
                 AND  xmdkdocno = l_xmdk_result[l_j].ERP_FORM_NO 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd xmdk_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success2 = 'N'
               CALL s_transaction_end('N','0')
               EXIT FOR
            END IF
            #IF l_success2 = 'Y' THEN                #20151022---mark---
               CALL s_transaction_end('Y','0') 
               CLOSE axmp102_cl  
            #20151022---mark---begin---
            #ELSE
            #   CALL s_transaction_end('N','0')
            #END IF 
            #20151022---mark---end---    
            END IF     #1104               
       END FOR
       #切回中间库更新传输状态
       SET CONNECTION g_middb 
       IF status THEN DISPLAY 'connect to g_middb error:',status EXIT FOREACH  END IF #1216
       DISPLAY  l_success2
       DISPLAY  l_cnt   
           FOR l_i = 1 TO l_cnt
            DISPLAY 'tran_status:',l_xmdk_result[l_i].tran_status
            UPDATE b2b_xmdk_t SET tran_status = l_xmdk_result[l_i].tran_status    #传输状态
            WHERE xmdkent = l_xmdk_result[l_i].TENANTGROUP
              AND xmdkdocno = l_xmdk_result[l_i].ERP_FORM_NO
              AND tran_time = l_xmdk_result[l_i].tran_time
                  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "upd b2b_xmdk_t"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET l_success2 = 'N'
                 EXIT FOR
              END IF               
           END FOR
              
     ELSE
      #呼叫服務失敗
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "aws-00029"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success2 = 'N'
    END IF       
    END IF  #1126
   END FOREACH
   
   DISPLAY 'end foreach:',cl_get_current()
   SET CONNECTION g_dbs    #回到正式库
   IF status THEN DISPLAY 'connect to g_dbs error:',status  RETURN   END IF #1216
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axmp102_process_cs CURSOR FROM ls_sql
#  FOREACH axmp102_process_cs INTO
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
   CALL axmp102_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axmp102.get_buffer" >}
PRIVATE FUNCTION axmp102_get_buffer(p_dialog)
 
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
 
{<section id="axmp102.msgcentre_notify" >}
PRIVATE FUNCTION axmp102_msgcentre_notify()
 
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
 
{<section id="axmp102.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp102_get_doctype_relues()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp102_get_doctype_relues()
DEFINE l_e8  LIKE type_t.chr1
DEFINE l_e1  LIKE type_t.chr1
DEFINE l_e2  LIKE type_t.chr1
DEFINE l_e3  LIKE type_t.chr1
DEFINE l_e4  LIKE type_t.chr1
DEFINE l_e5  LIKE type_t.chr1
DEFINE l_e2length LIKE type_t.num5
DEFINE l_e4length LIKE type_t.num5
DEFINE l_e3length LIKE type_t.num5
DEFINE l_e1length LIKE type_t.num5

SELECT a.ooaa002,b.OOAA002,c.OOAA002,d.OOAA002,e.OOAA002,f.OOAA002
 INTO l_e8,l_e1,l_e2,l_e3,l_e4,l_e5
 FROM ooaa_t a,ooaa_t b, ooaa_t c, ooaa_t d, ooaa_t e, ooaa_t f 
 
where a.ooaa001 = 'E-COM-0008' and a.ooaaent = g_enterprise
and b.ooaa001 = 'E-COM-0001' and b.ooaaent = g_enterprise
and c.ooaa001 = 'E-COM-0002' and c.ooaaent = g_enterprise
and d.ooaa001 = 'E-COM-0003' and d.ooaaent = g_enterprise
and e.ooaa001 = 'E-COM-0004' and e.ooaaent = g_enterprise
and f.ooaa001 = 'E-COM-0005' and f.ooaaent = g_enterprise

LET l_e2length = 0   
LET l_e4length = 0 

IF l_e2 = 'Y' THEN
    LET l_e2length = 1
ELSE
    LET l_e2length = 0
END IF

IF l_e4 = 'Y' THEN
    LET l_e4length = 1
ELSE
    LET l_e4length = 0
END IF

LET l_e1length = l_e1

LET l_e3length = l_e3


RETURN l_e8,l_e1length,l_e2length,l_e3length,l_e3length

END FUNCTION

#end add-point
 
{</section>}
 
