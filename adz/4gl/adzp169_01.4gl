#+ 程式版本......: T6 Version 1.00.00 Build-0000 at 2014/10/20
#
#+ 程式代碼......: adzp169_01
#+ 設計人員......: tsai_yen
# Prog. Version..: 'T100-12.01.21(00000)'     #
#
# Program name   : adzp169_01.4gl
# Description    : 相對欄位開窗查詢
#+ Modifier......: No.FUN-141021 2014/10/21 tsai_yen 從qry拿過來修改
#+ Modifier......: No.FUN-150812 2015/08/12 tsai_yen 因為free style關係，目前已暫時停用dzfb_t的解析
#                                                    但...避免取到非輸入欄位,本程式暫時不修改,待dzfb_t恢復解析
#+ Modifier......: No.160401-00006#1 2016/04/01 tsai_yen 移除非ADZ/AZZ/ALO模組的欄位宣告

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#開窗畫面顯示欄位 type 宣告
PRIVATE TYPE type_gr_qry RECORD
         check   LIKE type_t.chr1,
         dzfi004_1      LIKE dzfi_t.dzfi004,
         dzfj005_2      LIKE dzfj_t.dzfj005,
         dzfj010        LIKE dzfj_t.dzfj010,    #FUN-141021
         dzfj005_name   LIKE gzzd_t.gzzd005,    #FUN-141021
         dzfi003_3      LIKE dzfi_t.dzfi003
       END RECORD

#@查詢資料的暫存器.
DEFINE gr_qry            DYNAMIC ARRAY OF type_gr_qry
DEFINE gr_qry_sel        DYNAMIC ARRAY OF type_gr_qry  #多選時記錄已勾選的資料

DEFINE gi_multi_sel      LIKE type_t.num5   #是否需要複選資料(TRUE/FALSE)
DEFINE gi_need_cons      LIKE type_t.num5   #是否需要CONSTRUCT(TRUE/FALSE)
DEFINE gi_cons_where     STRING                #暫存CONSTRUCT區塊的WHERE條件
DEFINE gi_cons_where_old STRING                #暫存CONSTRUCT區塊的WHERE條件(舊的,用來比對條件是否改變)

DEFINE gs_default1       STRING
DEFINE gs_default2       STRING

DEFINE gi_page_count     LIKE type_t.num10  #每頁顯現資料筆數
DEFINE gs_pageswitch     STRING                #選擇的頁面
DEFINE gs_action         STRING
DEFINE gi_reconstruct    LIKE type_t.num5   #重新查詢
DEFINE g_pagestart       LIKE type_t.num5
DEFINE g_data_cnt        LIKE type_t.num5
DEFINE g_page_idx        LIKE type_t.num5   #目前所在頁數
DEFINE g_page_last       LIKE type_t.num5   #最後一頁
DEFINE g_sel_limit       LIKE type_t.num5   #選擇筆數的上限
DEFINE gwin_curr         ui.Window
DEFINE gs_comment        STRING             #FUN-141021

PUBLIC FUNCTION adzp169_01()

   DEFINE pi_multi_sel   LIKE type_t.num5
   DEFINE pi_need_cons   LIKE type_t.num5
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING

   WHENEVER ERROR CALL cl_err_msg_log

   OPEN WINDOW w_qry WITH FORM cl_ap_formpath("adz","adzp169_01")   #adz模組 #FUN-141021
      ATTRIBUTE(STYLE="openwin")
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_openwin.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   IF g_qryparam.state = 'i' THEN
      LET gi_multi_sel = FALSE
   ELSE
      LET gi_multi_sel = TRUE
   END IF
   LET gi_need_cons = g_qryparam.reqry
   LET gs_default1 = g_qryparam.default1
   LET gs_default2 = g_qryparam.default2


   CALL adzp169_01_init()
   CALL adzp169_01_sel()

   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF

   CLOSE WINDOW w_qry

END FUNCTION

