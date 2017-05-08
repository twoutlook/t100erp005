#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 06/27/2013
#
#+ 程式代碼......: adzi150_gzca
#+ 設計人員......: chiang.cheng.han
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzi150_gzca.4gl
# Description    : 系統分類碼查詢
 
IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#開窗畫面顯示欄位 type 宣告
PRIVATE TYPE type_gr_qry RECORD
         check   LIKE type_t.chr1,
                  gzca001   LIKE gzca_t.gzca001, 
         gzcal003   LIKE gzcal_t.gzcal003
       END RECORD
 
#@查詢資料的暫存器.
DEFINE gr_qry            DYNAMIC ARRAY OF type_gr_qry  
DEFINE gr_qry_sel        DYNAMIC ARRAY OF type_gr_qry  #多選時記錄已勾選的資料

DEFINE g_gzcb_t          DYNAMIC ARRAY OF RECORD
   gzcb002  LIKE gzcb_t.gzcb002,
   gzcbl004 LIKE gzcbl_t.gzcbl004
END RECORD
 
DEFINE gi_multi_sel      LIKE type_t.num5   #是否需要複選資料(TRUE/FALSE)
DEFINE gi_need_cons      LIKE type_t.num5   #是否需要CONSTRUCT(TRUE/FALSE)
DEFINE gi_cons_where     STRING                #暫存CONSTRUCT區塊的WHERE條件
DEFINE gi_cons_where_old STRING                #暫存CONSTRUCT區塊的WHERE條件(舊的,用來比對條件是否改變)
 
DEFINE gs_default1       STRING 

DEFINE gi_page_count     LIKE type_t.num10  #每頁顯現資料筆數
DEFINE gs_pageswitch     STRING                #選擇的頁面
DEFINE gs_action         STRING
DEFINE gi_reconstruct    LIKE type_t.num5   #重新查詢
DEFINE g_pagestart       LIKE type_t.num5
DEFINE g_data_cnt        LIKE type_t.num5
DEFINE g_page_idx        LIKE type_t.num5   #目前所在頁數
DEFINE g_page_last       LIKE type_t.num5   #最後一頁
DEFINE g_sel_limit       LIKE type_t.num5   #選擇筆數的上限
 
PUBLIC FUNCTION adzi150_gzca()
 
   DEFINE pi_multi_sel   LIKE type_t.num5
   DEFINE pi_need_cons   LIKE type_t.num5
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING
   DEFINE ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
 
   #WHENEVER ERROR CALL cl_err_msg_log #20150422 by Hiko

   #CALL cl_tool_init() #20150422 by Hiko
 
   #目前因為cl_ap_formpath() lib尚未調整
   #所以open window路徑先寫死,未來應該要call cl_ap_formpath()
   OPEN WINDOW w_adzi150_gzca WITH FORM cl_ap_formpath("adz","adzi150_gzca")

   #Begin:20150422 by Hiko
   #  ATTRIBUTE(STYLE="openwin")

   CURRENT WINDOW IS w_adzi150_gzca

   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   #LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   #LET ls_path = os.Path.join(ls_path,"toolbar_adzi150_gzca.4tb")
   #CALL lfrm_curr.loadToolBar(ls_path)

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lwin_curr.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   #End:20150422 by Hiko

   IF g_qryparam.state = 'i' THEN
      LET gi_multi_sel = FALSE
   ELSE
      LET gi_multi_sel = TRUE
   END IF 
   LET gi_need_cons = g_qryparam.reqry
   LET gs_default1 = g_qryparam.default1 

 
   CALL adzi150_gzca_init()
   CALL adzi150_gzca_sel()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF 
 
   CLOSE WINDOW w_adzi150_gzca
 
END FUNCTION
 
##################################################
# Description   : 初始化
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_init()
 
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
   LET g_sel_limit = 200        #選擇筆數的上限
   LET gi_page_count = 10       #每頁顯現資料筆數
   LET gi_cons_where = " 1=1"   #預設查詢全部資料
   LET gi_cons_where_old = NULL
   LET gi_reconstruct = FALSE
   INITIALIZE gs_pageswitch TO NULL
   INITIALIZE gs_action TO NULL
   INITIALIZE g_qryparam.return1 TO NULL  

   CALL gr_qry.clear()
   CALL gr_qry_sel.clear()
END FUNCTION
 
