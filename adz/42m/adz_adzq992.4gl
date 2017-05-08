#+ 程式版本......: 
#
#+ 程式代碼......: adzq992
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzq992.4gl
# Description    : 預覽Patch或過單的程式差異
# Modify         : 20160310 160226-00010 by Hiko : 新建程式

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/adzq991_module.inc"

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    

   CALL cl_tool_init()

   OPEN WINDOW w_adzq992 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzq992_ui_input()

   CLOSE WINDOW w_adzq992 
END MAIN

PRIVATE FUNCTION adzq992_ui_input()
   DEFINE l_prog            LIKE dzaf_t.dzaf001, #程式代號
          ls_diff_kind      STRING,              #比較類型:4gl/4fd
          lc_file1_location CHAR(1),             #第一個檔案來源:c.client/s.server
          ls_file1          STRING,              #第一個檔案(含路徑與檔名)
          ls_temp_file1     STRING,
          lc_file2_location CHAR(1),             #第二個檔案來源:c.client/s.server
          ls_file2          STRING,              #第二個檔案(含路徑與檔名)
          ls_temp_file2     STRING,
          ls_server_file1   STRING,
          ls_server_file2   STRING,
          obj_json          util.JSONObject,
          lr_file_info      T_FILE_INFO,
          lr_param          RECORD
                            prog STRING,
                            param DYNAMIC ARRAY OF STRING
                            END RECORD,
          ls_js             STRING,
          lb_continue       BOOLEAN 

      INPUT ls_diff_kind, #FILE:隱藏btd_prog
            lc_file1_location,ls_file1, 
            lc_file2_location,ls_file2 
       FROM rgb_diff_kind, #FILE:btd_prog
            rgb_file1_location,btd_file1,  
            rgb_file2_location,btd_file2  
      ATTRIBUTES(UNBUFFERED)
 
        #Begin:FILE
        ##程式代號
        #ON ACTION controlp INFIELD btd_prog
        #   INITIALIZE g_qryparam.* TO NULL
        #   LET g_qryparam.state = 'i' #開窗單選單回傳
        #   CALL q_adzp990()
        #   LET l_prog = g_qryparam.return1
        #   DISPLAY l_prog TO btd_prog
        #   DISPLAY g_qryparam.return2 TO lbl_prog_name
        #   NEXT FIELD btd_prog
      
        #AFTER FIELD btd_prog
        #   IF NOT cl_null (l_prog) THEN
        #      INITIALIZE g_chkparam.* TO NULL
        #      LET g_chkparam.arg1 = l_prog
        #      IF NOT cl_chk_exist("v_dzaf001") THEN
        #         NEXT FIELD btd_prog
        #      ELSE
        #         NEXT FIELD rgb_diff_kind
        #      END IF
        #   END IF
        #End:FILE

         #比對類型
         ON CHANGE rgb_diff_kind
            LET ls_file1 = NULL
            LET ls_file2 = NULL

         #第一個檔案來源
         ON CHANGE rgb_file1_location
            LET ls_file1 = NULL

         #第一個檔案(含路徑與檔名)
         ON ACTION controlp INFIELD btd_file1
            LET ls_temp_file1 = ls_file1
            CALL adzq992_get_file_path(lc_file1_location, ls_file1, ls_diff_kind) RETURNING ls_file1
            IF cl_null(ls_file1) THEN
               LET ls_file1 = ls_temp_file1
            END IF
            DISPLAY ls_file1 TO btd_file1
            LET lr_file_info.left_orig = ls_file1

         #第二個檔案來源
         ON CHANGE rgb_file2_location
            LET ls_file2 = NULL

         #第二個檔案(含路徑與檔名)
         ON ACTION controlp INFIELD btd_file2
            LET ls_temp_file2 = ls_file2
            CALL adzq992_get_file_path(lc_file2_location, ls_file2, ls_diff_kind) RETURNING ls_file2
            IF cl_null(ls_file2) THEN
               LET ls_file2 = ls_temp_file2
            END IF
            DISPLAY ls_file2 TO btd_file2
            LET lr_file_info.right_orig = ls_file2


         #程式比較
         ON ACTION btn_diff
            #檔案路徑完全相同要提示錯誤.
            IF NOT cl_null(ls_file1) AND NOT cl_null(ls_file2) THEN
               IF ls_file1.equals(ls_file2) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00801" #檔案路徑與名稱完全相同, 不需要做比較.
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  LET ls_temp_file1 = ls_file1
                  LET ls_temp_file2 = ls_file2
                  LET lb_continue = TRUE
                  #Client端的程式要先上傳到TEMPDIR.
                  IF lc_file1_location='c' THEN
                     LET ls_server_file1 = os.Path.basename(ls_file1)
                     LET ls_server_file1 = os.Path.JOIN(FGL_GETENV("TEMPDIR"), ls_server_file1)
                     #上傳檔案至Server端
                     IF NOT cl_client_upload_file(ls_file1, ls_server_file1) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "adz-00332"
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET lb_continue = FALSE
                     END IF
                  
                     LET ls_file1 = ls_server_file1 #將Client檔案變成TEMPDIR路徑下的檔案.
                  END IF

                  IF lb_continue THEN
                     IF lc_file2_location='c' THEN
                        LET ls_server_file2 = os.Path.basename(ls_file2)
                        LET ls_server_file2 = os.Path.JOIN(FGL_GETENV("TEMPDIR"), ls_server_file2)
                        #上傳檔案至Server端
                        IF NOT cl_client_upload_file(ls_file2, ls_server_file2) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code =  "adz-00332"
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET lb_continue = FALSE
                        END IF
                        
                        LET ls_file2 = ls_server_file2 #將Client檔案變成TEMPDIR路徑下的檔案.
                     END IF
                  END IF
                 
                  DISPLAY "ls_file1=",ls_file1
                  DISPLAY "ls_file2=",ls_file2
                  IF lb_continue THEN
                     #呼叫adzq991
                     #LET lr_file_info.right_prog = l_prog #FILE
                     #LET lr_file_info.cons_type = sadzp060_2_chk_spec_type(l_prog) #FILE
                     IF ls_diff_kind="4gl" THEN
                        LET lr_file_info.left_4gl = ls_file1
                        LET lr_file_info.right_4gl = ls_file2
                        LET lr_file_info.left_4fd = NULL
                        LET lr_file_info.right_4fd = NULL
                     ELSE
                        LET lr_file_info.left_4gl = NULL
                        LET lr_file_info.right_4gl = NULL
                        LET lr_file_info.left_4fd = ls_file1
                        LET lr_file_info.right_4fd = ls_file2
                     END IF
                     
                     LET obj_json = util.JSONObject.fromFGL(lr_file_info)
                     
                     LET lr_param.prog = "adzq991" 
                     LET lr_param.param[1] = cs_file_diff
                     LET lr_param.param[2] = obj_json.toString()
                     LET ls_js = util.JSON.stringify(lr_param)
                     CALL cl_cmdrun(ls_js)

                     #將畫面上的Client端路徑還原.
                     LET ls_file1 = ls_temp_file1
                     LET ls_file2 = ls_temp_file2
                  END IF
               END IF 
            END IF  

         ON ACTION CLOSE
            EXIT INPUT
      
      END INPUT   

   IF INT_FLAG = FALSE THEN
      LET INT_FLAG = FALSE
   END IF
END FUNCTION

PRIVATE FUNCTION adzq992_get_file_path(p_file_location, p_file_path, p_diff_kind)
   DEFINE p_file_location CHAR(1),
          p_file_path     STRING,
          p_diff_kind     STRING
   DEFINE ls_default_dir  STRING

   IF p_file_location='c' THEN
      CALL ui.Interface.frontCall("standard",
                                  "openfile",
                                  #[ls_default_dir, p_diff_kind||" Files", "*."||p_diff_kind, "Open File"],
                                  [NULL, p_diff_kind||" Files", "*."||p_diff_kind, "Open File"],
                                  [p_file_path])
   ELSE
      IF cl_null(p_file_path) THEN
         LET ls_default_dir = NULL
         IF p_file_location='s' THEN #server端檔案總管的預設路徑.
            LET ls_default_dir = FGL_GETENV("ERP")
         END IF
      END IF

      LET p_file_path = sadzp340_dlg_opendlg(
                                             "Open File",
                                             ls_default_dir,
                                             NULL,
                                             "*."||p_diff_kind,
                                             ""
                                            )
   END IF

   RETURN p_file_path
END FUNCTION
