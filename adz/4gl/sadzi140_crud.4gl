{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  20170214   Ernestliou 1.產出 tbl 檔改為判斷 DGENV來做決定是否產出客戶家的語言資料(除了zh_TW,zh_CN以外)
}

&include "../4gl/sadzi140_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi140_type.inc"

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

FUNCTION sadzi140_crud_insert_dzea_t(p_create_table)
DEFINE
  p_create_table T_DZEA_CREATE_TABLE
DEFINE  
  lo_create_table T_DZEA_CREATE_TABLE
DEFINE
  ls_replace_arg STRING,
  lb_result      BOOLEAN,
  ls_user        VARCHAR(100),
  ldt_datetime    DATETIME YEAR TO SECOND

  LET lo_create_table.* = p_create_table.*
  LET lb_result = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  TRY
    INSERT INTO DZEA_T(
                       DZEA001,DZEA002,DZEA003,DZEA004,DZEA005,
                       DZEA006,DZEA007,DZEA008,DZEA009,DZEA010,
                       DZEA011,DZEA012,DZEA013,DZEA014,DZEA015,
                       DZEA016,DZEA017,DZEA018,DZEA019,DZEA020,
                       DZEA021,
                       DZEACRTID,DZEACRTDT,DZEAMODID,DZEAMODDT
                      ) 
               VALUES (
                       lo_create_table.dct_table_name,  lo_create_table.dct_table_description, lo_create_table.dct_module_name, lo_create_table.dct_table_type,    lo_create_table.dct_is_multi_lang_table,
                       lo_create_table.dct_is_system_table,lo_create_table.dct_common_columns,    lo_create_table.dct_define_group,    lo_create_table.dct_up_level_table, lo_create_table.dct_table_space,
                       "Y",lo_create_table.dct_alm_construct_version,lo_create_table.dct_alm_sd_version,lo_create_table.dct_industry_type,lo_create_table.dct_dgenv,
                       lo_create_table.dct_orig_module_name,lo_create_table.dct_shipping_notice,lo_create_table.dct_orig_dgenv,"","",
                       "",
                       ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
    
  CATCH 
    LET lb_result = FALSE
  END TRY

  RETURN lb_result
  
END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzeb_t(p_t_dzeb_t)
DEFINE
  p_t_dzeb_t   T_DZEB_T
DEFINE 
  lo_t_dzeb_t  T_DZEB_T,
  ls_user      VARCHAR(100),
  ldt_datetime  DATETIME YEAR TO SECOND

  LET lo_t_dzeb_t.* = p_t_dzeb_t.*

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif

  TRY 
    INSERT INTO DZEB_T(
                        dzeb001,dzeb002,dzeb003,dzeb004,dzeb005,
                        dzeb006,dzeb007,dzeb008,dzeb012,dzeb021,
                        dzeb022,dzeb023,dzeb024,dzeb027,dzeb028,
                        dzeb029,dzeb030,dzeb031,
                        dzebcrtid,dzebcrtdt,dzebmodid,dzebmoddt
                      )
               VALUES (
                        lo_t_dzeb_t.dzeb001,lo_t_dzeb_t.dzeb002,lo_t_dzeb_t.dzeb003,lo_t_dzeb_t.dzeb004,lo_t_dzeb_t.dzeb005,
                        lo_t_dzeb_t.dzeb006,lo_t_dzeb_t.dzeb007,lo_t_dzeb_t.dzeb008,lo_t_dzeb_t.dzeb012,lo_t_dzeb_t.dzeb021,
                        lo_t_dzeb_t.dzeb022,lo_t_dzeb_t.dzeb023,lo_t_dzeb_t.dzeb024,lo_t_dzeb_t.dzeb027,lo_t_dzeb_t.dzeb028,
                        lo_t_dzeb_t.dzeb029,lo_t_dzeb_t.dzeb030,lo_t_dzeb_t.dzeb031,
                        ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
                       
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZEB_T                                 
         SET dzeb003   = lo_t_dzeb_t.dzeb003,
             dzeb004   = lo_t_dzeb_t.dzeb004,
             dzeb005   = lo_t_dzeb_t.dzeb005,
             dzeb006   = lo_t_dzeb_t.dzeb006,
             dzeb007   = lo_t_dzeb_t.dzeb007,
             dzeb008   = lo_t_dzeb_t.dzeb008,
             dzeb012   = lo_t_dzeb_t.dzeb012,
             dzeb021   = lo_t_dzeb_t.dzeb021,
             dzeb022   = lo_t_dzeb_t.dzeb022,
             dzeb023   = lo_t_dzeb_t.dzeb023,
             dzeb024   = lo_t_dzeb_t.dzeb024,
             dzeb027   = lo_t_dzeb_t.dzeb027,
             dzeb028   = lo_t_dzeb_t.dzeb028,
             dzeb029   = lo_t_dzeb_t.dzeb029,
             dzeb030   = lo_t_dzeb_t.dzeb030,
             dzeb031   = lo_t_dzeb_t.dzeb031,
             dzebmodid = ls_user,
             dzebmoddt = ldt_datetime
       WHERE dzeb001 = lo_t_dzeb_t.dzeb001
         AND dzeb002 = lo_t_dzeb_t.dzeb002
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update DZEB_T with column ",lo_t_dzeb_t.DZEB002," unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzec_t(p_t_dzec_t)
DEFINE
  p_t_dzec_t  T_DZEC_T
DEFINE 
  lo_t_dzec_t  T_DZEC_T,
  lo_str_buf   base.StringBuffer,
  ls_user      VARCHAR(100),
  ldt_datetime  DATETIME YEAR TO SECOND

  LET lo_t_dzec_t.* = p_t_dzec_t.*

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif

  #移除空格 begin
  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.clear()
  
  CALL lo_str_buf.append(lo_t_dzec_t.dzec004)
  CALL lo_str_buf.replace(" ","",0)
  LET lo_t_dzec_t.dzec004 = lo_str_buf.toString()
  #移除空格 end
  
  TRY 
    INSERT INTO DZEC_T(
                        dzec001,dzec002,dzec003,dzec004,dzec005,
                        dzec006,dzec007,dzec008,
                        dzeccrtid,dzeccrtdt,dzecmodid,dzecmoddt
                      )
               VALUES (
                        lo_t_dzec_t.dzec001,lo_t_dzec_t.dzec002,lo_t_dzec_t.dzec003,lo_t_dzec_t.dzec004,lo_t_dzec_t.dzec005,
                        lo_t_dzec_t.dzec006,lo_t_dzec_t.dzec007,lo_t_dzec_t.dzec008,
                        ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
                       
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZEC_T                                 
         SET dzec003  = lo_t_dzec_t.dzec003,
             dzec004  = lo_t_dzec_t.dzec004,
             dzec005  = lo_t_dzec_t.dzec005,
             dzec006  = lo_t_dzec_t.dzec006,
             dzec007  = lo_t_dzec_t.dzec007,
             dzec008  = lo_t_dzec_t.dzec008,
             dzecmodid = ls_user,
             dzecmoddt = ldt_datetime
       WHERE dzec001  = lo_t_dzec_t.dzec001
         AND dzec002  = lo_t_dzec_t.dzec002
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update DZEC_T with index ",lo_t_dzec_t.dzec002," unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzed_t(p_t_dzed_t)
DEFINE
  p_t_dzed_t  T_DZED_T
DEFINE 
  lo_t_dzed_t  T_DZED_T,
  lo_str_buf   base.StringBuffer,
  ls_user      VARCHAR(100),
  ldt_datetime DATETIME YEAR TO SECOND

  LET lo_t_dzed_t.* = p_t_dzed_t.*

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif

  #移除空格 begin
  LET lo_str_buf = base.StringBuffer.create()

  CALL lo_str_buf.clear()
  CALL lo_str_buf.append(lo_t_dzed_t.dzed004)
  CALL lo_str_buf.replace(" ","",0)
  LET lo_t_dzed_t.dzed004 = lo_str_buf.toString()

  CALL lo_str_buf.clear()
  CALL lo_str_buf.append(lo_t_dzed_t.dzed006)
  CALL lo_str_buf.replace(" ","",0)
  LET lo_t_dzed_t.dzed006 = lo_str_buf.toString()
  #移除空格 end
  
  TRY 
    INSERT INTO DZED_T(
                        dzed001,dzed002,dzed003,dzed004,dzed005,
                        dzed006,dzed007,dzed008,dzed009,dzed010,
                        dzedcrtid,dzedcrtdt,dzedmodid,dzedmoddt
                      )
               VALUES (
                        lo_t_dzed_t.dzed001,lo_t_dzed_t.dzed002,lo_t_dzed_t.dzed003,lo_t_dzed_t.dzed004,lo_t_dzed_t.dzed005,
                        lo_t_dzed_t.dzed006,lo_t_dzed_t.dzed007,lo_t_dzed_t.dzed008,lo_t_dzed_t.dzed009,lo_t_dzed_t.dzed010,
                        ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
                       
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZED_T                                 
         SET dzed003  = lo_t_dzed_t.dzed003,
             dzed004  = lo_t_dzed_t.dzed004,
             dzed005  = lo_t_dzed_t.dzed005,
             dzed006  = lo_t_dzed_t.dzed006,
             dzed007  = lo_t_dzed_t.dzed007,
             dzed008  = lo_t_dzed_t.dzed008,
             dzed009  = lo_t_dzed_t.dzed009,
             dzed010  = lo_t_dzed_t.dzed010,
             dzedmodid = ls_user,
             dzedmoddt = ldt_datetime
       WHERE dzed001  = lo_t_dzed_t.dzed001
         AND dzed002  = lo_t_dzed_t.dzed002
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update DZED_T with key ",lo_t_dzed_t.dzed002," unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzen_t(p_t_dzen_t)
DEFINE
  p_t_dzen_t  T_DZEN_T
DEFINE 
  lo_t_dzen_t   T_DZEN_T,
  ls_user       VARCHAR(100),
  ldt_datetime  DATETIME YEAR TO SECOND

  LET lo_t_dzen_t.* = p_t_dzen_t.*

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif

  TRY 
    INSERT INTO DZEN_T(
                        DZEN001,DZEN002,DZEN003,DZEN004,DZEN005,
                        DZEN006,DZEN007,DZEN008,DZEN009,DZEN010,
                        DZEN011,DZEN012,DZEN013,
                        DZENCRTID,DZENCRTDT,DZENMODID,DZENMODDT
                      )
               VALUES (
                        lo_t_dzen_t.dzen001,lo_t_dzen_t.dzen002,lo_t_dzen_t.dzen003,lo_t_dzen_t.dzen004,lo_t_dzen_t.dzen005,
                        lo_t_dzen_t.dzen006,lo_t_dzen_t.dzen007,lo_t_dzen_t.dzen008,lo_t_dzen_t.dzen009,lo_t_dzen_t.dzen010,
                        lo_t_dzen_t.dzen011,lo_t_dzen_t.dzen012,lo_t_dzen_t.dzen013,
                        ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
    
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZEN_T
         SET DZEN004  = lo_t_dzen_t.dzen004,
             DZEN005  = lo_t_dzen_t.dzen005,
             DZEN006  = lo_t_dzen_t.dzen006,
             DZEN007  = lo_t_dzen_t.dzen007,
             DZEN008  = lo_t_dzen_t.dzen008,
             DZEN009  = lo_t_dzen_t.dzen009,
             DZEN010  = lo_t_dzen_t.dzen010,
             DZEN011  = lo_t_dzen_t.dzen011,
             DZEN012  = lo_t_dzen_t.dzen012,
             DZEN013  = lo_t_dzen_t.dzen013,
             DZENMODID = ls_user,
             DZENMODDT = ldt_datetime
       WHERE DZEN001  = lo_t_dzen_t.dzen001
         AND DZEN002  = lo_t_dzen_t.dzen002
         AND DZEN003  = lo_t_dzen_t.dzen003
         
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update DZEN_T with schema ",lo_t_dzen_t.dzen002," unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

END FUNCTION

#從dzeb_t新增dzep_t
FUNCTION sadzi140_crud_insert_update_dzep_t(p_t_dzeb_t,p_common_fields,p_lang)
DEFINE
  p_t_dzeb_t      T_DZEB_T,
  p_common_fields DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(50),
  p_lang          STRING 
DEFINE 
  lo_t_dzeb_t        T_DZEB_T,
  lo_common_fields   DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(50),
  ls_lang            STRING, 
  lo_t_dzep_t        T_DZEP_T,
  li_index           INTEGER,
  ls_insert_sql      STRING,
  ls_upd_dzep012_sql STRING,
  ls_upd_dzep021_sql STRING,
  ls_upd_dzep023_sql STRING,
  li_loop            INTEGER,
  lb_fault           BOOLEAN,
  ls_dgenv           STRING,
  lo_str_buf         base.StringBuffer,
  lo_property        T_PROPERTY,
  lo_mapping_data    DYNAMIC ARRAY OF T_MAPPING_DATA

  LET lo_t_dzeb_t.* = p_t_dzeb_t.*
  LET lo_common_fields.* = p_common_fields.*
  LET ls_lang = p_lang
  LET lb_fault = FALSE

  LET ls_dgenv = FGL_GETENV("DGENV")

  CALL sadzi140_util_get_property(lo_t_dzeb_t.dzeb006,ls_lang) RETURNING lo_property.*
  #將共用欄位的查詢時開窗設定值塞入dzeb018, 再塞入 dzep018
  FOR li_index = 1 TO lo_common_fields.getLength()
    IF lo_common_fields[li_index,1] = lo_t_dzeb_t.dzeb022 THEN
      LET lo_t_dzep_t.dzep018 = lo_common_fields[li_index,3]
      EXIT FOR
    ELSE  
      LET lo_t_dzep_t.dzep018 = ""
    END IF 
  END FOR

  {
  #2015.04.15 begin
  #字串型態的資料, 存進dzep_t前先將單引號拿掉
  IF lo_t_dzeb_t.dzeb006 LIKE "C%" THEN 
    LET lo_str_buf = base.StringBuffer.create()
    CALL lo_str_buf.clear()
    CALL lo_str_buf.append(lo_t_dzeb_t.dzeb012)
    CALL lo_str_buf.replace("'","",0)
    LET lo_t_dzeb_t.dzeb012 = lo_str_buf.toString()
  END IF 
  #2015.04.15 end
  }
  
  CALL sadzi140_util_get_global_var_to_db_func_mapping_data() RETURNING lo_mapping_data
  #取得對應的全域變數名稱
  FOR li_loop = 1 TO lo_mapping_data.getLength()
    IF UPSHIFT(lo_t_dzeb_t.dzeb012) = lo_mapping_data[li_loop].md_DB_FUNCTION THEN
      LET lo_t_dzeb_t.dzeb012 = lo_mapping_data[li_loop].md_GLOBAL_VARIABLE 
      EXIT FOR 
    END IF 
  END FOR  
  
  LET lo_t_dzep_t.dzep009 = lo_property.D_WIDGET_WIDTH
  LET lo_t_dzep_t.dzep010 = lo_property.D_WIDGETS
  --LET lo_t_dzep_t.dzep015 = lo_property.D_PERCENT
  LET lo_t_dzep_t.dzep021 = lo_property.D_FORMAT
  LET lo_t_dzep_t.dzep023 = lo_property.D_WORD_CASE
  LET lo_t_dzep_t.dzep027 = lo_property.D_REPORT_WIDTH
  LET lo_t_dzep_t.dzep028 = lo_property.D_REPORT_DIGIT
  
  LET ls_insert_sql = "INSERT INTO DZEP_T (                                                            ",
                      "                     DZEP001,DZEP002,DZEP005,DZEP009,DZEP010,                   ",
                      "                     DZEP012,DZEP015,DZEP016,DZEP018,DZEP021,                   ",
                      "                     DZEP022,DZEP023,DZEP027,DZEP028,                           ",
                      "                     DZEPSTUS                                                   ",  
                      "                    )                                                           ",  
                      "            VALUES (                                                            ",
                      "                     '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"',         ", 
                      "                     '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"',         ", 
                      "                     '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb005),"',         ", 
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep009),"',         ", 
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep010),"',         ", 
                      "                     ?,                                                         ", 
                      "                     '",sadzi140_util_trim_str(NVL(lo_t_dzep_t.dzep015,"Y")),"',", 
                      "                     '",sadzi140_util_trim_str(NVL(lo_t_dzep_t.dzep016,"Y")),"',", 
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep018),"',         ",
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep021),"',         ",
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep022),"',         ",
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep023),"',         ",
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep027),"',         ",
                      "                     '",sadzi140_util_trim_str(lo_t_dzep_t.dzep028),"',         ",
                      "                     '",ls_dgenv.trim(),"'                                      ",
                      "                   )                                                            "

                      
  #更新預設值    
  -- 20160506
  LET ls_upd_dzep012_sql = "UPDATE DZEP_T                                                                                                   ",
                           "   SET DZEP012 = ?                                                                                              ",
                           " WHERE DZEP001 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"'                                              ", 
                           "   AND DZEP002 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"'                                              "
                           --"   AND NVL(TRIM(REPLACE(REPLACE(DZEP012,CHR(13),''),CHR(10),'')),'",cs_null_default,"') = '",cs_null_default,"' " -- 20160506 marked
                      
  #更新顯示格式        
  -- 20160506
  LET ls_upd_dzep021_sql = "UPDATE DZEP_T                                                                                                   ",
                           "   SET DZEP021 = ?                                                                                              ",
                           " WHERE DZEP001 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"'                                              ", 
                           "   AND DZEP002 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"'                                              "
                           --"   AND NVL(TRIM(REPLACE(REPLACE(DZEP021,CHR(13),''),CHR(10),'')),'",cs_null_default,"') = '",cs_null_default,"' " -- 20160506 marked
                           
  #更新欄位大小寫        
  LET ls_upd_dzep023_sql = "UPDATE DZEP_T                                                                                                   ",
                           "   SET DZEP023 = ?                                                                                              ",
                           " WHERE DZEP001 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"'                                              ", 
                           "   AND DZEP002 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"'                                              ",
                           "   AND NVL(TRIM(REPLACE(REPLACE(DZEP023,CHR(13),''),CHR(10),'')),'",cs_null_default,"') = '",cs_null_default,"' "
  {                    
  LET ls_update_sql = "UPDATE DZEP_T                                                               ",
                      "   SET DZEP009 = '",sadzi140_util_trim_str(lo_t_dzep_t.dzep009),"',         ",
                      "       DZEP010 = '",sadzi140_util_trim_str(lo_t_dzep_t.dzep010),"',         ",
                      "       DZEP015 = '",sadzi140_util_trim_str(NVL(lo_t_dzep_t.dzep015,"Y")),"',",
                      "       DZEP016 = '",sadzi140_util_trim_str(NVL(lo_t_dzep_t.dzep016,"Y")),"',",
                      "       DZEP018 = '",sadzi140_util_trim_str(lo_t_dzep_t.dzep018),"'          ",
                      " WHERE DZEP001 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"'          ", 
                      "   AND DZEP002 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"'          "
  }
  
  TRY
    PREPARE lpre_insert_dzep_t FROM ls_insert_sql
    EXECUTE lpre_insert_dzep_t USING lo_t_dzeb_t.dzeb012
  CATCH
    DISPLAY cs_warning_tag,"Insert DZEP_T with column ",lo_t_dzeb_t.dzeb002," unsuccess."
    #更新預設值        
    TRY    
      PREPARE lpre_update_dzep012 FROM ls_upd_dzep012_sql
      EXECUTE lpre_update_dzep012 USING lo_t_dzeb_t.dzeb012
    CATCH
      LET lb_fault = TRUE
      DISPLAY cs_warning_tag,"Update DZEP012 unsuccess."
    END TRY
    #更新顯示格式        
    TRY    
      PREPARE lpre_update_dzep021 FROM ls_upd_dzep021_sql
      EXECUTE lpre_update_dzep021 USING lo_t_dzep_t.dzep021
    CATCH
      LET lb_fault = TRUE
      DISPLAY cs_warning_tag,"Update DZEP021 unsuccess."
    END TRY
    #更新欄位大小寫        
    TRY    
      PREPARE lpre_update_dzep023 FROM ls_upd_dzep023_sql
      EXECUTE lpre_update_dzep023 USING lo_t_dzep_t.dzep023
    CATCH
      LET lb_fault = TRUE
      DISPLAY cs_warning_tag,"Update DZEP023 unsuccess."
    END TRY
    #更新有錯誤則顯示SQL
    IF lb_fault THEN 
      DISPLAY "[Insert SQL] ",ls_insert_sql
      DISPLAY "[Update SQL] ",ls_upd_dzep012_sql
    END IF 
  END TRY  

