#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp280
#+ 設計人員......: cch
#+ 功能名稱說明..: 檢視程式碼作業
# Modify         : 2015/09/18 by Hiko : 增加查看規格功能.
#                : 20160701 160701-00022 by Hiko : 取消規格的呈現
 
#IMPORT JAVA java.lang.String 
IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 

DEFINE   g_erp             STRING,               #TIPTOP起始目錄
         gs_4gl            STRING,               #檔案路徑
         g_4gl_file        TEXT,                 #存放程式碼
         g_spec            TEXT,                 #規格 #2015/09/18 by Hiko
         g_find_4gl_string STRING,               #要搜尋的字串
         g_module_id       LIKE gzde_t.gzde002,  #模組代號
         g_src_module_id   STRING,
         g_prog_id         LIKE dzdf_t.dzdf001,  #程式代號
         g_src_prog_id     STRING,
         g_func_id         LIKE dzdf_t.dzdf002   #FUNCTION NAME 


#+ 作業開始
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS
     INPUT WRAP
   
   CALL cl_tool_init()   

   OPEN WINDOW w_adzp280 WITH FORM cl_ap_formpath("adz",g_prog)

   CLOSE WINDOW screen

   CALL adzp280_init()

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   
   CALL adzp280_input()
 
   #畫面關閉
   CLOSE WINDOW w_adzp280
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN

#+ 初始化變數
PRIVATE FUNCTION adzp280_init()

   LET g_erp = FGL_GETENV("ERP")
   LET g_func_id   = ARG_VAL(2) CLIPPED

   IF g_func_id MATCHES "cl_*" THEN
      #找function所在程式
      #SELECT dzba001 INTO g_prog_id FROM dzba_t WHERE dzba003 = "function."||g_func_id
      SELECT gzwa001 INTO g_prog_id FROM gzwa_t WHERE gzwa002 = g_func_id
      LET g_src_prog_id = "gzwa_t"
      #找程式所在模組
      #SELECT gzzn001 INTO g_module_id FROM gzzn_t WHERE gzzn002 = g_prog_id
      #LET g_module_id = "LIB"
      #SELECT dzde004 INTO g_module_id FROM dzde_t WHERE dzde001 = g_prog_id #2015/09/18 by Hiko
      LET g_src_module_id = "dzde_t"
   ELSE
      #找function所在程式
      #SELECT dzba001 INTO g_prog_id FROM dzba_t WHERE dzba003 = "function."||g_func_id
      SELECT dzdf001 INTO g_prog_id FROM dzdf_t WHERE dzdf002 = g_func_id
      LET g_src_prog_id = "dzdf_t"
      
      #找程式所在模組         
      #SELECT gzzn001 INTO g_module_id FROM gzzn_t WHERE gzzn002 = g_prog_id
      #SELECT dzde004 INTO g_module_id FROM dzde_t WHERE dzde001 = g_prog_id #2015/09/18 by Hiko
      LET g_src_module_id = "dzde_t"
   END IF
   
   CALL sadzp062_1_find_module(g_prog_id, sadzp060_2_chk_spec_type(g_prog_id)) RETURNING g_module_id #2015/09/18 by Hiko

   LET g_prog_id = g_prog_id CLIPPED
   LET g_module_id = g_module_id CLIPPED
   LET gs_4gl = os.path.join(os.path.join(FGL_GETENV(g_module_id), "4gl"),g_prog_id||".4gl")

   IF cl_null(g_prog_id) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00195"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_func_id
      LET g_errparam.replace[2] = g_src_prog_id
      CALL cl_err()
      EXIT PROGRAM
   END IF
   
   IF cl_null(g_module_id) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00196"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_func_id
      LET g_errparam.replace[2] = g_src_module_id
      CALL cl_err()
      EXIT PROGRAM
   END IF

   IF NOT os.Path.exists(gs_4gl) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00197"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  gs_4gl
      CALL cl_err()
       EXIT PROGRAM
   END IF
END FUNCTION

#+ 讀取檔案內容
PRIVATE FUNCTION adzp280_open_file(p_file_path,pt_object)
   DEFINE pt_object   TEXT,
          p_file_path STRING

   #指定物件在記憶體的位置
   LOCATE pt_object IN FILE 

   TRY
      #從檔案路徑載入檔案內容
      CALL pt_object.readFile(p_file_path)
   CATCH
      IF STATUS THEN
         #對此分鏡檔的權限不足
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00156"
         LET g_errparam.extend = "ERROR:permission"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_file_path
         CALL cl_err()
         EXIT PROGRAM
      END IF
   END TRY
   
   RETURN pt_object
END FUNCTION

#+ 擷取檔案本身資訊
PRIVATE FUNCTION adzp280_get_file_data(p_file_name)
   DEFINE p_file_name STRING,
          l_read base.Channel,
          ls_str STRING,
          l_msg STRING
  
   LET l_read = base.Channel.create()
   CALL l_read.openPipe("ls -al "||p_file_name, "r")

   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF
      LET l_msg = l_msg, ls_str
   END WHILE
   CALL l_read.close()

   RETURN l_msg
   
