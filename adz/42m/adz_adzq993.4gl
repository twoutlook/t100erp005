#+ 程式版本......:
#
#+ 程式代碼......: adzq993
#+ 設計人員......: Elena
# Prog. Version..:
#
# Program name   : adzq993.4gl
# Description    : 預覽Patch或過單的程式差異
# Modify         : 20160310 160226-00010 by Hiko : 新建程式

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/adzq991_module.inc"

PRIVATE TYPE T_LIST RECORD
       t_prog           LIKE dzaf_t.dzaf001,
       t_ver            LIKE dzaf_t.dzaf002,
       t_spec_ver       LIKE dzaf_t.dzaf003,
       t_code_ver       LIKE dzaf_t.dzaf004,
       t_module         LIKE dzaf_t.dzaf006,
       t_is_standard    LIKE dzaf_t.dzaf010

END RECORD

PRIVATE TYPE T_DELETE_LIST RECORD
       path1_1    STRING,
       Path1_2    STRING,
       path2_1    STRING,
       path2_2    STRING

END RECORD


DEFINE g_prog           LIKE dzaf_t.dzaf001,
       g_prog_name      STRING,
       g_diff_kind      STRING,
       g_prog_list      DYNAMIC ARRAY OF T_LIST

MAIN

   DEFINE lw_window     ui.Window,
          lf_form       ui.Form,
          ls_cfg_path   STRING,
          ls_4st_path   STRING,
          ls_img_path   STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP

   CALL FGL_SETENV("GEN_MODE", "diff")
   DISPLAY FGL_GETENV("GEN_MODE")
 
   CALL cl_tool_init()

   OPEN WINDOW w_adzq993 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱
 
   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzq993_ui_input()

   CLOSE WINDOW w_adzq993

END MAIN

