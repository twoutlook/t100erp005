SCHEMA ds


MAIN 
   DEFINE ls_sql STRING
   DEFINE ls_sql2 STRING
   DEFINE li_cnt INT
   DEFINE lc_gztz001 LIKE gztz_t.gztz001
   DEFINE lc_gztz002 LIKE gztz_t.gztz002
   DEFINE li_ent INT
   DEFINE li_newent INT
   DEFINE ls_db  VARCHAR(20)

   LET li_ent = ARG_VAL(1)
   LET li_newent = ARG_VAL(2)
   LET ls_db  = ARG_VAL(3)
   DATABASE ls_db  #請預先準備好FGLPROFILE,並完成環境變數設定

   LET ls_sql = "SELECT gztz001,gztz002 FROM gztz_t where gztz002 like '%ent' ORDER BY gztz001"
   DECLARE cs CURSOR FROM ls_sql
   FOREACH cs INTO lc_gztz001,lc_gztz002
      LET ls_sql2 = "SELECT COUNT(*) FROM ",lc_gztz001 CLIPPED," WHERE ",lc_gztz002 CLIPPED,"=",li_ent USING "<<<<<"
      PREPARE ppid FROM ls_sql2
      EXECUTE ppid INTO li_cnt
#     display '表格:',lc_gztz001,"符合資料:",li_cnt,"筆"
      CLOSE ppid
      FREE ppid
      IF li_cnt=0 THEN CONTINUE FOREACH END IF

      LET ls_sql2 = "UPDATE ",lc_gztz001 CLIPPED," SET ",lc_gztz002 CLIPPED,"=",li_newent USING "<<<<<",
                    " WHERE ",lc_gztz002 CLIPPED,"=",li_ent USING "<<<<<",";"
      DISPLAY ls_sql2
   END FOREACH

END MAIN
