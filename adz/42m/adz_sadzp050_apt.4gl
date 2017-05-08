#+ 程式代碼......: sadzp050_apt
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : sadzp050_apt.4gl
# Description    : 差異比對apt檔組合程序
# Modify         : 20161226 170208-00008 by Hiko : 新建程式
# Modify         : 20170215 170208-00008 by Hiko : Patch編號先找dzbk_t,沒有才找dzbj_t.

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"

DEFINE ms_prog       STRING,
       ms_patch_type STRING,
       mdoc_apt      xml.DomDocument,
       mnode_apt     xml.DomNode,
       mnode_target  xml.DomNode,
       mnode_topstd  xml.DomNode

CONSTANT cs_cus_path = "cus_path"
CONSTANT cs_ind_path = "ind_path"

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 取得比對工具專用的apt檔路徑
# Input parameter : ps_patch_type Patch類型(cus_patch:客製Patch;ind_path:行業Patch)
#                 : ps_prog       程式編號
#                 : ps_cons_type  建構類型
# Return code     : BOOLEAN 是否成功(成功:TRUE;失敗:FALSE)
#                 : STRING  檔案路徑(成功:檔案路徑;失敗:錯誤訊息)
# Date & Author   : 2016/12/26 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp050_apt_get_path(ps_patch_type, ps_prog, ps_cons_type) 
   DEFINE ps_patch_type STRING,
          ps_prog       STRING,
          ps_cons_type  STRING
   DEFINE lo_dzaf     T_DZAF_T,
          ls_apt_path STRING,
          lb_result   BOOLEAN 

   LET ms_prog = ps_prog #行業Patch就是傳入行業編號.
   LET ms_patch_type = ps_patch_type

   LET mdoc_apt = xml.domDocument.createDocument("code")
   CALL mdoc_apt.setFeature("format-pretty-print", "TRUE")

   LET mnode_apt = mdoc_apt.getDocumentElement()
   CALL mnode_apt.setAttribute("prog", ps_prog)
   
   LET lo_dzaf.dzaf001 = ps_prog
   LET lo_dzaf.dzaf005 = ps_cons_type
   LET lo_dzaf.dzaf010 = "s" #一定是找標準程式的資料
   LET lo_dzaf.dzaf002 = sadzp200_ver_get_max_construct_version(lo_dzaf.*)
   CALL mnode_apt.setAttribute("ver", sadzp200_ver_get_curr_pr_version(lo_dzaf.*))

   #建立設計器需要的主節點.
   LET mnode_target = mnode_apt.appendChildElement("target")
   LET mnode_topstd = mnode_apt.appendChildElement("topstd")

   #建立<point>節點內容.
   CALL sadzp050_apt_create('1')
   #建立<section>節點內容.
   CALL sadzp050_apt_create('2')
      
   LET ls_apt_path = os.path.join(FGL_GETENV("TEMPDIR"), ms_prog||".apt")
   IF os.Path.exists(ls_apt_path) THEN
      #刪除舊資料失敗也沒關係.
      IF NOT os.Path.delete(ls_apt_path) THEN
         DISPLAY "INFO : Delete ",ls_apt_path," failure!"
      END IF
   END IF
   
   CALL mdoc_apt.save(ls_apt_path)
   
   #最後變成777,這樣在運行過程中會比較保險,失敗也沒關係.
   IF NOT os.Path.chrwx(ls_apt_path, 511) THEN
      DISPLAY "INFO : ",ls_apt_path," chrwx 511 failure!"
   END IF

   RETURN ls_apt_path
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立差異比對工具專用的apt檔
# Input parameter : pc_code_type 程式類型(1.add point;2.section)
# Return code     : void
# Date & Author   : 2016/12/26 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp050_apt_create(pc_code_type)
   DEFINE pc_code_type CHAR(1)
   DEFINE lnode_child xml.DomNode,
          lnode_code  xml.DomNode,
          lnode_new   xml.DomNode,
          lnode_old   xml.DomNode,
          ls_sql      STRING,
          l_patch_no  LIKE dzbk_t.dzbk001, #Patch編號
          li_i    INTEGER,
          li_j    INTEGER,
          la_dzbj DYNAMIC ARRAY OF RECORD
                  dzbj002  LIKE dzbj_t.dzbj002, #最新識別碼使用版次(對應dzba004)
                  dzbj003  LIKE dzbj_t.dzbj003, #識別碼名稱(對應dzba003)
                  dzbj004  LIKE dzbj_t.dzbj004, #上次識別碼使用版次(對應dzba004)
                  new_code LIKE dzbb_t.dzbb098, #最新標準程式內容
                  old_code LIKE dzbb_t.dzbb098  #上次標準程式內容
                  END RECORD,
          la_dzbi DYNAMIC ARRAY OF RECORD
                  dzbi003 LIKE dzbi_t.dzbi003, #識別碼名稱(對應dzba003)
                  dzbi004 LIKE dzbi_t.dzbi004, #識別碼使用版次(對應dzba004)
                  dzbi007 LIKE dzbi_t.dzbi007, #下方的硬結構編號整段註解(對應dzba009)
                  dzbi098 LIKE dzbi_t.dzbi098
                  END RECORD
   DEFINE ltok_patch_no base.StringTokenizer,
          ls_temp       STRING
   
   TRY
      #Begin:20170215
      SELECT dzbk001 INTO l_patch_no FROM dzbk_t
      LET ltok_patch_no = base.StringTokenizer.create(l_patch_no,"|")
      WHILE ltok_patch_no.hasMoreTokens()
         IF cl_null(ls_temp) THEN
            LET ls_temp = "'",ltok_patch_no.nextToken(),"'"
         ELSE
            LET ls_temp = ls_temp,",'",ltok_patch_no.nextToken(),"'"
         END IF
      END WHILE
      LET l_patch_no = ls_temp #重設patch no.
      #End:20170215
         
      IF cl_null(l_patch_no) THEN #20170215
         #取得標準有衝突的客製add point清單,行業為斷開清單.資料來源為dzbj_t.
         LET ls_sql = "SELECT DISTINCT(bj1.dzbj005) FROM dzbj_t bj1",
                      " WHERE bj1.dzbj007='",ms_prog,"'",
                      "   AND bj1.dzbj006='",pc_code_type,"'",
                      "   AND bj1.dzbjcrtdt=(SELECT MAX(dzbjcrtdt) FROM dzbj_t bj2",
                      "                       WHERE bj2.dzbj007=bj1.dzbj007",
                      "                         AND bj2.dzbj006=bj1.dzbj006)"
         PREPARE dzbj_prep1 FROM ls_sql
         EXECUTE dzbj_prep1 INTO l_patch_no
         FREE dzbj_prep1

         LET l_patch_no = "'",l_patch_no,"'" #重設以符合IN條件.
      END IF

      IF NOT cl_null(l_patch_no) THEN
         IF pc_code_type='1' THEN
            LET ls_sql = "SELECT dzbj002,dzbj003,dzbj004,bb1.dzbb098,bb2.dzbb098 FROM dzbj_t",
                         "  LEFT JOIN dzbb_t bb1 ON bb1.dzbb001=dzbj001 AND bb1.dzbb002=dzbj003 AND bb1.dzbb003=dzbj002 AND bb1.dzbb004=dzbj008",
                         "  LEFT JOIN dzbb_t bb2 ON bb2.dzbb001=dzbj001 AND bb2.dzbb002=dzbj003 AND bb2.dzbb003=dzbj004 AND bb2.dzbb004=dzbj008"
         ELSE #'2'
            LET ls_sql = "SELECT dzbj002,dzbj003,dzbj004,bd1.dzbd098,bd2.dzbd098 FROM dzbj_t",
                         "  LEFT JOIN dzbd_t bd1 ON bd1.dzbd001=dzbj001 AND bd1.dzbd002=dzbj003 AND bd1.dzbd003=dzbj002 AND bd1.dzbd004=dzbj008",
                         "  LEFT JOIN dzbd_t bd2 ON bd2.dzbd001=dzbj001 AND bd2.dzbd002=dzbj003 AND bd2.dzbd003=dzbj004 AND bd2.dzbd004=dzbj008"
         END IF
         
         LET ls_sql = ls_sql," WHERE dzbj007='",ms_prog,"'",
                      "   AND dzbj005 IN (",l_patch_no,")",
                      "   AND dzbj006='",pc_code_type,"'",
                      " ORDER BY dzbj003"
         PREPARE dzbj_prep2 FROM ls_sql
         LOCATE la_dzbj[1].new_code IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
         LOCATE la_dzbj[1].old_code IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
         DECLARE dzbj_curs2 CURSOR FOR dzbj_prep2

         LET li_j = 1
         FOREACH dzbj_curs2 INTO la_dzbj[li_j].*
            IF pc_code_type='1' THEN
               LET lnode_child = mnode_target.appendChildElement("point")
            ELSE #'2'
               LET lnode_child = mnode_target.appendChildElement("section")
            END IF
         
            CALL lnode_child.setAttribute("name", la_dzbj[li_j].dzbj003)

            LET lnode_new = lnode_child.appendChildElement("new")
            CALL lnode_new.setAttribute("std_ver", la_dzbj[li_j].dzbj002)
            LET lnode_code = mdoc_apt.createCDATASection(la_dzbj[li_j].new_code)
            CALL lnode_new.appendChild(lnode_code)

            LET lnode_old = lnode_child.appendChildElement("old")
            CALL lnode_old.setAttribute("std_ver", la_dzbj[li_j].dzbj004)
            LET lnode_code = mdoc_apt.createCDATASection(la_dzbj[li_j].old_code)
            CALL lnode_old.appendChild(lnode_code)

            FREE la_dzbj[li_j].new_code #釋放LOCATE.
            FREE la_dzbj[li_j].old_code #釋放LOCATE.
            LET li_j = li_j + 1
            LOCATE la_dzbj[li_j].new_code IN FILE #設定陣列第二筆以後clob資料的LOCATE.
            LOCATE la_dzbj[li_j].old_code IN FILE #設定陣列第二筆以後clob資料的LOCATE.
         END FOREACH
      ELSE
         DISPLAY "INFO : The patch number corresponding to the program : ",ms_prog,"(",pc_code_type,") was not found in dzbj_t."
      END IF
         
      #取得標準有衝突的topstd add point清單,行業不需要.資料來源為dzbi_t.
      IF ms_patch_type=cs_cus_path THEN
         IF cl_null(l_patch_no) THEN #20170215
            LET ls_sql = "SELECT DISTINCT(bi1.dzbi005) FROM dzbi_t bi1",
                         " WHERE bi1.dzbi001='",ms_prog,"'",
                         "   AND bi1.dzbi006='",pc_code_type,"'",
                         "   AND bi1.dzbicrtdt=(SELECT MAX(dzbicrtdt) FROM dzbi_t bi2",
                         "                       WHERE bi2.dzbi001=bi1.dzbi001",
                         "                         AND bi2.dzbi006=bi1.dzbi006)"
            PREPARE dzbi_prep1 FROM ls_sql
            EXECUTE dzbi_prep1 INTO l_patch_no
            FREE dzbi_prep1

            LET l_patch_no = "'",l_patch_no,"'" #重設以符合IN條件.
         END IF
         
         IF NOT cl_null(l_patch_no) THEN
            LET ls_sql = "SELECT dzbi003,dzbi004,dzbi007,dzbi098 FROM dzbi_t",
                         " WHERE dzbi001='",ms_prog,"'",
                         "   AND dzbi005 IN (",l_patch_no,")",
                         "   AND dzbi006='",pc_code_type,"'",
                         " ORDER BY dzbi003"
            PREPARE dzbi_prep2 FROM ls_sql
            LOCATE la_dzbi[1].dzbi098 IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
            DECLARE dzbi_curs2 CURSOR FOR dzbi_prep2
            
            LET li_i = 1
            FOREACH dzbi_curs2 INTO la_dzbi[li_i].*
               IF pc_code_type='1' THEN
                  LET lnode_child = mnode_topstd.appendChildElement("point")
               ELSE #'2'
                  LET lnode_child = mnode_topstd.appendChildElement("section")
               END IF
               CALL lnode_child.setAttribute("name", la_dzbi[li_i].dzbi003)
               CALL lnode_child.setAttribute("std_ver", la_dzbi[li_i].dzbi004)
               IF pc_code_type='1' THEN
                  CALL lnode_child.setAttribute("mark_hard", la_dzbi[li_i].dzbi007)
               END IF
               LET lnode_code = mdoc_apt.createCDATASection(la_dzbi[li_i].dzbi098)
               CALL lnode_child.appendChild(lnode_code)
            
               FREE la_dzbi[li_i].dzbi098 #釋放LOCATE.
               LET li_i = li_i + 1
               LOCATE la_dzbi[li_i].dzbi098 IN FILE #設定陣列第二筆以後clob資料的LOCATE.
            END FOREACH
         ELSE
            DISPLAY "INFO : The patch number corresponding to the program : ",ms_prog,"(",pc_code_type,") was not found in dzbi_t."
         END IF
      END IF
   CATCH
      DISPLAY "WARNING : Call sadzp050_apt_create(",pc_code_type,") faliure!"
   END TRY
END FUNCTION
