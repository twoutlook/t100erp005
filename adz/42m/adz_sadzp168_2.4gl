#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/02/19
#
#+ 程式代碼......: sadzp168_2
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_2.4gl 
# Description    : sadzp168_4fd的程式子檔案(共用副程式)
# Memo           :
#                  20160223 160223-00028 by madey :patch優化專案
#                                        畫面重產時，備份檔案的份數及命名調整

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"
GLOBALS "../4gl/adzi888_global.inc"

#定義本程式所使用到的常數 
CONSTANT g_file_type = "4fd"     

#+ 載入4fd畫面成domNode
PUBLIC FUNCTION sadzp168_2_get_4fd(p_module, p_form_name)
   DEFINE p_module          STRING                #4fd所在模組
   DEFINE p_form_name       STRING                #4fd畫面檔檔案名稱,xxxx.4fd
   
   DEFINE l_path            STRING                #4fd路徑

   DEFINE r_template_node   om.DomNode            #4fd domNode
   
   INITIALIZE r_template_node TO NULL

   #模組名稱統一轉成大寫
   LET p_module = UPSHIFT(p_module)

   #取得畫面檔案所在路徑
   LET l_path = os.Path.join(FGL_GETENV(p_module.trim()), g_file_type.trim())   
   LET l_path = os.Path.join(l_path, p_form_name.trim() || "." || g_file_type.trim())
   
   IF NOT os.Path.exists(l_path) THEN
      IF g_rtn_msg THEN
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00307", g_lang, p_form_name)
         DISPLAY g_error_message
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00307"
         LET g_errparam.extend = "sadzp168_2"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  p_form_name
         CALL cl_err()
      END IF
      
      RETURN r_template_node
   END IF

   #載入程式所屬UI樣版成domNode
   LET r_template_node = sadzp168_2_load_xml_to_dom(l_path) 
         
   RETURN r_template_node
END FUNCTION

#+ 將xml檔載入Dom
PUBLIC FUNCTION sadzp168_2_load_xml_to_dom(p_xmlFile)
   DEFINE p_xmlFile          STRING
   DEFINE l_domDoc           om.DomDocument
   DEFINE r_domRoot          om.DomNode
   
   IF NOT os.Path.exists(p_xmlFile) THEN
      IF g_rtn_msg THEN
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00307", g_lang, p_xmlFile)
         DISPLAY g_error_message
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00307"
         LET g_errparam.extend = "sadzp168_2"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  p_xmlFile
         CALL cl_err()
      END IF
      
      RETURN r_domRoot
   END IF

   LET l_domDoc = om.DomDocument.createFromXmlFile(p_xmlFile)
   LET r_domRoot = l_domDoc.getDocumentElement()

   RETURN r_domRoot
END FUNCTION

#+ 取得畫面檔Form的節點(domNode)
PUBLIC FUNCTION sadzp168_2_get_form_node(p_domNode, p_tag) 
   DEFINE p_domNode         om.DomNode     #XML Root Node
   DEFINE p_tag             STRING         #要尋找的Tag Name
   
   DEFINE l_node_list       om.NodeList
   DEFINE l_node            om.DomNode
   
   INITIALIZE l_node TO NULL
   
   #尋找符合的tag name節點
   LET l_node_list = p_domNode.selectByTagName(p_tag.trim())

   #靜態畫面檔:一個檔案應該只會有一個Form節點
   IF l_node_list.getLength() > 1 THEN
      DISPLAY "The number of form nodes is more than one."
   ELSE
      LET l_node = l_node_list.item(1)
   END IF
   
   RETURN l_node
END FUNCTION

#+ 取得符合條件的節點(domNode)
PUBLIC FUNCTION sadzp168_2_get_domNode(p_domNode, p_tag, p_att_name, p_value) 
   DEFINE p_domNode         om.DomNode     #XML Root Node
   DEFINE p_tag             STRING         #要尋找的Tag Name
   DEFINE p_att_name        STRING         #要尋找的Attribute Name
   DEFINE p_value           STRING         #要尋找的Attribute Value
   
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_node_list       om.NodeList
   DEFINE l_node            om.DomNode
   
   INITIALIZE l_node TO NULL
   
   #尋找符合的tag name節點
   LET l_node_list = p_domNode.selectByTagName(p_tag.trim())

   FOR l_i = 1 to l_node_list.getLength()
      LET l_node = l_node_list.item(l_i)
      
      IF l_node.getAttribute(p_att_name) = p_value.trim() THEN
         RETURN l_node
         EXIT FOR
      END IF
   END FOR

   INITIALIZE l_node TO NULL
   
   RETURN l_node
