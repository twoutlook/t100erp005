#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp500_01.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000000
#+ 
#+ Filename...: awsp500_01
#+ Description: PLM程式
#+ Creator....: 05775(2015-10-16 15:48:33)
#+ Modifier...: 05775(2015-10-16 16:12:37) -SD/PR- 05775
 
{</section>}
 
{<section id="awsp500_01.global" >}
#應用 i01 樣板自動產生(Version:29)

 
IMPORT os
IMPORT util
#add-point:增加匯入項目
IMPORT xml
IMPORT com
IMPORT security
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS "../../cfg/top_ws.inc"
GLOBALS "../../aws/4gl/awsp500.inc"
 

 

#add-point:自定義模組變數(Module Variable)
TYPE type_g_attribute    DYNAMIC ARRAY OF RECORD
        name             STRING,      #屬性名稱
        value            STRING       #屬性值
                         END RECORD
             
DEFINE g_plm_server      STRING
#end add-point
 
{</section>}
 
{<section id="awsp500_01.main" >}

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.init" >}

 

 

 
{</section>}
 
{<section id="awsp500_01.ui_dialog" >}

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.browser_fill" >}

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.construct" >}

 

 

 
 
 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.query" >}

 

 
{</section>}
 
{<section id="awsp500_01.fetch" >}

 

 

 
{</section>}
 
{<section id="awsp500_01.insert" >}

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.modify" >}

 

 

 

 
{</section>}
 
{<section id="awsp500_01.input" >}

 

 

 

 

 

 
 
 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.reproduce" >}

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.show" >}

 

 

 

 
 
 

 
{</section>}
 
{<section id="awsp500_01.delete" >}

 

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.ui_browser_refresh" >}

 

 
{</section>}
 
{<section id="awsp500_01.set_entry" >}

 

 

 

 
{</section>}
 
{<section id="awsp500_01.set_no_entry" >}

 

 

 

 
{</section>}
 
{<section id="awsp500_01.set_act_visible" >}

 

 

 
{</section>}
 
{<section id="awsp500_01.set_act_no_visible" >}

 

 

 
{</section>}
 
{<section id="awsp500_01.default_search" >}

 

 

 

 

 
{</section>}
 
{<section id="awsp500_01.mask_functions" >}
 
{</section>}
 
{<section id="awsp500_01.state_change" >}
 
{</section>}
 
{<section id="awsp500_01.signature" >}
 
{</section>}
 
{<section id="awsp500_01.set_pk_array" >}

 

 

 

 
{</section>}
 
