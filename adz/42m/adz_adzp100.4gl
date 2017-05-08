IMPORT os

#DATABASE ds
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
#單身 type 宣告
PRIVATE TYPE type_g_diff_d  RECORD
   line_no   STRING, #行號 
   left_col  STRING, #左邊差異收集
   right_col STRING  #右邊差異收集  
       END RECORD

DEFINE g_diff_d DYNAMIC ARRAY OF type_g_diff_d 

MAIN

   DEFINE lc_dzdy001  LIKE dzdy_t.dzdy001   #樣板編號
   #DEFINE lc_dzdy004  LIKE dzdy_t.dzdy004   #存放路徑
   #DEFINE lc_dzdz003  LIKE dzdz_t.dzdz003   #CLOB欄位
   #DEFINE lc_dzdz004  LIKE dzdz_t.dzdz004   #MD5
   DEFINE ls_file     STRING
   DEFINE ls_cmd      STRING
   DEFINE ls_temp     STRING
   DEFINE ls_old      STRING 
   #DEFINE lch_channel base.Channel 
   DEFINE li_ver      LIKE type_t.num5

   #LOCATE lc_dzdz003 IN FILE
   LET g_t100debug = FGL_GETENV("T100DEBUG")
   
   CALL cl_db_connect("ds",FALSE)

   LET lc_dzdy001 = ARG_VAL(2)
   LET ls_file = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),lc_dzdy001||".template")
   IF os.Path.exists(ls_file) THEN 
   ELSE 
      LET ls_file = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),"slice"),lc_dzdy001||".template")
   END IF 
   CALL adzp100_get_ver(ls_file)RETURNING li_ver
   IF li_ver > 1 THEN
      LET li_ver = li_ver - 1  
     
   END IF 
   
   #解開前一版本
   CALL sadzi100_extract(lc_dzdy001,li_ver,"2") 
      #$TEMPDIR/code_i01.ver_NN
   LET ls_old = lc_dzdy001,".ver_", li_ver USING "<<<<" 
   LET ls_old = os.Path.join(FGL_GETENV("TEMPDIR"),ls_old)   

   

   #確認新版及前一版是否有差異 
   CALL sadzi100_load_diff(ls_file,ls_old)RETURNING g_diff_d
   --SELECT dzdy004 INTO lc_dzdy004 FROM dzdy_t WHERE dzdy001 = lc_dzdy001
--
   #定義檔案讀取路徑
   --LET ls_file = lc_dzdy001,".template"
   --IF lc_dzdy004[1,1] = "$" THEN
      --LET ls_temp = lc_dzdy004 CLIPPED
      --LET ls_cmd = ls_temp.subString(2,ls_temp.getIndexOf("/",1)-1)
      --LET ls_file = os.Path.join(os.Path.join(FGL_GETENV(ls_cmd),ls_temp.subString(ls_temp.getIndexOf("/",1)+1,
                                                                 --ls_temp.getLength())),ls_file)
   --ELSE
      --LET ls_file = os.Path.join(lc_dzdy004, ls_file)
   --END IF
--
   #讀取檔案
   --CALL lc_dzdz003.readFile(ls_file)
   --display 'info: read file:',ls_file,' length:',lc_dzdz003.getLength()
--
   #計算 MD5
   --LET lch_channel = base.Channel.create()
   --LET ls_cmd = "md5sum ",ls_file
   --CALL lch_channel.setDelimiter("\t")
   --CALL lch_channel.openPipe(ls_cmd ,"r")
   --WHILE lch_channel.read(ls_temp)
      --EXIT WHILE 
   --END WHILE
   --LET lc_dzdz004 = ls_temp.subString(1,32)
   --CALL lch_channel.close()
--
   --UPDATE dzdz_t SET dzdz003=lc_dzdz003,dzdz004=lc_dzdz004
    --WHERE dzdz001 = lc_dzdy001
      --AND dzdz002 = 1            #版本
--
   --FREE lc_dzdz003
END MAIN

PRIVATE FUNCTION adzp100_get_ver(ls_file)
   DEFINE ls_temp     STRING
   DEFINE lch_channel base.Channel 
   DEFINE l_ch        base.Channel
   DEFINE l_buf       STRING
   DEFINE li_ver      LIKE type_t.num5
   DEFINE ls_tmp      STRING
   DEFINE li_index    LIKE type_t.num5
   DEFINE li_chk      LIKE type_t.num5
   DEFINE ls_file    STRING



   #read
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openFile(ls_file,"r")

   WHILE TRUE
      CALL l_ch.readLine() RETURNING l_buf  #讀一行資料
      IF l_ch.isEof() THEN EXIT WHILE END IF

      LET ls_tmp = l_buf
      LET ls_tmp = ls_tmp.trim()
      LET ls_tmp = DOWNSHIFT(ls_tmp)
      LET ls_tmp = ls_tmp.trim()
      LET li_index = ls_tmp.getIndexOf("(version:",1)
      IF li_index > 0 THEN 
         LET li_ver = ls_tmp.subString(li_index + 9,ls_tmp.getIndexOf(")",li_index) - 1)
         EXIT WHILE  
      END IF 
      LET li_index = 0

   END WHILE    
   CALL l_ch.close()
   RETURN li_ver
END FUNCTION 


