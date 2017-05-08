#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp900_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-11-05 10:19:46), PR版次:0009(2016-12-28 11:25:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: awsp900_04
#+ Description: EAI 功能
#+ Creator....: 00544(2014-11-05 10:05:59)
#+ Modifier...: 00544 -SD/PR- 00845
 
{</section>}
 
{<section id="awsp900_04.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#161220-00012#1  2016/12/20 By hjwang    判斷參數確定是否額外複寫gzxd
#161228-00003#1  2016/12/28 By hjwang   gzxs參數抓取相反
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
GLOBALS "../../cfg/top_ws.inc"
GLOBALS "../../aws/4gl/aws_eai.inc"
#end add-point
 
{</section>}
 
{<section id="awsp900_04.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE gx_reqdoc           xml.DomDocument
DEFINE g_mdm_req_doc       xml.DomDocument  

TYPE type_g_attribute DYNAMIC ARRAY OF RECORD
                name         STRING,      #屬性名稱
                value        STRING       #屬性值
             END RECORD
TYPE type_g_param     DYNAMIC ARRAY OF RECORD
                name         STRING,      #屬性名稱
                value        STRING,      #屬性值
                text         STRING       #node value
             END RECORD             
TYPE type_gzxa     RECORD
         gzxa001 LIKE gzxa_t.gzxa001,
         gzxa002 LIKE gzxa_t.gzxa002,
         gzxa003 LIKE gzxa_t.gzxa003,
         gzxa003_desc LIKE type_t.chr80,
         gzxastus LIKE gzxa_t.gzxastus,
         gzxa010 LIKE gzxa_t.gzxa010,
         gzxa007 LIKE gzxa_t.gzxa007,
         gzxa007_desc LIKE type_t.chr80,
         gzxa011 LIKE gzxa_t.gzxa011,
         gzxa011_desc LIKE type_t.chr80,
         gzxd002 LIKE gzxd_t.gzxd002,
         gzxa013 LIKE gzxa_t.gzxa013,
         oofc012 LIKE oofc_t.oofc012,
         gzxa005 LIKE gzxa_t.gzxa005,
         #gzxa006 LIKE gzxa_t.gzxa006,
         gzxa008 LIKE gzxa_t.gzxa008,
         gzxa009 LIKE gzxa_t.gzxa009,
         gzxa014 LIKE gzxa_t.gzxa014,
         gzxa016 LIKE gzxa_t.gzxa016,
         gzxz002 LIKE gzxz_t.gzxz002,
         gzxz003 LIKE gzxz_t.gzxz003,
         gzxd004 LIKE gzxd_t.gzxd004,
         gzxz005 LIKE gzxz_t.gzxz005,
         gzxz006 LIKE gzxz_t.gzxz006,
         gzxz007 LIKE gzxz_t.gzxz007,
         gzxz008 LIKE gzxz_t.gzxz008,
         gzxz009 LIKE gzxz_t.gzxz009,
         gzxz010 LIKE gzxz_t.gzxz010,
         gzxaownid LIKE gzxa_t.gzxaownid,
         gzxaownid_desc LIKE type_t.chr80,
         gzxaowndp LIKE gzxa_t.gzxaowndp,
         gzxaowndp_desc LIKE type_t.chr80,
         gzxacrtid LIKE gzxa_t.gzxacrtid,
         gzxacrtid_desc LIKE type_t.chr80,
         gzxacrtdp LIKE gzxa_t.gzxacrtdp,
         gzxacrtdp_desc LIKE type_t.chr80,
         gzxacrtdt DATETIME YEAR TO SECOND,
         gzxamodid LIKE gzxa_t.gzxamodid,
         gzxamodid_desc LIKE type_t.chr80,
         gzxamoddt DATETIME YEAR TO SECOND
   END RECORD

#end add-point
 
{</section>}
 
{<section id="awsp900_04.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_gzxa DYNAMIC ARRAY OF type_gzxa
DEFINE g_sql                STRING
#end add-point
 
{</section>}
 
{<section id="awsp900_04.other_dialog" >}

 
{</section>}
 
{<section id="awsp900_04.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_invokeMdm()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_04_invokeMdm()
    
   
    #服務變數初始化
    CALL awsp900_01_init()

    #取出輸入檔案路徑內的輸入字串
    LET g_request.request = awsp900_01_read_file(g_request_file_path)
    IF cl_null(g_request.request) THEN
       LET g_srvcode = "100"
    END IF
    
    #將 XML 檔案轉為 XML DomNode
    LET g_mdm_req_doc = xml.DomDocument.create()
    CALL g_mdm_req_doc.loadFromString(g_request.request)  
    
    #DISPLAY "g_request.request = ", g_request.request

    #取得服務名稱
    LET g_service = awsp900_02_req_process() 
    display "service:",g_service    
    
     #紀錄 Request XML
    CALL awsp900_01_writeRequestLog()
    LET g_request.request = cl_trust_coding_de(g_request.request)
    #取得主資料表名稱
    IF g_service = "syncMasterData" THEN
       LET g_srvcode = "000"      #預設資料同步完成
       CALL awsp900_04_syncMasterData()              
       CALL awsp900_04_create_response()  
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
PUBLIC FUNCTION awsp900_04_syncMasterData()
   DEFINE l_node_list            xml.DomNodeList
   DEFINE l_child_list           xml.DomNodeList
   DEFINE l_pnode                xml.DomNode
   DEFINE l_child_node           xml.DomNode  
   DEFINE l_feild_node           xml.DomNode
   DEFINE l_record_node          xml.DomNode
   DEFINE l_tnode                xml.DomNode
   
   DEFINE l_name                 STRING
   DEFINE l_value                STRING   
   DEFINE l_publish_prod         STRING
   
   DEFINE l_i                    LIKE type_t.num5
   DEFINE l_j                    LIKE type_t.num5
   DEFINE l_x                    LIKE type_t.num5
   DEFINE l_cnt                  LIKE type_t.num5
   DEFINE l_batch_total          LIKE type_t.num5
   
   #LET l_node = g_mdm_req_doc.getElementsByTagName("DataName")
   DISPLAY awsp900_01_getNodeValue(g_mdm_req_doc ,"DataName" , "")
   
   LET l_x = 1
   LET l_node_list = g_mdm_req_doc.getElementsByTagName("records")
   FOR l_i = 1 TO l_node_list.getCount()
       LET l_record_node = l_node_list.getitem(l_i)
       LET l_child_node = l_record_node.getFirstChild()
       
       WHILE l_child_node IS NOT NULL
         IF l_child_node.getLocalName() = "record" THEN 
         
            display l_child_node.getAttribute("action")
            LET l_child_list = l_child_node.getElementsByTagName("field")
            display "fields:" , l_child_list.getCount()
            
            FOR l_j = 1 TO l_child_list.getCount()
                LET l_feild_node = l_child_list.getitem(l_j)                
                LET l_name = l_feild_node.getAttribute("name")
                
                #取node value
                LET l_tnode = l_feild_node.getFirstChild()
                #LET l_value = l_tnode.getNodeValue()
                LET l_value = awsp900_01_getNodeValue(g_mdm_req_doc ,"field" , l_name) #l_tnode.getNodeValue()
                LET l_value = cl_replace_str(l_value.trim(),"\r" , "")
                LET l_value = cl_replace_str(l_value.trim(),"\n" , "")
                LET l_value = cl_replace_str(l_value.trim(),"\t" , "")
                
                CASE l_name
                  WHEN "gzxa001"
                      LET g_gzxa[l_x].gzxa001 = l_value 
                      
                  WHEN "gzxd002"    
                      LET g_gzxa[l_x].gzxd002 = cl_trust_decrypt_token_key(l_value)
                      #display "gzxd002:" , p_gzxa_m.gzxd002
                      
                  WHEN "gzxa003"  
                      #電子郵件 
                      LET g_gzxa[l_x].oofc012 = s_aooi350_get_user_contact( l_value ,"4")   

                  WHEN "gzxa014"
                      LET g_gzxa[l_x].gzxa014 = l_value 
                  
                END CASE
            END FOR
            LET l_x = l_x + 1
         END IF 
         LET l_child_node = l_child_node.getNextSibling()     
      END WHILE         
   END FOR
   
   LET l_cnt = l_x - 1
   FOR l_i = 1 TO l_cnt
       LET g_gzxa[l_i].gzxaownid = l_publish_prod   #
       CALL awsp900_04_insert_user(g_gzxa[l_i].*)
   END FOR
   
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
PUBLIC FUNCTION awsp900_04_create_response()
DEFINE p_srvcode         STRING
DEFINE p_response_str    STRING
DEFINE l_resdoc          xml.DomDocument
DEFINE l_node_list       xml.DomNodeList
DEFINE l_res_root        xml.DomNode
DEFINE l_tnode           xml.DomNode
DEFINE l_pnode           xml.DomNode
DEFINE l_tp_version      STRING
DEFINE l_bpm_xml         STRING
DEFINE l_dom_doc         om.DomDocument
DEFINE l_dom_node        om.DomNode
DEFINE l_ch              base.Channel
    
    LET l_tp_version = "1.0"
     
    #產生 response xml.DomDocument
    LET l_resdoc = xml.DomDocument.CreateDocument("response")
    CALL l_resdoc.setFeature("format-pretty-print", true)

    LET l_res_root = l_resdoc.getDocumentElement()

    LET l_pnode = l_resdoc.createElement("srvver")    #建立 <srvver> 
    CALL l_res_root.appendChild(l_pnode)
    LET l_tnode = l_resdoc.createTextNode(l_tp_version)
    CALL l_pnode.appendChild(l_tnode)

    LET l_pnode = l_resdoc.createElement("srvcode")    #建立 <srvcode> 
    CALL l_res_root.appendChild(l_pnode)
    LET l_tnode = l_resdoc.createTextNode(g_srvcode)
    CALL l_pnode.appendChild(l_tnode)

    LET l_pnode = l_resdoc.createElement("payload")    #建立 <payload> 
    CALL l_res_root.appendChild(l_pnode) 
    
    LET g_response.response = l_resdoc.saveToString()
    LET g_response.response = cl_str_replace( g_response.response ,"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>","")
    LET g_response.response = cl_trust_coding_en(g_response.response)    
    #LET l_ch = base.Channel.create()
    #CALL l_ch.openFile(g_response_file_path, "w")
    #CALL l_ch.setDelimiter("")       
    #CALL l_ch.write(g_response.response)
    #CALL l_ch.close()
    
    CALL awsp900_01_writeResponseLog()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_insert_user(p_gzxa_m)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_04_insert_user(p_gzxa_m)
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE lc_gzxd002       LIKE gzxd_t.gzxd002
   DEFINE p_gzxa_m         type_gzxa
      
   #LET p_gzxa_m.gzxaownid = g_user
   LET p_gzxa_m.gzxaowndp = g_dept
   LET p_gzxa_m.gzxacrtid = g_user
   LET p_gzxa_m.gzxacrtdp = g_dept
   LET p_gzxa_m.gzxacrtdt = cl_get_current()
   
   LET p_gzxa_m.gzxastus = "Y"  
   LET p_gzxa_m.gzxa002 = "2"       #員工
   LET p_gzxa_m.gzxd004 = "N"
   #先給預設語言別 繁體
   LET p_gzxa_m.gzxa010 = "zh_TW"
   LET p_gzxa_m.gzxa008 = "0"
   LET p_gzxa_m.gzxa009 = "0"
   LET p_gzxa_m.gzxa016 = "Y"
      
   SELECT COUNT(*) INTO l_cnt FROM gzxa_t
    WHERE gzxaent = g_enterprise AND gzxa001 = p_gzxa_m.gzxa001   #161220-00012#1
    
   IF l_cnt > 0 THEN
      UPDATE gzxa_t SET (gzxa002,gzxa003,gzxastus,gzxa010,gzxa007,gzxa011,gzxa013,gzxa005,gzxa008,gzxa009,gzxa016,gzxaownid,gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,gzxamoddt) 
                      = (p_gzxa_m.gzxa002,p_gzxa_m.gzxa003,p_gzxa_m.gzxastus,p_gzxa_m.gzxa010,p_gzxa_m.gzxa007,p_gzxa_m.gzxa011,p_gzxa_m.gzxa013,p_gzxa_m.gzxa005,p_gzxa_m.gzxa008,p_gzxa_m.gzxa009,p_gzxa_m.gzxa016,p_gzxa_m.gzxaownid,p_gzxa_m.gzxaowndp,p_gzxa_m.gzxacrtid,p_gzxa_m.gzxacrtdp,p_gzxa_m.gzxacrtdt,p_gzxa_m.gzxamodid,p_gzxa_m.gzxamoddt)
       WHERE gzxaent = g_enterprise AND gzxa001 = p_gzxa_m.gzxa001    #161220-00012#1
       
   ELSE
      INSERT INTO gzxa_t (gzxaent,gzxa001,gzxa002,gzxa003,gzxastus,gzxa010,gzxa007,gzxa011,gzxa013,gzxa005,gzxa008,gzxa009,gzxa016,gzxaownid,gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,gzxamoddt)
               VALUES (g_enterprise,p_gzxa_m.gzxa001,p_gzxa_m.gzxa002,p_gzxa_m.gzxa003,p_gzxa_m.gzxastus,p_gzxa_m.gzxa010,p_gzxa_m.gzxa007,p_gzxa_m.gzxa011,p_gzxa_m.gzxa013,p_gzxa_m.gzxa005,p_gzxa_m.gzxa008,p_gzxa_m.gzxa009,p_gzxa_m.gzxa016,p_gzxa_m.gzxaownid,p_gzxa_m.gzxaowndp,p_gzxa_m.gzxacrtid,p_gzxa_m.gzxacrtdp,p_gzxa_m.gzxacrtdt,p_gzxa_m.gzxamodid,p_gzxa_m.gzxamoddt)
   END IF   
               
   IF SQLCA.sqlcode THEN
      LET g_srvcode = "585"
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM gzxd_t
    WHERE gzxdent = g_enterprise AND gzxd001 = p_gzxa_m.gzxa001   #161220-00012#1
    
   LET lc_gzxd002 = cl_hashkey_user_encode(p_gzxa_m.gzxa001)
   
   IF l_cnt > 0 THEN
      #161220-00012#1 -start   #161228-00003#1
      IF cl_get_para(g_enterprise,"","E-SYS-2010") IS NOT NULL AND cl_get_para(g_enterprise,"","E-SYS-2010") = "Y" THEN
         UPDATE gzxs_t SET gzxs002 = p_gzxa_m.gzxa001
          WHERE gzxsent = g_enterprise AND gzxs001 = p_gzxa_m.gzxa001
         IF SQLCA.SQLCODE THEN
            DISPLAY "upd gzxs_t:",SQLCA.SQLCODE,":",SQLERRMESSAGE
         END IF
      END IF
      #161220-00012#1 -end
      UPDATE gzxd_t SET (gzxd002,gzxd003) = (lc_gzxd002,g_today)
       WHERE gzxaent = g_enterprise AND gzxd001 = p_gzxa_m.gzxa001
   ELSE
      #161220-00012#1 -start   #161228-00003#1
      IF cl_get_para(g_enterprise,"","E-SYS-2010") IS NOT NULL AND cl_get_para(g_enterprise,"","E-SYS-2010") = "Y" THEN
         INSERT INTO gzxs_t(gzxsent,gzxs001,gzxs002)
         VALUES(g_enterprise,p_gzxa_m.gzxa001,p_gzxa_m.gzxa001)
         IF SQLCA.SQLCODE THEN
            DISPLAY "upd gzxs_t:",SQLCA.SQLCODE,":",SQLERRMESSAGE
         END IF
      END IF
      #161220-00012#1 -end
      INSERT INTO gzxd_t(gzxdent,gzxd001,gzxd002,gzxd003,gzxd004,gzxdstus)
             VALUES(g_enterprise,p_gzxa_m.gzxa001,lc_gzxd002,g_today,'Y','Y')
   END IF   
   
   IF SQLCA.sqlcode THEN
      DISPLAY "err gzxd_t:" , SQLCA.sqlcode
   END IF 
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_create_request_head()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_04_create_request_head(p_attr)
   #DEFINE p_job_name             STRING
   DEFINE p_attr                 type_g_attribute   #request 屬性資料
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode        #Request XML Node
   DEFINE l_tag                  STRING             #節點tag名稱
   DEFINE l_attr                 type_g_attribute   #節點屬性資料
   DEFINE l_node                 xml.DomNode
   DEFINE l_Request              STRING
   DEFINE l_xml_str              STRING
   DEFINE ls_sync                STRING
   DEFINE l_start                LIKE type_t.num10
   DEFINE l_end                  LIKE type_t.num10
    
   
   INITIALIZE l_request_root TO NULL
   INITIALIZE l_node TO NULL
   
   #建立 Request XML Document
   LET l_req_doc = xml.DomDocument.createDocument("request")
   LET l_request_root = l_req_doc.getDocumentElement()  
      

   IF p_attr.getLength() > 0 THEN     #設定 request 屬性
      CALL l_request_root.setAttribute(p_attr[1].name, p_attr[1].value)
   END IF
   
   #建立TT主機資訊(<host>)
   LET l_tag = "host"
   CALL l_attr.clear()
   LET l_attr = awsp900_04_get_host_info()
   
   CALL cl_bpm_create_node(l_req_doc, l_request_root, l_tag, l_attr)
      RETURNING l_req_doc, l_node
  
   RETURN l_req_doc, l_request_root
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_create_payload(p_req_doc,p_request_root,p_attr)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_04_create_payload(p_req_doc,p_request_root,p_attr)
   DEFINE p_req_doc              xml.DomDocument
   DEFINE p_request_root         xml.DomNode        #Request XML Node
   DEFINE l_tag                  STRING             #節點tag名稱
   DEFINE l_value                STRING 
   DEFINE l_attr                 type_g_attribute   #節點屬性資料
   
   DEFINE l_node                 xml.DomNode
   DEFINE l_pnode                xml.DomNode
   DEFINE p_attr                 type_g_param       #param 屬性資料
   DEFINE l_i                    LIKE type_t.num5
   
   #建立payload節點
   LET l_tag = "payload"
   CALL l_attr.clear()
   CALL cl_bpm_create_node(p_req_doc, p_request_root, l_tag, l_attr)
      RETURNING p_req_doc, l_pnode

   #建立param節點
   LET l_tag = "param" 
   
   FOR l_i = 1 TO p_attr.getLength()
      LET l_attr[1].name = "key"
      LET l_attr[1].value = p_attr[l_i].name

      LET l_attr[2].name = "type"
      LET l_attr[2].value = p_attr[l_i].value
      
      LET l_value = p_attr[l_i].text
   
      CALL awsp900_04_create_node(p_req_doc, l_pnode, l_tag, l_attr ,l_value)
         RETURNING p_req_doc, l_node
         
    END FOR

   RETURN p_req_doc, l_pnode
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
PUBLIC FUNCTION awsp900_04_create_node(p_req_doc,p_node,p_tag,p_attr,p_value)
   DEFINE p_req_doc              xml.DomDocument    #XML Document
   DEFINE p_node                 xml.DomNode        #要增加子節點的node
   DEFINE l_tnode                xml.DomNode        #建立 文字
   DEFINE p_tag                  STRING             #子節點的tag名稱
   DEFINE p_value                STRING
   DEFINE p_attr                 type_g_attribute
  
   DEFINE l_child_node           xml.DomNode
   DEFINE l_i                    LIKE type_t.num5

   INITIALIZE l_child_node TO NULL

   #建立子節點node
   LET l_child_node = p_req_doc.createElement(p_tag)
   CALL p_node.appendChild(l_child_node)
   
   LET l_tnode = p_req_doc.createTextNode(p_value)  
   CALL l_child_node.appendChild(l_tnode)

   FOR l_i = 1 TO p_attr.getLength()
      CALL l_child_node.setAttribute(p_attr[l_i].name, p_attr[l_i].value)
   END FOR

   RETURN p_req_doc, l_child_node
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
PUBLIC FUNCTION awsp900_04_get_response(p_response_str)
   DEFINE p_response_str         STRING   
   DEFINE l_res_doc              xml.DomDocument
   DEFINE l_tag                  STRING             #節點tag名稱   
   DEFINE l_response_cdata       STRING
   #DEFINE l_bpm_response         xml.DomDocument
   
   DEFINE l_node_list            xml.DomNodeList
   DEFINE l_record_node          xml.DomNode
   DEFINE l_child_node           xml.DomNode
   DEFINE l_name                 STRING
   DEFINE l_processSN            STRING
   DEFINE l_status               STRING
   DEFINE l_response_content     xml.DomNode

   INITIALIZE l_response_content TO NULL
   
   #建立 Response XML Document
   LET l_res_doc = xml.DomDocument.create()
   CALL l_res_doc.loadFromString(p_response_str)
   
   #response字串轉換成XML格式失敗
   IF l_res_doc IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00023"
      LET g_errparam.extend = "Response"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #Response isn't valid XML document
      RETURN l_response_content
   END IF
   
   #取得服務執行結果狀態代碼 (<srvcode>)   
   LET g_srvcode = cl_bpm_get_node_value(l_res_doc, "code")

   #服務執行結果狀態代碼
   IF g_srvcode <> "000" THEN 
      DISPLAY "srvcode:", g_srvcode
      #RETURN l_response_content
   END IF   
   
   #取得payload
   LET l_tag = "payload"
   LET l_node_list = l_res_doc.getElementsByTagName(l_tag.trim())
   LET l_response_content = l_node_list.getitem(1)

   RETURN l_res_doc,l_response_content
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
PUBLIC FUNCTION awsp900_04_get_host_info()
   DEFINE r_attr                 type_g_attribute   #子節點的屬性資料
   DEFINE l_value                STRING
   DEFINE l_p                    LIKE type_t.num5
   DEFINE l_sb                   base.StringBuffer
   DEFINE l_timezone             STRING             #需求端時區
   
   #<host prod="TIPTOP" ver="1.0" ip="10.40.40.18" id="topprod" lang="zh_TW" timezone="+8" timestamp="20130925155232023" acct="tiptop" />
   LET r_attr[1].name = "prod"
   LET r_attr[1].value = "T100"

   LET r_attr[2].name = "ver"
   LET r_attr[2].value = FGL_GETENV("ERPVER") #cl_getenv_erp_version()

   LET r_attr[3].name = "ip"
   LET r_attr[3].value = cl_getenv_tpserver_ip()

   LET r_attr[4].name = "id"
   LET r_attr[4].value = FGL_GETENV("ZONE")          #"t10dap"

   LET r_attr[5].name = "lang"
   LET r_attr[5].value = g_lang

   LET l_timezone = g_timezone CLIPPED
   LET l_timezone = l_timezone.subString(4, l_timezone.getLength())
   IF cl_null(l_timezone) THEN
      LET l_timezone = "+8"
   END IF
   
  # LET r_attr[6].name = "acct"
  # LET r_attr[6].value = "admin"
   
   #LET r_attr[6].name = "timezone"
   #LET r_attr[6].value = l_timezone.trim()
   
   #LET l_value = CURRENT YEAR TO FRACTION(3)  
   LET l_sb = base.StringBuffer.create()
   CALL l_sb.append(l_value)
   CALL l_sb.replace(":","",0)
   CALL l_sb.replace(" ","",0)
   CALL l_sb.replace("-","",0)
   CALL l_sb.replace(".","",0)
   #LET l_value = l_sb.toString()
   #LET g_timestamp = l_value

  # LET r_attr[7].name = "timestamp"
   #LET r_attr[7].value = l_value.trim()          #"20131009140132023"
   
   RETURN r_attr
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
PUBLIC FUNCTION awsp900_04_syncProd()
   DEFINE l_status          STRING
   DEFINE l_pnode           xml.DomNode
   DEFINE l_request_cdata   STRING
   DEFINE l_xmltype         STRING
   DEFINE l_service         STRING            #服務名稱

   #將 XML 檔案轉為 XML DomNode
   CALL awsp900_01_filetoxml(g_request_file_path) 
     RETURNING l_status,gx_reqdoc,g_response.response

   IF l_status = FALSE THEN
      RETURN
   END IF
   
   #尋找對應名稱的tag資料,取得CROSS平台要求服務名稱
   LET g_service = cl_bpm_get_node_attribute(gx_reqdoc,"service","name")
   DISPLAY "syncProd:" , g_service
   LET g_prod_ip = cl_bpm_get_node_attribute(gx_reqdoc,"host","ip")
   DISPLAY "g_prod_ip:",g_prod_ip
   CALL awsp900_01_writeRequestLog()
   
   CASE g_service
       WHEN "getProdRegInfo"    #請求產品提供註冊資訊
          CALL awsp900_04_getProdRegInfo()
          
       WHEN "getSrvRegInfo"     #請求產品提供服務註冊資訊
          CALL awsp900_04_getSrvRegInfo() RETURNING g_response.response
          DISPLAY "getSrvRegInfo" 

       WHEN "doSyncProcess"     #傳送同步資訊至產品
          CALL awsp900_04_doSyncProcess()  
          DISPLAY "doSyncProcess" 
          
       WHEN "syncEncodingState" #接收資料編碼啟用狀態
          CALL awsp900_04_syncEncodingState()
          DISPLAY "syncEncodingState"

       WHEN "getEncodingState"  #取得資料編碼啟用狀態
          CALL awsp900_04_getEncodingState()
          DISPLAY "getEncodingState"
          
      OTHERWISE
          DISPLAY "unknown:" ,  g_service
          
   END CASE
   
   CALL awsp900_01_writeResponseLog()
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_getProdRegInfo()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_04_getProdRegInfo()
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode
   DEFINE l_req_attr             type_g_attribute   #request 屬性資料
   
   LET l_req_attr[1].name = "action"
   LET l_req_attr[1].value = "reg"
   
   CALL awsp900_04_create_request_head(l_req_attr)
      RETURNING l_req_doc, l_request_root 

   CALL l_request_root.appendChild(l_req_doc.createElement("payload")) #建立 <payload>
   
   LET g_response.response = l_req_doc.saveToString()
   #"<?xml version='1.0' encoding='UTF-8'?>", l_request_root.toString()
  
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
PUBLIC FUNCTION awsp900_04_getSrvRegInfo()
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode
   DEFINE l_req_attr             type_g_attribute   #request 屬性資料
   DEFINE l_pnode                xml.DomNode
   DEFINE l_sql                  STRING
   DEFINE l_gzja004              LIKE gzja_t.gzja004
   
   LET l_sql = "SELECT gzja004 FROM gzja_t WHERE gzjastus = 'Y'"
   PREPARE getSrvRegInfo_prepare FROM l_sql
   DECLARE gzja_curs CURSOR FOR getSrvRegInfo_prepare
      
   LET l_req_attr[1].name = "action"
   LET l_req_attr[1].value = "reg"
   
   CALL awsp900_04_create_request_head(l_req_attr)
      RETURNING l_req_doc, l_request_root 

   LET l_pnode = l_req_doc.createElement("payload") #建立 <payload>
   
   FOREACH gzja_curs INTO l_gzja004
      CALL awsp900_04_param(l_req_doc,l_pnode,"srvname","string",l_gzja004) 
   END FOREACH
   CALL l_request_root.appendChild(l_pnode)
   
   LET g_response.response = l_req_doc.saveToString()
   
   DISPLAY g_response.response
   RETURN　g_response.response
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
PRIVATE FUNCTION awsp900_04_param(p_doc,p_node,p_key,p_type,p_text)
DEFINE p_doc        xml.DomDocument
DEFINE p_node       xml.DomNode
DEFINE p_key        STRING
DEFINE p_type       STRING
DEFINE p_text       STRING
DEFINE l_tnode      xml.DomNode
DEFINE l_pnode      xml.DomNode
       
       LET l_pnode = p_doc.createElement("param")        #建立 <parm>
       LET l_tnode = p_doc.createTextNode(p_text)
       CALL l_pnode.appendChild(l_tnode)
       CALL l_pnode.setAttribute("key", p_key.trim())
       CALL l_pnode.setAttribute("type", p_type.trim())
       CALL p_node.appendChild(l_pnode)
       
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_doSyncProcess (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp900_04_doSyncProcess()
   DEFINE l_node_list      xml.DomNodeList
   DEFINE l_node           xml.DomNode
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_wsdl           LIKE ooaa_t.ooaa002     #取回EAI接口網址
   DEFINE l_ver            STRING     #CROSS WSDL 位置
   DEFINE l_ip             STRING     #CROSS WSDL 位置
   DEFINE l_id             STRING     #CROSS WSDL 位置
   DEFINE lc_gzsz008       LIKE gzsz_t.gzsz008 
   DEFINE l_ooaamoddt      LIKE ooaa_t.ooaamoddt
   
   LET l_node_list = gx_reqdoc.getElementsByTagName("cross")
   
   
   FOR l_i = 1 TO l_node_list.getCount()   
       LET l_node = l_node_list.getitem(l_i)
       LET l_wsdl = l_node.getAttribute("wsdl")  #取回EAI接口網址
       
       IF NOT cl_null(l_wsdl) THEN
       
          SELECT gzsz008 INTO lc_gzsz008 FROM gzsz_t
           WHERE gzsz002 = 'E-SYS-0704'
           
          LET l_ooaamoddt = cl_get_current() 
          UPDATE ooaa_t SET ooaa002 = l_wsdl,ooaamodid = g_user,ooaamoddt = l_ooaamoddt
           --WHERE ooaaent = g_enterprise
           WHERE ooaa002 = lc_gzsz008          
             AND ooaa001='E-SYS-0704'               
             
       END IF
          
       #CALL cl_log_parameter_update('E-SYS-0704',g_site,l_wsdl,l_wsdl)    
       #LET l_ver = l_node.getAttribute("ver")
       #LET l_ip  = l_node.getAttribute("ip")
       #LET l_id  = l_node.getAttribute("id")       
       display l_wsdl 
   END FOR
   
   CALL awsp900_04_addNewProd()
   
   CALL awsp900_04_doSyncProcess_response("000", "OK")
        
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_doSyncProcess_response(p_srvcode,p_payload)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp900_04_doSyncProcess_response(p_srvcode,p_payload)
   DEFINE p_srvcode         STRING
   DEFINE p_payload         STRING
   DEFINE l_resp_doc        xml.DomDocument
   DEFINE l_res_root        xml.DomNode
   DEFINE l_node            xml.DomNode
   DEFINE l_tnode           xml.DomNode
   
   LET l_resp_doc = xml.DomDocument.CreateDocument("response")
   LET l_res_root = l_resp_doc.getDocumentElement()
      
   LET l_node  = l_resp_doc.createElement("srvcode")        #建立 <srvcode>
   CALL l_res_root.appendChild(l_node)
   LET l_tnode = l_resp_doc.createTextNode(p_srvcode)
   CALL l_node.appendChild(l_tnode)
      
   LET l_node  = l_resp_doc.createElement("payload")        #建立 <payload>
   CALL l_res_root.appendChild(l_node)
   LET l_tnode = l_resp_doc.createTextNode(p_payload)
   CALL l_node.appendChild(l_tnode)
   
   LET g_response.response = l_resp_doc.saveToString()
   
   DISPLAY g_response.response
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
PUBLIC FUNCTION awsp900_04_syncEncodingState()
   DEFINE l_node_list      xml.DomNodeList
   DEFINE l_node           xml.DomNode
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_encode_eai     STRING
   DEFINE l_encode         LIKE ooaa_t.ooaa002
   DEFINE l_code         STRING
   DEFINE l_host_ip       LIKE ooaa_t.ooaa002
   DEFINE l_ooaamoddt      LIKE ooaa_t.ooaamoddt

   LET l_encode_eai = ''
   LET l_encode = ''
   LET l_encode_eai = cl_bpm_get_node_value(gx_reqdoc,"param") 
   #DISPLAY 'l_encode_eai:',l_encode_eai
   #DISPLAY 'l_encode:',l_encode
   IF cl_null(l_encode_eai) THEN
      LET l_code = '100'
   ELSE
      IF l_encode_eai = 'true' THEN
         LET l_encode = 'Y'
      ELSE
         LET l_encode = 'N'
      END IF
      LET l_code = '001'
   END IF   
      
   IF NOT cl_null(l_encode_eai) THEN
   
          LET l_host_ip = '%',g_prod_ip CLIPPED,'%' 
          LET l_ooaamoddt = cl_get_current()
          UPDATE ooaa_t SET ooaa002 = l_encode,ooaamodid = g_user,ooaamoddt = l_ooaamoddt
           --WHERE ooaaent = g_enterprise
           WHERE ooaaent in (select ooaaent from ooaa_t where ooaa001 = 'E-SYS-0704' and ooaa002 like l_host_ip)           
             AND ooaa001='E-SYS-0717'     

      IF SQLCA.sqlcode THEN
         DISPLAY SQLCA.sqlcode 
      END IF
             
   END IF
      
   display l_encode 

   CALL awsp900_04_doSyncProcess_response(l_code, "OK")
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
PUBLIC FUNCTION awsp900_04_getEncodingState()
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode
   DEFINE l_req_attr             type_g_param   #request 屬性資料
   DEFINE l_pnode                xml.DomNode
   DEFINE l_tnode           xml.DomNode
   DEFINE l_sql                  STRING
   DEFINE l_encode               STRING
   DEFINE l_encode_eai           STRING
   DEFINE l_code                 STRING
 
   LET l_encode = cl_get_para(g_enterprise,g_site,"E-SYS-0717")

   IF cl_null(l_encode) THEN
      LET l_code = '100'
   ELSE
      IF l_encode = 'Y' THEN
         LET l_encode_eai = 'true'
      ELSE
         LET l_encode_eai = 'false'
      END IF
      LET l_code = '001'
   END IF
   
   INITIALIZE l_request_root TO NULL
   INITIALIZE l_pnode TO NULL
   
   
    #產生 response xml.DomDocument
    LET l_req_doc = xml.DomDocument.CreateDocument("response")
    CALL l_req_doc.setFeature("format-pretty-print", true)

    LET l_request_root = l_req_doc.getDocumentElement()

    LET l_pnode = l_req_doc.createElement("srvcode")    #建立 <srvcode> 
    CALL l_request_root.appendChild(l_pnode)
    LET l_tnode = l_req_doc.createTextNode(l_code)
    CALL l_pnode.appendChild(l_tnode)

    LET l_req_attr[1].name = "isEncoding"
    LET l_req_attr[1].value = "boolean"
    LET l_req_attr[1].text = l_encode_eai

    CALL awsp900_04_create_payload(l_req_doc,l_request_root,l_req_attr)
      RETURNING l_req_doc, l_request_root 

   
   LET g_response.response = l_req_doc.saveToString()
   
   DISPLAY g_response.response
        
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_04_addNewProd()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_04_addNewProd()
   DEFINE l_node_list      xml.DomNodeList
   DEFINE l_pnode          xml.DomNode
   DEFINE l_tnode          xml.DomNode
   DEFINE l_prod           DYNAMIC ARRAY OF RECORD
            name           LIKE wsef_t.wsef001,
            l_ver          LIKE wsef_t.wsef002,
            l_ip           LIKE wsef_t.wsef003,
            l_id           LIKE wsef_t.wsef004,
            l_wsdl         LIKE ooaa_t.ooaa002,
            l_standard     LIKE wsef_t.wsef006,
            l_ent          LIKE wsef_t.wsef007,
            l_site         LIKE wsef_t.wsef008
       END RECORD
   DEFINE l_wsef           DYNAMIC ARRAY OF RECORD
           wsef001         LIKE wsef_t.wsef001
       END RECORD
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_j              LIKE type_t.num5
   DEFINE l_prod_num       LIKE type_t.num5
   DEFINE lb_found         BOOLEAN
   DEFINE lb_name          STRING
   DEFINE l_wsef001        LIKE wsef_t.wsef001
   
   LET l_j = 1
   
   #從 wsef_t 中抓出 wsef001 的值
   LET g_sql = "SELECT wsef001 FROM wsef_t WHERE wsef006 = 'S'"
   
   DECLARE awsi900_04_curs CURSOR FROM g_sql
   FOREACH awsi900_04_curs INTO l_wsef001
   
      IF NOT cl_null(l_wsef001) THEN
      
         LET l_wsef[l_j].wsef001 = l_wsef001
         LET l_j = l_j + 1
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH awsp900_04_addNewProd:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         
      END IF
      
   END FOREACH
   
   #取得 wsef001 總項數
   LET l_prod_num = l_j - 1  
    
   LET l_j = 1
   LET lb_found = FALSE
   
   #取得 prodlist 下所有節點
   LET l_node_list = gx_reqdoc.getElementsByTagName("prodlist")
  
   IF l_node_list.getCount() > 0 THEN
      FOR l_i = 1  TO l_node_list.getCount()
         LET l_pnode = l_node_list.getitem(l_i)
         # prodlist 下第二個子節點，取得內容.
         LET l_tnode = l_pnode.getFirstChild()
         WHILE ( l_tnode IS NOT NULL )
         
           lET l_tnode = l_tnode.getNextSiblingElement()
           
           IF l_tnode IS NOT NULL THEN 
              LET lb_name = l_tnode.getLocalName()
           ELSE
              LET lb_name = ""
           END IF
           
           #當下節點為 prod 子節點才取值
           IF lb_name = "prod" THEN
           
              LET l_prod[l_j].name   = l_tnode.getAttribute("name")
              LET l_prod[l_j].l_ver  = l_tnode.getAttribute("ver") 
              LET l_prod[l_j].l_ip   = l_tnode.getAttribute("ip")
              LET l_prod[l_j].l_id   = l_tnode.getAttribute("id")
              LET l_prod[l_j].l_wsdl = l_tnode.getAttribute("wsdl")           
              LET l_prod[l_j].l_standard = 'S'
              LET l_prod[l_j].l_ent = 99
              LET l_prod[l_j].l_site = ' '
              IF NOT cl_null(l_prod[l_j].name) AND l_prod[l_j].name != "T100" THEN
                 FOR l_cnt = 1 TO l_prod_num
                    # prodlist 此筆內容已存在wsef_t, 進行 update
                    IF l_prod[l_j].name = l_wsef[l_cnt].wsef001 THEN
                    
                       IF cl_null(l_prod[l_j].l_id) THEN
                          LET l_prod[l_j].l_id = " "
                       END IF
                       
                       UPDATE wsef_t SET (wsef001,wsef002,wsef003,wsef004,wsef005,wsef006,wsef007,wsef008) = (l_prod[l_j].name, 
                                  l_prod[l_j].l_ver,l_prod[l_j].l_ip,l_prod[l_j].l_id,l_prod[l_j].l_wsdl,l_prod[l_j].l_standard,l_prod[l_j].l_ent,l_prod[l_j].l_site)
                        WHERE wsef001 = l_prod[l_j].name
                        
                        LET lb_found = TRUE
                        
                        EXIT FOR
                    END IF 
                 END FOR
                 # prodlist 此筆內容不存在wsef_t, 進行 insert
                 IF lb_found = FALSE THEN
                 
                    IF cl_null(l_prod[l_j].l_id) THEN
                       LET l_prod[l_j].l_id = " "
                    END IF
                    
                    INSERT INTO wsef_t (wsef001,wsef002,wsef003,wsef004,wsef005,wsef006,wsef007,wsef008) 
                    VALUES(l_prod[l_j].*)--,'S',99,' ')   
                          
                    IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = "wsef_t" 
                       LET g_errparam.code   = SQLCA.sqlcode 
                       LET g_errparam.popup  = FALSE 
                       CALL cl_err()
                    END IF 
                    
                 END IF
                 
                 LET l_j = l_j + 1
                 LET lb_found = FALSE
                 
              END IF
           END IF
        END WHILE         
      END FOR 
   END IF
   
END FUNCTION

 
{</section>}
 