{<section id="awsp500_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="awsp500_01.msgcentre_notify" >}

 

 

 
{</section>}
 
{<section id="awsp500_01.action_chk" >}

 

 

 
{</section>}
 
{<section id="awsp500_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得PLM服務IP位置
# Memo...........:
# Usage..........: CALL awsp500_01_chk_plm_server()
#                  RETURNING 回传参数
# Input parameter: none
# Return code....: none
# Date & Author..: 15/10/16 By TSD.Tim
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp500_01_chk_plm_server()
   LET g_plm_server = cl_get_para(g_enterprise,"","E-SYS-0719") 
   IF cl_null(g_plm_server) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aws-00031"  #請先在aoos010設定PLM接口URL
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 呼叫setT100JobStatus服務
# Memo...........:
# Usage..........: CALL awsp500_01_setT100JobStatus(p_xmlContext)
#                  RETURNING soapStatus,setT100JobStatusResponse.return
# Input parameter: p_xmlContext
# Return code....: soapStatus
#                : setT100JobStatusResponse.return
# Date & Author..: 15/10/16 TSD.Tim
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp500_01_setT100JobStatus(p_xmlContext)
  DEFINE	p_xmlContext	STRING
  DEFINE	soapStatus		INTEGER


  LET setT100JobStatus.xmlContext = p_xmlContext

  LET soapStatus = awsp500_01_setT100JobStatus_g()

  RETURN soapStatus, setT100JobStatusResponse.return
END FUNCTION

################################################################################
# Descriptions...: 呼叫PLM setT100JobStatus服務
# Memo...........:
# Usage..........: CALL awsp500_01_setT100JobStatus_g()
#                  RETURNING 回传参数
# Input parameter: none
# Return code....: wsstatus
# Date & Author..: 15/10/16 By TSD.Tim
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp500_01_setT100JobStatus_g()
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
  
   IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri IS NULL THEN
      LET g_plm_server = cl_get_para(g_enterprise,"","E-SYS-0719") 
      LET ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri = g_plm_server
   END IF
  
   #
   # CREATE REQUEST
   #
   TRY
     LET request = com.HTTPRequest.Create(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri)
     CALL request.setMethod("POST")
     CALL request.setCharset("UTF-8")
     CALL request.setHeader("SOAPAction","\"urn:setT100JobStatus\"")
     CALL WSHelper_SetRequestHeaders(request, ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Request.Headers)
     IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Version IS NOT NULL THEN
       CALL request.setVersion(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Version)
     END IF
     IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Cookie IS NOT NULL THEN
       CALL request.setHeader("Cookie",ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Cookie)
     END IF
     IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ConnectionTimeout <> 0 THEN
       CALL request.setConnectionTimeout(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ConnectionTimeout)
     END IF
     IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ReadWriteTimeout <> 0 THEN
       CALL request.setTimeout(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ReadWriteTimeout)
     END IF
     IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.CompressRequest IS NOT NULL THEN
       CALL request.setHeader("Content-Encoding",ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.CompressRequest)
     END IF
     CALL request.setHeader("Accept-Encoding","gzip, deflate")
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
       CALL xml.Serializer.VariableToStax(setT100JobStatus,writer)
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
         LET ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Cookie = WSHelper_ExtractServerCookie(setcookie,ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri)
       END IF
  
       #
       # RETRIEVE HTTP RESPONSE Headers
       #
       CALL WSHelper_SetResponseHeaders(response, ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Response.Headers)
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
           CALL xml.Serializer.StaxToVariable(reader,setT100JobStatusResponse)
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
PUBLIC FUNCTION awsp500_01_invokeSrv(p_paramXML)
  DEFINE	p_paramXML		STRING
  DEFINE	soapStatus		INTEGER


  LET  awsp500_01_invokeSrv.paramXML = p_paramXML

  LET soapStatus = awsp500_01_invokeSrv_g()

  RETURN soapStatus,  awsp500_01_invokeSrvResponse.return
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
PRIVATE FUNCTION awsp500_01_invokeSrv_g()
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

  IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri IS NULL THEN
     LET g_plm_server = cl_get_para(g_enterprise,"","E-SYS-0719") 
     LET ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri = g_plm_server
  END IF

  #
  # CREATE REQUEST
  #
  TRY
    LET request = com.HTTPRequest.Create(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri)
    CALL request.setMethod("POST")
    CALL request.setCharset("UTF-8")
    CALL request.setHeader("SOAPAction","\"urn:invokeSrv\"")
    CALL WSHelper_SetRequestHeaders(request, ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Request.Headers)
    IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Version IS NOT NULL THEN
      CALL request.setVersion(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Version)
    END IF
    IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Cookie IS NOT NULL THEN
      CALL request.setHeader("Cookie",ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Cookie)
    END IF
    IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ConnectionTimeout <> 0 THEN
      CALL request.setConnectionTimeout(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ConnectionTimeout)
    END IF
    IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ReadWriteTimeout <> 0 THEN
      CALL request.setTimeout(ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.ReadWriteTimeout)
    END IF
    IF ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.CompressRequest IS NOT NULL THEN
      CALL request.setHeader("Content-Encoding",ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.CompressRequest)
    END IF
    CALL request.setHeader("Accept-Encoding","gzip, deflate")
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
      CALL xml.Serializer.VariableToStax(awsp500_01_invokeSrv,writer)
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
        LET ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Cookie = WSHelper_ExtractServerCookie(setcookie,ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Address.Uri)
      END IF

      #
      # RETRIEVE HTTP RESPONSE Headers
      #
      CALL WSHelper_SetResponseHeaders(response, ERPIService_ERPIServiceHttpSoap11EndpointEndpoint.Binding.Response.Headers)
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
          CALL xml.Serializer.StaxToVariable(reader,awsp500_01_invokeSrvResponse)
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

 
{</section>}
 
