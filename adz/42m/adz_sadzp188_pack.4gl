#+ Version..: T100-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp030_tab
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 打包樣板檔
#+ ...........: 150513 150521-00011 tar路徑調整與增加png檔打包
#+ ...........: 150622 150622-00011 增加打包子報表圖片
#+ ...........: 151102 151102-00035#1 將MNT4RP改用LIB來取得
#+ ...........: 160223 160223-00028 將sadzi888_01_get_path()改用sadzp007_util_get_path()

IMPORT os
IMPORT security
SCHEMA ds


GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp000_type.inc"             

GLOBALS
   DEFINE g_prog_id         LIKE dzfi_t.dzfi001
   DEFINE g_sd_ver          LIKE dzaa_t.dzaa002  #規格版次/程式版次
   DEFINE g_sql             STRING 
   DEFINE g_4rplang         DYNAMIC ARRAY OF T_LANGUAGE_TYPE   #語言別  
   DEFINE g_file            STRING   
   
END GLOBALS
PRIVATE TYPE type_gzgd   RECORD 
       gzgd003           LIKE gzgd_t.gzgd003,   #客製否
       gzgd007           LIKE gzgd_t.gzgd007    #樣板名稱(4rp)
                         END RECORD


#打包工具
#先將樣板複製到$TEMPDIR/TARFOLDER/(標準OR客製)/4RP/語言別/*.4rp
#先將rdd複製到$TEMPDIR/TARFOLDER/(標準OR客製)/4RP/(rdd)/*.rdd
#先將png複製到$TEMPDIR/TARFOLDER/(標準OR客製)/4RP/語言別/*.png

