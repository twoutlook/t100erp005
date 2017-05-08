IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE lw_window   ui.Window,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE ls_sql STRING,
          la_scc DYNAMIC ARRAY OF RECORD
                 gzcbl002 LIKE gzcbl_t.gzcbl002,
                 gzcbl004 LIKE gzcbl_t.gzcbl004
                 END RECORD,
          li_idx SMALLINT

   CALL cl_tool_init()

   OPEN WINDOW w_adzq221 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET ls_sql = "SELECT gzcbl002,gzcbl004",
                 " FROM gzcbl_t",
                " WHERE gzcbl001='210' AND gzcbl003='",g_lang,"'",
                " ORDER BY gzcbl002" 
   PREPARE scc_prep FROM ls_sql
   DECLARE scc_curs CURSOR FOR scc_prep

   LET li_idx = 1
   FOREACH scc_curs INTO la_scc[li_idx].*
      LET li_idx = li_idx + 1
   END FOREACH

   DISPLAY ARRAY la_scc TO s_detail1.*
      ON ACTION CLOSE
         LET g_action_choice="exit"
         EXIT DISPLAY
   END DISPLAY
   
   CLOSE WINDOW w_adzq221 
END MAIN
