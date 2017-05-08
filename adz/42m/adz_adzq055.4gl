#+ 程式版本......: 
#
#+ 程式代碼......: adzq055
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzq055.4gl
# Description    : 查詢程式呼叫關聯清單
# Modify         : 20160526 160526-00022 by Hiko : 新建程式

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

TYPE T_TREE RECORD
            name    LIKE type_t.chr100,    #程式代號.函式名稱
            pid     LIKE type_t.chr100,    #父節點id
            id      LIKE type_t.chr100,    #本身節點id
            exp     LIKE type_t.chr100,    #是否展開
            isnode  LIKE type_t.num5,      #是否有子節點
            isexp   LIKE type_t.num5,      #是否已展開
            expcode LIKE type_t.num5,      #展開值
            belong_prog LIKE type_t.chr100 #所屬程式編號
            END RECORD

DEFINE ma_browse DYNAMIC ARRAY OF T_TREE,
       ms_errmsg STRING #檢查函式的累加錯誤訊息

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    

   CALL cl_tool_init()

   OPEN WINDOW w_adzq055 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzq055_ui_input()

   CLOSE WINDOW w_adzq055 
END MAIN

PRIVATE FUNCTION adzq055_ui_input()
   DEFINE l_option LIKE type_t.chr1,
          l_func1  LIKE type_t.chr100,
          l_func2  LIKE type_t.chr100,
          l_func   LIKE type_t.chr100,
          lb_find  BOOLEAN,
          lt_start DATETIME YEAR TO SECOND,
          lt_stop  DATETIME YEAR TO SECOND

   #建立暫存表來檢查是否存在無窮迴圈的情況出現.
   CREATE TEMP TABLE adzq055_temp
   (
      id   VARCHAR(100),
      func VARCHAR(100)
   );

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT l_option,l_func1,l_func2 FROM rgp_option,edt_func1,edt_func2
         BEFORE INPUT
            CALL cl_set_comp_entry("edt_func1", TRUE)
            CALL cl_set_comp_entry("edt_func2", FALSE)

         ON CHANGE rgp_option
            LET l_func1 = NULL            
            LET l_func2 = NULL            
            INITIALIZE ma_browse TO NULL
            LET ms_errmsg = NULL

            CASE l_option
               WHEN 'U'
                  CALL cl_set_comp_entry("edt_func1", TRUE)
                  CALL cl_set_comp_entry("edt_func2", FALSE)
               WHEN 'D'
                  CALL cl_set_comp_entry("edt_func1", FALSE)
                  CALL cl_set_comp_entry("edt_func2", TRUE)
            END CASE
            
         ON ACTION find_prog
            #暫時將程式尋找函式的功能隱藏,也就是沒有D.
            LET lb_find = FALSE
            CASE l_option
               WHEN 'U'
                  IF NOT cl_null(l_func1) THEN
                     LET l_func = l_func1
                     LET lb_find = TRUE
                  END IF
               WHEN 'D'
                  IF NOT cl_null(l_func2) THEN
                     LET l_func = l_func2
                     LET lb_find = TRUE
                  END IF
            END CASE

            IF lb_find THEN
               DELETE FROM adzq055_temp

               LET lt_start = CURRENT
               INITIALIZE ma_browse TO NULL
               #s_aini010_ins_inad
               LET ma_browse[1].pid = "0"
               LET ma_browse[1].id = "1"
               LET ma_browse[1].name = "(",ma_browse[1].id,")",l_func
               CALL adzq055_ins_temp(ma_browse[1].id, l_func)
               display "CALL adzq055_find_prog(",l_option,",",l_func,",",ma_browse[1].id,")"
               IF l_option='D' THEN #向下找的話, 第一趟是先找此程式的函式清單.
                  CALL adzq055_find_prog('P', l_func, ma_browse[1].id)
               ELSE
                  CALL adzq055_find_prog(l_option, l_func, ma_browse[1].id)
               END IF

               LET lt_stop = CURRENT
               display "查詢時間=",lt_stop-lt_start

               IF NOT cl_null(ms_errmsg) THEN
                  LET ms_errmsg = cl_getmsg("adz-00872", g_lang),"\n",ms_errmsg #底下節點的上下關係出現無窮迴圈的隱憂, 請查明後再繼續 :
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "!"
                  LET g_errparam.extend = ms_errmsg
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            END IF

      END INPUT   

      DISPLAY ARRAY ma_browse TO s_browse.*
         ON ACTION exp_excel
            IF NOT cl_null(l_func) THEN
               CALL g_export_node.clear()
               LET g_main_hidden = 1
               LET g_export_node[1] = base.typeInfo.create(ma_browse)
               LET g_export_id[1]   = "s_browse"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

      END DISPLAY

      ON ACTION exit
         LET g_action_choice = "exit"
         EXIT DIALOG
      
      ON ACTION CLOSE
         LET g_action_choice = "exit"
         EXIT DIALOG

   END DIALOG

   DROP TABLE adzq055_temp
END FUNCTION

