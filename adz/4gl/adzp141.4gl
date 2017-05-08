#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzp141
#+ Buildtype: 
#+ Memo.....: 提速檔自動產生工具


IMPORT os
SCHEMA ds
 
PUBLIC CONSTANT li_space = 3 #空三格
DEFINE g_table_id STRING    #table id
DEFINE g_properties    om.SaxAttributes 

DEFINE gs_code_filename STRING 


MAIN
   CONNECT TO "ds"
   #準備產生4gl
   CALL adzp141_generate_4gl()
   #編譯檔案
   CALL adzp141_compile_file("2")
END MAIN


#+準備產生4gl
PUBLIC FUNCTION adzp141_generate_4gl()
 
   DEFINE ls_code_filename        STRING

   #取出傳入值,確認此table是否已存在系統中  #ARG_VAL(2)
   LET ls_code_filename = ARG_VAL(2) CLIPPED  #table_id gzzal_t

   DISPLAY "來源檔:",ls_code_filename 
   #檢核table
   LET g_properties = om.SaxAttributes.create()
   IF NOT adzp141_chk_table(ls_code_filename) THEN 
      DISPLAY "ERROR:提速檔資料不存在"
      EXIT PROGRAM
   END IF 

   #若存在則用 n_tableid.4gl (去除_t) 存入 ls_code_filename
   LET ls_code_filename = adzp141_trim_table(ls_code_filename)    #n_gzzal_t
   
   CALL g_properties.addAttribute("general_prefix", ls_code_filename)   #general_prefix 程式代號
   CALL g_properties.addAttribute("speed_tbl_name",g_table_id)
   LET gs_code_filename = ls_code_filename #,".4gl"

   #取得table 資訊
   DISPLAY "gs_code_filename:",gs_code_filename
 
   IF NOT adzp141_table_info() THEN  
      DISPLAY "ERROR:提速檔資料設定資料不完整"
      EXIT PROGRAM
   END IF  

   #開始替換變數及產生4gl
   CALL adzp141_read_and_replace()
END FUNCTION


#+ check table
PRIVATE FUNCTION adzp141_chk_table(p_tablei_d)
   DEFINE p_tablei_d  STRING
   DEFINE lc_dzeq008   LIKE  dzeq_t.dzeq008
   DEFINE lc_dzeq001   LIKE  dzeq_t.dzeq001

   LET lc_dzeq008 = p_tablei_d
   SELECT dzeq001 INTO lc_dzeq001 FROM dzeq_t 
    WHERE dzeq007 = 'speed'  
     AND dzeq008 = lc_dzeq008 

   IF NOT cl_null(lc_dzeq001) THEN 
      CALL g_properties.addAttribute("master_tbl_name",lc_dzeq001)
      RETURN TRUE
   ELSE 
      RETURN FALSE   
   END IF     
END FUNCTION


#+ 去除 _t
PRIVATE FUNCTION adzp141_trim_table(ps_code_filename)
   DEFINE ps_code_filename  STRING
   DEFINE l_n         LIKE type_t.num5

   LET ps_code_filename = ps_code_filename.toLowerCase() #table id
   LET g_table_id = ps_code_filename #ooac_t
   LET l_n = ps_code_filename.getIndexOf("_t",1)
   LET ps_code_filename = ps_code_filename.subString(1,l_n-1)  
   LET ps_code_filename = "n_",ps_code_filename
   
   RETURN ps_code_filename
END FUNCTION 


