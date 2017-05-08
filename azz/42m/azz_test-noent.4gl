
IMPORT os

MAIN 
   DEFINE lchannel_read      base.Channel
   DEFINE ls_sample_filename STRING 
   DEFINE ls_readline        STRING
   DEFINE ls_tmp             STRING 
   DEFINE li_index  SMALLINT 
   DEFINE ls_sqlstring   STRING
   DEFINE li_lineno      INT
   DEFINE ls_module      STRING
   DEFINE ls_code        STRING
   DEFINE ls_mode        STRING

   LET ls_module = UPSHIFT(ARG_VAL(1) CLIPPED)
   LET ls_code = ARG_VAL(2) CLIPPED,".4gl"

   LET lchannel_read = base.Channel.create()
   LET ls_sample_filename = os.Path.join(os.Path.join(FGL_GETENV(ls_module),"4gl"),ls_code) #檔案路徑
   CALL lchannel_read.setDelimiter("")
   CALL lchannel_read.openFile(ls_sample_filename CLIPPED, "r" )
   
   DISPLAY "ls_sample_filename:",ls_sample_filename
   LET li_lineno = 0
   LET li_index = 0

   WHILE TRUE
      LET ls_readline = lchannel_read.readLine()
 
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      ELSE
         LET li_lineno = li_lineno + 1
      END IF

      LET ls_tmp = DOWNSHIFT(ls_readline)
      IF ls_tmp.getIndexOf("#",1) THEN LET ls_tmp = ls_tmp.subString(1,ls_tmp.getIndexOf("#",1)-1) END IF
      IF ls_tmp.getIndexOf("--",1) THEN LET ls_tmp = ls_tmp.subString(1,ls_tmp.getIndexOf("--",1)-1) END IF
      LET ls_tmp = ls_tmp.trim()
      IF ls_tmp.getLength() = 0 THEN CONTINUE WHILE END IF
      IF li_index >= 1 THEN
         LET li_index = li_index + 1
      END IF

      #設定起始點
      IF li_index = 0 THEN
         IF ls_tmp.getIndexOf("select",1) OR ls_tmp.getIndexOf("update",1) OR ls_tmp.getIndexOf("delete",1) THEN
            CASE
               WHEN ls_tmp.getIndexOf("update",1) LET ls_mode = "update"
               WHEN ls_tmp.getIndexOf("delete",1) LET ls_mode = "delete"
               OTHERWISE  LET ls_mode = "select"
            END CASE
            IF ls_tmp.getIndexOf("deleteelement",1) OR
               ls_tmp.getIndexOf("delete_",1) OR ls_tmp.getIndexOf("select_",1) OR ls_tmp.getIndexOf("update_",1) OR
               ls_tmp.getIndexOf("_delete",1) OR ls_tmp.getIndexOf("_select",1) OR ls_tmp.getIndexOf("_update",1) OR
               ls_tmp.getIndexOf(",delete",1) OR ls_tmp.getIndexOf(",select",1) OR ls_tmp.getIndexOf(",update",1) OR
               ls_tmp.getIndexOf(".delete",1) OR ls_tmp.getIndexOf(".select",1) OR ls_tmp.getIndexOf(".update",1) OR
               ls_tmp.getIndexOf("'delete",1) OR ls_tmp.getIndexOf("'update",1) OR #ls_tmp.getIndexOf("'select",1) OR
               ls_tmp.getIndexOf('"delete',1) OR ls_tmp.getIndexOf('"update',1) OR #ls_tmp.getIndexOf('"select',1) OR
               ls_tmp.getIndexOf("before ",1) OR ls_tmp.getIndexOf("cancel ",1) OR ls_tmp.getIndexOf("after",1) OR
               ls_tmp.getIndexOf("on action",1) OR ls_tmp.getIndexOf("for update",1) OR ls_tmp.getIndexOf("on update",1) OR
               ls_tmp.getIndexOf('update"',1) OR
               ls_tmp.getIndexOf("delete row",1) OR ls_tmp.getIndexOf("setselect",1) OR ls_tmp.getIndexOf("selected",1) THEN
            ELSE
               LET li_index = 1 
               LET ls_sqlstring = li_lineno,":"
            END IF
         END IF
      END IF

      #設定截止點
      IF li_index > 1 THEN
         IF ls_tmp.getIndexOf("let ",1) OR ls_tmp.getIndexOf("declare ",1) OR ls_tmp.getIndexOf("if ",1) OR 
            ls_tmp.getIndexOf("foreach",1) OR ls_tmp.getIndexOf("call ",1) OR ls_tmp.getIndexOf("dialog",1) OR
            ls_tmp.getIndexOf("open ",1) OR ls_tmp.getIndexOf(" function",1) OR ls_tmp.getIndexOf("end ",1) OR
            ls_tmp.getIndexOf("#add-point",1) OR ls_tmp.getIndexOf("return",1) OR ls_tmp.getIndexOf("else",1) OR
            ls_tmp.getIndexOf("initialize",1) OR
            ls_tmp.getIndexOf("prepare",1) OR (ls_tmp.getIndexOf("case",1) AND ls_mode <> "update") THEN
            LET li_index = 0
            CALL noent_check(ls_sqlstring.trim(),ls_mode)
         ELSE
            IF ls_tmp.getIndexOf("select",1) OR ls_tmp.getIndexOf("update",1) OR ls_tmp.getIndexOf("delete",1) THEN
               CASE
                  WHEN ls_tmp.getIndexOf("update",1) LET ls_mode = "update"
                  WHEN ls_tmp.getIndexOf("delete",1) LET ls_mode = "delete"
                  OTHERWISE  LET ls_mode = "select"
               END CASE
               IF ls_tmp.getIndexOf("deleteelement",1) OR
                  ls_tmp.getIndexOf("delete_",1) OR ls_tmp.getIndexOf("select_",1) OR ls_tmp.getIndexOf("update_",1) OR
                  ls_tmp.getIndexOf("_delete",1) OR ls_tmp.getIndexOf("_select",1) OR ls_tmp.getIndexOf("_update",1) OR
                  ls_tmp.getIndexOf(",delete",1) OR ls_tmp.getIndexOf(",select",1) OR ls_tmp.getIndexOf(",update",1) OR
                  ls_tmp.getIndexOf(".delete",1) OR ls_tmp.getIndexOf(".select",1) OR ls_tmp.getIndexOf(".update",1) OR
                  ls_tmp.getIndexOf("'delete",1) OR ls_tmp.getIndexOf("'update",1) OR #ls_tmp.getIndexOf("'select",1) OR
                  ls_tmp.getIndexOf('"delete',1) OR ls_tmp.getIndexOf('"update',1) OR #ls_tmp.getIndexOf('"select',1) OR
                  ls_tmp.getIndexOf("before ",1) OR ls_tmp.getIndexOf("cancel ",1) OR ls_tmp.getIndexOf("after",1) OR
                  ls_tmp.getIndexOf("on action",1) OR ls_tmp.getIndexOf("for update",1) OR ls_tmp.getIndexOf('update"',1) THEN
               ELSE
                  CALL noent_check(ls_sqlstring.trim(),ls_mode)
                  LET li_index = 1 
                  LET ls_sqlstring = li_lineno,":"
               END IF
            END IF
         END IF
      END IF

      IF li_index > 0 THEN
      #  display li_lineno,'-->',ls_tmp,'<--'
         LET ls_sqlstring = ls_sqlstring.trim()," ",ls_tmp
      END IF

  END WHILE 