END FUNCTION

FUNCTION sadzi140_crud_clone_dzep_t(p_t_dzep_t)
DEFINE
  p_t_dzep_t T_DZEP_T
DEFINE 
  lo_t_dzep_t T_DZEP_T,
  ls_dgenv    VARCHAR(2)

  LET ls_dgenv = FGL_GETENV("DGENV")
  
  LET lo_t_dzep_t.* = p_t_dzep_t.*

  TRY
    INSERT INTO DZEP_T(
                        DZEP001,DZEP002,DZEP003,DZEP004,DZEP005,
                        DZEP006,DZEP007,DZEP008,DZEP009,DZEP010,
                        DZEP011,DZEP012,DZEP013,DZEP014,DZEP015,
                        DZEP016,DZEP017,DZEP018,DZEP019,DZEP020,
                        DZEP021,DZEP022,DZEP023,DZEP024,DZEP025,
                        DZEP026,DZEP027,DZEP028,
                        DZEPSTUS  
                      )
               VALUES (
                        lo_t_dzep_t.DZEP001,lo_t_dzep_t.DZEP002,lo_t_dzep_t.DZEP003,lo_t_dzep_t.DZEP004,lo_t_dzep_t.DZEP005,
                        lo_t_dzep_t.DZEP006,lo_t_dzep_t.DZEP007,lo_t_dzep_t.DZEP008,lo_t_dzep_t.DZEP009,lo_t_dzep_t.DZEP010,
                        lo_t_dzep_t.DZEP011,lo_t_dzep_t.DZEP012,lo_t_dzep_t.DZEP013,lo_t_dzep_t.DZEP014,lo_t_dzep_t.DZEP015,
                        lo_t_dzep_t.DZEP016,lo_t_dzep_t.DZEP017,lo_t_dzep_t.DZEP018,lo_t_dzep_t.DZEP019,lo_t_dzep_t.DZEP020,
                        lo_t_dzep_t.DZEP021,lo_t_dzep_t.DZEP022,lo_t_dzep_t.DZEP023,lo_t_dzep_t.DZEP024,lo_t_dzep_t.DZEP025,
                        lo_t_dzep_t.DZEP026,lo_t_dzep_t.DZEP027,lo_t_dzep_t.DZEP028,
                        ls_dgenv
                      )
  CATCH
    TRY
      UPDATE DZEP_T
         SET DZEP003 = LO_T_DZEP_T.DZEP003,
             DZEP004 = LO_T_DZEP_T.DZEP004,
             DZEP005 = LO_T_DZEP_T.DZEP005,
             DZEP006 = LO_T_DZEP_T.DZEP006,
             DZEP007 = LO_T_DZEP_T.DZEP007,
             DZEP008 = LO_T_DZEP_T.DZEP008,
             DZEP009 = LO_T_DZEP_T.DZEP009,
             DZEP010 = LO_T_DZEP_T.DZEP010,
             DZEP011 = LO_T_DZEP_T.DZEP011,
             DZEP012 = LO_T_DZEP_T.DZEP012,
             DZEP013 = LO_T_DZEP_T.DZEP013,
             DZEP014 = LO_T_DZEP_T.DZEP014,
             DZEP015 = LO_T_DZEP_T.DZEP015,
             DZEP016 = LO_T_DZEP_T.DZEP016,
             DZEP017 = LO_T_DZEP_T.DZEP017,
             DZEP018 = LO_T_DZEP_T.DZEP018,
             DZEP019 = LO_T_DZEP_T.DZEP019,
             DZEP020 = LO_T_DZEP_T.DZEP020,
             DZEP021 = LO_T_DZEP_T.DZEP021,
             DZEP022 = LO_T_DZEP_T.DZEP022,
             DZEP023 = LO_T_DZEP_T.DZEP023,
             DZEP024 = LO_T_DZEP_T.DZEP024,
             DZEP025 = LO_T_DZEP_T.DZEP025,
             DZEP026 = LO_T_DZEP_T.DZEP026, 
             DZEP027 = LO_T_DZEP_T.DZEP027,
             DZEP028 = LO_T_DZEP_T.DZEP028 
       WHERE DZEP001 = LO_T_DZEP_T.DZEP001
         AND DZEP002 = LO_T_DZEP_T.DZEP002
    CATCH
      DISPLAY "INSERT or Update dzep error"
    END TRY     
  END TRY   

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzef_t(p_t_dzeb_t,p_common_fields)
DEFINE
  p_t_dzeb_t T_DZEB_T,
  p_common_fields DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(50)