#+取得主檔及提速檔table的相關資訊 
PRIVATE FUNCTION adzp141_table_info()
   DEFINE ls_sql STRING 
   DEFINE lc_dzeq001 LIKE  dzeq_t.dzeq001
   DEFINE lc_dzeq008 LIKE  dzeq_t.dzeq008
   DEFINE lc_dzeq007 LIKE  dzeq_t.dzeq007
   DEFINE lc_dzeq009 LIKE  dzeq_t.dzeq009

   DEFINE ld_arr   DYNAMIC ARRAY OF RECORD 
      dzeb002 LIKE  dzeb_t.dzeb002
      END RECORD 
      
   DEFINE ls_tmp    STRING
   DEFINE li LIKE type_t.num5
   DEFINE li_rnt LIKE  type_t.num5
   
   #取得主檔
   LET lc_dzeq008 = g_table_id
   LET lc_dzeq001 = g_properties.getValue("master_tbl_name")
   LET li_rnt = TRUE  
   LET ls_sql = " SELECT dzeq007,dzeq009 FROM dzeq_t WHERE dzeq001 = ? " 

   PREPARE adzp141_pb FROM ls_sql
   DECLARE adzp141_cs CURSOR FOR adzp141_pb
   OPEN adzp141_cs USING lc_dzeq001
   FOREACH adzp141_cs INTO lc_dzeq007,lc_dzeq009

      IF SQLCA.sqlcode THEN
         DISPLAY "ERROR: FOREACH ",SQLCA.sqlcode 
         RETURN FALSE 
      END IF 
      CASE
         WHEN lc_dzeq007 = "id"
              CALL g_properties.addAttribute("master_field_lid",lc_dzeq009)
              
         WHEN lc_dzeq007 = "pid"
              CALL g_properties.addAttribute("master_field_pid",lc_dzeq009)

      END CASE   
      
   END FOREACH 
   
   CLOSE adzp141_cs
   FREE adzp141_pb
   #取得提速檔
   LET ls_sql = " SELECT dzeq007,dzeq009 FROM dzeq_t WHERE dzeq001 = ? " 
   PREPARE adzp141_pb2 FROM ls_sql
   DECLARE adzp141_cs2 CURSOR FOR adzp141_pb2
   OPEN adzp141_cs2 USING lc_dzeq008
   FOREACH adzp141_cs2 INTO lc_dzeq007,lc_dzeq009

      IF SQLCA.sqlcode THEN
         DISPLAY "ERROR: FOREACH ",SQLCA.sqlcode 
         RETURN FALSE 
      END IF 
      
      CASE
         WHEN lc_dzeq007 = "sid"
              CALL g_properties.addAttribute("speed_field_lid",lc_dzeq009)
         WHEN lc_dzeq007 = "spid"
              CALL g_properties.addAttribute("speed_field_pid",lc_dzeq009)
              CALL g_properties.addAttribute("speed_var_ancestors",lc_dzeq009) 
      END CASE

   END FOREACH 
   CLOSE adzp141_cs2
   FREE adzp141_pb2
   
   #取這個table所有欄位,再找出欄位屬於階層
   LET ls_sql = " SELECT dzeb002 FROM dzeb_t  WHERE dzeb001 = ? " 
   PREPARE adzp141_pb3 FROM ls_sql
   DECLARE adzp141_cs3 CURSOR FOR adzp141_pb3
   OPEN adzp141_cs3 USING lc_dzeq008 

   LET li = 1
   FOREACH adzp141_cs3 INTO ld_arr[li].dzeb002
       IF SQLCA.sqlcode THEN
         DISPLAY "ERROR: FOREACH ",SQLCA.sqlcode 
         RETURN FALSE 
       END IF 
      LET ls_tmp = ld_arr[li].dzeb002 

      LET li = li + 1
      
      IF ls_tmp.getIndexOf("ent",1) THEN 
           CALL g_properties.addAttribute("speed_field_ent",ls_tmp)
           CONTINUE FOREACH 
      END IF 
      IF  ls_tmp <> g_properties.getValue("speed_field_lid") AND 
          ls_tmp <> g_properties.getValue("speed_field_pid") THEN 
         IF NOT cl_null(g_properties.getValue("speed_field_layer"))  THEN 
            CONTINUE FOREACH
         END IF          
         CALL g_properties.addAttribute("speed_field_layer",ls_tmp)

      END IF 
        
   END FOREACH  
   CALL ld_arr.deleteElement(li)  
   CALL adzp141_compos_spd_fields(ld_arr)
   CLOSE adzp141_cs3
   FREE adzp141_pb3
   RETURN TRUE  
END FUNCTION  


#+ 組提速檔欄位變數
PRIVATE FUNCTION adzp141_compos_spd_fields(ld_arr)
   DEFINE ls_speed_fields STRING
   DEFINE ls_speed_var_fields STRING 

   DEFINE ld_arr   DYNAMIC ARRAY OF RECORD 
      dzeb002 LIKE  dzeb_t.dzeb002
      END RECORD 
   DEFINE li LIKE type_t.num5

   FOR li = 1 TO ld_arr.getLength()
      LET ls_speed_fields = ls_speed_fields ,ld_arr[li].dzeb002 
      LET ls_speed_var_fields = ls_speed_var_fields ,"lc_",ld_arr[li].dzeb002

      IF li <> ld_arr.getLength() THEN 
         LET ls_speed_fields = ls_speed_fields ,","
         LET ls_speed_var_fields = ls_speed_var_fields,"," 
      END IF 
   END FOR 
  
   CALL g_properties.addAttribute("speed_fields",ls_speed_fields)   
   CALL g_properties.addAttribute("speed_var_fields",ls_speed_var_fields)