PUBLIC FUNCTION sadzp188_rep_pack(p_prog_id)  

   DEFINE p_prog_id      STRING    #樣板元件代號
   DEFINE p_code_ide     LIKE type_t.chr1     #客製標示
   DEFINE ls_tar_folder  STRING                 #tar目錄
   DEFINE ls_tar_name    STRING                 #tar檔名
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE li_scuss       LIKE type_t.num5       #操作上是否成功(全過程)
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE l_i            LIKE type_t.num5 
   DEFINE ls_temp_path   STRING                 #暫存檔路徑
   DEFINE li_pid         LIKE type_t.num5       #PID
   DEFINE ls_time        STRING 
   DEFINE l_msg          STRING 
   DEFINE l_cmd          STRING 
   DEFINE l_4rplang      STRING 
   DEFINE ls_sys         STRING 
   DEFINE l_cust         LIKE type_t.chr1
   DEFINE lb_result      BOOLEAN 
                          
                         
   

   LET g_prog_id = p_prog_id       #樣板元件代號

   LET ls_temp_path = FGL_GETENV("TEMPDIR")
   #切換目錄
   IF NOT os.Path.chdir(ls_temp_path) THEN
      #CALL cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_temp_path.trim()) 
      LET lb_result = FALSE 
      GOTO _return 
   END IF
      ##取得語言別
   CALL sadzp188_pack_get_lang_type_list() RETURNING g_4rplang 
   
    
   LET ls_time = ""
   LET ls_time = sadzp188_pack_get_date()
   LET ls_tar_folder = p_prog_id CLIPPED, "-",ls_time
   LET ls_tar_name = ls_tar_folder, ".tar"
   

   #檢查目錄是否存在
   IF os.Path.EXISTS(ls_tar_folder) THEN
      LET l_msg = cl_getmsg_parm("adz-00323", g_lang, ls_tar_folder)
      IF NOT cl_ask_type1(l_msg, "Warnning") THEN
         #RETURN
         LET lb_result = FALSE 
         GOTO _return 
      ELSE
         #刪除目錄
         LET l_cmd = "rm -rf ", ls_tar_folder
         RUN l_cmd

         #刪除tar檔
         IF os.Path.EXISTS(ls_tar_name) THEN
            LET l_cmd = "rm -rf ", ls_tar_name
            RUN l_cmd
         END IF
      END IF
   END IF

   #檢查tar是否存在
   IF os.Path.EXISTS(ls_tar_name) THEN
      LET l_msg = cl_getmsg_parm("adz-00323", g_lang, ls_tar_name)
      IF NOT cl_ask_type1(l_msg, "Warnning") THEN
         #RETURN
         LET lb_result = FALSE 
         GOTO _return          
      ELSE
         #刪除tar檔
         LET l_cmd = "rm -rf ", ls_tar_name
         RUN l_cmd
      END IF
   END IF

   #重新建立目錄
   IF NOT os.Path.mkdir(ls_tar_folder) THEN
      #CALL cl_err_msg(NULL, "adz-00341", ls_tar_folder.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00341", ls_tar_folder.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00341", g_lang), ls_tar_folder.trim())
      LET lb_result = FALSE 
      GOTO _return       
   END IF

   #切換到新目錄下,準備將匯出檔皆置於此目錄下


    DECLARE sadzp188_get_4rpcust_cs CURSOR FOR  
     SELECT DISTINCT gzgd003    
       FROM gzgd_t                                        
      WHERE gzgd001  = g_prog_id 
        AND gzgdstus = 'Y'
    FOREACH  sadzp188_get_4rpcust_cs INTO l_cust  

       #取得模組
       LET ls_sys =""
       CALL sadzp188_get_module(g_prog_id,l_cust) RETURNING ls_sys 
       LET ls_sys = downshift(ls_sys)

       #切換目錄
       IF NOT os.Path.chdir(ls_temp_path) THEN
          #CALL cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
          #RETURN
          #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
          LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_temp_path.trim()) 
          LET lb_result = FALSE 
          GOTO _return           
       END IF 

       #切換目錄
       IF (NOT os.Path.EXISTS(ls_tar_folder)) OR (NOT os.Path.chdir(ls_tar_folder)) THEN
          #CALL cl_err_msg(NULL, "adz-00340", ls_tar_folder.trim(), 1)
          #RETURN
          #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_tar_folder.trim(), 1)
          LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_tar_folder.trim()) 
          LET lb_result = FALSE 
          GOTO _return           
       END IF       
       #建模組目錄
       IF NOT os.Path.mkdir(ls_sys) THEN
          #CALL cl_err_msg(NULL, "adz-00341", ls_sys.trim(), 1)
          #RETURN
          #LET l_msg = cl_err_msg(NULL, "adz-00341", ls_sys.trim(), 1)
          LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00341", g_lang), ls_sys.trim())
          LET lb_result = FALSE 
          GOTO _return           
       END IF  

       IF (NOT os.Path.EXISTS(ls_sys)) OR (NOT os.Path.chdir(ls_sys)) THEN
          #CALL cl_err_msg(NULL, "adz-00340", ls_sys.trim(), 1)
          #RETURN
          #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_sys.trim(), 1)
          LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_sys.trim()) 
          LET lb_result = FALSE 
          GOTO _return           
       END IF 
       #建4rp目錄
       IF NOT os.Path.mkdir("4rp") THEN
          #CALL cl_err_msg(NULL, "adz-00341", ls_sys.trim(), 1)
          #RETURN
          #LET l_msg = cl_err_msg(NULL, "adz-00341", ls_sys.trim(), 1)
          LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00341", g_lang), ls_sys.trim())
          LET lb_result = FALSE 
          GOTO _return             
       END IF  

       IF (NOT os.Path.EXISTS("4rp")) OR (NOT os.Path.chdir("4rp")) THEN
          #CALL cl_err_msg(NULL, "adz-00340", ls_sys.trim(), 1)
          #RETURN
          #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_sys.trim(), 1)
          LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_sys.trim()) 
          LET lb_result = FALSE 
          GOTO _return            
       END IF       

       #建立語言別目錄
       FOR l_i = 1 TO g_4rplang.getLength()
           LET l_4rplang =""
           LET l_4rplang = g_4rplang[l_i]
           IF NOT cl_null(g_4rplang[l_i]) THEN 
               IF NOT os.Path.mkdir(l_4rplang) THEN
                  #CALL cl_err_msg(NULL, "adz-00341", l_4rplang.trim(), 1)
                  #RETURN
                  #LET l_msg = cl_err_msg(NULL, "adz-00341", l_4rplang.trim(), 1)
                  LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00341", g_lang), l_4rplang.trim())
                  LET lb_result = FALSE 
                  GOTO _return                     
               END IF     
           END IF 
       END FOR 
   END FOREACH 

   #切換回$TEMPDIR目錄
   IF (NOT os.Path.EXISTS(ls_temp_path)) OR (NOT os.Path.chdir(ls_temp_path)) THEN
      #CALL cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_temp_path.trim()) 
      LET lb_result = FALSE 
      GOTO _return      
   END IF
   
   
   #複製此次打包的實體檔   
   CALL sadzp188_pack_export_file(ls_temp_path,ls_tar_folder)
   

   #切換回$TEMPDIR目錄
   IF (NOT os.Path.EXISTS(ls_temp_path)) OR (NOT os.Path.chdir(ls_temp_path)) THEN
      #CALL cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      #RETURN 
      #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_temp_path.trim()) 
      LET lb_result = FALSE 
      GOTO _return         
   END IF
   
   #切換回$TEMPDIR目錄
   IF (NOT os.Path.EXISTS(ls_tar_folder)) OR (NOT os.Path.chdir(ls_tar_folder)) THEN
      #CALL cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00340", ls_temp_path.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), ls_temp_path.trim()) 
      LET lb_result = FALSE 
      GOTO _return         
   END IF
  
   #製作tar檔
   #指定tar檔名稱
   LET ls_tar_name = ls_tar_folder CLIPPED, ".tar"
   #LET l_source = ls_tar_folder CLIPPED
   #回傳路徑
   #LET l_dest = os.Path.JOIN(os.Path.JOIN(ls_temp_path, ls_tar_folder), ls_tar_name)  ##150513 mark
   LET l_dest = "$TEMPDIR/",os.Path.JOIN( ls_tar_folder, ls_tar_name)                  ##150513 add  
   #切換到tar檔目錄下，tar出相對路徑
   LET l_cmd = "cd ", ls_tar_folder CLIPPED, ";"
   #tar cvf tar檔名.tar * 所有東西
   LET l_cmd = l_cmd, "tar cvf ", ls_tar_name, " *"  
   RUN l_cmd
   

   #匯出此次打包清單資訊
   CALL sadzp188_export_pack_list() RETURNING lb_result,l_msg
   IF lb_result = FALSE THEN 
   #IF NOT sadzp188_export_pack_list() THEN
      #RETURN
      GOTO _return       
   END IF   
   #drop temptable
   DROP TABLE pack_tmp
   
   #回傳tar檔完整路徑
   LET l_msg = l_dest.trim()
   LET lb_result = TRUE 
   GOTO _return  


  LABEL _return: 
      
      RETURN lb_result ,l_msg  
 