##################################################
# Description   : 畫面顯現與資料的選擇.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_sel()
 
   WHILE TRUE
      CALL adzi150_gzca_prep_result_set()
 
      IF (gi_multi_sel) THEN
         CALL adzi150_gzca_input_array()
      ELSE
         CALL adzi150_gzca_display_array()
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
PRIVATE FUNCTION adzi150_gzca_prep_result_set()
 
   CALL gr_qry.clear()
   CALL gr_qry_sel.clear()
 
   IF (gi_need_cons) OR (gi_reconstruct) THEN
      LET gi_reconstruct = FALSE
      LET gi_cons_where_old = NULL
      DISPLAY "" TO formonly.index
      CONSTRUCT gi_cons_where ON gzca001, gzcal003 
         FROM s_qry[1].gzca001, s_qry[1].gzcal003 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         LET gi_cons_where = " 1=1"
      END IF
   END IF
 
   IF cl_null(gs_pageswitch) THEN
      LET gs_pageswitch = "first"
   END IF
   CALL adzi150_gzca_pagedata_fill(gs_pageswitch)
   INITIALIZE gs_pageswitch TO NULL
END FUNCTION

FUNCTION adzi150_gzca_fill_g_gzcb(p_gzcb001)

  DEFINE p_gzcb001   LIKE gzcb_t.gzcb001,  
         ls_gzcb001 LIKE gzcb_t.gzcb001,
         ls_sql         STRING,
         li_count       LIKE type_t.num5

         
   LET ls_gzcb001 = p_gzcb001
  
   LET ls_sql = "SELECT gzcb002,gzcbl004 ",
                " FROM gzcb_t LIFT JOIN gzcbl_t     ", 
                " ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003='",g_lang,"'",
                " WHERE gzcb001 = '",p_gzcb001,"'"
                
   #DISPLAY "ls_sql = ",ls_sql

   PREPARE lpre_gzcc_no_valid FROM ls_sql
   DECLARE lcur_gzcc_no_valid CURSOR FOR lpre_gzcc_no_valid

   CALL g_gzcb_t.clear()
  
   LET li_count = 1
  
   #DISPLAY ls_gzcb001
   FOREACH lcur_gzcc_no_valid INTO g_gzcb_t[li_count].* 
      
      IF SQLCA.sqlcode THEN
         EXIT FOREACH
      END IF
     
      LET li_count = li_count + 1
   END FOREACH
   CALL g_gzcb_t.deleteElement(li_count)

END FUNCTION
 
##################################################
# Description   : 採用INPUT ARRAY的方式來顯現查詢過後的資料.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_input_array()
 
   DEFINE li_ac     LIKE type_t.num5
   DEFINE ldig_curr ui.Dialog
 
   DIALOG ATTRIBUTES(UNBUFFERED)
      #DISPLAY ARRAY g_gzcb_t TO s_gzcb_t.*
         #
      #END DISPLAY
   
      INPUT ARRAY gr_qry FROM s_qry.*
         ATTRIBUTES(COUNT=g_data_cnt, 
                    APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE) 
         
         BEFORE INPUT
            CALL adzi150_gzca_set_pagebutton(ldig_curr) 
            
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_qry") 
            #CALL adzi150_gzca_fill_g_gzcb(gr_qry[li_ac].gzca001)
            
         ON CHANGE check   #改變勾選狀態
            CALL adzi150_gzca_qry_check("", gr_qry[li_ac].check, li_ac, li_ac)
      END INPUT
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
 
      ON ACTION accept
         CALL adzi150_gzca_get_multiret()
         LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION cancel
         LET g_qryparam.return1 = NULL
         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION pg_first
         CALL adzi150_gzca_pagedata_fill("first")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_prev
         CALL adzi150_gzca_pagedata_fill("prev")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_next
         CALL adzi150_gzca_pagedata_fill("next")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_last
         CALL adzi150_gzca_pagedata_fill("last")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      #重新整理
      ON ACTION refresh
         CALL adzi150_gzca_pagedata_fill("first")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         EXIT DIALOG
         
      #重新查詢
      ON ACTION reconstruct
         LET gi_reconstruct = TRUE
         CALL gr_qry.clear()
         CALL gr_qry_sel.clear()
         CALL adzi150_gzca_data_count("0")    #總筆數
         EXIT DIALOG
         
      #全部選取
      ON ACTION selectall
         # 連未選擇的頁面都必須選擇
         CALL adzi150_gzca_qry_check("selectall", "Y", 1, gr_qry.getLength()) 
         
      #全部取消選取
      ON ACTION selectnone
         CALL adzi150_gzca_qry_check("selectnone", "N", 1, gr_qry.getLength()) 
         
      #此頁全選
      ON ACTION selectpageall
         CALL adzi150_gzca_qry_check("selectpageall", "Y", 1, gr_qry.getLength()) 
         
      #此頁取消選取
      ON ACTION selectpagenone
         CALL adzi150_gzca_qry_check("selectpagenone", "N", 1, gr_qry.getLength()) 
         
      ON ACTION exporttoexcel
         MESSAGE ""
         
   END DIALOG
