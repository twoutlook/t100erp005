
IMPORT os

DEFINE gs_lng_table STRING 
DEFINE gs_prog STRING 
MAIN
   LET gs_lng_table = ARG_VAL(1) CLIPPED
   #DISPLAY "gs_prog:",gs_prog
   #LET ls_path = FGL_GETENV(gs_lng_table) #/u1/t10dit/com #先做lib sub qry 
   CALL test_gen_lng_process_working()
END MAIN 


#+處理模組下4gl目錄
PRIVATE FUNCTION test_gen_lng_process_dir(ls_path)
   DEFINE li_h         INTEGER 
   DEFINE ls_path      STRING 
   DEFINE ls_child     STRING
   DEFINE lb_chk       SMALLINT 
   DEFINE ls_msg       STRING
   DEFINE ls_table_name STRING    

   LET li_h = os.Path.diropen(ls_path)
   WHILE li_h > 0
      #IF INT_FLAG THEN CALL azzp181_suspend() END IF
      LET ls_child = os.Path.dirnext(li_h)
      IF ls_child IS NULL THEN EXIT WHILE END IF
      IF ls_child == "." OR ls_child == ".." THEN CONTINUE WHILE END IF
    
      IF os.path.extension(ls_child) = "4gl" THEN
         LET gs_prog = os.path.rootname(ls_child)  #cl_cmdrun.4gl
         DISPLAY "gs_prog:",gs_prog
         LET ls_table_name = test_gen_lng_table() 
         DISPLAY "ls_table_name:",ls_table_name
         CALL test_gen_lng_4gl(ls_table_name)
         #IF NOT azzp181_chk_file() THEN 
              #DISPLAY "檔案來源不存在:",gs_sample_filename
              #RETURN  
         #  END IF
         #  CALL azzp181_chk_memo() RETURNING lb_chk,ls_msg
         #  IF lb_chk THEN 
         #     CALL azzp181_read_and_replace()
         #  ELSE 
         #     DISPLAY "未通過fglcomp 工具檢查:",ls_msg  
         #  END IF 
      END IF 
   END WHILE
   CALL os.Path.dirclose(li_h)
END FUNCTION

PRIVATE FUNCTION test_gen_lng_process_working()
   DEFINE ls_path    STRING 
   DEFINE ls_target  STRING  
   DEFINE li_h       INTEGER 
   DEFINE ls_child   STRING
   LET ls_path = FGL_GETENV(UPSHIFT(gs_lng_table))
   DISPLAY "ls_path:",ls_path
   IF NOT os.Path.isdirectory(ls_path) THEN 
      DISPLAY "Warning:不是一個目錄"
      RETURN 
   END IF 
   LET li_h = os.Path.diropen(ls_path) 
   WHILE li_h > 0
      LET ls_child = os.Path.dirnext(li_h)
      LET ls_child = ls_child.trim()
      IF ls_child IS NULL THEN EXIT WHILE END IF
      IF ls_child == "." OR ls_child == ".." THEN CONTINUE WHILE END IF
      DISPLAY "ls_child:",ls_child
      IF NOT ls_child.getIndexOf("4gl",1) THEN 
         CONTINUE WHILE 
      END IF 
      LET ls_target = os.Path.join(ls_path,ls_child)  
   END WHILE 
   CALL os.Path.dirclose(li_h)
   CALL test_gen_lng_process_dir(ls_target)

END FUNCTION  


PRIVATE FUNCTION test_gen_lng_table()
   DEFINE li SMALLINT 
   DEFINE ls_table_id STRING  
   LET li = gs_prog.getIndexOf("n_",1)
   LET ls_table_id = gs_prog.subString(li+2,gs_prog.getLength()),"_t"
   RETURN ls_table_id
END FUNCTION 


PRIVATE FUNCTION test_gen_lng_4gl(ls_table_name)
   DEFINE ls_table_name STRING 
   DEFINE ls_cmd STRING 
   #LET ls_cmd = os.path.join("adz",os.path.join("42r","adzp140")) 
   #LET ls_cmd = FGL_GETENV("FGLRUN") ," ",  os.path.join(FGL_GETENV("TOP"),os.path.join("erp",ls_cmd)) , " " , ls_table_name
   #LET ls_cmd = ls_cmd , " " , ls_table_name 
   LET ls_cmd = "r.r adzp140 " ,ls_table_name
   DISPLAY "ls_cmd:",ls_cmd
   RUN ls_cmd
   
END FUNCTION 