END FUNCTION

#+ 取得4fd目前所使用的 fieldid 和 tabIndex 最大值
PUBLIC FUNCTION sadzp168_2_search_fieldId_tabIndex_max(p_domNode, p_fieldId_max, p_tabIndex_max)
   DEFINE p_domNode         om.DomNode
   DEFINE p_fieldId_max     LIKE type_t.num10   #4fd上 fieldid 最大值
   DEFINE p_tabIndex_max    LIKE type_t.num10   #4fd上 tabIndex 最大值 
   
   DEFINE l_tmpStr          STRING

   #取得此節點"fieldId"的屬性值
   LET l_tmpStr = p_domNode.getAttribute("fieldId")
   
   IF l_tmpStr.getLength() > 0 THEN
      IF p_domNode.getAttribute("fieldId") > p_fieldId_max THEN
         LET p_fieldId_max = p_domNode.getAttribute("fieldId")
      END IF
   END IF

   #取得此節點"tabIndex"的屬性值
   LET l_tmpStr = p_domNode.getAttribute("tabIndex")
   
   IF l_tmpStr.getLength() > 0 THEN
      IF p_domNode.getAttribute("tabIndex") > p_tabIndex_max THEN
         LET p_tabIndex_max = p_domNode.getAttribute("tabIndex")
      END IF
   END IF

   #控制權移到其第一個子節點
   LET p_domNode = p_domNode.getFirstChild()

   #若節點為空則不再進行遞迴
   WHILE p_domNode IS NOT NULL   
      CALL sadzp168_2_search_fieldId_tabIndex_max(p_domNode, p_fieldId_max, p_tabIndex_max)
         RETURNING p_fieldId_max, p_tabIndex_max
         
      #控制權移到下一個同層的節點
      LET p_domNode = p_domNode.getNext()   
   END WHILE

   RETURN p_fieldId_max, p_tabIndex_max
END FUNCTION

