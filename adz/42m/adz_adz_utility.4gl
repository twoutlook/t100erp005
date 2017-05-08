IMPORT os
SCHEMA ds

#20150702 mark
##GLOBALS
##   DEFINE g_prog  LIKE type_t.chr20
##   DEFINE g_user  LIKE type_t.chr20
##END GLOBALS

#20150702 mark
### Pattern name...: cl_string.4gl
### Descriptions...: 字串的相關處理
### Date & Author..: 12/02/15 by Hiko
### Modify.........: 2014/10/23 by Hiko : cl_copy_file不要刪除,而是做備份
###取得數個相同字串所組成的字串.
##FUNCTION cl_repeat_char(ps_str, pi_cnt)
##   DEFINE ps_str STRING
##   DEFINE pi_cnt LIKE type_t.num5
##   DEFINE i_idx  LIKE type_t.num5
##   DEFINE sb_str base.StringBuffer
##
##   LET sb_str = base.StringBuffer.create()
##   FOR i_idx=1 TO pi_cnt
##      CALL sb_str.append(ps_str)
##   END FOR
##
##   RETURN sb_str.toString()
##END FUNCTION

#20150702 mark
###依據個數組成空白字串.
##FUNCTION cl_repeat_space(pi_cnt)
##   DEFINE pi_cnt SMALLINT
##
##   RETURN cl_repeat_char(" ", pi_cnt)
##END FUNCTION

##取代全部字串.
#FUNCTION cl_replace_str(ps_src, ps_old, ps_new)
#   DEFINE ps_src STRING, #來源字串
#          ps_old STRING, #被取代的字串
#          ps_new STRING  #要取代的字串
#   DEFINE sb_str base.StringBuffer
#
#   LET sb_str = base.StringBuffer.create()
#   CALL sb_str.append(ps_src)
#   CALL sb_str.replace(ps_old, ps_new, 0)
#
#   RETURN sb_str.toString()
#END FUNCTION


# Pattern name...: cl_dom.4gl
# Descriptions...: DOM的相關處理
# Date & Author..: 12/02/18 by Hiko


#20150702 mark
###判斷節點內是否存在某個屬性.
##FUNCTION cl_check_att_exist(pnode_item, ps_chk_att)
##   DEFINE pnode_item om.DomNode,
##          ps_chk_att STRING
##   DEFINE i_i SMALLINT,
##          s_att_name STRING,
##          b_exist_att BOOLEAN
##
##   LET ps_chk_att = ps_chk_att.trim()
##   LET b_exist_att = FALSE
##   FOR i_i=1 TO pnode_item.getAttributesCount()
##      LET s_att_name = pnode_item.getAttributeName(i_i)
##      LET s_att_name = s_att_name.trim()
##      IF s_att_name=ps_chk_att THEN
##         LET b_exist_att = TRUE
##         EXIT FOR
##      END IF
##   END FOR
##
##   RETURN b_exist_att
##END FUNCTION

#20150702 mark
###將別的檔案的節點加入到目標節點.
##FUNCTION cl_append_child(pnode_parent, pnode_src)
##   DEFINE pnode_parent om.DomNode, #目標節點
##          pnode_src om.DomNode #其他檔案的節點
##   DEFINE node_child om.DomNode,
##          i_i SMALLINT
##
##   LET node_child = pnode_parent.createChild(pnode_src.getTagName())
##   FOR i_i=1 TO pnode_src.getAttributesCount()
##      CALL node_child.setAttribute(pnode_src.getAttributeName(i_i), pnode_src.getAttributeValue(i_i))
##   END FOR
##
##   FOR i_i=1 TO pnode_src.getChildCount()
##      CALL cl_append_child(node_child, pnode_src.getChildByIndex(i_i))
##   END FOR
##END FUNCTION

# Pattern name...: cl_path.4gl
# Descriptions...: 重新包裝os.path的重要FUNCTION
# Date & Author..: 12/02/09 by Hiko

#20150702 mark
###檢查檔案/目錄是否存在.
##FUNCTION cl_check_exist(ps_file) 
##   DEFINE ps_file STRING
##   DEFINE s_msg STRING
##
##   IF NOT os.Path.exists(ps_file) THEN
##      LET s_msg = "The file : ",ps_file," does not exist."
##      CALL cl_error_msg(s_msg)
##      RETURN FALSE
##   END IF
##
##   RETURN TRUE
##END FUNCTION 

#20150702 mark
###刪除檔案.
##FUNCTION cl_delete_file(ps_file)
##   DEFINE ps_file STRING
##   DEFINE s_msg STRING
##
##   IF os.Path.exists(ps_file) THEN
##      IF NOT os.Path.delete(ps_file) THEN
##         LET s_msg = "Delete ",ps_file," error!"
##         CALL cl_error_msg(s_msg)
##         RETURN FALSE
##      END IF
##   END IF
##
##   RETURN TRUE
##END FUNCTION

##20150702:搬到cl_adz.4gl
###切換目錄.
##FUNCTION cl_change_dir(ps_dir)
##   DEFINE ps_dir STRING
##   DEFINE s_msg STRING
##
##   IF NOT os.Path.chdir(ps_dir) THEN
##      LET s_msg = "Fail to change directory : ",ps_dir
##      CALL cl_error_msg(s_msg)   
##      RETURN FALSE
##   END IF
##
##   RETURN TRUE
##END FUNCTION