END FUNCTION 


#+ 程式樣板讀取/程式寫出(一進一出) / 產生器符號中斷,擺放切片或產生code
PRIVATE FUNCTION adzp141_read_and_replace( )
   DEFINE lchannel_read           base.Channel
   DEFINE lchannel_write          base.Channel
   DEFINE ls_readline             STRING
   DEFINE ls_text                 STRING
   DEFINE ls_sample_filename      STRING
   DEFINE ls_code_filename        STRING


   LET lchannel_read = base.Channel.create()
   LET lchannel_write = base.Channel.create()

   CALL lchannel_read.setDelimiter("")
   CALL lchannel_write.setDelimiter("")
   #定義寫入檔案  $COM/lng/4gl/n_tabid.4gl
   LET ls_sample_filename = os.Path.join(os.Path.join(FGL_GETENV("COM"),"lng"),"4gl") #檔案路徑
   LET ls_code_filename = os.Path.join(ls_sample_filename,gs_code_filename||".4gl")

   #定義要讀取的樣板檔案  $COM/lng/mdl/n_speed_template.4gl
   LET ls_sample_filename = os.Path.join(os.Path.join(FGL_GETENV("COM"),"lng"),"mdl")
   LET ls_sample_filename = os.Path.join(ls_sample_filename,"n_speed_template.4gl")
 
   DISPLAY "樣板檔:",ls_sample_filename
   DISPLAY "目的檔:",gs_code_filename,".4gl"
   
   IF NOT os.Path.exists(ls_sample_filename) THEN
      DISPLAY "Error:樣板檔案:",ls_sample_filename.trim()," 不存在!"
      EXIT PROGRAM
   END IF
   CALL lchannel_read.openFile(ls_sample_filename CLIPPED, "r" )

   DISPLAY "產生檔位置:", ls_code_filename
   
   IF NOT os.Path.exists(ls_code_filename) THEN

      CALL lchannel_write.openFile(ls_code_filename, "w" )
   ELSE
      IF os.Path.delete(ls_code_filename||".bak") THEN

      END IF
      
      IF NOT os.Path.rename(ls_code_filename, ls_code_filename||".bak" ) THEN 
         DISPLAY "Error:目的備份檔案:",ls_code_filename.trim(),"不存在!"
         #EXIT PROGRAM   
      END IF 
      CALL lchannel_write.openFile(ls_code_filename, "w" )
   END IF
   
   #產生程式版本及說明
   CALL lchannel_write.write(adzp141_prog_memo())

   #讀取及轉換
   WHILE TRUE
   
      LET ls_text = ""
      LET ls_readline = lchannel_read.readLine()
        
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF

      
      #行代換/ 對 ${} 置換
      IF ls_readline.getIndexOf("${",1) AND 
         (ls_readline.getIndexOf("${",1) < ls_readline.getIndexOf("}",1)) THEN
         LET ls_text = adzp141_line_replace(ls_readline)
      END IF

      #一般未進行任何處理段落產出
      IF ls_text IS NULL THEN
         LET ls_text = ls_readline
      END IF
      CALL lchannel_write.write(ls_text)
   END WHILE

   CALL lchannel_read.close()
   CALL lchannel_write.close()

      #進行4gl編譯成42m
   CALL adzp141_compile_file("1")
   
END FUNCTION

 
#+ 逐行代換
PRIVATE FUNCTION adzp141_line_replace(ls_read)
   DEFINE ls_read     STRING
   DEFINE ls_text     STRING
   DEFINE ls_tag      STRING
   DEFINE li_pos1     LIKE type_t.num10
   DEFINE li_pos2     LIKE type_t.num10
   DEFINE ls_temp     STRING                #暫存properties資料用

   LET li_pos1 = ls_read.getIndexOf("${",1)
   LET li_pos2 = ls_read.getIndexOf("}", li_pos1)

   IF li_pos1 > 0 AND li_pos2 > 0 AND li_pos1 < li_pos2 THEN
      LET ls_text = ""
      LET ls_tag = ls_read.subString(li_pos1 +2, li_pos2 -1 ) #取出要置換的tag

      #由SaxAttribute內取出值進行代換
      #不在行首
      IF li_pos1 > 1 THEN
         LET ls_text = ls_read.subString(1, li_pos1 - 1)
      END IF

      #中間段
      LET ls_temp = g_properties.getValue(ls_tag) CLIPPED
         
      LET ls_text = ls_text, g_properties.getValue(ls_tag) CLIPPED,
                       ls_read.subString(li_pos2+1, ls_read.getLength())

      #遞迴處理同行其他組
      IF ls_text.getIndexOf("${",1) THEN
         LET ls_text = adzp141_line_replace(ls_text)
      END IF
   END IF

   RETURN ls_text
