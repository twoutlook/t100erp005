#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp140_gen_4fd
#+ Buildtype: 
#+ Memo.....: 是adzp140 副程式，產生4fd
# Modify.........:2016/02/03 By jrg542 修改元件排版位置
#160519-00018 #1 2016/05/19 by jrg542 多語言產生器調整編譯順序位置及增加全部重產功能

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS 
   DEFINE g_properties    om.SaxAttributes 
   DEFINE g_table_id STRING    #table id

   TYPE type_g_table_info RECORD 
     table_id     LIKE dzeb_t.dzeb001,    #table id
     field_id     LIKE dzeb_t.dzeb002,    #field id
     field_pk     LIKE dzeb_t.dzeb004,    #是否 pk
     field_type   LIKE dzeb_t.dzeb006,    #field 屬性 (field type ex:230)
     widge_code   LIKE dzep_t.dzep010,    #widge code (ex:05)
     field_ent    LIKE type_t.num5,       #是否 ent
     field_lang   LIKE type_t.num5        #是否 lang 語言別     
     END RECORD
     
   DEFINE g_table_info   DYNAMIC ARRAY OF type_g_table_info     
   DEFINE g_key_count     LIKE type_t.num5  #key 總數  
   DEFINE g_pkey_count    LIKE type_t.num5  #pk 總數 
   DEFINE gs_code_filename STRING           #4gl 檔案名稱
   DEFINE g_generation_ch base.Channel
END GLOBALS

#-----處理 4fd 部分
DEFINE gnode_4fd        om.DomNode
DEFINE g_posX           LIKE type_t.num10       #目前元件X軸位置
DEFINE g_posY           LIKE type_t.num10       #目前元件Y軸位置
DEFINE g_fieldId_max    LIKE type_t.num10       #4fd上 fieldid 最大值
DEFINE g_tabIndex_max   LIKE type_t.num10       #4fd上 tabIndex 最大值 
DEFINE g_field_num      LIKE type_t.num5        #目前table內元件的個數 #No.000002
DEFINE g_grid_height    LIKE type_t.num10       #高度 
DEFINE g_grid_width     LIKE type_t.num10       #目前table內元件已使用寬度
DEFINE g_grid_width2    LIKE type_t.num10       #目前grid內元件已使用寬度

#+ 產生4fd 
PUBLIC FUNCTION sadzp140_generate_4fd()
   DEFINE ls_4fd_file        STRING
   DEFINE l_sr_node          om.DomNode
   DEFINE l_sr_tmp_node      om.DomNode
   DEFINE l_table_node       om.DomNode
   DEFINE l_table_tmp_node   om.DomNode
   DEFINE l_sr_undefine_node om.DomNode    #單頭 sr Undefined
   DEFINE l_master_node     om.DomNode     #單頭
   
   #因此預設 posX=1, posY=0
   LET g_posX = 0
   LET g_posY = 0
   LET g_grid_width = 1
   LET g_grid_height = 0
  
   #取得lng/mdl 的UI畫面樣版檔:ntab_template.4fd檔
   LET ls_4fd_file = adzp140_load_4fd_template()
  
   DISPLAY "畫面樣版檔:",ls_4fd_file
   #Load lng/mdl 的UI畫面樣版檔:ntab_template.4fd檔至om.DomNode為XML格式文件
   LET gnode_4fd = sadzp140_load_xml_to_dom(ls_4fd_file)
    
   #取得lng/mdl 的UI畫面樣版檔目前所使用的fieldId和tabIndex最大值
   CALL sadzp140_search_fieldId_tabIndex_max(gnode_4fd)  
   #取得開窗4fd檔上的screen record節點
   #以利在節點內建立開窗欄位的子節點

   LET l_sr_undefine_node = sadzp140_get_domNode(gnode_4fd, "Record", "name", "Undefined")  

   LET l_sr_tmp_node = sadzp140_get_domNode(gnode_4fd, "Record", "name", "s_nlng") 

   LET l_sr_node = sadzp140_get_domNode(l_sr_tmp_node, "RecordField", "name", "ref_node") 
   
   #取得開窗4fd檔上的table(表格陣列)節點
   #以利在節點內建立開窗欄位的子節點
   LET l_table_tmp_node = sadzp140_get_domNode(gnode_4fd, "Table", "name", "s_nlng")
   LET l_table_node = sadzp140_get_domNode(l_table_tmp_node, "Edit", "name", "ref_node")  
   LET l_master_node = sadzp140_get_domNode(gnode_4fd, "Grid", "name", "gridmst")  #單頭
  
   IF l_sr_node IS NULL OR l_table_node IS NULL THEN
      DISPLAY "The ntab_template.4fd is error."
      RETURN
   END IF

   #開始在n_xxx 4fd畫面檔中加入開窗設定需要顯示的欄位
   CALL sadzp140_add_field(l_sr_tmp_node, l_table_tmp_node,l_sr_undefine_node,l_master_node) #要個別呼叫 單頭 單身
   CALL l_sr_tmp_node.removeChild(l_sr_node)
   CALL l_table_tmp_node.removeChild(l_table_node)

   #實際生成q_xxx 4fd畫面檔
   CALL adzp140_gen_4fd_file()
 
END FUNCTION

#+ 取得符合條件的節點(domNode)
PRIVATE FUNCTION sadzp140_get_domNode(p_domNode, p_tag, p_att_name, p_value) 
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
  
   RETURN l_node
   
