#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/27
#
#+ 程式代碼......: sadzp169_02
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp169_02.4gl
# Description    : 開通自定義欄位的相關功能
# Modify         : 2014/10/14 by Hiko : 新建程式
#                : 2015/02/25 by Hiko : 移除'm'的條件

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"

DEFINE g_date DATETIME YEAR TO SECOND,
       gs_dept STRING, 
       gs_erpid STRING,          #產品代號
       gs_erpver STRING,         #ERP大版版號
       gs_customer STRING,       #客戶代號
       g_env LIKE dzaa_t.dzaa009 #辨識目前所在的環境:s.產中環境,c.客製環境

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷是否可以執行自定義欄位開通
# Input parameter : po_curr_dzaf 目前的DZAF_T資料
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息  
# Date & Author   : 2014/10/14 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp169_02_continue_flag(po_curr_dzaf)
   DEFINE po_curr_dzaf T_DZAF_T
   DEFINE ls_trigger    STRING,
          ls_sql        STRING,
          ls_free_style STRING,
          lb_rtn        BOOLEAN,
          ls_err_msg    STRING

   TRY
      LET ls_trigger = "call sadzp169_02_continue_flag() start!"
      DISPLAY ls_trigger
      LET lb_rtn = TRUE
      LET ls_err_msg = NULL

      CALL sadzp169_02_chk_not_free_style(po_curr_dzaf.dzaf001, po_curr_dzaf.dzaf010) RETURNING lb_rtn,ls_err_msg
      IF lb_rtn THEN
         CALL sadzp169_02_chk_not_section(po_curr_dzaf.dzaf001, po_curr_dzaf.dzaf004, po_curr_dzaf.dzaf010) RETURNING lb_rtn,ls_err_msg
      END IF

      RETURN lb_rtn,ls_err_msg
   CATCH
      CALL sadzp169_02_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp169_02_continue_flag error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷程式是否為Free Style
# Input parameter : p_prog     程式代號
#                 : p_identity 客製
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息  
# Date & Author   : 2014/10/14 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp169_02_chk_not_free_style(p_prog, p_identity)
   DEFINE p_prog     LIKE dzax_t.dzax001,
          p_identity LIKE dzax_t.dzax006
   DEFINE l_free_style LIKE dzax_t.dzax003
   DEFINE ls_trigger   STRING,
          ls_sql       STRING,
          ls_err_msg   STRING

   TRY
      LET ls_trigger = "call sadzp169_02_chk_free_style() start!"
      DISPLAY ls_trigger
      LET ls_err_msg = NULL

      SELECT dzax003 INTO l_free_style FROM dzax_t WHERE dzax001=p_prog AND dzax006=p_identity
      IF cl_null(l_free_style) THEN
         LET ls_err_msg = cl_getmsg("adz-00411", g_lang) #可以開通自定義欄位的程式(M,S)一定會有dzax_t的資料,所以找不到dzax的任何資料就是錯誤.
         RETURN FALSE,ls_err_msg
      END IF

      IF l_free_style="Y" THEN #執行到這邊一定有dzax_t的資料
         LET ls_err_msg = cl_getmsg("adz-00412", g_lang) #此程式為Free Style,所以不能執行自動開通
         RETURN FALSE,ls_err_msg
      END IF

      RETURN TRUE,NULL
   CATCH
      CALL sadzp169_02_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp169_02_chk_free_style error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷程式是否已經改過SECTION
# Input parameter : p_prog          程式代號
#                 : p_code_revision 程式版次
#                 : p_identity 客製
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息  
# Date & Author   : 2014/10/14 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp169_02_chk_not_section(p_prog, p_code_revision, p_identity)
   DEFINE p_prog          LIKE dzbc_t.dzbc001,
          p_code_revision LIKE dzbc_t.dzbc002,
          p_identity      LIKE dzbc_t.dzbc007
   DEFINE ls_trigger    STRING,
          ls_sql        STRING,
          li_cnt        SMALLINT,
          ls_err_msg    STRING

   TRY
      LET ls_trigger = "call sadzp169_02_chk_section() start!"
      DISPLAY ls_trigger
      SELECT COUNT(*) INTO li_cnt FROM dzbc_t
       WHERE dzbc001=p_prog
         AND dzbc002=p_code_revision
         AND dzbc007=p_identity
         AND dzbc005 IN ('c') #2015/02/25 by Hiko : 移除'm'的條件
      IF li_cnt>0 THEN
         LET ls_err_msg = cl_getmsg("adz-00413", g_lang) #SECTION已經被修改,所以不能執行自動開通
         RETURN FALSE,ls_err_msg
      END IF

      RETURN TRUE,NULL
   CATCH
      CALL sadzp169_02_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp169_02_chk_section error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : void
