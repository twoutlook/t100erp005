#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(1900-01-01 00:00:00), PR版次:0002(2016-11-01 14:04:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: apmp100
#+ Description: 採購單確認作業
#+ Creator....: 07899(2016-02-15 09:54:09)
#+ Modifier...: 00000 -SD/PR- 06021
 
{</section>}
 
{<section id="apmp100.global" >}
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
DEFINE g_middb    STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp100.main" >}
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
   LET g_bgjob = "Y"   #直接跑背景(自测时先注销)
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
      CALL apmp100_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp100 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp100_init()
 
      #進入選單 Menu (="N")
      CALL apmp100_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp100.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp100_init()
 
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
 
{<section id="apmp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp100_ui_dialog()
 
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
            CALL apmp100_get_buffer(l_dialog)
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
         CALL apmp100_init()
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
                 CALL apmp100_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp100_transfer_argv(ls_js)
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
 
{<section id="apmp100.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp100_transfer_argv(ls_js)
 
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
 
{<section id="apmp100.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp100_process(ls_js)
 
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
   DEFINE l_sql1      STRING  #子单身sql
   DEFINE l_sql2      STRING  #附件sql
   DEFINE l_pmdl     RECORD
          doctype    LIKE type_t.chr5,  #截取订单单别
          pmdlent    LIKE type_t.chr10,
          pmdldocno  LIKE pmdl_t.pmdldocno,
          pmdlsite   LIKE pmdl_t.pmdlsite,
          pmdldocdt  LIKE pmdl_t.pmdldocdt,
          pmdlcrtdt  LIKE pmdl_t.pmdlcrtdt,
          pmdlmoddt  LIKE pmdl_t.pmdlmoddt,
         #pmdl001    LIKE pmdl_t.pmdl001,  #1101 mark by ouhz #版次取整数
          pmdl001    LIKE type_t.chr10,    #1101 add  by ouhz
          pmdl002    LIKE pmdl_t.pmdl002,
          pmdl003    LIKE pmdl_t.pmdl003,
          pmdl004    LIKE pmdl_t.pmdl004,
          pmdl005    LIKE pmdl_t.pmdl005,
          pmdl009    LIKE pmdl_t.pmdl009,
          pmdl010    LIKE pmdl_t.pmdl010,
          pmdl011    LIKE pmdl_t.pmdl011,
          pmdl012    LIKE pmdl_t.pmdl012,
          pmdl013    LIKE pmdl_t.pmdl013,
          pmdl015    LIKE pmdl_t.pmdl015,
          pmdl016    LIKE pmdl_t.pmdl016,
          pmdl025    LIKE pmdl_t.pmdl025,
          pmdl026    LIKE pmdl_t.pmdl026,
          pmdl029    LIKE pmdl_t.pmdl029,
          pmdl032    LIKE pmdl_t.pmdl032,
          pmdl033    LIKE pmdl_t.pmdl033,
          pmdl040    LIKE pmdl_t.pmdl040,
          pmdl041    LIKE pmdl_t.pmdl041, 
          pmdl042    LIKE pmdl_t.pmdl042,
          pmdl044    LIKE pmdl_t.pmdl044,
          pmdl208    LIKE pmdl_t.pmdl208,
          status     LIKE pmdl_t.pmdlstus,
          erpold_stus LIKE pmdl_t.pmdlstus,
          tran_status LIKE type_t.chr2,    
          tran_time   LIKE type_t.chr20
                        END RECORD 

   DEFINE l_pmdn    DYNAMIC ARRAY OF RECORD
          pmdnseq      LIKE pmdn_t.pmdnseq,
          pmdn001      LIKE pmdn_t.pmdn001,
          pmdn006      LIKE pmdn_t.pmdn006,
          pmdn007      LIKE pmdn_t.pmdn007,
          pmdn011      LIKE pmdn_t.pmdn011,
          pmdn012      LIKE pmdn_t.pmdn012,
          pmdn013      LIKE pmdn_t.pmdn013,
          pmdn016      LIKE pmdn_t.pmdn016,
          pmdn017      LIKE pmdn_t.pmdn017,
          pmdn021      LIKE pmdn_t.pmdn021,
          pmdn022      LIKE pmdn_t.pmdn022,
          pmdn024      LIKE pmdn_t.pmdn024,
          pmdn028      LIKE pmdn_t.pmdn028,
          pmdn046      LIKE pmdn_t.pmdn046,
          pmdn047      LIKE pmdn_t.pmdn047,
          pmdn048      LIKE pmdn_t.pmdn048,
          pmdn050      LIKE pmdn_t.pmdn050,
          pmdn052      LIKE pmdn_t.pmdn052,
          pmdn200      LIKE pmdn_t.pmdn200 
                     END RECORD 

  DEFINE l_pmdo    DYNAMIC ARRAY OF RECORD
         pmdoseq      LIKE pmdo_t.pmdoseq,
         pmdoseq1     LIKE pmdo_t.pmdoseq1,
         pmdoseq2     LIKE pmdo_t.pmdoseq2,
         pmdo003      LIKE pmdo_t.pmdo003,
         pmdo006      LIKE pmdo_t.pmdo006,
         pmdo011      LIKE pmdo_t.pmdo011,
         pmdoud001    LIKE pmdo_t.pmdoud001
                  END RECORD
  
                   
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_cnt2        LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_node1       xml.DomNode
   DEFINE l_cnt1        LIKE type_t.num5 
   DEFINE l_doctype     STRING
   DEFINE l_begin       LIKE type_t.num5
   DEFINE l_e8          LIKE type_t.chr1
   DEFINE l_e2length    LIKE type_t.num5
   DEFINE l_e4length    LIKE type_t.num5
   DEFINE l_e3length    LIKE type_t.num5
   DEFINE l_e1length    LIKE type_t.num5
   DEFINE l_success     STRING
   DEFINE l_success2    STRING   
   DEFINE l_str         STRING
   DEFINE l_request_root xml.DomNode
   DEFINE l_node           xml.DomNode
   DEFINE lr_result         RECORD
                              status LIKE type_t.num5,
                              data   STRING
                            END RECORD

   DEFINE l_pmdl_result         RECORD
                                TENANTGROUP     LIKE pmdl_t.pmdlent,
                                ERP_FORM_NO     LIKE pmdl_t.pmdldocno,
                                DOC_TYPE_CODE   LIKE type_t.chr5,
                                DOC_NO          LIKE pmdl_t.pmdldocno,
                                tran_status     LIKE type_t.chr2,    
                                tran_time       LIKE type_t.chr20
                                
                               END RECORD
   DEFINE l_param   RECORD
             doc_type_parent LIKE type_t.chr5     #单据大类  
                    END RECORD
   DEFINE l_service   RECORD
                        prod     STRING,   #產品別
                        srvname  STRING,   #服務名稱
                        async    BOOLEAN,  #非同步(option)
                        request  STRING,
                        id       STRING,
                        ip       STRING
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
   LET l_success2 = 'Y'
   CALL apmp100_get_doctype_relues() RETURNING l_e8,l_e1length,l_e2length,l_e3length,l_e3length  #单别阶段
   LET l_enterprise = g_enterprise
   #定义cursor
   LET g_forupd_sql = "SELECT pmdlent,pmdldocno,pmdlsite,pmdldocdt,pmdlcrtdt,pmdlmoddt,pmdl001,pmdl002,pmdl003,",
                            " pmdl004,pmdl005,pmdl009,pmdl010,pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl025,",
                            " pmdl026,pmdl029,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,pmdl044,pmdl208",
                            " FROM pmdl_t WHERE pmdlent = ? AND pmdldocno = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)              #转换不同资料库语法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)            #遮蔽特定资料
   DECLARE apmp100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   LET g_middb = cl_eai_db_connect(g_dbs)
   SET CONNECTION g_middb
   IF status THEN DISPLAY  'connect to  g_middb error:',status RETURN  END IF
   LET ls_sql = "SELECT '',pmdlent,pmdldocno,pmdlsite,pmdldocdt,pmdlcrtdt,pmdlmoddt,pmdl001,pmdl002,pmdl003,",
                      " pmdl004,pmdl005,pmdl009,pmdl010,pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl025,",
                      " pmdl026,pmdl029,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,pmdl044,pmdl208,",
                      " status,erpold_stus,tran_status,tran_time",
                      " FROM b2b_pmdl_t ",
                      " WHERE pmdlsite IN (SELECT ooabsite FROM all_ooab02_v WHERE ooabent = '" ,l_enterprise,"' AND ",
                      " ooab001 = 'S-SYS-0002' AND ooab002 = 'Y')",
                      " AND pmdlent = '",l_enterprise,"'",
                      " AND pmdlstus = 'Y'",
                      " AND tran_status = 'N' ",
                      " ORDER BY tran_time ASC"
   PREPARE apmp100_sel_pmdl_pr FROM ls_sql
   DECLARE apmp100_sel_pmdl_cs CURSOR FOR apmp100_sel_pmdl_pr
   
   LET l_sql = "SELECT pmdnseq,pmdn001,pmdn006,pmdn007,pmdn011,pmdn012,pmdn013,pmdn016,pmdn017,pmdn021,",
                     " pmdn022,pmdn024,pmdn028,pmdn046,pmdn047,pmdn048,pmdn050,pmdn052,pmdn200",
                     " FROM b2b_pmdn01_v ",
                     " WHERE pmdnent = ? AND pmdndocno = ? ORDER BY pmdnseq "
  
   PREPARE apmp100_sel_pmdn_pr FROM l_sql
   DECLARE apmp100_sel_pmdn_cs CURSOR FOR apmp100_sel_pmdn_pr
   
   LET l_sql1 = "SELECT pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo006,pmdo011,pmdoud001",
                     " FROM b2b_pmdo01_v ",
                     " WHERE pmdoent = ? AND pmdodocno = ? AND pmdo003 = '1' ",
                     " ORDER BY pmdoseq,pmdoseq1,pmdoseq2"
  
   PREPARE apmp100_sel_pmdo_pr FROM l_sql1
   DECLARE apmp100_sel_pmdo_cs CURSOR FOR apmp100_sel_pmdo_pr
   
   
   DISPLAY 'start foreach:',cl_get_current()
   INITIALIZE l_pmdl.* TO NULL
   FOREACH apmp100_sel_pmdl_cs INTO  l_pmdl.*
      #1019------add-------------begin----------------
      IF SQLCA.sqlcode THEN
         EXIT FOREACH
      END IF
      #1019------add-------------end----------------
      LET l_pmaa098='N'
      SELECT pmaa098 INTO l_pmaa098 FROM all_pmaa01_v 
       WHERE pmaaent=l_enterprise AND pmaa001=l_pmdl.pmdl004
      #1019------add-------------begin---------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "reproduce:",SQLERRMESSAGE
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         EXIT FOREACH
      END IF
      #1019------add-------------end----------------
 
      IF l_pmaa098 <> 'Y' THEN
         CONTINUE FOREACH 
       ELSE
         DISPLAY 'l_pmaa098 = y'
         DISPLAY l_pmdl.pmdldocno
      END IF
   
      LET l_param.doc_type_parent = 'K'
      CALL cl_ws_create_request() RETURNING l_request_root   #组xml 请求段落
      CALL cl_ws_addParameterRecord(util.JSONObject.fromFGL(l_param))  #组param
      #截取单号中的单别
      LET l_str = l_pmdl.pmdldocno
      IF l_e8 = '1' THEN  #据点+单别 取第二段
         LET l_begin = l_e3length + l_e2length
         LET l_doctype = l_str.subString(l_begin+1,l_begin+l_e1length)
      ELSE
         LET l_begin = 0  #单别+据点取第一段
          LET l_doctype = l_str.subString(l_begin+1,l_e1length)
      END IF 
      LET l_pmdl.doctype = l_doctype 
      #组xml 
      LET l_node =  cl_ws_addMasterRecord("pmdl_t",util.JSONObject.fromFGL(l_pmdl))     #单头节点数据获取
      LET l_cnt = 1
      FOREACH  apmp100_sel_pmdn_cs USING l_pmdl.pmdlent,l_pmdl.pmdldocno INTO l_pmdn[l_cnt].* 
         IF SQLCA.sqlcode THEN
            EXIT FOREACH
         END IF
         CALL cl_ws_addDetailRecord(l_node , "pmdn_t",util.JSONObject.fromFGL(l_pmdn[l_cnt]) , l_cnt)  #单身节点数据获取
         LET l_cnt = l_cnt + 1
      END FOREACH
      CALL l_pmdn.deleteelement(l_cnt)
      LET l_cnt = l_cnt - 1
      DISPLAY 'l_cnt=',l_cnt    
      LET l_cnt1 = 1
      FOREACH apmp100_sel_pmdo_cs USING l_pmdl.pmdlent,l_pmdl.pmdldocno INTO l_pmdo[l_cnt1].*
         IF SQLCA.sqlcode THEN
            EXIT FOREACH
         END IF
         CALL cl_ws_addDetailRecord(l_node,"pmdo_t",util.JSONObject.fromFGL(l_pmdo[l_cnt1]) , l_cnt1) #子单身节点数据获取
         LET l_cnt1 = l_cnt1 +1
      END FOREACH
      CALL l_pmdo.deleteelement(l_cnt1)
      LET l_cnt1 = l_cnt1 - 1  

      SET CONNECTION g_dbs 
      IF status THEN DISPLAY 'connect to g_dbs error:',status EXIT FOREACH END IF 
      LET l_service.ip =  cl_get_para(g_enterprise,"","E-SYS-0721")
      LET l_service.id =  cl_get_para(g_enterprise,"","E-SYS-0722")
      LET l_service.prod    = "EC_B2B"
      LET l_service.srvname = "SETsales_order"
      LET l_service.request = l_request_root.toString()
      DISPLAY 'start to eai',cl_get_current()
      CALL cl_eai_invokeSrv(util.JSONObject.fromFGL(l_service)) RETURNING lr_result.*
      DISPLAY 'end to eai',cl_get_current()      
      IF  status THEN DISPLAY 'call cross error:',status EXIT FOREACH  END IF 
      LET l_cnt = 0 
      IF lr_result.status = 0 THEN
       LET l_resp_root = cl_ws_stringToXml(lr_result.data)  #读取response string
       #读取 Master node
       LET l_cnt = cl_ws_getMasterRecordLength("T_A_SO_ORDER") 
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'wss-00002'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          RETURN
       END IF
       LET l_node = cl_ws_getMasterRecord(l_cnt,'T_A_SO_ORDER')  
       LET l_pmdl_result.TENANTGROUP        = cl_ws_getRecordField(l_node ,"TENANTGROUP")
       LET l_pmdl_result.ERP_FORM_NO        = cl_ws_getRecordField(l_node ,"ERP_FORM_NO")
       LET l_pmdl_result.DOC_TYPE_CODE      = cl_ws_getRecordField(l_node ,"DOC_TYPE_CODE")   
       LET l_pmdl_result.DOC_NO             = cl_ws_getRecordField(l_node ,"DOC_NO")
       LET l_pmdl_result.tran_status        = cl_ws_getRecordField(l_node ,"tran_status")
       LET l_pmdl_result.tran_time          = cl_ws_getRecordField(l_node ,"tran_time")
       
       IF cl_null(l_pmdl_result.DOC_NO) OR cl_null(l_pmdl_result.DOC_TYPE_CODE) THEN
          LET l_pmdl_result.DOC_NO = '' 
       ELSE
          LET l_pmdl_result.tran_status = 'Y'       
       END IF
       
       IF cl_null(l_pmdl.pmdl208) AND l_pmdl_result.tran_status = 'Y' THEN
       CALL s_transaction_begin() 
       OPEN apmp100_cl USING g_enterprise,l_pmdl_result.DOC_NO
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "OPEN apmp100_cl:"
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          CLOSE apmp100_cl
          CALL s_transaction_end('N','0')
          RETURN
       END IF
       UPDATE pmdl_t SET pmdl208 = l_pmdl_result.DOC_NO
           WHERE  pmdlent = l_pmdl_result.TENANTGROUP
             AND  pmdldocno = l_pmdl_result.ERP_FORM_NO
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = "upd pmdl_t"
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           LET l_success2 = 'N'
           CALL s_transaction_end('N','0')
           RETURN
        END IF
        CALL s_transaction_end('Y','0')  
        CLOSE apmp100_cl        
        END IF              
           
       #切回中间库更新传输状态
       SET CONNECTION g_middb   
       IF status THEN DISPLAY 'connect to g_middb error:',status EXIT FOREACH  END IF 
       IF l_success2 = 'Y' THEN  
         DISPLAY 'tran_status:',l_pmdl_result.tran_status
         UPDATE b2b_pmdl_t SET tran_status = l_pmdl_result.tran_status    #传输状态
         WHERE pmdlent = l_pmdl_result.TENANTGROUP
         AND pmdldocno = l_pmdl_result.DOC_NO
         AND tran_time = l_pmdl_result.tran_time
               
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "upd b2b_pmdl_t"
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
   IF status THEN DISPLAY 'connect to g_dbs error:',status RETURN  END IF 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp100_process_cs CURSOR FROM ls_sql
#  FOREACH apmp100_process_cs INTO
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
   CALL apmp100_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp100.get_buffer" >}
PRIVATE FUNCTION apmp100_get_buffer(p_dialog)
 
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
 
{<section id="apmp100.msgcentre_notify" >}
PRIVATE FUNCTION apmp100_msgcentre_notify()
 
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
 
{<section id="apmp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp100_get_doctype_relues (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp100_get_doctype_relues()
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
 