##################################################
# Description   : 初始化
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_init()
   DEFINE l_qry_text LIKE dzcal_t.dzcal003
   DEFINE l_qry_id   LIKE dzca_t.dzca001
   DEFINE l_text     STRING

   IF NOT (gi_multi_sel) THEN
      CALL cl_set_comp_visible("check", FALSE)
      CALL cl_set_toolbaritem_visible("selectall, selectnone, selectpageall, selectpagenone", FALSE)
   END IF

   IF (gi_multi_sel) THEN
      #lib尚未修正
      #CALL cl_set_comp_font_color("oea01", "red")
   END IF

   LET INT_FLAG = FALSE         #避免被其他函式影響
   LET g_page_idx = 0
   LET g_page_last = 0
   LET g_sel_limit = adzp169_01_get_sel_limit()     #選擇筆數的上限
   LET gi_page_count = adzp169_01_get_page_count()  #每頁顯現資料筆數
   LET gi_cons_where = " 1=1"   #預設查詢全部資料
   LET gi_cons_where_old = NULL
   LET gi_reconstruct = FALSE
   INITIALIZE gs_pageswitch TO NULL
   INITIALIZE gs_action TO NULL
   INITIALIZE g_qryparam.return1 TO NULL
   INITIALIZE g_qryparam.return2 TO NULL

   CALL gr_qry.clear()
   CALL gr_qry_sel.clear()

   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###

   #設定開窗識別碼的說明
   LET gwin_curr = ui.Window.forName("w_qry")
   #FUN-141021 mark
   #SELECT dzca001,dzcal003 INTO l_qry_id,l_qry_text FROM dzca_t
   #   LEFT JOIN dzcal_t ON dzcal001=dzca001 AND dzcal002=g_lang
   #   WHERE dzca001="adzp169_01"
   #LET l_text = l_qry_text,"(",l_qry_id,")"
   #CALL gwin_curr.setText(l_text)
   CALL cl_ui_init()   #FUN-141021

END FUNCTION

##################################################
# Description    : 取得每頁顯現資料筆數
# Date & Author  : {%格式為:xxxx/xx/xx by xxx}
# Parameter      : none
# Return         : void
# Date & Author..: 
# Modify.........: No.160401-00006#1 2016/04/01 by tsai_yen 移除非ADZ/AZZ/ALO模組的欄位宣告
##################################################
PRIVATE FUNCTION adzp169_01_get_page_count()
   DEFINE l_sel_limit  LIKE type_t.num5,
          l_default    LIKE type_t.num5

   LET l_default = 10 #設定預設值
   LET l_sel_limit = l_default

   RETURN l_default
END FUNCTION

##################################################
# Description    : 取得選擇筆數的上限
# Date & Author  : {%格式為:xxxx/xx/xx by xxx}
# Parameter      : none
# Return         : void
# Modify.........: No.160401-00006#1 2016/04/01 by tsai_yen 移除非ADZ/AZZ/ALO模組的欄位宣告
##################################################
PRIVATE FUNCTION adzp169_01_get_sel_limit()
   DEFINE l_sel_limit  LIKE type_t.num5,
          l_default    LIKE type_t.num5

   LET l_default = 200 #設定預設值
   LET l_sel_limit = l_default

   RETURN l_sel_limit
END FUNCTION

##################################################
# Description   : 畫面顯現與資料的選擇.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_sel()

   WHILE TRUE
      CALL adzp169_01_prep_result_set()

      IF (gi_multi_sel) THEN
         CALL adzp169_01_input_array()
      ELSE
         CALL adzp169_01_display_array()
      END IF

      IF gs_action = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

##################################################
# Description   : 準備查詢畫面的資料集.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_prep_result_set()

   CALL gr_qry.clear()
   CALL gr_qry_sel.clear()

   IF (gi_need_cons) OR (gi_reconstruct) THEN

      #避免使用預先查詢時,按重新整理的時候,進入CONSTRUCT段
      LET gi_need_cons = FALSE

      LET gi_reconstruct = FALSE
      LET gi_cons_where_old = NULL
      DISPLAY "" TO formonly.index
      CONSTRUCT gi_cons_where ON dzfi004, dzfj005, dzfi003
         FROM s_qry[1].dzfi004_1, s_qry[1].dzfj005_2, s_qry[1].dzfi003_3
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         LET gi_cons_where = " 1=1"
      END IF
   END IF

   IF cl_null(gs_pageswitch) THEN
      LET gs_pageswitch = "first"
   END IF
   CALL adzp169_01_pagedata_fill(gs_pageswitch)
   INITIALIZE gs_pageswitch TO NULL
END FUNCTION

