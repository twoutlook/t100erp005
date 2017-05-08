# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadz_mult_name.4gl
# Description    : 名称说明等多语言处理

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE g_dzdi001   LIKE dzdi_t.dzdi001   #档案代码
DEFINE g_dzdi002   LIKE dzdi_t.dzdi002   #栏位代码
DEFINE g_dzdi003   LIKE dzdi_t.dzdi003   #KEY 值序列
DEFINE g_dzdi      DYNAMIC ARRAY of RECORD #程式變數
                   dzdi004   LIKE dzdi_t.dzdi004,
                   dzdi005   LIKE dzdi_t.dzdi005
                   END RECORD
DEFINE g_dzdi_t    RECORD                #變數舊值
                   dzdi004   LIKE dzdi_t.dzdi004,
                   dzdi005   LIKE dzdi_t.dzdi005
                   END RECORD
DEFINE g_sql       STRING
DEFINE g_cnt       LIKE type_t.num10
DEFINE g_rec_b     LIKE type_t.num5      #單身筆數
DEFINE g_forupd_sql   STRING
DEFINE l_ac        LIKE type_t.num5      #目前處理的ARRAY CNT

################################################################################
# Descriptions...: 维护多语言说明
# Memo...........:
# Usage..........: CALL sadz_edit_name(p_dzdi001,p_dzdi002,p_dzdi003) RETURNING r_success
# INPUT parameter: p_dzdi001 档案代码
#                : p_dzdi002 栏位代码
#                : p_dzdi003 KEY 值序列
# RETURN code....: r_success 成功否
# Date & Author..: 13/01/25 By zhangll
# Modify.........:
################################################################################
PUBLIC FUNCTION sadz_edit_name(p_dzdi001,p_dzdi002,p_dzdi003)
DEFINE p_dzdi001   LIKE dzdi_t.dzdi001   #档案代码
DEFINE p_dzdi002   LIKE dzdi_t.dzdi002   #栏位代码
DEFINE p_dzdi003   LIKE dzdi_t.dzdi003   #KEY 值序列
DEFINE r_success   LIKE type_t.num5      #成功否
DEFINE r_dzdi005   LIKE dzdi_t.dzdi005   #说明

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   IF cl_null(p_dzdi001) OR cl_null(p_dzdi002) OR cl_null(p_dzdi003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = 'sadz_edit_name'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #IF NOT s_chk_trans('Y') THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF

   LET g_dzdi001 = p_dzdi001  #档案代码
   LET g_dzdi002 = p_dzdi002  #栏位代码
   LET g_dzdi003 = p_dzdi003  #KEY 值序列

  #OPEN WINDOW w_sadz_edit_name WITH FORM "adz/42f/sadz_edit_name"
  #ATTRIBUTE(STYLE=g_win_style CLIPPED)
   OPEN WINDOW w_sadz_edit_name WITH FORM cl_ap_formpath("adz","sadz_edit_name")
   CALL cl_ui_init()
   #动态多语言
   CALL cl_set_combo_lang("dzdi004")
   #隐藏单头
   IF g_user <> "tiptop" THEN
      CALL cl_set_comp_visible("group01", FALSE)
   END IF

   DISPLAY g_dzdi001,g_dzdi002,g_dzdi003 TO dzdi001,dzdi002,dzdi003
   LET g_sql = "SELECT dzdi004,dzdi005 FROM dzdi_t ",
               " WHERE dzdi001 = '",g_dzdi001 CLIPPED,"' ",
                 " AND dzdi002 = '",g_dzdi002 CLIPPED,"' ",
                 " AND dzdi003 = '",g_dzdi003 CLIPPED,"' ",
               " ORDER BY dzdi004"

   PREPARE sadz_edit_name_p FROM g_sql
   DECLARE sadz_edit_name_c CURSOR FOR sadz_edit_name_p

   CALL sadz_edit_name_b_fill()
   CALL sadz_edit_name_menu()

   CALL cl_set_comp_visible("group01", TRUE)
   CLOSE WINDOW w_sadz_edit_name

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION sadz_edit_name_b_fill()
   CALL g_dzdi.clear()
   LET g_cnt = 1
   LET g_rec_b = 0
   FOREACH sadz_edit_name_c INTO g_dzdi[g_cnt].*       #單身 ARRAY 填充
      LET g_rec_b = g_rec_b + 1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET g_cnt = g_cnt + 1
     #IF g_cnt > g_max_rec THEN
     #   CALL cl_err('',9035,0)
     #   EXIT FOREACH
     #END IF
   END FOREACH
   CALL g_dzdi.deleteElement(g_cnt)
   LET g_rec_b = g_cnt - 1
END FUNCTION

PRIVATE FUNCTION sadz_edit_name_menu()
   WHILE TRUE
      CALL sadz_edit_name_bp("G")
      CASE g_action_choice
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL sadz_edit_name_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "help"                            # H.求助
            CALL cl_help_prog_url()
         WHEN "exit"                            # Esc.結束
            EXIT WHILE
      END CASE
   END WHILE
END FUNCTION

PRIVATE FUNCTION sadz_edit_name_bp(p_ud)
DEFINE p_ud   LIKE type_t.chr1
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL SET_COUNT(g_rec_b)
   DISPLAY ARRAY g_dzdi TO s_dzdi.* ATTRIBUTE(UNBUFFERED)
      BEFORE ROW
         CALL SET_COUNT(g_rec_b)
         CALL cl_show_fld_cont()
         LET l_ac = ARR_CURR()

      ON ACTION detail                           # B.單身
         LET g_action_choice='detail'
         LET l_ac = 1
         EXIT DISPLAY

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION help                             # H.說明
         LET g_action_choice='help'
         EXIT DISPLAY

      ON ACTION exit                             # Esc.結束
         LET g_action_choice='exit'
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

       ON ACTION about
          CALL cl_about()

       ON ACTION controlg
          CALL cl_cmdask()

      AFTER DISPLAY
         CONTINUE DISPLAY

   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

PRIVATE FUNCTION sadz_edit_name_b()
DEFINE l_ac_t          LIKE type_t.num5   # 未取消的ARRAY CNT
DEFINE l_n             LIKE type_t.num5   # 檢查重複用
DEFINE l_lock_sw       LIKE type_t.chr1   # 單身鎖住否
DEFINE p_cmd           LIKE type_t.chr1   # 處理狀態
DEFINE l_allow_insert  LIKE type_t.num5
DEFINE l_allow_delete  LIKE type_t.num5
DEFINE l_today         LIKE type_t.dat

   LET g_action_choice = ""
  #IF s_shut(0) THEN
  #   RETURN
  #END IF

   #在進入時已查核過權限, 此處不必重新再檢查
   LET l_allow_insert = TRUE
   LET l_allow_delete = TRUE
   LET l_today = cl_get_current()

   LET g_forupd_sql= "SELECT dzdi004,dzdi005 ",
                     "  FROM dzdi_t",
                     "  WHERE dzdi001=? AND dzdi002=? AND dzdi003=? AND dzdi004=? ",
                       " FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE sadz_edit_name_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET l_ac_t = 0

   INPUT ARRAY g_dzdi WITHOUT DEFAULTS FROM s_dzdi.*
              ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                        INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
      BEFORE INPUT
         IF g_rec_b != 0 THEN
             CALL fgl_set_arr_curr(l_ac)
         END IF

      BEFORE ROW
         LET p_cmd = ''
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'              #DEFAULT
         LET l_n  = ARR_COUNT()

         IF g_rec_b >= l_ac THEN
            LET p_cmd='u'
            LET g_dzdi_t.* = g_dzdi[l_ac].*  #BACKUP
           #CALL s_begin_trans()
            LET p_cmd='u'
            OPEN sadz_edit_name_bcl
                 USING g_dzdi001,g_dzdi002,g_dzdi003,g_dzdi_t.dzdi004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN sadz_edit_name_bcl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_lock_sw = 'Y'
            ELSE
               FETCH sadz_edit_name_bcl INTO g_dzdi[l_ac].*
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'FETCH sadz_edit_name_bcl:'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw = "Y"
               END IF
            END IF
            CALL cl_show_fld_cont()
         END IF

      BEFORE INSERT
         LET p_cmd = 'a'
         LET l_n = ARR_COUNT()
         INITIALIZE g_dzdi[l_ac].* TO NULL
         LET g_dzdi_t.* = g_dzdi[l_ac].*          #新輸入資料
         CALL cl_show_fld_cont() 
         NEXT FIELD dzdi004

      AFTER INSERT
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         INSERT INTO dzdi_t(dzdiownid,dzdiowndp,dzdicrtid,dzdicrtdp,
                            dzdicrtdt,dzdimodid,dzdimoddt,dzdicnfid,dzdicnfdt,
                            dzdi001,dzdi002,dzdi003,dzdi004,dzdi005)
                      VALUES (g_user,g_dept,g_user,g_dept,
                              l_today,g_user,l_today,g_user,l_today,
                              g_dzdi001,g_dzdi002,g_dzdi003,
                              g_dzdi[l_ac].dzdi004,g_dzdi[l_ac].dzdi005)
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = g_dzdi[l_ac].dzdi005
             LET g_errparam.popup = FALSE
             CALL cl_err()
            #CALL s_end_trans('N')
             CANCEL INSERT
         ELSE
             MESSAGE 'INSERT O.K'
             LET g_rec_b = g_rec_b + 1
         END IF

      BEFORE DELETE                            #是否取消單身
         IF NOT cl_null(g_dzdi_t.dzdi004) THEN
            IF NOT cl_ask_del_detail() THEN
               CANCEL DELETE
            END IF
            IF l_lock_sw = "Y" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  -263
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CANCEL DELETE
            END IF
            DELETE FROM dzdi_t WHERE dzdi001 = g_dzdi001
                                 AND dzdi002 = g_dzdi002
                                 AND dzdi003 = g_dzdi003
                                 AND dzdi004 = g_dzdi[l_ac].dzdi004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = g_dzdi_t.dzdi005
               LET g_errparam.popup = FALSE
               CALL cl_err()
              #CALL s_end_trans('N')
               CANCEL DELETE
            END IF
            LET g_rec_b = g_rec_b - 1
         END IF
        #CALL s_end_trans('Y')

      ON ROW CHANGE
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            LET g_dzdi[l_ac].* = g_dzdi_t.*
            CLOSE sadz_edit_name_bcl
           #CALL s_end_trans('N')
            EXIT INPUT
         END IF
         IF l_lock_sw = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = -263
            LET g_errparam.extend = g_dzdi[l_ac].dzdi005
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_dzdi[l_ac].* = g_dzdi_t.*
         ELSE
            UPDATE dzdi_t
               SET dzdi004 = g_dzdi[l_ac].dzdi004,
                   dzdi005 = g_dzdi[l_ac].dzdi005,
                   dzdimodid= g_user,
                   dzdimoddt= l_today
             WHERE dzdi001 = g_dzdi001
               AND dzdi002 = g_dzdi002
               AND dzdi003 = g_dzdi003
               AND dzdi004 = g_dzdi_t.dzdi004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = g_dzdi[l_ac].dzdi005
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET g_dzdi[l_ac].* = g_dzdi_t.*
            ELSE
               MESSAGE 'UPDATE O.K'
              #CALL s_end_trans('Y')
            END IF
         END IF

      AFTER ROW
         LET l_ac = ARR_CURR()
         LET l_ac_t = l_ac

         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            IF p_cmd='u' THEN
                LET g_dzdi[l_ac].* = g_dzdi_t.*
            END IF
            CLOSE sadz_edit_name_bcl
           #CALL s_end_trans('N')
            EXIT INPUT
         END IF
         CLOSE sadz_edit_name_bcl
        #CALL s_end_trans('Y')

      ON ACTION CONTROLG
          CALL cl_cmdask()

      ON ACTION CONTROLZ
         CALL cl_show_req_fields()

      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
       # CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)   #zll

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

       ON ACTION about
          CALL cl_about()

       ON ACTION help
          CALL cl_help_prog_url()

   END INPUT
   CLOSE sadz_edit_name_bcl
  #CALL s_end_trans('Y')
END FUNCTION



################################################################################
# Descriptions...: 获取多语言说明
# Memo...........:
# Usage..........: CALL sadz_get_name(p_dzdi001,p_dzdi002,p_dzdi003) RETURNING r_dzdi005
# Example........:      LET g_dzdi003 = s_chr_trim(g_dzdg001),',',s_chr_trim(g_dzdg004)
#                :      LET g_dzdg004_desc = sadz_get_name("dzdg_t","dzdg004",g_dzdi003)
# INPUT parameter: p_dzdi001 档案代码
#                : p_dzdi002 栏位代码
#                : p_dzdi003 KEY 值序列
# RETURN code....: r_dzdi005 说明
# Date & Author..: 13/01/25 By zhangll
# Modify.........:
################################################################################

PUBLIC FUNCTION sadz_get_name(p_dzdi001,p_dzdi002,p_dzdi003)
DEFINE p_dzdi001   LIKE dzdi_t.dzdi001   #档案代码
DEFINE p_dzdi002   LIKE dzdi_t.dzdi002   #栏位代码
DEFINE p_dzdi003   LIKE dzdi_t.dzdi003   #KEY 值序列
DEFINE r_success   LIKE type_t.num5      #成功否
DEFINE r_dzdi005   LIKE dzdi_t.dzdi005   #说明

   WHENEVER ERROR CONTINUE
   IF cl_null(p_dzdi001) OR cl_null(p_dzdi002) OR cl_null(p_dzdi003) THEN
     #CALL cl_err('sadz_get_name','sub-00001',1)  #这一般是程序错误或者栏位没有值，显示是不需要报错的
      RETURN r_dzdi005
   END IF

   SELECT dzdi005 INTO r_dzdi005
     FROM dzdi_t
    WHERE dzdi001 = p_dzdi001
      AND dzdi002 = p_dzdi002
      AND dzdi003 = p_dzdi003
      AND dzdi004 = g_lang
   IF SQLCA.sqlcode THEN
     #CALL cl_err('sel dzdi005',SQLCA.sqlcode,0)
      RETURN r_dzdi005
   END IF

   RETURN r_dzdi005
END FUNCTION

################################################################################
# Descriptions...: 删除多语言说明
# Memo...........:
# Usage..........: CALL sadz_del_name(p_dzdi001,p_dzdi002,p_dzdi003) RETURNING r_success
# INPUT parameter: p_dzdi001 档案代码
#                : p_dzdi002 栏位代码
#                : p_dzdi003 KEY 值序列
# RETURN code....: r_success 成功否
# Date & Author..: 13/01/25 By zhangll
# Modify.........:
################################################################################
PUBLIC FUNCTION sadz_del_name(p_dzdi001,p_dzdi002,p_dzdi003)
DEFINE p_dzdi001   LIKE dzdi_t.dzdi001   #档案代码
DEFINE p_dzdi002   LIKE dzdi_t.dzdi002   #栏位代码
DEFINE p_dzdi003   LIKE dzdi_t.dzdi003   #KEY 值序列
DEFINE r_success   LIKE type_t.num5      #成功否

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE 
   IF cl_null(p_dzdi001) OR cl_null(p_dzdi002) OR cl_null(p_dzdi003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = 'sadz_del_name'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #IF NOT s_chk_trans('Y') THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF

   DELETE FROM dzdi_t 
    WHERE dzdi001 = p_dzdi001  #档案代码
      AND dzdi002 = p_dzdi002  #栏位代码
      AND dzdi003 = p_dzdi003  #KEY 值序列
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'delete mult_name'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新多语言说明之key值
# Memo...........:
# Usage..........: CALL sadz_upd_name_key(p_dzdi001,p_dzdi002,p_dzdi003,
#                :                       p_dzdi001_t,p_dzdi002_t,p_dzdi003_t)
#                :          RETURNING r_success
# INPUT parameter: p_dzdi001 档案代码
#                : p_dzdi002 栏位代码
#                : p_dzdi003 KEY 值序列
# RETURN code....: r_success 成功否
# Date & Author..: 13/01/25 By zhangll
# Modify.........:
################################################################################
PUBLIC FUNCTION sadz_upd_name_key(p_dzdi001,p_dzdi002,p_dzdi003,p_dzdi001_t,p_dzdi002_t,p_dzdi003_t)
DEFINE p_dzdi001   LIKE dzdi_t.dzdi001   #档案代码
DEFINE p_dzdi002   LIKE dzdi_t.dzdi002   #栏位代码
DEFINE p_dzdi003   LIKE dzdi_t.dzdi003   #KEY 值序列
DEFINE p_dzdi001_t LIKE dzdi_t.dzdi001   #档案代码_旧值
DEFINE p_dzdi002_t LIKE dzdi_t.dzdi002   #栏位代码_旧值
DEFINE p_dzdi003_t LIKE dzdi_t.dzdi003   #KEY 值序列_旧值
DEFINE r_success   LIKE type_t.num5      #成功否

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   IF cl_null(p_dzdi001) OR cl_null(p_dzdi002) OR cl_null(p_dzdi003) OR
      cl_null(p_dzdi001_t) OR cl_null(p_dzdi002_t) OR cl_null(p_dzdi003_t) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = 'sadz_upd_name_key'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #IF NOT s_chk_trans('Y') THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF

   UPDATE dzdi_t SET dzdi001 = p_dzdi001,  #档案代码
                     dzdi002 = p_dzdi002,  #栏位代码
                     dzdi003 = p_dzdi003   #KEY 值序列
    WHERE dzdi001 = p_dzdi001_t  #档案代码
      AND dzdi002 = p_dzdi002_t  #栏位代码
      AND dzdi003 = p_dzdi003_t  #KEY 值序列
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'update'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION




