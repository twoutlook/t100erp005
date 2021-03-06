#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp002.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(1900-01-01 00:00:00), PR版次:0003(2016-12-27 17:54:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: awsp002
#+ Description: 取得簽核者關卡資訊
#+ Creator....: 00544(2014-06-05 18:16:07)
#+ Modifier...: 00000 -SD/PR- 07375
 
{</section>}
 
{<section id="awsp002.global" >}
#Memos
#161102-00047#16 2016/12/22 By nikoybeat 調整帳號為tiptop權限

 
IMPORT os
IMPORT xml
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT com
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable)

#end add-point
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
{</section>}
 
{<section id="awsp002.main" >}
#+ 作業開始
MAIN
   #add-point:main段define

   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #161102-00047#16-S
   LET g_account = 'tiptop'
   IF FGL_GETENV("WSBGJOB") = "1" THEN
      CALL FGL_SETENV("WEBUSER", "tiptop")
   ELSE
      CALL FGL_SETENV("LOGNAME", "tiptop")
   END IF
   #161102-00047#16-E
   
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化

   #end add-point
 
   #add-point:SQL_define

   #end add-point
  
   #add-point:Service Call
   SLEEP 5                     #BPM 處理有時間差,先等待 5 秒 
   CALL awsp002_approve_Log()
   #end add-point
  
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="awsp002.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 取得BPM 簽核關卡資訊
# Memo...........:
# Usage..........: CALL awsp002_approve_Log()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp002_approve_Log()
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode           #Request XML Node
   DEFINE l_tag                  STRING                #節點tag名稱
   
   DEFINE l_node                 xml.DomNode
   DEFINE l_request              xml.DomNode
   DEFINE l_request_doc          xml.DomDocument       #傳送的單據資料內容
   DEFINE l_node_list            xml.DomNodeList
   DEFINE l_child_list           xml.DomNodeList
   
   DEFINE l_record_node          xml.DomNode
   DEFINE l_child_node           xml.DomNode
   
   DEFINE l_request_content      xml.DomNode
   DEFINE l_slip                 LIKE ooba_t.ooba002   #單別
   DEFINE l_dzeb001              LIKE dzeb_t.dzeb001   #資料表代碼
   DEFINE l_oobx003              LIKE oobx_t.oobx003   #單據性質
   DEFINE l_wsab002              LIKE wsab_t.wsab002   #參照表編號
   DEFINE l_doc_key              LIKE wsbd_t.wsbd001   #單據的組合key; 多個key用{+}分隔
   DEFINE l_docno                STRING        
   DEFINE l_prog                 STRING
      
   DEFINE l_response_content     xml.DomNode
   DEFINE l_response_content_str STRING   
   DEFINE l_file                 STRING   
   DEFINE l_i                    LIKE type_t.num5
   DEFINE l_j                    LIKE type_t.num5
   DEFINE l_k                    LIKE type_t.num5
   DEFINE l_cnt                  LIKE type_t.num5
   DEFINE l_name                 STRING
   DEFINE l_wsbd                 RECORD LIKE wsbd_t.*
   DEFINE l_imageUrl             STRING
   DEFINE l_approve_time         STRING
   
   DEFINE req                    com.HTTPRequest
   DEFINE resp                   com.HTTPResponse
   DEFINE l_wsba005              LIKE wsba_t.wsba005   #BPM 簽核流程序號
   

   #參數
   LET l_slip    = g_argv[1]
   LET l_doc_key = g_argv[2]
   LET l_wsab002 = g_argv[3]
   LET l_oobx003 = g_argv[4]
   LET l_wsba005 = g_argv[5]
   LET l_docno   = g_argv[6]
   LET l_prog    = g_argv[7]
   
   #建立 Request XML Document
   CALL cl_bpm_create_request_head("ApproveLogGet")
      RETURNING l_req_doc, l_request_root
   
   #建立datakey
   CALL awsp002_create_data_key(l_req_doc, l_request_root, l_slip, l_doc_key, l_wsab002, l_oobx003,l_docno,l_prog)
      RETURNING l_req_doc

   IF l_req_doc IS NULL THEN
      RETURN FALSE
   END IF

   #建立request真正資料內容(payload)
   CALL cl_bpm_create_payload(l_req_doc, l_request_root)
      RETURNING l_req_doc, l_request_root
      
   #建立傳送資料內容
   CALL cl_bpm_request_content_pre()
      RETURNING l_request_doc, l_request

   #建立Parameter節點
   LET l_request_doc = awsp002_create_param(l_request_doc, l_request, l_wsba005)      

   CALL l_request_doc.setFeature("format-pretty-print", true)
   
   #與BPM交換[資料本體]內容需包覆於CDATA中
   LET l_request_content = l_req_doc.createCDataSection(l_request_doc.saveToString())
   CALL l_request_root.appendChild(l_request_content)

   CALL l_req_doc.setFeature("format-pretty-print", true) 

   LET l_file = os.Path.join(FGL_GETENV("TEMPDIR"), "myfile.xml")   
   CALL l_req_doc.save(l_file)

   #取得response
   CALL cl_bpm_api_call(l_req_doc.saveToString())
      RETURNING l_response_content_str
 
  #取得BPM 處理的回傳資料本體
   CALL cl_bpm_get_response(l_response_content_str)
      RETURNING l_response_content
   
   IF l_response_content IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00027"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM wsbd_t
    WHERE wsbdent = g_enterprise
      AND wsbd001 = l_doc_key
      
   IF l_cnt > 0 THEN
      DELETE FROM wsbd_t 
       WHERE wsbdent = g_enterprise
         AND wsbd001 = l_doc_key 
         
      IF SQLCA.sqlcode THEN
         DISPLAY "DELETE Error:" , SQLCA.sqlcode
      END IF         
   END IF

   #取得Record
   LET l_tag = "//Detail/Record"   
   LET l_node_list = l_response_content.selectByXPath(l_tag,"")
   
   #取得Field資料
   FOR l_i = 1 TO l_node_list.getCount()
      INITIALIZE l_wsbd.* TO NULL      
      LET l_wsbd.wsbdent = g_enterprise
      LET l_wsbd.wsbd001 = l_doc_key 
      LOCATE l_wsbd.wsbd008 IN MEMORY       #圖檔存放位置
      
      LET l_record_node = l_node_list.getitem(l_i)      
      LET l_child_list = l_record_node.getElementsByTagName("Field")
      
      FOR l_j = 1 TO l_child_list.getCount()
          LET l_child_node = l_child_list.getitem(l_j) 
          LET l_name = l_child_node.getAttribute("name")
         
          CASE l_name
               WHEN "workItem"         #簽核關卡代號               
               #WHEN "Workitem"         #簽核關卡代號               
                  LET l_wsbd.wsbd002 = l_child_node.getAttribute("value")
                  #DISPLAY "workItem:", l_wsbd.wsbd002
               WHEN "userId"           #使用者代號
                  LET l_wsbd.wsbd003 = l_child_node.getAttribute("value")
                  
               WHEN "approvalResult"   #簽核結果
                  LET l_wsbd.wsbd004 = l_child_node.getAttribute("value") 

               WHEN "approvalOpinion"  #簽核意見
                  LET l_wsbd.wsbd005 = l_child_node.getAttribute("value")
                  
               WHEN "approvalDate"     #簽核日期
                  LET l_wsbd.wsbd006 = l_child_node.getAttribute("value")
                  DISPLAY "approvalDate:", l_wsbd.wsbd006
                  
               WHEN "approvalTime"     #簽核時間
                  LET l_approve_time = l_child_node.getAttribute("value")
                  LET l_wsbd.wsbd007 = l_approve_time.subString(1,10)
                  DISPLAY "approvalTime:", l_wsbd.wsbd007
                  
               WHEN "approvalImageUrl"  #手寫簽名圖檔
                  LET l_imageUrl = ""
                  LET l_imageUrl = l_child_node.getAttribute("value")
                  
                  IF NOT cl_null(l_imageUrl) THEN
                     TRY 
                        
      
                        LET req = com.HTTPRequest.Create(l_imageUrl)
                        CALL req.doRequest()
                        LET resp = req.getResponse()
                        
                        IF resp.getStatusCode() != 200 THEN 
                           DISPLAY "HTTP Error:" , resp.getStatusCode()                          
                        END IF      
                        CALL resp.getDataResponse(l_wsbd.wsbd008)
            
                     CATCH
                        DISPLAY "HTTP Error:" ,STATUS
                     END TRY                    
                  END IF              

            END CASE         
         LET l_child_node = l_child_node.getNextSibling()      
      END FOR
      
      LET l_wsbd.wsbd009 = cl_get_current()
            
      INSERT INTO wsbd_t VALUES (l_wsbd.*)
      
      IF SQLCA.sqlcode THEN         
         DISPLAY "INSERT Error:" , SQLCA.sqlcode
         
      END IF
   END FOR
      
