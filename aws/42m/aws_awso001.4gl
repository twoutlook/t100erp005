#+ Version..: T6-ERP-1.00.00 Build-000005
#
# Program name...: awso001.4gl
# Descriptions...: TIPTOP Services 服务代码((Service GateWay)
# Date & Author..: 
# Modify.........: 
 
#引用com库，保证下面的WebService类能够正常使用 
IMPORT com
IMPORT xml 
 
#指定程序中LIKE table引用的schema为ds.sch 
SCHEMA ds

#引用标准的全局变量 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/awsp900.inc"   #TIPTOP Service Gateway 使用的全域變數檔

DEFINE   g_serv              com.WebService
 
MAIN

DEFINE   l_action            LIKE type_t.num10,
         l_port              STRING,
         l_url               STRING

   OPTIONS
       ON CLOSE APPLICATION STOP
       DEFER INTERRUPT
       WHENEVER ERROR CONTINUE

    #LET g_prog = "awso001"                 #程序编号
    LET g_user = "tiptop"                  #当前运行的用户
    LET g_bgjob = "Y"                      #是否以后台方式运行
    LET g_gui_type = 0                     #后台方式必须指定gui_type=0
    LET g_lang = 2                         #默认语言别（0 - 繁体，1 - 英文，2 - 简体
    LET g_today = TODAY                    #默认的当前日期
    LET g_time = TIME                      #默认系统当前时间 

    LET l_port =  NUM_ARGS()

    #依模組進行系統初始化設定(系統設定)
    CALL cl_ap_init("aws","")   #FUN-T100
    
    #切換至使用者所需要的資料庫 (營運中心)  #todo
    DISCONNECT CURRENT #todo
    CONNECT TO "ds" #todo
    DISPLAY 'connect:ds->',STATUS

 
    LET l_action = -1 
    LET l_port = NULL
    display "ARGS:", NUM_ARGS()

    CASE        #根据传入的参数数量决定相应的动作
         WHEN NUM_ARGS()= 1
              #----------------------------------------------------------------#
              # 透過 Application Server(gasd) 模式啟動 4GL Web Services 程式   #
              #----------------------------------------------------------------#
              IF fgl_getenv("FGLAPPSERVER") IS NOT NULL THEN
                 LET l_action = 2         
              END IF
         WHEN NUM_ARGS()=7
              #CASE ARG_VAL(1) CLIPPED
              CASE g_argv[1] CLIPPED
                   #-----------------------------------------------------------#
                   # 指定參數產生 WSDL 檔案                                    #
                   #-----------------------------------------------------------#
                   WHEN "-W"
                        LET l_action = 1
                        #LET l_url = ARG_VAL(2)
                        LET l_url = g_argv[2]
                   #-----------------------------------------------------------#
                   # 透過 standalone(r.r2) 模式啟動 4GL Web Services 程式      #
                   #-----------------------------------------------------------#
                   WHEN "-S"
                        LET l_action = 2
                        #LET l_port = ARG_VAL(2)
                        LET l_port = g_argv[2]
                        display "port:", l_port
              END CASE
    END CASE
    display "action:",l_action
    #--------------------------------------------------------------------------#
    # 若沒有指定正確的參數                                                     #
    #--------------------------------------------------------------------------#
    IF l_action = -1 THEN
       CALL aws_ttsrv_help()
       EXIT PROGRAM
    END IF
    
    #--------------------------------------------------------------------------#
    # 建立 Web Services 服務                                                   #
    #--------------------------------------------------------------------------#
    CALL aws_ttsrv_createService()
 
    display "start"
    CASE l_action
         WHEN 1            
              CALL aws_ttsrv_generateWSDL(l_url)
         WHEN 2
              CALL aws_ttsrv_startServer(l_port)
    END CASE     
END MAIN
 
 
#[
# Description....: 顯示執行時參數說明
# Date & Author..: 2012/12/10 by wangxy 
# Parameter......: none
# Return.........: none
# Memo...........:
# Modify.........:
#
#]
FUNCTION aws_ttsrv_help()
    DISPLAY "Usage:"
    DISPLAY "  r.r awso001 -W serverURL  (Generate WSDL file)"
    DISPLAY "  r.r awso001 -S serverPort (Start service)"
    DISPLAY "  r.r awso001 -h            (Display This Help)"
    DISPLAY "Example:"
    DISPLAY "  r.r2 awso001 -W http://localhost:8090"
    DISPLAY "  r.r2 awso001 -S 8090"
    EXIT PROGRAM
END FUNCTION
 
 
#[
# Description....: 建立 Web Service 
# Date & Author..: 2012/12/10 by wangxy 
# Parameter......: none
# Return.........: none
# Memo...........:
# Modify.........:
#
#]
FUNCTION aws_ttsrv_createService()
    DEFINE l_op        com.WebOperation
    DEFINE l_ns        STRING
    
    LET l_ns = "http://www.digiwin.com.cn/tiptop/TIPTOPServiceGateWay"   #指定 Namespace
    LET g_serv = com.WebService.CreateWebService("TIPTOPServiceGateWay", l_ns)    #注册总的WebService
    #CALL g_serv.setFeature("Soap1.1",TRUE)
    LET l_op = com.WebOperation.CreateRPCStyle("aws_invokeSrv","invokeSrv", g_request, g_response)
    CALL g_serv.publishOperation(l_op, NULL)
END FUNCTION
 