#+ 實際生成 4fd畫面檔
PUBLIC FUNCTION sadzp168_2_gen_4fd_file(p_name, p_node, p_compile)
   DEFINE p_name                  LIKE gzza_t.gzza001          #4fd畫面檔檔案名稱,xxxx.4fd 
   DEFINE p_node                  om.DomNode
   DEFINE p_compile               LIKE type_t.chr1             #是否編譯
   
   DEFINE ls_code_filename        STRING
   DEFINE l_gzza003               LIKE gzza_t.gzza003
   DEFINE l_module                STRING
   DEFINE l_flag                  BOOLEAN
   DEFINE l_str                   STRING
   DEFINE l_dzfq005               LIKE dzfq_t.dzfq005
   DEFINE ls_result               STRING                       #160223-00028
   
   IF p_node IS NULL THEN
      #整個畫面結構(xml)為空
      IF g_rtn_msg THEN
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00076", g_lang, p_name)
         DISPLAY g_error_message
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00076"
         LET g_errparam.extend = "sadzp168_2"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_name
         CALL cl_err()
      END IF
      
      RETURN FALSE
   END IF

   IF cl_null(g_gzza003_module) THEN      
      #取得畫面所屬類別(M:主程式畫面, S:子程式畫面, F:子畫面)
      LET l_dzfq005 = sadzp060_2_chk_spec_type(p_name) 
      
      IF l_dzfq005 = "N" THEN
         IF g_rtn_msg THEN
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00495", g_lang, p_name)
            DISPLAY g_error_message
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00495"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_name
            CALL cl_err()
         END IF
         
         RETURN FALSE
      END IF

      #取得模組
      LET g_gzza003_module = sadzp062_1_find_module(p_name, l_dzfq005) 
      
      IF cl_null(g_gzza003_module) THEN
         IF g_rtn_msg THEN
            LET g_error_message = "ERROR:", cl_getmsg("adz-00012", g_lang)
            DISPLAY g_error_message
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00012"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         
         RETURN FALSE
      END IF
   END IF 

   LET l_module = g_gzza003_module
   LET l_module = l_module.toUpperCase()
   
   #產出程式路徑
   LET ls_code_filename = os.Path.join(FGL_GETENV(l_module), "4fd")
   LET ls_code_filename = os.Path.join(ls_code_filename, p_name CLIPPED || ".4fd")
   DISPLAY "產生檔位置:", ls_code_filename

   ##確認檔案寫入權限
   #LET l_flag = os.Path.writable(ls_code_filename)
   #IF NOT l_flag THEN
   #   CALL cl_err_msg(NULL, "adz-00017", g_dzfa_m.dzfa001 CLIPPED, 0)   #todo
   #   RETURN FALSE
   #END IF 

   ##產出 4fd檔前先將原先實體檔案刪除,以免發生無法產生新檔覆蓋情況(檔案權限問題)
   #IF os.Path.exists(ls_code_filename) THEN
   #   IF NOT os.Path.delete(ls_code_filename) THEN
   #      CALL cl_err_msg(NULL, "adz-00082", ls_code_filename.trim(), 0)
   #      RETURN FALSE
   #   END IF
   #END IF

   #產出 4fd檔前先將原先實體檔案rename,以免發生無法產生新檔覆蓋情況(檔案權限問題)
   #Begin: 160223-00028 -modify-
   #IF os.Path.delete(ls_code_filename || ".bak") THEN END IF
   #IF NOT os.Path.rename(ls_code_filename, ls_code_filename || ".bak") THEN
   #   DISPLAY "Warning:rename failed."
   #END IF
   IF g_backfile > 0 THEN
      CALL sadzp007_util_backfile(ls_code_filename,g_backfile)
   ELSE
      CALL sadzp007_util_backfile(ls_code_filename,'')
   END IF
   #End: 160223-00028 -modify-
   
   #實際在路徑下產出.4fd檔
   CALL p_node.writeXml(ls_code_filename)
   
   IF NOT os.Path.exists(ls_code_filename) THEN
      IF g_rtn_msg THEN
         LET g_error_message = "ERROR:", cl_getmsg("adz-00011", g_lang)
         DISPLAY g_error_message
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00011"
         LET g_errparam.extend = "generate"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      RETURN FALSE
   END IF

   IF sadzp168_2_compile_file(l_module, p_name, p_compile) THEN
      ##IF g_gen42s_flag THEN
      #   LET l_str = "r.g42s ", p_name CLIPPED, " &"
      #   RUN l_str WITHOUT WAITING

      #   IF STATUS THEN
      #      LET l_str = "Warning-", l_str.trim(), ":", cl_getmsg(STATUS, g_lang)
      #      DISPLAY l_str
      #   END IF
      ##END IF
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

#+ 編譯4fd,實際生成42f畫面檔
PUBLIC FUNCTION sadzp168_2_compile_file(p_module, p_name, p_compile)
   DEFINE p_module       STRING                #程式所屬模組名稱
   DEFINE p_name         STRING                #4fd畫面檔檔案名稱,xxxx.4fd 
   DEFINE p_compile      LIKE type_t.chr1      #是否編譯
   
   DEFINE l_cmd          STRING                #要執行的指令
   DEFINE l_path         STRING                #要編譯的路徑
   DEFINE ls_str         STRING
   DEFINE l_msg          STRING                #編譯後訊息
   DEFINE l_read         base.Channel
   DEFINE l_result       LIKE type_t.chr1      #編譯成功或失敗
   DEFINE l_tmp          STRING

   LET l_read = base.Channel.create()
   LET l_result = "Y"

   LET l_cmd = "r.f ", p_name.trim(), " 2>&1"

   #預設不gen 42s下,帶入第2參數(tiptop)
   IF NOT cl_null(g_gen42s_flag) AND (NOT g_gen42s_flag) THEN
      LET l_cmd = "r.f ", p_name.trim(), " ", g_gen42s_arg2 CLIPPED, " 2>&1"
   END IF
   
   LET l_msg = l_cmd, ASCII 10

   #切換目錄
   IF NOT cl_null(p_module) THEN
      LET p_module = p_module.toUpperCase()
      LET l_path = os.Path.join(FGL_GETENV(p_module), "4fd")
      LET l_cmd = "cd ", l_path, "; ", l_cmd
   ELSE
      IF g_rtn_msg THEN
         LET g_error_message = "ERROR:", cl_getmsg("adz-00012", g_lang)
         DISPLAY g_error_message
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00012"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      RETURN FALSE
   END IF

   LET g_error_message  = ""
   
   #不進行編譯時,直接run command
   IF (p_compile IS NOT NULL) AND (NOT p_compile) THEN
      RUN l_cmd
      RETURN TRUE
   END IF
   
   #執行指令
   CALL l_read.openPipe(l_cmd, "r")

   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF
      LET l_msg = l_msg, ls_str, ASCII 10
      LET l_tmp = ls_str
      LET ls_str = ls_str.toUpperCase()
      
      #遇到編譯錯誤訊息時,結束整個作業
      IF ls_str.getIndexOf("ERROR", 1) > 0 THEN
         LET l_result = "N"
         LET g_error_message = g_error_message, l_tmp, ASCII 10
      END IF
   END WHILE
   CALL l_read.close()

   DISPLAY l_msg
   IF l_result = "N" THEN
      #show出最後編譯結果,提供使用者判斷是否整個過程都成功
      #todo:這邊show msg的做法可提供show出整個編譯錯誤的訊息
      IF g_rtn_msg THEN
         DISPLAY "ERROR:", cl_getmsg("adz-00013", g_lang)
         #DISPLAY g_error_message
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00013"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

