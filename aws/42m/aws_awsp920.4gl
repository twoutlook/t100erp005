#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-08-04 16:57:53), PR版次:0005(2017-02-22 09:45:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000018
#+ Filename...: awsp920
#+ Description: 整合服務端Restful + JSON
#+ Creator....: 00544(2016-08-04 16:57:53)
#+ Modifier...: 00544 -SD/PR- 04182
 
{</section>}
 
{<section id="awsp920.global" >}
#應用 i00 樣板自動產生(Version:7)
#add-point:填寫註解說明
#Memos
#161014-00042  2016/11/01 By Hank Wu  1.將CALL req.setResponseHeader("Access-Control-Allow-Origin", "*")這段語法新增至awsp920的invokeSrv() 2.新增目錄新增判斷 3.修改檔案產生路徑及名稱
#161208-00039  2016/12/08 By yc.chao  新增中台restful接口處理
#161228-00023  2016/12/28 By yc.chao  新增中台檔案傳輸處理
#170222-00002  2017/02/22 By yc.chao  減少非必要的DISPLAY訊息
#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
IMPORT com
IMPORT xml
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_ws.inc"
 
#add-point:free_style模組變數(Module Variable)
GLOBALS "../../cfg/top_json.inc"   #161228-00023 add
#end add-point
 
#add-point:自定義模組變數(Module Variable)
DEFINE req             com.HTTPServiceRequest
DEFINE g_request_str   STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
MAIN
   DEFINE l_port          STRING
   DEFINE l_argv01        STRING
   DEFINE l_master        util.JSONObject
   DEFINE l_detail        util.JSONArray
   
   CALL cl_db_connect("ds", FALSE) 
   
   DISPLAY "ARGS:", NUM_ARGS()
 
   CASE        #根据传入的参数数量决定相应的动作
      WHEN NUM_ARGS()= 1
         LET l_master = util.JSONObject.parse(ARG_VAL(1)) #parse json
         LET l_detail = l_master.get("param")
         LET l_argv01 = l_detail.get(1)
 
         IF l_argv01 = "-S" THEN
            LET l_port = l_detail.get(2)
         END IF
         
      WHEN NUM_ARGS()=7
         LET l_port = ARG_VAL(7)
         display "port:", l_port   
         
   END CASE
 
   IF NOT cl_null(l_port) THEN
      CALL fgl_setenv("FGLAPPSERVER", l_port)
   END IF
      
   CALL awsp920_startServer()
    
END MAIN
{</section>}
 