# Date & Author   : 2014/10/14 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp169_02_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 開通之前的動作.
# Input parameter : po_old_dzaf 目前的DZAF_T資料
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息  
#                 : T_DZAF_T dzaf_t物件
# Date & Author   : 2014/10/21 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp169_02_before_opening(po_old_dzaf)
   DEFINE po_old_dzaf T_DZAF_T
   DEFINE ls_trigger    STRING,
          ls_sql        STRING,
          lb_result     BOOLEAN,
          ls_err_msg    STRING,
          lo_new_dzaf T_DZAF_T #新的客製DZAF_T資料

   DISPLAY "call sadzp169_02_before_opening start..."
   
   CALL sadzp169_02_init_var()

   #自動簽出
   CALL sadzp169_02_check_out_in("O", po_old_dzaf.*) RETURNING lb_result,ls_err_msg
   IF NOT lb_result THEN
      RETURN FALSE,ls_err_msg
   END IF

   IF po_old_dzaf.dzaf010="s" THEN #標準變客製的時候要做兩次:s534-->c111
      CALL sadzi888_07_create_design_data_for_adzp169(po_old_dzaf.*, "ALL") RETURNING lb_result,ls_err_msg,lo_new_dzaf.*
      IF NOT lb_result THEN
         RETURN FALSE,ls_err_msg,NULL
      END IF

      LET po_old_dzaf.* = lo_new_dzaf.* #這裡是為了做c111-->c222  
   END IF

   CALL sadzi888_07_create_design_data_for_adzp169(po_old_dzaf.*, "ALL") RETURNING lb_result,ls_err_msg,lo_new_dzaf.*
   IF NOT lb_result THEN
      RETURN FALSE,ls_err_msg,NULL
   END IF

   DISPLAY "call sadzp169_02_before_opening finish"

   RETURN TRUE,NULL,lo_new_dzaf.*
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : BOOLEAN(成功:TRUE,失敗:FALSE)
# Date & Author   : 2014/10/21 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp169_02_init_var()
   LET g_date = cl_get_current()
   LET gs_dept = g_dept CLIPPED
   LET gs_erpid = FGL_GETENV("ERPID") CLIPPED
   LET gs_erpver = FGL_GETENV("ERPVER") CLIPPED
   LET gs_customer = FGL_GETENV("CUST") CLIPPED
   LET g_env = FGL_GETENV("DGENV") CLIPPED
   
   DISPLAY "call sadzp169_02_init_var finish"
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 遷出/入.
# Input parameter : p_action 執行動作(O:check out/I:check in)
#                 : po_old_dzaf 舊的客製DZAF_T資料
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息  
# Date & Author   : 2014/10/21 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp169_02_check_out_in(p_action, po_old_dzaf)
   DEFINE p_action STRING,
          po_old_dzaf T_DZAF_T
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          li_cnt      SMALLINT,
          ls_err_msg  STRING
   DEFINE l_dzlm004 LIKE dzlm_t.dzlm004,
          l_dzlm005 LIKE dzlm_t.dzlm005,
          l_dzlm006 LIKE dzlm_t.dzlm006,
          l_dzlm009 LIKE dzlm_t.dzlm009,
          lo_dzlm T_DZLM_T

   TRY
      CALL sadzp169_02_init_var()

      IF p_action="O" THEN
         IF po_old_dzaf.dzaf010="s" THEN #標準轉客製(例如s534變成c111)
            LET l_dzlm004 = sadzi140_db_get_module_code_by_dgenv(po_old_dzaf.dzaf006, "c") #取得對應的客製模組
            LET l_dzlm005 = 1
            LET l_dzlm006 = 1
            LET l_dzlm009 = 1
         ELSE
            LET l_dzlm004 = po_old_dzaf.dzaf006 #原本的客製模組
            LET l_dzlm005 = po_old_dzaf.dzaf002 #建構版次字串轉數字
            LET l_dzlm006 = po_old_dzaf.dzaf003 #規格版次字串轉數字
            LET l_dzlm009 = po_old_dzaf.dzaf004 #程式版次字串轉數字
         END IF
         
         LET l_dzlm005 = l_dzlm005 + 1
         LET l_dzlm006 = l_dzlm006 + 1
         LET l_dzlm009 = l_dzlm009 + 1
      ELSE
         LET l_dzlm005 = po_old_dzaf.dzaf002 #建構版次字串轉數字
         LET l_dzlm006 = po_old_dzaf.dzaf003 #規格版次字串轉數字
         LET l_dzlm009 = po_old_dzaf.dzaf004 #程式版次字串轉數字
      END IF
      #標準開通:例如s534-->c222(標準變客製):不需要簽出c111
      #客製開通:例如c323-->c434

      #主要資訊
      LET lo_dzlm.dzlm001 = po_old_dzaf.dzaf005   #建構類型(PK)
      LET lo_dzlm.dzlm002 = po_old_dzaf.dzaf001   #建構代號(PK)
      LET lo_dzlm.dzlm003 = NULL                  #建構名稱
      LET lo_dzlm.dzlm004 = l_dzlm004             #模組
      LET lo_dzlm.dzlm005 = l_dzlm005             #建構版次(PK)
      #SD權限相關
      LET lo_dzlm.dzlm006 = l_dzlm006             #SD版次
      LET lo_dzlm.dzlm007 = g_user                #SD工號
      #PR權限相關
      LET lo_dzlm.dzlm009 = l_dzlm009             #PR版次
      LET lo_dzlm.dzlm010 = g_user                #PR工號
      #其他資訊:其他欄位對於本作業沒有影響,所以不需要處理
      LET lo_dzlm.dzlm012 = "000000-00000"        #需求單號(PK)
      LET lo_dzlm.dzlm013 = gs_erpid              #產品代號(PK)
      LET lo_dzlm.dzlm014 = gs_erpver             #產品版本(PK)
      LET lo_dzlm.dzlm015 = 1                     #作業項次(PK)

      SELECT COUNT(*) INTO li_cnt FROM dzlm_t
       WHERE dzlm001=lo_dzlm.dzlm001
         AND dzlm002=lo_dzlm.dzlm002
         AND dzlm005=lo_dzlm.dzlm005

      IF p_action="O" THEN #簽出要新增dzlm_t
         IF li_cnt=0 THEN #沒有資料才可以新增
            LET lo_dzlm.dzlm008 = "O" #SD狀態(O:簽出,I:簽入)
            LET lo_dzlm.dzlm011 = "O" #PR狀態(O:簽出,I:簽入)

            LET ls_sql = "INSERT INTO dzlm_t(dzlm001,dzlm002,dzlm003,dzlm004,dzlm005,",
                                            "dzlm006,dzlm007,dzlm008,dzlm009,dzlm010,",
                                            "dzlm011,dzlm012,dzlm013,dzlm014,dzlm015)",
                                    " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
            
            PREPARE dzlm_prep1 FROM ls_sql
            EXECUTE dzlm_prep1 USING lo_dzlm.dzlm001,lo_dzlm.dzlm002,lo_dzlm.dzlm003,lo_dzlm.dzlm004,lo_dzlm.dzlm005,
                                     lo_dzlm.dzlm006,lo_dzlm.dzlm007,lo_dzlm.dzlm008,lo_dzlm.dzlm009,lo_dzlm.dzlm010,
                                     lo_dzlm.dzlm011,lo_dzlm.dzlm012,lo_dzlm.dzlm013,lo_dzlm.dzlm014,lo_dzlm.dzlm015
            FREE dzlm_prep1
         END IF
      ELSE #簽入要刪除dzlm_t
         IF li_cnt>0 THEN #有資料才可以刪除
            LET lo_dzlm.dzlm008 = "I" #SD狀態(O:簽出,I:簽入)
            LET lo_dzlm.dzlm011 = "I" #PR狀態(O:簽出,I:簽入)
            LET lo_dzlm.dzlm017 = cl_get_current()

            UPDATE dzlm_t
               SET dzlm008=lo_dzlm.dzlm008,
                   dzlm011=lo_dzlm.dzlm011,
                   dzlm017=lo_dzlm.dzlm017
             WHERE dzlm001=lo_dzlm.dzlm001
               AND dzlm002=lo_dzlm.dzlm002
               AND dzlm005=lo_dzlm.dzlm005
         END IF
      END IF

      RETURN TRUE,NULL
   CATCH
      CALL sadzp169_02_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp169_02_mdi_dzlm ",p_action," error!"
   END TRY
END FUNCTION