PRIVATE FUNCTION adzq993_ui_input()
   DEFINE ls_prog          STRING,
          ls_module        STRING,
          ls_standard      STRING,
          ls_code_ver      STRING,
          li_curr_ver1     INTEGER,
          li_curr_ver2     INTEGER,
          ls_cmd           STRING,
          lb_return        BOOLEAN,
          ls_retmsg        STRING,
          ls_PathName1_1   STRING,
          ls_PathName1_2   STRING,
          ls_PathName2_1   STRING,
          ls_PathName2_2   STRING,
          ls_prog_name     STRING,
          lch_pipe         base.Channel,
          lb_file1_exist   BOOLEAN,
          lb_file2_exist   BOOLEAN,
          li_cnt           INTEGER,
          
          lr_file_info     T_FILE_INFO,   
          obj_json         util.JSONObject,
          lr_param         RECORD
                           prog  STRING,
                           param DYNAMIC ARRAY OF STRING
                           END RECORD,
          ls_js            STRING,
          delete_list      DYNAMIC ARRAY OF T_DELETE_LIST

   LET g_prog = ''
   LET g_prog_name = ''

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      INPUT g_diff_kind, g_prog, g_prog_name FROM  rgb_diff_kind, btd_prog, lbl_prog_name #ATTRIBUTES(UNBUFFERED) 

      ON ACTION controlp INFIELD btd_prog
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
      LET g_qryparam.reqry = FALSE
      LET g_qryparam.where = ""
      LET g_qryparam.arg1 = g_prog
      CALL q_adzq993()

      LET g_prog = g_qryparam.return1
      LET g_prog_name = g_qryparam.return2

      IF NOT cl_null(g_prog) THEN
         CALL adzq993_init()
      ELSE
         LET g_prog = null
         LET g_prog_list = null
      END IF

      


      AFTER FIELD btd_prog
         IF NOT cl_null(g_prog) THEN
            CALL adzq993_init()
         ELSE
            LET g_prog_list = null
         END IF


      END INPUT


      DISPLAY ARRAY g_prog_list TO tbl_ver1.*
         BEFORE ROW
            LET li_curr_ver1 = ARR_CURR() 
      END DISPLAY

      DISPLAY ARRAY g_prog_list TO tbl_ver2.*
         BEFORE ROW 
            LET li_curr_ver2 = ARR_CURR()
      END DISPLAY



      ON ACTION btn_diff

         #未選擇程式代號，提示訊息
         IF cl_null(g_prog) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'adz-00354'
            LET g_errparam.extend = NULL
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CONTINUE DIALOG
         END IF
 
         #來源沒選擇，提示訊息
         IF li_curr_ver1 = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'adz-00888'
            LET g_errparam.extend = NULL
            LET g_errparam.popup = FALSE
            LET g_errparam.replace[1] = "來源"
            CALL cl_err()
            CONTINUE DIALOG
         END IF

         #目的沒選擇，提示訊息
         IF li_curr_ver2 = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'adz-00888'
            LET g_errparam.extend = NULL
            LET g_errparam.popup = FALSE
            LET g_errparam.replace[1] = "目的"
            CALL cl_err()
            CONTINUE DIALOG
         END IF


         #刪除delete_list內紀錄路徑下的檔案
         IF delete_list.getLength() >0 THEN
            DISPLAY "delete last file"
            FOR li_cnt = 1 TO delete_list.getLength() 
               CALL os.Path.delete(delete_list[li_cnt].path1_1) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path1_2) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path2_1) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path2_2) RETURNING lb_return
            END FOR
         END IF

         LET ls_module = g_prog_list[li_curr_ver1].t_module CLIPPED
         LET ls_module = ls_module.toLowerCase()
         LET ls_standard = g_prog_list[li_curr_ver1].t_is_standard CLIPPED
         LET ls_prog = g_prog
         
         IF g_diff_kind = "4gl" THEN

            LET ls_code_ver = g_prog_list[li_curr_ver1].t_code_ver CLIPPED


            #產生來源版本
            DISPLAY "產生來源版本"
            LET ls_cmd = "r.r adzp177 ",ls_module," ",ls_prog," ",ls_code_ver," ",ls_standard
            
            #產生tgl
            DISPLAY "產生來源tgl"
            CALL cl_cmdrun_openpipe("r.r adzp177",ls_cmd,FALSE) RETURNING lb_return,ls_retmsg
            LET ls_prog_name = ls_prog,".tgl.ver",ls_code_ver
            LET ls_PathName1_1 = os.path.join(os.path.join(os.path.join(os.path.join(FGL_GETENV("ERP"),ls_module),"dzx"),"tgl"),ls_prog_name)

            IF lb_return THEN
               DISPLAY "產生來源4gl"
               #fglrun $ERP/adz/42r/adzp180.42r  '模組別' '程式名稱' '版次' '識別標示'
               LET ls_cmd = "fglrun $ERP/adz/42r/adzp180.42r ",ls_module," ",ls_prog," ", ls_code_ver, " ", ls_standard
               RUN ls_cmd

               #檢核檔案是否產生
               LET ls_prog_name = ls_prog||".4gl.ver"||ls_code_ver
               LET ls_PathName1_2 = os.path.join(os.path.join(os.path.join(FGL_GETENV("ERP"),ls_module),"4gl"),ls_prog_name)
               IF NOT os.Path.exists(ls_PathName1_2) THEN
                  #提示檔案不存在
                  LET lb_file1_exist = FALSE
               ELSE
                  LET lb_file1_exist = TRUE
               END IF
 
            END IF
            

            #產生目的版本
            LET ls_module = g_prog_list[li_curr_ver2].t_module
            LET ls_module = ls_module.toLowerCase()
            LET ls_standard = g_prog_list[li_curr_ver2].t_is_standard
            LET ls_code_ver = g_prog_list[li_curr_ver2].t_code_ver

            DISPLAY "產生目的版本"
            LET ls_cmd = "r.r adzp177 ",ls_module," ",ls_prog," ",ls_code_ver," ",ls_standard

            #產生tgl
            DISPLAY "產生目的tgl"
            CALL cl_cmdrun_openpipe("r.r adzp177",ls_cmd,FALSE) RETURNING lb_return,ls_retmsg
            #LET ls_PathName2_1 = "$ERP/",ls_module,"/dzx/tgl/",ls_prog,".tgl.ver",ls_code_ver
            LET ls_prog_name = ls_prog,".tgl.ver",ls_code_ver
            LET ls_PathName2_1 = os.path.join(os.path.join(os.path.join(os.path.join(FGL_GETENV("ERP"),ls_module),"dzx"),"tgl"),ls_prog_name)

            IF lb_return THEN
               DISPLAY "產生目的4gl"
               #fglrun $ERP/adz/42r/adzp180.42r  '模組別' '程式名稱' '版次' '識別標示'
               LET ls_cmd = "fglrun $ERP/adz/42r/adzp180.42r ",ls_module," ",ls_prog," ", ls_code_ver, " ", ls_standard
               RUN ls_cmd


               #檢核檔案是否產生
               LET ls_prog_name = ls_prog||".4gl.ver"||ls_code_ver
               LET ls_PathName2_2 = os.path.join(os.path.join(os.path.join(FGL_GETENV("ERP"),ls_module),"4gl"),ls_prog_name)
               IF NOT os.Path.exists(ls_PathName2_2) THEN
                  #提示檔案不存在
                  LET lb_file2_exist = FALSE
               ELSE
                  LET lb_file2_exist = TRUE
               END IF

            END IF
         
         ELSE   #4fd



         END IF
 
         DISPLAY "ls_PathName1_1=",ls_PathName1_1
         DISPLAY "ls_PathName1_2=",ls_PathName1_2
         DISPLAY "ls_PathName2_1=",ls_PathName2_1
         DISPLAY "ls_PathName2_2=",ls_PathName2_2

         #檔案都存在，呼叫adzq991執行diff
         IF lb_file1_exist AND lb_file2_exist THEN
            IF g_diff_kind = "4gl" THEN
               LET lr_file_info.left_4gl = ls_PathName1_2
               LET lr_file_info.right_4gl = ls_PathName2_2
               LET lr_file_info.left_4fd = NULL
               LET lr_file_info.right_4fd = NULL   
            ELSE
               LET lr_file_info.left_4gl = NULL
               LET lr_file_info.right_4gl = NULL
               LET lr_file_info.left_4fd = ls_PathName1_2
               LET lr_file_info.right_4fd = ls_PathName2_2
            END IF

            LET obj_json = util.JSONObject.fromFGL(lr_file_info)

            LET lr_param.prog = "adzq991"
            LET lr_param.param[1] = cs_file_diff
            LET lr_param.param[2] = obj_json.toString()
            LET ls_js = util.JSON.stringify(lr_param)
            CALL cl_cmdrun(ls_js)

         END IF

         #將這次比對的檔案資料加入delete_list中
         CALL delete_list.clear()
         LET delete_list[1].path1_1 = ls_PathName1_1
         LET delete_list[1].path1_2 = ls_PathName1_2
         LET delete_list[1].path2_1 = ls_PathName2_1
         LET delete_list[1].path2_2 = ls_PathName2_2
       


      ON ACTION CLOSE
         #刪除delete_list內紀錄路徑下的檔案
         IF delete_list.getLength() >0 THEN
            DISPLAY "delete last file"
            FOR li_cnt = 1 TO delete_list.getLength()
               CALL os.Path.delete(delete_list[li_cnt].path1_1) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path1_2) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path2_1) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path2_2) RETURNING lb_return
            END FOR
         END IF         

         EXIT DIALOG

      ON ACTION EXIT
         #刪除delete_list內紀錄路徑下的檔案
         IF delete_list.getLength() >0 THEN
            DISPLAY "delete last file"
            FOR li_cnt = 1 TO delete_list.getLength()
               CALL os.Path.delete(delete_list[li_cnt].path1_1) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path1_2) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path2_1) RETURNING lb_return
               CALL os.Path.delete(delete_list[li_cnt].path2_2) RETURNING lb_return
            END FOR
         END IF

         EXIT DIALOG

      IF INT_FLAG = FALSE THEN
         LET INT_FLAG = FALSE
      END IF      
      
 
   END DIALOG


END FUNCTION


#換程式代號
PRIVATE FUNCTION adzq993_init()

   DEFINE ls_sql STRING,
          li_cnt INTEGER

   LET ls_sql = "select dzaf001, dzaf002, dzaf003, dzaf004, dzaf006, dzaf010  from dzaf_t where dzaf001='", g_prog ,"' order by dzaf010 desc,dzaf002, dzaf003, dzaf004"
     
   PREPARE select_dzaf_t FROM ls_sql
   DECLARE dzaf_curs CURSOR FOR select_dzaf_t

   LET li_cnt = 1
   FOREACH dzaf_curs INTO g_prog_list[li_cnt].t_prog, g_prog_list[li_cnt].t_ver, g_prog_list[li_cnt].t_spec_ver, 
                          g_prog_list[li_cnt].t_code_ver, g_prog_list[li_cnt].t_module, g_prog_list[li_cnt].t_is_standard
      LET li_cnt = li_cnt + 1
   END FOREACH

   CALL g_prog_list.deleteElement(li_cnt)
 
END FUNCTION


PRIVATE FUNCTION adzq993_show()

END FUNCTION