DEFINE 
  lo_t_dzeb_t   T_DZEB_T,
  lo_common_fields DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(50),
  ls_insert_sql STRING,
  ls_update_sql STRING,
  ls_pre_name   STRING,
  ls_dgenv      STRING,
  li_index      INTEGER

  LET lo_t_dzeb_t.* = p_t_dzeb_t.*
  LET lo_common_fields.* = p_common_fields.*

  LET ls_dgenv = FGL_GETENV("DGENV")
  
  #取得表格的前置名稱
  CALL sadzi140_util_get_table_pre_name(lo_t_dzeb_t.dzeb001) RETURNING ls_pre_name

  #將共用欄位的查設定值塞入
  FOR li_index = 1 TO lo_common_fields.getLength()
    IF lo_common_fields[li_index,1] = lo_t_dzeb_t.dzeb022 THEN
    
      LET ls_insert_sql = "INSERT INTO DZEF_T (                                                             ",
                          "                     DZEF001,DZEF002,DZEF003,DZEF006,DZEF007,                    ",
                          "                     DZEF008,DZEF009,                                            ",
                          "                     DZEFSTUS                                                    ",
                          "                    )                                                            ",  
                          "            VALUES (                                                             ",
                          "                     '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"',          ", 
                          "                     '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"',          ", 
                          "                     REPLACE('",sadzi140_util_trim_str(lo_common_fields[li_index,4]),"','*','",ls_pre_name,"'),", 
                          "                     '",sadzi140_util_trim_str(lo_common_fields[li_index,5]),"', ", 
                          "                     '",sadzi140_util_trim_str(lo_common_fields[li_index,6]),"', ", 
                          "                     '",sadzi140_util_trim_str(lo_common_fields[li_index,8]),"', ", 
                          "                     '",sadzi140_util_trim_str(lo_common_fields[li_index,7]),"', ",
                          "                     '",ls_dgenv.trim(),"'                                       ",
                          "                   )                                                             "

      {                    
      LET ls_update_sql = "UPDATE DZEF_T                                                              ",
                          "   SET DZEF003 = REPLACE('",sadzi140_util_trim_str(lo_common_fields[li_index,4]),"','*','",ls_pre_name,"'),",
                          "       DZEF006 = '",sadzi140_util_trim_str(lo_common_fields[li_index,5]),"',",
                          "       DZEF007 = '",sadzi140_util_trim_str(lo_common_fields[li_index,6]),"',",
                          "       DZEF008 = '",sadzi140_util_trim_str(lo_common_fields[li_index,8]),"',",
                          "       DZEF009 = '",sadzi140_util_trim_str(lo_common_fields[li_index,7]),"' ",
                          " WHERE DZEF001 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb001),"'         ", 
                          "   AND DZEF002 = '",sadzi140_util_trim_str(lo_t_dzeb_t.dzeb002),"'         "
      }                   
      TRY
        PREPARE lpre_insert_dzef_t FROM ls_insert_sql
        EXECUTE lpre_insert_dzef_t
      CATCH
        #DISPLAY cs_warning_tag,"Insert DZEF_T unsuccess."
        {
        TRY    
          PREPARE lpre_update_dzef_t FROM ls_update_sql
          EXECUTE lpre_update_dzef_t
        CATCH
          DISPLAY cs_warning_tag,"Insert or Update DZEF_T unsuccess."
          DISPLAY "[Insert SQL] ",ls_insert_sql
          DISPLAY "[Update SQL] ",ls_update_sql
        END TRY
        }
      END TRY  
      EXIT FOR
    END IF 
  END FOR

