#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/20
#
#+ 程式代碼......: sadzp063_1
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp063_1.4gl
# Description    : 設計資料刪除工具
# Modify         : 2014/10/24 by Hiko : 新建程式
# Modify         : 2014/12/11 by Hiko : 增加客製合併還原功能(刪除選項=5)
#                : 2015/01/12 by Hiko : UI設計資料要刪除dzfa_t
#                : 2015/03/05 by Hiko : 客製還原標準要先判斷是否存在標準設計資料
#                : 2015/04/20 by madey: 客製還原標準時:若為x/g類,提示要手動刪除azzi300/azzi301設定資料
#                : 2015/04/22 by Hiko : 客製還原標準時要判斷類型,這樣檢查dzaa_t才不會出錯
#                : 2015/04/30 by Hiko : 判斷是否可簽出改成環境變數TOPCHKOUT
#                : 2015/05/18 by Hiko : 報表元件的刪除改呼叫sadzp188_del_rep_data,完畢也不用特別提示還要刪除azzi300/azzi301.
#                : 2015/07/01 by madey: 因應支持qry透過設計器開發內容(hardcode)而調整
#                : 2015/07/10 by madey: 1.客製還原標準時，仍要重產4fd
#                                     : 2.重產4fd若編議失敗，仍繼續往下重產程式
#                : 2015/07/21 by madey: 函式sadzp063_1_del_unnecessary_spec_data增加處理資源池dzam_t/dzag_t/dzfs_t
#                : 2015/08/13 by madey: 選項3新增:刪除dzld_t(比照dzlm_t)
#                : 2015/09/01 by Hiko : 增加第6個選項:退回前一版
#                : 2015/09/08 by madey: hardcode qry客製退回標準時仍要r.l cqry
#                : 2015/09/18 by madey: 卡控:
#                                       1.在客戶環境下,程式若包含標準資料,不可以刪除(選項3),
#                                       2.在客戶環境下,程式若包含客製資料,不可以刪除(選項3),僅能還原成標準
#                                       3.god mode支持純標準程式的刪除(選項3)
#                : 2015/11/24 by Hiko : 不論情況都要刪除dzlm_t,但程式不能crash.
#                  20160330 160330-00030 by madey :刪除簽出記錄後都要提示(原本只有選項3才有)
#                  20160704 160704-00016 by madey :bug修正:count筆數太多overflow造成程式crash
#                  20160728 160728-00031 by madey :行業程式退回上一版時關注dzaq_t
#                  20161004 160922-00039 by Hiko : 退回上一版也要還原dzax_t.
#                  20170124 170124-00011 by madey: bug fix:
#                                                  1.刪除4rp時也要把相關多樣板一起刪除
#                                                  2.刪除4rp時也要刪除MNT4RP目錄內的資料
#                                                  3.g類退回前一版時,要把back內的4rp搬回去現有模組目錄內

import os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS
   DEFINE g_god_mode            BOOLEAN #20150918
   DEFINE gb_dzlm_t             BOOLEAN #160330-00030
   DEFINE g_topind              STRING  #所屬平台         #160728-00031
   DEFINE gb_ind                BOOLEAN #是否處於行業平台 #160728-00031
END GLOBALS

&include "../4gl/sadzp200_type.inc"
#Begin: 170124-00011 
&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp050_type.inc"
#End: 170124-00011

