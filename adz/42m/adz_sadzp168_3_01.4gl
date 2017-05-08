#+ 程式版本......: T6 Version 1.00.00 Build-0001 AT 12/12/21
#
#+ 程式代碼......: sadzp168_3_01 for 整合產出UI設計資料暫用
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_3_01.4gl 
# Description    : 解析4fd畫面成設計資料工具
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

CONSTANT g_widget_group = "widget_group"             #元件組合群組代碼前綴字元


TYPE type_g_structure        RECORD                  #控件所屬結構
                TYPE            STRING,              #structure類型
                id              STRING,              #structure代碼
                label_text      STRING,              #structure標籤代碼
                level           LIKE type_t.num5     #structure節點階層
             END RECORD

TYPE type_g_dzfb             RECORD                  #畫面元件組合檔
                   dzfb001      LIKE dzfb_t.dzfb001,
                   dzfb002      LIKE dzfb_t.dzfb002,
                   dzfb003      LIKE dzfb_t.dzfb003,
                   dzfb004      LIKE dzfb_t.dzfb004,
                   dzfb005      LIKE dzfb_t.dzfb005,
                   dzfb006      LIKE dzfb_t.dzfb006,
                   dzfb007      LIKE dzfb_t.dzfb007, #所屬結構類型
                   dzfb008      LIKE dzfb_t.dzfb008, #所屬結構代碼
                   dzfb009      LIKE dzfb_t.dzfb009, #所屬結構標籤代碼
                   dzfb010      LIKE dzfb_t.dzfb010, #欄位標籤代碼
                   dzfb011      LIKE dzfb_t.dzfb011, #參考欄位控件代號
                   dzfb012      LIKE dzfb_t.dzfb012  #是否為參考欄位
             END RECORD


  
DEFINE g_dzaa004             LIKE dzaa_t.dzaa004     #設計點版本              #todo
DEFINE g_dzfa003             LIKE dzfa_t.dzfa003     #編號

DEFINE g_dzfa                RECORD                  #畫面結構檔
                   dzfa001      LIKE dzfa_t.dzfa001, 
                   dzfa002      LIKE dzfa_t.dzfa002,
                   dzfa003      LIKE dzfa_t.dzfa003,
                   dzfa004      LIKE dzfa_t.dzfa004,
                   dzfa005      LIKE dzfa_t.dzfa005,
                   dzfa006      LIKE dzfa_t.dzfa006,
                   dzfa007      LIKE dzfa_t.dzfa007,
                   dzfa008      LIKE dzfa_t.dzfa008,
                   dzfa009      LIKE dzfa_t.dzfa009,
                   dzfa010      LIKE dzfa_t.dzfa010, #是否為元件組合(Y:Container下會有widget; M:Container下會再有Container)
                   dzfa011      LIKE dzfa_t.dzfa011,
                   dzfa012      LIKE dzfa_t.dzfa012, #節點階層
                   dzfaownid    LIKE dzfa_t.dzfaownid, 
                   dzfaowndp    LIKE dzfa_t.dzfaowndp, 
                   dzfacrtid    LIKE dzfa_t.dzfacrtid, 
                   dzfacrtdp    LIKE dzfa_t.dzfacrtdp, 
                   dzfacrtdt    LIKE dzfa_t.dzfacrtdt, 
                   dzfamodid    LIKE dzfa_t.dzfamodid, 
                   dzfamoddt    LIKE dzfa_t.dzfamoddt
             END RECORD

#DEFINE g_dzfb                RECORD                  #畫面元件組合檔
#                   dzfb001      LIKE dzfb_t.dzfb001,
#                   dzfb002      LIKE dzfb_t.dzfb002,
#                   dzfb003      LIKE dzfb_t.dzfb003,
#                   dzfb004      LIKE dzfb_t.dzfb004,
#                   dzfb005      LIKE dzfb_t.dzfb005,
#                   dzfb006      LIKE dzfb_t.dzfb006,
#                   dzfb007      LIKE dzfb_t.dzfb007, #所屬結構類型
#                   dzfb008      LIKE dzfb_t.dzfb008, #所屬結構代碼
#                   dzfb009      LIKE dzfb_t.dzfb009, #所屬結構標籤代碼
#                   dzfb010      LIKE dzfb_t.dzfb010, #欄位標籤代碼
#                   dzfb011      LIKE dzfb_t.dzfb011  #參考欄位控件代號
#             END RECORD

DEFINE g_dzfk                RECORD                  #畫面元件屬性檔
                   dzfk001      LIKE dzfk_t.dzfk001,
                   dzfk002      LIKE dzfk_t.dzfk002,
                   dzfk003      LIKE dzfk_t.dzfk003,
                   dzfk004      LIKE dzfk_t.dzfk004,
                   dzfk005      LIKE dzfk_t.dzfk005,
                   dzfk006      LIKE dzfk_t.dzfk006
             END RECORD

DEFINE g_dzfl                RECORD                  #畫面元件屬性檔
                   dzfl001      LIKE dzfl_t.dzfl001,
                   dzfl002      LIKE dzfl_t.dzfl002,
                   dzfl003      LIKE dzfl_t.dzfl003,
                   dzfl004      LIKE dzfl_t.dzfl004,
                   dzfl005      LIKE dzfl_t.dzfl005,
                   dzfl006      LIKE dzfl_t.dzfl006
             END RECORD