##################################################
# Description   : 採用INPUT ARRAY的方式來顯現查詢過後的資料.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_input_array()

   DEFINE li_ac     LIKE type_t.num5
   DEFINE ldig_curr ui.Dialog
   DEFINE l_msg     STRING
   DEFINE l_chk     LIKE type_t.num5

   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###

   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY gr_qry FROM s_qry.*
         ATTRIBUTES(COUNT=g_data_cnt,
                    APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE)

         BEFORE INPUT
            CALL adzp169_01_set_pagebutton(ldig_curr)

         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_qry")

         ON CHANGE check   #改變勾選狀態
            CALL adzp169_01_qry_check("", gr_qry[li_ac].check, li_ac, li_ac)
      END INPUT

      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()

      ON ACTION accept
         CALL adzp169_01_get_multiret()
         LET gs_action = "exit"
         EXIT DIALOG

      ON ACTION cancel
         LET g_qryparam.return1 = NULL

         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION pg_first
         CALL adzp169_01_pagedata_fill("first")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION pg_prev
         CALL adzp169_01_pagedata_fill("prev")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION pg_next
         CALL adzp169_01_pagedata_fill("next")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION pg_last
         CALL adzp169_01_pagedata_fill("last")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      #重新整理
      ON ACTION refresh
         CALL adzp169_01_pagedata_fill("first")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         EXIT DIALOG

      #重新查詢
      ON ACTION reconstruct
         LET gi_reconstruct = TRUE
         CALL gr_qry.clear()
         CALL gr_qry_sel.clear()
         CALL adzp169_01_data_count("0")    #總筆數
         EXIT DIALOG

      #全部選取
      ON ACTION selectall
         # 連未選擇的頁面都必須選擇
         CALL adzp169_01_qry_check("selectall", "Y", 1, gr_qry.getLength())

      #全部取消選取
      ON ACTION selectnone
         CALL adzp169_01_qry_check("selectnone", "N", 1, gr_qry.getLength())

      #此頁全選
      ON ACTION selectpageall
         CALL adzp169_01_qry_check("selectpageall", "Y", 1, gr_qry.getLength())

      #此頁取消選取
      ON ACTION selectpagenone
         CALL adzp169_01_qry_check("selectpagenone", "N", 1, gr_qry.getLength())

      ON ACTION exporttoexcel
         MESSAGE ""

      #開窗程式串查沒有設定


   END DIALOG
END FUNCTION

##################################################
# Description   : 採用DISPLAY ARRAY的方式來顯現查詢過後的資料.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_display_array()

   DEFINE li_ac       LIKE type_t.num5
   DEFINE ldig_curr   ui.Dialog
   DEFINE l_msg       STRING
   DEFINE l_chk       LIKE type_t.num5

   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###

   DIALOG ATTRIBUTES(UNBUFFERED)
      DISPLAY ARRAY gr_qry TO s_qry.*
         ATTRIBUTES(COUNT=g_data_cnt)
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_qry")
      END DISPLAY

      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
         CALL adzp169_01_set_pagebutton(ldig_curr)

      ON ACTION accept
         IF li_ac > 0 THEN
            LET g_qryparam.return1 = gr_qry[li_ac].dzfj005_2
            LET g_qryparam.return2 = gr_qry[li_ac].dzfi003_3

         ELSE
            LET g_qryparam.return1 = gs_default1
            LET g_qryparam.return2 = gs_default2

         END IF
         LET gs_action = "exit"
         EXIT DIALOG

      ON ACTION CANCEL
            LET g_qryparam.return1 = gs_default1
            LET g_qryparam.return2 = gs_default2


         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION pg_first
         CALL adzp169_01_pagedata_fill("first")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION pg_prev
         CALL adzp169_01_pagedata_fill("prev")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION pg_next
         CALL adzp169_01_pagedata_fill("next")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION pg_last
         CALL adzp169_01_pagedata_fill("last")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT

      ON ACTION refresh       #重新整理
         CALL adzp169_01_pagedata_fill("first")
         CALL adzp169_01_set_pagebutton(ldig_curr)
         EXIT DIALOG

      ON ACTION reconstruct   #重新查詢
         LET gi_reconstruct = TRUE
         CALL gr_qry.clear()
         CALL adzp169_01_data_count("0")    #總筆數
         EXIT DIALOG

      ON ACTION exporttoexcel
         MESSAGE ""

      #開窗程式串查沒有設定


   END DIALOG
END FUNCTION