# 設置sr的RecordField屬性
PUBLIC FUNCTION sadzp168_2_set_sr_attr(p_sr_child, p_node)
   DEFINE p_sr_child          om.DomNode            #新欄位的 SR 子節點
   DEFINE p_node              om.DomNode            #在Form裡的widget節點,用來參考屬性資料
   
   DEFINE l_tab_name          STRING                #欄位所屬資料表名稱
   DEFINE l_tab_alias_name    STRING                #資料表別名
   DEFINE l_col_name          STRING                #欄位名稱
   DEFINE l_name              STRING                #4fd上widget屬性TABLE_COLUMN時的命名(name屬性)
   DEFINE l_field_type        STRING                #欄位的fieldType
   DEFINE l_field_id_ref      STRING                #欄位的fieldIdRef
   
   LET l_tab_name = p_node.getAttribute("sqlTabName") CLIPPED
   LET l_tab_alias_name = p_node.getAttribute("table_alias_name") CLIPPED
   LET l_col_name = p_node.getAttribute("colName") CLIPPED
   LET l_name = p_node.getAttribute("name") CLIPPED
   LET l_field_type = p_node.getAttribute("fieldType") CLIPPED
   LET l_field_id_ref = p_node.getAttribute("fieldId") CLIPPED

   CASE l_field_type.trim()
      WHEN "NON_DATABASE"    #NON_DATABASE
         CALL p_sr_child.setAttribute("name", l_name.trim())
         CALL p_sr_child.setAttribute("colName", "")
         CALL p_sr_child.setAttribute("sqlTabName", "")
         
      WHEN "COLUMN_LIKE"     #COLUMN_LIKE
         CALL p_sr_child.setAttribute("fieldType", "COLUMN_LIKE")

         CALL p_sr_child.setAttribute("name", l_name.trim())
         CALL p_sr_child.setAttribute("colName", l_col_name.trim())
         CALL p_sr_child.setAttribute("sqlTabName", l_tab_name.trim())
         
      WHEN "TABLE_ALIAS"     #TABLE_ALIAS
         CALL p_sr_child.setAttribute("fieldType", "TABLE_ALIAS")

         CALL p_sr_child.setAttribute("name", l_name.trim())
         CALL p_sr_child.setAttribute("colName", l_col_name.trim())
         CALL p_sr_child.setAttribute("sqlTabName", l_tab_name.trim())
         CALL p_sr_child.setAttribute("table_alias_name", l_tab_alias_name.trim())
         
      WHEN "TABLE_COLUMN"    #TABLE_COLUMN
         CALL p_sr_child.setAttribute("fieldType", "TABLE_COLUMN")
         CALL p_sr_child.setAttribute("name", l_name.trim())
         CALL p_sr_child.setAttribute("colName", l_col_name.trim())
         CALL p_sr_child.setAttribute("sqlTabName", l_tab_name.trim())
         
      OTHERWISE
         CALL p_sr_child.setAttribute("name", l_name.trim())
         CALL p_sr_child.setAttribute("colName", "")
         CALL p_sr_child.setAttribute("sqlTabName", "")
   END CASE

   CALL p_sr_child.setAttribute("fieldIdRef", l_field_id_ref) 
   
END FUNCTION

