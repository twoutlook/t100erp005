#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp910.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000000
#+ 
#+ Filename...: awsp910
#+ Description: 
#+ Creator....: 00544(2016-03-18 17:14:20)
#+ Modifier...: 00000() -SD/PR- 00544
 
{</section>}
 
{<section id="awsp910.global" >}
#應用 p01 樣板自動產生(Version:14)
#add-point:填寫註解說明

#end add-point 
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目
IMPORT com
IMPORT xml
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
GLOBALS "../../cfg/top_ws.inc"
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE req        com.HTTPServiceRequest
 

 

 
 
{</section>}
 
{<section id="awsp910.main" >}
MAIN
   #add-point:main段define (客製用)

   #end add-point 
   
   #add-point:main段define 
   DEFINE l_port          STRING
   DEFINE l_argv01        STRING
   DEFINE l_master        util.JSONObject
   DEFINE l_detail        util.JSONArray
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("aws","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   CALL awsp900_01_init()
   CALL cl_db_connect("ds", FALSE) 
   #end add-point
   
   DISPLAY "ARGS:", NUM_ARGS()
        
   CASE        #根据传入的参数数量决定相应的动作
      WHEN NUM_ARGS()= 1
         LET l_master = util.JSONObject.parse(ARG_VAL(1)) #parse json
         LET l_detail = l_master.get("param")
         LET l_argv01 = l_detail.get(1)
                  
         IF l_argv01 = "-S" THEN
            LET l_port = l_detail.get(2)      
         END IF
   END CASE      
   
   IF NOT cl_null(l_port) THEN      
      CALL fgl_setenv("FGLAPPSERVER", l_port)
   END IF      
   
   CALL awsp910_startServer()
    
   
     

     
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp910.init" >}
#+ 初始化作業
 

  

   

  
 
{</section>}
 
{<section id="awsp910.ui_dialog" >}
#+ 選單功能實際執行處
 

  

   

 
 
   

     

     

  

 
 
 
        

           

         

           
        

        

     

 
 
{</section>}
 
{<section id="awsp910.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
 

 

 

 
{</section>}
 
{<section id="awsp910.process" >}
 
   

  

  
 

 

 

 
 
  

    

 
 
{</section>}
 
{<section id="awsp910.get_buffer" >}

   

  

 
 
{</section>}
 
{<section id="awsp910.msgcentre_notify" >}
 
  

 
  

 

 
{</section>}
 
{<section id="awsp910.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp910_startServer()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp910_startServer()
     
   #--------------------------------------------------------------------------#
   # 啟動服務                                                                  #
   #--------------------------------------------------------------------------#
   CALL com.WebServiceEngine.Start()

   DISPLAY "START T100 Restful Service ..."
   DISPLAY ""
   
   WHILE TRUE

      #---------------------------------------------------------------------#
      # 處理呼叫的服務                                                       #
      #---------------------------------------------------------------------#
      TRY
         LET req = com.WebServiceEngine.GetHttpServiceRequest(-1)
       
         #開放 POST 的請求方法
         IF req.getMethod() = "POST" THEN
            CALL awsp910_invokeSrv()
         ELSE
            CALL req.sendTextResponse(200,"", "Restful service is ok")
         END IF
      CATCH          
         DISPLAY "#--- (", cl_get_current() , ") code:" , STATUS ," msg:",SQLCA.SQLERRM         
         LET STATUS = 0  #必須清空
         EXIT WHILE           
      END TRY
   END WHILE
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp910_invokeSrv()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp910_invokeSrv()
   DEFINE l_req_doc              xml.DomDocument   
   DEFINE l_time                 STRING  
   DEFINE l_req                  STRING
   DEFINE l_resp_str             STRING

   LET l_req = req.readTextRequest()
   #DISPLAY "Content:" ,l_req
  
   IF NOT cl_null(l_req) THEN
      LET l_time = CURRENT HOUR TO FRACTION(3)
      #產生輸入檔案路徑
      LET g_request_file_path = fgl_getenv("TEMPDIR"), "/",
                "http_request_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"
      #產生輸出檔案路徑
      LET g_response_file_path = fgl_getenv("TEMPDIR"), "/",
                "http_response_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"

      LET l_req_doc = xml.DomDocument.create()
      CALL l_req_doc.loadFromString(l_req)
      CALL l_req_doc.save(g_request_file_path)

      DISPLAY "#----- awsp900_02_invokeSrv start:" ,cl_get_current()
      CALL awsp900_02_invokeSrv()     
      DISPLAY "#----- awsp900_02_invokeSrv end:" ,cl_get_current()
      #產出 response xml
      LET l_resp_str = g_response.response 
   END IF

   CALL req.setResponseCharset("utf-8")
   CALL req.sendTextResponse(200,"", l_resp_str )
END FUNCTION

#end add-point
 
{</section>}
 
