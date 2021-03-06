#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp900.description" >}
#161031-00058  2016/11/01 By Hank Wu  1.新增目錄新增判斷 2.修改檔案產生路徑及名稱
#161118-00009  2016/11/18 By Hank Wu  1.還原目錄以及檔案產生路徑寫法
{</section>}
 
{<section id="awsp900.global" >}
IMPORT os
IMPORT util
IMPORT com
IMPORT xml
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_ws.inc"
 
DEFINE   g_serv              com.WebService
 
{</section>}
 
{<section id="awsp900.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   
   DEFINE l_action   LIKE type_t.num10,
          l_port     STRING,
          l_url      STRING
   DEFINE l_argv01   STRING
   DEFINE l_master   util.JSONObject
   DEFINE l_detail   util.JSONArray
   

   display "awsp900 start"
   CALL awsp900_01_init()
   #end add-point    
 
   #定義在其他link的程式則無效
 
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("aws","")
 
   #add-point:作業初始化
   #CALL awsp900_01_init()  #初始變數
   CALL cl_db_connect("ds",FALSE)
   
   #end add-point
   LET l_action = -1
   LET l_port = NULL
   display "ARGS:", NUM_ARGS()
   
   CASE   #根据传入的参数数量决定相应的动作
      WHEN NUM_ARGS()= 0
         IF fgl_getenv("FGLAPPSERVER") IS NOT NULL THEN
            LET l_action = 2
         END IF
 
      WHEN NUM_ARGS()= 1
         
         LET l_argv01 = ARG_VAL(1)
         IF NOT cl_null(l_argv01) AND l_argv01.subString(1,1) == "{" THEN
            LET l_master = util.JSONObject.parse(ARG_VAL(1)) #parse json
            LET l_detail = l_master.get("param")
            LET l_argv01 = l_detail.get(1)			  
         ELSE			  
            LET l_argv01 = ARG_VAL(1)
         END IF
                    
         #----------------------------------------------------------------#
         # 透過 Application Server(gasd) 模式啟動 4GL Web Services 程式   #
         #----------------------------------------------------------------#
         #CASE ARG_VAL(1) CLIPPED
         #CASE g_argv[1] CLIPPED
         CASE l_argv01 CLIPPED                         
            #-----------------------------------------------------------#
            # 指定參數產生 WSDL 檔案                                    #
            #-----------------------------------------------------------#
            WHEN "-W"              
               LET l_action = 1
               #LET l_url = ARG_VAL(2)
               #LET l_url = g_argv[2]
               LET l_url = l_detail.get(2)
            #-----------------------------------------------------------#
            # 透過 standalone(r.r) 模式啟動 4GL Web Services 程式      #
            #-----------------------------------------------------------#                        
            WHEN "-S"                      
               LET l_action = 2
               #LET l_port = ARG_VAL(2)
               #LET l_port = g_argv[2]
               LET l_port = l_detail.get(2)
               display "port:", l_port                                               
            OTHERWISE
               IF fgl_getenv("FGLAPPSERVER") IS NOT NULL THEN
                  LET l_action = 2
               END IF
         END CASE   
              
      WHEN NUM_ARGS()=7                    
         
         #----------------------------------------------------------------#
         # 透過 Application Server(gasd) 模式啟動 4GL Web Services 程式   #
         #----------------------------------------------------------------#  			                
         #CASE g_argv[1] CLIPPED
         CASE ARG_VAL(6) CLIPPED
            #-----------------------------------------------------------#
            # 指定參數產生 WSDL 檔案                                    #
            #-----------------------------------------------------------#
            WHEN "-W"
               LET l_action = 1                        
               #LET l_url = g_argv[2]
               LET l_url = ARG_VAL(7)
            #-----------------------------------------------------------#
            # 透過 standalone(r.r) 模式啟動 4GL Web Services 程式      #
            #-----------------------------------------------------------#
            WHEN "-S"
               LET l_action = 2                        
               #LET l_port = g_argv[2]
               LET l_port = ARG_VAL(7)
               display "port:", l_port
         END CASE
   END CASE
    
   display "action:",l_action
    
   #--------------------------------------------------------------------------#
   # 若沒有指定正確的參數                                                     #
   #--------------------------------------------------------------------------#
   IF l_action = -1 THEN
      CALL awsp900_help()    
   ELSE 
      #--------------------------------------------------------------------------#
      # 建立 Web Services 服務                                                   #
      #--------------------------------------------------------------------------#
      
      CALL awsp900_createService()
      
      display "start"       
      CASE l_action
         WHEN 1
            CALL cl_log_service_start("W" ,"")
            CALL awsp900_generateWSDL(l_url)
                 
         WHEN 2
            CALL cl_log_service_start("G" ,l_port)
            CALL awsp900_startServer(l_port)
                 
      END CASE    
   END IF
   #add-point:SQL_define

   #end add-point
   
  
 
   #add-point:作業離開前
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="awsp900.other_function" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_help()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_help()

    DISPLAY "Usage:"
    DISPLAY "  r.r awsp900 -W serverURL  (Generate WSDL file)"
    DISPLAY "  r.r awsp900 -S serverPort (Start service)"
    DISPLAY "  r.r awsp900 -h            (Display This Help)"
    DISPLAY "Example:"
    DISPLAY "  r.r awsp900 -W http://localhost:8090"
    DISPLAY "  r.r awsp900 -S 8090"
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_createService()
    DEFINE l_op        com.WebOperation
    DEFINE l_ns        STRING

    LET l_ns = "http://www.digiwin.com.cn/tiptop/TIPTOPServiceGateWay"   #指定 Namespace
    LET g_serv = com.WebService.CreateWebService("TIPTOPServiceGateWay", l_ns)    #注册总的WebService
    #CALL g_serv.setFeature("Soap1.1",TRUE)
    LET l_op = com.WebOperation.CreateRPCStyle("awsp900_invokeSrv","invokeSrv", g_request, g_response)
    CALL g_serv.publishOperation(l_op, NULL)
    
    LET l_op = com.WebOperation.CreateRPCStyle("awsp900_invokeMdm","invokeMdm", g_request, g_response)
    CALL g_serv.publishOperation(l_op, NULL)
    
    LET l_op = com.WebOperation.CreateRPCStyle("awsp900_syncProd","syncProd", g_request, g_response)
    CALL g_serv.publishOperation(l_op, NULL)

    LET l_op = com.WebOperation.CreateRPCStyle("awsp900_callbackSrv","callbackSrv", g_request, g_response)
    CALL g_serv.publishOperation(l_op, NULL)
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_generateWSDL (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_generateWSDL(p_url)
    DEFINE p_url   STRING,
           l_ret   LIKE type_t.num10
                        
    #--------------------------------------------------------------------------#
    # 當變數為 CHAR/VARCHAR, 視為 STRING 不特別再指定 size                     #
    #--------------------------------------------------------------------------#
    CALL com.WebServiceEngine.SetOption("wsdl_stringsize", FALSE)
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

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_startServer(p_port)
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

    DISPLAY "[", cl_get_today() ," ", cl_get_time() , " #" , l_serial ,"] START T100 Service Gateway  ..."
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
        
        DISPLAY "  (", cl_get_current() , " #", l_serial, ") ", l_msg
        DISPLAY ""

        IF INT_FLAG OR l_ret = -2 OR l_ret = -10 OR l_ret = -15 OR l_ret = -8 THEN
           DISPLAY "[", cl_get_today() ," ", cl_get_time() , " #", l_serial, "] STOP T100 Service Gateway  ..."
           EXIT WHILE
        END IF
    END WHILE
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_invokeSrv()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_invokeSrv()
   DEFINE l_req_doc              xml.DomDocument   
   DEFINE l_time                 STRING
   DEFINE l_today                STRING                #161031-00058  2016/11/01 Hank Wu
   DEFINE l_return               LIKE type_t.num5      #161031-00058  2016/11/01 Hank Wu

   
   DISPLAY cl_time_trans_by_tz("system_time") #設定時區
   
   LET l_time = CURRENT HOUR TO FRACTION(3)
   #161118-00009  2016/11/01 Hank Wu   START
   LET l_today = cl_get_today()
   LET l_today = cl_replace_str(l_today,"-","")
   DISPLAY "l_today=",l_today
   
   
   IF os.Path.isdirectory(os.Path.join(fgl_getenv("TEMPDIR"),l_today)) THEN 
   --IF os.Path.isdirectory(l_today)=0 THEN
      DISPLAY "boolean= ",os.Path.isdirectory(l_today)
      CALL os.Path.mkdir(l_today) RETURNING l_return
   END IF
   #161118-00009  2016/11/01 Hank Wu   END
   
   display "awsp900:  ",FGL_GETENV("FGLLDPATH")

   #產生輸入檔案路徑(路徑和唯一檔名+_input)
   LET g_request_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)        #161118-00009  2016/11/01 Hank Wu
   LET g_request_file_path = g_request_file_path,"/ws_request_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"
   

   #產生輸出檔案路徑(路徑和唯一檔名+_output)
   LET g_response_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)       #161118-00009  2016/11/01 Hank Wu
   LET g_response_file_path = g_response_file_path,"/ws_response_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"
   
   IF NOT cl_null(g_request.request) THEN  
      TRY   
         LET l_req_doc = xml.DomDocument.create()
         CALL l_req_doc.loadFromString(g_request.request)     
         CALL l_req_doc.save(g_request_file_path)
      CATCH
         DISPLAY 'Cannot create xml file.'
         LET g_status.code = "-1"
         #LET l_status.sqlcode = g_status.sqlcode
         LET g_status.description = "Cannot create xml file."
         LET g_response.response = awsp900_01_createExecptionRespond(g_response.response)
         CALL awsp900_01_create_response(g_response.response)
         RETURN         
      END TRY
   ELSE
      LET g_response.response= "<response><srvver>1.0</srvver><srvcode>100</srvcode></response>"      
      RETURN
   END IF
   
   CALL awsp900_02_invokeSrv()
   
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_invokeMdm()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_invokeMdm()
   DEFINE l_req_doc              xml.DomDocument   
   DEFINE l_time                 STRING
   DEFINE l_today                STRING                #161031-00058  2016/11/01 Hank Wu
   DEFINE l_return               LIKE type_t.num5      #161031-00058  2016/11/01 Hank Wu
   
   LET l_time = CURRENT HOUR TO FRACTION(3)
   
   #161118-00009  2016/11/01 Hank Wu   START
   LET l_today = cl_get_today()
   LET l_today = cl_replace_str(l_today,"-","")
   DISPLAY "l_today=",l_today

   IF os.Path.isdirectory(os.Path.join(fgl_getenv("TEMPDIR"),l_today)) = 0 THEN 
   --IF os.Path.isdirectory(l_today)=0 THEN
      DISPLAY "boolean= ",os.Path.isdirectory(l_today)
      CALL os.Path.mkdir(l_today)   
      RETURNING l_return
   END IF
   #161118-00009  2016/11/01 Hank Wu   END
   
   display "awsp900:  ",FGL_GETENV("FGLLDPATH")

   #產生輸入檔案路徑(路徑和唯一檔名+_input)
   LET g_request_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)        #161118-00009  2016/11/01 Hank Wu 
   LET g_request_file_path = g_request_file_path,"/ws_request_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"

   #產生輸出檔案路徑(路徑和唯一檔名+_output)
   LET g_response_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)       #161118-00009  2016/11/01 Hank Wu
   LET g_response_file_path = g_response_file_path,"/ws_response_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"
   
   IF NOT cl_null(g_request.request) THEN   
      LET l_req_doc = xml.DomDocument.create()
      CALL l_req_doc.loadFromString(g_request.request)     
      CALL l_req_doc.save(g_request_file_path)
   END IF
   
   CALL awsp900_04_invokeMdm()
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_syncProd()
   DEFINE l_req_doc              xml.DomDocument   
   DEFINE l_time                 STRING
   DEFINE l_today                STRING                #161031-00058  2016/11/01 Hank Wu
   DEFINE l_return               LIKE type_t.num5      #161031-00058  2016/11/01 Hank Wu

   
   LET l_time = CURRENT HOUR TO FRACTION(3)
   
   #161118-00009  2016/11/18 Hank Wu   START
   LET l_today = cl_get_today()
   LET l_today = cl_replace_str(l_today,"-","")
   DISPLAY "l_today=",l_today
   
   IF os.Path.isdirectory(os.Path.join(fgl_getenv("TEMPDIR"),l_today)) = 0 THEN 
   --IF os.Path.isdirectory(l_today)=0 THEN
      DISPLAY "boolean= ",os.Path.isdirectory(l_today)
      CALL os.Path.mkdir(l_today)   
      RETURNING l_return
   END IF
   #161118-00009  2016/11/18 Hank Wu   END
   
   #產生輸入檔案路徑(路徑和唯一檔名+_input)
   LET g_request_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)        #161118-00009  2016/11/18 Hank Wu
   LET g_request_file_path = g_request_file_path,"/ws_request_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"
   DISPLAY "g_request_file_path=",g_request_file_path
   #產生輸出檔案路徑(路徑和唯一檔名+_output)
   LET g_response_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)       #161118-00009  2016/11/18 Hank Wu
   LET g_response_file_path = g_response_file_path,"/ws_response_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"
   
   IF NOT cl_null(g_request.request) THEN   
      DISPLAY "request:" , g_request.request
      DISPLAY "syncProd xml Path:", g_request_file_path
      LET l_req_doc = xml.DomDocument.create()
      CALL l_req_doc.loadFromString(g_request.request)     
      CALL l_req_doc.save(g_request_file_path)      
   END IF
   
   CALL awsp900_04_syncProd()
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_callbackSrv()

END FUNCTION

{</section>}
 
