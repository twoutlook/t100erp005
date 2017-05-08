#&define DEBUG
#cch:adzp110主要是單純產生tap檔
# Modify         : 2013/10/24 by Hiko : 修正dzba_t複製時跳版次的問題
# Modify         : 2014/05/27 by Hiko : 1.adzp110_gen_structure_tree與adzp110_gen_section_structure_tree都改在sadzp060_2_after_check_out_for_download執行
#                                       2.將原本在tsd內的<other>改在tap
#                                       3.增加DZBA010(PK)和DZBC007(PK)為條件
#                : 2014/08/06 by Hiko : 1.同一個版次的status要完整呈現u和d,因此取得SQL要變成生/失效兩句UNION,同時設計器Table也需要調整:本版次異動:dzax004
#                : 2014/10/03 by Hiko : 增加dzax007(接收參數起始順序)
#                : 2014/12/10 by Hiko : 本版次異動只記錄版次>1的情況,這樣比較有意義.
#                : 2014/12/10 by Hiko : 本版次異動調整:dzba005(使用標示)=dzba010(客製標示)時,版次>1才設定u,這可提升剛開發程式的上傳效能;但d就不論版次都需要設定.
#                : 2014/12/22 by Hiko : topstd可以簽出c1的規格,程式則不限版次.
#                : 2014/12/27 by Hiko : 失效的資料多一層防呆措施
#                : 2015/04/27 by Hiko : 增加設計器版次資訊的讀取,讓sadzp060_2得以判斷.
#                : 2015/09/01 by Hiko : 程式類型除了M/S外, 其餘類型section的readonly設定為Y.
#                : 2015/11/10 by madey: 1.new function固定給Y
#                                     : 2.修正ORDER BY 順序
#                : 2015/11/09 by Hiko : 1.改善上傳效能,增加一個屬性'ch'來當作本版次異動.
#                                       2.dzax_t/dzbc_t取消本版次異動.
#                : 2015/12/14 by Hiko : 增加權限不足的防呆.
#                : 20160125 by Hiko : 下載路徑改在$TEMPDIR, 以免因為權限不足而無法下載.
#                : 20160707 160707-00033 by Hiko : 增加ind_extra屬性來表示有行業的額外設定需要關注.
#                : 20160809 160809-00022 by Hiko : 修正Z類程式也可以解開Section的問題.
#                : 20160913 160913-00057 by Hiko : 修正add-point設定ch的問題.
#                : 20160929 160922-00039 by Hiko : topstd不可以轉Free Style.

IMPORT os
IMPORT util
IMPORT XML

SCHEMA ds

CONSTANT cs_null_value  STRING = "!@#"
      
GLOBALS "../../cfg/top_global.inc"

#執行的環境變數
DEFINE ms_dgenv  STRING
DEFINE ms_erpver STRING
DEFINE ms_zone   STRING

#為行業別程式
DEFINE mb_is_industry BOOLEAN
DEFINE gs_type STRING #建構類型 #2015/09/01 by Hiko

