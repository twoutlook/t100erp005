#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/27
#
#+ 程式代碼......: sadzp060_2
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp060_2.4gl
# Description    : 關於規格/程式設計資料的相關功能
# Modify         : 2014/02/27 by Hiko : 從sadzp060_2搬過來
#                : 2014/03/03 by Hiko : 1.新增取得規格/程式最大版次的功能(上傳程式專用)
#                                       2.新增檢查ALM權限,並取得規格/程式最大版次的功能(上傳規格並產生程式專用)
#                : 2014/05/15 by Hiko : 1.因應dzaf_t而調整
#                                       2.將sadzp060_0.cl_chk_competence,cl_chk_competence_check_alm,cl_chk_competence_check_env,cl_chk_competence_check_stus搬過來並更名
#                                       3.sadzp060_2_check_stus不需要檢查,全部註解掉
#                                       4.sadzp060_2_check_env不需要檢查,全部註解掉
#                                       5.新建呼叫簽入的FUNCTION
#                : 2014/05/21 by Hiko : 1.增加取得dzaf_t識別標示的功能
#                                       2.ALM檢查改為呼叫sadzp200_alm_check_item_if_exist
#                : 2014/05/23 by Hiko : 增加sadzp060_2_create_spec_structure(由sadzp030_tsd移植過來)
#                : 2014/06/04 by Hiko : 呼叫sadzp062_1_del_design_data增加參數
#                : 2014/06/09 by Hiko : 1.sadzp060_2_chk_permission的回傳改成TYPE,err_msg
#                                       2.新建sadzp060_2_check_out_rpt給adzp188使用
#                : 2014/06/12 by Hiko : 1.增加判斷是否已經簽出:sadzp060_2_have_checked_out,並移除sadzp060_2_check_dzlm
#                                       2.報表元件/報表元件設計資料/4rp的版次共用,建構類型都為G
#                : 2014/06/17 by Hiko : 1.簽出還要更新dzax_t的[客製標示]
#                                       2.將check_out的FUNCTION變成註解
#                : 2014/06/23 by Hiko : 新建sadzp060_2_get_curr_ver_info_by_dzaf002
#                : 2014/06/26 by Hiko : sadzp200_alm_check_item_if_exist改為sadzp200_alm_get_alm_owner_by_role
#                : 2014/07/29 by Hiko : 新建 sadzp060_2_ins_dzax()for簽出程式後走複製工具(不透過r.a產生dzax)
#                : 2014/08/14 by Hiko : 判斷dzax_t不判斷生失效,而是存在後,直接更新為生效可以防呆.
#                : 2014/08/26 by madey: 新增function sadzp060_2_chk_spec_type取代sadzi444_01_chk_spec_type
#                : 2014/09/03 by Hiko : r.f加上最後一個固定參數:tiptop
#                : 2014/09/09 by Hiko : 1.標準變客製的錯誤增加錯誤訊息
#                                       2.失敗沒關係的訊息改成ls_err_msg3,才不會影響簽出流程
#                : 2014/09/15 by Hiko : dzbc009新增時預設為NULL
#                : 2014/09/18 by Hiko : 增加Q類hard code的行為
#                : 2014/10/01 by Hiko : dzax002若是由此程式來塞值,應該都是為了複製的簽出,所以預設給'F'即可(共用F,P,Q,R,W)
#                : 2014/10/03 by Hiko : 調整gzde008,gzdf003,gzza011的條件判斷:Y-->c;N-->s
#                : 2014/10/06 by Hiko : 1.效能調校:after_check_out_for_download的程式重產只在標準變客製的時候才做.
#                                       2.增加dzax007
#                : 2014/10/07 by Hiko : 1.修改sadzp060_2_ins_dzax的邏輯.
#                                       2.在標準變客製過程中的取消簽出得要刪除dzax_t
#                : 2014/10/08 by Hiko : r.c3拉出一個FUNCTION處理
#                : 2014/10/16 by Hiko : 1.B,W,Z,Q的程式預設為Free Style,但流程上需要dzax_t的只有M,S,F,所以做了調整.
#                                       2.GR報表元件在標準變客製的時候要產生rdd
#                : 2014/10/27 by Hiko : 長樹的時候要判斷舊版版次是否>0
#                : 2014/10/30 by Hiko : 1.重組4fd的FUNCTION已經有r.f,所以取消簽出只做重產4fd即可.
#                                       2.取消簽出有可能是541取消變成440,所以要防呆.
#                : 2014/11/11 by Hiko : rc3增加參數
#                : 2014/11/19 by Hiko : 1.移除元件(B)規格,改成和報表元件(R)規格相同的行為
#                                       2.取消簽出改呼叫sadzp063_1_del_design_data來刪除設計資料
#                : 2014/11/27 by Hiko : 修改bug
#                : 2014/12/03 by Hiko : 1.簽出:將dzax_t的資料複製到dzay_t
#                                       2.取消簽出:將dzay_t的資料複製到dzax_t
#                : 2014/12/09 by Hiko : 因為下載規格已經不重產多語言檔,因此標準轉客製時,子畫面需要般str,42s.
#                : 2014/12/16 by Hiko : 檢查簽出人員改成g_account.
#                : 2014/12/17 by Hiko : dzax004(本版次異動)預設為N
#                : 2015/01/07 by Hiko : 標準轉客製呼叫r.c3之後,要執行r.l ALL,要不然相關聯的子程式/元件的主程式都會受到影響.
#                : 2015/02/06 by Hiko : 1.上傳還要判斷區域(ZONE)是否正確.
#                                       2.移動版次為0的判斷時機.
#                : 2015/04/27 by Hiko : 增加設計器版次資訊的判斷.
#                : 2015/05/14 by Hiko : 1.報表元件的取消簽出改呼叫sadzp188_copy_rep_table
#                                       2.組合路徑的module變數要轉小寫(DOWNSHIFT).
#                : 2015/05/29 by madey: sadzp060_2_chk_spec_type()增加類別:Q qry
#                : 2015/06/12 by Hiko : 1.將產生規格樹與程式樹改成PUBLIC, 要給行業同步使用.
#                                       2.Q類Hard Code標準轉客製呼叫sadzp210_copy_qry_from_std_to_cust新建一筆客製資料.
#                : 2015/08/05 by Hiko : 支持取消簽出的條件:1.DEBUG模式,2.非topstd,3.DGENV<>c,4.M類程式要注意對應的行業程式是否已經簽出.
#                : 2015/08/18 by madey: sadzp060_2_chk_spec_type()補上判斷cwss
#                : 2015/08/26 by Hiko : 標準轉客製的時候先刪除客製垃圾, 可避免一些奇怪問題發生.
#                : 2015/09/14 by Hiko : 報表元件(G/X)標準轉客製的時候, 要將dzba_t/dzbb_t的客製flag都變成c, 這可避免patch上了標準資源池的內容而導致4gl組合出錯.
#                : 2015/09/15 by madey: sadzp060_2_rc3()在r.c3時遇錯回傳錯,由呼叫端自行控制流程
#                : 2015/09/16 by Hiko : 產生新版樹頭的時候, 要判斷是否存在舊版資料.
#                : 2015/09/18 by madey: 標準轉客製時,set T100_SRCSTAND_SWITCH=off避開一般程式規則檢查(src_standard)
#                : 2015/10/22 by Hiko : 標準轉客製的時候, r.c3真的錯誤也不還原, 讓開發人員可以往下修正問題.
#                : 2015/11/02 by Hiko : 將FGL_GETENV("MNT4RP")，改成cl_rpt_get_env_global(“MNT4RP”)
#                : 2015/11/09 by Hiko : 1.改善上傳/下載效能, 增加dzay005(程式是否需要重產)來記錄程式是否需要重產.
#                                       2.調整dzay_t新增的時機,改在adzp050處理.
#                                       3.因為r.c3第四個參數為2的時候才會做語法檢查,所以將T100_SRCSTAND_SWITCH的設定移除.
#                : 2015/12/01 by Hiko : 將錯誤訊息替換內容的長訊息逗號後面加上一個空白,可讓cl_err進行換行.
#                : 20160121 by Hiko : 將標準轉客製r.l ALL的行為改在adzp050簽出的時候處理, 這樣可避免標準轉客製不完全(c111)然後持續做r.l ALL(會很久).
#                : 20160302 160302-00026 by Hiko : 1.檢查簽出版次是否和dzaf_t相同.
#                                                  2.修正錯誤訊息adz-00351的取替代參數.
#                : 20160516 160516-00005 by Hiko : 配合過單/Patch流程的判斷, 將sadzp060_2_get_curr_ver_info的顯現訊息從ERROR改成WARNING.
#                : 20160706 160706-00001 by madey: 調整sadzp060_2_chk_spec_type()的F類規則
#                : 20160923 160919-00031 by Ernest: 上傳時檢核是否符合 P65T 的規則, topstd 不檢核
#                : 20160926 160922-00039 by Hiko: 修改sadzp060_2_chk_permission:1.CODE上傳要多檢查與'FreeStyle'的情境.
#                                                                               2.ls_revision的判斷都改成li_revision

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
#for sadzp060_2_chk_permission
&include "../4gl/adzp080_type.inc"
#for sadzp050_zip_copy_4rp_list
&include "../4gl/sadzp050_type.inc"

DEFINE g_date DATETIME YEAR TO SECOND,
       gs_dept STRING, 
       gs_erpver STRING, #ERP大版版號
       gs_customer STRING, 
       g_env LIKE dzaa_t.dzaa009 #辨識目前所在的環境:s.產中環境,c.客製環境
