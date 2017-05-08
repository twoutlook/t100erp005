#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1)
#+ 
#+ Filename...: adzq185_01
#+ Description: 憑證報表樣板比對相關作業
#+ Creator....: 04010(2016-11-21 09:46:52)
#+ Modifier...: 04010(2016-11-21 09:46:52)
# Usage .........: 
# Return code....: none
#+ Modifier...: No.161130-00066#1 16/11/30 Cynthia  提供報表樣板merge功能

IMPORT os
DATABASE ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/adzq185_module.inc"

DEFINE g_chk_err_msg        STRING   #檢查報表命名規則的錯誤訊息
DEFINE g_strong_err         INTEGER  #強制錯誤訊息數


#讀出4rp中的資料欄位
FUNCTION sadzq185_01_readnodes(p_field,p_node,p_tagname,p_lang,p_gzgd000,p_code,p_loc)
    DEFINE p_field      DYNAMIC ARRAY OF type_g_field
    DEFINE p_node       om.DomNode
    DEFINE p_tagname    STRING
    DEFINE p_lang       LIKE gzzy_t.gzzy001
    DEFINE p_gzgd000    LIKE gzgd_t.gzgd000
    DEFINE p_code       LIKE type_t.chr1
    DEFINE p_loc        LIKE type_t.chr10
    DEFINE l_nodes      om.NodeList
    DEFINE l_i          LIKE type_t.num10
    DEFINE l_j          LIKE type_t.num10
    DEFINE l_curnode    om.DomNode
    DEFINE l_parent     om.DomNode
    DEFINE l_nodename   STRING
    DEFINE l_colname    STRING
    DEFINE l_tagtype    LIKE type_t.chr1
    DEFINE l_index      LIKE type_t.num10
    DEFINE l_exist      LIKE type_t.num5
    DEFINE l_node2      om.DomNode 
    DEFINE l_k          LIKE type_t.num10
    DEFINE l_node3      om.DomNode
    DEFINE l_cmpname    STRING
    DEFINE l_err_msg    STRING               #錯誤訊息
    DEFINE l_strbuf     base.StringBuffer    #組錯誤訊息的字串緩衝區
    DEFINE l_prev       LIKE type_t.num10    #前一個_Label位置
    DEFINE l_flag       LIKE type_t.num10    #找到成對的_Label與_Value
    DEFINE l_align      STRING 
    DEFINE l_line_seq   LIKE type_t.num5     #行序
    DEFINE l_col_seq    LIKE type_t.num5     #欄位順序

#    CALL p_field.clear()
    LET l_strbuf = base.StringBuffer.create()
    LET l_nodes = p_node.selectByTagName(p_tagname)
    FOR l_i = 1 TO l_nodes.getLength()
        LET l_colname = NULL
        LET l_align = NULL
        LET l_curnode = l_nodes.item(l_i)
        LET l_nodename = l_curnode.getAttribute("name")
        LET l_parent = l_curnode.getParent()

        
        #若為IMAGEBOX物件時，限定名稱為logo_Value才處理
        IF p_tagname = "IMAGEBOX" AND (l_nodename != "logoRH_Value" OR l_nodename != "logoPH_Value")THEN
            CONTINUE FOR
        END IF
  
        IF p_code = '1' THEN #for Value & LValue
           CASE
               WHEN l_nodename.getIndexOf("_Value",1) > 0  #欄位
                   LET l_tagtype = "V"
                   LET l_colname = cl_replace_str(l_nodename,"_Value","")
               WHEN l_nodename.getIndexOf("_LValue",1) > 0  #動態欄位說明
                   LET l_tagtype = "L"
                   LET l_colname = cl_replace_str(l_nodename,"_LValue","")
               WHEN l_nodename.getIndexOf("Dspacer",1)>0
                    LET l_tagtype = "V"
                    LET l_colname =l_nodename
           END CASE
        ELSE
           CASE
               WHEN l_nodename.getIndexOf("_Label",1) > 0  #欄位
                   LET l_tagtype = "L"
                   LET l_colname = cl_replace_str(l_nodename,"_Label","")
               WHEN l_nodename.getIndexOf("DHspacer",1)>0
                    LET l_tagtype = "L"
                    LET l_colname =l_nodename
           END CASE
        END IF
        IF cl_null(l_colname) THEN CONTINUE FOR END IF

        #尋找p_field中是否已有相同欄位名稱的資料
        LET l_index = 0
        LET l_exist = FALSE
        FOR l_j = 1 TO p_field.getLength()
            IF p_field[l_j].gzgg001 = l_colname THEN
                LET l_index = l_j
                LET l_exist = TRUE
                EXIT FOR
            END IF
        END FOR

        #在p_field中未找到,新增一筆
        IF l_index <= 0 THEN
            CALL p_field.appendElement()
            LET l_index = p_field.getLength()
            LET p_field[l_index].seq = l_index

            LET p_field[l_index].agl = "L"    #欄位水平對齊
            LET p_field[l_index].lblagl = "L" #欄位說明水平對齊

            #取欄位名稱
            LET p_field[l_index].gzgg001 = l_colname  #欄位代碼