END FUNCTION

FUNCTION sadzi140_crud_clone_dzef_t(p_t_DZEF_t)
DEFINE
  p_t_dzef_t T_DZEF_T
DEFINE 
  lo_t_dzef_t T_DZEF_T,
  ls_dgenv    VARCHAR(2)

  LET lo_t_dzef_t.* = p_t_dzef_t.*

  LET ls_dgenv = FGL_GETENV("DGENV")
  
  TRY
    INSERT INTO DZEF_T(
                        DZEF001,DZEF002,DZEF003,DZEF004,DZEF005,
                        DZEF006,DZEF007,DZEF008,DZEF009,DZEF010,
                        DZEFSTUS
                      )
               VALUES (
                        lo_t_DZEF_t.DZEF001,lo_t_DZEF_t.DZEF002,lo_t_DZEF_t.DZEF003,lo_t_DZEF_t.DZEF004,lo_t_DZEF_t.DZEF005,
                        lo_t_DZEF_t.DZEF006,lo_t_DZEF_t.DZEF007,lo_t_DZEF_t.DZEF008,lo_t_DZEF_t.DZEF009,lo_t_DZEF_t.DZEF010,
                        ls_dgenv
                      )
  CATCH
    TRY
      UPDATE DZEF_T
         SET DZEF003 = LO_T_DZEF_T.DZEF003,
             DZEF004 = LO_T_DZEF_T.DZEF004,
             DZEF005 = LO_T_DZEF_T.DZEF005,
             DZEF006 = LO_T_DZEF_T.DZEF006,
             DZEF007 = LO_T_DZEF_T.DZEF007,
             DZEF008 = LO_T_DZEF_T.DZEF008,
             DZEF009 = LO_T_DZEF_T.DZEF009,
             DZEF010 = LO_T_DZEF_T.DZEF010
       WHERE DZEF001 = LO_T_DZEF_T.DZEF001
         AND DZEF002 = LO_T_DZEF_T.DZEF002
    CATCH
      DISPLAY "INSERT or Update DZEF error"
    END TRY     
  END TRY   

