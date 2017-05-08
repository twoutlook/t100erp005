#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/27
#
#+ 程式代碼......: adzp640
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp640.4gl
# Description    : 整批進行行業同步
# Modify         : 2015/08/19 by Hiko : 修改引用過程的版次問題.
# Modify         : 2015/09/09 by Hiko : 串聯預覽行業同步清單
# Modify         : 20160226 160226-00009 by Hiko : 1.將刪除後新增dzye_t改成更新dzye_t.
#                                                  2.顯現資料以dzaq_t為主.
#                                                  3.開啟程式前先檢查是否存在還沒同步的行業清單.
#                : 20160321 160226-00010 by Hiko : 1.未同步前可以預覽標準差異.
#                                                  2.調整行業的執行判斷.                                
#                : 20160726 160726-00007 by Hiko : 移除btn_view #預覽同步的內容
#                : 20160811 160811-00028 by Hiko : 1.解決已遷出程式也出現在未遷出清單內的問題.
#                                                  2.只能單選同步.
#                                                  3.只要勾選程式就可以預覽標準差異.
#                                                  4.補上[只顯現還未同步過的行業程式]的操作.
#                : 20161003 160929-00037 by Hiko : 調整呼叫sadzp060_4的判斷.

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc" 
&include "../4gl/sadzp200_type.inc" 
&include "../4gl/adzq991_module.inc"

PRIVATE TYPE TYPE_SYNC RECORD
                       sel LIKE type_t.chr1,
                       dzlm008 LIKE dzlm_t.dzlm008,    #規格簽出:O/I
                       dzlm007 LIKE dzlm_t.dzlm007,    #規格簽出者
                       dzlm011 LIKE dzlm_t.dzlm011,    #程式簽出:O/I
                       dzlm010 LIKE dzlm_t.dzlm010,    #程式簽出者
                       dzaq011 LIKE dzaq_t.dzaq011,    #行業代號
                       dzaq013 LIKE dzaq_t.dzaq013,    #模組 #160226-00009 by Hiko
                       dzaq001 LIKE dzaq_t.dzaq001,    #行業程式代號
                       gzzal003 LIKE gzzal_t.gzzal003, #程式名稱
                       #Begin:160226-00009 by Hiko
                       #dzaf002 LIKE dzaf_t.dzaf002,    #建構版次
                       #dzaf003 LIKE dzaf_t.dzaf003,    #規格版次
                       #dzaf004 LIKE dzaf_t.dzaf004,    #程式版次
                       #dzaf005 LIKE dzaf_t.dzaf005,    #建構類型
                       #dzaf006 LIKE dzaf_t.dzaf006,    #模組
                       #dzaf007 LIKE dzaf_t.dzaf007,    #產品代號
                       #dzaf008 LIKE dzaf_t.dzaf008,    #產品版本
                       #dzaf009 LIKE dzaf_t.dzaf009,    #客戶代號
                       #dzaf010 LIKE dzaf_t.dzaf010,    #客製標示
                       #dzaq007 LIKE dzaq_t.dzaq007,    #標準建構版次
                       #dzaq008 LIKE dzaq_t.dzaq008,    #標準規格版次
                       #dzaq003 LIKE dzaq_t.dzaq003,    #對應行業Patch時的匯入包編號
                       #dzaq009 LIKE dzaq_t.dzaq009,    #標準程式版次
                       dzaq004 LIKE dzaq_t.dzaq004,    #行業建構版次
                       dzaq005 LIKE dzaq_t.dzaq005,    #行業規格版次
                       dzaq006 LIKE dzaq_t.dzaq006,    #行業程式版次
                       dzaq012 LIKE dzaq_t.dzaq012,    #標準程式代號
                       dzaq007 LIKE dzaq_t.dzaq007,    #標準建構版次
                       dzaq008 LIKE dzaq_t.dzaq008,    #標準規格版次
                       dzaq009 LIKE dzaq_t.dzaq009,    #標準程式版次
                       dzaq010 LIKE dzaq_t.dzaq010,    #同步否
                       dzaq003 LIKE dzaq_t.dzaq003     #對應行業Patch時的匯入包編號
                       #End:160226-00009 by Hiko
                       END RECORD