END FUNCTION

#+ 資料輸入
PRIVATE FUNCTION adzp280_input()
   DEFINE l_start_searching    LIKE type_t.num5,
          l_search_from_head   LIKE type_t.num5,
          l_start_pos          LIKE type_t.num20,
          l_search_function    LIKE type_t.num5,
          l_str                STRING
   #Begin:2015/09/18 by Hiko
   DEFINE l_type     LIKE dzaf_t.dzaf005,
          l_revision LIKE dzaf_t.dzaf003,
          l_identity LIKE dzaf_t.dzaf010,
          ls_err_msg STRING,
          ls_sql     STRING,
          l_dzab099  LIKE dzab_t.dzab099
   #End:2015/09/18 by Hiko

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #4gl檔的 Ctrl+F 功能
      #INPUT g_4gl_file,g_spec,g_find_4gl_string FROM s_4gl_file,s_spec,s_find_4gl_string #2015/09/18 by Hiko
      #INPUT g_4gl_file,g_spec FROM s_4gl_file,s_spec #160701-00022
      INPUT g_4gl_file FROM s_4gl_file
         BEFORE INPUT
            #初始化變數
            LET l_start_searching = FALSE
            LET l_search_from_head = FALSE
            
         BEFORE FIELD s_4gl_file
            IF l_search_function = TRUE THEN
               #尋找function name
               CALL adzp280_get_select_range(g_4gl_file,adzp280_find_function_name_location(g_func_id,gs_4gl),1)

               LET l_search_function = FALSE
            END IF

            #如果為TRUE則開始設定滑鼠選取的範圍        
            IF l_start_searching = TRUE THEN
               CALL adzp280_get_select_range(g_4gl_file,g_find_4gl_string,l_start_pos)
             
               #初始化變數l_start_searching為FALSE
               LET l_start_searching = FALSE
            END IF

        #Begin:2015/09/18 by Hiko:改用原廠搜尋功能:4fd設定即可.
        ##進入搜尋字串開始從頭搜尋
        #BEFORE FIELD s_find_4gl_string
        #   LET l_search_from_head = TRUE

        ##搜尋字串功能
        #ON ACTION btm_find_4gl_string
        #   IF g_find_4gl_string.getLength() > 0 THEN
        #      IF l_search_from_head = TRUE THEN
        #         LET l_start_pos = 1
        #         LET l_search_from_head = FALSE
        #      ELSE
        #         LET l_start_pos = FGL_DIALOG_GETCURSOR()+g_find_4gl_string.getLength()
        #      END IF
        #    
        #      LET l_start_searching = TRUE
        #      NEXT FIELD s_4gl_file
        #   END IF
        #End:2015/09/18 by Hiko
      END INPUT

      BEFORE DIALOG
         #顯示4gl檔案本身資訊
         DISPLAY  adzp280_get_file_data(gs_4gl) TO s_4gl_data   
         #檢視4gl檔-->一定要放在此段才可以預先自動載入TEXT的內容

         LET g_find_4gl_string = g_func_id
   
         LET g_4gl_file = adzp280_open_file(gs_4gl,g_4gl_file)
         LET l_search_function = TRUE
         DISPLAY g_func_id TO s_func_id
         #LET l_str = g_prog_id,"   (### data from ",g_src_prog_id," ###)" #2015/09/18 by Hiko
         LET l_str = g_prog_id
         DISPLAY l_str TO s_prog_id
         #LET l_str = g_module_id,"   (### data from ",g_src_module_id," ###)" #2015/09/18 by Hiko
         LET l_str = g_module_id 
         DISPLAY l_str TO s_module_id
         DISPLAY g_4gl_file TO s_4gl_file

         #Begin:160701-00022
         ##Begin:2015/09/18 by Hiko
         ##1.取得元件規格版本.
         #CALL sadzp060_2_chk_spec_type(g_prog_id) RETURNING l_type
         #CALL sadzp060_2_get_spec_curr_revision(g_prog_id, l_type, g_module_id) RETURNING l_revision,l_identity,ls_err_msg
         #IF cl_null(ls_err_msg) THEN
         #   #2.若有規格則顯現.
         #   IF NOT cl_null(l_revision) AND l_revision>0 THEN
         #      LET ls_sql = "SELECT dzab099 FROM dzab_t",
         #                   "               LEFT JOIN dzaa_t ON dzaa001=dzab001 AND dzaa003=dzab004 AND dzaa004=dzab002 AND dzaa006=dzab003",
         #                   " WHERE dzaa001=? AND dzaa002=? AND dzaa003='ALL' AND dzaa009=?"
         #      
         #      PREPARE dzab_prep FROM ls_sql
         #      LOCATE l_dzab099 IN FILE
         #      EXECUTE dzab_prep INTO l_dzab099 USING g_prog_id,l_revision,l_identity
         #      FREE dzab_prep
         
         #      LET g_spec = l_dzab099
         #      DISPLAY g_spec TO s_spec
         #   END IF
         #END IF
         ##End:2015/09/18 by Hiko
         #End

      ON ACTION close       #在dialog 右上角 (X)
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         EXIT DIALOG
 
      #交談指令共用ACTION
       &include "common_action.4gl" 
         
   END DIALOG
    