END FUNCTION

FUNCTION sadzi140_crud_insert_update_gzcc_t(p_dzeb_t)
DEFINE
  p_dzeb_t  T_DZEB_T
DEFINE 
  lo_dzeb_t      T_DZEB_T,
  lo_gzcc_t      DYNAMIC ARRAY OF T_GZCC_T,
  li_loop        INTEGER,
  ls_column_name STRING

  LET lo_dzeb_t.* = p_dzeb_t.* 

  LET ls_column_name = lo_dzeb_t.dzeb002
  LET ls_column_name = ls_column_name.toLowerCase()

  IF (ls_column_name.getIndexOf('stus',1) > 0) THEN
    IF NOT (sadzi140_crud_get_status_code_data_exists(lo_dzeb_t.dzeb001)) THEN

      #若不存在, 則由 gzcb_t 抓取對應的代碼清單新增
      CALL sadzi140_crud_get_status_list(lo_dzeb_t.dzeb001) RETURNING lo_gzcc_t

      FOR li_loop = 1 TO lo_gzcc_t.getLength() 
        TRY 
          #只新增不更新
          INSERT INTO GZCC_T(
                              GZCC001, GZCC002, GZCC003, GZCC004, GZCC005,
                              GZCC006, GZCCSTUS
                            )
                     VALUES (
                              lo_gzcc_t[li_loop].gzcc001, lo_gzcc_t[li_loop].gzcc002, lo_gzcc_t[li_loop].gzcc003, lo_gzcc_t[li_loop].gzcc004, lo_gzcc_t[li_loop].gzcc005,
                              lo_gzcc_t[li_loop].gzcc006, lo_gzcc_t[li_loop].gzccstus                                
                            )
                             
        CATCH
          #DISPLAY cs_warning_tag,"Insert GZCC_T unsuccess."
        END TRY
      END FOR
    END IF  
  END IF  

END FUNCTION

#檢核狀態碼表格資料是否存在
FUNCTION sadzi140_crud_get_status_code_data_exists(p_table)
DEFINE
  p_table  STRING
DEFINE
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_table_name STRING

  LET ls_table_name = p_table

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1) REC_CNT                 ", 
               "  FROM GZCC_T CC                        ", 
               " WHERE CC.GZCC001 = '",ls_table_name,"' " 

  PREPARE lpre_get_status_code_count FROM ls_sql
  DECLARE lcur_get_status_code_count CURSOR FOR lpre_get_status_code_count
  OPEN lcur_get_status_code_count
  FETCH lcur_get_status_code_count INTO li_rec_count
  CLOSE lcur_get_status_code_count
  FREE lcur_get_status_code_count
  FREE lpre_get_status_code_count

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_crud_clone_gzcc_t(p_t_gzcc_t)
DEFINE
  p_t_gzcc_t T_GZCC_T