DEFINE ga_sync DYNAMIC ARRAY OF TYPE_SYNC
DEFINE g_date  DATETIME YEAR TO SECOND
DEFINE gb_trans_flag BOOLEAN
DEFINE g_topind  LIKE dzaq_t.dzaq011 #160226-00009

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE ls_sql    STRING,
          li_cnt    SMALLINT,
          la_gzoi   DYNAMIC ARRAY OF RECORD
                    gzoi001 LIKE gzoi_t.gzoi001,
                    gzoi002 LIKE gzoi_t.gzoi002
                    END RECORD,
          li_i      SMALLINT,
          ls_values STRING,
          ls_items  STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    

   CALL cl_tool_init()

   IF g_account="topstd" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00602" #topstd 帳號無法使用此功能，請改用其他帳號
      LET g_errparam.popup = TRUE
      CALL cl_err()
      EXIT PROGRAM 
   END IF

   IF FGL_GETENV("DGENV")="c" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00512" #行業別同步工具限定標準環境使用
      LET g_errparam.popup = TRUE
      CALL cl_err()
      EXIT PROGRAM 
   END IF

   #Begin:160226-00009:檢查當下行業是否存在未同步的行業清單.
   LET g_topind = FGL_GETENV("TOPIND") CLIPPED
   IF NOT cl_null(g_topind) AND g_topind<>"sd" THEN
      LET ls_sql = "SELECT COUNT(*) FROM dzaq_t",
                   " WHERE dzaq011=? AND dzaq010='N'"
      PREPARE dzaq_prep1 FROM ls_sql
      EXECUTE dzaq_prep1 USING g_topind INTO li_cnt
      FREE dzaq_prep1
      IF li_cnt=0 THEN
         DISPLAY "$TOPIND=",g_topind," 行業下沒有未同步的行業程式, 所以不需要開啟此程式"
         EXIT PROGRAM
      END IF
   ELSE
      DISPLAY "$TOPIND=",g_topind," 不需要開啟此程式"
      #Begin:160226-00010
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00809" #非行業區域不需要執行此程式
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #End:160226-00010
      EXIT PROGRAM
   END IF
   #End:160226-00009
    
   OPEN WINDOW w_adzp640 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   #動態產生行業清單.
   LET ls_sql = "SELECT gzoi001,gzoi002 FROM gzoi_t WHERE gzoi001<>'sd' AND gzoistus='Y' ORDER BY gzoi001"
   PREPARE gzoi_prep FROM ls_sql
   DECLARE gzoi_curs CURSOR FOR gzoi_prep
   LET li_i = 1
   FOREACH gzoi_curs INTO la_gzoi[li_i].*
      IF NOT cl_null(ls_values) THEN
         LET ls_values = ls_values,","
      END IF
      LET ls_values = ls_values,la_gzoi[li_i].gzoi001

      IF NOT cl_null(ls_items) THEN
         LET ls_items = ls_items,","
      END IF
      LET ls_items = ls_items,la_gzoi[li_i].gzoi002

      LET li_i = li_i + 1
   END FOREACH

   CALL cl_set_combo_items("cbo_industry", ls_values, ls_items)

   CALL adzp640_ui_dialog() 

   CLOSE WINDOW w_adzp640 
END MAIN

