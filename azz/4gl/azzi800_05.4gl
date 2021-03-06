#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi800_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-05-11 11:27:36), PR版次:0001(2015-05-18 10:53:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: azzi800_05
#+ Description: 設定使用者流程目錄
#+ Creator....: 01274(2015-05-11 10:36:01)
#+ Modifier...: 01274 -SD/PR- 01274
 
{</section>}
 
{<section id="azzi800_05.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="azzi800_05.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_detail1             DYNAMIC ARRAY OF RECORD
            name             STRING,
            id               STRING,
            pid              STRING,
            isnode           BOOLEAN,
            expanded         BOOLEAN
       END RECORD
DEFINE g_gzba_d DYNAMIC ARRAY OF RECORD LIKE gzba_t.*
#end add-point
 
{</section>}
 
{<section id="azzi800_05.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="azzi800_05.other_dialog" >}

 
{</section>}
 
{<section id="azzi800_05.other_function" readonly="Y" >}

PUBLIC FUNCTION azzi800_05(p_gzba001)
   DEFINE p_gzba001        LIKE gzba_t.gzba001
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   DEFINE ls_sql          STRING
   DEFINE lr_gzba001      LIKE gzba_t.gzba001
   DEFINE l_ar             INTEGER
   DEFINE l_i              INTEGER
   
   LET ls_sql = " SELECT gzba001, gzba002, gzbal003  ",
                " FROM gzba_t ",
                " LEFT JOIN gzbal_t ON gzbalent = '"||g_enterprise||"' AND gzba001 = gzbal001 AND gzbal002 = '",g_dlang,"' ",
                " WHERE gzbaent = '" ||g_enterprise|| "' AND gzba002 IS NULL ORDER BY gzba003 ASC"
   PREPARE detail1_root_pre FROM ls_sql
   DECLARE detail1_root_cur CURSOR FOR detail1_root_pre
   
   LET ls_sql = " SELECT COUNT(*)  ",
                " FROM gzba_t ",
                " WHERE gzbaent = '" ||g_enterprise|| "' AND gzba002 = ?  "   
   PREPARE detail1_children_cnt_pre FROM ls_sql   
   
   LET ls_sql = " SELECT gzba001, gzba002, gzbal003  ",
                " FROM gzba_t ",
                " LEFT JOIN gzbal_t ON gzbalent = '"||g_enterprise||"' AND gzba001 = gzbal001 AND gzbal002 = '",g_dlang,"' ",
                " WHERE gzbaent = '" ||g_enterprise|| "' AND gzba002 = ? ORDER BY gzba003 ASC"
   PREPARE detail1_children_pre FROM ls_sql
   DECLARE detail1_children_cur CURSOR FOR detail1_children_pre
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi800_05 WITH FORM cl_ap_formpath("azz","azzi800_05")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   LET g_qryparam.state = "i"
   LET p_cmd = 'a'

   #輸入前處理
   #add-point:單頭前置處理

   #end add-point
   CALL azzi800_05_fill_tree()
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      DISPLAY ARRAY g_detail1 TO s_detail1.*
         BEFORE DISPLAY
            FOR l_i = 1 TO g_detail1.getLength()
               IF g_detail1[l_i].id == p_gzba001 THEN
                  CALL DIALOG.setCurrentRow("s_detail1", l_i)
                  EXIT FOR
               END IF
            END FOR
         BEFORE ROW
            LET l_ar = ARR_CURR()
      END DISPLAY

      #公用action
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #畫面關閉
   CLOSE WINDOW w_azzi800_05

   IF INT_FLAG == TRUE THEN
      LET lr_gzba001 = p_gzba001      
   ELSE
      IF g_detail1.getLength() == 0 THEN
         LET lr_gzba001 = NULL
      ELSE
         LET lr_gzba001 = g_detail1[l_ar].id   
      END IF
   END IF
   
   RETURN lr_gzba001
END FUNCTION

################################################################################
# Descriptions...: 填充系統流程樹狀圖
# Memo...........:
# Usage..........: CALL azzi800_05_fill_tree()
#                  RETURNING none
# Input parameter: none
# Return code....: lr_gzba001
# Date & Author..: 2015/05/11 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_05_fill_tree()
   DEFINE ls_sql        STRING
   DEFINE li_len        INTEGER
   DEFINE li_cnt        INTEGER
   DEFINE li_idx        INTEGER
   DEFINE l_gzba_t      DYNAMIC ARRAY OF RECORD 
            gzba001     LIKE gzba_t.gzba001,
            gzba002     LIKE gzba_t.gzba002,
            gzbal003    LIKE gzbal_t.gzbal003
          END RECORD
   
   CALL g_detail1.clear()  

   OPEN detail1_root_cur
   LET li_idx = 1
   FOREACH detail1_root_cur INTO l_gzba_t[li_idx].*
      LET li_idx = li_idx + 1
   END FOREACH
   CALL l_gzba_t.deleteElement(li_idx)
   
   FOR li_idx = 1 TO l_gzba_t.getLength()
      CALL g_detail1.appendElement()
      LET li_len = g_detail1.getLength()
      LET g_detail1[li_len].id = l_gzba_t[li_idx].gzba001
      LET g_detail1[li_len].pid = l_gzba_t[li_idx].gzba002
      LET g_detail1[li_len].name = l_gzba_t[li_idx].gzbal003  #, "(", l_gzba_t[li_idx].gzba001, ")"
      #展開子項
      EXECUTE detail1_children_cnt_pre USING l_gzba_t[li_idx].gzba001 INTO li_cnt
      IF li_cnt > 0 THEN
         CALL azzi800_05_fill_tree_child(l_gzba_t[li_idx].gzba001)
         LET g_detail1[li_len].isnode = TRUE
         LET g_detail1[li_len].expanded = TRUE
      END IF
   END FOR
   CLOSE detail1_root_cur
   FREE detail1_root_cur
END FUNCTION

################################################################################
# Descriptions...: 填充系統流程樹狀圖子項
# Memo...........:
# Usage..........: CALL azzi800_05_fill_tree_child(p_gzxa001)
#                  RETURNING noone
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/05/11 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_05_fill_tree_child(p_gzba001)
   DEFINE p_gzba001     LIKE gzba_t.gzba001  #選單代號
   DEFINE li_len        INTEGER
   DEFINE li_cnt        INTEGER
   DEFINE li_idx        INTEGER
   DEFINE l_gzba_t      DYNAMIC ARRAY OF RECORD 
            gzba001     LIKE gzba_t.gzba001,
            gzba002     LIKE gzba_t.gzba002,
            gzbal003    LIKE gzbal_t.gzbal003
          END RECORD


   
   LET li_idx = 1
   
   OPEN detail1_children_cur USING p_gzba001 
   FOREACH detail1_children_cur INTO l_gzba_t[li_idx].*
      LET li_idx = li_idx + 1
   END FOREACH
   CLOSE detail1_children_cur
   
   CALL l_gzba_t.deleteElement(li_idx)
   
   FOR li_idx = 1 TO l_gzba_t.getLength()
      CALL g_detail1.appendElement()
      LET li_len = g_detail1.getLength()
      LET g_detail1[li_len].id = l_gzba_t[li_idx].gzba001
      LET g_detail1[li_len].pid = l_gzba_t[li_idx].gzba002
      LET g_detail1[li_len].name = l_gzba_t[li_idx].gzbal003  #, "(", l_gzba_t[li_idx].gzba001, ")"
      #展開子項
      EXECUTE detail1_children_cnt_pre USING l_gzba_t[li_idx].gzba001 INTO li_cnt
      IF li_cnt > 0 THEN
         CALL azzi800_05_fill_tree_child(l_gzba_t[li_idx].gzba001)
         LET g_detail1[li_len].isnode = TRUE
         LET g_detail1[li_len].expanded = TRUE
      END IF
   END FOR

END FUNCTION

 
{</section>}
 