DEFINE 
  lo_t_gzcc_t T_GZCC_T

  LET lo_t_gzcc_t.* = p_t_gzcc_t.*

  TRY
    INSERT INTO GZCC_T(
                        GZCC001,GZCC002,GZCC003,GZCC004,GZCC005,
                        GZCC006,GZCCSTUS
                      )
               VALUES (
                        lo_t_gzcc_t.GZCC001,lo_t_gzcc_t.GZCC002,lo_t_gzcc_t.GZCC003,lo_t_gzcc_t.GZCC004,lo_t_gzcc_t.GZCC005,
                        lo_t_gzcc_t.GZCC006,lo_t_gzcc_t.GZCCSTUS
                      )
  CATCH
    TRY 
      UPDATE GZCC_T
         SET GZCC002  = lo_t_gzcc_t.GZCC002, 
             GZCC003  = lo_t_gzcc_t.GZCC003, 
             GZCC005  = lo_t_gzcc_t.GZCC005, 
             GZCC006  = lo_t_gzcc_t.GZCC006, 
             GZCCSTUS = lo_t_gzcc_t.GZCCSTUS
       WHERE GZCC001  = lo_t_gzcc_t.GZCC001 
         AND GZCC004  = lo_t_gzcc_t.GZCC004
    CATCH
      DISPLAY "INSERT or Update GZCC_T error"
    END TRY    
  END TRY   

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzer_t(p_t_dzer_t)
DEFINE
  p_t_dzer_t T_DZER_T
DEFINE 
  lo_t_dzer_t T_DZER_T,
  ls_dgenv    VARCHAR(2)

  LET lo_t_dzer_t.* = p_t_dzer_t.*

  LET ls_dgenv = FGL_GETENV("DGENV")
  
  TRY 
    INSERT INTO DZER_T(
                        DZER001,DZER002,DZER003,DZER004,DZER005,
                        DZER006,DZER007,DZER008,
                        DZERSTUS
                      )
               VALUES (
                        lo_t_dzer_t.DZER001,lo_t_dzer_t.DZER002,lo_t_dzer_t.DZER003,lo_t_dzer_t.DZER004,lo_t_dzer_t.DZER005,
                        lo_t_dzer_t.DZER006,lo_t_dzer_t.DZER007,lo_t_dzer_t.DZER008,
                        ls_dgenv
                      )
  CATCH 
    DISPLAY "INSERT or Update DZER_T error"
  END TRY   

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzeq_t(p_t_dzeq_t)
DEFINE
  p_t_dzeq_t T_DZEQ_T
DEFINE 
  lo_t_dzeq_t T_DZEQ_T,
  ls_dgenv    VARCHAR(2)

  LET lo_t_dzeq_t.* = p_t_dzeq_t.*

  LET ls_dgenv = FGL_GETENV("DGENV")

  TRY
    INSERT INTO DZEQ_T(
                        dzeq001,dzeq002,dzeq003,dzeq004,dzeq005,
                        dzeq006,dzeq007,dzeq008,dzeq009,
                        dzeqstus
                      )
               VALUES (
                        lo_t_dzeq_t.dzeq001,lo_t_dzeq_t.dzeq002,lo_t_dzeq_t.dzeq003,lo_t_dzeq_t.dzeq004,lo_t_dzeq_t.dzeq005,
                        lo_t_dzeq_t.dzeq006,lo_t_dzeq_t.dzeq007,lo_t_dzeq_t.dzeq008,lo_t_dzeq_t.dzeq009,
                        ls_dgenv
                      )
  CATCH
    DISPLAY "INSERT or Update DZEQ_T error"
  END TRY   

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzhh_t(p_t_dzhh_t)
DEFINE
  p_t_dzhh_t  T_DZHH_T