#DEFINE g_structure           type_g_structure
DEFINE g_form_name           STRING                  #4fd UI畫面代號
DEFINE g_bg_exec             LIKE type_t.chr1        #是否為背景執行

#+ 作業開始
FUNCTION sadzp168_3_01(p_module, p_form_name, p_ver)
   DEFINE l_s_time,l_e_time DATETIME YEAR TO FRACTION(4)
   DEFINE l_node            om.DomNode              #4fd domNode

   DEFINE p_module          STRING                  #4fd所在模組
   DEFINE p_form_name       STRING                  #UI畫面代號
   DEFINE p_ver             LIKE dzaa_t.dzaa002     #規格版號

   DEFINE l_structure       type_g_structure
   DEFINE l_dzfa012         LIKE dzfa_t.dzfa012     #節點所屬階層

   #todo:free style的解析與否判斷,系統/應用元件有無4fd的判斷
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_s_time = CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Strat time : ", l_s_time, ASCII 10

   INITIALIZE l_structure TO NULL
   LET g_dzaa004 = p_ver
   
   LET g_bg_exec = FALSE
   
   #程式初始化
   IF NOT sadzp168_3_01_init(p_form_name, p_ver) THEN
      RETURN FALSE
   END IF

   #取得需要解析的4fd畫面檔結構
   CALL sadzp168_3_01_get_4fd(p_module, p_form_name) RETURNING l_node

   IF l_node IS NULL THEN
      #取得4fd畫面檔結構失敗.
      IF g_bg_exec = "Y" THEN
         #DISPLAY "ERROR:", cl_getmsg_parm("adz-00076", g_lang, p_module || "." || p_form_name)
         DISPLAY "ERROR:", cl_getmsg_parm("adz-00243", g_lang, "")
      ELSE
         #CALL cl_err_msg(NULL, "adz-00076", p_module || "." || p_form_name, 0)
         CALL cl_err("", "adz-00243", 1)
      END IF
      RETURN FALSE
   END IF
   
   BEGIN WORK

   #root為最上階(第1階層)
   LET l_dzfa012 = 0
   
   #進行畫面解析,最上層節點定義為root
   IF sadzp168_3_01_analyze(l_node, "root", 1, l_structure.*, l_dzfa012) THEN
      COMMIT WORK
   ELSE
      RETURN FALSE
   END IF
   
   LET l_e_time = CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_e_time
   DISPLAY "    Cost time : ", l_e_time - l_s_time

   RETURN TRUE
END FUNCTION

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp168_3_01_init(p_form_name, p_ver)
   DEFINE p_form_name       STRING                #4fd畫面檔檔案名稱,xxxx.4fd
   DEFINE p_ver             LIKE dzaa_t.dzaa002   #規格版號
   DEFINE l_sql             STRING

   LET g_dzfa003 = 0
   LET g_form_name = p_form_name
   
   #刪除此畫面代碼所有相關設計資訊
   IF NOT sadzp168_3_01_reload_delete(p_form_name, p_ver) THEN
      DISPLAY "Delete failures."    #刪除失敗
   END IF

   #####宣告insert 畫面結構檔資枓表#####
   LET l_sql = "INSERT INTO dzfa_t (dzfa001, dzfa002, dzfa003, dzfa004, dzfa005, ",
               "                    dzfa006, dzfa007, dzfa008, dzfa009, dzfa010, ",
               "                    dzfa011, dzfa012, ", 
               "                    dzfaownid, dzfaowndp, dzfacrtid, dzfacrtdp, dzfacrtdt, ",
               "                    dzfamodid, dzfamoddt ", 
               "                     )",
               "  VALUES (?,?,?,?,?, ?,?,?,?,?,",
               "          ?,?, ",
               "          ?,?,?,?,?, ?,?)"
                     
   PREPARE sadzp168_3_01_dzfa_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      IF g_bg_exec = "Y" THEN
         DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfa_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      ELSE
         CALL cl_err('PREPARE sadzp168_3_01_dzfa_ins_pre:', SQLCA.sqlcode, 0) 
      END IF
      RETURN FALSE
   END IF

   LET g_dzfa.dzfa001 = p_form_name.trim()
   LET g_dzfa.dzfa002 = g_dzaa004 CLIPPED

   #####宣告insert 畫面元件組合檔資枓表#####
   LET l_sql = "INSERT INTO dzfb_t (dzfb001, dzfb002, dzfb003, dzfb004, dzfb005, ", 
               "                    dzfb006, dzfb007, dzfb008, dzfb009, dzfb010, ", 
               "                    dzfb011, dzfb012)",
               "  VALUES (?,?,?,?,?, ?,?,?,?,?,",
               "          ?,?)"
                     
   PREPARE sadzp168_3_01_dzfb_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      IF g_bg_exec = "Y" THEN
         DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfb_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
       ELSE
         CALL cl_err('PREPARE sadzp168_3_01_dzfb_ins_pre:', SQLCA.sqlcode, 0)
      END IF
      RETURN FALSE
   END IF

   #LET g_dzfb.dzfb001 = p_form_name.trim()
   #LET g_dzfb.dzfb002 = g_dzaa004 CLIPPED

   #####宣告insert 畫面元件屬性檔資枓表#####
   LET l_sql = "INSERT INTO dzfk_t (dzfk001, dzfk002, dzfk003, ", 
               "                    dzfk004, dzfk005, dzfk006)",
               "  VALUES (?,?,?,?,?, ?)"
                     
   PREPARE sadzp168_3_01_dzfk_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      IF g_bg_exec = "Y" THEN
         DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfk_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      ELSE
         CALL cl_err('PREPARE sadzp168_3_01_dzfk_ins_pre:', SQLCA.sqlcode, 0)
      END IF
      RETURN FALSE
   END IF

   LET g_dzfk.dzfk001 = p_form_name.trim()
   LET g_dzfk.dzfk002 = g_dzaa004 CLIPPED

   #####宣告insert 畫面元件資料項目檔資枓表#####
   LET l_sql = "INSERT INTO dzfl_t (dzfl001, dzfl002, dzfl003, ", 
               "                    dzfl004, dzfl005, dzfl006)",
               "  VALUES (?,?,?,?,?, ?)"
                     
   PREPARE sadzp168_3_01_dzfl_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      IF g_bg_exec = "Y" THEN
         DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfl_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      ELSE
         CALL cl_err('PREPARE sadzp168_3_01_dzfl_ins_pre:', SQLCA.sqlcode, 0)
      END IF
      RETURN FALSE
   END IF

   LET g_dzfl.dzfl001 = p_form_name.trim()
   LET g_dzfl.dzfl002 = g_dzaa004 CLIPPED

   RETURN TRUE