#            IF p_field[l_index].gzgg001 = "sr1.l_xmev002_ooefl003RH" THEN
#               DISPLAY "test"
#            END IF
            #取欄位屬性
            LET p_field[l_index].gzgg019 = sadzq185_01_session(l_curnode) #欄位類別
#            IF p_field[l_index].gzgg001 = "sr1.l_xmev002_ooefl003RH" THEN
#               DISPLAY "p_field[l_index].gzgg019:",p_field[l_index].gzgg019
#            END IF

            #取行序
            IF p_field[l_index].gzgg019 MATCHES "[123456789]" THEN
                CALL sadzq185_01_getlinecol(l_curnode)
                  RETURNING l_line_seq, l_col_seq
                LET p_field[l_index].gzgg027 = l_line_seq
            END IF

            #取單身欄位順序
            IF p_field[l_index].gzgg019 = "9" THEN
                LET p_field[l_index].gzgg004 = l_col_seq
            END IF

            #設定折行否
            IF l_curnode.getTagName() = "WORDWRAPBOX" THEN
                LET p_field[l_index].l_wrap = "Y"
            ELSE
                LET p_field[l_index].l_wrap = "N"
            END IF

            #設定隱藏否
            CASE l_curnode.getAttribute("rtl:condition")
                WHEN "Boolean.FALSE" LET p_field[l_index].vc = "Y"
                WHEN "Boolean.TRUE" LET p_field[l_index].vc = "N"
                OTHERWISE LET p_field[l_index].vc = "N"  
            END CASE
             IF l_tagtype="L" THEN 
                LET p_field[l_index].lblvcrtl=l_curnode.getAttribute("rtl:condition")                
             END IF 
             IF l_tagtype="V" THEN 
                LET p_field[l_index].vcrtl=l_curnode.getAttribute("rtl:condition")
             END IF
         END IF 
          
        CASE sadzq185_01_has_label(p_node,p_field[l_index].gzgg001)
            WHEN "Y" LET p_field[l_index].lblbvc = "N"
            WHEN "N" LET p_field[l_index].lblbvc = "Y"
        END CASE

        #取行序跟單身欄位順序
        IF p_field[l_index].gzgg019 MATCHES "[123456789]" THEN
            IF p_field[l_index].gzgg027 IS NULL THEN
               CALL sadzq185_01_getlinecol(l_curnode)
                  RETURNING l_line_seq, l_col_seq
               LET p_field[l_index].gzgg027 = l_line_seq
            END IF
            IF p_field[l_index].gzgg019 = "9" AND p_field[l_index].gzgg004 IS NULL THEN
               LET p_field[l_index].gzgg004 = l_col_seq
            END IF
        END IF

        CASE l_tagtype
            WHEN "L"    #欄位說明
               #單頭需設定定位點
                LET p_field[l_index].posy = l_curnode.getAttribute("y")
                LET p_field[l_index].posx = l_curnode.getAttribute("x")
                LET p_field[l_index].lblwid = l_curnode.getAttribute("width")
                LET p_field[l_index].lblfont = l_curnode.getAttribute("fontName")
                LET p_field[l_index].lblsize = l_curnode.getAttribute("fontSize")
                LET p_field[l_index].lblbold = sadzq185_01_bool2char(l_curnode.getAttribute("fontBold"))
                LET p_field[l_index].lblcolor = l_curnode.getAttribute("color")
                LET p_field[l_index].gzge003 = l_curnode.getAttribute("text")
                LET p_field[l_index].lblvcrtl = l_curnode.getAttribute("rtl:condition")
                
                LET l_align = sadzq185_01_getalign(l_curnode.getAttribute("textAlignment"))   
                IF l_align IS NOT NULL THEN
                    LET p_field[l_index].lblagl = l_align
                END IF
                LET p_field[l_index].lbldraw = p_tagname  
            WHEN "V"    #欄位
                LET p_field[l_index].gzgg005 = l_curnode.getAttribute("width")
                LET p_field[l_index].l_font = l_curnode.getAttribute("fontName")
                LET p_field[l_index].l_size = l_curnode.getAttribute("fontSize")
                LET p_field[l_index].l_bold = sadzq185_01_bool2char(l_curnode.getAttribute("fontBold"))
                LET p_field[l_index].color = l_curnode.getAttribute("color")
                LET p_field[l_index].vcrtl = l_curnode.getAttribute("rtl:condition")
                LET l_align = sadzq185_01_getalign(l_curnode.getAttribute("textAlignment"))   
                IF l_align IS NOT NULL THEN
                    LET p_field[l_index].agl = l_align
                END IF

                IF (p_field[l_index].gzgg019 MATCHES "[12345678910111213]") AND p_field[l_index].lblbvc = "Y" THEN
                    LET p_field[l_index].posx = l_curnode.getAttribute("x")
                    LET p_field[l_index].posy = l_curnode.getAttribute("y")
                END IF
                LET p_field[l_index].draw = p_tagname
        END CASE

        IF p_field[l_index].l_bold IS NULL THEN
            LET p_field[l_index].l_bold = "N"
        END IF

        IF p_field[l_index].lblbold IS NULL THEN
            LET p_field[l_index].lblbold = "N"
        END IF

        #檢查命名規則
        CASE 
            WHEN p_field[l_index].gzgg019 MATCHES "[12345678]"
                IF l_nodename.getIndexOf("_Label",1) <= 0 AND
                    l_nodename.getIndexOf("_Value",1) <= 0
                THEN
                    LET l_err_msg = cl_getmsg_parm("azz1192", g_lang, l_nodename)
                    IF l_err_msg IS NOT NULL THEN
                        CALL l_strbuf.append(l_err_msg)
                        CALL l_strbuf.append("\r\n")
                    END IF
                END IF

                #檢查單身欄位說明與欄位值是否相連
                IF l_nodename.getIndexOf("_Value",1) >= 1 THEN
                    LET l_prev = 0
                    LET l_flag = FALSE
                    FOR l_j = 1 TO l_parent.getChildCount()
                        LET l_node2 = l_parent.getChildByIndex(l_j)
                        IF l_node2 = l_curnode THEN
                            FOR l_k = l_j - 1 TO 1 STEP -1
                                LET l_node3 = l_parent.getChildByIndex(l_k)
                                IF l_node3.getTagName() = "WORDBOX" OR l_node3.getTagName() = "WORDWRAPBOX" THEN
                                    LET l_prev = l_prev + 1
                                    LET l_cmpname = l_node3.getAttribute("name")
                                    IF l_cmpname = l_colname||"_Label" THEN
                                        LET l_flag = TRUE
                                        EXIT FOR
                                    END IF
                                END IF
                            END FOR
                        END IF
                    END FOR 
                END IF

                IF l_flag AND l_prev > 1 THEN
                    LET l_err_msg = cl_getmsg_parm("azz1192", g_lang, l_nodename)
                    IF l_err_msg IS NOT NULL THEN
                        CALL l_strbuf.append(l_err_msg)
                        CALL l_strbuf.append("\r\n")
                    END IF
                END IF
            WHEN p_field[l_index].gzgg019 = "9"
                IF l_nodename.getIndexOf("_Label",1) <= 0 AND
                    l_nodename.getIndexOf("_Value",1) <= 0 AND
                    l_nodename.getIndexOf("_LValue",1) <= 0 AND
                    l_nodename.getIndexOf("DHspacer",1) <= 0 AND
                    l_nodename.getIndexOf("Dspacer",1) <= 0 
                THEN
                    LET l_err_msg = cl_getmsg_parm("azz1192", g_lang, l_nodename)
                    IF l_err_msg IS NOT NULL THEN
                        CALL l_strbuf.append(l_err_msg)
                        CALL l_strbuf.append("\r\n")
                    END IF
                END IF
            OTHERWISE
                IF l_nodename.getIndexOf("_Label",1) <= 0 AND
                    l_nodename.getIndexOf("_Value",1) <= 0
                THEN
                    LET l_err_msg = cl_getmsg_parm("azz1192", g_lang, l_nodename)
                    IF l_err_msg IS NOT NULL THEN
                        CALL l_strbuf.append(l_err_msg)
                        CALL l_strbuf.append("\r\n")
                    END IF
                END IF
        END CASE
       IF p_loc = "new" THEN
          LET ga_field_new[l_index].* = p_field[l_index].*
       ELSE
          LET ga_field_old[l_index].* = p_field[l_index].*
       END IF 
    END FOR
    #將錯誤訊息附加到紀錄檢查命名規則錯誤的變數中
    IF l_strbuf.getLength() > 0 THEN
        IF g_chk_err_msg IS NULL THEN
            LET g_chk_err_msg = l_strbuf.toString()
        ELSE
            LET g_chk_err_msg = g_chk_err_msg,l_strbuf.toString()
        END IF
    END IF