##20150702:搬到cl_adz.4gl
###檔案複製.
##FUNCTION cl_copy_file(ps_from, ps_to)
##   DEFINE ps_from STRING,
##          ps_to STRING
##   DEFINE s_msg STRING
##   DEFINE s_to_bak STRING
##   DEFINE lb_result BOOLEAN #2014/10/23 by Hiko
##
##   IF os.Path.exists(ps_to) THEN
##      CALL os.Path.rename(ps_to, ps_to||".bak") RETURNING lb_result #這裡不成功就算了
##   END IF
##
##  #IF cl_delete_file(ps_to) THEN
##      IF os.Path.exists(ps_from) THEN
##         IF NOT os.path.copy(ps_from, ps_to) THEN
##            LET s_msg = "Fail to copy file : ",ps_to
##            CALL cl_error_msg(s_msg)   
##            RETURN FALSE
##         END IF
##      END IF
##  #ELSE
##  #   RETURN FALSE
##  #END IF
##
##   RETURN TRUE
##END FUNCTION

# Pattern name...: cl_win_msg.4gl
# Descriptions...: 有畫面的訊息
# Date & Author..: 12/02/09 by Hiko

#20150702 mark
##FUNCTION cl_confirm_msg(ps_msg)
##   DEFINE ps_msg STRING
##   DEFINE b_conf_flag BOOLEAN
##
##   #CALL FGL_WINQUESTION( title STRING, text STRING, default STRING, buttons STRING, icon STRING, danger SMALLINT ) RETURNING value STRING
##   IF FGL_WINQUESTION("CONFIRM MESSAGE", ps_msg, "yes", "yes|no", "question", 0)="yes" THEN
##      LET b_conf_flag = TRUE
##   ELSE
##      LET b_conf_flag = FALSE
##   END IF
##
##   RETURN b_conf_flag
##END FUNCTION

##20150702:搬到cl_adz.4gl
##FUNCTION cl_error_msg(ps_msg)
##   DEFINE ps_msg STRING
##
##   #CALL FGL_WINMESSAGE( title STRING, text STRING, icon STRING )
##   #Supported icon names are: "information", "exclamation", "question", "stop". 
##   CALL FGL_WINMESSAGE("ERROR MESSAGE", ps_msg, "stop")
##END FUNCTION

#20150702 mark
##FUNCTION cl_info_msg(ps_msg)
##   DEFINE ps_msg STRING
##
##   #CALL FGL_WINMESSAGE( title STRING, text STRING, icon STRING )
##   #Supported icon names are: "information", "exclamation", "question", "stop". 
##   CALL FGL_WINMESSAGE("INFORMATION MESSAGE", ps_msg, "information")
##END FUNCTION

############################################################
#+ @code
#+ 函式目的 判斷 SELECT ... FOR UPDATE 是否加上其他語法(by Database)
#+ @param   ps_forupd_sql  STRING  原傳入 SQL 字串
#+
#+ @return  STRING         調整過的 SQL 字串
############################################################
##20150702:搬到cl_adz.4gl
##PUBLIC FUNCTION cl_forupd_sql(ps_forupd_sql)
##  DEFINE ps_forupd_sql STRING
##  DEFINE ps_temp1      STRING
##  DEFINE li_pos        SMALLINT
##
##  CASE cl_db_get_database_type()
##     WHEN "IFX"
##        # IFX為基本語法，不作任何增加或調整
##     WHEN "ORA"
##        IF NOT ps_forupd_sql.getIndexOf(" NOWAIT",1) THEN
##           LET ps_forupd_sql = ps_forupd_sql CLIPPED, " NOWAIT"
##        END IF
##     WHEN "MSV"
##        IF NOT ps_forupd_sql.getIndexOf(" UPDLOCK ",1) THEN
##           LET ps_temp1 = ps_forupd_sql.toLowerCase()
##           IF ps_temp1.getIndexOf("where ",1) THEN
##              LET ps_forupd_sql = ps_forupd_sql.subString(1,ps_temp1.getIndexOf("where ",1)-1),
##                                  " UPDLOCK ",
##                                  ps_forupd_sql.subString(ps_temp1.getIndexOf("where ",1),ps_temp1.getLength())
##           END IF
##        END IF
##     WHEN "ASE"
##        # ASE為基本語法，不作任何增加或調整
##     WHEN "DB2"
##     OTHERWISE
##  END CASE
##
##  RETURN ps_forupd_sql
##END FUNCTION

############################################################
#+ @code
#+ 函式目的  完成修改後進行歷程紀錄
#+ @param    lc_logc004  CHAR(10)
#+ @param    lc_logc005  CHAR(50)
#+
#+ @return   BOOLEAN  TRUE/FALSE
############################################################
##20150702:搬到cl_adz.4gl
##PUBLIC FUNCTION cl_used_modified_record(lc_logc004,lc_logc005)
##   DEFINE lc_logc001  LIKE logc_t.logc001
##   DEFINE lc_logc002  LIKE logc_t.logc002
##   DEFINE ld_logc003  DATETIME YEAR TO SECOND
##   DEFINE lc_logc004  LIKE logc_t.logc004
##   DEFINE lc_logc005  LIKE logc_t.logc005
##
##   LET lc_logc001 = g_user
##   LET lc_logc002 = g_prog
##   LET ld_logc003 = cl_get_current()
##
##   INSERT INTO logc_t(logc001,logc002,logc003,logc004,logc005)
##    VALUES(lc_logc001,lc_logc002,ld_logc003,lc_logc004,lc_logc005)
##
##   IF SQLCA.SQLCODE THEN
##      RETURN FALSE
##   ELSE
##      RETURN TRUE
##   END IF
##
##END FUNCTION