##################################################
# Description   : 準備查詢畫面的資料集.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : ps_page_action  STRING   上下頁
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_pagedata_fill(ps_page_action)

   DEFINE ps_page_action STRING
   DEFINE ls_sql         STRING
   DEFINE ls_where       STRING
   DEFINE li_i           LIKE type_t.num10
   DEFINE li_j           LIKE type_t.num10
   DEFINE l_datarange    STRING   #第m-n筆
   DEFINE l_str          STRING   #字串
   DEFINE l_str1         STRING
   DEFINE l_str2         STRING

   CASE ps_page_action
      WHEN "first"
         LET g_page_idx = 1
      WHEN "prev"
         LET g_page_idx = g_page_idx - 1
      WHEN "next"
         LET g_page_idx = g_page_idx + 1
      WHEN "last"
         LET g_page_idx = g_page_last
   END CASE

   IF g_page_idx > 0 THEN
      LET g_pagestart = (g_page_idx - 1) * gi_page_count + 1
   END IF

   CALL adzp169_01_sqlwhere() RETURNING ls_where
   #全部選取
   #FUN-141021
   LET ls_sql =
         "SELECT DISTINCT  'Y',  t1.dzfi004,t1.dzfj005,t1.dzfj010,'',t1.dzfi003",
         " FROM (",
         "    SELECT *",
         "    FROM dzfb_t,dzfj_t,dzfi_t",
         "    WHERE dzfb001 = dzfj001 AND dzfb002 = dzfj002 AND dzfb005 = dzfj005 AND dzfb007 = dzfj017",
         "    AND dzfj001 = dzfi001 AND dzfj002 = dzfi002 AND dzfj003 = dzfi006 AND dzfj017 = dzfi009",
         "    AND dzfb001 = '",g_qryparam.arg1 CLIPPED,"' AND dzfb002 = '",g_qryparam.arg2 CLIPPED,"' AND dzfb007 = '",g_qryparam.arg3 CLIPPED,"'",
         "    AND dzfjstus = 'Y' AND dzfistus = 'Y' AND dzfi008 = 'Y' AND dzfj012 = 'N'",
         "    AND dzfi004 NOT IN ('grid_state')",
         " ) t1",
         " LEFT JOIN dzfi_t fi",
         " ON fi.dzfi001 = t1.dzfi001",
         "    AND fi.dzfi002 = t1.dzfi002",
         "    AND fi.dzfi009 = t1.dzfi009",
         "    AND fi.dzfi006 = t1.dzfi004",
         " LEFT JOIN dzaa_t aa",
         " ON aa.dzaastus = t1.dzfistus",
         "    AND dzaa001 = t1.dzfi001",
         "    AND dzaa002 = t1.dzfi002",
         "    AND dzaa003 = 'TABLE'",
         "    AND dzaa009 = t1.dzfi009",
         " LEFT JOIN dzfs_t fs",
         " ON fs.dzfs001 = aa.dzaa004",
         "    AND fs.dzfs002 = aa.dzaa001",
         "    AND fs.dzfs003 = t1.dzfi004",
         "    AND fs.dzfs005 = aa.dzaa006",
         "    AND fs.dzfsstus = aa.dzaastus",
         #" --WHERE t1.dzfi004 = 's_detail4'",
         #" WHERE dzfs004 IS NULL",
         " WHERE 1=1 AND ", ls_where CLIPPED,
         " ORDER BY t1.dzfi003"
   DECLARE lcurs_qry_all CURSOR FROM ls_sql

   #此頁
   #@如果不需要複選資料,則不要設定check的預設值(將'N'刪除)
   #FUN-141021
   LET ls_sql =
   "SELECT 'N', dzfi004_1, dzfj005_2,dzfj010,'', dzfi003_3, RANK",
   " FROM ( SELECT dzfi004_1, dzfj005_2,dzfj010, dzfi003_3, RANK() OVER(ORDER BY dzfi004_1, dzfj005_2, dzfi003_3) AS RANK",
   "         FROM (SELECT DISTINCT  dzfi004 dzfi004_1, dzfj005 dzfj005_2,dzfj010, dzfi003 dzfi003_3",
   "                FROM  (",
                           "SELECT t1.dzfi004,t1.dzfj005,t1.dzfj010,t1.dzfi003",
                           " FROM (",
                           "    SELECT *",
                           "    FROM dzfb_t,dzfj_t,dzfi_t",
                           "    WHERE dzfb001 = dzfj001 AND dzfb002 = dzfj002 AND dzfb005 = dzfj005 AND dzfb007 = dzfj017",
                           "    AND dzfj001 = dzfi001 AND dzfj002 = dzfi002 AND dzfj003 = dzfi006 AND dzfj017 = dzfi009",
                           "    AND dzfb001 = '",g_qryparam.arg1 CLIPPED,"' AND dzfb002 = '",g_qryparam.arg2 CLIPPED,"' AND dzfb007 = '",g_qryparam.arg3 CLIPPED,"'",
                           "    AND dzfjstus = 'Y' AND dzfistus = 'Y' AND dzfi008 = 'Y' AND dzfj012 = 'N'",
                           "    AND dzfi004 NOT IN ('grid_state')",
                           " ) t1",
                           " LEFT JOIN dzfi_t fi",
                           " ON fi.dzfi001 = t1.dzfi001",
                           "    AND fi.dzfi002 = t1.dzfi002",
                           "    AND fi.dzfi009 = t1.dzfi009",
                           "    AND fi.dzfi006 = t1.dzfi004",
                           " LEFT JOIN dzaa_t aa",
                           " ON aa.dzaastus = t1.dzfistus",
                           "    AND dzaa001 = t1.dzfi001",
                           "    AND dzaa002 = t1.dzfi002",
                           "    AND dzaa003 = 'TABLE'",
                           "    AND dzaa009 = t1.dzfi009",
                           " LEFT JOIN dzfs_t fs",
                           " ON fs.dzfs001 = aa.dzaa004",
                           "    AND fs.dzfs002 = aa.dzaa001",
                           "    AND fs.dzfs003 = t1.dzfi004",
                           "    AND fs.dzfs005 = aa.dzaa006",
                           "    AND fs.dzfsstus = aa.dzaastus",
                           " WHERE 1=1 AND ", ls_where CLIPPED,
                           " ORDER BY t1.dzfi003",
                    ")",
   "          )",
   ")",
   " WHERE RANK >= ", g_pagestart," AND RANK < ", g_pagestart + gi_page_count

   LET ls_sql = ls_sql CLIPPED," ORDER BY dzfi003_3"   #FUN-141021
   #DISPLAY "%%%%%%%%%%%%%%%%%%%%%%"
   #DISPLAY "ls_sql = ",ls_sql

   DECLARE lcurs_qry CURSOR FROM ls_sql

   CALL gr_qry.clear()

   LET li_i = 1
   FOREACH lcurs_qry INTO gr_qry[li_i].*
      CALL s_azzi902_get_gzzd(g_qryparam.arg1,gr_qry[li_i].dzfj010) RETURNING gr_qry[li_i].dzfj005_name, gs_comment    #FUN-141021
      LET l_str1 = gr_qry[li_i].dzfi004_1, gr_qry[li_i].dzfj005_2, gr_qry[li_i].dzfi003_3
      FOR li_j = 1 TO gr_qry_sel.getLength()
         LET l_str2 = gr_qry_sel[li_j].dzfi004_1, gr_qry_sel[li_j].dzfj005_2, gr_qry_sel[li_j].dzfi003_3
         IF l_str1 = l_str2 THEN
            LET gr_qry[li_i].check = gr_qry_sel[li_j].check
         END IF
      END FOR
      LET li_i = li_i + 1
   END FOREACH
   CALL gr_qry.deleteElement(li_i)

   IF gi_cons_where <> gi_cons_where_old OR cl_null(gi_cons_where) OR cl_null(gi_cons_where_old) THEN   #查詢條件改變
      LET gi_cons_where_old = gi_cons_where
      #CALL adzp169_01_data_count("db")  #查詢資料的總筆數,給下一段計算第m-n筆
   END IF

   CALL adzp169_01_data_count("db") #查詢資料的總筆數,給下一段計算第m-n筆

   #第m-n筆
   IF g_page_idx > 0 THEN
      LET li_i = g_data_cnt MOD gi_page_count
      #現在在最後一頁，而且不是滿頁的狀況
      IF g_page_idx = g_page_last AND li_i > 0 THEN
         LET l_str = g_pagestart - 1 + li_i
      ELSE
         LET l_str = g_pagestart - 1 + gi_page_count
      END IF
      LET l_datarange = g_pagestart
      LET l_datarange = l_datarange CLIPPED, " - ", l_str
   ELSE
      LET l_datarange = ""
   END IF
   DISPLAY l_datarange TO formonly.index