MAIN
   DEFINE lo_channel_read         base.Channel
   DEFINE ls_file_name            STRING
   DEFINE ls_module_name          STRING
   DEFINE ls_tgl_mod_name         STRING
   DEFINE ls_tgl_file_name        STRING
   DEFINE ls_tgl_main_name        STRING
   DEFINE ls_tgl_random_name      STRING
   DEFINE ls_random_name          STRING
   DEFINE ls_working_path         STRING
   DEFINE ls_prev_working_path    STRING
   DEFINE lb_chrwx_return         BOOLEAN 
   DEFINE ls_os_separator         STRING 
   DEFINE ls_std_prog_name        STRING
   DEFINE ls_version              STRING
   DEFINE ls_std_version          STRING
   DEFINE ls_normal_style         STRING
   ################################################
   DEFINE ls_arg_val1             STRING
   DEFINE ls_arg_val2             STRING
   DEFINE ls_arg_val3             STRING
   DEFINE ls_arg_val4             STRING
   DEFINE ls_arg_val5             STRING
   DEFINE ls_arg_val6             STRING
   DEFINE ls_arg_val7             STRING
   ################################################
   DEFINE lo_line_string_buf      base.StringBuffer
   DEFINE lo_add_point_strbuf     base.StringBuffer
   ################################################
   DEFINE ls_tap_filename         STRING
   DEFINE ls_tap_tmp_filename     STRING
   DEFINE ls_tap_back_filename    STRING
   DEFINE ls_tap_tmp_back_filename STRING
   DEFINE ls_tap_path_name        STRING
   ################################################
   DEFINE ls_tgl_ext_name         STRING
   DEFINE ls_tap_ext_name         STRING
   ################################################
   DEFINE ls_dzx_path             STRING 
   DEFINE ls_tap_full_path_name   STRING
   DEFINE ls_tmp_tap_full_path_name STRING
   ################################################
   DEFINE lo_xml_tap_document     xml.DomDocument
   DEFINE lo_xml_tap_elements     xml.DomNode
   ################################################
   DEFINE ls_booking_y            STRING
   DEFINE ls_booking_n            STRING
   DEFINE ls_type                 STRING 
   DEFINE ls_DGENV                STRING
   DEFINE ls_section_flag         STRING 
   DEFINE lb_result               BOOLEAN, #2013/10/11 by Hiko
          ls_err_msg              STRING   #2013/10/11 by Hiko

   &ifndef DEBUG
   #CONNECT TO "ds"
   CALL cl_tool_init()
   &else
   CONNECT TO "local"
   &endif
   
   #取得參數
   LET ls_arg_val1 = ARG_VAL(2) #Program Name
   LET ls_arg_val2 = ARG_VAL(3) #Module Name
   LET ls_arg_val3 = ARG_VAL(4) #Version
   LET ls_arg_val4 = ARG_VAL(5) #Standard program name
   LET ls_arg_val5 = ARG_VAL(6) #Standard program Version
   LET ls_arg_val6 = ARG_VAL(7) #Spec Type (M,S,B....)
   LET ls_arg_val7 = ARG_VAL(8) #DGENV

   #驗證參數
   &ifndef DEBUG
   CALL adzp110_check_argument(ls_arg_val1) RETURNING ls_arg_val1 
   IF ls_arg_val1 IS NULL THEN
     EXIT PROGRAM
   ELSE
     LET ls_file_name     = ls_arg_val1
     LET ls_version       = ls_arg_val3
     LET ls_std_prog_name = NVL(ls_arg_val4,ls_file_name)
     LET ls_std_version   = ls_arg_val5
     LET ls_type          = ls_arg_val6   
     LET ls_DGENV         = ls_arg_val7
   END IF
   &endif

   LET gs_type = ls_type #2015/09/01 by Hiko

   ##############################
   #begin For Debug
   IF ls_arg_val1 IS NULL THEN
     LET ls_file_name = "aiti333"
   END IF  
   #end For Debug
   ##############################

   #取得模組名稱
   IF ls_arg_val2 IS NULL THEN
     LET ls_module_name = ls_file_name.subString(1,3)
   ELSE  
     LET ls_module_name = ls_arg_val2.trim()
   END IF

   #取得標準或是客製化變數
   LET ms_dgenv  = NVL(FGL_GETENV("DGENV"),"NO DEFINE!!")
   LET ms_erpver = NVL(FGL_GETENV("ERPVER"),"NO DEFINE!!")
   LET ms_zone   = NVL(FGL_GETENV("ZONE"),"NO DEFINE!!")

   #判斷是否為行業別程式
   IF ls_std_prog_name = ls_file_name THEN
     LET mb_is_industry = FALSE
   ELSE
     LET mb_is_industry = TRUE
   END IF

   #取得作業系統的分隔符號
   CALL os.Path.separator() RETURNING ls_os_separator 
   
   #設定延伸檔名
   LET ls_tgl_ext_name  = "tgl"
   #LET ls_tap_path_name = "..",ls_os_separator,"tap",ls_os_separator
   LET ls_tap_path_name = FGL_GETENV("TEMPDIR"),ls_os_separator #20160125 by Hiko
   LET ls_tap_ext_name  = "tap"
   
   #取得及切換目前工作目錄
   CALL os.Path.pwd() RETURNING ls_prev_working_path

   LET ls_working_path = os.Path.join(os.Path.join(FGL_GETENV(ls_module_name.toUpperCase()),"dzx"),"tgl")
   
   CALL adzp110_change_working_path(ls_working_path)

   #建立　String Buffer 讀取通道
   LET lo_channel_read     = base.Channel.create()
   LET lo_line_string_buf  = base.StringBuffer.create()
   LET lo_add_point_strbuf = base.StringBuffer.create()

   CALL lo_channel_read.setDelimiter("")
   
   #呼叫亂數產生器
   CALL util.Math.srand()
   
   #定義取用樣板檔案(先將原始檔案複製一份為亂數取碼的檔案, 再讀取這個檔案, 避免同時間多人讀取情形)
   LET ls_tgl_file_name = ls_file_name,".",ls_tgl_ext_name
   LET ls_tgl_main_name = ls_file_name
   LET ls_tgl_mod_name  = ls_module_name #ls_tgl_file_name.subString(1,3)
   
   CALL adzp110_gen_random_name() RETURNING ls_random_name #產生亂數副檔名
   LET ls_tgl_random_name = ls_tgl_file_name,".",ls_random_name
   
   #CALL adzp110_get_program_style(ls_tgl_main_name) RETURNING ls_normal_style

   #############################################################################

   LET ls_booking_y = "Y"
   LET ls_booking_n = "N"
   
   #取得該程式是否有經過異動框架
   CALL adzp110_get_section_if_modify(ls_file_name,ls_version,ls_DGENV) RETURNING ls_section_flag
   
   #產出 XML 標頭
   LET lo_xml_tap_document = xml.DomDocument.CreateDocument("add_points")
   LET lo_xml_tap_elements = lo_xml_tap_document.getDocumentElement()
   CALL lo_xml_tap_elements.setAttribute("prog",ls_tgl_main_name)
   CALL lo_xml_tap_elements.setAttribute("std_prog",ls_std_prog_name)
   CALL lo_xml_tap_elements.setAttribute("erpver",ms_erpver)
   CALL lo_xml_tap_elements.setAttribute("module",ls_module_name.toUpperCase())
   CALL lo_xml_tap_elements.setAttribute("ver",ls_version)
   CALL lo_xml_tap_elements.setAttribute("env",ms_dgenv)
   CALL lo_xml_tap_elements.setAttribute("zone",ms_zone)
   #CALL lo_xml_tap_elements.setAttribute("normal_style",ls_normal_style)
   CALL lo_xml_tap_elements.setAttribute("booking", ls_booking_y)
   CALL lo_xml_tap_elements.setAttribute("type", ls_type)   
   CALL lo_xml_tap_elements.setAttribute("identity", ls_DGENV)   
   CALL lo_xml_tap_elements.setAttribute("section_flag", ls_section_flag)   
   CALL lo_xml_tap_elements.setAttribute("designer_ver", sadzp060_2_get_designer_ver()) #2015/04/27 by Hiko     
   CALL lo_xml_tap_elements.setAttribute("login_user", g_account) #160922-00039     
   
   CALL adzp110_gen_other(ls_file_name, ls_version, lo_xml_tap_elements, ls_DGENV) RETURNING lb_result #2014/05/27 by Hiko

   #cch:在抓出Add Point function前,判斷ls_version是否存在,不存在則產生新的結構樹
   #CALL adzp110_gen_structure_tree(ls_file_name,ls_version) #2014/05/27 by Hiko
   #CALL adzp110_gen_section_structure_tree(ls_file_name,ls_version) #2014/05/27 by Hiko

   #抓出 Add Point function 
   CALL adzp110_get_custom_function(ls_file_name,ls_version,ls_std_prog_name,ls_std_version,TRUE,lo_xml_tap_document,ls_DGENV) 
   CALL adzp110_get_section_custom_function(ls_file_name,ls_version,ls_std_prog_name,ls_std_version,TRUE,lo_xml_tap_document,ls_DGENV) 
   
   #############################################################################
   
   #將舊tap檔案備份為原副檔名加上亂數的名稱
   CALL adzp110_gen_random_name() RETURNING ls_random_name
   LET ls_tap_filename      = ls_tap_path_name,ls_file_name,".",ls_tap_ext_name
   LET ls_tap_tmp_filename  = ls_tap_path_name,ls_file_name,".",ls_tap_ext_name,".read"
   
   LET ls_tap_back_filename = ls_tap_path_name,ls_file_name,".",ls_tap_ext_name,".bak" --,ls_random_name
   LET ls_tap_tmp_back_filename = ls_tap_path_name,ls_file_name,".",ls_tap_ext_name,".read.bak" --,ls_random_name
   
   CALL adzp110_backup_file(ls_tap_filename,ls_tap_back_filename)
   CALL adzp110_backup_file(ls_tap_tmp_filename,ls_tap_tmp_back_filename)

   TRY
      #開檔將String Buffer寫入實體檔案
      CALL lo_xml_tap_document.setFeature("format-pretty-print", "TRUE")
      CALL lo_xml_tap_document.save(ls_tap_filename)
      
      #開檔將String Buffer寫入實體無權限檔案
      CALL lo_xml_tap_elements.setAttribute("booking", ls_booking_n)
      CALL lo_xml_tap_document.save(ls_tap_tmp_filename)
   CATCH
      #Begin:2015/12/14 by Hiko
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00739" #使用者的權限不足, 無法建立設計檔.
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      EXIT PROGRAM
      #End:2015/12/14 by Hiko
   END TRY
   #############################################################################
   
   #更改產出tap權限
   CALL os.Path.pwd() RETURNING ls_dzx_path
   LET ls_dzx_path = ls_dzx_path.subString(1,ls_dzx_path.getIndexOf("dzx",1)+2)
   #DISPLAY ls_dzx_path

   LET ls_tap_full_path_name = ls_dzx_path,ls_os_separator,ls_tap_ext_name,ls_os_separator,ls_file_name,".",ls_tap_ext_name
   LET ls_tmp_tap_full_path_name = ls_dzx_path,ls_os_separator,ls_tap_ext_name,ls_os_separator,ls_file_name,".",ls_tap_ext_name,".read"
   
   CALL os.Path.chrwx(ls_tap_full_path_name, 511) RETURNING lb_chrwx_return
   CALL os.Path.chrwx(ls_tmp_tap_full_path_name, 511) RETURNING lb_chrwx_return
   
   #刪除檔案
   --CALL adzp110_delete_backup_file(ls_tap_back_filename)
   --CALL adzp110_delete_backup_file(ls_tap_tmp_back_filename)

   #切換回原始工作目錄
   CALL adzp110_change_working_path(ls_prev_working_path)
   DISPLAY "Generate tap file finished."
   
END MAIN

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<other>其他設定
# Input parameter : p_prog 程式代號
#                 : p_version 程式版次
#                 : p_node_tap <tsd> node
#                 : p_identity 客製標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/27 by Hiko
##########################################################################
PRIVATE FUNCTION adzp110_gen_other(p_prog, p_version, p_node_tap, p_identity)
   DEFINE p_prog STRING,
          p_version LIKE dzaf_t.dzaf004, #2014/12/10 by Hiko
          p_node_tap xml.DomNode,
          p_identity STRING
   DEFINE lnode_other xml.DomNode,
          lnode_child xml.DomNode,
          ls_sql STRING,
          lr_dzax RECORD LIKE dzax_t.*
   DEFINE ls_upd STRING, #2014/08/06 by Hiko
          l_revision LIKE dzaf_t.dzaf004 #2014/12/10 by Hiko

   TRY
      DISPLAY "adzp110_gen_other : get ",p_prog," other setting"
      LET ls_sql = "SELECT *",
                    " FROM dzax_t",
                   " WHERE dzax001='",p_prog,"' AND dzax006='",p_identity,"' AND dzaxstus='Y'" 
      DECLARE dzax_curs SCROLL CURSOR FROM ls_sql
      OPEN dzax_curs
      FETCH FIRST dzax_curs INTO lr_dzax.*
      CLOSE dzax_curs

      LET lnode_other = p_node_tap.appendChildElement("other")
      LET lnode_child = lnode_other.appendChildElement("code_template")
      CALL lnode_child.setAttribute("value", lr_dzax.dzax002 CLIPPED)

      #Begin:2014/08/06 by Hiko
      LET ls_upd = ""
      #Begin:2015/11/09 by Hiko
      #LET l_revision = p_version
      #IF lr_dzax.dzax006=p_identity THEN #2014/12/17 by Hiko
      #   IF lr_dzax.dzax004 CLIPPED="Y" THEN
      #      LET ls_upd = "u"
      #   END IF
      #END IF
      #End:2015/11/09 by Hiko
      CALL lnode_child.setAttribute("status", ls_upd)
      #End:2014/08/06 by Hiko

      LET lnode_child = lnode_other.appendChildElement("free_style")
      CALL lnode_child.setAttribute("value", lr_dzax.dzax003 CLIPPED)
      CALL lnode_child.setAttribute("status", ls_upd)

      #Begin:2014/10/03 by Hiko
      LET lnode_child = lnode_other.appendChildElement("start_arg")
      CALL lnode_child.setAttribute("value", lr_dzax.dzax007 CLIPPED)
      CALL lnode_child.setAttribute("status", ls_upd)
      #End:2014/10/03 by Hiko

      RETURN TRUE
   CATCH 
      DISPLAY "ERROR : adzp110_gen_other failure!"
      DISPLAY "STATUS=",STATUS
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
      DISPLAY "ls_sql=",ls_sql,"<<"

      RETURN FALSE
   END TRY
END FUNCTION

FUNCTION adzp110_get_custom_function(p_file_name,p_version,p_std_file_name,p_std_version,p_is_industry,p_xml_document,p_dgenv)
DEFINE
  p_file_name     STRING,
  p_version       STRING,
  p_std_file_name STRING,
  p_std_version   STRING,
  p_is_industry   BOOLEAN,
  p_xml_document  xml.DomDocument,
  p_dgenv         STRING
DEFINE
  ls_file_name      STRING,
  ls_version        STRING,
  ls_std_file_name  STRING,
  ls_std_version    STRING,
  lb_is_industry    BOOLEAN,
  ls_dgenv          STRING,
  ls_tap_xml        STRING,
  li_space          SMALLINT,
  ls_tap_content    STRING,
  ls_function_name  STRING,
  lsb_tap_strbuf    base.StringBuffer,
  ls_sql            STRING,
  li_func_index     INTEGER,
  li_func_pos       INTEGER,
  ls_cite_std       STRING,
  ls_cdata          STRING,
  li_function_count INTEGER,  
  ls_new_function   STRING,
  lo_tap_function_xml xml.DomNode,
  lo_tap_node_xml     xml.DomNode,
  lo_tap_cdata_xml    xml.DomNode,
  lo_contents RECORD
                function_name      LIKE dzbb_t.dzbb002,
                order_by           LIKE dzba_t.dzba006,  
                dzbastus           LIKE dzba_t.dzbastus, #2014/08/06 by Hiko  
                tap_function_name  LIKE dzbb_t.dzbb002,
                point_version      LIKE dzbb_t.dzbb003,
                point_type         LIKE dzbb_t.dzbb004,
                cite_std           VARCHAR(3),
                mark_hard          VARCHAR(3),
                standard_contents  TEXT
              END RECORD
DEFINE
  l_tap_return STRING,
  ls_upd       STRING, #2014/08/06 by Hiko
  l_revision   LIKE dzaf_t.dzaf004 #2014/12/10 by Hiko
  DEFINE ls_ch STRING #2015/11/09 by Hiko
  #Begin:160707-00033
  DEFINE ls_lower_func_name STRING,
         li_func_idx        SMALLINT,
         ls_real_func       STRING,
         ls_gzoj_sql        STRING,
         li_gzoj_cnt        SMALLINT
  #End:160707-00033

  LET ls_file_name     = p_file_name
  LET ls_version       = p_version
  LET ls_std_file_name = p_std_file_name
  LET ls_std_version   = p_std_version
  LET lb_is_industry   = p_is_industry
  LET ls_dgenv         = p_dgenv.trim()
  LET l_tap_return = ""

  LET li_space       = 10
  LET ls_tap_content = ""
  LET ls_cite_std    = ""
  LET ls_cdata       = ""
  
  LET lsb_tap_strbuf = base.StringBuffer.create()

  CALL lsb_tap_strbuf.clear()

  #LET ls_sql = "SELECT BB.DZBB002 FUNCTION_NAME,                         ", #BB002-->BA003      
  LET ls_sql = "SELECT BA.DZBA003 FUNCTION_NAME,                         ",       
               "       BA.DZBA006,                                       ",
               "       BA.DZBASTUS,                                      ", #2014/08/06 by Hiko
               "       BA.DZBA003,                                       ",  #BB002-->BA003                             
               "       BA.DZBA004,                                       ",  #BB003-->BA004                             
               "       BA.DZBA005,                                       ",  #BB004-->BA005                             
               "       BA.DZBA007,                                       ",
               "       BA.DZBA009,                                       ",
               "       BB.DZBB098                                        ",
               "  FROM DZBA_T BA                                         ",
               " INNER JOIN DZBB_T BB  ON BB.DZBB001 = BA.DZBA001        ",#2014/05/27 by Hiko:LEFT改INNER
               "                            AND BB.DZBB002 = BA.DZBA003  ",  
               "                            AND BB.DZBB003 = BA.DZBA004  ",  
               "                            AND BB.DZBB004 = BA.DZBA005  ",  
              ##" WHERE BA.DZBASTUS = 'Y'                                 ", #2014/08/06 by Hiko
               " WHERE BA.DZBA001  = '",ls_file_name,"'                  ",
               "   AND BA.DZBA002  = '",ls_version,"'                    ",
               "   AND BA.DZBA010  = '",ls_dgenv,"'                      ", #2014/05/27 by Hiko
               "   AND BA.DZBASTUS = 'Y'                                 ", #2015/11/09 by Hiko:失效就不取得了
              #" ORDER BY 2, 3                                           " 
               " ORDER BY 2, 1                                           "  #20151110 modify 
  PREPARE lpre_get_custom_function FROM ls_sql
  DECLARE lcur_get_custom_function CURSOR FOR lpre_get_custom_function

  LOCATE lo_contents.standard_contents IN FILE
  
  FOREACH lcur_get_custom_function INTO lo_contents.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    IF NVL(lo_contents.function_name,cs_null_value) <> cs_null_value THEN 
      LET ls_tap_xml = ""

      LET ls_tap_content   = lo_contents.standard_contents
      LET ls_function_name = lo_contents.function_name
      LET ls_cite_std      = lo_contents.cite_std

      LET ls_cdata = ls_tap_content

      LET li_func_index = ls_function_name.getIndexOf("(",1)-1
      IF (li_func_index <= 0) THEN
        LET li_func_pos = ls_function_name.getLength()
      ELSE
        LET li_func_pos = ls_function_name.subString(1,li_func_index)
      END IF    

      LET ls_function_name = lo_contents.tap_function_name 
      
     #20151110 :mark 
     #CALL adzp110_get_function_counts(ls_file_name,ls_function_name,ls_dgenv) RETURNING li_function_count
     #LET ls_new_function = "N" 
     #IF li_function_count > 1 OR (ls_function_name.subString(1,9) <> "function." AND ls_function_name.subString(1,7) <> "dialog." AND ls_function_name.subString(1,7) <> "report.") THEN
     #  LET ls_new_function = "N" 
     #ELSE
     #  LET ls_new_function = "Y" 
     #END IF 
     #20151110 :mark 

      LET lo_tap_function_xml = p_xml_document.getDocumentElement()
      
      LET lo_tap_node_xml = lo_tap_function_xml.appendChildElement("point")
      
      CALL lo_tap_node_xml.setAttribute("name",ls_function_name)
      CALL lo_tap_node_xml.setAttribute("order",lo_contents.order_by)
      CALL lo_tap_node_xml.setAttribute("ver",lo_contents.point_version)
      CALL lo_tap_node_xml.setAttribute("cite_std",ls_cite_std)
      #CALL lo_tap_node_xml.setAttribute("cite_ver",lo_contents.cite_ver CLIPPED)
     #CALL lo_tap_node_xml.setAttribute("new",ls_new_function) #20151110 mark
      CALL lo_tap_node_xml.setAttribute("new","Y")
    
      #Begin:160707-00033
      CALL lo_tap_node_xml.setAttribute("ind_extra","N") #預設為沒有行業額外設定.

      LET ls_lower_func_name = ls_function_name.toLowerCase()
      LET li_func_idx = ls_lower_func_name.getIndexOf("function.", 1)
      IF li_func_idx>0 THEN
         LET ls_real_func = ls_function_name.subString(li_func_idx+1, ls_function_name.getLength())
         #不需要刻意判斷行業條件, 同一個環境只需要判斷是否有設定就可以了.
         LET ls_gzoj_sql = "SELECT COUNT(*) FROM gzoj_t",
                           " WHERE gzoj001='",ls_file_name.trim(),"'",
                           "   AND gzoj006='",ls_real_func.trim(),"'"
         PREPARE gzoj_prep FROM ls_gzoj_sql
         EXECUTE gzoj_prep INTO li_gzoj_cnt
         FREE gzoj_prep
         IF li_gzoj_cnt>0 THEN
            CALL lo_tap_node_xml.setAttribute("ind_extra","Y")
         END IF
      END IF
      #End:160707-00033

      #Begin:2015/11/09 by Hiko
      ##Begin:2014/08/06 by Hiko
      #LET ls_upd = ""
      #IF lo_contents.dzbastus CLIPPED="N" THEN #2014/12/27 by Hiko:若發生不該發生的問題,這裡至少要防呆.
      #   LET ls_upd = "d"
      #END IF
      #LET l_revision = ls_version
      #IF lo_contents.point_type=ls_dgenv AND #2014/12/17 by Hiko:dzba005(使用標示)=dzba010(客製標示)
      #   lo_contents.point_version=ls_version THEN
      #   IF lo_contents.dzbastus CLIPPED="Y" THEN
      #      IF l_revision>1 THEN #2014/12/10 by Hiko
      #         LET ls_upd = "u"
      #      END IF
      #   ELSE
      #      IF lo_contents.dzbastus CLIPPED="N" THEN
      #         LET ls_upd = "d"
      #      END IF
      #   END IF
      #END IF
      
      #CALL lo_tap_node_xml.setAttribute("status",ls_upd)
      ##End:2014/08/06 by Hiko
      LET l_revision = ls_version #160913-00057
      LET ls_ch = ""
      IF lo_contents.point_type=ls_dgenv AND #2014/12/17 by Hiko:dzba005(使用標示)=dzba010(客製標示)
         lo_contents.point_version=ls_version THEN
         IF lo_contents.dzbastus CLIPPED="Y" THEN
            IF l_revision>1 THEN #2014/12/10 by Hiko
               LET ls_ch = "Y"
            END IF
         END IF
      END IF

      CALL lo_tap_node_xml.setAttribute("ch",ls_ch)
      CALL lo_tap_node_xml.setAttribute("status","")
      #End:2015/11/09 by Hiko

      CALL lo_tap_node_xml.setAttribute("src",lo_contents.point_type)

      #Begin:2014/12/22 by Hiko:topstd不能修改客製的設計資料.
      CALL lo_tap_node_xml.setAttribute("readonly","")
      IF g_account="topstd" THEN
         IF lo_contents.point_type CLIPPED="c" THEN
            CALL lo_tap_node_xml.setAttribute("readonly","Y")
         END IF
      END IF
      #End:2014/12/22 by Hiko

      CALL lo_tap_node_xml.setAttribute("mark_hard",NVL(lo_contents.mark_hard,"N"))

      LET lo_tap_cdata_xml = p_xml_document.createCDATASection(ls_cdata)
      CALL lo_tap_node_xml.appendChild(lo_tap_cdata_xml)
    END IF 
  END FOREACH  
  
  CLOSE lcur_get_custom_function
  
  LET l_tap_return = lsb_tap_strbuf.toString()
  
  FREE lo_contents.standard_contents
  FREE lcur_get_custom_function
  FREE lpre_get_custom_function

END FUNCTION