END FUNCTION





FUNCTION sadzp188_pack_get_lang_type_list()
DEFINE
  lo_lang_arr  DYNAMIC ARRAY OF T_LANGUAGE_TYPE,
  li_count     INTEGER,
  ls_sql       STRING 
DEFINE
  lo_return DYNAMIC ARRAY OF T_LANGUAGE_TYPE


  DECLARE get_lang_type_list_cs CURSOR FOR 
   SELECT gzzy001 FROM gzzy_t ORDER BY gzzy001 

  LET li_count = 1
  
  OPEN get_lang_type_list_cs
  FOREACH get_lang_type_list_cs INTO lo_lang_arr[li_count]  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_count = li_count + 1

  END FOREACH
  CLOSE get_lang_type_list_cs

  FREE get_lang_type_list_cs


  #增加rdd目錄
  LET lo_lang_arr[li_count] ="rdd"
  #CALL lo_lang_arr.deleteElement(li_count)
  
  LET lo_return = lo_lang_arr

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp188_pack_get_date()
   DEFINE  l_time            STRING
   DEFINE  l_sb              base.StringBuffer


   LET l_time =""
   LET l_time = CURRENT YEAR TO FRACTION(3)  #時間截記
   LET l_sb = base.StringBuffer.create()
   CALL l_sb.append(l_time)
   CALL l_sb.replace(":","",0)
   CALL l_sb.replace(" ","",0)
   CALL l_sb.replace("-","",0)
   CALL l_sb.replace(".","",0)
   LET l_time = l_sb.toString()

   RETURN l_time
   
   
END FUNCTION


#+ 匯出此次打包清單資訊
PRIVATE FUNCTION sadzp188_export_pack_list()   
   DEFINE l_sql             STRING
   DEFINE l_msg             STRING 
   
   
   #匯出[檔案匯出清單]
   LET g_file = "Temp-", g_prog_id,"_4rp.unl"
   LET l_sql = "SELECT * FROM pack_tmp WHERE prog = '", g_prog_id CLIPPED,"'"

   UNLOAD TO g_file l_sql
   LET l_msg =''
   IF STATUS THEN
      #CALL cl_err("UNLOAD TO " || g_file.trim(), STATUS, 1)
      #LET l_msg = cl_err("UNLOAD TO " || g_file.trim(), STATUS, 1)
      LET l_msg = "UNLOAD TO " || g_file.trim() , cl_getmsg(STATUS, g_lang)
      RETURN FALSE,l_msg
   END IF

   RETURN TRUE,NULL 
END FUNCTION



PRIVATE FUNCTION sadzp188_pack_export_file(p_pack_dir, p_folder)
   DEFINE p_pack_dir        STRING             #打包檔置放路徑
   DEFINE p_folder          STRING             #匯出檔所在目錄
   DEFINE l_cmd             STRING
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE l_source_i        VARCHAR(1000)
   DEFINE l_dest_i          VARCHAR(1000)
   DEFINE l_source_file_i   VARCHAR(100) 
   DEFINE l_src_folder      STRING 
   DEFINE ls_gzgd        DYNAMIC ARRAY OF type_gzgd
   DEFINE l_i               LIKE type_t.num5
   DEFINE ls_sys            STRING 
   DEFINE l_src             STRING 
   DEFINE l_source_path     STRING
   DEFINE l_source_file     STRING  
   DEFINE li_i              LIKE type_t.num5
   #DEFINE l_src_folder      STRING 
   DEFINE l_png_str         STRING                    #150513 add
                      
   

   #執行前清空dynamic array
   CALL ls_gzgd.clear()

      #切換目錄
   IF NOT os.Path.chdir(p_folder) THEN      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_folder.trim()
      CALL cl_err()
      RETURN
   END IF 
   

   #建立unl的temp檔
   CALL sadzp188_pack_create_temp()

   LET l_src_folder = FGL_GETENV("ERP")

   LET li_i = 1
   #找出[檔案匯出清單]   
  DECLARE sadzp188_get_4rpfile_cs CURSOR FOR  
   SELECT gzgd003,gzgd007    
     FROM gzgd_t                                        
    WHERE gzgd001  = g_prog_id 
      #AND gzgd004  = 'default'     
      #AND gzgd005  = 'default'     
      AND gzgdstus = 'Y'
   FOREACH sadzp188_get_4rpfile_cs INTO ls_gzgd[li_i].*
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzp188_get_4rpfile_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      #取得模組
      CALL sadzp188_get_module(g_prog_id,ls_gzgd[li_i].gzgd003) RETURNING  ls_sys

      
      LET l_src = os.path.join(FGL_GETENV(ls_sys),"4rp")
      #cp {路徑}/{檔名} $FOLDER/f#
      FOR l_i = 1 TO g_4rplang.getLength()
          LET l_cmd = ""
          LET l_source_path = os.Path.JOIN(l_src CLIPPED, g_4rplang[l_i] CLIPPED)
          IF g_4rplang[l_i] ="rdd" THEN 
             LET l_source_file = g_prog_id,".rdd"
          ELSE 
             LET l_source_file = ls_gzgd[li_i].gzgd007,".4rp"              
          END IF 

          LET l_source = os.Path.join( l_source_path,l_source_file)
          LET l_dest = os.path.join(os.Path.JOIN(os.path.join(os.Path.JOIN(p_pack_dir, p_folder),downshift(ls_sys)),"4rp"), g_4rplang[l_i] CLIPPED)
          IF os.Path.exists(l_source) THEN  #檔案存在才繼續做
              LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()
              DISPLAY "l_cmd:", l_cmd, ";"
              RUN l_cmd
              LET l_source_file_i =l_source_file
              LET l_source_i = l_source
              LET l_dest_i = l_dest
              INSERT INTO pack_tmp VALUES(g_prog_id,ls_gzgd[li_i].gzgd003,l_source_file_i,l_source_i,l_dest_i)
          END IF 
          ##150513 150521-00011 複製png add -(s)
          LET l_png_str = ''
          LET l_png_str = ls_gzgd[li_i].gzgd007
          #IF l_png_str.getIndexOf("subrep",1) = 0 THEN   ##150622-00011 mark 子報表若有圖也要打包
             IF g_4rplang[l_i] <> "rdd" THEN 
                LET l_source_file = ls_gzgd[li_i].gzgd007,".png"           
                LET l_source = os.Path.join( l_source_path,l_source_file)              
                IF os.Path.exists(l_source) THEN  #檔案存在才繼續做
                    LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()
                    DISPLAY "l_cmd:", l_cmd, ";"
                    RUN l_cmd
                    LET l_source_file_i =l_source_file
                    LET l_source_i = l_source
                    LET l_dest_i = l_dest
                    INSERT INTO pack_tmp VALUES(g_prog_id,ls_gzgd[li_i].gzgd003,l_source_file_i,l_source_i,l_dest_i)
                END IF 
             END IF 
          #END IF                                         ##150622-00011 mark 子報表若有圖也要打包
          ##150513 150521-00011 複製png add -(e) 
      END FOR 
 
      LET li_i = li_i +1
   END FOREACH

END FUNCTION


FUNCTION sadzp188_get_module(p_prog_id,p_dzgd003)
   DEFINE p_prog_id      STRING
   DEFINE p_dzgd003      LIKE dzgd_t.dzgd003
   DEFINE ls_sys         STRING 
   DEFINE ls_module      STRING 
   DEFINE lc_module      LIKE type_t.chr4
   DEFINE li_cnt         LIKE type_t.num5 

     LET ls_sys = UPSHIFT(p_prog_id.subString(1,4))

   #ls_sys模組代碼修正
   CASE
      #A/B/D/E開頭均為模組程式, C開頭需要進一步分析
      WHEN ls_sys.subString(1,1) = "A"
         IF p_dzgd003 = "c" THEN  
            LET ls_module = "C",ls_sys.subString(2,3)
         ELSE
            LET ls_module = ls_sys.subString(1,3)
         END IF

      WHEN ls_sys.subString(1,1) = "B"
         LET lc_module = ls_sys.subString(1,3)
         #檢查若模組存在 gzzo_t ->則為行業專用模組下的程式, 不存在則需更換為 A開頭模組
         SELECT COUNT(*) INTO li_cnt FROM gzzo_t
          WHERE gzzo001 = lc_module
         IF li_cnt > 0 THEN
            IF p_dzgd003 = "c" THEN  #sadzp030_tab_file_chk_cust(ls_prog_id) THEN
               LET ls_module = "D",ls_sys.subString(2,3)
            ELSE
               LET ls_module = ls_sys.subString(1,3)
            END IF
         ELSE
            IF p_dzgd003 = "c" THEN  #sadzp030_tab_file_chk_cust(ls_prog_id) THEN
               LET ls_module = "C",ls_sys.subString(2,3)
            ELSE
               LET ls_module = "A",ls_sys.subString(2,3)
            END IF
         END IF
      OTHERWISE
         LET ls_module = ls_sys.subString(1,3)         
    END CASE 

   RETURN ls_module
    
END FUNCTION 


FUNCTION sadzp188_pack_create_temp()

     CREATE TEMP TABLE pack_tmp
   (
   prog       VARCHAR(30) ,          
   ide        VARCHAR(1),            
   filename   VARCHAR(100) ,         
   src        VARCHAR(1000) ,        
   dest       VARCHAR(1000)          

   );


END FUNCTION 


FUNCTION sadzp188_rep_unpack(p_prog_id,p_tar_name)
  DEFINE p_prog_id       STRING          #樣板元件代號
  DEFINE p_tar_name      STRING          #壓縮檔路徑
  DEFINE l_work_dir      STRING 
  DEFINE l_pack_dir      STRING 
  DEFINE l_cmd           STRING
  DEFINE l_src_folder    STRING 
  DEFINE li_i            LIKE type_t.num5
  DEFINE ls_gzgd         DYNAMIC ARRAY OF type_gzgd
  DEFINE ls_sys          STRING 
  DEFINE l_i             LIKE type_t.num5
  DEFINE l_src           STRING 
  DEFINE l_source_path   STRING 
  DEFINE l_source_file   STRING 
  DEFINE l_source        STRING   
  DEFINE lb_result       BOOLEAN
  DEFINE l_msg           STRING
  #140722 add -(s) 
  DEFINE l_source_w      STRING     
  DEFINE l_src_folder_w  STRING    #140722 報表主機上路徑 add
  DEFINE l_zone          STRING    
  DEFINE l_src_w         STRING
  DEFINE l_source_path_w STRING 
  
  #140722 add -(e) 

   #記錄目前程式執行路徑
   LET l_work_dir = FGL_GETENV("ERP")

   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV("TEMPDIR")
   IF NOT os.Path.chdir(l_pack_dir) THEN
      #CALL cl_err_msg(NULL, "adz-00340", l_pack_dir.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00340", l_pack_dir.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), l_pack_dir.trim()) 
      LET lb_result = FALSE 
      GOTO _return       
   END IF

   LET l_src_folder = FGL_GETENV("ERP")
   LET l_zone = FGL_GETENV("ZONE")
   #LET l_src_folder_w = FGL_GETENV("MNT4RP")   #151102-00035#1 mark
   LET l_src_folder_w = cl_rpt_get_env_global("MNT4RP")    #151102-00035#1 add
   #DISPLAY "l_src_folder_w:",l_src_folder_w

   LET li_i = 1
   #找出[檔案匯出清單]   
  DECLARE sadzp188_get_4rpfile_cs1 CURSOR FOR  
   SELECT gzgd003,gzgd007    
     FROM gzgd_t                                        
    WHERE gzgd001  = g_prog_id 
      #AND gzgd004  = 'default'     
      #AND gzgd005  = 'default'     
      AND gzgdstus = 'Y'
   FOREACH sadzp188_get_4rpfile_cs1 INTO ls_gzgd[li_i].*
      
      IF SQLCA.sqlcode THEN
         #CALL cl_err("FOREACH sadzp188_get_4rpfile_cs:", SQLCA.sqlcode, 1)
         #RETURN
         #LET l_msg = cl_err("FOREACH sadzp188_get_4rpfile_cs:", SQLCA.sqlcode, 1)
         LET l_msg = "FOREACH sadzp188_get_4rpfile_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         LET lb_result = FALSE 
         GOTO _return           
      END IF
      #取得模組
      CALL sadzp188_get_module(g_prog_id,ls_gzgd[li_i].gzgd003) RETURNING  ls_sys

      
      LET l_src = os.path.join(FGL_GETENV(ls_sys),"4rp")
      LET l_src_w = os.path.join(os.path.join(l_src_folder_w,downshift(ls_sys)),"4rp")
      #DISPLAY "l_src_w:",l_src_w
      #cp {路徑}/{檔名} $FOLDER/f#
      FOR l_i = 1 TO g_4rplang.getLength()
          LET l_cmd = ""
          LET l_source_path = os.Path.JOIN(l_src CLIPPED, g_4rplang[l_i] CLIPPED)
          LET l_source_path_w = os.Path.JOIN(l_src_w CLIPPED, g_4rplang[l_i] CLIPPED)
          IF g_4rplang[l_i] ="rdd" THEN 
             LET l_source_file = g_prog_id,".rdd"
          ELSE 
             LET l_source_file = ls_gzgd[li_i].gzgd007,".4rp"
          END IF 

          LET l_source = os.Path.join( l_source_path,l_source_file)
          
           #判斷檔案是否存在,存在的話需先備份
            IF os.Path.exists(l_source) THEN
              IF os.Path.copy(l_source, l_source || ".bak") THEN 
                 IF os.Path.chrwx(l_source||".bak",511) THEN END IF 
              END IF 
            END IF  
           LET l_source_w = os.Path.join( l_source_path_w,l_source_file)        
           #判斷檔案是否存在,存在的話需先備份
            IF os.Path.exists(l_source_w) THEN
              IF os.Path.copy(l_source_w, l_source_w || ".bak") THEN 
                 IF os.Path.chrwx(l_source_w||".bak",511) THEN END IF 
              END IF 
            END IF  
      END FOR  
      LET li_i = li_i +1
   END FOREACH   


   IF NOT os.Path.chdir(l_src_folder) THEN
      #CALL cl_err_msg(NULL, "adz-00340", l_src_folder.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00340", l_src_folder.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), l_src_folder.trim()) 
      LET lb_result = FALSE 
      GOTO _return      
   END IF   

   #檢查tar是否存在
   LET p_tar_name = sadzp007_util_get_path(p_tar_name) #madey:因為路徑含環境變數，需要再次轉換 #160223-00028
   IF NOT os.Path.EXISTS(p_tar_name) THEN
      #CALL cl_err_msg(NULL, "adz-00328", p_tar_name.trim(), 1) 
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00328", p_tar_name.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00328", g_lang), p_tar_name.trim()) 
      LET lb_result = FALSE 
      GOTO _return       
   END IF

   #解包成tar檔範例:tar xvf $FOLDER.tar
   LET l_cmd = "tar xvf ", p_tar_name  
   RUN l_cmd  

   #LET l_cmd = " rm ",g_file

   #140722 /tiptop_gr/$ZONE/也要解tar
    DISPLAY "l_src_folder_w:",l_src_folder_w
    IF NOT os.Path.chdir(l_src_folder_w) THEN
      #CALL cl_err_msg(NULL, "adz-00340", l_src_folder.trim(), 1)
      #RETURN
      #LET l_msg = cl_err_msg(NULL, "adz-00340", l_src_folder.trim(), 1)
      LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00340", g_lang), l_src_folder_w.trim()) 
      LET lb_result = FALSE 
      GOTO _return      
   END IF 
   #解包成tar檔範例:tar xvf $FOLDER.tar
   LET l_cmd = "tar xvf ", p_tar_name  
   RUN l_cmd  

   #DISPLAY "g_file:",g_file
   #LET l_cmd = " rm ",g_file   

   #刪除tar檔
   LET l_cmd = "rm -rf ", p_tar_name
   RUN l_cmd

   
 
   LET l_msg = NULL
   LET lb_result = TRUE
   GOTO _return 


  LABEL _return: 
      
      RETURN lb_result ,l_msg     
   
END FUNCTION 