END FUNCTION
   
#+ 載入4fd畫面成domNode
PRIVATE FUNCTION sadzp168_3_01_get_4fd(p_module, p_form_name)
   DEFINE p_module          STRING                #4fd所在模組
   DEFINE p_form_name       STRING                #4fd畫面檔檔案名稱,xxxx.4fd

   DEFINE r_template_node   om.DomNode            #4fd domNode
   
   INITIALIZE r_template_node TO NULL
   
   #載入需要解析的4fd畫面檔成domNode
   LET r_template_node = sadzp168_2_get_4fd(p_module, p_form_name)

   #取得符合條件的節點(domNode)=>取得只需要解析4fd結構
   #通常就是由<Form></Form> tag裡的結構資料
   IF r_template_node IS NOT NULL THEN
      #CALL sadzp168_2_get_domNode(r_template_node, "Form", "name", p_form_name.trim())
      CALL sadzp168_2_get_form_node(r_template_node, "Form")
         RETURNING r_template_node  
   END IF
         
   RETURN r_template_node
END FUNCTION

#+ 分析4fd結構(解析方式:XML結構由外而內方式)
PRIVATE FUNCTION sadzp168_3_01_analyze(p_node, p_dzfa004, p_dzfa005, p_structure, p_dzfa012)
   DEFINE p_node             om.DomNode  
   DEFINE p_dzfa004          LIKE dzfa_t.dzfa004              #父節點群組代碼
   DEFINE p_dzfa005          LIKE dzfa_t.dzfa005              #排序順序
   DEFINE p_structure        type_g_structure
   DEFINE p_dzfa012          LIKE dzfa_t.dzfa012              #節點所屬階層
   
   DEFINE l_child_num        LIKE dzfa_t.dzfa005              #子節點排序順序
   DEFINE l_dzfa006          LIKE dzfa_t.dzfa006              #此節點元件(組)代碼
   DEFINE l_is_container     LIKE type_t.chr1                 #此節點是否為定義可包容子元件的container結構
   #DEFINE l_structure        type_g_structure
   
   LET g_dzfa003 = g_dzfa003 + 1
   
   #####insert 畫面結構檔資枓表#####
   LET g_dzfa.dzfa003 = g_dzfa003                             #編號
   LET g_dzfa.dzfa004 = p_dzfa004 CLIPPED                     #群組代碼
   LET g_dzfa.dzfa005 = p_dzfa005 CLIPPED                     #順序
   LET g_dzfa.dzfa006 = p_node.getAttribute("name") CLIPPED   #元件(組)代碼 
   LET l_dzfa006 = g_dzfa.dzfa006
   LET g_dzfa.dzfa007 = p_node.getTagName()                   #節點類型

   LET g_dzfa.dzfaownid = g_user
   LET g_dzfa.dzfaowndp = g_dept
   LET g_dzfa.dzfacrtid = g_user
   LET g_dzfa.dzfacrtdp = g_dept
   LET g_dzfa.dzfacrtdt = cl_get_current()
   LET g_dzfa.dzfamodid = g_user
   LET g_dzfa.dzfamoddt = cl_get_current()
   

   #取得widget所屬結構
   CALL sadzp168_3_01_get_structure(g_dzfa.dzfa006, g_dzfa.dzfa007, p_dzfa012, p_node.getAttribute("text"), p_structure.*)
      RETURNING p_structure.*
      
   #node下無其他子節點時,視為最終元件(dzfa008)
   #因ComboBox和RadioGroup二個widget也為最終元件,但底下還會有items子項目,所以需排除
   IF p_node.getChildCount() = 0 OR p_node.getTagName() = "ComboBox" OR p_node.getTagName() = "RadioGroup" THEN
      LET g_dzfa.dzfa008 = "Y"   #是否為最終元件
   ELSE
      LET g_dzfa.dzfa008 = "N"
   END IF

   LET g_dzfa.dzfa009 = "N"      #todo:是否為公版 
   LET g_dzfa.dzfa010 = "N"
   
   #dzfa010先定義:最終元件子widget目前只可在某幾個container下
   #這些container下,視為元件組合
   #目前dzfa011取群組的原則都是橫向排列,只有VBox元件是直向排列
   CALL sadzp168_3_01_is_container(p_node.getTagName(), p_node.getAttribute("name"))
      RETURNING l_is_container, g_dzfa.dzfa011
   
   EXECUTE sadzp168_3_01_dzfa_ins_pre USING g_dzfa.dzfa001, g_dzfa.dzfa002, g_dzfa.dzfa003, g_dzfa.dzfa004, g_dzfa.dzfa005, 
                                         g_dzfa.dzfa006, g_dzfa.dzfa007, g_dzfa.dzfa008, g_dzfa.dzfa009, g_dzfa.dzfa010, 
                                         g_dzfa.dzfa011, p_dzfa012,
                                         g_dzfa.dzfaownid, g_dzfa.dzfaowndp, g_dzfa.dzfacrtid, g_dzfa.dzfacrtdp, g_dzfa.dzfacrtdt, 
                                         g_dzfa.dzfamodid, g_dzfa.dzfamoddt
   IF SQLCA.sqlcode THEN
      IF g_bg_exec = "Y" THEN
         DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfa_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      ELSE
         CALL cl_err('EXECUTE sadzp168_3_01_dzfa_ins_pre:', SQLCA.sqlcode, 0)
      END IF
      ROLLBACK WORK
      RETURN FALSE
   END IF

   #Container若為元件組合,需逐一解析內存的widget排列方式
   IF l_is_container = "Y" THEN
      IF NOT sadzp168_3_01_analyze_container(p_node, l_dzfa006, p_structure.*, p_dzfa012) THEN
         RETURN FALSE
      ELSE
         RETURN TRUE
      END IF
   END IF

   #node結構不為元件組合的container時,繼續往下層結構解析
   LET p_node = p_node.getFirstChild()
   LET l_child_num = 1
   LET p_dzfa012 = p_dzfa012 + 1

   WHILE p_node IS NOT NULL
      DISPLAY "tag:", p_node.getTagName(), "; name:", p_node.getAttribute("name")
      #紀錄各節點(包含container和widget..等)屬性值
      IF NOT sadzp168_3_01_insert_attr(p_node) THEN
         RETURN FALSE
      END IF

      #繼續逐層往下往子節點解析(由外而內)
      IF sadzp168_3_01_analyze(p_node, l_dzfa006, l_child_num, p_structure.*, p_dzfa012) THEN
         LET p_node = p_node.getNext()
         LET l_child_num = l_child_num + 1
      ELSE
         RETURN FALSE
         #EXIT WHILE
      END IF
   END WHILE

   RETURN TRUE