END FUNCTION

##################################################
# Description   : 查詢資料的總筆數
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_data_count(p_data_cnt)

   DEFINE p_data_cnt  STRING     #總筆數計算方式 "db":資料庫中的資料/非"db"則以此值為總筆數
   DEFINE ls_sql      STRING
   DEFINE ls_where    STRING
   DEFINE ls_sql_1    STRING


   IF p_data_cnt = "db" THEN
      CALL adzp169_01_sqlwhere() RETURNING ls_where
      #FUN-141021
      LET ls_sql_1 = "SELECT DISTINCT  'Y',  t1.dzfi004,t1.dzfj005,t1.dzfj010,'',t1.dzfi003",
         " FROM (",
         "    SELECT *",
         "    FROM dzfb_t,dzfj_t,dzfi_t",
         "    WHERE dzfb001 = dzfj001 AND dzfb002 = dzfj002 AND dzfb005 = dzfj005 AND dzfb007 = dzfj017",
         "    AND dzfj001 = dzfi001 AND dzfj002 = dzfi002 AND dzfj003 = dzfi006 AND dzfj017 = dzfi009",
         "    AND dzfb001 = '",g_qryparam.arg1 CLIPPED,"' AND dzfb002 = '",g_qryparam.arg2 CLIPPED CLIPPED,"' AND dzfb007 = '",g_qryparam.arg3 CLIPPED,"'",
         "    AND dzfjstus = 'Y' AND dzfistus = 'Y' AND dzfi008 = 'Y' AND dzfj012 = 'N'",
         "    AND dzfi004 NOT IN ('grid_state')",
         " ) t1",
         " LEFT JOIN dzfi_t fi",
         " ON fi.dzfi001 = t1.dzfi001",
         "    AND fi.dzfi002 = t1.dzfi002",
         "    AND fi.dzfi009 = t1.dzfi009",
         "    AND fi.dzfi006 = t1.dzfi004",
         " LEFT JOIN dzaa_t aa",
         " ON aa.dzaastus = t1.dzfistus",
         "    AND dzaa001 = t1.dzfi001",
         "    AND dzaa002 = t1.dzfi002",
         "    AND dzaa003 = 'TABLE'",
         "    AND dzaa009 = t1.dzfi009",
         " LEFT JOIN dzfs_t fs",
         " ON fs.dzfs001 = aa.dzaa004",
         "    AND fs.dzfs002 = aa.dzaa001",
         "    AND fs.dzfs003 = t1.dzfi004",
         "    AND fs.dzfs005 = aa.dzaa006",
         "    AND fs.dzfsstus = aa.dzaastus",
         #" --WHERE t1.dzfi004 = 's_detail4'",
         #" WHERE dzfs004 IS NULL",
         " WHERE 1=1 AND ", ls_where CLIPPED,
         " ORDER BY t1.dzfi003"



      LET ls_sql = "SELECT COUNT(1) FROM (", ls_sql_1, ")"   #FUN-141021
      DISPLAY "########################################################################"
      DISPLAY "[sql for adzp169_01] = ",ls_sql_1
      DISPLAY "########################################################################"
      CALL adzp169_01_sql_verify(ls_sql_1)
      PREPARE qry_count FROM ls_sql
      EXECUTE qry_count INTO g_data_cnt
   ELSE
      LET g_data_cnt = p_data_cnt
   END IF

   IF g_data_cnt > 0 THEN
      IF g_data_cnt MOD gi_page_count = 0 THEN
         LET g_page_last = g_data_cnt / gi_page_count   #總筆數 / 每頁顯現資料筆數
      ELSE
         LET g_page_last = g_data_cnt / gi_page_count + 1
      END IF
   ELSE
      LET g_page_last = 0
   END IF

   #DISPLAY "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   #DISPLAY "ls_sql = ",ls_sql
   #DISPLAY "ls_sql_1 = ",ls_sql_1
   #DISPLAY "g_data_cnt = ",g_data_cnt
   #DISPLAY "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

   DISPLAY g_data_cnt TO formonly.count    #顯示總筆數