PRIVATE FUNCTION adzp640_ui_dialog()
   DEFINE lb_result     BOOLEAN,
          li_ac         SMALLINT,
          ls_industry   STRING,
          l_not_sync    LIKE type_t.chr1, #160811-00028
          l_self_chkout LIKE type_t.chr1,
          l_select      LIKE type_t.chr1,
          li_i          SMALLINT 
   #Begin:2015/09/09 by Hiko
   DEFINE li_curr_row   SMALLINT,
          ls_run_cmd    STRING,
          lb_run_result BOOLEAN,
          ls_run_msg    STRING
   #End:2015/09/09 by Hiko
   #Begin:160226-00009 by Hiko
   DEFINE la_param  RECORD
                    prog  STRING,
                    param DYNAMIC ARRAY OF STRING
                    END RECORD,
          ls_js     STRING
   DEFINE ls_left_4gl_path STRING,
          obj_left_prog    util.JSONArray, #外部參數只能用JSON來包裝陣列傳遞
          la_prog_lst      T_DIFF_PROG_LIST #160726-00007
                           #Begin:160226-00010
                           #DYNAMIC ARRAY OF RECORD
                           #left_prog  LIKE dzaf_t.dzaf001,
                           #right_prog LIKE dzaf_t.dzaf001,
                           #prog_name  LIKE gzzal_t.gzzal003,
                           #cons_type  LIKE dzaf_t.dzaf005
                           #END RECORD
                           #End:160226-00010
   #End:160226-00009 by Hiko
          
   LET ls_industry = ""
   LET l_not_sync = 'N' #160811-00028
   LET l_self_chkout = 'Y' #預設值
   LET l_select = 'N' #預設值

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ls_industry,l_not_sync,l_self_chkout,l_select FROM cbo_industry,chk_not_sync,chk_self_chkout,chk_all ATTRIBUTE(WITHOUT DEFAULTS) #160811-00028:增加chk_not_sync
            #Begin:160811-00028:改成唯讀
            #ON CHANGE cbo_industry
            #   #DISPLAY "cbo_industry=",ls_industry,"<<"
            #   LET l_select = 'N' #清空多選
            #   EXIT DIALOG
            #End:160811-00028

            #Begin:160811-00028
            ON CHANGE chk_not_sync
               CALL adzp640_show_prog_info(ls_industry, l_not_sync, l_self_chkout)

            #Begin:160811-00028

            ON CHANGE chk_self_chkout
               LET l_select = 'N' #清空多選
               EXIT DIALOG

            #Begin:160811-00028:改成隱藏
            #ON CHANGE chk_all
            #   FOR li_i=1 TO ga_sync.getLength()
            #      IF ((cl_null(ga_sync[li_i].dzlm008) OR ga_sync[li_i].dzlm008='I') AND
            #          (cl_null(ga_sync[li_i].dzlm011) OR ga_sync[li_i].dzlm011='I')) THEN
            #         LET ga_sync[li_i].sel = l_select
            #      END IF
            #   END FOR
            #End:160811-00028

         END INPUT

         INPUT ARRAY ga_sync FROM s_detail1.* ATTRIBUTE(APPEND ROW=FALSE)
           #ON ACTION btn_alm #因為主SQL已經撈出ALM簽出資料,所以就不需要有查看ALM的功能了.
           #   CALL adzp640_show_alm(ARR_CURR())

            #Begin:2015/09/09 by Hiko
            BEFORE ROW
               LET li_curr_row = ARR_CURR()
               #Begin:160226-00009 by Hiko
               #IF (NOT cl_null(ga_sync[li_curr_row].dzaq001) AND
               #    (cl_null(ga_sync[li_curr_row].dzlm008) OR ga_sync[li_curr_row].dzlm008='I') AND
               #    (cl_null(ga_sync[li_curr_row].dzlm011) OR ga_sync[li_curr_row].dzlm011='I')) THEN
               #IF NOT cl_null(ga_sync[li_curr_row].dzaq001) THEN

               #CALL cl_set_act_visible("btn_diff", FALSE) #160226-00010 #160811-00028
               #End:160226-00009 by Hiko
               #Begin:160726-00007
               #IF (ga_sync[li_curr_row].sel='Y') THEN
               #   CALL cl_set_act_visible("btn_view", TRUE) 
               #ELSE
               #   CALL cl_set_act_visible("btn_view", FALSE) 
               #END IF
               #End:160726-00007

               #Begin:160811-00028
               CALL cl_set_act_visible("btn_diff,btn_batch", FALSE)
               IF ga_sync[li_curr_row].sel='Y' THEN
                  CALL cl_set_act_visible("btn_diff", TRUE)
                  IF ((cl_null(ga_sync[li_curr_row].dzlm008) OR ga_sync[li_curr_row].dzlm008='I') AND
                      (cl_null(ga_sync[li_curr_row].dzlm011) OR ga_sync[li_curr_row].dzlm011='I')) THEN
                     CALL cl_set_act_visible("btn_batch", TRUE)
                  END IF
               END IF
               #Begin:160811-00028
               
            #End:2015/09/09 by Hiko
           
            #Begin:160226-00009 by Hiko
            ON CHANGE chk_sel
               #Begin:160811-00028
               #CALL cl_set_act_visible("btn_diff", FALSE) #160226-00010
               #IF (ga_sync[li_curr_row].sel='Y') THEN
               #   #CALL cl_set_act_visible("btn_view", TRUE) #160726-00007
               #   #Begin:160226-00010:此程式要沒有同步過才可以查看diff;adzp050是同步過才可以查看, 因為用途不同.
               #   IF ga_sync[li_curr_row].dzaq010='N' THEN
               #      CALL cl_set_act_visible("btn_diff", TRUE)
               #   END IF
               #   #End:160226-00010
               #ELSE
               #   #CALL cl_set_act_visible("btn_view", FALSE) #160726-00007
               #END IF

               CALL cl_set_act_visible("btn_diff,btn_batch", FALSE)
               IF ga_sync[li_curr_row].sel='Y' THEN
                  CALL cl_set_act_visible("btn_diff", TRUE)
                  IF ((cl_null(ga_sync[li_curr_row].dzlm008) OR ga_sync[li_curr_row].dzlm008='I') AND
                      (cl_null(ga_sync[li_curr_row].dzlm011) OR ga_sync[li_curr_row].dzlm011='I')) THEN
                     CALL cl_set_act_visible("btn_batch", TRUE)
                  END IF
               END IF

               FOR li_i=1 TO ga_sync.getLength()
                  IF li_i<>li_curr_row THEN
                     IF ga_sync[li_i].sel='Y' THEN
                        LET ga_sync[li_i].sel = 'N'
                     END IF
                  END IF
               END FOR
               #End:160811-00028
            #End:160226-00009 by Hiko

            #Begin:160726-00007
            #ON ACTION btn_view #預覽同步的內容.
            #   LET ls_run_cmd = "r.r adzq620 ",ga_sync[li_curr_row].dzaq001 CLIPPED
            #   CALL cl_cmdrun_openpipe("r.r adzq620", ls_run_cmd, FALSE) RETURNING lb_run_result,ls_run_msg
            #End:160726-00007

            ON ACTION btn_diff #檢視標準與行業差異
               #Begin:160226-00010 by Hiko
               #LET ls_left_4gl_path = os.Path.join(FGL_GETENV(UPSHIFT(ga_sync[li_curr_row].dzaq013)), "4gl") #模組路徑
               #LET la_prog_lst[1].prog = ga_sync[li_curr_row].dzaq012
               IF ga_sync[li_curr_row].sel='Y' THEN #160811-00028
                  LET la_prog_lst[1].prog = ga_sync[li_curr_row].dzaq001 #160726-00007
                  LET la_prog_lst[1].prog_name = ga_sync[li_curr_row].gzzal003
                  LET la_prog_lst[1].cons_type = "M" #目前僅支援M類的引用,所以只有M類才需要同步.
                  LET la_prog_lst[1].auth = "N"
                  
                  LET obj_left_prog = util.JSONArray.create()
                  LET obj_left_prog = util.JSONArray.fromFGL(la_prog_lst)
                  
                  LET la_param.prog = "adzq991"
                  #LET la_param.param[1] = cs_only_query
                  LET la_param.param[1] = cs_after_ind_patch #160726-00007
                  LET la_param.param[2] = obj_left_prog.toString()
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
               #End:160226-00010 by Hiko

            #Begin:160811-00028:從下面搬上來.
            ON ACTION btn_batch
               IF ga_sync[li_curr_row].sel='Y' THEN
                  IF ((cl_null(ga_sync[li_curr_row].dzlm008) OR ga_sync[li_curr_row].dzlm008='I') AND
                      (cl_null(ga_sync[li_curr_row].dzlm011) OR ga_sync[li_curr_row].dzlm011='I')) THEN
                     IF adzp640_batch_sync() THEN
                        #同步後得要重新讀取資料, 以免重做.
                        LET l_select = 'N' #清空多選
                        EXIT DIALOG
                     END IF
                  END IF
               END IF
            #End:160811-00028
         END INPUT

         #Begin:160811-00028
         #ON ACTION btn_batch
         #   IF adzp640_batch_sync() THEN
         #      #同步後得要重新讀取資料, 以免重做.
         #      LET l_select = 'N' #清空多選
         #      EXIT DIALOG
         #   END IF
         #End:160811-00028

         ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG

         BEFORE DIALOG                
            #DISPLAY "BEFORE DIALOG : cbo_industry=",ls_industry,"<<"
            CLEAR FORM
            LET ls_industry = g_topind #160226-00009
            CALL adzp640_show_prog_info(ls_industry, l_not_sync, l_self_chkout)

      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