DEFINE g_dzaf002 LIKE dzaf_t.dzaf002 #2014/06/23 by Hiko
       

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : BOOLEAN(成功:TRUE,失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_2_init_var()
   DEFINE ls_trigger STRING

   TRY
      LET ls_trigger = "sadzp060_2_init_var"
      LET g_date = cl_get_current()
      LET gs_dept = g_dept CLIPPED
      LET gs_erpver = FGL_GETENV("ERPVER") CLIPPED
      LET gs_customer = FGL_GETENV("CUST") CLIPPED
      LET g_env = FGL_GETENV("DGENV") CLIPPED
      
      DISPLAY "call sadzp060_2_init_var finish"

      RETURN TRUE
   CATCH
      CALL sadzp060_2_err_catch(ls_trigger, NULL)
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 上傳時檢查是否為合法來源
# Input parameter : p_prog 程式代號
#                 : p_path tsd/tap檔路徑
#                 : p_kind 檔案種類(SPEC/CODE)
# Return code     : T_UPLOAD_PARAM 參數物件
#                 : STRING 錯誤訊息
# Date & Author   : 2013/10/07 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_chk_permission(p_prog, p_path, p_kind)
   DEFINE p_prog STRING,
          p_path STRING,
          p_kind STRING
   DEFINE ls_kind STRING, #2014/06/09 by Hiko
          ls_file STRING,
          ldoc_file xml.domDocument,
          lnode_file xml.DomNode,
          ls_trigger STRING
   DEFINE lb_result BOOLEAN, #2013/10/11 by Hiko
          ls_err_msg STRING  #2013/10/11 by Hiko
   #Begin:2013/11/22 by Hiko
   DEFINE ls_sql STRING, 
          ls_field STRING,
          li_revision SMALLINT,
          ls_revision STRING,
          ls_identity STRING, #2014/05/15 by Hiko
          ls_file_revision STRING,
          #Begin:2014/05/21 by Hiko
          ls_role STRING,
          ls_type STRING,
          ls_module STRING,
          #End:2014/05/21 by Hiko
          #Begin:160922-00039
          ls_free_style STRING,
          li_cnt SMALLINT,  
          lst_other XML.DomNodeList,
          lnode_other XML.DomNode,
          lnode_child XML.DomNode,
          ls_tag_name STRING,
          #End:160922-00039
          ls_err_replace STRING
   #End:2013/11/22 by Hiko
   #Begin:2014/06/09 by Hiko
   DEFINE lo_upload_param T_UPLOAD_PARAM,
          ls_std_revision STRING,
          ls_std_identity STRING
   #End:2014/06/09 by Hiko
   #Begin:2015/02/06 by Hiko
   DEFINE ls_file_zone STRING,
          ls_server_zone STRING
   #End:2015/02/06 by Hiko
   DEFINE ls_designer_ver,ls_file_designer_ver STRING #2015/04/27 by Hiko
   #Begin:160302-00026
   DEFINE lo_program_info DYNAMIC ARRAY OF T_PROGRAM_INFO,  #程式的動態陣列物件
          lo_return       T_DZLM_T
   #End:160302-00026
   DEFINE lo_dzlm   T_DZLM_T #160919-00031         
   DEFINE ls_DGENV  STRING   #160919-00031 
   
   LET ls_DGENV = FGL_GETENV("DGENV") #160919-00031   

   TRY
      DISPLAY "CALL sadzp060_2_chk_permission(",p_prog,",",p_path,",",p_kind,") begin..."
    
      LET p_prog = p_prog.trim() #160922-00039
      LET p_path = p_path.trim() #160922-00039
      LET p_kind = p_kind.trim()
      LET ls_kind = p_kind
      #Begin:2014/02/24 by Hiko
      IF ls_kind.equals("SPECGEN") THEN
         LET ls_kind = "SPEC"
      END IF
      #End:2014/02/24 by Hiko
      #Begin:2014/04/17 by Hiko
      IF ls_kind.equals("GCODE") THEN
         LET ls_kind = "CODE"
      END IF
      #End:2014/04/17 by Hiko
      CASE ls_kind
         WHEN "SPEC"
            LET p_path = os.path.join(p_path, p_prog||".tsd")
            LET ls_role = "SD"
         WHEN "CODE"
            LET p_path = os.path.join(p_path, p_prog||".tap")
            LET ls_role = "PR"
         WHEN "CSPEC" #2014/05/21 by Hiko
            LET p_path = os.path.join(p_path, p_prog||".csd")
            LET ls_role = "SD"
         WHEN "RSPEC" #2014/04/10 by Hiko
            LET p_path = os.path.join(p_path, p_prog||".rsd")
            LET ls_role = "SD"
         WHEN "4RP" #2014/04/11 by Hiko
            LET p_path = os.path.join(p_path, p_prog||".vfy")
            LET ls_role = "PR"
      END CASE

      IF NOT os.Path.exists(p_path) THEN
         LET ls_err_msg = "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00175", g_lang), p_path)
         GOTO _RTN_ERR
      END IF

      LET ls_trigger = "sadzp060_2_chk_permission : load tmp file=",p_path
      LET ldoc_file = xml.domDocument.create()
      CALL ldoc_file.load(p_path)
      LET lnode_file = ldoc_file.getDocumentElement()

      #Begin:2015/02/06 by Hiko
      LET ls_file_zone = lnode_file.getAttribute("zone") CLIPPED
      LET ls_server_zone = FGL_GETENV("ZONE") CLIPPED
      #判斷區域是否相同:沒有丟包的行為,只能透過匯出/匯入設計資料來達到這樣的效果.
      IF NOT ls_file_zone.equals(ls_server_zone) THEN
         LET ls_err_msg = "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00122", g_lang), ls_server_zone||"|"||ls_file_zone)
         GOTO _RTN_ERR
      END IF
      #End:2015/02/06 by Hiko

      #原本可以直接使用tsd/tap內的booking屬性來判斷即可, 但為了避免出問題, 所以還是重查一次.
      LET ls_file_revision = lnode_file.getAttribute("ver") CLIPPED #2013/11/22 by Hiko
      LET ls_module = lnode_file.getAttribute("module") CLIPPED #2014/05/21 by Hiko
      #Begin:2014/05/21 by Hiko
 
      #Begin:2014/06/12 by Hiko
      #IF ls_kind.equals("4RP") THEN
      #   LET ls_type = "R" #報表樣版為固定值
      #ELSE
      #   LET ls_type = lnode_file.getAttribute("type") CLIPPED
      #END IF
      LET ls_type = lnode_file.getAttribute("type") CLIPPED
      LET lo_upload_param.arg11_type = ls_type
      #End:2014/06/12 by Hiko
      
      LET lo_upload_param.arg7_std_program = lnode_file.getAttribute("std_prog") CLIPPED
      LET ls_trigger = "sadzp060_2_chk_permission : sadzp060_2_get_spec(or code)_max_revision"
      IF ls_role.equals("SD") THEN
         CALL sadzp060_2_get_spec_curr_revision(p_prog, ls_type, ls_module) RETURNING li_revision,ls_identity,ls_err_msg
         #Begin:2014/06/09 by Hiko
         IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF
         LET lo_upload_param.arg5_spec_version = li_revision

         CALL sadzp060_2_get_spec_curr_revision(lo_upload_param.arg7_std_program, ls_type, ls_module) RETURNING ls_std_revision,ls_std_identity,ls_err_msg
         IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF
         LET lo_upload_param.arg8_std_spec_version = ls_std_revision 
         #End:2014/06/09 by Hiko
      ELSE #PR
         CALL sadzp060_2_get_code_curr_revision(p_prog, ls_type, ls_module) RETURNING li_revision,ls_identity,ls_err_msg
         #Begin:2014/06/09 by Hiko
         IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF
         LET lo_upload_param.arg6_code_version = li_revision 

         CALL sadzp060_2_get_code_curr_revision(lo_upload_param.arg7_std_program, ls_type, ls_module) RETURNING ls_std_revision,ls_std_identity,ls_err_msg
         IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF
         LET lo_upload_param.arg9_std_code_version = ls_std_revision 
         #End:2014/06/09 by Hiko
      END IF

      IF li_revision<>0 THEN
         #檢查要更新的版次是否相同
         IF ls_file_revision<>li_revision THEN
            LET ls_err_replace = p_prog,"|",ls_kind,"|",ls_file_revision,"|",li_revision
            LET ls_err_msg = "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00222", g_lang), ls_err_replace)
            GOTO _RTN_ERR  
         ELSE #ls_file_revision=li_revision
            LET ls_trigger = "sadzp060_2_chk_permission : sadzp060_2_have_checked_out"
            CALL sadzp060_2_have_checked_out(p_prog, ls_type, ls_role, 0) RETURNING ls_err_msg
            IF NOT cl_null(ls_err_msg) THEN GOTO _RTN_ERR END IF
            #Begin:160302-00026
            LET lo_program_info[1].pi_NAME = p_prog
            LET lo_program_info[1].pi_TYPE = ls_type
            CALL sadzp200_alm_get_dzlm(lo_program_info[1].*, ls_role) RETURNING lo_return.*
            IF ls_role.equals("SD") THEN
               IF li_revision<>lo_return.dzlm006 THEN
                  LET ls_err_replace = "SPEC|",li_revision,"|",lo_return.dzlm006
                  LET ls_err_msg = "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00785", g_lang), ls_err_replace)
                  GOTO _RTN_ERR  
               END IF
            ELSE #PR
               IF li_revision<>lo_return.dzlm009 THEN
                  LET ls_err_replace = "CODE|",li_revision,"|",lo_return.dzlm009
                  LET ls_err_msg = "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00785", g_lang), ls_err_replace)
                  GOTO _RTN_ERR  
               END IF

               #Begin:160922-00039
               IF ls_kind = "CODE" THEN
                  LET lst_other = lnode_file.getElementsByTagName("other")
                  LET lnode_other = lst_other.getItem(1) #目前只有一個other
                  LET lnode_child = lnode_other.getFirstChildElement()
                  WHILE lnode_child IS NOT NULL
                     LET ls_tag_name = lnode_child.getLocalName() CLIPPED
                     IF ls_tag_name.equals("free_style") THEN
                        LET ls_free_style = lnode_child.getAttribute("value") CLIPPED
                        IF cl_null(ls_free_style) THEN
                           LET ls_sql = "SELECT COUNT(*) FROM dzax_t",
                                        " WHERE dzax001='",p_prog,"'",
                                        "   AND dzax003='Y'"
                           PREPARE dzax_prep FROM ls_sql
                           EXECUTE dzax_prep INTO li_cnt
                           FREE dzax_prep
                           IF li_cnt > 0 THEN
                              LET ls_err_msg = "ERROR : ",cl_getmsg("adz-00904", g_lang) #我們偵測到Server端已經轉為FreeStyle, 但Client端還是標準, 麻煩請重新下載再繼續開發.
                              GOTO _RTN_ERR  
                           END IF
                        END IF
                     END IF

                     LET lnode_child = lnode_child.getNextSiblingElement()
                  END WHILE
               END IF
               #End:160922-00039
            END IF #ls_role.equals("SD")
            #End:160302-00026
         END IF #ls_file_revision<>li_revision
      ELSE
         LET ls_err_msg = "ERROR : the file revision is 0!"
         GOTO _RTN_ERR
      END IF
      #End:2014/05/21 by Hiko

      #判斷設計器版本是否符合.
      LET ls_file_designer_ver = lnode_file.getAttribute("designer_ver") CLIPPED
      CALL sadzp060_2_get_designer_ver() RETURNING ls_designer_ver
      IF ls_file_designer_ver <> ls_designer_ver THEN
         LET ls_err_msg =  "ERROR : ",cl_getmsg("adz-00588", g_lang)
         GOTO _RTN_ERR
      END IF

      LET lo_upload_param.arg10_dgenv = lnode_file.getAttribute("identity") CLIPPED #2014/06/09 by Hiko
      LET lo_upload_param.arg2_module_name = ls_module #2014/06/09 by Hiko
      
      #160919-00031 begin
      IF g_user <> "topstd" AND ls_DGENV = "s" THEN 
        LET ls_trigger = "sadzp060_2_chk_permission : Check if P65T stage."
        LET lo_program_info[1].pi_NAME = p_prog
        LET lo_program_info[1].pi_TYPE = ls_type
        CALL sadzp200_alm_get_dzlm(lo_program_info[1].*, ls_role) RETURNING lo_dzlm.*
        CALL sadzp060_2_check_if_stage_P65T(lo_dzlm.*) RETURNING lb_result
        IF lb_result THEN
           LET ls_err_msg =  "ERROR : ",cl_getmsg("adz-00902", g_lang) #該程式或規格已經處於P65T階段, 無法執行上傳 !
           GOTO _RTN_ERR
        END IF
      END IF  
      #160919-00031 end

      DISPLAY "CALL sadzp060_2_chk_permission(",p_prog,",",p_path,",",p_kind,") finish..."

      #RETURN ls_file_revision,ls_err_msg
      RETURN lo_upload_param.*,ls_err_msg

      #Begin:LABEL
      LABEL _RTN_ERR:
         DISPLAY ls_err_msg
         RETURN lo_upload_param.*,ls_err_msg
      #End:LABEL
   CATCH 
      CALL sadzp060_2_err_catch(ls_trigger, ls_sql)
      LET ls_err_msg = "ERROR : sadzp060_2_chk_permission(",p_prog,",",p_path,",",p_kind,")"
      RETURN lo_upload_param.*,ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PBULIC