END FUNCTION

##################################################
# Description   : 進行SQL驗證
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_sql_verify(p_sql)
   DEFINE p_sql      STRING
   DEFINE l_sql      STRING
   DEFINE l_sql_msg  STRING

   TRY
      LET l_sql = "SELECT COUNT(1) FROM (",p_sql,")"

      #實際進行驗證
      EXECUTE IMMEDIATE l_sql


      MESSAGE 'Verify OK!'
   CATCH
      DISPLAY ":SQLCA.SQLCODE=",SQLCA.SQLCODE,SQLERRMESSAGE
      LET l_sql_msg = ":SQLCA.SQLCODE=",SQLCA.SQLCODE,ASCII 10," \ sql = ",l_sql,ASCII 10," \ SQLERRMESSAGE=",SQLERRMESSAGE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_sql_msg
      LET g_errparam.code   =  "adz-00024"
      LET g_errparam.popup  = TRUE
      CALL cl_err()


   END TRY
END FUNCTION

##################################################
# Description   : 組SQL的where條件
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_sqlwhere()

   DEFINE ls_where   STRING

   LET ls_where = gi_cons_where CLIPPED   #gi_cons_where 螢幕抓取的where 條件

   #在input段開窗的時候自動加入<inwc></inwc>之間的where條件 cch_20130605
   IF  g_qryparam.state = "i" THEN
      LET ls_where = ls_where," ",""
   END IF

   #entprise - Start -

   #entprise -  End  -
   IF NOT cl_null(g_qryparam.where) THEN
      LET ls_where = ls_where, " AND ", g_qryparam.where CLIPPED   # g_qryparam.where查詢資料的條件
   END IF
   RETURN ls_where
END FUNCTION

##################################################
# Description   : 設定上下頁按鈕狀態
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : pdig_curr   ui.Dialog   目的DIALOG
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_set_pagebutton(pdig_curr)

   DEFINE pdig_curr ui.Dialog

   CALL pdig_curr.setActionActive("pg_first", 0)
   CALL pdig_curr.setActionActive("pg_prev", 0)
   CALL pdig_curr.setActionActive("pg_next", 0)
   CALL pdig_curr.setActionActive("pg_last", 0)

   IF g_page_idx > 1 THEN
      CALL pdig_curr.setActionActive("pg_first", 1)
      CALL pdig_curr.setActionActive("pg_prev", 1)
   END IF

   IF g_page_idx < g_page_last THEN
      CALL pdig_curr.setActionActive("pg_next", 1)
      CALL pdig_curr.setActionActive("pg_last", 1)
   END IF

END FUNCTION