END FUNCTION
 
##################################################
# Description   : 採用DISPLAY ARRAY的方式來顯現查詢過後的資料.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_display_array()
 
   DEFINE li_ac       LIKE type_t.num5
   DEFINE ldig_curr   ui.Dialog
 
   DIALOG ATTRIBUTES(UNBUFFERED)

      DISPLAY ARRAY g_gzcb_t TO s_gzcb_t.*
         
      END DISPLAY
   
      DISPLAY ARRAY gr_qry TO s_qry.*
         ATTRIBUTES(COUNT=g_data_cnt)
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_qry")
            CALL adzi150_gzca_fill_g_gzcb(gr_qry[li_ac].gzca001)
            #DISPLAY "gr_qry[li_ac].gzca001 = ",gr_qry[li_ac].gzca001
      END DISPLAY
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
 
      ON ACTION accept
         IF li_ac > 0 THEN
            LET g_qryparam.return1 = gr_qry[li_ac].gzca001 CLIPPED 
          
         ELSE
            LET g_qryparam.return1 = gs_default1 

         END IF
         LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION cancel
            LET g_qryparam.return1 = gs_default1 

         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION pg_first
         CALL adzi150_gzca_pagedata_fill("first")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_prev
         CALL adzi150_gzca_pagedata_fill("prev")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_next
         CALL adzi150_gzca_pagedata_fill("next")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_last
         CALL adzi150_gzca_pagedata_fill("last")
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION refresh       #重新整理
         CALL adzi150_gzca_pagedata_fill("first") 
         CALL adzi150_gzca_set_pagebutton(ldig_curr)
         EXIT DIALOG
         
      ON ACTION reconstruct   #重新查詢 
         LET gi_reconstruct = TRUE
         CALL gr_qry.clear()
         CALL adzi150_gzca_data_count("0")    #總筆數
         EXIT DIALOG
         
      ON ACTION exporttoexcel
         MESSAGE ""
         
   END DIALOG
END FUNCTION
 
##################################################
# Description   : 準備查詢畫面的資料集.
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : ps_page_action  STRING   上下頁
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_pagedata_fill(ps_page_action)
 
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
 
   CALL adzi150_gzca_sqlwhere() RETURNING ls_where
   #全部選取
   LET ls_sql = 
   "SELECT DISTINCT  'Y',  gzca001,gzcal003 
  FROM  gzca_t LEFT OUTER JOIN gzcal_t ON gzcal001 = gzca001 AND gzcal002 = '",g_dlang,"' 
  AND gzcastus = 'Y'  
  WHERE   1=1  AND ", ls_where CLIPPED, "
  ORDER BY gzca001"
   DECLARE lcurs_qry_all CURSOR FROM ls_sql
 
   #此頁
   #@如果不需要複選資料,則不要設定check的預設值(將'N'刪除)
   LET ls_sql = 
   "SELECT 'N', gzca001, gzcal003, RANK 
  FROM ( SELECT gzca001, gzcal003, RANK() OVER(ORDER BY gzca001, gzcal003) AS RANK  FROM (SELECT DISTINCT  gzca001,gzcal003 
  FROM  gzca_t LEFT OUTER JOIN gzcal_t ON gzcal001 = gzca001 AND gzcal002 = '",g_dlang,"' 
  AND gzcastus = 'Y'  
  WHERE   1=1  AND ", ls_where CLIPPED, "
  ORDER BY gzca001))",
   " WHERE RANK >= ", g_pagestart," AND RANK < ", g_pagestart + gi_page_count
   DECLARE lcurs_qry CURSOR FROM ls_sql
 
   CALL gr_qry.clear()
 
   LET li_i = 1
   FOREACH lcurs_qry INTO gr_qry[li_i].*
      LET l_str1 = gr_qry[li_i].gzca001, gr_qry[li_i].gzcal003
      FOR li_j = 1 TO gr_qry_sel.getLength()
         LET l_str2 = gr_qry_sel[li_j].gzca001, gr_qry_sel[li_j].gzcal003
         IF l_str1 = l_str2 THEN
            LET gr_qry[li_i].check = gr_qry_sel[li_j].check
         END IF
      END FOR
      LET li_i = li_i + 1
   END FOREACH
   CALL gr_qry.deleteElement(li_i)
 
   IF gi_cons_where <> gi_cons_where_old OR cl_null(gi_cons_where) OR cl_null(gi_cons_where_old) THEN   #查詢條件改變
      LET gi_cons_where_old = gi_cons_where
      CALL adzi150_gzca_data_count("db")   #查詢資料的總筆數,給下一段計算第m-n筆
   END IF
 
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
PRIVATE FUNCTION adzi150_gzca_data_count(p_data_cnt)
 
   DEFINE p_data_cnt STRING     #總筆數計算方式 "db":資料庫中的資料/非"db"則以此值為總筆數
   DEFINE ls_sql     STRING
   DEFINE ls_where   STRING
 
   IF p_data_cnt = "db" THEN
      CALL adzi150_gzca_sqlwhere() RETURNING ls_where
      LET ls_sql = "SELECT COUNT(*) FROM (", "SELECT DISTINCT  'Y',  gzca001,gzcal003 
  FROM  gzca_t LEFT OUTER JOIN gzcal_t ON gzcal001 = gzca001 AND gzcal002 = '",g_dlang,"' 
  AND gzcastus = 'Y'  
  WHERE   1=1  AND ", ls_where CLIPPED, "
  ORDER BY gzca001", ")"

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
 
   DISPLAY g_data_cnt TO formonly.count    #顯示總筆數