PRIVATE FUNCTION adzp640_show_prog_info(p_industry, p_not_sync, p_self_chkout)
   DEFINE p_industry    STRING,
          p_not_sync    LIKE type_t.chr1, #160811-00028
          p_self_chkout LIKE type_t.chr1 
   DEFINE ls_sql STRING,
          ls_ind_wc   STRING,
          ls_owner_wc STRING,
          li_i   SMALLINT

   TRY
      IF NOT cl_null(p_industry) THEN
         LET ls_ind_wc = " AND dzaq011='",p_industry CLIPPED,"'"
      END IF

      #Begin:160811-00028
      IF p_not_sync = 'Y' THEN
         LET ls_ind_wc = ls_ind_wc," AND (dzaq010='N' OR dzaq010 IS NULL)"
      END IF
      #End:160811-00028

      IF p_self_chkout = 'Y' THEN
         LET ls_owner_wc = " AND ((dzlm008 IS NULL OR dzlm008='I') AND (dzlm011 IS NULL OR dzlm011='I'))"
      END IF

      #Begin:160226-00009 by Hiko
      #LET ls_sql = "SELECT 'N',dzlm008,dzlm007,dzlm011,dzlm010,",
      #             "       aq1.dzaq011,aq1.dzaq001,gzzal003,af1.dzaf002,af1.dzaf003,",
      #             "       af1.dzaf004,af1.dzaf005,af1.dzaf006,af1.dzaf007,af1.dzaf008,",
      #             "       af1.dzaf009,af1.dzaf010,aq1.dzaq007,aq1.dzaq008,aq1.dzaq003,",
      #             "       aq1.dzaq009,aq1.dzaq010", #160226-00009 by Hiko:增加dzaq010
      #             "  FROM dzaq_t aq1  LEFT JOIN gzzal_t ON gzzal001=aq1.dzaq001 AND gzzal002='",g_lang,"'",
      #             "                  INNER JOIN dzaf_t af1 ON dzaf001=aq1.dzaq001 AND af1.dzaf005='M' AND af1.dzaf010='s' AND dzaf002=(SELECT MAX(af2.dzaf002) FROM dzaf_t af2",
      #             "                                                                                                                     WHERE af2.dzaf001=af1.dzaf001", 
      #             "                                                                                                                       AND af2.dzaf005=af1.dzaf005", 
      #             "                                                                                                                       AND af2.dzaf010=af1.dzaf010)", 
      #             "                   LEFT JOIN dzlm_t ON dzlm002=aq1.dzaq001 AND dzlm001=af1.dzaf005 AND dzlm005=af1.dzaf002",
      #             " WHERE aq1.dzaq010='N'",ls_ind_wc,
      #             "   AND aq1.dzaq007=(SELECT MAX(dzaq007) FROM dzaq_t aq2",
      #             "                     WHERE aq2.dzaq001=aq1.dzaq001)",ls_owner_wc,
      #             " WHERE ",ls_ind_wc,ls_owner_wc,
      #             " ORDER BY aq1.dzaq001"
      LET ls_sql = "SELECT 'N',dzlm008,dzlm007,dzlm011,dzlm010,",
                   "       dzaq011,dzaq013,dzaq001,gzzal003,dzaq004,dzaq005,dzaq006,",
                   "       dzaq012,dzaq007,dzaq008,dzaq009,dzaq010,dzaq003",
                   "  FROM dzaq_t LEFT JOIN gzzal_t ON gzzal001=dzaq001 AND gzzal002='",g_lang,"'",
                   #Begin:160811-00028
                   #"              LEFT JOIN dzlm_t ON dzlm002=dzaq001 AND dzlm001='M' AND dzlm005=dzaq004",
                   "              LEFT JOIN dzlm_t ON dzlm002=dzaq001 AND dzlm001='M'",
                   "                              AND dzlm005=(SELECT MAX(lm2.dzlm005) FROM dzlm_t lm2 ",
                   "                                            WHERE lm2.dzlm002=dzaq001 AND lm2.dzlm001='M')",
                   " WHERE 1=1",ls_ind_wc,ls_owner_wc,
                   #End:160811-00028
                   " ORDER BY dzaq012,dzaq001"
      #End:160226-00009 by Hiko
      #display "Hiko dzaq_t ls_sql=",ls_sql 
      PREPARE sync_prep1 FROM ls_sql
      DECLARE sync_curs1 CURSOR FOR sync_prep1

      CALL ga_sync.clear() #初始化

      LET li_i = 1
      FOREACH sync_curs1 INTO ga_sync[li_i].*
         LET li_i = li_i + 1
      END FOREACH

      CALL ga_sync.deleteElement(li_i)
   CATCH
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "!"
      LET g_errparam.extend = "Get dzaq_t failure!"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END TRY