DEFINE 
  lo_t_dzhh_t   T_DZHH_T,
  ls_user       VARCHAR(100),
  ldt_datetime  DATETIME YEAR TO SECOND

  LET lo_t_dzhh_t.* = p_t_dzhh_t.*

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif

  TRY 
    INSERT INTO DZHH_T(
                        dzhh001,dzhh002,dzhh003,dzhh004,dzhh005,
                        dzhhcrtid,dzhhcrtdt,dzhhmodid,dzhhmoddt
                      )
               VALUES (
                        lo_t_dzhh_t.dzhh001,lo_t_dzhh_t.dzhh002,lo_t_dzhh_t.dzhh003,lo_t_dzhh_t.dzhh004,lo_t_dzhh_t.dzhh005,
                        ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
                       
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZHH_T                                 
         SET dzhh003   = lo_t_dzhh_t.dzhh003,
             dzhh004   = lo_t_dzhh_t.dzhh004,
             dzhh005   = lo_t_dzhh_t.dzhh005,
             dzhhmodid = ls_user,
             dzhhmoddt = ldt_datetime
       WHERE dzhh001   = lo_t_dzhh_t.dzhh001
         AND dzhh002   = lo_t_dzhh_t.dzhh002
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update DZHH_T unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

END FUNCTION

FUNCTION sadzi140_crud_get_status_list(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name STRING,
  lo_gzcc_t     DYNAMIC ARRAY OF T_GZCC_T
DEFINE  
  ls_sql      STRING,
  li_rec_cnt  INTEGER,
  lo_return   DYNAMIC ARRAY OF T_GZCC_T

  LET ls_table_name = p_table_name

  LET ls_sql = "SELECT EB.DZEB001                     GZCC001,                                 ",
               "       EB.DZEB002                     GZCC002,                                 ",
               "       DECODE(EA.DZEA004,'B',17,'P',17,'M',50,'H',13,'T',13,NULL)   GZCC003,   ",
               "       CB.GZCB002                     GZCC004,                                 ",
               "       's'                            GZCC005,                                 ",
               "       ROWNUM                         GZCC006,                                 ",
               {                                                                               
               "       'TIPTOP'                       GZCCMODU,                                ",
               "       SYSDATE                        GZCCDATE,                                ",
               "       'TIPTOP'                       GZCCORIU,                                ",
               "       ''                             GZCCORID,                                ",
               "       'TIPTOP'                       GZCCUSER,                                ",
               "       ''                             GZCCDEPT,                                ",
               "       SYSDATE                        GZCCBUID,                                ",
               }
               "       DECODE(EA.DZEA004,'B','Y','P','Y','M','Y','H','Y','T','Y','N') GZCCSTUS ",
               "  FROM DZEB_T EB,DZEA_T EA,                                                    ",
               "       GZCB_T CB                                                               ",
               " WHERE 1=1                                                                     ",
               "   AND EA.DZEA001 = '",ls_table_name.toLowercase(),"'                          ",
               "   AND EA.DZEA001 = EB.DZEB001                                                 ",
               "   AND EB.DZEB022 = 'cdfStatus'                                                ",
               "   AND CB.GZCB001 = DECODE(EA.DZEA004,'B',17,'P',17,'M',50,'H',13,'T',13,NULL) ",
               "   AND CB.GZCB003 = 'Y'                                                        ", 
               " ORDER BY EB.DZEB001,CB.GZCB002                                                "

  PREPARE lpre_get_status_list FROM ls_sql
  DECLARE lcur_get_status_list CURSOR FOR lpre_get_status_list

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_status_list
  FOREACH lcur_get_status_list INTO lo_gzcc_t[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_status_list
  IF li_rec_cnt > 1 THEN
    CALL lo_gzcc_t.deleteElement(li_rec_cnt)
  END IF  
    
  FREE lpre_get_status_list
  FREE lcur_get_status_list  

  LET lo_return.* = lo_gzcc_t.*
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzeal_t(p_create_table,p_lang)
DEFINE
  p_create_table T_DZEA_CREATE_TABLE,
  p_lang         STRING 
DEFINE
  lo_create_table T_DZEA_CREATE_TABLE,
  ls_lang         STRING, 
  ls_orig_lang    STRING, 
  ls_insert_sql   STRING,
  ls_update_sql   STRING,
  ls_lang_content STRING,
  li_loop         INTEGER,
  lo_lang_arr     DYNAMIC ARRAY OF T_LANGUAGE_TYPE

  LET lo_create_table.* = p_create_table.*
  LET ls_lang = p_lang
  LET ls_orig_lang = p_lang
    
  LET ls_lang_content = lo_create_table.dct_table_description

  &ifndef DEBUG
  CALL sadzi140_crud_get_static_lang_list() RETURNING lo_lang_arr

  FOR li_loop = 1 TO lo_lang_arr.getLength()
    LET ls_lang = lo_lang_arr[li_loop]
    IF ls_lang <> ls_orig_lang THEN 
      TRY 
        CALL cl_trans_code_tw_cn(ls_lang,lo_create_table.dct_table_description) RETURNING ls_lang_content
      CATCH
        DISPLAY cs_error_tag,"Translate language data '",ls_lang,"' error."
        LET ls_lang_content = lo_create_table.dct_table_description
      END TRY
    ELSE   
      LET ls_lang_content = lo_create_table.dct_table_description
    END IF     
  &endif
    LET ls_insert_sql = "INSERT INTO DZEAL_T (DZEAL001,DZEAL002,DZEAL003)                                             ",  
                        "            VALUES ('",lo_create_table.dct_table_name,"','",ls_lang,"','",ls_lang_content,"')"
  
    LET ls_update_sql = "UPDATE DZEAL_T                                        ",
                        "   SET DZEAL003 = '",ls_lang_content,"'               ",
                        " WHERE DZEAL001 = '",lo_create_table.dct_table_name,"'", 
                        "   AND DZEAL002 = '",ls_lang,"'                       "
                       
    TRY
      PREPARE lpre_insert_dzeal_t FROM ls_insert_sql
      EXECUTE lpre_insert_dzeal_t
    CATCH
      DISPLAY cs_warning_tag,"Insert DZEAL_T with table ",lo_create_table.dct_table_name," unsuccess."
      TRY    
        PREPARE lpre_update_dzeal_t FROM ls_update_sql
        EXECUTE lpre_update_dzeal_t
      CATCH
        DISPLAY cs_warning_tag,"Insert or Update DZEAL_T with table ",lo_create_table.dct_table_name," unsuccess."
        DISPLAY "[Insert SQL] ",ls_insert_sql
        DISPLAY "[Update SQL] ",ls_update_sql
      END TRY
    END TRY
    
  &ifndef DEBUG
  END FOR    
  &endif

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzebl_t(p_t_dzeb_t,p_lang)
DEFINE
  p_t_dzeb_t T_DZEB_T,
  p_lang     STRING  
DEFINE 
  lo_t_dzeb_t     T_DZEB_T,
  ls_lang         STRING,  
  ls_orig_lang    STRING, 
  ls_insert_sql   STRING,
  ls_update_sql   STRING,
  ls_lang_content STRING,
  ls_lang_memo    STRING,
  li_loop         INTEGER,
  lo_lang_arr     DYNAMIC ARRAY OF T_LANGUAGE_TYPE

  LET lo_t_dzeb_t.* = p_t_dzeb_t.*
  LET ls_lang = p_lang
  LET ls_orig_lang = p_lang

  LET ls_lang_content = lo_t_dzeb_t.DZEB003
  LET ls_lang_memo    = lo_t_dzeb_t.DZEB024

  #如果多語系沒有修改就不用更新
  IF lo_t_dzeb_t.lang_modified <> cs_lang_modified THEN RETURN END IF
  
  &ifndef DEBUG
  CALL sadzi140_crud_get_static_lang_list() RETURNING lo_lang_arr

  FOR li_loop = 1 TO lo_lang_arr.getLength()
    LET ls_lang = lo_lang_arr[li_loop]
    IF ls_lang <> ls_orig_lang THEN 
      TRY 
        CALL cl_trans_code_tw_cn(ls_lang,lo_t_dzeb_t.DZEB003) RETURNING ls_lang_content
        CALL cl_trans_code_tw_cn(ls_lang,lo_t_dzeb_t.DZEB024) RETURNING ls_lang_memo
      CATCH
        DISPLAY cs_error_tag,"Translate language data '",ls_lang,"' error."
        LET ls_lang_content = lo_t_dzeb_t.DZEB003
        LET ls_lang_memo    = lo_t_dzeb_t.DZEB024
      END TRY
    ELSE  
      LET ls_lang_content = lo_t_dzeb_t.DZEB003
      LET ls_lang_memo    = lo_t_dzeb_t.DZEB024
    END IF     
  &endif
    
    LET ls_insert_sql = "INSERT INTO DZEBL_T (DZEBL001,DZEBL002,DZEBL003,DZEBL004,DZEBL000)                                                                ",  
                        "            VALUES ('",lo_t_dzeb_t.DZEB002 ,"','",ls_lang,"','",ls_lang_content,"','",ls_lang_memo,"','",lo_t_dzeb_t.DZEB001 ,"') "
                        
    LET ls_update_sql = "UPDATE DZEBL_T                              ",
                        "   SET DZEBL003 = '",ls_lang_content,"',    ",
                        "       DZEBL004 = '",ls_lang_memo,"',       ",
                        "       DZEBl000 = '",lo_t_dzeb_t.DZEB001,"' ", 
                        " WHERE DZEBL001 = '",lo_t_dzeb_t.DZEB002,"' ", 
                        "   AND DZEBL002 = '",ls_lang,"'             "
                       
    TRY
      PREPARE lpre_insert_dzebl_t FROM ls_insert_sql
      EXECUTE lpre_insert_dzebl_t
    CATCH
      DISPLAY cs_warning_tag,"Insert DZEBL_T with column ",lo_t_dzeb_t.DZEB002," unsuccess."

      #20160705 如果語系相同才更新多語言的內容
      IF ls_lang = ls_orig_lang THEN
        TRY    
          PREPARE lpre_update_dzebl_t FROM ls_update_sql
          EXECUTE lpre_update_dzebl_t
        CATCH
          DISPLAY cs_warning_tag,"Insert or Update DZEBL_T with column ",lo_t_dzeb_t.DZEB002," unsuccess."
          DISPLAY "[Insert SQL] ",ls_insert_sql
          DISPLAY "[Update SQL] ",ls_update_sql
        END TRY
      END IF  
      
    END TRY  

  &ifndef DEBUG
  END FOR  
  &endif

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzeu_t(p_table_type)
DEFINE
  p_table_type  T_TABLE_TYPE 
DEFINE
  lo_table_type  T_TABLE_TYPE, 
  ls_insert_sql  STRING,
  ls_update_sql  STRING

  LET lo_table_type.* = p_table_type.*
    
  LET ls_insert_sql = "INSERT INTO DZEU_T (DZEU001,DZEU002,DZEU003,DZEU004,DZEU005) ",  
                      "            VALUES (                                         ",
                      "                    '",lo_table_type.DZEU001,"',             ",
                      "                    '",lo_table_type.DZEU002,"',             ",
                      "                    '",lo_table_type.DZEU003,"',             ",
                      "                    '",lo_table_type.DZEU004,"',             ",
                      "                     ",lo_table_type.DZEU005,"               ",
                      "                    )                                        "

  LET ls_update_sql = "UPDATE DZEU_T                                ",
                      "   SET DZEU003 = '",lo_table_type.DZEU003,"',",
                      "       DZEU004 = '",lo_table_type.DZEU004,"',",
                      "       DZEU005 =  ",lo_table_type.DZEU005,"  ",
                      " WHERE DZEU001 = '",lo_table_type.DZEU001,"' ", 
                      "   AND DZEU002 = '",lo_table_type.DZEU002,"' "
                     
  TRY
    PREPARE lpre_insert_dzeu_t FROM ls_insert_sql
    EXECUTE lpre_insert_dzeu_t
  CATCH
    TRY    
      PREPARE lpre_update_dzeu_t FROM ls_update_sql
      EXECUTE lpre_update_dzeu_t
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update dzeu_T with table ",lo_table_type.DZEU001," unsuccess."
      DISPLAY "[Insert SQL] ",ls_insert_sql
      DISPLAY "[Update SQL] ",ls_update_sql
    END TRY
    
  END TRY  

END FUNCTION

FUNCTION sadzi140_crud_insert_update_dzey_t(p_dzey_t)
DEFINE
  p_dzey_t  T_DZEY_T 
DEFINE
  lo_dzey_t      T_DZEY_T, 
  ldt_today      DATETIME YEAR TO DAY,
  ls_insert_sql  STRING,
  ls_update_sql  STRING

  LET lo_dzey_t.* = p_dzey_t.*

  LET ldt_today = CURRENT YEAR TO DAY
  LET lo_dzey_t.DZEY001 = ldt_today
  
  LET ls_insert_sql = "INSERT INTO DZEY_T (DZEY001,DZEY002)          ",  
                      "            VALUES (                          ",
                      "                     ?,                       ",
                      "                     '",lo_dzey_t.DZEY002,"'  ",
                      "                   )                          "

  {                       
  LET ls_update_sql = "UPDATE DZEY_T                            ",
                      "   SET DZEY001 = '",lo_dzey_t.DZEY001,"',",
                      "       DZEY002 = '",lo_dzey_t.DZEY002,"' ",
                      " WHERE DZEY001 = '",lo_dzey_t.DZEY001,"' ", 
                      "   AND DZEY002 = '",lo_dzey_t.DZEY002,"' "
  }
  
  TRY
    PREPARE lpre_insert_dzey_t FROM ls_insert_sql
    EXECUTE lpre_insert_dzey_t USING lo_dzey_t.DZEY001
  CATCH
    DISPLAY cs_warning_tag,"Insert DZEY_T with table ",lo_dzey_t.DZEY002," unsuccess."
    {
    TRY    
      PREPARE lpre_update_dzey_t FROM ls_update_sql
      EXECUTE lpre_update_dzey_t
    CATCH
      DISPLAY cs_warning_tag,"Insert or Update DZEY_T with table ",lo_dzey_t.DZEY002," unsuccess."
      DISPLAY "[Insert SQL] ",ls_insert_sql
      DISPLAY "[Update SQL] ",ls_update_sql
    END TRY
    }
  END TRY  

END FUNCTION

FUNCTION sadzi140_crud_get_static_lang_list()
DEFINE
  lo_lang_arr DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  lo_return DYNAMIC ARRAY OF T_LANGUAGE_TYPE,
  ls_sql    STRING, #20170214
  li_count  INTEGER, #20170214
  ls_DGENV  STRING #20170214

  #設定靜態區域別
  LET lo_lang_arr[1] = cs_lang_zh_cn
  LET lo_lang_arr[2] = cs_lang_zh_tw

  #20170214 begin
  LET ls_DGENV = FGL_GETENV("DGENV")
  
  #如果是在客制環境就抓除了簡繁中文外的其他語言資料
  IF ls_DGENV = cs_dgenv_customize THEN
  
    LET ls_sql = "SELECT GZZY001                                                  ", 
                 "  FROM GZZY_T                                                   ", 
                 " WHERE GZZY001 NOT IN ('",cs_lang_zh_cn,"','",cs_lang_zh_tw,"') ",
                 " ORDER BY GZZY001                                               "
                 
    PREPARE lpre_get_static_lang_list FROM ls_sql
    DECLARE lcur_get_static_lang_list CURSOR FOR lpre_get_static_lang_list

    LET li_count = 3
    
    OPEN lcur_get_static_lang_list
    FOREACH lcur_get_static_lang_list INTO lo_lang_arr[li_count]  
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF

      LET li_count = li_count + 1

    END FOREACH
    CLOSE lcur_get_static_lang_list

    FREE lcur_get_static_lang_list
    FREE lpre_get_static_lang_list
    
    CALL lo_lang_arr.deleteElement(li_count)
    
  END IF
  #20170214 end
  
  LET lo_return = lo_lang_arr

  RETURN lo_return

END FUNCTION 