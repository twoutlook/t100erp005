#+ 程式版本......: T6 Version 1.00.00 Build-0340 at 13/01/31
#
#+ 程式代碼......: sadzp010_1
#+ 設計人員......: Hiko
#+ 修改歷程......: 2013/08/05 by Hiko : 移除gztw_t,gztx_t的程式段,改為gzcb_t,gzcbl_t.
#                : 2013/08/27 by Hiko : 增加tables.xml,datatypes.xml的產生.
#                : 2013/09/04 by Hiko : subroutines.xml的來源dzdastus從'Y'改抓取'4'
#                : 2013/09/05 by Hiko : checks.xml和zooms.xml支持多語言
#                : 2013/09/27 by Hiko : 1.新增code_sample.xml
#                                       2.註解CATCH與rename的cl_err_msg
#                : 2013/10/24 by Hiko : 程式串查清單改為取得gzzz_t
#                : 2013/11/21 by Hiko : 1.增加subinfo.xml(與subroutines.xml同時建立)
#                                       2.將原本取得元件多語言的方式(sadz_get_name)改為SQL JOIN,這樣比較快.
#                                       3.將原本取得SCC的方式改為SQL JOIN,這樣比較快.
#                : 2014/01/14 by Hiko : 增加樹狀型態的基本資料檔:tree_kind.xml
#                : 2014/03/11 by Hiko : 調整產生與回傳方式
#                : 2014/03/27 by Hiko : 1.增加程式樣版類型檔(code_template.xml)
#                                       2.增加標準標籤檔(std_label.xml)
#                : 2014/04/07 by Hiko : 開窗清單要剃除hard code(dzca006='Y')
#                : 2014/04/25 by Hiko : 因應效能調整
#                : 2014/08/15 by Hiko : 增加各語系的產生
#                : 2014/12/09 by Hiko : 移除元件其他資訊的產生:sadzp010_1_gen_subinfo_xml
#                : 2015/06/08 by Hiko : 1.hard code也是以r.q當作註冊來源
#                                       2.subroutines.xml的來源還原dzdastus='Y'的條件

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE gs_lang STRING, #2014/08/15 by Hiko
       gs_mta_path STRING

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 取得基礎資料的檔案數量
# Input parameter : none
# Return code     : SMALLINT 基礎資料的檔案數量
# Date & Author   : 2014/03/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_get_file_cnt()
   RETURN 11 #這是為了cl_progress_bar的進度表使用,若基礎檔案有增減,則要手動調整.
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生各語系的設計器相關基礎資料.
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/08/15 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_multi_lang_base_data()
   DEFINE lb_result BOOLEAN, 
          ls_err_msg STRING,
          lsb_err base.StringBuffer
   DEFINE ls_sql STRING,
          la_langs DYNAMIC ARRAY OF RECORD
                   lang LIKE gzzy_t.gzzy001
                   END RECORD,
          li_i SMALLINT

   LET lb_result = TRUE
   LET ls_err_msg = ""
   LET lsb_err = base.StringBuffer.create()

   #Begin:2014/08/15 by Hiko
   LET ls_sql = "SELECT gzzy001",
                 " FROM gzzy_t",
                " WHERE gzzystus='Y'",
                "ORDER BY gzzy001"
   PREPARE gzzy_prep FROM ls_sql
   DECLARE gzzy_curs CURSOR FOR gzzy_prep
   LET li_i = 1
   FOREACH gzzy_curs INTO la_langs[li_i].*
      LET li_i = li_i + 1
   END FOREACH
   CALL la_langs.deleteElement(li_i)
   #End:2014/08/15 by Hiko

   CALL cl_progress_ing("sadzp010_1_gen_checks_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_checks_xml() RETURNING lb_result,ls_err_msg      #校驗帶值設計資料檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_zooms_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_zooms_xml() RETURNING lb_result,ls_err_msg       #開窗設計資料檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_items_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_items_xml() RETURNING lb_result,ls_err_msg       #系統分類碼資料檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_prog_rel_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_prog_rel_xml() RETURNING lb_result,ls_err_msg    #格式串查設定檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_sub_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_sub_xml() RETURNING lb_result,ls_err_msg         #應用元件資訊檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_lib_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_lib_xml() RETURNING lb_result,ls_err_msg         #系統元件資訊檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_messages_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_messages_xml() RETURNING lb_result,ls_err_msg    #訊息資訊檔
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_code_sample_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_code_sample_xml() RETURNING lb_result,ls_err_msg #範本代碼檔 
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_tree_kind_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_tree_kind_xml() RETURNING lb_result,ls_err_msg   #樹狀結構類別檔 
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_code_template_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_code_template_xml() RETURNING lb_result,ls_err_msg   #程式樣版類別檔 
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR
   
   CALL cl_progress_ing("sadzp010_1_gen_std_label_xml")
   FOR li_i=1 TO la_langs.getLength()
      LET gs_lang = la_langs[li_i].lang CLIPPED
      LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)
      
      CALL sadzp010_1_gen_std_label_xml() RETURNING lb_result,ls_err_msg   #標準標籤檔 
      IF NOT lb_result THEN
         CALL lsb_err.append(ls_err_msg||"\n")
      END IF
   END FOR

   IF lsb_err.getLength()>0 THEN
      RETURN FALSE,lsb_err.toString()
   END IF

   RETURN TRUE,""
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生設計器相關基礎資料.
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/03/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_base_data()
   DEFINE lb_result BOOLEAN, 
          ls_err_msg STRING,
          lsb_err base.StringBuffer

   LET lb_result = TRUE
   LET ls_err_msg = ""
   LET lsb_err = base.StringBuffer.create()

   #CALL sadzp010_1_init_var()
   LET gs_lang = g_lang
   LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), gs_lang)

   CALL cl_progress_ing("sadzp010_1_gen_checks_xml")
   CALL sadzp010_1_gen_checks_xml() RETURNING lb_result,ls_err_msg      #校驗帶值設計資料檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_zooms_xml")
   CALL sadzp010_1_gen_zooms_xml() RETURNING lb_result,ls_err_msg       #開窗設計資料檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_items_xml")
   CALL sadzp010_1_gen_items_xml() RETURNING lb_result,ls_err_msg       #系統分類碼資料檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_prog_rel_xml")
   CALL sadzp010_1_gen_prog_rel_xml() RETURNING lb_result,ls_err_msg    #格式串查設定檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_sub_xml")
   CALL sadzp010_1_gen_sub_xml() RETURNING lb_result,ls_err_msg         #應用元件資訊檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_lib_xml")
   CALL sadzp010_1_gen_lib_xml() RETURNING lb_result,ls_err_msg         #系統元件資訊檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_messages_xml")
   CALL sadzp010_1_gen_messages_xml() RETURNING lb_result,ls_err_msg    #訊息資訊檔
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_code_sample_xml")
   CALL sadzp010_1_gen_code_sample_xml() RETURNING lb_result,ls_err_msg #範本代碼檔 
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_tree_kind_xml")
   CALL sadzp010_1_gen_tree_kind_xml() RETURNING lb_result,ls_err_msg   #樹狀結構類別檔 
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_code_template_xml")
   CALL sadzp010_1_gen_code_template_xml() RETURNING lb_result,ls_err_msg   #程式樣版類別檔 
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   CALL cl_progress_ing("sadzp010_1_gen_std_label_xml")
   CALL sadzp010_1_gen_std_label_xml() RETURNING lb_result,ls_err_msg   #標準標籤檔 
   IF NOT lb_result THEN
      CALL lsb_err.append(ls_err_msg||"\n")
   END IF

   IF lsb_err.getLength()>0 THEN
      RETURN FALSE,lsb_err.toString()
   END IF

   RETURN TRUE,""
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : void
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp010_1_init_var()
   LET gs_mta_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), g_lang)
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 檔案更名.
# Input parameter : p_file_path 檔案含路徑
#                 : p_file 檔名
# Return code     : BOOLEAN
# Date & Author   : 2013/09/05 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp010_1_rename(p_file_path, p_file)
   DEFINE p_file_path STRING,
          p_file STRING
   DEFINE ls_err_msg STRING #2014/03/11 by Hiko

   IF os.Path.exists(p_file_path) THEN
      IF NOT os.Path.rename(p_file_path, p_file_path||".bak") THEN
         #CALL cl_err_msg(NULL, "adz-00174", "rename"||"|"||p_file, 0) #2013/09/27 by Hiko
         #DISPLAY "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00174", gs_lang), "rename"||"|"||p_file)
         LET ls_err_msg = "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00174", gs_lang), "rename"||"|"||p_file)
         DISPLAY ls_err_msg
         RETURN FALSE,ls_err_msg
      END IF
   END IF
   
   RETURN TRUE,""
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{校驗帶值設計檔}(checks.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_checks_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx,li_i SMALLINT
   DEFINE la_checks DYNAMIC ARRAY OF RECORD #取得'校驗帶值資料表'的設定.
                    dzcd001 LIKE dzcd_t.dzcd001,
                    dzcd003 LIKE dzcd_t.dzcd003,
                    dzcd004 LIKE dzcd_t.dzcd004,
                    dzcd005 LIKE dzcd_t.dzcd005,
                    dzcdl003 LIKE dzcdl_t.dzcdl003,
                    dzce002 LIKE dzce_t.dzce002,
                    dzce004 LIKE dzce_t.dzce004,
                    dzcel004 LIKE dzcel_t.dzcel004 
                    END RECORD
   DEFINE ls_id STRING,
          ls_id_tmp STRING
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_check xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_checks_xml start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "checks.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "checks.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("checks")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get check verify and return setting"
      LET ls_sql = "SELECT dzcd001,dzcd003,dzcd004,dzcd005,dzcdl003,dzce002,dzce004,dzcel004", #2014/04/25 by Hiko
                    " FROM dzcd_t",
                    " LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002='",gs_lang,"'", #2013/09/05 by Hiko
                    " LEFT JOIN dzce_t ON dzce001=dzcd001",
                    " LEFT JOIN dzcel_t ON dzcel001=dzce001 AND dzcel002=dzce002 AND dzcel003='",gs_lang,"'", #2013/09/05 by Hiko
                   " ORDER BY dzcd001,dzce002"
      PREPARE dzcd_prep FROM ls_sql
      DECLARE dzcd_curs CURSOR FOR dzcd_prep
      LET li_idx = 1
      FOREACH dzcd_curs INTO la_checks[li_idx].*
         #Begin : 2014/04/25 by Hiko
         LET ls_id = la_checks[li_idx].dzcd001 CLIPPED
         IF NOT ls_id.equals(ls_id_tmp) THEN
            LET lnode_check = lnode_xml.appendChildElement("check")
            CALL lnode_check.setAttribute("id", ls_id)
            CALL lnode_check.setAttribute("desc", la_checks[li_idx].dzcdl003 CLIPPED)
            CALL lnode_check.setAttribute("msg", la_checks[li_idx].dzcd004 CLIPPED)
            LET lnode_child = ldoc_xml.createCDATASection(la_checks[li_idx].dzcd003)
            CALL lnode_check.appendChild(lnode_child)
            LET ls_id_tmp = ls_id
         END IF

         #取得校驗帶值參數設定.
         LET lnode_child = lnode_check.appendChildElement("param")
         CALL lnode_child.setAttribute("order", la_checks[li_idx].dzce002 CLIPPED)
         CALL lnode_child.setAttribute("name", "arg"||la_checks[li_idx].dzce004 CLIPPED)
         CALL lnode_child.setAttribute("desc", la_checks[li_idx].dzcel004 CLIPPED)
         #End : 2014/04/25 by Hiko

         LET li_idx = li_idx + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_checks_xml finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_checks_xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{開窗設計檔}(zooms.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_zooms_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx,li_i SMALLINT
   DEFINE la_zooms DYNAMIC ARRAY OF RECORD #取得'開窗資料表'的設定.
                   dzca001 LIKE dzca_t.dzca001,
                   dzca003 LIKE dzca_t.dzca003,
                   dzcal003 LIKE dzcal_t.dzcal003,
                   dzcb002 LIKE dzcb_t.dzcb002,
                   dzcb003 LIKE dzcb_t.dzcb003,
                   dzcbl004 LIKE dzcbl_t.dzcbl004
                   END RECORD
   DEFINE ls_id STRING,
          ls_id_tmp STRING
   DEFINE la_ui DYNAMIC ARRAY OF RECORD #取得'開窗畫面設計表'的設定.
                dzca001 LIKE dzca_t.dzca001,
                dzcc002 LIKE dzcc_t.dzcc002,
                dzcc003 LIKE dzcc_t.dzcc003,
                dzcc004 LIKE dzcc_t.dzcc004,
                dzcc005 LIKE dzcc_t.dzcc005,
                dzej003 LIKE dzej_t.dzej003
                END RECORD
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode,
          lst_node xml.DomNodeList
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_zoom xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_zooms_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "zooms.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "zooms.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("zooms")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get zoom setting"
      LET ls_sql = "SELECT dzca001,dzca003,dzcal003,dzcb002,dzcb003,dzcbl004", #2013/09/05 by Hiko
                    " FROM dzca_t",
                    " LEFT JOIN dzcal_t ON dzcal001=dzca001 AND dzcal002='",gs_lang,"'", #2013/09/05 by Hiko
                    " LEFT JOIN dzcb_t ON dzcb001=dzca001",
                    " LEFT JOIN dzcbl_t ON dzcbl001=dzcb001 AND dzcbl002=dzcb002 AND dzcbl003='",gs_lang,"'", #2013/09/05 by Hiko
                   #" WHERE dzca006<>'Y'", #2014/04/07 by Hiko:開窗清單要剃除hard code(dzca006='Y') #2015/06/08 by Hiko:hard code也是以r.q當作註冊來源
                   " ORDER BY dzca001,dzcb002"
      PREPARE dzca_prep FROM ls_sql
      DECLARE dzca_curs CURSOR FOR dzca_prep
      LET ls_sql = ""
      LET li_idx = 1
      FOREACH dzca_curs INTO la_zooms[li_idx].*
         LET ls_id = la_zooms[li_idx].dzca001 CLIPPED
         IF NOT ls_id.equals(ls_id_tmp) THEN
            LET lnode_zoom = lnode_xml.appendChildElement("zoom")
            CALL lnode_zoom.setAttribute("id", la_zooms[li_idx].dzca001 CLIPPED)
            CALL lnode_zoom.setAttribute("desc", la_zooms[li_idx].dzcal003 CLIPPED)
            LET lnode_child = ldoc_xml.createCDATASection(la_zooms[li_idx].dzca003)
            CALL lnode_zoom.appendChild(lnode_child)
            LET ls_id_tmp = ls_id
         END IF 
      
         #開窗參數設定.
         IF NOT cl_null(la_zooms[li_idx].dzcb002 CLIPPED) THEN
            LET lnode_child = lnode_zoom.appendChildElement("param")
            CALL lnode_child.setAttribute("order", la_zooms[li_idx].dzcb002 CLIPPED)
            CALL lnode_child.setAttribute("name", "arg"||la_zooms[li_idx].dzcb003 CLIPPED)
            CALL lnode_child.setAttribute("desc", la_zooms[li_idx].dzcbl004 CLIPPED)
         END IF

         LET li_idx = li_idx + 1
      END FOREACH

      LET lst_node = lnode_xml.getElementsByTagName("zoom")
      #取得開窗畫面設計.
      LET ls_trigger = "gen xml : get zoom ui setting"
      LET ls_sql = "SELECT dzca001,dzcc002,dzcc003,dzcc004,dzcc005,dzej003",
                    " FROM dzca_t",
                    " LEFT JOIN dzcc_t ON dzcc001=dzca001",
                    " LEFT JOIN dzej_t ON dzej001='GENERO_WIDGETS' AND dzej002=dzcc004",
                   " ORDER BY dzca001,dzcc002"
      PREPARE dzcc_prep FROM ls_sql
      DECLARE dzcc_curs CURSOR FOR dzcc_prep
      LET ls_sql = ""
      LET ls_id = ""
      LET ls_id_tmp = ""
      LET li_idx = 0
      LET li_i = 1
      FOREACH dzcc_curs INTO la_ui[li_i].*
         LET ls_id = la_ui[li_i].dzca001 CLIPPED
         IF NOT ls_id.equals(ls_id_tmp) THEN
            LET li_idx = li_idx + 1
            IF li_idx>lst_node.getCount() THEN
               EXIT FOREACH
            END IF
            LET lnode_zoom = lst_node.getItem(li_idx) #可以這樣直接對應而不判斷的原因是因為dzca001的順序會和xml內的順序相同.
            IF lnode_zoom IS NULL THEN
               EXIT FOREACH
            END IF
            LET ls_id_tmp = ls_id
         END IF

         #不可能沒有ui
         LET lnode_child = lnode_zoom.appendChildElement("ui")
         CALL lnode_child.setAttribute("order", la_ui[li_i].dzcc002 CLIPPED)
         CALL lnode_child.setAttribute("column", la_ui[li_i].dzcc003 CLIPPED)
         CALL lnode_child.setAttribute("widget", la_ui[li_i].dzej003 CLIPPED) #這樣速度比較快
         CALL lnode_child.setAttribute("return", la_ui[li_i].dzcc005 CLIPPED)

         LET li_i = li_i + 1
      END FOREACH

      LET ls_trigger = "gen xml : save zooms.xml"
      LET ls_sql = ""
      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_zooms_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_zooms_xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得WIDGET
# Input parameter : p_widget_no WIDGET代碼
# Return code     : s_widget WIDGET名稱
# Date & Author   : 2013/04/24 by Hiko
# Modify          : 2013/08/05 by Hiko : 改為取得dzej003 
##########################################################################
PRIVATE FUNCTION sadzp010_1_get_widget(p_widget_no)
   DEFINE p_widget_no STRING
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          #l_gztx004 LIKE gztx_t.gztx004
          l_dzej003 LIKE gztx_t.gztx004

   #這裡有錯誤也不影響開發,所以不需要特別停下.
   TRY
      LET ls_trigger = "gen xml : get zooms.xml widget"
      LET ls_sql = "SELECT dzej003",
                    " FROM dzej_t",
                   " WHERE dzej001='GENERO_WIDGETS' AND dzej002='",p_widget_no,"'"
      PREPARE dzej_prep FROM ls_sql
      EXECUTE dzej_prep INTO l_dzej003
      FREE dzej_prep

      RETURN l_dzej003 CLIPPED
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN NULL
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{資料項目設定檔}(items.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/06/25 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_items_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx,li_i SMALLINT
   DEFINE la_items DYNAMIC ARRAY OF RECORD
                   gzca001 LIKE gzca_t.gzca001,
                   gzcal003 LIKE gzcal_t.gzcal003,
                   gzcb002 LIKE gzcb_t.gzcb002,
                   gzcbl004 LIKE gzcbl_t.gzcbl004
                   END RECORD 
   DEFINE ls_id STRING,
          ls_id_tmp STRING
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_item xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_items_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "items.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "items.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("items")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get item setting"
      LET ls_sql = "SELECT gzca001,gzcal003,gzcb002,gzcbl004",
                    " FROM gzca_t",
                    " LEFT JOIN gzcal_t ON gzcal001=gzca001 AND gzcal002='",gs_lang,"'",
                    " LEFT JOIN gzcb_t ON gzcb001=gzca001",
                    " LEFT JOIN gzcbl_t ON gzcbl001=gzcb001 AND gzcbl002=gzcb002 AND gzcbl003='",gs_lang,"'",
                   " ORDER BY gzca001,gzcb002"
      PREPARE gzca_prep FROM ls_sql
      DECLARE gzca_curs CURSOR FOR gzca_prep
      LET li_idx = 1
      FOREACH gzca_curs INTO la_items[li_idx].*
         LET ls_id = la_items[li_idx].gzca001 CLIPPED
         IF NOT ls_id.equals(ls_id_tmp) THEN
            LET lnode_item = lnode_xml.appendChildElement("item")
            CALL lnode_item.setAttribute("id", ls_id)
            CALL lnode_item.setAttribute("desc", la_items[li_idx].gzcal003 CLIPPED)
            LET ls_id_tmp = ls_id
         END IF

         #取得資料項目的資料.
         LET lnode_child = lnode_item.appendChildElement("opt")
         CALL lnode_child.setAttribute("value", la_items[li_idx].gzcb002 CLIPPED)
         CALL lnode_child.setAttribute("caption", la_items[li_idx].gzcbl004 CLIPPED)

         LET li_idx = li_idx + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_items_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_items_xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{程式串查設定檔}(prog_rel.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_prog_rel_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx,li_i SMALLINT
   DEFINE la_gzzz DYNAMIC ARRAY OF RECORD 
                  gzzz001 LIKE gzzz_t.gzzz001,
                  gzzal003 LIKE gzzal_t.gzzal003 
                  END RECORD
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_prog xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_prog_rel_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "prog_rel.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "prog_rel.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("prog_rel")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get gzzz_t data"
      LET ls_sql = "SELECT gzzz001,gzzal003",
                    " FROM gzzz_t",
                    " LEFT JOIN gzzal_t ON gzzal001=gzzz001 AND gzzal002='",gs_lang,"'",
                   " ORDER BY gzzz001"
      PREPARE gzzz_prep1 FROM ls_sql
      DECLARE gzzz_curs1 CURSOR FOR gzzz_prep1
      LET li_idx = 1
      FOREACH gzzz_curs1 INTO la_gzzz[li_idx].*
         LET lnode_prog = lnode_xml.appendChildElement("prog")
         CALL lnode_prog.setAttribute("id", la_gzzz[li_idx].gzzz001 CLIPPED)
         CALL lnode_prog.setAttribute("desc", la_gzzz[li_idx].gzzal003 CLIPPED)
         LET li_i = li_i + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_prog_rel_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_prog_rel__xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{元件資訊檔}(subroutines.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_sub_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx,li_i SMALLINT
   DEFINE la_sub DYNAMIC ARRAY OF RECORD      #取得'元件維護資料表'的設定.
                 dzda001 LIKE dzda_t.dzda001,
                 dzdi005 LIKE dzdi_t.dzdi005, #2013/11/21 by Hiko
                 dzdb002 LIKE dzdb_t.dzdb002,
                 dzdb003 LIKE dzdb_t.dzdb003,
                 dzdb005 LIKE dzdb_t.dzdb005,
                 dzdb007 LIKE dzdb_t.dzdb007 
                 END RECORD
   DEFINE ls_id STRING,
          ls_id_tmp STRING,
          ls_dzdb002 STRING
   DEFINE l_dzdb005_desc LIKE dzdi_t.dzdi005 
   DEFINE ls_dzdi003 STRING 
   DEFINE ls_dzdb003 STRING 
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_com xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_sub_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "subroutines.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "subroutines.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("coms")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get subroutines setting"
      LET ls_sql = "SELECT dzda001,dzdi005,dzdb002,dzdb003,dzdb005,dzdb007",
                    " FROM dzda_t",
                    " LEFT JOIN dzdi_t ON dzdi001='dzda_t' AND dzdi002='dzda001' AND dzdi003=dzda001 AND dzdi004='",gs_lang,"'", #2013/11/21 by Hiko
                    " LEFT JOIN dzdb_t ON dzdb001=dzda001",
                   " WHERE dzdastus='Y'", #2013/09/03 by Hiko #2015/06/08 by Hiko:dzdastus='4'改成'Y'
                   " ORDER BY dzda001,dzdb002,dzdb003"
      PREPARE dzda_prep FROM ls_sql
      DECLARE dzda_curs CURSOR FOR dzda_prep
      LET li_idx = 1
      FOREACH dzda_curs INTO la_sub[li_idx].*
         LET ls_id = la_sub[li_idx].dzda001 CLIPPED
         IF NOT ls_id.equals(ls_id_tmp) THEN
            LET lnode_com = lnode_xml.appendChildElement("com")
            CALL lnode_com.setAttribute("id", ls_id) 
            #CALL sadz_get_name("dzda_t","dzda001",la_dzda[li_idx].dzda001 CLIPPED) RETURNING l_dzda001_desc
            CALL lnode_com.setAttribute("desc", la_sub[li_idx].dzdi005 CLIPPED) #2013/11/21 by Hiko
            LET ls_id_tmp = ls_id
         END IF

         #取得元件參數設定.
         LET ls_dzdb002 = la_sub[li_idx].dzdb002 CLIPPED
         IF NOT cl_null(ls_dzdb002) THEN
            IF ls_dzdb002="P" THEN
               LET lnode_child = lnode_com.appendChildElement("param")
            ELSE
               LET lnode_child = lnode_com.appendChildElement("rtn")
            END IF
            CALL lnode_child.setAttribute("name", la_sub[li_idx].dzdb005 CLIPPED)
            LET ls_dzdb003 = la_sub[li_idx].dzdb003
            LET ls_dzdb003 = ls_dzdb003.trim()
            LET ls_dzdi003 = ls_id,",",ls_dzdb002 CLIPPED,",",ls_dzdb003,",",la_sub[li_idx].dzdb005 CLIPPED
            CALL lnode_child.setAttribute("desc", sadz_get_name("dzdb_t", "dzdb005", ls_dzdi003)) #因為dzdi003是多個key的組合,所以無法使用JOIN的方式.
            CALL lnode_child.setAttribute("type", la_sub[li_idx].dzdb007 CLIPPED)
         END IF

         LET li_idx = li_idx + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_sub_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_sub__xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 產生{元件相關資訊檔}(subinfo.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/11/21 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp010_1_gen_subinfo_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_i,li_j SMALLINT
   DEFINE la_gzcb DYNAMIC ARRAY OF RECORD   
                  gzcb002 LIKE gzcb_t.gzcb002,
                  gzcbl004 LIKE gzcbl_t.gzcbl004
                  END RECORD
   DEFINE la_dzdg DYNAMIC ARRAY OF RECORD   
                  dzdg001 LIKE dzdg_t.dzdg001, #dimension
                  dzdg002 LIKE dzdg_t.dzdg002, #class
                  dzdi005 LIKE dzdi_t.dzdi005
                  END RECORD
   DEFINE ls_dzdg001 STRING,
          ls_dzdg001_tmp STRING
   DEFINE ls_dzdi003 STRING #class desc
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_for_db xml.DomNode,
          lnode_dimension xml.DomNode,
          lnode_class xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_subinfo_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "subinfo.xml")
      CALL sadzp010_1_rename(ls_xml, "subinfo.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      LET ldoc_xml = xml.domDocument.createDocument("subinfo")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get subinfo setting : for_db"
      LET ls_sql = "SELECT gzcb002,gzcbl004",
                    " FROM gzcb_t",
                    " LEFT JOIN gzcbl_t ON gzcbl001=gzcb001 AND gzcbl002=gzcb002 AND gzcbl003='",gs_lang,"'",
                   " WHERE gzcb001='18002'", 
                   " ORDER BY gzcb002"
      PREPARE gzcb_prep2 FROM ls_sql
      DECLARE gzcb_curs2 CURSOR FOR gzcb_prep2
      LET li_i = 1
      FOREACH gzcb_curs2 INTO la_gzcb[li_i].*
         LET lnode_for_db = lnode_xml.appendChildElement("for_db")
         CALL lnode_for_db.setAttribute("value", la_gzcb[li_i].gzcb002 CLIPPED)
         CALL lnode_for_db.setAttribute("desc", la_gzcb[li_i].gzcbl004 CLIPPED) 
         LET li_i = li_i + 1
      END FOREACH

      LET ls_trigger = "gen xml : get subinfo setting : dimension"
      LET ls_sql = "SELECT distinct(dzdg001),dzdg002,dzdi005",
                    " FROM dzdg_t",
                    " LEFT JOIN dzdi_t ON dzdi001='dzdg_t' AND dzdi002='dzdg001' AND dzdi003=dzdg001 AND dzdi004='",gs_lang,"'", 
                   " ORDER BY dzdg001,dzdg002" 
      PREPARE dzdg_prep FROM ls_sql
      DECLARE dzdg_curs CURSOR FOR dzdg_prep
      LET li_i = 1
      FOREACH dzdg_curs INTO la_dzdg[li_i].*
         LET ls_dzdg001 = la_dzdg[li_i].dzdg001 CLIPPED
         IF NOT ls_dzdg001.equals(ls_dzdg001_tmp) THEN
            LET lnode_dimension = lnode_xml.appendChildElement("dimension")
            CALL lnode_dimension.setAttribute("no", ls_dzdg001)
            CALL lnode_dimension.setAttribute("desc", la_dzdg[li_i].dzdi005 CLIPPED) 
            LET ls_dzdg001_tmp = ls_dzdg001
         END IF

         LET lnode_class = lnode_dimension.appendChildElement("class")
         CALL lnode_class.setAttribute("name", la_dzdg[li_i].dzdg002 CLIPPED)
         LET ls_dzdi003 = ls_dzdg001,",",la_dzdg[li_i].dzdg002 CLIPPED
         CALL lnode_class.setAttribute("desc", sadz_get_name("dzdg_t", "dzdg002", ls_dzdi003)) #因為dzdi003是多個key的組合,所以無法使用JOIN的方式.

         LET li_i = li_i + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_subinfo_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_subinfo__xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{元件資訊檔}(libraries.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/03/04 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_lib_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx,li_i SMALLINT
   DEFINE la_lib DYNAMIC ARRAY OF RECORD 
                 gzwa002 LIKE gzwa_t.gzwa002, 
                 gzwa006 LIKE gzwa_t.gzwa006,
                 gzwb006 LIKE gzwb_t.gzwb006, 
                 gzwb007 LIKE gzwb_t.gzwb007, 
                 gzwb008 LIKE gzwb_t.gzwb008, 
                 gzwb009 LIKE gzwb_t.gzwb009, 
                 gzwb010 LIKE gzwb_t.gzwb010 
                 END RECORD
   DEFINE ls_id STRING,
          ls_id_tmp STRING,
          ls_gzwb006 STRING
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_com xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_lib_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "libraries.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "libraries.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("coms")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get libraries setting"
      LET ls_sql = "SELECT gzwa002,gzwa006,gzwb006,gzwb007,gzwb008,gzwb009,gzwb010",
                    " FROM gzwa_t",
                    " LEFT JOIN gzwb_t ON gzwb001=gzwa001 AND gzwb002=gzwa002",
                   " WHERE gzwa004='0'", #只取出PUBLIC FUNCTION.
                   " ORDER BY gzwa002,gzwb006,gzwb007"
      PREPARE gzwa_prep FROM ls_sql
      DECLARE gzwa_curs CURSOR FOR gzwa_prep
      LET li_idx = 1
      FOREACH gzwa_curs INTO la_lib[li_idx].*
         LET ls_id = la_lib[li_idx].gzwa002 CLIPPED
         IF NOT ls_id.equals(ls_id_tmp) THEN
            LET lnode_com = lnode_xml.appendChildElement("com")
            CALL lnode_com.setAttribute("id", ls_id)
            CALL lnode_com.setAttribute("desc", la_lib[li_idx].gzwa006 CLIPPED) 
            LET ls_id_tmp = ls_id
         END IF

         #取得元件參數設定.
         LET ls_gzwb006 = la_lib[li_idx].gzwb006 CLIPPED
         IF NOT cl_null(ls_gzwb006) THEN
            IF ls_gzwb006="i" THEN #元件為"p"
               LET lnode_child = lnode_com.appendChildElement("param")
            ELSE #o #元件為"r"
               LET lnode_child = lnode_com.appendChildElement("rtn")
            END IF
            CALL lnode_child.setAttribute("name", la_lib[li_idx].gzwb010 CLIPPED)
            CALL lnode_child.setAttribute("type", la_lib[li_idx].gzwb008 CLIPPED)
            CALL lnode_child.setAttribute("desc", la_lib[li_idx].gzwb009 CLIPPED) 
         END IF

         LET li_idx = li_idx + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_lib_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_lib__xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{提示訊息檔}(messages.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_messages_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx SMALLINT
   DEFINE la_gzze DYNAMIC ARRAY OF RECORD LIKE gzze_t.* #取得'錯誤訊息檔'的參數設定.
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode
   DEFINE lb_flag BOOLEAN #呼叫檔案複製的回傳變數.
   DEFINE lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_messages_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "messages.xml")
      #Begin : 2013/09/05 by Hiko
      CALL sadzp010_1_rename(ls_xml, "messages.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      #End : 2013/09/05 by Hiko
      LET ldoc_xml = xml.domDocument.createDocument("messages")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      #取得錯誤訊息資料.
      LET ls_trigger = "gen xml : get messages setting"
      LET ls_sql = "SELECT *",
                    " FROM gzze_t",
                   " WHERE gzze002='",gs_lang,"'",
                   " ORDER BY gzze001"
      PREPARE gzze_prep FROM ls_sql
      DECLARE gzze_curs CURSOR FOR gzze_prep
      LET li_idx = 1
      FOREACH gzze_curs INTO la_gzze[li_idx].*
         LET lnode_child = lnode_xml.appendChildElement("message")
         CALL lnode_child.setAttribute("id", la_gzze[li_idx].gzze001 CLIPPED)
         CALL lnode_child.setAttribute("desc", la_gzze[li_idx].gzze003 CLIPPED)
         
         LET li_idx = li_idx + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_messages_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_messages__xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{資料表清單檔}(tables.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/08/27 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_tables_xml()
   DEFINE ls_xml STRING

   DISPLAY "call sadzp010_1_gen_tables_xml() start!"
   CALL sadzp010_1_init_var()
   LET ls_xml = os.path.join(gs_mta_path, "tables.xml")
   CALL sadzi140_xml_gen_table_list(ls_xml, gs_lang)
   DISPLAY "call sadzp010_1_gen_tables_xml() finish!"
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{範本代碼檔}(code_sample.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/09/27 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_code_sample_xml()
   DEFINE ls_xml STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE li_idx SMALLINT
   #Begin : 2013/11/21 by Hiko
   DEFINE la_dzdj DYNAMIC ARRAY OF RECORD 
                  dzdj001 LIKE dzdj_t.dzdj001,
                  dzdj003 LIKE dzdj_t.dzdj003,
                  dzdj006 LIKE dzdj_t.dzdj006,
                  dzdj008 LIKE dzdj_t.dzdj008,
                  dzdi005 LIKE dzdi_t.dzdi005,
                  gzcbl004 LIKE gzcbl_t.gzcbl004
                  END RECORD
   #End : 2013/11/21 by Hiko
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode,
          lnode_child xml.DomNode,
          lnode_code xml.DomNode
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   DISPLAY "call sadzp010_1_gen_code_sample_xml() start!"

   TRY
      LET ls_xml = os.path.join(gs_mta_path, "code_sample.xml")
      CALL sadzp010_1_rename(ls_xml, "code_sample.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF

      LET ldoc_xml = xml.domDocument.createDocument("code_sample")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      #取得範本代碼檔資料.
      LET ls_trigger = "gen xml : get code_sample setting"
      LET ls_sql = "SELECT dzdj001,dzdj003,dzdj006,dzdj008,dzdi005,gzcbl004",
                    " FROM dzdj_t",
                    " LEFT JOIN dzdi_t ON dzdi001='dzdj_t' AND dzdi002='dzdj001' AND dzdi003=dzdj001 AND dzdi004='",gs_lang,"'", #2013/11/21 by Hiko
                    " LEFT JOIN gzcbl_t ON gzcbl001='460' AND gzcbl002=dzdj008 AND gzcbl003='",gs_lang,"'", #2013/11/21 by Hiko
                   " ORDER BY dzdj001"
      PREPARE dzdj_prep FROM ls_sql
      DECLARE dzdj_curs CURSOR FOR dzdj_prep
      LET li_idx = 1
      FOREACH dzdj_curs INTO la_dzdj[li_idx].*
         LET lnode_child = lnode_xml.appendChildElement("sample")
         CALL lnode_child.setAttribute("id", la_dzdj[li_idx].dzdj001 CLIPPED)
         #CALL lnode_child.setAttribute("desc", sadz_get_name("dzdj_t", "dzdj001", la_dzdj[li_idx].dzdj001 CLIPPED))
         CALL lnode_child.setAttribute("desc", la_dzdj[li_idx].dzdi005 CLIPPED) #2013/11/21 by Hiko
         #取得range的對應說明:1==>erp,2==>lib,3==>sub.
         #CALL lnode_child.setAttribute("range", sadzp010_1_get_scc_desc("460", la_dzdj[li_idx].dzdj008 CLIPPED))
         CALL lnode_child.setAttribute("range", la_dzdj[li_idx].gzcbl004 CLIPPED) #2013/11/21 by Hiko
         CALL lnode_child.setAttribute("show", la_dzdj[li_idx].dzdj006 CLIPPED)
         
         LET lnode_code = ldoc_xml.createCDATASection(la_dzdj[li_idx].dzdj003 CLIPPED)
         CALL lnode_child.appendChild(lnode_code)

         LET li_idx = li_idx + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)

      DISPLAY "call sadzp010_1_gen_code_sample_xml() finish!"
      RETURN TRUE,""
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE,"call sadzp010_1_gen_code_sample_xml failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得系統分類值的說明
# Input parameter : p_scc 系統分類碼
#                 : p_scc_value 系統分類值
# Return code     : STRING 系統分類值的說明
# Date & Author   : 2013/09/27 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp010_1_get_scc_desc(p_scc, p_scc_value)
   DEFINE p_scc STRING,
          p_scc_value STRING
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          l_gzcbl004 LIKE gzcbl_t.gzcbl004

   TRY
      LET p_scc = p_scc.trim()
      LET p_scc_value = p_scc_value.trim()
      
      LET ls_trigger = "sadzp010_1_get_scc_desc"
      LET ls_sql = "SELECT gzcbl004",
                    " FROM gzcbl_t",
                   " WHERE gzcbl001='",p_scc,"' AND gzcbl002='",p_scc_value,"' AND gzcbl003='",gs_lang,"'"
      PREPARE gzcbl_prep FROM ls_sql
      EXECUTE gzcbl_prep INTO l_gzcbl004
      FREE gzcbl_prep
      
      RETURN l_gzcbl004 CLIPPED
   CATCH 
      CALL sadzp010_1_err_catch(ls_trigger, ls_sql) 
      RETURN NULL
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{樹狀結構類別檔}(tree_kind.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/14 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_tree_kind_xml()
   DEFINE ls_xml STRING
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode,
          lnode_child xml.DomNode
   DEFINE sa_kind DYNAMIC ARRAY OF STRING,
          li_idx SMALLINT
   DEFINE lb_result BOOLEAN, #2014/03/11 by Hiko
          ls_err_msg STRING

   TRY
      DISPLAY "call sadzp010_1_gen_tree_kind_xml() start!"

      LET ls_xml = os.path.join(gs_mta_path, "tree_kind.xml")
      CALL sadzp010_1_rename(ls_xml, "tree_kind.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      LET ldoc_xml = xml.domDocument.createDocument("tree_kind")
      LET lnode_xml = ldoc_xml.getDocumentElement()
      LET sa_kind[1] = "recu_01"
      LET sa_kind[2] = "recu_02"
      LET sa_kind[3] = "type_01"
      FOR li_idx=1 TO sa_kind.getLength()
         LET lnode_child = lnode_xml.appendChildElement("kind")
         CALL lnode_child.setAttribute("name", sa_kind[li_idx])
         CALL lnode_child.setAttribute("att", sadzp168_1_dzff_default_str("s_browse", sa_kind[li_idx])) #s_browse其實沒有作用
      END FOR
      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)
      DISPLAY "call sadzp010_1_gen_tree_kind_xml() finish!"
      RETURN TRUE,""
   CATCH 
      RETURN FALSE,"call sadzp010_1_gen_tree_kind_xml() failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{程式樣版類別檔}(code_template.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/03/27 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_code_template_xml()
   DEFINE ls_xml STRING
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, 
          ls_err_msg STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING
   DEFINE la_dzej DYNAMIC ARRAY OF RECORD 
                  dzej002 LIKE dzej_t.dzej002,
                  dzejl004 LIKE dzejl_t.dzejl004 
                  END RECORD,
          li_i SMALLINT

   TRY
      DISPLAY "call sadzp010_1_gen_code_template_xml() start!"

      LET ls_xml = os.path.join(gs_mta_path, "code_template.xml")
      CALL sadzp010_1_rename(ls_xml, "code_template.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      LET ldoc_xml = xml.domDocument.createDocument("code_template")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get dzej_t data"
      LET ls_sql = "SELECT dzej002,dzejl004",
                    " FROM dzej_t",
                    " LEFT JOIN dzejl_t ON dzejl001=dzej001 AND dzejl002=dzej002 AND dzejl003='",gs_lang,"'",
                   " WHERE dzej001='code_template'",
                   " ORDER BY dzej002"
      PREPARE dzej_prep5 FROM ls_sql
      DECLARE dzej_curs5 CURSOR FOR dzej_prep5
      LET li_i = 1
      FOREACH dzej_curs5 INTO la_dzej[li_i].*
         LET lnode_child = lnode_xml.appendChildElement("kind")
         CALL lnode_child.setAttribute("id", la_dzej[li_i].dzej002 CLIPPED)
         CALL lnode_child.setAttribute("desc", la_dzej[li_i].dzejl004 CLIPPED)
         
         LET li_i = li_i + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)
      DISPLAY "call sadzp010_1_gen_code_template_xml() finish!"
      RETURN TRUE,""
   CATCH 
      RETURN FALSE,"call sadzp010_1_gen_code_template_xml() failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 產生{標準標籤檔}(std_label.xml).
# Input parameter : none
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/03/27 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp010_1_gen_std_label_xml()
   DEFINE ls_xml STRING
   DEFINE ldoc_xml xml.DomDocument,
          lnode_xml xml.DomNode,
          lnode_child xml.DomNode
   DEFINE lb_result BOOLEAN, 
          ls_err_msg STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING
   DEFINE la_gzzd DYNAMIC ARRAY OF RECORD 
                  gzzd003 LIKE gzzd_t.gzzd003,
                  gzzd005 LIKE gzzd_t.gzzd005
                  END RECORD,
          li_i SMALLINT

   TRY
      DISPLAY "call sadzp010_1_gen_std_label_xml() start!"

      LET ls_xml = os.path.join(gs_mta_path, "std_label.xml")
      CALL sadzp010_1_rename(ls_xml, "std_label.xml") RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg
      END IF
      LET ldoc_xml = xml.domDocument.createDocument("std_label")
      LET lnode_xml = ldoc_xml.getDocumentElement()

      LET ls_trigger = "gen xml : get gzzd_t data"
      #不需要說明,只需要清單即可,所以不加上語系當作條件,以免多語言不同步,造成不同語言的判斷誤差.
      LET ls_sql = "SELECT DISTINCT(gzzd003)",
                    " FROM gzzd_t",
                   " WHERE gzzd001='standard'",
                   " ORDER BY gzzd003"
      PREPARE gzzd_prep5 FROM ls_sql
      DECLARE gzzd_curs5 CURSOR FOR gzzd_prep5
      LET li_i = 1
      FOREACH gzzd_curs5 INTO la_gzzd[li_i].*
         LET lnode_child = lnode_xml.appendChildElement("label")
         CALL lnode_child.setAttribute("id", la_gzzd[li_i].gzzd003 CLIPPED)
         
         LET li_i = li_i + 1
      END FOREACH

      CALL ldoc_xml.setFeature("format-pretty-print", "TRUE")
      CALL ldoc_xml.save(ls_xml)
      DISPLAY "call sadzp010_1_gen_std_label_xml() finish!"
      RETURN TRUE,""
   CATCH 
      RETURN FALSE,"call sadzp010_1_gen_std_label_xml() failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : none
# Date & Author   : 2013/04/24 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp010_1_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION




