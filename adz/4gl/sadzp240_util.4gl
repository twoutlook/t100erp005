{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  2016.09.12 Ernestliou 1.產生 ds.sch 後也重產多語言檔
  Modify                  2016.10.18 Ernestliou 1.更新dzyg_t.dzyg002
}

&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp240_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"

FUNCTION sadzp240_util_making_work_directory(p_work_path,p_using_GUID,p_using_temp_dir)
DEFINE
  p_work_path      STRING,
  p_using_GUID     BOOLEAN,
  p_using_temp_dir BOOLEAN
DEFINE
  ls_work_path        STRING,
  lb_using_GUID       BOOLEAN,
  lb_using_temp_dir   BOOLEAN,
  li_ConstructVersion INTEGER,
  li_SD_Version       INTEGER,
  ls_PathName         STRING,
  ls_TEMPDIR          STRING,
  ls_GUID             STRING,
  li_MKDIR            INTEGER,
  li_CHDIR            INTEGER,
  ls_os_separator     STRING
DEFINE 
  ls_return STRING   

  LET ls_work_path  = p_work_path
  LET lb_using_GUID = p_using_GUID
  LET lb_using_temp_dir = p_using_temp_dir
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  LET ls_GUID = security.RandomGenerator.CreateUUIDString()

  IF lb_using_temp_dir THEN 
    LET ls_TEMPDIR = FGL_GETENV("TEMPDIR")
  ELSE
    LET ls_TEMPDIR = ""
  END IF   
  
  IF lb_using_GUID THEN
    IF ls_TEMPDIR IS NULL THEN 
      LET ls_PathName = ls_work_path,"_",ls_GUID
    ELSE
      LET ls_PathName = ls_TEMPDIR,ls_os_separator,ls_work_path,"_",ls_GUID
    END IF  
  ELSE
    IF ls_TEMPDIR IS NULL THEN 
      LET ls_PathName = ls_work_path
    ELSE
      LET ls_PathName = ls_TEMPDIR,ls_os_separator,ls_work_path
    END IF  
  END IF   
                    
  CALL os.Path.mkdir(ls_PathName) RETURNING li_MKDIR
  CALL os.Path.chdir(ls_PathName) RETURNING li_CHDIR  

  LET ls_return = ls_PathName
  
  RETURN ls_return  
  
END FUNCTION

FUNCTION sadzp240_util_get_parameter(p_level,p_param)
DEFINE
  p_level STRING,
  p_param STRING
DEFINE
  ls_level     STRING,
  ls_param     STRING,
  ls_sql       STRING,
  ls_parameter VARCHAR(30) 
DEFINE
  ls_return    STRING

  LET ls_level = p_level
  LET ls_param = p_param

  LET ls_sql = "SELECT EJ.DZEJ005                        ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzp240_parameters' ",
               "   AND EJ.DZEJ003 = '",ls_level,"'       ",
               "   AND EJ.DZEJ004 = '",ls_param,"'       "
                              
  PREPARE lpre_get_parameter FROM ls_sql
  DECLARE lcur_get_parameter CURSOR FOR lpre_get_parameter

  OPEN lcur_get_parameter
  FETCH lcur_get_parameter INTO ls_parameter
  CLOSE lcur_get_parameter
  
  FREE lpre_get_parameter
  FREE lcur_get_parameter  

  LET ls_return = ls_parameter
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp240_util_get_cpu_resource()
DEFINE 
  lo_channel  base.Channel   
DEFINE 
  li_cpu_number    INTEGER,
  ls_using_percent STRING,
  li_using_percent INTEGER,
  li_percent       FLOAT,
  ls_line          STRING
DEFINE
  li_return INTEGER  

  CALL sadzp240_util_get_parameter(cs_param_level_resource,cs_param_using_cpu_resource) RETURNING ls_using_percent
  LET li_using_percent = NVL(ls_using_percent.trim(),"80")
  IF li_using_percent <= 0 THEN
    LET li_using_percent = 80
  END IF   
  IF li_using_percent > 100 THEN
    LET li_using_percent = 100
  END IF   
 
  LET lo_channel = base.Channel.CREATE()
  CALL lo_channel.openPipe("fglWrt -a cpu", "r") #CPU數
  IF lo_channel.READ(ls_line) THEN
    LET li_cpu_number = ls_line
  END IF
  CALL lo_channel.CLOSE()

  LET li_percent = li_using_percent/100
  
  LET li_cpu_number = (li_cpu_number * li_percent)
  IF li_cpu_number < 1 THEN LET li_cpu_number = 1 END IF 
  
  LET li_return = li_cpu_number
  
  RETURN li_return
   
END FUNCTION

FUNCTION sadzp240_util_trim_str(p_string)
DEFINE
  p_string STRING
DEFINE
  ls_string    STRING,
  lo_channel   base.Channel,
  ls_TextLine  STRING,
  li_RecCnt    INTEGER
DEFINE
  ls_return STRING

  LET ls_string = p_string

  LET ls_string = ls_string.trim()
  
  LET ls_return = ls_string
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzp240_util_get_min_start_datetime(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid     STRING,
  ls_sql      STRING,
  ls_datetime VARCHAR(50)
DEFINE
  ls_return  STRING

  LET ls_guid = p_guid

  LET ls_sql = " SELECT TO_CHAR(MIN(NVL(EZ.DZEZ005,SYSDATE-365)),'YYYY-MM-DD HH24:MI:SS') MINSDT ",
               "   FROM DZEZ_T EZ                                                                ",
               "  WHERE EZ.DZEZ001 = '",ls_GUID,"'                                               "
                              
  PREPARE lpre_get_min_start_datetime FROM ls_sql
  DECLARE lcur_get_min_start_datetime CURSOR FOR lpre_get_min_start_datetime

  OPEN lcur_get_min_start_datetime
  FETCH lcur_get_min_start_datetime INTO ls_datetime
  CLOSE lcur_get_min_start_datetime
  
  FREE lpre_get_min_start_datetime
  FREE lcur_get_min_start_datetime  

  LET ls_return = NVL(ls_datetime,CURRENT YEAR TO SECOND)
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp240_util_get_max_finish_datetime(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid     STRING,
  ls_sql      STRING,
  ls_datetime VARCHAR(50)
DEFINE
  ls_return  STRING

  LET ls_guid = p_guid

  LET ls_sql = " SELECT TO_CHAR(MAX(NVL(EZ.DZEZ006,SYSDATE)),'YYYY-MM-DD HH24:MI:SS') MAXFDT ",
               "   FROM DZEZ_T EZ                                                            ",
               "  WHERE EZ.DZEZ001 = '",ls_GUID,"'                                           "
                              
  PREPARE lpre_get_max_finish_datetime FROM ls_sql
  DECLARE lcur_get_max_finish_datetime CURSOR FOR lpre_get_max_finish_datetime

  OPEN lcur_get_max_finish_datetime
  FETCH lcur_get_max_finish_datetime INTO ls_datetime
  CLOSE lcur_get_max_finish_datetime
  
  FREE lpre_get_max_finish_datetime
  FREE lcur_get_max_finish_datetime  

  LET ls_return = NVL(ls_datetime,CURRENT YEAR TO SECOND)
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp240_util_set_form_title(p_form,p_lang) 
DEFINE 
  p_form  STRING,
  p_lang  STRING
DEFINE 
  ls_form      STRING,
  ls_lang      STRING,
  lo_window    ui.Window,
  lf_form      ui.Form,
  ls_cfg_path  STRING,
  ls_4st_path  STRING,
  ls_img_path  STRING,
  ls_icon_path STRING
DEFINE 
  ls_sql    STRING,
  ls_title  VARCHAR(1024) 

  LET ls_form = p_form
  LET ls_lang = p_lang
  
  LET ls_sql = "SELECT GZDEL003                ",
               "  FROM GZDEL_T                 ",
               " WHERE GZDEL001 = '",ls_form,"'",
               "   AND GZDEL002 = '",ls_lang,"'"
               
  PREPARE lcur_set_form_title FROM ls_sql
  EXECUTE lcur_set_form_title INTO ls_title
  FREE lcur_set_form_title

  LET lo_window = ui.Window.getCurrent()
  CALL lo_window.setText(ls_title CLIPPED) 

  LET ls_img_path  = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
  LET ls_icon_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
  TRY 
    CALL lo_window.setImage(ls_icon_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not set logo icon !"
  END TRY   
    
  
END FUNCTION

FUNCTION sadzp240_util_set_form_style(p_lang)
DEFINE
  p_lang STRING
DEFINE
  ls_lang     STRING,
  ls_cfg_path STRING,
  ls_4st_path STRING

  LET ls_lang = p_lang
  
  LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ls_lang), "designer.4st")
  
  TRY 
    CALL ui.Interface.loadStyles(ls_4st_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not found 'designer.4st' !"
  END TRY   
  
END FUNCTION 

# Clone from adzp999_01_chk_routine_num
FUNCTION sadzp240_util_chk_routine_num(ps_patch_num,ps_pop)
   DEFINE ps_patch_num      STRING
   DEFINE ps_pop            BOOLEAN
   DEFINE ls_patch_info     DYNAMIC ARRAY OF STRING
   DEFINE ls_token          STRING   
   DEFINE lst_token         base.StringTokenizer            
   DEFINE ls_patch_code     LIKE type_t.chr3  #T100Patch包代碼(TSD,TPH,TIC...)
   DEFINE ls_patch_type     LIKE type_t.chr1  #T100Patch包類型(1-小包,2-專案包,3-例行包,T-測試區包)
   DEFINE ls_patch_time     LIKE type_t.num5  #T100Patch包年月份(1601,1705...)
   DEFINE ls_patch_num      LIKE type_t.num10 #T100Patch包流水號(000001~999999)
   DEFINE ls_patch_ver      LIKE type_t.chr5  #T100Patch包版號(1.0~x.x)
   DEFINE ls_patch_pre      LIKE type_t.chr50
   DEFINE ls_patch_num_pre  LIKE type_t.num10 #T100Patch包流水號(000001~999999)
   DEFINE li_cnt            LIKE type_t.num10
   DEFINE li_idx            LIKE type_t.num10
   
   #未啟用
   RETURN TRUE
   
   IF ps_patch_num.subString(1,1) <> "T" THEN
      DISPLAY "INFO:舊規則Patch包,不做管控!"
      RETURN TRUE
   END IF
   
   #開始解析資訊
   LET li_idx = 1
   LET lst_token  = base.StringTokenizer.create(ps_patch_num,"-")
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_patch_info[li_idx] = ls_token
      #2為類別碼
      IF li_idx = 2 THEN
         #不為3代表非例行性patch包, 不做檢查
         IF ls_token <> "3" THEN
            RETURN TRUE 
         END IF
      END IF
      LET li_idx = li_idx + 1
   END WHILE
   
    
   #開始組合資訊
   LET ls_patch_code = ls_patch_info[1] #T100Patch包代碼(TSD,TPH,TIC...)
   LET ls_patch_type = ls_patch_info[2] #T100Patch包類型(1-小包,2-專案包,3-例行包,T-測試區包)
   LET ls_patch_time = ls_patch_info[3] #T100Patch包年月份(1601,1705...)
   LET ls_patch_num  = ls_patch_info[4] #T100Patch包流水號(000001~999999)
   LET ls_patch_ver  = ls_patch_info[5] #T100Patch包版號(1.0~x.x)
   
   #檢查是否上過例行性Patch
   LET ls_patch_pre = "TSD-3-%",ls_patch_ver
   LET li_cnt = 0
   SELECT COUNT(*) INTO li_cnt 
     FROM dzyg_t 
    WHERE dzyg001 LIKE ls_patch_pre
   IF li_cnt = 0 THEN
      #無上過例行性patch, 不須檢查
      RETURN TRUE
   END IF
   
   #上一個編號
   LET ls_patch_num_pre = ls_patch_num - 1
   
   #組出上一包的代碼
   LET ls_patch_pre = ls_patch_code, #TSD
                      "-",
                      ls_patch_type, #3-例行包
                      "-",
                      "%",           #月份-未定
                      "-",
                      ls_patch_num_pre USING "&&&&&&", #流水號
                      "-",
                      ls_patch_ver   #版號
   
   #確認是否有前一包的資訊
   LET li_cnt = 0
   SELECT COUNT(*) INTO li_cnt 
     FROM dzyg_t 
    WHERE dzyg001 LIKE ls_patch_pre
    
   IF li_cnt > 0 THEN
      #有前一包
      RETURN TRUE
   ELSE
      #沒有前一包
      LET ls_patch_pre = ls_patch_code, #TSD
                         "-",
                         ls_patch_type, #3-例行包
                         "-",
                         "YYMM",        #月份-未定
                         "-",
                         ls_patch_num_pre USING "&&&&&&", #流水號
                         "-",
                         ls_patch_ver   #版號
      #20160726 begin
      {                   
      IF ps_pop THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-01013" #未定
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = ls_patch_pre
         CALL cl_err()
      ELSE
         DISPLAY "ERROR:請先匯入",ls_patch_pre,"!"
      END IF
      }
      #20160726 end

      #20160726 add
      DISPLAY cs_error_tag,":Please import ",ls_patch_pre," first !"
      
      RETURN FALSE
      
   END IF
   
END FUNCTION

FUNCTION sadzp240_util_gen_db_schema()
DEFINE
  ls_command  STRING,
  lb_success  BOOLEAN,
  ls_message  STRING 

  {
  LET ls_command = "r.s ds >/dev/null 2>&1 &"
  
  DISPLAY cs_command_tag,ls_command

  RUN ls_command WITHOUT WAITING
  }

  LET ls_command = "r.s ds"
  
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  CALL cl_cmdrun_openpipe("r.s",ls_command,TRUE) RETURNING lb_success,ls_message
  &endif  

END FUNCTION

#2016.09.12 begin
FUNCTION sadzp240_util_gen_multi_lang_file(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid    STRING,
  li_loop    INTEGER,
  lb_result  BOOLEAN,
  lo_multi_lang_tables DYNAMIC ARRAY OF T_MULTI_LANG_TABLES
DEFINE
  lb_return BOOLEAN
  
  LET ls_guid = p_guid

  LET lb_return = TRUE

  CALL sadzp240_util_get_multi_lang_table_list(ls_guid) RETURNING lo_multi_lang_tables

  FOR li_loop = 1 TO lo_multi_lang_tables.getLength()
    CALL sadzp240_util_call_gen_multi_lang(lo_multi_lang_tables[li_loop].mlt_TABLE_NAME) RETURNING lb_result
    IF NOT lb_result THEN LET lb_return = FALSE END IF
  END FOR 
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp240_util_get_multi_lang_table_list(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid     STRING,
  ls_sql      STRING,
  li_rec_cnt  INTEGER,
  lo_multi_lang_tables DYNAMIC ARRAY OF T_MULTI_LANG_TABLES
DEFINE
  lo_return DYNAMIC ARRAY OF T_MULTI_LANG_TABLES

  LET ls_guid = p_guid
  
  LET ls_sql = "SELECT EZ.DZEZ002, EA.DZEA003                          ",
               "  FROM DZEZ_T EZ                                       ",
               "  LEFT OUTER JOIN DZEA_T EA ON EA.DZEA001 = EZ.DZEZ002 ",
               " WHERE EA.DZEA004 = 'L'                                ",
               "   AND EZ.DZEZ001 = '",ls_guid,"'                      ",
               " ORDER BY EZ.DZEZ002                                   " 
                   
  PREPARE lpre_get_multi_lang_table_list FROM ls_sql
  DECLARE lcur_get_multi_lang_table_list CURSOR FOR lpre_get_multi_lang_table_list

  LET li_rec_cnt = 1
  
  OPEN lcur_get_multi_lang_table_list
  FOREACH lcur_get_multi_lang_table_list INTO lo_multi_lang_tables[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_multi_lang_table_list
  
  FREE lpre_get_multi_lang_table_list
  FREE lcur_get_multi_lang_table_list 

  CALL lo_multi_lang_tables.deleteElement(li_rec_cnt)
  
  LET lo_return = lo_multi_lang_tables
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp240_util_call_gen_multi_lang(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING  

  LET ls_table_name = p_table_name
  
  LET lb_success = TRUE
  
  #LET ls_command = "r.r adzp140 ",ls_table_name CLIPPED
  LET ls_command = "r.r adzp140 ",ls_table_name," >/dev/null 2>&1 &"
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  RUN ls_command WITHOUT WAITING
  #CALL cl_cmdrun_openpipe("adzp140",ls_command,TRUE) RETURNING lb_success,ls_message
  &endif

  RETURN lb_success
  
END FUNCTION
#2016.09.12 end

#2016.10.18 begin
FUNCTION sadzp240_util_update_dzyg002(p_patch_no)
DEFINE
  p_patch_no  STRING
DEFINE
  lv_patch_no  VARCHAR(100),
  lb_result    BOOLEAN

  LET lv_patch_no = p_patch_no.subString(1,p_patch_no.getLength()-1)

  LET lb_result = TRUE

  BEGIN WORK 

  TRY 
    UPDATE DZYG_T 
       SET DZYG002 = 'Y'
     WHERE DZYG001 = lv_patch_no  

    COMMIT WORK

  CATCH
    ROLLBACK WORK
    LET lb_result = FALSE
  END TRY 

  DISPLAY IIF(lb_result,cs_success_tag,cs_error_tag),"Update patch tag for table patch ",lv_patch_no," : ",IIF(lb_result,"SUCCESS","FAIL")
  
END FUNCTION
#2016.10.18 end