{<section id="awsp920.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp920_startServer()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp920_startServer()
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
            CALL awsp920_invokeSrv()
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
# Usage..........: CALL awsp920_invokeSrv()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp920_invokeSrv()
   DEFINE l_req_doc            xml.DomDocument   
   DEFINE l_time               STRING 
   DEFINE l_resp_str           STRING
   DEFINE l_channel            base.Channel   
   DEFINE l_start              DATETIME HOUR TO FRACTION(3),
          l_end                DATETIME HOUR TO FRACTION(3)
   DEFINE l_today                STRING                #161014-00042  2016/11/01 Hank Wu
   DEFINE l_cmd                  STRING                #161014-00042  2016/11/01 Hank Wu
   DEFINE l_return               LIKE type_t.num5      #161014-00042  2016/11/01 Hank Wu
   DEFINE l_ver                STRING                  #161208-00039
   DEFINE l_req_header         STRING                  #161208-00039
   DEFINE l_guid               VARCHAR(32)             #161208-00039  
   DEFINE l_fn                 STRING                  #161208-00039
   DEFINE json_obj             util.JSONObject         #161208-00039
   DEFINE json_obj1            util.JSONObject         #161208-00039
   DEFINE buf                   base.StringBuffer      #161208-00039
   DEFINE cnt,ind               INTEGER                #161208-00039
   DEFINE l_headervalue         STRING                 #161208-00039
   DEFINE l_trans_type          STRING                 #161228-00023
   DEFINE l_zipdata             STRING                 #161228-00023
   DEFINE l_filename            STRING                 #161228-00023
   DEFINE l_filename1           STRING                 #161228-00023
   DEFINE l_request_str         STRING                 #161228-00023  
   
   DISPLAY "#----- invokeSrv start:" ,cl_get_current()
   LET g_request_str = req.readTextRequest()  #readFormEncodedRequest("UTF-8")

   IF NOT cl_null(g_request_str) THEN
      LET l_time = CURRENT HOUR TO FRACTION(3)
      
      #161208-00039 start
      IF NOT cl_null(req.getRequestHeader("Digi-Reqid")) THEN
      
         LET l_req_header = '{ "digi-header":{ '
         LET cnt = req.getRequestHeaderCount()
         LET buf = base.StringBuffer.create()
         FOR ind = 1 to cnt
             LET l_headervalue = req.getRequestHeaderName(ind)
             CALL buf.clear()
             CALL buf.append(l_headervalue)
             CALL buf.toLowerCase()
             IF buf.getIndexOf("digi-reqid",1) > 0 THEN
                LET l_req_header = l_req_header,'"digi-reqid":"',req.getRequestHeaderValue(ind),'",'
             ELSE              
                IF buf.getIndexOf("digi-",1) > 0 THEN
                   #161228-00023 add start
                   IF buf.getIndexOf("digi-protocol",1) > 0 THEN
                      CASE req.getRequestHeaderValue(ind)
                        WHEN 'raw' 
                          LET l_trans_type = '1'
                        WHEN 'serial'
                          LET l_trans_type = '3'
                        WHEN 'ftp'
                          LET l_trans_type = '4'
                      END CASE
                      LET l_req_header = l_req_header,'"',buf.toString(),'":"',req.getRequestHeaderValue(ind),'",'
                   ELSE
                      LET l_req_header = l_req_header,'"',buf.toString(),'":',req.getRequestHeaderValue(ind),','                   
                   END IF
                   #161228-00023 add end
                END IF                
             END IF
         END FOR
         CALL buf.clear()
         CALL buf.append(l_req_header)
         LET l_req_header = buf.subString(1,buf.getLength() - 1)
         LET l_req_header = l_req_header,'},'

         #161228-00023 add start
         IF cl_null(l_trans_type) THEN
            LET l_trans_type = '1'
         END IF
         CASE l_trans_type
            WHEN '1'
              LET g_request_str = l_req_header,' "digi-body":',g_request_str,'}'
            WHEN '3'
              LET g_ori_request = l_req_header,' "digi-body":',g_request_str,'}'
              LET g_ori_request = util.JSON.format(g_ori_request)
              LET json_obj = util.JSONObject.parse(g_request_str)
              LET l_zipdata = json_obj.get('zip_data')
              LET l_filename = json_obj.get('file_name')
              
              LET l_request_str = cl_eai_serial_to_string(2,l_zipdata,l_filename)
              LET g_request_str = l_req_header,' "digi-body":',l_request_str,'}'
            WHEN '4'
              LET g_ori_request = l_req_header,' "digi-body":',g_request_str,'}'
              LET g_ori_request = util.JSON.format(g_ori_request)
              LET json_obj = util.JSONObject.parse(g_request_str)
              LET l_zipdata = json_obj.get('zip_path')
              LET l_filename = json_obj.get('file_name')
              
              LET l_request_str = cl_eai_ftpfile_to_string(2,l_zipdata,l_filename)
              LET g_request_str = l_req_header,' "digi-body":',l_request_str,'}'              
         END CASE
         #161228-00023 add end
         LET l_ver = '2'
      ELSE
         LET l_ver = '1'      
      END IF
      LET g_request_str = util.JSON.format(g_request_str)
      #161208-00039 end
      
      #161014-00042  2016/11/01 Hank Wu   START
      LET l_today = cl_get_today()
      LET l_today = cl_replace_str(l_today,"-","")
      #DISPLAY "l_today=",l_today   #170222-00002 mark
      
      IF os.Path.isdirectory(os.Path.join(fgl_getenv("TEMPDIR"),l_today)) = 0 THEN 
      --IF os.Path.isdirectory(l_today)=0 THEN
        --DISPLAY "boolean= ",os.Path.isdirectory(l_today)  #170222-00002 mark
         --CALL os.Path.mkdir(l_today) RETURNING l_return
         CALL os.Path.mkdir(os.Path.join(fgl_getenv("TEMPDIR"),l_today)) RETURNING l_return
      END IF
      #161014-00042  2016/11/01 Hank Wu   END
      
      select rawtohex(sys_guid()) into l_guid from dual     #161208-00039
      LET l_fn = l_guid CLIPPED                             #161208-00039
      
      #產生輸入檔案路徑
      LET g_request_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)        #161014-00042  2016/11/01 Hank Wu
      #LET g_request_file_path = g_request_file_path,"/http_request_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"  #161208-00039 mark    
      LET g_request_file_path = g_request_file_path,"/http_req_", l_time , "_",l_fn,".xml"            #161208-00039      
      
      LET l_channel = base.Channel.create()
      CALL l_channel.setDelimiter("")   
      CALL l_channel.openFile(g_request_file_path, "w")
      
      CALL l_channel.write(g_request_str)
      CALL l_channel.close()                
                
      #產生輸出檔案路徑
      LET g_response_file_path = os.Path.join(fgl_getenv("TEMPDIR"),l_today)       #161014-00042  2016/11/01 Hank Wu
      #LET g_response_file_path = g_response_file_path,"/http_response_", l_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".xml"   #161208-00039 mark
      LET g_response_file_path = g_response_file_path,"/http_res_", l_time , "_" , l_fn,".xml"                #161208-00039    

      #JSON轉XML 
      #CALL awsp920_convert(l_time,'1')
      
      #呼叫 invokeSrv 程式
      LET l_start = CURRENT HOUR TO FRACTION(3)
      CALL awsp900_02_invokeSrv()     
      LET l_end = CURRENT HOUR TO FRACTION(3)

      #XML轉JSON
      #CALL awsp920_convert(l_time,'2')      
      LET l_resp_str = g_response.response 
      #161228-00023 add start
       IF cl_null(g_trans_type) THEN 
          LET g_trans_type = '1'
       END IF  
       #LET g_trans_type = '4'       
      #161228-00023 add end
      
      CALL req.setResponseCharset("utf-8") 
      CALL req.setResponseHeader("Content-Type", "application/json")       
      CALL req.setResponseHeader("Access-Control-Allow-Origin", "*")
      #161208-00039 add
      IF l_ver = '2' THEN
         #CALL req.setResponseHeader("Content-Type", "application/x-www-form-urlencoded")
         CALL req.setResponseHeader("digi-srvver", "1.0")
         CALL req.setResponseHeader("digi-srvcode", g_srvcode)
         #161228-00023 add start
         CASE g_trans_type
            WHEN '1'         
              CALL req.setResponseHeader("digi-protocol", "raw") 
            WHEN '3'         
              CALL req.setResponseHeader("digi-protocol", "serial")   
            WHEN '4'         
              CALL req.setResponseHeader("digi-protocol", "ftp")      
         END CASE              
         #161228-00023 add end
         LET json_obj = util.JSONObject.parse(g_response.response)
         LET json_obj1 = json_obj.get('digi-body')
         LET l_resp_str = json_obj1.toString()
         LET l_resp_str = util.JSON.format(l_resp_str) 
      #ELSE
         #CALL req.setResponseHeader("Content-Type", "application/json")      
      END IF
      #161208-00039 end
      CALL req.sendTextResponse(200,"", l_resp_str)
   END IF   
   DISPLAY "#----- invokeSrv process time:" ,(l_end - l_start)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp920_convert()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp920_convert(p_time,p_type)
   DEFINE p_time          STRING
   DEFINE p_type          STRING
   DEFINE l_cmd           STRING   
   DEFINE l_path          STRING   
   DEFINE ls_convert      STRING   
   DEFINE ls_input_file   STRING   
   DEFINE ls_output_file  STRING
   
   DEFINE l_result        STRING   
   DEFINE l_buf           STRING  
   DEFINE l_channel       base.Channel   
   
   LET l_path = os.Path.join(FGL_GETENV("UTL"),"bin")
   LET ls_convert =  l_path , "/xml2json"  
   
   IF p_type = '1' THEN
      DISPLAY "#----- JSON convert to XML"
      ##轉換json2xml
      LET ls_input_file = fgl_getenv("TEMPDIR"), "/",
                   "http_request_", p_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".json"
             
      LET l_channel = base.Channel.create()
      CALL l_channel.setDelimiter("")   
      CALL l_channel.openFile(ls_input_file, "w")
      
      CALL l_channel.write(g_request_str)
      CALL l_channel.close()
      
      LET l_cmd = "xml2json --strip_text --strip_newlines --pretty -t json2xml ",
                   ls_input_file , " > " , g_request_file_path   
   ELSE
       DISPLAY "#----- XML convert to JSON"
       ##XML轉成JSON
       LET ls_output_file = fgl_getenv("TEMPDIR"), "/",
            "http_response_", p_time , "_" , FGL_GETPID() USING '<<<<<<<<<<',".json"
            
       LET l_cmd = "xml2json --strip_text --strip_newlines --pretty -t xml2json -o ",
                   ls_output_file  , " " , g_response_file_path
   END IF   
   
   DISPLAY "convert:" , l_cmd
   RUN l_cmd
   
   IF p_type = '2' THEN
      LET l_channel = base.Channel.create()    
      CALL l_channel.setDelimiter("")   
      CALL l_channel.openFile(ls_output_file, "r")   
      
      LET l_result = ""
      WHILE l_channel.read(l_buf)
         LET l_result = l_result, l_buf
      END WHILE
      CALL l_channel.close()
      
      LET g_response.response = l_result
   END IF
     
END FUNCTION

#end add-point
 
{</section>}
 
{<section id="awsp920.msgcentre_notify" >}
 
   #add-point:process段define (客製用)
{<point name="msgcentre_notify.define_customerization" edit="c"/>}
   #end add-point
  
   #add-point:process段define
   
   #end add-point
 
 
   #action-id與狀態填寫
 
 
   #add-point:msgcentre其他通知
{<point name="msg_centre.process"/>}
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
  
 
 
 
{</section>}
 
