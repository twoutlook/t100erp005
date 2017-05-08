#
#+ 程式代碼......: adzp166
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp166.4gl
# Description    : 解析4fd檔為分鏡格式
# Memo           : 
# Modify         : 2015/07/15 by Hiko : 新建程式
#                : 160422-00002 20160422 by Hiko : 修正4fd轉分鏡CheckBox的title問題
#                : 160504-00023 20160504 by Hiko : 配合分鏡調整, TableRole的欄位增加modelIndex屬性

import os
import xml
import security
import util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE gdoc_root  xml.DomDocument,
       gnode_root xml.DomNode, 
       gnode_sco  xml.DomNode 
DEFINE gs_prog     STRING,
       g_cons_type LIKE type_t.chr1,
       gs_module   STRING
DEFINE gobj_str       util.JSONObject, #將多語言檔(str)的資料儲存於JSON物件內.
       gobj_spec      util.JSONObject, #SA規格.
       gobj_folder    util.JSONObject, #將畫面檔(4fd)的page/folder名稱儲存於JSON物件內, 這是為了切開Page為不同分鏡.
       gs_curr_folder STRING,          #搭配gobj_folder使用. 紀錄目前的Page控件所隸屬的Folder是哪一個.
       gobj_parent    util.JSONObject, #將畫面檔(4fd)的名稱/父項控件名稱儲存於JSON物件內, 這是為了切開累加容器控件的寬度/高度.
       gobj_tbl_x     util.JSONObject, #將Table下的控件X軸記錄下來, 因為會重算X軸.
       gs_curr_table  STRING           #搭配gobj_tbl_x使用.
DEFINE SCENE_MAX_WIDTH  SMALLINT, #分鏡可呈現的最大寬度(4000).
       SCENE_MAX_HEIGHT SMALLINT, #分鏡可呈現的最大高度(4000). #目前沒有特別判斷.
       gi_multip_x      SMALLINT, #4fd轉分鏡的控件X軸位置比(預設10).
       gi_multip_y      SMALLINT, #4fd轉分鏡的控件Y軸位置比(預設20). #目前固定20.
       gi_multip_w      SMALLINT, #4fd轉分鏡的控件寬度比(預設10).
       gi_multip_h      SMALLINT, #4fd轉分鏡的控件寬度比(預設20). #目前固定20.
       gb_regen_w       BOOLEAN,
       gb_regen_h       BOOLEAN   #目前沒有使用.

MAIN
   DEFINE ls_4fd_path STRING,
          lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP

   CALL cl_tool_init()

   OPEN WINDOW w_adzp166 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET lf_form = lw_window.getForm()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzp166_init()

   CALL adzp166_ui_dialog()

   CLOSE WINDOW w_adzp166
END MAIN

PRIVATE FUNCTION adzp166_init()
   LET SCENE_MAX_WIDTH  = 4000
   LET SCENE_MAX_HEIGHT = 4000   
   LET gi_multip_x = 10
   LET gi_multip_y = 20
   LET gi_multip_w = 10
   LET gi_multip_h = 20
   LET gb_regen_w = FALSE
   LET gb_regen_h = FALSE
END FUNCTION

PRIVATE FUNCTION adzp166_ui_dialog()
   DEFINE ls_4fd_path STRING

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_cons_type,gs_prog FROM s_qry_type,s_prog_id
         ON CHANGE s_qry_type
            LET gs_prog = NULL
            LET gs_module = NULL
            DISPLAY gs_prog TO s_prog_id
            NEXT FIELD s_prog_id 

         ON ACTION controlp INFIELD s_prog_id
            LET g_qryparam.state = "i"
            LET g_qryparam.default1 = ""
            IF NOT cl_null(g_cons_type) THEN
               LET g_qryparam.where = " dzaf005='",g_cons_type,"' "
            END IF
            
            CALL q_adzp063_a()
            
            LET gs_prog = g_qryparam.return1 CLIPPED
            DISPLAY gs_prog TO s_prog_id
            NEXT FIELD s_prog_id 

         AFTER FIELD s_prog_id
            IF NOT cl_null(gs_prog) THEN
               CALL adzp166_after_field_prog_id(g_cons_type) RETURNING ls_4fd_path
               IF cl_null(ls_4fd_path) THEN
                  NEXT FIELD s_prog_id
               END IF
            END IF

      END INPUT

      ON ACTION btn_go
         CALL adzp166_after_field_prog_id(g_cons_type) RETURNING ls_4fd_path
         IF cl_null(ls_4fd_path) THEN
            NEXT FIELD s_prog_id
         ELSE
            CALL adzp166_trans_sco(ls_4fd_path)
         END IF

      ON ACTION CLOSE
         EXIT DIALOG
   END DIALOG
END FUNCTION

FUNCTION adzp166_after_field_prog_id(p_qry_type)
   DEFINE p_qry_type LIKE type_t.chr1
   DEFINE ls_4fd_path STRING

   #依據程式代號與建構類型取得目前模組.
   CALL sadzp062_1_find_module(gs_prog, p_qry_type) RETURNING gs_module
   IF NOT cl_null(gs_prog) AND NOT cl_null(gs_module) THEN
      LET ls_4fd_path = os.path.join(os.path.join(FGL_GETENV(gs_module), "4fd"), gs_prog||".4fd")

      IF FGL_GETENV("T100DEBUG")="9" THEN
         DISPLAY "ls_4fd_path=",ls_4fd_path
      END IF

      IF NOT os.path.exists(ls_4fd_path) then 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00339"
         LET g_errparam.replace[1] = ls_4fd_path
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "lib-050" #程式代號錯誤或無此程式代號.
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   RETURN ls_4fd_path
END FUNCTION