END FUNCTION

#取得欄位類別(1:單頭,2:單身,3:其他,4:群組首,5:群組尾)
#1:ReportHeader, 2:RHMasters, 3:RHMasterAs, 4:RHMasterCs
#5:PageHeader, 6:PHMasters, 7:PHMasterAs, 8:PHMasterCs
#9:Details, 10:RHDetailHeaders, 11:PHDetailHeaders, 12:PageFooters
#13:ReportFooters, 14:GroupFooters, 15:其他
FUNCTION sadzq185_01_session(p_node)
   DEFINE p_node        om.DomNode
   DEFINE l_parent      om.DomNode
   DEFINE l_res         STRING
   DEFINE l_name        STRING
   DEFINE l_parname     STRING
   DEFINE la_parents    DYNAMIC ARRAY OF om.DomNode   #父節點
   
   LET l_res = "15"

   #找PHDetailHeaders,RHDetailHeaders,Details,RHMasters,PHMasters,RHMasterAs,PHMasterAs,RHMasterCs,PHMasterCs該層區段
   CALL la_parents.clear()
   LET la_parents = sadzq185_01_getparents(p_node)
   IF la_parents.getLength() > 0 THEN
      LET l_parent = la_parents[la_parents.getLength()]
   END IF
   
   #LET l_parent = p_node.getParent()
   LET l_parname = l_parent.getAttribute("name")
   WHILE TRUE
      IF l_parent IS NULL THEN
         EXIT WHILE
      END IF
      
      CASE l_parent.getAttribute("name")
         WHEN "ReportHeader"
            LET l_res = "1"
            EXIT WHILE
         WHEN "RHMasters"
            LET l_res = "2"
            EXIT WHILE
         WHEN "RHMasterAs"
            LET l_res = "3"
            EXIT WHILE
         WHEN "RHMasterCs"
            LET l_res = "4"
            EXIT WHILE
         WHEN "PageHeader"
            LET l_res = "5"
            EXIT WHILE
         WHEN "PHMasters"
            LET l_res = "6"
            EXIT WHILE
         WHEN "PHMasterAs"
            LET l_res = "7"
            EXIT WHILE
         WHEN "PHMasterCs"
            LET l_res = "8"
            EXIT WHILE
         WHEN "Details"
            LET l_res = "9"
            EXIT WHILE
         WHEN "RHDetailHeaders"
            LET l_res = "10"
            EXIT WHILE
         WHEN "RHDetailHeaders"
            LET l_res = "11"
            EXIT WHILE
         WHEN "PHDetailHeaders"
            LET l_res = "12"
            EXIT WHILE
         WHEN "ReportFooters"
            LET l_res = "13"
            EXIT WHILE
         OTHERWISE
            LET l_name = l_parent.getAttribute("name")
            CASE 
               WHEN l_name.getIndexOf("GroupFooters",1) > 0  #群組尾
                  LET l_res = "14"
                  EXIT WHILE           
            END CASE
      END CASE

      LET l_parent = l_parent.getParent()
   END WHILE

   RETURN l_res