END FUNCTION

{
PRIVATE FUNCTION adzp640_show_alm(p_ac)
   DEFINE p_ac SMALLINT
   DEFINE lo_prog_info  T_PROGRAM_INFO, 
          lo_owner_list DYNAMIC ARRAY OF T_CHECK_OUT_OWNER_LIST,
          ls_owner_list STRING,
          li_i          SMALLINT,
          ls_alm_info   STRING

   LET lo_prog_info.pi_TYPE   = ga_sync[p_ac].dzaf005
   LET lo_prog_info.pi_MODULE = ga_sync[p_ac].dzaf006
   LET lo_prog_info.pi_NAME   = ga_sync[p_ac].dzaq001
   LET lo_prog_info.pi_DESC   = ga_sync[p_ac].gzzal003
   CALL sadzp200_alm_get_owner_list(lo_prog_info.*) RETURNING lo_owner_list 
   LET ls_owner_list = " " 
   FOR li_i = 1 TO lo_owner_list.getLength()
     IF lo_owner_list[li_i].cool_ROLE IS NOT NULL THEN 
       LET ls_owner_list = ls_owner_list,'\n',
                           "Role : ",lo_owner_list[li_i].cool_ROLE,'\n', 
                           "ID : ",lo_owner_list[li_i].cool_ID,'\n',
                           "Name : ",lo_owner_list[li_i].cool_NAME,'\n',
                           "Request Number : ",lo_owner_list[li_i].cool_REQUEST_NO,'\n',
                           "Request Sequence : ",lo_owner_list[li_i].cool_SEQUENCE_NO,'\n'
     END IF                                                   
   END FOR
   
   LET ls_alm_info  = lo_prog_info.pi_NAME,"|",ls_owner_list,"|"
   CALL sadzp000_msg_show_info("adz-00389", "adz-00389", ls_alm_info, 1)
END FUNCTION
}

PRIVATE FUNCTION adzp640_batch_sync()
   DEFINE la_sync     DYNAMIC ARRAY OF TYPE_SYNC,
          li_i,li_j   SMALLINT,
          lo_old_dzaf T_DZAF_T,
          lo_new_dzaf T_DZAF_T,
          lb_result   BOOLEAN,
          ls_err_msg  LIKE dzye_t.dzye018,
          ls_ind_ver  LIKE dzye_t.dzye007, #行業同步後的最終版次
          ls_sql      STRING,
          lc_syn      LIKE type_t.chr1,
          ls_msg_code STRING,
          ls_info     STRING,
          li_cnt      SMALLINT, #160226-00009 by Hiko 
          ls_syn_prog STRING

   IF NOT cl_ask_confirm("adz-00603") THEN #請問是否要執行行業同步?
      RETURN FALSE
   END IF

   LET ls_syn_prog = NULL #160929-00037
   FOR li_i=1 TO ga_sync.getLength()
      IF ga_sync[li_i].sel='Y' THEN
         LET li_j = li_j + 1
         #Begin:160929-00037:目前是單筆執行, 所以只能勾選一筆程式.
         LET la_sync[li_j].* = ga_sync[li_i].*
         EXIT FOR
         #End:160929-00037
      END IF
   END FOR

   #Begin:160226-00009 by Hiko:提醒已經同步過的程式清單.
   IF la_sync.getLength()=0 THEN
      RETURN FALSE
   END IF

   LET ls_syn_prog = NULL
   FOR li_i=1 TO la_sync.getLength()
      IF la_sync[li_i].dzaq010='Y' THEN
         IF ls_syn_prog.getLength()>0 THEN
            LET ls_syn_prog = ls_syn_prog,",",la_sync[li_i].dzaq001
         ELSE
            LET ls_syn_prog = la_sync[li_i].dzaq001
         END IF
      END IF
   END FOR
 
   IF NOT cl_null(ls_syn_prog) THEN
      IF NOT cl_ask_confirm_parm("adz-00496", ls_syn_prog) THEN
         RETURN FALSE
      END IF
   END IF
   #End:160226-00009 by Hiko

   #LET g_bgjob = 'Y' #批次處理要抑制彈窗 #160929-00037:只有單筆, 所以就可以彈窗.

   #Begin:160929-00037
   #IF la_sync.getLength()>0 THEN
   #   CALL cl_progress_bar(la_sync.getLength()*2)
   #END IF
   #End:160929-00037

   LET g_date = cl_get_current()

   FOR li_i=1 TO la_sync.getLength()
      LET ls_info = "create design data : ",la_sync[li_i].dzaq001
      #CALL cl_progress_ing(ls_info) #160929-00037
      
      #Begin:160226-00009 by Hiko
      CALL sadzp060_2_get_curr_ver_info(la_sync[li_i].dzaq001, "M", la_sync[li_i].dzaq013) RETURNING lo_old_dzaf.*,ls_err_msg
      IF NOT cl_null(ls_err_msg) THEN
         CONTINUE FOR  
      END IF

      #LET lo_old_dzaf.dzaf001 = la_sync[li_i].dzaq001
      #LET lo_old_dzaf.dzaf002 = la_sync[li_i].dzaf002
      #LET lo_old_dzaf.dzaf003 = la_sync[li_i].dzaf003
      #LET lo_old_dzaf.dzaf004 = la_sync[li_i].dzaf004
      #LET lo_old_dzaf.dzaf005 = la_sync[li_i].dzaf005
      #LET lo_old_dzaf.dzaf006 = la_sync[li_i].dzaf006
      #LET lo_old_dzaf.dzaf007 = la_sync[li_i].dzaf007
      #LET lo_old_dzaf.dzaf008 = la_sync[li_i].dzaf008
      #LET lo_old_dzaf.dzaf009 = la_sync[li_i].dzaf009
      #LET lo_old_dzaf.dzaf010 = la_sync[li_i].dzaf010 #行業別的引用一定是在鼎新標準環境
      
      #LET lo_new_dzaf.dzaf001 = la_sync[li_i].dzaq001
      #LET lo_new_dzaf.dzaf002 = la_sync[li_i].dzaf002 + 1
      #LET lo_new_dzaf.dzaf003 = la_sync[li_i].dzaf003 + 1
      #LET lo_new_dzaf.dzaf004 = la_sync[li_i].dzaf004 + 1
      #LET lo_new_dzaf.dzaf005 = la_sync[li_i].dzaf005
      #LET lo_new_dzaf.dzaf006 = la_sync[li_i].dzaf006
      #LET lo_new_dzaf.dzaf007 = la_sync[li_i].dzaf007
      #LET lo_new_dzaf.dzaf008 = la_sync[li_i].dzaf008
      #LET lo_new_dzaf.dzaf009 = la_sync[li_i].dzaf009
      #LET lo_new_dzaf.dzaf010 = la_sync[li_i].dzaf010

      LET lo_new_dzaf.dzaf001 = lo_old_dzaf.dzaf001
      LET lo_new_dzaf.dzaf002 = lo_old_dzaf.dzaf002 + 1
      LET lo_new_dzaf.dzaf003 = lo_old_dzaf.dzaf003 + 1
      LET lo_new_dzaf.dzaf004 = lo_old_dzaf.dzaf004 + 1
      LET lo_new_dzaf.dzaf005 = lo_old_dzaf.dzaf005
      LET lo_new_dzaf.dzaf006 = lo_old_dzaf.dzaf006
      LET lo_new_dzaf.dzaf007 = lo_old_dzaf.dzaf007
      LET lo_new_dzaf.dzaf008 = lo_old_dzaf.dzaf008
      LET lo_new_dzaf.dzaf009 = lo_old_dzaf.dzaf009
      LET lo_new_dzaf.dzaf010 = lo_old_dzaf.dzaf010
      #End:160226-00009 by Hiko

      #Begin:2015/06/12 by Hiko:產生新版設計資料是由sadzp060_4_start_sync處理.
      #CALL adzp640_create_design_data(lo_old_dzaf.*, lo_new_dzaf.*) RETURNING lb_result,ls_err_msg
      #IF lb_result THEN
      #   LET ls_info = "sync : ",la_sync[li_i].dzaq001
      #   CALL cl_progress_ing(ls_info)
      #   
      #   CALL sadzp060_4_start_sync(lo_new_dzaf.*) RETURNING lb_result,ls_err_msg
      #ELSE 
      #   LET ls_info = "no sync : ",la_sync[li_i].dzaq001
      #   CALL cl_progress_ing(ls_info)
      #END IF

      LET ls_info = "sync : ",la_sync[li_i].dzaq001
      #CALL cl_progress_ing(ls_info) #160929-00037
      LET g_bgjob = 'Y' #160929-00037:批次處理要抑制彈窗
      CALL sadzp060_4_start_sync(lo_old_dzaf.*) RETURNING lb_result,ls_err_msg #2015/08/19 by Hiko:lo_new_dzaf改lo_old_dzaf
      LET g_bgjob = 'N' #160929-00037
      #End:2015/06/12 by Hiko

      #Begin:160929-00037
      IF NOT lb_result THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "!"
         LET g_errparam.extend = ls_err_msg
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      ELSE #End:160929-00037
         TRY
            #dzye001 匯入包編號
            #dzye002 程式代碼
            #dzye003 建構類型
            #dzye005 模組
            #dzye009 目的建構版次
            #dzye010 目的規格版次
            #dzye011 目的程式版次
            #dzye014 來源建構版次
            #dzye017 執行日期
            #dzye018 錯誤訊息(完整)
            #dzye020 來源規格版次
            #dzye021 來源程式版次
            #dzye023 patch狀態
            #dzye024 執行使用者
         
            #DELETE FROM dzye_t WHERE dzye001=la_sync[li_i].dzaq003 AND dzye002=la_sync[li_i].dzaq001 #160226-00009 by Hiko
         
            IF lb_result THEN
               LET lc_syn = '1'
               LET ls_ind_ver = "final industry ver : ",lo_new_dzaf.dzaf002,lo_new_dzaf.dzaf003,lo_new_dzaf.dzaf004
            ELSE
               LET lc_syn = '2'
               LET ls_ind_ver = ""
            END IF
         
            #Begin:160226-00009 by Hiko
            #LET ls_sql = "INSERT INTO dzye_t(dzye001,dzye002,dzye003,dzye005,dzye007,",
            #                                "dzye009,dzye010,dzye011,dzye014,dzye017,dzye018,",
            #                                "dzye020,dzye021,dzye023,dzye024)",
            #                        " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"
            #PREPARE dzye_prep FROM ls_sql
            #EXECUTE dzye_prep USING la_sync[li_i].dzaq003,la_sync[li_i].dzaq001,la_sync[li_i].dzaf005,la_sync[li_i].dzaf006,ls_ind_ver,
            #                        la_sync[li_i].dzaf002,la_sync[li_i].dzaf003,la_sync[li_i].dzaf004,la_sync[li_i].dzaq007,g_date,ls_err_msg,
            #                        la_sync[li_i].dzaq008,la_sync[li_i].dzaq009,lc_syn,g_user
         
            SELECT COUNT(*) INTO li_cnt FROM dzye_t WHERE dzye001=la_sync[li_i].dzaq003 AND dzye002=la_sync[li_i].dzaq001 #160226-00009 by Hiko
            IF li_cnt>0 THEN #正常情況下一定會有標準Patch到行業主機資料.
               LET ls_sql = "UPDATE dzye_t SET dzye009=?,dzye010=?,dzye011=?,",
                            "                  dzye017=?,dzye018=?,dzye023=?",
                            " WHERE dzye001=? AND dzye002=?"
               PREPARE dzye_prep FROM ls_sql
               EXECUTE dzye_prep USING lo_new_dzaf.dzaf002,lo_new_dzaf.dzaf003,lo_new_dzaf.dzaf004,
                                       g_date,ls_err_msg,lc_syn,
                                       la_sync[li_i].dzaq003,la_sync[li_i].dzaq001
               FREE dzye_prep
            END IF
            #End:160226-00009 by Hiko
         CATCH
            #DISPLAY "Insert into dzye_t error, but it's OK."
            DISPLAY "Update dzye_t error, but it's OK." #160226-00009 by Hiko
         END TRY
         
         IF NOT lb_result THEN
            IF cl_null(ls_msg_code) THEN #只做一次即可
               LET ls_msg_code = "adz-00604" #同步過程出現錯誤.請執行adzq999,查詢[Patch序號]: *sync來查看批次同步結果.
            END IF
         END IF
      END IF
   END FOR

   #LET g_bgjob = 'N' #處理結束還原 #160929-00037

   IF cl_null(ls_msg_code) THEN #表示批次執行成功
      #Begin:160929-00037
      IF NOT cl_null(ls_err_msg) THEN #呼叫sadzp060_4_start_sync回傳的錯誤訊息:這裡就是執行成功後的提示訊息.
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00906" #%1.(資訊圖示)
         LET g_errparam.replace[1] = ls_err_msg
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN TRUE
      ELSE #End:160929-00037
         LET ls_msg_code = "adz-00217" #執行成功 #沒有成功後的提示訊息, 就單純顯現執行成功即可.
      END IF
   END IF

   MENU "Batch sync result" ATTRIBUTE (STYLE="dialog", COMMENT=cl_getmsg(ls_msg_code, g_lang), IMAGE="information")
     ON ACTION ok
       EXIT MENU
   END MENU

   RETURN TRUE