# Descriptions    : 取得設計器版本資訊.
# Input parameter : none
# Return code     : STRING 設計器版本
# Date & Author   : 2014/05/15 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_get_designer_ver()
   DEFINE ls_ver_path      STRING,
          lch_designer_ver base.Channel,
          ls_line          STRING

   LET ls_ver_path = os.path.join(os.path.join(FGL_GETENV("COM"), "mta"), "ver")
   LET lch_designer_ver = base.Channel.create()
   CALL lch_designer_ver.openFile(ls_ver_path, "r")
   WHILE TRUE
      IF lch_designer_ver.isEof() OR NOT cl_null(ls_line)THEN
         EXIT WHILE
      END IF

      LET ls_line = lch_designer_ver.readLine() #目前只有一行
   END WHILE
   CALL lch_designer_ver.close()

   RETURN ls_line
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : void
# Date & Author   : 2014/05/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_2_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷是否已經簽出.
# Input parameter : p_prog 程式代號
#                   p_type 程式類型(M/S/F/G/X...)
#                   p_role 簽出角色(SD/PR)
#                   p_popup_err 彈出錯誤訊息窗(1:彈窗,0:不彈窗)
# Return code     : STRING (成功:NULL,失敗:錯誤訊息)
# Date & Author   : 2014/06/12 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_have_checked_out(p_prog, p_type, p_role, p_popup_err)
   DEFINE p_prog STRING,
          p_type STRING,
          p_role STRING,
          p_popup_err SMALLINT
   DEFINE lo_program_info DYNAMIC ARRAY OF T_PROGRAM_INFO,  #程式的動態陣列物件
          lb_result       BOOLEAN,                          #回傳布林值
          ls_owner        STRING, #2014/06/26 by Hiko
          ls_err_msg      STRING,
          ls_err_code     STRING,
          ls_replace_arg  STRING 

   LET p_prog = p_prog.trim()
   LET p_type = p_type.trim()
   LET p_role = p_role.trim()

   #設定程式資訊(有多支程式時請用For迴圈給定)
   LET lo_program_info[1].pi_NAME = p_prog #程式代碼
   LET lo_program_info[1].pi_TYPE = p_type #類別

   #檢核該程式是否已經被簽出
   CASE p_role
      WHEN "ALL" #先檢查規格,再檢查程式
        CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "SD") RETURNING lb_result,ls_owner
        IF NOT lb_result THEN
           LET ls_err_code = "adz-00313"
        ELSE
           IF ls_owner.equals(g_account) THEN
              CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "PR") RETURNING lb_result,ls_owner
              IF NOT lb_result THEN
                 LET ls_err_code = "adz-00313"
              ELSE
                 IF NOT ls_owner.equals(g_account) THEN #2014/12/16 by Hiko
                    LET lb_result = FALSE
                    LET ls_err_code = "adz-00351"
                    LET ls_replace_arg = "CODE|",ls_owner
                 END IF
              END IF
           ELSE
              LET lb_result = FALSE
              LET ls_err_code = "adz-00351"
              LET ls_replace_arg = "SPEC|",ls_owner
           END IF
        END IF
      WHEN "SD"
         CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "SD") RETURNING lb_result,ls_owner
         IF NOT lb_result THEN
            LET ls_err_code = "adz-00314"
         ELSE #有簽出還得判斷是誰簽出
            IF NOT ls_owner.equals(g_account) THEN #2014/12/16 by Hiko
               LET lb_result = FALSE
               LET ls_err_code = "adz-00351"
               LET ls_replace_arg = "SPEC|",ls_owner
            END IF
         END IF
      WHEN "PR"
         CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "PR") RETURNING lb_result,ls_owner
         IF NOT lb_result THEN
            LET ls_err_code = "adz-00315"
         ELSE
            IF NOT ls_owner.equals(g_account) THEN #2014/12/16 by Hiko
               LET lb_result = FALSE
               LET ls_err_code = "adz-00351"
               LET ls_replace_arg = "CODE|",ls_owner
            END IF
         END IF
   END CASE

   LET ls_err_msg = NULL

   IF NOT lb_result THEN
      IF p_popup_err=1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  ls_err_code
         LET g_errparam.replace[1] = ls_replace_arg
         LET g_errparam.replace[2] = ls_owner
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      LET ls_err_msg = cl_replace_err_msg(cl_getmsg(ls_err_code, g_lang), ls_replace_arg)
   END IF

   RETURN ls_err_msg
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 在下載畫面選擇簽出清單之後要做的事情.
# Input parameter : p_prog 程式代號
#                 : p_role 角色(SD/PR)
#                 : p_curr_dzaf 目前版次資訊
#                 : p_prev_dzaf 前版版次資訊
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_after_check_out_for_download(p_prog, p_role, p_curr_dzaf, p_prev_dzaf)
   DEFINE p_prog STRING,
          p_role STRING,
          p_curr_dzaf T_DZAF_T, #範例:版次2
          p_prev_dzaf T_DZAF_T  #範例:版次1
   DEFINE ls_type STRING,
          l_curr_spec_revision LIKE dzaf_t.dzaf003,
          l_curr_code_revision LIKE dzaf_t.dzaf004,
          ls_curr_identity STRING,
          ls_curr_module STRING,
          ls_curr_module_path STRING,
          l_prev_spec_revision LIKE dzaf_t.dzaf003,
          l_prev_code_revision LIKE dzaf_t.dzaf004,
          ls_prev_identity STRING,
          ls_prev_module STRING,
          ls_prev_module_path STRING
   DEFINE lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_err_msg2 STRING,
          ls_err_msg3 STRING #失敗沒關係,但要印出訊息
   DEFINE lo_program_info T_PROGRAM_INFO,
          lo_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
          ls_cmd STRING,
          ls_from_4fd STRING,
          ls_to_4fd_dir STRING,
          ls_to_4fd STRING,
          ls_from_4rp_dir STRING,
          ls_to_4rp_dir STRING,
          ls_to_4gl_dir STRING #2014/10/16 by Hiko
   DEFINE ls_trigger STRING,
          ls_sql STRING

   #簽出流程說明:
   #情境一.s4-->s5 or c2-->c3
   #1-1.長樹
   #1-2.複製4rp到back
   #情境二.s5-->c1
   #2-0.更新客製(c-->s)
   #2-1.長樹
   #2-2.複製4rp到客製back以及客製4rp下
   #2-3.重產4fd
   #2-4.重產4gl

   #規格簽出並修改會影響程式;程式就只是影響自己.

   TRY 
      IF NOT sadzp060_2_init_var() THEN
         LET ls_err_msg = "ERROR : sadzp060_2_after_check_out_for_download.sadzp060_2_init_var"
         RETURN ls_err_msg
      END IF
      
      LET p_prog = p_prog.trim()
      LET ls_type = p_curr_dzaf.dzaf005 CLIPPED
      LET l_curr_spec_revision = p_curr_dzaf.dzaf003 CLIPPED
      LET l_curr_code_revision = p_curr_dzaf.dzaf004 CLIPPED
      LET ls_curr_identity = p_curr_dzaf.dzaf010 CLIPPED
      LET ls_curr_module = p_curr_dzaf.dzaf006 CLIPPED
      LET ls_curr_module_path = FGL_GETENV(UPSHIFT(ls_curr_module))
      LET l_prev_spec_revision = p_prev_dzaf.dzaf003 CLIPPED
      LET l_prev_code_revision = p_prev_dzaf.dzaf004 CLIPPED
      LET ls_prev_identity = p_prev_dzaf.dzaf010 CLIPPED
      LET ls_prev_module = p_prev_dzaf.dzaf006 CLIPPED
      LET ls_prev_module_path = FGL_GETENV(UPSHIFT(ls_prev_module))

      CASE p_role
         WHEN "SD"
            IF cl_null(l_prev_spec_revision) THEN
               DISPLAY "prev_spec_revision is null, RETURN NULL"
               RETURN NULL
            END IF
         WHEN "PR"
            IF cl_null(l_prev_code_revision) THEN
               DISPLAY "prev_code_revision is null, CALL sadzp060_2_ins_dzax..."
               CALL sadzp060_2_ins_dzax(p_prog, ls_type, ls_curr_identity, ls_prev_identity) RETURNING lb_result,ls_err_msg #2014/10/01 by Hiko 
               IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF
               DISPLAY "prev_code_revision is null, RETURN NULL"
               RETURN NULL
            END IF
      END CASE

      DISPLAY "after download : p_role=",p_role,"<<"   
      DISPLAY "after download : p_prog=",p_prog,"<<"   
      DISPLAY "after download : ls_type=",ls_type,"<<"   
      DISPLAY "after download : l_curr_spec_revision=",l_curr_spec_revision,"<<"   
      DISPLAY "after download : l_curr_code_revision=",l_curr_code_revision,"<<"   
      DISPLAY "after download : ls_curr_identity=",ls_curr_identity,"<<"   
      DISPLAY "after download : ls_curr_module=",ls_curr_module,"<<"   
      DISPLAY "after download : ls_curr_module_path=",ls_curr_module_path,"<<"   
      DISPLAY "after download : l_prev_spec_revision=",l_prev_spec_revision,"<<"   
      DISPLAY "after download : l_prev_code_revision=",l_prev_code_revision,"<<"   
      DISPLAY "after download : ls_prev_identity=",ls_prev_identity,"<<"   
      DISPLAY "after download : ls_prev_module=",ls_prev_module,"<<"   
      DISPLAY "after download : ls_prev_module_path=",ls_prev_module_path,"<<"   
      
      IF ls_prev_identity <> ls_curr_identity THEN
         #Begin:2014/06/17 by Hiko
         #Begin:2014/10/07 by Hiko
         DISPLAY "after download : insert dzax_t : ",ls_curr_identity
         CALL sadzp060_2_ins_dzax(p_prog, ls_type, ls_curr_identity, ls_prev_identity) RETURNING lb_result,ls_err_msg
         IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF
         #End:2014/10/07 by Hiko
         #End:2014/06/17 by Hiko

         #簽出時(s --> c)要呼叫更新註冊資料的[是否客製]:Y(c)
         #Begin:2015/06/12 by Hiko
         IF ls_type<>"Q" THEN
            CALL s_azzi900_upd_gzza011(p_prog, ls_type, ls_curr_identity) RETURNING lb_result
         ELSE
            CALL sadzp210_copy_qry_from_std_to_cust(p_prog) RETURNING lb_result,ls_err_msg
         END IF

         IF NOT lb_result THEN 
            LET ls_err_msg = "ERROR : ",p_prog," updated registration information fail when check out!"
            GOTO _ROLLBACK_FLAG #有錯誤訊息表示失敗
         END IF
         #End:2014/10/03 by Hiko
      END IF
      
      CASE p_role
         WHEN "SD"
            #建立規格樹
            CALL sadzp060_2_create_spec_structure(p_prog, p_curr_dzaf.*, p_prev_dzaf.*) RETURNING ls_err_msg
            IF NOT cl_null(ls_err_msg) THEN GOTO _ROLLBACK_FLAG END IF  
            
            IF ls_type="M" OR ls_type="S" OR ls_type="F" OR ls_type="Q" THEN #只有M/S/F才有4fd,Q類hard code也有
               #只有在標準(s)變客製(c)時才要做4fd複製的動作
               IF ls_prev_identity <> ls_curr_identity THEN
                  DISPLAY "sadzp060_2_after_check_out_for_download : spec s --> c"
                  LET ls_from_4fd = os.path.JOIN(os.path.JOIN(ls_prev_module_path, "4fd"), p_prog||".4fd")
                  LET ls_to_4fd_dir = os.path.JOIN(ls_curr_module_path, "4fd")
                  LET ls_to_4fd = os.path.JOIN(ls_to_4fd_dir, p_prog||".4fd")
                  DISPLAY "ls_from_4fd=",ls_from_4fd
                  DISPLAY "ls_to_4fd=",ls_to_4fd
                  IF NOT cl_copy_file(ls_from_4fd, ls_to_4fd) THEN
                     LET ls_err_msg = "ERROR : Fail to copy file : ",ls_to_4fd
                     GOTO _ROLLBACK_FLAG  
                  END IF
                  #編譯4fd:編譯過程失敗都不影響簽出
                  IF cl_change_dir(ls_to_4fd_dir) THEN
                     LET ls_cmd = "r.f ",p_prog," tiptop" #2014/09/03 by Hiko
                     CALL cl_cmdrun_openpipe("r.f", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg3
                     IF NOT lb_result THEN
                        DISPLAY "WARNING : ",ls_err_msg3
                     END IF
                  ELSE
                     DISPLAY "WARNING : change dir to ",ls_to_4fd_dir," fail!"
                  END IF
                  #2014/12/09 by Hiko:子畫面需要搬str,42s
                  LET ls_from_4fd = os.path.JOIN(os.path.JOIN(os.path.JOIN(ls_prev_module_path, "str"), g_lang), p_prog||".str")
                  LET ls_to_4fd_dir = os.path.JOIN(os.path.JOIN(ls_curr_module_path, "str"), g_lang)
                  LET ls_to_4fd = os.path.JOIN(ls_to_4fd_dir, p_prog||".str")
                  DISPLAY "ls_from_4fd=",ls_from_4fd
                  DISPLAY "ls_to_4fd=",ls_to_4fd
                  IF NOT cl_copy_file(ls_from_4fd, ls_to_4fd) THEN
                     LET ls_err_msg = "ERROR : Fail to copy file : ",ls_to_4fd
                     GOTO _ROLLBACK_FLAG  
                  END IF
                  LET ls_from_4fd = os.path.JOIN(os.path.JOIN(os.path.JOIN(ls_prev_module_path, "str"), g_lang), p_prog||".42s")
                  LET ls_to_4fd_dir = os.path.JOIN(os.path.JOIN(ls_curr_module_path, "str"), g_lang)
                  LET ls_to_4fd = os.path.JOIN(ls_to_4fd_dir, p_prog||".42s")
                  DISPLAY "ls_from_4fd=",ls_from_4fd
                  DISPLAY "ls_to_4fd=",ls_to_4fd
                  IF NOT cl_copy_file(ls_from_4fd, ls_to_4fd) THEN
                     LET ls_err_msg = "ERROR : Fail to copy file : ",ls_to_4fd
                     GOTO _ROLLBACK_FLAG  
                  END IF
                  #End:2014/12/09 by Hiko
               END IF

               #建立UI樹
               DISPLAY "after_check_out_for_download : call sadzp168_3(",ls_curr_module,",",p_prog,",",l_curr_spec_revision,",",ls_curr_identity,")"
               CALL sadzp168_3(ls_curr_module, p_prog, l_curr_spec_revision, ls_curr_identity) RETURNING lb_result,ls_err_msg #解析4fd畫面成設計資料
               IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF
               #產生畫面欄位資訊
               DISPLAY "after_check_out_for_download : call sadzp168_4(",p_prog,",",l_curr_spec_revision,",",ls_curr_identity,")"
               CALL sadzp168_4(p_prog, l_curr_spec_revision, ls_curr_identity) RETURNING lb_result,ls_err_msg3 #失敗沒關係
               IF NOT lb_result THEN
                  DISPLAY "WARNING : ",ls_err_msg3
               END IF
            END IF
         WHEN "PR"
            IF ls_type="G" OR ls_type="X" THEN 
               #簽出報表元件設計資料(adzp188):最後一個參數:N代表New,D代表Delete
               DISPLAY "sadzp060_2_after_check_out_for_download : call sadzp188_copy_rep_table(",p_prog,",",l_prev_code_revision,",",ls_prev_identity,",",l_curr_code_revision,",",ls_curr_identity,",N)"
               CALL sadzp188_copy_rep_table(p_prog, l_prev_code_revision, ls_prev_identity, l_curr_code_revision, ls_curr_identity, "N") RETURNING lb_result
               IF NOT lb_result THEN
                  LET ls_err_msg = "ERROR : sadzp060_2_after_check_out_for_download : call sadzp188_copy_rep_table fail!"
                  GOTO _ROLLBACK_FLAG
               END IF
            END IF #ls_type="G" OR ls_type="X"
      
            #建立代碼樹,Section樹
            CALL sadzp060_2_create_code_structure(p_prog, p_curr_dzaf.*, p_prev_dzaf.*) RETURNING ls_err_msg
            IF NOT cl_null(ls_err_msg) THEN GOTO _ROLLBACK_FLAG END IF
            #搬移4rp
            IF ls_type="G" THEN #簽出樣版(4rp)
               CALL lo_template_list.CLEAR()
               LET lo_program_info.pi_MODULE = ls_prev_module
               LET lo_program_info.pi_NAME = p_prog
               #取得樣板陣列  
               CALL sadzp050_tple_get_template_records(g_lang, lo_program_info.*, lo_template_list) RETURNING lb_result,lo_template_list
               IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF

               LET ls_from_4rp_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(ls_prev_module)), "4rp")
               IF ls_prev_identity <> ls_curr_identity THEN
                  #要搬移標準目錄的4rp到客製目錄的4rp下,例如AXM到CXM之類的4rp搬移
                  LET ls_to_4rp_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(ls_curr_module)), "4rp") #語系之前的路徑
                  DISPLAY "sadzp060_2_after_check_out_for_download : s-->c 1: copy 4rp from ",ls_from_4rp_dir
                  DISPLAY "sadzp060_2_after_check_out_for_download : s-->c 1: copy 4rp to ",ls_to_4rp_dir
                  CALL sadzp050_zip_moving_4rp_files(p_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_result
                  IF NOT lb_result THEN 
                     LET ls_err_msg = "ERROR : sadzp060_2_after_check_out_for_download : call sadzp050_zip_moving_4rp_files() to ",ls_to_4rp_dir," fail!"
                     GOTO _ROLLBACK_FLAG
                  END IF

                  #做報表主機的4rp/語系目錄/4rp的複製動作
                  DISPLAY "sadzp060_2_after_check_out_for_download : 4rp s --> c"
                  #ex : D:/tiptop_gr/t10dev/aap/4rp/zh_TW/aapr300_g01.4rp
                  #LET ls_curr_module_path = os.path.JOIN(FGL_GETENV("MNT4RP") CLIPPED, DOWNSHIFT(ls_curr_module)) #2015/05/14 by Hiko
                  LET ls_curr_module_path = os.path.JOIN(cl_rpt_get_env_global("MNT4RP") CLIPPED, DOWNSHIFT(ls_curr_module)) #2015/11/02 by Hiko #2015/05/14 by Hiko
                  LET ls_to_4rp_dir = os.path.JOIN(ls_curr_module_path, "4rp")
                  DISPLAY "sadzp060_2_after_check_out_for_download : s-->c 2: copy 4rp from ",ls_from_4rp_dir
                  DISPLAY "sadzp060_2_after_check_out_for_download : s-->c 2: copy 4rp to ",ls_to_4rp_dir
                  CALL sadzp050_zip_moving_4rp_files(p_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_result
                  IF NOT lb_result THEN 
                     LET ls_err_msg = "ERROR : sadzp060_2_after_check_out_for_download : call sadzp050_zip_moving_4rp_files() to ",ls_to_4rp_dir," fail!"
                     GOTO _ROLLBACK_FLAG
                  END IF
               END IF

               #4rp/語系目錄複製到4rp/back/語系目錄的動作
               LET ls_to_4rp_dir = os.path.JOIN(os.path.JOIN(FGL_GETENV(UPSHIFT(ls_curr_module)), "4rp"), "back") #語系之前的路徑
               DISPLAY "sadzp060_2_after_check_out_for_download : copy 4rp from ",ls_from_4rp_dir
               DISPLAY "sadzp060_2_after_check_out_for_download : copy 4rp to ",ls_to_4rp_dir
               CALL sadzp050_zip_moving_4rp_files(p_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_result
               IF NOT lb_result THEN 
                  LET ls_err_msg = "ERROR : sadzp060_2_after_check_out_for_download : call sadzp050_zip_copy_4rp_list ",ls_to_4rp_dir," fail!"
                  GOTO _ROLLBACK_FLAG
               END IF
            END IF #IF ls_type="G"
            
            #2014/10/06 by Hiko:簽出下載程式就會做標準重產流程,所以只需要在標準變客製才會需要重產4gl,要不然會多做而影響效能.
            IF ls_prev_identity <> ls_curr_identity THEN 
               #要做4gl重新產生的動作,且要做編譯,避免測試時發生找不到執行檔的問題
               #Begin:2014/10/08 by Hiko
               #CALL FGL_SETENV("T100_SRCSTAND_SWITCH","off") #20150918 #2015/11/09 by Hiko
               #Begin:20160121 by Hiko
               #CALL sadzp060_2_rc3(p_prog, p_curr_dzaf.*, '1') RETURNING lb_result,ls_err_msg #2015/10/22 by Hiko
               CALL sadzp060_2_rc3(p_prog, p_curr_dzaf.*, '0') RETURNING lb_result,ls_err_msg #20160118 by Hiko:要做編譯與link, 但有錯誤也沒關係.
               #IF NOT lb_result THEN
               #   GOTO _ROLLBACK_FLAG
               #END IF
               ##CALL FGL_SETENV("T100_SRCSTAND_SWITCH","on") #20150918 #2015/11/09 by Hiko
               ##End:2014/10/08 by Hiko

               ##Begin:2015/01/07 by Hiko:link失敗不影響流程
               #LET ls_cmd = "r.l ",p_prog," ALL"
               #DISPLAY "sadzp060_2_after_check_out_for_download : ",ls_cmd
               #CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
               #IF NOT lb_result THEN
               #   DISPLAY "WARNING : ",ls_err_msg
               #END IF
               ##End:2015/01/07 by Hiko
               #End:20160121 by Hiko

               #Begin:2014/10/16 by Hiko
               #GR報表元件要產生rdd,編譯錯誤不影響流程
               IF ls_type="G" THEN #簽出樣版(4rp)
                  LET ls_to_4gl_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(ls_curr_module)), "4gl")
                  DISPLAY "sadzp060_2_after_check_out_for_download : change dir to ",ls_to_4gl_dir
                  IF cl_change_dir(ls_to_4gl_dir) THEN
                     LET ls_cmd = "r.c ",p_prog," rdd"
                     DISPLAY "sadzp060_2_after_check_out_for_download : ",ls_cmd
                     CALL cl_cmdrun_openpipe("r.c", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg3
                     IF NOT lb_result THEN
                        DISPLAY "WARNING : ",ls_err_msg3
                     END IF
                  ELSE
                     DISPLAY "WARNING : change dir to ",ls_to_4fd_dir," fail!"
                  END IF
               END IF
               #End:2014/10/16 by Hiko
            END IF
      END CASE

      #失敗也沒關係.
      #CALL sadzp060_2_dzay_t(p_prog, ls_prev_identity, "1") #2015/11/09 by Hiko:改在sadzp060_2_ins_dzax內執行.
      
      RETURN NULL #成功就沒有回傳錯誤訊息
      
      LABEL _ROLLBACK_FLAG:
         IF ls_prev_identity <> ls_curr_identity THEN
            LET ls_err_msg = "ERROR : ",ls_err_msg,' ',cl_getmsg("adz-00390", g_lang) #2014/09/09 by Hiko
            DISPLAY "ERROR : ",ls_err_msg
            #Begin:2014/06/17 by Hiko
            DISPLAY "after download rollback : update dzax_t.dzax006=",ls_prev_identity
            #Begin:2014/10/07 by Hiko
            CALL sadzp060_2_del_dzax(p_prog, ls_curr_identity) RETURNING ls_err_msg2
            IF NOT cl_null(ls_err_msg2) THEN #有錯誤訊息表示失敗
               LET ls_err_msg = ls_err_msg,' ',ls_err_msg2
            END IF
            #End:2014/10/07 by Hiko
            #End:2014/06/17 by Hiko

            #還原簽出(s --> c)時更新註冊的[是否客製]:N(s)
            #Begin:2015/06/12 by Hiko
            IF ls_type<>"Q" THEN
               CALL s_azzi900_upd_gzza011(p_prog, ls_type, ls_prev_identity) RETURNING lb_result
               IF NOT lb_result THEN 
                  LET ls_err_msg = ls_err_msg," ERROR : Updated registration information fail when download!"
               END IF
            END IF  
            #End:2015/06/12 by Hiko
         END IF
      
         RETURN ls_err_msg
   CATCH
      CALL sadzp060_2_err_catch(ls_trigger, ls_sql)
      LET ls_err_msg = "ERROR : call sadzp060_2_after_check_out_for_download fail!"
      RETURN ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 異動dzax_t.
# Input parameter : p_prog 程式代號
#                 : p_new_identity 新的客製標示
#                 : p_old_identity 舊的客製標示
# Return code     : BOOLEAN TRUE:成功;FALSE:失敗
#                 : STRING 錯誤訊息
# Date & Author   : 2014/07/29 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_ins_dzax(p_prog, ps_type, p_new_identity, p_old_identity)
   DEFINE p_prog         STRING,
          ps_type        STRING, #2014/10/16 by Hiko
          p_new_identity STRING, #2014/10/07 by Hiko
          p_old_identity STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          li_cnt SMALLINT,
          ls_err_msg STRING
   DEFINE lb_rtn BOOLEAN,
          ls_free_style STRING   #2014/10/16 by Hiko

   TRY
      LET ls_where = " WHERE dzax001='",p_prog,"' AND dzax006='",p_new_identity,"'" #2014/08/14 by Hiko
      LET ls_sql = "SELECT count(*)",
                    " FROM dzax_t",ls_where
      PREPARE dzax_prep1 FROM ls_sql
      EXECUTE dzax_prep1 INTO li_cnt
      FREE dzax_prep1
      
      IF li_cnt=0 THEN #找不到新的客製標示就要新增了.
         LET ls_where = " WHERE dzax001='",p_prog,"' AND dzax006='",p_old_identity,"'" 
         LET ls_sql = "SELECT count(*)",
                       " FROM dzax_t",ls_where
         PREPARE dzax_prep2 FROM ls_sql
         EXECUTE dzax_prep2 INTO li_cnt
         FREE dzax_prep2

         IF li_cnt=0 THEN #連舊的客製標示都找不到(這通常是非r.a的程式)
            LET ls_free_style = "N" #2014/10/16 by Hiko
            IF ps_type="B" OR ps_type="W" OR ps_type="Z" OR ps_type="Q" THEN #B,W,Z,Q的程式預設為Free Style
               LET ls_free_style = "Y"
            END IF
            LET ls_sql = "INSERT INTO dzax_t(dzax001,dzax002,dzax003,dzax004,dzax005,dzax006,dzax007,",
                                            "dzaxcrtdt,dzaxcrtdp,dzaxowndp,dzaxownid,dzaxstus,dzaxcrtid)",
                                    " VALUES('",p_prog,"','",ps_type,"','",ls_free_style,"','N','",gs_customer,"','",p_new_identity,"','',", #dzax003預設為"Y"是為了避開沒有設計資料的時候tab_gen的問題.
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
         ELSE #找到舊的dzax_t就當作新增基礎(這通常是標準變客製)
            LET ls_sql = "INSERT INTO dzax_t(dzax001,dzax002,dzax003,dzax004,dzax005,dzax006,dzax007,",
                                            "dzaxcrtdt,dzaxcrtdp,dzaxowndp,dzaxownid,dzaxstus,dzaxcrtid)",
                                    " SELECT dzax001,dzax002,dzax003,'N','",gs_customer,"','",p_new_identity,"',dzax007,",
                                            "?,'",gs_dept CLIPPED,"','",gs_dept CLIPPED,"','",g_user,"',dzaxstus,'",g_user,"'",
                                      " FROM dzax_t",ls_where
         END IF

         PREPARE dzax_prep9 FROM ls_sql
         EXECUTE dzax_prep9 USING g_date
         FREE dzax_prep9
      END IF

      RETURN TRUE,NULL
   CATCH
      CALL sadzp060_2_err_catch('', ls_sql)
      LET ls_err_msg = "ERROR : call sadzp060_2_ins_dzax fail!"
      RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 刪除dzax_t.
# Input parameter : p_prog 程式代號
#                 : p_new_identity 新的客製標示
# Return code     : STRING
# Date & Author   : 2014/10/07 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_2_del_dzax(p_prog, p_new_identity)
   DEFINE p_prog STRING,
          p_new_identity STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          li_cnt SMALLINT,
          ls_err_msg STRING

   TRY
      LET ls_where = " WHERE dzax001='",p_prog,"' AND dzax006='",p_new_identity,"'" 
      LET ls_sql = "SELECT count(*)",
                    " FROM dzax_t",ls_where
      PREPARE dzax_prep3 FROM ls_sql
      EXECUTE dzax_prep3 INTO li_cnt
      FREE dzax_prep3
      
      IF li_cnt>0 THEN
         LET ls_sql = "DELETE FROM dzax_t",ls_where
         EXECUTE IMMEDIATE ls_sql
      END IF
      
      RETURN NULL
   CATCH
      CALL sadzp060_2_err_catch('', ls_sql)
      LET ls_err_msg = "ERROR : call sadzp060_2_del_dzax fail!"
      RETURN ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 程式重產與重組
# Input parameter : p_prog 程式代號
#                 : p_dzaf 版次資訊
#                 : p_rc3_flag r.c3的選項(0:全做;1:做到產生和組合,不做編譯和鏈結;2:不做產生,只做組合,包含編譯和鏈結)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : STRING 錯誤訊息
# Date & Author   : 2014/10/08 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_rc3(p_prog, p_dzaf, p_rc3_flag)
   DEFINE p_prog STRING,
          p_dzaf T_DZAF_T,
          p_rc3_flag STRING #2014/11/11 by Hiko
   DEFINE l_type LIKE dzaf_t.dzaf005,
          l_spec_revision LIKE dzaf_t.dzaf003,
          l_code_revision LIKE dzaf_t.dzaf004,
          l_identity LIKE dzaf_t.dzaf010
   DEFINE ls_cmd STRING,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_err_msg3 STRING

   LET l_type = p_dzaf.dzaf005 CLIPPED
   LET l_spec_revision = p_dzaf.dzaf003
   LET l_code_revision = p_dzaf.dzaf004
   LET l_identity = p_dzaf.dzaf010 CLIPPED

   #要做4gl重新產生的動作(不做編譯..)
   IF l_type="G" OR l_type="X" THEN #報表元件設計資料的版次是屬於"程式"
      DISPLAY "sadzp060_2_rc3 : call sadzp030_tab_gen(",p_prog,",",l_code_revision,",'',",l_identity,")"
      CALL sadzp030_tab_gen(p_prog, l_code_revision, "", l_identity) RETURNING lb_result
   ELSE
      DISPLAY "sadzp060_2_rc3 : call sadzp030_tab_gen(",p_prog,",",l_spec_revision,",'',",l_identity,")"
      CALL sadzp030_tab_gen(p_prog, l_spec_revision, "", l_identity) RETURNING lb_result
   END IF
   
   IF NOT lb_result THEN
      LET ls_err_msg = "ERROR : call sadzp030_tab_gen fail!"
      RETURN FALSE,ls_err_msg
   ELSE
      #編譯錯誤沒關係
      LET ls_cmd = "r.c3 ",p_prog," ","''"," ",l_code_revision," ",p_rc3_flag," ",l_identity
      DISPLAY "sadzp060_2_rc3 : ",ls_cmd
      CALL cl_cmdrun_openpipe("r.c3", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg3
      IF NOT lb_result THEN
        #DISPLAY "WARNING : ",ls_err_msg3
         RETURN FALSE,ls_err_msg3 #20150915 真實反應對錯,由呼叫端控制流程
      END IF
   END IF

   RETURN TRUE,NULL
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 在取消簽出之後要做的事情.
# Input parameter : p_prog 程式代號
#                 : p_role 角色(SD/PR)
#                 : p_curr_dzaf 目前版次資訊
#                 : p_prev_dzaf 前版版次資訊
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_after_recall(p_prog, p_role, p_curr_dzaf, p_prev_dzaf)
   DEFINE p_prog STRING,
          p_role STRING,
          p_curr_dzaf T_DZAF_T, #範例:版次2
          p_prev_dzaf T_DZAF_T  #範例:版次1
   DEFINE ls_type STRING,
          l_curr_spec_revision LIKE dzaf_t.dzaf003, #recall:5-->4:curr=5;download:4-->5:curr=4
          l_curr_code_revision LIKE dzaf_t.dzaf004,
          ls_curr_identity STRING,
          ls_curr_module STRING,
          ls_curr_module_path STRING,
          l_prev_spec_revision LIKE dzaf_t.dzaf003,
          l_prev_code_revision LIKE dzaf_t.dzaf004,
          ls_prev_identity STRING,
          ls_prev_module STRING,
          ls_prev_module_path STRING
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_err_msg2 STRING,
          ls_err_msg3 STRING
   DEFINE lo_program_info T_PROGRAM_INFO,
          lo_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
          ls_from_4rp_dir STRING,
          ls_to_4rp_dir STRING,
          ls_to_4fd_dir STRING,
          ls_4fd STRING,
          ls_4fd_dir STRING,
          ls_cmd STRING,
          ls_temp_file STRING
   #Begin:2015/08/05 by Hiko
   DEFINE ls_err_code STRING,
          ls_owner STRING,
          ls_replace_arg STRING,
          li_idx SMALLINT,
          la_gzzb DYNAMIC ARRAY OF RECORD
                  gzzb001 LIKE gzzb_t.gzzb001
                  END RECORD,
          lb_continue BOOLEAN
   #End:2015/08/05 by Hiko

   #取消簽出流程說明:
   #情境三.s4<--s5 or c2<--c3
   #3-1.刪除樹
   #3-2.還原4rp
   #3-3.4fd重產
   #3-4.4gl重產
   #情四.s5<--c1
   #4-0.更新客製(c-->s)
   #4-1~4-4同3-1~3-4

   TRY
      IF NOT sadzp060_2_init_var() THEN
         LET ls_err_msg = "ERROR : sadzp060_2_after_recall.sadzp060_2_init_var"
         GOTO _ROLLBACK_FLAG
      END IF
      
      LET p_prog = p_prog.trim()
      LET ls_type = p_curr_dzaf.dzaf005 CLIPPED
      LET l_curr_spec_revision = p_curr_dzaf.dzaf003 CLIPPED
      LET l_curr_code_revision = p_curr_dzaf.dzaf004 CLIPPED
      LET ls_curr_identity = p_curr_dzaf.dzaf010 CLIPPED
      LET ls_curr_module = p_curr_dzaf.dzaf006 CLIPPED
      LET ls_curr_module_path = FGL_GETENV(UPSHIFT(ls_curr_module))
      LET l_prev_spec_revision = p_prev_dzaf.dzaf003 CLIPPED
      LET l_prev_code_revision = p_prev_dzaf.dzaf004 CLIPPED
      LET ls_prev_identity = p_prev_dzaf.dzaf010 CLIPPED
      LET ls_prev_module = p_prev_dzaf.dzaf006 CLIPPED
      LET ls_prev_module_path = FGL_GETENV(UPSHIFT(ls_prev_module))

      #Begin:2015/08/05 by Hiko
      #不分簽出的角色, M類程式要注意對應的行業程式是否已經簽出.
      IF ls_type.equals("M") THEN
         LET lb_continue = TRUE
         LET ls_sql = "SELECT gzzb001 FROM gzzb_t WHERE gzzb002<>'sd' AND gzzb003='",p_prog,"' ORDER BY gzzb001"
         PREPARE gzzb_prep FROM ls_sql
         DECLARE gzzb_curs CURSOR FOR gzzb_prep
         LET li_idx = 1
         FOREACH gzzb_curs INTO la_gzzb[li_idx].*
            LET lo_program_info.pi_NAME = la_gzzb[li_idx].gzzb001  #程式代碼
            LET lo_program_info.pi_TYPE = ls_type #類別
            CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info.*, "SD") RETURNING lb_result,ls_owner
            IF NOT lb_result THEN #行業規格沒簽出繼續檢查行業程式是否簽出.
               CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info.*, "PR") RETURNING lb_result,ls_owner
               IF lb_result THEN #行業程式已經被簽出.
                  LET lb_continue = FALSE
                  LET ls_err_code = "adz-00679" #對應的行業程式%1正被%2簽出中, 所以%3無法取消簽出.
                  LET ls_replace_arg = la_gzzb[li_idx].gzzb001,"|",ls_owner,"|",p_prog
                  EXIT FOREACH
               END IF
            ELSE
               LET lb_continue = FALSE
               LET ls_err_code = "adz-00678" #對應的行業規格%1正被%2簽出中, 所以%3無法取消簽出.
               LET ls_replace_arg = la_gzzb[li_idx].gzzb001,"|",ls_owner,"|",p_prog
               EXIT FOREACH
            END IF

            LET li_idx = li_idx + 1
         END FOREACH
         
         IF NOT lb_continue THEN
            CALL cl_replace_err_msg(cl_getmsg(ls_err_code, g_lang), ls_replace_arg) RETURNING ls_err_msg
            RETURN ls_err_msg
         END IF
      END IF
      #End:2015/08/05 by Hiko

      CASE p_role
         WHEN "SD"
            IF cl_null(l_prev_spec_revision) THEN
               DISPLAY "prev_spec_revision is null, RETURN NULL"
               RETURN NULL
            END IF
         WHEN "PR"
            IF cl_null(l_prev_code_revision) THEN
               DISPLAY "prev_code_revision is null, RETURN NULL"
               RETURN NULL
            END IF
      END CASE

      DISPLAY "after recall : p_role=",p_role,"<<"   
      DISPLAY "after recall : p_prog=",p_prog,"<<"   
      DISPLAY "after recall : ls_type=",ls_type,"<<"   
      DISPLAY "after recall : l_curr_spec_revision=",l_curr_spec_revision,"<<"   
      DISPLAY "after recall : l_curr_code_revision=",l_curr_code_revision,"<<"   
      DISPLAY "after recall : ls_curr_identity=",ls_curr_identity,"<<"   
      DISPLAY "after recall : ls_curr_module=",ls_curr_module,"<<"   
      DISPLAY "after recall : ls_curr_module_path=",ls_curr_module_path,"<<"   
      DISPLAY "after recall : l_prev_spec_revision=",l_prev_spec_revision,"<<"   
      DISPLAY "after recall : l_prev_code_revision=",l_prev_code_revision,"<<"   
      DISPLAY "after recall : ls_prev_identity=",ls_prev_identity,"<<"   
      DISPLAY "after recall : ls_prev_module=",ls_prev_module,"<<"   
      DISPLAY "after recall : ls_prev_module_path=",ls_prev_module_path,"<<"   
      
      #以流程來說,不可能會有c --> s的情況,因為s --> c的當下就已經產生了1c並簽入,所以客戶看到的是2c的簽出,所以取消簽出只是2c --> 1c.
      
      CASE p_role
         WHEN "SD"
            CALL sadzp063_1_del_design_data(p_prev_dzaf.*, '1') RETURNING lb_result,ls_err_msg #2014/11/19 by Hiko
            IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF
         WHEN "PR"
            #Begin:2014/11/19 by Hiko
            IF ls_type="G" OR ls_type="X" THEN
               #刪除報表元件設計資料(adzp188) #2015/05/14 by Hiko              
               DISPLAY "sadzp060_2_after_recall : call sadzp188_copy_rep_table(",p_prog,",",l_prev_code_revision,",",ls_prev_identity,",",l_curr_code_revision,",",ls_curr_identity,",D)"
               CALL sadzp188_copy_rep_table(p_prog, l_prev_code_revision, ls_prev_identity, l_curr_code_revision, ls_curr_identity, "D") RETURNING lb_result
               IF NOT lb_result THEN
                  LET ls_err_msg = "ERROR : sadzp060_2_after_recall : call sadzp188_copy_rep_table fail! "
                  GOTO _ROLLBACK_FLAG
               END IF
            
               IF ls_type="G" THEN 
                  #todo:有4rp設計資料後就得刪除
               END IF
            END IF

            CALL sadzp063_1_del_design_data(p_prev_dzaf.*, '2') RETURNING lb_result,ls_err_msg #2014/11/19 by Hiko
            IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF
            #End:2014/11/19 by Hiko

            IF ls_type="G" THEN 
               CALL lo_template_list.CLEAR()
               LET lo_program_info.pi_MODULE = ls_prev_module
               LET lo_program_info.pi_NAME = p_prog
               #取得樣板陣列  
               CALL sadzp050_tple_get_template_records(g_lang, lo_program_info.*, lo_template_list) RETURNING lb_result,lo_template_list
               IF NOT lb_result THEN GOTO _ROLLBACK_FLAG END IF

               #將4rp/back/語系目錄下的4rp全部還原到對應的4rp/語系目錄
               LET ls_from_4rp_dir = os.path.JOIN(os.path.JOIN(ls_curr_module_path, "4rp"), "back")
               LET ls_to_4rp_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(ls_prev_module)), "4rp") #語系之前的路徑
               DISPLAY "sadzp060_2_after_recall 1: copy from 4rp dir : ",ls_from_4rp_dir
               DISPLAY "sadzp060_2_after_recall 1: copy to 4rp dir : ",ls_to_4rp_dir
               CALL sadzp050_zip_moving_4rp_files(p_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_result
               IF NOT lb_result THEN 
                  LET ls_err_msg = "ERROR : sadzp060_2_after_recall : call sadzp050_zip_moving_4rp_files() to ",ls_from_4rp_dir," fail!"
                  GOTO _ROLLBACK_FLAG
               END IF

               #將4rp/語系目錄下的4rp全部還原到報表主機對應的4rp/語系目錄:同簽出的動作,但一定是在back搬到module後才可以這樣做
               #LET ls_prev_module_path = os.path.JOIN(FGL_GETENV("MNT4RP") CLIPPED, DOWNSHIFT(ls_prev_module))
               LET ls_prev_module_path = os.path.JOIN(cl_rpt_get_env_global("MNT4RP") CLIPPED, DOWNSHIFT(ls_prev_module)) #2015/11/02 by Hiko
               LET ls_to_4rp_dir = os.path.JOIN(ls_prev_module_path, "4rp")
               DISPLAY "sadzp060_2_after_recall 2: copy from 4rp dir : ",ls_from_4rp_dir
               DISPLAY "sadzp060_2_after_recall 2: copy to 4rp dir : ",ls_to_4rp_dir
               CALL sadzp050_zip_moving_4rp_files(p_prog, ls_from_4rp_dir, ls_to_4rp_dir, lo_template_list) RETURNING lb_result
               IF NOT lb_result THEN 
                  LET ls_err_msg = "ERROR : sadzp060_2_after_recall : call sadzp050_zip_moving_4rp_files() to ",ls_to_4rp_dir," fail!"
                  GOTO _ROLLBACK_FLAG
               END IF
            END IF
      END CASE
      
      #失敗也沒關係.
      CALL sadzp060_2_dzay_t(p_prog, ls_prev_identity, "2")

      RETURN NULL #成功就沒有回傳錯誤訊息
      
      LABEL _ROLLBACK_FLAG:
         #以流程來說,不可能會有c --> s的情況,因為s --> c的當下就已經產生了1c並簽入,所以客戶看到的是2c的簽出,所以取消簽出只是2c --> 1c.
         RETURN ls_err_msg
   CATCH
      CALL sadzp060_2_err_catch(ls_trigger, ls_sql)
      LET ls_err_msg = "ERROR : call sadzp060_2_after_recall fail!"
      RETURN ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立規格結構樹.
# Input parameter : p_prog 程式代號
#                 : p_curr_dzaf 目前版次資訊
#                 : p_prev_dzaf 前版版次資訊
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_create_spec_structure(p_prog, p_curr_dzaf, p_prev_dzaf)
   DEFINE p_prog STRING,
          p_curr_dzaf T_DZAF_T,
          p_prev_dzaf T_DZAF_T
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   DEFINE ls_type STRING,
          l_curr_spec_revision LIKE dzaf_t.dzaf003,
          l_prev_spec_revision LIKE dzaf_t.dzaf003,
          ls_curr_identity STRING,
          ls_prev_identity STRING, #2015/09/16 by Hiko
          ls_replace_arg   STRING, #2015/09/16 by Hiko
          lb_result BOOLEAN,
          ls_err_msg STRING

   TRY
      LET p_prog = p_prog.trim()
      LET ls_type = p_curr_dzaf.dzaf005 CLIPPED
      LET l_curr_spec_revision = p_curr_dzaf.dzaf003 CLIPPED
      LET l_prev_spec_revision = p_prev_dzaf.dzaf003 CLIPPED
      LET ls_curr_identity = p_curr_dzaf.dzaf010 CLIPPED
      LET ls_prev_identity = p_prev_dzaf.dzaf010 CLIPPED #2015/09/16 by Hiko
   
      #Begin:2014/10/27 by Hiko
      IF cl_null(l_prev_spec_revision) OR l_prev_spec_revision=0 THEN
         RETURN NULL
      END IF
      #End:2014/10/27 by Hiko

      LET ls_trigger = "sadzp060_2_create_spec_structure : check dzaa_t current ver data count"
      #Begin:2015/08/26 by Hiko
      #標準轉客製的時候,要先將客製資料刪除,以免有殘留資料而造成資料不齊全.
      IF p_prev_dzaf.dzaf010='s' AND p_curr_dzaf.dzaf010='c' THEN
         LET ls_sql = "DELETE FROM dzaa_t",
                      " WHERE dzaa001='",p_prog,"'",
                      "   AND dzaa009='c'"
         EXECUTE IMMEDIATE ls_sql
      END IF
      #End:2015/08/26 by Hiko
      #判斷規格樹(dzaa_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzaa_t",
                   " WHERE dzaa001='",p_prog,"' AND dzaa002='",l_curr_spec_revision,"' AND dzaa009='",ls_curr_identity,"'" #這裡不能加上dzaastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzaa_prep1 FROM ls_sql
      EXECUTE dzaa_prep1 INTO li_cnt
      FREE dzaa_prep1

      IF li_cnt=0 THEN 
         #Begin:2015/09/16 by Hiko
         IF ls_type MATCHES "[MSFQ]" THEN
            IF ls_prev_identity=ls_curr_identity THEN #相同客製標示才多這個判斷.
               IF l_prev_spec_revision>0 THEN
                  LET ls_sql = "SELECT count(*)",
                                " FROM dzaa_t",
                               " WHERE dzaa001='",p_prog,"' AND dzaa002='",l_prev_spec_revision,"' AND dzaa009='",ls_prev_identity,"'" #這裡不能加上dzaastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
                  PREPARE dzaa_prep9 FROM ls_sql
                  EXECUTE dzaa_prep9 INTO li_cnt
                  FREE dzaa_prep9
                  
                  IF li_cnt=0 THEN
                     LET ls_replace_arg = l_prev_spec_revision
                     LET ls_replace_arg = ls_replace_arg.trim(),"|SPEC"
                     LET ls_err_msg = cl_replace_err_msg(cl_getmsg("adz-00700", g_lang), ls_replace_arg) #找不到舊版(第%1版)的%2設計資料, 請查明問題後再繼續執行. 
                     DISPLAY "ERROR : ",ls_err_msg
                     RETURN ls_err_msg
                  END IF
               END IF
            END IF
            
            LET li_cnt = 0
         END IF
         #End:2015/09/16 by Hiko

         #要以舊的版本當作基底建立規格樹.
         LET ls_trigger = "sadzp060_2_create_spec_structure : insert new ver dzaa_t"
         LET ls_sql = "INSERT INTO dzaa_t(dzaa001,dzaa002,dzaa003,dzaa004,dzaa005,",
                                         "dzaa006,dzaa007,dzaa008,dzaa009,dzaa010,",
                                         "dzaacrtdt,dzaacrtdp,dzaaowndp,dzaaownid,dzaastus,dzaacrtid)",
                                 " SELECT dzaa001,'",l_curr_spec_revision,"',dzaa003,dzaa004,dzaa005,",
                                         "dzaa006,dzaa007,dzaa008,'",ls_curr_identity,"','",gs_customer,"',", 
                                         "?,'",gs_dept CLIPPED,"','",gs_dept CLIPPED,"','",g_user,"',dzaastus,'",g_user,"'",
                                   " FROM dzaa_t",
                                  " WHERE dzaa001='",p_prog,"'",
                                    " AND dzaa002='",p_prev_dzaf.dzaf003 CLIPPED,"'",
                                    " AND dzaa009='",p_prev_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzaastus='Y'"
         PREPARE dzaa_prep3 FROM ls_sql
         EXECUTE dzaa_prep3 USING g_date
         FREE dzaa_prep3
      END IF

      RETURN NULL
   CATCH 
      CALL sadzp060_2_err_catch(ls_trigger, ls_sql) 
      RETURN "ERROR : sadzp060_2_create_spec_structure faliure!"
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立程式結構樹(包含add point和section)
# Input parameter : p_prog 程式代號
#                 : p_curr_dzaf 目前版次資訊
#                 : p_prev_dzaf 前版版次資訊
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_create_code_structure(p_prog, p_curr_dzaf, p_prev_dzaf)
   DEFINE p_prog STRING,
          p_curr_dzaf T_DZAF_T,
          p_prev_dzaf T_DZAF_T
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   DEFINE ls_type STRING,
          l_curr_code_revision LIKE dzaf_t.dzaf004,
          l_prev_code_revision LIKE dzaf_t.dzaf004,
          ls_curr_identity STRING,
          ls_prev_identity STRING, #2015/09/16 by Hiko
          ls_replace_arg   STRING, #2015/09/16 by Hiko
          lb_result BOOLEAN,
          ls_err_msg STRING

   TRY
      LET p_prog = p_prog.trim()
      LET ls_type = p_curr_dzaf.dzaf005 CLIPPED
      LET l_curr_code_revision = p_curr_dzaf.dzaf004 CLIPPED
      LET l_prev_code_revision = p_prev_dzaf.dzaf004 CLIPPED
      LET ls_curr_identity = p_curr_dzaf.dzaf010 CLIPPED
      LET ls_prev_identity = p_prev_dzaf.dzaf010 CLIPPED #2015/09/16 by Hiko

      #Begin:2014/10/27 by Hiko
      IF cl_null(l_prev_code_revision) OR l_prev_code_revision=0 THEN
         RETURN NULL
      END IF
      #End:2014/10/27 by Hiko

      LET ls_trigger = "sadzp060_2_create_code_structure : check dzba_t current ver data count"
      #Begin:2015/08/26 by Hiko
      #標準轉客製的時候,要先將客製資料刪除,以免有殘留資料而造成資料不齊全.
      IF p_prev_dzaf.dzaf010='s' AND p_curr_dzaf.dzaf010='c' THEN
         LET ls_sql = "DELETE FROM dzba_t",
                      " WHERE dzba001='",p_prog,"'",
                      "   AND dzba010='c'"
         EXECUTE IMMEDIATE ls_sql
      END IF
      #End:2015/08/26 by Hiko
      #判斷add point樹(dzba_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzba_t",
                   " WHERE dzba001='",p_prog,"' AND dzba002='",l_curr_code_revision,"' AND dzba010='",ls_curr_identity,"'" #這裡不能加上dzbastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzba_prep1 FROM ls_sql
      EXECUTE dzba_prep1 INTO li_cnt
      FREE dzba_prep1

      IF li_cnt=0 THEN 
         #Begin:2015/09/16 by Hiko
         IF ls_type MATCHES "[MSQ]" THEN
            IF ls_prev_identity=ls_curr_identity THEN #相同客製標示才多這個判斷.
               IF l_prev_code_revision>0 THEN
                  LET ls_sql = "SELECT count(*)",
                                " FROM dzba_t",
                               " WHERE dzba001='",p_prog,"' AND dzba002='",l_prev_code_revision,"' AND dzba010='",ls_prev_identity,"'" #這裡不能加上dzbastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
                  PREPARE dzba_prep9 FROM ls_sql
                  EXECUTE dzba_prep9 INTO li_cnt
                  FREE dzba_prep9
                  
                  IF li_cnt=0 THEN
                     LET ls_replace_arg = l_prev_code_revision
                     LET ls_replace_arg = ls_replace_arg.trim(),"|ADD POINT"
                     LET ls_err_msg = cl_replace_err_msg(cl_getmsg("adz-00700", g_lang), ls_replace_arg) #找不到舊版(第%1版)的%2設計資料, 請查明問題後再繼續執行. 
                     DISPLAY "ERROR : ",ls_err_msg
                     RETURN ls_err_msg
                  END IF
               END IF
            END IF
            
            LET li_cnt = 0
         END IF
         #End:2015/09/16 by Hiko

         #要以舊的版本當作基底建立程式樹.
         LET ls_trigger = "sadzp060_2_create_code_structure : insert new ver dzba_t"
         LET ls_sql = "INSERT INTO dzba_t(dzba001,dzba002,dzba003,dzba004,dzba005,",
                                         "dzba006,dzba007,dzba008,dzba009,dzba010,dzba011,",
                                         "dzbacrtdt,dzbacrtdp,dzbaowndp,dzbaownid,dzbastus,dzbacrtid)",
                                 " SELECT dzba001,'",l_curr_code_revision,"',dzba003,dzba004,dzba005,",
                                         "dzba006,dzba007,dzba008,dzba009,'",ls_curr_identity,"','",gs_customer,"',", 
                                         "?,'",gs_dept CLIPPED,"','",gs_dept CLIPPED,"','",g_user,"',dzbastus,'",g_user,"'",
                                   " FROM dzba_t",
                                  " WHERE dzba001='",p_prog,"'",
                                    " AND dzba002='",p_prev_dzaf.dzaf004 CLIPPED,"'",
                                    " AND dzba010='",p_prev_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzbastus='Y'"
         PREPARE dzba_prep3 FROM ls_sql
         EXECUTE dzba_prep3 USING g_date
         FREE dzba_prep3
      END IF

      LET ls_trigger = "sadzp060_2_create_code_structure : check dzbc_t current ver data count"
      #Begin:2015/08/26 by Hiko
      IF p_prev_dzaf.dzaf010='s' AND p_curr_dzaf.dzaf010='c' THEN
         #Begin:2015/09/14 by Hiko:G/X類在標準轉客製的時候,要將客製flag全部變成c.
         IF ls_type="G" OR ls_type="X" THEN
            LET ls_sql = "INSERT INTO dzbb_t(dzbb001,dzbb002,dzbb003,dzbb004,dzbb005,dzbb006,dzbb007,dzbb098,dzbbstus) ",
                         "SELECT dzbb001,dzbb002,dzbb003,'c',dzbb005,dzbb006,dzbb007,dzbb098,dzbbstus FROM dzbb_t",
                         " INNER JOIN dzba_t ON dzba001=dzbb001 AND dzba003=dzbb002 AND dzba004=dzbb003 AND dzba005=dzbb004",
                         " WHERE dzba001='",p_prog,"' AND dzba002=",l_prev_code_revision," AND dzba010='s' ORDER BY dzbb002"
            PREPARE dzbb_prep4 FROM ls_sql
            EXECUTE dzbb_prep4
            FREE dzbb_prep4
            
            LET ls_sql = "UPDATE dzba_t SET dzba005='c'",
                         " WHERE dzba001='",p_prog,"'",
                         "   AND dzba002=",l_curr_code_revision,
                         "   AND dzba010='c'"
            PREPARE dzba_prep4 FROM ls_sql
            EXECUTE dzba_prep4
            FREE dzba_prep4
         END IF
         #End:2015/09/14 by Hiko

         #標準轉客製的時候,要先將客製資料刪除,以免有殘留資料而造成資料不齊全.
         LET ls_sql = "DELETE FROM dzbc_t",
                      " WHERE dzbc001='",p_prog,"'",
                      "   AND dzbc007='c'"
         EXECUTE IMMEDIATE ls_sql
      END IF
      #End:2015/08/26 by Hiko

      #判斷section樹(dzbc_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzbc_t",
                   " WHERE dzbc001='",p_prog,"' AND dzbc002='",l_curr_code_revision,"' AND dzbc007='",ls_curr_identity,"'" #這裡不能加上dzbcstus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzbc_prep1 FROM ls_sql
      EXECUTE dzbc_prep1 INTO li_cnt
      FREE dzbc_prep1

      IF li_cnt=0 THEN 
         #Begin:2015/09/16 by Hiko
         IF ls_type MATCHES "[MSQ]" THEN
            IF ls_prev_identity=ls_curr_identity THEN #相同客製標示才多這個判斷.
               IF l_prev_code_revision>0 THEN
                  LET ls_sql = "SELECT count(*)",
                                " FROM dzbc_t",
                               " WHERE dzbc001='",p_prog,"' AND dzbc002='",l_prev_code_revision,"' AND dzbc007='",ls_prev_identity,"'" #這裡不能加上dzbcstus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
                  PREPARE dzbc_prep9 FROM ls_sql
                  EXECUTE dzbc_prep9 INTO li_cnt
                  FREE dzbc_prep9
                  
                  IF li_cnt=0 THEN
                     LET ls_replace_arg = l_prev_code_revision
                     LET ls_replace_arg = ls_replace_arg.trim(),"|SECTION"
                     LET ls_err_msg = cl_replace_err_msg(cl_getmsg("adz-00700", g_lang), ls_replace_arg) #找不到舊版(第%1版)的%2設計資料, 請查明問題後再繼續執行. 
                     DISPLAY "ERROR : ",ls_err_msg
                     RETURN ls_err_msg
                  END IF
               END IF
            END IF
            
            LET li_cnt = 0
         END IF
         #End:2015/09/16 by Hiko

         #要以舊的版本當作基底建立規格樹.
         LET ls_trigger = "sadzp060_2_create_code_structure : insert new ver dzbc_t"
         LET ls_sql = "INSERT INTO dzbc_t(dzbc001,dzbc002,dzbc003,dzbc004,dzbc005,",
                                         "dzbc006,dzbc007,dzbc008,dzbc009,dzbc010,dzbc011,", #2014/09/10 by Hiko:補上dzbc009~dzbc011
                                         "dzbccrtdt,dzbccrtdp,dzbcowndp,dzbcownid,dzbcstus,dzbccrtid)",
                                 " SELECT dzbc001,'",l_curr_code_revision,"',dzbc003,dzbc004,dzbc005,",
                                         "dzbc006,'",ls_curr_identity,"','",gs_customer,"','',dzbc010,dzbc011,", 
                                         "?,'",gs_dept CLIPPED,"','",gs_dept CLIPPED,"','",g_user,"',dzbcstus,'",g_user,"'",
                                   " FROM dzbc_t",
                                  " WHERE dzbc001='",p_prog,"'",
                                    " AND dzbc002='",p_prev_dzaf.dzaf004 CLIPPED,"'",
                                    " AND dzbc007='",p_prev_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzbcstus='Y'"

         PREPARE dzbc_prep3 FROM ls_sql
         EXECUTE dzbc_prep3 USING g_date
         FREE dzbc_prep3
      END IF 

      RETURN NULL
   CATCH 
      CALL sadzp060_2_err_catch(ls_trigger, ls_sql) 
      RETURN "ERROR : sadzp060_2_create_code_structure faliure!"
   END TRY
END FUNCTION

{
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立元件規格結構樹.
# Input parameter : p_prog 程式代號
#                 : p_curr_dzaf 目前版次資訊
#                 : p_prev_dzaf 前版版次資訊
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_2_create_comp_spec_structure(p_prog, p_curr_dzaf, p_prev_dzaf)
   DEFINE p_prog STRING,
          p_curr_dzaf T_DZAF_T,
          p_prev_dzaf T_DZAF_T
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   DEFINE ls_type STRING,
          l_curr_spec_revision LIKE dzaf_t.dzaf003,
          l_prev_spec_revision LIKE dzaf_t.dzaf003,
          ls_curr_identity STRING,
          lb_result BOOLEAN,
          ls_err_msg STRING

   TRY
      LET p_prog = p_prog.trim()
      LET ls_type = p_curr_dzaf.dzaf005 CLIPPED
      LET l_curr_spec_revision = p_curr_dzaf.dzaf003 CLIPPED
      LET l_prev_spec_revision = p_prev_dzaf.dzaf003 CLIPPED
      LET ls_curr_identity = p_curr_dzaf.dzaf010 CLIPPED

      #Begin:2014/10/27 by Hiko
      IF cl_null(l_prev_spec_revision) OR l_prev_spec_revision=0 THEN
         RETURN NULL
      END IF
      #End:2014/10/27 by Hiko

      LET ls_trigger = "sadzp060_2_create_comp_spec_structure : check dzdp_t current ver data count"
      #判斷元件規格樹(dzdp_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzdp_t",
                   " WHERE dzdp001='",p_prog,"' AND dzdp002='",l_curr_spec_revision,"' AND dzdp006='",ls_curr_identity,"'" #這裡不能加上dzdpstus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzdp_prep1 FROM ls_sql
      EXECUTE dzdp_prep1 INTO li_cnt
      FREE dzdp_prep1
      #資料存在先砍舊資料,以免有殘留資料而造成資料不齊全.
      IF li_cnt=0 THEN 
         #要以舊的版本當作基底建立規格樹.
         LET ls_trigger = "sadzp060_2_create_spec_structure : insert new ver dzdp_t"
         LET ls_sql = "INSERT INTO dzdp_t(dzdp001,dzdp002,dzdp003,dzdp004,dzdp005,",
                                         "dzdp006,dzdp007,dzdp008,",
                                         "dzdpcrtdt,dzdpcrtdp,dzdpowndp,dzdpownid,dzdpstus,dzdpcrtid)",
                                 " SELECT dzdp001,'",l_curr_spec_revision,"',dzdp003,dzdp004,dzdp005,",
                                         "'",ls_curr_identity,"','",gs_customer,"',dzdp008,", 
                                         "?,'",gs_dept CLIPPED,"','",gs_dept CLIPPED,"','",g_user,"',dzdpstus,'",g_user,"'",
                                   " FROM dzdp_t",
                                  " WHERE dzdp001='",p_prog,"'",
                                    " AND dzdp002='",p_prev_dzaf.dzaf003 CLIPPED,"'",
                                    " AND dzdp006='",p_prev_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzdpstus='Y'"
         PREPARE dzdp_prep3 FROM ls_sql
         EXECUTE dzdp_prep3 USING g_date
         FREE dzdp_prep3
      END IF

      RETURN NULL
   CATCH 
      CALL sadzp060_2_err_catch(ls_trigger, ls_sql) 
      RETURN "ERROR : sadzp060_2_create_comp_spec_structure faliure!"
   END TRY
END FUNCTION
}

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 取得當下規格的版次和識別標示
# Input parameter : p_prog 程式代號
#                 : p_type 建構類型(M/S/F/B/G/X/...)
#                 : p_module 模組別
# Return code     : STRING 版次
#                 : STRING 識別標示
#                 : STRING 錯誤訊息(NULL表示成功)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_get_spec_curr_revision(p_prog, p_type, p_module)
   DEFINE p_prog STRING,
          p_type STRING,
          p_module STRING
   DEFINE lo_DZAF_T T_DZAF_T,
          l_revision LIKE dzaf_t.dzaf003,
          l_identity LIKE dzaf_t.dzaf010,
          ls_err_msg STRING

   CALL sadzp060_2_get_curr_ver_info(p_prog, p_type, p_module) RETURNING lo_DZAF_T.*,ls_err_msg
   IF cl_null(ls_err_msg) THEN
      LET l_revision = lo_DZAF_T.dzaf003 CLIPPED
      IF cl_null(l_revision) OR l_revision=0 THEN 
         LET ls_err_msg = "ERROR : ",p_prog," spec revision is NULL or 0"
         RETURN l_revision,lo_DZAF_T.dzaf010 CLIPPED,ls_err_msg
      END IF
   END IF

   RETURN l_revision,lo_DZAF_T.dzaf010 CLIPPED,ls_err_msg
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 取得當下代碼的版次和識別標示
# Input parameter : p_prog 程式代號
#                 : p_type 建構類型(M/S/F/B/G/X/...)
#                 : p_module 模組別
# Return code     : STRING 版次
#                 : STRING 識別標示
#                 : STRING 錯誤訊息(NULL表示成功)
# Date & Author   : 2014/05/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_get_code_curr_revision(p_prog, p_type, p_module)
   DEFINE p_prog STRING,
          p_type STRING,
          p_module STRING
   DEFINE lo_DZAF_T T_DZAF_T,
          l_revision LIKE dzaf_t.dzaf004,
          l_identity LIKE dzaf_t.dzaf010,
          ls_err_msg STRING

   CALL sadzp060_2_get_curr_ver_info(p_prog, p_type, p_module) RETURNING lo_DZAF_T.*,ls_err_msg
   IF cl_null(ls_err_msg) THEN
      LET l_revision = lo_DZAF_T.dzaf004 CLIPPED
      IF cl_null(l_revision) OR l_revision=0 THEN 
         LET ls_err_msg = "ERROR : ",p_prog," code revision is NULL or 0"
         RETURN l_revision,lo_DZAF_T.dzaf010 CLIPPED,ls_err_msg
      END IF
   END IF

   RETURN l_revision,lo_DZAF_T.dzaf010 CLIPPED,ls_err_msg
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 取得當下程式(包含規格和代碼)的版次相關資訊
# Input parameter : p_prog 程式代號
#                 : p_type 建構類型(M/S/F/B/G/X/...)
#                 : p_module 模組別
# Return code     : T_DZAF_T 版次資訊物件
#                 : STRING 錯誤訊息(NULL表示成功)
# Date & Author   : 2014/05/22 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_get_curr_ver_info(p_prog, p_type, p_module)
   DEFINE p_prog STRING,
          p_type STRING,
          p_module STRING
   DEFINE lo_DZAF_T T_DZAF_T,
          lo_DZAF_T_new T_DZAF_T
   DEFINE ls_err_msg STRING

   LET lo_DZAF_T.DZAF001 = p_prog.trim()
   LET lo_DZAF_T.DZAF005 = p_type.trim()
   LET lo_DZAF_T.DZAF006 = p_module.trim()
   LET lo_DZAF_T.DZAF002 = g_dzaf002 #2014/06/23 by Hiko
   LET lo_DZAF_T.DZAF010 = "c" #先找是否存在客製版次資料
   CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T_new.*
   
   IF cl_null(lo_DZAF_T_new.DZAF002) OR lo_DZAF_T_new.DZAF002=0 THEN
      LET lo_DZAF_T.DZAF010 = "s" #沒有客製再找標準版次資料
      CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T_new.*
      IF cl_null(lo_DZAF_T_new.DZAF002) OR lo_DZAF_T_new.DZAF002=0 THEN
         LET ls_err_msg = "WARNING : ",p_prog," revision info is NULL" #160516-00005
         RETURN lo_DZAF_T_new.*,ls_err_msg
      END IF
   END IF

   RETURN lo_DZAF_T_new.*,NULL
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 取得當下程式(包含規格和代碼)的版次相關資訊
# Input parameter : p_prog 程式代號
#                 : p_type 建構類型(M/S/F/B/G/X/...)
#                 : p_module 模組別
#                 : p_dzaf002 建構版次
# Return code     : T_DZAF_T 版次資訊物件
#                 : STRING 錯誤訊息(NULL表示成功)
# Date & Author   : 2014/06/23 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_get_curr_ver_info_by_dzaf002(p_prog, p_type, p_module, p_dzaf002)
   DEFINE p_prog STRING,
          p_dzaf002 LIKE dzaf_t.dzaf002,
          p_type STRING,
          p_module STRING
   DEFINE lo_DZAF_T T_DZAF_T
   DEFINE ls_err_msg STRING

   LET g_dzaf002 = p_dzaf002 #初始建構版次

   CALL sadzp060_2_get_curr_ver_info(p_prog, p_type, p_module) RETURNING lo_DZAF_T.*,ls_err_msg

   LET g_dzaf002 = NULL #初始還原
   
   RETURN lo_DZAF_T.*,ls_err_msg
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 取得程式類型
# Input parameter : p_prog 程式代號
# Return code     : STRING type
# Date & Author   : 2014/08/26 by madey
##########################################################################
#+ 取得程式類型
PUBLIC FUNCTION sadzp060_2_chk_spec_type(ls_specid)
   DEFINE ls_specid   STRING
   DEFINE ls_spectype LIKE type_t.chr1
   DEFINE lc_gzde001  LIKE gzde_t.gzde001
   DEFINE lc_gzde003  LIKE gzde_t.gzde003
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_tmp      STRING
   DEFINE lc_dzca001  LIKE dzca_t.dzca001
   DEFINE lc_gzdf002  LIKE gzdf_t.gzdf002 #160706-00001

   #注意:修改時請確認以下function規則是否需要一併調整:sadzp060_2_chk_spec_type()與cl_adz_chk_spec_type()與cl_chk_spec_type() #160706-00001

   LET ls_specid = ls_specid.trim()

   #確認傳入是否為子畫面
  #Begin: 160706-00001 modify
  #IF ls_specid.subString(ls_specid.getLength()-3,ls_specid.getLength()-2) = "_s" THEN
  #   #注意最後兩碼一定是數字
  #   LET ls_tmp = ls_specid.subString(ls_specid.getLength()-1,ls_specid.getLength())
  #   IF cl_chk_num(ls_tmp,"N") THEN
  #      #子畫面
  #      LET ls_spectype = "F"
  #      RETURN ls_spectype
  #   END IF
  #END IF
   LET lc_gzdf002 = ls_specid
   SELECT COUNT(*) INTO li_cnt
     FROM gzdf_t
    WHERE gzdf002 = lc_gzdf002
   IF li_cnt > 0 THEN
      LET ls_spectype = "F"
      RETURN ls_spectype
   END IF
  #End: 160706-00001 modify


   LET lc_gzde001 = ls_specid

   #確認傳入是否為子程式,或應用元件
   SELECT COUNT(*) INTO li_cnt
     FROM gzde_t
    WHERE gzde001 = lc_gzde001
   CASE
      WHEN li_cnt = 1
         #子程式/應用元件/LIB
         SELECT gzde003 INTO lc_gzde003 FROM gzde_t
          WHERE gzde001 = lc_gzde001
         RETURN lc_gzde003

      WHEN li_cnt > 1
         CASE
            WHEN ls_specid.subString(1,2) = "s_"
               LET ls_spectype = "S"
            WHEN ls_specid.subString(1,3) = "cl_"
               LET ls_spectype = "L"
            OTHERWISE
               LET ls_spectype = "B"  #應用元件
         END CASE
   END CASE

   #確認傳入是否為web service
  #IF ls_specid.subString(1,3) = "wss" THEN
   IF ls_specid.subString(1,3) = "wss" OR ls_specid.subString(1,4) = "cwss" THEN #20150818
      LET lc_gzde001 = ls_specid
      SELECT gzja001 INTO lc_gzde003 FROM gzja_t
       WHERE gzja001 = lc_gzde001
      IF NOT SQLCA.SQLCODE THEN
        #LET ls_spectype = "W"
         LET ls_spectype = "Z"  #此處與cl_chk_spec_type不同!!!!!
         RETURN ls_spectype
      END IF
   END IF

   #20150529 -Begin-
   #確認傳入是否為開窗
   IF ls_specid MATCHES "q_*" OR ls_specid MATCHES "cq_*"  THEN
      LET li_cnt =0
      LET lc_dzca001 = ls_specid
      SELECT COUNT(1) INTO li_cnt FROM dzca_t 
         WHERE dzca001=lc_dzca001
      IF li_cnt >0 THEN 
         LET ls_spectype = "Q"
         RETURN ls_spectype
      END IF
   END IF
   #20150529 -End-

   #最後查看是否為主程式
   SELECT COUNT(*) INTO li_cnt
     FROM gzza_t
    WHERE gzza001 = lc_gzde001
   IF li_cnt > 0 THEN
      LET ls_spectype = "M"   #主程式
   ELSE
      LET ls_spectype = "N"
   END IF
   RETURN ls_spectype

END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 依據簽出/取消簽出處理dzay_t
# Input parameter : p_prog 程式代號
#                 : p_identity 客製標示
#                 : p_action 執行時機(1:簽出;2:取消簽出)
# Return code     : void
# Date & Author   : 2014/12/03 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_dzay_t(p_prog, p_identity, p_action)
   DEFINE p_prog     LIKE dzax_t.dzax001,
          p_identity LIKE dzax_t.dzax006,
          p_action   STRING 
   DEFINE ls_trigger STRING,
          li_cnt     SMALLINT,
          lr_dzay    RECORD LIKE dzay_t.*
   DEFINE li_dzax_cnt SMALLINT #2015/11/09 by Hiko

   TRY
      DISPLAY "call sadzp060_2_dzay_t() start:",p_prog,",",p_identity,",action=",p_action

      SELECT COUNT(*) INTO li_cnt FROM dzay_t WHERE dzay001=p_prog
      CASE p_action
         WHEN "1" #簽出:將dzax_t的資料複製到dzay_t
            IF li_cnt>0 THEN
               #先刪除dzay_t.
               LET ls_trigger = "DELETE dzay_t:",p_prog
               DISPLAY ls_trigger
               DELETE FROM dzay_t WHERE dzay001=p_prog
            END IF

            #再複製.
            LET ls_trigger = "INSERT dzay_t:",p_prog
            DISPLAY ls_trigger
            SELECT COUNT(*) INTO li_dzax_cnt FROM dzax_t
             WHERE dzax001=p_prog AND dzax006=p_identity #2015/11/09 by Hiko
            IF li_dzax_cnt>0 THEN
               INSERT INTO dzay_t(dzay001,dzay002,dzay003,dzay004,dzay005)
                           SELECT dzax001,dzax002,dzax003,dzax007,'Y' FROM dzax_t #2015/11/09 by Hiko:dzay005預設為'Y'
                            WHERE dzax001=p_prog AND dzax006=p_identity
            ELSE #找不到dzax_t就自己新增.
               CALL sadzp060_2_set_regen(p_prog, "Y") #2015/11/09 by Hiko
            END IF
         WHEN "2" #取消簽出:將dzay_t的資料複製到dzax_t
            IF li_cnt>0 THEN
               SELECT * INTO lr_dzay.* FROM dzay_t WHERE dzay001=p_prog
               LET ls_trigger = "UPDATE dzax_t:",p_prog
               DISPLAY ls_trigger
               UPDATE dzax_t SET dzax002=lr_dzay.dzay002,dzax003=lr_dzay.dzay003,dzax007=lr_dzay.dzay004
                WHERE dzax001=p_prog AND dzax006=p_identity
            END IF
      END CASE

      DISPLAY "call sadzp060_2_dzay_t() finish!"
   CATCH
      CALL sadzp060_2_err_catch(ls_trigger, NULL)
      #就算失敗也不影響簽出/取消簽出流程
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 設定程式是否需要重產
# Input parameter : p_table 表格代號
# Return code     : void
# Date & Author   : 2015/11/09 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_need_regen(p_table)
   DEFINE p_table LIKE dzea_t.dzea001
   DEFINE ls_sql  STRING,
          li_idx  SMALLINT,
          la_prog DYNAMIC ARRAY OF RECORD
                  progid LIKE dzag_t.dzag001
                  END RECORD,
          ls_prog STRING

   DISPLAY "sadzp060_2_need_regen:",p_table CLIPPED
   LET ls_sql = "SELECT distinct(dzag001) FROM dzag_t WHERE dzag002='",p_table CLIPPED,"' ORDER BY dzag001"
   PREPARE dzag_prep FROM ls_sql
   DECLARE dzag_curs CURSOR FOR dzag_prep
   LET li_idx = 1
   FOREACH dzag_curs INTO la_prog[li_idx].*
      CALL sadzp060_2_set_regen(la_prog[li_idx].progid, 'Y')
      IF li_idx=1 THEN
         LET ls_prog = la_prog[li_idx].progid
      ELSE
         LET ls_prog = ls_prog,", ",la_prog[li_idx].progid #2015/12/01 by Hiko:逗號後面加上一個空白
      END IF
      
      LET li_idx = li_idx + 1
   END FOREACH

   IF ls_prog.getLength()>0 THEN
      DISPLAY "NEEDREGEN:",ls_prog
   END IF
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 設定程式是否需要重產
# Input parameter : p_prog 程式代號
#                 : p_regen 程式是否需要重產(Y:要重產;N:不重產)
# Return code     : void
# Date & Author   : 2015/11/09 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_set_regen(p_prog, p_regen)
   DEFINE p_prog  LIKE dzay_t.dzay001,
          p_regen LIKE dzay_t.dzay005
   DEFINE ls_trigger STRING,
          li_cnt     SMALLINT

   #需要重產時機:
   #1.規格上傳(M/S/Q) : 有tab
   #2.r.t : 表格PK/FK改變
   #3.adzi150 : 狀態碼改變
   
   #當程式(M/S/Q)有權限下載後, 要將重產時機的標示變成N.

   TRY
      DISPLAY "sadzp060_2_set_regen:",p_prog," ",p_regen
      SELECT COUNT(*) INTO li_cnt FROM dzay_t WHERE dzay001=p_prog
      IF li_cnt>0 THEN #有可能未簽出過, dzay_t會沒有資料, 所以要先防呆.
         UPDATE dzay_t SET dzay005=p_regen
          WHERE dzay001=p_prog
      ELSE
         INSERT INTO dzay_t(dzay001,dzay002,dzay003,dzay004,dzay005)
                     VALUES(p_prog,'F','N',1,p_regen) #只有dzay005才重要, 其他都是預設值. 重新簽出規格後, 這些資料都會是正確的.
      END IF
   CATCH
      CALL sadzp060_2_err_catch(ls_trigger, NULL)
      #就算失敗也不影響流程
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 判斷程式是否需要重產
# Input parameter : p_prog 程式代號
# Return code     : BOOLEAN Y:重產/N:不重產
# Date & Author   : 2015/11/09 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_2_is_regen(p_prog)
   DEFINE p_prog  LIKE dzay_t.dzay001
   DEFINE ls_trigger STRING,
          l_dzay005  LIKE dzay_t.dzay005,
          lb_return  BOOLEAN

   TRY
      LET ls_trigger = "sadzp060_2_is_regen prog=",p_prog
      DISPLAY ls_trigger
      LET lb_return = FALSE
      SELECT dzay005 INTO l_dzay005 FROM dzay_t WHERE dzay001=p_prog
      IF NOT cl_null(l_dzay005) THEN
         IF l_dzay005="Y" THEN
            LET lb_return = TRUE
         END IF
      END IF

      LET ls_trigger = "sadzp060_2_is_regen return=",lb_return
      DISPLAY ls_trigger
      RETURN lb_return
   CATCH
      CALL sadzp060_2_err_catch(ls_trigger, NULL)
      #就算失敗也不影響流程
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 判斷程式/規格是否處於 P65T 階段
# Input parameter : p_dzlm 簽出資訊
# Return code     : BOOLEAN Y:是/N:否
# Date & Author   : 2016/09/23 by Ernest
##########################################################################
PUBLIC FUNCTION sadzp060_2_check_if_stage_P65T(p_dzlm_t)
DEFINE
  p_dzlm_t T_DZLM_T 
DEFINE
  lo_dzlm_t    T_DZLM_T,
  ls_sql       STRING,
  li_rec_count INTEGER
DEFINE
  lb_return BOOLEAN  
  
  LET lo_dzlm_t.* = p_dzlm_t.*
  
  TRY 
    #取得資料筆數
    LET ls_sql = "SELECT COUNT(1)                          ",
                 "  FROM DZLA_T                            ",
                 " WHERE DZLA001 = 'P65T'                  ",
                 "   AND DZLA003 = '",lo_dzlm_t.DZLM002,"' ", -- dzlm002 
                 "   AND DZLA007 = '",lo_dzlm_t.DZLM012,"' ", -- dzlm012
                 "   AND DZLA010 =  ",lo_dzlm_t.DZLM015,"  "  -- dzlm015

    PREPARE lpre_check_if_stage_P65T FROM ls_sql
    DECLARE lcur_check_if_stage_P65T CURSOR FOR lpre_check_if_stage_P65T
    OPEN lcur_check_if_stage_P65T
    FETCH lcur_check_if_stage_P65T INTO li_rec_count
    CLOSE lcur_check_if_stage_P65T
    FREE lcur_check_if_stage_P65T
    FREE lpre_check_if_stage_P65T
  CATCH 
    LET li_rec_count = 0
  END TRY   

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
     
END FUNCTION