END FUNCTION

#取出欄位所在行序及欄位順序
FUNCTION sadzq185_01_getlinecol(p_node)
   DEFINE p_node        om.DomNode
   DEFINE l_parent      om.DomNode
   DEFINE l_seq         LIKE type_t.num5           #累計行序
   DEFINE l_line_seq    LIKE type_t.num5           #行序
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_curnode     om.DomNode
   DEFINE l_curname     STRING
   DEFINE la_parents    DYNAMIC ARRAY OF om.DomNode   #父節點
   DEFINE l_line_idx    LIKE type_t.num5           #行節點位置
   DEFINE l_col_seq     LIKE type_t.num5           #欄位順序
   DEFINE l_col_node    om.DomNode
   
   #找PHDetailHeaders,RHDetailHeaders,Details,RHMasters,PHMasters,RHMasterAs,PHMasterAs,RHMasterCs,PHMasterCs該層區段
   CALL la_parents.clear()
   LET la_parents = sadzq185_01_getparents(p_node)
   IF la_parents.getLength() > 0 THEN
      LET l_parent = la_parents[la_parents.getLength()]
      IF la_parents.getLength() > 1 THEN
         LET l_line_idx = la_parents.getLength() - 1
      END IF
   END IF

   LET l_seq = 0
   LET l_line_seq = 0
   LET l_col_seq = 0

   IF l_parent IS NOT NULL THEN
      #取得行序
      FOR l_i = 1 TO l_parent.getChildCount()
         LET l_curnode = l_parent.getChildByIndex(l_i)
         IF l_curnode.getTagName() = "MINIPAGE" 
            OR l_curnode.getTagName() = "LAYOUTNODE"
         THEN
            LET l_curname = l_curnode.getAttribute("name")
            CASE l_parent.getAttribute("name")
               WHEN "PHDetailHeaders" #單身欄位說明
                  IF l_curname.getIndexOf("PHDetailHeader",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHDetailHeaders" #單身欄位說明
                  IF l_curname.getIndexOf("RHDetailHeader",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "Details"       #單身
                  IF l_curname.getIndexOf("Detail",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHMasters"       #單頭
                  IF l_curname.getIndexOf("RHMaster",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "PHMasters"       #單頭
                  IF l_curname.getIndexOf("PHMaster",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHMasterAs"       #單頭
                  IF l_curname.getIndexOf("RHMasterA",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "PHMasterAs"       #單頭
                  IF l_curname.getIndexOf("PHMasterA",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHMasterCs"       #單頭
                  IF l_curname.getIndexOf("RHMasterC",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "PHMasterCs"       #單頭
                  IF l_curname.getIndexOf("PHMasterC",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
            END CASE

            #找到該行離開迴圈
            IF l_curnode = la_parents[l_line_idx] THEN
               LET l_line_seq = l_seq
               EXIT FOR
            END IF
         END IF
      END FOR

      #單身需取得欄位順序
      IF l_line_seq > 0 AND (l_parent.getAttribute("name") = "PHDetailHeaders" OR l_parent.getAttribute("name") = "RHDetailHeaders" 
         OR l_parent.getAttribute("name") = "Details")
         AND la_parents[l_line_idx] IS NOT NULL
      THEN
         LET l_seq = 0
         FOR l_i = 1 TO la_parents[l_line_idx].getChildCount()
            LET l_col_node = la_parents[l_line_idx].getChildByIndex(l_i)
               IF l_col_node.getTagName() = "WORDBOX"
                  OR l_col_node.getTagName() = "WORDWRAPBOX"
                  OR l_col_node.getTagName() = "DECIMALFORMATBOX"
                  OR l_col_node.getTagName() = "IMAGEBOX"
               THEN
                  LET l_seq = l_seq + 1
                  IF l_col_node = p_node THEN 
                     LET l_col_seq = l_seq
                     EXIT FOR
                  END IF
               END IF
         END FOR
      END IF
   END IF
   
   RETURN l_line_seq,l_col_seq
END FUNCTION

#檢查欄位是否有欄位說明
FUNCTION sadzq185_01_has_label(p_node,p_name)
   DEFINE p_node   om.DomNode
   DEFINE p_name   STRING
   DEFINE l_nodes  om.NodeList
   DEFINE l_len    LIKE type_t.num5
   DEFINE l_str    STRING
   DEFINE l_res    STRING

    LET l_str = "//WORDWRAPBOX[@name=\""||p_name.trim()||"_Label\"]"
    LET l_nodes = p_node.selectByPath(l_str)
    LET l_len = l_nodes.getLength()

    IF l_len <= 0 THEN
        LET l_str = "//WORDBOX[@name=\""||p_name.trim()||"_Label\"]"
        LET l_nodes = p_node.selectByPath(l_str)
        LET l_len = l_nodes.getLength()
    END IF

    IF l_len >= 1 THEN
        LET l_res = "Y"
    ELSE
        LET l_res = "N"
    END IF
    RETURN l_res
END FUNCTION

#從4rp中讀取對齊屬性轉成資料庫對齊屬性
FUNCTION sadzq185_01_getalign(p_value)
   DEFINE p_value    STRING
   DEFINE l_result   LIKE  type_t.chr1 

   LET l_result = NULL
   CASE DOWNSHIFT(p_value)
      WHEN "center"
         LET l_result = "C"
      WHEN "right"
         LET l_result = "R"
      WHEN "left"
         LET l_result = "L"
      OTHERWISE
         LET l_result = "L"
   END CASE

   RETURN l_result
END FUNCTION

#將4RP屬性值true|false轉為資料欄位值Y|N
FUNCTION sadzq185_01_bool2char(p_val)
    DEFINE p_val STRING
    DEFINE l_str STRING

    INITIALIZE l_str TO NULL
    CASE
        WHEN p_val.equalsIgnoreCase("true")
            LET l_str = "Y"
        WHEN p_val.equalsIgnoreCase("false")
            LET l_str = "N"
        OTHERWISE
            LET l_str = "N"
    END CASE
    RETURN l_str
END FUNCTION

#取得欄位到單頭單身區段的所有節點
FUNCTION sadzq185_01_getparents(p_node)
   DEFINE p_node     om.DomNode
   DEFINE la_parents DYNAMIC ARRAY OF om.DomNode
   DEFINE l_parent   om.DomNode

   CALL la_parents.clear()
   LET l_parent = p_node.getParent()#父節點
   WHILE TRUE
      IF l_parent IS NULL THEN
         EXIT WHILE
      END IF
      CALL la_parents.appendElement()
      LET la_parents[la_parents.getLength()] = l_parent #將父節點放入陣列
      IF l_parent.getAttribute("name") = "ReportHeader" #父節點的NAME屬性判斷
          OR l_parent.getAttribute("name") = "RHMasters"
          OR l_parent.getAttribute("name") = "RHMasterAs"
          OR l_parent.getAttribute("name") = "RHMasterCs"
          OR l_parent.getAttribute("name") = "PHMasters"
          OR l_parent.getAttribute("name") = "PageHeader"
          OR l_parent.getAttribute("name") = "PHMasterAs"
          OR l_parent.getAttribute("name") = "PHMasterCs"
          OR l_parent.getAttribute("name") = "Details"
          OR l_parent.getAttribute("name") = "RHDetailHeaders" 
          OR l_parent.getAttribute("name") = "PHDetailHeaders"
      THEN
         EXIT WHILE
      END IF
      LET l_parent = l_parent.getParent()
   END WHILE

   RETURN la_parents
END FUNCTION

#161207 add(s)
#取得需要與欄位一起搬移的變數節點 找此欄位前的rtl:input-variable 並記下，要一起搬移
FUNCTION sadzq185_01_get_varnodes(p_node)
    DEFINE p_node       om.DomNode
    DEFINE l_parent     om.DomNode
    DEFINE l_nodes      DYNAMIC ARRAY OF om.DomNode
    DEFINE l_current    om.DomNode
    DEFINE l_i          LIKE type_t.num5
    DEFINE l_j          LIKE type_t.num5
    DEFINE l_str        STRING
    DEFINE l_varname    STRING

    CALL l_nodes.clear()
    LET l_parent = p_node.getParent() #父節點
    FOR l_i = 1 TO l_parent.getChildCount() #子節點數
        LET l_current = l_parent.getChildByIndex(l_i) #目前父節點的子節點index
        LET l_varname = l_current.getAttribute("name") #取得NAME屬性的名稱
        IF l_current.getTagName() = "rtl:input-variable" THEN #目前index的標籤名稱 若是rtl:input-variable
            FOR l_j = 1 TO p_node.getAttributesCount() #此節點屬性數
                LET l_str = p_node.getAttributeValue(l_j) #此節點在位置上的值
                IF l_str.getIndexOf("{{",1) > 0 AND l_str.getIndexOf(l_varname,1) > 0 THEN #若有找到{{或屬性名稱
                    CALL l_nodes.appendElement()   #增加元素
                    LET l_nodes[l_nodes.getLength()] = l_current  #將此父節點的子節點index放入陣列
                END IF
            END FOR
        END IF
    END FOR

    RETURN l_nodes
END FUNCTION

#取得單身或單頭欄位變更的目的行節點
FUNCTION sadzq185_01_get_dstnode(p_node,p_lineno)
   DEFINE p_node        om.DomNode
   DEFINE p_lineno      LIKE type_t.num5
   DEFINE l_parent      om.DomNode
   DEFINE l_curnode     om.DomNode
   DEFINE l_i           LIKE type_t.num10
   DEFINE l_flag        LIKE type_t.num5
   DEFINE la_parents    DYNAMIC ARRAY OF om.DomNode   #父節點
   DEFINE l_nodeName    STRING
   DEFINE l_seq         LIKE type_t.num5
   DEFINE l_result      om.DomNode 
   DEFINE l_curname     STRING   

   LET  l_curnode = NULL
   LET l_flag = FALSE
   
   #找DetailHeaders,Details,Masters該層區段
   CALL la_parents.clear()
   DISPLAY "p_node:",p_node.toString()
   LET la_parents = sadzq185_01_getparents(p_node)
   IF la_parents.getLength() > 0 THEN
      LET l_parent = la_parents[la_parents.getLength()]
   END IF

   #有找到
   IF l_parent IS NOT NULL THEN
      DISPLAY "get_dstnode l_parent有找到"
      LET l_seq = 0
      #搜尋該層所屬行的子節點
      FOR l_i = 1 TO l_parent.getChildCount()
         LET l_curnode = l_parent.getChildByIndex(l_i)
         IF l_curnode.getTagName() = "MINIPAGE"
            OR l_curnode.getTagName() = "LAYOUTNODE" 
         THEN
            LET l_nodeName = l_curnode.getAttribute("name")
            CASE l_parent.getAttribute("name")
               WHEN "PHDetailHeaders" #單身欄位說明
                  IF l_curname.getIndexOf("PHDetailHeader",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHDetailHeaders" #單身欄位說明
                  IF l_curname.getIndexOf("RHDetailHeader",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "Details"       #單身
                  IF l_curname.getIndexOf("Detail",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHMasters"       #單頭
                  IF l_curname.getIndexOf("RHMaster",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "PHMasters"       #單頭
                  IF l_curname.getIndexOf("PHMaster",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHMasterAs"       #單頭
                  IF l_curname.getIndexOf("RHMasterA",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "PHMasterAs"       #單頭
                  IF l_curname.getIndexOf("PHMasterA",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "RHMasterCs"       #單頭
                  IF l_curname.getIndexOf("RHMasterC",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF
               WHEN "PHMasterCs"       #單頭
                  IF l_curname.getIndexOf("PHMasterC",1) >= 1 THEN
                     LET l_seq = l_seq + 1
                  END IF            
            END CASE

            #有找到該行
            IF l_seq = p_lineno THEN
               LET l_result = l_curnode
               EXIT FOR
            END IF
         END IF
      END FOR
   END IF

   RETURN l_result
END FUNCTION

#找出目前欄位與DetailHeaders,Details,Masters區段的層數
FUNCTION sadzq185_01_getlevel(p_node)
   DEFINE p_node     om.DomNode
   DEFINE l_parent   om.DomNode
   DEFINE l_level    LIKE type_t.num5

   LET l_level = 0
   #找DetailHeaders,Details,Masters該層區段
   LET l_parent = p_node.getParent()
   WHILE TRUE
      IF l_parent IS NULL THEN
         LET l_level = 0   #未找到時將層數設為0
         EXIT WHILE
      END IF
      LET l_level = l_level + 1
      IF l_parent.getAttribute("name") = "RHDetailHeaders" #父節點的NAME屬性判斷
          OR l_parent.getAttribute("name") = "PHDetailHeaders"
          OR l_parent.getAttribute("name") = "Details"
          OR l_parent.getAttribute("name") = "RHMasters"
          OR l_parent.getAttribute("name") = "PHMasters"
          OR l_parent.getAttribute("name") = "RHMasterAs"
          OR l_parent.getAttribute("name") = "PHMasterAs"
          OR l_parent.getAttribute("name") = "RHMasterCs"
          OR l_parent.getAttribute("name") = "PHMasterCs"
      THEN
         EXIT WHILE
      END IF
      LET l_parent = l_parent.getParent()
   END WHILE

   RETURN l_level
END FUNCTION

#取得變更的單身欄位目的節點
FUNCTION sadzq185_01_get_seqnode(p_parent,p_seqno)
   DEFINE p_parent      om.DomNode
   DEFINE p_seqno       LIKE type_t.num5
   DEFINE l_curnode     om.DomNode
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_resnode     om.DomNode
   DEFINE l_parent_name STRING    

   INITIALIZE l_resnode TO NULL
   
   IF p_parent IS NOT NULL AND p_seqno >= 1 THEN
      LET l_cnt = 0
      LET l_parent_name = p_parent.getAttribute("name")
      FOR l_i = 1 TO p_parent.getChildCount()
         LET l_curnode = p_parent.getChildByIndex(l_i)
         IF l_curnode.getTagName() = "WORDBOX"
            OR l_curnode.getTagName() = "WORDWRAPBOX"
            OR l_curnode.getTagName() = "DECIMALFORMATBOX"
            OR l_curnode.getTagName() = "IMAGEBOX" 
         THEN
            LET l_cnt = l_cnt + 1
            IF l_cnt = p_seqno THEN
                LET l_resnode = l_curnode
                EXIT FOR
            END IF
         END IF
       END FOR
    END IF
    RETURN l_resnode
END FUNCTION

#確認p_node是否為p_parent的子節點
FUNCTION sadzq185_01_findchild(p_parent,p_node)
   DEFINE p_parent   om.DomNode
   DEFINE p_node     om.DomNode
   DEFINE l_nodelist om.NodeList
   DEFINE l_curnode  om.DomNode
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_result   LIKE type_t.num5
   DEFINE l_tagname  STRING
   DEFINE l_nodename STRING

   LET l_result = FALSE
   IF p_parent IS NOT NULL AND p_node IS NOT NULL THEN
      LET l_tagname = p_node.getTagName()
      LET l_nodename = p_node.getAttribute("name")
      LET l_nodelist = p_parent.selectByTagName(l_tagname)
      FOR l_i = 1 TO l_nodelist.getLength()
         LET l_curnode = l_nodelist.item(l_i)
         IF l_curnode.getAttribute("name") = l_nodename THEN
            LET l_result = TRUE
            EXIT FOR
         END IF
      END FOR
   END IF
   RETURN l_result
END FUNCTION
#161207 add(e)