#+ fieldId和tabIndex屬性都要是4fd的唯一值
PUBLIC FUNCTION sadzp168_2_field_add_index(p_node, p_attribute_name, p_fieldId_max, p_tabIndex_max)
   DEFINE p_node             om.DomNode              #新增節點
   DEFINE p_attribute_name   LIKE dzfk_t.dzfk005     #屬性名稱
   DEFINE p_fieldId_max      LIKE type_t.num10       #4fd上 fieldid 最大值
   DEFINE p_tabIndex_max     LIKE type_t.num10       #4fd上 tabIndex 最大值 
   
   #因為要新增加欄位,所以fieldId和tabIndex都要依續加1,都要是畫面的唯一值
   IF p_attribute_name = "fieldId" THEN
      LET p_fieldId_max = p_fieldId_max + 1
      CALL p_node.setAttribute(p_attribute_name, p_fieldId_max)
   END IF

   IF p_attribute_name = "tabIndex" THEN
      LET p_tabIndex_max = p_tabIndex_max + 1
      CALL p_node.setAttribute(p_attribute_name, p_tabIndex_max)
   END IF

   RETURN p_fieldId_max, p_tabIndex_max
END FUNCTION

#1.判斷Screen Records是否存在
#2.新增一個Screen Records節點
PUBLIC FUNCTION sadzp168_2_add_sr_structure(p_sr_name, p_template_node, p_sr_ref, p_node_before)
   DEFINE p_sr_name         STRING                  #Screen Record節點的[name]屬性設置值
   DEFINE p_template_node   om.DomNode              #UI樣版
   DEFINE p_sr_ref          om.DomNode              #新增SR節點時,所需參考設置屬性的SR節點(通常是Undefined)
   DEFINE p_node_before     om.DomNode              #插入節點
   
   DEFINE l_sr_node         om.DomNode              #Screen Record節點 
   DEFINE l_i               LIKE type_t.num5

   INITIALIZE l_sr_node TO NULL
   
   
   #尋找SR節點是否已存在樣版中
   LET l_sr_node = sadzp168_2_get_domNode(p_template_node, "Record", "name", p_sr_name.trim()) 

   #SR節點存在時,直接回傳此節點   
   IF l_sr_node IS NOT NULL THEN
      RETURN l_sr_node
   END IF
   
   LET l_sr_node = p_template_node.createChild("Record")

   #抄寫公版上SR節點的屬性
   FOR l_i = 1 TO p_sr_ref.getAttributesCount()
       CALL l_sr_node.setAttribute(p_sr_ref.getAttributeName(l_i), p_sr_ref.getAttributeValue(l_i))

       #變更SR節點[name]屬性
       IF p_sr_ref.getAttributeName(l_i) = "name" THEN
          #140624發現[查詢方案]和[相關作業]二個container和SR在公版上的名稱不一致,因此特別加上此判斷
          IF p_sr_name = "queryplan" OR p_sr_name = "relateapps" THEN
             LET p_sr_name = "s_", p_sr_name.trim()
          END IF
          
          CALL l_sr_node.setAttribute("name", p_sr_name.trim())
       END IF
          
       IF p_sr_ref.getAttributeName(l_i) = "uid" THEN
          CALL l_sr_node.removeAttribute("uid")
       END IF
   END FOR

   #將新增的 Screen Record節點 insert在 Form節點之前
   IF p_node_before IS NOT NULL THEN
      CALL p_template_node.insertBefore(l_sr_node, p_node_before) 
   END IF

   RETURN l_sr_node
END FUNCTION

#+ 取得模組代碼
PUBLIC FUNCTION sadzp168_2_get_module(p_dzfi001)
   DEFINE p_dzfi001            LIKE dzfi_t.dzfi001     #畫面代號
   
   DEFINE l_dzfq005            LIKE dzfq_t.dzfq005     #主/子程式
   DEFINE l_gzza002            LIKE gzza_t.gzza002     #程式類別
   DEFINE l_gzza003            LIKE gzza_t.gzza003     #模組代碼
   DEFINE l_gzzal003           LIKE gzzal_t.gzzal003   #程式名稱
   DEFINE l_gzza003_module     LIKE gzza_t.gzza003     #模組代碼
   #DEFINE l_use_tpl       LIKE gzza_t.gzza007   #是否使用樣板 Y:使用結構樣板 N:FreeStyle產生框架
   
   LET l_gzza003 = ""
   
   LET l_dzfq005 = sadzp060_2_chk_spec_type(p_dzfi001) 
   CALL sadzp168_1_gzza002(p_dzfi001, l_dzfq005) 
      RETURNING l_gzza002, l_gzza003, l_gzza003_module, l_gzzal003   #, l_use_tpl
   
   RETURN l_gzza003_module
END FUNCTION