END FUNCTION

################################################################################
# Descriptions...: 建立 <Parameter>
# Memo...........:
# Usage..........: CALL awsp002_create_param(p_req_doc,p_node,p_wsba005)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp002_create_param(p_req_doc,p_node,p_wsba005)
   DEFINE p_req_doc              xml.DomDocument       #XML Document
   DEFINE p_node                 xml.DomNode           #要增加子節點的node
   DEFINE p_wsba005              LIKE wsba_t.wsba005   #BPM 流程
   
   DEFINE l_parameter_node       xml.DomNode
   DEFINE l_record_node          xml.DomNode
   DEFINE l_field_node           xml.DomNode
  
   
   #建立 <Parameter>
   LET l_parameter_node = p_req_doc.createElement("Parameter")
   CALL p_node.appendChild(l_parameter_node)

   #建立 <Record>
   LET l_record_node = p_req_doc.createElement("Record")
   CALL l_parameter_node.appendChild(l_record_node)

   #建立簽核流程代號
   LET l_field_node = p_req_doc.createElement("Field")
   CALL l_record_node.appendChild(l_field_node)
   CALL l_field_node.setAttribute("name", "flow_processSN")
   CALL l_field_node.setAttribute("value", p_wsba005)
   
   RETURN p_req_doc
END FUNCTION

