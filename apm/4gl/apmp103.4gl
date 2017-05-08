#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp103.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(1900-01-01 00:00:00), PR版次:0001(2016-04-06 13:55:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: apmp103
#+ Description: 採購入庫單批處理下傳
#+ Creator....: 07899(2016-02-19 09:21:35)
#+ Modifier...: 00000 -SD/PR- 07899
 
{</section>}
 
{<section id="apmp103.global" >}
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
DEFINE g_middb          STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp103.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_bgjob = "Y"
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
      CALL apmp103_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp103 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp103_init()
 
      #進入選單 Menu (="N")
      CALL apmp103_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp103
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp103.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp103_init()
 
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
 
{<section id="apmp103.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp103_ui_dialog()
 
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
            CALL apmp103_get_buffer(l_dialog)
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
         CALL apmp103_init()
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
                 CALL apmp103_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp103_transfer_argv(ls_js)
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
 
{<section id="apmp103.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp103_transfer_argv(ls_js)
 
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
 
{<section id="apmp103.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp103_process(ls_js)
 
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
   DEFINE l_pmds     RECORD
          doctype       LIKE type_t.chr5,  #截取订单单别
          pmdsent       LIKE type_t.chr10,
          pmdsdocno     LIKE pmds_t.pmdsdocno,
          pmds006       LIKE pmds_t.pmds006,
          pmds007       LIKE pmds_t.pmds007,
          pmds010       LIKE pmds_t.pmds010,
          pmds042       LIKE pmds_t.pmds042,
          status        LIKE pmee_t.pmeestus,
          erpold_stus   LIKE pmee_t.pmeestus,
          tran_status   LIKE type_t.chr2,    
          tran_time     LIKE type_t.chr20
                     END RECORD
                     
   DEFINE l_pmdt  DYNAMIC ARRAY OF RECORD
          pmdtdocno  LIKE pmdt_t.pmdtdocno,
          pmdtseq    LIKE pmdt_t.pmdtseq,
          pmdt001    LIKE pmdt_t.pmdt001,
          pmdt002    LIKE pmdt_t.pmdt002,
          pmdt006    LIKE pmdt_t.pmdt006,
          pmdt018    LIKE pmdt_t.pmdt018,
          pmdt019    LIKE pmdt_t.pmdt019,
          pmdt020    LIKE pmdt_t.pmdt020,
          pmdt022    LIKE pmdt_t.pmdt022,
          pmdt024    LIKE pmdt_t.pmdt024,
          pmdt027    LIKE pmdt_t.pmdt027,
          pmdt028    LIKE pmdt_t.pmdt028,
          pmdt037    LIKE pmdt_t.pmdt037,
          pmdt038    LIKE pmdt_t.pmdt038,
          pmdt039    LIKE pmdt_t.pmdt039,
          pmdt041    LIKE pmdt_t.pmdt041,
          pmdt046    LIKE pmdt_t.pmdt046,
          pmdt047    LIKE pmdt_t.pmdt047,
          pmdt049    LIKE pmdt_t.pmdt049,
          pmdt054    LIKE pmdt_t.pmdt054,
          pmdt055    LIKE pmdt_t.pmdt055,
          pmdt059    LIKE pmdt_t.pmdt059,
          pmdt064    LIKE pmdt_t.pmdt064,
          pmdt065    LIKE pmdt_t.pmdt065,
          pmdt088    LIKE pmdt_t.pmdt088,
          pmds031    LIKE pmds_t.pmds031,
          pmds032    LIKE pmds_t.pmds032,
          pmds037    LIKE pmds_t.pmds037,
          pmds038    LIKE pmds_t.pmds038,
          imaal003   LIKE imaal_t.imaal003,
          imaal004   LIKE imaal_t.imaal004
                  END RECORD
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5     
   DEFINE l_pmds057     LIKE pmds_t.pmds057
   DEFINE l_success     STRING
   DEFINE l_success2    STRING   
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
   DEFINE lr_result  RECORD
                        status LIKE type_t.num5,
                        data   STRING
                     END RECORD
   DEFINE l_pmds_result RECORD
                           ERP_FORM_NO    LIKE pmds_t.pmdsdocno,
                           TENANTGROUP    LIKE type_t.chr10,
                           DOC_TYPE_CODE  LIKE type_t.chr5,
                           DOC_NO         LIKE pmds_t.pmdsdocno,
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
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #切换到T100中间库
   LET l_success2 = "Y"
   CALL apmp103_get_doctype_relues() RETURNING l_e8,l_e1length,l_e2length,l_e3length,l_e3length  #单别阶段
   LET l_enterprise = g_enterprise
   
   #定义cursor
   LET g_forupd_sql = "SELECT pmdsent,pmdsdocno,pmds042,pmds057 FROM pmds_t",
                      " WHERE pmdsent = ? AND pmdsdocno = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmp103_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   
   LET g_middb = cl_eai_db_connect(g_dbs)
   SET CONNECTION g_middb
   IF  status THEN DISPLAY 'connect to g_middb error:',status RETURN  END IF
   LET ls_sql = "SELECT '',pmdsent,pmdsdocno,pmds006,pmds007,pmds010,pmds042,status,erpold_stus,tran_status,tran_time",
                " FROM b2b_pmds_t",
                " WHERE pmdsent = '",l_enterprise,"'",
                " AND tran_status = 'N' ",
                " AND status = 'S' AND pmds000 = '6'",
                " ORDER BY tran_time ASC"
   PREPARE apmp103_sel_pmds_pr FROM ls_sql
   DECLARE apmp103_sel_pmds_cs CURSOR FOR apmp103_sel_pmds_pr

   LET l_sql = "SELECT pmdtdocno,pmdtseq,pmdt001,pmdt002,pmdt006,pmdt018,pmdt019,pmdt020,pmdt022,pmdt024,pmdt027,pmdt028,",
               " pmdt037,pmdt038,pmdt039,pmdt041,pmdt046,pmdt047,pmdt049,pmdt054,pmdt055,pmdt059,",
               " pmdt064,pmdt065,pmdt088,pmds031,pmds032,pmds037,pmds038,imaal003,imaal004",
               " FROM b2b_pmdt01_v",
               " LEFT JOIN b2b_pmds01_v ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno",
               " LEFT JOIN all_imaal01_v ON imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"'",
               " WHERE pmdtent = ? AND pmdtdocno = ? ORDER BY pmdtseq"
   PREPARE apmp103_sel_pmdt_pr FROM l_sql
   DECLARE apmp103_sel_pmdt_cs CURSOR FOR apmp103_sel_pmdt_pr
   
   DISPLAY 'start foreach:',cl_get_current()
   INITIALIZE l_pmds.* TO NULL
   FOREACH apmp103_sel_pmds_cs INTO l_pmds.*
      LET l_pmaa098='N'
      SELECT pmaa098 INTO l_pmaa098 FROM all_pmaa01_v 
       WHERE pmaaent=l_enterprise AND pmaa001=l_pmds.pmds007
      IF l_pmaa098 <> 'Y' THEN
         CONTINUE FOREACH 
      ELSE
        DISPLAY 'l_pmaa098 = y'
        DISPLAY l_pmds.pmdsdocno
      END IF
      
      LET l_param.doc_type_parent = 'M'                      #单据大类待定
      CALL cl_ws_create_request() RETURNING l_request_root   #组xml 请求段落
      CALL cl_ws_addParameterRecord(util.JSONObject.fromFGL(l_param))  #组param  
      #截取单号中的单别
      LET l_str = l_pmds.pmdsdocno
      IF l_e8 = '1' THEN  #据点+单别 取第二段
         LET l_begin = l_e3length + l_e2length
         LET l_doctype = l_str.subString(l_begin+1,l_begin+l_e1length)
      ELSE
         LET l_begin = 0  #单别+据点取第一段
          LET l_doctype = l_str.subString(l_begin+1,l_e1length)
      END IF 
      LET l_pmds.doctype = l_doctype
      #组xml 
      LET l_node =  cl_ws_addMasterRecord("pmds_t",util.JSONObject.fromFGL(l_pmds))     #单头节点数据获取
      LET l_cnt = 1
      FOREACH  apmp103_sel_pmdt_cs USING l_pmds.pmdsent,l_pmds.pmdsdocno INTO l_pmdt[l_cnt].* 
        IF SQLCA.sqlcode THEN
           EXIT FOREACH
         END IF
         CALL cl_ws_addDetailRecord(l_node , "pmdt_t",util.JSONObject.fromFGL(l_pmdt[l_cnt]) , l_cnt)  #单身节点数据获取
         LET l_cnt = l_cnt + 1
      END FOREACH
      CALL l_pmdt.deleteelement(l_cnt)  
      LET l_cnt = l_cnt - 1 
   #单身组完
      SET CONNECTION g_dbs 
      IF status THEN DISPLAY 'connect to g_dbs error:',status EXIT FOREACH END IF
      LET l_service.ip =  cl_get_para(g_enterprise,"","E-SYS-0721")
      LET l_service.id =  cl_get_para(g_enterprise,"","E-SYS-0722")  
      LET l_service.prod    = "EC_B2B"
      LET l_service.srvname = "SetIN_STORAGE"
      LET l_service.request = l_request_root.toString()
      DISPLAY 'start to eai',cl_get_current()
      CALL cl_eai_invokeSrv(util.JSONObject.fromFGL(l_service)) RETURNING lr_result.*    
      DISPLAY 'end to eai',cl_get_current()
      IF  status THEN DISPLAY 'call cross error:',status EXIT FOREACH  END IF     
      LET l_cnt = 0  
      IF lr_result.status = 0 THEN
         LET l_resp_root = cl_ws_stringToXml(lr_result.data)  #讀取response string
         #讀取 Master node
         LET l_cnt = cl_ws_getMasterRecordLength("T_A_SN")   
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'wss-00002'
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         LET l_node = cl_ws_getMasterRecord(l_cnt,'T_A_SN')
         LET l_pmds_result.ERP_FORM_NO   = cl_ws_getRecordField(l_node ,"ERP_FORM_NO")
         LET l_pmds_result.TENANTGROUP   = cl_ws_getRecordField(l_node ,"TENANTGROUP")   
         LET l_pmds_result.DOC_TYPE_CODE = cl_ws_getRecordField(l_node ,"DOC_TYPE_CODE")
         LET l_pmds_result.tran_status   = cl_ws_getRecordField(l_node ,"tran_status")
         LET l_pmds_result.tran_time     = cl_ws_getRecordField(l_node ,"tran_time")
         LET l_pmds_result.DOC_NO        = cl_ws_getRecordField(l_node ,"DOC_NO")  
         IF cl_null(l_pmds_result.DOC_NO) OR cl_null(l_pmds_result.DOC_TYPE_CODE) THEN
            LET l_pmds057 = '1'
            LET l_pmds_result.DOC_NO = ''
         ELSE
            LET l_pmds057 = '2' 
            LET l_pmds_result.tran_status = 'Y'              
         END IF    
         #更新正式库来源单号，来源类型
         IF cl_null(l_pmds.pmds042) AND l_pmds_result.tran_status = 'Y'THEN  #集成单号为空才更新，避免反复触发到触发器 #1104
             CALL s_transaction_begin()   
             OPEN apmp103_cl USING g_enterprise,l_pmds_result.ERP_FORM_NO
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "OPEN apmp103_cl:"
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                CLOSE apmp103_cl
                CALL s_transaction_end('N','0')
                RETURN
             END IF 
             UPDATE pmds_t SET pmds057 = l_pmds057,pmds042 = l_pmds_result.DOC_NO
                        WHERE  pmdsent = l_pmds_result.TENANTGROUP AND  pmdsdocno = l_pmds_result.ERP_FORM_NO 
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "upd pmds_t"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET l_success2 = 'N'
                CALL s_transaction_end('N','0')
                RETURN
             END IF   
             CALL s_transaction_end('Y','0') 
             CLOSE apmp103_cl 
         END IF  
         #切回中间库更新传输状态
         SET CONNECTION g_middb     
         IF status THEN DISPLAY 'connect to g_middb error:',status  EXIT FOREACH END IF 
         IF  l_pmds_result.tran_status = 'Y'THEN  #集成单号为空才更新，避免反复触发到触发器
            DISPLAY 'tran_status:',l_pmds_result.tran_status
            UPDATE b2b_pmds_t SET tran_status = l_pmds_result.tran_status    #传输状态
                            WHERE pmdsent = l_pmds_result.TENANTGROUP
                              AND pmdsdocno = l_pmds_result.ERP_FORM_NO
                              AND tran_time = l_pmds_result.tran_time
                  
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd b2b_pmds_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success2 = 'N'
               RETURN
            END IF                      
         END IF           
      ELSE 
         #呼叫服務失敗
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "aws-00029"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_success2 = 'N'
      END IF  
   END FOREACH
   
   
   DISPLAY 'end foreach:',cl_get_current()
   SET CONNECTION g_dbs    #回到正式库
   IF status THEN DISPLAY 'connect to g_dbs error:',status  RETURN END IF      
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp103_process_cs CURSOR FROM ls_sql
#  FOREACH apmp103_process_cs INTO
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
   CALL apmp103_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp103.get_buffer" >}
PRIVATE FUNCTION apmp103_get_buffer(p_dialog)
 
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
 
{<section id="apmp103.msgcentre_notify" >}
PRIVATE FUNCTION apmp103_msgcentre_notify()
 
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
 
{<section id="apmp103.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp103_get_doctype_relues (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp103_get_doctype_relues()
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
 