END FUNCTION

#+ 取得是否為container元件
#todo:目前最終元件子widget目前只可在某幾個container下,是否合理?
PRIVATE FUNCTION sadzp168_3_01_is_container(p_widget, p_widget_name)
   DEFINE p_widget          STRING                #widget type
   DEFINE p_widget_name     STRING                #widget name
   
   DEFINE l_dzfa010         LIKE dzfa_t.dzfa010   #是否為元件組合
   DEFINE l_dzfa011         LIKE dzfa_t.dzfa011   #直橫排列V/H

   LET l_dzfa010 = ""
   LET l_dzfa011 = ""

   #如果Group名稱為Group_state,代表在單頭結構中直接有一個statechange的控件節點
   #所以Group_state為元件組合的container
   IF p_widget.trim() = "Group" AND p_widget_name.trim() = "Group_state" THEN
      LET l_dzfa010 = "Y"
      LET l_dzfa011 = "H"
      RETURN l_dzfa010, l_dzfa011
   END IF
   
   CASE p_widget.trim()
      WHEN "Grid"
         LET l_dzfa010 = "Y"
         LET l_dzfa011 = "H"
      WHEN "Table"
         LET l_dzfa010 = "Y"
         LET l_dzfa011 = "H"
      WHEN "Tree"
         LET l_dzfa010 = "Y"
         LET l_dzfa011 = "H"
      WHEN "ScrollGrid"
         LET l_dzfa010 = "Y"
         LET l_dzfa011 = "H"

      WHEN "Folder"
         LET l_dzfa010 = "M"
         LET l_dzfa011 = "H"
      WHEN "Page"
         LET l_dzfa010 = "Y"
         LET l_dzfa011 = "H"

      WHEN "Group"            #這種Group下還有其他container元件,如:Grid, HBox...
         LET l_dzfa010 = "Y"
         LET l_dzfa011 = "H"
      WHEN "HBox"
         LET l_dzfa010 = "M"
         LET l_dzfa011 = "H"
      WHEN "VBox"
         LET l_dzfa010 = "M"
         LET l_dzfa011 = "V"
         
      OTHERWISE
         LET l_dzfa010 = ""
         LET l_dzfa011 = ""
   END CASE 

   RETURN l_dzfa010, l_dzfa011
END FUNCTION