#[
# Description....: 產生 TIPTOP Web Services WSDL 檔案
# Date & Author..: 2012/12/10 by wangxy 
# Parameter......: p_url - STRING - 服務網址
# Return.........: none
# Memo...........:
# Modify.........:
#
#]
FUNCTION aws_ttsrv_generateWSDL(p_url)
    DEFINE p_url   STRING,
           l_ret   LIKE type_t.num10
 
           
    #--------------------------------------------------------------------------#
    # 當變數為 CHAR/VARCHAR, 視為 STRING 不特別再指定 size                     #
    #--------------------------------------------------------------------------#
    CALL com.WebServiceEngine.SetOption("wsdl_stringsize", FALSE) 
    display "wsdl"
    #--------------------------------------------------------------------------#
    # 產生 WSDL 檔, 並顯示執行訊息                                             #
    #--------------------------------------------------------------------------#
    LET l_ret = g_serv.saveWSDL(p_url)
    IF l_ret = 0 THEN
       DISPLAY "'TIPTOPServiceGateWay.wsdl' generated successfully."
    ELSE
       DISPLAY "'TIPTOPServiceGateWay.wsdl' generated failed."
    END IF
END FUNCTION
 
 
#[
# Description....: 啟動 TIPTOP Service 程序進行服務
# Date & Author..: 2012/12/10 by wangxy 
# Parameter......: p_port - STRING - 服務 listen port
# Return.........: none
# Memo...........:
# Modify.........:
#
#]
FUNCTION aws_ttsrv_startServer(p_port)
    DEFINE p_port     STRING,
           l_ret      LIKE type_t.num10,
           l_msg      STRING,
           l_serial   STRING
 
    #--------------------------------------------------------------------------#
    # 若模式為 standalone(r.r2) 模式, 則需手動指定 listen port                 #
    #--------------------------------------------------------------------------#
    IF NOT cl_null(p_port) THEN
       CALL fgl_setenv("FGLAPPSERVER", p_port)
    END IF
    
    #--------------------------------------------------------------------------#
    # 啟動服務                                                                 #
    #--------------------------------------------------------------------------#    
    LET l_serial = FGL_GETPID() USING '<<<<<<<<<<'
    CALL com.WebServiceEngine.RegisterService(g_serv)  
    CALL com.WebServiceEngine.Start()
    
    DISPLAY "[", TODAY USING 'YYYY/MM/DD', " ", TIME, " #", l_serial ,"] START TIPTOP Service Gateway  ..."
    DISPLAY ""
 
    WHILE TRUE

        #----------------------------------------------------------------------#
        # 處理呼叫的服務                                                       #
        #----------------------------------------------------------------------#
        LET l_ret = com.WebServiceEngine.ProcessServices(-1)
        DISPLAY "l_ret:",l_ret
 
        #----------------------------------------------------------------------#
        # 服務處理後狀態值顯示, '0' 表正常處理, 其餘回傳值表各種 error 狀態    #
        #----------------------------------------------------------------------#
        CASE l_ret
            WHEN 0         
                 #回傳 Response 後，若有需要背景執行功能可以加在此funcation裡
                 LET l_msg = "Rquest processed successfully."
            WHEN -1
                 LET l_msg = "Time out reached."
            WHEN -2
                 LET l_msg = "Disconnected from application server."
            WHEN -3
                 LET l_msg = "Lost connection with the client."
            WHEN -4
                 LET l_msg = "Server process has been interrupted with Ctrl-C."
            WHEN -5
                 LET l_msg = "Bad HTTP request received."
            WHEN -6
                 LET l_msg = "Malformed or bad SOAP envelope received."
            WHEN -7
                 LET l_msg = "Malformed or bad XML document received."
            WHEN -8
                 LET l_msg = "HTTP error."
            WHEN -9
                 LET l_msg = "Unsupported operation."
            WHEN -10
                 LET l_msg = "Internal server error."
            WHEN -11
                 LET l_msg = "WSDL Generation failed."
            WHEN -12
                 LET l_msg = "WSDL Service not found."
            WHEN -13
                 LET l_msg = "Reserved."
            WHEN -14
                 LET l_msg = "Incoming request overflow."
            WHEN -15
                 LET l_msg = "Server was not started."
            WHEN -16
                 LET l_msg = "Request still in progress."
            WHEN -17
                 LET l_msg = "Stax response error."
        END CASE
        
        DISPLAY "  (", TODAY USING 'YYYY/MM/DD', " ", TIME, " #", l_serial, ") ", l_msg
        DISPLAY ""

        IF INT_FLAG OR l_ret = -2 OR l_ret = -10 OR l_ret = -15 OR l_ret = -8 THEN
           DISPLAY "[", TODAY USING 'YYYY/MM/DD', " ", TIME, " #", l_serial, "] STOP TIPTOP Service Gateway  ..."
           EXIT WHILE
        END IF
    END WHILE
END FUNCTION

#提供服務呼叫

FUNCTION aws_invokeSrv()
   DEFINE l_dom_doc              om.DomDocument
   DEFINE l_dom_node             om.DomNode

   #產生輸入檔案路徑(路徑和唯一檔名+_input)
   LET g_request_file_path = fgl_getenv("TEMPDIR"), "/",
       "ttsrv_request_",FGL_GETPID() USING '<<<<<<<<<<',".xml"

   #產生輸出檔案路徑(路徑和唯一檔名+_output)
   LET g_response_file_path = fgl_getenv("TEMPDIR"), "/",
       "ttsrv_response_",FGL_GETPID() USING '<<<<<<<<<<',".xml"

   
   LET l_dom_doc = om.DomDocument.createFromString(g_request.request)
   LET l_dom_node = l_dom_doc.getDocumentElement()
   CALL l_dom_node.writeXml(g_request_file_path)

   CALL awsp900_02_invokeSrv()

END FUNCTION