END FUNCTION

#+ 將xml檔載入Dom
PRIVATE FUNCTION sadzp140_load_xml_to_dom(p_xmlFile)
   DEFINE p_xmlFile STRING
   DEFINE l_domDoc  om.DomDocument
   DEFINE r_domRoot om.DomNode

   LET l_domDoc = om.DomDocument.createFromXmlFile(p_xmlFile)
   LET r_domRoot = l_domDoc.getDocumentElement()

   RETURN r_domRoot
END FUNCTION

#+ 取得4fd目前所使用的 fieldid 和 tabIndex 最大值
FUNCTION sadzp140_search_fieldId_tabIndex_max(p_domNode) #
   DEFINE p_domNode   om.DomNode
   DEFINE l_tmpStr    STRING

   #取得此節點"fieldId"的屬性值
   LET l_tmpStr = p_domNode.getAttribute("fieldId")
   
   IF l_tmpStr.getLength() > 0 THEN
      IF p_domNode.getAttribute("fieldId") > g_fieldId_max THEN  #fieldId
         LET g_fieldId_max = p_domNode.getAttribute("fieldId")
      END IF
   END IF

   #取得此節點"tabIndex"的屬性值
   LET l_tmpStr = p_domNode.getAttribute("tabIndex")
   
   IF l_tmpStr.getLength() > 0 THEN
      IF p_domNode.getAttribute("tabIndex") > g_tabIndex_max THEN
         LET g_tabIndex_max = p_domNode.getAttribute("tabIndex")  #tabIndex 
      END IF
   END IF

   #控制權移到其第一個子節點
   LET p_domNode = p_domNode.getFirstChild()

   #若節點為空則不再進行遞迴
   WHILE p_domNode IS NOT NULL   
      CALL sadzp140_search_fieldId_tabIndex_max(p_domNode)
      
      #控制權移到下一個同層的節點
      LET p_domNode = p_domNode.getNext()   
   END WHILE
   
END FUNCTION

#+ 載入樣板檔
PRIVATE FUNCTION adzp140_load_4fd_template()
   DEFINE ls_4fd_file STRING 

   #com/lng/mdl
   LET ls_4fd_file = os.Path.join(os.Path.join(FGL_GETENV("COM"),"lng"),"mdl") #檔案路徑
   LET ls_4fd_file = os.Path.join(ls_4fd_file, "ntab_template.4fd")   
   IF NOT os.Path.exists(ls_4fd_file) THEN
      DISPLAY "Error:lng--畫面樣板檔:", ls_4fd_file.trim(), " 不存在!"
      EXIT PROGRAM 
   END IF
   
   RETURN ls_4fd_file
END FUNCTION  