#+ 解析container內的元件組合各內容物
PRIVATE FUNCTION sadzp168_3_01_analyze_container(p_node, p_dzfa004, p_structure, p_dzfa012)
   DEFINE p_node            om.DomNode            #Container Node
   DEFINE p_dzfa004         LIKE dzfa_t.dzfa004   #上層父節點元件(組)代碼 
   DEFINE p_structure       type_g_structure
   DEFINE p_dzfa012         LIKE dzfa_t.dzfa012   #節點所屬階層
   
   DEFINE l_child_node      om.DomNode            #子節點
   DEFINE l_posY            LIKE type_t.num10     #同一排的posY軸位置
   DEFINE l_posY_widget     LIKE type_t.num10     #每個widget的posY軸位置
   DEFINE l_is_new_group    LIKE type_t.chr1      #是否為一個新的群組
   DEFINE l_dzfb003         LIKE dzfb_t.dzfb003   #群組代碼
   DEFINE l_child_num       LIKE dzfb_t.dzfb004   #同一群組下的widget排列順序
   DEFINE l_dzfa005         LIKE dzfa_t.dzfa005   #父節點下的各群組順序
   DEFINE l_dzfa006         LIKE dzfa_t.dzfa006   #元件(組)代碼
   DEFINE l_dzfa010         LIKE dzfa_t.dzfa010   #是否為元件組合
   DEFINE l_dzfa011         LIKE dzfa_t.dzfa011   #直橫排列V/H
   
   DEFINE l_dzfb            type_g_dzfb           #畫面元件組合檔
   DEFINE l_dzfb_t          type_g_dzfb
   DEFINE l_label           LIKE dzfb_t.dzfb010   #欄位標籤代碼
   DEFINE l_dzfb012         LIKE dzfb_t.dzfb012   #是否為參考欄位
   DEFINE l_success         LIKE type_t.chr1

   #預設l_posY = -1表示元件組合無任何widget
   LET l_posY = -1
   LET l_dzfb003  = ""
   LET l_dzfb012 = "N"
   LET l_dzfa005 = 0
   
   LET l_child_node = p_node.getFirstChild()
   
   WHILE l_child_node IS NOT NULL
      #判斷container裡是否還包了一層的container   
      CALL sadzp168_3_01_is_container(l_child_node.getTagName(), l_child_node.getAttribute("name"))
         RETURNING l_dzfa010, l_dzfa011

      #子節點若為Container,需再逐一解析內存的widget 元件組合方式
      IF l_dzfa010 = "Y" OR l_dzfa010 = "M" THEN
         LET l_dzfa005 = l_dzfa005 + 1
         LET l_dzfa006 = p_node.getAttribute("name") CLIPPED   #元件(組)代碼

         LET p_dzfa012 = p_dzfa012 + 1
         
         #再往下層解析至元件組合結構為止
         IF NOT sadzp168_3_01_analyze(l_child_node, l_dzfa006, l_dzfa005, p_structure.*, p_dzfa012) THEN
            RETURN FALSE
         END IF
      ELSE
         #container內的widget屬性posY值相同的話,視為同一排組合元件(同一個群組)
         LET l_posY_widget = l_child_node.getAttribute("posY") 
         
         #如果是Phantom欄位沒有posY就直接指定為0
         IF l_posY_widget IS NULL AND l_child_node.getTagName() = "Phantom" THEN
            LET l_posY_widget = 0
         END IF
         
         IF l_posY <> l_posY_widget THEN
            #新元件組合群組成立
            LET l_is_new_group = TRUE   
            LET l_child_num = 1

            #同一排(posY)組合元件(同一個群組)
            LET l_posY = l_posY_widget
         ELSE
            LET l_is_new_group = FALSE
         END IF   
    
         #新的元件組合檔群組成立時,insert一筆回畫面結構檔
         IF l_is_new_group THEN
            #####insert 畫面結構檔資枓表#####
            LET g_dzfa003 = g_dzfa003 + 1

            #取得本次元件(組)代碼
            LET l_dzfb003 = g_widget_group, g_dzfa003 USING "<<<<<"
            
            LET g_dzfa.dzfa003 = g_dzfa003           #編號
            LET g_dzfa.dzfa004 = p_dzfa004 CLIPPED   #群組代碼
            LET l_dzfa005 = l_dzfa005 + 1
            LET g_dzfa.dzfa005 = l_dzfa005 CLIPPED   #順序
            LET g_dzfa.dzfa006 = l_dzfb003 CLIPPED   #元件(組)代碼 
            LET g_dzfa.dzfa007 = ""                  #節點類型
            LET g_dzfa.dzfa008 = "Y"                 #是否為最終元件
            LET g_dzfa.dzfa009 = "N"                 #是否為公版 
            LET g_dzfa.dzfa010 = "Y"                 #是否為元件組合
            LET g_dzfa.dzfa011 = ""                  #直橫排列V/H
            LET g_dzfa.dzfa012 = ""

            LET g_dzfa.dzfaownid = g_user
            LET g_dzfa.dzfaowndp = g_dept            
            LET g_dzfa.dzfacrtid = g_user
            LET g_dzfa.dzfacrtdp = g_dept
            LET g_dzfa.dzfacrtdt = cl_get_current()
            LET g_dzfa.dzfamodid = g_user
            LET g_dzfa.dzfamoddt = cl_get_current()
   

            EXECUTE sadzp168_3_01_dzfa_ins_pre USING g_dzfa.dzfa001, g_dzfa.dzfa002, g_dzfa.dzfa003, g_dzfa.dzfa004, g_dzfa.dzfa005, 
                                                  g_dzfa.dzfa006, g_dzfa.dzfa007, g_dzfa.dzfa008, g_dzfa.dzfa009, g_dzfa.dzfa010, 
                                                  g_dzfa.dzfa011, g_dzfa.dzfa012, 
                                                  g_dzfa.dzfaownid, g_dzfa.dzfaowndp, g_dzfa.dzfacrtid, g_dzfa.dzfacrtdp, g_dzfa.dzfacrtdt, 
                                                  g_dzfa.dzfamodid, g_dzfa.dzfamoddt
            IF SQLCA.sqlcode THEN
               IF g_bg_exec = "Y" THEN
                  DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfa_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
               ELSE
                  CALL cl_err('EXECUTE sadzp168_3_01_dzfa_ins_pre:', SQLCA.sqlcode, 0)
               END IF
               ROLLBACK WORK
               RETURN FALSE
            END IF
         END IF

         #依據單頭/單身不同,取得widget欄位標籤代碼
         #LET l_label = ""
         
         #IF p_node.getTagName() <> "Table" AND p_node.getTagName() <> "Tree" THEN
         LET l_label = sadzp168_3_01_get_label(p_node, l_child_node)
         #END IF

         #取得reference欄位控件時,需要將ref欄位控件代號資訊Update到前一個控件代號中(pmdb004=>pmdb004_desc)
         CALL sadzp168_3_01_get_ref_widget(l_child_node, l_dzfb_t.*)
            RETURNING l_success, l_dzfb012
            
         IF NOT l_success THEN
            ROLLBACK WORK
            RETURN FALSE
         END IF
         
         #####insert 畫面元件組合檔資枓表#####
         LET l_dzfb.dzfb001 = g_form_name.trim()
         LET l_dzfb.dzfb002 = g_dzaa004 CLIPPED
         LET l_dzfb.dzfb003 = l_dzfb003 CLIPPED                           #群組代碼
         LET l_dzfb.dzfb004 = l_child_num                                 #順序
         LET l_dzfb.dzfb005 = l_child_node.getAttribute("name") CLIPPED   #元件名稱
         LET l_dzfb.dzfb006 = l_child_node.getTagName() CLIPPED           #節點類型
         LET l_dzfb.dzfb007 = p_structure.TYPE CLIPPED                    #所屬結構類型
         LET l_dzfb.dzfb008 = p_structure.id CLIPPED                      #所屬結構代碼
         LET l_dzfb.dzfb009 = p_structure.label_text CLIPPED              #所屬結構標籤代碼

         IF cl_null(l_dzfb.dzfb008) THEN
            LET l_dzfb.dzfb008 = g_dzfa.dzfa004
         END IF

         LET l_dzfb.dzfb010 = l_label CLIPPED                             #欄位widget標籤代碼
         LET l_dzfb.dzfb011 = ""                                          #參考欄位控件代號
         LET l_dzfb.dzfb012 = l_dzfb012                                   #是否為參考欄位

         EXECUTE sadzp168_3_01_dzfb_ins_pre USING l_dzfb.dzfb001, l_dzfb.dzfb002, l_dzfb.dzfb003, l_dzfb.dzfb004, l_dzfb.dzfb005, 
                                               l_dzfb.dzfb006, l_dzfb.dzfb007, l_dzfb.dzfb008, l_dzfb.dzfb009, l_dzfb.dzfb010,
                                               l_dzfb.dzfb011, l_dzfb.dzfb012
         IF SQLCA.sqlcode THEN
            IF g_bg_exec = "Y" THEN
               DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfb_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
            ELSE
               CALL cl_err('EXECUTE sadzp168_3_01_dzfb_ins_pre:', SQLCA.sqlcode, 0)
            END IF
            ROLLBACK WORK
            RETURN FALSE
         END IF
      END IF

      LET l_dzfb_t.* = l_dzfb.*
      
      #紀錄各節點(包含container和widget..等)屬性值
      IF NOT sadzp168_3_01_insert_attr(l_child_node) THEN
         RETURN FALSE
      END IF
      
      LET l_child_node = l_child_node.getNext()
      LET l_child_num = l_child_num + 1
   END WHILE

   RETURN TRUE