END FUNCTION


#+r.c 、 r.f 、 r.gx lng
PRIVATE FUNCTION adzp141_compile_file(p_type)

   DEFINE p_type                  LIKE type_t.chr1  #要編譯的檔案類型--1:4gl ; 2:4fd
   DEFINE ls_str                  STRING
   DEFINE l_read                  base.Channel
   DEFINE l_cmd                   STRING            #要執行的指令
   DEFINE l_path                  STRING            #要編譯的路徑
   DEFINE l_msg                   STRING            #編譯後訊息
   
   LET l_read = base.Channel.create()
   LET l_cmd = ""
   LET l_path = ""
   LET l_msg = ""
   
   #因為要編譯com/lng/4gl相對路徑下
   #才可進行編譯動作
   LET l_path = os.Path.join(FGL_GETENV("COM"), "lng")
   
   #4gl和4fd存放路徑不同,編譯方式也不同
   CASE p_type
      WHEN "1"   #4gl
         LET l_path = os.Path.join(l_path, "4gl")
         LET l_cmd = "r.c ", gs_code_filename
      WHEN "2"   #lng 42x打包
         LET l_cmd = "r.l ", "lng"

   END CASE

   #RUN l_cmd
   
   LET l_msg = l_msg, l_cmd, ASCII 10

   IF l_path IS NOT NULL THEN
      #切換目錄
      LET l_cmd = "cd ", l_path.trim(), "; ", l_cmd
   END IF
   
   #執行指令
   CALL l_read.openPipe(l_cmd, "r")
   
   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF
      IF ls_str.getIndexOf("lng.42x",1) THEN 
         LET ls_str = "\n",ls_str
      END IF  
      LET l_msg = l_msg, ls_str
   END WHILE
   CALL l_read.close()
   DISPLAY l_msg

END FUNCTION


#+ 產生程式版本及說明
PRIVATE FUNCTION adzp141_prog_memo()
   DEFINE ls_text  STRING

   LET ls_text = ""
   LET ls_text = ls_text, "#+ Version..: T6-ERP-1.00.00 Build-", adzp141_prog_buildtime(), " at ", TODAY, "\n"
   LET ls_text = ls_text, "#+ ","\n" 
   LET ls_text = ls_text, "#+ Filename......: ", gs_code_filename CLIPPED,".4gl" ,"\n"
   LET ls_text = ls_text, "#+ Buildtype..: " ,"\n"
   LET ls_text = ls_text, "#+ Memo.......: 產出自動填入提速資料功能\n" 
  
   RETURN ls_text
END FUNCTION


#+ 取出版本建置次數
PRIVATE FUNCTION adzp141_prog_buildtime()
   DEFINE lc_dzaz001   LIKE dzaz_t.dzaz001
   DEFINE li_dzaz002   LIKE dzaz_t.dzaz002
   DEFINE lc_dzaz003   LIKE dzaz_t.dzaz003
   DEFINE lc_dzaz004   DATETIME YEAR TO SECOND

   LET lc_dzaz001 = gs_code_filename CLIPPED
   LET li_dzaz002 = 0
   
   SELECT MAX(dzaz002) INTO li_dzaz002 FROM dzaz_t WHERE dzaz001 = lc_dzaz001
   
   IF STATUS OR li_dzaz002 IS NULL THEN
      LET li_dzaz002 = 0
   END IF
   
   #取得登入帳號
   LET lc_dzaz003 = FGL_GETENV("LOGNAME")
   LET lc_dzaz004 = CURRENT

   INSERT INTO dzaz_t(dzaz001, dzaz002, dzaz003, dzaz004)
      VALUES(lc_dzaz001, li_dzaz002+1, lc_dzaz003, lc_dzaz004)

   RETURN li_dzaz002 USING "&&&&"
END FUNCTION




