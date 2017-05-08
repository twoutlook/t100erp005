#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/27
#
#+ 程式代碼......: sadzp060_4
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp060_4.4gl
# Description    : 標準程式同步行業功能
# Modify         : 2015/01/15 by Hiko : 新建程式
#                : 2015/03/10 by Hiko : 將同步清單寫入dzar_t內
#                : 2015/03/13 by Hiko : 執行同步前,讓開發者可以看清楚要更新的前後內容
#                : 2015/04/29 by Hiko : 取得本次標準異動的清單,並且dzaq007改成PK(Key Word:STD_LIST)
#                : 2015/05/11 by Hiko : 精準更新本次標準異動的清單(Key Word:TARGET_LIST)
#                : 2015/05/19 by Hiko : 支持整批同步((Key Word:BATCH_SYNC)
#                : 2015/05/26 by Hiko : 同步後要重產tsd/tap(因為tab/4gl/4fd都已經是新的,若有人沒有簽出就下載,就會出現不一致的情況)
#                : 2015/06/03 by Hiko : 同步後由呼叫端來重產tsd/tap
#                : 2015/06/12 by Hiko : 同步改成未簽出的時候執行, 所以得自行長dzaf_t. 也就是說, 同步也是只能執行一次.
#                : 2015/06/30 by Hiko : 若沒有版次資料,則不寫入dzaq_t.
#                : 2015/08/19 by Hiko : 修改引用過程的版次問題,重點是改adzp640.
#                : 2015/09/18 by Hiko : 新增dzaq_t前先判斷是否有版次
#                : 20160118 by Hiko : 1.簡化同步機制, 不特別判斷dzaq_t的版次, 一律以最新的標準版次為同步來源.
#                                     2.若已經同步過, 還是可以透過adzp640來處理.
#                                     3.移除dzar_t的預覽機制, 改成呼叫adzq991來查看.
#                                     4.增加dzau_t/dzbu_t來記錄行業對應之標準規格/apt引用清單, 讓引用過程更有效率.
#                : 20160226 160226-00009 by Hiko : 1.調整sadzp060_4_batch_ins_dzaq_t參數.
#                                                  2.補上未簽出的檢查.
#                                                  3.補上dzaq013(模組別)的賦值.
#                : 20160727 160726-00007 by Hiko : 移除dzau_t,dzbu_t沒有資料的警告.
#                : 20160929 160929-00037 by Hiko : 1.只要標準與行業都不是Free Style或都是Free Style就可以同步.
#                                                  2.只要標準或行業有解開Section, 就在同步後提示訊息.

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"
#160226-00009
&include "../4gl/sadzp000_type.inc"

DEFINE g_date DATETIME YEAR TO SECOND,
       gs_dept STRING, 
       gs_erpid STRING,  #產品代號
       gs_erpver STRING, #ERP大版版號
       gs_customer STRING, 
       g_env LIKE dzaa_t.dzaa009, #辨識目前所在的環境:s.產中環境,c.行業環境
       g_revision LIKE dzaf_t.dzaf003 #規格/程式版次
DEFINE g_prog        LIKE dzaf_t.dzaf001,
       gb_trans_flag BOOLEAN
#Begin:STD_LIST
DEFINE gr_dzaq RECORD LIKE dzaq_t.*,
       ga_std_dzaa DYNAMIC ARRAY OF RECORD LIKE dzaa_t.*,
       ga_std_dzba DYNAMIC ARRAY OF RECORD LIKE dzba_t.*,
       ga_std_dzag DYNAMIC ARRAY OF RECORD LIKE dzag_t.*,
       ga_std_dzfs DYNAMIC ARRAY OF RECORD LIKE dzfs_t.*,
       ga_std_dzam DYNAMIC ARRAY OF RECORD LIKE dzam_t.*
#End:STD_LIST


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : BOOLEAN(成功:TRUE,失敗:FALSE)
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_init_var()
   LET g_date = cl_get_current()
   LET gs_dept = g_dept CLIPPED
   LET gs_erpid = FGL_GETENV("ERPID") CLIPPED
   LET gs_erpver = FGL_GETENV("ERPVER") CLIPPED
   LET gs_customer = FGL_GETENV("CUST") CLIPPED
   LET g_env = FGL_GETENV("DGENV") CLIPPED
   LET gb_trans_flag = FALSE
   
   DISPLAY "call sadzp060_4_init_var finish"
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : void
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 批次新增sync資訊(dzaq_t)
# Input parameter : pa_std_list 行業主機同步的標準程式清單
#                 : p_patch_no  匯入包編號
# Return code     : BOOLEAN  TRUE:成功;FALSE:失敗
#                 : STRING   錯誤訊息
# Date & Author   : 2015/05/22 by Hiko
##########################################################################
#PUBLIC FUNCTION sadzp060_4_batch_ins_dzaq_t(pa_std_list,p_patch_no) #BATCH_SYNC
PUBLIC FUNCTION sadzp060_4_batch_ins_dzaq_t(p_patch_no) #BATCH_SYNC #160226-00009
   DEFINE p_patch_no  LIKE dzye_t.dzye001
   DEFINE li_i        SMALLINT,
          ls_sql      STRING,
          #lr_dzye     RECORD LIKE dzye_t.*,
          la_dzye     DYNAMIC ARRAY OF RECORD LIKE dzye_t.*, #160226-00009
          lo_std_dzaf T_DZAF_T,
          lb_result   BOOLEAN,
          ls_err_msg  STRING,
          lsb_err     base.StringBuffer,
          l_patch_no  LIKE dzye_t.dzye001,
          l_prog      LIKE dzye_t.dzye002,
          l_date      DATETIME YEAR TO SECOND, 
          l_fail_prog LIKE dzye_t.dzye018
   
   CALL sadzp060_4_init_var()

   LET lsb_err = base.StringBuffer.create()

   #Begin:160226-00009
   #FOR li_i=1 TO la_std_list.getLength()
   #   #行業主機Patch後會將相關資訊寫入dzye_t,所以可從dzye_t的相關資料組出T_DZAF_T.
   #   LET ls_sql = "SELECT * FROM dzye_t WHERE dzye002='",la_std_list[li_i] CLIPPED,"' AND dzye001='",p_patch_no CLIPPED,"'"
   #   PREPARE dzye_prep FROM ls_sql
   #   EXECUTE dzye_prep INTO lr_dzye.*
   #   FREE dzye_prep
   #   LET ls_sql = NULL #20160118 by Hiko
   #   
   #   LET lo_std_dzaf.dzaf001 = la_std_list[li_i]
   #   LET lo_std_dzaf.dzaf002 = lr_dzye.dzye014 #來源建構版次
   #   LET lo_std_dzaf.dzaf003 = lr_dzye.dzye020 #來源規格版次
   #   LET lo_std_dzaf.dzaf004 = lr_dzye.dzye021 #來源程式版次
   #   LET lo_std_dzaf.dzaf005 = lr_dzye.dzye003 #建構類型
   #   LET lo_std_dzaf.dzaf006 = lr_dzye.dzye005 #模組
   #   LET lo_std_dzaf.dzaf010 = lr_dzye.dzye019 #來源程式客制否
   LET ls_sql = "SELECT * FROM dzye_t WHERE dzye001=?"
   PREPARE prep_dzye FROM ls_sql
   DECLARE curs_dzye CURSOR FOR prep_dzye
   OPEN curs_dzye USING p_patch_no
   LET ls_sql = NULL
   LET li_i = 1
   FOREACH curs_dzye INTO la_dzye[li_i].*
      INITIALIZE lo_std_dzaf TO NULL
      LET lo_std_dzaf.dzaf001 = la_dzye[li_i].dzye002 #程式代碼
      LET lo_std_dzaf.dzaf002 = la_dzye[li_i].dzye014 #來源建構版次
      LET lo_std_dzaf.dzaf003 = la_dzye[li_i].dzye020 #來源規格版次
      LET lo_std_dzaf.dzaf004 = la_dzye[li_i].dzye021 #來源程式版次
      LET lo_std_dzaf.dzaf005 = la_dzye[li_i].dzye003 #建構類型
      LET lo_std_dzaf.dzaf006 = la_dzye[li_i].dzye005 #模組
      LET lo_std_dzaf.dzaf010 = la_dzye[li_i].dzye019 #來源程式客制否
   #End:160226-00009

      #目前只有M類才可以做行業同步.
      IF lo_std_dzaf.dzaf005<>"M" THEN
         LET li_i = li_i + 1 #160226-00009
         CONTINUE FOREACH
      END IF 

      CALL sadzp060_4_ins_dzaq_t(lo_std_dzaf.*, p_patch_no, "") RETURNING lb_result,ls_err_msg
      #Begin:20160118 by Hiko
      #IF NOT lb_result THEN
      #   IF lsb_err.getLength()>0 THEN
      #      CALL lsb_err.append(",")
      #   END IF
      #   CALL lsb_err.append(lo_std_dzaf.dzaf001) #紀錄失敗的程式代號
      #END IF
      #End:20160118 by Hiko
   END FOREACH
   #END FOR

   #Begin:20160118 by Hiko
   #IF lsb_err.getLength()>0 THEN #表示新增dzaq_t有失敗紀錄,只需要建立一筆dzye_t即可.
   #   TRY
   #      LET l_patch_no = p_patch_no CLIPPED,"dzaq"
   #      LET l_prog = "ins_dzaq_fail" #固定字串
   #      LET l_date = cl_get_current()
   #      LET l_fail_prog = lsb_err.toString()
   #      LET ls_sql = "INSERT INTO dzye_t(dzye001,dzye002,dzye017,dzye018,dzye024)",
   #                              " VALUES(?,?,?,?,?)"
   #      PREPARE dzye_prep2 FROM ls_sql
   #      EXECUTE dzye_prep2 USING l_patch_no,l_prog,l_date,l_fail_prog,g_user
   #      FREE dzye_prep2
   #   CATCH
   #      DISPLAY "sadzp060_4_batch_ins_dzaq_t insert dzye_t failure, but it's OK."
   #   END TRY
   
   #   LET ls_err_msg = "Batch insert dzaq_t have error. Please to check the dzye_t : where dzye001='",l_patch_no CLIPPED,"' AND dzye002='ins_dzaq_fail'"
   #   RETURN FALSE,ls_err_msg
   #END IF
   #End:20160118 by Hiko

   RETURN TRUE,NULL
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 新增sync資訊(dzaq_t)
# Input parameter : po_curr_std_dzaf 簽出當下的標準DZAF_T資料
#                 : p_req_no     需求單號
#                 : p_req_order  需求單項次
# Return code     : BOOLEAN  TRUE:成功;FALSE:失敗
#                 : STRING   錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_4_ins_dzaq_t(po_curr_std_dzaf, p_req_no, p_req_order)
   DEFINE po_curr_std_dzaf T_DZAF_T,
          p_req_no         LIKE dzaq_t.dzaq003,
          p_req_order      LIKE dzaq_t.dzaq002
   DEFINE la_gzzb    DYNAMIC ARRAY OF RECORD
                     gzzb001 LIKE gzzb_t.gzzb001, #行業程式代號
                     gzzb002 LIKE gzzb_t.gzzb002  #行業編號
                     END RECORD,
          li_idx     SMALLINT,
          l_prog     LIKE gzzb_t.gzzb001,
          ls_trigger STRING,
          ls_sql     STRING,
          ls_info    STRING,
          ls_err_msg STRING,
          li_cnt     SMALLINT
   DEFINE lo_dzaf T_DZAF_T

   TRY
      #目前只有M類才可以做sync,這裡是防呆.
      IF po_curr_std_dzaf.dzaf005<>"M" THEN
         LET ls_info = "[INFO]Only M type of industry program can do synchronous."
         DISPLAY ls_info
         RETURN TRUE,ls_info
      END IF 

      CALL sadzp060_4_init_var()

      #依據標準程式代號找到對應的各行業程式代號.
      LET ls_sql = "SELECT gzzb001,gzzb002 FROM gzzb_t",
                   " WHERE gzzb003=?",
                   "   AND gzzb003<>gzzb001",
                   " ORDER BY 1"
      PREPARE prep_gzzb FROM ls_sql
      DECLARE curs_gzzb CURSOR FOR prep_gzzb
      OPEN curs_gzzb USING po_curr_std_dzaf.dzaf001
      LET ls_sql = NULL #20160118 by Hiko
      LET li_idx = 1
      FOREACH curs_gzzb INTO la_gzzb[li_idx].*
         LET l_prog = la_gzzb[li_idx].gzzb001
         
         #STD_LIST:取得行業版次資訊:lo_dzaf
         CALL sadzp060_2_get_curr_ver_info(l_prog, po_curr_std_dzaf.dzaf005, po_curr_std_dzaf.dzaf006) RETURNING lo_dzaf.*,ls_err_msg
         IF cl_null(ls_err_msg) THEN #2015/06/30 by Hiko
            IF (NOT cl_null(lo_dzaf.dzaf003) AND lo_dzaf.dzaf003<>0) AND
               (NOT cl_null(lo_dzaf.dzaf004) AND lo_dzaf.dzaf004<>0) THEN #2015/09/18 by Hiko
               #這裡可以不用管行業程式是否已經同步過,總之就是要換新資料就是了.
               LET ls_trigger = "sadzp060_4_ins_dzaq_t:DELETE dzaq_t:",l_prog
               #DISPLAY ls_trigger
               DELETE FROM dzaq_t WHERE dzaq001=l_prog AND dzaq007=po_curr_std_dzaf.dzaf002 #STD_LIST
               
               LET ls_trigger = "sadzp060_4_ins_dzaq_t:INSERT INTO dzaq_t : ",l_prog
               #DISPLAY ls_trigger
               LET ls_sql = "INSERT INTO dzaq_t(dzaq001,dzaq002,dzaq003,dzaq004,dzaq005,",
                                               "dzaq006,dzaq007,dzaq008,dzaq009,dzaq010,",
                                               "dzaq011,dzaq012,dzaq013,", #160226-00009:補上dzaq013
                                               "dzaqownid,dzaqowndp,dzaqcrtid,dzaqcrtdp,dzaqcrtdt)",
                                       " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
               PREPARE ins_dzaq_prep FROM ls_sql
               EXECUTE ins_dzaq_prep USING l_prog,p_req_order,p_req_no,'','',
                                           '',po_curr_std_dzaf.dzaf002,po_curr_std_dzaf.dzaf003,po_curr_std_dzaf.dzaf004,'N',
                                           la_gzzb[li_idx].gzzb002,po_curr_std_dzaf.dzaf001,po_curr_std_dzaf.dzaf006, #160226-00009
                                           g_user,g_dept,g_user,g_dept,g_date
               FREE ins_dzaq_prep
               LET ls_sql = NULL #20160118 by Hiko
            END IF
         END IF

         LET li_idx = li_idx + 1
      END FOREACH
 
      DISPLAY "sadzp060_4_ins_dzaq_t finish!"

      RETURN TRUE,NULL

      LABEL _RTN_ERR :
         RETURN FALSE,ls_err_msg
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_ins_dzaq_t error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 更新sync資訊(dzaq_t)
# Input parameter : po_industry_dzaf 行業程式DZAF_T資料
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING  錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_4_upd_dzaq_t(po_industry_dzaf)
   DEFINE po_industry_dzaf T_DZAF_T
   DEFINE l_prog     LIKE dzaf_t.dzaf001,
          ls_trigger STRING,
          ls_sql     STRING,
          ls_err_msg STRING,
          li_cnt     SMALLINT
   DEFINE lb_result  BOOLEAN #STD_LIST

   TRY
      LET l_prog = po_industry_dzaf.dzaf001

      #Begin:STD_LIST
      CALL sadzp060_4_get_max_dzaq_t(l_prog) RETURNING lb_result
      #SELECT COUNT(*) INTO li_cnt FROM dzaq_t WHERE dzaq001=l_prog
      #IF li_cnt>0 THEN #這裡是防呆
      #End:STD_LIST
      IF lb_result THEN
         LET ls_trigger = "sadzp060_4_upd_dzaq_t:UPDATE dzaq_t:",l_prog
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzaq_t SET dzaq004=?,", #行業程式建構版次
                                        "dzaq005=?,", #行業程式規格版次
                                        "dzaq006=?,", #行業程式程式版次
                                        "dzaq010='Y',",
                                        "dzaqmoddt=?,",
                                        "dzaqmodid=?",
                      #" WHERE dzaq001=? AND dzaq007=?" #STD_LIST
                      " WHERE dzaq001=?" #STD_LIST #20160118 by Hiko
         PREPARE upd_dzaq_prep2 FROM ls_sql
         EXECUTE upd_dzaq_prep2 USING po_industry_dzaf.dzaf002,po_industry_dzaf.dzaf003,po_industry_dzaf.dzaf004,
                                      #g_date,g_user,l_prog,gr_dzaq.dzaq007 #STD_LIST
                                      g_date,g_user,l_prog #STD_LIST #20160118 by Hiko
         FREE upd_dzaq_prep2
         LET ls_sql = NULL #20160118 by Hiko
      ELSE
         LET ls_err_msg = "Cannot find the ",l_prog," data within dzaq_t."
         GOTO _RTN_ERR
      END IF
  
      DISPLAY "sadzp060_4_upd_dzaq_t finish!"
 
      RETURN TRUE,NULL

      LABEL _RTN_ERR :
         RETURN FALSE,ls_err_msg
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_upd_dzaq_t error!",ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得行業對應的最大標準建構版次的dzaq_t
# Input parameter : p_dzaq001 行業程式代號
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
# Date & Author   : 2015/04/29 by Hiko #STD_LIST
##########################################################################
PRIVATE FUNCTION sadzp060_4_get_max_dzaq_t(p_dzaq001)
   DEFINE p_dzaq001 LIKE dzaq_t.dzaq001
   DEFINE ls_trigger STRING,
          ls_sql     STRING
   #Begin:20160118 by Hiko
   DEFINE li_cnt SMALLINT
          
   #End:20160118 by Hiko

   TRY
      LET ls_trigger = "sadzp060_4_get_max_dzaq_t..."
      #DISPLAY ls_trigger
      #Begin:20160118 by Hiko
      #LET ls_sql = "SELECT * FROM dzaq_t aq",
      #             " WHERE aq.dzaq001=?"
      #             "   AND aq.dzaq007=(SELECT MAX(aq2.dzaq007) FROM dzaq_t aq2",
      #                                " WHERE aq2.dzaq001=aq.dzaq001)"
      #PREPARE dzaq_prep5 FROM ls_sql
      #EXECUTE dzaq_prep5 USING p_dzaq001 INTO gr_dzaq.*
      #FREE dzaq_prep5

      INITIALIZE gr_dzaq.* TO NULL
      LET li_cnt = 0
      SELECT COUNT(*) INTO li_cnt FROM dzaq_t WHERE dzaq001=p_dzaq001
      IF li_cnt>0 THEN
         LET ls_sql = "SELECT * FROM dzaq_t WHERE dzaq001='",p_dzaq001,"'"
         PREPARE dzaq_prep5 FROM ls_sql
         EXECUTE dzaq_prep5 INTO gr_dzaq.*
         FREE dzaq_prep5
         LET ls_sql = NULL #20160118 by Hiko
      ELSE
         RETURN FALSE
      END IF
      #End:20160118 by Hiko

      RETURN TRUE
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE
   END TRY
