IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
MAIN
   DEFINE ls_path STRING

   CALL cl_db_connect("ds",FALSE)

   INITIALIZE g_xml.* TO NULL

   LET g_xml.mailserver = "imap.mail.yahoo.com"
   LET g_xml.serverport = "993"
   LET g_xml.user = "t100.digiwin@yahoo.com.tw"
   LET g_xml.passwd = "T100dc0371"

   LET ls_path = cl_jmail_receive()

   CALL azzp958_analyze(ls_path)
END MAIN


PRIVATE FUNCTION azzp958_analyze(ls_path)
   DEFINE ls_path    STRING
   DEFINE l_channel  base.Channel
   DEFINE ls_readline   STRING
   DEFINE ls_subject STRING
   DEFINE ls_date    STRING
   DEFINE ls_from    STRING

   #讀取檔案
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(ls_path,"r")
   LET ls_from = ""

   WHILE TRUE
      IF l_channel.isEof() THEN
         EXIT WHILE
      END IF

      LET ls_readline = l_channel.readLine()
      #寄信人FROM:
      IF ls_readline.subString(1,5) = "FROM:" THEN
         #標示上一封信件的結束
         IF ls_from IS NOT NULL THEN
            CALL azzp958_reply(ls_from,ls_date,ls_subject)
         END IF
         LET ls_from = ls_readline.subString(6,ls_readline.getLength())
      END IF

      #寄信時間SENT DATE:
      IF ls_readline.subString(1,10) = "SENT DATE:" THEN
         LET ls_date = ls_readline.subString(11,ls_readline.getLength())
      END IF
      #標題SUBJECT:
      IF ls_readline.subString(1,8) = "SUBJECT:" THEN
         LET ls_subject = ls_readline.subString(9,ls_readline.getLength())
      END IF

   END WHILE

   IF ls_from IS NOT NULL THEN
      CALL azzp958_reply(ls_from,ls_date,ls_subject)
   END IF
   CALL l_channel.close()

END FUNCTION
 

PRIVATE FUNCTION azzp958_reply(ls_from,ls_date,ls_subject)
   DEFINE lc_channel  base.Channel
   DEFINE ls_file    STRING
   DEFINE ls_tmp     STRING
   DEFINE ls_subject STRING
   DEFINE ls_date    STRING
   DEFINE ls_from    STRING
   DEFINE ls_text    STRING

   INITIALIZE g_xml.* TO NULL

   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),FGL_GETPID()||".msg")

   #信件檔案
   LET lc_channel = base.Channel.create()
   CALL lc_channel.openFile( ls_file CLIPPED, "a" )
   CALL lc_channel.setDelimiter("")
   LET ls_text = "T100用戶您好,\n您在",ls_date,"寄出關於",ls_subject,"信件已收到,\n謝謝"
   CALL lc_channel.write(ls_text)
   CALL lc_channel.close()
   #信件主旨
   LET g_xml.subject = "Re:",ls_subject
   #信件本文
   LET g_xml.body = ls_file
   #寄信人
   LET g_xml.sender = "t100.digiwin@yahoo.com.tw:回信機器人"
   #收件者
   LET g_xml.recipient = ls_from
display '寄出回信給：',ls_from

   #寄發mail
   CALL cl_jmail() RETURNING ls_tmp
END FUNCTION