END MAIN 

FUNCTION noent_check(ls_str,ls_mode)
   DEFINE ls_str  STRING
   DEFINE ls_mode STRING
   DEFINE ls_tabid STRING
   DEFINE li_half INT
   DEFINE ls_tmp   STRING

   #update內如果有 case 但也可能是碰到 sqlca
   IF ls_str.getIndexOf("update",1) AND ls_str.getIndexOf("case",1) AND ls_str.getIndexOf("sqlca.",1) THEN
      LET ls_str = ls_str.subString(1,ls_str.getIndexOf("case",1)-1)
   END IF

   LET ls_tabid = noent_get_tabid(ls_str,ls_mode)

   IF ls_str.getIndexOf("update",1) AND ls_str.getIndexOf("_t",1) AND NOT ls_str.getIndexOf("where",1) THEN
#     display "UPD_NO_WHERE:",ls_str
   END IF

   #偵測是否只有半句
   LET ls_tmp = ls_str.subString(ls_str.getLength()-8,ls_str.getLength())
   IF ls_tmp.getIndexOf("from",1) THEN
      LET li_half = TRUE
   ELSE
      LET li_half = FALSE
   END IF

   IF ls_tabid.getLength() <= 7 AND NOT ls_tabid = "dual" AND ls_tabid.subString(1,2) <> 'dz' AND ls_tabid.subString(1,2) <> 'gz' AND
      NOT ls_str.getIndexOf("ent",1) AND NOT li_half THEN
      display "NO_ENT:",ls_str
   END IF

   #JOIN
   IF ls_str.getIndexOf("left join",1) THEN
#     display "JOIN:",ls_str
   END IF
END FUNCTION

FUNCTION noent_get_tabid(ls_str,ls_mode)
   DEFINE ls_str  STRING
   DEFINE ls_tmp  STRING
   DEFINE ls_mode STRING
   DEFINE ls_tabid STRING

   LET ls_tmp = ls_str.trim()
   IF ls_tmp.getIndexOf("where",1) THEN
      LET ls_tmp = ls_tmp.subString(1,ls_tmp.getIndexOf("where",1)-1)
   END IF

   IF ls_mode = "select" OR ls_mode = "delete" THEN
      LET ls_tmp = ls_tmp.subString(ls_tmp.getIndexOf("from",1)+4, ls_tmp.getLength())
      LET ls_tmp = ls_tmp.trim()
   ELSE   #update
      LET ls_tmp = ls_tmp.subString(ls_tmp.getIndexOf("update",1)+6, ls_tmp.getLength())
      LET ls_tmp = ls_tmp.trim()
      IF ls_tmp.getIndexOf("set ",1) THEN
         LET ls_tmp = ls_tmp.subString(1,ls_tmp.getIndexOf("set ",1)-1)
      END IF
   END IF
   LET ls_tabid = ls_tmp.trim()
   RETURN ls_tabid.trim()
END FUNCTION