FUNCTION adzp166_trans_sco(p_4fd_path)
   DEFINE p_4fd_path STRING
   DEFINE lrole_scene   xml.DomNode,
          lrole_frame   xml.DomNode,
          ls_sql        STRING,
          l_prog_desc   LIKE gzzal_t.gzzal003, #建立PROCESS控件.
          lrole_process xml.DomNode,
          lnode_font    xml.DomNode,
          lrole_text    xml.DomNode
   DEFINE ls_run_cmd  STRING,
          lb_result   BOOLEAN,
          ls_err_msg  STRING,
          ls_str_path STRING
   DEFINE ldoc_4fd    xml.DomDocument,
          lnode_start xml.DomNode,
          ls_sco_xml  STRING, #4fd轉出來的分鏡暫存檔.
          ls_sco_path STRING, #經過ScoCreator轉換過後的分鏡檔.
          lb_regen    BOOLEAN,
          ls_dst      STRING  #client端路徑.
   #底下是為了TopMenuRole所設定的變數.
   DEFINE li_revision      SMALLINT,
          ls_identity      STRING,
          la_dzad DYNAMIC ARRAY OF RECORD
                  dzaa003 LIKE dzaa_t.dzaa003
                  END RECORD,
          li_act_idx       SMALLINT,
          ls_act_name      STRING,
          ls_comment       STRING,
          ls_standard      STRING,
          li_x             SMALLINT,
          li_y             SMALLINT,
          li_w             SMALLINT,
          li_h             SMALLINT,
          lrole_act        xml.DomNode,
          lnode_data_model xml.DomNode,
          ls_text          STRING 
   #底下是為了劇情名稱/劇情說明所設定的變數.
   DEFINE lnode_sco_name xml.DomNode,
          lnode_sco_desc xml.DomNode,
          ls_sco_desc    STRING

   #分鏡格式說明:
   #<ScenarioNode>
   #   <Scenario>
   #      <Scene name=$PROG id=$GUID size=($width,$height)> #第一個分鏡就以程式代號命名.
   #         <Role ...>
   #            <TextContent>
   #               <list type="5">
   #                  <item>$邏輯處理</item>
   #               </list>
   #            </TextContent>
   #         </Role>
   #         <Role ...>
   #            ...
   #         </Role>
   #      </Scene>
   #      <Scene name=$PAGE id=$GUID size=($width,$height)> #第二個分鏡出現,一定是有Page,所以就以Page name當作分鏡的name.
   #         <Role ...>
   #            <TextContent>
   #               <list type="5">
   #                  <item>$邏輯處理</item>
   #               </list>
   #            </TextContent>
   #         </Role>
   #         <Role ...>
   #            ...
   #         </Role>
   #      </Scene>
   #      <TextContent>
   #         <text type="4">$劇情名稱</text> #固定為-->程式代號(程式名稱)
   #         <text type="0">$劇情說明</text> #固定為-->4fd to sco : $日期 by $人員
   #      </TextContent>
   #   </Scenario>
   #</ScenarioNode>

   LET ls_str_path = os.path.join(os.path.join(os.path.join(FGL_GETENV(gs_module), "str"), g_lang), gs_prog||".str")
   IF NOT os.path.exists(ls_str_path) then #重產多語言檔(str).
      LET ls_run_cmd = "r.r azzp191 ",gs_prog," ",g_lang," '' '' 'Y'"
      CALL cl_cmdrun_openpipe("r.r azzp191", ls_run_cmd, FALSE) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00654" #產生多語言檔(str)失敗.
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END IF

   LET gobj_str = util.JSONObject.create()
   CALL adzp166_parse_str(ls_str_path)          

   #取得SA規格資料.
   CALL adzp166_get_spec("1") #條件1是取得非ON ACTION的規格.

   LET lb_regen = FALSE
   WHILE TRUE
      LET ldoc_4fd = xml.domDocument.create()
      CALL ldoc_4fd.load(p_4fd_path)
      #解析4fd是從mainlayout開始.
      CALL adzp166_get_mainlayout(ldoc_4fd, "VBox") RETURNING lnode_start
      IF lnode_start IS NULL THEN
         CALL adzp166_get_mainlayout(ldoc_4fd, "HBox") RETURNING lnode_start
      END IF
      
      IF lnode_start IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00652" #此4fd內找不到mainlayout節點.
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      
      LET gobj_folder = util.JSONObject.create()
      LET gobj_parent = util.JSONObject.create()
      LET gobj_tbl_x = util.JSONObject.create()
      LET gs_curr_folder = NULL
      LET gs_curr_table = NULL
      
      LET gdoc_root = xml.domDocument.createDocument("ScenarioNode")
      LET gnode_root = gdoc_root.getDocumentElement()
      LET gnode_sco = gnode_root.appendChildElement("Scenario")
      LET lrole_scene = gnode_sco.appendChildElement("Scene")
      CALL lrole_scene.setAttribute("name", gs_prog)
      CALL lrole_scene.setAttribute("id", security.RandomGenerator.CreateUUIDString()) #GUID
      CALL lrole_scene.setAttribute("size", "(0,0)") 
      
      CALL adzp166_create_role(lrole_scene, "FrameRole", "MAIN", 0, 0, 0, 0) RETURNING lrole_frame
      CALL adzp166_set_spec(lrole_frame) #設定SA規格.

      IF g_cons_type="M" THEN
         LET ls_sql = "SELECT gzzal003 FROM gzzal_t WHERE gzzal001='",gs_prog,"' AND gzzal002='",g_lang,"'"
      ELSE
         LET ls_sql = "SELECT gzdel003 FROM gzdel_t WHERE gzdel001='",gs_prog,"' AND gzdel002='",g_lang,"'"
      END IF

      PREPARE gzzal_prep FROM ls_sql
      EXECUTE gzzal_prep INTO l_prog_desc
      FREE gzzal_prep

      LET l_prog_desc = gs_prog,"(",l_prog_desc,")"
      CALL lrole_frame.setAttribute("text", l_prog_desc)
      CALL gobj_parent.put("MAIN", gs_prog)

      #p_role_scene, p_role_parent, p_node_widget, p_start_x, p_start_y
      CALL adzp166_parse_4fd(lrole_scene, lrole_frame, lnode_start.getFirstChildElement(), 10, 10)
      IF NOT lb_regen THEN #做多重做1次.
         #若過程當中所累加的容器控件超出分鏡可解析的寬度/高度, 則必須要重新縮小再重產一次.
         IF NOT gb_regen_w THEN
            EXIT WHILE
         ELSE
            LET lb_regen = TRUE
            LET gi_multip_w = 5
            LET gi_multip_x = 5

            IF FGL_GETENV("T100DEBUG")="9" THEN
               DISPLAY "重作一次..."
               DISPLAY "gi_multip_x=",gi_multip_x
               DISPLAY "gi_multip_w=",gi_multip_w
            END IF
         END IF
      ELSE
         EXIT WHILE
      END IF
   END WHILE

   #最後再補上PROCESS控件.
   CALL adzp166_create_role(lrole_scene, "LabelRole", "PROCESS", 500, 30, 100, 20) RETURNING lrole_process
   CALL lrole_process.setAttribute("text", "PROCESS")
   LET lnode_font = lrole_process.appendChildElement("Font")
   CALL lnode_font.setAttribute("name", "Dialog")    
   CALL lnode_font.setAttribute("style", "0" )    
   CALL lnode_font.setAttribute("size", "12")    
   CALL lnode_font.setAttribute("isUnderline", "false")    
   CALL adzp166_set_spec(lrole_process) #設定SA規格.
   
   #最後再建立TopMenu分鏡來呈現ON ACTION的規格.
   CALL adzp166_get_spec("2") #取得ON ACTION的規格.
   LET lrole_scene = gnode_sco.appendChildElement("Scene")
   CALL lrole_scene.setAttribute("name", "TopMenu")
   CALL lrole_scene.setAttribute("id", security.RandomGenerator.CreateUUIDString()) #GUID
   CALL lrole_scene.setAttribute("size", "(800,600)") #一行可以顯現大約20個ON ACTION. 超過就放在下一行.
   
   LET li_x = 10
   LET li_y = 10
   LET li_w = 80
   LET li_h = 30

   #取得正確版次的規格所記錄的ON ACTION清單.
   CALL sadzp060_2_get_spec_curr_revision(gs_prog, g_cons_type, gs_module) RETURNING li_revision,ls_identity,ls_err_msg
   IF cl_null(ls_err_msg) THEN 
      LET ls_sql = "SELECT dzaa003 FROM dzaa_t",
                   " WHERE dzaa001='",gs_prog,"'",
                   "   AND dzaa002=",li_revision,
                   "   AND dzaa005='2'",
                   "   AND dzaa009='",ls_identity,"'",
                   "   AND dzaastus='Y'",
                   " ORDER BY dzaa003"
      PREPARE dzad_prep FROM ls_sql
      DECLARE dzad_curs CURSOR FOR dzad_prep
      LET li_act_idx = 1
      FOREACH dzad_curs INTO la_dzad[li_act_idx].*
         IF (li_y+li_h)>590 THEN #這樣控制(600-10)的畫面編排會比較好看.
            LET li_x = li_x + li_w + 10
            LET li_y = 10
         END IF
      
         LET ls_act_name = la_dzad[li_act_idx].dzaa003
         CALL adzp166_create_role(lrole_scene, "PopupMenuRole", ls_act_name, li_x, li_y, li_w, li_h) RETURNING lrole_act
         LET lnode_data_model = lrole_act.appendChildElement("DataModel")
         #LET ls_text = gobj_str.get(ls_act_name)
         CALL s_azzi903_get_gzzq(gs_prog, ls_act_name) RETURNING ls_text,ls_comment,ls_standard
         IF ls_text IS NULL THEN
            LET ls_text = ls_act_name
         END IF
         LET ls_text = "(",ls_text,")"
         CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_text)) #建立節點<DataModel>(act1)</DataModel>
         CALL adzp166_set_spec(lrole_act) #設定SA規格.
      
         LET li_y = li_y + li_h
      END FOREACH
   END IF

   #最後再加上TextContent的內容.
   LET lrole_text = gnode_sco.appendChildElement("TextContent")
   #設定劇情名稱.
   LET lnode_sco_name = lrole_text.appendChildElement("text")
   CALL lnode_sco_name.setAttribute("type", "4")
   CALL lnode_sco_name.appendchild(gdoc_root.createTextNode(l_prog_desc)) #建立節點<text type="4">劇情名稱</text>
   #設定劇情說明.
   LET lnode_sco_desc = lrole_text.appendChildElement("text")
   CALL lnode_sco_desc.setAttribute("type", "0")
   LET ls_sco_desc = "4fd to sco : ",cl_get_current()," by ",g_user,"(",g_account,")"
   CALL lnode_sco_desc.appendchild(gdoc_root.createTextNode(ls_sco_desc)) #建立節點<text type="0">4fd to sco : $日期 by $人員 </text>

   #解析之後放到暫存路徑.
   LET ls_sco_xml = os.path.join(FGL_GETENV("TEMPDIR"), gs_prog||".xml")
   CALL gdoc_root.setFeature("format-pretty-print", "TRUE")
   CALL gdoc_root.save(ls_sco_xml)

   #呼叫Java程式組合成完整的分鏡檔.
   LET ls_sco_path = os.path.join(FGL_GETENV("TEMPDIR"), gs_prog||".sco")
   #java ScoCreator input.xml output.sco imgs
   LET ls_run_cmd = "java ScoCreator ",ls_sco_xml," ",ls_sco_path
   CALL cl_cmdrun_openpipe("4fd to sco", ls_run_cmd, FALSE) RETURNING lb_result,ls_err_msg
   
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = "adz-00217" #執行成功
   LET g_errparam.popup = TRUE
   CALL cl_err()

   #組合完成後讓使用者挑選Client端的路徑存放.
   LET ls_dst = cl_client_browse_dir() #選擇本地端下載資料夾.
   LET ls_dst = os.Path.join(ls_dst, gs_prog||".sco")

   #下載檔案至Client端
   IF NOT cl_client_download_file(ls_sco_path, ls_dst) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00329"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL cl_ask_confirm3("adz-00330", ls_dst)

     ##下載成功後, 從Server端刪除相關檔案.
     #IF os.Path.exists(ls_sco_path) THEN
     #   LET l_cmd = "rm ", l_tar_name
     #   RUN l_cmd
     #END IF
   END IF
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得SA規格
# Input parameter : p_cond_type 條件型態(1.非ON ACTION的規格, 2.ON ACTION的規格)
# Return code     : void
# Date & Author   : 2015/07/30 by Hiko
##########################################################################
FUNCTION adzp166_get_spec(p_cond_type)
   DEFINE p_cond_type STRING
   DEFINE ls_sql     STRING,
          ls_where   STRING,
          li_idx     SMALLINT,
          la_dzem    DYNAMIC ARRAY OF RECORD
                     dzem002 LIKE dzem_t.dzem002,
                     dzem099 LIKE dzem_t.dzem099
                     END RECORD,
          ls_dzem099 STRING 

   LET gobj_spec = util.JSONObject.create()

   IF p_cond_type.equals("1") THEN
      LET ls_where = "   AND dzem003<>'2'"
   ELSE #"2"
      LET ls_where = "   AND dzem003='2'"
   END IF

   LET ls_sql = "SELECT dzem002,dzem099",
                "  FROM dzem_t",
                " WHERE dzem001 = '",gs_prog,"'",ls_where,
                " ORDER BY dzem002,dzem003"
   PREPARE dzem_prep FROM ls_sql
   LOCATE la_dzem[1].dzem099 IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
   DECLARE dzem_curs CURSOR FOR dzem_prep
   LET li_idx = 1
   FOREACH dzem_curs INTO la_dzem[li_idx].*
      LET ls_dzem099 = la_dzem[li_idx].dzem099
      CALL gobj_spec.put(la_dzem[li_idx].dzem002 CLIPPED, ls_dzem099)
      FREE la_dzem[li_idx].dzem099 #釋放LOCATE.
      LET li_idx = li_idx + 1
      LOCATE la_dzem[li_idx].dzem099 IN FILE #設定陣列第二筆以後clob資料的LOCATE.
   END FOREACH
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得T100畫面檔內的mainlayout節點
# Input parameter : p_doc 4fd的xml.DomDocument物件
#                 : p_tag 目標物件的標籤(VBox/HBox)
# Return code     : xml.DomNode mainlayout節點
# Date & Author   : 2015/07/16 by Hiko
##########################################################################
FUNCTION adzp166_get_mainlayout(p_doc, p_tag)
   DEFINE p_doc xml.DomDocument,
          p_tag STRING
   DEFINE list_node    xml.DomNodeList,
          li_idx       SMALLINT,
          lnode_item   xml.DomNode,
          lnode_target xml.DomNode

   LET list_node = p_doc.getElementsByTagName(p_tag)
   FOR li_idx=1 TO list_node.getCount()
      LET lnode_item = list_node.getItem(li_idx)
      IF lnode_item.getAttribute("name")="mainlayout" THEN
         LET lnode_target = lnode_item
         EXIT FOR
      END IF
   END FOR

   RETURN lnode_target
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 解析多語言檔(str)
# Input parameter : p_str_path 多語言檔(str)路徑
# Return code     : void
# Date & Author   : 2015/07/17 by Hiko
##########################################################################
PRIVATE FUNCTION adzp166_parse_str(p_str_path)
   DEFINE p_str_path STRING
   DEFINE ch_str       base.Channel,
          ls_line      STRING,
          li_equal_idx SMALLINT,
          ls_name      STRING,
          ls_text      STRING

   LET ch_str = base.Channel.create()
   CALL ch_str.openFile(p_str_path, "r")
   WHILE TRUE
      LET ls_line = ch_str.readLine() #ex:格式為"lbl_dzza001"="簽核等級"   
      IF ch_str.isEof() THEN
         EXIT WHILE
      END IF
   
      LET li_equal_idx = ls_line.getIndexOf("=", 1)
      IF li_equal_idx>0 THEN
         LET ls_name = ls_line.subString(1, li_equal_idx-1) #ex:"lbl_dzza001"
         LET ls_name = ls_name.trim() #ex:"lbl_dzza001"(去除雙引號兩邊的空白)
         LET ls_name = ls_name.subString(2, ls_name.getLength()-1) #ex:lbl_dzza001
         LET ls_name = ls_name.trim() #去除名稱兩邊的空白.
         LET ls_text = ls_line.subString(li_equal_idx+1, ls_line.getLength())
         LET ls_text = ls_text.trim() #ex:"簽核等級"(去除雙引號兩邊的空白)
         LET ls_text = ls_text.subString(2, ls_text.getLength()-1) #ex:簽核等級
         IF NOT gobj_str.has(ls_name) THEN
            CALL gobj_str.put(ls_name, ls_text)
         END IF
      END IF
   END WHILE
   CALL ch_str.close()
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 解析T100畫面檔(4fd)
# Input parameter : p_role_scene 分鏡節點
#                 : p_role_parent 分鏡的父項節點
#                 : p_node_widget 4fd控件
#                 : p_pos_x 子項起始posX
#                 : p_pos_y 子項起始posY
# Return code     : void
# Date & Author   : 2015/07/16 by Hiko
# Memo            : 1.遞迴的時候, 物件參數若有不同含意則需要以新的物件來處理, 以避免將舊的物件覆蓋而造成判斷上的錯誤.
#                 : 2.容器控件的w/h最後會由其子項累加的控件所覆寫.
##########################################################################
FUNCTION adzp166_parse_4fd(p_role_scene, p_role_parent, p_node_widget, p_start_x, p_start_y)
   DEFINE p_role_scene  xml.DomNode,
          p_role_parent xml.DomNode, #這是為了累加計算的容器.
          p_node_widget xml.DomNode,
          p_start_x     SMALLINT,
          p_start_y     SMALLINT
   DEFINE ls_tag           STRING,
          ls_name          STRING,
          ls_text_key      STRING,
          ls_text          STRING,
          ls_field_type    STRING,
          ls_table_name    STRING,
          li_x             SMALLINT,
          li_y             SMALLINT,
          li_w             SMALLINT,
          li_h             SMALLINT,
          ls_bound         STRING,
          lrole_node       xml.DomNode,
          ls_role          STRING,
          lnode_font       xml.DomNode #LabelRole必須要有Font屬性. 
   #底下是為了處理Page的變數.
   DEFINE lnode_data_model xml.DomNode,
          lnode_text       xml.DomNode,
          ls_page_str      STRING,
          lrole_scene      xml.DomNode,
          ls_scene_name    STRING 
   #底下是為了處理RadioGroup和ComboBox的變數.
   DEFINE ls_orientation STRING,
          lnode_item     xml.DomNode,
          ls_item_name   STRING,
          ls_item_text   STRING,
          ls_items       STRING,
          ls_sql         STRING,
          li_idx         SMALLINT,
          la_gzcc DYNAMIC ARRAY OF RECORD
                  gzcc004  LIKE gzcc_t.gzcc004,
                  gzcbl004 LIKE gzcbl_t.gzcbl004
                  END RECORD,
          la_gzcb DYNAMIC ARRAY OF RECORD
                  dzep011  LIKE dzep_t.dzep011,
                  gzcb002  LIKE gzcb_t.gzcb002,
                  gzcbl004 LIKE gzcbl_t.gzcbl004
                  END RECORD 
   #底下是為了處理Table的變數.
   DEFINE lnode_cols     xml.DomNode,
          lnode_col      xml.DomNode,
          li_model_idx   SMALLINT,
          lnode_rows     xml.DomNode,
          lnode_row      xml.DomNode,
          lnode_row_item xml.DomNode,
          ls_row_item    STRING,
          li_col_cnt     SMALLINT, #計算Table的欄位數.
          li_tbl_idx     SMALLINT, #標記同一個Table name但不同TabelRole. 預設從2開始.
          ls_tbl_idx     STRING    #將數字轉成字串.
   #底下是為了ButtonEdit處理的變數.
   DEFINE ls_btn_name STRING,
          lrole_btn   xml.DomNode

   LET li_tbl_idx = 1 #等li_col_cnt\20的時候要換TableRole, 這時候才累加.
   WHILE (p_node_widget IS NOT NULL)
      LET ls_tag = p_node_widget.getLocalName()
      LET ls_name = p_node_widget.getAttribute("name")
      LET ls_field_type = p_node_widget.getAttribute("fieldType")

      IF ls_field_type="TABLE_COLUMN" THEN
         LET ls_name = p_node_widget.getAttribute("colName")
         LET ls_table_name = p_node_widget.getAttribute("sqlTabName")
      END IF

      #160422-00002 : 將text與title的取得順序顛倒即可.
      IF p_node_widget.hasAttribute("title") THEN
         LET ls_text_key = p_node_widget.getAttribute("title")
      ELSE
         IF p_node_widget.hasAttribute("text") THEN
            LET ls_text_key = p_node_widget.getAttribute("text")
         END IF
      END IF

      LET ls_text = gobj_str.get(ls_text_key)

      #將4fd的位置和大小轉換為分鏡格線像素:位置都乘以10,寬度乘以10,高度乘以20.
      IF p_node_widget.hasAttribute("posX") THEN
         LET li_x = p_node_widget.getAttribute("posX")
         LET li_x = li_x * gi_multip_x
      ELSE
         LET li_x = 0
      END IF

      IF p_node_widget.hasAttribute("posY") THEN
         LET li_y = p_node_widget.getAttribute("posY")
         LET li_y = li_y * gi_multip_y
      ELSE
         LET li_y = 0
      END IF

      IF p_node_widget.hasAttribute("gridWidth") THEN
         LET li_w = p_node_widget.getAttribute("gridWidth")
         LET li_w = li_w * gi_multip_w
      ELSE
         LET li_w = 0
      END IF

      IF p_node_widget.hasAttribute("gridHeight") THEN
         LET li_h = p_node_widget.getAttribute("gridHeight")
         LET li_h = li_h * gi_multip_h
      ELSE
         LET li_h = 0
      END IF

      LET li_x = p_start_x + li_x #對應分鏡的絕對X軸.
      LET li_y = p_start_y + li_y #對應分鏡的絕對Y軸.

      #父項控件若為TableRole的話, 則X軸/Y軸/控件寬度得微調. 另外一個Table最多呈現20個控件, 超過就再建立另一個TableRole.
      IF p_role_parent.getAttribute("role")="TableRole" THEN
         LET li_x = gobj_tbl_x.get(gs_curr_table) #X軸重新取得上次控件的x+w.
         LET li_y = li_y + gi_multip_h #因為要在Table title的下方產生控件, 所以Y軸要增加title的高度.
         
         IF li_w>100 THEN #寬度最大為100
            LET li_w = 100
         END IF

         LET li_h = gi_multip_h #高度就固定, 避免格式出錯.

         LET li_col_cnt = li_col_cnt + 1 #累加Table的欄位數.
      END IF

      IF FGL_GETENV("T100DEBUG")="9" THEN
         DISPLAY "tag=",ls_tag
         DISPLAY "name=",ls_name
         DISPLAY "text=",ls_text
         DISPLAY "p_start_x=",p_start_x
         DISPLAY "p_start_y=",p_start_y
         DISPLAY "li_x=",li_x
         DISPLAY "li_y=",li_y
         DISPLAY "li_w=",li_w
         DISPLAY "li_h=",li_h
      END IF
 
      #父項控件若為TableRole的話, 則要設定columns/rows.
      IF p_role_parent.getAttribute("role")="TableRole" THEN
         LET lnode_data_model = p_role_parent.getFirstChildElement()
         LET lnode_cols = lnode_data_model.getFirstChildElement()
         LET li_model_idx = lnode_cols.getChildrenCount() #160504-00023:增加節點之前先算出columns有多少子節點, 當作modelIndex的值.
         LET lnode_col = lnode_cols.appendChildElement("column")
         CALL lnode_col.setAttribute("width", li_w)
         CALL lnode_col.setAttribute("modelIndex", li_model_idx) #160504-00023
         CALL lnode_col.appendchild(gdoc_root.createTextNode(ls_text)) #建立節點<column>title</column>

         LET lnode_rows = lnode_cols.getNextSiblingElement()
         LET lnode_row = lnode_rows.getFirstChildElement()
         LET lnode_row_item = lnode_row.getFirstChild() #因為是TextNode,所以不能取得getFirstChildElement().
         IF cl_null(ls_row_item) THEN
            LET ls_row_item = "nbsp;"
         ELSE
            LET ls_row_item = lnode_row_item.getNodeValue(),",nbsp;" 
         END IF
         CALL lnode_row_item.setNodeValue(ls_row_item)
      END IF

      #除了容器控件外, 所有控件都要重新計算父項的w/h.
      IF NOT (ls_tag.equals("HBox") OR ls_tag.equals("VBox") OR ls_tag.equals("Grid") OR
              ls_tag.equals("Folder") OR ls_tag.equals("Page") OR ls_tag.equals("Table") OR ls_tag.equals("Group") OR
              ls_tag.equals("RadioGroup")) THEN #RadioGroup是在建立Role的過程中就重新計算過了, 所以這裡不可以重複計算.
         CALL adzp166_reset_parent_bound(p_role_parent, li_x, li_y, li_w, li_h)
      END IF
 
      CASE
         WHEN ls_tag.equals("HBox") OR ls_tag.equals("VBox") OR ls_tag.equals("Grid") #排版容器就找其下的子節點.
            IF p_node_widget.getAttribute("name")<>"GridT_quantity" THEN #資料筆數的顯現區塊不需要解析.
               CALL adzp166_parse_4fd(p_role_scene, p_role_parent, p_node_widget.getFirstChildElement(), li_x, li_y) #遞迴
            END IF
         WHEN ls_tag.equals("Folder")
            #為了判斷page是否為folder的第一個page, 所以要紀錄目前的folder名稱.
            LET gs_curr_folder = ls_name
            CALL gobj_parent.put(ls_name, p_role_parent.getAttribute("name"))

            CALL adzp166_create_role(p_role_scene, "TabbedPaneRole", gs_curr_folder, li_x, li_y, 0, 0) RETURNING lrole_node
            LET lnode_data_model = lrole_node.appendChildElement("DataModel")

            CALL adzp166_set_spec(lrole_node) #設定SA規格.

            CALL adzp166_parse_4fd(p_role_scene, lrole_node, p_node_widget.getFirstChildElement(), (li_x+gi_multip_x), (li_y+(20+10))) #遞迴 #為了編排美觀問題, Folder底下的X軸/Y軸都做了起始位置的微調.
         WHEN ls_tag.equals("Page")
            IF gobj_folder.get(gs_curr_folder) IS NULL THEN
               #表示這是folder的第一個page.
               CALL gobj_folder.put(gs_curr_folder, ls_name) #f1,p1
               CALL gobj_parent.put(ls_name, p_role_parent.getAttribute("name"))
               LET lnode_data_model = p_role_parent.getFirstChildElement()
               LET ls_page_str = "(",ls_text,")"
               CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_page_str)) #建立節點<DataModel>(p1)</DataModel>

               CALL adzp166_parse_4fd(p_role_scene, p_role_parent, p_node_widget.getFirstChildElement(), p_start_x, p_start_y) #遞迴 
            ELSE #gobj_folder.get("f1")="p1"<>"p2"
               LET lnode_data_model = p_role_parent.getFirstChildElement()
               LET lnode_text = lnode_data_model.getFirstChild() #因為是TextNode,所以不能取得getFirstChildElement().
               LET ls_page_str = lnode_text.getNodeValue() 
               LET ls_page_str = ls_page_str.subString(2, ls_page_str.getLength()-1) #去除兩邊的括號.
               LET ls_page_str = "(",ls_page_str,",",ls_text,")" #最後再補上兩邊的括號. 
               CALL lnode_text.setNodeValue(ls_page_str) #增加頁籤:<DataModel>(p1,p2)</DataModel>

               #這裡一定是不同的Page, 而不同的Page一定是不同的分鏡, 且不需要累加其長寬與位置資料.
               LET lrole_scene = gnode_sco.appendChildElement("Scene")
               LEt ls_scene_name = ls_name,"(",gs_curr_folder,")(",ls_text,")"
               CALL lrole_scene.setAttribute("name", ls_scene_name)
               CALL lrole_scene.setAttribute("id", security.RandomGenerator.CreateUUIDString()) #GUID
               CALL lrole_scene.setAttribute("size", "(0,0)")
 
               CALL gobj_parent.put(ls_name, lrole_scene.getAttribute("name"))

               CALL adzp166_create_role(lrole_scene, "TabbedPaneRole", ls_name, 0, 0, 0, 0) RETURNING lrole_node
               LET lnode_data_model = lrole_node.appendChildElement("DataModel")
               LET ls_page_str = "(",ls_text,")"
               CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_page_str))

               CALL adzp166_set_spec(lrole_node) #設定SA規格.

               CALL adzp166_parse_4fd(lrole_scene, lrole_node, p_node_widget.getFirstChildElement(), gi_multip_x, (20+10)) #遞迴 #新的Page所組成的Folder, 起始位置得加上Folder的顯現高度, 再加上10.
            END IF
         WHEN ls_tag.equals("Table")
            LET gs_curr_table = ls_name
            CALL gobj_tbl_x.put(gs_curr_table, li_x) #新的Table就初始化.
            CALL gobj_parent.put(ls_name, p_role_parent.getAttribute("name"))
            CALL adzp166_create_role(p_role_scene, "TableRole", ls_name, li_x, li_y, 0, li_h) RETURNING lrole_node
            LET lnode_data_model = lrole_node.appendChildElement("DataModel")
            LET lnode_cols = lnode_data_model.appendChildElement("columns")
            CALL lnode_cols.setAttribute("height", gi_multip_h)
            LET lnode_rows = lnode_data_model.appendChildElement("rows")
            CALL lnode_rows.setAttribute("height", gi_multip_h)
            LET lnode_row = lnode_rows.appendChildElement("row") #解析只需要一個列的空白資料即可.
            CALL lnode_row.appendchild(gdoc_root.createTextNode("")) #建立節點<row></row>

            CALL adzp166_set_spec(lrole_node) #設定SA規格.

            CALL adzp166_parse_4fd(p_role_scene, lrole_node, p_node_widget.getFirstChildElement(), li_x, li_y) #遞迴
         WHEN ls_tag.equals("Group")
            CALL gobj_parent.put(ls_name, p_role_parent.getAttribute("name"))
            CALL adzp166_create_role(p_role_scene, "PanelRole", ls_name, li_x, li_y, 0, 0) RETURNING lrole_node
            CALL lrole_node.setAttribute("text", ls_text)
            CALL adzp166_set_spec(lrole_node) #設定SA規格.
            CALL adzp166_parse_4fd(p_role_scene, lrole_node, p_node_widget.getFirstChildElement(), li_x, li_y) #遞迴
         OTHERWISE
            #父項控件若為TableRole的話, 則將暫存X軸重新設定.
            IF p_role_parent.getAttribute("role")="TableRole" THEN
               CALL gobj_tbl_x.put(gs_curr_table, (li_x+li_w))
            END IF

            CALL gobj_parent.put(ls_name, p_role_parent.getAttribute("name"))
            CASE ls_tag
               WHEN "Image"        LET ls_role = "ImageRole"
               WHEN "FFImage"      LET ls_role = "ImageRole"
               WHEN "Edit"         LET ls_role = "TextFieldRole"
               WHEN "Button"       LET ls_role = "ButtonRole"
               WHEN "TextEdit"     LET ls_role = "TextAreaRole"
               WHEN "Label"        LET ls_role = "LabelRole"
               WHEN "FFLabel"      LET ls_role = "LabelRole"
               WHEN "ComboBox"     LET ls_role = "ComboBoxRole"
               WHEN "CheckBox"     LET ls_role = "CheckBoxRole"
               WHEN "RadioGroup"   LET ls_role = "RadioButtonRole" #要取得子項Item的name/text.
               WHEN "ButtonEdit"   LET ls_role = "TextFieldRole"   #其中一個控件是TextFieldRole.
               WHEN "DateEdit"     LET ls_role = "TextFieldRole"   #呈現方式類似ButtonEdit.
               WHEN "TimeEdit"     LET ls_role = "TextFieldRole"   #呈現方式類似ButtonEdit.
               WHEN "Tree"         LET ls_role = "TreeRole"        #其下的子控件就不特別處理.
               WHEN "WebComponent" LET ls_role = "HtmlRole"        
               OTHERWISE           LET ls_role = "TextFieldRole"   #不常用的控件都歸類於TextField.
                                   LET ls_text = ls_tag #若畫面上有看到控件的類型, 就表示沒有處理到的控件.
                                   DISPLAY "no mapping role : ",ls_tag
            END CASE

            #這段要建立物件, 不能移到下面.
            IF ls_role.equals("RadioButtonRole") THEN
               LET ls_orientation = p_node_widget.getAttribute("orientation")
               IF ls_field_type="TABLE_COLUMN" THEN
                  LET ls_sql = "SELECT dzep011,gzcb002,gzcbl004",
                               "  FROM dzep_t",
                               " INNER JOIN gzcb_t ON gzcb001=dzep011",
                               "  LEFT JOIN gzcbl_t ON gzcbl001=gzcb001 AND gzcbl002=gzcb002 AND gzcbl003='",g_lang,"'",
                               " WHERE dzep001 = '",ls_table_name,"'",
                               "   AND dzep002 = '",ls_name,"'",
                               " ORDER BY gzcb012"
                  PREPARE gzcb_prep FROM ls_sql
                  DECLARE gzcb_curs CURSOR FOR gzcb_prep
                  LET li_idx = 1
                  FOREACH gzcb_curs INTO la_gzcb[li_idx].*
                     LET ls_item_name = la_gzcb[li_idx].gzcb002,"(",ls_name,")"
                     LET ls_item_text = la_gzcb[li_idx].gzcbl004                      
                     CALL adzp166_create_role(p_role_scene, ls_role, ls_item_name, li_x, li_y, li_w, li_h) RETURNING lrole_node
                     CALL lrole_node.setAttribute("text", ls_item_text)

                     IF ls_orientation="vertical" THEN
                        LET li_y = li_y + gi_multip_y #每個Item往下疊加Y軸.
                     ELSE
                        LET li_x = li_x + li_w + gi_multip_x #每個Item往下疊加X軸.
                     END IF

                     LET li_idx = li_idx + 1
                  END FOREACH

                  CALL adzp166_reset_parent_bound(p_role_parent, li_x, li_y, li_w, li_h) #重新計算父項控件的寬度/高度.
               ELSE #非TABLE_COLUMN則取得其下Item.
                  LET lnode_item = p_node_widget.getFirstChildElement()
                  WHILE lnode_item IS NOT NULL
                     LET ls_item_name = lnode_item.getAttribute("name"),"(",ls_name,")"
                     LET ls_item_text = gobj_str.get(lnode_item.getAttribute("text"))
                     CALL adzp166_create_role(p_role_scene, ls_role, ls_item_name, li_x, li_y, li_w, li_h) RETURNING lrole_node
                     CALL lrole_node.setAttribute("text", ls_item_text)
                  
                     LET lnode_item = lnode_item.getNextSiblingElement() #取得下一個兄弟節點.
                     IF lnode_item IS NOT NULL THEN #表示還有下一個兄弟節點.
                        IF ls_orientation="vertical" THEN
                           LET li_y = li_y + gi_multip_y #每個Item往下疊加Y軸.
                        ELSE
                           LET li_x = li_x + li_w + gi_multip_x #每個Item往下疊加X軸.
                        END IF
                     ELSE #表示這是最後一個節點.
                        CALL adzp166_reset_parent_bound(p_role_parent, li_x, li_y, li_w, li_h) #重新計算父項控件的寬度/高度.
                     END IF
                  END WHILE
               END IF

               CALL adzp166_set_spec(lrole_node) #設定SA規格. #RadioGroup的規格就放在最後一個即可.
            ELSE #非RadioGroup的控件.
               #ButtonEdit/DateEdit/TimeEdit要拆成兩個role:TextFieldRole與ButtonRole
               IF ls_tag.equals("ButtonEdit") OR ls_tag.equals("DateEdit") OR ls_tag.equals("TimeEdit") THEN
                  #將原本的寬度再扣除ButtonRole的寬度.
                  CALL adzp166_create_role(p_role_scene, ls_role, ls_name, li_x, li_y, (li_w-20), li_h) RETURNING lrole_node
                  LET ls_btn_name = "btn","(",ls_name,")"
                  CALL adzp166_create_role(p_role_scene, "ButtonRole", ls_btn_name, (li_x+li_w-20), li_y, 20, li_h) RETURNING lrole_btn
                  IF ls_tag.equals("ButtonEdit") THEN
                     CALL lrole_btn.setAttribute("text", "P")
                  ELSE
                     CALL lrole_btn.setAttribute("text", "D")
                  END IF
               ELSE
                  CALL adzp166_create_role(p_role_scene, ls_role, ls_name, li_x, li_y, li_w, li_h) RETURNING lrole_node
               END IF

               CALL adzp166_set_spec(lrole_node) #設定SA規格.
            END IF

            IF ls_role.equals("ButtonRole") OR ls_role.equals("LabelRole") OR ls_role.equals("CheckBoxRole") THEN
               IF lrole_node.getAttribute("text") IS NULL THEN #可避免ButtonEdit的Button text又被覆寫掉.
                  IF ls_text IS NULL THEN #這樣可防止Label沒有text而在畫面上看不見.
                     LET ls_text = ls_name
                  END IF
                  CALL lrole_node.setAttribute("text", ls_text)
               END IF
            END IF
            
            IF ls_role.equals("LabelRole") THEN #LabelRole必須要有Font屬性.
               LET lnode_font = lrole_node.appendChildElement("Font")
               CALL lnode_font.setAttribute("name", "Dialog")    
               CALL lnode_font.setAttribute("style", "0" )    
               CALL lnode_font.setAttribute("size", "12")    
               CALL lnode_font.setAttribute("isUnderline", "false")    
            END IF

            #TextFieldRole顯現欄位代號.
            IF ls_role.equals("TextFieldRole") THEN
               IF ls_text.equals(ls_tag) THEN #表示OTHERWRISE.
                  CALL lrole_node.setAttribute("text", ls_text)
               ELSE
                  CALL lrole_node.setAttribute("text", ls_name)
               END IF
            END IF

            #TextAreaRole顯現欄位代號.
            IF ls_role.equals("TextAreaRole") THEN
               LET lnode_data_model = lrole_node.appendChildElement("DataModel")
               CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_name)) #建立節點<DataModel>欄位代號</DataModel>
            END IF

            #TreeRole顯現欄位代號.
            IF ls_role.equals("TreeRole") THEN
               LET lnode_data_model = lrole_node.appendChildElement("DataModel")
               LET ls_text = "(root,",ls_name,",//)" #重設ls_text.
               CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_text)) #建立節點<DataModel>(root,欄位代號,//)</DataModel>
            END IF

            #Table的顯現控件就呈現欄位代號. TextFieldRole就不分是否是在Table內都呈現.
            IF p_role_parent.getAttribute("role")="TableRole" THEN
               IF ls_role.equals("CheckBoxRole") THEN
                  CALL lrole_node.setAttribute("text", ls_name)
               END IF
            END IF

            IF ls_role.equals("ComboBoxRole") THEN
               LET lnode_data_model = lrole_node.appendChildElement("DataModel")
               LET ls_items = NULL
               IF ls_field_type="TABLE_COLUMN" THEN
                  IF ls_name.getIndexOf("stus", 1)>0 THEN #若是xxxstus欄位(TABLE_COLUMN), 則要抓SCC.
                     LET ls_sql = "SELECT gzcc004,gzcbl004",
                                  "  FROM gzcc_t",
                                  "  LEFT JOIN gzcbl_t ON gzcbl001=gzcc003 AND gzcbl002=gzcc004 AND gzcbl003='",g_lang,"'",
                                  " WHERE gzcc001 = '",ls_table_name,"'",
                                  "   AND gzccstus = 'Y'",
                                  " ORDER BY gzcc006"
                     PREPARE gzcc_prep FROM ls_sql
                     DECLARE gzcc_curs CURSOR FOR gzcc_prep
                     LET li_idx = 1
                     FOREACH gzcc_curs INTO la_gzcc[li_idx].*
                        LET ls_item_text = la_gzcc[li_idx].gzcc004,".",la_gzcc[li_idx].gzcbl004
                        IF ls_items IS NULL THEN
                           LET ls_items = ls_item_text
                        ELSE
                           LET ls_items = ls_items,",",ls_item_text
                        END IF
                        
                        LET li_idx = li_idx + 1
                     END FOREACH
                  
                     LET ls_items = "(",ls_items,")"
                     CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_items))
                  ELSE #一般欄位要抓取dzep011.
                     LET ls_sql = "SELECT dzep011,gzcb002,gzcbl004",
                                  "  FROM dzep_t",
                                  " INNER JOIN gzcb_t ON gzcb001=dzep011",
                                  "  LEFT JOIN gzcbl_t ON gzcbl001=gzcb001 AND gzcbl002=gzcb002 AND gzcbl003='",g_lang,"'",
                                  " WHERE dzep001 = '",ls_table_name,"'",
                                  "   AND dzep002 = '",ls_name,"'",
                                  " ORDER BY gzcb012"
                     PREPARE gzcb_prep2 FROM ls_sql
                     DECLARE gzcb_curs2 CURSOR FOR gzcb_prep2
                     LET li_idx = 1
                     FOREACH gzcb_curs2 INTO la_gzcb[li_idx].*
                        LET ls_item_text = la_gzcb[li_idx].gzcb002,".",la_gzcb[li_idx].gzcbl004
                        IF ls_items IS NULL THEN
                           LET ls_items = ls_item_text
                        ELSE
                           LET ls_items = ls_items,",",ls_item_text
                        END IF
                        
                        LET li_idx = li_idx + 1
                     END FOREACH
                  
                     LET ls_items = "(",ls_items,")"
                     CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_items))
                  END IF
               ELSE #非TABLE_COLUMN則取得其下Item.
                  LET lnode_item = p_node_widget.getFirstChildElement()
                  WHILE lnode_item IS NOT NULL
                     LET ls_item_name = lnode_item.getAttribute("name")
                     LET ls_item_text = ls_item_name,".",gobj_str.get(lnode_item.getAttribute("text"))
                     IF ls_items IS NULL THEN
                        LET ls_items = ls_item_text
                     ELSE
                        LET ls_items = ls_items,",",ls_item_text
                     END IF

                     LET lnode_item = lnode_item.getNextSiblingElement() #取得下一個兄弟節點.
                  END WHILE

                  LET ls_items = "(",ls_items,")"
                  CALL lnode_data_model.appendchild(gdoc_root.createTextNode(ls_items))
               END IF
            END IF
      END CASE

      LET p_node_widget = p_node_widget.getNextSiblingElement() #取得下一個兄弟節點.

      IF p_node_widget IS NULL THEN
         #父項控件若為TableRole的話, 則在最後需要將row的內容加上左右括號.
         IF p_role_parent.getAttribute("role")="TableRole" THEN
            #因為上面的流程已經取得ls_row_item, 所以這邊直接取得即可.
            LET ls_row_item = "(",ls_row_item,")"
            CALL lnode_row_item.setNodeValue(ls_row_item)
         END IF
      END IF

      IF p_role_parent.getAttribute("role")="TableRole" THEN
         IF (li_col_cnt MOD 20)=0 THEN #判斷Table欄位是否已經達到20個.
            LET li_tbl_idx = li_tbl_idx + 1
            LET ls_tbl_idx = li_tbl_idx
            LET ls_tbl_idx = ls_tbl_idx.trim()
            LET gs_curr_table = ls_name,"(",ls_tbl_idx,")"
            CALL gobj_tbl_x.put(gs_curr_table, p_start_x) #新的Table就初始化.
            #CALL gobj_parent.put(ls_name, p_role_parent.getAttribute("name")) #注意:這和Table段落不同, 額外長出來的TableRole就不需要再重設父項的長度/寬度了.
            LET p_start_y = p_start_y + (3*gi_multip_y) #Y軸位置就往下位移3倍的高度.
            #額外的TableRole高度就固定為3個gi_multip_y.
            CALL adzp166_create_role(p_role_scene, "TableRole", gs_curr_table, p_start_x, p_start_y, 0, (3*gi_multip_y)) RETURNING lrole_node
            LET lnode_data_model = lrole_node.appendChildElement("DataModel")
            LET lnode_cols = lnode_data_model.appendChildElement("columns")
            CALL lnode_cols.setAttribute("height", gi_multip_h)
            LET lnode_rows = lnode_data_model.appendChildElement("rows")
            CALL lnode_rows.setAttribute("height", gi_multip_h)
            LET lnode_row = lnode_rows.appendChildElement("row") #解析只需要一個列的空白資料即可.
            CALL lnode_row.appendchild(gdoc_root.createTextNode("")) #建立節點<row></row>

            CALL adzp166_set_spec(lrole_node) #設定SA規格.

            LET p_role_parent = lrole_node #因為還在WHILE回圈內, 所以得要覆寫父項控件.
         END IF
      END IF
   END WHILE
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立分鏡的控件
# Input parameter : p_node_scene 分鏡節點
#                 : p_role 控件角色
#                 : p_name 控件名稱
#                 : p_x 控件X軸
#                 : p_y 控件Y軸
#                 : p_w 控件寬度
#                 : p_h 控件高度
# Return code     : void
# Date & Author   : 2015/07/16 by Hiko
##########################################################################
FUNCTION adzp166_create_role(p_node_scene, p_role, p_name, p_x, p_y, p_w, p_h)
   DEFINE p_node_scene xml.DomNode,
          p_role       STRING,
          p_name       STRING,
          p_x          SMALLINT,
          p_y          SMALLINT,
          p_w          SMALLINT,
          p_h          SMALLINT 
   DEFINE lrole_node xml.DomNode,
          ls_bound   STRING 

   LET lrole_node = p_node_scene.appendChildElement("Role")
   CALL lrole_node.setAttribute("role", p_role)
   CALL lrole_node.setAttribute("name", p_name)
   CALL adzp166_int2bound(p_x, p_y, p_w, p_h) RETURNING ls_bound
   CALL lrole_node.setAttribute("bound", ls_bound)

   RETURN lrole_node
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 設定分鏡控件的SA規格
# Input parameter : p_role 分鏡控件
# Return code     : void
# Date & Author   : 2015/07/30 by Hiko
##########################################################################
FUNCTION adzp166_set_spec(p_role)
   DEFINE p_role xml.DomNode
   DEFINE ls_name         STRING,
          ls_spec         STRING,
          ls_temp_name    STRING,
          li_key_idx      SMALLINT,
          li_char_idx     SMALLINT,
          ls_char         STRING,
          ls_main_spec    STRING,
          ls_process_spec STRING,
          lnode_text      xml.DomNode,
          lnode_list      xml.DomNode,
          lnode_item      xml.DomNode 

   LET ls_name = p_role.getAttribute("name")
   IF ls_name.equals("MAIN") OR ls_name.equals("PROCESS") THEN
      LET ls_temp_name = ls_name #這是為了最後要判斷規格的歸屬.
      LET ls_name = "ALL" #因為MAIN與PROCESS的規格是合併於ALL, 中間以多個"==========="隔開.
   END IF

   LET ls_spec = gobj_spec.get(ls_name)
   IF NOT cl_null(ls_spec) THEN
      IF ls_name.equals("ALL") THEN
         LET li_key_idx = ls_spec.getIndexOf("==================================================", 1) #實際上有92個'=', 但為了避免被人為異動, 所以先找前面50個, 然後再逐個比對到最後一個.
         IF li_key_idx>0 THEN
            LET ls_main_spec = ls_spec.subString(1, li_key_idx-1)
            LET li_char_idx = li_key_idx+50 #從第51個開始找.
            LET ls_char = ls_spec.getCharAt(li_char_idx)
            WHILE ls_char.equals("=")
               LET li_char_idx = li_char_idx + 1
               LET ls_char = ls_spec.getCharAt(li_char_idx)
            END WHILE
      
            LET ls_process_spec = ls_spec.subString(li_char_idx, ls_spec.getLength())
         END IF

         IF ls_temp_name.equals("MAIN") THEN
            LET ls_spec = ls_main_spec
         ELSE #PROCESS
            LET ls_spec = ls_process_spec
         END IF
      END IF

      LET lnode_text = p_role.appendChildElement("TextContent")
      LET lnode_list = lnode_text.appendChildElement("list")
      CALL lnode_list.setAttribute("type", "5")
      LET lnode_item = lnode_list.appendChildElement("item")
      
      CALL lnode_item.appendchild(gdoc_root.createTextNode(ls_spec))
   END IF
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 重新設定分鏡父項容器的大小
# Input parameter : p_role_parent 父項容器
#                 : p_x 來源x軸
#                 : p_y 來源y軸
#                 : p_w 來源寬度
#                 : p_h 來源高度
# Return code     : VOID
# Date & Author   : 2015/07/23 by Hiko
##########################################################################
FUNCTION adzp166_reset_parent_bound(p_role_parent, p_x, p_y, p_w, p_h)
   DEFINE p_role_parent xml.DomNode,
          p_x           SMALLINT,
          p_y           SMALLINT,
          p_w           SMALLINT,
          p_h           SMALLINT
   DEFINE ls_bound           STRING,
          ls_size            STRING,
          li_parent_x        SMALLINT,
          li_parent_y        SMALLINT,
          li_parent_w        SMALLINT,
          li_parent_h        SMALLINT,
          li_parent_temp_w   SMALLINT,
          li_parent_temp_h   SMALLINT,
          li_child_temp_w    SMALLINT,
          li_child_temp_h    SMALLINT,
          li_parent_differ_w SMALLINT, 
          li_parent_differ_h SMALLINT 
   DEFINE ls_grandfather    STRING,
          lrole_grandfather xml.DomNode
   
   IF p_role_parent.hasAttribute("bound") THEN
      CALL adzp166_bound2int(p_role_parent) RETURNING li_parent_x,li_parent_y,li_parent_w,li_parent_h
   ELSE
      CALL adzp166_size2int(p_role_parent) RETURNING li_parent_w,li_parent_h
   END IF
   #範例說明:父項x=20,y=20,w=100,h=20; 子項(重設後)x=30,y=30,w=150,h=20.
   LET li_parent_temp_w = li_parent_x + li_parent_w #20+100=120
   LET li_parent_temp_h = li_parent_y + li_parent_h #20+ 20= 40
   LET li_child_temp_w = p_x + p_w #30+150=180
   LET li_child_temp_h = p_y + p_h #30+ 20= 50
   LET li_parent_differ_w = li_child_temp_w - li_parent_temp_w #180-120=60
   #以4fd轉分鏡位置大小的規則(至少*10)來看, <0至少就是<10. 所以這是正常, 不用調整父項寬度.
   IF li_parent_differ_w>=0 THEN
      LET li_parent_w = li_parent_w + li_parent_differ_w + gi_multip_x #100+60+10=170, 再加上li_parent_x的話就變成190, 剛好比li_child_temp_w多10. 
   END IF
   LET li_parent_differ_h = li_child_temp_h - li_parent_temp_h #50-40=10
   IF li_parent_differ_h>=0 THEN
      LET li_parent_h = li_parent_h + li_parent_differ_h + gi_multip_y #20+10+10=40, 再加上li_parent_y的話就變成60, 剛好比li_child_temp_h多10.
   END IF

   #父項控件若為TableRole的話不須特別處理高度問題, 因為Table內控件的Y軸都不會改變, 所以不會影響Table的高度.

   IF p_role_parent.hasAttribute("bound") THEN
      CALL adzp166_int2bound(li_parent_x, li_parent_y, li_parent_w, li_parent_h) RETURNING ls_bound
      CALL p_role_parent.setAttribute("bound", ls_bound)
   ELSE
      CALL adzp166_int2size(li_parent_w, li_parent_h) RETURNING ls_size
      CALL p_role_parent.setAttribute("size", ls_size)
   END IF

   #判斷累加的寬度是否超過最大限制. 高度超出的機率非常低, 所以就不控制了.
   IF (li_parent_x+li_parent_w)>SCENE_MAX_WIDTH THEN
      LET gb_regen_w = TRUE
   END IF

   LET ls_grandfather = gobj_parent.get(p_role_parent.getAttribute("name"))
   CALL adzp166_get_sco_widget("Role", ls_grandfather) RETURNING lrole_grandfather
   IF lrole_grandfather IS NULL THEN
      CALL adzp166_get_sco_widget("Scene", ls_grandfather) RETURNING lrole_grandfather
   END IF

   IF lrole_grandfather IS NOT NULL THEN #這判斷不可以和上面的判斷合併.
      CALL adzp166_reset_parent_bound(lrole_grandfather, li_parent_x, li_parent_y, li_parent_w, li_parent_h)
   END IF
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 將分鏡位置大小格式(bound)轉為int
# Input parameter : p_role 分鏡容器
# Return          : SMALLINT x軸
#                 : SMALLINT y軸
#                 : SMALLINT 寬度
#                 : SMALLINT 高度
# Date & Author   : 2015/07/23 by Hiko
##########################################################################
FUNCTION adzp166_bound2int(p_role)
   DEFINE p_role xml.DomNode 
   DEFINE ltok_bound  base.StringTokenizer,
          ls_bound    STRING,
          li_cnt      SMALLINT,
          ls_token    STRING,
          li_x        SMALLINT,
          li_y        SMALLINT,
          li_w        SMALLINT,
          li_h        SMALLINT 
 
   LET ls_bound = p_role.getAttribute("bound") #格式為(x,y,w,h)
   LET li_cnt = 1
   LET ltok_bound = base.StringTokenizer.create(ls_bound, ",")
   WHILE ltok_bound.hasMoreTokens()
      LET ls_token = ltok_bound.nextToken()
      CASE li_cnt
         WHEN 1 LET li_x = ls_token.subString(2, ls_token.getLength())
         WHEN 2 LET li_y = ls_token
         WHEN 3 LET li_w = ls_token
         WHEN 4 LET li_h = ls_token.subString(1, ls_token.getLength()-1)
      END CASE
   
      LET li_cnt = li_cnt + 1
   END WHILE 

   RETURN li_x,li_y,li_w,li_h
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 將位置/大小轉成分鏡格式(bound)
# Input parameter : p_x 控件X軸
#                 : p_y 控件Y軸
#                 : p_w 控件寬度
#                 : p_h 控件高度
# Return code     : STRING 分鏡控件的大小位置格式
# Date & Author   : 2015/07/22 by Hiko
##########################################################################
FUNCTION adzp166_int2bound(p_x, p_y, p_w, p_h)
   DEFINE p_x STRING,
          p_y STRING,
          p_w STRING,
          p_h STRING
   DEFINE ls_bound STRING

   LET p_x = p_x.trim()
   LET p_y = p_y.trim()
   LET p_w = p_w.trim()
   LET p_h = p_h.trim()
   LET ls_bound = "(",p_x,",",p_y,",",p_w,",",p_h,")"        

   RETURN ls_bound
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 將分鏡位置大小格式(size)轉為int
# Input parameter : p_role 分鏡容器
# Return          : SMALLINT 寬度
#                 : SMALLINT 高度
# Date & Author   : 2015/07/29 by Hiko
##########################################################################
FUNCTION adzp166_size2int(p_role)
   DEFINE p_role xml.DomNode 
   DEFINE ltok_size base.StringTokenizer,
          ls_size   STRING,
          li_cnt    SMALLINT,
          ls_token  STRING,
          li_w      SMALLINT,
          li_h      SMALLINT 
 
   LET ls_size = p_role.getAttribute("size") #格式為(w,h)
   LET li_cnt = 1
   LET ltok_size = base.StringTokenizer.create(ls_size, ",")
   WHILE ltok_size.hasMoreTokens()
      LET ls_token = ltok_size.nextToken()
      CASE li_cnt
         WHEN 1 LET li_w = ls_token.subString(2, ls_token.getLength())
         WHEN 2 LET li_h = ls_token.subString(1, ls_token.getLength()-1)
      END CASE
   
      LET li_cnt = li_cnt + 1
   END WHILE 

   RETURN li_w,li_h
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 將大小轉成分鏡格式(size)
# Input parameter : p_w 控件寬度
#                 : p_h 控件高度
# Return code     : STRING 分鏡控件的大小格式
# Date & Author   : 2015/07/29 by Hiko
##########################################################################
FUNCTION adzp166_int2size(p_w, p_h)
   DEFINE p_w STRING,
          p_h STRING
   DEFINE ls_size STRING

   LET p_w = p_w.trim()
   LET p_h = p_h.trim()
   LET ls_size = "(",p_w,",",p_h,")"        

   RETURN ls_size
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得分鏡檔控件節點
# Input parameter : p_tag 目標物件的標籤(Role/Scene)
#                 : p_name 控件名稱
# Return code     : xml.DomNode 分鏡控件節點
# Date & Author   : 2015/07/23 by Hiko
##########################################################################
FUNCTION adzp166_get_sco_widget(p_tag, p_name)
   DEFINE p_tag  STRING,
          p_name STRING
   DEFINE list_node    xml.DomNodeList,
          li_idx       SMALLINT,
          lnode_item   xml.DomNode,
          lnode_target xml.DomNode 

   LET lnode_target = NULL
   LET list_node = gdoc_root.getElementsByTagName(p_tag)
   FOR li_idx=1 TO list_node.getCount()
      LET lnode_item = list_node.getItem(li_idx)
      IF lnode_item.getAttribute("name")=p_name THEN
         LET lnode_target = lnode_item
         EXIT FOR
      END IF
   END FOR

   RETURN lnode_target
END FUNCTION