DEFINE g_date DATETIME YEAR TO SECOND

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 刪除所有設計資料
# Input parameter : p_prog 程式代號
#                 : p_type 建構類型
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/10/24 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp063_1_del_all_data(p_prog, p_type, p_module) 
   DEFINE p_prog   LIKE dzaf_t.dzaf001, #規格代號
          p_type   LIKE dzaf_t.dzaf005, #識別標示
          p_module LIKE dzaf_t.dzaf006  #模組
   DEFINE lo_dzaf T_DZAF_T,
          lb_return  BOOLEAN,
          ls_err_msg STRING

   LET lb_return = TRUE
   LET ls_err_msg = NULL
   IF cl_ask_confirm_parm("adz-00145","") THEN
      #全部刪除的話就不需要其他額外的資料,所以這樣就可以了.
      LET lo_dzaf.dzaf001 = p_prog CLIPPED
      LET lo_dzaf.dzaf005 = p_type CLIPPED
      LET lo_dzaf.dzaf006 = p_module CLIPPED
      
      CALL sadzp063_1_del_design_data(lo_dzaf.*, '3') RETURNING lb_return,ls_err_msg
   END IF

   RETURN lb_return,ls_err_msg   
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 刪除規格/程式設定檔
# Input parameter : po_dzaf DZAF_T物件
#                 : p_action 刪除選項(1,2,3,4,5)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING (錯誤訊息)
# Date & Author   : 2014/10/24 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp063_1_del_design_data(po_dzaf, p_action)
   DEFINE po_dzaf  T_DZAF_T,   
          p_action LIKE type_t.chr1   
   DEFINE l_prog     LIKE dzaf_t.dzaf001, #程式代號
          l_cons_ver LIKE dzaf_t.dzaf002, #建構版次
          l_spec_ver LIKE dzaf_t.dzaf003, #規格版次
          l_code_ver LIKE dzaf_t.dzaf004, #程式版次
          l_type     LIKE dzaf_t.dzaf005, #建構類型
          l_module   LIKE dzaf_t.dzaf006, #模組
          l_identity LIKE dzaf_t.dzaf010  #客製
   DEFINE ls_env STRING,
         #li_cnt SMALLINT,    #160704-00016 mark
          li_cnt INTEGER,     #160704-00016 add
          ls_err_code STRING,
          lb_return  BOOLEAN,
          ls_err_msg STRING,
          ls_cmd STRING,
          lo_new_std_DZAF T_DZAF_T,
          ls_module_path STRING,
          lb_intrans BOOLEAN
   #Begin:2014/12/11 by Hiko
   DEFINE l_merge_cons_ver LIKE dzap_t.dzap004, #客製合併來源的客製建構版次
          l_merge_spec_ver LIKE dzap_t.dzap005, #客製合併來源的規格建構版次
          l_merge_code_ver LIKE dzap_t.dzap006, #客製合併來源的程式建構版次
          lo_merge_cust_DZAF T_DZAF_T,
          ls_sql STRING
   #End:2014/12/11 by Hiko
   DEFINE li_regen     LIKE type_t.num5  #20150701 add
   DEFINE lb_have_cust BOOLEAN           #20150701 add
   DEFINE ls_err_msg_keep  STRING,       #20150710 add #合併錯誤訊息,先往下繼續,最後再一起顯示
          lb_err_msg_keep  BOOLEAN       #20150710 add 
   DEFINE lb_dzlm_t        BOOLEAN,      #是否有刪除簽出資料 20150813
          lb_dzld_t        BOOLEAN       #是否有刪除adzi888資料 20150813
  #DEFINE li_cnt_s SMALLINT,             #20150918 add #標準 #160704-00016 mark
  #       li_cnt_c SMALLINT              #20150918 add #客製 #160704-00016 mark
   DEFINE li_cnt_s INTEGER,              #標準               #160704-00016 add
          li_cnt_c INTEGER               #客製               #160704-00016 add
   DEFINE lr_dzay  RECORD LIKE dzay_t.* #160922-00039

   #Begin: 170124-00011
   DEFINE lo_program_info T_PROGRAM_INFO,
          lo_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
          ls_from_4fd STRING,
          ls_to_4fd_dir STRING,
          ls_to_4fd STRING,
          ls_from_4rp_dir STRING,
          ls_to_4rp_dir STRING,
          ls_to_4gl_dir STRING
   DEFINE lb_template_result BOOLEAN
   #End: 170124-00011
          
   TRY
      LET l_prog = po_dzaf.dzaf001
      LET l_cons_ver = po_dzaf.dzaf002
      LET l_spec_ver = po_dzaf.dzaf003
      LET l_code_ver = po_dzaf.dzaf004
      LET l_type = po_dzaf.dzaf005
      LET l_module = po_dzaf.dzaf006
      LET l_identity = po_dzaf.dzaf010
      LET ls_env = FGL_GETENV("DGENV") CLIPPED
      LET g_date = cl_get_current()

      DISPLAY "sadzp063_1_del_design_data start : ",l_prog," : ",l_identity,l_spec_ver,l_code_ver,l_type

      LET lb_intrans = FALSE
      LET ls_err_msg_keep = NULL  #20150710
      LET lb_err_msg_keep = FALSE #20150710
      LET lb_dzld_t = FALSE       #160330-00030

      #Begin: 170124-00011
      IF l_type = 'G' THEN
         CALL lo_template_list.CLEAR()
         LET lo_program_info.pi_MODULE = l_module
         LET lo_program_info.pi_NAME = l_prog
         CALL sadzp050_tple_get_template_records(g_lang, lo_program_info.*, lo_template_list) RETURNING lb_template_result,lo_template_list
      END IF
      #End: 170124-00011

      #IF cl_ask_confirm_parm("adz-00145","") THEN #因為每個呼叫端應用方式都不同,所以是否需要再次詢問就由呼叫端自行處理.
         CASE p_action
            WHEN "1" #清除規格異常資料:通常是在取消簽出失敗後執行,不包含標準變客製失敗,所以不用更新註冊資料的客製.
               #這時候的版次是已經還原,所以刪除大於此版次的設計資料.
               BEGIN WORK
               LET lb_intrans = TRUE #這是為了CATCH的時候使用
         
               CALL sadzp063_1_del_unnecessary_spec_data(l_prog, l_spec_ver, l_identity) RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

               COMMIT WORK
               LET lb_intrans = FALSE
                     
               #元件規格已經封印,所以就不需要再刪除元件規格樹了.

               IF l_type='M' OR l_type='S' OR l_type='F' OR l_type='Q' THEN #只有M/S/F才有4fd,Q類hard code也有
                  #重組4fd.
                  DISPLAY "sadzp063_1: call sadzp168_5(",l_prog,",",l_spec_ver USING "<<<" ,",",l_identity,",","TRUE)"
                  CALL sadzp168_5(l_prog, l_spec_ver, l_identity, TRUE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                    #LET ls_err_code = "adz-00034"
                    #GOTO _RTN_ERR

                     #20150710
                     #重產4fd若有錯,繼續往下重產4gl,錯誤訊息一併列出
                     LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00034",g_lang),"\n",ls_err_msg,"\n"
                     LET lb_err_msg_keep = TRUE
                  END IF
               END IF

               #重產4gl與編譯.
               IF l_type<>'F' THEN
                  CALL sadzp060_2_rc3(l_prog, po_dzaf.*, '0') RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                    #LET ls_err_code = "adz-00033"
                    #GOTO _RTN_ERR

                     #20150710
                     LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00128",g_lang),"\n",ls_err_msg,"\n"
                     LET lb_err_msg_keep = TRUE
                  END IF
               END IF

               #20150710
               IF lb_err_msg_keep THEN
                  LET ls_err_msg = ls_err_msg_keep
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

            WHEN "2" #清除程式異常資料:通常是在取消簽出失敗後執行,不包含標準變客製失敗,所以不用更新註冊資料的客製.
               #這時候的版次是已經還原,所以刪除大於此版次的設計資料.
               BEGIN WORK
               LET lb_intrans = TRUE #這是為了CATCH的時候使用
         
               CALL sadzp063_1_del_unnecessary_code_data(l_prog, l_code_ver, l_identity) RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

               COMMIT WORK
               LET lb_intrans = FALSE
         
               #重產4gl與編譯.
               CALL sadzp060_2_rc3(l_prog, po_dzaf.*, '0') RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00033"
                  GOTO _RTN_ERR
               END IF

            WHEN "3" #刪除程式(重新r.a):將所有設計資料(含離線檔案)不分版次全部刪除,同時一併刪除簽出資料.
 
               #20150918 -Begin-
               #檢查包含標準(s)資料
               LET li_cnt_s=0
               SELECT count(*) INTO li_cnt_s
                 FROM dzaf_t af1
                WHERE af1.dzaf001=l_prog
                  AND af1.dzaf005<>'T'
                  AND EXISTS (
                      SELECT 1 FROM dzaf_t af2
                       WHERE af2.dzaf001=af1.dzaf001
                         AND af2.dzaf005<>'T'
                         AND af2.dzaf010='s'
                      )
               #檢查包含客製(c)資料
               LET li_cnt_c=0
               SELECT count(*) INTO li_cnt_c
                 FROM dzaf_t af1
                WHERE af1.dzaf001=l_prog
                  AND af1.dzaf005<>'T'
                  AND EXISTS (
                      SELECT 1 FROM dzaf_t af2
                       WHERE af2.dzaf001=af1.dzaf001
                         AND af2.dzaf005<>'T'
                         AND af2.dzaf010='c'
                      )
               #卡控
               IF ls_env="c" THEN
               #在客製環境下,只要存在s的資料(標準轉客製的程式),就不能夠重來.
                  IF li_cnt_c > 0 THEN
                    #有客製
                     IF li_cnt_s > 0 THEN
                        #標準轉客製
                        LET ls_err_code = "adz-00706" #引導至客製還原標準 
                        GOTO _RTN_ERR                
                     ELSE 
                        #純客製
                        #do nothing 不卡控
                     END IF
                  ELSE
                    #純標準(無客製)
                     IF g_god_mode THEN
                       #do nothing 開放god mode可以刪除純標準程式
                     ELSE
                       LET ls_err_code = "adz-00705" 
                       GOTO _RTN_ERR                 
                     END IF
                  END IF
               ELSE
                  IF ls_env="s" THEN
                    #在標準環境下,只要存在c的資料(標準轉客製的程式或單純客製程式),就不能夠重來

                    #以下作廢,因為不允許topstd帳號操作,所以dgenv=s表示產中環境不--> 不會有客製資料
                    #IF li_cnt_c >0 THEN
                    #   LET ls_err_code = "adz-00423"
                    #   GOTO _RTN_ERR
                    #END IF
                   END IF
               END IF
               #20150918 -End-

               #20150701 -Begin-
               #屬於標準轉客製的qry ,且標準為Hard Code的:無法還原Hard Code=N,因為底下的刪除dza*_t的動作,會連同標準的資料一起砍掉
               CALL sadzp210_check_qry_have_cust(l_prog) RETURNING li_cnt ,lb_have_cust
               IF lb_have_cust AND li_cnt > 1 THEN
                  IF sadzp210_check_qry_hardcode(l_prog,"s") THEN
                     LET ls_err_msg = cl_getmsg('adz-00643',g_lang)
                     LET ls_err_code = "adz-00023"
                     GOTO _RTN_ERR
                  END IF
               END IF
               #20150701 -End-

               BEGIN WORK
               LET lb_intrans = TRUE #這是為了CATCH的時候使用


               CALL sadzp063_1_del_all_design_data(l_prog) RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF
               
               DISPLAY "DELETE r.a DATA..."
               DISPLAY "delete r.a data : CALL sadzp168_1_del"
               CALL sadzp168_1_del(l_prog) RETURNING lb_return #失敗沒關係
                     
               DISPLAY "DELETE PROG VER DATA..."
               #刪除簽出入與版次資料.
               #IF FGL_GETENV("TOPCHKOUT")="Y" THEN #2015/04/30 by Hiko #2015/11/24 by Hiko:不會權限不夠了
                  #20150813 -Modify-
                 #LET lb_dzlm_t = FALSE                                                           #160330-00030 mark
                 #LET lb_dzld_t = FALSE                                                           #160330-00030 mark
                 #LET li_cnt=0                                                                    #160330-00030 mark
                 #SELECT COUNT(*) INTO li_cnt FROM dzlm_t WHERE dzlm001=l_type AND dzlm002=l_prog #160330-00030 mark
                 #IF li_cnt >0 THEN                                                               #160330-00030 mark
                     DISPLAY "delete dzlm_t"
                     DELETE FROM dzlm_t WHERE dzlm001=l_type AND dzlm002=l_prog
                 #   LET lb_dzlm_t = TRUE                                                         #160330-00030 mark
                 #END IF                                                                          #160330-00030 mark
                  LET li_cnt=0
                  SELECT COUNT(*) INTO li_cnt FROM dzld_t WHERE dzld006=l_prog
                  IF li_cnt >0 THEN
                     DISPLAY "delete dzld_t"
                     DELETE FROM dzld_t WHERE dzld006=l_prog
                     LET lb_dzld_t = TRUE
                  END IF
                  #20150813 -Modify-
               #END IF
               
               DISPLAY "delete dzaf_t"
               DELETE FROM dzaf_t WHERE dzaf001=l_prog AND dzaf005=l_type

               #Begin:2015/11/24 by Hiko
               IF g_god_mode THEN #god modle才有可能會刪除已經出貨的程式,所以必須將出貨清單清除.
                  DISPLAY "delete dzyf_t"
                  DELETE FROM dzyf_t WHERE dzyf001=l_prog #2015/11/25 by Hiko
               END IF
               #End:2015/11/24 by Hiko
      
               COMMIT WORK
               LET lb_intrans = FALSE
         
               #刪除離線檔案:失敗也沒關係
               LET ls_module_path = FGL_GETENV(UPSHIFT(l_module))
               IF cl_change_dir(ls_module_path) THEN
                  LET ls_cmd = "rm -f */",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  LET ls_cmd = "rm -f 42m/*_",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  LET ls_cmd = "rm -f */*/",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  LET ls_cmd = "rm -f */*/*/",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  #Begin: 170124-00011
                  IF l_type ='G' THEN
                     #現行模組4rp目錄
                     LET ls_from_4rp_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp")
                     DISPLAY "sadzp063_1 :delete 4rp from : ",ls_from_4rp_dir
                     CALL sadzp050_zip_delete_4rp_files(l_prog, ls_from_4rp_dir, lo_template_list) RETURNING lb_template_result

                     #現行模組4rp/back目錄
                     LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp"), "back")
                     DISPLAY "sadzp063_1 :delete 4rp from ",ls_from_4rp_dir
                     CALL sadzp050_zip_delete_4rp_files(l_prog, ls_from_4rp_dir, lo_template_list) RETURNING lb_template_result

                     #MNT4RP:現行模組4rp目錄
                     LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(cl_rpt_get_env_global("MNT4RP") CLIPPED, DOWNSHIFT(l_module)), "4rp")
                     DISPLAY "sadzp063_1 :delete 4rp from ",ls_from_4rp_dir
                     CALL sadzp050_zip_delete_4rp_files(l_prog, ls_from_4rp_dir, lo_template_list) RETURNING lb_template_result
                  END IF
                  #End: 170124-00011
               ELSE
                  DISPLAY "sadzp063_1 : change dir to ",ls_module_path," faulure!"
               END IF

               #20150701 -Begin-
               #刪除dza*_t的設計資料時，r.q設計資料不動，僅把hardcode由Y變回N,並以r.q樣版為主,重產這支程式
               IF l_type = 'Q' THEN
                  DISPLAY "call sadzp210_sync_qry('",l_prog,"','delete') :set r.q hardcode=N,and re-gen 4gl/4fd "
                  CALL sadzp210_sync_qry(l_prog,'delete') RETURNING lb_RETURN,li_regen,ls_err_msg
                  IF NOT lb_return THEN
                     LET ls_err_code = "adz-00023"
                     GOTO _RTN_ERR
                  END IF
               END IF
               #20150701 -End-

               #20150701 -Begin-
               #主程式及子畫面以外的其他類型,要重新連結有使用到的程式
               IF l_type ='M' OR l_type ='Z' OR l_type='F' OR l_type='Q' THEN
                  #do nothing
               ELSE
                  LET ls_cmd = "r.l ",l_prog," ALL " 
                  DISPLAY ls_cmd 
                  CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF
               END IF
               #20150701 -End-

            WHEN "4" #客製退回標準:有兩種情況會選擇此項:a.簽出標準變客製失敗,b.刪除客製改使用標準程式.
               BEGIN WORK
               LET lb_intrans = TRUE #這是為了CATCH的時候使用

               #20150701 -Begin-
               #刪除r.q設計資料(客製的)
               IF l_type = 'Q' THEN
                  DISPLAY "call sadzp210_sync_qry('",l_prog,"','cust_to_std') :delete dzca_t,dzcb_t,dzcc_t"
                  CALL sadzp210_sync_qry(l_prog,'cust_to_std') RETURNING lb_return,li_regen,ls_err_msg
                  IF NOT lb_return THEN
                     LET ls_err_code = "adz-00023"
                     GOTO _RTN_ERR
                  END IF
               END IF
               #20150701 -End-

               #Begin:2015/03/05 by Hiko:先檢查是否有標準設計資料 
               #Begin:2015/04/22 by Hiko
               IF l_type = 'F' THEN
                  SELECT COUNT(*) INTO li_cnt FROM dzaa_t WHERE dzaa001=l_prog AND dzaa009='s'
               ELSE
                  SELECT COUNT(*) INTO li_cnt FROM dzba_t WHERE dzba001=l_prog AND dzba010='s'
               END IF
               #End:2015/04/22 by Hiko
               IF li_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00559" #此程式不存在標準設計資料,所以不能執行還原標準.
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = ls_err_msg
                  CALL cl_err()
                  RETURN TRUE,NULL
               END IF
               #End:2015/03/05 by Hiko
 
               CALL sadzp063_1_del_cust_data(l_prog) RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

               DISPLAY "DELETE PROG VER DATA..."
               #刪除簽出入與版次資料.
               #IF FGL_GETENV("TOPCHKOUT")="Y" THEN #2015/04/30 by Hiko #2015/11/24 by Hiko:不會權限不夠了
                  DISPLAY "delete dzlm_t"
                  DELETE FROM dzlm_t WHERE dzlm001=l_type AND dzlm002=l_prog #dzlm_t沒有"客製"標示,且出貨時並沒有標準程式的dzlm_t,所以還原為標準時整個刪除也是正確的.
               #END IF
               
               DISPLAY "delete dzaf_t"
               DELETE FROM dzaf_t WHERE dzaf001=l_prog AND dzaf005=l_type AND dzaf010='c'

      
               COMMIT WORK
               LET lb_intrans = FALSE
         
               #20150701 -Begin-
               IF l_type = 'Q' THEN
                  #20150908 -Begin-
                  LET ls_cmd = "r.l cqry"
                  DISPLAY ls_cmd 
                  CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF
                  #20150908 -End-
               ELSE
               #20150701 -End-
                  #將註冊資料的[客製]改為s.
                  CALL s_azzi900_upd_gzza011(l_prog, l_type, "s") RETURNING lb_return
                  IF NOT lb_return THEN
                     LET ls_err_code = "adz-00023"
                     LET ls_err_msg = "Updated registration information failure!"
                     GOTO _RTN_ERR
                  END IF
               END IF #20150701

               #最後要移除客製的離線檔案:失敗也沒關係
               CALL sadzp062_1_translate_cust_module(UPSHIFT(l_module)) RETURNING l_module 
               LET ls_module_path = FGL_GETENV(UPSHIFT(l_module)) #這個是客製模組
               IF cl_change_dir(ls_module_path) THEN
                  LET ls_cmd = "rm -f */",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  LET ls_cmd = "rm -f 42m/*_",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  LET ls_cmd = "rm -f */*/",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  LET ls_cmd = "rm -f */*/*/",l_prog,".*" 
                  CALL cl_cmdrun_openpipe("rm", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF

                  #Begin: 170124-00011
                  IF l_type ='G' THEN
                     #現行模組4rp目錄
                     LET ls_from_4rp_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp")
                     DISPLAY "sadzp063_1 :delete 4rp from : ",ls_from_4rp_dir
                     CALL sadzp050_zip_delete_4rp_files(l_prog, ls_from_4rp_dir, lo_template_list) RETURNING lb_template_result

                     #現行模組4rp/back目錄
                     LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp"), "back")
                     DISPLAY "sadzp063_1 :delete 4rp from ",ls_from_4rp_dir
                     CALL sadzp050_zip_delete_4rp_files(l_prog, ls_from_4rp_dir, lo_template_list) RETURNING lb_template_result

                     #MNT4RP:現行模組4rp目錄
                     LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(cl_rpt_get_env_global("MNT4RP") CLIPPED, DOWNSHIFT(l_module)), "4rp")
                     DISPLAY "sadzp063_1 :delete 4rp from ",ls_from_4rp_dir
                     CALL sadzp050_zip_delete_4rp_files(l_prog, ls_from_4rp_dir, lo_template_list) RETURNING lb_template_result
                  END IF
                  #End: 170124-00011
               ELSE
                  DISPLAY "sadzp063_1 : change dir to ",ls_module_path," faulure!"
               END IF

               #20150701 -Begin-
               IF l_type ='Q' AND (li_regen=0 OR li_regen=1) THEN
                  #Q類且li_regen=0 :不用重產
                  #Q類且li_regen=1 :重產,但走r.q設計資料重產,表示:標準為非hard code ,客製為hardcode
                  #Q類且li_regen=2 :重產,但走r.c3重產,       表示:標準為hard code   ,客製是hardcode
               ELSE
               #20150701 -End-

                  #取得目前(patch之後)dzaf_t內最大的標準版次資料 
                  CALL sadzi888_07_get_curr_ver_info_by_flag(po_dzaf.*, "s") RETURNING ls_err_msg,lo_new_std_DZAF.*
                  IF cl_null(ls_err_msg) THEN
                     LET l_spec_ver=lo_new_std_DZAF.dzaf003
                     LET l_identity=lo_new_std_DZAF.dzaf010

                     IF l_type='M' OR l_type='S' OR l_type='F' OR l_type='Q' THEN #只有M/S/F才有4fd,Q類hard code也有
                        #重組4fd.
                        DISPLAY "sadzp063_1: call sadzp168_5(",l_prog,",",l_spec_ver USING "<<<" ,",",l_identity,",","TRUE)"
                        CALL sadzp168_5(l_prog, l_spec_ver, l_identity, TRUE) RETURNING lb_return,ls_err_msg
                        IF NOT lb_return THEN
                          #LET ls_err_code = "adz-00034"
                          #GOTO _RTN_ERR

                           #20150710
                           #重產4fd若有錯,繼續往下重產4gl,錯誤訊息一併列出
                           LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00034",g_lang),"\n",ls_err_msg,"\n"
                           LET lb_err_msg_keep = TRUE
                        END IF
                     END IF

                     #重產4gl與編譯.
                     CALL sadzp060_2_rc3(l_prog, lo_new_std_DZAF.*, '0') RETURNING lb_return,ls_err_msg
                     IF NOT lb_return THEN
                       #LET ls_err_code = "adz-00023"
                       #GOTO _RTN_ERR

                        #20150710
                        LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00128",g_lang),"\n",ls_err_msg,"\n"
                        LET lb_err_msg_keep = TRUE
                     END IF
                  ELSE
                     LET ls_err_code = "adz-00023"
                     LET ls_err_msg = "Get the standard dzaf_t info error!"
                     GOTO _RTN_ERR
                  END IF

               END IF #20150701
            
               ##20150701 -Begin-
               #主程式及子畫面以外的其他類型,要重新連結有使用到的程式
               IF l_type ='M' OR l_type ='Z' OR l_type='F' THEN
                  #do nothing
               ELSE
                  LET ls_cmd = "r.l ",l_prog," ALL " 
                  CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     DISPLAY "sadzp063_1 : ",ls_cmd," faulure!"
                  END IF
               END IF
               ##20150701 -End-

               IF lb_err_msg_keep THEN
                  LET ls_err_msg = ls_err_msg_keep
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF


            WHEN "5" #還原客製合併:清除客製合併後的設計資料
               #合併當時的來源客製建構版次和目前客製建構版次只能差1版(dzaf002)
               #取得合併來源的客製建構版次
               SELECT dzap004,dzap005,dzap006 INTO l_merge_cons_ver,l_merge_spec_ver,l_merge_code_ver
                 FROM dzap_t WHERE dzap001=l_prog AND dzap010='Y'
               #l_cons_ver:目前最大的客製建構版次
               DISPLAY "Hiko:l_merge_cons_ver=",l_merge_cons_ver
               DISPLAY "Hiko:l_merge_spec_ver=",l_merge_spec_ver
               DISPLAY "Hiko:l_merge_code_ver=",l_merge_code_ver
               DISPLAY "Hiko:l_cons_ver=",l_cons_ver
               IF (l_cons_ver-l_merge_cons_ver)<>1 THEN
                  DISPLAY "Hiko:不能客製還原"
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00480"
                  LET g_errparam.replace[1] = l_merge_cons_ver
                  LET g_errparam.replace[2] = l_cons_ver
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN FALSE,NULL
               END IF

               BEGIN WORK
               LET lb_intrans = TRUE #這是為了CATCH的時候使用
         
               CALL sadzp063_1_del_unnecessary_spec_data(l_prog, l_merge_spec_ver, "c") RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

               CALL sadzp063_1_del_unnecessary_code_data(l_prog, l_merge_code_ver, "c") RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

               DISPLAY "DELETE PROG VER DATA..."
               #刪除簽出入與版次資料.
               #IF FGL_GETENV("TOPCHKOUT")="Y" THEN #2015/04/30 by Hiko #2015/11/24 by Hiko:不會權限不夠了
                  DISPLAY "delete dzlm_t"
                  DELETE FROM dzlm_t WHERE dzlm001=l_type AND dzlm002=l_prog AND dzlm005=l_cons_ver
               #END IF
               
               DISPLAY "delete dzaf_t"
               DELETE FROM dzaf_t WHERE dzaf001=l_prog AND dzaf002=l_cons_ver AND dzaf005=l_type AND dzaf010='c'

               DISPLAY "update dzap_t"
               SELECT COUNT(*) INTO li_cnt FROM dzap_t WHERE dzap001=l_prog
               IF li_cnt>0 THEN
                  LET ls_sql = "UPDATE dzap_t SET dzap010=?,",
                                                 "dzapmoddt=?,",
                                                 "dzapmodid=?",
                               " WHERE dzap001=?"
                  PREPARE upd_dzap_prep2 FROM ls_sql
                  EXECUTE upd_dzap_prep2 USING "N",g_date,g_user,l_prog
                  FREE upd_dzap_prep2
               END IF

               COMMIT WORK
               LET lb_intrans = FALSE

               IF l_type='M' OR l_type='S' OR l_type='F' OR l_type='Q' THEN #只有M/S/F才有4fd,Q類hard code也有
                  #重組4fd,失敗也沒關係
                  DISPLAY "sadzp063_1: call sadzp168_5(",l_prog,",",l_spec_ver USING "<<<" ,",",l_identity,",","TRUE)"
                  CALL sadzp168_5(l_prog, l_merge_spec_ver, "c", TRUE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                    #LET ls_err_code = "adz-00034" 
                    #GOTO _RTN_ERR #因為前面已經COMMIT,所以這邊直接GOTO也可以

                     #20150710
                     #重產4fd若有錯,繼續往下重產4gl,錯誤訊息一併列出
                     LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00034",g_lang),"\n",ls_err_msg,"\n"
                     LET lb_err_msg_keep = TRUE
                  END IF
               END IF

               #重產4gl與編譯,失敗也沒關係
               IF l_type<>'F' THEN
                  #建立原本的dzaf_t
                  CALL sadzp060_2_get_curr_ver_info_by_dzaf002(l_prog, l_type, l_module, l_merge_cons_ver) RETURNING lo_merge_cust_DZAF.*,ls_err_msg
                  IF cl_null(ls_err_msg) THEN
                     CALL sadzp060_2_rc3(l_prog, lo_merge_cust_DZAF.*, '0') RETURNING lb_return,ls_err_msg
                     IF NOT lb_return THEN
                       #LET ls_err_code = "adz-00033" #因為前面已經COMMIT,所以這邊直接GOTO也可以
                       #GOTO _RTN_ERR

                        #20150710
                        LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00128",g_lang),"\n",ls_err_msg,"\n"
                        LET lb_err_msg_keep = TRUE
                     END IF
                  ELSE
                     LET ls_err_code = "adz-00023"
                     GOTO _RTN_ERR
                  END IF
               END IF

               #20150710
               IF lb_err_msg_keep THEN
                  LET ls_err_msg = ls_err_msg_keep
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF

            WHEN "6" #退回上一版
               BEGIN WORK
               LET lb_intrans = TRUE #這是為了CATCH的時候使用
               
               #刪除上一版的簽出資料.
               #IF FGL_GETENV("TOPCHKOUT")="Y" THEN #2015/11/24 by Hiko:不會權限不夠了
                  DISPLAY "delete dzlm_t"
                  DELETE FROM dzlm_t WHERE dzlm001=l_type AND dzlm002=l_prog AND dzlm005>l_cons_ver
               #END IF
               
               #刪除上一版的版次資料.
               DISPLAY "delete dzaf_t"
               DELETE FROM dzaf_t WHERE dzaf001=l_prog AND dzaf002>l_cons_ver AND dzaf005=l_type AND dzaf010=l_identity
               
               #刪除上一版的規格資料.
               CALL sadzp063_1_del_unnecessary_spec_data(l_prog, l_spec_ver, l_identity) RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF
               
               #刪除上一版的程式資料.
               CALL sadzp063_1_del_unnecessary_code_data(l_prog, l_code_ver, l_identity) RETURNING lb_return,ls_err_msg
               IF NOT lb_return THEN
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF
   
               #Begin: 160728-00031
               #行業程式退版要dzaq_t
               IF gb_ind THEN
                  #此處直接用gb_ind的原因adzp063有管制行業平台下只能挑選到行業程式
                  CALL sadzp063_1_chk_and_upd_dzaq_t(po_dzaf.*) RETURNING lb_return,ls_err_msg
                  #遇錯先忽略
               END IF
               #End: 160728-00031
               
               #Begin:160922-00039
               SELECT COUNT(*) INTO li_cnt FROM dzay_t WHERE dzay001=l_prog
               IF li_cnt>0 THEN
                  SELECT * INTO lr_dzay.* FROM dzay_t WHERE dzay001=l_prog

                  DISPLAY "Revert dzax_t..."

                  UPDATE dzax_t SET dzax002=lr_dzay.dzay002,dzax003=lr_dzay.dzay003,dzax007=lr_dzay.dzay004
                   WHERE dzax001=l_prog AND dzax006=l_identity
               END IF
               #End:160922-00039

               COMMIT WORK

               #Begin: 170124-00011
               IF l_type ='G' THEN
                  #現行模組back目錄搬回4rp目錄
                  LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp"), "back")
                  LET ls_to_4rp_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp")
                  DISPLAY "sadzp063_1 :copy 4rp from : ",ls_from_4rp_dir
                  DISPLAY "sadzp063_1 :copy 4rp to   : ",ls_to_4rp_dir
                  CALL sadzp050_zip_moving_4rp_files(l_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_template_result

                  #現行模組back搬回MNT4RP目錄
                  LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(FGL_GETENV(UPSHIFT(l_module)), "4rp"), "back")
                  LET ls_to_4rp_dir = os.path.JOIN(os.path.JOIN(cl_rpt_get_env_global("MNT4RP") CLIPPED, DOWNSHIFT(l_module)), "4rp")
                  DISPLAY "sadzp063_1 :copy 4rp from : ",ls_from_4rp_dir
                  DISPLAY "sadzp063_1 :copy 4rp to   : ",ls_to_4rp_dir
                  CALL sadzp050_zip_moving_4rp_files(l_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_template_result
               END IF
               #End: 170124-00011

               LET lb_intrans = FALSE
                     
               IF l_type='M' OR l_type='S' OR l_type='F' OR l_type='Q' THEN #只有M/S/F/Q類hard code才有4fd.
                  #重組4fd.
                  DISPLAY "sadzp063_1: call sadzp168_5(",l_prog,",",l_spec_ver USING "<<<" ,",",l_identity,",","TRUE)"
                  CALL sadzp168_5(l_prog, l_spec_ver, l_identity, TRUE) RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     #重產4fd若有錯,繼續往下重產4gl,錯誤訊息一併列出
                     LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00034",g_lang),"\n",ls_err_msg,"\n"
                     LET lb_err_msg_keep = TRUE
                  END IF
               END IF
               
               #重產4gl與編譯.
               IF l_type<>'F' THEN
                  CALL sadzp060_2_rc3(l_prog, po_dzaf.*, '0') RETURNING lb_return,ls_err_msg
                  IF NOT lb_return THEN
                     LET ls_err_msg_keep = ls_err_msg_keep,cl_getmsg("adz-00128",g_lang),"\n",ls_err_msg,"\n"
                     LET lb_err_msg_keep = TRUE
                  END IF
               END IF
               
               IF lb_err_msg_keep THEN
                  LET ls_err_msg = ls_err_msg_keep
                  LET ls_err_code = "adz-00023"
                  GOTO _RTN_ERR
               END IF
         END CASE 

         CALL sadzp063_1_del_log(po_dzaf.*, p_action)
         CALL cl_ask_pressanykey("adz-00294") #成功

         #20150813 -Begin-
         #重新r.a時,若有刪除dzlm_t或dzld_t資料時，彈窗提示
        #Begin: 160330-00030 modify
        #IF p_action="3" AND (lb_dzlm_t OR lb_dzld_t) THEN
        #   IF lb_dzlm_t THEN
         IF gb_dzlm_t OR lb_dzld_t THEN
            IF gb_dzlm_t THEN
        #End: 160330-00030 modify
               LET ls_err_msg = ls_err_msg,cl_getmsg('adz-00681',g_lang),ASCII 10
            END IF
            IF lb_dzld_t THEN
               LET ls_err_msg = ls_err_msg,cl_getmsg('adz-00682',g_lang)
            END IF
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00023"
            LET g_errparam.popup = TRUE
            LET g_errparam.type = "2"
            LET g_errparam.replace[1] = ls_err_msg
            CALL cl_err()
         END IF
         #20150813 -End-
         
      #END IF

      RETURN TRUE,NULL

     LABEL _RTN_ERR:
         IF lb_intrans THEN
            ROLLBACK WORK
         END IF

         CALL sadzp063_1_del_log(po_dzaf.*, p_action)

         DISPLAY ls_err_msg
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = ls_err_code
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = ls_err_msg
         CALL cl_err()
         RETURN FALSE,ls_err_msg #2014/12/11 by Hiko:原本是RETURN TRUE

   CATCH 
      IF lb_intrans THEN
         ROLLBACK WORK
      END IF

      CALL sadzp063_1_del_log(po_dzaf.*, p_action)

      RETURN FALSE,"ERROR : delete design data failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 清除規格異常資料
# Input parameter : p_prog 程式代號
#                 : p_spec_ver 規格版次
#                 : p_identity 客製
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/10/24 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp063_1_del_unnecessary_spec_data(p_prog, p_spec_ver, p_identity) 
   DEFINE p_prog     LIKE dzaf_t.dzaf001, #規格代號
          p_spec_ver LIKE dzaf_t.dzaf003, #規格版次
          p_identity LIKE dzaf_t.dzaf010  #客製

   TRY
      #刪除規格樹.
      DISPLAY "DELETE SPEC TREE..."
      DISPLAY "delete dzaa_t"
      DELETE FROM dzaa_t WHERE dzaa001=p_prog AND dzaa002>p_spec_ver AND dzaa009=p_identity

      #20150721 -Begin-
      DISPLAY "delete dzam_t"
      DELETE FROM dzam_t WHERE dzam001=p_prog AND dzam004>p_spec_ver AND dzam005=p_identity
      DISPLAY "delete dzag_t"
      DELETE FROM dzag_t WHERE dzag001=p_prog AND dzag003>p_spec_ver AND dzag006=p_identity
      DISPLAY "delete dzfs_t"
      DELETE FROM dzfs_t WHERE dzfs002=p_prog AND dzfs001>p_spec_ver AND dzfs005=p_identity
      #20150721 -End-
      
      DISPLAY "DELETE 4fd TREE..."
      DISPLAY "delete dzfa_t"
      DELETE FROM dzfa_t WHERE dzfa001=p_prog AND dzfa006>p_spec_ver AND dzfa003=p_identity #2015/01/12 by Hiko
      DISPLAY "delete dzfb_t"
      DELETE FROM dzfb_t WHERE dzfb001=p_prog AND dzfb002>p_spec_ver AND dzfb007=p_identity
      DISPLAY "delete dzfi_t"
      DELETE FROM dzfi_t WHERE dzfi001=p_prog AND dzfi002>p_spec_ver AND dzfi009=p_identity
      DISPLAY "delete dzfj_t"
      DELETE FROM dzfj_t WHERE dzfj001=p_prog AND dzfj002>p_spec_ver AND dzfj017=p_identity
      DISPLAY "delete dzfk_t"
      DELETE FROM dzfk_t WHERE dzfk001=p_prog AND dzfk002>p_spec_ver AND dzfk007=p_identity
      DISPLAY "delete dzfl_t"
      DELETE FROM dzfl_t WHERE dzfl001=p_prog AND dzfl002>p_spec_ver AND dzfl007=p_identity

      RETURN TRUE,NULL
   CATCH 
      RETURN FALSE,"ERROR : delete spec design data failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 清除程式異常資料
# Input parameter : p_prog 程式代號
#                 : p_code_ver 程式版次
#                 : p_identity 客製
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/10/24 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp063_1_del_unnecessary_code_data(p_prog, p_code_ver, p_identity) 
   DEFINE p_prog     LIKE dzaf_t.dzaf001, #程式代號
          p_code_ver LIKE dzaf_t.dzaf004, #程式版次
          p_identity LIKE dzaf_t.dzaf010  #客製

   TRY
      #刪除程式樹.
      DISPLAY "DELETE CODE TREE..."
      DISPLAY "delete dzba_t"
      DELETE FROM dzba_t WHERE dzba001=p_prog AND dzba002>p_code_ver AND dzba010=p_identity
      DISPLAY "DELETE SECTION TREE..."
      DISPLAY "delete dzbc_t"
      DELETE FROM dzbc_t WHERE dzbc001=p_prog AND dzbc002>p_code_ver AND dzbc007=p_identity
      
      #刪除報表元件設計資料. #這邊不用改成sadzp188_del_rep_data
      DISPLAY "DELETE REPORT COMP DATA..."
      DISPLAY "delete dzga_t"
      DELETE FROM dzga_t WHERE dzga001=p_prog AND dzga002>p_code_ver AND dzga006=p_identity
      DISPLAY "delete dzgb_t"
      DELETE FROM dzgb_t WHERE dzgb001=p_prog AND dzgb002>p_code_ver AND dzgb019=p_identity
      DISPLAY "delete dzgc_t"
      DELETE FROM dzgc_t WHERE dzgc001=p_prog AND dzgc002>p_code_ver AND dzgc009=p_identity
      DISPLAY "delete dzgd_t"
      DELETE FROM dzgd_t WHERE dzgd001=p_prog AND dzgd002>p_code_ver AND dzgd008=p_identity
      DISPLAY "delete dzge_t"
      DELETE FROM dzge_t WHERE dzge001=p_prog AND dzge002>p_code_ver AND dzge009=p_identity
      DISPLAY "delete dzgf_t"
      DELETE FROM dzgf_t WHERE dzgf001=p_prog AND dzgf002>p_code_ver AND dzgf012=p_identity
      DISPLAY "delete dzgg_t"
      DELETE FROM dzgg_t WHERE dzgg001=p_prog AND dzgg002>p_code_ver AND dzgg017=p_identity
      DISPLAY "delete dzgh_t"
      DELETE FROM dzgh_t WHERE dzgh001=p_prog AND dzgh002>p_code_ver AND dzgh012=p_identity
      DISPLAY "delete dzgi_t"
      DELETE FROM dzgi_t WHERE dzgi001=p_prog AND dzgi002>p_code_ver AND dzgi006=p_identity
      DISPLAY "delete dzgj_t"
      DELETE FROM dzgj_t WHERE dzgj001=p_prog AND dzgj002>p_code_ver AND dzgj008=p_identity
      DISPLAY "delete dzgl_t"
      DELETE FROM dzgl_t WHERE dzgl001=p_prog AND dzgl002>p_code_ver AND dzgl030=p_identity

      RETURN TRUE,NULL
   CATCH 
      RETURN FALSE,"ERROR : delete code design data failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 清除所有設計資料
# Input parameter : p_prog 程式代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/10/24 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp063_1_del_all_design_data(p_prog) 
   DEFINE p_prog LIKE dzaf_t.dzaf001 #程式代號

   TRY
      #刪除規格設計資料.
      DISPLAY "DELETE SPEC DATA..."
      DISPLAY "delete dzax_t"
      DELETE FROM dzax_t WHERE dzax001=p_prog
      DISPLAY "delete dzaa_t"
      DELETE FROM dzaa_t WHERE dzaa001=p_prog
      DISPLAY "delete dzab_t"
      DELETE FROM dzab_t WHERE dzab001=p_prog
      DISPLAY "delete dzac_t"
      DELETE FROM dzac_t WHERE dzac001=p_prog
      DISPLAY "delete dzak_t"
      DELETE FROM dzak_t WHERE dzak001=p_prog
      DISPLAY "delete dzal_t"
      DELETE FROM dzal_t WHERE dzal001=p_prog
      DISPLAY "delete dzad_t"
      DELETE FROM dzad_t WHERE dzad001=p_prog
      DISPLAY "delete dzag_t"
      DELETE FROM dzag_t WHERE dzag001=p_prog
      DISPLAY "delete dzfs_t"
      DELETE FROM dzfs_t WHERE dzfs002=p_prog
      DISPLAY "delete dzai_t"
      DELETE FROM dzai_t WHERE dzai001=p_prog
      DISPLAY "delete dzaj_t"
      DELETE FROM dzaj_t WHERE dzaj001=p_prog
      DISPLAY "delete dzam_t"
      DELETE FROM dzam_t WHERE dzam001=p_prog
      DISPLAY "delete dzff_t"
      DELETE FROM dzff_t WHERE dzff001=p_prog

      DISPLAY "DELETE 4fd DATA..."
      DISPLAY "delete dzfa_t"
      DELETE FROM dzfa_t WHERE dzfa001=p_prog
      DISPLAY "delete dzfb_t"
      DELETE FROM dzfb_t WHERE dzfb001=p_prog
      DISPLAY "delete dzfi_t"
      DELETE FROM dzfi_t WHERE dzfi001=p_prog
      DISPLAY "delete dzfj_t"
      DELETE FROM dzfj_t WHERE dzfj001=p_prog
      DISPLAY "delete dzfk_t"
      DELETE FROM dzfk_t WHERE dzfk001=p_prog
      DISPLAY "delete dzfl_t"
      DELETE FROM dzfl_t WHERE dzfl001=p_prog
            
      #元件規格已經封印,所以就不需要再刪除了.
      
      #刪除程式設計資料.
      DISPLAY "DELETE CODE DATA..."
      DISPLAY "delete dzba_t"
      DELETE FROM dzba_t WHERE dzba001=p_prog
      DISPLAY "delete dzbb_t"
      DELETE FROM dzbb_t WHERE dzbb001=p_prog
      DISPLAY "DELETE SECTION DATA..."
      DISPLAY "delete dzbc_t"
      DELETE FROM dzbc_t WHERE dzbc001=p_prog
      DISPLAY "delete dzbd_t"
      DELETE FROM dzbd_t WHERE dzbd001=p_prog
         
      #刪除報表元件設計資料.
      DISPLAY "DELETE REPORT COMP DATA..."
      #Begin:2015/05/18 by Hiko
      #DISPLAY "delete dzga_t"
      #DELETE FROM dzga_t WHERE dzga001=p_prog
      #DISPLAY "delete dzgb_t"
      #DELETE FROM dzgb_t WHERE dzgb001=p_prog
      #DISPLAY "delete dzgc_t"
      #DELETE FROM dzgc_t WHERE dzgc001=p_prog
      #DISPLAY "delete dzgd_t"
      #DELETE FROM dzgd_t WHERE dzgd001=p_prog
      #DISPLAY "delete dzge_t"
      #DELETE FROM dzge_t WHERE dzge001=p_prog
      #DISPLAY "delete dzgf_t"
      #DELETE FROM dzgf_t WHERE dzgf001=p_prog
      #DISPLAY "delete dzgg_t"
      #DELETE FROM dzgg_t WHERE dzgg001=p_prog
      #DISPLAY "delete dzgh_t"
      #DELETE FROM dzgh_t WHERE dzgh001=p_prog
      #DISPLAY "delete dzgi_t"
      #DELETE FROM dzgi_t WHERE dzgi001=p_prog
      #DISPLAY "delete dzgj_t"
      #DELETE FROM dzgj_t WHERE dzgj001=p_prog
      #DISPLAY "delete dzgl_t"
      #DELETE FROM dzgl_t WHERE dzgl001=p_prog
      CALL sadzp188_del_rep_data(p_prog, NULL)
      #End:2015/05/18 by Hiko
      
      DISPLAY "DELETE OTHER DATA..."
      #刪除畫面元件多語言記錄表
      DISPLAY "delete gzzd_t"
      DELETE FROM gzzd_t WHERE gzzd001=p_prog
      
      #刪除ACTION多語言對照檔
      DISPLAY "delete gzzq_t"
      DELETE FROM gzzq_t WHERE gzzq001=p_prog
      
      #刪除階層式選單設定檔
      DISPLAY "delete gzzp_t"
      DELETE FROM gzzp_t WHERE gzzp001=p_prog

      RETURN TRUE,NULL
   CATCH 
      RETURN FALSE,"ERROR : delete all design data failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 清除客製資料
# Input parameter : p_prog 程式代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/10/24 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp063_1_del_cust_data(p_prog) 
   DEFINE p_prog LIKE dzaf_t.dzaf001 #程式代號

   TRY
      #刪除規格設計資料.
      DISPLAY "DELETE SPEC DATA..."
      DISPLAY "delete dzax_t"
      DELETE FROM dzax_t WHERE dzax001=p_prog AND dzax006='c'
      DISPLAY "delete dzaa_t"
      DELETE FROM dzaa_t WHERE dzaa001=p_prog AND dzaa009='c'
      DISPLAY "delete dzab_t"
      DELETE FROM dzab_t WHERE dzab001=p_prog AND dzab003='c'
      DISPLAY "delete dzac_t"
      DELETE FROM dzac_t WHERE dzac001=p_prog AND dzac012='c'
      DISPLAY "delete dzak_t"
      DELETE FROM dzak_t WHERE dzak001=p_prog AND dzak004='c'
      DISPLAY "delete dzal_t"
      DELETE FROM dzal_t WHERE dzal001=p_prog AND dzal004='c'
      DISPLAY "delete dzad_t"
      DELETE FROM dzad_t WHERE dzad001=p_prog AND dzad005='c'
      DISPLAY "delete dzag_t"
      DELETE FROM dzag_t WHERE dzag001=p_prog AND dzag006='c'
      DISPLAY "delete dzfs_t"
      DELETE FROM dzfs_t WHERE dzfs002=p_prog AND dzfs005='c'
      DISPLAY "delete dzai_t"
      DELETE FROM dzai_t WHERE dzai001=p_prog AND dzai004='c'
      DISPLAY "delete dzaj_t"
      DELETE FROM dzaj_t WHERE dzaj001=p_prog AND dzaj004='c'
      DISPLAY "delete dzam_t"
      DELETE FROM dzam_t WHERE dzam001=p_prog AND dzam005='c'
      DISPLAY "delete dzff_t"
      DELETE FROM dzff_t WHERE dzff001=p_prog AND dzff008='c'
      
      DISPLAY "DELETE 4fd DATA..."
      DISPLAY "delete dzfa_t"
      DELETE FROM dzfa_t WHERE dzfa001=p_prog AND dzfa003='c' #2015/01/12 by Hiko
      DISPLAY "delete dzfb_t"
      DELETE FROM dzfb_t WHERE dzfb001=p_prog AND dzfb007='c'
      DISPLAY "delete dzfi_t"
      DELETE FROM dzfi_t WHERE dzfi001=p_prog AND dzfi009='c'
      DISPLAY "delete dzfj_t"
      DELETE FROM dzfj_t WHERE dzfj001=p_prog AND dzfj017='c'
      DISPLAY "delete dzfk_t"
      DELETE FROM dzfk_t WHERE dzfk001=p_prog AND dzfk007='c'
      DISPLAY "delete dzfl_t"
      DELETE FROM dzfl_t WHERE dzfl001=p_prog AND dzfl007='c'
            
      #元件規格已經封印,所以就不需要再刪除了.
      
      #刪除程式設計資料.
      DISPLAY "DELETE CODE DATA..."
      DISPLAY "delete dzba_t"
      DELETE FROM dzba_t WHERE dzba001=p_prog AND dzba010='c'
      DISPLAY "delete dzbb_t"
      DELETE FROM dzbb_t WHERE dzbb001=p_prog AND dzbb004='c'
      DISPLAY "DELETE SECTION DATA..."
      DISPLAY "delete dzbc_t"
      DELETE FROM dzbc_t WHERE dzbc001=p_prog AND dzbc007='c'
      DISPLAY "delete dzbd_t"
      DELETE FROM dzbd_t WHERE dzbd001=p_prog AND dzbd004='c'
         
      #刪除報表元件設計資料.
      DISPLAY "DELETE REPORT COMP DATA..."
      #Begin:2015/05/18 by Hiko
      #DISPLAY "delete dzga_t"
      #DELETE FROM dzga_t WHERE dzga001=p_prog AND dzga006='c'
      #DISPLAY "delete dzgb_t"
      #DELETE FROM dzgb_t WHERE dzgb001=p_prog AND dzgb019='c'
      #DISPLAY "delete dzgc_t"
      #DELETE FROM dzgc_t WHERE dzgc001=p_prog AND dzgc009='c'
      #DISPLAY "delete dzgd_t"
      #DELETE FROM dzgd_t WHERE dzgd001=p_prog AND dzgd008='c'
      #DISPLAY "delete dzge_t"
      #DELETE FROM dzge_t WHERE dzge001=p_prog AND dzge009='c'
      #DISPLAY "delete dzgf_t"
      #DELETE FROM dzgf_t WHERE dzgf001=p_prog AND dzgf012='c'
      #DISPLAY "delete dzgg_t"
      #DELETE FROM dzgg_t WHERE dzgg001=p_prog AND dzgg017='c'
      #DISPLAY "delete dzgh_t"
      #DELETE FROM dzgh_t WHERE dzgh001=p_prog AND dzgh012='c'
      #DISPLAY "delete dzgi_t"
      #DELETE FROM dzgi_t WHERE dzgi001=p_prog AND dzgi006='c'
      #DISPLAY "delete dzgj_t"
      #DELETE FROM dzgj_t WHERE dzgj001=p_prog AND dzgj008='c'
      #DISPLAY "delete dzgl_t"
      #DELETE FROM dzgl_t WHERE dzgl001=p_prog AND dzgl030='c'
      CALL sadzp188_del_rep_data(p_prog, "c")
      #End:2015/05/18 by Hiko
      
      DISPLAY "DELETE OTHER DATA..."
      #刪除畫面元件多語言記錄表
      DISPLAY "delete gzzd_t"
      DELETE FROM gzzd_t WHERE gzzd001=p_prog AND gzzd004='c'
      
      #刪除ACTION多語言對照檔
      DISPLAY "delete gzzq_t"
      DELETE FROM gzzq_t WHERE gzzq001=p_prog

      RETURN TRUE,NULL
   CATCH 
      RETURN FALSE,"ERROR : delete cust design data failure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 保留刪除紀錄  
# Input parameter : po_dzaf DZAF_T物件
#                 : p_action 刪除選項(1,2,3,4)
# Return code     : void
# Date & Author   : 2014/11/19 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp063_1_del_log(po_dzaf, p_action)
   DEFINE po_dzaf  T_DZAF_T,   
          p_action LIKE type_t.chr1   
   DEFINE l_prog     LIKE dzaf_t.dzaf001, #程式代號
          l_cons_ver LIKE dzaf_t.dzaf002, #建構版次
          l_spec_ver LIKE dzaf_t.dzaf003, #規格版次
          l_code_ver LIKE dzaf_t.dzaf004, #程式版次
          l_module   LIKE dzaf_t.dzaf006  #模組
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          li_cnt     SMALLINT,
          l_crtdt    DATETIME YEAR TO SECOND, #資料創建日
          l_client_ip LIKE type_t.chr20 #紀錄client ip

   #失敗也沒關係
   TRY
      LET l_prog = po_dzaf.dzaf001
      LET l_cons_ver = po_dzaf.dzaf002
      LET l_spec_ver = po_dzaf.dzaf003
      LET l_code_ver = po_dzaf.dzaf004
      LET l_module = po_dzaf.dzaf006

      DISPLAY "sadzp063_1_del_log start..."

      SELECT COUNT(*) INTO li_cnt FROM dzav_t WHERE dzav001=l_prog
      IF li_cnt>0 THEN
         DISPLAY "delete dzav_t..."
         DELETE FROM dzav_t WHERE dzav001=l_prog
      END IF

      LET ls_sql = "INSERT INTO dzav_t(dzav001,dzav002,dzav003,dzav004,dzav005,dzav006,",
                                      "dzavownid,dzavowndp,dzavcrtid,dzavcrtdp,dzavcrtdt,dzavmodid)", 
                              " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"
      PREPARE ins_dzav FROM ls_sql
      LET l_crtdt = cl_get_current()
      LET l_client_ip = cl_getenv_client_ip() #暫時將client ip記錄在dzavmodid內
      EXECUTE ins_dzav USING l_prog,l_module,p_action,l_cons_ver,l_spec_ver,l_code_ver,
                             g_user,g_dept,g_user,g_dept,l_crtdt,l_client_ip 

      DISPLAY "sadzp063_1_del_log finish..."
   CATCH 
      DISPLAY "sadzp063_1_del_log : ",SQLCA.SQLCODE
   END TRY
END FUNCTION

#160728-00031 add
#+若在dzaq_t找到同建構版次的資料，則將資料更新為尚未同步
PRIVATE FUNCTION sadzp063_1_chk_and_upd_dzaq_t(po_dzaf)
   DEFINE po_dzaf      T_DZAF_T
   DEFINE l_dzaq001    LIKE dzaq_t.dzaq001
   DEFINE l_dzaq004    LIKE dzaq_t.dzaq004
   DEFINE ls_err_msg   STRING
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE ls_sql       STRING
   DEFINE lb_result    BOOLEAN

   LET lb_result = TRUE
   IF po_dzaf.dzaf002 >= 1 THEN #防呆一下 傳過來的是退版後的版次
      LET l_dzaq001 = po_dzaf.dzaf001
      LET l_dzaq004 = po_dzaf.dzaf002 + 1 
      SELECT COUNT(*) INTO li_cnt FROM dzaq_t WHERE dzaq001=l_dzaq001 AND dzaq004=l_dzaq004
      IF li_cnt >0 THEN
         UPDATE dzaq_t SET dzaq004=NULL,dzaq005=NULL,dzaq006=NULL,dzaq010='N' WHERE dzaq001=l_dzaq001
         LET ls_sql = "UPDATE dzaq_t SET dzaq004=NULL,", #行業程式建構版次
                                        "dzaq005=NULL,", #行業程式規格版次
                                        "dzaq006=NULL,", #行業程式程式版次
                                        "dzaq010='N',",
                                        "dzaqmoddt=?,",
                                        "dzaqmodid=?",
                      " WHERE dzaq001=?"
         PREPARE upd_dzaq_prep1 FROM ls_sql
         EXECUTE upd_dzaq_prep1 USING g_date,g_user,l_dzaq001
         IF SQLCA.SQLCODE THEN
            LET ls_err_msg = "update dzaq_t fail:",l_dzaq001
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = cl_getmsg(SQLCA.SQLCODE,g_lang)
            LET g_errparam.popup = TRUE
            LET g_errparam.EXTEND = ls_err_msg
            CALL cl_err()
            LET lb_result = FALSE
         END IF
         FREE upd_dzaq_prep1
      END IF
   ELSE
      DISPLAY "Waring: dzaf002 is wrong:",po_dzaf.dzaf002
   END IF
   
   RETURN lb_result,ls_err_msg
   
END FUNCTION