##################################################
# Description   : 組合多選資料
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_get_multiret()

   DEFINE li_i   LIKE type_t.num10

   IF g_qryparam.state = "c" THEN
      LET g_qryparam.return1 = ""
      FOR li_i = 1 TO gr_qry_sel.getLength()
         IF gr_qry_sel[li_i].check = "Y" THEN
            #@因為複選資料(display array)只能回傳一個欄位的組合字串.這裡不處理多欄位的回傳,以序號最小的回傳欄位為回傳值
            IF cl_null(g_qryparam.return1) THEN
               LET g_qryparam.return1 = gr_qry_sel[li_i].dzfj005_2

            ELSE
               LET g_qryparam.return1 = g_qryparam.return1 , "|", gr_qry_sel[li_i].dzfj005_2

            END IF
         END IF
      END FOR
   END IF

   IF g_qryparam.state = "m" THEN
      CALL g_qryparam.str_array.clear()

      FOR li_i = 1 TO gr_qry_sel.getLength()
         #DISPLAY "gr_qry_sel[",li_i,"] = ",gr_qry_sel[li_i].*

         LET g_qryparam.str_array[li_i] = gr_qry_sel[li_i].dzfj005_2,'|',
gr_qry_sel[li_i].dzfi003_3
         #DISPLAY "g_qryparam.str_array[",li_i,"] = ",g_qryparam.str_array[li_i]
      END FOR
   END IF

END FUNCTION

##################################################
# Description   : 記錄已勾選的資料
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_qry_check(p_mode, p_check, p_start, p_end)

   DEFINE p_mode   STRING                 #選取方式
   DEFINE p_check  LIKE type_t.chr1    #選取狀態 Y/N
   DEFINE p_start  LIKE type_t.num10   #此頁選取範圍第一筆
   DEFINE p_end    LIKE type_t.num10   #此頁選取範圍最後一筆
   DEFINE li_i     LIKE type_t.num10
   DEFINE li_j     LIKE type_t.num10
   DEFINE l_check  LIKE type_t.chr1
   DEFINE l_str1   STRING
   DEFINE l_str2   STRING

   CASE
      #全部選取
      WHEN p_mode = "selectall"
         IF g_data_cnt > g_sel_limit THEN   #選取資料筆數超出系統容許上限
            #qry-005:選取資料筆數超出系統容許上限%1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_sel_limit
            LET g_errparam.code   =  "9035"
            LET g_errparam.popup  = TRUE
            CALL cl_err()

         ELSE
            FOR li_i = p_start TO p_end
               LET gr_qry[li_i].check = "Y"
            END FOR

            CALL gr_qry_sel.clear()
            LET li_i = 1
            FOREACH lcurs_qry_all INTO gr_qry_sel[li_i].*
               CALL s_azzi902_get_gzzd(g_qryparam.arg1,gr_qry_sel[li_i].dzfj010) RETURNING gr_qry_sel[li_i].dzfj005_name, gs_comment    #FUN-141021
               LET li_i = li_i + 1
            END FOREACH
            CALL gr_qry_sel.deleteElement(li_i)
         END IF
      #全部取消選取
      WHEN p_mode = "selectnone"
         CALL gr_qry_sel.clear()
         FOR li_i = p_start TO p_end
            LET gr_qry[li_i].check = "N"
         END FOR
      #改變單筆資料的選取狀態/此頁全選/此頁取消選取
      WHEN p_end > 0 AND (cl_null(p_mode) OR p_mode = "selectpageall" OR p_mode = "selectpagenone")
         FOR li_i = p_start TO p_end
         	  #將所有欄位值串在一起,以利做開窗record唯一值判斷
            #要和已被選取的陣列(gr_qry_sel)做唯一值判斷比較
         	  LET l_str1 = gr_qry[li_i].dzfi004_1, gr_qry[li_i].dzfj005_2, gr_qry[li_i].dzfi003_3

            IF p_check = "Y" THEN
               IF gr_qry_sel.getLength() >= g_sel_limit THEN   #選取資料筆數超出系統容許上限
                  LET gr_qry[li_i].check = "N"
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_sel_limit
                  LET g_errparam.code   =  "9035"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  EXIT FOR
               ELSE
                  LET l_check = "Y"
                  LET gr_qry[li_i].check = "Y"             #此頁全選時,用程式批次改變值
                  FOR li_j = 1 TO gr_qry_sel.getLength()   #勾選清單中有此筆資料
                     LET l_str2 = gr_qry_sel[li_j].dzfi004_1, gr_qry_sel[li_j].dzfj005_2, gr_qry_sel[li_j].dzfi003_3
                     IF l_str1 = l_str2 THEN
                        LET l_check = ""
                        EXIT FOR
                     END IF
                  END FOR
                  IF l_check = "Y" THEN  #加入勾選清單
                     LET li_j = gr_qry_sel.getLength() + 1
                     LET gr_qry_sel[li_j].* = gr_qry[li_i].*
                  END IF
               END IF
            ELSE
               LET gr_qry[li_i].check = "N"             #此頁取消選取時,用程式批次改變值
               FOR li_j = 1 TO gr_qry_sel.getLength()   #刪除勾選清單中的此筆資料
                  LET l_str2 = gr_qry_sel[li_j].dzfi004_1, gr_qry_sel[li_j].dzfj005_2, gr_qry_sel[li_j].dzfi003_3
                  IF l_str1 = l_str2 THEN
                      CALL gr_qry_sel.deleteElement(li_j)
                     EXIT FOR
                  END IF
               END FOR
            END IF
         END FOR
   END CASE