#+ 在n_xxx  
PRIVATE FUNCTION sadzp140_add_field(p_sr_child, p_table_node,p_sr_undefine_child,p_master_node)  
   DEFINE p_sr_child          om.DomNode         #screen record的節點domNode
   DEFINE p_table_node        om.DomNode         #table的節點domNode
   DEFINE p_sr_undefine_child om.DomNode         #screen record undefine的節點domNode 
   DEFINE p_master_node       om.DomNode         #master 單頭
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE r_str               STRING
   DEFINE ls_tmp              STRING 
   DEFINE li_index            LIKE type_t.num5
   DEFINE l_posX              LIKE type_t.num10     #目前元件X軸位置
   DEFINE l_posY              LIKE type_t.num10     #目前元件Y軸位置

   LET l_cnt = g_table_info.getLength()
   LET r_str = ""
   
   #單頭欄位組合
   LET l_posX = 1 #固定 每一個起始元件 (1,0)
   FOR l_i = 1 TO l_cnt
       IF g_table_info[l_i].field_pk = "Y" AND NOT g_table_info[l_i].field_lang 
          AND NOT g_table_info[l_i].field_ent THEN  
           LET g_fieldId_max = g_fieldId_max + 1
           LET g_tabIndex_max = g_tabIndex_max + 1
           LET li_index = li_index + 1
           CALL sadzp140_add_sr_field(p_sr_undefine_child, l_i)

           #計算元件排列位置 元件位置由上而下 由左到右
           #2016/02/03 -start
           #每行放三個元件，超過重新計算
           CASE li_index MOD 3 
              WHEN 1
                 IF li_index > 1 THEN 
                    #元件位置 = g_posX + 10(寬度)  + 1(空格)
                    LET l_posX = l_posX + 10  + 1 # 換另一排開始的起點
                 END IF 
                 LET l_posY = 0 
              WHEN 2
                 LET l_posY = l_posY + 1
              #WHEN 3
              #   LET l_posY = l_posY + 1
              WHEN 0 
                 LET l_posY = l_posY + 1
               #元件位置 = g_posX + 10(寬度)  + 1(空格)
               #LET l_posX = l_posX + 10  + 1 # 換另一排開始的起點 
               #LET l_posY = 0 
           END CASE 
           IF g_t100debug = "9" THEN
              DISPLAY " posX :",l_posX ," posY:",l_posY ," index ",li_index ," field_id ",g_table_info[l_i].field_id
           END IF 
           #2016/02/03 -end
           CALL adzp140_add_grid_field(p_master_node, l_i,l_posX,l_posY,li_index) RETURNING l_posX
           IF li_index < 3 THEN
              #LET g_posY = g_posY + 1 #元件高度
              LET g_grid_height = g_grid_height + 1 
           END IF
              #查t100debug
    
       END IF 

   END FOR 
   

   CALL sadzp140_container_resize(p_master_node)  #單頭重新排列

   LET g_posX = 0
   LET g_posY = 0
   LET g_grid_height = 0 
   LET g_grid_width = 0

   #單身欄位組合 
   FOR l_i = 1 TO l_cnt
      #因為要新增加開窗欄位,所以fieldId和tabIndex都要依續加1,都要是畫面的唯一值
      #LET l_datatype =  "" #可以不用 datatype r.f 會自動賦予

      LET ls_tmp = ""
      #單身
      IF g_table_info[l_i].field_pk = "Y" AND g_table_info[l_i].field_lang THEN 
         LET g_fieldId_max = g_fieldId_max + 1
         LET g_tabIndex_max = g_tabIndex_max + 1 
         CALL sadzp140_add_sr_field(p_sr_child, l_i)
         CALL sadzp140_add_table_field(p_table_node, l_i)
         
      ELSE # 外層IF
         IF NOT g_table_info[l_i].field_ent  THEN 
            IF g_table_info[l_i].field_pk != "Y" THEN  #排除 PK 

               LET ls_tmp = g_table_info[l_i].field_id
               LET ls_tmp = DOWNSHIFT(ls_tmp)

             CASE 
                WHEN ls_tmp.getIndexOf("modid",1) OR ls_tmp.getIndexOf("ownid",1) OR ls_tmp.getIndexOf("owndp",1)
                  OR ls_tmp.getIndexOf("crtid",1) OR ls_tmp.getIndexOf("crtdp",1) OR ls_tmp.getIndexOf("moddt",1) 
                  OR ls_tmp.getIndexOf("crtdt",1)

                  LET g_fieldId_max = g_fieldId_max + 1
                  LET g_tabIndex_max = g_tabIndex_max + 1
                  CALL sadzp140_add_sr_field(p_sr_child, l_i)                
                  CALL sadzp140_add_table_field( p_table_node, l_i)
                  LET g_fieldId_max = g_fieldId_max + 1
                  LET g_tabIndex_max = g_tabIndex_max + 1

                  CALL sadzp140_add_sr_common_desc_field(p_sr_child,ls_tmp)
                  CALL sadzp140_add_table_common_desc_field(p_table_node,ls_tmp) 
                                      
               OTHERWISE 
                  LET g_fieldId_max = g_fieldId_max + 1
                  LET g_tabIndex_max = g_tabIndex_max + 1 
                  CALL sadzp140_add_sr_field(p_sr_child, l_i)              
                  CALL sadzp140_add_table_field(p_table_node, l_i)  
                    
            END CASE 
            END IF 
          END IF 
       END IF #外層if
   END FOR

   #因為在table增加了開窗所需的欄位,而4fd限制容器寬度必須大於table的總寬度
   #所以重新調整Table和VBox等相關容器的寬度,避免編譯失敗
   #table容器的寬度 = 已用寬度 + 欄位個數 + 2
   #g_grid_width=(使用寬度) +g_field_num(表格內欄位的個數) + 2
   LET g_grid_width = g_grid_width + g_field_num + 2  
   CALL p_table_node.setAttribute("gridWidth", g_grid_width)
   LET l_posX = p_table_node.getAttribute("posX") 
   LET g_grid_width = g_grid_width + l_posX
   CALL sadzp140_container_resize(p_table_node)#單身重新排列
   
END FUNCTION

