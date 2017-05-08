#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzp140
#+ Buildtype: 
#+ Memo.....: 多語言畫面自動產生工具
#160519-00018 #1 2016/05/19 by jrg542 多語言產生器調整編譯順序位置及增加全部重產功能
 
IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS 
   DEFINE g_properties    om.SaxAttributes 
   DEFINE g_table_id STRING    #table id

   TYPE type_g_table_info RECORD 
     table_id     LIKE dzeb_t.dzeb001,    #table id
     field_id     LIKE dzeb_t.dzeb002,    #field id
     field_pk     LIKE dzeb_t.dzeb004,    #是否 pk
     field_type   LIKE dzeb_t.dzeb006,    #field 屬性 (field type ex:230)
     widge_code   LIKE dzep_t.dzep010,    #widge code (ex:05)
     field_ent    LIKE type_t.num5,       #是否 ent
     field_lang   LIKE type_t.num5        #是否 lang 語言別     
   END RECORD
     
   DEFINE g_table_info     DYNAMIC ARRAY OF type_g_table_info     
   DEFINE g_key_count      LIKE type_t.num5  #key 總數  
   DEFINE g_pkey_count     LIKE type_t.num5  #pk 總數 
   DEFINE gs_code_filename STRING            #4gl 檔案名稱
   DEFINE g_generation_ch  base.Channel
   DEFINE gs_log_file      STRING 
   DEFINE gs_log_path      STRING
END GLOBALS 

PUBLIC CONSTANT li_space = 3 #空三格

MAIN
   DEFINE ls_code_filename  STRING

   LET ls_code_filename = ARG_VAL(2) CLIPPED 

   display "ARG_VAL(1) ",ARG_VAL(1) #程式編號
   display "ARG_VAL(2) ",ARG_VAL(2) #是否全部重產生 (all)
   display "ARG_VAL(3) ",ARG_VAL(3) #是否編譯      (Y:編譯 N:不編譯)
   display "ARG_VAL(4) ",ARG_VAL(4) #是否link     (Y:link N:不link)

   CALL cl_db_connect("ds", FALSE)
   #查t100debug
   LET g_t100debug = FGL_GETENV("T100DEBUG")
   #160519-00018 #1 add 

   IF UPSHIFT(ARG_VAL(2)) = "ALL" THEN 
      CALL sadzp140_gen_all()
   ELSE
     #4gl建置成功時, 再續建4fd
     IF sadzp140_gen_4gl(ls_code_filename) THEN
        CALL sadzp140_generate_4fd()
        IF ARG_VAL(3) IS NULL OR UPSHIFT(ARG_VAL(3)) = "Y" OR ARG_VAL(3) = "tiptop" THEN
           #編譯4gl 
           CALL sadzp140_compile_file("1")
           #編譯4fd
           CALL sadzp140_compile_file("2")
           IF ARG_VAL(4) IS NULL OR UPSHIFT(ARG_VAL(4)) = "Y" THEN  
              #連結lng.42x
              CALL sadzp140_compile_file("3")
           END IF 
       END IF 
     END IF   
   END IF
   #160519-00018 #1 end 

#160519-00018 #1 mark   
   #4gl建置成功時, 再續建4fd
#   IF sadzp140_gen_4gl(ls_code_filename) THEN
#      CALL sadzp140_generate_4fd()
#      
#  
#      IF ARG_VAL(3) IS NULL OR UPSHIFT(ARG_VAL(3)) = "Y" THEN
#         編譯4gl 
#         CALL sadzp140_compile_file("1")
#         編譯4fd
#         CALL sadzp140_compile_file("2")
#         
#      END IF 
#   END IF
   #連結lng.42x
   #CALL sadzp140_compile_file("3")
#160519-00018 #1 end   
END MAIN


#+ 監看ps 是否結束
PRIVATE FUNCTION adzp140_watch_ps()
   DEFINE lch_pipe    base.Channel
   DEFINE ls_tmp      STRING 
   DEFINE ls_cmd      STRING 
   DEFINE ls_temp     STRING
   DEFINE lt_temp_start    DATETIME YEAR TO SECOND
   DEFINE li_chk      LIKE type_t.num5
   DEFINE li_cnt      LIKE type_t.num5 

   LET li_chk = FALSE 
   LET ls_cmd = "ps -ef | grep adzp140 |grep -v grep|  grep -v 'sh -c' | grep -v 'all' | grep -v 'ALL' | wc -l" 
   
   DISPLAY "ls_cmd ",ls_cmd
   WHILE TRUE
      LET lch_pipe = base.Channel.create()

      CALL lch_pipe.openPipe(ls_cmd, "r")
      LET ls_tmp = ""
      WHILE lch_pipe.read(ls_tmp)
        IF ls_tmp.trim() IS NULL THEN CONTINUE WHILE END IF

        DISPLAY "Process cnt ",li_cnt
        IF li_cnt > 0 THEN 
           LET li_chk = TRUE
           EXIT WHILE
        ELSE   
           EXIT WHILE 
        END IF 

      END WHILE
      CALL lch_pipe.close()

      IF li_chk THEN
         LET li_chk =  FALSE 

         SLEEP 1 
      ELSE 
         EXIT WHILE 
      END IF 

   END WHILE 
   
END FUNCTION  