################################################################################
# Descriptions...: 建立datakey
# Memo...........:
# Usage..........: CALL awsp002_create_data_key(p_req_doc,p_node,p_slip,p_doc_key,p_wsab002,p_oobx003,p_docno,p_prog)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp002_create_data_key(p_req_doc,p_node,p_slip,p_doc_key,p_wsab002,p_oobx003,p_docno,p_prog)
   DEFINE p_req_doc              xml.DomDocument       #XML Document
   DEFINE p_node                 xml.DomNode           #要增加子節點的node
   DEFINE p_slip                 STRING                #單別
   DEFINE p_wsab002              LIKE wsab_t.wsab002   #參照表編號
   DEFINE p_oobx003              LIKE oobx_t.oobx003   #單據性質
   
   DEFINE l_child_node           xml.DomNode
   DEFINE l_key_node             xml.DomNode   
   DEFINE p_doc_key              STRING
   DEFINE p_docno                STRING
   DEFINE p_prog                 STRING

   #<datakey type="FOM">
   LET l_child_node = p_req_doc.createElement("datakey")    #建立 <datakey>
   CALL p_node.appendChild(l_child_node)
   CALL l_child_node.setAttribute("type", "FOM")

   #<datakey>下建立子節點
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "EntId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(g_enterprise))
   
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "CompanyId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(g_site))

   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "RefId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_wsab002))
   
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "DocProp")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_oobx003))

   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "Prog")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_prog))

   #設定單別
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "FormId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_slip))

   #設定單據編號
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "SheetNo")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_docno))
   
   #設定單據的組合key
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "DocKey")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_doc_key.trim()))
   
   RETURN p_req_doc
END FUNCTION

#end add-point
 
{</section>}
 