#+ table中欄位設定 4fd 單身 
PRIVATE FUNCTION sadzp140_add_table_field(p_table_node, p_index)  
   DEFINE p_table_node   om.DomNode          #table的節點domNode
   DEFINE p_index        LIKE type_t.num10   #目前新增欄位的index
   DEFINE l_name         STRING              #欄位tag name
   DEFINE p_table_child  om.DomNode
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_dzej003 LIKE dzej_t.dzej003
   DEFINE l_sql  STRING 
   DEFINE ls_tmp  STRING 

   
   #預設table元件內的長,寬 預設
   LET l_grid_height = 1
   LET l_grid_width = 10 
   LET ls_tmp = g_table_info[p_index].field_id
   
   #欄位tag name命名(4fd上的object name)
   LET l_name = g_table_id.trim(), ".", g_table_info[p_index].field_id CLIPPED
   
   #取得widget

   #共用欄位
   CASE 
      WHEN ls_tmp.getIndexOf("modid",1) OR ls_tmp.getIndexOf("ownid",1) OR ls_tmp.getIndexOf("owndp",1)
         OR ls_tmp.getIndexOf("crtid",1) OR ls_tmp.getIndexOf("crtdp",1) 

         LET ls_tmp =  adzp140_add_common_field(ls_tmp,"1")     
      WHEN ls_tmp.getIndexOf("crtdt",1) OR ls_tmp.getIndexOf("moddt",1)   
         LET l_dzej003 = "DateEdit" 
         LET ls_tmp =  adzp140_add_common_field(ls_tmp,"1")
      OTHERWISE  
         LET l_sql = "SELECT dzej003  FROM dzej_t ", 
                     " WHERE dzej001 = 'GENERO_WIDGETS' ",
                     " AND dzej002 = '",g_table_info[p_index].widge_code,"'"  
  
         PREPARE adzp140_pre_widget_info FROM l_sql
         EXECUTE adzp140_pre_widget_info INTO l_dzej003 
         FREE adzp140_pre_widget_info
   END CASE    
   
   IF cl_null(l_dzej003) THEN 
      LET l_dzej003 = "Edit" #dzeb_t.dzep010 是NUll的話  
   END IF  

   IF g_table_info[p_index].field_lang THEN #是語言別
      LET l_dzej003 = "ComboBox"
   END IF 

   LET p_table_child =  p_table_node.createChild(l_dzej003)
   
   CALL p_table_child.setAttribute("aggregateColName", "")
   CALL p_table_child.setAttribute("aggregateName", "")
   CALL p_table_child.setAttribute("aggregateTableAliasName", "")
   CALL p_table_child.setAttribute("aggregateTableName", "")
   CALL p_table_child.setAttribute("colName", g_table_info[p_index].field_id CLIPPED)
   CALL p_table_child.setAttribute("columnCount", "")
   CALL p_table_child.setAttribute("fieldId", g_fieldId_max) 
   CALL p_table_child.setAttribute("fieldType", "TABLE_COLUMN") 
   CALL p_table_child.setAttribute("gridHeight", l_grid_height)  
   CALL p_table_child.setAttribute("gridWidth", l_grid_width)  
   CALL p_table_child.setAttribute("name", l_name)
   #IF g_table_info[p_index].g_field_lang THEN 
   CALL p_table_child.setAttribute("noEntry", "false")
   #ELSE 
   #   CALL p_table_child.setAttribute("noEntry", "true")
   #END IF    
   CALL p_table_child.setAttribute("posX", g_posX)
   CALL p_table_child.setAttribute("posY", g_posY)
   #CALL p_table_child.setAttribute("scroll", "true")
   CALL p_table_child.setAttribute("rowCount", "")
   CALL p_table_child.setAttribute("sqlTabName", g_table_id)
   #CALL p_table_child.setAttribute("sqlType", "")
   CALL p_table_child.setAttribute("stepX", "")
   CALL p_table_child.setAttribute("stepY", "")
   CALL p_table_child.setAttribute("tabIndex", g_tabIndex_max)
   CALL p_table_child.setAttribute("table_alias_name", "")
   CALL p_table_child.setAttribute("title", "lbl_" || ls_tmp CLIPPED)
   CALL p_table_child.setAttribute("hidden", "")
   CALL p_table_child.setAttribute("style", "")
   CALL p_table_child.setAttribute("widget", l_dzej003)

   CALL adzp140_add_widget_code_attr(p_table_child, p_index) #單身

   #後續加入的元件 posX 位置,將隨此元件的寬度增加
   LET g_posX = g_posX + l_grid_width
   LET g_posY = 0
   LET g_field_num = g_field_num + 1 #計算表格內欄位的個數
   LET g_grid_width = g_grid_width + l_grid_width  #table 使用寬度
   LET g_grid_height = l_grid_height

END FUNCTION


#+ table共用欄位 4fd 單身 xxx_desc
PRIVATE FUNCTION sadzp140_add_table_common_desc_field(p_table_node, ps_tmp)  
   DEFINE p_table_node   om.DomNode          #table的節點domNode
   DEFINE p_table_child  om.DomNode
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_dzej003 LIKE dzej_t.dzej003
   DEFINE ps_tmp STRING 
   
   #預設table元件內的長,寬
   LET l_grid_height = 1
   LET l_grid_width = 10
   
   #取得widget
   LET ps_tmp =  adzp140_add_common_field(ps_tmp,"2")

   IF cl_null(ps_tmp) THEN 
      RETURN 
   END IF 
   LET l_dzej003 = "FFLabel"
   LET p_table_child =  p_table_node.createChild(l_dzej003)
   
   CALL p_table_child.setAttribute("aggregateColName", "")
   CALL p_table_child.setAttribute("aggregateName", "")
   CALL p_table_child.setAttribute("aggregateTableAliasName", "")
   CALL p_table_child.setAttribute("aggregateTableName", "")
   CALL p_table_child.setAttribute("colName", ps_tmp CLIPPED)
   CALL p_table_child.setAttribute("columnCount", "")
   CALL p_table_child.setAttribute("fieldId", g_fieldId_max) 
   CALL p_table_child.setAttribute("fieldType", "NON_DATABASE") 
   CALL p_table_child.setAttribute("gridHeight", l_grid_height)  
   CALL p_table_child.setAttribute("gridWidth", l_grid_width)  
   CALL p_table_child.setAttribute("name", ps_tmp)
   #CALL p_table_child.setAttribute("noEntry", "true")
   CALL p_table_child.setAttribute("posX", g_posX)
   CALL p_table_child.setAttribute("posY", g_posY)
   CALL p_table_child.setAttribute("rowCount", "")
   CALL p_table_child.setAttribute("sqlTabName", g_table_id)
   #CALL p_table_child.setAttribute("sqlType", "")
   CALL p_table_child.setAttribute("stepX", "")
   CALL p_table_child.setAttribute("stepY", "")
   #CALL p_table_child.setAttribute("tabIndex", g_tabIndex_max)
   CALL p_table_child.setAttribute("table_alias_name", "")
   CALL p_table_child.setAttribute("title", ps_tmp CLIPPED)
   CALL p_table_child.setAttribute("hidden", "")
   #CALL p_table_child.setAttribute("style", "")
   CALL p_table_child.setAttribute("widget", l_dzej003)

   #CALL adzp140_add_widget_code_attr(p_table_child, p_index) 
   #後續加入的元件 posX 位置,將隨此元件的寬度增加
   LET g_posX = g_posX + l_grid_width
   LET g_posY = 0
   LET g_field_num = g_field_num + 1 #計算表格內欄位的個數
   LET g_grid_width = g_grid_width + l_grid_width
   LET g_grid_height = l_grid_height
