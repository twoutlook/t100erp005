#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp900_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-11-11 16:33:00), PR版次:0003(2015-10-23 11:32:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: awsp900_05
#+ Description: m-cloud
#+ Creator....: 00544(2014-11-11 16:28:06)
#+ Modifier...: 00544 -SD/PR- 00544
 
{</section>}
 
{<section id="awsp900_05.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT xml
IMPORT com
IMPORT util
IMPORT security
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../aws/4gl/aws_mcloud.inc"
#end add-point
 
{</section>}
 
{<section id="awsp900_05.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_req_doc         xml.DomDocument
DEFINE g_mcloud_server   STRING
#end add-point
 
{</section>}
 
{<section id="awsp900_05.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
 
#end add-point
 
{</section>}
 
{<section id="awsp900_05.other_dialog" >}

 
{</section>}
 
{<section id="awsp900_05.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_05_push_msg(p_keyfield)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_05_push_msg(p_json_str)
   DEFINE p_json_str    STRING #util.JSONObject
   DEFINE p_msg         RECORD
                          title     STRING,
                          menu_id   STRING,
                          msgid     STRING,
                          recv_id   LIKE gzxa_t.gzxa003                          
                        END RECORD
   
   DEFINE l_node        xml.DomNode
   DEFINE l_msg_node    xml.DomNode
   DEFINE l_xml_root    xml.DomNode
   
   DEFINE l_req_doc     xml.DomDocument   
   DEFINE ls_json       STRING
   DEFINE l_xml_data    STRING
   DEFINE ls_base64     STRING
   DEFINE l_result      STRING
   DEFINE l_status		INTEGER
   DEFINE l_ret		   STRING
   DEFINE l_keyfield    STRING
   DEFINE l_user        LIKE gzxa_t.gzxa001   
   
   #mcloud 網址
   LET g_mcloud_server = cl_get_para(g_enterprise,"","E-SYS-0709")
   IF cl_null(g_mcloud_server) THEN
      DISPLAY "mcloud server not found" 
   END IF   
    
   #LET ls_json = p_json_record.toString()
   CALL util.JSON.parse(p_json_str, p_msg)
   
   LET g_req_doc = xml.DomDocument.createDocument("PushMsg")     
   CALL g_req_doc.setFeature("format-pretty-print", true)
    
   LET l_xml_root = g_req_doc.getDocumentElement()  
  
   #訊息來源產品名稱
   CALL awsp900_05_create_node_text(l_xml_root,"From", "T100POC")
   
   #推播對象   
   CALL awsp900_05_create_node_text(l_xml_root,"TargetUser",p_msg.recv_id) 
   
   #推播訊息內文 
   LET l_msg_node = g_req_doc.createElement("Message")    
   CALL awsp900_05_create_node_text(l_msg_node,"alert", p_msg.title)
   
   LET l_keyfield = "MM_PT=T100POC"
   IF NOT cl_null(p_msg.menu_id) THEN
      LET l_keyfield = l_keyfield , "├MM_PID=" , p_msg.menu_id
   END IF
   
   IF NOT cl_null(p_msg.msgid) THEN
      LET l_keyfield = l_keyfield , "├msgID=",  p_msg.msgid
   END IF
   CALL awsp900_05_create_node_text(l_msg_node,"keyfield", l_keyfield)
   
   CALL l_xml_root.appendChild(l_msg_node)
   
   LET l_xml_data = l_xml_root.toString()
   display l_xml_data
   
   #LET ls_base64 = "<![CDATA[" , security.Base64.FromString(l_xml_data) , "]]" , ">"
   LET ls_base64 = security.Base64.FromString(l_xml_data)
   display "base64:" , ls_base64 
   
   CALL cl_eai_start_log()
   CALL awsp900_05_PushDevicePMG("" , ls_base64 ) RETURNING l_status,l_result      
   LET l_ret = security.Base64.ToString(l_result)
   IF l_status THEN
      
   END IF   
   CALL cl_eai_end_log(l_xml_data,l_ret)
   #display l_ret
   
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
PUBLIC FUNCTION awsp900_05_PushDevicePMG(p_pKey,p_pPushMsg)
  DEFINE	soapStatus		INTEGER
  DEFINE	p_pKey		STRING
  DEFINE	p_pPushMsg		STRING

  LET awsp900_05_PushDevicePMG.pKey = p_pKey
  LET awsp900_05_PushDevicePMG.pPushMsg = p_pPushMsg

  LET soapStatus = awsp900_05_PushDevicePMG_g()

  RETURN soapStatus, awsp900_05_PushDevicePMGResponse.PushDevicePMGResult
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
PUBLIC FUNCTION awsp900_05_PushDevicePMG_g()
DEFINE wsstatus   INTEGER
  DEFINE retryAuth  INTEGER
  DEFINE retryProxy INTEGER
  DEFINE retry      INTEGER
  DEFINE nb         INTEGER
  DEFINE uri        STRING
  DEFINE setcookie  STRING
  DEFINE mustUnderstand INTEGER
  DEFINE request    com.HTTPRequest
  DEFINE response   com.HTTPResponse
  DEFINE writer     xml.StaxWriter
  DEFINE reader     xml.StaxReader

  #
  # INIT VARIABLES
  #
  LET wsstatus = -1
  LET retryAuth = FALSE
  LET retryProxy = FALSE
  LET retry = TRUE
  LET uri = com.WebServiceEngine.GetOption("SoapModuleURI")

  #
  # CREATE REQUEST
  #
  TRY
    
    LET awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Address.Uri = g_mcloud_server # "http://203.65.163.94/MT100POC/PushService.asmx"    
    
    LET request = com.HTTPRequest.Create(awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Address.Uri)
    CALL request.setMethod("POST")
    CALL request.setCharset("UTF-8")
    CALL request.setHeader("SOAPAction","\"http://tempuri.org/PushDevicePMG\"")
    IF awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.Version IS NOT NULL THEN
      CALL request.setVersion(awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.Version)
    END IF
    IF awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.Cookie IS NOT NULL THEN
      CALL request.setHeader("Cookie",awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.Cookie)
    END IF
    IF awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.ConnectionTimeout <> 0 THEN
      CALL request.setConnectionTimeout(awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.ConnectionTimeout)
    END IF
    IF awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.ReadWriteTimeout <> 0 THEN
      CALL request.setTimeout(awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.ReadWriteTimeout)
    END IF
  CATCH
    LET wsstatus = STATUS
    CALL WSHelper_FillSOAP11WSError("Client","Cannot create HTTPRequest")
    RETURN wsstatus
  END TRY

  # START LOOP
  WHILE retry
    LET retry = FALSE

    #
    # Stax request
    #
    TRY
      LET writer = request.beginXmlRequest()
      CALL WSHelper_WriteStaxSOAP11StartEnvelope(writer)
      CALL WSHelper_WriteStaxSOAP11StartBody(writer)
      #
      # STAX SOAP REQUEST SERIALIZE
      #
      CALL xml.Serializer.VariableToStax(awsp900_05_PushDevicePMG,writer)
      CALL WSHelper_WriteStaxSOAP11EndBody(writer)
      CALL WSHelper_WriteStaxSOAP11EndEnvelope(writer)
      CALL request.endXmlRequest(writer)
    CATCH
      LET wsstatus = STATUS
      CALL WSHelper_FillSOAP11WSError("Client",SQLCA.SQLERRM)
      RETURN wsstatus
    END TRY

    #
    # PROCESS RESPONSE
    #
    TRY
      LET response = request.getResponse()

      #
      # RETRIEVE SERVICE SESSION COOKIE
      #
      LET setcookie = response.getHeader("Set-Cookie")
      IF setcookie IS NOT NULL THEN
        LET awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Binding.Cookie = WSHelper_ExtractServerCookie(setcookie,awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint.Address.Uri)
      END IF

      CASE response.getStatusCode()

        WHEN 500 # SOAP Fault
          #
          # STAX SOAP FAULT
          #
          LET reader = response.beginXmlResponse() # Begin Streaming Response
          IF NOT WSHelper_ReadStaxSOAP11StartEnvelope(reader) THEN
            EXIT CASE
          END IF
          # Process SOAP headers 
          IF WSHelper_CheckStaxSOAP11Header(reader) AND NOT reader.isEmptyElement() THEN
            CALL reader.nextTag()
            WHILE (reader.getEventType()=="START_ELEMENT")
              IF WSHelper_CheckStaxSOAP11HeaderActor(reader,uri) THEN
                LET mustUnderstand = WSHelper_GetStaxSOAP11HeaderMustUnderstand(reader)
                IF mustUnderstand = -1 THEN
                  CALL WSHelper_FillSOAP11WSError("Client","Invalid mustUnderstand value")
                  EXIT CASE
                END IF
                IF mustUnderstand THEN
                  CALL WSHelper_FillSOAP11WSError("MustUnderstand","Mandatory header block not understood")
                  EXIT CASE
                ELSE
                  CALL reader.nextSibling() # Skip header, not necessary
                END IF
              ELSE
                CALL reader.nextSibling() # Skip header, not intended to us
              END IF
            END WHILE
            IF NOT WSHelper_CheckStaxSOAP11Header(reader) THEN
              CALL WSHelper_FillSOAP11WSError("Client","No ending header tag found")
              EXIT CASE
            ELSE
              CALL reader.nextTag()
            END IF
          ELSE
            IF WSHelper_CheckStaxSOAP11Header(reader) THEN
              CALL reader.nextSibling() # Skip SOAP headers
            END IF
          END IF
          IF NOT WSHelper_ReadStaxSOAP11StartBody(reader) THEN
            EXIT CASE
          END IF
          IF NOT WSHelper_ReadStaxSOAP11StartFault(reader) THEN
            EXIT CASE
          END IF
          IF NOT WSHelper_ReadStaxSOAP11FaultUntilDetail(reader) THEN
            EXIT CASE
          END IF
          IF WSHelper_CheckStaxSOAP11FaultDetail(reader) THEN
            #
            # STAX SOAP FAULT DESERIALIZE
            #
            CALL reader.nextSibling() # Skip SOAP detail
          END IF
          IF NOT WSHelper_ReadStaxSOAP11EndFault(reader) THEN
            EXIT CASE
          END IF
          IF NOT WSHelper_ReadStaxSOAP11EndBody(reader) THEN
            EXIT CASE
          END IF
          IF NOT WSHelper_ReadStaxSOAP11EndEnvelope(reader) THEN
            EXIT CASE
          END IF
          # End Streaming Response
          CALL response.endXmlResponse(reader)

        WHEN 200 # SOAP Result
          #
          # STAX SOAP RESPONSE
          #
          LET reader = response.beginXmlResponse() # Begin Streaming Response
          IF NOT WSHelper_ReadStaxSOAP11StartEnvelope(reader) THEN
            EXIT CASE
          END IF
          # Process SOAP headers 
          IF WSHelper_CheckStaxSOAP11Header(reader) AND NOT reader.isEmptyElement() THEN
            LET nb = 0
            CALL reader.nextTag()
            WHILE (reader.getEventType()=="START_ELEMENT")
              IF WSHelper_CheckStaxSOAP11HeaderActor(reader,uri) THEN
                LET mustUnderstand = WSHelper_GetStaxSOAP11HeaderMustUnderstand(reader)
                IF mustUnderstand = -1 THEN
                  CALL WSHelper_FillSOAP11WSError("Client","Invalid mustUnderstand value")
                  EXIT CASE
                END IF
                #
                # STAX SOAP RESPONSE HEADER DESERIALIZE
                #
                IF mustUnderstand THEN
                  CALL WSHelper_FillSOAP11WSError("MustUnderstand","Mandatory header block not understood")
                  EXIT CASE
                ELSE
                  CALL reader.nextSibling() # Skip header, not necessary
                END IF
              ELSE
                CALL reader.nextSibling() # Skip header, not intended to us
              END IF
            END WHILE
            IF NOT WSHelper_CheckStaxSOAP11Header(reader) THEN
              CALL WSHelper_FillSOAP11WSError("Client","No ending header tag found")
              EXIT CASE
            ELSE
              IF nb != 0 THEN
                CALL WSHelper_FillSOAP11WSError("Client","One or more headers are missing")
                EXIT CASE
              ELSE
                CALL reader.nextTag()
              END IF
            END IF
          ELSE
           IF reader.isEmptyElement() THEN
             CALL reader.nextTag()
           END IF
          END IF
          IF NOT WSHelper_ReadStaxSOAP11StartBody(reader) THEN
            EXIT CASE
          END IF
          # Retrieve SOAP Message taking soap:root attribute into account
          IF NOT WSHelper_RetrieveStaxSOAP11Message(reader) THEN
            EXIT CASE
          END IF
          #
          # STAX SOAP RESPONSE DESERIALIZE
          #
          CALL xml.Serializer.StaxToVariable(reader,awsp900_05_PushDevicePMGResponse)
          IF NOT WSHelper_ReadStaxSOAP11EndBody(reader) THEN
            EXIT CASE
          END IF
          IF NOT WSHelper_ReadStaxSOAP11EndEnvelope(reader) THEN
            EXIT CASE
          END IF
          # End Streaming Response
          CALL response.endXmlResponse(reader)
          LET wsstatus = 0

        WHEN 401 # HTTP Authentication
          IF retryAuth THEN
            CALL WSHelper_FillSOAP11WSError("Server","HTTP Error 401 ("||response.getStatusDescription()||")")
          ELSE
            LET retryAuth = TRUE
            LET retry = TRUE
          END IF

        WHEN 407 # Proxy Authentication
          IF retryProxy THEN
            CALL WSHelper_FillSOAP11WSError("Server","HTTP Error 407 ("||response.getStatusDescription()||")")
          ELSE
            LET retryProxy = TRUE
            LET retry = TRUE
          END IF

        OTHERWISE
          CALL WSHelper_FillSOAP11WSError("Server","HTTP Error "||response.getStatusCode()||" ("||response.getStatusDescription()||")")

      END CASE
    CATCH
      LET wsstatus = status
      CALL WSHelper_FillSOAP11WSError("Server",SQLCA.SQLERRM)
      RETURN wsstatus
    END TRY

  # END LOOP
  END WHILE

  RETURN wsstatus

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
PUBLIC FUNCTION awsp900_05_create_node_text(p_xml_root,p_name,p_value)
   DEFINE l_node        xml.DomNode
   DEFINE l_tnode       xml.DomNode
   DEFINE p_xml_root    xml.DomNode
   
   DEFINE p_name        STRING
   DEFINE p_value       STRING
   
   
   LET l_node = g_req_doc.createElement(p_name)         #建立<tag>
   LET l_tnode =  g_req_doc.createTextNode(p_value)     
   CALL l_node.appendChild(l_tnode)
   
   CALL p_xml_root.appendChild(l_node)
   
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
PUBLIC FUNCTION awsp900_05_get_attach(p_attch_url,p_attach_path)
  DEFINE p_attch_url    STRING
  DEFINE p_attach_path  STRING
  DEFINE l_file        BYTE
  DEFINE req            com.HTTPRequest
  DEFINE resp           com.HTTPResponse

  TRY 
      LOCATE l_file IN MEMORY       #存放位置
      
      LET req = com.HTTPRequest.Create(p_attch_url)
      CALL req.doRequest()
      LET resp = req.getResponse()
      
      IF resp.getStatusCode() != 200 THEN
         #LET g_status.code = resp.getStatusCode()
         #LET g_status.description = "HTTP Rqeust Error"
         RETURN
      END IF
      
      CALL resp.getDataResponse(l_file)
      CALL l_file.writeFile(p_attach_path)    
   CATCH
      #LET g_status.code = STATUS
      #LET g_status.description = STATUS || " ("||SQLCA.SQLERRM||")"
      RETURN
   END TRY  
END FUNCTION

 
{</section>}
 