FUNCTION adzp110_get_section_custom_function(p_file_name,p_version,p_std_file_name,p_std_version,p_is_industry,p_xml_document,p_dgenv)
DEFINE
  p_file_name     STRING,
  p_version       STRING,
  p_std_file_name STRING,
  p_std_version   STRING,
  p_is_industry   BOOLEAN,
  p_xml_document  xml.DomDocument,
  p_dgenv         STRING
DEFINE
  ls_file_name      STRING,
  ls_version        STRING,
  ls_std_file_name  STRING,
  ls_std_version    STRING,
  lb_is_industry    BOOLEAN,
  ls_dgenv          STRING,
  ls_tap_xml        STRING,
  li_space          SMALLINT,
  ls_tap_content    STRING,
  ls_function_name  STRING,
  lsb_tap_strbuf    base.StringBuffer,
  ls_sql            STRING,
  li_func_index     INTEGER,
  li_func_pos       INTEGER,
  ls_cite_std       STRING,
  ls_cdata          STRING,
  li_function_count INTEGER,  
  ls_new_function   STRING,
  lo_tap_function_xml xml.DomNode,
  lo_tap_node_xml     xml.DomNode,
  lo_tap_cdata_xml    xml.DomNode,
  lo_contents RECORD
                function_name      LIKE dzbd_t.dzbd002,
                #order_by           LIKE dzbc_t.dzbc006,  
                order_by           LIKE dzbc_t.dzbc010,  #2015/11/09 by Hiko:移除DZBC006改成DZBC010
                this_ver_modify    LIKE dzbc_t.dzbc009, #2014/08/06 by Hiko  
                tap_function_name  LIKE dzbd_t.dzbd002,
                point_version      LIKE dzbd_t.dzbd003,
                point_type         LIKE dzbd_t.dzbd004,
                standard_contents  TEXT
              END RECORD
DEFINE
  l_tap_return STRING,
  ls_upd       STRING, #2014/08/06 by Hiko
  l_revision   LIKE dzaf_t.dzaf004 #2014/12/10 by Hiko
  DEFINE ls_ch STRING #2015/11/09 by Hiko

  LET ls_file_name     = p_file_name
  LET ls_version       = p_version
  LET ls_std_file_name = p_std_file_name
  LET ls_std_version   = p_std_version
  LET lb_is_industry   = p_is_industry
  LET ls_dgenv         = p_dgenv.trim()
  LET l_tap_return = ""

  LET li_space       = 10
  LET ls_tap_content = ""
  LET ls_cite_std    = ""
  LET ls_cdata       = ""
  
  LET lsb_tap_strbuf = base.StringBuffer.create()

  CALL lsb_tap_strbuf.clear()

  #Section 沒有原始程式的問題 2014.03.20
  LET ls_sql = "SELECT SUBSTRB(BD.DZBD002,10,LENGTHB(BD.DZBD002)),      ",
               #"       BC.DZBC006,                                      ",
               "       BC.DZBC010,                                      ", #2015/11/09 by Hiko:移除DZBC006改成DZBC010
               "       BC.DZBC009,                                      ", #2014/08/06 by Hiko
               "       BD.DZBD002,                                      ",
               "       BD.DZBD003,                                      ",
               "       BD.DZBD004,                                      ",
               "       BD.DZBD098                                       ",
               "  FROM DZBD_T BD                                        ",
               "  INNER JOIN DZBC_T BC ON BC.DZBC001  = BD.DZBD001      ", #2014/08/06 by Hiko:正常來說不會有對不到的情況,所以這裡就維持INNER JOIN即可
               "                      AND BC.DZBC004  = BD.DZBD003      ",
               "                      AND BC.DZBC003  = BD.DZBD002      ",
               "                      AND BC.DZBC005  = BD.DZBD004      ",
               #Begin:2014/05/27 by Hiko
              ##"                      AND BC.DZBCSTUS = 'Y'             ",
              ##"                      AND BC.DZBC002  = '",ls_version,"'",
              ##" WHERE BD.DZBD001 = '",ls_file_name,"'                  ",
               " WHERE BC.DZBCSTUS = 'Y'                                ", #2014/08/06 by Hiko:section沒有刪除機會,所以這裡就直接給條件
               "   AND BC.DZBC001  = '",ls_file_name,"'                 ",
               "   AND BC.DZBC002  = '",ls_version,"'                   ",
               "   AND BC.DZBC007  = '",ls_dgenv,"'                     ", #2014/05/27 by Hiko
               #End:2014/05/27 by Hiko
              #" ORDER BY BC.DZBC006, BD.DZBD002                        "
              #" ORDER BY BD.DZBD002                                    "  #20151110
               " ORDER BY BC.DZBC010                                    "  #2015/11/09 by Hiko

  PREPARE lpre_get_section_custom_function FROM ls_sql
  DECLARE lcur_get_section_custom_function CURSOR FOR lpre_get_section_custom_function

  LOCATE lo_contents.standard_contents IN FILE
  
  FOREACH lcur_get_section_custom_function INTO lo_contents.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    IF NVL(lo_contents.function_name,cs_null_value) <> cs_null_value THEN 
      LET ls_tap_xml = ""

      LET ls_tap_content   = lo_contents.standard_contents
      LET ls_function_name = lo_contents.function_name

      LET ls_cdata = ls_tap_content

      LET li_func_index = ls_function_name.getIndexOf("(",1)-1
      IF (li_func_index <= 0) THEN
        LET li_func_pos = ls_function_name.getLength()
      ELSE
        LET li_func_pos = ls_function_name.subString(1,li_func_index)
      END IF    

      LET ls_function_name = lo_contents.tap_function_name 
      
     #20151110 mark
     #CALL adzp110_get_function_counts(ls_file_name,ls_function_name,ls_dgenv) RETURNING li_function_count
     #LET ls_new_function = "N" 
     #IF li_function_count > 1 OR (ls_function_name.subString(1,9) <> "function." AND ls_function_name.subString(1,7) <> "dialog.") THEN
     #  LET ls_new_function = "N" 
     #ELSE
     #  LET ls_new_function = "Y" 
     #END IF 
     #20151110 mark

      LET lo_tap_function_xml = p_xml_document.getDocumentElement()
      
      LET lo_tap_node_xml = lo_tap_function_xml.appendChildElement("section")
      
      CALL lo_tap_node_xml.setAttribute("id",ls_function_name)
      CALL lo_tap_node_xml.setAttribute("ver",lo_contents.point_version)

      #Begin:2015/11/09 by Hiko
      ##Begin:2014/08/06 by Hiko
      #LET ls_upd = ""
      #LET l_revision = ls_version
      #IF (lo_contents.point_type='m' AND ls_dgenv='s') OR
      #   (lo_contents.point_type='c' AND ls_dgenv='c') THEN #2014/12/17 by Hiko:dzbc005(使用標示)=dzbc007(客製標示)
      #   IF lo_contents.this_ver_modify CLIPPED="Y" THEN #SECTION都是取得有效的資料,所以這邊直接判斷本版次異動即可.
      #      IF l_revision>1 THEN #2014/12/10 by Hiko
      #         LET ls_upd = "u"
      #      END IF
      #   END IF
      #END IF
      
      #CALL lo_tap_node_xml.setAttribute("status",ls_upd)
      ##End:2014/08/06 by Hiko
      LET ls_ch = ""
      IF (lo_contents.point_type='m' AND ls_dgenv='s') OR
         (lo_contents.point_type='c' AND ls_dgenv='c') THEN #2014/12/17 by Hiko:dzbc005(使用標示)=dzbc007(客製標示)
         IF lo_contents.this_ver_modify CLIPPED="Y" THEN #SECTION都是取得有效的資料,所以這邊直接判斷本版次異動即可.
            LET ls_ch = "Y"
         END IF
      END IF

      CALL lo_tap_node_xml.setAttribute("ch",ls_ch)
      CALL lo_tap_node_xml.setAttribute("status","")
      #End:2015/11/09 by Hiko

      CALL lo_tap_node_xml.setAttribute("src",lo_contents.point_type)

      #Begin:2014/12/22 by Hiko:topstd不能修改客製的設計資料.
      CALL lo_tap_node_xml.setAttribute("readonly","")
      IF g_account="topstd" THEN
         IF lo_contents.point_type CLIPPED="c" THEN
            CALL lo_tap_node_xml.setAttribute("readonly","Y")
         END IF
      END IF
      #End:2015/09/01 by Hiko

      #End:2014/12/22 by Hiko:非M/S就將readonly設定為Y
      IF gs_type<>"M" AND gs_type<>"S" AND gs_type<>"Z" THEN #160809-00022:加上Z
         CALL lo_tap_node_xml.setAttribute("readonly","Y")
      END IF
      #Begin:2015/09/01 by Hiko

      LET lo_tap_cdata_xml = p_xml_document.createCDATASection(ls_cdata)
      CALL lo_tap_node_xml.appendChild(lo_tap_cdata_xml)
    END IF 
  END FOREACH  
  
  CLOSE lcur_get_section_custom_function
  
  LET l_tap_return = lsb_tap_strbuf.toString()
  
  FREE lo_contents.standard_contents
  FREE lcur_get_section_custom_function
  FREE lpre_get_section_custom_function

END FUNCTION

FUNCTION adzp110_get_section_if_modify(p_file_name,p_version,p_dgenv)
DEFINE
  p_file_name STRING,
  p_version   STRING,
  p_dgenv     STRING
DEFINE
  ls_file_name STRING,
  ls_version   STRING,
  ls_dgenv     STRING,
  ls_SQL       STRING,
  li_counts    INTEGER,
  ls_return    STRING

  LET ls_file_name = p_file_name.trim()
  LET ls_version   = p_version.trim()
  LET ls_dgenv     = p_dgenv.trim()

  LET li_counts = 0

  LET ls_sql = "SELECT COUNT(*)                                     ",
               "  FROM DZBD_T BD                                    ",
               "  INNER JOIN DZBC_T BC ON BC.DZBC001  = BD.DZBD001  ",
               "                      AND BC.DZBC004  = BD.DZBD003  ",
               "                      AND BC.DZBC003  = BD.DZBD002  ",
               "                      AND BC.DZBC005  = BD.DZBD004  ",
               " WHERE BC.DZBCSTUS = 'Y'                            ",
               "   AND BC.DZBC001  = '",ls_file_name,"'             ",
               "   AND BC.DZBC002  = '",ls_version,"'               ",
               "   AND BC.DZBC007  = '",ls_dgenv,"'                 ",
               "   and BD.DZBD004  <> 's'                           "
               
  PREPARE lpre_get_section_if_modify FROM ls_SQL
  DECLARE lcur_get_section_if_modify CURSOR FOR lpre_get_section_if_modify

  OPEN lcur_get_section_if_modify
  FETCH lcur_get_section_if_modify INTO li_counts
  CLOSE lcur_get_section_if_modify
  
  FREE lpre_get_section_if_modify
  FREE lcur_get_section_if_modify  

  LET ls_return = IIF(li_counts > 0,"Y","N")
  
  RETURN ls_return
  
END FUNCTION

################################################################################
#+ Other Functions
################################################################################

#以亂數產出副檔名
FUNCTION adzp110_gen_random_name()
DEFINE
  lr_random_name RECORD
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
  ls_return  STRING

  LET li_max_random_num = 9999
  LET ls_using_format   = "&&&&"
  
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment1 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment2 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment3 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment4 = li_random_value USING ls_using_format
  
  LET ls_final_name = lr_random_name.segment1,".",
                      lr_random_name.segment2,".",
                      lr_random_name.segment3,".",
                      lr_random_name.segment4

  LET ls_return = ls_final_name
  
  RETURN ls_return                     
  
END FUNCTION

#+ 檢核輸入的參數
FUNCTION adzp110_check_argument(p_value)
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
                     "Usage : r.r ",ui.Interface.getName()," [ProgramName(or ComponentName)] [ModuleName] [Version] [StdProgName] [StdProgVer] [SpecType] [DGENV]",
                     ls_crlf 
    DISPLAY ls_command
  ELSE
    LET l_return = l_value.trim()
  END IF
  
  RETURN l_return
  
END FUNCTION

FUNCTION adzp110_backup_file(p_src_filename,p_dst_filename)
DEFINE
  p_src_filename STRING,
  p_dst_filename STRING
DEFINE   
  ls_src_filename  STRING,
  ls_dst_filename  STRING,
  lb_delete        BOOLEAN,
  li_rename_status INTEGER

  LET ls_src_filename = p_src_filename
  LET ls_dst_filename = p_dst_filename

  CALL os.Path.delete(ls_dst_filename) RETURNING lb_delete
  CALL os.Path.rename(ls_src_filename,ls_dst_filename) RETURNING li_rename_status
  IF li_rename_status > 0 THEN
    DISPLAY "Original file ",ls_src_filename," rename to : ",ls_dst_filename
  END IF  
   
END FUNCTION

FUNCTION adzp110_delete_backup_file(p_file_name)
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

FUNCTION adzp110_change_working_path(p_working_path)
DEFINE
  p_working_path STRING
DEFINE
  ls_working_path  STRING,
  ls_pwd           STRING,
  ls_status        STRING,
  li_ch_dir_status INTEGER
  
  LET ls_working_path = p_working_path
  LET ls_status = ""
  
  CALL os.Path.chdir(ls_working_path) RETURNING li_ch_dir_status
  CASE
    WHEN li_ch_dir_status = 0
      LET ls_status = "FAULT"
    WHEN li_ch_dir_status = 1
      LET ls_status = "SUCCESS" 
    OTHERWISE
      LET ls_status = ""
  END CASE
  
  DISPLAY "Changing path to : ",ls_working_path," --> ",ls_status
  CALL os.Path.pwd() RETURNING ls_pwd
  DISPLAY "Current working path : ",ls_pwd
  
END FUNCTION



FUNCTION adzp110_get_function_counts(p_program_name,p_function_name,p_dgenv)
DEFINE
  p_program_name  STRING,
  p_function_name STRING,
  p_dgenv         STRING
DEFINE
  ls_program_name  STRING,
  ls_function_name STRING,
  ls_dgenv         STRING,
  ls_SQL           STRING,
  li_counts        INTEGER,
  li_return        INTEGER

  LET ls_program_name  = p_program_name
  LET ls_function_name = p_function_name
  LET ls_dgenv         = p_dgenv 

  LET li_counts = 0

  #2013.05.15 只找 function or dialog 開頭的, 其他new值均設為"N"
  LET ls_SQL = "SELECT COUNT(*)                            ",
               "  FROM DZBA_T BA                           ",
               " WHERE 1=1                                 ",
               "   AND BA.DZBA001 = '",ls_program_name,"'  ",
               "   AND BA.DZBA003 = '",ls_function_name,"' ",
               "   AND (                                   ",
               "        BA.DZBA003 LIKE 'function.%'       ",
               "        OR                                 ", 
               "        BA.DZBA003 LIKE 'dialog.%'         ",
               "        OR                                 ", 
               "        BA.DZBA003 LIKE 'report.%'         ",
               "       )                                   ",
               "   AND BA.DZBA010  = '",ls_dgenv,"'        "  #2014/05/27 by Hiko
               
  PREPARE lpre_function_counts FROM ls_SQL
  DECLARE lcur_function_counts CURSOR FOR lpre_function_counts

  OPEN lcur_function_counts
  FETCH lcur_function_counts INTO li_counts
  CLOSE lcur_function_counts
  
  FREE lpre_function_counts
  FREE lcur_function_counts  

  -- VER1_FLAG begin
  IF li_counts >= 1 THEN
    LET li_counts = 1
  END IF 
  -- VER1_FLAG end
  
  LET li_return = li_counts
  
  RETURN li_return
  
END FUNCTION

FUNCTION adzp110_get_program_style(p_program_name)
DEFINE
  p_program_name  STRING
DEFINE
  ls_program_name  STRING,
  ls_style         VARCHAR(100),
  ls_SQL           STRING
DEFINE  
  ls_return  STRING

  LET ls_program_name = p_program_name

  LET ls_SQL = "SELECT NVL(GZZA007,'Y') STYLE             ",
               "  FROM GZZA_T                             ",
               " WHERE GZZA001  = '",ls_program_name,"'   ",
               "   AND GZZASTUS = 'Y'                     ",
               " UNION ALL                                ",
               "SELECT NVL(DE.GZDE004,'Y') STYLE          ",
               "  FROM GZDE_T DE                          ",
               " WHERE DE.GZDE001 = '",ls_program_name,"' ",
               "   AND DE.GZDESTUS = 'Y'                  "
               
  PREPARE lpre_get_program_style FROM ls_SQL
  DECLARE lcur_get_program_style CURSOR FOR lpre_get_program_style

  OPEN lcur_get_program_style
  FETCH lcur_get_program_style INTO ls_style
  CLOSE lcur_get_program_style
  
  FREE lpre_get_program_style
  FREE lcur_get_program_style  

  LET ls_return = ls_style
  
  RETURN ls_return
  
END FUNCTION