END FUNCTION

#+ insert 畫面元件屬性檔
PRIVATE FUNCTION sadzp168_3_01_insert_attr(p_node)
   DEFINE p_node            om.DomNode          #widget Node
   DEFINE l_i               LIKE type_t.num5
   
   IF p_node IS NULL THEN
      RETURN FALSE
   END IF
   
   FOR l_i = 1 TO p_node.getAttributesCount()
       #####insert 畫面元件屬性檔資枓表#####
       LET g_dzfk.dzfk003 = p_node.getAttribute("name") CLIPPED     #元件代碼
       LET g_dzfk.dzfk004 = l_i                                     #編號
       LET g_dzfk.dzfk005 = p_node.getAttributeName(l_i) CLIPPED    #屬性
       LET g_dzfk.dzfk006 = p_node.getAttributeValue(l_i) CLIPPED   #屬性值
 
       EXECUTE sadzp168_3_01_dzfk_ins_pre USING g_dzfk.dzfk001, g_dzfk.dzfk002, g_dzfk.dzfk003, 
                                             g_dzfk.dzfk004, g_dzfk.dzfk005, g_dzfk.dzfk006
       IF SQLCA.sqlcode THEN
          IF g_bg_exec = "Y" THEN
             DISPLAY "ERROR-PREPARE sadzp168_3_01_dzfk_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
          ELSE
             CALL cl_err('EXECUTE sadzp168_3_01_dzfk_ins_pre:', SQLCA.sqlcode, 0)
          END IF
          ROLLBACK WORK
          RETURN FALSE
       END IF
   END FOR

   #widget為"ComboBox"和"RadioGroup"時,需紀錄資料項目(item子項目)
   IF p_node.getTagName() = "ComboBox" OR p_node.getTagName() = "RadioGroup" THEN
      IF NOT sadzp168_3_01_insert_items(p_node) THEN
         RETURN FALSE
       END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ insert 畫面元件資料項目檔