END FUNCTION


#+加入widget 屬性
PRIVATE FUNCTION adzp140_add_widget_code_attr(p_table_child, p_index)
   DEFINE p_table_child   om.DomNode          #table的節點domNode
   DEFINE p_table        STRING              #欄位隸屬資料表名稱
   DEFINE p_index        LIKE type_t.num10   #目前新增欄位的index
   DEFINE l_col_name     STRING                #控件欄位名稱
   DEFINE ls_widget_code STRING  
   DEFINE l_parent_node  om.DomNode            #父節點node
   DEFINE ls_tmp STRING 
   #取得父節點
   LET l_parent_node = p_table_child.getParent()
   #取得欄位名稱
   LET l_col_name = p_table_child.getAttribute("colName")
   CALL p_table_child.setAttribute("comment", "cmt_" || l_col_name.trim())
   #LET ls_widget_code = g_table_info[p_index].g_widge_code  
   LET ls_tmp = g_table_info[p_index].widge_code 
   CASE ls_tmp
      WHEN "01"        #"ButtonEdit"
         CALL p_table_child.setAttribute("scroll", "true")
         CALL p_table_child.setAttribute("image", "16/openwindow.png")
         CALL p_table_child.setAttribute("action", "controlp")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "02"        #"CheckBox"
         CALL p_table_child.setAttribute("valueChecked", "Y")
         CALL p_table_child.setAttribute("valueUnchecked", "N")
         CALL p_table_child.setAttribute("sizePolicy", "dynamic")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "false")
         CALL p_table_child.setAttribute("lstrtext", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")

         #IF NOT (l_parent_node.getTagName() = "Table" OR l_parent_node.getTagName() = "Tree") THEN
         IF NOT (l_parent_node.getTagName() = "Table" ) THEN
            CALL p_table_child.setAttribute("text", "lbl_" || l_col_name.trim())
         END IF
         
      WHEN "03"        #"ComboBox"
         CALL p_table_child.setAttribute("scroll", "true")
         CALL p_table_child.setAttribute("sizePolicy", "dynamic")
         CALL p_table_child.setAttribute("queryEditable", "true")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
         #建立items子項目
         #T6 CALL adzp140_set_items_attr(p_table_child)
         
      WHEN "04"        #"DateEdit"     
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "05"        #"Edit"
         CALL p_table_child.setAttribute("scroll", "true")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")

         #Table元件內補aggregate相關屬性
         IF l_parent_node.getTagName() = "Table" THEN
            CALL p_table_child.setAttribute("aggregate", "")
            CALL p_table_child.setAttribute("aggregateName", "")
            CALL p_table_child.setAttribute("aggregateText", "")
            CALL p_table_child.setAttribute("aggregateType", "sum")
            CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         END IF

      WHEN "06"        #FFImage
         CALL p_table_child.setAttribute("comment", "cmt_img_" || l_col_name.trim())
         CALL p_table_child.setAttribute("widthUnit", "pixels")
         CALL p_table_child.setAttribute("heightUnit", "pixels")
         CALL p_table_child.setAttribute("autoScale", "true")
         CALL p_table_child.setAttribute("justify", "center")
         CALL p_table_child.setAttribute("stretch", "none")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "07"        #FFLabel
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "08"        #ProgressBar
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "09"        #"RadioGroup"
         CALL p_table_child.setAttribute("orientation", "horizontal")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")

         #建立items子項目 
         #T6 CALL adzp140_set_items_attr(p_table_child)
         
      WHEN "10"        #Slider
         CALL p_table_child.setAttribute("step", "1")
         CALL p_table_child.setAttribute("sliderOrientation", "horizontal")
         CALL p_table_child.setAttribute("valueMin", "0")
         CALL p_table_child.setAttribute("valueMax", "5")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "11"        #SpinEdit
         CALL p_table_child.setAttribute("scroll", "true")
         CALL p_table_child.setAttribute("step", "1")
         CALL p_table_child.setAttribute("valueMin", "0")
         CALL p_table_child.setAttribute("valueMax", "100")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
          
      WHEN "12"        #"TextEdit"
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "13"        #"TimeEdit"
         CALL p_table_child.setAttribute("scroll", "true")
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "14"        #Field
         CALL p_table_child.setAttribute("lstrcomment", "true")
         CALL p_table_child.setAttribute("lstrtitle", "true")
         CALL p_table_child.setAttribute("lstrAggregatetext", "true")
         
      WHEN "15"        #WebComponent
         CALL p_table_child.setAttribute("lstrcomment", "true")
         
      OTHERWISE
   END CASE
END FUNCTION 


#+ 在 n_xxx開窗screen record中加入相關開窗欄位設定
PRIVATE FUNCTION sadzp140_add_sr_field(p_sr_node, p_index)  
   DEFINE p_sr_node      om.DomNode          #screen record的節點domNode
   DEFINE p_index        LIKE type_t.num10   #目前新增欄位的index
   DEFINE l_name         STRING              #欄位tag name
   DEFINE l_sr_child     om.DomNode
   
   #欄位tag name命名(4fd上的object name)
   LET l_name = g_table_id.trim(), ".", g_table_info[p_index].field_id CLIPPED
   
   LET l_sr_child = p_sr_node.createChild("RecordField")
   CALL l_sr_child.setAttribute("colName", g_table_info[p_index].field_id CLIPPED)
   CALL l_sr_child.setAttribute("fieldIdRef", g_fieldId_max) 
   CALL l_sr_child.setAttribute("fieldType", "TABLE_COLUMN")   #目前設定為TABLE_COLUMN
   CALL l_sr_child.setAttribute("name", l_name)
   CALL l_sr_child.setAttribute("sqlTabName", g_table_id)
   #CALL l_sr_child.setAttribute("sqlType", "")
   CALL l_sr_child.setAttribute("table_alias_name", "")
END FUNCTION


#+ 在 n_xxx開窗screen record中加入 xxx_desc
PRIVATE FUNCTION sadzp140_add_sr_common_desc_field(p_sr_node, ps_tmp)  
   DEFINE p_sr_node      om.DomNode          #screen record的節點domNode
   DEFINE l_sr_child     om.DomNode
   DEFINE ps_tmp         STRING 
   
   LET ps_tmp =  adzp140_add_common_field(ps_tmp,"2")
   IF cl_null(ps_tmp) THEN 
      RETURN 
   END IF
   LET l_sr_child = p_sr_node.createChild("RecordField")
   CALL l_sr_child.setAttribute("colName", ps_tmp CLIPPED)
   CALL l_sr_child.setAttribute("fieldIdRef", g_fieldId_max) 
   CALL l_sr_child.setAttribute("fieldType", "NON_DATABASE")   #目前設定為TABLE_COLUMN
   CALL l_sr_child.setAttribute("name", ps_tmp)
   CALL l_sr_child.setAttribute("sqlTabName", "NON_DATABASE")
   #CALL l_sr_child.setAttribute("sqlType", "")
   CALL l_sr_child.setAttribute("table_alias_name", "")
END FUNCTION


#+共用欄位處理
PRIVATE FUNCTION adzp140_add_common_field(ps_tmp,ps_type)
   DEFINE li_i           LIKE type_t.num5 
   DEFINE ps_tmp         STRING 
   DEFINE ps_type        LIKE type_t.chr1 #1:組lbl_xxx    2:組 xxx_desc  
   
   LET ps_tmp = DOWNSHIFT(ps_tmp)

   CASE  
      WHEN ps_tmp.getIndexOf("modid",1) 
         LET li_i = ps_tmp.getIndexOf("modid",1) 
      WHEN ps_tmp.getIndexOf("ownid",1) 
         LET li_i = ps_tmp.getIndexOf("ownid",1) 
      WHEN ps_tmp.getIndexOf("owndp",1) 
         LET li_i = ps_tmp.getIndexOf("owndp",1) 
      WHEN ps_tmp.getIndexOf("crtid",1) 
         LET li_i = ps_tmp.getIndexOf("crtid",1) 
      WHEN ps_tmp.getIndexOf("crtdp",1) 
         LET li_i = ps_tmp.getIndexOf("crtdp",1) 
      WHEN ps_tmp.getIndexOf("moddt",1)   
         IF ps_type == "2" THEN 
            RETURN ""
         END IF 
         LET li_i = ps_tmp.getIndexOf("moddt",1)  
         #RETURN ""
      WHEN ps_tmp.getIndexOf("crtdt",1) 
         IF ps_type == "2" THEN 
            RETURN ""
         END IF 
         LET li_i = ps_tmp.getIndexOf("crtdt",1)  

   END CASE 

   IF ps_type == "1" THEN 
      LET ps_tmp = ps_tmp.subString(li_i,ps_tmp.getLength()) 
   ELSE 
      LET ps_tmp = ps_tmp.subString(li_i,ps_tmp.getLength()) ||"_desc"
   END IF 
      
   RETURN ps_tmp
END FUNCTION 


#+重新排列容器
PRIVATE FUNCTION sadzp140_container_resize(p_node)
   DEFINE p_node            om.DomNode            #table的節點domNode
   #DEFINE p_width           LIKE type_t.num10     #此次要設定的容器大小
   DEFINE l_width            LIKE type_t.num10
   #DEFINE p_height          LIKE type_t.num10     #此次要設定的容器大小
   DEFINE l_height          LIKE type_t.num10
   DEFINE l_width_source    LIKE type_t.num10     #容器原始大小
   DEFINE l_height_source   LIKE type_t.num10     #容器原始大小
   DEFINE l_grid_width      LIKE type_t.num10     #子容器寬度
   DEFINE l_child           om.DomNode 
   DEFINE l_posX            LIKE type_t.num10
   DEFINE l_grid_height     LIKE type_t.num10     #子容器寬度
   DEFINE l_posY            LIKE type_t.num10
   
   LET p_node = p_node.getParent() #父節點
   LET l_width_source = 0
   LET l_height_source = 0
   LET l_grid_width = 0
   LET l_posX = 0
   LET l_grid_height = 0
   LET l_posY = 0

   LET l_width = g_grid_width    #寬度

   #table 寬度 < grid 寬度
   IF g_grid_width < g_grid_width2 THEN 
      LET l_width = g_grid_width2    #寬度  

   END IF 
   LET l_height = g_grid_height  #高度
 
   #ManagedForm:表示已達到XML Document頂端
   IF p_node.getTagName() = "ManagedForm" THEN
      RETURN
   END IF
      
   IF (NOT cl_null(p_node.getAttribute("gridWidth"))) AND (NOT cl_null(p_node.getAttribute("gridHeight"))) THEN
      LET l_width_source = p_node.getAttribute("gridWidth")
      LET l_height_source = p_node.getAttribute("gridHeight")
      CASE p_node.getTagName()
         WHEN "VBox"
            LET l_width = l_width

            IF p_node.getChildCount() > 1 THEN
               LET l_child = p_node.getFirstChild()
               LET l_posY = l_child.getAttribute("posY")   #取得第一個子元件的Y軸
               WHILE l_child IS NOT NULL
                  #每個子元件需跟著變更X軸位置
                  IF (NOT cl_null(l_posY)) AND (NOT cl_null(l_child.getAttribute("posY"))) AND l_child.getAttribute("posY") < l_posY THEN
                     CALL l_child.setAttribute("posY", l_posY)
                  END IF

                  IF (NOT cl_null(l_child.getAttribute("gridWidth"))) AND l_child.getAttribute("gridWidth") < l_width THEN
                     CALL l_child.setAttribute("gridWidth", l_width)
                  END IF

                  #計算下一個子元件的Y軸位置, exp:下一個元件Y軸位置 = 元件目前Y軸位置 + 元件高度
                  LET l_grid_height = l_child.getAttribute("gridHeight")
                  LET l_posY = l_posY + l_grid_height

                  LET l_child = l_child.getNext()
               END WHILE
               LET l_height = l_posY + 4
            ELSE
               LET l_height = l_height + 4
            END IF

         WHEN "Folder"
            LET l_width = l_width + 2
            LET l_height = l_height + 2
               
         WHEN "HBox"
            IF p_node.getChildCount() > 1 THEN
               LET l_child = p_node.getFirstChild()
               LET l_posX = l_child.getAttribute("posX")   #取得第一個子元件的X軸
               WHILE l_child IS NOT NULL
                  #每個子元件需跟著變更X軸位置
                  IF (NOT cl_null(l_posX)) AND (NOT cl_null(l_child.getAttribute("posX"))) AND l_child.getAttribute("posX") < l_posX THEN
                     CALL l_child.setAttribute("posX", l_posX)
                  END IF

                  IF (NOT cl_null(l_child.getAttribute("gridHeight"))) AND l_child.getAttribute("gridHeight") < l_height THEN
                     CALL l_child.setAttribute("gridHeight", l_height)
                  END IF

                  #計算下一個子元件的X軸位置, exp:下一個元件X軸位置 = 元件目前X軸位置 + 元件寬度
                  LET l_grid_width = l_child.getAttribute("gridWidth")
                  LET l_posX = l_posX + l_grid_width

                  LET l_child = l_child.getNext()
               END WHILE
               LET l_width = l_posX + 4
            ELSE
               LET l_width = l_width + 4
            END IF

         WHEN "Form"
            LET l_child = p_node.getFirstChild()
            LET l_posX = l_child.getAttribute("posX")   #取得第一個子元件的X軸
            WHILE l_child IS NOT NULL
               ##每個子元件需跟著變更X軸位置
               #IF l_posX IS NOT NULL AND l_child.getAttribute("posX") IS NOT NULL AND l_child.getAttribute("posX") < l_posX THEN
               #   CALL l_child.setAttribute("posX", l_posX)
               #END IF

               #IF l_child.getAttribute("gridHeight") IS NOT NULL AND l_child.getAttribute("gridHeight") < p_height THEN
               #   CALL l_child.setAttribute("gridHeight", p_height)
               #END IF

               #計算下一個子元件的X軸位置, exp:下一個元件X軸位置 = 元件目前X軸位置 + 元件寬度
               LET l_grid_width = l_child.getAttribute("gridWidth")
               LET l_posX = l_posX + l_grid_width
                  
               LET l_child = l_child.getNext()
            END WHILE
            LET l_width = l_posX + 2
            LET l_height = l_height + 2
      END CASE

      #如果父節點container的原始寬度小於要設置的寬度,則設定新的最大寬度
      IF l_width_source < l_width THEN
         CALL p_node.setAttribute("gridWidth", l_width)
      END IF

      #如果父節點container的原始高度小於要設置的高度,則設定新的最大高度
      IF l_height_source < l_height THEN
         CALL p_node.setAttribute("gridHeight", l_height)
      END IF
   END IF

   LET g_grid_width = l_width
   LET g_grid_height = l_height

   CALL sadzp140_container_resize(p_node)
END FUNCTION


#+元件加入Grid 4fd 單頭部分 (增加Label、增加Edit)
PRIVATE FUNCTION adzp140_add_grid_field(p_master_node,p_i,p_posX,p_posY,pi_index)  
   DEFINE p_master_node      om.DomNode
   DEFINE l_master_child     om.DomNode
   DEFINE p_i                LIKE type_t.num5
   DEFINE pi_index           LIKE type_t.num5
   DEFINE l_name STRING 
   DEFINE p_posX             LIKE type_t.num10     #下一個欄位元件X軸位置
   DEFINE p_posY             LIKE type_t.num10     #下一個欄位元件Y軸位置
   DEFINE l_posX_src         LIKE type_t.num10     #下一個欄位元件X軸位置
   #DEFINE l_posY              LIKE type_t.num10     #下一個欄位元件Y軸位置
   #DEFINE l_posX_start        LIKE type_t.num10     #每一排元件X軸啟始位置
   #DEFINE l_posY_start        LIKE type_t.num10     #每一排元件Y軸啟始位置
   DEFINE l_grid_height      LIKE type_t.num10
   DEFINE l_grid_width       LIKE type_t.num10
   
   #一開始位置從 (1,0) 
   
   #一開始 元件寬度及高度 
   LET l_grid_width = 10
   LET l_grid_height = 1 
   LET l_posX_src = p_posX
   #增加Label(敘述)
   LET l_name = g_table_id.trim(), ".", g_table_info[p_i].field_id CLIPPED
   LET l_master_child = p_master_node.createChild("Label")
   CALL l_master_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_master_child.setAttribute("gridWidth", l_grid_width)
   CALL l_master_child.setAttribute("name", "lbl_" || g_table_info[p_i].field_id CLIPPED)
   CALL l_master_child.setAttribute("posX", p_posX)
   CALL l_master_child.setAttribute("posY", p_posY)
   CALL l_master_child.setAttribute("text", "lbl_" || g_table_info[p_i].field_id CLIPPED)
   CALL l_master_child.setAttribute("lstrcomment", "true")
   LET p_posX = p_posX + l_grid_width + 1  #下一個欄位點的X軸位置 (X軸+寬度+空格)

   #處理欄位
   LET l_master_child = p_master_node.createChild("Edit")
   
   CALL l_master_child.setAttribute("aggregateColName", "")
   CALL l_master_child.setAttribute("aggregateName", "")
   CALL l_master_child.setAttribute("aggregateTableAliasName", "")
   CALL l_master_child.setAttribute("aggregateTableName", "")
   CALL l_master_child.setAttribute("colName", g_table_info[p_i].field_id CLIPPED)
   CALL l_master_child.setAttribute("columnCount", "")
   CALL l_master_child.setAttribute("fieldId", g_fieldId_max) 
   CALL l_master_child.setAttribute("fieldType", "TABLE_COLUMN") 
   CALL l_master_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_master_child.setAttribute("gridWidth", l_grid_width)  
   CALL l_master_child.setAttribute("name", l_name)
   CALL l_master_child.setAttribute("noEntry", "true") #pk  
   CALL l_master_child.setAttribute("posX", p_posX)
   CALL l_master_child.setAttribute("posY", p_posY)
   CALL l_master_child.setAttribute("rowCount", "")
   CALL l_master_child.setAttribute("sqlTabName", g_table_id)
   #CALL p_table_child.setAttribute("sqlType", "")
   CALL l_master_child.setAttribute("stepX", "")
   CALL l_master_child.setAttribute("stepY", "")
   CALL l_master_child.setAttribute("tabIndex", g_tabIndex_max)
   CALL l_master_child.setAttribute("table_alias_name", "")
   #CALL l_master_child.setAttribute("title", "lbl_" || g_table_info[p_i].g_field_id CLIPPED) #先暫時註解 13/02/04 Edit 沒有title 屬性  
   CALL l_master_child.setAttribute("hidden", "")
   CALL l_master_child.setAttribute("style", "")
   CALL l_master_child.setAttribute("widget", "Edit")

   CALL adzp140_add_widget_code_attr(l_master_child, p_i) #單頭

   LET g_grid_width2 = g_grid_width2 + l_grid_width   #紀錄使用寬度
   #LET g_grid_height = g_grid_height + l_grid_height #紀錄使用高度
   #比較一下同一列的每個widget高度最大己用posY值
   #IF l_posY_max < l_grid_height THEN
   #   LET l_posY_max = l_grid_height
   #END IF

   #2016/02/03 -start
   CASE pi_index MOD 3 
      WHEN 1
         LET p_posX = l_posX_src
      WHEN 2
         LET p_posX = l_posX_src
      WHEN 0 
   END CASE 
   --IF pi_index MOD 4 != 3 THEN
      #LET p_posX = 1
      --LET p_posX = l_posX_src  
   --END IF 
   #2016/02/03 -end
   
   RETURN p_posX
   
END FUNCTION 


#+ 實際生成n_xxx 4fd畫面檔
PRIVATE FUNCTION adzp140_gen_4fd_file() 

   DEFINE ls_code_filename        STRING

   #產出程式路徑
   LET ls_code_filename = os.Path.join(os.Path.join(FGL_GETENV("COM"),"lng"),"4fd")
   
   LET ls_code_filename = os.Path.join(ls_code_filename, gs_code_filename || ".4fd")
   DISPLAY "產生檔位置:", ls_code_filename

   IF NOT os.Path.exists(ls_code_filename) THEN
      #實際在路徑下產出.4fd檔
      CALL gnode_4fd.writeXml(ls_code_filename)
   ELSE
      IF os.Path.delete(ls_code_filename||".bak") THEN END IF
      IF NOT os.Path.rename(ls_code_filename, ls_code_filename||".bak" ) THEN 
         DISPLAY "Error:目的備份檔案:",ls_code_filename.trim(),"不存在!"
      END IF 
      #實際在路徑下產出.4fd檔
      CALL gnode_4fd.writeXml(ls_code_filename)
   END IF
   #160519-00018 #1 mark
   #CALL sadzp140_compile_file("2")
END FUNCTION