END FUNCTION

##################################################
# Description   : 設定comboBox
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_setting_comboBox(p_col_str)
   DEFINE p_col_str           STRING,
          l_i                 LIKE type_t.num5,
          l_dzep011           LIKE dzep_t.dzep010, #系統分類碼
          l_dzeb001           LIKE dzeb_t.dzeb001, #表格代號
          l_gzcc003           LIKE gzcc_t.gzcc003, #系統分類碼
          l_gzcc004_str       STRING,              #系統分類值的字串
          l_token             base.StringTokenizer,
          l_token_str         LIKE dzeb_t.dzeb002,
          l_str               STRING,
          l_parameter1        STRING,
          l_parameter2        STRING,
          l_parameter3        STRING,
          l_col_id            LIKE dzeb_t.dzeb002

   #優先處理 token
   LET l_token = base.StringTokenizer.create(p_col_str,"|")

   WHILE l_token.hasMoreTokens()

      LET l_token_str =l_token.nextToken()

      LET l_str = l_token_str
      #LET l_str = l_str.subString(1,l_str.getLength()-2)
      LET l_str = l_str.subString(1,l_str.getIndexOf("_",1)-1)
      LET l_col_id = l_str.trim()
      #DISPLAY "l_col_id = ",l_col_id


      #找出欄位的所屬表格代號
      SELECT dzeb001 INTO l_dzeb001 FROM dzeb_t WHERE dzeb002 = l_col_id

      IF l_col_id MATCHES "*stus" THEN
         #找出該表格的狀態碼欄位和系統分類碼
         SELECT DISTINCT gzcc003 INTO l_gzcc003 FROM gzcc_t WHERE gzcc001 = l_dzeb001
         #組合出表格有效的系統分類值的字串
         LET l_gzcc004_str = adzp169_01_setting_system_type_value_for_table(l_dzeb001)

         #DISPLAY "###########",l_token_str
         LET l_parameter1 = "formonly.",l_token_str
         LET l_parameter2 = l_gzcc003
         LET l_parameter3 = l_gzcc004_str

         #DISPLAY l_parameter1
         #DISPLAY l_parameter2
         #DISPLAY l_parameter3

         #組合 動態設定有選擇SCC資料的ComboBox選項 的程式碼,列出部分的系統分類值
         CALL cl_set_combo_scc_part(l_parameter1,l_parameter2,l_parameter3)
      ELSE
         #找出該欄位的系統分類碼
         SELECT dzep011 INTO l_dzep011 FROM dzep_t WHERE dzep002 = l_col_id

         #DISPLAY "###########",l_token_str
         LET l_parameter1 = "formonly.",l_token_str
         LET l_parameter2 = l_dzep011

         #DISPLAY l_parameter1
         #DISPLAY l_parameter2

         #組合 動態設定有選擇SCC資料的ComboBox選項 的程式碼,列出全部的系統分類值
         CALL cl_set_combo_scc(l_parameter1,l_parameter2)
      END IF

   END WHILE

END FUNCTION

##################################################
# Description   : 組合出表格有效的系統分類值的字串
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp169_01_setting_system_type_value_for_table(p_table)
   DEFINE p_table     LIKE  gzcc_t.gzcc001,
          l_gzcc_d    DYNAMIC ARRAY OF  RECORD
            gzcc004     LIKE dzeb_t.dzeb001
                      END  RECORD,
          l_cnt       LIKE type_t.num5,
          ls_sql      STRING,
          r_str       STRING

   LET ls_sql = "SELECT gzcc004 FROM gzcc_t ",
               "WHERE gzcc001='",p_table,"' AND gzccstus='Y' ",
               "ORDER BY gzcc006 "

   LET r_str = ""

   PREPARE gzcc_prep FROM ls_sql
   DECLARE gzcc_curs CURSOR FOR gzcc_prep
   LET l_cnt = 1
   FOREACH gzcc_curs INTO l_gzcc_d[l_cnt].gzcc004
      LET r_str = r_str,l_gzcc_d[l_cnt].gzcc004,","

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL l_gzcc_d.deleteElement(l_cnt)

   #去掉最後面的逗號
   LET r_str = r_str.subString(1,r_str.getLength()-1)

   RETURN r_str
END FUNCTION
