#該程式已解開Section, 不再透過樣板產出!
{<section id="apsp501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-05-21 12:10:15), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: apsp501
#+ Description: APS執行作業
#+ Creator....: 01588(2014-05-20 16:32:02)
#+ Modifier...: 01588 -SD/PR- 00000
 
{</section>}
 
{<section id="apsp501.global" >}
#160519-00052#1  20160613 By ming 此程式不會有畫面，所以在cl_ap_init前，需直接設定g_bgjob為Y 
#                                 才不會在使用排程跑背景執行時，出現gui的錯誤 
IMPORT util
IMPORT xml
IMPORT com
 
IMPORT JAVA com.dci.t100.run.RunAPS
IMPORT JAVA java.lang.Object
 
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
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)

   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="apsp501.main" >}
MAIN
   DEFINE l_gateway           com.dci.t100.run.RunAPS 
   DEFINE l_err1              STRING  
   DEFINE l_response          STRING
   DEFINE l_request_xml       STRING
   DEFINE l_filename          STRING
   DEFINE l_req_doc           xml.DomDocument
   DEFINE l_request_root      xml.DomNode
   #add-point:main段define

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
   
   #160519-00052#1 20160613 modify by ming -----(S) 
   #IF NOT cl_null(g_argv[1]) AND g_argv[1] = 'Y' THEN 
   #   LET g_bgjob = 'Y'
   #ELSE
   #   LET g_bgjob = 'N'
   #END IF
   
   LET g_bgjob = 'Y' 
   #160519-00052#1 20160613 modify by ming -----(E) 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js

   LET l_filename = g_argv[1]
   LET l_req_doc = xml.domDocument.create()
   CALL l_req_doc.load(l_filename)
   LET l_request_xml = l_req_doc.saveToString()
 
   IF NOT cl_null(l_request_xml) THEN
      TRY     
         #建立呼叫APS api閘道
         LET l_gateway = RunAPS.create()
         
         RUN "umask 000"
         LET l_response = l_gateway.run(l_request_xml)
         DISPLAY "response:", l_response, ";"
   
      CATCH
         LET l_err1 = ERR_GET(STATUS)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_err1
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         DISPLAY "ERR_GET(STATUS):\n", l_err1
         LET l_response = ""
      END TRY
   END IF

 

 

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp501.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apsp501_init()
   #add-point:init段define

   #end add-point

   #add-point:畫面資料初始化

   #end add-point

END FUNCTION

PRIVATE FUNCTION apsp501_process(ls_js)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE li_stus     LIKE type_t.num5
   DEFINE li_count    LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql      STRING             #主SQL













END FUNCTION

PRIVATE FUNCTION apsp501_transfer_argv(ls_js)
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter




END FUNCTION

PRIVATE FUNCTION apsp501_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define

   #end add-point

   #add-point:ui_dialog段before dialog















END FUNCTION

#end add-point
 
{</section>}
 
