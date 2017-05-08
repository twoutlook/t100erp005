IMPORT os
SCHEMA ds

MAIN 
   DEFINE ls_sql STRING
   DEFINE ls_sql2 STRING
   DEFINE li_cnt INT
   DEFINE lc_gztz001 LIKE gztz_t.gztz001
   DEFINE lc_gztz002 LIKE gztz_t.gztz002
   DEFINE li_ent INT
   DEFINE ls_db  VARCHAR(20)
   DEFINE ls_tabid STRING
   DEFINE lc_channel  base.channel
   DEFINE lc_imp  base.channel
   DEFINE ls_filename  STRING

   LET li_ent = ARG_VAL(1)
   LET ls_db  = ARG_VAL(2)
   DATABASE ls_db  #請預先準備好FGLPROFILE,並完成環境變數設定

   IF os.Path.mkdir(os.Path.join(FGL_GETENV("TEMPDIR"),li_ent USING "<<<<<")) THEN END IF
   LET ls_filename = os.Path.join(FGL_GETENV("TEMPDIR"),li_ent USING "<<<<<")
   LET lc_channel = base.Channel.create()
   CALL lc_channel.openFile(os.Path.join(ls_filename,"exp2016.sh"),"a")
   CALL lc_channel.setDelimiter("")

   LET lc_imp = base.Channel.create()
   CALL lc_imp.openFile(os.Path.join(ls_filename,"imp2016.sh"),"a")
   CALL lc_imp.setDelimiter("")

   LET ls_sql = "SELECT gztz001,gztz002 FROM gztz_t where gztz002 like '%ent' ORDER BY gztz001"
   DECLARE cs CURSOR FROM ls_sql
   FOREACH cs INTO lc_gztz001,lc_gztz002
      LET ls_sql2 = "SELECT COUNT(*) FROM ",lc_gztz001 CLIPPED," WHERE ",lc_gztz002 CLIPPED,"=",li_ent
      PREPARE ppid FROM ls_sql2
      EXECUTE ppid INTO li_cnt
      CLOSE ppid
      FREE ppid
      IF li_cnt = 0 THEN CONTINUE FOREACH END IF

      display '表格:',lc_gztz001,"符合資料:",li_cnt,"筆"
      LET ls_tabid = lc_gztz001
      LET ls_tabid = ls_tabid.subString(1,ls_tabid.getIndexOf("_t",1)-1)
      LET ls_sql2 = 'exp dsdemo/dsdemo8 file=',ls_filename,'/',ls_tabid,'.dmp ',
                    'tables="',lc_gztz001 CLIPPED,'" QUERY=\\" where ',ls_tabid,'ent=',li_ent USING "<<<<<",'\\"'
      
      CALL lc_channel.write(ls_sql2)
      DISPLAY ls_sql2

      LET ls_sql2 = 'imp dsdemo/dsdemo8 file=',ls_filename,'/',ls_tabid,'.dmp ignore=Y'
      CALL lc_imp.write(ls_sql2)
      DISPLAY ls_sql2
   END FOREACH
   CALL lc_channel.close()

END MAIN