END FUNCTION
 
##################################################
# Description   : 組SQL的where條件
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_sqlwhere()
 
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
PRIVATE FUNCTION adzi150_gzca_set_pagebutton(pdig_curr)
 
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
PRIVATE FUNCTION adzi150_gzca_get_multiret()
 
   DEFINE li_i   LIKE type_t.num10
 
   LET g_qryparam.return1 = ""
   FOR li_i = 1 TO gr_qry_sel.getLength()
      IF gr_qry_sel[li_i].check = "Y" THEN
         #@因為複選資料(display array)只能回傳一個欄位的組合字串.這裡不處理多欄位的回傳,以序號最小的回傳欄位為回傳值
         IF cl_null(g_qryparam.return1) THEN
            LET g_qryparam.return1 = gr_qry_sel[li_i].gzca001 CLIPPED 

         ELSE
            LET g_qryparam.return1 = g_qryparam.return1 CLIPPED, "|", gr_qry_sel[li_i].gzca001 CLIPPED 

         END IF
      END IF
   END FOR
 
END FUNCTION
 
##################################################
# Description   : 記錄已勾選的資料
# Date & Author : {%格式為:xxxx/xx/xx by xxx}
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzi150_gzca_qry_check(p_mode, p_check, p_start, p_end)
 
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
            LET g_errparam.code =  "qry-005"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            FOR li_i = p_start TO p_end
               LET gr_qry[li_i].check = "Y"
            END FOR
 
            CALL gr_qry_sel.clear()
            LET li_i = 1
            FOREACH lcurs_qry_all INTO gr_qry_sel[li_i].*
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
         	  LET l_str1 = gr_qry[li_i].gzca001, gr_qry[li_i].gzcal003
         	  
            IF p_check = "Y" THEN
               IF gr_qry_sel.getLength() >= g_sel_limit THEN   #選取資料筆數超出系統容許上限
                  LET gr_qry[li_i].check = "N"
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "qry-005"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT FOR
               ELSE
                  LET l_check = "Y"
                  LET gr_qry[li_i].check = "Y"             #此頁全選時,用程式批次改變值
                  FOR li_j = 1 TO gr_qry_sel.getLength()   #勾選清單中有此筆資料
                     LET l_str2 = gr_qry_sel[li_j].gzca001, gr_qry_sel[li_j].gzcal003
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
                  LET l_str2 = gr_qry_sel[li_j].gzca001, gr_qry_sel[li_j].gzcal003
                  IF l_str1 = l_str2 THEN
                      CALL gr_qry_sel.deleteElement(li_j)
                     EXIT FOR
                  END IF
               END FOR
            END IF
         END FOR
   END CASE
END FUNCTION