END FUNCTION

#+ 模糊搜尋程式碼中的Function Name的所在位置
PRIVATE FUNCTION adzp280_find_function_name_location(p_funcition_name,p_file)
   DEFINE p_funcition_name STRING,            #要搜尋的function名稱 
          p_file           STRING,            #檔案路徑
          l_line_str       STRING,            #
          l_line_tmp_str   STRING,            #
          l_ch_in          base.Channel,       #Genero讀取的檔案物件變數
          l_return         STRING,
          l_buf_line   base.StringBuffer

   #建立Genero讀取的檔案物件
   LET l_ch_in = base.Channel.create()
   TRY
      #指定來源的的檔案路徑
      CALL l_ch_in.openFile(p_file,"r")
   CATCH
      IF STATUS THEN
         #對此分鏡檔的權限不足
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00156"
         LET g_errparam.extend = "ERROR:permission"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_file
         CALL cl_err()
         EXIT PROGRAM
      END IF
   END TRY

   #因為genero呼叫function名稱不分大小寫,所以一律用小寫比對
   LET p_funcition_name = p_funcition_name.toLowerCase()

   #LET l_expression = "/^function/"
   LET l_buf_line = base.StringBuffer.create()

   LET  l_return = ""
   
   WHILE TRUE
      LET l_line_str = l_ch_in.readLine()

      #備份此行的字串
      LET l_line_tmp_str = l_line_str
      #先除掉兩邊的空白
      LET l_line_str = l_line_str.trim()
      #因為genero呼叫function名稱不分大小寫,所以一律用小寫比對
      LET l_line_str = l_line_str.toLowerCase()
      
      IF l_ch_in.isEof() THEN EXIT WHILE END IF

      #開頭為"#"或不包含" [function name]"或不包含"function "的一律跳過不比對
      IF l_line_str.getCharAt(1) = "#" 
         OR l_line_str.getIndexOf(" "||p_funcition_name,1) = 0 
         OR l_line_str.getIndexOf("function ",1) = 0 THEN
         CONTINUE WHILE
      END IF
      #處理字串之前
      #DISPLAY "l_line_str = ",l_line_str

      #擷取[function name]到[functiona name]之後的第一個(的字串
      LET l_line_str = l_line_str.subString(l_line_str.getIndexOf(p_funcition_name,1),l_line_str.getIndexOf("(",l_line_str.getIndexOf(p_funcition_name,1)))

      CALL l_buf_line.clear()
      CALL l_buf_line.append(l_line_str)
      
      #將[function name]到[functiona name]之後的第一個(的字串之間的空格消除
      CALL l_buf_line.replace(" ","",0)
      
      #處理字串之後
      #DISPLAY "l_line_str = ",l_line_str

      LET l_line_str = l_buf_line.toString()

      #因為[function name]到[functiona name]之後的第一個(的字串之間的空格消除
      #所以留下來的字串若等於[function name]加上(,則就是要找尋的目標
      IF l_line_str = p_funcition_name||"(" THEN
         LET l_return = l_line_tmp_str
         EXIT WHILE
      END IF
      
   END WHILE

   CALL l_ch_in.close()
   #DISPLAY "#########################"
   #DISPLAY "l_return = ",l_return
   #DISPLAY "#########################"
   RETURN  l_return
END FUNCTION

#+ 設定尋找的字串區塊
PRIVATE FUNCTION adzp280_get_select_range(p_text,p_find_str,p_start_find_pos)
   DEFINE p_text           TEXT,
          p_find_str       STRING,
          l_start_pos      LIKE type_t.num20,
          l_end_pos        LIKE type_t.num20,
          p_start_find_pos LIKE type_t.num20,
          l_buf            base.StringBuffer,
          l_str            STRING

   IF p_find_str.getLength() = 0  THEN
      CALL cl_ask_confirm3('-6010',"")
      RETURN
   END IF
          
   LET l_buf = base.StringBuffer.create()
   CALL l_buf.append(p_text)

   #DISPLAY "l_buf.getLength() = ",l_buf.getLength()
   
   LET l_start_pos = l_buf.getIndexOf(p_find_str,p_start_find_pos)
   LET l_end_pos = l_start_pos + p_find_str.getLength()

   #如果從中間找不到在從頭開始找
   IF l_start_pos = 0 THEN
      LET l_start_pos = l_buf.getIndexOf(p_find_str,1)
      LET l_end_pos = l_start_pos + p_find_str.getLength()
   END IF

   IF l_start_pos = 0 THEN
      CALL cl_ask_confirm3('-6010',"")
   END IF
  
   LET l_str = l_buf.subString(l_start_pos,l_end_pos-1)
   
   IF l_str = p_find_str THEN
      #設定滑鼠選取的範圍  
      CALL FGL_DIALOG_SETSELECTION(l_start_pos, l_end_pos)
   END IF

END FUNCTION
