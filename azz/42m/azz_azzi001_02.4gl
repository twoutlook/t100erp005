#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi001_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-10-14 11:14:36), PR版次:0001(2014-10-17 15:48:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: azzi001_02
#+ Description: 檔案瀏覽
#+ Creator....: 01274(2014-10-13 17:18:37)
#+ Modifier...: 01274 -SD/PR- 01274
 
{</section>}
 
{<section id="azzi001_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="azzi001_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE t_fdlg_record RECORD
               title             STRING,
               defaultfilename   STRING,
               defaultpath       STRING,
               types             DYNAMIC ARRAY OF RECORD #檔案類型
                  description       STRING,              #類型的描述
                  suffixes          STRING               #example "*.per|*.4gl"
                           END RECORD
END RECORD
CONSTANT C_DIRECTORY="Directory"
DEFINE m_file_list   DYNAMIC ARRAY OF RECORD
         eimage         STRING, #目錄或檔案的圖示
         entry          STRING, #檔名或目錄名
         esize          INT,    #檔案大小
         emodt          STRING, #修改日期
         etype          STRING  #C_DIRECTORY or "*.xxx File"
                     END RECORD

DEFINE m_last_dir    STRING         #最後開啟的目錄位置
DEFINE m_typearr     DYNAMIC ARRAY OF STRING
DEFINE m_typelen     INT
DEFINE m_root_dir    STRING     #要鎖定的根目錄，使用者不可移出此目錄至上層

#end add-point
 
{</section>}
 
{<section id="azzi001_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="azzi001_02.other_dialog" >}

 
{</section>}
 
{<section id="azzi001_02.other_function" readonly="Y" >}

PUBLIC FUNCTION azzi001_02(p_file,p_root_dir)
   DEFINE p_file     STRING,
          p_root_dir STRING
   DEFINE r          t_fdlg_record
   
   CALL m_file_list.clear()
   
   LET m_root_dir = azzi001_02_normalize_dir(p_root_dir)
   IF os.Path.isdirectory(p_file) THEN
      LET r.defaultfilename = p_file
      LET r.defaultpath = azzi001_02_normalize_dir(p_file)
   ELSE
      LET r.defaultfilename = os.Path.basename(p_file)
      LET r.defaultpath = azzi001_02_normalize_dir(os.Path.dirName(p_file))
   END IF

   LET r.title = "Select a Image"
   LET r.types[1].description = "Image (*.jpg, *.png)"
   LET r.types[1].suffixes = "*.jpg|*.png"
   LET r.types[2].description = "All (*.*)"
   LET r.types[2].suffixes = "*"
   RETURN azzi001_02_open(r.*) 
END FUNCTION

PRIVATE FUNCTION azzi001_02_open(p_r)
   DEFINE p_r t_fdlg_record
   DEFINE l_t, l_fn STRING
   IF p_r.defaultpath IS NULL THEN
      IF m_last_dir IS NULL THEN
         LET m_last_dir = "."
      END IF
      LET p_r.defaultpath = m_last_dir
   END IF
   LET l_t= "Open File"
   IF p_r.title IS NOT NULL THEN
      LET l_t = p_r.title
   END IF
   LET l_fn = azzi001_02_dodlg(l_t,p_r.*)
   IF l_fn IS NOT NULL THEN
      LET m_last_dir = azzi001_02_get_dirname(l_fn)
   END IF
   RETURN l_fn
END FUNCTION

PRIVATE FUNCTION azzi001_02_dodlg(p_title,p_r)
   DEFINE p_title STRING
   DEFINE p_r t_fdlg_record
   DEFINE l_currpath, l_path, l_filename, l_ftype, l_filepath STRING
   DEFINE l_doContinue, l_i INT
   DEFINE l_cb ui.ComboBox
   
   OPEN WINDOW azzi001_02_w WITH FORM cl_ap_formpath("azz","azzi001_01_s01")
          ATTRIBUTES(STYLE='functionwin',TEXT=p_title)

   CALL cl_ui_init()

   LET l_currpath = p_r.defaultpath
   LET l_filename = p_r.defaultfilename
   DISPLAY l_filename TO filename
   DISPLAY os.Path.join(l_currpath, l_filename) TO prev_img
   
   IF l_currpath="." THEN 
      LET l_currpath=os.Path.pwd()
   END IF
   
   LET l_cb = ui.ComboBox.forName("formonly.ftype")
   #IF cb IS NULL THEN
   #    DISPLAY "ERROR:form field \"ftype\" not found in form filedlg"
   #    EXIT PROGRAM
   #END IF
   FOR l_i=1 TO p_r.types.getLength()
      CALL l_cb.addItem(p_r.types[l_i].suffixes,p_r.types[l_i].description)
   END FOR
   LET l_ftype=p_r.types[1].suffixes
   DIALOG ATTRIBUTE(UNBUFFERED)
      --use a DISPLAY ARRAY for showing the file list
      DISPLAY ARRAY m_file_list TO s_detail1.* 

         BEFORE ROW
            DISPLAY "" TO prev_img 
            IF m_file_list[arr_curr()].etype<>C_DIRECTORY THEN
               LET l_filename=m_file_list[arr_curr()].entry
               DISPLAY l_filename TO filename 
               DISPLAY os.Path.join(l_currpath, l_filename) TO prev_img
            ELSE
               DISPLAY NULL TO filename
            END IF
           
      END DISPLAY

      INPUT l_filename,l_ftype FROM filename, ftype ATTRIBUTE(WITHOUT DEFAULTS)
         --when the type combobox changes we need to redisplay
         ON CHANGE ftype
            CALL azzi001_02_fetch_files(DIALOG,l_currpath,l_ftype,NULL)
            NEXT FIELD entry
            
      END INPUT

      BEFORE DIALOG
         CALL azzi001_02_fetch_files(DIALOG,l_currpath,l_ftype,l_filename)
         CALL azzi001_02_show_currpath( l_currpath )
         
      ON ACTION ACCEPT
         LET l_doContinue=FALSE

         IF DIALOG.getCurrentItem()="s_detail1" THEN
            --we are in the display array
            LET l_filepath = os.Path.join(l_currpath,m_file_list[arr_curr()].entry)
         ELSE
            --not in display array
            LET l_filepath = os.Path.join(l_currpath,l_filename)
         END IF
         IF os.Path.exists(l_filepath) AND os.Path.isdirectory(l_filepath) THEN
            --switch   the directory and refill the array
            LET l_currpath = azzi001_02_normalize_dir(l_filepath)
            CALL azzi001_02_fetch_files(DIALOG,l_filepath,l_ftype,"..")
            CALL azzi001_02_show_currpath(l_currpath)
            LET l_filename = ""
            LET l_doContinue = TRUE
            IF m_file_list.getLength() > 0 THEN
               LET l_filename =  m_file_list[dialog.getCurrentRow("s_detail1")].entry
               DISPLAY l_filename TO filename
               DISPLAY os.Path.join(l_currpath, l_filename) TO prev_img
            ELSE
               DISPLAY NULL TO prev_img
            END IF
         END IF

         IF NOT l_doContinue THEN
            EXIT DIALOG
         END IF

      ON ACTION cancel
         LET l_filepath=NULL
         EXIT DIALOG

      ON ACTION move_up --move 1 directory level up
         LET l_path = azzi001_02_get_dirname(l_currpath)
         CALL azzi001_02_fetch_files(DIALOG,l_path,l_ftype,l_currpath)
         LET l_currpath=l_path
         CALL azzi001_02_show_currpath(l_currpath)
         DISPLAY NULL TO prev_img
         
   END DIALOG
   CLOSE WINDOW azzi001_02_w
   RETURN l_filepath
END FUNCTION

PRIVATE FUNCTION azzi001_02_fetch_files(p_d,p_currpath,p_typelist,p_currfile)
   DEFINE p_d ui.Dialog
   DEFINE p_currpath STRING
   DEFINE p_typelist STRING
   DEFINE p_currfile STRING
   DEFINE l_i,l_len,l_found INT
   DEFINE l_st base.StringTokenizer
   DEFINE l_cb ui.ComboBox

   LET l_cb = ui.ComboBox.forName("formonly.filename")
   
   LET l_st = base.StringTokenizer.create(p_typelist,"|")
   CALL m_typearr.clear()
   WHILE l_st.hasMoreTokens()
      LET m_typearr[m_typearr.getLength()+1]=l_st.nextToken()
   END WHILE
   LET m_typelen=m_typearr.getLength()
   CALL azzi001_02_getfiles_int(p_currpath)
   #填充檔案名稱的自動完成 
   CALL l_cb.clear()
   LET l_len=m_file_list.getLength()
   FOR l_i = 1 TO l_len
      CALL l_cb.addItem(m_file_list[l_i].entry, m_file_list[l_i].entry)
   END FOR

   LET p_currfile=os.Path.basename(p_currfile)
   FOR l_i=1 TO l_len
      IF p_currfile=m_file_list[l_i].entry THEN
         LET l_found=1
         CALL p_d.setCurrentRow("s_detail1",l_i)
         EXIT FOR
      END IF
   END FOR
   IF NOT l_found THEN
       CALL p_d.setCurrentRow("s_detail1",1)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_02_getfiles_int(p_dir)
   DEFINE p_dir STRING
   DEFINE l_dh, l_isdir INTEGER
   DEFINE l_fname, l_pname, size STRING
   CALL m_file_list.clear()
   LET l_dh = os.Path.diropen(p_dir)
   IF l_dh == 0 THEN 
      RETURN
   END IF
   WHILE TRUE
         LET l_fname = os.Path.dirnext(l_dh)
         IF l_fname IS NULL THEN 
            EXIT WHILE 
         END IF
         IF l_fname == "." OR l_fname == ".." THEN
             CONTINUE WHILE
         END IF
         LET l_pname = os.Path.join(p_dir,l_fname)
         LET l_isdir=os.Path.isdirectory(l_pname)
         IF l_isdir THEN
             LET size = NULL
         ELSE
             LET size = os.Path.size(l_pname)
         END IF
         #IF NOT isdir THEN
             CALL azzi001_02_append_entry(l_isdir,l_fname,size,os.Path.mtime(l_pname))
         #END IF
   END WHILE
   CALL os.Path.dirclose(l_dh)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_02_in_typearr(p_type)
   DEFINE p_type STRING
   DEFINE i INT
   FOR i=1 TO m_typelen
      IF p_type=m_typearr[i] THEN
         RETURN TRUE
      END IF
   END FOR
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION azzi001_02_checktypeandext(p_ext)
   DEFINE p_ext STRING
   IF azzi001_02_in_typearr("*") THEN
       RETURN TRUE
   END IF
   IF p_ext IS NOT NULL THEN
       IF azzi001_02_in_typearr("*.*") THEN
            RETURN TRUE
       END IF
       IF azzi001_02_in_typearr("*"||p_ext) THEN
            RETURN TRUE
       END IF
   END IF
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION azzi001_02_append_entry(p_isdir,p_name,p_size,p_moddate)
   DEFINE p_isdir INT
   DEFINE p_name STRING
   DEFINE p_size INT
   DEFINE p_moddate STRING
   DEFINE type,image,ext STRING
   DEFINE len INT
   IF p_isdir THEN
      LET ext=""
      LET type=C_DIRECTORY
      LET image="folder"
   ELSE
      LET ext = azzi001_02_extension(p_name)
      LET type = SFMT(%"%1-File",ext)
      LET image="file"
   END IF
   IF NOT p_isdir AND NOT azzi001_02_checktypeandext(ext) THEN
      RETURN
   END IF
   
   CALL m_file_list.appendElement()
   LET len=m_file_list.getLength()
   LET m_file_list[len].entry   = p_name
   LET m_file_list[len].etype   = type
   LET m_file_list[len].eimage = image
   LET m_file_list[len].esize   = p_size
   LET m_file_list[len].emodt   = p_moddate
END FUNCTION

PRIVATE FUNCTION azzi001_02_get_dirname(p_filename)
   DEFINE p_filename STRING
   DEFINE l_dirname STRING
   LET l_dirname=os.Path.dirname(p_filename)
   IF l_dirname IS NULL THEN
      LET l_dirname="."
   END IF
   RETURN l_dirname
END FUNCTION

PRIVATE FUNCTION azzi001_02_extension(p_filename)
   DEFINE p_filename STRING
   DEFINE l_extension STRING
   LET l_extension=os.Path.extension(p_filename)
   IF l_extension IS NOT NULL THEN
      LET l_extension=".",l_extension
   END IF
   RETURN l_extension
END FUNCTION

PRIVATE FUNCTION azzi001_02_normalize_dir(p_fname)
   DEFINE p_fname STRING
   DEFINE l_cmd STRING
   DEFINE l_arr DYNAMIC ARRAY OF STRING
   #IF NOT os.Path.isdirectory(fname) THEN 
   #   RETURN fname
   #END IF
   IF fgl_getenv("WINDIR") IS NOT NULL THEN
      LET l_cmd="cd ",p_fname,"&&cd"
   ELSE
      LET l_cmd="cd ",p_fname,"&&pwd"
   END IF
   IF NOT azzi001_02_get_output(l_cmd,l_arr) THEN
      RETURN p_fname||os.Path.separator()
   END IF
   RETURN l_arr[1]||os.Path.separator()
END FUNCTION

PRIVATE FUNCTION azzi001_02_get_output(p_program,p_arr)
   DEFINE p_program, l_linestr STRING
   DEFINE p_arr DYNAMIC ARRAY OF STRING
   DEFINE l_mystatus,l_idx INTEGER
   DEFINE l_c base.Channel
   LET l_c = base.channel.create()
   CALL l_c.setDelimiter("")
   WHENEVER ERROR CONTINUE
   CALL l_c.openpipe(p_program,"r")
   LET l_mystatus=status
   WHENEVER ERROR STOP
   IF l_mystatus THEN
      ERROR "error in file_get_output(program,arr)"
      RETURN 0
   END IF
   CALL p_arr.clear()
   WHILE (l_linestr:=l_c.readline()) IS NOT NULL
      LET l_idx=l_idx+1
      LET p_arr[l_idx]=l_linestr
   END WHILE
   CALL l_c.close()
   RETURN 1
END FUNCTION

PRIVATE FUNCTION azzi001_02_show_currpath(p_currpath)
   DEFINE p_currpath    STRING
   DEFINE l_dialog      ui.Dialog
   LET l_dialog = ui.Dialog.getCurrent()
   IF p_currpath.getCharAt(p_currpath.getLength()) <> os.Path.separator() THEN
      LET p_currpath = p_currpath, os.Path.separator()
   END IF
   DISPLAY p_currpath TO currpath
   IF l_dialog IS NOT NULL THEN
   
      IF p_currpath == m_root_dir THEN
         CALL l_dialog.setActionActive("move_up", FALSE)
         RETURN
      END IF
      
      IF p_currpath.getIndexOf(m_root_dir, 1) == 1 THEN
         CALL l_dialog.setActionActive("move_up", TRUE)
      ELSE
         CALL l_dialog.setActionActive("move_up", FALSE)
      END IF
   END IF
END FUNCTION

 
{</section>}
 