END FUNCTION
{
PRIVATE FUNCTION adzp640_create_design_data(po_old_dzaf, po_new_dzaf)
   DEFINE po_old_dzaf T_DZAF_T,
          po_new_dzaf T_DZAF_T
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          li_cnt      SMALLINT,
          ls_err_msg  STRING 

   TRY
      BEGIN WORK
      LET gb_trans_flag = TRUE
   
      LET ls_sql = "INSERT INTO dzaf_t(dzaf001,dzaf002,dzaf003,dzaf004,dzaf005,",
                                      "dzaf006,dzaf007,dzaf008,dzaf009,dzaf010)",
                              " VALUES(?,?,?,?,?,?,?,?,?,?)"
      PREPARE dzaf_prep FROM ls_sql
      EXECUTE dzaf_prep USING po_new_dzaf.dzaf001,po_new_dzaf.dzaf002,po_new_dzaf.dzaf003,po_new_dzaf.dzaf004,po_new_dzaf.dzaf005,
                              po_new_dzaf.dzaf006,po_new_dzaf.dzaf007,po_new_dzaf.dzaf008,po_new_dzaf.dzaf009,po_new_dzaf.dzaf010 
      FREE dzaf_prep

      #底下程式是從sadzp060_2複製過來改.
      #判斷規格樹(dzaa_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzaa_t",
                   " WHERE dzaa001='",po_new_dzaf.dzaf001 CLIPPED,"' AND dzaa002=",po_new_dzaf.dzaf003," AND dzaa009='",po_new_dzaf.dzaf010,"'" #這裡不能加上dzaastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzaa_prep1 FROM ls_sql
      EXECUTE dzaa_prep1 INTO li_cnt
      FREE dzaa_prep1
      #資料存在先砍舊資料,以免有殘留資料而造成資料不齊全.
      IF li_cnt=0 THEN 
         #要以舊的版本當作基底建立規格樹.
         LET ls_trigger = "adzp640_create_spec_structure : insert new ver dzaa_t"
         DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzaa_t(dzaa001,dzaa002,dzaa003,dzaa004,dzaa005,",
                                         "dzaa006,dzaa007,dzaa008,dzaa009,dzaa010,",
                                         "dzaacrtdt,dzaacrtdp,dzaaowndp,dzaaownid,dzaastus,dzaacrtid)",
                                 " SELECT dzaa001,",po_new_dzaf.dzaf003,",dzaa003,dzaa004,dzaa005,",
                                         "dzaa006,dzaa007,dzaa008,'",po_new_dzaf.dzaf010,"',dzaa010,", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user CLIPPED,"',dzaastus,'",g_user CLIPPED,"'",
                                   " FROM dzaa_t",
                                  " WHERE dzaa001='",po_old_dzaf.dzaf001 CLIPPED,"'",
                                    " AND dzaa002= ",po_old_dzaf.dzaf003,
                                    " AND dzaa009='",po_old_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzaastus='Y'"
         PREPARE dzaa_prep FROM ls_sql
         EXECUTE dzaa_prep USING g_date
         FREE dzaa_prep
      END IF

      #判斷add point樹(dzba_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzba_t",
                   " WHERE dzba001='",po_new_dzaf.dzaf001 CLIPPED,"' AND dzba002=",po_new_dzaf.dzaf004," AND dzba010='",po_new_dzaf.dzaf010,"'" #這裡不能加上dzbastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzba_prep1 FROM ls_sql
      EXECUTE dzba_prep1 INTO li_cnt
      FREE dzba_prep1
      #資料存在先砍舊資料,以免有殘留資料而造成資料不齊全.
      IF li_cnt=0 THEN 
         #要以舊的版本當作基底建立程式樹.
         LET ls_trigger = "adzp640_create_code_structure : insert new ver dzba_t"
         DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzba_t(dzba001,dzba002,dzba003,dzba004,dzba005,",
                                         "dzba006,dzba007,dzba008,dzba009,dzba010,dzba011,",
                                         "dzbacrtdt,dzbacrtdp,dzbaowndp,dzbaownid,dzbastus,dzbacrtid)",
                                 " SELECT dzba001,",po_new_dzaf.dzaf004,",dzba003,dzba004,dzba005,",
                                         "dzba006,dzba007,dzba008,dzba009,'",po_new_dzaf.dzaf010,"',dzba011,", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user CLIPPED,"',dzbastus,'",g_user CLIPPED,"'",
                                   " FROM dzba_t",
                                  " WHERE dzba001='",po_old_dzaf.dzaf001 CLIPPED,"'",
                                    " AND dzba002= ",po_old_dzaf.dzaf004,
                                    " AND dzba010='",po_old_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzbastus='Y'"
         PREPARE dzba_prep FROM ls_sql
         EXECUTE dzba_prep USING g_date
         FREE dzba_prep
      END IF

      #判斷section樹(dzbc_t)是否存在目前正要下載的版本 : 沒有就要建立.
      LET ls_sql = "SELECT count(*)",
                    " FROM dzbc_t",
                   " WHERE dzbc001='",po_new_dzaf.dzaf001 CLIPPED,"' AND dzbc002=",po_new_dzaf.dzaf004," AND dzbc007='",po_new_dzaf.dzaf010,"'" #這裡不能加上dzbcstus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
      PREPARE dzbc_prep1 FROM ls_sql
      EXECUTE dzbc_prep1 INTO li_cnt
      FREE dzbc_prep1
      IF li_cnt=0 THEN #資料不存在.
         #要以舊的版本當作基底建立規格樹.
         LET ls_trigger = "sadzp060_2_create_code_structure : insert new ver dzbc_t"
         DISPLAY ls_trigger
         LET ls_sql = "INSERT INTO dzbc_t(dzbc001,dzbc002,dzbc003,dzbc004,dzbc005,",
                                         "dzbc006,dzbc007,dzbc008,dzbc009,dzbc010,dzbc011,",
                                         "dzbccrtdt,dzbccrtdp,dzbcowndp,dzbcownid,dzbcstus,dzbccrtid)",
                                 " SELECT dzbc001,",po_new_dzaf.dzaf004,",dzbc003,dzbc004,dzbc005,",
                                         "dzbc006,'",po_new_dzaf.dzaf010,"',dzbc008,'',dzbc010,dzbc011,", 
                                         "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user CLIPPED,"',dzbcstus,'",g_user CLIPPED,"'",
                                   " FROM dzbc_t",
                                  " WHERE dzbc001='",po_old_dzaf.dzaf001 CLIPPED,"'",
                                    " AND dzbc002= ",po_old_dzaf.dzaf004,
                                    " AND dzbc007='",po_old_dzaf.dzaf010 CLIPPED,"'",
                                    " AND dzbcstus='Y'"

         PREPARE dzbc_prep FROM ls_sql
         EXECUTE dzbc_prep USING g_date
         FREE dzbc_prep
      END IF 

      COMMIT WORK
      LET gb_trans_flag = FALSE
      
      RETURN TRUE,NULL
   CATCH
      GOTO _RTN_ERR
   END TRY

   LABEL _RTN_ERR:
      IF gb_trans_flag THEN
         ROLLBACK WORK
      END IF
      
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
      LET ls_err_msg = "adzp640_create_data failure:",ls_sql
      RETURN FALSE,ls_err_msg
END FUNCTION
}