PRIVATE FUNCTION sadzp168_3_01_insert_items(p_node)
   DEFINE p_node            om.DomNode          #widget Node

   DEFINE l_child_node      om.DomNode          #子節點
   DEFINE l_child_num       LIKE type_t.num5    #同一群組下的widget排列順序

   IF p_node IS NULL THEN
      RETURN FALSE
   END IF
   
   LET l_child_node = p_node.getFirstChild()
   LET l_child_num = 1
   
   WHILE l_child_node IS NOT NULL
       #####insert 畫面元件資料項目檔資枓表#####
       LET g_dzfl.dzfl003 = p_node.getAttribute("name") CLIPPED         #元件代碼
       LET g_dzfl.dzfl004 = l_child_num                                 #編號
       LET g_dzfl.dzfl005 = l_child_node.getAttribute("name") CLIPPED   #屬性
       LET g_dzfl.dzfl006 = l_child_node.getAttribute("text") CLIPPED   #屬性值
 
       EXECUTE sadzp168_3_01_dzfl_ins_pre USING g_dzfl.dzfl001, g_dzfl.dzfl002, g_dzfl.dzfl003, 
                                             g_dzfl.dzfl004, g_dzfl.dzfl005, g_dzfl.dzfl006
       IF SQLCA.sqlcode THEN
          IF g_bg_exec = "Y" THEN
             DISPLAY "ERROR-EXECUTE sadzp168_3_01_dzfl_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
          ELSE
             CALL cl_err('EXECUTE sadzp168_3_01_dzfl_ins_pre:', SQLCA.sqlcode, 0)
          END IF
          ROLLBACK WORK
          RETURN FALSE
       END IF
          
      LET l_child_node = l_child_node.getNext()
      LET l_child_num = l_child_num + 1
   END WHILE

   RETURN TRUE
END FUNCTION

#取得欄位標籤代碼. exp:imba001=>lbl_imba001
PRIVATE FUNCTION sadzp168_3_01_get_label(p_node, p_child_node)
   DEFINE p_node            om.DomNode            #Container Node
   DEFINE p_child_node      om.DomNode            #子節點

   DEFINE l_label           LIKE dzfb_t.dzfb010   #欄位標籤代碼
   DEFINE l_previous_node   om.DomNode            #前一個節點

   LET l_label = ""

   CASE
      #紀錄單身欄位標籤代碼(父節點一定為Table container)
      WHEN (p_node.getTagName() = "Table" OR p_node.getTagName() = "Tree" )
         LET l_label = p_child_node.getAttribute("title") CLIPPED
         RETURN l_label

      #CheckBox widget直接取得text屬性
      WHEN p_child_node.getTagName() = "CheckBox"
         LET l_label = p_child_node.getAttribute("text") CLIPPED

      #紀錄單頭欄位標籤代碼,直接取得label widget名稱
      #WHEN p_child_node.getTagName() = "Label"
         #LET l_label = p_child_node.getAttribute("name") CLIPPED
         
      OTHERWISE
         #紀錄單頭欄位標籤代碼,直接取得label widget名稱
         #單頭欄位標籤代碼,按規則應該都是和欄位控件的posY值相同(同一排)且在前面(PREVIOUS node)
         LET l_previous_node = p_child_node.getPrevious()

         IF p_child_node.getAttribute("posY") = l_previous_node.getAttribute("posY") THEN
            CASE l_previous_node.getTagName()
               WHEN "Label" 
                  LET l_label = l_previous_node.getAttribute("text") CLIPPED

               #串查欄位呈現
               WHEN "Button" 
                  IF l_previous_node.getAttribute("style") = "button_qrystr" AND l_previous_node.getAttribute("name") MATCHES "prog_*" THEN
                     LET l_label = l_previous_node.getAttribute("text") CLIPPED
                  END IF
                  
            END CASE
         END IF

   END CASE

   #下述控件型態在欄位前方應該不會有文字說明
   IF p_child_node.getTagName() = "Phantom" OR p_child_node.getTagName() = "FFLabel" OR p_child_node.getTagName() = "Label" OR 
      p_child_node.getTagName() = "Button" OR p_child_node.getTagName() = "Slider" OR p_child_node.getTagName() = "ProgressBar" OR
      p_child_node.getTagName() = "SpinEdit" THEN
      
      LET l_label = ""
   END IF
   
   RETURN l_label
END FUNCTION

