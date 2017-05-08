# Description    : 測試程式
IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"
GLOBALS "../4gl/adzi888_global.inc"

MAIN
   DEFINE ls_prog     STRING,     #規格代號
          ls_sys      STRING,     #模組
          ls_revision STRING,     #規格版次
          ls_type     STRING,     #類型
          ls_identity STRING      #識別標示

   DEFINE ls_msg      STRING
   DEFINE l_date      LIKE dzaa_t.dzaacrtdt
   DEFINE l_chr       LIKE type_t.chr1
   DEFINE lb_result   BOOLEAN

   DEFINE lb_rtn     BOOLEAN,
          ls_err     STRING,
          lb_return  BOOLEAN, 
          lo_dzaf T_DZAF_T
   DEFINE g_parameter STRING
   DEFINE li_i       LIKE type_t.num5
   DEFINE l_arg      STRING

   CALL cl_tool_init()
   
   LET ls_prog = ARG_VAL(2) CLIPPED
   LET ls_sys = ARG_VAL(3)
   LET ls_revision = ARG_VAL(4)
   LET ls_type = ARG_VAL(5)
   LET ls_identity = ARG_VAL(6)

   DISPLAY '\narg1,arg2,arg3,arg4,arg5=',ls_prog, ',' , ls_sys , ',',ls_revision, ',',ls_type, ',',ls_identity
   #########################################################

  
   CALL sadzp168_5('asli100',1,'s',TRUE) RETURNING lb_result,ls_msg
    
  {##################################  手動執行merge  ###########################
   ##################################  BEGIN  ###########################
   #輸入參數1:prog id
   #輸入參數2:prog type
   LET g_patch_mode = TRUE
   
   LET lo_dzaf.dzaf001 = ARG_VAL(2) CLIPPED #程式代號
   LET lo_dzaf.dzaf005 = ARG_VAL(3) CLIPPED #建構類型

   IF cl_null(lo_dzaf.dzaf001) OR cl_null(lo_dzaf.dzaf005) THEN
      DISPLAY "usage --> r.r adzp065 prog_name construct_type"
      EXIT PROGRAM
   END IF

   #取得目前(patch之後)dzaf_t內最大的客製版次資料 
   CALL sadzi888_07_get_curr_ver_info_by_flag(lo_dzaf.*, "c") RETURNING ls_err,lo_dzaf.*
   IF NOT cl_null(ls_err) THEN
      DISPLAY ls_err
      EXIT PROGRAM
   END IF

   CALL sadzi888_07_ins_dzap_t(lo_dzaf.*, "2014120202") RETURNING lb_rtn,ls_err
   IF NOT lb_rtn THEN
      DISPLAY ls_err
      EXIT PROGRAM
   END IF

   DISPLAY "sadzi888_07_auto_merge start..."
   CALL sadzi888_07_auto_merge(lo_dzaf.*) RETURNING lb_rtn,ls_err
   IF NOT lb_rtn THEN
      DISPLAY ls_err
      EXIT PROGRAM
   END IF
   ##################################  END  ###########################
  ##################################  手動執行merge  ###########################}



  {##################################  手動解開merge  ########################### 
   ##################################  BEGIN  ###########################
   #輸入參數1:prog id
   #輸入參數2:prog type
   IF cl_ask_confirm_parm("adz-00145","") THEN
      LET lo_dzaf.dzaf001 = ARG_VAL(2) CLIPPED #程式代號
      LET lo_dzaf.dzaf005 = ARG_VAL(3) CLIPPED #建構類型
     
      #取得目前(patch之後)dzaf_t內最大的客製版次資料
      CALL sadzi888_07_get_curr_ver_info_by_flag(lo_dzaf.*, "c") RETURNING ls_err,lo_dzaf.*
      IF NOT cl_null(ls_err) THEN 
         DISPLAY ls_err
         EXIT PROGRAM
      END IF  
      
      DISPLAY "call sadzp063_1_del_design_data() start..."
      DISPLAY "lo_dzaf.dzaf001=",lo_dzaf.dzaf001
      DISPLAY "lo_dzaf.dzaf005=",lo_dzaf.dzaf005
      LET g_parameter = "5" #客製合併還原功能
      
      #刪除設計資料需要控卡tiptop權限
      IF g_parameter="3" OR g_parameter="4" OR g_parameter="5" THEN
         IF lo_dzaf.dzaf006<>"AIT" AND lo_dzaf.dzaf006<>"CIT" THEN 
            IF NOT g_account = "tiptop" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.EXTEND = ""
               LET g_errparam.code   = "adz-00442"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN
            END IF
         END IF
      END IF
      
      CALL sadzp063_1_del_design_data(lo_dzaf.*, g_parameter) RETURNING lb_return,ls_err
      IF NOT lb_return THEN
        DISPLAY ls_err
      END IF
      DISPLAY "call sadzp063_1_del_design_data() finish!"
   END IF
   ##################################  END  ###########################
   ##################################  手動解開merge  ###########################}

   EXIT PROGRAM
END MAIN


