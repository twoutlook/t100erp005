&include "../4gl/sadzi180_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds
#_crud 進行實際資料的新增或是修改
#&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi180_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi180_type.inc"
GLOBALS "../../cfg/top_global.inc"


################################################################################
# Descriptions...: 新增設計資料內容或者更新異動者記錄
# Memo...........: 
# Usage..........: CALL sadzi180_crud_insert_dzia_t (p_dzia_t)
#                :      RETURNING lb_result, ls_message
# Input parameter: p_dzib_t  中介表格明細檔
#                :
# Return code....: lb_result  執行結果, true : 執行成功, false 執行錯誤
#                : ls_message 訊息記錄
# Date & Author..: 
# Modify.........: 20170116 by CircleLai
################################################################################
FUNCTION sadzi180_crud_insert_dzia_t(p_dzia_t)
DEFINE
  p_dzia_t T_DZIA_T
DEFINE  
  lo_dzia_t T_DZIA_T
DEFINE
  ls_replace_arg STRING,
  lb_success     BOOLEAN,
  ls_user        VARCHAR(100),
  ldt_datetime   DATETIME YEAR TO SECOND
DEFINE 
  ls_message      STRING

  LET lo_dzia_t.* = p_dzia_t.*
  LET lb_success = TRUE

  LET ls_user = g_user #FGL_GETENV("USERNUMBER") #20170116 modify by circlelai 
  LET ldt_datetime = CURRENT YEAR TO SECOND
  LET ls_message = ""
  
  TRY
    INSERT INTO DZIA_T(
                       DZIA001,DZIA002,DZIA003,DZIA004,DZIA005,
                       DZIA006,DZIA007,DZIA008,DZIA009,DZIA010,
                       DZIA011,DZIA012,DZIA013,DZIA014,DZIA015,
                       DZIA016,DZIA017,DZIA018,DZIA019,DZIA020,
                       DZIA021,
                       DZIACRTID,DZIACRTDT,DZIAMODID,DZIAMODDT
                      ) 
               VALUES (
                       lo_dzia_t.DZIA001,lo_dzia_t.DZIA002,lo_dzia_t.DZIA003,lo_dzia_t.DZIA004,lo_dzia_t.DZIA005,
                       lo_dzia_t.DZIA006,lo_dzia_t.DZIA007,lo_dzia_t.DZIA008,lo_dzia_t.DZIA009,lo_dzia_t.DZIA010,
                       lo_dzia_t.DZIA011,lo_dzia_t.DZIA012,lo_dzia_t.DZIA013,lo_dzia_t.DZIA014,lo_dzia_t.DZIA015,
                       lo_dzia_t.DZIA016,lo_dzia_t.DZIA017,lo_dzia_t.DZIA018,lo_dzia_t.DZIA019,lo_dzia_t.DZIA020,
                       lo_dzia_t.DZIA021,
                       ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
    
  CATCH 
    # 更新異動者資訊, 20170116 add by circlelai 
    TRY
      UPDATE dzia_t 
         SET dziamodid = ls_user, dziamoddt = ldt_datetime
       WHERE dzia001 = lo_dzia_t.DZIA001 AND dzia015 = lo_dzia_t.DZIA015
    CATCH
      LET lb_success = FALSE
      DISPLAY "[Warning] INSERT INTO DZIA_T unsuccess : ",SQLCA.sqlcode
      LET ls_message =  "[Warning] INSERT INTO DZIA_T unsuccess : ",SQLCA.sqlcode
      #SQLSTATE , SQLERRMESSAGE
    END TRY
  END TRY
  
  RETURN lb_success,ls_message
  
END FUNCTION

FUNCTION sadzi180_crud_insert_update_dzib_t(p_dzib_t)
DEFINE
  p_dzib_t  T_DZIB_T
DEFINE 
  lo_dzib_t     T_DZIB_T,
  lb_success    BOOLEAN,
  ls_user       VARCHAR(100),
  ldt_datetime  DATETIME YEAR TO SECOND
DEFINE 
  ls_message    STRING  #紀錄錯誤訊息 DGW07558_add_at20151109

  LET lo_dzib_t.* = p_dzib_t.*

  LET ls_user = g_user --FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND

  LET lb_success = TRUE
  LET ls_message = ""
  
  TRY 
    INSERT INTO DZIB_T(
                        dzib001,dzib002,dzib003,dzib004,dzib005,
                        dzib006,dzib007,dzib008,dzib012,dzib021,
                        dzib022,dzib023,dzib024,dzib027,dzib028,
                        dzib029,dzib030,dzib031,
                        dzibcrtid,dzibcrtdt,dzibmodid,dzibmoddt
                      )
               VALUES (
                        lo_dzib_t.dzib001,lo_dzib_t.dzib002,lo_dzib_t.dzib003,lo_dzib_t.dzib004,lo_dzib_t.dzib005,
                        lo_dzib_t.dzib006,lo_dzib_t.dzib007,lo_dzib_t.dzib008,lo_dzib_t.dzib012,lo_dzib_t.dzib021,
                        lo_dzib_t.dzib022,lo_dzib_t.dzib023,lo_dzib_t.dzib024,lo_dzib_t.dzib027,lo_dzib_t.dzib028,
                        lo_dzib_t.dzib029,lo_dzib_t.dzib030,lo_dzib_t.dzib031,
                        ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
                       
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZIB_T                                 
         SET DZIB003   = lo_dzib_t.dzib003,
             DZIB004   = lo_dzib_t.dzib004,
             DZIB005   = lo_dzib_t.dzib005,
             DZIB006   = lo_dzib_t.dzib006,
             DZIB007   = lo_dzib_t.dzib007,
             DZIB008   = lo_dzib_t.dzib008,
             DZIB012   = lo_dzib_t.dzib012,
             DZIB021   = lo_dzib_t.dzib021,
             DZIB022   = lo_dzib_t.dzib022,
             DZIB023   = lo_dzib_t.dzib023,
             DZIB024   = lo_dzib_t.dzib024,
             DZIB027   = lo_dzib_t.dzib027,
             DZIB028   = lo_dzib_t.dzib028,
             #DZIB029   = lo_dzib_t.dzib029,
             DZIB030   = lo_dzib_t.dzib030,
             DZIB031   = lo_dzib_t.dzib031,
             DZIBMODID = ls_user,
             DZIBMODDT = ldt_datetime
       WHERE DZIB001  = lo_dzib_t.dzib001
         AND DZIB002  = lo_dzib_t.dzib002
         AND DZIB029  = lo_dzib_t.dzib029
    CATCH
      LET lb_success = FALSE
      DISPLAY "[Warning] Insert or Update DZIB_T unsuccess : ",SQLCA.sqlcode
      LET ls_message = "[Warning] Insert or Update DZIB_T unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

  RETURN lb_success,ls_message

END FUNCTION

#DZIB_T 資料表 欄位資料刪除行為  --DGW07558_add at20151103
FUNCTION sadzi180_crud_delete_dzib_t(p_dzib_column)
DEFINE 
  p_dzib_column   T_INTF_COLUMN_LIST
DEFINE 
  lo_dzib_column     T_INTF_COLUMN_LIST,
  ls_message      STRING,
  lb_success    BOOLEAN
  
  LET ls_message = ""
  LET lo_dzib_column.* = p_dzib_column.*
  LET lb_success = TRUE
  TRY
    DELETE FROM DZIB_T 
    WHERE DZIB001 = lo_dzib_column.TABLE_NAME 
    AND DZIB002 = lo_dzib_column.COLUMN_NAME 
  CATCH 
    LET lb_success = FALSE 
    DISPLAY "[Warning] Delete DZIB_T unsuccess : ",SQLCA.sqlcode
    LET ls_message = "[Warning] Delete DZIB_T unsuccess : ",SQLCA.sqlcode
  END TRY
  RETURN lb_success,ls_message
END FUNCTION 

FUNCTION sadzi180_crud_insert_update_dziu_t(p_dziu_t)
DEFINE
  p_dziu_t  T_DZIU_T
DEFINE 
  lo_dziu_t     T_DZIU_T,
  lb_success    BOOLEAN,
  ls_user       VARCHAR(100),
  ldt_datetime  DATETIME YEAR TO SECOND,
  ls_message    STRING

  LET ls_message = ""
  LET lo_dziu_t.* = p_dziu_t.*

  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND

  LET lb_success = TRUE
  
  TRY 
    INSERT INTO DZIU_T(
                        dziu001,dziu002,dziu003,dziu004,dziu005
                      )
               VALUES (
                        lo_dziu_t.dziu001,lo_dziu_t.dziu002,lo_dziu_t.dziu003,lo_dziu_t.dziu004,lo_dziu_t.dziu005
                      )
                       
  CATCH
    TRY
      #DISPLAY "INSERT NOT SUCCESS TRY Update"
      UPDATE DZIU_T                                 
         SET DZIU003 = lo_dziu_t.dziu003,
             DZIU004 = lo_dziu_t.dziu004,
             DZIU005 = lo_dziu_t.dziu005
       WHERE DZIU001 = lo_dziu_t.dziu001
         AND DZIU002 = lo_dziu_t.dziu002
    CATCH
      LET lb_success = FALSE
      DISPLAY "[Warning] Insert or Update DZIU_T unsuccess : ",SQLCA.sqlcode
      LET ls_message =  "[Warning] Insert or Update DZIU_T unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

  RETURN lb_success,ls_message

END FUNCTION

################################################################################
# Descriptions...: 新增或者修改設計資料內容
# Memo...........: 
# Usage..........: CALL sadzi180_crud_set_table_data 
#                :      (p_dzia_t,p_dzib_t,p_dziu_t,p_edit_type,p_dzib_del_list)
#                :      RETURNING lb_result, ls_message
# Input parameter: p_dzia_t  中介表格主檔
#                : p_dzib_t  中介表格明細檔
#                : p_dziu_t  中介表格表格.同義字設定檔
#                : p_edit_type  新增或者修改模式
#                : p_dzib_del_list  修改狀態下dzib_t要刪除的資料內容
# Return code....: 
# Date & Author..: 
# Modify.........: 20170116 mod by circlelai
################################################################################
FUNCTION sadzi180_crud_set_table_data(p_dzia_t,p_dzib_t,p_dziu_t,p_edit_type,p_dzib_del_list)
DEFINE
  p_dzia_t          T_DZIA_T,
  p_dzib_t          DYNAMIC ARRAY OF T_DZIB_T,
  p_dziu_t          DYNAMIC ARRAY OF T_DZIU_T,
  p_edit_type       STRING,  #新增或者修改狀態  --DGW07558_add at20151103
  p_dzib_del_list   DYNAMIC ARRAY OF T_INTF_COLUMN_LIST #修改狀態下，dzib_t要刪除的資料內容 --DGW07558_add at20151103
DEFINE
  lo_dzia_t         T_DZIA_T,
  lo_dzib_t         DYNAMIC ARRAY OF T_DZIB_T,
  lo_dziu_t         DYNAMIC ARRAY OF T_DZIU_T,
  lo_dzib_del_list  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  li_loop    INTEGER,
  lb_result  BOOLEAN,
  lb_success BOOLEAN,
  ls_message      STRING    #紀錄執行訊息 --DGW07558_add_at151109
  

  LET lo_dzia_t.* = p_dzia_t.*
  LET lo_dzib_t   = p_dzib_t
  LET lo_dziu_t   = p_dziu_t
  
  LET lb_success = TRUE
  LET lb_result  = TRUE

  BEGIN WORK

  #dzia_t 新增中介表格主檔或者更新異動人資訊 # 20170116 mod by circlelai begin
  IF lb_success THEN
     CALL sadzi180_crud_insert_dzia_t(lo_dzia_t.*) RETURNING lb_result,ls_message
     IF NOT lb_result THEN 
        LET lb_success = FALSE
        ROLLBACK WORK 
     END IF
  END IF 
  # 20170116 mod by circlelai end

  #新增 dzib 
  IF lb_success THEN 
    FOR li_loop = 1 TO lo_dzib_t.getLength()
      CALL sadzi180_crud_insert_update_dzib_t(lo_dzib_t[li_loop].*) RETURNING lb_result,ls_message
      IF NOT lb_result THEN 
        LET lb_success = FALSE
        ROLLBACK WORK 
        EXIT FOR 
      END IF
    END FOR
  END IF  

  #修改狀態下，處理使用者可能刪除欄位 --DGW07558_add at20151103
  IF (p_edit_type == cs_mdf_type_modify) THEN
    IF lb_success AND (p_dzib_del_list.getLength() > 0) THEN 
      FOR li_loop = 1 TO p_dzib_del_list.getLength()
        CALL sadzi180_crud_delete_dzib_t(p_dzib_del_list[li_loop].*) RETURNING lb_result,ls_message
        IF NOT lb_result THEN 
          LET lb_success = FALSE
          ROLLBACK WORK 
          EXIT FOR 
        END IF
      END FOR
    END IF
  END IF 
  
  IF (p_edit_type == cs_mdf_type_new) THEN 
    IF lb_success THEN 
      FOR li_loop = 1 TO lo_dziu_t.getLength()
        CALL sadzi180_crud_insert_update_dziu_t(lo_dziu_t[li_loop].*) RETURNING lb_result,ls_message
        IF NOT lb_result THEN 
          LET lb_success = FALSE
          ROLLBACK WORK 
          EXIT FOR 
        END IF
      END FOR
    END IF
  END IF 
  
  IF lb_success THEN 
    COMMIT WORK 
  END IF 

  RETURN lb_success,ls_message
      
END FUNCTION