#取得欄位reference說明. exp:pmdb004=>pmdb004_desc
PRIVATE FUNCTION sadzp168_3_01_get_ref_widget(p_child_node, p_dzfb)
   DEFINE p_child_node      om.DomNode            #子節點
   DEFINE p_dzfb            type_g_dzfb           #畫面元件組合檔

   DEFINE l_ref_widget      LIKE dzfb_t.dzfb011   #參考欄位控件代號
   DEFINE l_previous_node   om.DomNode            #前一個控件欄位
   DEFINE l_str             STRING
   DEFINE l_dzfb012         LIKE dzfb_t.dzfb012   #是否為參考欄位

   LET l_ref_widget = ""
   LET l_dzfb012 = "N"

   #判斷是否為reference說明欄位控件
   IF p_child_node.getTagName() = "FFLabel" AND 
      p_child_node.getAttribute("style") = "reference" AND
      p_child_node.getAttribute("name") MATCHES "*_desc" THEN
      
      LET l_ref_widget = p_child_node.getAttribute("name") CLIPPED
      LET l_previous_node = p_child_node.getPrevious()
      LET l_str = l_ref_widget
   END IF

   #下述控件型態若在參考欄位[前方]出現,應該不會有參考欄位的說明文字,因此排除
   IF l_previous_node.getTagName() = "Phantom" OR l_previous_node.getTagName() = "FFLabel" OR l_previous_node.getTagName() = "Label" OR 
      l_previous_node.getTagName() = "Button" OR l_previous_node.getTagName() = "Slider" OR l_previous_node.getTagName() = "ProgressBar" OR
      l_previous_node.getTagName() = "SpinEdit" THEN
      
      LET l_ref_widget = ""
   END IF

   #將ref欄位控件代號資訊Update到前一個控件代號中
   IF NOT cl_null(l_ref_widget) THEN
      UPDATE dzfb_t SET dzfb011 = l_ref_widget
        WHERE dzfb001 = p_dzfb.dzfb001
          AND dzfb002 = p_dzfb.dzfb002
          AND dzfb003 = p_dzfb.dzfb003
          AND dzfb004 = p_dzfb.dzfb004

      IF SQLCA.sqlcode THEN
         CALL cl_err('upd dzfb_t:', SQLCA.sqlcode, 0)
         RETURN FALSE, l_dzfb012
      END IF 
      
      LET l_dzfb012 = "Y"
   END IF
    
   RETURN TRUE, l_dzfb012
END FUNCTION

#+ delete 畫面相關設計資訊
PUBLIC FUNCTION sadzp168_3_01_reload_delete(p_dzfa001, p_dzfa002)
   DEFINE p_dzfa001         LIKE dzfa_t.dzfa001    #畫面代碼
   DEFINE p_dzfa002         LIKE dzfa_t.dzfa002    #設計點版本

   DELETE FROM dzfa_t WHERE dzfa001 = p_dzfa001 AND dzfa002 = p_dzfa002
   DELETE FROM dzfb_t WHERE dzfb001 = p_dzfa001 AND dzfb002 = p_dzfa002
   DELETE FROM dzfk_t WHERE dzfk001 = p_dzfa001 AND dzfk002 = p_dzfa002
   DELETE FROM dzfl_t WHERE dzfl001 = p_dzfa001 AND dzfl002 = p_dzfa002
   
   RETURN TRUE
END FUNCTION






#取得控件所屬結構
#PRIVATE FUNCTION sadzp168_3_01_get_structure(p_node)
PRIVATE FUNCTION sadzp168_3_01_get_structure(p_dzfa006, p_dzfa007, p_dzfa012, p_text, p_structure)
   DEFINE p_dzfa006         LIKE dzfa_t.dzfa006     #container代碼
   DEFINE p_dzfa007         LIKE dzfa_t.dzfa007     #container類型
   DEFINE p_dzfa012         LIKE dzfa_t.dzfa012     #container節點所屬階層
   DEFINE p_text            STRING                  #container標籤代碼
   DEFINE p_structure       type_g_structure

   #結構分類定義:1.Page 2.Group 3.Table
   #以最先找到(最上層結構為區分)結構為主,意同:Page > Group > Table
   #如果已存在所屬結構,且為最上層
   IF (NOT cl_null(p_structure.id)) AND (p_structure.level < p_dzfa012) THEN
      IF NOT (p_structure.TYPE = "Group" AND (p_dzfa007 = "Page" OR p_dzfa007 = "Table")) THEN 
         RETURN p_structure.*
      END IF
   END IF

   IF p_dzfa007 = "Page" OR p_dzfa007 = "Group" OR p_dzfa007 = "Table" THEN
      INITIALIZE p_structure TO NULL
      
      LET p_structure.TYPE = p_dzfa007
      LET p_structure.id = p_dzfa006
      LET p_structure.label_text = p_text
      LET p_structure.level = p_dzfa012

      IF cl_null(p_structure.label_text) THEN
         LET p_structure.label_text = p_dzfa006
      END IF

   END IF
   
   ####結構分類定義:1.Page 2.Group 3.Table
   ####以最先找到(最上層結構為區分)結構為主,意同:Page > Group > Table
   ###IF p_node.getTagName() = "Page" THEN
   ###   INITIALIZE g_structure TO NULL
   ###   LET g_structure.type = p_node.getTagName() CLIPPED
   ###   LET g_structure.id = p_node.getAttribute("name") CLIPPED
   ###   LET g_structure.label_text = p_node.getAttribute("text") CLIPPED
   ###END IF
   ###
   ###IF cl_null(g_structure.id) AND p_node.getTagName() = "Group" THEN
   ###   INITIALIZE g_structure TO NULL
   ###   LET g_structure.type = p_node.getTagName() CLIPPED
   ###   LET g_structure.id = p_node.getAttribute("name") CLIPPED
   ###   LET g_structure.label_text = p_node.getAttribute("text") CLIPPED
   ###END IF
   ###
   ###IF cl_null(g_structure.id) AND p_node.getTagName() = "Table" THEN
   ###   INITIALIZE g_structure TO NULL
   ###   LET g_structure.type = p_node.getTagName() CLIPPED
   ###   LET g_structure.id = p_node.getAttribute("name") CLIPPED
   ###   LET g_structure.label_text = p_node.getAttribute("name") CLIPPED
   ###END IF

   RETURN p_structure.*
END FUNCTION