END FUNCTION

#Begin:20160118 by Hiko
###########################################################################
## Access Modifier : PUBLIC
## Descriptions    : 顯示規格/程式的同步資料
## Input parameter : po_industry_dzaf 行業程式DZAF_T資料
## Return code     : BOOLEAN  TRUE:成功;FALSE:失敗
## Date & Author   : 2015/03/13 by Hiko
###########################################################################
#PUBLIC FUNCTION sadzp060_4_show_sync_data(po_industry_dzaf)
#   DEFINE po_industry_dzaf T_DZAF_T
#   DEFINE ls_trigger  STRING,
#          ls_sql      STRING,
#          li_cnt      SMALLINT,
#          li_dzaq004  SMALLINT, #行業建構版次
#          li_dzaq005  SMALLINT, #行業規格版次
#          li_dzaq006  SMALLINT, #行業程式版次
#          lb_result   BOOLEAN,
#          lb_result2  BOOLEAN,
#          ls_info     STRING,
#          ls_err_msg  STRING,
#          lr_std_dzaq RECORD
#                      std_prog LIKE dzaq_t.dzaq012,
#                      cons_ver LIKE dzaq_t.dzaq007,
#                      spec_ver LIKE dzaq_t.dzaq008,
#                      code_ver LIKE dzaq_t.dzaq009
#                      END RECORD,
#          lo_std_dzaf T_DZAF_T 
#
#   TRY
#      CALL sadzp060_4_chk_data(po_industry_dzaf.*) RETURNING lb_result,ls_err_msg,lo_std_dzaf.*
#      IF NOT lb_result THEN
#         RETURN lb_result
#      END IF
#
#      #DELETE FROM dzar_t WHERE dzar001=g_prog #2015/03/10 by Hiko:查看前先清空dzar_t(行業資料同步清單) #20160118 by Hiko
#
#      #取得規格同步清單
#      LET ls_trigger = "sadzp060_4_show_sync_data : call sadzp060_4_sync_spec"
#      DISPLAY ls_trigger
#      LET g_revision = po_industry_dzaf.dzaf003
#      CALL sadzp060_4_sync_spec("QUERY", lo_std_dzaf.*, po_industry_dzaf.*) RETURNING lb_result,ls_err_msg
#      IF NOT lb_result THEN GOTO _RTN_ERR END IF
#   
#      #取得程式同步清單
#      LET ls_trigger = "sadzp060_4_show_sync_data : call sadzp060_4_sync_addpoint"
#      DISPLAY ls_trigger
#      LET g_revision = po_industry_dzaf.dzaf004 
#      CALL sadzp060_4_sync_addpoint("QUERY", lo_std_dzaf.*, po_industry_dzaf.*) RETURNING lb_result,ls_err_msg
#      IF NOT lb_result THEN GOTO _RTN_ERR END IF
#
#      RETURN TRUE
#
#      LABEL _RTN_ERR :
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = "!"
#         LET g_errparam.extend = ls_err_msg
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         RETURN FALSE
#   CATCH
#      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
#      DISPLAY "ERROR : call sadzp060_4_show_sync_data error!",ls_err_msg
#      RETURN FALSE
#   END TRY
#END FUNCTION
#End:20160118 by Hiko

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷是否可以執行行業同步
# Input parameter : po_industry_dzaf 行業程式DZAF_T資料
# Return code     : BOOLEAN  TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
#                 : DZAF_T 標準程式DZAF_T資料
# Date & Author   : 2015/03/13 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_4_chk_data(po_industry_dzaf)
   DEFINE po_industry_dzaf T_DZAF_T
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          lb_result   BOOLEAN,
          lb_result2  BOOLEAN,
          ls_err_code STRING,
          ls_err_msg  STRING,
          lo_std_dzaf T_DZAF_T 
   #Begin:21060118 by Hiko
   DEFINE li_sync_cnt    SMALLINT,
          lb_ver_same    BOOLEAN,
          ls_diff_kind   STRING, #CONS/SPEC/CODE
          li_dzaq_ver    SMALLINT,
          li_dzaf_ver    SMALLINT,
          ls_replace_arg STRING
   #End:21060118 by Hiko
   #Begin:160226-00009
   DEFINE lo_program_info DYNAMIC ARRAY OF T_PROGRAM_INFO,
          ls_owner        STRING
   #End:160226-00009

   TRY
      CALL sadzp060_4_init_var()

      #Begin:160726-00007
      ##Begin:20160118 by Hiko
      #SELECT COUNT(*) INTO li_sync_cnt FROM dzau_t WHERE dzau001=po_industry_dzaf.dzaf001
      #IF li_sync_cnt>0 THEN
      #   SELECT COUNT(*) INTO li_sync_cnt FROM dzau_t WHERE dzau001=po_industry_dzaf.dzaf001
      #END IF
      
      #IF li_sync_cnt=0 THEN
      #   LET ls_err_code = "adz-00753" #缺少行業產生時的基礎同步資料(dzau_t與dzbu_t), 所以無法執行行業同步.
      #   GOTO _RTN_ERR
      #END IF
      ##End:20160118 by Hiko
      #End:160726-00007

      IF po_industry_dzaf.dzaf005<>"M" THEN
         LET ls_err_code = "adz-00522" #只有主程式才可以執行行業同步
         GOTO _RTN_ERR
      END IF 

      IF g_account="topstd" OR g_env='c' THEN
         LET ls_err_code = "adz-00525" #非topstd登入以及標準環境才可以執行行業同步
         GOTO _RTN_ERR
      END IF

      LET g_prog = po_industry_dzaf.dzaf001 CLIPPED

      #Begin:STD_LIST
      CALL sadzp060_4_get_max_dzaq_t(g_prog) RETURNING lb_result
      IF NOT lb_result THEN
         LET ls_err_msg = "Cannot find the ",g_prog," data within dzaq_t."
         RETURN FALSE,ls_err_msg,lo_std_dzaf.*
      END IF

      LET ls_trigger = "sadzp060_4_chk_data:取得標準程式的dzaf_t"
      #DISPLAY ls_trigger

      #Begin:20160118 by Hiko:判斷dzaq_t上的標準版次是否和資料庫的標準最大版次相同, 要先提示.
      #LET lo_std_dzaf.dzaf001 = gr_dzaq.dzaq012
      #LET lo_std_dzaf.dzaf002 = gr_dzaq.dzaq007
      #LET lo_std_dzaf.dzaf003 = gr_dzaq.dzaq008
      #LET lo_std_dzaf.dzaf004 = gr_dzaq.dzaq009

      #LET lo_std_dzaf.dzaf005 = po_industry_dzaf.dzaf005 #M
      #LET lo_std_dzaf.dzaf006 = po_industry_dzaf.dzaf006
      #LET lo_std_dzaf.dzaf010 = po_industry_dzaf.dzaf010 #s

      #IF cl_null(lo_std_dzaf.dzaf001) OR cl_null(lo_std_dzaf.dzaf003) OR lo_std_dzaf.dzaf003=0 THEN
      #   LET ls_err_code = "adz-00498"
      #   GOTO _RTN_ERR
      #END IF
   
      CALL sadzp060_2_get_curr_ver_info(gr_dzaq.dzaq012, "M", gr_dzaq.dzaq013) RETURNING lo_std_dzaf.*,ls_err_msg
      IF NOT cl_null(ls_err_msg) THEN
         RETURN FALSE,ls_err_msg,lo_std_dzaf.*
      END IF

      LET lb_ver_same = TRUE
      IF lo_std_dzaf.dzaf002<>gr_dzaq.dzaq007 THEN #檢查建構版次
         LET lb_ver_same = FALSE
         LET ls_diff_kind = "CONS"
         LET li_dzaq_ver = gr_dzaq.dzaq007
         LET li_dzaf_ver = lo_std_dzaf.dzaf002
      END IF

      IF lb_ver_same THEN
         IF lo_std_dzaf.dzaf003<>gr_dzaq.dzaq008 THEN #檢查規格版次
            LET lb_ver_same = FALSE
            LET ls_diff_kind = "SPEC"
            LET li_dzaq_ver = gr_dzaq.dzaq008
            LET li_dzaf_ver = lo_std_dzaf.dzaf003
         END IF
      END IF

      IF lb_ver_same THEN
         IF lo_std_dzaf.dzaf004<>gr_dzaq.dzaq009 THEN #檢查程式版次
            LET lb_ver_same = FALSE
            LET ls_diff_kind = "CODE"
            LET li_dzaq_ver = gr_dzaq.dzaq009
            LET li_dzaf_ver = lo_std_dzaf.dzaf004
         END IF
      END IF

      IF NOT lb_ver_same THEN
         LET ls_replace_arg = gr_dzaq.dzaq012,"|",ls_diff_kind,"|",li_dzaq_ver,"|",li_dzaf_ver
         LET ls_err_msg = cl_replace_err_msg(cl_getmsg("adz-00222", g_lang), ls_replace_arg)
   
         RETURN FALSE,ls_err_msg,lo_std_dzaf.*
      END IF
      #End:20160118 by Hiko
      #End:STD_LIST

      #Begin:160226-00009:簽出就不能執行同步.
      LET lo_program_info[1].pi_NAME = po_industry_dzaf.dzaf001 #程式代碼
      LET lo_program_info[1].pi_TYPE = po_industry_dzaf.dzaf005 #類別
      CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "SD") RETURNING lb_result,ls_owner
      IF lb_result THEN
         #Begin:160929-00037
         LET ls_err_code = "adz-01002" #注意:此程式狀態為簽出中。(詳細簽出記錄可透過設計器的下載工具adzp050查看ALM資訊)
         GOTO _RTN_ERR
         #End:160929-00037
      ELSE
         CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "PR") RETURNING lb_result,ls_owner
         IF lb_result THEN
            #Begin:160929-00037
            LET ls_err_code = "adz-01002" #注意:此程式狀態為簽出中。(詳細簽出記錄可透過設計器的下載工具adzp050查看ALM資訊)
            GOTO _RTN_ERR
            #End:160929-00037
         END IF
      END IF

      LET lb_result = FALSE #還原預設值.
      #End:160226-00009

      LET ls_trigger = "sadzp060_4_chk_data:判斷標準程式和行業程式是否為Free Style"
      #DISPLAY ls_trigger
      CALL sadzp169_02_chk_not_free_style(lo_std_dzaf.dzaf001, lo_std_dzaf.dzaf010) RETURNING lb_result,ls_err_msg
      CALL sadzp169_02_chk_not_free_style(g_prog, po_industry_dzaf.dzaf010) RETURNING lb_result2,ls_err_msg
      #IF (NOT lb_result) OR (NOT lb_result2) THEN
      IF lb_result<>lb_result2 THEN #160929-00037
         LET ls_err_code = "adz-00523" #只有標準與行業都不是Free Style或都是Free Style才可以執行行業同步.
         GOTO _RTN_ERR
      END IF

      RETURN TRUE,NULL,lo_std_dzaf.*

      LABEL _RTN_ERR :
         #INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = ls_err_code
         #LET g_errparam.extend = NULL
         #LET g_errparam.popup = TRUE #160929-00037
         #CALL cl_err()
         LET ls_err_msg = "ERROR:", cl_getmsg(ls_err_code, g_lang)
         RETURN FALSE,ls_err_msg,lo_std_dzaf.*
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      LET ls_err_msg = "ERROR : call sadzp060_4_chk_data error!",ls_err_msg
      DISPLAY ls_err_msg
      RETURN FALSE,ls_err_msg,lo_std_dzaf.*
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 執行規格/程式的sync
# Input parameter : po_prev_industry_dzaf 行業程式未簽出前的DZAF_T資料
# Return code     : BOOLEAN  TRUE:成功;FALSE:失敗
#                 : STRING   錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_4_start_sync(po_prev_industry_dzaf)
   DEFINE po_prev_industry_dzaf T_DZAF_T
   DEFINE ls_trigger    STRING,
          ls_trigger2   STRING,
          ls_sql        STRING,
          li_cnt        SMALLINT,
          lb_result     BOOLEAN,
          ls_info       STRING,
          ls_err_msg    STRING,
          ls_msg_replace STRING, #160929-00037
          lo_std_dzaf   T_DZAF_T,
          ls_run_cmd    STRING #2015/05/26 by Hiko 
   DEFINE lo_industry_dzaf T_DZAF_T, #2015/06/12 by Hiko
          l_new_dzaf002    LIKE dzaf_t.dzaf002 #2015/06/12 by Hiko

   TRY
      #Begin:2015/03/13 by Hiko
      CALL sadzp060_4_chk_data(po_prev_industry_dzaf.*) RETURNING lb_result,ls_err_msg,lo_std_dzaf.*
      IF NOT lb_result THEN
         RETURN lb_result,ls_err_msg
      END IF

      #Begin:2015/08/19 by Hiko:sadzp060_4_chk_data已經取得過,這邊多做了.
      #LET ls_trigger = "sadzp060_4_start_sync:判斷行業程式的同步狀況"
      #DISPLAY ls_trigger
      #CALL sadzp060_4_get_max_dzaq_t(g_prog) RETURNING lb_result
      #IF NOT lb_result THEN
      #   LET ls_err_msg = "sadzp060_4_get_max_dzaq_t ERROR.."
      #   RETURN FALSE,ls_err_msg
      #END IF
      #End:2015/08/19 by Hiko

      #Begin:20160118 by Hiko
      ##Begin:2015/06/12 by Hiko
      #IF gr_dzaq.dzaq010 CLIPPED='Y' THEN #此段在整批同步(dzaq010='N')時不會進入.
      #   LET ls_err_msg = "[INFO]",g_prog," has synchronoused!"
      #   DISPLAY ls_err_msg
      #   RETURN FALSE,ls_err_msg
      #END IF
      ##End:2015/06/12 by Hiko
      #End:20160118 by Hiko
 
      #Begin:2015/06/12 by Hiko:因為變成未簽出執行同步, 所以要自己長版次與設計資料樹.
      LET lo_industry_dzaf.* = po_prev_industry_dzaf.*
      LET l_new_dzaf002 = po_prev_industry_dzaf.dzaf002 + 1
      LET lo_industry_dzaf.dzaf002 = l_new_dzaf002
      LET lo_industry_dzaf.dzaf003 = po_prev_industry_dzaf.dzaf003 + 1
      LET lo_industry_dzaf.dzaf004 = po_prev_industry_dzaf.dzaf004 + 1

      LET li_cnt = 0
      SELECT COUNT(*) INTO li_cnt FROM dzaf_t
       WHERE dzaf001=lo_industry_dzaf.dzaf001 
         AND dzaf002=l_new_dzaf002
         AND dzaf005=lo_industry_dzaf.dzaf005
         AND dzaf010=lo_industry_dzaf.dzaf010

      IF li_cnt=0 THEN
         LET ls_sql = "INSERT INTO dzaf_t(dzaf001,dzaf002,dzaf003,dzaf004,dzaf005,",
                                         "dzaf006,dzaf007,dzaf008,dzaf009,dzaf010)",
                                 " VALUES(?,?,?,?,?,?,?,?,?,?)"
         PREPARE ins_dzaf_prep FROM ls_sql
         EXECUTE ins_dzaf_prep USING lo_industry_dzaf.dzaf001,lo_industry_dzaf.dzaf002,lo_industry_dzaf.dzaf003,lo_industry_dzaf.dzaf004,lo_industry_dzaf.dzaf005,
                                     lo_industry_dzaf.dzaf006,lo_industry_dzaf.dzaf007,lo_industry_dzaf.dzaf008,lo_industry_dzaf.dzaf009,lo_industry_dzaf.dzaf010 
         FREE ins_dzaf_prep
         LET ls_sql = NULL #20160118 by Hiko
      END IF

      #UI設計資料自己有控制Transaction, 而且都和設計器相關Table無關, 所以單獨執行.
      #解析4fd畫面成設計資料
      DISPLAY "sadzp060_4_sync_start : call sadzp168_3"
      CALL sadzp168_3(lo_industry_dzaf.dzaf006, g_prog, lo_industry_dzaf.dzaf003, lo_industry_dzaf.dzaf010) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN GOTO _RTN_ERR END IF

      #產生畫面資訊, 失敗沒關係.
      DISPLAY "sadzp060_4_sync_start : call sadzp168_4"
      CALL sadzp168_4(g_prog, lo_industry_dzaf.dzaf003, lo_industry_dzaf.dzaf010) RETURNING lb_result,ls_info
      IF NOT lb_result THEN
         DISPLAY "WARNING : ",ls_info
      END IF
      #End:2015/06/12 by Hiko

      #Begin:20160118 by Hiko:從底下sadzp060_4_sync_spec之前改在這邊處理, 可以避免sadzp168_xxx內有COMMIT的行為, 導致ROLLBACK不完整.
      #呼叫4fd sync
      LET ls_trigger = "sadzp060_4_sync_start : call sadzp168_8(",g_prog,",",lo_industry_dzaf.dzaf003,",",lo_std_dzaf.dzaf001,",",lo_std_dzaf.dzaf003,")" 
      DISPLAY ls_trigger
      CALL sadzp168_8(g_prog, lo_industry_dzaf.dzaf003, lo_std_dzaf.dzaf001, lo_std_dzaf.dzaf003) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN GOTO _RTN_ERR END IF
      #重新組合4fd
      LET ls_trigger = "sadzp060_4_sync_start : call sadzp168_5(",g_prog,",",lo_industry_dzaf.dzaf003,",",lo_industry_dzaf.dzaf010,", TRUE)"
      DISPLAY ls_trigger
      #忽略4fd編譯錯誤
      CALL sadzp168_5(g_prog, lo_industry_dzaf.dzaf003, lo_industry_dzaf.dzaf010, FALSE) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN GOTO _RTN_ERR END IF
      #End:20160118 by Hiko
  
      BEGIN WORK
      LET gb_trans_flag = TRUE
 
      #Begin:2015/06/12 by Hiko
      #建立規格樹
      DISPLAY "sadzp060_4_sync_start : call sadzp060_2_create_spec_structure"
      CALL sadzp060_2_create_spec_structure(g_prog, lo_industry_dzaf.*, po_prev_industry_dzaf.*) RETURNING ls_err_msg
      IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF

      #建立代碼樹,Section樹
      DISPLAY "sadzp060_4_sync_start : call sadzp060_2_create_code_structure"
      CALL sadzp060_2_create_code_structure(g_prog, lo_industry_dzaf.*, po_prev_industry_dzaf.*) RETURNING ls_err_msg
      IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF
      #End:2015/06/12 by Hiko

      #20160118 by Hiko
      #DELETE FROM dzar_t WHERE dzar001=g_prog #TARGET:不呼叫show_sync_data #STD_LIST:已經先呼叫show_sync_data,所以這裡就不需要做, 要不然會沒有資料.#2015/03/10 by Hiko:同步前先清空dzar_t(行業資料同步清單)

      #呼叫規格sync
      LET ls_trigger = "sadzp060_4_sync_start : call sadzp060_4_sync_spec"
      DISPLAY ls_trigger
      LET g_revision = lo_industry_dzaf.dzaf003
      CALL sadzp060_4_sync_spec("SYNC", lo_std_dzaf.*, lo_industry_dzaf.*) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN GOTO _RTN_ERR END IF
   
      #4.呼叫程式sync
      LET ls_trigger = "sadzp060_4_sync_start : call sadzp060_4_sync_addpoint"
      DISPLAY ls_trigger
      LET g_revision = lo_industry_dzaf.dzaf004 
      CALL sadzp060_4_sync_addpoint("SYNC", lo_std_dzaf.*, lo_industry_dzaf.*) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN GOTO _RTN_ERR END IF
  
      #將sync紀錄表的欄位[同步否]更新為'Y'.這邊就算失敗,也不影響sync結果,但還是要顯現有錯誤.
      LET ls_trigger = "sadzp060_4_sync_start : call sadzp060_4_upd_dzaq_t"
      DISPLAY ls_trigger
      #CALL sadzp060_4_upd_dzaq_t(po_prev_industry_dzaf.*) RETURNING lb_result,ls_err_msg #2015/07/03 by Hiko
      CALL sadzp060_4_upd_dzaq_t(lo_industry_dzaf.*) RETURNING lb_result,ls_err_msg #20160118 by Hiko:改成顯現同步後的行業版次
      IF NOT lb_result THEN 
         DISPLAY ls_err_msg
      END IF

      COMMIT WORK
 
      #程式重新產生與組合
      LET ls_trigger = "sadzp060_4_sync_start : call sadzp060_2_rc3"
      DISPLAY ls_trigger
      #Begin:20160118 by Hiko:r.c3會自己印出訊息
      #CALL sadzp060_2_rc3(g_prog, lo_industry_dzaf.*, '1') RETURNING lb_result,ls_err_msg
      CALL sadzp060_2_rc3(g_prog, lo_industry_dzaf.*, '0') RETURNING lb_result,ls_err_msg
      #IF NOT lb_result THEN 
      #   #以sync來說,r.c3的出錯機率相對比較高,因此這邊有錯誤,也算是sync成功了.所以只需要印出錯誤訊息即可.
      #   DISPLAY "sadzp060_4_start_sync gen 4gl failure!",ls_err_msg
      #END IF
      #End:20160118 by Hiko

      #Begin:160929-00037:檢查標準或行業是否解開Section.
      LET ls_sql = "SELECT COUNT(*) FROM dzbc_t",
                   " WHERE dzbc001='",lo_std_dzaf.dzaf001,"'",
                   "   AND dzbc002=",lo_std_dzaf.dzaf004,
                   "   AND dzbc005='m'",
                   "   AND dzbcstus='Y'"
      PREPARE dzbc_std_prep FROM ls_sql
      EXECUTE dzbc_std_prep INTO li_cnt
      FREE dzbc_std_prep
      IF li_cnt>0 THEN
         LET ls_msg_replace = lo_std_dzaf.dzaf001
      END IF

      LET ls_sql = "SELECT COUNT(*) FROM dzbc_t",
                   " WHERE dzbc001='",lo_industry_dzaf.dzaf001,"'",
                   "   AND dzbc002=",lo_industry_dzaf.dzaf004,
                   "   AND dzbc005='m'",
                   "   AND dzbcstus='Y'"
      PREPARE dzbc_ind_prep FROM ls_sql
      EXECUTE dzbc_ind_prep INTO li_cnt
      FREE dzbc_ind_prep
      IF li_cnt>0 THEN
         IF NOT cl_null(ls_msg_replace) THEN
            LET ls_msg_replace = ls_msg_replace,","
         END IF

         LET ls_msg_replace = ls_msg_replace,lo_industry_dzaf.dzaf001
      END IF

      IF NOT cl_null(ls_msg_replace) THEN
         #adz-00905:行業add-point已經同步完畢, 我們偵測到 %1 為解開Section的狀態, 請自行比對標準與行業程式的差異來進行追單.
         LET ls_err_msg = cl_replace_err_msg(cl_getmsg("adz-00905", g_lang), ls_msg_replace)
         RETURN TRUE,ls_err_msg
      END IF
      #End:160929-00037

      DISPLAY "sadzp060_4_start_sync finish!"

      RETURN TRUE,NULL
   CATCH
      GOTO _RTN_ERR
   END TRY

   LABEL _RTN_ERR : #和CATCH相同
      IF gb_trans_flag THEN
         ROLLBACK WORK #除了dzaf_t外, 其他設計資料都會ROLLBACK.
         #Begin:20160118 by Hiko:從下方搬上來
         DISPLAY "sadzp060_4_sync_start : RTN_ERR : delete dzaf_t"
         #Begin:2015/06/12 by Hiko:刪除新版dzaf_t
         DELETE FROM dzaf_t 
          WHERE dzaf001=lo_industry_dzaf.dzaf001 
            AND dzaf002=l_new_dzaf002
            AND dzaf005=lo_industry_dzaf.dzaf005
            AND dzaf010=lo_industry_dzaf.dzaf010
         #End:2015/06/12 by Hiko
         #End:20160118 by Hiko
      END IF
      
      #重新組合前版4fd:有錯誤也沒關係
      LET ls_trigger2 = "sadzp060_4_sync_start : RTN_ERR : 行業同步失敗 : call sadzp168_5(",g_prog,",",po_prev_industry_dzaf.dzaf003,",",po_prev_industry_dzaf.dzaf010,", FALSE)"
      DISPLAY ls_trigger2
      CALL sadzp168_5(g_prog, po_prev_industry_dzaf.dzaf003, po_prev_industry_dzaf.dzaf010, FALSE) RETURNING lb_result,ls_err_msg
      
      #前版程式重新產生與組合:有錯誤也沒關係
      LET ls_trigger2 = "sadzp060_4_sync_start : RTN_ERR : call sadzp060_2_rc3"
      DISPLAY ls_trigger2
      #CALL sadzp060_2_rc3(g_prog, po_prev_industry_dzaf.*, '1') RETURNING lb_result,ls_err_msg
      CALL sadzp060_2_rc3(g_prog, po_prev_industry_dzaf.*, '0') RETURNING lb_result,ls_err_msg #20160118 by Hiko

      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)

      RETURN FALSE,ls_err_msg
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:spec
# Input parameter : ps_act 執行動作(QUERY:查詢/SYNC:同步)
#                 : po_std_dzaf 標準dzaf_t資料
#                 : po_industry_dzaf 行業dzaf_t資料
# Return code     : STRING 錯誤訊息(NULL表示成功)
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_spec(ps_act, po_std_dzaf, po_industry_dzaf)
   DEFINE ps_act           STRING, #2015/03/13 by Hiko
          po_std_dzaf      T_DZAF_T,
          po_industry_dzaf T_DZAF_T
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_where   STRING,
          li_i       SMALLINT
   DEFINE dzaa_std_arr DYNAMIC ARRAY OF RECORD LIKE dzaa_t.*,
          li_cnt SMALLINT
   DEFINE lb_result  BOOLEAN,
          ls_err_msg STRING
   #Begin:STD_LIST
   DEFINE li_idx     SMALLINT,
          l_revision LIKE dzaa_t.dzaa004,
          l_cite     LIKE dzaa_t.dzaa007
   #End:STD_LIST
   #Begin:20160118 by Hiko
   DEFINE li_ind_ver       SMALLINT,
          li_curr_ver_flag SMALLINT 
   #End:20160118 by Hiko

   #需要同步的規格內容有:dzaa005=
   #1.欄位規格
   #2.Action規格
   #3.整體規格
   #5.樹狀結構
   #6.欄位參考
   #7.資料多語言

   TRY
      LET lb_result = TRUE #STD_LIST
      
      LET ls_trigger = "sadzp060_4_sync_spec : prepare sync source data..."
      DISPLAY ls_trigger
      
      LET ls_sql = "SELECT aa1.* FROM dzaa_t aa1",
                   " WHERE aa1.dzaa001='",po_std_dzaf.dzaf001,"'",   #標準規格代號
                   "   AND aa1.dzaa002=",po_std_dzaf.dzaf003         #標準規格版次
      #Begin:STD_LIST
      #IF ps_act.equals("QUERY") THEN #TARGET_LIST
         #DZAQ001    DZAQ004 DZAQ005 DZAQ006 DZAQ007 DZAQ008 DZAQ009 DZAQ010 DZAQ012
         #aiti777_ph 1       1       1       3       2       3       Y       aiti777
         #aiti777_ph 2       2       2       4       3       4       Y       aiti777
         #aiti777_ph 2       2       2       5       4       4       N       aiti777
         #aiti777_ph 3       3       3       6       4       5       Y       aiti777
         #aiti777_ph 5       3       5       7       4       6       N       aiti777
         #aiti777_ph 6       4       6       8       4       7       Y       aiti777

         #取得要更新的標準程式版次資料
         #Begin:20160118 by Hiko
         #LET ls_sql = ls_sql,
         #             " AND aa1.dzaa004 >= (SELECT NVL((SELECT MAX(aq2.dzaq008)+1", #dzaq008+1是因為要從還未同步過的資料往後推.
         #                                   "             FROM dzaq_t aq2",
         #                                   "            WHERE aq2.dzaq012=aa1.dzaa001",
         #                                   "              AND aq2.dzaq007<",po_std_dzaf.dzaf002, #標準程式建構版次
         #                                   "              AND aq2.dzaq010='Y'),",
         #                                   "          (SELECT MIN(aq3.dzaq008)",   #有可能因為從來沒有同步會找不到資料(正常來說不可能),所以才要防呆.
         #                                   "             FROM dzaq_t aq3",
         #                                   "            WHERE aq3.dzaq012=aa1.dzaa001",
         #                                   "              AND aq3.dzaq007<",po_std_dzaf.dzaf002, #標準程式建構版次
         #                                   "              AND aq3.dzaq010='N'))",
         #                                   " FROM dual)"
         #End:20160118 by Hiko
      #END IF
      #End:STD_LIST
      LET ls_sql = ls_sql,
                   #"   AND aa1.dzaa005 IN('1','2','3','5','6','7')", #需要同步的類型 #TARGET_LIST:dzag_t/dzfs_t和dzam_t都需要複製
                   "   AND aa1.dzaa009='",po_std_dzaf.dzaf010,"'",   #客製識別碼:s
                   "   AND (   aa1.dzaa003 IN (",                    #取得需要更新的spec
                   "           SELECT aa2.dzaa003 FROM dzaa_t aa2", 
                   "            WHERE aa2.dzaa001='",g_prog,"'",     #行業規格代號:和sadzi888_07不同
                   "              AND aa2.dzaa002=",g_revision,      #行業規格版次
                   "              AND aa2.dzaa005=aa1.dzaa005",      
                   "              AND aa2.dzaa007='Y'",              #只需要更改設定為引用的spec
                   "              AND aa2.dzaa009='",po_industry_dzaf.dzaf010,"')", #客製識別碼:s:故意不寫死,想確認資料正確性
                   "        OR aa1.dzaa003 IN (",                    
                   "           SELECT aa2.dzaa003 FROM dzaa_t aa2", 
                   "            WHERE aa2.dzaa001='",g_prog,"'",     
                   "              AND aa2.dzaa002=",g_revision,     
                   "              AND aa2.dzaa005=aa1.dzaa005",      
                   "              AND aa2.dzaa003 IN ('TABLE','EXCLUDE')", #TARGET_LIST:取得dzag_t/dzfs_t和dzam_t的資料
                   "              AND aa2.dzaa009='",po_industry_dzaf.dzaf010,"')", 
                   "        OR aa1.dzaa003 NOT IN (",              #取得標準多於行業的spec
                   "           SELECT aa3.dzaa003 FROM dzaa_t aa3",
                   "            WHERE aa3.dzaa001='",g_prog,"'",     
                   "              AND aa3.dzaa002=",g_revision,    
                   "              AND aa3.dzaa005=aa1.dzaa005",      
                   "              AND aa3.dzaa009='",po_industry_dzaf.dzaf010,"')",
                   "       )",
                   #" ORDER BY aa1.dzaa002,aa1.dzaa003" #TARGET_LIST:同名但不同版次的設計資料,後面的設定會蓋過前面的設定.
                   " ORDER BY aa1.dzaa003" #TARGET_LIST:同名但不同版次的設計資料,後面的設定會蓋過前面的設定. #20160118 by Hiko
      DISPLAY "DEBUG:sadzp060_4_sync_spec ls_sql=",ls_sql
      PREPARE dzaa_std_prep FROM ls_sql
      DECLARE dzaa_std_curs CURSOR FOR dzaa_std_prep
      OPEN dzaa_std_curs 
      LET ls_sql = NULL #20160118 by Hiko

      LET li_i = 1
      FOREACH dzaa_std_curs INTO dzaa_std_arr[li_i].*
         LET l_cite = "Y"
         #Begin:STD_LIST:這是為了更新時可以精準知道哪些資料是要真正新增行業資源池.
         #IF ps_act.equals("QUERY") THEN #TARGET_LIST
            #LET ga_std_dzaa[li_i].* = dzaa_std_arr[li_i].* #TARGET_LIST

            #Begin:20160118 by Hiko
            #Begin:2015/03/13 by Hiko
            #STD_LIST:因為執行start_sync的時候會呼叫show_sync_data,所以新增dzar_t就只需要執行一次即可. #TARGET_LIST:已經不呼叫因為執行start_sync的時候會呼叫show_sync_data了
            #CASE dzaa_std_arr[li_i].dzaa005
            #   WHEN '1' CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzac_t")
            #            #Begin:STD_LIST:標準有dzak_t,dzal_t才需要同時寫入dzar_t內.
            #            LET ls_sql = "SELECT COUNT(*) FROM dzak_t",
            #                         " WHERE dzak001='",dzaa_std_arr[li_i].dzaa001,"'",
            #                         "   AND dzak002='",dzaa_std_arr[li_i].dzaa003,"'",
            #                         "   AND dzak003=",dzaa_std_arr[li_i].dzaa004,
            #                         "   AND dzak004='",dzaa_std_arr[li_i].dzaa006,"'" 
            #            PREPARE dzak_cus_prep1 FROM ls_sql
            #            EXECUTE dzak_cus_prep1 INTO li_cnt
            #            FREE dzak_cus_prep1
            #            IF li_cnt>0 THEN
            #               CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzak_t")
            #            END IF
            #
            #            LET ls_sql = "SELECT COUNT(*) FROM dzal_t",
            #                         " WHERE dzal001='",dzaa_std_arr[li_i].dzaa001,"'",
            #                         "   AND dzal005='",dzaa_std_arr[li_i].dzaa003,"'",
            #                         "   AND dzal003=",dzaa_std_arr[li_i].dzaa004,
            #                         "   AND dzal004='",dzaa_std_arr[li_i].dzaa006,"'" 
            #            PREPARE dzal_cus_prep1 FROM ls_sql
            #            EXECUTE dzal_cus_prep1 INTO li_cnt
            #            FREE dzal_cus_prep1
            #            IF li_cnt>0 THEN
            #               CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzal_t")
            #            END IF
            #            #End:STD_LIST
            #   WHEN '2' CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzad_t")
            #   WHEN '3' CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzab_t")
            #   WHEN '4' CALL sadzp060_4_multi_dzar_t(dzaa_std_arr[li_i].*, po_industry_dzaf.*)
            #            LET l_cite = "N"
            #   WHEN '5' CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzff_t")
            #   WHEN '6' CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzai_t")
            #   WHEN '7' CALL sadzp060_4_spec_dzar_t(dzaa_std_arr[li_i].*, "dzaj_t")
            #   WHEN 'a' CALL sadzp060_4_multi_dzar_t(dzaa_std_arr[li_i].*, po_industry_dzaf.*) #只會執行一次
            #            LET l_cite = "N"
            #END CASE
            CASE dzaa_std_arr[li_i].dzaa005
               WHEN '4' CALL sadzp060_4_prepare_dzag_t(dzaa_std_arr[li_i].*, po_industry_dzaf.*)
                        LET l_cite = "N"
               WHEN 'a' CALL sadzp060_4_prepare_dzam_t(dzaa_std_arr[li_i].*, po_industry_dzaf.*)
                        LET l_cite = "N"
            END CASE
            #End:20160118 by Hiko
         #END IF
         #End:STD_LIST
         #End:2015/03/13 by Hiko

         #Begin:20160118 by Hiko
         LET l_revision = g_revision #預設版次

         LET ls_where = "     dzaa001='",g_prog,"'",
                        " AND dzaa002=",g_revision,
                        " AND dzaa003='",dzaa_std_arr[li_i].dzaa003,"'",
                        " AND dzaa009='",po_industry_dzaf.dzaf010,"'" #s

         #查看行業樹是否存在要更新的標準識別碼.
         LET ls_trigger = "sadzp060_4_sync_spec : get sync target : ",dzaa_std_arr[li_i].dzaa003
         #DISPLAY ls_trigger
         LET li_cnt = 0
         LET ls_sql = "SELECT COUNT(*) FROM dzaa_t WHERE ",ls_where
         
         PREPARE dzaa_cus_prep1 FROM ls_sql
         EXECUTE dzaa_cus_prep1 INTO li_cnt
         FREE dzaa_cus_prep1

         IF li_cnt>0 THEN 
            LET ls_sql = "SELECT dzaa004 FROM dzaa_t WHERE",ls_where
            PREPARE dzaa_prep9 FROM ls_sql
            EXECUTE dzaa_prep9 INTO li_ind_ver
            FREE dzaa_prep9
         END IF

         #判斷dzau_t的版次資訊來決定是否需要異動樹頭的使用版次.
         LET li_curr_ver_flag = 0
         LET ls_sql = NULL
         LET ls_sql = "SELECT COUNT(*) FROM dzau_t",
                      " WHERE dzau001='",g_prog,"'", #這裡是行業程式代號, 不要搞錯.
                      "   AND dzau003='",dzaa_std_arr[li_i].dzaa003,"'", #這裡是標準識別碼
                      "   AND dzau004=",dzaa_std_arr[li_i].dzaa004       #這裡是標準識別碼版次
         PREPARE dzau_cus_prep1 FROM ls_sql
         EXECUTE dzau_cus_prep1 INTO li_curr_ver_flag
         FREE dzau_cus_prep1

         IF li_curr_ver_flag>0 THEN #表示只需要更新內容, 但使用版次維持.
            LET l_revision = li_ind_ver
         END IF
         #End:20160118 by Hiko

         IF ps_act.equals("SYNC") THEN
            IF li_cnt>0 THEN 
               #LET l_revision = g_revision #維持local變數會比較容易還原 #20160118 by Hiko

               LET ls_trigger = "sadzp060_4_sync_spec : UPDATE..."
              #DISPLAY ls_trigger
               
               #修改一定是標準識別碼更新到行業樹內,所以皆以標準資料為主.
               LET ls_sql = "UPDATE dzaa_t SET dzaa004=",l_revision,",",                     #識別碼版次
                                              "dzaa007='",l_cite,"',",                       #引用
                                              "dzaastus='",dzaa_std_arr[li_i].dzaastus,"',", #生失效 
                                              "dzaamoddt=?,",
                                              "dzaamodid='",g_user,"'",
                            " WHERE ",ls_where
               PREPARE dzaa_cus_prep2 FROM ls_sql
               EXECUTE dzaa_cus_prep2 USING g_date
               FREE dzaa_cus_prep2
               LET ls_sql = NULL #20160118 by Hiko
            ELSE 
               #LET l_revision = g_revision #STD_LIST #20160118 by Hiko
               IF dzaa_std_arr[li_i].dzaastus<>"N" THEN #sync的時候,找不到行業樹內容,則標準失效的資料不需要新增進來,以免多垃圾.
                  LET ls_trigger = "sadzp060_4_sync_spec : INSERT..."
                 #DISPLAY ls_trigger
                  #新增一定是標準多餘行業的識別碼,所以皆以標準資料為主.
                  LET ls_sql = "INSERT INTO dzaa_t(dzaa001,dzaa002,dzaa003,dzaa004,dzaa005,",
                                                  "dzaa006,dzaa007,dzaa008,dzaa009,dzaa010,",
                                                  "dzaacrtdt,dzaacrtdp,dzaaowndp,dzaaownid,dzaastus,dzaacrtid)",
                                       "VALUES( '",g_prog,"',",
                                                   l_revision,",",                #dzaa002:行業版次
                                               "'",dzaa_std_arr[li_i].dzaa003,"',",
                                                   g_revision,",",                #dzaa004
                                               "'",dzaa_std_arr[li_i].dzaa005,"',",
                                               "'",dzaa_std_arr[li_i].dzaa006,"',",
                                               "   '",l_cite,"',",                #dzaa007:引用
                                               "'",dzaa_std_arr[li_i].dzaa008,"',",
                                               "'",po_industry_dzaf.dzaf010,"',", #s:客製標示
                                               "'",dzaa_std_arr[li_i].dzaa010,"',",
                                               "   ?,",                           #dzaacrtdt
                                               "'",g_dept CLIPPED,"',",           #dzaacrtdp
                                               "'",g_dept CLIPPED,"',",           #dzaaowndp
                                               "'",g_user,"',",                   #dzaaownid
                                               "'",dzaa_std_arr[li_i].dzaastus,"',",
                                               "'",g_user,"')"                    #dzaaownid
                  PREPARE dzaa_cus_prep3 FROM ls_sql
                  EXECUTE dzaa_cus_prep3 USING g_date
                  FREE dzaa_cus_prep3
                  LET ls_sql = NULL #20160118 by Hiko
               END IF
            END IF
        
            CASE dzaa_std_arr[li_i].dzaa005
               WHEN '1' CALL sadzp060_4_sync_dzac(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
                        #Begin:20160118 by Hiko
                        IF NOT lb_result THEN
                           EXIT FOREACH
                        END IF

                        CALL sadzp060_4_sync_dzak(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
                        IF NOT lb_result THEN
                           EXIT FOREACH
                        END IF
                        #End:20160118 by Hiko
                        CALL sadzp060_4_sync_dzal(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN '2' CALL sadzp060_4_sync_dzad(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN '3' CALL sadzp060_4_sync_dzab(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN '4' CALL sadzp060_4_sync_dzag(po_industry_dzaf.*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN '5' CALL sadzp060_4_sync_dzff(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN '6' CALL sadzp060_4_sync_dzai(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN '7' CALL sadzp060_4_sync_dzaj(dzaa_std_arr[li_i].*, l_revision) RETURNING lb_result,ls_err_msg
               WHEN 'a' CALL sadzp060_4_sync_dzam(l_revision) RETURNING lb_result,ls_err_msg
            END CASE
            
            IF NOT lb_result THEN
               EXIT FOREACH
            END IF
         END IF #ps_act.equals("SYNC")

         LET li_i = li_i + 1
      END FOREACH
      
      DISPLAY "sadzp060_4_sync_spec : finish! : 總共同步 ",(li_i-1)," 筆規格資料"

      #Begin:20161118 by Hiko : 最後再將標準dzba_t的資料寫入dzau_t內.
      LET ls_trigger = "sadzp060_4_sync_addpoint : delete dzau_t"
      DELETE FROM dzau_t WHERE dzau001=g_prog

      LET ls_trigger = "sadzp060_4_sync_addpoint : insert dzau_t"
      LET ls_sql = "INSERT INTO dzau_t(dzau001,dzau003,dzau004,dzau005)",
                   " SELECT '",g_prog,"',dzaa003,dzaa004,dzaa005 FROM dzaa_t",
                   "  WHERE dzaa001='",po_std_dzaf.dzaf001,"'",
                   "    AND dzaa002=",po_std_dzaf.dzaf003
      PREPARE dzau_prep2 FROM ls_sql
      EXECUTE dzau_prep2
      FREE dzau_prep2
      #DISPLAY "insert dzau_t:",ls_sql
      #End:20161118 by Hiko

      RETURN lb_result,ls_err_msg
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_spec error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業程式:add point
# Input parameter : ps_act 執行動作(QUERY:查詢/SYNC:同步)
#                 : po_std_dzaf 標準dzaf_t資料
#                 : po_industry_dzaf 行業dzaf_t資料
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_addpoint(ps_act, po_std_dzaf, po_industry_dzaf)
   DEFINE ps_act           STRING, #2015/03/13 by Hiko
          po_std_dzaf      T_DZAF_T,
          po_industry_dzaf T_DZAF_T
   DEFINE ls_trigger    STRING,
          ls_sql        STRING,
          ls_wc         STRING,
          ls_where      STRING, 
          ls_ind_where  STRING, 
          li_i          SMALLINT
   DEFINE dzba_std_arr  DYNAMIC ARRAY OF RECORD LIKE dzba_t.*,
          li_cnt        SMALLINT,
          l_dzbb098     LIKE dzbb_t.dzbb098, 
          l_ind_dzbb098 LIKE dzbb_t.dzbb098 
   DEFINE ls_err_msg STRING
   #Begin:STD_LIST
   DEFINE li_idx     SMALLINT,
          l_revision LIKE dzba_t.dzba004
   #End:STD_LIST
   #Begin:20160118 by Hiko
   DEFINE li_ind_ver       SMALLINT,
          li_curr_ver_flag SMALLINT
   #End:20160118 by Hiko

   TRY
      #底下和sadzi888_07雷同
      LET ls_trigger = "sadzp060_4_sync_addpoint : prepare sync source data..."
      #DISPLAY ls_trigger
      LET ls_sql = "SELECT ba1.* FROM dzba_t ba1",
                   " WHERE ba1.dzba001='",po_std_dzaf.dzaf001,"'", #標準程式代號
                   "   AND ba1.dzba002=",po_std_dzaf.dzaf004       #標準程式版次
      #Begin:STD_LIST
      #IF ps_act.equals("QUERY") THEN #TARGET_LIST
         #DZAQ001    DZAQ004 DZAQ005 DZAQ006 DZAQ007 DZAQ008 DZAQ009 DZAQ010 DZAQ012
         #aiti777_ph 1       1       1       3       2       3       Y       aiti777
         #aiti777_ph 2       2       2       4       3       4       Y       aiti777
         #aiti777_ph 2       2       2       5       4       4       N       aiti777
         #aiti777_ph 3       3       3       6       4       5       Y       aiti777
         #aiti777_ph 5       3       5       7       4       6       N       aiti777
         #aiti777_ph 6       4       6       8       4       7       Y       aiti777

         #取得要更新的標準程式版次資料
         #Begin:20160118 by Hiko
         #LET ls_sql = ls_sql,
         #             " AND ba1.dzba004 >= (SELECT NVL((SELECT MAX(aq2.dzaq009)+1",
         #                                   "             FROM dzaq_t aq2",
         #                                   "            WHERE aq2.dzaq012=ba1.dzba001",
         #                                   "              AND aq2.dzaq007<",po_std_dzaf.dzaf002, #標準程式建構版次
         #                                   "              AND aq2.dzaq010='Y'),",
         #                                   "          (SELECT MIN(aq3.dzaq009)",
         #                                   "             FROM dzaq_t aq3",
         #                                   "            WHERE aq3.dzaq012=ba1.dzba001",
         #                                   "              AND aq3.dzaq007<",po_std_dzaf.dzaf002, #標準程式建構版次
         #                                   "              AND aq3.dzaq010='N'))",
         #                                   " FROM dual)"
         #End:20160118 by Hiko
      #END IF
      #End:STD_LIST
      LET ls_sql = ls_sql,
                   "   AND ba1.dzba010='",po_std_dzaf.dzaf010,"'", #客製識別碼:s
                   "   AND (   ba1.dzba003 IN (",                  #取得需要更新的add point
                   "           SELECT ba2.dzba003 FROM dzba_t ba2",
                   "            WHERE ba2.dzba001='",g_prog,"'",   #行業程式代號:和sadzi888_07不同
                   "              AND ba2.dzba002=",g_revision,    #行業程式版次
                   "              AND ba2.dzba007='Y'",            #只需要更改設定為引用的add point:和sadzi888_07不同
                   "              AND ba2.dzba010='",po_industry_dzaf.dzaf010,"')", #客製識別碼:s
                   "        OR ba1.dzba003 NOT IN (",              #取得標準多於行業的add point
                   "           SELECT ba3.dzba003 FROM dzba_t ba3",
                   "            WHERE ba3.dzba001='",g_prog,"'",   
                   "              AND ba3.dzba002=",g_revision,    
                   "              AND ba3.dzba010='",po_industry_dzaf.dzaf010,"')", 
                   "       )",
                   #" ORDER BY ba1.dzba002,ba1.dzba003"  #TARGET_LIST:同名但不同版次的設計資料,後面的設定會蓋過前面的設定.
                   " ORDER BY ba1.dzba003"  #TARGET_LIST:同名但不同版次的設計資料,後面的設定會蓋過前面的設定. #20160118 by Hiko
      
      #DISPLAY "DEBUG:sadzp060_4_sync_addpoint ls_sql=",ls_sql
      PREPARE dzba_std_prep FROM ls_sql
      DECLARE dzba_std_curs CURSOR FOR dzba_std_prep
      OPEN dzba_std_curs 
      LET ls_sql = NULL #20160118 by Hiko

      LET li_i = 1
      FOREACH dzba_std_curs INTO dzba_std_arr[li_i].*
         #Begin:20160118 by Hiko
         LET l_revision = g_revision

         LET ls_ind_where = "     dzba001='",g_prog,"'",
                            " AND dzba002=",g_revision,
                            " AND dzba003='",dzba_std_arr[li_i].dzba003,"'",
                            " AND dzba010='",po_industry_dzaf.dzaf010,"'" #s

         #查看行業樹是否存在要更新的標準識別碼.
         LET ls_trigger = "sadzp060_4_sync_addpoint : get sync target : ",dzba_std_arr[li_i].dzba003
         #DISPLAY ls_trigger
         LET li_cnt = 0
         LET ls_sql = "SELECT COUNT(*) FROM dzba_t WHERE ",ls_ind_where
         PREPARE dzba_cus_prep1 FROM ls_sql
         EXECUTE dzba_cus_prep1 INTO li_cnt
         FREE dzba_cus_prep1

         IF li_cnt>0 THEN 
            LET ls_sql = "SELECT dzba004 FROM dzba_t WHERE",ls_ind_where
            PREPARE dzba_prep9 FROM ls_sql
            EXECUTE dzba_prep9 INTO li_ind_ver
            FREE dzba_prep9
         END IF

         #判斷dzbu_t的版次資訊來決定是否需要異動樹頭的使用版次.
         LET li_curr_ver_flag = 0
         LET ls_sql = NULL 
         LET ls_sql = "SELECT COUNT(*) FROM dzbu_t",
                      " WHERE dzbu001='",g_prog,"'", #這裡是行業程式代號, 不要搞錯.
                      "   AND dzbu003='",dzba_std_arr[li_i].dzba003,"'", #這裡是標準識別碼
                      "   AND dzbu004=",dzba_std_arr[li_i].dzba004      #這裡是標準識別碼版次
         PREPARE dzbu_cus_prep1 FROM ls_sql
         EXECUTE dzbu_cus_prep1 INTO li_curr_ver_flag
         FREE dzbu_cus_prep1

         IF li_curr_ver_flag>0 THEN #表示只需要更新內容, 但使用版次維持.
            LET l_revision = li_ind_ver
         END IF
         #End:20160118 by Hiko

         IF ps_act.equals("SYNC") THEN #2015/03/13 by Hiko
            IF li_cnt>0 THEN 
               #LET l_revision = g_revision #維持local變數會比較容易還原 #20160118 by Hiko

               LET ls_trigger = "sadzp060_4_sync_addpoint : UPDATE..."
               #DISPLAY ls_trigger

               #修改一定是標準識別碼更新到行業樹內,所以皆以標準資料為主.
               LET ls_sql = "UPDATE dzba_t SET dzba004=",l_revision,",",                     #設計點版次
                                              "dzba007='Y',",                                #引用
                                              "dzbastus='",dzba_std_arr[li_i].dzbastus,"',", #生失效 
                                              "dzbamoddt=?,",
                                              "dzbamodid='",g_user,"'",
                           " WHERE ",ls_ind_where
               PREPARE dzba_cus_prep2 FROM ls_sql
               EXECUTE dzba_cus_prep2 USING g_date
               FREE dzba_cus_prep2
               LET ls_sql = NULL #20160118 by Hiko
            ELSE 
               #LET l_revision = g_revision #STD_LIST #20160118 by Hiko
               IF dzba_std_arr[li_i].dzbastus<>"N" THEN #sync的時候,找不到行業樹內容,則標準失效的資料不需要新增進來,以免多垃圾.
                  LET ls_trigger = "sadzp060_4_sync_addpoint : INSERT..."
                  #DISPLAY ls_trigger
                  #新增一定是標準多餘行業的識別碼,所以皆以標準資料為主.
                  LET ls_sql = "INSERT INTO dzba_t(dzba001,dzba002,dzba003,dzba004,dzba005,",
                                                  "dzba006,dzba007,dzba008,dzba009,dzba010,dzba011,",
                                                  "dzbacrtdt,dzbacrtdp,dzbaowndp,dzbaownid,dzbastus,dzbacrtid)",
                                       "VALUES( '",g_prog,"',",
                                                   l_revision,",",                #dzba002:行業版次
                                               "'",dzba_std_arr[li_i].dzba003,"',",
                                                   g_revision,",",                #dzba004
                                               "'",dzba_std_arr[li_i].dzba005,"',",
                                               "   ?,",                           #dzba006
                                               "   'Y',",                         #dzba007:引用
                                               "'",dzba_std_arr[li_i].dzba008,"',",
                                               "'",dzba_std_arr[li_i].dzba009,"',",
                                               "'",po_industry_dzaf.dzaf010,"',", #s:客製標示
                                               "'",dzba_std_arr[li_i].dzba011,"',",
                                               "   ?,",                           #dzbacrtdt
                                               "'",g_dept CLIPPED,"',",           #dzbacrtdp
                                               "'",g_dept CLIPPED,"',",           #dzbaowndp
                                               "'",g_user,"',",                   #dzbaownid
                                               "'",dzba_std_arr[li_i].dzbastus,"',",
                                               "'",g_user,"')"                    #dzbaownid
                  PREPARE dzba_cus_prep3 FROM ls_sql
                  EXECUTE dzba_cus_prep3 USING dzba_std_arr[li_i].dzba006,g_date
                  FREE dzba_cus_prep3
                  LET ls_sql = NULL #20160118 by Hiko
               END IF
            END IF
         END IF #ps_act.equals("SYNC")

         LET ls_trigger = "sadzp060_4_sync_addpoint : 由標準的dzba_t查出標準的dzbb_t.dzbb098"
         #DISPLAY ls_trigger
         LOCATE l_dzbb098 IN FILE
         
         LET ls_wc = " AND dzbb002='",dzba_std_arr[li_i].dzba003,"'", #代碼設計點
                     " AND dzbb004='",dzba_std_arr[li_i].dzba005,"'"  #使用標示
         LET ls_where = " WHERE dzbb001='",dzba_std_arr[li_i].dzba001,"'", #標準程式代號
                        "   AND dzbb003=",dzba_std_arr[li_i].dzba004,ls_wc #標準程式設計點版次
         LET ls_sql = "SELECT dzbb098 FROM dzbb_t",ls_where
         PREPARE std_dzbb_prep1 FROM ls_sql
         EXECUTE std_dzbb_prep1 INTO l_dzbb098
         LET ls_sql = NULL #20160118 by Hiko
         FREE std_dzbb_prep1
         
         #Begin:2015/03/10 by Hiko:取得行業程式的dzbb_t.dzbb098
         LET ls_trigger = "sadzp060_4_sync_addpoint : 取得行業程式的dzbb_t.dzbb098"
         #DISPLAY ls_trigger
         LET ls_sql = "SELECT dzbb098 FROM dzbb_t",
                      " INNER JOIN dzba_t ON dzba001=dzbb001 AND dzba003=dzbb002 AND dzba004=dzbb003 AND dzba005=dzbb004",
                      " WHERE ",ls_ind_where
         #DISPLAY "dzbb098 ls_sql=",ls_sql
         LOCATE l_ind_dzbb098 IN FILE
         PREPARE ind_dzbb_prep1 FROM ls_sql
         EXECUTE ind_dzbb_prep1 INTO l_ind_dzbb098
         FREE ind_dzbb_prep1
         LET ls_sql = NULL #20160118 by Hiko

         #20160118 by Hiko
         #CALL sadzp060_4_code_dzar_t(dzba_std_arr[li_i].*, l_ind_dzbb098, l_dzbb098) #TARGET_LIST:start_sync不呼叫show_sync了.

         FREE l_ind_dzbb098
         #End:2015/03/10 by Hiko

         IF ps_act.equals("SYNC") THEN #2015/03/13 by Hiko
            #更新dzbb_t:此段和sadzp060_1雷同.      
            LET ls_trigger = "sadzp060_4_sync_addpoint : ",dzba_std_arr[li_i].dzba005," 檢查行業引用段的內容"
            #DISPLAY ls_trigger
            LET li_cnt = 0
            LET ls_where = " WHERE dzbb001='",g_prog,"'",     #行業程式代號
                           "   AND dzbb003=",l_revision,ls_wc #行業程式的程式版次:這樣才符合更新機制 #STD_LIST:g_revision改成l_revision
            LET ls_sql = "SELECT COUNT(*) FROM dzbb_t",ls_where
            PREPARE dzbb_prep1 FROM ls_sql
            EXECUTE dzbb_prep1 INTO li_cnt
            FREE dzbb_prep1
            LET ls_sql = NULL #20160118 by Hiko
            
            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp060_4_sync_addpoint : update dzbb_t data ",dzba_std_arr[li_i].dzba003
               #DISPLAY ls_trigger
               #更新dzbb005
               LET ls_sql = "UPDATE dzbb_t",
                              " SET dzbbstus='",dzba_std_arr[li_i].dzbastus CLIPPED,"',", 
                                   "dzbbmoddt=?,", 
                                   "dzbbmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp060_4_sync_addpoint : insert dzbb_t data ",dzba_std_arr[li_i].dzba003
               #DISPLAY ls_trigger
               LET ls_sql = "INSERT INTO dzbb_t(dzbb001,dzbb002,dzbb003,dzbb004,dzbb005,dzbb006,dzbb007,",
                                               "dzbbcrtdt,dzbbcrtdp,dzbbowndp,dzbbownid,dzbbstus,dzbbcrtid)",
                                       " VALUES('",g_prog,"','",dzba_std_arr[li_i].dzba003 CLIPPED,"',",l_revision,",'",g_env,"','",gs_customer,"','','',", 
                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",dzba_std_arr[li_i].dzbastus CLIPPED,"','",g_user,"')"
            END IF
            PREPARE dzbb_prep2 FROM ls_sql
            EXECUTE dzbb_prep2 USING g_date
            FREE dzbb_prep2
            LET ls_sql = NULL #20160118 by Hiko
             
            #更新程式代碼資料:上面就算是INSERT的動作,執行到此也是UPDATE.
            LET ls_trigger = "sadzp060_4_sync_addpoint : update dzbb_t data : dzbb098"
            #DISPLAY ls_trigger
            UPDATE dzbb_t 
               SET dzbb098=l_dzbb098
             WHERE dzbb001=g_prog
               AND dzbb002=dzba_std_arr[li_i].dzba003
               AND dzbb003=l_revision
               AND dzbb004=dzba_std_arr[li_i].dzba005 
         END IF #ps_act.equals("SYNC")

         FREE l_dzbb098

         LET li_i = li_i + 1
      END FOREACH
      
      DISPLAY "sadzp060_4_sync_addpoint : finish! : 總共同步 ",(li_i-1)," 筆程式資料"

      #Begin:20161118 by Hiko : 最後再將標準dzba_t的資料寫入dzbu_t內.
      LET ls_trigger = "sadzp060_4_sync_addpoint : delete dzbu_t"
      DELETE FROM dzbu_t WHERE dzbu001=g_prog

      LET ls_trigger = "sadzp060_4_sync_addpoint : insert dzbu_t"
      LET ls_sql = "INSERT INTO dzbu_t(dzbu001,dzbu003,dzbu004)",
                   " SELECT '",g_prog,"',dzba003,dzba004 FROM dzba_t",
                   "  WHERE dzba001='",po_std_dzaf.dzaf001,"'",
                   "    AND dzba002=",po_std_dzaf.dzaf004
      PREPARE dzbu_prep2 FROM ls_sql
      EXECUTE dzbu_prep2
      FREE dzbu_prep2
      #DISPLAY "insert dzbu_t:",ls_sql
      #End:20161118 by Hiko

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_addpoint error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzac_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzac(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_wc      STRING,
          ls_where   STRING,
          li_cnt       SMALLINT,
          lr_std_dzac  RECORD LIKE dzac_t.* 

   TRY
      LET li_cnt = 0
      LET ls_wc = " AND dzac003='",pr_std_dzaa.dzaa003,"'", #識別碼(控件編號)
                  " AND dzac012='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzac001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzac004=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzac_t",ls_where
      PREPARE std_dzac_prep0 FROM ls_sql
      EXECUTE std_dzac_prep0 INTO li_cnt
      FREE std_dzac_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #由標準的dzaa_t查出標準的dzac_t.*.
      LOCATE lr_std_dzac.dzac099 IN FILE

      LET ls_sql = "SELECT * FROM dzac_t",ls_where
      PREPARE std_dzac_prep1 FROM ls_sql
      EXECUTE std_dzac_prep1 INTO lr_std_dzac.*
      FREE std_dzac_prep1
      LET ls_sql = NULL #20160118 by Hiko

      #更新dzac_t:此段和sadzp060_1雷同.      
      LET ls_trigger = "sadzp060_4_sync_dzac : ",pr_std_dzaa.dzaa003," 檢查行業引用段的內容"
      #DISPLAY ls_trigger
      LET li_cnt = 0
      LET ls_where = " WHERE dzac001='",g_prog,"'",     #行業程式代號
                     "   AND dzac004=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
      LET ls_sql = "SELECT COUNT(*) FROM dzac_t",ls_where
      PREPARE dzac_prep1 FROM ls_sql
      EXECUTE dzac_prep1 INTO li_cnt
      FREE dzac_prep1
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt>0 THEN #資料已存在.
         LET ls_trigger = "sadzp060_4_sync_dzac : update dzac_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzac_t",
                        " SET dzac002='",lr_std_dzac.dzac002 CLIPPED,"',",
                             "dzac005='",lr_std_dzac.dzac005 CLIPPED,"',",
                             "dzac006='",lr_std_dzac.dzac006 CLIPPED,"',",
                             "dzac007='",lr_std_dzac.dzac007 CLIPPED,"',",
                             "dzac008='",lr_std_dzac.dzac008 CLIPPED,"',",
                             "dzac009='",lr_std_dzac.dzac009 CLIPPED,"',",
                             "dzac010='",lr_std_dzac.dzac010 CLIPPED,"',",
                             "dzac011='",lr_std_dzac.dzac011 CLIPPED,"',",
                             "dzac013='",lr_std_dzac.dzac013 CLIPPED,"',",
                             "dzac014=?,", #STD_LIST:預設值的部分就已資料庫的資料為主
                             "dzac015='",lr_std_dzac.dzac015 CLIPPED,"',",
                             "dzac016='",lr_std_dzac.dzac016 CLIPPED,"',",
                             "dzac017='",lr_std_dzac.dzac017 CLIPPED,"',",
                             "dzac018='",lr_std_dzac.dzac018 CLIPPED,"',",
                             "dzac019='",lr_std_dzac.dzac019 CLIPPED,"',",
                             "dzac020='",lr_std_dzac.dzac020 CLIPPED,"',",
                             "dzac021='",lr_std_dzac.dzac021 CLIPPED,"',",
                             "dzacstus='",lr_std_dzac.dzacstus CLIPPED,"',", 
                             "dzacmoddt=?,",
                             "dzacmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp060_4_sync_dzac : insert dzac_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzac_t(dzac001,dzac002,dzac003,dzac004,dzac005,",
                                         "dzac006,dzac007,dzac008,dzac009,dzac010,",
                                         "dzac011,dzac012,dzac013,dzac014,dzac015,",
                                         "dzac016,dzac017,dzac018,dzac019,dzac020,",
                                         "dzac021,",
                                         "dzaccrtdt,dzaccrtdp,dzacowndp,dzacownid,dzacstus,dzaccrtid)",
                                 " VALUES('",g_prog,"','",lr_std_dzac.dzac002 CLIPPED,"','",lr_std_dzac.dzac003 CLIPPED,"',",p_revision,",'",lr_std_dzac.dzac005 CLIPPED,"',",
                                         "'",lr_std_dzac.dzac006 CLIPPED,"','",lr_std_dzac.dzac007 CLIPPED,"','",lr_std_dzac.dzac008 CLIPPED,"','",lr_std_dzac.dzac009 CLIPPED,"','",lr_std_dzac.dzac010 CLIPPED,"',", 
                                         "'",lr_std_dzac.dzac011 CLIPPED,"','",lr_std_dzac.dzac012 CLIPPED,"','",lr_std_dzac.dzac013 CLIPPED,"',?,'",lr_std_dzac.dzac015 CLIPPED,"',", 
                                         "'",lr_std_dzac.dzac016 CLIPPED,"','",lr_std_dzac.dzac017 CLIPPED,"','",lr_std_dzac.dzac018 CLIPPED,"','",lr_std_dzac.dzac019 CLIPPED,"','",lr_std_dzac.dzac020 CLIPPED,"',", 
                                         "'",lr_std_dzac.dzac021 CLIPPED,"',", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",lr_std_dzac.dzacstus CLIPPED,"','",g_user,"')"
      END IF
      
      PREPARE dzac_prep2 FROM ls_sql
      EXECUTE dzac_prep2 USING lr_std_dzac.dzac014,g_date
      FREE dzac_prep2
      LET ls_sql = NULL #20160118 by Hiko
      
      #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
      LET ls_trigger = "sadzp060_4_sync_dzac : update dzac_t data : dzac099"
      #DISPLAY ls_trigger
      UPDATE dzac_t 
         SET dzac099=lr_std_dzac.dzac099
       WHERE dzac001=g_prog
         AND dzac003=pr_std_dzaa.dzaa003
         AND dzac004=p_revision
         AND dzac012=pr_std_dzaa.dzaa006 

      FREE lr_std_dzac.dzac099

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzac error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzab_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzab(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_wc      STRING,
          ls_where   STRING,
          li_cnt       SMALLINT,
          lr_std_dzab  RECORD LIKE dzab_t.* 

   TRY
      LET li_cnt = 0
      LET ls_wc = " AND dzab004='",pr_std_dzaa.dzaa003,"'", #識別碼
                  " AND dzab003='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzab001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzab002=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzab_t",ls_where
      PREPARE std_dzab_prep0 FROM ls_sql
      EXECUTE std_dzab_prep0 INTO li_cnt
      FREE std_dzab_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         DISPLAY "INFO : Can't find dzab_t : ",pr_std_dzaa.dzaa003," SQL=",ls_sql
         RETURN TRUE,NULL
      END IF

      #由標準的dzaa_t查出標準的dzab_t.*.
      LOCATE lr_std_dzab.dzab099 IN FILE

      LET ls_sql = "SELECT * FROM dzab_t",ls_where
      PREPARE std_dzab_prep1 FROM ls_sql
      EXECUTE std_dzab_prep1 INTO lr_std_dzab.*
      FREE std_dzab_prep1
      LET ls_sql = NULL #20160118 by Hiko

      #更新dzab_t:此段和sadzp060_1雷同.      
      LET ls_trigger = "sadzp060_4_sync_dzab : ",pr_std_dzaa.dzaa003," 檢查行業引用段的內容"
      #DISPLAY ls_trigger
      LET li_cnt = 0
      LET ls_where = " WHERE dzab001='",g_prog,"'",     #行業程式代號
                     "   AND dzab002=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
      LET ls_sql = "SELECT COUNT(*) FROM dzab_t",ls_where
      PREPARE dzab_prep1 FROM ls_sql
      EXECUTE dzab_prep1 INTO li_cnt
      FREE dzab_prep1
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt>0 THEN #資料已存在.
         LET ls_trigger = "sadzp060_4_sync_dzab : update dzab_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzab_t",
                        " SET dzabstus='",lr_std_dzab.dzabstus CLIPPED,"',", 
                             "dzabmoddt=?,",
                             "dzabmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp060_4_sync_dzab : insert dzab_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzab_t(dzab001,dzab002,dzab003,dzab004,dzab005,",
                                         "dzab006,",
                                         "dzabcrtdt,dzabcrtdp,dzabowndp,dzabownid,dzabstus,dzabcrtid)",
                                 " VALUES('",g_prog,"',",p_revision,",'",lr_std_dzab.dzab003 CLIPPED,"','",lr_std_dzab.dzab004 CLIPPED,"','",lr_std_dzab.dzab005 CLIPPED,"',",
                                         "'",lr_std_dzab.dzab006 CLIPPED,"',", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",lr_std_dzab.dzabstus CLIPPED,"','",g_user,"')"
      END IF
      
      PREPARE dzab_prep2 FROM ls_sql
      EXECUTE dzab_prep2 USING g_date
      FREE dzab_prep2
      LET ls_sql = NULL #20160118 by Hiko
      
      #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
      LET ls_trigger = "sadzp060_4_sync_dzab : update dzab_t data : dzab099"
      #DISPLAY ls_trigger
      UPDATE dzab_t 
         SET dzab099=lr_std_dzab.dzab099
       WHERE dzab001=g_prog
         AND dzab002=p_revision
         AND dzab003=pr_std_dzaa.dzaa006 
         AND dzab004=pr_std_dzaa.dzaa003

      FREE lr_std_dzab.dzab099

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzab error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzad_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzad(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_wc      STRING,
          ls_where   STRING,
          li_cnt       SMALLINT,
          lr_std_dzad  RECORD LIKE dzad_t.* 

   TRY
      LET li_cnt = 0
      LET ls_wc = " AND dzad002='",pr_std_dzaa.dzaa003,"'", #識別碼
                  " AND dzad005='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzad001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzad003=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzad_t",ls_where
      PREPARE std_dzad_prep0 FROM ls_sql
      EXECUTE std_dzad_prep0 INTO li_cnt
      FREE std_dzad_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #由標準的dzaa_t查出標準的dzad_t.*.
      LOCATE lr_std_dzad.dzad099 IN FILE

      LET ls_sql = "SELECT * FROM dzad_t",ls_where
      PREPARE std_dzad_prep1 FROM ls_sql
      EXECUTE std_dzad_prep1 INTO lr_std_dzad.*
      FREE std_dzad_prep1
      LET ls_sql = NULL #20160118 by Hiko

      #更新dzad_t:此段和sadzp060_1雷同.      
      LET ls_trigger = "sadzp060_4_sync_dzad : ",pr_std_dzaa.dzaa003," 檢查行業引用段的內容"
      #DISPLAY ls_trigger
      LET li_cnt = 0
      LET ls_where = " WHERE dzad001='",g_prog,"'",     #行業程式代號
                     "   AND dzad003=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
      LET ls_sql = "SELECT COUNT(*) FROM dzad_t",ls_where
      PREPARE dzad_prep1 FROM ls_sql
      EXECUTE dzad_prep1 INTO li_cnt
      FREE dzad_prep1
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt>0 THEN #資料已存在.
         LET ls_trigger = "sadzp060_4_sync_dzad : update dzad_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzad_t",
                        " SET dzad006='",lr_std_dzad.dzad006 CLIPPED,"',",
                             "dzad007='",lr_std_dzad.dzad007 CLIPPED,"',",
                             "dzadstus='",lr_std_dzad.dzadstus,"',", 
                             "dzadmoddt=?,",
                             "dzadmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp060_4_sync_dzad : insert dzad_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzad_t(dzad001,dzad002,dzad003,dzad005,",
                                         "dzad006,dzad007,dzad008,",
                                         "dzadcrtdt,dzadcrtdp,dzadowndp,dzadownid,dzadstus,dzadcrtid)",
                                 " VALUES('",g_prog,"','",lr_std_dzad.dzad002 CLIPPED,"',",p_revision,",'",lr_std_dzad.dzad005 CLIPPED,"',",
                                         "'",lr_std_dzad.dzad006 CLIPPED,"','",lr_std_dzad.dzad007 CLIPPED,"','",lr_std_dzad.dzad008 CLIPPED,"',", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",lr_std_dzad.dzadstus CLIPPED,"','",g_user,"')"
      END IF
      
      PREPARE dzad_prep2 FROM ls_sql
      EXECUTE dzad_prep2 USING g_date
      FREE dzad_prep2
      LET ls_sql = NULL #20160118 by Hiko
      
      #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
      LET ls_trigger = "sadzp060_4_sync_dzad : update dzad_t data : dzad099"
      #DISPLAY ls_trigger
      UPDATE dzad_t 
         SET dzad099=lr_std_dzad.dzad099
       WHERE dzad001=g_prog
         AND dzad002=pr_std_dzaa.dzaa003
         AND dzad003=p_revision 
         AND dzad005=pr_std_dzaa.dzaa006

      FREE lr_std_dzad.dzad099

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzad error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzak_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzak(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_wc      STRING,
          ls_where   STRING,
          li_cnt       SMALLINT,
          lr_std_dzak  RECORD LIKE dzak_t.* 

   TRY
      LET li_cnt = 0
      LET ls_wc = " AND dzak002='",pr_std_dzaa.dzaa003,"'", #識別碼(控件編號)
                  " AND dzak004='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzak001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzak003=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzak_t",ls_where
      PREPARE std_dzak_prep0 FROM ls_sql
      EXECUTE std_dzak_prep0 INTO li_cnt
      FREE std_dzak_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #由標準的dzaa_t查出標準的dzak_t.*.
      LET ls_sql = "SELECT * FROM dzak_t",ls_where
      PREPARE std_dzak_prep1 FROM ls_sql
      EXECUTE std_dzak_prep1 INTO lr_std_dzak.*
      FREE std_dzak_prep1
      LET ls_sql = NULL #20160118 by Hiko

      #更新dzak_t:此段和sadzp060_1雷同.      
      LET ls_trigger = "sadzp060_4_sync_dzak : ",pr_std_dzaa.dzaa003," 檢查行業引用段的內容"
      #DISPLAY ls_trigger
      LET ls_where = " WHERE dzak001='",g_prog,"'",     #行業程式代號
                     "   AND dzak003=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
      LET li_cnt = 0
      LET ls_sql = "SELECT COUNT(*) FROM dzak_t",ls_where
      PREPARE dzak_prep1 FROM ls_sql
      EXECUTE dzak_prep1 INTO li_cnt
      FREE dzak_prep1
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt>0 THEN #資料已存在.
         LET ls_trigger = "sadzp060_4_sync_dzak : update dzak_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzak_t",
                        " SET dzak005=?,",
                             "dzak007='",lr_std_dzak.dzak007 CLIPPED,"',",
                             "dzak008='",lr_std_dzak.dzak008 CLIPPED,"',",
                             "dzak009='",lr_std_dzak.dzak009 CLIPPED,"',",
                             "dzak010='",lr_std_dzak.dzak010 CLIPPED,"',",
                             "dzak011='",lr_std_dzak.dzak011 CLIPPED,"',",
                             "dzakstus='",lr_std_dzak.dzakstus CLIPPED,"',", 
                             "dzakmoddt=?,",
                             "dzakmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp060_4_sync_dzak : insert dzak_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzak_t(dzak001,dzak002,dzak003,dzak004,dzak005,",
                                         "        dzak007,dzak008,dzak009,dzak010,",
                                         "dzak011,dzak012,",
                                         "dzakcrtdt,dzakcrtdp,dzakowndp,dzakownid,dzakstus,dzakcrtid)",
                                 " VALUES('",g_prog,"','",lr_std_dzak.dzak002 CLIPPED,"',",p_revision,",'",lr_std_dzak.dzak004 CLIPPED,"',?,", #20160118 by Hiko
                                         "'",lr_std_dzak.dzak007 CLIPPED,"','",lr_std_dzak.dzak008 CLIPPED,"','",lr_std_dzak.dzak009 CLIPPED,"','",lr_std_dzak.dzak010 CLIPPED,"',", 
                                         "'",lr_std_dzak.dzak011 CLIPPED,"','",lr_std_dzak.dzak012 CLIPPED,"',", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",lr_std_dzak.dzakstus CLIPPED,"','",g_user,"')"
      END IF
      
      PREPARE dzak_prep2 FROM ls_sql
      EXECUTE dzak_prep2 USING lr_std_dzak.dzak005,g_date
      FREE dzak_prep2
      LET ls_sql = NULL #20160118 by Hiko

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzak error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzal_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzal(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_wc       STRING,
          ls_where    STRING, #標準WHERE
          ls_where2   STRING, #行業WHERE
          li_i        SMALLINT,
          li_cnt      SMALLINT,
          la_std_dzal DYNAMIC ARRAY OF RECORD LIKE dzal_t.*

   TRY
      LET li_cnt = 0
      #由標準的dzaa_t查出標準的dzal_t.*.
      LET ls_wc = " AND dzal005='",pr_std_dzaa.dzaa003,"'", #依附控件編號
                  " AND dzal004='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzal001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzal003=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzal_t",ls_where
      PREPARE std_dzal_prep0 FROM ls_sql
      EXECUTE std_dzal_prep0 INTO li_cnt
      FREE std_dzal_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #執行到這邊就表示有標準資料,則先將目前版次的設計資料清除乾淨,這樣同步結果才會正確.
      LET ls_where2 = " WHERE dzal001='",g_prog,"'",     #行業程式代號
                      "   AND dzal003=",p_revision,      #行業程式的規格版次:這樣才符合更新機制 
                      "   AND dzal004='",pr_std_dzaa.dzaa006,"'", #使用標示:這裡和其他同步段落都不相同
                      #Begin:21060118 by Hiko
                      #"   AND dzal002 IN (",
                      #"                   SELECT DISTINCT dzal002 FROM dzal_t",ls_where,")"
                      "   AND dzal005='",pr_std_dzaa.dzaa003,"'"
                      #End:21060118 by Hiko
      LET ls_sql = "DELETE FROM dzal_t",ls_where2
      PREPARE del_dzal_prep0 FROM ls_sql
      EXECUTE del_dzal_prep0
      FREE del_dzal_prep0
      LET ls_sql = NULL #20160118 by Hiko

      LET ls_sql = "INSERT INTO dzal_t(dzal001,dzal002,dzal003,dzal004,dzal005,",
                                      "dzal006,dzal007,dzal008,",
                                      "dzalcrtdt,dzalcrtdp,dzalowndp,dzalownid,dzalstus,dzalcrtid)",
                              " SELECT '",g_prog,"',dzal002,",p_revision,",dzal004,dzal005,",
                                      "dzal006,dzal007,dzal008,",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"',dzalstus,'",g_user,"'",
                                " FROM dzal_t",ls_where
      PREPARE dzal_prep8 FROM ls_sql
      EXECUTE dzal_prep8 USING g_date
      FREE dzal_prep8
      LET ls_sql = NULL #20160118 by Hiko

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzal error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzff_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzff(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_wc       STRING,
          ls_where    STRING, #標準WHERE
          ls_where2   STRING, #行業WHERE
          li_i        SMALLINT,
          li_cnt      SMALLINT,
          la_std_dzff DYNAMIC ARRAY OF RECORD LIKE dzff_t.*

   TRY
      LET li_cnt = 0
      #由標準的dzaa_t查出標準的dzff_t.*.
      LET ls_wc = " AND dzff003='",pr_std_dzaa.dzaa003,"'", #控件編號
                  " AND dzff008='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzff001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzff002=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzff_t",ls_where
      PREPARE std_dzff_prep0 FROM ls_sql
      EXECUTE std_dzff_prep0 INTO li_cnt
      FREE std_dzff_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #執行到這邊就表示有標準資料,則先將目前版次的設計資料清除乾淨,這樣同步結果才會正確.
      LET ls_where2 = " WHERE dzff001='",g_prog,"'",     #行業程式代號
                      #"   AND dzff002=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
                      "   AND dzff002=",p_revision #行業程式的規格版次:這樣才符合更新機制 #20160118 by Hiko
      LET ls_sql = "DELETE FROM dzff_t",ls_where2
      PREPARE del_dzff_prep0 FROM ls_sql
      EXECUTE del_dzff_prep0
      FREE del_dzff_prep0
      LET ls_sql = NULL #20160118 by Hiko

      LET ls_sql = "INSERT INTO dzff_t(dzff001,dzff002,dzff003,dzff004,dzff005,",
                                      "dzff006,dzff007,dzff008,dzff009,",
                                      "dzffcrtdt,dzffcrtdp,dzffowndp,dzffownid,dzffstus,dzffcrtid)",
                              " SELECT '",g_prog,"',",p_revision,",dzff003,dzff004,dzff005,",
                                      "dzff006,dzff007,dzff008,dzff009,",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"',dzffstus,'",g_user,"'",
                                " FROM dzff_t",ls_where
      PREPARE dzff_prep8 FROM ls_sql
      EXECUTE dzff_prep8 USING g_date
      FREE dzff_prep8
      LET ls_sql = NULL #20160118 by Hiko

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzff error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzai_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzai(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_wc      STRING,
          ls_where   STRING,
          li_cnt       SMALLINT,
          lr_std_dzai  RECORD LIKE dzai_t.* 

   TRY
      LET li_cnt = 0
      LET ls_wc = " AND dzai002='",pr_std_dzaa.dzaa003,"'", #識別碼(控件編號)
                  " AND dzai004='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzai001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzai003=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzai_t",ls_where
      PREPARE std_dzai_prep0 FROM ls_sql
      EXECUTE std_dzai_prep0 INTO li_cnt
      FREE std_dzai_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #由標準的dzaa_t查出標準的dzai_t.*.
      LET ls_sql = "SELECT * FROM dzai_t",ls_where
      PREPARE std_dzai_prep1 FROM ls_sql
      EXECUTE std_dzai_prep1 INTO lr_std_dzai.*
      FREE std_dzai_prep1
      LET ls_sql = NULL #20160118 by Hiko

      #更新dzai_t:此段和sadzp060_1雷同.      
      LET ls_trigger = "sadzp060_4_sync_dzai : ",pr_std_dzaa.dzaa003," 檢查行業引用段的內容"
      #DISPLAY ls_trigger
      LET li_cnt = 0
      LET ls_where = " WHERE dzai001='",g_prog,"'",     #行業程式代號
                     "   AND dzai003=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
      LET ls_sql = "SELECT COUNT(*) FROM dzai_t",ls_where
      PREPARE dzai_prep1 FROM ls_sql
      EXECUTE dzai_prep1 INTO li_cnt
      FREE dzai_prep1
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt>0 THEN #資料已存在.
         LET ls_trigger = "sadzp060_4_sync_dzai : update dzai_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzai_t",
                        " SET dzai005='",lr_std_dzai.dzai005 CLIPPED,"',",
                             "dzai007=?,",
                             "dzai008='",lr_std_dzai.dzai008 CLIPPED,"',",
                             "dzai009='",lr_std_dzai.dzai009 CLIPPED,"',",
                             "dzai010='",lr_std_dzai.dzai010 CLIPPED,"',",
                             "dzai011='",lr_std_dzai.dzai011 CLIPPED,"',",
                             "dzaistus='",lr_std_dzai.dzaistus CLIPPED,"',", 
                             "dzaimoddt=?,",
                             "dzaimodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp060_4_sync_dzai : insert dzai_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzai_t(dzai001,dzai002,dzai003,dzai004,dzai005,",
                                         "        dzai007,dzai008,dzai009,dzai010,",
                                         "dzai011,dzai012,",
                                         "dzaicrtdt,dzaicrtdp,dzaiowndp,dzaiownid,dzaistus,dzaicrtid)",
                                 " VALUES('",g_prog,"','",lr_std_dzai.dzai002 CLIPPED,"',",p_revision,",'",lr_std_dzai.dzai004 CLIPPED,"','",lr_std_dzai.dzai005 CLIPPED,"',",
                                                      "?,'",lr_std_dzai.dzai008 CLIPPED,"','",lr_std_dzai.dzai009 CLIPPED,"','",lr_std_dzai.dzai010 CLIPPED,"',", 
                                         "'",lr_std_dzai.dzai011 CLIPPED,"','",lr_std_dzai.dzai012 CLIPPED,"',", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",lr_std_dzai.dzaistus CLIPPED,"','",g_user,"')"
      END IF
      
      PREPARE dzai_prep2 FROM ls_sql
      EXECUTE dzai_prep2 USING lr_std_dzai.dzai007,g_date
      FREE dzai_prep2
      LET ls_sql = NULL #20160118 by Hiko

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzai error!"
   END TRY
END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzaj_t
# Input parameter : pr_std_dzaa 標準dzaa_t資料
#                 : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzaj(pr_std_dzaa, p_revision)
   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
          p_revision  LIKE dzaa_t.dzaa004 #STD_LIST
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_wc      STRING,
          ls_where   STRING,
          li_cnt       SMALLINT,
          lr_std_dzaj  RECORD LIKE dzaj_t.* 

   TRY
      LET li_cnt = 0
      LET ls_wc = " AND dzaj002='",pr_std_dzaa.dzaa003,"'", #識別碼(控件編號)
                  " AND dzaj004='",pr_std_dzaa.dzaa006,"'"  #使用標示
      LET ls_where = " WHERE dzaj001='",pr_std_dzaa.dzaa001,"'", #標準程式代號
                     "   AND dzaj003=",pr_std_dzaa.dzaa004,ls_wc #識別碼版次
      LET ls_sql = "SELECT COUNT(*) FROM dzaj_t",ls_where
      PREPARE std_dzaj_prep0 FROM ls_sql
      EXECUTE std_dzaj_prep0 INTO li_cnt
      FREE std_dzaj_prep0
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN #沒有找到標準的設計資料,就不需要繼續往下執行了.
         RETURN TRUE,NULL
      END IF

      #由標準的dzaa_t查出標準的dzaj_t.*.
      LOCATE lr_std_dzaj.dzaj099 IN FILE

      LET ls_sql = "SELECT * FROM dzaj_t",ls_where
      PREPARE std_dzaj_prep1 FROM ls_sql
      EXECUTE std_dzaj_prep1 INTO lr_std_dzaj.*
      FREE std_dzaj_prep1
      LET ls_sql = NULL #20160118 by Hiko

      #更新dzaj_t:此段和sadzp060_1雷同.      
      LET ls_trigger = "sadzp060_4_sync_dzaj : ",pr_std_dzaa.dzaa003," 檢查行業引用段的內容"
      #DISPLAY ls_trigger
      LET li_cnt = 0
      LET ls_where = " WHERE dzaj001='",g_prog,"'",     #行業程式代號
                     "   AND dzaj003=",p_revision,ls_wc #行業程式的規格版次:這樣才符合更新機制 
      LET ls_sql = "SELECT COUNT(*) FROM dzaj_t",ls_where
      PREPARE dzaj_prep1 FROM ls_sql
      EXECUTE dzaj_prep1 INTO li_cnt
      FREE dzaj_prep1
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt>0 THEN #資料已存在.
         LET ls_trigger = "sadzp060_4_sync_dzaj : update dzaj_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "UPDATE dzaj_t",
                        " SET dzaj005='",lr_std_dzaj.dzaj005 CLIPPED,"',",
                             "dzaj007=?,",
                             "dzaj008='",lr_std_dzaj.dzaj008 CLIPPED,"',",
                             "dzaj009='",lr_std_dzaj.dzaj009 CLIPPED,"',",
                             "dzaj010='",lr_std_dzaj.dzaj010 CLIPPED,"',",
                             "dzaj011='",lr_std_dzaj.dzaj011 CLIPPED,"',",
                             "dzajstus='",lr_std_dzaj.dzajstus CLIPPED,"',", 
                             "dzajmoddt=?,",
                             "dzajmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp060_4_sync_dzaj : insert dzaj_t data"
         #DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzaj_t(dzaj001,dzaj002,dzaj003,dzaj004,dzaj005,",
                                         "        dzaj007,dzaj008,dzaj009,dzaj010,",
                                         "dzaj011,dzaj012,",
                                         "dzajcrtdt,dzajcrtdp,dzajowndp,dzajownid,dzajstus,dzajcrtid)",
                                 " VALUES('",g_prog,"','",lr_std_dzaj.dzaj002 CLIPPED,"',",p_revision,",'",lr_std_dzaj.dzaj004 CLIPPED,"','",lr_std_dzaj.dzaj005 CLIPPED,"',",
                                                      "?,'",lr_std_dzaj.dzaj008 CLIPPED,"','",lr_std_dzaj.dzaj009 CLIPPED,"','",lr_std_dzaj.dzaj010 CLIPPED,"',", 
                                         "'",lr_std_dzaj.dzaj011 CLIPPED,"','",lr_std_dzaj.dzaj012 CLIPPED,"',", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",lr_std_dzaj.dzajstus CLIPPED,"','",g_user,"')"
      END IF
      
      PREPARE dzaj_prep2 FROM ls_sql
      EXECUTE dzaj_prep2 USING lr_std_dzaj.dzaj007,g_date
      FREE dzaj_prep2
      LET ls_sql = NULL #20160118 by Hiko

      #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
      LET ls_trigger = "sadzp060_4_sync_dzaj : update dzaj_t data : dzaj099"
      #DISPLAY ls_trigger
      UPDATE dzaj_t 
         SET dzaj099=lr_std_dzaj.dzaj099
       WHERE dzaj001=g_prog
         AND dzaj002=pr_std_dzaa.dzaa003
         AND dzaj003=p_revision
         AND dzaj004=pr_std_dzaa.dzaa006 

      FREE lr_std_dzaj.dzaj099

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzaj error!"
   END TRY
END FUNCTION

#Begin:20160118 by Hiko
###########################################################################
## Access Modifier : PRIVATE 
## Descriptions    : 將規格同步資料寫入dzar_t內
## Input parameter : pr_std_dzaa 標準dzaa_t資料
##                 : p_table     資源池表格
## Return code     : void
## Date & Author   : 2015/03/10 by Hiko
###########################################################################
#PRIVATE FUNCTION sadzp060_4_spec_dzar_t(pr_std_dzaa, p_table)
#   DEFINE pr_std_dzaa RECORD LIKE dzaa_t.*,
#          p_table     LIKE dzar_t.dzar003
#   DEFINE ls_trigger STRING,
#          ls_sql     STRING
#   
#   TRY
#      LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                      "dzar006,dzar007,",
#                                      "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                              " VALUES('",g_prog,"','SPEC','",p_table,"','",pr_std_dzaa.dzaa003,"',",pr_std_dzaa.dzaa004,",",
#                                      "'",pr_std_dzaa.dzaa006,"','",pr_std_dzaa.dzaastus,"',",
#                                      "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#      
#      PREPARE dzar_prep1 FROM ls_sql
#      EXECUTE dzar_prep1 USING g_date
#      FREE dzar_prep1
#   CATCH
#      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
#   END TRY
#END FUNCTION
#
###########################################################################
## Access Modifier : PRIVATE 
## Descriptions    : 將規格TABLE/EXCLUDE資料寫入dzar_t內
## Input parameter : pr_std_dzaa 標準dzaa_t資料
## Input parameter : po_industry_dzaf 行業程式DZAF_T資料
## Return code     : void
## Date & Author   : 2015/05/13 by Hiko
###########################################################################
#PRIVATE FUNCTION sadzp060_4_multi_dzar_t(pr_std_dzaa, po_industry_dzaf)
#   DEFINE pr_std_dzaa      RECORD LIKE dzaa_t.*,
#          po_industry_dzaf T_DZAF_T
#   DEFINE ls_trigger STRING,
#          ls_sql     STRING,
#          li_i       SMALLINT
#   
#   TRY
#      CASE pr_std_dzaa.dzaa005
#         WHEN "4" #TABLE
#            #取得標準規格多餘行業規格的TABLE設計資料
#            CALL ga_std_dzag.clear()
#            LET ls_sql = "SELECT ag1.* FROM dzag_t ag1",
#                         " WHERE ag1.dzag001='",pr_std_dzaa.dzaa001,"'",
#                         "   AND ag1.dzag003=",pr_std_dzaa.dzaa004,
#                         "   AND ag1.dzag006='",pr_std_dzaa.dzaa006,"'",
#                         "   AND ag1.dzag002 NOT IN(SELECT ag2.dzag002 FROM dzag_t ag2",
#                                                   " WHERE ag2.dzag001='",g_prog,"'",
#                                                   "   AND ag2.dzag003=",po_industry_dzaf.dzaf003,
#                                                   "   AND ag2.dzag006='",po_industry_dzaf.dzaf010,"')"
#            #DISPLAY "DEBUG:sadzp060_4_multi_dzar_t ls_sql=",ls_sql
#            PREPARE dzag_std_prep FROM ls_sql
#            DECLARE dzag_std_curs CURSOR FOR dzag_std_prep
#            
#            LET li_i = 1
#            FOREACH dzag_std_curs INTO ga_std_dzag[li_i].*
#               LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                               "dzar006,dzar007,",
#                                               "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                                       " VALUES('",g_prog,"','SPEC','dzag_t','",ga_std_dzag[li_i].dzag002 CLIPPED,"',",ga_std_dzag[li_i].dzag003,",",
#                                               "'",ga_std_dzag[li_i].dzag006 CLIPPED,"','",ga_std_dzag[li_i].dzagstus CLIPPED,"',",
#                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#               
#               PREPARE dzar_prep3 FROM ls_sql
#               EXECUTE dzar_prep3 USING g_date
#               FREE dzar_prep3
#
#               LET li_i = li_i + 1
#            END FOREACH
#            CALL ga_std_dzag.deleteElement(li_i)
#
#            #取得標準規格多餘行業規格的SCREEN RECORD設計資料
#            CALL ga_std_dzfs.clear()
#            LET ls_sql = "SELECT fs1.* FROM dzfs_t fs1",
#                         " WHERE fs1.dzfs002='",pr_std_dzaa.dzaa001,"'",
#                         "   AND fs1.dzfs001=",pr_std_dzaa.dzaa004,
#                         "   AND fs1.dzfs005='",pr_std_dzaa.dzaa006,"'",
#                         "   AND fs1.dzfs003 NOT IN(SELECT fs2.dzfs003 FROM dzfs_t fs2",
#                                                   " WHERE fs2.dzfs002='",g_prog,"'",
#                                                   "   AND fs2.dzfs001=",po_industry_dzaf.dzaf003,
#                                                   "   AND fs2.dzfs005='",po_industry_dzaf.dzaf010,"')"
#            #DISPLAY "DEBUG:sadzp060_4_multi_dzar_t ls_sql=",ls_sql
#            PREPARE dzfs_std_prep FROM ls_sql
#            DECLARE dzfs_std_curs CURSOR FOR dzfs_std_prep
#            
#            LET li_i = 1
#            FOREACH dzfs_std_curs INTO ga_std_dzfs[li_i].*
#               LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                               "dzar006,dzar007,",
#                                               "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                                       " VALUES('",g_prog,"','SPEC','dzfs_t','",ga_std_dzfs[li_i].dzfs003 CLIPPED,"',",ga_std_dzfs[li_i].dzfs001,",",
#                                               "'",ga_std_dzfs[li_i].dzfs005 CLIPPED,"','",ga_std_dzfs[li_i].dzfsstus CLIPPED,"',",
#                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#               
#               PREPARE dzar_prep4 FROM ls_sql
#               EXECUTE dzar_prep4 USING g_date
#               FREE dzar_prep4
#
#               LET li_i = li_i + 1
#            END FOREACH
#            CALL ga_std_dzfs.deleteElement(li_i)
#
#            IF ga_std_dzag.getLength()=0 AND ga_std_dzfs.getLength()=0 THEN #這是表示已經同步過,雖然設計資料已經更新,但dzar_t看不到,所以補上一筆.
#               LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                               "dzar006,dzar007,",
#                                               "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                                       " VALUES('",g_prog,"','SPEC','dzag_t','TABLE',",pr_std_dzaa.dzaa004,",",
#                                               "'",pr_std_dzaa.dzaa006 CLIPPED,"','",pr_std_dzaa.dzaastus CLIPPED,"',",
#                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#               PREPARE dzar_prep6 FROM ls_sql
#               EXECUTE dzar_prep6 USING g_date
#               FREE dzar_prep6
#            END IF
#         WHEN "a" #EXCLUDE
#            CALL ga_std_dzam.clear()
#            #取得標準規格多餘行業規格的排除控件資料
#            LET ls_sql = "SELECT am1.* FROM dzam_t am1",
#                         " WHERE am1.dzam001='",pr_std_dzaa.dzaa001,"'",
#                         "   AND am1.dzam004=",pr_std_dzaa.dzaa004,
#                         "   AND am1.dzam005='",pr_std_dzaa.dzaa006,"'",
#                         "   AND am1.dzam003 NOT IN(SELECT am2.dzam003 FROM dzam_t am2",
#                                                   " WHERE am2.dzam001='",g_prog,"'",
#                                                   "   AND am2.dzam004=",po_industry_dzaf.dzaf003,
#                                                   "   AND am2.dzam005='",po_industry_dzaf.dzaf010,"')"
#            #DISPLAY "DEBUG:sadzp060_4_multi_dzar_t ls_sql=",ls_sql
#            PREPARE dzam_std_prep FROM ls_sql
#            DECLARE dzam_std_curs CURSOR FOR dzam_std_prep
#            
#            LET li_i = 1
#            FOREACH dzam_std_curs INTO ga_std_dzam[li_i].*
#               LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                               "dzar006,dzar007,",
#                                               "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                                       " VALUES('",g_prog,"','SPEC','dzam_t','",ga_std_dzam[li_i].dzam003 CLIPPED,"',",ga_std_dzam[li_i].dzam004,",",
#                                               "'",ga_std_dzam[li_i].dzam005 CLIPPED,"','",ga_std_dzam[li_i].dzamstus CLIPPED,"',",
#                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#               
#               PREPARE dzar_prep5 FROM ls_sql
#               EXECUTE dzar_prep5 USING g_date
#               FREE dzar_prep5
#
#               LET li_i = li_i + 1
#            END FOREACH
#            CALL ga_std_dzam.deleteElement(li_i)
#
#            IF ga_std_dzam.getLength()=0 THEN #這是表示已經同步過,雖然設計資料已經更新,但dzar_t看不到,所以補上一筆.
#               LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                               "dzar006,dzar007,",
#                                               "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                                       " VALUES('",g_prog,"','SPEC','dzam_t','EXCLUDE',",pr_std_dzaa.dzaa004,",",
#                                               "'",pr_std_dzaa.dzaa006 CLIPPED,"','",pr_std_dzaa.dzaastus CLIPPED,"',",
#                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#               PREPARE dzar_prep7 FROM ls_sql
#               EXECUTE dzar_prep7 USING g_date
#               FREE dzar_prep7
#            END IF
#      END CASE
#   CATCH
#      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
#   END TRY
#END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 準備規格TABLE的資料
# Input parameter : pr_std_dzaa 標準dzaa_t資料
# Input parameter : po_industry_dzaf 行業程式DZAF_T資料
# Return code     : void
# Date & Author   : 20160118 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_prepare_dzag_t(pr_std_dzaa, po_industry_dzaf)
   DEFINE pr_std_dzaa      RECORD LIKE dzaa_t.*,
          po_industry_dzaf T_DZAF_T
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          li_i       SMALLINT
   
   TRY
      CASE pr_std_dzaa.dzaa005
         WHEN "4" #TABLE
            #取得標準規格多餘行業規格的TABLE設計資料
            CALL ga_std_dzag.clear()
            LET ls_sql = "SELECT ag1.* FROM dzag_t ag1",
                         " WHERE ag1.dzag001='",pr_std_dzaa.dzaa001,"'",
                         "   AND ag1.dzag003=",pr_std_dzaa.dzaa004,
                         "   AND ag1.dzag006='",pr_std_dzaa.dzaa006,"'",
                         "   AND ag1.dzag002 NOT IN(SELECT ag2.dzag002 FROM dzag_t ag2",
                                                   " WHERE ag2.dzag001='",g_prog,"'",
                                                   "   AND ag2.dzag003=",po_industry_dzaf.dzaf003,
                                                   "   AND ag2.dzag006='",po_industry_dzaf.dzaf010,"')"
            DISPLAY "DEBUG:sadzp060_4_prepare_dzag_t ls_sql=",ls_sql
            PREPARE dzag_std_prep FROM ls_sql
            DECLARE dzag_std_curs CURSOR FOR dzag_std_prep
            
            LET li_i = 1
            FOREACH dzag_std_curs INTO ga_std_dzag[li_i].*
               LET li_i = li_i + 1
            END FOREACH
            CALL ga_std_dzag.deleteElement(li_i)

            #取得標準規格多餘行業規格的SCREEN RECORD設計資料
            CALL ga_std_dzfs.clear()
            LET ls_sql = "SELECT fs1.* FROM dzfs_t fs1",
                         " WHERE fs1.dzfs002='",pr_std_dzaa.dzaa001,"'",
                         "   AND fs1.dzfs001=",pr_std_dzaa.dzaa004,
                         "   AND fs1.dzfs005='",pr_std_dzaa.dzaa006,"'",
                         "   AND fs1.dzfs003 NOT IN(SELECT fs2.dzfs003 FROM dzfs_t fs2",
                                                   " WHERE fs2.dzfs002='",g_prog,"'",
                                                   "   AND fs2.dzfs001=",po_industry_dzaf.dzaf003,
                                                   "   AND fs2.dzfs005='",po_industry_dzaf.dzaf010,"')"
            DISPLAY "DEBUG:sadzp060_4_prepare_dzfs_t ls_sql=",ls_sql
            PREPARE dzfs_std_prep FROM ls_sql
            DECLARE dzfs_std_curs CURSOR FOR dzfs_std_prep
            
            LET li_i = 1
            FOREACH dzfs_std_curs INTO ga_std_dzfs[li_i].*
               LET li_i = li_i + 1
            END FOREACH
            CALL ga_std_dzfs.deleteElement(li_i)
      END CASE
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 準備規格EXCLUDE的資料
# Input parameter : pr_std_dzaa 標準dzaa_t資料
# Input parameter : po_industry_dzaf 行業程式DZAF_T資料
# Return code     : void
# Date & Author   : 20160118 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_prepare_dzam_t(pr_std_dzaa, po_industry_dzaf)
   DEFINE pr_std_dzaa      RECORD LIKE dzaa_t.*,
          po_industry_dzaf T_DZAF_T
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          li_i       SMALLINT
   
   TRY
      CASE pr_std_dzaa.dzaa005
         WHEN "a" #EXCLUDE
            CALL ga_std_dzam.clear()
            #取得標準規格多餘行業規格的排除控件資料
            LET ls_sql = "SELECT am1.* FROM dzam_t am1",
                         " WHERE am1.dzam001='",pr_std_dzaa.dzaa001,"'",
                         "   AND am1.dzam004=",pr_std_dzaa.dzaa004,
                         "   AND am1.dzam005='",pr_std_dzaa.dzaa006,"'",
                         "   AND am1.dzam003 NOT IN(SELECT am2.dzam003 FROM dzam_t am2",
                                                   " WHERE am2.dzam001='",g_prog,"'",
                                                   "   AND am2.dzam004=",po_industry_dzaf.dzaf003,
                                                   "   AND am2.dzam005='",po_industry_dzaf.dzaf010,"')"
            #DISPLAY "DEBUG:sadzp060_4_multi_dzar_t ls_sql=",ls_sql
            PREPARE dzam_std_prep FROM ls_sql
            DECLARE dzam_std_curs CURSOR FOR dzam_std_prep
            
            LET li_i = 1
            FOREACH dzam_std_curs INTO ga_std_dzam[li_i].*
               LET li_i = li_i + 1
            END FOREACH
            CALL ga_std_dzam.deleteElement(li_i)
      END CASE
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
   END TRY
END FUNCTION
#End:20160118 by Hiko

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzag_t
# Input parameter : po_industry_dzaf 行業程式DZAF_T資料
#                 : p_revision       要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/05/13 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzag(po_industry_dzaf, p_revision)
   DEFINE po_industry_dzaf T_DZAF_T,
          p_revision       LIKE dzaa_t.dzaa004 
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          li_cnt     SMALLINT,
          li_i       SMALLINT

   TRY
      IF ga_std_dzag.getLength()>0 OR ga_std_dzfs.getLength()>0 THEN
         #Begin:20160118 by Hiko : 行業同步的時候, 不會做表格資料的UPDATE, 只會做INSERT, 所以並不需要做複製舊版的動作.
         ##要先複製舊版資料.
         #IF NOT sadzp060_4_copy_dzag_t(po_industry_dzaf.*, p_revision) THEN
         #   RETURN FALSE,"ERROR : call sadzp060_4_sync_dzag : copy dzag_t error!"
         #END IF
         #End:20160118 by Hiko

         #排除控件(EXCLUDE)和表格設計資料(TABLE/SCREEN RECORD)一樣,都是將標準多餘行業的設計資料複製到行業規格內.
         FOR li_i=1 TO ga_std_dzag.getLength()
            #Begin:21060118 by Hiko
            LET li_cnt = 0
            SELECT COUNT(*) INTO li_cnt FROM dzag_t
             WHERE dzag001=g_prog
               AND dzag002=ga_std_dzag[li_i].dzag002
               AND dzag003=p_revision
               AND dzag006=ga_std_dzag[li_i].dzag006
            #End:21060118 by Hiko

            IF li_cnt=0 THEN
               LET ls_sql = "INSERT INTO dzag_t(dzag001,dzag002,dzag003,dzag004,dzag005,",
                                               "dzag006,dzag007,dzag008,dzag009,dzag010,",
                                               "dzag011,dzag012,dzag013,dzag014,dzag015,",
                                               "dzagcrtdt,dzagcrtdp,dzagowndp,dzagownid,dzagstus,dzagcrtid)",
                                       " VALUES('",g_prog,"','",ga_std_dzag[li_i].dzag002 CLIPPED,"',",p_revision,",'",ga_std_dzag[li_i].dzag004 CLIPPED,"','",ga_std_dzag[li_i].dzag005 CLIPPED,"',",
                                               "'",ga_std_dzag[li_i].dzag006 CLIPPED,"','",ga_std_dzag[li_i].dzag007 CLIPPED,"','",ga_std_dzag[li_i].dzag008 CLIPPED,"','",ga_std_dzag[li_i].dzag009 CLIPPED,"','",ga_std_dzag[li_i].dzag010 CLIPPED,"',",
                                               "'",ga_std_dzag[li_i].dzag011 CLIPPED,"','",ga_std_dzag[li_i].dzag012 CLIPPED,"','",ga_std_dzag[li_i].dzag013 CLIPPED,"','",ga_std_dzag[li_i].dzag014 CLIPPED,"','",ga_std_dzag[li_i].dzag015 CLIPPED,"',",
                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",ga_std_dzag[li_i].dzagstus CLIPPED,"','",g_user,"')"
               
               PREPARE dzag_prep2 FROM ls_sql
               EXECUTE dzag_prep2 USING g_date
               FREE dzag_prep2
            END IF
         END FOR

         FOR li_i=1 TO ga_std_dzfs.getLength()
            #Begin:21060118 by Hiko
            LET li_cnt = 0
            SELECT COUNT(*) INTO li_cnt FROM dzfs_t
             WHERE dzfs002=g_prog
               AND dzfs001=p_revision
               AND dzfs003=ga_std_dzfs[li_i].dzfs003
               AND dzfs005=ga_std_dzfs[li_i].dzfs005
            #End:21060118 by Hiko

            IF li_cnt=0 THEN
               LET ls_sql = "INSERT INTO dzfs_t(dzfs001,dzfs002,dzfs003,dzfs004,dzfs005,",
                                               "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,",
                                               "dzfs011,dzfs012,",
                                               "dzfscrtdt,dzfscrtdp,dzfsowndp,dzfsownid,dzfsstus,dzfscrtid)",
                                       " VALUES(",p_revision,",'",g_prog,"','",ga_std_dzfs[li_i].dzfs003 CLIPPED,"','",ga_std_dzfs[li_i].dzfs004 CLIPPED,"','",ga_std_dzfs[li_i].dzfs005 CLIPPED,"',",
                                               "'",ga_std_dzfs[li_i].dzfs006 CLIPPED,"','",ga_std_dzfs[li_i].dzfs007 CLIPPED,"','",ga_std_dzfs[li_i].dzfs008 CLIPPED,"','",ga_std_dzfs[li_i].dzfs009 CLIPPED,"','",ga_std_dzfs[li_i].dzfs010 CLIPPED,"',",
                                               "'",ga_std_dzfs[li_i].dzfs011 CLIPPED,"','",ga_std_dzfs[li_i].dzfs012 CLIPPED,"',",
                                               "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",ga_std_dzfs[li_i].dzfsstus CLIPPED,"','",g_user,"')"
               
               PREPARE dzfs_prep2 FROM ls_sql
               EXECUTE dzfs_prep2 USING g_date
               FREE dzfs_prep2
            END IF
         END FOR
      END IF

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzam error!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzag_t(包含dzfs_t).
# Input parameter : po_industry_dzaf 行業程式DZAF_T資料
#                 : p_revision       要更新的識別碼版次
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2015/05/13 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_copy_dzag_t(po_industry_dzaf, p_revision)
   DEFINE po_industry_dzaf T_DZAF_T,
          p_revision       LIKE dzaa_t.dzaa004 
   DEFINE ls_sql     STRING,
          ls_trigger STRING,
          li_cnt     SMALLINT,
          l_dzaa004  LIKE dzaa_t.dzaa004,
          l_dzaa006  LIKE dzaa_t.dzaa006

   #備註:整段是從sadzp060_1_copy_dzag_t複製過來改的.
   TRY
      #先找行業規格目前的TABLE識別碼版次和使用標示.
      LET ls_sql = "SELECT dzaa004,dzaa006 FROM dzaa_t",
                   " WHERE dzaa001='",g_prog,"'",
                   "   AND dzaa002=",po_industry_dzaf.dzaf003,
                   "   AND dzaa003='TABLE'",
                   "   AND dzaa005='4'",
                   "   AND dzaa009='",po_industry_dzaf.dzaf010,"'"

      PREPARE dzag_prep11 FROM ls_sql
      EXECUTE dzag_prep11 INTO l_dzaa004
      FREE dzag_prep11
      LET ls_sql = NULL #20160118 by Hiko

      IF cl_null(l_dzaa004) OR l_dzaa004=0 THEN
         RETURN TRUE
      END IF

      #找看看行業規格有沒有本版次的TABLE設計資料
      LET li_cnt = 0
      LET ls_sql = "SELECT COUNT(*) FROM dzag_t",
                   " WHERE dzag001='",g_prog,"'",
                   "   AND dzag003=",p_revision,
                   "   AND dzag006='",l_dzaa006,"'"
      PREPARE dzag_prep10 FROM ls_sql
      EXECUTE dzag_prep10 INTO li_cnt
      FREE dzag_prep10
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料,將舊版複製為新版,狀態碼不變.
         LET ls_sql = "INSERT INTO dzag_t(dzag001,dzag002,dzag003,dzag004,dzag005,",
                                         "dzag006,dzag007,dzag008,dzag009,dzag010,",
                                         "dzag011,dzag012,dzag013,dzag014,dzag015,",
                                         "dzagcrtdt,dzagcrtdp,dzagowndp,dzagownid,dzagstus,dzagcrtid)",
                                 " SELECT dzag001,dzag002,",p_revision,",dzag004,dzag005,",
                                         "dzag006,dzag007,dzag008,dzag009,dzag010,",
                                         "dzag011,dzag012,dzag013,dzag014,dzag015,",
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"',dzagstus,'",g_user,"'",
                                   " FROM dzag_t",
                                  " WHERE dzag001='",g_prog,"'",
                                  "   AND dzag003=",l_dzaa004,
                                  "   AND dzag006='",l_dzaa006,"'"
         PREPARE dzag_prep12 FROM ls_sql
         EXECUTE dzag_prep12 USING g_date
         FREE dzag_prep12
         LET ls_sql = NULL #20160118 by Hiko
      END IF
	  
      #dzfs_t一起處理.
      #找看看行業規格有沒有本版次的SCREEN RECORD設計資料
      LET li_cnt = 0
      LET ls_sql = "SELECT COUNT(*) FROM dzfs_t",
                   " WHERE dzfs002='",g_prog,"'",
                   "   AND dzfs001=",p_revision,
                   "   AND dzfs005='",l_dzaa006,"'"
      PREPARE dzfs_prep10 FROM ls_sql
      EXECUTE dzfs_prep10 INTO li_cnt
      FREE dzfs_prep10
      LET ls_sql = NULL #20160118 by Hiko

      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料,將舊版複製為新版,狀態碼不變.
         LET ls_sql = "INSERT INTO dzfs_t(dzfs001,dzfs002,dzfs003,dzfs004,dzfs005,",
                                         "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,",
                                         "dzfs011,dzfs012,",
                                         "dzfscrtdt,dzfscrtdp,dzfsowndp,dzfsownid,dzfsstus,dzfscrtid)",
                                 " SELECT ",p_revision,",dzfs002,dzfs003,dzfs004,dzfs005,",
                                         "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,",
                                         "dzfs011,dzfs012,",
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"',dzfsstus,'",g_user,"'",
                                   " FROM dzfs_t",
                                  " WHERE dzfs002='",g_prog,"'",
                                  "   AND dzfs001=",l_dzaa004,
                                  "   AND dzfs005='",l_dzaa006,"'"
         PREPARE dzfs_prep12 FROM ls_sql
         EXECUTE dzfs_prep12 USING g_date
         FREE dzfs_prep12
         LET ls_sql = NULL #20160118 by Hiko
      END IF

      RETURN TRUE
   CATCH 
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 同步行業規格:dzam_t
# Input parameter : p_revision  要更新的識別碼版次
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2015/05/13 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_4_sync_dzam(p_revision)
   DEFINE p_revision LIKE dzaa_t.dzaa004
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          li_i       SMALLINT,
          li_cnt     SMALLINT

   TRY
      #排除控件(EXCLUDE)和表格設計資料(TABLE)一樣,都是將標準多餘行業的設計資料複製到行業規格內.
      FOR li_i=1 TO ga_std_dzam.getLength()
         LET li_cnt = 0
         SELECT COUNT(*) INTO li_cnt FROM dzam_t
          WHERE dzam001=g_prog
            AND dzam003=ga_std_dzam[li_i].dzam003
            AND dzam004=p_revision
            AND dzam005=ga_std_dzam[li_i].dzam005
         
         IF li_cnt=0 THEN                      
            LET ls_sql = "INSERT INTO dzam_t(dzam001,dzam002,dzam003,dzam004,dzam005,",
                                            "dzam006,",
                                            "dzamcrtdt,dzamcrtdp,dzamowndp,dzamownid,dzamstus,dzamcrtid)",
                                    " VALUES('",g_prog,"','",ga_std_dzam[li_i].dzam002 CLIPPED,"','",ga_std_dzam[li_i].dzam003 CLIPPED,"',",p_revision,",'",ga_std_dzam[li_i].dzam005 CLIPPED,"',",
                                            "'",ga_std_dzam[li_i].dzam006 CLIPPED,"',", 
                                            "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",ga_std_dzam[li_i].dzamstus CLIPPED,"','",g_user,"')"
            
            PREPARE dzam_prep2 FROM ls_sql
            EXECUTE dzam_prep2 USING g_date
            FREE dzam_prep2
         END IF
      END FOR

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
      RETURN FALSE,"ERROR : call sadzp060_4_sync_dzam error!"
   END TRY
END FUNCTION

#Begin:20160118 by Hiko
###########################################################################
## Access Modifier : PRIVATE 
## Descriptions    : 將程式同步資料寫入dzar_t內
## Input parameter : pr_std_dzba   標準dzba_t資料
##                 : p_ind_dzbb098 行業程式內容
##                 : p_std_dzbb098 標準程式內容
## Return code     : void
## Date & Author   : 2015/03/10 by Hiko
###########################################################################
#PRIVATE FUNCTION sadzp060_4_code_dzar_t(pr_std_dzba, p_ind_dzbb098, p_std_dzbb098)
#   DEFINE pr_std_dzba RECORD LIKE dzba_t.*,
#          p_ind_dzbb098      LIKE dzbb_t.dzbb098,
#          p_std_dzbb098      LIKE dzbb_t.dzbb098
#   DEFINE ls_trigger STRING,
#          ls_sql     STRING
#   
#   TRY
#      LET ls_sql = "INSERT INTO dzar_t(dzar001,dzar002,dzar003,dzar004,dzar005,",
#                                      "dzar006,dzar007,",
#                                      "dzarcrtdt,dzarcrtdp,dzarowndp,dzarownid,dzarcrtid)",
#                              " VALUES('",g_prog,"','CODE','dzbb_t','",pr_std_dzba.dzba003,"',",pr_std_dzba.dzba004,",",
#                                      "'",pr_std_dzba.dzba005,"','",pr_std_dzba.dzbastus,"',",
#                                      "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
#      
#      PREPARE dzar_prep2 FROM ls_sql
#      EXECUTE dzar_prep2 USING g_date
#      FREE dzar_prep2
#
#      UPDATE dzar_t 
#         SET dzar011=p_ind_dzbb098,dzar012=p_std_dzbb098
#       WHERE dzar001=g_prog
#         AND dzar003='dzbb_t'
#         AND dzar004=pr_std_dzba.dzba003
#   CATCH
#      CALL sadzp060_4_err_catch(ls_trigger, ls_sql)
#   END TRY
#END FUNCTION
#End:20160118 by Hiko
