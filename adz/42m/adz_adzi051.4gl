#+ 程式版本......: 
#
#+ 程式代碼......: adzi051
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzi051.4gl
# Description    : 差異比對來源Patch條件設定
# Modify         : 20170215 170215-00005 by Hiko : 新建程式

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

   OPEN WINDOW w_adzi051 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzi051_ui_input()

   CLOSE WINDOW w_adzi051 
END MAIN

PRIVATE FUNCTION adzi051_ui_input()
   DEFINE l_patch_no LIKE dzbk_t.dzbk001,
          li_cnt     SMALLINT,
          ls_sql     STRING,
          l_date     DATETIME YEAR TO SECOND

   INPUT l_patch_no FROM btd_patch_no ATTRIBUTES(UNBUFFERED)
      BEFORE INPUT
         SELECT dzbk001 INTO l_patch_no FROM dzbk_t
         DISPLAY l_patch_no TO btd_patch_no

      ON ACTION controlp INFIELD btd_patch_no
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c' #開窗多選
         CALL q_dzyg001()
         LET l_patch_no = g_qryparam.return1
         DISPLAY l_patch_no TO btd_patch_no
         NEXT FIELD btd_patch_no
   
      #儲存並離開
      ON ACTION save_exit
         IF cl_null(l_patch_no) THEN
            #若沒有輸入, 則刪除原本設定.
            IF cl_ask_confirm("adz-01170") THEN #請問是否要清空Patch編號的條件設定?
               DELETE FROM dzbk_t
               EXIT INPUT
            ELSE
               NEXT FIELD btd_patch_no
            END IF
         ELSE
            LET l_date = cl_get_current()
            SELECT COUNT(*) INTO li_cnt FROM dzbk_t
            IF li_cnt>0 THEN
               LET ls_sql = "UPDATE dzbk_t",
                              " SET dzbk001='",l_patch_no CLIPPED,"',",
                                   "dzbkmoddt=?,",
                                   "dzbkmodid='",g_user,"'"
            ELSE
               LET ls_sql = "INSERT INTO dzbk_t(dzbk001,dzbk002,dzbk003,",
                                               "dzbkcrtdt,dzbkcrtdp,dzbkowndp,dzbkownid,dzbkcrtid)",
                                       " VALUES('",l_patch_no CLIPPED,"','','',",
                                               "?,'",g_dept,"','",g_dept,"','",g_user,"','",g_user,"')"
            END IF
            display "ls_sql=",ls_sql
            PREPARE dzbk_prep FROM ls_sql
            EXECUTE dzbk_prep USING l_date
            FREE dzbk_prep               

            EXIT INPUT
         END IF
 
      ON ACTION exit
         EXIT INPUT

      ON ACTION CLOSE
         EXIT INPUT
   
   END INPUT   

   IF INT_FLAG = FALSE THEN
      LET INT_FLAG = FALSE
   END IF
END FUNCTION