PRIVATE FUNCTION adzq055_find_prog(p_option, p_target_func, p_pid)
   DEFINE p_option      LIKE type_t.chr1,
          p_target_func STRING,
          p_pid         STRING
   DEFINE ls_sql    STRING,
          li_cnt    INTEGER,
          la_dzbs   DYNAMIC ARRAY OF RECORD
                    prog LIKE dzbs_t.dzbs001, #程式編號
                    func LIKE dzbs_t.dzbs002  #所屬函式
                    END RECORD,
          li_i      INTEGER,
          li_idx    INTEGER,
          ls_id     STRING,
          lb_result BOOLEAN #檢查函式是否正常

   LET p_target_func = p_target_func.trim()
   LET p_target_func = p_target_func.toLowerCase() #dzbs_t都是小寫資料.

   CASE p_option
      WHEN 'U'
         IF p_target_func.equals("main") THEN
            RETURN
         END IF

         LET ls_sql = "SELECT dzbs001,dzbs002 FROM dzbs_t",
                      " WHERE dzbs003='",p_target_func,"'",
                      " ORDER BY dzbs001,dzbs002"
      WHEN 'P'
         LET ls_sql = "SELECT DISTINCT dzbs001,dzbs002 FROM dzbs_t",
                      " WHERE dzbs001='",p_target_func,"'",
                      " ORDER BY dzbs001,dzbs002"
         LET p_option = 'D' #P只做一次, 然後變成D.
      WHEN 'D'
         LET ls_sql = "SELECT dzbs001,dzbs003 FROM dzbs_t",
                      " WHERE dzbs002='",p_target_func,"'",
                      " ORDER BY dzbs001,dzbs003"
   END CASE
   #display "ls_sql=",ls_sql
   PREPARE dzbs_prep FROM ls_sql
   DECLARE dzbs_curs CURSOR FOR dzbs_prep
   LET li_i = 1
   FOREACH dzbs_curs INTO la_dzbs[li_i].*
      LET li_i = li_i + 1
   END FOREACH
   IF la_dzbs.getLength()>0 THEN
      CALL la_dzbs.deleteElement(li_i)
   END IF

   #在FOREACH內不可以有遞迴呼叫, 所以改成用陣列處理.
   FOR li_i=1 TO la_dzbs.getLength()
      #若發現所屬函式和目標函式相同, 表示這是遞迴呼叫, 就不要再列出來了.
      IF la_dzbs[li_i].func=p_target_func THEN
         CONTINUE FOR
      END IF

      #判斷函式的上下關係是否存在顛倒情形, 以免無窮迴圈 : 同一樹枝上下關係不能又找到自己.
      IF NOT adzq055_check_func(p_pid, la_dzbs[li_i].func) THEN
         CONTINUE FOR
      END IF

      LET li_idx = ma_browse.getLength() + 1
      LET ma_browse[li_idx].pid = p_pid
      LET ls_id = li_i
      LET ls_id = p_pid,"-",ls_id.trim()
      LET ma_browse[li_idx].id = ls_id
      LET ma_browse[li_idx].name = "(",ls_id,")",la_dzbs[li_i].func
      LET ma_browse[li_idx].belong_prog = la_dzbs[li_i].prog
     #display "ma_browse[li_idx].name=",ma_browse[li_idx].name
     #display "ma_browse[li_idx].pid=",ma_browse[li_idx].pid
     #display "ma_browse[li_idx].id=",ma_browse[li_idx].id

      CALL adzq055_ins_temp(ls_id, la_dzbs[li_i].func)
      
      CALL adzq055_find_prog(p_option, la_dzbs[li_i].func, ls_id)
   END FOR
END FUNCTION
 
PRIVATE FUNCTION adzq055_check_func(p_id, p_func)
   DEFINE p_id   STRING,
          p_func STRING
   DEFINE ls_sql    STRING,
          li_cnt    INTEGER,
          li_idx    INTEGER,
          lb_repeat BOOLEAN,
          lb_result BOOLEAN,
          ls_errmsg STRING

   LET lb_repeat = FALSE
   LET lb_result = TRUE
   LET ls_errmsg = NULL

   LET ls_sql = "SELECT COUNT(*) FROM adzq055_temp WHERE id='",p_id,"' AND func='",p_func,"'"
   PREPARE temp_prep1 FROM ls_sql
   EXECUTE temp_prep1 INTO li_cnt
   FREE temp_prep1
   IF li_cnt>0 THEN
      LET lb_result = FALSE
      LET ls_errmsg = "node : ",p_func," ,id : like ",p_id,"*"
      IF ms_errmsg.getLength()>0 THEN
         LET ms_errmsg = ms_errmsg,"\n",ls_errmsg
      ELSE
         LET ms_errmsg = ls_errmsg
      END IF
      RETURN lb_result
   ELSE
      #以id往上找是否早已存在p_func.
      FOR li_idx=p_id.getLength() TO 1 STEP -1
         IF p_id.getCharAt(li_idx)='-' THEN
            LET p_id = p_id.subString(1, li_idx-1)
            LET lb_repeat = TRUE
            EXIT FOR            
         END IF
      END FOR
   END IF

   IF lb_repeat THEN
      CALL adzq055_check_func(p_id, p_func) RETURNING lb_result
   END IF

   RETURN lb_result
END FUNCTION
 
PRIVATE FUNCTION adzq055_ins_temp(p_id, p_func)
   DEFINE p_id   STRING,
          p_func STRING
   DEFINE ls_sql STRING

   LET ls_sql = "INSERT INTO adzq055_temp VALUES('",p_id,"','",p_func,"')"
   PREPARE temp_prep2 FROM ls_sql
   EXECUTE temp_prep2
   FREE temp_prep2
END FUNCTION
