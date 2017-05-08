IMPORT os
SCHEMA ds

MAIN
   DEFINE ls_sql  STRING
   DEFINE lr_gzdc RECORD
          gzdc002 LIKE gzdc_t.gzdc002
          END RECORD 
   DEFINE lchannel_write          base.Channel
   DEFINE ls_code_filename        STRING
   DEFINE ls_define               STRING
   DEFINE ls_table                VARCHAR(50)
   DEFINE li_cnt                  INTEGER
   
   CALL cl_db_connect("ds",FALSE)
   
   LET ls_table = ARG_VAL(2)
   IF cl_null(ls_table) THEN
      LET ls_table = 'ALL'
   END IF

   #檢查是否需要重產
   LET li_cnt = 0
   SELECT COUNT(*) INTO li_cnt FROM gzdc_t WHERE gzdc002 = ls_table
    
   IF li_cnt = 0 AND ls_table <> 'ALL' THEN
      DISPLAY 'Info:此次處理為(',ls_table,'),不進行重產動作!'
      RETURN
   ELSE
      DISPLAY 'Info:此次處理為(',ls_table,'),進行expand.inc重產!'
   END IF
   
   LET lchannel_write = base.Channel.create()
   CALL lchannel_write.setDelimiter("")
   
   LET ls_code_filename = os.Path.join(FGL_GETENV('COM'),"inc")
   LET ls_code_filename = os.Path.join(ls_code_filename,"erp")
   LET ls_code_filename = os.Path.join(ls_code_filename,"top_global_expand.inc")
   
   CALL lchannel_write.openFile( ls_code_filename, "w" )
   
   #產生程式版本及說明
   CALL lchannel_write.write("#>>> top_global.inc額外變數定義檔 <<<")
   
   LET ls_sql = " SELECT UNIQUE(gzdc002) FROM gzdc_t "
   
   PREPARE gzdc_pre FROM ls_sql
   DECLARE gzdc_cur CURSOR FOR gzdc_pre
   
   #根據設定的table產出定義段
   FOREACH gzdc_cur INTO lr_gzdc.gzdc002
      LET ls_define = adzp156_write_file(lr_gzdc.gzdc002)
      CALL lchannel_write.write(ls_define)
   END FOREACH
   
   CALL lchannel_write.close()
    
END MAIN

PRIVATE FUNCTION adzp156_write_file(ps_gzdc002)
   DEFINE ps_gzdc002      LIKE gzdc_t.gzdc002
   DEFINE ls_gztz002      LIKE gztz_t.gztz002
   DEFINE ls_table        STRING
   DEFINE ls_sql          STRING
   DEFINE ls_pre          STRING
   DEFINE ls_return       STRING
           
   LET ls_table = ps_gzdc002
        
   LET ls_sql = " SELECT gztz002 FROM gztz_t ",
                "  WHERE gztz001 = '",ls_table,"' ORDER BY gztz005"
   
   PREPARE gztz_pre FROM ls_sql
   DECLARE gztz_cur CURSOR FOR gztz_pre
   
   LET ls_pre = ls_table.subString(1,ls_table.getIndexOf("_",1)-1)
   
   LET ls_return = "DEFINE g_", ls_pre, " RECORD \n"
   
   #讀取指定的表格並產出DEFINE
   FOREACH gztz_cur INTO ls_gztz002
      LET ls_return = ls_return, "   ", ls_gztz002, " LIKE ", ls_table, ".", ls_gztz002, ",\n"
   END FOREACH
   
   LET ls_return = ls_return.subString(1,ls_return.getLength()-2), "\nEND RECORD \n\n"
   
   RETURN ls_return
    
END FUNCTION 
