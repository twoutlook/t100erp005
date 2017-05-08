#&define DEBUG

IMPORT os
IMPORT util

SCHEMA ds

#執行的環境變數
DEFINE ms_dgenv STRING

MAIN

   DEFINE lo_channel_read         base.Channel
   DEFINE ls_read_line            STRING
   DEFINE ls_line_text            STRING
   DEFINE ls_file_name            STRING
   DEFINE ls_module_name          STRING
   DEFINE ls_component_path       STRING
   DEFINE ls_tgl_mod_name         STRING
   DEFINE ls_tgl_file_name        STRING
   DEFINE ls_tgl_main_name        STRING
   DEFINE ls_tgl_random_name      STRING
   DEFINE li_copy_status          INTEGER
   DEFINE ls_random_name          STRING
   DEFINE ls_curr_working_path    STRING
   DEFINE ls_prev_working_path    STRING
   ################################################
   DEFINE ls_arg_val1             STRING
   DEFINE ls_arg_val2             STRING
   DEFINE ls_arg_val3             STRING
   ################################################
   DEFINE lo_line_string_buf      base.StringBuffer
   DEFINE lo_add_point_string_buf base.StringBuffer
   ################################################
   DEFINE ls_4gl_file_name        STRING
   DEFINE ls_4gl_back_file_name   STRING
   DEFINE ls_4gl_path_name        STRING
   ################################################
   DEFINE ls_tgl_ext_name         STRING
   DEFINE ls_4gl_ext_name         STRING
   DEFINE ls_4gl_bak_ext_name     STRING
   ################################################
   DEFINE ls_4gl_text             STRING
   DEFINE ls_point_name           STRING
   DEFINE ls_point_begin          INTEGER
   DEFINE ls_point_end            INTEGER

   &ifndef DEBUG
     #CONNECT TO "ds"
     CALL cl_tool_init()
   &else
     CONNECT TO "local"
   &endif
   
   #取得參數
   LET ls_arg_val1 = ARG_VAL(2) #Program Name
   LET ls_arg_val2 = ARG_VAL(3) #Module Name
   LET ls_arg_val3 = ARG_VAL(4) #Module Path

   #驗證參數
   &ifndef DEBUG
   CALL adzp115_check_argument(ls_arg_val1) RETURNING ls_arg_val1 
   IF ls_arg_val1 IS NULL THEN
     EXIT PROGRAM
   ELSE
     LET ls_file_name = ls_arg_val1
   END IF
   &endif

   ##############################
   #begin For Debug
   IF ls_arg_val1 IS NULL THEN
     LET ls_file_name = "s_aooi150"
   END IF  
   #end For Debug
   ##############################

   #取得模組名稱
   IF ls_arg_val2 IS NULL THEN
     LET ls_module_name = ls_file_name.subString(1,3)
   ELSE  
     LET ls_module_name = ls_arg_val2.trim()
   END IF

   LET ls_component_path = ls_arg_val3

   #取得標準或是客製化變數
   LET ms_dgenv = NVL(FGL_GETENV("DGENV"),"s")

   #設定延伸檔名
   LET ls_4gl_ext_name  = "4gl"
   LET ls_tgl_ext_name  = "tgl"
   LET ls_4gl_path_name = "../../4gl/"
   
   #取得及切換目前工作目錄
   CALL os.Path.pwd() RETURNING ls_prev_working_path
   IF ls_component_path IS NOT NULL THEN
     IF ls_module_name.toUpperCase() = "SUB" OR ls_module_name.toUpperCase() = "LIB" THEN
       LET ls_curr_working_path = os.Path.join(FGL_GETENV("COM"),ls_component_path)
     ELSE
       LET ls_curr_working_path = os.Path.join(FGL_GETENV("ERP"),ls_component_path)
     END IF  
   ELSE
     IF ls_module_name.toUpperCase() = "SUB" OR ls_module_name.toUpperCase() = "LIB" THEN
       LET ls_curr_working_path = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("COM"),ls_module_name),"dzx"),"tgl")
     ELSE
       LET ls_curr_working_path = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("ERP"),ls_module_name),"dzx"),"tgl")
     END IF  
   END IF
   CALL adzp115_change_working_path(ls_curr_working_path)
   
   #建立　String Buffer 讀取通道
   LET lo_channel_read = base.Channel.create()
   LET lo_line_string_buf = base.StringBuffer.create()
   LET lo_add_point_string_buf = base.StringBuffer.create()

   CALL lo_channel_read.setDelimiter("")
   
   #呼叫亂數產生器
   CALL util.Math.srand()
   
   #定義取用樣板檔案(先將原始檔案複製一份為亂數取碼的檔案, 再讀取這個檔案, 避免同時間多人讀取情形)
   LET ls_tgl_file_name = ls_file_name,".",ls_tgl_ext_name
   LET ls_tgl_main_name = ls_file_name
   LET ls_tgl_mod_name  = ls_module_name #ls_tgl_file_name.subString(1,3)
   CALL adzp115_gen_random_name() RETURNING ls_random_name #產生亂數副檔名
   LET ls_tgl_random_name = ls_tgl_file_name,".",ls_random_name

   IF os.path.exists(ls_tgl_file_name) THEN
     CALL os.Path.copy(ls_tgl_file_name,ls_tgl_random_name) RETURNING li_copy_status 
     IF li_copy_status > 0 THEN
       DISPLAY "Original file ",ls_tgl_file_name," copy to : ",ls_tgl_random_name
     END IF
   ELSE
     DISPLAY "Error : ",ls_tgl_ext_name," File ",ls_tgl_file_name," not exist !! Program terminated !!"
     EXIT PROGRAM
   END IF
 
   #讀取 tgl 檔案
   CALL lo_channel_read.openFile(ls_tgl_random_name CLIPPED, "r" )

   #############################################################################
   
   #讀取及轉換
   WHILE TRUE
     LET ls_line_text = ""
     LET ls_read_line = lo_channel_read.readLine()
     IF lo_channel_read.isEof() THEN
        EXIT WHILE
     END IF

     #取得模組 Add Point 的程式區段
     IF ls_read_line.getIndexOf("point name",1) > 0 THEN
       LET ls_point_begin = ls_read_line.getIndexOf("{<point name=""",1) + 14
       LET ls_point_end   = ls_read_line.getIndexOf("""/>}",1) - 1
       LET ls_point_name  = ls_read_line.subString(ls_point_begin,ls_point_end)
       CALL adzp115_get_custom_component(ls_file_name,ls_point_name) RETURNING ls_4gl_text
       LET ls_line_text = ls_4gl_text
       CALL lo_line_string_buf.append(ls_line_text)
     ELSE
       LET ls_line_text = ls_read_line,"\n"
       CALL lo_line_string_buf.append(ls_line_text)
     END IF
     
   END WHILE

   #產出自定義函數的區段
   LET ls_4gl_text = ""
   CALL adzp115_get_custom_component(ls_file_name,"function") RETURNING ls_4gl_text
   LET ls_4gl_text = ls_4gl_text,"\n"
   CALL lo_line_string_buf.append(ls_4gl_text)
   
   #讀檔 Channel 關檔
   CALL lo_channel_read.close()
   
   #############################################################################
   
   #將舊4gl檔案備份
   LET ls_4gl_bak_ext_name   = (TODAY USING "yyyymmdd")
   LET ls_4gl_file_name      = ls_4gl_path_name,ls_file_name,".",ls_4gl_ext_name
   LET ls_4gl_back_file_name = ls_4gl_path_name,ls_file_name,".",ls_4gl_ext_name,".bak.",ls_4gl_bak_ext_name
   CALL adzp115_backup_file(ls_4gl_file_name,ls_4gl_back_file_name)

   #開檔將String Buffer寫入實體檔案
   CALL adzp115_write_file(ls_4gl_file_name,lo_line_string_buf.toString()) #4gl File
   
   #刪除檔案
   CALL adzp115_delete_backup_file(ls_tgl_random_name)
   #CALL adzp115_delete_backup_file(ls_4gl_back_file_name)

   #切換回原始工作目錄
   CALL adzp115_change_working_path(ls_prev_working_path)
   #DISPLAY "[COMPLETE] Generate Component"
   
END MAIN

#
FUNCTION adzp115_get_custom_component(p_file_name,p_point_name)
DEFINE
  p_file_name  STRING,
  p_point_name STRING
DEFINE
  ls_file_name    STRING,
  ls_point_name   STRING,
  ls_4gl_contents STRING,
  lsb_4gl_strbuf  base.StringBuffer,
  ls_sql_cond     STRING,
  ls_sql          STRING,
  lo_contents RECORD
                function_name     LIKE DZBB_T.DZBB002,
                point_version     LIKE DZBB_T.DZBB003,
                point_type        LIKE DZBB_T.DZBB004,
                standard_contents TEXT,
                custom_contents   TEXT
              END RECORD
DEFINE
  ls_4GL_Return STRING

  LET ls_file_name  = p_file_name
  LET ls_point_name = p_point_name

  LET ls_4GL_Return = ""
  LET ls_sql_cond   = ""

  LET lsb_4gl_strbuf = base.StringBuffer.create()
  CALL lsb_4gl_strbuf.clear()

  IF ls_point_name.toLowerCase() = "function" THEN
    LET ls_sql_cond = " AND LOWER(BB.DZBB002) LIKE 'function%' "
  ELSE
    LET ls_sql_cond = " AND BB.DZBB002 = '",ls_point_name,"' "
  END IF  

  LET ls_sql = "SELECT BB.DZBB002,                                 ",
               "       BB.DZBB003,                                 ",
               "       BB.DZBB004,                                 ", 
               "       BB.DZBB098,                                 ",
               "       ''                                          ",   
               "  FROM DZBB_T BB                                   ",
               " INNER JOIN DZBA_T BA ON BA.DZBA001  = BB.DZBB001  ",
               "                     AND BA.DZBA002  = BB.DZBB003  ",
               "                     AND BA.DZBA003  = BB.DZBB002  ",
               "                     AND BA.DZBASTUS = 'Y'         ",
               " WHERE BB.DZBB001 = '",ls_file_name,"'              ",
               ls_sql_cond

  PREPARE lpre_get_custom_components FROM ls_sql
  DECLARE lcur_get_custom_components CURSOR FOR lpre_get_custom_components

  LOCATE lo_contents.standard_contents IN FILE
  LOCATE lo_contents.custom_contents   IN FILE

  FOREACH lcur_get_custom_components INTO lo_contents.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_4gl_contents = ""

    LET ls_4gl_contents = lo_contents.standard_contents

    IF (ms_dgenv = "0") OR (ms_dgenv = "s") THEN 
      LET ls_4gl_contents = lo_contents.standard_contents
    ELSE
      LET ls_4gl_contents = lo_contents.custom_contents
    END IF  
    
    LET ls_4gl_contents = ls_4gl_contents,"\n"
    
    CALL lsb_4gl_strbuf.append(ls_4gl_contents)   
    
  END FOREACH  
  
  CLOSE lcur_get_custom_components
  
  LET ls_4GL_Return = lsb_4gl_strbuf.toString()
  
  FREE lo_contents.standard_contents
  FREE lo_contents.custom_contents
  FREE lcur_get_custom_components
  FREE lpre_get_custom_components

  RETURN ls_4GL_Return

END FUNCTION

################################################################################
#+ Other Functions
################################################################################

#以亂數產出副檔名
FUNCTION adzp115_gen_random_name()
DEFINE
  lr_randomname RECORD
    segment1 STRING,
    segment2 STRING,
    segment3 STRING,
    segment4 STRING
  END RECORD
DEFINE 
  li_random_value   INTEGER,
  li_max_random_num INTEGER,
  ls_final_name     STRING,
  ls_using_format   STRING
DEFINE  
  ls_return STRING

  LET li_max_random_num = 9999
  LET ls_using_format  = "&&&&"
  
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment1 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment2 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment3 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment4 = li_random_value USING ls_using_format
  
  LET ls_final_name = lr_randomname.segment1,".",
                      lr_randomname.segment2,".",
                      lr_randomname.segment3,".",
                      lr_randomname.segment4

  LET ls_return = ls_final_name
  
  RETURN ls_return                     
  
END FUNCTION

#+ 檢核輸入的參數
FUNCTION adzp115_check_argument(p_value)
DEFINE 
  p_value STRING
DEFINE 
  l_value    STRING,
  ls_crlf    STRING,
  ls_command STRING
DEFINE 
  l_return STRING

  LET l_value  = p_value
  LET l_return = ""

  LET ls_crlf = "\n"

  IF l_value IS NULL THEN
    LET ls_command = ls_crlf,
                     "Usage : r.r ",ui.Interface.getName()," [ProgramName(or ComponentName)] [ModuleName] [ModulePath]",
                     ls_crlf 
    DISPLAY ls_command
  ELSE
    LET l_return = l_value.trim()
  END IF
  
  RETURN l_return
  
END FUNCTION

FUNCTION adzp115_write_file(p_file_name,p_line_string)
DEFINE
  p_file_name   STRING,
  p_line_string STRING
DEFINE   
  ls_file_name      STRING,
  ls_line_string    STRING,
  lo_channel_write  base.Channel

  LET ls_file_name   = p_file_name
  LET ls_line_string = p_line_string

  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  DISPLAY ls_file_name
  
  CALL lo_channel_write.openFile(ls_file_name, "w" )
  CALL lo_channel_write.write(ls_line_string)
  CALL lo_channel_write.close()
   
END FUNCTION

FUNCTION adzp115_backup_file(p_src_filename,p_dst_filename)
DEFINE
  p_src_filename STRING,
  p_dst_filename STRING
DEFINE   
  ls_src_filename STRING,
  ls_dst_filename STRING,
  li_rename_status INTEGER

  LET ls_src_filename = p_src_filename
  LET ls_dst_filename = p_dst_filename

   CALL os.Path.rename(ls_src_filename,ls_dst_filename) RETURNING li_rename_status
   IF li_rename_status > 0 THEN
     DISPLAY "Original file ",ls_src_filename," rename to : ",ls_dst_filename
   END IF  
   
END FUNCTION

FUNCTION adzp115_delete_backup_file(p_file_name)
DEFINE
  p_file_name STRING
DEFINE   
  ls_file_name     STRING,
  li_delete_status INTEGER

  LET ls_file_name = p_file_name
  
  CALL os.Path.delete(ls_file_name) RETURNING li_delete_status #刪除tst備份檔
  
  IF li_delete_status > 0 THEN
    DISPLAY ls_file_name," Delete SUCCESS !!"
  ELSE  
    DISPLAY ls_file_name," Delete FAULT !!"
  END IF
   
END FUNCTION

FUNCTION adzp115_change_working_path(p_working_path)
DEFINE
  p_working_path STRING
DEFINE
  ls_curr_working_path STRING,
  ls_pwd               STRING,
  ls_status            STRING,
  li_chdir_status      INTEGER
  
  LET ls_curr_working_path = p_working_path
  LET ls_status = ""
  
  CALL os.Path.chdir(ls_curr_working_path) RETURNING li_chdir_status
  CASE
    WHEN li_chdir_status = 0
      LET ls_status = "FAULT"
    WHEN li_chdir_status = 1
      LET ls_status = "SUCCESS" 
    OTHERWISE
      LET ls_status = ""
  END CASE
  
  DISPLAY "Changing path to : ",ls_curr_working_path," --> ",ls_status
  CALL os.Path.pwd() RETURNING ls_pwd
  DISPLAY "Current working path : ",ls_pwd
  
END FUNCTION