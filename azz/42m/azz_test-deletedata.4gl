SCHEMA ds


MAIN 
   DEFINE ls_sql STRING
   DEFINE ls_sql2 STRING
   DEFINE li_cnt INT
   DEFINE lc_gztz001 LIKE gztz_t.gztz001
   DEFINE lc_gztz002 LIKE gztz_t.gztz002
   DEFINE li_ent INT
   DEFINE ls_db  VARCHAR(20)

   LET li_ent = ARG_VAL(1)
   LET ls_db  = ARG_VAL(2)
   DATABASE ls_db  #請預先準備好FGLPROFILE,並完成環境變數設定

   LET ls_sql = "SELECT gztz001,gztz002 FROM gztz_t where gztz002 like '%ent'"
   DECLARE cs CURSOR FROM ls_sql
   FOREACH cs INTO lc_gztz001,lc_gztz002
      LET ls_sql2 = "SELECT COUNT(*) FROM ",lc_gztz001 CLIPPED," WHERE ",lc_gztz002 CLIPPED,"=",li_ent
      PREPARE ppid FROM ls_sql2
      EXECUTE ppid INTO li_cnt
      display '表格:',lc_gztz001,"符合資料:",li_cnt,"筆"
      CLOSE ppid
      FREE ppid

      LET ls_sql2 = "DELETE FROM ",lc_gztz001 CLIPPED," WHERE ",lc_gztz002 CLIPPED,"=",li_ent
      PREPARE ppid2 FROM ls_sql2
      EXECUTE ppid2
      CLOSE ppid2
      FREE ppid2
   END FOREACH

   LET ls_sql2 = "DELETE FROM gzoul_t WHERE gzoul001=",li_ent
   PREPARE ppid3 FROM ls_sql2
   EXECUTE ppid3
   CLOSE ppid3
   FREE ppid3

   LET ls_sql2 = "DELETE FROM gzou_t WHERE gzou001=",li_ent
   PREPARE ppid4 FROM ls_sql2
   EXECUTE ppid4
   CLOSE ppid4
   FREE ppid4

END MAIN
